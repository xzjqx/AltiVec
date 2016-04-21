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
// synthesizable models for PEPs specific books
// to make models portable

//`include "/vendors/btv/cmos6sf/synopsys/peps_dw/gatemap_func.v"
// 1 Port Register, Enable E1 Unsed E2,  L2 Output
module p405s_PDP_P1EUL2 (CB,D,E1,I,L2,SO);
 parameter N=10,ScanDir=0,LBHC=1,CSBHC=1,ClkSep=0,FAST=0;
  output [0:N-1] L2;
  output SO;
  input  [0:N-1] D;
  input  CB;
  input  E1,I;

 reg [0:N-1] L2;

 wire SO = 1'bx;
 integer    i;

//L2 Output modeled as posedge FF.
 always @(posedge CB)
  begin
  casez(E1)  //case for feedback mux instead of clk gating
   1'b0: L2 <= L2;
   1'b1: L2 <= D;
    default:    for(i=0; i<N; i=i+1)
                L2[i]<= 1'bx;
    endcase
  end

endmodule
