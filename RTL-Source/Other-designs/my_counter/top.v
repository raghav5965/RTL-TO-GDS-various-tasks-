`timescale 1ns/1ps

module top(
    input wire clk, rst, enable,
    output wire [3:0] out_4,
    output wire [7:0] out_8
);

my_counter bit_4(clk, rst, enable, out_4);
my_counter #(8) bit_8(clk, rst, enable, out_8);

endmodule
