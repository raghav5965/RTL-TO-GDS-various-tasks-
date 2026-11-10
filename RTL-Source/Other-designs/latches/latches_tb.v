`timescale 1ns/1ps

module d_latch_tb();

reg en, d;
wire q;

d_latch uut(en, d, q);

initial begin

    $dumpfile("latches.vcd");
    $dumpvars(1, d_latch_tb);

    $display("===========");
    $display("latch result");
    $display("===========");

    $monitor("en=%b, d=%b | q=%b", en, d, q);

    d = 0;
    en = 0;

    #10;

    d = 1;
    en = 1;

    #10;

    d = 0;

    #10;

    en = 0;
    d = 1;

    #10;

    $finish;

end

endmodule
