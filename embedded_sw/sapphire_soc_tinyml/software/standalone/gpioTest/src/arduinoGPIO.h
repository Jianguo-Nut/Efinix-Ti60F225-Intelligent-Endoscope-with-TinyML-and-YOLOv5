#ifndef ARDUINO_GPIO_H
#define ARDUINO_GPIO_H

#include "gpio.h"
#include "soc.h"

// Pin modes
#define INPUT 0x0
#define OUTPUT 0x1
#define INPUT_PULLUP 0x2

// Digital values
#define LOW 0x0
#define HIGH 0x1

// GPIO banks
#define GPIO_BANK0 SYSTEM_GPIO_0_IO_CTRL
#define GPIO_BANK1 SYSTEM_GPIO_1_IO_CTRL

// Function prototypes
void pinMode(uint32_t bank, uint32_t pin, uint32_t mode);
void digitalWrite(uint32_t bank, uint32_t pin, uint32_t val);
uint32_t digitalRead(uint32_t bank, uint32_t pin);

// Interrupt modes
#define RISING 0x1
#define FALLING 0x2
#define HIGH_LEVEL 0x3
#define LOW_LEVEL 0x4

void attachInterrupt(uint32_t bank, uint32_t pin, uint32_t mode);
void detachInterrupt(uint32_t bank, uint32_t pin);

#endif
