module flip_flop(
input wire d, clk,rst,
output reg q);
always @(posedge clk)
begin 
if(rst==1)
q <= d;
else
q <=1'b0;
end
endmodule
