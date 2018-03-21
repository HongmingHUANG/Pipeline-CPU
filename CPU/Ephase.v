`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:22 11/25/2015 
// Design Name: 
// Module Name:    Ephase 
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
module Ephase(
		input [31:0] IR_E_in,RS_E_in,RT_E_in,EXT_E_in,PC4_E_in,PC8_E_in,
		output [31:0] IR_E_out,ALUout_E_out,RT_E_out,PC4_E_out,PC8_E_out,XALUout_E_out,
		output DE_cal_r,
		output DE_cal_i,
		output DE_l,
		output DE_st,
		output DE_jal,
		output DE_jr,
		output DE_mtdv,
		output DE_movto,
		output DE_movfm,
		output DE_mfc0,
		output DE_mtc0,
		output XALUbusy,
		input [2:0]ForwardRSE,ForwardRTE,
		input [31:0]AO,M4,XAO,MW_PC8,EM_PC8,
		input clk,rst,
		input interupt,clear_xalu
    );
wire [31:0]IR,ALUa,ALUb,rs,rt,ALUout,XALUout,XALU_HI,XALU_LO;
wire [3:0]ALUop;
wire Ecalr,Ecali,El,ALUasel,ALUbsel;
wire XALUhilo,XALUstart,XALUwe,XALU_outsel;
wire [1:0]XALUop;

assign IR=IR_E_in;
assign IR_E_out=IR;
assign ALUout_E_out=ALUout;
assign RT_E_out=rt;
assign PC4_E_out=PC4_E_in;
assign PC8_E_out=PC8_E_in;

ctrl ctrl(
			.instr(IR),
			.ALU_asel(ALUasel),
			.ALU_bsel(ALUbsel),
			.ALUop(ALUop),
			.XALUhilo(XALUhilo),
			.XALUop(XALUop),
			.XALUstart(XALUstart),
			.XALUwe(XALUwe),
			.XALU_outsel(XALU_outsel),
			
			.Ins_cal_r(DE_cal_r),
			.Ins_cal_i(DE_cal_i),
			.Ins_jal(DE_jal),
			.Ins_jr(DE_jr),
			.Ins_l(DE_l),
			.Ins_st(DE_st),
			.Ins_mtdv(DE_mtdv),
			.Ins_movto(DE_movto),
			.Ins_movfm(DE_movfm),
			.Ins_mfc0(DE_mfc0),
			.Ins_mtc0(DE_mtc0)
	);
mux3op MFRSE(
			.in0(RS_E_in),
			.in1(AO),
			.in2(M4),
			.in3(0),
			.in4(EM_PC8),
			.in5(XAO),
			.op(ForwardRSE),
			.out(rs)
	);	
mux3op MFRTE(
			.in0(RT_E_in),
			.in1(AO),
			.in2(M4),
			.in3(0),
			.in4(EM_PC8),
			.in5(XAO),
			.op(ForwardRTE),
			.out(rt)
	);	
mux1op MUX_ALUa(
			.in0(rs),
			.in1({27'b0,IR[10:6]}),
			.op(ALUasel),
			.out(ALUa)
	);
mux1op MUX_ALUb(
			.in0(rt),
			.in1(EXT_E_in),
			.op(ALUbsel),
			.out(ALUb)
	);
alu ALU(
			.A(ALUa),
			.B(ALUb),
			.op(ALUop),
			.C(ALUout),
			.Over()
	);
xalu XALU(
			.D1(rs),
			.D2(rt),
			.hilo(XALUhilo),
			.op(XALUop),
			.start(XALUstart),
			.we(XALUwe),
			.HI(XALU_HI),
			.LO(XALU_LO),
			.busy(XALUbusy),
			.clk(clk),
			.rst(rst),
			.interupt(interupt),
			.clear_xalu(clear_xalu)
	);
assign XALUout_E_out=(XALU_outsel)?XALU_HI:XALU_LO;
endmodule
