#include <stdint.h>
#include "print.h"
#include "io.h"

typedef unsigned char u8;

#include "bsp.h"

static void flush_data_cache(){
        asm(".word(0x500F)");
}

void test(void *p, int size, u8 value, u8 idx) {
	volatile u8 *addr = (volatile u8 *)p;
	if(!idx) {
		memset(p, value, size);
		flush_data_cache();
		for(u32 i = 0; i < size; i++) {
			if(addr[i] != value) {
				bsp_printf_full("Error: %p: %x != %x\n\r", addr+i, value, addr[i]);
				goto err;
			}
		}
	} else {
		for(u32 i = 0; i < size; i++) {
			addr[i] = i;
		}

		for(u32 i = 0; i < size; i++) {
			if(addr[i] != i & 0xff) {
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", addr+i, i&0xff, addr[i]);
				goto err;
			}
		}
	}
	if(!idx) {
		bsp_printf_full("test (0x%p, 0x%p) = 0x%.2X success!\n\r", p, p + size, value);
	} else {
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
	}
	return;
err:
	bsp_printf_full("test (0x%p, 0x%p) = 0x%.2X failed!\n\r", p, p + size, value);
}
void test32(void *p, int size, u32 value, u8 idx) {
	volatile u32 *addr = (volatile u32 *)p;
	if(!idx) {
		for(int i = 0; i < size/4; i++) {
			addr[i] = value;
		}
		for(int i = 0; i < size/4; i++) {
			if(addr[i] != value) {
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", addr+i, value, addr[i]);
				goto err;
			}
		}
	} else {
		for(u32 i = 0; i < size/4; i++) {
			addr[i] = addr+i*4;
		}

		for(u32 i = 0; i < size/4; i++) {
			u32 addr_idx = addr + i*4;
			if(addr[i] != addr_idx) {
				bsp_printf_full("Error: 0x%p: %x != %x\n\r", &addr[i], addr_idx, &addr[i]);
				goto err;
			}
		}
	}
	if(!idx) {
		bsp_printf_full("test (0x%p, 0x%p) = 0x%.8X success!\n\r", p, p + size, value);
	} else {
		bsp_printf_full("test (0x%p, 0x%p) = self success!\n\r", p, p + size);
	}
	return;
err:
	bsp_printf_full("test (0x%p, 0x%p) = 0x%.8X failed!\n\r", p, p + size, value);
}

#define BEGIN 0x00400000U
#define MEM_SIZE (16 * 1024 * 1024)
#define ROUNDS 1000
void main() {
	bsp_printf_full("MEMORY TEST BEGIN (%p -> %p): %dMB, ROUNDS: %d\n\r", BEGIN, BEGIN+MEM_SIZE, MEM_SIZE/1024/1024, ROUNDS);
	for(int i = 0; i < ROUNDS; i++) {
		bsp_printf("================= round: %d ===================\n\r", i);
		test(BEGIN,   MEM_SIZE, 0x0, 0);
		test(BEGIN,   MEM_SIZE, 0x1, 0);
		test(BEGIN,   MEM_SIZE, 0x5, 0);
		test(BEGIN,   MEM_SIZE, 0xa, 0);
		test32(BEGIN, MEM_SIZE, 0, 1);
	}
	bsp_printf_full("MEMORY TEST FINISH!\n\r");

}
