/* Edge Vision YOLO — integer-optimized */

#include <stdint.h>
#include "riscv.h"
#include "soc.h"
#include "bsp.h"
#include "plic.h"
#include "clint.h"

#include "tinyml.h"
#include "ops/ops_api.h"

#include "tensorflow/lite/micro/micro_error_reporter.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/micro/all_ops_resolver.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/c/common.h"

#include "model/best_int8_fixed_model_data.h"

#define CAM_BUF  0x00001000
#define CAM_W    1280
#define CAM_H    720
#define STRIDE   8
#define SUB_W    (CAM_W/STRIDE)
#define SUB_H    (CAM_H/STRIDE)

#define CONF_THR  0.7f
#define IOU_THR   0.5f
#define MAX_DET   200

alignas(16) static uint8_t  sub[SUB_W*SUB_H*3];
alignas(16) static int       boxes_i[MAX_DET*4];  // x1,y1,x2,y2 scaled by 256
alignas(16) static uint16_t scores_i[MAX_DET];   // conf scaled by 256
alignas(16) static int      order[MAX_DET], supp[MAX_DET], keep[MAX_DET];

namespace { alignas(16) uint8_t arena[10000*1024];
    tflite::MicroInterpreter *ip; TfLiteTensor *mi; }

static void flush_dcache(void){ asm volatile(".word(0x500F)"); }
static void subsample(const volatile uint32_t *s,uint8_t *d){
    for(int y=0;y<SUB_H;y++){int sy=y*STRIDE;
        for(int x=0;x<SUB_W;x++){int sx=x*STRIDE;
            uint32_t p=s[sy*CAM_W+sx];int o=(y*SUB_W+x)*3;
            d[o+0]=(uint8_t)(p>>16);d[o+1]=(uint8_t)(p>>8);d[o+2]=(uint8_t)p;
}}}

extern "C" void main(){

    plic_set_threshold(BSP_PLIC,BSP_PLIC_CPU_0,0);
    plic_set_enable(BSP_PLIC,BSP_PLIC_CPU_0,SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT,1);
    plic_set_priority(BSP_PLIC,SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT,1);
    extern void trap_entry();csr_write(mtvec,trap_entry);
    csr_set(mie,MIE_MEIE);csr_write(mstatus,MSTATUS_MPP|MSTATUS_MIE);

    static tflite::MicroErrorReporter err;
    auto *m=tflite::GetModel(best_int8_fixed_model_data);
    static tflite::AllOpsResolver res;
    static tflite::MicroInterpreter interp(m,res,arena,sizeof(arena),&err,nullptr);
    ip=&interp;
    if(ip->AllocateTensors()!=kTfLiteOk){bsp_printf("A fail\r\n");while(1);}
    mi=ip->input(0);int nw=mi->dims->data[2],nh=mi->dims->data[1];

    // Read output quantization params (used once for dequant)
    TfLiteTensor *o_check=ip->output(0);
    auto *oq=(TfLiteAffineQuantization*)o_check->quantization.params;
    int o_zp=oq->zero_point->data[0];
    float o_sc=oq->scale->data[0];
    int conf_thr_i = (int)((CONF_THR/o_sc)+o_zp);  // int8 threshold for confidence

    uint32_t fc=0;
    while(1){
        flush_dcache();
        subsample((const volatile uint32_t*)CAM_BUF,sub);

        // INT8 input: pixel - 128
        for(int y=0;y<nh;y++){int sy=(y<SUB_H)?y:SUB_H-1;
            for(int x=0;x<nw;x++){int sx=(x<SUB_W)?x:SUB_W-1;
                uint8_t *p=&sub[(sy*SUB_W+sx)*3];int idx=(y*nw+x)*3;
                mi->data.int8[idx+0]=(int8_t)(p[0]-128);
                mi->data.int8[idx+1]=(int8_t)(p[1]-128);
                mi->data.int8[idx+2]=(int8_t)(p[2]-128);
        }}

        uint64_t t0=clint_getTime(BSP_CLINT);
        if(ip->Invoke()!=kTfLiteOk){bsp_printf("E\r\n");continue;}
        uint64_t t1=clint_getTime(BSP_CLINT);

        TfLiteTensor *o=ip->output(0); int tot=o->dims->data[1];
        int nd=0;
        for(int i=0;i<tot&&nd<MAX_DET;i++){
            int8_t *r=o->data.int8+i*6;
            int c=r[4]; if(c<conf_thr_i)continue; // int8 confidence check
            // Dequantize only survivors
            float xc=((float)r[0]-o_zp)*o_sc*256.0f;
            float yc=((float)r[1]-o_zp)*o_sc*256.0f;
            float bw=((float)r[2]-o_zp)*o_sc*256.0f;
            float bh=((float)r[3]-o_zp)*o_sc*256.0f;
            int x1=(int)((xc-bw/2)*nw), y1=(int)((yc-bh/2)*nh);
            int x2=(int)((xc+bw/2)*nw), y2=(int)((yc+bh/2)*nh);
            boxes_i[nd*4+0]=x1; boxes_i[nd*4+1]=y1;
            boxes_i[nd*4+2]=x2; boxes_i[nd*4+3]=y2;
            scores_i[nd]=(uint16_t)(c); nd++;
        }

        // NMS with integer math
        for(int i=0;i<nd;i++){order[i]=i;supp[i]=0;}
        for(int i=0;i<nd-1;i++) // bubble sort by score
            for(int j=i+1;j<nd;j++)
                if(scores_i[order[j]]>scores_i[order[i]])
                    {int t=order[i];order[i]=order[j];order[j]=t;}

        int nk=0;
        for(int i=0;i<nd;i++){
            if(supp[i])continue;
            keep[nk++]=order[i];
            int *a=boxes_i+order[i]*4;
            for(int j=i+1;j<nd;j++){
                if(supp[j])continue;
                int *b=boxes_i+order[j]*4;
                int ix1=a[0]>b[0]?a[0]:b[0], iy1=a[1]>b[1]?a[1]:b[1];
                int ix2=a[2]<b[2]?a[2]:b[2], iy2=a[3]<b[3]?a[3]:b[3];
                int iw=ix2-ix1, ih=iy2-iy1; if(iw<=0||ih<=0)continue;
                int inter=iw*ih;
                int area_a=(a[2]-a[0])*(a[3]-a[1]);
                int area_b=(b[2]-b[0])*(b[3]-b[1]);
                if(inter*100 > (area_a+area_b-inter)*(int)(IOU_THR*100)) supp[j]=1;
            }
        }

        for(int i=0;i<nk&&i<10;i++){
            int *d=boxes_i+keep[i]*4;
            int x1=d[0],y1=d[1],x2=d[2],y2=d[3];
            if(x1<0)x1=0;if(y1<0)y1=0;if(x2>nw*256)x2=nw*256;if(y2>nh*256)y2=nh*256;
            //int px=(int)(x1/256.0f/nw*CAM_W), py=(int)(y1/256.0f/nh*CAM_H);
            //int pw=(int)((x2-x1)/256.0f/nw*CAM_W), ph=(int)((y2-y1)/256.0f/nh*CAM_H);

            // 修复后
            int px=(int)(x1/256.0f/nw*CAM_W),    py=(int)(y1/256.0f/SUB_H*CAM_H);
            int pw=(int)((x2-x1)/256.0f/nw*CAM_W), ph=(int)((y2-y1)/256.0f/SUB_H*CAM_H);

            int pct=(int)((scores_i[keep[i]]-o_zp)*o_sc*100);
            bsp_printf(" [%d,%d %dx%d %d]",px,py,pw,ph,pct);
        }
        bsp_printf("\r\n");
    }
}
