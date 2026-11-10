`timescale 1ns/1ps
module shift_decoder(
  input [2:0] a,
  output reg [7:0] y
);
  always @(*) begin
    y = 8'b00000001 << a;
  end
endmodule
