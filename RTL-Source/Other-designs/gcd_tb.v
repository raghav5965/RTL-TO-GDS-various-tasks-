`timescale 1ns/1ps

module gcd_tb;

    reg clk, rst, rdflg;
    reg [7:0] in_A, in_B;
    wire [7:0] out;
    wire flag;

    gcd uut (clk, rst, rdflg, in_A, in_B, out, flag);

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("gcd.vcd");
        $dumpvars(0, gcd_tb);

        $monitor("Time=%0t | rst=%b | rdflg=%b | A=%0d | B=%0d | out=%0d | flag=%b | Current_A=%0d | Current_B=%0d",$time, rst, rdflg, in_A, in_B, out, flag, uut.c_A, uut.c_B);

        clk   = 0;
        rst   = 0;
        rdflg = 0;
        in_A  = 0;
        in_B  = 0;

        // Reset
        #25;
        rst = 1;

        // Test 1: GCD(48,18) = 6
        @(negedge clk) in_A = 8'd48;
        @(negedge clk) in_B = 8'd0;
        @(negedge clk) rdflg = 1'b1;
        @(negedge clk) rdflg = 1'b0;

        wait(flag == 1'b1);
        #50;
        $finish;
    end

endmodule
