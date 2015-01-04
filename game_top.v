/* @brief  Top module
 * @input  
 * @output
 * @remark  
 */
module game_top(
	/*Clock Input*/ 
	iCLK_50,						//  28.63636 MHz
	/*Push Buttons*/
	PS2_DAT,
	PS2_CLK,//	Pushbutton[3:0]
	/*DPDT Switches*/
	iSW,							//	Toggle Switch[17:0]
	/*VGA*/
	oVGA_CLOCK,   					//	VGA Clock
	oVGA_HS,						//	VGA H_SYNC
	oVGA_VS,						//	VGA V_SYNC
	oVGA_BLANK_N,					//	VGA BLANK
	oVGA_SYNC_N,					//	VGA SYNC
	oVGA_R,   						//	VGA Red[9:0]
	oVGA_G,	 						//	VGA Green[9:0]
	oVGA_B  						//	VGA Blue[9:0]	   
);

/*******************************************************************************
 * PARAMETER declarations
 *******************************************************************************
 */

/* PORT declarations
 */
/*Clock Input*/
input			iCLK_50;				//  28.63636 MHz
/*Keyboard Input*/
input 		PS2_DAT;
input			PS2_CLK;
/*DPDT Switches*/
input			iSW;					//	Toggle Switch[17:0]
/*VGA*/
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;				//	VGA H_SYNC
output			oVGA_VS;				//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[ 9: 0]	oVGA_R;   				//	VGA Red[9:0]
output	[ 9: 0]	oVGA_G;	 				//	VGA Green[9:0]
output	[ 9: 0]	oVGA_B;   				//	VGA Blue[9:0]
/******************************************************************************/

/* REG/WIRE declarations
 */
reg  				CLK_25;
wire           reset_pin;
wire 	[7:0]		iKEY;	
assign reset_pin = ~iSW;

assign oVGA_BLANK_N	= oVGA_HS & oVGA_VS;
assign oVGA_SYNC_N	= 1'b0;
assign oVGA_CLOCK   = CLK_25;
assign oVGA_R[8: 0] = {9 {oVGA_R[9]}};
assign oVGA_G[8: 0] = {9 {oVGA_G[9]}};
assign oVGA_B[8: 0] = {9 {oVGA_B[9]}};

//Background video rom
wire [ 8: 0] oAddr_bkg;
wire [ 2: 0] iDin_bkg_mux;
wire [ 2: 0] iDin_bkg1;
wire [ 2: 0] iDin_bkg2;
wire [ 2: 0] iDin_bkg3;
wire [ 1: 0] bkg_sel;
//Object video ram
wire [ 2: 0] oAddr_obj;
wire [12: 0] iDin_obj;
//Background tile table
wire [12: 0] oAddr_tile1;
wire [ 2: 0] iDin_tile1;
//Object tile table
wire [12: 0] oAddr_tile2;
wire [ 2: 0] iDin_tile2;
//Object video ram - write side
wire [ 2: 0] objram_addr;
wire [12: 0] objram_data;
wire         objram_we;

always @(posedge iCLK_50) begin
	CLK_25 <= ~CLK_25;
end
	
//Game controller
game_controller mGame_controller(
	//Clock and reset
	.clk(CLK_25),
	.reset_n(reset_pin),
	//Frame synchronization input
	.iVS(oVGA_VS),
	//Keyboard input
	.iKEY(iKEY),
	//Background selection
	.oBkg_sel(bkg_sel),
	//Object ram interface
	.oObjRam_addr(objram_addr),
	.oObjRam_data(objram_data),
	.oObjRam_we(objram_we)
);

 PS2DATA P1(		
		//Clock and reset
		.CLK(CLK_25),
		.RSTn(reset_pin),
		//PS2 interface
		.PS2_DAT(PS2_DAT),
		.PS2_CLK(PS2_CLK),
		//The key used 
		.LEFT(iKEY[1]),
		.RIGHT(iKEY[0]),
		.UP(iKEY[3]),
		.DOWN(iKEY[2]),
		.LEFT2(iKEY[5]),
		.RIGHT2(iKEY[4]),
		.UP2(iKEY[7]),
		.DOWN2(iKEY[6])
		);
//Display driver
display_driver mDisplay_driver(
	//Clock and reset
	.clk(CLK_25),
	.reset_n(reset_pin),
	//Video output
	.oHS(oVGA_HS),
	.oVS(oVGA_VS),
	.oRGB({oVGA_R[9], oVGA_G[9], oVGA_B[9]}),
	//Background video ram
	.oAddr_bkg(oAddr_bkg),
	.iDin_bkg(iDin_bkg_mux),
	//Object video ram
	.oAddr_obj(oAddr_obj),
	.iDin_obj(iDin_obj),
	//Background tile table
	.oAddr_tile1(oAddr_tile1),
	.iDin_tile1(iDin_tile1),
	//Object tile table
	.oAddr_tile2(oAddr_tile2),
	.iDin_tile2(iDin_tile2)
);

//Object video ram
obj_ram mOBJ_RAM(
	.clk(CLK_25),
	//Write side
	.wr_addr(objram_addr),
	.data(objram_data),
	.we(objram_we),
	//Read side
	.rd_addr(oAddr_obj),
	.q(iDin_obj)
);

//Background multiplexing
assign iDin_bkg_mux = (bkg_sel == 0) ? iDin_bkg1 : 
                      (bkg_sel == 1) ? iDin_bkg2 :
                      (bkg_sel == 2) ? iDin_bkg3 : 3'b000;

//Background video rom 1 - PALY STATE
bkg_rom1 mBKG_ROM1(
	.addr(oAddr_bkg),
	.q(iDin_bkg1)
);

//Background video rom 2 - "WIN"
bkg_rom2 mBKG_ROM2(
	.addr(oAddr_bkg),
	.q(iDin_bkg2)
);

//Background video rom 3 - "GAME OVER"
bkg_rom3 mBKG_ROM3(
	.addr(oAddr_bkg),
	.q(iDin_bkg3)
);

//Background tile table
bkg_tile_table mTile_Table1(
	.addr(oAddr_tile1),
	.q(iDin_tile1)
);

//Object tile table
obj_tile_table mTile_Table2(
	.addr(oAddr_tile2),
	.q(iDin_tile2)
);

endmodule

//End of file
