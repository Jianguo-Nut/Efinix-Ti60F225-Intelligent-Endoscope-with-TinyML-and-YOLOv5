
build/gpioDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

01000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
 1000000:	00001197          	auipc	gp,0x1
 1000004:	09018193          	addi	gp,gp,144 # 1001090 <__global_pointer$>
.global smp_lottery_target
.global smp_lottery_lock
.global smp_slave


  sw x0, smp_lottery_lock, a1
 1000008:	8201a023          	sw	zero,-2016(gp) # 10008b0 <smp_lottery_lock>

0100000c <smp_tyranny>:

smp_tyranny:
  csrr a0, mhartid
 100000c:	f1402573          	csrr	a0,mhartid
  beqz a0, init
 1000010:	02050e63          	beqz	a0,100004c <init>

01000014 <smp_slave>:

smp_slave:
	lw a0, smp_lottery_lock
 1000014:	8201a503          	lw	a0,-2016(gp) # 10008b0 <smp_lottery_lock>
	beqz a0, smp_slave
 1000018:	fe050ee3          	beqz	a0,1000014 <smp_slave>

	fence r, r
 100001c:	0220000f          	fence	r,r
 1000020:	0000100f          	fence.i
	//li a1, -1
	//amoadd.w x0, a1,(a0)

	.word(0x100F) //i$ flush
	lw a5, smp_lottery_target
 1000024:	81c1a783          	lw	a5,-2020(gp) # 10008ac <__bss_start>
	li a0, 0
 1000028:	00000513          	li	a0,0
	li a1, 0
 100002c:	00000593          	li	a1,0
	li a2, 0
 1000030:	00000613          	li	a2,0
	jr a5
 1000034:	00078067          	jr	a5

01000038 <smp_unlock>:

.global   smp_unlock
.type    smp_unlock,%function
smp_unlock:
	sw a0, smp_lottery_target, a1
 1000038:	80a1ae23          	sw	a0,-2020(gp) # 10008ac <__bss_start>
	fence w, w
 100003c:	0110000f          	fence	w,w
	li a0, 1
 1000040:	00100513          	li	a0,1
	sw a0, smp_lottery_lock, a1
 1000044:	82a1a023          	sw	a0,-2016(gp) # 10008b0 <smp_lottery_lock>
    ret
 1000048:	00008067          	ret

0100004c <init>:
#endif

init:
	la sp, _sp
 100004c:	03018113          	addi	sp,gp,48 # 10010c0 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
 1000050:	00000517          	auipc	a0,0x0
 1000054:	7a050513          	addi	a0,a0,1952 # 10007f0 <_data>
	la a1, _data
 1000058:	00000597          	auipc	a1,0x0
 100005c:	79858593          	addi	a1,a1,1944 # 10007f0 <_data>
	la a2, _edata
 1000060:	81c18613          	addi	a2,gp,-2020 # 10008ac <__bss_start>
	bgeu a1, a2, 2f
 1000064:	00c5fc63          	bgeu	a1,a2,100007c <init+0x30>
1:
	lw t0, (a0)
 1000068:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
 100006c:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
 1000070:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
 1000074:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
 1000078:	fec5e8e3          	bltu	a1,a2,1000068 <init+0x1c>
2:

	/* Clear bss section */
	la a0, __bss_start
 100007c:	81c18513          	addi	a0,gp,-2020 # 10008ac <__bss_start>
	la a1, _end
 1000080:	82818593          	addi	a1,gp,-2008 # 10008b8 <_end>
	bgeu a0, a1, 2f
 1000084:	00b57863          	bgeu	a0,a1,1000094 <init+0x48>
1:
	sw zero, (a0)
 1000088:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
 100008c:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
 1000090:	feb56ce3          	bltu	a0,a1,1000088 <init+0x3c>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
 1000094:	010000ef          	jal	ra,10000a4 <__libc_init_array>
#endif

	call main
 1000098:	4f0000ef          	jal	ra,1000588 <main>

0100009c <mainDone>:
mainDone:
    j mainDone
 100009c:	0000006f          	j	100009c <mainDone>

010000a0 <_init>:


	.globl _init
_init:
    ret
 10000a0:	00008067          	ret

Disassembly of section .text:

010000a4 <__libc_init_array>:
 10000a4:	ff010113          	addi	sp,sp,-16
 10000a8:	00812423          	sw	s0,8(sp)
 10000ac:	01212023          	sw	s2,0(sp)
 10000b0:	00000417          	auipc	s0,0x0
 10000b4:	74040413          	addi	s0,s0,1856 # 10007f0 <_data>
 10000b8:	00000917          	auipc	s2,0x0
 10000bc:	73890913          	addi	s2,s2,1848 # 10007f0 <_data>
 10000c0:	40890933          	sub	s2,s2,s0
 10000c4:	00112623          	sw	ra,12(sp)
 10000c8:	00912223          	sw	s1,4(sp)
 10000cc:	40295913          	srai	s2,s2,0x2
 10000d0:	00090e63          	beqz	s2,10000ec <__libc_init_array+0x48>
 10000d4:	00000493          	li	s1,0
 10000d8:	00042783          	lw	a5,0(s0)
 10000dc:	00148493          	addi	s1,s1,1
 10000e0:	00440413          	addi	s0,s0,4
 10000e4:	000780e7          	jalr	a5
 10000e8:	fe9918e3          	bne	s2,s1,10000d8 <__libc_init_array+0x34>
 10000ec:	00000417          	auipc	s0,0x0
 10000f0:	70440413          	addi	s0,s0,1796 # 10007f0 <_data>
 10000f4:	00000917          	auipc	s2,0x0
 10000f8:	6fc90913          	addi	s2,s2,1788 # 10007f0 <_data>
 10000fc:	40890933          	sub	s2,s2,s0
 1000100:	40295913          	srai	s2,s2,0x2
 1000104:	00090e63          	beqz	s2,1000120 <__libc_init_array+0x7c>
 1000108:	00000493          	li	s1,0
 100010c:	00042783          	lw	a5,0(s0)
 1000110:	00148493          	addi	s1,s1,1
 1000114:	00440413          	addi	s0,s0,4
 1000118:	000780e7          	jalr	a5
 100011c:	fe9918e3          	bne	s2,s1,100010c <__libc_init_array+0x68>
 1000120:	00c12083          	lw	ra,12(sp)
 1000124:	00812403          	lw	s0,8(sp)
 1000128:	00412483          	lw	s1,4(sp)
 100012c:	00012903          	lw	s2,0(sp)
 1000130:	01010113          	addi	sp,sp,16
 1000134:	00008067          	ret

01000138 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
 1000138:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
 100013c:	01055513          	srli	a0,a0,0x10
    }
 1000140:	0ff57513          	andi	a0,a0,255
 1000144:	00008067          	ret

01000148 <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
 1000148:	ff010113          	addi	sp,sp,-16
 100014c:	00112623          	sw	ra,12(sp)
 1000150:	00812423          	sw	s0,8(sp)
 1000154:	00912223          	sw	s1,4(sp)
 1000158:	00050413          	mv	s0,a0
 100015c:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
 1000160:	00040513          	mv	a0,s0
 1000164:	fd5ff0ef          	jal	ra,1000138 <uart_writeAvailability>
 1000168:	fe050ce3          	beqz	a0,1000160 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
 100016c:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
 1000170:	00c12083          	lw	ra,12(sp)
 1000174:	00812403          	lw	s0,8(sp)
 1000178:	00412483          	lw	s1,4(sp)
 100017c:	01010113          	addi	sp,sp,16
 1000180:	00008067          	ret

01000184 <uart_applyConfig>:
*          value using data length, parity, and stop bit settings from the configuration
*          structure, and writes this value to the UART frame configuration register.
*
******************************************************************************/
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
 1000184:	00c5a783          	lw	a5,12(a1)
 1000188:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
 100018c:	0005a783          	lw	a5,0(a1)
 1000190:	fff78793          	addi	a5,a5,-1
 1000194:	0045a703          	lw	a4,4(a1)
 1000198:	00871713          	slli	a4,a4,0x8
 100019c:	00e7e7b3          	or	a5,a5,a4
 10001a0:	0085a703          	lw	a4,8(a1)
 10001a4:	01071713          	slli	a4,a4,0x10
 10001a8:	00e7e7b3          	or	a5,a5,a4
 10001ac:	00f52623          	sw	a5,12(a0)
    }
 10001b0:	00008067          	ret

010001b4 <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
 10001b4:	000f47b7          	lui	a5,0xf4
 10001b8:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf3a40>
 10001bc:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
 10001c0:	0000c7b7          	lui	a5,0xc
 10001c4:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xb7f8>
 10001c8:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
 10001cc:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
 10001d0:	02a58533          	mul	a0,a1,a0
 10001d4:	00f50533          	add	a0,a0,a5
 10001d8:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
 10001dc:	40f507b3          	sub	a5,a0,a5
 10001e0:	fe07dce3          	bgez	a5,10001d8 <clint_uDelay+0x24>
 10001e4:	00008067          	ret

010001e8 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
 10001e8:	ff010113          	addi	sp,sp,-16
 10001ec:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
 10001f0:	00050593          	mv	a1,a0
 10001f4:	f8010537          	lui	a0,0xf8010
 10001f8:	f51ff0ef          	jal	ra,1000148 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
 10001fc:	00c12083          	lw	ra,12(sp)
 1000200:	01010113          	addi	sp,sp,16
 1000204:	00008067          	ret

01000208 <_putchar_s>:

    static void _putchar_s(char *p)
    {
 1000208:	ff010113          	addi	sp,sp,-16
 100020c:	00112623          	sw	ra,12(sp)
 1000210:	00812423          	sw	s0,8(sp)
 1000214:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
 1000218:	00044503          	lbu	a0,0(s0)
 100021c:	00050863          	beqz	a0,100022c <_putchar_s+0x24>
            _putchar(*(p++));
 1000220:	00140413          	addi	s0,s0,1
 1000224:	fc5ff0ef          	jal	ra,10001e8 <_putchar>
 1000228:	ff1ff06f          	j	1000218 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
 100022c:	00c12083          	lw	ra,12(sp)
 1000230:	00812403          	lw	s0,8(sp)
 1000234:	01010113          	addi	sp,sp,16
 1000238:	00008067          	ret

0100023c <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
 100023c:	ff010113          	addi	sp,sp,-16
 1000240:	00112623          	sw	ra,12(sp)
 1000244:	00812423          	sw	s0,8(sp)
 1000248:	00912223          	sw	s1,4(sp)
 100024c:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
 1000250:	01c00413          	li	s0,28
 1000254:	0240006f          	j	1000278 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
 1000258:	0084d7b3          	srl	a5,s1,s0
 100025c:	00f7f713          	andi	a4,a5,15
 1000260:	010007b7          	lui	a5,0x1000
 1000264:	7f078793          	addi	a5,a5,2032 # 10007f0 <_data>
 1000268:	00e787b3          	add	a5,a5,a4
 100026c:	0007c503          	lbu	a0,0(a5)
 1000270:	f79ff0ef          	jal	ra,10001e8 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
 1000274:	ffc40413          	addi	s0,s0,-4
 1000278:	fe0450e3          	bgez	s0,1000258 <bsp_printHex+0x1c>
        }
    }
 100027c:	00c12083          	lw	ra,12(sp)
 1000280:	00812403          	lw	s0,8(sp)
 1000284:	00412483          	lw	s1,4(sp)
 1000288:	01010113          	addi	sp,sp,16
 100028c:	00008067          	ret

01000290 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
 1000290:	ff010113          	addi	sp,sp,-16
 1000294:	00112623          	sw	ra,12(sp)
 1000298:	00812423          	sw	s0,8(sp)
 100029c:	00912223          	sw	s1,4(sp)
 10002a0:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
 10002a4:	01c00413          	li	s0,28
 10002a8:	0240006f          	j	10002cc <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
 10002ac:	0084d7b3          	srl	a5,s1,s0
 10002b0:	00f7f713          	andi	a4,a5,15
 10002b4:	010017b7          	lui	a5,0x1001
 10002b8:	80478793          	addi	a5,a5,-2044 # 1000804 <_data+0x14>
 10002bc:	00e787b3          	add	a5,a5,a4
 10002c0:	0007c503          	lbu	a0,0(a5)
 10002c4:	f25ff0ef          	jal	ra,10001e8 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
 10002c8:	ffc40413          	addi	s0,s0,-4
 10002cc:	fe0450e3          	bgez	s0,10002ac <bsp_printHex_lower+0x1c>

        }
    }
 10002d0:	00c12083          	lw	ra,12(sp)
 10002d4:	00812403          	lw	s0,8(sp)
 10002d8:	00412483          	lw	s1,4(sp)
 10002dc:	01010113          	addi	sp,sp,16
 10002e0:	00008067          	ret

010002e4 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
 10002e4:	ff010113          	addi	sp,sp,-16
 10002e8:	00112623          	sw	ra,12(sp)
        _putchar(c);
 10002ec:	0ff57513          	andi	a0,a0,255
 10002f0:	ef9ff0ef          	jal	ra,10001e8 <_putchar>
    }
 10002f4:	00c12083          	lw	ra,12(sp)
 10002f8:	01010113          	addi	sp,sp,16
 10002fc:	00008067          	ret

01000300 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
 1000300:	ff010113          	addi	sp,sp,-16
 1000304:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
 1000308:	f01ff0ef          	jal	ra,1000208 <_putchar_s>
    }
 100030c:	00c12083          	lw	ra,12(sp)
 1000310:	01010113          	addi	sp,sp,16
 1000314:	00008067          	ret

01000318 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
 1000318:	fd010113          	addi	sp,sp,-48
 100031c:	02112623          	sw	ra,44(sp)
 1000320:	02812423          	sw	s0,40(sp)
 1000324:	02912223          	sw	s1,36(sp)
 1000328:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
 100032c:	00054663          	bltz	a0,1000338 <bsp_printf_d+0x20>
    {
 1000330:	00010413          	mv	s0,sp
 1000334:	02c0006f          	j	1000360 <bsp_printf_d+0x48>
            bsp_printf_c('-');
 1000338:	02d00513          	li	a0,45
 100033c:	fa9ff0ef          	jal	ra,10002e4 <bsp_printf_c>
            val = -val;
 1000340:	409004b3          	neg	s1,s1
 1000344:	fedff06f          	j	1000330 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
 1000348:	00a00713          	li	a4,10
 100034c:	02e4e7b3          	rem	a5,s1,a4
 1000350:	03078793          	addi	a5,a5,48
 1000354:	00f40023          	sb	a5,0(s0)
            val = val / 10;
 1000358:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
 100035c:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
 1000360:	fe0494e3          	bnez	s1,1000348 <bsp_printf_d+0x30>
 1000364:	00010793          	mv	a5,sp
 1000368:	fef400e3          	beq	s0,a5,1000348 <bsp_printf_d+0x30>
 100036c:	0100006f          	j	100037c <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
 1000370:	fff40413          	addi	s0,s0,-1
 1000374:	00044503          	lbu	a0,0(s0)
 1000378:	f6dff0ef          	jal	ra,10002e4 <bsp_printf_c>
        while (p != buffer)
 100037c:	00010793          	mv	a5,sp
 1000380:	fef418e3          	bne	s0,a5,1000370 <bsp_printf_d+0x58>
    }
 1000384:	02c12083          	lw	ra,44(sp)
 1000388:	02812403          	lw	s0,40(sp)
 100038c:	02412483          	lw	s1,36(sp)
 1000390:	03010113          	addi	sp,sp,48
 1000394:	00008067          	ret

01000398 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
 1000398:	ff010113          	addi	sp,sp,-16
 100039c:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
 10003a0:	00000713          	li	a4,0
 10003a4:	00700793          	li	a5,7
 10003a8:	02e7c063          	blt	a5,a4,10003c8 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
 10003ac:	00271693          	slli	a3,a4,0x2
 10003b0:	ff000793          	li	a5,-16
 10003b4:	00d797b3          	sll	a5,a5,a3
 10003b8:	00f577b3          	and	a5,a0,a5
 10003bc:	00078663          	beqz	a5,10003c8 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
 10003c0:	00170713          	addi	a4,a4,1
 10003c4:	fe1ff06f          	j	10003a4 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
 10003c8:	ec9ff0ef          	jal	ra,1000290 <bsp_printHex_lower>
    }
 10003cc:	00c12083          	lw	ra,12(sp)
 10003d0:	01010113          	addi	sp,sp,16
 10003d4:	00008067          	ret

010003d8 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
 10003d8:	ff010113          	addi	sp,sp,-16
 10003dc:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
 10003e0:	00000713          	li	a4,0
 10003e4:	00700793          	li	a5,7
 10003e8:	02e7c063          	blt	a5,a4,1000408 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
 10003ec:	00271693          	slli	a3,a4,0x2
 10003f0:	ff000793          	li	a5,-16
 10003f4:	00d797b3          	sll	a5,a5,a3
 10003f8:	00f577b3          	and	a5,a0,a5
 10003fc:	00078663          	beqz	a5,1000408 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
 1000400:	00170713          	addi	a4,a4,1
 1000404:	fe1ff06f          	j	10003e4 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
 1000408:	e35ff0ef          	jal	ra,100023c <bsp_printHex>
        }
 100040c:	00c12083          	lw	ra,12(sp)
 1000410:	01010113          	addi	sp,sp,16
 1000414:	00008067          	ret

01000418 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
 1000418:	fe010113          	addi	sp,sp,-32
 100041c:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
 1000420:	00800793          	li	a5,8
 1000424:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
 1000428:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
 100042c:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
 1000430:	06b00793          	li	a5,107
 1000434:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
 1000438:	00010593          	mv	a1,sp
 100043c:	f8010537          	lui	a0,0xf8010
 1000440:	d45ff0ef          	jal	ra,1000184 <uart_applyConfig>
    }
 1000444:	01c12083          	lw	ra,28(sp)
 1000448:	02010113          	addi	sp,sp,32
 100044c:	00008067          	ret

01000450 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
 1000450:	fc010113          	addi	sp,sp,-64
 1000454:	00112e23          	sw	ra,28(sp)
 1000458:	00812c23          	sw	s0,24(sp)
 100045c:	00912a23          	sw	s1,20(sp)
 1000460:	00050493          	mv	s1,a0
 1000464:	02b12223          	sw	a1,36(sp)
 1000468:	02c12423          	sw	a2,40(sp)
 100046c:	02d12623          	sw	a3,44(sp)
 1000470:	02e12823          	sw	a4,48(sp)
 1000474:	02f12a23          	sw	a5,52(sp)
 1000478:	03012c23          	sw	a6,56(sp)
 100047c:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
 1000480:	02410793          	addi	a5,sp,36
 1000484:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
 1000488:	00000413          	li	s0,0
 100048c:	01c0006f          	j	10004a8 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
 1000490:	00c12783          	lw	a5,12(sp)
 1000494:	00478713          	addi	a4,a5,4
 1000498:	00e12623          	sw	a4,12(sp)
 100049c:	0007a503          	lw	a0,0(a5)
 10004a0:	e45ff0ef          	jal	ra,10002e4 <bsp_printf_c>
        for (i = 0; format[i]; i++)
 10004a4:	00140413          	addi	s0,s0,1
 10004a8:	008487b3          	add	a5,s1,s0
 10004ac:	0007c503          	lbu	a0,0(a5)
 10004b0:	0c050263          	beqz	a0,1000574 <bsp_printf+0x124>
            if (format[i] == '%') {
 10004b4:	02500793          	li	a5,37
 10004b8:	06f50663          	beq	a0,a5,1000524 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
 10004bc:	e29ff0ef          	jal	ra,10002e4 <bsp_printf_c>
 10004c0:	fe5ff06f          	j	10004a4 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
 10004c4:	00c12783          	lw	a5,12(sp)
 10004c8:	00478713          	addi	a4,a5,4
 10004cc:	00e12623          	sw	a4,12(sp)
 10004d0:	0007a503          	lw	a0,0(a5)
 10004d4:	e2dff0ef          	jal	ra,1000300 <bsp_printf_s>
                        break;
 10004d8:	fcdff06f          	j	10004a4 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
 10004dc:	00c12783          	lw	a5,12(sp)
 10004e0:	00478713          	addi	a4,a5,4
 10004e4:	00e12623          	sw	a4,12(sp)
 10004e8:	0007a503          	lw	a0,0(a5)
 10004ec:	e2dff0ef          	jal	ra,1000318 <bsp_printf_d>
                        break;
 10004f0:	fb5ff06f          	j	10004a4 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
 10004f4:	00c12783          	lw	a5,12(sp)
 10004f8:	00478713          	addi	a4,a5,4
 10004fc:	00e12623          	sw	a4,12(sp)
 1000500:	0007a503          	lw	a0,0(a5)
 1000504:	ed5ff0ef          	jal	ra,10003d8 <bsp_printf_X>
                        break;
 1000508:	f9dff06f          	j	10004a4 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
 100050c:	00c12783          	lw	a5,12(sp)
 1000510:	00478713          	addi	a4,a5,4
 1000514:	00e12623          	sw	a4,12(sp)
 1000518:	0007a503          	lw	a0,0(a5)
 100051c:	e7dff0ef          	jal	ra,1000398 <bsp_printf_x>
                        break;
 1000520:	f85ff06f          	j	10004a4 <bsp_printf+0x54>
                while (format[++i]) {
 1000524:	00140413          	addi	s0,s0,1
 1000528:	008487b3          	add	a5,s1,s0
 100052c:	0007c783          	lbu	a5,0(a5)
 1000530:	f6078ae3          	beqz	a5,10004a4 <bsp_printf+0x54>
                    if (format[i] == 'c') {
 1000534:	06300713          	li	a4,99
 1000538:	f4e78ce3          	beq	a5,a4,1000490 <bsp_printf+0x40>
                    else if (format[i] == 's') {
 100053c:	07300713          	li	a4,115
 1000540:	f8e782e3          	beq	a5,a4,10004c4 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
 1000544:	06400713          	li	a4,100
 1000548:	f8e78ae3          	beq	a5,a4,10004dc <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
 100054c:	05800713          	li	a4,88
 1000550:	fae782e3          	beq	a5,a4,10004f4 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
 1000554:	07800713          	li	a4,120
 1000558:	fae78ae3          	beq	a5,a4,100050c <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
 100055c:	06600713          	li	a4,102
 1000560:	fce792e3          	bne	a5,a4,1000524 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
 1000564:	01001537          	lui	a0,0x1001
 1000568:	81850513          	addi	a0,a0,-2024 # 1000818 <_data+0x28>
 100056c:	d95ff0ef          	jal	ra,1000300 <bsp_printf_s>
                        break;
 1000570:	f35ff06f          	j	10004a4 <bsp_printf+0x54>

        va_end(ap);
    }
 1000574:	01c12083          	lw	ra,28(sp)
 1000578:	01812403          	lw	s0,24(sp)
 100057c:	01412483          	lw	s1,20(sp)
 1000580:	04010113          	addi	sp,sp,64
 1000584:	00008067          	ret

01000588 <main>:
#include "clint.h"
#include "plic.h"
#include "arduinoGPIO.h"


void main() {
 1000588:	ff010113          	addi	sp,sp,-16
 100058c:	00112623          	sw	ra,12(sp)
 1000590:	00812423          	sw	s0,8(sp)
 1000594:	00912223          	sw	s1,4(sp)
    bsp_init();
 1000598:	e81ff0ef          	jal	ra,1000418 <bsp_init>
    bsp_printf("***Starting GPIO Demo*** \r\n");
 100059c:	01001537          	lui	a0,0x1001
 10005a0:	86450513          	addi	a0,a0,-1948 # 1000864 <_data+0x74>
 10005a4:	eadff0ef          	jal	ra,1000450 <bsp_printf>
    bsp_printf("Configure GPIOs to blink .. \r\n");
 10005a8:	01001537          	lui	a0,0x1001
 10005ac:	88050513          	addi	a0,a0,-1920 # 1000880 <_data+0x90>
 10005b0:	ea1ff0ef          	jal	ra,1000450 <bsp_printf>
    // Set GPIO to output
    pinMode(GPIO_BANK0, 0, OUTPUT);
 10005b4:	00100613          	li	a2,1
 10005b8:	00000593          	li	a1,0
 10005bc:	f8015537          	lui	a0,0xf8015
 10005c0:	100000ef          	jal	ra,10006c0 <pinMode>
    pinMode(GPIO_BANK0, 1, OUTPUT);
 10005c4:	00100613          	li	a2,1
 10005c8:	00100593          	li	a1,1
 10005cc:	f8015537          	lui	a0,0xf8015
 10005d0:	0f0000ef          	jal	ra,10006c0 <pinMode>
    pinMode(GPIO_BANK0, 2, OUTPUT);
 10005d4:	00100613          	li	a2,1
 10005d8:	00200593          	li	a1,2
 10005dc:	f8015537          	lui	a0,0xf8015
 10005e0:	0e0000ef          	jal	ra,10006c0 <pinMode>
    pinMode(GPIO_BANK0, 3, OUTPUT);
 10005e4:	00100613          	li	a2,1
 10005e8:	00300593          	li	a1,3
 10005ec:	f8015537          	lui	a0,0xf8015
 10005f0:	0d0000ef          	jal	ra,10006c0 <pinMode>
    pinMode(GPIO_BANK0, 4, OUTPUT);
 10005f4:	00100613          	li	a2,1
 10005f8:	00400593          	li	a1,4
 10005fc:	f8015537          	lui	a0,0xf8015
 1000600:	0c0000ef          	jal	ra,10006c0 <pinMode>
    pinMode(GPIO_BANK0, 5, OUTPUT);
 1000604:	00100613          	li	a2,1
 1000608:	00500593          	li	a1,5
 100060c:	f8015537          	lui	a0,0xf8015
 1000610:	0b0000ef          	jal	ra,10006c0 <pinMode>

    digitalWrite(GPIO_BANK0, 0, LOW);
 1000614:	00000613          	li	a2,0
 1000618:	00000593          	li	a1,0
 100061c:	f8015537          	lui	a0,0xf8015
 1000620:	100000ef          	jal	ra,1000720 <digitalWrite>
    digitalWrite(GPIO_BANK0, 1, LOW);
 1000624:	00000613          	li	a2,0
 1000628:	00100593          	li	a1,1
 100062c:	f8015537          	lui	a0,0xf8015
 1000630:	0f0000ef          	jal	ra,1000720 <digitalWrite>
    digitalWrite(GPIO_BANK0, 2, LOW);
 1000634:	00000613          	li	a2,0
 1000638:	00200593          	li	a1,2
 100063c:	f8015537          	lui	a0,0xf8015
 1000640:	0e0000ef          	jal	ra,1000720 <digitalWrite>
    digitalWrite(GPIO_BANK0, 3, LOW);
 1000644:	00000613          	li	a2,0
 1000648:	00300593          	li	a1,3
 100064c:	f8015537          	lui	a0,0xf8015
 1000650:	0d0000ef          	jal	ra,1000720 <digitalWrite>
    digitalWrite(GPIO_BANK0, 4, LOW);
 1000654:	00000613          	li	a2,0
 1000658:	00400593          	li	a1,4
 100065c:	f8015537          	lui	a0,0xf8015
 1000660:	0c0000ef          	jal	ra,1000720 <digitalWrite>
    digitalWrite(GPIO_BANK0, 5, LOW);
 1000664:	00000613          	li	a2,0
 1000668:	00500593          	li	a1,5
 100066c:	f8015537          	lui	a0,0xf8015
 1000670:	0b0000ef          	jal	ra,1000720 <digitalWrite>

   while(1) {
	    digitalWrite(GPIO_BANK0, 0, HIGH);
 1000674:	00100613          	li	a2,1
 1000678:	00000593          	li	a1,0
 100067c:	f8015537          	lui	a0,0xf8015
 1000680:	0a0000ef          	jal	ra,1000720 <digitalWrite>
        bsp_uDelay(5*LOOP_UDELAY);
 1000684:	f8b00637          	lui	a2,0xf8b00
 1000688:	05f5e4b7          	lui	s1,0x5f5e
 100068c:	10048593          	addi	a1,s1,256 # 5f5e100 <__freertos_irq_stack_top+0x4f5d040>
 1000690:	0007a437          	lui	s0,0x7a
 1000694:	12040513          	addi	a0,s0,288 # 7a120 <__stack_size+0x79920>
 1000698:	b1dff0ef          	jal	ra,10001b4 <clint_uDelay>
        digitalWrite(GPIO_BANK0, 0, LOW);
 100069c:	00000613          	li	a2,0
 10006a0:	00000593          	li	a1,0
 10006a4:	f8015537          	lui	a0,0xf8015
 10006a8:	078000ef          	jal	ra,1000720 <digitalWrite>
        bsp_uDelay(5*LOOP_UDELAY);
 10006ac:	f8b00637          	lui	a2,0xf8b00
 10006b0:	10048593          	addi	a1,s1,256
 10006b4:	12040513          	addi	a0,s0,288
 10006b8:	afdff0ef          	jal	ra,10001b4 <clint_uDelay>
 10006bc:	fb9ff06f          	j	1000674 <main+0xec>

010006c0 <pinMode>:
#include "arduinoGPIO.h"

void pinMode(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
 10006c0:	00100793          	li	a5,1
 10006c4:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
 10006c8:	02f60463          	beq	a2,a5,10006f0 <pinMode+0x30>
 10006cc:	00060863          	beqz	a2,10006dc <pinMode+0x1c>
 10006d0:	00200793          	li	a5,2
 10006d4:	02f60663          	beq	a2,a5,1000700 <pinMode+0x40>
 10006d8:	00008067          	ret
 10006dc:	00852783          	lw	a5,8(a0) # f8015008 <__freertos_irq_stack_top+0xf7013f48>
        case INPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
 10006e0:	fff5c593          	not	a1,a1
 10006e4:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
 10006e8:	00b52423          	sw	a1,8(a0)
 10006ec:	00008067          	ret
        return *((volatile u32*) address);
 10006f0:	00852783          	lw	a5,8(a0)
            break;

        case OUTPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) | mask);
 10006f4:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
 10006f8:	00b52423          	sw	a1,8(a0)
 10006fc:	00008067          	ret
        return *((volatile u32*) address);
 1000700:	00852703          	lw	a4,8(a0)
            break;

        case INPUT_PULLUP:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
 1000704:	fff5c793          	not	a5,a1
 1000708:	00e7f7b3          	and	a5,a5,a4
        *((volatile u32*) address) = data;
 100070c:	00f52423          	sw	a5,8(a0)
        return *((volatile u32*) address);
 1000710:	00452783          	lw	a5,4(a0)
            gpio_setOutput(bank, gpio_getOutput(bank) | mask); // Enable pull-up
 1000714:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
 1000718:	00b52223          	sw	a1,4(a0)
            break;
    }
}
 100071c:	00008067          	ret

01000720 <digitalWrite>:
        return *((volatile u32*) address);
 1000720:	00452703          	lw	a4,4(a0)

void digitalWrite(uint32_t bank, uint32_t pin, uint32_t val) {
    uint32_t current = gpio_getOutput(bank);
    uint32_t mask = 1 << pin;
 1000724:	00100793          	li	a5,1
 1000728:	00b795b3          	sll	a1,a5,a1

    if(val == HIGH) {
 100072c:	00f60a63          	beq	a2,a5,1000740 <digitalWrite+0x20>
        gpio_setOutput(bank, current | mask);
    } else {
        gpio_setOutput(bank, current & ~mask);
 1000730:	fff5c593          	not	a1,a1
 1000734:	00e5f5b3          	and	a1,a1,a4
        *((volatile u32*) address) = data;
 1000738:	00b52223          	sw	a1,4(a0)
    }
}
 100073c:	00008067          	ret
        gpio_setOutput(bank, current | mask);
 1000740:	00e5e5b3          	or	a1,a1,a4
 1000744:	00b52223          	sw	a1,4(a0)
 1000748:	00008067          	ret

0100074c <digitalRead>:
        return *((volatile u32*) address);
 100074c:	00052503          	lw	a0,0(a0)

uint32_t digitalRead(uint32_t bank, uint32_t pin) {
    uint32_t value = gpio_getInput(bank);
    return (value >> pin) & 0x1;
 1000750:	00b55533          	srl	a0,a0,a1
}
 1000754:	00157513          	andi	a0,a0,1
 1000758:	00008067          	ret

0100075c <attachInterrupt>:

void attachInterrupt(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
 100075c:	00100793          	li	a5,1
 1000760:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
 1000764:	00200793          	li	a5,2
 1000768:	02f60c63          	beq	a2,a5,10007a0 <attachInterrupt+0x44>
 100076c:	00c7fe63          	bgeu	a5,a2,1000788 <attachInterrupt+0x2c>
 1000770:	00300793          	li	a5,3
 1000774:	02f60a63          	beq	a2,a5,10007a8 <attachInterrupt+0x4c>
 1000778:	00400793          	li	a5,4
 100077c:	02f61063          	bne	a2,a5,100079c <attachInterrupt+0x40>
        *((volatile u32*) address) = data;
 1000780:	02b52623          	sw	a1,44(a0)

        case LOW_LEVEL:
            gpio_setInterruptLowEnable(bank, mask);
            break;
    }
}
 1000784:	00008067          	ret
    switch(mode) {
 1000788:	00100793          	li	a5,1
 100078c:	00f61663          	bne	a2,a5,1000798 <attachInterrupt+0x3c>
 1000790:	02b52023          	sw	a1,32(a0)
 1000794:	00008067          	ret
 1000798:	00008067          	ret
 100079c:	00008067          	ret
 10007a0:	02b52223          	sw	a1,36(a0)
 10007a4:	00008067          	ret
 10007a8:	02b52423          	sw	a1,40(a0)
 10007ac:	00008067          	ret

010007b0 <detachInterrupt>:

void detachInterrupt(uint32_t bank, uint32_t pin) {
    uint32_t mask = 1 << pin;
 10007b0:	00100793          	li	a5,1
 10007b4:	00b795b3          	sll	a1,a5,a1
        return *((volatile u32*) address);
 10007b8:	00052783          	lw	a5,0(a0)

    // Disable all interrupt modes for this pin
    gpio_setInterruptRiseEnable(bank, gpio_getInput(bank) & ~mask);
 10007bc:	fff5c593          	not	a1,a1
 10007c0:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
 10007c4:	02f52023          	sw	a5,32(a0)
        return *((volatile u32*) address);
 10007c8:	00052783          	lw	a5,0(a0)
    gpio_setInterruptFallEnable(bank, gpio_getInput(bank) & ~mask);
 10007cc:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
 10007d0:	02f52223          	sw	a5,36(a0)
        return *((volatile u32*) address);
 10007d4:	00052783          	lw	a5,0(a0)
    gpio_setInterruptHighEnable(bank, gpio_getInput(bank) & ~mask);
 10007d8:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
 10007dc:	02f52423          	sw	a5,40(a0)
        return *((volatile u32*) address);
 10007e0:	00052783          	lw	a5,0(a0)
    gpio_setInterruptLowEnable(bank, gpio_getInput(bank) & ~mask);
 10007e4:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
 10007e8:	02b52623          	sw	a1,44(a0)
}
 10007ec:	00008067          	ret
