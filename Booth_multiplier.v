module Booth_multiplier(clk,reset,start,A,B,valid,C);
reg next_state,state;
reg q0;
reg [1:0] temp,n_temp;
reg [1:0] count;
reg [1:0] n_count;
output reg valid;
reg n_valid;
input clk;
input reset;
input start;
input signed[3:0]A;
input signed[3:0]B;
output signed[7:0]C;
reg signed [7:0]C;
reg signed [7:0]C_next;
reg signed [7:0]C_temp=0;

parameter IDLE=0;
parameter START=1;


always @(posedge clk or negedge reset)
 begin 
if (!reset)
        begin
		  C<=8'b0;
		  valid<=1'b0;
		  state<=1'b0;
		  temp<=2'd0;
		  count<=2'd0;
		  end

 else
    begin
C<=C_next;
valid<=n_valid;
temp<=n_temp;
count<=n_count;
state <= next_state;
end 
end


always @(*)
begin
next_state=IDLE;

case(state)
IDLE:
     begin 
      n_count=count;
      n_valid=1'b0;
		if(start)
		begin
		next_state=START;
		n_temp={A[0],1'b0};
		C_next={4'b0,A};
		end 
		
		end
		START:
		     begin
		     case(temp)
		      
			2'b10: C_temp={C[7:4]-B,C[3:0]};
		   2'b01: C_temp={C[7:4]+B,C[3:0]};
		default:C_temp={C[7:4],C[3:0]};
		endcase
		
		C_next=C_temp>>>1;
		n_count=count-1'b1;
		n_valid=(n_count==0)?1:0;
		next_state=(n_count==0)?IDLE:START;
		n_temp<={C_temp[1],C_temp[0]};
		end
		endcase
end
			
endmodule
