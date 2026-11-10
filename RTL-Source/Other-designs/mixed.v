`timescale 1ns/1ps
module mixed(
  input [3:0] a, b, c,
  output [4:0] y1, y2,
  output reg [3:0] y3, y4,
  output reg [4:0] y5
);
  // Dataflow
  assign y1 = a + b;
  assign y2 = y1 ^ {1'b0, c};

  // Procedural
  always @(*) y3 = a & b;
  always @(*) y4 = y3 | c;
  always @(*) y5 = {1'b0, a} - {1'b0, b};
endmodule
