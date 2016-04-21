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
module p405s_cacheMMU( CAR_cacheable,
                       CAR_endian,
                       DCU_ABus,
                       DCU_CA,
                       DCU_DA,
                       DCU_DBus,
                       DCU_RNW,
                       DCU_SCL2,
                       DCU_SDQ_mod,
                       C405_lssdDiagBistDone,
                       DCU_abort,
                       DCU_apuWbByteEn,
                       DCU_cacheable,
                       DCU_carByteEn,
                       DCU_dTags,
                       DCU_data_NEG,
                       DCU_diagBus,
//                       DCU_diagOut,
                       DCU_firstCycCarStXltV,
                       DCU_guarded,
                       DCU_kompress,
                       DCU_ocmAbort,
                       DCU_ocmData,
                       DCU_ocmLoadReq,
                       DCU_ocmStoreReq,
                       DCU_ocmWait,
                       DCU_parityError,
                       DCU_FlushParityError,
                       DCU_pclOcmWait,
                       DCU_plbPriority,
                       DCU_request,
                       DCU_sleepReq,
                       DCU_tranSize,
                       DCU_writeThru,
                       ICU_ABus,
                       ICU_EO,
                       ICU_GPRC,
                       ICU_LDBE,
                       ICU_abort,
                       ICU_cacheable,
                       ICU_diagBus,
                       ICU_dsCA,
                       ICU_ifbError,
                       ICU_isBus,
                       ICU_isCA,
                       ICU_ocmIcuReady,
                       ICU_ocmReqPending,
                       ICU_parityErrE,
                       ICU_parityErrO,
                       ICU_tagParityErr,
                       ICU_CCR0DPP,
                       ICU_CCR0DPE,
                       ICU_CCR0IPE,
                       ICU_CCR0TPE,
                       ICU_plbPriority,
                       ICU_plbU0Attr,
                       ICU_request,
                       ICU_sleepReq,
                       ICU_sprData,
                       ICU_syncAfterReset,
                       ICU_traceEnable,
                       ICU_tranSize,
                       LSSD_cacheMMUScanOut,
                       MMU_BMCO,
                       MMU_apuWbEndian,
                       MMU_dsStateBorC,
                       MMU_dsStatus,
                       MMU_dsocmABus,
                       MMU_dsocmCacheable,
                       MMU_dsocmGuarded,
                       MMU_dsocmU0Attr,
                       MMU_dsocmXltValid,
                       MMU_isStatus,
                       MMU_isocmCacheable,
                       MMU_isocmU0Attr,
                       MMU_isocmXltValid,
                       MMU_sprData,
                       MMU_tlbSXHit,
                       MMU_wbHold,
                       CB,
                       EXE_dcuData,
                       MMU_tlbREParityErr,
                       MMU_tlbSXParityErr,
                       MMU_dsParityErr,
                       MMU_isParityErr,
                       EXE_dsEA_NEG,
                       EXE_dsEaCP,
                       EXE_eaARegBuf,
                       EXE_eaBRegBuf,
                       EXE_icuSprDcds,
                       EXE_mmuIcuSprData,
                       EXE_sprAddr,
                       IFB_cntxSync,
                       IFB_exeFlush,
                       IFB_fetchReq,
                       IFB_icuCancelData,
                       IFB_isAbortForICU,
                       IFB_isAbortForMMU,
                       IFB_isEA,
                       IFB_isNL,
                       IFB_isNP,
                       IFB_ldNotSt,
                       IFB_nonSpecAcc,
                       JTG_iCacheWr,
                       JTG_instBuf,
                       LSSD_bistCClk,
                       LSSD_cacheMMUScanIn,
                       LSSD_coreTestEn,
                       LSSD_testM1,
                       LSSD_testM3,
                       OCM_dsComplete,
                       OCM_dsHold,
                       OCM_isDATA,
                       OCM_isDValid,
                       OCM_isHold,
                       PCL_dcuByteEn,
                       PCL_dcuOp,
                       PCL_dcuOp_early,
                       PCL_dsMmuOp,
                       PCL_exeAbort,
                       PCL_exeStorageOp,
                       PCL_exeTlbOp,
                       PCL_icuOp,
                       PCL_mfSPR,
                       PCL_mmuExeAbort,
                       PCL_mmuIcuSprHold,
                       PCL_mmuSprDcd,
                       PCL_mtSPR,
                       PCL_stSteerCntl,
                       PCL_tlbRE,
                       PCL_tlbSX,
                       PCL_tlbWE,
                       PCL_tlbWS,
                       PCL_wbHoldNonErr,
                       PCL_wbStorageOp,
                       PLB_dcuAddrAck,
                       PLB_dcuBusy,
                       PLB_dcuRdDAck,
                       PLB_dcuRdDBus,
                       PLB_dcuRdWdAddr,
                       PLB_dcuSsize,
                       PLB_dcuWrDAck,
                       PLB_icuAddrAck,
                       PLB_icuBusy,
                       PLB_icuDBus,
                       PLB_icuError,
                       PLB_icuRdDAck,
                       PLB_icuRdWrAddr,
                       PLB_sSize,
                       PLB_sampleCycle,
                       VCT_dcuWbAbort,
                       VCT_dearE2,
                       VCT_icuWbAbort,
                       VCT_mmuExeSuppress,
                       VCT_mmuWbAbort,
                       VCT_msrDR,
                       VCT_msrIR,
                       VCT_msrPR,
                       resetCore,
//                       BIST_sysPF,
                       BIST_pepsPF,
                       LSSD_c405CE0EVS,
//                       LSSD_c405BistCE0LBist,
                       LSSD_c405BistCE0StClk,
                       LSSD_c405BistCE1Enable,
//                       LSSD_c405BistCE1PG1,
                       PLB_sampleCycleAlt,
                       CPM_c405SyncBypass,
                       testmode,
                       dcu_bist_debug_si,
                       dcu_bist_debug_so,
                       dcu_bist_debug_en,
                       dcu_bist_mode_reg_in,
                       dcu_bist_mode_reg_out,
                       dcu_bist_parallel_dr,
                       dcu_bist_mode_reg_si,
                       dcu_bist_mode_reg_so,
                       dcu_bist_shift_dr,
                       dcu_bist_mbrun,
                       icu_bist_debug_si,
                       icu_bist_debug_so,
                       icu_bist_debug_en,
                       icu_bist_mode_reg_in,
                       icu_bist_mode_reg_out,
                       icu_bist_parallel_dr,
                       icu_bist_mode_reg_si,
                       icu_bist_mode_reg_so,
                       icu_bist_shift_dr,
                       icu_bist_mbrun
                     );


output  CAR_cacheable;
output  CAR_endian;
output  DCU_CA;
output  DCU_DA;
output  DCU_RNW;
output  DCU_SCL2;
output  C405_lssdDiagBistDone;
output  DCU_abort;
output  DCU_cacheable;
//output  DCU_diagOut;
output  DCU_firstCycCarStXltV;
output  DCU_guarded;
output  DCU_kompress;
output  DCU_ocmAbort;
output  DCU_ocmLoadReq;
output  DCU_ocmStoreReq;
output  DCU_ocmWait;
output  DCU_parityError;
output  DCU_FlushParityError;
output  DCU_pclOcmWait;
output  DCU_request;
output  DCU_sleepReq;
output  DCU_tranSize;
output  DCU_writeThru;
output  ICU_GPRC;
output  ICU_LDBE;
output  ICU_abort;
output  ICU_cacheable;
output  ICU_dsCA;
output  ICU_parityErrE;
output  ICU_parityErrO;
output  ICU_tagParityErr;
output  ICU_CCR0DPP;
output  ICU_CCR0DPE;
output  ICU_CCR0IPE;
output  ICU_CCR0TPE;
output  ICU_isCA;
output  ICU_ocmIcuReady;
output  ICU_ocmReqPending;
output  ICU_plbU0Attr;
output  ICU_request;
output  ICU_sleepReq;
output  ICU_syncAfterReset;
output  ICU_traceEnable;
output  MMU_BMCO;
output  MMU_apuWbEndian;
output  MMU_dsStateBorC;
output  MMU_dsocmCacheable;
output  MMU_dsocmGuarded;
output  MMU_dsocmU0Attr;
output  MMU_dsocmXltValid;
output  MMU_tlbREParityErr;
output  MMU_tlbSXParityErr;
output  MMU_dsParityErr;
output  MMU_isParityErr;
output  MMU_isocmCacheable;
output  MMU_isocmU0Attr;
output  MMU_isocmXltValid;
output  MMU_tlbSXHit;
output  MMU_wbHold;

input  IFB_cntxSync;
input  IFB_exeFlush;
input  IFB_fetchReq;
input  IFB_icuCancelData;
input  IFB_isAbortForMMU;
input  IFB_isNL;
input  IFB_isNP;
input  IFB_ldNotSt;
input  IFB_nonSpecAcc;
input  JTG_iCacheWr;
input  LSSD_bistCClk;
input  LSSD_coreTestEn;
input  LSSD_testM1;
input  LSSD_testM3;
input  OCM_dsComplete;
input  OCM_dsHold;
input  OCM_isHold;
input  PCL_exeAbort;
input  PCL_exeStorageOp;
input  PCL_exeTlbOp;
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
input  PLB_dcuAddrAck;
input  PLB_dcuBusy;
input  PLB_dcuRdDAck;
input  PLB_dcuSsize;
input  PLB_dcuWrDAck;
input  PLB_icuAddrAck;
input  PLB_icuBusy;
input  PLB_icuError;
input  PLB_icuRdDAck;
input  PLB_sSize;
input  PLB_sampleCycle;
input  VCT_dcuWbAbort;
input  VCT_dearE2;
input  VCT_icuWbAbort;
input  VCT_mmuExeSuppress;
input  VCT_mmuWbAbort;
input  VCT_msrDR;
input  VCT_msrIR;
input  VCT_msrPR;
input  resetCore;

input  LSSD_c405CE0EVS;
//input  LSSD_c405BistCE0LBist;
input  LSSD_c405BistCE0StClk;
input  LSSD_c405BistCE1Enable;
//input  LSSD_c405BistCE1PG1;

// added for tbird
input PLB_sampleCycleAlt;
input CPM_c405SyncBypass;

output [0:3]  DCU_apuWbByteEn;
output [0:7]  MMU_dsStatus;
output [0:22]  ICU_diagBus;
output [0:31]  DCU_SDQ_mod;
output [0:31]  ICU_sprData;
output [0:31]  DCU_ABus;
output [0:29]  MMU_dsocmABus;
output [0:63]  DCU_DBus;
output [0:1]  ICU_plbPriority;
output [2:3]  ICU_tranSize;
output [0:31]  MMU_sprData;
output [0:29]  ICU_ABus;
output [0:1]  MMU_isStatus;
output [0:7]  DCU_dTags;
output [0:1]  ICU_EO;
output [0:63]  ICU_isBus;
output [0:1]  ICU_ifbError;
output [0:9]  LSSD_cacheMMUScanOut;
output [0:20]  DCU_diagBus;
output [0:3]  DCU_carByteEn;
output [0:31]  DCU_data_NEG;
output [0:1]  DCU_plbPriority;
output [0:31]  DCU_ocmData;
//output [0:7]  BIST_sysPF;
output [0:2]  BIST_pepsPF;

input [0:21]  EXE_eaARegBuf;
input [0:31]  EXE_dcuData;
input [0:63]  OCM_isDATA;
input [0:1]  OCM_isDValid;
input [4:9]  EXE_sprAddr;
input        CB;
input [0:2]  PLB_dcuRdWdAddr;
input [0:2]  PCL_dcuOp_early;
input [0:8]  PCL_mmuSprDcd;
input [0:31]  EXE_dsEA_NEG;
input [0:29]  IFB_isEA;
input [0:63]  PLB_dcuRdDBus;
input [0:2]  IFB_isAbortForICU;
input [0:7]  EXE_dsEaCP;
input [1:3]  PLB_icuRdWrAddr;
input [0:3]  PCL_icuOp;
input [0:9]  PCL_stSteerCntl;
input [0:31]  EXE_mmuIcuSprData;
input [0:11]  PCL_dcuOp;
input [0:2]  EXE_icuSprDcds;
input [0:9]  LSSD_cacheMMUScanIn;
input [0:63]  PLB_icuDBus;
input [0:31]  JTG_instBuf;
input [0:21]  EXE_eaBRegBuf;
input [0:3]  PCL_dsMmuOp;
input [0:3]  PCL_dcuByteEn;

// BIST IO

input         testmode;
input         dcu_bist_mbrun;
input  [3:0]  dcu_bist_debug_si;
input  [3:0]  dcu_bist_debug_en;
output [3:0]  dcu_bist_debug_so;

input   dcu_bist_shift_dr;
input   dcu_bist_mode_reg_si;
output  dcu_bist_mode_reg_so;

input          dcu_bist_parallel_dr;
input  [18:0]  dcu_bist_mode_reg_in;
output [18:0]  dcu_bist_mode_reg_out;

input         icu_bist_mbrun;
input  [3:0]  icu_bist_debug_si;
input  [3:0]  icu_bist_debug_en;
output [3:0]  icu_bist_debug_so;

input   icu_bist_shift_dr;
input   icu_bist_mode_reg_si;
output  icu_bist_mode_reg_so;

input          icu_bist_parallel_dr;
input  [18:0]  icu_bist_mode_reg_in;
output [18:0]  icu_bist_mode_reg_out;


// Buses in the design
wire  [0:25]  DCU_icuMI;
wire  [0:11]  ICU_dcuCCR0_L2;
wire  [0:29]  MMU_isRA_NEG;
wire  [0:2]  MMU_isCacheable_NEG;
wire  [0:29]  MMU_dsRA;
wire  [0:2]  DCU_icuSize;
wire  [0:2]  MMU_diagOut;
wire  [0:29]  MMU_rdarDsRAL2;

wire MMU_bistDone;
wire DCU_abDone;
wire p405s_MMU_top;

wire resetMemBist;  // Sync reset for icu/dcu memory bists

//Removed the module 'AND2_J' 
assign C405_lssdDiagBistDone = MMU_bistDone;

p405s_MMU_top
 mmu_topSch(
        .CAR_U0Attr(                        CAR_U0Attr),
        .CAR_cacheable(                     CAR_cacheable),
        .CAR_endian(                        CAR_endian),
        .CAR_guarded(                       CAR_guarded),
        .CAR_writethru(                     MMU_dsWritethru),
        .MMU_BMCO(                          MMU_BMCO),
        .MMU_apuWbEndian(                   MMU_apuWbEndian),
        .MMU_dcuShadowAbort(                MMU_dcuShadowAbort),
        .MMU_dcuUTLBAbort(                  MMU_dcuUTLBAbort),
        .MMU_dcuXltValid(                   MMU_dcuXltValid),
        .MMU_diagOut(                       MMU_diagOut[0:2]),
        .MMU_dsRA(                          MMU_dsRA[0:29]),
        .MMU_dsStateBorC(                   MMU_dsStateBorC),
        .MMU_dsStatus(                      MMU_dsStatus[0:7]),
        .MMU_dsocmABus(                     MMU_dsocmABus[0:29]),
        .MMU_dsocmCacheable(                MMU_dsocmCacheable),
        .MMU_dsocmGuarded(                  MMU_dsocmGuarded),
        .MMU_dsocmU0Attr(                   MMU_dsocmU0Attr),
        .MMU_dsocmXltValid(                 MMU_dsocmXltValid),
        .MMU_icuDsAbort(                    MMU_icuDsAbort),
        .MMU_icuIsAbort(                    MMU_icuIsAbort),
        .MMU_isCacheable_NEG(               MMU_isCacheable_NEG[0:2]),
        .MMU_isDsCacheableL2(               MMU_isDsCacheableL2),
        .MMU_isDsEndianL2(                  MMU_isDsEndianL2),
        .MMU_isDsU0AttrL2(                  MMU_isDsU0AttrL2),
        .MMU_isDsXltValidL2(                MMU_isDsXltValidL2),
        .MMU_isEndian(                      MMU_isEndian),
        .MMU_isRA_NEG(                      MMU_isRA_NEG[0:29]),
        .MMU_isStatus(                      MMU_isStatus[0:1]),
        .MMU_isU0Attr(                      MMU_isU0Attr),
        .MMU_isXltValid(                    MMU_isXltValid),
        .MMU_isocmCacheable(                MMU_isocmCacheable),
        .MMU_isocmU0Attr(                   MMU_isocmU0Attr),
        .MMU_isocmXltValid(                 MMU_isocmXltValid),
        .MMU_rdarDsRAL2(                    MMU_rdarDsRAL2[0:29]),
        .MMU_sprData(                       MMU_sprData[0:31]),
        .MMU_tlbSXHit(                      MMU_tlbSXHit),
        .MMU_tlbREParityErr(                MMU_tlbREParityErr),
        .MMU_tlbSXParityErr(                MMU_tlbSXParityErr),
        .MMU_dsParityErr(                   MMU_dsParityErr),
        .MMU_isParityErr(                   MMU_isParityErr),
        .MMU_wbHold(                        MMU_wbHold),
        .CAR_mmuAttr_E1(                    CAR_mmuAttr_E1),
        .CAR_mmuAttr_E2(                    CAR_mmuAttr_E2),
        .CB(                                CB),
        .DCU_CA(                            DCU_CA),
        .EXE_dsEA_NEG(                      EXE_dsEA_NEG[0:31]),
        .EXE_dsEaCP_NEG(                    EXE_dsEaCP[0:7]),
        .EXE_eaARegBuf(                     EXE_eaARegBuf[0:21]),
        .EXE_eaBRegBuf(                     EXE_eaBRegBuf[0:21]),
        .EXE_mmuIcuSprData(                 EXE_mmuIcuSprData[0:31]),
        .EXE_sprAddr(                       EXE_sprAddr[4:9]),
        .ICU_CCR0DDK(                       ICU_CCR0DDK),
        .ICU_CCR0PRS(                       ICU_dcuCCR0_L2[11]),
        .ICU_CCR1TLBE(                      ICU_CCR1TLBE),
        .ICU_CCR0TPE(                       ICU_CCR0TPE),
        .ICU_EoOdd(                         ICU_mmuEoOdd),
        .ICU_dsCA(                          ICU_dsCA),
        .ICU_isCA(                          ICU_isCA),
        .ICU_mmuRdarE2(                     ICU_mmuRdarE1),
        .IFB_cntxSync(                      IFB_cntxSync),
        .IFB_exeFlush(                      IFB_exeFlush),
        .IFB_fetchReq(                      IFB_fetchReq),
        .IFB_icuCancelData(                 IFB_icuCancelData),
        .IFB_isAbort(                       IFB_isAbortForMMU),
        .IFB_isEA(                          IFB_isEA[0:29]),
        .IFB_isNL(                          IFB_isNL),
        .IFB_isNP(                          IFB_isNP),
        .IFB_nonSpecAcc(                    IFB_nonSpecAcc),
        .LSSD_TestM1(                       LSSD_testM1),
        .LSSD_TestM3(                       LSSD_testM3),
        .LSSD_coreTestEn(                   LSSD_coreTestEn),
        .MMU_BIST_Scanin(                   LSSD_cacheMMUScanIn[0]),
        .PCL_dcba(                          PCL_dcuOp[5]),
        .PCL_dcbz(                          PCL_dcuOp[4]),
        .PCL_dcuLoad(                       PCL_dcuOp[1]),
        .PCL_dcuOp(                         PCL_dcuOp[0]),
        .PCL_dcuStore(                      PCL_dcuOp[2]),
        .PCL_dsMmuOp(                       PCL_dsMmuOp[0:3]),
        .PCL_exeStorageOp(                  PCL_exeStorageOp),
        .PCL_exeTlbOp(                      PCL_exeTlbOp),
        .PCL_icuOp(                         PCL_icuOp[0]),
        .PCL_ldNotSt(                       IFB_ldNotSt),
        .PCL_mfSPR(                         PCL_mfSPR),
        .PCL_mmuExeAbort(                   PCL_mmuExeAbort),
        .PCL_mmuIcuSprHold(                 PCL_mmuIcuSprHold),
        .PCL_mmuSprDcd(                     PCL_mmuSprDcd[0:8]),
        .PCL_mtSPR(                         PCL_mtSPR),
        .PCL_tlbRE(                         PCL_tlbRE),
        .PCL_tlbSX(                         PCL_tlbSX),
        .PCL_tlbWE(                         PCL_tlbWE),
        .PCL_tlbWS(                         PCL_tlbWS),
        .PCL_wbHoldNonErr(                  PCL_wbHoldNonErr),
        .PCL_wbStorageOp(                   PCL_wbStorageOp),
        .VCT_dcuWbAbort(                    VCT_mmuWbAbort),
        .VCT_dearE2(                        VCT_dearE2),
        .VCT_mmuExeSuppress(                VCT_mmuExeSuppress),
        .VCT_msrDR(                         VCT_msrDR),
        .VCT_msrIR(                         VCT_msrIR),
        .VCT_msrPR(                         VCT_msrPR),
        .BIST_pepsPF(                       BIST_pepsPF[0:2]),
        .resetCore(                         resetCore),
        .testmode(                          testmode),
        .LSSD_EVS(                          LSSD_c405CE0EVS),
        .BISTCE0STCLK(                      LSSD_c405BistCE0StClk),
        .BISTCE1ENABLE(                     LSSD_c405BistCE1Enable),
        .LSSD_BISTCClk(                     LSSD_bistCClk),
        .BIST_Done(                         MMU_bistDone),
        .resetMemBist(                      resetMemBist)
        );

p405s_icu_top
 icu_topSch(
        .DCU_plbPriorityBit1(               DCU_plbPriority[0]),
        .ICU_ABus(                          ICU_ABus[0:29]),
        .ICU_CCR0DDK(                       ICU_CCR0DDK),
        .ICU_EO(                            ICU_EO[0:1]),
        .ICU_GPRC(                          ICU_GPRC),
        .ICU_LDBE(                          ICU_LDBE),
        .ICU_U0Attr(                        ICU_plbU0Attr),
        .ICU_abort(                         ICU_abort),
        .ICU_cacheable(                     ICU_cacheable),
        .ICU_dcuCCR0_L2(                    ICU_dcuCCR0_L2[0:11]),
        .ICU_diagBus(                       ICU_diagBus[0:22]),
//       .ICU_dcuDataA_PF(                   ICU_dcuDataA_PF),
//       .ICU_dcuDataB_PF(                   ICU_dcuDataB_PF),
//       .ICU_dcuTag_PF(                     ICU_dcuTag_PF),
//       .ICU_dcuParity_PF(                  ICU_dcuParity_PF),
//       .ICU_diagOutDataA(                  ICU_diagOutDataA),
//       .ICU_diagOutDataB(                  ICU_diagOutDataB),
//       .ICU_diagOutTag(                    ICU_diagOutTag),
//       .ICU_diagOutParity(                 ICU_diagOutParity),
//        .DCU_icuMI(                         DCU_icuMI[0:25]),
        .ICU_dsCA(                          ICU_dsCA),
        .ICU_ifbError(                      ICU_ifbError[0:1]),
        .ICU_isBus(                         ICU_isBus[0:63]),
        .ICU_isCA(                          ICU_isCA),
        .ICU_mmuEoOdd(                      ICU_mmuEoOdd),
        .ICU_mmuRdarE2(                     ICU_mmuRdarE1),
        .ICU_ocmIcuReady(                   ICU_ocmIcuReady),
        .ICU_ocmReqPending(                 ICU_ocmReqPending),
        .ICU_parityErrE(                    ICU_parityErrE),
        .ICU_parityErrO(                    ICU_parityErrO),
        .ICU_tagParityErr(                  ICU_tagParityErr),
        .ICU_CCR0DPP(                       ICU_CCR0DPP),
        .ICU_CCR0DPE(                       ICU_CCR0DPE),
        .ICU_CCR0IPE(                       ICU_CCR0IPE),
        .ICU_CCR0TPE(                       ICU_CCR0TPE),
        .ICU_CCR1DCTE(                      ICU_CCR1DCTE),
        .ICU_CCR1DCDE(                      ICU_CCR1DCDE),
        .ICU_CCR1TLBE(                      ICU_CCR1TLBE),
        .ICU_plbPriority(                   ICU_plbPriority[0:1]),
        .ICU_request(                       ICU_request),
        .ICU_sleepReq(                      ICU_sleepReq),
        .ICU_sprData(                       ICU_sprData[0:31]),
        .ICU_syncAfterReset(                ICU_syncAfterReset),
        .ICU_traceEnable(                   ICU_traceEnable),
        .ICU_tranSize(                      ICU_tranSize[2:3]),
        .CB(                                CB),
        .DCU_icuSize(                       DCU_icuSize[0:2]),
        .EXE_dsEA_NEG(                      EXE_dsEA_NEG[0:29]),
        .EXE_icuSprDcds(                    EXE_icuSprDcds[0:2]),
        .EXE_sprData(                       EXE_mmuIcuSprData[0:31]),
        .IFB_cntxSync(                      IFB_cntxSync),
        .IFB_fetchReq(                      IFB_fetchReq),
        .IFB_icuCancelData(                 IFB_icuCancelData),
        .IFB_isAbort(                       IFB_isAbortForICU[0:2]),
        .IFB_isEA(                          IFB_isEA[0:29]),
        .IFB_isNL(                          IFB_isNL),
        .JTG_iCacheWr_NEG(                  JTG_iCacheWr),
        .JTG_inst(                          JTG_instBuf[0:31]),
        .MMU_dsEndianL2(                    MMU_isDsEndianL2),
        .MMU_dsU0AttrL2(                    MMU_isDsU0AttrL2),
        .MMU_icuDsAbort(                    MMU_icuDsAbort),
        .MMU_icuIsAbort(                    MMU_icuIsAbort),
        .MMU_isCacheableNEG(                MMU_isCacheable_NEG[0:2]),
        .MMU_isDsCacheableL2(               MMU_isDsCacheableL2),
        .MMU_isDsXltValidL2(                MMU_isDsXltValidL2),
        .MMU_isEndian(                      MMU_isEndian),
        .MMU_isRANEG(                       MMU_isRA_NEG[0:29]),
        .MMU_isU0Attr(                      MMU_isU0Attr),
        .MMU_isXltValid(                    MMU_isXltValid),
        .MMU_rdarDsRAL2(                    MMU_rdarDsRAL2[0:29]),
        .OCM_isDATA(                        OCM_isDATA[0:63]),
        .OCM_isDValid(                      OCM_isDValid[0:1]),
        .OCM_isHold(                        OCM_isHold),
        .PCL_icuOp(                         PCL_icuOp[0:3]),
        .PCL_mfSPR(                         PCL_mfSPR),
        .PCL_mtSPR(                         PCL_mtSPR),
        .PCL_sprHold(                       PCL_mmuIcuSprHold),
        .PLB_dcuBusy(                       PLB_dcuBusy),
        .PLB_icuAddrAck(                    PLB_icuAddrAck),
        .PLB_icuBusy(                       PLB_icuBusy),
        .PLB_icuDBus(                       PLB_icuDBus[0:63]),
        .PLB_icuError(                      PLB_icuError),
        .PLB_icuRdDAck(                     PLB_icuRdDAck),
        .PLB_icuRdWdAddr(                   PLB_icuRdWrAddr[1:3]),
        .PLB_sSize(                         PLB_sSize),
        .PLB_sampleCycle(                   PLB_sampleCycle),
        .VCT_exeAbort(                      PCL_exeAbort),
        .VCT_icuWbAbort(                    VCT_icuWbAbort),
        .resetCoreIn(                       resetCore),
        .testEn(                            LSSD_coreTestEn),
        .VCT_msrIR(                         VCT_msrIR),
        .PLB_sampleCycleAlt(                PLB_sampleCycleAlt),
        .CPM_c405SyncBypass(                CPM_c405SyncBypass),
        .icu_bist_debug_si(                 icu_bist_debug_si),
        .icu_bist_debug_so(                 icu_bist_debug_so),
        .icu_bist_debug_en(                 icu_bist_debug_en),
        .icu_bist_mode_reg_in(              icu_bist_mode_reg_in),
        .icu_bist_mode_reg_out(             icu_bist_mode_reg_out),
        .icu_bist_parallel_dr(              icu_bist_parallel_dr),
        .icu_bist_mode_reg_si(              icu_bist_mode_reg_si),
        .icu_bist_mode_reg_so(              icu_bist_mode_reg_so),
        .icu_bist_shift_dr(                 icu_bist_shift_dr),
        .icu_bist_mbrun(                    icu_bist_mbrun),
        .resetMemBist(                      resetMemBist)
        );

p405s_dcu_top
 dcu_topSch(
        .CAR_mmuAttr_E1(                    CAR_mmuAttr_E1),
        .CAR_mmuAttr_E2(                    CAR_mmuAttr_E2),
        .DCU_CA(                            DCU_CA),
        .DCU_DA(                            DCU_DA),
        .DCU_SCL2(                          DCU_SCL2),
        .DCU_SDQ_mod_NEG(                   DCU_SDQ_mod[0:31]),
//        .DCU_abDone(                        DCU_abDone),
        .DCU_apuWbByteEn(                   DCU_apuWbByteEn[0:3]),
        .DCU_carByteEn(                     DCU_carByteEn[0:3]),
        .DCU_data_NEG(                      DCU_data_NEG[0:31]),
        .DCU_diagBus(                       DCU_diagBus[0:20]),
//        .DCU_diagOut(                       DCU_diagOut),
        .DCU_firstCycCarStXltV(             DCU_firstCycCarStXltV),
//        .DCU_icuMI(                         DCU_icuMI[0:25]),
        .DCU_icuSize(                       DCU_icuSize[0:2]),
        .DCU_ocmAbort(                      DCU_ocmAbort),
        .DCU_ocmData(                       DCU_ocmData[0:31]),
        .DCU_ocmLoadReq(                    DCU_ocmLoadReq),
        .DCU_ocmStoreReq(                   DCU_ocmStoreReq),
        .DCU_ocmWait(                       DCU_ocmWait),
        .DCU_parityError(                   DCU_parityError),
        .DCU_FlushParityError(              DCU_FlushParityError),
        .DCU_pclOcmLdPendNoWait(            DCU_pclOcmWait),
        .DCU_plbABus(                       DCU_ABus[0:31]),
        .DCU_plbAbort(                      DCU_abort),
        .DCU_plbCacheable(                  DCU_cacheable),
        .DCU_plbDBus(                       DCU_DBus[0:63]),
        .DCU_plbDTags(                      DCU_dTags[0:7]),
        .DCU_plbGuarded(                    DCU_guarded),
        .DCU_plbPriority(                   DCU_plbPriority[1]),
        .DCU_plbRNW(                        DCU_RNW),
        .DCU_plbRequest(                    DCU_request),
        .DCU_plbTranSize(                   DCU_tranSize),
        .DCU_plbU0Attr(                     DCU_kompress),
        .DCU_plbWriteThru(                  DCU_writeThru),
//        .DCU_scanOut1(                      LSSD_cacheMMUScanOut[4]),
//        .DCU_scanOut2(                      LSSD_cacheMMUScanOut[5]),
//        .DCU_scanOut3(                      LSSD_cacheMMUScanOut[6]),
        .DCU_sleepReq(                      DCU_sleepReq),
        .CAR_U0Attr(                        CAR_U0Attr),
        .CAR_cacheable(                     CAR_cacheable),
        .CAR_endian(                        CAR_endian),
        .CAR_guarded(                       CAR_guarded),
        .CAR_writethru(                     MMU_dsWritethru),

//TCB FIX THIS!!!
//        .CB(                                {CB,CB,CB,CB,CB}),
        .CB(                                CB),

//        .DCU_scanIn1(                       LSSD_cacheMMUScanIn[4]),
//        .DCU_scanIn2(                       LSSD_cacheMMUScanIn[5]),
//        .DCU_scanIn3(                       LSSD_cacheMMUScanIn[6]),
        .EXE_dcuData(                       EXE_dcuData[0:31]),
        .ICU_dcuCCR0_L2(                    ICU_dcuCCR0_L2[0:11]),
        .ICU_CCR1DCTE(                      ICU_CCR1DCTE),
        .ICU_CCR1DCDE(                      ICU_CCR1DCDE),
//        .ICU_dcuDataA_PF(                   ICU_dcuDataA_PF),
//        .ICU_dcuDataB_PF(                   ICU_dcuDataB_PF),
//        .ICU_dcuTag_PF(                     ICU_dcuTag_PF),
//        .ICU_dcuParity_PF(                  ICU_dcuParity_PF),
//        .ICU_diagOutDataA(                  ICU_diagOutDataA),
//        .ICU_diagOutDataB(                  ICU_diagOutDataB),
//        .ICU_diagOutTag(                    ICU_diagOutTag),
//        .ICU_diagOutParity(                 ICU_diagOutParity),
        .ICU_syncAfterReset(                ICU_syncAfterReset),
 //       .LSSD_bistCClk(                     LSSD_bistCClk),
//        .LSSD_testM1(                       LSSD_testM1),
//        .LSSD_testM3(                       LSSD_testM3),
        .MMU_dcuShadowAbort(                MMU_dcuShadowAbort),
        .MMU_dcuUTLBAbort(                  MMU_dcuUTLBAbort),
        .MMU_dcuXltValid(                   MMU_dcuXltValid),
        .MMU_diagOut(                       MMU_diagOut[0:2]),
        .MMU_dsRA(                          MMU_dsRA[0:29]),
        .MMU_wbHold(                        MMU_wbHold),
        .OCM_dsComplete(                    OCM_dsComplete),
        .OCM_dsHold(                        OCM_dsHold),
        .PCL_dcuByteEn(                     PCL_dcuByteEn[0:3]),
        .PCL_dcuOp(                         PCL_dcuOp[0:11]),
        .PCL_dcuOp_early(                   PCL_dcuOp_early[0:2]),
        .PCL_stSteerCntl(                   PCL_stSteerCntl[0:9]),
        .PLB_dcuAddrAck(                    PLB_dcuAddrAck),
        .PLB_dcuBusy(                       PLB_dcuBusy),
        .PLB_dcuRdDAck(                     PLB_dcuRdDAck),
        .PLB_dcuRdDBus(                     PLB_dcuRdDBus[0:63]),
        .PLB_dcuRdWdAddr(                   PLB_dcuRdWdAddr[0:2]),
        .PLB_dcuSsize(                      PLB_dcuSsize),
        .PLB_dcuWrDAck(                     PLB_dcuWrDAck),
        .PLB_sampleCycle(                   PLB_sampleCycle),
        .VCT_exeAbort(                      PCL_exeAbort),
        .VCT_wbAbort(                       VCT_dcuWbAbort),
        .resetCore(                         resetCore),
        .testEn(                            LSSD_coreTestEn),
        .PLB_sampleCycleAlt(                PLB_sampleCycleAlt),
        .CPM_c405SyncBypass(                CPM_c405SyncBypass),
        .dcu_bist_debug_si(                 dcu_bist_debug_si),
        .dcu_bist_debug_so(                 dcu_bist_debug_so),
        .dcu_bist_debug_en(                 dcu_bist_debug_en),
        .dcu_bist_mode_reg_in(              dcu_bist_mode_reg_in),
        .dcu_bist_mode_reg_out(             dcu_bist_mode_reg_out),
        .dcu_bist_parallel_dr(              dcu_bist_parallel_dr),
        .dcu_bist_mode_reg_si(              dcu_bist_mode_reg_si),
        .dcu_bist_mode_reg_so(              dcu_bist_mode_reg_so),
        .dcu_bist_shift_dr(                 dcu_bist_shift_dr),
        .dcu_bist_mbrun(                    dcu_bist_mbrun),
        .resetMemBist(                      resetMemBist)
        );

endmodule
