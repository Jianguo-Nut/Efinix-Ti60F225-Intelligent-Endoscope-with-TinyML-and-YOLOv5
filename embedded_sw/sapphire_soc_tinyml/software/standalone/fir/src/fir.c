#include <stdio.h>
#include <stdint.h> // 为了使用 uint8_t 和 uint32_t
#include <bsp.h>
#include <clint.h>
#include <riscv.h>
// 1. 定义滤波器系数 (h[n])
// 对于最简单的8级移动平均滤波器，所有8个系数都为1。
const uint8_t h[8] = {9, 3, 15, 2, 7, 4, 3, 48};

// 2. 定义输入样本历史缓冲区 (x[n])，也叫延迟线
// 初始化为0
uint8_t x[8] = {0};

// 3. 准备一些模拟的输入信号
uint8_t input_signal[] = {1, 2, 3, 17, 8, 3, 10, 22, 4, 19, 3, 1, 7, 4, 7, 5, 4, 33};
uint8_t output_signal[sizeof(input_signal)] = {0};

void soft_fir() {
	   int signal_length = sizeof(input_signal) / sizeof(input_signal[0]);


	    // 4. 循环处理每一个输入样本
	    for (int n = 0; n < signal_length; n++) {
	        // 获取当前的新输入样本
	         uint8_t current_input = input_signal[n];

	        // a. 更新历史缓冲区：将所有样本向后移动一位
	        for (int i = 7; i > 0; i--) {
	            x[i] = x[i-1];
	        }
	        // 将新样本存入缓冲区最前端
	        x[0] = current_input;

	        // b. 执行FIR核心计算：卷积求和
	        // y[n] = h[0]*x[0] + h[1]*x[1] + ... + h[7]*x[7]
	        // 使用一个32位无符号整数作为累加器，防止中间计算结果溢出
	        uint32_t sum = 0;
	        for (int i = 0; i < 8; i++) {
	            sum += h[i] * x[i];
	        }

	        // c. 归一化/缩放输出
	        // 对于移动平均，需要除以系数的个数（8）。
	        // 使用位运算右移3位 (>> 3) 来代替除以8，效率更高。
	        uint8_t output = (uint8_t)(sum >> 3);

	        // d. 打印结果
	        output_signal[n] = output;
	    }
}
int main() {
	bsp_printf("8-stage fir filter, input size: %d\n\r", sizeof(input_signal));
	//soft
	u32 beginTicks = clint_getTime(BSP_CLINT);
	soft_fir();
	u32 endTicks = clint_getTime(BSP_CLINT);


    bsp_printf("Input -> Output\n\r");
    for(int i = 0; i < sizeof(input_signal); i++) {
    	bsp_printf("%d -> %d\n\r", input_signal[i], output_signal[i]);
    }
    bsp_printf("soft time cost: %d\n\r", endTicks - beginTicks);

    //custom instruction



    bsp_printf("done\n\r");
    return 0;
}

