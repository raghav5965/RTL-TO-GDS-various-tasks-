`timescale 1ns/1ps

module four_to_mux_tb();

    reg [3:0] I;
    reg [1:0] S;
    wire y;

    integer i;

    four_to_mux uut(I, S, y);

    initial begin

        $dumpfile("four_to_mux.vcd");
        $dumpvars(0, four_to_mux_tb);

        $display("---------------------------");
        $display("       4:1 MUX");
        $display("---------------------------");
        $display(" I    S | Y");
        $display("---------------------------");

        I = 4'b1010;

        for(i = 0; i < 4; i = i + 1) begin

            S = i[1:0];

            #10;

            $display("%b   %b | %b", I, S, y);

        end

        $display("---------------------------");

        $finish;

    end

endmodule
