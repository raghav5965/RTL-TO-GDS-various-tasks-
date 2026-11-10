
module flipflop(
    input wire clk,
    input wire rst,
    input wire d,
    output reg q
);

always @(posedge clk) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end

endmodule


module right_shift(
    input wire clk,
    input wire rst,
    input wire [3:0] D,
    output wire [3:0] Q
);

flipflop F1(clk, rst, D[0],           Q[0]);
flipflop F2(clk, rst, D[1] & Q[0],    Q[1]);
flipflop F3(clk, rst, D[2] & Q[1],    Q[2]);
flipflop F4(clk, rst, D[3] & Q[2],    Q[3]);

endmodule

