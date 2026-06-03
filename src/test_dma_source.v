////////////////////////////////////////////////////////////////////////////
// Simple DMA Source Test Module for display_hdmi_rgb
// Generates color bar pattern data as DMA input
////////////////////////////////////////////////////////////////////////////

module test_dma_source (
    input  logic             iHdmiClk,
    input  logic             iRst_n,
    
    // DMA interface to display_hdmi_rgb
    output logic [63:0]      ovDisplayDmaRdData,
    output logic             oDisplayDmaRdValid,
    output logic [7:0]       ov7DisplayDmaRdKeep,
    input  logic             iDisplayDmaRdReady
);

//===========================================================================
// Test Pattern Parameters
//===========================================================================
// For 1280x720 display, 2 pixels per clock
// Horizontal active: 1280 pixels → 640 DMA transfers per line
// Vertical active: 720 lines
localparam H_ACTIVE_XFER = 640;   // 1280 / 2 (PPC=2)
localparam V_ACTIVE      = 720;

// Color bar width in DMA transfers (640 / 8 = 80 transfers per bar)
localparam BAR_WIDTH     = H_ACTIVE_XFER / 8;  // = 80

// Color definitions for 8 color bars (packed 2 pixels per 64-bit)
// Format: {Pixel1_RGB[23:0], Pixel2_RGB[23:0]} = 64-bit
//          Pixel1 = high 32 bits, Pixel2 = low 32 bits

// 8 basic colors
localparam [23:0] COLOR_WHITE   = 24'hFF_FF_FF;
localparam [23:0] COLOR_YELLOW  = 24'hFF_FF_00;
localparam [23:0] COLOR_CYAN    = 24'h00_FF_FF;
localparam [23:0] COLOR_GREEN   = 24'h00_FF_00;
localparam [23:0] COLOR_MAGENTA = 24'hFF_00_FF;
localparam [23:0] COLOR_RED     = 24'hFF_00_00;
localparam [23:0] COLOR_BLUE    = 24'h00_00_FF;
localparam [23:0] COLOR_BLACK   = 24'h00_00_00;

// Packed colors for 2 pixels (Pixel1-RGB, Pixel2-RGB) -> 64-bit
localparam [63:0] PACKED_WHITE   = {COLOR_WHITE,   COLOR_WHITE};
localparam [63:0] PACKED_YELLOW  = {COLOR_YELLOW,  COLOR_YELLOW};
localparam [63:0] PACKED_CYAN    = {COLOR_CYAN,    COLOR_CYAN};
localparam [63:0] PACKED_GREEN   = {COLOR_GREEN,   COLOR_GREEN};
localparam [63:0] PACKED_MAGENTA = {COLOR_MAGENTA, COLOR_MAGENTA};
localparam [63:0] PACKED_RED     = {COLOR_RED,     COLOR_RED};
localparam [63:0] PACKED_BLUE    = {COLOR_BLUE,    COLOR_BLUE};
localparam [63:0] PACKED_BLACK   = {COLOR_BLACK,   COLOR_BLACK};

// Color bar lookup table
localparam [63:0] COLOR_BARS[0:7] = '{
    PACKED_WHITE,   // Bar 0
    PACKED_YELLOW,  // Bar 1
    PACKED_CYAN,    // Bar 2
    PACKED_GREEN,   // Bar 3
    PACKED_MAGENTA, // Bar 4
    PACKED_RED,     // Bar 5
    PACKED_BLUE,    // Bar 6
    PACKED_BLACK    // Bar 7
};

//===========================================================================
// Internal Registers
//===========================================================================
logic [9:0]  r_xfer_cnt;      // DMA transfer counter per line (0-639)
logic [9:0]  r_line_cnt;      // Line counter (0-719)
logic        r_valid;          // Valid data flag
logic        r_vsync_detect;   // VSync detection for frame reset

//===========================================================================
// Main Pattern Generation Logic
//===========================================================================

// Simple line counter that resets at VSync detection
// Since we don't have direct VSync from display_hdmi_rgb,
// we generate free-running pattern. The display_hdmi_rgb will
// read when it's ready (iDisplayDmaRdReady)
always @(posedge iHdmiClk or negedge iRst_n) begin
    if (~iRst_n) begin
        r_line_cnt  <= 10'd0;
        r_xfer_cnt  <= 10'd0;
        r_valid     <= 1'b0;
    end else begin
        // Reset counter when reaching end of frame
        if (r_line_cnt >= V_ACTIVE && r_xfer_cnt >= H_ACTIVE_XFER) begin
            r_line_cnt <= 10'd0;
            r_xfer_cnt <= 10'd0;
            r_valid    <= 1'b0;
        end
        // Data generation when DMA is ready and within active area
        else if (iDisplayDmaRdReady) begin
            r_valid <= 1'b1;
            
            // Advance transfer counter
            if (r_xfer_cnt < H_ACTIVE_XFER - 1) begin
                r_xfer_cnt <= r_xfer_cnt + 1'b1;
            end else begin
                // End of line, move to next line
                r_xfer_cnt <= 10'd0;
                if (r_line_cnt < V_ACTIVE - 1) begin
                    r_line_cnt <= r_line_cnt + 1'b1;
                end else begin
                    r_line_cnt <= 10'd0;  // Wrap to next frame
                end
            end
        end else begin
            r_valid <= 1'b0;
        end
    end
end

// Generate data based on current position
always @(posedge iHdmiClk or negedge iRst_n) begin
    if (~iRst_n) begin
        ovDisplayDmaRdData <= 64'd0;
        ov7DisplayDmaRdKeep <= 8'hFF;  // All bytes valid
    end else begin
        ov7DisplayDmaRdKeep <= 8'hFF;  // Always all bytes valid
        
        if (r_valid && iDisplayDmaRdReady) begin
            // Determine which color bar based on horizontal position
            // Each bar is BAR_WIDTH (80) transfers wide
            case (r_xfer_cnt / BAR_WIDTH)
                0: ovDisplayDmaRdData <= COLOR_BARS[0];  // White
                1: ovDisplayDmaRdData <= COLOR_BARS[1];  // Yellow
                2: ovDisplayDmaRdData <= COLOR_BARS[2];  // Cyan
                3: ovDisplayDmaRdData <= COLOR_BARS[3];  // Green
                4: ovDisplayDmaRdData <= COLOR_BARS[4];  // Magenta
                5: ovDisplayDmaRdData <= COLOR_BARS[5];  // Red
                6: ovDisplayDmaRdData <= COLOR_BARS[6];  // Blue
                7: ovDisplayDmaRdData <= COLOR_BARS[7];  // Black
                default: ovDisplayDmaRdData <= PACKED_BLACK;
            endcase
        end else begin
            ovDisplayDmaRdData <= 64'd0;
        end
    end
end

// Valid signal output
always @(posedge iHdmiClk or negedge iRst_n) begin
    if (~iRst_n) begin
        oDisplayDmaRdValid <= 1'b0;
    end else begin
        oDisplayDmaRdValid <= r_valid && iDisplayDmaRdReady;
    end
end

endmodule