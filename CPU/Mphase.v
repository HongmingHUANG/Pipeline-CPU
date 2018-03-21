`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:03:25 11/25/2015 
// Design Name: 
// Module Name:    Mphase 
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
module Mphase(
		input [31:0]IR_M_in,ALUout_M_in,XALUout_M_in,RT_M_in,PC4_M_in,PC8_M_in,
		output [31:0]IR_M_out,ALUout_M_out,XALUout_M_out,DM_M_out,PC4_M_out,PC8_M_out,
		output EM_cal_r,EM_cal_i,EM_l,EM_st,EM_jal,EM_jr,EM_movfm,EM_mfc0,EM_mtc0,
		input [31:0]M4,MW_PC8,
		input [2:0]ForwardRTM,
		input interupt,
		input clk,rst,
		output [31:0]DM_addr,DM_din,
		output DM_we
    );
wire [31:0]IR,rt;
wire [3:0]DM_BE;
wire [1:0]BE_EXTop;
wire MemWrite,mcalr,mcali,ml;

assign IR=IR_M_in;
assign IR_M_out=IR;
assign ALUout_M_out=ALUout_M_in;
assign XALUout_M_out=XALUout_M_in;
assign PC4_M_out=PC4_M_in;
assign PC8_M_out=PC8_M_in;

ctrl ctrl(
			.instr(IR),
			.MemWrite(MemWrite),
			.BE_EXTop(BE_EXTop),
			.Ins_cal_r(EM_cal_r),
			.Ins_cal_i(EM_cal_i),
			.Ins_jal(EM_jal),
			.Ins_jr(EM_jr),
			.Ins_l(EM_l),
			.Ins_st(EM_st),
			.Ins_movfm(EM_movfm),
			.Ins_mfc0(EM_mfc0),
			.Ins_mtc0(EM_mtc0)
	);
mux3op MFRTM(
			.in0(RT_M_in),
			.in1(0),
			.in2(M4),
			.in3(0),
			.in5(0),
			.op(ForwardRTM),
			.out(rt)
	);
be_ext BE_EXT(
			.A(ALUout_M_in[1:0]),
			.op(BE_EXTop),
			.BE(DM_BE)
	);
assign DM_addr=ALUout_M_in;
assign DM_din=rt;
assign DM_we=MemWrite;
dm_4k DM(
			.A(ALUout_M_in[31:2]),
			.WD(rt),
			.clk(clk),
			.rst(rst),
			.we(MemWrite),
			.RD(DM_M_out),
			.BE(DM_BE),
			.interupt(interupt)
	);
endmodule
