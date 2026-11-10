`timescale 1ns/1ps

module counter_4bit_tb;

reg clk;
reg rst;
reg enable;

wire [3:0] out;

counter_4bit uut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .out(out)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    $dumpfile("counter_4bit.vcd");
    $dumpvars(0, counter_4bit_tb);

    $display("======================================");
    $display("          4-BIT COUNTER");
    $display("======================================");
    $display("TIME   CLK   RST   EN    OUT");
    $display("--------------------------------------");

    // Initial values
    clk = 0;
    rst = 0;
    enable = 0;

    // Apply asynchronous reset
    #2;
    rst = 1;

    #3;
    rst = 0;

    // Enable counter
    enable = 1;

    // Count for 8 clock cycles
    #80;

    // Disable counter
    enable = 0;

    #20;

    // Apply asynchronous reset while clock is running
    rst = 1;

    #3;
    rst = 0;

    // Enable again
    enable = 1;

    #30;

    $display("======================================");

    $finish;

end

// Display at every rising edge
always @(posedge clk or posedge rst) begin

    $display("%4t    %b     %b     %b    %b",
             $time, clk, rst, enable, out);

end

endmodule
