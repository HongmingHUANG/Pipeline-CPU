`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:37 12/08/2015 
// Design Name: 
// Module Name:    xalu 
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
module xalu(
		input [31:0]D1,D2,
		input [1:0]op,
		input hilo,start,we,clk,rst,
		output [31:0]HI,LO,
		output reg busy,
		input interupt,
		input clear_xalu
    );
reg [63:0]temp;
reg [31:0]counter,HIreg,LOreg,temp2,HIreg2,LOreg2;
always @(posedge rst)
begin
	HIreg<=0;
	HIreg2<=0;
	LOreg<=0;
	LOreg2<=0;
	busy<=0;
end
always @(posedge clk)
begin
	if(!rst && !we && !interupt)
	begin
		if(start)
		begin
			busy<=1;
			HIreg2=HIreg;
			LOreg2=LOreg;
			counter<=(op[1]==0)?3:8;
			case(op)
				2'b00:begin
					temp=D1*D2;//multu
					HIreg<=temp[63:32]; 
					LOreg<=temp[31:0];
				end
				2'b01:begin
					temp=$signed(D1)*$signed(D2);//mult
					HIreg<=temp[63:32];
					LOreg<=temp[31:0];
				end
				2'b10:begin
					temp=D1/D2;//divu
					temp2=D1%D2;
					HIreg<=temp2;
					LOreg<=temp[31:0];
				end
				2'b11:begin
					temp=$signed($signed(D1)/$signed(D2));//div
					temp2=$signed($signed(D1)%$signed(D2));
					HIreg<=temp2;
					LOreg<=temp[31:0];
				end
			endcase
		end
		else
		begin
			if(counter==0)
			begin
				busy<=0;
			end
			else
			begin
				counter<=counter-1;
			end
		end
	end
	if(!rst && we && !interupt)
	begin
		if(hilo==1)
		begin
			HIreg2=HIreg;
			HIreg<=D1;
		end
		else
		begin
			LOreg2=LOreg;
			LOreg<=D1;
		end
	end
	if(clear_xalu)
	begin
		HIreg<=HIreg2;
		LOreg<=LOreg2;
	end
end

assign HI=HIreg;
assign LO=LOreg;

endmodule
