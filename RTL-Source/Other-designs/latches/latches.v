module d_latch(
    input wire en, d,
    output reg q
);

always @(*) begin
    if (en)
        q = d;
end

endmodule
