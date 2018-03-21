`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:44 12/07/2015 
// Design Name: 
// Module Name:    be_ext 
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
module be_ext(
			input [1:0]A,
			input [1:0]op,
			output [3:0]BE
    );
assign BE=(op==2'b00)?4'b1111:
				((op==2'b01)&&(A[1]==0))?4'b0011:
				((op==2'b01)&&(A[1]==1))?4'b1100:
				((op==2'b10)&&(A==2'b00))?4'b0001:
				((op==2'b10)&&(A==2'b01))?4'b0010:
				((op==2'b10)&&(A==2'b10))?4'b0100:
				((op==2'b10)&&(A==2'b11))?4'b1000:0;

endmodule
