`timescale 1ns/1ps
module traffic_tb;
  reg clk, rst, s;
  wire [2:0] hwy, road;

  traffic uut(clk,rst,s,hwy,road);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_tb);
    $monitor("t=%0t s=%b state=%d | hwy(RYG)=%b road(RYG)=%b",
             $time,s,uut.state,hwy,road);
    rst=1; s=0; #12
    rst=0;
    repeat (3) @(negedge clk);   // no vehicle
    s=1;                         // vehicle arrives
    repeat (5) @(negedge clk);
    s=0;                         // vehicle has passed
    repeat (5) @(negedge clk);
    s=1;                         // another vehicle
    repeat (4) @(negedge clk);
    s=0;
    repeat (5) @(negedge clk);
    $finish;
  end
endmodule
