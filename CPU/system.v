`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:47:25 12/17/2015 
// Design Name: 
// Module Name:    system 
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
module system(
		input clk,
		input reset	
    );
wire [31:0]addr_cpu;
wire [3:2]addr_timer1,addr_timer0;
wire [31:0]din_cpu,dout_timer1,dout_timer0;
wire we_cpu,we_timer1,we_timer0;
wire [5:0]intq_cpu;
wire intq_timer1,intq_timer0;
mips cpu(
		.clk(clk),
		.reset(reset),
		.addr_cpu(addr_cpu),
		.din_cpu(din_cpu),
		.we_cpu(we_cpu),
		.intq(intq_cpu)
	);
bridge bridge(
		.addr_cpu(addr_cpu),
		.din_cpu(din_cpu),
		.we_cpu(we_cpu),
		.intq_cpu(intq_cpu),
		.addr_timer1(addr_timer1),
		.we_timer1(we_timer1),
		.dout_timer1(dout_timer1),
		.intq_timer1(intq_timer1),
		.addr_timer0(addr_timer0),
		.we_timer0(we_timer0),
		.dout_timer0(dout_timer0),
		.intq_timer0(intq_timer0)
	);
timer timer1(
		.clk(clk),
		.rst(reset),
		.addr(addr_timer1),
		.we(we_timer1),
		.din(dout_timer1),
		.intq(intq_timer1)
	);
timer timer0(
		.clk(clk),
		.rst(reset),
		.addr(addr_timer0),
		.we(we_timer0),
		.din(dout_timer0),
		.intq(intq_timer0)
	);

endmodule
