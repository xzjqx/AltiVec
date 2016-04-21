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
//
module p405s_wbStage (PCL_ldAdjE2, PCL_ldFillByPassMuxSel, ldAdjSel,
           PCL_ldSteerMuxSel, PCL_wbRpWrEn, wbFull, wbLoad, wbLpWrEn,
           CB, byteCount, cntGtEq4, exeAlg, exeByteRev, exeStorageOp,
           exeEA, exeLoadQ, exeMultiple, exeRpWrEnQ, exeStrgSt, exeString,
           loadSteerMuxSel, lwbE1, nxtWbLpWrEn, PCL_wbStorageOp,
           wbClearOrFlush, wbEndian, wbE1, wbE2, wbStrgLS, exeLwarx,
           exeStwcx, wbLwarx, wbStwcx, exeApuFpuLoad, wbApuFpuLoad,
           algnErr, PCL_wbAlgnErr, exeLdNotSt, PCL_wbLdNotSt, exeStore,
           exeWUD, wbLdOrStWUD, wbStrgC1, exeRA, wbRAL2, exeStrgEnd, PCL_wbStrgEnd,
           exeByteEn, wbByteEn, wbFullForPO, exeTrapLE, exeTrapBE,
           exeApuFpuLdSt,wbStrgSt, wbFullForDepend, wbLoadForApu);
    output [1:3] PCL_ldAdjE2;
    output [0:5] PCL_ldFillByPassMuxSel;
    output [1:3] ldAdjSel;
    output [0:7] PCL_ldSteerMuxSel;
    output PCL_wbRpWrEn;
    output wbFull;
    output wbLoad;
    output wbLpWrEn;
    output PCL_wbStorageOp;
    output wbStrgLS;
    output wbLwarx;
    output wbStwcx;
    output wbApuFpuLoad;
    output PCL_wbAlgnErr;
    output PCL_wbLdNotSt;
    output wbLdOrStWUD;
    output wbStrgC1;
    output [0:4] wbRAL2;
    output PCL_wbStrgEnd;
    output [0:3] wbByteEn;
    output wbFullForPO;
    output [1:2] wbStrgSt;
    output wbFullForDepend;
    output wbLoadForApu;
    input [0:4] exeRA;
    input       CB;
    input [6:7] byteCount;
    input cntGtEq4;
    input exeAlg;
    input exeByteRev;
    input [30:31] exeEA;
    input exeLoadQ;
    input exeMultiple;
    input exeRpWrEnQ;
    input [0:2] exeStrgSt;
    input exeString;
    input loadSteerMuxSel;
    input lwbE1;
    input nxtWbLpWrEn;
    input wbClearOrFlush;
    input wbEndian;
    input wbE1;
    input wbE2;
    input exeStorageOp;
    input exeLwarx;
    input exeStwcx;
    input exeApuFpuLoad;
    input algnErr;
    input exeLdNotSt;
    input exeStore;
    input exeWUD;
    input exeStrgEnd;
    input [0:3] exeByteEn;
    input exeTrapLE;
    input exeTrapBE;
    input exeApuFpuLdSt;

// Changes:
// 04/05/00 SBP Change the D1 input of dp_regPCL_wbStage register. See issue 184 for more detail.

wire  byteRevEndian;
reg wbAlgnErr;
wire [1:3]  wbLdAdjE2;
wire [1:3]  wbLdAdjSel, ldAdjSel;
wire [0:7]  wbLdSteerMuxSel;
wire [0:5]  wbLdFillByPassMuxSel, PCL_ldFillByPassMuxSel;
wire [6:7]  byteCount;
wire [30:31] exeEA;
wire [0:7] PCL_ldSteerMuxSel;
reg [1:3] lwbLdAdjE2;
reg [1:3] lwbLdAdjSel;
reg [0:7] lwbLdSteerMuxSel;
reg [0:5] lwbLdFillByPassMuxSel;
reg wbFullForDepend;
reg [0:3] wbByteEn;
reg wbTrapLE;
reg wbTrapBE;
reg wbApuFpuLdSt;
reg wbLoadForApu;
reg [30:31] wbEA;
reg [6:7] wbByteCount;
reg wbCntGtEq4;
wire [1:2] wbStrgSt;
reg wbLoad_i;
reg wbString;
reg wbMultiple;
reg wbByteRev;
reg wbAlg;
reg wbFull;
reg wbFullForPO;
reg wbRpWrEn;
reg wbLpWrEn;
reg PCL_wbStorageOp;
reg wbLwarx;
reg wbStwcx;
reg wbApuFpuLoad;
reg PCL_wbLdNotSt;
reg wbStore;
reg wbWUD;
reg [0:4] wbRAL2_i;
reg PCL_wbStrgEnd;
reg [1:2] wbStrgSt_i;


assign wbRAL2 = wbRAL2_i;
assign wbStrgSt = wbStrgSt_i;
assign wbLoad = wbLoad_i;

//************************************************************************
// WB CNtl Register
//************************************************************************

//Removed the module dp_regPCL_wbStage
always @(posedge CB)
  begin: dp_regPCL_wbStage_PROC
    if (wbE1 & wbE2)
      begin
        if (wbClearOrFlush)
          {wbEA, 
           wbByteCount,
           wbCntGtEq4,
           wbStrgSt_i, 
           wbLoad_i, 
           wbString, 
           wbMultiple,
           wbByteRev, 
           wbAlg, 
           wbFull, 
           wbFullForPO, 
           wbRpWrEn,
           wbLpWrEn, 
           PCL_wbStorageOp, 
           wbLwarx, 
           wbStwcx,
           wbApuFpuLoad, 
           wbAlgnErr, 
           PCL_wbLdNotSt,
           wbStore, 
           wbWUD, 
           wbRAL2_i, 
           PCL_wbStrgEnd} <= {24'b0,wbRAL2_i[0:4],1'b0};
        else
          {wbEA, 
           wbByteCount,
           wbCntGtEq4,
           wbStrgSt_i, 
           wbLoad_i, 
           wbString, 
           wbMultiple,
           wbByteRev, 
           wbAlg, 
           wbFull, 
           wbFullForPO, 
           wbRpWrEn,
           wbLpWrEn, 
           PCL_wbStorageOp, 
           wbLwarx, 
           wbStwcx,
           wbApuFpuLoad, 
           wbAlgnErr, 
           PCL_wbLdNotSt,
           wbStore, 
           wbWUD, 
           wbRAL2_i, 
           PCL_wbStrgEnd} <= {exeEA, 
                              byteCount, 
                              cntGtEq4,
                              exeStrgSt[1:2], 
                              exeLoadQ, 
                              exeString, 
                              exeMultiple,
                              exeByteRev, 
                              exeAlg, 
                              2'b11, 
                              exeRpWrEnQ,
                              nxtWbLpWrEn, 
                              exeStorageOp, 
                              exeLwarx, 
                              exeStwcx,
                              exeApuFpuLoad, 
                              algnErr,
                              exeLdNotSt, 
                              exeStore,
                              exeWUD, 
                              exeRA, 
                              exeStrgEnd};
      end
  end // dp_regPCL_wbStage_PROC
  
//Removed the module dp_regPCL_wbStage1 
always @(posedge CB)
  begin: dp_regPCL_wbStage1_PROC
    if (wbE1 & wbE2)
      begin
        if (wbClearOrFlush)
          {wbFullForDepend, 
           wbByteEn, 
           wbTrapLE, 
           wbTrapBE,
           wbApuFpuLdSt, 
           wbLoadForApu} <= 9'b0;
        else
          {wbFullForDepend, 
           wbByteEn, 
           wbTrapLE, 
           wbTrapBE,
           wbApuFpuLdSt, 
           wbLoadForApu} <= {1'b1, exeByteEn, exeTrapLE, exeTrapBE, exeApuFpuLdSt, exeLoadQ};        
      end
  end // dp_regPCL_wbStage1_PROC

assign byteRevEndian =  wbByteRev ^ wbEndian;
assign wbStrgLS = wbStrgSt_i[1];
assign wbStrgC1 = wbStrgSt_i[2];
assign wbLdOrStWUD = wbWUD & (wbLoad_i | wbStore);
assign PCL_wbRpWrEn = wbRpWrEn | exeStrgSt[0];
assign PCL_wbAlgnErr = wbAlgnErr | (wbApuFpuLdSt & ((wbEndian & wbTrapLE) |
                                                    (~wbEndian & wbTrapBE)));
//************************************************************************
// Load Steering PLA
//************************************************************************
p405s_ldSteerPla
   ldSteerPlaPla(.ldAdjE2(wbLdAdjE2[1:3]),
                                       .ldFillByPassMuxSel(wbLdFillByPassMuxSel[0:5]),
                                       .ldAdjSel(wbLdAdjSel[1:3]),
                                       .ldSteerMuxSel(wbLdSteerMuxSel[0:7]),
                                       .algebraic(wbAlg),
                                       .byteCount(wbByteCount),
                                       .byteRev(byteRevEndian),
                                       .cntGtEq4(wbCntGtEq4),
                                       .ea(wbEA),
                                       .load(wbLoad_i),
                                       .multiple(wbMultiple),
                                       .strgSt(wbStrgSt_i),
                                       .string(wbString));

//************************************************************************
// LWB Load Steering Register
//************************************************************************
//Removed the module dp_regPCL_lwbLdSteer 
always @(posedge CB)
  begin: dp_regPCL_lwbLdSteer_PROC
    if (lwbE1)
      {lwbLdAdjE2,
       lwbLdAdjSel,
       lwbLdSteerMuxSel,
       lwbLdFillByPassMuxSel} <= {wbLdAdjE2,
                                  wbLdAdjSel,
                                  wbLdSteerMuxSel,
                                  wbLdFillByPassMuxSel};
  end // dp_regPCL_lwbLdSteer_PROC

//************************************************************************
// Load Steering Mux
//************************************************************************
//Removed the module dp_muxPCL_ldSteer 
assign {PCL_ldAdjE2, ldAdjSel, 
        PCL_ldSteerMuxSel, PCL_ldFillByPassMuxSel} = 
                           loadSteerMuxSel ? {lwbLdAdjE2, lwbLdAdjSel, 
                                              lwbLdSteerMuxSel, lwbLdFillByPassMuxSel}
                                           : {wbLdAdjE2, wbLdAdjSel, 
                                              wbLdSteerMuxSel, wbLdFillByPassMuxSel};
endmodule
