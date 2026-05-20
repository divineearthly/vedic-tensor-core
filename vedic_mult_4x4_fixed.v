module vedic_mult_4x4 (
    input [3:0] a, b,
    output [7:0] p
);
    wire [3:0] pp0, pp1, pp2, pp3;
    wire [4:0] sum1;  // max: 3+3+3=9, needs 4 bits + carry = 5
    wire [5:0] sum2;  // max: 7+3+3+3=16, needs 5 bits + carry = 6
    
    vedic_2x2 v00 (a[1:0], b[1:0], pp0);
    vedic_2x2 v01 (a[3:2], b[1:0], pp1);
    vedic_2x2 v02 (a[1:0], b[3:2], pp2);
    vedic_2x2 v03 (a[3:2], b[3:2], pp3);
    
    assign p[1:0] = pp0[1:0];
    
    // First stage: pp0[3:2] + pp1[1:0] + pp2[1:0]
    // These are all 2-bit numbers, max sum = 3+3+3 = 9 (5 bits)
    assign sum1 = pp0[3:2] + pp1[1:0] + pp2[1:0];
    assign p[3:2] = sum1[1:0];
    
    // Second stage: sum1[4:2] + pp1[3:2] + pp2[3:2] + pp3[1:0]
    // sum1[4:2] is max 2 (since sum1 max is 9), pp1/pp2[3:2] max 3 each, pp3[1:0] max 3
    // Max = 2+3+3+3 = 11 (needs 4 bits + carry = 5)
    assign sum2 = {1'b0, sum1[4:2]} + pp1[3:2] + pp2[3:2] + pp3[1:0];
    assign p[5:4] = sum2[1:0];
    
    // Final stage: sum2[4:2] + pp3[3:2]
    // sum2[4:2] max 2, pp3[3:2] max 3, total max 5 (needs 3 bits)
    assign p[7:6] = sum2[4:2] + pp3[3:2];
endmodule
