#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include "bsp.h"
#include "io.h"
#if __cplusplus
extern "C" {
#endif
void print_hex(u32 val, u32 digits)
{
	for (int i = (4*digits)-4; i >= 0; i -= 4)
		uart_write(BSP_UART_TERMINAL, "0123456789ABCDEF"[(val >> i) % 16]);
}
#if __cplusplus
}
#endif
