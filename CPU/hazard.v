`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:58:07 11/25/2015 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
		input [31:0]IR_D,
		input FD_cal_r,
		input FD_cal_i,
		input FD_l,
		input FD_beq,
		input FD_st,
		input FD_jal,
		input FD_jr,
		input FD_mtdv,
		input FD_movto,
		input FD_movfm,
		input [31:0]IR_E,
		input XALUbusy,
		input DE_cal_r,
		input DE_cal_i,
		input DE_l,
		input DE_st,
		input DE_jal,
		input DE_jr,
		input DE_mtdv,
		input DE_movto,
		input DE_movfm,
		input DE_mfc0,
		input DE_mtc0,
		input [31:0]IR_M,
		input EM_cal_r,
		input EM_cal_i,
		input EM_l,
		input EM_st,
		input EM_jal,
		input EM_jr,
		input EM_movfm,
		input EM_mfc0,
		input EM_mtc0,
		input [31:0]IR_W,
		input MW_cal_r,
		input MW_cal_i,
		input MW_l,
		input MW_jal,
		input MW_jr,
		input MW_movfm,
		input MW_mfc0,
		output stall,
		output [2:0]ForwardRSD,
		output [2:0]ForwardRTD,
		output [2:0]ForwardRSE,
		output [2:0]ForwardRTE,
		output [2:0]ForwardRTM
    );
wire stall_b,stall_cal_r,stall_cal_i,stall_l,stall_jr,stall_mtdv,stall_movfm,stall_movto;

assign stall_b=		(FD_beq && DE_cal_r && (IR_E[`rd]==IR_D[`rs] || IR_E[`rd]==IR_D[`rt]))?1:
					(FD_beq && DE_movfm && (IR_E[`rd]==IR_D[`rs] || IR_E[`rd]==IR_D[`rt]))?1:
					(FD_beq && DE_cal_i && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]))?1:
					(FD_beq && DE_l     && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]))?1:
					(FD_beq && DE_mfc0  && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]))?1:
					(FD_beq && EM_l     && (IR_M[`rt]==IR_D[`rs] || IR_M[`rt]==IR_D[`rt]))?1:
					(FD_beq && EM_mfc0  && (IR_M[`rt]==IR_D[`rs] || IR_M[`rt]==IR_D[`rt]))?1:
					0;
assign stall_jr=	(FD_jr && DE_cal_r && (IR_E[`rd]==IR_D[`rs]))?1:
					(FD_jr  && DE_movfm && (IR_E[`rd]==IR_D[`rs]))?1:
					(FD_jr  && DE_cal_i && (IR_E[`rt]==IR_D[`rs]))?1:
					(FD_jr  && DE_l     && (IR_E[`rt]==IR_D[`rs]))?1:
					(FD_jr  && DE_mfc0  && (IR_E[`rt]==IR_D[`rs]))?1:
					(FD_jr  && EM_l     && (IR_M[`rt]==IR_D[`rs]))?1:
					(FD_jr  && EM_mfc0  && (IR_M[`rt]==IR_D[`rs]))?1:
					0;
assign stall_cal_r=(FD_cal_r && DE_l    && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]))?1:
						 (FD_cal_r && DE_mfc0 && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]))?1:
					0;
assign stall_cal_i=(FD_cal_i && (DE_l || DE_mfc0) && IR_E[`rt]==IR_D[`rs])?1:0;
assign stall_l=(FD_l && (DE_l||DE_mfc0) && IR_E[`rt]==IR_D[`rs])?1:0;
assign stall_st=(FD_st && (DE_l||DE_mfc0) && IR_E[`rt]==IR_D[`rs])?1:0;


assign stall_mtdv=(XALUbusy||DE_mtdv)?1:
					(FD_mtdv  && (DE_l || DE_mfc0) && IR_E[`rt]==IR_D[`rs])?1:
					(FD_mtdv  && (DE_l || DE_mfc0) && IR_E[`rt]==IR_D[`rt])?1:0;
assign stall_movfm=(XALUbusy||DE_mtdv)?1:0;
assign stall_movto=(XALUbusy||DE_mtdv)?1:
					(FD_movto && (DE_l || DE_mfc0) && IR_E[`rt]==IR_D[`rs])?1:0;

assign stall=(stall_b || stall_cal_r || stall_cal_i || stall_l || stall_st || stall_jr || stall_mtdv || stall_movfm || stall_movto)?1:0;

wire tempRSD,tempRTD,tempRSE,tempRTE,tempRTM;
assign tempRSD=(FD_beq||FD_jr)?1:0; 
assign tempRTD=FD_beq?1:0; 
assign tempRSE=(DE_cal_r||DE_cal_i||DE_l||DE_st||DE_movto||DE_mtdv)?1:0;
assign tempRTE=(DE_cal_r||DE_st||DE_mtdv||DE_mtc0)?1:0;
assign tempRTM=(EM_st||EM_mtc0)?1:0;
assign ForwardRSD=		(tempRSD && DE_jal   && (       31==IR_D[`rs])                   && (~DE_jr))?3:
						(tempRSD && DE_jal   && (IR_E[`rd]==IR_D[`rs]) && (IR_D[`rs]!=0) && ( DE_jr))?3:
						(tempRSD && EM_cal_r && (IR_M[`rd]==IR_D[`rs]) && (IR_D[`rs]!=0))?1:
						(tempRSD && EM_cal_i && (IR_M[`rt]==IR_D[`rs]) && (IR_D[`rs]!=0))?1:
						(tempRSD && EM_jal   && (       31==IR_D[`rs])                   && (~EM_jr))?4:
						(tempRSD && EM_jal   && (IR_M[`rd]==IR_D[`rs]) && (IR_D[`rs]!=0) && ( EM_jr))?4:
						(tempRSD && EM_movfm && (IR_M[`rd]==IR_D[`rs]) && (IR_D[`rs]!=0))?5:
						0;
assign ForwardRTD=		(tempRTD && DE_jal   && (       31==IR_D[`rt])                   && (~DE_jr))?3:
						(tempRTD && DE_jal   && (IR_E[`rd]==IR_D[`rt]) && (IR_D[`rt]!=0) && ( DE_jr))?3:
						(tempRTD && EM_cal_r && (IR_M[`rd]==IR_D[`rt]) && (IR_D[`rt]!=0))?1:
						(tempRTD && EM_cal_i && (IR_M[`rt]==IR_D[`rt]) && (IR_D[`rt]!=0))?1:						
						(tempRTD && EM_jal   && (       31==IR_D[`rt])                   && (~EM_jr))?4:
						(tempRTD && EM_jal   && (IR_M[`rd]==IR_D[`rt]) && (IR_D[`rt]!=0) && ( EM_jr))?4:
						(tempRTD && EM_movfm && (IR_M[`rd]==IR_D[`rt]) && (IR_D[`rt]!=0))?5:
						0;
assign ForwardRSE=		((~tempRSE)||(IR_E[`rs]==0))?0:
						(DE_jal   && (       31==IR_E[`rs]) && (~DE_jr))?3:
						(DE_jal   && (IR_E[`rd]==IR_E[`rs]) && ( DE_jr))?3:
						(EM_cal_r && (IR_M[`rd]==IR_E[`rs]))?1:
						(EM_cal_i && (IR_M[`rt]==IR_E[`rs]))?1:
						(EM_jal   && (       31==IR_E[`rs]) && (~DE_jr))?4:
						(EM_jal   && (IR_M[`rd]==IR_E[`rs]) && ( DE_jr))?4:
						(EM_movfm && (IR_M[`rd]==IR_E[`rs]))?5:
						(MW_cal_r && (IR_W[`rd]==IR_E[`rs]))?2:
						(MW_cal_i && (IR_W[`rt]==IR_E[`rs]))?2:
						(MW_l     && (IR_W[`rt]==IR_E[`rs]))?2:
						(MW_mfc0  && (IR_W[`rt]==IR_E[`rs]))?2:
						(MW_jal   && (       31==IR_E[`rs]) && (~DE_jr))?2:
						(MW_jal   && (IR_W[`rd]==IR_E[`rs]) && ( DE_jr))?2:
						(MW_movfm && (IR_W[`rd]==IR_E[`rs]))?2:
						0;
assign ForwardRTE=((~tempRTE)||(IR_E[`rt]==0))?0:
						(DE_jal   && (       31==IR_E[`rt]) && (~DE_jr))?3:
						(DE_jal   && (IR_E[`rd]==IR_E[`rt]) && ( DE_jr))?3:
						(EM_cal_r && (IR_M[`rd]==IR_E[`rt]))?1:
						(EM_cal_i && (IR_M[`rt]==IR_E[`rt]))?1:
						(EM_jal   && (       31==IR_E[`rt]) && (~DE_jr))?4:
						(EM_jal   && (IR_M[`rd]==IR_E[`rt]) && ( DE_jr))?4:
						(EM_movfm && (IR_M[`rd]==IR_E[`rt]))?5:
						(MW_cal_r && (IR_W[`rd]==IR_E[`rt]))?2:
						(MW_cal_i && (IR_W[`rt]==IR_E[`rt]))?2:
						(MW_l     && (IR_W[`rt]==IR_E[`rt]))?2:
						(MW_mfc0  && (IR_W[`rt]==IR_E[`rt]))?2:
						(MW_jal   && (       31==IR_E[`rt]) && (~DE_jr))?2:
						(MW_jal   && (IR_W[`rd]==IR_E[`rt]) && ( DE_jr))?2:
						(MW_movfm && (IR_W[`rd]==IR_E[`rt]))?2:
						0;
assign ForwardRTM=((~tempRTM)||(IR_M[`rt]==0))?0:
						(MW_cal_r && (IR_W[`rd]==IR_M[`rt]))?2:
						(MW_cal_i && (IR_W[`rt]==IR_M[`rt]))?2:
						(MW_l     && (IR_W[`rt]==IR_M[`rt]))?2:
						(MW_mfc0  && (IR_W[`rt]==IR_M[`rt]))?2:
						(MW_jal   && (~MW_jr) && (31==IR_M[`rt]))?2:
						(MW_jal   && MW_jr && (IR_W[`rd]==IR_M[`rt]))?2:
						(MW_movfm && (IR_W[`rd]==IR_M[`rt]))?2:
						0;

endmodule
