#include "dmasg.h"
#include "intc.h"
#include "vision/apb3_cam.h"

#define FACE_LANDMARK_INPUT_BYTES   192*192*3
#define NUM_LANDMARK                468
#define FACE_FLAG_THRESH            0.2

#define FRAME_WIDTH     1080
#define FRAME_HEIGHT    1080

#define NET_HEIGHT      192
#define NET_WIDTH       192
#define COORDINATES     3


//Set to 4 for multi-buffering; Set to 1 for single buffering (shared for camera frame capture, display, and tinyML pre-processing input).
#define NUM_BUFFER   4
//Start address to be divided evenly by 8. Otherwise DMA tkeep might be shifted, not handled in display and hw_accel blocks.
//BUFFER_START_ADDR should not overlap with memory space allocated for RISC-V program (default.ld)
#define BUFFER_START_ADDR        0x01100000
//Memory gap between BUFFER_START_ADDR and TINYML_INPUT_START_ADDR must sufficient to accommate NUM_BUFFER*FRAME_WIDTH*FRAME_HEIGHT*4 bytes data
#define TINYML_INPUT_START_ADDR  0x03000000

#define buffer_array       ((volatile uint32_t*)BUFFER_START_ADDR)
#define tinyml_input_array ((volatile uint8_t*)TINYML_INPUT_START_ADDR)

uint8_t camera_buffer = 0;
uint8_t display_buffer = 0;
uint8_t next_display_buffer = 0;
uint8_t draw_buffer = 0;
uint8_t  landmark_valid = 0;
uint32_t landmark_x[NUM_LANDMARK];
uint32_t landmark_y[NUM_LANDMARK];

static void flush_data_cache(){
   asm(".word(0x500F)");
}
u32 buf(u32 i) {
   return BUFFER_START_ADDR +  FRAME_WIDTH*FRAME_HEIGHT*4*i;
}
void send_dma(u32 channel, u32 port, u32 addr, u32 size, int interrupt, int wait, int self_restart) {
   dmasg_input_memory(DMASG_BASE, channel, addr, 16);
   dmasg_output_stream(DMASG_BASE, channel, port, 0, 0, 1);

   if(interrupt) {
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
   }

   if(self_restart) {
      dmasg_direct_start(DMASG_BASE, channel, size, 1);
   } else {
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
   }

   if(wait) {
      while(dmasg_busy(DMASG_BASE, channel));
      flush_data_cache();
   }
}

void recv_dma(u32 channel, u32 port, u32 addr, u32 size, int interrupt, int wait, int self_restart) {
   dmasg_input_stream(DMASG_BASE, channel, port, 1, 0);
   dmasg_output_memory(DMASG_BASE, channel, addr, 16);

   if(interrupt){
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
   }

   if(self_restart) {
      dmasg_direct_start(DMASG_BASE, channel, size, 1);
   } else {
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
   }

   if(wait){
      while(dmasg_busy(DMASG_BASE, channel));
      flush_data_cache();
   }
}
/*
u32 array_offset;
void trigger_next_display_dma() {
   display_buffer = next_display_buffer;
   send_dma(DMASG_DISPLAY_MM2S_CHANNEL, DMASG_DISPLAY_MM2S_PORT, buf(display_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);

   //Plot landmark points for display
   array_offset = display_buffer*FRAME_WIDTH*FRAME_HEIGHT;
   if(landmark_valid) {
      for (int i=0; i<NUM_LANDMARK; i++) {
         for (int j=-1; j<2; j++) {
            for (int k=-1; k<2; k++) {
               buffer_array [array_offset + (landmark_y[i]+j)*FRAME_WIDTH + landmark_x[i] +k] = 0x000000FF; //RED
            }
         }
      }
   }
}
*/
static u8 n = 0;
static u8 cnt = 0;
static u32 col[] = {0xffff0000, 0xff00ff00, 0xff0000ff};
void trigger_next_display_dma() {
	bsp_printf("+");
	u32 color = col[n];

	if((cnt++ & 31) == 0) {
		n++;
		color = col[n];
		bsp_printf("color => %d\n\r", n);
		if(n > 2) n = 0;
	}
   display_buffer = next_display_buffer;
   u32 *bbuf = (u32*)buf(display_buffer);
   for(int i = 0; i < FRAME_HEIGHT; i++) {
	   for(int j = 0; j < FRAME_WIDTH; j++) {
		   *bbuf++ = color;
	   }
   }
   send_dma(DMASG_DISPLAY_MM2S_CHANNEL, DMASG_DISPLAY_MM2S_PORT, buf(display_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
}

void trigger_next_cam_dma() {
   next_display_buffer = camera_buffer;
   for(int i=0; i<NUM_BUFFER; i++)
   {
      if(i!=display_buffer && i!=next_display_buffer && i!=draw_buffer)
      {
         camera_buffer = i;
         break;
      }
   }
   recv_dma(DMASG_CAM_S2MM_CHANNEL, DMASG_CAM_S2MM_PORT, buf(camera_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);

//   //Indicate start of S2MM DMA to camera building block via APB3 slave
   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG4_OFFSET, 0x00000001);
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG4_OFFSET, 0x00000000);

   //Trigger storage of one captured frame via APB3 slave
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000002);
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000000);
}

int main(int argc, char **argv) {
	   bsp_printf("hello\n\r");

	   mipi_i2c_init();
	   PiCam_init();
	   bsp_printf("Done\n\r");

	   //Indicate camera configuration done
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG1_OFFSET, 0x00000001);
	   bsp_printf("n\n\r");

	   //SET camera pre-processing RGB gain value
	   Set_RGBGain(1,5,3,4);

	   dma_init();
	   dmasg_priority(DMASG_BASE, DMASG_HW_ACCEL_MM2S_CHANNEL, 0, 0);
	   dmasg_priority(DMASG_BASE, DMASG_HW_ACCEL_S2MM_CHANNEL, 0, 0);
	   dmasg_priority(DMASG_BASE, DMASG_DISPLAY_MM2S_CHANNEL,  3, 0);
	   dmasg_priority(DMASG_BASE, DMASG_CAM_S2MM_CHANNEL,      0, 0);
	   //Trigger display DMA once then the rest handled by interrupt sub-rountine
	   bsp_printf("Trigger display DMA...");
	   send_dma(DMASG_DISPLAY_MM2S_CHANNEL, DMASG_DISPLAY_MM2S_PORT, buf(display_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
	   display_mm2s_active = 1;
	   bsp_printf("Done\n\r");

	   bsp_uDelay(3000*1000); //Display colour bar for 3 seconds

	   /*********************************************************TRIGGER CAMERA CAPTURE*****************************************************/

	   //SELECT RGB or grayscale output from camera pre-processing block.
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG3_OFFSET, 0x00000000);   //RGB
	   //uart_read(BSP_UART_TERMINAL);
	   //Trigger camera DMA once then the rest handled by interrupt sub-rountine
	   bsp_printf("Trigger camera DMA...");
	   recv_dma(DMASG_CAM_S2MM_CHANNEL, DMASG_CAM_S2MM_PORT, buf(camera_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
	   cam_s2mm_active = 1;

	   //Indicate start of S2MM DMA to camera building block via APB3 slave
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG4_OFFSET, 0x00000001);
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG4_OFFSET, 0x00000000);

	   //Trigger storage of one captured frame via APB3 slave
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000002);
	   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000000);

	   bsp_printf("Done\n\r");
	   uint8_t color = 0;
	   int cnt = 0;
	   while(1) {

	      /***********************************************HW ACCELERATOR - TINYML PRE-PROCESSING********************************************/

	      //Person Detection Model: Perform Image Scaling & Pixel packing
	      //Input: 540x540x3; Output: 192x192x3
		   //bsp_printf("\n\rHardware Accelerator - TinyML Pre-processing...");
		   if(!(cnt++ & 0xff))
			   bsp_printf(".");
	      //Trigger HW accel MM2S DMA

//		  send_dma(DMASG_HW_ACCEL_MM2S_CHANNEL, DMASG_HW_ACCEL_MM2S_PORT, buf(draw_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 0, 0, 0);
//
//	      //Trigger HW accel S2MM DMA
//	      recv_dma(DMASG_HW_ACCEL_S2MM_CHANNEL, DMASG_HW_ACCEL_S2MM_PORT, TINYML_INPUT_START_ADDR, FACE_LANDMARK_INPUT_BYTES, 0, 0, 0);
//
//
//	      //Indicate start of S2MM DMA to HW accel building block via APB3 slave
//	      EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG6_OFFSET, 0x00000001);
//	      EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG6_OFFSET, 0x00000000);
//
//	      //Wait for DMA transfer completion
//	      while(dmasg_busy(DMASG_BASE, DMASG_HW_ACCEL_MM2S_CHANNEL) || dmasg_busy(DMASG_BASE, DMASG_HW_ACCEL_S2MM_CHANNEL));
//
//	      flush_data_cache();
	      bsp_uDelay(1000*5);
	   }
	return 0;
}
