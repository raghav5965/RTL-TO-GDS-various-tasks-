`timescale 1ns/1ps

module alu4_tb;

    reg clk;
    reg [3:0] a, b;
    reg [2:0] opcode;
    wire [3:0] result;

    integer i;

    // Explicit named port mapping
    alu4 uut (
        .clk(clk),
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("alu4_gls.vcd");
        $dumpvars(0, alu4_tb);

        // Back-annotate physical delays
        $sdf_annotate("alu4.sdf", uut);

        $monitor("Time=%0t | CLK=%b | A=%d | B=%d | OP=%b | RESULT=%d",
                 $time, clk, a, b, opcode, result);

        clk = 0;
        a = 4'd9;
        b = 4'd5;
        opcode = 3'b000;

        // Test all eight ALU operations
        for (i = 0; i < 8; i = i + 1) begin
            opcode = i;
            #10;
        end

        a = 4'd3;
        b = 4'd5;

        for (i = 0; i < 8; i = i + 1) begin
            opcode = i;
            #10;
        end

        #10;
        $finish;
    end

endmodule
