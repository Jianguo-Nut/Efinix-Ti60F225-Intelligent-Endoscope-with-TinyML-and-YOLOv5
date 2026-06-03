#ifndef GT911_H
#define GT911_H

#include <stdint.h>
#include <stdbool.h>
#include "softwire.h"
#include "bsp.h"
#include "gpio.h"

#define GT911_ADDR1     0x5D
#define GT911_ADDR2     0x14

#define GT911_POINT_INFO        0x814E
#define GT911_POINT_1           0x814F  // 修正后的地址
#define GT911_CONFIG_START      0x8047
#define GT911_CONFIG_SIZE       186
#define GT911_CONFIG_CHKSUM     0x80FF
#define GT911_CONFIG_FRESH      0x8100
#define GT911_X_OUTPUT_MAX_LOW  0x8048
#define GT911_X_OUTPUT_MAX_HIGH 0x8049
#define GT911_Y_OUTPUT_MAX_LOW  0x804A
#define GT911_Y_OUTPUT_MAX_HIGH 0x804B

typedef enum {
    ROTATION_NORMAL = 0,
    ROTATION_LEFT,
    ROTATION_INVERTED,
    ROTATION_RIGHT
} GT911_Rotation;

typedef struct {
    uint8_t id;
    uint16_t x;
    uint16_t y;
    uint16_t size;
} TP_Point;

typedef struct {
    uint8_t addr;
    int pin_rst;
    int pin_int;
    uint16_t width;
    uint16_t height;
    GT911_Rotation rotation;
    uint8_t configBuf[GT911_CONFIG_SIZE];
    uint8_t touches;
    bool isTouched;
    bool isLargeDetect;
    TP_Point points[5];
} GT911_Device;

void GT911_init(GT911_Device *dev, int rst, int intp, uint16_t width, uint16_t height);
void GT911_begin(GT911_Device *dev, uint8_t addr);
void GT911_reset(GT911_Device *dev);
void GT911_setRotation(GT911_Device *dev, GT911_Rotation rot);
void GT911_setResolution(GT911_Device *dev, uint16_t width, uint16_t height);
void GT911_reflashConfig(GT911_Device *dev);
void GT911_read(GT911_Device *dev);
TP_Point GT911_readPoint(GT911_Device *dev, uint8_t *data);

#endif
