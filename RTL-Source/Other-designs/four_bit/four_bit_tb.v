`timescale 1ns/1ps
module counter4_tb;
  reg clk, rst, en;
  wire [3:0] count;

  counter4 uut(clk,rst,en,count);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("counter4.vcd");
    $dumpvars(0, counter4_tb);
    $monitor("t=%0t rst=%b en=%b | count=%d",
             $time,rst,en,count);
    rst=1; en=0; #22
    rst=0;       #20
    en=1;        #180  // counts and wraps
    en=0;        #30   // holds
    en=1;        #40
    rst=1;       #20   // reset
    rst=0;       #40
    $finish;
  end
endmodule
