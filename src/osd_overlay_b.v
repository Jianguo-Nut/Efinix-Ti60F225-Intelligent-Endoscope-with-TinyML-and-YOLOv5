module osd_overlay_b(
    input  wire        clk,
    input  wire        rst_n,
    input  wire        ae_me,
    input  wire        i_hs,
    input  wire        i_vs,
    input  wire        i_de,
    input  wire [7:0]  i_r,
    input  wire [7:0]  i_g,
    input  wire [7:0]  i_b,
    output wire        o_hs,
    output wire        o_vs,
    output wire        o_de,
    output reg  [7:0]  o_r,
    output reg  [7:0]  o_g,
    output reg  [7:0]  o_b
);

    assign o_hs = i_hs;
    assign o_vs = i_vs;
    assign o_de = i_de;

    //==================== Parameters ====================
    localparam H_ACTIVE = 1280;
    localparam V_ACTIVE = 720;

    localparam CHAR_W  = 8;
    localparam CHAR_H  = 12;
    localparam SCALE   = 10;
    localparam CHAR_W_S = CHAR_W * SCALE;  // 80
    localparam CHAR_H_S = CHAR_H * SCALE;  // 120
    localparam CHAR_GAP = 4 * SCALE;       // 40
    localparam CHAR_START_X = H_ACTIVE - CHAR_W_S - 10;
    localparam CHAR_START_Y = 10;

    localparam X_OFFSET = 3;
    localparam Y_OFFSET = 3;

    localparam F_Y_START = CHAR_START_Y + Y_OFFSET;
    localparam F_Y_END   = F_Y_START + CHAR_H_S - 1;

    localparam A_Y_START = F_Y_END + CHAR_GAP + 1;
    localparam A_Y_END   = A_Y_START + CHAR_H_S - 1;

    localparam P_Y_START = A_Y_END + CHAR_GAP + 1;
    localparam P_Y_END   = P_Y_START + CHAR_H_S - 1;

    localparam M_Y_START = P_Y_END + CHAR_GAP + 1;
    localparam M_Y_END   = M_Y_START + CHAR_H_S - 1;

    localparam X_START = CHAR_START_X + X_OFFSET;
    localparam X_END   = X_START + CHAR_W_S - 1;

    //==================== Pixel counters ====================
    reg [10:0] h_cnt;
    reg [10:0] v_cnt;

    //==================== Lookup tables ====================
    reg [3:0] h_table [0:CHAR_W_S-1];
    reg [3:0] v_table [0:CHAR_H_S-1];

    integer i;
    initial begin
        for(i=0;i<10;i=i+1)       h_table[i] = 0;
        for(i=10;i<20;i=i+1)      h_table[i] = 1;
        for(i=20;i<30;i=i+1)      h_table[i] = 2;
        for(i=30;i<40;i=i+1)      h_table[i] = 3;
        for(i=40;i<50;i=i+1)      h_table[i] = 4;
        for(i=50;i<60;i=i+1)      h_table[i] = 5;
        for(i=60;i<70;i=i+1)      h_table[i] = 6;
        for(i=70;i<80;i=i+1)      h_table[i] = 7;

        for(i=0;i<10;i=i+1)       v_table[i] = 0;
        for(i=10;i<20;i=i+1)      v_table[i] = 1;
        for(i=20;i<30;i=i+1)      v_table[i] = 2;
        for(i=30;i<40;i=i+1)      v_table[i] = 3;
        for(i=40;i<50;i=i+1)      v_table[i] = 4;
        for(i=50;i<60;i=i+1)      v_table[i] = 5;
        for(i=60;i<70;i=i+1)      v_table[i] = 6;
        for(i=70;i<80;i=i+1)      v_table[i] = 7;
        for(i=80;i<90;i=i+1)      v_table[i] = 8;
        for(i=90;i<100;i=i+1)     v_table[i] = 9;
        for(i=100;i<110;i=i+1)    v_table[i] =10;
        for(i=110;i<120;i=i+1)    v_table[i] =11;
    end

    //==================== Font bitmaps (8x12) ====================
    function automatic [95:0] font_F(input dummy);
        font_F = {
            8'b11111111,
            8'b11000000,
            8'b11000000,
            8'b11111100,
            8'b11000000,
            8'b11000000,
            8'b11000000,
            8'b11000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000
        };
    endfunction

    function automatic [95:0] font_A(input dummy);
        font_A = {
            8'b00111100,
            8'b01100110,
            8'b11000011,
            8'b11111111,
            8'b11000011,
            8'b11000011,
            8'b11000011,
            8'b11000011,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000
        };
    endfunction

    function automatic [95:0] font_P(input dummy);
        font_P = {
            8'b00011000,
            8'b00011000,
            8'b11111111,
            8'b11111111,
            8'b00011000,
            8'b00011000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000
        };
    endfunction

    function automatic [95:0] font_M(input dummy);
        font_M = {
            8'b00000000,
            8'b00000000,
            8'b11111111,
            8'b11111111,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000
        };
    endfunction

    function automatic [95:0] font_mm(input dummy);
        font_mm = {
            8'b10000001,
            8'b11000011,
            8'b11100111,
            8'b11011011,
            8'b11011011,
            8'b11000011,
            8'b11000011,
            8'b11000011,
            8'b00000000,
            8'b00000000,
            8'b00000000,
            8'b00000000
        };
    endfunction

    //==================== Main logic ====================
    reg [3:0] px, py, px_r;
    reg       font_bit;

    wire [23:0] in_rgb = {i_r, i_g, i_b};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            h_cnt     <= 0;
            v_cnt     <= 0;
            o_r       <= 0;
            o_g       <= 0;
            o_b       <= 0;
            px        <= 0;
            py        <= 0;
            px_r      <= 0;
            font_bit  <= 0;
        end else begin
            {o_r, o_g, o_b} <= in_rgb;

            if (i_de) begin
                if (h_cnt == H_ACTIVE-1) begin
                    h_cnt <= 0;
                    if (v_cnt == V_ACTIVE-1)
                        v_cnt <= 0;
                    else
                        v_cnt <= v_cnt+1;
                end else begin
                    h_cnt <= h_cnt+1;
                end
            end

            font_bit <= 0;

            if (i_de && h_cnt>=X_START && h_cnt<=X_END) begin
                px <= h_table[h_cnt - X_START];
                px_r <= CHAR_W - 1 - px;

                if (v_cnt>=F_Y_START && v_cnt<=F_Y_END) begin
                    py <= v_table[v_cnt - F_Y_START];
                    font_bit <= font_F(1'b0)[(CHAR_H-1-py)*CHAR_W + px_r];
                end
                else if (v_cnt>=A_Y_START && v_cnt<=A_Y_END) begin
                    py <= v_table[v_cnt - A_Y_START];
                    if(ae_me) begin
                        font_bit <= font_A(1'b0)[(CHAR_H-1-py)*CHAR_W + px_r];
                    end
                    else begin
                        font_bit <= font_mm(1'b0)[(CHAR_H-1-py)*CHAR_W + px_r];
                    end
                end
                else if (v_cnt>=P_Y_START && v_cnt<=P_Y_END) begin
                    py <= v_table[v_cnt - P_Y_START];
                    if(~ae_me) begin
                        font_bit <= font_P(1'b0)[(CHAR_H-1-py)*CHAR_W + px_r];
                    end
                end
                else if (v_cnt>=M_Y_START && v_cnt<=M_Y_END) begin
                    py <= v_table[v_cnt - M_Y_START];
                    if(~ae_me) begin
                        font_bit <= font_M(1'b0)[(CHAR_H-1-py)*CHAR_W + px_r];
                    end
                end

                if (font_bit)
                    {o_r, o_g, o_b} <= 24'h000000;
            end
        end
    end

endmodule
