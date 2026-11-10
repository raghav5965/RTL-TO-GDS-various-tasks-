`timescale 1ns/1ps

module sequence_mac_tb;

reg clk, rst_n, x;
reg [7:0]in_A,[3:0]stream;

wire enable,[3:0]fsm_output,[15:0]accumulator;

integer i;

sequence_mac_system uut (
    .clk(clk),
    .rst_n(rst_n),
    .x(x),
    .in_A(in_A),
    .enable(enable),
    .fsm_output(fsm_output),
    .accumulator(accumulator)
);

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    $dumpfile("sequence_mac_system.vcd");
    $dumpvars(0, sequence_mac_tb);

    $monitor(
        "time=%0t | rst_n=%b | x=%b | state=%b | FSM_y=%b | enable=%b | in_A=%0d | accumulator=%0d",
        $time, rst_n, x, uut.FSM.state,
        fsm_output, enable, in_A, accumulator
    );

    // Apply active-low reset for exactly R = 83 ns
    rst_n = 1'b0;
    x = 1'b0;
    in_A = 8'd5;

    #83;
    rst_n = 1'b1;

    // Target sequence: 1001
    stream = 4'b1001;

    // Apply one serial bit per falling edge
    for (i = 3; i >= 0; i = i - 1) begin
        @(negedge clk);
        x = stream[i];
        in_A = 8'd5;

        // Allow FSM to sample this bit
        @(posedge clk);
        #1;

        // On detection, change in_A to R = 83
        if (fsm_output == 4'b0110) begin
            in_A = 8'd83;
            $display(
                "Sequence detected at time %0t; in_A changed to 83",
                $time
            );
        end
    end

    // Give the MAC one more rising edge to accumulate 83 * 6
    @(posedge clk);
    #1;

    $display("----------------------------------------");
    $display("Final FSM output = %b", fsm_output);
    $display("Final enable     = %b", enable);
    $display("Final accumulator = %0d", accumulator);
    $display("----------------------------------------");

    $finish;
end

endmodule
