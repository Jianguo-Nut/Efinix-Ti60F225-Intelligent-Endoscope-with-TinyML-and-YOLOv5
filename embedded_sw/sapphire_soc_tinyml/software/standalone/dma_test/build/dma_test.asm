
build/dma_test.elf:     file format elf32-littleriscv


Disassembly of section .init:

00001000 <_start>:

_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
    1000:	00007197          	auipc	gp,0x7
    1004:	7f018193          	addi	gp,gp,2032 # 87f0 <__global_pointer$>

00001008 <init>:
	sw a0, smp_lottery_lock, a1
    ret
#endif

init:
	la sp, _sp
    1008:	00208117          	auipc	sp,0x208
    100c:	ec810113          	addi	sp,sp,-312 # 208ed0 <__freertos_irq_stack_top>

	/* Load data section */
	la a0, _data_lma
    1010:	00006517          	auipc	a0,0x6
    1014:	7fc50513          	addi	a0,a0,2044 # 780c <_data>
	la a1, _data
    1018:	00006597          	auipc	a1,0x6
    101c:	7f458593          	addi	a1,a1,2036 # 780c <_data>
	la a2, _edata
    1020:	83418613          	addi	a2,gp,-1996 # 8024 <display_mm2s_active>
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
    103c:	83418513          	addi	a0,gp,-1996 # 8024 <display_mm2s_active>
	la a1, _end
    1040:	6e018593          	addi	a1,gp,1760 # 8ed0 <_end>
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
    1058:	12c010ef          	jal	ra,2184 <main>

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
    1078:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5ef0af>
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
    1120:	00006417          	auipc	s0,0x6
    1124:	6ec40413          	addi	s0,s0,1772 # 780c <_data>
    1128:	00006917          	auipc	s2,0x6
    112c:	6e490913          	addi	s2,s2,1764 # 780c <_data>
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
    115c:	00006417          	auipc	s0,0x6
    1160:	6b040413          	addi	s0,s0,1712 # 780c <_data>
    1164:	00006917          	auipc	s2,0x6
    1168:	6a890913          	addi	s2,s2,1704 # 780c <_data>
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
    11c8:	eff60613          	addi	a2,a2,-257 # fefefeff <__freertos_irq_stack_top+0xfede702f>
    11cc:	00c707b3          	add	a5,a4,a2
    11d0:	808086b7          	lui	a3,0x80808
    11d4:	fff74713          	not	a4,a4
    11d8:	08068693          	addi	a3,a3,128 # 80808080 <__freertos_irq_stack_top+0x805ff1b0>
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
    1258:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__freertos_irq_stack_top+0x7f5ef0af>
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

000012d4 <plic_set_priority>:
#define PLIC_CLAIM_BASE         0x200004
#define PLIC_ENABLE_PER_HART    0x80
#define PLIC_CONTEXT_PER_HART   0x1000

    static void plic_set_priority(u32 plic, u32 gateway, u32 priority){
        write_u32(priority, plic + PLIC_PRIORITY_BASE + gateway*4);
    12d4:	00259593          	slli	a1,a1,0x2
    12d8:	00a585b3          	add	a1,a1,a0
    static inline u32 read_u32(u32 address){
        return *((volatile u32*) address);
    }
    
    static inline void write_u32(u32 data, u32 address){
        *((volatile u32*) address) = data;
    12dc:	00c5a023          	sw	a2,0(a1)
    }
    12e0:	00008067          	ret

000012e4 <plic_set_enable>:
    static u32 plic_get_priority(u32 plic, u32 gateway){
        return read_u32(plic + PLIC_PRIORITY_BASE + gateway*4);
    }
    
    static void plic_set_enable(u32 plic, u32 target,u32 gateway, u32 enable){
        u32 word = plic + PLIC_ENABLE_BASE + target * PLIC_ENABLE_PER_HART + (gateway / 32 * 4);
    12e4:	00759593          	slli	a1,a1,0x7
    12e8:	00a58533          	add	a0,a1,a0
    12ec:	00565593          	srli	a1,a2,0x5
    12f0:	00259593          	slli	a1,a1,0x2
    12f4:	00b50533          	add	a0,a0,a1
    12f8:	000025b7          	lui	a1,0x2
    12fc:	00b50533          	add	a0,a0,a1
        u32 mask = 1 << (gateway % 32);
    1300:	00100793          	li	a5,1
    1304:	00c797b3          	sll	a5,a5,a2
        if (enable)
    1308:	00068a63          	beqz	a3,131c <plic_set_enable+0x38>
        return *((volatile u32*) address);
    130c:	00052603          	lw	a2,0(a0)
            write_u32(read_u32(word) | mask, word);
    1310:	00c7e7b3          	or	a5,a5,a2
        *((volatile u32*) address) = data;
    1314:	00f52023          	sw	a5,0(a0)
    1318:	00008067          	ret
        return *((volatile u32*) address);
    131c:	00052603          	lw	a2,0(a0)
        else
            write_u32(read_u32(word) & ~mask, word);
    1320:	fff7c793          	not	a5,a5
    1324:	00c7f7b3          	and	a5,a5,a2
        *((volatile u32*) address) = data;
    1328:	00f52023          	sw	a5,0(a0)
    }
    132c:	00008067          	ret

00001330 <plic_set_threshold>:
    
    static void plic_set_threshold(u32 plic, u32 target, u32 threshold){
        write_u32(threshold, plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
    1330:	00c59593          	slli	a1,a1,0xc
    1334:	00a585b3          	add	a1,a1,a0
    1338:	00200537          	lui	a0,0x200
    133c:	00a585b3          	add	a1,a1,a0
    1340:	00c5a023          	sw	a2,0(a1) # 2000 <trigger_next_display_dma>
    }
    1344:	00008067          	ret

00001348 <plic_claim>:
    static u32 plic_get_threshold(u32 plic, u32 target){
        return read_u32(plic + PLIC_THRESHOLD_BASE + target*PLIC_CONTEXT_PER_HART);
    }
    
    static u32 plic_claim(u32 plic, u32 target){
        return read_u32(plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
    1348:	00c59593          	slli	a1,a1,0xc
    134c:	00a585b3          	add	a1,a1,a0
    1350:	00200537          	lui	a0,0x200
    1354:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x4>
    1358:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
    135c:	0005a503          	lw	a0,0(a1)
    }
    1360:	00008067          	ret

00001364 <plic_release>:
    
    static void plic_release(u32 plic, u32 target, u32 gateway){
        write_u32(gateway,plic + PLIC_CLAIM_BASE + target*PLIC_CONTEXT_PER_HART);
    1364:	00c59593          	slli	a1,a1,0xc
    1368:	00a585b3          	add	a1,a1,a0
    136c:	00200537          	lui	a0,0x200
    1370:	00450513          	addi	a0,a0,4 # 200004 <__stack_size+0x4>
    1374:	00a585b3          	add	a1,a1,a0
        *((volatile u32*) address) = data;
    1378:	00c5a023          	sw	a2,0(a1)
    }
    137c:	00008067          	ret

00001380 <uart_writeAvailability>:
        return *((volatile u32*) address);
    1380:	00452503          	lw	a0,4(a0)
        enum UartStop stop;
        u32 clockDivider;
    } Uart_Config;
    
    static u32 uart_writeAvailability(u32 reg){
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    1384:	01055513          	srli	a0,a0,0x10
    }
    1388:	0ff57513          	andi	a0,a0,255
    138c:	00008067          	ret

00001390 <uart_write>:
    static u32 uart_readOccupancy(u32 reg){
        return read_u32(reg + UART_STATUS) >> 24;
    }
    
    static void uart_write(u32 reg, char data){
    1390:	ff010113          	addi	sp,sp,-16
    1394:	00112623          	sw	ra,12(sp)
    1398:	00812423          	sw	s0,8(sp)
    139c:	00912223          	sw	s1,4(sp)
    13a0:	00050413          	mv	s0,a0
    13a4:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    13a8:	00040513          	mv	a0,s0
    13ac:	fd5ff0ef          	jal	ra,1380 <uart_writeAvailability>
    13b0:	fe050ce3          	beqz	a0,13a8 <uart_write+0x18>
        *((volatile u32*) address) = data;
    13b4:	00942023          	sw	s1,0(s0)
        write_u32(data, reg + UART_DATA);
    }
    13b8:	00c12083          	lw	ra,12(sp)
    13bc:	00812403          	lw	s0,8(sp)
    13c0:	00412483          	lw	s1,4(sp)
    13c4:	01010113          	addi	sp,sp,16
    13c8:	00008067          	ret

000013cc <uart_writeStr>:
    
    static void uart_writeStr(u32 reg, const char* str){
    13cc:	ff010113          	addi	sp,sp,-16
    13d0:	00112623          	sw	ra,12(sp)
    13d4:	00812423          	sw	s0,8(sp)
    13d8:	00912223          	sw	s1,4(sp)
    13dc:	00050493          	mv	s1,a0
    13e0:	00058413          	mv	s0,a1
        while(*str) uart_write(reg, *str++);
    13e4:	00044583          	lbu	a1,0(s0)
    13e8:	00058a63          	beqz	a1,13fc <uart_writeStr+0x30>
    13ec:	00140413          	addi	s0,s0,1
    13f0:	00048513          	mv	a0,s1
    13f4:	f9dff0ef          	jal	ra,1390 <uart_write>
    13f8:	fedff06f          	j	13e4 <uart_writeStr+0x18>
    }
    13fc:	00c12083          	lw	ra,12(sp)
    1400:	00812403          	lw	s0,8(sp)
    1404:	00412483          	lw	s1,4(sp)
    1408:	01010113          	addi	sp,sp,16
    140c:	00008067          	ret

00001410 <dmasg_busy>:
        write_u32(mask, ca+DMASG_CHANNEL_INTERRUPT_PENDING);
    }
    
    // Check the status of the specified channel.
    static u32 dmasg_busy(u32 base, u32 channel){
        u32 ca = dmasg_ca(base, channel);
    1410:	00759593          	slli	a1,a1,0x7
    1414:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
    1418:	02c5a503          	lw	a0,44(a1)
        return read_u32(ca + DMASG_CHANNEL_STATUS) & DMASG_CHANNEL_STATUS_BUSY;
    }
    141c:	00157513          	andi	a0,a0,1
    1420:	00008067          	ret

00001424 <crash>:

/********************************* Function **********************************/
//Used on unexpected trap/interrupt codes


void crash(){
    1424:	ff010113          	addi	sp,sp,-16
    1428:	00112623          	sw	ra,12(sp)
	uart_writeStr(BSP_UART_TERMINAL, "\n*** CRASH ***\n");
    142c:	000085b7          	lui	a1,0x8
    1430:	81058593          	addi	a1,a1,-2032 # 7810 <_data+0x4>
    1434:	f8010537          	lui	a0,0xf8010
    1438:	f95ff0ef          	jal	ra,13cc <uart_writeStr>
	while(1);
    143c:	0000006f          	j	143c <crash+0x18>

00001440 <userInterrupt>:
}


void userInterrupt(){
    1440:	ff010113          	addi	sp,sp,-16
    1444:	00112623          	sw	ra,12(sp)
    1448:	00812423          	sw	s0,8(sp)
    uint32_t claim;
    //While there is pending interrupts
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
    144c:	0300006f          	j	147c <userInterrupt+0x3c>
       switch(claim){
       case SYSTEM_PLIC_USER_INTERRUPT_B_INTERRUPT: //DMA channels share single interrupt
          if(cam_s2mm_active && !(dmasg_busy(DMASG_BASE, DMASG_CAM_S2MM_CHANNEL))) {
    1450:	00000593          	li	a1,0
    1454:	f8100537          	lui	a0,0xf8100
    1458:	fb9ff0ef          	jal	ra,1410 <dmasg_busy>
    145c:	04051263          	bnez	a0,14a0 <userInterrupt+0x60>
             trigger_next_cam_dma();
    1460:	4a5000ef          	jal	ra,2104 <trigger_next_cam_dma>
    1464:	03c0006f          	j	14a0 <userInterrupt+0x60>
          }
          if(display_mm2s_active && !(dmasg_busy(DMASG_BASE, DMASG_DISPLAY_MM2S_CHANNEL))){
             trigger_next_display_dma();
          }
          break;
       default: crash(); break;
    1468:	fbdff0ef          	jal	ra,1424 <crash>
       }
       plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); //unmask the claimed interrupt
    146c:	00040613          	mv	a2,s0
    1470:	00000593          	li	a1,0
    1474:	f8c00537          	lui	a0,0xf8c00
    1478:	eedff0ef          	jal	ra,1364 <plic_release>
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
    147c:	00000593          	li	a1,0
    1480:	f8c00537          	lui	a0,0xf8c00
    1484:	ec5ff0ef          	jal	ra,1348 <plic_claim>
    1488:	00050413          	mv	s0,a0
    148c:	02050a63          	beqz	a0,14c0 <userInterrupt+0x80>
       switch(claim){
    1490:	01100793          	li	a5,17
    1494:	fcf41ae3          	bne	s0,a5,1468 <userInterrupt+0x28>
          if(cam_s2mm_active && !(dmasg_busy(DMASG_BASE, DMASG_CAM_S2MM_CHANNEL))) {
    1498:	8351c783          	lbu	a5,-1995(gp) # 8025 <cam_s2mm_active>
    149c:	fa079ae3          	bnez	a5,1450 <userInterrupt+0x10>
          if(display_mm2s_active && !(dmasg_busy(DMASG_BASE, DMASG_DISPLAY_MM2S_CHANNEL))){
    14a0:	8341c783          	lbu	a5,-1996(gp) # 8024 <display_mm2s_active>
    14a4:	fc0784e3          	beqz	a5,146c <userInterrupt+0x2c>
    14a8:	00100593          	li	a1,1
    14ac:	f8100537          	lui	a0,0xf8100
    14b0:	f61ff0ef          	jal	ra,1410 <dmasg_busy>
    14b4:	fa051ce3          	bnez	a0,146c <userInterrupt+0x2c>
             trigger_next_display_dma();
    14b8:	349000ef          	jal	ra,2000 <trigger_next_display_dma>
    14bc:	fb1ff06f          	j	146c <userInterrupt+0x2c>
    }
}
    14c0:	00c12083          	lw	ra,12(sp)
    14c4:	00812403          	lw	s0,8(sp)
    14c8:	01010113          	addi	sp,sp,16
    14cc:	00008067          	ret

000014d0 <trap>:


//Called by trap_entry on both exceptions and interrupts events
void trap(){
    14d0:	ff010113          	addi	sp,sp,-16
    14d4:	00112623          	sw	ra,12(sp)
	int32_t mcause = csr_read(mcause);
    14d8:	342027f3          	csrr	a5,mcause
	int32_t interrupt = mcause < 0;    //Interrupt if true, exception if false
	int32_t cause     = mcause & 0xF;
	if(interrupt){
    14dc:	0207d263          	bgez	a5,1500 <trap+0x30>
    14e0:	00f7f713          	andi	a4,a5,15
		switch(cause){
    14e4:	00b00793          	li	a5,11
    14e8:	00f71a63          	bne	a4,a5,14fc <trap+0x2c>
		case CAUSE_MACHINE_EXTERNAL: userInterrupt(); break;
    14ec:	f55ff0ef          	jal	ra,1440 <userInterrupt>
		crash();
	}
    
    

}
    14f0:	00c12083          	lw	ra,12(sp)
    14f4:	01010113          	addi	sp,sp,16
    14f8:	00008067          	ret
		default: crash(); break;
    14fc:	f29ff0ef          	jal	ra,1424 <crash>
		crash();
    1500:	f25ff0ef          	jal	ra,1424 <crash>

00001504 <dma_init>:

// void IntcInitialize()
void dma_init()
{
    1504:	ff010113          	addi	sp,sp,-16
    1508:	00112623          	sw	ra,12(sp)
   plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); //cpu 0 accept all interrupts with priority above 0
    150c:	00000613          	li	a2,0
    1510:	00000593          	li	a1,0
    1514:	f8c00537          	lui	a0,0xf8c00
    1518:	e19ff0ef          	jal	ra,1330 <plic_set_threshold>
   
   //enable PLIC DMASG channel 0 interrupt listening (But for the demo, we enable the DMASG internal interrupts later)
   plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_USER_INTERRUPT_B_INTERRUPT, 1);
    151c:	00100693          	li	a3,1
    1520:	01100613          	li	a2,17
    1524:	00000593          	li	a1,0
    1528:	f8c00537          	lui	a0,0xf8c00
    152c:	db9ff0ef          	jal	ra,12e4 <plic_set_enable>
   plic_set_priority(BSP_PLIC, SYSTEM_PLIC_USER_INTERRUPT_B_INTERRUPT, 1);
    1530:	00100613          	li	a2,1
    1534:	01100593          	li	a1,17
    1538:	f8c00537          	lui	a0,0xf8c00
    153c:	d99ff0ef          	jal	ra,12d4 <plic_set_priority>
   
    //enable SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT rising edge interrupt
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT, 1);
    1540:	00100693          	li	a3,1
    1544:	01000613          	li	a2,16
    1548:	00000593          	li	a1,0
    154c:	f8c00537          	lui	a0,0xf8c00
    1550:	d95ff0ef          	jal	ra,12e4 <plic_set_enable>
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT, 1);
    1554:	00100613          	li	a2,1
    1558:	01000593          	li	a1,16
    155c:	f8c00537          	lui	a0,0xf8c00
    1560:	d75ff0ef          	jal	ra,12d4 <plic_set_priority>
   
    //enable riscV interrupts
    csr_write(mtvec, trap_entry); //Set the machine trap vector (../common/trap.S)
    1564:	000037b7          	lui	a5,0x3
    1568:	5e878793          	addi	a5,a5,1512 # 35e8 <trap_entry>
    156c:	30579073          	csrw	mtvec,a5
//  csr_set(mie, MIE_MTIE | MIE_MEIE); //Enable machine timer and external interrupts
    csr_set(mie, MIE_MEIE); //Enable machine timer and external interrupts
    1570:	000017b7          	lui	a5,0x1
    1574:	80078793          	addi	a5,a5,-2048 # 800 <regnum_t6+0x7e1>
    1578:	3047a073          	csrs	mie,a5
    csr_write(mstatus, MSTATUS_MPP | MSTATUS_MIE);
    157c:	000027b7          	lui	a5,0x2
    1580:	80878793          	addi	a5,a5,-2040 # 1808 <bsp_printHex_lower+0x2c>
    1584:	30079073          	csrw	mstatus,a5
}
    1588:	00c12083          	lw	ra,12(sp)
    158c:	01010113          	addi	sp,sp,16
    1590:	00008067          	ret

00001594 <dmasg_input_memory>:
        u32 ca = dmasg_ca(base, channel);
    1594:	00759593          	slli	a1,a1,0x7
    1598:	00a58533          	add	a0,a1,a0
        *((volatile u32*) address) = data;
    159c:	00c52023          	sw	a2,0(a0) # f8c00000 <__freertos_irq_stack_top+0xf89f7130>
        write_u32(DMASG_CHANNEL_INPUT_CONFIG_MEMORY | (byte_per_burst-1 & 0xFFF), ca + DMASG_CHANNEL_INPUT_CONFIG);
    15a0:	fff68693          	addi	a3,a3,-1
    15a4:	000017b7          	lui	a5,0x1
    15a8:	fff78713          	addi	a4,a5,-1 # fff <regnum_t6+0xfe0>
    15ac:	00e6f6b3          	and	a3,a3,a4
    15b0:	00f6e6b3          	or	a3,a3,a5
    15b4:	00d52623          	sw	a3,12(a0)
    }
    15b8:	00008067          	ret

000015bc <dmasg_output_memory>:
        u32 ca = dmasg_ca(base, channel);
    15bc:	00759593          	slli	a1,a1,0x7
    15c0:	00a58533          	add	a0,a1,a0
    15c4:	00c52823          	sw	a2,16(a0)
        write_u32(DMASG_CHANNEL_OUTPUT_CONFIG_MEMORY | (byte_per_burst-1 & 0xFFF), ca + DMASG_CHANNEL_OUTPUT_CONFIG);
    15c8:	fff68693          	addi	a3,a3,-1
    15cc:	000017b7          	lui	a5,0x1
    15d0:	fff78713          	addi	a4,a5,-1 # fff <regnum_t6+0xfe0>
    15d4:	00e6f6b3          	and	a3,a3,a4
    15d8:	00f6e6b3          	or	a3,a3,a5
    15dc:	00d52e23          	sw	a3,28(a0)
    }
    15e0:	00008067          	ret

000015e4 <dmasg_input_stream>:
        u32 ca = dmasg_ca(base, channel);
    15e4:	00759593          	slli	a1,a1,0x7
    15e8:	00a58533          	add	a0,a1,a0
    15ec:	00c52423          	sw	a2,8(a0)
        write_u32(DMASG_CHANNEL_INPUT_CONFIG_STREAM | (completion_on_packet ? DMASG_CHANNEL_INPUT_CONFIG_COMPLETION_ON_PACKET : 0) | 
    15f0:	00070e63          	beqz	a4,160c <dmasg_input_stream+0x28>
    15f4:	000027b7          	lui	a5,0x2
            (wait_on_packet ? DMASG_CHANNEL_INPUT_CONFIG_WAIT_ON_PACKET : 0), ca + DMASG_CHANNEL_INPUT_CONFIG);
    15f8:	00068e63          	beqz	a3,1614 <dmasg_input_stream+0x30>
    15fc:	00004737          	lui	a4,0x4
        write_u32(DMASG_CHANNEL_INPUT_CONFIG_STREAM | (completion_on_packet ? DMASG_CHANNEL_INPUT_CONFIG_COMPLETION_ON_PACKET : 0) | 
    1600:	00e7e7b3          	or	a5,a5,a4
    1604:	00f52623          	sw	a5,12(a0)
    }
    1608:	00008067          	ret
        write_u32(DMASG_CHANNEL_INPUT_CONFIG_STREAM | (completion_on_packet ? DMASG_CHANNEL_INPUT_CONFIG_COMPLETION_ON_PACKET : 0) | 
    160c:	00000793          	li	a5,0
    1610:	fe9ff06f          	j	15f8 <dmasg_input_stream+0x14>
            (wait_on_packet ? DMASG_CHANNEL_INPUT_CONFIG_WAIT_ON_PACKET : 0), ca + DMASG_CHANNEL_INPUT_CONFIG);
    1614:	00000713          	li	a4,0
    1618:	fe9ff06f          	j	1600 <dmasg_input_stream+0x1c>

0000161c <dmasg_output_stream>:
        u32 ca = dmasg_ca(base, channel);
    161c:	00759593          	slli	a1,a1,0x7
    1620:	00a58533          	add	a0,a1,a0
        write_u32(port << 0 | source << 8 | sink << 16, ca + DMASG_CHANNEL_OUTPUT_STREAM);
    1624:	00869693          	slli	a3,a3,0x8
    1628:	00c6e6b3          	or	a3,a3,a2
    162c:	01071713          	slli	a4,a4,0x10
    1630:	00e6e6b3          	or	a3,a3,a4
    1634:	00d52c23          	sw	a3,24(a0)
        write_u32(DMASG_CHANNEL_OUTPUT_CONFIG_STREAM | (last ? DMASG_CHANNEL_OUTPUT_CONFIG_LAST : 0), ca + DMASG_CHANNEL_OUTPUT_CONFIG);
    1638:	00078463          	beqz	a5,1640 <dmasg_output_stream+0x24>
    163c:	000027b7          	lui	a5,0x2
    1640:	00f52e23          	sw	a5,28(a0)
    }
    1644:	00008067          	ret

00001648 <dmasg_direct_start>:
        u32 ca = dmasg_ca(base, channel);
    1648:	00759593          	slli	a1,a1,0x7
    164c:	00a58533          	add	a0,a1,a0
        write_u32(bytes-1, ca + DMASG_CHANNEL_DIRECT_BYTES);
    1650:	fff60613          	addi	a2,a2,-1
    1654:	02c52023          	sw	a2,32(a0)
        write_u32(DMASG_CHANNEL_STATUS_DIRECT_START | (self_restart ? DMASG_CHANNEL_STATUS_SELF_RESTART : 0), ca + DMASG_CHANNEL_STATUS);
    1658:	00068863          	beqz	a3,1668 <dmasg_direct_start+0x20>
    165c:	00300793          	li	a5,3
    1660:	02f52623          	sw	a5,44(a0)
    }
    1664:	00008067          	ret
        write_u32(DMASG_CHANNEL_STATUS_DIRECT_START | (self_restart ? DMASG_CHANNEL_STATUS_SELF_RESTART : 0), ca + DMASG_CHANNEL_STATUS);
    1668:	00100793          	li	a5,1
    166c:	ff5ff06f          	j	1660 <dmasg_direct_start+0x18>

00001670 <dmasg_interrupt_config>:
        u32 ca = dmasg_ca(base, channel);
    1670:	00759593          	slli	a1,a1,0x7
    1674:	00a58533          	add	a0,a1,a0
    1678:	fff00793          	li	a5,-1
    167c:	04f52a23          	sw	a5,84(a0)
    1680:	04c52823          	sw	a2,80(a0)
    }
    1684:	00008067          	ret

00001688 <dmasg_busy>:
        u32 ca = dmasg_ca(base, channel);
    1688:	00759593          	slli	a1,a1,0x7
    168c:	00a585b3          	add	a1,a1,a0
        return *((volatile u32*) address);
    1690:	02c5a503          	lw	a0,44(a1)
    }
    1694:	00157513          	andi	a0,a0,1
    1698:	00008067          	ret

0000169c <dmasg_priority>:
        u32 ca = dmasg_ca(base, channel);
        write_u32(fifo_base << 0 | fifo_bytes-1 << 16,  ca+DMASG_CHANNEL_FIFO);
    }
    
    static void dmasg_priority(u32 base, u32 channel, u32 priority, u32 weight){
        u32 ca = dmasg_ca(base, channel);
    169c:	00759593          	slli	a1,a1,0x7
    16a0:	00a585b3          	add	a1,a1,a0
        write_u32(priority | weight << 8,  ca+DMASG_CHANNEL_PRIORITY);
    16a4:	00869693          	slli	a3,a3,0x8
    16a8:	00c6e6b3          	or	a3,a3,a2
        *((volatile u32*) address) = data;
    16ac:	04d5a223          	sw	a3,68(a1)
    }
    16b0:	00008067          	ret

000016b4 <uart_writeAvailability>:
        return *((volatile u32*) address);
    16b4:	00452503          	lw	a0,4(a0)
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    16b8:	01055513          	srli	a0,a0,0x10
    }
    16bc:	0ff57513          	andi	a0,a0,255
    16c0:	00008067          	ret

000016c4 <uart_write>:
    static void uart_write(u32 reg, char data){
    16c4:	ff010113          	addi	sp,sp,-16
    16c8:	00112623          	sw	ra,12(sp)
    16cc:	00812423          	sw	s0,8(sp)
    16d0:	00912223          	sw	s1,4(sp)
    16d4:	00050413          	mv	s0,a0
    16d8:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    16dc:	00040513          	mv	a0,s0
    16e0:	fd5ff0ef          	jal	ra,16b4 <uart_writeAvailability>
    16e4:	fe050ce3          	beqz	a0,16dc <uart_write+0x18>
        *((volatile u32*) address) = data;
    16e8:	00942023          	sw	s1,0(s0)
    }
    16ec:	00c12083          	lw	ra,12(sp)
    16f0:	00812403          	lw	s0,8(sp)
    16f4:	00412483          	lw	s1,4(sp)
    16f8:	01010113          	addi	sp,sp,16
    16fc:	00008067          	ret

00001700 <clint_uDelay>:
    
        return (((u64)hi) << 32) | lo;
    }
    
    static void clint_uDelay(u32 usec, u32 hz, u32 reg){
        u32 mTimePerUsec = hz/1000000;
    1700:	000f47b7          	lui	a5,0xf4
    1704:	24078793          	addi	a5,a5,576 # f4240 <_end+0xeb370>
    1708:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    170c:	0000c7b7          	lui	a5,0xc
    1710:	ff878793          	addi	a5,a5,-8 # bff8 <_end+0x3128>
    1714:	00f60633          	add	a2,a2,a5
        return *((volatile u32*) address);
    1718:	00062783          	lw	a5,0(a2)
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    171c:	02a58533          	mul	a0,a1,a0
    1720:	00f50533          	add	a0,a0,a5
    1724:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    1728:	40f507b3          	sub	a5,a0,a5
    172c:	fe07dce3          	bgez	a5,1724 <clint_uDelay+0x24>
    }
    1730:	00008067          	ret

00001734 <_putchar>:
#include <math.h>
#include <string.h>
#include "bsp.h"

#if (ENABLE_BSP_PRINTF)
    static void _putchar(char character){
    1734:	ff010113          	addi	sp,sp,-16
    1738:	00112623          	sw	ra,12(sp)
        #if (ENABLE_SEMIHOSTING_PRINT == 1)
            sh_writec(character);
        #else
            bsp_putChar(character);
    173c:	00050593          	mv	a1,a0
    1740:	f8010537          	lui	a0,0xf8010
    1744:	f81ff0ef          	jal	ra,16c4 <uart_write>
        #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1748:	00c12083          	lw	ra,12(sp)
    174c:	01010113          	addi	sp,sp,16
    1750:	00008067          	ret

00001754 <_putchar_s>:

    static void _putchar_s(char *p)
    {
    1754:	ff010113          	addi	sp,sp,-16
    1758:	00112623          	sw	ra,12(sp)
    175c:	00812423          	sw	s0,8(sp)
    1760:	00050413          	mv	s0,a0
    #if (ENABLE_SEMIHOSTING_PRINT == 1)
        sh_write0(p);
    #else
        while (*p)
    1764:	00044503          	lbu	a0,0(s0)
    1768:	00050863          	beqz	a0,1778 <_putchar_s+0x24>
            _putchar(*(p++));
    176c:	00140413          	addi	s0,s0,1
    1770:	fc5ff0ef          	jal	ra,1734 <_putchar>
    1774:	ff1ff06f          	j	1764 <_putchar_s+0x10>
    #endif // (ENABLE_SEMIHOSTING_PRINT == 1)
    }
    1778:	00c12083          	lw	ra,12(sp)
    177c:	00812403          	lw	s0,8(sp)
    1780:	01010113          	addi	sp,sp,16
    1784:	00008067          	ret

00001788 <bsp_printHex>:

        static void bsp_printHex(uint32_t val)
    {
    1788:	ff010113          	addi	sp,sp,-16
    178c:	00112623          	sw	ra,12(sp)
    1790:	00812423          	sw	s0,8(sp)
    1794:	00912223          	sw	s1,4(sp)
    1798:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    179c:	01c00413          	li	s0,28
    17a0:	0240006f          	j	17c4 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    17a4:	0084d7b3          	srl	a5,s1,s0
    17a8:	00f7f713          	andi	a4,a5,15
    17ac:	000087b7          	lui	a5,0x8
    17b0:	82c78793          	addi	a5,a5,-2004 # 782c <col+0xc>
    17b4:	00e787b3          	add	a5,a5,a4
    17b8:	0007c503          	lbu	a0,0(a5)
    17bc:	f79ff0ef          	jal	ra,1734 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    17c0:	ffc40413          	addi	s0,s0,-4
    17c4:	fe0450e3          	bgez	s0,17a4 <bsp_printHex+0x1c>
        }
    }
    17c8:	00c12083          	lw	ra,12(sp)
    17cc:	00812403          	lw	s0,8(sp)
    17d0:	00412483          	lw	s1,4(sp)
    17d4:	01010113          	addi	sp,sp,16
    17d8:	00008067          	ret

000017dc <bsp_printHex_lower>:

    static void bsp_printHex_lower(uint32_t val)
    {
    17dc:	ff010113          	addi	sp,sp,-16
    17e0:	00112623          	sw	ra,12(sp)
    17e4:	00812423          	sw	s0,8(sp)
    17e8:	00912223          	sw	s1,4(sp)
    17ec:	00050493          	mv	s1,a0
        uint32_t digits;
        digits =8;

        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    17f0:	01c00413          	li	s0,28
    17f4:	0240006f          	j	1818 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    17f8:	0084d7b3          	srl	a5,s1,s0
    17fc:	00f7f713          	andi	a4,a5,15
    1800:	000087b7          	lui	a5,0x8
    1804:	84078793          	addi	a5,a5,-1984 # 7840 <col+0x20>
    1808:	00e787b3          	add	a5,a5,a4
    180c:	0007c503          	lbu	a0,0(a5)
    1810:	f25ff0ef          	jal	ra,1734 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    1814:	ffc40413          	addi	s0,s0,-4
    1818:	fe0450e3          	bgez	s0,17f8 <bsp_printHex_lower+0x1c>

        }
    }
    181c:	00c12083          	lw	ra,12(sp)
    1820:	00812403          	lw	s0,8(sp)
    1824:	00412483          	lw	s1,4(sp)
    1828:	01010113          	addi	sp,sp,16
    182c:	00008067          	ret

00001830 <bsp_printf_c>:
*
* @param c: The character to be output.
*
******************************************************************************/
    static void bsp_printf_c(int c)
    {
    1830:	ff010113          	addi	sp,sp,-16
    1834:	00112623          	sw	ra,12(sp)
        _putchar(c);
    1838:	0ff57513          	andi	a0,a0,255
    183c:	ef9ff0ef          	jal	ra,1734 <_putchar>
    }
    1840:	00c12083          	lw	ra,12(sp)
    1844:	01010113          	addi	sp,sp,16
    1848:	00008067          	ret

0000184c <bsp_printf_s>:
*
* @param s: A pointer to the null-terminated string to be output.
*
*******************************************************************************/
    static void bsp_printf_s(char *p)
    {
    184c:	ff010113          	addi	sp,sp,-16
    1850:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    1854:	f01ff0ef          	jal	ra,1754 <_putchar_s>
    }
    1858:	00c12083          	lw	ra,12(sp)
    185c:	01010113          	addi	sp,sp,16
    1860:	00008067          	ret

00001864 <bsp_printf_d>:
* - Handles negative numbers by printing a '-' sign.
* - Uses the 'bsp_printf_c' function to print each character.
*
******************************************************************************/
    static void bsp_printf_d(int val)
    {
    1864:	fd010113          	addi	sp,sp,-48
    1868:	02112623          	sw	ra,44(sp)
    186c:	02812423          	sw	s0,40(sp)
    1870:	02912223          	sw	s1,36(sp)
    1874:	00050493          	mv	s1,a0
        char buffer[32];
        char *p = buffer;
        if (val < 0) {
    1878:	00054663          	bltz	a0,1884 <bsp_printf_d+0x20>
    {
    187c:	00010413          	mv	s0,sp
    1880:	02c0006f          	j	18ac <bsp_printf_d+0x48>
            bsp_printf_c('-');
    1884:	02d00513          	li	a0,45
    1888:	fa9ff0ef          	jal	ra,1830 <bsp_printf_c>
            val = -val;
    188c:	409004b3          	neg	s1,s1
    1890:	fedff06f          	j	187c <bsp_printf_d+0x18>
        }
        while (val || p == buffer) {
            *(p++) = '0' + val % 10;
    1894:	00a00713          	li	a4,10
    1898:	02e4e7b3          	rem	a5,s1,a4
    189c:	03078793          	addi	a5,a5,48
    18a0:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    18a4:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    18a8:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    18ac:	fe0494e3          	bnez	s1,1894 <bsp_printf_d+0x30>
    18b0:	00010793          	mv	a5,sp
    18b4:	fef400e3          	beq	s0,a5,1894 <bsp_printf_d+0x30>
    18b8:	0100006f          	j	18c8 <bsp_printf_d+0x64>
        }
        while (p != buffer)
            bsp_printf_c(*(--p));
    18bc:	fff40413          	addi	s0,s0,-1
    18c0:	00044503          	lbu	a0,0(s0)
    18c4:	f6dff0ef          	jal	ra,1830 <bsp_printf_c>
        while (p != buffer)
    18c8:	00010793          	mv	a5,sp
    18cc:	fef418e3          	bne	s0,a5,18bc <bsp_printf_d+0x58>
    }
    18d0:	02c12083          	lw	ra,44(sp)
    18d4:	02812403          	lw	s0,40(sp)
    18d8:	02412483          	lw	s1,36(sp)
    18dc:	03010113          	addi	sp,sp,48
    18e0:	00008067          	ret

000018e4 <bsp_printf_x>:
* - Calls 'bsp_printHex_lower' to print the hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_x(int val)
    {
    18e4:	ff010113          	addi	sp,sp,-16
    18e8:	00112623          	sw	ra,12(sp)
        int i,digi=2;

        for(i=0;i<8;i++)
    18ec:	00000713          	li	a4,0
    18f0:	00700793          	li	a5,7
    18f4:	02e7c063          	blt	a5,a4,1914 <bsp_printf_x+0x30>
        {
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    18f8:	00271693          	slli	a3,a4,0x2
    18fc:	ff000793          	li	a5,-16
    1900:	00d797b3          	sll	a5,a5,a3
    1904:	00f577b3          	and	a5,a0,a5
    1908:	00078663          	beqz	a5,1914 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    190c:	00170713          	addi	a4,a4,1 # 4001 <__subdf3+0x235>
    1910:	fe1ff06f          	j	18f0 <bsp_printf_x+0xc>
            {
                digi=i+1;
                break;
            }
        }
        bsp_printHex_lower(val);
    1914:	ec9ff0ef          	jal	ra,17dc <bsp_printHex_lower>
    }
    1918:	00c12083          	lw	ra,12(sp)
    191c:	01010113          	addi	sp,sp,16
    1920:	00008067          	ret

00001924 <bsp_printf_X>:
* - Calls 'bsp_printHex' to print the uppercase hexadecimal representation.
* - Determines the number of leading zeros to be printed based on the value.
*
******************************************************************************/
    static void bsp_printf_X(int val)
        {
    1924:	ff010113          	addi	sp,sp,-16
    1928:	00112623          	sw	ra,12(sp)
            int i,digi=2;

            for(i=0;i<8;i++)
    192c:	00000713          	li	a4,0
    1930:	00700793          	li	a5,7
    1934:	02e7c063          	blt	a5,a4,1954 <bsp_printf_X+0x30>
            {
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    1938:	00271693          	slli	a3,a4,0x2
    193c:	ff000793          	li	a5,-16
    1940:	00d797b3          	sll	a5,a5,a3
    1944:	00f577b3          	and	a5,a0,a5
    1948:	00078663          	beqz	a5,1954 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    194c:	00170713          	addi	a4,a4,1
    1950:	fe1ff06f          	j	1930 <bsp_printf_X+0xc>
                {
                    digi=i+1;
                    break;
                }
            }
            bsp_printHex(val);
    1954:	e35ff0ef          	jal	ra,1788 <bsp_printHex>
        }
    1958:	00c12083          	lw	ra,12(sp)
    195c:	01010113          	addi	sp,sp,16
    1960:	00008067          	ret

00001964 <flush_data_cache>:
uint8_t draw_buffer = 0;
uint8_t  landmark_valid = 0;
uint32_t landmark_x[NUM_LANDMARK];
uint32_t landmark_y[NUM_LANDMARK];

static void flush_data_cache(){
    1964:	0000500f          	0x500f
   asm(".word(0x500F)");
}
    1968:	00008067          	ret

0000196c <reverse>:
     {
    196c:	ff010113          	addi	sp,sp,-16
    1970:	00112623          	sw	ra,12(sp)
    1974:	00812423          	sw	s0,8(sp)
    1978:	00050413          	mv	s0,a0
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    197c:	8cdff0ef          	jal	ra,1248 <strlen>
    1980:	fff50513          	addi	a0,a0,-1 # f800ffff <__freertos_irq_stack_top+0xf7e0712f>
    1984:	00000793          	li	a5,0
    1988:	02a7d463          	bge	a5,a0,19b0 <reverse+0x44>
              c = s[i];
    198c:	00f406b3          	add	a3,s0,a5
    1990:	0006c603          	lbu	a2,0(a3)
              s[i] = s[j];
    1994:	00a40733          	add	a4,s0,a0
    1998:	00074583          	lbu	a1,0(a4)
    199c:	00b68023          	sb	a1,0(a3)
              s[j] = c;
    19a0:	00c70023          	sb	a2,0(a4)
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    19a4:	00178793          	addi	a5,a5,1
    19a8:	fff50513          	addi	a0,a0,-1
    19ac:	fddff06f          	j	1988 <reverse+0x1c>
     }
    19b0:	00c12083          	lw	ra,12(sp)
    19b4:	00812403          	lw	s0,8(sp)
    19b8:	01010113          	addi	sp,sp,16
    19bc:	00008067          	ret

000019c0 <itos>:
     {
    19c0:	ff010113          	addi	sp,sp,-16
    19c4:	00112623          	sw	ra,12(sp)
         if ((sign = n) < 0)  /* record sign */
    19c8:	00054863          	bltz	a0,19d8 <itos+0x18>
    19cc:	00050613          	mv	a2,a0
    19d0:	00000813          	li	a6,0
    19d4:	0140006f          	j	19e8 <itos+0x28>
             n = -n;          /* make n positive */
    19d8:	40a00633          	neg	a2,a0
    19dc:	ff5ff06f          	j	19d0 <itos+0x10>
             s[i++] = n % 10 + '0';   /* get next digit */
    19e0:	00088813          	mv	a6,a7
         } while ((n /= 10) > 0);     /* delete it */
    19e4:	00078613          	mv	a2,a5
             s[i++] = n % 10 + '0';   /* get next digit */
    19e8:	00a00793          	li	a5,10
    19ec:	02f666b3          	rem	a3,a2,a5
    19f0:	00180893          	addi	a7,a6,1
    19f4:	01058733          	add	a4,a1,a6
    19f8:	03068693          	addi	a3,a3,48
    19fc:	00d70023          	sb	a3,0(a4)
         } while ((n /= 10) > 0);     /* delete it */
    1a00:	02f647b3          	div	a5,a2,a5
    1a04:	00900713          	li	a4,9
    1a08:	fcc74ce3          	blt	a4,a2,19e0 <itos+0x20>
         if (sign < 0)
    1a0c:	02054063          	bltz	a0,1a2c <itos+0x6c>
         s[i] = '\0';
    1a10:	011588b3          	add	a7,a1,a7
    1a14:	00088023          	sb	zero,0(a7)
         reverse(s);
    1a18:	00058513          	mv	a0,a1
    1a1c:	f51ff0ef          	jal	ra,196c <reverse>
    }
    1a20:	00c12083          	lw	ra,12(sp)
    1a24:	01010113          	addi	sp,sp,16
    1a28:	00008067          	ret
             s[i++] = '-';
    1a2c:	011588b3          	add	a7,a1,a7
    1a30:	02d00793          	li	a5,45
    1a34:	00f88023          	sb	a5,0(a7)
    1a38:	00280893          	addi	a7,a6,2
    1a3c:	fd5ff06f          	j	1a10 <itos+0x50>

00001a40 <ftoa>:
    {
    1a40:	fe010113          	addi	sp,sp,-32
    1a44:	00112e23          	sw	ra,28(sp)
    1a48:	00812c23          	sw	s0,24(sp)
    1a4c:	00912a23          	sw	s1,20(sp)
    1a50:	01212823          	sw	s2,16(sp)
    1a54:	01312623          	sw	s3,12(sp)
    1a58:	01412423          	sw	s4,8(sp)
    1a5c:	00050913          	mv	s2,a0
    1a60:	00058993          	mv	s3,a1
    1a64:	00060a13          	mv	s4,a2
    1a68:	00068413          	mv	s0,a3
        int ipart = (int)n;
    1a6c:	3dd020ef          	jal	ra,4648 <__fixdfsi>
    1a70:	00050493          	mv	s1,a0
        double fpart = n - (double)ipart;
    1a74:	459020ef          	jal	ra,46cc <__floatsidf>
    1a78:	00050613          	mv	a2,a0
    1a7c:	00058693          	mv	a3,a1
    1a80:	00090513          	mv	a0,s2
    1a84:	00098593          	mv	a1,s3
    1a88:	344020ef          	jal	ra,3dcc <__subdf3>
    1a8c:	00050913          	mv	s2,a0
    1a90:	00058993          	mv	s3,a1
        itos(n, res1);
    1a94:	000a0593          	mv	a1,s4
    1a98:	00048513          	mv	a0,s1
    1a9c:	f25ff0ef          	jal	ra,19c0 <itos>
        *res2 = '.';
    1aa0:	02e00793          	li	a5,46
    1aa4:	00f40023          	sb	a5,0(s0)
        res2++;
    1aa8:	00140a13          	addi	s4,s0,1
        fpart_f = (float)fpart * pow(10, afterpoint);
    1aac:	00090513          	mv	a0,s2
    1ab0:	00098593          	mv	a1,s3
    1ab4:	7d5020ef          	jal	ra,4a88 <__truncdfsf2>
    1ab8:	6d1020ef          	jal	ra,4988 <__extendsfdf2>
    1abc:	8181a603          	lw	a2,-2024(gp) # 8008 <_impure_ptr+0x4>
    1ac0:	81c1a683          	lw	a3,-2020(gp) # 800c <_impure_ptr+0x8>
    1ac4:	4b5010ef          	jal	ra,3778 <__muldf3>
    1ac8:	7c1020ef          	jal	ra,4a88 <__truncdfsf2>
    1acc:	00050493          	mv	s1,a0
        if (fpart_f<0)
    1ad0:	00000593          	li	a1,0
    1ad4:	57d020ef          	jal	ra,4850 <__lesf2>
    1ad8:	06054a63          	bltz	a0,1b4c <ftoa+0x10c>
        for (int i=afterpoint; i>0; i--)
    1adc:	00400413          	li	s0,4
    1ae0:	08805263          	blez	s0,1b64 <ftoa+0x124>
            if ((fpart_f<(1 * pow(10, i-1))) && (fpart_f>0))
    1ae4:	00048513          	mv	a0,s1
    1ae8:	6a1020ef          	jal	ra,4988 <__extendsfdf2>
    1aec:	00050913          	mv	s2,a0
    1af0:	00058993          	mv	s3,a1
    1af4:	fff40413          	addi	s0,s0,-1
    1af8:	00040513          	mv	a0,s0
    1afc:	3d1020ef          	jal	ra,46cc <__floatsidf>
    1b00:	00050613          	mv	a2,a0
    1b04:	00058693          	mv	a3,a1
    1b08:	8201a503          	lw	a0,-2016(gp) # 8010 <_impure_ptr+0xc>
    1b0c:	8241a583          	lw	a1,-2012(gp) # 8014 <_impure_ptr+0x10>
    1b10:	200030ef          	jal	ra,4d10 <pow>
    1b14:	00050613          	mv	a2,a0
    1b18:	00058693          	mv	a3,a1
    1b1c:	00090513          	mv	a0,s2
    1b20:	00098593          	mv	a1,s3
    1b24:	355010ef          	jal	ra,3678 <__ledf2>
    1b28:	fa055ce3          	bgez	a0,1ae0 <ftoa+0xa0>
    1b2c:	00000593          	li	a1,0
    1b30:	00048513          	mv	a0,s1
    1b34:	459020ef          	jal	ra,478c <__gesf2>
    1b38:	faa054e3          	blez	a0,1ae0 <ftoa+0xa0>
                *res2='0';
    1b3c:	03000793          	li	a5,48
    1b40:	00fa0023          	sb	a5,0(s4)
                res2++;
    1b44:	001a0a13          	addi	s4,s4,1
    1b48:	f99ff06f          	j	1ae0 <ftoa+0xa0>
            *res2 = '-';
    1b4c:	02d00793          	li	a5,45
    1b50:	00f400a3          	sb	a5,1(s0)
            res2++;
    1b54:	00240a13          	addi	s4,s0,2
            fpart_f = -(fpart_f);
    1b58:	800007b7          	lui	a5,0x80000
    1b5c:	0097c4b3          	xor	s1,a5,s1
    1b60:	f7dff06f          	j	1adc <ftoa+0x9c>
        itos((int)fpart_f, res2);
    1b64:	00048513          	mv	a0,s1
    1b68:	5ad020ef          	jal	ra,4914 <__fixsfsi>
    1b6c:	000a0593          	mv	a1,s4
    1b70:	e51ff0ef          	jal	ra,19c0 <itos>
    }
    1b74:	01c12083          	lw	ra,28(sp)
    1b78:	01812403          	lw	s0,24(sp)
    1b7c:	01412483          	lw	s1,20(sp)
    1b80:	01012903          	lw	s2,16(sp)
    1b84:	00c12983          	lw	s3,12(sp)
    1b88:	00812a03          	lw	s4,8(sp)
    1b8c:	02010113          	addi	sp,sp,32
    1b90:	00008067          	ret

00001b94 <print_float>:
    {
    1b94:	fc010113          	addi	sp,sp,-64
    1b98:	02112e23          	sw	ra,60(sp)
    1b9c:	02812c23          	sw	s0,56(sp)
        ftoa(val, sval, fval);
    1ba0:	00c10693          	addi	a3,sp,12
    1ba4:	01810613          	addi	a2,sp,24
    1ba8:	e99ff0ef          	jal	ra,1a40 <ftoa>
        if (fval[1] == '-')
    1bac:	00d14703          	lbu	a4,13(sp)
    1bb0:	02d00793          	li	a5,45
    1bb4:	06f70663          	beq	a4,a5,1c20 <print_float+0x8c>
        neg=0;
    1bb8:	00000413          	li	s0,0
        strcat(sval, fval);
    1bbc:	00c10593          	addi	a1,sp,12
    1bc0:	01810513          	addi	a0,sp,24
    1bc4:	de4ff0ef          	jal	ra,11a8 <strcat>
        if ((sval[0] != '-') && (neg == 1))
    1bc8:	01814703          	lbu	a4,24(sp)
    1bcc:	02d00793          	li	a5,45
    1bd0:	00f70463          	beq	a4,a5,1bd8 <print_float+0x44>
    1bd4:	08041263          	bnez	s0,1c58 <print_float+0xc4>
        _putchar_s(sval);
    1bd8:	01810513          	addi	a0,sp,24
    1bdc:	b79ff0ef          	jal	ra,1754 <_putchar_s>
    }
    1be0:	03c12083          	lw	ra,60(sp)
    1be4:	03812403          	lw	s0,56(sp)
    1be8:	04010113          	addi	sp,sp,64
    1bec:	00008067          	ret
                fval[i-1] = fval[i];
    1bf0:	fff78713          	addi	a4,a5,-1 # 7fffffff <__freertos_irq_stack_top+0x7fdf712f>
    1bf4:	03010693          	addi	a3,sp,48
    1bf8:	00f686b3          	add	a3,a3,a5
    1bfc:	fdc6c683          	lbu	a3,-36(a3)
    1c00:	03010613          	addi	a2,sp,48
    1c04:	00e60733          	add	a4,a2,a4
    1c08:	fcd70e23          	sb	a3,-36(a4)
                i++;
    1c0c:	00178793          	addi	a5,a5,1
            while (i<10)
    1c10:	00900713          	li	a4,9
    1c14:	fcf75ee3          	bge	a4,a5,1bf0 <print_float+0x5c>
            neg = 1;
    1c18:	00100413          	li	s0,1
    1c1c:	fa1ff06f          	j	1bbc <print_float+0x28>
        i=2;
    1c20:	00200793          	li	a5,2
    1c24:	fedff06f          	j	1c10 <print_float+0x7c>
                sval[j+1] = sval[j];
    1c28:	00178713          	addi	a4,a5,1
    1c2c:	03010693          	addi	a3,sp,48
    1c30:	00f686b3          	add	a3,a3,a5
    1c34:	fe86c683          	lbu	a3,-24(a3)
    1c38:	03010613          	addi	a2,sp,48
    1c3c:	00e60733          	add	a4,a2,a4
    1c40:	fed70423          	sb	a3,-24(a4)
                j--;
    1c44:	fff78793          	addi	a5,a5,-1
            while (j>=0)
    1c48:	fe07d0e3          	bgez	a5,1c28 <print_float+0x94>
            sval[0] = '-';
    1c4c:	02d00793          	li	a5,45
    1c50:	00f10c23          	sb	a5,24(sp)
    1c54:	f85ff06f          	j	1bd8 <print_float+0x44>
        j=19;
    1c58:	01300793          	li	a5,19
    1c5c:	fedff06f          	j	1c48 <print_float+0xb4>

00001c60 <bsp_printf>:
* - Handles each format specifier by calling the appropriate helper function.
* - If floating-point support is disabled, prints a warning for the 'f' specifier.
*
******************************************************************************/
    static void bsp_printf(const char *format, ...)
    {
    1c60:	fc010113          	addi	sp,sp,-64
    1c64:	00112e23          	sw	ra,28(sp)
    1c68:	00812c23          	sw	s0,24(sp)
    1c6c:	00912a23          	sw	s1,20(sp)
    1c70:	00050493          	mv	s1,a0
    1c74:	02b12223          	sw	a1,36(sp)
    1c78:	02c12423          	sw	a2,40(sp)
    1c7c:	02d12623          	sw	a3,44(sp)
    1c80:	02e12823          	sw	a4,48(sp)
    1c84:	02f12a23          	sw	a5,52(sp)
    1c88:	03012c23          	sw	a6,56(sp)
    1c8c:	03112e23          	sw	a7,60(sp)
        int i;
        va_list ap;

        va_start(ap, format);
    1c90:	02410793          	addi	a5,sp,36
    1c94:	00f12623          	sw	a5,12(sp)

        for (i = 0; format[i]; i++)
    1c98:	00000413          	li	s0,0
    1c9c:	01c0006f          	j	1cb8 <bsp_printf+0x58>
            if (format[i] == '%') {
                while (format[++i]) {
                    if (format[i] == 'c') {
                        bsp_printf_c(va_arg(ap,int));
    1ca0:	00c12783          	lw	a5,12(sp)
    1ca4:	00478713          	addi	a4,a5,4
    1ca8:	00e12623          	sw	a4,12(sp)
    1cac:	0007a503          	lw	a0,0(a5)
    1cb0:	b81ff0ef          	jal	ra,1830 <bsp_printf_c>
        for (i = 0; format[i]; i++)
    1cb4:	00140413          	addi	s0,s0,1
    1cb8:	008487b3          	add	a5,s1,s0
    1cbc:	0007c503          	lbu	a0,0(a5)
    1cc0:	0c050c63          	beqz	a0,1d98 <bsp_printf+0x138>
            if (format[i] == '%') {
    1cc4:	02500793          	li	a5,37
    1cc8:	06f50663          	beq	a0,a5,1d34 <bsp_printf+0xd4>
                        break;
                    }
#endif //#if (ENABLE_FLOATING_POINT_SUPPORT)
                }
            } else
                bsp_printf_c(format[i]);
    1ccc:	b65ff0ef          	jal	ra,1830 <bsp_printf_c>
    1cd0:	fe5ff06f          	j	1cb4 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    1cd4:	00c12783          	lw	a5,12(sp)
    1cd8:	00478713          	addi	a4,a5,4
    1cdc:	00e12623          	sw	a4,12(sp)
    1ce0:	0007a503          	lw	a0,0(a5)
    1ce4:	b69ff0ef          	jal	ra,184c <bsp_printf_s>
                        break;
    1ce8:	fcdff06f          	j	1cb4 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    1cec:	00c12783          	lw	a5,12(sp)
    1cf0:	00478713          	addi	a4,a5,4
    1cf4:	00e12623          	sw	a4,12(sp)
    1cf8:	0007a503          	lw	a0,0(a5)
    1cfc:	b69ff0ef          	jal	ra,1864 <bsp_printf_d>
                        break;
    1d00:	fb5ff06f          	j	1cb4 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    1d04:	00c12783          	lw	a5,12(sp)
    1d08:	00478713          	addi	a4,a5,4
    1d0c:	00e12623          	sw	a4,12(sp)
    1d10:	0007a503          	lw	a0,0(a5)
    1d14:	c11ff0ef          	jal	ra,1924 <bsp_printf_X>
                        break;
    1d18:	f9dff06f          	j	1cb4 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    1d1c:	00c12783          	lw	a5,12(sp)
    1d20:	00478713          	addi	a4,a5,4
    1d24:	00e12623          	sw	a4,12(sp)
    1d28:	0007a503          	lw	a0,0(a5)
    1d2c:	bb9ff0ef          	jal	ra,18e4 <bsp_printf_x>
                        break;
    1d30:	f85ff06f          	j	1cb4 <bsp_printf+0x54>
                while (format[++i]) {
    1d34:	00140413          	addi	s0,s0,1
    1d38:	008487b3          	add	a5,s1,s0
    1d3c:	0007c783          	lbu	a5,0(a5)
    1d40:	f6078ae3          	beqz	a5,1cb4 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    1d44:	06300713          	li	a4,99
    1d48:	f4e78ce3          	beq	a5,a4,1ca0 <bsp_printf+0x40>
                    else if (format[i] == 's') {
    1d4c:	07300713          	li	a4,115
    1d50:	f8e782e3          	beq	a5,a4,1cd4 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    1d54:	06400713          	li	a4,100
    1d58:	f8e78ae3          	beq	a5,a4,1cec <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    1d5c:	05800713          	li	a4,88
    1d60:	fae782e3          	beq	a5,a4,1d04 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    1d64:	07800713          	li	a4,120
    1d68:	fae78ae3          	beq	a5,a4,1d1c <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    1d6c:	06600713          	li	a4,102
    1d70:	fce792e3          	bne	a5,a4,1d34 <bsp_printf+0xd4>
                        print_float(va_arg(ap,double));
    1d74:	00c12783          	lw	a5,12(sp)
    1d78:	00778793          	addi	a5,a5,7
    1d7c:	ff87f793          	andi	a5,a5,-8
    1d80:	00878713          	addi	a4,a5,8
    1d84:	00e12623          	sw	a4,12(sp)
    1d88:	0007a503          	lw	a0,0(a5)
    1d8c:	0047a583          	lw	a1,4(a5)
    1d90:	e05ff0ef          	jal	ra,1b94 <print_float>
                        break;
    1d94:	f21ff06f          	j	1cb4 <bsp_printf+0x54>

        va_end(ap);
    }
    1d98:	01c12083          	lw	ra,28(sp)
    1d9c:	01812403          	lw	s0,24(sp)
    1da0:	01412483          	lw	s1,20(sp)
    1da4:	04010113          	addi	sp,sp,64
    1da8:	00008067          	ret

00001dac <example_register_read>:
	read_u32(addr+offset)

u32 example_register_read(u16 reg)
{
	u32 rdata;
	rdata = EXAMPLE_APB3_REGR(EXAMPLE_APB3_SLV, reg);
    1dac:	f81107b7          	lui	a5,0xf8110
    1db0:	00f50533          	add	a0,a0,a5
    1db4:	00052503          	lw	a0,0(a0)
	return rdata;
}
    1db8:	00008067          	ret

00001dbc <Set_RGBGain>:

void Set_RGBGain(u8 ena, u8 R, u8 G, u8 B)
{
    1dbc:	ff010113          	addi	sp,sp,-16
    1dc0:	00112623          	sw	ra,12(sp)
	u32 data = ((B & 0x7)<<12)|((G & 0x7)<<8)|((R & 0x7)<<4)|(ena&0x1);
    1dc4:	00c69693          	slli	a3,a3,0xc
    1dc8:	000077b7          	lui	a5,0x7
    1dcc:	00f6f6b3          	and	a3,a3,a5
    1dd0:	00861613          	slli	a2,a2,0x8
    1dd4:	70067613          	andi	a2,a2,1792
    1dd8:	00c6e6b3          	or	a3,a3,a2
    1ddc:	00459593          	slli	a1,a1,0x4
    1de0:	0705f593          	andi	a1,a1,112
    1de4:	00b6e6b3          	or	a3,a3,a1
    1de8:	00157513          	andi	a0,a0,1
    1dec:	00a6e6b3          	or	a3,a3,a0
        *((volatile u32*) address) = data;
    1df0:	f81107b7          	lui	a5,0xf8110
    1df4:	00d7a023          	sw	a3,0(a5) # f8110000 <__freertos_irq_stack_top+0xf7f07130>

	EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG0_OFFSET, data);
	bsp_uDelay(DELAY_BUSY);
    1df8:	f8b00637          	lui	a2,0xf8b00
    1dfc:	05f5e5b7          	lui	a1,0x5f5e
    1e00:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d55230>
    1e04:	00500513          	li	a0,5
    1e08:	8f9ff0ef          	jal	ra,1700 <clint_uDelay>
}
    1e0c:	00c12083          	lw	ra,12(sp)
    1e10:	01010113          	addi	sp,sp,16
    1e14:	00008067          	ret

00001e18 <buf>:
u32 buf(u32 i) {
   return BUFFER_START_ADDR +  FRAME_WIDTH*FRAME_HEIGHT*4*i;
    1e18:	004737b7          	lui	a5,0x473
    1e1c:	10078793          	addi	a5,a5,256 # 473100 <__freertos_irq_stack_top+0x26a230>
    1e20:	02f50533          	mul	a0,a0,a5
}
    1e24:	011007b7          	lui	a5,0x1100
    1e28:	00f50533          	add	a0,a0,a5
    1e2c:	00008067          	ret

00001e30 <send_dma>:
void send_dma(u32 channel, u32 port, u32 addr, u32 size, int interrupt, int wait, int self_restart) {
    1e30:	fe010113          	addi	sp,sp,-32
    1e34:	00112e23          	sw	ra,28(sp)
    1e38:	00812c23          	sw	s0,24(sp)
    1e3c:	00912a23          	sw	s1,20(sp)
    1e40:	01212823          	sw	s2,16(sp)
    1e44:	01312623          	sw	s3,12(sp)
    1e48:	01412423          	sw	s4,8(sp)
    1e4c:	01512223          	sw	s5,4(sp)
    1e50:	00050413          	mv	s0,a0
    1e54:	00058a93          	mv	s5,a1
    1e58:	00068913          	mv	s2,a3
    1e5c:	00070a13          	mv	s4,a4
    1e60:	00078493          	mv	s1,a5
    1e64:	00080993          	mv	s3,a6
   dmasg_input_memory(DMASG_BASE, channel, addr, 16);
    1e68:	01000693          	li	a3,16
    1e6c:	00050593          	mv	a1,a0
    1e70:	f8100537          	lui	a0,0xf8100
    1e74:	f20ff0ef          	jal	ra,1594 <dmasg_input_memory>
   dmasg_output_stream(DMASG_BASE, channel, port, 0, 0, 1);
    1e78:	00100793          	li	a5,1
    1e7c:	00000713          	li	a4,0
    1e80:	00000693          	li	a3,0
    1e84:	000a8613          	mv	a2,s5
    1e88:	00040593          	mv	a1,s0
    1e8c:	f8100537          	lui	a0,0xf8100
    1e90:	f8cff0ef          	jal	ra,161c <dmasg_output_stream>

   if(interrupt) {
    1e94:	040a1c63          	bnez	s4,1eec <send_dma+0xbc>
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
   }

   if(self_restart) {
    1e98:	06098463          	beqz	s3,1f00 <send_dma+0xd0>
      dmasg_direct_start(DMASG_BASE, channel, size, 1);
    1e9c:	00100693          	li	a3,1
    1ea0:	00090613          	mv	a2,s2
    1ea4:	00040593          	mv	a1,s0
    1ea8:	f8100537          	lui	a0,0xf8100
    1eac:	f9cff0ef          	jal	ra,1648 <dmasg_direct_start>
   } else {
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
   }

   if(wait) {
    1eb0:	00048c63          	beqz	s1,1ec8 <send_dma+0x98>
      while(dmasg_busy(DMASG_BASE, channel));
    1eb4:	00040593          	mv	a1,s0
    1eb8:	f8100537          	lui	a0,0xf8100
    1ebc:	fccff0ef          	jal	ra,1688 <dmasg_busy>
    1ec0:	fe051ae3          	bnez	a0,1eb4 <send_dma+0x84>
      flush_data_cache();
    1ec4:	aa1ff0ef          	jal	ra,1964 <flush_data_cache>
   }
}
    1ec8:	01c12083          	lw	ra,28(sp)
    1ecc:	01812403          	lw	s0,24(sp)
    1ed0:	01412483          	lw	s1,20(sp)
    1ed4:	01012903          	lw	s2,16(sp)
    1ed8:	00c12983          	lw	s3,12(sp)
    1edc:	00812a03          	lw	s4,8(sp)
    1ee0:	00412a83          	lw	s5,4(sp)
    1ee4:	02010113          	addi	sp,sp,32
    1ee8:	00008067          	ret
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
    1eec:	00400613          	li	a2,4
    1ef0:	00040593          	mv	a1,s0
    1ef4:	f8100537          	lui	a0,0xf8100
    1ef8:	f78ff0ef          	jal	ra,1670 <dmasg_interrupt_config>
    1efc:	f9dff06f          	j	1e98 <send_dma+0x68>
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
    1f00:	00000693          	li	a3,0
    1f04:	00090613          	mv	a2,s2
    1f08:	00040593          	mv	a1,s0
    1f0c:	f8100537          	lui	a0,0xf8100
    1f10:	f38ff0ef          	jal	ra,1648 <dmasg_direct_start>
    1f14:	f9dff06f          	j	1eb0 <send_dma+0x80>

00001f18 <recv_dma>:

void recv_dma(u32 channel, u32 port, u32 addr, u32 size, int interrupt, int wait, int self_restart) {
    1f18:	fe010113          	addi	sp,sp,-32
    1f1c:	00112e23          	sw	ra,28(sp)
    1f20:	00812c23          	sw	s0,24(sp)
    1f24:	00912a23          	sw	s1,20(sp)
    1f28:	01212823          	sw	s2,16(sp)
    1f2c:	01312623          	sw	s3,12(sp)
    1f30:	01412423          	sw	s4,8(sp)
    1f34:	01512223          	sw	s5,4(sp)
    1f38:	00050413          	mv	s0,a0
    1f3c:	00060a93          	mv	s5,a2
    1f40:	00068913          	mv	s2,a3
    1f44:	00070a13          	mv	s4,a4
    1f48:	00078493          	mv	s1,a5
    1f4c:	00080993          	mv	s3,a6
   dmasg_input_stream(DMASG_BASE, channel, port, 1, 0);
    1f50:	00000713          	li	a4,0
    1f54:	00100693          	li	a3,1
    1f58:	00058613          	mv	a2,a1
    1f5c:	00050593          	mv	a1,a0
    1f60:	f8100537          	lui	a0,0xf8100
    1f64:	e80ff0ef          	jal	ra,15e4 <dmasg_input_stream>
   dmasg_output_memory(DMASG_BASE, channel, addr, 16);
    1f68:	01000693          	li	a3,16
    1f6c:	000a8613          	mv	a2,s5
    1f70:	00040593          	mv	a1,s0
    1f74:	f8100537          	lui	a0,0xf8100
    1f78:	e44ff0ef          	jal	ra,15bc <dmasg_output_memory>

   if(interrupt){
    1f7c:	040a1c63          	bnez	s4,1fd4 <recv_dma+0xbc>
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
   }

   if(self_restart) {
    1f80:	06098463          	beqz	s3,1fe8 <recv_dma+0xd0>
      dmasg_direct_start(DMASG_BASE, channel, size, 1);
    1f84:	00100693          	li	a3,1
    1f88:	00090613          	mv	a2,s2
    1f8c:	00040593          	mv	a1,s0
    1f90:	f8100537          	lui	a0,0xf8100
    1f94:	eb4ff0ef          	jal	ra,1648 <dmasg_direct_start>
   } else {
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
   }

   if(wait){
    1f98:	00048c63          	beqz	s1,1fb0 <recv_dma+0x98>
      while(dmasg_busy(DMASG_BASE, channel));
    1f9c:	00040593          	mv	a1,s0
    1fa0:	f8100537          	lui	a0,0xf8100
    1fa4:	ee4ff0ef          	jal	ra,1688 <dmasg_busy>
    1fa8:	fe051ae3          	bnez	a0,1f9c <recv_dma+0x84>
      flush_data_cache();
    1fac:	9b9ff0ef          	jal	ra,1964 <flush_data_cache>
   }
}
    1fb0:	01c12083          	lw	ra,28(sp)
    1fb4:	01812403          	lw	s0,24(sp)
    1fb8:	01412483          	lw	s1,20(sp)
    1fbc:	01012903          	lw	s2,16(sp)
    1fc0:	00c12983          	lw	s3,12(sp)
    1fc4:	00812a03          	lw	s4,8(sp)
    1fc8:	00412a83          	lw	s5,4(sp)
    1fcc:	02010113          	addi	sp,sp,32
    1fd0:	00008067          	ret
      dmasg_interrupt_config(DMASG_BASE, channel, DMASG_CHANNEL_INTERRUPT_CHANNEL_COMPLETION_MASK);
    1fd4:	00400613          	li	a2,4
    1fd8:	00040593          	mv	a1,s0
    1fdc:	f8100537          	lui	a0,0xf8100
    1fe0:	e90ff0ef          	jal	ra,1670 <dmasg_interrupt_config>
    1fe4:	f9dff06f          	j	1f80 <recv_dma+0x68>
      dmasg_direct_start(DMASG_BASE, channel, size, 0);
    1fe8:	00000693          	li	a3,0
    1fec:	00090613          	mv	a2,s2
    1ff0:	00040593          	mv	a1,s0
    1ff4:	f8100537          	lui	a0,0xf8100
    1ff8:	e50ff0ef          	jal	ra,1648 <dmasg_direct_start>
    1ffc:	f9dff06f          	j	1f98 <recv_dma+0x80>

00002000 <trigger_next_display_dma>:
}
*/
static u8 n = 0;
static u8 cnt = 0;
static u32 col[] = {0xffff0000, 0xff00ff00, 0xff0000ff};
void trigger_next_display_dma() {
    2000:	ff010113          	addi	sp,sp,-16
    2004:	00112623          	sw	ra,12(sp)
    2008:	00812423          	sw	s0,8(sp)
    200c:	00912223          	sw	s1,4(sp)
	bsp_printf("+");
    2010:	00008537          	lui	a0,0x8
    2014:	85450513          	addi	a0,a0,-1964 # 7854 <col+0x34>
    2018:	c49ff0ef          	jal	ra,1c60 <bsp_printf>
	u32 color = col[n];
    201c:	8371c783          	lbu	a5,-1993(gp) # 8027 <n>
    2020:	00279693          	slli	a3,a5,0x2
    2024:	00008737          	lui	a4,0x8
    2028:	82070713          	addi	a4,a4,-2016 # 7820 <col>
    202c:	00d70733          	add	a4,a4,a3
    2030:	00072403          	lw	s0,0(a4)

	if((cnt++ & 31) == 0) {
    2034:	8361c703          	lbu	a4,-1994(gp) # 8026 <cnt>
    2038:	00170613          	addi	a2,a4,1
    203c:	82c18b23          	sb	a2,-1994(gp) # 8026 <cnt>
    2040:	01f77713          	andi	a4,a4,31
    2044:	00070c63          	beqz	a4,205c <trigger_next_display_dma+0x5c>
		n++;
		color = col[n];
		bsp_printf("color => %d\n\r", n);
		if(n > 2) n = 0;
	}
   display_buffer = next_display_buffer;
    2048:	83a1c503          	lbu	a0,-1990(gp) # 802a <next_display_buffer>
    204c:	82a18da3          	sb	a0,-1989(gp) # 802b <display_buffer>
   u32 *bbuf = (u32*)buf(display_buffer);
    2050:	dc9ff0ef          	jal	ra,1e18 <buf>
   for(int i = 0; i < FRAME_HEIGHT; i++) {
    2054:	00000693          	li	a3,0
    2058:	0480006f          	j	20a0 <trigger_next_display_dma+0xa0>
		n++;
    205c:	00178793          	addi	a5,a5,1 # 1100001 <__freertos_irq_stack_top+0xef7131>
    2060:	0ff7f593          	andi	a1,a5,255
    2064:	82b18ba3          	sb	a1,-1993(gp) # 8027 <n>
		color = col[n];
    2068:	00259713          	slli	a4,a1,0x2
    206c:	000087b7          	lui	a5,0x8
    2070:	82078793          	addi	a5,a5,-2016 # 7820 <col>
    2074:	00e787b3          	add	a5,a5,a4
    2078:	0007a403          	lw	s0,0(a5)
		bsp_printf("color => %d\n\r", n);
    207c:	00008537          	lui	a0,0x8
    2080:	85850513          	addi	a0,a0,-1960 # 7858 <col+0x38>
    2084:	bddff0ef          	jal	ra,1c60 <bsp_printf>
		if(n > 2) n = 0;
    2088:	8371c703          	lbu	a4,-1993(gp) # 8027 <n>
    208c:	00200793          	li	a5,2
    2090:	fae7fce3          	bgeu	a5,a4,2048 <trigger_next_display_dma+0x48>
    2094:	82018ba3          	sb	zero,-1993(gp) # 8027 <n>
    2098:	fb1ff06f          	j	2048 <trigger_next_display_dma+0x48>
   for(int i = 0; i < FRAME_HEIGHT; i++) {
    209c:	00168693          	addi	a3,a3,1
    20a0:	43700793          	li	a5,1079
    20a4:	02d7c063          	blt	a5,a3,20c4 <trigger_next_display_dma+0xc4>
	   for(int j = 0; j < FRAME_WIDTH; j++) {
    20a8:	00000793          	li	a5,0
    20ac:	43700713          	li	a4,1079
    20b0:	fef746e3          	blt	a4,a5,209c <trigger_next_display_dma+0x9c>
		   *bbuf++ = color;
    20b4:	00852023          	sw	s0,0(a0)
	   for(int j = 0; j < FRAME_WIDTH; j++) {
    20b8:	00178793          	addi	a5,a5,1
		   *bbuf++ = color;
    20bc:	00450513          	addi	a0,a0,4
    20c0:	fedff06f          	j	20ac <trigger_next_display_dma+0xac>
	   }
   }
   send_dma(DMASG_DISPLAY_MM2S_CHANNEL, DMASG_DISPLAY_MM2S_PORT, buf(display_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
    20c4:	83b1c503          	lbu	a0,-1989(gp) # 802b <display_buffer>
    20c8:	d51ff0ef          	jal	ra,1e18 <buf>
    20cc:	00000813          	li	a6,0
    20d0:	00000793          	li	a5,0
    20d4:	00100713          	li	a4,1
    20d8:	004736b7          	lui	a3,0x473
    20dc:	10068693          	addi	a3,a3,256 # 473100 <__freertos_irq_stack_top+0x26a230>
    20e0:	00050613          	mv	a2,a0
    20e4:	00000593          	li	a1,0
    20e8:	00100513          	li	a0,1
    20ec:	d45ff0ef          	jal	ra,1e30 <send_dma>
}
    20f0:	00c12083          	lw	ra,12(sp)
    20f4:	00812403          	lw	s0,8(sp)
    20f8:	00412483          	lw	s1,4(sp)
    20fc:	01010113          	addi	sp,sp,16
    2100:	00008067          	ret

00002104 <trigger_next_cam_dma>:

void trigger_next_cam_dma() {
    2104:	ff010113          	addi	sp,sp,-16
    2108:	00112623          	sw	ra,12(sp)
   next_display_buffer = camera_buffer;
    210c:	83c1c683          	lbu	a3,-1988(gp) # 802c <camera_buffer>
    2110:	82d18d23          	sb	a3,-1990(gp) # 802a <next_display_buffer>
   for(int i=0; i<NUM_BUFFER; i++)
    2114:	00000793          	li	a5,0
    2118:	0080006f          	j	2120 <trigger_next_cam_dma+0x1c>
    211c:	00178793          	addi	a5,a5,1
    2120:	00300713          	li	a4,3
    2124:	00f74e63          	blt	a4,a5,2140 <trigger_next_cam_dma+0x3c>
   {
      if(i!=display_buffer && i!=next_display_buffer && i!=draw_buffer)
    2128:	83b1c703          	lbu	a4,-1989(gp) # 802b <display_buffer>
    212c:	fef708e3          	beq	a4,a5,211c <trigger_next_cam_dma+0x18>
    2130:	fef686e3          	beq	a3,a5,211c <trigger_next_cam_dma+0x18>
    2134:	8391c703          	lbu	a4,-1991(gp) # 8029 <draw_buffer>
    2138:	fef702e3          	beq	a4,a5,211c <trigger_next_cam_dma+0x18>
      {
         camera_buffer = i;
    213c:	82f18e23          	sb	a5,-1988(gp) # 802c <camera_buffer>
         break;
      }
   }
   recv_dma(DMASG_CAM_S2MM_CHANNEL, DMASG_CAM_S2MM_PORT, buf(camera_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
    2140:	83c1c503          	lbu	a0,-1988(gp) # 802c <camera_buffer>
    2144:	cd5ff0ef          	jal	ra,1e18 <buf>
    2148:	00000813          	li	a6,0
    214c:	00000793          	li	a5,0
    2150:	00100713          	li	a4,1
    2154:	004736b7          	lui	a3,0x473
    2158:	10068693          	addi	a3,a3,256 # 473100 <__freertos_irq_stack_top+0x26a230>
    215c:	00050613          	mv	a2,a0
    2160:	00000593          	li	a1,0
    2164:	00000513          	li	a0,0
    2168:	db1ff0ef          	jal	ra,1f18 <recv_dma>
    216c:	f81107b7          	lui	a5,0xf8110
    2170:	00100713          	li	a4,1
    2174:	00e7a823          	sw	a4,16(a5) # f8110010 <__freertos_irq_stack_top+0xf7f07140>
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG4_OFFSET, 0x00000000);

   //Trigger storage of one captured frame via APB3 slave
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000002);
   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000000);
}
    2178:	00c12083          	lw	ra,12(sp)
    217c:	01010113          	addi	sp,sp,16
    2180:	00008067          	ret

00002184 <main>:

int main(int argc, char **argv) {
    2184:	fe010113          	addi	sp,sp,-32
    2188:	00112e23          	sw	ra,28(sp)
    218c:	00812c23          	sw	s0,24(sp)
    2190:	00912a23          	sw	s1,20(sp)
    2194:	01212823          	sw	s2,16(sp)
    2198:	01312623          	sw	s3,12(sp)
	   bsp_printf("hello\n\r");
    219c:	00008537          	lui	a0,0x8
    21a0:	86850513          	addi	a0,a0,-1944 # 7868 <col+0x48>
    21a4:	abdff0ef          	jal	ra,1c60 <bsp_printf>

	   mipi_i2c_init();
    21a8:	3f0010ef          	jal	ra,3598 <mipi_i2c_init>
	   PiCam_init();
    21ac:	7ac000ef          	jal	ra,2958 <PiCam_init>
	   bsp_printf("Done\n\r");
    21b0:	00008937          	lui	s2,0x8
    21b4:	87090513          	addi	a0,s2,-1936 # 7870 <col+0x50>
    21b8:	aa9ff0ef          	jal	ra,1c60 <bsp_printf>
    21bc:	f8110437          	lui	s0,0xf8110
    21c0:	00100493          	li	s1,1
    21c4:	00942223          	sw	s1,4(s0) # f8110004 <__freertos_irq_stack_top+0xf7f07134>

	   //Indicate camera configuration done
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG1_OFFSET, 0x00000001);
	   bsp_printf("n\n\r");
    21c8:	00008537          	lui	a0,0x8
    21cc:	87850513          	addi	a0,a0,-1928 # 7878 <col+0x58>
    21d0:	a91ff0ef          	jal	ra,1c60 <bsp_printf>

	   //SET camera pre-processing RGB gain value
	   Set_RGBGain(1,5,3,4);
    21d4:	00400693          	li	a3,4
    21d8:	00300613          	li	a2,3
    21dc:	00500593          	li	a1,5
    21e0:	00100513          	li	a0,1
    21e4:	bd9ff0ef          	jal	ra,1dbc <Set_RGBGain>

	   dma_init();
    21e8:	b1cff0ef          	jal	ra,1504 <dma_init>
	   dmasg_priority(DMASG_BASE, DMASG_HW_ACCEL_MM2S_CHANNEL, 0, 0);
    21ec:	00000693          	li	a3,0
    21f0:	00000613          	li	a2,0
    21f4:	00300593          	li	a1,3
    21f8:	f8100537          	lui	a0,0xf8100
    21fc:	ca0ff0ef          	jal	ra,169c <dmasg_priority>
	   dmasg_priority(DMASG_BASE, DMASG_HW_ACCEL_S2MM_CHANNEL, 0, 0);
    2200:	00000693          	li	a3,0
    2204:	00000613          	li	a2,0
    2208:	00200593          	li	a1,2
    220c:	f8100537          	lui	a0,0xf8100
    2210:	c8cff0ef          	jal	ra,169c <dmasg_priority>
	   dmasg_priority(DMASG_BASE, DMASG_DISPLAY_MM2S_CHANNEL,  3, 0);
    2214:	00000693          	li	a3,0
    2218:	00300613          	li	a2,3
    221c:	00100593          	li	a1,1
    2220:	f8100537          	lui	a0,0xf8100
    2224:	c78ff0ef          	jal	ra,169c <dmasg_priority>
	   dmasg_priority(DMASG_BASE, DMASG_CAM_S2MM_CHANNEL,      0, 0);
    2228:	00000693          	li	a3,0
    222c:	00000613          	li	a2,0
    2230:	00000593          	li	a1,0
    2234:	f8100537          	lui	a0,0xf8100
    2238:	c64ff0ef          	jal	ra,169c <dmasg_priority>
	   //Trigger display DMA once then the rest handled by interrupt sub-rountine
	   bsp_printf("Trigger display DMA...");
    223c:	00008537          	lui	a0,0x8
    2240:	87c50513          	addi	a0,a0,-1924 # 787c <col+0x5c>
    2244:	a1dff0ef          	jal	ra,1c60 <bsp_printf>
	   send_dma(DMASG_DISPLAY_MM2S_CHANNEL, DMASG_DISPLAY_MM2S_PORT, buf(display_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
    2248:	83b1c503          	lbu	a0,-1989(gp) # 802b <display_buffer>
    224c:	bcdff0ef          	jal	ra,1e18 <buf>
    2250:	00000813          	li	a6,0
    2254:	00000793          	li	a5,0
    2258:	00100713          	li	a4,1
    225c:	004739b7          	lui	s3,0x473
    2260:	10098693          	addi	a3,s3,256 # 473100 <__freertos_irq_stack_top+0x26a230>
    2264:	00050613          	mv	a2,a0
    2268:	00000593          	li	a1,0
    226c:	00100513          	li	a0,1
    2270:	bc1ff0ef          	jal	ra,1e30 <send_dma>
	   display_mm2s_active = 1;
    2274:	82918a23          	sb	s1,-1996(gp) # 8024 <display_mm2s_active>
	   bsp_printf("Done\n\r");
    2278:	87090513          	addi	a0,s2,-1936
    227c:	9e5ff0ef          	jal	ra,1c60 <bsp_printf>

	   bsp_uDelay(3000*1000); //Display colour bar for 3 seconds
    2280:	f8b00637          	lui	a2,0xf8b00
    2284:	05f5e5b7          	lui	a1,0x5f5e
    2288:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d55230>
    228c:	002dc537          	lui	a0,0x2dc
    2290:	6c050513          	addi	a0,a0,1728 # 2dc6c0 <__freertos_irq_stack_top+0xd37f0>
    2294:	c6cff0ef          	jal	ra,1700 <clint_uDelay>
    2298:	00042623          	sw	zero,12(s0)

	   //SELECT RGB or grayscale output from camera pre-processing block.
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG3_OFFSET, 0x00000000);   //RGB
	   //uart_read(BSP_UART_TERMINAL);
	   //Trigger camera DMA once then the rest handled by interrupt sub-rountine
	   bsp_printf("Trigger camera DMA...");
    229c:	00008537          	lui	a0,0x8
    22a0:	89450513          	addi	a0,a0,-1900 # 7894 <col+0x74>
    22a4:	9bdff0ef          	jal	ra,1c60 <bsp_printf>
	   recv_dma(DMASG_CAM_S2MM_CHANNEL, DMASG_CAM_S2MM_PORT, buf(camera_buffer), (FRAME_WIDTH*FRAME_HEIGHT)*4, 1, 0, 0);
    22a8:	83c1c503          	lbu	a0,-1988(gp) # 802c <camera_buffer>
    22ac:	b6dff0ef          	jal	ra,1e18 <buf>
    22b0:	00000813          	li	a6,0
    22b4:	00000793          	li	a5,0
    22b8:	00100713          	li	a4,1
    22bc:	10098693          	addi	a3,s3,256
    22c0:	00050613          	mv	a2,a0
    22c4:	00000593          	li	a1,0
    22c8:	00000513          	li	a0,0
    22cc:	c4dff0ef          	jal	ra,1f18 <recv_dma>
	   cam_s2mm_active = 1;
    22d0:	82918aa3          	sb	s1,-1995(gp) # 8025 <cam_s2mm_active>
    22d4:	00942823          	sw	s1,16(s0)
    22d8:	00042823          	sw	zero,16(s0)
    22dc:	00200793          	li	a5,2
    22e0:	00f42423          	sw	a5,8(s0)

	   //Trigger storage of one captured frame via APB3 slave
	   EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000002);
	   //EXAMPLE_APB3_REGW(EXAMPLE_APB3_SLV, EXAMPLE_APB3_SLV_REG2_OFFSET, 0x00000000);

	   bsp_printf("Done\n\r");
    22e4:	87090513          	addi	a0,s2,-1936
    22e8:	979ff0ef          	jal	ra,1c60 <bsp_printf>
	   uint8_t color = 0;
	   int cnt = 0;
    22ec:	00000793          	li	a5,0
    22f0:	0200006f          	j	2310 <main+0x18c>
//
//	      //Wait for DMA transfer completion
//	      while(dmasg_busy(DMASG_BASE, DMASG_HW_ACCEL_MM2S_CHANNEL) || dmasg_busy(DMASG_BASE, DMASG_HW_ACCEL_S2MM_CHANNEL));
//
//	      flush_data_cache();
	      bsp_uDelay(1000*5);
    22f4:	f8b00637          	lui	a2,0xf8b00
    22f8:	05f5e5b7          	lui	a1,0x5f5e
    22fc:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d55230>
    2300:	00001537          	lui	a0,0x1
    2304:	38850513          	addi	a0,a0,904 # 1388 <uart_writeAvailability+0x8>
    2308:	bf8ff0ef          	jal	ra,1700 <clint_uDelay>
		   if(!(cnt++ & 0xff))
    230c:	00040793          	mv	a5,s0
    2310:	00178413          	addi	s0,a5,1
    2314:	0ff7f793          	andi	a5,a5,255
    2318:	fc079ee3          	bnez	a5,22f4 <main+0x170>
			   bsp_printf(".");
    231c:	00008537          	lui	a0,0x8
    2320:	8a850513          	addi	a0,a0,-1880 # 78a8 <col+0x88>
    2324:	93dff0ef          	jal	ra,1c60 <bsp_printf>
    2328:	fcdff06f          	j	22f4 <main+0x170>

0000232c <i2c_masterBusy>:
        return *((volatile u32*) address);
    232c:	04052503          	lw	a0,64(a0)
    static inline void i2c_masterRecover(u32 reg){
        write_u32(I2C_MASTER_RECOVER | I2C_MASTER_RECOVER_DROPPED, reg + I2C_MASTER_STATUS);
    }
    static int i2c_masterBusy(u32 reg){
        return (read_u32(reg + I2C_MASTER_STATUS) & I2C_MASTER_BUSY) != 0;
    }
    2330:	00157513          	andi	a0,a0,1
    2334:	00008067          	ret

00002338 <i2c_masterStartBlocking>:
        write_u32(I2C_MASTER_START | I2C_MASTER_START_DROPPED, reg + I2C_MASTER_STATUS);
    2338:	04050713          	addi	a4,a0,64
        *((volatile u32*) address) = data;
    233c:	21000793          	li	a5,528
    2340:	04f52023          	sw	a5,64(a0)
        return *((volatile u32*) address);
    2344:	00072783          	lw	a5,0(a4)
    static int i2c_masterStatus(u32 reg){
        return (read_u32(reg + I2C_MASTER_STATUS));
    }
    static void i2c_masterStartBlocking(u32 reg){
        i2c_masterStart(reg);
        while(i2c_getMasterStatus(reg) & I2C_MASTER_START);
    2348:	0107f793          	andi	a5,a5,16
    234c:	fe079ce3          	bnez	a5,2344 <i2c_masterStartBlocking+0xc>
    }
    2350:	00008067          	ret

00002354 <i2c_masterStopWait>:
            if((i2c_getMasterStatus(reg) & I2C_MASTER_RECOVER_DROPPED) == 0){
                break;
            }
        }
    }
    static void i2c_masterStopWait(u32 reg){
    2354:	ff010113          	addi	sp,sp,-16
    2358:	00112623          	sw	ra,12(sp)
    235c:	00812423          	sw	s0,8(sp)
    2360:	00050413          	mv	s0,a0
        while(i2c_masterBusy(reg));
    2364:	00040513          	mv	a0,s0
    2368:	fc5ff0ef          	jal	ra,232c <i2c_masterBusy>
    236c:	fe051ce3          	bnez	a0,2364 <i2c_masterStopWait+0x10>
    }
    2370:	00c12083          	lw	ra,12(sp)
    2374:	00812403          	lw	s0,8(sp)
    2378:	01010113          	addi	sp,sp,16
    237c:	00008067          	ret

00002380 <i2c_masterStopBlocking>:
    static inline void i2c_masterDrop(u32 reg){
        write_u32(I2C_MASTER_DROP, reg + I2C_MASTER_STATUS);
    }
    static void i2c_masterStopBlocking(u32 reg){
    2380:	ff010113          	addi	sp,sp,-16
    2384:	00112623          	sw	ra,12(sp)
        *((volatile u32*) address) = data;
    2388:	42000713          	li	a4,1056
    238c:	04e52023          	sw	a4,64(a0)
        i2c_masterStop(reg);
        i2c_masterStopWait(reg);
    2390:	fc5ff0ef          	jal	ra,2354 <i2c_masterStopWait>
    }
    2394:	00c12083          	lw	ra,12(sp)
    2398:	01010113          	addi	sp,sp,16
    239c:	00008067          	ret

000023a0 <i2c_txAckWait>:
        return *((volatile u32*) address);
    23a0:	00452783          	lw	a5,4(a0)
    }
    static inline void i2c_txNack(u32 reg){
        write_u32(1 | I2C_TX_VALID | I2C_TX_ENABLE, reg + I2C_TX_ACK);
    }
    static void i2c_txAckWait(u32 reg){
        while(read_u32(reg + I2C_TX_ACK) & I2C_TX_VALID);
    23a4:	1007f793          	andi	a5,a5,256
    23a8:	fe079ce3          	bnez	a5,23a0 <i2c_txAckWait>
    }
    23ac:	00008067          	ret

000023b0 <i2c_txNackBlocking>:
        i2c_txAck(reg);
        i2c_txAckWait(reg);


    }
    static void i2c_txNackBlocking(u32 reg){
    23b0:	ff010113          	addi	sp,sp,-16
    23b4:	00112623          	sw	ra,12(sp)
        *((volatile u32*) address) = data;
    23b8:	30100713          	li	a4,769
    23bc:	00e52223          	sw	a4,4(a0)
        i2c_txNack(reg);
        i2c_txAckWait(reg);
    23c0:	fe1ff0ef          	jal	ra,23a0 <i2c_txAckWait>
    }
    23c4:	00c12083          	lw	ra,12(sp)
    23c8:	01010113          	addi	sp,sp,16
    23cc:	00008067          	ret

000023d0 <i2c_rxData>:
        return *((volatile u32*) address);
    23d0:	00852503          	lw	a0,8(a0)
    static u32 i2c_rxData(u32 reg){
        return read_u32(reg + I2C_RX_DATA) & I2C_RX_VALUE;
    }
    23d4:	0ff57513          	andi	a0,a0,255
    23d8:	00008067          	ret

000023dc <i2c_rxNack>:
    23dc:	00c52503          	lw	a0,12(a0)
    static int i2c_rxNack(u32 reg){
        return (read_u32(reg + I2C_RX_ACK) & I2C_RX_VALUE) != 0;
    23e0:	0ff57513          	andi	a0,a0,255
    }
    23e4:	00a03533          	snez	a0,a0
    23e8:	00008067          	ret

000023ec <i2c_rxAck>:
    23ec:	00c52503          	lw	a0,12(a0)
    static int i2c_rxAck(u32 reg){
        return (read_u32(reg + I2C_RX_ACK) & I2C_RX_VALUE) == 0;
    23f0:	0ff57513          	andi	a0,a0,255
    }
    23f4:	00153513          	seqz	a0,a0
    23f8:	00008067          	ret

000023fc <PiCam_WriteRegData>:
#include "common.h"



void PiCam_WriteRegData(u16 reg,u8 data)
{
    23fc:	fe010113          	addi	sp,sp,-32
    2400:	00112e23          	sw	ra,28(sp)
    2404:	00812c23          	sw	s0,24(sp)
    2408:	00912a23          	sw	s1,20(sp)
    240c:	01212823          	sw	s2,16(sp)
    2410:	01312623          	sw	s3,12(sp)
    2414:	00050493          	mv	s1,a0
    2418:	00058993          	mv	s3,a1
	u8 outdata;

    i2c_masterStartBlocking(I2C_CTRL_MIPI);
    241c:	f8015537          	lui	a0,0xf8015
    2420:	f19ff0ef          	jal	ra,2338 <i2c_masterStartBlocking>
        *((volatile u32*) address) = data;
    2424:	f8015937          	lui	s2,0xf8015
    2428:	00001437          	lui	s0,0x1
    242c:	b2040793          	addi	a5,s0,-1248 # b20 <regnum_t6+0xb01>
    2430:	00f92023          	sw	a5,0(s2) # f8015000 <__freertos_irq_stack_top+0xf7e0c130>

    i2c_txByte(I2C_CTRL_MIPI, 0x10<<1);
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2434:	f8015537          	lui	a0,0xf8015
    2438:	f79ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    243c:	f8015537          	lui	a0,0xf8015
    2440:	fadff0ef          	jal	ra,23ec <i2c_rxAck>
    2444:	795000ef          	jal	ra,33d8 <assert>

	i2c_txByte(I2C_CTRL_MIPI, (reg>>8) & 0xFF);
    2448:	0084d793          	srli	a5,s1,0x8
        write_u32(byte | I2C_TX_VALID | I2C_TX_ENABLE | I2C_TX_DISABLE_ON_DATA_CONFLICT, reg + I2C_TX_DATA);
    244c:	b0040413          	addi	s0,s0,-1280
    2450:	0087e7b3          	or	a5,a5,s0
    2454:	00f92023          	sw	a5,0(s2)
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2458:	f8015537          	lui	a0,0xf8015
    245c:	f55ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    2460:	f8015537          	lui	a0,0xf8015
    2464:	f89ff0ef          	jal	ra,23ec <i2c_rxAck>
    2468:	771000ef          	jal	ra,33d8 <assert>

	i2c_txByte(I2C_CTRL_MIPI, (reg) & 0xFF);
    246c:	0ff4f493          	andi	s1,s1,255
    2470:	0084e4b3          	or	s1,s1,s0
    2474:	00992023          	sw	s1,0(s2)
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2478:	f8015537          	lui	a0,0xf8015
    247c:	f35ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    2480:	f8015537          	lui	a0,0xf8015
    2484:	f69ff0ef          	jal	ra,23ec <i2c_rxAck>
    2488:	751000ef          	jal	ra,33d8 <assert>
    248c:	0089e433          	or	s0,s3,s0
    2490:	00892023          	sw	s0,0(s2)

	i2c_txByte(I2C_CTRL_MIPI, data & 0xFF);
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2494:	f8015537          	lui	a0,0xf8015
    2498:	f19ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    249c:	f8015537          	lui	a0,0xf8015
    24a0:	f4dff0ef          	jal	ra,23ec <i2c_rxAck>
    24a4:	735000ef          	jal	ra,33d8 <assert>

	i2c_masterStopBlocking(I2C_CTRL_MIPI);
    24a8:	f8015537          	lui	a0,0xf8015
    24ac:	ed5ff0ef          	jal	ra,2380 <i2c_masterStopBlocking>
}
    24b0:	01c12083          	lw	ra,28(sp)
    24b4:	01812403          	lw	s0,24(sp)
    24b8:	01412483          	lw	s1,20(sp)
    24bc:	01012903          	lw	s2,16(sp)
    24c0:	00c12983          	lw	s3,12(sp)
    24c4:	02010113          	addi	sp,sp,32
    24c8:	00008067          	ret

000024cc <PiCam_ReadRegData>:

u8 PiCam_ReadRegData(u16 reg)
{
    24cc:	fe010113          	addi	sp,sp,-32
    24d0:	00112e23          	sw	ra,28(sp)
    24d4:	00812c23          	sw	s0,24(sp)
    24d8:	00912a23          	sw	s1,20(sp)
    24dc:	01212823          	sw	s2,16(sp)
    24e0:	01312623          	sw	s3,12(sp)
    24e4:	00050493          	mv	s1,a0
	u8 outdata;

    i2c_masterStartBlocking(I2C_CTRL_MIPI);
    24e8:	f8015537          	lui	a0,0xf8015
    24ec:	e4dff0ef          	jal	ra,2338 <i2c_masterStartBlocking>
    24f0:	f8015937          	lui	s2,0xf8015
    24f4:	00001437          	lui	s0,0x1
    24f8:	b2040793          	addi	a5,s0,-1248 # b20 <regnum_t6+0xb01>
    24fc:	00f92023          	sw	a5,0(s2) # f8015000 <__freertos_irq_stack_top+0xf7e0c130>

    i2c_txByte(I2C_CTRL_MIPI, 0x10<<1);
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2500:	f8015537          	lui	a0,0xf8015
    2504:	eadff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    2508:	f8015537          	lui	a0,0xf8015
    250c:	ee1ff0ef          	jal	ra,23ec <i2c_rxAck>
    2510:	6c9000ef          	jal	ra,33d8 <assert>

	i2c_txByte(I2C_CTRL_MIPI, (reg>>8) & 0xFF);
    2514:	0084d793          	srli	a5,s1,0x8
    2518:	b0040993          	addi	s3,s0,-1280
    251c:	0137e7b3          	or	a5,a5,s3
    2520:	00f92023          	sw	a5,0(s2)
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2524:	f8015537          	lui	a0,0xf8015
    2528:	e89ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    252c:	f8015537          	lui	a0,0xf8015
    2530:	ebdff0ef          	jal	ra,23ec <i2c_rxAck>
    2534:	6a5000ef          	jal	ra,33d8 <assert>

	i2c_txByte(I2C_CTRL_MIPI, (reg) & 0xFF);
    2538:	0ff4f493          	andi	s1,s1,255
    253c:	0134e4b3          	or	s1,s1,s3
    2540:	00992023          	sw	s1,0(s2)
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2544:	f8015537          	lui	a0,0xf8015
    2548:	e69ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    254c:	f8015537          	lui	a0,0xf8015
    2550:	e9dff0ef          	jal	ra,23ec <i2c_rxAck>
    2554:	685000ef          	jal	ra,33d8 <assert>

	i2c_masterStopBlocking(I2C_CTRL_MIPI);
    2558:	f8015537          	lui	a0,0xf8015
    255c:	e25ff0ef          	jal	ra,2380 <i2c_masterStopBlocking>
	i2c_masterStartBlocking(I2C_CTRL_MIPI);
    2560:	f8015537          	lui	a0,0xf8015
    2564:	dd5ff0ef          	jal	ra,2338 <i2c_masterStartBlocking>
    2568:	b2140793          	addi	a5,s0,-1247
    256c:	00f92023          	sw	a5,0(s2)

	i2c_txByte(I2C_CTRL_MIPI, (0x10<<1) | 0x01);
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    2570:	f8015537          	lui	a0,0xf8015
    2574:	e3dff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxAck(I2C_CTRL_MIPI)); // Optional check
    2578:	f8015537          	lui	a0,0xf8015
    257c:	e71ff0ef          	jal	ra,23ec <i2c_rxAck>
    2580:	659000ef          	jal	ra,33d8 <assert>
    2584:	bff40413          	addi	s0,s0,-1025
    2588:	00892023          	sw	s0,0(s2)

	i2c_txByte(I2C_CTRL_MIPI, 0xFF);
	i2c_txNackBlocking(I2C_CTRL_MIPI);
    258c:	f8015537          	lui	a0,0xf8015
    2590:	e21ff0ef          	jal	ra,23b0 <i2c_txNackBlocking>
	assert(i2c_rxNack(I2C_CTRL_MIPI)); // Optional check
    2594:	f8015537          	lui	a0,0xf8015
    2598:	e45ff0ef          	jal	ra,23dc <i2c_rxNack>
    259c:	63d000ef          	jal	ra,33d8 <assert>
	outdata = i2c_rxData(I2C_CTRL_MIPI);
    25a0:	f8015537          	lui	a0,0xf8015
    25a4:	e2dff0ef          	jal	ra,23d0 <i2c_rxData>
    25a8:	0ff57413          	andi	s0,a0,255

	i2c_masterStopBlocking(I2C_CTRL_MIPI);
    25ac:	f8015537          	lui	a0,0xf8015
    25b0:	dd1ff0ef          	jal	ra,2380 <i2c_masterStopBlocking>

	return outdata;
}
    25b4:	00040513          	mv	a0,s0
    25b8:	01c12083          	lw	ra,28(sp)
    25bc:	01812403          	lw	s0,24(sp)
    25c0:	01412483          	lw	s1,20(sp)
    25c4:	01012903          	lw	s2,16(sp)
    25c8:	00c12983          	lw	s3,12(sp)
    25cc:	02010113          	addi	sp,sp,32
    25d0:	00008067          	ret

000025d4 <AccessCommSeq>:
void AccessCommSeq(void)
{
    25d4:	ff010113          	addi	sp,sp,-16
    25d8:	00112623          	sw	ra,12(sp)
    25dc:	00812423          	sw	s0,8(sp)
	PiCam_WriteRegData(0x30EB, 0x05);
    25e0:	00500593          	li	a1,5
    25e4:	00003437          	lui	s0,0x3
    25e8:	0eb40513          	addi	a0,s0,235 # 30eb <print_float+0xb>
    25ec:	e11ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(0x30EB, 0x0C);
    25f0:	00c00593          	li	a1,12
    25f4:	0eb40513          	addi	a0,s0,235
    25f8:	e05ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(0x300A, 0xFF);
    25fc:	0ff00593          	li	a1,255
    2600:	00a40513          	addi	a0,s0,10
    2604:	df9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(0x300B, 0xFF);
    2608:	0ff00593          	li	a1,255
    260c:	00b40513          	addi	a0,s0,11
    2610:	dedff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(0x30EB, 0x05);
    2614:	00500593          	li	a1,5
    2618:	0eb40513          	addi	a0,s0,235
    261c:	de1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(0x30EB, 0x09);
    2620:	00900593          	li	a1,9
    2624:	0eb40513          	addi	a0,s0,235
    2628:	dd5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    262c:	00c12083          	lw	ra,12(sp)
    2630:	00812403          	lw	s0,8(sp)
    2634:	01010113          	addi	sp,sp,16
    2638:	00008067          	ret

0000263c <PiCam_Output_Size>:

void PiCam_Output_Size(u16 X,u16 Y)
{
    263c:	ff010113          	addi	sp,sp,-16
    2640:	00112623          	sw	ra,12(sp)
    2644:	00812423          	sw	s0,8(sp)
    2648:	00912223          	sw	s1,4(sp)
    264c:	00050493          	mv	s1,a0
    2650:	00058413          	mv	s0,a1
	PiCam_WriteRegData(x_output_size_A_1	, X>>8);
    2654:	00855593          	srli	a1,a0,0x8
    2658:	16c00513          	li	a0,364
    265c:	da1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(x_output_size_A_0	, X & 0xFF);
    2660:	0ff4f593          	andi	a1,s1,255
    2664:	16d00513          	li	a0,365
    2668:	d95ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(y_output_size_A_1	, Y>>8);
    266c:	00845593          	srli	a1,s0,0x8
    2670:	16e00513          	li	a0,366
    2674:	d89ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(y_output_size_A_0	, Y & 0xFF);
    2678:	0ff47593          	andi	a1,s0,255
    267c:	16f00513          	li	a0,367
    2680:	d7dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2684:	00c12083          	lw	ra,12(sp)
    2688:	00812403          	lw	s0,8(sp)
    268c:	00412483          	lw	s1,4(sp)
    2690:	01010113          	addi	sp,sp,16
    2694:	00008067          	ret

00002698 <PiCam_Output_activePixel>:

void PiCam_Output_activePixel(u16 XStart,u16 XEnd, u16 YStart, u16 YEnd)
{
    2698:	fe010113          	addi	sp,sp,-32
    269c:	00112e23          	sw	ra,28(sp)
    26a0:	00812c23          	sw	s0,24(sp)
    26a4:	00912a23          	sw	s1,20(sp)
    26a8:	01212823          	sw	s2,16(sp)
    26ac:	01312623          	sw	s3,12(sp)
    26b0:	00050993          	mv	s3,a0
    26b4:	00058913          	mv	s2,a1
    26b8:	00060493          	mv	s1,a2
    26bc:	00068413          	mv	s0,a3

	//Max Active pixel 3280* 2464--imx219

	PiCam_WriteRegData(X_ADD_STA_A_1	, XStart>>8);
    26c0:	00855593          	srli	a1,a0,0x8
    26c4:	16400513          	li	a0,356
    26c8:	d35ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_STA_A_0	, XStart&0xFF);
    26cc:	0ff9f593          	andi	a1,s3,255
    26d0:	16500513          	li	a0,357
    26d4:	d29ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_END_A_1	, XEnd>>8);
    26d8:	00895593          	srli	a1,s2,0x8
    26dc:	16600513          	li	a0,358
    26e0:	d1dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_END_A_0	, XEnd&0xFF);
    26e4:	0ff97593          	andi	a1,s2,255
    26e8:	16700513          	li	a0,359
    26ec:	d11ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

	PiCam_WriteRegData(Y_ADD_STA_A_1	, YStart>>8);
    26f0:	0084d593          	srli	a1,s1,0x8
    26f4:	16800513          	li	a0,360
    26f8:	d05ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_STA_A_0	, YStart&0xFF);
    26fc:	0ff4f593          	andi	a1,s1,255
    2700:	16900513          	li	a0,361
    2704:	cf9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_END_A_1	, YEnd>>8);
    2708:	00845593          	srli	a1,s0,0x8
    270c:	16a00513          	li	a0,362
    2710:	cedff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_END_A_0	, YEnd&0xFF);
    2714:	0ff47593          	andi	a1,s0,255
    2718:	16b00513          	li	a0,363
    271c:	ce1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2720:	01c12083          	lw	ra,28(sp)
    2724:	01812403          	lw	s0,24(sp)
    2728:	01412483          	lw	s1,20(sp)
    272c:	01012903          	lw	s2,16(sp)
    2730:	00c12983          	lw	s3,12(sp)
    2734:	02010113          	addi	sp,sp,32
    2738:	00008067          	ret

0000273c <PiCam_Output_activePixelX>:

void PiCam_Output_activePixelX(u16 XStart,u16 XEnd)
{
    273c:	ff010113          	addi	sp,sp,-16
    2740:	00112623          	sw	ra,12(sp)
    2744:	00812423          	sw	s0,8(sp)
    2748:	00912223          	sw	s1,4(sp)
    274c:	00050493          	mv	s1,a0
    2750:	00058413          	mv	s0,a1
	//Max Active pixel 3280* 2464--imx219

	PiCam_WriteRegData(X_ADD_STA_A_1	, XStart>>8);
    2754:	00855593          	srli	a1,a0,0x8
    2758:	16400513          	li	a0,356
    275c:	ca1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_STA_A_0	, XStart&0xFF);
    2760:	0ff4f593          	andi	a1,s1,255
    2764:	16500513          	li	a0,357
    2768:	c95ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_END_A_1	, XEnd>>8);
    276c:	00845593          	srli	a1,s0,0x8
    2770:	16600513          	li	a0,358
    2774:	c89ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(X_ADD_END_A_0	, XEnd&0xFF);
    2778:	0ff47593          	andi	a1,s0,255
    277c:	16700513          	li	a0,359
    2780:	c7dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2784:	00c12083          	lw	ra,12(sp)
    2788:	00812403          	lw	s0,8(sp)
    278c:	00412483          	lw	s1,4(sp)
    2790:	01010113          	addi	sp,sp,16
    2794:	00008067          	ret

00002798 <PiCam_Output_activePixelY>:

void PiCam_Output_activePixelY(u16 YStart,u16 YEnd)
{
    2798:	ff010113          	addi	sp,sp,-16
    279c:	00112623          	sw	ra,12(sp)
    27a0:	00812423          	sw	s0,8(sp)
    27a4:	00912223          	sw	s1,4(sp)
    27a8:	00050493          	mv	s1,a0
    27ac:	00058413          	mv	s0,a1
	//Max Active pixel 3280* 2464--imx219

	PiCam_WriteRegData(Y_ADD_STA_A_1	, YStart>>8);
    27b0:	00855593          	srli	a1,a0,0x8
    27b4:	16800513          	li	a0,360
    27b8:	c45ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_STA_A_0	, YStart&0xFF);
    27bc:	0ff4f593          	andi	a1,s1,255
    27c0:	16900513          	li	a0,361
    27c4:	c39ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_END_A_1	, YEnd>>8);
    27c8:	00845593          	srli	a1,s0,0x8
    27cc:	16a00513          	li	a0,362
    27d0:	c2dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(Y_ADD_END_A_0	, YEnd&0xFF);
    27d4:	0ff47593          	andi	a1,s0,255
    27d8:	16b00513          	li	a0,363
    27dc:	c21ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    27e0:	00c12083          	lw	ra,12(sp)
    27e4:	00812403          	lw	s0,8(sp)
    27e8:	00412483          	lw	s1,4(sp)
    27ec:	01010113          	addi	sp,sp,16
    27f0:	00008067          	ret

000027f4 <PiCam_SetBinningMode>:

void PiCam_SetBinningMode(u8 Xmode, u8 Ymode)
{
    27f4:	ff010113          	addi	sp,sp,-16
    27f8:	00112623          	sw	ra,12(sp)
    27fc:	00812423          	sw	s0,8(sp)
    2800:	00058413          	mv	s0,a1
	//0:no-binning
	//1:x2-binning
	//2:x4-binning
	//3:x2 analog (special)

	if(Xmode>=3)	Xmode=3;
    2804:	00200793          	li	a5,2
    2808:	00a7f463          	bgeu	a5,a0,2810 <PiCam_SetBinningMode+0x1c>
    280c:	00300513          	li	a0,3
	if(Ymode>=3)	Ymode=3;
    2810:	00200793          	li	a5,2
    2814:	0087f463          	bgeu	a5,s0,281c <PiCam_SetBinningMode+0x28>
    2818:	00300413          	li	s0,3

	PiCam_WriteRegData(BINNING_MODE_H_A, Xmode);
    281c:	00050593          	mv	a1,a0
    2820:	17400513          	li	a0,372
    2824:	bd9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(BINNING_MODE_V_A, Ymode);
    2828:	00040593          	mv	a1,s0
    282c:	17500513          	li	a0,373
    2830:	bcdff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2834:	00c12083          	lw	ra,12(sp)
    2838:	00812403          	lw	s0,8(sp)
    283c:	01010113          	addi	sp,sp,16
    2840:	00008067          	ret

00002844 <PiCam_Output_ColorBarSize>:

void PiCam_Output_ColorBarSize(u16 X,u16 Y)
{
    2844:	ff010113          	addi	sp,sp,-16
    2848:	00112623          	sw	ra,12(sp)
    284c:	00812423          	sw	s0,8(sp)
    2850:	00912223          	sw	s1,4(sp)
    2854:	00050493          	mv	s1,a0
    2858:	00058413          	mv	s0,a1
	PiCam_WriteRegData(TP_WINDOW_WIDTH_1	, X>>8);
    285c:	00855593          	srli	a1,a0,0x8
    2860:	62400513          	li	a0,1572
    2864:	b99ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(TP_WINDOW_WIDTH_0	, X & 0xFF);
    2868:	0ff4f593          	andi	a1,s1,255
    286c:	62500513          	li	a0,1573
    2870:	b8dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(TP_WINDOW_HEIGHT_1	, Y>>8);
    2874:	00845593          	srli	a1,s0,0x8
    2878:	62600513          	li	a0,1574
    287c:	b81ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(TP_WINDOW_HEIGHT_0	, Y & 0xFF);
    2880:	0ff47593          	andi	a1,s0,255
    2884:	62700513          	li	a0,1575
    2888:	b75ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    288c:	00c12083          	lw	ra,12(sp)
    2890:	00812403          	lw	s0,8(sp)
    2894:	00412483          	lw	s1,4(sp)
    2898:	01010113          	addi	sp,sp,16
    289c:	00008067          	ret

000028a0 <PiCam_TestPattern>:

void PiCam_TestPattern(u8 Enable,u8 mode,u16 X,u16 Y)
{
    28a0:	fe010113          	addi	sp,sp,-32
    28a4:	00112e23          	sw	ra,28(sp)
    28a8:	00812c23          	sw	s0,24(sp)
    28ac:	00912a23          	sw	s1,20(sp)
    28b0:	01212823          	sw	s2,16(sp)
    28b4:	01312623          	sw	s3,12(sp)
    28b8:	00050413          	mv	s0,a0
    28bc:	00058993          	mv	s3,a1
    28c0:	00060493          	mv	s1,a2
    28c4:	00068913          	mv	s2,a3
	//0006h - 16 split inverted color bar
	//0007h - column counter
	//0008h - inverted column counter
	//0009h - PN31

	PiCam_WriteRegData(test_pattern_Ena, 0x00);
    28c8:	00000593          	li	a1,0
    28cc:	60000513          	li	a0,1536
    28d0:	b2dff0ef          	jal	ra,23fc <PiCam_WriteRegData>

	if(Enable==0)	mode=0;
    28d4:	00040463          	beqz	s0,28dc <PiCam_TestPattern+0x3c>
    28d8:	00098413          	mv	s0,s3

	PiCam_WriteRegData(test_pattern_mode, mode);
    28dc:	00040593          	mv	a1,s0
    28e0:	60100513          	li	a0,1537
    28e4:	b19ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

	PiCam_Output_ColorBarSize(X,Y);
    28e8:	00090593          	mv	a1,s2
    28ec:	00048513          	mv	a0,s1
    28f0:	f55ff0ef          	jal	ra,2844 <PiCam_Output_ColorBarSize>
}
    28f4:	01c12083          	lw	ra,28(sp)
    28f8:	01812403          	lw	s0,24(sp)
    28fc:	01412483          	lw	s1,20(sp)
    2900:	01012903          	lw	s2,16(sp)
    2904:	00c12983          	lw	s3,12(sp)
    2908:	02010113          	addi	sp,sp,32
    290c:	00008067          	ret

00002910 <PiCam_Gainfilter>:

void PiCam_Gainfilter(u8 AGain, u16 DGain)
{
    2910:	ff010113          	addi	sp,sp,-16
    2914:	00112623          	sw	ra,12(sp)
    2918:	00812423          	sw	s0,8(sp)
    291c:	00058413          	mv	s0,a1
	PiCam_WriteRegData(ANA_GAIN_GLOBAL_A, AGain&0xFF);
    2920:	00050593          	mv	a1,a0
    2924:	15700513          	li	a0,343
    2928:	ad5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(DIG_GAIN_GLOBAL_A_1, (DGain>>8)&0x0F);
    292c:	00845593          	srli	a1,s0,0x8
    2930:	00f5f593          	andi	a1,a1,15
    2934:	15800513          	li	a0,344
    2938:	ac5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
	PiCam_WriteRegData(DIG_GAIN_GLOBAL_A_0, DGain&0xFF);
    293c:	0ff47593          	andi	a1,s0,255
    2940:	15900513          	li	a0,345
    2944:	ab9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2948:	00c12083          	lw	ra,12(sp)
    294c:	00812403          	lw	s0,8(sp)
    2950:	01010113          	addi	sp,sp,16
    2954:	00008067          	ret

00002958 <PiCam_init>:



void PiCam_init(void)
{
    2958:	ff010113          	addi	sp,sp,-16
    295c:	00112623          	sw	ra,12(sp)
   PiCam_WriteRegData(mode_select, 0x00);
    2960:	00000593          	li	a1,0
    2964:	10000513          	li	a0,256
    2968:	a95ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   AccessCommSeq();
    296c:	c69ff0ef          	jal	ra,25d4 <AccessCommSeq>
   PiCam_WriteRegData(CSI_LANE_MODE, 0x01);
    2970:	00100593          	li	a1,1
    2974:	11400513          	li	a0,276
    2978:	a85ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(DPHY_CTRL, 0x00);
    297c:	00000593          	li	a1,0
    2980:	12800513          	li	a0,296
    2984:	a79ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(EXCK_FREQ_1, 0x18);
    2988:	01800593          	li	a1,24
    298c:	12a00513          	li	a0,298
    2990:	a6dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(EXCK_FREQ_0, 0x00);
    2994:	00000593          	li	a1,0
    2998:	12b00513          	li	a0,299
    299c:	a61ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(FRM_LENGTH_A_1, 0x04);
    29a0:	00400593          	li	a1,4
    29a4:	16000513          	li	a0,352
    29a8:	a55ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(FRM_LENGTH_A_0, 0x59);
    29ac:	05900593          	li	a1,89
    29b0:	16100513          	li	a0,353
    29b4:	a49ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_WriteRegData(LINE_LENGTH_A_1, 0x0D);
    29b8:	00d00593          	li	a1,13
    29bc:	16200513          	li	a0,354
    29c0:	a3dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(LINE_LENGTH_A_0, 0x78);
    29c4:	07800593          	li	a1,120
    29c8:	16300513          	li	a0,355
    29cc:	a31ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   //PiCam_Output_activePixel(0, 3279, 0, 2463);
   PiCam_Output_activePixel(680, 3279, 0, 2463); //Use offset to have central view for 1920 frame width
    29d0:	000015b7          	lui	a1,0x1
    29d4:	99f58693          	addi	a3,a1,-1633 # 99f <regnum_t6+0x980>
    29d8:	00000613          	li	a2,0
    29dc:	ccf58593          	addi	a1,a1,-817
    29e0:	2a800513          	li	a0,680
    29e4:	cb5ff0ef          	jal	ra,2698 <PiCam_Output_activePixel>

   PiCam_Output_Size(1920, 1080);
    29e8:	43800593          	li	a1,1080
    29ec:	78000513          	li	a0,1920
    29f0:	c4dff0ef          	jal	ra,263c <PiCam_Output_Size>
   //PiCam_Output_Size(1280, 720);
   //PiCam_Output_Size(640, 480);

   PiCam_WriteRegData(X_ODD_INC_A, 0x01);
    29f4:	00100593          	li	a1,1
    29f8:	17000513          	li	a0,368
    29fc:	a01ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(Y_ODD_INC_A, 0x01);
    2a00:	00100593          	li	a1,1
    2a04:	17100513          	li	a0,369
    2a08:	9f5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   //0: No binning; 1: x2 binning; 2: x4 binning; 3: x2 binning (analog special)
   PiCam_SetBinningMode(0, 0);
    2a0c:	00000593          	li	a1,0
    2a10:	00000513          	li	a0,0
    2a14:	de1ff0ef          	jal	ra,27f4 <PiCam_SetBinningMode>

   PiCam_WriteRegData(CSI_DATA_FORMAT_A_1, 0x0A);
    2a18:	00a00593          	li	a1,10
    2a1c:	18c00513          	li	a0,396
    2a20:	9ddff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(CSI_DATA_FORMAT_A_0, 0x0A);
    2a24:	00a00593          	li	a1,10
    2a28:	18d00513          	li	a0,397
    2a2c:	9d1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_WriteRegData(VTPXCK_DIV, 0x05);
    2a30:	00500593          	li	a1,5
    2a34:	30100513          	li	a0,769
    2a38:	9c5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(VTSYCK_DIV, 0x01);
    2a3c:	00100593          	li	a1,1
    2a40:	30300513          	li	a0,771
    2a44:	9b9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PREPLLCK_VT_DIV, 0x03);
    2a48:	00300593          	li	a1,3
    2a4c:	30400513          	li	a0,772
    2a50:	9adff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PREPLLCK_OP_DIV, 0x03);
    2a54:	00300593          	li	a1,3
    2a58:	30500513          	li	a0,773
    2a5c:	9a1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_VT_MPY_1, 0x00);
    2a60:	00000593          	li	a1,0
    2a64:	30600513          	li	a0,774
    2a68:	995ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_VT_MPY_0, 0x39);
    2a6c:	03900593          	li	a1,57
    2a70:	30700513          	li	a0,775
    2a74:	989ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(OPPXCK_DIV, 0x0A);
    2a78:	00a00593          	li	a1,10
    2a7c:	30900513          	li	a0,777
    2a80:	97dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(OPSYCK_DIV, 0x01);
    2a84:	00100593          	li	a1,1
    2a88:	30b00513          	li	a0,779
    2a8c:	971ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_OP_MPY_1, 0x00);
    2a90:	00000593          	li	a1,0
    2a94:	30c00513          	li	a0,780
    2a98:	965ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_OP_MPY_0, 0x72);
    2a9c:	07200593          	li	a1,114
    2aa0:	30d00513          	li	a0,781
    2aa4:	959ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_WriteRegData(OPPXCK_DIV, 0x0A);
    2aa8:	00a00593          	li	a1,10
    2aac:	30900513          	li	a0,777
    2ab0:	94dff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(OPSYCK_DIV, 0x01);
    2ab4:	00100593          	li	a1,1
    2ab8:	30b00513          	li	a0,779
    2abc:	941ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_OP_MPY_1, 0x00);
    2ac0:	00000593          	li	a1,0
    2ac4:	30c00513          	li	a0,780
    2ac8:	935ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(PLL_OP_MPY_0, 0x72);
    2acc:	07200593          	li	a1,114
    2ad0:	30d00513          	li	a0,781
    2ad4:	929ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_WriteRegData(mode_select, 0x01);
    2ad8:	00100593          	li	a1,1
    2adc:	10000513          	li	a0,256
    2ae0:	91dff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_Gainfilter(0xB9, 0x200);
    2ae4:	20000593          	li	a1,512
    2ae8:	0b900513          	li	a0,185
    2aec:	e25ff0ef          	jal	ra,2910 <PiCam_Gainfilter>

   PiCam_WriteRegData(LINE_LENGTH_A_1, 0x0D);
    2af0:	00d00593          	li	a1,13
    2af4:	16200513          	li	a0,354
    2af8:	905ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(LINE_LENGTH_A_0, 0x78);
    2afc:	07800593          	li	a1,120
    2b00:	16300513          	li	a0,355
    2b04:	8f9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(COARSE_INTEGRATION_TIME_A_1, 0x04);
   PiCam_WriteRegData(COARSE_INTEGRATION_TIME_A_0, 0x54);
*/

   //Longer camera exposure time, suitable for low light condition. Trade-off with lower frame rate. 20 fps
   PiCam_WriteRegData(FRM_LENGTH_A_1, 0x0A);
    2b08:	00a00593          	li	a1,10
    2b0c:	16000513          	li	a0,352
    2b10:	8edff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(FRM_LENGTH_A_0, 0xA8);
    2b14:	0a800593          	li	a1,168
    2b18:	16100513          	li	a0,353
    2b1c:	8e1ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(COARSE_INTEGRATION_TIME_A_1, 0x0A);
    2b20:	00a00593          	li	a1,10
    2b24:	15a00513          	li	a0,346
    2b28:	8d5ff0ef          	jal	ra,23fc <PiCam_WriteRegData>
   PiCam_WriteRegData(COARSE_INTEGRATION_TIME_A_0, 0x54);
    2b2c:	05400593          	li	a1,84
    2b30:	15b00513          	li	a0,347
    2b34:	8c9ff0ef          	jal	ra,23fc <PiCam_WriteRegData>

   PiCam_WriteRegData(IMG_ORIENTATION_A, 0x00);
    2b38:	00000593          	li	a1,0
    2b3c:	17200513          	li	a0,370
    2b40:	8bdff0ef          	jal	ra,23fc <PiCam_WriteRegData>
}
    2b44:	00c12083          	lw	ra,12(sp)
    2b48:	01010113          	addi	sp,sp,16
    2b4c:	00008067          	ret

00002b50 <uart_writeAvailability>:
        return *((volatile u32*) address);
    2b50:	00452503          	lw	a0,4(a0) # f8015004 <__freertos_irq_stack_top+0xf7e0c134>
        return (read_u32(reg + UART_STATUS) >> 16) & 0xFF;
    2b54:	01055513          	srli	a0,a0,0x10
    }
    2b58:	0ff57513          	andi	a0,a0,255
    2b5c:	00008067          	ret

00002b60 <uart_readOccupancy>:
    2b60:	00452503          	lw	a0,4(a0)
    }
    2b64:	01855513          	srli	a0,a0,0x18
    2b68:	00008067          	ret

00002b6c <uart_write>:
    static void uart_write(u32 reg, char data){
    2b6c:	ff010113          	addi	sp,sp,-16
    2b70:	00112623          	sw	ra,12(sp)
    2b74:	00812423          	sw	s0,8(sp)
    2b78:	00912223          	sw	s1,4(sp)
    2b7c:	00050413          	mv	s0,a0
    2b80:	00058493          	mv	s1,a1
        while(uart_writeAvailability(reg) == 0);
    2b84:	00040513          	mv	a0,s0
    2b88:	fc9ff0ef          	jal	ra,2b50 <uart_writeAvailability>
    2b8c:	fe050ce3          	beqz	a0,2b84 <uart_write+0x18>
        *((volatile u32*) address) = data;
    2b90:	00942023          	sw	s1,0(s0)
    }
    2b94:	00c12083          	lw	ra,12(sp)
    2b98:	00812403          	lw	s0,8(sp)
    2b9c:	00412483          	lw	s1,4(sp)
    2ba0:	01010113          	addi	sp,sp,16
    2ba4:	00008067          	ret

00002ba8 <uart_writeStr>:
    static void uart_writeStr(u32 reg, const char* str){
    2ba8:	ff010113          	addi	sp,sp,-16
    2bac:	00112623          	sw	ra,12(sp)
    2bb0:	00812423          	sw	s0,8(sp)
    2bb4:	00912223          	sw	s1,4(sp)
    2bb8:	00050493          	mv	s1,a0
    2bbc:	00058413          	mv	s0,a1
        while(*str) uart_write(reg, *str++);
    2bc0:	00044583          	lbu	a1,0(s0)
    2bc4:	00058a63          	beqz	a1,2bd8 <uart_writeStr+0x30>
    2bc8:	00140413          	addi	s0,s0,1
    2bcc:	00048513          	mv	a0,s1
    2bd0:	f9dff0ef          	jal	ra,2b6c <uart_write>
    2bd4:	fedff06f          	j	2bc0 <uart_writeStr+0x18>
    }
    2bd8:	00c12083          	lw	ra,12(sp)
    2bdc:	00812403          	lw	s0,8(sp)
    2be0:	00412483          	lw	s1,4(sp)
    2be4:	01010113          	addi	sp,sp,16
    2be8:	00008067          	ret

00002bec <uart_read>:
    
    static char uart_read(u32 reg){
    2bec:	ff010113          	addi	sp,sp,-16
    2bf0:	00112623          	sw	ra,12(sp)
    2bf4:	00812423          	sw	s0,8(sp)
    2bf8:	00050413          	mv	s0,a0
        while(uart_readOccupancy(reg) == 0);
    2bfc:	00040513          	mv	a0,s0
    2c00:	f61ff0ef          	jal	ra,2b60 <uart_readOccupancy>
    2c04:	fe050ce3          	beqz	a0,2bfc <uart_read+0x10>
        return *((volatile u32*) address);
    2c08:	00042503          	lw	a0,0(s0)
        return read_u32(reg + UART_DATA);
    }
    2c0c:	0ff57513          	andi	a0,a0,255
    2c10:	00c12083          	lw	ra,12(sp)
    2c14:	00812403          	lw	s0,8(sp)
    2c18:	01010113          	addi	sp,sp,16
    2c1c:	00008067          	ret

00002c20 <clint_uDelay>:
        u32 mTimePerUsec = hz/1000000;
    2c20:	000f47b7          	lui	a5,0xf4
    2c24:	24078793          	addi	a5,a5,576 # f4240 <_end+0xeb370>
    2c28:	02f5d5b3          	divu	a1,a1,a5
    readReg_u32 (clint_getTimeLow , CLINT_TIME_ADDR)
    2c2c:	0000c7b7          	lui	a5,0xc
    2c30:	ff878793          	addi	a5,a5,-8 # bff8 <_end+0x3128>
    2c34:	00f60633          	add	a2,a2,a5
    2c38:	00062783          	lw	a5,0(a2) # f8b00000 <__freertos_irq_stack_top+0xf88f7130>
        u32 limit = clint_getTimeLow(reg) + usec*mTimePerUsec;
    2c3c:	02a58533          	mul	a0,a1,a0
    2c40:	00f50533          	add	a0,a0,a5
    2c44:	00062783          	lw	a5,0(a2)
        while((int32_t)(limit-(clint_getTimeLow(reg))) >= 0);
    2c48:	40f507b3          	sub	a5,a0,a5
    2c4c:	fe07dce3          	bgez	a5,2c44 <clint_uDelay+0x24>
    }
    2c50:	00008067          	ret

00002c54 <_putchar>:
    static void _putchar(char character){
    2c54:	ff010113          	addi	sp,sp,-16
    2c58:	00112623          	sw	ra,12(sp)
            bsp_putChar(character);
    2c5c:	00050593          	mv	a1,a0
    2c60:	f8010537          	lui	a0,0xf8010
    2c64:	f09ff0ef          	jal	ra,2b6c <uart_write>
    }
    2c68:	00c12083          	lw	ra,12(sp)
    2c6c:	01010113          	addi	sp,sp,16
    2c70:	00008067          	ret

00002c74 <_putchar_s>:
    {
    2c74:	ff010113          	addi	sp,sp,-16
    2c78:	00112623          	sw	ra,12(sp)
    2c7c:	00812423          	sw	s0,8(sp)
    2c80:	00050413          	mv	s0,a0
        while (*p)
    2c84:	00044503          	lbu	a0,0(s0)
    2c88:	00050863          	beqz	a0,2c98 <_putchar_s+0x24>
            _putchar(*(p++));
    2c8c:	00140413          	addi	s0,s0,1
    2c90:	fc5ff0ef          	jal	ra,2c54 <_putchar>
    2c94:	ff1ff06f          	j	2c84 <_putchar_s+0x10>
    }
    2c98:	00c12083          	lw	ra,12(sp)
    2c9c:	00812403          	lw	s0,8(sp)
    2ca0:	01010113          	addi	sp,sp,16
    2ca4:	00008067          	ret

00002ca8 <bsp_printHex>:
    {
    2ca8:	ff010113          	addi	sp,sp,-16
    2cac:	00112623          	sw	ra,12(sp)
    2cb0:	00812423          	sw	s0,8(sp)
    2cb4:	00912223          	sw	s1,4(sp)
    2cb8:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2cbc:	01c00413          	li	s0,28
    2cc0:	0240006f          	j	2ce4 <bsp_printHex+0x3c>
            _putchar("0123456789ABCDEF"[(val >> i) % 16]);
    2cc4:	0084d7b3          	srl	a5,s1,s0
    2cc8:	00f7f713          	andi	a4,a5,15
    2ccc:	000087b7          	lui	a5,0x8
    2cd0:	82c78793          	addi	a5,a5,-2004 # 782c <col+0xc>
    2cd4:	00e787b3          	add	a5,a5,a4
    2cd8:	0007c503          	lbu	a0,0(a5)
    2cdc:	f79ff0ef          	jal	ra,2c54 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2ce0:	ffc40413          	addi	s0,s0,-4
    2ce4:	fe0450e3          	bgez	s0,2cc4 <bsp_printHex+0x1c>
    }
    2ce8:	00c12083          	lw	ra,12(sp)
    2cec:	00812403          	lw	s0,8(sp)
    2cf0:	00412483          	lw	s1,4(sp)
    2cf4:	01010113          	addi	sp,sp,16
    2cf8:	00008067          	ret

00002cfc <bsp_printHex_lower>:
    {
    2cfc:	ff010113          	addi	sp,sp,-16
    2d00:	00112623          	sw	ra,12(sp)
    2d04:	00812423          	sw	s0,8(sp)
    2d08:	00912223          	sw	s1,4(sp)
    2d0c:	00050493          	mv	s1,a0
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2d10:	01c00413          	li	s0,28
    2d14:	0240006f          	j	2d38 <bsp_printHex_lower+0x3c>
            _putchar("0123456789abcdef"[(val >> i) % 16]);
    2d18:	0084d7b3          	srl	a5,s1,s0
    2d1c:	00f7f713          	andi	a4,a5,15
    2d20:	000087b7          	lui	a5,0x8
    2d24:	84078793          	addi	a5,a5,-1984 # 7840 <col+0x20>
    2d28:	00e787b3          	add	a5,a5,a4
    2d2c:	0007c503          	lbu	a0,0(a5)
    2d30:	f25ff0ef          	jal	ra,2c54 <_putchar>
        for (int i = (4*digits)-4; i >= 0; i -= 4) {
    2d34:	ffc40413          	addi	s0,s0,-4
    2d38:	fe0450e3          	bgez	s0,2d18 <bsp_printHex_lower+0x1c>
    }
    2d3c:	00c12083          	lw	ra,12(sp)
    2d40:	00812403          	lw	s0,8(sp)
    2d44:	00412483          	lw	s1,4(sp)
    2d48:	01010113          	addi	sp,sp,16
    2d4c:	00008067          	ret

00002d50 <bsp_printf_c>:
    {
    2d50:	ff010113          	addi	sp,sp,-16
    2d54:	00112623          	sw	ra,12(sp)
        _putchar(c);
    2d58:	0ff57513          	andi	a0,a0,255
    2d5c:	ef9ff0ef          	jal	ra,2c54 <_putchar>
    }
    2d60:	00c12083          	lw	ra,12(sp)
    2d64:	01010113          	addi	sp,sp,16
    2d68:	00008067          	ret

00002d6c <bsp_printf_s>:
    {
    2d6c:	ff010113          	addi	sp,sp,-16
    2d70:	00112623          	sw	ra,12(sp)
        _putchar_s(p);
    2d74:	f01ff0ef          	jal	ra,2c74 <_putchar_s>
    }
    2d78:	00c12083          	lw	ra,12(sp)
    2d7c:	01010113          	addi	sp,sp,16
    2d80:	00008067          	ret

00002d84 <bsp_printf_d>:
    {
    2d84:	fd010113          	addi	sp,sp,-48
    2d88:	02112623          	sw	ra,44(sp)
    2d8c:	02812423          	sw	s0,40(sp)
    2d90:	02912223          	sw	s1,36(sp)
    2d94:	00050493          	mv	s1,a0
        if (val < 0) {
    2d98:	00054663          	bltz	a0,2da4 <bsp_printf_d+0x20>
    {
    2d9c:	00010413          	mv	s0,sp
    2da0:	02c0006f          	j	2dcc <bsp_printf_d+0x48>
            bsp_printf_c('-');
    2da4:	02d00513          	li	a0,45
    2da8:	fa9ff0ef          	jal	ra,2d50 <bsp_printf_c>
            val = -val;
    2dac:	409004b3          	neg	s1,s1
    2db0:	fedff06f          	j	2d9c <bsp_printf_d+0x18>
            *(p++) = '0' + val % 10;
    2db4:	00a00713          	li	a4,10
    2db8:	02e4e7b3          	rem	a5,s1,a4
    2dbc:	03078793          	addi	a5,a5,48
    2dc0:	00f40023          	sb	a5,0(s0)
            val = val / 10;
    2dc4:	02e4c4b3          	div	s1,s1,a4
            *(p++) = '0' + val % 10;
    2dc8:	00140413          	addi	s0,s0,1
        while (val || p == buffer) {
    2dcc:	fe0494e3          	bnez	s1,2db4 <bsp_printf_d+0x30>
    2dd0:	00010793          	mv	a5,sp
    2dd4:	fef400e3          	beq	s0,a5,2db4 <bsp_printf_d+0x30>
    2dd8:	0100006f          	j	2de8 <bsp_printf_d+0x64>
            bsp_printf_c(*(--p));
    2ddc:	fff40413          	addi	s0,s0,-1
    2de0:	00044503          	lbu	a0,0(s0)
    2de4:	f6dff0ef          	jal	ra,2d50 <bsp_printf_c>
        while (p != buffer)
    2de8:	00010793          	mv	a5,sp
    2dec:	fef418e3          	bne	s0,a5,2ddc <bsp_printf_d+0x58>
    }
    2df0:	02c12083          	lw	ra,44(sp)
    2df4:	02812403          	lw	s0,40(sp)
    2df8:	02412483          	lw	s1,36(sp)
    2dfc:	03010113          	addi	sp,sp,48
    2e00:	00008067          	ret

00002e04 <bsp_printf_x>:
    {
    2e04:	ff010113          	addi	sp,sp,-16
    2e08:	00112623          	sw	ra,12(sp)
        for(i=0;i<8;i++)
    2e0c:	00000713          	li	a4,0
    2e10:	00700793          	li	a5,7
    2e14:	02e7c063          	blt	a5,a4,2e34 <bsp_printf_x+0x30>
            if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    2e18:	00271693          	slli	a3,a4,0x2
    2e1c:	ff000793          	li	a5,-16
    2e20:	00d797b3          	sll	a5,a5,a3
    2e24:	00f577b3          	and	a5,a0,a5
    2e28:	00078663          	beqz	a5,2e34 <bsp_printf_x+0x30>
        for(i=0;i<8;i++)
    2e2c:	00170713          	addi	a4,a4,1
    2e30:	fe1ff06f          	j	2e10 <bsp_printf_x+0xc>
        bsp_printHex_lower(val);
    2e34:	ec9ff0ef          	jal	ra,2cfc <bsp_printHex_lower>
    }
    2e38:	00c12083          	lw	ra,12(sp)
    2e3c:	01010113          	addi	sp,sp,16
    2e40:	00008067          	ret

00002e44 <bsp_printf_X>:
        {
    2e44:	ff010113          	addi	sp,sp,-16
    2e48:	00112623          	sw	ra,12(sp)
            for(i=0;i<8;i++)
    2e4c:	00000713          	li	a4,0
    2e50:	00700793          	li	a5,7
    2e54:	02e7c063          	blt	a5,a4,2e74 <bsp_printf_X+0x30>
                if((val & (0xFFFFFFF0 <<(4*i))) == 0)
    2e58:	00271693          	slli	a3,a4,0x2
    2e5c:	ff000793          	li	a5,-16
    2e60:	00d797b3          	sll	a5,a5,a3
    2e64:	00f577b3          	and	a5,a0,a5
    2e68:	00078663          	beqz	a5,2e74 <bsp_printf_X+0x30>
            for(i=0;i<8;i++)
    2e6c:	00170713          	addi	a4,a4,1
    2e70:	fe1ff06f          	j	2e50 <bsp_printf_X+0xc>
            bsp_printHex(val);
    2e74:	e35ff0ef          	jal	ra,2ca8 <bsp_printHex>
        }
    2e78:	00c12083          	lw	ra,12(sp)
    2e7c:	01010113          	addi	sp,sp,16
    2e80:	00008067          	ret

00002e84 <i2c_applyConfig>:
        write_u32(config->samplingClockDivider, reg + I2C_SAMPLING_CLOCK_DIVIDER);
    2e84:	0005a783          	lw	a5,0(a1)
        *((volatile u32*) address) = data;
    2e88:	02f52423          	sw	a5,40(a0) # f8010028 <__freertos_irq_stack_top+0xf7e07158>
        write_u32(config->timeout, reg + I2C_TIMEOUT);
    2e8c:	0045a783          	lw	a5,4(a1)
    2e90:	02f52623          	sw	a5,44(a0)
        write_u32(config->tsuDat, reg + I2C_TSUDAT);
    2e94:	0085a783          	lw	a5,8(a1)
    2e98:	02f52823          	sw	a5,48(a0)
        write_u32(config->tLow, reg + I2C_TLOW);
    2e9c:	00c5a783          	lw	a5,12(a1)
    2ea0:	04f52823          	sw	a5,80(a0)
        write_u32(config->tHigh, reg + I2C_THIGH);
    2ea4:	0105a783          	lw	a5,16(a1)
    2ea8:	04f52a23          	sw	a5,84(a0)
        write_u32(config->tBuf, reg + I2C_TBUF);
    2eac:	0145a783          	lw	a5,20(a1)
    2eb0:	04f52c23          	sw	a5,88(a0)
    }
    2eb4:	00008067          	ret

00002eb8 <reverse>:
     {
    2eb8:	ff010113          	addi	sp,sp,-16
    2ebc:	00112623          	sw	ra,12(sp)
    2ec0:	00812423          	sw	s0,8(sp)
    2ec4:	00050413          	mv	s0,a0
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    2ec8:	b80fe0ef          	jal	ra,1248 <strlen>
    2ecc:	fff50513          	addi	a0,a0,-1
    2ed0:	00000793          	li	a5,0
    2ed4:	02a7d463          	bge	a5,a0,2efc <reverse+0x44>
              c = s[i];
    2ed8:	00f406b3          	add	a3,s0,a5
    2edc:	0006c603          	lbu	a2,0(a3)
              s[i] = s[j];
    2ee0:	00a40733          	add	a4,s0,a0
    2ee4:	00074583          	lbu	a1,0(a4)
    2ee8:	00b68023          	sb	a1,0(a3)
              s[j] = c;
    2eec:	00c70023          	sb	a2,0(a4)
          for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    2ef0:	00178793          	addi	a5,a5,1
    2ef4:	fff50513          	addi	a0,a0,-1
    2ef8:	fddff06f          	j	2ed4 <reverse+0x1c>
     }
    2efc:	00c12083          	lw	ra,12(sp)
    2f00:	00812403          	lw	s0,8(sp)
    2f04:	01010113          	addi	sp,sp,16
    2f08:	00008067          	ret

00002f0c <itos>:
     {
    2f0c:	ff010113          	addi	sp,sp,-16
    2f10:	00112623          	sw	ra,12(sp)
         if ((sign = n) < 0)  /* record sign */
    2f14:	00054863          	bltz	a0,2f24 <itos+0x18>
    2f18:	00050613          	mv	a2,a0
    2f1c:	00000813          	li	a6,0
    2f20:	0140006f          	j	2f34 <itos+0x28>
             n = -n;          /* make n positive */
    2f24:	40a00633          	neg	a2,a0
    2f28:	ff5ff06f          	j	2f1c <itos+0x10>
             s[i++] = n % 10 + '0';   /* get next digit */
    2f2c:	00088813          	mv	a6,a7
         } while ((n /= 10) > 0);     /* delete it */
    2f30:	00078613          	mv	a2,a5
             s[i++] = n % 10 + '0';   /* get next digit */
    2f34:	00a00793          	li	a5,10
    2f38:	02f666b3          	rem	a3,a2,a5
    2f3c:	00180893          	addi	a7,a6,1
    2f40:	01058733          	add	a4,a1,a6
    2f44:	03068693          	addi	a3,a3,48
    2f48:	00d70023          	sb	a3,0(a4)
         } while ((n /= 10) > 0);     /* delete it */
    2f4c:	02f647b3          	div	a5,a2,a5
    2f50:	00900713          	li	a4,9
    2f54:	fcc74ce3          	blt	a4,a2,2f2c <itos+0x20>
         if (sign < 0)
    2f58:	02054063          	bltz	a0,2f78 <itos+0x6c>
         s[i] = '\0';
    2f5c:	011588b3          	add	a7,a1,a7
    2f60:	00088023          	sb	zero,0(a7)
         reverse(s);
    2f64:	00058513          	mv	a0,a1
    2f68:	f51ff0ef          	jal	ra,2eb8 <reverse>
    }
    2f6c:	00c12083          	lw	ra,12(sp)
    2f70:	01010113          	addi	sp,sp,16
    2f74:	00008067          	ret
             s[i++] = '-';
    2f78:	011588b3          	add	a7,a1,a7
    2f7c:	02d00793          	li	a5,45
    2f80:	00f88023          	sb	a5,0(a7)
    2f84:	00280893          	addi	a7,a6,2
    2f88:	fd5ff06f          	j	2f5c <itos+0x50>

00002f8c <ftoa>:
    {
    2f8c:	fe010113          	addi	sp,sp,-32
    2f90:	00112e23          	sw	ra,28(sp)
    2f94:	00812c23          	sw	s0,24(sp)
    2f98:	00912a23          	sw	s1,20(sp)
    2f9c:	01212823          	sw	s2,16(sp)
    2fa0:	01312623          	sw	s3,12(sp)
    2fa4:	01412423          	sw	s4,8(sp)
    2fa8:	00050913          	mv	s2,a0
    2fac:	00058993          	mv	s3,a1
    2fb0:	00060a13          	mv	s4,a2
    2fb4:	00068413          	mv	s0,a3
        int ipart = (int)n;
    2fb8:	690010ef          	jal	ra,4648 <__fixdfsi>
    2fbc:	00050493          	mv	s1,a0
        double fpart = n - (double)ipart;
    2fc0:	70c010ef          	jal	ra,46cc <__floatsidf>
    2fc4:	00050613          	mv	a2,a0
    2fc8:	00058693          	mv	a3,a1
    2fcc:	00090513          	mv	a0,s2
    2fd0:	00098593          	mv	a1,s3
    2fd4:	5f9000ef          	jal	ra,3dcc <__subdf3>
    2fd8:	00050913          	mv	s2,a0
    2fdc:	00058993          	mv	s3,a1
        itos(n, res1);
    2fe0:	000a0593          	mv	a1,s4
    2fe4:	00048513          	mv	a0,s1
    2fe8:	f25ff0ef          	jal	ra,2f0c <itos>
        *res2 = '.';
    2fec:	02e00793          	li	a5,46
    2ff0:	00f40023          	sb	a5,0(s0)
        res2++;
    2ff4:	00140a13          	addi	s4,s0,1
        fpart_f = (float)fpart * pow(10, afterpoint);
    2ff8:	00090513          	mv	a0,s2
    2ffc:	00098593          	mv	a1,s3
    3000:	289010ef          	jal	ra,4a88 <__truncdfsf2>
    3004:	185010ef          	jal	ra,4988 <__extendsfdf2>
    3008:	8181a603          	lw	a2,-2024(gp) # 8008 <_impure_ptr+0x4>
    300c:	81c1a683          	lw	a3,-2020(gp) # 800c <_impure_ptr+0x8>
    3010:	768000ef          	jal	ra,3778 <__muldf3>
    3014:	275010ef          	jal	ra,4a88 <__truncdfsf2>
    3018:	00050493          	mv	s1,a0
        if (fpart_f<0)
    301c:	00000593          	li	a1,0
    3020:	031010ef          	jal	ra,4850 <__lesf2>
    3024:	06054a63          	bltz	a0,3098 <ftoa+0x10c>
        for (int i=afterpoint; i>0; i--)
    3028:	00400413          	li	s0,4
    302c:	08805263          	blez	s0,30b0 <ftoa+0x124>
            if ((fpart_f<(1 * pow(10, i-1))) && (fpart_f>0))
    3030:	00048513          	mv	a0,s1
    3034:	155010ef          	jal	ra,4988 <__extendsfdf2>
    3038:	00050913          	mv	s2,a0
    303c:	00058993          	mv	s3,a1
    3040:	fff40413          	addi	s0,s0,-1
    3044:	00040513          	mv	a0,s0
    3048:	684010ef          	jal	ra,46cc <__floatsidf>
    304c:	00050613          	mv	a2,a0
    3050:	00058693          	mv	a3,a1
    3054:	8201a503          	lw	a0,-2016(gp) # 8010 <_impure_ptr+0xc>
    3058:	8241a583          	lw	a1,-2012(gp) # 8014 <_impure_ptr+0x10>
    305c:	4b5010ef          	jal	ra,4d10 <pow>
    3060:	00050613          	mv	a2,a0
    3064:	00058693          	mv	a3,a1
    3068:	00090513          	mv	a0,s2
    306c:	00098593          	mv	a1,s3
    3070:	608000ef          	jal	ra,3678 <__ledf2>
    3074:	fa055ce3          	bgez	a0,302c <ftoa+0xa0>
    3078:	00000593          	li	a1,0
    307c:	00048513          	mv	a0,s1
    3080:	70c010ef          	jal	ra,478c <__gesf2>
    3084:	faa054e3          	blez	a0,302c <ftoa+0xa0>
                *res2='0';
    3088:	03000793          	li	a5,48
    308c:	00fa0023          	sb	a5,0(s4)
                res2++;
    3090:	001a0a13          	addi	s4,s4,1
    3094:	f99ff06f          	j	302c <ftoa+0xa0>
            *res2 = '-';
    3098:	02d00793          	li	a5,45
    309c:	00f400a3          	sb	a5,1(s0)
            res2++;
    30a0:	00240a13          	addi	s4,s0,2
            fpart_f = -(fpart_f);
    30a4:	800007b7          	lui	a5,0x80000
    30a8:	0097c4b3          	xor	s1,a5,s1
    30ac:	f7dff06f          	j	3028 <ftoa+0x9c>
        itos((int)fpart_f, res2);
    30b0:	00048513          	mv	a0,s1
    30b4:	061010ef          	jal	ra,4914 <__fixsfsi>
    30b8:	000a0593          	mv	a1,s4
    30bc:	e51ff0ef          	jal	ra,2f0c <itos>
    }
    30c0:	01c12083          	lw	ra,28(sp)
    30c4:	01812403          	lw	s0,24(sp)
    30c8:	01412483          	lw	s1,20(sp)
    30cc:	01012903          	lw	s2,16(sp)
    30d0:	00c12983          	lw	s3,12(sp)
    30d4:	00812a03          	lw	s4,8(sp)
    30d8:	02010113          	addi	sp,sp,32
    30dc:	00008067          	ret

000030e0 <print_float>:
    {
    30e0:	fc010113          	addi	sp,sp,-64
    30e4:	02112e23          	sw	ra,60(sp)
    30e8:	02812c23          	sw	s0,56(sp)
        ftoa(val, sval, fval);
    30ec:	00c10693          	addi	a3,sp,12
    30f0:	01810613          	addi	a2,sp,24
    30f4:	e99ff0ef          	jal	ra,2f8c <ftoa>
        if (fval[1] == '-')
    30f8:	00d14703          	lbu	a4,13(sp)
    30fc:	02d00793          	li	a5,45
    3100:	06f70663          	beq	a4,a5,316c <print_float+0x8c>
        neg=0;
    3104:	00000413          	li	s0,0
        strcat(sval, fval);
    3108:	00c10593          	addi	a1,sp,12
    310c:	01810513          	addi	a0,sp,24
    3110:	898fe0ef          	jal	ra,11a8 <strcat>
        if ((sval[0] != '-') && (neg == 1))
    3114:	01814703          	lbu	a4,24(sp)
    3118:	02d00793          	li	a5,45
    311c:	00f70463          	beq	a4,a5,3124 <print_float+0x44>
    3120:	08041263          	bnez	s0,31a4 <print_float+0xc4>
        _putchar_s(sval);
    3124:	01810513          	addi	a0,sp,24
    3128:	b4dff0ef          	jal	ra,2c74 <_putchar_s>
    }
    312c:	03c12083          	lw	ra,60(sp)
    3130:	03812403          	lw	s0,56(sp)
    3134:	04010113          	addi	sp,sp,64
    3138:	00008067          	ret
                fval[i-1] = fval[i];
    313c:	fff78713          	addi	a4,a5,-1 # 7fffffff <__freertos_irq_stack_top+0x7fdf712f>
    3140:	03010693          	addi	a3,sp,48
    3144:	00f686b3          	add	a3,a3,a5
    3148:	fdc6c683          	lbu	a3,-36(a3)
    314c:	03010613          	addi	a2,sp,48
    3150:	00e60733          	add	a4,a2,a4
    3154:	fcd70e23          	sb	a3,-36(a4)
                i++;
    3158:	00178793          	addi	a5,a5,1
            while (i<10)
    315c:	00900713          	li	a4,9
    3160:	fcf75ee3          	bge	a4,a5,313c <print_float+0x5c>
            neg = 1;
    3164:	00100413          	li	s0,1
    3168:	fa1ff06f          	j	3108 <print_float+0x28>
        i=2;
    316c:	00200793          	li	a5,2
    3170:	fedff06f          	j	315c <print_float+0x7c>
                sval[j+1] = sval[j];
    3174:	00178713          	addi	a4,a5,1
    3178:	03010693          	addi	a3,sp,48
    317c:	00f686b3          	add	a3,a3,a5
    3180:	fe86c683          	lbu	a3,-24(a3)
    3184:	03010613          	addi	a2,sp,48
    3188:	00e60733          	add	a4,a2,a4
    318c:	fed70423          	sb	a3,-24(a4)
                j--;
    3190:	fff78793          	addi	a5,a5,-1
            while (j>=0)
    3194:	fe07d0e3          	bgez	a5,3174 <print_float+0x94>
            sval[0] = '-';
    3198:	02d00793          	li	a5,45
    319c:	00f10c23          	sb	a5,24(sp)
    31a0:	f85ff06f          	j	3124 <print_float+0x44>
        j=19;
    31a4:	01300793          	li	a5,19
    31a8:	fedff06f          	j	3194 <print_float+0xb4>

000031ac <bsp_printf>:
    {
    31ac:	fc010113          	addi	sp,sp,-64
    31b0:	00112e23          	sw	ra,28(sp)
    31b4:	00812c23          	sw	s0,24(sp)
    31b8:	00912a23          	sw	s1,20(sp)
    31bc:	00050493          	mv	s1,a0
    31c0:	02b12223          	sw	a1,36(sp)
    31c4:	02c12423          	sw	a2,40(sp)
    31c8:	02d12623          	sw	a3,44(sp)
    31cc:	02e12823          	sw	a4,48(sp)
    31d0:	02f12a23          	sw	a5,52(sp)
    31d4:	03012c23          	sw	a6,56(sp)
    31d8:	03112e23          	sw	a7,60(sp)
        va_start(ap, format);
    31dc:	02410793          	addi	a5,sp,36
    31e0:	00f12623          	sw	a5,12(sp)
        for (i = 0; format[i]; i++)
    31e4:	00000413          	li	s0,0
    31e8:	01c0006f          	j	3204 <bsp_printf+0x58>
                        bsp_printf_c(va_arg(ap,int));
    31ec:	00c12783          	lw	a5,12(sp)
    31f0:	00478713          	addi	a4,a5,4
    31f4:	00e12623          	sw	a4,12(sp)
    31f8:	0007a503          	lw	a0,0(a5)
    31fc:	b55ff0ef          	jal	ra,2d50 <bsp_printf_c>
        for (i = 0; format[i]; i++)
    3200:	00140413          	addi	s0,s0,1
    3204:	008487b3          	add	a5,s1,s0
    3208:	0007c503          	lbu	a0,0(a5)
    320c:	0c050c63          	beqz	a0,32e4 <bsp_printf+0x138>
            if (format[i] == '%') {
    3210:	02500793          	li	a5,37
    3214:	06f50663          	beq	a0,a5,3280 <bsp_printf+0xd4>
                bsp_printf_c(format[i]);
    3218:	b39ff0ef          	jal	ra,2d50 <bsp_printf_c>
    321c:	fe5ff06f          	j	3200 <bsp_printf+0x54>
                        bsp_printf_s(va_arg(ap,char*));
    3220:	00c12783          	lw	a5,12(sp)
    3224:	00478713          	addi	a4,a5,4
    3228:	00e12623          	sw	a4,12(sp)
    322c:	0007a503          	lw	a0,0(a5)
    3230:	b3dff0ef          	jal	ra,2d6c <bsp_printf_s>
                        break;
    3234:	fcdff06f          	j	3200 <bsp_printf+0x54>
                        bsp_printf_d(va_arg(ap,int));
    3238:	00c12783          	lw	a5,12(sp)
    323c:	00478713          	addi	a4,a5,4
    3240:	00e12623          	sw	a4,12(sp)
    3244:	0007a503          	lw	a0,0(a5)
    3248:	b3dff0ef          	jal	ra,2d84 <bsp_printf_d>
                        break;
    324c:	fb5ff06f          	j	3200 <bsp_printf+0x54>
                        bsp_printf_X(va_arg(ap,int));
    3250:	00c12783          	lw	a5,12(sp)
    3254:	00478713          	addi	a4,a5,4
    3258:	00e12623          	sw	a4,12(sp)
    325c:	0007a503          	lw	a0,0(a5)
    3260:	be5ff0ef          	jal	ra,2e44 <bsp_printf_X>
                        break;
    3264:	f9dff06f          	j	3200 <bsp_printf+0x54>
                        bsp_printf_x(va_arg(ap,int));
    3268:	00c12783          	lw	a5,12(sp)
    326c:	00478713          	addi	a4,a5,4
    3270:	00e12623          	sw	a4,12(sp)
    3274:	0007a503          	lw	a0,0(a5)
    3278:	b8dff0ef          	jal	ra,2e04 <bsp_printf_x>
                        break;
    327c:	f85ff06f          	j	3200 <bsp_printf+0x54>
                while (format[++i]) {
    3280:	00140413          	addi	s0,s0,1
    3284:	008487b3          	add	a5,s1,s0
    3288:	0007c783          	lbu	a5,0(a5)
    328c:	f6078ae3          	beqz	a5,3200 <bsp_printf+0x54>
                    if (format[i] == 'c') {
    3290:	06300713          	li	a4,99
    3294:	f4e78ce3          	beq	a5,a4,31ec <bsp_printf+0x40>
                    else if (format[i] == 's') {
    3298:	07300713          	li	a4,115
    329c:	f8e782e3          	beq	a5,a4,3220 <bsp_printf+0x74>
                    else if (format[i] == 'd') {
    32a0:	06400713          	li	a4,100
    32a4:	f8e78ae3          	beq	a5,a4,3238 <bsp_printf+0x8c>
                    else if (format[i] == 'X') {
    32a8:	05800713          	li	a4,88
    32ac:	fae782e3          	beq	a5,a4,3250 <bsp_printf+0xa4>
                    else if (format[i] == 'x') {
    32b0:	07800713          	li	a4,120
    32b4:	fae78ae3          	beq	a5,a4,3268 <bsp_printf+0xbc>
                    else if (format[i] == 'f') {
    32b8:	06600713          	li	a4,102
    32bc:	fce792e3          	bne	a5,a4,3280 <bsp_printf+0xd4>
                        print_float(va_arg(ap,double));
    32c0:	00c12783          	lw	a5,12(sp)
    32c4:	00778793          	addi	a5,a5,7
    32c8:	ff87f793          	andi	a5,a5,-8
    32cc:	00878713          	addi	a4,a5,8
    32d0:	00e12623          	sw	a4,12(sp)
    32d4:	0007a503          	lw	a0,0(a5)
    32d8:	0047a583          	lw	a1,4(a5)
    32dc:	e05ff0ef          	jal	ra,30e0 <print_float>
                        break;
    32e0:	f21ff06f          	j	3200 <bsp_printf+0x54>
    }
    32e4:	01c12083          	lw	ra,28(sp)
    32e8:	01812403          	lw	s0,24(sp)
    32ec:	01412483          	lw	s1,20(sp)
    32f0:	04010113          	addi	sp,sp,64
    32f4:	00008067          	ret

000032f8 <init_mem_content>:

#include "common.h"

void init_mem_content (volatile uint32_t mem_array [], int32_t num_words) {
    32f8:	ff010113          	addi	sp,sp,-16
    32fc:	00112623          	sw	ra,12(sp)
    3300:	00812423          	sw	s0,8(sp)
    3304:	00912223          	sw	s1,4(sp)
    3308:	00050493          	mv	s1,a0
    330c:	00058413          	mv	s0,a1
   uart_writeStr(BSP_UART_TERMINAL, "Initialize memory content..\n\r");
    3310:	000085b7          	lui	a1,0x8
    3314:	8ac58593          	addi	a1,a1,-1876 # 78ac <col+0x8c>
    3318:	f8010537          	lui	a0,0xf8010
    331c:	88dff0ef          	jal	ra,2ba8 <uart_writeStr>
   for(int i=0;i<num_words;i++) {
    3320:	00000793          	li	a5,0
    3324:	0087de63          	bge	a5,s0,3340 <init_mem_content+0x48>
      mem_array [i] = 0xffffffff;
    3328:	00279713          	slli	a4,a5,0x2
    332c:	00e48733          	add	a4,s1,a4
    3330:	fff00693          	li	a3,-1
    3334:	00d72023          	sw	a3,0(a4)
   for(int i=0;i<num_words;i++) {
    3338:	00178793          	addi	a5,a5,1
    333c:	fe9ff06f          	j	3324 <init_mem_content+0x2c>
   }
}
    3340:	00c12083          	lw	ra,12(sp)
    3344:	00812403          	lw	s0,8(sp)
    3348:	00412483          	lw	s1,4(sp)
    334c:	01010113          	addi	sp,sp,16
    3350:	00008067          	ret

00003354 <check_mem_content>:

void check_mem_content (volatile uint32_t mem_array [], int32_t num_words) {
    3354:	ff010113          	addi	sp,sp,-16
    3358:	00112623          	sw	ra,12(sp)
    335c:	00812423          	sw	s0,8(sp)
    3360:	00912223          	sw	s1,4(sp)
    3364:	01212023          	sw	s2,0(sp)
    3368:	00050913          	mv	s2,a0
    336c:	00058493          	mv	s1,a1
   uart_writeStr(BSP_UART_TERMINAL, "Check memory content..\n\r");
    3370:	000085b7          	lui	a1,0x8
    3374:	8cc58593          	addi	a1,a1,-1844 # 78cc <col+0xac>
    3378:	f8010537          	lui	a0,0xf8010
    337c:	82dff0ef          	jal	ra,2ba8 <uart_writeStr>
   for(int i=0;i<num_words;i++) {
    3380:	00000413          	li	s0,0
    3384:	02945a63          	bge	s0,s1,33b8 <check_mem_content+0x64>
      //print_hex(mem_array[i], 8);
	  bsp_printf("%x", mem_array[i]);
    3388:	00241793          	slli	a5,s0,0x2
    338c:	00f907b3          	add	a5,s2,a5
    3390:	0007a583          	lw	a1,0(a5)
    3394:	00008537          	lui	a0,0x8
    3398:	8e850513          	addi	a0,a0,-1816 # 78e8 <col+0xc8>
    339c:	e11ff0ef          	jal	ra,31ac <bsp_printf>
      uart_writeStr(BSP_UART_TERMINAL, "\r");
    33a0:	000085b7          	lui	a1,0x8
    33a4:	8c858593          	addi	a1,a1,-1848 # 78c8 <col+0xa8>
    33a8:	f8010537          	lui	a0,0xf8010
    33ac:	ffcff0ef          	jal	ra,2ba8 <uart_writeStr>
   for(int i=0;i<num_words;i++) {
    33b0:	00140413          	addi	s0,s0,1
    33b4:	fd1ff06f          	j	3384 <check_mem_content+0x30>
   }
}
    33b8:	00c12083          	lw	ra,12(sp)
    33bc:	00812403          	lw	s0,8(sp)
    33c0:	00412483          	lw	s1,4(sp)
    33c4:	00012903          	lw	s2,0(sp)
    33c8:	01010113          	addi	sp,sp,16
    33cc:	00008067          	ret

000033d0 <axi_slave_read32>:
        return *((volatile u32*) address);
    33d0:	00052503          	lw	a0,0(a0) # f8010000 <__freertos_irq_stack_top+0xf7e07130>

u32 axi_slave_read32(u32 address) {
   u32 data;
   data = read_u32(address);
   return data;
}
    33d4:	00008067          	ret

000033d8 <assert>:

void assert(int cond){
    if(!cond) {
    33d8:	00050463          	beqz	a0,33e0 <assert+0x8>
    33dc:	00008067          	ret
void assert(int cond){
    33e0:	ff010113          	addi	sp,sp,-16
    33e4:	00112623          	sw	ra,12(sp)
        uart_writeStr(BSP_UART_TERMINAL, "Assert failure\n");
    33e8:	000085b7          	lui	a1,0x8
    33ec:	8ec58593          	addi	a1,a1,-1812 # 78ec <col+0xcc>
    33f0:	f8010537          	lui	a0,0xf8010
    33f4:	fb4ff0ef          	jal	ra,2ba8 <uart_writeStr>
        while(1);
    33f8:	0000006f          	j	33f8 <assert+0x20>

000033fc <number_pow>:
u32 number_pow(u32 base ,u32 pow)
{
	u32 i=1;
	u32 out=1;

		 if(pow==0)return 1;
    33fc:	02058063          	beqz	a1,341c <number_pow+0x20>
	else if(pow==1)return base;
    3400:	00100793          	li	a5,1
    3404:	02f58263          	beq	a1,a5,3428 <number_pow+0x2c>
	u32 out=1;
    3408:	00100713          	li	a4,1
	else
	{
		while(i<=pow){
    340c:	00f5ea63          	bltu	a1,a5,3420 <number_pow+0x24>
			out=out*base;
    3410:	02a70733          	mul	a4,a4,a0
			i++;
    3414:	00178793          	addi	a5,a5,1
    3418:	ff5ff06f          	j	340c <number_pow+0x10>
		 if(pow==0)return 1;
    341c:	00100713          	li	a4,1
		}
		return out;
	}

	return 0;	//error
}
    3420:	00070513          	mv	a0,a4
    3424:	00008067          	ret
	else if(pow==1)return base;
    3428:	00050713          	mv	a4,a0
    342c:	ff5ff06f          	j	3420 <number_pow+0x24>

00003430 <UartGetChar>:

unsigned char UartGetChar(void)
{
    3430:	ff010113          	addi	sp,sp,-16
    3434:	00112623          	sw	ra,12(sp)
	unsigned char out;

	while(1)
	{
		while(uart_readOccupancy(BSP_UART_TERMINAL))
    3438:	f8010537          	lui	a0,0xf8010
    343c:	f24ff0ef          	jal	ra,2b60 <uart_readOccupancy>
    3440:	fe050ce3          	beqz	a0,3438 <UartGetChar+0x8>
		{
			out = uart_read(BSP_UART_TERMINAL);
    3444:	f8010537          	lui	a0,0xf8010
    3448:	fa4ff0ef          	jal	ra,2bec <uart_read>
			return out;
		}
	}
}
    344c:	00c12083          	lw	ra,12(sp)
    3450:	01010113          	addi	sp,sp,16
    3454:	00008067          	ret

00003458 <msDelay>:


void msDelay(u32 ms)
{
    3458:	ff010113          	addi	sp,sp,-16
    345c:	00112623          	sw	ra,12(sp)
	bsp_uDelay(ms*1000);
    3460:	f8b00637          	lui	a2,0xf8b00
    3464:	05f5e5b7          	lui	a1,0x5f5e
    3468:	10058593          	addi	a1,a1,256 # 5f5e100 <__freertos_irq_stack_top+0x5d55230>
    346c:	3e800793          	li	a5,1000
    3470:	02f50533          	mul	a0,a0,a5
    3474:	facff0ef          	jal	ra,2c20 <clint_uDelay>
}
    3478:	00c12083          	lw	ra,12(sp)
    347c:	01010113          	addi	sp,sp,16
    3480:	00008067          	ret

00003484 <UartGetDec>:

u32 UartGetDec(void)
{
    3484:	ff010113          	addi	sp,sp,-16
    3488:	00112623          	sw	ra,12(sp)
    348c:	00812423          	sw	s0,8(sp)
    3490:	00912223          	sw	s1,4(sp)
    3494:	01212023          	sw	s2,0(sp)
	unsigned char u=0;
	u32 num=0,total=0,total_num=0;
    3498:	00000493          	li	s1,0
    349c:	00000913          	li	s2,0
    34a0:	0200006f          	j	34c0 <UartGetDec+0x3c>
			{
				u = uart_read(BSP_UART_TERMINAL);

				uart_write(BSP_UART_TERMINAL, u);

					 if(u=='0')	num=0;
    34a4:	00000913          	li	s2,0
				else if(u=='6')	num=6;
				else if(u=='7')	num=7;
				else if(u=='8')	num=8;
				else if(u=='9')	num=9;

				if(u==0x0D)
    34a8:	00d00793          	li	a5,13
    34ac:	0cf40863          	beq	s0,a5,357c <UartGetDec+0xf8>
					total_num=total;
					return total;
				}
				else
				{
					total*=10;
    34b0:	00249793          	slli	a5,s1,0x2
    34b4:	009787b3          	add	a5,a5,s1
    34b8:	00179493          	slli	s1,a5,0x1
					total+=num;
    34bc:	009904b3          	add	s1,s2,s1
			while(uart_readOccupancy(BSP_UART_TERMINAL))
    34c0:	f8010537          	lui	a0,0xf8010
    34c4:	e9cff0ef          	jal	ra,2b60 <uart_readOccupancy>
    34c8:	fe050ce3          	beqz	a0,34c0 <UartGetDec+0x3c>
				u = uart_read(BSP_UART_TERMINAL);
    34cc:	f8010537          	lui	a0,0xf8010
    34d0:	f1cff0ef          	jal	ra,2bec <uart_read>
    34d4:	00050413          	mv	s0,a0
				uart_write(BSP_UART_TERMINAL, u);
    34d8:	00050593          	mv	a1,a0
    34dc:	f8010537          	lui	a0,0xf8010
    34e0:	e8cff0ef          	jal	ra,2b6c <uart_write>
					 if(u=='0')	num=0;
    34e4:	03000793          	li	a5,48
    34e8:	faf40ee3          	beq	s0,a5,34a4 <UartGetDec+0x20>
				else if(u=='1')	num=1;
    34ec:	03100793          	li	a5,49
    34f0:	04f40663          	beq	s0,a5,353c <UartGetDec+0xb8>
				else if(u=='2')	num=2;
    34f4:	03200793          	li	a5,50
    34f8:	04f40663          	beq	s0,a5,3544 <UartGetDec+0xc0>
				else if(u=='3')	num=3;
    34fc:	03300793          	li	a5,51
    3500:	04f40663          	beq	s0,a5,354c <UartGetDec+0xc8>
				else if(u=='4')	num=4;
    3504:	03400793          	li	a5,52
    3508:	04f40663          	beq	s0,a5,3554 <UartGetDec+0xd0>
				else if(u=='5')	num=5;
    350c:	03500793          	li	a5,53
    3510:	04f40663          	beq	s0,a5,355c <UartGetDec+0xd8>
				else if(u=='6')	num=6;
    3514:	03600793          	li	a5,54
    3518:	04f40663          	beq	s0,a5,3564 <UartGetDec+0xe0>
				else if(u=='7')	num=7;
    351c:	03700793          	li	a5,55
    3520:	04f40663          	beq	s0,a5,356c <UartGetDec+0xe8>
				else if(u=='8')	num=8;
    3524:	03800793          	li	a5,56
    3528:	04f40663          	beq	s0,a5,3574 <UartGetDec+0xf0>
				else if(u=='9')	num=9;
    352c:	03900793          	li	a5,57
    3530:	f6f41ce3          	bne	s0,a5,34a8 <UartGetDec+0x24>
    3534:	00900913          	li	s2,9
    3538:	f71ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='1')	num=1;
    353c:	00100913          	li	s2,1
    3540:	f69ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='2')	num=2;
    3544:	00200913          	li	s2,2
    3548:	f61ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='3')	num=3;
    354c:	00300913          	li	s2,3
    3550:	f59ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='4')	num=4;
    3554:	00400913          	li	s2,4
    3558:	f51ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='5')	num=5;
    355c:	00500913          	li	s2,5
    3560:	f49ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='6')	num=6;
    3564:	00600913          	li	s2,6
    3568:	f41ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='7')	num=7;
    356c:	00700913          	li	s2,7
    3570:	f39ff06f          	j	34a8 <UartGetDec+0x24>
				else if(u=='8')	num=8;
    3574:	00800913          	li	s2,8
    3578:	f31ff06f          	j	34a8 <UartGetDec+0x24>
				}
			}

		}
}
    357c:	00048513          	mv	a0,s1
    3580:	00c12083          	lw	ra,12(sp)
    3584:	00812403          	lw	s0,8(sp)
    3588:	00412483          	lw	s1,4(sp)
    358c:	00012903          	lw	s2,0(sp)
    3590:	01010113          	addi	sp,sp,16
    3594:	00008067          	ret

00003598 <mipi_i2c_init>:

void mipi_i2c_init(){
    3598:	fd010113          	addi	sp,sp,-48
    359c:	02112623          	sw	ra,44(sp)
    //I2C init
    I2c_Config i2c_mipi;
    i2c_mipi.samplingClockDivider = 3;
    35a0:	00300793          	li	a5,3
    35a4:	00f12423          	sw	a5,8(sp)
    i2c_mipi.timeout = I2C_CTRL_HZ/1000;
    35a8:	000187b7          	lui	a5,0x18
    35ac:	6a078793          	addi	a5,a5,1696 # 186a0 <_end+0xf7d0>
    35b0:	00f12623          	sw	a5,12(sp)
    i2c_mipi.tsuDat  = I2C_CTRL_HZ/2000000;
    35b4:	03200793          	li	a5,50
    35b8:	00f12823          	sw	a5,16(sp)

    i2c_mipi.tLow  = I2C_CTRL_HZ/800000;
    35bc:	07d00793          	li	a5,125
    35c0:	00f12a23          	sw	a5,20(sp)
    i2c_mipi.tHigh = I2C_CTRL_HZ/800000;
    35c4:	00f12c23          	sw	a5,24(sp)
    i2c_mipi.tBuf  = I2C_CTRL_HZ/400000;
    35c8:	0fa00793          	li	a5,250
    35cc:	00f12e23          	sw	a5,28(sp)

    i2c_applyConfig(I2C_CTRL_MIPI, &i2c_mipi);
    35d0:	00810593          	addi	a1,sp,8
    35d4:	f8015537          	lui	a0,0xf8015
    35d8:	8adff0ef          	jal	ra,2e84 <i2c_applyConfig>

}
    35dc:	02c12083          	lw	ra,44(sp)
    35e0:	03010113          	addi	sp,sp,48
    35e4:	00008067          	ret

000035e8 <trap_entry>:
.global  trap_entry
.align(2) //mtvec require 32 bits allignement
trap_entry:
  addi sp,sp, -16*4
    35e8:	fc010113          	addi	sp,sp,-64
  sw x1,   0*4(sp)
    35ec:	00112023          	sw	ra,0(sp)
  sw x5,   1*4(sp)
    35f0:	00512223          	sw	t0,4(sp)
  sw x6,   2*4(sp)
    35f4:	00612423          	sw	t1,8(sp)
  sw x7,   3*4(sp)
    35f8:	00712623          	sw	t2,12(sp)
  sw x10,  4*4(sp)
    35fc:	00a12823          	sw	a0,16(sp)
  sw x11,  5*4(sp)
    3600:	00b12a23          	sw	a1,20(sp)
  sw x12,  6*4(sp)
    3604:	00c12c23          	sw	a2,24(sp)
  sw x13,  7*4(sp)
    3608:	00d12e23          	sw	a3,28(sp)
  sw x14,  8*4(sp)
    360c:	02e12023          	sw	a4,32(sp)
  sw x15,  9*4(sp)
    3610:	02f12223          	sw	a5,36(sp)
  sw x16, 10*4(sp)
    3614:	03012423          	sw	a6,40(sp)
  sw x17, 11*4(sp)
    3618:	03112623          	sw	a7,44(sp)
  sw x28, 12*4(sp)
    361c:	03c12823          	sw	t3,48(sp)
  sw x29, 13*4(sp)
    3620:	03d12a23          	sw	t4,52(sp)
  sw x30, 14*4(sp)
    3624:	03e12c23          	sw	t5,56(sp)
  sw x31, 15*4(sp)
    3628:	03f12e23          	sw	t6,60(sp)
  call trap
    362c:	ea5fd0ef          	jal	ra,14d0 <trap>
  lw x1 ,  0*4(sp)
    3630:	00012083          	lw	ra,0(sp)
  lw x5,   1*4(sp)
    3634:	00412283          	lw	t0,4(sp)
  lw x6,   2*4(sp)
    3638:	00812303          	lw	t1,8(sp)
  lw x7,   3*4(sp)
    363c:	00c12383          	lw	t2,12(sp)
  lw x10,  4*4(sp)
    3640:	01012503          	lw	a0,16(sp)
  lw x11,  5*4(sp)
    3644:	01412583          	lw	a1,20(sp)
  lw x12,  6*4(sp)
    3648:	01812603          	lw	a2,24(sp)
  lw x13,  7*4(sp)
    364c:	01c12683          	lw	a3,28(sp)
  lw x14,  8*4(sp)
    3650:	02012703          	lw	a4,32(sp)
  lw x15,  9*4(sp)
    3654:	02412783          	lw	a5,36(sp)
  lw x16, 10*4(sp)
    3658:	02812803          	lw	a6,40(sp)
  lw x17, 11*4(sp)
    365c:	02c12883          	lw	a7,44(sp)
  lw x28, 12*4(sp)
    3660:	03012e03          	lw	t3,48(sp)
  lw x29, 13*4(sp)
    3664:	03412e83          	lw	t4,52(sp)
  lw x30, 14*4(sp)
    3668:	03812f03          	lw	t5,56(sp)
  lw x31, 15*4(sp)
    366c:	03c12f83          	lw	t6,60(sp)
  addi sp,sp, 16*4
    3670:	04010113          	addi	sp,sp,64
  mret
    3674:	30200073          	mret

00003678 <__ledf2>:
    3678:	0145d713          	srli	a4,a1,0x14
    367c:	001007b7          	lui	a5,0x100
    3680:	fff78793          	addi	a5,a5,-1 # fffff <_end+0xf712f>
    3684:	0146d813          	srli	a6,a3,0x14
    3688:	7ff77713          	andi	a4,a4,2047
    368c:	7ff00893          	li	a7,2047
    3690:	00b7f333          	and	t1,a5,a1
    3694:	00050e13          	mv	t3,a0
    3698:	00d7f7b3          	and	a5,a5,a3
    369c:	01f5d593          	srli	a1,a1,0x1f
    36a0:	00060e93          	mv	t4,a2
    36a4:	7ff87813          	andi	a6,a6,2047
    36a8:	01f6d693          	srli	a3,a3,0x1f
    36ac:	05170a63          	beq	a4,a7,3700 <__ledf2+0x88>
    36b0:	03180263          	beq	a6,a7,36d4 <__ledf2+0x5c>
    36b4:	04071c63          	bnez	a4,370c <__ledf2+0x94>
    36b8:	00a36533          	or	a0,t1,a0
    36bc:	02081663          	bnez	a6,36e8 <__ledf2+0x70>
    36c0:	00c7e633          	or	a2,a5,a2
    36c4:	02061263          	bnez	a2,36e8 <__ledf2+0x70>
    36c8:	00000693          	li	a3,0
    36cc:	06050263          	beqz	a0,3730 <__ledf2+0xb8>
    36d0:	0200006f          	j	36f0 <__ledf2+0x78>
    36d4:	00c7e8b3          	or	a7,a5,a2
    36d8:	fc088ee3          	beqz	a7,36b4 <__ledf2+0x3c>
    36dc:	00200693          	li	a3,2
    36e0:	00068513          	mv	a0,a3
    36e4:	00008067          	ret
    36e8:	04050263          	beqz	a0,372c <__ledf2+0xb4>
    36ec:	04d58e63          	beq	a1,a3,3748 <__ledf2+0xd0>
    36f0:	00100693          	li	a3,1
    36f4:	02058e63          	beqz	a1,3730 <__ledf2+0xb8>
    36f8:	fff00693          	li	a3,-1
    36fc:	0340006f          	j	3730 <__ledf2+0xb8>
    3700:	00a36533          	or	a0,t1,a0
    3704:	fc051ce3          	bnez	a0,36dc <__ledf2+0x64>
    3708:	02e80863          	beq	a6,a4,3738 <__ledf2+0xc0>
    370c:	00081663          	bnez	a6,3718 <__ledf2+0xa0>
    3710:	00c7e633          	or	a2,a5,a2
    3714:	fc060ee3          	beqz	a2,36f0 <__ledf2+0x78>
    3718:	fcd59ce3          	bne	a1,a3,36f0 <__ledf2+0x78>
    371c:	02e85663          	bge	a6,a4,3748 <__ledf2+0xd0>
    3720:	fc069ce3          	bnez	a3,36f8 <__ledf2+0x80>
    3724:	00100693          	li	a3,1
    3728:	0080006f          	j	3730 <__ledf2+0xb8>
    372c:	fc0686e3          	beqz	a3,36f8 <__ledf2+0x80>
    3730:	00068513          	mv	a0,a3
    3734:	00008067          	ret
    3738:	00c7e633          	or	a2,a5,a2
    373c:	fc060ee3          	beqz	a2,3718 <__ledf2+0xa0>
    3740:	00200693          	li	a3,2
    3744:	f9dff06f          	j	36e0 <__ledf2+0x68>
    3748:	01074a63          	blt	a4,a6,375c <__ledf2+0xe4>
    374c:	fa67e2e3          	bltu	a5,t1,36f0 <__ledf2+0x78>
    3750:	00f30c63          	beq	t1,a5,3768 <__ledf2+0xf0>
    3754:	00000693          	li	a3,0
    3758:	fcf37ce3          	bgeu	t1,a5,3730 <__ledf2+0xb8>
    375c:	f8058ee3          	beqz	a1,36f8 <__ledf2+0x80>
    3760:	00058693          	mv	a3,a1
    3764:	fcdff06f          	j	3730 <__ledf2+0xb8>
    3768:	f9cee4e3          	bltu	t4,t3,36f0 <__ledf2+0x78>
    376c:	00000693          	li	a3,0
    3770:	fdde70e3          	bgeu	t3,t4,3730 <__ledf2+0xb8>
    3774:	fe9ff06f          	j	375c <__ledf2+0xe4>

00003778 <__muldf3>:
    3778:	fc010113          	addi	sp,sp,-64
    377c:	0145d793          	srli	a5,a1,0x14
    3780:	02812c23          	sw	s0,56(sp)
    3784:	03212823          	sw	s2,48(sp)
    3788:	03412423          	sw	s4,40(sp)
    378c:	00c59413          	slli	s0,a1,0xc
    3790:	02112e23          	sw	ra,60(sp)
    3794:	02912a23          	sw	s1,52(sp)
    3798:	03312623          	sw	s3,44(sp)
    379c:	03512223          	sw	s5,36(sp)
    37a0:	03612023          	sw	s6,32(sp)
    37a4:	01712e23          	sw	s7,28(sp)
    37a8:	7ff7f793          	andi	a5,a5,2047
    37ac:	00050913          	mv	s2,a0
    37b0:	00c45413          	srli	s0,s0,0xc
    37b4:	01f5da13          	srli	s4,a1,0x1f
    37b8:	14078c63          	beqz	a5,3910 <__muldf3+0x198>
    37bc:	7ff00713          	li	a4,2047
    37c0:	20e78863          	beq	a5,a4,39d0 <__muldf3+0x258>
    37c4:	00341513          	slli	a0,s0,0x3
    37c8:	01d95413          	srli	s0,s2,0x1d
    37cc:	00a46433          	or	s0,s0,a0
    37d0:	00800537          	lui	a0,0x800
    37d4:	00a46433          	or	s0,s0,a0
    37d8:	00391493          	slli	s1,s2,0x3
    37dc:	c0178b13          	addi	s6,a5,-1023
    37e0:	00000993          	li	s3,0
    37e4:	00000b93          	li	s7,0
    37e8:	0146d793          	srli	a5,a3,0x14
    37ec:	00c69913          	slli	s2,a3,0xc
    37f0:	7ff7f793          	andi	a5,a5,2047
    37f4:	00c95913          	srli	s2,s2,0xc
    37f8:	01f6da93          	srli	s5,a3,0x1f
    37fc:	18078263          	beqz	a5,3980 <__muldf3+0x208>
    3800:	7ff00713          	li	a4,2047
    3804:	04e78c63          	beq	a5,a4,385c <__muldf3+0xe4>
    3808:	00391513          	slli	a0,s2,0x3
    380c:	01d65913          	srli	s2,a2,0x1d
    3810:	00a96933          	or	s2,s2,a0
    3814:	c0178793          	addi	a5,a5,-1023
    3818:	00800537          	lui	a0,0x800
    381c:	00a96933          	or	s2,s2,a0
    3820:	00361593          	slli	a1,a2,0x3
    3824:	00fb0b33          	add	s6,s6,a5
    3828:	00000813          	li	a6,0
    382c:	015a46b3          	xor	a3,s4,s5
    3830:	00f00793          	li	a5,15
    3834:	00068513          	mv	a0,a3
    3838:	001b0613          	addi	a2,s6,1
    383c:	2137ec63          	bltu	a5,s3,3a54 <__muldf3+0x2dc>
    3840:	00004797          	auipc	a5,0x4
    3844:	0bc78793          	addi	a5,a5,188 # 78fc <col+0xdc>
    3848:	00299993          	slli	s3,s3,0x2
    384c:	00f989b3          	add	s3,s3,a5
    3850:	0009a703          	lw	a4,0(s3)
    3854:	00f70733          	add	a4,a4,a5
    3858:	00070067          	jr	a4
    385c:	00c965b3          	or	a1,s2,a2
    3860:	7ffb0b13          	addi	s6,s6,2047
    3864:	1c059063          	bnez	a1,3a24 <__muldf3+0x2ac>
    3868:	0029e993          	ori	s3,s3,2
    386c:	00000913          	li	s2,0
    3870:	00200813          	li	a6,2
    3874:	fb9ff06f          	j	382c <__muldf3+0xb4>
    3878:	00000693          	li	a3,0
    387c:	7ff00793          	li	a5,2047
    3880:	00080437          	lui	s0,0x80
    3884:	00000493          	li	s1,0
    3888:	00c41413          	slli	s0,s0,0xc
    388c:	01479793          	slli	a5,a5,0x14
    3890:	00c45413          	srli	s0,s0,0xc
    3894:	01f69693          	slli	a3,a3,0x1f
    3898:	00f46433          	or	s0,s0,a5
    389c:	00d46433          	or	s0,s0,a3
    38a0:	00040593          	mv	a1,s0
    38a4:	03c12083          	lw	ra,60(sp)
    38a8:	03812403          	lw	s0,56(sp)
    38ac:	00048513          	mv	a0,s1
    38b0:	03012903          	lw	s2,48(sp)
    38b4:	03412483          	lw	s1,52(sp)
    38b8:	02c12983          	lw	s3,44(sp)
    38bc:	02812a03          	lw	s4,40(sp)
    38c0:	02412a83          	lw	s5,36(sp)
    38c4:	02012b03          	lw	s6,32(sp)
    38c8:	01c12b83          	lw	s7,28(sp)
    38cc:	04010113          	addi	sp,sp,64
    38d0:	00008067          	ret
    38d4:	000a8513          	mv	a0,s5
    38d8:	00090413          	mv	s0,s2
    38dc:	00058493          	mv	s1,a1
    38e0:	00080b93          	mv	s7,a6
    38e4:	00200793          	li	a5,2
    38e8:	14fb8c63          	beq	s7,a5,3a40 <__muldf3+0x2c8>
    38ec:	00300793          	li	a5,3
    38f0:	f8fb84e3          	beq	s7,a5,3878 <__muldf3+0x100>
    38f4:	00100793          	li	a5,1
    38f8:	00050693          	mv	a3,a0
    38fc:	4cfb9463          	bne	s7,a5,3dc4 <__muldf3+0x64c>
    3900:	00000793          	li	a5,0
    3904:	00000413          	li	s0,0
    3908:	00000493          	li	s1,0
    390c:	f7dff06f          	j	3888 <__muldf3+0x110>
    3910:	00a464b3          	or	s1,s0,a0
    3914:	0e048e63          	beqz	s1,3a10 <__muldf3+0x298>
    3918:	00d12623          	sw	a3,12(sp)
    391c:	00c12423          	sw	a2,8(sp)
    3920:	38040863          	beqz	s0,3cb0 <__muldf3+0x538>
    3924:	00040513          	mv	a0,s0
    3928:	354010ef          	jal	ra,4c7c <__clzsi2>
    392c:	00812603          	lw	a2,8(sp)
    3930:	00c12683          	lw	a3,12(sp)
    3934:	00050793          	mv	a5,a0
    3938:	ff550593          	addi	a1,a0,-11 # 7ffff5 <__freertos_irq_stack_top+0x5f7125>
    393c:	01d00713          	li	a4,29
    3940:	ff878493          	addi	s1,a5,-8
    3944:	40b70733          	sub	a4,a4,a1
    3948:	00941433          	sll	s0,s0,s1
    394c:	00e95733          	srl	a4,s2,a4
    3950:	00876433          	or	s0,a4,s0
    3954:	009914b3          	sll	s1,s2,s1
    3958:	c0d00b13          	li	s6,-1011
    395c:	40fb0b33          	sub	s6,s6,a5
    3960:	0146d793          	srli	a5,a3,0x14
    3964:	00c69913          	slli	s2,a3,0xc
    3968:	7ff7f793          	andi	a5,a5,2047
    396c:	00000993          	li	s3,0
    3970:	00000b93          	li	s7,0
    3974:	00c95913          	srli	s2,s2,0xc
    3978:	01f6da93          	srli	s5,a3,0x1f
    397c:	e80792e3          	bnez	a5,3800 <__muldf3+0x88>
    3980:	00c965b3          	or	a1,s2,a2
    3984:	06058463          	beqz	a1,39ec <__muldf3+0x274>
    3988:	2e090c63          	beqz	s2,3c80 <__muldf3+0x508>
    398c:	00090513          	mv	a0,s2
    3990:	00c12423          	sw	a2,8(sp)
    3994:	2e8010ef          	jal	ra,4c7c <__clzsi2>
    3998:	00812603          	lw	a2,8(sp)
    399c:	00050793          	mv	a5,a0
    39a0:	ff550693          	addi	a3,a0,-11
    39a4:	01d00713          	li	a4,29
    39a8:	ff878593          	addi	a1,a5,-8
    39ac:	40d70733          	sub	a4,a4,a3
    39b0:	00b91933          	sll	s2,s2,a1
    39b4:	00e65733          	srl	a4,a2,a4
    39b8:	01276933          	or	s2,a4,s2
    39bc:	00b615b3          	sll	a1,a2,a1
    39c0:	40fb07b3          	sub	a5,s6,a5
    39c4:	c0d78b13          	addi	s6,a5,-1011
    39c8:	00000813          	li	a6,0
    39cc:	e61ff06f          	j	382c <__muldf3+0xb4>
    39d0:	00a464b3          	or	s1,s0,a0
    39d4:	02049463          	bnez	s1,39fc <__muldf3+0x284>
    39d8:	00000413          	li	s0,0
    39dc:	00800993          	li	s3,8
    39e0:	7ff00b13          	li	s6,2047
    39e4:	00200b93          	li	s7,2
    39e8:	e01ff06f          	j	37e8 <__muldf3+0x70>
    39ec:	0019e993          	ori	s3,s3,1
    39f0:	00000913          	li	s2,0
    39f4:	00100813          	li	a6,1
    39f8:	e35ff06f          	j	382c <__muldf3+0xb4>
    39fc:	00050493          	mv	s1,a0
    3a00:	00c00993          	li	s3,12
    3a04:	7ff00b13          	li	s6,2047
    3a08:	00300b93          	li	s7,3
    3a0c:	dddff06f          	j	37e8 <__muldf3+0x70>
    3a10:	00000413          	li	s0,0
    3a14:	00400993          	li	s3,4
    3a18:	00000b13          	li	s6,0
    3a1c:	00100b93          	li	s7,1
    3a20:	dc9ff06f          	j	37e8 <__muldf3+0x70>
    3a24:	0039e993          	ori	s3,s3,3
    3a28:	00060593          	mv	a1,a2
    3a2c:	00300813          	li	a6,3
    3a30:	dfdff06f          	j	382c <__muldf3+0xb4>
    3a34:	00200793          	li	a5,2
    3a38:	000a0513          	mv	a0,s4
    3a3c:	eafb98e3          	bne	s7,a5,38ec <__muldf3+0x174>
    3a40:	00050693          	mv	a3,a0
    3a44:	7ff00793          	li	a5,2047
    3a48:	00000413          	li	s0,0
    3a4c:	00000493          	li	s1,0
    3a50:	e39ff06f          	j	3888 <__muldf3+0x110>
    3a54:	00010e37          	lui	t3,0x10
    3a58:	fffe0713          	addi	a4,t3,-1 # ffff <_end+0x712f>
    3a5c:	0104d793          	srli	a5,s1,0x10
    3a60:	0105d813          	srli	a6,a1,0x10
    3a64:	00e4f4b3          	and	s1,s1,a4
    3a68:	00e5f5b3          	and	a1,a1,a4
    3a6c:	02958733          	mul	a4,a1,s1
    3a70:	02b78333          	mul	t1,a5,a1
    3a74:	01075513          	srli	a0,a4,0x10
    3a78:	029808b3          	mul	a7,a6,s1
    3a7c:	006888b3          	add	a7,a7,t1
    3a80:	01150533          	add	a0,a0,a7
    3a84:	03078f33          	mul	t5,a5,a6
    3a88:	00657463          	bgeu	a0,t1,3a90 <__muldf3+0x318>
    3a8c:	01cf0f33          	add	t5,t5,t3
    3a90:	00010eb7          	lui	t4,0x10
    3a94:	fffe8893          	addi	a7,t4,-1 # ffff <_end+0x712f>
    3a98:	01095293          	srli	t0,s2,0x10
    3a9c:	01197933          	and	s2,s2,a7
    3aa0:	01157333          	and	t1,a0,a7
    3aa4:	01177733          	and	a4,a4,a7
    3aa8:	01031313          	slli	t1,t1,0x10
    3aac:	029908b3          	mul	a7,s2,s1
    3ab0:	00e30333          	add	t1,t1,a4
    3ab4:	01055513          	srli	a0,a0,0x10
    3ab8:	03278fb3          	mul	t6,a5,s2
    3abc:	0108de13          	srli	t3,a7,0x10
    3ac0:	029284b3          	mul	s1,t0,s1
    3ac4:	01f484b3          	add	s1,s1,t6
    3ac8:	009e04b3          	add	s1,t3,s1
    3acc:	02578733          	mul	a4,a5,t0
    3ad0:	01f4f463          	bgeu	s1,t6,3ad8 <__muldf3+0x360>
    3ad4:	01d70733          	add	a4,a4,t4
    3ad8:	000109b7          	lui	s3,0x10
    3adc:	fff98e13          	addi	t3,s3,-1 # ffff <_end+0x712f>
    3ae0:	01c477b3          	and	a5,s0,t3
    3ae4:	01c4feb3          	and	t4,s1,t3
    3ae8:	01045f93          	srli	t6,s0,0x10
    3aec:	0104d493          	srli	s1,s1,0x10
    3af0:	01c8f8b3          	and	a7,a7,t3
    3af4:	02f583b3          	mul	t2,a1,a5
    3af8:	00e48e33          	add	t3,s1,a4
    3afc:	010e9e93          	slli	t4,t4,0x10
    3b00:	011e8eb3          	add	t4,t4,a7
    3b04:	01d50533          	add	a0,a0,t4
    3b08:	02f80733          	mul	a4,a6,a5
    3b0c:	0103d893          	srli	a7,t2,0x10
    3b10:	02bf85b3          	mul	a1,t6,a1
    3b14:	00b70733          	add	a4,a4,a1
    3b18:	00e888b3          	add	a7,a7,a4
    3b1c:	03f80833          	mul	a6,a6,t6
    3b20:	00b8f463          	bgeu	a7,a1,3b28 <__muldf3+0x3b0>
    3b24:	01380833          	add	a6,a6,s3
    3b28:	00010737          	lui	a4,0x10
    3b2c:	fff70413          	addi	s0,a4,-1 # ffff <_end+0x712f>
    3b30:	0088f5b3          	and	a1,a7,s0
    3b34:	0108d893          	srli	a7,a7,0x10
    3b38:	010888b3          	add	a7,a7,a6
    3b3c:	0083f3b3          	and	t2,t2,s0
    3b40:	01059593          	slli	a1,a1,0x10
    3b44:	02f90833          	mul	a6,s2,a5
    3b48:	007585b3          	add	a1,a1,t2
    3b4c:	032f8933          	mul	s2,t6,s2
    3b50:	01085413          	srli	s0,a6,0x10
    3b54:	02f287b3          	mul	a5,t0,a5
    3b58:	012787b3          	add	a5,a5,s2
    3b5c:	00f407b3          	add	a5,s0,a5
    3b60:	03f28fb3          	mul	t6,t0,t6
    3b64:	0127f463          	bgeu	a5,s2,3b6c <__muldf3+0x3f4>
    3b68:	00ef8fb3          	add	t6,t6,a4
    3b6c:	000102b7          	lui	t0,0x10
    3b70:	fff28293          	addi	t0,t0,-1 # ffff <_end+0x712f>
    3b74:	0057f733          	and	a4,a5,t0
    3b78:	00587833          	and	a6,a6,t0
    3b7c:	01071713          	slli	a4,a4,0x10
    3b80:	01e50533          	add	a0,a0,t5
    3b84:	01070733          	add	a4,a4,a6
    3b88:	01d53eb3          	sltu	t4,a0,t4
    3b8c:	01c70733          	add	a4,a4,t3
    3b90:	00b50533          	add	a0,a0,a1
    3b94:	01d70433          	add	s0,a4,t4
    3b98:	00b535b3          	sltu	a1,a0,a1
    3b9c:	01140833          	add	a6,s0,a7
    3ba0:	00b80f33          	add	t5,a6,a1
    3ba4:	01c73733          	sltu	a4,a4,t3
    3ba8:	01d43433          	sltu	s0,s0,t4
    3bac:	00876433          	or	s0,a4,s0
    3bb0:	0107d793          	srli	a5,a5,0x10
    3bb4:	011838b3          	sltu	a7,a6,a7
    3bb8:	00bf35b3          	sltu	a1,t5,a1
    3bbc:	00f40433          	add	s0,s0,a5
    3bc0:	00b8e5b3          	or	a1,a7,a1
    3bc4:	00951493          	slli	s1,a0,0x9
    3bc8:	00b40433          	add	s0,s0,a1
    3bcc:	01f40433          	add	s0,s0,t6
    3bd0:	0064e4b3          	or	s1,s1,t1
    3bd4:	00941713          	slli	a4,s0,0x9
    3bd8:	009034b3          	snez	s1,s1
    3bdc:	017f5413          	srli	s0,t5,0x17
    3be0:	01755513          	srli	a0,a0,0x17
    3be4:	009f1793          	slli	a5,t5,0x9
    3be8:	00a4e4b3          	or	s1,s1,a0
    3bec:	00876433          	or	s0,a4,s0
    3bf0:	00f4e4b3          	or	s1,s1,a5
    3bf4:	00741793          	slli	a5,s0,0x7
    3bf8:	0207d063          	bgez	a5,3c18 <__muldf3+0x4a0>
    3bfc:	0014d793          	srli	a5,s1,0x1
    3c00:	0014f493          	andi	s1,s1,1
    3c04:	01f41713          	slli	a4,s0,0x1f
    3c08:	0097e4b3          	or	s1,a5,s1
    3c0c:	00e4e4b3          	or	s1,s1,a4
    3c10:	00145413          	srli	s0,s0,0x1
    3c14:	00060b13          	mv	s6,a2
    3c18:	3ffb0713          	addi	a4,s6,1023
    3c1c:	0ce05063          	blez	a4,3cdc <__muldf3+0x564>
    3c20:	0074f793          	andi	a5,s1,7
    3c24:	02078063          	beqz	a5,3c44 <__muldf3+0x4cc>
    3c28:	00f4f793          	andi	a5,s1,15
    3c2c:	00400613          	li	a2,4
    3c30:	00c78a63          	beq	a5,a2,3c44 <__muldf3+0x4cc>
    3c34:	00448793          	addi	a5,s1,4
    3c38:	0097b4b3          	sltu	s1,a5,s1
    3c3c:	00940433          	add	s0,s0,s1
    3c40:	00078493          	mv	s1,a5
    3c44:	00741793          	slli	a5,s0,0x7
    3c48:	0007da63          	bgez	a5,3c5c <__muldf3+0x4e4>
    3c4c:	ff0007b7          	lui	a5,0xff000
    3c50:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf712f>
    3c54:	00f47433          	and	s0,s0,a5
    3c58:	400b0713          	addi	a4,s6,1024
    3c5c:	7fe00793          	li	a5,2046
    3c60:	14e7ca63          	blt	a5,a4,3db4 <__muldf3+0x63c>
    3c64:	0034d793          	srli	a5,s1,0x3
    3c68:	01d41493          	slli	s1,s0,0x1d
    3c6c:	00941413          	slli	s0,s0,0x9
    3c70:	00f4e4b3          	or	s1,s1,a5
    3c74:	00c45413          	srli	s0,s0,0xc
    3c78:	7ff77793          	andi	a5,a4,2047
    3c7c:	c0dff06f          	j	3888 <__muldf3+0x110>
    3c80:	00060513          	mv	a0,a2
    3c84:	00c12423          	sw	a2,8(sp)
    3c88:	7f5000ef          	jal	ra,4c7c <__clzsi2>
    3c8c:	01550693          	addi	a3,a0,21
    3c90:	01c00713          	li	a4,28
    3c94:	02050793          	addi	a5,a0,32
    3c98:	00812603          	lw	a2,8(sp)
    3c9c:	d0d754e3          	bge	a4,a3,39a4 <__muldf3+0x22c>
    3ca0:	ff850513          	addi	a0,a0,-8
    3ca4:	00000593          	li	a1,0
    3ca8:	00a61933          	sll	s2,a2,a0
    3cac:	d15ff06f          	j	39c0 <__muldf3+0x248>
    3cb0:	7cd000ef          	jal	ra,4c7c <__clzsi2>
    3cb4:	01550593          	addi	a1,a0,21
    3cb8:	01c00713          	li	a4,28
    3cbc:	02050793          	addi	a5,a0,32
    3cc0:	00812603          	lw	a2,8(sp)
    3cc4:	00c12683          	lw	a3,12(sp)
    3cc8:	c6b75ae3          	bge	a4,a1,393c <__muldf3+0x1c4>
    3ccc:	ff850513          	addi	a0,a0,-8
    3cd0:	00000493          	li	s1,0
    3cd4:	00a91433          	sll	s0,s2,a0
    3cd8:	c81ff06f          	j	3958 <__muldf3+0x1e0>
    3cdc:	00100613          	li	a2,1
    3ce0:	40e60633          	sub	a2,a2,a4
    3ce4:	06071063          	bnez	a4,3d44 <__muldf3+0x5cc>
    3ce8:	41eb0793          	addi	a5,s6,1054
    3cec:	00f49733          	sll	a4,s1,a5
    3cf0:	00f417b3          	sll	a5,s0,a5
    3cf4:	00c4d4b3          	srl	s1,s1,a2
    3cf8:	0097e4b3          	or	s1,a5,s1
    3cfc:	00e03733          	snez	a4,a4
    3d00:	00e4e4b3          	or	s1,s1,a4
    3d04:	0074f793          	andi	a5,s1,7
    3d08:	00c45633          	srl	a2,s0,a2
    3d0c:	02078063          	beqz	a5,3d2c <__muldf3+0x5b4>
    3d10:	00f4f793          	andi	a5,s1,15
    3d14:	00400713          	li	a4,4
    3d18:	00e78a63          	beq	a5,a4,3d2c <__muldf3+0x5b4>
    3d1c:	00448793          	addi	a5,s1,4
    3d20:	0097b4b3          	sltu	s1,a5,s1
    3d24:	00960633          	add	a2,a2,s1
    3d28:	00078493          	mv	s1,a5
    3d2c:	00861793          	slli	a5,a2,0x8
    3d30:	0607d463          	bgez	a5,3d98 <__muldf3+0x620>
    3d34:	00100793          	li	a5,1
    3d38:	00000413          	li	s0,0
    3d3c:	00000493          	li	s1,0
    3d40:	b49ff06f          	j	3888 <__muldf3+0x110>
    3d44:	03800793          	li	a5,56
    3d48:	bac7cce3          	blt	a5,a2,3900 <__muldf3+0x188>
    3d4c:	01f00793          	li	a5,31
    3d50:	f8c7dce3          	bge	a5,a2,3ce8 <__muldf3+0x570>
    3d54:	fe100793          	li	a5,-31
    3d58:	40e78733          	sub	a4,a5,a4
    3d5c:	02000793          	li	a5,32
    3d60:	00e45733          	srl	a4,s0,a4
    3d64:	00f60863          	beq	a2,a5,3d74 <__muldf3+0x5fc>
    3d68:	43eb0793          	addi	a5,s6,1086
    3d6c:	00f417b3          	sll	a5,s0,a5
    3d70:	00f4e4b3          	or	s1,s1,a5
    3d74:	009034b3          	snez	s1,s1
    3d78:	00e4e4b3          	or	s1,s1,a4
    3d7c:	0074f613          	andi	a2,s1,7
    3d80:	00000413          	li	s0,0
    3d84:	02060063          	beqz	a2,3da4 <__muldf3+0x62c>
    3d88:	00f4f793          	andi	a5,s1,15
    3d8c:	00400713          	li	a4,4
    3d90:	00000613          	li	a2,0
    3d94:	f8e794e3          	bne	a5,a4,3d1c <__muldf3+0x5a4>
    3d98:	00961413          	slli	s0,a2,0x9
    3d9c:	00c45413          	srli	s0,s0,0xc
    3da0:	01d61613          	slli	a2,a2,0x1d
    3da4:	0034d493          	srli	s1,s1,0x3
    3da8:	00c4e4b3          	or	s1,s1,a2
    3dac:	00000793          	li	a5,0
    3db0:	ad9ff06f          	j	3888 <__muldf3+0x110>
    3db4:	7ff00793          	li	a5,2047
    3db8:	00000413          	li	s0,0
    3dbc:	00000493          	li	s1,0
    3dc0:	ac9ff06f          	j	3888 <__muldf3+0x110>
    3dc4:	00060b13          	mv	s6,a2
    3dc8:	e51ff06f          	j	3c18 <__muldf3+0x4a0>

00003dcc <__subdf3>:
    3dcc:	00100737          	lui	a4,0x100
    3dd0:	fff70713          	addi	a4,a4,-1 # fffff <_end+0xf712f>
    3dd4:	fe010113          	addi	sp,sp,-32
    3dd8:	00b77333          	and	t1,a4,a1
    3ddc:	0146d893          	srli	a7,a3,0x14
    3de0:	00d77733          	and	a4,a4,a3
    3de4:	01d65e93          	srli	t4,a2,0x1d
    3de8:	00812c23          	sw	s0,24(sp)
    3dec:	00912a23          	sw	s1,20(sp)
    3df0:	00331313          	slli	t1,t1,0x3
    3df4:	0145d493          	srli	s1,a1,0x14
    3df8:	01d55793          	srli	a5,a0,0x1d
    3dfc:	00371713          	slli	a4,a4,0x3
    3e00:	00112e23          	sw	ra,28(sp)
    3e04:	01212823          	sw	s2,16(sp)
    3e08:	01312623          	sw	s3,12(sp)
    3e0c:	7ff8f893          	andi	a7,a7,2047
    3e10:	7ff00e13          	li	t3,2047
    3e14:	00eee733          	or	a4,t4,a4
    3e18:	7ff4f493          	andi	s1,s1,2047
    3e1c:	01f5d413          	srli	s0,a1,0x1f
    3e20:	0067e333          	or	t1,a5,t1
    3e24:	00351f13          	slli	t5,a0,0x3
    3e28:	01f6d693          	srli	a3,a3,0x1f
    3e2c:	00361e93          	slli	t4,a2,0x3
    3e30:	1dc88663          	beq	a7,t3,3ffc <__subdf3+0x230>
    3e34:	0016c693          	xori	a3,a3,1
    3e38:	411485b3          	sub	a1,s1,a7
    3e3c:	16d40863          	beq	s0,a3,3fac <__subdf3+0x1e0>
    3e40:	1cb05863          	blez	a1,4010 <__subdf3+0x244>
    3e44:	20088463          	beqz	a7,404c <__subdf3+0x280>
    3e48:	008007b7          	lui	a5,0x800
    3e4c:	00f76733          	or	a4,a4,a5
    3e50:	67c48a63          	beq	s1,t3,44c4 <__subdf3+0x6f8>
    3e54:	03800793          	li	a5,56
    3e58:	3eb7c263          	blt	a5,a1,423c <__subdf3+0x470>
    3e5c:	01f00793          	li	a5,31
    3e60:	54b7ca63          	blt	a5,a1,43b4 <__subdf3+0x5e8>
    3e64:	02000793          	li	a5,32
    3e68:	40b787b3          	sub	a5,a5,a1
    3e6c:	00bed9b3          	srl	s3,t4,a1
    3e70:	00f71833          	sll	a6,a4,a5
    3e74:	00fe9eb3          	sll	t4,t4,a5
    3e78:	01386833          	or	a6,a6,s3
    3e7c:	00b75733          	srl	a4,a4,a1
    3e80:	01d039b3          	snez	s3,t4
    3e84:	01386833          	or	a6,a6,s3
    3e88:	40e30333          	sub	t1,t1,a4
    3e8c:	410f09b3          	sub	s3,t5,a6
    3e90:	013f37b3          	sltu	a5,t5,s3
    3e94:	40f30633          	sub	a2,t1,a5
    3e98:	00861793          	slli	a5,a2,0x8
    3e9c:	2a07d863          	bgez	a5,414c <__subdf3+0x380>
    3ea0:	00800937          	lui	s2,0x800
    3ea4:	fff90913          	addi	s2,s2,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    3ea8:	01267933          	and	s2,a2,s2
    3eac:	36090663          	beqz	s2,4218 <__subdf3+0x44c>
    3eb0:	00090513          	mv	a0,s2
    3eb4:	5c9000ef          	jal	ra,4c7c <__clzsi2>
    3eb8:	ff850713          	addi	a4,a0,-8
    3ebc:	02000793          	li	a5,32
    3ec0:	40e787b3          	sub	a5,a5,a4
    3ec4:	00f9d7b3          	srl	a5,s3,a5
    3ec8:	00e91633          	sll	a2,s2,a4
    3ecc:	00c7e7b3          	or	a5,a5,a2
    3ed0:	00e999b3          	sll	s3,s3,a4
    3ed4:	32974463          	blt	a4,s1,41fc <__subdf3+0x430>
    3ed8:	40970733          	sub	a4,a4,s1
    3edc:	00170613          	addi	a2,a4,1
    3ee0:	01f00693          	li	a3,31
    3ee4:	44c6ca63          	blt	a3,a2,4338 <__subdf3+0x56c>
    3ee8:	02000713          	li	a4,32
    3eec:	40c70733          	sub	a4,a4,a2
    3ef0:	00c9d6b3          	srl	a3,s3,a2
    3ef4:	00e99833          	sll	a6,s3,a4
    3ef8:	00e79733          	sll	a4,a5,a4
    3efc:	00d76733          	or	a4,a4,a3
    3f00:	01003833          	snez	a6,a6
    3f04:	010769b3          	or	s3,a4,a6
    3f08:	00c7d633          	srl	a2,a5,a2
    3f0c:	00000493          	li	s1,0
    3f10:	0079f793          	andi	a5,s3,7
    3f14:	02078063          	beqz	a5,3f34 <__subdf3+0x168>
    3f18:	00f9f693          	andi	a3,s3,15
    3f1c:	00400793          	li	a5,4
    3f20:	00f68a63          	beq	a3,a5,3f34 <__subdf3+0x168>
    3f24:	00498693          	addi	a3,s3,4
    3f28:	0136b833          	sltu	a6,a3,s3
    3f2c:	01060633          	add	a2,a2,a6
    3f30:	00068993          	mv	s3,a3
    3f34:	00861793          	slli	a5,a2,0x8
    3f38:	2007de63          	bgez	a5,4154 <__subdf3+0x388>
    3f3c:	00148713          	addi	a4,s1,1
    3f40:	7ff00793          	li	a5,2047
    3f44:	00147413          	andi	s0,s0,1
    3f48:	26f70463          	beq	a4,a5,41b0 <__subdf3+0x3e4>
    3f4c:	ff8007b7          	lui	a5,0xff800
    3f50:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    3f54:	00f677b3          	and	a5,a2,a5
    3f58:	01d79813          	slli	a6,a5,0x1d
    3f5c:	0039d993          	srli	s3,s3,0x3
    3f60:	00979793          	slli	a5,a5,0x9
    3f64:	01386833          	or	a6,a6,s3
    3f68:	00c7d793          	srli	a5,a5,0xc
    3f6c:	7ff77713          	andi	a4,a4,2047
    3f70:	00c79693          	slli	a3,a5,0xc
    3f74:	01471713          	slli	a4,a4,0x14
    3f78:	00c6d693          	srli	a3,a3,0xc
    3f7c:	01f41413          	slli	s0,s0,0x1f
    3f80:	00e6e6b3          	or	a3,a3,a4
    3f84:	0086e6b3          	or	a3,a3,s0
    3f88:	01c12083          	lw	ra,28(sp)
    3f8c:	01812403          	lw	s0,24(sp)
    3f90:	01412483          	lw	s1,20(sp)
    3f94:	01012903          	lw	s2,16(sp)
    3f98:	00c12983          	lw	s3,12(sp)
    3f9c:	00080513          	mv	a0,a6
    3fa0:	00068593          	mv	a1,a3
    3fa4:	02010113          	addi	sp,sp,32
    3fa8:	00008067          	ret
    3fac:	0ab05e63          	blez	a1,4068 <__subdf3+0x29c>
    3fb0:	14088a63          	beqz	a7,4104 <__subdf3+0x338>
    3fb4:	008007b7          	lui	a5,0x800
    3fb8:	00f76733          	or	a4,a4,a5
    3fbc:	33c48c63          	beq	s1,t3,42f4 <__subdf3+0x528>
    3fc0:	03800793          	li	a5,56
    3fc4:	1cb7c063          	blt	a5,a1,4184 <__subdf3+0x3b8>
    3fc8:	01f00793          	li	a5,31
    3fcc:	44b7da63          	bge	a5,a1,4420 <__subdf3+0x654>
    3fd0:	fe058813          	addi	a6,a1,-32
    3fd4:	02000793          	li	a5,32
    3fd8:	010759b3          	srl	s3,a4,a6
    3fdc:	00f58a63          	beq	a1,a5,3ff0 <__subdf3+0x224>
    3fe0:	04000793          	li	a5,64
    3fe4:	40b785b3          	sub	a1,a5,a1
    3fe8:	00b71733          	sll	a4,a4,a1
    3fec:	00eeeeb3          	or	t4,t4,a4
    3ff0:	01d03833          	snez	a6,t4
    3ff4:	01386833          	or	a6,a6,s3
    3ff8:	1940006f          	j	418c <__subdf3+0x3c0>
    3ffc:	01d767b3          	or	a5,a4,t4
    4000:	80148593          	addi	a1,s1,-2047
    4004:	00079463          	bnez	a5,400c <__subdf3+0x240>
    4008:	0016c693          	xori	a3,a3,1
    400c:	04d40e63          	beq	s0,a3,4068 <__subdf3+0x29c>
    4010:	08059a63          	bnez	a1,40a4 <__subdf3+0x2d8>
    4014:	00148793          	addi	a5,s1,1
    4018:	7fe7f793          	andi	a5,a5,2046
    401c:	24079263          	bnez	a5,4260 <__subdf3+0x494>
    4020:	01e367b3          	or	a5,t1,t5
    4024:	01d76833          	or	a6,a4,t4
    4028:	18049c63          	bnez	s1,41c0 <__subdf3+0x3f4>
    402c:	46078063          	beqz	a5,448c <__subdf3+0x6c0>
    4030:	4c081e63          	bnez	a6,450c <__subdf3+0x740>
    4034:	00351813          	slli	a6,a0,0x3
    4038:	01d31693          	slli	a3,t1,0x1d
    403c:	00385813          	srli	a6,a6,0x3
    4040:	0106e833          	or	a6,a3,a6
    4044:	00335793          	srli	a5,t1,0x3
    4048:	1280006f          	j	4170 <__subdf3+0x3a4>
    404c:	01d767b3          	or	a5,a4,t4
    4050:	1e078c63          	beqz	a5,4248 <__subdf3+0x47c>
    4054:	fff58793          	addi	a5,a1,-1
    4058:	44078a63          	beqz	a5,44ac <__subdf3+0x6e0>
    405c:	29c58c63          	beq	a1,t3,42f4 <__subdf3+0x528>
    4060:	00078593          	mv	a1,a5
    4064:	df1ff06f          	j	3e54 <__subdf3+0x88>
    4068:	22059263          	bnez	a1,428c <__subdf3+0x4c0>
    406c:	00148693          	addi	a3,s1,1
    4070:	7fe6f793          	andi	a5,a3,2046
    4074:	0a079663          	bnez	a5,4120 <__subdf3+0x354>
    4078:	01e367b3          	or	a5,t1,t5
    407c:	3e049663          	bnez	s1,4468 <__subdf3+0x69c>
    4080:	50078863          	beqz	a5,4590 <__subdf3+0x7c4>
    4084:	01d767b3          	or	a5,a4,t4
    4088:	52079063          	bnez	a5,45a8 <__subdf3+0x7dc>
    408c:	00351513          	slli	a0,a0,0x3
    4090:	01d31813          	slli	a6,t1,0x1d
    4094:	00355513          	srli	a0,a0,0x3
    4098:	00a86833          	or	a6,a6,a0
    409c:	00335793          	srli	a5,t1,0x3
    40a0:	0d00006f          	j	4170 <__subdf3+0x3a4>
    40a4:	409885b3          	sub	a1,a7,s1
    40a8:	26049263          	bnez	s1,430c <__subdf3+0x540>
    40ac:	01e367b3          	or	a5,t1,t5
    40b0:	38078e63          	beqz	a5,444c <__subdf3+0x680>
    40b4:	fff58793          	addi	a5,a1,-1
    40b8:	4a078e63          	beqz	a5,4574 <__subdf3+0x7a8>
    40bc:	7ff00513          	li	a0,2047
    40c0:	24a58e63          	beq	a1,a0,431c <__subdf3+0x550>
    40c4:	00078593          	mv	a1,a5
    40c8:	03800793          	li	a5,56
    40cc:	30b7ca63          	blt	a5,a1,43e0 <__subdf3+0x614>
    40d0:	01f00793          	li	a5,31
    40d4:	46b7ca63          	blt	a5,a1,4548 <__subdf3+0x77c>
    40d8:	02000793          	li	a5,32
    40dc:	40b787b3          	sub	a5,a5,a1
    40e0:	00f31833          	sll	a6,t1,a5
    40e4:	00bf5633          	srl	a2,t5,a1
    40e8:	00ff17b3          	sll	a5,t5,a5
    40ec:	00c86833          	or	a6,a6,a2
    40f0:	00f039b3          	snez	s3,a5
    40f4:	00b35333          	srl	t1,t1,a1
    40f8:	01386833          	or	a6,a6,s3
    40fc:	40670733          	sub	a4,a4,t1
    4100:	2e80006f          	j	43e8 <__subdf3+0x61c>
    4104:	01d767b3          	or	a5,a4,t4
    4108:	14078063          	beqz	a5,4248 <__subdf3+0x47c>
    410c:	fff58793          	addi	a5,a1,-1
    4110:	24078e63          	beqz	a5,436c <__subdf3+0x5a0>
    4114:	37c58063          	beq	a1,t3,4474 <__subdf3+0x6a8>
    4118:	00078593          	mv	a1,a5
    411c:	ea5ff06f          	j	3fc0 <__subdf3+0x1f4>
    4120:	7ff00793          	li	a5,2047
    4124:	08f68463          	beq	a3,a5,41ac <__subdf3+0x3e0>
    4128:	01df0eb3          	add	t4,t5,t4
    412c:	01eeb633          	sltu	a2,t4,t5
    4130:	00e307b3          	add	a5,t1,a4
    4134:	00c787b3          	add	a5,a5,a2
    4138:	01f79813          	slli	a6,a5,0x1f
    413c:	001ede93          	srli	t4,t4,0x1
    4140:	01d869b3          	or	s3,a6,t4
    4144:	0017d613          	srli	a2,a5,0x1
    4148:	00068493          	mv	s1,a3
    414c:	0079f793          	andi	a5,s3,7
    4150:	dc0794e3          	bnez	a5,3f18 <__subdf3+0x14c>
    4154:	01d61793          	slli	a5,a2,0x1d
    4158:	0039d813          	srli	a6,s3,0x3
    415c:	00f86833          	or	a6,a6,a5
    4160:	00048593          	mv	a1,s1
    4164:	00365793          	srli	a5,a2,0x3
    4168:	7ff00713          	li	a4,2047
    416c:	06e58a63          	beq	a1,a4,41e0 <__subdf3+0x414>
    4170:	00c79793          	slli	a5,a5,0xc
    4174:	00c7d793          	srli	a5,a5,0xc
    4178:	7ff5f713          	andi	a4,a1,2047
    417c:	00147413          	andi	s0,s0,1
    4180:	df1ff06f          	j	3f70 <__subdf3+0x1a4>
    4184:	01d76733          	or	a4,a4,t4
    4188:	00e03833          	snez	a6,a4
    418c:	01e809b3          	add	s3,a6,t5
    4190:	01e9b7b3          	sltu	a5,s3,t5
    4194:	00678633          	add	a2,a5,t1
    4198:	00861793          	slli	a5,a2,0x8
    419c:	fa07d8e3          	bgez	a5,414c <__subdf3+0x380>
    41a0:	00148493          	addi	s1,s1,1
    41a4:	7ff00793          	li	a5,2047
    41a8:	1ef49263          	bne	s1,a5,438c <__subdf3+0x5c0>
    41ac:	00147413          	andi	s0,s0,1
    41b0:	7ff00713          	li	a4,2047
    41b4:	00000793          	li	a5,0
    41b8:	00000813          	li	a6,0
    41bc:	db5ff06f          	j	3f70 <__subdf3+0x1a4>
    41c0:	12079863          	bnez	a5,42f0 <__subdf3+0x524>
    41c4:	46080063          	beqz	a6,4624 <__subdf3+0x858>
    41c8:	00361813          	slli	a6,a2,0x3
    41cc:	01d71793          	slli	a5,a4,0x1d
    41d0:	00385813          	srli	a6,a6,0x3
    41d4:	00f86833          	or	a6,a6,a5
    41d8:	00068413          	mv	s0,a3
    41dc:	00375793          	srli	a5,a4,0x3
    41e0:	00f867b3          	or	a5,a6,a5
    41e4:	fc0784e3          	beqz	a5,41ac <__subdf3+0x3e0>
    41e8:	00000413          	li	s0,0
    41ec:	7ff00713          	li	a4,2047
    41f0:	000807b7          	lui	a5,0x80
    41f4:	00000813          	li	a6,0
    41f8:	d79ff06f          	j	3f70 <__subdf3+0x1a4>
    41fc:	ff800637          	lui	a2,0xff800
    4200:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    4204:	00c7f633          	and	a2,a5,a2
    4208:	0079f793          	andi	a5,s3,7
    420c:	40e484b3          	sub	s1,s1,a4
    4210:	d00794e3          	bnez	a5,3f18 <__subdf3+0x14c>
    4214:	f41ff06f          	j	4154 <__subdf3+0x388>
    4218:	00098513          	mv	a0,s3
    421c:	261000ef          	jal	ra,4c7c <__clzsi2>
    4220:	01850713          	addi	a4,a0,24
    4224:	01f00793          	li	a5,31
    4228:	c8e7dae3          	bge	a5,a4,3ebc <__subdf3+0xf0>
    422c:	ff850613          	addi	a2,a0,-8
    4230:	00c997b3          	sll	a5,s3,a2
    4234:	00000993          	li	s3,0
    4238:	c9dff06f          	j	3ed4 <__subdf3+0x108>
    423c:	01d76833          	or	a6,a4,t4
    4240:	01003833          	snez	a6,a6
    4244:	c49ff06f          	j	3e8c <__subdf3+0xc0>
    4248:	00351813          	slli	a6,a0,0x3
    424c:	01d31793          	slli	a5,t1,0x1d
    4250:	00385813          	srli	a6,a6,0x3
    4254:	00f86833          	or	a6,a6,a5
    4258:	00335793          	srli	a5,t1,0x3
    425c:	f0dff06f          	j	4168 <__subdf3+0x39c>
    4260:	41df09b3          	sub	s3,t5,t4
    4264:	40e30933          	sub	s2,t1,a4
    4268:	013f3633          	sltu	a2,t5,s3
    426c:	40c90933          	sub	s2,s2,a2
    4270:	00891793          	slli	a5,s2,0x8
    4274:	2607c463          	bltz	a5,44dc <__subdf3+0x710>
    4278:	0129e833          	or	a6,s3,s2
    427c:	c20818e3          	bnez	a6,3eac <__subdf3+0xe0>
    4280:	00000793          	li	a5,0
    4284:	00000413          	li	s0,0
    4288:	ee9ff06f          	j	4170 <__subdf3+0x3a4>
    428c:	409885b3          	sub	a1,a7,s1
    4290:	16048863          	beqz	s1,4400 <__subdf3+0x634>
    4294:	008006b7          	lui	a3,0x800
    4298:	7ff00793          	li	a5,2047
    429c:	00d36333          	or	t1,t1,a3
    42a0:	24f88a63          	beq	a7,a5,44f4 <__subdf3+0x728>
    42a4:	03800793          	li	a5,56
    42a8:	28b7ca63          	blt	a5,a1,453c <__subdf3+0x770>
    42ac:	01f00793          	li	a5,31
    42b0:	34b7c463          	blt	a5,a1,45f8 <__subdf3+0x82c>
    42b4:	02000793          	li	a5,32
    42b8:	40b787b3          	sub	a5,a5,a1
    42bc:	00f31833          	sll	a6,t1,a5
    42c0:	00bf56b3          	srl	a3,t5,a1
    42c4:	00ff17b3          	sll	a5,t5,a5
    42c8:	00d86833          	or	a6,a6,a3
    42cc:	00f039b3          	snez	s3,a5
    42d0:	00b35333          	srl	t1,t1,a1
    42d4:	01386833          	or	a6,a6,s3
    42d8:	00670733          	add	a4,a4,t1
    42dc:	01d809b3          	add	s3,a6,t4
    42e0:	01d9b7b3          	sltu	a5,s3,t4
    42e4:	00e78633          	add	a2,a5,a4
    42e8:	00088493          	mv	s1,a7
    42ec:	eadff06f          	j	4198 <__subdf3+0x3cc>
    42f0:	ee081ce3          	bnez	a6,41e8 <__subdf3+0x41c>
    42f4:	00351813          	slli	a6,a0,0x3
    42f8:	01d31793          	slli	a5,t1,0x1d
    42fc:	00385813          	srli	a6,a6,0x3
    4300:	00f86833          	or	a6,a6,a5
    4304:	00335793          	srli	a5,t1,0x3
    4308:	ed9ff06f          	j	41e0 <__subdf3+0x414>
    430c:	00800537          	lui	a0,0x800
    4310:	7ff00793          	li	a5,2047
    4314:	00a36333          	or	t1,t1,a0
    4318:	daf898e3          	bne	a7,a5,40c8 <__subdf3+0x2fc>
    431c:	00361613          	slli	a2,a2,0x3
    4320:	01d71813          	slli	a6,a4,0x1d
    4324:	00365613          	srli	a2,a2,0x3
    4328:	00c86833          	or	a6,a6,a2
    432c:	00375793          	srli	a5,a4,0x3
    4330:	00068413          	mv	s0,a3
    4334:	eadff06f          	j	41e0 <__subdf3+0x414>
    4338:	fe170713          	addi	a4,a4,-31
    433c:	02000693          	li	a3,32
    4340:	00e7d733          	srl	a4,a5,a4
    4344:	00d60a63          	beq	a2,a3,4358 <__subdf3+0x58c>
    4348:	04000693          	li	a3,64
    434c:	40c68633          	sub	a2,a3,a2
    4350:	00c79633          	sll	a2,a5,a2
    4354:	00c9e9b3          	or	s3,s3,a2
    4358:	01303833          	snez	a6,s3
    435c:	00e869b3          	or	s3,a6,a4
    4360:	00000613          	li	a2,0
    4364:	00000493          	li	s1,0
    4368:	de5ff06f          	j	414c <__subdf3+0x380>
    436c:	01df09b3          	add	s3,t5,t4
    4370:	00e307b3          	add	a5,t1,a4
    4374:	01e9bf33          	sltu	t5,s3,t5
    4378:	01e78633          	add	a2,a5,t5
    437c:	00861793          	slli	a5,a2,0x8
    4380:	00100493          	li	s1,1
    4384:	dc07d4e3          	bgez	a5,414c <__subdf3+0x380>
    4388:	00200493          	li	s1,2
    438c:	ff8007b7          	lui	a5,0xff800
    4390:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    4394:	00f677b3          	and	a5,a2,a5
    4398:	0019d713          	srli	a4,s3,0x1
    439c:	0019f813          	andi	a6,s3,1
    43a0:	01076833          	or	a6,a4,a6
    43a4:	01f79993          	slli	s3,a5,0x1f
    43a8:	0109e9b3          	or	s3,s3,a6
    43ac:	0017d613          	srli	a2,a5,0x1
    43b0:	b61ff06f          	j	3f10 <__subdf3+0x144>
    43b4:	fe058813          	addi	a6,a1,-32
    43b8:	02000793          	li	a5,32
    43bc:	010759b3          	srl	s3,a4,a6
    43c0:	00f58a63          	beq	a1,a5,43d4 <__subdf3+0x608>
    43c4:	04000793          	li	a5,64
    43c8:	40b785b3          	sub	a1,a5,a1
    43cc:	00b71733          	sll	a4,a4,a1
    43d0:	00eeeeb3          	or	t4,t4,a4
    43d4:	01d03833          	snez	a6,t4
    43d8:	01386833          	or	a6,a6,s3
    43dc:	ab1ff06f          	j	3e8c <__subdf3+0xc0>
    43e0:	01e36333          	or	t1,t1,t5
    43e4:	00603833          	snez	a6,t1
    43e8:	410e89b3          	sub	s3,t4,a6
    43ec:	013eb7b3          	sltu	a5,t4,s3
    43f0:	40f70633          	sub	a2,a4,a5
    43f4:	00088493          	mv	s1,a7
    43f8:	00068413          	mv	s0,a3
    43fc:	a9dff06f          	j	3e98 <__subdf3+0xcc>
    4400:	01e367b3          	or	a5,t1,t5
    4404:	1c078863          	beqz	a5,45d4 <__subdf3+0x808>
    4408:	fff58793          	addi	a5,a1,-1
    440c:	22078463          	beqz	a5,4634 <__subdf3+0x868>
    4410:	7ff00693          	li	a3,2047
    4414:	0ed58063          	beq	a1,a3,44f4 <__subdf3+0x728>
    4418:	00078593          	mv	a1,a5
    441c:	e89ff06f          	j	42a4 <__subdf3+0x4d8>
    4420:	02000793          	li	a5,32
    4424:	40b787b3          	sub	a5,a5,a1
    4428:	00bed9b3          	srl	s3,t4,a1
    442c:	00f71833          	sll	a6,a4,a5
    4430:	00fe9eb3          	sll	t4,t4,a5
    4434:	01386833          	or	a6,a6,s3
    4438:	00b75733          	srl	a4,a4,a1
    443c:	01d039b3          	snez	s3,t4
    4440:	01386833          	or	a6,a6,s3
    4444:	00e30333          	add	t1,t1,a4
    4448:	d45ff06f          	j	418c <__subdf3+0x3c0>
    444c:	00361813          	slli	a6,a2,0x3
    4450:	01d71793          	slli	a5,a4,0x1d
    4454:	00385813          	srli	a6,a6,0x3
    4458:	0107e833          	or	a6,a5,a6
    445c:	00068413          	mv	s0,a3
    4460:	00375793          	srli	a5,a4,0x3
    4464:	d05ff06f          	j	4168 <__subdf3+0x39c>
    4468:	08078663          	beqz	a5,44f4 <__subdf3+0x728>
    446c:	01d76733          	or	a4,a4,t4
    4470:	d6071ce3          	bnez	a4,41e8 <__subdf3+0x41c>
    4474:	00351513          	slli	a0,a0,0x3
    4478:	01d31813          	slli	a6,t1,0x1d
    447c:	00355513          	srli	a0,a0,0x3
    4480:	00a86833          	or	a6,a6,a0
    4484:	00335793          	srli	a5,t1,0x3
    4488:	d59ff06f          	j	41e0 <__subdf3+0x414>
    448c:	de080ae3          	beqz	a6,4280 <__subdf3+0x4b4>
    4490:	00361813          	slli	a6,a2,0x3
    4494:	01d71793          	slli	a5,a4,0x1d
    4498:	00385813          	srli	a6,a6,0x3
    449c:	00f86833          	or	a6,a6,a5
    44a0:	00068413          	mv	s0,a3
    44a4:	00375793          	srli	a5,a4,0x3
    44a8:	cc9ff06f          	j	4170 <__subdf3+0x3a4>
    44ac:	41df09b3          	sub	s3,t5,t4
    44b0:	40e307b3          	sub	a5,t1,a4
    44b4:	013f3f33          	sltu	t5,t5,s3
    44b8:	41e78633          	sub	a2,a5,t5
    44bc:	00100493          	li	s1,1
    44c0:	9d9ff06f          	j	3e98 <__subdf3+0xcc>
    44c4:	00351813          	slli	a6,a0,0x3
    44c8:	01d31693          	slli	a3,t1,0x1d
    44cc:	00385813          	srli	a6,a6,0x3
    44d0:	0106e833          	or	a6,a3,a6
    44d4:	00335793          	srli	a5,t1,0x3
    44d8:	d09ff06f          	j	41e0 <__subdf3+0x414>
    44dc:	41ee89b3          	sub	s3,t4,t5
    44e0:	40670633          	sub	a2,a4,t1
    44e4:	013eb933          	sltu	s2,t4,s3
    44e8:	41260933          	sub	s2,a2,s2
    44ec:	00068413          	mv	s0,a3
    44f0:	9bdff06f          	j	3eac <__subdf3+0xe0>
    44f4:	00361613          	slli	a2,a2,0x3
    44f8:	01d71813          	slli	a6,a4,0x1d
    44fc:	00365613          	srli	a2,a2,0x3
    4500:	00c86833          	or	a6,a6,a2
    4504:	00375793          	srli	a5,a4,0x3
    4508:	cd9ff06f          	j	41e0 <__subdf3+0x414>
    450c:	41df09b3          	sub	s3,t5,t4
    4510:	40e307b3          	sub	a5,t1,a4
    4514:	013f3633          	sltu	a2,t5,s3
    4518:	40c78633          	sub	a2,a5,a2
    451c:	00861793          	slli	a5,a2,0x8
    4520:	0c07d663          	bgez	a5,45ec <__subdf3+0x820>
    4524:	41ee89b3          	sub	s3,t4,t5
    4528:	406707b3          	sub	a5,a4,t1
    452c:	013ebeb3          	sltu	t4,t4,s3
    4530:	41d78633          	sub	a2,a5,t4
    4534:	00068413          	mv	s0,a3
    4538:	9d9ff06f          	j	3f10 <__subdf3+0x144>
    453c:	01e36333          	or	t1,t1,t5
    4540:	00603833          	snez	a6,t1
    4544:	d99ff06f          	j	42dc <__subdf3+0x510>
    4548:	fe058813          	addi	a6,a1,-32
    454c:	02000793          	li	a5,32
    4550:	010359b3          	srl	s3,t1,a6
    4554:	00f58a63          	beq	a1,a5,4568 <__subdf3+0x79c>
    4558:	04000793          	li	a5,64
    455c:	40b785b3          	sub	a1,a5,a1
    4560:	00b31333          	sll	t1,t1,a1
    4564:	006f6f33          	or	t5,t5,t1
    4568:	01e03833          	snez	a6,t5
    456c:	01386833          	or	a6,a6,s3
    4570:	e79ff06f          	j	43e8 <__subdf3+0x61c>
    4574:	41ee89b3          	sub	s3,t4,t5
    4578:	406707b3          	sub	a5,a4,t1
    457c:	013ebeb3          	sltu	t4,t4,s3
    4580:	41d78633          	sub	a2,a5,t4
    4584:	00068413          	mv	s0,a3
    4588:	00100493          	li	s1,1
    458c:	90dff06f          	j	3e98 <__subdf3+0xcc>
    4590:	00361813          	slli	a6,a2,0x3
    4594:	01d71793          	slli	a5,a4,0x1d
    4598:	00385813          	srli	a6,a6,0x3
    459c:	00f86833          	or	a6,a6,a5
    45a0:	00375793          	srli	a5,a4,0x3
    45a4:	bcdff06f          	j	4170 <__subdf3+0x3a4>
    45a8:	01df09b3          	add	s3,t5,t4
    45ac:	00e307b3          	add	a5,t1,a4
    45b0:	01e9bf33          	sltu	t5,s3,t5
    45b4:	01e78633          	add	a2,a5,t5
    45b8:	00861793          	slli	a5,a2,0x8
    45bc:	b807d8e3          	bgez	a5,414c <__subdf3+0x380>
    45c0:	ff8007b7          	lui	a5,0xff800
    45c4:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    45c8:	00f67633          	and	a2,a2,a5
    45cc:	00100493          	li	s1,1
    45d0:	b7dff06f          	j	414c <__subdf3+0x380>
    45d4:	00361613          	slli	a2,a2,0x3
    45d8:	01d71813          	slli	a6,a4,0x1d
    45dc:	00365613          	srli	a2,a2,0x3
    45e0:	00c86833          	or	a6,a6,a2
    45e4:	00375793          	srli	a5,a4,0x3
    45e8:	b81ff06f          	j	4168 <__subdf3+0x39c>
    45ec:	00c9e833          	or	a6,s3,a2
    45f0:	c80808e3          	beqz	a6,4280 <__subdf3+0x4b4>
    45f4:	b59ff06f          	j	414c <__subdf3+0x380>
    45f8:	fe058813          	addi	a6,a1,-32
    45fc:	02000793          	li	a5,32
    4600:	010359b3          	srl	s3,t1,a6
    4604:	00f58a63          	beq	a1,a5,4618 <__subdf3+0x84c>
    4608:	04000793          	li	a5,64
    460c:	40b785b3          	sub	a1,a5,a1
    4610:	00b31333          	sll	t1,t1,a1
    4614:	006f6f33          	or	t5,t5,t1
    4618:	01e03833          	snez	a6,t5
    461c:	01386833          	or	a6,a6,s3
    4620:	cbdff06f          	j	42dc <__subdf3+0x510>
    4624:	00000413          	li	s0,0
    4628:	7ff00713          	li	a4,2047
    462c:	000807b7          	lui	a5,0x80
    4630:	941ff06f          	j	3f70 <__subdf3+0x1a4>
    4634:	01df09b3          	add	s3,t5,t4
    4638:	00e307b3          	add	a5,t1,a4
    463c:	01d9beb3          	sltu	t4,s3,t4
    4640:	01d78633          	add	a2,a5,t4
    4644:	d39ff06f          	j	437c <__subdf3+0x5b0>

00004648 <__fixdfsi>:
    4648:	0145d793          	srli	a5,a1,0x14
    464c:	001006b7          	lui	a3,0x100
    4650:	fff68713          	addi	a4,a3,-1 # fffff <_end+0xf712f>
    4654:	7ff7f793          	andi	a5,a5,2047
    4658:	3fe00613          	li	a2,1022
    465c:	00b77733          	and	a4,a4,a1
    4660:	01f5d593          	srli	a1,a1,0x1f
    4664:	00f65e63          	bge	a2,a5,4680 <__fixdfsi+0x38>
    4668:	41d00613          	li	a2,1053
    466c:	00f65e63          	bge	a2,a5,4688 <__fixdfsi+0x40>
    4670:	80000537          	lui	a0,0x80000
    4674:	fff54513          	not	a0,a0
    4678:	00a58533          	add	a0,a1,a0
    467c:	00008067          	ret
    4680:	00000513          	li	a0,0
    4684:	00008067          	ret
    4688:	43300613          	li	a2,1075
    468c:	40f60633          	sub	a2,a2,a5
    4690:	01f00813          	li	a6,31
    4694:	00d76733          	or	a4,a4,a3
    4698:	02c85063          	bge	a6,a2,46b8 <__fixdfsi+0x70>
    469c:	41300693          	li	a3,1043
    46a0:	40f687b3          	sub	a5,a3,a5
    46a4:	00f757b3          	srl	a5,a4,a5
    46a8:	40f00533          	neg	a0,a5
    46ac:	fc059ce3          	bnez	a1,4684 <__fixdfsi+0x3c>
    46b0:	00078513          	mv	a0,a5
    46b4:	00008067          	ret
    46b8:	bed78793          	addi	a5,a5,-1043 # 7fbed <_end+0x76d1d>
    46bc:	00f717b3          	sll	a5,a4,a5
    46c0:	00c55533          	srl	a0,a0,a2
    46c4:	00a7e7b3          	or	a5,a5,a0
    46c8:	fe1ff06f          	j	46a8 <__fixdfsi+0x60>

000046cc <__floatsidf>:
    46cc:	ff010113          	addi	sp,sp,-16
    46d0:	00112623          	sw	ra,12(sp)
    46d4:	00812423          	sw	s0,8(sp)
    46d8:	00912223          	sw	s1,4(sp)
    46dc:	04050a63          	beqz	a0,4730 <__floatsidf+0x64>
    46e0:	41f55793          	srai	a5,a0,0x1f
    46e4:	00a7c4b3          	xor	s1,a5,a0
    46e8:	40f484b3          	sub	s1,s1,a5
    46ec:	00050413          	mv	s0,a0
    46f0:	00048513          	mv	a0,s1
    46f4:	588000ef          	jal	ra,4c7c <__clzsi2>
    46f8:	41e00693          	li	a3,1054
    46fc:	40a686b3          	sub	a3,a3,a0
    4700:	00a00793          	li	a5,10
    4704:	01f45413          	srli	s0,s0,0x1f
    4708:	7ff6f693          	andi	a3,a3,2047
    470c:	06a7c463          	blt	a5,a0,4774 <__floatsidf+0xa8>
    4710:	00b00713          	li	a4,11
    4714:	40a70733          	sub	a4,a4,a0
    4718:	00e4d7b3          	srl	a5,s1,a4
    471c:	01550513          	addi	a0,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf7145>
    4720:	00c79793          	slli	a5,a5,0xc
    4724:	00a494b3          	sll	s1,s1,a0
    4728:	00c7d793          	srli	a5,a5,0xc
    472c:	0140006f          	j	4740 <__floatsidf+0x74>
    4730:	00000413          	li	s0,0
    4734:	00000693          	li	a3,0
    4738:	00000793          	li	a5,0
    473c:	00000493          	li	s1,0
    4740:	00c79793          	slli	a5,a5,0xc
    4744:	01469693          	slli	a3,a3,0x14
    4748:	00c7d793          	srli	a5,a5,0xc
    474c:	01f41413          	slli	s0,s0,0x1f
    4750:	00d7e7b3          	or	a5,a5,a3
    4754:	0087e7b3          	or	a5,a5,s0
    4758:	00c12083          	lw	ra,12(sp)
    475c:	00812403          	lw	s0,8(sp)
    4760:	00048513          	mv	a0,s1
    4764:	00078593          	mv	a1,a5
    4768:	00412483          	lw	s1,4(sp)
    476c:	01010113          	addi	sp,sp,16
    4770:	00008067          	ret
    4774:	ff550513          	addi	a0,a0,-11
    4778:	00a497b3          	sll	a5,s1,a0
    477c:	00c79793          	slli	a5,a5,0xc
    4780:	00c7d793          	srli	a5,a5,0xc
    4784:	00000493          	li	s1,0
    4788:	fb9ff06f          	j	4740 <__floatsidf+0x74>

0000478c <__gesf2>:
    478c:	01755693          	srli	a3,a0,0x17
    4790:	008007b7          	lui	a5,0x800
    4794:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    4798:	0175d613          	srli	a2,a1,0x17
    479c:	0ff6f693          	andi	a3,a3,255
    47a0:	0ff00813          	li	a6,255
    47a4:	00a7f8b3          	and	a7,a5,a0
    47a8:	01f55713          	srli	a4,a0,0x1f
    47ac:	00b7f7b3          	and	a5,a5,a1
    47b0:	0ff67613          	andi	a2,a2,255
    47b4:	01f5d513          	srli	a0,a1,0x1f
    47b8:	03068a63          	beq	a3,a6,47ec <__gesf2+0x60>
    47bc:	03060263          	beq	a2,a6,47e0 <__gesf2+0x54>
    47c0:	02069a63          	bnez	a3,47f4 <__gesf2+0x68>
    47c4:	00061463          	bnez	a2,47cc <__gesf2+0x40>
    47c8:	04078a63          	beqz	a5,481c <__gesf2+0x90>
    47cc:	04088263          	beqz	a7,4810 <__gesf2+0x84>
    47d0:	06a70063          	beq	a4,a0,4830 <__gesf2+0xa4>
    47d4:	00100513          	li	a0,1
    47d8:	02071e63          	bnez	a4,4814 <__gesf2+0x88>
    47dc:	00008067          	ret
    47e0:	fe0780e3          	beqz	a5,47c0 <__gesf2+0x34>
    47e4:	ffe00513          	li	a0,-2
    47e8:	00008067          	ret
    47ec:	fe089ce3          	bnez	a7,47e4 <__gesf2+0x58>
    47f0:	02d60c63          	beq	a2,a3,4828 <__gesf2+0x9c>
    47f4:	00061463          	bnez	a2,47fc <__gesf2+0x70>
    47f8:	fc078ee3          	beqz	a5,47d4 <__gesf2+0x48>
    47fc:	fca71ce3          	bne	a4,a0,47d4 <__gesf2+0x48>
    4800:	02d65a63          	bge	a2,a3,4834 <__gesf2+0xa8>
    4804:	00051863          	bnez	a0,4814 <__gesf2+0x88>
    4808:	00100513          	li	a0,1
    480c:	00008067          	ret
    4810:	fc0516e3          	bnez	a0,47dc <__gesf2+0x50>
    4814:	fff00513          	li	a0,-1
    4818:	00008067          	ret
    481c:	00000513          	li	a0,0
    4820:	fa089ae3          	bnez	a7,47d4 <__gesf2+0x48>
    4824:	00008067          	ret
    4828:	fc078ae3          	beqz	a5,47fc <__gesf2+0x70>
    482c:	fb9ff06f          	j	47e4 <__gesf2+0x58>
    4830:	00000693          	li	a3,0
    4834:	00c6c863          	blt	a3,a2,4844 <__gesf2+0xb8>
    4838:	f917eee3          	bltu	a5,a7,47d4 <__gesf2+0x48>
    483c:	00000513          	li	a0,0
    4840:	f8f8fee3          	bgeu	a7,a5,47dc <__gesf2+0x50>
    4844:	fc0708e3          	beqz	a4,4814 <__gesf2+0x88>
    4848:	00070513          	mv	a0,a4
    484c:	00008067          	ret

00004850 <__lesf2>:
    4850:	01755693          	srli	a3,a0,0x17
    4854:	008007b7          	lui	a5,0x800
    4858:	fff78793          	addi	a5,a5,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    485c:	0175d613          	srli	a2,a1,0x17
    4860:	0ff6f693          	andi	a3,a3,255
    4864:	0ff00813          	li	a6,255
    4868:	00a7f8b3          	and	a7,a5,a0
    486c:	01f55713          	srli	a4,a0,0x1f
    4870:	00b7f7b3          	and	a5,a5,a1
    4874:	0ff67613          	andi	a2,a2,255
    4878:	01f5d513          	srli	a0,a1,0x1f
    487c:	05068263          	beq	a3,a6,48c0 <__lesf2+0x70>
    4880:	01060e63          	beq	a2,a6,489c <__lesf2+0x4c>
    4884:	04069263          	bnez	a3,48c8 <__lesf2+0x78>
    4888:	02061063          	bnez	a2,48a8 <__lesf2+0x58>
    488c:	00079e63          	bnez	a5,48a8 <__lesf2+0x58>
    4890:	00000513          	li	a0,0
    4894:	00089e63          	bnez	a7,48b0 <__lesf2+0x60>
    4898:	00008067          	ret
    489c:	fe0784e3          	beqz	a5,4884 <__lesf2+0x34>
    48a0:	00200513          	li	a0,2
    48a4:	00008067          	ret
    48a8:	02088e63          	beqz	a7,48e4 <__lesf2+0x94>
    48ac:	04a70463          	beq	a4,a0,48f4 <__lesf2+0xa4>
    48b0:	00100513          	li	a0,1
    48b4:	fe0702e3          	beqz	a4,4898 <__lesf2+0x48>
    48b8:	fff00513          	li	a0,-1
    48bc:	00008067          	ret
    48c0:	fe0890e3          	bnez	a7,48a0 <__lesf2+0x50>
    48c4:	02d60463          	beq	a2,a3,48ec <__lesf2+0x9c>
    48c8:	00061463          	bnez	a2,48d0 <__lesf2+0x80>
    48cc:	fe0782e3          	beqz	a5,48b0 <__lesf2+0x60>
    48d0:	fea710e3          	bne	a4,a0,48b0 <__lesf2+0x60>
    48d4:	02d65263          	bge	a2,a3,48f8 <__lesf2+0xa8>
    48d8:	fe0510e3          	bnez	a0,48b8 <__lesf2+0x68>
    48dc:	00100513          	li	a0,1
    48e0:	00008067          	ret
    48e4:	fc050ae3          	beqz	a0,48b8 <__lesf2+0x68>
    48e8:	00008067          	ret
    48ec:	fe0782e3          	beqz	a5,48d0 <__lesf2+0x80>
    48f0:	fb1ff06f          	j	48a0 <__lesf2+0x50>
    48f4:	00000693          	li	a3,0
    48f8:	00c6c863          	blt	a3,a2,4908 <__lesf2+0xb8>
    48fc:	fb17eae3          	bltu	a5,a7,48b0 <__lesf2+0x60>
    4900:	00000513          	li	a0,0
    4904:	f8f8fae3          	bgeu	a7,a5,4898 <__lesf2+0x48>
    4908:	fa0708e3          	beqz	a4,48b8 <__lesf2+0x68>
    490c:	00070513          	mv	a0,a4
    4910:	00008067          	ret

00004914 <__fixsfsi>:
    4914:	00800637          	lui	a2,0x800
    4918:	01755713          	srli	a4,a0,0x17
    491c:	fff60793          	addi	a5,a2,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    4920:	0ff77713          	andi	a4,a4,255
    4924:	07e00593          	li	a1,126
    4928:	00a7f6b3          	and	a3,a5,a0
    492c:	01f55793          	srli	a5,a0,0x1f
    4930:	00e5fe63          	bgeu	a1,a4,494c <__fixsfsi+0x38>
    4934:	09d00593          	li	a1,157
    4938:	00e5fe63          	bgeu	a1,a4,4954 <__fixsfsi+0x40>
    493c:	80000537          	lui	a0,0x80000
    4940:	fff54513          	not	a0,a0
    4944:	00a78533          	add	a0,a5,a0
    4948:	00008067          	ret
    494c:	00000513          	li	a0,0
    4950:	00008067          	ret
    4954:	09500593          	li	a1,149
    4958:	00c6e6b3          	or	a3,a3,a2
    495c:	02e5c063          	blt	a1,a4,497c <__fixsfsi+0x68>
    4960:	09600613          	li	a2,150
    4964:	40e60733          	sub	a4,a2,a4
    4968:	00e6d733          	srl	a4,a3,a4
    496c:	40e00533          	neg	a0,a4
    4970:	fe0790e3          	bnez	a5,4950 <__fixsfsi+0x3c>
    4974:	00070513          	mv	a0,a4
    4978:	00008067          	ret
    497c:	f6a70713          	addi	a4,a4,-150
    4980:	00e69733          	sll	a4,a3,a4
    4984:	fe9ff06f          	j	496c <__fixsfsi+0x58>

00004988 <__extendsfdf2>:
    4988:	01755713          	srli	a4,a0,0x17
    498c:	0ff77713          	andi	a4,a4,255
    4990:	ff010113          	addi	sp,sp,-16
    4994:	00170793          	addi	a5,a4,1
    4998:	00812423          	sw	s0,8(sp)
    499c:	00912223          	sw	s1,4(sp)
    49a0:	00951413          	slli	s0,a0,0x9
    49a4:	00112623          	sw	ra,12(sp)
    49a8:	0fe7f793          	andi	a5,a5,254
    49ac:	00945413          	srli	s0,s0,0x9
    49b0:	01f55493          	srli	s1,a0,0x1f
    49b4:	04078263          	beqz	a5,49f8 <__extendsfdf2+0x70>
    49b8:	00345793          	srli	a5,s0,0x3
    49bc:	38070713          	addi	a4,a4,896
    49c0:	01d41413          	slli	s0,s0,0x1d
    49c4:	00c79793          	slli	a5,a5,0xc
    49c8:	01471713          	slli	a4,a4,0x14
    49cc:	00c7d793          	srli	a5,a5,0xc
    49d0:	01f49513          	slli	a0,s1,0x1f
    49d4:	00e7e7b3          	or	a5,a5,a4
    49d8:	00a7e7b3          	or	a5,a5,a0
    49dc:	00c12083          	lw	ra,12(sp)
    49e0:	00040513          	mv	a0,s0
    49e4:	00812403          	lw	s0,8(sp)
    49e8:	00412483          	lw	s1,4(sp)
    49ec:	00078593          	mv	a1,a5
    49f0:	01010113          	addi	sp,sp,16
    49f4:	00008067          	ret
    49f8:	04071263          	bnez	a4,4a3c <__extendsfdf2+0xb4>
    49fc:	06040863          	beqz	s0,4a6c <__extendsfdf2+0xe4>
    4a00:	00040513          	mv	a0,s0
    4a04:	278000ef          	jal	ra,4c7c <__clzsi2>
    4a08:	00a00793          	li	a5,10
    4a0c:	06a7c663          	blt	a5,a0,4a78 <__extendsfdf2+0xf0>
    4a10:	00b00713          	li	a4,11
    4a14:	40a70733          	sub	a4,a4,a0
    4a18:	01550793          	addi	a5,a0,21 # 80000015 <__freertos_irq_stack_top+0x7fdf7145>
    4a1c:	00e45733          	srl	a4,s0,a4
    4a20:	00f41433          	sll	s0,s0,a5
    4a24:	00c71793          	slli	a5,a4,0xc
    4a28:	38900713          	li	a4,905
    4a2c:	40a70733          	sub	a4,a4,a0
    4a30:	00c7d793          	srli	a5,a5,0xc
    4a34:	7ff77713          	andi	a4,a4,2047
    4a38:	f8dff06f          	j	49c4 <__extendsfdf2+0x3c>
    4a3c:	02040263          	beqz	s0,4a60 <__extendsfdf2+0xd8>
    4a40:	00345713          	srli	a4,s0,0x3
    4a44:	000807b7          	lui	a5,0x80
    4a48:	00f767b3          	or	a5,a4,a5
    4a4c:	00c79793          	slli	a5,a5,0xc
    4a50:	01d41413          	slli	s0,s0,0x1d
    4a54:	00c7d793          	srli	a5,a5,0xc
    4a58:	7ff00713          	li	a4,2047
    4a5c:	f69ff06f          	j	49c4 <__extendsfdf2+0x3c>
    4a60:	7ff00713          	li	a4,2047
    4a64:	00000793          	li	a5,0
    4a68:	f5dff06f          	j	49c4 <__extendsfdf2+0x3c>
    4a6c:	00000713          	li	a4,0
    4a70:	00000793          	li	a5,0
    4a74:	f51ff06f          	j	49c4 <__extendsfdf2+0x3c>
    4a78:	ff550713          	addi	a4,a0,-11
    4a7c:	00e41733          	sll	a4,s0,a4
    4a80:	00000413          	li	s0,0
    4a84:	fa1ff06f          	j	4a24 <__extendsfdf2+0x9c>

00004a88 <__truncdfsf2>:
    4a88:	0145d693          	srli	a3,a1,0x14
    4a8c:	00c59793          	slli	a5,a1,0xc
    4a90:	7ff6f693          	andi	a3,a3,2047
    4a94:	00c7d793          	srli	a5,a5,0xc
    4a98:	00168613          	addi	a2,a3,1
    4a9c:	00379793          	slli	a5,a5,0x3
    4aa0:	01d55713          	srli	a4,a0,0x1d
    4aa4:	7fe67613          	andi	a2,a2,2046
    4aa8:	01f5d593          	srli	a1,a1,0x1f
    4aac:	00f76733          	or	a4,a4,a5
    4ab0:	00351893          	slli	a7,a0,0x3
    4ab4:	0a060463          	beqz	a2,4b5c <__truncdfsf2+0xd4>
    4ab8:	c8068813          	addi	a6,a3,-896
    4abc:	0fe00793          	li	a5,254
    4ac0:	0307d463          	bge	a5,a6,4ae8 <__truncdfsf2+0x60>
    4ac4:	00000793          	li	a5,0
    4ac8:	00979513          	slli	a0,a5,0x9
    4acc:	0ff00693          	li	a3,255
    4ad0:	01769693          	slli	a3,a3,0x17
    4ad4:	00955513          	srli	a0,a0,0x9
    4ad8:	01f59593          	slli	a1,a1,0x1f
    4adc:	00d56533          	or	a0,a0,a3
    4ae0:	00b56533          	or	a0,a0,a1
    4ae4:	00008067          	ret
    4ae8:	0f005e63          	blez	a6,4be4 <__truncdfsf2+0x15c>
    4aec:	00651793          	slli	a5,a0,0x6
    4af0:	00371713          	slli	a4,a4,0x3
    4af4:	00f037b3          	snez	a5,a5
    4af8:	00e7e7b3          	or	a5,a5,a4
    4afc:	01d8d893          	srli	a7,a7,0x1d
    4b00:	0117e7b3          	or	a5,a5,a7
    4b04:	0077f713          	andi	a4,a5,7
    4b08:	16070663          	beqz	a4,4c74 <__truncdfsf2+0x1ec>
    4b0c:	00f7f713          	andi	a4,a5,15
    4b10:	00400693          	li	a3,4
    4b14:	00d70463          	beq	a4,a3,4b1c <__truncdfsf2+0x94>
    4b18:	00478793          	addi	a5,a5,4 # 80004 <_end+0x77134>
    4b1c:	04000737          	lui	a4,0x4000
    4b20:	00e7f733          	and	a4,a5,a4
    4b24:	14070863          	beqz	a4,4c74 <__truncdfsf2+0x1ec>
    4b28:	00180713          	addi	a4,a6,1
    4b2c:	0ff00613          	li	a2,255
    4b30:	0ff77693          	andi	a3,a4,255
    4b34:	f8c708e3          	beq	a4,a2,4ac4 <__truncdfsf2+0x3c>
    4b38:	00679793          	slli	a5,a5,0x6
    4b3c:	0097d793          	srli	a5,a5,0x9
    4b40:	00979513          	slli	a0,a5,0x9
    4b44:	01769693          	slli	a3,a3,0x17
    4b48:	00955513          	srli	a0,a0,0x9
    4b4c:	01f59593          	slli	a1,a1,0x1f
    4b50:	00d56533          	or	a0,a0,a3
    4b54:	00b56533          	or	a0,a0,a1
    4b58:	00008067          	ret
    4b5c:	011767b3          	or	a5,a4,a7
    4b60:	02069a63          	bnez	a3,4b94 <__truncdfsf2+0x10c>
    4b64:	04078e63          	beqz	a5,4bc0 <__truncdfsf2+0x138>
    4b68:	00500793          	li	a5,5
    4b6c:	00679793          	slli	a5,a5,0x6
    4b70:	0097d793          	srli	a5,a5,0x9
    4b74:	00979513          	slli	a0,a5,0x9
    4b78:	0ff6f693          	andi	a3,a3,255
    4b7c:	01769693          	slli	a3,a3,0x17
    4b80:	00955513          	srli	a0,a0,0x9
    4b84:	01f59593          	slli	a1,a1,0x1f
    4b88:	00d56533          	or	a0,a0,a3
    4b8c:	00b56533          	or	a0,a0,a1
    4b90:	00008067          	ret
    4b94:	f20788e3          	beqz	a5,4ac4 <__truncdfsf2+0x3c>
    4b98:	004007b7          	lui	a5,0x400
    4b9c:	00979513          	slli	a0,a5,0x9
    4ba0:	0ff00693          	li	a3,255
    4ba4:	01769693          	slli	a3,a3,0x17
    4ba8:	00000593          	li	a1,0
    4bac:	00955513          	srli	a0,a0,0x9
    4bb0:	01f59593          	slli	a1,a1,0x1f
    4bb4:	00d56533          	or	a0,a0,a3
    4bb8:	00b56533          	or	a0,a0,a1
    4bbc:	00008067          	ret
    4bc0:	00000793          	li	a5,0
    4bc4:	00979513          	slli	a0,a5,0x9
    4bc8:	00000693          	li	a3,0
    4bcc:	01769693          	slli	a3,a3,0x17
    4bd0:	00955513          	srli	a0,a0,0x9
    4bd4:	01f59593          	slli	a1,a1,0x1f
    4bd8:	00d56533          	or	a0,a0,a3
    4bdc:	00b56533          	or	a0,a0,a1
    4be0:	00008067          	ret
    4be4:	fe900793          	li	a5,-23
    4be8:	06f84263          	blt	a6,a5,4c4c <__truncdfsf2+0x1c4>
    4bec:	01e00793          	li	a5,30
    4bf0:	00800637          	lui	a2,0x800
    4bf4:	410787b3          	sub	a5,a5,a6
    4bf8:	01f00513          	li	a0,31
    4bfc:	00c76633          	or	a2,a4,a2
    4c00:	04f55a63          	bge	a0,a5,4c54 <__truncdfsf2+0x1cc>
    4c04:	ffe00713          	li	a4,-2
    4c08:	41070733          	sub	a4,a4,a6
    4c0c:	02000513          	li	a0,32
    4c10:	00e65733          	srl	a4,a2,a4
    4c14:	00a78863          	beq	a5,a0,4c24 <__truncdfsf2+0x19c>
    4c18:	ca268693          	addi	a3,a3,-862
    4c1c:	00d616b3          	sll	a3,a2,a3
    4c20:	00d8e8b3          	or	a7,a7,a3
    4c24:	011037b3          	snez	a5,a7
    4c28:	00e7e7b3          	or	a5,a5,a4
    4c2c:	0077f713          	andi	a4,a5,7
    4c30:	00000813          	li	a6,0
    4c34:	ec071ce3          	bnez	a4,4b0c <__truncdfsf2+0x84>
    4c38:	00579713          	slli	a4,a5,0x5
    4c3c:	00100693          	li	a3,1
    4c40:	ee074ce3          	bltz	a4,4b38 <__truncdfsf2+0xb0>
    4c44:	00000693          	li	a3,0
    4c48:	f25ff06f          	j	4b6c <__truncdfsf2+0xe4>
    4c4c:	00000693          	li	a3,0
    4c50:	f19ff06f          	j	4b68 <__truncdfsf2+0xe0>
    4c54:	c8268693          	addi	a3,a3,-894
    4c58:	00d89733          	sll	a4,a7,a3
    4c5c:	00e03733          	snez	a4,a4
    4c60:	00d616b3          	sll	a3,a2,a3
    4c64:	00f8d8b3          	srl	a7,a7,a5
    4c68:	00d767b3          	or	a5,a4,a3
    4c6c:	00f8e7b3          	or	a5,a7,a5
    4c70:	fbdff06f          	j	4c2c <__truncdfsf2+0x1a4>
    4c74:	00080693          	mv	a3,a6
    4c78:	ef5ff06f          	j	4b6c <__truncdfsf2+0xe4>

00004c7c <__clzsi2>:
    4c7c:	000107b7          	lui	a5,0x10
    4c80:	04f57463          	bgeu	a0,a5,4cc8 <__clzsi2+0x4c>
    4c84:	0ff00793          	li	a5,255
    4c88:	02000713          	li	a4,32
    4c8c:	00a7ee63          	bltu	a5,a0,4ca8 <__clzsi2+0x2c>
    4c90:	00003797          	auipc	a5,0x3
    4c94:	cac78793          	addi	a5,a5,-852 # 793c <__clz_tab>
    4c98:	00a787b3          	add	a5,a5,a0
    4c9c:	0007c503          	lbu	a0,0(a5)
    4ca0:	40a70533          	sub	a0,a4,a0
    4ca4:	00008067          	ret
    4ca8:	00855513          	srli	a0,a0,0x8
    4cac:	00003797          	auipc	a5,0x3
    4cb0:	c9078793          	addi	a5,a5,-880 # 793c <__clz_tab>
    4cb4:	00a787b3          	add	a5,a5,a0
    4cb8:	0007c503          	lbu	a0,0(a5)
    4cbc:	01800713          	li	a4,24
    4cc0:	40a70533          	sub	a0,a4,a0
    4cc4:	00008067          	ret
    4cc8:	010007b7          	lui	a5,0x1000
    4ccc:	02f56263          	bltu	a0,a5,4cf0 <__clzsi2+0x74>
    4cd0:	01855513          	srli	a0,a0,0x18
    4cd4:	00003797          	auipc	a5,0x3
    4cd8:	c6878793          	addi	a5,a5,-920 # 793c <__clz_tab>
    4cdc:	00a787b3          	add	a5,a5,a0
    4ce0:	0007c503          	lbu	a0,0(a5)
    4ce4:	00800713          	li	a4,8
    4ce8:	40a70533          	sub	a0,a4,a0
    4cec:	00008067          	ret
    4cf0:	01055513          	srli	a0,a0,0x10
    4cf4:	00003797          	auipc	a5,0x3
    4cf8:	c4878793          	addi	a5,a5,-952 # 793c <__clz_tab>
    4cfc:	00a787b3          	add	a5,a5,a0
    4d00:	0007c503          	lbu	a0,0(a5)
    4d04:	01000713          	li	a4,16
    4d08:	40a70533          	sub	a0,a4,a0
    4d0c:	00008067          	ret

00004d10 <pow>:
    4d10:	fe010113          	addi	sp,sp,-32
    4d14:	00812c23          	sw	s0,24(sp)
    4d18:	00912a23          	sw	s1,20(sp)
    4d1c:	01212823          	sw	s2,16(sp)
    4d20:	01312623          	sw	s3,12(sp)
    4d24:	01412423          	sw	s4,8(sp)
    4d28:	01512223          	sw	s5,4(sp)
    4d2c:	00112e23          	sw	ra,28(sp)
    4d30:	00050913          	mv	s2,a0
    4d34:	00058993          	mv	s3,a1
    4d38:	00060413          	mv	s0,a2
    4d3c:	00068493          	mv	s1,a3
    4d40:	240000ef          	jal	ra,4f80 <__ieee754_pow>
    4d44:	81018793          	addi	a5,gp,-2032 # 8000 <__fdlib_version>
    4d48:	0007a703          	lw	a4,0(a5)
    4d4c:	fff00793          	li	a5,-1
    4d50:	00050a13          	mv	s4,a0
    4d54:	00058a93          	mv	s5,a1
    4d58:	08f70663          	beq	a4,a5,4de4 <pow+0xd4>
    4d5c:	00040613          	mv	a2,s0
    4d60:	00048693          	mv	a3,s1
    4d64:	00040513          	mv	a0,s0
    4d68:	00048593          	mv	a1,s1
    4d6c:	23d020ef          	jal	ra,77a8 <__unorddf2>
    4d70:	06051a63          	bnez	a0,4de4 <pow+0xd4>
    4d74:	00090613          	mv	a2,s2
    4d78:	00098693          	mv	a3,s3
    4d7c:	00090513          	mv	a0,s2
    4d80:	00098593          	mv	a1,s3
    4d84:	225020ef          	jal	ra,77a8 <__unorddf2>
    4d88:	00000613          	li	a2,0
    4d8c:	00000693          	li	a3,0
    4d90:	0e051063          	bnez	a0,4e70 <pow+0x160>
    4d94:	00090513          	mv	a0,s2
    4d98:	00098593          	mv	a1,s3
    4d9c:	085020ef          	jal	ra,7620 <__eqdf2>
    4da0:	06051863          	bnez	a0,4e10 <pow+0x100>
    4da4:	00000613          	li	a2,0
    4da8:	00000693          	li	a3,0
    4dac:	00040513          	mv	a0,s0
    4db0:	00048593          	mv	a1,s1
    4db4:	06d020ef          	jal	ra,7620 <__eqdf2>
    4db8:	0c050463          	beqz	a0,4e80 <pow+0x170>
    4dbc:	00040513          	mv	a0,s0
    4dc0:	00048593          	mv	a1,s1
    4dc4:	454010ef          	jal	ra,6218 <finite>
    4dc8:	00050e63          	beqz	a0,4de4 <pow+0xd4>
    4dcc:	00000613          	li	a2,0
    4dd0:	00000693          	li	a3,0
    4dd4:	00040513          	mv	a0,s0
    4dd8:	00048593          	mv	a1,s1
    4ddc:	89dfe0ef          	jal	ra,3678 <__ledf2>
    4de0:	12054263          	bltz	a0,4f04 <pow+0x1f4>
    4de4:	01c12083          	lw	ra,28(sp)
    4de8:	01812403          	lw	s0,24(sp)
    4dec:	000a0513          	mv	a0,s4
    4df0:	000a8593          	mv	a1,s5
    4df4:	01412483          	lw	s1,20(sp)
    4df8:	01012903          	lw	s2,16(sp)
    4dfc:	00c12983          	lw	s3,12(sp)
    4e00:	00812a03          	lw	s4,8(sp)
    4e04:	00412a83          	lw	s5,4(sp)
    4e08:	02010113          	addi	sp,sp,32
    4e0c:	00008067          	ret
    4e10:	000a0513          	mv	a0,s4
    4e14:	000a8593          	mv	a1,s5
    4e18:	400010ef          	jal	ra,6218 <finite>
    4e1c:	06050c63          	beqz	a0,4e94 <pow+0x184>
    4e20:	00000613          	li	a2,0
    4e24:	00000693          	li	a3,0
    4e28:	000a0513          	mv	a0,s4
    4e2c:	000a8593          	mv	a1,s5
    4e30:	7f0020ef          	jal	ra,7620 <__eqdf2>
    4e34:	fa0518e3          	bnez	a0,4de4 <pow+0xd4>
    4e38:	00090513          	mv	a0,s2
    4e3c:	00098593          	mv	a1,s3
    4e40:	3d8010ef          	jal	ra,6218 <finite>
    4e44:	fa0500e3          	beqz	a0,4de4 <pow+0xd4>
    4e48:	00040513          	mv	a0,s0
    4e4c:	00048593          	mv	a1,s1
    4e50:	3c8010ef          	jal	ra,6218 <finite>
    4e54:	f80508e3          	beqz	a0,4de4 <pow+0xd4>
    4e58:	1a5020ef          	jal	ra,77fc <__errno>
    4e5c:	02200793          	li	a5,34
    4e60:	00f52023          	sw	a5,0(a0)
    4e64:	00000a13          	li	s4,0
    4e68:	00000a93          	li	s5,0
    4e6c:	f79ff06f          	j	4de4 <pow+0xd4>
    4e70:	00040513          	mv	a0,s0
    4e74:	00048593          	mv	a1,s1
    4e78:	7a8020ef          	jal	ra,7620 <__eqdf2>
    4e7c:	f60514e3          	bnez	a0,4de4 <pow+0xd4>
    4e80:	00003797          	auipc	a5,0x3
    4e84:	bc078793          	addi	a5,a5,-1088 # 7a40 <__clz_tab+0x104>
    4e88:	0007aa03          	lw	s4,0(a5)
    4e8c:	0047aa83          	lw	s5,4(a5)
    4e90:	f55ff06f          	j	4de4 <pow+0xd4>
    4e94:	00090513          	mv	a0,s2
    4e98:	00098593          	mv	a1,s3
    4e9c:	37c010ef          	jal	ra,6218 <finite>
    4ea0:	f80500e3          	beqz	a0,4e20 <pow+0x110>
    4ea4:	00040513          	mv	a0,s0
    4ea8:	00048593          	mv	a1,s1
    4eac:	36c010ef          	jal	ra,6218 <finite>
    4eb0:	f60508e3          	beqz	a0,4e20 <pow+0x110>
    4eb4:	000a0613          	mv	a2,s4
    4eb8:	000a8693          	mv	a3,s5
    4ebc:	000a0513          	mv	a0,s4
    4ec0:	000a8593          	mv	a1,s5
    4ec4:	0e5020ef          	jal	ra,77a8 <__unorddf2>
    4ec8:	08051663          	bnez	a0,4f54 <pow+0x244>
    4ecc:	131020ef          	jal	ra,77fc <__errno>
    4ed0:	02200793          	li	a5,34
    4ed4:	00f52023          	sw	a5,0(a0)
    4ed8:	00000613          	li	a2,0
    4edc:	00000693          	li	a3,0
    4ee0:	00090513          	mv	a0,s2
    4ee4:	00098593          	mv	a1,s3
    4ee8:	f90fe0ef          	jal	ra,3678 <__ledf2>
    4eec:	02054c63          	bltz	a0,4f24 <pow+0x214>
    4ef0:	00003797          	auipc	a5,0x3
    4ef4:	b6078793          	addi	a5,a5,-1184 # 7a50 <__clz_tab+0x114>
    4ef8:	0007aa03          	lw	s4,0(a5)
    4efc:	0047aa83          	lw	s5,4(a5)
    4f00:	ee5ff06f          	j	4de4 <pow+0xd4>
    4f04:	0f9020ef          	jal	ra,77fc <__errno>
    4f08:	02100793          	li	a5,33
    4f0c:	00f52023          	sw	a5,0(a0)
    4f10:	00003797          	auipc	a5,0x3
    4f14:	b3878793          	addi	a5,a5,-1224 # 7a48 <__clz_tab+0x10c>
    4f18:	0007aa03          	lw	s4,0(a5)
    4f1c:	0047aa83          	lw	s5,4(a5)
    4f20:	ec5ff06f          	j	4de4 <pow+0xd4>
    4f24:	00040513          	mv	a0,s0
    4f28:	00048593          	mv	a1,s1
    4f2c:	318010ef          	jal	ra,6244 <rint>
    4f30:	00040613          	mv	a2,s0
    4f34:	00048693          	mv	a3,s1
    4f38:	6e8020ef          	jal	ra,7620 <__eqdf2>
    4f3c:	fa050ae3          	beqz	a0,4ef0 <pow+0x1e0>
    4f40:	00003797          	auipc	a5,0x3
    4f44:	b0878793          	addi	a5,a5,-1272 # 7a48 <__clz_tab+0x10c>
    4f48:	0007aa03          	lw	s4,0(a5)
    4f4c:	0047aa83          	lw	s5,4(a5)
    4f50:	e95ff06f          	j	4de4 <pow+0xd4>
    4f54:	0a9020ef          	jal	ra,77fc <__errno>
    4f58:	02100793          	li	a5,33
    4f5c:	00000613          	li	a2,0
    4f60:	00000693          	li	a3,0
    4f64:	00f52023          	sw	a5,0(a0)
    4f68:	00068593          	mv	a1,a3
    4f6c:	00060513          	mv	a0,a2
    4f70:	735010ef          	jal	ra,6ea4 <__divdf3>
    4f74:	00050a13          	mv	s4,a0
    4f78:	00058a93          	mv	s5,a1
    4f7c:	e69ff06f          	j	4de4 <pow+0xd4>

00004f80 <__ieee754_pow>:
    4f80:	80000837          	lui	a6,0x80000
    4f84:	f8010113          	addi	sp,sp,-128
    4f88:	fff84813          	not	a6,a6
    4f8c:	07212823          	sw	s2,112(sp)
    4f90:	0106f933          	and	s2,a3,a6
    4f94:	06112e23          	sw	ra,124(sp)
    4f98:	06812c23          	sw	s0,120(sp)
    4f9c:	06912a23          	sw	s1,116(sp)
    4fa0:	07312623          	sw	s3,108(sp)
    4fa4:	07412423          	sw	s4,104(sp)
    4fa8:	07512223          	sw	s5,100(sp)
    4fac:	07612023          	sw	s6,96(sp)
    4fb0:	05712e23          	sw	s7,92(sp)
    4fb4:	05812c23          	sw	s8,88(sp)
    4fb8:	05912a23          	sw	s9,84(sp)
    4fbc:	05a12823          	sw	s10,80(sp)
    4fc0:	05b12623          	sw	s11,76(sp)
    4fc4:	00c967b3          	or	a5,s2,a2
    4fc8:	10078063          	beqz	a5,50c8 <__ieee754_pow+0x148>
    4fcc:	00b87433          	and	s0,a6,a1
    4fd0:	7ff007b7          	lui	a5,0x7ff00
    4fd4:	00058a93          	mv	s5,a1
    4fd8:	00050a13          	mv	s4,a0
    4fdc:	0487dc63          	bge	a5,s0,5034 <__ieee754_pow+0xb4>
    4fe0:	c0100837          	lui	a6,0xc0100
    4fe4:	01040833          	add	a6,s0,a6
    4fe8:	00a86833          	or	a6,a6,a0
    4fec:	3ff005b7          	lui	a1,0x3ff00
    4ff0:	00000513          	li	a0,0
    4ff4:	0e081463          	bnez	a6,50dc <__ieee754_pow+0x15c>
    4ff8:	07c12083          	lw	ra,124(sp)
    4ffc:	07812403          	lw	s0,120(sp)
    5000:	07412483          	lw	s1,116(sp)
    5004:	07012903          	lw	s2,112(sp)
    5008:	06c12983          	lw	s3,108(sp)
    500c:	06812a03          	lw	s4,104(sp)
    5010:	06412a83          	lw	s5,100(sp)
    5014:	06012b03          	lw	s6,96(sp)
    5018:	05c12b83          	lw	s7,92(sp)
    501c:	05812c03          	lw	s8,88(sp)
    5020:	05412c83          	lw	s9,84(sp)
    5024:	05012d03          	lw	s10,80(sp)
    5028:	04c12d83          	lw	s11,76(sp)
    502c:	08010113          	addi	sp,sp,128
    5030:	00008067          	ret
    5034:	0af40063          	beq	s0,a5,50d4 <__ieee754_pow+0x154>
    5038:	fb27c4e3          	blt	a5,s2,4fe0 <__ieee754_pow+0x60>
    503c:	7ff007b7          	lui	a5,0x7ff00
    5040:	24f90e63          	beq	s2,a5,529c <__ieee754_pow+0x31c>
    5044:	00058493          	mv	s1,a1
    5048:	00050993          	mv	s3,a0
    504c:	00060c93          	mv	s9,a2
    5050:	00068d93          	mv	s11,a3
    5054:	00000d13          	li	s10,0
    5058:	0c0ac463          	bltz	s5,5120 <__ieee754_pow+0x1a0>
    505c:	100c9463          	bnez	s9,5164 <__ieee754_pow+0x1e4>
    5060:	7ff006b7          	lui	a3,0x7ff00
    5064:	1ad90663          	beq	s2,a3,5210 <__ieee754_pow+0x290>
    5068:	3ff006b7          	lui	a3,0x3ff00
    506c:	1cd90a63          	beq	s2,a3,5240 <__ieee754_pow+0x2c0>
    5070:	400006b7          	lui	a3,0x40000
    5074:	60dd80e3          	beq	s11,a3,5e74 <__ieee754_pow+0xef4>
    5078:	3fe006b7          	lui	a3,0x3fe00
    507c:	0edd9463          	bne	s11,a3,5164 <__ieee754_pow+0x1e4>
    5080:	0e0ac263          	bltz	s5,5164 <__ieee754_pow+0x1e4>
    5084:	07812403          	lw	s0,120(sp)
    5088:	07c12083          	lw	ra,124(sp)
    508c:	07012903          	lw	s2,112(sp)
    5090:	06812a03          	lw	s4,104(sp)
    5094:	06412a83          	lw	s5,100(sp)
    5098:	06012b03          	lw	s6,96(sp)
    509c:	05c12b83          	lw	s7,92(sp)
    50a0:	05812c03          	lw	s8,88(sp)
    50a4:	05412c83          	lw	s9,84(sp)
    50a8:	05012d03          	lw	s10,80(sp)
    50ac:	04c12d83          	lw	s11,76(sp)
    50b0:	00098513          	mv	a0,s3
    50b4:	00048593          	mv	a1,s1
    50b8:	06c12983          	lw	s3,108(sp)
    50bc:	07412483          	lw	s1,116(sp)
    50c0:	08010113          	addi	sp,sp,128
    50c4:	6950006f          	j	5f58 <__ieee754_sqrt>
    50c8:	00000513          	li	a0,0
    50cc:	3ff005b7          	lui	a1,0x3ff00
    50d0:	f29ff06f          	j	4ff8 <__ieee754_pow+0x78>
    50d4:	00051463          	bnez	a0,50dc <__ieee754_pow+0x15c>
    50d8:	f72452e3          	bge	s0,s2,503c <__ieee754_pow+0xbc>
    50dc:	07812403          	lw	s0,120(sp)
    50e0:	07c12083          	lw	ra,124(sp)
    50e4:	07412483          	lw	s1,116(sp)
    50e8:	07012903          	lw	s2,112(sp)
    50ec:	06c12983          	lw	s3,108(sp)
    50f0:	06812a03          	lw	s4,104(sp)
    50f4:	06412a83          	lw	s5,100(sp)
    50f8:	06012b03          	lw	s6,96(sp)
    50fc:	05c12b83          	lw	s7,92(sp)
    5100:	05812c03          	lw	s8,88(sp)
    5104:	05412c83          	lw	s9,84(sp)
    5108:	05012d03          	lw	s10,80(sp)
    510c:	04c12d83          	lw	s11,76(sp)
    5110:	00002517          	auipc	a0,0x2
    5114:	7d450513          	addi	a0,a0,2004 # 78e4 <col+0xc4>
    5118:	08010113          	addi	sp,sp,128
    511c:	1140106f          	j	6230 <nan>
    5120:	434006b7          	lui	a3,0x43400
    5124:	18d95063          	bge	s2,a3,52a4 <__ieee754_pow+0x324>
    5128:	3ff006b7          	lui	a3,0x3ff00
    512c:	02d94a63          	blt	s2,a3,5160 <__ieee754_pow+0x1e0>
    5130:	41495693          	srai	a3,s2,0x14
    5134:	c0168693          	addi	a3,a3,-1023 # 3feffc01 <__freertos_irq_stack_top+0x3fcf6d31>
    5138:	01400613          	li	a2,20
    513c:	54d658e3          	bge	a2,a3,5e8c <__ieee754_pow+0xf0c>
    5140:	03400613          	li	a2,52
    5144:	40d606b3          	sub	a3,a2,a3
    5148:	00dcd633          	srl	a2,s9,a3
    514c:	00d616b3          	sll	a3,a2,a3
    5150:	01969863          	bne	a3,s9,5160 <__ieee754_pow+0x1e0>
    5154:	00167613          	andi	a2,a2,1
    5158:	00200313          	li	t1,2
    515c:	40c30d33          	sub	s10,t1,a2
    5160:	f00c84e3          	beqz	s9,5068 <__ieee754_pow+0xe8>
    5164:	00098513          	mv	a0,s3
    5168:	00048593          	mv	a1,s1
    516c:	0a0010ef          	jal	ra,620c <fabs>
    5170:	040a0c63          	beqz	s4,51c8 <__ieee754_pow+0x248>
    5174:	01f4de13          	srli	t3,s1,0x1f
    5178:	fffe0e13          	addi	t3,t3,-1
    517c:	01cd66b3          	or	a3,s10,t3
    5180:	12068663          	beqz	a3,52ac <__ieee754_pow+0x32c>
    5184:	41e006b7          	lui	a3,0x41e00
    5188:	1526d463          	bge	a3,s2,52d0 <__ieee754_pow+0x350>
    518c:	43f006b7          	lui	a3,0x43f00
    5190:	3526dce3          	bge	a3,s2,5ce8 <__ieee754_pow+0xd68>
    5194:	3ff00737          	lui	a4,0x3ff00
    5198:	0ce45a63          	bge	s0,a4,526c <__ieee754_pow+0x2ec>
    519c:	080ddc63          	bgez	s11,5234 <__ieee754_pow+0x2b4>
    51a0:	00003797          	auipc	a5,0x3
    51a4:	8d878793          	addi	a5,a5,-1832 # 7a78 <__clz_tab+0x13c>
    51a8:	0007a603          	lw	a2,0(a5)
    51ac:	0047a683          	lw	a3,4(a5)
    51b0:	00060513          	mv	a0,a2
    51b4:	00068593          	mv	a1,a3
    51b8:	dc0fe0ef          	jal	ra,3778 <__muldf3>
    51bc:	e3dff06f          	j	4ff8 <__ieee754_pow+0x78>
    51c0:	04c010ef          	jal	ra,620c <fabs>
    51c4:	0e0a1463          	bnez	s4,52ac <__ieee754_pow+0x32c>
    51c8:	00040a63          	beqz	s0,51dc <__ieee754_pow+0x25c>
    51cc:	00249693          	slli	a3,s1,0x2
    51d0:	0026d693          	srli	a3,a3,0x2
    51d4:	3ff00637          	lui	a2,0x3ff00
    51d8:	f8c69ee3          	bne	a3,a2,5174 <__ieee754_pow+0x1f4>
    51dc:	080dcc63          	bltz	s11,5274 <__ieee754_pow+0x2f4>
    51e0:	e00adce3          	bgez	s5,4ff8 <__ieee754_pow+0x78>
    51e4:	c01007b7          	lui	a5,0xc0100
    51e8:	00f407b3          	add	a5,s0,a5
    51ec:	01a7e7b3          	or	a5,a5,s10
    51f0:	4e0796e3          	bnez	a5,5edc <__ieee754_pow+0xf5c>
    51f4:	00050613          	mv	a2,a0
    51f8:	00058693          	mv	a3,a1
    51fc:	bd1fe0ef          	jal	ra,3dcc <__subdf3>
    5200:	00050613          	mv	a2,a0
    5204:	00058693          	mv	a3,a1
    5208:	49d010ef          	jal	ra,6ea4 <__divdf3>
    520c:	dedff06f          	j	4ff8 <__ieee754_pow+0x78>
    5210:	c0100537          	lui	a0,0xc0100
    5214:	00a40533          	add	a0,s0,a0
    5218:	01356533          	or	a0,a0,s3
    521c:	ea0506e3          	beqz	a0,50c8 <__ieee754_pow+0x148>
    5220:	3ff00737          	lui	a4,0x3ff00
    5224:	2ae442e3          	blt	s0,a4,5cc8 <__ieee754_pow+0xd48>
    5228:	000d8593          	mv	a1,s11
    522c:	00000513          	li	a0,0
    5230:	dc0dd4e3          	bgez	s11,4ff8 <__ieee754_pow+0x78>
    5234:	00000513          	li	a0,0
    5238:	00000593          	li	a1,0
    523c:	dbdff06f          	j	4ff8 <__ieee754_pow+0x78>
    5240:	00098513          	mv	a0,s3
    5244:	00048593          	mv	a1,s1
    5248:	da0dd8e3          	bgez	s11,4ff8 <__ieee754_pow+0x78>
    524c:	00002797          	auipc	a5,0x2
    5250:	7f478793          	addi	a5,a5,2036 # 7a40 <__clz_tab+0x104>
    5254:	0007a503          	lw	a0,0(a5)
    5258:	0047a583          	lw	a1,4(a5)
    525c:	00098613          	mv	a2,s3
    5260:	00048693          	mv	a3,s1
    5264:	441010ef          	jal	ra,6ea4 <__divdf3>
    5268:	d91ff06f          	j	4ff8 <__ieee754_pow+0x78>
    526c:	f3b04ae3          	bgtz	s11,51a0 <__ieee754_pow+0x220>
    5270:	fc5ff06f          	j	5234 <__ieee754_pow+0x2b4>
    5274:	00002717          	auipc	a4,0x2
    5278:	7cc70713          	addi	a4,a4,1996 # 7a40 <__clz_tab+0x104>
    527c:	00050c93          	mv	s9,a0
    5280:	00058793          	mv	a5,a1
    5284:	00072503          	lw	a0,0(a4)
    5288:	00472583          	lw	a1,4(a4)
    528c:	000c8613          	mv	a2,s9
    5290:	00078693          	mv	a3,a5
    5294:	411010ef          	jal	ra,6ea4 <__divdf3>
    5298:	f49ff06f          	j	51e0 <__ieee754_pow+0x260>
    529c:	da0604e3          	beqz	a2,5044 <__ieee754_pow+0xc4>
    52a0:	d41ff06f          	j	4fe0 <__ieee754_pow+0x60>
    52a4:	00200d13          	li	s10,2
    52a8:	db5ff06f          	j	505c <__ieee754_pow+0xdc>
    52ac:	00098613          	mv	a2,s3
    52b0:	00048693          	mv	a3,s1
    52b4:	00098513          	mv	a0,s3
    52b8:	00048593          	mv	a1,s1
    52bc:	b11fe0ef          	jal	ra,3dcc <__subdf3>
    52c0:	00050613          	mv	a2,a0
    52c4:	00058693          	mv	a3,a1
    52c8:	3dd010ef          	jal	ra,6ea4 <__divdf3>
    52cc:	d2dff06f          	j	4ff8 <__ieee754_pow+0x78>
    52d0:	7ff006b7          	lui	a3,0x7ff00
    52d4:	0096f4b3          	and	s1,a3,s1
    52d8:	00000613          	li	a2,0
    52dc:	02049463          	bnez	s1,5304 <__ieee754_pow+0x384>
    52e0:	00002697          	auipc	a3,0x2
    52e4:	7d068693          	addi	a3,a3,2000 # 7ab0 <__clz_tab+0x174>
    52e8:	0006a603          	lw	a2,0(a3)
    52ec:	0046a683          	lw	a3,4(a3)
    52f0:	01c12423          	sw	t3,8(sp)
    52f4:	c84fe0ef          	jal	ra,3778 <__muldf3>
    52f8:	00812e03          	lw	t3,8(sp)
    52fc:	00058413          	mv	s0,a1
    5300:	fcb00613          	li	a2,-53
    5304:	001005b7          	lui	a1,0x100
    5308:	41445e93          	srai	t4,s0,0x14
    530c:	fff58813          	addi	a6,a1,-1 # fffff <_end+0xf712f>
    5310:	0003a6b7          	lui	a3,0x3a
    5314:	c01e8e93          	addi	t4,t4,-1023
    5318:	01047833          	and	a6,s0,a6
    531c:	3ff00c37          	lui	s8,0x3ff00
    5320:	88e68693          	addi	a3,a3,-1906 # 3988e <_end+0x309be>
    5324:	00ce8eb3          	add	t4,t4,a2
    5328:	01886c33          	or	s8,a6,s8
    532c:	1b06d8e3          	bge	a3,a6,5cdc <__ieee754_pow+0xd5c>
    5330:	000bb6b7          	lui	a3,0xbb
    5334:	67968693          	addi	a3,a3,1657 # bb679 <_end+0xb27a9>
    5338:	3b06dee3          	bge	a3,a6,5ef4 <__ieee754_pow+0xf74>
    533c:	00002a97          	auipc	s5,0x2
    5340:	704a8a93          	addi	s5,s5,1796 # 7a40 <__clz_tab+0x104>
    5344:	001e8e93          	addi	t4,t4,1
    5348:	40bc0c33          	sub	s8,s8,a1
    534c:	000aa783          	lw	a5,0(s5)
    5350:	004aa803          	lw	a6,4(s5)
    5354:	00012823          	sw	zero,16(sp)
    5358:	00012a23          	sw	zero,20(sp)
    535c:	02012c23          	sw	zero,56(sp)
    5360:	02012e23          	sw	zero,60(sp)
    5364:	00000993          	li	s3,0
    5368:	00f12423          	sw	a5,8(sp)
    536c:	01012623          	sw	a6,12(sp)
    5370:	00812403          	lw	s0,8(sp)
    5374:	00c12483          	lw	s1,12(sp)
    5378:	000c0593          	mv	a1,s8
    537c:	00040613          	mv	a2,s0
    5380:	00048693          	mv	a3,s1
    5384:	03d12a23          	sw	t4,52(sp)
    5388:	03c12823          	sw	t3,48(sp)
    538c:	00050913          	mv	s2,a0
    5390:	a3dfe0ef          	jal	ra,3dcc <__subdf3>
    5394:	00050b13          	mv	s6,a0
    5398:	00058b93          	mv	s7,a1
    539c:	00040613          	mv	a2,s0
    53a0:	00048693          	mv	a3,s1
    53a4:	00090513          	mv	a0,s2
    53a8:	000c0593          	mv	a1,s8
    53ac:	00812423          	sw	s0,8(sp)
    53b0:	00912623          	sw	s1,12(sp)
    53b4:	26c010ef          	jal	ra,6620 <__adddf3>
    53b8:	00050613          	mv	a2,a0
    53bc:	00058693          	mv	a3,a1
    53c0:	000aa503          	lw	a0,0(s5)
    53c4:	004aa583          	lw	a1,4(s5)
    53c8:	00000493          	li	s1,0
    53cc:	2d9010ef          	jal	ra,6ea4 <__divdf3>
    53d0:	00050613          	mv	a2,a0
    53d4:	00058693          	mv	a3,a1
    53d8:	00a12c23          	sw	a0,24(sp)
    53dc:	00b12e23          	sw	a1,28(sp)
    53e0:	000b0513          	mv	a0,s6
    53e4:	000b8593          	mv	a1,s7
    53e8:	b90fe0ef          	jal	ra,3778 <__muldf3>
    53ec:	401c5f13          	srai	t5,s8,0x1
    53f0:	200006b7          	lui	a3,0x20000
    53f4:	00df6f33          	or	t5,t5,a3
    53f8:	000806b7          	lui	a3,0x80
    53fc:	00df0f33          	add	t5,t5,a3
    5400:	013f09b3          	add	s3,t5,s3
    5404:	00050a13          	mv	s4,a0
    5408:	00098693          	mv	a3,s3
    540c:	00000613          	li	a2,0
    5410:	00048513          	mv	a0,s1
    5414:	00058413          	mv	s0,a1
    5418:	b60fe0ef          	jal	ra,3778 <__muldf3>
    541c:	00050613          	mv	a2,a0
    5420:	00058693          	mv	a3,a1
    5424:	000b0513          	mv	a0,s6
    5428:	000b8593          	mv	a1,s7
    542c:	9a1fe0ef          	jal	ra,3dcc <__subdf3>
    5430:	00812603          	lw	a2,8(sp)
    5434:	00c12683          	lw	a3,12(sp)
    5438:	00050b13          	mv	s6,a0
    543c:	00058b93          	mv	s7,a1
    5440:	00000513          	li	a0,0
    5444:	00098593          	mv	a1,s3
    5448:	985fe0ef          	jal	ra,3dcc <__subdf3>
    544c:	00050613          	mv	a2,a0
    5450:	00058693          	mv	a3,a1
    5454:	00090513          	mv	a0,s2
    5458:	000c0593          	mv	a1,s8
    545c:	971fe0ef          	jal	ra,3dcc <__subdf3>
    5460:	00048613          	mv	a2,s1
    5464:	00040693          	mv	a3,s0
    5468:	b10fe0ef          	jal	ra,3778 <__muldf3>
    546c:	00050613          	mv	a2,a0
    5470:	00058693          	mv	a3,a1
    5474:	000b0513          	mv	a0,s6
    5478:	000b8593          	mv	a1,s7
    547c:	951fe0ef          	jal	ra,3dcc <__subdf3>
    5480:	01812803          	lw	a6,24(sp)
    5484:	01c12883          	lw	a7,28(sp)
    5488:	00002b97          	auipc	s7,0x2
    548c:	660b8b93          	addi	s7,s7,1632 # 7ae8 <__clz_tab+0x1ac>
    5490:	00080613          	mv	a2,a6
    5494:	00088693          	mv	a3,a7
    5498:	ae0fe0ef          	jal	ra,3778 <__muldf3>
    549c:	000a0613          	mv	a2,s4
    54a0:	00040693          	mv	a3,s0
    54a4:	00a12423          	sw	a0,8(sp)
    54a8:	00b12623          	sw	a1,12(sp)
    54ac:	000a0513          	mv	a0,s4
    54b0:	00040593          	mv	a1,s0
    54b4:	ac4fe0ef          	jal	ra,3778 <__muldf3>
    54b8:	00002697          	auipc	a3,0x2
    54bc:	60068693          	addi	a3,a3,1536 # 7ab8 <__clz_tab+0x17c>
    54c0:	0006a603          	lw	a2,0(a3)
    54c4:	0046a683          	lw	a3,4(a3)
    54c8:	00050913          	mv	s2,a0
    54cc:	00058993          	mv	s3,a1
    54d0:	aa8fe0ef          	jal	ra,3778 <__muldf3>
    54d4:	00002697          	auipc	a3,0x2
    54d8:	5ec68693          	addi	a3,a3,1516 # 7ac0 <__clz_tab+0x184>
    54dc:	0006a603          	lw	a2,0(a3)
    54e0:	0046a683          	lw	a3,4(a3)
    54e4:	00000b13          	li	s6,0
    54e8:	00000c13          	li	s8,0
    54ec:	134010ef          	jal	ra,6620 <__adddf3>
    54f0:	00090613          	mv	a2,s2
    54f4:	00098693          	mv	a3,s3
    54f8:	a80fe0ef          	jal	ra,3778 <__muldf3>
    54fc:	00002697          	auipc	a3,0x2
    5500:	5cc68693          	addi	a3,a3,1484 # 7ac8 <__clz_tab+0x18c>
    5504:	0006a603          	lw	a2,0(a3)
    5508:	0046a683          	lw	a3,4(a3)
    550c:	114010ef          	jal	ra,6620 <__adddf3>
    5510:	00090613          	mv	a2,s2
    5514:	00098693          	mv	a3,s3
    5518:	a60fe0ef          	jal	ra,3778 <__muldf3>
    551c:	00002697          	auipc	a3,0x2
    5520:	5b468693          	addi	a3,a3,1460 # 7ad0 <__clz_tab+0x194>
    5524:	0006a603          	lw	a2,0(a3)
    5528:	0046a683          	lw	a3,4(a3)
    552c:	0f4010ef          	jal	ra,6620 <__adddf3>
    5530:	00090613          	mv	a2,s2
    5534:	00098693          	mv	a3,s3
    5538:	a40fe0ef          	jal	ra,3778 <__muldf3>
    553c:	00002697          	auipc	a3,0x2
    5540:	59c68693          	addi	a3,a3,1436 # 7ad8 <__clz_tab+0x19c>
    5544:	0006a603          	lw	a2,0(a3)
    5548:	0046a683          	lw	a3,4(a3)
    554c:	0d4010ef          	jal	ra,6620 <__adddf3>
    5550:	00090613          	mv	a2,s2
    5554:	00098693          	mv	a3,s3
    5558:	a20fe0ef          	jal	ra,3778 <__muldf3>
    555c:	00002697          	auipc	a3,0x2
    5560:	58468693          	addi	a3,a3,1412 # 7ae0 <__clz_tab+0x1a4>
    5564:	0006a603          	lw	a2,0(a3)
    5568:	0046a683          	lw	a3,4(a3)
    556c:	0b4010ef          	jal	ra,6620 <__adddf3>
    5570:	00090613          	mv	a2,s2
    5574:	00098693          	mv	a3,s3
    5578:	00a12c23          	sw	a0,24(sp)
    557c:	00b12e23          	sw	a1,28(sp)
    5580:	00090513          	mv	a0,s2
    5584:	00098593          	mv	a1,s3
    5588:	9f0fe0ef          	jal	ra,3778 <__muldf3>
    558c:	01812703          	lw	a4,24(sp)
    5590:	01c12783          	lw	a5,28(sp)
    5594:	00050613          	mv	a2,a0
    5598:	00058693          	mv	a3,a1
    559c:	00070513          	mv	a0,a4
    55a0:	00078593          	mv	a1,a5
    55a4:	9d4fe0ef          	jal	ra,3778 <__muldf3>
    55a8:	00050913          	mv	s2,a0
    55ac:	00058993          	mv	s3,a1
    55b0:	00048613          	mv	a2,s1
    55b4:	00040693          	mv	a3,s0
    55b8:	000a0513          	mv	a0,s4
    55bc:	00040593          	mv	a1,s0
    55c0:	060010ef          	jal	ra,6620 <__adddf3>
    55c4:	00812603          	lw	a2,8(sp)
    55c8:	00c12683          	lw	a3,12(sp)
    55cc:	9acfe0ef          	jal	ra,3778 <__muldf3>
    55d0:	00090613          	mv	a2,s2
    55d4:	00098693          	mv	a3,s3
    55d8:	048010ef          	jal	ra,6620 <__adddf3>
    55dc:	00050913          	mv	s2,a0
    55e0:	00058993          	mv	s3,a1
    55e4:	00048613          	mv	a2,s1
    55e8:	00040693          	mv	a3,s0
    55ec:	00048513          	mv	a0,s1
    55f0:	00040593          	mv	a1,s0
    55f4:	984fe0ef          	jal	ra,3778 <__muldf3>
    55f8:	000ba603          	lw	a2,0(s7)
    55fc:	004ba683          	lw	a3,4(s7)
    5600:	02a12423          	sw	a0,40(sp)
    5604:	02b12623          	sw	a1,44(sp)
    5608:	018010ef          	jal	ra,6620 <__adddf3>
    560c:	00090613          	mv	a2,s2
    5610:	00098693          	mv	a3,s3
    5614:	01212c23          	sw	s2,24(sp)
    5618:	01312e23          	sw	s3,28(sp)
    561c:	004010ef          	jal	ra,6620 <__adddf3>
    5620:	00058913          	mv	s2,a1
    5624:	000b0613          	mv	a2,s6
    5628:	00058693          	mv	a3,a1
    562c:	00048513          	mv	a0,s1
    5630:	00040593          	mv	a1,s0
    5634:	944fe0ef          	jal	ra,3778 <__muldf3>
    5638:	000ba603          	lw	a2,0(s7)
    563c:	004ba683          	lw	a3,4(s7)
    5640:	02a12023          	sw	a0,32(sp)
    5644:	02b12223          	sw	a1,36(sp)
    5648:	000b0513          	mv	a0,s6
    564c:	00090593          	mv	a1,s2
    5650:	f7cfe0ef          	jal	ra,3dcc <__subdf3>
    5654:	02812f03          	lw	t5,40(sp)
    5658:	02c12f83          	lw	t6,44(sp)
    565c:	000f0613          	mv	a2,t5
    5660:	000f8693          	mv	a3,t6
    5664:	f68fe0ef          	jal	ra,3dcc <__subdf3>
    5668:	00050613          	mv	a2,a0
    566c:	00058693          	mv	a3,a1
    5670:	01812503          	lw	a0,24(sp)
    5674:	01c12583          	lw	a1,28(sp)
    5678:	f54fe0ef          	jal	ra,3dcc <__subdf3>
    567c:	000a0613          	mv	a2,s4
    5680:	00040693          	mv	a3,s0
    5684:	8f4fe0ef          	jal	ra,3778 <__muldf3>
    5688:	00050413          	mv	s0,a0
    568c:	00058493          	mv	s1,a1
    5690:	00812503          	lw	a0,8(sp)
    5694:	00c12583          	lw	a1,12(sp)
    5698:	000b0613          	mv	a2,s6
    569c:	00090693          	mv	a3,s2
    56a0:	8d8fe0ef          	jal	ra,3778 <__muldf3>
    56a4:	00050613          	mv	a2,a0
    56a8:	00058693          	mv	a3,a1
    56ac:	00040513          	mv	a0,s0
    56b0:	00048593          	mv	a1,s1
    56b4:	76d000ef          	jal	ra,6620 <__adddf3>
    56b8:	02012b03          	lw	s6,32(sp)
    56bc:	02412b83          	lw	s7,36(sp)
    56c0:	00050413          	mv	s0,a0
    56c4:	00058493          	mv	s1,a1
    56c8:	00050613          	mv	a2,a0
    56cc:	00058693          	mv	a3,a1
    56d0:	000b0513          	mv	a0,s6
    56d4:	000b8593          	mv	a1,s7
    56d8:	749000ef          	jal	ra,6620 <__adddf3>
    56dc:	00002697          	auipc	a3,0x2
    56e0:	41468693          	addi	a3,a3,1044 # 7af0 <__clz_tab+0x1b4>
    56e4:	0006a603          	lw	a2,0(a3)
    56e8:	0046a683          	lw	a3,4(a3)
    56ec:	000c0513          	mv	a0,s8
    56f0:	00058a13          	mv	s4,a1
    56f4:	884fe0ef          	jal	ra,3778 <__muldf3>
    56f8:	00050913          	mv	s2,a0
    56fc:	00058993          	mv	s3,a1
    5700:	000b0613          	mv	a2,s6
    5704:	000b8693          	mv	a3,s7
    5708:	000c0513          	mv	a0,s8
    570c:	000a0593          	mv	a1,s4
    5710:	ebcfe0ef          	jal	ra,3dcc <__subdf3>
    5714:	00050613          	mv	a2,a0
    5718:	00058693          	mv	a3,a1
    571c:	00040513          	mv	a0,s0
    5720:	00048593          	mv	a1,s1
    5724:	ea8fe0ef          	jal	ra,3dcc <__subdf3>
    5728:	00002697          	auipc	a3,0x2
    572c:	3d068693          	addi	a3,a3,976 # 7af8 <__clz_tab+0x1bc>
    5730:	0006a603          	lw	a2,0(a3)
    5734:	0046a683          	lw	a3,4(a3)
    5738:	840fe0ef          	jal	ra,3778 <__muldf3>
    573c:	00002697          	auipc	a3,0x2
    5740:	3c468693          	addi	a3,a3,964 # 7b00 <__clz_tab+0x1c4>
    5744:	0006a603          	lw	a2,0(a3)
    5748:	0046a683          	lw	a3,4(a3)
    574c:	00050413          	mv	s0,a0
    5750:	00058493          	mv	s1,a1
    5754:	000c0513          	mv	a0,s8
    5758:	000a0593          	mv	a1,s4
    575c:	81cfe0ef          	jal	ra,3778 <__muldf3>
    5760:	00050613          	mv	a2,a0
    5764:	00058693          	mv	a3,a1
    5768:	00040513          	mv	a0,s0
    576c:	00048593          	mv	a1,s1
    5770:	6b1000ef          	jal	ra,6620 <__adddf3>
    5774:	03812603          	lw	a2,56(sp)
    5778:	03c12683          	lw	a3,60(sp)
    577c:	6a5000ef          	jal	ra,6620 <__adddf3>
    5780:	03412e83          	lw	t4,52(sp)
    5784:	00050b13          	mv	s6,a0
    5788:	00058b93          	mv	s7,a1
    578c:	000e8513          	mv	a0,t4
    5790:	f3dfe0ef          	jal	ra,46cc <__floatsidf>
    5794:	00050413          	mv	s0,a0
    5798:	00058493          	mv	s1,a1
    579c:	000b0613          	mv	a2,s6
    57a0:	000b8693          	mv	a3,s7
    57a4:	00090513          	mv	a0,s2
    57a8:	00098593          	mv	a1,s3
    57ac:	675000ef          	jal	ra,6620 <__adddf3>
    57b0:	01012603          	lw	a2,16(sp)
    57b4:	01412683          	lw	a3,20(sp)
    57b8:	669000ef          	jal	ra,6620 <__adddf3>
    57bc:	00040613          	mv	a2,s0
    57c0:	00048693          	mv	a3,s1
    57c4:	65d000ef          	jal	ra,6620 <__adddf3>
    57c8:	00000613          	li	a2,0
    57cc:	00060513          	mv	a0,a2
    57d0:	00048693          	mv	a3,s1
    57d4:	00040613          	mv	a2,s0
    57d8:	00058493          	mv	s1,a1
    57dc:	00050413          	mv	s0,a0
    57e0:	decfe0ef          	jal	ra,3dcc <__subdf3>
    57e4:	01012603          	lw	a2,16(sp)
    57e8:	01412683          	lw	a3,20(sp)
    57ec:	de0fe0ef          	jal	ra,3dcc <__subdf3>
    57f0:	00090613          	mv	a2,s2
    57f4:	00098693          	mv	a3,s3
    57f8:	dd4fe0ef          	jal	ra,3dcc <__subdf3>
    57fc:	00050613          	mv	a2,a0
    5800:	00058693          	mv	a3,a1
    5804:	000b0513          	mv	a0,s6
    5808:	000b8593          	mv	a1,s7
    580c:	dc0fe0ef          	jal	ra,3dcc <__subdf3>
    5810:	03012e03          	lw	t3,48(sp)
    5814:	00050913          	mv	s2,a0
    5818:	00058993          	mv	s3,a1
    581c:	fffd0313          	addi	t1,s10,-1
    5820:	01c36e33          	or	t3,t1,t3
    5824:	480e1863          	bnez	t3,5cb4 <__ieee754_pow+0xd34>
    5828:	00002697          	auipc	a3,0x2
    582c:	24868693          	addi	a3,a3,584 # 7a70 <__clz_tab+0x134>
    5830:	0006a783          	lw	a5,0(a3)
    5834:	0046a803          	lw	a6,4(a3)
    5838:	00f12423          	sw	a5,8(sp)
    583c:	01012623          	sw	a6,12(sp)
    5840:	00000c13          	li	s8,0
    5844:	000c0613          	mv	a2,s8
    5848:	000d8693          	mv	a3,s11
    584c:	000c8513          	mv	a0,s9
    5850:	000d8593          	mv	a1,s11
    5854:	d78fe0ef          	jal	ra,3dcc <__subdf3>
    5858:	00040613          	mv	a2,s0
    585c:	00048693          	mv	a3,s1
    5860:	f19fd0ef          	jal	ra,3778 <__muldf3>
    5864:	00050b13          	mv	s6,a0
    5868:	00058b93          	mv	s7,a1
    586c:	000c8613          	mv	a2,s9
    5870:	000d8693          	mv	a3,s11
    5874:	00090513          	mv	a0,s2
    5878:	00098593          	mv	a1,s3
    587c:	efdfd0ef          	jal	ra,3778 <__muldf3>
    5880:	00050613          	mv	a2,a0
    5884:	00058693          	mv	a3,a1
    5888:	000b0513          	mv	a0,s6
    588c:	000b8593          	mv	a1,s7
    5890:	591000ef          	jal	ra,6620 <__adddf3>
    5894:	00050913          	mv	s2,a0
    5898:	00058993          	mv	s3,a1
    589c:	000c0613          	mv	a2,s8
    58a0:	000d8693          	mv	a3,s11
    58a4:	00040513          	mv	a0,s0
    58a8:	00048593          	mv	a1,s1
    58ac:	ecdfd0ef          	jal	ra,3778 <__muldf3>
    58b0:	00050613          	mv	a2,a0
    58b4:	00058693          	mv	a3,a1
    58b8:	00050413          	mv	s0,a0
    58bc:	00058493          	mv	s1,a1
    58c0:	00090513          	mv	a0,s2
    58c4:	00098593          	mv	a1,s3
    58c8:	559000ef          	jal	ra,6620 <__adddf3>
    58cc:	409007b7          	lui	a5,0x40900
    58d0:	00050a13          	mv	s4,a0
    58d4:	00058b13          	mv	s6,a1
    58d8:	00058b93          	mv	s7,a1
    58dc:	36f5c463          	blt	a1,a5,5c44 <__ieee754_pow+0xcc4>
    58e0:	40f587b3          	sub	a5,a1,a5
    58e4:	00a7e7b3          	or	a5,a5,a0
    58e8:	5e079463          	bnez	a5,5ed0 <__ieee754_pow+0xf50>
    58ec:	00002797          	auipc	a5,0x2
    58f0:	21c78793          	addi	a5,a5,540 # 7b08 <__clz_tab+0x1cc>
    58f4:	0007a603          	lw	a2,0(a5)
    58f8:	0047a683          	lw	a3,4(a5)
    58fc:	00090513          	mv	a0,s2
    5900:	00098593          	mv	a1,s3
    5904:	51d000ef          	jal	ra,6620 <__adddf3>
    5908:	00050d13          	mv	s10,a0
    590c:	00058d93          	mv	s11,a1
    5910:	00040613          	mv	a2,s0
    5914:	00048693          	mv	a3,s1
    5918:	000a0513          	mv	a0,s4
    591c:	000b0593          	mv	a1,s6
    5920:	cacfe0ef          	jal	ra,3dcc <__subdf3>
    5924:	00050613          	mv	a2,a0
    5928:	00058693          	mv	a3,a1
    592c:	000d0513          	mv	a0,s10
    5930:	000d8593          	mv	a1,s11
    5934:	579010ef          	jal	ra,76ac <__gedf2>
    5938:	58a04c63          	bgtz	a0,5ed0 <__ieee754_pow+0xf50>
    593c:	414bd793          	srai	a5,s7,0x14
    5940:	7ff7f793          	andi	a5,a5,2047
    5944:	00100537          	lui	a0,0x100
    5948:	c0278793          	addi	a5,a5,-1022
    594c:	40f557b3          	sra	a5,a0,a5
    5950:	017787b3          	add	a5,a5,s7
    5954:	4147d713          	srai	a4,a5,0x14
    5958:	7ff77713          	andi	a4,a4,2047
    595c:	c0170713          	addi	a4,a4,-1023
    5960:	fff50a13          	addi	s4,a0,-1 # fffff <_end+0xf712f>
    5964:	40ea55b3          	sra	a1,s4,a4
    5968:	fff5c593          	not	a1,a1
    596c:	00f5f5b3          	and	a1,a1,a5
    5970:	0147fa33          	and	s4,a5,s4
    5974:	01400793          	li	a5,20
    5978:	00aa6a33          	or	s4,s4,a0
    597c:	40e78733          	sub	a4,a5,a4
    5980:	00000613          	li	a2,0
    5984:	00058693          	mv	a3,a1
    5988:	40ea5a33          	sra	s4,s4,a4
    598c:	000bd463          	bgez	s7,5994 <__ieee754_pow+0xa14>
    5990:	41400a33          	neg	s4,s4
    5994:	00040513          	mv	a0,s0
    5998:	00048593          	mv	a1,s1
    599c:	c30fe0ef          	jal	ra,3dcc <__subdf3>
    59a0:	00050613          	mv	a2,a0
    59a4:	00058693          	mv	a3,a1
    59a8:	00050413          	mv	s0,a0
    59ac:	00058493          	mv	s1,a1
    59b0:	00090513          	mv	a0,s2
    59b4:	00098593          	mv	a1,s3
    59b8:	469000ef          	jal	ra,6620 <__adddf3>
    59bc:	00058b13          	mv	s6,a1
    59c0:	014a1d93          	slli	s11,s4,0x14
    59c4:	00002717          	auipc	a4,0x2
    59c8:	15470713          	addi	a4,a4,340 # 7b18 <__clz_tab+0x1dc>
    59cc:	00072603          	lw	a2,0(a4)
    59d0:	00472683          	lw	a3,4(a4)
    59d4:	00000c13          	li	s8,0
    59d8:	000c0513          	mv	a0,s8
    59dc:	000b0593          	mv	a1,s6
    59e0:	d99fd0ef          	jal	ra,3778 <__muldf3>
    59e4:	000b0d13          	mv	s10,s6
    59e8:	00058b93          	mv	s7,a1
    59ec:	00050b13          	mv	s6,a0
    59f0:	00040613          	mv	a2,s0
    59f4:	00048693          	mv	a3,s1
    59f8:	000c0513          	mv	a0,s8
    59fc:	000d0593          	mv	a1,s10
    5a00:	bccfe0ef          	jal	ra,3dcc <__subdf3>
    5a04:	00050613          	mv	a2,a0
    5a08:	00058693          	mv	a3,a1
    5a0c:	00090513          	mv	a0,s2
    5a10:	00098593          	mv	a1,s3
    5a14:	bb8fe0ef          	jal	ra,3dcc <__subdf3>
    5a18:	00002717          	auipc	a4,0x2
    5a1c:	10870713          	addi	a4,a4,264 # 7b20 <__clz_tab+0x1e4>
    5a20:	00072603          	lw	a2,0(a4)
    5a24:	00472683          	lw	a3,4(a4)
    5a28:	d51fd0ef          	jal	ra,3778 <__muldf3>
    5a2c:	00002717          	auipc	a4,0x2
    5a30:	0fc70713          	addi	a4,a4,252 # 7b28 <__clz_tab+0x1ec>
    5a34:	00072603          	lw	a2,0(a4)
    5a38:	00472683          	lw	a3,4(a4)
    5a3c:	00050413          	mv	s0,a0
    5a40:	00058493          	mv	s1,a1
    5a44:	000c0513          	mv	a0,s8
    5a48:	000d0593          	mv	a1,s10
    5a4c:	d2dfd0ef          	jal	ra,3778 <__muldf3>
    5a50:	00050613          	mv	a2,a0
    5a54:	00058693          	mv	a3,a1
    5a58:	00040513          	mv	a0,s0
    5a5c:	00048593          	mv	a1,s1
    5a60:	3c1000ef          	jal	ra,6620 <__adddf3>
    5a64:	00050913          	mv	s2,a0
    5a68:	00058993          	mv	s3,a1
    5a6c:	00050613          	mv	a2,a0
    5a70:	00058693          	mv	a3,a1
    5a74:	000b0513          	mv	a0,s6
    5a78:	000b8593          	mv	a1,s7
    5a7c:	3a5000ef          	jal	ra,6620 <__adddf3>
    5a80:	000b0613          	mv	a2,s6
    5a84:	000b8693          	mv	a3,s7
    5a88:	00050413          	mv	s0,a0
    5a8c:	00058493          	mv	s1,a1
    5a90:	b3cfe0ef          	jal	ra,3dcc <__subdf3>
    5a94:	00050613          	mv	a2,a0
    5a98:	00058693          	mv	a3,a1
    5a9c:	00090513          	mv	a0,s2
    5aa0:	00098593          	mv	a1,s3
    5aa4:	b28fe0ef          	jal	ra,3dcc <__subdf3>
    5aa8:	00050b13          	mv	s6,a0
    5aac:	00058b93          	mv	s7,a1
    5ab0:	00040613          	mv	a2,s0
    5ab4:	00048693          	mv	a3,s1
    5ab8:	00040513          	mv	a0,s0
    5abc:	00048593          	mv	a1,s1
    5ac0:	cb9fd0ef          	jal	ra,3778 <__muldf3>
    5ac4:	00002797          	auipc	a5,0x2
    5ac8:	06c78793          	addi	a5,a5,108 # 7b30 <__clz_tab+0x1f4>
    5acc:	0007a603          	lw	a2,0(a5)
    5ad0:	0047a683          	lw	a3,4(a5)
    5ad4:	00050913          	mv	s2,a0
    5ad8:	00058993          	mv	s3,a1
    5adc:	c9dfd0ef          	jal	ra,3778 <__muldf3>
    5ae0:	00002797          	auipc	a5,0x2
    5ae4:	05878793          	addi	a5,a5,88 # 7b38 <__clz_tab+0x1fc>
    5ae8:	0007a603          	lw	a2,0(a5)
    5aec:	0047a683          	lw	a3,4(a5)
    5af0:	adcfe0ef          	jal	ra,3dcc <__subdf3>
    5af4:	00090613          	mv	a2,s2
    5af8:	00098693          	mv	a3,s3
    5afc:	c7dfd0ef          	jal	ra,3778 <__muldf3>
    5b00:	00002797          	auipc	a5,0x2
    5b04:	04078793          	addi	a5,a5,64 # 7b40 <__clz_tab+0x204>
    5b08:	0007a603          	lw	a2,0(a5)
    5b0c:	0047a683          	lw	a3,4(a5)
    5b10:	311000ef          	jal	ra,6620 <__adddf3>
    5b14:	00090613          	mv	a2,s2
    5b18:	00098693          	mv	a3,s3
    5b1c:	c5dfd0ef          	jal	ra,3778 <__muldf3>
    5b20:	00002797          	auipc	a5,0x2
    5b24:	02878793          	addi	a5,a5,40 # 7b48 <__clz_tab+0x20c>
    5b28:	0007a603          	lw	a2,0(a5)
    5b2c:	0047a683          	lw	a3,4(a5)
    5b30:	a9cfe0ef          	jal	ra,3dcc <__subdf3>
    5b34:	00090613          	mv	a2,s2
    5b38:	00098693          	mv	a3,s3
    5b3c:	c3dfd0ef          	jal	ra,3778 <__muldf3>
    5b40:	00002797          	auipc	a5,0x2
    5b44:	01078793          	addi	a5,a5,16 # 7b50 <__clz_tab+0x214>
    5b48:	0007a603          	lw	a2,0(a5)
    5b4c:	0047a683          	lw	a3,4(a5)
    5b50:	2d1000ef          	jal	ra,6620 <__adddf3>
    5b54:	00090613          	mv	a2,s2
    5b58:	00098693          	mv	a3,s3
    5b5c:	c1dfd0ef          	jal	ra,3778 <__muldf3>
    5b60:	00050613          	mv	a2,a0
    5b64:	00058693          	mv	a3,a1
    5b68:	00040513          	mv	a0,s0
    5b6c:	00048593          	mv	a1,s1
    5b70:	a5cfe0ef          	jal	ra,3dcc <__subdf3>
    5b74:	00050613          	mv	a2,a0
    5b78:	00058693          	mv	a3,a1
    5b7c:	00050c13          	mv	s8,a0
    5b80:	00058c93          	mv	s9,a1
    5b84:	00040513          	mv	a0,s0
    5b88:	00048593          	mv	a1,s1
    5b8c:	bedfd0ef          	jal	ra,3778 <__muldf3>
    5b90:	00002697          	auipc	a3,0x2
    5b94:	fc868693          	addi	a3,a3,-56 # 7b58 <__clz_tab+0x21c>
    5b98:	0006a603          	lw	a2,0(a3)
    5b9c:	0046a683          	lw	a3,4(a3)
    5ba0:	00050913          	mv	s2,a0
    5ba4:	00058993          	mv	s3,a1
    5ba8:	000c0513          	mv	a0,s8
    5bac:	000c8593          	mv	a1,s9
    5bb0:	a1cfe0ef          	jal	ra,3dcc <__subdf3>
    5bb4:	00050613          	mv	a2,a0
    5bb8:	00058693          	mv	a3,a1
    5bbc:	00090513          	mv	a0,s2
    5bc0:	00098593          	mv	a1,s3
    5bc4:	2e0010ef          	jal	ra,6ea4 <__divdf3>
    5bc8:	00050913          	mv	s2,a0
    5bcc:	00058993          	mv	s3,a1
    5bd0:	000b0613          	mv	a2,s6
    5bd4:	000b8693          	mv	a3,s7
    5bd8:	00040513          	mv	a0,s0
    5bdc:	00048593          	mv	a1,s1
    5be0:	b99fd0ef          	jal	ra,3778 <__muldf3>
    5be4:	000b0613          	mv	a2,s6
    5be8:	000b8693          	mv	a3,s7
    5bec:	235000ef          	jal	ra,6620 <__adddf3>
    5bf0:	00050613          	mv	a2,a0
    5bf4:	00058693          	mv	a3,a1
    5bf8:	00090513          	mv	a0,s2
    5bfc:	00098593          	mv	a1,s3
    5c00:	9ccfe0ef          	jal	ra,3dcc <__subdf3>
    5c04:	00040613          	mv	a2,s0
    5c08:	00048693          	mv	a3,s1
    5c0c:	9c0fe0ef          	jal	ra,3dcc <__subdf3>
    5c10:	00058693          	mv	a3,a1
    5c14:	00050613          	mv	a2,a0
    5c18:	004aa583          	lw	a1,4(s5)
    5c1c:	000aa503          	lw	a0,0(s5)
    5c20:	9acfe0ef          	jal	ra,3dcc <__subdf3>
    5c24:	00bd87b3          	add	a5,s11,a1
    5c28:	4147d693          	srai	a3,a5,0x14
    5c2c:	32d05063          	blez	a3,5f4c <__ieee754_pow+0xfcc>
    5c30:	00078593          	mv	a1,a5
    5c34:	00812603          	lw	a2,8(sp)
    5c38:	00c12683          	lw	a3,12(sp)
    5c3c:	b3dfd0ef          	jal	ra,3778 <__muldf3>
    5c40:	bb8ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5c44:	00159793          	slli	a5,a1,0x1
    5c48:	4090d6b7          	lui	a3,0x4090d
    5c4c:	0017d793          	srli	a5,a5,0x1
    5c50:	bff68693          	addi	a3,a3,-1025 # 4090cbff <__freertos_irq_stack_top+0x40703d2f>
    5c54:	26f6d263          	bge	a3,a5,5eb8 <__ieee754_pow+0xf38>
    5c58:	3f6f37b7          	lui	a5,0x3f6f3
    5c5c:	40078793          	addi	a5,a5,1024 # 3f6f3400 <__freertos_irq_stack_top+0x3f4ea530>
    5c60:	00f587b3          	add	a5,a1,a5
    5c64:	00a7e7b3          	or	a5,a5,a0
    5c68:	02079063          	bnez	a5,5c88 <__ieee754_pow+0xd08>
    5c6c:	00040613          	mv	a2,s0
    5c70:	00048693          	mv	a3,s1
    5c74:	958fe0ef          	jal	ra,3dcc <__subdf3>
    5c78:	00090613          	mv	a2,s2
    5c7c:	00098693          	mv	a3,s3
    5c80:	22d010ef          	jal	ra,76ac <__gedf2>
    5c84:	ca054ce3          	bltz	a0,593c <__ieee754_pow+0x9bc>
    5c88:	00002417          	auipc	s0,0x2
    5c8c:	e8840413          	addi	s0,s0,-376 # 7b10 <__clz_tab+0x1d4>
    5c90:	00042603          	lw	a2,0(s0)
    5c94:	00442683          	lw	a3,4(s0)
    5c98:	00812503          	lw	a0,8(sp)
    5c9c:	00c12583          	lw	a1,12(sp)
    5ca0:	ad9fd0ef          	jal	ra,3778 <__muldf3>
    5ca4:	00042603          	lw	a2,0(s0)
    5ca8:	00442683          	lw	a3,4(s0)
    5cac:	acdfd0ef          	jal	ra,3778 <__muldf3>
    5cb0:	b48ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5cb4:	000aa783          	lw	a5,0(s5)
    5cb8:	004aa803          	lw	a6,4(s5)
    5cbc:	00f12423          	sw	a5,8(sp)
    5cc0:	01012623          	sw	a6,12(sp)
    5cc4:	b7dff06f          	j	5840 <__ieee754_pow+0x8c0>
    5cc8:	d60dd663          	bgez	s11,5234 <__ieee754_pow+0x2b4>
    5ccc:	800005b7          	lui	a1,0x80000
    5cd0:	00000513          	li	a0,0
    5cd4:	01b5c5b3          	xor	a1,a1,s11
    5cd8:	b20ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5cdc:	00002a97          	auipc	s5,0x2
    5ce0:	d64a8a93          	addi	s5,s5,-668 # 7a40 <__clz_tab+0x104>
    5ce4:	e68ff06f          	j	534c <__ieee754_pow+0x3cc>
    5ce8:	3ff006b7          	lui	a3,0x3ff00
    5cec:	ffe68613          	addi	a2,a3,-2 # 3feffffe <__freertos_irq_stack_top+0x3fcf712e>
    5cf0:	ca865663          	bge	a2,s0,519c <__ieee754_pow+0x21c>
    5cf4:	d686cc63          	blt	a3,s0,526c <__ieee754_pow+0x2ec>
    5cf8:	00002a97          	auipc	s5,0x2
    5cfc:	d48a8a93          	addi	s5,s5,-696 # 7a40 <__clz_tab+0x104>
    5d00:	000aa603          	lw	a2,0(s5)
    5d04:	004aa683          	lw	a3,4(s5)
    5d08:	01c12823          	sw	t3,16(sp)
    5d0c:	8c0fe0ef          	jal	ra,3dcc <__subdf3>
    5d10:	00002697          	auipc	a3,0x2
    5d14:	d7068693          	addi	a3,a3,-656 # 7a80 <__clz_tab+0x144>
    5d18:	0006a603          	lw	a2,0(a3)
    5d1c:	0046a683          	lw	a3,4(a3)
    5d20:	00050413          	mv	s0,a0
    5d24:	00058493          	mv	s1,a1
    5d28:	a51fd0ef          	jal	ra,3778 <__muldf3>
    5d2c:	00002697          	auipc	a3,0x2
    5d30:	d5c68693          	addi	a3,a3,-676 # 7a88 <__clz_tab+0x14c>
    5d34:	0006a603          	lw	a2,0(a3)
    5d38:	0046a683          	lw	a3,4(a3)
    5d3c:	00050913          	mv	s2,a0
    5d40:	00058993          	mv	s3,a1
    5d44:	00040513          	mv	a0,s0
    5d48:	00048593          	mv	a1,s1
    5d4c:	a2dfd0ef          	jal	ra,3778 <__muldf3>
    5d50:	00002697          	auipc	a3,0x2
    5d54:	d4068693          	addi	a3,a3,-704 # 7a90 <__clz_tab+0x154>
    5d58:	0006a603          	lw	a2,0(a3)
    5d5c:	0046a683          	lw	a3,4(a3)
    5d60:	00a12423          	sw	a0,8(sp)
    5d64:	00b12623          	sw	a1,12(sp)
    5d68:	00040513          	mv	a0,s0
    5d6c:	00048593          	mv	a1,s1
    5d70:	a09fd0ef          	jal	ra,3778 <__muldf3>
    5d74:	00058693          	mv	a3,a1
    5d78:	00002597          	auipc	a1,0x2
    5d7c:	d2058593          	addi	a1,a1,-736 # 7a98 <__clz_tab+0x15c>
    5d80:	00050613          	mv	a2,a0
    5d84:	0005a503          	lw	a0,0(a1)
    5d88:	0045a583          	lw	a1,4(a1)
    5d8c:	840fe0ef          	jal	ra,3dcc <__subdf3>
    5d90:	00040613          	mv	a2,s0
    5d94:	00048693          	mv	a3,s1
    5d98:	9e1fd0ef          	jal	ra,3778 <__muldf3>
    5d9c:	00058693          	mv	a3,a1
    5da0:	00002597          	auipc	a1,0x2
    5da4:	d0058593          	addi	a1,a1,-768 # 7aa0 <__clz_tab+0x164>
    5da8:	00050613          	mv	a2,a0
    5dac:	0005a503          	lw	a0,0(a1)
    5db0:	0045a583          	lw	a1,4(a1)
    5db4:	818fe0ef          	jal	ra,3dcc <__subdf3>
    5db8:	00050b13          	mv	s6,a0
    5dbc:	00058b93          	mv	s7,a1
    5dc0:	00040613          	mv	a2,s0
    5dc4:	00048693          	mv	a3,s1
    5dc8:	00040513          	mv	a0,s0
    5dcc:	00048593          	mv	a1,s1
    5dd0:	9a9fd0ef          	jal	ra,3778 <__muldf3>
    5dd4:	00050613          	mv	a2,a0
    5dd8:	00058693          	mv	a3,a1
    5ddc:	000b0513          	mv	a0,s6
    5de0:	000b8593          	mv	a1,s7
    5de4:	995fd0ef          	jal	ra,3778 <__muldf3>
    5de8:	00002697          	auipc	a3,0x2
    5dec:	cc068693          	addi	a3,a3,-832 # 7aa8 <__clz_tab+0x16c>
    5df0:	0006a603          	lw	a2,0(a3)
    5df4:	0046a683          	lw	a3,4(a3)
    5df8:	981fd0ef          	jal	ra,3778 <__muldf3>
    5dfc:	00812703          	lw	a4,8(sp)
    5e00:	00c12783          	lw	a5,12(sp)
    5e04:	00050613          	mv	a2,a0
    5e08:	00058693          	mv	a3,a1
    5e0c:	00070513          	mv	a0,a4
    5e10:	00078593          	mv	a1,a5
    5e14:	fb9fd0ef          	jal	ra,3dcc <__subdf3>
    5e18:	00050613          	mv	a2,a0
    5e1c:	00058693          	mv	a3,a1
    5e20:	00050b13          	mv	s6,a0
    5e24:	00058b93          	mv	s7,a1
    5e28:	00090513          	mv	a0,s2
    5e2c:	00098593          	mv	a1,s3
    5e30:	7f0000ef          	jal	ra,6620 <__adddf3>
    5e34:	00000613          	li	a2,0
    5e38:	00098693          	mv	a3,s3
    5e3c:	00060513          	mv	a0,a2
    5e40:	00060413          	mv	s0,a2
    5e44:	00090613          	mv	a2,s2
    5e48:	00058493          	mv	s1,a1
    5e4c:	f81fd0ef          	jal	ra,3dcc <__subdf3>
    5e50:	00050613          	mv	a2,a0
    5e54:	00058693          	mv	a3,a1
    5e58:	000b0513          	mv	a0,s6
    5e5c:	000b8593          	mv	a1,s7
    5e60:	f6dfd0ef          	jal	ra,3dcc <__subdf3>
    5e64:	00050913          	mv	s2,a0
    5e68:	00058993          	mv	s3,a1
    5e6c:	01012e03          	lw	t3,16(sp)
    5e70:	9adff06f          	j	581c <__ieee754_pow+0x89c>
    5e74:	00098613          	mv	a2,s3
    5e78:	00098513          	mv	a0,s3
    5e7c:	00048693          	mv	a3,s1
    5e80:	00048593          	mv	a1,s1
    5e84:	8f5fd0ef          	jal	ra,3778 <__muldf3>
    5e88:	970ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5e8c:	b20c9a63          	bnez	s9,51c0 <__ieee754_pow+0x240>
    5e90:	40d606b3          	sub	a3,a2,a3
    5e94:	40d95633          	sra	a2,s2,a3
    5e98:	00d616b3          	sll	a3,a2,a3
    5e9c:	000c8d13          	mv	s10,s9
    5ea0:	01268463          	beq	a3,s2,5ea8 <__ieee754_pow+0xf28>
    5ea4:	9c4ff06f          	j	5068 <__ieee754_pow+0xe8>
    5ea8:	00167613          	andi	a2,a2,1
    5eac:	00200313          	li	t1,2
    5eb0:	40c30d33          	sub	s10,t1,a2
    5eb4:	9b4ff06f          	j	5068 <__ieee754_pow+0xe8>
    5eb8:	3fe00737          	lui	a4,0x3fe00
    5ebc:	00000d93          	li	s11,0
    5ec0:	00000a13          	li	s4,0
    5ec4:	b0f750e3          	bge	a4,a5,59c4 <__ieee754_pow+0xa44>
    5ec8:	4147d793          	srai	a5,a5,0x14
    5ecc:	a79ff06f          	j	5944 <__ieee754_pow+0x9c4>
    5ed0:	00002417          	auipc	s0,0x2
    5ed4:	ba840413          	addi	s0,s0,-1112 # 7a78 <__clz_tab+0x13c>
    5ed8:	db9ff06f          	j	5c90 <__ieee754_pow+0xd10>
    5edc:	00100793          	li	a5,1
    5ee0:	00fd0463          	beq	s10,a5,5ee8 <__ieee754_pow+0xf68>
    5ee4:	914ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5ee8:	800007b7          	lui	a5,0x80000
    5eec:	00b7c5b3          	xor	a1,a5,a1
    5ef0:	908ff06f          	j	4ff8 <__ieee754_pow+0x78>
    5ef4:	00002697          	auipc	a3,0x2
    5ef8:	b6468693          	addi	a3,a3,-1180 # 7a58 <__clz_tab+0x11c>
    5efc:	0006a783          	lw	a5,0(a3)
    5f00:	0046a803          	lw	a6,4(a3)
    5f04:	00002697          	auipc	a3,0x2
    5f08:	b5c68693          	addi	a3,a3,-1188 # 7a60 <__clz_tab+0x124>
    5f0c:	00f12823          	sw	a5,16(sp)
    5f10:	01012a23          	sw	a6,20(sp)
    5f14:	0006a783          	lw	a5,0(a3)
    5f18:	0046a803          	lw	a6,4(a3)
    5f1c:	00002697          	auipc	a3,0x2
    5f20:	b4c68693          	addi	a3,a3,-1204 # 7a68 <__clz_tab+0x12c>
    5f24:	02f12c23          	sw	a5,56(sp)
    5f28:	03012e23          	sw	a6,60(sp)
    5f2c:	0006a783          	lw	a5,0(a3)
    5f30:	0046a803          	lw	a6,4(a3)
    5f34:	000409b7          	lui	s3,0x40
    5f38:	00f12423          	sw	a5,8(sp)
    5f3c:	01012623          	sw	a6,12(sp)
    5f40:	00002a97          	auipc	s5,0x2
    5f44:	b00a8a93          	addi	s5,s5,-1280 # 7a40 <__clz_tab+0x104>
    5f48:	c28ff06f          	j	5370 <__ieee754_pow+0x3f0>
    5f4c:	000a0613          	mv	a2,s4
    5f50:	518000ef          	jal	ra,6468 <scalbn>
    5f54:	ce1ff06f          	j	5c34 <__ieee754_pow+0xcb4>

00005f58 <__ieee754_sqrt>:
    5f58:	ff010113          	addi	sp,sp,-16
    5f5c:	7ff00737          	lui	a4,0x7ff00
    5f60:	00812423          	sw	s0,8(sp)
    5f64:	00912223          	sw	s1,4(sp)
    5f68:	00112623          	sw	ra,12(sp)
    5f6c:	00b77833          	and	a6,a4,a1
    5f70:	00058493          	mv	s1,a1
    5f74:	00050413          	mv	s0,a0
    5f78:	20e80863          	beq	a6,a4,6188 <__ieee754_sqrt+0x230>
    5f7c:	00058793          	mv	a5,a1
    5f80:	00050693          	mv	a3,a0
    5f84:	14b05a63          	blez	a1,60d8 <__ieee754_sqrt+0x180>
    5f88:	4145de13          	srai	t3,a1,0x14
    5f8c:	240e0e63          	beqz	t3,61e8 <__ieee754_sqrt+0x290>
    5f90:	00100737          	lui	a4,0x100
    5f94:	fff70613          	addi	a2,a4,-1 # fffff <_end+0xf712f>
    5f98:	00c7f7b3          	and	a5,a5,a2
    5f9c:	00e7e7b3          	or	a5,a5,a4
    5fa0:	c01e0e13          	addi	t3,t3,-1023
    5fa4:	00179713          	slli	a4,a5,0x1
    5fa8:	001e7613          	andi	a2,t3,1
    5fac:	01f6d793          	srli	a5,a3,0x1f
    5fb0:	00f707b3          	add	a5,a4,a5
    5fb4:	00169713          	slli	a4,a3,0x1
    5fb8:	00060a63          	beqz	a2,5fcc <__ieee754_sqrt+0x74>
    5fbc:	01f75713          	srli	a4,a4,0x1f
    5fc0:	00179793          	slli	a5,a5,0x1
    5fc4:	00e787b3          	add	a5,a5,a4
    5fc8:	00269713          	slli	a4,a3,0x2
    5fcc:	401e5e13          	srai	t3,t3,0x1
    5fd0:	01600593          	li	a1,22
    5fd4:	00000e93          	li	t4,0
    5fd8:	00000693          	li	a3,0
    5fdc:	00200637          	lui	a2,0x200
    5fe0:	00c68533          	add	a0,a3,a2
    5fe4:	01f75813          	srli	a6,a4,0x1f
    5fe8:	fff58593          	addi	a1,a1,-1
    5fec:	00a7c863          	blt	a5,a0,5ffc <__ieee754_sqrt+0xa4>
    5ff0:	40a787b3          	sub	a5,a5,a0
    5ff4:	00c506b3          	add	a3,a0,a2
    5ff8:	00ce8eb3          	add	t4,t4,a2
    5ffc:	00179793          	slli	a5,a5,0x1
    6000:	00f807b3          	add	a5,a6,a5
    6004:	00171713          	slli	a4,a4,0x1
    6008:	00165613          	srli	a2,a2,0x1
    600c:	fc059ae3          	bnez	a1,5fe0 <__ieee754_sqrt+0x88>
    6010:	00000313          	li	t1,0
    6014:	02000813          	li	a6,32
    6018:	80000637          	lui	a2,0x80000
    601c:	0240006f          	j	6040 <__ieee754_sqrt+0xe8>
    6020:	12d78e63          	beq	a5,a3,615c <__ieee754_sqrt+0x204>
    6024:	01f75513          	srli	a0,a4,0x1f
    6028:	00179793          	slli	a5,a5,0x1
    602c:	fff80813          	addi	a6,a6,-1 # c00fffff <__freertos_irq_stack_top+0xbfef712f>
    6030:	00a787b3          	add	a5,a5,a0
    6034:	00171713          	slli	a4,a4,0x1
    6038:	00165613          	srli	a2,a2,0x1
    603c:	04080663          	beqz	a6,6088 <__ieee754_sqrt+0x130>
    6040:	00b60533          	add	a0,a2,a1
    6044:	fcf6dee3          	bge	a3,a5,6020 <__ieee754_sqrt+0xc8>
    6048:	00c505b3          	add	a1,a0,a2
    604c:	00068893          	mv	a7,a3
    6050:	0e054e63          	bltz	a0,614c <__ieee754_sqrt+0x1f4>
    6054:	40d787b3          	sub	a5,a5,a3
    6058:	00a736b3          	sltu	a3,a4,a0
    605c:	40d787b3          	sub	a5,a5,a3
    6060:	40a70733          	sub	a4,a4,a0
    6064:	01f75513          	srli	a0,a4,0x1f
    6068:	00179793          	slli	a5,a5,0x1
    606c:	fff80813          	addi	a6,a6,-1
    6070:	00c30333          	add	t1,t1,a2
    6074:	00088693          	mv	a3,a7
    6078:	00a787b3          	add	a5,a5,a0
    607c:	00171713          	slli	a4,a4,0x1
    6080:	00165613          	srli	a2,a2,0x1
    6084:	fa081ee3          	bnez	a6,6040 <__ieee754_sqrt+0xe8>
    6088:	00e7e7b3          	or	a5,a5,a4
    608c:	0e079463          	bnez	a5,6174 <__ieee754_sqrt+0x21c>
    6090:	00135813          	srli	a6,t1,0x1
    6094:	401ed713          	srai	a4,t4,0x1
    6098:	3fe004b7          	lui	s1,0x3fe00
    609c:	001efe93          	andi	t4,t4,1
    60a0:	009704b3          	add	s1,a4,s1
    60a4:	000e8663          	beqz	t4,60b0 <__ieee754_sqrt+0x158>
    60a8:	800007b7          	lui	a5,0x80000
    60ac:	00f86833          	or	a6,a6,a5
    60b0:	014e1713          	slli	a4,t3,0x14
    60b4:	00080413          	mv	s0,a6
    60b8:	00970733          	add	a4,a4,s1
    60bc:	00040513          	mv	a0,s0
    60c0:	00c12083          	lw	ra,12(sp)
    60c4:	00812403          	lw	s0,8(sp)
    60c8:	00412483          	lw	s1,4(sp)
    60cc:	00070593          	mv	a1,a4
    60d0:	01010113          	addi	sp,sp,16
    60d4:	00008067          	ret
    60d8:	00159713          	slli	a4,a1,0x1
    60dc:	00175713          	srli	a4,a4,0x1
    60e0:	00a76833          	or	a6,a4,a0
    60e4:	00058713          	mv	a4,a1
    60e8:	fc080ae3          	beqz	a6,60bc <__ieee754_sqrt+0x164>
    60ec:	0c059c63          	bnez	a1,61c4 <__ieee754_sqrt+0x26c>
    60f0:	00b6d593          	srli	a1,a3,0xb
    60f4:	feb78793          	addi	a5,a5,-21 # 7fffffeb <__freertos_irq_stack_top+0x7fdf711b>
    60f8:	00058713          	mv	a4,a1
    60fc:	01569693          	slli	a3,a3,0x15
    6100:	fe0588e3          	beqz	a1,60f0 <__ieee754_sqrt+0x198>
    6104:	0145d613          	srli	a2,a1,0x14
    6108:	0e061a63          	bnez	a2,61fc <__ieee754_sqrt+0x2a4>
    610c:	00000613          	li	a2,0
    6110:	0080006f          	j	6118 <__ieee754_sqrt+0x1c0>
    6114:	00050613          	mv	a2,a0
    6118:	00171713          	slli	a4,a4,0x1
    611c:	00b71593          	slli	a1,a4,0xb
    6120:	00160513          	addi	a0,a2,1 # 80000001 <__freertos_irq_stack_top+0x7fdf7131>
    6124:	fe05d8e3          	bgez	a1,6114 <__ieee754_sqrt+0x1bc>
    6128:	02000893          	li	a7,32
    612c:	00068813          	mv	a6,a3
    6130:	40a888b3          	sub	a7,a7,a0
    6134:	00070593          	mv	a1,a4
    6138:	00a696b3          	sll	a3,a3,a0
    613c:	01185733          	srl	a4,a6,a7
    6140:	40c78e33          	sub	t3,a5,a2
    6144:	00b767b3          	or	a5,a4,a1
    6148:	e49ff06f          	j	5f90 <__ieee754_sqrt+0x38>
    614c:	fff5c893          	not	a7,a1
    6150:	01f8d893          	srli	a7,a7,0x1f
    6154:	011688b3          	add	a7,a3,a7
    6158:	efdff06f          	j	6054 <__ieee754_sqrt+0xfc>
    615c:	eca764e3          	bltu	a4,a0,6024 <__ieee754_sqrt+0xcc>
    6160:	00c505b3          	add	a1,a0,a2
    6164:	fe0544e3          	bltz	a0,614c <__ieee754_sqrt+0x1f4>
    6168:	00078893          	mv	a7,a5
    616c:	00000793          	li	a5,0
    6170:	ef1ff06f          	j	6060 <__ieee754_sqrt+0x108>
    6174:	fff00793          	li	a5,-1
    6178:	06f30e63          	beq	t1,a5,61f4 <__ieee754_sqrt+0x29c>
    617c:	00130813          	addi	a6,t1,1
    6180:	00185813          	srli	a6,a6,0x1
    6184:	f11ff06f          	j	6094 <__ieee754_sqrt+0x13c>
    6188:	00050613          	mv	a2,a0
    618c:	00058693          	mv	a3,a1
    6190:	de8fd0ef          	jal	ra,3778 <__muldf3>
    6194:	00040613          	mv	a2,s0
    6198:	00048693          	mv	a3,s1
    619c:	484000ef          	jal	ra,6620 <__adddf3>
    61a0:	00050413          	mv	s0,a0
    61a4:	00040513          	mv	a0,s0
    61a8:	00c12083          	lw	ra,12(sp)
    61ac:	00812403          	lw	s0,8(sp)
    61b0:	00058713          	mv	a4,a1
    61b4:	00412483          	lw	s1,4(sp)
    61b8:	00070593          	mv	a1,a4
    61bc:	01010113          	addi	sp,sp,16
    61c0:	00008067          	ret
    61c4:	00050613          	mv	a2,a0
    61c8:	00058693          	mv	a3,a1
    61cc:	c01fd0ef          	jal	ra,3dcc <__subdf3>
    61d0:	00050613          	mv	a2,a0
    61d4:	00058693          	mv	a3,a1
    61d8:	4cd000ef          	jal	ra,6ea4 <__divdf3>
    61dc:	00050413          	mv	s0,a0
    61e0:	00058713          	mv	a4,a1
    61e4:	ed9ff06f          	j	60bc <__ieee754_sqrt+0x164>
    61e8:	00058713          	mv	a4,a1
    61ec:	00000793          	li	a5,0
    61f0:	f1dff06f          	j	610c <__ieee754_sqrt+0x1b4>
    61f4:	001e8e93          	addi	t4,t4,1
    61f8:	e9dff06f          	j	6094 <__ieee754_sqrt+0x13c>
    61fc:	00068813          	mv	a6,a3
    6200:	02000893          	li	a7,32
    6204:	fff00613          	li	a2,-1
    6208:	f35ff06f          	j	613c <__ieee754_sqrt+0x1e4>

0000620c <fabs>:
    620c:	00159593          	slli	a1,a1,0x1
    6210:	0015d593          	srli	a1,a1,0x1
    6214:	00008067          	ret

00006218 <finite>:
    6218:	00159593          	slli	a1,a1,0x1
    621c:	0015d593          	srli	a1,a1,0x1
    6220:	80100537          	lui	a0,0x80100
    6224:	00a58533          	add	a0,a1,a0
    6228:	01f55513          	srli	a0,a0,0x1f
    622c:	00008067          	ret

00006230 <nan>:
    6230:	00002797          	auipc	a5,0x2
    6234:	93078793          	addi	a5,a5,-1744 # 7b60 <__clz_tab+0x224>
    6238:	0007a503          	lw	a0,0(a5)
    623c:	0047a583          	lw	a1,4(a5)
    6240:	00008067          	ret

00006244 <rint>:
    6244:	4145d713          	srai	a4,a1,0x14
    6248:	fd010113          	addi	sp,sp,-48
    624c:	7ff77713          	andi	a4,a4,2047
    6250:	02812423          	sw	s0,40(sp)
    6254:	02112623          	sw	ra,44(sp)
    6258:	02912223          	sw	s1,36(sp)
    625c:	03212023          	sw	s2,32(sp)
    6260:	01312e23          	sw	s3,28(sp)
    6264:	c0170613          	addi	a2,a4,-1023
    6268:	01300893          	li	a7,19
    626c:	00058793          	mv	a5,a1
    6270:	00050693          	mv	a3,a0
    6274:	00058e13          	mv	t3,a1
    6278:	01f5d413          	srli	s0,a1,0x1f
    627c:	16c8cc63          	blt	a7,a2,63f4 <rint+0x1b0>
    6280:	0c064863          	bltz	a2,6350 <rint+0x10c>
    6284:	001005b7          	lui	a1,0x100
    6288:	fff58593          	addi	a1,a1,-1 # fffff <_end+0xf712f>
    628c:	40c5d5b3          	sra	a1,a1,a2
    6290:	00f5f533          	and	a0,a1,a5
    6294:	00d56533          	or	a0,a0,a3
    6298:	00068893          	mv	a7,a3
    629c:	00078313          	mv	t1,a5
    62a0:	08050663          	beqz	a0,632c <rint+0xe8>
    62a4:	0015d593          	srli	a1,a1,0x1
    62a8:	00f5f833          	and	a6,a1,a5
    62ac:	00d86833          	or	a6,a6,a3
    62b0:	02080663          	beqz	a6,62dc <rint+0x98>
    62b4:	bee70693          	addi	a3,a4,-1042
    62b8:	00040e37          	lui	t3,0x40
    62bc:	0016b693          	seqz	a3,a3
    62c0:	fff5c593          	not	a1,a1
    62c4:	80000837          	lui	a6,0x80000
    62c8:	40d006b3          	neg	a3,a3
    62cc:	00f5f7b3          	and	a5,a1,a5
    62d0:	40ce5633          	sra	a2,t3,a2
    62d4:	00d87833          	and	a6,a6,a3
    62d8:	00c7ee33          	or	t3,a5,a2
    62dc:	00002797          	auipc	a5,0x2
    62e0:	88c78793          	addi	a5,a5,-1908 # 7b68 <TWO52>
    62e4:	00341313          	slli	t1,s0,0x3
    62e8:	00678333          	add	t1,a5,t1
    62ec:	00032403          	lw	s0,0(t1)
    62f0:	00432483          	lw	s1,4(t1)
    62f4:	00080613          	mv	a2,a6
    62f8:	000e0693          	mv	a3,t3
    62fc:	00040513          	mv	a0,s0
    6300:	00048593          	mv	a1,s1
    6304:	31c000ef          	jal	ra,6620 <__adddf3>
    6308:	00a12423          	sw	a0,8(sp)
    630c:	00b12623          	sw	a1,12(sp)
    6310:	00812503          	lw	a0,8(sp)
    6314:	00c12583          	lw	a1,12(sp)
    6318:	00040613          	mv	a2,s0
    631c:	00048693          	mv	a3,s1
    6320:	aadfd0ef          	jal	ra,3dcc <__subdf3>
    6324:	00050893          	mv	a7,a0
    6328:	00058313          	mv	t1,a1
    632c:	02c12083          	lw	ra,44(sp)
    6330:	02812403          	lw	s0,40(sp)
    6334:	02412483          	lw	s1,36(sp)
    6338:	02012903          	lw	s2,32(sp)
    633c:	01c12983          	lw	s3,28(sp)
    6340:	00088513          	mv	a0,a7
    6344:	00030593          	mv	a1,t1
    6348:	03010113          	addi	sp,sp,48
    634c:	00008067          	ret
    6350:	800004b7          	lui	s1,0x80000
    6354:	fff4c493          	not	s1,s1
    6358:	00b4f733          	and	a4,s1,a1
    635c:	00a76733          	or	a4,a4,a0
    6360:	00050893          	mv	a7,a0
    6364:	00058313          	mv	t1,a1
    6368:	fc0702e3          	beqz	a4,632c <rint+0xe8>
    636c:	00c59793          	slli	a5,a1,0xc
    6370:	00c7d793          	srli	a5,a5,0xc
    6374:	00a7e733          	or	a4,a5,a0
    6378:	40e007b3          	neg	a5,a4
    637c:	00e7e7b3          	or	a5,a5,a4
    6380:	00001697          	auipc	a3,0x1
    6384:	7e868693          	addi	a3,a3,2024 # 7b68 <TWO52>
    6388:	00341713          	slli	a4,s0,0x3
    638c:	00e686b3          	add	a3,a3,a4
    6390:	00c7d793          	srli	a5,a5,0xc
    6394:	0006a903          	lw	s2,0(a3)
    6398:	0046a983          	lw	s3,4(a3)
    639c:	fffe0737          	lui	a4,0xfffe0
    63a0:	00080337          	lui	t1,0x80
    63a4:	00b77733          	and	a4,a4,a1
    63a8:	0067f333          	and	t1,a5,t1
    63ac:	00e36333          	or	t1,t1,a4
    63b0:	00030693          	mv	a3,t1
    63b4:	00050613          	mv	a2,a0
    63b8:	00098593          	mv	a1,s3
    63bc:	00090513          	mv	a0,s2
    63c0:	260000ef          	jal	ra,6620 <__adddf3>
    63c4:	00a12423          	sw	a0,8(sp)
    63c8:	00b12623          	sw	a1,12(sp)
    63cc:	00812503          	lw	a0,8(sp)
    63d0:	00c12583          	lw	a1,12(sp)
    63d4:	00090613          	mv	a2,s2
    63d8:	00098693          	mv	a3,s3
    63dc:	9f1fd0ef          	jal	ra,3dcc <__subdf3>
    63e0:	00b4f4b3          	and	s1,s1,a1
    63e4:	01f41313          	slli	t1,s0,0x1f
    63e8:	0064e333          	or	t1,s1,t1
    63ec:	00050893          	mv	a7,a0
    63f0:	f3dff06f          	j	632c <rint+0xe8>
    63f4:	03300893          	li	a7,51
    63f8:	02c8d663          	bge	a7,a2,6424 <rint+0x1e0>
    63fc:	40000713          	li	a4,1024
    6400:	00050893          	mv	a7,a0
    6404:	00058313          	mv	t1,a1
    6408:	f2e612e3          	bne	a2,a4,632c <rint+0xe8>
    640c:	00050613          	mv	a2,a0
    6410:	000e0693          	mv	a3,t3
    6414:	20c000ef          	jal	ra,6620 <__adddf3>
    6418:	00050893          	mv	a7,a0
    641c:	00058313          	mv	t1,a1
    6420:	f0dff06f          	j	632c <rint+0xe8>
    6424:	bed70713          	addi	a4,a4,-1043 # fffdfbed <__freertos_irq_stack_top+0xffdd6d1d>
    6428:	fff00613          	li	a2,-1
    642c:	00e65633          	srl	a2,a2,a4
    6430:	00a675b3          	and	a1,a2,a0
    6434:	00050893          	mv	a7,a0
    6438:	00078313          	mv	t1,a5
    643c:	ee0588e3          	beqz	a1,632c <rint+0xe8>
    6440:	00165613          	srli	a2,a2,0x1
    6444:	00a677b3          	and	a5,a2,a0
    6448:	00050813          	mv	a6,a0
    644c:	e80788e3          	beqz	a5,62dc <rint+0x98>
    6450:	40000837          	lui	a6,0x40000
    6454:	fff64613          	not	a2,a2
    6458:	00a676b3          	and	a3,a2,a0
    645c:	40e85733          	sra	a4,a6,a4
    6460:	00e6e833          	or	a6,a3,a4
    6464:	e79ff06f          	j	62dc <rint+0x98>

00006468 <scalbn>:
    6468:	ff010113          	addi	sp,sp,-16
    646c:	4145d793          	srai	a5,a1,0x14
    6470:	00812423          	sw	s0,8(sp)
    6474:	00112623          	sw	ra,12(sp)
    6478:	7ff7f793          	andi	a5,a5,2047
    647c:	00060413          	mv	s0,a2
    6480:	0a079063          	bnez	a5,6520 <scalbn+0xb8>
    6484:	00159793          	slli	a5,a1,0x1
    6488:	0017d793          	srli	a5,a5,0x1
    648c:	00a7e7b3          	or	a5,a5,a0
    6490:	08078063          	beqz	a5,6510 <scalbn+0xa8>
    6494:	00001797          	auipc	a5,0x1
    6498:	6e478793          	addi	a5,a5,1764 # 7b78 <TWO52+0x10>
    649c:	0007a603          	lw	a2,0(a5)
    64a0:	0047a683          	lw	a3,4(a5)
    64a4:	ad4fd0ef          	jal	ra,3778 <__muldf3>
    64a8:	ffff47b7          	lui	a5,0xffff4
    64ac:	cb078793          	addi	a5,a5,-848 # ffff3cb0 <__freertos_irq_stack_top+0xffdeade0>
    64b0:	00058713          	mv	a4,a1
    64b4:	12f44a63          	blt	s0,a5,65e8 <scalbn+0x180>
    64b8:	4145d793          	srai	a5,a1,0x14
    64bc:	7ff7f793          	andi	a5,a5,2047
    64c0:	fca78793          	addi	a5,a5,-54
    64c4:	00f407b3          	add	a5,s0,a5
    64c8:	7fe00693          	li	a3,2046
    64cc:	06f6ce63          	blt	a3,a5,6548 <scalbn+0xe0>
    64d0:	0ef04a63          	bgtz	a5,65c4 <scalbn+0x15c>
    64d4:	fcb00693          	li	a3,-53
    64d8:	0ad7d663          	bge	a5,a3,6584 <scalbn+0x11c>
    64dc:	0000c7b7          	lui	a5,0xc
    64e0:	35078793          	addi	a5,a5,848 # c350 <_end+0x3480>
    64e4:	0687c263          	blt	a5,s0,6548 <scalbn+0xe0>
    64e8:	00001797          	auipc	a5,0x1
    64ec:	62878793          	addi	a5,a5,1576 # 7b10 <__clz_tab+0x1d4>
    64f0:	0007a803          	lw	a6,0(a5)
    64f4:	0047a883          	lw	a7,4(a5)
    64f8:	1005ca63          	bltz	a1,660c <scalbn+0x1a4>
    64fc:	0007a603          	lw	a2,0(a5)
    6500:	0047a683          	lw	a3,4(a5)
    6504:	00080513          	mv	a0,a6
    6508:	00088593          	mv	a1,a7
    650c:	a6cfd0ef          	jal	ra,3778 <__muldf3>
    6510:	00c12083          	lw	ra,12(sp)
    6514:	00812403          	lw	s0,8(sp)
    6518:	01010113          	addi	sp,sp,16
    651c:	00008067          	ret
    6520:	7ff00693          	li	a3,2047
    6524:	00058713          	mv	a4,a1
    6528:	f8d79ee3          	bne	a5,a3,64c4 <scalbn+0x5c>
    652c:	00050613          	mv	a2,a0
    6530:	00058693          	mv	a3,a1
    6534:	0ec000ef          	jal	ra,6620 <__adddf3>
    6538:	00c12083          	lw	ra,12(sp)
    653c:	00812403          	lw	s0,8(sp)
    6540:	01010113          	addi	sp,sp,16
    6544:	00008067          	ret
    6548:	00001797          	auipc	a5,0x1
    654c:	53078793          	addi	a5,a5,1328 # 7a78 <__clz_tab+0x13c>
    6550:	0007a803          	lw	a6,0(a5)
    6554:	0047a883          	lw	a7,4(a5)
    6558:	fa05d2e3          	bgez	a1,64fc <scalbn+0x94>
    655c:	00001717          	auipc	a4,0x1
    6560:	62470713          	addi	a4,a4,1572 # 7b80 <TWO52+0x18>
    6564:	00072803          	lw	a6,0(a4)
    6568:	00472883          	lw	a7,4(a4)
    656c:	0007a603          	lw	a2,0(a5)
    6570:	0047a683          	lw	a3,4(a5)
    6574:	00080513          	mv	a0,a6
    6578:	00088593          	mv	a1,a7
    657c:	9fcfd0ef          	jal	ra,3778 <__muldf3>
    6580:	f91ff06f          	j	6510 <scalbn+0xa8>
    6584:	801005b7          	lui	a1,0x80100
    6588:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef712f>
    658c:	03678793          	addi	a5,a5,54
    6590:	00b77733          	and	a4,a4,a1
    6594:	01479793          	slli	a5,a5,0x14
    6598:	00e7e7b3          	or	a5,a5,a4
    659c:	00001717          	auipc	a4,0x1
    65a0:	5f470713          	addi	a4,a4,1524 # 7b90 <TWO52+0x28>
    65a4:	00072603          	lw	a2,0(a4)
    65a8:	00472683          	lw	a3,4(a4)
    65ac:	00078593          	mv	a1,a5
    65b0:	9c8fd0ef          	jal	ra,3778 <__muldf3>
    65b4:	00c12083          	lw	ra,12(sp)
    65b8:	00812403          	lw	s0,8(sp)
    65bc:	01010113          	addi	sp,sp,16
    65c0:	00008067          	ret
    65c4:	00c12083          	lw	ra,12(sp)
    65c8:	00812403          	lw	s0,8(sp)
    65cc:	801005b7          	lui	a1,0x80100
    65d0:	fff58593          	addi	a1,a1,-1 # 800fffff <__freertos_irq_stack_top+0x7fef712f>
    65d4:	00b77733          	and	a4,a4,a1
    65d8:	01479593          	slli	a1,a5,0x14
    65dc:	00b765b3          	or	a1,a4,a1
    65e0:	01010113          	addi	sp,sp,16
    65e4:	00008067          	ret
    65e8:	00001697          	auipc	a3,0x1
    65ec:	52868693          	addi	a3,a3,1320 # 7b10 <__clz_tab+0x1d4>
    65f0:	0006a603          	lw	a2,0(a3)
    65f4:	0046a683          	lw	a3,4(a3)
    65f8:	980fd0ef          	jal	ra,3778 <__muldf3>
    65fc:	00c12083          	lw	ra,12(sp)
    6600:	00812403          	lw	s0,8(sp)
    6604:	01010113          	addi	sp,sp,16
    6608:	00008067          	ret
    660c:	00001717          	auipc	a4,0x1
    6610:	57c70713          	addi	a4,a4,1404 # 7b88 <TWO52+0x20>
    6614:	00072803          	lw	a6,0(a4)
    6618:	00472883          	lw	a7,4(a4)
    661c:	ee1ff06f          	j	64fc <scalbn+0x94>

00006620 <__adddf3>:
    6620:	00100837          	lui	a6,0x100
    6624:	fe010113          	addi	sp,sp,-32
    6628:	fff80813          	addi	a6,a6,-1 # fffff <_end+0xf712f>
    662c:	00b87733          	and	a4,a6,a1
    6630:	00912a23          	sw	s1,20(sp)
    6634:	00d87833          	and	a6,a6,a3
    6638:	0145d493          	srli	s1,a1,0x14
    663c:	0146d313          	srli	t1,a3,0x14
    6640:	00371e13          	slli	t3,a4,0x3
    6644:	01312623          	sw	s3,12(sp)
    6648:	01d55713          	srli	a4,a0,0x1d
    664c:	00381813          	slli	a6,a6,0x3
    6650:	01d65793          	srli	a5,a2,0x1d
    6654:	7ff4f493          	andi	s1,s1,2047
    6658:	7ff37313          	andi	t1,t1,2047
    665c:	00112e23          	sw	ra,28(sp)
    6660:	00812c23          	sw	s0,24(sp)
    6664:	01212823          	sw	s2,16(sp)
    6668:	01f5d993          	srli	s3,a1,0x1f
    666c:	01f6de93          	srli	t4,a3,0x1f
    6670:	01c76733          	or	a4,a4,t3
    6674:	00351f13          	slli	t5,a0,0x3
    6678:	0107e833          	or	a6,a5,a6
    667c:	00361f93          	slli	t6,a2,0x3
    6680:	40648e33          	sub	t3,s1,t1
    6684:	1dd98463          	beq	s3,t4,684c <__adddf3+0x22c>
    6688:	17c05863          	blez	t3,67f8 <__adddf3+0x1d8>
    668c:	20030a63          	beqz	t1,68a0 <__adddf3+0x280>
    6690:	008006b7          	lui	a3,0x800
    6694:	7ff00793          	li	a5,2047
    6698:	00d86833          	or	a6,a6,a3
    669c:	40f48e63          	beq	s1,a5,6ab8 <__adddf3+0x498>
    66a0:	03800793          	li	a5,56
    66a4:	3dc7ca63          	blt	a5,t3,6a78 <__adddf3+0x458>
    66a8:	01f00793          	li	a5,31
    66ac:	55c7c663          	blt	a5,t3,6bf8 <__adddf3+0x5d8>
    66b0:	02000513          	li	a0,32
    66b4:	41c50533          	sub	a0,a0,t3
    66b8:	01cfd7b3          	srl	a5,t6,t3
    66bc:	00a816b3          	sll	a3,a6,a0
    66c0:	00af9933          	sll	s2,t6,a0
    66c4:	00f6e6b3          	or	a3,a3,a5
    66c8:	01203933          	snez	s2,s2
    66cc:	01c857b3          	srl	a5,a6,t3
    66d0:	0126e933          	or	s2,a3,s2
    66d4:	40f70733          	sub	a4,a4,a5
    66d8:	412f0933          	sub	s2,t5,s2
    66dc:	012f37b3          	sltu	a5,t5,s2
    66e0:	40f70633          	sub	a2,a4,a5
    66e4:	00861793          	slli	a5,a2,0x8
    66e8:	2a07d263          	bgez	a5,698c <__adddf3+0x36c>
    66ec:	00800737          	lui	a4,0x800
    66f0:	fff70713          	addi	a4,a4,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    66f4:	00e67433          	and	s0,a2,a4
    66f8:	34040e63          	beqz	s0,6a54 <__adddf3+0x434>
    66fc:	00040513          	mv	a0,s0
    6700:	d7cfe0ef          	jal	ra,4c7c <__clzsi2>
    6704:	ff850713          	addi	a4,a0,-8 # 800ffff8 <__freertos_irq_stack_top+0x7fef7128>
    6708:	02000793          	li	a5,32
    670c:	40e787b3          	sub	a5,a5,a4
    6710:	00f957b3          	srl	a5,s2,a5
    6714:	00e41633          	sll	a2,s0,a4
    6718:	00c7e7b3          	or	a5,a5,a2
    671c:	00e91933          	sll	s2,s2,a4
    6720:	30974c63          	blt	a4,s1,6a38 <__adddf3+0x418>
    6724:	40970533          	sub	a0,a4,s1
    6728:	00150613          	addi	a2,a0,1
    672c:	01f00713          	li	a4,31
    6730:	44c74663          	blt	a4,a2,6b7c <__adddf3+0x55c>
    6734:	02000713          	li	a4,32
    6738:	40c70733          	sub	a4,a4,a2
    673c:	00c956b3          	srl	a3,s2,a2
    6740:	00e91933          	sll	s2,s2,a4
    6744:	00e79733          	sll	a4,a5,a4
    6748:	00d76733          	or	a4,a4,a3
    674c:	01203933          	snez	s2,s2
    6750:	01276933          	or	s2,a4,s2
    6754:	00c7d633          	srl	a2,a5,a2
    6758:	00000493          	li	s1,0
    675c:	00797793          	andi	a5,s2,7
    6760:	02078063          	beqz	a5,6780 <__adddf3+0x160>
    6764:	00f97713          	andi	a4,s2,15
    6768:	00400793          	li	a5,4
    676c:	00f70a63          	beq	a4,a5,6780 <__adddf3+0x160>
    6770:	00490713          	addi	a4,s2,4
    6774:	01273933          	sltu	s2,a4,s2
    6778:	01260633          	add	a2,a2,s2
    677c:	00070913          	mv	s2,a4
    6780:	00861793          	slli	a5,a2,0x8
    6784:	2007d863          	bgez	a5,6994 <__adddf3+0x374>
    6788:	00148513          	addi	a0,s1,1 # 80000001 <__freertos_irq_stack_top+0x7fdf7131>
    678c:	7ff00793          	li	a5,2047
    6790:	00098593          	mv	a1,s3
    6794:	24f50c63          	beq	a0,a5,69ec <__adddf3+0x3cc>
    6798:	ff8007b7          	lui	a5,0xff800
    679c:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    67a0:	00f677b3          	and	a5,a2,a5
    67a4:	01d79893          	slli	a7,a5,0x1d
    67a8:	00395913          	srli	s2,s2,0x3
    67ac:	00979793          	slli	a5,a5,0x9
    67b0:	0128e8b3          	or	a7,a7,s2
    67b4:	00c7d793          	srli	a5,a5,0xc
    67b8:	7ff57513          	andi	a0,a0,2047
    67bc:	00c79693          	slli	a3,a5,0xc
    67c0:	01451513          	slli	a0,a0,0x14
    67c4:	01c12083          	lw	ra,28(sp)
    67c8:	01812403          	lw	s0,24(sp)
    67cc:	00c6d693          	srli	a3,a3,0xc
    67d0:	01f59593          	slli	a1,a1,0x1f
    67d4:	00a6e6b3          	or	a3,a3,a0
    67d8:	00b6e6b3          	or	a3,a3,a1
    67dc:	01412483          	lw	s1,20(sp)
    67e0:	01012903          	lw	s2,16(sp)
    67e4:	00c12983          	lw	s3,12(sp)
    67e8:	00088513          	mv	a0,a7
    67ec:	00068593          	mv	a1,a3
    67f0:	02010113          	addi	sp,sp,32
    67f4:	00008067          	ret
    67f8:	0c0e1463          	bnez	t3,68c0 <__adddf3+0x2a0>
    67fc:	00148313          	addi	t1,s1,1
    6800:	7fe37313          	andi	t1,t1,2046
    6804:	28031063          	bnez	t1,6a84 <__adddf3+0x464>
    6808:	01e767b3          	or	a5,a4,t5
    680c:	01f868b3          	or	a7,a6,t6
    6810:	1e049663          	bnez	s1,69fc <__adddf3+0x3dc>
    6814:	4c078063          	beqz	a5,6cd4 <__adddf3+0x6b4>
    6818:	50088863          	beqz	a7,6d28 <__adddf3+0x708>
    681c:	41ff0933          	sub	s2,t5,t6
    6820:	410707b3          	sub	a5,a4,a6
    6824:	012f3633          	sltu	a2,t5,s2
    6828:	40c78633          	sub	a2,a5,a2
    682c:	00861793          	slli	a5,a2,0x8
    6830:	5a07d463          	bgez	a5,6dd8 <__adddf3+0x7b8>
    6834:	41ef8933          	sub	s2,t6,t5
    6838:	40e807b3          	sub	a5,a6,a4
    683c:	012fb633          	sltu	a2,t6,s2
    6840:	40c78633          	sub	a2,a5,a2
    6844:	000e8993          	mv	s3,t4
    6848:	f15ff06f          	j	675c <__adddf3+0x13c>
    684c:	0fc05a63          	blez	t3,6940 <__adddf3+0x320>
    6850:	0c030863          	beqz	t1,6920 <__adddf3+0x300>
    6854:	008006b7          	lui	a3,0x800
    6858:	7ff00793          	li	a5,2047
    685c:	00d86833          	or	a6,a6,a3
    6860:	44f48e63          	beq	s1,a5,6cbc <__adddf3+0x69c>
    6864:	03800793          	li	a5,56
    6868:	15c7cc63          	blt	a5,t3,69c0 <__adddf3+0x3a0>
    686c:	01f00793          	li	a5,31
    6870:	3fc7da63          	bge	a5,t3,6c64 <__adddf3+0x644>
    6874:	fe0e0913          	addi	s2,t3,-32 # 3ffe0 <_end+0x37110>
    6878:	02000793          	li	a5,32
    687c:	012856b3          	srl	a3,a6,s2
    6880:	00fe0a63          	beq	t3,a5,6894 <__adddf3+0x274>
    6884:	04000913          	li	s2,64
    6888:	41c90933          	sub	s2,s2,t3
    688c:	01281933          	sll	s2,a6,s2
    6890:	012fefb3          	or	t6,t6,s2
    6894:	01f03933          	snez	s2,t6
    6898:	00d96933          	or	s2,s2,a3
    689c:	12c0006f          	j	69c8 <__adddf3+0x3a8>
    68a0:	01f867b3          	or	a5,a6,t6
    68a4:	22078663          	beqz	a5,6ad0 <__adddf3+0x4b0>
    68a8:	fffe0793          	addi	a5,t3,-1
    68ac:	44078463          	beqz	a5,6cf4 <__adddf3+0x6d4>
    68b0:	7ff00693          	li	a3,2047
    68b4:	20de0263          	beq	t3,a3,6ab8 <__adddf3+0x498>
    68b8:	00078e13          	mv	t3,a5
    68bc:	de5ff06f          	j	66a0 <__adddf3+0x80>
    68c0:	409305b3          	sub	a1,t1,s1
    68c4:	28049663          	bnez	s1,6b50 <__adddf3+0x530>
    68c8:	01e767b3          	or	a5,a4,t5
    68cc:	3c078263          	beqz	a5,6c90 <__adddf3+0x670>
    68d0:	fff58793          	addi	a5,a1,-1
    68d4:	50078c63          	beqz	a5,6dec <__adddf3+0x7cc>
    68d8:	7ff00693          	li	a3,2047
    68dc:	28d58263          	beq	a1,a3,6b60 <__adddf3+0x540>
    68e0:	00078593          	mv	a1,a5
    68e4:	03800793          	li	a5,56
    68e8:	32b7ce63          	blt	a5,a1,6c24 <__adddf3+0x604>
    68ec:	01f00793          	li	a5,31
    68f0:	4ab7c263          	blt	a5,a1,6d94 <__adddf3+0x774>
    68f4:	02000793          	li	a5,32
    68f8:	40b787b3          	sub	a5,a5,a1
    68fc:	00f71933          	sll	s2,a4,a5
    6900:	00bf56b3          	srl	a3,t5,a1
    6904:	00ff17b3          	sll	a5,t5,a5
    6908:	00d96933          	or	s2,s2,a3
    690c:	00f037b3          	snez	a5,a5
    6910:	00b75733          	srl	a4,a4,a1
    6914:	00f96933          	or	s2,s2,a5
    6918:	40e80833          	sub	a6,a6,a4
    691c:	3100006f          	j	6c2c <__adddf3+0x60c>
    6920:	01f867b3          	or	a5,a6,t6
    6924:	3e078463          	beqz	a5,6d0c <__adddf3+0x6ec>
    6928:	fffe0793          	addi	a5,t3,-1
    692c:	28078263          	beqz	a5,6bb0 <__adddf3+0x590>
    6930:	7ff00693          	li	a3,2047
    6934:	38de0463          	beq	t3,a3,6cbc <__adddf3+0x69c>
    6938:	00078e13          	mv	t3,a5
    693c:	f29ff06f          	j	6864 <__adddf3+0x244>
    6940:	1a0e1663          	bnez	t3,6aec <__adddf3+0x4cc>
    6944:	00148693          	addi	a3,s1,1
    6948:	7fe6f793          	andi	a5,a3,2046
    694c:	3e079a63          	bnez	a5,6d40 <__adddf3+0x720>
    6950:	01e767b3          	or	a5,a4,t5
    6954:	34049e63          	bnez	s1,6cb0 <__adddf3+0x690>
    6958:	4a078863          	beqz	a5,6e08 <__adddf3+0x7e8>
    695c:	01f867b3          	or	a5,a6,t6
    6960:	3c078463          	beqz	a5,6d28 <__adddf3+0x708>
    6964:	01ff0933          	add	s2,t5,t6
    6968:	010707b3          	add	a5,a4,a6
    696c:	01e93f33          	sltu	t5,s2,t5
    6970:	01e78633          	add	a2,a5,t5
    6974:	00861793          	slli	a5,a2,0x8
    6978:	0007da63          	bgez	a5,698c <__adddf3+0x36c>
    697c:	ff8007b7          	lui	a5,0xff800
    6980:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    6984:	00f67633          	and	a2,a2,a5
    6988:	00100493          	li	s1,1
    698c:	00797793          	andi	a5,s2,7
    6990:	dc079ae3          	bnez	a5,6764 <__adddf3+0x144>
    6994:	01d61793          	slli	a5,a2,0x1d
    6998:	00395893          	srli	a7,s2,0x3
    699c:	00f8e8b3          	or	a7,a7,a5
    69a0:	00365793          	srli	a5,a2,0x3
    69a4:	7ff00713          	li	a4,2047
    69a8:	06e48a63          	beq	s1,a4,6a1c <__adddf3+0x3fc>
    69ac:	00c79793          	slli	a5,a5,0xc
    69b0:	00c7d793          	srli	a5,a5,0xc
    69b4:	7ff4f513          	andi	a0,s1,2047
    69b8:	00098593          	mv	a1,s3
    69bc:	e01ff06f          	j	67bc <__adddf3+0x19c>
    69c0:	01f86933          	or	s2,a6,t6
    69c4:	01203933          	snez	s2,s2
    69c8:	01e90933          	add	s2,s2,t5
    69cc:	01e937b3          	sltu	a5,s2,t5
    69d0:	00e78633          	add	a2,a5,a4
    69d4:	00861793          	slli	a5,a2,0x8
    69d8:	fa07dae3          	bgez	a5,698c <__adddf3+0x36c>
    69dc:	00148493          	addi	s1,s1,1
    69e0:	7ff00793          	li	a5,2047
    69e4:	1ef49663          	bne	s1,a5,6bd0 <__adddf3+0x5b0>
    69e8:	00098593          	mv	a1,s3
    69ec:	7ff00513          	li	a0,2047
    69f0:	00000793          	li	a5,0
    69f4:	00000893          	li	a7,0
    69f8:	dc5ff06f          	j	67bc <__adddf3+0x19c>
    69fc:	0a079c63          	bnez	a5,6ab4 <__adddf3+0x494>
    6a00:	46088463          	beqz	a7,6e68 <__adddf3+0x848>
    6a04:	00361693          	slli	a3,a2,0x3
    6a08:	01d81793          	slli	a5,a6,0x1d
    6a0c:	0036d693          	srli	a3,a3,0x3
    6a10:	00d7e8b3          	or	a7,a5,a3
    6a14:	000e8993          	mv	s3,t4
    6a18:	00385793          	srli	a5,a6,0x3
    6a1c:	00f8e7b3          	or	a5,a7,a5
    6a20:	fc0784e3          	beqz	a5,69e8 <__adddf3+0x3c8>
    6a24:	00000593          	li	a1,0
    6a28:	7ff00513          	li	a0,2047
    6a2c:	000807b7          	lui	a5,0x80
    6a30:	00000893          	li	a7,0
    6a34:	d89ff06f          	j	67bc <__adddf3+0x19c>
    6a38:	ff800637          	lui	a2,0xff800
    6a3c:	fff60613          	addi	a2,a2,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    6a40:	00c7f633          	and	a2,a5,a2
    6a44:	00797793          	andi	a5,s2,7
    6a48:	40e484b3          	sub	s1,s1,a4
    6a4c:	d0079ce3          	bnez	a5,6764 <__adddf3+0x144>
    6a50:	f45ff06f          	j	6994 <__adddf3+0x374>
    6a54:	00090513          	mv	a0,s2
    6a58:	a24fe0ef          	jal	ra,4c7c <__clzsi2>
    6a5c:	01850713          	addi	a4,a0,24
    6a60:	01f00793          	li	a5,31
    6a64:	cae7d2e3          	bge	a5,a4,6708 <__adddf3+0xe8>
    6a68:	ff850613          	addi	a2,a0,-8
    6a6c:	00c917b3          	sll	a5,s2,a2
    6a70:	00000913          	li	s2,0
    6a74:	cadff06f          	j	6720 <__adddf3+0x100>
    6a78:	01f86933          	or	s2,a6,t6
    6a7c:	01203933          	snez	s2,s2
    6a80:	c59ff06f          	j	66d8 <__adddf3+0xb8>
    6a84:	41ff0933          	sub	s2,t5,t6
    6a88:	41070633          	sub	a2,a4,a6
    6a8c:	012f3433          	sltu	s0,t5,s2
    6a90:	40860433          	sub	s0,a2,s0
    6a94:	00841793          	slli	a5,s0,0x8
    6a98:	2c07cc63          	bltz	a5,6d70 <__adddf3+0x750>
    6a9c:	008968b3          	or	a7,s2,s0
    6aa0:	c4089ce3          	bnez	a7,66f8 <__adddf3+0xd8>
    6aa4:	00000793          	li	a5,0
    6aa8:	00000993          	li	s3,0
    6aac:	00000493          	li	s1,0
    6ab0:	efdff06f          	j	69ac <__adddf3+0x38c>
    6ab4:	f60898e3          	bnez	a7,6a24 <__adddf3+0x404>
    6ab8:	00351513          	slli	a0,a0,0x3
    6abc:	01d71793          	slli	a5,a4,0x1d
    6ac0:	00355513          	srli	a0,a0,0x3
    6ac4:	00a7e8b3          	or	a7,a5,a0
    6ac8:	00375793          	srli	a5,a4,0x3
    6acc:	f51ff06f          	j	6a1c <__adddf3+0x3fc>
    6ad0:	00351513          	slli	a0,a0,0x3
    6ad4:	01d71793          	slli	a5,a4,0x1d
    6ad8:	00355513          	srli	a0,a0,0x3
    6adc:	00a7e8b3          	or	a7,a5,a0
    6ae0:	000e0493          	mv	s1,t3
    6ae4:	00375793          	srli	a5,a4,0x3
    6ae8:	ebdff06f          	j	69a4 <__adddf3+0x384>
    6aec:	40930533          	sub	a0,t1,s1
    6af0:	14048a63          	beqz	s1,6c44 <__adddf3+0x624>
    6af4:	008006b7          	lui	a3,0x800
    6af8:	7ff00793          	li	a5,2047
    6afc:	00d76733          	or	a4,a4,a3
    6b00:	38f30663          	beq	t1,a5,6e8c <__adddf3+0x86c>
    6b04:	03800793          	li	a5,56
    6b08:	28a7c063          	blt	a5,a0,6d88 <__adddf3+0x768>
    6b0c:	01f00793          	li	a5,31
    6b10:	32a7c663          	blt	a5,a0,6e3c <__adddf3+0x81c>
    6b14:	02000793          	li	a5,32
    6b18:	40a787b3          	sub	a5,a5,a0
    6b1c:	00f71933          	sll	s2,a4,a5
    6b20:	00af56b3          	srl	a3,t5,a0
    6b24:	00ff17b3          	sll	a5,t5,a5
    6b28:	00d96933          	or	s2,s2,a3
    6b2c:	00f037b3          	snez	a5,a5
    6b30:	00a75733          	srl	a4,a4,a0
    6b34:	00f96933          	or	s2,s2,a5
    6b38:	00e80833          	add	a6,a6,a4
    6b3c:	01f90933          	add	s2,s2,t6
    6b40:	01f937b3          	sltu	a5,s2,t6
    6b44:	01078633          	add	a2,a5,a6
    6b48:	00030493          	mv	s1,t1
    6b4c:	e89ff06f          	j	69d4 <__adddf3+0x3b4>
    6b50:	008006b7          	lui	a3,0x800
    6b54:	7ff00793          	li	a5,2047
    6b58:	00d76733          	or	a4,a4,a3
    6b5c:	d8f314e3          	bne	t1,a5,68e4 <__adddf3+0x2c4>
    6b60:	00361793          	slli	a5,a2,0x3
    6b64:	0037d793          	srli	a5,a5,0x3
    6b68:	01d81893          	slli	a7,a6,0x1d
    6b6c:	0117e8b3          	or	a7,a5,a7
    6b70:	000e8993          	mv	s3,t4
    6b74:	00385793          	srli	a5,a6,0x3
    6b78:	ea5ff06f          	j	6a1c <__adddf3+0x3fc>
    6b7c:	fe150713          	addi	a4,a0,-31
    6b80:	02000693          	li	a3,32
    6b84:	00e7d733          	srl	a4,a5,a4
    6b88:	00d60a63          	beq	a2,a3,6b9c <__adddf3+0x57c>
    6b8c:	04000693          	li	a3,64
    6b90:	40c68633          	sub	a2,a3,a2
    6b94:	00c79633          	sll	a2,a5,a2
    6b98:	00c96933          	or	s2,s2,a2
    6b9c:	01203933          	snez	s2,s2
    6ba0:	00e96933          	or	s2,s2,a4
    6ba4:	00000613          	li	a2,0
    6ba8:	00000493          	li	s1,0
    6bac:	de1ff06f          	j	698c <__adddf3+0x36c>
    6bb0:	01ff0933          	add	s2,t5,t6
    6bb4:	010707b3          	add	a5,a4,a6
    6bb8:	01e93633          	sltu	a2,s2,t5
    6bbc:	00c78633          	add	a2,a5,a2
    6bc0:	00861793          	slli	a5,a2,0x8
    6bc4:	00100493          	li	s1,1
    6bc8:	dc07d2e3          	bgez	a5,698c <__adddf3+0x36c>
    6bcc:	00200493          	li	s1,2
    6bd0:	ff8007b7          	lui	a5,0xff800
    6bd4:	fff78793          	addi	a5,a5,-1 # ff7fffff <__freertos_irq_stack_top+0xff5f712f>
    6bd8:	00f677b3          	and	a5,a2,a5
    6bdc:	00195713          	srli	a4,s2,0x1
    6be0:	00197913          	andi	s2,s2,1
    6be4:	01276933          	or	s2,a4,s2
    6be8:	01f79893          	slli	a7,a5,0x1f
    6bec:	0128e933          	or	s2,a7,s2
    6bf0:	0017d613          	srli	a2,a5,0x1
    6bf4:	b69ff06f          	j	675c <__adddf3+0x13c>
    6bf8:	fe0e0913          	addi	s2,t3,-32
    6bfc:	02000793          	li	a5,32
    6c00:	012856b3          	srl	a3,a6,s2
    6c04:	00fe0a63          	beq	t3,a5,6c18 <__adddf3+0x5f8>
    6c08:	04000913          	li	s2,64
    6c0c:	41c90933          	sub	s2,s2,t3
    6c10:	01281933          	sll	s2,a6,s2
    6c14:	012fefb3          	or	t6,t6,s2
    6c18:	01f03933          	snez	s2,t6
    6c1c:	00d96933          	or	s2,s2,a3
    6c20:	ab9ff06f          	j	66d8 <__adddf3+0xb8>
    6c24:	01e76933          	or	s2,a4,t5
    6c28:	01203933          	snez	s2,s2
    6c2c:	412f8933          	sub	s2,t6,s2
    6c30:	012fb7b3          	sltu	a5,t6,s2
    6c34:	40f80633          	sub	a2,a6,a5
    6c38:	00030493          	mv	s1,t1
    6c3c:	000e8993          	mv	s3,t4
    6c40:	aa5ff06f          	j	66e4 <__adddf3+0xc4>
    6c44:	01e767b3          	or	a5,a4,t5
    6c48:	1c078c63          	beqz	a5,6e20 <__adddf3+0x800>
    6c4c:	fff50793          	addi	a5,a0,-1
    6c50:	22078463          	beqz	a5,6e78 <__adddf3+0x858>
    6c54:	7ff00693          	li	a3,2047
    6c58:	16d50463          	beq	a0,a3,6dc0 <__adddf3+0x7a0>
    6c5c:	00078513          	mv	a0,a5
    6c60:	ea5ff06f          	j	6b04 <__adddf3+0x4e4>
    6c64:	02000793          	li	a5,32
    6c68:	41c787b3          	sub	a5,a5,t3
    6c6c:	00f816b3          	sll	a3,a6,a5
    6c70:	00ff9933          	sll	s2,t6,a5
    6c74:	01cfd633          	srl	a2,t6,t3
    6c78:	00c6e6b3          	or	a3,a3,a2
    6c7c:	01203933          	snez	s2,s2
    6c80:	01c857b3          	srl	a5,a6,t3
    6c84:	0126e933          	or	s2,a3,s2
    6c88:	00f70733          	add	a4,a4,a5
    6c8c:	d3dff06f          	j	69c8 <__adddf3+0x3a8>
    6c90:	00361793          	slli	a5,a2,0x3
    6c94:	0037d793          	srli	a5,a5,0x3
    6c98:	01d81893          	slli	a7,a6,0x1d
    6c9c:	0117e8b3          	or	a7,a5,a7
    6ca0:	00058493          	mv	s1,a1
    6ca4:	00385793          	srli	a5,a6,0x3
    6ca8:	000e8993          	mv	s3,t4
    6cac:	cf9ff06f          	j	69a4 <__adddf3+0x384>
    6cb0:	10078863          	beqz	a5,6dc0 <__adddf3+0x7a0>
    6cb4:	01f86933          	or	s2,a6,t6
    6cb8:	d60916e3          	bnez	s2,6a24 <__adddf3+0x404>
    6cbc:	00351513          	slli	a0,a0,0x3
    6cc0:	01d71793          	slli	a5,a4,0x1d
    6cc4:	00355513          	srli	a0,a0,0x3
    6cc8:	00f568b3          	or	a7,a0,a5
    6ccc:	00375793          	srli	a5,a4,0x3
    6cd0:	d4dff06f          	j	6a1c <__adddf3+0x3fc>
    6cd4:	10088663          	beqz	a7,6de0 <__adddf3+0x7c0>
    6cd8:	00361693          	slli	a3,a2,0x3
    6cdc:	01d81793          	slli	a5,a6,0x1d
    6ce0:	0036d693          	srli	a3,a3,0x3
    6ce4:	00d7e8b3          	or	a7,a5,a3
    6ce8:	000e8993          	mv	s3,t4
    6cec:	00385793          	srli	a5,a6,0x3
    6cf0:	cbdff06f          	j	69ac <__adddf3+0x38c>
    6cf4:	41ff0933          	sub	s2,t5,t6
    6cf8:	410707b3          	sub	a5,a4,a6
    6cfc:	012f3f33          	sltu	t5,t5,s2
    6d00:	41e78633          	sub	a2,a5,t5
    6d04:	00100493          	li	s1,1
    6d08:	9ddff06f          	j	66e4 <__adddf3+0xc4>
    6d0c:	00351513          	slli	a0,a0,0x3
    6d10:	01d71793          	slli	a5,a4,0x1d
    6d14:	00355513          	srli	a0,a0,0x3
    6d18:	00f568b3          	or	a7,a0,a5
    6d1c:	000e0493          	mv	s1,t3
    6d20:	00375793          	srli	a5,a4,0x3
    6d24:	c81ff06f          	j	69a4 <__adddf3+0x384>
    6d28:	00351513          	slli	a0,a0,0x3
    6d2c:	01d71793          	slli	a5,a4,0x1d
    6d30:	00355513          	srli	a0,a0,0x3
    6d34:	00a7e8b3          	or	a7,a5,a0
    6d38:	00375793          	srli	a5,a4,0x3
    6d3c:	c71ff06f          	j	69ac <__adddf3+0x38c>
    6d40:	7ff00793          	li	a5,2047
    6d44:	caf682e3          	beq	a3,a5,69e8 <__adddf3+0x3c8>
    6d48:	01ff0933          	add	s2,t5,t6
    6d4c:	01e93633          	sltu	a2,s2,t5
    6d50:	010707b3          	add	a5,a4,a6
    6d54:	00c787b3          	add	a5,a5,a2
    6d58:	01f79893          	slli	a7,a5,0x1f
    6d5c:	00195913          	srli	s2,s2,0x1
    6d60:	0128e933          	or	s2,a7,s2
    6d64:	0017d613          	srli	a2,a5,0x1
    6d68:	00068493          	mv	s1,a3
    6d6c:	c21ff06f          	j	698c <__adddf3+0x36c>
    6d70:	41ef8933          	sub	s2,t6,t5
    6d74:	40e80733          	sub	a4,a6,a4
    6d78:	012fb633          	sltu	a2,t6,s2
    6d7c:	40c70433          	sub	s0,a4,a2
    6d80:	000e8993          	mv	s3,t4
    6d84:	975ff06f          	j	66f8 <__adddf3+0xd8>
    6d88:	01e76933          	or	s2,a4,t5
    6d8c:	01203933          	snez	s2,s2
    6d90:	dadff06f          	j	6b3c <__adddf3+0x51c>
    6d94:	fe058793          	addi	a5,a1,-32
    6d98:	02000693          	li	a3,32
    6d9c:	00f757b3          	srl	a5,a4,a5
    6da0:	00d58a63          	beq	a1,a3,6db4 <__adddf3+0x794>
    6da4:	04000693          	li	a3,64
    6da8:	40b685b3          	sub	a1,a3,a1
    6dac:	00b71733          	sll	a4,a4,a1
    6db0:	00ef6f33          	or	t5,t5,a4
    6db4:	01e03933          	snez	s2,t5
    6db8:	00f96933          	or	s2,s2,a5
    6dbc:	e71ff06f          	j	6c2c <__adddf3+0x60c>
    6dc0:	00361793          	slli	a5,a2,0x3
    6dc4:	0037d793          	srli	a5,a5,0x3
    6dc8:	01d81893          	slli	a7,a6,0x1d
    6dcc:	0117e8b3          	or	a7,a5,a7
    6dd0:	00385793          	srli	a5,a6,0x3
    6dd4:	c49ff06f          	j	6a1c <__adddf3+0x3fc>
    6dd8:	00c968b3          	or	a7,s2,a2
    6ddc:	ba0898e3          	bnez	a7,698c <__adddf3+0x36c>
    6de0:	00000793          	li	a5,0
    6de4:	00000993          	li	s3,0
    6de8:	bc5ff06f          	j	69ac <__adddf3+0x38c>
    6dec:	41ef8933          	sub	s2,t6,t5
    6df0:	40e807b3          	sub	a5,a6,a4
    6df4:	012fb633          	sltu	a2,t6,s2
    6df8:	40c78633          	sub	a2,a5,a2
    6dfc:	000e8993          	mv	s3,t4
    6e00:	00100493          	li	s1,1
    6e04:	8e1ff06f          	j	66e4 <__adddf3+0xc4>
    6e08:	00361693          	slli	a3,a2,0x3
    6e0c:	01d81793          	slli	a5,a6,0x1d
    6e10:	0036d693          	srli	a3,a3,0x3
    6e14:	00d7e8b3          	or	a7,a5,a3
    6e18:	00385793          	srli	a5,a6,0x3
    6e1c:	b91ff06f          	j	69ac <__adddf3+0x38c>
    6e20:	00361693          	slli	a3,a2,0x3
    6e24:	01d81793          	slli	a5,a6,0x1d
    6e28:	0036d693          	srli	a3,a3,0x3
    6e2c:	00d7e8b3          	or	a7,a5,a3
    6e30:	00050493          	mv	s1,a0
    6e34:	00385793          	srli	a5,a6,0x3
    6e38:	b6dff06f          	j	69a4 <__adddf3+0x384>
    6e3c:	fe050793          	addi	a5,a0,-32
    6e40:	02000693          	li	a3,32
    6e44:	00f757b3          	srl	a5,a4,a5
    6e48:	00d50a63          	beq	a0,a3,6e5c <__adddf3+0x83c>
    6e4c:	04000693          	li	a3,64
    6e50:	40a68533          	sub	a0,a3,a0
    6e54:	00a71733          	sll	a4,a4,a0
    6e58:	00ef6f33          	or	t5,t5,a4
    6e5c:	01e03933          	snez	s2,t5
    6e60:	00f96933          	or	s2,s2,a5
    6e64:	cd9ff06f          	j	6b3c <__adddf3+0x51c>
    6e68:	00000593          	li	a1,0
    6e6c:	7ff00513          	li	a0,2047
    6e70:	000807b7          	lui	a5,0x80
    6e74:	949ff06f          	j	67bc <__adddf3+0x19c>
    6e78:	01ff0933          	add	s2,t5,t6
    6e7c:	010707b3          	add	a5,a4,a6
    6e80:	01f93633          	sltu	a2,s2,t6
    6e84:	00c78633          	add	a2,a5,a2
    6e88:	d39ff06f          	j	6bc0 <__adddf3+0x5a0>
    6e8c:	00361693          	slli	a3,a2,0x3
    6e90:	01d81793          	slli	a5,a6,0x1d
    6e94:	0036d693          	srli	a3,a3,0x3
    6e98:	00d7e8b3          	or	a7,a5,a3
    6e9c:	00385793          	srli	a5,a6,0x3
    6ea0:	b7dff06f          	j	6a1c <__adddf3+0x3fc>

00006ea4 <__divdf3>:
    6ea4:	fc010113          	addi	sp,sp,-64
    6ea8:	0145d793          	srli	a5,a1,0x14
    6eac:	02812c23          	sw	s0,56(sp)
    6eb0:	02912a23          	sw	s1,52(sp)
    6eb4:	03312623          	sw	s3,44(sp)
    6eb8:	00050493          	mv	s1,a0
    6ebc:	00c59413          	slli	s0,a1,0xc
    6ec0:	02112e23          	sw	ra,60(sp)
    6ec4:	03212823          	sw	s2,48(sp)
    6ec8:	03412423          	sw	s4,40(sp)
    6ecc:	03512223          	sw	s5,36(sp)
    6ed0:	03612023          	sw	s6,32(sp)
    6ed4:	01712e23          	sw	s7,28(sp)
    6ed8:	7ff7f513          	andi	a0,a5,2047
    6edc:	00c45413          	srli	s0,s0,0xc
    6ee0:	01f5d993          	srli	s3,a1,0x1f
    6ee4:	16050863          	beqz	a0,7054 <__divdf3+0x1b0>
    6ee8:	7ff00793          	li	a5,2047
    6eec:	1cf50263          	beq	a0,a5,70b0 <__divdf3+0x20c>
    6ef0:	01d4da93          	srli	s5,s1,0x1d
    6ef4:	00341413          	slli	s0,s0,0x3
    6ef8:	008ae433          	or	s0,s5,s0
    6efc:	00800ab7          	lui	s5,0x800
    6f00:	00349b13          	slli	s6,s1,0x3
    6f04:	01546ab3          	or	s5,s0,s5
    6f08:	c0150913          	addi	s2,a0,-1023
    6f0c:	00000493          	li	s1,0
    6f10:	00000b93          	li	s7,0
    6f14:	0146d713          	srli	a4,a3,0x14
    6f18:	00c69413          	slli	s0,a3,0xc
    6f1c:	7ff77713          	andi	a4,a4,2047
    6f20:	00c45413          	srli	s0,s0,0xc
    6f24:	01f6da13          	srli	s4,a3,0x1f
    6f28:	0e070063          	beqz	a4,7008 <__divdf3+0x164>
    6f2c:	7ff00793          	li	a5,2047
    6f30:	04f70863          	beq	a4,a5,6f80 <__divdf3+0xdc>
    6f34:	00341793          	slli	a5,s0,0x3
    6f38:	01d65413          	srli	s0,a2,0x1d
    6f3c:	00f467b3          	or	a5,s0,a5
    6f40:	c0170713          	addi	a4,a4,-1023
    6f44:	00800437          	lui	s0,0x800
    6f48:	0087e433          	or	s0,a5,s0
    6f4c:	00361813          	slli	a6,a2,0x3
    6f50:	40e90933          	sub	s2,s2,a4
    6f54:	00000693          	li	a3,0
    6f58:	00f00793          	li	a5,15
    6f5c:	0149c5b3          	xor	a1,s3,s4
    6f60:	2497ec63          	bltu	a5,s1,71b8 <__divdf3+0x314>
    6f64:	00001717          	auipc	a4,0x1
    6f68:	c3470713          	addi	a4,a4,-972 # 7b98 <TWO52+0x30>
    6f6c:	00249493          	slli	s1,s1,0x2
    6f70:	00e484b3          	add	s1,s1,a4
    6f74:	0004a783          	lw	a5,0(s1)
    6f78:	00e787b3          	add	a5,a5,a4
    6f7c:	00078067          	jr	a5 # 80000 <_end+0x77130>
    6f80:	00c46833          	or	a6,s0,a2
    6f84:	80190913          	addi	s2,s2,-2047
    6f88:	18081063          	bnez	a6,7108 <__divdf3+0x264>
    6f8c:	0024e493          	ori	s1,s1,2
    6f90:	00000413          	li	s0,0
    6f94:	00200693          	li	a3,2
    6f98:	fc1ff06f          	j	6f58 <__divdf3+0xb4>
    6f9c:	7ff00713          	li	a4,2047
    6fa0:	00000793          	li	a5,0
    6fa4:	00000413          	li	s0,0
    6fa8:	00c79793          	slli	a5,a5,0xc
    6fac:	00040513          	mv	a0,s0
    6fb0:	03c12083          	lw	ra,60(sp)
    6fb4:	03812403          	lw	s0,56(sp)
    6fb8:	01471713          	slli	a4,a4,0x14
    6fbc:	00c7d793          	srli	a5,a5,0xc
    6fc0:	01f59593          	slli	a1,a1,0x1f
    6fc4:	00e7e7b3          	or	a5,a5,a4
    6fc8:	00b7e7b3          	or	a5,a5,a1
    6fcc:	03412483          	lw	s1,52(sp)
    6fd0:	03012903          	lw	s2,48(sp)
    6fd4:	02c12983          	lw	s3,44(sp)
    6fd8:	02812a03          	lw	s4,40(sp)
    6fdc:	02412a83          	lw	s5,36(sp)
    6fe0:	02012b03          	lw	s6,32(sp)
    6fe4:	01c12b83          	lw	s7,28(sp)
    6fe8:	00078593          	mv	a1,a5
    6fec:	04010113          	addi	sp,sp,64
    6ff0:	00008067          	ret
    6ff4:	00000593          	li	a1,0
    6ff8:	7ff00713          	li	a4,2047
    6ffc:	000807b7          	lui	a5,0x80
    7000:	00000413          	li	s0,0
    7004:	fa5ff06f          	j	6fa8 <__divdf3+0x104>
    7008:	00c46833          	or	a6,s0,a2
    700c:	0e080663          	beqz	a6,70f8 <__divdf3+0x254>
    7010:	3e040a63          	beqz	s0,7404 <__divdf3+0x560>
    7014:	00040513          	mv	a0,s0
    7018:	00c12423          	sw	a2,8(sp)
    701c:	c61fd0ef          	jal	ra,4c7c <__clzsi2>
    7020:	00812603          	lw	a2,8(sp)
    7024:	ff550593          	addi	a1,a0,-11
    7028:	01d00693          	li	a3,29
    702c:	ff850713          	addi	a4,a0,-8
    7030:	40b686b3          	sub	a3,a3,a1
    7034:	00e417b3          	sll	a5,s0,a4
    7038:	00d656b3          	srl	a3,a2,a3
    703c:	00f6e433          	or	s0,a3,a5
    7040:	00e61833          	sll	a6,a2,a4
    7044:	01250533          	add	a0,a0,s2
    7048:	3f350913          	addi	s2,a0,1011
    704c:	00000693          	li	a3,0
    7050:	f09ff06f          	j	6f58 <__divdf3+0xb4>
    7054:	00946ab3          	or	s5,s0,s1
    7058:	080a8663          	beqz	s5,70e4 <__divdf3+0x240>
    705c:	00d12623          	sw	a3,12(sp)
    7060:	00c12423          	sw	a2,8(sp)
    7064:	36040863          	beqz	s0,73d4 <__divdf3+0x530>
    7068:	00040513          	mv	a0,s0
    706c:	c11fd0ef          	jal	ra,4c7c <__clzsi2>
    7070:	00812603          	lw	a2,8(sp)
    7074:	00c12683          	lw	a3,12(sp)
    7078:	00050913          	mv	s2,a0
    707c:	ff550713          	addi	a4,a0,-11
    7080:	01d00a93          	li	s5,29
    7084:	ff890b13          	addi	s6,s2,-8
    7088:	40ea8ab3          	sub	s5,s5,a4
    708c:	01641433          	sll	s0,s0,s6
    7090:	0154dab3          	srl	s5,s1,s5
    7094:	008aeab3          	or	s5,s5,s0
    7098:	01649b33          	sll	s6,s1,s6
    709c:	c0d00513          	li	a0,-1011
    70a0:	41250933          	sub	s2,a0,s2
    70a4:	00000493          	li	s1,0
    70a8:	00000b93          	li	s7,0
    70ac:	e69ff06f          	j	6f14 <__divdf3+0x70>
    70b0:	00946ab3          	or	s5,s0,s1
    70b4:	000a9c63          	bnez	s5,70cc <__divdf3+0x228>
    70b8:	00000b13          	li	s6,0
    70bc:	00800493          	li	s1,8
    70c0:	7ff00913          	li	s2,2047
    70c4:	00200b93          	li	s7,2
    70c8:	e4dff06f          	j	6f14 <__divdf3+0x70>
    70cc:	00048b13          	mv	s6,s1
    70d0:	00040a93          	mv	s5,s0
    70d4:	00c00493          	li	s1,12
    70d8:	7ff00913          	li	s2,2047
    70dc:	00300b93          	li	s7,3
    70e0:	e35ff06f          	j	6f14 <__divdf3+0x70>
    70e4:	00000b13          	li	s6,0
    70e8:	00400493          	li	s1,4
    70ec:	00000913          	li	s2,0
    70f0:	00100b93          	li	s7,1
    70f4:	e21ff06f          	j	6f14 <__divdf3+0x70>
    70f8:	0014e493          	ori	s1,s1,1
    70fc:	00000413          	li	s0,0
    7100:	00100693          	li	a3,1
    7104:	e55ff06f          	j	6f58 <__divdf3+0xb4>
    7108:	0034e493          	ori	s1,s1,3
    710c:	00060813          	mv	a6,a2
    7110:	00300693          	li	a3,3
    7114:	e45ff06f          	j	6f58 <__divdf3+0xb4>
    7118:	3c070063          	beqz	a4,74d8 <__divdf3+0x634>
    711c:	00100793          	li	a5,1
    7120:	40e787b3          	sub	a5,a5,a4
    7124:	03800693          	li	a3,56
    7128:	42f6d063          	bge	a3,a5,7548 <__divdf3+0x6a4>
    712c:	00000713          	li	a4,0
    7130:	00000793          	li	a5,0
    7134:	00000413          	li	s0,0
    7138:	e71ff06f          	j	6fa8 <__divdf3+0x104>
    713c:	000a0593          	mv	a1,s4
    7140:	00200793          	li	a5,2
    7144:	e4f68ce3          	beq	a3,a5,6f9c <__divdf3+0xf8>
    7148:	00300793          	li	a5,3
    714c:	eaf684e3          	beq	a3,a5,6ff4 <__divdf3+0x150>
    7150:	00100793          	li	a5,1
    7154:	fcf68ce3          	beq	a3,a5,712c <__divdf3+0x288>
    7158:	3ff90713          	addi	a4,s2,1023
    715c:	fae05ee3          	blez	a4,7118 <__divdf3+0x274>
    7160:	00787793          	andi	a5,a6,7
    7164:	32079c63          	bnez	a5,749c <__divdf3+0x5f8>
    7168:	00385813          	srli	a6,a6,0x3
    716c:	00741793          	slli	a5,s0,0x7
    7170:	0007da63          	bgez	a5,7184 <__divdf3+0x2e0>
    7174:	ff0007b7          	lui	a5,0xff000
    7178:	fff78793          	addi	a5,a5,-1 # feffffff <__freertos_irq_stack_top+0xfedf712f>
    717c:	00f47433          	and	s0,s0,a5
    7180:	40090713          	addi	a4,s2,1024
    7184:	7fe00793          	li	a5,2046
    7188:	e0e7cae3          	blt	a5,a4,6f9c <__divdf3+0xf8>
    718c:	00941793          	slli	a5,s0,0x9
    7190:	01d41693          	slli	a3,s0,0x1d
    7194:	0106e433          	or	s0,a3,a6
    7198:	00c7d793          	srli	a5,a5,0xc
    719c:	7ff77713          	andi	a4,a4,2047
    71a0:	e09ff06f          	j	6fa8 <__divdf3+0x104>
    71a4:	00098593          	mv	a1,s3
    71a8:	000a8413          	mv	s0,s5
    71ac:	000b0813          	mv	a6,s6
    71b0:	000b8693          	mv	a3,s7
    71b4:	f8dff06f          	j	7140 <__divdf3+0x29c>
    71b8:	2b546863          	bltu	s0,s5,7468 <__divdf3+0x5c4>
    71bc:	2a8a8463          	beq	s5,s0,7464 <__divdf3+0x5c0>
    71c0:	000b0713          	mv	a4,s6
    71c4:	fff90913          	addi	s2,s2,-1
    71c8:	00000b13          	li	s6,0
    71cc:	00841793          	slli	a5,s0,0x8
    71d0:	01885893          	srli	a7,a6,0x18
    71d4:	00f8e8b3          	or	a7,a7,a5
    71d8:	0108de13          	srli	t3,a7,0x10
    71dc:	03cad7b3          	divu	a5,s5,t3
    71e0:	01089e93          	slli	t4,a7,0x10
    71e4:	010ede93          	srli	t4,t4,0x10
    71e8:	01075613          	srli	a2,a4,0x10
    71ec:	00881313          	slli	t1,a6,0x8
    71f0:	03cafab3          	remu	s5,s5,t3
    71f4:	02fe86b3          	mul	a3,t4,a5
    71f8:	010a9a93          	slli	s5,s5,0x10
    71fc:	01566633          	or	a2,a2,s5
    7200:	00d67e63          	bgeu	a2,a3,721c <__divdf3+0x378>
    7204:	01160633          	add	a2,a2,a7
    7208:	fff78513          	addi	a0,a5,-1
    720c:	33166a63          	bltu	a2,a7,7540 <__divdf3+0x69c>
    7210:	32d67863          	bgeu	a2,a3,7540 <__divdf3+0x69c>
    7214:	ffe78793          	addi	a5,a5,-2
    7218:	01160633          	add	a2,a2,a7
    721c:	40d60633          	sub	a2,a2,a3
    7220:	03c65433          	divu	s0,a2,t3
    7224:	01071713          	slli	a4,a4,0x10
    7228:	01075713          	srli	a4,a4,0x10
    722c:	03c67633          	remu	a2,a2,t3
    7230:	028e86b3          	mul	a3,t4,s0
    7234:	01061613          	slli	a2,a2,0x10
    7238:	00c76633          	or	a2,a4,a2
    723c:	00d67e63          	bgeu	a2,a3,7258 <__divdf3+0x3b4>
    7240:	01160633          	add	a2,a2,a7
    7244:	fff40713          	addi	a4,s0,-1 # 7fffff <__freertos_irq_stack_top+0x5f712f>
    7248:	2f166863          	bltu	a2,a7,7538 <__divdf3+0x694>
    724c:	2ed67663          	bgeu	a2,a3,7538 <__divdf3+0x694>
    7250:	ffe40413          	addi	s0,s0,-2
    7254:	01160633          	add	a2,a2,a7
    7258:	01079793          	slli	a5,a5,0x10
    725c:	000103b7          	lui	t2,0x10
    7260:	0087e433          	or	s0,a5,s0
    7264:	fff38793          	addi	a5,t2,-1 # ffff <_end+0x712f>
    7268:	00f47833          	and	a6,s0,a5
    726c:	01045f13          	srli	t5,s0,0x10
    7270:	01035513          	srli	a0,t1,0x10
    7274:	00f377b3          	and	a5,t1,a5
    7278:	02f80fb3          	mul	t6,a6,a5
    727c:	40d60733          	sub	a4,a2,a3
    7280:	02ff02b3          	mul	t0,t5,a5
    7284:	010fd613          	srli	a2,t6,0x10
    7288:	030506b3          	mul	a3,a0,a6
    728c:	005686b3          	add	a3,a3,t0
    7290:	00d606b3          	add	a3,a2,a3
    7294:	02af0833          	mul	a6,t5,a0
    7298:	0056f463          	bgeu	a3,t0,72a0 <__divdf3+0x3fc>
    729c:	00780833          	add	a6,a6,t2
    72a0:	00010f37          	lui	t5,0x10
    72a4:	ffff0f13          	addi	t5,t5,-1 # ffff <_end+0x712f>
    72a8:	0106d613          	srli	a2,a3,0x10
    72ac:	01e6f6b3          	and	a3,a3,t5
    72b0:	01069693          	slli	a3,a3,0x10
    72b4:	01efff33          	and	t5,t6,t5
    72b8:	01060633          	add	a2,a2,a6
    72bc:	01e686b3          	add	a3,a3,t5
    72c0:	16c76e63          	bltu	a4,a2,743c <__divdf3+0x598>
    72c4:	16c70a63          	beq	a4,a2,7438 <__divdf3+0x594>
    72c8:	40db06b3          	sub	a3,s6,a3
    72cc:	40c70733          	sub	a4,a4,a2
    72d0:	00db3b33          	sltu	s6,s6,a3
    72d4:	41670b33          	sub	s6,a4,s6
    72d8:	3ff90713          	addi	a4,s2,1023
    72dc:	1f688263          	beq	a7,s6,74c0 <__divdf3+0x61c>
    72e0:	03cb5833          	divu	a6,s6,t3
    72e4:	0106d613          	srli	a2,a3,0x10
    72e8:	03cb7b33          	remu	s6,s6,t3
    72ec:	030e8f33          	mul	t5,t4,a6
    72f0:	010b1b13          	slli	s6,s6,0x10
    72f4:	01666b33          	or	s6,a2,s6
    72f8:	01eb7e63          	bgeu	s6,t5,7314 <__divdf3+0x470>
    72fc:	011b0b33          	add	s6,s6,a7
    7300:	fff80613          	addi	a2,a6,-1
    7304:	2d1b6863          	bltu	s6,a7,75d4 <__divdf3+0x730>
    7308:	2deb7663          	bgeu	s6,t5,75d4 <__divdf3+0x730>
    730c:	ffe80813          	addi	a6,a6,-2
    7310:	011b0b33          	add	s6,s6,a7
    7314:	41eb0b33          	sub	s6,s6,t5
    7318:	03cb5633          	divu	a2,s6,t3
    731c:	01069693          	slli	a3,a3,0x10
    7320:	0106d693          	srli	a3,a3,0x10
    7324:	03cb7b33          	remu	s6,s6,t3
    7328:	02ce8eb3          	mul	t4,t4,a2
    732c:	010b1b13          	slli	s6,s6,0x10
    7330:	0166e6b3          	or	a3,a3,s6
    7334:	01d6fe63          	bgeu	a3,t4,7350 <__divdf3+0x4ac>
    7338:	011686b3          	add	a3,a3,a7
    733c:	fff60e13          	addi	t3,a2,-1
    7340:	2916e663          	bltu	a3,a7,75cc <__divdf3+0x728>
    7344:	29d6f463          	bgeu	a3,t4,75cc <__divdf3+0x728>
    7348:	ffe60613          	addi	a2,a2,-2
    734c:	011686b3          	add	a3,a3,a7
    7350:	01081813          	slli	a6,a6,0x10
    7354:	00c86833          	or	a6,a6,a2
    7358:	01081e13          	slli	t3,a6,0x10
    735c:	01085f93          	srli	t6,a6,0x10
    7360:	010e5e13          	srli	t3,t3,0x10
    7364:	02fe0f33          	mul	t5,t3,a5
    7368:	41d686b3          	sub	a3,a3,t4
    736c:	03c50e33          	mul	t3,a0,t3
    7370:	010f5613          	srli	a2,t5,0x10
    7374:	02ff87b3          	mul	a5,t6,a5
    7378:	00fe0e33          	add	t3,t3,a5
    737c:	01c60633          	add	a2,a2,t3
    7380:	03f50533          	mul	a0,a0,t6
    7384:	00f67663          	bgeu	a2,a5,7390 <__divdf3+0x4ec>
    7388:	000107b7          	lui	a5,0x10
    738c:	00f50533          	add	a0,a0,a5
    7390:	00010e37          	lui	t3,0x10
    7394:	fffe0e13          	addi	t3,t3,-1 # ffff <_end+0x712f>
    7398:	01065793          	srli	a5,a2,0x10
    739c:	01c67633          	and	a2,a2,t3
    73a0:	01061613          	slli	a2,a2,0x10
    73a4:	01cf7f33          	and	t5,t5,t3
    73a8:	00a78533          	add	a0,a5,a0
    73ac:	01e60633          	add	a2,a2,t5
    73b0:	0ca6f863          	bgeu	a3,a0,7480 <__divdf3+0x5dc>
    73b4:	00d886b3          	add	a3,a7,a3
    73b8:	fff80793          	addi	a5,a6,-1
    73bc:	2516e463          	bltu	a3,a7,7604 <__divdf3+0x760>
    73c0:	20a6ee63          	bltu	a3,a0,75dc <__divdf3+0x738>
    73c4:	24a68663          	beq	a3,a0,7610 <__divdf3+0x76c>
    73c8:	00078813          	mv	a6,a5
    73cc:	00186813          	ori	a6,a6,1
    73d0:	d8dff06f          	j	715c <__divdf3+0x2b8>
    73d4:	00048513          	mv	a0,s1
    73d8:	8a5fd0ef          	jal	ra,4c7c <__clzsi2>
    73dc:	01550713          	addi	a4,a0,21
    73e0:	01c00593          	li	a1,28
    73e4:	02050913          	addi	s2,a0,32
    73e8:	00812603          	lw	a2,8(sp)
    73ec:	00c12683          	lw	a3,12(sp)
    73f0:	c8e5d8e3          	bge	a1,a4,7080 <__divdf3+0x1dc>
    73f4:	ff850413          	addi	s0,a0,-8
    73f8:	00849ab3          	sll	s5,s1,s0
    73fc:	00000b13          	li	s6,0
    7400:	c9dff06f          	j	709c <__divdf3+0x1f8>
    7404:	00060513          	mv	a0,a2
    7408:	00c12423          	sw	a2,8(sp)
    740c:	871fd0ef          	jal	ra,4c7c <__clzsi2>
    7410:	01550593          	addi	a1,a0,21
    7414:	01c00713          	li	a4,28
    7418:	00050793          	mv	a5,a0
    741c:	00812603          	lw	a2,8(sp)
    7420:	02050513          	addi	a0,a0,32
    7424:	c0b752e3          	bge	a4,a1,7028 <__divdf3+0x184>
    7428:	ff878793          	addi	a5,a5,-8 # fff8 <_end+0x7128>
    742c:	00000813          	li	a6,0
    7430:	00f61433          	sll	s0,a2,a5
    7434:	c11ff06f          	j	7044 <__divdf3+0x1a0>
    7438:	e8db78e3          	bgeu	s6,a3,72c8 <__divdf3+0x424>
    743c:	006b0b33          	add	s6,s6,t1
    7440:	006b3833          	sltu	a6,s6,t1
    7444:	01180833          	add	a6,a6,a7
    7448:	01070733          	add	a4,a4,a6
    744c:	fff40813          	addi	a6,s0,-1
    7450:	02e8fe63          	bgeu	a7,a4,748c <__divdf3+0x5e8>
    7454:	16c76063          	bltu	a4,a2,75b4 <__divdf3+0x710>
    7458:	14e60c63          	beq	a2,a4,75b0 <__divdf3+0x70c>
    745c:	00080413          	mv	s0,a6
    7460:	e69ff06f          	j	72c8 <__divdf3+0x424>
    7464:	d50b6ee3          	bltu	s6,a6,71c0 <__divdf3+0x31c>
    7468:	01fa9713          	slli	a4,s5,0x1f
    746c:	001b5613          	srli	a2,s6,0x1
    7470:	001ada93          	srli	s5,s5,0x1
    7474:	00c76733          	or	a4,a4,a2
    7478:	01fb1b13          	slli	s6,s6,0x1f
    747c:	d51ff06f          	j	71cc <__divdf3+0x328>
    7480:	f4a696e3          	bne	a3,a0,73cc <__divdf3+0x528>
    7484:	cc060ce3          	beqz	a2,715c <__divdf3+0x2b8>
    7488:	f2dff06f          	j	73b4 <__divdf3+0x510>
    748c:	fce898e3          	bne	a7,a4,745c <__divdf3+0x5b8>
    7490:	fc6b72e3          	bgeu	s6,t1,7454 <__divdf3+0x5b0>
    7494:	00080413          	mv	s0,a6
    7498:	e31ff06f          	j	72c8 <__divdf3+0x424>
    749c:	00f87793          	andi	a5,a6,15
    74a0:	00400693          	li	a3,4
    74a4:	ccd782e3          	beq	a5,a3,7168 <__divdf3+0x2c4>
    74a8:	ffc83793          	sltiu	a5,a6,-4
    74ac:	00480813          	addi	a6,a6,4
    74b0:	0017c793          	xori	a5,a5,1
    74b4:	00385813          	srli	a6,a6,0x3
    74b8:	00f40433          	add	s0,s0,a5
    74bc:	cb1ff06f          	j	716c <__divdf3+0x2c8>
    74c0:	00000813          	li	a6,0
    74c4:	00100793          	li	a5,1
    74c8:	fee048e3          	bgtz	a4,74b8 <__divdf3+0x614>
    74cc:	fff00813          	li	a6,-1
    74d0:	c40716e3          	bnez	a4,711c <__divdf3+0x278>
    74d4:	c0100913          	li	s2,-1023
    74d8:	00100793          	li	a5,1
    74dc:	41e90513          	addi	a0,s2,1054
    74e0:	00a41733          	sll	a4,s0,a0
    74e4:	00f856b3          	srl	a3,a6,a5
    74e8:	00a81533          	sll	a0,a6,a0
    74ec:	00d76733          	or	a4,a4,a3
    74f0:	00a03533          	snez	a0,a0
    74f4:	00a76733          	or	a4,a4,a0
    74f8:	00777693          	andi	a3,a4,7
    74fc:	00f45433          	srl	s0,s0,a5
    7500:	02068063          	beqz	a3,7520 <__divdf3+0x67c>
    7504:	00f77793          	andi	a5,a4,15
    7508:	00400693          	li	a3,4
    750c:	00d78a63          	beq	a5,a3,7520 <__divdf3+0x67c>
    7510:	00470793          	addi	a5,a4,4
    7514:	00e7b733          	sltu	a4,a5,a4
    7518:	00e40433          	add	s0,s0,a4
    751c:	00078713          	mv	a4,a5
    7520:	00841793          	slli	a5,s0,0x8
    7524:	0607d863          	bgez	a5,7594 <__divdf3+0x6f0>
    7528:	00100713          	li	a4,1
    752c:	00000793          	li	a5,0
    7530:	00000413          	li	s0,0
    7534:	a75ff06f          	j	6fa8 <__divdf3+0x104>
    7538:	00070413          	mv	s0,a4
    753c:	d1dff06f          	j	7258 <__divdf3+0x3b4>
    7540:	00050793          	mv	a5,a0
    7544:	cd9ff06f          	j	721c <__divdf3+0x378>
    7548:	01f00693          	li	a3,31
    754c:	f8f6d8e3          	bge	a3,a5,74dc <__divdf3+0x638>
    7550:	fe100693          	li	a3,-31
    7554:	40e68733          	sub	a4,a3,a4
    7558:	02000613          	li	a2,32
    755c:	00e456b3          	srl	a3,s0,a4
    7560:	00c78863          	beq	a5,a2,7570 <__divdf3+0x6cc>
    7564:	43e90793          	addi	a5,s2,1086
    7568:	00f417b3          	sll	a5,s0,a5
    756c:	00f86833          	or	a6,a6,a5
    7570:	01003733          	snez	a4,a6
    7574:	00d76733          	or	a4,a4,a3
    7578:	00777413          	andi	s0,a4,7
    757c:	00000793          	li	a5,0
    7580:	02040063          	beqz	s0,75a0 <__divdf3+0x6fc>
    7584:	00f77793          	andi	a5,a4,15
    7588:	00400693          	li	a3,4
    758c:	00000413          	li	s0,0
    7590:	f8d790e3          	bne	a5,a3,7510 <__divdf3+0x66c>
    7594:	00941793          	slli	a5,s0,0x9
    7598:	00c7d793          	srli	a5,a5,0xc
    759c:	01d41413          	slli	s0,s0,0x1d
    75a0:	00375713          	srli	a4,a4,0x3
    75a4:	00876433          	or	s0,a4,s0
    75a8:	00000713          	li	a4,0
    75ac:	9fdff06f          	j	6fa8 <__divdf3+0x104>
    75b0:	eadb76e3          	bgeu	s6,a3,745c <__divdf3+0x5b8>
    75b4:	006b0b33          	add	s6,s6,t1
    75b8:	006b3833          	sltu	a6,s6,t1
    75bc:	01180833          	add	a6,a6,a7
    75c0:	ffe40413          	addi	s0,s0,-2
    75c4:	01070733          	add	a4,a4,a6
    75c8:	d01ff06f          	j	72c8 <__divdf3+0x424>
    75cc:	000e0613          	mv	a2,t3
    75d0:	d81ff06f          	j	7350 <__divdf3+0x4ac>
    75d4:	00060813          	mv	a6,a2
    75d8:	d3dff06f          	j	7314 <__divdf3+0x470>
    75dc:	00131793          	slli	a5,t1,0x1
    75e0:	0067b333          	sltu	t1,a5,t1
    75e4:	011308b3          	add	a7,t1,a7
    75e8:	011686b3          	add	a3,a3,a7
    75ec:	ffe80813          	addi	a6,a6,-2
    75f0:	00078313          	mv	t1,a5
    75f4:	dca69ce3          	bne	a3,a0,73cc <__divdf3+0x528>
    75f8:	b6c302e3          	beq	t1,a2,715c <__divdf3+0x2b8>
    75fc:	00186813          	ori	a6,a6,1
    7600:	b5dff06f          	j	715c <__divdf3+0x2b8>
    7604:	00078813          	mv	a6,a5
    7608:	fea688e3          	beq	a3,a0,75f8 <__divdf3+0x754>
    760c:	dc1ff06f          	j	73cc <__divdf3+0x528>
    7610:	fcc366e3          	bltu	t1,a2,75dc <__divdf3+0x738>
    7614:	00078813          	mv	a6,a5
    7618:	fec312e3          	bne	t1,a2,75fc <__divdf3+0x758>
    761c:	b41ff06f          	j	715c <__divdf3+0x2b8>

00007620 <__eqdf2>:
    7620:	0145d713          	srli	a4,a1,0x14
    7624:	001007b7          	lui	a5,0x100
    7628:	fff78793          	addi	a5,a5,-1 # fffff <_end+0xf712f>
    762c:	0146d813          	srli	a6,a3,0x14
    7630:	7ff77713          	andi	a4,a4,2047
    7634:	7ff00893          	li	a7,2047
    7638:	00b7fe33          	and	t3,a5,a1
    763c:	00050e93          	mv	t4,a0
    7640:	00d7f7b3          	and	a5,a5,a3
    7644:	01f5d593          	srli	a1,a1,0x1f
    7648:	00060f13          	mv	t5,a2
    764c:	7ff87813          	andi	a6,a6,2047
    7650:	01f6d693          	srli	a3,a3,0x1f
    7654:	01170e63          	beq	a4,a7,7670 <__eqdf2+0x50>
    7658:	00100313          	li	t1,1
    765c:	01180663          	beq	a6,a7,7668 <__eqdf2+0x48>
    7660:	01071463          	bne	a4,a6,7668 <__eqdf2+0x48>
    7664:	02fe0263          	beq	t3,a5,7688 <__eqdf2+0x68>
    7668:	00030513          	mv	a0,t1
    766c:	00008067          	ret
    7670:	00ae68b3          	or	a7,t3,a0
    7674:	00100313          	li	t1,1
    7678:	fe0898e3          	bnez	a7,7668 <__eqdf2+0x48>
    767c:	fee816e3          	bne	a6,a4,7668 <__eqdf2+0x48>
    7680:	00c7e7b3          	or	a5,a5,a2
    7684:	fe0792e3          	bnez	a5,7668 <__eqdf2+0x48>
    7688:	00100313          	li	t1,1
    768c:	fdee9ee3          	bne	t4,t5,7668 <__eqdf2+0x48>
    7690:	00000313          	li	t1,0
    7694:	fcd58ae3          	beq	a1,a3,7668 <__eqdf2+0x48>
    7698:	00100313          	li	t1,1
    769c:	fc0716e3          	bnez	a4,7668 <__eqdf2+0x48>
    76a0:	00ae6533          	or	a0,t3,a0
    76a4:	00a03333          	snez	t1,a0
    76a8:	fc1ff06f          	j	7668 <__eqdf2+0x48>

000076ac <__gedf2>:
    76ac:	0145d713          	srli	a4,a1,0x14
    76b0:	001007b7          	lui	a5,0x100
    76b4:	fff78793          	addi	a5,a5,-1 # fffff <_end+0xf712f>
    76b8:	0146d813          	srli	a6,a3,0x14
    76bc:	7ff77713          	andi	a4,a4,2047
    76c0:	7ff00893          	li	a7,2047
    76c4:	00b7f333          	and	t1,a5,a1
    76c8:	00050e13          	mv	t3,a0
    76cc:	00d7f7b3          	and	a5,a5,a3
    76d0:	01f5d593          	srli	a1,a1,0x1f
    76d4:	00060e93          	mv	t4,a2
    76d8:	7ff87813          	andi	a6,a6,2047
    76dc:	01f6d693          	srli	a3,a3,0x1f
    76e0:	05170263          	beq	a4,a7,7724 <__gedf2+0x78>
    76e4:	03180863          	beq	a6,a7,7714 <__gedf2+0x68>
    76e8:	04071463          	bnez	a4,7730 <__gedf2+0x84>
    76ec:	00a36533          	or	a0,t1,a0
    76f0:	00081663          	bnez	a6,76fc <__gedf2+0x50>
    76f4:	00c7e633          	or	a2,a5,a2
    76f8:	06060263          	beqz	a2,775c <__gedf2+0xb0>
    76fc:	04050a63          	beqz	a0,7750 <__gedf2+0xa4>
    7700:	06d58c63          	beq	a1,a3,7778 <__gedf2+0xcc>
    7704:	00100693          	li	a3,1
    7708:	04059663          	bnez	a1,7754 <__gedf2+0xa8>
    770c:	00068513          	mv	a0,a3
    7710:	00008067          	ret
    7714:	00c7e8b3          	or	a7,a5,a2
    7718:	fc0888e3          	beqz	a7,76e8 <__gedf2+0x3c>
    771c:	ffe00693          	li	a3,-2
    7720:	fedff06f          	j	770c <__gedf2+0x60>
    7724:	00a36533          	or	a0,t1,a0
    7728:	fe051ae3          	bnez	a0,771c <__gedf2+0x70>
    772c:	02e80e63          	beq	a6,a4,7768 <__gedf2+0xbc>
    7730:	00081663          	bnez	a6,773c <__gedf2+0x90>
    7734:	00c7e633          	or	a2,a5,a2
    7738:	fc0606e3          	beqz	a2,7704 <__gedf2+0x58>
    773c:	fcd594e3          	bne	a1,a3,7704 <__gedf2+0x58>
    7740:	02e85c63          	bge	a6,a4,7778 <__gedf2+0xcc>
    7744:	00069863          	bnez	a3,7754 <__gedf2+0xa8>
    7748:	00100693          	li	a3,1
    774c:	fc1ff06f          	j	770c <__gedf2+0x60>
    7750:	fa069ee3          	bnez	a3,770c <__gedf2+0x60>
    7754:	fff00693          	li	a3,-1
    7758:	fb5ff06f          	j	770c <__gedf2+0x60>
    775c:	00000693          	li	a3,0
    7760:	fa0506e3          	beqz	a0,770c <__gedf2+0x60>
    7764:	fa1ff06f          	j	7704 <__gedf2+0x58>
    7768:	00c7e633          	or	a2,a5,a2
    776c:	fc0608e3          	beqz	a2,773c <__gedf2+0x90>
    7770:	ffe00693          	li	a3,-2
    7774:	f99ff06f          	j	770c <__gedf2+0x60>
    7778:	01074a63          	blt	a4,a6,778c <__gedf2+0xe0>
    777c:	f867e4e3          	bltu	a5,t1,7704 <__gedf2+0x58>
    7780:	00f30c63          	beq	t1,a5,7798 <__gedf2+0xec>
    7784:	00000693          	li	a3,0
    7788:	f8f372e3          	bgeu	t1,a5,770c <__gedf2+0x60>
    778c:	fc0584e3          	beqz	a1,7754 <__gedf2+0xa8>
    7790:	00058693          	mv	a3,a1
    7794:	f79ff06f          	j	770c <__gedf2+0x60>
    7798:	f7cee6e3          	bltu	t4,t3,7704 <__gedf2+0x58>
    779c:	00000693          	li	a3,0
    77a0:	f7de76e3          	bgeu	t3,t4,770c <__gedf2+0x60>
    77a4:	fe9ff06f          	j	778c <__gedf2+0xe0>

000077a8 <__unorddf2>:
    77a8:	0145d713          	srli	a4,a1,0x14
    77ac:	001007b7          	lui	a5,0x100
    77b0:	fff78793          	addi	a5,a5,-1 # fffff <_end+0xf712f>
    77b4:	fff74713          	not	a4,a4
    77b8:	0146d813          	srli	a6,a3,0x14
    77bc:	00b7f5b3          	and	a1,a5,a1
    77c0:	00d7f7b3          	and	a5,a5,a3
    77c4:	01571693          	slli	a3,a4,0x15
    77c8:	7ff87813          	andi	a6,a6,2047
    77cc:	02068063          	beqz	a3,77ec <__unorddf2+0x44>
    77d0:	7ff00713          	li	a4,2047
    77d4:	00000513          	li	a0,0
    77d8:	00e80463          	beq	a6,a4,77e0 <__unorddf2+0x38>
    77dc:	00008067          	ret
    77e0:	00c7e7b3          	or	a5,a5,a2
    77e4:	00f03533          	snez	a0,a5
    77e8:	00008067          	ret
    77ec:	00a5e5b3          	or	a1,a1,a0
    77f0:	00100513          	li	a0,1
    77f4:	fc058ee3          	beqz	a1,77d0 <__unorddf2+0x28>
    77f8:	00008067          	ret

000077fc <__errno>:
    77fc:	81418793          	addi	a5,gp,-2028 # 8004 <_impure_ptr>
    7800:	0007a503          	lw	a0,0(a5)
    7804:	00008067          	ret
