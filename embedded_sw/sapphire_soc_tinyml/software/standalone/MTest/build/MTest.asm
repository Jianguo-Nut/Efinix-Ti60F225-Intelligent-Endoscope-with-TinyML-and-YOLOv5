
build/MTest.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00002197          	auipc	gp,0x2
f9000004:	1c818193          	addi	gp,gp,456 # f90021c8 <__global_pointer$>

f9000008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
f9000008:	92818113          	addi	sp,gp,-1752 # f9001af0 <_sp>

	/* Load data section */
	la a0, _data_lma
f900000c:	00001517          	auipc	a0,0x1
f9000010:	5f850513          	addi	a0,a0,1528 # f9001604 <_data>
	la a1, _data
f9000014:	00001597          	auipc	a1,0x1
f9000018:	5f058593          	addi	a1,a1,1520 # f9001604 <_data>
	la a2, _edata
f900001c:	81c18613          	addi	a2,gp,-2020 # f90019e4 <__bss_start>
	bgeu a1, a2, 2f
f9000020:	00c5fc63          	bgeu	a1,a2,f9000038 <init+0x30>
1:
	lw t0, (a0)
f9000024:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
f9000028:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
f900002c:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
f9000030:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
f9000034:	fec5e8e3          	bltu	a1,a2,f9000024 <init+0x1c>
2:

	/* Clear bss section */
	la a0, __bss_start
f9000038:	81c18513          	addi	a0,gp,-2020 # f90019e4 <__bss_start>
	la a1, _end
f900003c:	82018593          	addi	a1,gp,-2016 # f90019e8 <_end>
	bgeu a0, a1, 2f
f9000040:	00b57863          	bgeu	a0,a1,f9000050 <init+0x48>
1:
	sw zero, (a0)
f9000044:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
f9000048:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
f900004c:	feb56ce3          	bltu	a0,a1,f9000044 <init+0x3c>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
f9000050:	444010ef          	jal	ra,f9001494 <__libc_init_array>
#endif

	call main
f9000054:	374010ef          	jal	ra,f90013c8 <main>

f9000058 <mainDone>:
mainDone:
    j mainDone
f9000058:	0000006f          	j	f9000058 <mainDone>

f900005c <_init>:


	.globl _init
_init:
    ret
f900005c:	00008067          	ret

Disassembly of section .text:

f9000060 <uart_writeAvailability>:
#include "type.h"
#include "soc.h"


    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
f9000060:	00452503          	lw	a0,4(a0)
        enum UartStop stop;
        u32 clockDivider;
    } Uart_Config;
    
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
f9000064:	01055513          	srli	a0,a0,0x10
    }
f9000068:	0ff57513          	andi	a0,a0,255
f900006c:	00008067          	ret

f9000070 <uart_write>:
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
    
    static void uart_write(u32 reg, char data){
f9000070:	ff010113          	addi	sp,sp,-16
f9000074:	00112623          	sw	ra,12(sp)
f9000078:	00812423          	sw	s0,8(sp)
f900007c:	00912223          	sw	s1,4(sp)
f9000080:	00050413          	mv	s0,a0
f9000084:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
f9000088:	00040513          	mv	a0,s0
f900008c:	fd5ff0ef          	jal	ra,f9000060 <uart_writeAvailability>
f9000090:	fe050ce3          	beqz	a0,f9000088 <uart_write+0x18>
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f9000094:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
f9000098:	00c12083          	lw	ra,12(sp)
f900009c:	00812403          	lw	s0,8(sp)
f90000a0:	00412483          	lw	s1,4(sp)
f90000a4:	01010113          	addi	sp,sp,16
f90000a8:	00008067          	ret

f90000ac <_putchar>:
// use bsp_printf_full as bsp_printf
#define ENABLE_BRIDGE_FULL_TO_LITE          1 // If this is enabled, bsp_printf_full can be called with bsp_printf. Enabling both ENABLE_BSP_PRINTF and ENABLE_BSP_PRINTF_FULL, bsp_printf_full will be remained as bsp_printf_full. Default: Enable
#define ENABLE_PRINTF_WARNING               1 // Print warning when the specifier not supported. Default: Enable


    static void _putchar(char character){
f90000ac:	ff010113          	addi	sp,sp,-16
f90000b0:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
f90000b4:	00050593          	mv	a1,a0
f90000b8:	f8010537          	lui	a0,0xf8010
f90000bc:	fb5ff0ef          	jal	ra,f9000070 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f90000c0:	00c12083          	lw	ra,12(sp)
f90000c4:	01010113          	addi	sp,sp,16
f90000c8:	00008067          	ret

f90000cc <_putchar_s>:

    static void _putchar_s(char *p)
    {
f90000cc:	ff010113          	addi	sp,sp,-16
f90000d0:	00112623          	sw	ra,12(sp)
f90000d4:	00812423          	sw	s0,8(sp)
f90000d8:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
f90000dc:	00044503          	lbu	a0,0(s0)
f90000e0:	00050863          	beqz	a0,f90000f0 <_putchar_s+0x24>
            _putchar(*(p++));
f90000e4:	00140413          	addi	s0,s0,1
f90000e8:	fc5ff0ef          	jal	ra,f90000ac <_putchar>
f90000ec:	ff1ff06f          	j	f90000dc <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
f90000f0:	00c12083          	lw	ra,12(sp)
f90000f4:	00812403          	lw	s0,8(sp)
f90000f8:	01010113          	addi	sp,sp,16
f90000fc:	00008067          	ret

f9000100 <bsp_printHex>:


    //bsp_printHex is used in BSP_PRINTF
    static void bsp_printHex(uint32_t val)
    {
f9000100:	ff010113          	addi	sp,sp,-16
f9000104:	00112623          	sw	ra,12(sp)
f9000108:	00812423          	sw	s0,8(sp)
f900010c:	00912223          	sw	s1,4(sp)
f9000110:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000114:	01c00413          	li	s0,28
f9000118:	0240006f          	j	f900013c <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
f900011c:	0084d7b3          	srl	a5,s1,s0
f9000120:	00f7f713          	andi	a4,a5,15
f9000124:	f90017b7          	lui	a5,0xf9001
f9000128:	79878793          	addi	a5,a5,1944 # f9001798 <__global_pointer$+0xfffff5d0>
f900012c:	00e787b3          	add	a5,a5,a4
f9000130:	0007c503          	lbu	a0,0(a5)
f9000134:	f79ff0ef          	jal	ra,f90000ac <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000138:	ffc40413          	addi	s0,s0,-4
f900013c:	fe0450e3          	bgez	s0,f900011c <bsp_printHex+0x1c>
        }
    }
f9000140:	00c12083          	lw	ra,12(sp)
f9000144:	00812403          	lw	s0,8(sp)
f9000148:	00412483          	lw	s1,4(sp)
f900014c:	01010113          	addi	sp,sp,16
f9000150:	00008067          	ret

f9000154 <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
        {
f9000154:	ff010113          	addi	sp,sp,-16
f9000158:	00112623          	sw	ra,12(sp)
f900015c:	00812423          	sw	s0,8(sp)
f9000160:	00912223          	sw	s1,4(sp)
f9000164:	00050493          	mv	s1,a0
            uint32_t digits;
            digits =8;

            for (int i = (4*digits)-4; i >= 0; i -= 4) {
f9000168:	01c00413          	li	s0,28
f900016c:	0240006f          	j	f9000190 <bsp_printHex_lower+0x3c>
                _putchar("0123456789abcdef"[(val >> i) % 16]);
f9000170:	0084d7b3          	srl	a5,s1,s0
f9000174:	00f7f713          	andi	a4,a5,15
f9000178:	f90017b7          	lui	a5,0xf9001
f900017c:	7ac78793          	addi	a5,a5,1964 # f90017ac <__global_pointer$+0xfffff5e4>
f9000180:	00e787b3          	add	a5,a5,a4
f9000184:	0007c503          	lbu	a0,0(a5)
f9000188:	f25ff0ef          	jal	ra,f90000ac <_putchar>
            for (int i = (4*digits)-4; i >= 0; i -= 4) {
f900018c:	ffc40413          	addi	s0,s0,-4
f9000190:	fe0450e3          	bgez	s0,f9000170 <bsp_printHex_lower+0x1c>

            }
        }
f9000194:	00c12083          	lw	ra,12(sp)
f9000198:	00812403          	lw	s0,8(sp)
f900019c:	00412483          	lw	s1,4(sp)
f90001a0:	01010113          	addi	sp,sp,16
f90001a4:	00008067          	ret

f90001a8 <_out_null>:

// internal null output
static inline void _out_null(char character, void* buffer, size_t idx, size_t maxlen)
{
  (void)character; (void)buffer; (void)idx; (void)maxlen;
}
f90001a8:	00008067          	ret

f90001ac <_out_char>:

// internal _putchar wrapper
static inline void _out_char(char character, void* buffer, size_t idx, size_t maxlen)
{
  (void)buffer; (void)idx; (void)maxlen;
  if (character) {
f90001ac:	00051463          	bnez	a0,f90001b4 <_out_char+0x8>
f90001b0:	00008067          	ret
{
f90001b4:	ff010113          	addi	sp,sp,-16
f90001b8:	00112623          	sw	ra,12(sp)
    _putchar(character);
f90001bc:	ef1ff0ef          	jal	ra,f90000ac <_putchar>
  }
}
f90001c0:	00c12083          	lw	ra,12(sp)
f90001c4:	01010113          	addi	sp,sp,16
f90001c8:	00008067          	ret

f90001cc <_atoi>:


// internal ASCII string to unsigned int conversion
static unsigned int _atoi(const char** str)
{
  unsigned int i = 0U;
f90001cc:	00000793          	li	a5,0
  while (_is_digit(**str)) {
f90001d0:	00052683          	lw	a3,0(a0) # f8010000 <__global_pointer$+0xff00de38>
f90001d4:	0006c703          	lbu	a4,0(a3)
  return (ch >= '0') && (ch <= '9');
f90001d8:	fd070713          	addi	a4,a4,-48
f90001dc:	0ff77713          	andi	a4,a4,255
  while (_is_digit(**str)) {
f90001e0:	00900613          	li	a2,9
f90001e4:	02e66463          	bltu	a2,a4,f900020c <_atoi+0x40>
    i = i * 10U + (unsigned int)(*((*str)++) - '0');
f90001e8:	00279713          	slli	a4,a5,0x2
f90001ec:	00f707b3          	add	a5,a4,a5
f90001f0:	00179713          	slli	a4,a5,0x1
f90001f4:	00168793          	addi	a5,a3,1
f90001f8:	00f52023          	sw	a5,0(a0)
f90001fc:	0006c783          	lbu	a5,0(a3)
f9000200:	00e787b3          	add	a5,a5,a4
f9000204:	fd078793          	addi	a5,a5,-48
f9000208:	fc9ff06f          	j	f90001d0 <_atoi+0x4>
  }
  return i;
}
f900020c:	00078513          	mv	a0,a5
f9000210:	00008067          	ret

f9000214 <_out_rev>:

// output the specified string in reverse, taking care of any zero-padding
static size_t _out_rev(out_fct_type out, char* buffer, size_t idx, size_t maxlen, const char* buf, size_t len, unsigned int width, unsigned int flags)
{
f9000214:	fd010113          	addi	sp,sp,-48
f9000218:	02112623          	sw	ra,44(sp)
f900021c:	02812423          	sw	s0,40(sp)
f9000220:	02912223          	sw	s1,36(sp)
f9000224:	03212023          	sw	s2,32(sp)
f9000228:	01312e23          	sw	s3,28(sp)
f900022c:	01412c23          	sw	s4,24(sp)
f9000230:	01512a23          	sw	s5,20(sp)
f9000234:	01612823          	sw	s6,16(sp)
f9000238:	01712623          	sw	s7,12(sp)
f900023c:	01812423          	sw	s8,8(sp)
f9000240:	01912223          	sw	s9,4(sp)
f9000244:	00050493          	mv	s1,a0
f9000248:	00058913          	mv	s2,a1
f900024c:	00060b93          	mv	s7,a2
f9000250:	00068993          	mv	s3,a3
f9000254:	00070b13          	mv	s6,a4
f9000258:	00078413          	mv	s0,a5
f900025c:	00080a93          	mv	s5,a6
f9000260:	00088c13          	mv	s8,a7
  const size_t start_idx = idx;

  // pad spaces up to given width
  if (!(flags & FLAGS_LEFT) && !(flags & FLAGS_ZEROPAD)) {
f9000264:	0038f793          	andi	a5,a7,3
f9000268:	02078663          	beqz	a5,f9000294 <_out_rev+0x80>
      out(' ', buffer, idx++, maxlen);
    }
  }

  // reverse string
  while (len) {
f900026c:	04040863          	beqz	s0,f90002bc <_out_rev+0xa8>
    out(buf[--len], buffer, idx++, maxlen);
f9000270:	fff40413          	addi	s0,s0,-1
f9000274:	008b07b3          	add	a5,s6,s0
f9000278:	00160a13          	addi	s4,a2,1
f900027c:	00098693          	mv	a3,s3
f9000280:	00090593          	mv	a1,s2
f9000284:	0007c503          	lbu	a0,0(a5)
f9000288:	000480e7          	jalr	s1
f900028c:	000a0613          	mv	a2,s4
f9000290:	fddff06f          	j	f900026c <_out_rev+0x58>
    for (size_t i = len; i < width; i++) {
f9000294:	00040a13          	mv	s4,s0
f9000298:	fd5a7ae3          	bgeu	s4,s5,f900026c <_out_rev+0x58>
      out(' ', buffer, idx++, maxlen);
f900029c:	00160c93          	addi	s9,a2,1
f90002a0:	00098693          	mv	a3,s3
f90002a4:	00090593          	mv	a1,s2
f90002a8:	02000513          	li	a0,32
f90002ac:	000480e7          	jalr	s1
    for (size_t i = len; i < width; i++) {
f90002b0:	001a0a13          	addi	s4,s4,1
      out(' ', buffer, idx++, maxlen);
f90002b4:	000c8613          	mv	a2,s9
f90002b8:	fe1ff06f          	j	f9000298 <_out_rev+0x84>
  }

  // append pad spaces up to given width
  if (flags & FLAGS_LEFT) {
f90002bc:	002c7c13          	andi	s8,s8,2
f90002c0:	020c1e63          	bnez	s8,f90002fc <_out_rev+0xe8>
      out(' ', buffer, idx++, maxlen);
    }
  }

  return idx;
}
f90002c4:	00060513          	mv	a0,a2
f90002c8:	02c12083          	lw	ra,44(sp)
f90002cc:	02812403          	lw	s0,40(sp)
f90002d0:	02412483          	lw	s1,36(sp)
f90002d4:	02012903          	lw	s2,32(sp)
f90002d8:	01c12983          	lw	s3,28(sp)
f90002dc:	01812a03          	lw	s4,24(sp)
f90002e0:	01412a83          	lw	s5,20(sp)
f90002e4:	01012b03          	lw	s6,16(sp)
f90002e8:	00c12b83          	lw	s7,12(sp)
f90002ec:	00812c03          	lw	s8,8(sp)
f90002f0:	00412c83          	lw	s9,4(sp)
f90002f4:	03010113          	addi	sp,sp,48
f90002f8:	00008067          	ret
    while (idx - start_idx < width) {
f90002fc:	417607b3          	sub	a5,a2,s7
f9000300:	fd57f2e3          	bgeu	a5,s5,f90002c4 <_out_rev+0xb0>
      out(' ', buffer, idx++, maxlen);
f9000304:	00160413          	addi	s0,a2,1
f9000308:	00098693          	mv	a3,s3
f900030c:	00090593          	mv	a1,s2
f9000310:	02000513          	li	a0,32
f9000314:	000480e7          	jalr	s1
f9000318:	00040613          	mv	a2,s0
f900031c:	fe1ff06f          	j	f90002fc <_out_rev+0xe8>

f9000320 <_ntoa_format>:


// internal itoa format
static size_t _ntoa_format(out_fct_type out, char* buffer, size_t idx, size_t maxlen, char* buf, size_t len, bool negative, unsigned int base, unsigned int prec, unsigned int width, unsigned int flags)
{
f9000320:	ff010113          	addi	sp,sp,-16
f9000324:	00112623          	sw	ra,12(sp)
f9000328:	00080f93          	mv	t6,a6
f900032c:	00088f13          	mv	t5,a7
f9000330:	01012e83          	lw	t4,16(sp)
f9000334:	01412803          	lw	a6,20(sp)
f9000338:	01812883          	lw	a7,24(sp)
  // pad leading zeros
  if (!(flags & FLAGS_LEFT)) {
f900033c:	0028f313          	andi	t1,a7,2
f9000340:	06031263          	bnez	t1,f90003a4 <_ntoa_format+0x84>
    if (width && (flags & FLAGS_ZEROPAD) && (negative || (flags & (FLAGS_PLUS | FLAGS_SPACE)))) {
f9000344:	00080e63          	beqz	a6,f9000360 <_ntoa_format+0x40>
f9000348:	0018f313          	andi	t1,a7,1
f900034c:	00030a63          	beqz	t1,f9000360 <_ntoa_format+0x40>
f9000350:	000f9663          	bnez	t6,f900035c <_ntoa_format+0x3c>
f9000354:	00c8f313          	andi	t1,a7,12
f9000358:	00030463          	beqz	t1,f9000360 <_ntoa_format+0x40>
      width--;
f900035c:	fff80813          	addi	a6,a6,-1
    }
    while ((len < prec) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000360:	03d7f863          	bgeu	a5,t4,f9000390 <_ntoa_format+0x70>
f9000364:	01f00313          	li	t1,31
f9000368:	02f36463          	bltu	t1,a5,f9000390 <_ntoa_format+0x70>
      buf[len++] = '0';
f900036c:	00f70333          	add	t1,a4,a5
f9000370:	03000e13          	li	t3,48
f9000374:	01c30023          	sb	t3,0(t1)
f9000378:	00178793          	addi	a5,a5,1
f900037c:	fe5ff06f          	j	f9000360 <_ntoa_format+0x40>
    }
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
      buf[len++] = '0';
f9000380:	00f70333          	add	t1,a4,a5
f9000384:	03000e13          	li	t3,48
f9000388:	01c30023          	sb	t3,0(t1)
f900038c:	00178793          	addi	a5,a5,1
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000390:	0018f313          	andi	t1,a7,1
f9000394:	00030863          	beqz	t1,f90003a4 <_ntoa_format+0x84>
f9000398:	0107f663          	bgeu	a5,a6,f90003a4 <_ntoa_format+0x84>
f900039c:	01f00313          	li	t1,31
f90003a0:	fef370e3          	bgeu	t1,a5,f9000380 <_ntoa_format+0x60>
    }
  }

  // handle hash
  if (flags & FLAGS_HASH) {
f90003a4:	0108f313          	andi	t1,a7,16
f90003a8:	04030463          	beqz	t1,f90003f0 <_ntoa_format+0xd0>
    if (!(flags & FLAGS_PRECISION) && len && ((len == prec) || (len == width))) {
f90003ac:	4008f313          	andi	t1,a7,1024
f90003b0:	00031863          	bnez	t1,f90003c0 <_ntoa_format+0xa0>
f90003b4:	00078663          	beqz	a5,f90003c0 <_ntoa_format+0xa0>
f90003b8:	07d78263          	beq	a5,t4,f900041c <_ntoa_format+0xfc>
f90003bc:	07078063          	beq	a5,a6,f900041c <_ntoa_format+0xfc>
      len--;
      if (len && (base == 16U)) {
        len--;
      }
    }
    if ((base == 16U) && !(flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90003c0:	01000313          	li	t1,16
f90003c4:	086f0063          	beq	t5,t1,f9000444 <_ntoa_format+0x124>
      buf[len++] = 'x';
    }
    else if ((base == 16U) && (flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90003c8:	01000313          	li	t1,16
f90003cc:	086f0e63          	beq	t5,t1,f9000468 <_ntoa_format+0x148>
      buf[len++] = 'X';
    }
    else if ((base == 2U) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f90003d0:	00200313          	li	t1,2
f90003d4:	0a6f0c63          	beq	t5,t1,f900048c <_ntoa_format+0x16c>
      buf[len++] = 'b';
    }
    if (len < PRINTF_NTOA_BUFFER_SIZE) {
f90003d8:	01f00313          	li	t1,31
f90003dc:	00f36a63          	bltu	t1,a5,f90003f0 <_ntoa_format+0xd0>
      buf[len++] = '0';
f90003e0:	00f70333          	add	t1,a4,a5
f90003e4:	03000e13          	li	t3,48
f90003e8:	01c30023          	sb	t3,0(t1)
f90003ec:	00178793          	addi	a5,a5,1
    }
  }

  if (len < PRINTF_NTOA_BUFFER_SIZE) {
f90003f0:	01f00313          	li	t1,31
f90003f4:	00f36c63          	bltu	t1,a5,f900040c <_ntoa_format+0xec>
    if (negative) {
f90003f8:	0a0f8863          	beqz	t6,f90004a8 <_ntoa_format+0x188>
      buf[len++] = '-';
f90003fc:	00f70333          	add	t1,a4,a5
f9000400:	02d00e13          	li	t3,45
f9000404:	01c30023          	sb	t3,0(t1)
f9000408:	00178793          	addi	a5,a5,1
    else if (flags & FLAGS_SPACE) {
      buf[len++] = ' ';
    }
  }

  return _out_rev(out, buffer, idx, maxlen, buf, len, width, flags);
f900040c:	e09ff0ef          	jal	ra,f9000214 <_out_rev>
}
f9000410:	00c12083          	lw	ra,12(sp)
f9000414:	01010113          	addi	sp,sp,16
f9000418:	00008067          	ret
      len--;
f900041c:	fff78313          	addi	t1,a5,-1
      if (len && (base == 16U)) {
f9000420:	00030e63          	beqz	t1,f900043c <_ntoa_format+0x11c>
f9000424:	01000e13          	li	t3,16
f9000428:	01cf0663          	beq	t5,t3,f9000434 <_ntoa_format+0x114>
      len--;
f900042c:	00030793          	mv	a5,t1
f9000430:	f91ff06f          	j	f90003c0 <_ntoa_format+0xa0>
        len--;
f9000434:	ffe78793          	addi	a5,a5,-2
f9000438:	f89ff06f          	j	f90003c0 <_ntoa_format+0xa0>
      len--;
f900043c:	00030793          	mv	a5,t1
f9000440:	f81ff06f          	j	f90003c0 <_ntoa_format+0xa0>
    if ((base == 16U) && !(flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000444:	0208f313          	andi	t1,a7,32
f9000448:	f80310e3          	bnez	t1,f90003c8 <_ntoa_format+0xa8>
f900044c:	01f00313          	li	t1,31
f9000450:	f6f36ce3          	bltu	t1,a5,f90003c8 <_ntoa_format+0xa8>
      buf[len++] = 'x';
f9000454:	00f70333          	add	t1,a4,a5
f9000458:	07800e13          	li	t3,120
f900045c:	01c30023          	sb	t3,0(t1)
f9000460:	00178793          	addi	a5,a5,1
f9000464:	f75ff06f          	j	f90003d8 <_ntoa_format+0xb8>
    else if ((base == 16U) && (flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f9000468:	0208f313          	andi	t1,a7,32
f900046c:	f60302e3          	beqz	t1,f90003d0 <_ntoa_format+0xb0>
f9000470:	01f00313          	li	t1,31
f9000474:	f4f36ee3          	bltu	t1,a5,f90003d0 <_ntoa_format+0xb0>
      buf[len++] = 'X';
f9000478:	00f70333          	add	t1,a4,a5
f900047c:	05800e13          	li	t3,88
f9000480:	01c30023          	sb	t3,0(t1)
f9000484:	00178793          	addi	a5,a5,1
f9000488:	f51ff06f          	j	f90003d8 <_ntoa_format+0xb8>
    else if ((base == 2U) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
f900048c:	01f00313          	li	t1,31
f9000490:	f4f364e3          	bltu	t1,a5,f90003d8 <_ntoa_format+0xb8>
      buf[len++] = 'b';
f9000494:	00f70333          	add	t1,a4,a5
f9000498:	06200e13          	li	t3,98
f900049c:	01c30023          	sb	t3,0(t1)
f90004a0:	00178793          	addi	a5,a5,1
f90004a4:	f35ff06f          	j	f90003d8 <_ntoa_format+0xb8>
    else if (flags & FLAGS_PLUS) {
f90004a8:	0048f313          	andi	t1,a7,4
f90004ac:	00030c63          	beqz	t1,f90004c4 <_ntoa_format+0x1a4>
      buf[len++] = '+';  // ignore the space if the '+' exists
f90004b0:	00f70333          	add	t1,a4,a5
f90004b4:	02b00e13          	li	t3,43
f90004b8:	01c30023          	sb	t3,0(t1)
f90004bc:	00178793          	addi	a5,a5,1
f90004c0:	f4dff06f          	j	f900040c <_ntoa_format+0xec>
    else if (flags & FLAGS_SPACE) {
f90004c4:	0088f313          	andi	t1,a7,8
f90004c8:	f40302e3          	beqz	t1,f900040c <_ntoa_format+0xec>
      buf[len++] = ' ';
f90004cc:	00f70333          	add	t1,a4,a5
f90004d0:	02000e13          	li	t3,32
f90004d4:	01c30023          	sb	t3,0(t1)
f90004d8:	00178793          	addi	a5,a5,1
f90004dc:	f31ff06f          	j	f900040c <_ntoa_format+0xec>

f90004e0 <_ntoa_long>:


// internal itoa for 'long' type
static size_t _ntoa_long(out_fct_type out, char* buffer, size_t idx, size_t maxlen, unsigned long value, bool negative, unsigned long base, unsigned int prec, unsigned int width, unsigned int flags)
{
f90004e0:	fc010113          	addi	sp,sp,-64
f90004e4:	02112e23          	sw	ra,60(sp)
f90004e8:	00078f93          	mv	t6,a5
f90004ec:	04412f03          	lw	t5,68(sp)
  char buf[PRINTF_NTOA_BUFFER_SIZE];
  size_t len = 0U;

  // no hash for 0 values
  if (!value) {
f90004f0:	00071463          	bnez	a4,f90004f8 <_ntoa_long+0x18>
    flags &= ~FLAGS_HASH;
f90004f4:	feff7f13          	andi	t5,t5,-17
  }

  // write if precision != 0 and value is != 0
  if (!(flags & FLAGS_PRECISION) || value) {
f90004f8:	400f7e93          	andi	t4,t5,1024
f90004fc:	040e8a63          	beqz	t4,f9000550 <_ntoa_long+0x70>
f9000500:	06070a63          	beqz	a4,f9000574 <_ntoa_long+0x94>
f9000504:	00000e93          	li	t4,0
f9000508:	0480006f          	j	f9000550 <_ntoa_long+0x70>
    do {
      const char digit = (char)(value % base);
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f900050c:	020f7313          	andi	t1,t5,32
f9000510:	04030e63          	beqz	t1,f900056c <_ntoa_long+0x8c>
f9000514:	04100313          	li	t1,65
f9000518:	01c30333          	add	t1,t1,t3
f900051c:	0ff37313          	andi	t1,t1,255
f9000520:	ff630313          	addi	t1,t1,-10
f9000524:	0ff37313          	andi	t1,t1,255
f9000528:	001e8793          	addi	a5,t4,1
f900052c:	03010e13          	addi	t3,sp,48
f9000530:	01de0eb3          	add	t4,t3,t4
f9000534:	fe6e8023          	sb	t1,-32(t4)
      value /= base;
f9000538:	03075333          	divu	t1,a4,a6
    } while (value && (len < PRINTF_NTOA_BUFFER_SIZE));
f900053c:	03076e63          	bltu	a4,a6,f9000578 <_ntoa_long+0x98>
f9000540:	01f00713          	li	a4,31
f9000544:	02f76a63          	bltu	a4,a5,f9000578 <_ntoa_long+0x98>
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f9000548:	00078e93          	mv	t4,a5
      value /= base;
f900054c:	00030713          	mv	a4,t1
      const char digit = (char)(value % base);
f9000550:	03077333          	remu	t1,a4,a6
f9000554:	0ff37e13          	andi	t3,t1,255
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
f9000558:	00900313          	li	t1,9
f900055c:	fbc368e3          	bltu	t1,t3,f900050c <_ntoa_long+0x2c>
f9000560:	030e0313          	addi	t1,t3,48
f9000564:	0ff37313          	andi	t1,t1,255
f9000568:	fc1ff06f          	j	f9000528 <_ntoa_long+0x48>
f900056c:	06100313          	li	t1,97
f9000570:	fa9ff06f          	j	f9000518 <_ntoa_long+0x38>
  size_t len = 0U;
f9000574:	00070793          	mv	a5,a4
  }

  return _ntoa_format(out, buffer, idx, maxlen, buf, len, negative, (unsigned int)base, prec, width, flags);
f9000578:	01e12423          	sw	t5,8(sp)
f900057c:	04012703          	lw	a4,64(sp)
f9000580:	00e12223          	sw	a4,4(sp)
f9000584:	01112023          	sw	a7,0(sp)
f9000588:	00080893          	mv	a7,a6
f900058c:	000f8813          	mv	a6,t6
f9000590:	01010713          	addi	a4,sp,16
f9000594:	d8dff0ef          	jal	ra,f9000320 <_ntoa_format>
}
f9000598:	03c12083          	lw	ra,60(sp)
f900059c:	04010113          	addi	sp,sp,64
f90005a0:	00008067          	ret

f90005a4 <_vsnprintf>:
#endif  // PRINTF_SUPPORT_FLOAT


// internal vsnprintf
static int _vsnprintf(out_fct_type out, char* buffer, const size_t maxlen, const char* format, va_list va)
{
f90005a4:	fa010113          	addi	sp,sp,-96
f90005a8:	04112e23          	sw	ra,92(sp)
f90005ac:	04812c23          	sw	s0,88(sp)
f90005b0:	04912a23          	sw	s1,84(sp)
f90005b4:	05212823          	sw	s2,80(sp)
f90005b8:	05312623          	sw	s3,76(sp)
f90005bc:	05412423          	sw	s4,72(sp)
f90005c0:	05512223          	sw	s5,68(sp)
f90005c4:	05612023          	sw	s6,64(sp)
f90005c8:	03712e23          	sw	s7,60(sp)
f90005cc:	03812c23          	sw	s8,56(sp)
f90005d0:	03912a23          	sw	s9,52(sp)
f90005d4:	03a12823          	sw	s10,48(sp)
f90005d8:	03b12623          	sw	s11,44(sp)
f90005dc:	00050a13          	mv	s4,a0
f90005e0:	00058993          	mv	s3,a1
f90005e4:	00060913          	mv	s2,a2
f90005e8:	00d12e23          	sw	a3,28(sp)
f90005ec:	00e12c23          	sw	a4,24(sp)
  unsigned int flags, width, precision, n;
  size_t idx = 0U;

  if (!buffer) {
f90005f0:	000586e3          	beqz	a1,f9000dfc <_vsnprintf+0x858>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
          }
        }
        format++;
        break;
f90005f4:	00000413          	li	s0,0
  while (*format)
f90005f8:	01c12783          	lw	a5,28(sp)
f90005fc:	0007c503          	lbu	a0,0(a5)
f9000600:	000504e3          	beqz	a0,f9000e08 <_vsnprintf+0x864>
    if (*format != '%') {
f9000604:	02500713          	li	a4,37
f9000608:	02e50663          	beq	a0,a4,f9000634 <_vsnprintf+0x90>
      out(*format, buffer, idx++, maxlen);
f900060c:	00140493          	addi	s1,s0,1
f9000610:	00090693          	mv	a3,s2
f9000614:	00040613          	mv	a2,s0
f9000618:	00098593          	mv	a1,s3
f900061c:	000a00e7          	jalr	s4
      format++;
f9000620:	01c12783          	lw	a5,28(sp)
f9000624:	00178793          	addi	a5,a5,1
f9000628:	00f12e23          	sw	a5,28(sp)
      out(*format, buffer, idx++, maxlen);
f900062c:	00048413          	mv	s0,s1
      continue;
f9000630:	fc9ff06f          	j	f90005f8 <_vsnprintf+0x54>
      format++;
f9000634:	00178793          	addi	a5,a5,1
f9000638:	00f12e23          	sw	a5,28(sp)
    flags = 0U;
f900063c:	00000493          	li	s1,0
f9000640:	0740006f          	j	f90006b4 <_vsnprintf+0x110>
  return (ch >= '0') && (ch <= '9');
f9000644:	fd060793          	addi	a5,a2,-48
f9000648:	0ff7f793          	andi	a5,a5,255
    if (_is_digit(*format)) {
f900064c:	00900713          	li	a4,9
f9000650:	0cf77a63          	bgeu	a4,a5,f9000724 <_vsnprintf+0x180>
    else if (*format == '*') {
f9000654:	02a00793          	li	a5,42
f9000658:	0cf60e63          	beq	a2,a5,f9000734 <_vsnprintf+0x190>
    width = 0U;
f900065c:	00000b13          	li	s6,0
    if (*format == '.') {
f9000660:	01c12783          	lw	a5,28(sp)
f9000664:	0007c683          	lbu	a3,0(a5)
f9000668:	02e00713          	li	a4,46
f900066c:	0ee68c63          	beq	a3,a4,f9000764 <_vsnprintf+0x1c0>
    precision = 0U;
f9000670:	00000a93          	li	s5,0
    switch (*format) {
f9000674:	01c12703          	lw	a4,28(sp)
f9000678:	00074783          	lbu	a5,0(a4)
f900067c:	06a00693          	li	a3,106
f9000680:	1ad78c63          	beq	a5,a3,f9000838 <_vsnprintf+0x294>
f9000684:	14f6f663          	bgeu	a3,a5,f90007d0 <_vsnprintf+0x22c>
f9000688:	06c00693          	li	a3,108
f900068c:	16d78663          	beq	a5,a3,f90007f8 <_vsnprintf+0x254>
f9000690:	07a00693          	li	a3,122
f9000694:	1ad79863          	bne	a5,a3,f9000844 <_vsnprintf+0x2a0>
        flags |= (sizeof(size_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
f9000698:	1004e493          	ori	s1,s1,256
        format++;
f900069c:	00170713          	addi	a4,a4,1
f90006a0:	00e12e23          	sw	a4,28(sp)
        break;
f90006a4:	1a00006f          	j	f9000844 <_vsnprintf+0x2a0>
        case '0': flags |= FLAGS_ZEROPAD; format++; n = 1U; break;
f90006a8:	0014e493          	ori	s1,s1,1
f90006ac:	00170713          	addi	a4,a4,1
f90006b0:	00e12e23          	sw	a4,28(sp)
      switch (*format) {
f90006b4:	01c12703          	lw	a4,28(sp)
f90006b8:	00074603          	lbu	a2,0(a4)
f90006bc:	fe060793          	addi	a5,a2,-32
f90006c0:	0ff7f593          	andi	a1,a5,255
f90006c4:	01000693          	li	a3,16
f90006c8:	f6b6eee3          	bltu	a3,a1,f9000644 <_vsnprintf+0xa0>
f90006cc:	00259793          	slli	a5,a1,0x2
f90006d0:	f90016b7          	lui	a3,0xf9001
f90006d4:	60468693          	addi	a3,a3,1540 # f9001604 <__global_pointer$+0xfffff43c>
f90006d8:	00d787b3          	add	a5,a5,a3
f90006dc:	0007a783          	lw	a5,0(a5)
f90006e0:	00078067          	jr	a5
        case '-': flags |= FLAGS_LEFT;    format++; n = 1U; break;
f90006e4:	0024e493          	ori	s1,s1,2
f90006e8:	00170713          	addi	a4,a4,1
f90006ec:	00e12e23          	sw	a4,28(sp)
f90006f0:	fc5ff06f          	j	f90006b4 <_vsnprintf+0x110>
        case '+': flags |= FLAGS_PLUS;    format++; n = 1U; break;
f90006f4:	0044e493          	ori	s1,s1,4
f90006f8:	00170713          	addi	a4,a4,1
f90006fc:	00e12e23          	sw	a4,28(sp)
f9000700:	fb5ff06f          	j	f90006b4 <_vsnprintf+0x110>
        case ' ': flags |= FLAGS_SPACE;   format++; n = 1U; break;
f9000704:	0084e493          	ori	s1,s1,8
f9000708:	00170713          	addi	a4,a4,1
f900070c:	00e12e23          	sw	a4,28(sp)
f9000710:	fa5ff06f          	j	f90006b4 <_vsnprintf+0x110>
        case '#': flags |= FLAGS_HASH;    format++; n = 1U; break;
f9000714:	0104e493          	ori	s1,s1,16
f9000718:	00170713          	addi	a4,a4,1
f900071c:	00e12e23          	sw	a4,28(sp)
f9000720:	f95ff06f          	j	f90006b4 <_vsnprintf+0x110>
      width = _atoi(&format);
f9000724:	01c10513          	addi	a0,sp,28
f9000728:	aa5ff0ef          	jal	ra,f90001cc <_atoi>
f900072c:	00050b13          	mv	s6,a0
f9000730:	f31ff06f          	j	f9000660 <_vsnprintf+0xbc>
      const int w = va_arg(va, int);
f9000734:	01812783          	lw	a5,24(sp)
f9000738:	00478713          	addi	a4,a5,4
f900073c:	00e12c23          	sw	a4,24(sp)
f9000740:	0007ab03          	lw	s6,0(a5)
      if (w < 0) {
f9000744:	000b4a63          	bltz	s6,f9000758 <_vsnprintf+0x1b4>
      format++;
f9000748:	01c12783          	lw	a5,28(sp)
f900074c:	00178793          	addi	a5,a5,1
f9000750:	00f12e23          	sw	a5,28(sp)
f9000754:	f0dff06f          	j	f9000660 <_vsnprintf+0xbc>
        flags |= FLAGS_LEFT;    // reverse padding
f9000758:	0024e493          	ori	s1,s1,2
        width = (unsigned int)-w;
f900075c:	41600b33          	neg	s6,s6
f9000760:	fe9ff06f          	j	f9000748 <_vsnprintf+0x1a4>
      flags |= FLAGS_PRECISION;
f9000764:	4004e493          	ori	s1,s1,1024
      format++;
f9000768:	00178713          	addi	a4,a5,1
f900076c:	00e12e23          	sw	a4,28(sp)
      if (_is_digit(*format)) {
f9000770:	0017c703          	lbu	a4,1(a5)
  return (ch >= '0') && (ch <= '9');
f9000774:	fd070793          	addi	a5,a4,-48
f9000778:	0ff7f793          	andi	a5,a5,255
      if (_is_digit(*format)) {
f900077c:	00900693          	li	a3,9
f9000780:	00f6fa63          	bgeu	a3,a5,f9000794 <_vsnprintf+0x1f0>
      else if (*format == '*') {
f9000784:	02a00793          	li	a5,42
f9000788:	00f70e63          	beq	a4,a5,f90007a4 <_vsnprintf+0x200>
    precision = 0U;
f900078c:	00000a93          	li	s5,0
f9000790:	ee5ff06f          	j	f9000674 <_vsnprintf+0xd0>
        precision = _atoi(&format);
f9000794:	01c10513          	addi	a0,sp,28
f9000798:	a35ff0ef          	jal	ra,f90001cc <_atoi>
f900079c:	00050a93          	mv	s5,a0
f90007a0:	ed5ff06f          	j	f9000674 <_vsnprintf+0xd0>
        const int prec = (int)va_arg(va, int);
f90007a4:	01812783          	lw	a5,24(sp)
f90007a8:	00478713          	addi	a4,a5,4
f90007ac:	00e12c23          	sw	a4,24(sp)
f90007b0:	0007aa83          	lw	s5,0(a5)
        precision = prec > 0 ? (unsigned int)prec : 0U;
f90007b4:	000aca63          	bltz	s5,f90007c8 <_vsnprintf+0x224>
        format++;
f90007b8:	01c12783          	lw	a5,28(sp)
f90007bc:	00178793          	addi	a5,a5,1
f90007c0:	00f12e23          	sw	a5,28(sp)
f90007c4:	eb1ff06f          	j	f9000674 <_vsnprintf+0xd0>
        precision = prec > 0 ? (unsigned int)prec : 0U;
f90007c8:	00000a93          	li	s5,0
f90007cc:	fedff06f          	j	f90007b8 <_vsnprintf+0x214>
    switch (*format) {
f90007d0:	06800693          	li	a3,104
f90007d4:	06d79863          	bne	a5,a3,f9000844 <_vsnprintf+0x2a0>
        flags |= FLAGS_SHORT;
f90007d8:	0804e613          	ori	a2,s1,128
        format++;
f90007dc:	00170793          	addi	a5,a4,1
f90007e0:	00f12e23          	sw	a5,28(sp)
        if (*format == 'h') {
f90007e4:	00174683          	lbu	a3,1(a4)
f90007e8:	06800713          	li	a4,104
f90007ec:	02e68e63          	beq	a3,a4,f9000828 <_vsnprintf+0x284>
        flags |= FLAGS_SHORT;
f90007f0:	00060493          	mv	s1,a2
f90007f4:	0500006f          	j	f9000844 <_vsnprintf+0x2a0>
        flags |= FLAGS_LONG;
f90007f8:	1004e613          	ori	a2,s1,256
        format++;
f90007fc:	00170793          	addi	a5,a4,1
f9000800:	00f12e23          	sw	a5,28(sp)
        if (*format == 'l') {
f9000804:	00174683          	lbu	a3,1(a4)
f9000808:	06c00713          	li	a4,108
f900080c:	00e68663          	beq	a3,a4,f9000818 <_vsnprintf+0x274>
        flags |= FLAGS_LONG;
f9000810:	00060493          	mv	s1,a2
f9000814:	0300006f          	j	f9000844 <_vsnprintf+0x2a0>
          flags |= FLAGS_LONG_LONG;
f9000818:	3004e493          	ori	s1,s1,768
          format++;
f900081c:	00178793          	addi	a5,a5,1
f9000820:	00f12e23          	sw	a5,28(sp)
f9000824:	0200006f          	j	f9000844 <_vsnprintf+0x2a0>
          flags |= FLAGS_CHAR;
f9000828:	0c04e493          	ori	s1,s1,192
          format++;
f900082c:	00178793          	addi	a5,a5,1
f9000830:	00f12e23          	sw	a5,28(sp)
f9000834:	0100006f          	j	f9000844 <_vsnprintf+0x2a0>
        flags |= (sizeof(intmax_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
f9000838:	2004e493          	ori	s1,s1,512
        format++;
f900083c:	00170713          	addi	a4,a4,1
f9000840:	00e12e23          	sw	a4,28(sp)
    switch (*format) {
f9000844:	01c12783          	lw	a5,28(sp)
f9000848:	0007c503          	lbu	a0,0(a5)
f900084c:	fdb50793          	addi	a5,a0,-37
f9000850:	0ff7f693          	andi	a3,a5,255
f9000854:	05300713          	li	a4,83
f9000858:	56d76e63          	bltu	a4,a3,f9000dd4 <_vsnprintf+0x830>
f900085c:	00269793          	slli	a5,a3,0x2
f9000860:	f9001737          	lui	a4,0xf9001
f9000864:	64870713          	addi	a4,a4,1608 # f9001648 <__global_pointer$+0xfffff480>
f9000868:	00e787b3          	add	a5,a5,a4
f900086c:	0007a783          	lw	a5,0(a5)
f9000870:	00078067          	jr	a5
        if (*format == 'x' || *format == 'X') {
f9000874:	07800793          	li	a5,120
f9000878:	02f50463          	beq	a0,a5,f90008a0 <_vsnprintf+0x2fc>
f900087c:	05800793          	li	a5,88
f9000880:	0af50863          	beq	a0,a5,f9000930 <_vsnprintf+0x38c>
        else if (*format == 'o') {
f9000884:	06f00793          	li	a5,111
f9000888:	0af50863          	beq	a0,a5,f9000938 <_vsnprintf+0x394>
        else if (*format == 'b') {
f900088c:	06200793          	li	a5,98
f9000890:	0af50863          	beq	a0,a5,f9000940 <_vsnprintf+0x39c>
          flags &= ~FLAGS_HASH;   // no hash for dec format
f9000894:	fef4f493          	andi	s1,s1,-17
          base = 10U;
f9000898:	00a00813          	li	a6,10
f900089c:	0080006f          	j	f90008a4 <_vsnprintf+0x300>
          base = 16U;
f90008a0:	01000813          	li	a6,16
        if (*format == 'X') {
f90008a4:	05800793          	li	a5,88
f90008a8:	0af50063          	beq	a0,a5,f9000948 <_vsnprintf+0x3a4>
        if ((*format != 'i') && (*format != 'd')) {
f90008ac:	06900793          	li	a5,105
f90008b0:	00f50863          	beq	a0,a5,f90008c0 <_vsnprintf+0x31c>
f90008b4:	06400793          	li	a5,100
f90008b8:	00f50463          	beq	a0,a5,f90008c0 <_vsnprintf+0x31c>
          flags &= ~(FLAGS_PLUS | FLAGS_SPACE);
f90008bc:	ff34f493          	andi	s1,s1,-13
        if (flags & FLAGS_PRECISION) {
f90008c0:	4004f793          	andi	a5,s1,1024
f90008c4:	00078463          	beqz	a5,f90008cc <_vsnprintf+0x328>
          flags &= ~FLAGS_ZEROPAD;
f90008c8:	ffe4f493          	andi	s1,s1,-2
        if ((*format == 'i') || (*format == 'd')) {
f90008cc:	06900793          	li	a5,105
f90008d0:	08f50063          	beq	a0,a5,f9000950 <_vsnprintf+0x3ac>
f90008d4:	06400793          	li	a5,100
f90008d8:	06f50c63          	beq	a0,a5,f9000950 <_vsnprintf+0x3ac>
          if (flags & FLAGS_LONG_LONG) {
f90008dc:	2004f793          	andi	a5,s1,512
f90008e0:	0c079663          	bnez	a5,f90009ac <_vsnprintf+0x408>
          else if (flags & FLAGS_LONG) {
f90008e4:	1004f793          	andi	a5,s1,256
f90008e8:	14079663          	bnez	a5,f9000a34 <_vsnprintf+0x490>
            const unsigned int value = (flags & FLAGS_CHAR) ? (unsigned char)va_arg(va, unsigned int) : (flags & FLAGS_SHORT) ? (unsigned short int)va_arg(va, unsigned int) : va_arg(va, unsigned int);
f90008ec:	0404f793          	andi	a5,s1,64
f90008f0:	18078063          	beqz	a5,f9000a70 <_vsnprintf+0x4cc>
f90008f4:	01812783          	lw	a5,24(sp)
f90008f8:	00478713          	addi	a4,a5,4
f90008fc:	00e12c23          	sw	a4,24(sp)
f9000900:	0007c703          	lbu	a4,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, value, false, base, precision, width, flags);
f9000904:	00912223          	sw	s1,4(sp)
f9000908:	01612023          	sw	s6,0(sp)
f900090c:	000a8893          	mv	a7,s5
f9000910:	00000793          	li	a5,0
f9000914:	00090693          	mv	a3,s2
f9000918:	00040613          	mv	a2,s0
f900091c:	00098593          	mv	a1,s3
f9000920:	000a0513          	mv	a0,s4
f9000924:	bbdff0ef          	jal	ra,f90004e0 <_ntoa_long>
f9000928:	00050413          	mv	s0,a0
f900092c:	0800006f          	j	f90009ac <_vsnprintf+0x408>
          base = 16U;
f9000930:	01000813          	li	a6,16
f9000934:	f71ff06f          	j	f90008a4 <_vsnprintf+0x300>
          base =  8U;
f9000938:	00800813          	li	a6,8
f900093c:	f69ff06f          	j	f90008a4 <_vsnprintf+0x300>
          base =  2U;
f9000940:	00200813          	li	a6,2
f9000944:	f61ff06f          	j	f90008a4 <_vsnprintf+0x300>
          flags |= FLAGS_UPPERCASE;
f9000948:	0204e493          	ori	s1,s1,32
f900094c:	f61ff06f          	j	f90008ac <_vsnprintf+0x308>
          if (flags & FLAGS_LONG_LONG) {
f9000950:	2004f793          	andi	a5,s1,512
f9000954:	04079c63          	bnez	a5,f90009ac <_vsnprintf+0x408>
          else if (flags & FLAGS_LONG) {
f9000958:	1004f793          	andi	a5,s1,256
f900095c:	06079063          	bnez	a5,f90009bc <_vsnprintf+0x418>
            const int value = (flags & FLAGS_CHAR) ? (char)va_arg(va, int) : (flags & FLAGS_SHORT) ? (short int)va_arg(va, int) : va_arg(va, int);
f9000960:	0404f793          	andi	a5,s1,64
f9000964:	0a078063          	beqz	a5,f9000a04 <_vsnprintf+0x460>
f9000968:	01812783          	lw	a5,24(sp)
f900096c:	00478713          	addi	a4,a5,4
f9000970:	00e12c23          	sw	a4,24(sp)
f9000974:	0007c783          	lbu	a5,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned int)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
f9000978:	41f7d713          	srai	a4,a5,0x1f
f900097c:	00f746b3          	xor	a3,a4,a5
f9000980:	00912223          	sw	s1,4(sp)
f9000984:	01612023          	sw	s6,0(sp)
f9000988:	000a8893          	mv	a7,s5
f900098c:	01f7d793          	srli	a5,a5,0x1f
f9000990:	40e68733          	sub	a4,a3,a4
f9000994:	00090693          	mv	a3,s2
f9000998:	00040613          	mv	a2,s0
f900099c:	00098593          	mv	a1,s3
f90009a0:	000a0513          	mv	a0,s4
f90009a4:	b3dff0ef          	jal	ra,f90004e0 <_ntoa_long>
f90009a8:	00050413          	mv	s0,a0
        format++;
f90009ac:	01c12783          	lw	a5,28(sp)
f90009b0:	00178793          	addi	a5,a5,1
f90009b4:	00f12e23          	sw	a5,28(sp)
        break;
f90009b8:	c41ff06f          	j	f90005f8 <_vsnprintf+0x54>
            const long value = va_arg(va, long);
f90009bc:	01812783          	lw	a5,24(sp)
f90009c0:	00478713          	addi	a4,a5,4
f90009c4:	00e12c23          	sw	a4,24(sp)
f90009c8:	0007a783          	lw	a5,0(a5)
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
f90009cc:	41f7d713          	srai	a4,a5,0x1f
f90009d0:	00f746b3          	xor	a3,a4,a5
f90009d4:	00912223          	sw	s1,4(sp)
f90009d8:	01612023          	sw	s6,0(sp)
f90009dc:	000a8893          	mv	a7,s5
f90009e0:	01f7d793          	srli	a5,a5,0x1f
f90009e4:	40e68733          	sub	a4,a3,a4
f90009e8:	00090693          	mv	a3,s2
f90009ec:	00040613          	mv	a2,s0
f90009f0:	00098593          	mv	a1,s3
f90009f4:	000a0513          	mv	a0,s4
f90009f8:	ae9ff0ef          	jal	ra,f90004e0 <_ntoa_long>
f90009fc:	00050413          	mv	s0,a0
f9000a00:	fadff06f          	j	f90009ac <_vsnprintf+0x408>
            const int value = (flags & FLAGS_CHAR) ? (char)va_arg(va, int) : (flags & FLAGS_SHORT) ? (short int)va_arg(va, int) : va_arg(va, int);
f9000a04:	0804f793          	andi	a5,s1,128
f9000a08:	00078c63          	beqz	a5,f9000a20 <_vsnprintf+0x47c>
f9000a0c:	01812783          	lw	a5,24(sp)
f9000a10:	00478713          	addi	a4,a5,4
f9000a14:	00e12c23          	sw	a4,24(sp)
f9000a18:	00079783          	lh	a5,0(a5)
f9000a1c:	f5dff06f          	j	f9000978 <_vsnprintf+0x3d4>
f9000a20:	01812783          	lw	a5,24(sp)
f9000a24:	00478713          	addi	a4,a5,4
f9000a28:	00e12c23          	sw	a4,24(sp)
f9000a2c:	0007a783          	lw	a5,0(a5)
f9000a30:	f49ff06f          	j	f9000978 <_vsnprintf+0x3d4>
            idx = _ntoa_long(out, buffer, idx, maxlen, va_arg(va, unsigned long), false, base, precision, width, flags);
f9000a34:	01812783          	lw	a5,24(sp)
f9000a38:	00478713          	addi	a4,a5,4
f9000a3c:	00e12c23          	sw	a4,24(sp)
f9000a40:	0007a703          	lw	a4,0(a5)
f9000a44:	00912223          	sw	s1,4(sp)
f9000a48:	01612023          	sw	s6,0(sp)
f9000a4c:	000a8893          	mv	a7,s5
f9000a50:	00000793          	li	a5,0
f9000a54:	00090693          	mv	a3,s2
f9000a58:	00040613          	mv	a2,s0
f9000a5c:	00098593          	mv	a1,s3
f9000a60:	000a0513          	mv	a0,s4
f9000a64:	a7dff0ef          	jal	ra,f90004e0 <_ntoa_long>
f9000a68:	00050413          	mv	s0,a0
f9000a6c:	f41ff06f          	j	f90009ac <_vsnprintf+0x408>
            const unsigned int value = (flags & FLAGS_CHAR) ? (unsigned char)va_arg(va, unsigned int) : (flags & FLAGS_SHORT) ? (unsigned short int)va_arg(va, unsigned int) : va_arg(va, unsigned int);
f9000a70:	0804f793          	andi	a5,s1,128
f9000a74:	00078c63          	beqz	a5,f9000a8c <_vsnprintf+0x4e8>
f9000a78:	01812783          	lw	a5,24(sp)
f9000a7c:	00478713          	addi	a4,a5,4
f9000a80:	00e12c23          	sw	a4,24(sp)
f9000a84:	0007d703          	lhu	a4,0(a5)
f9000a88:	e7dff06f          	j	f9000904 <_vsnprintf+0x360>
f9000a8c:	01812783          	lw	a5,24(sp)
f9000a90:	00478713          	addi	a4,a5,4
f9000a94:	00e12c23          	sw	a4,24(sp)
f9000a98:	0007a703          	lw	a4,0(a5)
f9000a9c:	e69ff06f          	j	f9000904 <_vsnprintf+0x360>
            unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f9000aa0:	040a9e63          	bnez	s5,f9000afc <_vsnprintf+0x558>
f9000aa4:	fff00713          	li	a4,-1
f9000aa8:	f90017b7          	lui	a5,0xf9001
f9000aac:	7c078793          	addi	a5,a5,1984 # f90017c0 <__global_pointer$+0xfffff5f8>
f9000ab0:	00c0006f          	j	f9000abc <_vsnprintf+0x518>
  for (s = str; *s && maxsize--; ++s);
f9000ab4:	00178793          	addi	a5,a5,1
f9000ab8:	00068713          	mv	a4,a3
f9000abc:	0007c683          	lbu	a3,0(a5)
f9000ac0:	00068663          	beqz	a3,f9000acc <_vsnprintf+0x528>
f9000ac4:	fff70693          	addi	a3,a4,-1
f9000ac8:	fe0716e3          	bnez	a4,f9000ab4 <_vsnprintf+0x510>
  return (unsigned int)(s - str);
f9000acc:	f9001737          	lui	a4,0xf9001
f9000ad0:	7c070713          	addi	a4,a4,1984 # f90017c0 <__global_pointer$+0xfffff5f8>
f9000ad4:	40e787b3          	sub	a5,a5,a4
            if (flags & FLAGS_PRECISION) {
f9000ad8:	4004fb93          	andi	s7,s1,1024
f9000adc:	000b8663          	beqz	s7,f9000ae8 <_vsnprintf+0x544>
              l = (l < precision ? l : precision);
f9000ae0:	00faf463          	bgeu	s5,a5,f9000ae8 <_vsnprintf+0x544>
f9000ae4:	000a8793          	mv	a5,s5
            if (!(flags & FLAGS_LEFT)) {
f9000ae8:	0024f493          	andi	s1,s1,2
f9000aec:	02048c63          	beqz	s1,f9000b24 <_vsnprintf+0x580>
            while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9000af0:	f90014b7          	lui	s1,0xf9001
f9000af4:	7c048493          	addi	s1,s1,1984 # f90017c0 <__global_pointer$+0xfffff5f8>
f9000af8:	0580006f          	j	f9000b50 <_vsnprintf+0x5ac>
            unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f9000afc:	000a8713          	mv	a4,s5
f9000b00:	fa9ff06f          	j	f9000aa8 <_vsnprintf+0x504>
                out(' ', buffer, idx++, maxlen);
f9000b04:	00140c13          	addi	s8,s0,1
f9000b08:	00090693          	mv	a3,s2
f9000b0c:	00040613          	mv	a2,s0
f9000b10:	00098593          	mv	a1,s3
f9000b14:	02000513          	li	a0,32
f9000b18:	000a00e7          	jalr	s4
              while (l++ < width) {
f9000b1c:	00048793          	mv	a5,s1
                out(' ', buffer, idx++, maxlen);
f9000b20:	000c0413          	mv	s0,s8
              while (l++ < width) {
f9000b24:	00178493          	addi	s1,a5,1
f9000b28:	fd67eee3          	bltu	a5,s6,f9000b04 <_vsnprintf+0x560>
f9000b2c:	fc5ff06f          	j	f9000af0 <_vsnprintf+0x54c>
            while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9000b30:	00078a93          	mv	s5,a5
              out(*(p++), buffer, idx++, maxlen);
f9000b34:	00148493          	addi	s1,s1,1
f9000b38:	00140b13          	addi	s6,s0,1
f9000b3c:	00090693          	mv	a3,s2
f9000b40:	00040613          	mv	a2,s0
f9000b44:	00098593          	mv	a1,s3
f9000b48:	000a00e7          	jalr	s4
f9000b4c:	000b0413          	mv	s0,s6
            while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9000b50:	0004c503          	lbu	a0,0(s1)
f9000b54:	00050863          	beqz	a0,f9000b64 <_vsnprintf+0x5c0>
f9000b58:	fc0b8ee3          	beqz	s7,f9000b34 <_vsnprintf+0x590>
f9000b5c:	fffa8793          	addi	a5,s5,-1
f9000b60:	fc0a98e3          	bnez	s5,f9000b30 <_vsnprintf+0x58c>
            out(*format, buffer, idx++, maxlen);
f9000b64:	00140493          	addi	s1,s0,1
f9000b68:	00090693          	mv	a3,s2
f9000b6c:	00040613          	mv	a2,s0
f9000b70:	00098593          	mv	a1,s3
f9000b74:	01c12783          	lw	a5,28(sp)
f9000b78:	0007c503          	lbu	a0,0(a5)
f9000b7c:	000a00e7          	jalr	s4
            out('>', buffer, idx++, maxlen);
f9000b80:	00090693          	mv	a3,s2
f9000b84:	00048613          	mv	a2,s1
f9000b88:	00240413          	addi	s0,s0,2
f9000b8c:	00098593          	mv	a1,s3
f9000b90:	03e00513          	li	a0,62
f9000b94:	000a00e7          	jalr	s4
            format++;
f9000b98:	01c12783          	lw	a5,28(sp)
f9000b9c:	00178793          	addi	a5,a5,1
f9000ba0:	00f12e23          	sw	a5,28(sp)
            break;
f9000ba4:	a55ff06f          	j	f90005f8 <_vsnprintf+0x54>
        if (!(flags & FLAGS_LEFT)) {
f9000ba8:	0024f493          	andi	s1,s1,2
f9000bac:	06048863          	beqz	s1,f9000c1c <_vsnprintf+0x678>
        unsigned int l = 1U;
f9000bb0:	00100a93          	li	s5,1
        out((char)va_arg(va, int), buffer, idx++, maxlen);
f9000bb4:	01812783          	lw	a5,24(sp)
f9000bb8:	00478713          	addi	a4,a5,4
f9000bbc:	00e12c23          	sw	a4,24(sp)
f9000bc0:	00140b93          	addi	s7,s0,1
f9000bc4:	00090693          	mv	a3,s2
f9000bc8:	00040613          	mv	a2,s0
f9000bcc:	00098593          	mv	a1,s3
f9000bd0:	0007c503          	lbu	a0,0(a5)
f9000bd4:	000a00e7          	jalr	s4
        if (flags & FLAGS_LEFT) {
f9000bd8:	06049663          	bnez	s1,f9000c44 <_vsnprintf+0x6a0>
        format++;
f9000bdc:	01c12783          	lw	a5,28(sp)
f9000be0:	00178793          	addi	a5,a5,1
f9000be4:	00f12e23          	sw	a5,28(sp)
        break;
f9000be8:	000b8413          	mv	s0,s7
f9000bec:	a0dff06f          	j	f90005f8 <_vsnprintf+0x54>
            out(' ', buffer, idx++, maxlen);
f9000bf0:	00140b93          	addi	s7,s0,1
f9000bf4:	00090693          	mv	a3,s2
f9000bf8:	00040613          	mv	a2,s0
f9000bfc:	00098593          	mv	a1,s3
f9000c00:	02000513          	li	a0,32
f9000c04:	000a00e7          	jalr	s4
          while (l++ < width) {
f9000c08:	000a8793          	mv	a5,s5
            out(' ', buffer, idx++, maxlen);
f9000c0c:	000b8413          	mv	s0,s7
          while (l++ < width) {
f9000c10:	00178a93          	addi	s5,a5,1
f9000c14:	fd67eee3          	bltu	a5,s6,f9000bf0 <_vsnprintf+0x64c>
f9000c18:	f9dff06f          	j	f9000bb4 <_vsnprintf+0x610>
        unsigned int l = 1U;
f9000c1c:	00100793          	li	a5,1
f9000c20:	ff1ff06f          	j	f9000c10 <_vsnprintf+0x66c>
            out(' ', buffer, idx++, maxlen);
f9000c24:	001b8493          	addi	s1,s7,1
f9000c28:	00090693          	mv	a3,s2
f9000c2c:	000b8613          	mv	a2,s7
f9000c30:	00098593          	mv	a1,s3
f9000c34:	02000513          	li	a0,32
f9000c38:	000a00e7          	jalr	s4
          while (l++ < width) {
f9000c3c:	00040a93          	mv	s5,s0
            out(' ', buffer, idx++, maxlen);
f9000c40:	00048b93          	mv	s7,s1
          while (l++ < width) {
f9000c44:	001a8413          	addi	s0,s5,1
f9000c48:	fd6aeee3          	bltu	s5,s6,f9000c24 <_vsnprintf+0x680>
f9000c4c:	f91ff06f          	j	f9000bdc <_vsnprintf+0x638>
      }

      case 's' : {
        const char* p = va_arg(va, char*);
f9000c50:	01812783          	lw	a5,24(sp)
f9000c54:	00478713          	addi	a4,a5,4
f9000c58:	00e12c23          	sw	a4,24(sp)
f9000c5c:	0007ac03          	lw	s8,0(a5)
        unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f9000c60:	040a9463          	bnez	s5,f9000ca8 <_vsnprintf+0x704>
f9000c64:	fff00713          	li	a4,-1
f9000c68:	000c0793          	mv	a5,s8
f9000c6c:	00c0006f          	j	f9000c78 <_vsnprintf+0x6d4>
  for (s = str; *s && maxsize--; ++s);
f9000c70:	00178793          	addi	a5,a5,1
f9000c74:	00068713          	mv	a4,a3
f9000c78:	0007c683          	lbu	a3,0(a5)
f9000c7c:	00068663          	beqz	a3,f9000c88 <_vsnprintf+0x6e4>
f9000c80:	fff70693          	addi	a3,a4,-1
f9000c84:	fe0716e3          	bnez	a4,f9000c70 <_vsnprintf+0x6cc>
  return (unsigned int)(s - str);
f9000c88:	41878bb3          	sub	s7,a5,s8
        // pre padding
        if (flags & FLAGS_PRECISION) {
f9000c8c:	4004fc93          	andi	s9,s1,1024
f9000c90:	000c8663          	beqz	s9,f9000c9c <_vsnprintf+0x6f8>
          l = (l < precision ? l : precision);
f9000c94:	017af463          	bgeu	s5,s7,f9000c9c <_vsnprintf+0x6f8>
f9000c98:	000a8b93          	mv	s7,s5
        }
        if (!(flags & FLAGS_LEFT)) {
f9000c9c:	0024fd13          	andi	s10,s1,2
f9000ca0:	060d1063          	bnez	s10,f9000d00 <_vsnprintf+0x75c>
f9000ca4:	02c0006f          	j	f9000cd0 <_vsnprintf+0x72c>
        unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
f9000ca8:	000a8713          	mv	a4,s5
f9000cac:	fbdff06f          	j	f9000c68 <_vsnprintf+0x6c4>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
f9000cb0:	00140d93          	addi	s11,s0,1
f9000cb4:	00090693          	mv	a3,s2
f9000cb8:	00040613          	mv	a2,s0
f9000cbc:	00098593          	mv	a1,s3
f9000cc0:	02000513          	li	a0,32
f9000cc4:	000a00e7          	jalr	s4
          while (l++ < width) {
f9000cc8:	00048b93          	mv	s7,s1
            out(' ', buffer, idx++, maxlen);
f9000ccc:	000d8413          	mv	s0,s11
          while (l++ < width) {
f9000cd0:	001b8493          	addi	s1,s7,1
f9000cd4:	fd6beee3          	bltu	s7,s6,f9000cb0 <_vsnprintf+0x70c>
f9000cd8:	00048b93          	mv	s7,s1
f9000cdc:	0240006f          	j	f9000d00 <_vsnprintf+0x75c>
          }
        }
        // string output
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9000ce0:	00078a93          	mv	s5,a5
          out(*(p++), buffer, idx++, maxlen);
f9000ce4:	001c0c13          	addi	s8,s8,1
f9000ce8:	00140493          	addi	s1,s0,1
f9000cec:	00090693          	mv	a3,s2
f9000cf0:	00040613          	mv	a2,s0
f9000cf4:	00098593          	mv	a1,s3
f9000cf8:	000a00e7          	jalr	s4
f9000cfc:	00048413          	mv	s0,s1
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
f9000d00:	000c4503          	lbu	a0,0(s8)
f9000d04:	00050863          	beqz	a0,f9000d14 <_vsnprintf+0x770>
f9000d08:	fc0c8ee3          	beqz	s9,f9000ce4 <_vsnprintf+0x740>
f9000d0c:	fffa8793          	addi	a5,s5,-1
f9000d10:	fc0a98e3          	bnez	s5,f9000ce0 <_vsnprintf+0x73c>
        }
        // post padding
        if (flags & FLAGS_LEFT) {
f9000d14:	020d1a63          	bnez	s10,f9000d48 <_vsnprintf+0x7a4>
          while (l++ < width) {
            out(' ', buffer, idx++, maxlen);
          }
        }
        format++;
f9000d18:	01c12783          	lw	a5,28(sp)
f9000d1c:	00178793          	addi	a5,a5,1
f9000d20:	00f12e23          	sw	a5,28(sp)
        break;
f9000d24:	8d5ff06f          	j	f90005f8 <_vsnprintf+0x54>
            out(' ', buffer, idx++, maxlen);
f9000d28:	00140a93          	addi	s5,s0,1
f9000d2c:	00090693          	mv	a3,s2
f9000d30:	00040613          	mv	a2,s0
f9000d34:	00098593          	mv	a1,s3
f9000d38:	02000513          	li	a0,32
f9000d3c:	000a00e7          	jalr	s4
          while (l++ < width) {
f9000d40:	00048b93          	mv	s7,s1
            out(' ', buffer, idx++, maxlen);
f9000d44:	000a8413          	mv	s0,s5
          while (l++ < width) {
f9000d48:	001b8493          	addi	s1,s7,1
f9000d4c:	fd6beee3          	bltu	s7,s6,f9000d28 <_vsnprintf+0x784>
f9000d50:	fc9ff06f          	j	f9000d18 <_vsnprintf+0x774>
      }

      case 'p' : {
        width = sizeof(void*) * 2U;
        flags |= FLAGS_ZEROPAD | FLAGS_UPPERCASE;
f9000d54:	0214e493          	ori	s1,s1,33
        if (is_ll) {
          idx = _ntoa_long_long(out, buffer, idx, maxlen, (uintptr_t)va_arg(va, void*), false, 16U, precision, width, flags);
        }
        else {
#endif
          idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)((uintptr_t)va_arg(va, void*)), false, 16U, precision, width, flags);
f9000d58:	01812783          	lw	a5,24(sp)
f9000d5c:	00478713          	addi	a4,a5,4
f9000d60:	00e12c23          	sw	a4,24(sp)
f9000d64:	0007a703          	lw	a4,0(a5)
f9000d68:	00912223          	sw	s1,4(sp)
f9000d6c:	00800793          	li	a5,8
f9000d70:	00f12023          	sw	a5,0(sp)
f9000d74:	000a8893          	mv	a7,s5
f9000d78:	01000813          	li	a6,16
f9000d7c:	00000793          	li	a5,0
f9000d80:	00090693          	mv	a3,s2
f9000d84:	00040613          	mv	a2,s0
f9000d88:	00098593          	mv	a1,s3
f9000d8c:	000a0513          	mv	a0,s4
f9000d90:	f50ff0ef          	jal	ra,f90004e0 <_ntoa_long>
f9000d94:	00050413          	mv	s0,a0
#if defined(PRINTF_SUPPORT_LONG_LONG)
        }
#endif
        format++;
f9000d98:	01c12783          	lw	a5,28(sp)
f9000d9c:	00178793          	addi	a5,a5,1
f9000da0:	00f12e23          	sw	a5,28(sp)
        break;
f9000da4:	855ff06f          	j	f90005f8 <_vsnprintf+0x54>
      }

      case '%' :
        out('%', buffer, idx++, maxlen);
f9000da8:	00140493          	addi	s1,s0,1
f9000dac:	00090693          	mv	a3,s2
f9000db0:	00040613          	mv	a2,s0
f9000db4:	00098593          	mv	a1,s3
f9000db8:	02500513          	li	a0,37
f9000dbc:	000a00e7          	jalr	s4
        format++;
f9000dc0:	01c12783          	lw	a5,28(sp)
f9000dc4:	00178793          	addi	a5,a5,1
f9000dc8:	00f12e23          	sw	a5,28(sp)
        out('%', buffer, idx++, maxlen);
f9000dcc:	00048413          	mv	s0,s1
        break;
f9000dd0:	829ff06f          	j	f90005f8 <_vsnprintf+0x54>

      default :
        out(*format, buffer, idx++, maxlen);
f9000dd4:	00140493          	addi	s1,s0,1
f9000dd8:	00090693          	mv	a3,s2
f9000ddc:	00040613          	mv	a2,s0
f9000de0:	00098593          	mv	a1,s3
f9000de4:	000a00e7          	jalr	s4
        format++;
f9000de8:	01c12783          	lw	a5,28(sp)
f9000dec:	00178793          	addi	a5,a5,1
f9000df0:	00f12e23          	sw	a5,28(sp)
        out(*format, buffer, idx++, maxlen);
f9000df4:	00048413          	mv	s0,s1
        break;
f9000df8:	801ff06f          	j	f90005f8 <_vsnprintf+0x54>
    out = _out_null;
f9000dfc:	f9000a37          	lui	s4,0xf9000
f9000e00:	1a8a0a13          	addi	s4,s4,424 # f90001a8 <__global_pointer$+0xffffdfe0>
f9000e04:	ff0ff06f          	j	f90005f4 <_vsnprintf+0x50>
    }
  }

  // termination
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
f9000e08:	05246c63          	bltu	s0,s2,f9000e60 <_vsnprintf+0x8bc>
f9000e0c:	fff90613          	addi	a2,s2,-1
f9000e10:	00090693          	mv	a3,s2
f9000e14:	00098593          	mv	a1,s3
f9000e18:	00000513          	li	a0,0
f9000e1c:	000a00e7          	jalr	s4

  // return written chars without terminating \0
  return (int)idx;
}
f9000e20:	00040513          	mv	a0,s0
f9000e24:	05c12083          	lw	ra,92(sp)
f9000e28:	05812403          	lw	s0,88(sp)
f9000e2c:	05412483          	lw	s1,84(sp)
f9000e30:	05012903          	lw	s2,80(sp)
f9000e34:	04c12983          	lw	s3,76(sp)
f9000e38:	04812a03          	lw	s4,72(sp)
f9000e3c:	04412a83          	lw	s5,68(sp)
f9000e40:	04012b03          	lw	s6,64(sp)
f9000e44:	03c12b83          	lw	s7,60(sp)
f9000e48:	03812c03          	lw	s8,56(sp)
f9000e4c:	03412c83          	lw	s9,52(sp)
f9000e50:	03012d03          	lw	s10,48(sp)
f9000e54:	02c12d83          	lw	s11,44(sp)
f9000e58:	06010113          	addi	sp,sp,96
f9000e5c:	00008067          	ret
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
f9000e60:	00040613          	mv	a2,s0
f9000e64:	fadff06f          	j	f9000e10 <_vsnprintf+0x86c>

f9000e68 <bsp_printf_c>:
    #endif //#if (ENABLE_FLOATING_POINT_SUPPORT)

    

    static void bsp_printf_c(int c)
    {
f9000e68:	ff010113          	addi	sp,sp,-16
f9000e6c:	00112623          	sw	ra,12(sp)
        _putchar(c);
f9000e70:	0ff57513          	andi	a0,a0,255
f9000e74:	a38ff0ef          	jal	ra,f90000ac <_putchar>
    }
f9000e78:	00c12083          	lw	ra,12(sp)
f9000e7c:	01010113          	addi	sp,sp,16
f9000e80:	00008067          	ret

f9000e84 <bsp_printf_s>:

    static void bsp_printf_s(char *p)
    {
f9000e84:	ff010113          	addi	sp,sp,-16
f9000e88:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
f9000e8c:	a40ff0ef          	jal	ra,f90000cc <_putchar_s>
    }
f9000e90:	00c12083          	lw	ra,12(sp)
f9000e94:	01010113          	addi	sp,sp,16
f9000e98:	00008067          	ret

f9000e9c <bsp_printf_d>:



    static void bsp_printf_d(int val)
    {
f9000e9c:	fd010113          	addi	sp,sp,-48
f9000ea0:	02112623          	sw	ra,44(sp)
f9000ea4:	02812423          	sw	s0,40(sp)
f9000ea8:	02912223          	sw	s1,36(sp)
f9000eac:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
f9000eb0:	00054663          	bltz	a0,f9000ebc <bsp_printf_d+0x20>
    {
f9000eb4:	00010413          	mv	s0,sp
f9000eb8:	02c0006f          	j	f9000ee4 <bsp_printf_d+0x48>
            bsp_printf_c('-');
f9000ebc:	02d00513          	li	a0,45
f9000ec0:	fa9ff0ef          	jal	ra,f9000e68 <bsp_printf_c>
            val = -val;
f9000ec4:	409004b3          	neg	s1,s1
f9000ec8:	fedff06f          	j	f9000eb4 <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
f9000ecc:	00a00713          	li	a4,10
f9000ed0:	02e4e7b3          	rem	a5,s1,a4
f9000ed4:	03078793          	addi	a5,a5,48
f9000ed8:	00f40023          	sb	a5,0(s0)
            val = val / 10;
f9000edc:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
f9000ee0:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
f9000ee4:	fe0494e3          	bnez	s1,f9000ecc <bsp_printf_d+0x30>
f9000ee8:	00010793          	mv	a5,sp
f9000eec:	fef400e3          	beq	s0,a5,f9000ecc <bsp_printf_d+0x30>
f9000ef0:	0100006f          	j	f9000f00 <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
f9000ef4:	fff40413          	addi	s0,s0,-1
f9000ef8:	00044503          	lbu	a0,0(s0)
f9000efc:	f6dff0ef          	jal	ra,f9000e68 <bsp_printf_c>
        while (p != buffer)
f9000f00:	00010793          	mv	a5,sp
f9000f04:	fef418e3          	bne	s0,a5,f9000ef4 <bsp_printf_d+0x58>
    }
f9000f08:	02c12083          	lw	ra,44(sp)
f9000f0c:	02812403          	lw	s0,40(sp)
f9000f10:	02412483          	lw	s1,36(sp)
f9000f14:	03010113          	addi	sp,sp,48
f9000f18:	00008067          	ret

f9000f1c <bsp_printf_x>:

    static void bsp_printf_x(int val)
    {
f9000f1c:	ff010113          	addi	sp,sp,-16
f9000f20:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
f9000f24:	00000713          	li	a4,0
f9000f28:	00700793          	li	a5,7
f9000f2c:	02e7c063          	blt	a5,a4,f9000f4c <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9000f30:	00271693          	slli	a3,a4,0x2
f9000f34:	ff000793          	li	a5,-16
f9000f38:	00d797b3          	sll	a5,a5,a3
f9000f3c:	00f577b3          	and	a5,a0,a5
f9000f40:	00078663          	beqz	a5,f9000f4c <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
f9000f44:	00170713          	addi	a4,a4,1
f9000f48:	fe1ff06f          	j	f9000f28 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
f9000f4c:	a08ff0ef          	jal	ra,f9000154 <bsp_printHex_lower>
    }
f9000f50:	00c12083          	lw	ra,12(sp)
f9000f54:	01010113          	addi	sp,sp,16
f9000f58:	00008067          	ret

f9000f5c <bsp_printf_X>:

    static void bsp_printf_X(int val)
        {
f9000f5c:	ff010113          	addi	sp,sp,-16
f9000f60:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
f9000f64:	00000713          	li	a4,0
f9000f68:	00700793          	li	a5,7
f9000f6c:	02e7c063          	blt	a5,a4,f9000f8c <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
f9000f70:	00271693          	slli	a3,a4,0x2
f9000f74:	ff000793          	li	a5,-16
f9000f78:	00d797b3          	sll	a5,a5,a3
f9000f7c:	00f577b3          	and	a5,a0,a5
f9000f80:	00078663          	beqz	a5,f9000f8c <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
f9000f84:	00170713          	addi	a4,a4,1
f9000f88:	fe1ff06f          	j	f9000f68 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
f9000f8c:	974ff0ef          	jal	ra,f9000100 <bsp_printHex>
        }
f9000f90:	00c12083          	lw	ra,12(sp)
f9000f94:	01010113          	addi	sp,sp,16
f9000f98:	00008067          	ret

f9000f9c <flush_data_cache>:

typedef unsigned char u8;

#include "bsp.h"

static void flush_data_cache(){
f9000f9c:	0000500f          	0x500f
        asm(".word(0x500F)");
}
f9000fa0:	00008067          	ret

f9000fa4 <printf_>:


///////////////////////////////////////////////////////////////////////////////

static int printf_(const char* format, ...)
{
f9000fa4:	fc010113          	addi	sp,sp,-64
f9000fa8:	00112e23          	sw	ra,28(sp)
f9000fac:	02b12223          	sw	a1,36(sp)
f9000fb0:	02c12423          	sw	a2,40(sp)
f9000fb4:	02d12623          	sw	a3,44(sp)
f9000fb8:	02e12823          	sw	a4,48(sp)
f9000fbc:	02f12a23          	sw	a5,52(sp)
f9000fc0:	03012c23          	sw	a6,56(sp)
f9000fc4:	03112e23          	sw	a7,60(sp)
  va_list va;
  va_start(va, format);
f9000fc8:	02410713          	addi	a4,sp,36
f9000fcc:	00e12623          	sw	a4,12(sp)
    char buffer[MAX_STRING_BUFFER_SIZE];
    const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
    _putchar_s(buffer);
#else
    char buffer[1];
    const int ret = _vsnprintf(_out_char, buffer, (size_t)-1, format, va);
f9000fd0:	00050693          	mv	a3,a0
f9000fd4:	fff00613          	li	a2,-1
f9000fd8:	00810593          	addi	a1,sp,8
f9000fdc:	f9000537          	lui	a0,0xf9000
f9000fe0:	1ac50513          	addi	a0,a0,428 # f90001ac <__global_pointer$+0xffffdfe4>
f9000fe4:	dc0ff0ef          	jal	ra,f90005a4 <_vsnprintf>

#endif

  va_end(va);
  return ret;
}
f9000fe8:	01c12083          	lw	ra,28(sp)
f9000fec:	04010113          	addi	sp,sp,64
f9000ff0:	00008067          	ret

f9000ff4 <bsp_printf>:
#if (ENABLE_SEMIHOSTING_PRINT == 0)
    static void bsp_printf(const char *format, ...)
    {
f9000ff4:	fc010113          	addi	sp,sp,-64
f9000ff8:	00112e23          	sw	ra,28(sp)
f9000ffc:	00812c23          	sw	s0,24(sp)
f9001000:	00912a23          	sw	s1,20(sp)
f9001004:	00050493          	mv	s1,a0
f9001008:	02b12223          	sw	a1,36(sp)
f900100c:	02c12423          	sw	a2,40(sp)
f9001010:	02d12623          	sw	a3,44(sp)
f9001014:	02e12823          	sw	a4,48(sp)
f9001018:	02f12a23          	sw	a5,52(sp)
f900101c:	03012c23          	sw	a6,56(sp)
f9001020:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
f9001024:	02410793          	addi	a5,sp,36
f9001028:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
f900102c:	00000413          	li	s0,0
f9001030:	01c0006f          	j	f900104c <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
f9001034:	00c12783          	lw	a5,12(sp)
f9001038:	00478713          	addi	a4,a5,4
f900103c:	00e12623          	sw	a4,12(sp)
f9001040:	0007a503          	lw	a0,0(a5)
f9001044:	e25ff0ef          	jal	ra,f9000e68 <bsp_printf_c>
        for (i = 0; format[i]; i++)
f9001048:	00140413          	addi	s0,s0,1
f900104c:	008487b3          	add	a5,s1,s0
f9001050:	0007c503          	lbu	a0,0(a5)
f9001054:	0c050263          	beqz	a0,f9001118 <bsp_printf+0x124>
            if (format[i] == '%') {
f9001058:	02500793          	li	a5,37
f900105c:	06f50663          	beq	a0,a5,f90010c8 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
f9001060:	e09ff0ef          	jal	ra,f9000e68 <bsp_printf_c>
f9001064:	fe5ff06f          	j	f9001048 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
f9001068:	00c12783          	lw	a5,12(sp)
f900106c:	00478713          	addi	a4,a5,4
f9001070:	00e12623          	sw	a4,12(sp)
f9001074:	0007a503          	lw	a0,0(a5)
f9001078:	e0dff0ef          	jal	ra,f9000e84 <bsp_printf_s>
                        break;
f900107c:	fcdff06f          	j	f9001048 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
f9001080:	00c12783          	lw	a5,12(sp)
f9001084:	00478713          	addi	a4,a5,4
f9001088:	00e12623          	sw	a4,12(sp)
f900108c:	0007a503          	lw	a0,0(a5)
f9001090:	e0dff0ef          	jal	ra,f9000e9c <bsp_printf_d>
                        break;
f9001094:	fb5ff06f          	j	f9001048 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
f9001098:	00c12783          	lw	a5,12(sp)
f900109c:	00478713          	addi	a4,a5,4
f90010a0:	00e12623          	sw	a4,12(sp)
f90010a4:	0007a503          	lw	a0,0(a5)
f90010a8:	eb5ff0ef          	jal	ra,f9000f5c <bsp_printf_X>
                        break;
f90010ac:	f9dff06f          	j	f9001048 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
f90010b0:	00c12783          	lw	a5,12(sp)
f90010b4:	00478713          	addi	a4,a5,4
f90010b8:	00e12623          	sw	a4,12(sp)
f90010bc:	0007a503          	lw	a0,0(a5)
f90010c0:	e5dff0ef          	jal	ra,f9000f1c <bsp_printf_x>
                        break;
f90010c4:	f85ff06f          	j	f9001048 <bsp_printf+0x54>
                while (format[++i]) {
f90010c8:	00140413          	addi	s0,s0,1
f90010cc:	008487b3          	add	a5,s1,s0
f90010d0:	0007c783          	lbu	a5,0(a5)
f90010d4:	f6078ae3          	beqz	a5,f9001048 <bsp_printf+0x54>
                    if (format[i] == 'c') {
f90010d8:	06300713          	li	a4,99
f90010dc:	f4e78ce3          	beq	a5,a4,f9001034 <bsp_printf+0x40>
                    else if (format[i] == 's') {
f90010e0:	07300713          	li	a4,115
f90010e4:	f8e782e3          	beq	a5,a4,f9001068 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
f90010e8:	06400713          	li	a4,100
f90010ec:	f8e78ae3          	beq	a5,a4,f9001080 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
f90010f0:	05800713          	li	a4,88
f90010f4:	fae782e3          	beq	a5,a4,f9001098 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
f90010f8:	07800713          	li	a4,120
f90010fc:	fae78ae3          	beq	a5,a4,f90010b0 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
f9001100:	06600713          	li	a4,102
f9001104:	fce792e3          	bne	a5,a4,f90010c8 <bsp_printf+0xd4>
                        bsp_printf_s("<Floating point printing not enable. Please Enable it at bsp.h first...>");
f9001108:	f9002537          	lui	a0,0xf9002
f900110c:	81850513          	addi	a0,a0,-2024 # f9001818 <__global_pointer$+0xfffff650>
f9001110:	d75ff0ef          	jal	ra,f9000e84 <bsp_printf_s>
                        break;
f9001114:	f35ff06f          	j	f9001048 <bsp_printf+0x54>

        va_end(ap);
    }
f9001118:	01c12083          	lw	ra,28(sp)
f900111c:	01812403          	lw	s0,24(sp)
f9001120:	01412483          	lw	s1,20(sp)
f9001124:	04010113          	addi	sp,sp,64
f9001128:	00008067          	ret

f900112c <test>:

void test(void *p, int size, u8 value, u8 idx) {
f900112c:	fe010113          	addi	sp,sp,-32
f9001130:	00112e23          	sw	ra,28(sp)
f9001134:	00812c23          	sw	s0,24(sp)
f9001138:	00912a23          	sw	s1,20(sp)
f900113c:	01212823          	sw	s2,16(sp)
f9001140:	01312623          	sw	s3,12(sp)
f9001144:	01412423          	sw	s4,8(sp)
f9001148:	00050413          	mv	s0,a0
f900114c:	00058493          	mv	s1,a1
f9001150:	00060913          	mv	s2,a2
f9001154:	00068993          	mv	s3,a3
	volatile u8 *addr = (volatile u8 *)p;
	if(!idx) {
f9001158:	02068263          	beqz	a3,f900117c <test+0x50>
				bsp_printf_full("Error: %p: %x != %x\n\r", addr+i, value, addr[i]);
				goto err;
			}
		}
	} else {
		for(u32 i = 0; i < size; i++) {
f900115c:	00000793          	li	a5,0
f9001160:	00048713          	mv	a4,s1
f9001164:	0697f263          	bgeu	a5,s1,f90011c8 <test+0x9c>
			addr[i] = i;
f9001168:	00f40733          	add	a4,s0,a5
f900116c:	0ff7f693          	andi	a3,a5,255
f9001170:	00d70023          	sb	a3,0(a4)
		for(u32 i = 0; i < size; i++) {
f9001174:	00178793          	addi	a5,a5,1
f9001178:	fe9ff06f          	j	f9001160 <test+0x34>
		memset(p, value, size);
f900117c:	00058a13          	mv	s4,a1
f9001180:	00058613          	mv	a2,a1
f9001184:	00090593          	mv	a1,s2
f9001188:	3a0000ef          	jal	ra,f9001528 <memset>
		flush_data_cache();
f900118c:	e11ff0ef          	jal	ra,f9000f9c <flush_data_cache>
		for(u32 i = 0; i < size; i++) {
f9001190:	00000793          	li	a5,0
f9001194:	0b47f063          	bgeu	a5,s4,f9001234 <test+0x108>
			if(addr[i] != value) {
f9001198:	00f405b3          	add	a1,s0,a5
f900119c:	0005c703          	lbu	a4,0(a1)
f90011a0:	0ff77713          	andi	a4,a4,255
f90011a4:	01271663          	bne	a4,s2,f90011b0 <test+0x84>
		for(u32 i = 0; i < size; i++) {
f90011a8:	00178793          	addi	a5,a5,1
f90011ac:	fe9ff06f          	j	f9001194 <test+0x68>
				bsp_printf_full("Error: %p: %x != %x\n\r", addr+i, value, addr[i]);
f90011b0:	0005c683          	lbu	a3,0(a1)
f90011b4:	00090613          	mv	a2,s2
f90011b8:	f9002537          	lui	a0,0xf9002
f90011bc:	86450513          	addi	a0,a0,-1948 # f9001864 <__global_pointer$+0xfffff69c>
f90011c0:	de5ff0ef          	jal	ra,f9000fa4 <printf_>
				goto err;
f90011c4:	0380006f          	j	f90011fc <test+0xd0>
		}

		for(u32 i = 0; i < size; i++) {
f90011c8:	00000613          	li	a2,0
f90011cc:	06e67463          	bgeu	a2,a4,f9001234 <test+0x108>
			if(addr[i] != i & 0xff) {
f90011d0:	00c405b3          	add	a1,s0,a2
f90011d4:	0005c783          	lbu	a5,0(a1)
f90011d8:	0ff7f793          	andi	a5,a5,255
f90011dc:	00c79663          	bne	a5,a2,f90011e8 <test+0xbc>
		for(u32 i = 0; i < size; i++) {
f90011e0:	00160613          	addi	a2,a2,1
f90011e4:	fe9ff06f          	j	f90011cc <test+0xa0>
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", addr+i, i&0xff, addr[i]);
f90011e8:	0005c683          	lbu	a3,0(a1)
f90011ec:	0ff67613          	andi	a2,a2,255
f90011f0:	f9002537          	lui	a0,0xf9002
f90011f4:	87c50513          	addi	a0,a0,-1924 # f900187c <__global_pointer$+0xfffff6b4>
f90011f8:	dadff0ef          	jal	ra,f9000fa4 <printf_>
	} else {
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
	}
	return;
err:
	bsp_printf_full("test (0x%p, 0x%p) = 0x%.2X failed!\n\r", p, p + size, value);
f90011fc:	00090693          	mv	a3,s2
f9001200:	00940633          	add	a2,s0,s1
f9001204:	00040593          	mv	a1,s0
f9001208:	f9002537          	lui	a0,0xf9002
f900120c:	8e050513          	addi	a0,a0,-1824 # f90018e0 <__global_pointer$+0xfffff718>
f9001210:	d95ff0ef          	jal	ra,f9000fa4 <printf_>
}
f9001214:	01c12083          	lw	ra,28(sp)
f9001218:	01812403          	lw	s0,24(sp)
f900121c:	01412483          	lw	s1,20(sp)
f9001220:	01012903          	lw	s2,16(sp)
f9001224:	00c12983          	lw	s3,12(sp)
f9001228:	00812a03          	lw	s4,8(sp)
f900122c:	02010113          	addi	sp,sp,32
f9001230:	00008067          	ret
	if(!idx) {
f9001234:	02099063          	bnez	s3,f9001254 <test+0x128>
		bsp_printf_full("test (0x%p, 0x%p) = 0x%.2X success!\n\r", p, p + size, value);
f9001238:	00090693          	mv	a3,s2
f900123c:	00940633          	add	a2,s0,s1
f9001240:	00040593          	mv	a1,s0
f9001244:	f9002537          	lui	a0,0xf9002
f9001248:	89450513          	addi	a0,a0,-1900 # f9001894 <__global_pointer$+0xfffff6cc>
f900124c:	d59ff0ef          	jal	ra,f9000fa4 <printf_>
f9001250:	fc5ff06f          	j	f9001214 <test+0xe8>
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
f9001254:	00940633          	add	a2,s0,s1
f9001258:	00040593          	mv	a1,s0
f900125c:	f9002537          	lui	a0,0xf9002
f9001260:	8bc50513          	addi	a0,a0,-1860 # f90018bc <__global_pointer$+0xfffff6f4>
f9001264:	d41ff0ef          	jal	ra,f9000fa4 <printf_>
f9001268:	fadff06f          	j	f9001214 <test+0xe8>

f900126c <test32>:
void test32(void *p, int size, u32 value, u8 idx) {
f900126c:	ff010113          	addi	sp,sp,-16
f9001270:	00112623          	sw	ra,12(sp)
f9001274:	00812423          	sw	s0,8(sp)
f9001278:	00912223          	sw	s1,4(sp)
f900127c:	01212023          	sw	s2,0(sp)
f9001280:	00050413          	mv	s0,a0
f9001284:	00058493          	mv	s1,a1
f9001288:	00060913          	mv	s2,a2
	volatile u32 *addr = (volatile u32 *)p;
	if(!idx) {
f900128c:	02068c63          	beqz	a3,f90012c4 <test32+0x58>
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", addr+i, value, addr[i]);
				goto err;
			}
		}
	} else {
		for(u32 i = 0; i < size/4; i++) {
f9001290:	00000713          	li	a4,0
f9001294:	41f4d793          	srai	a5,s1,0x1f
f9001298:	0037f793          	andi	a5,a5,3
f900129c:	009787b3          	add	a5,a5,s1
f90012a0:	4027d793          	srai	a5,a5,0x2
f90012a4:	0af77863          	bgeu	a4,a5,f9001354 <test32+0xe8>
			addr[i] = addr+i*4;
f90012a8:	00471613          	slli	a2,a4,0x4
f90012ac:	00c40633          	add	a2,s0,a2
f90012b0:	00271793          	slli	a5,a4,0x2
f90012b4:	00f407b3          	add	a5,s0,a5
f90012b8:	00c7a023          	sw	a2,0(a5)
		for(u32 i = 0; i < size/4; i++) {
f90012bc:	00170713          	addi	a4,a4,1
f90012c0:	fd5ff06f          	j	f9001294 <test32+0x28>
		for(int i = 0; i < size/4; i++) {
f90012c4:	00000713          	li	a4,0
f90012c8:	41f4d793          	srai	a5,s1,0x1f
f90012cc:	0037f793          	andi	a5,a5,3
f90012d0:	009787b3          	add	a5,a5,s1
f90012d4:	4027d793          	srai	a5,a5,0x2
f90012d8:	00f75c63          	bge	a4,a5,f90012f0 <test32+0x84>
			addr[i] = value;
f90012dc:	00271793          	slli	a5,a4,0x2
f90012e0:	00f407b3          	add	a5,s0,a5
f90012e4:	0127a023          	sw	s2,0(a5)
		for(int i = 0; i < size/4; i++) {
f90012e8:	00170713          	addi	a4,a4,1
f90012ec:	fddff06f          	j	f90012c8 <test32+0x5c>
		for(int i = 0; i < size/4; i++) {
f90012f0:	00000713          	li	a4,0
f90012f4:	08f75e63          	bge	a4,a5,f9001390 <test32+0x124>
			if(addr[i] != value) {
f90012f8:	00271593          	slli	a1,a4,0x2
f90012fc:	00b405b3          	add	a1,s0,a1
f9001300:	0005a603          	lw	a2,0(a1)
f9001304:	01261663          	bne	a2,s2,f9001310 <test32+0xa4>
		for(int i = 0; i < size/4; i++) {
f9001308:	00170713          	addi	a4,a4,1
f900130c:	fe9ff06f          	j	f90012f4 <test32+0x88>
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", addr+i, value, addr[i]);
f9001310:	0005a683          	lw	a3,0(a1)
f9001314:	00090613          	mv	a2,s2
f9001318:	f9002537          	lui	a0,0xf9002
f900131c:	87c50513          	addi	a0,a0,-1924 # f900187c <__global_pointer$+0xfffff6b4>
f9001320:	c85ff0ef          	jal	ra,f9000fa4 <printf_>
	} else {
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
	}
	return;
err:
	bsp_printf_full("test (0x%p, 0x%p) = 0x%.8X failed!\n\r", p, p + size, value);
f9001324:	00090693          	mv	a3,s2
f9001328:	00940633          	add	a2,s0,s1
f900132c:	00040593          	mv	a1,s0
f9001330:	f9002537          	lui	a0,0xf9002
f9001334:	93050513          	addi	a0,a0,-1744 # f9001930 <__global_pointer$+0xfffff768>
f9001338:	c6dff0ef          	jal	ra,f9000fa4 <printf_>
}
f900133c:	00c12083          	lw	ra,12(sp)
f9001340:	00812403          	lw	s0,8(sp)
f9001344:	00412483          	lw	s1,4(sp)
f9001348:	00012903          	lw	s2,0(sp)
f900134c:	01010113          	addi	sp,sp,16
f9001350:	00008067          	ret
		for(u32 i = 0; i < size/4; i++) {
f9001354:	00000713          	li	a4,0
f9001358:	02f77c63          	bgeu	a4,a5,f9001390 <test32+0x124>
			u32 addr_idx = addr + i*4;
f900135c:	00471613          	slli	a2,a4,0x4
f9001360:	00c40633          	add	a2,s0,a2
			if(addr[i] != addr_idx) {
f9001364:	00271593          	slli	a1,a4,0x2
f9001368:	00b405b3          	add	a1,s0,a1
f900136c:	0005a503          	lw	a0,0(a1)
f9001370:	00c51663          	bne	a0,a2,f900137c <test32+0x110>
		for(u32 i = 0; i < size/4; i++) {
f9001374:	00170713          	addi	a4,a4,1
f9001378:	fe1ff06f          	j	f9001358 <test32+0xec>
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", &addr[i], addr_idx, &addr[i]);
f900137c:	00058693          	mv	a3,a1
f9001380:	f9002537          	lui	a0,0xf9002
f9001384:	87c50513          	addi	a0,a0,-1924 # f900187c <__global_pointer$+0xfffff6b4>
f9001388:	c1dff0ef          	jal	ra,f9000fa4 <printf_>
				goto err;
f900138c:	f99ff06f          	j	f9001324 <test32+0xb8>
	if(!idx) {
f9001390:	02069063          	bnez	a3,f90013b0 <test32+0x144>
		bsp_printf_full("test (0x%p, 0x%p) = 0x%.8X success!\n\r", p, p + size, value);
f9001394:	00090693          	mv	a3,s2
f9001398:	00940633          	add	a2,s0,s1
f900139c:	00040593          	mv	a1,s0
f90013a0:	f9002537          	lui	a0,0xf9002
f90013a4:	90850513          	addi	a0,a0,-1784 # f9001908 <__global_pointer$+0xfffff740>
f90013a8:	bfdff0ef          	jal	ra,f9000fa4 <printf_>
f90013ac:	f91ff06f          	j	f900133c <test32+0xd0>
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
f90013b0:	00940633          	add	a2,s0,s1
f90013b4:	00040593          	mv	a1,s0
f90013b8:	f9002537          	lui	a0,0xf9002
f90013bc:	8bc50513          	addi	a0,a0,-1860 # f90018bc <__global_pointer$+0xfffff6f4>
f90013c0:	be5ff0ef          	jal	ra,f9000fa4 <printf_>
f90013c4:	f79ff06f          	j	f900133c <test32+0xd0>

f90013c8 <main>:

#define BEGIN 0x00400000U
#define MEM_SIZE (16 * 1024 * 1024)
#define ROUNDS 1000
void main() {
f90013c8:	ff010113          	addi	sp,sp,-16
f90013cc:	00112623          	sw	ra,12(sp)
f90013d0:	00812423          	sw	s0,8(sp)
	bsp_printf_full("MEMORY TEST BEGIN (%p -> %p): %dMB, ROUNDS: %d\n\r", BEGIN, BEGIN+MEM_SIZE, MEM_SIZE/1024/1024, ROUNDS);
f90013d4:	3e800713          	li	a4,1000
f90013d8:	01000693          	li	a3,16
f90013dc:	01400637          	lui	a2,0x1400
f90013e0:	004005b7          	lui	a1,0x400
f90013e4:	f9002537          	lui	a0,0xf9002
f90013e8:	95850513          	addi	a0,a0,-1704 # f9001958 <__global_pointer$+0xfffff790>
f90013ec:	bb9ff0ef          	jal	ra,f9000fa4 <printf_>
	for(int i = 0; i < ROUNDS; i++) {
f90013f0:	00000413          	li	s0,0
f90013f4:	3e700793          	li	a5,999
f90013f8:	0887c063          	blt	a5,s0,f9001478 <main+0xb0>
		bsp_printf("================= round: %d ===================\n\r", i);
f90013fc:	00040593          	mv	a1,s0
f9001400:	f9002537          	lui	a0,0xf9002
f9001404:	98c50513          	addi	a0,a0,-1652 # f900198c <__global_pointer$+0xfffff7c4>
f9001408:	bedff0ef          	jal	ra,f9000ff4 <bsp_printf>
		test(BEGIN,   MEM_SIZE, 0x0, 0);
f900140c:	00000693          	li	a3,0
f9001410:	00000613          	li	a2,0
f9001414:	010005b7          	lui	a1,0x1000
f9001418:	00400537          	lui	a0,0x400
f900141c:	d11ff0ef          	jal	ra,f900112c <test>
		test(BEGIN,   MEM_SIZE, 0x1, 0);
f9001420:	00000693          	li	a3,0
f9001424:	00100613          	li	a2,1
f9001428:	010005b7          	lui	a1,0x1000
f900142c:	00400537          	lui	a0,0x400
f9001430:	cfdff0ef          	jal	ra,f900112c <test>
		test(BEGIN,   MEM_SIZE, 0x5, 0);
f9001434:	00000693          	li	a3,0
f9001438:	00500613          	li	a2,5
f900143c:	010005b7          	lui	a1,0x1000
f9001440:	00400537          	lui	a0,0x400
f9001444:	ce9ff0ef          	jal	ra,f900112c <test>
		test(BEGIN,   MEM_SIZE, 0xa, 0);
f9001448:	00000693          	li	a3,0
f900144c:	00a00613          	li	a2,10
f9001450:	010005b7          	lui	a1,0x1000
f9001454:	00400537          	lui	a0,0x400
f9001458:	cd5ff0ef          	jal	ra,f900112c <test>
		test32(BEGIN, MEM_SIZE, 0, 1);
f900145c:	00100693          	li	a3,1
f9001460:	00000613          	li	a2,0
f9001464:	010005b7          	lui	a1,0x1000
f9001468:	00400537          	lui	a0,0x400
f900146c:	e01ff0ef          	jal	ra,f900126c <test32>
	for(int i = 0; i < ROUNDS; i++) {
f9001470:	00140413          	addi	s0,s0,1
f9001474:	f81ff06f          	j	f90013f4 <main+0x2c>
	}
	bsp_printf_full("MEMORY TEST FINISH!\n\r");
f9001478:	f9002537          	lui	a0,0xf9002
f900147c:	9c050513          	addi	a0,a0,-1600 # f90019c0 <__global_pointer$+0xfffff7f8>
f9001480:	b25ff0ef          	jal	ra,f9000fa4 <printf_>

}
f9001484:	00c12083          	lw	ra,12(sp)
f9001488:	00812403          	lw	s0,8(sp)
f900148c:	01010113          	addi	sp,sp,16
f9001490:	00008067          	ret

f9001494 <__libc_init_array>:
f9001494:	ff010113          	addi	sp,sp,-16
f9001498:	00812423          	sw	s0,8(sp)
f900149c:	01212023          	sw	s2,0(sp)
f90014a0:	00000417          	auipc	s0,0x0
f90014a4:	16440413          	addi	s0,s0,356 # f9001604 <_data>
f90014a8:	00000917          	auipc	s2,0x0
f90014ac:	15c90913          	addi	s2,s2,348 # f9001604 <_data>
f90014b0:	40890933          	sub	s2,s2,s0
f90014b4:	00112623          	sw	ra,12(sp)
f90014b8:	00912223          	sw	s1,4(sp)
f90014bc:	40295913          	srai	s2,s2,0x2
f90014c0:	00090e63          	beqz	s2,f90014dc <__libc_init_array+0x48>
f90014c4:	00000493          	li	s1,0
f90014c8:	00042783          	lw	a5,0(s0)
f90014cc:	00148493          	addi	s1,s1,1
f90014d0:	00440413          	addi	s0,s0,4
f90014d4:	000780e7          	jalr	a5
f90014d8:	fe9918e3          	bne	s2,s1,f90014c8 <__libc_init_array+0x34>
f90014dc:	00000417          	auipc	s0,0x0
f90014e0:	12840413          	addi	s0,s0,296 # f9001604 <_data>
f90014e4:	00000917          	auipc	s2,0x0
f90014e8:	12090913          	addi	s2,s2,288 # f9001604 <_data>
f90014ec:	40890933          	sub	s2,s2,s0
f90014f0:	40295913          	srai	s2,s2,0x2
f90014f4:	00090e63          	beqz	s2,f9001510 <__libc_init_array+0x7c>
f90014f8:	00000493          	li	s1,0
f90014fc:	00042783          	lw	a5,0(s0)
f9001500:	00148493          	addi	s1,s1,1
f9001504:	00440413          	addi	s0,s0,4
f9001508:	000780e7          	jalr	a5
f900150c:	fe9918e3          	bne	s2,s1,f90014fc <__libc_init_array+0x68>
f9001510:	00c12083          	lw	ra,12(sp)
f9001514:	00812403          	lw	s0,8(sp)
f9001518:	00412483          	lw	s1,4(sp)
f900151c:	00012903          	lw	s2,0(sp)
f9001520:	01010113          	addi	sp,sp,16
f9001524:	00008067          	ret

f9001528 <memset>:
f9001528:	00f00313          	li	t1,15
f900152c:	00050713          	mv	a4,a0
f9001530:	02c37e63          	bgeu	t1,a2,f900156c <memset+0x44>
f9001534:	00f77793          	andi	a5,a4,15
f9001538:	0a079063          	bnez	a5,f90015d8 <memset+0xb0>
f900153c:	08059263          	bnez	a1,f90015c0 <memset+0x98>
f9001540:	ff067693          	andi	a3,a2,-16
f9001544:	00f67613          	andi	a2,a2,15
f9001548:	00e686b3          	add	a3,a3,a4
f900154c:	00b72023          	sw	a1,0(a4)
f9001550:	00b72223          	sw	a1,4(a4)
f9001554:	00b72423          	sw	a1,8(a4)
f9001558:	00b72623          	sw	a1,12(a4)
f900155c:	01070713          	addi	a4,a4,16
f9001560:	fed766e3          	bltu	a4,a3,f900154c <memset+0x24>
f9001564:	00061463          	bnez	a2,f900156c <memset+0x44>
f9001568:	00008067          	ret
f900156c:	40c306b3          	sub	a3,t1,a2
f9001570:	00269693          	slli	a3,a3,0x2
f9001574:	00000297          	auipc	t0,0x0
f9001578:	005686b3          	add	a3,a3,t0
f900157c:	00c68067          	jr	12(a3)
f9001580:	00b70723          	sb	a1,14(a4)
f9001584:	00b706a3          	sb	a1,13(a4)
f9001588:	00b70623          	sb	a1,12(a4)
f900158c:	00b705a3          	sb	a1,11(a4)
f9001590:	00b70523          	sb	a1,10(a4)
f9001594:	00b704a3          	sb	a1,9(a4)
f9001598:	00b70423          	sb	a1,8(a4)
f900159c:	00b703a3          	sb	a1,7(a4)
f90015a0:	00b70323          	sb	a1,6(a4)
f90015a4:	00b702a3          	sb	a1,5(a4)
f90015a8:	00b70223          	sb	a1,4(a4)
f90015ac:	00b701a3          	sb	a1,3(a4)
f90015b0:	00b70123          	sb	a1,2(a4)
f90015b4:	00b700a3          	sb	a1,1(a4)
f90015b8:	00b70023          	sb	a1,0(a4)
f90015bc:	00008067          	ret
f90015c0:	0ff5f593          	andi	a1,a1,255
f90015c4:	00859693          	slli	a3,a1,0x8
f90015c8:	00d5e5b3          	or	a1,a1,a3
f90015cc:	01059693          	slli	a3,a1,0x10
f90015d0:	00d5e5b3          	or	a1,a1,a3
f90015d4:	f6dff06f          	j	f9001540 <memset+0x18>
f90015d8:	00279693          	slli	a3,a5,0x2
f90015dc:	00000297          	auipc	t0,0x0
f90015e0:	005686b3          	add	a3,a3,t0
f90015e4:	00008293          	mv	t0,ra
f90015e8:	fa0680e7          	jalr	-96(a3)
f90015ec:	00028093          	mv	ra,t0
f90015f0:	ff078793          	addi	a5,a5,-16
f90015f4:	40f70733          	sub	a4,a4,a5
f90015f8:	00f60633          	add	a2,a2,a5
f90015fc:	f6c378e3          	bgeu	t1,a2,f900156c <memset+0x44>
f9001600:	f3dff06f          	j	f900153c <memset+0x14>
