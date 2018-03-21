`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:20 12/07/2015 
// Design Name: 
// Module Name:    dm_ext 
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
module dm_ext(
			input [1:0]A,
			input [2:0]op,
			input [31:0]din,
			output [31:0]dout
    );
reg [31:0] temp;
always @(*)
begin
	case(op)
		3'b000:temp=din;
		3'b001://ÓÐ·ûºÅ×Ö½ÚÀ©Õ¹
		begin
			case(A)
				2'b00:temp={{24{din[7]}},din[7:0]};
				2'b01:temp={{24{din[15]}},din[15:8]};
				2'b10:temp={{24{din[23]}},din[23:16]};
				2'b11:temp={{24{din[31]}},din[31:24]};
			endcase
		end
		3'b010://ÎÞ·ûºÅ×Ö½ÚÀ©Õ¹
		begin
			case(A)
				2'b00:temp={24'h000000,din[7:0]};
				2'b01:temp={24'h000000,din[15:8]};
				2'b10:temp={24'h000000,din[23:16]};
				2'b11:temp={24'h000000,din[31:24]};
			endcase
		end
		3'b011://ÓÐ·ûºÅ°ë×ÖÀ©Õ¹
		begin
			temp=(A[1]==0)?{{16{din[15]}},din[15:0]}:{{16{din[31]}},din[31:16]};
		end
		3'b100://ÎÞ·ûºÅ°ë×ÖÀ©Õ¹
		begin
			temp=(A[1]==0)?{16'h0000,din[15:0]}:{16'h0000,din[31:16]};
		end
	endcase
end
assign dout=temp;
endmodule
