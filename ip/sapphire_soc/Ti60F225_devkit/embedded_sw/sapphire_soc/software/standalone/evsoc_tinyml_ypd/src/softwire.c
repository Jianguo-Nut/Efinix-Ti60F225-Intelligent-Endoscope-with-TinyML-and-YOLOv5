#include "softwire.h"
#include "arduinoGPIO.h"

SoftWire Wire;
static uint8_t rx_buffer[64];
static uint8_t rx_len = 0;
static uint8_t rx_index = 0;
static uint8_t device_addr = 0;

// --- 基本GPIO控制宏 ---
static inline void SDA_OUT() { pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT); }
static inline void SDA_IN()  { pinMode(Wire.sda_bank, Wire.sda_pin, INPUT);  }

static inline void SDA_HIGH() { digitalWrite(Wire.sda_bank, Wire.sda_pin, HIGH); }
static inline void SDA_LOW()  { digitalWrite(Wire.sda_bank, Wire.sda_pin, LOW);  }
static inline void SCL_HIGH() { digitalWrite(Wire.scl_bank, Wire.scl_pin, HIGH); }
static inline void SCL_LOW()  { digitalWrite(Wire.scl_bank, Wire.scl_pin, LOW);  }

static inline void i2c_delay() { bsp_uDelay(Wire.delay_us); }

// --- 基础时序函数 ---
static void i2c_start(void) {
    SDA_OUT();
    SDA_HIGH(); SCL_HIGH();
    i2c_delay();
    SDA_LOW();
    i2c_delay();
    SCL_LOW();
}

static void i2c_stop(void) {
    SDA_OUT();
    SDA_LOW();
    i2c_delay();
    SCL_HIGH();
    i2c_delay();
    SDA_HIGH();
    i2c_delay();
}

static uint8_t i2c_write_byte(uint8_t data) {
    SDA_OUT();
    for (int i = 0; i < 8; i++) {
        if (data & 0x80) SDA_HIGH(); else SDA_LOW();
        i2c_delay();
        SCL_HIGH();
        i2c_delay();
        SCL_LOW();
        data <<= 1;
    }
    // 读取ACK
    SDA_IN();
    i2c_delay();
    SCL_HIGH();
    uint8_t ack = !digitalRead(Wire.sda_bank, Wire.sda_pin);
    i2c_delay();
    SCL_LOW();
    SDA_OUT();
    return ack;
}

static uint8_t i2c_read_byte(uint8_t ack) {
    uint8_t data = 0;
    SDA_IN();
    // 逐位读取：将第一次读到的 bit 放到最高位（MSB first）
    for (int i = 0; i < 8; i++) {
        SCL_HIGH();
        i2c_delay();
        uint8_t bit = digitalRead(Wire.sda_bank, Wire.sda_pin) ? 1 : 0;
        data = (data << 1) | bit;
        SCL_LOW();
        i2c_delay();
    }
    // 发送 ACK/NACK（ACK -> SDA 拉低）
    SDA_OUT();
    if (ack) SDA_LOW(); else SDA_HIGH();
    i2c_delay();
    SCL_HIGH();
    i2c_delay();
    SCL_LOW();
    return data;
}

// --- 高层接口 ---
void Wire_begin(int sda, int scl) {
    Wire.sda_bank = GPIO_BANK1;
    Wire.scl_bank = GPIO_BANK1;
    Wire.sda_pin = sda;
    Wire.scl_pin = scl;
    Wire.delay_us = I2C_DELAY_US_DEFAULT;

    pinMode(Wire.sda_bank, Wire.sda_pin, OUTPUT);
    pinMode(Wire.scl_bank, Wire.scl_pin, OUTPUT);
    SDA_HIGH();
    SCL_HIGH();
}

void Wire_setClock(uint32_t freq_hz) {
    // 简单近似：根据频率反算延时
    if (freq_hz >= 400000) Wire.delay_us = 1;   // 400kHz
    else if (freq_hz >= 100000) Wire.delay_us = 5; // 100kHz
    else Wire.delay_us = 10;
}

void Wire_beginTransmission(uint8_t address) {
    device_addr = address << 1;
    i2c_start();
    if (!i2c_write_byte(device_addr)) {
        bsp_printf("I2C NACK at addr write\r\n");
    }
}

uint8_t Wire_write(uint8_t data) {
    if (!i2c_write_byte(data)) {
        bsp_printf("I2C NACK data\r\n");
        return 0;
    }
    return 1;
}

uint8_t Wire_writeBytes(const uint8_t *data, uint8_t len) {
    uint8_t count = 0;
    for (uint8_t i = 0; i < len; i++) {
        if (i2c_write_byte(data[i])) count++;
        else break;
    }
    return count;
}

uint8_t Wire_endTransmission(void) {
    i2c_stop();
    return 0; // 0 表示成功
}

uint8_t Wire_requestFrom(uint8_t address, uint8_t length) {
    if (length > sizeof(rx_buffer)) length = sizeof(rx_buffer);
    i2c_start();
    if (!i2c_write_byte((address << 1) | 1)) {
        bsp_printf("I2C NACK at addr read\r\n");
        i2c_stop();
        return 0;
    }
    rx_len = length;
    rx_index = 0;
    for (uint8_t i = 0; i < length; i++) {
        rx_buffer[i] = i2c_read_byte(i < (length - 1));
    }
    i2c_stop();
    return rx_len;
}

int Wire_read(void) {
    if (rx_index < rx_len) return rx_buffer[rx_index++];
    else return -1;
}

int Wire_available(void) {
    return (rx_index < rx_len);
}
