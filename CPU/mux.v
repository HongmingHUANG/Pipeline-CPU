`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:01 11/18/2015 
// Design Name: 
// Module Name:    mux 
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
module mux3op(in0,in1,in2,in3,in4,in5,in6,in7,op,out
    );
input [31:0] in0,in1,in2,in3,in4,in5,in6,in7;
input [2:0]op;
output reg [31:0] out;
always @(*)
begin
	case(op)
		3'b000:out=in0;
		3'b001:out=in1;
		3'b010:out=in2;
		3'b011:out=in3;
		3'b100:out=in4;
		3'b101:out=in5;
		3'b110:out=in6;
		3'b111:out=in7;
	endcase
end
endmodule

module mux2op(in0,in1,in2,in3,op,out);
input [31:0]in0,in1,in2,in3;
input [1:0]op;
output reg [31:0]out;
always @(*)
begin
	case(op)
		2'b00:out=in0;
		2'b01:out=in1;
		2'b10:out=in2;
		2'b11:out=in3;
	endcase
end
endmodule

module mux1op(in0,in1,op,out);
input [31:0]in0,in1;
input op;
output [31:0]out;
assign out=op?in1:in0;
endmodule
