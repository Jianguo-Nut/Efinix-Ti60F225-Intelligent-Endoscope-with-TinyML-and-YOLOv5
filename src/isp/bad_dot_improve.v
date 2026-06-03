// =========================================================================================================================================
// DPC (Dead Pixel Correction) - 坏点校正模块
// =========================================================================================================================================
module bad_dot_improve #(
    parameter IMG_HDISP = 1280,  // 图像水平分辨率
    parameter IMG_VDISP = 960    // 图像垂直分辨率
) (
    // 系统信号
    input  wire        clk,                // 像素时钟
    input  wire        rst_n,              // 复位信号（低有效）
    
    // 输入视频流接口
    input  wire        per_frame_vsync,    // 输入场同步信号
    input  wire        per_frame_href,     // 输入行有效信号
    input  wire        per_frame_hsync,    // 输入行同步信号
    input  wire [7:0]  per_img_RAW,        // 输入RAW图像数据
    
    // 输出视频流接口
    output reg         post_frame_vsync,   // 输出场同步信号
    output reg         post_frame_href,    // 输出行有效信号
    output reg         post_frame_hsync,   // 输出行同步信号
    output reg  [7:0]  final_data          // 输出校正后数据
);

// ===================================================================
// 内部信号定义
// ===================================================================
// 坏点检测阈值
localparam THRESHOLD_HIGH = 8'd40;  // 坏点检测高阈值

// 3x3矩阵信号
wire        matrix_frame_vsync;
wire        matrix_frame_href;
wire        matrix_frame_hsync;
wire [7:0]  matrix_p11, matrix_p12, matrix_p13;
wire [7:0]  matrix_p21, matrix_p22, matrix_p23;
wire [7:0]  matrix_p31, matrix_p32, matrix_p33;

// 校正后像素
reg [7:0] corrected_pixel;

// ===================================================================
// 3x3矩阵生成模块例化
// ===================================================================
VIP_Matrix_Generate_3X3_8Bit #(
    .IMG_HDISP (IMG_HDISP),
    .IMG_VDISP (IMG_VDISP)
) u_VIP_Matrix_Generate_3X3_8Bit (
    // 全局时钟
    .clk                    (clk),
    .rst_n                  (rst_n),
    
    // 输入图像数据
    .per_frame_vsync        (per_frame_vsync),
    .per_frame_href         (per_frame_href),
    .per_frame_hsync        (per_frame_hsync),
    .per_img_Y              (per_img_RAW),
    
    // 输出矩阵数据
    .matrix_frame_vsync     (matrix_frame_vsync),
    .matrix_frame_href      (matrix_frame_href),
    .matrix_frame_hsync     (matrix_frame_hsync),
    
    // 3x3矩阵输出
    .matrix_p11             (matrix_p11),
    .matrix_p12             (matrix_p12),
    .matrix_p13             (matrix_p13),
    .matrix_p21             (matrix_p21),
    .matrix_p22             (matrix_p22),
    .matrix_p23             (matrix_p23),
    .matrix_p31             (matrix_p31),
    .matrix_p32             (matrix_p32),
    .matrix_p33             (matrix_p33)
);

// ===================================================================
// 坏点检测与校正算法
// ===================================================================
reg [8:0] diff_h, diff_v, diff_d1, diff_d2;
reg [8:0] max_diff;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        diff_h          <= 9'd0;
        diff_v          <= 9'd0;
        diff_d1         <= 9'd0;
        diff_d2         <= 9'd0;
        max_diff        <= 9'd0;
        corrected_pixel <= 8'd0;
    end else if (matrix_frame_href) begin
        // 计算当前像素与邻域像素的差异
        // 水平方向差异 (左-右)
        diff_h <= (matrix_p23 > matrix_p21) ? 
                 (matrix_p23 - matrix_p21) : 
                 (matrix_p21 - matrix_p23);
        
        // 垂直方向差异 (上-下)
        diff_v <= (matrix_p12 > matrix_p32) ? 
                 (matrix_p12 - matrix_p32) : 
                 (matrix_p32 - matrix_p12);
        
        // 对角线方向差异1 (左上-右下)
        diff_d1 <= (matrix_p11 > matrix_p33) ? 
                  (matrix_p11 - matrix_p33) : 
                  (matrix_p33 - matrix_p11);
        
        // 对角线方向差异2 (右上-左下)
        diff_d2 <= (matrix_p13 > matrix_p31) ? 
                  (matrix_p13 - matrix_p31) : 
                  (matrix_p31 - matrix_p13);
        
        // 找出最大差异
        max_diff <= diff_h;
        if (diff_v > max_diff)  max_diff <= diff_v;
        if (diff_d1 > max_diff) max_diff <= diff_d1;
        if (diff_d2 > max_diff) max_diff <= diff_d2;
        
        // 坏点检测条件
        if (max_diff > THRESHOLD_HIGH) begin
            // 检测到可能的坏点，使用中值滤波进行校正
            corrected_pixel <= median_filter_3x3(
                matrix_p11, matrix_p12, matrix_p13,
                matrix_p21, matrix_p22, matrix_p23,
                matrix_p31, matrix_p32, matrix_p33
            );
        end else begin
            // 正常像素，直接输出中心像素
            corrected_pixel <= matrix_p22;
        end
        
    end else begin
        // 非有效数据期间
        corrected_pixel <= 8'd0;
        diff_h   <= 9'd0;
        diff_v   <= 9'd0;
        diff_d1  <= 9'd0;
        diff_d2  <= 9'd0;
        max_diff <= 9'd0;
    end
end

// ===================================================================
// 3x3中值滤波函数
// ===================================================================
function [7:0] median_filter_3x3;
    input [7:0] p11, p12, p13;
    input [7:0] p21, p22, p23;
    input [7:0] p31, p32, p33;
    
    reg [7:0] temp [0:8];
    reg [7:0] swap_temp;
    integer i, j;
    begin
        // 复制像素值到临时数组
        temp[0] = p11; temp[1] = p12; temp[2] = p13;
        temp[3] = p21; temp[4] = p22; temp[5] = p23;
        temp[6] = p31; temp[7] = p32; temp[8] = p33;
        
        // 使用冒泡排序找到中值
        for (i = 0; i < 8; i = i + 1) begin
            for (j = i + 1; j < 9; j = j + 1) begin
                if (temp[i] > temp[j]) begin
                    swap_temp = temp[i];
                    temp[i] = temp[j];
                    temp[j] = swap_temp;
                end
            end
        end
        
        // 返回中值（排序后的第5个元素）
        median_filter_3x3 = temp[4];
    end
endfunction

// ===================================================================
// 输出寄存器
// ===================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        post_frame_vsync <= 1'b0;
        post_frame_href  <= 1'b0;
        post_frame_hsync <= 1'b0;
        final_data       <= 8'd0;
    end else begin
        // 输出控制信号（直接使用矩阵生成模块的输出）
        post_frame_vsync <= matrix_frame_vsync;
        post_frame_href  <= matrix_frame_href;
        post_frame_hsync <= matrix_frame_hsync;
        
        // 输出校正后的像素数据
        final_data <= corrected_pixel;
    end
end

endmodule