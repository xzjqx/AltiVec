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
module p405s_core_top( C405_jtgCaptureDR,
                       C405_jtgExtest,
                       C405_jtgPgmOut,
                       C405_jtgShiftDR,
                       C405_jtgTDO,
                       C405_jtgTDOEn,
                       C405_jtgUpdateDR,
                       C405_lssdDiagBistDone,
//                       C405_lssdDiagOut,
                       C405_rstChipResetReq,
                       C405_rstCoreResetReq,
                       C405_rstSystemResetReq,
                       CPU_TEType,
                       DCS_plbABus,
                       DCS_plbWrDBus,
                       DCS_plbPriority,
                       DCS_plbRNW,
                       DCS_plbAbort,
                       DCU_apuWbByteEn,
                       DCS_plbCacheable,
                       DCS_plbBE,
                       DCS_plbGuarded,
                       DCS_plbU0Attr,
                       DCU_ocmAbort,
                       DCU_ocmAbortReq,
                       DCU_ocmData,
                       DCU_ocmLoadReq,
                       DCU_ocmStoreReq,
                       DCU_ocmWait,
                       DCS_plbRequest,
                       DCS_plbSize2,
                       DCS_plbWriteThru,
                       EXE_apuLoadData,
                       EXE_dcrAddr,
                       EXE_dcrDataBus,
                       EXE_raData,
                       EXE_rbData,
                       EXE_xerCa,
                       ICS_plbABus,
                       ICS_plbPriority,
                       ICS_plbAbort,
                       ICS_plbCacheable,
                       ICU_ocmIcuReady,
                       ICU_ocmReqPending,
                       ICS_plbU0Attr,
                       ICS_plbRequest,
                       ICS_plbTranSize,
                       IFB_TE,
                       IFB_cntxSyncOCM,
                       IFB_coreSleepReq,
                       IFB_dcdFullApuL2,
                       IFB_extStopAck,
                       IFB_isOcmAbus,
                       IFB_ocmAbort,
                       IFB_reqDcdApuL2,
                       IFB_wbIar,
                       MMU_apuWbEndian,
                       MMU_dsocmABus,
                       MMU_dsocmCacheable,
                       MMU_dsocmGuarded,
                       MMU_dsocmU0Attr,
                       MMU_dsocmXltValid,
                       MMU_isocmCacheable,
                       MMU_isocmU0Attr,
                       MMU_isocmXltValid,
                       PCL_apuExeWdCnt,
                       PCL_apuLoadDV,
                       PCL_apuWbHold,
                       PCL_dcdHoldForApu,
                       PCL_dsOcmByteEn,
                       PCL_exeFlushForApu,
                       PCL_exeHoldForApu,
                       PCL_exeStringMultiple,
                       PCL_mfDCR,
                       PCL_mtDCR,
                       PCL_trcLoadDV,
                       PCL_wbComplete,
                       PCL_wbFull,
                       TIM_timerResetL2,
                       TRC_evenESBusL2,
                       TRC_oddCycle,
                       TRC_oddESBusL2,
                       TRC_tsBusL2,
                       VCT_apuWbFlush,
                       VCT_errorOut,
                       VCT_msrCE,
                       VCT_msrEE,
                       VCT_msrFE0,
                       VCT_msrFE1,
                       VCT_msrWE,
                       VCT_timerIntrp,
                       APU_dcdApuOp,
                       APU_dcdExeLdDepend,
                       APU_dcdForceAlgn,
                       APU_dcdForceBESteering,
                       APU_dcdFpuOp,
                       APU_dcdGprWr,
                       APU_dcdLdStByte,
                       APU_dcdLdStDw,
                       APU_dcdLdStHw,
                       APU_dcdLdStQw,
                       APU_dcdLdStWd,
                       APU_dcdLoad,
                       APU_dcdLwbLdDepend,
                       APU_dcdPrivOp,
                       APU_dcdRaEn,
                       APU_dcdRbEn,
                       APU_dcdRc,
                       APU_dcdStore,
                       APU_dcdTrapBE,
                       APU_dcdTrapLE,
                       APU_dcdUpdate,
                       APU_dcdValidOp,
                       APU_dcdWbLdDepend,
                       APU_dcdXerCAEn,
                       APU_dcdXerOVEn,
                       APU_exception,
                       APU_exeBlkingMco,
                       APU_exeBusy,
                       APU_exeCa,
                       APU_exeCr0,
                       APU_exeCrField,
                       APU_exeNonBlkingMco,
                       APU_exeOv,
                       APU_exeResult,
                       APU_fpuException,
                       APU_sleepReq,
                       C405_timerTick,
                       CB,
                       CPM_CpuEn,
                       CPM_coreClkOff,
                       DBG_c405DebugHalt,
                       DBG_c405ExtBusHoldAck,
                       EIC_critIntrp,
                       EIC_extIntrp,
                       JTG_c405BndScanTDO,
                       JTG_c405TCK,
                       JTG_c405TDI,
                       JTG_c405TMS,
                       JTG_c405TRST_NEG,
                       LSSD_bistCClk,
                       LSSD_coreTestEn,
                       CPM_jtgEn,
                       LSSD_testM1,
                       LSSD_testM3,
                       CPM_timerEn,
                       OCM_DOF,
                       OCM_dsComplete,
                       OCM_dsData,
                       OCM_dsHold,
                       OCM_isDATA,
                       OCM_isDValid,
                       OCM_isHold,
                       PGM_coprocPresent,
                       PGM_dcu_DOF,
                       PGM_deterministicMult,
                       PGM_divEn,
                       PGM_mmuEn,
                       PGM_pvrBus,
                       PLB_dcuAddrAck,
                       PLB_dcuBusy,
                       PLB_dcuErr,
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
                       PLB_icuSSize,
                       PLB_sampleCycle,
                       RST_c405ResetChip,
                       RST_c405ResetSystem,
                       TRC_c405TE,
                       TRC_c405TraceDisable,
                       XXX_dcrAck,
                       XXX_dcrDataBus,
                       XXX_uncondEvent,
                       resetCore,
//                       BIST_sysPF,
                       BIST_pepsPF,
                       LSSD_c405CE0EVS,
//                       LSSD_c405BistCE0LBist,
                       LSSD_c405BistCE0StClk,
                       LSSD_c405BistCE1Enable,
//                       LSSD_c405BistCE1PG1,
                       LSSD_c405BistCE1Mode,
                       TIE_c405ClockEnable,
                       TIE_c405DutyEnable,
                       CPM_c405PLBClock,
                       CPM_c405SyncBypass,
                       PLB_sampleCycleAlt,
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

     
output  C405_jtgCaptureDR;
output  C405_jtgExtest;
output  C405_jtgPgmOut;
output  C405_jtgShiftDR;
output  C405_jtgTDO;
output  C405_jtgTDOEn;
output  C405_jtgUpdateDR;
output  C405_lssdDiagBistDone;
//output  C405_lssdDiagOut;
output  C405_rstChipResetReq;
output  C405_rstCoreResetReq;
output  C405_rstSystemResetReq;
output  DCS_plbRNW;
output  DCS_plbAbort;
output  DCS_plbCacheable;
output  DCS_plbGuarded;
output  DCS_plbU0Attr;
output  DCU_ocmAbort;
output  DCU_ocmAbortReq;
output  DCU_ocmLoadReq;
output  DCU_ocmStoreReq;
output  DCU_ocmWait;
output  DCS_plbRequest;
output  DCS_plbSize2;
output  DCS_plbWriteThru;
output  EXE_xerCa;
output  ICS_plbAbort;
output  ICS_plbCacheable;
output  ICU_ocmIcuReady;
output  ICU_ocmReqPending;
output  ICS_plbU0Attr;
output  ICS_plbRequest;
output  IFB_TE;
output  IFB_cntxSyncOCM;
output  IFB_coreSleepReq;
output  IFB_dcdFullApuL2;
output  IFB_extStopAck;
output  IFB_ocmAbort;
output  MMU_apuWbEndian;
output  MMU_dsocmCacheable;
output  MMU_dsocmGuarded;
output  MMU_dsocmU0Attr;
output  MMU_dsocmXltValid;
output  MMU_isocmCacheable;
output  MMU_isocmU0Attr;
output  MMU_isocmXltValid;
output  PCL_apuLoadDV;
output  PCL_apuWbHold;
output  PCL_dcdHoldForApu;
output  PCL_exeFlushForApu;
output  PCL_exeHoldForApu;
output  PCL_exeStringMultiple;
output  PCL_mfDCR;
output  PCL_mtDCR;
output  PCL_trcLoadDV;
output  PCL_wbComplete;
output  PCL_wbFull;
output  TIM_timerResetL2;
output  TRC_oddCycle;
output  VCT_apuWbFlush;
output  VCT_errorOut;
output  VCT_msrCE;
output  VCT_msrEE;
output  VCT_msrFE0;
output  VCT_msrFE1;
output  VCT_msrWE;
output  VCT_timerIntrp;


input   APU_dcdApuOp;
input   APU_dcdExeLdDepend;
input   APU_dcdForceAlgn;
input   APU_dcdForceBESteering;
input   APU_dcdFpuOp;
input   APU_dcdGprWr;
input   APU_dcdLdStByte;
input   APU_dcdLdStDw;
input   APU_dcdLdStHw;
input   APU_dcdLdStQw;
input   APU_dcdLdStWd;
input   APU_dcdLoad;
input   APU_dcdLwbLdDepend;
input   APU_dcdPrivOp;
input   APU_dcdRaEn;
input   APU_dcdRbEn;
input   APU_dcdRc;
input   APU_dcdStore;
input   APU_dcdTrapBE;
input   APU_dcdTrapLE;
input   APU_dcdUpdate;
input   APU_dcdValidOp;
input   APU_dcdWbLdDepend;
input   APU_dcdXerCAEn;
input   APU_dcdXerOVEn;
input   APU_exception;
input   APU_exeBlkingMco;
input   APU_exeBusy;
input   APU_exeCa;
input   APU_exeNonBlkingMco;
input   APU_exeOv;
input   APU_fpuException;
input   APU_sleepReq;
input   C405_timerTick;
input   CPM_coreClkOff;
input   DBG_c405DebugHalt;
input   DBG_c405ExtBusHoldAck;
input   EIC_critIntrp;
input   EIC_extIntrp;
input   JTG_c405BndScanTDO;
input   JTG_c405TCK;
input   JTG_c405TDI;
input   JTG_c405TMS;
input   JTG_c405TRST_NEG;
input   LSSD_bistCClk;
input   LSSD_coreTestEn;
input   CPM_jtgEn;
input   LSSD_testM1;
input   LSSD_testM3;
input   CPM_timerEn;
input   OCM_DOF;
input   OCM_dsComplete;
input   OCM_dsHold;
input   OCM_isHold;
input   PGM_coprocPresent;
input   PGM_dcu_DOF;
input   PGM_deterministicMult;
input   PGM_divEn;
input   PGM_mmuEn;
input   PLB_dcuAddrAck;
input   PLB_dcuBusy;
input   PLB_dcuErr;
input   PLB_dcuRdDAck;
input   PLB_dcuSsize;
input   PLB_dcuWrDAck;
input   PLB_icuAddrAck;
input   PLB_icuBusy;
input   PLB_icuError;
input   PLB_icuRdDAck;
input   PLB_icuSSize;
input   PLB_sampleCycle;
input   RST_c405ResetChip;
input   RST_c405ResetSystem;
input   TRC_c405TE;
input   TRC_c405TraceDisable;
input   XXX_dcrAck;
input   XXX_uncondEvent;
input   resetCore;
input   LSSD_c405CE0EVS;
//input   LSSD_c405BistCE0LBist;
input   LSSD_c405BistCE0StClk;
input   LSSD_c405BistCE1Enable;
//input   LSSD_c405BistCE1PG1;
input   LSSD_c405BistCE1Mode;
input   TIE_c405ClockEnable;
input   TIE_c405DutyEnable;
input   CPM_c405PLBClock;
input   CPM_c405SyncBypass;

// added for tbird
input          PLB_sampleCycleAlt;

output [0:31] DCS_plbABus;
output [0:7]  DCS_plbBE;
output [0:1]  TRC_evenESBusL2;
output [0:1]  TRC_oddESBusL2;
output [0:31]  EXE_raData;
output [0:9]  EXE_dcrAddr;
output [0:1]  DCS_plbPriority;
output [0:31]  DCU_ocmData;
output [0:29]  IFB_isOcmAbus;
output [0:3]  DCU_apuWbByteEn;
output [0:10]  CPU_TEType;
output [0:29]  ICS_plbABus;
output [0:1]  ICS_plbPriority;
output [0:31]  IFB_reqDcdApuL2;
output [0:31]  EXE_dcrDataBus;
output [0:63]  DCS_plbWrDBus;
output [0:3]  PCL_dsOcmByteEn;
output [0:29]  IFB_wbIar;
output [0:3]  TRC_tsBusL2;
output [0:29]  MMU_dsocmABus;
output [0:31]  EXE_rbData;
output [0:1]  PCL_apuExeWdCnt;
output [2:3]  ICS_plbTranSize;
output [0:31]  EXE_apuLoadData;
//output [0:7]  BIST_sysPF;
output [0:2]  BIST_pepsPF;

input [0:3]  APU_exeCr0;
input [0:31]  XXX_dcrDataBus;
input [0:2]  PLB_dcuRdWdAddr;
input [0:31]  OCM_dsData;
input [0:2]  APU_exeCrField;
input [0:63]  PLB_dcuRdDBus;
input [0:31]  APU_exeResult;
input         CB;
input         CPM_CpuEn;
input [1:3]  PLB_icuRdWrAddr;
input [0:1]  OCM_isDValid;
input [0:63]  OCM_isDATA;
input [0:63]  PLB_icuDBus;
input [0:31]  PGM_pvrBus;

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

wire  [0:31]  EXE_mmuIcuSprData;
wire  [0:31]  DCU_data_NEG;
wire  [0:1]  ICU_EO;
wire  [0:63]  ICU_isBus;
wire  [0:31]  ICU_sprData;
wire  [0:1]  MMU_isStatus;
wire  [0:11]  PCL_dcuOp;
wire  [0:29]  IFB_isEA;
wire  [0:9]  PCL_stSteerCntl;
wire  [0:3]  PCL_icuOp;
wire  [0:3]  PCL_dsMmuOp;
wire  [0:3]  PCL_dcuByteEn;
wire  [0:31]  EXE_dcuData;
wire  [0:2]  IFB_isAbortForICU;
wire  [0:31]  EXE_dsEA_NEG;
wire  [4:9]  EXE_sprAddr;
wire  [0:7]  MMU_dsStatus;
wire  [0:31]  JTG_instBuf;
wire  [0:31]  MMU_sprData;
wire  [0:7]  EXE_dsEaCP;
wire  [0:21]  EXE_eaBRegBuf;
wire  [0:21]  EXE_eaARegBuf;
wire  [0:8]  PCL_mmuSprDcd;
wire  [0:1]  ICU_ifbError;
wire  [0:3]  DCU_carByteEn;
wire  [0:31]  DCU_SDQ_mod;
wire  [0:2]  EXE_icuSprDcds;
wire  [0:2]  PCL_dcuOp_early;
wire  [0:22]  ICU_diagBus;
wire  [0:20]  DCU_diagBus;
wire         CBBufStretched;

wire [0:31] DCU_ABus;
wire [0:63] DCU_DBus;
wire [0:7]  DCU_dTags;
wire [0:1]  DCU_PlbPriority;
wire [0:29] ICU_ABus;
wire [0:1]  ICU_PlbPriority;
wire [2:3]  ICU_tranSize;
wire [0:63] DCS_c405RdDBus;
wire [0:2]  DCS_c405RdWdAddr;
wire [0:63] ICS_c405DBus;
wire [1:3]  ICS_c405RdWrAddr;
wire PGM_dcu_DOF_or_DPE;
wire CBGated;
wire ICU_CCR0DPE;

wire CoreClk;
wire TimerClk;
wire JtgClk;
reg CoreClkEn;
reg TimerClkEn;
reg JtagClkEn;

//Removed the module 'OR2_J'
assign PGM_dcu_DOF_or_DPE = PGM_dcu_DOF | ICU_CCR0DPE;
//Removed the module 'AND2_J'
assign CBGated = CB & LSSD_c405BistCE1Mode & TIE_c405ClockEnable & TIE_c405DutyEnable;
// The following create three clock trees that can be
// individually disabled.
assign CoreClk = CBGated & CoreClkEn;
assign TimerClk = CBGated & TimerClkEn;
assign JtgClk = JTG_c405TCK & JtagClkEn; 
always @(CBGated or CPM_CpuEn or CPM_timerEn ) begin
  if (~CBGated) begin
    CoreClkEn <= CPM_CpuEn;
    TimerClkEn <= CPM_timerEn;
  end
end
always @(JTG_c405TCK or CPM_jtgEn ) begin
  if (~JTG_c405TCK) begin
    JtagClkEn <= CPM_jtgEn;
  end
end  

p405s_cpu_top
 cpu_topSch(
        .C405_jtgCaptureDR(                 C405_jtgCaptureDR),
        .C405_jtgExtest(                    C405_jtgExtest),
        .C405_jtgPlbDcuPriorityAdjust(      C405_jtgPgmOut),
        .C405_jtgShiftDR(                   C405_jtgShiftDR),
        .C405_jtgTDO(                       C405_jtgTDO),
        .C405_jtgTDOEn(                     C405_jtgTDOEn),
        .C405_jtgUpdateDR(                  C405_jtgUpdateDR),
        .C405_rstChipResetReq(              C405_rstChipResetReq),
        .C405_rstCoreResetReq(              C405_rstCoreResetReq),
        .C405_rstSystemResetReq(            C405_rstSystemResetReq),
        .CPU_TEType(                        CPU_TEType[0:10]),
        .EXE_apuLoadData(                   EXE_apuLoadData[0:31]),
        .EXE_dcrAddr(                       EXE_dcrAddr[0:9]),
        .EXE_dcrDataBus(                    EXE_dcrDataBus[0:31]),
        .EXE_dcuData(                       EXE_dcuData[0:31]),
        .EXE_dsEA_NEG(                      EXE_dsEA_NEG[0:31]),
        .EXE_dsEaCP(                        EXE_dsEaCP[0:7]),
        .EXE_eaARegBuf(                     EXE_eaARegBuf[0:21]),
        .EXE_eaBRegBuf(                     EXE_eaBRegBuf[0:21]),
        .EXE_icuSprDcds(                    EXE_icuSprDcds[0:2]),
        .EXE_mmuIcuSprDataBus(              EXE_mmuIcuSprData[0:31]),
        .EXE_raData(                        EXE_raData[0:31]),
        .EXE_rbData(                        EXE_rbData[0:31]),
        .EXE_sprAddr(                       EXE_sprAddr[4:9]),
        .EXE_xerCa(                         EXE_xerCa),
        .ICU_parityErrE(                    ICU_parityErrE),
        .ICU_parityErrO(                    ICU_parityErrO),
        .ICU_tagParityErr(                  ICU_tagParityErr),
        .ICU_CCR0DPP(                       ICU_CCR0DPP),
        .ICU_CCR0DPE(                       ICU_CCR0DPE),
        .ICU_CCR0IPE(                       ICU_CCR0IPE),
        .ICU_CCR0TPE(                       ICU_CCR0TPE),
        .IFB_TE(                            IFB_TE),
        .IFB_cntxSync(                      IFB_cntxSync),
        .IFB_cntxSyncOCM(                   IFB_cntxSyncOCM),
        .IFB_coreSleepReq(                  IFB_coreSleepReq),
        .IFB_dcdFullApuL2(                  IFB_dcdFullApuL2),
        .IFB_exeFlush(                      IFB_exeFlush),
        .IFB_extStopAck(                    IFB_extStopAck),
        .IFB_fetchReq(                      IFB_fetchReq),
        .IFB_icuCancelDataL2(               IFB_icuCancelData),
        .IFB_isAbortForICU(                 IFB_isAbortForICU[0:2]),
        .IFB_isAbortForMMU(                 IFB_isAbortForMMU),
        .IFB_isEA(                          IFB_isEA[0:29]),
        .IFB_isNL(                          IFB_isNL),
        .IFB_isNP(                          IFB_isNP),
        .IFB_isOcmAbus_Neg(                 IFB_isOcmAbus[0:29]),
        .IFB_nonSpecAcc(                    IFB_nonSpecAcc),
        .IFB_ocmAbort(                      IFB_ocmAbort),
        .IFB_regDcdApuL2(                   IFB_reqDcdApuL2[0:31]),
        .IFB_wbIar(                         IFB_wbIar[0:29]),
        .JTG_iCacheWr(                      JTG_iCacheWr),
        .JTG_instBuf(                       JTG_instBuf[0:31]),
        .MMU_tlbREParityErr(                MMU_tlbREParityErr),
        .MMU_tlbSXParityErr(                MMU_tlbSXParityErr),
        .MMU_dsParityErr(                   MMU_dsParityErr),
        .MMU_isParityErr(                   MMU_isParityErr),
        .PCL_apuExeWdCnt(                   PCL_apuExeWdCnt[0:1]),
        .PCL_apuLoadDV(                     PCL_apuLoadDV),
        .PCL_apuWbHold(                     PCL_apuWbHold),
        .PCL_dcdHoldForApu(                 PCL_dcdHoldForApu),
        .PCL_dcuByteEn(                     PCL_dcuByteEn[0:3]),
        .PCL_dcuOp(                         PCL_dcuOp[0:11]),
        .PCL_dcuOp_early(                   PCL_dcuOp_early[0:2]),
        .PCL_dsMmuOp(                       PCL_dsMmuOp[0:3]),
        .PCL_dsOcmByteEn(                   PCL_dsOcmByteEn[0:3]),
        .PCL_exeAbort(                      PCL_exeAbort),
        .PCL_exeFlushForApu(                PCL_exeFlushForApu),
        .PCL_exeHoldForApu(                 PCL_exeHoldForApu),
        .PCL_exeLdNotSt(                    PCL_ldNotSt),
        .PCL_exeStorageOp(                  PCL_exeStorageOp),
        .PCL_exeStringMultiple(             PCL_exeStringMultiple),
        .PCL_exeTlbOp(                      PCL_exeTlbOp),
        .PCL_icuOp(                         PCL_icuOp[0:3]),
        .PCL_mfDCR(                         PCL_mfDCR),
        .PCL_mfSPR(                         PCL_mfSPR),
        .PCL_mmuExeAbort(                   PCL_mmuExeAbort),
        .PCL_mmuIcuSprHold(                 PCL_mmuIcuSprHold),
        .PCL_mmuSprDcd(                     PCL_mmuSprDcd[0:8]),
        .PCL_mtDCR(                         PCL_mtDCR),
        .PCL_mtSPR(                         PCL_mtSPR),
        .PCL_ocmAbortReq(                   DCU_ocmAbortReq),
        .PCL_stSteerCntl(                   PCL_stSteerCntl[0:9]),
        .PCL_tlbRE(                         PCL_tlbRE),
        .PCL_tlbSX(                         PCL_tlbSX),
        .PCL_tlbWE(                         PCL_tlbWE),
        .PCL_tlbWS(                         PCL_tlbWS),
        .PCL_trcLoadDV(                     PCL_trcLoadDV),
        .PCL_wbComplete(                    PCL_wbComplete),
        .PCL_wbFull(                        PCL_wbFull),
        .PCL_wbHoldNonErr(                  PCL_wbHoldNonErr),
        .PCL_wbStorageOp(                   PCL_wbStorageOp),
        .TIM_timerResetL2(                  TIM_timerResetL2),
        .TRC_evenESBusL2(                   TRC_evenESBusL2[0:1]),
        .TRC_oddCycle(                      TRC_oddCycle),
        .TRC_oddESBusL2(                    TRC_oddESBusL2[0:1]),
        .TRC_tsBusL2(                       TRC_tsBusL2[0:3]),
        .VCT_apuWbFlush(                    VCT_apuWbFlush),
        .VCT_dcuWbAbort(                    VCT_dcuWbAbort),
        .VCT_dearE2(                        VCT_dearE2),
        .VCT_errorOut(                      VCT_errorOut),
        .VCT_icuWbAbort(                    VCT_icuWbAbort),
        .VCT_mmuExeSuppress(                VCT_mmuExeSuppress),
        .VCT_mmuWbAbort(                    VCT_mmuWbAbort),
        .VCT_msrCE(                         VCT_msrCE),
        .VCT_msrDR(                         VCT_msrDR),
        .VCT_msrEE(                         VCT_msrEE),
        .VCT_msrFE0(                        VCT_msrFE0),
        .VCT_msrFE1(                        VCT_msrFE1),
        .VCT_msrIR(                         VCT_msrIR),
        .VCT_msrPR(                         VCT_msrPR),
        .VCT_msrWE(                         VCT_msrWE),
        .VCT_timerIntrp(                    VCT_timerIntrp),
        .APU_dcdApuOp(                      APU_dcdApuOp),
        .APU_dcdExeLdDepend(                APU_dcdExeLdDepend),
        .APU_dcdForceAlgn(                  APU_dcdForceAlgn),
        .APU_dcdForceBESteering(            APU_dcdForceBESteering),
        .APU_dcdFpuOp(                      APU_dcdFpuOp),
        .APU_dcdGprWr(                      APU_dcdGprWr),
        .APU_dcdLdStByte(                   APU_dcdLdStByte),
        .APU_dcdLdStDw(                     APU_dcdLdStDw),
        .APU_dcdLdStHw(                     APU_dcdLdStHw),
        .APU_dcdLdStQw(                     APU_dcdLdStQw),
        .APU_dcdLdStWd(                     APU_dcdLdStWd),
        .APU_dcdLoad(                       APU_dcdLoad),
        .APU_dcdLwbLdDepend(                APU_dcdLwbLdDepend),
        .APU_dcdPrivOp(                     APU_dcdPrivOp),
        .APU_dcdRaEn(                       APU_dcdRaEn),
        .APU_dcdRbEn(                       APU_dcdRbEn),
        .APU_dcdRc(                         APU_dcdRc),
        .APU_dcdStore(                      APU_dcdStore),
        .APU_dcdTrapBE(                     APU_dcdTrapBE),
        .APU_dcdTrapLE(                     APU_dcdTrapLE),
        .APU_dcdUpdate(                     APU_dcdUpdate),
        .APU_dcdValidOp(                    APU_dcdValidOp),
        .APU_dcdWbLdDepend(                 APU_dcdWbLdDepend),
        .APU_dcdXerCAEn(                    APU_dcdXerCAEn),
        .APU_dcdXerOVEn(                    APU_dcdXerOVEn),
        .APU_exception(                     APU_exception),
        .APU_exeBlkingMco(                  APU_exeBlkingMco),
        .APU_exeBusy(                       APU_exeBusy),
        .APU_exeCa(                         APU_exeCa),
        .APU_exeCr(                         APU_exeCr0[0:3]),
        .APU_exeCrField(                    APU_exeCrField[0:2]),
        .APU_exeNonBlkingMco(               APU_exeNonBlkingMco),
        .APU_exeOv(                         APU_exeOv),
        .APU_exeResult(                     APU_exeResult[0:31]),
        .APU_sleepReq(                      APU_sleepReq),
        .C405_timerTick(                    C405_timerTick),
        .CAR_cacheable(                     CAR_cacheable),
        .CAR_endian(                        CAR_endian),
        .CB(                                CoreClk),
        .TimerClk(                          TimerClk),
        .CPM_coreClkOff(                    CPM_coreClkOff),
        .DBG_c405DebugHalt(                 DBG_c405DebugHalt),
        .DBG_c405ExtBusHoldAck(             DBG_c405ExtBusHoldAck),
        .DCU_CA(                            DCU_CA),
        .DCU_DA(                            DCU_DA),
        .DCU_SCL2(                          DCU_SCL2),
        .DCU_SDQ_mod(                       DCU_SDQ_mod[0:31]),
        .DCU_carByteEn(                     DCU_carByteEn[0:3]),
        .DCU_data_NEG(                      DCU_data_NEG[0:31]),
        .DCU_diagBus(                       DCU_diagBus[0:20]),
        .DCU_firstCycCarStXltV(             DCU_firstCycCarStXltV),
        .DCU_parityError(                   DCU_parityError),
        .DCU_FlushParityError(              DCU_FlushParityError),
        .DCU_pclOcmWait(                    DCU_pclOcmWait),
        .DCU_sleepReq(                      DCU_sleepReq),
        .EIC_critIntrp(                     EIC_critIntrp),
        .EIC_extIntrp(                      EIC_extIntrp),
        .FPU_exception(                     APU_fpuException),
        .ICU_EO(                            ICU_EO[0:1]),
        .ICU_GPRC(                          ICU_GPRC),
        .ICU_LDBE(                          ICU_LDBE),
        .ICU_diagBus(                       ICU_diagBus[0:22]),
        .ICU_dsCA(                          ICU_dsCA),
        .ICU_ifbError(                      ICU_ifbError[0:1]),
        .ICU_isBus(                         ICU_isBus[0:63]),
        .ICU_isCA(                          ICU_isCA),
        .ICU_sleepReq(                      ICU_sleepReq),
        .ICU_sprDataBus(                    ICU_sprData[0:31]),
        .ICU_syncAfterReset(                ICU_syncAfterReset),
        .ICU_traceEnable(                   ICU_traceEnable),
        .JTG_c405BndScanTDO(                JTG_c405BndScanTDO),
        .JTG_c405TCK(                       JtgClk),
        .JTG_c405TDI(                       JTG_c405TDI),
        .JTG_c405TMS(                       JTG_c405TMS),
        .JTG_c405TRST_NEG(                  JTG_c405TRST_NEG),
        .LSSD_coreTestEn(                   LSSD_coreTestEn),
        .MMU_BMCO(                          MMU_BMCO),
        .MMU_dsStateBorC(                   MMU_dsStateBorC),
        .MMU_dsStatus(                      MMU_dsStatus[0:7]),
        .MMU_isStatus(                      MMU_isStatus[0:1]),
        .MMU_sprDataBus(                    MMU_sprData[0:31]),
        .MMU_tlbSXHit(                      MMU_tlbSXHit),
        .MMU_wbHold(                        MMU_wbHold),
        .OCM_DOF(                           OCM_DOF),
        .OCM_dsComplete(                    OCM_dsComplete),
        .OCM_dsData(                        OCM_dsData[0:31]),
        .PGM_coprocPresent(                 PGM_coprocPresent),
        .PGM_dcu_DOF(                       PGM_dcu_DOF_or_DPE),   
        .PGM_deterministicMult(             PGM_deterministicMult),
        .PGM_divEn(                         PGM_divEn),
        .PGM_mmuEn(                         PGM_mmuEn),
        .PGM_pvrBus(                        PGM_pvrBus[0:31]),
        .PLB_dcuErr(                        DCS_c405Err),
        .RST_c405ResetChip(                 RST_c405ResetChip),
        .RST_c405ResetSystem(               RST_c405ResetSystem),
        .TRC_c405TE(                        TRC_c405TE),
        .TRC_c405TraceDisable(              TRC_c405TraceDisable),
        .XXX_dcrAck(                        XXX_dcrAck),
        .XXX_dcrDataBus(                    XXX_dcrDataBus[0:31]),
        .XXX_uncondEvent(                   XXX_uncondEvent),
        .c2Clk(                             CoreClk),
        .resetCore(                         resetCore),
	    .EXE_gprSysClkPI(                     CoreClk)
        );

p405s_cacheMMU
 cacheMMUSch(
        .CAR_cacheable(                     CAR_cacheable),
        .CAR_endian(                        CAR_endian),
        .DCU_ABus(                          DCU_ABus[0:31]),
        .DCU_CA(                            DCU_CA),
        .DCU_DA(                            DCU_DA),
        .DCU_DBus(                          DCU_DBus[0:63]),
        .DCU_RNW(                           DCU_RNW),
        .DCU_SCL2(                          DCU_SCL2),
        .DCU_SDQ_mod(                       DCU_SDQ_mod[0:31]),
        .C405_lssdDiagBistDone(             C405_lssdDiagBistDone),
        .DCU_abort(                         DCU_abort),
        .DCU_apuWbByteEn(                   DCU_apuWbByteEn[0:3]),
        .DCU_cacheable(                     DCU_cacheable),
        .DCU_carByteEn(                     DCU_carByteEn[0:3]),
        .DCU_dTags(                         DCU_dTags[0:7]),
        .DCU_data_NEG(                      DCU_data_NEG[0:31]),
        .DCU_diagBus(                       DCU_diagBus[0:20]),
//        .DCU_diagOut(                       C405_lssdDiagOut),
        .DCU_firstCycCarStXltV(             DCU_firstCycCarStXltV),
        .DCU_guarded(                       DCU_guarded),
        .DCU_kompress(                      DCU_kompress),
        .DCU_ocmAbort(                      DCU_ocmAbort),
        .DCU_ocmData(                       DCU_ocmData[0:31]),
        .DCU_ocmLoadReq(                    DCU_ocmLoadReq),
        .DCU_ocmStoreReq(                   DCU_ocmStoreReq),
        .DCU_ocmWait(                       DCU_ocmWait),
        .DCU_parityError(                   DCU_parityError),
        .DCU_FlushParityError(              DCU_FlushParityError),
        .DCU_pclOcmWait(                    DCU_pclOcmWait),
        .DCU_plbPriority(                   DCU_PlbPriority[0:1]),
        .DCU_request(                       DCU_request),
        .DCU_sleepReq(                      DCU_sleepReq),
        .DCU_tranSize(                      DCU_tranSize),
        .DCU_writeThru(                     DCU_writeThru),
        .ICU_ABus(                          ICU_ABus[0:29]),
        .ICU_CCR0DPP(                       ICU_CCR0DPP),
        .ICU_CCR0DPE(                       ICU_CCR0DPE),
        .ICU_CCR0IPE(                       ICU_CCR0IPE),
        .ICU_CCR0TPE(                       ICU_CCR0TPE),
        .ICU_EO(                            ICU_EO[0:1]),
        .ICU_GPRC(                          ICU_GPRC),
        .ICU_LDBE(                          ICU_LDBE),
        .ICU_abort(                         ICU_abort),
        .ICU_cacheable(                     ICU_cacheable),
        .ICU_diagBus(                       ICU_diagBus[0:22]),
        .ICU_dsCA(                          ICU_dsCA),
        .ICU_ifbError(                      ICU_ifbError[0:1]),
        .ICU_isBus(                         ICU_isBus[0:63]),
        .ICU_isCA(                          ICU_isCA),
        .ICU_ocmIcuReady(                   ICU_ocmIcuReady),
        .ICU_ocmReqPending(                 ICU_ocmReqPending),
        .ICU_parityErrE(                    ICU_parityErrE),
        .ICU_parityErrO(                    ICU_parityErrO),
        .ICU_tagParityErr(                  ICU_tagParityErr),
        .ICU_plbPriority(                   ICU_PlbPriority[0:1]),
        .ICU_plbU0Attr(                     ICU_plbU0Attr),
        .ICU_request(                       ICU_request),
        .ICU_sleepReq(                      ICU_sleepReq),
        .ICU_sprData(                       ICU_sprData[0:31]),
        .ICU_syncAfterReset(                ICU_syncAfterReset),
        .ICU_traceEnable(                   ICU_traceEnable),
        .ICU_tranSize(                      ICU_tranSize[2:3]),
        .MMU_BMCO(                          MMU_BMCO),
        .MMU_apuWbEndian(                   MMU_apuWbEndian),
        .MMU_dsStateBorC(                   MMU_dsStateBorC),
        .MMU_dsStatus(                      MMU_dsStatus[0:7]),
        .MMU_dsocmABus(                     MMU_dsocmABus[0:29]),
        .MMU_dsocmCacheable(                MMU_dsocmCacheable),
        .MMU_dsocmGuarded(                  MMU_dsocmGuarded),
        .MMU_dsocmU0Attr(                   MMU_dsocmU0Attr),
        .MMU_dsocmXltValid(                 MMU_dsocmXltValid),
        .MMU_isStatus(                      MMU_isStatus[0:1]),
        .MMU_isocmCacheable(                MMU_isocmCacheable),
        .MMU_isocmU0Attr(                   MMU_isocmU0Attr),
        .MMU_isocmXltValid(                 MMU_isocmXltValid),
        .MMU_sprData(                       MMU_sprData[0:31]),
        .MMU_tlbSXHit(                      MMU_tlbSXHit),
        .MMU_tlbREParityErr(                MMU_tlbREParityErr),
        .MMU_tlbSXParityErr(                MMU_tlbSXParityErr),
        .MMU_dsParityErr(                   MMU_dsParityErr),
        .MMU_isParityErr(                   MMU_isParityErr),
        .MMU_wbHold(                        MMU_wbHold),
        .CB(                                CoreClk),
        .EXE_dcuData(                       EXE_dcuData[0:31]),
        .EXE_dsEA_NEG(                      EXE_dsEA_NEG[0:31]),
        .EXE_dsEaCP(                        EXE_dsEaCP[0:7]),
        .EXE_eaARegBuf(                     EXE_eaARegBuf[0:21]),
        .EXE_eaBRegBuf(                     EXE_eaBRegBuf[0:21]),
        .EXE_icuSprDcds(                    EXE_icuSprDcds[0:2]),
        .EXE_mmuIcuSprData(                 EXE_mmuIcuSprData[0:31]),
        .EXE_sprAddr(                       EXE_sprAddr[4:9]),
        .IFB_cntxSync(                      IFB_cntxSync),
        .IFB_exeFlush(                      IFB_exeFlush),
        .IFB_fetchReq(                      IFB_fetchReq),
        .IFB_icuCancelData(                 IFB_icuCancelData),
        .IFB_isAbortForICU(                 IFB_isAbortForICU[0:2]),
        .IFB_isAbortForMMU(                 IFB_isAbortForMMU),
        .IFB_isEA(                          IFB_isEA[0:29]),
        .IFB_isNL(                          IFB_isNL),
        .IFB_isNP(                          IFB_isNP),
        .IFB_ldNotSt(                       PCL_ldNotSt),
        .IFB_nonSpecAcc(                    IFB_nonSpecAcc),
        .JTG_iCacheWr(                      JTG_iCacheWr),
        .JTG_instBuf(                       JTG_instBuf[0:31]),
        .LSSD_bistCClk(                     LSSD_bistCClk),
        .LSSD_coreTestEn(                   LSSD_coreTestEn),
        .LSSD_testM1(                       LSSD_testM1),
        .LSSD_testM3(                       LSSD_testM3),
        .OCM_dsComplete(                    OCM_dsComplete),
        .OCM_dsHold(                        OCM_dsHold),
        .OCM_isDATA(                        OCM_isDATA[0:63]),
        .OCM_isDValid(                      OCM_isDValid[0:1]),
        .OCM_isHold(                        OCM_isHold),
        .PCL_dcuByteEn(                     PCL_dcuByteEn[0:3]),
        .PCL_dcuOp(                         PCL_dcuOp[0:11]),
        .PCL_dcuOp_early(                   PCL_dcuOp_early[0:2]),
        .PCL_dsMmuOp(                       PCL_dsMmuOp[0:3]),
        .PCL_exeAbort(                      PCL_exeAbort),
        .PCL_exeStorageOp(                  PCL_exeStorageOp),
        .PCL_exeTlbOp(                      PCL_exeTlbOp),
        .PCL_icuOp(                         PCL_icuOp[0:3]),
        .PCL_mfSPR(                         PCL_mfSPR),
        .PCL_mmuExeAbort(                   PCL_mmuExeAbort),
        .PCL_mmuIcuSprHold(                 PCL_mmuIcuSprHold),
        .PCL_mmuSprDcd(                     PCL_mmuSprDcd[0:8]),
        .PCL_mtSPR(                         PCL_mtSPR),
        .PCL_stSteerCntl(                   PCL_stSteerCntl[0:9]),
        .PCL_tlbRE(                         PCL_tlbRE),
        .PCL_tlbSX(                         PCL_tlbSX),
        .PCL_tlbWE(                         PCL_tlbWE),
        .PCL_tlbWS(                         PCL_tlbWS),
        .PCL_wbHoldNonErr(                  PCL_wbHoldNonErr),
        .PCL_wbStorageOp(                   PCL_wbStorageOp),
        .PLB_dcuAddrAck(                    DCS_c405AddrAck),
        .PLB_dcuBusy(                       DCS_c405Busy),
        .PLB_dcuRdDAck(                     DCS_c405RdDAck),
        .PLB_dcuRdDBus(                     DCS_c405RdDBus[0:63]),
        .PLB_dcuRdWdAddr(                   DCS_c405RdWdAddr[0:2]),
        .PLB_dcuSsize(                      DCS_c405SSize1),
        .PLB_dcuWrDAck(                     DCS_c405WrDAck),
        .PLB_icuAddrAck(                    ICS_c405AddrAck),
        .PLB_icuBusy(                       ICS_c405IcuBusy),
        .PLB_icuDBus(                       ICS_c405DBus[0:63]),
        .PLB_icuError(                      ICS_c405Error),
        .PLB_icuRdDAck(                     ICS_c405RdDAck),
        .PLB_icuRdWrAddr(                   ICS_c405RdWrAddr[1:3]),
        .PLB_sSize(                         ICS_c405SSize),
        .PLB_sampleCycle(                   PLB_sampleCycle),
        .VCT_dcuWbAbort(                    VCT_dcuWbAbort),
        .VCT_dearE2(                        VCT_dearE2),
        .VCT_icuWbAbort(                    VCT_icuWbAbort),
        .VCT_mmuExeSuppress(                VCT_mmuExeSuppress),
        .VCT_mmuWbAbort(                    VCT_mmuWbAbort),
        .VCT_msrDR(                         VCT_msrDR),
        .VCT_msrIR(                         VCT_msrIR),
        .VCT_msrPR(                         VCT_msrPR),
//        .BIST_sysPF(                        BIST_sysPF[0:7]),
        .BIST_pepsPF(                       BIST_pepsPF[0:2]),
        .resetCore(                         resetCore),
        .LSSD_c405CE0EVS(                   LSSD_c405CE0EVS),
//        .LSSD_c405BistCE0LBist(             LSSD_c405BistCE0LBist),
        .LSSD_c405BistCE0StClk(             LSSD_c405BistCE0StClk),
        .LSSD_c405BistCE1Enable(            LSSD_c405BistCE1Enable),
//        .LSSD_c405BistCE1PG1(               LSSD_c405BistCE1PG1),
        .PLB_sampleCycleAlt(                PLB_sampleCycleAlt),
        .CPM_c405SyncBypass(                CPM_c405SyncBypass),
        .testmode(                          testmode),
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
        .icu_bist_debug_si(                 icu_bist_debug_si),
        .icu_bist_debug_so(                 icu_bist_debug_so),
        .icu_bist_debug_en(                 icu_bist_debug_en),
        .icu_bist_mode_reg_in(              icu_bist_mode_reg_in),
        .icu_bist_mode_reg_out(             icu_bist_mode_reg_out),
        .icu_bist_parallel_dr(              icu_bist_parallel_dr),
        .icu_bist_mode_reg_si(              icu_bist_mode_reg_si),
        .icu_bist_mode_reg_so(              icu_bist_mode_reg_so),
        .icu_bist_shift_dr(                 icu_bist_shift_dr),
        .icu_bist_mbrun(                    icu_bist_mbrun)
        );

p405s_sync_top
 sync (
              .ICS_plbABus(                     ICS_plbABus),
              .ICS_plbAbort(                    ICS_plbAbort),
              .ICS_plbCacheable(                ICS_plbCacheable),
              .ICS_plbRequest(                  ICS_plbRequest),
              .ICS_plbTranSize(                 ICS_plbTranSize),
              .ICS_plbU0Attr(                   ICS_plbU0Attr),
              .ICS_plbPriority(                 ICS_plbPriority),
              .ICS_c405AddrAck(                 ICS_c405AddrAck),
              .ICS_c405IcuBusy(                 ICS_c405IcuBusy),
              .ICS_c405Error(                   ICS_c405Error),
              .ICS_c405RdDAck(                  ICS_c405RdDAck),
              .ICS_c405DBus(                    ICS_c405DBus),
              .ICS_c405RdWrAddr(                ICS_c405RdWrAddr),
              .ICS_c405SSize(                   ICS_c405SSize),
              .C405_icsABus(                    ICU_ABus[0:29]),
              .C405_icsAbort(                   ICU_abort),
              .C405_icsCacheable(               ICU_cacheable),
              .C405_icsRequest(                 ICU_request),
              .C405_icsTranSize(                ICU_tranSize[2:3]),
              .C405_icsU0Attr(                  ICU_plbU0Attr),
              .C405_icsPriority(                ICU_PlbPriority[0:1]),
              .PLB_icsAddrAck(                  PLB_icuAddrAck),
              .PLB_icsIcuBusy(                  PLB_icuBusy),
              .PLB_icsError(                    PLB_icuError),
              .PLB_icsRdDAck(                   PLB_icuRdDAck),
              .PLB_icsDBus(                     PLB_icuDBus[0:63]),
              .PLB_icsRdWrAddr(                 PLB_icuRdWrAddr[1:3]),
              .PLB_icsSSize(                    PLB_icuSSize),
              .DCS_plbRequest(                  DCS_plbRequest),
              .DCS_plbRNW(                      DCS_plbRNW),
              .DCS_plbABus(                     DCS_plbABus),
              .DCS_plbSize2(                    DCS_plbSize2),
              .DCS_plbCacheable(                DCS_plbCacheable),
              .DCS_plbWriteThru(                DCS_plbWriteThru),
              .DCS_plbU0Attr(                   DCS_plbU0Attr),
              .DCS_plbGuarded(                  DCS_plbGuarded),
              .DCS_plbBE(                       DCS_plbBE),
              .DCS_plbPriority(                 DCS_plbPriority),
              .DCS_plbAbort(                    DCS_plbAbort),
              .DCS_plbWrDBus(                   DCS_plbWrDBus),
              .DCS_c405AddrAck(                 DCS_c405AddrAck),
              .DCS_c405SSize1(                  DCS_c405SSize1),
              .DCS_c405RdDAck(                  DCS_c405RdDAck),
              .DCS_c405RdDBus(                  DCS_c405RdDBus),
              .DCS_c405RdWdAddr(                DCS_c405RdWdAddr),
              .DCS_c405WrDAck(                  DCS_c405WrDAck),
              .DCS_c405Busy(                    DCS_c405Busy),
              .DCS_c405Err(                     DCS_c405Err),
              .C405_dcsDcuRequest(              DCU_request),
              .C405_dcsDcuRNW(                  DCU_RNW),
              .C405_dcsDcuABus(                 DCU_ABus),
              .C405_dcsDcuSize2(                DCU_tranSize),
              .C405_dcsDcuCacheable(            DCU_cacheable),
              .C405_dcsDcuWriteThru(            DCU_writeThru),
              .C405_dcsDcuU0Attr(               DCU_kompress),
              .C405_dcsDcuGuarded(              DCU_guarded),
              .C405_dcsDcuBE(                   DCU_dTags),
              .C405_dcsDcuPriority(             DCU_PlbPriority),
              .C405_dcsDcuAbort(                DCU_abort),
              .C405_dcsDcuWrDBus(               DCU_DBus),
              .PLB_dcsAddrAck(                  PLB_dcuAddrAck),
              .PLB_dcsSSize1(                   PLB_dcuSsize),
              .PLB_dcsRdDAck(                   PLB_dcuRdDAck),
              .PLB_dcsRdDBus(                   PLB_dcuRdDBus),
              .PLB_dcsRdWdAddr(                 PLB_dcuRdWdAddr),
              .PLB_dcsWrDAck(                   PLB_dcuWrDAck),
              .PLB_dcsBusy(                     PLB_dcuBusy),
              .PLB_dcsErr(                      PLB_dcuErr),
              .CPM_c405SyncBypass(              CPM_c405SyncBypass),
              .EXT_sysclkPLB(                   CPM_c405PLBClock),              // PLB slow clock
              .CB(                              CoreClk),
              .RST_ResetCore(                   resetCore)
             );

endmodule
