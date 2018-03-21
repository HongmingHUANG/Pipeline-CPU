`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:12 11/18/2015 
// Design Name: 
// Module Name:    dm_4k 
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
module dm_4k(
    input [31:2]A,
    input [31:0]WD,
    input clk,
    input rst,
    input we,
	 input [3:0]BE,
	 output [31:0]RD,
	 input interupt
    );
reg [31:0] dm[2047:0];
integer i;
assign RD=dm[A[12:2]];

always @(posedge clk or posedge rst)
begin
	if(clk==1)
	begin
		if(rst==0 && interupt==0)
			if(we==1)
			begin
				case(BE)
					4'b1111:dm[A[12:2]]<=WD;
					4'b0011:dm[A[12:2]][15:0]<=WD[15:0];
					4'b1100:dm[A[12:2]][31:16]<=WD[15:0];
					4'b0001:dm[A[12:2]][7:0]<=WD[7:0];
					4'b0010:dm[A[12:2]][15:8]<=WD[7:0];
					4'b0100:dm[A[12:2]][23:16]<=WD[7:0];
					4'b1000:dm[A[12:2]][31:24]<=WD[7:0];
				endcase
			end
	end		
	if(rst==1)
	begin
		for(i=0;i<=1023;i=i+1)
			dm[i]<=0;
	end		
end
endmodule
