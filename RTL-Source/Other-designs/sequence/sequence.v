`timescale 1ns/1ps
module seq101(
  input clk, rst, x,
  output reg y
);
  parameter S0 = 2'd0,
            S1 = 2'd1,
            S2 = 2'd2;
  reg [1:0] state, next;

  // State register
  always @(posedge clk) begin
    if (rst) state <= S0;
    else     state <= next;
  end

  // Next-state logic
  always @(*) begin
    case (state)
      S0: next = x ? S1 : S0;
      S1: next = x ? S1 : S2;
      S2: next = x ? S1 : S0;
      default: next = S0;
    endcase
  end

  // Output logic (Mealy)
  always @(*) begin
    y = (state == S2) && x;
  end
endmodule
