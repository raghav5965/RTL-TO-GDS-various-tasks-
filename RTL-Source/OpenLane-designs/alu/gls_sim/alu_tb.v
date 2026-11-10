`timescale 1ns/1ps

module alu4_tb;

    reg clk;
    reg [31:0] a, b;
    reg [2:0] opcode;
    wire [31:0] result;

    integer i;

    // Gate-level ALU instantiation
    alu4 uut (
        .clk(clk),
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("alu4_gls.vcd");
        $dumpvars(0, alu4_tb);
$sdf_annotate("alu4.sdf", uut);
        clk = 0;
        a = 0;
        b = 0;
        opcode = 0;

        $display("==============================================");
        $display("       ALU GATE LEVEL SIMULATION");
        $display("==============================================");

        // Test Case 1
        a = 32'd9;
        b = 32'd5;

        for (i = 0; i < 8; i = i + 1) begin
            @(negedge clk);
            opcode = i;
            @(posedge clk);
            #1;
            $display("OP=%b A=%d B=%d RESULT=%d (0x%h)",
                     opcode, a, b, result, result);
        end

        // Test Case 2
        a = 32'd3;
        b = 32'd5;

        for (i = 0; i < 8; i = i + 1) begin
            @(negedge clk);
            opcode = i;
            @(posedge clk);
            #1;
            $display("OP=%b A=%d B=%d RESULT=%d (0x%h)",
                     opcode, a, b, result, result);
        end

        $display("==============================================");
        $display("       SIMULATION COMPLETED");
        $display("==============================================");

        #10;
        $finish;

    end

endmodule
