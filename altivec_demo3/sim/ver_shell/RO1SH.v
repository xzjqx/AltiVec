// ========================================================================================================================
// File name            : RO1SH.v
// File Revision        : 2.0
// Author               : wangjie
// Date                 : 2014.3.5
// Email                : ycyquick@foxmail.com
// History              : 2013.10.31 v1.0 cuiluping
// -----------------------------------------------------------------------------------------------------------------------
// Description :       model single port ROM
// ------------------------------------------------------------------------------------------------------------------------
// Copyright (c) 2013,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// =========================================================================================================================
module  RO1SH(
              cs,
              addr,
              dout_eve,
              dout_odd
              );
//---------------------------------------
//Parameter declaration
//----------------------------------------
parameter     WIDTH  = 32,
              AWIDTH  = 30,
              DEPTH  = 2048;
//---------------------------------------
//I/O declaration
//----------------------------------------        
input         cs;
input         [AWIDTH-1:0]  addr;
output        [WIDTH-1:0]   dout_eve;
output        [WIDTH-1:0]   dout_odd;

//register declaration
reg           [WIDTH-1:0]    mem[0:DEPTH-1];
reg           [WIDTH-1:0]    dout_eve;
reg           [WIDTH-1:0]    dout_odd;

always @( * )
begin
  if(cs)//mem select 
  begin
    dout_eve  = mem[addr];
    dout_odd  = mem[addr + 1];
  end
  else
  begin  
    dout_eve  = 32'h??;
    dout_odd  = 32'h??;
  end
end  
endmodule

  