`timescale 1ns/1ps
module edge_det(
  input clk, rst, btn,
  output reg y
);
  parameter IDLE  = 2'd0,
            PULSE = 2'd1,
            HOLD  = 2'd2;
  reg [1:0] state, next;

  // Block 1: state register
  always @(posedge clk) begin
    if (rst) state <= IDLE;
    else     state <= next;
  end

  // Block 2: next-state logic
  always @(*) begin
    case (state)
      IDLE:    next = btn ? PULSE : IDLE;
      PULSE:   next = btn ? HOLD  : IDLE;
      HOLD:    next = btn ? HOLD  : IDLE;
      default: next = IDLE;
    endcase
  end

  // Block 3: output logic (Moore)
  always @(*) begin
    y = (state == PULSE);
  end
endmodule
