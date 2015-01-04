/* @brief
 * @input  
 * @output
 * @remark  
 */
module vga_timing(
	//Clock and reset
	clk,
	reset_n,
	//VGA timing output
	HS,
	VS,
	HCnt,
	VCnt
);
/* PORT declarations
 */
//Clock and reset
input          clk;
input          reset_n;
//VGA timing output
output         HS;
output         VS;
output [ 9: 0] HCnt;
output [ 9: 0] VCnt;

/* Parameters definition
 */
//VGA timing (640 * 480)
`define VGA_H_TOTAL      800 //pixels
`define VGA_H_SYNC       96

`define VGA_V_TOTAL      525 //lines
`define VGA_V_SYNC       2

/* REG/WIRE declarations
 */
reg         HS;
reg         VS;
reg [ 9: 0] HCnt;
reg [ 9: 0] VCnt;

/* LOGIC Descriptions
 */
//Horizontal timing
always @(posedge clk or negedge reset_n)
	if(!reset_n) HCnt <= 0;
	else begin
		if(HCnt == `VGA_H_TOTAL - 1) HCnt <= 0;
		else HCnt <= HCnt + 1;
	end

always @(posedge clk or negedge reset_n)
	if(!reset_n) HS <= 1;
	else if(HCnt == 0) HS <= 0;
	else if(HCnt == `VGA_H_SYNC) HS <= 1;
	
//Vertical timing
always @(posedge clk or negedge reset_n)
	if(!reset_n) VCnt <= 0;
	else if(HCnt == `VGA_H_TOTAL - 1) begin
		if(VCnt == `VGA_V_TOTAL - 1) VCnt <= 0;
		else VCnt <= VCnt + 1;
	end
	
always @(posedge clk or negedge reset_n)
	if(!reset_n) VS <= 1;
	else if(HCnt == 0) begin
		if(VCnt == 0) VS <= 0;
		else if(VCnt == `VGA_V_SYNC) VS <= 1;
	end

endmodule //vga_timing
