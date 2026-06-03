
build/gpioDemo.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00001197          	auipc	gp,0x1
f9000004:	38818193          	addi	gp,gp,904 # f9001388 <__global_pointer$>
.global smp_lottery_target
.global smp_lottery_lock
.global smp_slave


  sw x0, smp_lottery_lock, a1
f9000008:	8201a023          	sw	zero,-2016(gp) # f9000ba8 <smp_lottery_lock>

f900000c <smp_tyranny>:

smp_tyranny:
  csrr a0, mhartid
f900000c:	f1402573          	csrr	a0,mhartid
  beqz a0, init
f9000010:	02050e63          	beqz	a0,f900004c <init>

f9000014 <smp_slave>:

smp_slave:
	lw a0, smp_lottery_lock
f9000014:	8201a503          	lw	a0,-2016(gp) # f9000ba8 <smp_lottery_lock>
	beqz a0, smp_slave
f9000018:	fe050ee3          	beqz	a0,f9000014 <smp_slave>

	fence r, r
f900001c:	0220000f          	fence	r,r
f9000020:	0000100f          	fence.i
	//li a1, -1
	//amoadd.w x0, a1,(a0)

	.word(0x100F) //i$ flush
	lw a5, smp_lottery_target
f9000024:	81c1a783          	lw	a5,-2020(gp) # f9000ba4 <__bss_start>
	li a0, 0
f9000028:	00000513          	li	a0,0
	li a1, 0
f900002c:	00000593          	li	a1,0
	li a2, 0
f9000030:	00000613          	li	a2,0
	jr a5
f9000034:	00078067          	jr	a5

f9000038 <smp_unlock>:

.global   smp_unlock
.type    smp_unlock,%function
smp_unlock:
	sw a0, smp_lottery_target, a1
f9000038:	80a1ae23          	sw	a0,-2020(gp) # f9000ba4 <__bss_start>
	fence w, w
f900003c:	0110000f          	fence	w,w
	li a0, 1
f9000040:	00100513          	li	a0,1
	sw a0, smp_lottery_lock, a1
f9000044:	82a1a023          	sw	a0,-2016(gp) # f9000ba8 <smp_lottery_lock>
    ret
f9000048:	00008067          	ret

f900004c <init>:
#endif

init:
	la sp, _sp
f900004c:	02818113          	addi	sp,gp,40 # f90013b0 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
f9000050:	00001517          	auipc	a0,0x1
f9000054:	a4850513          	addi	a0,a0,-1464 # f9000a98 <_data>
	la a1, _data
f9000058:	00001597          	auipc	a1,0x1
f900005c:	a4058593          	addi	a1,a1,-1472 # f9000a98 <_data>
	la a2, _edata
f9000060:	81c18613          	addi	a2,gp,-2020 # f9000ba4 <__bss_start>
	bgeu a1, a2, 2f
f9000064:	00c5fc63          	bgeu	a1,a2,f900007c <init+0x30>
1:
	lw t0, (a0)
f9000068:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
f900006c:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
f9000070:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
f9000074:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
f9000078:	fec5e8e3          	bltu	a1,a2,f9000068 <init+0x1c>
2:

	/* Clear bss section */
	la a0, __bss_start
f900007c:	81c18513          	addi	a0,gp,-2020 # f9000ba4 <__bss_start>
	la a1, _end
f9000080:	82818593          	addi	a1,gp,-2008 # f9000bb0 <_end>
	bgeu a0, a1, 2f
f9000084:	00b57863          	bgeu	a0,a1,f9000094 <init+0x48>
1:
	sw zero, (a0)
f9000088:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
f900008c:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
f9000090:	feb56ce3          	bltu	a0,a1,f9000088 <init+0x3c>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
f9000094:	010000ef          	jal	ra,f90000a4 <__libc_init_array>
#endif

	call main
f9000098:	708000ef          	jal	ra,f90007a0 <main>

f900009c <mainDone>:
mainDone:
    j mainDone
f900009c:	0000006f          	j	f900009c <mainDone>

f90000a0 <_init>:


	.globl _init
_init:
    ret
f90000a0:	00008067          	ret

Disassembly of section .text:

f90000a4 <__libc_init_array>:
f90000a4:	ff010113          	addi	sp,sp,-16
f90000a8:	00812423          	sw	s0,8(sp)
f90000ac:	01212023          	sw	s2,0(sp)
f90000b0:	00001417          	auipc	s0,0x1
f90000b4:	9e840413          	addi	s0,s0,-1560 # f9000a98 <_data>
f90000b8:	00001917          	auipc	s2,0x1
f90000bc:	9e090913          	addi	s2,s2,-1568 # f9000a98 <_data>
f90000c0:	40890933          	sub	s2,s2,s0
f90000c4:	00112623          	sw	ra,12(sp)
f90000c8:	00912223          	sw	s1,4(sp)
f90000cc:	40295913          	srai	s2,s2,0x2
f90000d0:	00090e63          	beqz	s2,f90000ec <__libc_init_array+0x48>
f90000d4:	00000493          	li	s1,0
f90000d8:	00042783          	lw	a5,0(s0)
f90000dc:	00148493          	addi	s1,s1,1
f90000e0:	00440413          	addi	s0,s0,4
f90000e4:	000780e7          	jalr	a5
f90000e8:	fe9918e3          	bne	s2,s1,f90000d8 <__libc_init_array+0x34>
f90000ec:	00001417          	auipc	s0,0x1
f90000f0:	9ac40413          	addi	s0,s0,-1620 # f9000a98 <_data>
f90000f4:	00001917          	auipc	s2,0x1
f90000f8:	9a490913          	addi	s2,s2,-1628 # f9000a98 <_data>
f90000fc:	40890933          	sub	s2,s2,s0
f9000100:	40295913          	srai	s2,s2,0x2
f9000104:	00090e63          	beqz	s2,f9000120 <__libc_init_array+0x7c>
f9000108:	00000493          	li	s1,0
f900010c:	00042783          	lw	a5,0(s0)
f9000110:	00148493          	addi	s1,s1,1
f9000114:	00440413          	addi	s0,s0,4
f9000118:	000780e7          	jalr	a5
f900011c:	fe9918e3          	bne	s2,s1,f900010c <__libc_init_array+0x68>
f9000120:	00c12083          	lw	ra,12(sp)
f9000124:	00812403          	lw	s0,8(sp)
f9000128:	00412483          	lw	s1,4(sp)
f900012c:	00012903          	lw	s2,0(sp)
f9000130:	01010113          	addi	sp,sp,16
f9000134:	00008067          	ret

f9000138 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f9000138:	00452503          	lw	a0,4(a0)
*          of available spaces for writing data from bits 23 to 16. It then
*          returns this value after masking with 0xFF.
*
******************************************************************************/
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f900013c:	01055513          	srli	a0,a0,0x10
    }
f9000140:	0ff57513          	andi	a0,a0,255
f9000144:	00008067          	ret

f9000148 <uart_write>:
* @note    The function waits until there is available space in the UART buffer
*          for writing data. Once space is available, it writes the character
*          data to the UART data register.
*
******************************************************************************/
    static void uart_write(u32 reg, char data){
f9000148:	ff010113          	addi	sp,sp,-16
f900014c:	00112623          	sw	ra,12(sp)
f9000150:	00812423          	sw	s0,8(sp)
f9000154:	00912223          	sw	s1,4(sp)
f9000158:	00050413          	mv	s0,a0
f900015c:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000160:	00040513          	mv	a0,s0
f9000164:	fd5ff0ef          	jal	ra,f9000138 <uart_writeAvailability>
f9000168:	fe050ce3          	beqz	a0,f9000160 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f900016c:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
f9000170:	00c12083          	lw	ra,12(sp)
f9000174:	00812403          	lw	s0,8(sp)
f9000178:	00412483          	lw	s1,4(sp)
f900017c:	01010113          	addi	sp,sp,16
f9000180:	00008067          	ret

f9000184 <uart_applyConfig>:
*          value using data length, parity, and stop bit settings from the configuration
*          structure, and writes this value to the UART frame configuration register.
*
******************************************************************************/
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
f9000184:	00c5a783          	lw	a5,12(a1)
f9000188:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
f900018c:	0005a783          	lw	a5,0(a1)
f9000190:	fff78793          	addi	a5,a5,-1
f9000194:	0045a703          	lw	a4,4(a1)
f9000198:	00871713          	slli	a4,a4,0x8
f900019c:	00e7e7b3          	or	a5,a5,a4
f90001a0:	0085a703          	lw	a4,8(a1)
f90001a4:	01071713          	slli	a4,a4,0x10
f90001a8:	00e7e7b3          	or	a5,a5,a4
f90001ac:	00f52623          	sw	a5,12(a0)
    }
f90001b0:	00008067          	ret

f90001b4 <clint_uDelay>:
*          and the time limit is non-negative, indicating that the delay has
*          not yet elapsed.
*
******************************************************************************/
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
f90001b4:	000f47b7          	lui	a5,0xf4
f90001b8:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf3a40>
f90001bc:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f90001c0:	0000c7b7          	lui	a5,0xc
f90001c4:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xb7f8>
f90001c8:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f90001cc:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f90001d0:	02a58533          	mul	a0,a1,a0
f90001d4:	00f50533          	add	a0,a0,a5
f90001d8:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f90001dc:	40f507b3          	sub	a5,a0,a5
f90001e0:	fe07dce3          	bgez	a5,f90001d8 <clint_uDelay+0x24>
f90001e4:	00008067          	ret

f90001e8 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
f90001e8:	ff010113          	addi	sp,sp,-16
f90001ec:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
f90001f0:	00050593          	mv	a1,a0
f90001f4:	f8010537          	lui	a0,0xf8010
f90001f8:	f51ff0ef          	jal	ra,f9000148 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f90001fc:	00c12083          	lw	ra,12(sp)
f9000200:	01010113          	addi	sp,sp,16
f9000204:	00008067          	ret

f9000208 <_putchar_s>:

    static void _putchar_s(char *p)
    {
f9000208:	ff010113          	addi	sp,sp,-16
f900020c:	00112623          	sw	ra,12(sp)
f9000210:	00812423          	sw	s0,8(sp)
f9000214:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
f9000218:	00044503          	lbu	a0,0(s0)
f900021c:	00050863          	beqz	a0,f900022c <_putchar_s+0x24>
            _putchar(*(p++));
f9000220:	00140413          	addi	s0,s0,1
f9000224:	fc5ff0ef          	jal	ra,f90001e8 <_putchar>
f9000228:	ff1ff06f          	j	f9000218 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f900022c:	00c12083          	lw	ra,12(sp)
f9000230:	00812403          	lw	s0,8(sp)
f9000234:	01010113          	addi	sp,sp,16
f9000238:	00008067          	ret

f900023c <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
f900023c:	ff010113          	addi	sp,sp,-16
f9000240:	00112623          	sw	ra,12(sp)
f9000244:	00812423          	sw	s0,8(sp)
f9000248:	00912223          	sw	s1,4(sp)
f900024c:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000250:	01c00413          	li	s0,28
f9000254:	0240006f          	j	f9000278 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f9000258:	0084d7b3          	srl	a5,s1,s0
f900025c:	00f7f713          	andi	a4,a5,15
f9000260:	f90017b7          	lui	a5,0xf9001
f9000264:	a9878793          	addi	a5,a5,-1384 # f9000a98 <__freertos_irq_stack_top+0xfffff6e8>
f9000268:	00e787b3          	add	a5,a5,a4
f900026c:	0007c503          	lbu	a0,0(a5)
f9000270:	f79ff0ef          	jal	ra,f90001e8 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000274:	ffc40413          	addi	s0,s0,-4
f9000278:	fe0450e3          	bgez	s0,f9000258 <bsp_printHex+0x1c>
        }
    }
f900027c:	00c12083          	lw	ra,12(sp)
f9000280:	00812403          	lw	s0,8(sp)
f9000284:	00412483          	lw	s1,4(sp)
f9000288:	01010113          	addi	sp,sp,16
f900028c:	00008067          	ret

f9000290 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
f9000290:	ff010113          	addi	sp,sp,-16
f9000294:	00112623          	sw	ra,12(sp)
f9000298:	00812423          	sw	s0,8(sp)
f900029c:	00912223          	sw	s1,4(sp)
f90002a0:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f90002a4:	01c00413          	li	s0,28
f90002a8:	0240006f          	j	f90002cc <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
f90002ac:	0084d7b3          	srl	a5,s1,s0
f90002b0:	00f7f713          	andi	a4,a5,15
f90002b4:	f90017b7          	lui	a5,0xf9001
f90002b8:	aac78793          	addi	a5,a5,-1364 # f9000aac <__freertos_irq_stack_top+0xfffff6fc>
f90002bc:	00e787b3          	add	a5,a5,a4
f90002c0:	0007c503          	lbu	a0,0(a5)
f90002c4:	f25ff0ef          	jal	ra,f90001e8 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f90002c8:	ffc40413          	addi	s0,s0,-4
f90002cc:	fe0450e3          	bgez	s0,f90002ac <bsp_printHex_lower+0x1c>

        }
    }
f90002d0:	00c12083          	lw	ra,12(sp)
f90002d4:	00812403          	lw	s0,8(sp)
f90002d8:	00412483          	lw	s1,4(sp)
f90002dc:	01010113          	addi	sp,sp,16
f90002e0:	00008067          	ret

f90002e4 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
f90002e4:	ff010113          	addi	sp,sp,-16
f90002e8:	00112623          	sw	ra,12(sp)
        _putchar(c);
f90002ec:	0ff57513          	andi	a0,a0,255
f90002f0:	ef9ff0ef          	jal	ra,f90001e8 <_putchar>
    }
f90002f4:	00c12083          	lw	ra,12(sp)
f90002f8:	01010113          	addi	sp,sp,16
f90002fc:	00008067          	ret

f9000300 <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
f9000300:	ff010113          	addi	sp,sp,-16
f9000304:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f9000308:	f01ff0ef          	jal	ra,f9000208 <_putchar_s>
    }
f900030c:	00c12083          	lw	ra,12(sp)
f9000310:	01010113          	addi	sp,sp,16
f9000314:	00008067          	ret

f9000318 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
f9000318:	fd010113          	addi	sp,sp,-48
f900031c:	02112623          	sw	ra,44(sp)
f9000320:	02812423          	sw	s0,40(sp)
f9000324:	02912223          	sw	s1,36(sp)
f9000328:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
f900032c:	00054663          	bltz	a0,f9000338 <bsp_printf_d+0x20>
    {
f9000330:	00010413          	mv	s0,sp
f9000334:	02c0006f          	j	f9000360 <bsp_printf_d+0x48>
            bsp_printf_c('-');
f9000338:	02d00513          	li	a0,45
f900033c:	fa9ff0ef          	jal	ra,f90002e4 <bsp_printf_c>
            val = -val;
f9000340:	409004b3          	neg	s1,s1
f9000344:	fedff06f          	j	f9000330 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
f9000348:	00a00713          	li	a4,10
f900034c:	02e4e7b3          	rem	a5,s1,a4
f9000350:	03078793          	addi	a5,a5,48
f9000354:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f9000358:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f900035c:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f9000360:	fe0494e3          	bnez	s1,f9000348 <bsp_printf_d+0x30>
f9000364:	00010793          	mv	a5,sp
f9000368:	fef400e3          	beq	s0,a5,f9000348 <bsp_printf_d+0x30>
f900036c:	0100006f          	j	f900037c <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
f9000370:	fff40413          	addi	s0,s0,-1
f9000374:	00044503          	lbu	a0,0(s0)
f9000378:	f6dff0ef          	jal	ra,f90002e4 <bsp_printf_c>
        while (p != buffer)
f900037c:	00010793          	mv	a5,sp
f9000380:	fef418e3          	bne	s0,a5,f9000370 <bsp_printf_d+0x58>
    }
f9000384:	02c12083          	lw	ra,44(sp)
f9000388:	02812403          	lw	s0,40(sp)
f900038c:	02412483          	lw	s1,36(sp)
f9000390:	03010113          	addi	sp,sp,48
f9000394:	00008067          	ret

f9000398 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
f9000398:	ff010113          	addi	sp,sp,-16
f900039c:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
f90003a0:	00000713          	li	a4,0
f90003a4:	00700793          	li	a5,7
f90003a8:	02e7c063          	blt	a5,a4,f90003c8 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f90003ac:	00271693          	slli	a3,a4,0x2
f90003b0:	ff000793          	li	a5,-16
f90003b4:	00d797b3          	sll	a5,a5,a3
f90003b8:	00f577b3          	and	a5,a0,a5
f90003bc:	00078663          	beqz	a5,f90003c8 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f90003c0:	00170713          	addi	a4,a4,1
f90003c4:	fe1ff06f          	j	f90003a4 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
f90003c8:	ec9ff0ef          	jal	ra,f9000290 <bsp_printHex_lower>
    }
f90003cc:	00c12083          	lw	ra,12(sp)
f90003d0:	01010113          	addi	sp,sp,16
f90003d4:	00008067          	ret

f90003d8 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
f90003d8:	ff010113          	addi	sp,sp,-16
f90003dc:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
f90003e0:	00000713          	li	a4,0
f90003e4:	00700793          	li	a5,7
f90003e8:	02e7c063          	blt	a5,a4,f9000408 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f90003ec:	00271693          	slli	a3,a4,0x2
f90003f0:	ff000793          	li	a5,-16
f90003f4:	00d797b3          	sll	a5,a5,a3
f90003f8:	00f577b3          	and	a5,a0,a5
f90003fc:	00078663          	beqz	a5,f9000408 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9000400:	00170713          	addi	a4,a4,1
f9000404:	fe1ff06f          	j	f90003e4 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
f9000408:	e35ff0ef          	jal	ra,f900023c <bsp_printHex>
        }
f900040c:	00c12083          	lw	ra,12(sp)
f9000410:	01010113          	addi	sp,sp,16
f9000414:	00008067          	ret

f9000418 <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
f9000418:	fe010113          	addi	sp,sp,-32
f900041c:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
f9000420:	00800793          	li	a5,8
f9000424:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
f9000428:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
f900042c:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
f9000430:	06b00793          	li	a5,107
f9000434:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
f9000438:	00010593          	mv	a1,sp
f900043c:	f8010537          	lui	a0,0xf8010
f9000440:	d45ff0ef          	jal	ra,f9000184 <uart_applyConfig>
    }
f9000444:	01c12083          	lw	ra,28(sp)
f9000448:	02010113          	addi	sp,sp,32
f900044c:	00008067          	ret

f9000450 <plic_set_priority>:
*          specified priority value to the calculated address, effectively
*          setting the priority for the specified interrupt gateway in the PLIC.
*
******************************************************************************/
    static void plic_set_priority(u32 plic, u32 gateway, u32 priority){
        write_u32(priority, plic + PLIC_PRIORITY_BASE + gateway*4);
f9000450:	00259593          	slli	a1,a1,0x2
f9000454:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
f9000458:	00c5a023          	sw	a2,0(a1)
    }
f900045c:	00008067          	ret

f9000460 <plic_set_enable>:
*          to the enable register.
*
******************************************************************************/

    static void plic_set_enable(u32 plic, u32 target,u32 gateway, u32 enable){
        u32 word = plic + PLIC_ENABLE_BASE + target * PLIC_ENABLE_PER_HART + (gateway / 32 * 4);
f9000460:	00759593          	slli	a1,a1,0x7
f9000464:	00a58533          	add	a0,a1,a0
f9000468:	00565593          	srli	a1,a2,0x5
f900046c:	00259593          	slli	a1,a1,0x2
f9000470:	00b50533          	add	a0,a0,a1
f9000474:	000025b7          	lui	a1,0x2
f9000478:	00b50533          	add	a0,a0,a1
        u32 mask = 1 << (gateway % 32);
f900047c:	00100793          	li	a5,1
f9000480:	00c797b3          	sll	a5,a5,a2
        if (enable)
f9000484:	00068a63          	beqz	a3,f9000498 <plic_set_enable+0x38>
        return *((volatile u32*) address);
f9000488:	00052603          	lw	a2,0(a0) # f8010000 <__freertos_irq_stack_top+0xff00ec50>
            write_u32(read_u32(word) | mask, word);
f900048c:	00c7e7b3          	or	a5,a5,a2
        *((volatile u32*) address) = data;
f9000490:	00f52023          	sw	a5,0(a0)
f9000494:	00008067          	ret
        return *((volatile u32*) address);
f9000498:	00052603          	lw	a2,0(a0)
        else
            write_u32(read_u32(word) & ~mask, word);
f900049c:	fff7c793          	not	a5,a5
f90004a0:	00c7f7b3          	and	a5,a5,a2
        *((volatile u32*) address) = data;
f90004a4:	00f52023          	sw	a5,0(a0)
    }
f90004a8:	00008067          	ret

f90004ac <plic_set_threshold>:
*          to the calculated address, effectively setting the threshold for the
*          specified target in the PLIC.
*
******************************************************************************/   
    static void plic_set_threshold(u32 plic, u32 target, u32 threshold){
        write_u32(threshold, plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
f90004ac:	00c59593          	slli	a1,a1,0xc
f90004b0:	00a585b3          	add	a1,a1,a0
f90004b4:	00200537          	lui	a0,0x200
f90004b8:	00a585b3          	add	a1,a1,a0
f90004bc:	00c5a023          	sw	a2,0(a1) # 2000 <__stack_size+0x1800>
    }
f90004c0:	00008067          	ret

f90004c4 <plic_claim>:
*          value from the calculated address, effectively claiming an interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static u32 plic_claim(u32 plic, u32 target){
        return read_u32(plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f90004c4:	00c59593          	slli	a1,a1,0xc
f90004c8:	00a585b3          	add	a1,a1,a0
f90004cc:	00200537          	lui	a0,0x200
f90004d0:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x1ff804>
f90004d4:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
f90004d8:	0005a503          	lw	a0,0(a1)
    }
f90004dc:	00008067          	ret

f90004e0 <plic_release>:
*          to the calculated address, effectively releasing the claimed interrupt
*          for the specified target in the PLIC.
*
******************************************************************************/
    static void plic_release(u32 plic, u32 target, u32 gateway){
        write_u32(gateway,plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
f90004e0:	00c59593          	slli	a1,a1,0xc
f90004e4:	00a585b3          	add	a1,a1,a0
f90004e8:	00200537          	lui	a0,0x200
f90004ec:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x1ff804>
f90004f0:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
f90004f4:	00c5a023          	sw	a2,0(a1)
    }
f90004f8:	00008067          	ret

f90004fc <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
f90004fc:	fc010113          	addi	sp,sp,-64
f9000500:	00112e23          	sw	ra,28(sp)
f9000504:	00812c23          	sw	s0,24(sp)
f9000508:	00912a23          	sw	s1,20(sp)
f900050c:	00050493          	mv	s1,a0
f9000510:	02b12223          	sw	a1,36(sp)
f9000514:	02c12423          	sw	a2,40(sp)
f9000518:	02d12623          	sw	a3,44(sp)
f900051c:	02e12823          	sw	a4,48(sp)
f9000520:	02f12a23          	sw	a5,52(sp)
f9000524:	03012c23          	sw	a6,56(sp)
f9000528:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
f900052c:	02410793          	addi	a5,sp,36
f9000530:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
f9000534:	00000413          	li	s0,0
f9000538:	01c0006f          	j	f9000554 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
f900053c:	00c12783          	lw	a5,12(sp)
f9000540:	00478713          	addi	a4,a5,4
f9000544:	00e12623          	sw	a4,12(sp)
f9000548:	0007a503          	lw	a0,0(a5)
f900054c:	d99ff0ef          	jal	ra,f90002e4 <bsp_printf_c>
        for (i = 0; format[i]; i++)
f9000550:	00140413          	addi	s0,s0,1
f9000554:	008487b3          	add	a5,s1,s0
f9000558:	0007c503          	lbu	a0,0(a5)
f900055c:	0c050263          	beqz	a0,f9000620 <bsp_printf+0x124>
            if (format[i] == '%') {
f9000560:	02500793          	li	a5,37
f9000564:	06f50663          	beq	a0,a5,f90005d0 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
f9000568:	d7dff0ef          	jal	ra,f90002e4 <bsp_printf_c>
f900056c:	fe5ff06f          	j	f9000550 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f9000570:	00c12783          	lw	a5,12(sp)
f9000574:	00478713          	addi	a4,a5,4
f9000578:	00e12623          	sw	a4,12(sp)
f900057c:	0007a503          	lw	a0,0(a5)
f9000580:	d81ff0ef          	jal	ra,f9000300 <bsp_printf_s>
                        break;
f9000584:	fcdff06f          	j	f9000550 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f9000588:	00c12783          	lw	a5,12(sp)
f900058c:	00478713          	addi	a4,a5,4
f9000590:	00e12623          	sw	a4,12(sp)
f9000594:	0007a503          	lw	a0,0(a5)
f9000598:	d81ff0ef          	jal	ra,f9000318 <bsp_printf_d>
                        break;
f900059c:	fb5ff06f          	j	f9000550 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f90005a0:	00c12783          	lw	a5,12(sp)
f90005a4:	00478713          	addi	a4,a5,4
f90005a8:	00e12623          	sw	a4,12(sp)
f90005ac:	0007a503          	lw	a0,0(a5)
f90005b0:	e29ff0ef          	jal	ra,f90003d8 <bsp_printf_X>
                        break;
f90005b4:	f9dff06f          	j	f9000550 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f90005b8:	00c12783          	lw	a5,12(sp)
f90005bc:	00478713          	addi	a4,a5,4
f90005c0:	00e12623          	sw	a4,12(sp)
f90005c4:	0007a503          	lw	a0,0(a5)
f90005c8:	dd1ff0ef          	jal	ra,f9000398 <bsp_printf_x>
                        break;
f90005cc:	f85ff06f          	j	f9000550 <bsp_printf+0x54>
                while (format[++i]) {
f90005d0:	00140413          	addi	s0,s0,1
f90005d4:	008487b3          	add	a5,s1,s0
f90005d8:	0007c783          	lbu	a5,0(a5)
f90005dc:	f6078ae3          	beqz	a5,f9000550 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f90005e0:	06300713          	li	a4,99
f90005e4:	f4e78ce3          	beq	a5,a4,f900053c <bsp_printf+0x40>
                    else if (format[i] == 's') {
f90005e8:	07300713          	li	a4,115
f90005ec:	f8e782e3          	beq	a5,a4,f9000570 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
f90005f0:	06400713          	li	a4,100
f90005f4:	f8e78ae3          	beq	a5,a4,f9000588 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
f90005f8:	05800713          	li	a4,88
f90005fc:	fae782e3          	beq	a5,a4,f90005a0 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
f9000600:	07800713          	li	a4,120
f9000604:	fae78ae3          	beq	a5,a4,f90005b8 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
f9000608:	06600713          	li	a4,102
f900060c:	fce792e3          	bne	a5,a4,f90005d0 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f9000610:	f9001537          	lui	a0,0xf9001
f9000614:	ac050513          	addi	a0,a0,-1344 # f9000ac0 <__freertos_irq_stack_top+0xfffff710>
f9000618:	ce9ff0ef          	jal	ra,f9000300 <bsp_printf_s>
                        break;
f900061c:	f35ff06f          	j	f9000550 <bsp_printf+0x54>

        va_end(ap);
    }
f9000620:	01c12083          	lw	ra,28(sp)
f9000624:	01812403          	lw	s0,24(sp)
f9000628:	01412483          	lw	s1,20(sp)
f900062c:	04010113          	addi	sp,sp,64
f9000630:	00008067          	ret

f9000634 <crash>:
*
* @brief This function handles the system crash scenario by printing a crash message
* 		 and entering an infinite loop.
*
******************************************************************************/
void crash(){
f9000634:	ff010113          	addi	sp,sp,-16
f9000638:	00112623          	sw	ra,12(sp)
    bsp_printf("\r\n*** CRASH ***\r\n");
f900063c:	f9001537          	lui	a0,0xf9001
f9000640:	b0c50513          	addi	a0,a0,-1268 # f9000b0c <__freertos_irq_stack_top+0xfffff75c>
f9000644:	eb9ff0ef          	jal	ra,f90004fc <bsp_printf>
    while(1);
f9000648:	0000006f          	j	f9000648 <crash+0x14>

f900064c <gpioIsr>:
    } else {
        crash();
    }
}

void gpioIsr(){
f900064c:	ff010113          	addi	sp,sp,-16
f9000650:	00112623          	sw	ra,12(sp)
    bsp_printf("Entering gpio interrupt routine .. \r\n");
f9000654:	f9001537          	lui	a0,0xf9001
f9000658:	b2050513          	addi	a0,a0,-1248 # f9000b20 <__freertos_irq_stack_top+0xfffff770>
f900065c:	ea1ff0ef          	jal	ra,f90004fc <bsp_printf>
    bsp_uDelay(100);
f9000660:	f8b00637          	lui	a2,0xf8b00
f9000664:	05f5e5b7          	lui	a1,0x5f5e
f9000668:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5d900>
f900066c:	06400513          	li	a0,100
f9000670:	b45ff0ef          	jal	ra,f90001b4 <clint_uDelay>
    count++;
f9000674:	8241a583          	lw	a1,-2012(gp) # f9000bac <count>
f9000678:	00158593          	addi	a1,a1,1
f900067c:	82b1a223          	sw	a1,-2012(gp) # f9000bac <count>
    bsp_printf("Count:%d .. Done \r\n",count);
f9000680:	f9001537          	lui	a0,0xf9001
f9000684:	b4850513          	addi	a0,a0,-1208 # f9000b48 <__freertos_irq_stack_top+0xfffff798>
f9000688:	e75ff0ef          	jal	ra,f90004fc <bsp_printf>
}
f900068c:	00c12083          	lw	ra,12(sp)
f9000690:	01010113          	addi	sp,sp,16
f9000694:	00008067          	ret

f9000698 <isrRoutine>:
*        source. If an interrupt from an unknown source is detected, it 
*        calls a crash function to handle the error.
*
******************************************************************************/

void isrRoutine(){
f9000698:	ff010113          	addi	sp,sp,-16
f900069c:	00112623          	sw	ra,12(sp)
f90006a0:	00812423          	sw	s0,8(sp)
    uint32_t claim;
    // While there is pending interrupts
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
f90006a4:	00000593          	li	a1,0
f90006a8:	f8c00537          	lui	a0,0xf8c00
f90006ac:	e19ff0ef          	jal	ra,f90004c4 <plic_claim>
f90006b0:	00050413          	mv	s0,a0
f90006b4:	02050463          	beqz	a0,f90006dc <isrRoutine+0x44>
        switch(claim){
f90006b8:	00c00793          	li	a5,12
f90006bc:	00f41e63          	bne	s0,a5,f90006d8 <isrRoutine+0x40>
        case SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0: gpioIsr(); break;
f90006c0:	f8dff0ef          	jal	ra,f900064c <gpioIsr>
        default: crash(); break;
        }
        // Unmask the claimed interrupt
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
f90006c4:	00040613          	mv	a2,s0
f90006c8:	00000593          	li	a1,0
f90006cc:	f8c00537          	lui	a0,0xf8c00
f90006d0:	e11ff0ef          	jal	ra,f90004e0 <plic_release>
f90006d4:	fd1ff06f          	j	f90006a4 <isrRoutine+0xc>
        default: crash(); break;
f90006d8:	f5dff0ef          	jal	ra,f9000634 <crash>
    }
}
f90006dc:	00c12083          	lw	ra,12(sp)
f90006e0:	00812403          	lw	s0,8(sp)
f90006e4:	01010113          	addi	sp,sp,16
f90006e8:	00008067          	ret

f90006ec <trap>:
void trap(){
f90006ec:	ff010113          	addi	sp,sp,-16
f90006f0:	00112623          	sw	ra,12(sp)
    int32_t mcause = csr_read(mcause);
f90006f4:	342027f3          	csrr	a5,mcause
    if(interrupt){
f90006f8:	0207d263          	bgez	a5,f900071c <trap+0x30>
f90006fc:	00f7f713          	andi	a4,a5,15
        switch(cause){
f9000700:	00b00793          	li	a5,11
f9000704:	00f71a63          	bne	a4,a5,f9000718 <trap+0x2c>
        case CAUSE_MACHINE_EXTERNAL: isrRoutine(); break;
f9000708:	f91ff0ef          	jal	ra,f9000698 <isrRoutine>
}
f900070c:	00c12083          	lw	ra,12(sp)
f9000710:	01010113          	addi	sp,sp,16
f9000714:	00008067          	ret
        default: crash(); break;
f9000718:	f1dff0ef          	jal	ra,f9000634 <crash>
        crash();
f900071c:	f19ff0ef          	jal	ra,f9000634 <crash>

f9000720 <isrInit>:
*
* @brief This function initializes GPIO interrupts and enables external interrupts
*        by setting up the machine trap vector. 
*
******************************************************************************/
void isrInit(){
f9000720:	ff010113          	addi	sp,sp,-16
f9000724:	00112623          	sw	ra,12(sp)
    // Configure PLIC
    // Cpu 0 accept all interrupts with priority above 0
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); 
f9000728:	00000613          	li	a2,0
f900072c:	00000593          	li	a1,0
f9000730:	f8c00537          	lui	a0,0xf8c00
f9000734:	d79ff0ef          	jal	ra,f90004ac <plic_set_threshold>
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
f9000738:	00100693          	li	a3,1
f900073c:	00c00613          	li	a2,12
f9000740:	00000593          	li	a1,0
f9000744:	f8c00537          	lui	a0,0xf8c00
f9000748:	d19ff0ef          	jal	ra,f9000460 <plic_set_enable>
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
f900074c:	00100613          	li	a2,1
f9000750:	00c00593          	li	a1,12
f9000754:	f8c00537          	lui	a0,0xf8c00
f9000758:	cf9ff0ef          	jal	ra,f9000450 <plic_set_priority>
f900075c:	f80157b7          	lui	a5,0xf8015
f9000760:	00100713          	li	a4,1
f9000764:	02e7a023          	sw	a4,32(a5) # f8015020 <__freertos_irq_stack_top+0xff013c70>
    // Enable rising edge interrupts
    gpio_setInterruptRiseEnable(GPIO0, 1); 
    // Enable interrupts
    // Set the machine trap vector (../common/trap.S)
    csr_write(mtvec, trap_entry); 
f9000768:	f90017b7          	lui	a5,0xf9001
f900076c:	a0878793          	addi	a5,a5,-1528 # f9000a08 <__freertos_irq_stack_top+0xfffff658>
f9000770:	30579073          	csrw	mtvec,a5
    //Enable external interrupts
    csr_set(mie, MIE_MEIE); 
f9000774:	000017b7          	lui	a5,0x1
f9000778:	80078793          	addi	a5,a5,-2048 # 800 <__stack_size>
f900077c:	3047a073          	csrs	mie,a5
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
f9000780:	300027f3          	csrr	a5,mstatus
f9000784:	00002737          	lui	a4,0x2
f9000788:	80870713          	addi	a4,a4,-2040 # 1808 <__stack_size+0x1008>
f900078c:	00e7e7b3          	or	a5,a5,a4
f9000790:	30079073          	csrw	mstatus,a5
}
f9000794:	00c12083          	lw	ra,12(sp)
f9000798:	01010113          	addi	sp,sp,16
f900079c:	00008067          	ret

f90007a0 <main>:
*        and release various onboard buttons (sw4, sw6, sw7) corresponding to
*        different timer intervals.
*
******************************************************************************/

void main() {
f90007a0:	ff010113          	addi	sp,sp,-16
f90007a4:	00112623          	sw	ra,12(sp)
f90007a8:	00812423          	sw	s0,8(sp)
f90007ac:	00912223          	sw	s1,4(sp)
    bsp_init();
f90007b0:	c69ff0ef          	jal	ra,f9000418 <bsp_init>
    bsp_printf("***Starting GPIO Demo*** \r\n");
f90007b4:	f9001537          	lui	a0,0xf9001
f90007b8:	b5c50513          	addi	a0,a0,-1188 # f9000b5c <__freertos_irq_stack_top+0xfffff7ac>
f90007bc:	d41ff0ef          	jal	ra,f90004fc <bsp_printf>
    bsp_printf("Configure GPIOs to blink .. \r\n");
f90007c0:	f9001537          	lui	a0,0xf9001
f90007c4:	b7850513          	addi	a0,a0,-1160 # f9000b78 <__freertos_irq_stack_top+0xfffff7c8>
f90007c8:	d35ff0ef          	jal	ra,f90004fc <bsp_printf>
    // Set GPIO to output
    pinMode(GPIO_BANK0, 0, OUTPUT);
f90007cc:	00100613          	li	a2,1
f90007d0:	00000593          	li	a1,0
f90007d4:	f8015537          	lui	a0,0xf8015
f90007d8:	100000ef          	jal	ra,f90008d8 <pinMode>
    pinMode(GPIO_BANK0, 1, OUTPUT);
f90007dc:	00100613          	li	a2,1
f90007e0:	00100593          	li	a1,1
f90007e4:	f8015537          	lui	a0,0xf8015
f90007e8:	0f0000ef          	jal	ra,f90008d8 <pinMode>
    pinMode(GPIO_BANK0, 2, OUTPUT);
f90007ec:	00100613          	li	a2,1
f90007f0:	00200593          	li	a1,2
f90007f4:	f8015537          	lui	a0,0xf8015
f90007f8:	0e0000ef          	jal	ra,f90008d8 <pinMode>
    pinMode(GPIO_BANK0, 3, OUTPUT);
f90007fc:	00100613          	li	a2,1
f9000800:	00300593          	li	a1,3
f9000804:	f8015537          	lui	a0,0xf8015
f9000808:	0d0000ef          	jal	ra,f90008d8 <pinMode>
    pinMode(GPIO_BANK0, 4, OUTPUT);
f900080c:	00100613          	li	a2,1
f9000810:	00400593          	li	a1,4
f9000814:	f8015537          	lui	a0,0xf8015
f9000818:	0c0000ef          	jal	ra,f90008d8 <pinMode>
    pinMode(GPIO_BANK0, 5, OUTPUT);
f900081c:	00100613          	li	a2,1
f9000820:	00500593          	li	a1,5
f9000824:	f8015537          	lui	a0,0xf8015
f9000828:	0b0000ef          	jal	ra,f90008d8 <pinMode>

    digitalWrite(GPIO_BANK0, 0, LOW);
f900082c:	00000613          	li	a2,0
f9000830:	00000593          	li	a1,0
f9000834:	f8015537          	lui	a0,0xf8015
f9000838:	100000ef          	jal	ra,f9000938 <digitalWrite>
    digitalWrite(GPIO_BANK0, 1, LOW);
f900083c:	00000613          	li	a2,0
f9000840:	00100593          	li	a1,1
f9000844:	f8015537          	lui	a0,0xf8015
f9000848:	0f0000ef          	jal	ra,f9000938 <digitalWrite>
    digitalWrite(GPIO_BANK0, 2, LOW);
f900084c:	00000613          	li	a2,0
f9000850:	00200593          	li	a1,2
f9000854:	f8015537          	lui	a0,0xf8015
f9000858:	0e0000ef          	jal	ra,f9000938 <digitalWrite>
    digitalWrite(GPIO_BANK0, 3, LOW);
f900085c:	00000613          	li	a2,0
f9000860:	00300593          	li	a1,3
f9000864:	f8015537          	lui	a0,0xf8015
f9000868:	0d0000ef          	jal	ra,f9000938 <digitalWrite>
    digitalWrite(GPIO_BANK0, 4, LOW);
f900086c:	00000613          	li	a2,0
f9000870:	00400593          	li	a1,4
f9000874:	f8015537          	lui	a0,0xf8015
f9000878:	0c0000ef          	jal	ra,f9000938 <digitalWrite>
    digitalWrite(GPIO_BANK0, 5, LOW);
f900087c:	00000613          	li	a2,0
f9000880:	00500593          	li	a1,5
f9000884:	f8015537          	lui	a0,0xf8015
f9000888:	0b0000ef          	jal	ra,f9000938 <digitalWrite>

   while(1) {
	    digitalWrite(GPIO_BANK0, 0, HIGH);
f900088c:	00100613          	li	a2,1
f9000890:	00000593          	li	a1,0
f9000894:	f8015537          	lui	a0,0xf8015
f9000898:	0a0000ef          	jal	ra,f9000938 <digitalWrite>
        bsp_uDelay(5*LOOP_UDELAY);
f900089c:	f8b00637          	lui	a2,0xf8b00
f90008a0:	05f5e4b7          	lui	s1,0x5f5e
f90008a4:	10048593          	addi	a1,s1,256 # 5f5e100 <__stack_size+0x5f5d900>
f90008a8:	0007a437          	lui	s0,0x7a
f90008ac:	12040513          	addi	a0,s0,288 # 7a120 <__stack_size+0x79920>
f90008b0:	905ff0ef          	jal	ra,f90001b4 <clint_uDelay>
        digitalWrite(GPIO_BANK0, 0, LOW);
f90008b4:	00000613          	li	a2,0
f90008b8:	00000593          	li	a1,0
f90008bc:	f8015537          	lui	a0,0xf8015
f90008c0:	078000ef          	jal	ra,f9000938 <digitalWrite>
        bsp_uDelay(5*LOOP_UDELAY);
f90008c4:	f8b00637          	lui	a2,0xf8b00
f90008c8:	10048593          	addi	a1,s1,256
f90008cc:	12040513          	addi	a0,s0,288
f90008d0:	8e5ff0ef          	jal	ra,f90001b4 <clint_uDelay>
f90008d4:	fb9ff06f          	j	f900088c <main+0xec>

f90008d8 <pinMode>:
#include "arduinoGPIO.h"

void pinMode(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
f90008d8:	00100793          	li	a5,1
f90008dc:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
f90008e0:	02f60463          	beq	a2,a5,f9000908 <pinMode+0x30>
f90008e4:	00060863          	beqz	a2,f90008f4 <pinMode+0x1c>
f90008e8:	00200793          	li	a5,2
f90008ec:	02f60663          	beq	a2,a5,f9000918 <pinMode+0x40>
f90008f0:	00008067          	ret
        return *((volatile u32*) address);
f90008f4:	00852783          	lw	a5,8(a0) # f8015008 <__freertos_irq_stack_top+0xff013c58>
        case INPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
f90008f8:	fff5c593          	not	a1,a1
f90008fc:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
f9000900:	00b52423          	sw	a1,8(a0)
f9000904:	00008067          	ret
        return *((volatile u32*) address);
f9000908:	00852783          	lw	a5,8(a0)
            break;

        case OUTPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) | mask);
f900090c:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
f9000910:	00b52423          	sw	a1,8(a0)
f9000914:	00008067          	ret
        return *((volatile u32*) address);
f9000918:	00852703          	lw	a4,8(a0)
            break;

        case INPUT_PULLUP:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
f900091c:	fff5c793          	not	a5,a1
f9000920:	00e7f7b3          	and	a5,a5,a4
        *((volatile u32*) address) = data;
f9000924:	00f52423          	sw	a5,8(a0)
        return *((volatile u32*) address);
f9000928:	00452783          	lw	a5,4(a0)
            gpio_setOutput(bank, gpio_getOutput(bank) | mask); // Enable pull-up
f900092c:	00f5e5b3          	or	a1,a1,a5
        *((volatile u32*) address) = data;
f9000930:	00b52223          	sw	a1,4(a0)
            break;
    }
}
f9000934:	00008067          	ret

f9000938 <digitalWrite>:
        return *((volatile u32*) address);
f9000938:	00452703          	lw	a4,4(a0)

void digitalWrite(uint32_t bank, uint32_t pin, uint32_t val) {
    uint32_t current = gpio_getOutput(bank);
    uint32_t mask = 1 << pin;
f900093c:	00100793          	li	a5,1
f9000940:	00b795b3          	sll	a1,a5,a1

    if(val == HIGH) {
f9000944:	00f60a63          	beq	a2,a5,f9000958 <digitalWrite+0x20>
        gpio_setOutput(bank, current | mask);
    } else {
        gpio_setOutput(bank, current & ~mask);
f9000948:	fff5c593          	not	a1,a1
f900094c:	00e5f5b3          	and	a1,a1,a4
        *((volatile u32*) address) = data;
f9000950:	00b52223          	sw	a1,4(a0)
    }
}
f9000954:	00008067          	ret
        gpio_setOutput(bank, current | mask);
f9000958:	00e5e5b3          	or	a1,a1,a4
f900095c:	00b52223          	sw	a1,4(a0)
f9000960:	00008067          	ret

f9000964 <digitalRead>:
        return *((volatile u32*) address);
f9000964:	00052503          	lw	a0,0(a0)

uint32_t digitalRead(uint32_t bank, uint32_t pin) {
    uint32_t value = gpio_getInput(bank);
    return (value >> pin) & 0x1;
f9000968:	00b55533          	srl	a0,a0,a1
}
f900096c:	00157513          	andi	a0,a0,1
f9000970:	00008067          	ret

f9000974 <attachInterrupt>:

void attachInterrupt(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;
f9000974:	00100793          	li	a5,1
f9000978:	00b795b3          	sll	a1,a5,a1

    switch(mode) {
f900097c:	00200793          	li	a5,2
f9000980:	02f60c63          	beq	a2,a5,f90009b8 <attachInterrupt+0x44>
f9000984:	00c7fe63          	bgeu	a5,a2,f90009a0 <attachInterrupt+0x2c>
f9000988:	00300793          	li	a5,3
f900098c:	02f60a63          	beq	a2,a5,f90009c0 <attachInterrupt+0x4c>
f9000990:	00400793          	li	a5,4
f9000994:	02f61063          	bne	a2,a5,f90009b4 <attachInterrupt+0x40>
        *((volatile u32*) address) = data;
f9000998:	02b52623          	sw	a1,44(a0)

        case LOW_LEVEL:
            gpio_setInterruptLowEnable(bank, mask);
            break;
    }
}
f900099c:	00008067          	ret
    switch(mode) {
f90009a0:	00100793          	li	a5,1
f90009a4:	00f61663          	bne	a2,a5,f90009b0 <attachInterrupt+0x3c>
f90009a8:	02b52023          	sw	a1,32(a0)
f90009ac:	00008067          	ret
f90009b0:	00008067          	ret
f90009b4:	00008067          	ret
f90009b8:	02b52223          	sw	a1,36(a0)
f90009bc:	00008067          	ret
f90009c0:	02b52423          	sw	a1,40(a0)
f90009c4:	00008067          	ret

f90009c8 <detachInterrupt>:

void detachInterrupt(uint32_t bank, uint32_t pin) {
    uint32_t mask = 1 << pin;
f90009c8:	00100793          	li	a5,1
f90009cc:	00b795b3          	sll	a1,a5,a1
        return *((volatile u32*) address);
f90009d0:	00052783          	lw	a5,0(a0)

    // Disable all interrupt modes for this pin
    gpio_setInterruptRiseEnable(bank, gpio_getInput(bank) & ~mask);
f90009d4:	fff5c593          	not	a1,a1
f90009d8:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
f90009dc:	02f52023          	sw	a5,32(a0)
        return *((volatile u32*) address);
f90009e0:	00052783          	lw	a5,0(a0)
    gpio_setInterruptFallEnable(bank, gpio_getInput(bank) & ~mask);
f90009e4:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
f90009e8:	02f52223          	sw	a5,36(a0)
        return *((volatile u32*) address);
f90009ec:	00052783          	lw	a5,0(a0)
    gpio_setInterruptHighEnable(bank, gpio_getInput(bank) & ~mask);
f90009f0:	00f5f7b3          	and	a5,a1,a5
        *((volatile u32*) address) = data;
f90009f4:	02f52423          	sw	a5,40(a0)
        return *((volatile u32*) address);
f90009f8:	00052783          	lw	a5,0(a0)
    gpio_setInterruptLowEnable(bank, gpio_getInput(bank) & ~mask);
f90009fc:	00f5f5b3          	and	a1,a1,a5
        *((volatile u32*) address) = data;
f9000a00:	02b52623          	sw	a1,44(a0)
}
f9000a04:	00008067          	ret

f9000a08 <trap_entry>:
.global  trap_entry
.align(2) //mtvec require 32 bits allignement
trap_entry:
  addi sp,sp, -16*4
f9000a08:	fc010113          	addi	sp,sp,-64
  sw x1,   0*4(sp)
f9000a0c:	00112023          	sw	ra,0(sp)
  sw x5,   1*4(sp)
f9000a10:	00512223          	sw	t0,4(sp)
  sw x6,   2*4(sp)
f9000a14:	00612423          	sw	t1,8(sp)
  sw x7,   3*4(sp)
f9000a18:	00712623          	sw	t2,12(sp)
  sw x10,  4*4(sp)
f9000a1c:	00a12823          	sw	a0,16(sp)
  sw x11,  5*4(sp)
f9000a20:	00b12a23          	sw	a1,20(sp)
  sw x12,  6*4(sp)
f9000a24:	00c12c23          	sw	a2,24(sp)
  sw x13,  7*4(sp)
f9000a28:	00d12e23          	sw	a3,28(sp)
  sw x14,  8*4(sp)
f9000a2c:	02e12023          	sw	a4,32(sp)
  sw x15,  9*4(sp)
f9000a30:	02f12223          	sw	a5,36(sp)
  sw x16, 10*4(sp)
f9000a34:	03012423          	sw	a6,40(sp)
  sw x17, 11*4(sp)
f9000a38:	03112623          	sw	a7,44(sp)
  sw x28, 12*4(sp)
f9000a3c:	03c12823          	sw	t3,48(sp)
  sw x29, 13*4(sp)
f9000a40:	03d12a23          	sw	t4,52(sp)
  sw x30, 14*4(sp)
f9000a44:	03e12c23          	sw	t5,56(sp)
  sw x31, 15*4(sp)
f9000a48:	03f12e23          	sw	t6,60(sp)
  call trap
f9000a4c:	ca1ff0ef          	jal	ra,f90006ec <trap>
  lw x1 ,  0*4(sp)
f9000a50:	00012083          	lw	ra,0(sp)
  lw x5,   1*4(sp)
f9000a54:	00412283          	lw	t0,4(sp)
  lw x6,   2*4(sp)
f9000a58:	00812303          	lw	t1,8(sp)
  lw x7,   3*4(sp)
f9000a5c:	00c12383          	lw	t2,12(sp)
  lw x10,  4*4(sp)
f9000a60:	01012503          	lw	a0,16(sp)
  lw x11,  5*4(sp)
f9000a64:	01412583          	lw	a1,20(sp)
  lw x12,  6*4(sp)
f9000a68:	01812603          	lw	a2,24(sp)
  lw x13,  7*4(sp)
f9000a6c:	01c12683          	lw	a3,28(sp)
  lw x14,  8*4(sp)
f9000a70:	02012703          	lw	a4,32(sp)
  lw x15,  9*4(sp)
f9000a74:	02412783          	lw	a5,36(sp)
  lw x16, 10*4(sp)
f9000a78:	02812803          	lw	a6,40(sp)
  lw x17, 11*4(sp)
f9000a7c:	02c12883          	lw	a7,44(sp)
  lw x28, 12*4(sp)
f9000a80:	03012e03          	lw	t3,48(sp)
  lw x29, 13*4(sp)
f9000a84:	03412e83          	lw	t4,52(sp)
  lw x30, 14*4(sp)
f9000a88:	03812f03          	lw	t5,56(sp)
  lw x31, 15*4(sp)
f9000a8c:	03c12f83          	lw	t6,60(sp)
  addi sp,sp, 16*4
f9000a90:	04010113          	addi	sp,sp,64
  mret
f9000a94:	30200073          	mret
