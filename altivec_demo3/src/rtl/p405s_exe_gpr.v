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
// p405s_exe_gpr.v
// Arul initial version
// TRC 09/28/04 modified to remove input regs

module p405s_exe_gpr 
          (aPort, bPort, sPort, lPort, rPort, ApAddr, BpAddr,
           SpAddr, LpAddr, LpWE, RpAddr, RpWE, LpEqAp, LpEqBp, LpEqSp,
           RpEqAp, RpEqBp, RpEqSp, BpEqSp, SysClk, 
 	   EXE_gprRen, EXE_gprSysClkPI);
	   	   
    output [0:31] aPort;
    output [0:31] bPort;
    output [0:31] sPort;
       
    input [0:31] lPort;
    input [0:31] rPort;
    input [0:9] ApAddr;
    input [0:9] BpAddr;
    input [0:9] SpAddr;
    input [0:4] LpAddr;
    input LpWE;
    input [0:4] RpAddr;
    input RpWE;
    input LpEqAp;
    input LpEqBp;
    input LpEqSp;
    input RpEqAp;
    input RpEqBp;
    input RpEqSp;
    input BpEqSp;
    input SysClk;

	    
    input EXE_gprRen;	    
    input EXE_gprSysClkPI;      
          

 //  The GPRs
 //
 reg [0:31] gpr_reg_0;
 reg [0:31] gpr_reg_1;
 reg [0:31] gpr_reg_2;
 reg [0:31] gpr_reg_3;
 reg [0:31] gpr_reg_4;
 reg [0:31] gpr_reg_5;
 reg [0:31] gpr_reg_6;
 reg [0:31] gpr_reg_7;
 reg [0:31] gpr_reg_8;
 reg [0:31] gpr_reg_9;
 reg [0:31] gpr_reg_10;
 reg [0:31] gpr_reg_11;
 reg [0:31] gpr_reg_12;
 reg [0:31] gpr_reg_13;
 reg [0:31] gpr_reg_14;
 reg [0:31] gpr_reg_15;
 reg [0:31] gpr_reg_16;
 reg [0:31] gpr_reg_17;
 reg [0:31] gpr_reg_18;
 reg [0:31] gpr_reg_19;
 reg [0:31] gpr_reg_20;
 reg [0:31] gpr_reg_21;
 reg [0:31] gpr_reg_22;
 reg [0:31] gpr_reg_23;
 reg [0:31] gpr_reg_24;
 reg [0:31] gpr_reg_25;
 reg [0:31] gpr_reg_26;
 reg [0:31] gpr_reg_27;
 reg [0:31] gpr_reg_28;
 reg [0:31] gpr_reg_29;
 reg [0:31] gpr_reg_30;
 reg [0:31] gpr_reg_31;

 reg [0:31] aPort;
// reg [0:31] bPort;
 reg [0:31] sPort;
 reg [0:31] fromReg_aaddr;
 reg [0:31] fromReg_baddr;
 reg [0:31] fromReg_saddr;

 reg [0:31] bPort_int;

 reg [0:31] sport_data;

 wire sp_enable;

 reg [0:4] xlated_ApAddr;
 reg [0:4] xlated_BpAddr;
 reg [0:4] xlated_SpAddr;

 wire ApAddr_Eq_RpAddr;
 wire ApAddr_Eq_LpAddr;
 wire BpAddr_Eq_RpAddr;
 wire BpAddr_Eq_LpAddr;
 wire SpAddr_Eq_RpAddr;
 wire SpAddr_Eq_LpAddr;

//
// Write Task 
//
task gpr_wr ;
input [0:4] wr_addr;
input [0:31] wr_data;
begin

case(wr_addr)
   0 :  gpr_reg_0 <= wr_data [0:31] ;
   1 :  gpr_reg_1 <= wr_data [0:31] ;
   2 :  gpr_reg_2 <= wr_data [0:31] ;
   3 :  gpr_reg_3 <= wr_data [0:31] ;
   4 :  gpr_reg_4 <= wr_data [0:31] ;
   5 :  gpr_reg_5 <= wr_data [0:31] ;
   6 :  gpr_reg_6 <= wr_data [0:31] ;
   7 :  gpr_reg_7 <= wr_data [0:31] ;
   8 :  gpr_reg_8 <= wr_data [0:31] ;
   9 :  gpr_reg_9 <= wr_data [0:31] ;
  10 :  gpr_reg_10 <= wr_data [0:31] ;
  11 :  gpr_reg_11 <= wr_data [0:31] ;
  12 :  gpr_reg_12 <= wr_data [0:31] ;
  13 :  gpr_reg_13 <= wr_data [0:31] ;
  14 :  gpr_reg_14 <= wr_data [0:31] ;
  15 :  gpr_reg_15 <= wr_data [0:31] ;
  16 :  gpr_reg_16 <= wr_data [0:31] ;
  17 :  gpr_reg_17 <= wr_data [0:31] ;
  18 :  gpr_reg_18 <= wr_data [0:31] ;
  19 :  gpr_reg_19 <= wr_data [0:31] ;
  20 :  gpr_reg_20 <= wr_data [0:31] ;
  21 :  gpr_reg_21 <= wr_data [0:31] ;
  22 :  gpr_reg_22 <= wr_data [0:31] ;
  23 :  gpr_reg_23 <= wr_data [0:31] ;
  24 :  gpr_reg_24 <= wr_data [0:31] ;
  25 :  gpr_reg_25 <= wr_data [0:31] ;
  26 :  gpr_reg_26 <= wr_data [0:31] ;
  27 :  gpr_reg_27 <= wr_data [0:31] ;
  28 :  gpr_reg_28 <= wr_data [0:31] ;
  29 :  gpr_reg_29 <= wr_data [0:31] ;
  30 :  gpr_reg_30 <= wr_data [0:31] ;
  31 :  gpr_reg_31 <= wr_data [0:31] ;
 endcase
end

endtask

//
// Read Task
//
function [0:31] gpr_rd;
input [0:9] rd_addr;
reg [0:31] rd_data;
begin

 case (rd_addr[0:9])

      10'h288 : rd_data = gpr_reg_0;
      10'h284 : rd_data = gpr_reg_1;
      10'h282 : rd_data = gpr_reg_2;
      10'h281 : rd_data = gpr_reg_3;
      10'h248 : rd_data = gpr_reg_4;
      10'h244 : rd_data = gpr_reg_5;
      10'h242 : rd_data = gpr_reg_6;
      10'h241 : rd_data = gpr_reg_7;
      10'h228 : rd_data = gpr_reg_8;
      10'h224 : rd_data = gpr_reg_9;
      10'h222 : rd_data = gpr_reg_10;
      10'h221 : rd_data = gpr_reg_11;
      10'h218 : rd_data = gpr_reg_12;
      10'h214 : rd_data = gpr_reg_13;
      10'h212 : rd_data = gpr_reg_14;
      10'h211 : rd_data = gpr_reg_15;
      10'h188 : rd_data = gpr_reg_16;
      10'h184 : rd_data = gpr_reg_17;
      10'h182 : rd_data = gpr_reg_18;
      10'h181 : rd_data = gpr_reg_19;
      10'h148 : rd_data = gpr_reg_20;
      10'h144 : rd_data = gpr_reg_21;
      10'h142 : rd_data = gpr_reg_22;
      10'h141 : rd_data = gpr_reg_23;
      10'h128 : rd_data = gpr_reg_24;
      10'h124 : rd_data = gpr_reg_25;
      10'h122 : rd_data = gpr_reg_26;
      10'h121 : rd_data = gpr_reg_27;
      10'h118 : rd_data = gpr_reg_28;
      10'h114 : rd_data = gpr_reg_29;
      10'h112 : rd_data = gpr_reg_30;
      10'h111 : rd_data = gpr_reg_31;
      default : rd_data = gpr_reg_0;
 endcase
  gpr_rd = rd_data;
end
endfunction


//
// Translate Read Address Task
//
function [0:4] xlate_read_addr;
  input [0:9] rd_addr;
  begin

    case (rd_addr[0:9])

      10'h288 : xlate_read_addr = 5'h0;
      10'h284 : xlate_read_addr = 5'h1;
      10'h282 : xlate_read_addr = 5'h2;
      10'h281 : xlate_read_addr = 5'h3;
      10'h248 : xlate_read_addr = 5'h4;
      10'h244 : xlate_read_addr = 5'h5;
      10'h242 : xlate_read_addr = 5'h6;
      10'h241 : xlate_read_addr = 5'h7;
      10'h228 : xlate_read_addr = 5'h8;
      10'h224 : xlate_read_addr = 5'h9;
      10'h222 : xlate_read_addr = 5'ha;
      10'h221 : xlate_read_addr = 5'hb;
      10'h218 : xlate_read_addr = 5'hc;
      10'h214 : xlate_read_addr = 5'hd;
      10'h212 : xlate_read_addr = 5'he;
      10'h211 : xlate_read_addr = 5'hf;
      10'h188 : xlate_read_addr = 5'h10;
      10'h184 : xlate_read_addr = 5'h11;
      10'h182 : xlate_read_addr = 5'h12;
      10'h181 : xlate_read_addr = 5'h13;
      10'h148 : xlate_read_addr = 5'h14;
      10'h144 : xlate_read_addr = 5'h15;
      10'h142 : xlate_read_addr = 5'h16;
      10'h141 : xlate_read_addr = 5'h17;
      10'h128 : xlate_read_addr = 5'h18;
      10'h124 : xlate_read_addr = 5'h19;
      10'h122 : xlate_read_addr = 5'h1a;
      10'h121 : xlate_read_addr = 5'h1b;
      10'h118 : xlate_read_addr = 5'h1c;
      10'h114 : xlate_read_addr = 5'h1d;
      10'h112 : xlate_read_addr = 5'h1e;
      10'h111 : xlate_read_addr = 5'h1f;
      default : xlate_read_addr = 5'h0;

    endcase
  end
endfunction


//
// Write Logic For the L and R ports
// Ports may be written to simultaneously
// Note - Per IBM LpAddr /= RpAddr 
//
  always @ (posedge SysClk) begin
    if (LpWE) begin
     gpr_wr(LpAddr,lPort); 
    end

    if (RpWE) begin
     gpr_wr(RpAddr,rPort); 
    end
  end

//
// Need to translate the read address so we can compare 
// the port read addresses to the write address so we 
// can output the "new" write data to the appropriate 
// read port so it can be captured on the next rising 
// edge of sys clock.  This will match the original 
// design that has the gpr regs clocked off the neg 
// edge of sys clock.  This bypass will only be active 
// when read addr == write addr and NOT is write-through-
// read-mode.  So, we basically are putting the output 
// ports into write-through-read mode.
//

  always @ (ApAddr)
    begin
      xlated_ApAddr = xlate_read_addr(ApAddr);
    end

  assign ApAddr_Eq_RpAddr = (xlated_ApAddr == RpAddr) ? 1'b1 : 1'b0;
  assign ApAddr_Eq_LpAddr = (xlated_ApAddr == LpAddr) ? 1'b1 : 1'b0;

  always @ (BpAddr)
    begin
      xlated_BpAddr = xlate_read_addr(BpAddr);
    end

  assign BpAddr_Eq_RpAddr = (xlated_BpAddr == RpAddr) ? 1'b1 : 1'b0;
  assign BpAddr_Eq_LpAddr = (xlated_BpAddr == LpAddr) ? 1'b1 : 1'b0;

  always @ (SpAddr)
    begin
      xlated_SpAddr = xlate_read_addr(SpAddr);
    end

  assign SpAddr_Eq_RpAddr = (xlated_SpAddr == RpAddr) ? 1'b1 : 1'b0;
  assign SpAddr_Eq_LpAddr = (xlated_SpAddr == LpAddr) ? 1'b1 : 1'b0;

//
// Aport read logic
// Make sure that we "re-read" the data after a reg write

  always @ (ApAddr or gpr_reg_0 or gpr_reg_1 or gpr_reg_2 or 
            gpr_reg_3 or gpr_reg_4 or gpr_reg_5 or gpr_reg_6 or 
            gpr_reg_7 or gpr_reg_8 or gpr_reg_9 or gpr_reg_10 or 
            gpr_reg_11 or gpr_reg_12 or gpr_reg_13 or gpr_reg_14 or 
            gpr_reg_15 or gpr_reg_16 or gpr_reg_17 or gpr_reg_18 or 
            gpr_reg_19 or gpr_reg_20 or gpr_reg_21 or gpr_reg_22 or 
            gpr_reg_23 or gpr_reg_24 or gpr_reg_25 or gpr_reg_26 or 
            gpr_reg_27 or gpr_reg_28 or gpr_reg_29 or gpr_reg_30 or 
            gpr_reg_31)
  begin
    fromReg_aaddr = gpr_rd(ApAddr);
  end

  always @ (fromReg_aaddr or lPort or rPort or RpEqAp or
       RpWE or LpEqAp or LpWE or ApAddr_Eq_RpAddr or 
       ApAddr_Eq_LpAddr) begin
     case({(RpEqAp | ApAddr_Eq_RpAddr) & RpWE, 
           (LpEqAp | ApAddr_Eq_LpAddr) & LpWE}) 
       2'b00: aPort = fromReg_aaddr;
       2'b01: aPort = lPort;
       2'b10: aPort = rPort;
       default: aPort = fromReg_aaddr;
     endcase
  end

//
// Bport Read logic 
// Make sure that we "re-read" the data after a reg write

  always @ (BpAddr or gpr_reg_0 or gpr_reg_1 or gpr_reg_2 or 
            gpr_reg_3 or gpr_reg_4 or gpr_reg_5 or gpr_reg_6 or 
            gpr_reg_7 or gpr_reg_8 or gpr_reg_9 or gpr_reg_10 or 
            gpr_reg_11 or gpr_reg_12 or gpr_reg_13 or gpr_reg_14 or 
            gpr_reg_15 or gpr_reg_16 or gpr_reg_17 or gpr_reg_18 or 
            gpr_reg_19 or gpr_reg_20 or gpr_reg_21 or gpr_reg_22 or 
            gpr_reg_23 or gpr_reg_24 or gpr_reg_25 or gpr_reg_26 or 
            gpr_reg_27 or gpr_reg_28 or gpr_reg_29 or gpr_reg_30 or 
            gpr_reg_31)
  begin
    fromReg_baddr = gpr_rd(BpAddr);
  end

  always @ (fromReg_baddr or lPort or rPort or RpEqBp or
       RpWE or LpEqBp or LpWE or BpAddr_Eq_RpAddr or 
       BpAddr_Eq_LpAddr) begin
     case({(RpEqBp | BpAddr_Eq_RpAddr) & RpWE, 
           (LpEqBp | BpAddr_Eq_LpAddr) & LpWE}) 
       2'b00: bPort_int = fromReg_baddr;
       2'b01: bPort_int = lPort;
       2'b10: bPort_int = rPort;
       default: bPort_int = fromReg_baddr;
     endcase
  end

// Dont want to read from an output port per RMM

  assign bPort = bPort_int;

//
// Sport Read Logic
// Make sure that we "re-read" the data after a reg write

  always @ (SpAddr or gpr_reg_0 or gpr_reg_1 or gpr_reg_2 or 
            gpr_reg_3 or gpr_reg_4 or gpr_reg_5 or gpr_reg_6 or 
            gpr_reg_7 or gpr_reg_8 or gpr_reg_9 or gpr_reg_10 or 
            gpr_reg_11 or gpr_reg_12 or gpr_reg_13 or gpr_reg_14 or 
            gpr_reg_15 or gpr_reg_16 or gpr_reg_17 or gpr_reg_18 or 
            gpr_reg_19 or gpr_reg_20 or gpr_reg_21 or gpr_reg_22 or 
            gpr_reg_23 or gpr_reg_24 or gpr_reg_25 or gpr_reg_26 or 
            gpr_reg_27 or gpr_reg_28 or gpr_reg_29 or gpr_reg_30 or 
            gpr_reg_31)
  begin
    fromReg_saddr = gpr_rd(SpAddr);
  end

  always @ (fromReg_saddr or lPort or rPort or RpEqSp or
       RpWE or LpEqSp or LpWE or SpAddr_Eq_RpAddr or 
       SpAddr_Eq_LpAddr) begin
     case({(RpEqSp | SpAddr_Eq_RpAddr) & RpWE, 
           (LpEqSp | SpAddr_Eq_LpAddr) & LpWE}) 
       2'b00: sport_data = fromReg_saddr;
       2'b01: sport_data = lPort;
       2'b10: sport_data = rPort;
       default: sport_data = fromReg_saddr;
     endcase
  end

 assign sp_enable = (BpEqSp & ~(RpEqSp & RpWE) &
                     ~(LpEqSp & LpWE)) ;

  always @ (sport_data or sp_enable or bPort_int) begin
    case(sp_enable) 
      1'b0: sPort = sport_data;
      1'b1: sPort = bPort_int;
      default: sPort = 32'bx;
//      default: sPort = sport_data;
    endcase
  end 

endmodule

