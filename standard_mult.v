module standard_mult #(
    parameter WIDTH = 4
) (
    input [WIDTH-1:0] a, b,
    output [2*WIDTH-1:0] p
);
    assign p = a * b;
endmodule
