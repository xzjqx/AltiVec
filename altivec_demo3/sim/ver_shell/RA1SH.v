// ========================================================================================================================
// File name            : RA1SH.v
// File Revision        : 1.0
// Author               : Cuiluping
// Date                 : 2013.10.31
// Email                : clp510@tju.edu.cn
// History              : none
// -----------------------------------------------------------------------------------------------------------------------
// Description :       model single port sram
// ------------------------------------------------------------------------------------------------------------------------
// Copyright (c) 2013,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// =========================================================================================================================
module	RA1SH	(
			//	clk,
				cs,
				rw,//1 -- read,0---write
				addr,
				din,
				dout
				);
//---------------------------------------
//Parameter declaration
//----------------------------------------
parameter 		WIDTH	= 32,
				AWIDTH	= 30,
				DEPTH	= 2048;
//---------------------------------------
//I/O declaration
//----------------------------------------				
//input					clk;
input					cs;
input					rw;
input	[AWIDTH-1:0]	addr;
input	[WIDTH-1:0]		din;
output	[WIDTH-1:0]		dout;


//register declaration
reg		[WIDTH-1:0]		mem[0:DEPTH-1];
reg		[WIDTH-1:0]		dout;

always @( * )
begin
	if(cs)//mem select and rw is high
	begin
		if(!rw)
		begin
			mem[addr]	= din;
		end
		else
		begin
			dout		=mem[addr];
		end
	end
	else
	begin	
		dout			= 'h??;
	end
end	
endmodule

	