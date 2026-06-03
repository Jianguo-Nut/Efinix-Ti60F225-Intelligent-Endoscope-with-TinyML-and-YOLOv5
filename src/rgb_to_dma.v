module rgb_to_dma #(
    parameter FRAME_WIDTH  = 1280,
    parameter FRAME_HEIGHT = 720
)(
    input  wire        clk,
    input  wire        rst_n,

    // Input RGB stream
    input  wire        rgb_vsync,           // pulse at start of frame
    input  wire        rgb_valid,
    input  wire [23:0] rgb_data,            // {R, G, B} each 8-bit

    // DMA interface
    input  wire        dma_wready,
    output reg         dma_wvalid,
    output reg  [63:0] dma_wdata,
    output reg         dma_wlast
);

// Parameters
localparam PIX_PER_BEAT = 2;
localparam TOTAL_PIXELS = FRAME_WIDTH * FRAME_HEIGHT;
localparam TOTAL_BEATS  = TOTAL_PIXELS / PIX_PER_BEAT;
localparam FIFO_DEPTH   = 256;   // enough to absorb backpressure

// FIFO signals
reg  [23:0] fifo_wdata;
reg         fifo_wr_en;
wire        fifo_almost_full;
wire        fifo_empty;
wire        fifo_rd_valid;
wire [23:0] fifo_rd_data;
reg         fifo_rd_en;

// Frame control
reg         vsync_r;
wire        vsync_rise = rgb_vsync && !vsync_r;
reg         frame_active;
reg [31:0]  beat_cnt;        // beats counter for current frame
reg         pack_buffer;     // 0: waiting for first pixel, 1: buffer holds first pixel
reg [23:0]  first_pixel;

// ========== FIFO instantiation ==========
// Simple synchronous FWFT FIFO (depth 256, width 24)
// You may replace with vendor-specific FIFO if needed.
reg [23:0]  fifo_mem [0:FIFO_DEPTH-1];
reg [$clog2(FIFO_DEPTH):0] wr_ptr, rd_ptr;
wire full = (wr_ptr[$clog2(FIFO_DEPTH)] != rd_ptr[$clog2(FIFO_DEPTH)]) &&
            (wr_ptr[$clog2(FIFO_DEPTH)-1:0] == rd_ptr[$clog2(FIFO_DEPTH)-1:0]);
assign fifo_almost_full = (wr_ptr - rd_ptr) >= (FIFO_DEPTH - 4);
assign fifo_empty = (wr_ptr == rd_ptr);
assign fifo_rd_valid = !fifo_empty;
assign fifo_rd_data = fifo_mem[rd_ptr[$clog2(FIFO_DEPTH)-1:0]];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_ptr <= 0;
    end else if (fifo_wr_en && !full) begin
        fifo_mem[wr_ptr[$clog2(FIFO_DEPTH)-1:0]] <= fifo_wdata;
        wr_ptr <= wr_ptr + 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rd_ptr <= 0;
    end else if (fifo_rd_en && !fifo_empty) begin
        rd_ptr <= rd_ptr + 1;
    end
end

// ========== Write side ==========
// Capture frame only when frame_active is high.
// frame_active is set on vsync rise and cleared when enough pixels have been written.
// But we must count pixels written into FIFO, not beats output, to avoid overrun.
// However, we can simply count beats output after packing. Simpler: frame_active cleared by vsync rise of next frame.
// Let's clear on next vsync rise, and rely on FIFO to handle the overlap (FIFO depth > remaining data).
// That ensures continuous streaming without losing frames.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        frame_active <= 1'b0;
        vsync_r <= 1'b0;
    end else begin
        vsync_r <= rgb_vsync;
        if (vsync_rise) begin
            frame_active <= 1'b1;   // start new frame
        end
        // No automatic clear; we keep active forever. The beat counter will wrap after TOTAL_BEATS,
        // but wlast is only generated once per frame when beat_cnt == TOTAL_BEATS-1.
        // To avoid multiple wlast in one frame, we need to reset beat_cnt on vsync rise.
    end
end

assign fifo_wr_en = frame_active & rgb_valid & !fifo_almost_full;
assign fifo_wdata = rgb_data;

// ========== Read and pack side ==========
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pack_buffer <= 1'b0;
        first_pixel <= 24'd0;
        beat_cnt <= 32'd0;
        dma_wvalid <= 1'b0;
        dma_wdata <= 64'd0;
        dma_wlast <= 1'b0;
        fifo_rd_en <= 1'b0;
    end else begin
        // Defaults
        fifo_rd_en <= 1'b0;
        dma_wvalid <= 1'b0;
        dma_wlast <= 1'b0;

        // Reset beat counter on vsync rise (new frame)
        if (vsync_rise) begin
            beat_cnt <= 32'd0;
            pack_buffer <= 1'b0;
            first_pixel <= 24'd0;
        end

        // Packing state machine
        if (frame_active) begin
            if (!pack_buffer) begin
                // Need first pixel
                if (fifo_rd_valid) begin
                    first_pixel <= fifo_rd_data;
                    pack_buffer <= 1'b1;
                    fifo_rd_en <= 1'b1;
                end
            end else begin
                // Have first pixel, need second pixel
                if (fifo_rd_valid && dma_wready) begin
                    // Pack two pixels: order = {8'd0, B1, G1, R1, 8'd0, B0, G0, R0}
                    // Input rgb_data order: {R, G, B}. 
                    // So for first pixel (stored): R0=first_pixel[23:16], G0=first_pixel[15:8], B0=first_pixel[7:0]
                    // For second pixel (current): R1=fifo_rd_data[23:16], G1=fifo_rd_data[15:8], B1=fifo_rd_data[7:0]
                    dma_wdata <= { 8'd0,
                                   fifo_rd_data[7:0],    // B1
                                   fifo_rd_data[15:8],   // G1
                                   fifo_rd_data[23:16],  // R1
                                   8'd0,
                                   first_pixel[7:0],     // B0
                                   first_pixel[15:8],    // G0
                                   first_pixel[23:16]    // R0
                                 };
                    dma_wvalid <= 1'b1;
                    beat_cnt <= beat_cnt + 1'b1;
                    if (beat_cnt == TOTAL_BEATS - 1) begin
                        dma_wlast <= 1'b1;
                    end
                    pack_buffer <= 1'b0;
                    fifo_rd_en <= 1'b1;
                end
            end
        end
    end
end

endmodule