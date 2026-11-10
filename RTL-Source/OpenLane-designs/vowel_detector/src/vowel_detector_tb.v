
`timescale 1ns/1ps

module vowel_detector_tb;

reg clk, rst, x;
wire [3:0] y;

integer i;
reg [15:0] stream;

// Instantiate the FSM using named port connections
vowel_detector uut (
    .clk(clk),
    .rst(rst),
    .x(x),
    .y(y)
);

// Generate a 10 ns clock
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("vowel_detector.vcd");
    $dumpvars(0, vowel_detector_tb);

    // 16-bit serial stream ending in the target sequence 1001
    stream = 16'b0100000000001001;

    // Initialize inputs and apply synchronous reset
    rst = 1'b1;
    x   = 1'b0;

    // Keep reset active through two rising edges
    repeat (2) @(posedge clk);

    // Release reset on the falling edge
    @(negedge clk);
    rst = 1'b0;

    $display("Time(ns)  x  State  y");

    // Send the stream MSB first, one bit per clock cycle
    for (i = 15; i >= 0; i = i - 1) begin
        x = stream[i];

        // Wait for the FSM to sample the input
        @(posedge clk);
        #1;

        $display("%0t       %b  %b     %b",
                 $time, x, uut.state, y);

        // Prepare the next input bit on the falling edge
        @(negedge clk);
    end

    $display("Final output y = %b", y);

    #1;
    $finish;
end

endmodule

