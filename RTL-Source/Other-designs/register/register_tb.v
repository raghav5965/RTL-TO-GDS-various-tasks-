
`timescale 1ns/1ps

module right_shift_tb;

reg clk;
reg rst;
reg [3:0] D;
wire [3:0] Q;

// Instantiate the DUT
right_shift uut (
    .clk(clk),
    .rst(rst),
    .D(D),
    .Q(Q)
);

// Generate a clock with a 10 ns period
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("right_shift.vcd");
    $dumpvars(0, right_shift_tb);

    // Apply reset
    rst = 1'b1;
    D = 4'b0000;

    repeat (2) @(posedge clk);
    @(negedge clk);
    rst = 1'b0;

    // Serial input sequence: 1, 0, 0, 1
    D[0] = 1'b1;
    @(posedge clk); #1;
    $display("Input bit = 1 | Q = %b", Q);

    @(negedge clk);
    D[0] = 1'b0;
    @(posedge clk); #1;
    $display("Input bit = 0 | Q = %b", Q);

    @(negedge clk);
    D[0] = 1'b0;
    @(posedge clk); #1;
    $display("Input bit = 0 | Q = %b", Q);

    @(negedge clk);
    D[0] = 1'b1;
    @(posedge clk); #1;
    $display("Input bit = 1 | Q = %b", Q);

    // Allow the final bit to propagate through all stages
    repeat (3) begin
        @(negedge clk);
        D[0] = 1'b0;
        @(posedge clk); #1;
        $display("Input bit = 0 | Q = %b", Q);
    end

    $finish;
end

endmodule

