`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:38:51 12/08/2015
// Design Name:   cmp
// Module Name:   F:/Xilinx/work/P5/try.v
// Project Name:  P5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cmp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module try;

	// Inputs
	reg [31:0] D1;
	reg [31:0] D2;
	reg [2:0] op;

	// Outputs
	wire out;
	reg [63:0] temp;
	// Instantiate the Unit Under Test (UUT)


	initial begin
		// Initialize Inputs
		D1 = 10;
		D2 = -5;
		op = 0;
		temp = $signed($signed(D1)/$signed(D2));
		// Wait 100 ns for global reset to finish
		#100; op=0;
        
		// Add stimulus here

	end
      
endmodule

