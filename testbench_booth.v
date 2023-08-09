module testbench_booth;

reg clk,reset,start;
reg signed [3:0]A,B;
wire signed [7:0]C;
wire valid;

always #5 clk = ~clk;

Booth_multiplier inst (clk,reset,start,A,B,valid,C);

initial
$monitor($time,"A=%d, B=%d, valid=%d, C=%d ",A,B,valid,C);
initial
begin
A=4;B=6;clk=1'b1;reset=1'b0;start=1'b0;
#20 reset = 1'b1;
#10 start = 1'b1;
#10 start = 1'b0;
@valid
#10 A=-5;B=-7;start = 1'b1;
#10 start = 1'b0;
end      
endmodule
