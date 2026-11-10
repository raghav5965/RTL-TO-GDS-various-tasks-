module sr_latch(
    input wire s,
    input wire r,
    input wire clk,
    output wire q,
    output wire qbar
);

wire s_g;
wire r_g;

nand n1(s_g, s, clk);
nand n2(r_g, r, clk);

nand n3(q, s_g, qbar);
nand n4(qbar, r_g, q);

endmodule
