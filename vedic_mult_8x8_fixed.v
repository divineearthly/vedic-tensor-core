module vedic_mult_8x8 (
    input [7:0] a, b,
    output [15:0] p
);
    wire [7:0] pp0, pp1, pp2, pp3;
    wire [8:0] sum1;
    wire [9:0] sum2;
    wire [5:0] final_sum;  // 6 bits to safely hold max 17
    
    vedic_mult_4x4 v00 (a[3:0], b[3:0], pp0);
    vedic_mult_4x4 v01 (a[7:4], b[3:0], pp1);
    vedic_mult_4x4 v02 (a[3:0], b[7:4], pp2);
    vedic_mult_4x4 v03 (a[7:4], b[7:4], pp3);
    
    assign p[3:0] = pp0[3:0];
    
    assign sum1 = pp0[7:4] + pp1[3:0] + pp2[3:0];
    assign p[7:4] = sum1[3:0];
    
    assign sum2 = {1'b0, sum1[8:4]} + pp1[7:4] + pp2[7:4] + pp3[3:0];
    assign p[11:8] = sum2[3:0];
    
    // Safe: 6-bit addition, then take lower 4 bits
    assign final_sum = sum2[9:4] + pp3[7:4];
    assign p[15:12] = final_sum[3:0];
endmodule
