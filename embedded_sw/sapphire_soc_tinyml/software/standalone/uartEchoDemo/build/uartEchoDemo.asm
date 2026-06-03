
build/uartEchoDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00006197          	auipc	gp,0x6
    1004:	b9818193          	addi	gp,gp,-1128 # 6b98 <__global_pointer$>

00001008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
    1008:	00205117          	auipc	sp,0x205
    100c:	3c810113          	addi	sp,sp,968 # 2063d0 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1010:	00005517          	auipc	a0,0x5
    1014:	c0c50513          	addi	a0,a0,-1012 # 5c1c <_data>
	la a1, _data
    1018:	00005597          	auipc	a1,0x5
    101c:	c0458593          	addi	a1,a1,-1020 # 5c1c <_data>
	la a2, _edata
    1020:	83418613          	addi	a2,gp,-1996 # 63cc <__bss_start>
	bgeu a1, a2, 2f
    1024:	00c5fc63          	bgeu	a1,a2,103c <init+0x34>
1:
	lw t0, (a0)
    1028:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
    102c:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
    1030:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
    1034:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
    1038:	fec5e8e3          	bltu	a1,a2,1028 <init+0x20>
2:

	/* Clear bss section */
	la a0, __bss_start
    103c:	83418513          	addi	a0,gp,-1996 # 63cc <__bss_start>
	la a1, _end
    1040:	83818593          	addi	a1,gp,-1992 # 63d0 <_end>
	bgeu a0, a1, 2f
    1044:	00b57863          	bgeu	a0,a1,1054 <init+0x4c>
1:
	sw zero, (a0)
    1048:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
    104c:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
    1050:	feb56ce3          	bltu	a0,a1,1048 <init+0x40>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
    1054:	0c0000ef          	jal	ra,1114 <__libc_init_array>
#endif

	call main
    1058:	1e1000ef          	jal	ra,1a38 <main>

0000105c <mainDone>:
mainDone:
    j mainDone
    105c:	0000006f          	j	105c <mainDone>

00001060 <_init>:


	.globl _init
_init:
    ret
    1060:	00008067          	ret

Disassembly of section .text:

00001064 <strcpy>:
    1064:	00b567b3          	or	a5,a0,a1
    1068:	0037f793          	andi	a5,a5,3
    106c:	08079263          	bnez	a5,10f0 <strcpy+0x8c>
    1070:	0005a703          	lw	a4,0(a1)
    1074:	7f7f86b7          	lui	a3,0x7f7f8
    1078:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5f1baf>
    107c:	00d777b3          	and	a5,a4,a3
    1080:	00d787b3          	add	a5,a5,a3
    1084:	00e7e7b3          	or	a5,a5,a4
    1088:	00d7e7b3          	or	a5,a5,a3
    108c:	fff00613          	li	a2,-1
    1090:	06c79e63          	bne	a5,a2,110c <strcpy+0xa8>
    1094:	00050613          	mv	a2,a0
    1098:	fff00813          	li	a6,-1
    109c:	00460613          	addi	a2,a2,4
    10a0:	00458593          	addi	a1,a1,4
    10a4:	fee62e23          	sw	a4,-4(a2)
    10a8:	0005a703          	lw	a4,0(a1)
    10ac:	00d777b3          	and	a5,a4,a3
    10b0:	00d787b3          	add	a5,a5,a3
    10b4:	00e7e7b3          	or	a5,a5,a4
    10b8:	00d7e7b3          	or	a5,a5,a3
    10bc:	ff0780e3          	beq	a5,a6,109c <strcpy+0x38>
    10c0:	0005c783          	lbu	a5,0(a1)
    10c4:	0015c703          	lbu	a4,1(a1)
    10c8:	0025c683          	lbu	a3,2(a1)
    10cc:	00f60023          	sb	a5,0(a2)
    10d0:	00078a63          	beqz	a5,10e4 <strcpy+0x80>
    10d4:	00e600a3          	sb	a4,1(a2)
    10d8:	00070663          	beqz	a4,10e4 <strcpy+0x80>
    10dc:	00d60123          	sb	a3,2(a2)
    10e0:	00069463          	bnez	a3,10e8 <strcpy+0x84>
    10e4:	00008067          	ret
    10e8:	000601a3          	sb	zero,3(a2)
    10ec:	00008067          	ret
    10f0:	00050793          	mv	a5,a0
    10f4:	0005c703          	lbu	a4,0(a1)
    10f8:	00178793          	addi	a5,a5,1
    10fc:	00158593          	addi	a1,a1,1
    1100:	fee78fa3          	sb	a4,-1(a5)
    1104:	fe0718e3          	bnez	a4,10f4 <strcpy+0x90>
    1108:	00008067          	ret
    110c:	00050613          	mv	a2,a0
    1110:	fb1ff06f          	j	10c0 <strcpy+0x5c>

00001114 <__libc_init_array>:
    1114:	ff010113          	addi	sp,sp,-16
    1118:	00812423          	sw	s0,8(sp)
    111c:	01212023          	sw	s2,0(sp)
    1120:	00005417          	auipc	s0,0x5
    1124:	afc40413          	addi	s0,s0,-1284 # 5c1c <_data>
    1128:	00005917          	auipc	s2,0x5
    112c:	af490913          	addi	s2,s2,-1292 # 5c1c <_data>
    1130:	40890933          	sub	s2,s2,s0
    1134:	00112623          	sw	ra,12(sp)
    1138:	00912223          	sw	s1,4(sp)
    113c:	40295913          	srai	s2,s2,0x2
    1140:	00090e63          	beqz	s2,115c <__libc_init_array+0x48>
    1144:	00000493          	li	s1,0
    1148:	00042783          	lw	a5,0(s0)
    114c:	00148493          	addi	s1,s1,1
    1150:	00440413          	addi	s0,s0,4
    1154:	000780e7          	jalr	a5
    1158:	fe9918e3          	bne	s2,s1,1148 <__libc_init_array+0x34>
    115c:	00005417          	auipc	s0,0x5
    1160:	ac040413          	addi	s0,s0,-1344 # 5c1c <_data>
    1164:	00005917          	auipc	s2,0x5
    1168:	ab890913          	addi	s2,s2,-1352 # 5c1c <_data>
    116c:	40890933          	sub	s2,s2,s0
    1170:	40295913          	srai	s2,s2,0x2
    1174:	00090e63          	beqz	s2,1190 <__libc_init_array+0x7c>
    1178:	00000493          	li	s1,0
    117c:	00042783          	lw	a5,0(s0)
    1180:	00148493          	addi	s1,s1,1
    1184:	00440413          	addi	s0,s0,4
    1188:	000780e7          	jalr	a5
    118c:	fe9918e3          	bne	s2,s1,117c <__libc_init_array+0x68>
    1190:	00c12083          	lw	ra,12(sp)
    1194:	00812403          	lw	s0,8(sp)
    1198:	00412483          	lw	s1,4(sp)
    119c:	00012903          	lw	s2,0(sp)
    11a0:	01010113          	addi	sp,sp,16
    11a4:	00008067          	ret

000011a8 <strcat>:
    11a8:	ff010113          	addi	sp,sp,-16
    11ac:	00812423          	sw	s0,8(sp)
    11b0:	00112623          	sw	ra,12(sp)
    11b4:	00357793          	andi	a5,a0,3
    11b8:	00050413          	mv	s0,a0
    11bc:	06079663          	bnez	a5,1228 <strcat+0x80>
    11c0:	00052703          	lw	a4,0(a0)
    11c4:	feff0637          	lui	a2,0xfeff0
    11c8:	eff60613          	addi	a2,a2,-257 # fefefeff <__freertos_irq_stack_top+0xfede9b2f>
    11cc:	00c707b3          	add	a5,a4,a2
    11d0:	808086b7          	lui	a3,0x80808
    11d4:	fff74713          	not	a4,a4
    11d8:	08068693          	addi	a3,a3,128 # 80808080 <__freertos_irq_stack_top+0x80601cb0>
    11dc:	00e7f7b3          	and	a5,a5,a4
    11e0:	00d7f7b3          	and	a5,a5,a3
    11e4:	04079263          	bnez	a5,1228 <strcat+0x80>
    11e8:	00450513          	addi	a0,a0,4
    11ec:	00052703          	lw	a4,0(a0)
    11f0:	00c707b3          	add	a5,a4,a2
    11f4:	fff74713          	not	a4,a4
    11f8:	00e7f7b3          	and	a5,a5,a4
    11fc:	00d7f7b3          	and	a5,a5,a3
    1200:	02079463          	bnez	a5,1228 <strcat+0x80>
    1204:	00450513          	addi	a0,a0,4
    1208:	00052703          	lw	a4,0(a0)
    120c:	00c707b3          	add	a5,a4,a2
    1210:	fff74713          	not	a4,a4
    1214:	00e7f7b3          	and	a5,a5,a4
    1218:	00d7f7b3          	and	a5,a5,a3
    121c:	fc0786e3          	beqz	a5,11e8 <strcat+0x40>
    1220:	0080006f          	j	1228 <strcat+0x80>
    1224:	00150513          	addi	a0,a0,1
    1228:	00054783          	lbu	a5,0(a0)
    122c:	fe079ce3          	bnez	a5,1224 <strcat+0x7c>
    1230:	e35ff0ef          	jal	ra,1064 <strcpy>
    1234:	00040513          	mv	a0,s0
    1238:	00c12083          	lw	ra,12(sp)
    123c:	00812403          	lw	s0,8(sp)
    1240:	01010113          	addi	sp,sp,16
    1244:	00008067          	ret

00001248 <strlen>:
    1248:	00357793          	andi	a5,a0,3
    124c:	00050713          	mv	a4,a0
    1250:	04079c63          	bnez	a5,12a8 <strlen+0x60>
    1254:	7f7f86b7          	lui	a3,0x7f7f8
    1258:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5f1baf>
    125c:	fff00593          	li	a1,-1
    1260:	00470713          	addi	a4,a4,4
    1264:	ffc72603          	lw	a2,-4(a4)
    1268:	00d677b3          	and	a5,a2,a3
    126c:	00d787b3          	add	a5,a5,a3
    1270:	00c7e7b3          	or	a5,a5,a2
    1274:	00d7e7b3          	or	a5,a5,a3
    1278:	feb784e3          	beq	a5,a1,1260 <strlen+0x18>
    127c:	ffc74683          	lbu	a3,-4(a4)
    1280:	40a707b3          	sub	a5,a4,a0
    1284:	ffd74603          	lbu	a2,-3(a4)
    1288:	ffe74503          	lbu	a0,-2(a4)
    128c:	04068063          	beqz	a3,12cc <strlen+0x84>
    1290:	02060a63          	beqz	a2,12c4 <strlen+0x7c>
    1294:	00a03533          	snez	a0,a0
    1298:	00f50533          	add	a0,a0,a5
    129c:	ffe50513          	addi	a0,a0,-2
    12a0:	00008067          	ret
    12a4:	fa0688e3          	beqz	a3,1254 <strlen+0xc>
    12a8:	00074783          	lbu	a5,0(a4)
    12ac:	00170713          	addi	a4,a4,1
    12b0:	00377693          	andi	a3,a4,3
    12b4:	fe0798e3          	bnez	a5,12a4 <strlen+0x5c>
    12b8:	40a70733          	sub	a4,a4,a0
    12bc:	fff70513          	addi	a0,a4,-1
    12c0:	00008067          	ret
    12c4:	ffd78513          	addi	a0,a5,-3
    12c8:	00008067          	ret
    12cc:	ffc78513          	addi	a0,a5,-4
    12d0:	00008067          	ret

000012d4 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    12d4:	00452503          	lw	a0,4(a0)
        enum UartStop stop;
        u32 clockDivider;
    } Uart_Config;
    
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    12d8:	01055513          	srli	a0,a0,0x10
    }
    12dc:	0ff57513          	andi	a0,a0,255
    12e0:	00008067          	ret

000012e4 <uart_readOccupancy>:
    12e4:	00452503          	lw	a0,4(a0)
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
    12e8:	01855513          	srli	a0,a0,0x18
    12ec:	00008067          	ret

000012f0 <uart_write>:
    
    static void uart_write(u32 reg, char data){
    12f0:	ff010113          	addi	sp,sp,-16
    12f4:	00112623          	sw	ra,12(sp)
    12f8:	00812423          	sw	s0,8(sp)
    12fc:	00912223          	sw	s1,4(sp)
    1300:	00050413          	mv	s0,a0
    1304:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    1308:	00040513          	mv	a0,s0
    130c:	fc9ff0ef          	jal	ra,12d4 <uart_writeAvailability>
    1310:	fe050ce3          	beqz	a0,1308 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    1314:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    1318:	00c12083          	lw	ra,12(sp)
    131c:	00812403          	lw	s0,8(sp)
    1320:	00412483          	lw	s1,4(sp)
    1324:	01010113          	addi	sp,sp,16
    1328:	00008067          	ret

0000132c <uart_read>:
    
    static void uart_writeStr(u32 reg, const char* str){
        while(*str) uart_write(reg, *str++);
    }
    
    static char uart_read(u32 reg){
    132c:	ff010113          	addi	sp,sp,-16
    1330:	00112623          	sw	ra,12(sp)
    1334:	00812423          	sw	s0,8(sp)
    1338:	00050413          	mv	s0,a0
        while(uart_readOccupancy(reg) == 0);
    133c:	00040513          	mv	a0,s0
    1340:	fa5ff0ef          	jal	ra,12e4 <uart_readOccupancy>
    1344:	fe050ce3          	beqz	a0,133c <uart_read+0x10>
        return *((volatile u32*) address);
    1348:	00042503          	lw	a0,0(s0)
        return read_u32(reg + UART_DATA);
    }
    134c:	0ff57513          	andi	a0,a0,255
    1350:	00c12083          	lw	ra,12(sp)
    1354:	00812403          	lw	s0,8(sp)
    1358:	01010113          	addi	sp,sp,16
    135c:	00008067          	ret

00001360 <uart_applyConfig>:
    
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
    1360:	00c5a783          	lw	a5,12(a1)
        *((volatile u32*) address) = data;
    1364:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
    1368:	0005a783          	lw	a5,0(a1)
    136c:	fff78793          	addi	a5,a5,-1
    1370:	0045a703          	lw	a4,4(a1)
    1374:	00871713          	slli	a4,a4,0x8
    1378:	00e7e7b3          	or	a5,a5,a4
    137c:	0085a703          	lw	a4,8(a1)
    1380:	01071713          	slli	a4,a4,0x10
    1384:	00e7e7b3          	or	a5,a5,a4
    1388:	00f52623          	sw	a5,12(a0)
    }
    138c:	00008067          	ret

00001390 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    1390:	ff010113          	addi	sp,sp,-16
    1394:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    1398:	00050593          	mv	a1,a0
    139c:	f8010537          	lui	a0,0xf8010
    13a0:	f51ff0ef          	jal	ra,12f0 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    13a4:	00c12083          	lw	ra,12(sp)
    13a8:	01010113          	addi	sp,sp,16
    13ac:	00008067          	ret

000013b0 <_putchar_s>:

    static void _putchar_s(char *p)
    {
    13b0:	ff010113          	addi	sp,sp,-16
    13b4:	00112623          	sw	ra,12(sp)
    13b8:	00812423          	sw	s0,8(sp)
    13bc:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    13c0:	00044503          	lbu	a0,0(s0)
    13c4:	00050863          	beqz	a0,13d4 <_putchar_s+0x24>
            _putchar(*(p++));
    13c8:	00140413          	addi	s0,s0,1
    13cc:	fc5ff0ef          	jal	ra,1390 <_putchar>
    13d0:	ff1ff06f          	j	13c0 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    13d4:	00c12083          	lw	ra,12(sp)
    13d8:	00812403          	lw	s0,8(sp)
    13dc:	01010113          	addi	sp,sp,16
    13e0:	00008067          	ret

000013e4 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    13e4:	ff010113          	addi	sp,sp,-16
    13e8:	00112623          	sw	ra,12(sp)
    13ec:	00812423          	sw	s0,8(sp)
    13f0:	00912223          	sw	s1,4(sp)
    13f4:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    13f8:	01c00413          	li	s0,28
    13fc:	0240006f          	j	1420 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    1400:	0084d7b3          	srl	a5,s1,s0
    1404:	00f7f713          	andi	a4,a5,15
    1408:	000067b7          	lui	a5,0x6
    140c:	c2078793          	addi	a5,a5,-992 # 5c20 <_data+0x4>
    1410:	00e787b3          	add	a5,a5,a4
    1414:	0007c503          	lbu	a0,0(a5)
    1418:	f79ff0ef          	jal	ra,1390 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    141c:	ffc40413          	addi	s0,s0,-4
    1420:	fe0450e3          	bgez	s0,1400 <bsp_printHex+0x1c>
        }
    }
    1424:	00c12083          	lw	ra,12(sp)
    1428:	00812403          	lw	s0,8(sp)
    142c:	00412483          	lw	s1,4(sp)
    1430:	01010113          	addi	sp,sp,16
    1434:	00008067          	ret

00001438 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    1438:	ff010113          	addi	sp,sp,-16
    143c:	00112623          	sw	ra,12(sp)
    1440:	00812423          	sw	s0,8(sp)
    1444:	00912223          	sw	s1,4(sp)
    1448:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    144c:	01c00413          	li	s0,28
    1450:	0240006f          	j	1474 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    1454:	0084d7b3          	srl	a5,s1,s0
    1458:	00f7f713          	andi	a4,a5,15
    145c:	000067b7          	lui	a5,0x6
    1460:	c3478793          	addi	a5,a5,-972 # 5c34 <_data+0x18>
    1464:	00e787b3          	add	a5,a5,a4
    1468:	0007c503          	lbu	a0,0(a5)
    146c:	f25ff0ef          	jal	ra,1390 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1470:	ffc40413          	addi	s0,s0,-4
    1474:	fe0450e3          	bgez	s0,1454 <bsp_printHex_lower+0x1c>

        }
    }
    1478:	00c12083          	lw	ra,12(sp)
    147c:	00812403          	lw	s0,8(sp)
    1480:	00412483          	lw	s1,4(sp)
    1484:	01010113          	addi	sp,sp,16
    1488:	00008067          	ret

0000148c <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    148c:	ff010113          	addi	sp,sp,-16
    1490:	00112623          	sw	ra,12(sp)
        _putchar(c);
    1494:	0ff57513          	andi	a0,a0,255
    1498:	ef9ff0ef          	jal	ra,1390 <_putchar>
    }
    149c:	00c12083          	lw	ra,12(sp)
    14a0:	01010113          	addi	sp,sp,16
    14a4:	00008067          	ret

000014a8 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    14a8:	ff010113          	addi	sp,sp,-16
    14ac:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    14b0:	f01ff0ef          	jal	ra,13b0 <_putchar_s>
    }
    14b4:	00c12083          	lw	ra,12(sp)
    14b8:	01010113          	addi	sp,sp,16
    14bc:	00008067          	ret

000014c0 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    14c0:	fd010113          	addi	sp,sp,-48
    14c4:	02112623          	sw	ra,44(sp)
    14c8:	02812423          	sw	s0,40(sp)
    14cc:	02912223          	sw	s1,36(sp)
    14d0:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    14d4:	00054663          	bltz	a0,14e0 <bsp_printf_d+0x20>
    {
    14d8:	00010413          	mv	s0,sp
    14dc:	02c0006f          	j	1508 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    14e0:	02d00513          	li	a0,45
    14e4:	fa9ff0ef          	jal	ra,148c <bsp_printf_c>
            val = -val;
    14e8:	409004b3          	neg	s1,s1
    14ec:	fedff06f          	j	14d8 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    14f0:	00a00713          	li	a4,10
    14f4:	02e4e7b3          	rem	a5,s1,a4
    14f8:	03078793          	addi	a5,a5,48
    14fc:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    1500:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    1504:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    1508:	fe0494e3          	bnez	s1,14f0 <bsp_printf_d+0x30>
    150c:	00010793          	mv	a5,sp
    1510:	fef400e3          	beq	s0,a5,14f0 <bsp_printf_d+0x30>
    1514:	0100006f          	j	1524 <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
    1518:	fff40413          	addi	s0,s0,-1
    151c:	00044503          	lbu	a0,0(s0)
    1520:	f6dff0ef          	jal	ra,148c <bsp_printf_c>
        while (p != buffer)
    1524:	00010793          	mv	a5,sp
    1528:	fef418e3          	bne	s0,a5,1518 <bsp_printf_d+0x58>
    }
    152c:	02c12083          	lw	ra,44(sp)
    1530:	02812403          	lw	s0,40(sp)
    1534:	02412483          	lw	s1,36(sp)
    1538:	03010113          	addi	sp,sp,48
    153c:	00008067          	ret

00001540 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    1540:	ff010113          	addi	sp,sp,-16
    1544:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    1548:	00000713          	li	a4,0
    154c:	00700793          	li	a5,7
    1550:	02e7c063          	blt	a5,a4,1570 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1554:	00271693          	slli	a3,a4,0x2
    1558:	ff000793          	li	a5,-16
    155c:	00d797b3          	sll	a5,a5,a3
    1560:	00f577b3          	and	a5,a0,a5
    1564:	00078663          	beqz	a5,1570 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    1568:	00170713          	addi	a4,a4,1
    156c:	fe1ff06f          	j	154c <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    1570:	ec9ff0ef          	jal	ra,1438 <bsp_printHex_lower>
    }
    1574:	00c12083          	lw	ra,12(sp)
    1578:	01010113          	addi	sp,sp,16
    157c:	00008067          	ret

00001580 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    1580:	ff010113          	addi	sp,sp,-16
    1584:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    1588:	00000713          	li	a4,0
    158c:	00700793          	li	a5,7
    1590:	02e7c063          	blt	a5,a4,15b0 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1594:	00271693          	slli	a3,a4,0x2
    1598:	ff000793          	li	a5,-16
    159c:	00d797b3          	sll	a5,a5,a3
    15a0:	00f577b3          	and	a5,a0,a5
    15a4:	00078663          	beqz	a5,15b0 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    15a8:	00170713          	addi	a4,a4,1
    15ac:	fe1ff06f          	j	158c <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    15b0:	e35ff0ef          	jal	ra,13e4 <bsp_printHex>
        }
    15b4:	00c12083          	lw	ra,12(sp)
    15b8:	01010113          	addi	sp,sp,16
    15bc:	00008067          	ret

000015c0 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
    15c0:	fe010113          	addi	sp,sp,-32
    15c4:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
    15c8:	00800793          	li	a5,8
    15cc:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
    15d0:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
    15d4:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
    15d8:	06b00793          	li	a5,107
    15dc:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
    15e0:	00010593          	mv	a1,sp
    15e4:	f8010537          	lui	a0,0xf8010
    15e8:	d79ff0ef          	jal	ra,1360 <uart_applyConfig>
    }
    15ec:	01c12083          	lw	ra,28(sp)
    15f0:	02010113          	addi	sp,sp,32
    15f4:	00008067          	ret

000015f8 <reverse>:
     {
    15f8:	ff010113          	addi	sp,sp,-16
    15fc:	00112623          	sw	ra,12(sp)
    1600:	00812423          	sw	s0,8(sp)
    1604:	00050413          	mv	s0,a0
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    1608:	c41ff0ef          	jal	ra,1248 <strlen>
    160c:	fff50513          	addi	a0,a0,-1 # f800ffff <__freertos_irq_stack_top+0xf7e09c2f>
    1610:	00000793          	li	a5,0
    1614:	02a7d463          	bge	a5,a0,163c <reverse+0x44>
              c = s[i];
    1618:	00f406b3          	add	a3,s0,a5
    161c:	0006c603          	lbu	a2,0(a3)
              s[i] = s[j];
    1620:	00a40733          	add	a4,s0,a0
    1624:	00074583          	lbu	a1,0(a4)
    1628:	00b68023          	sb	a1,0(a3)
              s[j] = c;
    162c:	00c70023          	sb	a2,0(a4)
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    1630:	00178793          	addi	a5,a5,1
    1634:	fff50513          	addi	a0,a0,-1
    1638:	fddff06f          	j	1614 <reverse+0x1c>
     }
    163c:	00c12083          	lw	ra,12(sp)
    1640:	00812403          	lw	s0,8(sp)
    1644:	01010113          	addi	sp,sp,16
    1648:	00008067          	ret

0000164c <itos>:
     {
    164c:	ff010113          	addi	sp,sp,-16
    1650:	00112623          	sw	ra,12(sp)
         if ((sign = n) < 0)  /* record sign */
    1654:	00054863          	bltz	a0,1664 <itos+0x18>
    1658:	00050613          	mv	a2,a0
    165c:	00000813          	li	a6,0
    1660:	0140006f          	j	1674 <itos+0x28>
             n = -n;          /* make n positive */
    1664:	40a00633          	neg	a2,a0
    1668:	ff5ff06f          	j	165c <itos+0x10>
             s[i++] = n % 10 + '0';   /* get next digit */
    166c:	00088813          	mv	a6,a7
         } while ((n /= 10) > 0);     /* delete it */
    1670:	00078613          	mv	a2,a5
             s[i++] = n % 10 + '0';   /* get next digit */
    1674:	00a00793          	li	a5,10
    1678:	02f666b3          	rem	a3,a2,a5
    167c:	00180893          	addi	a7,a6,1
    1680:	01058733          	add	a4,a1,a6
    1684:	03068693          	addi	a3,a3,48
    1688:	00d70023          	sb	a3,0(a4)
         } while ((n /= 10) > 0);     /* delete it */
    168c:	02f647b3          	div	a5,a2,a5
    1690:	00900713          	li	a4,9
    1694:	fcc74ce3          	blt	a4,a2,166c <itos+0x20>
         if (sign < 0)
    1698:	02054063          	bltz	a0,16b8 <itos+0x6c>
         s[i] = '\0';
    169c:	011588b3          	add	a7,a1,a7
    16a0:	00088023          	sb	zero,0(a7)
         reverse(s);
    16a4:	00058513          	mv	a0,a1
    16a8:	f51ff0ef          	jal	ra,15f8 <reverse>
    }
    16ac:	00c12083          	lw	ra,12(sp)
    16b0:	01010113          	addi	sp,sp,16
    16b4:	00008067          	ret
             s[i++] = '-';
    16b8:	011588b3          	add	a7,a1,a7
    16bc:	02d00793          	li	a5,45
    16c0:	00f88023          	sb	a5,0(a7)
    16c4:	00280893          	addi	a7,a6,2
    16c8:	fd5ff06f          	j	169c <itos+0x50>

000016cc <ftoa>:
    {
    16cc:	fe010113          	addi	sp,sp,-32
    16d0:	00112e23          	sw	ra,28(sp)
    16d4:	00812c23          	sw	s0,24(sp)
    16d8:	00912a23          	sw	s1,20(sp)
    16dc:	01212823          	sw	s2,16(sp)
    16e0:	01312623          	sw	s3,12(sp)
    16e4:	01412423          	sw	s4,8(sp)
    16e8:	00050913          	mv	s2,a0
    16ec:	00058993          	mv	s3,a1
    16f0:	00060a13          	mv	s4,a2
    16f4:	00068413          	mv	s0,a3
        int ipart = (int)n;
    16f8:	360010ef          	jal	ra,2a58 <__fixdfsi>
    16fc:	00050493          	mv	s1,a0
        double fpart = n - (double)ipart;
    1700:	3dc010ef          	jal	ra,2adc <__floatsidf>
    1704:	00050613          	mv	a2,a0
    1708:	00058693          	mv	a3,a1
    170c:	00090513          	mv	a0,s2
    1710:	00098593          	mv	a1,s3
    1714:	2c9000ef          	jal	ra,21dc <__subdf3>
    1718:	00050913          	mv	s2,a0
    171c:	00058993          	mv	s3,a1
        itos(n, res1);
    1720:	000a0593          	mv	a1,s4
    1724:	00048513          	mv	a0,s1
    1728:	f25ff0ef          	jal	ra,164c <itos>
        *res2 = '.';
    172c:	02e00793          	li	a5,46
    1730:	00f40023          	sb	a5,0(s0)
        res2++;
    1734:	00140a13          	addi	s4,s0,1
        fpart_f = (float)fpart * pow(10, afterpoint);
    1738:	00090513          	mv	a0,s2
    173c:	00098593          	mv	a1,s3
    1740:	758010ef          	jal	ra,2e98 <__truncdfsf2>
    1744:	654010ef          	jal	ra,2d98 <__extendsfdf2>
    1748:	8181a603          	lw	a2,-2024(gp) # 63b0 <_impure_ptr+0x4>
    174c:	81c1a683          	lw	a3,-2020(gp) # 63b4 <_impure_ptr+0x8>
    1750:	438000ef          	jal	ra,1b88 <__muldf3>
    1754:	744010ef          	jal	ra,2e98 <__truncdfsf2>
    1758:	00050493          	mv	s1,a0
        if (fpart_f<0)
    175c:	00000593          	li	a1,0
    1760:	500010ef          	jal	ra,2c60 <__lesf2>
    1764:	06054a63          	bltz	a0,17d8 <ftoa+0x10c>
        for (int i=afterpoint; i>0; i--)
    1768:	00400413          	li	s0,4
    176c:	08805263          	blez	s0,17f0 <ftoa+0x124>
            if ((fpart_f<(1 * pow(10, i-1))) && (fpart_f>0))
    1770:	00048513          	mv	a0,s1
    1774:	624010ef          	jal	ra,2d98 <__extendsfdf2>
    1778:	00050913          	mv	s2,a0
    177c:	00058993          	mv	s3,a1
    1780:	fff40413          	addi	s0,s0,-1
    1784:	00040513          	mv	a0,s0
    1788:	354010ef          	jal	ra,2adc <__floatsidf>
    178c:	00050613          	mv	a2,a0
    1790:	00058693          	mv	a3,a1
    1794:	8201a503          	lw	a0,-2016(gp) # 63b8 <_impure_ptr+0xc>
    1798:	8241a583          	lw	a1,-2012(gp) # 63bc <_impure_ptr+0x10>
    179c:	185010ef          	jal	ra,3120 <pow>
    17a0:	00050613          	mv	a2,a0
    17a4:	00058693          	mv	a3,a1
    17a8:	00090513          	mv	a0,s2
    17ac:	00098593          	mv	a1,s3
    17b0:	2d8000ef          	jal	ra,1a88 <__ledf2>
    17b4:	fa055ce3          	bgez	a0,176c <ftoa+0xa0>
    17b8:	00000593          	li	a1,0
    17bc:	00048513          	mv	a0,s1
    17c0:	3dc010ef          	jal	ra,2b9c <__gesf2>
    17c4:	faa054e3          	blez	a0,176c <ftoa+0xa0>
                *res2='0';
    17c8:	03000793          	li	a5,48
    17cc:	00fa0023          	sb	a5,0(s4)
                res2++;
    17d0:	001a0a13          	addi	s4,s4,1
    17d4:	f99ff06f          	j	176c <ftoa+0xa0>
            *res2 = '-';
    17d8:	02d00793          	li	a5,45
    17dc:	00f400a3          	sb	a5,1(s0)
            res2++;
    17e0:	00240a13          	addi	s4,s0,2
            fpart_f = -(fpart_f);
    17e4:	800007b7          	lui	a5,0x80000
    17e8:	0097c4b3          	xor	s1,a5,s1
    17ec:	f7dff06f          	j	1768 <ftoa+0x9c>
        itos((int)fpart_f, res2);
    17f0:	00048513          	mv	a0,s1
    17f4:	530010ef          	jal	ra,2d24 <__fixsfsi>
    17f8:	000a0593          	mv	a1,s4
    17fc:	e51ff0ef          	jal	ra,164c <itos>
    }
    1800:	01c12083          	lw	ra,28(sp)
    1804:	01812403          	lw	s0,24(sp)
    1808:	01412483          	lw	s1,20(sp)
    180c:	01012903          	lw	s2,16(sp)
    1810:	00c12983          	lw	s3,12(sp)
    1814:	00812a03          	lw	s4,8(sp)
    1818:	02010113          	addi	sp,sp,32
    181c:	00008067          	ret

00001820 <print_float>:
    {
    1820:	fc010113          	addi	sp,sp,-64
    1824:	02112e23          	sw	ra,60(sp)
    1828:	02812c23          	sw	s0,56(sp)
        ftoa(val, sval, fval);
    182c:	00c10693          	addi	a3,sp,12
    1830:	01810613          	addi	a2,sp,24
    1834:	e99ff0ef          	jal	ra,16cc <ftoa>
        if (fval[1] == '-')
    1838:	00d14703          	lbu	a4,13(sp)
    183c:	02d00793          	li	a5,45
    1840:	06f70663          	beq	a4,a5,18ac <print_float+0x8c>
        neg=0;
    1844:	00000413          	li	s0,0
        strcat(sval, fval);
    1848:	00c10593          	addi	a1,sp,12
    184c:	01810513          	addi	a0,sp,24
    1850:	959ff0ef          	jal	ra,11a8 <strcat>
        if ((sval[0] != '-') && (neg == 1))
    1854:	01814703          	lbu	a4,24(sp)
    1858:	02d00793          	li	a5,45
    185c:	00f70463          	beq	a4,a5,1864 <print_float+0x44>
    1860:	08041263          	bnez	s0,18e4 <print_float+0xc4>
        _putchar_s(sval);
    1864:	01810513          	addi	a0,sp,24
    1868:	b49ff0ef          	jal	ra,13b0 <_putchar_s>
    }
    186c:	03c12083          	lw	ra,60(sp)
    1870:	03812403          	lw	s0,56(sp)
    1874:	04010113          	addi	sp,sp,64
    1878:	00008067          	ret
                fval[i-1] = fval[i];
    187c:	fff78713          	addi	a4,a5,-1 # 7fffffff <__freertos_irq_stack_top+0x7fdf9c2f>
    1880:	03010693          	addi	a3,sp,48
    1884:	00f686b3          	add	a3,a3,a5
    1888:	fdc6c683          	lbu	a3,-36(a3)
    188c:	03010613          	addi	a2,sp,48
    1890:	00e60733          	add	a4,a2,a4
    1894:	fcd70e23          	sb	a3,-36(a4)
                i++;
    1898:	00178793          	addi	a5,a5,1
            while (i<10)
    189c:	00900713          	li	a4,9
    18a0:	fcf75ee3          	bge	a4,a5,187c <print_float+0x5c>
            neg = 1;
    18a4:	00100413          	li	s0,1
    18a8:	fa1ff06f          	j	1848 <print_float+0x28>
        i=2;
    18ac:	00200793          	li	a5,2
    18b0:	fedff06f          	j	189c <print_float+0x7c>
                sval[j+1] = sval[j];
    18b4:	00178713          	addi	a4,a5,1
    18b8:	03010693          	addi	a3,sp,48
    18bc:	00f686b3          	add	a3,a3,a5
    18c0:	fe86c683          	lbu	a3,-24(a3)
    18c4:	03010613          	addi	a2,sp,48
    18c8:	00e60733          	add	a4,a2,a4
    18cc:	fed70423          	sb	a3,-24(a4)
                j--;
    18d0:	fff78793          	addi	a5,a5,-1
            while (j>=0)
    18d4:	fe07d0e3          	bgez	a5,18b4 <print_float+0x94>
            sval[0] = '-';
    18d8:	02d00793          	li	a5,45
    18dc:	00f10c23          	sb	a5,24(sp)
    18e0:	f85ff06f          	j	1864 <print_float+0x44>
        j=19;
    18e4:	01300793          	li	a5,19
    18e8:	fedff06f          	j	18d4 <print_float+0xb4>

000018ec <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    18ec:	fc010113          	addi	sp,sp,-64
    18f0:	00112e23          	sw	ra,28(sp)
    18f4:	00812c23          	sw	s0,24(sp)
    18f8:	00912a23          	sw	s1,20(sp)
    18fc:	00050493          	mv	s1,a0
    1900:	02b12223          	sw	a1,36(sp)
    1904:	02c12423          	sw	a2,40(sp)
    1908:	02d12623          	sw	a3,44(sp)
    190c:	02e12823          	sw	a4,48(sp)
    1910:	02f12a23          	sw	a5,52(sp)
    1914:	03012c23          	sw	a6,56(sp)
    1918:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    191c:	02410793          	addi	a5,sp,36
    1920:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    1924:	00000413          	li	s0,0
    1928:	01c0006f          	j	1944 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    192c:	00c12783          	lw	a5,12(sp)
    1930:	00478713          	addi	a4,a5,4
    1934:	00e12623          	sw	a4,12(sp)
    1938:	0007a503          	lw	a0,0(a5)
    193c:	b51ff0ef          	jal	ra,148c <bsp_printf_c>
        for (i = 0; format[i]; i++)
    1940:	00140413          	addi	s0,s0,1
    1944:	008487b3          	add	a5,s1,s0
    1948:	0007c503          	lbu	a0,0(a5)
    194c:	0c050c63          	beqz	a0,1a24 <bsp_printf+0x138>
            if (format[i] == '%') {
    1950:	02500793          	li	a5,37
    1954:	06f50663          	beq	a0,a5,19c0 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    1958:	b35ff0ef          	jal	ra,148c <bsp_printf_c>
    195c:	fe5ff06f          	j	1940 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    1960:	00c12783          	lw	a5,12(sp)
    1964:	00478713          	addi	a4,a5,4
    1968:	00e12623          	sw	a4,12(sp)
    196c:	0007a503          	lw	a0,0(a5)
    1970:	b39ff0ef          	jal	ra,14a8 <bsp_printf_s>
                        break;
    1974:	fcdff06f          	j	1940 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    1978:	00c12783          	lw	a5,12(sp)
    197c:	00478713          	addi	a4,a5,4
    1980:	00e12623          	sw	a4,12(sp)
    1984:	0007a503          	lw	a0,0(a5)
    1988:	b39ff0ef          	jal	ra,14c0 <bsp_printf_d>
                        break;
    198c:	fb5ff06f          	j	1940 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    1990:	00c12783          	lw	a5,12(sp)
    1994:	00478713          	addi	a4,a5,4
    1998:	00e12623          	sw	a4,12(sp)
    199c:	0007a503          	lw	a0,0(a5)
    19a0:	be1ff0ef          	jal	ra,1580 <bsp_printf_X>
                        break;
    19a4:	f9dff06f          	j	1940 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    19a8:	00c12783          	lw	a5,12(sp)
    19ac:	00478713          	addi	a4,a5,4
    19b0:	00e12623          	sw	a4,12(sp)
    19b4:	0007a503          	lw	a0,0(a5)
    19b8:	b89ff0ef          	jal	ra,1540 <bsp_printf_x>
                        break;
    19bc:	f85ff06f          	j	1940 <bsp_printf+0x54>
                while (format[++i]) {
    19c0:	00140413          	addi	s0,s0,1
    19c4:	008487b3          	add	a5,s1,s0
    19c8:	0007c783          	lbu	a5,0(a5)
    19cc:	f6078ae3          	beqz	a5,1940 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    19d0:	06300713          	li	a4,99
    19d4:	f4e78ce3          	beq	a5,a4,192c <bsp_printf+0x40>
                    else if (format[i] == 's') {
    19d8:	07300713          	li	a4,115
    19dc:	f8e782e3          	beq	a5,a4,1960 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    19e0:	06400713          	li	a4,100
    19e4:	f8e78ae3          	beq	a5,a4,1978 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    19e8:	05800713          	li	a4,88
    19ec:	fae782e3          	beq	a5,a4,1990 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    19f0:	07800713          	li	a4,120
    19f4:	fae78ae3          	beq	a5,a4,19a8 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    19f8:	06600713          	li	a4,102
    19fc:	fce792e3          	bne	a5,a4,19c0 <bsp_printf+0xd4>
                        print_float(va_arg(ap,double));
    1a00:	00c12783          	lw	a5,12(sp)
    1a04:	00778793          	addi	a5,a5,7
    1a08:	ff87f793          	andi	a5,a5,-8
    1a0c:	00878713          	addi	a4,a5,8
    1a10:	00e12623          	sw	a4,12(sp)
    1a14:	0007a503          	lw	a0,0(a5)
    1a18:	0047a583          	lw	a1,4(a5)
    1a1c:	e05ff0ef          	jal	ra,1820 <print_float>
                        break;
    1a20:	f21ff06f          	j	1940 <bsp_printf+0x54>

        va_end(ap);
    }
    1a24:	01c12083          	lw	ra,28(sp)
    1a28:	01812403          	lw	s0,24(sp)
    1a2c:	01412483          	lw	s1,20(sp)
    1a30:	04010113          	addi	sp,sp,64
    1a34:	00008067          	ret

00001a38 <main>:
//
////////////////////////////////////////////////////////////////////////////////
#include <stdint.h>
#include "bsp.h"

void main() {
    1a38:	ff010113          	addi	sp,sp,-16
    1a3c:	00112623          	sw	ra,12(sp)
    uint8_t dat;

    bsp_init();
    1a40:	b81ff0ef          	jal	ra,15c0 <bsp_init>
    bsp_printf("Uart echo demo ! \r\n");
    1a44:	00006537          	lui	a0,0x6
    1a48:	c4850513          	addi	a0,a0,-952 # 5c48 <_data+0x2c>
    1a4c:	ea1ff0ef          	jal	ra,18ec <bsp_printf>
    bsp_printf("Start typing on terminal to send character... \r\n");
    1a50:	00006537          	lui	a0,0x6
    1a54:	c5c50513          	addi	a0,a0,-932 # 5c5c <_data+0x40>
    1a58:	e95ff0ef          	jal	ra,18ec <bsp_printf>
    1a5c:	01c0006f          	j	1a78 <main+0x40>
    while(1)
    {
        while(uart_readOccupancy(BSP_UART_TERMINAL)){
            dat=uart_read(BSP_UART_TERMINAL);
    1a60:	f8010537          	lui	a0,0xf8010
    1a64:	8c9ff0ef          	jal	ra,132c <uart_read>
            bsp_printf("echo character: %c \r\n", dat);
    1a68:	00050593          	mv	a1,a0
    1a6c:	00006537          	lui	a0,0x6
    1a70:	c9050513          	addi	a0,a0,-880 # 5c90 <_data+0x74>
    1a74:	e79ff0ef          	jal	ra,18ec <bsp_printf>
        while(uart_readOccupancy(BSP_UART_TERMINAL)){
    1a78:	f8010537          	lui	a0,0xf8010
    1a7c:	869ff0ef          	jal	ra,12e4 <uart_readOccupancy>
    1a80:	fe050ce3          	beqz	a0,1a78 <main+0x40>
    1a84:	fddff06f          	j	1a60 <main+0x28>

00001a88 <__ledf2>:
    1a88:	0145d713          	srli	a4,a1,0x14
    1a8c:	001007b7          	lui	a5,0x100
    1a90:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf9467>
    1a94:	0146d813          	srli	a6,a3,0x14
    1a98:	7ff77713          	andi	a4,a4,2047
    1a9c:	7ff00893          	li	a7,2047
    1aa0:	00b7f333          	and	t1,a5,a1
    1aa4:	00050e13          	mv	t3,a0
    1aa8:	00d7f7b3          	and	a5,a5,a3
    1aac:	01f5d593          	srli	a1,a1,0x1f
    1ab0:	00060e93          	mv	t4,a2
    1ab4:	7ff87813          	andi	a6,a6,2047
    1ab8:	01f6d693          	srli	a3,a3,0x1f
    1abc:	05170a63          	beq	a4,a7,1b10 <__ledf2+0x88>
    1ac0:	03180263          	beq	a6,a7,1ae4 <__ledf2+0x5c>
    1ac4:	04071c63          	bnez	a4,1b1c <__ledf2+0x94>
    1ac8:	00a36533          	or	a0,t1,a0
    1acc:	02081663          	bnez	a6,1af8 <__ledf2+0x70>
    1ad0:	00c7e633          	or	a2,a5,a2
    1ad4:	02061263          	bnez	a2,1af8 <__ledf2+0x70>
    1ad8:	00000693          	li	a3,0
    1adc:	06050263          	beqz	a0,1b40 <__ledf2+0xb8>
    1ae0:	0200006f          	j	1b00 <__ledf2+0x78>
    1ae4:	00c7e8b3          	or	a7,a5,a2
    1ae8:	fc088ee3          	beqz	a7,1ac4 <__ledf2+0x3c>
    1aec:	00200693          	li	a3,2
    1af0:	00068513          	mv	a0,a3
    1af4:	00008067          	ret
    1af8:	04050263          	beqz	a0,1b3c <__ledf2+0xb4>
    1afc:	04d58e63          	beq	a1,a3,1b58 <__ledf2+0xd0>
    1b00:	00100693          	li	a3,1
    1b04:	02058e63          	beqz	a1,1b40 <__ledf2+0xb8>
    1b08:	fff00693          	li	a3,-1
    1b0c:	0340006f          	j	1b40 <__ledf2+0xb8>
    1b10:	00a36533          	or	a0,t1,a0
    1b14:	fc051ce3          	bnez	a0,1aec <__ledf2+0x64>
    1b18:	02e80863          	beq	a6,a4,1b48 <__ledf2+0xc0>
    1b1c:	00081663          	bnez	a6,1b28 <__ledf2+0xa0>
    1b20:	00c7e633          	or	a2,a5,a2
    1b24:	fc060ee3          	beqz	a2,1b00 <__ledf2+0x78>
    1b28:	fcd59ce3          	bne	a1,a3,1b00 <__ledf2+0x78>
    1b2c:	02e85663          	bge	a6,a4,1b58 <__ledf2+0xd0>
    1b30:	fc069ce3          	bnez	a3,1b08 <__ledf2+0x80>
    1b34:	00100693          	li	a3,1
    1b38:	0080006f          	j	1b40 <__ledf2+0xb8>
    1b3c:	fc0686e3          	beqz	a3,1b08 <__ledf2+0x80>
    1b40:	00068513          	mv	a0,a3
    1b44:	00008067          	ret
    1b48:	00c7e633          	or	a2,a5,a2
    1b4c:	fc060ee3          	beqz	a2,1b28 <__ledf2+0xa0>
    1b50:	00200693          	li	a3,2
    1b54:	f9dff06f          	j	1af0 <__ledf2+0x68>
    1b58:	01074a63          	blt	a4,a6,1b6c <__ledf2+0xe4>
    1b5c:	fa67e2e3          	bltu	a5,t1,1b00 <__ledf2+0x78>
    1b60:	00f30c63          	beq	t1,a5,1b78 <__ledf2+0xf0>
    1b64:	00000693          	li	a3,0
    1b68:	fcf37ce3          	bgeu	t1,a5,1b40 <__ledf2+0xb8>
    1b6c:	f8058ee3          	beqz	a1,1b08 <__ledf2+0x80>
    1b70:	00058693          	mv	a3,a1
    1b74:	fcdff06f          	j	1b40 <__ledf2+0xb8>
    1b78:	f9cee4e3          	bltu	t4,t3,1b00 <__ledf2+0x78>
    1b7c:	00000693          	li	a3,0
    1b80:	fdde70e3          	bgeu	t3,t4,1b40 <__ledf2+0xb8>
    1b84:	fe9ff06f          	j	1b6c <__ledf2+0xe4>

00001b88 <__muldf3>:
    1b88:	fc010113          	addi	sp,sp,-64
    1b8c:	0145d793          	srli	a5,a1,0x14
    1b90:	02812c23          	sw	s0,56(sp)
    1b94:	03212823          	sw	s2,48(sp)
    1b98:	03412423          	sw	s4,40(sp)
    1b9c:	00c59413          	slli	s0,a1,0xc
    1ba0:	02112e23          	sw	ra,60(sp)
    1ba4:	02912a23          	sw	s1,52(sp)
    1ba8:	03312623          	sw	s3,44(sp)
    1bac:	03512223          	sw	s5,36(sp)
    1bb0:	03612023          	sw	s6,32(sp)
    1bb4:	01712e23          	sw	s7,28(sp)
    1bb8:	7ff7f793          	andi	a5,a5,2047
    1bbc:	00050913          	mv	s2,a0
    1bc0:	00c45413          	srli	s0,s0,0xc
    1bc4:	01f5da13          	srli	s4,a1,0x1f
    1bc8:	14078c63          	beqz	a5,1d20 <__muldf3+0x198>
    1bcc:	7ff00713          	li	a4,2047
    1bd0:	20e78863          	beq	a5,a4,1de0 <__muldf3+0x258>
    1bd4:	00341513          	slli	a0,s0,0x3
    1bd8:	01d95413          	srli	s0,s2,0x1d
    1bdc:	00a46433          	or	s0,s0,a0
    1be0:	00800537          	lui	a0,0x800
    1be4:	00a46433          	or	s0,s0,a0
    1be8:	00391493          	slli	s1,s2,0x3
    1bec:	c0178b13          	addi	s6,a5,-1023
    1bf0:	00000993          	li	s3,0
    1bf4:	00000b93          	li	s7,0
    1bf8:	0146d793          	srli	a5,a3,0x14
    1bfc:	00c69913          	slli	s2,a3,0xc
    1c00:	7ff7f793          	andi	a5,a5,2047
    1c04:	00c95913          	srli	s2,s2,0xc
    1c08:	01f6da93          	srli	s5,a3,0x1f
    1c0c:	18078263          	beqz	a5,1d90 <__muldf3+0x208>
    1c10:	7ff00713          	li	a4,2047
    1c14:	04e78c63          	beq	a5,a4,1c6c <__muldf3+0xe4>
    1c18:	00391513          	slli	a0,s2,0x3
    1c1c:	01d65913          	srli	s2,a2,0x1d
    1c20:	00a96933          	or	s2,s2,a0
    1c24:	c0178793          	addi	a5,a5,-1023
    1c28:	00800537          	lui	a0,0x800
    1c2c:	00a96933          	or	s2,s2,a0
    1c30:	00361593          	slli	a1,a2,0x3
    1c34:	00fb0b33          	add	s6,s6,a5
    1c38:	00000813          	li	a6,0
    1c3c:	015a46b3          	xor	a3,s4,s5
    1c40:	00f00793          	li	a5,15
    1c44:	00068513          	mv	a0,a3
    1c48:	001b0613          	addi	a2,s6,1
    1c4c:	2137ec63          	bltu	a5,s3,1e64 <__muldf3+0x2dc>
    1c50:	00004797          	auipc	a5,0x4
    1c54:	05878793          	addi	a5,a5,88 # 5ca8 <_data+0x8c>
    1c58:	00299993          	slli	s3,s3,0x2
    1c5c:	00f989b3          	add	s3,s3,a5
    1c60:	0009a703          	lw	a4,0(s3)
    1c64:	00f70733          	add	a4,a4,a5
    1c68:	00070067          	jr	a4
    1c6c:	00c965b3          	or	a1,s2,a2
    1c70:	7ffb0b13          	addi	s6,s6,2047
    1c74:	1c059063          	bnez	a1,1e34 <__muldf3+0x2ac>
    1c78:	0029e993          	ori	s3,s3,2
    1c7c:	00000913          	li	s2,0
    1c80:	00200813          	li	a6,2
    1c84:	fb9ff06f          	j	1c3c <__muldf3+0xb4>
    1c88:	00000693          	li	a3,0
    1c8c:	7ff00793          	li	a5,2047
    1c90:	00080437          	lui	s0,0x80
    1c94:	00000493          	li	s1,0
    1c98:	00c41413          	slli	s0,s0,0xc
    1c9c:	01479793          	slli	a5,a5,0x14
    1ca0:	00c45413          	srli	s0,s0,0xc
    1ca4:	01f69693          	slli	a3,a3,0x1f
    1ca8:	00f46433          	or	s0,s0,a5
    1cac:	00d46433          	or	s0,s0,a3
    1cb0:	00040593          	mv	a1,s0
    1cb4:	03c12083          	lw	ra,60(sp)
    1cb8:	03812403          	lw	s0,56(sp)
    1cbc:	00048513          	mv	a0,s1
    1cc0:	03012903          	lw	s2,48(sp)
    1cc4:	03412483          	lw	s1,52(sp)
    1cc8:	02c12983          	lw	s3,44(sp)
    1ccc:	02812a03          	lw	s4,40(sp)
    1cd0:	02412a83          	lw	s5,36(sp)
    1cd4:	02012b03          	lw	s6,32(sp)
    1cd8:	01c12b83          	lw	s7,28(sp)
    1cdc:	04010113          	addi	sp,sp,64
    1ce0:	00008067          	ret
    1ce4:	000a8513          	mv	a0,s5
    1ce8:	00090413          	mv	s0,s2
    1cec:	00058493          	mv	s1,a1
    1cf0:	00080b93          	mv	s7,a6
    1cf4:	00200793          	li	a5,2
    1cf8:	14fb8c63          	beq	s7,a5,1e50 <__muldf3+0x2c8>
    1cfc:	00300793          	li	a5,3
    1d00:	f8fb84e3          	beq	s7,a5,1c88 <__muldf3+0x100>
    1d04:	00100793          	li	a5,1
    1d08:	00050693          	mv	a3,a0
    1d0c:	4cfb9463          	bne	s7,a5,21d4 <__muldf3+0x64c>
    1d10:	00000793          	li	a5,0
    1d14:	00000413          	li	s0,0
    1d18:	00000493          	li	s1,0
    1d1c:	f7dff06f          	j	1c98 <__muldf3+0x110>
    1d20:	00a464b3          	or	s1,s0,a0
    1d24:	0e048e63          	beqz	s1,1e20 <__muldf3+0x298>
    1d28:	00d12623          	sw	a3,12(sp)
    1d2c:	00c12423          	sw	a2,8(sp)
    1d30:	38040863          	beqz	s0,20c0 <__muldf3+0x538>
    1d34:	00040513          	mv	a0,s0
    1d38:	354010ef          	jal	ra,308c <__clzsi2>
    1d3c:	00812603          	lw	a2,8(sp)
    1d40:	00c12683          	lw	a3,12(sp)
    1d44:	00050793          	mv	a5,a0
    1d48:	ff550593          	addi	a1,a0,-11 # 7ffff5 <__freertos_irq_stack_top+0x5f9c25>
    1d4c:	01d00713          	li	a4,29
    1d50:	ff878493          	addi	s1,a5,-8
    1d54:	40b70733          	sub	a4,a4,a1
    1d58:	00941433          	sll	s0,s0,s1
    1d5c:	00e95733          	srl	a4,s2,a4
    1d60:	00876433          	or	s0,a4,s0
    1d64:	009914b3          	sll	s1,s2,s1
    1d68:	c0d00b13          	li	s6,-1011
    1d6c:	40fb0b33          	sub	s6,s6,a5
    1d70:	0146d793          	srli	a5,a3,0x14
    1d74:	00c69913          	slli	s2,a3,0xc
    1d78:	7ff7f793          	andi	a5,a5,2047
    1d7c:	00000993          	li	s3,0
    1d80:	00000b93          	li	s7,0
    1d84:	00c95913          	srli	s2,s2,0xc
    1d88:	01f6da93          	srli	s5,a3,0x1f
    1d8c:	e80792e3          	bnez	a5,1c10 <__muldf3+0x88>
    1d90:	00c965b3          	or	a1,s2,a2
    1d94:	06058463          	beqz	a1,1dfc <__muldf3+0x274>
    1d98:	2e090c63          	beqz	s2,2090 <__muldf3+0x508>
    1d9c:	00090513          	mv	a0,s2
    1da0:	00c12423          	sw	a2,8(sp)
    1da4:	2e8010ef          	jal	ra,308c <__clzsi2>
    1da8:	00812603          	lw	a2,8(sp)
    1dac:	00050793          	mv	a5,a0
    1db0:	ff550693          	addi	a3,a0,-11
    1db4:	01d00713          	li	a4,29
    1db8:	ff878593          	addi	a1,a5,-8
    1dbc:	40d70733          	sub	a4,a4,a3
    1dc0:	00b91933          	sll	s2,s2,a1
    1dc4:	00e65733          	srl	a4,a2,a4
    1dc8:	01276933          	or	s2,a4,s2
    1dcc:	00b615b3          	sll	a1,a2,a1
    1dd0:	40fb07b3          	sub	a5,s6,a5
    1dd4:	c0d78b13          	addi	s6,a5,-1011
    1dd8:	00000813          	li	a6,0
    1ddc:	e61ff06f          	j	1c3c <__muldf3+0xb4>
    1de0:	00a464b3          	or	s1,s0,a0
    1de4:	02049463          	bnez	s1,1e0c <__muldf3+0x284>
    1de8:	00000413          	li	s0,0
    1dec:	00800993          	li	s3,8
    1df0:	7ff00b13          	li	s6,2047
    1df4:	00200b93          	li	s7,2
    1df8:	e01ff06f          	j	1bf8 <__muldf3+0x70>
    1dfc:	0019e993          	ori	s3,s3,1
    1e00:	00000913          	li	s2,0
    1e04:	00100813          	li	a6,1
    1e08:	e35ff06f          	j	1c3c <__muldf3+0xb4>
    1e0c:	00050493          	mv	s1,a0
    1e10:	00c00993          	li	s3,12
    1e14:	7ff00b13          	li	s6,2047
    1e18:	00300b93          	li	s7,3
    1e1c:	dddff06f          	j	1bf8 <__muldf3+0x70>
    1e20:	00000413          	li	s0,0
    1e24:	00400993          	li	s3,4
    1e28:	00000b13          	li	s6,0
    1e2c:	00100b93          	li	s7,1
    1e30:	dc9ff06f          	j	1bf8 <__muldf3+0x70>
    1e34:	0039e993          	ori	s3,s3,3
    1e38:	00060593          	mv	a1,a2
    1e3c:	00300813          	li	a6,3
    1e40:	dfdff06f          	j	1c3c <__muldf3+0xb4>
    1e44:	00200793          	li	a5,2
    1e48:	000a0513          	mv	a0,s4
    1e4c:	eafb98e3          	bne	s7,a5,1cfc <__muldf3+0x174>
    1e50:	00050693          	mv	a3,a0
    1e54:	7ff00793          	li	a5,2047
    1e58:	00000413          	li	s0,0
    1e5c:	00000493          	li	s1,0
    1e60:	e39ff06f          	j	1c98 <__muldf3+0x110>
    1e64:	00010e37          	lui	t3,0x10
    1e68:	fffe0713          	addi	a4,t3,-1 # ffff <__global_pointer$+0x9467>
    1e6c:	0104d793          	srli	a5,s1,0x10
    1e70:	0105d813          	srli	a6,a1,0x10
    1e74:	00e4f4b3          	and	s1,s1,a4
    1e78:	00e5f5b3          	and	a1,a1,a4
    1e7c:	02958733          	mul	a4,a1,s1
    1e80:	02b78333          	mul	t1,a5,a1
    1e84:	01075513          	srli	a0,a4,0x10
    1e88:	029808b3          	mul	a7,a6,s1
    1e8c:	006888b3          	add	a7,a7,t1
    1e90:	01150533          	add	a0,a0,a7
    1e94:	03078f33          	mul	t5,a5,a6
    1e98:	00657463          	bgeu	a0,t1,1ea0 <__muldf3+0x318>
    1e9c:	01cf0f33          	add	t5,t5,t3
    1ea0:	00010eb7          	lui	t4,0x10
    1ea4:	fffe8893          	addi	a7,t4,-1 # ffff <__global_pointer$+0x9467>
    1ea8:	01095293          	srli	t0,s2,0x10
    1eac:	01197933          	and	s2,s2,a7
    1eb0:	01157333          	and	t1,a0,a7
    1eb4:	01177733          	and	a4,a4,a7
    1eb8:	01031313          	slli	t1,t1,0x10
    1ebc:	029908b3          	mul	a7,s2,s1
    1ec0:	00e30333          	add	t1,t1,a4
    1ec4:	01055513          	srli	a0,a0,0x10
    1ec8:	03278fb3          	mul	t6,a5,s2
    1ecc:	0108de13          	srli	t3,a7,0x10
    1ed0:	029284b3          	mul	s1,t0,s1
    1ed4:	01f484b3          	add	s1,s1,t6
    1ed8:	009e04b3          	add	s1,t3,s1
    1edc:	02578733          	mul	a4,a5,t0
    1ee0:	01f4f463          	bgeu	s1,t6,1ee8 <__muldf3+0x360>
    1ee4:	01d70733          	add	a4,a4,t4
    1ee8:	000109b7          	lui	s3,0x10
    1eec:	fff98e13          	addi	t3,s3,-1 # ffff <__global_pointer$+0x9467>
    1ef0:	01c477b3          	and	a5,s0,t3
    1ef4:	01c4feb3          	and	t4,s1,t3
    1ef8:	01045f93          	srli	t6,s0,0x10
    1efc:	0104d493          	srli	s1,s1,0x10
    1f00:	01c8f8b3          	and	a7,a7,t3
    1f04:	02f583b3          	mul	t2,a1,a5
    1f08:	00e48e33          	add	t3,s1,a4
    1f0c:	010e9e93          	slli	t4,t4,0x10
    1f10:	011e8eb3          	add	t4,t4,a7
    1f14:	01d50533          	add	a0,a0,t4
    1f18:	02f80733          	mul	a4,a6,a5
    1f1c:	0103d893          	srli	a7,t2,0x10
    1f20:	02bf85b3          	mul	a1,t6,a1
    1f24:	00b70733          	add	a4,a4,a1
    1f28:	00e888b3          	add	a7,a7,a4
    1f2c:	03f80833          	mul	a6,a6,t6
    1f30:	00b8f463          	bgeu	a7,a1,1f38 <__muldf3+0x3b0>
    1f34:	01380833          	add	a6,a6,s3
    1f38:	00010737          	lui	a4,0x10
    1f3c:	fff70413          	addi	s0,a4,-1 # ffff <__global_pointer$+0x9467>
    1f40:	0088f5b3          	and	a1,a7,s0
    1f44:	0108d893          	srli	a7,a7,0x10
    1f48:	010888b3          	add	a7,a7,a6
    1f4c:	0083f3b3          	and	t2,t2,s0
    1f50:	01059593          	slli	a1,a1,0x10
    1f54:	02f90833          	mul	a6,s2,a5
    1f58:	007585b3          	add	a1,a1,t2
    1f5c:	032f8933          	mul	s2,t6,s2
    1f60:	01085413          	srli	s0,a6,0x10
    1f64:	02f287b3          	mul	a5,t0,a5
    1f68:	012787b3          	add	a5,a5,s2
    1f6c:	00f407b3          	add	a5,s0,a5
    1f70:	03f28fb3          	mul	t6,t0,t6
    1f74:	0127f463          	bgeu	a5,s2,1f7c <__muldf3+0x3f4>
    1f78:	00ef8fb3          	add	t6,t6,a4
    1f7c:	000102b7          	lui	t0,0x10
    1f80:	fff28293          	addi	t0,t0,-1 # ffff <__global_pointer$+0x9467>
    1f84:	0057f733          	and	a4,a5,t0
    1f88:	00587833          	and	a6,a6,t0
    1f8c:	01071713          	slli	a4,a4,0x10
    1f90:	01e50533          	add	a0,a0,t5
    1f94:	01070733          	add	a4,a4,a6
    1f98:	01d53eb3          	sltu	t4,a0,t4
    1f9c:	01c70733          	add	a4,a4,t3
    1fa0:	00b50533          	add	a0,a0,a1
    1fa4:	01d70433          	add	s0,a4,t4
    1fa8:	00b535b3          	sltu	a1,a0,a1
    1fac:	01140833          	add	a6,s0,a7
    1fb0:	00b80f33          	add	t5,a6,a1
    1fb4:	01c73733          	sltu	a4,a4,t3
    1fb8:	01d43433          	sltu	s0,s0,t4
    1fbc:	00876433          	or	s0,a4,s0
    1fc0:	0107d793          	srli	a5,a5,0x10
    1fc4:	011838b3          	sltu	a7,a6,a7
    1fc8:	00bf35b3          	sltu	a1,t5,a1
    1fcc:	00f40433          	add	s0,s0,a5
    1fd0:	00b8e5b3          	or	a1,a7,a1
    1fd4:	00951493          	slli	s1,a0,0x9
    1fd8:	00b40433          	add	s0,s0,a1
    1fdc:	01f40433          	add	s0,s0,t6
    1fe0:	0064e4b3          	or	s1,s1,t1
    1fe4:	00941713          	slli	a4,s0,0x9
    1fe8:	009034b3          	snez	s1,s1
    1fec:	017f5413          	srli	s0,t5,0x17
    1ff0:	01755513          	srli	a0,a0,0x17
    1ff4:	009f1793          	slli	a5,t5,0x9
    1ff8:	00a4e4b3          	or	s1,s1,a0
    1ffc:	00876433          	or	s0,a4,s0
    2000:	00f4e4b3          	or	s1,s1,a5
    2004:	00741793          	slli	a5,s0,0x7
    2008:	0207d063          	bgez	a5,2028 <__muldf3+0x4a0>
    200c:	0014d793          	srli	a5,s1,0x1
    2010:	0014f493          	andi	s1,s1,1
    2014:	01f41713          	slli	a4,s0,0x1f
    2018:	0097e4b3          	or	s1,a5,s1
    201c:	00e4e4b3          	or	s1,s1,a4
    2020:	00145413          	srli	s0,s0,0x1
    2024:	00060b13          	mv	s6,a2
    2028:	3ffb0713          	addi	a4,s6,1023
    202c:	0ce05063          	blez	a4,20ec <__muldf3+0x564>
    2030:	0074f793          	andi	a5,s1,7
    2034:	02078063          	beqz	a5,2054 <__muldf3+0x4cc>
    2038:	00f4f793          	andi	a5,s1,15
    203c:	00400613          	li	a2,4
    2040:	00c78a63          	beq	a5,a2,2054 <__muldf3+0x4cc>
    2044:	00448793          	addi	a5,s1,4
    2048:	0097b4b3          	sltu	s1,a5,s1
    204c:	00940433          	add	s0,s0,s1
    2050:	00078493          	mv	s1,a5
    2054:	00741793          	slli	a5,s0,0x7
    2058:	0007da63          	bgez	a5,206c <__muldf3+0x4e4>
    205c:	ff0007b7          	lui	a5,0xff000
    2060:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf9c2f>
    2064:	00f47433          	and	s0,s0,a5
    2068:	400b0713          	addi	a4,s6,1024
    206c:	7fe00793          	li	a5,2046
    2070:	14e7ca63          	blt	a5,a4,21c4 <__muldf3+0x63c>
    2074:	0034d793          	srli	a5,s1,0x3
    2078:	01d41493          	slli	s1,s0,0x1d
    207c:	00941413          	slli	s0,s0,0x9
    2080:	00f4e4b3          	or	s1,s1,a5
    2084:	00c45413          	srli	s0,s0,0xc
    2088:	7ff77793          	andi	a5,a4,2047
    208c:	c0dff06f          	j	1c98 <__muldf3+0x110>
    2090:	00060513          	mv	a0,a2
    2094:	00c12423          	sw	a2,8(sp)
    2098:	7f5000ef          	jal	ra,308c <__clzsi2>
    209c:	01550693          	addi	a3,a0,21
    20a0:	01c00713          	li	a4,28
    20a4:	02050793          	addi	a5,a0,32
    20a8:	00812603          	lw	a2,8(sp)
    20ac:	d0d754e3          	bge	a4,a3,1db4 <__muldf3+0x22c>
    20b0:	ff850513          	addi	a0,a0,-8
    20b4:	00000593          	li	a1,0
    20b8:	00a61933          	sll	s2,a2,a0
    20bc:	d15ff06f          	j	1dd0 <__muldf3+0x248>
    20c0:	7cd000ef          	jal	ra,308c <__clzsi2>
    20c4:	01550593          	addi	a1,a0,21
    20c8:	01c00713          	li	a4,28
    20cc:	02050793          	addi	a5,a0,32
    20d0:	00812603          	lw	a2,8(sp)
    20d4:	00c12683          	lw	a3,12(sp)
    20d8:	c6b75ae3          	bge	a4,a1,1d4c <__muldf3+0x1c4>
    20dc:	ff850513          	addi	a0,a0,-8
    20e0:	00000493          	li	s1,0
    20e4:	00a91433          	sll	s0,s2,a0
    20e8:	c81ff06f          	j	1d68 <__muldf3+0x1e0>
    20ec:	00100613          	li	a2,1
    20f0:	40e60633          	sub	a2,a2,a4
    20f4:	06071063          	bnez	a4,2154 <__muldf3+0x5cc>
    20f8:	41eb0793          	addi	a5,s6,1054
    20fc:	00f49733          	sll	a4,s1,a5
    2100:	00f417b3          	sll	a5,s0,a5
    2104:	00c4d4b3          	srl	s1,s1,a2
    2108:	0097e4b3          	or	s1,a5,s1
    210c:	00e03733          	snez	a4,a4
    2110:	00e4e4b3          	or	s1,s1,a4
    2114:	0074f793          	andi	a5,s1,7
    2118:	00c45633          	srl	a2,s0,a2
    211c:	02078063          	beqz	a5,213c <__muldf3+0x5b4>
    2120:	00f4f793          	andi	a5,s1,15
    2124:	00400713          	li	a4,4
    2128:	00e78a63          	beq	a5,a4,213c <__muldf3+0x5b4>
    212c:	00448793          	addi	a5,s1,4
    2130:	0097b4b3          	sltu	s1,a5,s1
    2134:	00960633          	add	a2,a2,s1
    2138:	00078493          	mv	s1,a5
    213c:	00861793          	slli	a5,a2,0x8
    2140:	0607d463          	bgez	a5,21a8 <__muldf3+0x620>
    2144:	00100793          	li	a5,1
    2148:	00000413          	li	s0,0
    214c:	00000493          	li	s1,0
    2150:	b49ff06f          	j	1c98 <__muldf3+0x110>
    2154:	03800793          	li	a5,56
    2158:	bac7cce3          	blt	a5,a2,1d10 <__muldf3+0x188>
    215c:	01f00793          	li	a5,31
    2160:	f8c7dce3          	bge	a5,a2,20f8 <__muldf3+0x570>
    2164:	fe100793          	li	a5,-31
    2168:	40e78733          	sub	a4,a5,a4
    216c:	02000793          	li	a5,32
    2170:	00e45733          	srl	a4,s0,a4
    2174:	00f60863          	beq	a2,a5,2184 <__muldf3+0x5fc>
    2178:	43eb0793          	addi	a5,s6,1086
    217c:	00f417b3          	sll	a5,s0,a5
    2180:	00f4e4b3          	or	s1,s1,a5
    2184:	009034b3          	snez	s1,s1
    2188:	00e4e4b3          	or	s1,s1,a4
    218c:	0074f613          	andi	a2,s1,7
    2190:	00000413          	li	s0,0
    2194:	02060063          	beqz	a2,21b4 <__muldf3+0x62c>
    2198:	00f4f793          	andi	a5,s1,15
    219c:	00400713          	li	a4,4
    21a0:	00000613          	li	a2,0
    21a4:	f8e794e3          	bne	a5,a4,212c <__muldf3+0x5a4>
    21a8:	00961413          	slli	s0,a2,0x9
    21ac:	00c45413          	srli	s0,s0,0xc
    21b0:	01d61613          	slli	a2,a2,0x1d
    21b4:	0034d493          	srli	s1,s1,0x3
    21b8:	00c4e4b3          	or	s1,s1,a2
    21bc:	00000793          	li	a5,0
    21c0:	ad9ff06f          	j	1c98 <__muldf3+0x110>
    21c4:	7ff00793          	li	a5,2047
    21c8:	00000413          	li	s0,0
    21cc:	00000493          	li	s1,0
    21d0:	ac9ff06f          	j	1c98 <__muldf3+0x110>
    21d4:	00060b13          	mv	s6,a2
    21d8:	e51ff06f          	j	2028 <__muldf3+0x4a0>

000021dc <__subdf3>:
    21dc:	00100737          	lui	a4,0x100
    21e0:	fff70713          	addi	a4,a4,-1 # fffff <__global_pointer$+0xf9467>
    21e4:	fe010113          	addi	sp,sp,-32
    21e8:	00b77333          	and	t1,a4,a1
    21ec:	0146d893          	srli	a7,a3,0x14
    21f0:	00d77733          	and	a4,a4,a3
    21f4:	01d65e93          	srli	t4,a2,0x1d
    21f8:	00812c23          	sw	s0,24(sp)
    21fc:	00912a23          	sw	s1,20(sp)
    2200:	00331313          	slli	t1,t1,0x3
    2204:	0145d493          	srli	s1,a1,0x14
    2208:	01d55793          	srli	a5,a0,0x1d
    220c:	00371713          	slli	a4,a4,0x3
    2210:	00112e23          	sw	ra,28(sp)
    2214:	01212823          	sw	s2,16(sp)
    2218:	01312623          	sw	s3,12(sp)
    221c:	7ff8f893          	andi	a7,a7,2047
    2220:	7ff00e13          	li	t3,2047
    2224:	00eee733          	or	a4,t4,a4
    2228:	7ff4f493          	andi	s1,s1,2047
    222c:	01f5d413          	srli	s0,a1,0x1f
    2230:	0067e333          	or	t1,a5,t1
    2234:	00351f13          	slli	t5,a0,0x3
    2238:	01f6d693          	srli	a3,a3,0x1f
    223c:	00361e93          	slli	t4,a2,0x3
    2240:	1dc88663          	beq	a7,t3,240c <__subdf3+0x230>
    2244:	0016c693          	xori	a3,a3,1
    2248:	411485b3          	sub	a1,s1,a7
    224c:	16d40863          	beq	s0,a3,23bc <__subdf3+0x1e0>
    2250:	1cb05863          	blez	a1,2420 <__subdf3+0x244>
    2254:	20088463          	beqz	a7,245c <__subdf3+0x280>
    2258:	008007b7          	lui	a5,0x800
    225c:	00f76733          	or	a4,a4,a5
    2260:	67c48a63          	beq	s1,t3,28d4 <__subdf3+0x6f8>
    2264:	03800793          	li	a5,56
    2268:	3eb7c263          	blt	a5,a1,264c <__subdf3+0x470>
    226c:	01f00793          	li	a5,31
    2270:	54b7ca63          	blt	a5,a1,27c4 <__subdf3+0x5e8>
    2274:	02000793          	li	a5,32
    2278:	40b787b3          	sub	a5,a5,a1
    227c:	00bed9b3          	srl	s3,t4,a1
    2280:	00f71833          	sll	a6,a4,a5
    2284:	00fe9eb3          	sll	t4,t4,a5
    2288:	01386833          	or	a6,a6,s3
    228c:	00b75733          	srl	a4,a4,a1
    2290:	01d039b3          	snez	s3,t4
    2294:	01386833          	or	a6,a6,s3
    2298:	40e30333          	sub	t1,t1,a4
    229c:	410f09b3          	sub	s3,t5,a6
    22a0:	013f37b3          	sltu	a5,t5,s3
    22a4:	40f30633          	sub	a2,t1,a5
    22a8:	00861793          	slli	a5,a2,0x8
    22ac:	2a07d863          	bgez	a5,255c <__subdf3+0x380>
    22b0:	00800937          	lui	s2,0x800
    22b4:	fff90913          	addi	s2,s2,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    22b8:	01267933          	and	s2,a2,s2
    22bc:	36090663          	beqz	s2,2628 <__subdf3+0x44c>
    22c0:	00090513          	mv	a0,s2
    22c4:	5c9000ef          	jal	ra,308c <__clzsi2>
    22c8:	ff850713          	addi	a4,a0,-8
    22cc:	02000793          	li	a5,32
    22d0:	40e787b3          	sub	a5,a5,a4
    22d4:	00f9d7b3          	srl	a5,s3,a5
    22d8:	00e91633          	sll	a2,s2,a4
    22dc:	00c7e7b3          	or	a5,a5,a2
    22e0:	00e999b3          	sll	s3,s3,a4
    22e4:	32974463          	blt	a4,s1,260c <__subdf3+0x430>
    22e8:	40970733          	sub	a4,a4,s1
    22ec:	00170613          	addi	a2,a4,1
    22f0:	01f00693          	li	a3,31
    22f4:	44c6ca63          	blt	a3,a2,2748 <__subdf3+0x56c>
    22f8:	02000713          	li	a4,32
    22fc:	40c70733          	sub	a4,a4,a2
    2300:	00c9d6b3          	srl	a3,s3,a2
    2304:	00e99833          	sll	a6,s3,a4
    2308:	00e79733          	sll	a4,a5,a4
    230c:	00d76733          	or	a4,a4,a3
    2310:	01003833          	snez	a6,a6
    2314:	010769b3          	or	s3,a4,a6
    2318:	00c7d633          	srl	a2,a5,a2
    231c:	00000493          	li	s1,0
    2320:	0079f793          	andi	a5,s3,7
    2324:	02078063          	beqz	a5,2344 <__subdf3+0x168>
    2328:	00f9f693          	andi	a3,s3,15
    232c:	00400793          	li	a5,4
    2330:	00f68a63          	beq	a3,a5,2344 <__subdf3+0x168>
    2334:	00498693          	addi	a3,s3,4
    2338:	0136b833          	sltu	a6,a3,s3
    233c:	01060633          	add	a2,a2,a6
    2340:	00068993          	mv	s3,a3
    2344:	00861793          	slli	a5,a2,0x8
    2348:	2007de63          	bgez	a5,2564 <__subdf3+0x388>
    234c:	00148713          	addi	a4,s1,1
    2350:	7ff00793          	li	a5,2047
    2354:	00147413          	andi	s0,s0,1
    2358:	26f70463          	beq	a4,a5,25c0 <__subdf3+0x3e4>
    235c:	ff8007b7          	lui	a5,0xff800
    2360:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    2364:	00f677b3          	and	a5,a2,a5
    2368:	01d79813          	slli	a6,a5,0x1d
    236c:	0039d993          	srli	s3,s3,0x3
    2370:	00979793          	slli	a5,a5,0x9
    2374:	01386833          	or	a6,a6,s3
    2378:	00c7d793          	srli	a5,a5,0xc
    237c:	7ff77713          	andi	a4,a4,2047
    2380:	00c79693          	slli	a3,a5,0xc
    2384:	01471713          	slli	a4,a4,0x14
    2388:	00c6d693          	srli	a3,a3,0xc
    238c:	01f41413          	slli	s0,s0,0x1f
    2390:	00e6e6b3          	or	a3,a3,a4
    2394:	0086e6b3          	or	a3,a3,s0
    2398:	01c12083          	lw	ra,28(sp)
    239c:	01812403          	lw	s0,24(sp)
    23a0:	01412483          	lw	s1,20(sp)
    23a4:	01012903          	lw	s2,16(sp)
    23a8:	00c12983          	lw	s3,12(sp)
    23ac:	00080513          	mv	a0,a6
    23b0:	00068593          	mv	a1,a3
    23b4:	02010113          	addi	sp,sp,32
    23b8:	00008067          	ret
    23bc:	0ab05e63          	blez	a1,2478 <__subdf3+0x29c>
    23c0:	14088a63          	beqz	a7,2514 <__subdf3+0x338>
    23c4:	008007b7          	lui	a5,0x800
    23c8:	00f76733          	or	a4,a4,a5
    23cc:	33c48c63          	beq	s1,t3,2704 <__subdf3+0x528>
    23d0:	03800793          	li	a5,56
    23d4:	1cb7c063          	blt	a5,a1,2594 <__subdf3+0x3b8>
    23d8:	01f00793          	li	a5,31
    23dc:	44b7da63          	bge	a5,a1,2830 <__subdf3+0x654>
    23e0:	fe058813          	addi	a6,a1,-32
    23e4:	02000793          	li	a5,32
    23e8:	010759b3          	srl	s3,a4,a6
    23ec:	00f58a63          	beq	a1,a5,2400 <__subdf3+0x224>
    23f0:	04000793          	li	a5,64
    23f4:	40b785b3          	sub	a1,a5,a1
    23f8:	00b71733          	sll	a4,a4,a1
    23fc:	00eeeeb3          	or	t4,t4,a4
    2400:	01d03833          	snez	a6,t4
    2404:	01386833          	or	a6,a6,s3
    2408:	1940006f          	j	259c <__subdf3+0x3c0>
    240c:	01d767b3          	or	a5,a4,t4
    2410:	80148593          	addi	a1,s1,-2047
    2414:	00079463          	bnez	a5,241c <__subdf3+0x240>
    2418:	0016c693          	xori	a3,a3,1
    241c:	04d40e63          	beq	s0,a3,2478 <__subdf3+0x29c>
    2420:	08059a63          	bnez	a1,24b4 <__subdf3+0x2d8>
    2424:	00148793          	addi	a5,s1,1
    2428:	7fe7f793          	andi	a5,a5,2046
    242c:	24079263          	bnez	a5,2670 <__subdf3+0x494>
    2430:	01e367b3          	or	a5,t1,t5
    2434:	01d76833          	or	a6,a4,t4
    2438:	18049c63          	bnez	s1,25d0 <__subdf3+0x3f4>
    243c:	46078063          	beqz	a5,289c <__subdf3+0x6c0>
    2440:	4c081e63          	bnez	a6,291c <__subdf3+0x740>
    2444:	00351813          	slli	a6,a0,0x3
    2448:	01d31693          	slli	a3,t1,0x1d
    244c:	00385813          	srli	a6,a6,0x3
    2450:	0106e833          	or	a6,a3,a6
    2454:	00335793          	srli	a5,t1,0x3
    2458:	1280006f          	j	2580 <__subdf3+0x3a4>
    245c:	01d767b3          	or	a5,a4,t4
    2460:	1e078c63          	beqz	a5,2658 <__subdf3+0x47c>
    2464:	fff58793          	addi	a5,a1,-1
    2468:	44078a63          	beqz	a5,28bc <__subdf3+0x6e0>
    246c:	29c58c63          	beq	a1,t3,2704 <__subdf3+0x528>
    2470:	00078593          	mv	a1,a5
    2474:	df1ff06f          	j	2264 <__subdf3+0x88>
    2478:	22059263          	bnez	a1,269c <__subdf3+0x4c0>
    247c:	00148693          	addi	a3,s1,1
    2480:	7fe6f793          	andi	a5,a3,2046
    2484:	0a079663          	bnez	a5,2530 <__subdf3+0x354>
    2488:	01e367b3          	or	a5,t1,t5
    248c:	3e049663          	bnez	s1,2878 <__subdf3+0x69c>
    2490:	50078863          	beqz	a5,29a0 <__subdf3+0x7c4>
    2494:	01d767b3          	or	a5,a4,t4
    2498:	52079063          	bnez	a5,29b8 <__subdf3+0x7dc>
    249c:	00351513          	slli	a0,a0,0x3
    24a0:	01d31813          	slli	a6,t1,0x1d
    24a4:	00355513          	srli	a0,a0,0x3
    24a8:	00a86833          	or	a6,a6,a0
    24ac:	00335793          	srli	a5,t1,0x3
    24b0:	0d00006f          	j	2580 <__subdf3+0x3a4>
    24b4:	409885b3          	sub	a1,a7,s1
    24b8:	26049263          	bnez	s1,271c <__subdf3+0x540>
    24bc:	01e367b3          	or	a5,t1,t5
    24c0:	38078e63          	beqz	a5,285c <__subdf3+0x680>
    24c4:	fff58793          	addi	a5,a1,-1
    24c8:	4a078e63          	beqz	a5,2984 <__subdf3+0x7a8>
    24cc:	7ff00513          	li	a0,2047
    24d0:	24a58e63          	beq	a1,a0,272c <__subdf3+0x550>
    24d4:	00078593          	mv	a1,a5
    24d8:	03800793          	li	a5,56
    24dc:	30b7ca63          	blt	a5,a1,27f0 <__subdf3+0x614>
    24e0:	01f00793          	li	a5,31
    24e4:	46b7ca63          	blt	a5,a1,2958 <__subdf3+0x77c>
    24e8:	02000793          	li	a5,32
    24ec:	40b787b3          	sub	a5,a5,a1
    24f0:	00f31833          	sll	a6,t1,a5
    24f4:	00bf5633          	srl	a2,t5,a1
    24f8:	00ff17b3          	sll	a5,t5,a5
    24fc:	00c86833          	or	a6,a6,a2
    2500:	00f039b3          	snez	s3,a5
    2504:	00b35333          	srl	t1,t1,a1
    2508:	01386833          	or	a6,a6,s3
    250c:	40670733          	sub	a4,a4,t1
    2510:	2e80006f          	j	27f8 <__subdf3+0x61c>
    2514:	01d767b3          	or	a5,a4,t4
    2518:	14078063          	beqz	a5,2658 <__subdf3+0x47c>
    251c:	fff58793          	addi	a5,a1,-1
    2520:	24078e63          	beqz	a5,277c <__subdf3+0x5a0>
    2524:	37c58063          	beq	a1,t3,2884 <__subdf3+0x6a8>
    2528:	00078593          	mv	a1,a5
    252c:	ea5ff06f          	j	23d0 <__subdf3+0x1f4>
    2530:	7ff00793          	li	a5,2047
    2534:	08f68463          	beq	a3,a5,25bc <__subdf3+0x3e0>
    2538:	01df0eb3          	add	t4,t5,t4
    253c:	01eeb633          	sltu	a2,t4,t5
    2540:	00e307b3          	add	a5,t1,a4
    2544:	00c787b3          	add	a5,a5,a2
    2548:	01f79813          	slli	a6,a5,0x1f
    254c:	001ede93          	srli	t4,t4,0x1
    2550:	01d869b3          	or	s3,a6,t4
    2554:	0017d613          	srli	a2,a5,0x1
    2558:	00068493          	mv	s1,a3
    255c:	0079f793          	andi	a5,s3,7
    2560:	dc0794e3          	bnez	a5,2328 <__subdf3+0x14c>
    2564:	01d61793          	slli	a5,a2,0x1d
    2568:	0039d813          	srli	a6,s3,0x3
    256c:	00f86833          	or	a6,a6,a5
    2570:	00048593          	mv	a1,s1
    2574:	00365793          	srli	a5,a2,0x3
    2578:	7ff00713          	li	a4,2047
    257c:	06e58a63          	beq	a1,a4,25f0 <__subdf3+0x414>
    2580:	00c79793          	slli	a5,a5,0xc
    2584:	00c7d793          	srli	a5,a5,0xc
    2588:	7ff5f713          	andi	a4,a1,2047
    258c:	00147413          	andi	s0,s0,1
    2590:	df1ff06f          	j	2380 <__subdf3+0x1a4>
    2594:	01d76733          	or	a4,a4,t4
    2598:	00e03833          	snez	a6,a4
    259c:	01e809b3          	add	s3,a6,t5
    25a0:	01e9b7b3          	sltu	a5,s3,t5
    25a4:	00678633          	add	a2,a5,t1
    25a8:	00861793          	slli	a5,a2,0x8
    25ac:	fa07d8e3          	bgez	a5,255c <__subdf3+0x380>
    25b0:	00148493          	addi	s1,s1,1
    25b4:	7ff00793          	li	a5,2047
    25b8:	1ef49263          	bne	s1,a5,279c <__subdf3+0x5c0>
    25bc:	00147413          	andi	s0,s0,1
    25c0:	7ff00713          	li	a4,2047
    25c4:	00000793          	li	a5,0
    25c8:	00000813          	li	a6,0
    25cc:	db5ff06f          	j	2380 <__subdf3+0x1a4>
    25d0:	12079863          	bnez	a5,2700 <__subdf3+0x524>
    25d4:	46080063          	beqz	a6,2a34 <__subdf3+0x858>
    25d8:	00361813          	slli	a6,a2,0x3
    25dc:	01d71793          	slli	a5,a4,0x1d
    25e0:	00385813          	srli	a6,a6,0x3
    25e4:	00f86833          	or	a6,a6,a5
    25e8:	00068413          	mv	s0,a3
    25ec:	00375793          	srli	a5,a4,0x3
    25f0:	00f867b3          	or	a5,a6,a5
    25f4:	fc0784e3          	beqz	a5,25bc <__subdf3+0x3e0>
    25f8:	00000413          	li	s0,0
    25fc:	7ff00713          	li	a4,2047
    2600:	000807b7          	lui	a5,0x80
    2604:	00000813          	li	a6,0
    2608:	d79ff06f          	j	2380 <__subdf3+0x1a4>
    260c:	ff800637          	lui	a2,0xff800
    2610:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    2614:	00c7f633          	and	a2,a5,a2
    2618:	0079f793          	andi	a5,s3,7
    261c:	40e484b3          	sub	s1,s1,a4
    2620:	d00794e3          	bnez	a5,2328 <__subdf3+0x14c>
    2624:	f41ff06f          	j	2564 <__subdf3+0x388>
    2628:	00098513          	mv	a0,s3
    262c:	261000ef          	jal	ra,308c <__clzsi2>
    2630:	01850713          	addi	a4,a0,24
    2634:	01f00793          	li	a5,31
    2638:	c8e7dae3          	bge	a5,a4,22cc <__subdf3+0xf0>
    263c:	ff850613          	addi	a2,a0,-8
    2640:	00c997b3          	sll	a5,s3,a2
    2644:	00000993          	li	s3,0
    2648:	c9dff06f          	j	22e4 <__subdf3+0x108>
    264c:	01d76833          	or	a6,a4,t4
    2650:	01003833          	snez	a6,a6
    2654:	c49ff06f          	j	229c <__subdf3+0xc0>
    2658:	00351813          	slli	a6,a0,0x3
    265c:	01d31793          	slli	a5,t1,0x1d
    2660:	00385813          	srli	a6,a6,0x3
    2664:	00f86833          	or	a6,a6,a5
    2668:	00335793          	srli	a5,t1,0x3
    266c:	f0dff06f          	j	2578 <__subdf3+0x39c>
    2670:	41df09b3          	sub	s3,t5,t4
    2674:	40e30933          	sub	s2,t1,a4
    2678:	013f3633          	sltu	a2,t5,s3
    267c:	40c90933          	sub	s2,s2,a2
    2680:	00891793          	slli	a5,s2,0x8
    2684:	2607c463          	bltz	a5,28ec <__subdf3+0x710>
    2688:	0129e833          	or	a6,s3,s2
    268c:	c20818e3          	bnez	a6,22bc <__subdf3+0xe0>
    2690:	00000793          	li	a5,0
    2694:	00000413          	li	s0,0
    2698:	ee9ff06f          	j	2580 <__subdf3+0x3a4>
    269c:	409885b3          	sub	a1,a7,s1
    26a0:	16048863          	beqz	s1,2810 <__subdf3+0x634>
    26a4:	008006b7          	lui	a3,0x800
    26a8:	7ff00793          	li	a5,2047
    26ac:	00d36333          	or	t1,t1,a3
    26b0:	24f88a63          	beq	a7,a5,2904 <__subdf3+0x728>
    26b4:	03800793          	li	a5,56
    26b8:	28b7ca63          	blt	a5,a1,294c <__subdf3+0x770>
    26bc:	01f00793          	li	a5,31
    26c0:	34b7c463          	blt	a5,a1,2a08 <__subdf3+0x82c>
    26c4:	02000793          	li	a5,32
    26c8:	40b787b3          	sub	a5,a5,a1
    26cc:	00f31833          	sll	a6,t1,a5
    26d0:	00bf56b3          	srl	a3,t5,a1
    26d4:	00ff17b3          	sll	a5,t5,a5
    26d8:	00d86833          	or	a6,a6,a3
    26dc:	00f039b3          	snez	s3,a5
    26e0:	00b35333          	srl	t1,t1,a1
    26e4:	01386833          	or	a6,a6,s3
    26e8:	00670733          	add	a4,a4,t1
    26ec:	01d809b3          	add	s3,a6,t4
    26f0:	01d9b7b3          	sltu	a5,s3,t4
    26f4:	00e78633          	add	a2,a5,a4
    26f8:	00088493          	mv	s1,a7
    26fc:	eadff06f          	j	25a8 <__subdf3+0x3cc>
    2700:	ee081ce3          	bnez	a6,25f8 <__subdf3+0x41c>
    2704:	00351813          	slli	a6,a0,0x3
    2708:	01d31793          	slli	a5,t1,0x1d
    270c:	00385813          	srli	a6,a6,0x3
    2710:	00f86833          	or	a6,a6,a5
    2714:	00335793          	srli	a5,t1,0x3
    2718:	ed9ff06f          	j	25f0 <__subdf3+0x414>
    271c:	00800537          	lui	a0,0x800
    2720:	7ff00793          	li	a5,2047
    2724:	00a36333          	or	t1,t1,a0
    2728:	daf898e3          	bne	a7,a5,24d8 <__subdf3+0x2fc>
    272c:	00361613          	slli	a2,a2,0x3
    2730:	01d71813          	slli	a6,a4,0x1d
    2734:	00365613          	srli	a2,a2,0x3
    2738:	00c86833          	or	a6,a6,a2
    273c:	00375793          	srli	a5,a4,0x3
    2740:	00068413          	mv	s0,a3
    2744:	eadff06f          	j	25f0 <__subdf3+0x414>
    2748:	fe170713          	addi	a4,a4,-31
    274c:	02000693          	li	a3,32
    2750:	00e7d733          	srl	a4,a5,a4
    2754:	00d60a63          	beq	a2,a3,2768 <__subdf3+0x58c>
    2758:	04000693          	li	a3,64
    275c:	40c68633          	sub	a2,a3,a2
    2760:	00c79633          	sll	a2,a5,a2
    2764:	00c9e9b3          	or	s3,s3,a2
    2768:	01303833          	snez	a6,s3
    276c:	00e869b3          	or	s3,a6,a4
    2770:	00000613          	li	a2,0
    2774:	00000493          	li	s1,0
    2778:	de5ff06f          	j	255c <__subdf3+0x380>
    277c:	01df09b3          	add	s3,t5,t4
    2780:	00e307b3          	add	a5,t1,a4
    2784:	01e9bf33          	sltu	t5,s3,t5
    2788:	01e78633          	add	a2,a5,t5
    278c:	00861793          	slli	a5,a2,0x8
    2790:	00100493          	li	s1,1
    2794:	dc07d4e3          	bgez	a5,255c <__subdf3+0x380>
    2798:	00200493          	li	s1,2
    279c:	ff8007b7          	lui	a5,0xff800
    27a0:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    27a4:	00f677b3          	and	a5,a2,a5
    27a8:	0019d713          	srli	a4,s3,0x1
    27ac:	0019f813          	andi	a6,s3,1
    27b0:	01076833          	or	a6,a4,a6
    27b4:	01f79993          	slli	s3,a5,0x1f
    27b8:	0109e9b3          	or	s3,s3,a6
    27bc:	0017d613          	srli	a2,a5,0x1
    27c0:	b61ff06f          	j	2320 <__subdf3+0x144>
    27c4:	fe058813          	addi	a6,a1,-32
    27c8:	02000793          	li	a5,32
    27cc:	010759b3          	srl	s3,a4,a6
    27d0:	00f58a63          	beq	a1,a5,27e4 <__subdf3+0x608>
    27d4:	04000793          	li	a5,64
    27d8:	40b785b3          	sub	a1,a5,a1
    27dc:	00b71733          	sll	a4,a4,a1
    27e0:	00eeeeb3          	or	t4,t4,a4
    27e4:	01d03833          	snez	a6,t4
    27e8:	01386833          	or	a6,a6,s3
    27ec:	ab1ff06f          	j	229c <__subdf3+0xc0>
    27f0:	01e36333          	or	t1,t1,t5
    27f4:	00603833          	snez	a6,t1
    27f8:	410e89b3          	sub	s3,t4,a6
    27fc:	013eb7b3          	sltu	a5,t4,s3
    2800:	40f70633          	sub	a2,a4,a5
    2804:	00088493          	mv	s1,a7
    2808:	00068413          	mv	s0,a3
    280c:	a9dff06f          	j	22a8 <__subdf3+0xcc>
    2810:	01e367b3          	or	a5,t1,t5
    2814:	1c078863          	beqz	a5,29e4 <__subdf3+0x808>
    2818:	fff58793          	addi	a5,a1,-1
    281c:	22078463          	beqz	a5,2a44 <__subdf3+0x868>
    2820:	7ff00693          	li	a3,2047
    2824:	0ed58063          	beq	a1,a3,2904 <__subdf3+0x728>
    2828:	00078593          	mv	a1,a5
    282c:	e89ff06f          	j	26b4 <__subdf3+0x4d8>
    2830:	02000793          	li	a5,32
    2834:	40b787b3          	sub	a5,a5,a1
    2838:	00bed9b3          	srl	s3,t4,a1
    283c:	00f71833          	sll	a6,a4,a5
    2840:	00fe9eb3          	sll	t4,t4,a5
    2844:	01386833          	or	a6,a6,s3
    2848:	00b75733          	srl	a4,a4,a1
    284c:	01d039b3          	snez	s3,t4
    2850:	01386833          	or	a6,a6,s3
    2854:	00e30333          	add	t1,t1,a4
    2858:	d45ff06f          	j	259c <__subdf3+0x3c0>
    285c:	00361813          	slli	a6,a2,0x3
    2860:	01d71793          	slli	a5,a4,0x1d
    2864:	00385813          	srli	a6,a6,0x3
    2868:	0107e833          	or	a6,a5,a6
    286c:	00068413          	mv	s0,a3
    2870:	00375793          	srli	a5,a4,0x3
    2874:	d05ff06f          	j	2578 <__subdf3+0x39c>
    2878:	08078663          	beqz	a5,2904 <__subdf3+0x728>
    287c:	01d76733          	or	a4,a4,t4
    2880:	d6071ce3          	bnez	a4,25f8 <__subdf3+0x41c>
    2884:	00351513          	slli	a0,a0,0x3
    2888:	01d31813          	slli	a6,t1,0x1d
    288c:	00355513          	srli	a0,a0,0x3
    2890:	00a86833          	or	a6,a6,a0
    2894:	00335793          	srli	a5,t1,0x3
    2898:	d59ff06f          	j	25f0 <__subdf3+0x414>
    289c:	de080ae3          	beqz	a6,2690 <__subdf3+0x4b4>
    28a0:	00361813          	slli	a6,a2,0x3
    28a4:	01d71793          	slli	a5,a4,0x1d
    28a8:	00385813          	srli	a6,a6,0x3
    28ac:	00f86833          	or	a6,a6,a5
    28b0:	00068413          	mv	s0,a3
    28b4:	00375793          	srli	a5,a4,0x3
    28b8:	cc9ff06f          	j	2580 <__subdf3+0x3a4>
    28bc:	41df09b3          	sub	s3,t5,t4
    28c0:	40e307b3          	sub	a5,t1,a4
    28c4:	013f3f33          	sltu	t5,t5,s3
    28c8:	41e78633          	sub	a2,a5,t5
    28cc:	00100493          	li	s1,1
    28d0:	9d9ff06f          	j	22a8 <__subdf3+0xcc>
    28d4:	00351813          	slli	a6,a0,0x3
    28d8:	01d31693          	slli	a3,t1,0x1d
    28dc:	00385813          	srli	a6,a6,0x3
    28e0:	0106e833          	or	a6,a3,a6
    28e4:	00335793          	srli	a5,t1,0x3
    28e8:	d09ff06f          	j	25f0 <__subdf3+0x414>
    28ec:	41ee89b3          	sub	s3,t4,t5
    28f0:	40670633          	sub	a2,a4,t1
    28f4:	013eb933          	sltu	s2,t4,s3
    28f8:	41260933          	sub	s2,a2,s2
    28fc:	00068413          	mv	s0,a3
    2900:	9bdff06f          	j	22bc <__subdf3+0xe0>
    2904:	00361613          	slli	a2,a2,0x3
    2908:	01d71813          	slli	a6,a4,0x1d
    290c:	00365613          	srli	a2,a2,0x3
    2910:	00c86833          	or	a6,a6,a2
    2914:	00375793          	srli	a5,a4,0x3
    2918:	cd9ff06f          	j	25f0 <__subdf3+0x414>
    291c:	41df09b3          	sub	s3,t5,t4
    2920:	40e307b3          	sub	a5,t1,a4
    2924:	013f3633          	sltu	a2,t5,s3
    2928:	40c78633          	sub	a2,a5,a2
    292c:	00861793          	slli	a5,a2,0x8
    2930:	0c07d663          	bgez	a5,29fc <__subdf3+0x820>
    2934:	41ee89b3          	sub	s3,t4,t5
    2938:	406707b3          	sub	a5,a4,t1
    293c:	013ebeb3          	sltu	t4,t4,s3
    2940:	41d78633          	sub	a2,a5,t4
    2944:	00068413          	mv	s0,a3
    2948:	9d9ff06f          	j	2320 <__subdf3+0x144>
    294c:	01e36333          	or	t1,t1,t5
    2950:	00603833          	snez	a6,t1
    2954:	d99ff06f          	j	26ec <__subdf3+0x510>
    2958:	fe058813          	addi	a6,a1,-32
    295c:	02000793          	li	a5,32
    2960:	010359b3          	srl	s3,t1,a6
    2964:	00f58a63          	beq	a1,a5,2978 <__subdf3+0x79c>
    2968:	04000793          	li	a5,64
    296c:	40b785b3          	sub	a1,a5,a1
    2970:	00b31333          	sll	t1,t1,a1
    2974:	006f6f33          	or	t5,t5,t1
    2978:	01e03833          	snez	a6,t5
    297c:	01386833          	or	a6,a6,s3
    2980:	e79ff06f          	j	27f8 <__subdf3+0x61c>
    2984:	41ee89b3          	sub	s3,t4,t5
    2988:	406707b3          	sub	a5,a4,t1
    298c:	013ebeb3          	sltu	t4,t4,s3
    2990:	41d78633          	sub	a2,a5,t4
    2994:	00068413          	mv	s0,a3
    2998:	00100493          	li	s1,1
    299c:	90dff06f          	j	22a8 <__subdf3+0xcc>
    29a0:	00361813          	slli	a6,a2,0x3
    29a4:	01d71793          	slli	a5,a4,0x1d
    29a8:	00385813          	srli	a6,a6,0x3
    29ac:	00f86833          	or	a6,a6,a5
    29b0:	00375793          	srli	a5,a4,0x3
    29b4:	bcdff06f          	j	2580 <__subdf3+0x3a4>
    29b8:	01df09b3          	add	s3,t5,t4
    29bc:	00e307b3          	add	a5,t1,a4
    29c0:	01e9bf33          	sltu	t5,s3,t5
    29c4:	01e78633          	add	a2,a5,t5
    29c8:	00861793          	slli	a5,a2,0x8
    29cc:	b807d8e3          	bgez	a5,255c <__subdf3+0x380>
    29d0:	ff8007b7          	lui	a5,0xff800
    29d4:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    29d8:	00f67633          	and	a2,a2,a5
    29dc:	00100493          	li	s1,1
    29e0:	b7dff06f          	j	255c <__subdf3+0x380>
    29e4:	00361613          	slli	a2,a2,0x3
    29e8:	01d71813          	slli	a6,a4,0x1d
    29ec:	00365613          	srli	a2,a2,0x3
    29f0:	00c86833          	or	a6,a6,a2
    29f4:	00375793          	srli	a5,a4,0x3
    29f8:	b81ff06f          	j	2578 <__subdf3+0x39c>
    29fc:	00c9e833          	or	a6,s3,a2
    2a00:	c80808e3          	beqz	a6,2690 <__subdf3+0x4b4>
    2a04:	b59ff06f          	j	255c <__subdf3+0x380>
    2a08:	fe058813          	addi	a6,a1,-32
    2a0c:	02000793          	li	a5,32
    2a10:	010359b3          	srl	s3,t1,a6
    2a14:	00f58a63          	beq	a1,a5,2a28 <__subdf3+0x84c>
    2a18:	04000793          	li	a5,64
    2a1c:	40b785b3          	sub	a1,a5,a1
    2a20:	00b31333          	sll	t1,t1,a1
    2a24:	006f6f33          	or	t5,t5,t1
    2a28:	01e03833          	snez	a6,t5
    2a2c:	01386833          	or	a6,a6,s3
    2a30:	cbdff06f          	j	26ec <__subdf3+0x510>
    2a34:	00000413          	li	s0,0
    2a38:	7ff00713          	li	a4,2047
    2a3c:	000807b7          	lui	a5,0x80
    2a40:	941ff06f          	j	2380 <__subdf3+0x1a4>
    2a44:	01df09b3          	add	s3,t5,t4
    2a48:	00e307b3          	add	a5,t1,a4
    2a4c:	01d9beb3          	sltu	t4,s3,t4
    2a50:	01d78633          	add	a2,a5,t4
    2a54:	d39ff06f          	j	278c <__subdf3+0x5b0>

00002a58 <__fixdfsi>:
    2a58:	0145d793          	srli	a5,a1,0x14
    2a5c:	001006b7          	lui	a3,0x100
    2a60:	fff68713          	addi	a4,a3,-1 # fffff <__global_pointer$+0xf9467>
    2a64:	7ff7f793          	andi	a5,a5,2047
    2a68:	3fe00613          	li	a2,1022
    2a6c:	00b77733          	and	a4,a4,a1
    2a70:	01f5d593          	srli	a1,a1,0x1f
    2a74:	00f65e63          	bge	a2,a5,2a90 <__fixdfsi+0x38>
    2a78:	41d00613          	li	a2,1053
    2a7c:	00f65e63          	bge	a2,a5,2a98 <__fixdfsi+0x40>
    2a80:	80000537          	lui	a0,0x80000
    2a84:	fff54513          	not	a0,a0
    2a88:	00a58533          	add	a0,a1,a0
    2a8c:	00008067          	ret
    2a90:	00000513          	li	a0,0
    2a94:	00008067          	ret
    2a98:	43300613          	li	a2,1075
    2a9c:	40f60633          	sub	a2,a2,a5
    2aa0:	01f00813          	li	a6,31
    2aa4:	00d76733          	or	a4,a4,a3
    2aa8:	02c85063          	bge	a6,a2,2ac8 <__fixdfsi+0x70>
    2aac:	41300693          	li	a3,1043
    2ab0:	40f687b3          	sub	a5,a3,a5
    2ab4:	00f757b3          	srl	a5,a4,a5
    2ab8:	40f00533          	neg	a0,a5
    2abc:	fc059ce3          	bnez	a1,2a94 <__fixdfsi+0x3c>
    2ac0:	00078513          	mv	a0,a5
    2ac4:	00008067          	ret
    2ac8:	bed78793          	addi	a5,a5,-1043 # 7fbed <__global_pointer$+0x79055>
    2acc:	00f717b3          	sll	a5,a4,a5
    2ad0:	00c55533          	srl	a0,a0,a2
    2ad4:	00a7e7b3          	or	a5,a5,a0
    2ad8:	fe1ff06f          	j	2ab8 <__fixdfsi+0x60>

00002adc <__floatsidf>:
    2adc:	ff010113          	addi	sp,sp,-16
    2ae0:	00112623          	sw	ra,12(sp)
    2ae4:	00812423          	sw	s0,8(sp)
    2ae8:	00912223          	sw	s1,4(sp)
    2aec:	04050a63          	beqz	a0,2b40 <__floatsidf+0x64>
    2af0:	41f55793          	srai	a5,a0,0x1f
    2af4:	00a7c4b3          	xor	s1,a5,a0
    2af8:	40f484b3          	sub	s1,s1,a5
    2afc:	00050413          	mv	s0,a0
    2b00:	00048513          	mv	a0,s1
    2b04:	588000ef          	jal	ra,308c <__clzsi2>
    2b08:	41e00693          	li	a3,1054
    2b0c:	40a686b3          	sub	a3,a3,a0
    2b10:	00a00793          	li	a5,10
    2b14:	01f45413          	srli	s0,s0,0x1f
    2b18:	7ff6f693          	andi	a3,a3,2047
    2b1c:	06a7c463          	blt	a5,a0,2b84 <__floatsidf+0xa8>
    2b20:	00b00713          	li	a4,11
    2b24:	40a70733          	sub	a4,a4,a0
    2b28:	00e4d7b3          	srl	a5,s1,a4
    2b2c:	01550513          	addi	a0,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf9c45>
    2b30:	00c79793          	slli	a5,a5,0xc
    2b34:	00a494b3          	sll	s1,s1,a0
    2b38:	00c7d793          	srli	a5,a5,0xc
    2b3c:	0140006f          	j	2b50 <__floatsidf+0x74>
    2b40:	00000413          	li	s0,0
    2b44:	00000693          	li	a3,0
    2b48:	00000793          	li	a5,0
    2b4c:	00000493          	li	s1,0
    2b50:	00c79793          	slli	a5,a5,0xc
    2b54:	01469693          	slli	a3,a3,0x14
    2b58:	00c7d793          	srli	a5,a5,0xc
    2b5c:	01f41413          	slli	s0,s0,0x1f
    2b60:	00d7e7b3          	or	a5,a5,a3
    2b64:	0087e7b3          	or	a5,a5,s0
    2b68:	00c12083          	lw	ra,12(sp)
    2b6c:	00812403          	lw	s0,8(sp)
    2b70:	00048513          	mv	a0,s1
    2b74:	00078593          	mv	a1,a5
    2b78:	00412483          	lw	s1,4(sp)
    2b7c:	01010113          	addi	sp,sp,16
    2b80:	00008067          	ret
    2b84:	ff550513          	addi	a0,a0,-11
    2b88:	00a497b3          	sll	a5,s1,a0
    2b8c:	00c79793          	slli	a5,a5,0xc
    2b90:	00c7d793          	srli	a5,a5,0xc
    2b94:	00000493          	li	s1,0
    2b98:	fb9ff06f          	j	2b50 <__floatsidf+0x74>

00002b9c <__gesf2>:
    2b9c:	01755693          	srli	a3,a0,0x17
    2ba0:	008007b7          	lui	a5,0x800
    2ba4:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    2ba8:	0175d613          	srli	a2,a1,0x17
    2bac:	0ff6f693          	andi	a3,a3,255
    2bb0:	0ff00813          	li	a6,255
    2bb4:	00a7f8b3          	and	a7,a5,a0
    2bb8:	01f55713          	srli	a4,a0,0x1f
    2bbc:	00b7f7b3          	and	a5,a5,a1
    2bc0:	0ff67613          	andi	a2,a2,255
    2bc4:	01f5d513          	srli	a0,a1,0x1f
    2bc8:	03068a63          	beq	a3,a6,2bfc <__gesf2+0x60>
    2bcc:	03060263          	beq	a2,a6,2bf0 <__gesf2+0x54>
    2bd0:	02069a63          	bnez	a3,2c04 <__gesf2+0x68>
    2bd4:	00061463          	bnez	a2,2bdc <__gesf2+0x40>
    2bd8:	04078a63          	beqz	a5,2c2c <__gesf2+0x90>
    2bdc:	04088263          	beqz	a7,2c20 <__gesf2+0x84>
    2be0:	06a70063          	beq	a4,a0,2c40 <__gesf2+0xa4>
    2be4:	00100513          	li	a0,1
    2be8:	02071e63          	bnez	a4,2c24 <__gesf2+0x88>
    2bec:	00008067          	ret
    2bf0:	fe0780e3          	beqz	a5,2bd0 <__gesf2+0x34>
    2bf4:	ffe00513          	li	a0,-2
    2bf8:	00008067          	ret
    2bfc:	fe089ce3          	bnez	a7,2bf4 <__gesf2+0x58>
    2c00:	02d60c63          	beq	a2,a3,2c38 <__gesf2+0x9c>
    2c04:	00061463          	bnez	a2,2c0c <__gesf2+0x70>
    2c08:	fc078ee3          	beqz	a5,2be4 <__gesf2+0x48>
    2c0c:	fca71ce3          	bne	a4,a0,2be4 <__gesf2+0x48>
    2c10:	02d65a63          	bge	a2,a3,2c44 <__gesf2+0xa8>
    2c14:	00051863          	bnez	a0,2c24 <__gesf2+0x88>
    2c18:	00100513          	li	a0,1
    2c1c:	00008067          	ret
    2c20:	fc0516e3          	bnez	a0,2bec <__gesf2+0x50>
    2c24:	fff00513          	li	a0,-1
    2c28:	00008067          	ret
    2c2c:	00000513          	li	a0,0
    2c30:	fa089ae3          	bnez	a7,2be4 <__gesf2+0x48>
    2c34:	00008067          	ret
    2c38:	fc078ae3          	beqz	a5,2c0c <__gesf2+0x70>
    2c3c:	fb9ff06f          	j	2bf4 <__gesf2+0x58>
    2c40:	00000693          	li	a3,0
    2c44:	00c6c863          	blt	a3,a2,2c54 <__gesf2+0xb8>
    2c48:	f917eee3          	bltu	a5,a7,2be4 <__gesf2+0x48>
    2c4c:	00000513          	li	a0,0
    2c50:	f8f8fee3          	bgeu	a7,a5,2bec <__gesf2+0x50>
    2c54:	fc0708e3          	beqz	a4,2c24 <__gesf2+0x88>
    2c58:	00070513          	mv	a0,a4
    2c5c:	00008067          	ret

00002c60 <__lesf2>:
    2c60:	01755693          	srli	a3,a0,0x17
    2c64:	008007b7          	lui	a5,0x800
    2c68:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    2c6c:	0175d613          	srli	a2,a1,0x17
    2c70:	0ff6f693          	andi	a3,a3,255
    2c74:	0ff00813          	li	a6,255
    2c78:	00a7f8b3          	and	a7,a5,a0
    2c7c:	01f55713          	srli	a4,a0,0x1f
    2c80:	00b7f7b3          	and	a5,a5,a1
    2c84:	0ff67613          	andi	a2,a2,255
    2c88:	01f5d513          	srli	a0,a1,0x1f
    2c8c:	05068263          	beq	a3,a6,2cd0 <__lesf2+0x70>
    2c90:	01060e63          	beq	a2,a6,2cac <__lesf2+0x4c>
    2c94:	04069263          	bnez	a3,2cd8 <__lesf2+0x78>
    2c98:	02061063          	bnez	a2,2cb8 <__lesf2+0x58>
    2c9c:	00079e63          	bnez	a5,2cb8 <__lesf2+0x58>
    2ca0:	00000513          	li	a0,0
    2ca4:	00089e63          	bnez	a7,2cc0 <__lesf2+0x60>
    2ca8:	00008067          	ret
    2cac:	fe0784e3          	beqz	a5,2c94 <__lesf2+0x34>
    2cb0:	00200513          	li	a0,2
    2cb4:	00008067          	ret
    2cb8:	02088e63          	beqz	a7,2cf4 <__lesf2+0x94>
    2cbc:	04a70463          	beq	a4,a0,2d04 <__lesf2+0xa4>
    2cc0:	00100513          	li	a0,1
    2cc4:	fe0702e3          	beqz	a4,2ca8 <__lesf2+0x48>
    2cc8:	fff00513          	li	a0,-1
    2ccc:	00008067          	ret
    2cd0:	fe0890e3          	bnez	a7,2cb0 <__lesf2+0x50>
    2cd4:	02d60463          	beq	a2,a3,2cfc <__lesf2+0x9c>
    2cd8:	00061463          	bnez	a2,2ce0 <__lesf2+0x80>
    2cdc:	fe0782e3          	beqz	a5,2cc0 <__lesf2+0x60>
    2ce0:	fea710e3          	bne	a4,a0,2cc0 <__lesf2+0x60>
    2ce4:	02d65263          	bge	a2,a3,2d08 <__lesf2+0xa8>
    2ce8:	fe0510e3          	bnez	a0,2cc8 <__lesf2+0x68>
    2cec:	00100513          	li	a0,1
    2cf0:	00008067          	ret
    2cf4:	fc050ae3          	beqz	a0,2cc8 <__lesf2+0x68>
    2cf8:	00008067          	ret
    2cfc:	fe0782e3          	beqz	a5,2ce0 <__lesf2+0x80>
    2d00:	fb1ff06f          	j	2cb0 <__lesf2+0x50>
    2d04:	00000693          	li	a3,0
    2d08:	00c6c863          	blt	a3,a2,2d18 <__lesf2+0xb8>
    2d0c:	fb17eae3          	bltu	a5,a7,2cc0 <__lesf2+0x60>
    2d10:	00000513          	li	a0,0
    2d14:	f8f8fae3          	bgeu	a7,a5,2ca8 <__lesf2+0x48>
    2d18:	fa0708e3          	beqz	a4,2cc8 <__lesf2+0x68>
    2d1c:	00070513          	mv	a0,a4
    2d20:	00008067          	ret

00002d24 <__fixsfsi>:
    2d24:	00800637          	lui	a2,0x800
    2d28:	01755713          	srli	a4,a0,0x17
    2d2c:	fff60793          	addi	a5,a2,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    2d30:	0ff77713          	andi	a4,a4,255
    2d34:	07e00593          	li	a1,126
    2d38:	00a7f6b3          	and	a3,a5,a0
    2d3c:	01f55793          	srli	a5,a0,0x1f
    2d40:	00e5fe63          	bgeu	a1,a4,2d5c <__fixsfsi+0x38>
    2d44:	09d00593          	li	a1,157
    2d48:	00e5fe63          	bgeu	a1,a4,2d64 <__fixsfsi+0x40>
    2d4c:	80000537          	lui	a0,0x80000
    2d50:	fff54513          	not	a0,a0
    2d54:	00a78533          	add	a0,a5,a0
    2d58:	00008067          	ret
    2d5c:	00000513          	li	a0,0
    2d60:	00008067          	ret
    2d64:	09500593          	li	a1,149
    2d68:	00c6e6b3          	or	a3,a3,a2
    2d6c:	02e5c063          	blt	a1,a4,2d8c <__fixsfsi+0x68>
    2d70:	09600613          	li	a2,150
    2d74:	40e60733          	sub	a4,a2,a4
    2d78:	00e6d733          	srl	a4,a3,a4
    2d7c:	40e00533          	neg	a0,a4
    2d80:	fe0790e3          	bnez	a5,2d60 <__fixsfsi+0x3c>
    2d84:	00070513          	mv	a0,a4
    2d88:	00008067          	ret
    2d8c:	f6a70713          	addi	a4,a4,-150
    2d90:	00e69733          	sll	a4,a3,a4
    2d94:	fe9ff06f          	j	2d7c <__fixsfsi+0x58>

00002d98 <__extendsfdf2>:
    2d98:	01755713          	srli	a4,a0,0x17
    2d9c:	0ff77713          	andi	a4,a4,255
    2da0:	ff010113          	addi	sp,sp,-16
    2da4:	00170793          	addi	a5,a4,1
    2da8:	00812423          	sw	s0,8(sp)
    2dac:	00912223          	sw	s1,4(sp)
    2db0:	00951413          	slli	s0,a0,0x9
    2db4:	00112623          	sw	ra,12(sp)
    2db8:	0fe7f793          	andi	a5,a5,254
    2dbc:	00945413          	srli	s0,s0,0x9
    2dc0:	01f55493          	srli	s1,a0,0x1f
    2dc4:	04078263          	beqz	a5,2e08 <__extendsfdf2+0x70>
    2dc8:	00345793          	srli	a5,s0,0x3
    2dcc:	38070713          	addi	a4,a4,896
    2dd0:	01d41413          	slli	s0,s0,0x1d
    2dd4:	00c79793          	slli	a5,a5,0xc
    2dd8:	01471713          	slli	a4,a4,0x14
    2ddc:	00c7d793          	srli	a5,a5,0xc
    2de0:	01f49513          	slli	a0,s1,0x1f
    2de4:	00e7e7b3          	or	a5,a5,a4
    2de8:	00a7e7b3          	or	a5,a5,a0
    2dec:	00c12083          	lw	ra,12(sp)
    2df0:	00040513          	mv	a0,s0
    2df4:	00812403          	lw	s0,8(sp)
    2df8:	00412483          	lw	s1,4(sp)
    2dfc:	00078593          	mv	a1,a5
    2e00:	01010113          	addi	sp,sp,16
    2e04:	00008067          	ret
    2e08:	04071263          	bnez	a4,2e4c <__extendsfdf2+0xb4>
    2e0c:	06040863          	beqz	s0,2e7c <__extendsfdf2+0xe4>
    2e10:	00040513          	mv	a0,s0
    2e14:	278000ef          	jal	ra,308c <__clzsi2>
    2e18:	00a00793          	li	a5,10
    2e1c:	06a7c663          	blt	a5,a0,2e88 <__extendsfdf2+0xf0>
    2e20:	00b00713          	li	a4,11
    2e24:	40a70733          	sub	a4,a4,a0
    2e28:	01550793          	addi	a5,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf9c45>
    2e2c:	00e45733          	srl	a4,s0,a4
    2e30:	00f41433          	sll	s0,s0,a5
    2e34:	00c71793          	slli	a5,a4,0xc
    2e38:	38900713          	li	a4,905
    2e3c:	40a70733          	sub	a4,a4,a0
    2e40:	00c7d793          	srli	a5,a5,0xc
    2e44:	7ff77713          	andi	a4,a4,2047
    2e48:	f8dff06f          	j	2dd4 <__extendsfdf2+0x3c>
    2e4c:	02040263          	beqz	s0,2e70 <__extendsfdf2+0xd8>
    2e50:	00345713          	srli	a4,s0,0x3
    2e54:	000807b7          	lui	a5,0x80
    2e58:	00f767b3          	or	a5,a4,a5
    2e5c:	00c79793          	slli	a5,a5,0xc
    2e60:	01d41413          	slli	s0,s0,0x1d
    2e64:	00c7d793          	srli	a5,a5,0xc
    2e68:	7ff00713          	li	a4,2047
    2e6c:	f69ff06f          	j	2dd4 <__extendsfdf2+0x3c>
    2e70:	7ff00713          	li	a4,2047
    2e74:	00000793          	li	a5,0
    2e78:	f5dff06f          	j	2dd4 <__extendsfdf2+0x3c>
    2e7c:	00000713          	li	a4,0
    2e80:	00000793          	li	a5,0
    2e84:	f51ff06f          	j	2dd4 <__extendsfdf2+0x3c>
    2e88:	ff550713          	addi	a4,a0,-11
    2e8c:	00e41733          	sll	a4,s0,a4
    2e90:	00000413          	li	s0,0
    2e94:	fa1ff06f          	j	2e34 <__extendsfdf2+0x9c>

00002e98 <__truncdfsf2>:
    2e98:	0145d693          	srli	a3,a1,0x14
    2e9c:	00c59793          	slli	a5,a1,0xc
    2ea0:	7ff6f693          	andi	a3,a3,2047
    2ea4:	00c7d793          	srli	a5,a5,0xc
    2ea8:	00168613          	addi	a2,a3,1
    2eac:	00379793          	slli	a5,a5,0x3
    2eb0:	01d55713          	srli	a4,a0,0x1d
    2eb4:	7fe67613          	andi	a2,a2,2046
    2eb8:	01f5d593          	srli	a1,a1,0x1f
    2ebc:	00f76733          	or	a4,a4,a5
    2ec0:	00351893          	slli	a7,a0,0x3
    2ec4:	0a060463          	beqz	a2,2f6c <__truncdfsf2+0xd4>
    2ec8:	c8068813          	addi	a6,a3,-896
    2ecc:	0fe00793          	li	a5,254
    2ed0:	0307d463          	bge	a5,a6,2ef8 <__truncdfsf2+0x60>
    2ed4:	00000793          	li	a5,0
    2ed8:	00979513          	slli	a0,a5,0x9
    2edc:	0ff00693          	li	a3,255
    2ee0:	01769693          	slli	a3,a3,0x17
    2ee4:	00955513          	srli	a0,a0,0x9
    2ee8:	01f59593          	slli	a1,a1,0x1f
    2eec:	00d56533          	or	a0,a0,a3
    2ef0:	00b56533          	or	a0,a0,a1
    2ef4:	00008067          	ret
    2ef8:	0f005e63          	blez	a6,2ff4 <__truncdfsf2+0x15c>
    2efc:	00651793          	slli	a5,a0,0x6
    2f00:	00371713          	slli	a4,a4,0x3
    2f04:	00f037b3          	snez	a5,a5
    2f08:	00e7e7b3          	or	a5,a5,a4
    2f0c:	01d8d893          	srli	a7,a7,0x1d
    2f10:	0117e7b3          	or	a5,a5,a7
    2f14:	0077f713          	andi	a4,a5,7
    2f18:	16070663          	beqz	a4,3084 <__truncdfsf2+0x1ec>
    2f1c:	00f7f713          	andi	a4,a5,15
    2f20:	00400693          	li	a3,4
    2f24:	00d70463          	beq	a4,a3,2f2c <__truncdfsf2+0x94>
    2f28:	00478793          	addi	a5,a5,4 # 80004 <__global_pointer$+0x7946c>
    2f2c:	04000737          	lui	a4,0x4000
    2f30:	00e7f733          	and	a4,a5,a4
    2f34:	14070863          	beqz	a4,3084 <__truncdfsf2+0x1ec>
    2f38:	00180713          	addi	a4,a6,1
    2f3c:	0ff00613          	li	a2,255
    2f40:	0ff77693          	andi	a3,a4,255
    2f44:	f8c708e3          	beq	a4,a2,2ed4 <__truncdfsf2+0x3c>
    2f48:	00679793          	slli	a5,a5,0x6
    2f4c:	0097d793          	srli	a5,a5,0x9
    2f50:	00979513          	slli	a0,a5,0x9
    2f54:	01769693          	slli	a3,a3,0x17
    2f58:	00955513          	srli	a0,a0,0x9
    2f5c:	01f59593          	slli	a1,a1,0x1f
    2f60:	00d56533          	or	a0,a0,a3
    2f64:	00b56533          	or	a0,a0,a1
    2f68:	00008067          	ret
    2f6c:	011767b3          	or	a5,a4,a7
    2f70:	02069a63          	bnez	a3,2fa4 <__truncdfsf2+0x10c>
    2f74:	04078e63          	beqz	a5,2fd0 <__truncdfsf2+0x138>
    2f78:	00500793          	li	a5,5
    2f7c:	00679793          	slli	a5,a5,0x6
    2f80:	0097d793          	srli	a5,a5,0x9
    2f84:	00979513          	slli	a0,a5,0x9
    2f88:	0ff6f693          	andi	a3,a3,255
    2f8c:	01769693          	slli	a3,a3,0x17
    2f90:	00955513          	srli	a0,a0,0x9
    2f94:	01f59593          	slli	a1,a1,0x1f
    2f98:	00d56533          	or	a0,a0,a3
    2f9c:	00b56533          	or	a0,a0,a1
    2fa0:	00008067          	ret
    2fa4:	f20788e3          	beqz	a5,2ed4 <__truncdfsf2+0x3c>
    2fa8:	004007b7          	lui	a5,0x400
    2fac:	00979513          	slli	a0,a5,0x9
    2fb0:	0ff00693          	li	a3,255
    2fb4:	01769693          	slli	a3,a3,0x17
    2fb8:	00000593          	li	a1,0
    2fbc:	00955513          	srli	a0,a0,0x9
    2fc0:	01f59593          	slli	a1,a1,0x1f
    2fc4:	00d56533          	or	a0,a0,a3
    2fc8:	00b56533          	or	a0,a0,a1
    2fcc:	00008067          	ret
    2fd0:	00000793          	li	a5,0
    2fd4:	00979513          	slli	a0,a5,0x9
    2fd8:	00000693          	li	a3,0
    2fdc:	01769693          	slli	a3,a3,0x17
    2fe0:	00955513          	srli	a0,a0,0x9
    2fe4:	01f59593          	slli	a1,a1,0x1f
    2fe8:	00d56533          	or	a0,a0,a3
    2fec:	00b56533          	or	a0,a0,a1
    2ff0:	00008067          	ret
    2ff4:	fe900793          	li	a5,-23
    2ff8:	06f84263          	blt	a6,a5,305c <__truncdfsf2+0x1c4>
    2ffc:	01e00793          	li	a5,30
    3000:	00800637          	lui	a2,0x800
    3004:	410787b3          	sub	a5,a5,a6
    3008:	01f00513          	li	a0,31
    300c:	00c76633          	or	a2,a4,a2
    3010:	04f55a63          	bge	a0,a5,3064 <__truncdfsf2+0x1cc>
    3014:	ffe00713          	li	a4,-2
    3018:	41070733          	sub	a4,a4,a6
    301c:	02000513          	li	a0,32
    3020:	00e65733          	srl	a4,a2,a4
    3024:	00a78863          	beq	a5,a0,3034 <__truncdfsf2+0x19c>
    3028:	ca268693          	addi	a3,a3,-862
    302c:	00d616b3          	sll	a3,a2,a3
    3030:	00d8e8b3          	or	a7,a7,a3
    3034:	011037b3          	snez	a5,a7
    3038:	00e7e7b3          	or	a5,a5,a4
    303c:	0077f713          	andi	a4,a5,7
    3040:	00000813          	li	a6,0
    3044:	ec071ce3          	bnez	a4,2f1c <__truncdfsf2+0x84>
    3048:	00579713          	slli	a4,a5,0x5
    304c:	00100693          	li	a3,1
    3050:	ee074ce3          	bltz	a4,2f48 <__truncdfsf2+0xb0>
    3054:	00000693          	li	a3,0
    3058:	f25ff06f          	j	2f7c <__truncdfsf2+0xe4>
    305c:	00000693          	li	a3,0
    3060:	f19ff06f          	j	2f78 <__truncdfsf2+0xe0>
    3064:	c8268693          	addi	a3,a3,-894
    3068:	00d89733          	sll	a4,a7,a3
    306c:	00e03733          	snez	a4,a4
    3070:	00d616b3          	sll	a3,a2,a3
    3074:	00f8d8b3          	srl	a7,a7,a5
    3078:	00d767b3          	or	a5,a4,a3
    307c:	00f8e7b3          	or	a5,a7,a5
    3080:	fbdff06f          	j	303c <__truncdfsf2+0x1a4>
    3084:	00080693          	mv	a3,a6
    3088:	ef5ff06f          	j	2f7c <__truncdfsf2+0xe4>

0000308c <__clzsi2>:
    308c:	000107b7          	lui	a5,0x10
    3090:	04f57463          	bgeu	a0,a5,30d8 <__clzsi2+0x4c>
    3094:	0ff00793          	li	a5,255
    3098:	02000713          	li	a4,32
    309c:	00a7ee63          	bltu	a5,a0,30b8 <__clzsi2+0x2c>
    30a0:	00003797          	auipc	a5,0x3
    30a4:	c4878793          	addi	a5,a5,-952 # 5ce8 <__clz_tab>
    30a8:	00a787b3          	add	a5,a5,a0
    30ac:	0007c503          	lbu	a0,0(a5)
    30b0:	40a70533          	sub	a0,a4,a0
    30b4:	00008067          	ret
    30b8:	00855513          	srli	a0,a0,0x8
    30bc:	00003797          	auipc	a5,0x3
    30c0:	c2c78793          	addi	a5,a5,-980 # 5ce8 <__clz_tab>
    30c4:	00a787b3          	add	a5,a5,a0
    30c8:	0007c503          	lbu	a0,0(a5)
    30cc:	01800713          	li	a4,24
    30d0:	40a70533          	sub	a0,a4,a0
    30d4:	00008067          	ret
    30d8:	010007b7          	lui	a5,0x1000
    30dc:	02f56263          	bltu	a0,a5,3100 <__clzsi2+0x74>
    30e0:	01855513          	srli	a0,a0,0x18
    30e4:	00003797          	auipc	a5,0x3
    30e8:	c0478793          	addi	a5,a5,-1020 # 5ce8 <__clz_tab>
    30ec:	00a787b3          	add	a5,a5,a0
    30f0:	0007c503          	lbu	a0,0(a5)
    30f4:	00800713          	li	a4,8
    30f8:	40a70533          	sub	a0,a4,a0
    30fc:	00008067          	ret
    3100:	01055513          	srli	a0,a0,0x10
    3104:	00003797          	auipc	a5,0x3
    3108:	be478793          	addi	a5,a5,-1052 # 5ce8 <__clz_tab>
    310c:	00a787b3          	add	a5,a5,a0
    3110:	0007c503          	lbu	a0,0(a5)
    3114:	01000713          	li	a4,16
    3118:	40a70533          	sub	a0,a4,a0
    311c:	00008067          	ret

00003120 <pow>:
    3120:	fe010113          	addi	sp,sp,-32
    3124:	00812c23          	sw	s0,24(sp)
    3128:	00912a23          	sw	s1,20(sp)
    312c:	01212823          	sw	s2,16(sp)
    3130:	01312623          	sw	s3,12(sp)
    3134:	01412423          	sw	s4,8(sp)
    3138:	01512223          	sw	s5,4(sp)
    313c:	00112e23          	sw	ra,28(sp)
    3140:	00050913          	mv	s2,a0
    3144:	00058993          	mv	s3,a1
    3148:	00060413          	mv	s0,a2
    314c:	00068493          	mv	s1,a3
    3150:	240000ef          	jal	ra,3390 <__ieee754_pow>
    3154:	81018793          	addi	a5,gp,-2032 # 63a8 <__fdlib_version>
    3158:	0007a703          	lw	a4,0(a5)
    315c:	fff00793          	li	a5,-1
    3160:	00050a13          	mv	s4,a0
    3164:	00058a93          	mv	s5,a1
    3168:	08f70663          	beq	a4,a5,31f4 <pow+0xd4>
    316c:	00040613          	mv	a2,s0
    3170:	00048693          	mv	a3,s1
    3174:	00040513          	mv	a0,s0
    3178:	00048593          	mv	a1,s1
    317c:	23d020ef          	jal	ra,5bb8 <__unorddf2>
    3180:	06051a63          	bnez	a0,31f4 <pow+0xd4>
    3184:	00090613          	mv	a2,s2
    3188:	00098693          	mv	a3,s3
    318c:	00090513          	mv	a0,s2
    3190:	00098593          	mv	a1,s3
    3194:	225020ef          	jal	ra,5bb8 <__unorddf2>
    3198:	00000613          	li	a2,0
    319c:	00000693          	li	a3,0
    31a0:	0e051063          	bnez	a0,3280 <pow+0x160>
    31a4:	00090513          	mv	a0,s2
    31a8:	00098593          	mv	a1,s3
    31ac:	085020ef          	jal	ra,5a30 <__eqdf2>
    31b0:	06051863          	bnez	a0,3220 <pow+0x100>
    31b4:	00000613          	li	a2,0
    31b8:	00000693          	li	a3,0
    31bc:	00040513          	mv	a0,s0
    31c0:	00048593          	mv	a1,s1
    31c4:	06d020ef          	jal	ra,5a30 <__eqdf2>
    31c8:	0c050463          	beqz	a0,3290 <pow+0x170>
    31cc:	00040513          	mv	a0,s0
    31d0:	00048593          	mv	a1,s1
    31d4:	454010ef          	jal	ra,4628 <finite>
    31d8:	00050e63          	beqz	a0,31f4 <pow+0xd4>
    31dc:	00000613          	li	a2,0
    31e0:	00000693          	li	a3,0
    31e4:	00040513          	mv	a0,s0
    31e8:	00048593          	mv	a1,s1
    31ec:	89dfe0ef          	jal	ra,1a88 <__ledf2>
    31f0:	12054263          	bltz	a0,3314 <pow+0x1f4>
    31f4:	01c12083          	lw	ra,28(sp)
    31f8:	01812403          	lw	s0,24(sp)
    31fc:	000a0513          	mv	a0,s4
    3200:	000a8593          	mv	a1,s5
    3204:	01412483          	lw	s1,20(sp)
    3208:	01012903          	lw	s2,16(sp)
    320c:	00c12983          	lw	s3,12(sp)
    3210:	00812a03          	lw	s4,8(sp)
    3214:	00412a83          	lw	s5,4(sp)
    3218:	02010113          	addi	sp,sp,32
    321c:	00008067          	ret
    3220:	000a0513          	mv	a0,s4
    3224:	000a8593          	mv	a1,s5
    3228:	400010ef          	jal	ra,4628 <finite>
    322c:	06050c63          	beqz	a0,32a4 <pow+0x184>
    3230:	00000613          	li	a2,0
    3234:	00000693          	li	a3,0
    3238:	000a0513          	mv	a0,s4
    323c:	000a8593          	mv	a1,s5
    3240:	7f0020ef          	jal	ra,5a30 <__eqdf2>
    3244:	fa0518e3          	bnez	a0,31f4 <pow+0xd4>
    3248:	00090513          	mv	a0,s2
    324c:	00098593          	mv	a1,s3
    3250:	3d8010ef          	jal	ra,4628 <finite>
    3254:	fa0500e3          	beqz	a0,31f4 <pow+0xd4>
    3258:	00040513          	mv	a0,s0
    325c:	00048593          	mv	a1,s1
    3260:	3c8010ef          	jal	ra,4628 <finite>
    3264:	f80508e3          	beqz	a0,31f4 <pow+0xd4>
    3268:	1a5020ef          	jal	ra,5c0c <__errno>
    326c:	02200793          	li	a5,34
    3270:	00f52023          	sw	a5,0(a0)
    3274:	00000a13          	li	s4,0
    3278:	00000a93          	li	s5,0
    327c:	f79ff06f          	j	31f4 <pow+0xd4>
    3280:	00040513          	mv	a0,s0
    3284:	00048593          	mv	a1,s1
    3288:	7a8020ef          	jal	ra,5a30 <__eqdf2>
    328c:	f60514e3          	bnez	a0,31f4 <pow+0xd4>
    3290:	00003797          	auipc	a5,0x3
    3294:	b5878793          	addi	a5,a5,-1192 # 5de8 <__clz_tab+0x100>
    3298:	0007aa03          	lw	s4,0(a5)
    329c:	0047aa83          	lw	s5,4(a5)
    32a0:	f55ff06f          	j	31f4 <pow+0xd4>
    32a4:	00090513          	mv	a0,s2
    32a8:	00098593          	mv	a1,s3
    32ac:	37c010ef          	jal	ra,4628 <finite>
    32b0:	f80500e3          	beqz	a0,3230 <pow+0x110>
    32b4:	00040513          	mv	a0,s0
    32b8:	00048593          	mv	a1,s1
    32bc:	36c010ef          	jal	ra,4628 <finite>
    32c0:	f60508e3          	beqz	a0,3230 <pow+0x110>
    32c4:	000a0613          	mv	a2,s4
    32c8:	000a8693          	mv	a3,s5
    32cc:	000a0513          	mv	a0,s4
    32d0:	000a8593          	mv	a1,s5
    32d4:	0e5020ef          	jal	ra,5bb8 <__unorddf2>
    32d8:	08051663          	bnez	a0,3364 <pow+0x244>
    32dc:	131020ef          	jal	ra,5c0c <__errno>
    32e0:	02200793          	li	a5,34
    32e4:	00f52023          	sw	a5,0(a0)
    32e8:	00000613          	li	a2,0
    32ec:	00000693          	li	a3,0
    32f0:	00090513          	mv	a0,s2
    32f4:	00098593          	mv	a1,s3
    32f8:	f90fe0ef          	jal	ra,1a88 <__ledf2>
    32fc:	02054c63          	bltz	a0,3334 <pow+0x214>
    3300:	00003797          	auipc	a5,0x3
    3304:	af878793          	addi	a5,a5,-1288 # 5df8 <__clz_tab+0x110>
    3308:	0007aa03          	lw	s4,0(a5)
    330c:	0047aa83          	lw	s5,4(a5)
    3310:	ee5ff06f          	j	31f4 <pow+0xd4>
    3314:	0f9020ef          	jal	ra,5c0c <__errno>
    3318:	02100793          	li	a5,33
    331c:	00f52023          	sw	a5,0(a0)
    3320:	00003797          	auipc	a5,0x3
    3324:	ad078793          	addi	a5,a5,-1328 # 5df0 <__clz_tab+0x108>
    3328:	0007aa03          	lw	s4,0(a5)
    332c:	0047aa83          	lw	s5,4(a5)
    3330:	ec5ff06f          	j	31f4 <pow+0xd4>
    3334:	00040513          	mv	a0,s0
    3338:	00048593          	mv	a1,s1
    333c:	318010ef          	jal	ra,4654 <rint>
    3340:	00040613          	mv	a2,s0
    3344:	00048693          	mv	a3,s1
    3348:	6e8020ef          	jal	ra,5a30 <__eqdf2>
    334c:	fa050ae3          	beqz	a0,3300 <pow+0x1e0>
    3350:	00003797          	auipc	a5,0x3
    3354:	aa078793          	addi	a5,a5,-1376 # 5df0 <__clz_tab+0x108>
    3358:	0007aa03          	lw	s4,0(a5)
    335c:	0047aa83          	lw	s5,4(a5)
    3360:	e95ff06f          	j	31f4 <pow+0xd4>
    3364:	0a9020ef          	jal	ra,5c0c <__errno>
    3368:	02100793          	li	a5,33
    336c:	00000613          	li	a2,0
    3370:	00000693          	li	a3,0
    3374:	00f52023          	sw	a5,0(a0)
    3378:	00068593          	mv	a1,a3
    337c:	00060513          	mv	a0,a2
    3380:	735010ef          	jal	ra,52b4 <__divdf3>
    3384:	00050a13          	mv	s4,a0
    3388:	00058a93          	mv	s5,a1
    338c:	e69ff06f          	j	31f4 <pow+0xd4>

00003390 <__ieee754_pow>:
    3390:	80000837          	lui	a6,0x80000
    3394:	f8010113          	addi	sp,sp,-128
    3398:	fff84813          	not	a6,a6
    339c:	07212823          	sw	s2,112(sp)
    33a0:	0106f933          	and	s2,a3,a6
    33a4:	06112e23          	sw	ra,124(sp)
    33a8:	06812c23          	sw	s0,120(sp)
    33ac:	06912a23          	sw	s1,116(sp)
    33b0:	07312623          	sw	s3,108(sp)
    33b4:	07412423          	sw	s4,104(sp)
    33b8:	07512223          	sw	s5,100(sp)
    33bc:	07612023          	sw	s6,96(sp)
    33c0:	05712e23          	sw	s7,92(sp)
    33c4:	05812c23          	sw	s8,88(sp)
    33c8:	05912a23          	sw	s9,84(sp)
    33cc:	05a12823          	sw	s10,80(sp)
    33d0:	05b12623          	sw	s11,76(sp)
    33d4:	00c967b3          	or	a5,s2,a2
    33d8:	10078063          	beqz	a5,34d8 <__ieee754_pow+0x148>
    33dc:	00b87433          	and	s0,a6,a1
    33e0:	7ff007b7          	lui	a5,0x7ff00
    33e4:	00058a93          	mv	s5,a1
    33e8:	00050a13          	mv	s4,a0
    33ec:	0487dc63          	bge	a5,s0,3444 <__ieee754_pow+0xb4>
    33f0:	c0100837          	lui	a6,0xc0100
    33f4:	01040833          	add	a6,s0,a6
    33f8:	00a86833          	or	a6,a6,a0
    33fc:	3ff005b7          	lui	a1,0x3ff00
    3400:	00000513          	li	a0,0
    3404:	0e081463          	bnez	a6,34ec <__ieee754_pow+0x15c>
    3408:	07c12083          	lw	ra,124(sp)
    340c:	07812403          	lw	s0,120(sp)
    3410:	07412483          	lw	s1,116(sp)
    3414:	07012903          	lw	s2,112(sp)
    3418:	06c12983          	lw	s3,108(sp)
    341c:	06812a03          	lw	s4,104(sp)
    3420:	06412a83          	lw	s5,100(sp)
    3424:	06012b03          	lw	s6,96(sp)
    3428:	05c12b83          	lw	s7,92(sp)
    342c:	05812c03          	lw	s8,88(sp)
    3430:	05412c83          	lw	s9,84(sp)
    3434:	05012d03          	lw	s10,80(sp)
    3438:	04c12d83          	lw	s11,76(sp)
    343c:	08010113          	addi	sp,sp,128
    3440:	00008067          	ret
    3444:	0af40063          	beq	s0,a5,34e4 <__ieee754_pow+0x154>
    3448:	fb27c4e3          	blt	a5,s2,33f0 <__ieee754_pow+0x60>
    344c:	7ff007b7          	lui	a5,0x7ff00
    3450:	24f90e63          	beq	s2,a5,36ac <__ieee754_pow+0x31c>
    3454:	00058493          	mv	s1,a1
    3458:	00050993          	mv	s3,a0
    345c:	00060c93          	mv	s9,a2
    3460:	00068d93          	mv	s11,a3
    3464:	00000d13          	li	s10,0
    3468:	0c0ac463          	bltz	s5,3530 <__ieee754_pow+0x1a0>
    346c:	100c9463          	bnez	s9,3574 <__ieee754_pow+0x1e4>
    3470:	7ff006b7          	lui	a3,0x7ff00
    3474:	1ad90663          	beq	s2,a3,3620 <__ieee754_pow+0x290>
    3478:	3ff006b7          	lui	a3,0x3ff00
    347c:	1cd90a63          	beq	s2,a3,3650 <__ieee754_pow+0x2c0>
    3480:	400006b7          	lui	a3,0x40000
    3484:	60dd80e3          	beq	s11,a3,4284 <__ieee754_pow+0xef4>
    3488:	3fe006b7          	lui	a3,0x3fe00
    348c:	0edd9463          	bne	s11,a3,3574 <__ieee754_pow+0x1e4>
    3490:	0e0ac263          	bltz	s5,3574 <__ieee754_pow+0x1e4>
    3494:	07812403          	lw	s0,120(sp)
    3498:	07c12083          	lw	ra,124(sp)
    349c:	07012903          	lw	s2,112(sp)
    34a0:	06812a03          	lw	s4,104(sp)
    34a4:	06412a83          	lw	s5,100(sp)
    34a8:	06012b03          	lw	s6,96(sp)
    34ac:	05c12b83          	lw	s7,92(sp)
    34b0:	05812c03          	lw	s8,88(sp)
    34b4:	05412c83          	lw	s9,84(sp)
    34b8:	05012d03          	lw	s10,80(sp)
    34bc:	04c12d83          	lw	s11,76(sp)
    34c0:	00098513          	mv	a0,s3
    34c4:	00048593          	mv	a1,s1
    34c8:	06c12983          	lw	s3,108(sp)
    34cc:	07412483          	lw	s1,116(sp)
    34d0:	08010113          	addi	sp,sp,128
    34d4:	6950006f          	j	4368 <__ieee754_sqrt>
    34d8:	00000513          	li	a0,0
    34dc:	3ff005b7          	lui	a1,0x3ff00
    34e0:	f29ff06f          	j	3408 <__ieee754_pow+0x78>
    34e4:	00051463          	bnez	a0,34ec <__ieee754_pow+0x15c>
    34e8:	f72452e3          	bge	s0,s2,344c <__ieee754_pow+0xbc>
    34ec:	07812403          	lw	s0,120(sp)
    34f0:	07c12083          	lw	ra,124(sp)
    34f4:	07412483          	lw	s1,116(sp)
    34f8:	07012903          	lw	s2,112(sp)
    34fc:	06c12983          	lw	s3,108(sp)
    3500:	06812a03          	lw	s4,104(sp)
    3504:	06412a83          	lw	s5,100(sp)
    3508:	06012b03          	lw	s6,96(sp)
    350c:	05c12b83          	lw	s7,92(sp)
    3510:	05812c03          	lw	s8,88(sp)
    3514:	05412c83          	lw	s9,84(sp)
    3518:	05012d03          	lw	s10,80(sp)
    351c:	04c12d83          	lw	s11,76(sp)
    3520:	00002517          	auipc	a0,0x2
    3524:	76c50513          	addi	a0,a0,1900 # 5c8c <_data+0x70>
    3528:	08010113          	addi	sp,sp,128
    352c:	1140106f          	j	4640 <nan>
    3530:	434006b7          	lui	a3,0x43400
    3534:	18d95063          	bge	s2,a3,36b4 <__ieee754_pow+0x324>
    3538:	3ff006b7          	lui	a3,0x3ff00
    353c:	02d94a63          	blt	s2,a3,3570 <__ieee754_pow+0x1e0>
    3540:	41495693          	srai	a3,s2,0x14
    3544:	c0168693          	addi	a3,a3,-1023 # 3feffc01 <__freertos_irq_stack_top+0x3fcf9831>
    3548:	01400613          	li	a2,20
    354c:	54d658e3          	bge	a2,a3,429c <__ieee754_pow+0xf0c>
    3550:	03400613          	li	a2,52
    3554:	40d606b3          	sub	a3,a2,a3
    3558:	00dcd633          	srl	a2,s9,a3
    355c:	00d616b3          	sll	a3,a2,a3
    3560:	01969863          	bne	a3,s9,3570 <__ieee754_pow+0x1e0>
    3564:	00167613          	andi	a2,a2,1
    3568:	00200313          	li	t1,2
    356c:	40c30d33          	sub	s10,t1,a2
    3570:	f00c84e3          	beqz	s9,3478 <__ieee754_pow+0xe8>
    3574:	00098513          	mv	a0,s3
    3578:	00048593          	mv	a1,s1
    357c:	0a0010ef          	jal	ra,461c <fabs>
    3580:	040a0c63          	beqz	s4,35d8 <__ieee754_pow+0x248>
    3584:	01f4de13          	srli	t3,s1,0x1f
    3588:	fffe0e13          	addi	t3,t3,-1
    358c:	01cd66b3          	or	a3,s10,t3
    3590:	12068663          	beqz	a3,36bc <__ieee754_pow+0x32c>
    3594:	41e006b7          	lui	a3,0x41e00
    3598:	1526d463          	bge	a3,s2,36e0 <__ieee754_pow+0x350>
    359c:	43f006b7          	lui	a3,0x43f00
    35a0:	3526dce3          	bge	a3,s2,40f8 <__ieee754_pow+0xd68>
    35a4:	3ff00737          	lui	a4,0x3ff00
    35a8:	0ce45a63          	bge	s0,a4,367c <__ieee754_pow+0x2ec>
    35ac:	080ddc63          	bgez	s11,3644 <__ieee754_pow+0x2b4>
    35b0:	00003797          	auipc	a5,0x3
    35b4:	87078793          	addi	a5,a5,-1936 # 5e20 <__clz_tab+0x138>
    35b8:	0007a603          	lw	a2,0(a5)
    35bc:	0047a683          	lw	a3,4(a5)
    35c0:	00060513          	mv	a0,a2
    35c4:	00068593          	mv	a1,a3
    35c8:	dc0fe0ef          	jal	ra,1b88 <__muldf3>
    35cc:	e3dff06f          	j	3408 <__ieee754_pow+0x78>
    35d0:	04c010ef          	jal	ra,461c <fabs>
    35d4:	0e0a1463          	bnez	s4,36bc <__ieee754_pow+0x32c>
    35d8:	00040a63          	beqz	s0,35ec <__ieee754_pow+0x25c>
    35dc:	00249693          	slli	a3,s1,0x2
    35e0:	0026d693          	srli	a3,a3,0x2
    35e4:	3ff00637          	lui	a2,0x3ff00
    35e8:	f8c69ee3          	bne	a3,a2,3584 <__ieee754_pow+0x1f4>
    35ec:	080dcc63          	bltz	s11,3684 <__ieee754_pow+0x2f4>
    35f0:	e00adce3          	bgez	s5,3408 <__ieee754_pow+0x78>
    35f4:	c01007b7          	lui	a5,0xc0100
    35f8:	00f407b3          	add	a5,s0,a5
    35fc:	01a7e7b3          	or	a5,a5,s10
    3600:	4e0796e3          	bnez	a5,42ec <__ieee754_pow+0xf5c>
    3604:	00050613          	mv	a2,a0
    3608:	00058693          	mv	a3,a1
    360c:	bd1fe0ef          	jal	ra,21dc <__subdf3>
    3610:	00050613          	mv	a2,a0
    3614:	00058693          	mv	a3,a1
    3618:	49d010ef          	jal	ra,52b4 <__divdf3>
    361c:	dedff06f          	j	3408 <__ieee754_pow+0x78>
    3620:	c0100537          	lui	a0,0xc0100
    3624:	00a40533          	add	a0,s0,a0
    3628:	01356533          	or	a0,a0,s3
    362c:	ea0506e3          	beqz	a0,34d8 <__ieee754_pow+0x148>
    3630:	3ff00737          	lui	a4,0x3ff00
    3634:	2ae442e3          	blt	s0,a4,40d8 <__ieee754_pow+0xd48>
    3638:	000d8593          	mv	a1,s11
    363c:	00000513          	li	a0,0
    3640:	dc0dd4e3          	bgez	s11,3408 <__ieee754_pow+0x78>
    3644:	00000513          	li	a0,0
    3648:	00000593          	li	a1,0
    364c:	dbdff06f          	j	3408 <__ieee754_pow+0x78>
    3650:	00098513          	mv	a0,s3
    3654:	00048593          	mv	a1,s1
    3658:	da0dd8e3          	bgez	s11,3408 <__ieee754_pow+0x78>
    365c:	00002797          	auipc	a5,0x2
    3660:	78c78793          	addi	a5,a5,1932 # 5de8 <__clz_tab+0x100>
    3664:	0007a503          	lw	a0,0(a5)
    3668:	0047a583          	lw	a1,4(a5)
    366c:	00098613          	mv	a2,s3
    3670:	00048693          	mv	a3,s1
    3674:	441010ef          	jal	ra,52b4 <__divdf3>
    3678:	d91ff06f          	j	3408 <__ieee754_pow+0x78>
    367c:	f3b04ae3          	bgtz	s11,35b0 <__ieee754_pow+0x220>
    3680:	fc5ff06f          	j	3644 <__ieee754_pow+0x2b4>
    3684:	00002717          	auipc	a4,0x2
    3688:	76470713          	addi	a4,a4,1892 # 5de8 <__clz_tab+0x100>
    368c:	00050c93          	mv	s9,a0
    3690:	00058793          	mv	a5,a1
    3694:	00072503          	lw	a0,0(a4)
    3698:	00472583          	lw	a1,4(a4)
    369c:	000c8613          	mv	a2,s9
    36a0:	00078693          	mv	a3,a5
    36a4:	411010ef          	jal	ra,52b4 <__divdf3>
    36a8:	f49ff06f          	j	35f0 <__ieee754_pow+0x260>
    36ac:	da0604e3          	beqz	a2,3454 <__ieee754_pow+0xc4>
    36b0:	d41ff06f          	j	33f0 <__ieee754_pow+0x60>
    36b4:	00200d13          	li	s10,2
    36b8:	db5ff06f          	j	346c <__ieee754_pow+0xdc>
    36bc:	00098613          	mv	a2,s3
    36c0:	00048693          	mv	a3,s1
    36c4:	00098513          	mv	a0,s3
    36c8:	00048593          	mv	a1,s1
    36cc:	b11fe0ef          	jal	ra,21dc <__subdf3>
    36d0:	00050613          	mv	a2,a0
    36d4:	00058693          	mv	a3,a1
    36d8:	3dd010ef          	jal	ra,52b4 <__divdf3>
    36dc:	d2dff06f          	j	3408 <__ieee754_pow+0x78>
    36e0:	7ff006b7          	lui	a3,0x7ff00
    36e4:	0096f4b3          	and	s1,a3,s1
    36e8:	00000613          	li	a2,0
    36ec:	02049463          	bnez	s1,3714 <__ieee754_pow+0x384>
    36f0:	00002697          	auipc	a3,0x2
    36f4:	76868693          	addi	a3,a3,1896 # 5e58 <__clz_tab+0x170>
    36f8:	0006a603          	lw	a2,0(a3)
    36fc:	0046a683          	lw	a3,4(a3)
    3700:	01c12423          	sw	t3,8(sp)
    3704:	c84fe0ef          	jal	ra,1b88 <__muldf3>
    3708:	00812e03          	lw	t3,8(sp)
    370c:	00058413          	mv	s0,a1
    3710:	fcb00613          	li	a2,-53
    3714:	001005b7          	lui	a1,0x100
    3718:	41445e93          	srai	t4,s0,0x14
    371c:	fff58813          	addi	a6,a1,-1 # fffff <__global_pointer$+0xf9467>
    3720:	0003a6b7          	lui	a3,0x3a
    3724:	c01e8e93          	addi	t4,t4,-1023
    3728:	01047833          	and	a6,s0,a6
    372c:	3ff00c37          	lui	s8,0x3ff00
    3730:	88e68693          	addi	a3,a3,-1906 # 3988e <__global_pointer$+0x32cf6>
    3734:	00ce8eb3          	add	t4,t4,a2
    3738:	01886c33          	or	s8,a6,s8
    373c:	1b06d8e3          	bge	a3,a6,40ec <__ieee754_pow+0xd5c>
    3740:	000bb6b7          	lui	a3,0xbb
    3744:	67968693          	addi	a3,a3,1657 # bb679 <__global_pointer$+0xb4ae1>
    3748:	3b06dee3          	bge	a3,a6,4304 <__ieee754_pow+0xf74>
    374c:	00002a97          	auipc	s5,0x2
    3750:	69ca8a93          	addi	s5,s5,1692 # 5de8 <__clz_tab+0x100>
    3754:	001e8e93          	addi	t4,t4,1
    3758:	40bc0c33          	sub	s8,s8,a1
    375c:	000aa783          	lw	a5,0(s5)
    3760:	004aa803          	lw	a6,4(s5)
    3764:	00012823          	sw	zero,16(sp)
    3768:	00012a23          	sw	zero,20(sp)
    376c:	02012c23          	sw	zero,56(sp)
    3770:	02012e23          	sw	zero,60(sp)
    3774:	00000993          	li	s3,0
    3778:	00f12423          	sw	a5,8(sp)
    377c:	01012623          	sw	a6,12(sp)
    3780:	00812403          	lw	s0,8(sp)
    3784:	00c12483          	lw	s1,12(sp)
    3788:	000c0593          	mv	a1,s8
    378c:	00040613          	mv	a2,s0
    3790:	00048693          	mv	a3,s1
    3794:	03d12a23          	sw	t4,52(sp)
    3798:	03c12823          	sw	t3,48(sp)
    379c:	00050913          	mv	s2,a0
    37a0:	a3dfe0ef          	jal	ra,21dc <__subdf3>
    37a4:	00050b13          	mv	s6,a0
    37a8:	00058b93          	mv	s7,a1
    37ac:	00040613          	mv	a2,s0
    37b0:	00048693          	mv	a3,s1
    37b4:	00090513          	mv	a0,s2
    37b8:	000c0593          	mv	a1,s8
    37bc:	00812423          	sw	s0,8(sp)
    37c0:	00912623          	sw	s1,12(sp)
    37c4:	26c010ef          	jal	ra,4a30 <__adddf3>
    37c8:	00050613          	mv	a2,a0
    37cc:	00058693          	mv	a3,a1
    37d0:	000aa503          	lw	a0,0(s5)
    37d4:	004aa583          	lw	a1,4(s5)
    37d8:	00000493          	li	s1,0
    37dc:	2d9010ef          	jal	ra,52b4 <__divdf3>
    37e0:	00050613          	mv	a2,a0
    37e4:	00058693          	mv	a3,a1
    37e8:	00a12c23          	sw	a0,24(sp)
    37ec:	00b12e23          	sw	a1,28(sp)
    37f0:	000b0513          	mv	a0,s6
    37f4:	000b8593          	mv	a1,s7
    37f8:	b90fe0ef          	jal	ra,1b88 <__muldf3>
    37fc:	401c5f13          	srai	t5,s8,0x1
    3800:	200006b7          	lui	a3,0x20000
    3804:	00df6f33          	or	t5,t5,a3
    3808:	000806b7          	lui	a3,0x80
    380c:	00df0f33          	add	t5,t5,a3
    3810:	013f09b3          	add	s3,t5,s3
    3814:	00050a13          	mv	s4,a0
    3818:	00098693          	mv	a3,s3
    381c:	00000613          	li	a2,0
    3820:	00048513          	mv	a0,s1
    3824:	00058413          	mv	s0,a1
    3828:	b60fe0ef          	jal	ra,1b88 <__muldf3>
    382c:	00050613          	mv	a2,a0
    3830:	00058693          	mv	a3,a1
    3834:	000b0513          	mv	a0,s6
    3838:	000b8593          	mv	a1,s7
    383c:	9a1fe0ef          	jal	ra,21dc <__subdf3>
    3840:	00812603          	lw	a2,8(sp)
    3844:	00c12683          	lw	a3,12(sp)
    3848:	00050b13          	mv	s6,a0
    384c:	00058b93          	mv	s7,a1
    3850:	00000513          	li	a0,0
    3854:	00098593          	mv	a1,s3
    3858:	985fe0ef          	jal	ra,21dc <__subdf3>
    385c:	00050613          	mv	a2,a0
    3860:	00058693          	mv	a3,a1
    3864:	00090513          	mv	a0,s2
    3868:	000c0593          	mv	a1,s8
    386c:	971fe0ef          	jal	ra,21dc <__subdf3>
    3870:	00048613          	mv	a2,s1
    3874:	00040693          	mv	a3,s0
    3878:	b10fe0ef          	jal	ra,1b88 <__muldf3>
    387c:	00050613          	mv	a2,a0
    3880:	00058693          	mv	a3,a1
    3884:	000b0513          	mv	a0,s6
    3888:	000b8593          	mv	a1,s7
    388c:	951fe0ef          	jal	ra,21dc <__subdf3>
    3890:	01812803          	lw	a6,24(sp)
    3894:	01c12883          	lw	a7,28(sp)
    3898:	00002b97          	auipc	s7,0x2
    389c:	5f8b8b93          	addi	s7,s7,1528 # 5e90 <__clz_tab+0x1a8>
    38a0:	00080613          	mv	a2,a6
    38a4:	00088693          	mv	a3,a7
    38a8:	ae0fe0ef          	jal	ra,1b88 <__muldf3>
    38ac:	000a0613          	mv	a2,s4
    38b0:	00040693          	mv	a3,s0
    38b4:	00a12423          	sw	a0,8(sp)
    38b8:	00b12623          	sw	a1,12(sp)
    38bc:	000a0513          	mv	a0,s4
    38c0:	00040593          	mv	a1,s0
    38c4:	ac4fe0ef          	jal	ra,1b88 <__muldf3>
    38c8:	00002697          	auipc	a3,0x2
    38cc:	59868693          	addi	a3,a3,1432 # 5e60 <__clz_tab+0x178>
    38d0:	0006a603          	lw	a2,0(a3)
    38d4:	0046a683          	lw	a3,4(a3)
    38d8:	00050913          	mv	s2,a0
    38dc:	00058993          	mv	s3,a1
    38e0:	aa8fe0ef          	jal	ra,1b88 <__muldf3>
    38e4:	00002697          	auipc	a3,0x2
    38e8:	58468693          	addi	a3,a3,1412 # 5e68 <__clz_tab+0x180>
    38ec:	0006a603          	lw	a2,0(a3)
    38f0:	0046a683          	lw	a3,4(a3)
    38f4:	00000b13          	li	s6,0
    38f8:	00000c13          	li	s8,0
    38fc:	134010ef          	jal	ra,4a30 <__adddf3>
    3900:	00090613          	mv	a2,s2
    3904:	00098693          	mv	a3,s3
    3908:	a80fe0ef          	jal	ra,1b88 <__muldf3>
    390c:	00002697          	auipc	a3,0x2
    3910:	56468693          	addi	a3,a3,1380 # 5e70 <__clz_tab+0x188>
    3914:	0006a603          	lw	a2,0(a3)
    3918:	0046a683          	lw	a3,4(a3)
    391c:	114010ef          	jal	ra,4a30 <__adddf3>
    3920:	00090613          	mv	a2,s2
    3924:	00098693          	mv	a3,s3
    3928:	a60fe0ef          	jal	ra,1b88 <__muldf3>
    392c:	00002697          	auipc	a3,0x2
    3930:	54c68693          	addi	a3,a3,1356 # 5e78 <__clz_tab+0x190>
    3934:	0006a603          	lw	a2,0(a3)
    3938:	0046a683          	lw	a3,4(a3)
    393c:	0f4010ef          	jal	ra,4a30 <__adddf3>
    3940:	00090613          	mv	a2,s2
    3944:	00098693          	mv	a3,s3
    3948:	a40fe0ef          	jal	ra,1b88 <__muldf3>
    394c:	00002697          	auipc	a3,0x2
    3950:	53468693          	addi	a3,a3,1332 # 5e80 <__clz_tab+0x198>
    3954:	0006a603          	lw	a2,0(a3)
    3958:	0046a683          	lw	a3,4(a3)
    395c:	0d4010ef          	jal	ra,4a30 <__adddf3>
    3960:	00090613          	mv	a2,s2
    3964:	00098693          	mv	a3,s3
    3968:	a20fe0ef          	jal	ra,1b88 <__muldf3>
    396c:	00002697          	auipc	a3,0x2
    3970:	51c68693          	addi	a3,a3,1308 # 5e88 <__clz_tab+0x1a0>
    3974:	0006a603          	lw	a2,0(a3)
    3978:	0046a683          	lw	a3,4(a3)
    397c:	0b4010ef          	jal	ra,4a30 <__adddf3>
    3980:	00090613          	mv	a2,s2
    3984:	00098693          	mv	a3,s3
    3988:	00a12c23          	sw	a0,24(sp)
    398c:	00b12e23          	sw	a1,28(sp)
    3990:	00090513          	mv	a0,s2
    3994:	00098593          	mv	a1,s3
    3998:	9f0fe0ef          	jal	ra,1b88 <__muldf3>
    399c:	01812703          	lw	a4,24(sp)
    39a0:	01c12783          	lw	a5,28(sp)
    39a4:	00050613          	mv	a2,a0
    39a8:	00058693          	mv	a3,a1
    39ac:	00070513          	mv	a0,a4
    39b0:	00078593          	mv	a1,a5
    39b4:	9d4fe0ef          	jal	ra,1b88 <__muldf3>
    39b8:	00050913          	mv	s2,a0
    39bc:	00058993          	mv	s3,a1
    39c0:	00048613          	mv	a2,s1
    39c4:	00040693          	mv	a3,s0
    39c8:	000a0513          	mv	a0,s4
    39cc:	00040593          	mv	a1,s0
    39d0:	060010ef          	jal	ra,4a30 <__adddf3>
    39d4:	00812603          	lw	a2,8(sp)
    39d8:	00c12683          	lw	a3,12(sp)
    39dc:	9acfe0ef          	jal	ra,1b88 <__muldf3>
    39e0:	00090613          	mv	a2,s2
    39e4:	00098693          	mv	a3,s3
    39e8:	048010ef          	jal	ra,4a30 <__adddf3>
    39ec:	00050913          	mv	s2,a0
    39f0:	00058993          	mv	s3,a1
    39f4:	00048613          	mv	a2,s1
    39f8:	00040693          	mv	a3,s0
    39fc:	00048513          	mv	a0,s1
    3a00:	00040593          	mv	a1,s0
    3a04:	984fe0ef          	jal	ra,1b88 <__muldf3>
    3a08:	000ba603          	lw	a2,0(s7)
    3a0c:	004ba683          	lw	a3,4(s7)
    3a10:	02a12423          	sw	a0,40(sp)
    3a14:	02b12623          	sw	a1,44(sp)
    3a18:	018010ef          	jal	ra,4a30 <__adddf3>
    3a1c:	00090613          	mv	a2,s2
    3a20:	00098693          	mv	a3,s3
    3a24:	01212c23          	sw	s2,24(sp)
    3a28:	01312e23          	sw	s3,28(sp)
    3a2c:	004010ef          	jal	ra,4a30 <__adddf3>
    3a30:	00058913          	mv	s2,a1
    3a34:	000b0613          	mv	a2,s6
    3a38:	00058693          	mv	a3,a1
    3a3c:	00048513          	mv	a0,s1
    3a40:	00040593          	mv	a1,s0
    3a44:	944fe0ef          	jal	ra,1b88 <__muldf3>
    3a48:	000ba603          	lw	a2,0(s7)
    3a4c:	004ba683          	lw	a3,4(s7)
    3a50:	02a12023          	sw	a0,32(sp)
    3a54:	02b12223          	sw	a1,36(sp)
    3a58:	000b0513          	mv	a0,s6
    3a5c:	00090593          	mv	a1,s2
    3a60:	f7cfe0ef          	jal	ra,21dc <__subdf3>
    3a64:	02812f03          	lw	t5,40(sp)
    3a68:	02c12f83          	lw	t6,44(sp)
    3a6c:	000f0613          	mv	a2,t5
    3a70:	000f8693          	mv	a3,t6
    3a74:	f68fe0ef          	jal	ra,21dc <__subdf3>
    3a78:	00050613          	mv	a2,a0
    3a7c:	00058693          	mv	a3,a1
    3a80:	01812503          	lw	a0,24(sp)
    3a84:	01c12583          	lw	a1,28(sp)
    3a88:	f54fe0ef          	jal	ra,21dc <__subdf3>
    3a8c:	000a0613          	mv	a2,s4
    3a90:	00040693          	mv	a3,s0
    3a94:	8f4fe0ef          	jal	ra,1b88 <__muldf3>
    3a98:	00050413          	mv	s0,a0
    3a9c:	00058493          	mv	s1,a1
    3aa0:	00812503          	lw	a0,8(sp)
    3aa4:	00c12583          	lw	a1,12(sp)
    3aa8:	000b0613          	mv	a2,s6
    3aac:	00090693          	mv	a3,s2
    3ab0:	8d8fe0ef          	jal	ra,1b88 <__muldf3>
    3ab4:	00050613          	mv	a2,a0
    3ab8:	00058693          	mv	a3,a1
    3abc:	00040513          	mv	a0,s0
    3ac0:	00048593          	mv	a1,s1
    3ac4:	76d000ef          	jal	ra,4a30 <__adddf3>
    3ac8:	02012b03          	lw	s6,32(sp)
    3acc:	02412b83          	lw	s7,36(sp)
    3ad0:	00050413          	mv	s0,a0
    3ad4:	00058493          	mv	s1,a1
    3ad8:	00050613          	mv	a2,a0
    3adc:	00058693          	mv	a3,a1
    3ae0:	000b0513          	mv	a0,s6
    3ae4:	000b8593          	mv	a1,s7
    3ae8:	749000ef          	jal	ra,4a30 <__adddf3>
    3aec:	00002697          	auipc	a3,0x2
    3af0:	3ac68693          	addi	a3,a3,940 # 5e98 <__clz_tab+0x1b0>
    3af4:	0006a603          	lw	a2,0(a3)
    3af8:	0046a683          	lw	a3,4(a3)
    3afc:	000c0513          	mv	a0,s8
    3b00:	00058a13          	mv	s4,a1
    3b04:	884fe0ef          	jal	ra,1b88 <__muldf3>
    3b08:	00050913          	mv	s2,a0
    3b0c:	00058993          	mv	s3,a1
    3b10:	000b0613          	mv	a2,s6
    3b14:	000b8693          	mv	a3,s7
    3b18:	000c0513          	mv	a0,s8
    3b1c:	000a0593          	mv	a1,s4
    3b20:	ebcfe0ef          	jal	ra,21dc <__subdf3>
    3b24:	00050613          	mv	a2,a0
    3b28:	00058693          	mv	a3,a1
    3b2c:	00040513          	mv	a0,s0
    3b30:	00048593          	mv	a1,s1
    3b34:	ea8fe0ef          	jal	ra,21dc <__subdf3>
    3b38:	00002697          	auipc	a3,0x2
    3b3c:	36868693          	addi	a3,a3,872 # 5ea0 <__clz_tab+0x1b8>
    3b40:	0006a603          	lw	a2,0(a3)
    3b44:	0046a683          	lw	a3,4(a3)
    3b48:	840fe0ef          	jal	ra,1b88 <__muldf3>
    3b4c:	00002697          	auipc	a3,0x2
    3b50:	35c68693          	addi	a3,a3,860 # 5ea8 <__clz_tab+0x1c0>
    3b54:	0006a603          	lw	a2,0(a3)
    3b58:	0046a683          	lw	a3,4(a3)
    3b5c:	00050413          	mv	s0,a0
    3b60:	00058493          	mv	s1,a1
    3b64:	000c0513          	mv	a0,s8
    3b68:	000a0593          	mv	a1,s4
    3b6c:	81cfe0ef          	jal	ra,1b88 <__muldf3>
    3b70:	00050613          	mv	a2,a0
    3b74:	00058693          	mv	a3,a1
    3b78:	00040513          	mv	a0,s0
    3b7c:	00048593          	mv	a1,s1
    3b80:	6b1000ef          	jal	ra,4a30 <__adddf3>
    3b84:	03812603          	lw	a2,56(sp)
    3b88:	03c12683          	lw	a3,60(sp)
    3b8c:	6a5000ef          	jal	ra,4a30 <__adddf3>
    3b90:	03412e83          	lw	t4,52(sp)
    3b94:	00050b13          	mv	s6,a0
    3b98:	00058b93          	mv	s7,a1
    3b9c:	000e8513          	mv	a0,t4
    3ba0:	f3dfe0ef          	jal	ra,2adc <__floatsidf>
    3ba4:	00050413          	mv	s0,a0
    3ba8:	00058493          	mv	s1,a1
    3bac:	000b0613          	mv	a2,s6
    3bb0:	000b8693          	mv	a3,s7
    3bb4:	00090513          	mv	a0,s2
    3bb8:	00098593          	mv	a1,s3
    3bbc:	675000ef          	jal	ra,4a30 <__adddf3>
    3bc0:	01012603          	lw	a2,16(sp)
    3bc4:	01412683          	lw	a3,20(sp)
    3bc8:	669000ef          	jal	ra,4a30 <__adddf3>
    3bcc:	00040613          	mv	a2,s0
    3bd0:	00048693          	mv	a3,s1
    3bd4:	65d000ef          	jal	ra,4a30 <__adddf3>
    3bd8:	00000613          	li	a2,0
    3bdc:	00060513          	mv	a0,a2
    3be0:	00048693          	mv	a3,s1
    3be4:	00040613          	mv	a2,s0
    3be8:	00058493          	mv	s1,a1
    3bec:	00050413          	mv	s0,a0
    3bf0:	decfe0ef          	jal	ra,21dc <__subdf3>
    3bf4:	01012603          	lw	a2,16(sp)
    3bf8:	01412683          	lw	a3,20(sp)
    3bfc:	de0fe0ef          	jal	ra,21dc <__subdf3>
    3c00:	00090613          	mv	a2,s2
    3c04:	00098693          	mv	a3,s3
    3c08:	dd4fe0ef          	jal	ra,21dc <__subdf3>
    3c0c:	00050613          	mv	a2,a0
    3c10:	00058693          	mv	a3,a1
    3c14:	000b0513          	mv	a0,s6
    3c18:	000b8593          	mv	a1,s7
    3c1c:	dc0fe0ef          	jal	ra,21dc <__subdf3>
    3c20:	03012e03          	lw	t3,48(sp)
    3c24:	00050913          	mv	s2,a0
    3c28:	00058993          	mv	s3,a1
    3c2c:	fffd0313          	addi	t1,s10,-1
    3c30:	01c36e33          	or	t3,t1,t3
    3c34:	480e1863          	bnez	t3,40c4 <__ieee754_pow+0xd34>
    3c38:	00002697          	auipc	a3,0x2
    3c3c:	1e068693          	addi	a3,a3,480 # 5e18 <__clz_tab+0x130>
    3c40:	0006a783          	lw	a5,0(a3)
    3c44:	0046a803          	lw	a6,4(a3)
    3c48:	00f12423          	sw	a5,8(sp)
    3c4c:	01012623          	sw	a6,12(sp)
    3c50:	00000c13          	li	s8,0
    3c54:	000c0613          	mv	a2,s8
    3c58:	000d8693          	mv	a3,s11
    3c5c:	000c8513          	mv	a0,s9
    3c60:	000d8593          	mv	a1,s11
    3c64:	d78fe0ef          	jal	ra,21dc <__subdf3>
    3c68:	00040613          	mv	a2,s0
    3c6c:	00048693          	mv	a3,s1
    3c70:	f19fd0ef          	jal	ra,1b88 <__muldf3>
    3c74:	00050b13          	mv	s6,a0
    3c78:	00058b93          	mv	s7,a1
    3c7c:	000c8613          	mv	a2,s9
    3c80:	000d8693          	mv	a3,s11
    3c84:	00090513          	mv	a0,s2
    3c88:	00098593          	mv	a1,s3
    3c8c:	efdfd0ef          	jal	ra,1b88 <__muldf3>
    3c90:	00050613          	mv	a2,a0
    3c94:	00058693          	mv	a3,a1
    3c98:	000b0513          	mv	a0,s6
    3c9c:	000b8593          	mv	a1,s7
    3ca0:	591000ef          	jal	ra,4a30 <__adddf3>
    3ca4:	00050913          	mv	s2,a0
    3ca8:	00058993          	mv	s3,a1
    3cac:	000c0613          	mv	a2,s8
    3cb0:	000d8693          	mv	a3,s11
    3cb4:	00040513          	mv	a0,s0
    3cb8:	00048593          	mv	a1,s1
    3cbc:	ecdfd0ef          	jal	ra,1b88 <__muldf3>
    3cc0:	00050613          	mv	a2,a0
    3cc4:	00058693          	mv	a3,a1
    3cc8:	00050413          	mv	s0,a0
    3ccc:	00058493          	mv	s1,a1
    3cd0:	00090513          	mv	a0,s2
    3cd4:	00098593          	mv	a1,s3
    3cd8:	559000ef          	jal	ra,4a30 <__adddf3>
    3cdc:	409007b7          	lui	a5,0x40900
    3ce0:	00050a13          	mv	s4,a0
    3ce4:	00058b13          	mv	s6,a1
    3ce8:	00058b93          	mv	s7,a1
    3cec:	36f5c463          	blt	a1,a5,4054 <__ieee754_pow+0xcc4>
    3cf0:	40f587b3          	sub	a5,a1,a5
    3cf4:	00a7e7b3          	or	a5,a5,a0
    3cf8:	5e079463          	bnez	a5,42e0 <__ieee754_pow+0xf50>
    3cfc:	00002797          	auipc	a5,0x2
    3d00:	1b478793          	addi	a5,a5,436 # 5eb0 <__clz_tab+0x1c8>
    3d04:	0007a603          	lw	a2,0(a5)
    3d08:	0047a683          	lw	a3,4(a5)
    3d0c:	00090513          	mv	a0,s2
    3d10:	00098593          	mv	a1,s3
    3d14:	51d000ef          	jal	ra,4a30 <__adddf3>
    3d18:	00050d13          	mv	s10,a0
    3d1c:	00058d93          	mv	s11,a1
    3d20:	00040613          	mv	a2,s0
    3d24:	00048693          	mv	a3,s1
    3d28:	000a0513          	mv	a0,s4
    3d2c:	000b0593          	mv	a1,s6
    3d30:	cacfe0ef          	jal	ra,21dc <__subdf3>
    3d34:	00050613          	mv	a2,a0
    3d38:	00058693          	mv	a3,a1
    3d3c:	000d0513          	mv	a0,s10
    3d40:	000d8593          	mv	a1,s11
    3d44:	579010ef          	jal	ra,5abc <__gedf2>
    3d48:	58a04c63          	bgtz	a0,42e0 <__ieee754_pow+0xf50>
    3d4c:	414bd793          	srai	a5,s7,0x14
    3d50:	7ff7f793          	andi	a5,a5,2047
    3d54:	00100537          	lui	a0,0x100
    3d58:	c0278793          	addi	a5,a5,-1022
    3d5c:	40f557b3          	sra	a5,a0,a5
    3d60:	017787b3          	add	a5,a5,s7
    3d64:	4147d713          	srai	a4,a5,0x14
    3d68:	7ff77713          	andi	a4,a4,2047
    3d6c:	c0170713          	addi	a4,a4,-1023
    3d70:	fff50a13          	addi	s4,a0,-1 # fffff <__global_pointer$+0xf9467>
    3d74:	40ea55b3          	sra	a1,s4,a4
    3d78:	fff5c593          	not	a1,a1
    3d7c:	00f5f5b3          	and	a1,a1,a5
    3d80:	0147fa33          	and	s4,a5,s4
    3d84:	01400793          	li	a5,20
    3d88:	00aa6a33          	or	s4,s4,a0
    3d8c:	40e78733          	sub	a4,a5,a4
    3d90:	00000613          	li	a2,0
    3d94:	00058693          	mv	a3,a1
    3d98:	40ea5a33          	sra	s4,s4,a4
    3d9c:	000bd463          	bgez	s7,3da4 <__ieee754_pow+0xa14>
    3da0:	41400a33          	neg	s4,s4
    3da4:	00040513          	mv	a0,s0
    3da8:	00048593          	mv	a1,s1
    3dac:	c30fe0ef          	jal	ra,21dc <__subdf3>
    3db0:	00050613          	mv	a2,a0
    3db4:	00058693          	mv	a3,a1
    3db8:	00050413          	mv	s0,a0
    3dbc:	00058493          	mv	s1,a1
    3dc0:	00090513          	mv	a0,s2
    3dc4:	00098593          	mv	a1,s3
    3dc8:	469000ef          	jal	ra,4a30 <__adddf3>
    3dcc:	00058b13          	mv	s6,a1
    3dd0:	014a1d93          	slli	s11,s4,0x14
    3dd4:	00002717          	auipc	a4,0x2
    3dd8:	0ec70713          	addi	a4,a4,236 # 5ec0 <__clz_tab+0x1d8>
    3ddc:	00072603          	lw	a2,0(a4)
    3de0:	00472683          	lw	a3,4(a4)
    3de4:	00000c13          	li	s8,0
    3de8:	000c0513          	mv	a0,s8
    3dec:	000b0593          	mv	a1,s6
    3df0:	d99fd0ef          	jal	ra,1b88 <__muldf3>
    3df4:	000b0d13          	mv	s10,s6
    3df8:	00058b93          	mv	s7,a1
    3dfc:	00050b13          	mv	s6,a0
    3e00:	00040613          	mv	a2,s0
    3e04:	00048693          	mv	a3,s1
    3e08:	000c0513          	mv	a0,s8
    3e0c:	000d0593          	mv	a1,s10
    3e10:	bccfe0ef          	jal	ra,21dc <__subdf3>
    3e14:	00050613          	mv	a2,a0
    3e18:	00058693          	mv	a3,a1
    3e1c:	00090513          	mv	a0,s2
    3e20:	00098593          	mv	a1,s3
    3e24:	bb8fe0ef          	jal	ra,21dc <__subdf3>
    3e28:	00002717          	auipc	a4,0x2
    3e2c:	0a070713          	addi	a4,a4,160 # 5ec8 <__clz_tab+0x1e0>
    3e30:	00072603          	lw	a2,0(a4)
    3e34:	00472683          	lw	a3,4(a4)
    3e38:	d51fd0ef          	jal	ra,1b88 <__muldf3>
    3e3c:	00002717          	auipc	a4,0x2
    3e40:	09470713          	addi	a4,a4,148 # 5ed0 <__clz_tab+0x1e8>
    3e44:	00072603          	lw	a2,0(a4)
    3e48:	00472683          	lw	a3,4(a4)
    3e4c:	00050413          	mv	s0,a0
    3e50:	00058493          	mv	s1,a1
    3e54:	000c0513          	mv	a0,s8
    3e58:	000d0593          	mv	a1,s10
    3e5c:	d2dfd0ef          	jal	ra,1b88 <__muldf3>
    3e60:	00050613          	mv	a2,a0
    3e64:	00058693          	mv	a3,a1
    3e68:	00040513          	mv	a0,s0
    3e6c:	00048593          	mv	a1,s1
    3e70:	3c1000ef          	jal	ra,4a30 <__adddf3>
    3e74:	00050913          	mv	s2,a0
    3e78:	00058993          	mv	s3,a1
    3e7c:	00050613          	mv	a2,a0
    3e80:	00058693          	mv	a3,a1
    3e84:	000b0513          	mv	a0,s6
    3e88:	000b8593          	mv	a1,s7
    3e8c:	3a5000ef          	jal	ra,4a30 <__adddf3>
    3e90:	000b0613          	mv	a2,s6
    3e94:	000b8693          	mv	a3,s7
    3e98:	00050413          	mv	s0,a0
    3e9c:	00058493          	mv	s1,a1
    3ea0:	b3cfe0ef          	jal	ra,21dc <__subdf3>
    3ea4:	00050613          	mv	a2,a0
    3ea8:	00058693          	mv	a3,a1
    3eac:	00090513          	mv	a0,s2
    3eb0:	00098593          	mv	a1,s3
    3eb4:	b28fe0ef          	jal	ra,21dc <__subdf3>
    3eb8:	00050b13          	mv	s6,a0
    3ebc:	00058b93          	mv	s7,a1
    3ec0:	00040613          	mv	a2,s0
    3ec4:	00048693          	mv	a3,s1
    3ec8:	00040513          	mv	a0,s0
    3ecc:	00048593          	mv	a1,s1
    3ed0:	cb9fd0ef          	jal	ra,1b88 <__muldf3>
    3ed4:	00002797          	auipc	a5,0x2
    3ed8:	00478793          	addi	a5,a5,4 # 5ed8 <__clz_tab+0x1f0>
    3edc:	0007a603          	lw	a2,0(a5)
    3ee0:	0047a683          	lw	a3,4(a5)
    3ee4:	00050913          	mv	s2,a0
    3ee8:	00058993          	mv	s3,a1
    3eec:	c9dfd0ef          	jal	ra,1b88 <__muldf3>
    3ef0:	00002797          	auipc	a5,0x2
    3ef4:	ff078793          	addi	a5,a5,-16 # 5ee0 <__clz_tab+0x1f8>
    3ef8:	0007a603          	lw	a2,0(a5)
    3efc:	0047a683          	lw	a3,4(a5)
    3f00:	adcfe0ef          	jal	ra,21dc <__subdf3>
    3f04:	00090613          	mv	a2,s2
    3f08:	00098693          	mv	a3,s3
    3f0c:	c7dfd0ef          	jal	ra,1b88 <__muldf3>
    3f10:	00002797          	auipc	a5,0x2
    3f14:	fd878793          	addi	a5,a5,-40 # 5ee8 <__clz_tab+0x200>
    3f18:	0007a603          	lw	a2,0(a5)
    3f1c:	0047a683          	lw	a3,4(a5)
    3f20:	311000ef          	jal	ra,4a30 <__adddf3>
    3f24:	00090613          	mv	a2,s2
    3f28:	00098693          	mv	a3,s3
    3f2c:	c5dfd0ef          	jal	ra,1b88 <__muldf3>
    3f30:	00002797          	auipc	a5,0x2
    3f34:	fc078793          	addi	a5,a5,-64 # 5ef0 <__clz_tab+0x208>
    3f38:	0007a603          	lw	a2,0(a5)
    3f3c:	0047a683          	lw	a3,4(a5)
    3f40:	a9cfe0ef          	jal	ra,21dc <__subdf3>
    3f44:	00090613          	mv	a2,s2
    3f48:	00098693          	mv	a3,s3
    3f4c:	c3dfd0ef          	jal	ra,1b88 <__muldf3>
    3f50:	00002797          	auipc	a5,0x2
    3f54:	fa878793          	addi	a5,a5,-88 # 5ef8 <__clz_tab+0x210>
    3f58:	0007a603          	lw	a2,0(a5)
    3f5c:	0047a683          	lw	a3,4(a5)
    3f60:	2d1000ef          	jal	ra,4a30 <__adddf3>
    3f64:	00090613          	mv	a2,s2
    3f68:	00098693          	mv	a3,s3
    3f6c:	c1dfd0ef          	jal	ra,1b88 <__muldf3>
    3f70:	00050613          	mv	a2,a0
    3f74:	00058693          	mv	a3,a1
    3f78:	00040513          	mv	a0,s0
    3f7c:	00048593          	mv	a1,s1
    3f80:	a5cfe0ef          	jal	ra,21dc <__subdf3>
    3f84:	00050613          	mv	a2,a0
    3f88:	00058693          	mv	a3,a1
    3f8c:	00050c13          	mv	s8,a0
    3f90:	00058c93          	mv	s9,a1
    3f94:	00040513          	mv	a0,s0
    3f98:	00048593          	mv	a1,s1
    3f9c:	bedfd0ef          	jal	ra,1b88 <__muldf3>
    3fa0:	00002697          	auipc	a3,0x2
    3fa4:	f6068693          	addi	a3,a3,-160 # 5f00 <__clz_tab+0x218>
    3fa8:	0006a603          	lw	a2,0(a3)
    3fac:	0046a683          	lw	a3,4(a3)
    3fb0:	00050913          	mv	s2,a0
    3fb4:	00058993          	mv	s3,a1
    3fb8:	000c0513          	mv	a0,s8
    3fbc:	000c8593          	mv	a1,s9
    3fc0:	a1cfe0ef          	jal	ra,21dc <__subdf3>
    3fc4:	00050613          	mv	a2,a0
    3fc8:	00058693          	mv	a3,a1
    3fcc:	00090513          	mv	a0,s2
    3fd0:	00098593          	mv	a1,s3
    3fd4:	2e0010ef          	jal	ra,52b4 <__divdf3>
    3fd8:	00050913          	mv	s2,a0
    3fdc:	00058993          	mv	s3,a1
    3fe0:	000b0613          	mv	a2,s6
    3fe4:	000b8693          	mv	a3,s7
    3fe8:	00040513          	mv	a0,s0
    3fec:	00048593          	mv	a1,s1
    3ff0:	b99fd0ef          	jal	ra,1b88 <__muldf3>
    3ff4:	000b0613          	mv	a2,s6
    3ff8:	000b8693          	mv	a3,s7
    3ffc:	235000ef          	jal	ra,4a30 <__adddf3>
    4000:	00050613          	mv	a2,a0
    4004:	00058693          	mv	a3,a1
    4008:	00090513          	mv	a0,s2
    400c:	00098593          	mv	a1,s3
    4010:	9ccfe0ef          	jal	ra,21dc <__subdf3>
    4014:	00040613          	mv	a2,s0
    4018:	00048693          	mv	a3,s1
    401c:	9c0fe0ef          	jal	ra,21dc <__subdf3>
    4020:	00058693          	mv	a3,a1
    4024:	00050613          	mv	a2,a0
    4028:	004aa583          	lw	a1,4(s5)
    402c:	000aa503          	lw	a0,0(s5)
    4030:	9acfe0ef          	jal	ra,21dc <__subdf3>
    4034:	00bd87b3          	add	a5,s11,a1
    4038:	4147d693          	srai	a3,a5,0x14
    403c:	32d05063          	blez	a3,435c <__ieee754_pow+0xfcc>
    4040:	00078593          	mv	a1,a5
    4044:	00812603          	lw	a2,8(sp)
    4048:	00c12683          	lw	a3,12(sp)
    404c:	b3dfd0ef          	jal	ra,1b88 <__muldf3>
    4050:	bb8ff06f          	j	3408 <__ieee754_pow+0x78>
    4054:	00159793          	slli	a5,a1,0x1
    4058:	4090d6b7          	lui	a3,0x4090d
    405c:	0017d793          	srli	a5,a5,0x1
    4060:	bff68693          	addi	a3,a3,-1025 # 4090cbff <__freertos_irq_stack_top+0x4070682f>
    4064:	26f6d263          	bge	a3,a5,42c8 <__ieee754_pow+0xf38>
    4068:	3f6f37b7          	lui	a5,0x3f6f3
    406c:	40078793          	addi	a5,a5,1024 # 3f6f3400 <__freertos_irq_stack_top+0x3f4ed030>
    4070:	00f587b3          	add	a5,a1,a5
    4074:	00a7e7b3          	or	a5,a5,a0
    4078:	02079063          	bnez	a5,4098 <__ieee754_pow+0xd08>
    407c:	00040613          	mv	a2,s0
    4080:	00048693          	mv	a3,s1
    4084:	958fe0ef          	jal	ra,21dc <__subdf3>
    4088:	00090613          	mv	a2,s2
    408c:	00098693          	mv	a3,s3
    4090:	22d010ef          	jal	ra,5abc <__gedf2>
    4094:	ca054ce3          	bltz	a0,3d4c <__ieee754_pow+0x9bc>
    4098:	00002417          	auipc	s0,0x2
    409c:	e2040413          	addi	s0,s0,-480 # 5eb8 <__clz_tab+0x1d0>
    40a0:	00042603          	lw	a2,0(s0)
    40a4:	00442683          	lw	a3,4(s0)
    40a8:	00812503          	lw	a0,8(sp)
    40ac:	00c12583          	lw	a1,12(sp)
    40b0:	ad9fd0ef          	jal	ra,1b88 <__muldf3>
    40b4:	00042603          	lw	a2,0(s0)
    40b8:	00442683          	lw	a3,4(s0)
    40bc:	acdfd0ef          	jal	ra,1b88 <__muldf3>
    40c0:	b48ff06f          	j	3408 <__ieee754_pow+0x78>
    40c4:	000aa783          	lw	a5,0(s5)
    40c8:	004aa803          	lw	a6,4(s5)
    40cc:	00f12423          	sw	a5,8(sp)
    40d0:	01012623          	sw	a6,12(sp)
    40d4:	b7dff06f          	j	3c50 <__ieee754_pow+0x8c0>
    40d8:	d60dd663          	bgez	s11,3644 <__ieee754_pow+0x2b4>
    40dc:	800005b7          	lui	a1,0x80000
    40e0:	00000513          	li	a0,0
    40e4:	01b5c5b3          	xor	a1,a1,s11
    40e8:	b20ff06f          	j	3408 <__ieee754_pow+0x78>
    40ec:	00002a97          	auipc	s5,0x2
    40f0:	cfca8a93          	addi	s5,s5,-772 # 5de8 <__clz_tab+0x100>
    40f4:	e68ff06f          	j	375c <__ieee754_pow+0x3cc>
    40f8:	3ff006b7          	lui	a3,0x3ff00
    40fc:	ffe68613          	addi	a2,a3,-2 # 3feffffe <__freertos_irq_stack_top+0x3fcf9c2e>
    4100:	ca865663          	bge	a2,s0,35ac <__ieee754_pow+0x21c>
    4104:	d686cc63          	blt	a3,s0,367c <__ieee754_pow+0x2ec>
    4108:	00002a97          	auipc	s5,0x2
    410c:	ce0a8a93          	addi	s5,s5,-800 # 5de8 <__clz_tab+0x100>
    4110:	000aa603          	lw	a2,0(s5)
    4114:	004aa683          	lw	a3,4(s5)
    4118:	01c12823          	sw	t3,16(sp)
    411c:	8c0fe0ef          	jal	ra,21dc <__subdf3>
    4120:	00002697          	auipc	a3,0x2
    4124:	d0868693          	addi	a3,a3,-760 # 5e28 <__clz_tab+0x140>
    4128:	0006a603          	lw	a2,0(a3)
    412c:	0046a683          	lw	a3,4(a3)
    4130:	00050413          	mv	s0,a0
    4134:	00058493          	mv	s1,a1
    4138:	a51fd0ef          	jal	ra,1b88 <__muldf3>
    413c:	00002697          	auipc	a3,0x2
    4140:	cf468693          	addi	a3,a3,-780 # 5e30 <__clz_tab+0x148>
    4144:	0006a603          	lw	a2,0(a3)
    4148:	0046a683          	lw	a3,4(a3)
    414c:	00050913          	mv	s2,a0
    4150:	00058993          	mv	s3,a1
    4154:	00040513          	mv	a0,s0
    4158:	00048593          	mv	a1,s1
    415c:	a2dfd0ef          	jal	ra,1b88 <__muldf3>
    4160:	00002697          	auipc	a3,0x2
    4164:	cd868693          	addi	a3,a3,-808 # 5e38 <__clz_tab+0x150>
    4168:	0006a603          	lw	a2,0(a3)
    416c:	0046a683          	lw	a3,4(a3)
    4170:	00a12423          	sw	a0,8(sp)
    4174:	00b12623          	sw	a1,12(sp)
    4178:	00040513          	mv	a0,s0
    417c:	00048593          	mv	a1,s1
    4180:	a09fd0ef          	jal	ra,1b88 <__muldf3>
    4184:	00058693          	mv	a3,a1
    4188:	00002597          	auipc	a1,0x2
    418c:	cb858593          	addi	a1,a1,-840 # 5e40 <__clz_tab+0x158>
    4190:	00050613          	mv	a2,a0
    4194:	0005a503          	lw	a0,0(a1)
    4198:	0045a583          	lw	a1,4(a1)
    419c:	840fe0ef          	jal	ra,21dc <__subdf3>
    41a0:	00040613          	mv	a2,s0
    41a4:	00048693          	mv	a3,s1
    41a8:	9e1fd0ef          	jal	ra,1b88 <__muldf3>
    41ac:	00058693          	mv	a3,a1
    41b0:	00002597          	auipc	a1,0x2
    41b4:	c9858593          	addi	a1,a1,-872 # 5e48 <__clz_tab+0x160>
    41b8:	00050613          	mv	a2,a0
    41bc:	0005a503          	lw	a0,0(a1)
    41c0:	0045a583          	lw	a1,4(a1)
    41c4:	818fe0ef          	jal	ra,21dc <__subdf3>
    41c8:	00050b13          	mv	s6,a0
    41cc:	00058b93          	mv	s7,a1
    41d0:	00040613          	mv	a2,s0
    41d4:	00048693          	mv	a3,s1
    41d8:	00040513          	mv	a0,s0
    41dc:	00048593          	mv	a1,s1
    41e0:	9a9fd0ef          	jal	ra,1b88 <__muldf3>
    41e4:	00050613          	mv	a2,a0
    41e8:	00058693          	mv	a3,a1
    41ec:	000b0513          	mv	a0,s6
    41f0:	000b8593          	mv	a1,s7
    41f4:	995fd0ef          	jal	ra,1b88 <__muldf3>
    41f8:	00002697          	auipc	a3,0x2
    41fc:	c5868693          	addi	a3,a3,-936 # 5e50 <__clz_tab+0x168>
    4200:	0006a603          	lw	a2,0(a3)
    4204:	0046a683          	lw	a3,4(a3)
    4208:	981fd0ef          	jal	ra,1b88 <__muldf3>
    420c:	00812703          	lw	a4,8(sp)
    4210:	00c12783          	lw	a5,12(sp)
    4214:	00050613          	mv	a2,a0
    4218:	00058693          	mv	a3,a1
    421c:	00070513          	mv	a0,a4
    4220:	00078593          	mv	a1,a5
    4224:	fb9fd0ef          	jal	ra,21dc <__subdf3>
    4228:	00050613          	mv	a2,a0
    422c:	00058693          	mv	a3,a1
    4230:	00050b13          	mv	s6,a0
    4234:	00058b93          	mv	s7,a1
    4238:	00090513          	mv	a0,s2
    423c:	00098593          	mv	a1,s3
    4240:	7f0000ef          	jal	ra,4a30 <__adddf3>
    4244:	00000613          	li	a2,0
    4248:	00098693          	mv	a3,s3
    424c:	00060513          	mv	a0,a2
    4250:	00060413          	mv	s0,a2
    4254:	00090613          	mv	a2,s2
    4258:	00058493          	mv	s1,a1
    425c:	f81fd0ef          	jal	ra,21dc <__subdf3>
    4260:	00050613          	mv	a2,a0
    4264:	00058693          	mv	a3,a1
    4268:	000b0513          	mv	a0,s6
    426c:	000b8593          	mv	a1,s7
    4270:	f6dfd0ef          	jal	ra,21dc <__subdf3>
    4274:	00050913          	mv	s2,a0
    4278:	00058993          	mv	s3,a1
    427c:	01012e03          	lw	t3,16(sp)
    4280:	9adff06f          	j	3c2c <__ieee754_pow+0x89c>
    4284:	00098613          	mv	a2,s3
    4288:	00098513          	mv	a0,s3
    428c:	00048693          	mv	a3,s1
    4290:	00048593          	mv	a1,s1
    4294:	8f5fd0ef          	jal	ra,1b88 <__muldf3>
    4298:	970ff06f          	j	3408 <__ieee754_pow+0x78>
    429c:	b20c9a63          	bnez	s9,35d0 <__ieee754_pow+0x240>
    42a0:	40d606b3          	sub	a3,a2,a3
    42a4:	40d95633          	sra	a2,s2,a3
    42a8:	00d616b3          	sll	a3,a2,a3
    42ac:	000c8d13          	mv	s10,s9
    42b0:	01268463          	beq	a3,s2,42b8 <__ieee754_pow+0xf28>
    42b4:	9c4ff06f          	j	3478 <__ieee754_pow+0xe8>
    42b8:	00167613          	andi	a2,a2,1
    42bc:	00200313          	li	t1,2
    42c0:	40c30d33          	sub	s10,t1,a2
    42c4:	9b4ff06f          	j	3478 <__ieee754_pow+0xe8>
    42c8:	3fe00737          	lui	a4,0x3fe00
    42cc:	00000d93          	li	s11,0
    42d0:	00000a13          	li	s4,0
    42d4:	b0f750e3          	bge	a4,a5,3dd4 <__ieee754_pow+0xa44>
    42d8:	4147d793          	srai	a5,a5,0x14
    42dc:	a79ff06f          	j	3d54 <__ieee754_pow+0x9c4>
    42e0:	00002417          	auipc	s0,0x2
    42e4:	b4040413          	addi	s0,s0,-1216 # 5e20 <__clz_tab+0x138>
    42e8:	db9ff06f          	j	40a0 <__ieee754_pow+0xd10>
    42ec:	00100793          	li	a5,1
    42f0:	00fd0463          	beq	s10,a5,42f8 <__ieee754_pow+0xf68>
    42f4:	914ff06f          	j	3408 <__ieee754_pow+0x78>
    42f8:	800007b7          	lui	a5,0x80000
    42fc:	00b7c5b3          	xor	a1,a5,a1
    4300:	908ff06f          	j	3408 <__ieee754_pow+0x78>
    4304:	00002697          	auipc	a3,0x2
    4308:	afc68693          	addi	a3,a3,-1284 # 5e00 <__clz_tab+0x118>
    430c:	0006a783          	lw	a5,0(a3)
    4310:	0046a803          	lw	a6,4(a3)
    4314:	00002697          	auipc	a3,0x2
    4318:	af468693          	addi	a3,a3,-1292 # 5e08 <__clz_tab+0x120>
    431c:	00f12823          	sw	a5,16(sp)
    4320:	01012a23          	sw	a6,20(sp)
    4324:	0006a783          	lw	a5,0(a3)
    4328:	0046a803          	lw	a6,4(a3)
    432c:	00002697          	auipc	a3,0x2
    4330:	ae468693          	addi	a3,a3,-1308 # 5e10 <__clz_tab+0x128>
    4334:	02f12c23          	sw	a5,56(sp)
    4338:	03012e23          	sw	a6,60(sp)
    433c:	0006a783          	lw	a5,0(a3)
    4340:	0046a803          	lw	a6,4(a3)
    4344:	000409b7          	lui	s3,0x40
    4348:	00f12423          	sw	a5,8(sp)
    434c:	01012623          	sw	a6,12(sp)
    4350:	00002a97          	auipc	s5,0x2
    4354:	a98a8a93          	addi	s5,s5,-1384 # 5de8 <__clz_tab+0x100>
    4358:	c28ff06f          	j	3780 <__ieee754_pow+0x3f0>
    435c:	000a0613          	mv	a2,s4
    4360:	518000ef          	jal	ra,4878 <scalbn>
    4364:	ce1ff06f          	j	4044 <__ieee754_pow+0xcb4>

00004368 <__ieee754_sqrt>:
    4368:	ff010113          	addi	sp,sp,-16
    436c:	7ff00737          	lui	a4,0x7ff00
    4370:	00812423          	sw	s0,8(sp)
    4374:	00912223          	sw	s1,4(sp)
    4378:	00112623          	sw	ra,12(sp)
    437c:	00b77833          	and	a6,a4,a1
    4380:	00058493          	mv	s1,a1
    4384:	00050413          	mv	s0,a0
    4388:	20e80863          	beq	a6,a4,4598 <__ieee754_sqrt+0x230>
    438c:	00058793          	mv	a5,a1
    4390:	00050693          	mv	a3,a0
    4394:	14b05a63          	blez	a1,44e8 <__ieee754_sqrt+0x180>
    4398:	4145de13          	srai	t3,a1,0x14
    439c:	240e0e63          	beqz	t3,45f8 <__ieee754_sqrt+0x290>
    43a0:	00100737          	lui	a4,0x100
    43a4:	fff70613          	addi	a2,a4,-1 # fffff <__global_pointer$+0xf9467>
    43a8:	00c7f7b3          	and	a5,a5,a2
    43ac:	00e7e7b3          	or	a5,a5,a4
    43b0:	c01e0e13          	addi	t3,t3,-1023
    43b4:	00179713          	slli	a4,a5,0x1
    43b8:	001e7613          	andi	a2,t3,1
    43bc:	01f6d793          	srli	a5,a3,0x1f
    43c0:	00f707b3          	add	a5,a4,a5
    43c4:	00169713          	slli	a4,a3,0x1
    43c8:	00060a63          	beqz	a2,43dc <__ieee754_sqrt+0x74>
    43cc:	01f75713          	srli	a4,a4,0x1f
    43d0:	00179793          	slli	a5,a5,0x1
    43d4:	00e787b3          	add	a5,a5,a4
    43d8:	00269713          	slli	a4,a3,0x2
    43dc:	401e5e13          	srai	t3,t3,0x1
    43e0:	01600593          	li	a1,22
    43e4:	00000e93          	li	t4,0
    43e8:	00000693          	li	a3,0
    43ec:	00200637          	lui	a2,0x200
    43f0:	00c68533          	add	a0,a3,a2
    43f4:	01f75813          	srli	a6,a4,0x1f
    43f8:	fff58593          	addi	a1,a1,-1
    43fc:	00a7c863          	blt	a5,a0,440c <__ieee754_sqrt+0xa4>
    4400:	40a787b3          	sub	a5,a5,a0
    4404:	00c506b3          	add	a3,a0,a2
    4408:	00ce8eb3          	add	t4,t4,a2
    440c:	00179793          	slli	a5,a5,0x1
    4410:	00f807b3          	add	a5,a6,a5
    4414:	00171713          	slli	a4,a4,0x1
    4418:	00165613          	srli	a2,a2,0x1
    441c:	fc059ae3          	bnez	a1,43f0 <__ieee754_sqrt+0x88>
    4420:	00000313          	li	t1,0
    4424:	02000813          	li	a6,32
    4428:	80000637          	lui	a2,0x80000
    442c:	0240006f          	j	4450 <__ieee754_sqrt+0xe8>
    4430:	12d78e63          	beq	a5,a3,456c <__ieee754_sqrt+0x204>
    4434:	01f75513          	srli	a0,a4,0x1f
    4438:	00179793          	slli	a5,a5,0x1
    443c:	fff80813          	addi	a6,a6,-1 # c00fffff <__freertos_irq_stack_top+0xbfef9c2f>
    4440:	00a787b3          	add	a5,a5,a0
    4444:	00171713          	slli	a4,a4,0x1
    4448:	00165613          	srli	a2,a2,0x1
    444c:	04080663          	beqz	a6,4498 <__ieee754_sqrt+0x130>
    4450:	00b60533          	add	a0,a2,a1
    4454:	fcf6dee3          	bge	a3,a5,4430 <__ieee754_sqrt+0xc8>
    4458:	00c505b3          	add	a1,a0,a2
    445c:	00068893          	mv	a7,a3
    4460:	0e054e63          	bltz	a0,455c <__ieee754_sqrt+0x1f4>
    4464:	40d787b3          	sub	a5,a5,a3
    4468:	00a736b3          	sltu	a3,a4,a0
    446c:	40d787b3          	sub	a5,a5,a3
    4470:	40a70733          	sub	a4,a4,a0
    4474:	01f75513          	srli	a0,a4,0x1f
    4478:	00179793          	slli	a5,a5,0x1
    447c:	fff80813          	addi	a6,a6,-1
    4480:	00c30333          	add	t1,t1,a2
    4484:	00088693          	mv	a3,a7
    4488:	00a787b3          	add	a5,a5,a0
    448c:	00171713          	slli	a4,a4,0x1
    4490:	00165613          	srli	a2,a2,0x1
    4494:	fa081ee3          	bnez	a6,4450 <__ieee754_sqrt+0xe8>
    4498:	00e7e7b3          	or	a5,a5,a4
    449c:	0e079463          	bnez	a5,4584 <__ieee754_sqrt+0x21c>
    44a0:	00135813          	srli	a6,t1,0x1
    44a4:	401ed713          	srai	a4,t4,0x1
    44a8:	3fe004b7          	lui	s1,0x3fe00
    44ac:	001efe93          	andi	t4,t4,1
    44b0:	009704b3          	add	s1,a4,s1
    44b4:	000e8663          	beqz	t4,44c0 <__ieee754_sqrt+0x158>
    44b8:	800007b7          	lui	a5,0x80000
    44bc:	00f86833          	or	a6,a6,a5
    44c0:	014e1713          	slli	a4,t3,0x14
    44c4:	00080413          	mv	s0,a6
    44c8:	00970733          	add	a4,a4,s1
    44cc:	00040513          	mv	a0,s0
    44d0:	00c12083          	lw	ra,12(sp)
    44d4:	00812403          	lw	s0,8(sp)
    44d8:	00412483          	lw	s1,4(sp)
    44dc:	00070593          	mv	a1,a4
    44e0:	01010113          	addi	sp,sp,16
    44e4:	00008067          	ret
    44e8:	00159713          	slli	a4,a1,0x1
    44ec:	00175713          	srli	a4,a4,0x1
    44f0:	00a76833          	or	a6,a4,a0
    44f4:	00058713          	mv	a4,a1
    44f8:	fc080ae3          	beqz	a6,44cc <__ieee754_sqrt+0x164>
    44fc:	0c059c63          	bnez	a1,45d4 <__ieee754_sqrt+0x26c>
    4500:	00b6d593          	srli	a1,a3,0xb
    4504:	feb78793          	addi	a5,a5,-21 # 7fffffeb <__freertos_irq_stack_top+0x7fdf9c1b>
    4508:	00058713          	mv	a4,a1
    450c:	01569693          	slli	a3,a3,0x15
    4510:	fe0588e3          	beqz	a1,4500 <__ieee754_sqrt+0x198>
    4514:	0145d613          	srli	a2,a1,0x14
    4518:	0e061a63          	bnez	a2,460c <__ieee754_sqrt+0x2a4>
    451c:	00000613          	li	a2,0
    4520:	0080006f          	j	4528 <__ieee754_sqrt+0x1c0>
    4524:	00050613          	mv	a2,a0
    4528:	00171713          	slli	a4,a4,0x1
    452c:	00b71593          	slli	a1,a4,0xb
    4530:	00160513          	addi	a0,a2,1 # 80000001 <__freertos_irq_stack_top+0x7fdf9c31>
    4534:	fe05d8e3          	bgez	a1,4524 <__ieee754_sqrt+0x1bc>
    4538:	02000893          	li	a7,32
    453c:	00068813          	mv	a6,a3
    4540:	40a888b3          	sub	a7,a7,a0
    4544:	00070593          	mv	a1,a4
    4548:	00a696b3          	sll	a3,a3,a0
    454c:	01185733          	srl	a4,a6,a7
    4550:	40c78e33          	sub	t3,a5,a2
    4554:	00b767b3          	or	a5,a4,a1
    4558:	e49ff06f          	j	43a0 <__ieee754_sqrt+0x38>
    455c:	fff5c893          	not	a7,a1
    4560:	01f8d893          	srli	a7,a7,0x1f
    4564:	011688b3          	add	a7,a3,a7
    4568:	efdff06f          	j	4464 <__ieee754_sqrt+0xfc>
    456c:	eca764e3          	bltu	a4,a0,4434 <__ieee754_sqrt+0xcc>
    4570:	00c505b3          	add	a1,a0,a2
    4574:	fe0544e3          	bltz	a0,455c <__ieee754_sqrt+0x1f4>
    4578:	00078893          	mv	a7,a5
    457c:	00000793          	li	a5,0
    4580:	ef1ff06f          	j	4470 <__ieee754_sqrt+0x108>
    4584:	fff00793          	li	a5,-1
    4588:	06f30e63          	beq	t1,a5,4604 <__ieee754_sqrt+0x29c>
    458c:	00130813          	addi	a6,t1,1
    4590:	00185813          	srli	a6,a6,0x1
    4594:	f11ff06f          	j	44a4 <__ieee754_sqrt+0x13c>
    4598:	00050613          	mv	a2,a0
    459c:	00058693          	mv	a3,a1
    45a0:	de8fd0ef          	jal	ra,1b88 <__muldf3>
    45a4:	00040613          	mv	a2,s0
    45a8:	00048693          	mv	a3,s1
    45ac:	484000ef          	jal	ra,4a30 <__adddf3>
    45b0:	00050413          	mv	s0,a0
    45b4:	00040513          	mv	a0,s0
    45b8:	00c12083          	lw	ra,12(sp)
    45bc:	00812403          	lw	s0,8(sp)
    45c0:	00058713          	mv	a4,a1
    45c4:	00412483          	lw	s1,4(sp)
    45c8:	00070593          	mv	a1,a4
    45cc:	01010113          	addi	sp,sp,16
    45d0:	00008067          	ret
    45d4:	00050613          	mv	a2,a0
    45d8:	00058693          	mv	a3,a1
    45dc:	c01fd0ef          	jal	ra,21dc <__subdf3>
    45e0:	00050613          	mv	a2,a0
    45e4:	00058693          	mv	a3,a1
    45e8:	4cd000ef          	jal	ra,52b4 <__divdf3>
    45ec:	00050413          	mv	s0,a0
    45f0:	00058713          	mv	a4,a1
    45f4:	ed9ff06f          	j	44cc <__ieee754_sqrt+0x164>
    45f8:	00058713          	mv	a4,a1
    45fc:	00000793          	li	a5,0
    4600:	f1dff06f          	j	451c <__ieee754_sqrt+0x1b4>
    4604:	001e8e93          	addi	t4,t4,1
    4608:	e9dff06f          	j	44a4 <__ieee754_sqrt+0x13c>
    460c:	00068813          	mv	a6,a3
    4610:	02000893          	li	a7,32
    4614:	fff00613          	li	a2,-1
    4618:	f35ff06f          	j	454c <__ieee754_sqrt+0x1e4>

0000461c <fabs>:
    461c:	00159593          	slli	a1,a1,0x1
    4620:	0015d593          	srli	a1,a1,0x1
    4624:	00008067          	ret

00004628 <finite>:
    4628:	00159593          	slli	a1,a1,0x1
    462c:	0015d593          	srli	a1,a1,0x1
    4630:	80100537          	lui	a0,0x80100
    4634:	00a58533          	add	a0,a1,a0
    4638:	01f55513          	srli	a0,a0,0x1f
    463c:	00008067          	ret

00004640 <nan>:
    4640:	00002797          	auipc	a5,0x2
    4644:	8c878793          	addi	a5,a5,-1848 # 5f08 <__clz_tab+0x220>
    4648:	0007a503          	lw	a0,0(a5)
    464c:	0047a583          	lw	a1,4(a5)
    4650:	00008067          	ret

00004654 <rint>:
    4654:	4145d713          	srai	a4,a1,0x14
    4658:	fd010113          	addi	sp,sp,-48
    465c:	7ff77713          	andi	a4,a4,2047
    4660:	02812423          	sw	s0,40(sp)
    4664:	02112623          	sw	ra,44(sp)
    4668:	02912223          	sw	s1,36(sp)
    466c:	03212023          	sw	s2,32(sp)
    4670:	01312e23          	sw	s3,28(sp)
    4674:	c0170613          	addi	a2,a4,-1023
    4678:	01300893          	li	a7,19
    467c:	00058793          	mv	a5,a1
    4680:	00050693          	mv	a3,a0
    4684:	00058e13          	mv	t3,a1
    4688:	01f5d413          	srli	s0,a1,0x1f
    468c:	16c8cc63          	blt	a7,a2,4804 <rint+0x1b0>
    4690:	0c064863          	bltz	a2,4760 <rint+0x10c>
    4694:	001005b7          	lui	a1,0x100
    4698:	fff58593          	addi	a1,a1,-1 # fffff <__global_pointer$+0xf9467>
    469c:	40c5d5b3          	sra	a1,a1,a2
    46a0:	00f5f533          	and	a0,a1,a5
    46a4:	00d56533          	or	a0,a0,a3
    46a8:	00068893          	mv	a7,a3
    46ac:	00078313          	mv	t1,a5
    46b0:	08050663          	beqz	a0,473c <rint+0xe8>
    46b4:	0015d593          	srli	a1,a1,0x1
    46b8:	00f5f833          	and	a6,a1,a5
    46bc:	00d86833          	or	a6,a6,a3
    46c0:	02080663          	beqz	a6,46ec <rint+0x98>
    46c4:	bee70693          	addi	a3,a4,-1042
    46c8:	00040e37          	lui	t3,0x40
    46cc:	0016b693          	seqz	a3,a3
    46d0:	fff5c593          	not	a1,a1
    46d4:	80000837          	lui	a6,0x80000
    46d8:	40d006b3          	neg	a3,a3
    46dc:	00f5f7b3          	and	a5,a1,a5
    46e0:	40ce5633          	sra	a2,t3,a2
    46e4:	00d87833          	and	a6,a6,a3
    46e8:	00c7ee33          	or	t3,a5,a2
    46ec:	00002797          	auipc	a5,0x2
    46f0:	82478793          	addi	a5,a5,-2012 # 5f10 <TWO52>
    46f4:	00341313          	slli	t1,s0,0x3
    46f8:	00678333          	add	t1,a5,t1
    46fc:	00032403          	lw	s0,0(t1)
    4700:	00432483          	lw	s1,4(t1)
    4704:	00080613          	mv	a2,a6
    4708:	000e0693          	mv	a3,t3
    470c:	00040513          	mv	a0,s0
    4710:	00048593          	mv	a1,s1
    4714:	31c000ef          	jal	ra,4a30 <__adddf3>
    4718:	00a12423          	sw	a0,8(sp)
    471c:	00b12623          	sw	a1,12(sp)
    4720:	00812503          	lw	a0,8(sp)
    4724:	00c12583          	lw	a1,12(sp)
    4728:	00040613          	mv	a2,s0
    472c:	00048693          	mv	a3,s1
    4730:	aadfd0ef          	jal	ra,21dc <__subdf3>
    4734:	00050893          	mv	a7,a0
    4738:	00058313          	mv	t1,a1
    473c:	02c12083          	lw	ra,44(sp)
    4740:	02812403          	lw	s0,40(sp)
    4744:	02412483          	lw	s1,36(sp)
    4748:	02012903          	lw	s2,32(sp)
    474c:	01c12983          	lw	s3,28(sp)
    4750:	00088513          	mv	a0,a7
    4754:	00030593          	mv	a1,t1
    4758:	03010113          	addi	sp,sp,48
    475c:	00008067          	ret
    4760:	800004b7          	lui	s1,0x80000
    4764:	fff4c493          	not	s1,s1
    4768:	00b4f733          	and	a4,s1,a1
    476c:	00a76733          	or	a4,a4,a0
    4770:	00050893          	mv	a7,a0
    4774:	00058313          	mv	t1,a1
    4778:	fc0702e3          	beqz	a4,473c <rint+0xe8>
    477c:	00c59793          	slli	a5,a1,0xc
    4780:	00c7d793          	srli	a5,a5,0xc
    4784:	00a7e733          	or	a4,a5,a0
    4788:	40e007b3          	neg	a5,a4
    478c:	00e7e7b3          	or	a5,a5,a4
    4790:	00001697          	auipc	a3,0x1
    4794:	78068693          	addi	a3,a3,1920 # 5f10 <TWO52>
    4798:	00341713          	slli	a4,s0,0x3
    479c:	00e686b3          	add	a3,a3,a4
    47a0:	00c7d793          	srli	a5,a5,0xc
    47a4:	0006a903          	lw	s2,0(a3)
    47a8:	0046a983          	lw	s3,4(a3)
    47ac:	fffe0737          	lui	a4,0xfffe0
    47b0:	00080337          	lui	t1,0x80
    47b4:	00b77733          	and	a4,a4,a1
    47b8:	0067f333          	and	t1,a5,t1
    47bc:	00e36333          	or	t1,t1,a4
    47c0:	00030693          	mv	a3,t1
    47c4:	00050613          	mv	a2,a0
    47c8:	00098593          	mv	a1,s3
    47cc:	00090513          	mv	a0,s2
    47d0:	260000ef          	jal	ra,4a30 <__adddf3>
    47d4:	00a12423          	sw	a0,8(sp)
    47d8:	00b12623          	sw	a1,12(sp)
    47dc:	00812503          	lw	a0,8(sp)
    47e0:	00c12583          	lw	a1,12(sp)
    47e4:	00090613          	mv	a2,s2
    47e8:	00098693          	mv	a3,s3
    47ec:	9f1fd0ef          	jal	ra,21dc <__subdf3>
    47f0:	00b4f4b3          	and	s1,s1,a1
    47f4:	01f41313          	slli	t1,s0,0x1f
    47f8:	0064e333          	or	t1,s1,t1
    47fc:	00050893          	mv	a7,a0
    4800:	f3dff06f          	j	473c <rint+0xe8>
    4804:	03300893          	li	a7,51
    4808:	02c8d663          	bge	a7,a2,4834 <rint+0x1e0>
    480c:	40000713          	li	a4,1024
    4810:	00050893          	mv	a7,a0
    4814:	00058313          	mv	t1,a1
    4818:	f2e612e3          	bne	a2,a4,473c <rint+0xe8>
    481c:	00050613          	mv	a2,a0
    4820:	000e0693          	mv	a3,t3
    4824:	20c000ef          	jal	ra,4a30 <__adddf3>
    4828:	00050893          	mv	a7,a0
    482c:	00058313          	mv	t1,a1
    4830:	f0dff06f          	j	473c <rint+0xe8>
    4834:	bed70713          	addi	a4,a4,-1043 # fffdfbed <__freertos_irq_stack_top+0xffdd981d>
    4838:	fff00613          	li	a2,-1
    483c:	00e65633          	srl	a2,a2,a4
    4840:	00a675b3          	and	a1,a2,a0
    4844:	00050893          	mv	a7,a0
    4848:	00078313          	mv	t1,a5
    484c:	ee0588e3          	beqz	a1,473c <rint+0xe8>
    4850:	00165613          	srli	a2,a2,0x1
    4854:	00a677b3          	and	a5,a2,a0
    4858:	00050813          	mv	a6,a0
    485c:	e80788e3          	beqz	a5,46ec <rint+0x98>
    4860:	40000837          	lui	a6,0x40000
    4864:	fff64613          	not	a2,a2
    4868:	00a676b3          	and	a3,a2,a0
    486c:	40e85733          	sra	a4,a6,a4
    4870:	00e6e833          	or	a6,a3,a4
    4874:	e79ff06f          	j	46ec <rint+0x98>

00004878 <scalbn>:
    4878:	ff010113          	addi	sp,sp,-16
    487c:	4145d793          	srai	a5,a1,0x14
    4880:	00812423          	sw	s0,8(sp)
    4884:	00112623          	sw	ra,12(sp)
    4888:	7ff7f793          	andi	a5,a5,2047
    488c:	00060413          	mv	s0,a2
    4890:	0a079063          	bnez	a5,4930 <scalbn+0xb8>
    4894:	00159793          	slli	a5,a1,0x1
    4898:	0017d793          	srli	a5,a5,0x1
    489c:	00a7e7b3          	or	a5,a5,a0
    48a0:	08078063          	beqz	a5,4920 <scalbn+0xa8>
    48a4:	00001797          	auipc	a5,0x1
    48a8:	67c78793          	addi	a5,a5,1660 # 5f20 <TWO52+0x10>
    48ac:	0007a603          	lw	a2,0(a5)
    48b0:	0047a683          	lw	a3,4(a5)
    48b4:	ad4fd0ef          	jal	ra,1b88 <__muldf3>
    48b8:	ffff47b7          	lui	a5,0xffff4
    48bc:	cb078793          	addi	a5,a5,-848 # ffff3cb0 <__freertos_irq_stack_top+0xffded8e0>
    48c0:	00058713          	mv	a4,a1
    48c4:	12f44a63          	blt	s0,a5,49f8 <scalbn+0x180>
    48c8:	4145d793          	srai	a5,a1,0x14
    48cc:	7ff7f793          	andi	a5,a5,2047
    48d0:	fca78793          	addi	a5,a5,-54
    48d4:	00f407b3          	add	a5,s0,a5
    48d8:	7fe00693          	li	a3,2046
    48dc:	06f6ce63          	blt	a3,a5,4958 <scalbn+0xe0>
    48e0:	0ef04a63          	bgtz	a5,49d4 <scalbn+0x15c>
    48e4:	fcb00693          	li	a3,-53
    48e8:	0ad7d663          	bge	a5,a3,4994 <scalbn+0x11c>
    48ec:	0000c7b7          	lui	a5,0xc
    48f0:	35078793          	addi	a5,a5,848 # c350 <__global_pointer$+0x57b8>
    48f4:	0687c263          	blt	a5,s0,4958 <scalbn+0xe0>
    48f8:	00001797          	auipc	a5,0x1
    48fc:	5c078793          	addi	a5,a5,1472 # 5eb8 <__clz_tab+0x1d0>
    4900:	0007a803          	lw	a6,0(a5)
    4904:	0047a883          	lw	a7,4(a5)
    4908:	1005ca63          	bltz	a1,4a1c <scalbn+0x1a4>
    490c:	0007a603          	lw	a2,0(a5)
    4910:	0047a683          	lw	a3,4(a5)
    4914:	00080513          	mv	a0,a6
    4918:	00088593          	mv	a1,a7
    491c:	a6cfd0ef          	jal	ra,1b88 <__muldf3>
    4920:	00c12083          	lw	ra,12(sp)
    4924:	00812403          	lw	s0,8(sp)
    4928:	01010113          	addi	sp,sp,16
    492c:	00008067          	ret
    4930:	7ff00693          	li	a3,2047
    4934:	00058713          	mv	a4,a1
    4938:	f8d79ee3          	bne	a5,a3,48d4 <scalbn+0x5c>
    493c:	00050613          	mv	a2,a0
    4940:	00058693          	mv	a3,a1
    4944:	0ec000ef          	jal	ra,4a30 <__adddf3>
    4948:	00c12083          	lw	ra,12(sp)
    494c:	00812403          	lw	s0,8(sp)
    4950:	01010113          	addi	sp,sp,16
    4954:	00008067          	ret
    4958:	00001797          	auipc	a5,0x1
    495c:	4c878793          	addi	a5,a5,1224 # 5e20 <__clz_tab+0x138>
    4960:	0007a803          	lw	a6,0(a5)
    4964:	0047a883          	lw	a7,4(a5)
    4968:	fa05d2e3          	bgez	a1,490c <scalbn+0x94>
    496c:	00001717          	auipc	a4,0x1
    4970:	5bc70713          	addi	a4,a4,1468 # 5f28 <TWO52+0x18>
    4974:	00072803          	lw	a6,0(a4)
    4978:	00472883          	lw	a7,4(a4)
    497c:	0007a603          	lw	a2,0(a5)
    4980:	0047a683          	lw	a3,4(a5)
    4984:	00080513          	mv	a0,a6
    4988:	00088593          	mv	a1,a7
    498c:	9fcfd0ef          	jal	ra,1b88 <__muldf3>
    4990:	f91ff06f          	j	4920 <scalbn+0xa8>
    4994:	801005b7          	lui	a1,0x80100
    4998:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef9c2f>
    499c:	03678793          	addi	a5,a5,54
    49a0:	00b77733          	and	a4,a4,a1
    49a4:	01479793          	slli	a5,a5,0x14
    49a8:	00e7e7b3          	or	a5,a5,a4
    49ac:	00001717          	auipc	a4,0x1
    49b0:	58c70713          	addi	a4,a4,1420 # 5f38 <TWO52+0x28>
    49b4:	00072603          	lw	a2,0(a4)
    49b8:	00472683          	lw	a3,4(a4)
    49bc:	00078593          	mv	a1,a5
    49c0:	9c8fd0ef          	jal	ra,1b88 <__muldf3>
    49c4:	00c12083          	lw	ra,12(sp)
    49c8:	00812403          	lw	s0,8(sp)
    49cc:	01010113          	addi	sp,sp,16
    49d0:	00008067          	ret
    49d4:	00c12083          	lw	ra,12(sp)
    49d8:	00812403          	lw	s0,8(sp)
    49dc:	801005b7          	lui	a1,0x80100
    49e0:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef9c2f>
    49e4:	00b77733          	and	a4,a4,a1
    49e8:	01479593          	slli	a1,a5,0x14
    49ec:	00b765b3          	or	a1,a4,a1
    49f0:	01010113          	addi	sp,sp,16
    49f4:	00008067          	ret
    49f8:	00001697          	auipc	a3,0x1
    49fc:	4c068693          	addi	a3,a3,1216 # 5eb8 <__clz_tab+0x1d0>
    4a00:	0006a603          	lw	a2,0(a3)
    4a04:	0046a683          	lw	a3,4(a3)
    4a08:	980fd0ef          	jal	ra,1b88 <__muldf3>
    4a0c:	00c12083          	lw	ra,12(sp)
    4a10:	00812403          	lw	s0,8(sp)
    4a14:	01010113          	addi	sp,sp,16
    4a18:	00008067          	ret
    4a1c:	00001717          	auipc	a4,0x1
    4a20:	51470713          	addi	a4,a4,1300 # 5f30 <TWO52+0x20>
    4a24:	00072803          	lw	a6,0(a4)
    4a28:	00472883          	lw	a7,4(a4)
    4a2c:	ee1ff06f          	j	490c <scalbn+0x94>

00004a30 <__adddf3>:
    4a30:	00100837          	lui	a6,0x100
    4a34:	fe010113          	addi	sp,sp,-32
    4a38:	fff80813          	addi	a6,a6,-1 # fffff <__global_pointer$+0xf9467>
    4a3c:	00b87733          	and	a4,a6,a1
    4a40:	00912a23          	sw	s1,20(sp)
    4a44:	00d87833          	and	a6,a6,a3
    4a48:	0145d493          	srli	s1,a1,0x14
    4a4c:	0146d313          	srli	t1,a3,0x14
    4a50:	00371e13          	slli	t3,a4,0x3
    4a54:	01312623          	sw	s3,12(sp)
    4a58:	01d55713          	srli	a4,a0,0x1d
    4a5c:	00381813          	slli	a6,a6,0x3
    4a60:	01d65793          	srli	a5,a2,0x1d
    4a64:	7ff4f493          	andi	s1,s1,2047
    4a68:	7ff37313          	andi	t1,t1,2047
    4a6c:	00112e23          	sw	ra,28(sp)
    4a70:	00812c23          	sw	s0,24(sp)
    4a74:	01212823          	sw	s2,16(sp)
    4a78:	01f5d993          	srli	s3,a1,0x1f
    4a7c:	01f6de93          	srli	t4,a3,0x1f
    4a80:	01c76733          	or	a4,a4,t3
    4a84:	00351f13          	slli	t5,a0,0x3
    4a88:	0107e833          	or	a6,a5,a6
    4a8c:	00361f93          	slli	t6,a2,0x3
    4a90:	40648e33          	sub	t3,s1,t1
    4a94:	1dd98463          	beq	s3,t4,4c5c <__adddf3+0x22c>
    4a98:	17c05863          	blez	t3,4c08 <__adddf3+0x1d8>
    4a9c:	20030a63          	beqz	t1,4cb0 <__adddf3+0x280>
    4aa0:	008006b7          	lui	a3,0x800
    4aa4:	7ff00793          	li	a5,2047
    4aa8:	00d86833          	or	a6,a6,a3
    4aac:	40f48e63          	beq	s1,a5,4ec8 <__adddf3+0x498>
    4ab0:	03800793          	li	a5,56
    4ab4:	3dc7ca63          	blt	a5,t3,4e88 <__adddf3+0x458>
    4ab8:	01f00793          	li	a5,31
    4abc:	55c7c663          	blt	a5,t3,5008 <__adddf3+0x5d8>
    4ac0:	02000513          	li	a0,32
    4ac4:	41c50533          	sub	a0,a0,t3
    4ac8:	01cfd7b3          	srl	a5,t6,t3
    4acc:	00a816b3          	sll	a3,a6,a0
    4ad0:	00af9933          	sll	s2,t6,a0
    4ad4:	00f6e6b3          	or	a3,a3,a5
    4ad8:	01203933          	snez	s2,s2
    4adc:	01c857b3          	srl	a5,a6,t3
    4ae0:	0126e933          	or	s2,a3,s2
    4ae4:	40f70733          	sub	a4,a4,a5
    4ae8:	412f0933          	sub	s2,t5,s2
    4aec:	012f37b3          	sltu	a5,t5,s2
    4af0:	40f70633          	sub	a2,a4,a5
    4af4:	00861793          	slli	a5,a2,0x8
    4af8:	2a07d263          	bgez	a5,4d9c <__adddf3+0x36c>
    4afc:	00800737          	lui	a4,0x800
    4b00:	fff70713          	addi	a4,a4,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    4b04:	00e67433          	and	s0,a2,a4
    4b08:	34040e63          	beqz	s0,4e64 <__adddf3+0x434>
    4b0c:	00040513          	mv	a0,s0
    4b10:	d7cfe0ef          	jal	ra,308c <__clzsi2>
    4b14:	ff850713          	addi	a4,a0,-8 # 800ffff8 <__freertos_irq_stack_top+0x7fef9c28>
    4b18:	02000793          	li	a5,32
    4b1c:	40e787b3          	sub	a5,a5,a4
    4b20:	00f957b3          	srl	a5,s2,a5
    4b24:	00e41633          	sll	a2,s0,a4
    4b28:	00c7e7b3          	or	a5,a5,a2
    4b2c:	00e91933          	sll	s2,s2,a4
    4b30:	30974c63          	blt	a4,s1,4e48 <__adddf3+0x418>
    4b34:	40970533          	sub	a0,a4,s1
    4b38:	00150613          	addi	a2,a0,1
    4b3c:	01f00713          	li	a4,31
    4b40:	44c74663          	blt	a4,a2,4f8c <__adddf3+0x55c>
    4b44:	02000713          	li	a4,32
    4b48:	40c70733          	sub	a4,a4,a2
    4b4c:	00c956b3          	srl	a3,s2,a2
    4b50:	00e91933          	sll	s2,s2,a4
    4b54:	00e79733          	sll	a4,a5,a4
    4b58:	00d76733          	or	a4,a4,a3
    4b5c:	01203933          	snez	s2,s2
    4b60:	01276933          	or	s2,a4,s2
    4b64:	00c7d633          	srl	a2,a5,a2
    4b68:	00000493          	li	s1,0
    4b6c:	00797793          	andi	a5,s2,7
    4b70:	02078063          	beqz	a5,4b90 <__adddf3+0x160>
    4b74:	00f97713          	andi	a4,s2,15
    4b78:	00400793          	li	a5,4
    4b7c:	00f70a63          	beq	a4,a5,4b90 <__adddf3+0x160>
    4b80:	00490713          	addi	a4,s2,4
    4b84:	01273933          	sltu	s2,a4,s2
    4b88:	01260633          	add	a2,a2,s2
    4b8c:	00070913          	mv	s2,a4
    4b90:	00861793          	slli	a5,a2,0x8
    4b94:	2007d863          	bgez	a5,4da4 <__adddf3+0x374>
    4b98:	00148513          	addi	a0,s1,1 # 80000001 <__freertos_irq_stack_top+0x7fdf9c31>
    4b9c:	7ff00793          	li	a5,2047
    4ba0:	00098593          	mv	a1,s3
    4ba4:	24f50c63          	beq	a0,a5,4dfc <__adddf3+0x3cc>
    4ba8:	ff8007b7          	lui	a5,0xff800
    4bac:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    4bb0:	00f677b3          	and	a5,a2,a5
    4bb4:	01d79893          	slli	a7,a5,0x1d
    4bb8:	00395913          	srli	s2,s2,0x3
    4bbc:	00979793          	slli	a5,a5,0x9
    4bc0:	0128e8b3          	or	a7,a7,s2
    4bc4:	00c7d793          	srli	a5,a5,0xc
    4bc8:	7ff57513          	andi	a0,a0,2047
    4bcc:	00c79693          	slli	a3,a5,0xc
    4bd0:	01451513          	slli	a0,a0,0x14
    4bd4:	01c12083          	lw	ra,28(sp)
    4bd8:	01812403          	lw	s0,24(sp)
    4bdc:	00c6d693          	srli	a3,a3,0xc
    4be0:	01f59593          	slli	a1,a1,0x1f
    4be4:	00a6e6b3          	or	a3,a3,a0
    4be8:	00b6e6b3          	or	a3,a3,a1
    4bec:	01412483          	lw	s1,20(sp)
    4bf0:	01012903          	lw	s2,16(sp)
    4bf4:	00c12983          	lw	s3,12(sp)
    4bf8:	00088513          	mv	a0,a7
    4bfc:	00068593          	mv	a1,a3
    4c00:	02010113          	addi	sp,sp,32
    4c04:	00008067          	ret
    4c08:	0c0e1463          	bnez	t3,4cd0 <__adddf3+0x2a0>
    4c0c:	00148313          	addi	t1,s1,1
    4c10:	7fe37313          	andi	t1,t1,2046
    4c14:	28031063          	bnez	t1,4e94 <__adddf3+0x464>
    4c18:	01e767b3          	or	a5,a4,t5
    4c1c:	01f868b3          	or	a7,a6,t6
    4c20:	1e049663          	bnez	s1,4e0c <__adddf3+0x3dc>
    4c24:	4c078063          	beqz	a5,50e4 <__adddf3+0x6b4>
    4c28:	50088863          	beqz	a7,5138 <__adddf3+0x708>
    4c2c:	41ff0933          	sub	s2,t5,t6
    4c30:	410707b3          	sub	a5,a4,a6
    4c34:	012f3633          	sltu	a2,t5,s2
    4c38:	40c78633          	sub	a2,a5,a2
    4c3c:	00861793          	slli	a5,a2,0x8
    4c40:	5a07d463          	bgez	a5,51e8 <__adddf3+0x7b8>
    4c44:	41ef8933          	sub	s2,t6,t5
    4c48:	40e807b3          	sub	a5,a6,a4
    4c4c:	012fb633          	sltu	a2,t6,s2
    4c50:	40c78633          	sub	a2,a5,a2
    4c54:	000e8993          	mv	s3,t4
    4c58:	f15ff06f          	j	4b6c <__adddf3+0x13c>
    4c5c:	0fc05a63          	blez	t3,4d50 <__adddf3+0x320>
    4c60:	0c030863          	beqz	t1,4d30 <__adddf3+0x300>
    4c64:	008006b7          	lui	a3,0x800
    4c68:	7ff00793          	li	a5,2047
    4c6c:	00d86833          	or	a6,a6,a3
    4c70:	44f48e63          	beq	s1,a5,50cc <__adddf3+0x69c>
    4c74:	03800793          	li	a5,56
    4c78:	15c7cc63          	blt	a5,t3,4dd0 <__adddf3+0x3a0>
    4c7c:	01f00793          	li	a5,31
    4c80:	3fc7da63          	bge	a5,t3,5074 <__adddf3+0x644>
    4c84:	fe0e0913          	addi	s2,t3,-32 # 3ffe0 <__global_pointer$+0x39448>
    4c88:	02000793          	li	a5,32
    4c8c:	012856b3          	srl	a3,a6,s2
    4c90:	00fe0a63          	beq	t3,a5,4ca4 <__adddf3+0x274>
    4c94:	04000913          	li	s2,64
    4c98:	41c90933          	sub	s2,s2,t3
    4c9c:	01281933          	sll	s2,a6,s2
    4ca0:	012fefb3          	or	t6,t6,s2
    4ca4:	01f03933          	snez	s2,t6
    4ca8:	00d96933          	or	s2,s2,a3
    4cac:	12c0006f          	j	4dd8 <__adddf3+0x3a8>
    4cb0:	01f867b3          	or	a5,a6,t6
    4cb4:	22078663          	beqz	a5,4ee0 <__adddf3+0x4b0>
    4cb8:	fffe0793          	addi	a5,t3,-1
    4cbc:	44078463          	beqz	a5,5104 <__adddf3+0x6d4>
    4cc0:	7ff00693          	li	a3,2047
    4cc4:	20de0263          	beq	t3,a3,4ec8 <__adddf3+0x498>
    4cc8:	00078e13          	mv	t3,a5
    4ccc:	de5ff06f          	j	4ab0 <__adddf3+0x80>
    4cd0:	409305b3          	sub	a1,t1,s1
    4cd4:	28049663          	bnez	s1,4f60 <__adddf3+0x530>
    4cd8:	01e767b3          	or	a5,a4,t5
    4cdc:	3c078263          	beqz	a5,50a0 <__adddf3+0x670>
    4ce0:	fff58793          	addi	a5,a1,-1
    4ce4:	50078c63          	beqz	a5,51fc <__adddf3+0x7cc>
    4ce8:	7ff00693          	li	a3,2047
    4cec:	28d58263          	beq	a1,a3,4f70 <__adddf3+0x540>
    4cf0:	00078593          	mv	a1,a5
    4cf4:	03800793          	li	a5,56
    4cf8:	32b7ce63          	blt	a5,a1,5034 <__adddf3+0x604>
    4cfc:	01f00793          	li	a5,31
    4d00:	4ab7c263          	blt	a5,a1,51a4 <__adddf3+0x774>
    4d04:	02000793          	li	a5,32
    4d08:	40b787b3          	sub	a5,a5,a1
    4d0c:	00f71933          	sll	s2,a4,a5
    4d10:	00bf56b3          	srl	a3,t5,a1
    4d14:	00ff17b3          	sll	a5,t5,a5
    4d18:	00d96933          	or	s2,s2,a3
    4d1c:	00f037b3          	snez	a5,a5
    4d20:	00b75733          	srl	a4,a4,a1
    4d24:	00f96933          	or	s2,s2,a5
    4d28:	40e80833          	sub	a6,a6,a4
    4d2c:	3100006f          	j	503c <__adddf3+0x60c>
    4d30:	01f867b3          	or	a5,a6,t6
    4d34:	3e078463          	beqz	a5,511c <__adddf3+0x6ec>
    4d38:	fffe0793          	addi	a5,t3,-1
    4d3c:	28078263          	beqz	a5,4fc0 <__adddf3+0x590>
    4d40:	7ff00693          	li	a3,2047
    4d44:	38de0463          	beq	t3,a3,50cc <__adddf3+0x69c>
    4d48:	00078e13          	mv	t3,a5
    4d4c:	f29ff06f          	j	4c74 <__adddf3+0x244>
    4d50:	1a0e1663          	bnez	t3,4efc <__adddf3+0x4cc>
    4d54:	00148693          	addi	a3,s1,1
    4d58:	7fe6f793          	andi	a5,a3,2046
    4d5c:	3e079a63          	bnez	a5,5150 <__adddf3+0x720>
    4d60:	01e767b3          	or	a5,a4,t5
    4d64:	34049e63          	bnez	s1,50c0 <__adddf3+0x690>
    4d68:	4a078863          	beqz	a5,5218 <__adddf3+0x7e8>
    4d6c:	01f867b3          	or	a5,a6,t6
    4d70:	3c078463          	beqz	a5,5138 <__adddf3+0x708>
    4d74:	01ff0933          	add	s2,t5,t6
    4d78:	010707b3          	add	a5,a4,a6
    4d7c:	01e93f33          	sltu	t5,s2,t5
    4d80:	01e78633          	add	a2,a5,t5
    4d84:	00861793          	slli	a5,a2,0x8
    4d88:	0007da63          	bgez	a5,4d9c <__adddf3+0x36c>
    4d8c:	ff8007b7          	lui	a5,0xff800
    4d90:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    4d94:	00f67633          	and	a2,a2,a5
    4d98:	00100493          	li	s1,1
    4d9c:	00797793          	andi	a5,s2,7
    4da0:	dc079ae3          	bnez	a5,4b74 <__adddf3+0x144>
    4da4:	01d61793          	slli	a5,a2,0x1d
    4da8:	00395893          	srli	a7,s2,0x3
    4dac:	00f8e8b3          	or	a7,a7,a5
    4db0:	00365793          	srli	a5,a2,0x3
    4db4:	7ff00713          	li	a4,2047
    4db8:	06e48a63          	beq	s1,a4,4e2c <__adddf3+0x3fc>
    4dbc:	00c79793          	slli	a5,a5,0xc
    4dc0:	00c7d793          	srli	a5,a5,0xc
    4dc4:	7ff4f513          	andi	a0,s1,2047
    4dc8:	00098593          	mv	a1,s3
    4dcc:	e01ff06f          	j	4bcc <__adddf3+0x19c>
    4dd0:	01f86933          	or	s2,a6,t6
    4dd4:	01203933          	snez	s2,s2
    4dd8:	01e90933          	add	s2,s2,t5
    4ddc:	01e937b3          	sltu	a5,s2,t5
    4de0:	00e78633          	add	a2,a5,a4
    4de4:	00861793          	slli	a5,a2,0x8
    4de8:	fa07dae3          	bgez	a5,4d9c <__adddf3+0x36c>
    4dec:	00148493          	addi	s1,s1,1
    4df0:	7ff00793          	li	a5,2047
    4df4:	1ef49663          	bne	s1,a5,4fe0 <__adddf3+0x5b0>
    4df8:	00098593          	mv	a1,s3
    4dfc:	7ff00513          	li	a0,2047
    4e00:	00000793          	li	a5,0
    4e04:	00000893          	li	a7,0
    4e08:	dc5ff06f          	j	4bcc <__adddf3+0x19c>
    4e0c:	0a079c63          	bnez	a5,4ec4 <__adddf3+0x494>
    4e10:	46088463          	beqz	a7,5278 <__adddf3+0x848>
    4e14:	00361693          	slli	a3,a2,0x3
    4e18:	01d81793          	slli	a5,a6,0x1d
    4e1c:	0036d693          	srli	a3,a3,0x3
    4e20:	00d7e8b3          	or	a7,a5,a3
    4e24:	000e8993          	mv	s3,t4
    4e28:	00385793          	srli	a5,a6,0x3
    4e2c:	00f8e7b3          	or	a5,a7,a5
    4e30:	fc0784e3          	beqz	a5,4df8 <__adddf3+0x3c8>
    4e34:	00000593          	li	a1,0
    4e38:	7ff00513          	li	a0,2047
    4e3c:	000807b7          	lui	a5,0x80
    4e40:	00000893          	li	a7,0
    4e44:	d89ff06f          	j	4bcc <__adddf3+0x19c>
    4e48:	ff800637          	lui	a2,0xff800
    4e4c:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    4e50:	00c7f633          	and	a2,a5,a2
    4e54:	00797793          	andi	a5,s2,7
    4e58:	40e484b3          	sub	s1,s1,a4
    4e5c:	d0079ce3          	bnez	a5,4b74 <__adddf3+0x144>
    4e60:	f45ff06f          	j	4da4 <__adddf3+0x374>
    4e64:	00090513          	mv	a0,s2
    4e68:	a24fe0ef          	jal	ra,308c <__clzsi2>
    4e6c:	01850713          	addi	a4,a0,24
    4e70:	01f00793          	li	a5,31
    4e74:	cae7d2e3          	bge	a5,a4,4b18 <__adddf3+0xe8>
    4e78:	ff850613          	addi	a2,a0,-8
    4e7c:	00c917b3          	sll	a5,s2,a2
    4e80:	00000913          	li	s2,0
    4e84:	cadff06f          	j	4b30 <__adddf3+0x100>
    4e88:	01f86933          	or	s2,a6,t6
    4e8c:	01203933          	snez	s2,s2
    4e90:	c59ff06f          	j	4ae8 <__adddf3+0xb8>
    4e94:	41ff0933          	sub	s2,t5,t6
    4e98:	41070633          	sub	a2,a4,a6
    4e9c:	012f3433          	sltu	s0,t5,s2
    4ea0:	40860433          	sub	s0,a2,s0
    4ea4:	00841793          	slli	a5,s0,0x8
    4ea8:	2c07cc63          	bltz	a5,5180 <__adddf3+0x750>
    4eac:	008968b3          	or	a7,s2,s0
    4eb0:	c4089ce3          	bnez	a7,4b08 <__adddf3+0xd8>
    4eb4:	00000793          	li	a5,0
    4eb8:	00000993          	li	s3,0
    4ebc:	00000493          	li	s1,0
    4ec0:	efdff06f          	j	4dbc <__adddf3+0x38c>
    4ec4:	f60898e3          	bnez	a7,4e34 <__adddf3+0x404>
    4ec8:	00351513          	slli	a0,a0,0x3
    4ecc:	01d71793          	slli	a5,a4,0x1d
    4ed0:	00355513          	srli	a0,a0,0x3
    4ed4:	00a7e8b3          	or	a7,a5,a0
    4ed8:	00375793          	srli	a5,a4,0x3
    4edc:	f51ff06f          	j	4e2c <__adddf3+0x3fc>
    4ee0:	00351513          	slli	a0,a0,0x3
    4ee4:	01d71793          	slli	a5,a4,0x1d
    4ee8:	00355513          	srli	a0,a0,0x3
    4eec:	00a7e8b3          	or	a7,a5,a0
    4ef0:	000e0493          	mv	s1,t3
    4ef4:	00375793          	srli	a5,a4,0x3
    4ef8:	ebdff06f          	j	4db4 <__adddf3+0x384>
    4efc:	40930533          	sub	a0,t1,s1
    4f00:	14048a63          	beqz	s1,5054 <__adddf3+0x624>
    4f04:	008006b7          	lui	a3,0x800
    4f08:	7ff00793          	li	a5,2047
    4f0c:	00d76733          	or	a4,a4,a3
    4f10:	38f30663          	beq	t1,a5,529c <__adddf3+0x86c>
    4f14:	03800793          	li	a5,56
    4f18:	28a7c063          	blt	a5,a0,5198 <__adddf3+0x768>
    4f1c:	01f00793          	li	a5,31
    4f20:	32a7c663          	blt	a5,a0,524c <__adddf3+0x81c>
    4f24:	02000793          	li	a5,32
    4f28:	40a787b3          	sub	a5,a5,a0
    4f2c:	00f71933          	sll	s2,a4,a5
    4f30:	00af56b3          	srl	a3,t5,a0
    4f34:	00ff17b3          	sll	a5,t5,a5
    4f38:	00d96933          	or	s2,s2,a3
    4f3c:	00f037b3          	snez	a5,a5
    4f40:	00a75733          	srl	a4,a4,a0
    4f44:	00f96933          	or	s2,s2,a5
    4f48:	00e80833          	add	a6,a6,a4
    4f4c:	01f90933          	add	s2,s2,t6
    4f50:	01f937b3          	sltu	a5,s2,t6
    4f54:	01078633          	add	a2,a5,a6
    4f58:	00030493          	mv	s1,t1
    4f5c:	e89ff06f          	j	4de4 <__adddf3+0x3b4>
    4f60:	008006b7          	lui	a3,0x800
    4f64:	7ff00793          	li	a5,2047
    4f68:	00d76733          	or	a4,a4,a3
    4f6c:	d8f314e3          	bne	t1,a5,4cf4 <__adddf3+0x2c4>
    4f70:	00361793          	slli	a5,a2,0x3
    4f74:	0037d793          	srli	a5,a5,0x3
    4f78:	01d81893          	slli	a7,a6,0x1d
    4f7c:	0117e8b3          	or	a7,a5,a7
    4f80:	000e8993          	mv	s3,t4
    4f84:	00385793          	srli	a5,a6,0x3
    4f88:	ea5ff06f          	j	4e2c <__adddf3+0x3fc>
    4f8c:	fe150713          	addi	a4,a0,-31
    4f90:	02000693          	li	a3,32
    4f94:	00e7d733          	srl	a4,a5,a4
    4f98:	00d60a63          	beq	a2,a3,4fac <__adddf3+0x57c>
    4f9c:	04000693          	li	a3,64
    4fa0:	40c68633          	sub	a2,a3,a2
    4fa4:	00c79633          	sll	a2,a5,a2
    4fa8:	00c96933          	or	s2,s2,a2
    4fac:	01203933          	snez	s2,s2
    4fb0:	00e96933          	or	s2,s2,a4
    4fb4:	00000613          	li	a2,0
    4fb8:	00000493          	li	s1,0
    4fbc:	de1ff06f          	j	4d9c <__adddf3+0x36c>
    4fc0:	01ff0933          	add	s2,t5,t6
    4fc4:	010707b3          	add	a5,a4,a6
    4fc8:	01e93633          	sltu	a2,s2,t5
    4fcc:	00c78633          	add	a2,a5,a2
    4fd0:	00861793          	slli	a5,a2,0x8
    4fd4:	00100493          	li	s1,1
    4fd8:	dc07d2e3          	bgez	a5,4d9c <__adddf3+0x36c>
    4fdc:	00200493          	li	s1,2
    4fe0:	ff8007b7          	lui	a5,0xff800
    4fe4:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9c2f>
    4fe8:	00f677b3          	and	a5,a2,a5
    4fec:	00195713          	srli	a4,s2,0x1
    4ff0:	00197913          	andi	s2,s2,1
    4ff4:	01276933          	or	s2,a4,s2
    4ff8:	01f79893          	slli	a7,a5,0x1f
    4ffc:	0128e933          	or	s2,a7,s2
    5000:	0017d613          	srli	a2,a5,0x1
    5004:	b69ff06f          	j	4b6c <__adddf3+0x13c>
    5008:	fe0e0913          	addi	s2,t3,-32
    500c:	02000793          	li	a5,32
    5010:	012856b3          	srl	a3,a6,s2
    5014:	00fe0a63          	beq	t3,a5,5028 <__adddf3+0x5f8>
    5018:	04000913          	li	s2,64
    501c:	41c90933          	sub	s2,s2,t3
    5020:	01281933          	sll	s2,a6,s2
    5024:	012fefb3          	or	t6,t6,s2
    5028:	01f03933          	snez	s2,t6
    502c:	00d96933          	or	s2,s2,a3
    5030:	ab9ff06f          	j	4ae8 <__adddf3+0xb8>
    5034:	01e76933          	or	s2,a4,t5
    5038:	01203933          	snez	s2,s2
    503c:	412f8933          	sub	s2,t6,s2
    5040:	012fb7b3          	sltu	a5,t6,s2
    5044:	40f80633          	sub	a2,a6,a5
    5048:	00030493          	mv	s1,t1
    504c:	000e8993          	mv	s3,t4
    5050:	aa5ff06f          	j	4af4 <__adddf3+0xc4>
    5054:	01e767b3          	or	a5,a4,t5
    5058:	1c078c63          	beqz	a5,5230 <__adddf3+0x800>
    505c:	fff50793          	addi	a5,a0,-1
    5060:	22078463          	beqz	a5,5288 <__adddf3+0x858>
    5064:	7ff00693          	li	a3,2047
    5068:	16d50463          	beq	a0,a3,51d0 <__adddf3+0x7a0>
    506c:	00078513          	mv	a0,a5
    5070:	ea5ff06f          	j	4f14 <__adddf3+0x4e4>
    5074:	02000793          	li	a5,32
    5078:	41c787b3          	sub	a5,a5,t3
    507c:	00f816b3          	sll	a3,a6,a5
    5080:	00ff9933          	sll	s2,t6,a5
    5084:	01cfd633          	srl	a2,t6,t3
    5088:	00c6e6b3          	or	a3,a3,a2
    508c:	01203933          	snez	s2,s2
    5090:	01c857b3          	srl	a5,a6,t3
    5094:	0126e933          	or	s2,a3,s2
    5098:	00f70733          	add	a4,a4,a5
    509c:	d3dff06f          	j	4dd8 <__adddf3+0x3a8>
    50a0:	00361793          	slli	a5,a2,0x3
    50a4:	0037d793          	srli	a5,a5,0x3
    50a8:	01d81893          	slli	a7,a6,0x1d
    50ac:	0117e8b3          	or	a7,a5,a7
    50b0:	00058493          	mv	s1,a1
    50b4:	00385793          	srli	a5,a6,0x3
    50b8:	000e8993          	mv	s3,t4
    50bc:	cf9ff06f          	j	4db4 <__adddf3+0x384>
    50c0:	10078863          	beqz	a5,51d0 <__adddf3+0x7a0>
    50c4:	01f86933          	or	s2,a6,t6
    50c8:	d60916e3          	bnez	s2,4e34 <__adddf3+0x404>
    50cc:	00351513          	slli	a0,a0,0x3
    50d0:	01d71793          	slli	a5,a4,0x1d
    50d4:	00355513          	srli	a0,a0,0x3
    50d8:	00f568b3          	or	a7,a0,a5
    50dc:	00375793          	srli	a5,a4,0x3
    50e0:	d4dff06f          	j	4e2c <__adddf3+0x3fc>
    50e4:	10088663          	beqz	a7,51f0 <__adddf3+0x7c0>
    50e8:	00361693          	slli	a3,a2,0x3
    50ec:	01d81793          	slli	a5,a6,0x1d
    50f0:	0036d693          	srli	a3,a3,0x3
    50f4:	00d7e8b3          	or	a7,a5,a3
    50f8:	000e8993          	mv	s3,t4
    50fc:	00385793          	srli	a5,a6,0x3
    5100:	cbdff06f          	j	4dbc <__adddf3+0x38c>
    5104:	41ff0933          	sub	s2,t5,t6
    5108:	410707b3          	sub	a5,a4,a6
    510c:	012f3f33          	sltu	t5,t5,s2
    5110:	41e78633          	sub	a2,a5,t5
    5114:	00100493          	li	s1,1
    5118:	9ddff06f          	j	4af4 <__adddf3+0xc4>
    511c:	00351513          	slli	a0,a0,0x3
    5120:	01d71793          	slli	a5,a4,0x1d
    5124:	00355513          	srli	a0,a0,0x3
    5128:	00f568b3          	or	a7,a0,a5
    512c:	000e0493          	mv	s1,t3
    5130:	00375793          	srli	a5,a4,0x3
    5134:	c81ff06f          	j	4db4 <__adddf3+0x384>
    5138:	00351513          	slli	a0,a0,0x3
    513c:	01d71793          	slli	a5,a4,0x1d
    5140:	00355513          	srli	a0,a0,0x3
    5144:	00a7e8b3          	or	a7,a5,a0
    5148:	00375793          	srli	a5,a4,0x3
    514c:	c71ff06f          	j	4dbc <__adddf3+0x38c>
    5150:	7ff00793          	li	a5,2047
    5154:	caf682e3          	beq	a3,a5,4df8 <__adddf3+0x3c8>
    5158:	01ff0933          	add	s2,t5,t6
    515c:	01e93633          	sltu	a2,s2,t5
    5160:	010707b3          	add	a5,a4,a6
    5164:	00c787b3          	add	a5,a5,a2
    5168:	01f79893          	slli	a7,a5,0x1f
    516c:	00195913          	srli	s2,s2,0x1
    5170:	0128e933          	or	s2,a7,s2
    5174:	0017d613          	srli	a2,a5,0x1
    5178:	00068493          	mv	s1,a3
    517c:	c21ff06f          	j	4d9c <__adddf3+0x36c>
    5180:	41ef8933          	sub	s2,t6,t5
    5184:	40e80733          	sub	a4,a6,a4
    5188:	012fb633          	sltu	a2,t6,s2
    518c:	40c70433          	sub	s0,a4,a2
    5190:	000e8993          	mv	s3,t4
    5194:	975ff06f          	j	4b08 <__adddf3+0xd8>
    5198:	01e76933          	or	s2,a4,t5
    519c:	01203933          	snez	s2,s2
    51a0:	dadff06f          	j	4f4c <__adddf3+0x51c>
    51a4:	fe058793          	addi	a5,a1,-32
    51a8:	02000693          	li	a3,32
    51ac:	00f757b3          	srl	a5,a4,a5
    51b0:	00d58a63          	beq	a1,a3,51c4 <__adddf3+0x794>
    51b4:	04000693          	li	a3,64
    51b8:	40b685b3          	sub	a1,a3,a1
    51bc:	00b71733          	sll	a4,a4,a1
    51c0:	00ef6f33          	or	t5,t5,a4
    51c4:	01e03933          	snez	s2,t5
    51c8:	00f96933          	or	s2,s2,a5
    51cc:	e71ff06f          	j	503c <__adddf3+0x60c>
    51d0:	00361793          	slli	a5,a2,0x3
    51d4:	0037d793          	srli	a5,a5,0x3
    51d8:	01d81893          	slli	a7,a6,0x1d
    51dc:	0117e8b3          	or	a7,a5,a7
    51e0:	00385793          	srli	a5,a6,0x3
    51e4:	c49ff06f          	j	4e2c <__adddf3+0x3fc>
    51e8:	00c968b3          	or	a7,s2,a2
    51ec:	ba0898e3          	bnez	a7,4d9c <__adddf3+0x36c>
    51f0:	00000793          	li	a5,0
    51f4:	00000993          	li	s3,0
    51f8:	bc5ff06f          	j	4dbc <__adddf3+0x38c>
    51fc:	41ef8933          	sub	s2,t6,t5
    5200:	40e807b3          	sub	a5,a6,a4
    5204:	012fb633          	sltu	a2,t6,s2
    5208:	40c78633          	sub	a2,a5,a2
    520c:	000e8993          	mv	s3,t4
    5210:	00100493          	li	s1,1
    5214:	8e1ff06f          	j	4af4 <__adddf3+0xc4>
    5218:	00361693          	slli	a3,a2,0x3
    521c:	01d81793          	slli	a5,a6,0x1d
    5220:	0036d693          	srli	a3,a3,0x3
    5224:	00d7e8b3          	or	a7,a5,a3
    5228:	00385793          	srli	a5,a6,0x3
    522c:	b91ff06f          	j	4dbc <__adddf3+0x38c>
    5230:	00361693          	slli	a3,a2,0x3
    5234:	01d81793          	slli	a5,a6,0x1d
    5238:	0036d693          	srli	a3,a3,0x3
    523c:	00d7e8b3          	or	a7,a5,a3
    5240:	00050493          	mv	s1,a0
    5244:	00385793          	srli	a5,a6,0x3
    5248:	b6dff06f          	j	4db4 <__adddf3+0x384>
    524c:	fe050793          	addi	a5,a0,-32
    5250:	02000693          	li	a3,32
    5254:	00f757b3          	srl	a5,a4,a5
    5258:	00d50a63          	beq	a0,a3,526c <__adddf3+0x83c>
    525c:	04000693          	li	a3,64
    5260:	40a68533          	sub	a0,a3,a0
    5264:	00a71733          	sll	a4,a4,a0
    5268:	00ef6f33          	or	t5,t5,a4
    526c:	01e03933          	snez	s2,t5
    5270:	00f96933          	or	s2,s2,a5
    5274:	cd9ff06f          	j	4f4c <__adddf3+0x51c>
    5278:	00000593          	li	a1,0
    527c:	7ff00513          	li	a0,2047
    5280:	000807b7          	lui	a5,0x80
    5284:	949ff06f          	j	4bcc <__adddf3+0x19c>
    5288:	01ff0933          	add	s2,t5,t6
    528c:	010707b3          	add	a5,a4,a6
    5290:	01f93633          	sltu	a2,s2,t6
    5294:	00c78633          	add	a2,a5,a2
    5298:	d39ff06f          	j	4fd0 <__adddf3+0x5a0>
    529c:	00361693          	slli	a3,a2,0x3
    52a0:	01d81793          	slli	a5,a6,0x1d
    52a4:	0036d693          	srli	a3,a3,0x3
    52a8:	00d7e8b3          	or	a7,a5,a3
    52ac:	00385793          	srli	a5,a6,0x3
    52b0:	b7dff06f          	j	4e2c <__adddf3+0x3fc>

000052b4 <__divdf3>:
    52b4:	fc010113          	addi	sp,sp,-64
    52b8:	0145d793          	srli	a5,a1,0x14
    52bc:	02812c23          	sw	s0,56(sp)
    52c0:	02912a23          	sw	s1,52(sp)
    52c4:	03312623          	sw	s3,44(sp)
    52c8:	00050493          	mv	s1,a0
    52cc:	00c59413          	slli	s0,a1,0xc
    52d0:	02112e23          	sw	ra,60(sp)
    52d4:	03212823          	sw	s2,48(sp)
    52d8:	03412423          	sw	s4,40(sp)
    52dc:	03512223          	sw	s5,36(sp)
    52e0:	03612023          	sw	s6,32(sp)
    52e4:	01712e23          	sw	s7,28(sp)
    52e8:	7ff7f513          	andi	a0,a5,2047
    52ec:	00c45413          	srli	s0,s0,0xc
    52f0:	01f5d993          	srli	s3,a1,0x1f
    52f4:	16050863          	beqz	a0,5464 <__divdf3+0x1b0>
    52f8:	7ff00793          	li	a5,2047
    52fc:	1cf50263          	beq	a0,a5,54c0 <__divdf3+0x20c>
    5300:	01d4da93          	srli	s5,s1,0x1d
    5304:	00341413          	slli	s0,s0,0x3
    5308:	008ae433          	or	s0,s5,s0
    530c:	00800ab7          	lui	s5,0x800
    5310:	00349b13          	slli	s6,s1,0x3
    5314:	01546ab3          	or	s5,s0,s5
    5318:	c0150913          	addi	s2,a0,-1023
    531c:	00000493          	li	s1,0
    5320:	00000b93          	li	s7,0
    5324:	0146d713          	srli	a4,a3,0x14
    5328:	00c69413          	slli	s0,a3,0xc
    532c:	7ff77713          	andi	a4,a4,2047
    5330:	00c45413          	srli	s0,s0,0xc
    5334:	01f6da13          	srli	s4,a3,0x1f
    5338:	0e070063          	beqz	a4,5418 <__divdf3+0x164>
    533c:	7ff00793          	li	a5,2047
    5340:	04f70863          	beq	a4,a5,5390 <__divdf3+0xdc>
    5344:	00341793          	slli	a5,s0,0x3
    5348:	01d65413          	srli	s0,a2,0x1d
    534c:	00f467b3          	or	a5,s0,a5
    5350:	c0170713          	addi	a4,a4,-1023
    5354:	00800437          	lui	s0,0x800
    5358:	0087e433          	or	s0,a5,s0
    535c:	00361813          	slli	a6,a2,0x3
    5360:	40e90933          	sub	s2,s2,a4
    5364:	00000693          	li	a3,0
    5368:	00f00793          	li	a5,15
    536c:	0149c5b3          	xor	a1,s3,s4
    5370:	2497ec63          	bltu	a5,s1,55c8 <__divdf3+0x314>
    5374:	00001717          	auipc	a4,0x1
    5378:	bcc70713          	addi	a4,a4,-1076 # 5f40 <TWO52+0x30>
    537c:	00249493          	slli	s1,s1,0x2
    5380:	00e484b3          	add	s1,s1,a4
    5384:	0004a783          	lw	a5,0(s1)
    5388:	00e787b3          	add	a5,a5,a4
    538c:	00078067          	jr	a5 # 80000 <__global_pointer$+0x79468>
    5390:	00c46833          	or	a6,s0,a2
    5394:	80190913          	addi	s2,s2,-2047
    5398:	18081063          	bnez	a6,5518 <__divdf3+0x264>
    539c:	0024e493          	ori	s1,s1,2
    53a0:	00000413          	li	s0,0
    53a4:	00200693          	li	a3,2
    53a8:	fc1ff06f          	j	5368 <__divdf3+0xb4>
    53ac:	7ff00713          	li	a4,2047
    53b0:	00000793          	li	a5,0
    53b4:	00000413          	li	s0,0
    53b8:	00c79793          	slli	a5,a5,0xc
    53bc:	00040513          	mv	a0,s0
    53c0:	03c12083          	lw	ra,60(sp)
    53c4:	03812403          	lw	s0,56(sp)
    53c8:	01471713          	slli	a4,a4,0x14
    53cc:	00c7d793          	srli	a5,a5,0xc
    53d0:	01f59593          	slli	a1,a1,0x1f
    53d4:	00e7e7b3          	or	a5,a5,a4
    53d8:	00b7e7b3          	or	a5,a5,a1
    53dc:	03412483          	lw	s1,52(sp)
    53e0:	03012903          	lw	s2,48(sp)
    53e4:	02c12983          	lw	s3,44(sp)
    53e8:	02812a03          	lw	s4,40(sp)
    53ec:	02412a83          	lw	s5,36(sp)
    53f0:	02012b03          	lw	s6,32(sp)
    53f4:	01c12b83          	lw	s7,28(sp)
    53f8:	00078593          	mv	a1,a5
    53fc:	04010113          	addi	sp,sp,64
    5400:	00008067          	ret
    5404:	00000593          	li	a1,0
    5408:	7ff00713          	li	a4,2047
    540c:	000807b7          	lui	a5,0x80
    5410:	00000413          	li	s0,0
    5414:	fa5ff06f          	j	53b8 <__divdf3+0x104>
    5418:	00c46833          	or	a6,s0,a2
    541c:	0e080663          	beqz	a6,5508 <__divdf3+0x254>
    5420:	3e040a63          	beqz	s0,5814 <__divdf3+0x560>
    5424:	00040513          	mv	a0,s0
    5428:	00c12423          	sw	a2,8(sp)
    542c:	c61fd0ef          	jal	ra,308c <__clzsi2>
    5430:	00812603          	lw	a2,8(sp)
    5434:	ff550593          	addi	a1,a0,-11
    5438:	01d00693          	li	a3,29
    543c:	ff850713          	addi	a4,a0,-8
    5440:	40b686b3          	sub	a3,a3,a1
    5444:	00e417b3          	sll	a5,s0,a4
    5448:	00d656b3          	srl	a3,a2,a3
    544c:	00f6e433          	or	s0,a3,a5
    5450:	00e61833          	sll	a6,a2,a4
    5454:	01250533          	add	a0,a0,s2
    5458:	3f350913          	addi	s2,a0,1011
    545c:	00000693          	li	a3,0
    5460:	f09ff06f          	j	5368 <__divdf3+0xb4>
    5464:	00946ab3          	or	s5,s0,s1
    5468:	080a8663          	beqz	s5,54f4 <__divdf3+0x240>
    546c:	00d12623          	sw	a3,12(sp)
    5470:	00c12423          	sw	a2,8(sp)
    5474:	36040863          	beqz	s0,57e4 <__divdf3+0x530>
    5478:	00040513          	mv	a0,s0
    547c:	c11fd0ef          	jal	ra,308c <__clzsi2>
    5480:	00812603          	lw	a2,8(sp)
    5484:	00c12683          	lw	a3,12(sp)
    5488:	00050913          	mv	s2,a0
    548c:	ff550713          	addi	a4,a0,-11
    5490:	01d00a93          	li	s5,29
    5494:	ff890b13          	addi	s6,s2,-8
    5498:	40ea8ab3          	sub	s5,s5,a4
    549c:	01641433          	sll	s0,s0,s6
    54a0:	0154dab3          	srl	s5,s1,s5
    54a4:	008aeab3          	or	s5,s5,s0
    54a8:	01649b33          	sll	s6,s1,s6
    54ac:	c0d00513          	li	a0,-1011
    54b0:	41250933          	sub	s2,a0,s2
    54b4:	00000493          	li	s1,0
    54b8:	00000b93          	li	s7,0
    54bc:	e69ff06f          	j	5324 <__divdf3+0x70>
    54c0:	00946ab3          	or	s5,s0,s1
    54c4:	000a9c63          	bnez	s5,54dc <__divdf3+0x228>
    54c8:	00000b13          	li	s6,0
    54cc:	00800493          	li	s1,8
    54d0:	7ff00913          	li	s2,2047
    54d4:	00200b93          	li	s7,2
    54d8:	e4dff06f          	j	5324 <__divdf3+0x70>
    54dc:	00048b13          	mv	s6,s1
    54e0:	00040a93          	mv	s5,s0
    54e4:	00c00493          	li	s1,12
    54e8:	7ff00913          	li	s2,2047
    54ec:	00300b93          	li	s7,3
    54f0:	e35ff06f          	j	5324 <__divdf3+0x70>
    54f4:	00000b13          	li	s6,0
    54f8:	00400493          	li	s1,4
    54fc:	00000913          	li	s2,0
    5500:	00100b93          	li	s7,1
    5504:	e21ff06f          	j	5324 <__divdf3+0x70>
    5508:	0014e493          	ori	s1,s1,1
    550c:	00000413          	li	s0,0
    5510:	00100693          	li	a3,1
    5514:	e55ff06f          	j	5368 <__divdf3+0xb4>
    5518:	0034e493          	ori	s1,s1,3
    551c:	00060813          	mv	a6,a2
    5520:	00300693          	li	a3,3
    5524:	e45ff06f          	j	5368 <__divdf3+0xb4>
    5528:	3c070063          	beqz	a4,58e8 <__divdf3+0x634>
    552c:	00100793          	li	a5,1
    5530:	40e787b3          	sub	a5,a5,a4
    5534:	03800693          	li	a3,56
    5538:	42f6d063          	bge	a3,a5,5958 <__divdf3+0x6a4>
    553c:	00000713          	li	a4,0
    5540:	00000793          	li	a5,0
    5544:	00000413          	li	s0,0
    5548:	e71ff06f          	j	53b8 <__divdf3+0x104>
    554c:	000a0593          	mv	a1,s4
    5550:	00200793          	li	a5,2
    5554:	e4f68ce3          	beq	a3,a5,53ac <__divdf3+0xf8>
    5558:	00300793          	li	a5,3
    555c:	eaf684e3          	beq	a3,a5,5404 <__divdf3+0x150>
    5560:	00100793          	li	a5,1
    5564:	fcf68ce3          	beq	a3,a5,553c <__divdf3+0x288>
    5568:	3ff90713          	addi	a4,s2,1023
    556c:	fae05ee3          	blez	a4,5528 <__divdf3+0x274>
    5570:	00787793          	andi	a5,a6,7
    5574:	32079c63          	bnez	a5,58ac <__divdf3+0x5f8>
    5578:	00385813          	srli	a6,a6,0x3
    557c:	00741793          	slli	a5,s0,0x7
    5580:	0007da63          	bgez	a5,5594 <__divdf3+0x2e0>
    5584:	ff0007b7          	lui	a5,0xff000
    5588:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf9c2f>
    558c:	00f47433          	and	s0,s0,a5
    5590:	40090713          	addi	a4,s2,1024
    5594:	7fe00793          	li	a5,2046
    5598:	e0e7cae3          	blt	a5,a4,53ac <__divdf3+0xf8>
    559c:	00941793          	slli	a5,s0,0x9
    55a0:	01d41693          	slli	a3,s0,0x1d
    55a4:	0106e433          	or	s0,a3,a6
    55a8:	00c7d793          	srli	a5,a5,0xc
    55ac:	7ff77713          	andi	a4,a4,2047
    55b0:	e09ff06f          	j	53b8 <__divdf3+0x104>
    55b4:	00098593          	mv	a1,s3
    55b8:	000a8413          	mv	s0,s5
    55bc:	000b0813          	mv	a6,s6
    55c0:	000b8693          	mv	a3,s7
    55c4:	f8dff06f          	j	5550 <__divdf3+0x29c>
    55c8:	2b546863          	bltu	s0,s5,5878 <__divdf3+0x5c4>
    55cc:	2a8a8463          	beq	s5,s0,5874 <__divdf3+0x5c0>
    55d0:	000b0713          	mv	a4,s6
    55d4:	fff90913          	addi	s2,s2,-1
    55d8:	00000b13          	li	s6,0
    55dc:	00841793          	slli	a5,s0,0x8
    55e0:	01885893          	srli	a7,a6,0x18
    55e4:	00f8e8b3          	or	a7,a7,a5
    55e8:	0108de13          	srli	t3,a7,0x10
    55ec:	03cad7b3          	divu	a5,s5,t3
    55f0:	01089e93          	slli	t4,a7,0x10
    55f4:	010ede93          	srli	t4,t4,0x10
    55f8:	01075613          	srli	a2,a4,0x10
    55fc:	00881313          	slli	t1,a6,0x8
    5600:	03cafab3          	remu	s5,s5,t3
    5604:	02fe86b3          	mul	a3,t4,a5
    5608:	010a9a93          	slli	s5,s5,0x10
    560c:	01566633          	or	a2,a2,s5
    5610:	00d67e63          	bgeu	a2,a3,562c <__divdf3+0x378>
    5614:	01160633          	add	a2,a2,a7
    5618:	fff78513          	addi	a0,a5,-1
    561c:	33166a63          	bltu	a2,a7,5950 <__divdf3+0x69c>
    5620:	32d67863          	bgeu	a2,a3,5950 <__divdf3+0x69c>
    5624:	ffe78793          	addi	a5,a5,-2
    5628:	01160633          	add	a2,a2,a7
    562c:	40d60633          	sub	a2,a2,a3
    5630:	03c65433          	divu	s0,a2,t3
    5634:	01071713          	slli	a4,a4,0x10
    5638:	01075713          	srli	a4,a4,0x10
    563c:	03c67633          	remu	a2,a2,t3
    5640:	028e86b3          	mul	a3,t4,s0
    5644:	01061613          	slli	a2,a2,0x10
    5648:	00c76633          	or	a2,a4,a2
    564c:	00d67e63          	bgeu	a2,a3,5668 <__divdf3+0x3b4>
    5650:	01160633          	add	a2,a2,a7
    5654:	fff40713          	addi	a4,s0,-1 # 7fffff <__freertos_irq_stack_top+0x5f9c2f>
    5658:	2f166863          	bltu	a2,a7,5948 <__divdf3+0x694>
    565c:	2ed67663          	bgeu	a2,a3,5948 <__divdf3+0x694>
    5660:	ffe40413          	addi	s0,s0,-2
    5664:	01160633          	add	a2,a2,a7
    5668:	01079793          	slli	a5,a5,0x10
    566c:	000103b7          	lui	t2,0x10
    5670:	0087e433          	or	s0,a5,s0
    5674:	fff38793          	addi	a5,t2,-1 # ffff <__global_pointer$+0x9467>
    5678:	00f47833          	and	a6,s0,a5
    567c:	01045f13          	srli	t5,s0,0x10
    5680:	01035513          	srli	a0,t1,0x10
    5684:	00f377b3          	and	a5,t1,a5
    5688:	02f80fb3          	mul	t6,a6,a5
    568c:	40d60733          	sub	a4,a2,a3
    5690:	02ff02b3          	mul	t0,t5,a5
    5694:	010fd613          	srli	a2,t6,0x10
    5698:	030506b3          	mul	a3,a0,a6
    569c:	005686b3          	add	a3,a3,t0
    56a0:	00d606b3          	add	a3,a2,a3
    56a4:	02af0833          	mul	a6,t5,a0
    56a8:	0056f463          	bgeu	a3,t0,56b0 <__divdf3+0x3fc>
    56ac:	00780833          	add	a6,a6,t2
    56b0:	00010f37          	lui	t5,0x10
    56b4:	ffff0f13          	addi	t5,t5,-1 # ffff <__global_pointer$+0x9467>
    56b8:	0106d613          	srli	a2,a3,0x10
    56bc:	01e6f6b3          	and	a3,a3,t5
    56c0:	01069693          	slli	a3,a3,0x10
    56c4:	01efff33          	and	t5,t6,t5
    56c8:	01060633          	add	a2,a2,a6
    56cc:	01e686b3          	add	a3,a3,t5
    56d0:	16c76e63          	bltu	a4,a2,584c <__divdf3+0x598>
    56d4:	16c70a63          	beq	a4,a2,5848 <__divdf3+0x594>
    56d8:	40db06b3          	sub	a3,s6,a3
    56dc:	40c70733          	sub	a4,a4,a2
    56e0:	00db3b33          	sltu	s6,s6,a3
    56e4:	41670b33          	sub	s6,a4,s6
    56e8:	3ff90713          	addi	a4,s2,1023
    56ec:	1f688263          	beq	a7,s6,58d0 <__divdf3+0x61c>
    56f0:	03cb5833          	divu	a6,s6,t3
    56f4:	0106d613          	srli	a2,a3,0x10
    56f8:	03cb7b33          	remu	s6,s6,t3
    56fc:	030e8f33          	mul	t5,t4,a6
    5700:	010b1b13          	slli	s6,s6,0x10
    5704:	01666b33          	or	s6,a2,s6
    5708:	01eb7e63          	bgeu	s6,t5,5724 <__divdf3+0x470>
    570c:	011b0b33          	add	s6,s6,a7
    5710:	fff80613          	addi	a2,a6,-1
    5714:	2d1b6863          	bltu	s6,a7,59e4 <__divdf3+0x730>
    5718:	2deb7663          	bgeu	s6,t5,59e4 <__divdf3+0x730>
    571c:	ffe80813          	addi	a6,a6,-2
    5720:	011b0b33          	add	s6,s6,a7
    5724:	41eb0b33          	sub	s6,s6,t5
    5728:	03cb5633          	divu	a2,s6,t3
    572c:	01069693          	slli	a3,a3,0x10
    5730:	0106d693          	srli	a3,a3,0x10
    5734:	03cb7b33          	remu	s6,s6,t3
    5738:	02ce8eb3          	mul	t4,t4,a2
    573c:	010b1b13          	slli	s6,s6,0x10
    5740:	0166e6b3          	or	a3,a3,s6
    5744:	01d6fe63          	bgeu	a3,t4,5760 <__divdf3+0x4ac>
    5748:	011686b3          	add	a3,a3,a7
    574c:	fff60e13          	addi	t3,a2,-1
    5750:	2916e663          	bltu	a3,a7,59dc <__divdf3+0x728>
    5754:	29d6f463          	bgeu	a3,t4,59dc <__divdf3+0x728>
    5758:	ffe60613          	addi	a2,a2,-2
    575c:	011686b3          	add	a3,a3,a7
    5760:	01081813          	slli	a6,a6,0x10
    5764:	00c86833          	or	a6,a6,a2
    5768:	01081e13          	slli	t3,a6,0x10
    576c:	01085f93          	srli	t6,a6,0x10
    5770:	010e5e13          	srli	t3,t3,0x10
    5774:	02fe0f33          	mul	t5,t3,a5
    5778:	41d686b3          	sub	a3,a3,t4
    577c:	03c50e33          	mul	t3,a0,t3
    5780:	010f5613          	srli	a2,t5,0x10
    5784:	02ff87b3          	mul	a5,t6,a5
    5788:	00fe0e33          	add	t3,t3,a5
    578c:	01c60633          	add	a2,a2,t3
    5790:	03f50533          	mul	a0,a0,t6
    5794:	00f67663          	bgeu	a2,a5,57a0 <__divdf3+0x4ec>
    5798:	000107b7          	lui	a5,0x10
    579c:	00f50533          	add	a0,a0,a5
    57a0:	00010e37          	lui	t3,0x10
    57a4:	fffe0e13          	addi	t3,t3,-1 # ffff <__global_pointer$+0x9467>
    57a8:	01065793          	srli	a5,a2,0x10
    57ac:	01c67633          	and	a2,a2,t3
    57b0:	01061613          	slli	a2,a2,0x10
    57b4:	01cf7f33          	and	t5,t5,t3
    57b8:	00a78533          	add	a0,a5,a0
    57bc:	01e60633          	add	a2,a2,t5
    57c0:	0ca6f863          	bgeu	a3,a0,5890 <__divdf3+0x5dc>
    57c4:	00d886b3          	add	a3,a7,a3
    57c8:	fff80793          	addi	a5,a6,-1
    57cc:	2516e463          	bltu	a3,a7,5a14 <__divdf3+0x760>
    57d0:	20a6ee63          	bltu	a3,a0,59ec <__divdf3+0x738>
    57d4:	24a68663          	beq	a3,a0,5a20 <__divdf3+0x76c>
    57d8:	00078813          	mv	a6,a5
    57dc:	00186813          	ori	a6,a6,1
    57e0:	d8dff06f          	j	556c <__divdf3+0x2b8>
    57e4:	00048513          	mv	a0,s1
    57e8:	8a5fd0ef          	jal	ra,308c <__clzsi2>
    57ec:	01550713          	addi	a4,a0,21
    57f0:	01c00593          	li	a1,28
    57f4:	02050913          	addi	s2,a0,32
    57f8:	00812603          	lw	a2,8(sp)
    57fc:	00c12683          	lw	a3,12(sp)
    5800:	c8e5d8e3          	bge	a1,a4,5490 <__divdf3+0x1dc>
    5804:	ff850413          	addi	s0,a0,-8
    5808:	00849ab3          	sll	s5,s1,s0
    580c:	00000b13          	li	s6,0
    5810:	c9dff06f          	j	54ac <__divdf3+0x1f8>
    5814:	00060513          	mv	a0,a2
    5818:	00c12423          	sw	a2,8(sp)
    581c:	871fd0ef          	jal	ra,308c <__clzsi2>
    5820:	01550593          	addi	a1,a0,21
    5824:	01c00713          	li	a4,28
    5828:	00050793          	mv	a5,a0
    582c:	00812603          	lw	a2,8(sp)
    5830:	02050513          	addi	a0,a0,32
    5834:	c0b752e3          	bge	a4,a1,5438 <__divdf3+0x184>
    5838:	ff878793          	addi	a5,a5,-8 # fff8 <__global_pointer$+0x9460>
    583c:	00000813          	li	a6,0
    5840:	00f61433          	sll	s0,a2,a5
    5844:	c11ff06f          	j	5454 <__divdf3+0x1a0>
    5848:	e8db78e3          	bgeu	s6,a3,56d8 <__divdf3+0x424>
    584c:	006b0b33          	add	s6,s6,t1
    5850:	006b3833          	sltu	a6,s6,t1
    5854:	01180833          	add	a6,a6,a7
    5858:	01070733          	add	a4,a4,a6
    585c:	fff40813          	addi	a6,s0,-1
    5860:	02e8fe63          	bgeu	a7,a4,589c <__divdf3+0x5e8>
    5864:	16c76063          	bltu	a4,a2,59c4 <__divdf3+0x710>
    5868:	14e60c63          	beq	a2,a4,59c0 <__divdf3+0x70c>
    586c:	00080413          	mv	s0,a6
    5870:	e69ff06f          	j	56d8 <__divdf3+0x424>
    5874:	d50b6ee3          	bltu	s6,a6,55d0 <__divdf3+0x31c>
    5878:	01fa9713          	slli	a4,s5,0x1f
    587c:	001b5613          	srli	a2,s6,0x1
    5880:	001ada93          	srli	s5,s5,0x1
    5884:	00c76733          	or	a4,a4,a2
    5888:	01fb1b13          	slli	s6,s6,0x1f
    588c:	d51ff06f          	j	55dc <__divdf3+0x328>
    5890:	f4a696e3          	bne	a3,a0,57dc <__divdf3+0x528>
    5894:	cc060ce3          	beqz	a2,556c <__divdf3+0x2b8>
    5898:	f2dff06f          	j	57c4 <__divdf3+0x510>
    589c:	fce898e3          	bne	a7,a4,586c <__divdf3+0x5b8>
    58a0:	fc6b72e3          	bgeu	s6,t1,5864 <__divdf3+0x5b0>
    58a4:	00080413          	mv	s0,a6
    58a8:	e31ff06f          	j	56d8 <__divdf3+0x424>
    58ac:	00f87793          	andi	a5,a6,15
    58b0:	00400693          	li	a3,4
    58b4:	ccd782e3          	beq	a5,a3,5578 <__divdf3+0x2c4>
    58b8:	ffc83793          	sltiu	a5,a6,-4
    58bc:	00480813          	addi	a6,a6,4
    58c0:	0017c793          	xori	a5,a5,1
    58c4:	00385813          	srli	a6,a6,0x3
    58c8:	00f40433          	add	s0,s0,a5
    58cc:	cb1ff06f          	j	557c <__divdf3+0x2c8>
    58d0:	00000813          	li	a6,0
    58d4:	00100793          	li	a5,1
    58d8:	fee048e3          	bgtz	a4,58c8 <__divdf3+0x614>
    58dc:	fff00813          	li	a6,-1
    58e0:	c40716e3          	bnez	a4,552c <__divdf3+0x278>
    58e4:	c0100913          	li	s2,-1023
    58e8:	00100793          	li	a5,1
    58ec:	41e90513          	addi	a0,s2,1054
    58f0:	00a41733          	sll	a4,s0,a0
    58f4:	00f856b3          	srl	a3,a6,a5
    58f8:	00a81533          	sll	a0,a6,a0
    58fc:	00d76733          	or	a4,a4,a3
    5900:	00a03533          	snez	a0,a0
    5904:	00a76733          	or	a4,a4,a0
    5908:	00777693          	andi	a3,a4,7
    590c:	00f45433          	srl	s0,s0,a5
    5910:	02068063          	beqz	a3,5930 <__divdf3+0x67c>
    5914:	00f77793          	andi	a5,a4,15
    5918:	00400693          	li	a3,4
    591c:	00d78a63          	beq	a5,a3,5930 <__divdf3+0x67c>
    5920:	00470793          	addi	a5,a4,4
    5924:	00e7b733          	sltu	a4,a5,a4
    5928:	00e40433          	add	s0,s0,a4
    592c:	00078713          	mv	a4,a5
    5930:	00841793          	slli	a5,s0,0x8
    5934:	0607d863          	bgez	a5,59a4 <__divdf3+0x6f0>
    5938:	00100713          	li	a4,1
    593c:	00000793          	li	a5,0
    5940:	00000413          	li	s0,0
    5944:	a75ff06f          	j	53b8 <__divdf3+0x104>
    5948:	00070413          	mv	s0,a4
    594c:	d1dff06f          	j	5668 <__divdf3+0x3b4>
    5950:	00050793          	mv	a5,a0
    5954:	cd9ff06f          	j	562c <__divdf3+0x378>
    5958:	01f00693          	li	a3,31
    595c:	f8f6d8e3          	bge	a3,a5,58ec <__divdf3+0x638>
    5960:	fe100693          	li	a3,-31
    5964:	40e68733          	sub	a4,a3,a4
    5968:	02000613          	li	a2,32
    596c:	00e456b3          	srl	a3,s0,a4
    5970:	00c78863          	beq	a5,a2,5980 <__divdf3+0x6cc>
    5974:	43e90793          	addi	a5,s2,1086
    5978:	00f417b3          	sll	a5,s0,a5
    597c:	00f86833          	or	a6,a6,a5
    5980:	01003733          	snez	a4,a6
    5984:	00d76733          	or	a4,a4,a3
    5988:	00777413          	andi	s0,a4,7
    598c:	00000793          	li	a5,0
    5990:	02040063          	beqz	s0,59b0 <__divdf3+0x6fc>
    5994:	00f77793          	andi	a5,a4,15
    5998:	00400693          	li	a3,4
    599c:	00000413          	li	s0,0
    59a0:	f8d790e3          	bne	a5,a3,5920 <__divdf3+0x66c>
    59a4:	00941793          	slli	a5,s0,0x9
    59a8:	00c7d793          	srli	a5,a5,0xc
    59ac:	01d41413          	slli	s0,s0,0x1d
    59b0:	00375713          	srli	a4,a4,0x3
    59b4:	00876433          	or	s0,a4,s0
    59b8:	00000713          	li	a4,0
    59bc:	9fdff06f          	j	53b8 <__divdf3+0x104>
    59c0:	eadb76e3          	bgeu	s6,a3,586c <__divdf3+0x5b8>
    59c4:	006b0b33          	add	s6,s6,t1
    59c8:	006b3833          	sltu	a6,s6,t1
    59cc:	01180833          	add	a6,a6,a7
    59d0:	ffe40413          	addi	s0,s0,-2
    59d4:	01070733          	add	a4,a4,a6
    59d8:	d01ff06f          	j	56d8 <__divdf3+0x424>
    59dc:	000e0613          	mv	a2,t3
    59e0:	d81ff06f          	j	5760 <__divdf3+0x4ac>
    59e4:	00060813          	mv	a6,a2
    59e8:	d3dff06f          	j	5724 <__divdf3+0x470>
    59ec:	00131793          	slli	a5,t1,0x1
    59f0:	0067b333          	sltu	t1,a5,t1
    59f4:	011308b3          	add	a7,t1,a7
    59f8:	011686b3          	add	a3,a3,a7
    59fc:	ffe80813          	addi	a6,a6,-2
    5a00:	00078313          	mv	t1,a5
    5a04:	dca69ce3          	bne	a3,a0,57dc <__divdf3+0x528>
    5a08:	b6c302e3          	beq	t1,a2,556c <__divdf3+0x2b8>
    5a0c:	00186813          	ori	a6,a6,1
    5a10:	b5dff06f          	j	556c <__divdf3+0x2b8>
    5a14:	00078813          	mv	a6,a5
    5a18:	fea688e3          	beq	a3,a0,5a08 <__divdf3+0x754>
    5a1c:	dc1ff06f          	j	57dc <__divdf3+0x528>
    5a20:	fcc366e3          	bltu	t1,a2,59ec <__divdf3+0x738>
    5a24:	00078813          	mv	a6,a5
    5a28:	fec312e3          	bne	t1,a2,5a0c <__divdf3+0x758>
    5a2c:	b41ff06f          	j	556c <__divdf3+0x2b8>

00005a30 <__eqdf2>:
    5a30:	0145d713          	srli	a4,a1,0x14
    5a34:	001007b7          	lui	a5,0x100
    5a38:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf9467>
    5a3c:	0146d813          	srli	a6,a3,0x14
    5a40:	7ff77713          	andi	a4,a4,2047
    5a44:	7ff00893          	li	a7,2047
    5a48:	00b7fe33          	and	t3,a5,a1
    5a4c:	00050e93          	mv	t4,a0
    5a50:	00d7f7b3          	and	a5,a5,a3
    5a54:	01f5d593          	srli	a1,a1,0x1f
    5a58:	00060f13          	mv	t5,a2
    5a5c:	7ff87813          	andi	a6,a6,2047
    5a60:	01f6d693          	srli	a3,a3,0x1f
    5a64:	01170e63          	beq	a4,a7,5a80 <__eqdf2+0x50>
    5a68:	00100313          	li	t1,1
    5a6c:	01180663          	beq	a6,a7,5a78 <__eqdf2+0x48>
    5a70:	01071463          	bne	a4,a6,5a78 <__eqdf2+0x48>
    5a74:	02fe0263          	beq	t3,a5,5a98 <__eqdf2+0x68>
    5a78:	00030513          	mv	a0,t1
    5a7c:	00008067          	ret
    5a80:	00ae68b3          	or	a7,t3,a0
    5a84:	00100313          	li	t1,1
    5a88:	fe0898e3          	bnez	a7,5a78 <__eqdf2+0x48>
    5a8c:	fee816e3          	bne	a6,a4,5a78 <__eqdf2+0x48>
    5a90:	00c7e7b3          	or	a5,a5,a2
    5a94:	fe0792e3          	bnez	a5,5a78 <__eqdf2+0x48>
    5a98:	00100313          	li	t1,1
    5a9c:	fdee9ee3          	bne	t4,t5,5a78 <__eqdf2+0x48>
    5aa0:	00000313          	li	t1,0
    5aa4:	fcd58ae3          	beq	a1,a3,5a78 <__eqdf2+0x48>
    5aa8:	00100313          	li	t1,1
    5aac:	fc0716e3          	bnez	a4,5a78 <__eqdf2+0x48>
    5ab0:	00ae6533          	or	a0,t3,a0
    5ab4:	00a03333          	snez	t1,a0
    5ab8:	fc1ff06f          	j	5a78 <__eqdf2+0x48>

00005abc <__gedf2>:
    5abc:	0145d713          	srli	a4,a1,0x14
    5ac0:	001007b7          	lui	a5,0x100
    5ac4:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf9467>
    5ac8:	0146d813          	srli	a6,a3,0x14
    5acc:	7ff77713          	andi	a4,a4,2047
    5ad0:	7ff00893          	li	a7,2047
    5ad4:	00b7f333          	and	t1,a5,a1
    5ad8:	00050e13          	mv	t3,a0
    5adc:	00d7f7b3          	and	a5,a5,a3
    5ae0:	01f5d593          	srli	a1,a1,0x1f
    5ae4:	00060e93          	mv	t4,a2
    5ae8:	7ff87813          	andi	a6,a6,2047
    5aec:	01f6d693          	srli	a3,a3,0x1f
    5af0:	05170263          	beq	a4,a7,5b34 <__gedf2+0x78>
    5af4:	03180863          	beq	a6,a7,5b24 <__gedf2+0x68>
    5af8:	04071463          	bnez	a4,5b40 <__gedf2+0x84>
    5afc:	00a36533          	or	a0,t1,a0
    5b00:	00081663          	bnez	a6,5b0c <__gedf2+0x50>
    5b04:	00c7e633          	or	a2,a5,a2
    5b08:	06060263          	beqz	a2,5b6c <__gedf2+0xb0>
    5b0c:	04050a63          	beqz	a0,5b60 <__gedf2+0xa4>
    5b10:	06d58c63          	beq	a1,a3,5b88 <__gedf2+0xcc>
    5b14:	00100693          	li	a3,1
    5b18:	04059663          	bnez	a1,5b64 <__gedf2+0xa8>
    5b1c:	00068513          	mv	a0,a3
    5b20:	00008067          	ret
    5b24:	00c7e8b3          	or	a7,a5,a2
    5b28:	fc0888e3          	beqz	a7,5af8 <__gedf2+0x3c>
    5b2c:	ffe00693          	li	a3,-2
    5b30:	fedff06f          	j	5b1c <__gedf2+0x60>
    5b34:	00a36533          	or	a0,t1,a0
    5b38:	fe051ae3          	bnez	a0,5b2c <__gedf2+0x70>
    5b3c:	02e80e63          	beq	a6,a4,5b78 <__gedf2+0xbc>
    5b40:	00081663          	bnez	a6,5b4c <__gedf2+0x90>
    5b44:	00c7e633          	or	a2,a5,a2
    5b48:	fc0606e3          	beqz	a2,5b14 <__gedf2+0x58>
    5b4c:	fcd594e3          	bne	a1,a3,5b14 <__gedf2+0x58>
    5b50:	02e85c63          	bge	a6,a4,5b88 <__gedf2+0xcc>
    5b54:	00069863          	bnez	a3,5b64 <__gedf2+0xa8>
    5b58:	00100693          	li	a3,1
    5b5c:	fc1ff06f          	j	5b1c <__gedf2+0x60>
    5b60:	fa069ee3          	bnez	a3,5b1c <__gedf2+0x60>
    5b64:	fff00693          	li	a3,-1
    5b68:	fb5ff06f          	j	5b1c <__gedf2+0x60>
    5b6c:	00000693          	li	a3,0
    5b70:	fa0506e3          	beqz	a0,5b1c <__gedf2+0x60>
    5b74:	fa1ff06f          	j	5b14 <__gedf2+0x58>
    5b78:	00c7e633          	or	a2,a5,a2
    5b7c:	fc0608e3          	beqz	a2,5b4c <__gedf2+0x90>
    5b80:	ffe00693          	li	a3,-2
    5b84:	f99ff06f          	j	5b1c <__gedf2+0x60>
    5b88:	01074a63          	blt	a4,a6,5b9c <__gedf2+0xe0>
    5b8c:	f867e4e3          	bltu	a5,t1,5b14 <__gedf2+0x58>
    5b90:	00f30c63          	beq	t1,a5,5ba8 <__gedf2+0xec>
    5b94:	00000693          	li	a3,0
    5b98:	f8f372e3          	bgeu	t1,a5,5b1c <__gedf2+0x60>
    5b9c:	fc0584e3          	beqz	a1,5b64 <__gedf2+0xa8>
    5ba0:	00058693          	mv	a3,a1
    5ba4:	f79ff06f          	j	5b1c <__gedf2+0x60>
    5ba8:	f7cee6e3          	bltu	t4,t3,5b14 <__gedf2+0x58>
    5bac:	00000693          	li	a3,0
    5bb0:	f7de76e3          	bgeu	t3,t4,5b1c <__gedf2+0x60>
    5bb4:	fe9ff06f          	j	5b9c <__gedf2+0xe0>

00005bb8 <__unorddf2>:
    5bb8:	0145d713          	srli	a4,a1,0x14
    5bbc:	001007b7          	lui	a5,0x100
    5bc0:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf9467>
    5bc4:	fff74713          	not	a4,a4
    5bc8:	0146d813          	srli	a6,a3,0x14
    5bcc:	00b7f5b3          	and	a1,a5,a1
    5bd0:	00d7f7b3          	and	a5,a5,a3
    5bd4:	01571693          	slli	a3,a4,0x15
    5bd8:	7ff87813          	andi	a6,a6,2047
    5bdc:	02068063          	beqz	a3,5bfc <__unorddf2+0x44>
    5be0:	7ff00713          	li	a4,2047
    5be4:	00000513          	li	a0,0
    5be8:	00e80463          	beq	a6,a4,5bf0 <__unorddf2+0x38>
    5bec:	00008067          	ret
    5bf0:	00c7e7b3          	or	a5,a5,a2
    5bf4:	00f03533          	snez	a0,a5
    5bf8:	00008067          	ret
    5bfc:	00a5e5b3          	or	a1,a1,a0
    5c00:	00100513          	li	a0,1
    5c04:	fc058ee3          	beqz	a1,5be0 <__unorddf2+0x28>
    5c08:	00008067          	ret

00005c0c <__errno>:
    5c0c:	81418793          	addi	a5,gp,-2028 # 63ac <_impure_ptr>
    5c10:	0007a503          	lw	a0,0(a5)
    5c14:	00008067          	ret
