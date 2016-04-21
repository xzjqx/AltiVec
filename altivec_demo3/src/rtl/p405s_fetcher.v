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
// Date Modified: 7/19/01
// Changes made for Cobra, 405 with Parity
// Changes to status register declarations for additional parity signals
// Signals added to fetcher module
// 

module p405s_fetcher( IFB_dcdApu, IFB_dcdDataIn_Neg, IFB_exeDisableDbL2,
     IFB_exeIfetchErrL2, IFB_iac1BitsEq, IFB_iac1GtIar, IFB_iac2BitsEq, IFB_iac2GtIar,
     IFB_iac3BitsEq, IFB_iac3GtIar, IFB_iac4BitsEq, IFB_iac4GtIar, IFB_isEA, IFB_isNL,
     IFB_isNP, IFB_isOcmAbus, IFB_traceData, IFB_wbDisableDbL2, IFB_wbIar,
     dcdData2L2, dcdDataBD_0, dcdDataBO, dcdDataL2, dcdDataPri,
     dcdDataSec, exeIarL2, isEaBuf, lcar_29, pfb0DataL2,
     refetchPipeAddr, wbBrTakenL2, wbTEL2, CB, DBG_exeTE,
     DBG_iacEn, ICU_ifbEDataBus, ICU_ifbError, ICU_ifbODataBus,
     IFB_exeDbgBrTaken, JTG_dbdrPulse, JTG_inst, LSSD_coreTestEn, MMU_isStatus,
     PCL_exe2Full, PCL_exe2IarE1, PCL_exe2IarE2, VCT_vectorBus, coreResetL2, ctrL2,
     dbsrPulseCntlE1, dcdApuE1, dcdBrTarSel, dcdCorrect_Neg, dcdCrtBpntLrCtr, dcdCrtE2,
     dcdCrtMuxSel, dcdDataMuxSel, dcdE1, dcdE2, dcdFullL2, dcdIarMuxSel,
     dcdTarget_Neg, evprL2, exeCorrect_Neg, exeCrtBpntLrCtr, exeCrtE2, exeCrtMuxSel,
     exeDataBr_21L2, exeDataE1, exeDataE2, exeFlushorClear, exeIarE2, iac1L2,
     iac2L2, iac3L2, iac4L2, isEaMuxSel, isEa_22DlyL2, isEa_27DlyL2, lcarE2,
     lcarMuxSel, linkL2, lrCtrNormal_Neg, lrCtrSe_Neg, mux048Sel,
     pfb0BrTarSel, pfb0DataMuxSel, pfb0E1, pfb0E2, pfb0IarMuxSel,
     pfb1DataMuxSel, pfb1E2, pfb1IarMuxSel, refetchAddrSel, refetchLcarMuxSel,
     refetchPipeStageSel, saveForTraceE1, saveForTraceE2, srr02_Neg,
     traceDataSel, tracePipeStageSel, wbDataE1, wbDataE2, wbFlushOrClear, wbIarE1,
     wbIarE2, MMU_isParityErr, ICU_parityErrE, ICU_tagParityErr, ICU_parityErrO,
     IFB_exeISideMachChk, ICU_CCR0IPE, ICU_CCR0TPE);
     
output  IFB_exeDisableDbL2, IFB_iac1BitsEq, IFB_iac1GtIar, IFB_iac2BitsEq, IFB_iac2GtIar,
     IFB_iac3BitsEq, IFB_iac3GtIar, IFB_iac4BitsEq, IFB_iac4GtIar, IFB_isNL, IFB_isNP,
     IFB_wbDisableDbL2, dcdDataBD_0, lcar_29, wbBrTakenL2, IFB_exeISideMachChk;


input  DBG_iacEn, IFB_exeDbgBrTaken, JTG_dbdrPulse, LSSD_coreTestEn, PCL_exe2Full,
     PCL_exe2IarE1, PCL_exe2IarE2, coreResetL2, dbsrPulseCntlE1, dcdApuE1, dcdCorrect_Neg,
     dcdCrtBpntLrCtr, dcdCrtE2, dcdCrtMuxSel, dcdE1, dcdE2, dcdFullL2, dcdTarget_Neg,
     exeCorrect_Neg, exeCrtBpntLrCtr, exeCrtE2, exeDataBr_21L2, exeDataE1, exeDataE2,
     exeFlushorClear, exeIarE2, isEaMuxSel, isEa_22DlyL2, isEa_27DlyL2, lcarE2, pfb0E1, pfb0E2,
     pfb1DataMuxSel, pfb1E2, pfb1IarMuxSel, refetchAddrSel, saveForTraceE1, saveForTraceE2,
     wbDataE1, wbDataE2, wbFlushOrClear, wbIarE1, wbIarE2, MMU_isParityErr, ICU_parityErrE,
     ICU_tagParityErr, ICU_parityErrO, ICU_CCR0IPE, ICU_CCR0TPE;

output [0:29]  IFB_traceData;
output [0:31]  pfb0DataL2;
output [0:4]  IFB_exeIfetchErrL2;
//output [0:2]  IFB_exeIfetchErrL2;
output [0:4]  wbTEL2;
output [11:15]  dcdData2L2;
output [0:10]  dcdDataSec;
output [0:4]  dcdDataBO;
output [0:5]  dcdDataPri;
output [0:29]  IFB_wbIar;
output [0:29]  IFB_isEA;
output [0:29]  isEaBuf;
output [0:31]  dcdDataL2;
output [0:29]  exeIarL2;
output [0:31]  IFB_dcdApu;
output [0:29]  IFB_isOcmAbus;
output [0:29]  refetchPipeAddr;
output [0:31]  IFB_dcdDataIn_Neg;


input [0:29]  iac2L2;
input [0:1]  ICU_ifbError;
input [0:29]  srr02_Neg;
input [0:1]  pfb0DataMuxSel;
input [0:1]  MMU_isStatus;
input [0:1]  dcdBrTarSel;
input [0:31]  JTG_inst;
input [0:31]  ICU_ifbEDataBus;
input [0:1]  dcdDataMuxSel;
input [0:1]  pfb0BrTarSel;
input [0:31]  ICU_ifbODataBus;
input [0:4]  DBG_exeTE;
input [0:1]  pfb0IarMuxSel;
input [0:29]  lrCtrSe_Neg;
input [0:1]  traceDataSel;
input [0:7]  VCT_vectorBus;
input [0:15]  evprL2;
input [0:1]  refetchPipeStageSel;
input [0:1]  dcdIarMuxSel;
input [0:29]  ctrL2;
input [0:29]  linkL2;
input [0:1]  lcarMuxSel;
input [0:29]  iac1L2;
input [0:29]  iac3L2;
input [0:29]  iac4L2;
input   CB;
input [0:1]  tracePipeStageSel;
input [0:1]  mux048Sel;
input [0:1]  refetchLcarMuxSel;
input [0:1]  exeCrtMuxSel;
input [0:29]  lrCtrNormal_Neg;

reg [0:29]  IFB_traceData;
wire [0:31]  IFB_dcdDataIn_Neg;
wire [0:29]  exeIarL2;

// Buses in the design
reg disableDbL2;
reg  [0:15]  pfb0SgnExt;
wire  [0:1]  mmuIsStatusTestability;
wire  [0:4]  pfb1StatusL2;
wire  [16:29]  pfb0BrData;
wire  [0:4]  pfb0StatusL2;
reg  [0:29]  refetchPipeAddr_Neg;
reg  [0:29]  seIar_Neg;
wire  [0:31]  pfb0DataBuf_Neg;
wire  [0:29]  lcar_Neg;
wire  [0:31]  pfb0DataBuf;
reg  [0:29]  dcdTargetAddr_Neg;
wire  [0:29]  dcdBrTarAdd;
reg  [0:15]  dcdSgnExt;
wire  [0:4]  dcdStatusL2;
wire  [16:29]  dcdBrAdd;
wire  [0:31]  dcdData1NegL2;
reg  [0:31]  dcdApuL2;
wire  [0:29]  pfb0BrTarAdd;
wire  [0:29]  pfb0P4;
reg  [0:29]  pfb0IarL2;
reg  [0:29]  pfb1IarL2;
wire  [0:29]  lcarL2_Neg;
wire  [0:29]  muxIsEa_Neg;
wire  [0:29]  lcarForPipe;
reg  [0:31]  pfb1DataL2;
wire  [0:29]  lcarP4Buf;
wire  [0:29]  muxIsEa_2_Neg;
reg  [0:29]  refetchLcar;
wire  [0:29]  lcar;
wire  [0:28]  lcarP8;
wire  [0:29]  mux048;
wire  [0:29]  isEaFromBranch;
wire  [0:29]  lcarL2;
wire  [0:29]  lcarP4;
reg  [0:29]  seIarMux_Neg;
wire  [0:29]  refetchAddr;
reg  [0:29]  exeCrtL2;
reg  [0:29]  dcdCrtL2;
wire  [0:29]  dcdCtrTestability;
wire  [0:29]  exeCorrectAddr_Neg;
wire  [0:29]  dcdP4;
reg  [0:29]  dcdIarL2;
wire  [0:29]  iarForIac_Neg;
reg  [0:29]  wbIarL2;
reg  [0:29]  exe2IarL2;
wire  [0:29]  exeIarSel;
wire  [0:29]  dcdCorrectAddr_Neg;
wire  [0:29]  dcdBrLrCtr;
wire  [0:29]  pfb0TargetAddr;
wire  [0:29]  dcdTargetAddr;
wire  [0:29]  exeLrCtr;
reg  [0:29]  coreTestablityEn;
reg  [0:29]  pfb0TargetAddr_Neg;
wire  [0:29]  lcarForInc;
wire          exeISideMachChkIn;

wire        IFB_exeDisableDbL2_int;
wire        lcar_29_int;
wire [0:31] pfb0DataL2_int;
wire [0:16] dcdData2L2_int_lo;
wire [21:31] dcdData2L2_int_hi;
wire [0:29] isEaBuf_int;
wire [0:31] dcdDataL2_int;
reg [0:29] exeIarL2_int;
reg [0:31] IFB_dcdDataIn_Neg_int;

assign IFB_exeDisableDbL2 = IFB_exeDisableDbL2_int;
assign lcar_29 = lcar_29_int;
assign pfb0DataL2 = pfb0DataL2_int;
assign dcdData2L2[11:15] = dcdData2L2_int_lo[11:15];
assign isEaBuf = isEaBuf_int;
assign dcdDataL2 = dcdDataL2_int;
assign exeIarL2 = exeIarL2_int;
assign IFB_dcdDataIn_Neg = IFB_dcdDataIn_Neg_int;


assign exeISideMachChkIn = dcdStatusL2[0] | (dcdStatusL2[3] & ICU_CCR0TPE) | 
                                (dcdStatusL2[4] & ICU_CCR0IPE);

//Removed the module 'dp_logIFB_Pfb0DataBufB' 
assign pfb0DataBuf[0:31] = ~pfb0DataBuf_Neg[0:31];

//Removed the module 'dp_logIFB_Pfb0DataBuf' 
assign pfb0DataBuf_Neg[0:31] =  ~pfb0DataL2_int[0:31];

//Removed the module 'dp_regIFB_iarForIacTestability' 
always @(posedge CB)
  casez(LSSD_coreTestEn)
    1'b0: coreTestablityEn[0:29] <= coreTestablityEn[0:29];
    1'b1: coreTestablityEn[0:29] <= iarForIac_Neg[0:29];
    default: coreTestablityEn[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_logIFB_mmuStatusTestability' 
assign  mmuIsStatusTestability[0:1] = MMU_isStatus[0:1] ^ {LSSD_coreTestEn, LSSD_coreTestEn};

// Replacing instantiation: XOR2 dp_logIFB_mmuParityTestability
wire mmuParityTestability;
assign mmuParityTestability = LSSD_coreTestEn ^ MMU_isParityErr;

//Removed the module 'dp_logIFB_dcdCrtTestability' 
assign dcdCtrTestability[0:29] = {30{LSSD_coreTestEn}} ^ dcdCrtL2[0:29];

//Removed the module 'dp_regIFB_iarForTrace' 
always @(posedge CB)
  casez(saveForTraceE1 & saveForTraceE2)
    1'b0: seIar_Neg[0:29] <= seIar_Neg[0:29];
    1'b1: seIar_Neg[0:29] <= seIarMux_Neg[0:29];
    default: seIar_Neg[0:29] <= 30'bx;
  endcase

// Replacing instantiation: INVERT sel_B
wire dcdCorrect;
assign dcdCorrect = ~(dcdCorrect_Neg);

// Replacing instantiation: INVERT sel_A
wire exeCorrect;
assign exeCorrect = ~(exeCorrect_Neg);

// Replacing instantiation: INVERT sel_C
wire dcdTarget;
assign dcdTarget = ~(dcdTarget_Neg);

// Replacing instantiation: INVERT sel_H
wire selExeCorrect_Neg;
wire selExeCorrect;
assign selExeCorrect = ~(selExeCorrect_Neg);

// Replacing instantiation: INVERT sel_K
wire delPfb0Target_Neg;
wire selPfb0Target;
assign selPfb0Target = ~(delPfb0Target_Neg);

// Replacing instantiation: INVERT sel_J
wire selDcdTarget_Neg;
wire selDecTarget;
assign selDecTarget = ~(selDcdTarget_Neg);

// Replacing instantiation: INVERT sel_I
wire selDcdCorrect_Neg;
wire selDcdCorrect;
assign selDcdCorrect = ~(selDcdCorrect_Neg);

// Replacing instantiation: NAND3 sel_G
assign delPfb0Target_Neg = ~( exeCorrect_Neg & dcdCorrect_Neg & dcdTarget_Neg );

// Replacing instantiation: NAND3 sel_F
assign selDcdTarget_Neg = ~( exeCorrect_Neg & dcdCorrect_Neg & dcdTarget );

// Replacing instantiation: NAND2 sel_E
assign selDcdCorrect_Neg = ~( exeCorrect_Neg & dcdCorrect );

// Replacing instantiation: INVERT sel_D
assign selExeCorrect_Neg = ~(exeCorrect);

assign isEaFromBranch = ~( (exeCorrectAddr_Neg & {30{selExeCorrect}}) |
                           (dcdCorrectAddr_Neg & {30{selDcdCorrect}}) |
                           (dcdTargetAddr_Neg & {30{selDecTarget}}) |
                           (pfb0TargetAddr_Neg & {30{selPfb0Target}}) );


//Removed the module 'dp_muxIFB_DcdLrCtr'
assign dcdBrLrCtr[0:29] = (linkL2[0:29] & {(30){~(dcdDataL2_int[21])}} ) 
                              | (ctrL2[0:29] & {(30){dcdDataL2_int[21]}} );


//Removed the module 'dp_logIFB_lcarRepower' 
assign lcarL2_Neg[0:29] = ~lcarL2[0:29];

//Removed the modue 'dp_logIFB_dcdApuBuf' 
assign IFB_dcdApu[0:31] = dcdApuL2[0:31];

//Removed the module 'dp_regIFB_DcdApu2' 
//Removed the module 'dp_regIFB_DcdApu1' 
always @(posedge CB)
  casez(dcdApuE1 & dcdE2)
    1'b0: dcdApuL2[0:31] <= dcdApuL2[0:31];
    1'b1: dcdApuL2[0:31] <= IFB_dcdDataIn_Neg_int[0:31];
    default: dcdApuL2[0:31] <= 32'bx;
  endcase

//Removed the module 'dp_logIFB_dcdBrTarInv' 
assign dcdTargetAddr[0:29] = ~dcdTargetAddr_Neg[0:29]; 

//Removed the module 'dp_muxIFB_dcdBrTar' 
always @(dcdSgnExt or dcdBrAdd or dcdBrTarAdd or ctrL2 or linkL2 or dcdBrTarSel)
  case(dcdBrTarSel[0:1])
    2'b00: dcdTargetAddr_Neg[0:29] = ~{dcdSgnExt[0:15], dcdBrAdd[16:29]};
    2'b01: dcdTargetAddr_Neg[0:29] = ~dcdBrTarAdd[0:29];
    2'b10: dcdTargetAddr_Neg[0:29] = ~ctrL2[0:29];
    2'b11: dcdTargetAddr_Neg[0:29] = ~linkL2[0:29];
    default: dcdTargetAddr_Neg[0:29] = 30'bx;
  endcase

//Removed the module 'dp_muxIFB_pfb0BrTar' 
always @(pfb0SgnExt or pfb0BrData or pfb0BrTarAdd or ctrL2 or linkL2 or pfb0BrTarSel)
  case(pfb0BrTarSel[0:1])
    2'b00: pfb0TargetAddr_Neg[0:29] = ~{pfb0SgnExt[0:15], pfb0BrData[16:29]};
    2'b01: pfb0TargetAddr_Neg[0:29] = ~pfb0BrTarAdd[0:29];
    2'b10: pfb0TargetAddr_Neg[0:29] = ~ctrL2[0:29];
    2'b11: pfb0TargetAddr_Neg[0:29] = ~linkL2[0:29];
    default: pfb0TargetAddr_Neg[0:29] = 30'bx;
  endcase

//Removed the module 'dp_logIFB_pfb0BrTarInv' 
assign pfb0TargetAddr[0:29] = ~pfb0TargetAddr_Neg[0:29]; 

//Removed the module 'dp_logIFB_NLNPXor' 
wire nlP0, nlP4, nlP8, npP0, npP4, npP8;
assign {nlP0, nlP4, nlP8, npP0, npP4, npP8} = 
      {isEa_27DlyL2, isEa_27DlyL2, isEa_27DlyL2, isEa_22DlyL2, isEa_22DlyL2, isEa_22DlyL2} ^
      {lcarForInc[27], lcarP4[27], lcarP8[27], lcarForInc[22], lcarP4[22], lcarP8[22]};

//Removed the module 'dp_muxIFB_isEa_2' 
assign muxIsEa_2_Neg[0:29] = ~( (mux048[0:29] & {(30){~(isEaMuxSel)}} ) | 
                    (isEaFromBranch[0:29] & {(30){isEaMuxSel}} ) );

//Removed the module 'dp_muxIFB_isEa'
assign muxIsEa_Neg[0:29] = ~( (mux048[0:29] & {(30){~(isEaMuxSel)}} ) | 
                     (isEaFromBranch[0:29] & {(30){isEaMuxSel}} ) );

//Removed the module 'dp_muxIFB_ExeCorrect' 
assign exeCorrectAddr_Neg[0:29] = ~( (exeCrtL2[0:29] & {(30){~(exeCrtBpntLrCtr)}} ) 
                                    | (exeLrCtr[0:29] & {(30){exeCrtBpntLrCtr}} ) );

//Removed the module 'dp_muxIFB_ExeLrCtr' 
assign exeLrCtr[0:29] = (linkL2[0:29] & {(30){~(exeDataBr_21L2)}} ) | 
                               (ctrL2[0:29] & {(30){exeDataBr_21L2}} );

//Removed the module 'dp_muxIFB_DcdCorrect'
assign dcdCorrectAddr_Neg[0:29] = ~( (dcdCrtL2[0:29] & {(30){~(dcdCrtBpntLrCtr)}} ) 
                                  | ( dcdBrLrCtr[0:29] & {(30){dcdCrtBpntLrCtr}} ) );

//Removed the module 'dp_logIFB_lcarForIncr' 
assign lcarForInc[0:29] = ~lcarL2_Neg[0:29];

//Removed the module 'dp_regIFB_LcarB' 
wire [0:14] LcarB_mux_D1;
reg [0:14] LcarB_Mux;
reg [0:14] LcarB_Reg;
assign lcarL2[15:29] = LcarB_Reg;
assign LcarB_mux_D1 = {evprL2[15], 2'b0, VCT_vectorBus[0:5], 2'b0, VCT_vectorBus[6:7], 2'b0};
always @(isEaBuf_int or LcarB_mux_D1 or refetchAddr or lcarMuxSel)
  casez(lcarMuxSel[0:1])
    2'b00: LcarB_Mux = isEaBuf_int[15:29];
    2'b01: LcarB_Mux = LcarB_mux_D1;
    2'b10: LcarB_Mux = refetchAddr[15:29];
 // changed by swang    2'b11: LcarB_Mux = 15'h7fff;
	 2'b11: LcarB_Mux = 15'h0;
    default: LcarB_Mux = 15'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(lcarE2)
    1'b0: LcarB_Reg <= LcarB_Reg;
    1'b1: LcarB_Reg <= LcarB_Mux;
    default: LcarB_Reg <= 15'bx;
  endcase

//Removed the module 'dp_regIFB_LcarA' 
//by swang: PC mux
reg [0:14] LcarA_Mux;
reg [0:14] LcarA_Reg;
assign lcarL2[0:14] = LcarA_Reg;
always @(isEaBuf_int or evprL2 or refetchAddr or lcarMuxSel)
  casez(lcarMuxSel[0:1])
    2'b00: LcarA_Mux = isEaBuf_int[0:14];
    2'b01: LcarA_Mux = evprL2[0:14];
    2'b10: LcarA_Mux = refetchAddr[0:14];
//    2'b11: LcarA_Mux = 15'h7fff; // changed by swang
      2'b11: LcarA_Mux = 15'h0;
    default: LcarA_Mux = 15'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(lcarE2)
    1'b0: LcarA_Reg <= LcarA_Reg;
    1'b1: LcarA_Reg <= LcarA_Mux;
    default: LcarA_Reg <= 15'bx;
  endcase

//Removed the module 'dp_regIFB_Pfb0Data2' 
//Removed the module 'dp_regIFB_Pfb0Data1' 
reg [0:31] Pfb0Data2_Mux;
reg [0:31] Pfb0Data2_Reg;
assign pfb0DataL2_int[0:31] = Pfb0Data2_Reg;
always @(pfb0DataMuxSel or pfb1DataL2 or ICU_ifbEDataBus or ICU_ifbODataBus)
  casez(pfb0DataMuxSel[0:1])
    2'b00: Pfb0Data2_Mux = pfb1DataL2[0:31];
    2'b01: Pfb0Data2_Mux = ICU_ifbEDataBus[0:31];
    2'b10: Pfb0Data2_Mux = ICU_ifbODataBus[0:31];
    2'b11: Pfb0Data2_Mux = 32'b0;
    default: Pfb0Data2_Mux = 32'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb0E2)
    1'b0: Pfb0Data2_Reg <= Pfb0Data2_Reg;
    1'b1: Pfb0Data2_Reg <= Pfb0Data2_Mux;
    default: Pfb0Data2_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_DcdData4' 
reg [0:11] DcdData4_Reg;
wire [0:11] DcdData4;
assign  {dcdData2L2_int_lo[16], dcdData2L2_int_hi[21:31]} = DcdData4_Reg; 
assign DcdData4 = {IFB_dcdDataIn_Neg_int[16], IFB_dcdDataIn_Neg_int[21:31]}; 
always @(posedge CB)
  casez(dcdE1 & dcdE2)
    1'b0: DcdData4_Reg <= DcdData4_Reg;
    1'b1: DcdData4_Reg <= DcdData4;
    default: DcdData4_Reg <= 12'bx;
  endcase

//Removed the module 'dp_regIFB_DcdData3' 
reg [0:15] DcdData3_Reg;
assign dcdData2L2_int_lo[0:15] = DcdData3_Reg;
always @(posedge CB)
  casez(dcdE1 & dcdE2)
    1'b0: DcdData3_Reg <= DcdData3_Reg;
    1'b1: DcdData3_Reg <= IFB_dcdDataIn_Neg_int[0:15];
    default: DcdData3_Reg <= 16'bx;
  endcase

//Removed the module 'dp_logIFB_pfb0BrAddBuf' 
assign pfb0BrData[16:29] = ~pfb0DataBuf_Neg[16:29];

//Removed the module 'dp_logIFB_dcdBrAddBuf' 
assign dcdBrAdd[16:29] = dcdDataL2_int[16:29];

//Removed the module 'dp_logIFB_mux048Buf' 
wire NL, NP;
assign {IFB_isNL, IFB_isNP} = {NL, NP};

//Removed the module 'dp_logIFB_lcarInc4Buf' 
assign lcarP4Buf[0:29] = lcarP4[0:29];

//Removed the module 'dp_logIFB_isEaBuf' 
assign IFB_isEA[0:29] = ~muxIsEa_Neg[0:29];

//Removed the module 'dp_logIFB_dcdDataForBr' 
assign {dcdDataPri[0:5], dcdDataBO[0:4], dcdDataBD_0, dcdDataSec[0:10]} = 
            {dcdData2L2_int_lo[0:10], dcdData2L2_int_lo[16], dcdData2L2_int_hi[21:31]};

//Removed the module 'dp_logIFB_lcarForAddr' 
assign lcar_29_int = ~(LSSD_coreTestEn ^ lcarL2_Neg[29]);

//Removed the module 'dp_logIFB_lcarForPipe' 
assign lcarForPipe[0:29] = ~lcarL2_Neg[0:29];

//Removed the module 'dp_logIFB_lcarForRefetch' 
assign lcar[0:29] = ~lcarL2_Neg[0:29];

//Removed the module 'x_macIFB_pfb0SignExt'
always @(pfb0DataBuf_Neg or pfb0DataBuf_Neg)
  casez(pfb0DataBuf_Neg[4])
    1'b1: pfb0SgnExt[0:15] = ~{16{pfb0DataBuf_Neg[16]}};
    1'b0: pfb0SgnExt[0:15] = ~{{6{pfb0DataBuf_Neg[6]}},pfb0DataBuf_Neg[6:15]};
    default: pfb0SgnExt[0:15] = 16'hxxxx;
  endcase

//Removed the module 'x_macIFB_dcdSignExt' 
always @(dcdDataL2_int or dcdDataL2_int)
  casez(dcdDataL2_int[4])
    1'b0: dcdSgnExt[0:15] = {16{dcdDataL2_int[16]}};
    1'b1: dcdSgnExt[0:15] = {{6{dcdDataL2_int[6]}},dcdDataL2_int[6:15]};
    default: dcdSgnExt[0:15] = 16'hxxxx;
  endcase


//adders and incrementors
//Removed the module 'SM_ADD30_P2'
wire [29:0] pfb0IarL2_rev;
wire [29:0] SDT_pfb0IarAdd_B_rev;
wire [30:0] pfb0BrTarAdd_rev;
assign pfb0IarL2_rev = pfb0IarL2[0:29];
assign SDT_pfb0IarAdd_B_rev = {pfb0SgnExt[0:15], pfb0BrData[16:29]};
assign pfb0BrTarAdd_rev = {1'b0,pfb0IarL2_rev} + {1'b0,SDT_pfb0IarAdd_B_rev}; 
assign pfb0BrTarAdd = pfb0BrTarAdd_rev[29:0];

//Removed the module 'SM_ADD30_P2'
wire [29:0] dcdIarL2_rev;
wire [29:0] SDT_dcdIarAdd_B_rev;
wire [30:0] dcdBrTarAdd_rev;
assign dcdIarL2_rev = dcdIarL2[0:29];
assign SDT_dcdIarAdd_B_rev = {dcdSgnExt[0:15], dcdBrAdd[16:29]};
assign dcdBrTarAdd_rev = {1'b0,dcdIarL2_rev} + {1'b0,SDT_dcdIarAdd_B_rev};
assign dcdBrTarAdd = dcdBrTarAdd_rev[29:0];

//Removed the module 'dp_macIFB_dcdIarInc4' 
wire [30:0] dcdP4_rev;
assign dcdP4_rev = {1'b0,dcdIarL2_rev} + 1;
assign dcdP4 = dcdP4_rev[29:0];

//Removed the module 'dp_macIFB_pfb0IarInc4'
wire [30:0] pfb0P4_rev;
assign pfb0P4_rev = {1'b0,pfb0IarL2_rev} + 1;
assign pfb0P4 = pfb0P4_rev[29:0];

//Removed the module 'dp_macIFB_lcarInc8'
wire [28:0] lcarForInc8_rev;
wire [29:0] lcarP8_rev;
assign lcarForInc8_rev = lcarForInc[0:28];
assign lcarP8_rev = {1'b0,lcarForInc8_rev[28:0]} + 1;
assign lcarP8 = lcarP8_rev[28:0];

//Removed the module 'dp_macIFB_lcarInc4'
wire [29:0] lcarForInc4_rev;
wire [30:0] lcarP4_rev;
assign lcarForInc4_rev = lcarForInc[0:29];
assign lcarP4_rev = {1'b0,lcarForInc4_rev[29:0]} + 1;
assign lcarP4 = lcarP4_rev[29:0];

//Removed the module 'dp_logIFB_lcarInv' 
assign lcar_Neg[0:29] = ~lcar[0:29];

//Removed the module 'dp_logIFB_dcdDataInv'
assign dcdDataL2_int[0:31] = ~dcdData1NegL2[0:31];

//Removed the module 'dp_regIFB_DcdData2' 
//Removed the module 'dp_regIFB_DcdData1' 
reg [0:31] DcdData2_Reg;
assign dcdData1NegL2[0:31] = ~DcdData2_Reg;
always @(posedge CB)
  casez(dcdE1 & dcdE2)
    1'b0: DcdData2_Reg <= DcdData2_Reg;
    1'b1: DcdData2_Reg <= IFB_dcdDataIn_Neg_int[0:31];
    default: DcdData2_Reg <= 32'bx;
  endcase

//Removed the module 'dp_logIFB_wbIarBuf' 
assign IFB_wbIar[0:29] = wbIarL2[0:29];

//Removed the module 'dp_muxIFB_traceData' 
always @(lrCtrSe_Neg or seIar_Neg or lrCtrNormal_Neg or lcar_Neg or traceDataSel)
  case(traceDataSel[0:1])
    2'b00: IFB_traceData = ~lrCtrSe_Neg[0:29];
    2'b01: IFB_traceData = ~seIar_Neg[0:29];
    2'b10: IFB_traceData = ~lrCtrNormal_Neg[0:29];
    2'b11: IFB_traceData = ~lcar_Neg[0:29];
    default: IFB_traceData = 30'bx;
  endcase

//Removed the module 'dp_muxIFB_tracePipeStage' 
always @(tracePipeStageSel or refetchLcar or dcdIarL2 or exeIarSel or wbIarL2)
  case(tracePipeStageSel[0:1])
    2'b00: seIarMux_Neg = ~refetchLcar;
    2'b01: seIarMux_Neg = ~dcdIarL2;
    2'b10: seIarMux_Neg = ~exeIarSel;
    2'b11: seIarMux_Neg = ~wbIarL2;
    default: seIarMux_Neg = 30'bx;
  endcase

//Removed the module 'dp_muxIFB_exeIarSel' 
assign exeIarSel[0:29] = (exeIarL2_int[0:29] & {(30){~(PCL_exe2Full)}} ) | 
                               (exe2IarL2[0:29] & {(30){PCL_exe2Full}} );

//Removed the module 'dp_logIFB_isEaBufOcm' 
assign IFB_isOcmAbus[0:29] = ~muxIsEa_2_Neg[0:29];

//Removed the module 'dp_logIFB_isEaBufLcar' 
assign isEaBuf_int[0:29] = ~muxIsEa_2_Neg[0:29];

//Removed the module 'dp_regIFB_wbStatus' 
reg [0:6] wbStatus_Mux;
reg [0:6] wbStatus_Reg;
assign {wbTEL2[0:4], wbBrTakenL2, IFB_wbDisableDbL2} = wbStatus_Reg;
always @(wbFlushOrClear or DBG_exeTE or IFB_exeDbgBrTaken or IFB_exeDisableDbL2_int)
  casez(wbFlushOrClear)
    1'b0: wbStatus_Mux = {DBG_exeTE[0:4], IFB_exeDbgBrTaken, IFB_exeDisableDbL2_int};
    1'b1: wbStatus_Mux = 7'b0;
    default: wbStatus_Mux = 7'bx;
  endcase
always @(posedge CB)
  casez(wbDataE1 & wbDataE2)
    1'b0: wbStatus_Reg <= wbStatus_Reg;
    1'b1: wbStatus_Reg <= wbStatus_Mux;
    default: wbStatus_Reg <= 7'bx;
  endcase

//Removed the module 'dp_regIFB_dbdrPulseCntl' 
reg dbdrPulseCntl_Mux;
always @(JTG_dbdrPulse or coreResetL2)
  casez(coreResetL2)
    1'b0: dbdrPulseCntl_Mux = JTG_dbdrPulse;
    1'b1: dbdrPulseCntl_Mux = 1'b0;
    default: dbdrPulseCntl_Mux = 1'bx;
  endcase
always @(posedge CB)
  casez(dbsrPulseCntlE1)
    1'b0: disableDbL2 <= disableDbL2;
    1'b1: disableDbL2 <= dbdrPulseCntl_Mux;
    default: disableDbL2 <= 1'bx;
  endcase

//Removed the module 'dp_regIFB_exe2Iar' 
always @(posedge CB)
  casez(PCL_exe2IarE1 & PCL_exe2IarE2)
    1'b0: exe2IarL2[0:29] <= exe2IarL2[0:29];
    1'b1: exe2IarL2[0:29] <= exeIarL2_int[0:29];
    default: exe2IarL2[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_muxIFB_refetchLcar' 
always @(refetchLcarMuxSel or lcar or lcarP4 or lcarP8 or lcar_29_int)
  case(refetchLcarMuxSel[0:1])
    2'b00: refetchLcar[0:29] = lcar[0:29];
    2'b01: refetchLcar[0:29] = lcarP4[0:29];
    2'b10: refetchLcar[0:29] = {lcarP8[0:28], lcar_29_int};
    2'b11: refetchLcar[0:29] = 30'b0;
    default: refetchLcar[0:29] = 30'bx;
  endcase

//Removed the module 'dp_logIFB_invRefetchPipeAddr' 
assign refetchPipeAddr[0:29] = ~refetchPipeAddr_Neg[0:29];

//Removed the module 'dp_logIFB_dcdIarForIac' 
assign iarForIac_Neg[0:29] = ~(dcdIarL2[0:29] & {(30){DBG_iacEn}} );

//Removed the module 'SM_ADD30CODETONE' 
wire [29:0] iac4L2_rev;
wire [29:0] iarForIac_Neg_rev;
wire [29:0] iac4Add_sum;
assign iac4L2_rev[29:0] = iac4L2[0:29];
assign iarForIac_Neg_rev[29:0] = iarForIac_Neg[0:29];
assign {IFB_iac4GtIar,iac4Add_sum} = 
             {1'b0,iac4L2_rev} + {1'b0,iarForIac_Neg_rev} + 31'b0;
assign IFB_iac4BitsEq = &(iac4L2_rev ^ iarForIac_Neg_rev);

//Removed the module 'SM_ADD30CODETONE'
wire [29:0] iac3L2_rev;
wire [29:0] iac3Add_sum;
assign iac3L2_rev[29:0] = iac3L2[0:29];
assign {IFB_iac3GtIar,iac3Add_sum} = 
             {1'b0,iac3L2_rev} + {1'b0,iarForIac_Neg_rev} + 31'b0;
assign IFB_iac3BitsEq = &(iac3L2_rev ^ iarForIac_Neg_rev);

//Removed the module 'SM_ADD30CODETONE' 
wire [29:0] iac2L2_rev;
wire [29:0] iac2Add_sum;
assign iac2L2_rev[29:0] = iac2L2[0:29];
assign {IFB_iac2GtIar,iac2Add_sum} = 
             {1'b0,iac2L2_rev} + {1'b0,iarForIac_Neg_rev} + 31'b0;
assign IFB_iac2BitsEq = &(iac2L2_rev ^ iarForIac_Neg_rev);

//Removed the module 'SM_ADD30CODETONE'
wire IFB_iac1BitsEq;
wire [29:0] iac1L2_rev;
wire [29:0] iac1Add_sum;
assign iac1L2_rev[29:0] = iac1L2[0:29];
assign {IFB_iac1GtIar,iac1Add_sum} = 
             {1'b0,iac1L2_rev} + {1'b0,iarForIac_Neg_rev} + 31'b0;
assign IFB_iac1BitsEq = &(iac1L2_rev ^ iarForIac_Neg_rev);

//Removed the module 'dp_logIFB_fetcherAclk';
//Removed the module 'dp_regIFB_exeStatus' 
  
wire [0:6] exeStatus_D0;
reg [0:6] exeStatus_Mux;
reg [0:6] exeStatus_Reg;
assign exeStatus_D0 = {exeISideMachChkIn, dcdStatusL2[3:4], dcdStatusL2[0:2], disableDbL2};
assign {IFB_exeISideMachChk, IFB_exeIfetchErrL2[3:4],
             IFB_exeIfetchErrL2[0:2], IFB_exeDisableDbL2_int} = exeStatus_Reg;
always @(exeStatus_D0 or exeFlushorClear)
  casez(exeFlushorClear)
    1'b0: exeStatus_Mux = exeStatus_D0;
    1'b1: exeStatus_Mux = 7'b0;
    default: exeStatus_Mux = 7'bx;
  endcase
always @(posedge CB)
  casez(exeDataE1 & exeDataE2)
    1'b0: exeStatus_Reg <= exeStatus_Reg;
    1'b1: exeStatus_Reg <= exeStatus_Mux;
    default: exeStatus_Reg <= 7'bx;
  endcase

//Removed the module 'dp_regIFB_dcdStatus' 
wire [0:4] dcdStatus_D0;
wire [0:4] dcdStatus_D1;
wire [0:4] dcdStatus_D2;
reg [0:4] dcdStatus_Mux;
reg [0:4] dcdStatus_Reg;
assign dcdStatus_D0 = {pfb0StatusL2[3:4],pfb0StatusL2[0:2]};
assign dcdStatus_D1 = {mmuParityTestability, (ICU_parityErrE | ICU_tagParityErr), 
                        ICU_ifbError[0], mmuIsStatusTestability[0:1]};
assign dcdStatus_D2 = {MMU_isParityErr, (ICU_parityErrO | ICU_tagParityErr), 
                        ICU_ifbError[1], MMU_isStatus[0:1]};
assign {dcdStatusL2[3:4], dcdStatusL2[0:2]} = dcdStatus_Reg;
always @(dcdStatus_D0 or dcdStatus_D1 or dcdStatus_D2 or dcdDataMuxSel)
  casez(dcdDataMuxSel[0:1])
    2'b00: dcdStatus_Mux = dcdStatus_D0;
    2'b01: dcdStatus_Mux = dcdStatus_D1;
    2'b10: dcdStatus_Mux = dcdStatus_D2;
    2'b11: dcdStatus_Mux = 5'b0;
    default: dcdStatus_Mux = 5'bx;
  endcase
always @(posedge CB)
  casez(dcdE1 & dcdE2)
    1'b0: dcdStatus_Reg <= dcdStatus_Reg;
    1'b1: dcdStatus_Reg <= dcdStatus_Mux;
    default: dcdStatus_Reg <= 5'bx;
  endcase
   
//Removed the module 'dp_regIFB_pfb0Status' 
wire [0:4] pfb0Status_D0;
wire [0:4] pfb0Status_D1;
wire [0:4] pfb0Status_D2;
reg [0:4] pfb0Status_Mux;
reg [0:4] pfb0Status_Reg;
assign pfb0Status_D0 = {pfb1StatusL2[3:4],pfb1StatusL2[0:2]};
assign pfb0Status_D1 = {mmuParityTestability, (ICU_parityErrE | ICU_tagParityErr), 
                        ICU_ifbError[0], mmuIsStatusTestability[0:1]};
assign pfb0Status_D2 = {MMU_isParityErr, (ICU_parityErrO | ICU_tagParityErr), ICU_ifbError[1], 
                        MMU_isStatus[0:1]};
assign {pfb0StatusL2[3:4],pfb0StatusL2[0:2]} = pfb0Status_Reg;
always @(pfb0Status_D0 or pfb0Status_D1 or pfb0Status_D2 or pfb0DataMuxSel)
  casez(pfb0DataMuxSel[0:1])
    2'b00: pfb0Status_Mux = pfb0Status_D0;
    2'b01: pfb0Status_Mux = pfb0Status_D1;
    2'b10: pfb0Status_Mux = pfb0Status_D2;
    2'b11: pfb0Status_Mux = 5'b0;
    default: pfb0Status_Mux = 5'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb0E2)
    1'b0: pfb0Status_Reg <= pfb0Status_Reg;
    1'b1: pfb0Status_Reg <= pfb0Status_Mux;
    default: pfb0Status_Reg <= 5'bx;
  endcase

//Removed the module 'dp_regIFB_pfb1Status' 
wire [0:4] pfb1Status_D0;
wire [0:4] pfb1Status_D1;
reg [0:4] pfb1Status_Mux;
reg [0:4] pfb1Status_Reg;
assign pfb1Status_D0 = {mmuParityTestability, (ICU_parityErrE | ICU_tagParityErr), 
                            ICU_ifbError[0], mmuIsStatusTestability[0:1]};
assign pfb1Status_D1 = {MMU_isParityErr, (ICU_parityErrO | ICU_tagParityErr), 
                            ICU_ifbError[1], MMU_isStatus[0:1]};
assign {pfb1StatusL2[3:4],pfb1StatusL2[0:2]} = pfb1Status_Reg;
always @(pfb1Status_D0 or pfb1Status_D1 or pfb1DataMuxSel)
  casez(pfb1DataMuxSel)
    1'b0: pfb1Status_Mux = pfb1Status_D0;
    1'b1: pfb1Status_Mux = pfb1Status_D1;
    default: pfb1Status_Mux = 5'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb1E2)
    1'b0: pfb1Status_Reg <= pfb1Status_Reg;
    1'b1: pfb1Status_Reg <= pfb1Status_Mux;
    default: pfb1Status_Reg <= 5'bx;
  endcase

//Removed the module 'dp_muxIFB_refetchAddr' 
assign refetchAddr = ~( (refetchPipeAddr_Neg & {(30){~(refetchAddrSel)}} ) | 
                          (srr02_Neg[0:29] & {(30){refetchAddrSel}} ) );

//Removed the module 'dp_muxIFB_refetchPipeStage' 
always @(refetchLcar or dcdIarL2 or exeIarSel or wbIarL2 or refetchPipeStageSel)
  case(refetchPipeStageSel[0:1])
    2'b00: refetchPipeAddr_Neg[0:29] = ~refetchLcar;
    2'b01: refetchPipeAddr_Neg[0:29] = ~dcdIarL2;
    2'b10: refetchPipeAddr_Neg[0:29] = ~exeIarSel;
    2'b11: refetchPipeAddr_Neg[0:29] = ~wbIarL2;
    default: refetchPipeAddr_Neg[0:29] = 30'bx;
  endcase

//Removed the module 'dp_muxIFB_DcdData' 
always @(pfb0DataBuf or ICU_ifbEDataBus or ICU_ifbODataBus or JTG_inst or dcdDataMuxSel)
  case(dcdDataMuxSel[0:1])
    2'b00: IFB_dcdDataIn_Neg_int[0:31] = pfb0DataBuf;
    2'b01: IFB_dcdDataIn_Neg_int[0:31] = ICU_ifbEDataBus;
    2'b10: IFB_dcdDataIn_Neg_int[0:31] = ICU_ifbODataBus;
    2'b11: IFB_dcdDataIn_Neg_int[0:31] = JTG_inst;
    default: IFB_dcdDataIn_Neg_int[0:31] = 32'bx;
  endcase

//Removed the module 'dp_regIFB_Pfb1Data' 
reg [0:31] Pfb1Data_Mux;
always @(ICU_ifbEDataBus or ICU_ifbODataBus or pfb1DataMuxSel)
  casez(pfb1DataMuxSel)
    1'b0: Pfb1Data_Mux[0:31] = ICU_ifbEDataBus[0:31];
    1'b1: Pfb1Data_Mux[0:31] = ICU_ifbODataBus[0:31];
    default: Pfb1Data_Mux[0:31] = 32'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb1E2)
    1'b0: pfb1DataL2[0:31] <= pfb1DataL2[0:31];
    1'b1: pfb1DataL2[0:31] <= Pfb1Data_Mux[0:31];
    default: pfb1DataL2[0:31] <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_DcdCrt' 
reg [0:29] DcdCrt_Mux;
always @(pfb0P4 or pfb0TargetAddr or dcdCrtMuxSel)
  casez(dcdCrtMuxSel)
    1'b0: DcdCrt_Mux = pfb0P4[0:29];
    1'b1: DcdCrt_Mux = pfb0TargetAddr[0:29];
    default: DcdCrt_Mux = 30'bx;
  endcase
always @(posedge CB)
  casez(dcdCrtE2)
    1'b0: dcdCrtL2[0:29] <= dcdCrtL2[0:29];
    1'b1: dcdCrtL2[0:29] <= DcdCrt_Mux;
    default: dcdCrtL2[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_ExeCrt' 
reg [0:29] ExeCrt_Mux;
always @(dcdP4 or dcdTargetAddr or dcdCtrTestability or dcdCrtL2 or exeCrtMuxSel)
  casez(exeCrtMuxSel[0:1])
    2'b00: ExeCrt_Mux = dcdP4[0:29];
    2'b01: ExeCrt_Mux = dcdTargetAddr[0:29];
    2'b10: ExeCrt_Mux = dcdCtrTestability[0:29];
    2'b11: ExeCrt_Mux = dcdCrtL2[0:29];
    default: ExeCrt_Mux = 30'bx;
  endcase
always @(posedge CB)
  casez(exeCrtE2)
    1'b0: exeCrtL2[0:29] <= exeCrtL2[0:29];
    1'b1: exeCrtL2[0:29] <= ExeCrt_Mux;
    default: exeCrtL2[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_WbIar' 
always @(posedge CB)
  casez(wbIarE1 & wbIarE2)
    1'b0: wbIarL2[0:29] <= wbIarL2[0:29];
    1'b1: wbIarL2[0:29] <= exeIarSel[0:29];
    default: wbIarL2[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_ExeIar' 
always @(posedge CB)
  casez(dcdFullL2 & exeIarE2)
    1'b0: exeIarL2_int[0:29] <= exeIarL2_int[0:29];
    1'b1: exeIarL2_int[0:29] <= dcdIarL2[0:29];
    default: exeIarL2_int[0:29] <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_DcdIar' 
reg [0:29] DcdIar_Mux;
always @(pfb0IarL2 or lcarForPipe or lcarP4Buf or dcdIarMuxSel)
  casez(dcdIarMuxSel[0:1])
    2'b00: DcdIar_Mux = pfb0IarL2[0:29];
    2'b01: DcdIar_Mux = lcarForPipe[0:29];
    2'b10: DcdIar_Mux = lcarP4Buf[0:29];
    2'b11: DcdIar_Mux = 30'b0;
    default: DcdIar_Mux = 30'bx;
  endcase
always @(posedge CB)
  casez(dcdE1 & dcdE2)
    1'b0: dcdIarL2 <= dcdIarL2;
    1'b1: dcdIarL2 <= DcdIar_Mux;
    default: dcdIarL2 <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_Pfb0Iar' 
reg [0:29] Pfb0Iar_Mux;
always @(pfb1IarL2 or lcarForPipe or lcarP4Buf or pfb0IarMuxSel)
  casez(pfb0IarMuxSel[0:1])
    2'b00: Pfb0Iar_Mux = pfb1IarL2[0:29];
    2'b01: Pfb0Iar_Mux = lcarForPipe[0:29];
    2'b10: Pfb0Iar_Mux = lcarP4Buf[0:29];
    2'b11: Pfb0Iar_Mux = 30'b0;
    default: Pfb0Iar_Mux = 30'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb0E2)
    1'b0: pfb0IarL2 <= pfb0IarL2;
    1'b1: pfb0IarL2 <= Pfb0Iar_Mux;
    default: pfb0IarL2 <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_Pfb1Iar' 
reg [0:29] Pfb1Iar_Mux;
always @(lcarForPipe or lcarP4Buf or pfb1IarMuxSel)
  casez(pfb1IarMuxSel)
    1'b0: Pfb1Iar_Mux = lcarForPipe[0:29];
    1'b1: Pfb1Iar_Mux = lcarP4Buf[0:29];
    default: Pfb1Iar_Mux = 30'bx;
  endcase
always @(posedge CB)
  casez(pfb0E1 & pfb1E2)
    1'b0: pfb1IarL2 <= pfb1IarL2;
    1'b1: pfb1IarL2 <= Pfb1Iar_Mux;
    default: pfb1IarL2 <= 30'bx;
  endcase

//Removed the module 'dp_muxIFB_048' 
reg [0:31] muxIFB_048;
assign {mux048[0:29], NL, NP} = muxIFB_048;
always @(lcarForInc or nlP0 or npP0 or lcarP4 or nlP4 or npP4 or lcarP8 or 
            lcar_29_int or nlP8 or npP8 or mux048Sel)
  case(mux048Sel[0:1])
    2'b00: muxIFB_048 = {lcarForInc[0:29], nlP0, npP0};
    2'b01: muxIFB_048 = {lcarP4[0:29], nlP4, npP4};
    2'b10: muxIFB_048 = {lcarP8[0:28], lcar_29_int, nlP8, npP8};
    2'b11: muxIFB_048 = 32'b0;
    default: muxIFB_048 = 32'bx;
  endcase

endmodule
