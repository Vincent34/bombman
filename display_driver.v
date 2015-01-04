/* @brief
 * @input  
 * @output
 * @remark  
 */
module display_driver(
	//Clock and reset
	clk,
	reset_n,
	//Video output
	oHS,
	oVS,
	oRGB,
	//Background video ram
	oAddr_bkg,
	iDin_bkg,
	//Object video ram
	oAddr_obj,
	iDin_obj,
	//Background tile table
	oAddr_tile1,
	iDin_tile1,
	//Object tile table
	oAddr_tile2,
	iDin_tile2
);
/* PORT declarations
 */
//Clock and reset
input          clk;
input          reset_n;
//Video output
output         oHS;
output         oVS;
output [ 2: 0] oRGB;
//Background video ram
output [ 8: 0] oAddr_bkg;
input  [ 2: 0] iDin_bkg;
//Object video ram
output [ 2: 0] oAddr_obj;
input  [12: 0] iDin_obj;
//Background tile table
output [12: 0] oAddr_tile1;
input  [ 2: 0] iDin_tile1;
//Object tile table
output [12: 0] oAddr_tile2;
input  [ 2: 0] iDin_tile2;

/* Organization of 3-bit background data
 * 2 .. 0 |
 * TILE NO.
 */

/* Organization of 13-bit object data: 
 * 12     | 11 .. 9 | 8 .. 4 | 3 .. 0 |
 * ON/OFF   TILE NO.  X COOR   Y COOR
 */

/* Parameters definition
 */
//VGA timing (640 * 480)
`define VGA_H_TOTAL      800 //pixels
`define VGA_H_SYNC       96
`define VGA_H_BP         48  //112
`define VGA_H_FP         16  //80
`define VGA_H_ACT        640

`define VGA_V_TOTAL      525 //lines
`define VGA_V_SYNC       2
`define VGA_V_BP         33
`define VGA_V_FP         10
`define VGA_V_ACT        480

/* REG/WIRE declarations
 */
wire [ 9: 0] hCnt;
wire [ 9: 0] vCnt;

wire [ 9: 0] xCoor_2f;
wire [ 9: 0] xCoor_16f;
wire [ 8: 0] yCoor;

reg  [ 2: 0] oRGB;
reg  [ 8: 0] oAddr_bkg;
reg  [ 2: 0] oAddr_obj;
reg  [12: 0] oAddr_tile1;
reg  [12: 0] oAddr_tile2;

reg  [ 2: 0] bkgTile;        //Current background tile
reg  [ 2: 0] objTile;        //Current object tile
reg          objEnable;      //ON/OFF bit of current object
reg  [ 2: 0] nextBkgTile;    //Next background tile
reg  [ 2: 0] nextObjTile;    //Next object tile
reg          nextObjEnable;  //ON/OFF bit of next object

reg  [ 2: 0] bkgRGB;          //RGB of next background pixel
reg  [ 2: 0] objRGB;          //RGB of next object pixel

assign xCoor_2f  = hCnt - `VGA_H_SYNC - `VGA_H_BP + 2;
assign xCoor_16f = hCnt - `VGA_H_SYNC - `VGA_H_BP + 16;
assign yCoor     = vCnt - `VGA_V_SYNC - `VGA_V_BP;

/* Sub modules
 */
vga_timing mVGA_timing(
	//Clock and reset
	.clk(clk),
	.reset_n(reset_n),
	//VGA timing output
	.HS(oHS),
	.VS(oVS),
	.HCnt(hCnt),
	.VCnt(vCnt)
);

/* LOGIC Descriptions
 */
//Background fetching
always @(posedge clk) begin	
	if(xCoor_16f[4: 0] == 5'd0) oAddr_bkg <= xCoor_16f[9: 5] + 9'd20 * yCoor[8: 5];
	else if(xCoor_16f[4: 0] == 5'd1) nextBkgTile <= iDin_bkg;
end

//Object fetching
always @(posedge clk) begin
	if(xCoor_16f[4: 0] == 5'd0) begin
		oAddr_obj     <= 3'd7;
		nextObjEnable <= 1'b0;
	end
	else if(xCoor_16f[4: 0] <= 5'd8) begin
		oAddr_obj <= oAddr_obj - 1;
		if(iDin_obj[12] && 
		   (iDin_obj[8: 4] == xCoor_16f[9: 5]) && 
		   (iDin_obj[3: 0] == yCoor[8: 5])) begin
			nextObjTile   <= iDin_obj[11: 9];
			nextObjEnable <= 1'b1;
		end
	end
end

//Background tile table fetching
always @(posedge clk) begin
	if(xCoor_2f[4: 0] == 5'd0) bkgTile = nextBkgTile;
	oAddr_tile1 <= {bkgTile, 10'd0} + {yCoor[4: 0], 5'd0} + xCoor_2f[4: 0];
	bkgRGB <= iDin_tile1;
end

//Object tile table fetching
always @(posedge clk) begin
	if(xCoor_2f[4: 0] == 5'd0) begin
		objTile = nextObjTile;
		objEnable <= nextObjEnable;
	end
	oAddr_tile2 <= {objTile, 10'd0} + {yCoor[4: 0], 5'd0} + xCoor_2f[4: 0];
	if(objEnable) objRGB <= iDin_tile2;
	else objRGB <= 0;
end

//Picture renderring
always @(posedge clk) begin
	if((hCnt >= `VGA_H_SYNC + `VGA_H_BP) && 
	   (hCnt <= `VGA_H_SYNC + `VGA_H_BP + `VGA_H_ACT - 1) &&
	   (vCnt >= `VGA_V_SYNC + `VGA_V_BP) &&
	   (vCnt <= `VGA_V_SYNC + `VGA_V_BP + `VGA_V_ACT - 1)) begin
		oRGB = objRGB; //Draw object layer first
		if(bkgRGB != 3'b000) oRGB = bkgRGB; //Draw background layer
	end
	else begin
		oRGB = 3'b000;
	end
end

endmodule //display_driver

