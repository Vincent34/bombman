`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:14 01/04/2012 
// Design Name: 
// Module Name:    PS2DATA 
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
module PS2DATA(		
		CLK,
		RSTn,
	
		PS2_DAT,
		PS2_CLK,
		
		LEFT,
		RIGHT,
		UP,
		DOWN,
		
		LEFT2,
		RIGHT2,
		UP2,
		DOWN2
    );
input wire CLK;
input wire RSTn;

input wire PS2_DAT;
input wire PS2_CLK;

output reg LEFT,RIGHT,UP,DOWN,LEFT2,RIGHT2,UP2,DOWN2;

wire	[7: 0]	PS2_DATA;
wire		BUZZER_EN;
wire RST;

assign RST = ~RSTn;

kb_top m0(CLK, RST, PS2_DAT, PS2_CLK, PS2_DATA, BUZZER_EN);


/*always @(negedge RST)
	if(!RST)
	begin
		 LEFT = 1;
		 RIGHT = 1;
		 UP = 1;
		 DOWN = 1;
		 ENTER = 1;
	end*/
always @ (posedge CLK or negedge RSTn)
begin
 if(!RSTn)
	begin
		 LEFT = 1'b1;
		 RIGHT = 1'b1;
		 UP = 1'b1;
		 DOWN = 1'b1;
		 
		 LEFT2 = 1'b1;
		 RIGHT2 = 1'b1;
		 UP2 = 1'b1;
		 DOWN2 = 1'b1;
	end
 else
	begin
		if(PS2_DATA == 8'h41)
			LEFT = 0;
		else
			LEFT = 1;
		
		if(PS2_DATA == 8'h44)
			RIGHT = 0;
		else
			RIGHT = 1;
		
		if(PS2_DATA == 8'h57)
			UP = 0;
		else
			UP = 1;
		
		if(PS2_DATA == 8'h53)
			DOWN = 0;
		else
			DOWN = 1;
		
		if (PS2_DATA == 8'h4a)
			LEFT2 = 1;
		else
			LEFT2 = 0;
		
		if (PS2_DATA == 8'h4c)
			RIGHT2 = 1;
		else 
			RIGHT2 = 0;
			
		if (PS2_DATA == 8'h49)
			UP2 = 1;
		else 
			UP2 = 0;
			
		if (PS2_DATA == 8'h4b)
			DOWN2 = 1;
		else 
			DOWN2 = 0;
	end
end
endmodule
