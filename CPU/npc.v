`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:35 11/18/2015 
// Design Name: 
// Module Name:    npc 
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
module npc(
    input [31:0]instr,
    input [1:0]op,      //00:normal 01:beq 10:jal,j
    input [31:0]pc4,
    input beq1,//g[rs]=g[rt];
    output [31:0]out
    );
wire [31:0]beqtar,beqoffset;
wire [31:0]jtar;

ext16 beqoffsetext(.din(instr[15:0]),.dout(beqoffset),.op(1));
assign beqtar=(beq1==1)?pc4+(beqoffset<<2):pc4+4;

assign jtar=instr[25:0]<<2;

mux2op npcoutmux(.in0(pc4),.in1(beqtar),.in2(jtar),.in3(0),.op(op),.out(out));

endmodule
