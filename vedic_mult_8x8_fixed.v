module vedic_mult_8x8 (
    input [7:0] a, b,
    output [15:0] p
);
    wire [7:0] pp0, pp1, pp2, pp3;
    wire [8:0] sum1;  // 4+4+4=12 bits worth of addition, max ~15
    wire [9:0] sum2;  // wider accumulation
    
    vedic_mult_4x4 v00 (a[3:0], b[3:0], pp0);
    vedic_mult_4x4 v01 (a[7:4], b[3:0], pp1);
    vedic_mult_4x4 v02 (a[3:0], b[7:4], pp2);
    vedic_mult_4x4 v03 (a[7:4], b[7:4], pp3);
    
    assign p[3:0] = pp0[3:0];
    
    // First stage: pp0[7:4] + pp1[3:0] + pp2[3:0]
    // These are 4-bit numbers, max sum = 15+15+15 = 45 (needs 6 bits + carry)
    assign sum1 = pp0[7:4] + pp1[3:0] + pp2[3:0];
    assign p[7:4] = sum1[3:0];
    
    // Second stage: sum1[8:4] + pp1[7:4] + pp2[7:4] + pp3[3:0]
    assign sum2 = {1'b0, sum1[8:4]} + pp1[7:4] + pp2[7:4] + pp3[3:0];
    assign p[11:8] = sum2[3:0];
    
    // Final stage: sum2[9:4] + pp3[7:4]
    assign p[15:12] = sum2[9:4] + pp3[7:4];
endmodule
