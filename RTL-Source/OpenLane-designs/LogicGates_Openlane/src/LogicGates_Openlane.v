// ============================================================
// Project : Basic Logic Gates RTL-to-GDS
// Technology : SkyWater SKY130A - 130 nm
// Flow : OpenLane
// HDL : Verilog
//
// Gates:
//   AND
//   OR
//   NOT
//   NAND
//   NOR
//   XOR
//   XNOR
//   BUFFER
// ============================================================

module logic_gates (
    input  wire a,
    input  wire b,

    output wire y_and,
    output wire y_or,
    output wire y_not,
    output wire y_nand,
    output wire y_nor,
    output wire y_xor,
    output wire y_xnor,
    output wire y_buf
);

    // AND
    assign y_and = a & b;

    // OR
    assign y_or = a | b;

    // NOT
    assign y_not = ~a;

    // NAND
    assign y_nand = ~(a & b);

    // NOR
    assign y_nor = ~(a | b);

    // XOR
    assign y_xor = a ^ b;

    // XNOR
    assign y_xnor = ~(a ^ b);

    // BUFFER
    assign y_buf = a;

endmodule
