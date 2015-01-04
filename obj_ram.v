module obj_ram(
	clk,
	//Write side
	wr_addr,
	data,
	we,
	//Read side
	rd_addr,
	q
);
input          clk;
//Write side
input  [ 2: 0] wr_addr;
input  [12: 0] data;
input          we;
//Read side
input  [ 2: 0] rd_addr;
output reg [12: 0] q;

//RAM
reg  [12: 0] ram [0: 7];

//Write logic
always @(negedge clk) if(we) ram[wr_addr] <= data;

//Read logic
always @(negedge clk) q <= ram[rd_addr];

endmodule

