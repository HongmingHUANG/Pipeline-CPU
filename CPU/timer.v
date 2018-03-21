`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:33 12/16/2015 
// Design Name: 
// Module Name:    timer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module timer(
		input clk,rst,we,
		input [3:2]addr,
		input [31:0]din,
		output intq
    );
reg [31:0] CTRL,PRESET,COUNT;
reg [1:0]mode;
reg interupt;
initial
begin
	CTRL=0;
	PRESET=0;
	COUNT=0;
	interupt=0;
	mode=0;
end
always @(posedge clk)
begin
	if(CTRL[1]==0)
	begin
		case(mode)
		
			2'b00:begin//idle
				if((we==1)&&(addr==0)&&(din[0]==1))
					mode<=1;
				if(CTRL[0]==1)
					mode<=1;
			end
			2'b01:begin//load
				COUNT<=PRESET;
				mode<=2;
			end
			2'b10:begin//count
				COUNT=COUNT-1;
				if((we==1)&&(addr==0)&&(din[0]==0))
					mode<=0;
				else if(CTRL[0]==0)
					mode<=0;
				else if(COUNT==0)
					mode<=3;
			end
			2'b11:begin//int
				interupt<=CTRL[3];
				if((we==1)&&(addr==1))
					mode<=0;
			end
		endcase 
	end
	else
	begin
		if(CTRL[0]==1)
		begin
			if(COUNT==0)
				COUNT<=PRESET;
			else
				COUNT<=COUNT-1;
		end
	end
end
always @(posedge clk)
begin
	if(we==1 && addr==0)
		CTRL<=din;
	if(we==1 && addr==1)
		PRESET<=din;
end
assign intq=interupt;
endmodule
