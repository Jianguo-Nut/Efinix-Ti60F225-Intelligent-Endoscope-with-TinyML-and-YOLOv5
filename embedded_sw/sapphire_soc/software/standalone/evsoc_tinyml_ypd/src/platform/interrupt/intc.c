#include "../../platform/interrupt/intc.h"
#include <stdint.h>
#include "riscv.h"
#include "plic.h"
#include "bsp.h"
#include "platform/tinyml/ops/ops_api.h"

void trap_entry();

void userInterrupt(){
    uint32_t claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0);
    if(claim == SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT) {
        for(volatile int i=0; i<8700; i++) asm volatile("");
        ops_drv_intr();
    }
    if(claim)
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim);
}

void trap(){
    int32_t mc = csr_read(mcause);
    if(mc < 0 && (mc & 0xF) == CAUSE_MACHINE_EXTERNAL)
        userInterrupt();
    else {
        // Unexpected exception (misaligned handled in trap.S)
        uart_writeStr(BSP_UART_TERMINAL, "X");
        char hx[2] = {"0123456789ABCDEF"[mc & 0xF], 0};
        uart_writeStr(BSP_UART_TERMINAL, hx);
        while(1);
    }
}
