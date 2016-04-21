// 
// ************************************************************************** 
// 
//  Copyright (c) International Business Machines Corporation, 2005. 
// 
//  This file contains trade secrets and other proprietary and confidential 
//  information of International Business Machines Corporation which are 
//  protected by copyright and other intellectual property rights and shall 
//  not be reproduced, transferred to other documents, disclosed to others, 
//  or used for any purpose except as specifically authorized in writing by 
//  International Business Machines Corporation. This notice must be 
//  contained as part of this text at all times. 
// 
// ************************************************************************** 
//
module p405s_srmMskDcd (mskBegin, mskEndHi, mskEndLo, forceZeroDcd, mbField, meField, shiftLt, shiftAmtMsb, shiftRt);
    output [0:31] mskBegin;
    output [0:14] mskEndHi;
    output [16:30] mskEndLo;
    output forceZeroDcd;
    input [0:4] mbField;
    input [0:4] meField;
    input shiftLt;
    input shiftAmtMsb;
    input shiftRt;

reg forceZeroDcd_i;
wire forceZeroDcd;
reg [0:31] mskBegin;
reg [0:14] mskEndHi;
reg [16:30] mskEndLo;
assign forceZeroDcd = forceZeroDcd_i;
always @(mbField or meField or shiftLt or shiftAmtMsb or shiftRt)
begin
   forceZeroDcd_i = (shiftLt | shiftRt) & shiftAmtMsb;
   casez({forceZeroDcd_i,mbField}) // synopsys parallel_case full_case
      6'h00 : mskBegin = 32'h80000000;
      6'h01 : mskBegin = 32'h40000000;
      6'h02 : mskBegin = 32'h20000000;
      6'h03 : mskBegin = 32'h10000000;
      6'h04 : mskBegin = 32'h08000000;
      6'h05 : mskBegin = 32'h04000000;
      6'h06 : mskBegin = 32'h02000000;
      6'h07 : mskBegin = 32'h01000000;
      6'h08 : mskBegin = 32'h00800000;
      6'h09 : mskBegin = 32'h00400000;
      6'h0a : mskBegin = 32'h00200000;
      6'h0b : mskBegin = 32'h00100000;
      6'h0c : mskBegin = 32'h00080000;
      6'h0d : mskBegin = 32'h00040000;
      6'h0e : mskBegin = 32'h00020000;
      6'h0f : mskBegin = 32'h00010000;
      6'h10 : mskBegin = 32'h00008000;
      6'h11 : mskBegin = 32'h00004000;
      6'h12 : mskBegin = 32'h00002000;
      6'h13 : mskBegin = 32'h00001000;
      6'h14 : mskBegin = 32'h00000800;
      6'h15 : mskBegin = 32'h00000400;
      6'h16 : mskBegin = 32'h00000200;
      6'h17 : mskBegin = 32'h00000100;
      6'h18 : mskBegin = 32'h00000080;
      6'h19 : mskBegin = 32'h00000040;
      6'h1a : mskBegin = 32'h00000020;
      6'h1b : mskBegin = 32'h00000010;
      6'h1c : mskBegin = 32'h00000008;
      6'h1d : mskBegin = 32'h00000004;
      6'h1e : mskBegin = 32'h00000002;
      6'h1f : mskBegin = 32'h00000001;
      6'b1????? :  mskBegin = 32'h00000000;
// x catcher.
      default : mskBegin = 32'hxxxxxxxx;
   endcase
   casez({forceZeroDcd_i,meField}) // synopsys parallel_case full_case
      6'h00 : mskEndHi = 15'b100000000000000;
      6'h01 : mskEndHi = 15'b010000000000000;
      6'h02 : mskEndHi = 15'b001000000000000;
      6'h03 : mskEndHi = 15'b000100000000000;
      6'h04 : mskEndHi = 15'b000010000000000;
      6'h05 : mskEndHi = 15'b000001000000000;
      6'h06 : mskEndHi = 15'b000000100000000;
      6'h07 : mskEndHi = 15'b000000010000000;
      6'h08 : mskEndHi = 15'b000000001000000;
      6'h09 : mskEndHi = 15'b000000000100000;
      6'h0a : mskEndHi = 15'b000000000010000;
      6'h0b : mskEndHi = 15'b000000000001000;
      6'h0c : mskEndHi = 15'b000000000000100;
      6'h0d : mskEndHi = 15'b000000000000010;
      6'h0e : mskEndHi = 15'b000000000000001;
      6'h0f : mskEndHi = 15'b000000000000000;
      6'b01???? : mskEndHi = 15'b000000000000000;
      6'b1????? : mskEndHi = 15'b000000000000000;
// x catcher.
      default mskEndHi = 15'bxxxxxxxxxxxxxxx;
   endcase
   casez({forceZeroDcd_i,meField}) // synopsys parallel_case full_case
      6'b00???? : mskEndLo = 15'b000000000000000;
      6'h10 : mskEndLo = 15'b100000000000000;
      6'h11 : mskEndLo = 15'b010000000000000;
      6'h12 : mskEndLo = 15'b001000000000000;
      6'h13 : mskEndLo = 15'b000100000000000;
      6'h14 : mskEndLo = 15'b000010000000000;
      6'h15 : mskEndLo = 15'b000001000000000;
      6'h16 : mskEndLo = 15'b000000100000000;
      6'h17 : mskEndLo = 15'b000000010000000;
      6'h18 : mskEndLo = 15'b000000001000000;
      6'h19 : mskEndLo = 15'b000000000100000;
      6'h1a : mskEndLo = 15'b000000000010000;
      6'h1b : mskEndLo = 15'b000000000001000;
      6'h1c : mskEndLo = 15'b000000000000100;
      6'h1d : mskEndLo = 15'b000000000000010;
      6'h1e : mskEndLo = 15'b000000000000001;
      6'h1f : mskEndLo = 15'b000000000000000;
      6'b1????? : mskEndLo = 15'b000000000000000;
// x catcher.
      default mskEndLo = 15'bxxxxxxxxxxxxxxx;
   endcase
end

endmodule
