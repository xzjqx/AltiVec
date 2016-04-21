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
// Verilog HDL for "PR_ifb", "brEquations" "_functional"

/////////////////////////////////////////
// Please generate symbol automatically//
/////////////////////////////////////////

module p405s_brEquations (
  pfb0Branch,
  nxtPfb0FirstCycle,
  pfb0Bc,
  pfb0Target_Neg,
  pfb0PredictionHolding,
  nxtDcdPfb0Prediction,
  dcdPredict,
  dcdPrediction,
  nxtExeDcdPrediction_Neg,
  dcdCorrect_Neg,
  dcdCtrEq0,
  nxtDcdFirstCycle,
  dcdHold_Neg,
  dcdPredictHolding,
  nxtExeDcdPredict,
  dcdPredictionHolding,
  exeCorrect,
  exeCorrect_Neg,
  exeBrAndLink,
  nxtExeFirstCycle,
  exeCrtBpntLrCtr,
  branchTarCrt,
  IFB_exeDbgBrTaken,
  dcdCrtE2,
  dcdCrtMuxSel,
  exeCrtE2,
  exeCrtMuxSel,
  pfb0PlaB,
  pfb0PlaBc,
  pfb0PriOp_5,
  pfb0SecOp_0,
  pfb0DataBO_0,
  pfb0DataBO_2,
  pfb0DataBO_4,
  pfb0DataBD_0,
  pfb0FullL2,
  pfb0FirstCycleL2,
  pfb0PredictionHoldingL2,
  dcdPlaB,
  dcdPlaBc,
  dcdPlaMtspr,
  dcdDataBO_0,
  dcdDataBO_2,
  dcdDataBO_4,
  dcdDataBD_0,
  dcdDataL2,
  dcdPriOp_5,
  dcdSecOp_0,
  dcdDataLK,
  dcdPfb0PredictionL2,
  dcdPfb0BranchL2,
  dcdPfb0BcL2,
  dcdCrtBpntLrCtr,
  dcdCondOK,
  dcdTarget_Neg,
  dcdFullL2,
  dcdFirstCycleL2,
  dcdClear,
  dcdFlush,
  dcdPredictHoldingL2,
  dcdPredictionHoldingL2,
  exeBL2,
  exeBcL2,
  exeMtCtrL2,
  exeDataBO_2,
  exeDataLKL2,
  exeFullL2,
  exeFirstCycleL2,
  exeDcdPredictL2,
  exeDcdPrediction_NegL2,
  exeCondOK_Neg,
  exe2Cr0EnL2,
  exeCrUpdateL2,
  exeCtrUpForBcctrL2,
  exeLrUpdateL2,
  exeDataBr_5L2,
  ctrEq1L2,
  ctrEq2L2,
  PCL_dcdHoldForIFB,
  PCL_exeIarHold,
  tracePipeHold
);

output          pfb0Branch, nxtPfb0FirstCycle, pfb0Bc, pfb0Target_Neg,
                pfb0PredictionHolding, nxtDcdPfb0Prediction;

output          dcdPredict, dcdPrediction, nxtExeDcdPrediction_Neg,
                dcdCorrect_Neg, dcdCtrEq0, nxtDcdFirstCycle, dcdHold_Neg,
                dcdCrtBpntLrCtr, dcdPredictHolding, nxtExeDcdPredict,
                dcdPredictionHolding;

output          exeCorrect, exeCorrect_Neg, exeBrAndLink, nxtExeFirstCycle;
output          exeCrtBpntLrCtr;
output  [0:1]   exeCrtMuxSel;

output          branchTarCrt;
output          IFB_exeDbgBrTaken;

output          dcdCrtE2, dcdCrtMuxSel, exeCrtE2;

input           pfb0PlaB, pfb0PlaBc;
input           pfb0PriOp_5, pfb0SecOp_0;
input           pfb0DataBO_0, pfb0DataBO_2, pfb0DataBO_4;
input           pfb0DataBD_0, pfb0FullL2, pfb0FirstCycleL2;
input           pfb0PredictionHoldingL2;

input           dcdPlaB, dcdPlaBc, dcdPlaMtspr;
input   [11:20] dcdDataL2;
input           dcdPriOp_5, dcdSecOp_0, dcdDataLK;
input           dcdDataBO_0, dcdDataBO_2, dcdDataBO_4, dcdDataBD_0;
input           dcdPfb0PredictionL2, dcdPfb0BranchL2;
input           dcdPfb0BcL2;
input           dcdCondOK, dcdTarget_Neg, dcdFullL2, dcdFirstCycleL2;
input           dcdClear, dcdFlush, dcdPredictHoldingL2;
input           dcdPredictionHoldingL2;

input           exeBL2, exeBcL2;
input           exeMtCtrL2;
input           exeDataBO_2;
input           exeDataLKL2;
input           exeDcdPredictL2, exeDcdPrediction_NegL2, exeCondOK_Neg;
input           exeFirstCycleL2, exeFullL2, exeDataBr_5L2;
input           exe2Cr0EnL2, exeCrUpdateL2, exeCtrUpForBcctrL2, exeLrUpdateL2;

input           ctrEq1L2, ctrEq2L2, PCL_dcdHoldForIFB, PCL_exeIarHold;
input           tracePipeHold;

reg             dcdCtrEq0;

wire            pfb0Prediction, pfb0PredictionQ;

wire            dcdPredictionQ, dcdPredictQ;
wire            dcdCtrUpForBcctr, dcdLrUpdate;
wire    [0:9]   dcdDataSprn;


wire        pfb0Target_Neg_int;
wire        nxtDcdPfb0Prediction_int;
wire        dcdPredict_int;
wire        dcdPrediction_int;
wire        dcdCorrect_Neg_int;
wire        exeCorrect_Neg_int;

assign pfb0Target_Neg =  pfb0Target_Neg_int;
assign nxtDcdPfb0Prediction =  nxtDcdPfb0Prediction_int;
assign dcdPredict =  dcdPredict_int;
assign dcdPrediction =  dcdPrediction_int;
assign dcdCorrect_Neg =  dcdCorrect_Neg_int;
assign exeCorrect_Neg =  exeCorrect_Neg_int;


// Change History:
// 09/15/98 JD/SP  Rewrote IFB_exeDbgBrTaken. Removed the exeIarHold and exeFlush terms.
//                 Those terms are included in debug logic.

// Rename signals for ease of debug
assign dcdDataSprn[0:9] = {dcdDataL2[16:20],dcdDataL2[11:15]};

// dcdBubble not included because all cases of IFB dcdBubble will cause a flush.
// This may cause unnecessay target and corrects to send aborts to the cache.
//    Do we want to do this???
assign dcdHold_Neg = ~(PCL_dcdHoldForIFB | tracePipeHold);

// First cycle if not full and holding.
assign nxtPfb0FirstCycle = ~(pfb0FullL2 & (PCL_dcdHoldForIFB | tracePipeHold));
assign nxtDcdFirstCycle = ~(dcdFullL2 & (PCL_dcdHoldForIFB | tracePipeHold));
assign nxtExeFirstCycle = ~(exeFullL2 & PCL_exeIarHold);

// Signal indicates that there is a branch is pfb0
// If dcd is flushing or clearing the instruction in pfb0 is being dicarded
assign pfb0Branch = (pfb0PlaB | pfb0PlaBc) & pfb0FullL2 & ~dcdFlush & ~dcdClear;

// Signal indicates that there is a branch conditional in pfb0
// Since all conditiona branches in pfb0 predict this is used as pfb0Predict.
assign pfb0Bc = pfb0PlaBc & pfb0FullL2 & ~dcdFlush & ~dcdClear;

// This is the value of branch prediction. Terms are defined as follows:
// Is the branch dependent cr or ctr, if not then predict taken (unconditional)
// Static predition as defined in PowerPc architecture.
// All terms qualified by bc and full when used. If the branch is to link
// or count and link or count are being updated the branch is predicted not
// taken.
// pfb0Predict will be qualified with pfb0Full and pfb0Bc. Because of this we
// only need 2 bits to determine if a branch is a bclr or bcctr.
assign pfb0Prediction =
 ((pfb0DataBO_0 & pfb0DataBO_2) | (pfb0DataBD_0 ^ pfb0DataBO_4)) &
  ~((pfb0PriOp_5 & ~pfb0SecOp_0 & (dcdLrUpdate | exeLrUpdateL2)) |      //bclr
  (pfb0PriOp_5 & pfb0SecOp_0 & (dcdCtrUpForBcctr | exeCtrUpForBcctrL2)));//bcctr

assign pfb0PredictionQ = pfb0Prediction & pfb0PlaBc & pfb0FullL2;
assign pfb0Target_Neg_int = ~(((pfb0PlaB & pfb0FullL2) | pfb0PredictionQ) &
                            pfb0FirstCycleL2);

// Issue 198
// If dcd holds while exe moves a dependency that initially caused the
//    direction of pfb0Prediction to change. The value of the pfb0FirstCycleL2
//    prediction is saved and passed to the dcd stage when the pipeline moves.
//    This problem has only been found to exist with an APU ops and CTR and
//    LR updates.
//assign pfb0PredictionHolding = ((pfb0PredictionQ & pfb0FirstCycleL2) |
//                                pfb0PredictionHoldingL2) &
//                             ((PCL_dcdHoldForIFB | tracePipeHold) & ~dcdFlush);
//assign nxtDcdPfb0Prediction = pfb0FirstCycleL2 & pfb0PredictionQ |
//                              ~pfb0FirstCycleL2 & pfb0PredictionHoldingL2;

//Issue 207: There was a bug in Prowler that came as a result of the changes 
// made for Issue 198 above.  The changes made are above.  The problem is a 
// branch not taken with the 198 fix.  The new fix is below:
//

//ignoring leda warning B_1013: nxtDcdPfb0Prediction_int drives multiple ports
assign pfb0PredictionHolding = nxtDcdPfb0Prediction_int;

assign nxtDcdPfb0Prediction_int = pfb0FirstCycleL2 & pfb0PredictionQ |
                              ~pfb0FirstCycleL2 & pfb0PredictionHoldingL2;



// Controls to dcdCorrect register. If predicting if pfb0 then must load
// correct register. Mux select does not need to be qualified with Bc and full
// because the E2 is. Branch conditional in pfb0 always predicts.
assign dcdCrtE2 = pfb0PlaBc & pfb0FullL2 & pfb0FirstCycleL2;
// 0 - nsi
// 1 - pfb0 target
assign dcdCrtMuxSel = ~pfb0Prediction;

////////////////////////////////////////////////////////////
// This signal determines if any of conditions that a branch is dependent on
// are unresolved so that the branch can not be determined and prediction
// must be used. The following conditions are checked as follows:
// Branch dependent on cr and cr being updated in exe stage.
// Branch dependent on ctr and ctr being updated in exe stage.
// Branch conditional to link and link being updated in exe stage.
//   this condition will be predicted not taken.
// Branch conditional to ctr and ctr being updated in exe stage.
//   this condition will be predicted not taken.
// All terms are qualified by the full bit and Bc when used
// If predicting in dcd then must have predicted in pfb0 if branch was there.
// If branch was predicted in pfb0 the target is blocked in brCondFlow.
// Branch determination can handle multiple branch and decrements in pipe.
// dcdPredict will be qualified with dcdFull and dcdBc. Because of this we only
// need 2 bits to determine if a branch is a bclr or bcctr.
assign dcdPredict_int =
    (~dcdDataBO_0 & (exeCrUpdateL2 | exe2Cr0EnL2)) |
    (~dcdDataBO_2 & exeMtCtrL2) |
    (dcdPriOp_5 & ~dcdSecOp_0 & exeLrUpdateL2) |     //bclr
    (dcdPriOp_5 & dcdSecOp_0 & exeCtrUpForBcctrL2);  //bcctr

assign dcdPredictQ = dcdPredict_int & dcdPlaBc & dcdFullL2;

// Issue 183
// If dcd holds while exe moves a dependency that initially caused dcd to
//    predict can go away. Anytime dcdHolds save the value of predict from
//    the first cycle and send it to exe when the pipe moves.
assign dcdPredictHolding = ((dcdPredictQ & dcdFirstCycleL2) |
                             dcdPredictHoldingL2) &
                           ((PCL_dcdHoldForIFB | tracePipeHold) & ~dcdFlush);

assign nxtExeDcdPredict = dcdFirstCycleL2 & dcdPredictQ |
                          ~dcdFirstCycleL2 & dcdPredictHoldingL2;

// This is the value of branch prediction. Terms are defined as follows:
// Is the branch dependent cr or ctr, if not then predict taken (unconditional)
// Static predition as defined in PowerPc architecture.
// All terms qualified by bc and full when used. If the branch is to link
// or count and link or count are being updated the branch is predicted
// not taken.
// dcdPrediction will be qualified with dcdFull and dcdBc. Because of this we
// only need 2 bits to determine if a branch is a bclr or bcctr.
assign dcdPrediction_int =
    ((dcdDataBO_0 & dcdDataBO_2) | (dcdDataBD_0 ^ dcdDataBO_4)) &
    ~((dcdPriOp_5 & ~dcdSecOp_0 & exeLrUpdateL2) |        //bclr
      (dcdPriOp_5 & dcdSecOp_0 & exeCtrUpForBcctrL2));    //bcctr


assign dcdPredictionQ = (dcdPrediction_int & dcdPlaBc & dcdFullL2);

// Issue 198
// If dcd holds while exe moves a dependency that initially caused the
//    direction of dcdPrediction to change. The value of the dcdFirstCycleL2
//    prediction is saved and passed to exe stage when the pipeline moves.
//  Fixing this equation is a
//  safety measure. This is the second bug associated with not fully
//  understanding our Hold equations. Since Holds are generated in the PCL it
//  is best to protect against any still unforseen hold condition. This fix
//  is not directly associated with the problem found in Issue 198.

assign dcdPredictionHolding = ((dcdPredictionQ & dcdFirstCycleL2) |
                                dcdPredictionHoldingL2) &
                              ((PCL_dcdHoldForIFB | tracePipeHold) & ~dcdFlush);

// New term to fix branch to ctr and branch to lr changing prediction
//   from pfb0 to dcd with standard predition is reversed. If exe has
//   a ctr or lr update then branch prediction is forced to zero. When
//   branch moves to dcd with predition reversed prediction changes to 1.
//   All other branches cannot change prediction between pfb0 and dcd.
//   This equation always looks to see if the branch was in pfb0 and then
//   always uses the same prediction that was used in pfb0 when in dcd, to
//   set the exe stage bit used for determining correction, indicating
//   the direction of the branch was predicted.

// Issue 198
// Old Equation:
// assign nxtExeDcdPrediction_Neg = ~( (dcdPfb0BcL2 & dcdPfb0PredictionL2) |
//                                    (~dcdPfb0BcL2 & dcdPredictionQ) );
// New Equation:
// Add term in case dcdPrediction changes between dcdFirstCycle and
//  subsequent cycles that the instruction holds. Fixing this equation is a
//  safety measure. This is the second bug associated with not fully
//  understanding our Hold equations. Since Holds are generated in the PCL it
//  is best to protect against any still unforseen hold condition. This fix
//  is not directly associated with the problem found in Issue 198.
assign nxtExeDcdPrediction_Neg = ~( (dcdPfb0BcL2 & dcdPfb0PredictionL2) |
                                    (~dcdPfb0BcL2 &
                                     (dcdFirstCycleL2 & dcdPredictionQ |
                                     ~dcdFirstCycleL2 & dcdPredictionHoldingL2))
                                  );


// Signal determines if the branch is being corrected in dcd. A branch
// predicted in pfb0 and the predicted direction is different than the dcd
// direction as indicated by dcdCondOK then correct. The pfb0 signals are
// properly qualifed on the input to the latch.
assign dcdCorrect_Neg_int = ~(dcdPfb0BcL2 & ~dcdPredict_int & dcdFirstCycleL2 &
                          dcdFullL2 & (dcdPfb0PredictionL2 ^ dcdCondOK));

// Mux sel for branch correction. If a branch to link or count is predicted
// not taken the correction comes from the link or count. Otherwise correction
// comes from the dcdCrtL2.
assign dcdCrtBpntLrCtr = ~dcdPfb0PredictionL2 & dcdPriOp_5;

// Used for pfb0Prediction;
assign dcdCtrUpForBcctr = (dcdPlaMtspr & (dcdDataSprn[0:9] == 10'h009)) |
                          (dcdPlaBc &  ~dcdDataBO_2);
assign dcdLrUpdate = (dcdPlaMtspr & (dcdDataSprn[0:9] == 10'h008)) |
                     ((dcdPlaB | dcdPlaBc) & dcdDataLK);

// exe correct register controls. If predicting in dcd then must load exe
// correct register. If predicted in pfb0 and dcd, will pass value
// of dcd correct register.
// If predicting in dcd then must have predicted in pfb0 if branch was there.
// If dcdPfb0BranchL2 is set then branch was in pfb0. Mux select does not
// need to be qualified with Bc and full because the E1 is.
assign exeCrtE2 = dcdPredict_int & dcdPlaBc & dcdFullL2 & dcdFirstCycleL2;
assign exeCrtMuxSel[0:1] = {dcdPfb0BranchL2,~dcdPrediction_int};

/////////////////////////////////////////
// Only need to correct in exe. We know that all branch conditions are
// known when branch is in exe.
// We know we didn't correct in dcd because exeDcdPredictL2 is set.
assign exeCorrect_Neg_int = ~(exeDcdPredictL2 & exeBcL2 & exeFullL2 &
                   exeFirstCycleL2 & (exeDcdPrediction_NegL2 ^ exeCondOK_Neg));
assign exeCorrect = exeDcdPredictL2 & exeBcL2 & exeFullL2 &
                   exeFirstCycleL2 & (exeDcdPrediction_NegL2 ^ exeCondOK_Neg);

// Mux sel for branch correction. If a branch to link or count is predicted
// not taken the correction comes from the link or count. Otherwise correction
// comes from the exeCrtL2.
assign exeCrtBpntLrCtr = exeDcdPrediction_NegL2 & exeDataBr_5L2;

// Create signal to be used in other logic.
assign exeBrAndLink = (exeBL2 | exeBcL2) & exeDataLKL2;

// Logic to determine if ctr = 0 for a branch. Since ctr check is decrement
// then check compare is to 1. Logic has been included to determine if ctr
// is being decremented by other branchs ahead in pipeline. With multiple
// decrements compare of 2 is necessary.
always @(exeBcL2 or exeDataBO_2 or ctrEq1L2 or ctrEq2L2)
begin
    casez(exeBcL2 & ~exeDataBO_2)
        1'b0: dcdCtrEq0 = ctrEq1L2;
        1'b1: dcdCtrEq0 = ctrEq2L2;
        default: dcdCtrEq0 = 1'bx;
    endcase
end

assign branchTarCrt = ~dcdCorrect_Neg_int | ~exeCorrect_Neg_int |
                      ~pfb0Target_Neg_int | ~dcdTarget_Neg;

assign IFB_exeDbgBrTaken = exeBL2 | (~exeCondOK_Neg & exeBcL2);
endmodule
