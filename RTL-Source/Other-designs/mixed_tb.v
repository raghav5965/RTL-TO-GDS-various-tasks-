`timescale 1ns/1ps
module mixed_tb;
  reg [3:0] a, b, c;
  wire [4:0] y1, y2, y5;
  wire [3:0] y3, y4;

  mixed uut(a,b,c,y1,y2,y3,y4,y5);

  initial begin
    $dumpfile("mixed.vcd");
    $dumpvars(0, mixed_tb);
    $monitor("t=%0t a=%d b=%d c=%d | y1=%d y2=%d y3=%d y4=%d y5=%d",
             $time,a,b,c,y1,y2,y3,y4,y5);
    a=4'd3;  b=4'd2;  c=4'd1;  #10
    a=4'd7;  b=4'd5;  c=4'd2;  #10
    a=4'd9;  b=4'd9;  c=4'd4;  #10
    a=4'd15; b=4'd1;  c=4'd8;  #10
    a=4'd2;  b=4'd6;  c=4'd5;  #10
    $finish;
  end
endmodule
