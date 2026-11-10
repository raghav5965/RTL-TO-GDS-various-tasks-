
module flipflop (
    input wire rst,
    input wire clk,
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


module rotate_register (
    input wire clk,
    input wire rst,
    input wire load,
    input wire [3:0] D,
    output wire [3:0] Q
);

wire [3:0] next_Q;

// Load the input or rotate the existing contents
assign next_Q[0] = load ? D[0] : Q[1];
assign next_Q[1] = load ? D[1] : Q[2];
assign next_Q[2] = load ? D[2] : Q[3];
assign next_Q[3] = load ? D[3] : Q[0];

flipflop F1 (rst, clk, next_Q[0], Q[0]);
flipflop F2 (rst, clk, next_Q[1], Q[1]);
flipflop F3 (rst, clk, next_Q[2], Q[2]);
flipflop F4 (rst, clk, next_Q[3], Q[3]);

endmodule

