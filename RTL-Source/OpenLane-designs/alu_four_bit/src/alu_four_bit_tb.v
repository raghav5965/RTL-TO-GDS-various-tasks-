`timescale 1ns / 1ps

module alu_four_bit_tb;

    reg [3:0] a, b;
    reg [2:0] opcode;
    wire [3:0] result;

    integer i;

    // ALU instantiation
    alu uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    initial begin

        // Generate waveform
        $dumpfile("alu.vcd");
        $dumpvars(1, alu_tb);

        // Monitor outputs
        $monitor("Time=%0t | A=%b | B=%b | Opcode=%b | Result=%b",
                 $time, a, b, opcode, result);

        // Initialize inputs
        a = 4'b1100;
        b = 4'b0101;

        // Test all 8 ALU operations
        for (i = 0; i < 8; i = i + 1) begin
            opcode = i;
            #10;
        end

        $finish;
    end

endmodule
