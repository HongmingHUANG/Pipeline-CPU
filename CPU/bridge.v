`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:16 12/16/2015 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
		input [31:0]addr_cpu,din_cpu,
		input we_cpu,
		output [5:0]intq_cpu,
		output [3:2]addr_timer1,addr_timer0,
		output we_timer1,we_timer0,
		output [31:0]dout_timer1,dout_timer0,
		input intq_timer1,intq_timer0
    );

assign we_timer0=(((addr_cpu==32'h00007f00)||(addr_cpu==32'h00007f04))&&(we_cpu))?1:0;
assign we_timer1=(((addr_cpu==32'h00007f10)||(addr_cpu==32'h00007f14))&&(we_cpu))?1:0;
assign addr_timer0=addr_cpu[3:2];
assign addr_timer1=addr_cpu[3:2];
assign dout_timer0=din_cpu;
assign dout_timer1=din_cpu;
assign intq_cpu={4'b0,intq_timer1,intq_timer0};
endmodule
