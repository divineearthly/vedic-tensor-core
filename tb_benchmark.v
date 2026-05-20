module tb_benchmark;
    parameter VEDIC_WIDTH = 8;
    parameter NUM_TESTS = 1000;
    
    reg [VEDIC_WIDTH-1:0] a, b;
    wire [2*VEDIC_WIDTH-1:0] p_vedic, p_standard;
    reg [2*VEDIC_WIDTH-1:0] expected;
    integer i, errors;
    
    vedic_mult_8x8 dut_vedic (a, b, p_vedic);
    standard_mult #(VEDIC_WIDTH) dut_standard (a, b, p_standard);
    
    initial begin
        errors = 0;
        $display("Testing Vedic %0dx%0d Multiplier", VEDIC_WIDTH, VEDIC_WIDTH);
        
        // Test max values
        a = {VEDIC_WIDTH{1'b1}}; b = {VEDIC_WIDTH{1'b1}}; #1;
        expected = a * b;
        if (p_vedic !== expected) begin
            errors = errors + 1;
            $display("FAIL: Max values - got %0d, expected %0d", p_vedic, expected);
        end else $display("PASS: Max values");
        
        // Test zero
        a = 0; b = 0; #1;
        expected = 0;
        if (p_vedic !== 0) begin
            errors = errors + 1;
            $display("FAIL: Zero");
        end else $display("PASS: Zero");
        
        // Random tests
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            a = $urandom % (1 << VEDIC_WIDTH);
            b = $urandom % (1 << VEDIC_WIDTH);
            #1;
            expected = a * b;
            if (p_vedic !== expected) begin
                errors = errors + 1;
                $display("FAIL: a=%0d, b=%0d, expected=%0d, got=%0d", a, b, expected, p_vedic);
            end
        end
        
        if (errors == 0)
            $display("SUCCESS: All %0d tests passed!", NUM_TESTS);
        else
            $display("FAILURE: %0d errors found", errors);
        
        $finish;
    end
endmodule
