`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:01:29 11/18/2015 
// Design Name: 
// Module Name:    im_4k 
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
module im_4k(
    input [31:0]addr,
    output [31:0]dout
    );
reg [31:0]im[2047:0];
integer i;
wire [31:0] temp;
initial 
begin
	for(i=0;i<=2047;i=i+1)
		im[i]=0;
	$readmemh("code.txt",im);
	$readmemh("handle.txt",im,12'b0001_0001_1000_01);	
end
assign temp=addr-32'h00003000;



assign dout=im[temp[12:2]];
endmodule
