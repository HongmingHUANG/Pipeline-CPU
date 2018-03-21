`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:02 11/25/2015 
// Design Name: 
// Module Name:    Flevel 
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
module Fphase(
		input [31:0]NPC,RS_D,
		input Stall,
		output wire [31:0]IR_F_out,
		output wire [31:0]PC4_F_out,
		output wire [31:0]PC8_F_out,
		input clk,rst,
		input [1:0]PC_sel,
		input [31:0]EPC,
		input int_end,
		input interupt
    );
wire [31:0]PC_out,IR_F,muxout;
mux2op MUX_pc(.in0(PC_out+4),.in1(NPC),.in2(RS_D),.op(PC_sel),.out(muxout));
pc PC(
		.NPC(muxout),
		.clk(clk),
		.rst(rst),
		.en(~Stall),
		.out(PC_out),
		.EPC(EPC),
		.int_end(int_end),
		.interupt(interupt)
		);
im_4k IM(.addr(PC_out),.dout(IR_F));
assign PC4_F_out=PC_out+4;
assign IR_F_out=IR_F;
assign PC8_F_out=PC_out+8;
endmodule
