`timescale 1ns/1ps

module sr_latch_tb;

reg s;
reg r;
reg clk;

wire q;
wire qbar;

sr_latch uut(
    .s(s),
    .r(r),
    .clk(clk),
    .q(q),
    .qbar(qbar)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    $dumpfile("sr_latch.vcd");
    $dumpvars(0, sr_latch_tb);

    $display("====================================");
    $display("        SR FLIP-FLOP TESTBENCH");
    $display("====================================");
    $display("Time   CLK   S   R   Q   Qbar");
    $display("------------------------------------");

    // Initial values
    clk = 0;
    s = 0;
    r = 0;

    #10;

    // SET
    s = 1;
    r = 0;

    #10;

    // HOLD
    s = 0;
    r = 0;

    #10;

    // RESET
    s = 0;
    r = 1;

    #10;

    // HOLD
    s = 0;
    r = 0;

    #10;

    $display("====================================");

    $finish;

end

// Display whenever any signal changes
always @(s or r or clk or q or qbar)
begin
    $display("%4t    %b     %b   %b   %b    %b",
             $time, clk, s, r, q, qbar);
end

endmodule
