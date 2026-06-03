// UART RX for bbox overlay — receives ASCII bounding box data from SoC UART TX
// Protocol (ASCII text): [x,y WxH score] per box, multiple boxes per line, newline separates frames
// Example: [414,214 115x73 78] [341,210 261x64 72]\n
// Baud rate: 115200

module uart_bbox #(
    parameter CLK_HZ = 74250000,  // pixel clock
    parameter BAUD   = 115200,
    parameter MAX_BOX = 8
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire         uart_rx,       // connect to system_uart_0_io_txd

    // Box outputs to bbox_overlay
    output reg          box_wr   = 1'b0,
    output reg  [3:0]   box_addr = 4'd0,
    output reg  [31:0]  box_data = 32'd0
);

    // -------------------------------------------------------------------------
    // UART RX — standard 8N1
    // -------------------------------------------------------------------------
    localparam BIT_PERIOD = CLK_HZ / BAUD;          // ~645 @ 74.25 MHz / 115200
    localparam HALF_BIT   = BIT_PERIOD / 2;

    reg [15:0] rx_cnt;
    reg [3:0]  rx_bit;
    reg [7:0]  rx_byte;
    reg        rx_done;
    reg        rx_sync0, rx_sync1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_cnt <= 0; rx_bit <= 0; rx_byte <= 0; rx_done <= 0;
            rx_sync0 <= 1; rx_sync1 <= 1;
        end else begin
            rx_sync0 <= uart_rx;
            rx_sync1 <= rx_sync0;
            rx_done  <= 0;

            if (rx_bit == 0) begin
                // Wait for start bit (falling edge)
                if (!rx_sync1) begin
                    rx_cnt <= HALF_BIT + BIT_PERIOD;
                    rx_bit <= 1;
                    rx_byte <= 0;
                end
            end else if (rx_bit <= 8) begin
                if (rx_cnt == 0) begin
                    rx_byte <= {rx_sync1, rx_byte[7:1]};   // LSB first
                    rx_bit  <= rx_bit + 1;
                    rx_cnt  <= BIT_PERIOD - 1;
                end else begin
                    rx_cnt <= rx_cnt - 1;
                end
            end else begin
                // Stop bit
                if (rx_cnt == 0) begin
                    rx_done <= 1;
                    rx_bit  <= 0;
                end else begin
                    rx_cnt <= rx_cnt - 1;
                end
            end
        end
    end

    // -------------------------------------------------------------------------
    // Timeout counter — reset parse state if idle > ~50 ms
    // -------------------------------------------------------------------------
    localparam TIMEOUT_CYCLES = CLK_HZ / 20;   // 50 ms

    reg [26:0] timeout_cnt;
    reg        timeout;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            timeout_cnt <= 0;
            timeout     <= 0;
        end else if (rx_done) begin
            timeout_cnt <= 0;
            timeout     <= 0;
        end else begin
            if (timeout_cnt < TIMEOUT_CYCLES)
                timeout_cnt <= timeout_cnt + 1;
            else
                timeout <= 1;
        end
    end

    // -------------------------------------------------------------------------
    // ASCII decimal accumulator helper
    // -------------------------------------------------------------------------
    // Parse states
    localparam S_IDLE    = 4'd0;   // waiting for '['
    localparam S_X       = 4'd1;   // reading x digits
    localparam S_Y       = 4'd2;   // reading y digits (after ',')
    localparam S_W       = 4'd3;   // reading w digits (after ' ')
    localparam S_H       = 4'd4;   // reading h digits (after 'x')
    localparam S_SCORE   = 4'd5;   // reading score digits (after ' ')
    localparam S_COMMIT  = 4'd6;   // write registers (lasts 3 cycles)
    localparam S_EOL     = 4'd7;   // after ']', wait for next '[' or '\n'

    reg [3:0]  state;

    // Accumulators — 12 bits enough for 1280/720
    reg [11:0] acc_x, acc_y, acc_w, acc_h;
    reg [7:0]  acc_score;   // not used for display but consumed

    // Box index — reset each newline (new frame)
    reg [3:0]  cur_box;

    // Commit sequencer
    reg [1:0]  commit_step;

    // CRLF handling
    reg        skip_lf;   // set when \r processed, swallow immediately following \n

    // Is incoming byte an ASCII digit?
    wire is_digit = (rx_byte >= 8'h30) && (rx_byte <= 8'h39);
    wire [3:0] digit_val = rx_byte[3:0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n || timeout) begin
            state       <= S_IDLE;
            acc_x       <= 0; acc_y <= 0; acc_w <= 0; acc_h <= 0;
            acc_score   <= 0;
            cur_box     <= 0;
            commit_step <= 0;
            box_wr      <= 0;
            box_addr    <= 0;
            box_data    <= 0;
            skip_lf     <= 0;
        end else begin
            box_wr <= 0;   // default de-assert

            // ------------------------------------------------------------------
            // Commit state — spread 3 writes across 3 consecutive clock cycles
            // (one write per cycle so bbox_overlay sees distinct reg_wr pulses)
            // ------------------------------------------------------------------
            if (state == S_COMMIT) begin
                case (commit_step)
                    2'd0: begin
                        // Write XY
                        box_addr    <= cur_box * 2 + 1;
                        box_data    <= {4'd0, acc_y, 4'd0, acc_x};
                        box_wr      <= 1;
                        commit_step <= 2'd1;
                    end
                    2'd1: begin
                        // Write WH
                        box_addr    <= cur_box * 2 + 2;
                        box_data    <= {4'd0, acc_h, 4'd0, acc_w};
                        box_wr      <= 1;
                        commit_step <= 2'd2;
                    end
                    2'd2: begin
                        // Write box count (cur_box is still the index, count = index+1)
                        box_addr    <= 4'd0;
                        box_data    <= {24'd0, cur_box + 1};
                        box_wr      <= 1;
                        commit_step <= 2'd0;
                        cur_box     <= (cur_box < MAX_BOX - 1) ? cur_box + 1 : cur_box;
                        state       <= S_EOL;
                    end
                    default: commit_step <= 2'd0;
                endcase

            end else if (rx_done) begin
                // ------------------------------------------------------------------
                // Normal ASCII parse
                // ------------------------------------------------------------------
                if (skip_lf && rx_byte == 8'h0A) begin
                    skip_lf <= 0;   // swallow LF that follows a CR
                end else begin
                    skip_lf <= 0;
                    case (state)

                        S_IDLE: begin
                            if (rx_byte == 8'h5B) begin   // '['
                                acc_x <= 0;
                                state <= S_X;
                            end else if (rx_byte == 8'h0D) begin   // CR — empty line, clear
                                cur_box  <= 0;
                                box_addr <= 4'd0;
                                box_data <= 32'd0;
                                box_wr   <= 1;
                                skip_lf  <= 1;
                            end else if (rx_byte == 8'h0A) begin   // bare LF — empty line, clear
                                cur_box  <= 0;
                                box_addr <= 4'd0;
                                box_data <= 32'd0;
                                box_wr   <= 1;
                            end
                        end

                        S_X: begin
                            if (is_digit)
                                acc_x <= acc_x * 10 + digit_val;
                            else if (rx_byte == 8'h2C) begin   // ','
                                acc_y <= 0;
                                state <= S_Y;
                            end
                            else state <= S_IDLE;
                        end

                        S_Y: begin
                            if (is_digit)
                                acc_y <= acc_y * 10 + digit_val;
                            else if (rx_byte == 8'h20) begin   // ' '
                                acc_w <= 0;
                                state <= S_W;
                            end
                            else state <= S_IDLE;
                        end

                        S_W: begin
                            if (is_digit)
                                acc_w <= acc_w * 10 + digit_val;
                            else if (rx_byte == 8'h78) begin   // 'x'
                                acc_h <= 0;
                                state <= S_H;
                            end
                            else state <= S_IDLE;
                        end

                        S_H: begin
                            if (is_digit)
                                acc_h <= acc_h * 10 + digit_val;
                            else if (rx_byte == 8'h20) begin   // ' '
                                acc_score <= 0;
                                state     <= S_SCORE;
                            end
                            else state <= S_IDLE;
                        end

                        S_SCORE: begin
                            if (is_digit)
                                acc_score <= acc_score * 10 + digit_val;
                            else if (rx_byte == 8'h5D) begin   // ']' — box complete
                                state       <= S_COMMIT;
                                commit_step <= 2'd0;
                            end
                            else state <= S_IDLE;
                        end

                        S_EOL: begin
                            if (rx_byte == 8'h5B) begin   // '[' — another box on same line
                                acc_x <= 0;
                                state <= S_X;
                            end else if (rx_byte == 8'h0D) begin   // CR — end of frame
                                cur_box <= 0;
                                state   <= S_IDLE;
                                skip_lf <= 1;
                            end else if (rx_byte == 8'h0A) begin   // bare LF — end of frame
                                cur_box <= 0;
                                state   <= S_IDLE;
                            end
                            // Spaces between boxes are silently ignored
                        end

                        default: state <= S_IDLE;
                    endcase
                end
            end
        end
    end

endmodule
