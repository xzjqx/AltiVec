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
// Cobra Change History
// NAME   DATE    DEFECT  DESCRIPTION
// PGM  07/31/01   1785   Remove port size information in module definition
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1

module p405s_dbg_top( DBG_dacEn, DBG_dacIntrp, DBG_dvcRdEn, DBG_dvcWrEn, DBG_eventSet,
     DBG_exeIacSuppress, DBG_exeSuppress, DBG_exeTE, DBG_freezeTimers, DBG_iacEn,
     DBG_icmpEn, DBG_immdTE, DBG_intrp, DBG_rstChipReq, DBG_rstCoreReq, DBG_rstSystemReq,
     DBG_sprDataBus, DBG_stopReq, DBG_trapEnQ, DBG_udeEventSet, DBG_udeIntrp,
     DBG_wbDacSuppress, DBG_wbTE, DBG_weakStopReq, CB, EXE_dac1Bits0to26Eq,
     EXE_dac1Bits27to29Eq, EXE_dac1Bits30Eq, EXE_dac1Bits31Eq, EXE_dac1GtDsEa,
     EXE_dac2Bits0to26Eq, EXE_dac2Bits27to29Eq, EXE_dac2Bits30Eq, EXE_dac2Bits31Eq,
     EXE_dac2GtDsEa, EXE_dbgSprDcds, EXE_dvc1ByteCmp, EXE_dvc2ByteCmp,
     EXE_sprDataBus, IFB_dcdFullL2, IFB_exeBrTaken, IFB_exeClear, IFB_exeDisableDbL2,
     IFB_exeFlush, IFB_exeFullL2, IFB_iac1BitsEq, IFB_iac1GtIar, IFB_iac2BitsEq, IFB_iac2GtIar,
     IFB_iac3BitsEq, IFB_iac3GtIar, IFB_iac4BitsEq, IFB_iac4GtIar, IFB_stuffStL2,
     IFB_wbDisableDbL2, JTG_dbdrPulse, JTG_dbgWaitEn, JTG_resetDBSR, JTG_uncondEvent,
     PCL_dvcCmpEn, PCL_exeDbgLdOp, PCL_exeDbgRdOp, PCL_exeDbgStOp, PCL_exeDbgWrOp,
     PCL_exeDvcHold, PCL_exeIarHold, PCL_exeTrap, PCL_mtSPR, PCL_sprHold, PCL_wbClearOrFlush,
     PCL_wbDbgIcmp, PCL_wbFull, PCL_wbHold, VCT_exeBrTrapErrSuppress, VCT_msrDE, VCT_msrDWE,
     VCT_swapQ01, VCT_swapQ23, VCT_wbErrSuppress, VCT_wbFlush, XXX_uncondEvent, chipReset,
     coreReset, systemReset, PCL_exeDvcOrParityHold);
output  DBG_dacEn, DBG_dacIntrp, DBG_dvcRdEn, DBG_dvcWrEn, DBG_eventSet, DBG_exeIacSuppress,
     DBG_exeSuppress, DBG_freezeTimers, DBG_iacEn, DBG_icmpEn, DBG_intrp, DBG_rstChipReq,
     DBG_rstCoreReq, DBG_rstSystemReq, DBG_stopReq, DBG_trapEnQ, DBG_udeEventSet, DBG_udeIntrp,
     DBG_wbDacSuppress, DBG_weakStopReq;


input  EXE_dac1Bits0to26Eq, EXE_dac1Bits27to29Eq, EXE_dac1Bits30Eq, EXE_dac1Bits31Eq,
     EXE_dac1GtDsEa, EXE_dac2Bits0to26Eq, EXE_dac2Bits27to29Eq, EXE_dac2Bits30Eq,
     EXE_dac2Bits31Eq, EXE_dac2GtDsEa, IFB_dcdFullL2, IFB_exeBrTaken, IFB_exeClear,
     IFB_exeDisableDbL2, IFB_exeFlush, IFB_exeFullL2, IFB_iac1BitsEq, IFB_iac1GtIar,
     IFB_iac2BitsEq, IFB_iac2GtIar, IFB_iac3BitsEq, IFB_iac3GtIar, IFB_iac4BitsEq,
     IFB_iac4GtIar, IFB_stuffStL2, IFB_wbDisableDbL2, JTG_dbdrPulse, JTG_dbgWaitEn,
     JTG_resetDBSR, JTG_uncondEvent, PCL_dvcCmpEn, PCL_exeDbgLdOp, PCL_exeDbgRdOp,
     PCL_exeDbgStOp, PCL_exeDbgWrOp, PCL_exeDvcHold, PCL_exeIarHold, PCL_exeTrap, PCL_mtSPR,
     PCL_sprHold, PCL_wbClearOrFlush, PCL_wbDbgIcmp, PCL_wbFull, PCL_wbHold,
     VCT_exeBrTrapErrSuppress, VCT_msrDE, VCT_msrDWE, VCT_swapQ01, VCT_swapQ23,
     VCT_wbErrSuppress, VCT_wbFlush, XXX_uncondEvent, chipReset, coreReset,
     systemReset, PCL_exeDvcOrParityHold;

output [0:2]  DBG_immdTE;
output [0:4]  DBG_wbTE;
output [0:31]  DBG_sprDataBus;
output [0:4]  DBG_exeTE;


input [0:3]  EXE_dvc1ByteCmp;
input [0:3]  EXE_dbgSprDcds;
input [0:3]  EXE_dvc2ByteCmp;

input        CB;
input [0:31]  EXE_sprDataBus;

// Buses in the design

wire  [0:1]  sprBusSel;

reg   [0:3]  wbDvcCntl;

reg   [0:23]  dbsr;

wire  [0:23]  nxtDbsr;

reg  [0:23]   dbcr1;

reg  [0:31]   dbcr0;

reg  [0:31]   DBG_sprDataBus_i;

reg  exeIac1EventL2;
reg  exeIac2EventL2;
reg  exeIac3EventL2;
reg  exeIac4EventL2;

reg  coreResetL2;
reg  chipResetL2;
reg  systemResetL2;

reg  dac1RdL2;
reg  dac1WrL2; 
reg  dac2RdL2; 
reg  dac2WrL2;

wire  dvc1RdL2; 
wire  dvc1WrL2; 
wire  dvc2RdL2;  
wire  dvc2WrL2;

wire dbcrE1;
wire dbcr1E2;
wire dbcr0_XE2;

wire nxtHwIac12X;
wire nxtHwIac34X;

wire exeMtdbcr0;
wire dvcCntlE2;
wire nxtDvc1Rd;
wire nxtDvc1Wr;
wire nxtDvc2Rd; 
wire nxtDvc2Wr;
wire iacCntlE1;
wire iacCntlE2;
wire iacCntlSel;
wire nxtExeIac1Event;
wire nxtExeIac2Event;
wire nxtExeIac3Event;
wire nxtExeIac4Event;
wire dacCntlE1;
wire dacCntlE2;

wire nxtDac1Rd;
wire nxtDac1Wr;
wire nxtDac2Rd;
wire nxtDac2Wr;
wire dbsrE2;
wire  nxtDbsrSummaryBit;
wire dbcr0E2;

reg dbsrSummaryBit;

assign DBG_sprDataBus = DBG_sprDataBus_i;
assign nxtDbsr[14:21] = 8'h0;

//Removed the module dp_logDBG_wbDvcCntlInv

assign {dvc1RdL2, dvc1WrL2, dvc2RdL2,  dvc2WrL2} =  wbDvcCntl[0:3]; 

//Removed the module  dp_regDBG_dbcr1_low    

always @(posedge CB)
 begin: dp_regDBG_dbcr1_low_PROC
   if (dbcrE1 & dbcr1E2)
     {dbcr1[0:9],dbcr1[12:23]} <= {EXE_sprDataBus[0:9], EXE_sprDataBus[12:23]};
 end  // dp_regDBG_dbcr1_low_PROC

//Removed the module dp_regDBG_dbcr0_X

// TBird Defect: 2298 -- dbcr0[2:3] comes on for a cycle during reset.  This is not really a design 
//   problem since the CSM says you have to ignore all output for a number of cycles upon reset.  But
//   these signals are for system reset request.  We are going to gate the two signals off during 
//   reset to clarify things for TBird and here on out.

always @(posedge CB)
 begin: dp_regDBG_dbcr0_X_PROC
   if (dbcr0_XE2)
     begin
       if (exeMtdbcr0)
         {dbcr0[11], dbcr0[15]} <= {EXE_sprDataBus[11], EXE_sprDataBus[15]};
       else
         {dbcr0[11], dbcr0[15]} <=  {nxtHwIac12X, nxtHwIac34X};
     end
   if (dbcrE1 & dbcr0E2)
     {dbcr0[0:10], dbcr0[12:14], dbcr0[16:17], dbcr0[31]} <= {EXE_sprDataBus[0:1], 
                                               (EXE_sprDataBus[2] & ~coreResetL2),
                                               (EXE_sprDataBus[3] & ~coreResetL2),
                                               EXE_sprDataBus[4:10],
                                               EXE_sprDataBus[12:14],
                                               EXE_sprDataBus[16:17],
                                               EXE_sprDataBus[31]};
 end // dp_regDBG_dbcr0_X_PROC

//Removed the module dp_regDBG_wbDvcCntl

always @(posedge CB)
  begin: dp_regDBG_wbDvcCntl_PROC
    if (dvcCntlE2)
      begin
        if (PCL_wbClearOrFlush)
          wbDvcCntl <= 4'h0;
        else
          wbDvcCntl <= {nxtDvc1Rd, nxtDvc1Wr, nxtDvc2Rd, nxtDvc2Wr};
      end
  end // dp_regDBG_wbDvcCntl_PROC
  
//Removed the module dp_regDBG_dbcr1   

//Removed the module dbgClkBuf

//Removed the module dp_regDBG_dbgReset

always @(posedge CB)
  begin: dp_regDBG_dbgReset_PROC
    {coreResetL2, chipResetL2, systemResetL2} <= {coreReset, chipReset, systemReset};
  end // dp_regDBG_dbgReset_PROC

//Removed the module dp_regDBG_exeIacCntl

always @(posedge CB)
  begin: dp_regDBG_exeIacCntl_PROC
    if (iacCntlE1 & iacCntlE2)
      begin
        if (iacCntlSel)
          {exeIac1EventL2, exeIac2EventL2, exeIac3EventL2, exeIac4EventL2} <= 4'h0;
        else
          {exeIac1EventL2, exeIac2EventL2, exeIac3EventL2, exeIac4EventL2} <= 
             {nxtExeIac1Event, nxtExeIac2Event, nxtExeIac3Event, nxtExeIac4Event};
      end
  end // dp_regDBG_exeIacCntl_PROC

//Removed the module dp_regDBG_wbDacCntl

always @(posedge CB)
  begin: dp_regDBG_wbDacCntl_PROC
    if (dacCntlE1 & dacCntlE2)
      begin
        if (PCL_wbClearOrFlush)
          {dac1RdL2, dac1WrL2, dac2RdL2, dac2WrL2} <= 4'h0;
        else
          {dac1RdL2, dac1WrL2, dac2RdL2, dac2WrL2} <= {nxtDac1Rd, nxtDac1Wr, nxtDac2Rd, nxtDac2Wr};
      end
  end // dp_regDBG_wbDacCntl_PROC

//Removed the module dp_regDBG_dbsr

always @(posedge CB)
  begin: dp_regDBG_dbsr_PROC
    if (dbsrE2)
      {dbsr[0:13], dbsr[22:23], dbsrSummaryBit} <= {nxtDbsr[0:13], nxtDbsr[22:23], nxtDbsrSummaryBit};
  end // dp_regDBG_dbsr_PROC

//Removed the module dp_regDBG_dbcr0

p405s_dbgEqs
 dbgEqsFunc(.nxtExeIac1Event(nxtExeIac1Event), 
                        .nxtExeIac2Event(nxtExeIac2Event), 
                        .nxtExeIac3Event(nxtExeIac3Event), 
                        .nxtExeIac4Event(nxtExeIac4Event),
                        .nxtDac1Rd(nxtDac1Rd), 
                        .nxtDac1Wr(nxtDac1Wr), 
                        .nxtDac2Rd(nxtDac2Rd), 
                        .nxtDac2Wr(nxtDac2Wr), 
                        .nxtDvc1Rd(nxtDvc1Rd), 
                        .nxtDvc1Wr(nxtDvc1Wr), 
                        .nxtDvc2Rd(nxtDvc2Rd), 
                        .nxtDvc2Wr(nxtDvc2Wr),
                        .nxtDbsrSummaryBit(nxtDbsrSummaryBit), 
                        .nxtHwIac12X(nxtHwIac12X), 
                        .nxtHwIac34X(nxtHwIac34X), 
                        .dbcr0_XE2(dbcr0_XE2), 
                        .iacCntlE1(iacCntlE1), 
                        .iacCntlE2(iacCntlE2), 
                        .iacCntlSel(iacCntlSel),
                        .dacCntlE1(dacCntlE1), 
                        .dacCntlE2(dacCntlE2), 
                        .dvcCntlE2(dvcCntlE2), 
                        .DBG_exeSuppress(DBG_exeSuppress), 
                        .DBG_wbDacSuppress(DBG_wbDacSuppress), 
                        .DBG_exeIacSuppress(DBG_exeIacSuppress),
                        .DBG_icmpEn(DBG_icmpEn), 
                        .DBG_stopReq(DBG_stopReq), 
                        .DBG_weakStopReq(DBG_weakStopReq), 
                        .DBG_intrp(DBG_intrp), 
                        .DBG_freezeTimers(DBG_freezeTimers), 
                        .DBG_trapEnQ(DBG_trapEnQ),
                        .DBG_udeIntrp(DBG_udeIntrp), 
                        .DBG_dacEn(DBG_dacEn), 
                        .DBG_rstCoreReq(DBG_rstCoreReq), 
                        .DBG_rstChipReq(DBG_rstChipReq), 
                        .DBG_rstSystemReq(DBG_rstSystemReq), 
                        .DBG_iacEn(DBG_iacEn),
                        .DBG_dvcRdEn(DBG_dvcRdEn), 
                        .DBG_dvcWrEn(DBG_dvcWrEn), 
                        .DBG_eventSet(DBG_eventSet),  
                        .DBG_exeTE(DBG_exeTE), 
                        .DBG_wbTE(DBG_wbTE),
                        .DBG_immdTE(DBG_immdTE), 
                        .DBG_dacIntrp(DBG_dacIntrp), 
                        .nxtDbsrGroup0({nxtDbsr[0:1], nxtDbsr[3], nxtDbsr[5],
                                        nxtDbsr[6:10], nxtDbsr[12:13]}),
                        .nxtDbsrGroup1({nxtDbsr[2], nxtDbsr[4]}), 
                        .nxtDbsrGroup2(nxtDbsr[11]),
                        .nxtDbsrGroup3(nxtDbsr[22:23]), 
                        .dbsrE2(dbsrE2), 
                        .dbcrE1(dbcrE1), 
                        .dbcr0E2(dbcr0E2), 
                        .dbcr1E2(dbcr1E2),
                        .sprBusSel(sprBusSel), 
                        .exeMtdbcr0(exeMtdbcr0), 
                        .IFB_iac1GtIar(IFB_iac1GtIar), 
                        .IFB_iac1BitsEq(IFB_iac1BitsEq), 
                        .IFB_iac2GtIar(IFB_iac2GtIar), 
                        .IFB_iac2BitsEq(IFB_iac2BitsEq),
                        .IFB_iac3GtIar(IFB_iac3GtIar), 
                        .IFB_iac3BitsEq(IFB_iac3BitsEq), 
                        .IFB_iac4GtIar(IFB_iac4GtIar), 
                        .IFB_iac4BitsEq(IFB_iac4BitsEq), 
                        .IFB_stuffStL2(IFB_stuffStL2),
                        .IFB_exeDbgBrTaken(IFB_exeBrTaken), 
                        .IFB_exeFlush(IFB_exeFlush), 
                        .IFB_exeClear(IFB_exeClear), 
                        .IFB_dcdFullL2(IFB_dcdFullL2), 
                        .IFB_exeFullL2(IFB_exeFullL2),
                        .IFB_exeDisableDbL2(IFB_exeDisableDbL2), 
                        .IFB_wbDisableDbL2(IFB_wbDisableDbL2), 
                        .EXE_dvc1ByteCmp(EXE_dvc1ByteCmp), 
                        .EXE_dac1Bits0to26Eq(EXE_dac1Bits0to26Eq),
                        .EXE_dac1Bits27to29Eq(EXE_dac1Bits27to29Eq), 
                        .EXE_dac1Bits30Eq(EXE_dac1Bits30Eq), 
                        .EXE_dac1Bits31Eq(EXE_dac1Bits31Eq), 
                        .EXE_dac1GtDsEa(EXE_dac1GtDsEa),
                        .EXE_dvc2ByteCmp(EXE_dvc2ByteCmp), 
                        .EXE_dac2Bits0to26Eq(EXE_dac2Bits0to26Eq), 
                        .EXE_dac2Bits27to29Eq(EXE_dac2Bits27to29Eq), 
                        .EXE_dac2Bits30Eq(EXE_dac2Bits30Eq),
                        .EXE_dac2Bits31Eq(EXE_dac2Bits31Eq), 
                        .EXE_dac2GtDsEa(EXE_dac2GtDsEa), 
                        .EXE_dbgSprDcds(EXE_dbgSprDcds), 
                        .EXE_sprDataBus(EXE_sprDataBus),
                        .PCL_exeDbgRdOp(PCL_exeDbgRdOp), 
                        .PCL_exeDbgWrOp(PCL_exeDbgWrOp), 
                        .PCL_wbDbgIcmp(PCL_wbDbgIcmp),
                        .PCL_dvcCmpEn(PCL_dvcCmpEn), 
                        .PCL_mtSPR(PCL_mtSPR), 
                        .PCL_exeDvcHold(PCL_exeDvcHold),
                        .PCL_exeTrap(PCL_exeTrap), 
                        .PCL_sprHold(PCL_sprHold), 
                        .PCL_exeIarHold(PCL_exeIarHold), 
                        .PCL_wbHold(PCL_wbHold), 
                        .PCL_wbFull(PCL_wbFull), 
                        .PCL_exeDbgLdOp(PCL_exeDbgLdOp),
                        .PCL_exeDbgStOp(PCL_exeDbgStOp), 
                        .VCT_msrDE(VCT_msrDE), 
                        .VCT_msrDWE(VCT_msrDWE), 
                        .VCT_wbFlush(VCT_wbFlush), 
                        .VCT_wbErrSuppress(VCT_wbErrSuppress), 
                        .VCT_swapQ01(VCT_swapQ01),
                        .VCT_swapQ23(VCT_swapQ23), 
                        .JTG_dbgWaitEn(JTG_dbgWaitEn), 
                        .VCT_exeBrTrapErrSuppress(VCT_exeBrTrapErrSuppress), 
                        .JTG_uncondEvent(JTG_uncondEvent), 
                        .JTG_dbdrPulse(JTG_dbdrPulse),
                        .JTG_resetDBSR(JTG_resetDBSR), 
                        .XXX_uncondEvent(XXX_uncondEvent), 
                        .coreResetL2(coreResetL2), 
                        .intDbMode(dbcr0[1]), 
                        .extDbMode(dbcr0[0]), 
                        .enIcmpL2(dbcr0[4]), 
                        .enBrTakenL2(dbcr0[5]),
                        .enTrapL2(dbcr0[7]), 
                        .enIac1L2(dbcr0[8]), 
                        .enIac2L2(dbcr0[9]), 
                        .enIac12RangeL2(dbcr0[10]), 
                        .enIac12XRangeL2(dbcr0[11]), 
                        .enIac3L2(dbcr0[12]), 
                        .enIac4L2(dbcr0[13]), 
                        .enIac34RangeL2(dbcr0[14]),
                        .enIac34XRangeL2(dbcr0[15]), 
                        .enIac12XToggleL2(dbcr0[16]), 
                        .enIac34XToggleL2(dbcr0[17]), 
                        .exeIac1EventL2(exeIac1EventL2), 
                        .exeIac2EventL2(exeIac2EventL2), 
                        .exeIac3EventL2(exeIac3EventL2),
                        .exeIac4EventL2(exeIac4EventL2), 
                        .enDac1RdL2(dbcr1[0]), 
                        .enDac1WrL2(dbcr1[2]), 
                        .dac1SizeL2(dbcr1[4:5]), 
                        .enDac2RdL2(dbcr1[1]), 
                        .enDac2WrL2(dbcr1[3]), 
                        .dac2SizeL2(dbcr1[6:7]), 
                        .enDacRangeL2(dbcr1[8]),
                        .enDacXRangeL2(dbcr1[9]), 
                        .dvc1ModeL2(dbcr1[12:13]), 
                        .dvc1BEL2(dbcr1[16:19]), 
                        .dvc2ModeL2(dbcr1[14:15]), 
                        .dvc2BEL2(dbcr1[20:23]), 
                        .dac1RdL2(dac1RdL2), 
                        .dac1WrL2(dac1WrL2),
                        .dac2RdL2(dac2RdL2), 
                        .dac2WrL2(dac2WrL2), 
                        .dvc1RdL2(dvc1RdL2), 
                        .dvc1WrL2(dvc1WrL2), 
                        .dvc2RdL2(dvc2RdL2), 
                        .dvc2WrL2(dvc2WrL2), 
                        .dbsrGroup0({dbsr[0:1], dbsr[3], dbsr[5:10], dbsr[12:13]}), 
                        .enExcL2(dbcr0[6]),
                        .dbsrGroup1({dbsr[2], dbsr[4]}), 
                        .dbsrGroup2(dbsr[11]), 
                        .chipResetL2(chipResetL2), 
                        .systemResetL2(systemResetL2),
                        .dbsrGroup3(dbsr[22:23]), 
                        .dbsrSummaryBit(dbsrSummaryBit),
                        .enFreezeTimersL2(dbcr0[31]), 
                        .dbcrReset_0(dbcr0[2]), 
                        .dbcrReset_1(dbcr0[3]), 
                        .PCL_exeDvcOrParityHold(PCL_exeDvcOrParityHold));

assign DBG_udeEventSet = dbsr[4];

//Removed the module dp_muxDBG_sprBus

always @(sprBusSel or dbcr0 or dbcr1 or dbsr or EXE_sprDataBus)
  begin: dp_muxDBG_sprBus_PROC
    case (sprBusSel)
      2'b00 : DBG_sprDataBus_i = EXE_sprDataBus;
      2'b01 : DBG_sprDataBus_i = {dbcr0[0:17],13'h0,dbcr0[31]};
      2'b10 : DBG_sprDataBus_i = {dbcr1[0:9],2'h0,dbcr1[12:23],8'h0};
      2'b11 : DBG_sprDataBus_i = {dbsr[0:13],8'h0,dbsr[22:23], 8'h0};
    endcase
  end // dp_muxDBG_sprBus_PROC
  
endmodule
