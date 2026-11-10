`timescale 1ns/1ps

module gcd(
    input wire clk, rst, rdflg,
    input wire [7:0] in_A, in_B,
    output reg [7:0] out,
    output reg flag
);

parameter idle   = 2'b00;
parameter calc   = 2'b01;
parameter result = 2'b10;

reg [1:0] current, next;
reg [7:0] c_A, c_B, n_A, n_B;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        current <= idle;
        c_A <= 8'd0;
        c_B <= 8'd0;
    end
    else begin
        current <= next;
        c_A <= n_A;
        c_B <= n_B;
    end
end

always @(*) begin
    next = current;
    n_A = c_A;
    n_B = c_B;
    out = 8'd0;
    flag = 1'b0;

    case (current)

        idle: begin
           if( rdflg) begin
            n_A = in_A;
            n_B = in_B;
            next = calc;
           end 

        end

        calc: begin
            if (c_A == 8'd0 || c_B == 8'd0)
                next = result;
            else
            if (c_A == c_B)
                next = result;
            else if (c_A > c_B)
                n_A = c_A - c_B;
            else
                n_B = c_B - c_A;
        end

        result: begin
            out = c_A;
            flag = 1'b1;
            next = idle;
        end

        default: begin
           if (!rdflg) begin
            next = idle;
            end     
        end

    endcase
end

endmodule
