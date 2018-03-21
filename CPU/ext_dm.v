`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:12 12/02/2015 
// Design Name: 
// Module Name:    ext_dm 
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
module ext_dm(
		input [1:0]A,
		input [31:0]Din,
		input [2:0]op,
		input [31:0]Dout
    );
/*always @(*)
begin
	case(op)
		3'b000: Dout=Din;
		3'b001:begin
			case(A)
		end
		
	endcase
end*/
endmodule
