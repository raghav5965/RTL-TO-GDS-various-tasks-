`timescale 1ns/1ps

module one_zero_tb();

reg clk, rst, x;
wire y;

reg [7:0] stream;
integer i;

one_zero uut(clk, rst, x, y);

always #5 clk = ~clk;

initial begin

    $dumpfile("one_zero.vcd");
    $dumpvars(0, one_zero_tb);

    $display("OUTPUT");

    $monitor("time=%t | clk=%b | rst=%b | x=%b | state=%b | y=%b",
             $time, clk, rst, x, uut.state, y);

    clk = 0;
    rst = 1;
    x = 0;

    #12;
    rst = 0;

    stream = 8'b01100101;

    for (i = 7; i >= 0; i = i - 1) begin
        @(negedge clk);
        x = stream[i];
    end

    #20;

    $finish;

end

endmodule
