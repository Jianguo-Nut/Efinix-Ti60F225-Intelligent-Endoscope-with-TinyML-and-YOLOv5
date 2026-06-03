/******************************************************************************
*
* @file main.c: GpioDemo (onBoard LED Blinking Demo)
*
* @brief This demo performs onboard LED blinking through GPIO controller 
*        and allow external interrupt by user. 
*
******************************************************************************/
#include <stdint.h>
#include "bsp.h"
#include "riscv.h"
#include "gpio.h"
#include "clint.h"
#include "plic.h"
#include "arduinoGPIO.h"
#include "softwire.h"
#include "gt911.h"

void init();
void main();
void trap();
void crash();
void trap_entry();
void externalInterrupt();

/******************************************************************************
*
* @brief This function initializes GPIO interrupts and enables external interrupts
*        by setting up the machine trap vector.
*
******************************************************************************/
void init(){
    //configure PLIC
    //cpu 0 accept all interrupts with priority above 0
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0);
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0, 1);


    //enable interrupts
    //Set the machine trap vector (../common/trap.S)
    csr_write(mtvec, trap_entry);
    //Enable external interrupts
    csr_set(mie, MIE_MEIE);
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
}


/******************************************************************************
*
* @brief This function handles exceptions and interrupts in the system.
*
* @note It is called by the trap_entry function on both exceptions and interrupts 
* 		events. If the cause of the trap is an interrupt, it checks the cause of 
* 		the interrupt and calls corresponding interrupt handler functions. If 
* 		the cause is an exception or an unhandled interrupt, it calls a 
*		crash function to handle the error.
*
******************************************************************************/
void trap(){
    int32_t mcause = csr_read(mcause);
    int32_t interrupt = mcause < 0;    //Interrupt if true, exception if false
    int32_t cause     = mcause & 0xF;
    if(interrupt){
        switch(cause){
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
        default: crash(); break;
        }
    } else {
        crash();
    }
}


/******************************************************************************
*
* @brief This function handles external interrupts. It checks for pending
*        interrupts and processes them accordingly. If an interrupt from
*        GPIO 0 is detected, it prints a message indicating the interrupt
*        source. If an interrupt from an unknown source is detected, it 
*        calls a crash function to handle the error.
*
******************************************************************************/
void externalInterrupt(){
    uint32_t claim;
    //While there is pending interrupts
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
        switch(claim){
        case SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0: bsp_printf("gpio 0 interrupt routine \r\n"); break;
        default: crash(); break;
        }
        //unmask the claimed interrupt
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
    }
}


/******************************************************************************
*
* @brief This function handles the system crash scenario by printing a crash message
* 		 and entering an infinite loop.
*
******************************************************************************/
void crash(){
    bsp_printf("\r\n*** CRASH ***\r\n");
    while(1);
}

/******************************************************************************
*
* @brief
*
******************************************************************************/
// Example usage
// ...existing code...
GT911_Device gt911;

// 新增：按钮区域/状态定义 —— 请在下面填入实际坐标（x1,y1,x2,y2）
typedef struct { int16_t x1,y1,x2,y2; } Rect;
static Rect buttonRects[4] = {
    /* Button 0 */ { /* x1 */ 540, /* y1 */ 707, /* x2 */ 486, /* y2 */ 651 },
    /* Button 1 */ { 540, 624, 486, 549 },
    /* Button 2 */ { 540, 508, 486, 444 },
    /* Button 3 */ { 540, 427, 486, 362 }
};

// 运行时按键保持状态（用于按下触发一次，松开后可再次触发）
static uint8_t buttonPressed[4] = {0,0,0,0};
// 新增：按住计数，用于实现按住自动重复触发
static uint16_t buttonHoldTicks[4] = {0,0,0,0};
// 每个主循环约 bsp_uDelay(50000) = 50ms，REPEAT_TICKS * 50ms = 重复间隔（默认 10*50ms = 500ms）
#define REPEAT_TICKS 10

// 映射到 GPIO_BANK0 的引脚号（与原来 pinMode/digitalWrite 使用一致）
static const uint8_t buttonPins[4] = { 0, 1, 2, 3 };


// 辅助：点是否在矩形内
static inline uint8_t point_in_rect(int16_t x, int16_t y, const Rect *r){
    return (x <= r->x1 && x >= r->x2 && y <= r->y1 && y >= r->y2) ? 1 : 0;
}

int flagFreeze = 0;
int flagAE = 0;

static void trigger_button_action(uint8_t idx){
    if(idx > 3) return;
    if(idx >1){
    	digitalWrite(GPIO_BANK0, buttonPins[idx], HIGH);
    	bsp_uDelay(100000); // 500ms
    	digitalWrite(GPIO_BANK0, buttonPins[idx], LOW);
    	return;
    }
    if(idx==0){
    	if(flagFreeze==1){
        	digitalWrite(GPIO_BANK0, buttonPins[idx], LOW);
        	bsp_uDelay(80000); // 500ms
        	flagFreeze = 0;
        	return;
    	}
    	else{
    		flagFreeze = 1;
    		digitalWrite(GPIO_BANK0, buttonPins[idx], HIGH);
    		bsp_uDelay(80000); // 500ms
    		return;
    	}
    }

    if(idx==1){
        	if(flagAE==1){
            	digitalWrite(GPIO_BANK0, buttonPins[idx], LOW);
            	bsp_uDelay(80000); // 500ms
            	flagAE = 0;
            	return;
        	}
        	else{
        		flagAE = 1;
        		digitalWrite(GPIO_BANK0, buttonPins[idx], HIGH);
        		bsp_uDelay(80000); // 500ms
        		return;
        	}
        }
}
// ...existing code...
void main() {
    bsp_printf("GT911 Touch Driver Test\r\n");
    pinMode(GPIO_BANK0,0,OUTPUT);
    pinMode(GPIO_BANK0,1,OUTPUT);
    pinMode(GPIO_BANK0,2,OUTPUT);
    pinMode(GPIO_BANK0,3,OUTPUT);
    digitalWrite(GPIO_BANK0,0,LOW);
    digitalWrite(GPIO_BANK0,1,LOW);
    digitalWrite(GPIO_BANK0,2,LOW);
    digitalWrite(GPIO_BANK0,3,LOW);
    bsp_uDelay(500000);
    digitalWrite(GPIO_BANK0,0,LOW);
    digitalWrite(GPIO_BANK0,1,LOW);
    digitalWrite(GPIO_BANK0,2,LOW);
    digitalWrite(GPIO_BANK0,3,LOW);
    bsp_uDelay(500000);
    /*
    // 初始化GT911：使用GPIO_BANK1的SCL=0, SDA=1, RST=2, INT=3
    GT911_init(&gt911, 2, 3, 1280, 720);
    GT911_begin(&gt911, GT911_ADDR1);
    bsp_uDelay(500000);
    while (1) {
        GT911_read(&gt911);

        // 标记当前帧哪些按钮被触摸
        uint8_t touched[4] = {0,0,0,0};
        if (gt911.isTouched) {
            for (uint8_t i = 0; i < gt911.touches; i++) {
                if (gt911.points[i].id != 0) continue;
                int16_t px = gt911.points[i].x;
                int16_t py = gt911.points[i].y;
                for (uint8_t b = 0; b < 4; b++) {
                    if (point_in_rect(px, py, &buttonRects[b])) {
                        touched[b] = 1;
                    }
                }
            }
        }

        // 根据 touched 数组触发动作：首次触发立即执行，按住时每 REPEAT_TICKS 重复一次
        for (uint8_t b = 0; b < 4; b++) {
            if (touched[b]) {
                buttonHoldTicks[b]++;
                if (!buttonPressed[b]) {
                    // 首次按下
                    buttonPressed[b] = 1;
                    buttonHoldTicks[b] = 0;
                    trigger_button_action(b);
                } else if (buttonHoldTicks[b] >= REPEAT_TICKS) {
                    // 按住达到重复间隔，重复触发
                    buttonHoldTicks[b] = 0;
                    trigger_button_action(b);
                }
            } else {
                // 未触摸：重置状态，下一次触摸重新触发
                buttonPressed[b] = 0;
                buttonHoldTicks[b] = 0;
            }
        }

        bsp_uDelay(50000);
    }
    */
}
