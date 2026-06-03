#include "gt911.h"
#include "arduinoGPIO.h"

static void GT911_calculateChecksum(GT911_Device *dev) {
    uint8_t checksum = 0;
    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
        checksum += dev->configBuf[i];
    checksum = (~checksum) + 1;
    dev->configBuf[GT911_CONFIG_CHKSUM - GT911_CONFIG_START] = checksum;
}

void GT911_init(GT911_Device *dev, int rst, int intp, uint16_t width, uint16_t height) {
    //dev->pin_rst = rst;
    //dev->pin_int = intp;
    dev->width = width;
    dev->height = height;
    dev->rotation = ROTATION_NORMAL;
    dev->isTouched = false;
    dev->touches = 0;

    // I2C默认使用 BANK1, SCL=0, SDA=1
    Wire_begin(1, 0);
    Wire_setClock(100000);
}

void GT911_begin(GT911_Device *dev, uint8_t addr) {
    dev->addr = addr;
    GT911_reset(dev);
}

void GT911_reset(GT911_Device *dev) {
   // pinMode(GPIO_BANK1, dev->pin_int, OUTPUT);
   // pinMode(GPIO_BANK1, dev->pin_rst, OUTPUT);

   // digitalWrite(GPIO_BANK1, dev->pin_int, 0);
   // digitalWrite(GPIO_BANK1, dev->pin_rst, 0);
    bsp_uDelay(10000);

    //digitalWrite(GPIO_BANK1, dev->pin_int, (dev->addr == GT911_ADDR2));
    bsp_uDelay(1000);
    //digitalWrite(GPIO_BANK1, dev->pin_rst, 1);
    bsp_uDelay(5000);

    //digitalWrite(GPIO_BANK1, dev->pin_int, 0);
    bsp_uDelay(50000);
    //pinMode(GPIO_BANK1, dev->pin_int, INPUT);
    bsp_uDelay(50000);

    Wire_beginTransmission(dev->addr);
    Wire_write((GT911_CONFIG_START >> 8) & 0xFF);
    Wire_write(GT911_CONFIG_START & 0xFF);
    Wire_endTransmission();
    Wire_requestFrom(dev->addr, GT911_CONFIG_SIZE);

    for (uint8_t i = 0; i < GT911_CONFIG_SIZE; i++)
        dev->configBuf[i] = Wire_read();

    GT911_setResolution(dev, dev->width, dev->height);
}

void GT911_setRotation(GT911_Device *dev, GT911_Rotation rot) {
    dev->rotation = rot;
}

void GT911_setResolution(GT911_Device *dev, uint16_t width, uint16_t height) {


    dev->configBuf[GT911_X_OUTPUT_MAX_LOW  - GT911_CONFIG_START] = width & 0xFF;
    dev->configBuf[GT911_X_OUTPUT_MAX_HIGH - GT911_CONFIG_START] = width >> 8;
    dev->configBuf[GT911_Y_OUTPUT_MAX_LOW  - GT911_CONFIG_START] = height & 0xFF;
    dev->configBuf[GT911_Y_OUTPUT_MAX_HIGH - GT911_CONFIG_START] = height >> 8;



    GT911_reflashConfig(dev);
}

void GT911_reflashConfig(GT911_Device *dev) {
    GT911_calculateChecksum(dev);
    Wire_beginTransmission(dev->addr);
    Wire_write((GT911_CONFIG_CHKSUM >> 8) & 0xFF);
    Wire_write(GT911_CONFIG_CHKSUM & 0xFF);
    Wire_write(dev->configBuf[GT911_CONFIG_CHKSUM - GT911_CONFIG_START]);
    Wire_endTransmission();

    Wire_beginTransmission(dev->addr);
    Wire_write((GT911_CONFIG_FRESH >> 8) & 0xFF);
    Wire_write(GT911_CONFIG_FRESH & 0xFF);
    Wire_write(1);
    Wire_endTransmission();
}

// ...existing code...
void GT911_read(GT911_Device *dev) {
    uint8_t data[7]; // 改为 7 字节，与 Arduino 库一致
    Wire_beginTransmission(dev->addr);
    Wire_write((GT911_POINT_INFO >> 8) & 0xFF);
    Wire_write(GT911_POINT_INFO & 0xFF);
    Wire_endTransmission();

    Wire_requestFrom(dev->addr, 1);
    uint8_t pointInfo = Wire_read();

    uint8_t bufferStatus = (pointInfo >> 7) & 1;
    dev->isLargeDetect = (pointInfo >> 6) & 1;
    dev->touches = pointInfo & 0x0F;
    dev->isTouched = dev->touches > 0;

    if (bufferStatus && dev->isTouched) {
        for (uint8_t i = 0; i < dev->touches; i++) {
            uint16_t reg = GT911_POINT_1 + i * 8;
            Wire_beginTransmission(dev->addr);
            Wire_write((reg >> 8) & 0xFF);
            Wire_write(reg & 0xFF);
            Wire_endTransmission();
            // 改为请求 7 字节（与 Arduino TAMC_GT911::read 中的实现一致）
            Wire_requestFrom(dev->addr, 7);
            for (int j = 0; j < 7; j++)
                data[j] = Wire_read();
            dev->points[i] = GT911_readPoint(dev, data);
        }
    }

    // 清除触摸标志
    Wire_beginTransmission(dev->addr);
    Wire_write((GT911_POINT_INFO >> 8) & 0xFF);
    Wire_write(GT911_POINT_INFO & 0xFF);
    Wire_write(0);
    Wire_endTransmission();
}
// ...existing code...

TP_Point GT911_readPoint(GT911_Device *dev, uint8_t *data) {
    TP_Point p;
    uint16_t temp;
    
    p.id = data[0];
    // 修正：使用低位在前的顺序，与Arduino版本保持一致
    p.x = data[1] + (data[2] << 8);
    p.y = data[3] + (data[4] << 8);
    p.size = data[5] + (data[6] << 8);

    // 调试输出，帮助排查问题

    switch (dev->rotation) {
        case ROTATION_NORMAL:
            p.x = dev->width - p.x;
            p.y = dev->height - p.y;
            break;
        case ROTATION_LEFT:
            temp = p.x;
            p.x = dev->width - p.y;
            p.y = temp;
            break;
        case ROTATION_RIGHT:
            temp = p.x;
            p.x = p.y;
            p.y = dev->height - temp;
            break;
        case ROTATION_INVERTED:
            // 保持不变
            break;
        default:
            break;
    }
    
    return p;
}
