`timescale 1ns/1ps
module seq101_tb;
  reg clk, rst, x;
  wire y;
  reg [11:0] stream;
  integer i;

  seq101 uut(clk,rst,x,y);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("seq101.vcd");
    $dumpvars(0, seq101_tb);
    $monitor("t=%0t rst=%b x=%b state=%d | y=%b",
             $time,rst,x,uut.state,y);
    stream = 12'b101011011010;
    rst = 1; x = 0;
    #12 rst = 0;
    for (i = 11; i >= 0; i = i - 1) begin
      @(negedge clk) x = stream[i];
    end
    #20
    $finish;
  end
endmodule
