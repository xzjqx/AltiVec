// Library - PR_ifb, Cell - ifb_top, // View - schematic, Version - 1.43
//
// Date Modified: 7/18/01 by SWD
// Changes made for Cobra, 405 with Parity
// Added input signals: MMU_isParityErr, ICU_ParityErrE, ICU_tagParityErr
// Added output: IFB_exeISideMachChkIn
// Change the number of bits for the IFB_exeIfetchErrL2[0:2] to [0:5]
// Added signals to module ifb_top
//

module p405s_ifb_top( IFB_TEL2, IFB_TETypeL2, IFB_cntxSync, IFB_cntxSyncOCM,
     IFB_coreSleepReqL2, IFB_dcdApu, IFB_dcdBubble, IFB_dcdDataIn_Neg,
     IFB_dcdFullApuL2, IFB_dcdFullL2, IFB_dcdRegE1, IFB_dcdRegE2, IFB_diagBus,
     IFB_exeClear, IFB_exeCorrect, IFB_exeDbgBrTaken, IFB_exeDisableDbL2, IFB_exeFlushA,
     IFB_exeFlushB, IFB_exeFullL2, IFB_exeIfetchErrL2, IFB_exeMcrxrL2, IFB_exeOpForExe2L2,
     IFB_exeRfciL2, IFB_exeRfiL2, IFB_exeScL2, IFB_extStopAck, IFB_fetchReq, IFB_iac1BitsEq,
     IFB_iac1GtIar, IFB_iac2BitsEq, IFB_iac2GtIar, IFB_iac3BitsEq, IFB_iac3GtIar,
     IFB_iac4BitsEq, IFB_iac4GtIar, IFB_icuCancelDataL2, IFB_isAbortForICU,
     IFB_isAbortForMMU, IFB_isEA, IFB_isNL, IFB_isNP, IFB_isOcmAbus,
     IFB_nonSpecAcc, IFB_ocmAbort, IFB_postEntry, IFB_rstStepPend, IFB_rstStuffPend,
     IFB_runStL2, IFB_seIdleSt, IFB_sprDataBus, IFB_stepStL2, IFB_stopAck, IFB_stuffStL2,
     IFB_swapEnable, IFB_swapStL2, IFB_traceData, IFB_traceESL2, IFB_tracePipeHold,
     IFB_traceType, IFB_wbDisableDbL2, IFB_wbIar,  APU_dcdCrField,
     APU_dcdRc, APU_sleepReq, CB, DBG_exeTE, DBG_iacEn, DBG_immdTE, DBG_stopReq,
     DBG_wbTE, DBG_weakStopReq, DCU_sleepReq, EXE_cc, EXE_sprDataBus,
     EXE_xer, ICU_ifbE, ICU_ifbEDataBus, ICU_ifbError, ICU_ifbO,
     ICU_ifbODataBus, ICU_isCA, ICU_sleepReq, ICU_syncAfterReset, ICU_traceEnable,
     JTG_dbdrPulse, JTG_inst, JTG_step, JTG_stopReq, JTG_stuff, LSSD_coreTestEn,
     MMU_isStatus, MMU_tlbSXHit, PCL_Rbit, PCL_blkFlush, PCL_dIcmpForStep,
     PCL_dIcmpForStuff, PCL_dcdHoldForIFB, PCL_exe2DataE1, PCL_exe2DataE2,
     PCL_exe2FlushorClear, PCL_exe2Full, PCL_exe2IarE1, PCL_exe2IarE2, PCL_exeHoldForCr,
     PCL_exeIarHold, PCL_icuOp_0, PCL_sprHold, PCL_wbClearTerms, PCL_wbFull, PCL_wbHold,
     PCL_wbStorageEnd, PCL_wbStorageOp, PGM_apuPresent, TRC_fifoFull, TRC_fifoOneEntryFree,
     TRC_se, TRC_seCtrEqZeroL2, TRC_sleepReq, VCT_anySwap, VCT_msrWE, VCT_swap01, VCT_swap23,
     VCT_vectorBus, VCT_wbFlush, VCT_wbRfci, VCT_wbRfi, VCT_wbSuppress, XXX_traceDisable,
     coreReset, dcdValidOp_Neg,  MMU_isParityErr, ICU_parityErrE, ICU_tagParityErr,
     ICU_parityErrO, IFB_exeISideMachChk, ICU_CCR0IPE, ICU_CCR0TPE);

output  IFB_TEL2, IFB_cntxSync, IFB_cntxSyncOCM, IFB_coreSleepReqL2, IFB_dcdBubble,
     IFB_dcdFullApuL2, IFB_dcdRegE1, IFB_dcdRegE2, IFB_exeClear, IFB_exeCorrect,
     IFB_exeDbgBrTaken, IFB_exeDisableDbL2, IFB_exeFlushA, IFB_exeFlushB, IFB_exeFullL2,
     IFB_exeMcrxrL2, IFB_exeOpForExe2L2, IFB_exeRfciL2, IFB_exeRfiL2, IFB_exeScL2,
     IFB_extStopAck, IFB_fetchReq, IFB_iac1BitsEq, IFB_iac1GtIar, IFB_iac2BitsEq,
     IFB_iac2GtIar, IFB_iac3BitsEq, IFB_iac3GtIar, IFB_iac4BitsEq, IFB_iac4GtIar,
     IFB_icuCancelDataL2, IFB_isAbortForMMU, IFB_isNL, IFB_isNP, IFB_nonSpecAcc, IFB_ocmAbort,
     IFB_postEntry, IFB_rstStepPend, IFB_rstStuffPend, IFB_runStL2, IFB_seIdleSt, IFB_stepStL2,
     IFB_stopAck, IFB_stuffStL2, IFB_swapEnable, IFB_swapStL2, IFB_tracePipeHold,
     IFB_wbDisableDbL2,  IFB_exeISideMachChk;


input  APU_dcdRc, APU_sleepReq, DBG_iacEn, DBG_stopReq, DBG_weakStopReq, DCU_sleepReq,
     ICU_ifbE, ICU_ifbO, ICU_isCA, ICU_sleepReq, ICU_syncAfterReset, ICU_traceEnable,
     JTG_dbdrPulse, JTG_step, JTG_stopReq, JTG_stuff, LSSD_coreTestEn, MMU_tlbSXHit, PCL_Rbit,
     PCL_blkFlush, PCL_dIcmpForStep, PCL_dIcmpForStuff, PCL_exe2DataE1, PCL_exe2DataE2,
     PCL_exe2FlushorClear, PCL_exe2Full, PCL_exe2IarE1, PCL_exe2IarE2, PCL_exeHoldForCr,
     PCL_exeIarHold, PCL_icuOp_0, PCL_sprHold, PCL_wbClearTerms, PCL_wbFull, PCL_wbHold,
     PCL_wbStorageEnd, PCL_wbStorageOp, PGM_apuPresent, TRC_fifoFull, TRC_fifoOneEntryFree,
     TRC_se, TRC_seCtrEqZeroL2, TRC_sleepReq, VCT_anySwap, VCT_msrWE, VCT_swap01, VCT_swap23,
     VCT_wbFlush, VCT_wbRfci, VCT_wbRfi, VCT_wbSuppress, XXX_traceDisable, coreReset,
     dcdValidOp_Neg,  MMU_isParityErr, ICU_parityErrE, ICU_tagParityErr, ICU_parityErrO,
     ICU_CCR0IPE, ICU_CCR0TPE;

output [0:10]  IFB_TETypeL2;
output [0:1]  IFB_traceType;
output [0:29]  IFB_traceData;
output [0:31]  IFB_dcdDataIn_Neg;
output [0:7]  IFB_diagBus;
output [0:29]  IFB_isEA;
output [0:2]  IFB_isAbortForICU;
output [0:1]  IFB_dcdFullL2;
output [0:31]  IFB_sprDataBus;
output [0:1]  IFB_traceESL2;
output [0:29]  IFB_isOcmAbus;
output [0:4]  IFB_exeIfetchErrL2;
output [0:29]  IFB_wbIar;
output [0:31]  IFB_dcdApu;


input [0:31]  EXE_sprDataBus;
input [0:1]  ICU_ifbError;
input [0:2]  DBG_immdTE;
input [0:4]  DBG_exeTE;
input [0:31]  ICU_ifbEDataBus;
input [0:2]  APU_dcdCrField;
input [0:2]  EXE_xer;
input        CB;
input [0:7]  VCT_vectorBus;
input [0:31]  ICU_ifbODataBus;
input [0:2]  PCL_dcdHoldForIFB;
input [0:3]  EXE_cc;
input [0:1]  MMU_isStatus;
input [0:4]  DBG_wbTE;
input [0:31]  JTG_inst;

// Buses in the design
wire  [6:20]  exeDataL2;
wire  [0:1]  exeCrtMuxSel;
wire  [0:3]  exeDataBrBOL2;
wire  [0:4]  exeDataBrBIL2;
wire  [0:31]  crL2;
wire  [0:31]  linkL2;
wire  [0:29]  refetchPipeAddr;
wire  [0:31]  ctrL2;
wire  [0:15]  evprL2;
wire  [0:29]  exeIarL2;
wire  [0:29]  srr02_Neg;
wire  [0:29]  iac4L2;
wire  [0:29]  iac3L2;
wire  [0:29]  iac2L2;
wire  [0:29]  iac1L2;
wire  [0:29]  lrCtrNormal_Neg;
wire  [0:29]  lrCtrSe_Neg;
wire  [0:4]  dcdDataBO;
wire  [0:4]  dcdDataBI;
wire  [0:1]  dcdIarMuxSel;
wire  [0:1]  dcdDataMuxSel;
wire  [0:1]  dcdBrTarSel;
wire  [0:1]  traceDataSel;
wire  [0:1]  tracePipeStageSel;
wire  [0:1]  pfb0BrTarSel;
wire  [0:1]  mux048Sel;
wire  [0:1]  pfb0IarMuxSel;
wire  [0:1]  refetchLcarMuxSel;
wire  [0:1]  pfb0DataMuxSel;
wire  [0:1]  lcarMuxSel;
wire  [0:1]  refetchPipeStageSel;
wire  [0:4]  wbTEL2;
wire  [0:29]  isEaBuf;
wire  [0:5]  dcdDataPri;
wire  [0:10]  dcdDataSec;
wire  [0:31]  dcdDataL2;
wire  [0:31]  pfb0DataL2;

wire        IFB_dcdRegE1_int;
wire        IFB_dcdRegE2_int;
wire        IFB_exeDbgBrTaken_int;
wire        IFB_exeFullL2_int;
wire        IFB_exeMcrxrL2_int;
wire        IFB_exeOpForExe2L2_int;
wire        IFB_exeRfciL2_int;
wire        IFB_exeRfiL2_int;
wire        IFB_exeScL2_int;
wire        IFB_swapEnable_int;
wire        IFB_tracePipeHold_int;

wire dcdPlaCr0En, dcdPlaBForBr, dcdPlaBcForBr, dcdPlaMtsprForBr, dcdMtCtr;
wire dcdCrUpdate, dcdLrUpdate, dcdCtrUpForBcctr,  dcdPlaMtspr;
wire dcdPlaCrBfEn, dcdPlaMtcrf, dcdPlaB, dcdPlaBc;
wire coreResetL2, dbdrPulseCntlE1, dcdApuE1, dcdClear;
wire dcdFlush, dcdFullL2, exeDataE1, exeDataE2, exeDataSel;
wire exeFlush, exeFlushorClear, exeIarE2, isEA_22DlyL2, isEA_27DlyL2;
wire lcarE2, pfb0E1, pfb0E2, pfb0FullL2, pfb1DataMuxSel, pfb1E2;
wire pfb1IarMuxSel, refetchAddrSel, saveForTraceE1, saveForTraceE2;
wire seCtrSt, wbDataE1, wbDataE2, wbFlushOrClear, wbIarE1, wbIarE2;
wire branchTarCrt, dcdCorrect_Neg, dcdTarget_Neg, exeCorrect_Neg, exeIsyncL2;
wire exeMtCtr, exeMtLr, lcar_29,pfb0Target_Neg, wbBrTakenL2, wbIsyncL2, wbMtCtrL2;
wire wbMtLrL2, ctrEq1, ctrEq2,exeBcL2;
wire exeBrAndLink, exeMfsprL2, exeMtsprL2;
wire exe2Cr0EnL2, exeCr0EnL2;
wire exeCrAndL2, exeCrBfEnL2, exeCrNegBBL2;
wire isEaMuxSel, exeCrNegBTL2, exeCrOrL2, exeCrXorL2, exeCrMcrfL2, exeMtcrfL2;
wire exeStwcxL2, exeTlbsxL2, exeBL2, exeCrUpdateL2;
wire exectrUpForBcctrL2, exeDataBr_5L2, exeDataBr_21L2, exeDataLKL2, exeLrUpdateL2;
wire exeMtCtrL2, dcdPlaCrAnd;
wire dcdPlaCrNegBB, dcdPlaCrNegBT, dcdPlaCrOr, dcdPlaCrXor ;
wire dcdPlaIsync, dcdPlaCrMcrf, dcdPlaMcrxr, dcdPlaMfspr, dcdPlaRfci, dcdPlaRfi;
wire dcdPlaExe2Op, dcdPlaSc, dcdPlaStwcx, dcdPlaTlbsx, pfb0PlaB, pfb0PlaBc;
wire dcdCrtBpntLrCtr,dcdCrtE2, dcdCrtMuxSel, exeCrtBpntLrCtr;
wire exeCrtE2, dcdDataBD_0;
wire IFB_TEL2;

//assign output ports to 'internal' signals
assign IFB_dcdRegE1 = IFB_dcdRegE1_int;
assign IFB_dcdRegE2 = IFB_dcdRegE2_int;
assign IFB_exeDbgBrTaken = IFB_exeDbgBrTaken_int;
assign IFB_exeFullL2 = IFB_exeFullL2_int;
assign IFB_exeMcrxrL2 = IFB_exeMcrxrL2_int;
assign IFB_exeOpForExe2L2 = IFB_exeOpForExe2L2_int;
assign IFB_exeRfciL2 = IFB_exeRfciL2_int;
assign IFB_exeRfiL2 = IFB_exeRfiL2_int;
assign IFB_exeScL2 = IFB_exeScL2_int;
assign IFB_swapEnable = IFB_swapEnable_int;
assign IFB_tracePipeHold = IFB_tracePipeHold_int;


p405s_dcdInstPlaForBr
 dcdInstPlaForBrPla(
  .priOp_0(dcdDataPri[0]), 
  .priOp_1(dcdDataPri[1]), 
  .priOp_2(dcdDataPri[2]), 
  .priOp_3(dcdDataPri[3]),
  .priOp_4(dcdDataPri[4]), 
  .priOp_5(dcdDataPri[5]), 
  .secOp_21(dcdDataSec[0]), 
  .secOp_22(dcdDataSec[1]), 
  .secOp_23(dcdDataSec[2]), 
  .secOp_24(dcdDataSec[3]),
  .secOp_25(dcdDataSec[4]), 
  .secOp_26(dcdDataSec[5]), 
  .secOp_27(dcdDataSec[6]), 
  .secOp_28(dcdDataSec[7]), 
  .secOp_29(dcdDataSec[8]), 
  .secOp_30(dcdDataSec[9]),
  .Rc(dcdDataSec[10]), 
  .plaCr0En(dcdPlaCr0En), 
  .plaB(dcdPlaBForBr), 
  .plaBc(dcdPlaBcForBr), 
  .plaMtspr(dcdPlaMtsprForBr)
);



p405s_dcdEquations
 dcdEquationFunc(
  .dcdMtCtr(dcdMtCtr), 
  .dcdCrUpDate(dcdCrUpdate), 
  .dcdLrUpdate(dcdLrUpdate), 
  .dcdCtrUpForBcctr(dcdCtrUpForBcctr),
  .dcdDataRcLK(dcdDataL2[31]), 
  .dcdPlaCr0En(dcdPlaCr0En), 
  .dcdPlaMtSpr(dcdPlaMtspr), 
  .dcdDataSprf(dcdDataL2[11:20]), 
  .dcdPlaCrBfEn(dcdPlaCrBfEn), 
  .dcdPlaMtcrf(dcdPlaMtcrf),
  .dcdPlaB(dcdPlaB), 
  .dcdPlaBc(dcdPlaBc), 
  .dcdDataBO_2(dcdDataL2[8])
);

p405s_fetcherCntl
 fetcherCntl( 
   .IFB_TEL2(IFB_TEL2),
   .IFB_TETypeL2(IFB_TETypeL2[0:10]),
   .IFB_cntxSync(IFB_cntxSync),
   .IFB_cntxSyncOCM(IFB_cntxSyncOCM),
   .IFB_coreSleepReqL2(IFB_coreSleepReqL2),
   .IFB_dcdFullApuL2(IFB_dcdFullApuL2),
   .IFB_dcdFullL2(IFB_dcdFullL2[0:1]),
   .IFB_diagBus(IFB_diagBus[0:7]),
   .IFB_exeFlushA(IFB_exeFlushA),
   .IFB_exeFlushB(IFB_exeFlushB),
   .IFB_extStopAck(IFB_extStopAck),
   .IFB_fetchReq(IFB_fetchReq),
   .IFB_icuCancelDataL2(IFB_icuCancelDataL2),
   .IFB_isAbortForICU(IFB_isAbortForICU[0:2]),
   .IFB_isAbortForMMU(IFB_isAbortForMMU),
   .IFB_nonSpecAcc(IFB_nonSpecAcc),
   .IFB_ocmAbort(IFB_ocmAbort),
   .IFB_postEntry(IFB_postEntry),
   .IFB_rstStepPend(IFB_rstStepPend),
   .IFB_rstStuffPend(IFB_rstStuffPend),
   .IFB_stopAck(IFB_stopAck),
   .IFB_traceESL2(IFB_traceESL2[0:1]),
   .IFB_traceType(IFB_traceType[0:1]),
   .coreResetL2(coreResetL2),
   .dbdrPulseCntlE1(dbdrPulseCntlE1),
   .dcdApuE1(dcdApuE1),
   .dcdBrTarSel(dcdBrTarSel[0:1]),
   .dcdBubble(IFB_dcdBubble),
   .dcdClear(dcdClear),
   .dcdDataMuxSel(dcdDataMuxSel[0:1]),
   .dcdE1(IFB_dcdRegE1_int),
   .dcdE2(IFB_dcdRegE2_int),
   .dcdFlush(dcdFlush),
   .dcdFullL2(dcdFullL2),
   .dcdIarMuxSel(dcdIarMuxSel[0:1]),
   .exeClear(IFB_exeClear),
   .exeDataE1(exeDataE1),
   .exeDataE2(exeDataE2),
   .exeDataSel(exeDataSel),
   .exeFlush(exeFlush),
   .exeFlushorClear(exeFlushorClear),
   .exeFullL2(IFB_exeFullL2_int),
   .exeIarE2(exeIarE2),
   .isEA_22DlyL2(isEA_22DlyL2),
   .isEA_27DlyL2(isEA_27DlyL2),
   .isEaMuxSel(isEaMuxSel),
   .lcarE2(lcarE2),
   .lcarMuxSel(lcarMuxSel[0:1]),
   .mux048Sel(mux048Sel[0:1]),
   .nxtSwapSt(IFB_swapEnable_int),
   .pfb0BrTarSel(pfb0BrTarSel[0:1]),
   .pfb0DataMuxSel(pfb0DataMuxSel[0:1]),
   .pfb0E1(pfb0E1),
   .pfb0E2(pfb0E2),
   .pfb0FullL2(pfb0FullL2),
   .pfb0IarMuxSel(pfb0IarMuxSel[0:1]),
   .pfb1DataMuxSel(pfb1DataMuxSel),
   .pfb1E2(pfb1E2),
   .pfb1IarMuxSel(pfb1IarMuxSel),
   .refetchAddrSel(refetchAddrSel),
   .refetchLcarMuxSel(refetchLcarMuxSel[0:1]),
   .refetchPipeStageSel(refetchPipeStageSel[0:1]),
   .runStL2(IFB_runStL2),
   .saveForTraceE1(saveForTraceE1),
   .saveForTraceE2(saveForTraceE2),
   .seCtrSt(seCtrSt),
   .seIdleSt(IFB_seIdleSt),
   .stepStL2(IFB_stepStL2),
   .stuffStL2(IFB_stuffStL2),
   .swapStL2(IFB_swapStL2),
   .traceDataSel(traceDataSel[0:1]),
   .tracePipeHold(IFB_tracePipeHold_int),
   .tracePipeStageSel(tracePipeStageSel[0:1]),
   .wbDataE1(wbDataE1),
   .wbDataE2(wbDataE2),
   .wbFlushOrClear(wbFlushOrClear),
   .wbIarE1(wbIarE1),
   .wbIarE2(wbIarE2),
   .APU_dcdValidOp_Neg(dcdValidOp_Neg),
   .APU_sleepReq(APU_sleepReq),
   .CB(CB),
   .DBG_immdTE(DBG_immdTE[0:2]),
   .DBG_stopReq(DBG_stopReq),
   .DBG_wbTE(DBG_wbTE[0:4]),
   .DBG_weakStopReq(DBG_weakStopReq),
   .DCU_sleepReq(DCU_sleepReq),
   .ICU_ifbE(ICU_ifbE),
   .ICU_ifbO(ICU_ifbO),
   .ICU_isCA(ICU_isCA),
   .ICU_sleepReq(ICU_sleepReq),
   .ICU_syncAfterReset(ICU_syncAfterReset),
   .ICU_traceEnable(ICU_traceEnable),
   .JTG_dbdrPulse(JTG_dbdrPulse),
   .JTG_step(JTG_step),
   .JTG_stopReq(JTG_stopReq),
   .JTG_stuff(JTG_stuff),
   .LSSD_coreTestEn(LSSD_coreTestEn),
   .MMU_isStatus(MMU_isStatus[0:1]),
   .PCL_blkFlush(PCL_blkFlush),
   .PCL_dIcmpForStep(PCL_dIcmpForStep),
   .PCL_dIcmpForStuff(PCL_dIcmpForStuff),
   .PCL_dcdHoldForIFB(PCL_dcdHoldForIFB[0:2]),
   .PCL_exe2Full(PCL_exe2Full),
   .PCL_exeIarHold(PCL_exeIarHold),
   .PCL_icuOp_0(PCL_icuOp_0),
   .PCL_wbClearTerms(PCL_wbClearTerms),
   .PCL_wbFull(PCL_wbFull),
   .PCL_wbHold(PCL_wbHold),
   .PCL_wbStorageEnd(PCL_wbStorageEnd),
   .PCL_wbStorageOp(PCL_wbStorageOp),
   .PGM_apuPresent(PGM_apuPresent),
   .TRC_fifoFull(TRC_fifoFull),
   .TRC_fifoOneEntryFree(TRC_fifoOneEntryFree),
   .TRC_se(TRC_se),
   .TRC_seCtrEqZeroL2(TRC_seCtrEqZeroL2),
   .TRC_sleepReq(TRC_sleepReq),
   .VCT_anySwap(VCT_anySwap),
   .VCT_msrWE(VCT_msrWE),
   .VCT_swap01(VCT_swap01),
   .VCT_swap23(VCT_swap23),
   .VCT_wbFlush(VCT_wbFlush),
   .VCT_wbRfci(VCT_wbRfci),
   .VCT_wbRfi(VCT_wbRfi),
   .VCT_wbSuppress(VCT_wbSuppress),
   .XXX_traceDisable(XXX_traceDisable),
   .branchTarCrt(branchTarCrt),
   .coreReset(coreReset),
   .dcdCorrect_Neg(dcdCorrect_Neg),
   .dcdData_5(dcdDataL2[5]),
   .dcdData_21(dcdDataL2[21]),
   .dcdData_30(dcdDataL2[30]),
   .dcdTarget_Neg(dcdTarget_Neg),
   .exeCorrect_Neg(exeCorrect_Neg), 
   .exeIsyncL2(exeIsyncL2), 
   .exeMtCtr(exeMtCtr),
   .exeMtLr(exeMtLr), 
   .exeRfciL2(IFB_exeRfciL2_int), 
   .exeRfiL2(IFB_exeRfiL2_int), 
   .exeScL2(IFB_exeScL2_int),
   .isEA_22(isEaBuf[22]),
   .isEA_27(isEaBuf[27]),
   .isEA_29(isEaBuf[29]),
   .lcar_29(lcar_29),
   .pfb0Data_5(pfb0DataL2[5]),
   .pfb0Data_21(pfb0DataL2[21]),
   .pfb0Data_30(pfb0DataL2[30]),
   .pfb0Target_Neg(pfb0Target_Neg),
   .wbBrTakenL2(wbBrTakenL2),
   .wbIsyncL2(wbIsyncL2),
   .wbMtCtrL2(wbMtCtrL2),
   .wbMtLrL2(wbMtLrL2),
   .wbTEL2(wbTEL2[0:4]),
   .MMU_isParityErr(MMU_isParityErr)
);

p405s_sprRegs
 sprRegsSch( 
   .IFB_sprDataBus(IFB_sprDataBus[0:31]),
   .ctrEq1(ctrEq1),
   .ctrEq2(ctrEq2),
   .ctrL2(ctrL2[0:31]),
   .evprL2(evprL2[0:15]),
   .exeMtCtr(exeMtCtr),
   .exeMtLr(exeMtLr),
   .iac1L2(iac1L2[0:29]),
   .iac2L2(iac2L2[0:29]),
   .iac3L2(iac3L2[0:29]),
   .iac4L2(iac4L2[0:29]),
   .linkL2(linkL2[0:31]),
   .lrCtrNormal_Neg(lrCtrNormal_Neg[0:29]),
   .lrCtrSe_Neg(lrCtrSe_Neg[0:29]),
   .srr02_Neg(srr02_Neg[0:29]),
   .CB(CB),
   .EXE_sprDataBus(EXE_sprDataBus[0:31]),
   .PCL_sprHold(PCL_sprHold),
   .VCT_swap01(VCT_swap01),
   .VCT_swap23(VCT_swap23),
   .VCT_wbRfci(VCT_wbRfci),
   .coreResetL2(coreResetL2),
   .crL2(crL2[0:31]),
   .exeBcL2(exeBcL2),
   .exeBrAndLink(exeBrAndLink),
   .exeDataBO_2(exeDataL2[8]),
   .exeDataSprf(exeDataL2[11:20]),
   .exeIar(exeIarL2[0:29]),
   .exeMfsprL2(exeMfsprL2),
   .exeMtsprL2(exeMtsprL2),
   .refetchPipeAddr(refetchPipeAddr[0:29]),
   .saveForTraceE1(saveForTraceE1),
   .saveForTraceE2(saveForTraceE2),
   .seCtrSt(seCtrSt),
   .swapEnable(IFB_swapEnable_int),
   .tracePipeHold(IFB_tracePipeHold_int),
   .wbMtCtrL2(wbMtCtrL2)
);

p405s_condReg
 condReg( 
   .crL2(crL2[0:31]),
   .CB(CB),
   .EXE_cc(EXE_cc[0:3]),
   .EXE_sprDataBus(EXE_sprDataBus[0:31]),
   .EXE_xer(EXE_xer[0:2]),
   .MMU_tlbSXHit(MMU_tlbSXHit),
   .PCL_Rbit(PCL_Rbit),
   .PCL_exeHoldForCr(PCL_exeHoldForCr),
   .coreResetL2(coreResetL2),
   .exe2Cr0EnL2(exe2Cr0EnL2),
   .exeCr0EnL2(exeCr0EnL2),
   .exeCrAndL2(exeCrAndL2),
   .exeCrBfEnL2(exeCrBfEnL2),
   .exeCrNegBBL2(exeCrNegBBL2),
   .exeCrNegBTL2(exeCrNegBTL2),
   .exeCrOrL2(exeCrOrL2),
   .exeCrXorL2(exeCrXorL2),
   .exeDataL2(exeDataL2[6:20]),
   .exeFlush(exeFlush),
   .exeMcrfL2(exeCrMcrfL2),
   .exeMcrxrL2(IFB_exeMcrxrL2_int),
   .exeMtcrfL2(exeMtcrfL2),
   .exeOpForExe2L2(IFB_exeOpForExe2L2_int),
   .exeStwcxL2(exeStwcxL2),
   .exeTlbsxL2(exeTlbsxL2)
);

p405s_exeIfb
 exeIfb( 
   .exe2Cr0EnL2(exe2Cr0EnL2),
   .exeBL2(exeBL2),
   .exeBcL2(exeBcL2),
   .exeCr0EnL2(exeCr0EnL2),
   .exeCrAndL2(exeCrAndL2),
   .exeCrBfEnL2(exeCrBfEnL2),
   .exeCrNegBBL2(exeCrNegBBL2),
   .exeCrNegBTL2(exeCrNegBTL2),
   .exeCrOrL2(exeCrOrL2),
   .exeCrUpdateL2(exeCrUpdateL2),
   .exeCrXorL2(exeCrXorL2),
   .exeCtrUpForBcctrL2(exectrUpForBcctrL2),
   .exeDataBrBIL2(exeDataBrBIL2[0:4]),
   .exeDataBrBOL2(exeDataBrBOL2[0:3]),
   .exeDataBr_5L2(exeDataBr_5L2),
   .exeDataBr_21L2(exeDataBr_21L2),
   .exeDataL2(exeDataL2[6:20]),
   .exeDataLKL2(exeDataLKL2),
   .exeIsyncL2(exeIsyncL2),
   .exeLrUpdateL2(exeLrUpdateL2),
   .exeMcrfL2(exeCrMcrfL2),
   .exeMcrxrL2(IFB_exeMcrxrL2_int),
   .exeMfsprL2(exeMfsprL2),
   .exeMtCtrL2(exeMtCtrL2),
   .exeMtcrfL2(exeMtcrfL2),
   .exeMtsprL2(exeMtsprL2),
   .exeOpForExe2L2(IFB_exeOpForExe2L2_int),
   .exeRfciL2(IFB_exeRfciL2_int),
   .exeRfiL2(IFB_exeRfiL2_int),
   .exeScL2(IFB_exeScL2_int),
   .exeStwcxL2(exeStwcxL2),
   .exeTlbsxL2(exeTlbsxL2),
   .wbIsyncL2(wbIsyncL2),
   .wbMtCtrL2(wbMtCtrL2),
   .wbMtLrL2(wbMtLrL2),
   .APU_dcdCrField(APU_dcdCrField[0:2]),
   .APU_dcdRc(APU_dcdRc),
   .APU_dcdValidOp_Neg(dcdValidOp_Neg),
   .CB(CB),
   .PCL_exe2DataE1(PCL_exe2DataE1),
   .PCL_exe2DataE2(PCL_exe2DataE2),
   .PCL_exe2FlushorClear(PCL_exe2FlushorClear),
   .dcdCrUpdate(dcdCrUpdate),
   .dcdCtrUpForBcctr(dcdCtrUpForBcctr),
   .dcdDataL2(dcdDataL2[5:21]),
   .dcdDataLK(dcdDataL2[31]),
   .dcdLrUpdate(dcdLrUpdate),
   .dcdMtCtr(dcdMtCtr),
   .dcdPlaB(dcdPlaB),
   .dcdPlaBc(dcdPlaBc),
   .dcdPlaCr0En(dcdPlaCr0En),
   .dcdPlaCrAnd(dcdPlaCrAnd),
   .dcdPlaCrBfEn(dcdPlaCrBfEn),
   .dcdPlaCrNegBB(dcdPlaCrNegBB),
   .dcdPlaCrNegBT(dcdPlaCrNegBT),
   .dcdPlaCrOr(dcdPlaCrOr),
   .dcdPlaCrXor(dcdPlaCrXor),
   .dcdPlaExe2Op(dcdPlaExe2Op),
   .dcdPlaIsync(dcdPlaIsync),
   .dcdPlaMcrf(dcdPlaCrMcrf),
   .dcdPlaMcrxr(dcdPlaMcrxr),
   .dcdPlaMfspr(dcdPlaMfspr),
   .dcdPlaMtcrf(dcdPlaMtcrf),
   .dcdPlaMtspr(dcdPlaMtspr),
   .dcdPlaRfci(dcdPlaRfci),
   .dcdPlaRfi(dcdPlaRfi),
   .dcdPlaSc(dcdPlaSc),
   .dcdPlaStwcx(dcdPlaStwcx),
   .dcdPlaTlbsx(dcdPlaTlbsx),
   .exeDataE1(exeDataE1),
   .exeDataE2(exeDataE2),
   .exeDataSel(exeDataSel),
   .exeFlushorClear(exeFlushorClear),
   .exeMtCtr(exeMtCtr),
   .exeMtLr(exeMtLr),
   .wbDataE1(wbDataE1),
   .wbDataE2(wbDataE2),
   .wbFlushOrClear(wbFlushOrClear)
);

p405s_pfb0InstPla
 pfb0InstPlaPers(
   .plaB(pfb0PlaB),
   .plaBc(pfb0PlaBc),
   .priOp_0(pfb0DataL2[0]),
   .priOp_1(pfb0DataL2[1]),
   .priOp_2(pfb0DataL2[2]),
   .priOp_3(pfb0DataL2[3]),
   .priOp_4(pfb0DataL2[4]),
   .priOp_5(pfb0DataL2[5]),
   .secOp_21(pfb0DataL2[21]),
   .secOp_22(pfb0DataL2[22]),
   .secOp_23(pfb0DataL2[23]),
   .secOp_24(pfb0DataL2[24]),
   .secOp_25(pfb0DataL2[25]),
   .secOp_26(pfb0DataL2[26]),
   .secOp_27(pfb0DataL2[27]),
   .secOp_28(pfb0DataL2[28]),
   .secOp_29(pfb0DataL2[29]),
   .secOp_30(pfb0DataL2[30])
);

p405s_dcdInstPla
 dcdInstPlaPers(
   .priOp_0(dcdDataL2[0]),
   .priOp_1(dcdDataL2[1]),
   .priOp_2(dcdDataL2[2]),
   .priOp_3(dcdDataL2[3]),
   .priOp_4(dcdDataL2[4]),
   .priOp_5(dcdDataL2[5]),
   .secOp_21(dcdDataL2[21]),
   .secOp_22(dcdDataL2[22]),
   .secOp_23(dcdDataL2[23]),
   .secOp_24(dcdDataL2[24]),
   .secOp_25(dcdDataL2[25]),
   .secOp_26(dcdDataL2[26]),
   .secOp_27(dcdDataL2[27]),
   .secOp_28(dcdDataL2[28]),
   .secOp_29(dcdDataL2[29]),
   .secOp_30(dcdDataL2[30]),
   .Rc(dcdDataL2[31]),
   .plaExe2Op(dcdPlaExe2Op),
   .plaCrBfEn(dcdPlaCrBfEn),
   .plaMtspr(dcdPlaMtspr),
   .plaMfspr(dcdPlaMfspr),
   .plaB(dcdPlaB),
   .plaBc(dcdPlaBc),
   .plaCrAnd(dcdPlaCrAnd),
   .plaCrOr(dcdPlaCrOr),
   .plaCrXor(dcdPlaCrXor),
   .plaCrNegBB(dcdPlaCrNegBB),
   .plaCrNegBT(dcdPlaCrNegBT),
   .plaMcrf(dcdPlaCrMcrf),
   .plaMcrxr(dcdPlaMcrxr),
   .plaMtcrf(dcdPlaMtcrf),
   .plaStwcx(dcdPlaStwcx),
   .plaTlbsx(dcdPlaTlbsx),
   .plaRfi(dcdPlaRfi),
   .plaRfci(dcdPlaRfci),
   .plaSc(dcdPlaSc),
   .plaIsync(dcdPlaIsync)
);

p405s_branchCntl
 branchCntl( 
   .IFB_exeCorrect(IFB_exeCorrect),
   .IFB_exeDbgBrTaken(IFB_exeDbgBrTaken_int),
   .branchTarCrt(branchTarCrt),
   .dcdCorrect_Neg(dcdCorrect_Neg),
   .dcdCrtBpntLrCtr(dcdCrtBpntLrCtr),
   .dcdCrtE2(dcdCrtE2),
   .dcdCrtMuxSel(dcdCrtMuxSel),
   .dcdTarget_Neg(dcdTarget_Neg),
   .exeBrAndLink(exeBrAndLink),
   .exeCorrect_Neg(exeCorrect_Neg),
   .exeCrtBpntLrCtr(exeCrtBpntLrCtr),
   .exeCrtE2(exeCrtE2),
   .exeCrtMuxSel(exeCrtMuxSel[0:1]),
   .pfb0Target_Neg(pfb0Target_Neg),
   .CB(CB),
   .PCL_dcdHoldForIFB(PCL_dcdHoldForIFB[2]),
   .PCL_exeIarHold(PCL_exeIarHold),
   .crL2(crL2[0:31]),
   .ctrEq1L2(ctrEq1),
   .ctrEq2L2(ctrEq2),
   .dcdClear(dcdClear),
   .dcdDataBD_0(dcdDataBD_0),
   .dcdDataBI(dcdDataBI[0:4]),
   .dcdDataBO(dcdDataBO[0:4]),
   .dcdDataL2(dcdDataL2[11:20]),
   .dcdDataLK(dcdDataL2[31]),
   .dcdFlush(dcdFlush),
   .dcdFullL2(dcdFullL2),
   .dcdPlaB(dcdPlaBForBr),
   .dcdPlaBc(dcdPlaBcForBr),
   .dcdPlaMtspr(dcdPlaMtsprForBr),
   .dcdPriOp_5(dcdDataPri[5]),
   .dcdSecOp_0(dcdDataSec[0]),
   .exe2Cr0EnL2(exe2Cr0EnL2),
   .exeBL2(exeBL2),
   .exeBcL2(exeBcL2),
   .exeCrUpdateL2(exeCrUpdateL2),
   .exeCtrUpForBcctrL2(exectrUpForBcctrL2),
   .exeDataBrBIL2(exeDataBrBIL2[0:4]),
   .exeDataBrBOL2(exeDataBrBOL2[0:3]),
   .exeDataBr_5L2(exeDataBr_5L2),
   .exeDataLKL2(exeDataLKL2),
   .exeFullL2(IFB_exeFullL2_int),
   .exeLrUpdateL2(exeLrUpdateL2),
   .exeMtCtrL2(exeMtCtrL2),
   .pfb0DataBD_0(pfb0DataL2[16]),
   .pfb0DataBO_0(pfb0DataL2[6]),
   .pfb0DataBO_2(pfb0DataL2[8]),
   .pfb0DataBO_4(pfb0DataL2[10]),
   .pfb0FullL2(pfb0FullL2),
   .pfb0PlaB(pfb0PlaB),
   .pfb0PlaBc(pfb0PlaBc),
   .pfb0PriOp_5(pfb0DataL2[5]),
   .pfb0SecOp_0(pfb0DataL2[21]),
   .tracePipeHold(IFB_tracePipeHold_int)
);

p405s_fetcher
 fetcherSch( 
   .IFB_dcdApu(IFB_dcdApu[0:31]),
   .IFB_dcdDataIn_Neg(IFB_dcdDataIn_Neg[0:31]),
   .IFB_exeDisableDbL2(IFB_exeDisableDbL2),
   .IFB_exeIfetchErrL2(IFB_exeIfetchErrL2[0:4]),
   .IFB_iac1BitsEq(IFB_iac1BitsEq),
   .IFB_iac1GtIar(IFB_iac1GtIar),
   .IFB_iac2BitsEq(IFB_iac2BitsEq),
   .IFB_iac2GtIar(IFB_iac2GtIar),
   .IFB_iac3BitsEq(IFB_iac3BitsEq),
   .IFB_iac3GtIar(IFB_iac3GtIar),
   .IFB_iac4BitsEq(IFB_iac4BitsEq),
   .IFB_iac4GtIar(IFB_iac4GtIar),
   .IFB_isEA(IFB_isEA[0:29]),
   .IFB_isNL(IFB_isNL),
   .IFB_isNP(IFB_isNP),
   .IFB_isOcmAbus(IFB_isOcmAbus[0:29]),
   .IFB_traceData(IFB_traceData[0:29]),
   .IFB_wbDisableDbL2(IFB_wbDisableDbL2),
   .IFB_wbIar(IFB_wbIar[0:29]),
   .dcdData2L2(dcdDataBI[0:4]),
   .dcdDataBD_0(dcdDataBD_0),
   .dcdDataBO(dcdDataBO[0:4]),
   .dcdDataL2(dcdDataL2[0:31]),
   .dcdDataPri(dcdDataPri[0:5]),
   .dcdDataSec(dcdDataSec[0:10]),
   .exeIarL2(exeIarL2[0:29]),
   .isEaBuf(isEaBuf[0:29]),
   .lcar_29(lcar_29),
   .pfb0DataL2(pfb0DataL2[0:31]),
   .refetchPipeAddr(refetchPipeAddr[0:29]),
   .wbBrTakenL2(wbBrTakenL2),
   .wbTEL2(wbTEL2[0:4]),
   .CB(CB),
   .DBG_exeTE(DBG_exeTE[0:4]),
   .DBG_iacEn(DBG_iacEn),
   .ICU_ifbEDataBus(ICU_ifbEDataBus[0:31]),
   .ICU_ifbError(ICU_ifbError[0:1]),
   .ICU_ifbODataBus(ICU_ifbODataBus[0:31]),
   .IFB_exeDbgBrTaken(IFB_exeDbgBrTaken_int),
   .JTG_dbdrPulse(JTG_dbdrPulse),
   .JTG_inst(JTG_inst[0:31]),
   .LSSD_coreTestEn(LSSD_coreTestEn),
   .MMU_isStatus(MMU_isStatus[0:1]),
   .PCL_exe2Full(PCL_exe2Full),
   .PCL_exe2IarE1(PCL_exe2IarE1),
   .PCL_exe2IarE2(PCL_exe2IarE2),
   .VCT_vectorBus(VCT_vectorBus[0:7]),
   .coreResetL2(coreResetL2),
   .ctrL2(ctrL2[0:29]),
   .dbsrPulseCntlE1(dbdrPulseCntlE1),
   .dcdApuE1(dcdApuE1),
   .dcdBrTarSel(dcdBrTarSel[0:1]),
   .dcdCorrect_Neg(dcdCorrect_Neg),
   .dcdCrtBpntLrCtr(dcdCrtBpntLrCtr),
   .dcdCrtE2(dcdCrtE2),
   .dcdCrtMuxSel(dcdCrtMuxSel),
   .dcdDataMuxSel(dcdDataMuxSel[0:1]),
   .dcdE1(IFB_dcdRegE1_int),
   .dcdE2(IFB_dcdRegE2_int),
   .dcdFullL2(dcdFullL2),
   .dcdIarMuxSel(dcdIarMuxSel[0:1]),
   .dcdTarget_Neg(dcdTarget_Neg),
   .evprL2(evprL2[0:15]),
   .exeCorrect_Neg(exeCorrect_Neg),
   .exeCrtBpntLrCtr(exeCrtBpntLrCtr),
   .exeCrtE2(exeCrtE2),
   .exeCrtMuxSel(exeCrtMuxSel[0:1]),
   .exeDataBr_21L2(exeDataBr_21L2),
   .exeDataE1(exeDataE1),
   .exeDataE2(exeDataE2),
   .exeFlushorClear(exeFlushorClear),
   .exeIarE2(exeIarE2),
   .iac1L2(iac1L2[0:29]),
   .iac2L2(iac2L2[0:29]),
   .iac3L2(iac3L2[0:29]),
   .iac4L2(iac4L2[0:29]),
   .isEaMuxSel(isEaMuxSel),
   .isEa_22DlyL2(isEA_22DlyL2),
   .isEa_27DlyL2(isEA_27DlyL2),
   .lcarE2(lcarE2),
   .lcarMuxSel(lcarMuxSel[0:1]),
   .linkL2(linkL2[0:29]),
   .lrCtrNormal_Neg(lrCtrNormal_Neg[0:29]),
   .lrCtrSe_Neg(lrCtrSe_Neg[0:29]),
   .mux048Sel(mux048Sel[0:1]),
   .pfb0BrTarSel(pfb0BrTarSel[0:1]),
   .pfb0DataMuxSel(pfb0DataMuxSel[0:1]),
   .pfb0E1(pfb0E1),
   .pfb0E2(pfb0E2),
   .pfb0IarMuxSel(pfb0IarMuxSel[0:1]),
   .pfb1DataMuxSel(pfb1DataMuxSel),
   .pfb1E2(pfb1E2),
   .pfb1IarMuxSel(pfb1IarMuxSel),
   .refetchAddrSel(refetchAddrSel),
   .refetchLcarMuxSel(refetchLcarMuxSel[0:1]),
   .refetchPipeStageSel(refetchPipeStageSel[0:1]),
   .saveForTraceE1(saveForTraceE1),
   .saveForTraceE2(saveForTraceE2),
   .srr02_Neg(srr02_Neg[0:29]),
   .traceDataSel(traceDataSel[0:1]),
   .tracePipeStageSel(tracePipeStageSel[0:1]),
   .wbDataE1(wbDataE1),
   .wbDataE2(wbDataE2),
   .wbFlushOrClear(wbFlushOrClear),
   .wbIarE1(wbIarE1),
   .wbIarE2(wbIarE2),
   .MMU_isParityErr(MMU_isParityErr),
   .ICU_parityErrE(ICU_parityErrE),
   .ICU_tagParityErr(ICU_tagParityErr),
   .ICU_parityErrO(ICU_parityErrO),
   .IFB_exeISideMachChk(IFB_exeISideMachChk),
   .ICU_CCR0IPE(ICU_CCR0IPE),
   .ICU_CCR0TPE(ICU_CCR0TPE)
);
/*
//ignoring leda warnings w/r/t system tasks
// BDZ TRANSLATE_OFF
// synopsys translate_off
// Making assertions for violated assumptions
`ifdef UNITSIM
`else
always@(posedge CB)
begin
  if(top.PR_CORE_SYS.PR_CORE.PPC405D4.core.cpu_topSch.IFB_exeIfetchErrL2[3] == 1'b1 &&
  top.PR_CORE_SYS.PR_CORE.PPC405D4.core.VCT_msrIR == 1'b0)
  begin
       $display("ERROR: Impossible parity error from the MMU! msrIR is off");
    #5 $finish;
  end
end
`endif
// synopsys translate_on
// BDZ TRANSLATE_ON
*/
endmodule
