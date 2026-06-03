module AEC_Serial
(
    input                   I_clk  ,             // 输入时钟信号
    input                   I_rst_n,             // 输入复位信号，低电平有效

    input                   I_vsync,            // 输入场同步信号
    input                   I_href ,            // 输入行有效信号
    input      [7:0]        I_y_data,           // 输入gamma校正后的Y分量数据

    input                   I_switch,           // 高 = 自动，低 = 手动
    input                   I_increase,         // 按键，低有效（不按 = 高）
    input                   I_decrease,         // 按键，低有效（不按 = 高）

    output                  O_vsync,            // 输出场同步信号
    output                  O_href ,            // 输出行有效信号
    output     [7:0]        O_y_data,           // 直接输出原始Y分量数据

    output                  O_gain_update_en,   // 增益更新使能信号（合成）
    output     [7:0]        O_gain_reg_data     // 增益寄存器数据（合成）
);

/*****************************************************************
                        信号定义与寄存器                                  
*****************************************************************/

reg    [1:0]            vsync_r    ;     // 场同步信号寄存器
reg    [1:0]            href_r     ;     // 行有效信号寄存器

localparam      DELAY_CYCLES = 2;       // 处理延迟周期数
reg   [7:0]     Y_out;                  // 存储最终的Y输出

// 亮度统计相关
reg   [19:0]    pixel_cnt;              // 像素计数器
reg   [27:0]    Y_sum;                  // Y值累加器
reg   [7:0]     Y_avg;                  // 平均亮度
reg   [7:0]     last_Y_avg;             // 上一帧平均亮度
reg             frame_end;              // 帧结束标志

// 增益控制相关
reg   [7:0]     current_gain;           // 当前增益值
reg   [7:0]     target_gain;            // 目标增益值
reg   [2:0]     stable_counter;         // 稳定计数器
reg             gain_stable;            // 增益稳定标志
reg   [1:0]     adjust_counter;         // 调整间隔计数器

reg  [3:0]      inc_cnt;
reg  [3:0]      dec_cnt;
reg             inc_trig;       // 增加按键的一周期触发脉冲
reg             dec_trig;       // 减少按键的一周期触发脉冲
reg             inc_locked;     // 长按锁定，等释放后才能再次触发
reg             dec_locked;

reg             O_gain_update_en_auto;
reg             O_gain_update_en_manual;
reg  [7:0]      O_gain_reg_data_auto;
reg  [7:0]      O_gain_reg_data_manual;

assign O_gain_update_en = O_gain_update_en_auto | O_gain_update_en_manual;
assign O_gain_reg_data = O_gain_update_en_manual ? O_gain_reg_data_manual : O_gain_reg_data_auto;

// 临时
reg [7:0] prev_gain;
reg [7:0] computed_target;
reg [7:0] next_gain;

localparam      EXTREME_DARK_THRESHOLD = 8'd15;   // 极暗场景阈值
localparam      VERY_DARK_THRESHOLD_1 = 8'd18;    // 很暗场景阈值1
localparam      VERY_DARK_THRESHOLD_2 = 8'd21;    // 很暗场景阈值2
localparam      VERY_DARK_THRESHOLD_3 = 8'd24;    // 很暗场景阈值3
localparam      VERY_DARK_THRESHOLD_4 = 8'd27;    // 很暗场景阈值4
localparam      VERY_DARK_THRESHOLD_5 = 8'd30;    // 很暗场景阈值5
localparam      DARK_THRESHOLD_1 = 8'd33;         // 暗场景阈值1
localparam      DARK_THRESHOLD_2 = 8'd36;         // 暗场景阈值2
localparam      DARK_THRESHOLD_3 = 8'd39;         // 暗场景阈值3
localparam      DARK_THRESHOLD_4 = 8'd42;         // 暗场景阈值4
localparam      DARK_THRESHOLD_5 = 8'd45;         // 暗场景阈值5
localparam      DARK_THRESHOLD_6 = 8'd48;         // 暗场景阈值6
localparam      DARK_THRESHOLD_7 = 8'd50;         // 暗场景阈值7

localparam      MID_DARK_THRESHOLD_1 = 8'd55;     // 中暗场景阈值1
localparam      MID_DARK_THRESHOLD_2 = 8'd60;     // 中暗场景阈值2
localparam      MID_DARK_THRESHOLD_3 = 8'd65;     // 中暗场景阈值3
localparam      MID_DARK_THRESHOLD_4 = 8'd70;     // 中暗场景阈值4
localparam      MID_DARK_THRESHOLD_5 = 8'd75;     // 中暗场景阈值5
localparam      MID_DARK_THRESHOLD_6 = 8'd80;     // 中暗场景阈值6
localparam      MID_DARK_THRESHOLD_7 = 8'd85;     // 中暗场景阈值7
localparam      MID_DARK_THRESHOLD_8 = 8'd90;     // 中暗场景阈值8
localparam      MID_DARK_THRESHOLD_9 = 8'd95;     // 中暗场景阈值9

localparam      TARGET_BRIGHTNESS = 8'd100;       // 目标亮度

localparam      MID_BRIGHT_THRESHOLD_1 = 8'd105;  // 中亮场景阈值1
localparam      MID_BRIGHT_THRESHOLD_2 = 8'd110;  // 中亮场景阈值2
localparam      MID_BRIGHT_THRESHOLD_3 = 8'd115;  // 中亮场景阈值3
localparam      MID_BRIGHT_THRESHOLD_4 = 8'd120;  // 中亮场景阈值4
localparam      MID_BRIGHT_THRESHOLD_5 = 8'd125;  // 中亮场景阈值5
localparam      MID_BRIGHT_THRESHOLD_6 = 8'd130;  // 中亮场景阈值6
localparam      MID_BRIGHT_THRESHOLD_7 = 8'd135;  // 中亮场景阈值7
localparam      MID_BRIGHT_THRESHOLD_8 = 8'd140;  // 中亮场景阈值8

localparam      BRIGHT_THRESHOLD_1 = 8'd145;      // 亮场景阈值1
localparam      BRIGHT_THRESHOLD_2 = 8'd150;      // 亮场景阈值2
localparam      BRIGHT_THRESHOLD_3 = 8'd155;      // 亮场景阈值3
localparam      BRIGHT_THRESHOLD_4 = 8'd160;      // 亮场景阈值4
localparam      BRIGHT_THRESHOLD_5 = 8'd165;      // 亮场景阈值5
localparam      BRIGHT_THRESHOLD_6 = 8'd170;      // 亮场景阈值6
localparam      BRIGHT_THRESHOLD_7 = 8'd175;      // 亮场景阈值7

localparam      VERY_BRIGHT_THRESHOLD_1 = 8'd180; // 很亮场景阈值1
localparam      VERY_BRIGHT_THRESHOLD_2 = 8'd185; // 很亮场景阈值2
localparam      VERY_BRIGHT_THRESHOLD_3 = 8'd190; // 很亮场景阈值3
localparam      VERY_BRIGHT_THRESHOLD_4 = 8'd195; // 很亮场景阈值4
localparam      VERY_BRIGHT_THRESHOLD_5 = 8'd200; // 很亮场景阈值5

// 增益控制参数 - 扩大增益范围，增强暗处处理
localparam      GAIN_MIN = 8'h10;       // 最小增益值
localparam      GAIN_MAX = 8'hFF;       // 最大增益值（使用全范围）
localparam      GAIN_DEFAULT = 8'h60;   // 提高默认增益值

// 1280x720分辨率相关参数
localparam      PIXEL_COUNT = 20'd921600; // 1280x720 = 921600像素
localparam      SHIFT_BITS = 20;          // 最接近的2的幂是2^20=1048576

// 稳定帧数与调整周期、增益步长上限
localparam      STABLE_FRAME_CNT = 3;   // 需要连续几帧才认为稳定
localparam      ADJUST_PERIOD = 4;      // 每 N 帧允许一次调整
localparam      MAX_GAIN_STEP = 8'd16;  // 每次实际增益最大变化，防突变


// 输入数据延迟链
reg   [7:0]     y_data_r [0:DELAY_CYCLES-1];

/*****************************************************************
                        同步信号延迟处理                                
*****************************************************************/

// 场同步信号延迟链
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        vsync_r <= 0;
    end
    else begin
        vsync_r <= {vsync_r[DELAY_CYCLES-2:0], I_vsync};
    end
end

// 行有效信号延迟链
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        href_r <= 0;
    end
    else begin
        href_r <= {href_r[DELAY_CYCLES-2:0], I_href};
    end
end

// Y数据延迟链
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        y_data_r[0] <= 0;
        y_data_r[1] <= 0;
    end
    else begin
        y_data_r[0] <= I_y_data;
        y_data_r[1] <= y_data_r[0];
    end
end

/*****************************************************************
                        Y分量输出 - 直接传递                            
*****************************************************************/

// 直接传递输入数据，不进行像素级调整
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        Y_out <= 0;
    end
    else if(href_r[DELAY_CYCLES-1]) begin
        Y_out <= y_data_r[DELAY_CYCLES-1];  // 直接输出延迟后的原始数据
    end
end

assign O_vsync = vsync_r[DELAY_CYCLES-1];
assign O_href  = href_r[DELAY_CYCLES-1];

assign O_y_data = Y_out;

// 帧结束检测
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        frame_end <= 0;
    end
    else if(vsync_r[DELAY_CYCLES-1] && ~vsync_r[DELAY_CYCLES-2]) begin  // 检测场同步上升沿
        frame_end <= 1;
    end
    else begin
        frame_end <= 0;
    end
end


// 像素计数和亮度累加（单一驱动：负责累加、帧尾清零并更新 Y_avg/last_Y_avg）
wire [7:0] computed_avg;
assign computed_avg = (pixel_cnt != 0) ? Y_sum[27:20] : Y_avg;

always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        pixel_cnt <= 0;
        Y_sum <= 0;
        Y_avg <= 0;
        last_Y_avg <= 0;
    end
    else if(frame_end) begin
        // 在帧尾由此块负责保存并清零，保证单一驱动
        last_Y_avg <= Y_avg;
        Y_avg <= computed_avg;
        pixel_cnt <= 0;
        Y_sum <= 0;
    end
    else begin
        if(href_r[0]) begin  // 使用延迟前的 href 采样
            pixel_cnt <= pixel_cnt + 1;
            Y_sum <= Y_sum + y_data_r[0];
        end
    end
end

/*****************************************************************
                        按键去抖与触发逻辑
*****************************************************************/

// 增加按键去抖与触发逻辑
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        inc_cnt <= 0;
        dec_cnt <= 0;
        inc_trig <= 0;
        dec_trig <= 0;
        inc_locked <= 0;
        dec_locked <= 0;
    end
    else begin
        // 增加按键处理
        if(!I_increase) begin  // 按键按下（低电平）
            if(inc_cnt < 4'd10) begin
                inc_cnt <= inc_cnt + 1;
            end
            if(inc_cnt == 4'd9 && !inc_locked) begin  // 达到去抖阈值且未锁定
                inc_trig <= 1;
                inc_locked <= 1;  // 锁定，防止重复触发
            end
            else begin
                inc_trig <= 0;
            end
        end
        else begin  // 按键释放
            inc_cnt <= 0;
            inc_trig <= 0;
            inc_locked <= 0;  // 释放锁定
        end

        // 减少按键处理
        if(!I_decrease) begin  // 按键按下（低电平）
            if(dec_cnt < 4'd10) begin
                dec_cnt <= dec_cnt + 1;
            end
            if(dec_cnt == 4'd9 && !dec_locked) begin  // 达到去抖阈值且未锁定
                dec_trig <= 1;
                dec_locked <= 1;  // 锁定，防止重复触发
            end
            else begin
                dec_trig <= 0;
            end
        end
        else begin  // 按键释放
            dec_cnt <= 0;
            dec_trig <= 0;
            dec_locked <= 0;  // 释放锁定
        end
    end
end

/*****************************************************************
                        增益控制逻辑
*****************************************************************/

// 在帧尾执行平均计算（位移近似）、稳定检测、目标增益计算与应用
always @(posedge I_clk or negedge I_rst_n) begin
    if(!I_rst_n) begin
        stable_counter <= 0;
        gain_stable <= 0;
        adjust_counter <= 0;
        target_gain <= GAIN_DEFAULT;
        current_gain <= GAIN_DEFAULT;
        O_gain_update_en_auto <= 0;
        O_gain_reg_data_auto <= GAIN_DEFAULT;
        O_gain_update_en_manual <= 0;
        O_gain_reg_data_manual <= GAIN_DEFAULT;
    end
    else begin
        // 默认每周期清除手动通道的使能脉冲（手动由按键触发单周期）
        O_gain_update_en_manual <= 0;

        // 立即响应手动按键（无需等待帧尾），仅在手动模式（I_switch==0）下生效
        if(!I_switch) begin
            if(inc_trig) begin
                // 手动增加，饱和到 GAIN_MAX
                next_gain = (current_gain >= GAIN_MAX) ? GAIN_MAX : current_gain + 8'h05;
                current_gain <= next_gain;
                target_gain <= next_gain;
                O_gain_update_en_manual <= 1;
                O_gain_reg_data_manual <= next_gain;
            end
            else if(dec_trig) begin
                // 手动减小，饱和到 GAIN_MIN
                next_gain = (current_gain <= GAIN_MIN) ? GAIN_MIN : current_gain - 8'h05;
                current_gain <= next_gain;
                target_gain <= next_gain;
                O_gain_update_en_manual <= 1;
                O_gain_reg_data_manual <= next_gain;
            end
            // 手动模式下不执行自动算法（跳过下面自动逻辑），但仍需维护 adjust_counter
            // 增加 adjust_counter 保持一致性
            if(frame_end) adjust_counter <= adjust_counter + 1;
        end

        // 自动模式和帧尾相关处理（仅在自动模式下允许自动调整）
        if(frame_end) begin
            // 增加 adjust_counter
            adjust_counter <= adjust_counter + 1;

            // 稳定检测：基于本帧计算值与上一帧的 last_Y_avg
            if(computed_avg == last_Y_avg || ((computed_avg>last_Y_avg?computed_avg-last_Y_avg:last_Y_avg-computed_avg) < 5)) begin
                if(stable_counter >= STABLE_FRAME_CNT-1) begin
                    gain_stable <= 1;
                end
                else begin
                    stable_counter <= stable_counter + 1;
                    gain_stable <= 0;
                end
            end
            else begin
                stable_counter <= 0;
                gain_stable <= 0;
            end
            
            // 计算目标增益（依据 computed_avg）- 使用大量阈值实现极其平滑的亮度变化
            computed_target = current_gain;
            
            // 极暗区域 (0-30)
            if(computed_avg < EXTREME_DARK_THRESHOLD) begin
                computed_target = (current_gain + 8'h40 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h40;
            end
            else if(computed_avg < VERY_DARK_THRESHOLD_1) begin
                computed_target = (current_gain + 8'h38 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h38;
            end
            else if(computed_avg < VERY_DARK_THRESHOLD_2) begin
                computed_target = (current_gain + 8'h35 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h35;
            end
            else if(computed_avg < VERY_DARK_THRESHOLD_3) begin
                computed_target = (current_gain + 8'h32 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h32;
            end
            else if(computed_avg < VERY_DARK_THRESHOLD_4) begin
                computed_target = (current_gain + 8'h2E > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h2E;
            end
            else if(computed_avg < VERY_DARK_THRESHOLD_5) begin
                computed_target = (current_gain + 8'h2A > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h2A;
            end
            
            // 暗区域 (30-50)
            else if(computed_avg < DARK_THRESHOLD_1) begin
                computed_target = (current_gain + 8'h26 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h26;
            end
            else if(computed_avg < DARK_THRESHOLD_2) begin
                computed_target = (current_gain + 8'h22 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h22;
            end
            else if(computed_avg < DARK_THRESHOLD_3) begin
                computed_target = (current_gain + 8'h1E > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h1E;
            end
            else if(computed_avg < DARK_THRESHOLD_4) begin
                computed_target = (current_gain + 8'h1A > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h1A;
            end
            else if(computed_avg < DARK_THRESHOLD_5) begin
                computed_target = (current_gain + 8'h16 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h16;
            end
            else if(computed_avg < DARK_THRESHOLD_6) begin
                computed_target = (current_gain + 8'h12 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h12;
            end
            else if(computed_avg < DARK_THRESHOLD_7) begin
                computed_target = (current_gain + 8'h0E > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h0E;
            end
            
            // 50~100区间 - 中暗区域
            else if(computed_avg < MID_DARK_THRESHOLD_1) begin
                computed_target = (current_gain + 8'h0C > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h0C;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_2) begin
                computed_target = (current_gain + 8'h0A > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h0A;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_3) begin
                computed_target = (current_gain + 8'h08 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h08;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_4) begin
                computed_target = (current_gain + 8'h06 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h06;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_5) begin
                computed_target = (current_gain + 8'h05 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h05;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_6) begin
                computed_target = (current_gain + 8'h04 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h04;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_7) begin
                computed_target = (current_gain + 8'h03 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h03;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_8) begin
                computed_target = (current_gain + 8'h02 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h02;
            end
            else if(computed_avg < MID_DARK_THRESHOLD_9) begin
                computed_target = (current_gain + 8'h01 > GAIN_MAX) ? GAIN_MAX : current_gain + 8'h01;
            end
            
            // 100~140区间 - 中亮区域
            else if(computed_avg < MID_BRIGHT_THRESHOLD_1) begin
                computed_target = (current_gain < (8'h01 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h01;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_2) begin
                computed_target = (current_gain < (8'h02 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h02;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_3) begin
                computed_target = (current_gain < (8'h03 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h03;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_4) begin
                computed_target = (current_gain < (8'h04 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h04;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_5) begin
                computed_target = (current_gain < (8'h05 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h05;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_6) begin
                computed_target = (current_gain < (8'h06 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h06;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_7) begin
                computed_target = (current_gain < (8'h08 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h08;
            end
            else if(computed_avg < MID_BRIGHT_THRESHOLD_8) begin
                computed_target = (current_gain < (8'h0A + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h0A;
            end
            
            // 亮区域 (140-175)
            else if(computed_avg < BRIGHT_THRESHOLD_1) begin
                computed_target = (current_gain < (8'h0C + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h0C;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_2) begin
                computed_target = (current_gain < (8'h0E + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h0E;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_3) begin
                computed_target = (current_gain < (8'h10 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h10;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_4) begin
                computed_target = (current_gain < (8'h12 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h12;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_5) begin
                computed_target = (current_gain < (8'h14 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h14;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_6) begin
                computed_target = (current_gain < (8'h16 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h16;
            end
            else if(computed_avg < BRIGHT_THRESHOLD_7) begin
                computed_target = (current_gain < (8'h18 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h18;
            end
            
            // 很亮区域 (175-200+)
            else if(computed_avg < VERY_BRIGHT_THRESHOLD_1) begin
                computed_target = (current_gain < (8'h1A + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h1A;
            end
            else if(computed_avg < VERY_BRIGHT_THRESHOLD_2) begin
                computed_target = (current_gain < (8'h1C + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h1C;
            end
            else if(computed_avg < VERY_BRIGHT_THRESHOLD_3) begin
                computed_target = (current_gain < (8'h1E + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h1E;
            end
            else if(computed_avg < VERY_BRIGHT_THRESHOLD_4) begin
                computed_target = (current_gain < (8'h20 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h20;
            end
            else begin // 200+
                computed_target = (current_gain < (8'h25 + GAIN_MIN)) ? GAIN_MIN : current_gain - 8'h25;
            end

            // 自动应用增益仅在自动模式下执行
            prev_gain = current_gain;
            if(I_switch && gain_stable && (adjust_counter >= ADJUST_PERIOD-1)) begin
                if(computed_target > current_gain) begin
                    if((computed_target - current_gain) > MAX_GAIN_STEP) next_gain = current_gain + MAX_GAIN_STEP;
                    else next_gain = computed_target;
                end
                else begin
                    if((current_gain - computed_target) > MAX_GAIN_STEP) next_gain = current_gain - MAX_GAIN_STEP;
                    else next_gain = computed_target;
                end

                current_gain <= next_gain;
                target_gain <= computed_target;

                if(next_gain != prev_gain) begin
                    O_gain_update_en_auto <= 1;
                    O_gain_reg_data_auto <= next_gain;
                end
                else begin
                    O_gain_update_en_auto <= 0;
                end

                // 重置调整计数器，避免连续快速调整
                adjust_counter <= 0;
            end
            else begin
                O_gain_update_en_auto <= 0;
                target_gain <= computed_target;
            end
        end // frame_end
    end
end

endmodule