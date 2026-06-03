
build/gpioDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00002197          	auipc	gp,0x2
    1004:	1f018193          	addi	gp,gp,496 # 31f0 <__global_pointer$>
.global smp_lottery_target
.global smp_lottery_lock
.global smp_slave


  sw x0, smp_lottery_lock, a1
    1008:	8601a623          	sw	zero,-1940(gp) # 2a5c <smp_lottery_lock>

0000100c <smp_tyranny>:

smp_tyranny:
  csrr a0, mhartid
    100c:	f1402573          	csrr	a0,mhartid
  beqz a0, init
    1010:	02050e63          	beqz	a0,104c <init>

00001014 <smp_slave>:

smp_slave:
	lw a0, smp_lottery_lock
    1014:	86c1a503          	lw	a0,-1940(gp) # 2a5c <smp_lottery_lock>
	beqz a0, smp_slave
    1018:	fe050ee3          	beqz	a0,1014 <smp_slave>

	fence r, r
    101c:	0220000f          	fence	r,r
    1020:	0000100f          	fence.i
	//li a1, -1
	//amoadd.w x0, a1,(a0)

	.word(0x100F) //i$ flush
	lw a5, smp_lottery_target
    1024:	8681a783          	lw	a5,-1944(gp) # 2a58 <smp_lottery_target>
	li a0, 0
    1028:	00000513          	li	a0,0
	li a1, 0
    102c:	00000593          	li	a1,0
	li a2, 0
    1030:	00000613          	li	a2,0
	jr a5
    1034:	00078067          	jr	a5

00001038 <smp_unlock>:

.global   smp_unlock
.type    smp_unlock,%function
smp_unlock:
	sw a0, smp_lottery_target, a1
    1038:	86a1a423          	sw	a0,-1944(gp) # 2a58 <smp_lottery_target>
	fence w, w
    103c:	0110000f          	fence	w,w
	li a0, 1
    1040:	00100513          	li	a0,1
	sw a0, smp_lottery_lock, a1
    1044:	86a1a623          	sw	a0,-1940(gp) # 2a5c <smp_lottery_lock>
    ret
    1048:	00008067          	ret

0000104c <init>:
#endif

init:
	la sp, _sp
    104c:	00202117          	auipc	sp,0x202
    1050:	b2410113          	addi	sp,sp,-1244 # 202b70 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1054:	00002517          	auipc	a0,0x2
    1058:	8a450513          	addi	a0,a0,-1884 # 28f8 <_data>
	la a1, _data
    105c:	00002597          	auipc	a1,0x2
    1060:	89c58593          	addi	a1,a1,-1892 # 28f8 <_data>
	la a2, _edata
    1064:	81c18613          	addi	a2,gp,-2020 # 2a0c <flagAE>
	bgeu a1, a2, 2f
    1068:	00c5fc63          	bgeu	a1,a2,1080 <init+0x34>
1:
	lw t0, (a0)
    106c:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
    1070:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
    1074:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
    1078:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
    107c:	fec5e8e3          	bltu	a1,a2,106c <init+0x20>
2:

	/* Clear bss section */
	la a0, __bss_start
    1080:	81c18513          	addi	a0,gp,-2020 # 2a0c <flagAE>
	la a1, _end
    1084:	98018593          	addi	a1,gp,-1664 # 2b70 <_end>
	bgeu a0, a1, 2f
    1088:	00b57863          	bgeu	a0,a1,1098 <init+0x4c>
1:
	sw zero, (a0)
    108c:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
    1090:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
    1094:	feb56ce3          	bltu	a0,a1,108c <init+0x40>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
    1098:	010000ef          	jal	ra,10a8 <__libc_init_array>
#endif

	call main
    109c:	2fd000ef          	jal	ra,1b98 <main>

000010a0 <mainDone>:
mainDone:
    j mainDone
    10a0:	0000006f          	j	10a0 <mainDone>

000010a4 <_init>:


	.globl _init
_init:
    ret
    10a4:	00008067          	ret

Disassembly of section .text:

000010a8 <__libc_init_array>:
    10a8:	ff010113          	addi	sp,sp,-16
    10ac:	00812423          	sw	s0,8(sp)
    10b0:	01212023          	sw	s2,0(sp)
    10b4:	00002417          	auipc	s0,0x2
    10b8:	84440413          	addi	s0,s0,-1980 # 28f8 <_data>
    10bc:	00002917          	auipc	s2,0x2
    10c0:	83c90913          	addi	s2,s2,-1988 # 28f8 <_data>
    10c4:	40890933          	sub	s2,s2,s0
    10c8:	00112623          	sw	ra,12(sp)
    10cc:	00912223          	sw	s1,4(sp)
    10d0:	40295913          	srai	s2,s2,0x2
    10d4:	00090e63          	beqz	s2,10f0 <__libc_init_array+0x48>
    10d8:	00000493          	li	s1,0
    10dc:	00042783          	lw	a5,0(s0)
    10e0:	00148493          	addi	s1,s1,1
    10e4:	00440413          	addi	s0,s0,4
    10e8:	000780e7          	jalr	a5
    10ec:	fe9918e3          	bne	s2,s1,10dc <__libc_init_array+0x34>
    10f0:	00002417          	auipc	s0,0x2
    10f4:	80840413          	addi	s0,s0,-2040 # 28f8 <_data>
    10f8:	00002917          	auipc	s2,0x2
    10fc:	80090913          	addi	s2,s2,-2048 # 28f8 <_data>
    1100:	40890933          	sub	s2,s2,s0
    1104:	40295913          	srai	s2,s2,0x2
    1108:	00090e63          	beqz	s2,1124 <__libc_init_array+0x7c>
    110c:	00000493          	li	s1,0
    1110:	00042783          	lw	a5,0(s0)
    1114:	00148493          	addi	s1,s1,1
    1118:	00440413          	addi	s0,s0,4
    111c:	000780e7          	jalr	a5
    1120:	fe9918e3          	bne	s2,s1,1110 <__libc_init_array+0x68>
    1124:	00c12083          	lw	ra,12(sp)
    1128:	00812403          	lw	s0,8(sp)
    112c:	00412483          	lw	s1,4(sp)
    1130:	00012903          	lw	s2,0(sp)
    1134:	01010113          	addi	sp,sp,16
    1138:	00008067          	ret

0000113c <clint_uDelay>:
    
        return (((u64)hi) << 32) | lo;
    }
    
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
    113c:	000f47b7          	lui	a5,0xf4
    1140:	24078793          	addi	a5,a5,576 # f4240 <__global_pointer$+0xf1050>
    1144:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    1148:	0000c7b7          	lui	a5,0xc
    114c:	ff878793          	addi	a5,a5,-8 # bff8 <__global_pointer$+0x8e08>
    1150:	00f60633          	add	a2,a2,a5
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    1154:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    1158:	02a58533          	mul	a0,a1,a0
    115c:	00f50533          	add	a0,a0,a5
    1160:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    1164:	40f507b3          	sub	a5,a0,a5
    1168:	fe07dce3          	bgez	a5,1160 <clint_uDelay+0x24>
    }
    116c:	00008067          	ret

00001170 <GT911_calculateChecksum>:
#include "gt911.h"
#include "arduinoGPIO.h"

static void GT911_calculateChecksum(GT911_Device *dev) {
    uint8_t checksum = 0;
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
    1170:	00000793          	li	a5,0
    uint8_t checksum = 0;
    1174:	00000713          	li	a4,0
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
    1178:	0b900693          	li	a3,185
    117c:	02f6e063          	bltu	a3,a5,119c <GT911_calculateChecksum+0x2c>
        checksum += dev->configBuf[i];
    1180:	00f506b3          	add	a3,a0,a5
    1184:	0146c683          	lbu	a3,20(a3)
    1188:	00e68733          	add	a4,a3,a4
    118c:	0ff77713          	andi	a4,a4,255
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
    1190:	00178793          	addi	a5,a5,1
    1194:	0ff7f793          	andi	a5,a5,255
    1198:	fe1ff06f          	j	1178 <GT911_calculateChecksum+0x8>
    checksum = (~checksum) + 1;
    119c:	40e00733          	neg	a4,a4
    dev->configBuf[GT911_CONFIG_CHKSUM - GT911_CONFIG_START] = checksum;
    11a0:	0ce50623          	sb	a4,204(a0)
}
    11a4:	00008067          	ret

000011a8 <GT911_init>:

void GT911_init(GT911_Device *dev, int rst, int intp, uint16_t width, uint16_t height) {
    11a8:	ff010113          	addi	sp,sp,-16
    11ac:	00112623          	sw	ra,12(sp)
    //dev->pin_rst = rst;
    //dev->pin_int = intp;
    dev->width = width;
    11b0:	00d51623          	sh	a3,12(a0)
    dev->height = height;
    11b4:	00e51723          	sh	a4,14(a0)
    dev->rotation = ROTATION_NORMAL;
    11b8:	00052823          	sw	zero,16(a0)
    dev->isTouched = false;
    11bc:	0c0507a3          	sb	zero,207(a0)
    dev->touches = 0;
    11c0:	0c050723          	sb	zero,206(a0)

    // I2C默认使用 BANK1, SCL=0, SDA=1
    Wire_begin(1, 0);
    11c4:	00000593          	li	a1,0
    11c8:	00100513          	li	a0,1
    11cc:	3f8010ef          	jal	ra,25c4 <Wire_begin>
    Wire_setClock(100000);
    11d0:	00018537          	lui	a0,0x18
    11d4:	6a050513          	addi	a0,a0,1696 # 186a0 <__global_pointer$+0x154b0>
    11d8:	468010ef          	jal	ra,2640 <Wire_setClock>
}
    11dc:	00c12083          	lw	ra,12(sp)
    11e0:	01010113          	addi	sp,sp,16
    11e4:	00008067          	ret

000011e8 <GT911_setRotation>:

    GT911_setResolution(dev, dev->width, dev->height);
}

void GT911_setRotation(GT911_Device *dev, GT911_Rotation rot) {
    dev->rotation = rot;
    11e8:	00b52823          	sw	a1,16(a0)
}
    11ec:	00008067          	ret

000011f0 <GT911_reflashConfig>:


    GT911_reflashConfig(dev);
}

void GT911_reflashConfig(GT911_Device *dev) {
    11f0:	ff010113          	addi	sp,sp,-16
    11f4:	00112623          	sw	ra,12(sp)
    11f8:	00812423          	sw	s0,8(sp)
    11fc:	00050413          	mv	s0,a0
    GT911_calculateChecksum(dev);
    1200:	f71ff0ef          	jal	ra,1170 <GT911_calculateChecksum>
    Wire_beginTransmission(dev->addr);
    1204:	00044503          	lbu	a0,0(s0)
    1208:	480010ef          	jal	ra,2688 <Wire_beginTransmission>
    Wire_write((GT911_CONFIG_CHKSUM >> 8) & 0xFF);
    120c:	08000513          	li	a0,128
    1210:	4bc010ef          	jal	ra,26cc <Wire_write>
    Wire_write(GT911_CONFIG_CHKSUM & 0xFF);
    1214:	0ff00513          	li	a0,255
    1218:	4b4010ef          	jal	ra,26cc <Wire_write>
    Wire_write(dev->configBuf[GT911_CONFIG_CHKSUM - GT911_CONFIG_START]);
    121c:	0cc44503          	lbu	a0,204(s0)
    1220:	4ac010ef          	jal	ra,26cc <Wire_write>
    Wire_endTransmission();
    1224:	544010ef          	jal	ra,2768 <Wire_endTransmission>

    Wire_beginTransmission(dev->addr);
    1228:	00044503          	lbu	a0,0(s0)
    122c:	45c010ef          	jal	ra,2688 <Wire_beginTransmission>
    Wire_write((GT911_CONFIG_FRESH >> 8) & 0xFF);
    1230:	08100513          	li	a0,129
    1234:	498010ef          	jal	ra,26cc <Wire_write>
    Wire_write(GT911_CONFIG_FRESH & 0xFF);
    1238:	00000513          	li	a0,0
    123c:	490010ef          	jal	ra,26cc <Wire_write>
    Wire_write(1);
    1240:	00100513          	li	a0,1
    1244:	488010ef          	jal	ra,26cc <Wire_write>
    Wire_endTransmission();
    1248:	520010ef          	jal	ra,2768 <Wire_endTransmission>
}
    124c:	00c12083          	lw	ra,12(sp)
    1250:	00812403          	lw	s0,8(sp)
    1254:	01010113          	addi	sp,sp,16
    1258:	00008067          	ret

0000125c <GT911_setResolution>:
void GT911_setResolution(GT911_Device *dev, uint16_t width, uint16_t height) {
    125c:	ff010113          	addi	sp,sp,-16
    1260:	00112623          	sw	ra,12(sp)
    dev->configBuf[GT911_X_OUTPUT_MAX_LOW  - GT911_CONFIG_START] = width & 0xFF;
    1264:	00b50aa3          	sb	a1,21(a0)
    dev->configBuf[GT911_X_OUTPUT_MAX_HIGH - GT911_CONFIG_START] = width >> 8;
    1268:	0085d593          	srli	a1,a1,0x8
    126c:	00b50b23          	sb	a1,22(a0)
    dev->configBuf[GT911_Y_OUTPUT_MAX_LOW  - GT911_CONFIG_START] = height & 0xFF;
    1270:	00c50ba3          	sb	a2,23(a0)
    dev->configBuf[GT911_Y_OUTPUT_MAX_HIGH - GT911_CONFIG_START] = height >> 8;
    1274:	00865613          	srli	a2,a2,0x8
    1278:	00c50c23          	sb	a2,24(a0)
    GT911_reflashConfig(dev);
    127c:	f75ff0ef          	jal	ra,11f0 <GT911_reflashConfig>
}
    1280:	00c12083          	lw	ra,12(sp)
    1284:	01010113          	addi	sp,sp,16
    1288:	00008067          	ret

0000128c <GT911_reset>:
void GT911_reset(GT911_Device *dev) {
    128c:	ff010113          	addi	sp,sp,-16
    1290:	00112623          	sw	ra,12(sp)
    1294:	00812423          	sw	s0,8(sp)
    1298:	00912223          	sw	s1,4(sp)
    129c:	01212023          	sw	s2,0(sp)
    12a0:	00050493          	mv	s1,a0
    bsp_uDelay(10000);
    12a4:	f8b00637          	lui	a2,0xf8b00
    12a8:	05f5e437          	lui	s0,0x5f5e
    12ac:	10040593          	addi	a1,s0,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    12b0:	00002537          	lui	a0,0x2
    12b4:	71050513          	addi	a0,a0,1808 # 2710 <Wire_writeBytes+0x4>
    12b8:	e85ff0ef          	jal	ra,113c <clint_uDelay>
    bsp_uDelay(1000);
    12bc:	f8b00637          	lui	a2,0xf8b00
    12c0:	10040593          	addi	a1,s0,256
    12c4:	3e800513          	li	a0,1000
    12c8:	e75ff0ef          	jal	ra,113c <clint_uDelay>
    bsp_uDelay(5000);
    12cc:	f8b00637          	lui	a2,0xf8b00
    12d0:	10040593          	addi	a1,s0,256
    12d4:	00001537          	lui	a0,0x1
    12d8:	38850513          	addi	a0,a0,904 # 1388 <GT911_begin+0x10>
    12dc:	e61ff0ef          	jal	ra,113c <clint_uDelay>
    bsp_uDelay(50000);
    12e0:	f8b00637          	lui	a2,0xf8b00
    12e4:	10040593          	addi	a1,s0,256
    12e8:	0000c937          	lui	s2,0xc
    12ec:	35090513          	addi	a0,s2,848 # c350 <__global_pointer$+0x9160>
    12f0:	e4dff0ef          	jal	ra,113c <clint_uDelay>
    bsp_uDelay(50000);
    12f4:	f8b00637          	lui	a2,0xf8b00
    12f8:	10040593          	addi	a1,s0,256
    12fc:	35090513          	addi	a0,s2,848
    1300:	e3dff0ef          	jal	ra,113c <clint_uDelay>
    Wire_beginTransmission(dev->addr);
    1304:	0004c503          	lbu	a0,0(s1)
    1308:	380010ef          	jal	ra,2688 <Wire_beginTransmission>
    Wire_write((GT911_CONFIG_START >> 8) & 0xFF);
    130c:	08000513          	li	a0,128
    1310:	3bc010ef          	jal	ra,26cc <Wire_write>
    Wire_write(GT911_CONFIG_START & 0xFF);
    1314:	04700513          	li	a0,71
    1318:	3b4010ef          	jal	ra,26cc <Wire_write>
    Wire_endTransmission();
    131c:	44c010ef          	jal	ra,2768 <Wire_endTransmission>
    Wire_requestFrom(dev->addr, GT911_CONFIG_SIZE);
    1320:	0ba00593          	li	a1,186
    1324:	0004c503          	lbu	a0,0(s1)
    1328:	45c010ef          	jal	ra,2784 <Wire_requestFrom>
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
    132c:	00000413          	li	s0,0
    1330:	0b900793          	li	a5,185
    1334:	0087ee63          	bltu	a5,s0,1350 <GT911_reset+0xc4>
        dev->configBuf[i] = Wire_read();
    1338:	4f4010ef          	jal	ra,282c <Wire_read>
    133c:	008487b3          	add	a5,s1,s0
    1340:	00a78a23          	sb	a0,20(a5)
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
    1344:	00140413          	addi	s0,s0,1
    1348:	0ff47413          	andi	s0,s0,255
    134c:	fe5ff06f          	j	1330 <GT911_reset+0xa4>
    GT911_setResolution(dev, dev->width, dev->height);
    1350:	00e4d603          	lhu	a2,14(s1)
    1354:	00c4d583          	lhu	a1,12(s1)
    1358:	00048513          	mv	a0,s1
    135c:	f01ff0ef          	jal	ra,125c <GT911_setResolution>
}
    1360:	00c12083          	lw	ra,12(sp)
    1364:	00812403          	lw	s0,8(sp)
    1368:	00412483          	lw	s1,4(sp)
    136c:	00012903          	lw	s2,0(sp)
    1370:	01010113          	addi	sp,sp,16
    1374:	00008067          	ret

00001378 <GT911_begin>:
void GT911_begin(GT911_Device *dev, uint8_t addr) {
    1378:	ff010113          	addi	sp,sp,-16
    137c:	00112623          	sw	ra,12(sp)
    dev->addr = addr;
    1380:	00b50023          	sb	a1,0(a0)
    GT911_reset(dev);
    1384:	f09ff0ef          	jal	ra,128c <GT911_reset>
}
    1388:	00c12083          	lw	ra,12(sp)
    138c:	01010113          	addi	sp,sp,16
    1390:	00008067          	ret

00001394 <GT911_readPoint>:
    Wire_write(0);
    Wire_endTransmission();
}
// ...existing code...

TP_Point GT911_readPoint(GT911_Device *dev, uint8_t *data) {
    1394:	ff010113          	addi	sp,sp,-16
    TP_Point p;
    uint16_t temp;
    
    p.id = data[0];
    1398:	0005c783          	lbu	a5,0(a1)
    139c:	00f10023          	sb	a5,0(sp)
    // 修正：使用低位在前的顺序，与Arduino版本保持一致
    p.x = data[1] + (data[2] << 8);
    13a0:	0015c783          	lbu	a5,1(a1)
    13a4:	0025c703          	lbu	a4,2(a1)
    13a8:	00871713          	slli	a4,a4,0x8
    13ac:	00e787b3          	add	a5,a5,a4
    13b0:	01079793          	slli	a5,a5,0x10
    13b4:	0107d793          	srli	a5,a5,0x10
    13b8:	00f11123          	sh	a5,2(sp)
    p.y = data[3] + (data[4] << 8);
    13bc:	0035c703          	lbu	a4,3(a1)
    13c0:	0045c683          	lbu	a3,4(a1)
    13c4:	00869693          	slli	a3,a3,0x8
    13c8:	00d70733          	add	a4,a4,a3
    13cc:	01071713          	slli	a4,a4,0x10
    13d0:	01075713          	srli	a4,a4,0x10
    13d4:	00e11223          	sh	a4,4(sp)
    p.size = data[5] + (data[6] << 8);
    13d8:	0055c683          	lbu	a3,5(a1)
    13dc:	0065c603          	lbu	a2,6(a1)
    13e0:	00861613          	slli	a2,a2,0x8
    13e4:	00c686b3          	add	a3,a3,a2
    13e8:	00d11323          	sh	a3,6(sp)

    // 调试输出，帮助排查问题

    switch (dev->rotation) {
    13ec:	01052683          	lw	a3,16(a0)
    13f0:	00100613          	li	a2,1
    13f4:	06c68a63          	beq	a3,a2,1468 <GT911_readPoint+0xd4>
    13f8:	04068a63          	beqz	a3,144c <GT911_readPoint+0xb8>
    13fc:	00300613          	li	a2,3
    1400:	06c68e63          	beq	a3,a2,147c <GT911_readPoint+0xe8>
            break;
        default:
            break;
    }
    
    return p;
    1404:	00012703          	lw	a4,0(sp)
    1408:	00412783          	lw	a5,4(sp)
    140c:	01071513          	slli	a0,a4,0x10
    1410:	01055513          	srli	a0,a0,0x10
    1414:	000105b7          	lui	a1,0x10
    1418:	fff58593          	addi	a1,a1,-1 # ffff <__global_pointer$+0xce0f>
    141c:	01075713          	srli	a4,a4,0x10
    1420:	01071713          	slli	a4,a4,0x10
    1424:	00b57533          	and	a0,a0,a1
    1428:	01079693          	slli	a3,a5,0x10
    142c:	0106d693          	srli	a3,a3,0x10
    1430:	0107d793          	srli	a5,a5,0x10
    1434:	01079793          	slli	a5,a5,0x10
    1438:	00b6f5b3          	and	a1,a3,a1
}
    143c:	00e56533          	or	a0,a0,a4
    1440:	00f5e5b3          	or	a1,a1,a5
    1444:	01010113          	addi	sp,sp,16
    1448:	00008067          	ret
            p.x = dev->width - p.x;
    144c:	00c55683          	lhu	a3,12(a0)
    1450:	40f687b3          	sub	a5,a3,a5
    1454:	00f11123          	sh	a5,2(sp)
            p.y = dev->height - p.y;
    1458:	00e55783          	lhu	a5,14(a0)
    145c:	40e78733          	sub	a4,a5,a4
    1460:	00e11223          	sh	a4,4(sp)
            break;
    1464:	fa1ff06f          	j	1404 <GT911_readPoint+0x70>
            p.x = dev->width - p.y;
    1468:	00c55683          	lhu	a3,12(a0)
    146c:	40e68733          	sub	a4,a3,a4
    1470:	00e11123          	sh	a4,2(sp)
            p.y = temp;
    1474:	00f11223          	sh	a5,4(sp)
            break;
    1478:	f8dff06f          	j	1404 <GT911_readPoint+0x70>
            p.x = p.y;
    147c:	00e11123          	sh	a4,2(sp)
            p.y = dev->height - temp;
    1480:	00e55703          	lhu	a4,14(a0)
    1484:	40f707b3          	sub	a5,a4,a5
    1488:	00f11223          	sh	a5,4(sp)
            break;
    148c:	f79ff06f          	j	1404 <GT911_readPoint+0x70>

00001490 <GT911_read>:
void GT911_read(GT911_Device *dev) {
    1490:	fe010113          	addi	sp,sp,-32
    1494:	00112e23          	sw	ra,28(sp)
    1498:	00812c23          	sw	s0,24(sp)
    149c:	00912a23          	sw	s1,20(sp)
    14a0:	01212823          	sw	s2,16(sp)
    14a4:	00050493          	mv	s1,a0
    Wire_beginTransmission(dev->addr);
    14a8:	00054503          	lbu	a0,0(a0)
    14ac:	1dc010ef          	jal	ra,2688 <Wire_beginTransmission>
    Wire_write((GT911_POINT_INFO >> 8) & 0xFF);
    14b0:	08100513          	li	a0,129
    14b4:	218010ef          	jal	ra,26cc <Wire_write>
    Wire_write(GT911_POINT_INFO & 0xFF);
    14b8:	04e00513          	li	a0,78
    14bc:	210010ef          	jal	ra,26cc <Wire_write>
    Wire_endTransmission();
    14c0:	2a8010ef          	jal	ra,2768 <Wire_endTransmission>
    Wire_requestFrom(dev->addr, 1);
    14c4:	00100593          	li	a1,1
    14c8:	0004c503          	lbu	a0,0(s1)
    14cc:	2b8010ef          	jal	ra,2784 <Wire_requestFrom>
    uint8_t pointInfo = Wire_read();
    14d0:	35c010ef          	jal	ra,282c <Wire_read>
    14d4:	0ff57513          	andi	a0,a0,255
    uint8_t bufferStatus = (pointInfo >> 7) & 1;
    14d8:	00755713          	srli	a4,a0,0x7
    dev->isLargeDetect = (pointInfo >> 6) & 1;
    14dc:	00655793          	srli	a5,a0,0x6
    14e0:	0017f793          	andi	a5,a5,1
    14e4:	0cf48823          	sb	a5,208(s1)
    dev->touches = pointInfo & 0x0F;
    14e8:	00f57513          	andi	a0,a0,15
    14ec:	0ca48723          	sb	a0,206(s1)
    dev->isTouched = dev->touches > 0;
    14f0:	00a03533          	snez	a0,a0
    14f4:	0ca487a3          	sb	a0,207(s1)
    if (bufferStatus && dev->isTouched) {
    14f8:	00070463          	beqz	a4,1500 <GT911_read+0x70>
    14fc:	0e051263          	bnez	a0,15e0 <GT911_read+0x150>
    Wire_beginTransmission(dev->addr);
    1500:	0004c503          	lbu	a0,0(s1)
    1504:	184010ef          	jal	ra,2688 <Wire_beginTransmission>
    Wire_write((GT911_POINT_INFO >> 8) & 0xFF);
    1508:	08100513          	li	a0,129
    150c:	1c0010ef          	jal	ra,26cc <Wire_write>
    Wire_write(GT911_POINT_INFO & 0xFF);
    1510:	04e00513          	li	a0,78
    1514:	1b8010ef          	jal	ra,26cc <Wire_write>
    Wire_write(0);
    1518:	00000513          	li	a0,0
    151c:	1b0010ef          	jal	ra,26cc <Wire_write>
    Wire_endTransmission();
    1520:	248010ef          	jal	ra,2768 <Wire_endTransmission>
}
    1524:	01c12083          	lw	ra,28(sp)
    1528:	01812403          	lw	s0,24(sp)
    152c:	01412483          	lw	s1,20(sp)
    1530:	01012903          	lw	s2,16(sp)
    1534:	02010113          	addi	sp,sp,32
    1538:	00008067          	ret
            dev->points[i] = GT911_readPoint(dev, data);
    153c:	01a90413          	addi	s0,s2,26
    1540:	00341413          	slli	s0,s0,0x3
    1544:	00848433          	add	s0,s1,s0
    1548:	00810593          	addi	a1,sp,8
    154c:	00048513          	mv	a0,s1
    1550:	e45ff0ef          	jal	ra,1394 <GT911_readPoint>
    1554:	00a41123          	sh	a0,2(s0)
    1558:	01055513          	srli	a0,a0,0x10
    155c:	00a41223          	sh	a0,4(s0)
    1560:	00b41323          	sh	a1,6(s0)
    1564:	0105d593          	srli	a1,a1,0x10
    1568:	00b41423          	sh	a1,8(s0)
        for (uint8_t i = 0; i < dev->touches; i++) {
    156c:	00190913          	addi	s2,s2,1
    1570:	0ff97913          	andi	s2,s2,255
    1574:	0ce4c783          	lbu	a5,206(s1)
    1578:	f8f974e3          	bgeu	s2,a5,1500 <GT911_read+0x70>
            uint16_t reg = GT911_POINT_1 + i * 8;
    157c:	00391413          	slli	s0,s2,0x3
    1580:	ffff87b7          	lui	a5,0xffff8
    1584:	14f78793          	addi	a5,a5,335 # ffff814f <__freertos_irq_stack_top+0xffdf55df>
    1588:	00f40433          	add	s0,s0,a5
    158c:	01041413          	slli	s0,s0,0x10
    1590:	01045413          	srli	s0,s0,0x10
            Wire_beginTransmission(dev->addr);
    1594:	0004c503          	lbu	a0,0(s1)
    1598:	0f0010ef          	jal	ra,2688 <Wire_beginTransmission>
            Wire_write((reg >> 8) & 0xFF);
    159c:	00845513          	srli	a0,s0,0x8
    15a0:	12c010ef          	jal	ra,26cc <Wire_write>
            Wire_write(reg & 0xFF);
    15a4:	0ff47513          	andi	a0,s0,255
    15a8:	124010ef          	jal	ra,26cc <Wire_write>
            Wire_endTransmission();
    15ac:	1bc010ef          	jal	ra,2768 <Wire_endTransmission>
            Wire_requestFrom(dev->addr, 7);
    15b0:	00700593          	li	a1,7
    15b4:	0004c503          	lbu	a0,0(s1)
    15b8:	1cc010ef          	jal	ra,2784 <Wire_requestFrom>
            for (int j = 0; j < 7; j++)
    15bc:	00000413          	li	s0,0
    15c0:	00600793          	li	a5,6
    15c4:	f687cce3          	blt	a5,s0,153c <GT911_read+0xac>
                data[j] = Wire_read();
    15c8:	264010ef          	jal	ra,282c <Wire_read>
    15cc:	01010793          	addi	a5,sp,16
    15d0:	008787b3          	add	a5,a5,s0
    15d4:	fea78c23          	sb	a0,-8(a5)
            for (int j = 0; j < 7; j++)
    15d8:	00140413          	addi	s0,s0,1
    15dc:	fe5ff06f          	j	15c0 <GT911_read+0x130>
        for (uint8_t i = 0; i < dev->touches; i++) {
    15e0:	00000913          	li	s2,0
    15e4:	f91ff06f          	j	1574 <GT911_read+0xe4>

000015e8 <uart_writeAvailability>:
    15e8:	00452503          	lw	a0,4(a0)
        enum UartStop stop;
        u32 clockDivider;
    } Uart_Config;
    
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    15ec:	01055513          	srli	a0,a0,0x10
    }
    15f0:	0ff57513          	andi	a0,a0,255
    15f4:	00008067          	ret

000015f8 <uart_write>:
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
    
    static void uart_write(u32 reg, char data){
    15f8:	ff010113          	addi	sp,sp,-16
    15fc:	00112623          	sw	ra,12(sp)
    1600:	00812423          	sw	s0,8(sp)
    1604:	00912223          	sw	s1,4(sp)
    1608:	00050413          	mv	s0,a0
    160c:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    1610:	00040513          	mv	a0,s0
    1614:	fd5ff0ef          	jal	ra,15e8 <uart_writeAvailability>
    1618:	fe050ce3          	beqz	a0,1610 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    161c:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    1620:	00c12083          	lw	ra,12(sp)
    1624:	00812403          	lw	s0,8(sp)
    1628:	00412483          	lw	s1,4(sp)
    162c:	01010113          	addi	sp,sp,16
    1630:	00008067          	ret

00001634 <clint_uDelay>:
        u32 mTimePerUsec = hz/1000000;
    1634:	000f47b7          	lui	a5,0xf4
    1638:	24078793          	addi	a5,a5,576 # f4240 <__global_pointer$+0xf1050>
    163c:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    1640:	0000c7b7          	lui	a5,0xc
    1644:	ff878793          	addi	a5,a5,-8 # bff8 <__global_pointer$+0x8e08>
    1648:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
    164c:	00062783          	lw	a5,0(a2) # f8b00000 <__freertos_irq_stack_top+0xf88fd490>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    1650:	02a58533          	mul	a0,a1,a0
    1654:	00f50533          	add	a0,a0,a5
    1658:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    165c:	40f507b3          	sub	a5,a0,a5
    1660:	fe07dce3          	bgez	a5,1658 <clint_uDelay+0x24>
    }
    1664:	00008067          	ret

00001668 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    1668:	ff010113          	addi	sp,sp,-16
    166c:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    1670:	00050593          	mv	a1,a0
    1674:	f8010537          	lui	a0,0xf8010
    1678:	f81ff0ef          	jal	ra,15f8 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    167c:	00c12083          	lw	ra,12(sp)
    1680:	01010113          	addi	sp,sp,16
    1684:	00008067          	ret

00001688 <_putchar_s>:

    static void _putchar_s(char *p)
    {
    1688:	ff010113          	addi	sp,sp,-16
    168c:	00112623          	sw	ra,12(sp)
    1690:	00812423          	sw	s0,8(sp)
    1694:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    1698:	00044503          	lbu	a0,0(s0)
    169c:	00050863          	beqz	a0,16ac <_putchar_s+0x24>
            _putchar(*(p++));
    16a0:	00140413          	addi	s0,s0,1
    16a4:	fc5ff0ef          	jal	ra,1668 <_putchar>
    16a8:	ff1ff06f          	j	1698 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    16ac:	00c12083          	lw	ra,12(sp)
    16b0:	00812403          	lw	s0,8(sp)
    16b4:	01010113          	addi	sp,sp,16
    16b8:	00008067          	ret

000016bc <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    16bc:	ff010113          	addi	sp,sp,-16
    16c0:	00112623          	sw	ra,12(sp)
    16c4:	00812423          	sw	s0,8(sp)
    16c8:	00912223          	sw	s1,4(sp)
    16cc:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    16d0:	01c00413          	li	s0,28
    16d4:	0240006f          	j	16f8 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    16d8:	0084d7b3          	srl	a5,s1,s0
    16dc:	00f7f713          	andi	a4,a5,15
    16e0:	000037b7          	lui	a5,0x3
    16e4:	8f878793          	addi	a5,a5,-1800 # 28f8 <_data>
    16e8:	00e787b3          	add	a5,a5,a4
    16ec:	0007c503          	lbu	a0,0(a5)
    16f0:	f79ff0ef          	jal	ra,1668 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    16f4:	ffc40413          	addi	s0,s0,-4
    16f8:	fe0450e3          	bgez	s0,16d8 <bsp_printHex+0x1c>
        }
    }
    16fc:	00c12083          	lw	ra,12(sp)
    1700:	00812403          	lw	s0,8(sp)
    1704:	00412483          	lw	s1,4(sp)
    1708:	01010113          	addi	sp,sp,16
    170c:	00008067          	ret

00001710 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    1710:	ff010113          	addi	sp,sp,-16
    1714:	00112623          	sw	ra,12(sp)
    1718:	00812423          	sw	s0,8(sp)
    171c:	00912223          	sw	s1,4(sp)
    1720:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1724:	01c00413          	li	s0,28
    1728:	0240006f          	j	174c <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    172c:	0084d7b3          	srl	a5,s1,s0
    1730:	00f7f713          	andi	a4,a5,15
    1734:	000037b7          	lui	a5,0x3
    1738:	90c78793          	addi	a5,a5,-1780 # 290c <_data+0x14>
    173c:	00e787b3          	add	a5,a5,a4
    1740:	0007c503          	lbu	a0,0(a5)
    1744:	f25ff0ef          	jal	ra,1668 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1748:	ffc40413          	addi	s0,s0,-4
    174c:	fe0450e3          	bgez	s0,172c <bsp_printHex_lower+0x1c>

        }
    }
    1750:	00c12083          	lw	ra,12(sp)
    1754:	00812403          	lw	s0,8(sp)
    1758:	00412483          	lw	s1,4(sp)
    175c:	01010113          	addi	sp,sp,16
    1760:	00008067          	ret

00001764 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    1764:	ff010113          	addi	sp,sp,-16
    1768:	00112623          	sw	ra,12(sp)
        _putchar(c);
    176c:	0ff57513          	andi	a0,a0,255
    1770:	ef9ff0ef          	jal	ra,1668 <_putchar>
    }
    1774:	00c12083          	lw	ra,12(sp)
    1778:	01010113          	addi	sp,sp,16
    177c:	00008067          	ret

00001780 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    1780:	ff010113          	addi	sp,sp,-16
    1784:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    1788:	f01ff0ef          	jal	ra,1688 <_putchar_s>
    }
    178c:	00c12083          	lw	ra,12(sp)
    1790:	01010113          	addi	sp,sp,16
    1794:	00008067          	ret

00001798 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    1798:	fd010113          	addi	sp,sp,-48
    179c:	02112623          	sw	ra,44(sp)
    17a0:	02812423          	sw	s0,40(sp)
    17a4:	02912223          	sw	s1,36(sp)
    17a8:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    17ac:	00054663          	bltz	a0,17b8 <bsp_printf_d+0x20>
    {
    17b0:	00010413          	mv	s0,sp
    17b4:	02c0006f          	j	17e0 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    17b8:	02d00513          	li	a0,45
    17bc:	fa9ff0ef          	jal	ra,1764 <bsp_printf_c>
            val = -val;
    17c0:	409004b3          	neg	s1,s1
    17c4:	fedff06f          	j	17b0 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    17c8:	00a00713          	li	a4,10
    17cc:	02e4e7b3          	rem	a5,s1,a4
    17d0:	03078793          	addi	a5,a5,48
    17d4:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    17d8:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    17dc:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    17e0:	fe0494e3          	bnez	s1,17c8 <bsp_printf_d+0x30>
    17e4:	00010793          	mv	a5,sp
    17e8:	fef400e3          	beq	s0,a5,17c8 <bsp_printf_d+0x30>
    17ec:	0100006f          	j	17fc <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
    17f0:	fff40413          	addi	s0,s0,-1
    17f4:	00044503          	lbu	a0,0(s0)
    17f8:	f6dff0ef          	jal	ra,1764 <bsp_printf_c>
        while (p != buffer)
    17fc:	00010793          	mv	a5,sp
    1800:	fef418e3          	bne	s0,a5,17f0 <bsp_printf_d+0x58>
    }
    1804:	02c12083          	lw	ra,44(sp)
    1808:	02812403          	lw	s0,40(sp)
    180c:	02412483          	lw	s1,36(sp)
    1810:	03010113          	addi	sp,sp,48
    1814:	00008067          	ret

00001818 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    1818:	ff010113          	addi	sp,sp,-16
    181c:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    1820:	00000713          	li	a4,0
    1824:	00700793          	li	a5,7
    1828:	02e7c063          	blt	a5,a4,1848 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    182c:	00271693          	slli	a3,a4,0x2
    1830:	ff000793          	li	a5,-16
    1834:	00d797b3          	sll	a5,a5,a3
    1838:	00f577b3          	and	a5,a0,a5
    183c:	00078663          	beqz	a5,1848 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    1840:	00170713          	addi	a4,a4,1
    1844:	fe1ff06f          	j	1824 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    1848:	ec9ff0ef          	jal	ra,1710 <bsp_printHex_lower>
    }
    184c:	00c12083          	lw	ra,12(sp)
    1850:	01010113          	addi	sp,sp,16
    1854:	00008067          	ret

00001858 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    1858:	ff010113          	addi	sp,sp,-16
    185c:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    1860:	00000713          	li	a4,0
    1864:	00700793          	li	a5,7
    1868:	02e7c063          	blt	a5,a4,1888 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    186c:	00271693          	slli	a3,a4,0x2
    1870:	ff000793          	li	a5,-16
    1874:	00d797b3          	sll	a5,a5,a3
    1878:	00f577b3          	and	a5,a0,a5
    187c:	00078663          	beqz	a5,1888 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    1880:	00170713          	addi	a4,a4,1
    1884:	fe1ff06f          	j	1864 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    1888:	e35ff0ef          	jal	ra,16bc <bsp_printHex>
        }
    188c:	00c12083          	lw	ra,12(sp)
    1890:	01010113          	addi	sp,sp,16
    1894:	00008067          	ret

00001898 <plic_set_priority>:
#define PLIC_CLAIM_BASE         0x200004
#define PLIC_ENABLE_PER_HART    0x80
#define PLIC_CONTEXT_PER_HART   0x1000

    static void plic_set_priority(u32 plic, u32 gateway, u32 priority){
        write_u32(priority, plic + PLIC_PRIORITY_BASE + gateway*4);
    1898:	00259593          	slli	a1,a1,0x2
    189c:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
    18a0:	00c5a023          	sw	a2,0(a1)
    }
    18a4:	00008067          	ret

000018a8 <plic_set_enable>:
    static u32 plic_get_priority(u32 plic, u32 gateway){
        return read_u32(plic + PLIC_PRIORITY_BASE + gateway*4);
    }
    
    static void plic_set_enable(u32 plic, u32 target,u32 gateway, u32 enable){
        u32 word = plic + PLIC_ENABLE_BASE + target * PLIC_ENABLE_PER_HART + (gateway / 32 * 4);
    18a8:	00759593          	slli	a1,a1,0x7
    18ac:	00a58533          	add	a0,a1,a0
    18b0:	00565593          	srli	a1,a2,0x5
    18b4:	00259593          	slli	a1,a1,0x2
    18b8:	00b50533          	add	a0,a0,a1
    18bc:	000025b7          	lui	a1,0x2
    18c0:	00b50533          	add	a0,a0,a1
        u32 mask = 1 << (gateway % 32);
    18c4:	00100793          	li	a5,1
    18c8:	00c797b3          	sll	a5,a5,a2
        if (enable)
    18cc:	00068a63          	beqz	a3,18e0 <plic_set_enable+0x38>
        return *((volatile u32*) address);
    18d0:	00052603          	lw	a2,0(a0) # f8010000 <__freertos_irq_stack_top+0xf7e0d490>
            write_u32(read_u32(word) | mask, word);
    18d4:	00c7e7b3          	or	a5,a5,a2
        *((volatile u32*) address) = data;
    18d8:	00f52023          	sw	a5,0(a0)
    18dc:	00008067          	ret
        return *((volatile u32*) address);
    18e0:	00052603          	lw	a2,0(a0)
        else
            write_u32(read_u32(word) & ~mask, word);
    18e4:	fff7c793          	not	a5,a5
    18e8:	00c7f7b3          	and	a5,a5,a2
        *((volatile u32*) address) = data;
    18ec:	00f52023          	sw	a5,0(a0)
    }
    18f0:	00008067          	ret

000018f4 <plic_set_threshold>:
    
    static void plic_set_threshold(u32 plic, u32 target, u32 threshold){
        write_u32(threshold, plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
    18f4:	00c59593          	slli	a1,a1,0xc
    18f8:	00a585b3          	add	a1,a1,a0
    18fc:	00200537          	lui	a0,0x200
    1900:	00a585b3          	add	a1,a1,a0
    1904:	00c5a023          	sw	a2,0(a1) # 2000 <bsp_printf_d+0x70>
    }
    1908:	00008067          	ret

0000190c <plic_claim>:
    static u32 plic_get_threshold(u32 plic, u32 target){
        return read_u32(plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
    }
    
    static u32 plic_claim(u32 plic, u32 target){
        return read_u32(plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
    190c:	00c59593          	slli	a1,a1,0xc
    1910:	00a585b3          	add	a1,a1,a0
    1914:	00200537          	lui	a0,0x200
    1918:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x4>
    191c:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
    1920:	0005a503          	lw	a0,0(a1)
    }
    1924:	00008067          	ret

00001928 <plic_release>:
    
    static void plic_release(u32 plic, u32 target, u32 gateway){
        write_u32(gateway,plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
    1928:	00c59593          	slli	a1,a1,0xc
    192c:	00a585b3          	add	a1,a1,a0
    1930:	00200537          	lui	a0,0x200
    1934:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x4>
    1938:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
    193c:	00c5a023          	sw	a2,0(a1)
    }
    1940:	00008067          	ret

00001944 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    1944:	fc010113          	addi	sp,sp,-64
    1948:	00112e23          	sw	ra,28(sp)
    194c:	00812c23          	sw	s0,24(sp)
    1950:	00912a23          	sw	s1,20(sp)
    1954:	00050493          	mv	s1,a0
    1958:	02b12223          	sw	a1,36(sp)
    195c:	02c12423          	sw	a2,40(sp)
    1960:	02d12623          	sw	a3,44(sp)
    1964:	02e12823          	sw	a4,48(sp)
    1968:	02f12a23          	sw	a5,52(sp)
    196c:	03012c23          	sw	a6,56(sp)
    1970:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    1974:	02410793          	addi	a5,sp,36
    1978:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    197c:	00000413          	li	s0,0
    1980:	01c0006f          	j	199c <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    1984:	00c12783          	lw	a5,12(sp)
    1988:	00478713          	addi	a4,a5,4
    198c:	00e12623          	sw	a4,12(sp)
    1990:	0007a503          	lw	a0,0(a5)
    1994:	dd1ff0ef          	jal	ra,1764 <bsp_printf_c>
        for (i = 0; format[i]; i++)
    1998:	00140413          	addi	s0,s0,1
    199c:	008487b3          	add	a5,s1,s0
    19a0:	0007c503          	lbu	a0,0(a5)
    19a4:	0c050263          	beqz	a0,1a68 <bsp_printf+0x124>
            if (format[i] == '%') {
    19a8:	02500793          	li	a5,37
    19ac:	06f50663          	beq	a0,a5,1a18 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    19b0:	db5ff0ef          	jal	ra,1764 <bsp_printf_c>
    19b4:	fe5ff06f          	j	1998 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    19b8:	00c12783          	lw	a5,12(sp)
    19bc:	00478713          	addi	a4,a5,4
    19c0:	00e12623          	sw	a4,12(sp)
    19c4:	0007a503          	lw	a0,0(a5)
    19c8:	db9ff0ef          	jal	ra,1780 <bsp_printf_s>
                        break;
    19cc:	fcdff06f          	j	1998 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    19d0:	00c12783          	lw	a5,12(sp)
    19d4:	00478713          	addi	a4,a5,4
    19d8:	00e12623          	sw	a4,12(sp)
    19dc:	0007a503          	lw	a0,0(a5)
    19e0:	db9ff0ef          	jal	ra,1798 <bsp_printf_d>
                        break;
    19e4:	fb5ff06f          	j	1998 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    19e8:	00c12783          	lw	a5,12(sp)
    19ec:	00478713          	addi	a4,a5,4
    19f0:	00e12623          	sw	a4,12(sp)
    19f4:	0007a503          	lw	a0,0(a5)
    19f8:	e61ff0ef          	jal	ra,1858 <bsp_printf_X>
                        break;
    19fc:	f9dff06f          	j	1998 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    1a00:	00c12783          	lw	a5,12(sp)
    1a04:	00478713          	addi	a4,a5,4
    1a08:	00e12623          	sw	a4,12(sp)
    1a0c:	0007a503          	lw	a0,0(a5)
    1a10:	e09ff0ef          	jal	ra,1818 <bsp_printf_x>
                        break;
    1a14:	f85ff06f          	j	1998 <bsp_printf+0x54>
                while (format[++i]) {
    1a18:	00140413          	addi	s0,s0,1
    1a1c:	008487b3          	add	a5,s1,s0
    1a20:	0007c783          	lbu	a5,0(a5)
    1a24:	f6078ae3          	beqz	a5,1998 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    1a28:	06300713          	li	a4,99
    1a2c:	f4e78ce3          	beq	a5,a4,1984 <bsp_printf+0x40>
                    else if (format[i] == 's') {
    1a30:	07300713          	li	a4,115
    1a34:	f8e782e3          	beq	a5,a4,19b8 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    1a38:	06400713          	li	a4,100
    1a3c:	f8e78ae3          	beq	a5,a4,19d0 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    1a40:	05800713          	li	a4,88
    1a44:	fae782e3          	beq	a5,a4,19e8 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    1a48:	07800713          	li	a4,120
    1a4c:	fae78ae3          	beq	a5,a4,1a00 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    1a50:	06600713          	li	a4,102
    1a54:	fce792e3          	bne	a5,a4,1a18 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
    1a58:	00003537          	lui	a0,0x3
    1a5c:	92050513          	addi	a0,a0,-1760 # 2920 <_data+0x28>
    1a60:	d21ff0ef          	jal	ra,1780 <bsp_printf_s>
                        break;
    1a64:	f35ff06f          	j	1998 <bsp_printf+0x54>

        va_end(ap);
    }
    1a68:	01c12083          	lw	ra,28(sp)
    1a6c:	01812403          	lw	s0,24(sp)
    1a70:	01412483          	lw	s1,20(sp)
    1a74:	04010113          	addi	sp,sp,64
    1a78:	00008067          	ret

00001a7c <init>:
*
* @brief This function initializes GPIO interrupts and enables external interrupts
*        by setting up the machine trap vector.
*
******************************************************************************/
void init(){
    1a7c:	ff010113          	addi	sp,sp,-16
    1a80:	00112623          	sw	ra,12(sp)
    //configure PLIC
    //cpu 0 accept all interrupts with priority above 0
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0);
    1a84:	00000613          	li	a2,0
    1a88:	00000593          	li	a1,0
    1a8c:	f8c00537          	lui	a0,0xf8c00
    1a90:	e65ff0ef          	jal	ra,18f4 <plic_set_threshold>
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
    1a94:	00100693          	li	a3,1
    1a98:	00c00613          	li	a2,12
    1a9c:	00000593          	li	a1,0
    1aa0:	f8c00537          	lui	a0,0xf8c00
    1aa4:	e05ff0ef          	jal	ra,18a8 <plic_set_enable>
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
    1aa8:	00100613          	li	a2,1
    1aac:	00c00593          	li	a1,12
    1ab0:	f8c00537          	lui	a0,0xf8c00
    1ab4:	de5ff0ef          	jal	ra,1898 <plic_set_priority>


    //enable interrupts
    //Set the machine trap vector (../common/trap.S)
    csr_write(mtvec, trap_entry);
    1ab8:	000037b7          	lui	a5,0x3
    1abc:	86878793          	addi	a5,a5,-1944 # 2868 <trap_entry>
    1ac0:	30579073          	csrw	mtvec,a5
    //Enable external interrupts
    csr_set(mie, MIE_MEIE);
    1ac4:	000017b7          	lui	a5,0x1
    1ac8:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
    1acc:	3047a073          	csrs	mie,a5
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
    1ad0:	300027f3          	csrr	a5,mstatus
    1ad4:	00002737          	lui	a4,0x2
    1ad8:	80870713          	addi	a4,a4,-2040 # 1808 <bsp_printf_d+0x70>
    1adc:	00e7e7b3          	or	a5,a5,a4
    1ae0:	30079073          	csrw	mstatus,a5
}
    1ae4:	00c12083          	lw	ra,12(sp)
    1ae8:	01010113          	addi	sp,sp,16
    1aec:	00008067          	ret

00001af0 <crash>:
*
* @brief This function handles the system crash scenario by printing a crash message
* 		 and entering an infinite loop.
*
******************************************************************************/
void crash(){
    1af0:	ff010113          	addi	sp,sp,-16
    1af4:	00112623          	sw	ra,12(sp)
    bsp_printf("\r\n*** CRASH ***\r\n");
    1af8:	00003537          	lui	a0,0x3
    1afc:	96c50513          	addi	a0,a0,-1684 # 296c <_data+0x74>
    1b00:	e45ff0ef          	jal	ra,1944 <bsp_printf>
    while(1);
    1b04:	0000006f          	j	1b04 <crash+0x14>

00001b08 <externalInterrupt>:
void externalInterrupt(){
    1b08:	ff010113          	addi	sp,sp,-16
    1b0c:	00112623          	sw	ra,12(sp)
    1b10:	00812423          	sw	s0,8(sp)
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
    1b14:	00000593          	li	a1,0
    1b18:	f8c00537          	lui	a0,0xf8c00
    1b1c:	df1ff0ef          	jal	ra,190c <plic_claim>
    1b20:	00050413          	mv	s0,a0
    1b24:	02050863          	beqz	a0,1b54 <externalInterrupt+0x4c>
        switch(claim){
    1b28:	00c00793          	li	a5,12
    1b2c:	02f41263          	bne	s0,a5,1b50 <externalInterrupt+0x48>
        case SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0: bsp_printf("gpio 0 interrupt routine \r\n"); break;
    1b30:	00003537          	lui	a0,0x3
    1b34:	98050513          	addi	a0,a0,-1664 # 2980 <_data+0x88>
    1b38:	e0dff0ef          	jal	ra,1944 <bsp_printf>
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
    1b3c:	00040613          	mv	a2,s0
    1b40:	00000593          	li	a1,0
    1b44:	f8c00537          	lui	a0,0xf8c00
    1b48:	de1ff0ef          	jal	ra,1928 <plic_release>
    1b4c:	fc9ff06f          	j	1b14 <externalInterrupt+0xc>
        default: crash(); break;
    1b50:	fa1ff0ef          	jal	ra,1af0 <crash>
}
    1b54:	00c12083          	lw	ra,12(sp)
    1b58:	00812403          	lw	s0,8(sp)
    1b5c:	01010113          	addi	sp,sp,16
    1b60:	00008067          	ret

00001b64 <trap>:
void trap(){
    1b64:	ff010113          	addi	sp,sp,-16
    1b68:	00112623          	sw	ra,12(sp)
    int32_t mcause = csr_read(mcause);
    1b6c:	342027f3          	csrr	a5,mcause
    if(interrupt){
    1b70:	0207d263          	bgez	a5,1b94 <trap+0x30>
    1b74:	00f7f713          	andi	a4,a5,15
        switch(cause){
    1b78:	00b00793          	li	a5,11
    1b7c:	00f71a63          	bne	a4,a5,1b90 <trap+0x2c>
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
    1b80:	f89ff0ef          	jal	ra,1b08 <externalInterrupt>
}
    1b84:	00c12083          	lw	ra,12(sp)
    1b88:	01010113          	addi	sp,sp,16
    1b8c:	00008067          	ret
        default: crash(); break;
    1b90:	f61ff0ef          	jal	ra,1af0 <crash>
        crash();
    1b94:	f5dff0ef          	jal	ra,1af0 <crash>

00001b98 <main>:
        		return;
        	}
        }
}
// ...existing code...
void main() {
    1b98:	ff010113          	addi	sp,sp,-16
    1b9c:	00112623          	sw	ra,12(sp)
    1ba0:	00812423          	sw	s0,8(sp)
    1ba4:	00912223          	sw	s1,4(sp)
    bsp_printf("GT911 Touch Driver Test\r\n");
    1ba8:	00003537          	lui	a0,0x3
    1bac:	99c50513          	addi	a0,a0,-1636 # 299c <_data+0xa4>
    1bb0:	d95ff0ef          	jal	ra,1944 <bsp_printf>
    pinMode(GPIO_BANK0,0,OUTPUT);
    1bb4:	00100613          	li	a2,1
    1bb8:	00000593          	li	a1,0
    1bbc:	f8015537          	lui	a0,0xf8015
    1bc0:	0f0000ef          	jal	ra,1cb0 <pinMode>
    pinMode(GPIO_BANK0,1,OUTPUT);
    1bc4:	00100613          	li	a2,1
    1bc8:	00100593          	li	a1,1
    1bcc:	f8015537          	lui	a0,0xf8015
    1bd0:	0e0000ef          	jal	ra,1cb0 <pinMode>
    pinMode(GPIO_BANK0,2,OUTPUT);
    1bd4:	00100613          	li	a2,1
    1bd8:	00200593          	li	a1,2
    1bdc:	f8015537          	lui	a0,0xf8015
    1be0:	0d0000ef          	jal	ra,1cb0 <pinMode>
    pinMode(GPIO_BANK0,3,OUTPUT);
    1be4:	00100613          	li	a2,1
    1be8:	00300593          	li	a1,3
    1bec:	f8015537          	lui	a0,0xf8015
    1bf0:	0c0000ef          	jal	ra,1cb0 <pinMode>
    digitalWrite(GPIO_BANK0,0,LOW);
    1bf4:	00000613          	li	a2,0
    1bf8:	00000593          	li	a1,0
    1bfc:	f8015537          	lui	a0,0xf8015
    1c00:	110000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,1,LOW);
    1c04:	00000613          	li	a2,0
    1c08:	00100593          	li	a1,1
    1c0c:	f8015537          	lui	a0,0xf8015
    1c10:	100000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,2,LOW);
    1c14:	00000613          	li	a2,0
    1c18:	00200593          	li	a1,2
    1c1c:	f8015537          	lui	a0,0xf8015
    1c20:	0f0000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,3,LOW);
    1c24:	00000613          	li	a2,0
    1c28:	00300593          	li	a1,3
    1c2c:	f8015537          	lui	a0,0xf8015
    1c30:	0e0000ef          	jal	ra,1d10 <digitalWrite>
    bsp_uDelay(500000);
    1c34:	f8b00637          	lui	a2,0xf8b00
    1c38:	05f5e4b7          	lui	s1,0x5f5e
    1c3c:	10048593          	addi	a1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    1c40:	0007a437          	lui	s0,0x7a
    1c44:	12040513          	addi	a0,s0,288 # 7a120 <__global_pointer$+0x76f30>
    1c48:	9edff0ef          	jal	ra,1634 <clint_uDelay>
    digitalWrite(GPIO_BANK0,0,LOW);
    1c4c:	00000613          	li	a2,0
    1c50:	00000593          	li	a1,0
    1c54:	f8015537          	lui	a0,0xf8015
    1c58:	0b8000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,1,LOW);
    1c5c:	00000613          	li	a2,0
    1c60:	00100593          	li	a1,1
    1c64:	f8015537          	lui	a0,0xf8015
    1c68:	0a8000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,2,LOW);
    1c6c:	00000613          	li	a2,0
    1c70:	00200593          	li	a1,2
    1c74:	f8015537          	lui	a0,0xf8015
    1c78:	098000ef          	jal	ra,1d10 <digitalWrite>
    digitalWrite(GPIO_BANK0,3,LOW);
    1c7c:	00000613          	li	a2,0
    1c80:	00300593          	li	a1,3
    1c84:	f8015537          	lui	a0,0xf8015
    1c88:	088000ef          	jal	ra,1d10 <digitalWrite>
    bsp_uDelay(500000);
    1c8c:	f8b00637          	lui	a2,0xf8b00
    1c90:	10048593          	addi	a1,s1,256
    1c94:	12040513          	addi	a0,s0,288
    1c98:	99dff0ef          	jal	ra,1634 <clint_uDelay>
        }

        bsp_uDelay(50000);
    }
    */
}
    1c9c:	00c12083          	lw	ra,12(sp)
    1ca0:	00812403          	lw	s0,8(sp)
    1ca4:	00412483          	lw	s1,4(sp)
    1ca8:	01010113          	addi	sp,sp,16
    1cac:	00008067          	ret

00001cb0 <pinMode>:
#include "arduinoGPIO.h"

void pinMode(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
    1cb0:	00100793          	li	a5,1
    1cb4:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
    1cb8:	02f60463          	beq	a2,a5,1ce0 <pinMode+0x30>
    1cbc:	00060863          	beqz	a2,1ccc <pinMode+0x1c>
    1cc0:	00200793          	li	a5,2
    1cc4:	02f60663          	beq	a2,a5,1cf0 <pinMode+0x40>
    1cc8:	00008067          	ret
        return *((volatile u32*) address);
    1ccc:	00852783          	lw	a5,8(a0) # f8015008 <__freertos_irq_stack_top+0xf7e12498>
        case INPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
    1cd0:	fff5c593          	not	a1,a1
    1cd4:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
    1cd8:	00b52423          	sw	a1,8(a0)
    1cdc:	00008067          	ret
        return *((volatile u32*) address);
    1ce0:	00852783          	lw	a5,8(a0)
            break;

        case OUTPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) | mask);
    1ce4:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
    1ce8:	00b52423          	sw	a1,8(a0)
    1cec:	00008067          	ret
        return *((volatile u32*) address);
    1cf0:	00852703          	lw	a4,8(a0)
            break;

        case INPUT_PULLUP:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
    1cf4:	fff5c793          	not	a5,a1
    1cf8:	00e7f7b3          	and	a5,a5,a4
        *((volatile u32*) address) = data;
    1cfc:	00f52423          	sw	a5,8(a0)
        return *((volatile u32*) address);
    1d00:	00452783          	lw	a5,4(a0)
            gpio_setOutput(bank, gpio_getOutput(bank) | mask); // Enable pull-up
    1d04:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
    1d08:	00b52223          	sw	a1,4(a0)
            break;
    }
}
    1d0c:	00008067          	ret

00001d10 <digitalWrite>:
        return *((volatile u32*) address);
    1d10:	00452703          	lw	a4,4(a0)

void digitalWrite(uint32_t bank, uint32_t pin, uint32_t val) {
    uint32_t current = gpio_getOutput(bank);
    uint32_t mask = 1 << pin;
    1d14:	00100793          	li	a5,1
    1d18:	00b795b3          	sll	a1,a5,a1

    if(val == HIGH) {
    1d1c:	00f60a63          	beq	a2,a5,1d30 <digitalWrite+0x20>
        gpio_setOutput(bank, current | mask);
    } else {
        gpio_setOutput(bank, current & ~mask);
    1d20:	fff5c593          	not	a1,a1
    1d24:	00e5f5b3          	and	a1,a1,a4
        *((volatile u32*) address) = data;
    1d28:	00b52223          	sw	a1,4(a0)
    }
}
    1d2c:	00008067          	ret
        gpio_setOutput(bank, current | mask);
    1d30:	00e5e5b3          	or	a1,a1,a4
    1d34:	00b52223          	sw	a1,4(a0)
    1d38:	00008067          	ret

00001d3c <digitalRead>:
        return *((volatile u32*) address);
    1d3c:	00052503          	lw	a0,0(a0)

uint32_t digitalRead(uint32_t bank, uint32_t pin) {
    uint32_t value = gpio_getInput(bank);
    return (value >> pin) & 0x1;
    1d40:	00b55533          	srl	a0,a0,a1
}
    1d44:	00157513          	andi	a0,a0,1
    1d48:	00008067          	ret

00001d4c <attachInterrupt>:

void attachInterrupt(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
    1d4c:	00100793          	li	a5,1
    1d50:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
    1d54:	00200793          	li	a5,2
    1d58:	02f60c63          	beq	a2,a5,1d90 <attachInterrupt+0x44>
    1d5c:	00c7fe63          	bgeu	a5,a2,1d78 <attachInterrupt+0x2c>
    1d60:	00300793          	li	a5,3
    1d64:	02f60a63          	beq	a2,a5,1d98 <attachInterrupt+0x4c>
    1d68:	00400793          	li	a5,4
    1d6c:	02f61063          	bne	a2,a5,1d8c <attachInterrupt+0x40>
        *((volatile u32*) address) = data;
    1d70:	02b52623          	sw	a1,44(a0)

        case LOW_LEVEL:
            gpio_setInterruptLowEnable(bank, mask);
            break;
    }
}
    1d74:	00008067          	ret
    switch(mode) {
    1d78:	00100793          	li	a5,1
    1d7c:	00f61663          	bne	a2,a5,1d88 <attachInterrupt+0x3c>
    1d80:	02b52023          	sw	a1,32(a0)
    1d84:	00008067          	ret
    1d88:	00008067          	ret
    1d8c:	00008067          	ret
    1d90:	02b52223          	sw	a1,36(a0)
    1d94:	00008067          	ret
    1d98:	02b52423          	sw	a1,40(a0)
    1d9c:	00008067          	ret

00001da0 <detachInterrupt>:

void detachInterrupt(uint32_t bank, uint32_t pin) {
    uint32_t mask = 1 << pin;
    1da0:	00100793          	li	a5,1
    1da4:	00b795b3          	sll	a1,a5,a1
        return *((volatile u32*) address);
    1da8:	00052783          	lw	a5,0(a0)

    // Disable all interrupt modes for this pin
    gpio_setInterruptRiseEnable(bank, gpio_getInput(bank) & ~mask);
    1dac:	fff5c593          	not	a1,a1
    1db0:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
    1db4:	02f52023          	sw	a5,32(a0)
        return *((volatile u32*) address);
    1db8:	00052783          	lw	a5,0(a0)
    gpio_setInterruptFallEnable(bank, gpio_getInput(bank) & ~mask);
    1dbc:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
    1dc0:	02f52223          	sw	a5,36(a0)
        return *((volatile u32*) address);
    1dc4:	00052783          	lw	a5,0(a0)
    gpio_setInterruptHighEnable(bank, gpio_getInput(bank) & ~mask);
    1dc8:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
    1dcc:	02f52423          	sw	a5,40(a0)
        return *((volatile u32*) address);
    1dd0:	00052783          	lw	a5,0(a0)
    gpio_setInterruptLowEnable(bank, gpio_getInput(bank) & ~mask);
    1dd4:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
    1dd8:	02b52623          	sw	a1,44(a0)
}
    1ddc:	00008067          	ret

00001de0 <uart_writeAvailability>:
        return *((volatile u32*) address);
    1de0:	00452503          	lw	a0,4(a0)
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    1de4:	01055513          	srli	a0,a0,0x10
    }
    1de8:	0ff57513          	andi	a0,a0,255
    1dec:	00008067          	ret

00001df0 <uart_write>:
    static void uart_write(u32 reg, char data){
    1df0:	ff010113          	addi	sp,sp,-16
    1df4:	00112623          	sw	ra,12(sp)
    1df8:	00812423          	sw	s0,8(sp)
    1dfc:	00912223          	sw	s1,4(sp)
    1e00:	00050413          	mv	s0,a0
    1e04:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    1e08:	00040513          	mv	a0,s0
    1e0c:	fd5ff0ef          	jal	ra,1de0 <uart_writeAvailability>
    1e10:	fe050ce3          	beqz	a0,1e08 <uart_write+0x18>
        *((volatile u32*) address) = data;
    1e14:	00942023          	sw	s1,0(s0)
    }
    1e18:	00c12083          	lw	ra,12(sp)
    1e1c:	00812403          	lw	s0,8(sp)
    1e20:	00412483          	lw	s1,4(sp)
    1e24:	01010113          	addi	sp,sp,16
    1e28:	00008067          	ret

00001e2c <clint_uDelay>:
        u32 mTimePerUsec = hz/1000000;
    1e2c:	000f47b7          	lui	a5,0xf4
    1e30:	24078793          	addi	a5,a5,576 # f4240 <__global_pointer$+0xf1050>
    1e34:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    1e38:	0000c7b7          	lui	a5,0xc
    1e3c:	ff878793          	addi	a5,a5,-8 # bff8 <__global_pointer$+0x8e08>
    1e40:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
    1e44:	00062783          	lw	a5,0(a2) # f8b00000 <__freertos_irq_stack_top+0xf88fd490>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    1e48:	02a58533          	mul	a0,a1,a0
    1e4c:	00f50533          	add	a0,a0,a5
    1e50:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    1e54:	40f507b3          	sub	a5,a0,a5
    1e58:	fe07dce3          	bgez	a5,1e50 <clint_uDelay+0x24>
    }
    1e5c:	00008067          	ret

00001e60 <_putchar>:
    static void _putchar(char character){
    1e60:	ff010113          	addi	sp,sp,-16
    1e64:	00112623          	sw	ra,12(sp)
            bsp_putChar(character);
    1e68:	00050593          	mv	a1,a0
    1e6c:	f8010537          	lui	a0,0xf8010
    1e70:	f81ff0ef          	jal	ra,1df0 <uart_write>
    }
    1e74:	00c12083          	lw	ra,12(sp)
    1e78:	01010113          	addi	sp,sp,16
    1e7c:	00008067          	ret

00001e80 <_putchar_s>:
    {
    1e80:	ff010113          	addi	sp,sp,-16
    1e84:	00112623          	sw	ra,12(sp)
    1e88:	00812423          	sw	s0,8(sp)
    1e8c:	00050413          	mv	s0,a0
        while (*p)
    1e90:	00044503          	lbu	a0,0(s0)
    1e94:	00050863          	beqz	a0,1ea4 <_putchar_s+0x24>
            _putchar(*(p++));
    1e98:	00140413          	addi	s0,s0,1
    1e9c:	fc5ff0ef          	jal	ra,1e60 <_putchar>
    1ea0:	ff1ff06f          	j	1e90 <_putchar_s+0x10>
    }
    1ea4:	00c12083          	lw	ra,12(sp)
    1ea8:	00812403          	lw	s0,8(sp)
    1eac:	01010113          	addi	sp,sp,16
    1eb0:	00008067          	ret

00001eb4 <bsp_printHex>:
    {
    1eb4:	ff010113          	addi	sp,sp,-16
    1eb8:	00112623          	sw	ra,12(sp)
    1ebc:	00812423          	sw	s0,8(sp)
    1ec0:	00912223          	sw	s1,4(sp)
    1ec4:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1ec8:	01c00413          	li	s0,28
    1ecc:	0240006f          	j	1ef0 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    1ed0:	0084d7b3          	srl	a5,s1,s0
    1ed4:	00f7f713          	andi	a4,a5,15
    1ed8:	000037b7          	lui	a5,0x3
    1edc:	8f878793          	addi	a5,a5,-1800 # 28f8 <_data>
    1ee0:	00e787b3          	add	a5,a5,a4
    1ee4:	0007c503          	lbu	a0,0(a5)
    1ee8:	f79ff0ef          	jal	ra,1e60 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1eec:	ffc40413          	addi	s0,s0,-4
    1ef0:	fe0450e3          	bgez	s0,1ed0 <bsp_printHex+0x1c>
    }
    1ef4:	00c12083          	lw	ra,12(sp)
    1ef8:	00812403          	lw	s0,8(sp)
    1efc:	00412483          	lw	s1,4(sp)
    1f00:	01010113          	addi	sp,sp,16
    1f04:	00008067          	ret

00001f08 <bsp_printHex_lower>:
    {
    1f08:	ff010113          	addi	sp,sp,-16
    1f0c:	00112623          	sw	ra,12(sp)
    1f10:	00812423          	sw	s0,8(sp)
    1f14:	00912223          	sw	s1,4(sp)
    1f18:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1f1c:	01c00413          	li	s0,28
    1f20:	0240006f          	j	1f44 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    1f24:	0084d7b3          	srl	a5,s1,s0
    1f28:	00f7f713          	andi	a4,a5,15
    1f2c:	000037b7          	lui	a5,0x3
    1f30:	90c78793          	addi	a5,a5,-1780 # 290c <_data+0x14>
    1f34:	00e787b3          	add	a5,a5,a4
    1f38:	0007c503          	lbu	a0,0(a5)
    1f3c:	f25ff0ef          	jal	ra,1e60 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1f40:	ffc40413          	addi	s0,s0,-4
    1f44:	fe0450e3          	bgez	s0,1f24 <bsp_printHex_lower+0x1c>
    }
    1f48:	00c12083          	lw	ra,12(sp)
    1f4c:	00812403          	lw	s0,8(sp)
    1f50:	00412483          	lw	s1,4(sp)
    1f54:	01010113          	addi	sp,sp,16
    1f58:	00008067          	ret

00001f5c <bsp_printf_c>:
    {
    1f5c:	ff010113          	addi	sp,sp,-16
    1f60:	00112623          	sw	ra,12(sp)
        _putchar(c);
    1f64:	0ff57513          	andi	a0,a0,255
    1f68:	ef9ff0ef          	jal	ra,1e60 <_putchar>
    }
    1f6c:	00c12083          	lw	ra,12(sp)
    1f70:	01010113          	addi	sp,sp,16
    1f74:	00008067          	ret

00001f78 <bsp_printf_s>:
    {
    1f78:	ff010113          	addi	sp,sp,-16
    1f7c:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    1f80:	f01ff0ef          	jal	ra,1e80 <_putchar_s>
    }
    1f84:	00c12083          	lw	ra,12(sp)
    1f88:	01010113          	addi	sp,sp,16
    1f8c:	00008067          	ret

00001f90 <bsp_printf_d>:
    {
    1f90:	fd010113          	addi	sp,sp,-48
    1f94:	02112623          	sw	ra,44(sp)
    1f98:	02812423          	sw	s0,40(sp)
    1f9c:	02912223          	sw	s1,36(sp)
    1fa0:	00050493          	mv	s1,a0
        if (val < 0) {
    1fa4:	00054663          	bltz	a0,1fb0 <bsp_printf_d+0x20>
    {
    1fa8:	00010413          	mv	s0,sp
    1fac:	02c0006f          	j	1fd8 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    1fb0:	02d00513          	li	a0,45
    1fb4:	fa9ff0ef          	jal	ra,1f5c <bsp_printf_c>
            val = -val;
    1fb8:	409004b3          	neg	s1,s1
    1fbc:	fedff06f          	j	1fa8 <bsp_printf_d+0x18>
            *(p++) = '0' + val % 10;
    1fc0:	00a00713          	li	a4,10
    1fc4:	02e4e7b3          	rem	a5,s1,a4
    1fc8:	03078793          	addi	a5,a5,48
    1fcc:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    1fd0:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    1fd4:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    1fd8:	fe0494e3          	bnez	s1,1fc0 <bsp_printf_d+0x30>
    1fdc:	00010793          	mv	a5,sp
    1fe0:	fef400e3          	beq	s0,a5,1fc0 <bsp_printf_d+0x30>
    1fe4:	0100006f          	j	1ff4 <bsp_printf_d+0x64>
            bsp_printf_c(*(--p));
    1fe8:	fff40413          	addi	s0,s0,-1
    1fec:	00044503          	lbu	a0,0(s0)
    1ff0:	f6dff0ef          	jal	ra,1f5c <bsp_printf_c>
        while (p != buffer)
    1ff4:	00010793          	mv	a5,sp
    1ff8:	fef418e3          	bne	s0,a5,1fe8 <bsp_printf_d+0x58>
    }
    1ffc:	02c12083          	lw	ra,44(sp)
    2000:	02812403          	lw	s0,40(sp)
    2004:	02412483          	lw	s1,36(sp)
    2008:	03010113          	addi	sp,sp,48
    200c:	00008067          	ret

00002010 <bsp_printf_x>:
    {
    2010:	ff010113          	addi	sp,sp,-16
    2014:	00112623          	sw	ra,12(sp)
        for(i=0;i<8;i++)
    2018:	00000713          	li	a4,0
    201c:	00700793          	li	a5,7
    2020:	02e7c063          	blt	a5,a4,2040 <bsp_printf_x+0x30>
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    2024:	00271693          	slli	a3,a4,0x2
    2028:	ff000793          	li	a5,-16
    202c:	00d797b3          	sll	a5,a5,a3
    2030:	00f577b3          	and	a5,a0,a5
    2034:	00078663          	beqz	a5,2040 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    2038:	00170713          	addi	a4,a4,1
    203c:	fe1ff06f          	j	201c <bsp_printf_x+0xc>
        bsp_printHex_lower(val);
    2040:	ec9ff0ef          	jal	ra,1f08 <bsp_printHex_lower>
    }
    2044:	00c12083          	lw	ra,12(sp)
    2048:	01010113          	addi	sp,sp,16
    204c:	00008067          	ret

00002050 <bsp_printf_X>:
        {
    2050:	ff010113          	addi	sp,sp,-16
    2054:	00112623          	sw	ra,12(sp)
            for(i=0;i<8;i++)
    2058:	00000713          	li	a4,0
    205c:	00700793          	li	a5,7
    2060:	02e7c063          	blt	a5,a4,2080 <bsp_printf_X+0x30>
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    2064:	00271693          	slli	a3,a4,0x2
    2068:	ff000793          	li	a5,-16
    206c:	00d797b3          	sll	a5,a5,a3
    2070:	00f577b3          	and	a5,a0,a5
    2074:	00078663          	beqz	a5,2080 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    2078:	00170713          	addi	a4,a4,1
    207c:	fe1ff06f          	j	205c <bsp_printf_X+0xc>
            bsp_printHex(val);
    2080:	e35ff0ef          	jal	ra,1eb4 <bsp_printHex>
        }
    2084:	00c12083          	lw	ra,12(sp)
    2088:	01010113          	addi	sp,sp,16
    208c:	00008067          	ret

00002090 <i2c_stop>:
    SDA_LOW();
    i2c_delay();
    SCL_LOW();
}

static void i2c_stop(void) {
    2090:	ff010113          	addi	sp,sp,-16
    2094:	00112623          	sw	ra,12(sp)
    2098:	00812423          	sw	s0,8(sp)
    209c:	00912223          	sw	s1,4(sp)
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
    20a0:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    20a4:	00100613          	li	a2,1
    20a8:	00442583          	lw	a1,4(s0)
    20ac:	00042503          	lw	a0,0(s0)
    20b0:	c01ff0ef          	jal	ra,1cb0 <pinMode>
static inline void SDA_LOW()  { digitalWrite(Wire.sda_bank, Wire.sda_pin, LOW);  }
    20b4:	00000613          	li	a2,0
    20b8:	00442583          	lw	a1,4(s0)
    20bc:	00042503          	lw	a0,0(s0)
    20c0:	c51ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    20c4:	f8b00637          	lui	a2,0xf8b00
    20c8:	05f5e4b7          	lui	s1,0x5f5e
    20cc:	10048593          	addi	a1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    20d0:	01042503          	lw	a0,16(s0)
    20d4:	d59ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    20d8:	00100613          	li	a2,1
    20dc:	00c42583          	lw	a1,12(s0)
    20e0:	00842503          	lw	a0,8(s0)
    20e4:	c2dff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    20e8:	f8b00637          	lui	a2,0xf8b00
    20ec:	10048593          	addi	a1,s1,256
    20f0:	01042503          	lw	a0,16(s0)
    20f4:	d39ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
    20f8:	00100613          	li	a2,1
    20fc:	00442583          	lw	a1,4(s0)
    2100:	00042503          	lw	a0,0(s0)
    2104:	c0dff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2108:	f8b00637          	lui	a2,0xf8b00
    210c:	10048593          	addi	a1,s1,256
    2110:	01042503          	lw	a0,16(s0)
    2114:	d19ff0ef          	jal	ra,1e2c <clint_uDelay>
    i2c_delay();
    SCL_HIGH();
    i2c_delay();
    SDA_HIGH();
    i2c_delay();
}
    2118:	00c12083          	lw	ra,12(sp)
    211c:	00812403          	lw	s0,8(sp)
    2120:	00412483          	lw	s1,4(sp)
    2124:	01010113          	addi	sp,sp,16
    2128:	00008067          	ret

0000212c <i2c_start>:
static void i2c_start(void) {
    212c:	ff010113          	addi	sp,sp,-16
    2130:	00112623          	sw	ra,12(sp)
    2134:	00812423          	sw	s0,8(sp)
    2138:	00912223          	sw	s1,4(sp)
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
    213c:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    2140:	00100613          	li	a2,1
    2144:	00442583          	lw	a1,4(s0)
    2148:	00042503          	lw	a0,0(s0)
    214c:	b65ff0ef          	jal	ra,1cb0 <pinMode>
static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
    2150:	00100613          	li	a2,1
    2154:	00442583          	lw	a1,4(s0)
    2158:	00042503          	lw	a0,0(s0)
    215c:	bb5ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    2160:	00100613          	li	a2,1
    2164:	00c42583          	lw	a1,12(s0)
    2168:	00842503          	lw	a0,8(s0)
    216c:	ba5ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2170:	f8b00637          	lui	a2,0xf8b00
    2174:	05f5e4b7          	lui	s1,0x5f5e
    2178:	10048593          	addi	a1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    217c:	01042503          	lw	a0,16(s0)
    2180:	cadff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SDA_LOW()  { digitalWrite(Wire.sda_bank, Wire.sda_pin, LOW);  }
    2184:	00000613          	li	a2,0
    2188:	00442583          	lw	a1,4(s0)
    218c:	00042503          	lw	a0,0(s0)
    2190:	b81ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2194:	f8b00637          	lui	a2,0xf8b00
    2198:	10048593          	addi	a1,s1,256
    219c:	01042503          	lw	a0,16(s0)
    21a0:	c8dff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }
    21a4:	00000613          	li	a2,0
    21a8:	00c42583          	lw	a1,12(s0)
    21ac:	00842503          	lw	a0,8(s0)
    21b0:	b61ff0ef          	jal	ra,1d10 <digitalWrite>
}
    21b4:	00c12083          	lw	ra,12(sp)
    21b8:	00812403          	lw	s0,8(sp)
    21bc:	00412483          	lw	s1,4(sp)
    21c0:	01010113          	addi	sp,sp,16
    21c4:	00008067          	ret

000021c8 <i2c_write_byte>:

static uint8_t i2c_write_byte(uint8_t data) {
    21c8:	fe010113          	addi	sp,sp,-32
    21cc:	00112e23          	sw	ra,28(sp)
    21d0:	00812c23          	sw	s0,24(sp)
    21d4:	00912a23          	sw	s1,20(sp)
    21d8:	01212823          	sw	s2,16(sp)
    21dc:	01312623          	sw	s3,12(sp)
    21e0:	00050493          	mv	s1,a0
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
    21e4:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    21e8:	00100613          	li	a2,1
    21ec:	0047a583          	lw	a1,4(a5)
    21f0:	0007a503          	lw	a0,0(a5)
    21f4:	abdff0ef          	jal	ra,1cb0 <pinMode>
    SDA_OUT();
    for (int i = 0; i < 8; i++) {
    21f8:	00000913          	li	s2,0
    21fc:	06c0006f          	j	2268 <i2c_write_byte+0xa0>
static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
    2200:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    2204:	00100613          	li	a2,1
    2208:	0047a583          	lw	a1,4(a5)
    220c:	0007a503          	lw	a0,0(a5)
    2210:	b01ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2214:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    2218:	f8b00637          	lui	a2,0xf8b00
    221c:	05f5e9b7          	lui	s3,0x5f5e
    2220:	10098593          	addi	a1,s3,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    2224:	01042503          	lw	a0,16(s0)
    2228:	c05ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    222c:	00100613          	li	a2,1
    2230:	00c42583          	lw	a1,12(s0)
    2234:	00842503          	lw	a0,8(s0)
    2238:	ad9ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    223c:	f8b00637          	lui	a2,0xf8b00
    2240:	10098593          	addi	a1,s3,256
    2244:	01042503          	lw	a0,16(s0)
    2248:	be5ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }
    224c:	00000613          	li	a2,0
    2250:	00c42583          	lw	a1,12(s0)
    2254:	00842503          	lw	a0,8(s0)
    2258:	ab9ff0ef          	jal	ra,1d10 <digitalWrite>
        if (data & 0x80) SDA_HIGH(); else SDA_LOW();
        i2c_delay();
        SCL_HIGH();
        i2c_delay();
        SCL_LOW();
        data <<= 1;
    225c:	00149493          	slli	s1,s1,0x1
    2260:	0ff4f493          	andi	s1,s1,255
    for (int i = 0; i < 8; i++) {
    2264:	00190913          	addi	s2,s2,1
    2268:	00700793          	li	a5,7
    226c:	0327c463          	blt	a5,s2,2294 <i2c_write_byte+0xcc>
        if (data & 0x80) SDA_HIGH(); else SDA_LOW();
    2270:	01849793          	slli	a5,s1,0x18
    2274:	4187d793          	srai	a5,a5,0x18
    2278:	f807c4e3          	bltz	a5,2200 <i2c_write_byte+0x38>
static inline void SDA_LOW()  { digitalWrite(Wire.sda_bank, Wire.sda_pin, LOW);  }
    227c:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    2280:	00000613          	li	a2,0
    2284:	0047a583          	lw	a1,4(a5)
    2288:	0007a503          	lw	a0,0(a5)
    228c:	a85ff0ef          	jal	ra,1d10 <digitalWrite>
    2290:	f85ff06f          	j	2214 <i2c_write_byte+0x4c>
static inline void SDA_IN()  { pinMode(Wire.sda_bank, Wire.sda_pin, INPUT);  }
    2294:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    2298:	00000613          	li	a2,0
    229c:	00442583          	lw	a1,4(s0)
    22a0:	00042503          	lw	a0,0(s0)
    22a4:	a0dff0ef          	jal	ra,1cb0 <pinMode>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    22a8:	f8b00637          	lui	a2,0xf8b00
    22ac:	05f5e4b7          	lui	s1,0x5f5e
    22b0:	10048593          	addi	a1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    22b4:	01042503          	lw	a0,16(s0)
    22b8:	b75ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    22bc:	00100613          	li	a2,1
    22c0:	00c42583          	lw	a1,12(s0)
    22c4:	00842503          	lw	a0,8(s0)
    22c8:	a49ff0ef          	jal	ra,1d10 <digitalWrite>
    }
    // 读取ACK
    SDA_IN();
    i2c_delay();
    SCL_HIGH();
    uint8_t ack = !digitalRead(Wire.sda_bank, Wire.sda_pin);
    22cc:	00442583          	lw	a1,4(s0)
    22d0:	00042503          	lw	a0,0(s0)
    22d4:	a69ff0ef          	jal	ra,1d3c <digitalRead>
    22d8:	00153913          	seqz	s2,a0
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    22dc:	f8b00637          	lui	a2,0xf8b00
    22e0:	10048593          	addi	a1,s1,256
    22e4:	01042503          	lw	a0,16(s0)
    22e8:	b45ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }
    22ec:	00000613          	li	a2,0
    22f0:	00c42583          	lw	a1,12(s0)
    22f4:	00842503          	lw	a0,8(s0)
    22f8:	a19ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
    22fc:	00100613          	li	a2,1
    2300:	00442583          	lw	a1,4(s0)
    2304:	00042503          	lw	a0,0(s0)
    2308:	9a9ff0ef          	jal	ra,1cb0 <pinMode>
    i2c_delay();
    SCL_LOW();
    SDA_OUT();
    return ack;
}
    230c:	00090513          	mv	a0,s2
    2310:	01c12083          	lw	ra,28(sp)
    2314:	01812403          	lw	s0,24(sp)
    2318:	01412483          	lw	s1,20(sp)
    231c:	01012903          	lw	s2,16(sp)
    2320:	00c12983          	lw	s3,12(sp)
    2324:	02010113          	addi	sp,sp,32
    2328:	00008067          	ret

0000232c <i2c_read_byte>:

static uint8_t i2c_read_byte(uint8_t ack) {
    232c:	fe010113          	addi	sp,sp,-32
    2330:	00112e23          	sw	ra,28(sp)
    2334:	00812c23          	sw	s0,24(sp)
    2338:	00912a23          	sw	s1,20(sp)
    233c:	01212823          	sw	s2,16(sp)
    2340:	01312623          	sw	s3,12(sp)
    2344:	01412423          	sw	s4,8(sp)
    2348:	00050a13          	mv	s4,a0
static inline void SDA_IN()  { pinMode(Wire.sda_bank, Wire.sda_pin, INPUT);  }
    234c:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    2350:	00000613          	li	a2,0
    2354:	0047a583          	lw	a1,4(a5)
    2358:	0007a503          	lw	a0,0(a5)
    235c:	955ff0ef          	jal	ra,1cb0 <pinMode>
    uint8_t data = 0;
    SDA_IN();
    // 逐位读取：将第一次读到的 bit 放到最高位（MSB first）
    for (int i = 0; i < 8; i++) {
    2360:	00000913          	li	s2,0
    uint8_t data = 0;
    2364:	00000493          	li	s1,0
    for (int i = 0; i < 8; i++) {
    2368:	06c0006f          	j	23d4 <i2c_read_byte+0xa8>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    236c:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    2370:	00100613          	li	a2,1
    2374:	00c42583          	lw	a1,12(s0)
    2378:	00842503          	lw	a0,8(s0)
    237c:	995ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2380:	f8b00637          	lui	a2,0xf8b00
    2384:	05f5e9b7          	lui	s3,0x5f5e
    2388:	10098593          	addi	a1,s3,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    238c:	01042503          	lw	a0,16(s0)
    2390:	a9dff0ef          	jal	ra,1e2c <clint_uDelay>
        SCL_HIGH();
        i2c_delay();
        uint8_t bit = digitalRead(Wire.sda_bank, Wire.sda_pin) ? 1 : 0;
    2394:	00442583          	lw	a1,4(s0)
    2398:	00042503          	lw	a0,0(s0)
    239c:	9a1ff0ef          	jal	ra,1d3c <digitalRead>
    23a0:	00a03533          	snez	a0,a0
        data = (data << 1) | bit;
    23a4:	00149493          	slli	s1,s1,0x1
    23a8:	00a4e4b3          	or	s1,s1,a0
    23ac:	0ff4f493          	andi	s1,s1,255
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }
    23b0:	00000613          	li	a2,0
    23b4:	00c42583          	lw	a1,12(s0)
    23b8:	00842503          	lw	a0,8(s0)
    23bc:	955ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    23c0:	f8b00637          	lui	a2,0xf8b00
    23c4:	10098593          	addi	a1,s3,256
    23c8:	01042503          	lw	a0,16(s0)
    23cc:	a61ff0ef          	jal	ra,1e2c <clint_uDelay>
    for (int i = 0; i < 8; i++) {
    23d0:	00190913          	addi	s2,s2,1
    23d4:	00700793          	li	a5,7
    23d8:	f927dae3          	bge	a5,s2,236c <i2c_read_byte+0x40>
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
    23dc:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    23e0:	00100613          	li	a2,1
    23e4:	0047a583          	lw	a1,4(a5)
    23e8:	0007a503          	lw	a0,0(a5)
    23ec:	8c5ff0ef          	jal	ra,1cb0 <pinMode>
        SCL_LOW();
        i2c_delay();
    }
    // 发送 ACK/NACK（ACK -> SDA 拉低）
    SDA_OUT();
    if (ack) SDA_LOW(); else SDA_HIGH();
    23f0:	080a0263          	beqz	s4,2474 <i2c_read_byte+0x148>
static inline void SDA_LOW()  { digitalWrite(Wire.sda_bank, Wire.sda_pin, LOW);  }
    23f4:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    23f8:	00000613          	li	a2,0
    23fc:	0047a583          	lw	a1,4(a5)
    2400:	0007a503          	lw	a0,0(a5)
    2404:	90dff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2408:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    240c:	f8b00637          	lui	a2,0xf8b00
    2410:	05f5e937          	lui	s2,0x5f5e
    2414:	10090593          	addi	a1,s2,256 # 5f5e100 <__freertos_irq_stack_top+0x5d5b590>
    2418:	01042503          	lw	a0,16(s0)
    241c:	a11ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    2420:	00100613          	li	a2,1
    2424:	00c42583          	lw	a1,12(s0)
    2428:	00842503          	lw	a0,8(s0)
    242c:	8e5ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }
    2430:	f8b00637          	lui	a2,0xf8b00
    2434:	10090593          	addi	a1,s2,256
    2438:	01042503          	lw	a0,16(s0)
    243c:	9f1ff0ef          	jal	ra,1e2c <clint_uDelay>
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }
    2440:	00000613          	li	a2,0
    2444:	00c42583          	lw	a1,12(s0)
    2448:	00842503          	lw	a0,8(s0)
    244c:	8c5ff0ef          	jal	ra,1d10 <digitalWrite>
    i2c_delay();
    SCL_HIGH();
    i2c_delay();
    SCL_LOW();
    return data;
}
    2450:	00048513          	mv	a0,s1
    2454:	01c12083          	lw	ra,28(sp)
    2458:	01812403          	lw	s0,24(sp)
    245c:	01412483          	lw	s1,20(sp)
    2460:	01012903          	lw	s2,16(sp)
    2464:	00c12983          	lw	s3,12(sp)
    2468:	00812a03          	lw	s4,8(sp)
    246c:	02010113          	addi	sp,sp,32
    2470:	00008067          	ret
static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
    2474:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    2478:	00100613          	li	a2,1
    247c:	0047a583          	lw	a1,4(a5)
    2480:	0007a503          	lw	a0,0(a5)
    2484:	88dff0ef          	jal	ra,1d10 <digitalWrite>
    2488:	f81ff06f          	j	2408 <i2c_read_byte+0xdc>

0000248c <bsp_printf>:
    {
    248c:	fc010113          	addi	sp,sp,-64
    2490:	00112e23          	sw	ra,28(sp)
    2494:	00812c23          	sw	s0,24(sp)
    2498:	00912a23          	sw	s1,20(sp)
    249c:	00050493          	mv	s1,a0
    24a0:	02b12223          	sw	a1,36(sp)
    24a4:	02c12423          	sw	a2,40(sp)
    24a8:	02d12623          	sw	a3,44(sp)
    24ac:	02e12823          	sw	a4,48(sp)
    24b0:	02f12a23          	sw	a5,52(sp)
    24b4:	03012c23          	sw	a6,56(sp)
    24b8:	03112e23          	sw	a7,60(sp)
        va_start(ap, format);
    24bc:	02410793          	addi	a5,sp,36
    24c0:	00f12623          	sw	a5,12(sp)
        for (i = 0; format[i]; i++)
    24c4:	00000413          	li	s0,0
    24c8:	01c0006f          	j	24e4 <bsp_printf+0x58>
                        bsp_printf_c(va_arg(ap,int));
    24cc:	00c12783          	lw	a5,12(sp)
    24d0:	00478713          	addi	a4,a5,4
    24d4:	00e12623          	sw	a4,12(sp)
    24d8:	0007a503          	lw	a0,0(a5)
    24dc:	a81ff0ef          	jal	ra,1f5c <bsp_printf_c>
        for (i = 0; format[i]; i++)
    24e0:	00140413          	addi	s0,s0,1
    24e4:	008487b3          	add	a5,s1,s0
    24e8:	0007c503          	lbu	a0,0(a5)
    24ec:	0c050263          	beqz	a0,25b0 <bsp_printf+0x124>
            if (format[i] == '%') {
    24f0:	02500793          	li	a5,37
    24f4:	06f50663          	beq	a0,a5,2560 <bsp_printf+0xd4>
                bsp_printf_c(format[i]);
    24f8:	a65ff0ef          	jal	ra,1f5c <bsp_printf_c>
    24fc:	fe5ff06f          	j	24e0 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    2500:	00c12783          	lw	a5,12(sp)
    2504:	00478713          	addi	a4,a5,4
    2508:	00e12623          	sw	a4,12(sp)
    250c:	0007a503          	lw	a0,0(a5)
    2510:	a69ff0ef          	jal	ra,1f78 <bsp_printf_s>
                        break;
    2514:	fcdff06f          	j	24e0 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    2518:	00c12783          	lw	a5,12(sp)
    251c:	00478713          	addi	a4,a5,4
    2520:	00e12623          	sw	a4,12(sp)
    2524:	0007a503          	lw	a0,0(a5)
    2528:	a69ff0ef          	jal	ra,1f90 <bsp_printf_d>
                        break;
    252c:	fb5ff06f          	j	24e0 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    2530:	00c12783          	lw	a5,12(sp)
    2534:	00478713          	addi	a4,a5,4
    2538:	00e12623          	sw	a4,12(sp)
    253c:	0007a503          	lw	a0,0(a5)
    2540:	b11ff0ef          	jal	ra,2050 <bsp_printf_X>
                        break;
    2544:	f9dff06f          	j	24e0 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    2548:	00c12783          	lw	a5,12(sp)
    254c:	00478713          	addi	a4,a5,4
    2550:	00e12623          	sw	a4,12(sp)
    2554:	0007a503          	lw	a0,0(a5)
    2558:	ab9ff0ef          	jal	ra,2010 <bsp_printf_x>
                        break;
    255c:	f85ff06f          	j	24e0 <bsp_printf+0x54>
                while (format[++i]) {
    2560:	00140413          	addi	s0,s0,1
    2564:	008487b3          	add	a5,s1,s0
    2568:	0007c783          	lbu	a5,0(a5)
    256c:	f6078ae3          	beqz	a5,24e0 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    2570:	06300713          	li	a4,99
    2574:	f4e78ce3          	beq	a5,a4,24cc <bsp_printf+0x40>
                    else if (format[i] == 's') {
    2578:	07300713          	li	a4,115
    257c:	f8e782e3          	beq	a5,a4,2500 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    2580:	06400713          	li	a4,100
    2584:	f8e78ae3          	beq	a5,a4,2518 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    2588:	05800713          	li	a4,88
    258c:	fae782e3          	beq	a5,a4,2530 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    2590:	07800713          	li	a4,120
    2594:	fae78ae3          	beq	a5,a4,2548 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    2598:	06600713          	li	a4,102
    259c:	fce792e3          	bne	a5,a4,2560 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
    25a0:	00003537          	lui	a0,0x3
    25a4:	92050513          	addi	a0,a0,-1760 # 2920 <_data+0x28>
    25a8:	9d1ff0ef          	jal	ra,1f78 <bsp_printf_s>
                        break;
    25ac:	f35ff06f          	j	24e0 <bsp_printf+0x54>
    }
    25b0:	01c12083          	lw	ra,28(sp)
    25b4:	01812403          	lw	s0,24(sp)
    25b8:	01412483          	lw	s1,20(sp)
    25bc:	04010113          	addi	sp,sp,64
    25c0:	00008067          	ret

000025c4 <Wire_begin>:

// --- 高层接口 ---
void Wire_begin(int sda, int scl) {
    25c4:	ff010113          	addi	sp,sp,-16
    25c8:	00112623          	sw	ra,12(sp)
    25cc:	00812423          	sw	s0,8(sp)
    Wire.sda_bank = GPIO_BANK1;
    25d0:	96c18413          	addi	s0,gp,-1684 # 2b5c <Wire>
    25d4:	f80167b7          	lui	a5,0xf8016
    25d8:	00f42023          	sw	a5,0(s0)
    Wire.scl_bank = GPIO_BANK1;
    25dc:	00f42423          	sw	a5,8(s0)
    Wire.sda_pin = sda;
    25e0:	00a42223          	sw	a0,4(s0)
    Wire.scl_pin = scl;
    25e4:	00b42623          	sw	a1,12(s0)
    Wire.delay_us = I2C_DELAY_US_DEFAULT;
    25e8:	00500793          	li	a5,5
    25ec:	00f42823          	sw	a5,16(s0)

    pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT);
    25f0:	00100613          	li	a2,1
    25f4:	00050593          	mv	a1,a0
    25f8:	f8016537          	lui	a0,0xf8016
    25fc:	eb4ff0ef          	jal	ra,1cb0 <pinMode>
    pinMode(Wire.scl_bank, Wire.scl_pin, OUTPUT);
    2600:	00100613          	li	a2,1
    2604:	00c42583          	lw	a1,12(s0)
    2608:	00842503          	lw	a0,8(s0)
    260c:	ea4ff0ef          	jal	ra,1cb0 <pinMode>
static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
    2610:	00100613          	li	a2,1
    2614:	00442583          	lw	a1,4(s0)
    2618:	00042503          	lw	a0,0(s0)
    261c:	ef4ff0ef          	jal	ra,1d10 <digitalWrite>
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
    2620:	00100613          	li	a2,1
    2624:	00c42583          	lw	a1,12(s0)
    2628:	00842503          	lw	a0,8(s0)
    262c:	ee4ff0ef          	jal	ra,1d10 <digitalWrite>
    SDA_HIGH();
    SCL_HIGH();
}
    2630:	00c12083          	lw	ra,12(sp)
    2634:	00812403          	lw	s0,8(sp)
    2638:	01010113          	addi	sp,sp,16
    263c:	00008067          	ret

00002640 <Wire_setClock>:

void Wire_setClock(uint32_t freq_hz) {
    // 简单近似：根据频率反算延时
    if (freq_hz >= 400000) Wire.delay_us = 1;   // 400kHz
    2640:	000627b7          	lui	a5,0x62
    2644:	a7f78793          	addi	a5,a5,-1409 # 61a7f <__global_pointer$+0x5e88f>
    2648:	00a7fa63          	bgeu	a5,a0,265c <Wire_setClock+0x1c>
    264c:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    2650:	00100713          	li	a4,1
    2654:	00e7a823          	sw	a4,16(a5)
    2658:	00008067          	ret
    else if (freq_hz >= 100000) Wire.delay_us = 5; // 100kHz
    265c:	000187b7          	lui	a5,0x18
    2660:	69f78793          	addi	a5,a5,1695 # 1869f <__global_pointer$+0x154af>
    2664:	00a7fa63          	bgeu	a5,a0,2678 <Wire_setClock+0x38>
    2668:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    266c:	00500713          	li	a4,5
    2670:	00e7a823          	sw	a4,16(a5)
    2674:	00008067          	ret
    else Wire.delay_us = 10;
    2678:	96c18793          	addi	a5,gp,-1684 # 2b5c <Wire>
    267c:	00a00713          	li	a4,10
    2680:	00e7a823          	sw	a4,16(a5)
}
    2684:	00008067          	ret

00002688 <Wire_beginTransmission>:

void Wire_beginTransmission(uint8_t address) {
    2688:	ff010113          	addi	sp,sp,-16
    268c:	00112623          	sw	ra,12(sp)
    2690:	00812423          	sw	s0,8(sp)
    device_addr = address << 1;
    2694:	00151513          	slli	a0,a0,0x1
    2698:	82a18223          	sb	a0,-2012(gp) # 2a14 <device_addr>
    i2c_start();
    269c:	a91ff0ef          	jal	ra,212c <i2c_start>
    if (!i2c_write_byte(device_addr)) {
    26a0:	8241c503          	lbu	a0,-2012(gp) # 2a14 <device_addr>
    26a4:	b25ff0ef          	jal	ra,21c8 <i2c_write_byte>
    26a8:	00050a63          	beqz	a0,26bc <Wire_beginTransmission+0x34>
        bsp_printf("I2C NACK at addr write\r\n");
    }
}
    26ac:	00c12083          	lw	ra,12(sp)
    26b0:	00812403          	lw	s0,8(sp)
    26b4:	01010113          	addi	sp,sp,16
    26b8:	00008067          	ret
        bsp_printf("I2C NACK at addr write\r\n");
    26bc:	00003537          	lui	a0,0x3
    26c0:	9b850513          	addi	a0,a0,-1608 # 29b8 <_data+0xc0>
    26c4:	dc9ff0ef          	jal	ra,248c <bsp_printf>
}
    26c8:	fe5ff06f          	j	26ac <Wire_beginTransmission+0x24>

000026cc <Wire_write>:

uint8_t Wire_write(uint8_t data) {
    26cc:	ff010113          	addi	sp,sp,-16
    26d0:	00112623          	sw	ra,12(sp)
    26d4:	00812423          	sw	s0,8(sp)
    if (!i2c_write_byte(data)) {
    26d8:	af1ff0ef          	jal	ra,21c8 <i2c_write_byte>
    26dc:	00050e63          	beqz	a0,26f8 <Wire_write+0x2c>
        bsp_printf("I2C NACK data\r\n");
        return 0;
    }
    return 1;
    26e0:	00100413          	li	s0,1
}
    26e4:	00040513          	mv	a0,s0
    26e8:	00c12083          	lw	ra,12(sp)
    26ec:	00812403          	lw	s0,8(sp)
    26f0:	01010113          	addi	sp,sp,16
    26f4:	00008067          	ret
    26f8:	00050413          	mv	s0,a0
        bsp_printf("I2C NACK data\r\n");
    26fc:	00003537          	lui	a0,0x3
    2700:	9d450513          	addi	a0,a0,-1580 # 29d4 <_data+0xdc>
    2704:	d89ff0ef          	jal	ra,248c <bsp_printf>
        return 0;
    2708:	fddff06f          	j	26e4 <Wire_write+0x18>

0000270c <Wire_writeBytes>:

uint8_t Wire_writeBytes(const uint8_t *data, uint8_t len) {
    270c:	ff010113          	addi	sp,sp,-16
    2710:	00112623          	sw	ra,12(sp)
    2714:	00812423          	sw	s0,8(sp)
    2718:	00912223          	sw	s1,4(sp)
    271c:	01212023          	sw	s2,0(sp)
    2720:	00050913          	mv	s2,a0
    2724:	00058493          	mv	s1,a1
    uint8_t count = 0;
    2728:	00000413          	li	s0,0
    for (uint8_t i = 0; i < len; i++) {
    272c:	02947063          	bgeu	s0,s1,274c <Wire_writeBytes+0x40>
        if (i2c_write_byte(data[i])) count++;
    2730:	008907b3          	add	a5,s2,s0
    2734:	0007c503          	lbu	a0,0(a5)
    2738:	a91ff0ef          	jal	ra,21c8 <i2c_write_byte>
    273c:	00050863          	beqz	a0,274c <Wire_writeBytes+0x40>
    2740:	00140413          	addi	s0,s0,1
    2744:	0ff47413          	andi	s0,s0,255
    2748:	fe5ff06f          	j	272c <Wire_writeBytes+0x20>
        else break;
    }
    return count;
}
    274c:	00040513          	mv	a0,s0
    2750:	00c12083          	lw	ra,12(sp)
    2754:	00812403          	lw	s0,8(sp)
    2758:	00412483          	lw	s1,4(sp)
    275c:	00012903          	lw	s2,0(sp)
    2760:	01010113          	addi	sp,sp,16
    2764:	00008067          	ret

00002768 <Wire_endTransmission>:

uint8_t Wire_endTransmission(void) {
    2768:	ff010113          	addi	sp,sp,-16
    276c:	00112623          	sw	ra,12(sp)
    i2c_stop();
    2770:	921ff0ef          	jal	ra,2090 <i2c_stop>
    return 0; // 0 表示成功
}
    2774:	00000513          	li	a0,0
    2778:	00c12083          	lw	ra,12(sp)
    277c:	01010113          	addi	sp,sp,16
    2780:	00008067          	ret

00002784 <Wire_requestFrom>:

uint8_t Wire_requestFrom(uint8_t address, uint8_t length) {
    2784:	ff010113          	addi	sp,sp,-16
    2788:	00112623          	sw	ra,12(sp)
    278c:	00812423          	sw	s0,8(sp)
    2790:	00912223          	sw	s1,4(sp)
    2794:	00050413          	mv	s0,a0
    2798:	00058493          	mv	s1,a1
    if (length > sizeof(rx_buffer)) length = sizeof(rx_buffer);
    279c:	04000793          	li	a5,64
    27a0:	00b7f463          	bgeu	a5,a1,27a8 <Wire_requestFrom+0x24>
    27a4:	04000493          	li	s1,64
    i2c_start();
    27a8:	985ff0ef          	jal	ra,212c <i2c_start>
    if (!i2c_write_byte((address << 1) | 1)) {
    27ac:	00141513          	slli	a0,s0,0x1
    27b0:	00156513          	ori	a0,a0,1
    27b4:	0ff57513          	andi	a0,a0,255
    27b8:	a11ff0ef          	jal	ra,21c8 <i2c_write_byte>
    27bc:	00050413          	mv	s0,a0
    27c0:	02050c63          	beqz	a0,27f8 <Wire_requestFrom+0x74>
        bsp_printf("I2C NACK at addr read\r\n");
        i2c_stop();
        return 0;
    }
    rx_len = length;
    27c4:	82918323          	sb	s1,-2010(gp) # 2a16 <rx_len>
    rx_index = 0;
    27c8:	820182a3          	sb	zero,-2011(gp) # 2a15 <rx_index>
    for (uint8_t i = 0; i < length; i++) {
    27cc:	00000413          	li	s0,0
    27d0:	02947e63          	bgeu	s0,s1,280c <Wire_requestFrom+0x88>
        rx_buffer[i] = i2c_read_byte(i < (length - 1));
    27d4:	fff48513          	addi	a0,s1,-1
    27d8:	00a42533          	slt	a0,s0,a0
    27dc:	b51ff0ef          	jal	ra,232c <i2c_read_byte>
    27e0:	82818793          	addi	a5,gp,-2008 # 2a18 <rx_buffer>
    27e4:	008787b3          	add	a5,a5,s0
    27e8:	00a78023          	sb	a0,0(a5)
    for (uint8_t i = 0; i < length; i++) {
    27ec:	00140413          	addi	s0,s0,1
    27f0:	0ff47413          	andi	s0,s0,255
    27f4:	fddff06f          	j	27d0 <Wire_requestFrom+0x4c>
        bsp_printf("I2C NACK at addr read\r\n");
    27f8:	00003537          	lui	a0,0x3
    27fc:	9e450513          	addi	a0,a0,-1564 # 29e4 <_data+0xec>
    2800:	c8dff0ef          	jal	ra,248c <bsp_printf>
        i2c_stop();
    2804:	88dff0ef          	jal	ra,2090 <i2c_stop>
        return 0;
    2808:	00c0006f          	j	2814 <Wire_requestFrom+0x90>
    }
    i2c_stop();
    280c:	885ff0ef          	jal	ra,2090 <i2c_stop>
    return rx_len;
    2810:	8261c403          	lbu	s0,-2010(gp) # 2a16 <rx_len>
}
    2814:	00040513          	mv	a0,s0
    2818:	00c12083          	lw	ra,12(sp)
    281c:	00812403          	lw	s0,8(sp)
    2820:	00412483          	lw	s1,4(sp)
    2824:	01010113          	addi	sp,sp,16
    2828:	00008067          	ret

0000282c <Wire_read>:

int Wire_read(void) {
    if (rx_index < rx_len) return rx_buffer[rx_index++];
    282c:	8251c703          	lbu	a4,-2011(gp) # 2a15 <rx_index>
    2830:	8261c783          	lbu	a5,-2010(gp) # 2a16 <rx_len>
    2834:	00f77e63          	bgeu	a4,a5,2850 <Wire_read+0x24>
    2838:	00170693          	addi	a3,a4,1
    283c:	82d182a3          	sb	a3,-2011(gp) # 2a15 <rx_index>
    2840:	82818793          	addi	a5,gp,-2008 # 2a18 <rx_buffer>
    2844:	00e787b3          	add	a5,a5,a4
    2848:	0007c503          	lbu	a0,0(a5)
    284c:	00008067          	ret
    else return -1;
    2850:	fff00513          	li	a0,-1
}
    2854:	00008067          	ret

00002858 <Wire_available>:

int Wire_available(void) {
    return (rx_index < rx_len);
    2858:	8251c503          	lbu	a0,-2011(gp) # 2a15 <rx_index>
    285c:	8261c783          	lbu	a5,-2010(gp) # 2a16 <rx_len>
}
    2860:	00f53533          	sltu	a0,a0,a5
    2864:	00008067          	ret

00002868 <trap_entry>:
.global  trap_entry
.align(2) //mtvec require 32 bits allignement
trap_entry:
  addi sp,sp, -16*4
    2868:	fc010113          	addi	sp,sp,-64
  sw x1,   0*4(sp)
    286c:	00112023          	sw	ra,0(sp)
  sw x5,   1*4(sp)
    2870:	00512223          	sw	t0,4(sp)
  sw x6,   2*4(sp)
    2874:	00612423          	sw	t1,8(sp)
  sw x7,   3*4(sp)
    2878:	00712623          	sw	t2,12(sp)
  sw x10,  4*4(sp)
    287c:	00a12823          	sw	a0,16(sp)
  sw x11,  5*4(sp)
    2880:	00b12a23          	sw	a1,20(sp)
  sw x12,  6*4(sp)
    2884:	00c12c23          	sw	a2,24(sp)
  sw x13,  7*4(sp)
    2888:	00d12e23          	sw	a3,28(sp)
  sw x14,  8*4(sp)
    288c:	02e12023          	sw	a4,32(sp)
  sw x15,  9*4(sp)
    2890:	02f12223          	sw	a5,36(sp)
  sw x16, 10*4(sp)
    2894:	03012423          	sw	a6,40(sp)
  sw x17, 11*4(sp)
    2898:	03112623          	sw	a7,44(sp)
  sw x28, 12*4(sp)
    289c:	03c12823          	sw	t3,48(sp)
  sw x29, 13*4(sp)
    28a0:	03d12a23          	sw	t4,52(sp)
  sw x30, 14*4(sp)
    28a4:	03e12c23          	sw	t5,56(sp)
  sw x31, 15*4(sp)
    28a8:	03f12e23          	sw	t6,60(sp)
  call trap
    28ac:	ab8ff0ef          	jal	ra,1b64 <trap>
  lw x1 ,  0*4(sp)
    28b0:	00012083          	lw	ra,0(sp)
  lw x5,   1*4(sp)
    28b4:	00412283          	lw	t0,4(sp)
  lw x6,   2*4(sp)
    28b8:	00812303          	lw	t1,8(sp)
  lw x7,   3*4(sp)
    28bc:	00c12383          	lw	t2,12(sp)
  lw x10,  4*4(sp)
    28c0:	01012503          	lw	a0,16(sp)
  lw x11,  5*4(sp)
    28c4:	01412583          	lw	a1,20(sp)
  lw x12,  6*4(sp)
    28c8:	01812603          	lw	a2,24(sp)
  lw x13,  7*4(sp)
    28cc:	01c12683          	lw	a3,28(sp)
  lw x14,  8*4(sp)
    28d0:	02012703          	lw	a4,32(sp)
  lw x15,  9*4(sp)
    28d4:	02412783          	lw	a5,36(sp)
  lw x16, 10*4(sp)
    28d8:	02812803          	lw	a6,40(sp)
  lw x17, 11*4(sp)
    28dc:	02c12883          	lw	a7,44(sp)
  lw x28, 12*4(sp)
    28e0:	03012e03          	lw	t3,48(sp)
  lw x29, 13*4(sp)
    28e4:	03412e83          	lw	t4,52(sp)
  lw x30, 14*4(sp)
    28e8:	03812f03          	lw	t5,56(sp)
  lw x31, 15*4(sp)
    28ec:	03c12f83          	lw	t6,60(sp)
  addi sp,sp, 16*4
    28f0:	04010113          	addi	sp,sp,64
  mret
    28f4:	30200073          	mret
