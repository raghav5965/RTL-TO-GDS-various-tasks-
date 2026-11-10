module four_to_mux(I, S, y);

input wire [3:0] I;
input wire [1:0] S;
output reg y;

always @(*) begin

    case (S)
        2'b00: y = I[0];
        2'b01: y = I[1];
        2'b10: y = I[2];
        2'b11: y = I[3];
        default: y = 1'b0;
    endcase

end

endmodule
