`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst;
reg enable;

wire [3:0] out_4;
wire [7:0] out_8;

top uut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .out_4(out_4),
    .out_8(out_8)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);

    $display("======================================");
    $display("          COUNTER TESTBENCH");
    $display("======================================");
    $display("TIME   CLK   RST   EN   OUT4   OUT8");
    $display("--------------------------------------");

    clk = 0;
    rst = 1;
    enable = 0;

    // Reset
    #10;

    // Enable counting
    rst = 0;
    enable = 1;

    #50;

    // Stop counting
    enable = 0;

    #20;

    $display("======================================");

    $finish;

end

always @(posedge clk) begin
    $display("%4t    %b     %b     %b    %d     %d",
             $time, clk, rst, enable, out_4, out_8);
end

endmodule
