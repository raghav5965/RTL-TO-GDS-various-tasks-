`timescale 1ns/1ps
module alu4_tb;
  reg [3:0] a, b;
  reg [2:0] op;
  wire [3:0] y;
  wire cout;
  integer i;

  alu4 uut(a,b,op,y,cout);

  initial begin
    $dumpfile("alu4.vcd");
    $dumpvars(0, alu4_tb);
    $monitor("t=%0t op=%b a=%d b=%d | y=%b (%d) cout=%b",
             $time,op,a,b,y,y,cout);
    a = 4'd9; b = 4'd5;
    for (i = 0; i < 8; i = i + 1) begin
      op = i; #10;
    end
    a = 4'd3; b = 4'd5;
    for (i = 0; i < 8; i = i + 1) begin
      op = i; #10;
    end
    $finish;
  end
endmodule
