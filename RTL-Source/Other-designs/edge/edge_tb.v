`timescale 1ns/1ps
module edge_det_tb;
  reg clk, rst, btn;
  wire y;

  edge_det uut(clk,rst,btn,y);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("edge_det.vcd");
    $dumpvars(0, edge_det_tb);
    $monitor("t=%0t rst=%b btn=%b state=%d | y=%b",
             $time,rst,btn,uut.state,y);
    rst=1; btn=0; #12
    rst=0;
    @(negedge clk) btn=0;
    @(negedge clk) btn=1;   // press, held for 5 cycles
    repeat (4) @(negedge clk);
    btn=0;                  // release
    repeat (2) @(negedge clk);
    btn=1;                  // short press (1 cycle)
    @(negedge clk) btn=0;
    repeat (2) @(negedge clk);
    btn=1;                  // press again, held
    repeat (3) @(negedge clk);
    btn=0;
    #30
    $finish;
  end
endmodule
