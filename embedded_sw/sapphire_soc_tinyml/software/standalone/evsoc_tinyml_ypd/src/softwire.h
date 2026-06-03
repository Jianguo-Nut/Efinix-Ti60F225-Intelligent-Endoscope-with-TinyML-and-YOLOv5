#ifndef SOFTWIRE_H
#define SOFTWIRE_H

#include <stdint.h>
#include "gpio.h"
#include "bsp.h"

#ifdef __cplusplus
extern "C" {
#endif

// 默认延时控制 I2C 速率（越大越慢）
#define I2C_DELAY_US_DEFAULT 5

typedef struct {
    int sda_bank;
    int sda_pin;
    int scl_bank;
    int scl_pin;
    uint32_t delay_us;  // I2C速度控制
} SoftWire;

extern SoftWire Wire;

// 对应 Arduino Wire API
void Wire_begin(int sda, int scl);               // 初始化 SDA、SCL
void Wire_setClock(uint32_t freq_hz);            // 设置通信频率
void Wire_beginTransmission(uint8_t address);    // 开始传输
uint8_t Wire_write(uint8_t data);                // 写单字节
uint8_t Wire_writeBytes(const uint8_t *data, uint8_t len); // 写多字节
uint8_t Wire_endTransmission(void);              // 结束传输（Stop）
uint8_t Wire_requestFrom(uint8_t address, uint8_t length); // 请求读取
int Wire_read(void);                             // 读取单字节
int Wire_available(void);                        // 判断是否还有数据

#ifdef __cplusplus
}
#endif

#endif
