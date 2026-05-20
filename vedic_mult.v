// Your 2x2 building block
module vedic_2x2 (
    input [1:0] a,
    input [1:0] b,
    output [3:0] p
);
    wire w1, w2, carry;
    assign p[0] = a[0] & b[0];
    assign w1 = a[1] & b[0];
    assign w2 = a[0] & b[1];
    assign p[1] = w1 ^ w2;
    assign carry = w1 & w2;
    assign p[2] = (a[1] & b[1]) ^ carry;
    assign p[3] = (a[1] & b[1]) & carry;
endmodule

// 4x4 Urdhva Tiryagbhyam Architecture
module vedic_mult #(parameter WIDTH = 4) (
    input [3:0] a,
    input [3:0] b,
    output [7:0] p
);
    wire [3:0] p0, p1, p2, p3;
    
    // Four parallel 2x2 multiplications
    vedic_2x2 m0 (.a(a[1:0]), .b(b[1:0]), .p(p0)); // LSB Vertical
    vedic_2x2 m1 (.a(a[3:2]), .b(b[1:0]), .p(p1)); // Crosswise 1
    vedic_2x2 m2 (.a(a[1:0]), .b(b[3:2]), .p(p2)); // Crosswise 2
    vedic_2x2 m3 (.a(a[3:2]), .b(b[3:2]), .p(p3)); // MSB Vertical
    
    // Parallel crosswise addition
    wire [7:0] term0 = {4'b0000, p0};
    wire [7:0] term1 = {2'b00, p1, 2'b00};
    wire [7:0] term2 = {2'b00, p2, 2'b00};
    wire [7:0] term3 = {p3, 4'b0000};
    
    assign p = term0 + term1 + term2 + term3;
endmodule
