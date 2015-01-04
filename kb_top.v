`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:35:07 12/29/2011 
// Design Name: 
// Module Name:    kb_top 
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
module kb_top(
	input wire clk, reset,
	input wire ps2d,ps2c,
	output wire [7:0] ascii_code,
	output wire kb_not_empty
    );
	 
	// signal declaration
	wire [7:0] key_code;
	wire kb_buf_empty;
	
	//body
	assign kb_not_empty = ~kb_buf_empty;
	
	// instantiate kb code
	kb_code #(.W_SIZE(2)) kb_code_unit
		(.clk(clk), .reset(reset),
		 .ps2d(ps2d), .ps2c(ps2c),
		 .rd_key_code(kb_not_empty),
		 .key_code(key_code),
		 .kb_buf_empty(kb_buf_empty)
		);
	
	// instantiate key-to-ascii 
	key2ascii key2ascii_unit
		(.key_code(key_code),
		 .ascii_code(ascii_code)
		);
	 


endmodule
