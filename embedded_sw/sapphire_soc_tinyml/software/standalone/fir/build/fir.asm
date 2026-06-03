
build/fir.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00006197          	auipc	gp,0x6
    1004:	c4818193          	addi	gp,gp,-952 # 6c48 <__global_pointer$>

00001008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
    1008:	00205117          	auipc	sp,0x205
    100c:	49810113          	addi	sp,sp,1176 # 2064a0 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1010:	00005517          	auipc	a0,0x5
    1014:	c9c50513          	addi	a0,a0,-868 # 5cac <_data>
	la a1, _data
    1018:	00005597          	auipc	a1,0x5
    101c:	c9458593          	addi	a1,a1,-876 # 5cac <_data>
	la a2, _edata
    1020:	83c18613          	addi	a2,gp,-1988 # 6484 <x>
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
    103c:	83c18513          	addi	a0,gp,-1988 # 6484 <x>
	la a1, _end
    1040:	85818593          	addi	a1,gp,-1960 # 64a0 <_end>
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
    1058:	201000ef          	jal	ra,1a58 <main>

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
    1078:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5f1adf>
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
    1124:	b8c40413          	addi	s0,s0,-1140 # 5cac <_data>
    1128:	00005917          	auipc	s2,0x5
    112c:	b8490913          	addi	s2,s2,-1148 # 5cac <_data>
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
    1160:	b5040413          	addi	s0,s0,-1200 # 5cac <_data>
    1164:	00005917          	auipc	s2,0x5
    1168:	b4890913          	addi	s2,s2,-1208 # 5cac <_data>
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
    11c8:	eff60613          	addi	a2,a2,-257 # fefefeff <__freertos_irq_stack_top+0xfede9a5f>
    11cc:	00c707b3          	add	a5,a4,a2
    11d0:	808086b7          	lui	a3,0x80808
    11d4:	fff74713          	not	a4,a4
    11d8:	08068693          	addi	a3,a3,128 # 80808080 <__freertos_irq_stack_top+0x80601be0>
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
    1258:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5f1adf>
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

000012e4 <uart_write>:
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
    
    static void uart_write(u32 reg, char data){
    12e4:	ff010113          	addi	sp,sp,-16
    12e8:	00112623          	sw	ra,12(sp)
    12ec:	00812423          	sw	s0,8(sp)
    12f0:	00912223          	sw	s1,4(sp)
    12f4:	00050413          	mv	s0,a0
    12f8:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    12fc:	00040513          	mv	a0,s0
    1300:	fd5ff0ef          	jal	ra,12d4 <uart_writeAvailability>
    1304:	fe050ce3          	beqz	a0,12fc <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    1308:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    130c:	00c12083          	lw	ra,12(sp)
    1310:	00812403          	lw	s0,8(sp)
    1314:	00412483          	lw	s1,4(sp)
    1318:	01010113          	addi	sp,sp,16
    131c:	00008067          	ret

00001320 <clint_getTime>:
        write_u32(0xFFFFFFFF, p + 4);
        write_u32(cmp, p + 0);
        write_u32(cmp >> 32, p + 4);
    }
    
    static u64 clint_getTime(u32 p){
    1320:	00050693          	mv	a3,a0
    readReg_u32 (clint_getTimeHigh, CLINT_TIME_ADDR+4)
    1324:	0000c7b7          	lui	a5,0xc
    1328:	ffc78713          	addi	a4,a5,-4 # bffc <__global_pointer$+0x53b4>
    132c:	00e68733          	add	a4,a3,a4
        return *((volatile u32*) address);
    1330:	00072583          	lw	a1,0(a4)
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    1334:	ff878793          	addi	a5,a5,-8
    1338:	00f687b3          	add	a5,a3,a5
    133c:	0007a503          	lw	a0,0(a5)
    1340:	00072783          	lw	a5,0(a4)
    
        /* Likewise, must guard against rollover when reading */
        do {
            hi = clint_getTimeHigh(p);
            lo = clint_getTimeLow(p);
        } while (clint_getTimeHigh(p) != hi);
    1344:	feb790e3          	bne	a5,a1,1324 <clint_getTime+0x4>
    
        return (((u64)hi) << 32) | lo;
    }
    1348:	00008067          	ret

0000134c <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    134c:	ff010113          	addi	sp,sp,-16
    1350:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    1354:	00050593          	mv	a1,a0
    1358:	f8010537          	lui	a0,0xf8010
    135c:	f89ff0ef          	jal	ra,12e4 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1360:	00c12083          	lw	ra,12(sp)
    1364:	01010113          	addi	sp,sp,16
    1368:	00008067          	ret

0000136c <_putchar_s>:

    static void _putchar_s(char *p)
    {
    136c:	ff010113          	addi	sp,sp,-16
    1370:	00112623          	sw	ra,12(sp)
    1374:	00812423          	sw	s0,8(sp)
    1378:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    137c:	00044503          	lbu	a0,0(s0)
    1380:	00050863          	beqz	a0,1390 <_putchar_s+0x24>
            _putchar(*(p++));
    1384:	00140413          	addi	s0,s0,1
    1388:	fc5ff0ef          	jal	ra,134c <_putchar>
    138c:	ff1ff06f          	j	137c <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1390:	00c12083          	lw	ra,12(sp)
    1394:	00812403          	lw	s0,8(sp)
    1398:	01010113          	addi	sp,sp,16
    139c:	00008067          	ret

000013a0 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    13a0:	ff010113          	addi	sp,sp,-16
    13a4:	00112623          	sw	ra,12(sp)
    13a8:	00812423          	sw	s0,8(sp)
    13ac:	00912223          	sw	s1,4(sp)
    13b0:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    13b4:	01c00413          	li	s0,28
    13b8:	0240006f          	j	13dc <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    13bc:	0084d7b3          	srl	a5,s1,s0
    13c0:	00f7f713          	andi	a4,a5,15
    13c4:	000067b7          	lui	a5,0x6
    13c8:	cb078793          	addi	a5,a5,-848 # 5cb0 <_data+0x4>
    13cc:	00e787b3          	add	a5,a5,a4
    13d0:	0007c503          	lbu	a0,0(a5)
    13d4:	f79ff0ef          	jal	ra,134c <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    13d8:	ffc40413          	addi	s0,s0,-4
    13dc:	fe0450e3          	bgez	s0,13bc <bsp_printHex+0x1c>
        }
    }
    13e0:	00c12083          	lw	ra,12(sp)
    13e4:	00812403          	lw	s0,8(sp)
    13e8:	00412483          	lw	s1,4(sp)
    13ec:	01010113          	addi	sp,sp,16
    13f0:	00008067          	ret

000013f4 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    13f4:	ff010113          	addi	sp,sp,-16
    13f8:	00112623          	sw	ra,12(sp)
    13fc:	00812423          	sw	s0,8(sp)
    1400:	00912223          	sw	s1,4(sp)
    1404:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1408:	01c00413          	li	s0,28
    140c:	0240006f          	j	1430 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    1410:	0084d7b3          	srl	a5,s1,s0
    1414:	00f7f713          	andi	a4,a5,15
    1418:	000067b7          	lui	a5,0x6
    141c:	cc478793          	addi	a5,a5,-828 # 5cc4 <_data+0x18>
    1420:	00e787b3          	add	a5,a5,a4
    1424:	0007c503          	lbu	a0,0(a5)
    1428:	f25ff0ef          	jal	ra,134c <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    142c:	ffc40413          	addi	s0,s0,-4
    1430:	fe0450e3          	bgez	s0,1410 <bsp_printHex_lower+0x1c>

        }
    }
    1434:	00c12083          	lw	ra,12(sp)
    1438:	00812403          	lw	s0,8(sp)
    143c:	00412483          	lw	s1,4(sp)
    1440:	01010113          	addi	sp,sp,16
    1444:	00008067          	ret

00001448 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    1448:	ff010113          	addi	sp,sp,-16
    144c:	00112623          	sw	ra,12(sp)
        _putchar(c);
    1450:	0ff57513          	andi	a0,a0,255
    1454:	ef9ff0ef          	jal	ra,134c <_putchar>
    }
    1458:	00c12083          	lw	ra,12(sp)
    145c:	01010113          	addi	sp,sp,16
    1460:	00008067          	ret

00001464 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    1464:	ff010113          	addi	sp,sp,-16
    1468:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    146c:	f01ff0ef          	jal	ra,136c <_putchar_s>
    }
    1470:	00c12083          	lw	ra,12(sp)
    1474:	01010113          	addi	sp,sp,16
    1478:	00008067          	ret

0000147c <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    147c:	fd010113          	addi	sp,sp,-48
    1480:	02112623          	sw	ra,44(sp)
    1484:	02812423          	sw	s0,40(sp)
    1488:	02912223          	sw	s1,36(sp)
    148c:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    1490:	00054663          	bltz	a0,149c <bsp_printf_d+0x20>
    {
    1494:	00010413          	mv	s0,sp
    1498:	02c0006f          	j	14c4 <bsp_printf_d+0x48>
            bsp_printf_c('-');
    149c:	02d00513          	li	a0,45
    14a0:	fa9ff0ef          	jal	ra,1448 <bsp_printf_c>
            val = -val;
    14a4:	409004b3          	neg	s1,s1
    14a8:	fedff06f          	j	1494 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    14ac:	00a00713          	li	a4,10
    14b0:	02e4e7b3          	rem	a5,s1,a4
    14b4:	03078793          	addi	a5,a5,48
    14b8:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    14bc:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    14c0:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    14c4:	fe0494e3          	bnez	s1,14ac <bsp_printf_d+0x30>
    14c8:	00010793          	mv	a5,sp
    14cc:	fef400e3          	beq	s0,a5,14ac <bsp_printf_d+0x30>
    14d0:	0100006f          	j	14e0 <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
    14d4:	fff40413          	addi	s0,s0,-1
    14d8:	00044503          	lbu	a0,0(s0)
    14dc:	f6dff0ef          	jal	ra,1448 <bsp_printf_c>
        while (p != buffer)
    14e0:	00010793          	mv	a5,sp
    14e4:	fef418e3          	bne	s0,a5,14d4 <bsp_printf_d+0x58>
    }
    14e8:	02c12083          	lw	ra,44(sp)
    14ec:	02812403          	lw	s0,40(sp)
    14f0:	02412483          	lw	s1,36(sp)
    14f4:	03010113          	addi	sp,sp,48
    14f8:	00008067          	ret

000014fc <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    14fc:	ff010113          	addi	sp,sp,-16
    1500:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    1504:	00000713          	li	a4,0
    1508:	00700793          	li	a5,7
    150c:	02e7c063          	blt	a5,a4,152c <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1510:	00271693          	slli	a3,a4,0x2
    1514:	ff000793          	li	a5,-16
    1518:	00d797b3          	sll	a5,a5,a3
    151c:	00f577b3          	and	a5,a0,a5
    1520:	00078663          	beqz	a5,152c <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    1524:	00170713          	addi	a4,a4,1
    1528:	fe1ff06f          	j	1508 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    152c:	ec9ff0ef          	jal	ra,13f4 <bsp_printHex_lower>
    }
    1530:	00c12083          	lw	ra,12(sp)
    1534:	01010113          	addi	sp,sp,16
    1538:	00008067          	ret

0000153c <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    153c:	ff010113          	addi	sp,sp,-16
    1540:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    1544:	00000713          	li	a4,0
    1548:	00700793          	li	a5,7
    154c:	02e7c063          	blt	a5,a4,156c <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1550:	00271693          	slli	a3,a4,0x2
    1554:	ff000793          	li	a5,-16
    1558:	00d797b3          	sll	a5,a5,a3
    155c:	00f577b3          	and	a5,a0,a5
    1560:	00078663          	beqz	a5,156c <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    1564:	00170713          	addi	a4,a4,1
    1568:	fe1ff06f          	j	1548 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    156c:	e35ff0ef          	jal	ra,13a0 <bsp_printHex>
        }
    1570:	00c12083          	lw	ra,12(sp)
    1574:	01010113          	addi	sp,sp,16
    1578:	00008067          	ret

0000157c <reverse>:
     {
    157c:	ff010113          	addi	sp,sp,-16
    1580:	00112623          	sw	ra,12(sp)
    1584:	00812423          	sw	s0,8(sp)
    1588:	00050413          	mv	s0,a0
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    158c:	cbdff0ef          	jal	ra,1248 <strlen>
    1590:	fff50513          	addi	a0,a0,-1 # f800ffff <__freertos_irq_stack_top+0xf7e09b5f>
    1594:	00000793          	li	a5,0
    1598:	02a7d463          	bge	a5,a0,15c0 <reverse+0x44>
              c = s[i];
    159c:	00f406b3          	add	a3,s0,a5
    15a0:	0006c603          	lbu	a2,0(a3)
              s[i] = s[j];
    15a4:	00a40733          	add	a4,s0,a0
    15a8:	00074583          	lbu	a1,0(a4)
    15ac:	00b68023          	sb	a1,0(a3)
              s[j] = c;
    15b0:	00c70023          	sb	a2,0(a4)
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    15b4:	00178793          	addi	a5,a5,1
    15b8:	fff50513          	addi	a0,a0,-1
    15bc:	fddff06f          	j	1598 <reverse+0x1c>
     }
    15c0:	00c12083          	lw	ra,12(sp)
    15c4:	00812403          	lw	s0,8(sp)
    15c8:	01010113          	addi	sp,sp,16
    15cc:	00008067          	ret

000015d0 <itos>:
     {
    15d0:	ff010113          	addi	sp,sp,-16
    15d4:	00112623          	sw	ra,12(sp)
         if ((sign = n) < 0)  /* record sign */
    15d8:	00054863          	bltz	a0,15e8 <itos+0x18>
    15dc:	00050613          	mv	a2,a0
    15e0:	00000813          	li	a6,0
    15e4:	0140006f          	j	15f8 <itos+0x28>
             n = -n;          /* make n positive */
    15e8:	40a00633          	neg	a2,a0
    15ec:	ff5ff06f          	j	15e0 <itos+0x10>
             s[i++] = n % 10 + '0';   /* get next digit */
    15f0:	00088813          	mv	a6,a7
         } while ((n /= 10) > 0);     /* delete it */
    15f4:	00078613          	mv	a2,a5
             s[i++] = n % 10 + '0';   /* get next digit */
    15f8:	00a00793          	li	a5,10
    15fc:	02f666b3          	rem	a3,a2,a5
    1600:	00180893          	addi	a7,a6,1
    1604:	01058733          	add	a4,a1,a6
    1608:	03068693          	addi	a3,a3,48
    160c:	00d70023          	sb	a3,0(a4)
         } while ((n /= 10) > 0);     /* delete it */
    1610:	02f647b3          	div	a5,a2,a5
    1614:	00900713          	li	a4,9
    1618:	fcc74ce3          	blt	a4,a2,15f0 <itos+0x20>
         if (sign < 0)
    161c:	02054063          	bltz	a0,163c <itos+0x6c>
         s[i] = '\0';
    1620:	011588b3          	add	a7,a1,a7
    1624:	00088023          	sb	zero,0(a7)
         reverse(s);
    1628:	00058513          	mv	a0,a1
    162c:	f51ff0ef          	jal	ra,157c <reverse>
    }
    1630:	00c12083          	lw	ra,12(sp)
    1634:	01010113          	addi	sp,sp,16
    1638:	00008067          	ret
             s[i++] = '-';
    163c:	011588b3          	add	a7,a1,a7
    1640:	02d00793          	li	a5,45
    1644:	00f88023          	sb	a5,0(a7)
    1648:	00280893          	addi	a7,a6,2
    164c:	fd5ff06f          	j	1620 <itos+0x50>

00001650 <ftoa>:
    {
    1650:	fe010113          	addi	sp,sp,-32
    1654:	00112e23          	sw	ra,28(sp)
    1658:	00812c23          	sw	s0,24(sp)
    165c:	00912a23          	sw	s1,20(sp)
    1660:	01212823          	sw	s2,16(sp)
    1664:	01312623          	sw	s3,12(sp)
    1668:	01412423          	sw	s4,8(sp)
    166c:	00050913          	mv	s2,a0
    1670:	00058993          	mv	s3,a1
    1674:	00060a13          	mv	s4,a2
    1678:	00068413          	mv	s0,a3
        int ipart = (int)n;
    167c:	46c010ef          	jal	ra,2ae8 <__fixdfsi>
    1680:	00050493          	mv	s1,a0
        double fpart = n - (double)ipart;
    1684:	4e8010ef          	jal	ra,2b6c <__floatsidf>
    1688:	00050613          	mv	a2,a0
    168c:	00058693          	mv	a3,a1
    1690:	00090513          	mv	a0,s2
    1694:	00098593          	mv	a1,s3
    1698:	3d5000ef          	jal	ra,226c <__subdf3>
    169c:	00050913          	mv	s2,a0
    16a0:	00058993          	mv	s3,a1
        itos(n, res1);
    16a4:	000a0593          	mv	a1,s4
    16a8:	00048513          	mv	a0,s1
    16ac:	f25ff0ef          	jal	ra,15d0 <itos>
        *res2 = '.';
    16b0:	02e00793          	li	a5,46
    16b4:	00f40023          	sb	a5,0(s0)
        res2++;
    16b8:	00140a13          	addi	s4,s0,1
        fpart_f = (float)fpart * pow(10, afterpoint);
    16bc:	00090513          	mv	a0,s2
    16c0:	00098593          	mv	a1,s3
    16c4:	065010ef          	jal	ra,2f28 <__truncdfsf2>
    16c8:	760010ef          	jal	ra,2e28 <__extendsfdf2>
    16cc:	8181a603          	lw	a2,-2024(gp) # 6460 <_impure_ptr+0x4>
    16d0:	81c1a683          	lw	a3,-2020(gp) # 6464 <_impure_ptr+0x8>
    16d4:	544000ef          	jal	ra,1c18 <__muldf3>
    16d8:	051010ef          	jal	ra,2f28 <__truncdfsf2>
    16dc:	00050493          	mv	s1,a0
        if (fpart_f<0)
    16e0:	00000593          	li	a1,0
    16e4:	60c010ef          	jal	ra,2cf0 <__lesf2>
    16e8:	06054a63          	bltz	a0,175c <ftoa+0x10c>
        for (int i=afterpoint; i>0; i--)
    16ec:	00400413          	li	s0,4
    16f0:	08805263          	blez	s0,1774 <ftoa+0x124>
            if ((fpart_f<(1 * pow(10, i-1))) && (fpart_f>0))
    16f4:	00048513          	mv	a0,s1
    16f8:	730010ef          	jal	ra,2e28 <__extendsfdf2>
    16fc:	00050913          	mv	s2,a0
    1700:	00058993          	mv	s3,a1
    1704:	fff40413          	addi	s0,s0,-1
    1708:	00040513          	mv	a0,s0
    170c:	460010ef          	jal	ra,2b6c <__floatsidf>
    1710:	00050613          	mv	a2,a0
    1714:	00058693          	mv	a3,a1
    1718:	8201a503          	lw	a0,-2016(gp) # 6468 <_impure_ptr+0xc>
    171c:	8241a583          	lw	a1,-2012(gp) # 646c <_impure_ptr+0x10>
    1720:	291010ef          	jal	ra,31b0 <pow>
    1724:	00050613          	mv	a2,a0
    1728:	00058693          	mv	a3,a1
    172c:	00090513          	mv	a0,s2
    1730:	00098593          	mv	a1,s3
    1734:	3e4000ef          	jal	ra,1b18 <__ledf2>
    1738:	fa055ce3          	bgez	a0,16f0 <ftoa+0xa0>
    173c:	00000593          	li	a1,0
    1740:	00048513          	mv	a0,s1
    1744:	4e8010ef          	jal	ra,2c2c <__gesf2>
    1748:	faa054e3          	blez	a0,16f0 <ftoa+0xa0>
                *res2='0';
    174c:	03000793          	li	a5,48
    1750:	00fa0023          	sb	a5,0(s4)
                res2++;
    1754:	001a0a13          	addi	s4,s4,1
    1758:	f99ff06f          	j	16f0 <ftoa+0xa0>
            *res2 = '-';
    175c:	02d00793          	li	a5,45
    1760:	00f400a3          	sb	a5,1(s0)
            res2++;
    1764:	00240a13          	addi	s4,s0,2
            fpart_f = -(fpart_f);
    1768:	800007b7          	lui	a5,0x80000
    176c:	0097c4b3          	xor	s1,a5,s1
    1770:	f7dff06f          	j	16ec <ftoa+0x9c>
        itos((int)fpart_f, res2);
    1774:	00048513          	mv	a0,s1
    1778:	63c010ef          	jal	ra,2db4 <__fixsfsi>
    177c:	000a0593          	mv	a1,s4
    1780:	e51ff0ef          	jal	ra,15d0 <itos>
    }
    1784:	01c12083          	lw	ra,28(sp)
    1788:	01812403          	lw	s0,24(sp)
    178c:	01412483          	lw	s1,20(sp)
    1790:	01012903          	lw	s2,16(sp)
    1794:	00c12983          	lw	s3,12(sp)
    1798:	00812a03          	lw	s4,8(sp)
    179c:	02010113          	addi	sp,sp,32
    17a0:	00008067          	ret

000017a4 <print_float>:
    {
    17a4:	fc010113          	addi	sp,sp,-64
    17a8:	02112e23          	sw	ra,60(sp)
    17ac:	02812c23          	sw	s0,56(sp)
        ftoa(val, sval, fval);
    17b0:	00c10693          	addi	a3,sp,12
    17b4:	01810613          	addi	a2,sp,24
    17b8:	e99ff0ef          	jal	ra,1650 <ftoa>
        if (fval[1] == '-')
    17bc:	00d14703          	lbu	a4,13(sp)
    17c0:	02d00793          	li	a5,45
    17c4:	06f70663          	beq	a4,a5,1830 <print_float+0x8c>
        neg=0;
    17c8:	00000413          	li	s0,0
        strcat(sval, fval);
    17cc:	00c10593          	addi	a1,sp,12
    17d0:	01810513          	addi	a0,sp,24
    17d4:	9d5ff0ef          	jal	ra,11a8 <strcat>
        if ((sval[0] != '-') && (neg == 1))
    17d8:	01814703          	lbu	a4,24(sp)
    17dc:	02d00793          	li	a5,45
    17e0:	00f70463          	beq	a4,a5,17e8 <print_float+0x44>
    17e4:	08041263          	bnez	s0,1868 <print_float+0xc4>
        _putchar_s(sval);
    17e8:	01810513          	addi	a0,sp,24
    17ec:	b81ff0ef          	jal	ra,136c <_putchar_s>
    }
    17f0:	03c12083          	lw	ra,60(sp)
    17f4:	03812403          	lw	s0,56(sp)
    17f8:	04010113          	addi	sp,sp,64
    17fc:	00008067          	ret
                fval[i-1] = fval[i];
    1800:	fff78713          	addi	a4,a5,-1 # 7fffffff <__freertos_irq_stack_top+0x7fdf9b5f>
    1804:	03010693          	addi	a3,sp,48
    1808:	00f686b3          	add	a3,a3,a5
    180c:	fdc6c683          	lbu	a3,-36(a3)
    1810:	03010613          	addi	a2,sp,48
    1814:	00e60733          	add	a4,a2,a4
    1818:	fcd70e23          	sb	a3,-36(a4)
                i++;
    181c:	00178793          	addi	a5,a5,1
            while (i<10)
    1820:	00900713          	li	a4,9
    1824:	fcf75ee3          	bge	a4,a5,1800 <print_float+0x5c>
            neg = 1;
    1828:	00100413          	li	s0,1
    182c:	fa1ff06f          	j	17cc <print_float+0x28>
        i=2;
    1830:	00200793          	li	a5,2
    1834:	fedff06f          	j	1820 <print_float+0x7c>
                sval[j+1] = sval[j];
    1838:	00178713          	addi	a4,a5,1
    183c:	03010693          	addi	a3,sp,48
    1840:	00f686b3          	add	a3,a3,a5
    1844:	fe86c683          	lbu	a3,-24(a3)
    1848:	03010613          	addi	a2,sp,48
    184c:	00e60733          	add	a4,a2,a4
    1850:	fed70423          	sb	a3,-24(a4)
                j--;
    1854:	fff78793          	addi	a5,a5,-1
            while (j>=0)
    1858:	fe07d0e3          	bgez	a5,1838 <print_float+0x94>
            sval[0] = '-';
    185c:	02d00793          	li	a5,45
    1860:	00f10c23          	sb	a5,24(sp)
    1864:	f85ff06f          	j	17e8 <print_float+0x44>
        j=19;
    1868:	01300793          	li	a5,19
    186c:	fedff06f          	j	1858 <print_float+0xb4>

00001870 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    1870:	fc010113          	addi	sp,sp,-64
    1874:	00112e23          	sw	ra,28(sp)
    1878:	00812c23          	sw	s0,24(sp)
    187c:	00912a23          	sw	s1,20(sp)
    1880:	00050493          	mv	s1,a0
    1884:	02b12223          	sw	a1,36(sp)
    1888:	02c12423          	sw	a2,40(sp)
    188c:	02d12623          	sw	a3,44(sp)
    1890:	02e12823          	sw	a4,48(sp)
    1894:	02f12a23          	sw	a5,52(sp)
    1898:	03012c23          	sw	a6,56(sp)
    189c:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    18a0:	02410793          	addi	a5,sp,36
    18a4:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    18a8:	00000413          	li	s0,0
    18ac:	01c0006f          	j	18c8 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    18b0:	00c12783          	lw	a5,12(sp)
    18b4:	00478713          	addi	a4,a5,4
    18b8:	00e12623          	sw	a4,12(sp)
    18bc:	0007a503          	lw	a0,0(a5)
    18c0:	b89ff0ef          	jal	ra,1448 <bsp_printf_c>
        for (i = 0; format[i]; i++)
    18c4:	00140413          	addi	s0,s0,1
    18c8:	008487b3          	add	a5,s1,s0
    18cc:	0007c503          	lbu	a0,0(a5)
    18d0:	0c050c63          	beqz	a0,19a8 <bsp_printf+0x138>
            if (format[i] == '%') {
    18d4:	02500793          	li	a5,37
    18d8:	06f50663          	beq	a0,a5,1944 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    18dc:	b6dff0ef          	jal	ra,1448 <bsp_printf_c>
    18e0:	fe5ff06f          	j	18c4 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    18e4:	00c12783          	lw	a5,12(sp)
    18e8:	00478713          	addi	a4,a5,4
    18ec:	00e12623          	sw	a4,12(sp)
    18f0:	0007a503          	lw	a0,0(a5)
    18f4:	b71ff0ef          	jal	ra,1464 <bsp_printf_s>
                        break;
    18f8:	fcdff06f          	j	18c4 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    18fc:	00c12783          	lw	a5,12(sp)
    1900:	00478713          	addi	a4,a5,4
    1904:	00e12623          	sw	a4,12(sp)
    1908:	0007a503          	lw	a0,0(a5)
    190c:	b71ff0ef          	jal	ra,147c <bsp_printf_d>
                        break;
    1910:	fb5ff06f          	j	18c4 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    1914:	00c12783          	lw	a5,12(sp)
    1918:	00478713          	addi	a4,a5,4
    191c:	00e12623          	sw	a4,12(sp)
    1920:	0007a503          	lw	a0,0(a5)
    1924:	c19ff0ef          	jal	ra,153c <bsp_printf_X>
                        break;
    1928:	f9dff06f          	j	18c4 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    192c:	00c12783          	lw	a5,12(sp)
    1930:	00478713          	addi	a4,a5,4
    1934:	00e12623          	sw	a4,12(sp)
    1938:	0007a503          	lw	a0,0(a5)
    193c:	bc1ff0ef          	jal	ra,14fc <bsp_printf_x>
                        break;
    1940:	f85ff06f          	j	18c4 <bsp_printf+0x54>
                while (format[++i]) {
    1944:	00140413          	addi	s0,s0,1
    1948:	008487b3          	add	a5,s1,s0
    194c:	0007c783          	lbu	a5,0(a5)
    1950:	f6078ae3          	beqz	a5,18c4 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    1954:	06300713          	li	a4,99
    1958:	f4e78ce3          	beq	a5,a4,18b0 <bsp_printf+0x40>
                    else if (format[i] == 's') {
    195c:	07300713          	li	a4,115
    1960:	f8e782e3          	beq	a5,a4,18e4 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    1964:	06400713          	li	a4,100
    1968:	f8e78ae3          	beq	a5,a4,18fc <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    196c:	05800713          	li	a4,88
    1970:	fae782e3          	beq	a5,a4,1914 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    1974:	07800713          	li	a4,120
    1978:	fae78ae3          	beq	a5,a4,192c <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    197c:	06600713          	li	a4,102
    1980:	fce792e3          	bne	a5,a4,1944 <bsp_printf+0xd4>
                        print_float(va_arg(ap,double));
    1984:	00c12783          	lw	a5,12(sp)
    1988:	00778793          	addi	a5,a5,7
    198c:	ff87f793          	andi	a5,a5,-8
    1990:	00878713          	addi	a4,a5,8
    1994:	00e12623          	sw	a4,12(sp)
    1998:	0007a503          	lw	a0,0(a5)
    199c:	0047a583          	lw	a1,4(a5)
    19a0:	e05ff0ef          	jal	ra,17a4 <print_float>
                        break;
    19a4:	f21ff06f          	j	18c4 <bsp_printf+0x54>

        va_end(ap);
    }
    19a8:	01c12083          	lw	ra,28(sp)
    19ac:	01812403          	lw	s0,24(sp)
    19b0:	01412483          	lw	s1,20(sp)
    19b4:	04010113          	addi	sp,sp,64
    19b8:	00008067          	ret

000019bc <soft_fir>:
void soft_fir() {
	   int signal_length = sizeof(input_signal) / sizeof(input_signal[0]);


	    // 4. 循环处理每一个输入样本
	    for (int n = 0; n < signal_length; n++) {
    19bc:	00000593          	li	a1,0
    19c0:	0740006f          	j	1a34 <soft_fir+0x78>
	        // 获取当前的新输入样本
	         uint8_t current_input = input_signal[n];

	        // a. 更新历史缓冲区：将所有样本向后移动一位
	        for (int i = 7; i > 0; i--) {
	            x[i] = x[i-1];
    19c4:	fff70693          	addi	a3,a4,-1
    19c8:	83c18793          	addi	a5,gp,-1988 # 6484 <x>
    19cc:	00d78633          	add	a2,a5,a3
    19d0:	00064603          	lbu	a2,0(a2)
    19d4:	00e787b3          	add	a5,a5,a4
    19d8:	00c78023          	sb	a2,0(a5)
	        for (int i = 7; i > 0; i--) {
    19dc:	00068713          	mv	a4,a3
    19e0:	fee042e3          	bgtz	a4,19c4 <soft_fir+0x8>
	        }
	        // 将新样本存入缓冲区最前端
	        x[0] = current_input;
    19e4:	82a18e23          	sb	a0,-1988(gp) # 6484 <x>

	        // b. 执行FIR核心计算：卷积求和
	        // y[n] = h[0]*x[0] + h[1]*x[1] + ... + h[7]*x[7]
	        // 使用一个32位无符号整数作为累加器，防止中间计算结果溢出
	        uint32_t sum = 0;
	        for (int i = 0; i < 8; i++) {
    19e8:	00000713          	li	a4,0
	        uint32_t sum = 0;
    19ec:	00000613          	li	a2,0
	        for (int i = 0; i < 8; i++) {
    19f0:	0280006f          	j	1a18 <soft_fir+0x5c>
	            sum += h[i] * x[i];
    19f4:	82818793          	addi	a5,gp,-2008 # 6470 <h>
    19f8:	00e787b3          	add	a5,a5,a4
    19fc:	0007c683          	lbu	a3,0(a5)
    1a00:	83c18793          	addi	a5,gp,-1988 # 6484 <x>
    1a04:	00e787b3          	add	a5,a5,a4
    1a08:	0007c783          	lbu	a5,0(a5)
    1a0c:	02f687b3          	mul	a5,a3,a5
    1a10:	00f60633          	add	a2,a2,a5
	        for (int i = 0; i < 8; i++) {
    1a14:	00170713          	addi	a4,a4,1
    1a18:	00700793          	li	a5,7
    1a1c:	fce7dce3          	bge	a5,a4,19f4 <soft_fir+0x38>
	        }

	        // c. 归一化/缩放输出
	        // 对于移动平均，需要除以系数的个数（8）。
	        // 使用位运算右移3位 (>> 3) 来代替除以8，效率更高。
	        uint8_t output = (uint8_t)(sum >> 3);
    1a20:	00365613          	srli	a2,a2,0x3

	        // d. 打印结果
	        output_signal[n] = output;
    1a24:	84418793          	addi	a5,gp,-1980 # 648c <output_signal>
    1a28:	00b787b3          	add	a5,a5,a1
    1a2c:	00c78023          	sb	a2,0(a5)
	    for (int n = 0; n < signal_length; n++) {
    1a30:	00158593          	addi	a1,a1,1
    1a34:	01100793          	li	a5,17
    1a38:	00b7ce63          	blt	a5,a1,1a54 <soft_fir+0x98>
	         uint8_t current_input = input_signal[n];
    1a3c:	000067b7          	lui	a5,0x6
    1a40:	01878793          	addi	a5,a5,24 # 6018 <input_signal>
    1a44:	00b787b3          	add	a5,a5,a1
    1a48:	0007c503          	lbu	a0,0(a5)
	        for (int i = 7; i > 0; i--) {
    1a4c:	00700713          	li	a4,7
    1a50:	f91ff06f          	j	19e0 <soft_fir+0x24>
	    }
}
    1a54:	00008067          	ret

00001a58 <main>:
int main() {
    1a58:	ff010113          	addi	sp,sp,-16
    1a5c:	00112623          	sw	ra,12(sp)
    1a60:	00812423          	sw	s0,8(sp)
    1a64:	00912223          	sw	s1,4(sp)
    1a68:	01212023          	sw	s2,0(sp)
	bsp_printf("8-stage fir filter, input size: %d\n\r", sizeof(input_signal));
    1a6c:	01200593          	li	a1,18
    1a70:	00006537          	lui	a0,0x6
    1a74:	cd850513          	addi	a0,a0,-808 # 5cd8 <_data+0x2c>
    1a78:	df9ff0ef          	jal	ra,1870 <bsp_printf>
	//soft
	u32 beginTicks = clint_getTime(BSP_CLINT);
    1a7c:	f8b00537          	lui	a0,0xf8b00
    1a80:	8a1ff0ef          	jal	ra,1320 <clint_getTime>
    1a84:	00050493          	mv	s1,a0
	soft_fir();
    1a88:	f35ff0ef          	jal	ra,19bc <soft_fir>
	u32 endTicks = clint_getTime(BSP_CLINT);
    1a8c:	f8b00537          	lui	a0,0xf8b00
    1a90:	891ff0ef          	jal	ra,1320 <clint_getTime>
    1a94:	00050913          	mv	s2,a0


    bsp_printf("Input -> Output\n\r");
    1a98:	00006537          	lui	a0,0x6
    1a9c:	d0050513          	addi	a0,a0,-768 # 5d00 <_data+0x54>
    1aa0:	dd1ff0ef          	jal	ra,1870 <bsp_printf>
    for(int i = 0; i < sizeof(input_signal); i++) {
    1aa4:	00000413          	li	s0,0
    1aa8:	01100793          	li	a5,17
    1aac:	0287ea63          	bltu	a5,s0,1ae0 <main+0x88>
    	bsp_printf("%d -> %d\n\r", input_signal[i], output_signal[i]);
    1ab0:	000067b7          	lui	a5,0x6
    1ab4:	01878793          	addi	a5,a5,24 # 6018 <input_signal>
    1ab8:	008787b3          	add	a5,a5,s0
    1abc:	84418713          	addi	a4,gp,-1980 # 648c <output_signal>
    1ac0:	00870733          	add	a4,a4,s0
    1ac4:	00074603          	lbu	a2,0(a4)
    1ac8:	0007c583          	lbu	a1,0(a5)
    1acc:	00006537          	lui	a0,0x6
    1ad0:	d1450513          	addi	a0,a0,-748 # 5d14 <_data+0x68>
    1ad4:	d9dff0ef          	jal	ra,1870 <bsp_printf>
    for(int i = 0; i < sizeof(input_signal); i++) {
    1ad8:	00140413          	addi	s0,s0,1
    1adc:	fcdff06f          	j	1aa8 <main+0x50>
    }
    bsp_printf("soft time cost: %d\n\r", endTicks - beginTicks);
    1ae0:	409905b3          	sub	a1,s2,s1
    1ae4:	00006537          	lui	a0,0x6
    1ae8:	d2050513          	addi	a0,a0,-736 # 5d20 <_data+0x74>
    1aec:	d85ff0ef          	jal	ra,1870 <bsp_printf>

    //custom instruction



    bsp_printf("done\n\r");
    1af0:	00006537          	lui	a0,0x6
    1af4:	d3850513          	addi	a0,a0,-712 # 5d38 <_data+0x8c>
    1af8:	d79ff0ef          	jal	ra,1870 <bsp_printf>
    return 0;
}
    1afc:	00000513          	li	a0,0
    1b00:	00c12083          	lw	ra,12(sp)
    1b04:	00812403          	lw	s0,8(sp)
    1b08:	00412483          	lw	s1,4(sp)
    1b0c:	00012903          	lw	s2,0(sp)
    1b10:	01010113          	addi	sp,sp,16
    1b14:	00008067          	ret

00001b18 <__ledf2>:
    1b18:	0145d713          	srli	a4,a1,0x14
    1b1c:	001007b7          	lui	a5,0x100
    1b20:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf93b7>
    1b24:	0146d813          	srli	a6,a3,0x14
    1b28:	7ff77713          	andi	a4,a4,2047
    1b2c:	7ff00893          	li	a7,2047
    1b30:	00b7f333          	and	t1,a5,a1
    1b34:	00050e13          	mv	t3,a0
    1b38:	00d7f7b3          	and	a5,a5,a3
    1b3c:	01f5d593          	srli	a1,a1,0x1f
    1b40:	00060e93          	mv	t4,a2
    1b44:	7ff87813          	andi	a6,a6,2047
    1b48:	01f6d693          	srli	a3,a3,0x1f
    1b4c:	05170a63          	beq	a4,a7,1ba0 <__ledf2+0x88>
    1b50:	03180263          	beq	a6,a7,1b74 <__ledf2+0x5c>
    1b54:	04071c63          	bnez	a4,1bac <__ledf2+0x94>
    1b58:	00a36533          	or	a0,t1,a0
    1b5c:	02081663          	bnez	a6,1b88 <__ledf2+0x70>
    1b60:	00c7e633          	or	a2,a5,a2
    1b64:	02061263          	bnez	a2,1b88 <__ledf2+0x70>
    1b68:	00000693          	li	a3,0
    1b6c:	06050263          	beqz	a0,1bd0 <__ledf2+0xb8>
    1b70:	0200006f          	j	1b90 <__ledf2+0x78>
    1b74:	00c7e8b3          	or	a7,a5,a2
    1b78:	fc088ee3          	beqz	a7,1b54 <__ledf2+0x3c>
    1b7c:	00200693          	li	a3,2
    1b80:	00068513          	mv	a0,a3
    1b84:	00008067          	ret
    1b88:	04050263          	beqz	a0,1bcc <__ledf2+0xb4>
    1b8c:	04d58e63          	beq	a1,a3,1be8 <__ledf2+0xd0>
    1b90:	00100693          	li	a3,1
    1b94:	02058e63          	beqz	a1,1bd0 <__ledf2+0xb8>
    1b98:	fff00693          	li	a3,-1
    1b9c:	0340006f          	j	1bd0 <__ledf2+0xb8>
    1ba0:	00a36533          	or	a0,t1,a0
    1ba4:	fc051ce3          	bnez	a0,1b7c <__ledf2+0x64>
    1ba8:	02e80863          	beq	a6,a4,1bd8 <__ledf2+0xc0>
    1bac:	00081663          	bnez	a6,1bb8 <__ledf2+0xa0>
    1bb0:	00c7e633          	or	a2,a5,a2
    1bb4:	fc060ee3          	beqz	a2,1b90 <__ledf2+0x78>
    1bb8:	fcd59ce3          	bne	a1,a3,1b90 <__ledf2+0x78>
    1bbc:	02e85663          	bge	a6,a4,1be8 <__ledf2+0xd0>
    1bc0:	fc069ce3          	bnez	a3,1b98 <__ledf2+0x80>
    1bc4:	00100693          	li	a3,1
    1bc8:	0080006f          	j	1bd0 <__ledf2+0xb8>
    1bcc:	fc0686e3          	beqz	a3,1b98 <__ledf2+0x80>
    1bd0:	00068513          	mv	a0,a3
    1bd4:	00008067          	ret
    1bd8:	00c7e633          	or	a2,a5,a2
    1bdc:	fc060ee3          	beqz	a2,1bb8 <__ledf2+0xa0>
    1be0:	00200693          	li	a3,2
    1be4:	f9dff06f          	j	1b80 <__ledf2+0x68>
    1be8:	01074a63          	blt	a4,a6,1bfc <__ledf2+0xe4>
    1bec:	fa67e2e3          	bltu	a5,t1,1b90 <__ledf2+0x78>
    1bf0:	00f30c63          	beq	t1,a5,1c08 <__ledf2+0xf0>
    1bf4:	00000693          	li	a3,0
    1bf8:	fcf37ce3          	bgeu	t1,a5,1bd0 <__ledf2+0xb8>
    1bfc:	f8058ee3          	beqz	a1,1b98 <__ledf2+0x80>
    1c00:	00058693          	mv	a3,a1
    1c04:	fcdff06f          	j	1bd0 <__ledf2+0xb8>
    1c08:	f9cee4e3          	bltu	t4,t3,1b90 <__ledf2+0x78>
    1c0c:	00000693          	li	a3,0
    1c10:	fdde70e3          	bgeu	t3,t4,1bd0 <__ledf2+0xb8>
    1c14:	fe9ff06f          	j	1bfc <__ledf2+0xe4>

00001c18 <__muldf3>:
    1c18:	fc010113          	addi	sp,sp,-64
    1c1c:	0145d793          	srli	a5,a1,0x14
    1c20:	02812c23          	sw	s0,56(sp)
    1c24:	03212823          	sw	s2,48(sp)
    1c28:	03412423          	sw	s4,40(sp)
    1c2c:	00c59413          	slli	s0,a1,0xc
    1c30:	02112e23          	sw	ra,60(sp)
    1c34:	02912a23          	sw	s1,52(sp)
    1c38:	03312623          	sw	s3,44(sp)
    1c3c:	03512223          	sw	s5,36(sp)
    1c40:	03612023          	sw	s6,32(sp)
    1c44:	01712e23          	sw	s7,28(sp)
    1c48:	7ff7f793          	andi	a5,a5,2047
    1c4c:	00050913          	mv	s2,a0
    1c50:	00c45413          	srli	s0,s0,0xc
    1c54:	01f5da13          	srli	s4,a1,0x1f
    1c58:	14078c63          	beqz	a5,1db0 <__muldf3+0x198>
    1c5c:	7ff00713          	li	a4,2047
    1c60:	20e78863          	beq	a5,a4,1e70 <__muldf3+0x258>
    1c64:	00341513          	slli	a0,s0,0x3
    1c68:	01d95413          	srli	s0,s2,0x1d
    1c6c:	00a46433          	or	s0,s0,a0
    1c70:	00800537          	lui	a0,0x800
    1c74:	00a46433          	or	s0,s0,a0
    1c78:	00391493          	slli	s1,s2,0x3
    1c7c:	c0178b13          	addi	s6,a5,-1023
    1c80:	00000993          	li	s3,0
    1c84:	00000b93          	li	s7,0
    1c88:	0146d793          	srli	a5,a3,0x14
    1c8c:	00c69913          	slli	s2,a3,0xc
    1c90:	7ff7f793          	andi	a5,a5,2047
    1c94:	00c95913          	srli	s2,s2,0xc
    1c98:	01f6da93          	srli	s5,a3,0x1f
    1c9c:	18078263          	beqz	a5,1e20 <__muldf3+0x208>
    1ca0:	7ff00713          	li	a4,2047
    1ca4:	04e78c63          	beq	a5,a4,1cfc <__muldf3+0xe4>
    1ca8:	00391513          	slli	a0,s2,0x3
    1cac:	01d65913          	srli	s2,a2,0x1d
    1cb0:	00a96933          	or	s2,s2,a0
    1cb4:	c0178793          	addi	a5,a5,-1023
    1cb8:	00800537          	lui	a0,0x800
    1cbc:	00a96933          	or	s2,s2,a0
    1cc0:	00361593          	slli	a1,a2,0x3
    1cc4:	00fb0b33          	add	s6,s6,a5
    1cc8:	00000813          	li	a6,0
    1ccc:	015a46b3          	xor	a3,s4,s5
    1cd0:	00f00793          	li	a5,15
    1cd4:	00068513          	mv	a0,a3
    1cd8:	001b0613          	addi	a2,s6,1
    1cdc:	2137ec63          	bltu	a5,s3,1ef4 <__muldf3+0x2dc>
    1ce0:	00004797          	auipc	a5,0x4
    1ce4:	06078793          	addi	a5,a5,96 # 5d40 <_data+0x94>
    1ce8:	00299993          	slli	s3,s3,0x2
    1cec:	00f989b3          	add	s3,s3,a5
    1cf0:	0009a703          	lw	a4,0(s3)
    1cf4:	00f70733          	add	a4,a4,a5
    1cf8:	00070067          	jr	a4
    1cfc:	00c965b3          	or	a1,s2,a2
    1d00:	7ffb0b13          	addi	s6,s6,2047
    1d04:	1c059063          	bnez	a1,1ec4 <__muldf3+0x2ac>
    1d08:	0029e993          	ori	s3,s3,2
    1d0c:	00000913          	li	s2,0
    1d10:	00200813          	li	a6,2
    1d14:	fb9ff06f          	j	1ccc <__muldf3+0xb4>
    1d18:	00000693          	li	a3,0
    1d1c:	7ff00793          	li	a5,2047
    1d20:	00080437          	lui	s0,0x80
    1d24:	00000493          	li	s1,0
    1d28:	00c41413          	slli	s0,s0,0xc
    1d2c:	01479793          	slli	a5,a5,0x14
    1d30:	00c45413          	srli	s0,s0,0xc
    1d34:	01f69693          	slli	a3,a3,0x1f
    1d38:	00f46433          	or	s0,s0,a5
    1d3c:	00d46433          	or	s0,s0,a3
    1d40:	00040593          	mv	a1,s0
    1d44:	03c12083          	lw	ra,60(sp)
    1d48:	03812403          	lw	s0,56(sp)
    1d4c:	00048513          	mv	a0,s1
    1d50:	03012903          	lw	s2,48(sp)
    1d54:	03412483          	lw	s1,52(sp)
    1d58:	02c12983          	lw	s3,44(sp)
    1d5c:	02812a03          	lw	s4,40(sp)
    1d60:	02412a83          	lw	s5,36(sp)
    1d64:	02012b03          	lw	s6,32(sp)
    1d68:	01c12b83          	lw	s7,28(sp)
    1d6c:	04010113          	addi	sp,sp,64
    1d70:	00008067          	ret
    1d74:	000a8513          	mv	a0,s5
    1d78:	00090413          	mv	s0,s2
    1d7c:	00058493          	mv	s1,a1
    1d80:	00080b93          	mv	s7,a6
    1d84:	00200793          	li	a5,2
    1d88:	14fb8c63          	beq	s7,a5,1ee0 <__muldf3+0x2c8>
    1d8c:	00300793          	li	a5,3
    1d90:	f8fb84e3          	beq	s7,a5,1d18 <__muldf3+0x100>
    1d94:	00100793          	li	a5,1
    1d98:	00050693          	mv	a3,a0
    1d9c:	4cfb9463          	bne	s7,a5,2264 <__muldf3+0x64c>
    1da0:	00000793          	li	a5,0
    1da4:	00000413          	li	s0,0
    1da8:	00000493          	li	s1,0
    1dac:	f7dff06f          	j	1d28 <__muldf3+0x110>
    1db0:	00a464b3          	or	s1,s0,a0
    1db4:	0e048e63          	beqz	s1,1eb0 <__muldf3+0x298>
    1db8:	00d12623          	sw	a3,12(sp)
    1dbc:	00c12423          	sw	a2,8(sp)
    1dc0:	38040863          	beqz	s0,2150 <__muldf3+0x538>
    1dc4:	00040513          	mv	a0,s0
    1dc8:	354010ef          	jal	ra,311c <__clzsi2>
    1dcc:	00812603          	lw	a2,8(sp)
    1dd0:	00c12683          	lw	a3,12(sp)
    1dd4:	00050793          	mv	a5,a0
    1dd8:	ff550593          	addi	a1,a0,-11 # 7ffff5 <__freertos_irq_stack_top+0x5f9b55>
    1ddc:	01d00713          	li	a4,29
    1de0:	ff878493          	addi	s1,a5,-8
    1de4:	40b70733          	sub	a4,a4,a1
    1de8:	00941433          	sll	s0,s0,s1
    1dec:	00e95733          	srl	a4,s2,a4
    1df0:	00876433          	or	s0,a4,s0
    1df4:	009914b3          	sll	s1,s2,s1
    1df8:	c0d00b13          	li	s6,-1011
    1dfc:	40fb0b33          	sub	s6,s6,a5
    1e00:	0146d793          	srli	a5,a3,0x14
    1e04:	00c69913          	slli	s2,a3,0xc
    1e08:	7ff7f793          	andi	a5,a5,2047
    1e0c:	00000993          	li	s3,0
    1e10:	00000b93          	li	s7,0
    1e14:	00c95913          	srli	s2,s2,0xc
    1e18:	01f6da93          	srli	s5,a3,0x1f
    1e1c:	e80792e3          	bnez	a5,1ca0 <__muldf3+0x88>
    1e20:	00c965b3          	or	a1,s2,a2
    1e24:	06058463          	beqz	a1,1e8c <__muldf3+0x274>
    1e28:	2e090c63          	beqz	s2,2120 <__muldf3+0x508>
    1e2c:	00090513          	mv	a0,s2
    1e30:	00c12423          	sw	a2,8(sp)
    1e34:	2e8010ef          	jal	ra,311c <__clzsi2>
    1e38:	00812603          	lw	a2,8(sp)
    1e3c:	00050793          	mv	a5,a0
    1e40:	ff550693          	addi	a3,a0,-11
    1e44:	01d00713          	li	a4,29
    1e48:	ff878593          	addi	a1,a5,-8
    1e4c:	40d70733          	sub	a4,a4,a3
    1e50:	00b91933          	sll	s2,s2,a1
    1e54:	00e65733          	srl	a4,a2,a4
    1e58:	01276933          	or	s2,a4,s2
    1e5c:	00b615b3          	sll	a1,a2,a1
    1e60:	40fb07b3          	sub	a5,s6,a5
    1e64:	c0d78b13          	addi	s6,a5,-1011
    1e68:	00000813          	li	a6,0
    1e6c:	e61ff06f          	j	1ccc <__muldf3+0xb4>
    1e70:	00a464b3          	or	s1,s0,a0
    1e74:	02049463          	bnez	s1,1e9c <__muldf3+0x284>
    1e78:	00000413          	li	s0,0
    1e7c:	00800993          	li	s3,8
    1e80:	7ff00b13          	li	s6,2047
    1e84:	00200b93          	li	s7,2
    1e88:	e01ff06f          	j	1c88 <__muldf3+0x70>
    1e8c:	0019e993          	ori	s3,s3,1
    1e90:	00000913          	li	s2,0
    1e94:	00100813          	li	a6,1
    1e98:	e35ff06f          	j	1ccc <__muldf3+0xb4>
    1e9c:	00050493          	mv	s1,a0
    1ea0:	00c00993          	li	s3,12
    1ea4:	7ff00b13          	li	s6,2047
    1ea8:	00300b93          	li	s7,3
    1eac:	dddff06f          	j	1c88 <__muldf3+0x70>
    1eb0:	00000413          	li	s0,0
    1eb4:	00400993          	li	s3,4
    1eb8:	00000b13          	li	s6,0
    1ebc:	00100b93          	li	s7,1
    1ec0:	dc9ff06f          	j	1c88 <__muldf3+0x70>
    1ec4:	0039e993          	ori	s3,s3,3
    1ec8:	00060593          	mv	a1,a2
    1ecc:	00300813          	li	a6,3
    1ed0:	dfdff06f          	j	1ccc <__muldf3+0xb4>
    1ed4:	00200793          	li	a5,2
    1ed8:	000a0513          	mv	a0,s4
    1edc:	eafb98e3          	bne	s7,a5,1d8c <__muldf3+0x174>
    1ee0:	00050693          	mv	a3,a0
    1ee4:	7ff00793          	li	a5,2047
    1ee8:	00000413          	li	s0,0
    1eec:	00000493          	li	s1,0
    1ef0:	e39ff06f          	j	1d28 <__muldf3+0x110>
    1ef4:	00010e37          	lui	t3,0x10
    1ef8:	fffe0713          	addi	a4,t3,-1 # ffff <__global_pointer$+0x93b7>
    1efc:	0104d793          	srli	a5,s1,0x10
    1f00:	0105d813          	srli	a6,a1,0x10
    1f04:	00e4f4b3          	and	s1,s1,a4
    1f08:	00e5f5b3          	and	a1,a1,a4
    1f0c:	02958733          	mul	a4,a1,s1
    1f10:	02b78333          	mul	t1,a5,a1
    1f14:	01075513          	srli	a0,a4,0x10
    1f18:	029808b3          	mul	a7,a6,s1
    1f1c:	006888b3          	add	a7,a7,t1
    1f20:	01150533          	add	a0,a0,a7
    1f24:	03078f33          	mul	t5,a5,a6
    1f28:	00657463          	bgeu	a0,t1,1f30 <__muldf3+0x318>
    1f2c:	01cf0f33          	add	t5,t5,t3
    1f30:	00010eb7          	lui	t4,0x10
    1f34:	fffe8893          	addi	a7,t4,-1 # ffff <__global_pointer$+0x93b7>
    1f38:	01095293          	srli	t0,s2,0x10
    1f3c:	01197933          	and	s2,s2,a7
    1f40:	01157333          	and	t1,a0,a7
    1f44:	01177733          	and	a4,a4,a7
    1f48:	01031313          	slli	t1,t1,0x10
    1f4c:	029908b3          	mul	a7,s2,s1
    1f50:	00e30333          	add	t1,t1,a4
    1f54:	01055513          	srli	a0,a0,0x10
    1f58:	03278fb3          	mul	t6,a5,s2
    1f5c:	0108de13          	srli	t3,a7,0x10
    1f60:	029284b3          	mul	s1,t0,s1
    1f64:	01f484b3          	add	s1,s1,t6
    1f68:	009e04b3          	add	s1,t3,s1
    1f6c:	02578733          	mul	a4,a5,t0
    1f70:	01f4f463          	bgeu	s1,t6,1f78 <__muldf3+0x360>
    1f74:	01d70733          	add	a4,a4,t4
    1f78:	000109b7          	lui	s3,0x10
    1f7c:	fff98e13          	addi	t3,s3,-1 # ffff <__global_pointer$+0x93b7>
    1f80:	01c477b3          	and	a5,s0,t3
    1f84:	01c4feb3          	and	t4,s1,t3
    1f88:	01045f93          	srli	t6,s0,0x10
    1f8c:	0104d493          	srli	s1,s1,0x10
    1f90:	01c8f8b3          	and	a7,a7,t3
    1f94:	02f583b3          	mul	t2,a1,a5
    1f98:	00e48e33          	add	t3,s1,a4
    1f9c:	010e9e93          	slli	t4,t4,0x10
    1fa0:	011e8eb3          	add	t4,t4,a7
    1fa4:	01d50533          	add	a0,a0,t4
    1fa8:	02f80733          	mul	a4,a6,a5
    1fac:	0103d893          	srli	a7,t2,0x10
    1fb0:	02bf85b3          	mul	a1,t6,a1
    1fb4:	00b70733          	add	a4,a4,a1
    1fb8:	00e888b3          	add	a7,a7,a4
    1fbc:	03f80833          	mul	a6,a6,t6
    1fc0:	00b8f463          	bgeu	a7,a1,1fc8 <__muldf3+0x3b0>
    1fc4:	01380833          	add	a6,a6,s3
    1fc8:	00010737          	lui	a4,0x10
    1fcc:	fff70413          	addi	s0,a4,-1 # ffff <__global_pointer$+0x93b7>
    1fd0:	0088f5b3          	and	a1,a7,s0
    1fd4:	0108d893          	srli	a7,a7,0x10
    1fd8:	010888b3          	add	a7,a7,a6
    1fdc:	0083f3b3          	and	t2,t2,s0
    1fe0:	01059593          	slli	a1,a1,0x10
    1fe4:	02f90833          	mul	a6,s2,a5
    1fe8:	007585b3          	add	a1,a1,t2
    1fec:	032f8933          	mul	s2,t6,s2
    1ff0:	01085413          	srli	s0,a6,0x10
    1ff4:	02f287b3          	mul	a5,t0,a5
    1ff8:	012787b3          	add	a5,a5,s2
    1ffc:	00f407b3          	add	a5,s0,a5
    2000:	03f28fb3          	mul	t6,t0,t6
    2004:	0127f463          	bgeu	a5,s2,200c <__muldf3+0x3f4>
    2008:	00ef8fb3          	add	t6,t6,a4
    200c:	000102b7          	lui	t0,0x10
    2010:	fff28293          	addi	t0,t0,-1 # ffff <__global_pointer$+0x93b7>
    2014:	0057f733          	and	a4,a5,t0
    2018:	00587833          	and	a6,a6,t0
    201c:	01071713          	slli	a4,a4,0x10
    2020:	01e50533          	add	a0,a0,t5
    2024:	01070733          	add	a4,a4,a6
    2028:	01d53eb3          	sltu	t4,a0,t4
    202c:	01c70733          	add	a4,a4,t3
    2030:	00b50533          	add	a0,a0,a1
    2034:	01d70433          	add	s0,a4,t4
    2038:	00b535b3          	sltu	a1,a0,a1
    203c:	01140833          	add	a6,s0,a7
    2040:	00b80f33          	add	t5,a6,a1
    2044:	01c73733          	sltu	a4,a4,t3
    2048:	01d43433          	sltu	s0,s0,t4
    204c:	00876433          	or	s0,a4,s0
    2050:	0107d793          	srli	a5,a5,0x10
    2054:	011838b3          	sltu	a7,a6,a7
    2058:	00bf35b3          	sltu	a1,t5,a1
    205c:	00f40433          	add	s0,s0,a5
    2060:	00b8e5b3          	or	a1,a7,a1
    2064:	00951493          	slli	s1,a0,0x9
    2068:	00b40433          	add	s0,s0,a1
    206c:	01f40433          	add	s0,s0,t6
    2070:	0064e4b3          	or	s1,s1,t1
    2074:	00941713          	slli	a4,s0,0x9
    2078:	009034b3          	snez	s1,s1
    207c:	017f5413          	srli	s0,t5,0x17
    2080:	01755513          	srli	a0,a0,0x17
    2084:	009f1793          	slli	a5,t5,0x9
    2088:	00a4e4b3          	or	s1,s1,a0
    208c:	00876433          	or	s0,a4,s0
    2090:	00f4e4b3          	or	s1,s1,a5
    2094:	00741793          	slli	a5,s0,0x7
    2098:	0207d063          	bgez	a5,20b8 <__muldf3+0x4a0>
    209c:	0014d793          	srli	a5,s1,0x1
    20a0:	0014f493          	andi	s1,s1,1
    20a4:	01f41713          	slli	a4,s0,0x1f
    20a8:	0097e4b3          	or	s1,a5,s1
    20ac:	00e4e4b3          	or	s1,s1,a4
    20b0:	00145413          	srli	s0,s0,0x1
    20b4:	00060b13          	mv	s6,a2
    20b8:	3ffb0713          	addi	a4,s6,1023
    20bc:	0ce05063          	blez	a4,217c <__muldf3+0x564>
    20c0:	0074f793          	andi	a5,s1,7
    20c4:	02078063          	beqz	a5,20e4 <__muldf3+0x4cc>
    20c8:	00f4f793          	andi	a5,s1,15
    20cc:	00400613          	li	a2,4
    20d0:	00c78a63          	beq	a5,a2,20e4 <__muldf3+0x4cc>
    20d4:	00448793          	addi	a5,s1,4
    20d8:	0097b4b3          	sltu	s1,a5,s1
    20dc:	00940433          	add	s0,s0,s1
    20e0:	00078493          	mv	s1,a5
    20e4:	00741793          	slli	a5,s0,0x7
    20e8:	0007da63          	bgez	a5,20fc <__muldf3+0x4e4>
    20ec:	ff0007b7          	lui	a5,0xff000
    20f0:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf9b5f>
    20f4:	00f47433          	and	s0,s0,a5
    20f8:	400b0713          	addi	a4,s6,1024
    20fc:	7fe00793          	li	a5,2046
    2100:	14e7ca63          	blt	a5,a4,2254 <__muldf3+0x63c>
    2104:	0034d793          	srli	a5,s1,0x3
    2108:	01d41493          	slli	s1,s0,0x1d
    210c:	00941413          	slli	s0,s0,0x9
    2110:	00f4e4b3          	or	s1,s1,a5
    2114:	00c45413          	srli	s0,s0,0xc
    2118:	7ff77793          	andi	a5,a4,2047
    211c:	c0dff06f          	j	1d28 <__muldf3+0x110>
    2120:	00060513          	mv	a0,a2
    2124:	00c12423          	sw	a2,8(sp)
    2128:	7f5000ef          	jal	ra,311c <__clzsi2>
    212c:	01550693          	addi	a3,a0,21
    2130:	01c00713          	li	a4,28
    2134:	02050793          	addi	a5,a0,32
    2138:	00812603          	lw	a2,8(sp)
    213c:	d0d754e3          	bge	a4,a3,1e44 <__muldf3+0x22c>
    2140:	ff850513          	addi	a0,a0,-8
    2144:	00000593          	li	a1,0
    2148:	00a61933          	sll	s2,a2,a0
    214c:	d15ff06f          	j	1e60 <__muldf3+0x248>
    2150:	7cd000ef          	jal	ra,311c <__clzsi2>
    2154:	01550593          	addi	a1,a0,21
    2158:	01c00713          	li	a4,28
    215c:	02050793          	addi	a5,a0,32
    2160:	00812603          	lw	a2,8(sp)
    2164:	00c12683          	lw	a3,12(sp)
    2168:	c6b75ae3          	bge	a4,a1,1ddc <__muldf3+0x1c4>
    216c:	ff850513          	addi	a0,a0,-8
    2170:	00000493          	li	s1,0
    2174:	00a91433          	sll	s0,s2,a0
    2178:	c81ff06f          	j	1df8 <__muldf3+0x1e0>
    217c:	00100613          	li	a2,1
    2180:	40e60633          	sub	a2,a2,a4
    2184:	06071063          	bnez	a4,21e4 <__muldf3+0x5cc>
    2188:	41eb0793          	addi	a5,s6,1054
    218c:	00f49733          	sll	a4,s1,a5
    2190:	00f417b3          	sll	a5,s0,a5
    2194:	00c4d4b3          	srl	s1,s1,a2
    2198:	0097e4b3          	or	s1,a5,s1
    219c:	00e03733          	snez	a4,a4
    21a0:	00e4e4b3          	or	s1,s1,a4
    21a4:	0074f793          	andi	a5,s1,7
    21a8:	00c45633          	srl	a2,s0,a2
    21ac:	02078063          	beqz	a5,21cc <__muldf3+0x5b4>
    21b0:	00f4f793          	andi	a5,s1,15
    21b4:	00400713          	li	a4,4
    21b8:	00e78a63          	beq	a5,a4,21cc <__muldf3+0x5b4>
    21bc:	00448793          	addi	a5,s1,4
    21c0:	0097b4b3          	sltu	s1,a5,s1
    21c4:	00960633          	add	a2,a2,s1
    21c8:	00078493          	mv	s1,a5
    21cc:	00861793          	slli	a5,a2,0x8
    21d0:	0607d463          	bgez	a5,2238 <__muldf3+0x620>
    21d4:	00100793          	li	a5,1
    21d8:	00000413          	li	s0,0
    21dc:	00000493          	li	s1,0
    21e0:	b49ff06f          	j	1d28 <__muldf3+0x110>
    21e4:	03800793          	li	a5,56
    21e8:	bac7cce3          	blt	a5,a2,1da0 <__muldf3+0x188>
    21ec:	01f00793          	li	a5,31
    21f0:	f8c7dce3          	bge	a5,a2,2188 <__muldf3+0x570>
    21f4:	fe100793          	li	a5,-31
    21f8:	40e78733          	sub	a4,a5,a4
    21fc:	02000793          	li	a5,32
    2200:	00e45733          	srl	a4,s0,a4
    2204:	00f60863          	beq	a2,a5,2214 <__muldf3+0x5fc>
    2208:	43eb0793          	addi	a5,s6,1086
    220c:	00f417b3          	sll	a5,s0,a5
    2210:	00f4e4b3          	or	s1,s1,a5
    2214:	009034b3          	snez	s1,s1
    2218:	00e4e4b3          	or	s1,s1,a4
    221c:	0074f613          	andi	a2,s1,7
    2220:	00000413          	li	s0,0
    2224:	02060063          	beqz	a2,2244 <__muldf3+0x62c>
    2228:	00f4f793          	andi	a5,s1,15
    222c:	00400713          	li	a4,4
    2230:	00000613          	li	a2,0
    2234:	f8e794e3          	bne	a5,a4,21bc <__muldf3+0x5a4>
    2238:	00961413          	slli	s0,a2,0x9
    223c:	00c45413          	srli	s0,s0,0xc
    2240:	01d61613          	slli	a2,a2,0x1d
    2244:	0034d493          	srli	s1,s1,0x3
    2248:	00c4e4b3          	or	s1,s1,a2
    224c:	00000793          	li	a5,0
    2250:	ad9ff06f          	j	1d28 <__muldf3+0x110>
    2254:	7ff00793          	li	a5,2047
    2258:	00000413          	li	s0,0
    225c:	00000493          	li	s1,0
    2260:	ac9ff06f          	j	1d28 <__muldf3+0x110>
    2264:	00060b13          	mv	s6,a2
    2268:	e51ff06f          	j	20b8 <__muldf3+0x4a0>

0000226c <__subdf3>:
    226c:	00100737          	lui	a4,0x100
    2270:	fff70713          	addi	a4,a4,-1 # fffff <__global_pointer$+0xf93b7>
    2274:	fe010113          	addi	sp,sp,-32
    2278:	00b77333          	and	t1,a4,a1
    227c:	0146d893          	srli	a7,a3,0x14
    2280:	00d77733          	and	a4,a4,a3
    2284:	01d65e93          	srli	t4,a2,0x1d
    2288:	00812c23          	sw	s0,24(sp)
    228c:	00912a23          	sw	s1,20(sp)
    2290:	00331313          	slli	t1,t1,0x3
    2294:	0145d493          	srli	s1,a1,0x14
    2298:	01d55793          	srli	a5,a0,0x1d
    229c:	00371713          	slli	a4,a4,0x3
    22a0:	00112e23          	sw	ra,28(sp)
    22a4:	01212823          	sw	s2,16(sp)
    22a8:	01312623          	sw	s3,12(sp)
    22ac:	7ff8f893          	andi	a7,a7,2047
    22b0:	7ff00e13          	li	t3,2047
    22b4:	00eee733          	or	a4,t4,a4
    22b8:	7ff4f493          	andi	s1,s1,2047
    22bc:	01f5d413          	srli	s0,a1,0x1f
    22c0:	0067e333          	or	t1,a5,t1
    22c4:	00351f13          	slli	t5,a0,0x3
    22c8:	01f6d693          	srli	a3,a3,0x1f
    22cc:	00361e93          	slli	t4,a2,0x3
    22d0:	1dc88663          	beq	a7,t3,249c <__subdf3+0x230>
    22d4:	0016c693          	xori	a3,a3,1
    22d8:	411485b3          	sub	a1,s1,a7
    22dc:	16d40863          	beq	s0,a3,244c <__subdf3+0x1e0>
    22e0:	1cb05863          	blez	a1,24b0 <__subdf3+0x244>
    22e4:	20088463          	beqz	a7,24ec <__subdf3+0x280>
    22e8:	008007b7          	lui	a5,0x800
    22ec:	00f76733          	or	a4,a4,a5
    22f0:	67c48a63          	beq	s1,t3,2964 <__subdf3+0x6f8>
    22f4:	03800793          	li	a5,56
    22f8:	3eb7c263          	blt	a5,a1,26dc <__subdf3+0x470>
    22fc:	01f00793          	li	a5,31
    2300:	54b7ca63          	blt	a5,a1,2854 <__subdf3+0x5e8>
    2304:	02000793          	li	a5,32
    2308:	40b787b3          	sub	a5,a5,a1
    230c:	00bed9b3          	srl	s3,t4,a1
    2310:	00f71833          	sll	a6,a4,a5
    2314:	00fe9eb3          	sll	t4,t4,a5
    2318:	01386833          	or	a6,a6,s3
    231c:	00b75733          	srl	a4,a4,a1
    2320:	01d039b3          	snez	s3,t4
    2324:	01386833          	or	a6,a6,s3
    2328:	40e30333          	sub	t1,t1,a4
    232c:	410f09b3          	sub	s3,t5,a6
    2330:	013f37b3          	sltu	a5,t5,s3
    2334:	40f30633          	sub	a2,t1,a5
    2338:	00861793          	slli	a5,a2,0x8
    233c:	2a07d863          	bgez	a5,25ec <__subdf3+0x380>
    2340:	00800937          	lui	s2,0x800
    2344:	fff90913          	addi	s2,s2,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    2348:	01267933          	and	s2,a2,s2
    234c:	36090663          	beqz	s2,26b8 <__subdf3+0x44c>
    2350:	00090513          	mv	a0,s2
    2354:	5c9000ef          	jal	ra,311c <__clzsi2>
    2358:	ff850713          	addi	a4,a0,-8
    235c:	02000793          	li	a5,32
    2360:	40e787b3          	sub	a5,a5,a4
    2364:	00f9d7b3          	srl	a5,s3,a5
    2368:	00e91633          	sll	a2,s2,a4
    236c:	00c7e7b3          	or	a5,a5,a2
    2370:	00e999b3          	sll	s3,s3,a4
    2374:	32974463          	blt	a4,s1,269c <__subdf3+0x430>
    2378:	40970733          	sub	a4,a4,s1
    237c:	00170613          	addi	a2,a4,1
    2380:	01f00693          	li	a3,31
    2384:	44c6ca63          	blt	a3,a2,27d8 <__subdf3+0x56c>
    2388:	02000713          	li	a4,32
    238c:	40c70733          	sub	a4,a4,a2
    2390:	00c9d6b3          	srl	a3,s3,a2
    2394:	00e99833          	sll	a6,s3,a4
    2398:	00e79733          	sll	a4,a5,a4
    239c:	00d76733          	or	a4,a4,a3
    23a0:	01003833          	snez	a6,a6
    23a4:	010769b3          	or	s3,a4,a6
    23a8:	00c7d633          	srl	a2,a5,a2
    23ac:	00000493          	li	s1,0
    23b0:	0079f793          	andi	a5,s3,7
    23b4:	02078063          	beqz	a5,23d4 <__subdf3+0x168>
    23b8:	00f9f693          	andi	a3,s3,15
    23bc:	00400793          	li	a5,4
    23c0:	00f68a63          	beq	a3,a5,23d4 <__subdf3+0x168>
    23c4:	00498693          	addi	a3,s3,4
    23c8:	0136b833          	sltu	a6,a3,s3
    23cc:	01060633          	add	a2,a2,a6
    23d0:	00068993          	mv	s3,a3
    23d4:	00861793          	slli	a5,a2,0x8
    23d8:	2007de63          	bgez	a5,25f4 <__subdf3+0x388>
    23dc:	00148713          	addi	a4,s1,1
    23e0:	7ff00793          	li	a5,2047
    23e4:	00147413          	andi	s0,s0,1
    23e8:	26f70463          	beq	a4,a5,2650 <__subdf3+0x3e4>
    23ec:	ff8007b7          	lui	a5,0xff800
    23f0:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    23f4:	00f677b3          	and	a5,a2,a5
    23f8:	01d79813          	slli	a6,a5,0x1d
    23fc:	0039d993          	srli	s3,s3,0x3
    2400:	00979793          	slli	a5,a5,0x9
    2404:	01386833          	or	a6,a6,s3
    2408:	00c7d793          	srli	a5,a5,0xc
    240c:	7ff77713          	andi	a4,a4,2047
    2410:	00c79693          	slli	a3,a5,0xc
    2414:	01471713          	slli	a4,a4,0x14
    2418:	00c6d693          	srli	a3,a3,0xc
    241c:	01f41413          	slli	s0,s0,0x1f
    2420:	00e6e6b3          	or	a3,a3,a4
    2424:	0086e6b3          	or	a3,a3,s0
    2428:	01c12083          	lw	ra,28(sp)
    242c:	01812403          	lw	s0,24(sp)
    2430:	01412483          	lw	s1,20(sp)
    2434:	01012903          	lw	s2,16(sp)
    2438:	00c12983          	lw	s3,12(sp)
    243c:	00080513          	mv	a0,a6
    2440:	00068593          	mv	a1,a3
    2444:	02010113          	addi	sp,sp,32
    2448:	00008067          	ret
    244c:	0ab05e63          	blez	a1,2508 <__subdf3+0x29c>
    2450:	14088a63          	beqz	a7,25a4 <__subdf3+0x338>
    2454:	008007b7          	lui	a5,0x800
    2458:	00f76733          	or	a4,a4,a5
    245c:	33c48c63          	beq	s1,t3,2794 <__subdf3+0x528>
    2460:	03800793          	li	a5,56
    2464:	1cb7c063          	blt	a5,a1,2624 <__subdf3+0x3b8>
    2468:	01f00793          	li	a5,31
    246c:	44b7da63          	bge	a5,a1,28c0 <__subdf3+0x654>
    2470:	fe058813          	addi	a6,a1,-32
    2474:	02000793          	li	a5,32
    2478:	010759b3          	srl	s3,a4,a6
    247c:	00f58a63          	beq	a1,a5,2490 <__subdf3+0x224>
    2480:	04000793          	li	a5,64
    2484:	40b785b3          	sub	a1,a5,a1
    2488:	00b71733          	sll	a4,a4,a1
    248c:	00eeeeb3          	or	t4,t4,a4
    2490:	01d03833          	snez	a6,t4
    2494:	01386833          	or	a6,a6,s3
    2498:	1940006f          	j	262c <__subdf3+0x3c0>
    249c:	01d767b3          	or	a5,a4,t4
    24a0:	80148593          	addi	a1,s1,-2047
    24a4:	00079463          	bnez	a5,24ac <__subdf3+0x240>
    24a8:	0016c693          	xori	a3,a3,1
    24ac:	04d40e63          	beq	s0,a3,2508 <__subdf3+0x29c>
    24b0:	08059a63          	bnez	a1,2544 <__subdf3+0x2d8>
    24b4:	00148793          	addi	a5,s1,1
    24b8:	7fe7f793          	andi	a5,a5,2046
    24bc:	24079263          	bnez	a5,2700 <__subdf3+0x494>
    24c0:	01e367b3          	or	a5,t1,t5
    24c4:	01d76833          	or	a6,a4,t4
    24c8:	18049c63          	bnez	s1,2660 <__subdf3+0x3f4>
    24cc:	46078063          	beqz	a5,292c <__subdf3+0x6c0>
    24d0:	4c081e63          	bnez	a6,29ac <__subdf3+0x740>
    24d4:	00351813          	slli	a6,a0,0x3
    24d8:	01d31693          	slli	a3,t1,0x1d
    24dc:	00385813          	srli	a6,a6,0x3
    24e0:	0106e833          	or	a6,a3,a6
    24e4:	00335793          	srli	a5,t1,0x3
    24e8:	1280006f          	j	2610 <__subdf3+0x3a4>
    24ec:	01d767b3          	or	a5,a4,t4
    24f0:	1e078c63          	beqz	a5,26e8 <__subdf3+0x47c>
    24f4:	fff58793          	addi	a5,a1,-1
    24f8:	44078a63          	beqz	a5,294c <__subdf3+0x6e0>
    24fc:	29c58c63          	beq	a1,t3,2794 <__subdf3+0x528>
    2500:	00078593          	mv	a1,a5
    2504:	df1ff06f          	j	22f4 <__subdf3+0x88>
    2508:	22059263          	bnez	a1,272c <__subdf3+0x4c0>
    250c:	00148693          	addi	a3,s1,1
    2510:	7fe6f793          	andi	a5,a3,2046
    2514:	0a079663          	bnez	a5,25c0 <__subdf3+0x354>
    2518:	01e367b3          	or	a5,t1,t5
    251c:	3e049663          	bnez	s1,2908 <__subdf3+0x69c>
    2520:	50078863          	beqz	a5,2a30 <__subdf3+0x7c4>
    2524:	01d767b3          	or	a5,a4,t4
    2528:	52079063          	bnez	a5,2a48 <__subdf3+0x7dc>
    252c:	00351513          	slli	a0,a0,0x3
    2530:	01d31813          	slli	a6,t1,0x1d
    2534:	00355513          	srli	a0,a0,0x3
    2538:	00a86833          	or	a6,a6,a0
    253c:	00335793          	srli	a5,t1,0x3
    2540:	0d00006f          	j	2610 <__subdf3+0x3a4>
    2544:	409885b3          	sub	a1,a7,s1
    2548:	26049263          	bnez	s1,27ac <__subdf3+0x540>
    254c:	01e367b3          	or	a5,t1,t5
    2550:	38078e63          	beqz	a5,28ec <__subdf3+0x680>
    2554:	fff58793          	addi	a5,a1,-1
    2558:	4a078e63          	beqz	a5,2a14 <__subdf3+0x7a8>
    255c:	7ff00513          	li	a0,2047
    2560:	24a58e63          	beq	a1,a0,27bc <__subdf3+0x550>
    2564:	00078593          	mv	a1,a5
    2568:	03800793          	li	a5,56
    256c:	30b7ca63          	blt	a5,a1,2880 <__subdf3+0x614>
    2570:	01f00793          	li	a5,31
    2574:	46b7ca63          	blt	a5,a1,29e8 <__subdf3+0x77c>
    2578:	02000793          	li	a5,32
    257c:	40b787b3          	sub	a5,a5,a1
    2580:	00f31833          	sll	a6,t1,a5
    2584:	00bf5633          	srl	a2,t5,a1
    2588:	00ff17b3          	sll	a5,t5,a5
    258c:	00c86833          	or	a6,a6,a2
    2590:	00f039b3          	snez	s3,a5
    2594:	00b35333          	srl	t1,t1,a1
    2598:	01386833          	or	a6,a6,s3
    259c:	40670733          	sub	a4,a4,t1
    25a0:	2e80006f          	j	2888 <__subdf3+0x61c>
    25a4:	01d767b3          	or	a5,a4,t4
    25a8:	14078063          	beqz	a5,26e8 <__subdf3+0x47c>
    25ac:	fff58793          	addi	a5,a1,-1
    25b0:	24078e63          	beqz	a5,280c <__subdf3+0x5a0>
    25b4:	37c58063          	beq	a1,t3,2914 <__subdf3+0x6a8>
    25b8:	00078593          	mv	a1,a5
    25bc:	ea5ff06f          	j	2460 <__subdf3+0x1f4>
    25c0:	7ff00793          	li	a5,2047
    25c4:	08f68463          	beq	a3,a5,264c <__subdf3+0x3e0>
    25c8:	01df0eb3          	add	t4,t5,t4
    25cc:	01eeb633          	sltu	a2,t4,t5
    25d0:	00e307b3          	add	a5,t1,a4
    25d4:	00c787b3          	add	a5,a5,a2
    25d8:	01f79813          	slli	a6,a5,0x1f
    25dc:	001ede93          	srli	t4,t4,0x1
    25e0:	01d869b3          	or	s3,a6,t4
    25e4:	0017d613          	srli	a2,a5,0x1
    25e8:	00068493          	mv	s1,a3
    25ec:	0079f793          	andi	a5,s3,7
    25f0:	dc0794e3          	bnez	a5,23b8 <__subdf3+0x14c>
    25f4:	01d61793          	slli	a5,a2,0x1d
    25f8:	0039d813          	srli	a6,s3,0x3
    25fc:	00f86833          	or	a6,a6,a5
    2600:	00048593          	mv	a1,s1
    2604:	00365793          	srli	a5,a2,0x3
    2608:	7ff00713          	li	a4,2047
    260c:	06e58a63          	beq	a1,a4,2680 <__subdf3+0x414>
    2610:	00c79793          	slli	a5,a5,0xc
    2614:	00c7d793          	srli	a5,a5,0xc
    2618:	7ff5f713          	andi	a4,a1,2047
    261c:	00147413          	andi	s0,s0,1
    2620:	df1ff06f          	j	2410 <__subdf3+0x1a4>
    2624:	01d76733          	or	a4,a4,t4
    2628:	00e03833          	snez	a6,a4
    262c:	01e809b3          	add	s3,a6,t5
    2630:	01e9b7b3          	sltu	a5,s3,t5
    2634:	00678633          	add	a2,a5,t1
    2638:	00861793          	slli	a5,a2,0x8
    263c:	fa07d8e3          	bgez	a5,25ec <__subdf3+0x380>
    2640:	00148493          	addi	s1,s1,1
    2644:	7ff00793          	li	a5,2047
    2648:	1ef49263          	bne	s1,a5,282c <__subdf3+0x5c0>
    264c:	00147413          	andi	s0,s0,1
    2650:	7ff00713          	li	a4,2047
    2654:	00000793          	li	a5,0
    2658:	00000813          	li	a6,0
    265c:	db5ff06f          	j	2410 <__subdf3+0x1a4>
    2660:	12079863          	bnez	a5,2790 <__subdf3+0x524>
    2664:	46080063          	beqz	a6,2ac4 <__subdf3+0x858>
    2668:	00361813          	slli	a6,a2,0x3
    266c:	01d71793          	slli	a5,a4,0x1d
    2670:	00385813          	srli	a6,a6,0x3
    2674:	00f86833          	or	a6,a6,a5
    2678:	00068413          	mv	s0,a3
    267c:	00375793          	srli	a5,a4,0x3
    2680:	00f867b3          	or	a5,a6,a5
    2684:	fc0784e3          	beqz	a5,264c <__subdf3+0x3e0>
    2688:	00000413          	li	s0,0
    268c:	7ff00713          	li	a4,2047
    2690:	000807b7          	lui	a5,0x80
    2694:	00000813          	li	a6,0
    2698:	d79ff06f          	j	2410 <__subdf3+0x1a4>
    269c:	ff800637          	lui	a2,0xff800
    26a0:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    26a4:	00c7f633          	and	a2,a5,a2
    26a8:	0079f793          	andi	a5,s3,7
    26ac:	40e484b3          	sub	s1,s1,a4
    26b0:	d00794e3          	bnez	a5,23b8 <__subdf3+0x14c>
    26b4:	f41ff06f          	j	25f4 <__subdf3+0x388>
    26b8:	00098513          	mv	a0,s3
    26bc:	261000ef          	jal	ra,311c <__clzsi2>
    26c0:	01850713          	addi	a4,a0,24
    26c4:	01f00793          	li	a5,31
    26c8:	c8e7dae3          	bge	a5,a4,235c <__subdf3+0xf0>
    26cc:	ff850613          	addi	a2,a0,-8
    26d0:	00c997b3          	sll	a5,s3,a2
    26d4:	00000993          	li	s3,0
    26d8:	c9dff06f          	j	2374 <__subdf3+0x108>
    26dc:	01d76833          	or	a6,a4,t4
    26e0:	01003833          	snez	a6,a6
    26e4:	c49ff06f          	j	232c <__subdf3+0xc0>
    26e8:	00351813          	slli	a6,a0,0x3
    26ec:	01d31793          	slli	a5,t1,0x1d
    26f0:	00385813          	srli	a6,a6,0x3
    26f4:	00f86833          	or	a6,a6,a5
    26f8:	00335793          	srli	a5,t1,0x3
    26fc:	f0dff06f          	j	2608 <__subdf3+0x39c>
    2700:	41df09b3          	sub	s3,t5,t4
    2704:	40e30933          	sub	s2,t1,a4
    2708:	013f3633          	sltu	a2,t5,s3
    270c:	40c90933          	sub	s2,s2,a2
    2710:	00891793          	slli	a5,s2,0x8
    2714:	2607c463          	bltz	a5,297c <__subdf3+0x710>
    2718:	0129e833          	or	a6,s3,s2
    271c:	c20818e3          	bnez	a6,234c <__subdf3+0xe0>
    2720:	00000793          	li	a5,0
    2724:	00000413          	li	s0,0
    2728:	ee9ff06f          	j	2610 <__subdf3+0x3a4>
    272c:	409885b3          	sub	a1,a7,s1
    2730:	16048863          	beqz	s1,28a0 <__subdf3+0x634>
    2734:	008006b7          	lui	a3,0x800
    2738:	7ff00793          	li	a5,2047
    273c:	00d36333          	or	t1,t1,a3
    2740:	24f88a63          	beq	a7,a5,2994 <__subdf3+0x728>
    2744:	03800793          	li	a5,56
    2748:	28b7ca63          	blt	a5,a1,29dc <__subdf3+0x770>
    274c:	01f00793          	li	a5,31
    2750:	34b7c463          	blt	a5,a1,2a98 <__subdf3+0x82c>
    2754:	02000793          	li	a5,32
    2758:	40b787b3          	sub	a5,a5,a1
    275c:	00f31833          	sll	a6,t1,a5
    2760:	00bf56b3          	srl	a3,t5,a1
    2764:	00ff17b3          	sll	a5,t5,a5
    2768:	00d86833          	or	a6,a6,a3
    276c:	00f039b3          	snez	s3,a5
    2770:	00b35333          	srl	t1,t1,a1
    2774:	01386833          	or	a6,a6,s3
    2778:	00670733          	add	a4,a4,t1
    277c:	01d809b3          	add	s3,a6,t4
    2780:	01d9b7b3          	sltu	a5,s3,t4
    2784:	00e78633          	add	a2,a5,a4
    2788:	00088493          	mv	s1,a7
    278c:	eadff06f          	j	2638 <__subdf3+0x3cc>
    2790:	ee081ce3          	bnez	a6,2688 <__subdf3+0x41c>
    2794:	00351813          	slli	a6,a0,0x3
    2798:	01d31793          	slli	a5,t1,0x1d
    279c:	00385813          	srli	a6,a6,0x3
    27a0:	00f86833          	or	a6,a6,a5
    27a4:	00335793          	srli	a5,t1,0x3
    27a8:	ed9ff06f          	j	2680 <__subdf3+0x414>
    27ac:	00800537          	lui	a0,0x800
    27b0:	7ff00793          	li	a5,2047
    27b4:	00a36333          	or	t1,t1,a0
    27b8:	daf898e3          	bne	a7,a5,2568 <__subdf3+0x2fc>
    27bc:	00361613          	slli	a2,a2,0x3
    27c0:	01d71813          	slli	a6,a4,0x1d
    27c4:	00365613          	srli	a2,a2,0x3
    27c8:	00c86833          	or	a6,a6,a2
    27cc:	00375793          	srli	a5,a4,0x3
    27d0:	00068413          	mv	s0,a3
    27d4:	eadff06f          	j	2680 <__subdf3+0x414>
    27d8:	fe170713          	addi	a4,a4,-31
    27dc:	02000693          	li	a3,32
    27e0:	00e7d733          	srl	a4,a5,a4
    27e4:	00d60a63          	beq	a2,a3,27f8 <__subdf3+0x58c>
    27e8:	04000693          	li	a3,64
    27ec:	40c68633          	sub	a2,a3,a2
    27f0:	00c79633          	sll	a2,a5,a2
    27f4:	00c9e9b3          	or	s3,s3,a2
    27f8:	01303833          	snez	a6,s3
    27fc:	00e869b3          	or	s3,a6,a4
    2800:	00000613          	li	a2,0
    2804:	00000493          	li	s1,0
    2808:	de5ff06f          	j	25ec <__subdf3+0x380>
    280c:	01df09b3          	add	s3,t5,t4
    2810:	00e307b3          	add	a5,t1,a4
    2814:	01e9bf33          	sltu	t5,s3,t5
    2818:	01e78633          	add	a2,a5,t5
    281c:	00861793          	slli	a5,a2,0x8
    2820:	00100493          	li	s1,1
    2824:	dc07d4e3          	bgez	a5,25ec <__subdf3+0x380>
    2828:	00200493          	li	s1,2
    282c:	ff8007b7          	lui	a5,0xff800
    2830:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    2834:	00f677b3          	and	a5,a2,a5
    2838:	0019d713          	srli	a4,s3,0x1
    283c:	0019f813          	andi	a6,s3,1
    2840:	01076833          	or	a6,a4,a6
    2844:	01f79993          	slli	s3,a5,0x1f
    2848:	0109e9b3          	or	s3,s3,a6
    284c:	0017d613          	srli	a2,a5,0x1
    2850:	b61ff06f          	j	23b0 <__subdf3+0x144>
    2854:	fe058813          	addi	a6,a1,-32
    2858:	02000793          	li	a5,32
    285c:	010759b3          	srl	s3,a4,a6
    2860:	00f58a63          	beq	a1,a5,2874 <__subdf3+0x608>
    2864:	04000793          	li	a5,64
    2868:	40b785b3          	sub	a1,a5,a1
    286c:	00b71733          	sll	a4,a4,a1
    2870:	00eeeeb3          	or	t4,t4,a4
    2874:	01d03833          	snez	a6,t4
    2878:	01386833          	or	a6,a6,s3
    287c:	ab1ff06f          	j	232c <__subdf3+0xc0>
    2880:	01e36333          	or	t1,t1,t5
    2884:	00603833          	snez	a6,t1
    2888:	410e89b3          	sub	s3,t4,a6
    288c:	013eb7b3          	sltu	a5,t4,s3
    2890:	40f70633          	sub	a2,a4,a5
    2894:	00088493          	mv	s1,a7
    2898:	00068413          	mv	s0,a3
    289c:	a9dff06f          	j	2338 <__subdf3+0xcc>
    28a0:	01e367b3          	or	a5,t1,t5
    28a4:	1c078863          	beqz	a5,2a74 <__subdf3+0x808>
    28a8:	fff58793          	addi	a5,a1,-1
    28ac:	22078463          	beqz	a5,2ad4 <__subdf3+0x868>
    28b0:	7ff00693          	li	a3,2047
    28b4:	0ed58063          	beq	a1,a3,2994 <__subdf3+0x728>
    28b8:	00078593          	mv	a1,a5
    28bc:	e89ff06f          	j	2744 <__subdf3+0x4d8>
    28c0:	02000793          	li	a5,32
    28c4:	40b787b3          	sub	a5,a5,a1
    28c8:	00bed9b3          	srl	s3,t4,a1
    28cc:	00f71833          	sll	a6,a4,a5
    28d0:	00fe9eb3          	sll	t4,t4,a5
    28d4:	01386833          	or	a6,a6,s3
    28d8:	00b75733          	srl	a4,a4,a1
    28dc:	01d039b3          	snez	s3,t4
    28e0:	01386833          	or	a6,a6,s3
    28e4:	00e30333          	add	t1,t1,a4
    28e8:	d45ff06f          	j	262c <__subdf3+0x3c0>
    28ec:	00361813          	slli	a6,a2,0x3
    28f0:	01d71793          	slli	a5,a4,0x1d
    28f4:	00385813          	srli	a6,a6,0x3
    28f8:	0107e833          	or	a6,a5,a6
    28fc:	00068413          	mv	s0,a3
    2900:	00375793          	srli	a5,a4,0x3
    2904:	d05ff06f          	j	2608 <__subdf3+0x39c>
    2908:	08078663          	beqz	a5,2994 <__subdf3+0x728>
    290c:	01d76733          	or	a4,a4,t4
    2910:	d6071ce3          	bnez	a4,2688 <__subdf3+0x41c>
    2914:	00351513          	slli	a0,a0,0x3
    2918:	01d31813          	slli	a6,t1,0x1d
    291c:	00355513          	srli	a0,a0,0x3
    2920:	00a86833          	or	a6,a6,a0
    2924:	00335793          	srli	a5,t1,0x3
    2928:	d59ff06f          	j	2680 <__subdf3+0x414>
    292c:	de080ae3          	beqz	a6,2720 <__subdf3+0x4b4>
    2930:	00361813          	slli	a6,a2,0x3
    2934:	01d71793          	slli	a5,a4,0x1d
    2938:	00385813          	srli	a6,a6,0x3
    293c:	00f86833          	or	a6,a6,a5
    2940:	00068413          	mv	s0,a3
    2944:	00375793          	srli	a5,a4,0x3
    2948:	cc9ff06f          	j	2610 <__subdf3+0x3a4>
    294c:	41df09b3          	sub	s3,t5,t4
    2950:	40e307b3          	sub	a5,t1,a4
    2954:	013f3f33          	sltu	t5,t5,s3
    2958:	41e78633          	sub	a2,a5,t5
    295c:	00100493          	li	s1,1
    2960:	9d9ff06f          	j	2338 <__subdf3+0xcc>
    2964:	00351813          	slli	a6,a0,0x3
    2968:	01d31693          	slli	a3,t1,0x1d
    296c:	00385813          	srli	a6,a6,0x3
    2970:	0106e833          	or	a6,a3,a6
    2974:	00335793          	srli	a5,t1,0x3
    2978:	d09ff06f          	j	2680 <__subdf3+0x414>
    297c:	41ee89b3          	sub	s3,t4,t5
    2980:	40670633          	sub	a2,a4,t1
    2984:	013eb933          	sltu	s2,t4,s3
    2988:	41260933          	sub	s2,a2,s2
    298c:	00068413          	mv	s0,a3
    2990:	9bdff06f          	j	234c <__subdf3+0xe0>
    2994:	00361613          	slli	a2,a2,0x3
    2998:	01d71813          	slli	a6,a4,0x1d
    299c:	00365613          	srli	a2,a2,0x3
    29a0:	00c86833          	or	a6,a6,a2
    29a4:	00375793          	srli	a5,a4,0x3
    29a8:	cd9ff06f          	j	2680 <__subdf3+0x414>
    29ac:	41df09b3          	sub	s3,t5,t4
    29b0:	40e307b3          	sub	a5,t1,a4
    29b4:	013f3633          	sltu	a2,t5,s3
    29b8:	40c78633          	sub	a2,a5,a2
    29bc:	00861793          	slli	a5,a2,0x8
    29c0:	0c07d663          	bgez	a5,2a8c <__subdf3+0x820>
    29c4:	41ee89b3          	sub	s3,t4,t5
    29c8:	406707b3          	sub	a5,a4,t1
    29cc:	013ebeb3          	sltu	t4,t4,s3
    29d0:	41d78633          	sub	a2,a5,t4
    29d4:	00068413          	mv	s0,a3
    29d8:	9d9ff06f          	j	23b0 <__subdf3+0x144>
    29dc:	01e36333          	or	t1,t1,t5
    29e0:	00603833          	snez	a6,t1
    29e4:	d99ff06f          	j	277c <__subdf3+0x510>
    29e8:	fe058813          	addi	a6,a1,-32
    29ec:	02000793          	li	a5,32
    29f0:	010359b3          	srl	s3,t1,a6
    29f4:	00f58a63          	beq	a1,a5,2a08 <__subdf3+0x79c>
    29f8:	04000793          	li	a5,64
    29fc:	40b785b3          	sub	a1,a5,a1
    2a00:	00b31333          	sll	t1,t1,a1
    2a04:	006f6f33          	or	t5,t5,t1
    2a08:	01e03833          	snez	a6,t5
    2a0c:	01386833          	or	a6,a6,s3
    2a10:	e79ff06f          	j	2888 <__subdf3+0x61c>
    2a14:	41ee89b3          	sub	s3,t4,t5
    2a18:	406707b3          	sub	a5,a4,t1
    2a1c:	013ebeb3          	sltu	t4,t4,s3
    2a20:	41d78633          	sub	a2,a5,t4
    2a24:	00068413          	mv	s0,a3
    2a28:	00100493          	li	s1,1
    2a2c:	90dff06f          	j	2338 <__subdf3+0xcc>
    2a30:	00361813          	slli	a6,a2,0x3
    2a34:	01d71793          	slli	a5,a4,0x1d
    2a38:	00385813          	srli	a6,a6,0x3
    2a3c:	00f86833          	or	a6,a6,a5
    2a40:	00375793          	srli	a5,a4,0x3
    2a44:	bcdff06f          	j	2610 <__subdf3+0x3a4>
    2a48:	01df09b3          	add	s3,t5,t4
    2a4c:	00e307b3          	add	a5,t1,a4
    2a50:	01e9bf33          	sltu	t5,s3,t5
    2a54:	01e78633          	add	a2,a5,t5
    2a58:	00861793          	slli	a5,a2,0x8
    2a5c:	b807d8e3          	bgez	a5,25ec <__subdf3+0x380>
    2a60:	ff8007b7          	lui	a5,0xff800
    2a64:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    2a68:	00f67633          	and	a2,a2,a5
    2a6c:	00100493          	li	s1,1
    2a70:	b7dff06f          	j	25ec <__subdf3+0x380>
    2a74:	00361613          	slli	a2,a2,0x3
    2a78:	01d71813          	slli	a6,a4,0x1d
    2a7c:	00365613          	srli	a2,a2,0x3
    2a80:	00c86833          	or	a6,a6,a2
    2a84:	00375793          	srli	a5,a4,0x3
    2a88:	b81ff06f          	j	2608 <__subdf3+0x39c>
    2a8c:	00c9e833          	or	a6,s3,a2
    2a90:	c80808e3          	beqz	a6,2720 <__subdf3+0x4b4>
    2a94:	b59ff06f          	j	25ec <__subdf3+0x380>
    2a98:	fe058813          	addi	a6,a1,-32
    2a9c:	02000793          	li	a5,32
    2aa0:	010359b3          	srl	s3,t1,a6
    2aa4:	00f58a63          	beq	a1,a5,2ab8 <__subdf3+0x84c>
    2aa8:	04000793          	li	a5,64
    2aac:	40b785b3          	sub	a1,a5,a1
    2ab0:	00b31333          	sll	t1,t1,a1
    2ab4:	006f6f33          	or	t5,t5,t1
    2ab8:	01e03833          	snez	a6,t5
    2abc:	01386833          	or	a6,a6,s3
    2ac0:	cbdff06f          	j	277c <__subdf3+0x510>
    2ac4:	00000413          	li	s0,0
    2ac8:	7ff00713          	li	a4,2047
    2acc:	000807b7          	lui	a5,0x80
    2ad0:	941ff06f          	j	2410 <__subdf3+0x1a4>
    2ad4:	01df09b3          	add	s3,t5,t4
    2ad8:	00e307b3          	add	a5,t1,a4
    2adc:	01d9beb3          	sltu	t4,s3,t4
    2ae0:	01d78633          	add	a2,a5,t4
    2ae4:	d39ff06f          	j	281c <__subdf3+0x5b0>

00002ae8 <__fixdfsi>:
    2ae8:	0145d793          	srli	a5,a1,0x14
    2aec:	001006b7          	lui	a3,0x100
    2af0:	fff68713          	addi	a4,a3,-1 # fffff <__global_pointer$+0xf93b7>
    2af4:	7ff7f793          	andi	a5,a5,2047
    2af8:	3fe00613          	li	a2,1022
    2afc:	00b77733          	and	a4,a4,a1
    2b00:	01f5d593          	srli	a1,a1,0x1f
    2b04:	00f65e63          	bge	a2,a5,2b20 <__fixdfsi+0x38>
    2b08:	41d00613          	li	a2,1053
    2b0c:	00f65e63          	bge	a2,a5,2b28 <__fixdfsi+0x40>
    2b10:	80000537          	lui	a0,0x80000
    2b14:	fff54513          	not	a0,a0
    2b18:	00a58533          	add	a0,a1,a0
    2b1c:	00008067          	ret
    2b20:	00000513          	li	a0,0
    2b24:	00008067          	ret
    2b28:	43300613          	li	a2,1075
    2b2c:	40f60633          	sub	a2,a2,a5
    2b30:	01f00813          	li	a6,31
    2b34:	00d76733          	or	a4,a4,a3
    2b38:	02c85063          	bge	a6,a2,2b58 <__fixdfsi+0x70>
    2b3c:	41300693          	li	a3,1043
    2b40:	40f687b3          	sub	a5,a3,a5
    2b44:	00f757b3          	srl	a5,a4,a5
    2b48:	40f00533          	neg	a0,a5
    2b4c:	fc059ce3          	bnez	a1,2b24 <__fixdfsi+0x3c>
    2b50:	00078513          	mv	a0,a5
    2b54:	00008067          	ret
    2b58:	bed78793          	addi	a5,a5,-1043 # 7fbed <__global_pointer$+0x78fa5>
    2b5c:	00f717b3          	sll	a5,a4,a5
    2b60:	00c55533          	srl	a0,a0,a2
    2b64:	00a7e7b3          	or	a5,a5,a0
    2b68:	fe1ff06f          	j	2b48 <__fixdfsi+0x60>

00002b6c <__floatsidf>:
    2b6c:	ff010113          	addi	sp,sp,-16
    2b70:	00112623          	sw	ra,12(sp)
    2b74:	00812423          	sw	s0,8(sp)
    2b78:	00912223          	sw	s1,4(sp)
    2b7c:	04050a63          	beqz	a0,2bd0 <__floatsidf+0x64>
    2b80:	41f55793          	srai	a5,a0,0x1f
    2b84:	00a7c4b3          	xor	s1,a5,a0
    2b88:	40f484b3          	sub	s1,s1,a5
    2b8c:	00050413          	mv	s0,a0
    2b90:	00048513          	mv	a0,s1
    2b94:	588000ef          	jal	ra,311c <__clzsi2>
    2b98:	41e00693          	li	a3,1054
    2b9c:	40a686b3          	sub	a3,a3,a0
    2ba0:	00a00793          	li	a5,10
    2ba4:	01f45413          	srli	s0,s0,0x1f
    2ba8:	7ff6f693          	andi	a3,a3,2047
    2bac:	06a7c463          	blt	a5,a0,2c14 <__floatsidf+0xa8>
    2bb0:	00b00713          	li	a4,11
    2bb4:	40a70733          	sub	a4,a4,a0
    2bb8:	00e4d7b3          	srl	a5,s1,a4
    2bbc:	01550513          	addi	a0,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf9b75>
    2bc0:	00c79793          	slli	a5,a5,0xc
    2bc4:	00a494b3          	sll	s1,s1,a0
    2bc8:	00c7d793          	srli	a5,a5,0xc
    2bcc:	0140006f          	j	2be0 <__floatsidf+0x74>
    2bd0:	00000413          	li	s0,0
    2bd4:	00000693          	li	a3,0
    2bd8:	00000793          	li	a5,0
    2bdc:	00000493          	li	s1,0
    2be0:	00c79793          	slli	a5,a5,0xc
    2be4:	01469693          	slli	a3,a3,0x14
    2be8:	00c7d793          	srli	a5,a5,0xc
    2bec:	01f41413          	slli	s0,s0,0x1f
    2bf0:	00d7e7b3          	or	a5,a5,a3
    2bf4:	0087e7b3          	or	a5,a5,s0
    2bf8:	00c12083          	lw	ra,12(sp)
    2bfc:	00812403          	lw	s0,8(sp)
    2c00:	00048513          	mv	a0,s1
    2c04:	00078593          	mv	a1,a5
    2c08:	00412483          	lw	s1,4(sp)
    2c0c:	01010113          	addi	sp,sp,16
    2c10:	00008067          	ret
    2c14:	ff550513          	addi	a0,a0,-11
    2c18:	00a497b3          	sll	a5,s1,a0
    2c1c:	00c79793          	slli	a5,a5,0xc
    2c20:	00c7d793          	srli	a5,a5,0xc
    2c24:	00000493          	li	s1,0
    2c28:	fb9ff06f          	j	2be0 <__floatsidf+0x74>

00002c2c <__gesf2>:
    2c2c:	01755693          	srli	a3,a0,0x17
    2c30:	008007b7          	lui	a5,0x800
    2c34:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    2c38:	0175d613          	srli	a2,a1,0x17
    2c3c:	0ff6f693          	andi	a3,a3,255
    2c40:	0ff00813          	li	a6,255
    2c44:	00a7f8b3          	and	a7,a5,a0
    2c48:	01f55713          	srli	a4,a0,0x1f
    2c4c:	00b7f7b3          	and	a5,a5,a1
    2c50:	0ff67613          	andi	a2,a2,255
    2c54:	01f5d513          	srli	a0,a1,0x1f
    2c58:	03068a63          	beq	a3,a6,2c8c <__gesf2+0x60>
    2c5c:	03060263          	beq	a2,a6,2c80 <__gesf2+0x54>
    2c60:	02069a63          	bnez	a3,2c94 <__gesf2+0x68>
    2c64:	00061463          	bnez	a2,2c6c <__gesf2+0x40>
    2c68:	04078a63          	beqz	a5,2cbc <__gesf2+0x90>
    2c6c:	04088263          	beqz	a7,2cb0 <__gesf2+0x84>
    2c70:	06a70063          	beq	a4,a0,2cd0 <__gesf2+0xa4>
    2c74:	00100513          	li	a0,1
    2c78:	02071e63          	bnez	a4,2cb4 <__gesf2+0x88>
    2c7c:	00008067          	ret
    2c80:	fe0780e3          	beqz	a5,2c60 <__gesf2+0x34>
    2c84:	ffe00513          	li	a0,-2
    2c88:	00008067          	ret
    2c8c:	fe089ce3          	bnez	a7,2c84 <__gesf2+0x58>
    2c90:	02d60c63          	beq	a2,a3,2cc8 <__gesf2+0x9c>
    2c94:	00061463          	bnez	a2,2c9c <__gesf2+0x70>
    2c98:	fc078ee3          	beqz	a5,2c74 <__gesf2+0x48>
    2c9c:	fca71ce3          	bne	a4,a0,2c74 <__gesf2+0x48>
    2ca0:	02d65a63          	bge	a2,a3,2cd4 <__gesf2+0xa8>
    2ca4:	00051863          	bnez	a0,2cb4 <__gesf2+0x88>
    2ca8:	00100513          	li	a0,1
    2cac:	00008067          	ret
    2cb0:	fc0516e3          	bnez	a0,2c7c <__gesf2+0x50>
    2cb4:	fff00513          	li	a0,-1
    2cb8:	00008067          	ret
    2cbc:	00000513          	li	a0,0
    2cc0:	fa089ae3          	bnez	a7,2c74 <__gesf2+0x48>
    2cc4:	00008067          	ret
    2cc8:	fc078ae3          	beqz	a5,2c9c <__gesf2+0x70>
    2ccc:	fb9ff06f          	j	2c84 <__gesf2+0x58>
    2cd0:	00000693          	li	a3,0
    2cd4:	00c6c863          	blt	a3,a2,2ce4 <__gesf2+0xb8>
    2cd8:	f917eee3          	bltu	a5,a7,2c74 <__gesf2+0x48>
    2cdc:	00000513          	li	a0,0
    2ce0:	f8f8fee3          	bgeu	a7,a5,2c7c <__gesf2+0x50>
    2ce4:	fc0708e3          	beqz	a4,2cb4 <__gesf2+0x88>
    2ce8:	00070513          	mv	a0,a4
    2cec:	00008067          	ret

00002cf0 <__lesf2>:
    2cf0:	01755693          	srli	a3,a0,0x17
    2cf4:	008007b7          	lui	a5,0x800
    2cf8:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    2cfc:	0175d613          	srli	a2,a1,0x17
    2d00:	0ff6f693          	andi	a3,a3,255
    2d04:	0ff00813          	li	a6,255
    2d08:	00a7f8b3          	and	a7,a5,a0
    2d0c:	01f55713          	srli	a4,a0,0x1f
    2d10:	00b7f7b3          	and	a5,a5,a1
    2d14:	0ff67613          	andi	a2,a2,255
    2d18:	01f5d513          	srli	a0,a1,0x1f
    2d1c:	05068263          	beq	a3,a6,2d60 <__lesf2+0x70>
    2d20:	01060e63          	beq	a2,a6,2d3c <__lesf2+0x4c>
    2d24:	04069263          	bnez	a3,2d68 <__lesf2+0x78>
    2d28:	02061063          	bnez	a2,2d48 <__lesf2+0x58>
    2d2c:	00079e63          	bnez	a5,2d48 <__lesf2+0x58>
    2d30:	00000513          	li	a0,0
    2d34:	00089e63          	bnez	a7,2d50 <__lesf2+0x60>
    2d38:	00008067          	ret
    2d3c:	fe0784e3          	beqz	a5,2d24 <__lesf2+0x34>
    2d40:	00200513          	li	a0,2
    2d44:	00008067          	ret
    2d48:	02088e63          	beqz	a7,2d84 <__lesf2+0x94>
    2d4c:	04a70463          	beq	a4,a0,2d94 <__lesf2+0xa4>
    2d50:	00100513          	li	a0,1
    2d54:	fe0702e3          	beqz	a4,2d38 <__lesf2+0x48>
    2d58:	fff00513          	li	a0,-1
    2d5c:	00008067          	ret
    2d60:	fe0890e3          	bnez	a7,2d40 <__lesf2+0x50>
    2d64:	02d60463          	beq	a2,a3,2d8c <__lesf2+0x9c>
    2d68:	00061463          	bnez	a2,2d70 <__lesf2+0x80>
    2d6c:	fe0782e3          	beqz	a5,2d50 <__lesf2+0x60>
    2d70:	fea710e3          	bne	a4,a0,2d50 <__lesf2+0x60>
    2d74:	02d65263          	bge	a2,a3,2d98 <__lesf2+0xa8>
    2d78:	fe0510e3          	bnez	a0,2d58 <__lesf2+0x68>
    2d7c:	00100513          	li	a0,1
    2d80:	00008067          	ret
    2d84:	fc050ae3          	beqz	a0,2d58 <__lesf2+0x68>
    2d88:	00008067          	ret
    2d8c:	fe0782e3          	beqz	a5,2d70 <__lesf2+0x80>
    2d90:	fb1ff06f          	j	2d40 <__lesf2+0x50>
    2d94:	00000693          	li	a3,0
    2d98:	00c6c863          	blt	a3,a2,2da8 <__lesf2+0xb8>
    2d9c:	fb17eae3          	bltu	a5,a7,2d50 <__lesf2+0x60>
    2da0:	00000513          	li	a0,0
    2da4:	f8f8fae3          	bgeu	a7,a5,2d38 <__lesf2+0x48>
    2da8:	fa0708e3          	beqz	a4,2d58 <__lesf2+0x68>
    2dac:	00070513          	mv	a0,a4
    2db0:	00008067          	ret

00002db4 <__fixsfsi>:
    2db4:	00800637          	lui	a2,0x800
    2db8:	01755713          	srli	a4,a0,0x17
    2dbc:	fff60793          	addi	a5,a2,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    2dc0:	0ff77713          	andi	a4,a4,255
    2dc4:	07e00593          	li	a1,126
    2dc8:	00a7f6b3          	and	a3,a5,a0
    2dcc:	01f55793          	srli	a5,a0,0x1f
    2dd0:	00e5fe63          	bgeu	a1,a4,2dec <__fixsfsi+0x38>
    2dd4:	09d00593          	li	a1,157
    2dd8:	00e5fe63          	bgeu	a1,a4,2df4 <__fixsfsi+0x40>
    2ddc:	80000537          	lui	a0,0x80000
    2de0:	fff54513          	not	a0,a0
    2de4:	00a78533          	add	a0,a5,a0
    2de8:	00008067          	ret
    2dec:	00000513          	li	a0,0
    2df0:	00008067          	ret
    2df4:	09500593          	li	a1,149
    2df8:	00c6e6b3          	or	a3,a3,a2
    2dfc:	02e5c063          	blt	a1,a4,2e1c <__fixsfsi+0x68>
    2e00:	09600613          	li	a2,150
    2e04:	40e60733          	sub	a4,a2,a4
    2e08:	00e6d733          	srl	a4,a3,a4
    2e0c:	40e00533          	neg	a0,a4
    2e10:	fe0790e3          	bnez	a5,2df0 <__fixsfsi+0x3c>
    2e14:	00070513          	mv	a0,a4
    2e18:	00008067          	ret
    2e1c:	f6a70713          	addi	a4,a4,-150
    2e20:	00e69733          	sll	a4,a3,a4
    2e24:	fe9ff06f          	j	2e0c <__fixsfsi+0x58>

00002e28 <__extendsfdf2>:
    2e28:	01755713          	srli	a4,a0,0x17
    2e2c:	0ff77713          	andi	a4,a4,255
    2e30:	ff010113          	addi	sp,sp,-16
    2e34:	00170793          	addi	a5,a4,1
    2e38:	00812423          	sw	s0,8(sp)
    2e3c:	00912223          	sw	s1,4(sp)
    2e40:	00951413          	slli	s0,a0,0x9
    2e44:	00112623          	sw	ra,12(sp)
    2e48:	0fe7f793          	andi	a5,a5,254
    2e4c:	00945413          	srli	s0,s0,0x9
    2e50:	01f55493          	srli	s1,a0,0x1f
    2e54:	04078263          	beqz	a5,2e98 <__extendsfdf2+0x70>
    2e58:	00345793          	srli	a5,s0,0x3
    2e5c:	38070713          	addi	a4,a4,896
    2e60:	01d41413          	slli	s0,s0,0x1d
    2e64:	00c79793          	slli	a5,a5,0xc
    2e68:	01471713          	slli	a4,a4,0x14
    2e6c:	00c7d793          	srli	a5,a5,0xc
    2e70:	01f49513          	slli	a0,s1,0x1f
    2e74:	00e7e7b3          	or	a5,a5,a4
    2e78:	00a7e7b3          	or	a5,a5,a0
    2e7c:	00c12083          	lw	ra,12(sp)
    2e80:	00040513          	mv	a0,s0
    2e84:	00812403          	lw	s0,8(sp)
    2e88:	00412483          	lw	s1,4(sp)
    2e8c:	00078593          	mv	a1,a5
    2e90:	01010113          	addi	sp,sp,16
    2e94:	00008067          	ret
    2e98:	04071263          	bnez	a4,2edc <__extendsfdf2+0xb4>
    2e9c:	06040863          	beqz	s0,2f0c <__extendsfdf2+0xe4>
    2ea0:	00040513          	mv	a0,s0
    2ea4:	278000ef          	jal	ra,311c <__clzsi2>
    2ea8:	00a00793          	li	a5,10
    2eac:	06a7c663          	blt	a5,a0,2f18 <__extendsfdf2+0xf0>
    2eb0:	00b00713          	li	a4,11
    2eb4:	40a70733          	sub	a4,a4,a0
    2eb8:	01550793          	addi	a5,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf9b75>
    2ebc:	00e45733          	srl	a4,s0,a4
    2ec0:	00f41433          	sll	s0,s0,a5
    2ec4:	00c71793          	slli	a5,a4,0xc
    2ec8:	38900713          	li	a4,905
    2ecc:	40a70733          	sub	a4,a4,a0
    2ed0:	00c7d793          	srli	a5,a5,0xc
    2ed4:	7ff77713          	andi	a4,a4,2047
    2ed8:	f8dff06f          	j	2e64 <__extendsfdf2+0x3c>
    2edc:	02040263          	beqz	s0,2f00 <__extendsfdf2+0xd8>
    2ee0:	00345713          	srli	a4,s0,0x3
    2ee4:	000807b7          	lui	a5,0x80
    2ee8:	00f767b3          	or	a5,a4,a5
    2eec:	00c79793          	slli	a5,a5,0xc
    2ef0:	01d41413          	slli	s0,s0,0x1d
    2ef4:	00c7d793          	srli	a5,a5,0xc
    2ef8:	7ff00713          	li	a4,2047
    2efc:	f69ff06f          	j	2e64 <__extendsfdf2+0x3c>
    2f00:	7ff00713          	li	a4,2047
    2f04:	00000793          	li	a5,0
    2f08:	f5dff06f          	j	2e64 <__extendsfdf2+0x3c>
    2f0c:	00000713          	li	a4,0
    2f10:	00000793          	li	a5,0
    2f14:	f51ff06f          	j	2e64 <__extendsfdf2+0x3c>
    2f18:	ff550713          	addi	a4,a0,-11
    2f1c:	00e41733          	sll	a4,s0,a4
    2f20:	00000413          	li	s0,0
    2f24:	fa1ff06f          	j	2ec4 <__extendsfdf2+0x9c>

00002f28 <__truncdfsf2>:
    2f28:	0145d693          	srli	a3,a1,0x14
    2f2c:	00c59793          	slli	a5,a1,0xc
    2f30:	7ff6f693          	andi	a3,a3,2047
    2f34:	00c7d793          	srli	a5,a5,0xc
    2f38:	00168613          	addi	a2,a3,1
    2f3c:	00379793          	slli	a5,a5,0x3
    2f40:	01d55713          	srli	a4,a0,0x1d
    2f44:	7fe67613          	andi	a2,a2,2046
    2f48:	01f5d593          	srli	a1,a1,0x1f
    2f4c:	00f76733          	or	a4,a4,a5
    2f50:	00351893          	slli	a7,a0,0x3
    2f54:	0a060463          	beqz	a2,2ffc <__truncdfsf2+0xd4>
    2f58:	c8068813          	addi	a6,a3,-896
    2f5c:	0fe00793          	li	a5,254
    2f60:	0307d463          	bge	a5,a6,2f88 <__truncdfsf2+0x60>
    2f64:	00000793          	li	a5,0
    2f68:	00979513          	slli	a0,a5,0x9
    2f6c:	0ff00693          	li	a3,255
    2f70:	01769693          	slli	a3,a3,0x17
    2f74:	00955513          	srli	a0,a0,0x9
    2f78:	01f59593          	slli	a1,a1,0x1f
    2f7c:	00d56533          	or	a0,a0,a3
    2f80:	00b56533          	or	a0,a0,a1
    2f84:	00008067          	ret
    2f88:	0f005e63          	blez	a6,3084 <__truncdfsf2+0x15c>
    2f8c:	00651793          	slli	a5,a0,0x6
    2f90:	00371713          	slli	a4,a4,0x3
    2f94:	00f037b3          	snez	a5,a5
    2f98:	00e7e7b3          	or	a5,a5,a4
    2f9c:	01d8d893          	srli	a7,a7,0x1d
    2fa0:	0117e7b3          	or	a5,a5,a7
    2fa4:	0077f713          	andi	a4,a5,7
    2fa8:	16070663          	beqz	a4,3114 <__truncdfsf2+0x1ec>
    2fac:	00f7f713          	andi	a4,a5,15
    2fb0:	00400693          	li	a3,4
    2fb4:	00d70463          	beq	a4,a3,2fbc <__truncdfsf2+0x94>
    2fb8:	00478793          	addi	a5,a5,4 # 80004 <__global_pointer$+0x793bc>
    2fbc:	04000737          	lui	a4,0x4000
    2fc0:	00e7f733          	and	a4,a5,a4
    2fc4:	14070863          	beqz	a4,3114 <__truncdfsf2+0x1ec>
    2fc8:	00180713          	addi	a4,a6,1
    2fcc:	0ff00613          	li	a2,255
    2fd0:	0ff77693          	andi	a3,a4,255
    2fd4:	f8c708e3          	beq	a4,a2,2f64 <__truncdfsf2+0x3c>
    2fd8:	00679793          	slli	a5,a5,0x6
    2fdc:	0097d793          	srli	a5,a5,0x9
    2fe0:	00979513          	slli	a0,a5,0x9
    2fe4:	01769693          	slli	a3,a3,0x17
    2fe8:	00955513          	srli	a0,a0,0x9
    2fec:	01f59593          	slli	a1,a1,0x1f
    2ff0:	00d56533          	or	a0,a0,a3
    2ff4:	00b56533          	or	a0,a0,a1
    2ff8:	00008067          	ret
    2ffc:	011767b3          	or	a5,a4,a7
    3000:	02069a63          	bnez	a3,3034 <__truncdfsf2+0x10c>
    3004:	04078e63          	beqz	a5,3060 <__truncdfsf2+0x138>
    3008:	00500793          	li	a5,5
    300c:	00679793          	slli	a5,a5,0x6
    3010:	0097d793          	srli	a5,a5,0x9
    3014:	00979513          	slli	a0,a5,0x9
    3018:	0ff6f693          	andi	a3,a3,255
    301c:	01769693          	slli	a3,a3,0x17
    3020:	00955513          	srli	a0,a0,0x9
    3024:	01f59593          	slli	a1,a1,0x1f
    3028:	00d56533          	or	a0,a0,a3
    302c:	00b56533          	or	a0,a0,a1
    3030:	00008067          	ret
    3034:	f20788e3          	beqz	a5,2f64 <__truncdfsf2+0x3c>
    3038:	004007b7          	lui	a5,0x400
    303c:	00979513          	slli	a0,a5,0x9
    3040:	0ff00693          	li	a3,255
    3044:	01769693          	slli	a3,a3,0x17
    3048:	00000593          	li	a1,0
    304c:	00955513          	srli	a0,a0,0x9
    3050:	01f59593          	slli	a1,a1,0x1f
    3054:	00d56533          	or	a0,a0,a3
    3058:	00b56533          	or	a0,a0,a1
    305c:	00008067          	ret
    3060:	00000793          	li	a5,0
    3064:	00979513          	slli	a0,a5,0x9
    3068:	00000693          	li	a3,0
    306c:	01769693          	slli	a3,a3,0x17
    3070:	00955513          	srli	a0,a0,0x9
    3074:	01f59593          	slli	a1,a1,0x1f
    3078:	00d56533          	or	a0,a0,a3
    307c:	00b56533          	or	a0,a0,a1
    3080:	00008067          	ret
    3084:	fe900793          	li	a5,-23
    3088:	06f84263          	blt	a6,a5,30ec <__truncdfsf2+0x1c4>
    308c:	01e00793          	li	a5,30
    3090:	00800637          	lui	a2,0x800
    3094:	410787b3          	sub	a5,a5,a6
    3098:	01f00513          	li	a0,31
    309c:	00c76633          	or	a2,a4,a2
    30a0:	04f55a63          	bge	a0,a5,30f4 <__truncdfsf2+0x1cc>
    30a4:	ffe00713          	li	a4,-2
    30a8:	41070733          	sub	a4,a4,a6
    30ac:	02000513          	li	a0,32
    30b0:	00e65733          	srl	a4,a2,a4
    30b4:	00a78863          	beq	a5,a0,30c4 <__truncdfsf2+0x19c>
    30b8:	ca268693          	addi	a3,a3,-862
    30bc:	00d616b3          	sll	a3,a2,a3
    30c0:	00d8e8b3          	or	a7,a7,a3
    30c4:	011037b3          	snez	a5,a7
    30c8:	00e7e7b3          	or	a5,a5,a4
    30cc:	0077f713          	andi	a4,a5,7
    30d0:	00000813          	li	a6,0
    30d4:	ec071ce3          	bnez	a4,2fac <__truncdfsf2+0x84>
    30d8:	00579713          	slli	a4,a5,0x5
    30dc:	00100693          	li	a3,1
    30e0:	ee074ce3          	bltz	a4,2fd8 <__truncdfsf2+0xb0>
    30e4:	00000693          	li	a3,0
    30e8:	f25ff06f          	j	300c <__truncdfsf2+0xe4>
    30ec:	00000693          	li	a3,0
    30f0:	f19ff06f          	j	3008 <__truncdfsf2+0xe0>
    30f4:	c8268693          	addi	a3,a3,-894
    30f8:	00d89733          	sll	a4,a7,a3
    30fc:	00e03733          	snez	a4,a4
    3100:	00d616b3          	sll	a3,a2,a3
    3104:	00f8d8b3          	srl	a7,a7,a5
    3108:	00d767b3          	or	a5,a4,a3
    310c:	00f8e7b3          	or	a5,a7,a5
    3110:	fbdff06f          	j	30cc <__truncdfsf2+0x1a4>
    3114:	00080693          	mv	a3,a6
    3118:	ef5ff06f          	j	300c <__truncdfsf2+0xe4>

0000311c <__clzsi2>:
    311c:	000107b7          	lui	a5,0x10
    3120:	04f57463          	bgeu	a0,a5,3168 <__clzsi2+0x4c>
    3124:	0ff00793          	li	a5,255
    3128:	02000713          	li	a4,32
    312c:	00a7ee63          	bltu	a5,a0,3148 <__clzsi2+0x2c>
    3130:	00003797          	auipc	a5,0x3
    3134:	c5078793          	addi	a5,a5,-944 # 5d80 <__clz_tab>
    3138:	00a787b3          	add	a5,a5,a0
    313c:	0007c503          	lbu	a0,0(a5)
    3140:	40a70533          	sub	a0,a4,a0
    3144:	00008067          	ret
    3148:	00855513          	srli	a0,a0,0x8
    314c:	00003797          	auipc	a5,0x3
    3150:	c3478793          	addi	a5,a5,-972 # 5d80 <__clz_tab>
    3154:	00a787b3          	add	a5,a5,a0
    3158:	0007c503          	lbu	a0,0(a5)
    315c:	01800713          	li	a4,24
    3160:	40a70533          	sub	a0,a4,a0
    3164:	00008067          	ret
    3168:	010007b7          	lui	a5,0x1000
    316c:	02f56263          	bltu	a0,a5,3190 <__clzsi2+0x74>
    3170:	01855513          	srli	a0,a0,0x18
    3174:	00003797          	auipc	a5,0x3
    3178:	c0c78793          	addi	a5,a5,-1012 # 5d80 <__clz_tab>
    317c:	00a787b3          	add	a5,a5,a0
    3180:	0007c503          	lbu	a0,0(a5)
    3184:	00800713          	li	a4,8
    3188:	40a70533          	sub	a0,a4,a0
    318c:	00008067          	ret
    3190:	01055513          	srli	a0,a0,0x10
    3194:	00003797          	auipc	a5,0x3
    3198:	bec78793          	addi	a5,a5,-1044 # 5d80 <__clz_tab>
    319c:	00a787b3          	add	a5,a5,a0
    31a0:	0007c503          	lbu	a0,0(a5)
    31a4:	01000713          	li	a4,16
    31a8:	40a70533          	sub	a0,a4,a0
    31ac:	00008067          	ret

000031b0 <pow>:
    31b0:	fe010113          	addi	sp,sp,-32
    31b4:	00812c23          	sw	s0,24(sp)
    31b8:	00912a23          	sw	s1,20(sp)
    31bc:	01212823          	sw	s2,16(sp)
    31c0:	01312623          	sw	s3,12(sp)
    31c4:	01412423          	sw	s4,8(sp)
    31c8:	01512223          	sw	s5,4(sp)
    31cc:	00112e23          	sw	ra,28(sp)
    31d0:	00050913          	mv	s2,a0
    31d4:	00058993          	mv	s3,a1
    31d8:	00060413          	mv	s0,a2
    31dc:	00068493          	mv	s1,a3
    31e0:	240000ef          	jal	ra,3420 <__ieee754_pow>
    31e4:	81018793          	addi	a5,gp,-2032 # 6458 <__fdlib_version>
    31e8:	0007a703          	lw	a4,0(a5)
    31ec:	fff00793          	li	a5,-1
    31f0:	00050a13          	mv	s4,a0
    31f4:	00058a93          	mv	s5,a1
    31f8:	08f70663          	beq	a4,a5,3284 <pow+0xd4>
    31fc:	00040613          	mv	a2,s0
    3200:	00048693          	mv	a3,s1
    3204:	00040513          	mv	a0,s0
    3208:	00048593          	mv	a1,s1
    320c:	23d020ef          	jal	ra,5c48 <__unorddf2>
    3210:	06051a63          	bnez	a0,3284 <pow+0xd4>
    3214:	00090613          	mv	a2,s2
    3218:	00098693          	mv	a3,s3
    321c:	00090513          	mv	a0,s2
    3220:	00098593          	mv	a1,s3
    3224:	225020ef          	jal	ra,5c48 <__unorddf2>
    3228:	00000613          	li	a2,0
    322c:	00000693          	li	a3,0
    3230:	0e051063          	bnez	a0,3310 <pow+0x160>
    3234:	00090513          	mv	a0,s2
    3238:	00098593          	mv	a1,s3
    323c:	085020ef          	jal	ra,5ac0 <__eqdf2>
    3240:	06051863          	bnez	a0,32b0 <pow+0x100>
    3244:	00000613          	li	a2,0
    3248:	00000693          	li	a3,0
    324c:	00040513          	mv	a0,s0
    3250:	00048593          	mv	a1,s1
    3254:	06d020ef          	jal	ra,5ac0 <__eqdf2>
    3258:	0c050463          	beqz	a0,3320 <pow+0x170>
    325c:	00040513          	mv	a0,s0
    3260:	00048593          	mv	a1,s1
    3264:	454010ef          	jal	ra,46b8 <finite>
    3268:	00050e63          	beqz	a0,3284 <pow+0xd4>
    326c:	00000613          	li	a2,0
    3270:	00000693          	li	a3,0
    3274:	00040513          	mv	a0,s0
    3278:	00048593          	mv	a1,s1
    327c:	89dfe0ef          	jal	ra,1b18 <__ledf2>
    3280:	12054263          	bltz	a0,33a4 <pow+0x1f4>
    3284:	01c12083          	lw	ra,28(sp)
    3288:	01812403          	lw	s0,24(sp)
    328c:	000a0513          	mv	a0,s4
    3290:	000a8593          	mv	a1,s5
    3294:	01412483          	lw	s1,20(sp)
    3298:	01012903          	lw	s2,16(sp)
    329c:	00c12983          	lw	s3,12(sp)
    32a0:	00812a03          	lw	s4,8(sp)
    32a4:	00412a83          	lw	s5,4(sp)
    32a8:	02010113          	addi	sp,sp,32
    32ac:	00008067          	ret
    32b0:	000a0513          	mv	a0,s4
    32b4:	000a8593          	mv	a1,s5
    32b8:	400010ef          	jal	ra,46b8 <finite>
    32bc:	06050c63          	beqz	a0,3334 <pow+0x184>
    32c0:	00000613          	li	a2,0
    32c4:	00000693          	li	a3,0
    32c8:	000a0513          	mv	a0,s4
    32cc:	000a8593          	mv	a1,s5
    32d0:	7f0020ef          	jal	ra,5ac0 <__eqdf2>
    32d4:	fa0518e3          	bnez	a0,3284 <pow+0xd4>
    32d8:	00090513          	mv	a0,s2
    32dc:	00098593          	mv	a1,s3
    32e0:	3d8010ef          	jal	ra,46b8 <finite>
    32e4:	fa0500e3          	beqz	a0,3284 <pow+0xd4>
    32e8:	00040513          	mv	a0,s0
    32ec:	00048593          	mv	a1,s1
    32f0:	3c8010ef          	jal	ra,46b8 <finite>
    32f4:	f80508e3          	beqz	a0,3284 <pow+0xd4>
    32f8:	1a5020ef          	jal	ra,5c9c <__errno>
    32fc:	02200793          	li	a5,34
    3300:	00f52023          	sw	a5,0(a0)
    3304:	00000a13          	li	s4,0
    3308:	00000a93          	li	s5,0
    330c:	f79ff06f          	j	3284 <pow+0xd4>
    3310:	00040513          	mv	a0,s0
    3314:	00048593          	mv	a1,s1
    3318:	7a8020ef          	jal	ra,5ac0 <__eqdf2>
    331c:	f60514e3          	bnez	a0,3284 <pow+0xd4>
    3320:	00003797          	auipc	a5,0x3
    3324:	b6078793          	addi	a5,a5,-1184 # 5e80 <__clz_tab+0x100>
    3328:	0007aa03          	lw	s4,0(a5)
    332c:	0047aa83          	lw	s5,4(a5)
    3330:	f55ff06f          	j	3284 <pow+0xd4>
    3334:	00090513          	mv	a0,s2
    3338:	00098593          	mv	a1,s3
    333c:	37c010ef          	jal	ra,46b8 <finite>
    3340:	f80500e3          	beqz	a0,32c0 <pow+0x110>
    3344:	00040513          	mv	a0,s0
    3348:	00048593          	mv	a1,s1
    334c:	36c010ef          	jal	ra,46b8 <finite>
    3350:	f60508e3          	beqz	a0,32c0 <pow+0x110>
    3354:	000a0613          	mv	a2,s4
    3358:	000a8693          	mv	a3,s5
    335c:	000a0513          	mv	a0,s4
    3360:	000a8593          	mv	a1,s5
    3364:	0e5020ef          	jal	ra,5c48 <__unorddf2>
    3368:	08051663          	bnez	a0,33f4 <pow+0x244>
    336c:	131020ef          	jal	ra,5c9c <__errno>
    3370:	02200793          	li	a5,34
    3374:	00f52023          	sw	a5,0(a0)
    3378:	00000613          	li	a2,0
    337c:	00000693          	li	a3,0
    3380:	00090513          	mv	a0,s2
    3384:	00098593          	mv	a1,s3
    3388:	f90fe0ef          	jal	ra,1b18 <__ledf2>
    338c:	02054c63          	bltz	a0,33c4 <pow+0x214>
    3390:	00003797          	auipc	a5,0x3
    3394:	b0078793          	addi	a5,a5,-1280 # 5e90 <__clz_tab+0x110>
    3398:	0007aa03          	lw	s4,0(a5)
    339c:	0047aa83          	lw	s5,4(a5)
    33a0:	ee5ff06f          	j	3284 <pow+0xd4>
    33a4:	0f9020ef          	jal	ra,5c9c <__errno>
    33a8:	02100793          	li	a5,33
    33ac:	00f52023          	sw	a5,0(a0)
    33b0:	00003797          	auipc	a5,0x3
    33b4:	ad878793          	addi	a5,a5,-1320 # 5e88 <__clz_tab+0x108>
    33b8:	0007aa03          	lw	s4,0(a5)
    33bc:	0047aa83          	lw	s5,4(a5)
    33c0:	ec5ff06f          	j	3284 <pow+0xd4>
    33c4:	00040513          	mv	a0,s0
    33c8:	00048593          	mv	a1,s1
    33cc:	318010ef          	jal	ra,46e4 <rint>
    33d0:	00040613          	mv	a2,s0
    33d4:	00048693          	mv	a3,s1
    33d8:	6e8020ef          	jal	ra,5ac0 <__eqdf2>
    33dc:	fa050ae3          	beqz	a0,3390 <pow+0x1e0>
    33e0:	00003797          	auipc	a5,0x3
    33e4:	aa878793          	addi	a5,a5,-1368 # 5e88 <__clz_tab+0x108>
    33e8:	0007aa03          	lw	s4,0(a5)
    33ec:	0047aa83          	lw	s5,4(a5)
    33f0:	e95ff06f          	j	3284 <pow+0xd4>
    33f4:	0a9020ef          	jal	ra,5c9c <__errno>
    33f8:	02100793          	li	a5,33
    33fc:	00000613          	li	a2,0
    3400:	00000693          	li	a3,0
    3404:	00f52023          	sw	a5,0(a0)
    3408:	00068593          	mv	a1,a3
    340c:	00060513          	mv	a0,a2
    3410:	735010ef          	jal	ra,5344 <__divdf3>
    3414:	00050a13          	mv	s4,a0
    3418:	00058a93          	mv	s5,a1
    341c:	e69ff06f          	j	3284 <pow+0xd4>

00003420 <__ieee754_pow>:
    3420:	80000837          	lui	a6,0x80000
    3424:	f8010113          	addi	sp,sp,-128
    3428:	fff84813          	not	a6,a6
    342c:	07212823          	sw	s2,112(sp)
    3430:	0106f933          	and	s2,a3,a6
    3434:	06112e23          	sw	ra,124(sp)
    3438:	06812c23          	sw	s0,120(sp)
    343c:	06912a23          	sw	s1,116(sp)
    3440:	07312623          	sw	s3,108(sp)
    3444:	07412423          	sw	s4,104(sp)
    3448:	07512223          	sw	s5,100(sp)
    344c:	07612023          	sw	s6,96(sp)
    3450:	05712e23          	sw	s7,92(sp)
    3454:	05812c23          	sw	s8,88(sp)
    3458:	05912a23          	sw	s9,84(sp)
    345c:	05a12823          	sw	s10,80(sp)
    3460:	05b12623          	sw	s11,76(sp)
    3464:	00c967b3          	or	a5,s2,a2
    3468:	10078063          	beqz	a5,3568 <__ieee754_pow+0x148>
    346c:	00b87433          	and	s0,a6,a1
    3470:	7ff007b7          	lui	a5,0x7ff00
    3474:	00058a93          	mv	s5,a1
    3478:	00050a13          	mv	s4,a0
    347c:	0487dc63          	bge	a5,s0,34d4 <__ieee754_pow+0xb4>
    3480:	c0100837          	lui	a6,0xc0100
    3484:	01040833          	add	a6,s0,a6
    3488:	00a86833          	or	a6,a6,a0
    348c:	3ff005b7          	lui	a1,0x3ff00
    3490:	00000513          	li	a0,0
    3494:	0e081463          	bnez	a6,357c <__ieee754_pow+0x15c>
    3498:	07c12083          	lw	ra,124(sp)
    349c:	07812403          	lw	s0,120(sp)
    34a0:	07412483          	lw	s1,116(sp)
    34a4:	07012903          	lw	s2,112(sp)
    34a8:	06c12983          	lw	s3,108(sp)
    34ac:	06812a03          	lw	s4,104(sp)
    34b0:	06412a83          	lw	s5,100(sp)
    34b4:	06012b03          	lw	s6,96(sp)
    34b8:	05c12b83          	lw	s7,92(sp)
    34bc:	05812c03          	lw	s8,88(sp)
    34c0:	05412c83          	lw	s9,84(sp)
    34c4:	05012d03          	lw	s10,80(sp)
    34c8:	04c12d83          	lw	s11,76(sp)
    34cc:	08010113          	addi	sp,sp,128
    34d0:	00008067          	ret
    34d4:	0af40063          	beq	s0,a5,3574 <__ieee754_pow+0x154>
    34d8:	fb27c4e3          	blt	a5,s2,3480 <__ieee754_pow+0x60>
    34dc:	7ff007b7          	lui	a5,0x7ff00
    34e0:	24f90e63          	beq	s2,a5,373c <__ieee754_pow+0x31c>
    34e4:	00058493          	mv	s1,a1
    34e8:	00050993          	mv	s3,a0
    34ec:	00060c93          	mv	s9,a2
    34f0:	00068d93          	mv	s11,a3
    34f4:	00000d13          	li	s10,0
    34f8:	0c0ac463          	bltz	s5,35c0 <__ieee754_pow+0x1a0>
    34fc:	100c9463          	bnez	s9,3604 <__ieee754_pow+0x1e4>
    3500:	7ff006b7          	lui	a3,0x7ff00
    3504:	1ad90663          	beq	s2,a3,36b0 <__ieee754_pow+0x290>
    3508:	3ff006b7          	lui	a3,0x3ff00
    350c:	1cd90a63          	beq	s2,a3,36e0 <__ieee754_pow+0x2c0>
    3510:	400006b7          	lui	a3,0x40000
    3514:	60dd80e3          	beq	s11,a3,4314 <__ieee754_pow+0xef4>
    3518:	3fe006b7          	lui	a3,0x3fe00
    351c:	0edd9463          	bne	s11,a3,3604 <__ieee754_pow+0x1e4>
    3520:	0e0ac263          	bltz	s5,3604 <__ieee754_pow+0x1e4>
    3524:	07812403          	lw	s0,120(sp)
    3528:	07c12083          	lw	ra,124(sp)
    352c:	07012903          	lw	s2,112(sp)
    3530:	06812a03          	lw	s4,104(sp)
    3534:	06412a83          	lw	s5,100(sp)
    3538:	06012b03          	lw	s6,96(sp)
    353c:	05c12b83          	lw	s7,92(sp)
    3540:	05812c03          	lw	s8,88(sp)
    3544:	05412c83          	lw	s9,84(sp)
    3548:	05012d03          	lw	s10,80(sp)
    354c:	04c12d83          	lw	s11,76(sp)
    3550:	00098513          	mv	a0,s3
    3554:	00048593          	mv	a1,s1
    3558:	06c12983          	lw	s3,108(sp)
    355c:	07412483          	lw	s1,116(sp)
    3560:	08010113          	addi	sp,sp,128
    3564:	6950006f          	j	43f8 <__ieee754_sqrt>
    3568:	00000513          	li	a0,0
    356c:	3ff005b7          	lui	a1,0x3ff00
    3570:	f29ff06f          	j	3498 <__ieee754_pow+0x78>
    3574:	00051463          	bnez	a0,357c <__ieee754_pow+0x15c>
    3578:	f72452e3          	bge	s0,s2,34dc <__ieee754_pow+0xbc>
    357c:	07812403          	lw	s0,120(sp)
    3580:	07c12083          	lw	ra,124(sp)
    3584:	07412483          	lw	s1,116(sp)
    3588:	07012903          	lw	s2,112(sp)
    358c:	06c12983          	lw	s3,108(sp)
    3590:	06812a03          	lw	s4,104(sp)
    3594:	06412a83          	lw	s5,100(sp)
    3598:	06012b03          	lw	s6,96(sp)
    359c:	05c12b83          	lw	s7,92(sp)
    35a0:	05812c03          	lw	s8,88(sp)
    35a4:	05412c83          	lw	s9,84(sp)
    35a8:	05012d03          	lw	s10,80(sp)
    35ac:	04c12d83          	lw	s11,76(sp)
    35b0:	00002517          	auipc	a0,0x2
    35b4:	74c50513          	addi	a0,a0,1868 # 5cfc <_data+0x50>
    35b8:	08010113          	addi	sp,sp,128
    35bc:	1140106f          	j	46d0 <nan>
    35c0:	434006b7          	lui	a3,0x43400
    35c4:	18d95063          	bge	s2,a3,3744 <__ieee754_pow+0x324>
    35c8:	3ff006b7          	lui	a3,0x3ff00
    35cc:	02d94a63          	blt	s2,a3,3600 <__ieee754_pow+0x1e0>
    35d0:	41495693          	srai	a3,s2,0x14
    35d4:	c0168693          	addi	a3,a3,-1023 # 3feffc01 <__freertos_irq_stack_top+0x3fcf9761>
    35d8:	01400613          	li	a2,20
    35dc:	54d658e3          	bge	a2,a3,432c <__ieee754_pow+0xf0c>
    35e0:	03400613          	li	a2,52
    35e4:	40d606b3          	sub	a3,a2,a3
    35e8:	00dcd633          	srl	a2,s9,a3
    35ec:	00d616b3          	sll	a3,a2,a3
    35f0:	01969863          	bne	a3,s9,3600 <__ieee754_pow+0x1e0>
    35f4:	00167613          	andi	a2,a2,1
    35f8:	00200313          	li	t1,2
    35fc:	40c30d33          	sub	s10,t1,a2
    3600:	f00c84e3          	beqz	s9,3508 <__ieee754_pow+0xe8>
    3604:	00098513          	mv	a0,s3
    3608:	00048593          	mv	a1,s1
    360c:	0a0010ef          	jal	ra,46ac <fabs>
    3610:	040a0c63          	beqz	s4,3668 <__ieee754_pow+0x248>
    3614:	01f4de13          	srli	t3,s1,0x1f
    3618:	fffe0e13          	addi	t3,t3,-1
    361c:	01cd66b3          	or	a3,s10,t3
    3620:	12068663          	beqz	a3,374c <__ieee754_pow+0x32c>
    3624:	41e006b7          	lui	a3,0x41e00
    3628:	1526d463          	bge	a3,s2,3770 <__ieee754_pow+0x350>
    362c:	43f006b7          	lui	a3,0x43f00
    3630:	3526dce3          	bge	a3,s2,4188 <__ieee754_pow+0xd68>
    3634:	3ff00737          	lui	a4,0x3ff00
    3638:	0ce45a63          	bge	s0,a4,370c <__ieee754_pow+0x2ec>
    363c:	080ddc63          	bgez	s11,36d4 <__ieee754_pow+0x2b4>
    3640:	00003797          	auipc	a5,0x3
    3644:	87878793          	addi	a5,a5,-1928 # 5eb8 <__clz_tab+0x138>
    3648:	0007a603          	lw	a2,0(a5)
    364c:	0047a683          	lw	a3,4(a5)
    3650:	00060513          	mv	a0,a2
    3654:	00068593          	mv	a1,a3
    3658:	dc0fe0ef          	jal	ra,1c18 <__muldf3>
    365c:	e3dff06f          	j	3498 <__ieee754_pow+0x78>
    3660:	04c010ef          	jal	ra,46ac <fabs>
    3664:	0e0a1463          	bnez	s4,374c <__ieee754_pow+0x32c>
    3668:	00040a63          	beqz	s0,367c <__ieee754_pow+0x25c>
    366c:	00249693          	slli	a3,s1,0x2
    3670:	0026d693          	srli	a3,a3,0x2
    3674:	3ff00637          	lui	a2,0x3ff00
    3678:	f8c69ee3          	bne	a3,a2,3614 <__ieee754_pow+0x1f4>
    367c:	080dcc63          	bltz	s11,3714 <__ieee754_pow+0x2f4>
    3680:	e00adce3          	bgez	s5,3498 <__ieee754_pow+0x78>
    3684:	c01007b7          	lui	a5,0xc0100
    3688:	00f407b3          	add	a5,s0,a5
    368c:	01a7e7b3          	or	a5,a5,s10
    3690:	4e0796e3          	bnez	a5,437c <__ieee754_pow+0xf5c>
    3694:	00050613          	mv	a2,a0
    3698:	00058693          	mv	a3,a1
    369c:	bd1fe0ef          	jal	ra,226c <__subdf3>
    36a0:	00050613          	mv	a2,a0
    36a4:	00058693          	mv	a3,a1
    36a8:	49d010ef          	jal	ra,5344 <__divdf3>
    36ac:	dedff06f          	j	3498 <__ieee754_pow+0x78>
    36b0:	c0100537          	lui	a0,0xc0100
    36b4:	00a40533          	add	a0,s0,a0
    36b8:	01356533          	or	a0,a0,s3
    36bc:	ea0506e3          	beqz	a0,3568 <__ieee754_pow+0x148>
    36c0:	3ff00737          	lui	a4,0x3ff00
    36c4:	2ae442e3          	blt	s0,a4,4168 <__ieee754_pow+0xd48>
    36c8:	000d8593          	mv	a1,s11
    36cc:	00000513          	li	a0,0
    36d0:	dc0dd4e3          	bgez	s11,3498 <__ieee754_pow+0x78>
    36d4:	00000513          	li	a0,0
    36d8:	00000593          	li	a1,0
    36dc:	dbdff06f          	j	3498 <__ieee754_pow+0x78>
    36e0:	00098513          	mv	a0,s3
    36e4:	00048593          	mv	a1,s1
    36e8:	da0dd8e3          	bgez	s11,3498 <__ieee754_pow+0x78>
    36ec:	00002797          	auipc	a5,0x2
    36f0:	79478793          	addi	a5,a5,1940 # 5e80 <__clz_tab+0x100>
    36f4:	0007a503          	lw	a0,0(a5)
    36f8:	0047a583          	lw	a1,4(a5)
    36fc:	00098613          	mv	a2,s3
    3700:	00048693          	mv	a3,s1
    3704:	441010ef          	jal	ra,5344 <__divdf3>
    3708:	d91ff06f          	j	3498 <__ieee754_pow+0x78>
    370c:	f3b04ae3          	bgtz	s11,3640 <__ieee754_pow+0x220>
    3710:	fc5ff06f          	j	36d4 <__ieee754_pow+0x2b4>
    3714:	00002717          	auipc	a4,0x2
    3718:	76c70713          	addi	a4,a4,1900 # 5e80 <__clz_tab+0x100>
    371c:	00050c93          	mv	s9,a0
    3720:	00058793          	mv	a5,a1
    3724:	00072503          	lw	a0,0(a4)
    3728:	00472583          	lw	a1,4(a4)
    372c:	000c8613          	mv	a2,s9
    3730:	00078693          	mv	a3,a5
    3734:	411010ef          	jal	ra,5344 <__divdf3>
    3738:	f49ff06f          	j	3680 <__ieee754_pow+0x260>
    373c:	da0604e3          	beqz	a2,34e4 <__ieee754_pow+0xc4>
    3740:	d41ff06f          	j	3480 <__ieee754_pow+0x60>
    3744:	00200d13          	li	s10,2
    3748:	db5ff06f          	j	34fc <__ieee754_pow+0xdc>
    374c:	00098613          	mv	a2,s3
    3750:	00048693          	mv	a3,s1
    3754:	00098513          	mv	a0,s3
    3758:	00048593          	mv	a1,s1
    375c:	b11fe0ef          	jal	ra,226c <__subdf3>
    3760:	00050613          	mv	a2,a0
    3764:	00058693          	mv	a3,a1
    3768:	3dd010ef          	jal	ra,5344 <__divdf3>
    376c:	d2dff06f          	j	3498 <__ieee754_pow+0x78>
    3770:	7ff006b7          	lui	a3,0x7ff00
    3774:	0096f4b3          	and	s1,a3,s1
    3778:	00000613          	li	a2,0
    377c:	02049463          	bnez	s1,37a4 <__ieee754_pow+0x384>
    3780:	00002697          	auipc	a3,0x2
    3784:	77068693          	addi	a3,a3,1904 # 5ef0 <__clz_tab+0x170>
    3788:	0006a603          	lw	a2,0(a3)
    378c:	0046a683          	lw	a3,4(a3)
    3790:	01c12423          	sw	t3,8(sp)
    3794:	c84fe0ef          	jal	ra,1c18 <__muldf3>
    3798:	00812e03          	lw	t3,8(sp)
    379c:	00058413          	mv	s0,a1
    37a0:	fcb00613          	li	a2,-53
    37a4:	001005b7          	lui	a1,0x100
    37a8:	41445e93          	srai	t4,s0,0x14
    37ac:	fff58813          	addi	a6,a1,-1 # fffff <__global_pointer$+0xf93b7>
    37b0:	0003a6b7          	lui	a3,0x3a
    37b4:	c01e8e93          	addi	t4,t4,-1023
    37b8:	01047833          	and	a6,s0,a6
    37bc:	3ff00c37          	lui	s8,0x3ff00
    37c0:	88e68693          	addi	a3,a3,-1906 # 3988e <__global_pointer$+0x32c46>
    37c4:	00ce8eb3          	add	t4,t4,a2
    37c8:	01886c33          	or	s8,a6,s8
    37cc:	1b06d8e3          	bge	a3,a6,417c <__ieee754_pow+0xd5c>
    37d0:	000bb6b7          	lui	a3,0xbb
    37d4:	67968693          	addi	a3,a3,1657 # bb679 <__global_pointer$+0xb4a31>
    37d8:	3b06dee3          	bge	a3,a6,4394 <__ieee754_pow+0xf74>
    37dc:	00002a97          	auipc	s5,0x2
    37e0:	6a4a8a93          	addi	s5,s5,1700 # 5e80 <__clz_tab+0x100>
    37e4:	001e8e93          	addi	t4,t4,1
    37e8:	40bc0c33          	sub	s8,s8,a1
    37ec:	000aa783          	lw	a5,0(s5)
    37f0:	004aa803          	lw	a6,4(s5)
    37f4:	00012823          	sw	zero,16(sp)
    37f8:	00012a23          	sw	zero,20(sp)
    37fc:	02012c23          	sw	zero,56(sp)
    3800:	02012e23          	sw	zero,60(sp)
    3804:	00000993          	li	s3,0
    3808:	00f12423          	sw	a5,8(sp)
    380c:	01012623          	sw	a6,12(sp)
    3810:	00812403          	lw	s0,8(sp)
    3814:	00c12483          	lw	s1,12(sp)
    3818:	000c0593          	mv	a1,s8
    381c:	00040613          	mv	a2,s0
    3820:	00048693          	mv	a3,s1
    3824:	03d12a23          	sw	t4,52(sp)
    3828:	03c12823          	sw	t3,48(sp)
    382c:	00050913          	mv	s2,a0
    3830:	a3dfe0ef          	jal	ra,226c <__subdf3>
    3834:	00050b13          	mv	s6,a0
    3838:	00058b93          	mv	s7,a1
    383c:	00040613          	mv	a2,s0
    3840:	00048693          	mv	a3,s1
    3844:	00090513          	mv	a0,s2
    3848:	000c0593          	mv	a1,s8
    384c:	00812423          	sw	s0,8(sp)
    3850:	00912623          	sw	s1,12(sp)
    3854:	26c010ef          	jal	ra,4ac0 <__adddf3>
    3858:	00050613          	mv	a2,a0
    385c:	00058693          	mv	a3,a1
    3860:	000aa503          	lw	a0,0(s5)
    3864:	004aa583          	lw	a1,4(s5)
    3868:	00000493          	li	s1,0
    386c:	2d9010ef          	jal	ra,5344 <__divdf3>
    3870:	00050613          	mv	a2,a0
    3874:	00058693          	mv	a3,a1
    3878:	00a12c23          	sw	a0,24(sp)
    387c:	00b12e23          	sw	a1,28(sp)
    3880:	000b0513          	mv	a0,s6
    3884:	000b8593          	mv	a1,s7
    3888:	b90fe0ef          	jal	ra,1c18 <__muldf3>
    388c:	401c5f13          	srai	t5,s8,0x1
    3890:	200006b7          	lui	a3,0x20000
    3894:	00df6f33          	or	t5,t5,a3
    3898:	000806b7          	lui	a3,0x80
    389c:	00df0f33          	add	t5,t5,a3
    38a0:	013f09b3          	add	s3,t5,s3
    38a4:	00050a13          	mv	s4,a0
    38a8:	00098693          	mv	a3,s3
    38ac:	00000613          	li	a2,0
    38b0:	00048513          	mv	a0,s1
    38b4:	00058413          	mv	s0,a1
    38b8:	b60fe0ef          	jal	ra,1c18 <__muldf3>
    38bc:	00050613          	mv	a2,a0
    38c0:	00058693          	mv	a3,a1
    38c4:	000b0513          	mv	a0,s6
    38c8:	000b8593          	mv	a1,s7
    38cc:	9a1fe0ef          	jal	ra,226c <__subdf3>
    38d0:	00812603          	lw	a2,8(sp)
    38d4:	00c12683          	lw	a3,12(sp)
    38d8:	00050b13          	mv	s6,a0
    38dc:	00058b93          	mv	s7,a1
    38e0:	00000513          	li	a0,0
    38e4:	00098593          	mv	a1,s3
    38e8:	985fe0ef          	jal	ra,226c <__subdf3>
    38ec:	00050613          	mv	a2,a0
    38f0:	00058693          	mv	a3,a1
    38f4:	00090513          	mv	a0,s2
    38f8:	000c0593          	mv	a1,s8
    38fc:	971fe0ef          	jal	ra,226c <__subdf3>
    3900:	00048613          	mv	a2,s1
    3904:	00040693          	mv	a3,s0
    3908:	b10fe0ef          	jal	ra,1c18 <__muldf3>
    390c:	00050613          	mv	a2,a0
    3910:	00058693          	mv	a3,a1
    3914:	000b0513          	mv	a0,s6
    3918:	000b8593          	mv	a1,s7
    391c:	951fe0ef          	jal	ra,226c <__subdf3>
    3920:	01812803          	lw	a6,24(sp)
    3924:	01c12883          	lw	a7,28(sp)
    3928:	00002b97          	auipc	s7,0x2
    392c:	600b8b93          	addi	s7,s7,1536 # 5f28 <__clz_tab+0x1a8>
    3930:	00080613          	mv	a2,a6
    3934:	00088693          	mv	a3,a7
    3938:	ae0fe0ef          	jal	ra,1c18 <__muldf3>
    393c:	000a0613          	mv	a2,s4
    3940:	00040693          	mv	a3,s0
    3944:	00a12423          	sw	a0,8(sp)
    3948:	00b12623          	sw	a1,12(sp)
    394c:	000a0513          	mv	a0,s4
    3950:	00040593          	mv	a1,s0
    3954:	ac4fe0ef          	jal	ra,1c18 <__muldf3>
    3958:	00002697          	auipc	a3,0x2
    395c:	5a068693          	addi	a3,a3,1440 # 5ef8 <__clz_tab+0x178>
    3960:	0006a603          	lw	a2,0(a3)
    3964:	0046a683          	lw	a3,4(a3)
    3968:	00050913          	mv	s2,a0
    396c:	00058993          	mv	s3,a1
    3970:	aa8fe0ef          	jal	ra,1c18 <__muldf3>
    3974:	00002697          	auipc	a3,0x2
    3978:	58c68693          	addi	a3,a3,1420 # 5f00 <__clz_tab+0x180>
    397c:	0006a603          	lw	a2,0(a3)
    3980:	0046a683          	lw	a3,4(a3)
    3984:	00000b13          	li	s6,0
    3988:	00000c13          	li	s8,0
    398c:	134010ef          	jal	ra,4ac0 <__adddf3>
    3990:	00090613          	mv	a2,s2
    3994:	00098693          	mv	a3,s3
    3998:	a80fe0ef          	jal	ra,1c18 <__muldf3>
    399c:	00002697          	auipc	a3,0x2
    39a0:	56c68693          	addi	a3,a3,1388 # 5f08 <__clz_tab+0x188>
    39a4:	0006a603          	lw	a2,0(a3)
    39a8:	0046a683          	lw	a3,4(a3)
    39ac:	114010ef          	jal	ra,4ac0 <__adddf3>
    39b0:	00090613          	mv	a2,s2
    39b4:	00098693          	mv	a3,s3
    39b8:	a60fe0ef          	jal	ra,1c18 <__muldf3>
    39bc:	00002697          	auipc	a3,0x2
    39c0:	55468693          	addi	a3,a3,1364 # 5f10 <__clz_tab+0x190>
    39c4:	0006a603          	lw	a2,0(a3)
    39c8:	0046a683          	lw	a3,4(a3)
    39cc:	0f4010ef          	jal	ra,4ac0 <__adddf3>
    39d0:	00090613          	mv	a2,s2
    39d4:	00098693          	mv	a3,s3
    39d8:	a40fe0ef          	jal	ra,1c18 <__muldf3>
    39dc:	00002697          	auipc	a3,0x2
    39e0:	53c68693          	addi	a3,a3,1340 # 5f18 <__clz_tab+0x198>
    39e4:	0006a603          	lw	a2,0(a3)
    39e8:	0046a683          	lw	a3,4(a3)
    39ec:	0d4010ef          	jal	ra,4ac0 <__adddf3>
    39f0:	00090613          	mv	a2,s2
    39f4:	00098693          	mv	a3,s3
    39f8:	a20fe0ef          	jal	ra,1c18 <__muldf3>
    39fc:	00002697          	auipc	a3,0x2
    3a00:	52468693          	addi	a3,a3,1316 # 5f20 <__clz_tab+0x1a0>
    3a04:	0006a603          	lw	a2,0(a3)
    3a08:	0046a683          	lw	a3,4(a3)
    3a0c:	0b4010ef          	jal	ra,4ac0 <__adddf3>
    3a10:	00090613          	mv	a2,s2
    3a14:	00098693          	mv	a3,s3
    3a18:	00a12c23          	sw	a0,24(sp)
    3a1c:	00b12e23          	sw	a1,28(sp)
    3a20:	00090513          	mv	a0,s2
    3a24:	00098593          	mv	a1,s3
    3a28:	9f0fe0ef          	jal	ra,1c18 <__muldf3>
    3a2c:	01812703          	lw	a4,24(sp)
    3a30:	01c12783          	lw	a5,28(sp)
    3a34:	00050613          	mv	a2,a0
    3a38:	00058693          	mv	a3,a1
    3a3c:	00070513          	mv	a0,a4
    3a40:	00078593          	mv	a1,a5
    3a44:	9d4fe0ef          	jal	ra,1c18 <__muldf3>
    3a48:	00050913          	mv	s2,a0
    3a4c:	00058993          	mv	s3,a1
    3a50:	00048613          	mv	a2,s1
    3a54:	00040693          	mv	a3,s0
    3a58:	000a0513          	mv	a0,s4
    3a5c:	00040593          	mv	a1,s0
    3a60:	060010ef          	jal	ra,4ac0 <__adddf3>
    3a64:	00812603          	lw	a2,8(sp)
    3a68:	00c12683          	lw	a3,12(sp)
    3a6c:	9acfe0ef          	jal	ra,1c18 <__muldf3>
    3a70:	00090613          	mv	a2,s2
    3a74:	00098693          	mv	a3,s3
    3a78:	048010ef          	jal	ra,4ac0 <__adddf3>
    3a7c:	00050913          	mv	s2,a0
    3a80:	00058993          	mv	s3,a1
    3a84:	00048613          	mv	a2,s1
    3a88:	00040693          	mv	a3,s0
    3a8c:	00048513          	mv	a0,s1
    3a90:	00040593          	mv	a1,s0
    3a94:	984fe0ef          	jal	ra,1c18 <__muldf3>
    3a98:	000ba603          	lw	a2,0(s7)
    3a9c:	004ba683          	lw	a3,4(s7)
    3aa0:	02a12423          	sw	a0,40(sp)
    3aa4:	02b12623          	sw	a1,44(sp)
    3aa8:	018010ef          	jal	ra,4ac0 <__adddf3>
    3aac:	00090613          	mv	a2,s2
    3ab0:	00098693          	mv	a3,s3
    3ab4:	01212c23          	sw	s2,24(sp)
    3ab8:	01312e23          	sw	s3,28(sp)
    3abc:	004010ef          	jal	ra,4ac0 <__adddf3>
    3ac0:	00058913          	mv	s2,a1
    3ac4:	000b0613          	mv	a2,s6
    3ac8:	00058693          	mv	a3,a1
    3acc:	00048513          	mv	a0,s1
    3ad0:	00040593          	mv	a1,s0
    3ad4:	944fe0ef          	jal	ra,1c18 <__muldf3>
    3ad8:	000ba603          	lw	a2,0(s7)
    3adc:	004ba683          	lw	a3,4(s7)
    3ae0:	02a12023          	sw	a0,32(sp)
    3ae4:	02b12223          	sw	a1,36(sp)
    3ae8:	000b0513          	mv	a0,s6
    3aec:	00090593          	mv	a1,s2
    3af0:	f7cfe0ef          	jal	ra,226c <__subdf3>
    3af4:	02812f03          	lw	t5,40(sp)
    3af8:	02c12f83          	lw	t6,44(sp)
    3afc:	000f0613          	mv	a2,t5
    3b00:	000f8693          	mv	a3,t6
    3b04:	f68fe0ef          	jal	ra,226c <__subdf3>
    3b08:	00050613          	mv	a2,a0
    3b0c:	00058693          	mv	a3,a1
    3b10:	01812503          	lw	a0,24(sp)
    3b14:	01c12583          	lw	a1,28(sp)
    3b18:	f54fe0ef          	jal	ra,226c <__subdf3>
    3b1c:	000a0613          	mv	a2,s4
    3b20:	00040693          	mv	a3,s0
    3b24:	8f4fe0ef          	jal	ra,1c18 <__muldf3>
    3b28:	00050413          	mv	s0,a0
    3b2c:	00058493          	mv	s1,a1
    3b30:	00812503          	lw	a0,8(sp)
    3b34:	00c12583          	lw	a1,12(sp)
    3b38:	000b0613          	mv	a2,s6
    3b3c:	00090693          	mv	a3,s2
    3b40:	8d8fe0ef          	jal	ra,1c18 <__muldf3>
    3b44:	00050613          	mv	a2,a0
    3b48:	00058693          	mv	a3,a1
    3b4c:	00040513          	mv	a0,s0
    3b50:	00048593          	mv	a1,s1
    3b54:	76d000ef          	jal	ra,4ac0 <__adddf3>
    3b58:	02012b03          	lw	s6,32(sp)
    3b5c:	02412b83          	lw	s7,36(sp)
    3b60:	00050413          	mv	s0,a0
    3b64:	00058493          	mv	s1,a1
    3b68:	00050613          	mv	a2,a0
    3b6c:	00058693          	mv	a3,a1
    3b70:	000b0513          	mv	a0,s6
    3b74:	000b8593          	mv	a1,s7
    3b78:	749000ef          	jal	ra,4ac0 <__adddf3>
    3b7c:	00002697          	auipc	a3,0x2
    3b80:	3b468693          	addi	a3,a3,948 # 5f30 <__clz_tab+0x1b0>
    3b84:	0006a603          	lw	a2,0(a3)
    3b88:	0046a683          	lw	a3,4(a3)
    3b8c:	000c0513          	mv	a0,s8
    3b90:	00058a13          	mv	s4,a1
    3b94:	884fe0ef          	jal	ra,1c18 <__muldf3>
    3b98:	00050913          	mv	s2,a0
    3b9c:	00058993          	mv	s3,a1
    3ba0:	000b0613          	mv	a2,s6
    3ba4:	000b8693          	mv	a3,s7
    3ba8:	000c0513          	mv	a0,s8
    3bac:	000a0593          	mv	a1,s4
    3bb0:	ebcfe0ef          	jal	ra,226c <__subdf3>
    3bb4:	00050613          	mv	a2,a0
    3bb8:	00058693          	mv	a3,a1
    3bbc:	00040513          	mv	a0,s0
    3bc0:	00048593          	mv	a1,s1
    3bc4:	ea8fe0ef          	jal	ra,226c <__subdf3>
    3bc8:	00002697          	auipc	a3,0x2
    3bcc:	37068693          	addi	a3,a3,880 # 5f38 <__clz_tab+0x1b8>
    3bd0:	0006a603          	lw	a2,0(a3)
    3bd4:	0046a683          	lw	a3,4(a3)
    3bd8:	840fe0ef          	jal	ra,1c18 <__muldf3>
    3bdc:	00002697          	auipc	a3,0x2
    3be0:	36468693          	addi	a3,a3,868 # 5f40 <__clz_tab+0x1c0>
    3be4:	0006a603          	lw	a2,0(a3)
    3be8:	0046a683          	lw	a3,4(a3)
    3bec:	00050413          	mv	s0,a0
    3bf0:	00058493          	mv	s1,a1
    3bf4:	000c0513          	mv	a0,s8
    3bf8:	000a0593          	mv	a1,s4
    3bfc:	81cfe0ef          	jal	ra,1c18 <__muldf3>
    3c00:	00050613          	mv	a2,a0
    3c04:	00058693          	mv	a3,a1
    3c08:	00040513          	mv	a0,s0
    3c0c:	00048593          	mv	a1,s1
    3c10:	6b1000ef          	jal	ra,4ac0 <__adddf3>
    3c14:	03812603          	lw	a2,56(sp)
    3c18:	03c12683          	lw	a3,60(sp)
    3c1c:	6a5000ef          	jal	ra,4ac0 <__adddf3>
    3c20:	03412e83          	lw	t4,52(sp)
    3c24:	00050b13          	mv	s6,a0
    3c28:	00058b93          	mv	s7,a1
    3c2c:	000e8513          	mv	a0,t4
    3c30:	f3dfe0ef          	jal	ra,2b6c <__floatsidf>
    3c34:	00050413          	mv	s0,a0
    3c38:	00058493          	mv	s1,a1
    3c3c:	000b0613          	mv	a2,s6
    3c40:	000b8693          	mv	a3,s7
    3c44:	00090513          	mv	a0,s2
    3c48:	00098593          	mv	a1,s3
    3c4c:	675000ef          	jal	ra,4ac0 <__adddf3>
    3c50:	01012603          	lw	a2,16(sp)
    3c54:	01412683          	lw	a3,20(sp)
    3c58:	669000ef          	jal	ra,4ac0 <__adddf3>
    3c5c:	00040613          	mv	a2,s0
    3c60:	00048693          	mv	a3,s1
    3c64:	65d000ef          	jal	ra,4ac0 <__adddf3>
    3c68:	00000613          	li	a2,0
    3c6c:	00060513          	mv	a0,a2
    3c70:	00048693          	mv	a3,s1
    3c74:	00040613          	mv	a2,s0
    3c78:	00058493          	mv	s1,a1
    3c7c:	00050413          	mv	s0,a0
    3c80:	decfe0ef          	jal	ra,226c <__subdf3>
    3c84:	01012603          	lw	a2,16(sp)
    3c88:	01412683          	lw	a3,20(sp)
    3c8c:	de0fe0ef          	jal	ra,226c <__subdf3>
    3c90:	00090613          	mv	a2,s2
    3c94:	00098693          	mv	a3,s3
    3c98:	dd4fe0ef          	jal	ra,226c <__subdf3>
    3c9c:	00050613          	mv	a2,a0
    3ca0:	00058693          	mv	a3,a1
    3ca4:	000b0513          	mv	a0,s6
    3ca8:	000b8593          	mv	a1,s7
    3cac:	dc0fe0ef          	jal	ra,226c <__subdf3>
    3cb0:	03012e03          	lw	t3,48(sp)
    3cb4:	00050913          	mv	s2,a0
    3cb8:	00058993          	mv	s3,a1
    3cbc:	fffd0313          	addi	t1,s10,-1
    3cc0:	01c36e33          	or	t3,t1,t3
    3cc4:	480e1863          	bnez	t3,4154 <__ieee754_pow+0xd34>
    3cc8:	00002697          	auipc	a3,0x2
    3ccc:	1e868693          	addi	a3,a3,488 # 5eb0 <__clz_tab+0x130>
    3cd0:	0006a783          	lw	a5,0(a3)
    3cd4:	0046a803          	lw	a6,4(a3)
    3cd8:	00f12423          	sw	a5,8(sp)
    3cdc:	01012623          	sw	a6,12(sp)
    3ce0:	00000c13          	li	s8,0
    3ce4:	000c0613          	mv	a2,s8
    3ce8:	000d8693          	mv	a3,s11
    3cec:	000c8513          	mv	a0,s9
    3cf0:	000d8593          	mv	a1,s11
    3cf4:	d78fe0ef          	jal	ra,226c <__subdf3>
    3cf8:	00040613          	mv	a2,s0
    3cfc:	00048693          	mv	a3,s1
    3d00:	f19fd0ef          	jal	ra,1c18 <__muldf3>
    3d04:	00050b13          	mv	s6,a0
    3d08:	00058b93          	mv	s7,a1
    3d0c:	000c8613          	mv	a2,s9
    3d10:	000d8693          	mv	a3,s11
    3d14:	00090513          	mv	a0,s2
    3d18:	00098593          	mv	a1,s3
    3d1c:	efdfd0ef          	jal	ra,1c18 <__muldf3>
    3d20:	00050613          	mv	a2,a0
    3d24:	00058693          	mv	a3,a1
    3d28:	000b0513          	mv	a0,s6
    3d2c:	000b8593          	mv	a1,s7
    3d30:	591000ef          	jal	ra,4ac0 <__adddf3>
    3d34:	00050913          	mv	s2,a0
    3d38:	00058993          	mv	s3,a1
    3d3c:	000c0613          	mv	a2,s8
    3d40:	000d8693          	mv	a3,s11
    3d44:	00040513          	mv	a0,s0
    3d48:	00048593          	mv	a1,s1
    3d4c:	ecdfd0ef          	jal	ra,1c18 <__muldf3>
    3d50:	00050613          	mv	a2,a0
    3d54:	00058693          	mv	a3,a1
    3d58:	00050413          	mv	s0,a0
    3d5c:	00058493          	mv	s1,a1
    3d60:	00090513          	mv	a0,s2
    3d64:	00098593          	mv	a1,s3
    3d68:	559000ef          	jal	ra,4ac0 <__adddf3>
    3d6c:	409007b7          	lui	a5,0x40900
    3d70:	00050a13          	mv	s4,a0
    3d74:	00058b13          	mv	s6,a1
    3d78:	00058b93          	mv	s7,a1
    3d7c:	36f5c463          	blt	a1,a5,40e4 <__ieee754_pow+0xcc4>
    3d80:	40f587b3          	sub	a5,a1,a5
    3d84:	00a7e7b3          	or	a5,a5,a0
    3d88:	5e079463          	bnez	a5,4370 <__ieee754_pow+0xf50>
    3d8c:	00002797          	auipc	a5,0x2
    3d90:	1bc78793          	addi	a5,a5,444 # 5f48 <__clz_tab+0x1c8>
    3d94:	0007a603          	lw	a2,0(a5)
    3d98:	0047a683          	lw	a3,4(a5)
    3d9c:	00090513          	mv	a0,s2
    3da0:	00098593          	mv	a1,s3
    3da4:	51d000ef          	jal	ra,4ac0 <__adddf3>
    3da8:	00050d13          	mv	s10,a0
    3dac:	00058d93          	mv	s11,a1
    3db0:	00040613          	mv	a2,s0
    3db4:	00048693          	mv	a3,s1
    3db8:	000a0513          	mv	a0,s4
    3dbc:	000b0593          	mv	a1,s6
    3dc0:	cacfe0ef          	jal	ra,226c <__subdf3>
    3dc4:	00050613          	mv	a2,a0
    3dc8:	00058693          	mv	a3,a1
    3dcc:	000d0513          	mv	a0,s10
    3dd0:	000d8593          	mv	a1,s11
    3dd4:	579010ef          	jal	ra,5b4c <__gedf2>
    3dd8:	58a04c63          	bgtz	a0,4370 <__ieee754_pow+0xf50>
    3ddc:	414bd793          	srai	a5,s7,0x14
    3de0:	7ff7f793          	andi	a5,a5,2047
    3de4:	00100537          	lui	a0,0x100
    3de8:	c0278793          	addi	a5,a5,-1022
    3dec:	40f557b3          	sra	a5,a0,a5
    3df0:	017787b3          	add	a5,a5,s7
    3df4:	4147d713          	srai	a4,a5,0x14
    3df8:	7ff77713          	andi	a4,a4,2047
    3dfc:	c0170713          	addi	a4,a4,-1023
    3e00:	fff50a13          	addi	s4,a0,-1 # fffff <__global_pointer$+0xf93b7>
    3e04:	40ea55b3          	sra	a1,s4,a4
    3e08:	fff5c593          	not	a1,a1
    3e0c:	00f5f5b3          	and	a1,a1,a5
    3e10:	0147fa33          	and	s4,a5,s4
    3e14:	01400793          	li	a5,20
    3e18:	00aa6a33          	or	s4,s4,a0
    3e1c:	40e78733          	sub	a4,a5,a4
    3e20:	00000613          	li	a2,0
    3e24:	00058693          	mv	a3,a1
    3e28:	40ea5a33          	sra	s4,s4,a4
    3e2c:	000bd463          	bgez	s7,3e34 <__ieee754_pow+0xa14>
    3e30:	41400a33          	neg	s4,s4
    3e34:	00040513          	mv	a0,s0
    3e38:	00048593          	mv	a1,s1
    3e3c:	c30fe0ef          	jal	ra,226c <__subdf3>
    3e40:	00050613          	mv	a2,a0
    3e44:	00058693          	mv	a3,a1
    3e48:	00050413          	mv	s0,a0
    3e4c:	00058493          	mv	s1,a1
    3e50:	00090513          	mv	a0,s2
    3e54:	00098593          	mv	a1,s3
    3e58:	469000ef          	jal	ra,4ac0 <__adddf3>
    3e5c:	00058b13          	mv	s6,a1
    3e60:	014a1d93          	slli	s11,s4,0x14
    3e64:	00002717          	auipc	a4,0x2
    3e68:	0f470713          	addi	a4,a4,244 # 5f58 <__clz_tab+0x1d8>
    3e6c:	00072603          	lw	a2,0(a4)
    3e70:	00472683          	lw	a3,4(a4)
    3e74:	00000c13          	li	s8,0
    3e78:	000c0513          	mv	a0,s8
    3e7c:	000b0593          	mv	a1,s6
    3e80:	d99fd0ef          	jal	ra,1c18 <__muldf3>
    3e84:	000b0d13          	mv	s10,s6
    3e88:	00058b93          	mv	s7,a1
    3e8c:	00050b13          	mv	s6,a0
    3e90:	00040613          	mv	a2,s0
    3e94:	00048693          	mv	a3,s1
    3e98:	000c0513          	mv	a0,s8
    3e9c:	000d0593          	mv	a1,s10
    3ea0:	bccfe0ef          	jal	ra,226c <__subdf3>
    3ea4:	00050613          	mv	a2,a0
    3ea8:	00058693          	mv	a3,a1
    3eac:	00090513          	mv	a0,s2
    3eb0:	00098593          	mv	a1,s3
    3eb4:	bb8fe0ef          	jal	ra,226c <__subdf3>
    3eb8:	00002717          	auipc	a4,0x2
    3ebc:	0a870713          	addi	a4,a4,168 # 5f60 <__clz_tab+0x1e0>
    3ec0:	00072603          	lw	a2,0(a4)
    3ec4:	00472683          	lw	a3,4(a4)
    3ec8:	d51fd0ef          	jal	ra,1c18 <__muldf3>
    3ecc:	00002717          	auipc	a4,0x2
    3ed0:	09c70713          	addi	a4,a4,156 # 5f68 <__clz_tab+0x1e8>
    3ed4:	00072603          	lw	a2,0(a4)
    3ed8:	00472683          	lw	a3,4(a4)
    3edc:	00050413          	mv	s0,a0
    3ee0:	00058493          	mv	s1,a1
    3ee4:	000c0513          	mv	a0,s8
    3ee8:	000d0593          	mv	a1,s10
    3eec:	d2dfd0ef          	jal	ra,1c18 <__muldf3>
    3ef0:	00050613          	mv	a2,a0
    3ef4:	00058693          	mv	a3,a1
    3ef8:	00040513          	mv	a0,s0
    3efc:	00048593          	mv	a1,s1
    3f00:	3c1000ef          	jal	ra,4ac0 <__adddf3>
    3f04:	00050913          	mv	s2,a0
    3f08:	00058993          	mv	s3,a1
    3f0c:	00050613          	mv	a2,a0
    3f10:	00058693          	mv	a3,a1
    3f14:	000b0513          	mv	a0,s6
    3f18:	000b8593          	mv	a1,s7
    3f1c:	3a5000ef          	jal	ra,4ac0 <__adddf3>
    3f20:	000b0613          	mv	a2,s6
    3f24:	000b8693          	mv	a3,s7
    3f28:	00050413          	mv	s0,a0
    3f2c:	00058493          	mv	s1,a1
    3f30:	b3cfe0ef          	jal	ra,226c <__subdf3>
    3f34:	00050613          	mv	a2,a0
    3f38:	00058693          	mv	a3,a1
    3f3c:	00090513          	mv	a0,s2
    3f40:	00098593          	mv	a1,s3
    3f44:	b28fe0ef          	jal	ra,226c <__subdf3>
    3f48:	00050b13          	mv	s6,a0
    3f4c:	00058b93          	mv	s7,a1
    3f50:	00040613          	mv	a2,s0
    3f54:	00048693          	mv	a3,s1
    3f58:	00040513          	mv	a0,s0
    3f5c:	00048593          	mv	a1,s1
    3f60:	cb9fd0ef          	jal	ra,1c18 <__muldf3>
    3f64:	00002797          	auipc	a5,0x2
    3f68:	00c78793          	addi	a5,a5,12 # 5f70 <__clz_tab+0x1f0>
    3f6c:	0007a603          	lw	a2,0(a5)
    3f70:	0047a683          	lw	a3,4(a5)
    3f74:	00050913          	mv	s2,a0
    3f78:	00058993          	mv	s3,a1
    3f7c:	c9dfd0ef          	jal	ra,1c18 <__muldf3>
    3f80:	00002797          	auipc	a5,0x2
    3f84:	ff878793          	addi	a5,a5,-8 # 5f78 <__clz_tab+0x1f8>
    3f88:	0007a603          	lw	a2,0(a5)
    3f8c:	0047a683          	lw	a3,4(a5)
    3f90:	adcfe0ef          	jal	ra,226c <__subdf3>
    3f94:	00090613          	mv	a2,s2
    3f98:	00098693          	mv	a3,s3
    3f9c:	c7dfd0ef          	jal	ra,1c18 <__muldf3>
    3fa0:	00002797          	auipc	a5,0x2
    3fa4:	fe078793          	addi	a5,a5,-32 # 5f80 <__clz_tab+0x200>
    3fa8:	0007a603          	lw	a2,0(a5)
    3fac:	0047a683          	lw	a3,4(a5)
    3fb0:	311000ef          	jal	ra,4ac0 <__adddf3>
    3fb4:	00090613          	mv	a2,s2
    3fb8:	00098693          	mv	a3,s3
    3fbc:	c5dfd0ef          	jal	ra,1c18 <__muldf3>
    3fc0:	00002797          	auipc	a5,0x2
    3fc4:	fc878793          	addi	a5,a5,-56 # 5f88 <__clz_tab+0x208>
    3fc8:	0007a603          	lw	a2,0(a5)
    3fcc:	0047a683          	lw	a3,4(a5)
    3fd0:	a9cfe0ef          	jal	ra,226c <__subdf3>
    3fd4:	00090613          	mv	a2,s2
    3fd8:	00098693          	mv	a3,s3
    3fdc:	c3dfd0ef          	jal	ra,1c18 <__muldf3>
    3fe0:	00002797          	auipc	a5,0x2
    3fe4:	fb078793          	addi	a5,a5,-80 # 5f90 <__clz_tab+0x210>
    3fe8:	0007a603          	lw	a2,0(a5)
    3fec:	0047a683          	lw	a3,4(a5)
    3ff0:	2d1000ef          	jal	ra,4ac0 <__adddf3>
    3ff4:	00090613          	mv	a2,s2
    3ff8:	00098693          	mv	a3,s3
    3ffc:	c1dfd0ef          	jal	ra,1c18 <__muldf3>
    4000:	00050613          	mv	a2,a0
    4004:	00058693          	mv	a3,a1
    4008:	00040513          	mv	a0,s0
    400c:	00048593          	mv	a1,s1
    4010:	a5cfe0ef          	jal	ra,226c <__subdf3>
    4014:	00050613          	mv	a2,a0
    4018:	00058693          	mv	a3,a1
    401c:	00050c13          	mv	s8,a0
    4020:	00058c93          	mv	s9,a1
    4024:	00040513          	mv	a0,s0
    4028:	00048593          	mv	a1,s1
    402c:	bedfd0ef          	jal	ra,1c18 <__muldf3>
    4030:	00002697          	auipc	a3,0x2
    4034:	f6868693          	addi	a3,a3,-152 # 5f98 <__clz_tab+0x218>
    4038:	0006a603          	lw	a2,0(a3)
    403c:	0046a683          	lw	a3,4(a3)
    4040:	00050913          	mv	s2,a0
    4044:	00058993          	mv	s3,a1
    4048:	000c0513          	mv	a0,s8
    404c:	000c8593          	mv	a1,s9
    4050:	a1cfe0ef          	jal	ra,226c <__subdf3>
    4054:	00050613          	mv	a2,a0
    4058:	00058693          	mv	a3,a1
    405c:	00090513          	mv	a0,s2
    4060:	00098593          	mv	a1,s3
    4064:	2e0010ef          	jal	ra,5344 <__divdf3>
    4068:	00050913          	mv	s2,a0
    406c:	00058993          	mv	s3,a1
    4070:	000b0613          	mv	a2,s6
    4074:	000b8693          	mv	a3,s7
    4078:	00040513          	mv	a0,s0
    407c:	00048593          	mv	a1,s1
    4080:	b99fd0ef          	jal	ra,1c18 <__muldf3>
    4084:	000b0613          	mv	a2,s6
    4088:	000b8693          	mv	a3,s7
    408c:	235000ef          	jal	ra,4ac0 <__adddf3>
    4090:	00050613          	mv	a2,a0
    4094:	00058693          	mv	a3,a1
    4098:	00090513          	mv	a0,s2
    409c:	00098593          	mv	a1,s3
    40a0:	9ccfe0ef          	jal	ra,226c <__subdf3>
    40a4:	00040613          	mv	a2,s0
    40a8:	00048693          	mv	a3,s1
    40ac:	9c0fe0ef          	jal	ra,226c <__subdf3>
    40b0:	00058693          	mv	a3,a1
    40b4:	00050613          	mv	a2,a0
    40b8:	004aa583          	lw	a1,4(s5)
    40bc:	000aa503          	lw	a0,0(s5)
    40c0:	9acfe0ef          	jal	ra,226c <__subdf3>
    40c4:	00bd87b3          	add	a5,s11,a1
    40c8:	4147d693          	srai	a3,a5,0x14
    40cc:	32d05063          	blez	a3,43ec <__ieee754_pow+0xfcc>
    40d0:	00078593          	mv	a1,a5
    40d4:	00812603          	lw	a2,8(sp)
    40d8:	00c12683          	lw	a3,12(sp)
    40dc:	b3dfd0ef          	jal	ra,1c18 <__muldf3>
    40e0:	bb8ff06f          	j	3498 <__ieee754_pow+0x78>
    40e4:	00159793          	slli	a5,a1,0x1
    40e8:	4090d6b7          	lui	a3,0x4090d
    40ec:	0017d793          	srli	a5,a5,0x1
    40f0:	bff68693          	addi	a3,a3,-1025 # 4090cbff <__freertos_irq_stack_top+0x4070675f>
    40f4:	26f6d263          	bge	a3,a5,4358 <__ieee754_pow+0xf38>
    40f8:	3f6f37b7          	lui	a5,0x3f6f3
    40fc:	40078793          	addi	a5,a5,1024 # 3f6f3400 <__freertos_irq_stack_top+0x3f4ecf60>
    4100:	00f587b3          	add	a5,a1,a5
    4104:	00a7e7b3          	or	a5,a5,a0
    4108:	02079063          	bnez	a5,4128 <__ieee754_pow+0xd08>
    410c:	00040613          	mv	a2,s0
    4110:	00048693          	mv	a3,s1
    4114:	958fe0ef          	jal	ra,226c <__subdf3>
    4118:	00090613          	mv	a2,s2
    411c:	00098693          	mv	a3,s3
    4120:	22d010ef          	jal	ra,5b4c <__gedf2>
    4124:	ca054ce3          	bltz	a0,3ddc <__ieee754_pow+0x9bc>
    4128:	00002417          	auipc	s0,0x2
    412c:	e2840413          	addi	s0,s0,-472 # 5f50 <__clz_tab+0x1d0>
    4130:	00042603          	lw	a2,0(s0)
    4134:	00442683          	lw	a3,4(s0)
    4138:	00812503          	lw	a0,8(sp)
    413c:	00c12583          	lw	a1,12(sp)
    4140:	ad9fd0ef          	jal	ra,1c18 <__muldf3>
    4144:	00042603          	lw	a2,0(s0)
    4148:	00442683          	lw	a3,4(s0)
    414c:	acdfd0ef          	jal	ra,1c18 <__muldf3>
    4150:	b48ff06f          	j	3498 <__ieee754_pow+0x78>
    4154:	000aa783          	lw	a5,0(s5)
    4158:	004aa803          	lw	a6,4(s5)
    415c:	00f12423          	sw	a5,8(sp)
    4160:	01012623          	sw	a6,12(sp)
    4164:	b7dff06f          	j	3ce0 <__ieee754_pow+0x8c0>
    4168:	d60dd663          	bgez	s11,36d4 <__ieee754_pow+0x2b4>
    416c:	800005b7          	lui	a1,0x80000
    4170:	00000513          	li	a0,0
    4174:	01b5c5b3          	xor	a1,a1,s11
    4178:	b20ff06f          	j	3498 <__ieee754_pow+0x78>
    417c:	00002a97          	auipc	s5,0x2
    4180:	d04a8a93          	addi	s5,s5,-764 # 5e80 <__clz_tab+0x100>
    4184:	e68ff06f          	j	37ec <__ieee754_pow+0x3cc>
    4188:	3ff006b7          	lui	a3,0x3ff00
    418c:	ffe68613          	addi	a2,a3,-2 # 3feffffe <__freertos_irq_stack_top+0x3fcf9b5e>
    4190:	ca865663          	bge	a2,s0,363c <__ieee754_pow+0x21c>
    4194:	d686cc63          	blt	a3,s0,370c <__ieee754_pow+0x2ec>
    4198:	00002a97          	auipc	s5,0x2
    419c:	ce8a8a93          	addi	s5,s5,-792 # 5e80 <__clz_tab+0x100>
    41a0:	000aa603          	lw	a2,0(s5)
    41a4:	004aa683          	lw	a3,4(s5)
    41a8:	01c12823          	sw	t3,16(sp)
    41ac:	8c0fe0ef          	jal	ra,226c <__subdf3>
    41b0:	00002697          	auipc	a3,0x2
    41b4:	d1068693          	addi	a3,a3,-752 # 5ec0 <__clz_tab+0x140>
    41b8:	0006a603          	lw	a2,0(a3)
    41bc:	0046a683          	lw	a3,4(a3)
    41c0:	00050413          	mv	s0,a0
    41c4:	00058493          	mv	s1,a1
    41c8:	a51fd0ef          	jal	ra,1c18 <__muldf3>
    41cc:	00002697          	auipc	a3,0x2
    41d0:	cfc68693          	addi	a3,a3,-772 # 5ec8 <__clz_tab+0x148>
    41d4:	0006a603          	lw	a2,0(a3)
    41d8:	0046a683          	lw	a3,4(a3)
    41dc:	00050913          	mv	s2,a0
    41e0:	00058993          	mv	s3,a1
    41e4:	00040513          	mv	a0,s0
    41e8:	00048593          	mv	a1,s1
    41ec:	a2dfd0ef          	jal	ra,1c18 <__muldf3>
    41f0:	00002697          	auipc	a3,0x2
    41f4:	ce068693          	addi	a3,a3,-800 # 5ed0 <__clz_tab+0x150>
    41f8:	0006a603          	lw	a2,0(a3)
    41fc:	0046a683          	lw	a3,4(a3)
    4200:	00a12423          	sw	a0,8(sp)
    4204:	00b12623          	sw	a1,12(sp)
    4208:	00040513          	mv	a0,s0
    420c:	00048593          	mv	a1,s1
    4210:	a09fd0ef          	jal	ra,1c18 <__muldf3>
    4214:	00058693          	mv	a3,a1
    4218:	00002597          	auipc	a1,0x2
    421c:	cc058593          	addi	a1,a1,-832 # 5ed8 <__clz_tab+0x158>
    4220:	00050613          	mv	a2,a0
    4224:	0005a503          	lw	a0,0(a1)
    4228:	0045a583          	lw	a1,4(a1)
    422c:	840fe0ef          	jal	ra,226c <__subdf3>
    4230:	00040613          	mv	a2,s0
    4234:	00048693          	mv	a3,s1
    4238:	9e1fd0ef          	jal	ra,1c18 <__muldf3>
    423c:	00058693          	mv	a3,a1
    4240:	00002597          	auipc	a1,0x2
    4244:	ca058593          	addi	a1,a1,-864 # 5ee0 <__clz_tab+0x160>
    4248:	00050613          	mv	a2,a0
    424c:	0005a503          	lw	a0,0(a1)
    4250:	0045a583          	lw	a1,4(a1)
    4254:	818fe0ef          	jal	ra,226c <__subdf3>
    4258:	00050b13          	mv	s6,a0
    425c:	00058b93          	mv	s7,a1
    4260:	00040613          	mv	a2,s0
    4264:	00048693          	mv	a3,s1
    4268:	00040513          	mv	a0,s0
    426c:	00048593          	mv	a1,s1
    4270:	9a9fd0ef          	jal	ra,1c18 <__muldf3>
    4274:	00050613          	mv	a2,a0
    4278:	00058693          	mv	a3,a1
    427c:	000b0513          	mv	a0,s6
    4280:	000b8593          	mv	a1,s7
    4284:	995fd0ef          	jal	ra,1c18 <__muldf3>
    4288:	00002697          	auipc	a3,0x2
    428c:	c6068693          	addi	a3,a3,-928 # 5ee8 <__clz_tab+0x168>
    4290:	0006a603          	lw	a2,0(a3)
    4294:	0046a683          	lw	a3,4(a3)
    4298:	981fd0ef          	jal	ra,1c18 <__muldf3>
    429c:	00812703          	lw	a4,8(sp)
    42a0:	00c12783          	lw	a5,12(sp)
    42a4:	00050613          	mv	a2,a0
    42a8:	00058693          	mv	a3,a1
    42ac:	00070513          	mv	a0,a4
    42b0:	00078593          	mv	a1,a5
    42b4:	fb9fd0ef          	jal	ra,226c <__subdf3>
    42b8:	00050613          	mv	a2,a0
    42bc:	00058693          	mv	a3,a1
    42c0:	00050b13          	mv	s6,a0
    42c4:	00058b93          	mv	s7,a1
    42c8:	00090513          	mv	a0,s2
    42cc:	00098593          	mv	a1,s3
    42d0:	7f0000ef          	jal	ra,4ac0 <__adddf3>
    42d4:	00000613          	li	a2,0
    42d8:	00098693          	mv	a3,s3
    42dc:	00060513          	mv	a0,a2
    42e0:	00060413          	mv	s0,a2
    42e4:	00090613          	mv	a2,s2
    42e8:	00058493          	mv	s1,a1
    42ec:	f81fd0ef          	jal	ra,226c <__subdf3>
    42f0:	00050613          	mv	a2,a0
    42f4:	00058693          	mv	a3,a1
    42f8:	000b0513          	mv	a0,s6
    42fc:	000b8593          	mv	a1,s7
    4300:	f6dfd0ef          	jal	ra,226c <__subdf3>
    4304:	00050913          	mv	s2,a0
    4308:	00058993          	mv	s3,a1
    430c:	01012e03          	lw	t3,16(sp)
    4310:	9adff06f          	j	3cbc <__ieee754_pow+0x89c>
    4314:	00098613          	mv	a2,s3
    4318:	00098513          	mv	a0,s3
    431c:	00048693          	mv	a3,s1
    4320:	00048593          	mv	a1,s1
    4324:	8f5fd0ef          	jal	ra,1c18 <__muldf3>
    4328:	970ff06f          	j	3498 <__ieee754_pow+0x78>
    432c:	b20c9a63          	bnez	s9,3660 <__ieee754_pow+0x240>
    4330:	40d606b3          	sub	a3,a2,a3
    4334:	40d95633          	sra	a2,s2,a3
    4338:	00d616b3          	sll	a3,a2,a3
    433c:	000c8d13          	mv	s10,s9
    4340:	01268463          	beq	a3,s2,4348 <__ieee754_pow+0xf28>
    4344:	9c4ff06f          	j	3508 <__ieee754_pow+0xe8>
    4348:	00167613          	andi	a2,a2,1
    434c:	00200313          	li	t1,2
    4350:	40c30d33          	sub	s10,t1,a2
    4354:	9b4ff06f          	j	3508 <__ieee754_pow+0xe8>
    4358:	3fe00737          	lui	a4,0x3fe00
    435c:	00000d93          	li	s11,0
    4360:	00000a13          	li	s4,0
    4364:	b0f750e3          	bge	a4,a5,3e64 <__ieee754_pow+0xa44>
    4368:	4147d793          	srai	a5,a5,0x14
    436c:	a79ff06f          	j	3de4 <__ieee754_pow+0x9c4>
    4370:	00002417          	auipc	s0,0x2
    4374:	b4840413          	addi	s0,s0,-1208 # 5eb8 <__clz_tab+0x138>
    4378:	db9ff06f          	j	4130 <__ieee754_pow+0xd10>
    437c:	00100793          	li	a5,1
    4380:	00fd0463          	beq	s10,a5,4388 <__ieee754_pow+0xf68>
    4384:	914ff06f          	j	3498 <__ieee754_pow+0x78>
    4388:	800007b7          	lui	a5,0x80000
    438c:	00b7c5b3          	xor	a1,a5,a1
    4390:	908ff06f          	j	3498 <__ieee754_pow+0x78>
    4394:	00002697          	auipc	a3,0x2
    4398:	b0468693          	addi	a3,a3,-1276 # 5e98 <__clz_tab+0x118>
    439c:	0006a783          	lw	a5,0(a3)
    43a0:	0046a803          	lw	a6,4(a3)
    43a4:	00002697          	auipc	a3,0x2
    43a8:	afc68693          	addi	a3,a3,-1284 # 5ea0 <__clz_tab+0x120>
    43ac:	00f12823          	sw	a5,16(sp)
    43b0:	01012a23          	sw	a6,20(sp)
    43b4:	0006a783          	lw	a5,0(a3)
    43b8:	0046a803          	lw	a6,4(a3)
    43bc:	00002697          	auipc	a3,0x2
    43c0:	aec68693          	addi	a3,a3,-1300 # 5ea8 <__clz_tab+0x128>
    43c4:	02f12c23          	sw	a5,56(sp)
    43c8:	03012e23          	sw	a6,60(sp)
    43cc:	0006a783          	lw	a5,0(a3)
    43d0:	0046a803          	lw	a6,4(a3)
    43d4:	000409b7          	lui	s3,0x40
    43d8:	00f12423          	sw	a5,8(sp)
    43dc:	01012623          	sw	a6,12(sp)
    43e0:	00002a97          	auipc	s5,0x2
    43e4:	aa0a8a93          	addi	s5,s5,-1376 # 5e80 <__clz_tab+0x100>
    43e8:	c28ff06f          	j	3810 <__ieee754_pow+0x3f0>
    43ec:	000a0613          	mv	a2,s4
    43f0:	518000ef          	jal	ra,4908 <scalbn>
    43f4:	ce1ff06f          	j	40d4 <__ieee754_pow+0xcb4>

000043f8 <__ieee754_sqrt>:
    43f8:	ff010113          	addi	sp,sp,-16
    43fc:	7ff00737          	lui	a4,0x7ff00
    4400:	00812423          	sw	s0,8(sp)
    4404:	00912223          	sw	s1,4(sp)
    4408:	00112623          	sw	ra,12(sp)
    440c:	00b77833          	and	a6,a4,a1
    4410:	00058493          	mv	s1,a1
    4414:	00050413          	mv	s0,a0
    4418:	20e80863          	beq	a6,a4,4628 <__ieee754_sqrt+0x230>
    441c:	00058793          	mv	a5,a1
    4420:	00050693          	mv	a3,a0
    4424:	14b05a63          	blez	a1,4578 <__ieee754_sqrt+0x180>
    4428:	4145de13          	srai	t3,a1,0x14
    442c:	240e0e63          	beqz	t3,4688 <__ieee754_sqrt+0x290>
    4430:	00100737          	lui	a4,0x100
    4434:	fff70613          	addi	a2,a4,-1 # fffff <__global_pointer$+0xf93b7>
    4438:	00c7f7b3          	and	a5,a5,a2
    443c:	00e7e7b3          	or	a5,a5,a4
    4440:	c01e0e13          	addi	t3,t3,-1023
    4444:	00179713          	slli	a4,a5,0x1
    4448:	001e7613          	andi	a2,t3,1
    444c:	01f6d793          	srli	a5,a3,0x1f
    4450:	00f707b3          	add	a5,a4,a5
    4454:	00169713          	slli	a4,a3,0x1
    4458:	00060a63          	beqz	a2,446c <__ieee754_sqrt+0x74>
    445c:	01f75713          	srli	a4,a4,0x1f
    4460:	00179793          	slli	a5,a5,0x1
    4464:	00e787b3          	add	a5,a5,a4
    4468:	00269713          	slli	a4,a3,0x2
    446c:	401e5e13          	srai	t3,t3,0x1
    4470:	01600593          	li	a1,22
    4474:	00000e93          	li	t4,0
    4478:	00000693          	li	a3,0
    447c:	00200637          	lui	a2,0x200
    4480:	00c68533          	add	a0,a3,a2
    4484:	01f75813          	srli	a6,a4,0x1f
    4488:	fff58593          	addi	a1,a1,-1
    448c:	00a7c863          	blt	a5,a0,449c <__ieee754_sqrt+0xa4>
    4490:	40a787b3          	sub	a5,a5,a0
    4494:	00c506b3          	add	a3,a0,a2
    4498:	00ce8eb3          	add	t4,t4,a2
    449c:	00179793          	slli	a5,a5,0x1
    44a0:	00f807b3          	add	a5,a6,a5
    44a4:	00171713          	slli	a4,a4,0x1
    44a8:	00165613          	srli	a2,a2,0x1
    44ac:	fc059ae3          	bnez	a1,4480 <__ieee754_sqrt+0x88>
    44b0:	00000313          	li	t1,0
    44b4:	02000813          	li	a6,32
    44b8:	80000637          	lui	a2,0x80000
    44bc:	0240006f          	j	44e0 <__ieee754_sqrt+0xe8>
    44c0:	12d78e63          	beq	a5,a3,45fc <__ieee754_sqrt+0x204>
    44c4:	01f75513          	srli	a0,a4,0x1f
    44c8:	00179793          	slli	a5,a5,0x1
    44cc:	fff80813          	addi	a6,a6,-1 # c00fffff <__freertos_irq_stack_top+0xbfef9b5f>
    44d0:	00a787b3          	add	a5,a5,a0
    44d4:	00171713          	slli	a4,a4,0x1
    44d8:	00165613          	srli	a2,a2,0x1
    44dc:	04080663          	beqz	a6,4528 <__ieee754_sqrt+0x130>
    44e0:	00b60533          	add	a0,a2,a1
    44e4:	fcf6dee3          	bge	a3,a5,44c0 <__ieee754_sqrt+0xc8>
    44e8:	00c505b3          	add	a1,a0,a2
    44ec:	00068893          	mv	a7,a3
    44f0:	0e054e63          	bltz	a0,45ec <__ieee754_sqrt+0x1f4>
    44f4:	40d787b3          	sub	a5,a5,a3
    44f8:	00a736b3          	sltu	a3,a4,a0
    44fc:	40d787b3          	sub	a5,a5,a3
    4500:	40a70733          	sub	a4,a4,a0
    4504:	01f75513          	srli	a0,a4,0x1f
    4508:	00179793          	slli	a5,a5,0x1
    450c:	fff80813          	addi	a6,a6,-1
    4510:	00c30333          	add	t1,t1,a2
    4514:	00088693          	mv	a3,a7
    4518:	00a787b3          	add	a5,a5,a0
    451c:	00171713          	slli	a4,a4,0x1
    4520:	00165613          	srli	a2,a2,0x1
    4524:	fa081ee3          	bnez	a6,44e0 <__ieee754_sqrt+0xe8>
    4528:	00e7e7b3          	or	a5,a5,a4
    452c:	0e079463          	bnez	a5,4614 <__ieee754_sqrt+0x21c>
    4530:	00135813          	srli	a6,t1,0x1
    4534:	401ed713          	srai	a4,t4,0x1
    4538:	3fe004b7          	lui	s1,0x3fe00
    453c:	001efe93          	andi	t4,t4,1
    4540:	009704b3          	add	s1,a4,s1
    4544:	000e8663          	beqz	t4,4550 <__ieee754_sqrt+0x158>
    4548:	800007b7          	lui	a5,0x80000
    454c:	00f86833          	or	a6,a6,a5
    4550:	014e1713          	slli	a4,t3,0x14
    4554:	00080413          	mv	s0,a6
    4558:	00970733          	add	a4,a4,s1
    455c:	00040513          	mv	a0,s0
    4560:	00c12083          	lw	ra,12(sp)
    4564:	00812403          	lw	s0,8(sp)
    4568:	00412483          	lw	s1,4(sp)
    456c:	00070593          	mv	a1,a4
    4570:	01010113          	addi	sp,sp,16
    4574:	00008067          	ret
    4578:	00159713          	slli	a4,a1,0x1
    457c:	00175713          	srli	a4,a4,0x1
    4580:	00a76833          	or	a6,a4,a0
    4584:	00058713          	mv	a4,a1
    4588:	fc080ae3          	beqz	a6,455c <__ieee754_sqrt+0x164>
    458c:	0c059c63          	bnez	a1,4664 <__ieee754_sqrt+0x26c>
    4590:	00b6d593          	srli	a1,a3,0xb
    4594:	feb78793          	addi	a5,a5,-21 # 7fffffeb <__freertos_irq_stack_top+0x7fdf9b4b>
    4598:	00058713          	mv	a4,a1
    459c:	01569693          	slli	a3,a3,0x15
    45a0:	fe0588e3          	beqz	a1,4590 <__ieee754_sqrt+0x198>
    45a4:	0145d613          	srli	a2,a1,0x14
    45a8:	0e061a63          	bnez	a2,469c <__ieee754_sqrt+0x2a4>
    45ac:	00000613          	li	a2,0
    45b0:	0080006f          	j	45b8 <__ieee754_sqrt+0x1c0>
    45b4:	00050613          	mv	a2,a0
    45b8:	00171713          	slli	a4,a4,0x1
    45bc:	00b71593          	slli	a1,a4,0xb
    45c0:	00160513          	addi	a0,a2,1 # 80000001 <__freertos_irq_stack_top+0x7fdf9b61>
    45c4:	fe05d8e3          	bgez	a1,45b4 <__ieee754_sqrt+0x1bc>
    45c8:	02000893          	li	a7,32
    45cc:	00068813          	mv	a6,a3
    45d0:	40a888b3          	sub	a7,a7,a0
    45d4:	00070593          	mv	a1,a4
    45d8:	00a696b3          	sll	a3,a3,a0
    45dc:	01185733          	srl	a4,a6,a7
    45e0:	40c78e33          	sub	t3,a5,a2
    45e4:	00b767b3          	or	a5,a4,a1
    45e8:	e49ff06f          	j	4430 <__ieee754_sqrt+0x38>
    45ec:	fff5c893          	not	a7,a1
    45f0:	01f8d893          	srli	a7,a7,0x1f
    45f4:	011688b3          	add	a7,a3,a7
    45f8:	efdff06f          	j	44f4 <__ieee754_sqrt+0xfc>
    45fc:	eca764e3          	bltu	a4,a0,44c4 <__ieee754_sqrt+0xcc>
    4600:	00c505b3          	add	a1,a0,a2
    4604:	fe0544e3          	bltz	a0,45ec <__ieee754_sqrt+0x1f4>
    4608:	00078893          	mv	a7,a5
    460c:	00000793          	li	a5,0
    4610:	ef1ff06f          	j	4500 <__ieee754_sqrt+0x108>
    4614:	fff00793          	li	a5,-1
    4618:	06f30e63          	beq	t1,a5,4694 <__ieee754_sqrt+0x29c>
    461c:	00130813          	addi	a6,t1,1
    4620:	00185813          	srli	a6,a6,0x1
    4624:	f11ff06f          	j	4534 <__ieee754_sqrt+0x13c>
    4628:	00050613          	mv	a2,a0
    462c:	00058693          	mv	a3,a1
    4630:	de8fd0ef          	jal	ra,1c18 <__muldf3>
    4634:	00040613          	mv	a2,s0
    4638:	00048693          	mv	a3,s1
    463c:	484000ef          	jal	ra,4ac0 <__adddf3>
    4640:	00050413          	mv	s0,a0
    4644:	00040513          	mv	a0,s0
    4648:	00c12083          	lw	ra,12(sp)
    464c:	00812403          	lw	s0,8(sp)
    4650:	00058713          	mv	a4,a1
    4654:	00412483          	lw	s1,4(sp)
    4658:	00070593          	mv	a1,a4
    465c:	01010113          	addi	sp,sp,16
    4660:	00008067          	ret
    4664:	00050613          	mv	a2,a0
    4668:	00058693          	mv	a3,a1
    466c:	c01fd0ef          	jal	ra,226c <__subdf3>
    4670:	00050613          	mv	a2,a0
    4674:	00058693          	mv	a3,a1
    4678:	4cd000ef          	jal	ra,5344 <__divdf3>
    467c:	00050413          	mv	s0,a0
    4680:	00058713          	mv	a4,a1
    4684:	ed9ff06f          	j	455c <__ieee754_sqrt+0x164>
    4688:	00058713          	mv	a4,a1
    468c:	00000793          	li	a5,0
    4690:	f1dff06f          	j	45ac <__ieee754_sqrt+0x1b4>
    4694:	001e8e93          	addi	t4,t4,1
    4698:	e9dff06f          	j	4534 <__ieee754_sqrt+0x13c>
    469c:	00068813          	mv	a6,a3
    46a0:	02000893          	li	a7,32
    46a4:	fff00613          	li	a2,-1
    46a8:	f35ff06f          	j	45dc <__ieee754_sqrt+0x1e4>

000046ac <fabs>:
    46ac:	00159593          	slli	a1,a1,0x1
    46b0:	0015d593          	srli	a1,a1,0x1
    46b4:	00008067          	ret

000046b8 <finite>:
    46b8:	00159593          	slli	a1,a1,0x1
    46bc:	0015d593          	srli	a1,a1,0x1
    46c0:	80100537          	lui	a0,0x80100
    46c4:	00a58533          	add	a0,a1,a0
    46c8:	01f55513          	srli	a0,a0,0x1f
    46cc:	00008067          	ret

000046d0 <nan>:
    46d0:	00002797          	auipc	a5,0x2
    46d4:	8d078793          	addi	a5,a5,-1840 # 5fa0 <__clz_tab+0x220>
    46d8:	0007a503          	lw	a0,0(a5)
    46dc:	0047a583          	lw	a1,4(a5)
    46e0:	00008067          	ret

000046e4 <rint>:
    46e4:	4145d713          	srai	a4,a1,0x14
    46e8:	fd010113          	addi	sp,sp,-48
    46ec:	7ff77713          	andi	a4,a4,2047
    46f0:	02812423          	sw	s0,40(sp)
    46f4:	02112623          	sw	ra,44(sp)
    46f8:	02912223          	sw	s1,36(sp)
    46fc:	03212023          	sw	s2,32(sp)
    4700:	01312e23          	sw	s3,28(sp)
    4704:	c0170613          	addi	a2,a4,-1023
    4708:	01300893          	li	a7,19
    470c:	00058793          	mv	a5,a1
    4710:	00050693          	mv	a3,a0
    4714:	00058e13          	mv	t3,a1
    4718:	01f5d413          	srli	s0,a1,0x1f
    471c:	16c8cc63          	blt	a7,a2,4894 <rint+0x1b0>
    4720:	0c064863          	bltz	a2,47f0 <rint+0x10c>
    4724:	001005b7          	lui	a1,0x100
    4728:	fff58593          	addi	a1,a1,-1 # fffff <__global_pointer$+0xf93b7>
    472c:	40c5d5b3          	sra	a1,a1,a2
    4730:	00f5f533          	and	a0,a1,a5
    4734:	00d56533          	or	a0,a0,a3
    4738:	00068893          	mv	a7,a3
    473c:	00078313          	mv	t1,a5
    4740:	08050663          	beqz	a0,47cc <rint+0xe8>
    4744:	0015d593          	srli	a1,a1,0x1
    4748:	00f5f833          	and	a6,a1,a5
    474c:	00d86833          	or	a6,a6,a3
    4750:	02080663          	beqz	a6,477c <rint+0x98>
    4754:	bee70693          	addi	a3,a4,-1042
    4758:	00040e37          	lui	t3,0x40
    475c:	0016b693          	seqz	a3,a3
    4760:	fff5c593          	not	a1,a1
    4764:	80000837          	lui	a6,0x80000
    4768:	40d006b3          	neg	a3,a3
    476c:	00f5f7b3          	and	a5,a1,a5
    4770:	40ce5633          	sra	a2,t3,a2
    4774:	00d87833          	and	a6,a6,a3
    4778:	00c7ee33          	or	t3,a5,a2
    477c:	00002797          	auipc	a5,0x2
    4780:	82c78793          	addi	a5,a5,-2004 # 5fa8 <TWO52>
    4784:	00341313          	slli	t1,s0,0x3
    4788:	00678333          	add	t1,a5,t1
    478c:	00032403          	lw	s0,0(t1)
    4790:	00432483          	lw	s1,4(t1)
    4794:	00080613          	mv	a2,a6
    4798:	000e0693          	mv	a3,t3
    479c:	00040513          	mv	a0,s0
    47a0:	00048593          	mv	a1,s1
    47a4:	31c000ef          	jal	ra,4ac0 <__adddf3>
    47a8:	00a12423          	sw	a0,8(sp)
    47ac:	00b12623          	sw	a1,12(sp)
    47b0:	00812503          	lw	a0,8(sp)
    47b4:	00c12583          	lw	a1,12(sp)
    47b8:	00040613          	mv	a2,s0
    47bc:	00048693          	mv	a3,s1
    47c0:	aadfd0ef          	jal	ra,226c <__subdf3>
    47c4:	00050893          	mv	a7,a0
    47c8:	00058313          	mv	t1,a1
    47cc:	02c12083          	lw	ra,44(sp)
    47d0:	02812403          	lw	s0,40(sp)
    47d4:	02412483          	lw	s1,36(sp)
    47d8:	02012903          	lw	s2,32(sp)
    47dc:	01c12983          	lw	s3,28(sp)
    47e0:	00088513          	mv	a0,a7
    47e4:	00030593          	mv	a1,t1
    47e8:	03010113          	addi	sp,sp,48
    47ec:	00008067          	ret
    47f0:	800004b7          	lui	s1,0x80000
    47f4:	fff4c493          	not	s1,s1
    47f8:	00b4f733          	and	a4,s1,a1
    47fc:	00a76733          	or	a4,a4,a0
    4800:	00050893          	mv	a7,a0
    4804:	00058313          	mv	t1,a1
    4808:	fc0702e3          	beqz	a4,47cc <rint+0xe8>
    480c:	00c59793          	slli	a5,a1,0xc
    4810:	00c7d793          	srli	a5,a5,0xc
    4814:	00a7e733          	or	a4,a5,a0
    4818:	40e007b3          	neg	a5,a4
    481c:	00e7e7b3          	or	a5,a5,a4
    4820:	00001697          	auipc	a3,0x1
    4824:	78868693          	addi	a3,a3,1928 # 5fa8 <TWO52>
    4828:	00341713          	slli	a4,s0,0x3
    482c:	00e686b3          	add	a3,a3,a4
    4830:	00c7d793          	srli	a5,a5,0xc
    4834:	0006a903          	lw	s2,0(a3)
    4838:	0046a983          	lw	s3,4(a3)
    483c:	fffe0737          	lui	a4,0xfffe0
    4840:	00080337          	lui	t1,0x80
    4844:	00b77733          	and	a4,a4,a1
    4848:	0067f333          	and	t1,a5,t1
    484c:	00e36333          	or	t1,t1,a4
    4850:	00030693          	mv	a3,t1
    4854:	00050613          	mv	a2,a0
    4858:	00098593          	mv	a1,s3
    485c:	00090513          	mv	a0,s2
    4860:	260000ef          	jal	ra,4ac0 <__adddf3>
    4864:	00a12423          	sw	a0,8(sp)
    4868:	00b12623          	sw	a1,12(sp)
    486c:	00812503          	lw	a0,8(sp)
    4870:	00c12583          	lw	a1,12(sp)
    4874:	00090613          	mv	a2,s2
    4878:	00098693          	mv	a3,s3
    487c:	9f1fd0ef          	jal	ra,226c <__subdf3>
    4880:	00b4f4b3          	and	s1,s1,a1
    4884:	01f41313          	slli	t1,s0,0x1f
    4888:	0064e333          	or	t1,s1,t1
    488c:	00050893          	mv	a7,a0
    4890:	f3dff06f          	j	47cc <rint+0xe8>
    4894:	03300893          	li	a7,51
    4898:	02c8d663          	bge	a7,a2,48c4 <rint+0x1e0>
    489c:	40000713          	li	a4,1024
    48a0:	00050893          	mv	a7,a0
    48a4:	00058313          	mv	t1,a1
    48a8:	f2e612e3          	bne	a2,a4,47cc <rint+0xe8>
    48ac:	00050613          	mv	a2,a0
    48b0:	000e0693          	mv	a3,t3
    48b4:	20c000ef          	jal	ra,4ac0 <__adddf3>
    48b8:	00050893          	mv	a7,a0
    48bc:	00058313          	mv	t1,a1
    48c0:	f0dff06f          	j	47cc <rint+0xe8>
    48c4:	bed70713          	addi	a4,a4,-1043 # fffdfbed <__freertos_irq_stack_top+0xffdd974d>
    48c8:	fff00613          	li	a2,-1
    48cc:	00e65633          	srl	a2,a2,a4
    48d0:	00a675b3          	and	a1,a2,a0
    48d4:	00050893          	mv	a7,a0
    48d8:	00078313          	mv	t1,a5
    48dc:	ee0588e3          	beqz	a1,47cc <rint+0xe8>
    48e0:	00165613          	srli	a2,a2,0x1
    48e4:	00a677b3          	and	a5,a2,a0
    48e8:	00050813          	mv	a6,a0
    48ec:	e80788e3          	beqz	a5,477c <rint+0x98>
    48f0:	40000837          	lui	a6,0x40000
    48f4:	fff64613          	not	a2,a2
    48f8:	00a676b3          	and	a3,a2,a0
    48fc:	40e85733          	sra	a4,a6,a4
    4900:	00e6e833          	or	a6,a3,a4
    4904:	e79ff06f          	j	477c <rint+0x98>

00004908 <scalbn>:
    4908:	ff010113          	addi	sp,sp,-16
    490c:	4145d793          	srai	a5,a1,0x14
    4910:	00812423          	sw	s0,8(sp)
    4914:	00112623          	sw	ra,12(sp)
    4918:	7ff7f793          	andi	a5,a5,2047
    491c:	00060413          	mv	s0,a2
    4920:	0a079063          	bnez	a5,49c0 <scalbn+0xb8>
    4924:	00159793          	slli	a5,a1,0x1
    4928:	0017d793          	srli	a5,a5,0x1
    492c:	00a7e7b3          	or	a5,a5,a0
    4930:	08078063          	beqz	a5,49b0 <scalbn+0xa8>
    4934:	00001797          	auipc	a5,0x1
    4938:	68478793          	addi	a5,a5,1668 # 5fb8 <TWO52+0x10>
    493c:	0007a603          	lw	a2,0(a5)
    4940:	0047a683          	lw	a3,4(a5)
    4944:	ad4fd0ef          	jal	ra,1c18 <__muldf3>
    4948:	ffff47b7          	lui	a5,0xffff4
    494c:	cb078793          	addi	a5,a5,-848 # ffff3cb0 <__freertos_irq_stack_top+0xffded810>
    4950:	00058713          	mv	a4,a1
    4954:	12f44a63          	blt	s0,a5,4a88 <scalbn+0x180>
    4958:	4145d793          	srai	a5,a1,0x14
    495c:	7ff7f793          	andi	a5,a5,2047
    4960:	fca78793          	addi	a5,a5,-54
    4964:	00f407b3          	add	a5,s0,a5
    4968:	7fe00693          	li	a3,2046
    496c:	06f6ce63          	blt	a3,a5,49e8 <scalbn+0xe0>
    4970:	0ef04a63          	bgtz	a5,4a64 <scalbn+0x15c>
    4974:	fcb00693          	li	a3,-53
    4978:	0ad7d663          	bge	a5,a3,4a24 <scalbn+0x11c>
    497c:	0000c7b7          	lui	a5,0xc
    4980:	35078793          	addi	a5,a5,848 # c350 <__global_pointer$+0x5708>
    4984:	0687c263          	blt	a5,s0,49e8 <scalbn+0xe0>
    4988:	00001797          	auipc	a5,0x1
    498c:	5c878793          	addi	a5,a5,1480 # 5f50 <__clz_tab+0x1d0>
    4990:	0007a803          	lw	a6,0(a5)
    4994:	0047a883          	lw	a7,4(a5)
    4998:	1005ca63          	bltz	a1,4aac <scalbn+0x1a4>
    499c:	0007a603          	lw	a2,0(a5)
    49a0:	0047a683          	lw	a3,4(a5)
    49a4:	00080513          	mv	a0,a6
    49a8:	00088593          	mv	a1,a7
    49ac:	a6cfd0ef          	jal	ra,1c18 <__muldf3>
    49b0:	00c12083          	lw	ra,12(sp)
    49b4:	00812403          	lw	s0,8(sp)
    49b8:	01010113          	addi	sp,sp,16
    49bc:	00008067          	ret
    49c0:	7ff00693          	li	a3,2047
    49c4:	00058713          	mv	a4,a1
    49c8:	f8d79ee3          	bne	a5,a3,4964 <scalbn+0x5c>
    49cc:	00050613          	mv	a2,a0
    49d0:	00058693          	mv	a3,a1
    49d4:	0ec000ef          	jal	ra,4ac0 <__adddf3>
    49d8:	00c12083          	lw	ra,12(sp)
    49dc:	00812403          	lw	s0,8(sp)
    49e0:	01010113          	addi	sp,sp,16
    49e4:	00008067          	ret
    49e8:	00001797          	auipc	a5,0x1
    49ec:	4d078793          	addi	a5,a5,1232 # 5eb8 <__clz_tab+0x138>
    49f0:	0007a803          	lw	a6,0(a5)
    49f4:	0047a883          	lw	a7,4(a5)
    49f8:	fa05d2e3          	bgez	a1,499c <scalbn+0x94>
    49fc:	00001717          	auipc	a4,0x1
    4a00:	5c470713          	addi	a4,a4,1476 # 5fc0 <TWO52+0x18>
    4a04:	00072803          	lw	a6,0(a4)
    4a08:	00472883          	lw	a7,4(a4)
    4a0c:	0007a603          	lw	a2,0(a5)
    4a10:	0047a683          	lw	a3,4(a5)
    4a14:	00080513          	mv	a0,a6
    4a18:	00088593          	mv	a1,a7
    4a1c:	9fcfd0ef          	jal	ra,1c18 <__muldf3>
    4a20:	f91ff06f          	j	49b0 <scalbn+0xa8>
    4a24:	801005b7          	lui	a1,0x80100
    4a28:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef9b5f>
    4a2c:	03678793          	addi	a5,a5,54
    4a30:	00b77733          	and	a4,a4,a1
    4a34:	01479793          	slli	a5,a5,0x14
    4a38:	00e7e7b3          	or	a5,a5,a4
    4a3c:	00001717          	auipc	a4,0x1
    4a40:	59470713          	addi	a4,a4,1428 # 5fd0 <TWO52+0x28>
    4a44:	00072603          	lw	a2,0(a4)
    4a48:	00472683          	lw	a3,4(a4)
    4a4c:	00078593          	mv	a1,a5
    4a50:	9c8fd0ef          	jal	ra,1c18 <__muldf3>
    4a54:	00c12083          	lw	ra,12(sp)
    4a58:	00812403          	lw	s0,8(sp)
    4a5c:	01010113          	addi	sp,sp,16
    4a60:	00008067          	ret
    4a64:	00c12083          	lw	ra,12(sp)
    4a68:	00812403          	lw	s0,8(sp)
    4a6c:	801005b7          	lui	a1,0x80100
    4a70:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef9b5f>
    4a74:	00b77733          	and	a4,a4,a1
    4a78:	01479593          	slli	a1,a5,0x14
    4a7c:	00b765b3          	or	a1,a4,a1
    4a80:	01010113          	addi	sp,sp,16
    4a84:	00008067          	ret
    4a88:	00001697          	auipc	a3,0x1
    4a8c:	4c868693          	addi	a3,a3,1224 # 5f50 <__clz_tab+0x1d0>
    4a90:	0006a603          	lw	a2,0(a3)
    4a94:	0046a683          	lw	a3,4(a3)
    4a98:	980fd0ef          	jal	ra,1c18 <__muldf3>
    4a9c:	00c12083          	lw	ra,12(sp)
    4aa0:	00812403          	lw	s0,8(sp)
    4aa4:	01010113          	addi	sp,sp,16
    4aa8:	00008067          	ret
    4aac:	00001717          	auipc	a4,0x1
    4ab0:	51c70713          	addi	a4,a4,1308 # 5fc8 <TWO52+0x20>
    4ab4:	00072803          	lw	a6,0(a4)
    4ab8:	00472883          	lw	a7,4(a4)
    4abc:	ee1ff06f          	j	499c <scalbn+0x94>

00004ac0 <__adddf3>:
    4ac0:	00100837          	lui	a6,0x100
    4ac4:	fe010113          	addi	sp,sp,-32
    4ac8:	fff80813          	addi	a6,a6,-1 # fffff <__global_pointer$+0xf93b7>
    4acc:	00b87733          	and	a4,a6,a1
    4ad0:	00912a23          	sw	s1,20(sp)
    4ad4:	00d87833          	and	a6,a6,a3
    4ad8:	0145d493          	srli	s1,a1,0x14
    4adc:	0146d313          	srli	t1,a3,0x14
    4ae0:	00371e13          	slli	t3,a4,0x3
    4ae4:	01312623          	sw	s3,12(sp)
    4ae8:	01d55713          	srli	a4,a0,0x1d
    4aec:	00381813          	slli	a6,a6,0x3
    4af0:	01d65793          	srli	a5,a2,0x1d
    4af4:	7ff4f493          	andi	s1,s1,2047
    4af8:	7ff37313          	andi	t1,t1,2047
    4afc:	00112e23          	sw	ra,28(sp)
    4b00:	00812c23          	sw	s0,24(sp)
    4b04:	01212823          	sw	s2,16(sp)
    4b08:	01f5d993          	srli	s3,a1,0x1f
    4b0c:	01f6de93          	srli	t4,a3,0x1f
    4b10:	01c76733          	or	a4,a4,t3
    4b14:	00351f13          	slli	t5,a0,0x3
    4b18:	0107e833          	or	a6,a5,a6
    4b1c:	00361f93          	slli	t6,a2,0x3
    4b20:	40648e33          	sub	t3,s1,t1
    4b24:	1dd98463          	beq	s3,t4,4cec <__adddf3+0x22c>
    4b28:	17c05863          	blez	t3,4c98 <__adddf3+0x1d8>
    4b2c:	20030a63          	beqz	t1,4d40 <__adddf3+0x280>
    4b30:	008006b7          	lui	a3,0x800
    4b34:	7ff00793          	li	a5,2047
    4b38:	00d86833          	or	a6,a6,a3
    4b3c:	40f48e63          	beq	s1,a5,4f58 <__adddf3+0x498>
    4b40:	03800793          	li	a5,56
    4b44:	3dc7ca63          	blt	a5,t3,4f18 <__adddf3+0x458>
    4b48:	01f00793          	li	a5,31
    4b4c:	55c7c663          	blt	a5,t3,5098 <__adddf3+0x5d8>
    4b50:	02000513          	li	a0,32
    4b54:	41c50533          	sub	a0,a0,t3
    4b58:	01cfd7b3          	srl	a5,t6,t3
    4b5c:	00a816b3          	sll	a3,a6,a0
    4b60:	00af9933          	sll	s2,t6,a0
    4b64:	00f6e6b3          	or	a3,a3,a5
    4b68:	01203933          	snez	s2,s2
    4b6c:	01c857b3          	srl	a5,a6,t3
    4b70:	0126e933          	or	s2,a3,s2
    4b74:	40f70733          	sub	a4,a4,a5
    4b78:	412f0933          	sub	s2,t5,s2
    4b7c:	012f37b3          	sltu	a5,t5,s2
    4b80:	40f70633          	sub	a2,a4,a5
    4b84:	00861793          	slli	a5,a2,0x8
    4b88:	2a07d263          	bgez	a5,4e2c <__adddf3+0x36c>
    4b8c:	00800737          	lui	a4,0x800
    4b90:	fff70713          	addi	a4,a4,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    4b94:	00e67433          	and	s0,a2,a4
    4b98:	34040e63          	beqz	s0,4ef4 <__adddf3+0x434>
    4b9c:	00040513          	mv	a0,s0
    4ba0:	d7cfe0ef          	jal	ra,311c <__clzsi2>
    4ba4:	ff850713          	addi	a4,a0,-8 # 800ffff8 <__freertos_irq_stack_top+0x7fef9b58>
    4ba8:	02000793          	li	a5,32
    4bac:	40e787b3          	sub	a5,a5,a4
    4bb0:	00f957b3          	srl	a5,s2,a5
    4bb4:	00e41633          	sll	a2,s0,a4
    4bb8:	00c7e7b3          	or	a5,a5,a2
    4bbc:	00e91933          	sll	s2,s2,a4
    4bc0:	30974c63          	blt	a4,s1,4ed8 <__adddf3+0x418>
    4bc4:	40970533          	sub	a0,a4,s1
    4bc8:	00150613          	addi	a2,a0,1
    4bcc:	01f00713          	li	a4,31
    4bd0:	44c74663          	blt	a4,a2,501c <__adddf3+0x55c>
    4bd4:	02000713          	li	a4,32
    4bd8:	40c70733          	sub	a4,a4,a2
    4bdc:	00c956b3          	srl	a3,s2,a2
    4be0:	00e91933          	sll	s2,s2,a4
    4be4:	00e79733          	sll	a4,a5,a4
    4be8:	00d76733          	or	a4,a4,a3
    4bec:	01203933          	snez	s2,s2
    4bf0:	01276933          	or	s2,a4,s2
    4bf4:	00c7d633          	srl	a2,a5,a2
    4bf8:	00000493          	li	s1,0
    4bfc:	00797793          	andi	a5,s2,7
    4c00:	02078063          	beqz	a5,4c20 <__adddf3+0x160>
    4c04:	00f97713          	andi	a4,s2,15
    4c08:	00400793          	li	a5,4
    4c0c:	00f70a63          	beq	a4,a5,4c20 <__adddf3+0x160>
    4c10:	00490713          	addi	a4,s2,4
    4c14:	01273933          	sltu	s2,a4,s2
    4c18:	01260633          	add	a2,a2,s2
    4c1c:	00070913          	mv	s2,a4
    4c20:	00861793          	slli	a5,a2,0x8
    4c24:	2007d863          	bgez	a5,4e34 <__adddf3+0x374>
    4c28:	00148513          	addi	a0,s1,1 # 80000001 <__freertos_irq_stack_top+0x7fdf9b61>
    4c2c:	7ff00793          	li	a5,2047
    4c30:	00098593          	mv	a1,s3
    4c34:	24f50c63          	beq	a0,a5,4e8c <__adddf3+0x3cc>
    4c38:	ff8007b7          	lui	a5,0xff800
    4c3c:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    4c40:	00f677b3          	and	a5,a2,a5
    4c44:	01d79893          	slli	a7,a5,0x1d
    4c48:	00395913          	srli	s2,s2,0x3
    4c4c:	00979793          	slli	a5,a5,0x9
    4c50:	0128e8b3          	or	a7,a7,s2
    4c54:	00c7d793          	srli	a5,a5,0xc
    4c58:	7ff57513          	andi	a0,a0,2047
    4c5c:	00c79693          	slli	a3,a5,0xc
    4c60:	01451513          	slli	a0,a0,0x14
    4c64:	01c12083          	lw	ra,28(sp)
    4c68:	01812403          	lw	s0,24(sp)
    4c6c:	00c6d693          	srli	a3,a3,0xc
    4c70:	01f59593          	slli	a1,a1,0x1f
    4c74:	00a6e6b3          	or	a3,a3,a0
    4c78:	00b6e6b3          	or	a3,a3,a1
    4c7c:	01412483          	lw	s1,20(sp)
    4c80:	01012903          	lw	s2,16(sp)
    4c84:	00c12983          	lw	s3,12(sp)
    4c88:	00088513          	mv	a0,a7
    4c8c:	00068593          	mv	a1,a3
    4c90:	02010113          	addi	sp,sp,32
    4c94:	00008067          	ret
    4c98:	0c0e1463          	bnez	t3,4d60 <__adddf3+0x2a0>
    4c9c:	00148313          	addi	t1,s1,1
    4ca0:	7fe37313          	andi	t1,t1,2046
    4ca4:	28031063          	bnez	t1,4f24 <__adddf3+0x464>
    4ca8:	01e767b3          	or	a5,a4,t5
    4cac:	01f868b3          	or	a7,a6,t6
    4cb0:	1e049663          	bnez	s1,4e9c <__adddf3+0x3dc>
    4cb4:	4c078063          	beqz	a5,5174 <__adddf3+0x6b4>
    4cb8:	50088863          	beqz	a7,51c8 <__adddf3+0x708>
    4cbc:	41ff0933          	sub	s2,t5,t6
    4cc0:	410707b3          	sub	a5,a4,a6
    4cc4:	012f3633          	sltu	a2,t5,s2
    4cc8:	40c78633          	sub	a2,a5,a2
    4ccc:	00861793          	slli	a5,a2,0x8
    4cd0:	5a07d463          	bgez	a5,5278 <__adddf3+0x7b8>
    4cd4:	41ef8933          	sub	s2,t6,t5
    4cd8:	40e807b3          	sub	a5,a6,a4
    4cdc:	012fb633          	sltu	a2,t6,s2
    4ce0:	40c78633          	sub	a2,a5,a2
    4ce4:	000e8993          	mv	s3,t4
    4ce8:	f15ff06f          	j	4bfc <__adddf3+0x13c>
    4cec:	0fc05a63          	blez	t3,4de0 <__adddf3+0x320>
    4cf0:	0c030863          	beqz	t1,4dc0 <__adddf3+0x300>
    4cf4:	008006b7          	lui	a3,0x800
    4cf8:	7ff00793          	li	a5,2047
    4cfc:	00d86833          	or	a6,a6,a3
    4d00:	44f48e63          	beq	s1,a5,515c <__adddf3+0x69c>
    4d04:	03800793          	li	a5,56
    4d08:	15c7cc63          	blt	a5,t3,4e60 <__adddf3+0x3a0>
    4d0c:	01f00793          	li	a5,31
    4d10:	3fc7da63          	bge	a5,t3,5104 <__adddf3+0x644>
    4d14:	fe0e0913          	addi	s2,t3,-32 # 3ffe0 <__global_pointer$+0x39398>
    4d18:	02000793          	li	a5,32
    4d1c:	012856b3          	srl	a3,a6,s2
    4d20:	00fe0a63          	beq	t3,a5,4d34 <__adddf3+0x274>
    4d24:	04000913          	li	s2,64
    4d28:	41c90933          	sub	s2,s2,t3
    4d2c:	01281933          	sll	s2,a6,s2
    4d30:	012fefb3          	or	t6,t6,s2
    4d34:	01f03933          	snez	s2,t6
    4d38:	00d96933          	or	s2,s2,a3
    4d3c:	12c0006f          	j	4e68 <__adddf3+0x3a8>
    4d40:	01f867b3          	or	a5,a6,t6
    4d44:	22078663          	beqz	a5,4f70 <__adddf3+0x4b0>
    4d48:	fffe0793          	addi	a5,t3,-1
    4d4c:	44078463          	beqz	a5,5194 <__adddf3+0x6d4>
    4d50:	7ff00693          	li	a3,2047
    4d54:	20de0263          	beq	t3,a3,4f58 <__adddf3+0x498>
    4d58:	00078e13          	mv	t3,a5
    4d5c:	de5ff06f          	j	4b40 <__adddf3+0x80>
    4d60:	409305b3          	sub	a1,t1,s1
    4d64:	28049663          	bnez	s1,4ff0 <__adddf3+0x530>
    4d68:	01e767b3          	or	a5,a4,t5
    4d6c:	3c078263          	beqz	a5,5130 <__adddf3+0x670>
    4d70:	fff58793          	addi	a5,a1,-1
    4d74:	50078c63          	beqz	a5,528c <__adddf3+0x7cc>
    4d78:	7ff00693          	li	a3,2047
    4d7c:	28d58263          	beq	a1,a3,5000 <__adddf3+0x540>
    4d80:	00078593          	mv	a1,a5
    4d84:	03800793          	li	a5,56
    4d88:	32b7ce63          	blt	a5,a1,50c4 <__adddf3+0x604>
    4d8c:	01f00793          	li	a5,31
    4d90:	4ab7c263          	blt	a5,a1,5234 <__adddf3+0x774>
    4d94:	02000793          	li	a5,32
    4d98:	40b787b3          	sub	a5,a5,a1
    4d9c:	00f71933          	sll	s2,a4,a5
    4da0:	00bf56b3          	srl	a3,t5,a1
    4da4:	00ff17b3          	sll	a5,t5,a5
    4da8:	00d96933          	or	s2,s2,a3
    4dac:	00f037b3          	snez	a5,a5
    4db0:	00b75733          	srl	a4,a4,a1
    4db4:	00f96933          	or	s2,s2,a5
    4db8:	40e80833          	sub	a6,a6,a4
    4dbc:	3100006f          	j	50cc <__adddf3+0x60c>
    4dc0:	01f867b3          	or	a5,a6,t6
    4dc4:	3e078463          	beqz	a5,51ac <__adddf3+0x6ec>
    4dc8:	fffe0793          	addi	a5,t3,-1
    4dcc:	28078263          	beqz	a5,5050 <__adddf3+0x590>
    4dd0:	7ff00693          	li	a3,2047
    4dd4:	38de0463          	beq	t3,a3,515c <__adddf3+0x69c>
    4dd8:	00078e13          	mv	t3,a5
    4ddc:	f29ff06f          	j	4d04 <__adddf3+0x244>
    4de0:	1a0e1663          	bnez	t3,4f8c <__adddf3+0x4cc>
    4de4:	00148693          	addi	a3,s1,1
    4de8:	7fe6f793          	andi	a5,a3,2046
    4dec:	3e079a63          	bnez	a5,51e0 <__adddf3+0x720>
    4df0:	01e767b3          	or	a5,a4,t5
    4df4:	34049e63          	bnez	s1,5150 <__adddf3+0x690>
    4df8:	4a078863          	beqz	a5,52a8 <__adddf3+0x7e8>
    4dfc:	01f867b3          	or	a5,a6,t6
    4e00:	3c078463          	beqz	a5,51c8 <__adddf3+0x708>
    4e04:	01ff0933          	add	s2,t5,t6
    4e08:	010707b3          	add	a5,a4,a6
    4e0c:	01e93f33          	sltu	t5,s2,t5
    4e10:	01e78633          	add	a2,a5,t5
    4e14:	00861793          	slli	a5,a2,0x8
    4e18:	0007da63          	bgez	a5,4e2c <__adddf3+0x36c>
    4e1c:	ff8007b7          	lui	a5,0xff800
    4e20:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    4e24:	00f67633          	and	a2,a2,a5
    4e28:	00100493          	li	s1,1
    4e2c:	00797793          	andi	a5,s2,7
    4e30:	dc079ae3          	bnez	a5,4c04 <__adddf3+0x144>
    4e34:	01d61793          	slli	a5,a2,0x1d
    4e38:	00395893          	srli	a7,s2,0x3
    4e3c:	00f8e8b3          	or	a7,a7,a5
    4e40:	00365793          	srli	a5,a2,0x3
    4e44:	7ff00713          	li	a4,2047
    4e48:	06e48a63          	beq	s1,a4,4ebc <__adddf3+0x3fc>
    4e4c:	00c79793          	slli	a5,a5,0xc
    4e50:	00c7d793          	srli	a5,a5,0xc
    4e54:	7ff4f513          	andi	a0,s1,2047
    4e58:	00098593          	mv	a1,s3
    4e5c:	e01ff06f          	j	4c5c <__adddf3+0x19c>
    4e60:	01f86933          	or	s2,a6,t6
    4e64:	01203933          	snez	s2,s2
    4e68:	01e90933          	add	s2,s2,t5
    4e6c:	01e937b3          	sltu	a5,s2,t5
    4e70:	00e78633          	add	a2,a5,a4
    4e74:	00861793          	slli	a5,a2,0x8
    4e78:	fa07dae3          	bgez	a5,4e2c <__adddf3+0x36c>
    4e7c:	00148493          	addi	s1,s1,1
    4e80:	7ff00793          	li	a5,2047
    4e84:	1ef49663          	bne	s1,a5,5070 <__adddf3+0x5b0>
    4e88:	00098593          	mv	a1,s3
    4e8c:	7ff00513          	li	a0,2047
    4e90:	00000793          	li	a5,0
    4e94:	00000893          	li	a7,0
    4e98:	dc5ff06f          	j	4c5c <__adddf3+0x19c>
    4e9c:	0a079c63          	bnez	a5,4f54 <__adddf3+0x494>
    4ea0:	46088463          	beqz	a7,5308 <__adddf3+0x848>
    4ea4:	00361693          	slli	a3,a2,0x3
    4ea8:	01d81793          	slli	a5,a6,0x1d
    4eac:	0036d693          	srli	a3,a3,0x3
    4eb0:	00d7e8b3          	or	a7,a5,a3
    4eb4:	000e8993          	mv	s3,t4
    4eb8:	00385793          	srli	a5,a6,0x3
    4ebc:	00f8e7b3          	or	a5,a7,a5
    4ec0:	fc0784e3          	beqz	a5,4e88 <__adddf3+0x3c8>
    4ec4:	00000593          	li	a1,0
    4ec8:	7ff00513          	li	a0,2047
    4ecc:	000807b7          	lui	a5,0x80
    4ed0:	00000893          	li	a7,0
    4ed4:	d89ff06f          	j	4c5c <__adddf3+0x19c>
    4ed8:	ff800637          	lui	a2,0xff800
    4edc:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    4ee0:	00c7f633          	and	a2,a5,a2
    4ee4:	00797793          	andi	a5,s2,7
    4ee8:	40e484b3          	sub	s1,s1,a4
    4eec:	d0079ce3          	bnez	a5,4c04 <__adddf3+0x144>
    4ef0:	f45ff06f          	j	4e34 <__adddf3+0x374>
    4ef4:	00090513          	mv	a0,s2
    4ef8:	a24fe0ef          	jal	ra,311c <__clzsi2>
    4efc:	01850713          	addi	a4,a0,24
    4f00:	01f00793          	li	a5,31
    4f04:	cae7d2e3          	bge	a5,a4,4ba8 <__adddf3+0xe8>
    4f08:	ff850613          	addi	a2,a0,-8
    4f0c:	00c917b3          	sll	a5,s2,a2
    4f10:	00000913          	li	s2,0
    4f14:	cadff06f          	j	4bc0 <__adddf3+0x100>
    4f18:	01f86933          	or	s2,a6,t6
    4f1c:	01203933          	snez	s2,s2
    4f20:	c59ff06f          	j	4b78 <__adddf3+0xb8>
    4f24:	41ff0933          	sub	s2,t5,t6
    4f28:	41070633          	sub	a2,a4,a6
    4f2c:	012f3433          	sltu	s0,t5,s2
    4f30:	40860433          	sub	s0,a2,s0
    4f34:	00841793          	slli	a5,s0,0x8
    4f38:	2c07cc63          	bltz	a5,5210 <__adddf3+0x750>
    4f3c:	008968b3          	or	a7,s2,s0
    4f40:	c4089ce3          	bnez	a7,4b98 <__adddf3+0xd8>
    4f44:	00000793          	li	a5,0
    4f48:	00000993          	li	s3,0
    4f4c:	00000493          	li	s1,0
    4f50:	efdff06f          	j	4e4c <__adddf3+0x38c>
    4f54:	f60898e3          	bnez	a7,4ec4 <__adddf3+0x404>
    4f58:	00351513          	slli	a0,a0,0x3
    4f5c:	01d71793          	slli	a5,a4,0x1d
    4f60:	00355513          	srli	a0,a0,0x3
    4f64:	00a7e8b3          	or	a7,a5,a0
    4f68:	00375793          	srli	a5,a4,0x3
    4f6c:	f51ff06f          	j	4ebc <__adddf3+0x3fc>
    4f70:	00351513          	slli	a0,a0,0x3
    4f74:	01d71793          	slli	a5,a4,0x1d
    4f78:	00355513          	srli	a0,a0,0x3
    4f7c:	00a7e8b3          	or	a7,a5,a0
    4f80:	000e0493          	mv	s1,t3
    4f84:	00375793          	srli	a5,a4,0x3
    4f88:	ebdff06f          	j	4e44 <__adddf3+0x384>
    4f8c:	40930533          	sub	a0,t1,s1
    4f90:	14048a63          	beqz	s1,50e4 <__adddf3+0x624>
    4f94:	008006b7          	lui	a3,0x800
    4f98:	7ff00793          	li	a5,2047
    4f9c:	00d76733          	or	a4,a4,a3
    4fa0:	38f30663          	beq	t1,a5,532c <__adddf3+0x86c>
    4fa4:	03800793          	li	a5,56
    4fa8:	28a7c063          	blt	a5,a0,5228 <__adddf3+0x768>
    4fac:	01f00793          	li	a5,31
    4fb0:	32a7c663          	blt	a5,a0,52dc <__adddf3+0x81c>
    4fb4:	02000793          	li	a5,32
    4fb8:	40a787b3          	sub	a5,a5,a0
    4fbc:	00f71933          	sll	s2,a4,a5
    4fc0:	00af56b3          	srl	a3,t5,a0
    4fc4:	00ff17b3          	sll	a5,t5,a5
    4fc8:	00d96933          	or	s2,s2,a3
    4fcc:	00f037b3          	snez	a5,a5
    4fd0:	00a75733          	srl	a4,a4,a0
    4fd4:	00f96933          	or	s2,s2,a5
    4fd8:	00e80833          	add	a6,a6,a4
    4fdc:	01f90933          	add	s2,s2,t6
    4fe0:	01f937b3          	sltu	a5,s2,t6
    4fe4:	01078633          	add	a2,a5,a6
    4fe8:	00030493          	mv	s1,t1
    4fec:	e89ff06f          	j	4e74 <__adddf3+0x3b4>
    4ff0:	008006b7          	lui	a3,0x800
    4ff4:	7ff00793          	li	a5,2047
    4ff8:	00d76733          	or	a4,a4,a3
    4ffc:	d8f314e3          	bne	t1,a5,4d84 <__adddf3+0x2c4>
    5000:	00361793          	slli	a5,a2,0x3
    5004:	0037d793          	srli	a5,a5,0x3
    5008:	01d81893          	slli	a7,a6,0x1d
    500c:	0117e8b3          	or	a7,a5,a7
    5010:	000e8993          	mv	s3,t4
    5014:	00385793          	srli	a5,a6,0x3
    5018:	ea5ff06f          	j	4ebc <__adddf3+0x3fc>
    501c:	fe150713          	addi	a4,a0,-31
    5020:	02000693          	li	a3,32
    5024:	00e7d733          	srl	a4,a5,a4
    5028:	00d60a63          	beq	a2,a3,503c <__adddf3+0x57c>
    502c:	04000693          	li	a3,64
    5030:	40c68633          	sub	a2,a3,a2
    5034:	00c79633          	sll	a2,a5,a2
    5038:	00c96933          	or	s2,s2,a2
    503c:	01203933          	snez	s2,s2
    5040:	00e96933          	or	s2,s2,a4
    5044:	00000613          	li	a2,0
    5048:	00000493          	li	s1,0
    504c:	de1ff06f          	j	4e2c <__adddf3+0x36c>
    5050:	01ff0933          	add	s2,t5,t6
    5054:	010707b3          	add	a5,a4,a6
    5058:	01e93633          	sltu	a2,s2,t5
    505c:	00c78633          	add	a2,a5,a2
    5060:	00861793          	slli	a5,a2,0x8
    5064:	00100493          	li	s1,1
    5068:	dc07d2e3          	bgez	a5,4e2c <__adddf3+0x36c>
    506c:	00200493          	li	s1,2
    5070:	ff8007b7          	lui	a5,0xff800
    5074:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f9b5f>
    5078:	00f677b3          	and	a5,a2,a5
    507c:	00195713          	srli	a4,s2,0x1
    5080:	00197913          	andi	s2,s2,1
    5084:	01276933          	or	s2,a4,s2
    5088:	01f79893          	slli	a7,a5,0x1f
    508c:	0128e933          	or	s2,a7,s2
    5090:	0017d613          	srli	a2,a5,0x1
    5094:	b69ff06f          	j	4bfc <__adddf3+0x13c>
    5098:	fe0e0913          	addi	s2,t3,-32
    509c:	02000793          	li	a5,32
    50a0:	012856b3          	srl	a3,a6,s2
    50a4:	00fe0a63          	beq	t3,a5,50b8 <__adddf3+0x5f8>
    50a8:	04000913          	li	s2,64
    50ac:	41c90933          	sub	s2,s2,t3
    50b0:	01281933          	sll	s2,a6,s2
    50b4:	012fefb3          	or	t6,t6,s2
    50b8:	01f03933          	snez	s2,t6
    50bc:	00d96933          	or	s2,s2,a3
    50c0:	ab9ff06f          	j	4b78 <__adddf3+0xb8>
    50c4:	01e76933          	or	s2,a4,t5
    50c8:	01203933          	snez	s2,s2
    50cc:	412f8933          	sub	s2,t6,s2
    50d0:	012fb7b3          	sltu	a5,t6,s2
    50d4:	40f80633          	sub	a2,a6,a5
    50d8:	00030493          	mv	s1,t1
    50dc:	000e8993          	mv	s3,t4
    50e0:	aa5ff06f          	j	4b84 <__adddf3+0xc4>
    50e4:	01e767b3          	or	a5,a4,t5
    50e8:	1c078c63          	beqz	a5,52c0 <__adddf3+0x800>
    50ec:	fff50793          	addi	a5,a0,-1
    50f0:	22078463          	beqz	a5,5318 <__adddf3+0x858>
    50f4:	7ff00693          	li	a3,2047
    50f8:	16d50463          	beq	a0,a3,5260 <__adddf3+0x7a0>
    50fc:	00078513          	mv	a0,a5
    5100:	ea5ff06f          	j	4fa4 <__adddf3+0x4e4>
    5104:	02000793          	li	a5,32
    5108:	41c787b3          	sub	a5,a5,t3
    510c:	00f816b3          	sll	a3,a6,a5
    5110:	00ff9933          	sll	s2,t6,a5
    5114:	01cfd633          	srl	a2,t6,t3
    5118:	00c6e6b3          	or	a3,a3,a2
    511c:	01203933          	snez	s2,s2
    5120:	01c857b3          	srl	a5,a6,t3
    5124:	0126e933          	or	s2,a3,s2
    5128:	00f70733          	add	a4,a4,a5
    512c:	d3dff06f          	j	4e68 <__adddf3+0x3a8>
    5130:	00361793          	slli	a5,a2,0x3
    5134:	0037d793          	srli	a5,a5,0x3
    5138:	01d81893          	slli	a7,a6,0x1d
    513c:	0117e8b3          	or	a7,a5,a7
    5140:	00058493          	mv	s1,a1
    5144:	00385793          	srli	a5,a6,0x3
    5148:	000e8993          	mv	s3,t4
    514c:	cf9ff06f          	j	4e44 <__adddf3+0x384>
    5150:	10078863          	beqz	a5,5260 <__adddf3+0x7a0>
    5154:	01f86933          	or	s2,a6,t6
    5158:	d60916e3          	bnez	s2,4ec4 <__adddf3+0x404>
    515c:	00351513          	slli	a0,a0,0x3
    5160:	01d71793          	slli	a5,a4,0x1d
    5164:	00355513          	srli	a0,a0,0x3
    5168:	00f568b3          	or	a7,a0,a5
    516c:	00375793          	srli	a5,a4,0x3
    5170:	d4dff06f          	j	4ebc <__adddf3+0x3fc>
    5174:	10088663          	beqz	a7,5280 <__adddf3+0x7c0>
    5178:	00361693          	slli	a3,a2,0x3
    517c:	01d81793          	slli	a5,a6,0x1d
    5180:	0036d693          	srli	a3,a3,0x3
    5184:	00d7e8b3          	or	a7,a5,a3
    5188:	000e8993          	mv	s3,t4
    518c:	00385793          	srli	a5,a6,0x3
    5190:	cbdff06f          	j	4e4c <__adddf3+0x38c>
    5194:	41ff0933          	sub	s2,t5,t6
    5198:	410707b3          	sub	a5,a4,a6
    519c:	012f3f33          	sltu	t5,t5,s2
    51a0:	41e78633          	sub	a2,a5,t5
    51a4:	00100493          	li	s1,1
    51a8:	9ddff06f          	j	4b84 <__adddf3+0xc4>
    51ac:	00351513          	slli	a0,a0,0x3
    51b0:	01d71793          	slli	a5,a4,0x1d
    51b4:	00355513          	srli	a0,a0,0x3
    51b8:	00f568b3          	or	a7,a0,a5
    51bc:	000e0493          	mv	s1,t3
    51c0:	00375793          	srli	a5,a4,0x3
    51c4:	c81ff06f          	j	4e44 <__adddf3+0x384>
    51c8:	00351513          	slli	a0,a0,0x3
    51cc:	01d71793          	slli	a5,a4,0x1d
    51d0:	00355513          	srli	a0,a0,0x3
    51d4:	00a7e8b3          	or	a7,a5,a0
    51d8:	00375793          	srli	a5,a4,0x3
    51dc:	c71ff06f          	j	4e4c <__adddf3+0x38c>
    51e0:	7ff00793          	li	a5,2047
    51e4:	caf682e3          	beq	a3,a5,4e88 <__adddf3+0x3c8>
    51e8:	01ff0933          	add	s2,t5,t6
    51ec:	01e93633          	sltu	a2,s2,t5
    51f0:	010707b3          	add	a5,a4,a6
    51f4:	00c787b3          	add	a5,a5,a2
    51f8:	01f79893          	slli	a7,a5,0x1f
    51fc:	00195913          	srli	s2,s2,0x1
    5200:	0128e933          	or	s2,a7,s2
    5204:	0017d613          	srli	a2,a5,0x1
    5208:	00068493          	mv	s1,a3
    520c:	c21ff06f          	j	4e2c <__adddf3+0x36c>
    5210:	41ef8933          	sub	s2,t6,t5
    5214:	40e80733          	sub	a4,a6,a4
    5218:	012fb633          	sltu	a2,t6,s2
    521c:	40c70433          	sub	s0,a4,a2
    5220:	000e8993          	mv	s3,t4
    5224:	975ff06f          	j	4b98 <__adddf3+0xd8>
    5228:	01e76933          	or	s2,a4,t5
    522c:	01203933          	snez	s2,s2
    5230:	dadff06f          	j	4fdc <__adddf3+0x51c>
    5234:	fe058793          	addi	a5,a1,-32
    5238:	02000693          	li	a3,32
    523c:	00f757b3          	srl	a5,a4,a5
    5240:	00d58a63          	beq	a1,a3,5254 <__adddf3+0x794>
    5244:	04000693          	li	a3,64
    5248:	40b685b3          	sub	a1,a3,a1
    524c:	00b71733          	sll	a4,a4,a1
    5250:	00ef6f33          	or	t5,t5,a4
    5254:	01e03933          	snez	s2,t5
    5258:	00f96933          	or	s2,s2,a5
    525c:	e71ff06f          	j	50cc <__adddf3+0x60c>
    5260:	00361793          	slli	a5,a2,0x3
    5264:	0037d793          	srli	a5,a5,0x3
    5268:	01d81893          	slli	a7,a6,0x1d
    526c:	0117e8b3          	or	a7,a5,a7
    5270:	00385793          	srli	a5,a6,0x3
    5274:	c49ff06f          	j	4ebc <__adddf3+0x3fc>
    5278:	00c968b3          	or	a7,s2,a2
    527c:	ba0898e3          	bnez	a7,4e2c <__adddf3+0x36c>
    5280:	00000793          	li	a5,0
    5284:	00000993          	li	s3,0
    5288:	bc5ff06f          	j	4e4c <__adddf3+0x38c>
    528c:	41ef8933          	sub	s2,t6,t5
    5290:	40e807b3          	sub	a5,a6,a4
    5294:	012fb633          	sltu	a2,t6,s2
    5298:	40c78633          	sub	a2,a5,a2
    529c:	000e8993          	mv	s3,t4
    52a0:	00100493          	li	s1,1
    52a4:	8e1ff06f          	j	4b84 <__adddf3+0xc4>
    52a8:	00361693          	slli	a3,a2,0x3
    52ac:	01d81793          	slli	a5,a6,0x1d
    52b0:	0036d693          	srli	a3,a3,0x3
    52b4:	00d7e8b3          	or	a7,a5,a3
    52b8:	00385793          	srli	a5,a6,0x3
    52bc:	b91ff06f          	j	4e4c <__adddf3+0x38c>
    52c0:	00361693          	slli	a3,a2,0x3
    52c4:	01d81793          	slli	a5,a6,0x1d
    52c8:	0036d693          	srli	a3,a3,0x3
    52cc:	00d7e8b3          	or	a7,a5,a3
    52d0:	00050493          	mv	s1,a0
    52d4:	00385793          	srli	a5,a6,0x3
    52d8:	b6dff06f          	j	4e44 <__adddf3+0x384>
    52dc:	fe050793          	addi	a5,a0,-32
    52e0:	02000693          	li	a3,32
    52e4:	00f757b3          	srl	a5,a4,a5
    52e8:	00d50a63          	beq	a0,a3,52fc <__adddf3+0x83c>
    52ec:	04000693          	li	a3,64
    52f0:	40a68533          	sub	a0,a3,a0
    52f4:	00a71733          	sll	a4,a4,a0
    52f8:	00ef6f33          	or	t5,t5,a4
    52fc:	01e03933          	snez	s2,t5
    5300:	00f96933          	or	s2,s2,a5
    5304:	cd9ff06f          	j	4fdc <__adddf3+0x51c>
    5308:	00000593          	li	a1,0
    530c:	7ff00513          	li	a0,2047
    5310:	000807b7          	lui	a5,0x80
    5314:	949ff06f          	j	4c5c <__adddf3+0x19c>
    5318:	01ff0933          	add	s2,t5,t6
    531c:	010707b3          	add	a5,a4,a6
    5320:	01f93633          	sltu	a2,s2,t6
    5324:	00c78633          	add	a2,a5,a2
    5328:	d39ff06f          	j	5060 <__adddf3+0x5a0>
    532c:	00361693          	slli	a3,a2,0x3
    5330:	01d81793          	slli	a5,a6,0x1d
    5334:	0036d693          	srli	a3,a3,0x3
    5338:	00d7e8b3          	or	a7,a5,a3
    533c:	00385793          	srli	a5,a6,0x3
    5340:	b7dff06f          	j	4ebc <__adddf3+0x3fc>

00005344 <__divdf3>:
    5344:	fc010113          	addi	sp,sp,-64
    5348:	0145d793          	srli	a5,a1,0x14
    534c:	02812c23          	sw	s0,56(sp)
    5350:	02912a23          	sw	s1,52(sp)
    5354:	03312623          	sw	s3,44(sp)
    5358:	00050493          	mv	s1,a0
    535c:	00c59413          	slli	s0,a1,0xc
    5360:	02112e23          	sw	ra,60(sp)
    5364:	03212823          	sw	s2,48(sp)
    5368:	03412423          	sw	s4,40(sp)
    536c:	03512223          	sw	s5,36(sp)
    5370:	03612023          	sw	s6,32(sp)
    5374:	01712e23          	sw	s7,28(sp)
    5378:	7ff7f513          	andi	a0,a5,2047
    537c:	00c45413          	srli	s0,s0,0xc
    5380:	01f5d993          	srli	s3,a1,0x1f
    5384:	16050863          	beqz	a0,54f4 <__divdf3+0x1b0>
    5388:	7ff00793          	li	a5,2047
    538c:	1cf50263          	beq	a0,a5,5550 <__divdf3+0x20c>
    5390:	01d4da93          	srli	s5,s1,0x1d
    5394:	00341413          	slli	s0,s0,0x3
    5398:	008ae433          	or	s0,s5,s0
    539c:	00800ab7          	lui	s5,0x800
    53a0:	00349b13          	slli	s6,s1,0x3
    53a4:	01546ab3          	or	s5,s0,s5
    53a8:	c0150913          	addi	s2,a0,-1023
    53ac:	00000493          	li	s1,0
    53b0:	00000b93          	li	s7,0
    53b4:	0146d713          	srli	a4,a3,0x14
    53b8:	00c69413          	slli	s0,a3,0xc
    53bc:	7ff77713          	andi	a4,a4,2047
    53c0:	00c45413          	srli	s0,s0,0xc
    53c4:	01f6da13          	srli	s4,a3,0x1f
    53c8:	0e070063          	beqz	a4,54a8 <__divdf3+0x164>
    53cc:	7ff00793          	li	a5,2047
    53d0:	04f70863          	beq	a4,a5,5420 <__divdf3+0xdc>
    53d4:	00341793          	slli	a5,s0,0x3
    53d8:	01d65413          	srli	s0,a2,0x1d
    53dc:	00f467b3          	or	a5,s0,a5
    53e0:	c0170713          	addi	a4,a4,-1023
    53e4:	00800437          	lui	s0,0x800
    53e8:	0087e433          	or	s0,a5,s0
    53ec:	00361813          	slli	a6,a2,0x3
    53f0:	40e90933          	sub	s2,s2,a4
    53f4:	00000693          	li	a3,0
    53f8:	00f00793          	li	a5,15
    53fc:	0149c5b3          	xor	a1,s3,s4
    5400:	2497ec63          	bltu	a5,s1,5658 <__divdf3+0x314>
    5404:	00001717          	auipc	a4,0x1
    5408:	bd470713          	addi	a4,a4,-1068 # 5fd8 <TWO52+0x30>
    540c:	00249493          	slli	s1,s1,0x2
    5410:	00e484b3          	add	s1,s1,a4
    5414:	0004a783          	lw	a5,0(s1)
    5418:	00e787b3          	add	a5,a5,a4
    541c:	00078067          	jr	a5 # 80000 <__global_pointer$+0x793b8>
    5420:	00c46833          	or	a6,s0,a2
    5424:	80190913          	addi	s2,s2,-2047
    5428:	18081063          	bnez	a6,55a8 <__divdf3+0x264>
    542c:	0024e493          	ori	s1,s1,2
    5430:	00000413          	li	s0,0
    5434:	00200693          	li	a3,2
    5438:	fc1ff06f          	j	53f8 <__divdf3+0xb4>
    543c:	7ff00713          	li	a4,2047
    5440:	00000793          	li	a5,0
    5444:	00000413          	li	s0,0
    5448:	00c79793          	slli	a5,a5,0xc
    544c:	00040513          	mv	a0,s0
    5450:	03c12083          	lw	ra,60(sp)
    5454:	03812403          	lw	s0,56(sp)
    5458:	01471713          	slli	a4,a4,0x14
    545c:	00c7d793          	srli	a5,a5,0xc
    5460:	01f59593          	slli	a1,a1,0x1f
    5464:	00e7e7b3          	or	a5,a5,a4
    5468:	00b7e7b3          	or	a5,a5,a1
    546c:	03412483          	lw	s1,52(sp)
    5470:	03012903          	lw	s2,48(sp)
    5474:	02c12983          	lw	s3,44(sp)
    5478:	02812a03          	lw	s4,40(sp)
    547c:	02412a83          	lw	s5,36(sp)
    5480:	02012b03          	lw	s6,32(sp)
    5484:	01c12b83          	lw	s7,28(sp)
    5488:	00078593          	mv	a1,a5
    548c:	04010113          	addi	sp,sp,64
    5490:	00008067          	ret
    5494:	00000593          	li	a1,0
    5498:	7ff00713          	li	a4,2047
    549c:	000807b7          	lui	a5,0x80
    54a0:	00000413          	li	s0,0
    54a4:	fa5ff06f          	j	5448 <__divdf3+0x104>
    54a8:	00c46833          	or	a6,s0,a2
    54ac:	0e080663          	beqz	a6,5598 <__divdf3+0x254>
    54b0:	3e040a63          	beqz	s0,58a4 <__divdf3+0x560>
    54b4:	00040513          	mv	a0,s0
    54b8:	00c12423          	sw	a2,8(sp)
    54bc:	c61fd0ef          	jal	ra,311c <__clzsi2>
    54c0:	00812603          	lw	a2,8(sp)
    54c4:	ff550593          	addi	a1,a0,-11
    54c8:	01d00693          	li	a3,29
    54cc:	ff850713          	addi	a4,a0,-8
    54d0:	40b686b3          	sub	a3,a3,a1
    54d4:	00e417b3          	sll	a5,s0,a4
    54d8:	00d656b3          	srl	a3,a2,a3
    54dc:	00f6e433          	or	s0,a3,a5
    54e0:	00e61833          	sll	a6,a2,a4
    54e4:	01250533          	add	a0,a0,s2
    54e8:	3f350913          	addi	s2,a0,1011
    54ec:	00000693          	li	a3,0
    54f0:	f09ff06f          	j	53f8 <__divdf3+0xb4>
    54f4:	00946ab3          	or	s5,s0,s1
    54f8:	080a8663          	beqz	s5,5584 <__divdf3+0x240>
    54fc:	00d12623          	sw	a3,12(sp)
    5500:	00c12423          	sw	a2,8(sp)
    5504:	36040863          	beqz	s0,5874 <__divdf3+0x530>
    5508:	00040513          	mv	a0,s0
    550c:	c11fd0ef          	jal	ra,311c <__clzsi2>
    5510:	00812603          	lw	a2,8(sp)
    5514:	00c12683          	lw	a3,12(sp)
    5518:	00050913          	mv	s2,a0
    551c:	ff550713          	addi	a4,a0,-11
    5520:	01d00a93          	li	s5,29
    5524:	ff890b13          	addi	s6,s2,-8
    5528:	40ea8ab3          	sub	s5,s5,a4
    552c:	01641433          	sll	s0,s0,s6
    5530:	0154dab3          	srl	s5,s1,s5
    5534:	008aeab3          	or	s5,s5,s0
    5538:	01649b33          	sll	s6,s1,s6
    553c:	c0d00513          	li	a0,-1011
    5540:	41250933          	sub	s2,a0,s2
    5544:	00000493          	li	s1,0
    5548:	00000b93          	li	s7,0
    554c:	e69ff06f          	j	53b4 <__divdf3+0x70>
    5550:	00946ab3          	or	s5,s0,s1
    5554:	000a9c63          	bnez	s5,556c <__divdf3+0x228>
    5558:	00000b13          	li	s6,0
    555c:	00800493          	li	s1,8
    5560:	7ff00913          	li	s2,2047
    5564:	00200b93          	li	s7,2
    5568:	e4dff06f          	j	53b4 <__divdf3+0x70>
    556c:	00048b13          	mv	s6,s1
    5570:	00040a93          	mv	s5,s0
    5574:	00c00493          	li	s1,12
    5578:	7ff00913          	li	s2,2047
    557c:	00300b93          	li	s7,3
    5580:	e35ff06f          	j	53b4 <__divdf3+0x70>
    5584:	00000b13          	li	s6,0
    5588:	00400493          	li	s1,4
    558c:	00000913          	li	s2,0
    5590:	00100b93          	li	s7,1
    5594:	e21ff06f          	j	53b4 <__divdf3+0x70>
    5598:	0014e493          	ori	s1,s1,1
    559c:	00000413          	li	s0,0
    55a0:	00100693          	li	a3,1
    55a4:	e55ff06f          	j	53f8 <__divdf3+0xb4>
    55a8:	0034e493          	ori	s1,s1,3
    55ac:	00060813          	mv	a6,a2
    55b0:	00300693          	li	a3,3
    55b4:	e45ff06f          	j	53f8 <__divdf3+0xb4>
    55b8:	3c070063          	beqz	a4,5978 <__divdf3+0x634>
    55bc:	00100793          	li	a5,1
    55c0:	40e787b3          	sub	a5,a5,a4
    55c4:	03800693          	li	a3,56
    55c8:	42f6d063          	bge	a3,a5,59e8 <__divdf3+0x6a4>
    55cc:	00000713          	li	a4,0
    55d0:	00000793          	li	a5,0
    55d4:	00000413          	li	s0,0
    55d8:	e71ff06f          	j	5448 <__divdf3+0x104>
    55dc:	000a0593          	mv	a1,s4
    55e0:	00200793          	li	a5,2
    55e4:	e4f68ce3          	beq	a3,a5,543c <__divdf3+0xf8>
    55e8:	00300793          	li	a5,3
    55ec:	eaf684e3          	beq	a3,a5,5494 <__divdf3+0x150>
    55f0:	00100793          	li	a5,1
    55f4:	fcf68ce3          	beq	a3,a5,55cc <__divdf3+0x288>
    55f8:	3ff90713          	addi	a4,s2,1023
    55fc:	fae05ee3          	blez	a4,55b8 <__divdf3+0x274>
    5600:	00787793          	andi	a5,a6,7
    5604:	32079c63          	bnez	a5,593c <__divdf3+0x5f8>
    5608:	00385813          	srli	a6,a6,0x3
    560c:	00741793          	slli	a5,s0,0x7
    5610:	0007da63          	bgez	a5,5624 <__divdf3+0x2e0>
    5614:	ff0007b7          	lui	a5,0xff000
    5618:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf9b5f>
    561c:	00f47433          	and	s0,s0,a5
    5620:	40090713          	addi	a4,s2,1024
    5624:	7fe00793          	li	a5,2046
    5628:	e0e7cae3          	blt	a5,a4,543c <__divdf3+0xf8>
    562c:	00941793          	slli	a5,s0,0x9
    5630:	01d41693          	slli	a3,s0,0x1d
    5634:	0106e433          	or	s0,a3,a6
    5638:	00c7d793          	srli	a5,a5,0xc
    563c:	7ff77713          	andi	a4,a4,2047
    5640:	e09ff06f          	j	5448 <__divdf3+0x104>
    5644:	00098593          	mv	a1,s3
    5648:	000a8413          	mv	s0,s5
    564c:	000b0813          	mv	a6,s6
    5650:	000b8693          	mv	a3,s7
    5654:	f8dff06f          	j	55e0 <__divdf3+0x29c>
    5658:	2b546863          	bltu	s0,s5,5908 <__divdf3+0x5c4>
    565c:	2a8a8463          	beq	s5,s0,5904 <__divdf3+0x5c0>
    5660:	000b0713          	mv	a4,s6
    5664:	fff90913          	addi	s2,s2,-1
    5668:	00000b13          	li	s6,0
    566c:	00841793          	slli	a5,s0,0x8
    5670:	01885893          	srli	a7,a6,0x18
    5674:	00f8e8b3          	or	a7,a7,a5
    5678:	0108de13          	srli	t3,a7,0x10
    567c:	03cad7b3          	divu	a5,s5,t3
    5680:	01089e93          	slli	t4,a7,0x10
    5684:	010ede93          	srli	t4,t4,0x10
    5688:	01075613          	srli	a2,a4,0x10
    568c:	00881313          	slli	t1,a6,0x8
    5690:	03cafab3          	remu	s5,s5,t3
    5694:	02fe86b3          	mul	a3,t4,a5
    5698:	010a9a93          	slli	s5,s5,0x10
    569c:	01566633          	or	a2,a2,s5
    56a0:	00d67e63          	bgeu	a2,a3,56bc <__divdf3+0x378>
    56a4:	01160633          	add	a2,a2,a7
    56a8:	fff78513          	addi	a0,a5,-1
    56ac:	33166a63          	bltu	a2,a7,59e0 <__divdf3+0x69c>
    56b0:	32d67863          	bgeu	a2,a3,59e0 <__divdf3+0x69c>
    56b4:	ffe78793          	addi	a5,a5,-2
    56b8:	01160633          	add	a2,a2,a7
    56bc:	40d60633          	sub	a2,a2,a3
    56c0:	03c65433          	divu	s0,a2,t3
    56c4:	01071713          	slli	a4,a4,0x10
    56c8:	01075713          	srli	a4,a4,0x10
    56cc:	03c67633          	remu	a2,a2,t3
    56d0:	028e86b3          	mul	a3,t4,s0
    56d4:	01061613          	slli	a2,a2,0x10
    56d8:	00c76633          	or	a2,a4,a2
    56dc:	00d67e63          	bgeu	a2,a3,56f8 <__divdf3+0x3b4>
    56e0:	01160633          	add	a2,a2,a7
    56e4:	fff40713          	addi	a4,s0,-1 # 7fffff <__freertos_irq_stack_top+0x5f9b5f>
    56e8:	2f166863          	bltu	a2,a7,59d8 <__divdf3+0x694>
    56ec:	2ed67663          	bgeu	a2,a3,59d8 <__divdf3+0x694>
    56f0:	ffe40413          	addi	s0,s0,-2
    56f4:	01160633          	add	a2,a2,a7
    56f8:	01079793          	slli	a5,a5,0x10
    56fc:	000103b7          	lui	t2,0x10
    5700:	0087e433          	or	s0,a5,s0
    5704:	fff38793          	addi	a5,t2,-1 # ffff <__global_pointer$+0x93b7>
    5708:	00f47833          	and	a6,s0,a5
    570c:	01045f13          	srli	t5,s0,0x10
    5710:	01035513          	srli	a0,t1,0x10
    5714:	00f377b3          	and	a5,t1,a5
    5718:	02f80fb3          	mul	t6,a6,a5
    571c:	40d60733          	sub	a4,a2,a3
    5720:	02ff02b3          	mul	t0,t5,a5
    5724:	010fd613          	srli	a2,t6,0x10
    5728:	030506b3          	mul	a3,a0,a6
    572c:	005686b3          	add	a3,a3,t0
    5730:	00d606b3          	add	a3,a2,a3
    5734:	02af0833          	mul	a6,t5,a0
    5738:	0056f463          	bgeu	a3,t0,5740 <__divdf3+0x3fc>
    573c:	00780833          	add	a6,a6,t2
    5740:	00010f37          	lui	t5,0x10
    5744:	ffff0f13          	addi	t5,t5,-1 # ffff <__global_pointer$+0x93b7>
    5748:	0106d613          	srli	a2,a3,0x10
    574c:	01e6f6b3          	and	a3,a3,t5
    5750:	01069693          	slli	a3,a3,0x10
    5754:	01efff33          	and	t5,t6,t5
    5758:	01060633          	add	a2,a2,a6
    575c:	01e686b3          	add	a3,a3,t5
    5760:	16c76e63          	bltu	a4,a2,58dc <__divdf3+0x598>
    5764:	16c70a63          	beq	a4,a2,58d8 <__divdf3+0x594>
    5768:	40db06b3          	sub	a3,s6,a3
    576c:	40c70733          	sub	a4,a4,a2
    5770:	00db3b33          	sltu	s6,s6,a3
    5774:	41670b33          	sub	s6,a4,s6
    5778:	3ff90713          	addi	a4,s2,1023
    577c:	1f688263          	beq	a7,s6,5960 <__divdf3+0x61c>
    5780:	03cb5833          	divu	a6,s6,t3
    5784:	0106d613          	srli	a2,a3,0x10
    5788:	03cb7b33          	remu	s6,s6,t3
    578c:	030e8f33          	mul	t5,t4,a6
    5790:	010b1b13          	slli	s6,s6,0x10
    5794:	01666b33          	or	s6,a2,s6
    5798:	01eb7e63          	bgeu	s6,t5,57b4 <__divdf3+0x470>
    579c:	011b0b33          	add	s6,s6,a7
    57a0:	fff80613          	addi	a2,a6,-1
    57a4:	2d1b6863          	bltu	s6,a7,5a74 <__divdf3+0x730>
    57a8:	2deb7663          	bgeu	s6,t5,5a74 <__divdf3+0x730>
    57ac:	ffe80813          	addi	a6,a6,-2
    57b0:	011b0b33          	add	s6,s6,a7
    57b4:	41eb0b33          	sub	s6,s6,t5
    57b8:	03cb5633          	divu	a2,s6,t3
    57bc:	01069693          	slli	a3,a3,0x10
    57c0:	0106d693          	srli	a3,a3,0x10
    57c4:	03cb7b33          	remu	s6,s6,t3
    57c8:	02ce8eb3          	mul	t4,t4,a2
    57cc:	010b1b13          	slli	s6,s6,0x10
    57d0:	0166e6b3          	or	a3,a3,s6
    57d4:	01d6fe63          	bgeu	a3,t4,57f0 <__divdf3+0x4ac>
    57d8:	011686b3          	add	a3,a3,a7
    57dc:	fff60e13          	addi	t3,a2,-1
    57e0:	2916e663          	bltu	a3,a7,5a6c <__divdf3+0x728>
    57e4:	29d6f463          	bgeu	a3,t4,5a6c <__divdf3+0x728>
    57e8:	ffe60613          	addi	a2,a2,-2
    57ec:	011686b3          	add	a3,a3,a7
    57f0:	01081813          	slli	a6,a6,0x10
    57f4:	00c86833          	or	a6,a6,a2
    57f8:	01081e13          	slli	t3,a6,0x10
    57fc:	01085f93          	srli	t6,a6,0x10
    5800:	010e5e13          	srli	t3,t3,0x10
    5804:	02fe0f33          	mul	t5,t3,a5
    5808:	41d686b3          	sub	a3,a3,t4
    580c:	03c50e33          	mul	t3,a0,t3
    5810:	010f5613          	srli	a2,t5,0x10
    5814:	02ff87b3          	mul	a5,t6,a5
    5818:	00fe0e33          	add	t3,t3,a5
    581c:	01c60633          	add	a2,a2,t3
    5820:	03f50533          	mul	a0,a0,t6
    5824:	00f67663          	bgeu	a2,a5,5830 <__divdf3+0x4ec>
    5828:	000107b7          	lui	a5,0x10
    582c:	00f50533          	add	a0,a0,a5
    5830:	00010e37          	lui	t3,0x10
    5834:	fffe0e13          	addi	t3,t3,-1 # ffff <__global_pointer$+0x93b7>
    5838:	01065793          	srli	a5,a2,0x10
    583c:	01c67633          	and	a2,a2,t3
    5840:	01061613          	slli	a2,a2,0x10
    5844:	01cf7f33          	and	t5,t5,t3
    5848:	00a78533          	add	a0,a5,a0
    584c:	01e60633          	add	a2,a2,t5
    5850:	0ca6f863          	bgeu	a3,a0,5920 <__divdf3+0x5dc>
    5854:	00d886b3          	add	a3,a7,a3
    5858:	fff80793          	addi	a5,a6,-1
    585c:	2516e463          	bltu	a3,a7,5aa4 <__divdf3+0x760>
    5860:	20a6ee63          	bltu	a3,a0,5a7c <__divdf3+0x738>
    5864:	24a68663          	beq	a3,a0,5ab0 <__divdf3+0x76c>
    5868:	00078813          	mv	a6,a5
    586c:	00186813          	ori	a6,a6,1
    5870:	d8dff06f          	j	55fc <__divdf3+0x2b8>
    5874:	00048513          	mv	a0,s1
    5878:	8a5fd0ef          	jal	ra,311c <__clzsi2>
    587c:	01550713          	addi	a4,a0,21
    5880:	01c00593          	li	a1,28
    5884:	02050913          	addi	s2,a0,32
    5888:	00812603          	lw	a2,8(sp)
    588c:	00c12683          	lw	a3,12(sp)
    5890:	c8e5d8e3          	bge	a1,a4,5520 <__divdf3+0x1dc>
    5894:	ff850413          	addi	s0,a0,-8
    5898:	00849ab3          	sll	s5,s1,s0
    589c:	00000b13          	li	s6,0
    58a0:	c9dff06f          	j	553c <__divdf3+0x1f8>
    58a4:	00060513          	mv	a0,a2
    58a8:	00c12423          	sw	a2,8(sp)
    58ac:	871fd0ef          	jal	ra,311c <__clzsi2>
    58b0:	01550593          	addi	a1,a0,21
    58b4:	01c00713          	li	a4,28
    58b8:	00050793          	mv	a5,a0
    58bc:	00812603          	lw	a2,8(sp)
    58c0:	02050513          	addi	a0,a0,32
    58c4:	c0b752e3          	bge	a4,a1,54c8 <__divdf3+0x184>
    58c8:	ff878793          	addi	a5,a5,-8 # fff8 <__global_pointer$+0x93b0>
    58cc:	00000813          	li	a6,0
    58d0:	00f61433          	sll	s0,a2,a5
    58d4:	c11ff06f          	j	54e4 <__divdf3+0x1a0>
    58d8:	e8db78e3          	bgeu	s6,a3,5768 <__divdf3+0x424>
    58dc:	006b0b33          	add	s6,s6,t1
    58e0:	006b3833          	sltu	a6,s6,t1
    58e4:	01180833          	add	a6,a6,a7
    58e8:	01070733          	add	a4,a4,a6
    58ec:	fff40813          	addi	a6,s0,-1
    58f0:	02e8fe63          	bgeu	a7,a4,592c <__divdf3+0x5e8>
    58f4:	16c76063          	bltu	a4,a2,5a54 <__divdf3+0x710>
    58f8:	14e60c63          	beq	a2,a4,5a50 <__divdf3+0x70c>
    58fc:	00080413          	mv	s0,a6
    5900:	e69ff06f          	j	5768 <__divdf3+0x424>
    5904:	d50b6ee3          	bltu	s6,a6,5660 <__divdf3+0x31c>
    5908:	01fa9713          	slli	a4,s5,0x1f
    590c:	001b5613          	srli	a2,s6,0x1
    5910:	001ada93          	srli	s5,s5,0x1
    5914:	00c76733          	or	a4,a4,a2
    5918:	01fb1b13          	slli	s6,s6,0x1f
    591c:	d51ff06f          	j	566c <__divdf3+0x328>
    5920:	f4a696e3          	bne	a3,a0,586c <__divdf3+0x528>
    5924:	cc060ce3          	beqz	a2,55fc <__divdf3+0x2b8>
    5928:	f2dff06f          	j	5854 <__divdf3+0x510>
    592c:	fce898e3          	bne	a7,a4,58fc <__divdf3+0x5b8>
    5930:	fc6b72e3          	bgeu	s6,t1,58f4 <__divdf3+0x5b0>
    5934:	00080413          	mv	s0,a6
    5938:	e31ff06f          	j	5768 <__divdf3+0x424>
    593c:	00f87793          	andi	a5,a6,15
    5940:	00400693          	li	a3,4
    5944:	ccd782e3          	beq	a5,a3,5608 <__divdf3+0x2c4>
    5948:	ffc83793          	sltiu	a5,a6,-4
    594c:	00480813          	addi	a6,a6,4
    5950:	0017c793          	xori	a5,a5,1
    5954:	00385813          	srli	a6,a6,0x3
    5958:	00f40433          	add	s0,s0,a5
    595c:	cb1ff06f          	j	560c <__divdf3+0x2c8>
    5960:	00000813          	li	a6,0
    5964:	00100793          	li	a5,1
    5968:	fee048e3          	bgtz	a4,5958 <__divdf3+0x614>
    596c:	fff00813          	li	a6,-1
    5970:	c40716e3          	bnez	a4,55bc <__divdf3+0x278>
    5974:	c0100913          	li	s2,-1023
    5978:	00100793          	li	a5,1
    597c:	41e90513          	addi	a0,s2,1054
    5980:	00a41733          	sll	a4,s0,a0
    5984:	00f856b3          	srl	a3,a6,a5
    5988:	00a81533          	sll	a0,a6,a0
    598c:	00d76733          	or	a4,a4,a3
    5990:	00a03533          	snez	a0,a0
    5994:	00a76733          	or	a4,a4,a0
    5998:	00777693          	andi	a3,a4,7
    599c:	00f45433          	srl	s0,s0,a5
    59a0:	02068063          	beqz	a3,59c0 <__divdf3+0x67c>
    59a4:	00f77793          	andi	a5,a4,15
    59a8:	00400693          	li	a3,4
    59ac:	00d78a63          	beq	a5,a3,59c0 <__divdf3+0x67c>
    59b0:	00470793          	addi	a5,a4,4
    59b4:	00e7b733          	sltu	a4,a5,a4
    59b8:	00e40433          	add	s0,s0,a4
    59bc:	00078713          	mv	a4,a5
    59c0:	00841793          	slli	a5,s0,0x8
    59c4:	0607d863          	bgez	a5,5a34 <__divdf3+0x6f0>
    59c8:	00100713          	li	a4,1
    59cc:	00000793          	li	a5,0
    59d0:	00000413          	li	s0,0
    59d4:	a75ff06f          	j	5448 <__divdf3+0x104>
    59d8:	00070413          	mv	s0,a4
    59dc:	d1dff06f          	j	56f8 <__divdf3+0x3b4>
    59e0:	00050793          	mv	a5,a0
    59e4:	cd9ff06f          	j	56bc <__divdf3+0x378>
    59e8:	01f00693          	li	a3,31
    59ec:	f8f6d8e3          	bge	a3,a5,597c <__divdf3+0x638>
    59f0:	fe100693          	li	a3,-31
    59f4:	40e68733          	sub	a4,a3,a4
    59f8:	02000613          	li	a2,32
    59fc:	00e456b3          	srl	a3,s0,a4
    5a00:	00c78863          	beq	a5,a2,5a10 <__divdf3+0x6cc>
    5a04:	43e90793          	addi	a5,s2,1086
    5a08:	00f417b3          	sll	a5,s0,a5
    5a0c:	00f86833          	or	a6,a6,a5
    5a10:	01003733          	snez	a4,a6
    5a14:	00d76733          	or	a4,a4,a3
    5a18:	00777413          	andi	s0,a4,7
    5a1c:	00000793          	li	a5,0
    5a20:	02040063          	beqz	s0,5a40 <__divdf3+0x6fc>
    5a24:	00f77793          	andi	a5,a4,15
    5a28:	00400693          	li	a3,4
    5a2c:	00000413          	li	s0,0
    5a30:	f8d790e3          	bne	a5,a3,59b0 <__divdf3+0x66c>
    5a34:	00941793          	slli	a5,s0,0x9
    5a38:	00c7d793          	srli	a5,a5,0xc
    5a3c:	01d41413          	slli	s0,s0,0x1d
    5a40:	00375713          	srli	a4,a4,0x3
    5a44:	00876433          	or	s0,a4,s0
    5a48:	00000713          	li	a4,0
    5a4c:	9fdff06f          	j	5448 <__divdf3+0x104>
    5a50:	eadb76e3          	bgeu	s6,a3,58fc <__divdf3+0x5b8>
    5a54:	006b0b33          	add	s6,s6,t1
    5a58:	006b3833          	sltu	a6,s6,t1
    5a5c:	01180833          	add	a6,a6,a7
    5a60:	ffe40413          	addi	s0,s0,-2
    5a64:	01070733          	add	a4,a4,a6
    5a68:	d01ff06f          	j	5768 <__divdf3+0x424>
    5a6c:	000e0613          	mv	a2,t3
    5a70:	d81ff06f          	j	57f0 <__divdf3+0x4ac>
    5a74:	00060813          	mv	a6,a2
    5a78:	d3dff06f          	j	57b4 <__divdf3+0x470>
    5a7c:	00131793          	slli	a5,t1,0x1
    5a80:	0067b333          	sltu	t1,a5,t1
    5a84:	011308b3          	add	a7,t1,a7
    5a88:	011686b3          	add	a3,a3,a7
    5a8c:	ffe80813          	addi	a6,a6,-2
    5a90:	00078313          	mv	t1,a5
    5a94:	dca69ce3          	bne	a3,a0,586c <__divdf3+0x528>
    5a98:	b6c302e3          	beq	t1,a2,55fc <__divdf3+0x2b8>
    5a9c:	00186813          	ori	a6,a6,1
    5aa0:	b5dff06f          	j	55fc <__divdf3+0x2b8>
    5aa4:	00078813          	mv	a6,a5
    5aa8:	fea688e3          	beq	a3,a0,5a98 <__divdf3+0x754>
    5aac:	dc1ff06f          	j	586c <__divdf3+0x528>
    5ab0:	fcc366e3          	bltu	t1,a2,5a7c <__divdf3+0x738>
    5ab4:	00078813          	mv	a6,a5
    5ab8:	fec312e3          	bne	t1,a2,5a9c <__divdf3+0x758>
    5abc:	b41ff06f          	j	55fc <__divdf3+0x2b8>

00005ac0 <__eqdf2>:
    5ac0:	0145d713          	srli	a4,a1,0x14
    5ac4:	001007b7          	lui	a5,0x100
    5ac8:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf93b7>
    5acc:	0146d813          	srli	a6,a3,0x14
    5ad0:	7ff77713          	andi	a4,a4,2047
    5ad4:	7ff00893          	li	a7,2047
    5ad8:	00b7fe33          	and	t3,a5,a1
    5adc:	00050e93          	mv	t4,a0
    5ae0:	00d7f7b3          	and	a5,a5,a3
    5ae4:	01f5d593          	srli	a1,a1,0x1f
    5ae8:	00060f13          	mv	t5,a2
    5aec:	7ff87813          	andi	a6,a6,2047
    5af0:	01f6d693          	srli	a3,a3,0x1f
    5af4:	01170e63          	beq	a4,a7,5b10 <__eqdf2+0x50>
    5af8:	00100313          	li	t1,1
    5afc:	01180663          	beq	a6,a7,5b08 <__eqdf2+0x48>
    5b00:	01071463          	bne	a4,a6,5b08 <__eqdf2+0x48>
    5b04:	02fe0263          	beq	t3,a5,5b28 <__eqdf2+0x68>
    5b08:	00030513          	mv	a0,t1
    5b0c:	00008067          	ret
    5b10:	00ae68b3          	or	a7,t3,a0
    5b14:	00100313          	li	t1,1
    5b18:	fe0898e3          	bnez	a7,5b08 <__eqdf2+0x48>
    5b1c:	fee816e3          	bne	a6,a4,5b08 <__eqdf2+0x48>
    5b20:	00c7e7b3          	or	a5,a5,a2
    5b24:	fe0792e3          	bnez	a5,5b08 <__eqdf2+0x48>
    5b28:	00100313          	li	t1,1
    5b2c:	fdee9ee3          	bne	t4,t5,5b08 <__eqdf2+0x48>
    5b30:	00000313          	li	t1,0
    5b34:	fcd58ae3          	beq	a1,a3,5b08 <__eqdf2+0x48>
    5b38:	00100313          	li	t1,1
    5b3c:	fc0716e3          	bnez	a4,5b08 <__eqdf2+0x48>
    5b40:	00ae6533          	or	a0,t3,a0
    5b44:	00a03333          	snez	t1,a0
    5b48:	fc1ff06f          	j	5b08 <__eqdf2+0x48>

00005b4c <__gedf2>:
    5b4c:	0145d713          	srli	a4,a1,0x14
    5b50:	001007b7          	lui	a5,0x100
    5b54:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf93b7>
    5b58:	0146d813          	srli	a6,a3,0x14
    5b5c:	7ff77713          	andi	a4,a4,2047
    5b60:	7ff00893          	li	a7,2047
    5b64:	00b7f333          	and	t1,a5,a1
    5b68:	00050e13          	mv	t3,a0
    5b6c:	00d7f7b3          	and	a5,a5,a3
    5b70:	01f5d593          	srli	a1,a1,0x1f
    5b74:	00060e93          	mv	t4,a2
    5b78:	7ff87813          	andi	a6,a6,2047
    5b7c:	01f6d693          	srli	a3,a3,0x1f
    5b80:	05170263          	beq	a4,a7,5bc4 <__gedf2+0x78>
    5b84:	03180863          	beq	a6,a7,5bb4 <__gedf2+0x68>
    5b88:	04071463          	bnez	a4,5bd0 <__gedf2+0x84>
    5b8c:	00a36533          	or	a0,t1,a0
    5b90:	00081663          	bnez	a6,5b9c <__gedf2+0x50>
    5b94:	00c7e633          	or	a2,a5,a2
    5b98:	06060263          	beqz	a2,5bfc <__gedf2+0xb0>
    5b9c:	04050a63          	beqz	a0,5bf0 <__gedf2+0xa4>
    5ba0:	06d58c63          	beq	a1,a3,5c18 <__gedf2+0xcc>
    5ba4:	00100693          	li	a3,1
    5ba8:	04059663          	bnez	a1,5bf4 <__gedf2+0xa8>
    5bac:	00068513          	mv	a0,a3
    5bb0:	00008067          	ret
    5bb4:	00c7e8b3          	or	a7,a5,a2
    5bb8:	fc0888e3          	beqz	a7,5b88 <__gedf2+0x3c>
    5bbc:	ffe00693          	li	a3,-2
    5bc0:	fedff06f          	j	5bac <__gedf2+0x60>
    5bc4:	00a36533          	or	a0,t1,a0
    5bc8:	fe051ae3          	bnez	a0,5bbc <__gedf2+0x70>
    5bcc:	02e80e63          	beq	a6,a4,5c08 <__gedf2+0xbc>
    5bd0:	00081663          	bnez	a6,5bdc <__gedf2+0x90>
    5bd4:	00c7e633          	or	a2,a5,a2
    5bd8:	fc0606e3          	beqz	a2,5ba4 <__gedf2+0x58>
    5bdc:	fcd594e3          	bne	a1,a3,5ba4 <__gedf2+0x58>
    5be0:	02e85c63          	bge	a6,a4,5c18 <__gedf2+0xcc>
    5be4:	00069863          	bnez	a3,5bf4 <__gedf2+0xa8>
    5be8:	00100693          	li	a3,1
    5bec:	fc1ff06f          	j	5bac <__gedf2+0x60>
    5bf0:	fa069ee3          	bnez	a3,5bac <__gedf2+0x60>
    5bf4:	fff00693          	li	a3,-1
    5bf8:	fb5ff06f          	j	5bac <__gedf2+0x60>
    5bfc:	00000693          	li	a3,0
    5c00:	fa0506e3          	beqz	a0,5bac <__gedf2+0x60>
    5c04:	fa1ff06f          	j	5ba4 <__gedf2+0x58>
    5c08:	00c7e633          	or	a2,a5,a2
    5c0c:	fc0608e3          	beqz	a2,5bdc <__gedf2+0x90>
    5c10:	ffe00693          	li	a3,-2
    5c14:	f99ff06f          	j	5bac <__gedf2+0x60>
    5c18:	01074a63          	blt	a4,a6,5c2c <__gedf2+0xe0>
    5c1c:	f867e4e3          	bltu	a5,t1,5ba4 <__gedf2+0x58>
    5c20:	00f30c63          	beq	t1,a5,5c38 <__gedf2+0xec>
    5c24:	00000693          	li	a3,0
    5c28:	f8f372e3          	bgeu	t1,a5,5bac <__gedf2+0x60>
    5c2c:	fc0584e3          	beqz	a1,5bf4 <__gedf2+0xa8>
    5c30:	00058693          	mv	a3,a1
    5c34:	f79ff06f          	j	5bac <__gedf2+0x60>
    5c38:	f7cee6e3          	bltu	t4,t3,5ba4 <__gedf2+0x58>
    5c3c:	00000693          	li	a3,0
    5c40:	f7de76e3          	bgeu	t3,t4,5bac <__gedf2+0x60>
    5c44:	fe9ff06f          	j	5c2c <__gedf2+0xe0>

00005c48 <__unorddf2>:
    5c48:	0145d713          	srli	a4,a1,0x14
    5c4c:	001007b7          	lui	a5,0x100
    5c50:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xf93b7>
    5c54:	fff74713          	not	a4,a4
    5c58:	0146d813          	srli	a6,a3,0x14
    5c5c:	00b7f5b3          	and	a1,a5,a1
    5c60:	00d7f7b3          	and	a5,a5,a3
    5c64:	01571693          	slli	a3,a4,0x15
    5c68:	7ff87813          	andi	a6,a6,2047
    5c6c:	02068063          	beqz	a3,5c8c <__unorddf2+0x44>
    5c70:	7ff00713          	li	a4,2047
    5c74:	00000513          	li	a0,0
    5c78:	00e80463          	beq	a6,a4,5c80 <__unorddf2+0x38>
    5c7c:	00008067          	ret
    5c80:	00c7e7b3          	or	a5,a5,a2
    5c84:	00f03533          	snez	a0,a5
    5c88:	00008067          	ret
    5c8c:	00a5e5b3          	or	a1,a1,a0
    5c90:	00100513          	li	a0,1
    5c94:	fc058ee3          	beqz	a1,5c70 <__unorddf2+0x28>
    5c98:	00008067          	ret

00005c9c <__errno>:
    5c9c:	81418793          	addi	a5,gp,-2028 # 645c <_impure_ptr>
    5ca0:	0007a503          	lw	a0,0(a5)
    5ca4:	00008067          	ret
