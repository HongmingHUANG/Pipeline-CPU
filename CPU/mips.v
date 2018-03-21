`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:34 11/25/2015 
// Design Name: 
// Module Name:    mips 
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
`define rs 25:21
`define rt 20:16
`define rd 15:11
module mips(
    input clk,
    input reset,
	 output [31:0]addr_cpu,
	 output [31:0]din_cpu,
	 output we_cpu,
	 input [5:0]intq
    );
wire rst;
wire [31:0] npc,IR_F_out,PC4_F_out,PC8_F_out;
wire [1:0]PC_sel;
wire [31:0]IR_DE_out,RS_DE_out,RT_DE_out,EXT_DE_out,PC4_DE_out,PC8_DE_out;
wire [31:0]IR_FD_out,PC4_FD_out,PC8_FD_out;
wire [31:0]IR_D_out,RS_D_out,RT_D_out,EXT_D_out;
wire [31:0]PC4_D_out,PC8_D_out,AO,M4,XAO;
wire FD_cal_r,FD_cal_i,FD_l,FD_beq,FD_st,FD_jr,FD_jal,FD_mtdv,FD_movto,FD_movfm,MW_cal_r,MW_cal_i,MW_l,MW_jal,MW_jr,MW_movfm,MW_mfc0;
wire [31:0]IR_E_out,ALUout_E_out,XALUout_E_out,RT_E_out,PC4_E_out,PC8_E_out;
wire DE_cal_r,DE_cal_i,DE_l,DE_jal,DE_jr,DE_mtdv,DE_movto,DE_movfm,DE_mfc0,DE_mtc0;
wire [31:0]IR_EM_out,PC4_EM_out,PC8_EM_out,ALUout_EM_out,XALUout_EM_out,RT_EM_out;
wire [31:0] IR_M_out,ALUout_M_out,XALUout_M_out,DM_M_out,PC4_M_out,PC8_M_out;
wire EM_cal_r,EM_cal_i,EM_l,EM_jal,EM_jr,EM_movfm,EM_mfc0,EM_mtc0;
wire [31:0]IR_MW_out,ALUout_MW_out,XALUout_MW_out,CP0out_MW_out,DM_MW_out,PC4_MW_out,PC8_MW_out,DM_A_MW_out;
wire [2:0]ForwardRSD,ForwardRTD,ForwardRSE,ForwardRTE,ForwardRTM;
wire Stall,XALUbusy,int_end;
wire [31:0]CP0out,EPCout;
assign rst=reset;
Fphase Fphase(
			.clk(clk),
			.rst(rst),
			.NPC(npc),
			.Stall(Stall),
			.RS_D(RS_D_out),
			.IR_F_out(IR_F_out),
			.PC4_F_out(PC4_F_out),
			.PC8_F_out(PC8_F_out),
			.PC_sel(PC_sel),
			.EPC(EPCout),
			.interupt(interupt),
			.int_end(int_end)
	);
	

Reg_F_D F_D(
			.clk(clk),
			.rst(rst),
			.en(~Stall),
			.interupt(interupt),
			.IR_D_in(IR_F_out),
			.PC4_D_in(PC4_F_out),
			.PC8_D_in(PC8_F_out),
			.IR_D_out(IR_FD_out),
			.PC4_D_out(PC4_FD_out),
			.PC8_D_out(PC8_FD_out)
	);


DWphase DWphase(
		.IR_D_in(IR_FD_out),
		.PC4_D_in(PC4_FD_out),
		.PC8_D_in(PC8_FD_out),
		.ForwardRSD(ForwardRSD),
		.ForwardRTD(ForwardRTD),
		.AO(AO),
		.XAO(XAO),
		.M4(M4),
		.DE_PC8(PC8_DE_out),
		.EM_PC8(PC8_EM_out),
		.IR_D_out(IR_D_out),
		.GPRrs_D_out(RS_D_out),
		.GPRrt_D_out(RT_D_out),
		.EXT_D_out(EXT_D_out),
		.PC4_D_out(PC4_D_out),
		.PC8_D_out(PC8_D_out),
		.NPC_D_out(npc),
		.PC_sel(PC_sel),
		.IR_W_in(IR_MW_out),
		.ALUout_W_in(ALUout_MW_out),
		.XALUout_W_in(XALUout_MW_out),
		.CP0out_W_in(CP0out_MW_out),
		.DM_W_in(DM_MW_out),
		.DM_A_W_in(DM_A_MW_out),
		.PC4_W_in(PC4_MW_out),
		.PC8_W_in(PC8_MW_out),
		.clk(clk),
		.rst(rst),
		.FD_jal(FD_jal),
		.FD_jr(FD_jr),
		.FD_cal_r(FD_cal_r),
		.FD_cal_i(FD_cal_i),
		.FD_l(FD_l),
		.FD_beq(FD_beq),
		.FD_st(FD_st),
		.FD_mtdv(FD_mtdv),
		.FD_movto(FD_movto),
		.FD_movfm(FD_movfm),
		.MW_jal(MW_jal),
		.MW_jr(MW_jr),
		.MW_cal_r(MW_cal_r),
		.MW_cal_i(MW_cal_i),
		.MW_l(MW_l),
		.MW_movfm(MW_movfm),
		.MW_mfc0(MW_mfc0),
		.M4_W_out(M4)
	);


Reg_D_E D_E(
		.IR_E_in(IR_D_out),
		.PC4_E_in(PC4_D_out),
		.PC8_E_in(PC8_D_out),
		.GPRrs_E_in(RS_D_out),
		.GPRrt_E_in(RT_D_out),
		.EXT_E_in(EXT_D_out),
		.IR_E_out(IR_DE_out),
		.PC4_E_out(PC4_DE_out),
		.PC8_E_out(PC8_DE_out),
		.GPRrs_E_out(RS_DE_out),
		.GPRrt_E_out(RT_DE_out),
		.EXT_E_out(EXT_DE_out),
		.clk(clk),
		.stall(Stall),
		.interupt(interupt),
		.rst(rst)
	);


Ephase Ephase(
		.IR_E_in(IR_DE_out),
		.RS_E_in(RS_DE_out),
		.RT_E_in(RT_DE_out),
		.EXT_E_in(EXT_DE_out),
		.PC4_E_in(PC4_DE_out),
		.PC8_E_in(PC8_DE_out),
		.IR_E_out(IR_E_out),
		.ALUout_E_out(ALUout_E_out),
		.XALUout_E_out(XALUout_E_out),
		.XALUbusy(XALUbusy),
		.RT_E_out(RT_E_out),
		.PC4_E_out(PC4_E_out),
		.PC8_E_out(PC8_E_out),
		.DE_cal_r(DE_cal_r),
		.DE_cal_i(DE_cal_i),
		.DE_l(DE_l),
		.DE_st(DE_st),
		.DE_jr(DE_jr),
		.DE_jal(DE_jal),
		.DE_mtdv(DE_mtdv),
		.DE_movto(DE_movto),
		.DE_movfm(DE_movfm),
		.DE_mfc0(DE_mfc0),
		.DE_mtc0(DE_mtc0),
		.ForwardRSE(ForwardRSE),
		.ForwardRTE(ForwardRTE),
		.AO(AO),
		.XAO(XAO),
		.M4(M4),
		.EM_PC8(PC8_EM_out),
		.MW_PC8(PC8_MW_out),
		.clk(clk),
		.rst(rst),
		.interupt(interupt),
		.clear_xalu(clear_xalu)
	);


Reg_E_M E_M(
		.IR_M_in(IR_E_out),
		.PC4_M_in(PC4_E_out),
		.PC8_M_in(PC8_E_out),
		.ALUout_M_in(ALUout_E_out),
		.XALUout_M_in(XALUout_E_out),
		.GPRrt_M_in(RT_E_out),
		.IR_M_out(IR_EM_out),
		.PC4_M_out(PC4_EM_out),
		.PC8_M_out(PC8_EM_out),
		.ALUout_M_out(ALUout_EM_out),
		.XALUout_M_out(XALUout_EM_out),
		.GPRrt_M_out(RT_EM_out),
		.AO_EM_out(AO),
		.XAO_EM_out(XAO),
		.interupt(interupt),
		.clk(clk),
		.rst(rst)
	);


Mphase Mphase(
		.IR_M_in(IR_EM_out),
		.ALUout_M_in(ALUout_EM_out),
		.XALUout_M_in(XALUout_EM_out),
		.RT_M_in(RT_EM_out),
		.PC4_M_in(PC4_EM_out),
		.PC8_M_in(PC8_EM_out),
		.IR_M_out(IR_M_out),
		.ALUout_M_out(ALUout_M_out),
		.XALUout_M_out(XALUout_M_out),
		.DM_M_out(DM_M_out),
		.PC4_M_out(PC4_M_out),
		.PC8_M_out(PC8_M_out),
		.DM_addr(addr_cpu),
		.DM_din(din_cpu),
		.DM_we(we_cpu),
		.EM_cal_r(EM_cal_r),
		.EM_cal_i(EM_cal_i),
		.EM_l(EM_l),
		.EM_st(EM_st),
		.EM_jr(EM_jr),
		.EM_jal(EM_jal),
		.EM_movfm(EM_movfm),
		.EM_mfc0(EM_mfc0),
		.EM_mtc0(EM_mtc0),
		.M4(M4),
		.MW_PC8(PC8_MW_out),
		.ForwardRTM(ForwardRTM),
		.interupt(interupt),
		.clk(clk),
		.rst(rst)
	);
//------------------假装CP0在这里
cp0 CP0(
		.wa(IR_EM_out[`rd]),
		.ra(IR_EM_out[`rd]),
		.din(RT_EM_out),
		.instrM(IR_EM_out),
		.instrW(IR_MW_out),
		.we(EM_mtc0),
		.M_PC4(PC4_EM_out),
		.ExcCode(0),
		.intq(intq),
		.EPCout(EPCout),
		.interupt(interupt),
		.clear_xalu(clear_xalu),
		.dout(CP0out),
		.int_end(int_end),
		.clk(clk),
		.rst(rst)
	);

Reg_M_W M_W(
		.IR_W_in(IR_M_out),
		.PC4_W_in(PC4_M_out),
		.PC8_W_in(PC8_M_out),
		.ALUout_W_in(ALUout_M_out),
		
		.XALUout_W_in(XALUout_M_out),
		.CP0out_W_in(CP0out),
		.DM_W_in(DM_M_out),
		.IR_W_out(IR_MW_out),
		.PC4_W_out(PC4_MW_out),
		.PC8_W_out(PC8_MW_out),
		.ALUout_W_out(ALUout_MW_out),
		.XALUout_W_out(XALUout_MW_out),
		.CP0out_W_out(CP0out_MW_out),
		.DM_W_out(DM_MW_out),
		.DM_A_W_out(DM_A_MW_out),
		.clk(clk),
		.rst(rst)
	);


hazard hazard(
		.IR_D(IR_FD_out),
		.FD_jr(FD_jr),
		.FD_jal(FD_jal),
		.FD_cal_r(FD_cal_r),
		.FD_cal_i(FD_cal_i),
		.FD_l(FD_l),
		.FD_beq(FD_beq),
		.FD_st(FD_st),
		.FD_mtdv(FD_mtdv),
		.FD_movto(FD_movto),
		.FD_movfm(FD_movfm),
		.IR_E(IR_DE_out),
		.XALUbusy(XALUbusy),
		.DE_jr(DE_jr),
		.DE_jal(DE_jal),
		.DE_cal_r(DE_cal_r),
		.DE_cal_i(DE_cal_i),
		.DE_l(DE_l),
		.DE_st(DE_st),
		.DE_mtdv(DE_mtdv),
		.DE_movto(DE_movto),
		.DE_movfm(DE_movfm),
		.DE_mfc0(DE_mfc0),
		.DE_mtc0(DE_mtc0),
		.IR_M(IR_EM_out),
		.EM_jr(EM_jr),
		.EM_jal(EM_jal),
		.EM_cal_r(EM_cal_r),
		.EM_cal_i(EM_cal_i),
		.EM_l(EM_l),
		.EM_st(EM_st),
		.EM_movfm(EM_movfm),
		.EM_mfc0(EM_mfc0),
		.EM_mtc0(EM_mtc0),
		.IR_W(IR_MW_out),
		.MW_jr(MW_jr),
		.MW_jal(MW_jal),
		.MW_cal_r(MW_cal_r),
		.MW_cal_i(MW_cal_i),
		.MW_l(MW_l),
		.MW_movfm(MW_movfm),
		.MW_mfc0(MW_mfc0),
		.stall(Stall),
		.ForwardRSD(ForwardRSD),
		.ForwardRTD(ForwardRTD),
		.ForwardRSE(ForwardRSE),
		.ForwardRTE(ForwardRTE),
		.ForwardRTM(ForwardRTM)
	);
endmodule
