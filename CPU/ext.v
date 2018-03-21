`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:48 11/18/2015 
// Design Name: 
// Module Name:    EXT_16 
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
module ext16(
    input op,
    input [15:0]din,
    output [31:0]dout
    );
assign dout[15:0]=din[15:0];
assign dout[31:16]=op?{din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15],din[15]}:16'b0;

endmodule
