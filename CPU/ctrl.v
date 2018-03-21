`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:05 11/18/2015 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input [31:0]instr,
	 //D phase
    output EXTop,
    output [1:0]NPCop,
	 output [2:0]CMPop,
	 output [1:0]PC_sel,
	 output Ins_cal_r,
	 output Ins_cal_i,
    output Ins_l,
	 output Ins_beq,
	 output Ins_st,
	 output Ins_jr,
	 output Ins_jal,
	 output Ins_mtdv,
	 output Ins_movto,
	 output Ins_movfm,
	 output Ins_jump,
	 output Ins_mfc0,
	 output Ins_eret,
	 output Ins_mtc0,
	 //E phase
	 output ALU_asel,
	 output ALU_bsel,
    output [3:0]ALUop,

	 output XALUhilo,
	 output [1:0]XALUop,
	 output XALUstart,
	 output XALUwe,
	 output XALU_outsel,
	 //M phase
    output MemWrite,
	 output [3:0]BE_EXTop,

	 //W phase
	 output [2:0]RF_WDsel,
    output [1:0]RF_WAsel,
	 output [3:0]DM_EXTop,
    output RegWrite

    );
wire [5:0]op;
assign op=instr[31:26];
wire [5:0]func;
assign func=instr[5:0];

wire lw,lb,lbu,lh;
assign lw =(op==6'b100011)?1:0;
assign lb =(op==6'b100000)?1:0;
assign lbu=(op==6'b100100)?1:0;
assign lh =(op==6'b100001)?1:0;
assign lhu=(op==6'b100101)?1:0;

wire sw,sh,sb;
assign sw=(op==6'b101011)?1:0;
assign sh=(op==6'b101001)?1:0;
assign sb=(op==6'b101000)?1:0;

wire jr,jal,j,jalr;
assign j=(op==6'b000010)?1:0;
assign jr=((func==6'b001000)&&(op==0))?1:0;
assign jal=(op==6'b000011)?1:0;
assign jalr=((op==6'b000000)&&(func==6'b001001))?1:0;

wire add,addu,sub,subu,slt,sltu,sllv,srlv,srav,aand,aor,axor,anor;
assign add =((func==6'b100000)&&(op==0))?1:0;
assign addu=((func==6'b100001)&&(op==0))?1:0;
assign sub =((func==6'b100010)&&(op==0))?1:0;
assign subu=((func==6'b100011)&&(op==0))?1:0;
assign slt =((func==6'b101010)&&(op==0))?1:0;
assign sltu=((func==6'b101011)&&(op==0))?1:0;

assign sllv=((func==6'b000100)&&(op==0))?1:0;
assign srlv=((func==6'b000110)&&(op==0))?1:0;
assign srav=((func==6'b000111)&&(op==0))?1:0;
assign aand=((func==6'b100100)&&(op==0))?1:0;
assign aor =((func==6'b100101)&&(op==0))?1:0;
assign axor=((func==6'b100110)&&(op==0))?1:0;
assign anor=((func==6'b100111)&&(op==0))?1:0;

wire mult,multu,div,divu;
assign mult =((func==6'b011000)&&(op==0))?1:0;
assign multu=((func==6'b011001)&&(op==0))?1:0;
assign div  =((func==6'b011010)&&(op==0))?1:0;
assign divu =((func==6'b011011)&&(op==0))?1:0;

wire mfhi,mflo,mthi,mtlo;
assign mfhi =((func==6'b010000)&&(op==0))?1:0;
assign mthi =((func==6'b010001)&&(op==0))?1:0;
assign mflo =((func==6'b010010)&&(op==0))?1:0;
assign mtlo =((func==6'b010011)&&(op==0))?1:0;

wire andi,ori,lui,addi,addiu,xori,slti,sltiu,sll,srl,sra;
assign andi =(op==6'b001100)?1:0;
assign ori  =(op==6'b001101)?1:0;
assign lui  =(op==6'b001111)?1:0;
assign addi =(op==6'b001000)?1:0;
assign addiu=(op==6'b001001)?1:0;
assign xori =(op==6'b001110)?1:0;
assign slti =(op==6'b001010)?1:0;
assign sltiu=(op==6'b001011)?1:0;
assign sll =((func==6'b000000)&&(op==0)&&(instr!=0))?1:0;
assign srl =((func==6'b000010)&&(op==0))?1:0;
assign sra =((func==6'b000011)&&(op==0))?1:0;

wire beq,bne,blez,bgtz,bltz,bgez;
assign beq =(op==6'b000100)?1:0;
assign bne =(op==6'b000101)?1:0;
assign blez=(op==6'b000110)?1:0;
assign bgtz=(op==6'b000111)?1:0;
assign bltz=(op==6'b000001 && instr[20:16]==5'b00000)?1:0;
assign bgez=(op==6'b000001 && instr[20:16]==5'b00001)?1:0;

wire eret,mfc0,mtc0;
assign eret=(op==6'b010000 && func==6'b011000)?1:0;
assign mfc0=(op==6'b010000 && instr[25:21]==5'b00000)?1:0;
assign mtc0=(op==6'b010000 && instr[25:21]==5'b00100)?1:0;


assign PC_sel=(beq||bne||blez||bgtz||bltz||bgez||j||jal)?1:
					(jr||jalr)?2:0;
assign RF_WAsel=(jal)?2:
					(addu||subu||jalr||add||sub||slt||sltu||sll||srl||sra||sllv||srlv||srav||aand||aor||axor||anor||mfhi||mflo)?1:0;
assign ALU_asel=(sll||srl||sra)?1:0;
assign ALU_bsel=(andi||ori||lui||addi||addiu||xori||slti||sltiu||lw||lb||lbu||lh||lhu||sw||sh||sb)?1:0;
assign ALUop=(ori||aor )?4'b0000:
				(aand||andi)?4'b0001:
				(lw||lb||lbu||lh||lhu||sw||sh||sb||add||addi||addiu)?4'b0010:
				(sub )?4'b0011:
				(axor||xori)?4'b0100:
				(anor)?4'b0101:
				(addu)?4'b0110:
				(subu)?4'b0111:
				(slt ||slti)?4'b1000:
				(sltu||sltiu)?4'b1001:
				(sll ||sllv)?4'b1010:
				(srl ||srlv)?4'b1011:
				(sra ||srav)?4'b1100:
				(lui )?4'b1101:0;
assign CMPop=  (bne )?3'b001:
					(blez)?3'b010:
					(bgtz)?3'b011:
					(bltz)?3'b100:
					(bgez)?3'b101:
					0;
assign RF_WDsel=(jal||jalr)?3'b010:
						(lw||lb||lbu||lh||lhu)?3'b001:
						(mflo||mfhi)?3'b011:
						(mfc0)?3'b100:0;
assign RegWrite=(mfc0||add||addu||sub||subu||slt||sltu||sll||srl||sra||sllv||srlv||srav||aand||aor||axor||anor||addi||addiu||andi||ori||xori||lui||slti||sltiu||lw||lb||lbu||lh||lhu||jal||jalr||mfhi||mflo)?1:0;
assign MemWrite=(sw||sh||sb)?1:0;
assign NPCop=(jal||j)?2:
					(beq||bne||blez||bgtz||bltz||bgez)?1:0;
assign EXTop=(lw||lb||lbu||lh||lhu||sw||sh||sb)?1:0;
assign DM_EXTop=(lw)?0:
					( lb)?3'b001:
					(lbu)?3'b010:
					( lh)?3'b011:
					(lhu)?3'b100:0;
assign BE_EXTop=(sw)?0:
					(sh)?1:
					(sb)?2:0;
assign XALUop= (multu)?0:
					(mult )?1:
					(divu )?2:
					(div  )?3:0;
assign XALUstart=(multu||mult||divu||div)?1:0;
assign XALUwe=(mthi||mtlo)?1:0;
assign XALUhilo=(mthi)?1:0;
assign XALU_outsel=(mfhi)?1:0;

assign Ins_cal_r=(add||addu||sub||subu||slt||sltu||sllv||srlv||srav||aand||aor||axor||anor||sll||srl||sra)?1:0;
assign Ins_cal_i=(andi||ori||addi||addiu||xori||lui||slti||sltiu)?1:0;
assign Ins_l=(lw||lb||lbu||lh||lhu)?1:0;
assign Ins_st=(sw||sh||sb)?1:0;
assign Ins_beq=(beq||bne||blez||bgtz||bltz||bgez)?1:0;
assign Ins_jal=(jal||jalr)?1:0;
assign Ins_jr=(jr||jalr)?1:0;
assign Ins_mtdv=(mult||multu||div||divu)?1:0;
assign Ins_movto=(mthi||mtlo)?1:0;
assign Ins_movfm=(mfhi||mflo)?1:0;
assign Ins_jump=(Ins_beq||Ins_jal||Ins_jr||j)?1:0;
assign Ins_mfc0=(mfc0)?1:0;
assign Ins_eret=(eret)?1:0;
assign Ins_mtc0=(mtc0)?1:0;
endmodule

