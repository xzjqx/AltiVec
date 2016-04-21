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
//p405s_fetcherCntl

module p405s_fetcherCntl( IFB_TEL2, IFB_TETypeL2, IFB_cntxSync, IFB_cntxSyncOCM,
     IFB_coreSleepReqL2, IFB_dcdFullApuL2, IFB_dcdFullL2, IFB_diagBus, IFB_exeFlushA,
     IFB_exeFlushB, IFB_extStopAck, IFB_fetchReq, IFB_icuCancelDataL2, IFB_isAbortForICU,
     IFB_isAbortForMMU, IFB_nonSpecAcc, IFB_ocmAbort, IFB_postEntry, IFB_rstStepPend,
     IFB_rstStuffPend, IFB_stopAck, IFB_traceESL2, IFB_traceType, coreResetL2,
     dbdrPulseCntlE1, dcdApuE1, dcdBrTarSel, dcdBubble, dcdClear, dcdDataMuxSel,
     dcdE1, dcdE2, dcdFlush, dcdFullL2, dcdIarMuxSel, exeClear, exeDataE1, exeDataE2,
     exeDataSel, exeFlush, exeFlushorClear, exeFullL2, exeIarE2, isEA_22DlyL2, isEA_27DlyL2,
     isEaMuxSel, lcarE2, lcarMuxSel, mux048Sel, nxtSwapSt, pfb0BrTarSel,
     pfb0DataMuxSel, pfb0E1, pfb0E2, pfb0FullL2, pfb0IarMuxSel, pfb1DataMuxSel,
     pfb1E2, pfb1IarMuxSel, refetchAddrSel, refetchLcarMuxSel, refetchPipeStageSel,
     runStL2, saveForTraceE1, saveForTraceE2, seCtrSt, seIdleSt, stepStL2, stuffStL2,
     swapStL2, traceDataSel, tracePipeHold, tracePipeStageSel, wbDataE1, wbDataE2,
     wbFlushOrClear, wbIarE1, wbIarE2, APU_dcdValidOp_Neg, APU_sleepReq, CB,
     DBG_immdTE, DBG_stopReq, DBG_wbTE, DBG_weakStopReq, DCU_sleepReq, ICU_ifbE,
     ICU_ifbO, ICU_isCA, ICU_sleepReq, ICU_syncAfterReset, ICU_traceEnable, JTG_dbdrPulse,
     JTG_step, JTG_stopReq, JTG_stuff, LSSD_coreTestEn, MMU_isStatus, PCL_blkFlush,
     PCL_dIcmpForStep, PCL_dIcmpForStuff, PCL_dcdHoldForIFB, PCL_exe2Full, PCL_exeIarHold,
     PCL_icuOp_0, PCL_wbClearTerms, PCL_wbFull, PCL_wbHold, PCL_wbStorageEnd, PCL_wbStorageOp,
     PGM_apuPresent, TRC_fifoFull, TRC_fifoOneEntryFree, TRC_se, TRC_seCtrEqZeroL2,
     TRC_sleepReq, VCT_anySwap, VCT_msrWE, VCT_swap01, VCT_swap23, VCT_wbFlush, VCT_wbRfci,
     VCT_wbRfi, VCT_wbSuppress, XXX_traceDisable, branchTarCrt, coreReset, dcdCorrect_Neg,
     dcdData_5, dcdData_21, dcdData_30, dcdTarget_Neg, exeCorrect_Neg, exeIsyncL2, exeMtCtr,
     exeMtLr, exeRfciL2, exeRfiL2, exeScL2, isEA_22, isEA_27, isEA_29, lcar_29, pfb0Data_5,
     pfb0Data_21, pfb0Data_30, pfb0Target_Neg, wbBrTakenL2, wbIsyncL2, wbMtCtrL2,
     wbMtLrL2, wbTEL2, MMU_isParityErr );

output  IFB_TEL2, IFB_cntxSync, IFB_cntxSyncOCM, IFB_coreSleepReqL2, IFB_dcdFullApuL2,
     IFB_exeFlushA, IFB_exeFlushB, IFB_extStopAck, IFB_fetchReq, IFB_icuCancelDataL2,
     IFB_isAbortForMMU, IFB_nonSpecAcc, IFB_ocmAbort, IFB_postEntry, IFB_rstStepPend,
     IFB_rstStuffPend, IFB_stopAck, coreResetL2, dbdrPulseCntlE1, dcdApuE1, dcdBubble,
     dcdClear, dcdE1, dcdE2, dcdFlush, dcdFullL2, exeClear, exeDataE1, exeDataE2, exeDataSel,
     exeFlush, exeFlushorClear, exeFullL2, exeIarE2, isEA_22DlyL2, isEA_27DlyL2, isEaMuxSel,
     lcarE2, nxtSwapSt, pfb0E1, pfb0E2, pfb0FullL2, pfb1DataMuxSel, pfb1E2, pfb1IarMuxSel,
     refetchAddrSel, runStL2, saveForTraceE1, saveForTraceE2, seCtrSt, seIdleSt,
     stepStL2, stuffStL2, swapStL2, tracePipeHold, wbDataE1, wbDataE2, wbFlushOrClear, wbIarE1,
     wbIarE2;

input  APU_dcdValidOp_Neg, APU_sleepReq, DBG_stopReq, DBG_weakStopReq, DCU_sleepReq, ICU_ifbE,
     ICU_ifbO, ICU_isCA, ICU_sleepReq, ICU_syncAfterReset, ICU_traceEnable, JTG_dbdrPulse,
     JTG_step, JTG_stopReq, JTG_stuff, LSSD_coreTestEn, PCL_blkFlush, PCL_dIcmpForStep,
     PCL_dIcmpForStuff, PCL_exe2Full, PCL_exeIarHold, PCL_icuOp_0, PCL_wbClearTerms,
     PCL_wbFull, PCL_wbHold, PCL_wbStorageEnd, PCL_wbStorageOp, PGM_apuPresent, TRC_fifoFull,
     TRC_fifoOneEntryFree, TRC_se, TRC_seCtrEqZeroL2, TRC_sleepReq, VCT_anySwap, VCT_msrWE,
     VCT_swap01, VCT_swap23, VCT_wbFlush, VCT_wbRfci, VCT_wbRfi, VCT_wbSuppress,
     XXX_traceDisable, branchTarCrt, coreReset, dcdCorrect_Neg, dcdData_5, dcdData_21,
     dcdData_30, dcdTarget_Neg, exeCorrect_Neg, exeIsyncL2, exeMtCtr, exeMtLr, exeRfciL2,
     exeRfiL2, exeScL2, isEA_22, isEA_27, isEA_29, lcar_29, pfb0Data_5, pfb0Data_21,
     pfb0Data_30, pfb0Target_Neg, wbBrTakenL2, wbIsyncL2, wbMtCtrL2, wbMtLrL2,
     MMU_isParityErr;

output [0:1]  refetchPipeStageSel;
output [0:7]  IFB_diagBus;
output [0:1]  pfb0IarMuxSel;
output [0:1]  lcarMuxSel;
output [0:2]  IFB_isAbortForICU;
output [0:1]  pfb0BrTarSel;
output [0:1]  dcdBrTarSel;
output [0:1]  dcdDataMuxSel;
output [0:1]  pfb0DataMuxSel;
output [0:1]  IFB_traceESL2;
output [0:1]  IFB_traceType;
output [0:1]  IFB_dcdFullL2;
output [0:1]  tracePipeStageSel;
output [0:1]  refetchLcarMuxSel;
output [0:1]  traceDataSel;
output [0:10]  IFB_TETypeL2;
output [0:1]  mux048Sel;
output [0:1]  dcdIarMuxSel;


input [0:4]  DBG_wbTE;
input [0:2]  PCL_dcdHoldForIFB;
input [0:2]  DBG_immdTE;
input        CB;
input [0:1]  MMU_isStatus;
input [0:4]  wbTEL2;

// Buses in the design
wire  [0:1]  traceStL2;
wire  [0:10] IFB_TETypeL2;
wire  [0:7]  IFB_diagBus;
wire  [0:3]  nxtDataE;
wire  [0:1]  nxtTraceSt;
wire  [0:3]  nxtPfb0Full;
wire  [0:1]  nxtTraceES;
wire  [0:10]  nxtTraceTEType;
wire  [0:3]  nxtPfb1Full;
wire pfb1FullL2;
wire osrOL2;
wire osrEL2;
wire dataOL2;
wire dataEL2;
reg [0:5] cpuSM_Reg;
reg [0:5] cpuSM_Reg_next;
wire [0:5] cpuSM_Mux_D0;
reg [0:2] cntlForEO_Reg;
reg [0:2] cntlForEO_Reg_next;
wire [0:2] cntlForEO_Mux_D0,cntlForEO_Mux_D1;
wire [0:2] cntlForEO_Mux_D2;
wire [0:2] cntlForEO_Mux_D3;
wire [0:1] cntlForEO_Muxsel;
wire stopStL2, dIcmpQDlydL2, nxtRunSt, nxtStepSt, nxtStopSt; 
wire nxtStuffSt, dIcmpQ, cpuStReset, isE, isO;
reg [0:15] ftchCntl3_Reg;
wire [0:15] ftchCntl3_Reg_next;
wire xxxTraceDisableL2, nxtDcdFull, nxtExeFull, nxtTraceTE;
reg [0:15] ftchCntl_Reg;
wire [0:15] ftchCntl_Reg_next;
wire aLtchL2, dcdHoldDlyL2, nxtDcdHoldDly, nxtALtch, nxtCDLtch; 
wire nxtOsrO, nxtOsrE, nxtDataO, nxtIsEA_22Dly, nxtIsEA_27Dly, coreSleepReq;
wire            pfb1Flush;
wire            pfb0Flush, pfb0Clear;
wire            dcdClear, dcdFlush;
wire    [0:2]   ifbDcdHold;
wire            wbFullQ;
wire            stuffReq, stuffReqForE1;
wire            swapReqQ, hardStopReqQ, weakStopReqQ, hardStopReq;
wire            stepQ, stuffQ;
wire            interrupt, refetch;
wire            seIarSt, seLrSt, postSe;
wire            nxtIarSt, nxtLrSt, nxtCtrSt;
wire            normalPost, fifoUnavailable, tracePipeFlush, isideAbort;

reg     [0:1]   refetchLcarMuxSel;
reg wbIsyncDlyL2, stepStDlydL2;

wire        IFB_fetchReq_int;
wire        IFB_icuCancelDataL2_int;
wire        IFB_stopAck_int;
wire        coreResetL2_int;
wire        dcdBubble_int;
wire        dcdClear_int;
wire        dcdFlush_int;
wire        dcdFullL2_int;
wire        exeClear_int;
wire        exeFlush_int;
wire        exeFlushorClear_int;
wire        exeFullL2_int;
wire        isEA_22DlyL2_int;
wire        isEA_27DlyL2_int;
wire        lcarE2_int;
wire        nxtSwapSt_int;
wire        pfb0FullL2_int;
wire        runStL2_int;
wire        seCtrSt_int;
wire        seIdleSt_int;
wire        stepStL2_int;
wire        stuffStL2_int;
wire        swapStL2_int;
wire        tracePipeHold_int;

assign IFB_fetchReq = IFB_fetchReq_int;
assign IFB_icuCancelDataL2 = IFB_icuCancelDataL2_int;
assign IFB_stopAck = IFB_stopAck_int;
assign coreResetL2 = coreResetL2_int;
assign dcdBubble = dcdBubble_int;
assign dcdClear = dcdClear_int;
assign dcdFlush = dcdFlush_int;
assign dcdFullL2 = dcdFullL2_int;
assign exeClear = exeClear_int;
assign exeFlush = exeFlush_int;
assign exeFlushorClear = exeFlushorClear_int;
assign exeFullL2 = exeFullL2_int;
assign isEA_22DlyL2 = isEA_22DlyL2_int;
assign isEA_27DlyL2 = isEA_27DlyL2_int;
assign lcarE2 = lcarE2_int;
assign nxtSwapSt = nxtSwapSt_int;
assign pfb0FullL2 = pfb0FullL2_int;
assign runStL2 = runStL2_int;
assign seCtrSt = seCtrSt_int;
assign seIdleSt = seIdleSt_int;
assign stepStL2 = stepStL2_int;
assign stuffStL2 = stuffStL2_int;
assign swapStL2 = swapStL2_int;
assign tracePipeHold = tracePipeHold_int;

//Removed the module 'dp_regIFB_ftchCntl2'
always @(posedge CB)
  {wbIsyncDlyL2, stepStDlydL2} <= {wbIsyncL2, stepStL2_int};

//Removed the module "dp_logIFB_ocmAbortBuf"
//Removed the module "dp_logIFB_cntxSyncOCMBuf"
//Removed the module "dp_logIFB_diaBusB"
//Removed the module "dp_logIFB_diaBusA"
//Removed the module "dp_logIFB_TEtypeBuf"
//Removed the module "dp_logIFB_TEBuf"
//Removed the module "dp_logIFB_extStopAckBuf"
//Removed the module "dp_logIFB_coreSleepReqBuf"
//Removed the module "dp_logIFB_dcdFullApuBuf"

assign IFB_diagBus[0:7] = {pfb1FullL2, pfb0FullL2_int, dcdFullL2_int, exeFullL2_int, osrOL2, 
     osrEL2, dataOL2, dataEL2};

//ignoring leda warning B_1013 (signal IFB_stopAck_int driving multiple ports)
assign IFB_extStopAck = IFB_stopAck_int;


//Removed the module 'dp_regIFB_cpuStateMachine'
assign {runStL2_int, stepStL2_int, stopStL2, stuffStL2_int, swapStL2_int, dIcmpQDlydL2} = cpuSM_Reg;
assign cpuSM_Mux_D0 = {nxtRunSt, nxtStepSt, nxtStopSt, nxtStuffSt, nxtSwapSt_int, dIcmpQ};
// 2-1 Mux input to register
always @(cpuSM_Mux_D0 or cpuStReset)
  casez(cpuStReset)
    1'b0: cpuSM_Reg_next = cpuSM_Mux_D0;
    1'b1: cpuSM_Reg_next = 6'b001000;
    default: cpuSM_Reg_next = 6'bx;
  endcase
// posedge FF
always @(posedge CB)
  cpuSM_Reg <= cpuSM_Reg_next;


//Removed the module 'dp_regIFB_cntlForEO'
assign cntlForEO_Mux_D0 = {nxtPfb1Full[0], nxtPfb0Full[0], nxtDataE[0]};
assign cntlForEO_Mux_D1 = {nxtPfb1Full[1], nxtPfb0Full[1], nxtDataE[1]};
assign cntlForEO_Mux_D2 = {nxtPfb1Full[2], nxtPfb0Full[2], nxtDataE[2]};
assign cntlForEO_Mux_D3 = {nxtPfb1Full[3], nxtPfb0Full[3], nxtDataE[3]};
assign cntlForEO_Muxsel = {isE, isO};
assign {pfb1FullL2, pfb0FullL2_int, dataEL2} = cntlForEO_Reg;
// 4-1 Mux input to register
always @(cntlForEO_Mux_D0 or cntlForEO_Mux_D1 or cntlForEO_Mux_D2 or 
         cntlForEO_Mux_D3 or cntlForEO_Muxsel)
  casez(cntlForEO_Muxsel)
    2'b00: cntlForEO_Reg_next = cntlForEO_Mux_D0;
    2'b01: cntlForEO_Reg_next = cntlForEO_Mux_D1;
    2'b10: cntlForEO_Reg_next = cntlForEO_Mux_D2;
    2'b11: cntlForEO_Reg_next = cntlForEO_Mux_D3;
    default: cntlForEO_Reg_next = 3'bx;
  endcase
//posedge FF
always @(posedge CB)
  cntlForEO_Reg <= cntlForEO_Reg_next;


//Removed the module 'dp_regIFB_ftchCntl3'
wire IFB_TEL2;
assign {dcdFullL2_int, exeFullL2_int, coreResetL2_int, IFB_TEL2, IFB_TETypeL2[0:10], xxxTraceDisableL2} = 
     ftchCntl3_Reg;
assign ftchCntl3_Reg_next = 
     {nxtDcdFull, nxtExeFull, coreReset, nxtTraceTE, nxtTraceTEType[0:10], XXX_traceDisable};
// posedge FF
always @(posedge CB)
  ftchCntl3_Reg <= ftchCntl3_Reg_next;


//Removed the module 'addrCntlPla'
assign mux048Sel[0] = ((~aLtchL2 & ~pfb1FullL2 & ~pfb0FullL2_int & ~lcar_29 &
    osrEL2) | (~aLtchL2 & ~dcdHoldDlyL2 & ~lcar_29 & ~osrEL2 & osrOL2 &
    dataEL2) | (~aLtchL2 & ~lcar_29 & ~osrEL2 & ~osrOL2 & dataEL2 &
    dataOL2) | (~aLtchL2 & ~pfb1FullL2 & ~lcar_29 & ~osrEL2 & osrOL2 &
    dataEL2) | (~aLtchL2 & ~dcdHoldDlyL2 & ~pfb1FullL2 & ~lcar_29 & osrEL2
    )) | LSSD_coreTestEn;
assign mux048Sel[1] = ((~aLtchL2 & dcdHoldDlyL2 & ~pfb1FullL2 & pfb0FullL2_int
     & osrEL2 & osrOL2) | (~aLtchL2 & ~dcdHoldDlyL2 & pfb1FullL2 & osrEL2
     & osrOL2) | (~aLtchL2 & dcdHoldDlyL2 & pfb1FullL2 & ~lcar_29 & ~
    osrEL2 & dataEL2 & ~dataOL2) | (~aLtchL2 & lcar_29 & ~osrOL2 & dataOL2
    ) | (~aLtchL2 & ~lcar_29 & ~osrEL2 & ~osrOL2 & dataEL2 & ~dataOL2) | (
    ~aLtchL2 & ~pfb1FullL2 & lcar_29 & osrOL2) | (~aLtchL2 & ~dcdHoldDlyL2
     & lcar_29 & osrOL2)) | LSSD_coreTestEn;


//Removed the module 'dp_regIFB_ftchCntl'
assign  {dcdHoldDlyL2, aLtchL2, IFB_icuCancelDataL2_int, osrOL2, osrEL2, dataOL2, 
   isEA_22DlyL2_int, isEA_27DlyL2_int, IFB_traceESL2[0:1], traceStL2[0:1], IFB_coreSleepReqL2, 
   IFB_dcdFullApuL2, IFB_dcdFullL2[0:1]} = ftchCntl_Reg;
assign ftchCntl_Reg_next = {nxtDcdHoldDly, nxtALtch, nxtCDLtch, nxtOsrO, nxtOsrE, 
   nxtDataO, nxtIsEA_22Dly, nxtIsEA_27Dly, nxtTraceES[0:1], nxtTraceSt[0:1], 
   coreSleepReq, nxtDcdFull, nxtDcdFull, nxtDcdFull};
// posedge FF
always @(posedge CB)
   ftchCntl_Reg <= ftchCntl_Reg_next;


//Removed the module 'fetcherCntlEqs'
// Qualify with osr bits because MMU_isStatus is not associated with even
//    or odd address. Osr bit will tell if we where expecting data.
// Simulations have worked without qualifing with osr bits. This was done
//    for peace of mind and may be removed if necessary.
assign isE = ICU_ifbE | (((|MMU_isStatus) | MMU_isParityErr) & osrEL2);
assign isO = ICU_ifbO | (((|MMU_isStatus) | MMU_isParityErr) & osrOL2);

assign IFB_fetchReq_int = stepStL2_int | swapStL2_int | runStL2_int;

assign IFB_nonSpecAcc = ~((PCL_exe2Full & dcdFullL2_int) |
                         (dcdFullL2_int & pfb0FullL2_int) |
                         (exeFullL2_int & dcdFullL2_int & ~PCL_icuOp_0));

assign IFB_cntxSync = swapStL2_int | wbIsyncDlyL2;
assign IFB_cntxSyncOCM = swapStL2_int | wbIsyncDlyL2;

//////////////////////////////////////////////////////////////////////////
// pfb1 clear or flush, pfb0 clear or flush, dcd clear or flush only    //
// clear the full bit data remains in data register. exeClear clears    //
// the exe stage data registers. wbClear clears wb stage data registers.//
// Flush overrides hold, Hold overrides clear.                          //
//////////////////////////////////////////////////////////////////////////

//////////
// lcar //
//////////
wire    lcarE2notIsO, lcarE2IsO, lcarE2Sig2, lcarE2Sig1;

//Removed the module 'dp_muxIFB_lcarE2' 
//lcarE2mux(.D0(~lcarE2notIsO), .D1(lcarE2Sig2), .SD(isO), .Z(lcarE2));
assign lcarE2_int = (lcarE2notIsO & ~isO) | (~lcarE2Sig2 & isO);

//Removed the module 'dp_logIFB_lcarE2Nor' 
//lcarE2Nor (.A(lcarE2Sig1), .B(lcarE2IsO), .Z(lcarE2Sig2));
assign lcarE2Sig2 = ~( lcarE2Sig1 | lcarE2IsO );

//Removed the module 'dp_logIFB_lcarE2Nor3'
// lcarE2Nor3 (.A(~ICU_isCA), .B(pfb1FullL2), .C(isE), .Z(lcarE2Sig1));
assign lcarE2Sig1 = ~(~ICU_isCA | pfb1FullL2 | isE);

    assign lcarE2notIsO =  (ICU_isCA & ~osrOL2) |
                           (IFB_icuCancelDataL2_int & ICU_isCA) |
                           (branchTarCrt) |
                           (interrupt) |
                           (refetch) |
                           (coreResetL2_int);
    assign lcarE2IsO = lcarE2notIsO |
                       (ICU_isCA & ~pfb1FullL2 & ~pfb0FullL2_int) |
                       (ICU_isCA & ~ifbDcdHold[0]) |
                       (ICU_isCA & dcdHoldDlyL2);

    assign lcarMuxSel[0] = ((refetch) | (coreResetL2_int));
    assign lcarMuxSel[1]= ((~refetch & interrupt) | (coreResetL2_int));

////////////////
// pfb1 Stage.//
////////////////
assign pfb1Flush = pfb0Flush | pfb0Clear;

//  Will allow pfb1 to load unless it is holding current value. When aLtchL2 is
//  set any data coming home will be tossed.
    assign pfb1E2 = ~(pfb1FullL2 & ifbDcdHold[2]);

    assign pfb1IarMuxSel = ((~lcar_29 & ~osrEL2) | (~pfb0FullL2_int) |
        (~ifbDcdHold[2] & ~pfb1FullL2));
    assign pfb1DataMuxSel = ((~osrEL2) | (~pfb0FullL2_int) | (~ifbDcdHold[2] &
         ~pfb1FullL2));

    assign nxtPfb1Full[0] = (ifbDcdHold[2] & pfb1FullL2 & ~pfb1Flush);
    assign nxtPfb1Full[1] = (~IFB_icuCancelDataL2_int & ~aLtchL2 & ~dcdHoldDlyL2 &
                              pfb1FullL2 & ~pfb1Flush) |
                            (~IFB_icuCancelDataL2_int & ~aLtchL2 & ifbDcdHold[2] &
                              pfb0FullL2_int & ~pfb1Flush) |
                            (ifbDcdHold[2] & pfb1FullL2 & ~pfb1Flush);
    assign nxtPfb1Full[2] = (~IFB_icuCancelDataL2_int & ~aLtchL2 & ~dcdHoldDlyL2 &
                              pfb1FullL2 & ~pfb1Flush) |
                            (~IFB_icuCancelDataL2_int & ~aLtchL2 & ifbDcdHold[2] &
                              pfb0FullL2_int & ~pfb1Flush) |
                            (ifbDcdHold[2] & pfb1FullL2 & ~pfb1Flush);
    assign nxtPfb1Full[3] = (~IFB_icuCancelDataL2_int & ~aLtchL2 &  ~dcdHoldDlyL2 &
                               pfb0FullL2_int & ~pfb1Flush) |
                             (~IFB_icuCancelDataL2_int & ~aLtchL2 & ifbDcdHold[2] &
                               dcdFullL2_int & ~pfb1Flush) |
                             (ifbDcdHold[2] & pfb1FullL2 & ~pfb1Flush);

////////////////
// pfb0 Stage //
////////////////
assign pfb0Flush = dcdFlush_int | dcdClear_int;
assign pfb0Clear = ~pfb0Target_Neg; // sequential pipe terms in PLA

//  Will allow pfb0 to load unless it is holding current value. When aLtchL2 is
//  set any data coming home will be tossed any pipe movement from pfb1 is
//  flushed.
    assign pfb0E1 = ~aLtchL2;
    assign pfb0E2 = ~(pfb0FullL2_int & ifbDcdHold[2]);

    assign pfb0IarMuxSel[0] = ((~pfb1FullL2 & ~lcar_29 & ~osrEL2) | (~dcdFullL2_int) |
        (~ifbDcdHold[2] & ~pfb0FullL2_int));
    assign pfb0IarMuxSel[1] = ((~pfb1FullL2 & lcar_29) | (ifbDcdHold[2] &
        dcdFullL2_int & osrEL2) | (~pfb1FullL2 & pfb0FullL2_int & osrEL2));

    assign pfb0DataMuxSel[0] = ((~pfb1FullL2 & ~osrEL2) | (~dcdFullL2_int) | (~
        ifbDcdHold[2] & ~pfb0FullL2_int)) | LSSD_coreTestEn;
    assign pfb0DataMuxSel[1] = ((ifbDcdHold[2] & dcdFullL2_int & osrEL2) | (~pfb1FullL2
         & pfb0FullL2_int & osrEL2)) | LSSD_coreTestEn;

// Design full bit so that isE, isO are on the mux selects of a reg for timing
// Don't need ifb dcdBubble because all ifb instructions that cause a bubble
//    also cause a flush.
// Hold beats clear so full and holding term qualified only with ~pfb0Flush.
    assign nxtPfb0Full[0] = (pfb1FullL2 & ~pfb0Flush & ~pfb0Clear) |
                             (ifbDcdHold[2] & pfb0FullL2_int & ~pfb0Flush);
    assign nxtPfb0Full[1] = (~IFB_icuCancelDataL2_int & ~aLtchL2 & ifbDcdHold[2] &
                               dcdFullL2_int & ~pfb0Flush & ~pfb0Clear) |
                            (~IFB_icuCancelDataL2_int & ~aLtchL2 & pfb0FullL2_int &
                               ~pfb0Flush & ~pfb0Clear) |
                            (pfb1FullL2 & ~pfb0Flush & ~pfb0Clear) |
                            (ifbDcdHold[2] & pfb0FullL2_int & ~pfb0Flush);
    assign nxtPfb0Full[2] = (~IFB_icuCancelDataL2_int & ~aLtchL2 & ifbDcdHold[2] &
                               dcdFullL2_int & ~pfb0Flush & ~pfb0Clear) |
                            (~IFB_icuCancelDataL2_int & ~aLtchL2 & pfb0FullL2_int &
                               ~pfb0Flush & ~pfb0Clear) |
                            (pfb1FullL2 & ~pfb0Flush & ~pfb0Clear) |
                            (ifbDcdHold[2] & pfb0FullL2_int & ~pfb0Flush);
    assign nxtPfb0Full[3] = (~IFB_icuCancelDataL2_int & ~aLtchL2 &
                                ~pfb0Flush & ~pfb0Clear) |
                             (pfb1FullL2 & ~pfb0Flush & ~pfb0Clear) |
                             (ifbDcdHold[2] & pfb0FullL2_int & ~pfb0Flush);


///////////////
// dcd Stage //
///////////////
// can't use exeClear because contains sequential pipe terms
assign dcdFlush_int = exeFlush_int | ~exeCorrect_Neg;

// sequential pipe terms in nxtDcdFull
assign dcdClear_int = ~dcdCorrect_Neg | ~dcdTarget_Neg;
assign dcdBubble_int = exeRfciL2 | exeRfiL2 | exeScL2 | exeIsyncL2;
assign ifbDcdHold[0] = PCL_dcdHoldForIFB[0] | dcdBubble_int | tracePipeHold_int;
assign ifbDcdHold[1] = PCL_dcdHoldForIFB[1] | dcdBubble_int | tracePipeHold_int;
assign ifbDcdHold[2] = PCL_dcdHoldForIFB[2] | dcdBubble_int | tracePipeHold_int;
assign nxtDcdHoldDly = ifbDcdHold[0];

//  Will allow dcd to load unless it is holding current value. When aLtchL2 is
//  set any data coming home will be tossed any pipe movement from dcd is
//  flushed.
    assign dcdApuE1 = (~aLtchL2 | stuffReqForE1 | pfb0FullL2_int) & PGM_apuPresent;
    assign dcdE1 = ~aLtchL2 | stuffReqForE1 | pfb0FullL2_int;
    assign dcdE2 = ~(dcdFullL2_int & ifbDcdHold[0]) | stuffReq;

    assign dcdIarMuxSel[0] = ((~stuffReq & ~pfb0FullL2_int & ~lcar_29 & ~osrEL2)) |
                             LSSD_coreTestEn;
    assign dcdIarMuxSel[1] = ((~pfb0FullL2_int & lcar_29) | (~pfb0FullL2_int & osrEL2) |
                             (stuffReq));

    assign dcdDataMuxSel[0] = ((~pfb0FullL2_int & ~osrEL2) | (stuffReq));
    assign dcdDataMuxSel[1] = ((~pfb0FullL2_int & osrEL2) | (stuffReq));

// Hold beats clear so full and holding term qualified only with ~dcdFlush_int.
    assign nxtDcdFull = (~aLtchL2 & isE & ~dcdFlush_int & ~dcdClear_int) |
                        (~aLtchL2 & isO & ~dcdFlush_int & ~dcdClear_int) |
                        (pfb0FullL2_int & ~dcdFlush_int & ~dcdClear_int) |
                        (ifbDcdHold[0] & dcdFullL2_int & ~dcdFlush_int) |
                        (stuffReq);

///////////////
// exe Stage //
//////////////
// tracePipeFlush not needed because VCT_anySwap already in equation.
assign exeFlush_int = ((runStL2_int | swapStL2_int) &
        (hardStopReqQ | VCT_anySwap | VCT_msrWE | weakStopReqQ)) |
        (stepStL2_int & VCT_anySwap & hardStopReq) |
        wbIsyncL2 | dIcmpQDlydL2 | coreResetL2_int;
assign IFB_exeFlushA = ((runStL2_int | swapStL2_int) &
        (hardStopReqQ | VCT_anySwap | VCT_msrWE | weakStopReqQ)) |
        (stepStL2_int & VCT_anySwap & hardStopReq) |
        wbIsyncL2 | dIcmpQDlydL2 | coreResetL2_int;
assign IFB_exeFlushB = ((runStL2_int | swapStL2_int) &
        (hardStopReqQ | VCT_anySwap | VCT_msrWE | weakStopReqQ)) |
        (stepStL2_int & VCT_anySwap & hardStopReq) |
        wbIsyncL2 | dIcmpQDlydL2 | coreResetL2_int;


// exeClear contains sequential pipe terms: Since exe must load from dcd only
// Pipe is not moving or exe is correcting.
assign exeClear_int = (~dcdFullL2_int | ifbDcdHold[0]) | ~exeCorrect_Neg;
assign exeFlushorClear_int = exeFlush_int | exeClear_int;

// assign exeIarE1 = dcdFullL2_int;
// PCL_exeIarHold contains suppress terms
assign exeIarE2 = ~PCL_exeIarHold;

// Pipe is holding and not flushing or pipe is moving and not flushing or
// clearing. Only need exeCorrect term from exeClear because other terms
// are included in pipe moving portion of the equation.
// PCL_exeIarHold contains suppress terms
assign nxtExeFull = (exeFullL2_int & PCL_exeIarHold & ~exeFlush_int) |
        (dcdFullL2_int & ~ifbDcdHold[0] &
        ~exeFlush_int & exeCorrect_Neg);

// E1 When dcd is full instruction may be moving to exe
//    When exe is full exe may be flushed or cleared
//    When coreReset exe will be flushed
assign exeDataE1 = (dcdFullL2_int | exeFullL2_int | coreResetL2_int);

// E2 is all conditions that cause exeData to be updated.
// exeFlush contains coreResetL2
// PCL_exeIarHold contains suppress terms
assign exeDataE2 = ~PCL_exeIarHold | exeFlush_int;

// The dcd pla has been designed to use all illegal ops as don't cares. This
// OK since the instruction will be flushed if it is illegal. If the APU is
// to execute the instrction then we cannot set the IFB exe stage latches.
// For APU ops these exe stage bits are cleared.
assign exeDataSel = exeFlushorClear_int | ~APU_dcdValidOp_Neg;

///////////////////////
// wb stage controls //
///////////////////////
assign wbIarE1 = exeFullL2_int | PCL_exe2Full;
assign wbIarE2 = ~(PCL_wbHold | VCT_wbSuppress);
assign wbDataE1 = exeFullL2_int | PCL_exe2Full | wbFullQ | coreResetL2_int;

// PCL_wbHold does not contain suppress terms?
// DisableDb is not well behaved when flushed.
// VCT_wbFlush does contain reset.
assign wbDataE2 = ~(PCL_wbHold | VCT_wbSuppress) | VCT_wbFlush;

assign wbFullQ = PCL_wbFull & PCL_wbStorageEnd;

// exeFlush contains VCT_wbFlush plus other terms that go into wbClear.
assign wbFlushOrClear = PCL_wbClearTerms | exeFlush_int;

////////////////////////////////////////////
// Fast memory transfer with JTG_dbdrPulse//
////////////////////////////////////////////
// Action is not well behaved if fast memory transfer is interfered by with
// flush. This register will remain set if the pipe is flushed.
// It is up to the user of the function to assure proper behavor.
// exeDisableDbEvent is set by a JTG_dbdrPulse. It then remains set until the
// first instruction lands in dcd and is used to feed the exe stage control for
// that instruction. Assumption is made that dcd is not holding. Since the cpu
// pipeline is emptied before this instruction comes the only thing that can
// hold dcd is APU_busy with an illegal op in dcd. In this case dcd will hold
// the disable debug event reg will reset and there will be another debug
// event. The user will have to deal with this by delaying the dbdr pulse
// until there APU is not busy.
// Async interrupts should be masked when this function is used. May cause
// unexpected masking if not.
assign dbdrPulseCntlE1 = dcdFullL2_int | coreResetL2_int | JTG_dbdrPulse;

/////////////////
// abort latch //
/////////////////
// Abort latch is set anytime there is a stopSt, Interrupt, refetch, or when
// when a branch target or correction is not not command accepted. In each
// the ALtch is set the address is loaded in lcar. Abort and the address
// are set to the cache in the next cycle.
assign nxtALtch = nxtStopSt | stopStL2 | interrupt | refetch |
                  (branchTarCrt & ~ICU_isCA) | (aLtchL2 & ~ICU_isCA);

////////////////////////////////////////////////////////////////////////////////////
// Correct is a condition that causes other things to happen. It is described here//
// for reference use by the designer in creating equations that relate to this.   //
// Correct occurs in the first cycle of dcdHold when dcdHoldDlyL2 is not set.     //
// Since address generation uses dcdHoldDlyL2 for speed, it is unaware that there //
// is not as many data slots available in the pipe as was expected. The fetcher   //
// will ask for an address but really need to ask for the previous address        //
// since it will be tossing the data from that request.                           //
//       correct = (ifbDcdHold &                                                  //
//                    ~dcdHoldDlyL2 & pfb0FullL2 & isE) |                         //
//              (ifbDcdHold &                                                     //
//                    ~dcdHoldDlyL2 & pfb1FullL2 & (isE | isO));                  //
////////////////////////////////////////////////////////////////////////////////////

/////////////////
// cancel data //
/////////////////
// Cancel data when correcting and when tossing even data and still waiting
// for odd data, since fetcher will need to request the even data again.
// Don't cancel data on an abort request since this is not a sequential request.
// Don't need ~osrOL2 in true command accept (isCa & (~osrO | isO) because
//    can't have correct unless data is coming home that we don't have room for.
// Can't blindly cancel data anytime even data is tossed, to get ~isO out
//    of equation. If even and odd come back we want
//    to use the current request. This would cancel it.
// The first term correcting does not need ~IFB_icuCancelDataL2 because
//    when correcting the current request is for data we don't want.
//    This is a new fetch request, so don't discard
// The second term is when we have tossed even data because we don't have
//    room for it and have not received the odd data. If cancel data is on
//    for this cycle then we are tossing because of the first term and will
//    currently be asking for an address we want so we don't want to cancel
//    it during the next cycle. This is a existing request, so we don't want
//    it anymore.
assign nxtCDLtch = ((ICU_isCA & isO) & (~isideAbort) &
                      (ifbDcdHold[1]) & (~dcdHoldDlyL2) &
                      ((pfb0FullL2_int & osrEL2) | (pfb1FullL2))) |
                   ((ifbDcdHold[1] | dcdHoldDlyL2) &
                      ~isideAbort & ~IFB_icuCancelDataL2_int & pfb1FullL2 &
                      isE & ~isO);

/////////////////////////
// outstanding request //
/////////////////////////
// Outstanding request latch is set any time the cache actually accepts a
//   fetch request and is not correcting. When correct we know we will toss
//   the data and make a new request in the next cycle, lcar does not update
//   therefor osr should not be set.
//   An actual command accept must have isCA, the cache must
//   be finished with it's previous request as indicated by isO, or
//   not be expecting data as indicated by ~Osr latch, this simplifies to
//   isCA since if Osr is set it remains set if we don't get data and sets
//   if we do get data. An abort or cancel causes the cache to accept the
//   new request therefor setting the OSR latch.
// interrupt, refetch, load lcar with the address that will be asked for next
//   can't be command accepted since it hasn't been asked for, so don't
//   load and reset osr. This address will be asked for with abort.
// Fetch request, (fetch request is run, step, swap state)
//      (fetch request is off during reset)
// Reset covered by abort.
// Osr is set dominate mean if a new request occurs when the old finishes the
//    register will stay set.

// Odd outstanding request
// Terms:
//     Don't set with interrupt or refetch, must have a fetch request.
// True command accept and not correct. Correct will stop LCAR from loading
//      and cancel data the next cycle.
// True command accept due to abort or cancel data.
// hold until data is received or an interrupt refetch or abort update the lcar
//     or until abort or cancel data invalidate the request.
assign nxtOsrO = IFB_fetchReq_int & ~interrupt & ~refetch & (
    (ICU_isCA & ~(ifbDcdHold[1] & ~dcdHoldDlyL2 &
       ((pfb0FullL2_int & osrEL2) | (pfb1FullL2)))) |
    (ICU_isCA & (isideAbort | IFB_icuCancelDataL2_int))
    ) |
    (osrOL2 & ~isO & ~interrupt & ~refetch &
               ~isideAbort & ~IFB_icuCancelDataL2_int);

// Even outstanding request
// Terms:
// True command accept and not correcting. Correct will stop LCAR from loading
//      and cancel data the next cycle.
// True command accept due to abort or cancel data
// hold until data is received or an interrupt refetch or abort update the lcar
//     or until abort or cancel data invalidate the request.
assign nxtOsrE = IFB_fetchReq_int & ~interrupt & ~refetch & (
    (ICU_isCA & ~isEA_29 & (~osrOL2 | isO) &
        ~(ifbDcdHold[1] & ~dcdHoldDlyL2 &
        ((pfb0FullL2_int & osrEL2) | (pfb1FullL2)))) |
    (ICU_isCA & ~isEA_29 & (isideAbort | IFB_icuCancelDataL2_int))
    ) |
    (osrEL2 & ~isE & ~interrupt & ~refetch &
        ~isideAbort & ~IFB_icuCancelDataL2_int);

/////////////////
// Data status //
/////////////////
// Data status indicates that the data has been received from the cache and that
//   it has been added to the pipe (has not been tossed). Register is reset
//   dominate since if a new fetch request is accepted data status remains off.
// interrupt or refetch or abort loads lcar with a new value. DataE/O should
//    reflect the current address in lcar. Can't have data.
// Abort or cancel data will cause a toss to any data being received should
//    block the setting of DataE/O.
// Cancel data always tosses odd data
// A new true command accept updates lcar with new request, that data has not
//    been received.
// Reset covered by ~abort.

// Odd data status
// Terms:
//    Don't set if interrupt or refetch or abort or cancel data. All cause data
//    to be tossed and or lcar to be updated. Don't set if new true command
//    accept.
// Receive both even and odd data an not tossing odd data.
// Receive just odd data and not tossing it.
// Hold term: dataO can't be set with cancel data since odd data is always
//    tossed on a correct or after even data is tossed.
//    (in the equation it is qualified with ~cancelData because it is a
//    shared term.).
//    interrupt, refetch, abort, or a new fetch request always load new
//    value in lcar, can't have the data for it.
assign nxtDataO = ~interrupt & ~refetch & ~isideAbort & ~IFB_icuCancelDataL2_int &
                   ~(ICU_isCA & (~osrOL2 | isO)) & (
    (isE & isO &
        ~(((ifbDcdHold[1] | dcdHoldDlyL2) & pfb0FullL2_int)
        | pfb1FullL2)) |
    (~isE & isO &
        ~((ifbDcdHold[1] | dcdHoldDlyL2) & pfb1FullL2)) |
    dataOL2
    );

// Even data status.
// Terms:
//    Don't set if interrupt or refetch or abort or cancel data. All cause data
//    to be tossed and or lcar to be updated. If correcting and capturing
//    even data set even data status since lcar will not update
// even data available and not full and holding, not new fetch accept
// correct with even data available and captured.
// Hold term: even data set and not new fetch accept.
//   interrupt, refetch, abort, or new fetch accept load new value in lcar,
//   can't have data, break hold
//   Cancel data must not break hold since cancel data is only set when lcar
//   did not update. Even data status still reflects the current value in
//   the lcar and will be used for picking lcar+4 for a fetch request.
// This equation has been updated to allow ICU_ifbE and ICU_ifbO as mux select
//   on a mux register for speed. Orginal equaiton is kept for reference.
// Fixed for issue 194
// Old Equation
//assign nxtDataE = ~interrupt & ~refetch & ~isideAbort &
//                  ~IFB_icuCancelDataL2_int & (
//        (isE & ~((ifbDcdHold | dcdHoldDlyL2) & pfb1FullL2) &
//            ~(ICU_isCA & (~osrOL2 | isO))) |
//        (isE & ifbDcdHold & ~dcdHoldDlyL2 & pfb0FullL2_int & ~pfb1FullL2)
//        ) |
//        ~interrupt & ~refetch & ~isideAbort & ~(ICU_isCA & (~osrOL2 | isO)) &
//             dataEL2;
// New Equation for issue 194
//assign nxtDataE = ~interrupt & ~refetch & ~isideAbort &
//                  ~IFB_icuCancelDataL2_int & (
//        (isE & ~((ifbDcdHold | dcdHoldDlyL2) & pfb1FullL2) &
//            ~(ICU_isCA & (~osrOL2 | isO))) |
//        (isE & ifbDcdHold & ~dcdHoldDlyL2 & pfb0FullL2_int & ~pfb1FullL2)
//        ) |
//        ~interrupt & ~refetch & ~isideAbort & ~(ICU_isCA & (~osrOL2 | isO)) &
//             dataEL2 |
//        ~interrupt & ~refetch & ~isideAbort &
//             ifbDcdHold & ~dcdHoldDlyL2 & pfb1FullL2 & is0 &
//             dataEL2 & (~isE);    //Note that is is impossible to get isE and
                                    //have dataEL2 set. ~isE is in place so this
                                    //reference equation matches gate level fix
                                    //implemented.

// isE,isO = 00
assign nxtDataE[0] =
  ~interrupt & ~refetch & ~isideAbort & ~IFB_icuCancelDataL2_int &
     (
     ((((|MMU_isStatus) | MMU_isParityErr) & osrEL2) & ~((ifbDcdHold[1] | dcdHoldDlyL2) & pfb1FullL2) &
       ~(ICU_isCA & (~osrOL2 | ((|MMU_isStatus) | MMU_isParityErr)))) |
     (((((|MMU_isStatus) | MMU_isParityErr) & osrEL2)) & ifbDcdHold[1] & ~dcdHoldDlyL2 &
        pfb0FullL2_int & ~pfb1FullL2)
     ) |
  ~interrupt & ~refetch & ~isideAbort &
     ~(ICU_isCA & (~osrOL2 | ((|MMU_isStatus) | MMU_isParityErr))) & dataEL2;
// isE,isO = 01
assign nxtDataE[1] =
  ~interrupt & ~refetch & ~isideAbort & ~IFB_icuCancelDataL2_int &
     (
     ((((|MMU_isStatus) | MMU_isParityErr) & osrEL2) & ~((ifbDcdHold[1] | dcdHoldDlyL2) &
        pfb1FullL2) & ~ICU_isCA) |
     ((((|MMU_isStatus) | MMU_isParityErr) & osrEL2) & ifbDcdHold[1] & ~dcdHoldDlyL2 &
        pfb0FullL2_int & ~pfb1FullL2)
     ) |
// issue 194 dataE must Hold if set for even LCAR and return of dataE and not
//   dataO, (32 bit bus) and dataO is returned same cycle as a Correct occurs.
//   Add second Hold term.
// Old Hold Term
//~interrupt & ~refetch & ~isideAbort & ~ICU_isCA & dataEL2;
// New Hold Term
  ~interrupt & ~refetch & ~isideAbort & ~ICU_isCA & dataEL2 |
  ~interrupt & ~refetch & ~isideAbort &
     ifbDcdHold[1] & ~dcdHoldDlyL2 & pfb1FullL2 & dataEL2;
// isE,isO = 10
assign nxtDataE[2] =
  ~interrupt & ~refetch & ~isideAbort & ~IFB_icuCancelDataL2_int &
     (
     (~((ifbDcdHold[1] | dcdHoldDlyL2) & pfb1FullL2) &
        ~(ICU_isCA & (~osrOL2 | ((|MMU_isStatus) | MMU_isParityErr)))) |
     (ifbDcdHold[1] & ~dcdHoldDlyL2 & pfb0FullL2_int & ~pfb1FullL2)
     ) |
  ~interrupt & ~refetch & ~isideAbort &
     ~(ICU_isCA & (~osrOL2 | ((|MMU_isStatus) | MMU_isParityErr))) & dataEL2;
// isE,isO = 11
assign nxtDataE[3] =
  ~interrupt & ~refetch & ~isideAbort & ~IFB_icuCancelDataL2_int &
     (
     (~((ifbDcdHold[1] | dcdHoldDlyL2) & pfb1FullL2) & ~ICU_isCA) |
     (ifbDcdHold[1] & ~dcdHoldDlyL2 & pfb0FullL2_int & ~pfb1FullL2)
     ) |
  ~interrupt & ~refetch & ~isideAbort & ~ICU_isCA & dataEL2;

///////////
// NL/NP //
///////////
// These bits are saved to be used to calculate new line and new page.
// The register is set any time the cache actually accepts a request.
// Once set they remain set until an actual command accept is received.
assign nxtIsEA_27Dly = (isEA_27 &
                (ICU_isCA &
                (isideAbort | IFB_icuCancelDataL2_int | ~osrOL2 | isO))) |
                (isEA_27DlyL2_int &
                ~(ICU_isCA &
                (isideAbort | IFB_icuCancelDataL2_int | ~osrOL2 | isO)));
assign nxtIsEA_22Dly = (isEA_22 &
                (ICU_isCA &
                (isideAbort | IFB_icuCancelDataL2_int | ~osrOL2 | isO))) |
                (isEA_22DlyL2_int &
                ~(ICU_isCA &
                (isideAbort | IFB_icuCancelDataL2_int | ~osrOL2 | isO)));

/////////////
// isAbort //
/////////////
// aLtchL2 is set anytime that we are go into stopSt, anytime we are in StopSt
// and will remain 1st cycle after leaving stopSt. It also sets for interrupts
// and refetches and for branches that aren't command accepted.
// Signal is duplicated for fanout and timing purposes. Let's hope synthesis
//    can get this right.
assign IFB_isAbortForICU[0] = aLtchL2 | branchTarCrt;
assign IFB_isAbortForICU[1] = aLtchL2 | branchTarCrt;
assign IFB_isAbortForICU[2] = aLtchL2 | branchTarCrt;
assign IFB_isAbortForMMU = aLtchL2 | branchTarCrt;
assign IFB_ocmAbort = aLtchL2 | branchTarCrt |
                      IFB_icuCancelDataL2_int | coreResetL2_int;
assign isideAbort = aLtchL2 | branchTarCrt;

////////////
// branch //
////////////
// pfb0 branch target mux select
// 00 AA
// 01 adder
// 10 ctr
// 11 link

//ignoring leda feedthrough warning
assign pfb0BrTarSel[0] =  pfb0Data_5;

assign pfb0BrTarSel[1] = ~((~pfb0Data_5 & pfb0Data_30) |
                           (pfb0Data_5 & pfb0Data_21));

// dcd branch target mux select
// 00 AA
// 01 adder
// 10 ctr
// 11 link


//ignoring leda feedthrough warning 
assign dcdBrTarSel[0] =  dcdData_5;

assign dcdBrTarSel[1] = ~((~dcdData_5 & dcdData_30) |
                          (dcdData_5 & dcdData_21));

// Select an address from the branch logic.
// Priorty as listed. dcdCorrect and dcdTarget can not happen at the same
//   time so priority not given in mux select.
// 11 - exeCorrect
// 10 - dcdCorrect
// 01 - dcdTarget
// 00 - pfb0Target
//assign isEaForBrSel[0] = ~exeCorrect_Neg | ~dcdCorrect_Neg;
//assign isEaForBrSel[1] = ~exeCorrect_Neg | ~dcdTarget_Neg;

// Final address select for isEa.
// 1 - branch target or correction
// 0 - 048 mux.
assign isEaMuxSel = ~exeCorrect_Neg | ~dcdCorrect_Neg | ~dcdTarget_Neg |
                    ~pfb0Target_Neg;

/////////////
// refetch //
/////////////
assign refetch = (nxtSwapSt_int & (VCT_wbRfi | VCT_wbRfci)) |
                 (wbIsyncL2 & ~nxtSwapSt_int) |
                 tracePipeFlush | nxtStopSt;

//*When stuffing branch taken must select lcar!!
//*We will always select lcar after stuffing because pipe will be empty
//*  with no OSRs or data capture set when we refetch going into stop state.
//*Lcar will load with target when a branch taken is stuffed.
assign refetchPipeStageSel[0:1] = {(exeFullL2_int | PCL_exe2Full | PCL_wbStorageOp),
                    ((dcdFullL2_int & ~exeFullL2_int & ~PCL_exe2Full) | PCL_wbStorageOp)};

always @(LSSD_coreTestEn or lcar_29 or osrEL2 or osrOL2 or dataEL2 or dataOL2)
begin
    casez({LSSD_coreTestEn,lcar_29,osrEL2,osrOL2,dataEL2,dataOL2})
    6'b00000?: refetchLcarMuxSel = 2'b00; // +0 tossed even and odd.
    6'b000010: refetchLcarMuxSel = 2'b01; // +4 captured even tossed odd.
    6'b000011: refetchLcarMuxSel = 2'b10; // +8 captured even and odd.
    6'b00010?: refetchLcarMuxSel = 2'b00; // +0 tossed even will toss/cancel odd.
    6'b00011?: refetchLcarMuxSel = 2'b01; // +4 captured even waiting for odd.
    6'b001???: refetchLcarMuxSel = 2'b00; // +0 waiting for even and odd.
    6'b01?0?0: refetchLcarMuxSel = 2'b00; // +0 odd addr tossed odd.
    6'b01?0?1: refetchLcarMuxSel = 2'b01; // +4 odd addr captured odd.
    6'b01?1??: refetchLcarMuxSel = 2'b00; // +0 odd addr waiting for odd.
    6'b1?????: refetchLcarMuxSel = 2'b11; // for test only.
    default: refetchLcarMuxSel = 2'bxx;
    endcase
end

assign refetchAddrSel = VCT_wbRfi | VCT_wbRfci;

///////////////
// interrupt //
///////////////
assign interrupt = nxtSwapSt_int & (VCT_swap01 | VCT_swap23);

//////////
// Swap //
//////////
assign swapReqQ = VCT_anySwap & ~fifoUnavailable;   //only for state machine

///////////
// sleep //
///////////
assign coreSleepReq = ICU_sleepReq & DCU_sleepReq & TRC_sleepReq &
                          APU_sleepReq & VCT_msrWE & stopStL2;


///////////////////////
// CPU State Machine //
///////////////////////
// The state latch is 5 bits and uses 1 bit per state.
// 0 - stopSt
// 1 - runSt
// 2 - swapSt
// 3 - stuffSt
// 4 - stepSt

// Next state assignments.
// Can't have blkFlush while in stopSt and swapSt.
assign nxtRunSt =
        (runStL2_int | swapStL2_int | stopStL2) &
            (~VCT_msrWE & ~weakStopReqQ & ~hardStopReqQ & ~swapReqQ);

assign nxtSwapSt_int =
        ((runStL2_int | swapStL2_int) & swapReqQ & ~hardStopReq) |
        (stopStL2 & (
            (swapReqQ & ~hardStopReq & ~DBG_weakStopReq) |
            (swapReqQ & ~hardStopReq & ~stuffQ & ~stepQ) |
            (swapReqQ & ~hardStopReq & VCT_msrWE & ~stuffQ))) |
        (stepStL2_int & swapReqQ & hardStopReqQ & ~dIcmpQDlydL2);

assign nxtStopSt =
        ((runStL2_int | swapStL2_int) & (
            (hardStopReqQ) |
            (VCT_msrWE & ~swapReqQ) |
            (weakStopReqQ & ~swapReqQ))) |
        (stopStL2 & (
            (VCT_msrWE & ~stuffQ & ~swapReqQ) |
            (VCT_msrWE & ~hardStopReq & ~DBG_weakStopReq & ~swapReqQ) |
            (DBG_weakStopReq & ~stuffQ & ~stepQ & ~swapReqQ) |
            (hardStopReq & ~stuffQ & ~stepQ))) |
        (stuffStL2_int & dIcmpQDlydL2) |
        (stepStL2_int & dIcmpQDlydL2);

assign nxtStuffSt =
        (stopStL2 & stuffQ & (hardStopReq | DBG_weakStopReq)) |
        (stuffStL2_int & ~dIcmpQDlydL2);

assign nxtStepSt =
        (stopStL2 & (
            (DBG_weakStopReq & ~VCT_msrWE & stepQ) |
            (hardStopReq & VCT_msrWE & stepQ & swapReqQ) |
            (hardStopReq & ~VCT_msrWE & stepQ))) |
        (stepStL2_int &
            ((~dIcmpQDlydL2 & ~hardStopReqQ) | (~dIcmpQDlydL2 & ~swapReqQ)));
            // In weak stop finish instruction before going to stop can't
            // go directly to swap. Can't be interrupted by async interrupts.

// Don't want to allow another step or stuff untill previous one has completed.
assign stuffQ = JTG_stuff & ~dIcmpQDlydL2;
assign stepQ = JTG_step & ~dIcmpQDlydL2;
// Used to load dcd registers
assign stuffReq = stopStL2 & stuffQ & (DBG_weakStopReq | hardStopReq);
assign stuffReqForE1 = stopStL2 & stuffQ;
assign IFB_stopAck_int = (DBG_weakStopReq | hardStopReq) &
                      stopStL2 & ~dIcmpQDlydL2;

// Debug Instr complete.
//assign PCL_dIcmp=(exeFull & ~exeAnyMco & DCU_CA & ICU_dsCA & ~tracePipeHold_int &
//                ~(exeStorageE0 | exeStorageE2)) |
//                (EXE_suppress & ~goToErrC1orC2orC3);
// The stuff terms are need for VCT to flush a stuffed instruction that is
//     suppessed. It is not need for the statemachine, but it still works so
//     we will save the register bit.
assign dIcmpQ = (PCL_dIcmpForStuff & stuffStL2_int) | (PCL_dIcmpForStep & stepStL2_int);

// Reset the stuff and step pending bit.
//  dIcmpqDlydL2 covers any exit from stuffSt or stepSt to stop.
//  If stepStDlydL2 and swapStL2 are both on then we moved directly from
//     stepSt to swapSt and we need to reset the pending bits. Nothing will
//     happen because we allow stuff or step pending to be on while in swapSt.
assign IFB_rstStuffPend = dIcmpQDlydL2;
assign IFB_rstStepPend = dIcmpQDlydL2 | (stepStDlydL2 & swapStL2_int) |
                         (stopStL2 & VCT_msrWE);

// Purposely did not add DBG_weakStopReq to hardStop or
// stopReq since DBG_weakStopReq combines with swapReqQ in a way that
// hardStop does not.
assign hardStopReq = JTG_stopReq | DBG_stopReq;
assign hardStopReqQ = hardStopReq & ~PCL_blkFlush;
assign weakStopReqQ = DBG_weakStopReq & ~PCL_blkFlush;

assign cpuStReset = coreResetL2_int | ICU_syncAfterReset;

/////////////////////
// Trace Equations //
/////////////////////
// Instruction status.
// 00 - No instr's completed.
// 01 - Program Discontinuity, interrupt, rfi, rfci
// 10 - 1 instr NON branch taken
// 11 - 1 instr Branch Taken
// Can't have wbHold or wbSuppress or wbFlush with wbBrTaken.
// Can't have wbFull and swapSt
assign nxtTraceES[0] = ~stuffStL2_int & wbFullQ & ~(xxxTraceDisableL2 & seIdleSt_int) &
            ~(PCL_wbHold | VCT_wbSuppress | VCT_wbFlush);
assign nxtTraceES[1] = ((~stuffStL2_int & wbBrTakenL2) | swapStL2_int) &
                         ~(xxxTraceDisableL2 & seIdleSt_int);
// *******************************
// nxtTraceTE - summary TE trace staging latch. All bits inTEType plus
//              brTaken and icmp.
// *******************************
// nxtTraceTEType
//  0       iac1
//  1       iac2
//  2       iac3
//  3       iac4
//  4       dac1Rd
//  5       dac1Wr
//  6       dac2Rd
//  7       dac2Wr
//  8       trap
//  9       exc
//  10      ude
// *******************************
// wbTE - wb stage of exe events
//  0       brTaken
//  1       iac1
//  2       iac2
//  3       iac3
//  4       iac4
// *******************************
// DBG_wbTE - wb events directly from DBG
//  0       icmp
//  1       dac1Rd
//  2       dac1Wr
//  3       dac2Rd
//  4       dac2Wr
// ******************************
// DBG_immdTE - TE's not moved through the pipeline. Occur immediately
//  0       trap
//  1       exc
//  2       ude
// ******************************
// brTaken and icmp don't have TETypes associated with them.
// TE is in sync with ES except for ude which is asycronous and has no
//    associated ES.
//    trap taken is suppressed and flushed so it does not get a completion
//    status.
//    trap taken and exc will give interrupt ES.
//*   what is the relationship between trap and exc and the interrupt ES???
//    Should be same cycle as ES
assign nxtTraceTEType[0:10] =
                    {({8{(~(PCL_wbHold | VCT_wbSuppress | VCT_wbFlush))}}) &
                     ({wbTEL2[1:4], DBG_wbTE[1:4]}),
                     (DBG_immdTE[0:2])};
assign nxtTraceTE = (~(PCL_wbHold | VCT_wbSuppress | VCT_wbFlush) &
                      ((|wbTEL2[0:4]) | (|DBG_wbTE[0:4]))) |
                    (|DBG_immdTE[0:2]);

// Trace SE Iar selection
// 00 - lcar
// 01 - dcd
// 10 - exe or exe2
// 11 - wb
assign tracePipeStageSel[0] = wbFullQ | (exeFullL2_int | PCL_exe2Full);
assign tracePipeStageSel[1] = wbFullQ |
                                 (dcdFullL2_int & ~(exeFullL2_int | PCL_exe2Full));
// Trace Data selection
// 00 - SE lr or ctr data
// 01 - SE iar data, from tracePipeStage
// 10 - normal lr or ctr data
// 11 - normal swap address data
// normalPost includes swapStL2_int.
assign traceDataSel[0] = normalPost;
assign traceDataSel[1] = (seIarSt & ~normalPost) | swapStL2_int;
// Trace SE Post Statemachine
// The trace SE Posting state machine has
// 4 states and is implemented with 2 latch bits.
// 00 seIdleSt : waits for TRC_se
// 01 seIarSt  : waits to post SE IAR and posts IAR.
// 11 seLrSt   : waits to post SE LR and posts LR.
// 10 seCtrSt  : waits to post SE CTR and posts CTR.
// seIarSt is used as E1 to lr and ctr save registers. They will load each
//     cycle in seIarSt.
assign seIdleSt_int = ~traceStL2[0] & ~traceStL2[1];
assign seIarSt = ~traceStL2[0] & traceStL2[1];
assign seLrSt = traceStL2[0] & traceStL2[1];
assign seCtrSt_int = traceStL2[0] & ~traceStL2[1];

assign nxtIarSt  = (seIdleSt_int & TRC_se) | (seIarSt & ~postSe);
assign nxtLrSt   = (seIarSt & postSe) | (seLrSt & ~postSe);
assign nxtCtrSt  = (seLrSt & postSe) | (seCtrSt_int & ~postSe);

assign nxtTraceSt[0] = ICU_traceEnable & ~coreResetL2_int & (nxtLrSt | nxtCtrSt);
assign nxtTraceSt[1] = ICU_traceEnable & ~coreResetL2_int & (nxtIarSt | nxtLrSt);

// Save registers for SE.
// These equations create the same function as TRC_se & seIdleSt_int. seIdleSt
//   is need to prevent the save register from being overwritten by another
//   SE, from a xxxTraceDisable for example.
assign saveForTraceE1 = TRC_seCtrEqZeroL2 & ICU_traceEnable & ~VCT_msrWE;
assign saveForTraceE2 = ~hardStopReq & ~xxxTraceDisableL2 & seIdleSt_int;

// When fifo fills can't get normal post because mtlr, mtctr will be held in
//    exe, swapReqQ is qualified with fifo unavailable, so postSe will get
//    through.
assign postSe = ~TRC_fifoFull & ~normalPost;
assign normalPost = (wbMtCtrL2 | wbMtLrL2 | swapStL2_int) &
                     ~(xxxTraceDisableL2 & seIdleSt_int);
assign fifoUnavailable = TRC_fifoFull |
       (TRC_fifoOneEntryFree & (normalPost | seIarSt | seLrSt | seCtrSt_int));
// fifoUnavailable blocks swapReq, so swapSt not in tracePipeHold_int.
assign tracePipeHold_int = (exeMtLr | exeMtCtr) & fifoUnavailable;
// VCT_anySwap has ~blockFlush in it.
assign tracePipeFlush = VCT_anySwap & fifoUnavailable;
// 00 = Normal post
// 01 = SE (synchr event) IAR (current)
// 10 = SE LR (current)
// 11 = SE CTR (current)
assign IFB_traceType[0:1] = {((seLrSt | seCtrSt_int) & ~normalPost),
                             ((seIarSt  | seCtrSt_int) & ~normalPost)};
//  Fifo full handled in trace unit.
assign IFB_postEntry = traceStL2[0] | traceStL2[1] | normalPost;

endmodule
