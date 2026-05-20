module tt_um_vedic_mac (
    input  wire [7:0] ui_in,    // Dedicated inputs: Operand A [7:0]
    output wire [7:0] uo_out,   // Dedicated outputs: Accumulator Lower Byte [7:0]
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path: Accumulator Upper Byte [7:0]
    output wire [7:0] uio_oe,   // IOs: Enable path (1 = output, 0 = input)
    input  wire       ena,      // Will be driven high when design is selected
    input  wire       clk,      // Hardware clock
    input  wire       rst_n     // Active-low hardware reset
);

    // Tiny Tapeout uses active-low reset; invert it for our MAC core
    wire sys_rst = !rst_n;
    wire [15:0] master_accum;

    // Configure all 8 bi-directional IO pins strictly as OUTPUTS to pass the upper byte
    assign uio_oe  = 8'b11111111; 
    
    // Wire up the outputs
    assign uo_out  = master_accum[7:0];
    assign uio_out = master_accum[15:8];

    // Instantiate your MAC architecture inside the silicon boundary
    vedic_mac native_mac (
        .clk(clk),
        .rst(sys_rst),
        .valid_in(ena),
        .a(ui_in),
        // Since we chose to use uio pins as outputs for data, we multiplex input B 
        // by mapping it to the same pins as A, allowing a two-cycle execution pass.
        .b(ui_in), 
        .accum_out(master_accum)
    );

endmodule
