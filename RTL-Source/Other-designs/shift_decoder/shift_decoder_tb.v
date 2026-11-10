`timescale 1ns/1ps
module shift_decoder_tb;
  reg [2:0] a;
  wire [7:0] y;
  integer i;

  shift_decoder uut(a,y);

  initial begin
    $dumpfile("shift_decoder.vcd");
    $dumpvars(0, shift_decoder_tb);
    $monitor("t=%0t a=%b | y=%b",
             $time,a,y);
    for (i = 0; i < 8; i = i + 1) begin
      a = i; #10;
    end
    $finish;
  end
endmodule
