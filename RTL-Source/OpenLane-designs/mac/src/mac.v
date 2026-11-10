
module mac (
    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire [7:0] in_A,
    input wire [3:0] multiplier,
    output reg [15:0] accumulator
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        accumulator <= 16'd0;
    else if (enable)
        accumulator <= accumulator + (in_A * multiplier);
    // When enable = 0, accumulator holds its value
end

endmodule

