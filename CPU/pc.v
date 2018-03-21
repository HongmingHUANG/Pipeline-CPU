`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:36 11/18/2015 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input [31:0]NPC,EPC,
    input clk,
    input rst,
	 input en,
	 input int_end,
	 input interupt,
    output [31:0]out
    );
reg [31:0]PC;
assign out=PC;
always @(posedge rst)
begin
	PC<=32'h00003000;
end
always @(posedge clk)
begin
	if(rst==0)
	begin 
		if(int_end==1)
			PC<=EPC;
		else if(interupt==1)
			PC<=32'h0000_4180;
		else 
			PC<=NPC;
	end
end
endmodule
