`timescale 1ns / 1ps

module alu4 (
    input wire clk,
    input wire [3:0] a, b,
    input wire [2:0] opcode,
    output reg [3:0] result
);

    always @(posedge clk) begin
        case (opcode)
            3'b000: result <= a + b;
            3'b001: result <= a - b;
            3'b010: result <= a & b;
            3'b011: result <= a | b;
            3'b100: result <= a ^ b;
            3'b101: result <= ~a;
            3'b110: result <= a << 1;
            3'b111: result <= a * b;
            default: result <= 4'd0;
        endcase
    end

endmodule
