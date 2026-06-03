////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2025 Efinix Inc. All rights reserved.              
// Full license header bsp/efinix/EfxSapphireSoc/include/LICENSE.MD
////////////////////////////////////////////////////////////////////////////////

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
#include "userDef.h"
#include "riscv.h"
#include "gpio.h"
#include "clint.h"
#include "plic.h"
#include "arduinoGPIO.h"


void main() {
    bsp_init();
    bsp_printf("***Starting GPIO Demo*** \r\n");
    bsp_printf("Configure GPIOs to blink .. \r\n");
    // Set GPIO to output
    pinMode(GPIO_BANK0, 0, OUTPUT);
    pinMode(GPIO_BANK0, 1, OUTPUT);
    pinMode(GPIO_BANK0, 2, OUTPUT);
    pinMode(GPIO_BANK0, 3, OUTPUT);
    pinMode(GPIO_BANK0, 4, OUTPUT);
    pinMode(GPIO_BANK0, 5, OUTPUT);

    digitalWrite(GPIO_BANK0, 0, LOW);
    digitalWrite(GPIO_BANK0, 1, LOW);
    digitalWrite(GPIO_BANK0, 2, LOW);
    digitalWrite(GPIO_BANK0, 3, LOW);
    digitalWrite(GPIO_BANK0, 4, LOW);
    digitalWrite(GPIO_BANK0, 5, LOW);

   while(1) {
	    digitalWrite(GPIO_BANK0, 0, HIGH);
        bsp_uDelay(5*LOOP_UDELAY);
        digitalWrite(GPIO_BANK0, 0, LOW);
        bsp_uDelay(5*LOOP_UDELAY);
    }   
    bsp_printf("***Starting GPIO Interrupt Demo*** \r\n");
    bsp_printf("Press and release onboard button sw4 .. \r\n");
    isrInit();
    while(1); 
}


