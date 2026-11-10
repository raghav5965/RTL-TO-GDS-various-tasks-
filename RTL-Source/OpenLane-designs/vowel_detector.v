
module vowel_detector(
    input clk, rst, x,
    output reg [3:0] y
);

// State encoding
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

reg [2:0] state, next;

// 1. Sequential state register
always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next;
end

// 2. Next-state combinational logic
always @(*) begin

    if (state == S0 && x == 1'b1)
        next = S1;
    else if (state == S0 && x == 1'b0)
        next = S0;

    else if (state == S1 && x == 1'b0)
        next = S2;
    else if (state == S1 && x == 1'b1)
        next = S1;

    else if (state == S2 && x == 1'b1)
        next = S1;
    else if (state == S2 && x == 1'b0)
        next = S3;

    else if (state == S3 && x == 1'b1)
        next = S4;
    else if (state == S3 && x == 1'b0)
        next = S0;

    else if (state == S4 && x == 1'b0)
        next = S2;
    else if (state == S4 && x == 1'b1)
        next = S1;

    else
        next = S0;

end

// 3. Moore output logic
always @(*) begin
    if (state == S4)
        y = 4'b0110;
    else
        y = 4'b0000;
end

endmodule

