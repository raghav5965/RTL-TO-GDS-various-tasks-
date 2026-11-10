
`timescale 1ns/1ps

module rotate_register_tb;

reg clk;
reg rst;
reg load;
reg [3:0] D;

wire [3:0] Q;

// Instantiate the rotating register
rotate_register uut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .D(D),
    .Q(Q)
);

// Generate a clock with a 10 ns period
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

// Apply inputs and observe outputs
initial begin

    $dumpfile("rotate_register.vcd");
    $dumpvars(0, rotate_register_tb);

    // Initial conditions
    rst  = 1'b1;
    load = 1'b0;
    D    = 4'b0000;

    $display("Time\tReset\tLoad\tD\tQ");
    $display("--------------------------------");

    // Step 1: Reset the register
    repeat (2) @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    // Release reset away from the rising edge
    @(negedge clk);
    rst = 1'b0;

    // Step 2: Load the pattern 1101
    D    = 4'b1101;
    load = 1'b1;

    @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    // Step 3: Disable load to enable rotation
    @(negedge clk);
    load = 1'b0;

    // First rotation: 1101 -> 1110
    @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    // Second rotation: 1110 -> 0111
    @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    // Third rotation: 0111 -> 1011
    @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    // Fourth rotation: 1011 -> 1101
    @(posedge clk);
    #1;
    $display("%0t\t%b\t%b\t%b\t%b",
             $time, rst, load, D, Q);

    $display("--------------------------------");
    $display("Simulation completed.");

    $finish;
end

endmodule

