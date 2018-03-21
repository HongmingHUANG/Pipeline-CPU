`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:56 11/18/2015 
// Design Name: 
// Module Name:    gpr 
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
module gpr(clk,rst,A1,A2,A3,we,wd,rd1,rd2);
input clk,rst,we;
input [4:0] A1,A2,A3;
input [31:0] wd;
output [31:0] rd1,rd2;
reg [31:0] memory[31:0];
integer i;
assign rd1=((A1==A3)&&(A3!=0)&&(we==1))?wd:memory[A1];
assign rd2=((A2==A3)&&(A3!=0)&&(we==1))?wd:memory[A2];
always @(posedge rst)
begin
	for(i=0;i<32;i=i+1)
		memory[i]<=0;
end
always @(posedge clk)
begin
	if(rst==0)
		if((we==1)&&(A3!=0))
		begin
			$display("$%d <= %x",A3,wd);
			memory[A3]<=wd;
			
		end
end
endmodule
