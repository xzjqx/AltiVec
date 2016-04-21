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
// updated dp_regMMU_UTLBtestLtch c-clock input  KVP 9/29/00
// copied by KVP/WGLee on 10/13/00 from local workspace
// Cobra Change History
// NAME   DATE    DEFECT  DESCRIPTION
// PGM  07/31/01   1785   Remove port size information in module definition
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1
// PGM  09/12/01   1878   Wire BIST outputs out to Core PO's

module p405s_MMU_top( CAR_U0Attr, 
                CAR_cacheable, 
                CAR_endian, 
                CAR_guarded, 
                CAR_writethru, 
                MMU_BMCO, 
                MMU_apuWbEndian, 
                MMU_dcuShadowAbort, 
                MMU_dcuUTLBAbort, 
                MMU_dcuXltValid,
                MMU_diagOut, 
                MMU_dsRA, 
                MMU_dsStateBorC, 
                MMU_dsStatus, 
                MMU_dsocmABus,
                MMU_dsocmCacheable, 
                MMU_dsocmGuarded, 
                MMU_dsocmU0Attr, 
                MMU_dsocmXltValid, 
                MMU_icuDsAbort,
                MMU_icuIsAbort, 
                MMU_isCacheable_NEG, 
                MMU_isDsCacheableL2, 
                MMU_isDsEndianL2,
                MMU_isDsU0AttrL2, 
                MMU_isDsXltValidL2, 
                MMU_isEndian, 
                MMU_isRA_NEG, 
                MMU_isStatus,
                MMU_isU0Attr, 
                MMU_isXltValid, 
                MMU_isocmCacheable, 
                MMU_isocmU0Attr, 
                MMU_isocmXltValid,
                MMU_rdarDsRAL2, 
                MMU_sprData, 
                MMU_tlbSXHit, 
                MMU_wbHold,
                CAR_mmuAttr_E1, 
                CAR_mmuAttr_E2, 
                CB, 
                DCU_CA, 
                EXE_dsEA_NEG, 
                EXE_dsEaCP_NEG,
                EXE_eaARegBuf, 
                EXE_eaBRegBuf, 
                EXE_mmuIcuSprData, 
                EXE_sprAddr,
                ICU_CCR0DDK, 
                ICU_EoOdd, 
                ICU_dsCA, 
                ICU_isCA, 
                ICU_mmuRdarE2, 
                IFB_cntxSync, 
                IFB_exeFlush,
                IFB_fetchReq, 
                IFB_icuCancelData, 
                IFB_isAbort, 
                IFB_isEA, 
                IFB_isNL, 
                IFB_isNP,
                IFB_nonSpecAcc, 
                LSSD_TestM1, 
                LSSD_TestM3, 
                LSSD_coreTestEn,
                MMU_BIST_Scanin, 
                MMU_scanIn, 
                PCL_dcba, 
                PCL_dcbz, 
                PCL_dcuLoad, 
                PCL_dcuOp, 
                PCL_dcuStore,
                PCL_dsMmuOp, 
                PCL_exeStorageOp, 
                PCL_exeTlbOp, 
                PCL_icuOp, 
                PCL_ldNotSt, 
                PCL_mfSPR,
                PCL_mmuExeAbort, 
                PCL_mmuIcuSprHold, 
                PCL_mmuSprDcd, 
                PCL_mtSPR, 
                PCL_tlbRE, 
                PCL_tlbSX,
                PCL_tlbWE, 
                PCL_tlbWS, 
                PCL_wbHoldNonErr, 
                PCL_wbStorageOp, 
                VCT_dcuWbAbort, 
                VCT_dearE2,
                VCT_mmuExeSuppress, 
                VCT_msrDR, 
                VCT_msrIR, 
                VCT_msrPR, 
                resetCore,
                testmode,
                MMU_tlbREParityErr, 
                MMU_tlbSXParityErr, 
                MMU_dsParityErr, 
                MMU_isParityErr, 
                ICU_CCR0PRS,
                BIST_pepsPF, 
                ICU_CCR1TLBE, 
                ICU_CCR0TPE,
                LSSD_EVS, 
                BISTCE0STCLK, 
                BISTCE1ENABLE, 
                LSSD_BISTCClk,
                BIST_Done,
                resetMemBist
                );

output  CAR_U0Attr;
output  CAR_cacheable;
output  CAR_endian;
output  CAR_guarded;
output  CAR_writethru;
output  MMU_BMCO;
output  MMU_apuWbEndian;
output  MMU_dcuShadowAbort;
output  MMU_dcuUTLBAbort;
output  MMU_dcuXltValid;
output  MMU_dsStateBorC;
output  MMU_dsocmCacheable;
output  MMU_dsocmGuarded;
output  MMU_dsocmU0Attr;
output  MMU_dsocmXltValid;
output  MMU_icuDsAbort;
output  MMU_icuIsAbort;
output  MMU_isDsCacheableL2;
output  MMU_isDsEndianL2;
output  MMU_isDsU0AttrL2;
output  MMU_isDsXltValidL2;
output  MMU_isEndian;
output  MMU_isU0Attr;
output  MMU_isXltValid;
output  MMU_isocmCacheable;
output  MMU_isocmU0Attr;
output  MMU_isocmXltValid;
output  MMU_tlbSXHit;
output  MMU_wbHold;
output  MMU_tlbREParityErr;
output  MMU_tlbSXParityErr;
output  MMU_dsParityErr;
output  MMU_isParityErr;
output  BIST_Done;

input  CAR_mmuAttr_E1;
input  CAR_mmuAttr_E2;
input  DCU_CA;
input  ICU_CCR0DDK;
input  ICU_EoOdd;
input  ICU_dsCA;
input  ICU_isCA;
input  ICU_mmuRdarE2;
input  IFB_cntxSync;
input  IFB_exeFlush;
input  IFB_fetchReq;
input  IFB_icuCancelData;
input  IFB_isAbort;
input  IFB_isNL;
input  IFB_isNP;
input  IFB_nonSpecAcc;
input  LSSD_TestM1;
input  LSSD_TestM3;
input  LSSD_coreTestEn;
input  MMU_BIST_Scanin;
input  PCL_dcba;
input  PCL_dcbz;
input  PCL_dcuLoad;
input  PCL_dcuOp;
input  PCL_dcuStore;
input  PCL_exeStorageOp;
input  PCL_exeTlbOp;
input  PCL_icuOp;
input  PCL_ldNotSt;
input  PCL_mfSPR;
input  PCL_mmuExeAbort;
input  PCL_mmuIcuSprHold;
input  PCL_mtSPR;
input  PCL_tlbRE;
input  PCL_tlbSX;
input  PCL_tlbWE;
input  PCL_tlbWS;
input  PCL_wbHoldNonErr;
input  PCL_wbStorageOp;
input  VCT_dcuWbAbort;
input  VCT_dearE2;
input  VCT_mmuExeSuppress;
input  VCT_msrDR;
input  VCT_msrIR;
input  VCT_msrPR;
input  resetCore;
input  testmode;
input  ICU_CCR0PRS;
input  ICU_CCR1TLBE;
input  ICU_CCR0TPE;
input  LSSD_EVS;
input  BISTCE0STCLK;
input  BISTCE1ENABLE;
input  LSSD_BISTCClk;

output [0:1]   MMU_isStatus;
output [0:29]  MMU_dsocmABus;
output [0:2]   MMU_isCacheable_NEG;
output [0:29]  MMU_rdarDsRAL2;
output [0:31]  MMU_sprData;
output [0:2]   MMU_diagOut;
output [0:29]  MMU_isRA_NEG;
output [0:29]  MMU_dsRA;
output [0:7]   MMU_dsStatus;
output [0:2]   BIST_pepsPF;

input [0:8]   PCL_mmuSprDcd;
input [4:9]   EXE_sprAddr;
input [0:21]  EXE_eaARegBuf;
input [0:21]  EXE_eaBRegBuf;
input [0:29]  IFB_isEA;
input [0:7]   EXE_dsEaCP_NEG;
input [0:3]   PCL_dsMmuOp;
input [0:31]  EXE_mmuIcuSprData;
input         CB;
input [0:31]  EXE_dsEA_NEG;
input [0:3]   MMU_scanIn;

output        resetMemBist;    // Sync reset for icu/dcu memory bist

// Buses in the design

wire  [0:21]   isEAL;
wire  [0:6]    UTLB_DSize;
wire  [0:31]   dsEAL;
wire  [0:6]    DSize;
wire  [0:2]    dsAddr;
wire  [0:1]    isAddr;
wire  [0:31]   sprgrp2;
reg   [0:31]   dearL2;
reg   [0:31]   dear_Reg_DataIn;
wire  [0:7]    pidIn_N;
wire  [0:3]    ZSEL;
wire  [0:1]    marZonePR;
wire  [22:29]  dsRAforRedrive;
wire  [0:1]    sprMuxSel;
wire  [0:31]   sprData;
wire  [0:21]   EPN_EA;
wire  [0:21]   marRPN;
wire  [0:6]    BIST_DSize;
wire  [0:7]    pidL2;
reg   [0:7]    pidL2_reg;
wire  [0:31]   symNet527;
wire  [0:31]   symNet535;
reg   [0:31]   iccrL2;
wire  [0:31]   Zone_Dear;
wire  [0:31]   Sgr_Dcwr;
wire  [0:31]   Dccr_Iccr;
wire  [0:31]   sprGrp0;
reg   [0:31]   sgrL2;
reg   [0:31]   sgr_Reg_DataIn;
wire  [0:2]    size_out;
wire  [0:21]   UTLB_EPN;
wire  [0:3]    UTLB_ZSEL;
wire  [0:21]   UTLB_RPN;
wire  [0:1]    DTLB_zonePR;
wire  [0:5]    BIST_addr;
wire  [0:5]    tlbaddr;
wire  [0:21]   RPN;
wire  [0:7]    TID;
wire  [0:7]    UTLB_TID;
wire  [0:21]   BIST_epn_ea;
wire  [0:7]    BIST_TID;
wire  [0:5]    UTLB_index;
wire  [0:21]   bypassRPN;
wire  [0:29]   isEA_NEG;
wire  [0:6]    marDSize;
wire  [0:7]    symNet394;
wire  [22:29]  MMU_isRA;
wire  [0:1]    BIST_data;
reg   [0:31]   slerL2;
wire  [0:16]   SelSprRedrive;
reg   [0:31]   dccrL2;
reg   [0:31]   skrL2;
reg   [0:31]   dcwrL2;
wire  [0:7]    pidData;
reg   [0:31]   zoneL2;
wire  [0:31]   sprgrp1;
wire  [0:31]   datafromSPR;
wire  [0:31]   newRamData;
wire  [0:31]   newTagData;

wire  seldccr_0;
wire  seldccr_1;
wire  seliccr_0;
wire  seliccr_1;
wire  selzone_0;
wire  selzone_1;
wire  selpid_0;
wire  selsgr_0;
wire  selsgr_1;
wire  seldcwr_0;
wire  seldcwr_1;
wire  seldear_0;
wire  seldear_1;
wire  selsler_0;
wire  selsler_1;
wire  selskr_0;
wire  selskr_1;
wire  mfSPR_N0;
wire  mfSPR_N1;
wire  mfSPR_N2;
wire  symNet400;
wire  symNet402;
wire  symNet404;
wire  symNet412;
wire  symNet414;
wire  symNet392;

wire  EN_C1;
wire  EN_ARRAYL1;

wire  clockGate;
wire  sysClkToUTLB;
wire  TestM1toUTLB;
wire  symNet932;

wire  seldccr;
wire  seliccr;
wire  selzone;
wire  selpid;
wire  selsgr;
wire  seldcwr;
wire  selsler;
wire  selskr;
wire  seldear;
wire  CAR_XltValid;
wire  dataEn;
wire  tagEn;
wire  rdWrb;
wire  indexLookupb;
wire  tlb_invalidate;
wire  dearE1;
wire  dearE2;

reg  resetL2;
reg  UTLBobs;

reg [0:31] MMU_sprData;

wire  CAR_U0Attr_i;
wire  CAR_cacheable_i;
wire  CAR_guarded_i;
wire  MMU_dcuXltValid_i;
wire  MMU_isU0Attr_i;
wire  MMU_isXltValid_i;
wire  MMU_tlbREParityErr_i;
wire  MMU_tlbSXParityErr_i;
wire  MMU_dsParityErr_i;
wire  MMU_isParityErr_i;
wire [0:2]   MMU_isCacheable_NEG_i;
wire [0:29]  MMU_dsRA_i;

// To fix implicit wire LEDA issues
wire  ABIST_test;
wire  BIST_DT;
wire  BIST_V;
wire  BIST_invalidate;
wire  BIST_lookupEn;
wire  BIST_rdEn;
wire  BIST_wrEn;
wire  DVS;
wire  LSSD_ArrayCClk_buf;
wire  LSSD_TestM3_buf;
wire  UTLB_Miss;
wire  dataComp;
wire  tagComp;
wire  UTLB_CacheInhibit;
wire  UTLB_DT;
wire  UTLB_E;
wire  UTLB_EX;
wire  UTLB_G;
wire  UTLB_M;
wire  UTLB_U0;
wire  UTLB_V;
wire  UTLB_W;
wire  UTLB_WR;
wire  TestComp;
wire  DT;
wire  EX;
wire  WR;
wire  tlbCacheInhibit;
wire  tlbE;
wire  tlbG;
wire  tlbM;
wire  tlbU0;
wire  tlbV;
wire  tlbW;
wire  tagPar1;
wire  tagPar2;
wire  tagPar3;
wire  tagPar4;
wire  ramPar1;
wire  ramPar2;
wire  UTLB_T1;
wire  UTLB_T2;
wire  UTLB_T3;
wire  UTLB_T4;
wire  UTLB_R1;
wire  UTLB_R2;
wire  msrIrL2;
wire  LoadRealRaAttr;
wire  msrDrL2forDTLB;
wire  marE;
wire  marU0;
wire  marWR;
wire  marW;
wire  marG;
wire  marCacheable;
wire  sprRegE2;
wire  iccrE1;
wire  dccrE1;
wire  sgrE1;
wire  slerE1;
wire  skrE1;
wire  pidE1;
wire  pidE2;
wire  zoneE1;
wire  dcwrE1;
wire  dsStateA;
wire  dsStateD;
wire  dsrdNotWrt;
wire  dsInvalidate;
wire  isInvalidate;
wire  CompE2;
wire  isIReal_N;
wire  isDsIReal_N;
wire  isU0Real_N;
wire  dsGReal_N;
wire  dsEReal_N;
wire  wtReqReal_N;
wire  isrdNotWrt;
wire  isEReal_N;
wire  dsIReal_N;
wire  dsU0Real_N;
wire  dtlbMiss;
wire  DTLB_WR;
wire  DTLB_U0;
wire  DTLB_I;
wire  DTLB_W;
wire  itlbMiss;
wire  EN_ARRAYL1_preTestM3;


  // Assign the outputs from internal wires
  assign CAR_U0Attr = CAR_U0Attr_i;
  assign CAR_cacheable = CAR_cacheable_i;
  assign CAR_guarded = CAR_guarded_i;
  assign MMU_dcuXltValid = MMU_dcuXltValid_i;
  assign MMU_isU0Attr = MMU_isU0Attr_i;
  assign MMU_isXltValid = MMU_isXltValid_i;
  assign MMU_tlbREParityErr = MMU_tlbREParityErr_i;
  assign MMU_tlbSXParityErr = MMU_tlbSXParityErr_i;
  assign MMU_dsParityErr = MMU_dsParityErr_i;
  assign MMU_isParityErr = MMU_isParityErr_i;
  assign MMU_isCacheable_NEG = MMU_isCacheable_NEG_i;
  assign MMU_dsRA = MMU_dsRA_i;


  // Removed the module "dp_logMMU_sprRedrive1"
  assign {seldccr_0, seldccr_1, seliccr_0,seliccr_1, selzone_0, selzone_1, selpid_0, 
          selsgr_0, selsgr_1, seldcwr_0, seldcwr_1,selsler_0, selsler_1, selskr_0, selskr_1, 
          seldear_0, seldear_1} = ~(SelSprRedrive[0:16]);

  // Removed the module "dp_logMMU_sprRedrive0"
  assign SelSprRedrive[0:16] = ~({seldccr, seldccr, seliccr, seliccr, selzone, selzone,
                                 selpid, selsgr, selsgr, seldcwr, seldcwr, selsler, selsler, 
                                 selskr, selskr, seldear,seldear});

  // Removed the module "dp_regMMU_UTLBtestLtch"
  always @(posedge CB)
    begin
      UTLBobs <= symNet932;
    end

  assign symNet932 = indexLookupb | rdWrb | tagEn | dataEn;

  // Removed the module "dp_logMMU_OCMInv1" 6 instances
  assign symNet412 = ~(CAR_XltValid);
  assign symNet400 = ~(MMU_isU0Attr_i);
  assign symNet404 = ~(CAR_guarded_i);
  assign symNet414 = ~(MMU_isXltValid_i);
  assign symNet392 = ~(CAR_U0Attr_i);
  assign symNet402 = ~(CAR_cacheable_i);

  // Removed the module "dp_logMMU_dsRAredrive" 2 instances
  assign symNet394[0:7] = ~(dsRAforRedrive[22:29]);
  assign MMU_dsRA_i[22:29] = ~(symNet394[0:7]);

  // Removed the module "dp_logMMU_isEAinv"
  assign isEA_NEG[0:29] = ~(IFB_isEA[0:29]);

  // Removed the module "dp_logMMU_OCMInv" 7 instances
  assign MMU_isocmCacheable = ~(MMU_isCacheable_NEG_i[0]);
  assign MMU_dsocmU0Attr = ~(symNet392);
  assign MMU_dsocmCacheable = ~(symNet402);
  assign MMU_dsocmGuarded = ~(symNet404);
  assign MMU_dsocmXltValid = ~(symNet412);
  assign MMU_isocmXltValid = ~(symNet414);
  assign MMU_isocmU0Attr = ~(symNet400);

  // Removed the module "dp_regMMU_isWord0RAinv"
  assign MMU_isRA_NEG[22:29] = ~(MMU_isRA[22:29]);

  // Removed the module "dp_logMMU_buffAClk"

  // Removed the module "dp_logMMU_mfSPRnot"
  assign {mfSPR_N0, mfSPR_N1,mfSPR_N2} = ~({PCL_mfSPR, PCL_mfSPR, PCL_mfSPR});

  // Removed the module "dp_logMMU_RAbuffer"
  assign MMU_dsocmABus[0:29] = ~(EXE_dsEA_NEG[0:29]);

  // Removed the module "mmuclkBuf"
  // Removed the module "dp_logMMU_clkInv"
  // Removed the module "dp_logMMU_clkBuf"


p405s_mmu_BIST_Unit
 ABIST_CBIST( .ABIST_test         (ABIST_test), 
                       .BIST_DSize         (BIST_DSize[0:6]), 
                       .BIST_DT            (BIST_DT), 
                       .BIST_TID           (BIST_TID[0:7]), 
                       .BIST_V             (BIST_V),
                       .BIST_addr          (BIST_addr[0:5]), 
                       .BIST_data          (BIST_data[0:1]), 
                       .BIST_epn_ea        (BIST_epn_ea[0:21]), 
                       .BIST_invalidate    (BIST_invalidate), 
                       .BIST_lookupEn      (BIST_lookupEn),
                       .BIST_rdEn          (BIST_rdEn), 
                       .BIST_wrEn          (BIST_wrEn), 
                       .MMU_diagOut        (MMU_diagOut[0:1]), 
                       .cbistError         (MMU_diagOut[2]), 
                       .DVS                (DVS),
                       .LSSD_ArrayCClk_buf (LSSD_ArrayCClk_buf),
                       .LSSD_TestM3_buf    (LSSD_TestM3_buf),
                       .BIST_Done          (BIST_Done),
                       .CB                 (CB), 
                       .resetL2            (resetL2),
                       .LSSD_TestM1        (LSSD_TestM1), 
                       .UTLB_Miss          (UTLB_Miss),
                       .BISTCE0STCLK       (BISTCE0STCLK), 
                       .BISTCE1ENABLE      (BISTCE1ENABLE),
                       .LSSD_BISTCClk      (LSSD_BISTCClk),
                       .UTLB_index         (UTLB_index[0:5]), 
                       .dataComp           (dataComp), 
                       .tagComp            (tagComp), 
                       .cbistErrL2         (BIST_pepsPF[0]),
                       .dataErrL2          (BIST_pepsPF[1]),
                       .tagErrL2           (BIST_pepsPF[2]),
                       .LSSD_EVS           (LSSD_EVS), 
                       .LSSD_TestM3        (LSSD_TestM3)
                       );

p405s_UTLB
 unified_TLB( .UTLB_CacheInhibit (UTLB_CacheInhibit), 
                  .UTLB_DSize        (UTLB_DSize[0:6]), 
                  .UTLB_DT           (UTLB_DT), 
                  .UTLB_E            (UTLB_E), 
                  .UTLB_EPN          (UTLB_EPN[0:21]),
                  .UTLB_EX           (UTLB_EX), 
                  .UTLB_G            (UTLB_G), 
                  .UTLB_M            (UTLB_M), 
                  .UTLB_RPN          (UTLB_RPN[0:21]), 
                  .UTLB_TID          (UTLB_TID[0:7]), 
                  .UTLB_U0           (UTLB_U0), 
                  .UTLB_V            (UTLB_V), 
                  .UTLB_W            (UTLB_W), 
                  .UTLB_WR           (UTLB_WR),
                  .UTLB_ZSEL         (UTLB_ZSEL[0:3]), 
                  .UTLB_index        (UTLB_index[0:5]), 
                  .UTLB_miss         (UTLB_Miss), 
                  .dataComp          (dataComp), 
                  .tagComp           (tagComp),
                  .EN_C1             (EN_C1), 
                  .DSize             (DSize[0:6]), 
                  .DT                (DT), 
                  .EPN_EA            (EPN_EA[0:21]), 
                  .EX                (EX), 
                  .RPN               (RPN[0:21]), 
                  .TID               (TID[0:7]),
                  .TestM1            (TestM1toUTLB), 
                  .TestComp          (TestComp), 
                  .WR                (WR), 
                  .ZSEL              (ZSEL[0:3]), 
                  .EN_ARRAYL1        (EN_ARRAYL1), 
                  .dataEn            (dataEn), 
                  .indexLookupb      (indexLookupb),
                  .rdWrb             (rdWrb), 
                  .tagEn             (tagEn), 
                  .tlbCacheInhibit   (tlbCacheInhibit),
                  .tlbE              (tlbE), 
                  .tlbG              (tlbG), 
                  .tlbM              (tlbM), 
                  .tlbU0             (tlbU0), 
                  .tlbV              (tlbV), 
                  .tlbW              (tlbW), 
                  .tlb_invalidate    (tlb_invalidate), 
                  .tlbaddr           (tlbaddr[0:5]), 
                  .CB                (CB),
                  .tagPar1           (tagPar1), 
                  .tagPar2           (tagPar2), 
                  .tagPar3           (tagPar3), 
                  .tagPar4           (tagPar4), 
                  .ramPar1           (ramPar1), 
                  .ramPar2           (ramPar2),
                  .UTLB_T1           (UTLB_T1), 
                  .UTLB_T2           (UTLB_T2), 
                  .UTLB_T3           (UTLB_T3), 
                  .UTLB_T4           (UTLB_T4), 
                  .UTLB_R1           (UTLB_R1), 
                  .UTLB_R2           (UTLB_R2), 
                  .DVS               (DVS)
                  );

  assign  clockGate = BISTCE0STCLK & BISTCE1ENABLE;
  assign  sysClkToUTLB = clockGate | CB;
  assign  TestM1toUTLB =  LSSD_TestM1 & ~BISTCE1ENABLE;

  // Removed the module "CLKSPELPC_S_RTP"

  // Removed the module "dp_logMMU_NOR2_2"
  assign sprData[0:31] = ~( datafromSPR[0:31] | {{10{mfSPR_N0}},{11{mfSPR_N1}},
                                                 {11{mfSPR_N2}}} );

  // Removed the module "dp_regMMU_reset"
  always @(posedge CB)      
    begin                                       
      resetL2 <= resetCore;          
    end                           

  assign resetMemBist = ~testmode ? resetL2 : resetCore;    // Sync reset for icu/dcu memory bist

  // Removed the module "dp_logMMU_NOR"
  assign datafromSPR[0:31] = ~( sprGrp0[0:31] | sprgrp1[0:31] | sprgrp2[0:31] );

  // Removed the module "dp_logMMU_NAND2_4"
  assign sprGrp0[0:31] = ~( symNet535[0:31] & Sgr_Dcwr[0:31] );

  // Removed the module "dp_logMMU_NAND2_6"
  assign sprgrp2[0:31] = ~( Zone_Dear[0:31] & {{24{1'b1}},pidData[0:7]} );

  // Removed the module "dp_logMMU_NAND2_5"
  assign sprgrp1[0:31] = ~( symNet527[0:31] & Dccr_Iccr[0:31] );

  // Removed the module "dp_logMMU_NAND2_3"
  assign symNet527[0:31] = ~( skrL2[0:31] & {{16{selskr_0}}, {16{selskr_1}}}); 

  // Removed the module "dp_logMMU_NAND2_2"
  assign symNet535[0:31] = ~( {{16{selsler_0}}, {16{selsler_1}}} & slerL2[0:31] );

  // Removed the module "dp_logMMU_NAND2_1"
  assign pidData[0:7] = ~( {8{selpid_0}} & pidL2[0:7] );

  // Removed the module "dp_regMMU_dear"
  // 2-1 Mux input to register         
  always @(EXE_mmuIcuSprData or dsEAL or VCT_dearE2)        
    begin                                       
      casez(VCT_dearE2)                    
        1'b0: dear_Reg_DataIn = EXE_mmuIcuSprData[0:31];   
        1'b1: dear_Reg_DataIn = dsEAL[0:31];   
        default: dear_Reg_DataIn = 32'bx;  
      endcase                             
    end                                  

  always @(posedge CB)      
    begin                                       
      casez(dearE1 & dearE2)                
        1'b0: dearL2[0:31] <= dearL2[0:31];                
        1'b1: dearL2[0:31] <= dear_Reg_DataIn;       
        default: dearL2[0:31] <= 32'bx;  
      endcase                             
    end                                  

  // Removed the module "dp_logMMU_AOI22_4"
  assign Zone_Dear[0:31] = ~( ({{16{selzone_0}},{16{selzone_1}}}  & zoneL2[0:31]) |
                              ({{16{seldear_0}},{16{seldear_1}}} & dearL2[0:31]) );

  // Removed the module "dp_logMMU_AOI22_3"
  assign Dccr_Iccr[0:31] = ~( ({{16{seldccr_0}},{16{seldccr_1}}} & dccrL2[0:31]) | 
                              ({{16{seliccr_0}},{16{seliccr_1}}} & iccrL2[0:31]) );

  // Removed the module "dp_logMMU_AOI22_1"
  assign Sgr_Dcwr[0:31] = ~( ({{16{selsgr_0}},{16{selsgr_1}}} & sgrL2[0:31]) |
                             ({{16{seldcwr_0}},{16{seldcwr_1}}} & dcwrL2[0:31]) );

p405s_mmu_control
 MMU_Control( .MMU_isStatus         (MMU_isStatus[0:1]), 
                         .MMU_isXltValid       (MMU_isXltValid_i), 
                         .MMU_icuDsAbort       (MMU_icuDsAbort), 
                         .MMU_isRA             (MMU_isRA[22:29]),
                         .msrIrL2forITLB       (msrIrL2), 
                         .LoadRealRaAttr       (LoadRealRaAttr), 
                         .MMU_dsStatus         (MMU_dsStatus[0:7]), 
                         .MMU_dcuXltValid      (MMU_dcuXltValid_i), 
                         .MMU_dcuUTLBAbort     (MMU_dcuUTLBAbort),
                         .MMU_dcuShadowAbort   (MMU_dcuShadowAbort), 
                         .MMU_dsRA             (dsRAforRedrive[22:29]), 
                         .MMU_wbHold           (MMU_wbHold), 
                         .MMU_tlbSXHit         (MMU_tlbSXHit), 
                         .MMU_dsStateBorC      (MMU_dsStateBorC),
                         .msrDrL2forDTLB       (msrDrL2forDTLB), 
                         .MMU_icuIsAbort       (MMU_icuIsAbort), 
                         .marRPN               (marRPN[0:21]), 
                         .marDSize             (marDSize[0:6]), 
                         .marE                 (marE), 
                         .marU0                (marU0), 
                         .marWR                (marWR), 
                         .marW                 (marW),
                         .marG                 (marG), 
                         .marCacheable         (marCacheable), 
                         .marZonePR            (marZonePR[0:1]), 
                         .sprRegE2             (sprRegE2), 
                         .iccrE1               (iccrE1), 
                         .dccrE1               (dccrE1), 
                         .sgrE1                (sgrE1), 
                         .slerE1               (slerE1), 
                         .skrE1                (skrE1), 
                         .pidE1                (pidE1),
                         .pidE2                (pidE2),
                         .zoneE1               (zoneE1),
                         .dcwrE1               (dcwrE1),
                         .seldccr              (seldccr),
                         .seliccr              (seliccr),
                         .selzone              (selzone),
                         .selpid               (selpid),
                         .selsgr               (selsgr),
                         .dearE1               (dearE1),
                         .dearE2               (dearE2),
                         .seldcwr              (seldcwr),
                         .selsler              (selsler),
                         .selskr               (selskr),
                         .seldear              (seldear),
                         .MMU_BMCO             (MMU_BMCO),
                         .pidIn_N              (pidIn_N[0:7]),
                         .size_out             (size_out[0:2]),
                         .sprMuxSel            (sprMuxSel[0:1]),
                         .wbStorageOp          (PCL_wbStorageOp),
                         .bypassRPN            (bypassRPN[0:21]),
                         .dsStateAfromLatch    (dsStateA),
                         .dsStateD             (dsStateD),
                         .dsAddrL2             (dsAddr[0:2]),
                         .dsrdNotWrt           (dsrdNotWrt),
                         .dsEAL                (dsEAL[0:31]),
                         .dsInvalidate         (dsInvalidate),
                         .isAddrL2             (isAddr[0:1]),
                         .isInvalidate         (isInvalidate),
                         .isrdNotWrt           (isrdNotWrt),
                         .isEAL                (isEAL[0:21]),
                         .CompE2               (CompE2),
                         .tlbAddr              (tlbaddr[0:5]),
                         .tagEn                (tagEn),
                         .dataEn               (dataEn),
                         .rdWrb                (rdWrb),
                         .indexLookupb         (indexLookupb),
                         .EN_ARRAYL1           (EN_ARRAYL1),
                         .TestComp             (TestComp),
                         .EN_C1                (EN_C1),
                         .tlb_invalidate       (tlb_invalidate),
                         .tlbE                 (tlbE),
                         .tlbU0                (tlbU0),
                         .DT                   (DT),
                         .TID                  (TID[0:7]),
                         .EPN_EA               (EPN_EA[0:21]),
                         .DSIZE                (DSize[0:6]),
                         .RPN                  (RPN[0:21]),
                         .tlbV                 (tlbV),
                         .EX                   (EX),
                         .WR                   (WR),
                         .ZSEL                 (ZSEL[0:3]),
                         .tlbW                 (tlbW),
                         .tlbCacheInhibit      (tlbCacheInhibit),
                         .tlbM                 (tlbM),
                         .tlbG                 (tlbG),
                         .isIReal_N            (isIReal_N),
                         .isDsIReal_N          (isDsIReal_N),
                         .isEReal_N            (isEReal_N),
                         .isU0Real_N           (isU0Real_N),
                         .dsIReal_N            (dsIReal_N),
                         .dsGReal_N            (dsGReal_N),
                         .dsEReal_N            (dsEReal_N),
                         .dsU0Real_N           (dsU0Real_N),
                         .wtReqReal_N          (wtReqReal_N),
                         .fetchReq             (IFB_fetchReq),
                         .isEA_NEG             (isEA_NEG[0:29]),
                         .nonSpecAcc           (IFB_nonSpecAcc),
                         .isAbort              (IFB_isAbort),
                         .cntxSync             (IFB_cntxSync),
                         .msrIR                (VCT_msrIR),
                         .isNP                 (IFB_isNP),
                         .isCA                 (ICU_isCA),
                         .EoOdd                (ICU_EoOdd),
                         .CancelData           (IFB_icuCancelData),
                         .icuOp                (PCL_icuOp),
                         .isNewLine            (IFB_isNL),
                         .msrPR                (VCT_msrPR),
                         .msrDR                (VCT_msrDR),
                         .LdNotSt              (PCL_ldNotSt),
                         .wbAbort              (VCT_dcuWbAbort),
                         .dcuOp                (PCL_dcuOp),
                         .dsMmuOp              (PCL_dsMmuOp[0:3]),
                         .dsEA_N               (EXE_dsEA_NEG[0:31]),
                         .ICU_dsCA             (ICU_dsCA),
                         .DCU_CA               (DCU_CA),
                         .cdbcrFDK             (ICU_CCR0DDK),
                         .dcuLoad              (PCL_dcuLoad),
                         .dcuStore             (PCL_dcuStore),
                         .dcbz                 (PCL_dcbz),
                         .dcba                 (PCL_dcba),
                         .VCT_mmuExeSuppress   (VCT_mmuExeSuppress),
                         .IFB_exeFlush         (IFB_exeFlush),
                         .PCL_mmuExeAbort      (PCL_mmuExeAbort),
                         .tlbSX                (PCL_tlbSX),
                         .tlbWE                (PCL_tlbWE),
                         .tlbRE                (PCL_tlbRE),
                         .tlbWC                (PCL_tlbWS),
                         .exeTlbOp             (PCL_exeTlbOp),
                         .sprAddr              (EXE_sprAddr[4:9]),
                         .SprDcd               (PCL_mmuSprDcd[0:8]),
                         .sprData              (EXE_mmuIcuSprData[0:31]),
                         .mtSPR                (PCL_mtSPR),
                         .mfSPR                (PCL_mfSPR),
                         .sprHold              (PCL_mmuIcuSprHold),
                         .VCT_dearE2           (VCT_dearE2),
                         .iccrL2               (iccrL2[0:31]),
                         .dccrL2               (dccrL2[0:31]),
                         .dcwrL2               (dcwrL2[0:31]),
                         .slerL2               (slerL2[0:31]),
                         .skrL2                (skrL2[0:31]),
                         .sgrL2                (sgrL2[0:31]),
                         .pidL2                (pidL2[0:7]),
                         .zoneL2               (zoneL2[0:31]),
                         .UTLB_DSize           (UTLB_DSize[0:6]),
                         .UTLB_EPN             (UTLB_EPN[0:21]),
                         .UTLB_V               (UTLB_V),
                         .UTLB_E               (UTLB_E),
                         .UTLB_U0              (UTLB_U0),
                         .UTLB_TID             (UTLB_TID[0:7]),
                         .UTLB_Miss            (UTLB_Miss),
                         .UTLB_RPN             (UTLB_RPN[0:21]),
                         .UTLB_EX              (UTLB_EX),
                         .UTLB_WR              (UTLB_WR),
                         .UTLB_ZSEL            (UTLB_ZSEL[0:3]),
                         .UTLB_W               (UTLB_W),
                         .UTLB_CacheInhibit    (UTLB_CacheInhibit),
                         .UTLB_G               (UTLB_G),
                         .dtlbMiss             (dtlbMiss),
                         .DTLB_zonePR          (DTLB_zonePR[0:1]),
                         .DTLB_WR              (DTLB_WR),
                         .DTLB_U0              (DTLB_U0),
                         .DTLB_I               (DTLB_I),
                         .DTLB_W               (DTLB_W),
                         .itlbMiss             (itlbMiss),
                         .PCL_wbHoldnonErr     (PCL_wbHoldNonErr),
                         .exeStorageOp         (PCL_exeStorageOp),
                         .resetL2              (resetL2),
                         .CB                   (CB),
                         .TestM1               (LSSD_TestM1),
                         .TestM3               (LSSD_TestM3_buf),
                         .LSSD_ArrayCClk_buf   (LSSD_ArrayCClk_buf),
                         .BIST_wrEn            (BIST_wrEn),
                         .BIST_rdEn            (BIST_rdEn),
                         .BIST_addr            (BIST_addr[0:5]),
                         .BIST_lookupEn        (BIST_lookupEn),
                         .BIST_epn_ea          (BIST_epn_ea[0:21]),
                         .BIST_DSize           (BIST_DSize[0:6]),
                         .BIST_TID             (BIST_TID[0:7]),
                         .BIST_data            (BIST_data[0:1]),
                         .BIST_DT              (BIST_DT),
                         .BIST_V               (BIST_V),
                         .BIST_invalidate      (BIST_invalidate),
                         .ABIST_test           (ABIST_test),
                         .EN_ARRAYL1_preTestM3 (EN_ARRAYL1_preTestM3),
                         .UTLB_DT              (UTLB_DT),
                         .MMU_tlbREParityErr   (MMU_tlbREParityErr_i),
                         .MMU_tlbSXParityErr   (MMU_tlbSXParityErr_i),
                         .MMU_dsParityErr      (MMU_dsParityErr_i),
                         .MMU_isParityErr      (MMU_isParityErr_i),
                         .tagPar1              (tagPar1),
                         .tagPar2              (tagPar2),
                         .tagPar3              (tagPar3),
                         .tagPar4              (tagPar4),
                         .ramPar1              (ramPar1),
                         .ramPar2              (ramPar2),
                         .UTLB_T1              (UTLB_T1),
                         .UTLB_T2              (UTLB_T2),
                         .UTLB_T3              (UTLB_T3),
                         .UTLB_T4              (UTLB_T4),
                         .UTLB_R1              (UTLB_R1),
                         .UTLB_R2              (UTLB_R2),
                         .UTLB_M               (UTLB_M),
                         .ICU_CCR1TLBE         (ICU_CCR1TLBE),
                         .ICU_CCR0TPE          (ICU_CCR0TPE)
                         );

  // Removed the module "dp_muxMMU_spr2Mux"
  assign newTagData[0:31] = ({UTLB_EPN[0:21],
                         size_out[0:2],UTLB_V,UTLB_E,UTLB_U0,1'b0,1'b0, 
                             1'b0,1'b0} & {32{~(ICU_CCR0PRS)}} ) | ({UTLB_T1, UTLB_T2, UTLB_T3, 
                             UTLB_T4,{28{1'b0}}} & {32{ICU_CCR0PRS}} );

  // Removed the module "dp_muxMMU_spr3Mux"
  assign newRamData[0:31] = ({UTLB_RPN[0:21], UTLB_EX, UTLB_WR, UTLB_ZSEL[0:3], UTLB_W,
                             UTLB_CacheInhibit, UTLB_M, UTLB_G} & {32{~(ICU_CCR0PRS)}} ) | 
                             ({UTLB_R1, UTLB_R2, {30{1'b0}}} & {32{ICU_CCR0PRS}} );

  // Removed the module "dp_muxMMU_sprMux"
  always @(sprMuxSel or sprData or newTagData or newRamData or 
           UTLB_index) 
    begin                                           
      case(sprMuxSel[0:1])                     
        2'b00: MMU_sprData[0:31] = sprData[0:31];    
        2'b01: MMU_sprData[0:31] = newTagData[0:31];    
        2'b10: MMU_sprData[0:31] = newRamData[0:31];    
        2'b11: MMU_sprData[0:31] = {{26{1'b0}},UTLB_index[0:5]};
        default: MMU_sprData[0:31] = 32'bx;   
      endcase                                    
    end                                       

  // Removed the module "dp_regMMU_dcwr" 
  always @(posedge CB)      
    begin                                       
      casez(dcwrE1 & sprRegE2)                
        1'b0: dcwrL2[0:31] <= dcwrL2[0:31];                
        1'b1: dcwrL2[0:31] <= EXE_mmuIcuSprData[0:31];            
        default: dcwrL2[0:31] <= 32'bx;  
      endcase                             
    end                                  

  // Removed the module "dp_regMMU_zone"
  always @(posedge CB)
    begin
      casez(zoneE1 & sprRegE2)
        1'b0: zoneL2[0:31] <= zoneL2[0:31];
        1'b1: zoneL2[0:31] <= EXE_mmuIcuSprData[0:31];
        default: zoneL2[0:31] <= 32'bx;
      endcase
    end

  // Removed the module "dp_regMMU_sler"
  always @(posedge CB)
    begin
      casez(slerE1 & sprRegE2)
        1'b0: slerL2[0:31] <= slerL2[0:31];
        1'b1: slerL2[0:31] <= EXE_mmuIcuSprData[0:31];
        default: slerL2[0:31] <= 32'bx;
      endcase
    end

  // Removed the module "dp_regMMU_skr"
  always @(posedge CB)
    begin
      casez(skrE1 & sprRegE2)
        1'b0: skrL2[0:31] <= skrL2[0:31];
        1'b1: skrL2[0:31] <= EXE_mmuIcuSprData[0:31];
        default: skrL2[0:31] <= 32'bx;
      endcase
    end

  // Removed the module "dp_regMMU_sgr"
  // 2-1 Mux input to register
  always @(EXE_mmuIcuSprData or resetL2)
    begin
      casez(resetL2)
        1'b0: sgr_Reg_DataIn = EXE_mmuIcuSprData[0:31];
        1'b1: sgr_Reg_DataIn = {32{1'b1}};
        default: sgr_Reg_DataIn = 32'bx;
      endcase
    end

  always @(posedge CB)
    begin
      casez(sgrE1 & sprRegE2)
        1'b0: sgrL2[0:31] <= sgrL2[0:31];
        1'b1: sgrL2[0:31] <= sgr_Reg_DataIn;
        default: sgrL2[0:31] <= 32'bx;
      endcase
    end

  // Removed the module "dp_regMMU_pid"
  always @(posedge CB)
    begin
      casez(pidE1 & pidE2)
        1'b0: pidL2_reg[0:7] <= pidL2_reg[0:7];
        1'b1: pidL2_reg[0:7] <= pidIn_N[0:7];
        default: pidL2_reg[0:7] <= 8'bx;
      endcase
    end

  assign pidL2[0:7] = ~(pidL2_reg[0:7]);

  // Removed the module "dp_regMMU_iccr"
  always @(posedge CB)
    begin
      casez(iccrE1 & sprRegE2)
        1'b0: iccrL2[0:31] <= iccrL2[0:31];
        1'b1: iccrL2[0:31] <= EXE_mmuIcuSprData[0:31];
        default: iccrL2[0:31] <= 32'bx;
      endcase
    end

  // Removed the module "dp_regMMU_dccr"
  always @(posedge CB)
    begin
      casez(dccrE1 & sprRegE2)
        1'b0: dccrL2[16:31] <= dccrL2[16:31];
        1'b1: dccrL2[16:31] <= EXE_mmuIcuSprData[16:31];
        default: dccrL2[16:31] <= 16'bx;
      endcase
    end

  // Removed the module "dp_regMMU_dccr"
  always @(posedge CB)
    begin
      casez(dccrE1 & sprRegE2)
        1'b0: dccrL2[0:15] <= dccrL2[0:15];
        1'b1: dccrL2[0:15] <= EXE_mmuIcuSprData[0:15];
        default: dccrL2[0:15] <= 16'bx;
      endcase
    end

p405s_ITLB
 I_Side_Shadow( .ITLB_E         (MMU_isEndian), 
                    .ITLB_I_NEG     (MMU_isCacheable_NEG_i[0:2]), 
                    .ITLB_U0        (MMU_isU0Attr_i),
                    .isRA_NEG       (MMU_isRA_NEG[0:21]), 
                    .itlbMiss       (itlbMiss), 
                    .CB             (CB), 
                    .CompE2         (CompE2),
                    .DSize          (marDSize[0:6]), 
                    .E              (marE), 
                    .I              (marCacheable), 
                    .LoadRealRaAttr (LoadRealRaAttr), 
                    .RPN            (marRPN[0:21]), 
                    .U0             (marU0),
                    .VCT_msrIR      (VCT_msrIR), 
                    .isAbort        (IFB_isAbort), 
                    .isAddr         (isAddr[0:1]), 
                    .isEA_NEG        (isEA_NEG[0:21]), 
                    .isEPN          (isEAL[0:21]), 
                    .isEReal_N      (isEReal_N), 
                    .isIReal_N      (isIReal_N),
                    .isInvalidate   (isInvalidate), 
                    .isU0Real_N     (isU0Real_N), 
                    .isrdNotWrt     (isrdNotWrt), 
                    .msrIrL2        (msrIrL2)
                    );

p405s_DTLB
 D_Side_Shadow( .CAR_Endian      (CAR_endian), 
                    .CAR_U0Attr      (CAR_U0Attr_i), 
                    .CAR_XltValid    (CAR_XltValid), 
                    .CAR_cacheable   (CAR_cacheable_i), 
                    .CAR_guarded     (CAR_guarded_i),
                    .CAR_writethru   (CAR_writethru), 
                    .DTLB_I          (DTLB_I), 
                    .DTLB_U0         (DTLB_U0), 
                    .DTLB_W          (DTLB_W), 
                    .DTLB_WR         (DTLB_WR), 
                    .DTLB_zonePR     (DTLB_zonePR[0:1]), 
                    .MMU_apuWbEndian (MMU_apuWbEndian),
                    .MMU_rdarDsRAL2  (MMU_rdarDsRAL2[0:29]), 
                    .dsRA            (MMU_dsRA_i[0:21]), 
                    .dtlbMiss        (dtlbMiss), 
                    .isDsCacheableL2 (MMU_isDsCacheableL2),
                    .isDsEndianL2    (MMU_isDsEndianL2), 
                    .isDsU0AttrL2    (MMU_isDsU0AttrL2), 
                    .isDsXltValidL2  (MMU_isDsXltValidL2),
                    .CAR_mmuAttr_E1  (CAR_mmuAttr_E1), 
                    .CAR_mmuAttr_E2  (CAR_mmuAttr_E2), 
                    .CB              (CB),
                    .DSize           (marDSize[0:6]), 
                    .E               (marE), 
                    .EXE_dsEaCP_NEG  (EXE_dsEaCP_NEG[0:7]), 
                    .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]), 
                    .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]), 
                    .G               (marG),
                    .I               (marCacheable), 
                    .ICU_mmuRdarE2   (ICU_mmuRdarE2), 
                    .LSSD_coreTestEn (LSSD_coreTestEn), 
                    .MMU_dsRA        (MMU_dsRA_i[22:29]), 
                    .RPN             (marRPN[0:21]),
                    .U0              (marU0), 
                    .W               (marW), 
                    .WR              (marWR), 
                    .bypassRPN       (bypassRPN[0:21]), 
                    .dsAddr          (dsAddr[0:2]), 
                    .dsEA_NEG        (EXE_dsEA_NEG[0:21]), 
                    .dsEPN           (dsEAL[0:21]),
                    .dsEReal_N       (dsEReal_N), 
                    .dsGReal_N       (dsGReal_N), 
                    .dsIReal_N       (dsIReal_N), 
                    .dsInvalidate    (dsInvalidate), 
                    .dsStateA        (dsStateA), 
                    .dsStateD        (dsStateD), 
                    .dsU0Real_N      (dsU0Real_N),
                    .dsXltValid      (MMU_dcuXltValid_i), 
                    .dsrdNotWrt      (dsrdNotWrt), 
                    .isDsIReal_N     (isDsIReal_N), 
                    .msrDR           (msrDrL2forDTLB), 
                    .wtReqReal_N     (wtReqReal_N), 
                    .zonePR          (marZonePR[0:1])
                    );


// synopsys translate_off
// Making assertions for violated assumptions
`ifdef TLB_MONITORS_OFF
`else
always@(posedge CB)
begin
  if(MMU_tlbREParityErr_i == 1'b1 || MMU_tlbSXParityErr_i == 1'b1 || MMU_dsParityErr_i == 1'b1 || MMU_isParityErr_i == 1'b1)
  begin
       $display("ERROR: Unexpected parity error from the MMU!");
    #5 $finish;
  end
end
`endif
always@(posedge CB)
begin
  if(MMU_tlbREParityErr_i == 1'b1 && MMU_tlbSXParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_tlbREParityErr_i == 1'b1 && MMU_dsParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_tlbREParityErr_i == 1'b1 && MMU_isParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_tlbSXParityErr_i == 1'b1 && MMU_dsParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_tlbSXParityErr_i == 1'b1 && MMU_isParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_isParityErr_i == 1'b1 && MMU_dsParityErr_i == 1'b1)
  begin
       $display("ERROR: Impossible double parity error from the MMU!");
    #5 $finish;
  end
end
always@(posedge CB)
begin
  if(MMU_dsParityErr_i == 1'b1 && VCT_msrDR == 1'b0)
  begin
       $display("ERROR: Impossible parity error from the MMU! msrDR is off");
    #5 $finish;
  end
end
// synopsys translate_on

endmodule
