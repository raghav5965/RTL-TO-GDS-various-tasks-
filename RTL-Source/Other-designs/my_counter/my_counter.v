`timescale 1ns/1ps

module my_counter #(parameter bits = 4)(
    input wire clk, rst, enable,
    output reg [bits-1:0] out
);

always @(posedge clk) begin
    if (rst) begin
        out <= {bits{1'b0}};
    end
    else if (enable) begin
        out <= out + 1'b1;
    end
end

endmodule
