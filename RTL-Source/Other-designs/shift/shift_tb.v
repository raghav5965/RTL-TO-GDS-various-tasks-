`timescale 1ns/1ps
module shift_muldiv_tb;
  reg [7:0] a;
  reg [2:0] n;
  wire [15:0] mul;
  wire [7:0] div;

  shift_muldiv uut(a,n,mul,div);

  initial begin
    $dumpfile("shift_muldiv.vcd");
    $dumpvars(0, shift_muldiv_tb);
    $monitor("t=%0t a=%d n=%d | a<<n=%d a>>n=%d",
             $time,a,n,mul,div);
    a=8'd12;  n=3'd1; #10
    a=8'd12;  n=3'd2; #10
    a=8'd40;  n=3'd3; #10
    a=8'd100; n=3'd2; #10
    a=8'd255; n=3'd4; #10
    $finish;
  end
endmodule
