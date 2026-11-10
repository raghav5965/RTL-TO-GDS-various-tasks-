`timescale 1ns/1ps

module counter_4bit(
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [3:0] out
);

always @(posedge clk or posedge rst) begin

    if (rst)
        out <= 4'b0000;

    else if (enable)
        out <= out + 1'b1;

end

endmodule
