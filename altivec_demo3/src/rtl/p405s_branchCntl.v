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

module p405s_branchCntl( IFB_exeCorrect, IFB_exeDbgBrTaken, branchTarCrt, dcdCorrect_Neg,
     dcdCrtBpntLrCtr, dcdCrtE2, dcdCrtMuxSel, dcdTarget_Neg, exeBrAndLink, exeCorrect_Neg,
     exeCrtBpntLrCtr, exeCrtE2, exeCrtMuxSel, pfb0Target_Neg, CB,
     PCL_dcdHoldForIFB, PCL_exeIarHold, crL2, ctrEq1L2, ctrEq2L2, dcdClear, dcdDataBD_0,
     dcdDataBI, dcdDataBO, dcdDataL2, dcdDataLK, dcdFlush, dcdFullL2, dcdPlaB,
     dcdPlaBc, dcdPlaMtspr, dcdPriOp_5, dcdSecOp_0, exe2Cr0EnL2, exeBL2, exeBcL2,
     exeCrUpdateL2, exeCtrUpForBcctrL2, exeDataBrBIL2, exeDataBrBOL2, exeDataBr_5L2,
     exeDataLKL2, exeFullL2, exeLrUpdateL2, exeMtCtrL2, pfb0DataBD_0, pfb0DataBO_0,
     pfb0DataBO_2, pfb0DataBO_4, pfb0FullL2, pfb0PlaB, pfb0PlaBc, pfb0PriOp_5, pfb0SecOp_0,
     tracePipeHold );
output  IFB_exeCorrect, IFB_exeDbgBrTaken, branchTarCrt, dcdCorrect_Neg, dcdCrtBpntLrCtr,
     dcdCrtE2, dcdCrtMuxSel, dcdTarget_Neg, exeBrAndLink, exeCorrect_Neg, exeCrtBpntLrCtr,
     exeCrtE2, pfb0Target_Neg;


input  PCL_dcdHoldForIFB, PCL_exeIarHold, ctrEq1L2, ctrEq2L2, dcdClear, dcdDataBD_0, dcdDataLK,
     dcdFlush, dcdFullL2, dcdPlaB, dcdPlaBc, dcdPlaMtspr, dcdPriOp_5, dcdSecOp_0, exe2Cr0EnL2,
     exeBL2, exeBcL2, exeCrUpdateL2, exeCtrUpForBcctrL2, exeDataBr_5L2, exeDataLKL2, exeFullL2,
     exeLrUpdateL2, exeMtCtrL2, pfb0DataBD_0, pfb0DataBO_0, pfb0DataBO_2, pfb0DataBO_4,
     pfb0FullL2, pfb0PlaB, pfb0PlaBc, pfb0PriOp_5, pfb0SecOp_0, tracePipeHold;

output [0:1]  exeCrtMuxSel;


input [0:4]  exeDataBrBIL2;
input [0:31]  crL2;
input [0:4]  dcdDataBI;
input [0:3]  exeDataBrBOL2;
input        CB;
input [11:20]  dcdDataL2;
input [0:4]  dcdDataBO;


//internal signals
reg [0:4] branchCntl_Reg;
reg [0:5] brFirstCycle_Reg;
wire      dcdPfb0BranchL2, dcdPfb0BcL2, dcdPfb0PredictionL2, exeDcdPredictL2; 
wire      exeDcdPrediction_NegL2;
wire      dcdHold_Neg, pfb0Branch, pfb0Bc, nxtDcdPfb0Prediction, nxtExeDcdPredict; 
wire      nxtExeDcdPrediction_Neg;
wire      dcdPredictionHoldingL2, pfb0PredictionHoldingL2, pfb0FirstCycleL2, dcdFirstCycleL2; 
wire      exeFirstCycleL2, dcdPredictHoldingL2;
wire      dcdPredictionHolding, pfb0PredictionHolding, nxtPfb0FirstCycle, nxtDcdFirstCycle; 
wire      nxtExeFirstCycle, dcdPredictHolding;
wire      dcdTarget_Neg_int;
wire      exeCondOK_Neg, dcdCondOK, dcdCtrEq0, dcdPredict, dcdPrediction;

assign dcdTarget_Neg = dcdTarget_Neg_int;

//Removed the module 'dp_regIFB_branchCntl' 
assign {dcdPfb0BranchL2, dcdPfb0BcL2, dcdPfb0PredictionL2, exeDcdPredictL2, 
          exeDcdPrediction_NegL2} = branchCntl_Reg;
always @(posedge CB)
  casez(dcdHold_Neg)
    1'b0: branchCntl_Reg <= branchCntl_Reg;
    1'b1: branchCntl_Reg <= {pfb0Branch, pfb0Bc, nxtDcdPfb0Prediction, nxtExeDcdPredict, 
                               nxtExeDcdPrediction_Neg};
    default: branchCntl_Reg <= 5'bx;
  endcase

//Removed the module 'dp_regIFB_brFirstCycle' 
assign {dcdPredictionHoldingL2, pfb0PredictionHoldingL2, pfb0FirstCycleL2, 
         dcdFirstCycleL2, exeFirstCycleL2, dcdPredictHoldingL2 } = brFirstCycle_Reg;
always @(posedge CB)
  brFirstCycle_Reg <= {dcdPredictionHolding, pfb0PredictionHolding, nxtPfb0FirstCycle, 
                       nxtDcdFirstCycle, nxtExeFirstCycle, dcdPredictHolding };

p405s_exeBrCondFlow
 exeBrCondFlowFunc( 
  .exeCondOK_Neg(exeCondOK_Neg),
  .crL2(crL2[0:31]), 
  .exeBIL2(exeDataBrBIL2),
  .exeBOL2(exeDataBrBOL2), 
  .exeCtrEq0(ctrEq1L2)
);

p405s_dcdBrCondFlow
 dcdBrCondFlowFunc( 
  .dcdCondOK(dcdCondOK),
  .dcdTarget_Neg(dcdTarget_Neg_int),
  .crL2(crL2[0:31]),
  .dcdCtrEq0(dcdCtrEq0),
  .dcdDataBI(dcdDataBI[0:4]),
  .dcdDataBO(dcdDataBO[0:3]),
  .dcdFirstCycleL2(dcdFirstCycleL2),
  .dcdFullL2(dcdFullL2),
  .dcdPfb0BranchL2(dcdPfb0BranchL2),
  .dcdPlaB(dcdPlaB),
  .dcdPlaBc(dcdPlaBc),
  .dcdPredict(dcdPredict),
  .dcdPrediction(dcdPrediction)
);

p405s_brEquations
 brEquationFunc(
  .pfb0Branch(pfb0Branch),
  .nxtPfb0FirstCycle(nxtPfb0FirstCycle),
  .pfb0Bc(pfb0Bc),
  .pfb0Target_Neg(pfb0Target_Neg),
  .pfb0PredictionHolding(pfb0PredictionHolding),
  .nxtDcdPfb0Prediction(nxtDcdPfb0Prediction),
  .dcdPredict(dcdPredict),
  .dcdPrediction(dcdPrediction),
  .nxtExeDcdPrediction_Neg(nxtExeDcdPrediction_Neg),
  .dcdCorrect_Neg(dcdCorrect_Neg),
  .dcdCtrEq0(dcdCtrEq0),
  .nxtDcdFirstCycle(nxtDcdFirstCycle),
  .dcdHold_Neg(dcdHold_Neg),
  .dcdPredictHolding(dcdPredictHolding),
  .nxtExeDcdPredict(nxtExeDcdPredict),
  .dcdPredictionHolding(dcdPredictionHolding),
  .exeCorrect(IFB_exeCorrect),
  .exeCorrect_Neg(exeCorrect_Neg),
  .exeBrAndLink(exeBrAndLink),
  .nxtExeFirstCycle(nxtExeFirstCycle),
  .exeCrtBpntLrCtr(exeCrtBpntLrCtr),
  .branchTarCrt(branchTarCrt),
  .IFB_exeDbgBrTaken(IFB_exeDbgBrTaken),
  .dcdCrtE2(dcdCrtE2),
  .dcdCrtMuxSel(dcdCrtMuxSel),
  .exeCrtE2(exeCrtE2),
  .exeCrtMuxSel(exeCrtMuxSel[0:1]),
  .pfb0PlaB(pfb0PlaB),
  .pfb0PlaBc(pfb0PlaBc),
  .pfb0PriOp_5(pfb0PriOp_5),
  .pfb0SecOp_0(pfb0SecOp_0),
  .pfb0DataBO_0(pfb0DataBO_0),
  .pfb0DataBO_2(pfb0DataBO_2),
  .pfb0DataBO_4(pfb0DataBO_4),
  .pfb0DataBD_0(pfb0DataBD_0),
  .pfb0FullL2(pfb0FullL2),
  .pfb0FirstCycleL2(pfb0FirstCycleL2),
  .pfb0PredictionHoldingL2(pfb0PredictionHoldingL2),
  .dcdPlaB(dcdPlaB),
  .dcdPlaBc(dcdPlaBc),
  .dcdPlaMtspr(dcdPlaMtspr),
  .dcdDataBO_0(dcdDataBO[0]),
  .dcdDataBO_2(dcdDataBO[2]),
  .dcdDataBO_4(dcdDataBO[4]),
  .dcdDataBD_0(dcdDataBD_0),
  .dcdDataL2(dcdDataL2[11:20]),
  .dcdPriOp_5(dcdPriOp_5),
  .dcdSecOp_0(dcdSecOp_0),
  .dcdDataLK(dcdDataLK),
  .dcdPfb0PredictionL2(dcdPfb0PredictionL2),
  .dcdPfb0BranchL2(dcdPfb0BranchL2),
  .dcdPfb0BcL2(dcdPfb0BcL2),
  .dcdCrtBpntLrCtr(dcdCrtBpntLrCtr),
  .dcdCondOK(dcdCondOK),
  .dcdTarget_Neg(dcdTarget_Neg_int),
  .dcdFullL2(dcdFullL2),
  .dcdFirstCycleL2(dcdFirstCycleL2),
  .dcdClear(dcdClear),
  .dcdFlush(dcdFlush),
  .dcdPredictHoldingL2(dcdPredictHoldingL2),
  .dcdPredictionHoldingL2(dcdPredictionHoldingL2),
  .exeBL2(exeBL2),
  .exeBcL2(exeBcL2),
  .exeMtCtrL2(exeMtCtrL2),
  .exeDataBO_2(exeDataBrBOL2[2]),
  .exeDataLKL2(exeDataLKL2),
  .exeFullL2(exeFullL2),
  .exeFirstCycleL2(exeFirstCycleL2),
  .exeDcdPredictL2(exeDcdPredictL2),
  .exeDcdPrediction_NegL2(exeDcdPrediction_NegL2),
  .exeCondOK_Neg(exeCondOK_Neg),
  .exe2Cr0EnL2(exe2Cr0EnL2),
  .exeCrUpdateL2(exeCrUpdateL2),
  .exeCtrUpForBcctrL2(exeCtrUpForBcctrL2),
  .exeLrUpdateL2(exeLrUpdateL2),
  .exeDataBr_5L2(exeDataBr_5L2),
  .ctrEq1L2(ctrEq1L2),
  .ctrEq2L2(ctrEq2L2),
  .PCL_dcdHoldForIFB(PCL_dcdHoldForIFB),
  .PCL_exeIarHold(PCL_exeIarHold),
  .tracePipeHold(tracePipeHold)
);

endmodule
