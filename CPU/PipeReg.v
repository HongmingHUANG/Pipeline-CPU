`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:26:42 11/25/2015 
// Design Name: 
// Module Name:    PipeReg 
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
module Reg_F_D(
		input [31:0]IR_D_in,
		input [31:0]PC4_D_in,
		input [31:0]PC8_D_in,
		input clk,rst,en,
		input interupt,
		output [31:0]IR_D_out,
		output [31:0]PC4_D_out,
		output [31:0]PC8_D_out
    );
reg [31:0]IR,PC4,PC8;
assign IR_D_out=IR;
assign PC4_D_out=PC4;
assign PC8_D_out=PC8;
always @(posedge rst)
begin
	IR<=0;
	PC4<=32'h00003004;
	PC8<=32'h00003008;
end
always @(posedge clk)
begin
	if(rst==0 && en && interupt==0)
	begin
		IR=IR_D_in;
		PC4=PC4_D_in;
		PC8=PC8_D_in;
	end
	if(interupt==1)
	begin
		IR<=0;
		PC4<=32'h00003004;
		PC8<=32'h00003008;
	end
end
endmodule

module Reg_D_E(
		input [31:0]IR_E_in,
		input [31:0]PC4_E_in,
		input [31:0]PC8_E_in,
		input [31:0]GPRrs_E_in,
		input [31:0]GPRrt_E_in,
		input [31:0]EXT_E_in,
		output [31:0]IR_E_out,
		output [31:0]PC4_E_out,
		output [31:0]PC8_E_out,
		output [31:0]GPRrs_E_out,
		output [31:0]GPRrt_E_out,
		output [31:0]EXT_E_out,
		input interupt,
		input clk,rst,stall
	);
reg [31:0]IR,PC4,PC8,GPRrs,GPRrt,EXT;
assign IR_E_out=IR;
assign PC4_E_out=PC4;
assign PC8_E_out=PC8;
assign GPRrs_E_out=GPRrs;
assign GPRrt_E_out=GPRrt;
assign EXT_E_out=EXT;
always @(posedge rst)
begin 
	if(rst==1)
	begin
		IR<=0;
		PC4<=32'h00003004;
		PC8<=32'h00003008;
		GPRrs<=0;
		GPRrt<=0;
		EXT<=0;
	end
end
always @(posedge clk)
begin
	if(stall==0 && interupt==0)
	begin
		IR<=IR_E_in;
		PC4<=PC4_E_in;
		PC8<=PC8_E_in;
		GPRrs<=GPRrs_E_in;
		GPRrt<=GPRrt_E_in;
		EXT<=EXT_E_in;
	end
	else if(stall==1 && interupt==0)
	begin
		IR<=0;
		PC4<=PC4_E_in;
		PC8<=32'h00003008;
		GPRrs<=0;
		GPRrt<=0;
		EXT<=0;
	end
	else
	begin
		IR<=0;
		PC4<=32'h00003004;
		PC8<=32'h00003008;
		GPRrs<=0;
		GPRrt<=0;
		EXT<=0;	
	end
end
endmodule

module Reg_E_M(
		input [31:0] IR_M_in,
		input [31:0] PC4_M_in,
		input [31:0] PC8_M_in,
		input [31:0] ALUout_M_in,
		input [31:0] XALUout_M_in,
		input [31:0] GPRrt_M_in,
		output [31:0] IR_M_out,
		output [31:0] PC4_M_out,
		output [31:0] PC8_M_out,
		output [31:0] ALUout_M_out,
		output [31:0] XALUout_M_out,
		output [31:0] GPRrt_M_out,
		output [31:0] AO_EM_out,
		output [31:0] XAO_EM_out,
		input interupt,
		input clk,rst
	);
reg [31:0]IR,PC4,PC8,ALUout,XALUout,GPRrt;
assign IR_M_out=IR;
assign PC4_M_out=PC4;
assign PC8_M_out=PC8;
assign ALUout_M_out=ALUout;
assign XALUout_M_out=XALUout;
assign GPRrt_M_out=GPRrt;
assign AO_EM_out=ALUout_M_out;
assign XAO_EM_out=XALUout_M_out;

always @(posedge rst)
begin
	IR<=0;
	PC4<=32'h00003004;
	PC8<=32'h00003008;
	ALUout<=0;
	XALUout<=0;
	GPRrt<=0;
end
always @(posedge clk)
begin 
	if(rst==0 && interupt==0)
	begin
		IR<=IR_M_in;
		PC4<=PC4_M_in;
		PC8<=PC8_M_in;
		ALUout<=ALUout_M_in;
		XALUout<=XALUout_M_in;
		GPRrt<=GPRrt_M_in;
	end
	else
	begin
		IR<=0;
		PC4<=32'h00003004;
		PC8<=32'h00003008;
		ALUout<=0;
		XALUout<=0;
		GPRrt<=0;
	end
end
endmodule

module Reg_M_W(
		input [31:0]IR_W_in,
		input [31:0]PC4_W_in,
		input [31:0]PC8_W_in,
		input [31:0]ALUout_W_in,
		input [31:0]XALUout_W_in,
		input [31:0]DM_W_in,
		input [31:0]CP0out_W_in,
		output [31:0]IR_W_out,
		output [31:0]PC4_W_out,
		output [31:0]PC8_W_out,
		output [31:0]ALUout_W_out,
		output [31:0]XALUout_W_out,
		output [31:0]DM_W_out,
		output [31:0]CP0out_W_out,
		output [31:0]DM_A_W_out,
		input clk,rst
	);
reg [31:0]IR,PC4,PC8,ALUout,XALUout,DM,CP0out;
assign IR_W_out=IR;
assign PC4_W_out=PC4;
assign PC8_W_out=PC8;
assign ALUout_W_out=ALUout;
assign XALUout_W_out=XALUout;
assign DM_W_out=DM;
assign CP0out_W_out=CP0out;
assign DM_A_W_out=ALUout;
always @(posedge rst)
begin
	IR<=0;
	PC4<=32'h00003004;
	PC8<=32'h00003008;
	ALUout<=0;
	XALUout<=0;
	DM<=0;
	CP0out<=0;
end
always @(posedge clk)
begin 
	if(rst==0)
	begin
		IR<=IR_W_in;
		PC4<=PC4_W_in;
		PC8<=PC8_W_in;
		ALUout<=ALUout_W_in;
		XALUout<=XALUout_W_in;
		DM<=DM_W_in;
		CP0out<=CP0out_W_in;
	end
end
endmodule
