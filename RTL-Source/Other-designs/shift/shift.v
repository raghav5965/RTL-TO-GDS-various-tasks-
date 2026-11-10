`timescale 1ns/1ps
module shift_muldiv(
  input [7:0] a,
  input [2:0] n,
  output reg [15:0] mul,
  output reg [7:0] div
);
  always @(*) begin
    mul = {8'b0, a} << n;
    div = a >> n;
  end
endmodule
