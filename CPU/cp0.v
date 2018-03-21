`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:57:14 12/16/2015 
// Design Name: 
// Module Name:    cp0 
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
`define sr 12
`define cause 13
`define epc 14
`define prid 15
module cp0(
		input [4:0] wa,ra,
		input [31:0] din,M_PC4,instrM,instrW,
		input we,clk,rst,
		input [5:0] intq,
		input [6:2] ExcCode,
		output [31:0] EPCout,dout,
		output interupt,
		output clear_xalu,
		output int_end
    );
reg [2:0] mode;
reg [31:0] mem[20:0];
reg [31:0] EPC;
integer i;
wire M_mtdv,M_movto,M_eret,W_jump;
ctrl decodeM(
		.instr(instrM),
		.Ins_mtdv(M_mtdv),
		.Ins_movto(M_movto),
		.Ins_eret(M_eret)
	);
ctrl decodeW(
		.instr(instrW),
		.Ins_jump(W_jump)
	);
assign interupt=((intq>0)&&(mem[`sr][0])&&(!mem[`sr][1])&&((intq & mem[`sr][15:10])>0));
assign clear_xalu=(interupt && (M_mtdv || M_movto))?1:0;
assign EPCout=EPC;
assign int_end=(mode==3)?1:0;
initial
begin
	EPC=0;
	for(i=0;i<=20;i=i+1)
		mem[i]=0;
	mode=0;
	mem[`sr]=32'h0000ff11;
end
always @(posedge interupt)
begin
	if(mode==0)
		mode<=1;
end
always @(posedge M_eret)
begin
	if(mode==2)
		mode<=3;
end
always @(posedge clk)//×´Ì¬»ú×ª»»µÄÂß¼­£¨ÔÝÍ£¹¦ÄÜ£©
begin
	case(mode)
		3'b001:begin//interupt happen
			EPC<=(W_jump==1)?M_PC4-8:M_PC4-4;
			mem[`sr][1]<=1;
			mem[`cause][6:2]<=ExcCode;
			mem[`cause][15:10]<=intq;
			mode<=2;
		end

		3'b011:begin//interupt end
			
			mode<=4;
		end
		3'b100:begin//interupt buffer
			if(M_PC4<=32'h0000_4180)
			begin
				mem[`sr][1]<=0;
				mode<=0;
			end
		end
	endcase
end
assign dout=mem[ra];
always @(posedge clk)//¶ÁÐ´µÄÂß¼­£¨¼Ä´æÆ÷¹¦ÄÜ£©
begin
	if((we==1)&&(mode==0 || mode==2))
		mem[wa]<=din;
end
endmodule
