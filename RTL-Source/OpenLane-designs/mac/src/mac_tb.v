
`timescale 1ns/1ps

module mac_tb;

reg clk, rst_n, enable;
reg [7:0] in_A;
wire [3:0] multiplier;
wire [15:0] accumulator;

// Standalone MAC uses constant multiplier V = 6
assign multiplier = 4'd6;

mac uut (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .in_A(in_A),
    .multiplier(multiplier),
    .accumulator(accumulator)
);

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    $dumpfile("mac.vcd");
    $dumpvars(0, mac_tb);

    $monitor("time=%0t | clk=%b | rst_n=%b | enable=%b | in_A=%0d | multiplier=%0d | accumulator=%0d",
             $time, clk, rst_n, enable, in_A, multiplier, accumulator);

    // Apply active-low reset
    rst_n = 1'b0;
    enable = 1'b0;
    in_A = 8'd0;

    // Hold reset low for exactly 83 ns
    #83;
    rst_n = 1'b1;

    // Cycle 1: enable=1, in_A=2
    @(negedge clk);
    enable = 1'b1;
    in_A = 8'd2;

    // Cycle 2: enable=1, in_A=5
    @(negedge clk);
    enable = 1'b1;
    in_A = 8'd5;

    // Cycle 3: enable=0, in_A=10
    @(negedge clk);
    enable = 1'b0;
    in_A = 8'd10;

    // Cycle 4: enable=1, in_A=3
    @(negedge clk);
    enable = 1'b1;
    in_A = 8'd3;

    // Allow Cycle 4 to be processed
    @(posedge clk);
    #1;

    $display("----------------------------------------");
    $display("Expected accumulator = 60");
    $display("Final accumulator    = %0d", accumulator);
    if (accumulator == 16'd60)
        $display("PASS: Standalone MAC verification");
    else
        $display("FAIL: Standalone MAC verification");
    $display("----------------------------------------");

    $finish;
end

endmodule

