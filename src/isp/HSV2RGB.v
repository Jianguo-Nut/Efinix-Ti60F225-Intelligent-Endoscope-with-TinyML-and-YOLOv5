module HSV2RGB (
    //global clock
    input               clk,                //cmos video pixel clock
    input               rst_n,              //global reset

    //Image data prepared to be processed
    input               per_img_vsync,      //Prepared Image data vsync valid signal
    input               per_img_href,       //Prepared Image data href valid signal
    input       [7:0]   per_img_H,          //Prepared Image Hue input
    input       [7:0]   per_img_S,          //Prepared Image Saturation input
    input       [7:0]   per_img_V,          //Prepared Image Value input
    
    //Image data has been processed
    output              post_img_vsync,     //Processed Image data vsync valid signal
    output              post_img_href,      //Processed Image data href valid signal
    output      [7:0]   post_img_red,       //Processed Image red output
    output      [7:0]   post_img_green,     //Processed Image green output
    output      [7:0]   post_img_blue       //Processed Image blue output
);

// =============================================================================
// 信号定义
// =============================================================================
// 流水线控制信号
reg [3:0] vsync_delay;
reg [3:0] href_delay;

// 输入信号寄存器
reg [7:0] H_reg, S_reg, V_reg;
reg [7:0] H_d1, S_d1, V_d1;
reg [7:0] H_d2, S_d2, V_d2;

// 中间计算变量
reg [7:0] region;          // 色相区域 (0-5)
reg [7:0] remainder;       // 色相余数
reg [7:0] p, q, t;         // 中间变量
reg [7:0] ff;              // 分数部分 * 255

// 除法器相关信号
wire [15:0] div_quotient;
wire [7:0] div_remain;
wire div_rfd;

// 除法器输入信号
reg [15:0] div_numer;
reg [7:0] div_denom;
reg div_clken;

// 计算状态机
reg [2:0] calc_state;

// RGB中间结果
reg [7:0] r_temp, g_temp, b_temp;

// =============================================================================
// 除法器实例化
// =============================================================================
divider u_divider (
    .numer(div_numer),
    .denom(div_denom),
    .clken(div_clken),
    .clk(clk),
    .reset(~rst_n),        // 注意复位极性转换
    .quotient(div_quotient),
    .remain(div_remain)
);

// =============================================================================
// 流水线控制信号延迟
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        vsync_delay <= 4'b0;
        href_delay <= 4'b0;
    end else begin
        vsync_delay <= {vsync_delay[2:0], per_img_vsync};
        href_delay <= {href_delay[2:0], per_img_href};
    end
end

assign post_img_vsync = vsync_delay[3];
assign post_img_href = href_delay[3];

// =============================================================================
// 阶段1：输入寄存和预处理
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        H_reg <= 8'd0;
        S_reg <= 8'd0;
        V_reg <= 8'd0;
        H_d1 <= 8'd0;
        S_d1 <= 8'd0;
        V_d1 <= 8'd0;
    end else if (per_img_href) begin
        // 寄存输入信号
        H_reg <= per_img_H;
        S_reg <= per_img_S;
        V_reg <= per_img_V;
        
        // 一级延迟
        H_d1 <= H_reg;
        S_d1 <= S_reg;
        V_d1 <= V_reg;
    end
end

// =============================================================================
// 阶段2：计算色相区域和余数
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        region <= 8'd0;
        remainder <= 8'd0;
        H_d2 <= 8'd0;
        S_d2 <= 8'd0;
        V_d2 <= 8'd0;
    end else if (href_delay[0]) begin
        H_d2 <= H_d1;
        S_d2 <= S_d1;
        V_d2 <= V_d1;
        
        // 计算色相区域 (每个区域43个值，因为255/6≈42.5)
        if (H_d1 < 43) begin           // 0-42: 红色到黄色
            region <= 8'd0;
            remainder <= H_d1;
        end else if (H_d1 < 85) begin  // 43-84: 黄色到绿色
            region <= 8'd1;
            remainder <= H_d1 - 8'd43;
        end else if (H_d1 < 128) begin // 85-127: 绿色到青色
            region <= 8'd2;
            remainder <= H_d1 - 8'd85;
        end else if (H_d1 < 170) begin // 128-169: 青色到蓝色
            region <= 8'd3;
            remainder <= H_d1 - 8'd128;
        end else if (H_d1 < 213) begin // 170-212: 蓝色到品红
            region <= 8'd4;
            remainder <= H_d1 - 8'd170;
        end else begin                 // 213-255: 品红到红色
            region <= 8'd5;
            remainder <= H_d1 - 8'd213;
        end
    end
end

// =============================================================================
// 阶段3：计算中间变量
// =============================================================================
reg [7:0] region_d1;
reg [7:0] remainder_d1;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p <= 8'd0;
        q <= 8'd0;
        t <= 8'd0;
        ff <= 8'd0;
        region_d1 <= 8'd0;
        remainder_d1 <= 8'd0;
        calc_state <= 3'd0;
        div_numer <= 16'd0;
        div_denom <= 8'd0;
        div_clken <= 1'b0;
    end else if (href_delay[1]) begin
        region_d1 <= region;
        remainder_d1 <= remainder;
        
        case (calc_state)
            3'd0: begin
                // 计算 p = V * (255 - S) / 255
                div_numer <= V_d2 * (16'd255 - {8'd0, S_d2});
                div_denom <= 8'd255;
                div_clken <= 1'b1;
                calc_state <= 3'd1;
            end
            3'd1: begin
                div_clken <= 1'b0;
                p <= (div_quotient > 255) ? 8'd255 : div_quotient[7:0];
                calc_state <= 3'd2;
            end
            3'd2: begin
                // 计算 ff = remainder * 255 / 43 (近似6倍)
                div_numer <= remainder_d1 * 16'd255;
                div_denom <= 8'd43;
                div_clken <= 1'b1;
                calc_state <= 3'd3;
            end
            3'd3: begin
                div_clken <= 1'b0;
                ff <= (div_quotient > 255) ? 8'd255 : div_quotient[7:0];
                calc_state <= 3'd4;
            end
            3'd4: begin
                // 计算 q = V * (255 - S * ff / 255) / 255
                div_numer <= {8'd0, S_d2} * {8'd0, ff};
                div_denom <= 8'd255;
                div_clken <= 1'b1;
                calc_state <= 3'd5;
            end
            3'd5: begin
                div_clken <= 1'b0;
                // 第二级除法：V * (255 - 上面结果) / 255
                div_numer <= V_d2 * (16'd255 - div_quotient);
                div_denom <= 8'd255;
                div_clken <= 1'b1;
                calc_state <= 3'd6;
            end
            3'd6: begin
                div_clken <= 1'b0;
                q <= (div_quotient > 255) ? 8'd255 : div_quotient[7:0];
                calc_state <= 3'd7;
            end
            3'd7: begin
                // 计算 t = V * (255 - S * (255 - ff) / 255) / 255
                div_numer <= {8'd0, S_d2} * (16'd255 - {8'd0, ff});
                div_denom <= 8'd255;
                div_clken <= 1'b1;
                calc_state <= 3'd8;
            end
            3'd8: begin
                div_clken <= 1'b0;
                // 第二级除法
                div_numer <= V_d2 * (16'd255 - div_quotient);
                div_denom <= 8'd255;
                div_clken <= 1'b1;
                calc_state <= 3'd9;
            end
            default: begin
                div_clken <= 1'b0;
                t <= (div_quotient > 255) ? 8'd255 : div_quotient[7:0];
                calc_state <= 3'd0;
            end
        endcase
    end else begin
        div_clken <= 1'b0;
        calc_state <= 3'd0;
    end
end

// =============================================================================
// 阶段4：根据色相区域计算RGB
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        r_temp <= 8'd0;
        g_temp <= 8'd0;
        b_temp <= 8'd0;
    end else if (href_delay[2]) begin
        case (region_d1)
            8'd0: begin // 红色到黄色
                r_temp <= V_d2;
                g_temp <= t;
                b_temp <= p;
            end
            8'd1: begin // 黄色到绿色
                r_temp <= q;
                g_temp <= V_d2;
                b_temp <= p;
            end
            8'd2: begin // 绿色到青色
                r_temp <= p;
                g_temp <= V_d2;
                b_temp <= t;
            end
            8'd3: begin // 青色到蓝色
                r_temp <= p;
                g_temp <= q;
                b_temp <= V_d2;
            end
            8'd4: begin // 蓝色到品红
                r_temp <= t;
                g_temp <= p;
                b_temp <= V_d2;
            end
            8'd5: begin // 品红到红色
                r_temp <= V_d2;
                g_temp <= p;
                b_temp <= q;
            end
            default: begin
                r_temp <= V_d2;
                g_temp <= V_d2;
                b_temp <= V_d2;
            end
        endcase
    end
end

// =============================================================================
// 阶段5：边界处理和输出
// =============================================================================
reg [7:0] red_out, green_out, blue_out;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        red_out <= 8'd0;
        green_out <= 8'd0;
        blue_out <= 8'd0;
    end else if (href_delay[3]) begin
        // 边界处理：确保RGB值在0-255范围内
        red_out <= (r_temp > 8'd255) ? 8'd255 : r_temp;
        green_out <= (g_temp > 8'd255) ? 8'd255 : g_temp;
        blue_out <= (b_temp > 8'd255) ? 8'd255 : b_temp;
        
        // 特殊情况的边界处理
        if (S_d2 == 8'd0) begin // 饱和度为0，显示灰度
            red_out <= V_d2;
            green_out <= V_d2;
            blue_out <= V_d2;
        end else if (V_d2 == 8'd0) begin // 明度为0，显示黑色
            red_out <= 8'd0;
            green_out <= 8'd0;
            blue_out <= 8'd0;
        end
    end
end

assign post_img_red = red_out;
assign post_img_green = green_out;
assign post_img_blue = blue_out;

endmodule