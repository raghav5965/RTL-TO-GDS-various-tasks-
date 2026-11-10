//======================================================
// 2-Input NAND Gate
//======================================================

module nand2 (
    input  wire a,
    input  wire b,
    output wire y
);

    assign y = ~(a & b);

endmodule



module d_latch_nand (
    input  wire d,
    input  wire en,
    output wire q,
    output wire qb
);

    wire dn;
    wire s;
    wire r;

    nand2 NAND1 (
        .a(d),
        .b(d),
        .y(dn)
    );

  
    nand2 NAND2 (
        .a(d),
        .b(en),
        .y(s)
    );

   
    nand2 NAND3 (
        .a(dn),
        .b(en),
        .y(r)
    );

   
    nand2 NAND4 (
        .a(s),
        .b(qb),
        .y(q)
    );

 
    nand2 NAND5 (
        .a(r),
        .b(q),
        .y(qb)
    );

endmodule
