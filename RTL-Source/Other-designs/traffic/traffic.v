`timescale 1ns/1ps
module traffic(
  input clk, rst, s,
  output reg [2:0] hwy, road
);
  parameter HG = 2'd0,
            HY = 2'd1,
            RG = 2'd2,
            RY = 2'd3;
  parameter GREEN  = 3'b001,
            YELLOW = 3'b010,
            RED    = 3'b100;
  reg [1:0] state, next;

  // State register
  always @(posedge clk) begin
    if (rst) state <= HG;
    else     state <= next;
  end

  // Next-state logic
  always @(*) begin
    case (state)
      HG:      next = s ? HY : HG;
      HY:      next = RG;
      RG:      next = s ? RG : RY;
      RY:      next = HG;
      default: next = HG;
    endcase
  end

  // Output logic (Moore)
  always @(*) begin
    case (state)
      HG: begin hwy = GREEN;  road = RED;    end
      HY: begin hwy = YELLOW; road = RED;    end
      RG: begin hwy = RED;    road = GREEN;  end
      RY: begin hwy = RED;    road = YELLOW; end
      default: begin hwy = GREEN; road = RED; end
    endcase
  end
endmodule
