`timescale 1ns/1ps
module hamming_weight_tb;
  reg [7:0] din;
  wire [3:0] count;

  hamming_weight uut(din,count);

  initial begin
    $dumpfile("hamming_weight.vcd");
    $dumpvars(0, hamming_weight_tb);
    $monitor("t=%0t din=%b | count=%d",
             $time,din,count);
    din=8'b00000000; #10
    din=8'b00000001; #10
    din=8'b10000000; #10
    din=8'b00000111; #10
    din=8'b10100101; #10
    din=8'b01011010; #10
    din=8'b11111110; #10
    din=8'b11111111; #10
    $finish;
  end
endmodule
