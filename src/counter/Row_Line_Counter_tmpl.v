wire    clk       ;
wire    rst_n     ;
wire    sta_vsync ;
wire    sta_hsync ;
wire    sta_valid ;
wire [10:0] cnt_pixel;
wire [10:0] cnt_row;

Row_Line_Counter  u_Row_Line_Counter (
    .Data_clk                          (clk               ),
    .Data_rst_n                        (rst_n             ),
    .Data_vsync                        (sta_vsync         ),
    .Data_hsync                        (sta_hsync         ),//用于统计行
    .Data_valid                        (sta_valid         ),//用于统计每一行的像素

    .cnt_pixel                         (cnt_pixel   [10:0]),
    .cnt_row                           (cnt_row     [10:0]) 
);