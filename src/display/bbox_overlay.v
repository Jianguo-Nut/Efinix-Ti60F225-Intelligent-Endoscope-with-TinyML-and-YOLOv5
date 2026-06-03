// Bounding box overlay - draws red rectangles on video stream
// APB-like register interface for SoC to write box coordinates

module bbox_overlay #(
    parameter CAM_W = 1280,
    parameter CAM_H = 720,
    parameter MAX_BOX = 8
) (
    input  wire         clk,
    input  wire         rst_n,

    // Video input (from lcd_driver)
    input  wire         i_hs,
    input  wire         i_vs,
    input  wire         i_de,
    input  wire [7:0]   i_r,
    input  wire [7:0]   i_g,
    input  wire [7:0]   i_b,
    input  wire [11:0]  i_x,    // current pixel X
    input  wire [11:0]  i_y,    // current pixel Y

    // Video output
    output wire         o_hs,
    output wire         o_vs,
    output wire         o_de,
    output wire [7:0]   o_r,
    output wire [7:0]   o_g,
    output wire [7:0]   o_b,

    // Register interface (SoC writes via 32-bit bus)
    // addr[3:0]: 0=cmd, 1=box0_xy, 2=box0_wh, 3=box1_xy, 4=box1_wh, ...
    input  wire         reg_wr,
    input  wire [3:0]   reg_addr,
    input  wire [31:0]  reg_wdata,
    output wire [31:0]  reg_rdata,
    output wire [7:0]   box_count
);

    // Pass through sync signals
    assign o_hs = i_hs;
    assign o_vs = i_vs;
    assign o_de = i_de;

    // Box storage
    reg [11:0] box_x [0:MAX_BOX-1];
    reg [11:0] box_y [0:MAX_BOX-1];
    reg [11:0] box_w [0:MAX_BOX-1];
    reg [11:0] box_h [0:MAX_BOX-1];
    reg        box_valid [0:MAX_BOX-1];
    reg [7:0]  r_box_count;

    assign box_count = r_box_count;

    // Register write
    integer bi;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (bi = 0; bi < MAX_BOX; bi = bi + 1) begin
                box_x[bi] <= 0; box_y[bi] <= 0;
                box_w[bi] <= 0; box_h[bi] <= 0;
                box_valid[bi] <= 0;
            end
            r_box_count <= 0;
        end else if (reg_wr) begin
            case (reg_addr)
                4'd0: r_box_count <= reg_wdata[7:0];
                4'd1: begin box_x[0] <= reg_wdata[11:0];  box_y[0] <= reg_wdata[27:16]; box_valid[0] <= 1; end
                4'd2: begin box_w[0] <= reg_wdata[11:0];  box_h[0] <= reg_wdata[27:16]; end
                4'd3: begin box_x[1] <= reg_wdata[11:0];  box_y[1] <= reg_wdata[27:16]; box_valid[1] <= 1; end
                4'd4: begin box_w[1] <= reg_wdata[11:0];  box_h[1] <= reg_wdata[27:16]; end
                4'd5: begin box_x[2] <= reg_wdata[11:0];  box_y[2] <= reg_wdata[27:16]; box_valid[2] <= 1; end
                4'd6: begin box_w[2] <= reg_wdata[11:0];  box_h[2] <= reg_wdata[27:16]; end
                4'd7: begin box_x[3] <= reg_wdata[11:0];  box_y[3] <= reg_wdata[27:16]; box_valid[3] <= 1; end
                4'd8: begin box_w[3] <= reg_wdata[11:0];  box_h[3] <= reg_wdata[27:16]; end
                default: ;
            endcase
        end
    end

    assign reg_rdata = 0;

    // Hit detection - check if current pixel is inside any valid box
    reg hit;
    integer bj;
    always @(*) begin
        hit = 0;
        for (bj = 0; bj < MAX_BOX; bj = bj + 1) begin
            if (bj < r_box_count && box_valid[bj] && i_x >= box_x[bj] && i_x < (box_x[bj] + box_w[bj]) &&
                i_y >= box_y[bj] && i_y < (box_y[bj] + box_h[bj]))
                hit = 1;
        end
    end

    // Output: red overlay on box borders (3-pixel thick)
    wire border;
    integer bk;
    reg border_hit;
    always @(*) begin
        border_hit = 0;
        for (bk = 0; bk < MAX_BOX; bk = bk + 1) begin
            if (bk < r_box_count && box_valid[bk]) begin
                if (i_x >= box_x[bk] && i_x < (box_x[bk] + box_w[bk]) &&
                    i_y >= box_y[bk] && i_y < (box_y[bk] + box_h[bk])) begin
                    // Check if on border (3 pixels)
                    if (i_x < (box_x[bk] + 3) || i_x >= (box_x[bk] + box_w[bk] - 3) ||
                        i_y < (box_y[bk] + 3) || i_y >= (box_y[bk] + box_h[bk] - 3))
                        border_hit = 1;
                end
            end
        end
    end

    // Mux output
    assign o_r = border_hit ? 8'hFF : i_r;
    assign o_g = border_hit ? 8'h00 : i_g;
    assign o_b = border_hit ? 8'h00 : i_b;

endmodule
