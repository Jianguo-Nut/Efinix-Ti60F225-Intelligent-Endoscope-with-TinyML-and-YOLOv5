module RGB2HSV (
    //global clock
    input               clk,                //cmos video pixel clock
    input               rst_n,              //global reset

    //Image data prepred to be processed
    input               per_img_vsync,      //Prepared Image data vsync valid signal
    input               per_img_href,       //Prepared Image data href vaild signal
    input       [7:0]   per_img_red,        //Prepared Image red data to be processed
    input       [7:0]   per_img_green,      //Prepared Image green data to be processed
    input       [7:0]   per_img_blue,       //Prepared Image blue data to be processed
    
    //Image data has been processed
    output              post_img_vsync,     //Processed Image data vsync valid signal
    output              post_img_href,      //Processed Image data href vaild signal
    output      [7:0]   post_img_H,         //Processed Image Hue output
    output      [7:0]   post_img_S,         //Processed Image Saturation output
    output      [7:0]   post_img_V          //Processed Image Value output
);

// =============================================================================
// 信号定义
// =============================================================================
// 流水线控制信号
reg [2:0] vsync_delay;
reg [2:0] href_delay;

// RGB最大值和最小值计算
reg [7:0] max_rgb;
reg [7:0] min_rgb;
reg [7:0] delta;

// 分量识别
reg [1:0] max_component; // 00:R, 01:G, 10:B

// 中间计算结果
reg [15:0] h_temp;
reg [15:0] s_temp;

// 除法器相关信号
wire [15:0] div_quotient;
wire [7:0] div_remain;
wire div_rfd;

// 除法器输入信号
reg [15:0] div_numer;
reg [7:0] div_denom;
reg div_clken;

// 状态机控制
reg [2:0] calc_state;

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
        vsync_delay <= 3'b0;
        href_delay <= 3'b0;
    end else begin
        vsync_delay <= {vsync_delay[1:0], per_img_vsync};
        href_delay <= {href_delay[1:0], per_img_href};
    end
end

assign post_img_vsync = vsync_delay[2];
assign post_img_href = href_delay[2];

// =============================================================================
// 阶段1：计算最大值、最小值和delta
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        max_rgb <= 8'd0;
        min_rgb <= 8'd0;
        delta <= 8'd0;
        max_component <= 2'b00;
    end else if (per_img_href) begin
        // 计算最大值
        if (per_img_red >= per_img_green && per_img_red >= per_img_blue) begin
            max_rgb <= per_img_red;
            max_component <= 2'b00; // R最大
        end else if (per_img_green >= per_img_red && per_img_green >= per_img_blue) begin
            max_rgb <= per_img_green;
            max_component <= 2'b01; // G最大
        end else begin
            max_rgb <= per_img_blue;
            max_component <= 2'b10; // B最大
        end
        
        // 计算最小值
        if (per_img_red <= per_img_green && per_img_red <= per_img_blue) begin
            min_rgb <= per_img_red;
        end else if (per_img_green <= per_img_red && per_img_green <= per_img_blue) begin
            min_rgb <= per_img_green;
        end else begin
            min_rgb <= per_img_blue;
        end
        
        // 计算delta
        delta <= max_rgb - min_rgb;
    end
end

// =============================================================================
// 阶段2：计算H分量分子部分
// =============================================================================
reg [1:0] max_component_d1;
reg [7:0] delta_d1;
reg [7:0] max_rgb_d1;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        h_temp <= 16'd0;
        max_component_d1 <= 2'b00;
        delta_d1 <= 8'd0;
        max_rgb_d1 <= 8'd0;
    end else if (href_delay[0]) begin
        max_component_d1 <= max_component;
        delta_d1 <= delta;
        max_rgb_d1 <= max_rgb;
        
        // 根据最大分量计算H的分子部分
        case (max_component)
            2'b00: begin // R最大
                h_temp <= (per_img_green >= per_img_blue) ? 
                         (per_img_green - per_img_blue) * 16'd43 : 
                         (per_img_green - per_img_blue + 8'd255) * 16'd43;
            end
            2'b01: begin // G最大
                h_temp <= (per_img_blue >= per_img_red) ? 
                         (per_img_blue - per_img_red) * 16'd43 + 16'd85 : 
                         (per_img_blue - per_img_red + 8'd255) * 16'd43 + 16'd85;
            end
            2'b10: begin // B最大
                h_temp <= (per_img_red >= per_img_green) ? 
                         (per_img_red - per_img_green) * 16'd43 + 16'd170 : 
                         (per_img_red - per_img_green + 8'd255) * 16'd43 + 16'd170;
            end
            default: h_temp <= 16'd0;
        endcase
    end
end

// =============================================================================
// 阶段3：除法计算控制
// =============================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        div_numer <= 16'd0;
        div_denom <= 8'd0;
        div_clken <= 1'b0;
        calc_state <= 3'd0;
    end else if (href_delay[1]) begin
        case (calc_state)
            3'd0: begin // H分量除法
                div_numer <= h_temp;
                div_denom <= delta_d1;
                div_clken <= (delta_d1 != 8'd0);
                calc_state <= 3'd1;
            end
            3'd1: begin // S分量除法
                div_numer <= delta_d1 * 16'd255;
                div_denom <= max_rgb_d1;
                div_clken <= (max_rgb_d1 != 8'd0);
                calc_state <= 3'd2;
            end
            default: begin
                div_clken <= 1'b0;
                calc_state <= 3'd0;
            end
        endcase
    end else begin
        div_clken <= 1'b0;
        calc_state <= 3'd0;
    end
end

// =============================================================================
// 阶段4：输出结果
// =============================================================================
reg [7:0] H_out, S_out, V_out;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        H_out <= 8'd0;
        S_out <= 8'd0;
        V_out <= 8'd0;
    end else if (href_delay[2]) begin
        // V分量直接输出最大值
        V_out <= max_rgb_d1;
        
        // H分量处理（使用除法器结果）
        if (delta_d1 == 8'd0) begin
            H_out <= 8'd0; // 无色相
        end else begin
            // 限制H在0-255范围内
            H_out <= (div_quotient[7:0] > 8'd255) ? 8'd255 : div_quotient[7:0];
        end
        
        // S分量处理（使用除法器结果）
        if (max_rgb_d1 == 8'd0) begin
            S_out <= 8'd0; // 无饱和度
        end else begin
            S_out <= div_quotient[7:0]; // 255 * delta / max_rgb
        end
    end
end

assign post_img_H = H_out;
assign post_img_S = S_out;
assign post_img_V = V_out;

endmodule