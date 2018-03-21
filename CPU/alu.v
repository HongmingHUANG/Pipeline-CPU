`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:28 11/18/2015 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input[31:0] A,
    input[31:0] B,
    input[3:0] op,
    output [31:0] C,
    output Over
    );
reg [32:0]temp,temp2;
integer i;

always @(*)
begin
	case(op)
		4'b0000:begin temp=A | B; end//or
		4'b0001:begin temp=A & B; end//and
		4'b0010:begin temp={A[31],A} + {B[31],B}; end//add
		4'b0011:begin temp={A[31],A} - {B[31],B};end//sub
		4'b0100:begin temp=A ^ B; end//xor
		4'b0101:begin temp=~(A | B); end//nor
		4'b0110:begin temp=A + B; end//addu
		4'b0111:begin temp=A - B; end//subu
		4'b1000:begin temp=($signed(A)<$signed(B))?1:0; end//a<b
		4'b1001:begin temp=A<B?1:0; end//a<b(unsign)
		4'b1010:begin temp=B << A[4:0]; end//logic left shift
		4'b1011:begin temp=B >> A[4:0]; end//logic right shift
		4'b1100:begin temp=$signed(B) >>> A[4:0]; end//algorithm right shift\
		4'b1101:begin temp=B << 16; end
		default: temp=0;
	endcase
end
assign Over=((temp[32]!=temp[31])&&((op==4'b0010)||(op==4'b0011)))?1:0;
assign C=temp[31:0];
endmodule
