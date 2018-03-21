`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:25:53 12/02/2015 
// Design Name: 
// Module Name:    CMP 
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
module cmp(
		input [31:0]D1,
		input [31:0]D2,
		input [2:0]op,
		output reg out
    );
always @(*)
begin
	case(op)
		3'b000:begin out=(D1==D2)?1:0; end //beq
		3'b001:begin out=(D1==D2)?0:1; end //bne
		3'b010:begin out=((D1[31]==1)||(D1==0))?1:0; end //D1<=0
		3'b011:begin out=((D1[31]==0)&&(D1!=0))?1:0; end //D1>0
		3'b100:begin out=(D1[31]==1)?1:0; end //D1<0
		3'b101:begin out=(D1[31]==0)?1:0; end //D1>=0;
		default: out=0;
	endcase
end

endmodule
