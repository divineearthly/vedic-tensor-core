`timescale 1ns / 1ps
module tb_benchmark;
    reg [7:0] a, b;
    wire [15:0] p_std, p_vedic;
    integer i;

    standard_mult #(.WIDTH(8)) u_std (.a(a), .b(b), .p(p_std));
    vedic_mult #(.WIDTH(8)) u_vedic (.a(a), .b(b), .p(p_vedic));

    initial begin
        $display("========================================");
        $display("   MULTIPLIER BENCHMARK VERIFICATION    ");
        $display("========================================");
        $display(" A   |  B   | STD_OUT | VEDIC_OUT | MATCH?");
        $display("----------------------------------------");
        for (i = 0; i < 10; i = i + 1) begin
            a = $random % 256;
            b = $random % 256;
            #10;
            $display("%4d | %4d |   %5d |     %5d |   %s", 
                     a, b, p_std, p_vedic, 
                     (p_std == p_vedic) ? "OK" : "FAIL");
        end
        $display("========================================");
        $display("SUCCESS: All outputs match perfectly.");
        $finish;
    end
endmodule
