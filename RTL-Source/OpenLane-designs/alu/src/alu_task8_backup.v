`timescale 1ns/1ps
module alu4(
  input [3:0] a, b,
  input [2:0] op,
  output reg [3:0] y,
  output reg cout
);
  always @(*) begin
    cout = 1'b0;
    case (op)
      3'b000: {cout,y} = a + b;
      3'b001: {cout,y} = {1'b0,a}
                       - {1'b0,b};
      3'b010: y = a & b;
      3'b011: y = a | b;
      3'b100: y = ~a;
      3'b101: y = a << 1;
      3'b110: y = a >> 1;
      default: y = 4'b0000;
    endcase
  end
endmodule


