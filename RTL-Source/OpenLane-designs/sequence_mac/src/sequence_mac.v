
`timescale 1ns/1ps

//====================================================
// CHILD MODULE 1: VOWEL DETECTOR (Moore FSM)
// Detects sequence 1001 and outputs 0110
//====================================================
module vowel_detector (
    input wire clk,
    input wire rst,
    input wire x,
    output reg [3:0] y
);

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

reg [2:0] state, next;

// State register
always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next;
end

// Next-state combinational logic
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

// Moore output logic
always @(*) begin
    if (state == S4)
        y = 4'b0110;
    else
        y = 4'b0000;
end

endmodule


//====================================================
// CHILD MODULE 2: MAC UNIT
// Accumulator = Accumulator + (in_A * multiplier)
// Active-low asynchronous reset
//====================================================
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
        accumulator <= accumulator +
                       (in_A * multiplier);
    // If enable = 0, accumulator retains its value
end

endmodule


//====================================================
// TOP-LEVEL PARENT MODULE
// Instantiates vowel_detector and mac
//====================================================
module sequence_mac(
    input wire clk,
    input wire rst_n,
    input wire x,
    input wire [7:0] in_A,
    output wire enable,
    output wire [3:0] fsm_output,
    output wire [15:0] accumulator
);

wire rst;

// Convert active-low reset to active-high FSM reset
assign rst = ~rst_n;

// Enable MAC only when FSM output equals 0110
assign enable = (fsm_output == 4'b0110);

// Child instance 1: FSM
vowel_detector FSM (clk,rst,x,fsm_output);

// Child instance 2: MAC
mac MAC_UNIT (clk,rst_n,enable,in_A,fsm_output,accumulator
);

endmodule

