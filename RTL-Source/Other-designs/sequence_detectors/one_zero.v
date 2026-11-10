module one_zero(
    input wire clk, rst, x,
    output reg y
);

parameter s0 = 2'b00,
          s1 = 2'b01,
          s2 = 2'b10;

reg [1:0] state, next;

// State register
always @(posedge clk) begin
    if (rst)
        state <= s0;
    else
        state <= next;
end

// Next-state logic
always @(*) begin

    if (state == s0 && x == 1)
        next = s0;

    else if (state == s0 && x == 0)
        next = s1;

    else if (state == s1 && x == 0)
        next = s1;

    else if (state == s1 && x == 1)
        next = s2;

    else if (state == s2 && x == 1)
        next = s0;

    else if (state == s2 && x == 0)
        next = s1;

    else
        next = s0;

end

// Mealy output logic
always @(*) begin
    y = (state == s2) && (x == 0);
end

endmodule
