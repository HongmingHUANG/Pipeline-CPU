`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:12 11/25/2015 
// Design Name: 
// Module Name:    Dphase 
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
`define imm16 15:0
module DWphase(
		input [31:0]IR_D_in,
		input [31:0]PC4_D_in,
		input [31:0]PC8_D_in,
		input [2:0]ForwardRSD,ForwardRTD,
		input [31:0]AO,M4,XAO,
		input [31:0]DE_PC8,EM_PC8,
		output [31:0]IR_D_out,
		output [31:0]GPRrs_D_out,
		output [31:0]GPRrt_D_out,
		output [31:0]EXT_D_out,
		output [31:0]PC4_D_out,
		output [31:0]PC8_D_out,
		output [31:0]NPC_D_out,
		output [1:0]PC_sel,
		input [31:0]IR_W_in,
		input [31:0]ALUout_W_in,
		input [31:0]XALUout_W_in,
		input [31:0]CP0out_W_in,
		input [31:0]DM_W_in,
		input [31:0]DM_A_W_in,
		input [31:0]PC4_W_in,
		input [31:0]PC8_W_in,
		input clk,rst,
		output FD_cal_r,
		output FD_cal_i,
		output FD_l,
		output FD_beq,
		output FD_st,
		output FD_jr,
		output FD_jal,
		output FD_mtdv,
		output FD_movto,
		output FD_movfm,
		output MW_cal_r,
		output MW_cal_i,
		output MW_l,
		output MW_jr,
		output MW_jal,
		output MW_movfm,
		output MW_mfc0,
		output [31:0]M4_W_out
    );
//phase D
wire [31:0]IR_D,PC4_D,PC8_D,rs_D,rt_D,rd1_D,rd2_D,EXT_D;
wire [1:0]NPCop;
wire [2:0]CMPop;
wire EXTop;
wire Dcalr,Dcali,Dl,Dbeq,Dst,Djr,Djal,CMPout;

wire RegWrite,Wcalr,Wcali,Wl;
wire [1:0]RF_WAsel;
wire [2:0]RF_WDsel;
wire [31:0]W_wa,W_wd;

assign IR_D=IR_D_in;

assign IR_D_out=IR_D;
assign EXT_D_out=EXT_D;
assign PC4_D_out=PC4_D_in;
assign PC8_D_out=PC8_D_in;
assign GPRrs_D_out=rs_D;
assign GPRrt_D_out=rt_D;
assign M4_W_out=W_wd;


gpr RF(.A1(IR_D[`rs]),
			.A2(IR_D[`rt]),
			.clk(clk),
			.rst(rst),
			.rd1(rd1_D),
			.rd2(rd2_D),
			.A3(W_wa),
			.wd(W_wd),
			.we(RegWrite));
ext16 EXT(.din(IR_D[`imm16]),
			.dout(EXT_D),
			.op(EXTop));
ctrl ctrl_D(.instr(IR_D),
			.EXTop(EXTop),
			.NPCop(NPCop),
			.CMPop(CMPop),
			.PC_sel(PC_sel),
			.Ins_jr(FD_jr),
			.Ins_jal(FD_jal),
			.Ins_cal_r(FD_cal_r),
			.Ins_cal_i(FD_cal_i),
			.Ins_l(FD_l),
			.Ins_beq(FD_beq),
			.Ins_st(FD_st),
			.Ins_mtdv(FD_mtdv),
			.Ins_movto(FD_movto),
			.Ins_movfm(FD_movfm)
			);
cmp CMP(
			.D1(rs_D),
			.D2(rt_D),
			.op(CMPop),
			.out(CMPout)
			);
npc npc(.instr(IR_D),
			.op(NPCop),
			.out(NPC_D_out),
			.pc4(PC4_D_in),
			.beq1(CMPout)
			);
mux3op MFRSD(.in0(rd1_D),
			.in1(AO),
			.in2(M4),
			.in3(DE_PC8),
			.in4(EM_PC8),
			.in5(XAO),
			.op(ForwardRSD),
			.out(rs_D));
mux3op MFRTD(.in0(rd2_D),
			.in1(AO),
			.in2(M4),
			.in3(DE_PC8),
			.in4(EM_PC8),
			.in5(XAO),
			.op(ForwardRTD),
			.out(rt_D));
//phase W

wire [31:0] DM_EXT_out;
wire [2:0] DM_EXTop;
mux2op MUX_GPRwa(.in0(IR_W_in[`rt]),
			.in1(IR_W_in[`rd]),
			.in2(31),
			.in3(0),
			.op(RF_WAsel),
			.out(W_wa));
mux3op MUX_GPRwd(.in0(ALUout_W_in),//mux4
			.in1(DM_EXT_out),
			.in2(PC8_W_in),
			.in3(XALUout_W_in),
			.in4(CP0out_W_in),
			.op(RF_WDsel),
			.out(W_wd)); 
dm_ext DM_EXT(
			.A(DM_A_W_in[1:0]),
			.op(DM_EXTop),
			.din(DM_W_in),
			.dout(DM_EXT_out)
			);
ctrl ctrl_W(.instr(IR_W_in),
			.RF_WDsel(RF_WDsel),
			.RF_WAsel(RF_WAsel),
			.RegWrite(RegWrite),
			.DM_EXTop(DM_EXTop),
			.Ins_jal(MW_jal),
			.Ins_jr(MW_jr),
			.Ins_cal_r(MW_cal_r),
			.Ins_cal_i(MW_cal_i),
			.Ins_l(MW_l),
			.Ins_movfm(MW_movfm),
			.Ins_mfc0(MW_mfc0)
			);

endmodule
