`timescale 1ns/1ps
module hamming_weight(
  input [7:0] din,
  output reg [3:0] count
);
  integer i;
  always @(*) begin
    count = 4'd0;
    for (i = 0; i < 8; i = i + 1)
      count = count + din[i];
  end
endmodule
