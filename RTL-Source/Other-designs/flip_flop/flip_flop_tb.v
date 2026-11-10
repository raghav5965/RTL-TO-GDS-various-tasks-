`timescale 1ns/1ps

module flip_flop_tb();

reg d;
reg clk;
reg rst;

wire q;

flip_flop uut(d, clk, rst, q);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("flip_flop.vcd");
    $dumpvars(0, flip_flop_tb);

    $display("==============================");
    $display("       D FLIP-FLOP TEST");
    $display("==============================");
    $display("D RST CLK | Q");
    $display("------------------------------");

    // -------------------------
    // Case 1: D=0, RST=0
    // -------------------------
    d = 0;
    rst = 0;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 2: D=0, RST=1
    // -------------------------
    d = 0;
    rst = 1;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 3: D=1, RST=0
    // -------------------------
    d = 1;
    rst = 0;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 4: D=1, RST=1
    // -------------------------
    d = 1;
    rst = 1;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // Repeat cases to observe behavior
    // -------------------------
    // Case 5: D=0, RST=0
    // -------------------------
    d = 0;
    rst = 0;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 6: D=0, RST=1
    // -------------------------
    d = 0;
    rst = 1;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 7: D=1, RST=0
    // -------------------------
    d = 1;
    rst = 0;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    // -------------------------
    // Case 8: D=1, RST=1
    // -------------------------
    d = 1;
    rst = 1;
    @(posedge clk);
    #1;
    $display("%b  %b   %b  | %b", d, rst, clk, q);

    $display("------------------------------");
    $display("Simulation completed.");
    $display("------------------------------");

    $finish;

end

endmodule
