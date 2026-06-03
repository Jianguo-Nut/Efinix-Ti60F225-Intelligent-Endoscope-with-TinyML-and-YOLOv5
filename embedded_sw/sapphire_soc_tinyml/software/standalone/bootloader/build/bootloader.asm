
build/bootloader.elf:     file format elf32-littleriscv


Disassembly of section .init:

f9000000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
f9000000:	00001197          	auipc	gp,0x1
f9000004:	dd018193          	addi	gp,gp,-560 # f9000dd0 <__global_pointer$>

f9000008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
f9000008:	92018113          	addi	sp,gp,-1760 # f90006f0 <_sp>

	/* Load data section */
	la a0, _data_lma
f900000c:	80c18513          	addi	a0,gp,-2036 # f90005dc <_data>
	la a1, _data
f9000010:	80c18593          	addi	a1,gp,-2036 # f90005dc <_data>
	la a2, _edata
f9000014:	81c18613          	addi	a2,gp,-2020 # f90005ec <__bss_start>
	bgeu a1, a2, 2f
f9000018:	00c5fc63          	bgeu	a1,a2,f9000030 <init+0x28>
1:
	lw t0, (a0)
f900001c:	00052283          	lw	t0,0(a0)
	sw t0, (a1)
f9000020:	0055a023          	sw	t0,0(a1)
	addi a0, a0, 4
f9000024:	00450513          	addi	a0,a0,4
	addi a1, a1, 4
f9000028:	00458593          	addi	a1,a1,4
	bltu a1, a2, 1b
f900002c:	fec5e8e3          	bltu	a1,a2,f900001c <init+0x14>
2:

	/* Clear bss section */
	la a0, __bss_start
f9000030:	81c18513          	addi	a0,gp,-2020 # f90005ec <__bss_start>
	la a1, _end
f9000034:	82018593          	addi	a1,gp,-2016 # f90005f0 <_end>
	bgeu a0, a1, 2f
f9000038:	00b57863          	bgeu	a0,a1,f9000048 <init+0x40>
1:
	sw zero, (a0)
f900003c:	00052023          	sw	zero,0(a0)
	addi a0, a0, 4
f9000040:	00450513          	addi	a0,a0,4
	bltu a0, a1, 1b
f9000044:	feb56ce3          	bltu	a0,a1,f900003c <init+0x34>
2:

#ifndef NO_LIBC_INIT_ARRAY
	call __libc_init_array
f9000048:	510000ef          	jal	ra,f9000558 <__libc_init_array>
#endif

	call main
f900004c:	4f0000ef          	jal	ra,f900053c <main>

f9000050 <mainDone>:
mainDone:
    j mainDone
f9000050:	0000006f          	j	f9000050 <mainDone>

f9000054 <_init>:


	.globl _init
_init:
    ret
f9000054:	00008067          	ret

Disassembly of section .text:

f9000058 <uart_applyConfig>:
        while(uart_readOccupancy(reg) == 0);
        return read_u32(reg + UART_DATA);
    }
    
    static void uart_applyConfig(u32 reg, Uart_Config *config){
        write_u32(config->clockDivider, reg + UART_CLOCK_DIVIDER);
f9000058:	00c5a783          	lw	a5,12(a1)
    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
f900005c:	00f52423          	sw	a5,8(a0)
        write_u32(((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16), reg + UART_FRAME_CONFIG);
f9000060:	0005a783          	lw	a5,0(a1)
f9000064:	fff78793          	addi	a5,a5,-1
f9000068:	0045a703          	lw	a4,4(a1)
f900006c:	00871713          	slli	a4,a4,0x8
f9000070:	00e7e7b3          	or	a5,a5,a4
f9000074:	0085a703          	lw	a4,8(a1)
f9000078:	01071713          	slli	a4,a4,0x10
f900007c:	00e7e7b3          	or	a5,a5,a4
f9000080:	00f52623          	sw	a5,12(a0)
    }
f9000084:	00008067          	ret

f9000088 <clint_uDelay>:
    
        return (((u64)hi) << 32) | lo;
    }
    
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
f9000088:	000f47b7          	lui	a5,0xf4
f900008c:	24078793          	addi	a5,a5,576 # f4240 <__stack_size+0xf4140>
f9000090:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
f9000094:	0000c7b7          	lui	a5,0xc
f9000098:	ff878793          	addi	a5,a5,-8 # bff8 <__stack_size+0xbef8>
f900009c:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
f90000a0:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
f90000a4:	02a58533          	mul	a0,a1,a0
f90000a8:	00f50533          	add	a0,a0,a5
f90000ac:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
f90000b0:	40f507b3          	sub	a5,a0,a5
f90000b4:	fe07dce3          	bgez	a5,f90000ac <clint_uDelay+0x24>
    }
f90000b8:	00008067          	ret

f90000bc <bsp_init>:
    *   1. UART baudrate
    *   2. 
    */
////////////////////////////////////////////////////////////////////////////////
    static void bsp_init()
    {
f90000bc:	fe010113          	addi	sp,sp,-32
f90000c0:	00112e23          	sw	ra,28(sp)
        Uart_Config uartConfig;
        uartConfig.dataLength   = BITS_8;
f90000c4:	00800793          	li	a5,8
f90000c8:	00f12023          	sw	a5,0(sp)
        uartConfig.parity       = NONE;
f90000cc:	00012223          	sw	zero,4(sp)
        uartConfig.stop         = ONE;
f90000d0:	00012423          	sw	zero,8(sp)
        uartConfig.clockDivider = BSP_CLINT_HZ/(BSP_UART_BAUDRATE*BSP_UART_DATA_LEN)-1;
f90000d4:	06b00793          	li	a5,107
f90000d8:	00f12623          	sw	a5,12(sp)
        uart_applyConfig(BSP_UART_TERMINAL, &uartConfig);    
f90000dc:	00010593          	mv	a1,sp
f90000e0:	f8010537          	lui	a0,0xf8010
f90000e4:	f75ff0ef          	jal	ra,f9000058 <uart_applyConfig>
    }
f90000e8:	01c12083          	lw	ra,28(sp)
f90000ec:	02010113          	addi	sp,sp,32
f90000f0:	00008067          	ret

f90000f4 <spi_cmdAvailability>:
f90000f4:	00452503          	lw	a0,4(a0) # f8010004 <__global_pointer$+0xff00f234>
        u32 ssDisable;
    } Spi_Config;
    
    static u32 spi_cmdAvailability(u32 reg){
        return read_u32(reg + SPI_BUFFER) & 0xFFFF;
    }
f90000f8:	01051513          	slli	a0,a0,0x10
f90000fc:	01055513          	srli	a0,a0,0x10
f9000100:	00008067          	ret

f9000104 <spi_rspOccupancy>:
f9000104:	00452503          	lw	a0,4(a0)
    static u32 spi_rspOccupancy(u32 reg){
        return read_u32(reg + SPI_BUFFER) >> 16;
    }
f9000108:	01055513          	srli	a0,a0,0x10
f900010c:	00008067          	ret

f9000110 <spi_write>:
    
    static void spi_write(u32 reg, u8 data){
f9000110:	ff010113          	addi	sp,sp,-16
f9000114:	00112623          	sw	ra,12(sp)
f9000118:	00812423          	sw	s0,8(sp)
f900011c:	00912223          	sw	s1,4(sp)
f9000120:	00050413          	mv	s0,a0
f9000124:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
f9000128:	00040513          	mv	a0,s0
f900012c:	fc9ff0ef          	jal	ra,f90000f4 <spi_cmdAvailability>
f9000130:	fe050ce3          	beqz	a0,f9000128 <spi_write+0x18>
        write_u32(data | SPI_CMD_WRITE, reg + SPI_DATA);
f9000134:	1004e493          	ori	s1,s1,256
        *((volatile u32*) address) = data;
f9000138:	00942023          	sw	s1,0(s0)
    }
f900013c:	00c12083          	lw	ra,12(sp)
f9000140:	00812403          	lw	s0,8(sp)
f9000144:	00412483          	lw	s1,4(sp)
f9000148:	01010113          	addi	sp,sp,16
f900014c:	00008067          	ret

f9000150 <spi_read>:
    
    static u8 spi_read(u32 reg){
f9000150:	ff010113          	addi	sp,sp,-16
f9000154:	00112623          	sw	ra,12(sp)
f9000158:	00812423          	sw	s0,8(sp)
f900015c:	00050413          	mv	s0,a0
        while(spi_cmdAvailability(reg) == 0);
f9000160:	00040513          	mv	a0,s0
f9000164:	f91ff0ef          	jal	ra,f90000f4 <spi_cmdAvailability>
f9000168:	fe050ce3          	beqz	a0,f9000160 <spi_read+0x10>
f900016c:	20000793          	li	a5,512
f9000170:	00f42023          	sw	a5,0(s0)
        write_u32(SPI_CMD_READ, reg + SPI_DATA);
        while(spi_rspOccupancy(reg) == 0);
f9000174:	00040513          	mv	a0,s0
f9000178:	f8dff0ef          	jal	ra,f9000104 <spi_rspOccupancy>
f900017c:	fe050ce3          	beqz	a0,f9000174 <spi_read+0x24>
        return *((volatile u32*) address);
f9000180:	00042503          	lw	a0,0(s0)
        return read_u32(reg + SPI_DATA);
    }
f9000184:	0ff57513          	andi	a0,a0,255
f9000188:	00c12083          	lw	ra,12(sp)
f900018c:	00812403          	lw	s0,8(sp)
f9000190:	01010113          	addi	sp,sp,16
f9000194:	00008067          	ret

f9000198 <spi_select>:
        write_u32(SPI_CMD_READ, reg + SPI_DATA);
        while(spi_rspOccupancy(reg) == 0);
        return read_u32(reg + SPI_READ_LARGE);
    }
    
    static void spi_select(u32 reg, u32 slaveId){
f9000198:	ff010113          	addi	sp,sp,-16
f900019c:	00112623          	sw	ra,12(sp)
f90001a0:	00812423          	sw	s0,8(sp)
f90001a4:	00912223          	sw	s1,4(sp)
f90001a8:	00050413          	mv	s0,a0
f90001ac:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
f90001b0:	00040513          	mv	a0,s0
f90001b4:	f41ff0ef          	jal	ra,f90000f4 <spi_cmdAvailability>
f90001b8:	fe050ce3          	beqz	a0,f90001b0 <spi_select+0x18>
        write_u32(slaveId | 0x80 | SPI_CMD_SS, reg + SPI_DATA);
f90001bc:	000017b7          	lui	a5,0x1
f90001c0:	88078793          	addi	a5,a5,-1920 # 880 <__stack_size+0x780>
f90001c4:	00f4e4b3          	or	s1,s1,a5
        *((volatile u32*) address) = data;
f90001c8:	00942023          	sw	s1,0(s0)
    }
f90001cc:	00c12083          	lw	ra,12(sp)
f90001d0:	00812403          	lw	s0,8(sp)
f90001d4:	00412483          	lw	s1,4(sp)
f90001d8:	01010113          	addi	sp,sp,16
f90001dc:	00008067          	ret

f90001e0 <spi_diselect>:
    
    static void spi_diselect(u32 reg, u32 slaveId){
f90001e0:	ff010113          	addi	sp,sp,-16
f90001e4:	00112623          	sw	ra,12(sp)
f90001e8:	00812423          	sw	s0,8(sp)
f90001ec:	00912223          	sw	s1,4(sp)
f90001f0:	00050413          	mv	s0,a0
f90001f4:	00058493          	mv	s1,a1
        while(spi_cmdAvailability(reg) == 0);
f90001f8:	00040513          	mv	a0,s0
f90001fc:	ef9ff0ef          	jal	ra,f90000f4 <spi_cmdAvailability>
f9000200:	fe050ce3          	beqz	a0,f90001f8 <spi_diselect+0x18>
        write_u32(slaveId | 0x00 | SPI_CMD_SS, reg + SPI_DATA);
f9000204:	000017b7          	lui	a5,0x1
f9000208:	80078793          	addi	a5,a5,-2048 # 800 <__stack_size+0x700>
f900020c:	00f4e4b3          	or	s1,s1,a5
f9000210:	00942023          	sw	s1,0(s0)
    }
f9000214:	00c12083          	lw	ra,12(sp)
f9000218:	00812403          	lw	s0,8(sp)
f900021c:	00412483          	lw	s1,4(sp)
f9000220:	01010113          	addi	sp,sp,16
f9000224:	00008067          	ret

f9000228 <spi_applyConfig>:
    
    static void spi_applyConfig(u32 reg, Spi_Config *config){
        write_u32((config->cpol << 0) | (config->cpha << 1) | (config->mode << 4), reg + SPI_CONFIG);
f9000228:	0005a783          	lw	a5,0(a1)
f900022c:	0045a703          	lw	a4,4(a1)
f9000230:	00171713          	slli	a4,a4,0x1
f9000234:	00e7e7b3          	or	a5,a5,a4
f9000238:	0085a703          	lw	a4,8(a1)
f900023c:	00471713          	slli	a4,a4,0x4
f9000240:	00e7e7b3          	or	a5,a5,a4
f9000244:	00f52423          	sw	a5,8(a0)
        write_u32(config->clkDivider, reg + SPI_CLK_DIVIDER);
f9000248:	00c5a783          	lw	a5,12(a1)
f900024c:	02f52023          	sw	a5,32(a0)
        write_u32(config->ssSetup, reg + SPI_SS_SETUP);
f9000250:	0105a783          	lw	a5,16(a1)
f9000254:	02f52223          	sw	a5,36(a0)
        write_u32(config->ssHold, reg + SPI_SS_HOLD);
f9000258:	0145a783          	lw	a5,20(a1)
f900025c:	02f52423          	sw	a5,40(a0)
        write_u32(config->ssDisable, reg + SPI_SS_DISABLE);
f9000260:	0185a783          	lw	a5,24(a1)
f9000264:	02f52623          	sw	a5,44(a0)
    }
f9000268:	00008067          	ret

f900026c <spi_waitXferBusy>:
    /**
    * Wait for SPI Transfer to complete
    * 
    * @param reg SPI base address 
    */
    static void spi_waitXferBusy(u32 reg){
f900026c:	ff010113          	addi	sp,sp,-16
f9000270:	00112623          	sw	ra,12(sp)
f9000274:	00812423          	sw	s0,8(sp)
f9000278:	00050413          	mv	s0,a0
    	bsp_uDelay(1);
f900027c:	f8b00637          	lui	a2,0xf8b00
f9000280:	05f5e5b7          	lui	a1,0x5f5e
f9000284:	10058593          	addi	a1,a1,256 # 5f5e100 <__stack_size+0x5f5e000>
f9000288:	00100513          	li	a0,1
f900028c:	dfdff0ef          	jal	ra,f9000088 <clint_uDelay>
    	while(spi_cmdAvailability(reg) != 256);
f9000290:	00040513          	mv	a0,s0
f9000294:	e61ff0ef          	jal	ra,f90000f4 <spi_cmdAvailability>
f9000298:	10000793          	li	a5,256
f900029c:	fef51ae3          	bne	a0,a5,f9000290 <spi_waitXferBusy+0x24>
    }
f90002a0:	00c12083          	lw	ra,12(sp)
f90002a4:	00812403          	lw	s0,8(sp)
f90002a8:	01010113          	addi	sp,sp,16
f90002ac:	00008067          	ret

f90002b0 <spiFlash_select>:
    * Set SPI Flash device Chip Select
    * 
    * @param spi SPI port base address 
    * @param cs 32-bit bitwise setting. Set 1 to enable particular bit. 
    */
    static void spiFlash_select(u32 spi, u32 cs){
f90002b0:	ff010113          	addi	sp,sp,-16
f90002b4:	00112623          	sw	ra,12(sp)
        spi_select(spi, cs);
f90002b8:	ee1ff0ef          	jal	ra,f9000198 <spi_select>
    }
f90002bc:	00c12083          	lw	ra,12(sp)
f90002c0:	01010113          	addi	sp,sp,16
f90002c4:	00008067          	ret

f90002c8 <spiFlash_diselect>:
    * Clear SPI Flash device Chip Select
    * 
    * @param spi SPI port base address 
    * @param cs 32-bit bitwise setting. Set 1 to disable particular bit. 
    */ 
    static void spiFlash_diselect(u32 spi, u32 cs){
f90002c8:	ff010113          	addi	sp,sp,-16
f90002cc:	00112623          	sw	ra,12(sp)
        spi_diselect(spi, cs);
f90002d0:	f11ff0ef          	jal	ra,f90001e0 <spi_diselect>
    }
f90002d4:	00c12083          	lw	ra,12(sp)
f90002d8:	01010113          	addi	sp,sp,16
f90002dc:	00008067          	ret

f90002e0 <spiFlash_init_>:
    /**
    * Initialize SPI port with default settings 
    * 
    * @param spi SPI port base address
    */
    static void spiFlash_init_(u32 spi){
f90002e0:	fd010113          	addi	sp,sp,-48
f90002e4:	02112623          	sw	ra,44(sp)
f90002e8:	02812423          	sw	s0,40(sp)
f90002ec:	00050413          	mv	s0,a0
        Spi_Config spiCfg;
        spiCfg.cpol = 0;
f90002f0:	00012223          	sw	zero,4(sp)
        spiCfg.cpha = 0;
f90002f4:	00012423          	sw	zero,8(sp)
        spiCfg.mode = 0;
f90002f8:	00012623          	sw	zero,12(sp)
        spiCfg.clkDivider = 2;
f90002fc:	00200793          	li	a5,2
f9000300:	00f12823          	sw	a5,16(sp)
        spiCfg.ssSetup = 2;
f9000304:	00f12a23          	sw	a5,20(sp)
        spiCfg.ssHold = 2;
f9000308:	00f12c23          	sw	a5,24(sp)
        spiCfg.ssDisable = 2;
f900030c:	00f12e23          	sw	a5,28(sp)
        spi_applyConfig(spi, &spiCfg);
f9000310:	00410593          	addi	a1,sp,4
f9000314:	f15ff0ef          	jal	ra,f9000228 <spi_applyConfig>
        spi_waitXferBusy(spi); 
f9000318:	00040513          	mv	a0,s0
f900031c:	f51ff0ef          	jal	ra,f900026c <spi_waitXferBusy>
    }
f9000320:	02c12083          	lw	ra,44(sp)
f9000324:	02812403          	lw	s0,40(sp)
f9000328:	03010113          	addi	sp,sp,48
f900032c:	00008067          	ret

f9000330 <spiFlash_init>:
    * 
    * @param spi SPI port base address
    * @param gpio GPIO port base address 
    * @param cs 32-bit bitwise chip select setting.
    */
    static void spiFlash_init(u32 spi, u32 cs){
f9000330:	ff010113          	addi	sp,sp,-16
f9000334:	00112623          	sw	ra,12(sp)
f9000338:	00812423          	sw	s0,8(sp)
f900033c:	00912223          	sw	s1,4(sp)
f9000340:	00050413          	mv	s0,a0
f9000344:	00058493          	mv	s1,a1
        spiFlash_init_(spi);
f9000348:	f99ff0ef          	jal	ra,f90002e0 <spiFlash_init_>
        spiFlash_diselect(spi, cs);
f900034c:	00048593          	mv	a1,s1
f9000350:	00040513          	mv	a0,s0
f9000354:	f75ff0ef          	jal	ra,f90002c8 <spiFlash_diselect>
    }
f9000358:	00c12083          	lw	ra,12(sp)
f900035c:	00812403          	lw	s0,8(sp)
f9000360:	00412483          	lw	s1,4(sp)
f9000364:	01010113          	addi	sp,sp,16
f9000368:	00008067          	ret

f900036c <spiFlash_wake_>:
    * Define DEFAULT_ADDRESS_BYTE to include command to return
    * to 3-byte addressing mode. 
    * 
    * @param spi SPI port base address
    */
    static void spiFlash_wake_(u32 spi){
f900036c:	ff010113          	addi	sp,sp,-16
f9000370:	00112623          	sw	ra,12(sp)
        spi_write(spi, 0xAB);
f9000374:	0ab00593          	li	a1,171
f9000378:	d99ff0ef          	jal	ra,f9000110 <spi_write>
#if defined(DEFAULT_ADDRESS_BYTE) || defined(MX25_FLASH)
        //return to 3-byte addressing
        bsp_uDelay(300);
        spi_write(spi, 0xE9);
#endif
    }
f900037c:	00c12083          	lw	ra,12(sp)
f9000380:	01010113          	addi	sp,sp,16
f9000384:	00008067          	ret

f9000388 <spiFlash_wake>:
    * Wake up the Spi Flash with chip select
    * 
    * @param spi SPI port base address
    * @param cs 32-bit bitwise chip select setting.
    */
    static void spiFlash_wake(u32 spi, u32 cs){
f9000388:	ff010113          	addi	sp,sp,-16
f900038c:	00112623          	sw	ra,12(sp)
f9000390:	00812423          	sw	s0,8(sp)
f9000394:	00912223          	sw	s1,4(sp)
f9000398:	00050413          	mv	s0,a0
f900039c:	00058493          	mv	s1,a1
        spiFlash_select(spi,cs);
f90003a0:	f11ff0ef          	jal	ra,f90002b0 <spiFlash_select>
        spiFlash_wake_(spi);
f90003a4:	00040513          	mv	a0,s0
f90003a8:	fc5ff0ef          	jal	ra,f900036c <spiFlash_wake_>
        spiFlash_diselect(spi,cs);
f90003ac:	00048593          	mv	a1,s1
f90003b0:	00040513          	mv	a0,s0
f90003b4:	f15ff0ef          	jal	ra,f90002c8 <spiFlash_diselect>
        spi_waitXferBusy(spi);
f90003b8:	00040513          	mv	a0,s0
f90003bc:	eb1ff0ef          	jal	ra,f900026c <spi_waitXferBusy>
    }
f90003c0:	00c12083          	lw	ra,12(sp)
f90003c4:	00812403          	lw	s0,8(sp)
f90003c8:	00412483          	lw	s1,4(sp)
f90003cc:	01010113          	addi	sp,sp,16
f90003d0:	00008067          	ret

f90003d4 <spiFlash_f2m_>:
    * @param spi SPI port base address
    * @param flashAddress The flash address to read the data
    * @param memoryAddress The RAM address to write the data
    * @param size The size of data to copy
    */
    static void spiFlash_f2m_(u32 spi, u32 flashAddress, u32 memoryAddress, u32 size){
f90003d4:	fe010113          	addi	sp,sp,-32
f90003d8:	00112e23          	sw	ra,28(sp)
f90003dc:	00812c23          	sw	s0,24(sp)
f90003e0:	00912a23          	sw	s1,20(sp)
f90003e4:	01212823          	sw	s2,16(sp)
f90003e8:	01312623          	sw	s3,12(sp)
f90003ec:	00050913          	mv	s2,a0
f90003f0:	00058493          	mv	s1,a1
f90003f4:	00060413          	mv	s0,a2
f90003f8:	00068993          	mv	s3,a3
        spi_write(spi, 0x0B);
f90003fc:	00b00593          	li	a1,11
f9000400:	d11ff0ef          	jal	ra,f9000110 <spi_write>
        spi_write(spi, flashAddress >> 16);
f9000404:	0104d593          	srli	a1,s1,0x10
f9000408:	0ff5f593          	andi	a1,a1,255
f900040c:	00090513          	mv	a0,s2
f9000410:	d01ff0ef          	jal	ra,f9000110 <spi_write>
        spi_write(spi, flashAddress >>  8);
f9000414:	0084d593          	srli	a1,s1,0x8
f9000418:	0ff5f593          	andi	a1,a1,255
f900041c:	00090513          	mv	a0,s2
f9000420:	cf1ff0ef          	jal	ra,f9000110 <spi_write>
        spi_write(spi, flashAddress >>  0);
f9000424:	0ff4f593          	andi	a1,s1,255
f9000428:	00090513          	mv	a0,s2
f900042c:	ce5ff0ef          	jal	ra,f9000110 <spi_write>
        spi_write(spi, 0);
f9000430:	00000593          	li	a1,0
f9000434:	00090513          	mv	a0,s2
f9000438:	cd9ff0ef          	jal	ra,f9000110 <spi_write>
        uint8_t *ram = (uint8_t *) memoryAddress;
        for(u32 idx = 0;idx < size;idx++){
f900043c:	00000493          	li	s1,0
f9000440:	0134fe63          	bgeu	s1,s3,f900045c <spiFlash_f2m_+0x88>
            u8 value = spi_read(spi);
f9000444:	00090513          	mv	a0,s2
f9000448:	d09ff0ef          	jal	ra,f9000150 <spi_read>
            *ram++ = value;
f900044c:	00a40023          	sb	a0,0(s0)
        for(u32 idx = 0;idx < size;idx++){
f9000450:	00148493          	addi	s1,s1,1
            *ram++ = value;
f9000454:	00140413          	addi	s0,s0,1
f9000458:	fe9ff06f          	j	f9000440 <spiFlash_f2m_+0x6c>
        }
    }
f900045c:	01c12083          	lw	ra,28(sp)
f9000460:	01812403          	lw	s0,24(sp)
f9000464:	01412483          	lw	s1,20(sp)
f9000468:	01012903          	lw	s2,16(sp)
f900046c:	00c12983          	lw	s3,12(sp)
f9000470:	02010113          	addi	sp,sp,32
f9000474:	00008067          	ret

f9000478 <spiFlash_f2m>:
    * @param cs 32-bit bitwise chip select setting
    * @param flashAddress The flash address to read the data
    * @param memoryAddress The RAM address to write the data
    * @param size The size of data to copy
    */ 
    static void spiFlash_f2m(u32 spi, u32 cs, u32 flashAddress, u32 memoryAddress, u32 size){
f9000478:	fe010113          	addi	sp,sp,-32
f900047c:	00112e23          	sw	ra,28(sp)
f9000480:	00812c23          	sw	s0,24(sp)
f9000484:	00912a23          	sw	s1,20(sp)
f9000488:	01212823          	sw	s2,16(sp)
f900048c:	01312623          	sw	s3,12(sp)
f9000490:	01412423          	sw	s4,8(sp)
f9000494:	00050413          	mv	s0,a0
f9000498:	00058493          	mv	s1,a1
f900049c:	00060913          	mv	s2,a2
f90004a0:	00068993          	mv	s3,a3
f90004a4:	00070a13          	mv	s4,a4
        spiFlash_select(spi,cs);
f90004a8:	e09ff0ef          	jal	ra,f90002b0 <spiFlash_select>
        spiFlash_f2m_(spi, flashAddress, memoryAddress, size);
f90004ac:	000a0693          	mv	a3,s4
f90004b0:	00098613          	mv	a2,s3
f90004b4:	00090593          	mv	a1,s2
f90004b8:	00040513          	mv	a0,s0
f90004bc:	f19ff0ef          	jal	ra,f90003d4 <spiFlash_f2m_>
        spiFlash_diselect(spi,cs);
f90004c0:	00048593          	mv	a1,s1
f90004c4:	00040513          	mv	a0,s0
f90004c8:	e01ff0ef          	jal	ra,f90002c8 <spiFlash_diselect>
    }
f90004cc:	01c12083          	lw	ra,28(sp)
f90004d0:	01812403          	lw	s0,24(sp)
f90004d4:	01412483          	lw	s1,20(sp)
f90004d8:	01012903          	lw	s2,16(sp)
f90004dc:	00c12983          	lw	s3,12(sp)
f90004e0:	00812a03          	lw	s4,8(sp)
f90004e4:	02010113          	addi	sp,sp,32
f90004e8:	00008067          	ret

f90004ec <bspMain>:
#define USER_SOFTWARE_FLASH    0x480000
#define USER_SOFTWARE_SIZE	   0x6BC0

#define SINGLE_SPI 1 //define DUAL_SPI for dual data SPI or QUAD_SPI for quad data SPI

void bspMain() {
f90004ec:	ff010113          	addi	sp,sp,-16
f90004f0:	00112623          	sw	ra,12(sp)
#ifndef SIM
	spiFlash_init(SPI, SPI_CS);
f90004f4:	00000593          	li	a1,0
f90004f8:	f8014537          	lui	a0,0xf8014
f90004fc:	e35ff0ef          	jal	ra,f9000330 <spiFlash_init>
	spiFlash_wake(SPI, SPI_CS);
f9000500:	00000593          	li	a1,0
f9000504:	f8014537          	lui	a0,0xf8014
f9000508:	e81ff0ef          	jal	ra,f9000388 <spiFlash_wake>
#ifdef SINGLE_SPI
	spiFlash_f2m(SPI, SPI_CS, USER_SOFTWARE_FLASH, USER_SOFTWARE_MEMORY, USER_SOFTWARE_SIZE);
f900050c:	00007737          	lui	a4,0x7
f9000510:	bc070713          	addi	a4,a4,-1088 # 6bc0 <__stack_size+0x6ac0>
f9000514:	f90006b7          	lui	a3,0xf9000
f9000518:	00480637          	lui	a2,0x480
f900051c:	00000593          	li	a1,0
f9000520:	f8014537          	lui	a0,0xf8014
f9000524:	f55ff0ef          	jal	ra,f9000478 <spiFlash_f2m>

	void (*userMain)() = (void (*)())USER_SOFTWARE_MEMORY;
    #ifdef SMP
        smp_unlock(userMain);
    #endif
	userMain();
f9000528:	f90007b7          	lui	a5,0xf9000
f900052c:	000780e7          	jalr	a5 # f9000000 <__global_pointer$+0xfffff230>
}
f9000530:	00c12083          	lw	ra,12(sp)
f9000534:	01010113          	addi	sp,sp,16
f9000538:	00008067          	ret

f900053c <main>:
///////////////////////////////////////////////////////////////////////////////////
#include "type.h"
#include "bsp.h"
#include "bootloaderConfig.h"

void main() {
f900053c:	ff010113          	addi	sp,sp,-16
f9000540:	00112623          	sw	ra,12(sp)
    bsp_init();
f9000544:	b79ff0ef          	jal	ra,f90000bc <bsp_init>
    bspMain();
f9000548:	fa5ff0ef          	jal	ra,f90004ec <bspMain>
}
f900054c:	00c12083          	lw	ra,12(sp)
f9000550:	01010113          	addi	sp,sp,16
f9000554:	00008067          	ret

f9000558 <__libc_init_array>:
f9000558:	ff010113          	addi	sp,sp,-16
f900055c:	00812423          	sw	s0,8(sp)
f9000560:	01212023          	sw	s2,0(sp)
f9000564:	80c18413          	addi	s0,gp,-2036 # f90005dc <_data>
f9000568:	80c18913          	addi	s2,gp,-2036 # f90005dc <_data>
f900056c:	40890933          	sub	s2,s2,s0
f9000570:	00112623          	sw	ra,12(sp)
f9000574:	00912223          	sw	s1,4(sp)
f9000578:	40295913          	srai	s2,s2,0x2
f900057c:	00090e63          	beqz	s2,f9000598 <__libc_init_array+0x40>
f9000580:	00000493          	li	s1,0
f9000584:	00042783          	lw	a5,0(s0)
f9000588:	00148493          	addi	s1,s1,1
f900058c:	00440413          	addi	s0,s0,4
f9000590:	000780e7          	jalr	a5
f9000594:	fe9918e3          	bne	s2,s1,f9000584 <__libc_init_array+0x2c>
f9000598:	80c18413          	addi	s0,gp,-2036 # f90005dc <_data>
f900059c:	80c18913          	addi	s2,gp,-2036 # f90005dc <_data>
f90005a0:	40890933          	sub	s2,s2,s0
f90005a4:	40295913          	srai	s2,s2,0x2
f90005a8:	00090e63          	beqz	s2,f90005c4 <__libc_init_array+0x6c>
f90005ac:	00000493          	li	s1,0
f90005b0:	00042783          	lw	a5,0(s0)
f90005b4:	00148493          	addi	s1,s1,1
f90005b8:	00440413          	addi	s0,s0,4
f90005bc:	000780e7          	jalr	a5
f90005c0:	fe9918e3          	bne	s2,s1,f90005b0 <__libc_init_array+0x58>
f90005c4:	00c12083          	lw	ra,12(sp)
f90005c8:	00812403          	lw	s0,8(sp)
f90005cc:	00412483          	lw	s1,4(sp)
f90005d0:	00012903          	lw	s2,0(sp)
f90005d4:	01010113          	addi	sp,sp,16
f90005d8:	00008067          	ret
