`timescale 1ns/1ps
module vending_tb;
  reg clk, rst;
  reg [1:0] coin;
  wire paid;

  vending uut(clk,rst,coin,paid);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("vending.vcd");
    $dumpvars(0, vending_tb);
    $monitor("t=%0t rst=%b coin=%b state=%d | paid=%b",
             $time,rst,coin,uut.state,paid);
    rst=1; coin=2'b00; #12
    rst=0;
    // Rs.5 + Rs.5 + Rs.5 = 15
    @(negedge clk) coin=2'b01;
    @(negedge clk) coin=2'b01;
    @(negedge clk) coin=2'b01;
    @(negedge clk) coin=2'b01;   // after 15 -> back to S0
    @(negedge clk) coin=2'b00;
    // Rs.10 + Rs.5 = 15
    @(negedge clk) coin=2'b10;
    @(negedge clk) coin=2'b01;
    @(negedge clk) coin=2'b10;   // after 15 -> back to S0
    @(negedge clk) coin=2'b00;
    // Rs.15 directly
    @(negedge clk) coin=2'b11;
    @(negedge clk) coin=2'b00;
    @(negedge clk) coin=2'b01;   // after 15 -> back to S0
    @(negedge clk) coin=2'b00;
    #20
    $finish;
  end
endmodule
