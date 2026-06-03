#include "arduinoGPIO.h"

void pinMode(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;

    switch(mode) {
        case INPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
            break;

        case OUTPUT:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) | mask);
            break;

        case INPUT_PULLUP:
            gpio_setOutputEnable(bank, gpio_getOutputEnable(bank) & ~mask);
            gpio_setOutput(bank, gpio_getOutput(bank) | mask); // Enable pull-up
            break;
    }
}

void digitalWrite(uint32_t bank, uint32_t pin, uint32_t val) {
    uint32_t current = gpio_getOutput(bank);
    uint32_t mask = 1 << pin;

    if(val == HIGH) {
        gpio_setOutput(bank, current | mask);
    } else {
        gpio_setOutput(bank, current & ~mask);
    }
}

uint32_t digitalRead(uint32_t bank, uint32_t pin) {
    uint32_t value = gpio_getInput(bank);
    return (value >> pin) & 0x1;
}

void attachInterrupt(uint32_t bank, uint32_t pin, uint32_t mode) {
    uint32_t mask = 1 << pin;

    switch(mode) {
        case RISING:
            gpio_setInterruptRiseEnable(bank, mask);
            break;

        case FALLING:
            gpio_setInterruptFallEnable(bank, mask);
            break;

        case HIGH_LEVEL:
            gpio_setInterruptHighEnable(bank, mask);
            break;

        case LOW_LEVEL:
            gpio_setInterruptLowEnable(bank, mask);
            break;
    }
}

void detachInterrupt(uint32_t bank, uint32_t pin) {
    uint32_t mask = 1 << pin;

    // Disable all interrupt modes for this pin
    gpio_setInterruptRiseEnable(bank, gpio_getInput(bank) & ~mask);
    gpio_setInterruptFallEnable(bank, gpio_getInput(bank) & ~mask);
    gpio_setInterruptHighEnable(bank, gpio_getInput(bank) & ~mask);
    gpio_setInterruptLowEnable(bank, gpio_getInput(bank) & ~mask);
}

