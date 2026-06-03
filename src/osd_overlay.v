module osd_overlay(
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

    localparam CHAR_W   = 8;
    localparam CHAR_H   = 12;
    localparam SCALE    = 10;
    localparam CHAR_W_S = CHAR_W  * SCALE;   // 80
    localparam CHAR_H_S = CHAR_H  * SCALE;   // 120
    localparam CHAR_GAP = 4 * SCALE;          // 40
    localparam CHAR_SX  = H_ACTIVE - CHAR_W_S - 10;
    localparam CHAR_SY  = 10;

    localparam X_OFF = 3;
    localparam Y_OFF = 3;

    // Foreground X range
    localparam FG_X0 = CHAR_SX;
    localparam FG_X1 = FG_X0 + CHAR_W_S - 1;

    // Shadow X range
    localparam SH_X0 = FG_X0 + X_OFF;
    localparam SH_X1 = FG_X1 + X_OFF;

    // Foreground character Y ranges
    localparam FG_F_Y0 = CHAR_SY;
    localparam FG_F_Y1 = FG_F_Y0 + CHAR_H_S - 1;

    localparam FG_A_Y0 = FG_F_Y1 + CHAR_GAP + 1;
    localparam FG_A_Y1 = FG_A_Y0 + CHAR_H_S - 1;

    localparam FG_P_Y0 = FG_A_Y1 + CHAR_GAP + 1;
    localparam FG_P_Y1 = FG_P_Y0 + CHAR_H_S - 1;

    localparam FG_M_Y0 = FG_P_Y1 + CHAR_GAP + 1;
    localparam FG_M_Y1 = FG_M_Y0 + CHAR_H_S - 1;

    // Shadow character Y ranges
    localparam SH_F_Y0 = FG_F_Y0 + Y_OFF;
    localparam SH_F_Y1 = FG_F_Y1 + Y_OFF;

    localparam SH_A_Y0 = FG_A_Y0 + Y_OFF;
    localparam SH_A_Y1 = FG_A_Y1 + Y_OFF;

    localparam SH_P_Y0 = FG_P_Y0 + Y_OFF;
    localparam SH_P_Y1 = FG_P_Y1 + Y_OFF;

    localparam SH_M_Y0 = FG_M_Y0 + Y_OFF;
    localparam SH_M_Y1 = FG_M_Y1 + Y_OFF;

    //==================== Pixel counters ====================
    reg [10:0] h_cnt;
    reg [10:0] v_cnt;

    //==================== Combinational div-by-SCALE (SCALE=10) ====================
    function [2:0] h_div10(input [6:0] n);
        h_div10 = (n >= 70) ? 3'd7 : (n >= 60) ? 3'd6 : (n >= 50) ? 3'd5 :
                  (n >= 40) ? 3'd4 : (n >= 30) ? 3'd3 : (n >= 20) ? 3'd2 :
                  (n >= 10) ? 3'd1 : 3'd0;
    endfunction

    function [3:0] v_div10(input [6:0] n);
        v_div10 = (n >= 110) ? 4'd11 : (n >= 100) ? 4'd10 : (n >= 90) ? 4'd9 :
                  (n >= 80)  ? 4'd8  : (n >= 70)  ? 4'd7  : (n >= 60) ? 4'd6 :
                  (n >= 50)  ? 4'd5  : (n >= 40)  ? 4'd4  : (n >= 30) ? 4'd3 :
                  (n >= 20)  ? 4'd2  : (n >= 10)  ? 4'd1  : 4'd0;
    endfunction

    //==================== Font bitmaps (8x12) ====================
    function automatic [95:0] font_F();
        font_F = {8'b11111111, 8'b11000000, 8'b11000000, 8'b11111100,
                  8'b11000000, 8'b11000000, 8'b11000000, 8'b11000000,
                  8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    endfunction

    function automatic [95:0] font_A();
        font_A = {8'b00111100, 8'b01100110, 8'b11000011, 8'b11111111,
                  8'b11000011, 8'b11000011, 8'b11000011, 8'b11000011,
                  8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    endfunction

    function automatic [95:0] font_P();
        font_P = {8'b00011000, 8'b00011000, 8'b11111111, 8'b11111111,
                  8'b00011000, 8'b00011000, 8'b00000000, 8'b00000000,
                  8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    endfunction

    function automatic [95:0] font_M();
        font_M = {8'b00000000, 8'b00000000, 8'b11111111, 8'b11111111,
                  8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
                  8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    endfunction

    function automatic [95:0] font_MM();
        font_MM = {8'b10000001, 8'b11000011, 8'b11100111, 8'b11011011,
                   8'b11011011, 8'b11000011, 8'b11000011, 8'b11000011,
                   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    endfunction

    function automatic [95:0] char_font(input [2:0] ct, input mode);
        case (ct)
            3'd0: char_font = font_F();
            3'd1: char_font = mode ? font_A() : font_MM();
            3'd2: char_font = font_P();
            3'd3: char_font = font_M();
            default: char_font = 96'd0;
        endcase
    endfunction

    function automatic bit char_en(input [2:0] ct, input mode);
        case (ct)
            3'd0: char_en = 1'b1;
            3'd1: char_en = 1'b1;
            3'd2: char_en = ~mode;
            3'd3: char_en = ~mode;
            default: char_en = 1'b0;
        endcase
    endfunction

    //==================== Main pipeline ====================
    reg fg_font_bit;
    reg sh_font_bit;

    // Combinational intermediates
    reg [2:0]  fg_ct, sh_ct;
    reg [10:0] fg_yb, sh_yb;     // Y base
    reg [2:0]  fg_px, sh_px;     // font column (0..7)
    reg [3:0]  fg_py, sh_py;     // font row (0..11)
    reg        fg_active, sh_active;
    reg        fg_en, sh_en;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            h_cnt       <= 0;
            v_cnt       <= 0;
            o_r         <= 0;
            o_g         <= 0;
            o_b         <= 0;
            fg_font_bit <= 0;
            sh_font_bit <= 0;
        end else begin
            // Default: pass through input
            {o_r, o_g, o_b} <= {i_r, i_g, i_b};

            // Pixel counter
            if (i_de) begin
                if (h_cnt == H_ACTIVE - 1) begin
                    h_cnt <= 0;
                    v_cnt <= (v_cnt == V_ACTIVE - 1) ? 0 : v_cnt + 1;
                end else begin
                    h_cnt <= h_cnt + 1;
                end
            end

            // Default: no font bit for current pixel
            fg_font_bit <= 0;
            sh_font_bit <= 0;

            if (i_de) begin
                // --- Foreground character detection ---
                fg_active = 0;
                if (h_cnt >= FG_X0 && h_cnt <= FG_X1) begin
                    if      (v_cnt >= FG_F_Y0 && v_cnt <= FG_F_Y1) begin fg_ct = 3'd0; fg_yb = FG_F_Y0; fg_active = 1; end
                    else if (v_cnt >= FG_A_Y0 && v_cnt <= FG_A_Y1) begin fg_ct = 3'd1; fg_yb = FG_A_Y0; fg_active = 1; end
                    else if (v_cnt >= FG_P_Y0 && v_cnt <= FG_P_Y1) begin fg_ct = 3'd2; fg_yb = FG_P_Y0; fg_active = 1; end
                    else if (v_cnt >= FG_M_Y0 && v_cnt <= FG_M_Y1) begin fg_ct = 3'd3; fg_yb = FG_M_Y0; fg_active = 1; end
                end

                if (fg_active) begin
                    fg_en = char_en(fg_ct, ae_me);
                    if (fg_en) begin
                        fg_px = h_div10(h_cnt - FG_X0);
                        fg_py = v_div10(v_cnt - fg_yb);
                        fg_font_bit <= char_font(fg_ct, ae_me)[(CHAR_H-1-fg_py)*CHAR_W + (CHAR_W-1-fg_px)];
                    end
                end

                // --- Shadow character detection ---
                sh_active = 0;
                if (h_cnt >= SH_X0 && h_cnt <= SH_X1) begin
                    if      (v_cnt >= SH_F_Y0 && v_cnt <= SH_F_Y1) begin sh_ct = 3'd0; sh_yb = SH_F_Y0; sh_active = 1; end
                    else if (v_cnt >= SH_A_Y0 && v_cnt <= SH_A_Y1) begin sh_ct = 3'd1; sh_yb = SH_A_Y0; sh_active = 1; end
                    else if (v_cnt >= SH_P_Y0 && v_cnt <= SH_P_Y1) begin sh_ct = 3'd2; sh_yb = SH_P_Y0; sh_active = 1; end
                    else if (v_cnt >= SH_M_Y0 && v_cnt <= SH_M_Y1) begin sh_ct = 3'd3; sh_yb = SH_M_Y0; sh_active = 1; end
                end

                if (sh_active) begin
                    sh_en = char_en(sh_ct, ae_me);
                    if (sh_en) begin
                        sh_px = h_div10(h_cnt - SH_X0);
                        sh_py = v_div10(v_cnt - sh_yb);
                        sh_font_bit <= char_font(sh_ct, ae_me)[(CHAR_H-1-sh_py)*CHAR_W + (CHAR_W-1-sh_px)];
                    end
                end
            end

            // Apply overlay using registered font bits (from previous cycle)
            if (fg_font_bit)
                {o_r, o_g, o_b} <= 24'hFFFFFF;
            else if (sh_font_bit)
                {o_r, o_g, o_b} <= 24'h000000;
        end
    end

endmodule
