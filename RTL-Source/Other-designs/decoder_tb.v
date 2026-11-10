`timescale 1ns/1ps
module decoder3to8_tb;
  reg en;
  reg [2:0] a;
  wire [7:0] y;
  integer i;

  decoder3to8 uut(en,a,y);

  initial begin
    $dumpfile("decoder3to8.vcd");
    $dumpvars(0, decoder3to8_tb);
    $monitor("t=%0t en=%b a=%b | y=%b",
             $time,en,a,y);
    en = 0;
    for (i = 0; i < 8; i = i + 1) begin
      a = i; #10;
    end
    en = 1;
    for (i = 0; i < 8; i = i + 1) begin
      a = i; #10;
    end
    $finish;
  end
endmodule
