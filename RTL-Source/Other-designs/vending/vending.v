`timescale 1ns/1ps
module vending(
  input clk, rst,
  input [1:0] coin,
  output reg paid
);
  parameter S0  = 2'd0,
            S5  = 2'd1,
            S10 = 2'd2,
            S15 = 2'd3;
  reg [1:0] state, next;

  // State register
  always @(posedge clk) begin
    if (rst) state <= S0;
    else     state <= next;
  end

  // Next-state logic
  always @(*) begin
    next = state;
    case (state)
      S0: case (coin)
            2'b01: next = S5;
            2'b10: next = S10;
            2'b11: next = S15;
          endcase
      S5: case (coin)
            2'b01: next = S10;
            2'b10: next = S15;
            2'b11: next = S15;
          endcase
      S10: if (coin != 2'b00) next = S15;
      S15: if (coin != 2'b00) next = S0;
    endcase
  end

  // Output logic (Moore)
  always @(*) paid = (state == S15);
endmodule
