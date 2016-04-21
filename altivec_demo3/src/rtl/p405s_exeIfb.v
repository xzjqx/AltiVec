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

module p405s_exeIfb( 
     exe2Cr0EnL2, exeBL2, exeBcL2, exeCr0EnL2, exeCrAndL2, exeCrBfEnL2, exeCrNegBBL2,
     exeCrNegBTL2, exeCrOrL2, exeCrUpdateL2, exeCrXorL2, exeCtrUpForBcctrL2,
     exeDataBrBIL2, exeDataBrBOL2, exeDataBr_5L2, exeDataBr_21L2, exeDataL2,
     exeDataLKL2, exeIsyncL2, exeLrUpdateL2, exeMcrfL2, exeMcrxrL2, exeMfsprL2, exeMtCtrL2,
     exeMtcrfL2, exeMtsprL2, exeOpForExe2L2, exeRfciL2, exeRfiL2, exeScL2, exeStwcxL2,
     exeTlbsxL2, wbIsyncL2, wbMtCtrL2, wbMtLrL2, APU_dcdCrField, APU_dcdRc,
     APU_dcdValidOp_Neg, CB, PCL_exe2DataE1, PCL_exe2DataE2, PCL_exe2FlushorClear,
     dcdCrUpdate, dcdCtrUpForBcctr, dcdDataL2, dcdDataLK, dcdLrUpdate, dcdMtCtr, dcdPlaB,
     dcdPlaBc, dcdPlaCr0En, dcdPlaCrAnd, dcdPlaCrBfEn, dcdPlaCrNegBB, dcdPlaCrNegBT,
     dcdPlaCrOr, dcdPlaCrXor, dcdPlaExe2Op, dcdPlaIsync, dcdPlaMcrf, dcdPlaMcrxr, dcdPlaMfspr,
     dcdPlaMtcrf, dcdPlaMtspr, dcdPlaRfci, dcdPlaRfi, dcdPlaSc, dcdPlaStwcx, dcdPlaTlbsx,
     exeDataE1, exeDataE2, exeDataSel, exeFlushorClear, exeMtCtr, exeMtLr,  wbDataE1,
     wbDataE2, wbFlushOrClear
);

output  exe2Cr0EnL2, exeBL2, exeBcL2, exeCr0EnL2, exeCrAndL2, exeCrBfEnL2, exeCrNegBBL2,
     exeCrNegBTL2, exeCrOrL2, exeCrUpdateL2, exeCrXorL2, exeCtrUpForBcctrL2, exeDataBr_5L2,
     exeDataBr_21L2, exeDataLKL2, exeIsyncL2, exeLrUpdateL2, exeMcrfL2, exeMcrxrL2, exeMfsprL2,
     exeMtCtrL2, exeMtcrfL2, exeMtsprL2, exeOpForExe2L2, exeRfciL2, exeRfiL2, exeScL2,
     exeStwcxL2, exeTlbsxL2,  wbIsyncL2, wbMtCtrL2, wbMtLrL2;


input  APU_dcdRc, APU_dcdValidOp_Neg, PCL_exe2DataE1, PCL_exe2DataE2, PCL_exe2FlushorClear,
     dcdCrUpdate, dcdCtrUpForBcctr, dcdDataLK, dcdLrUpdate, dcdMtCtr, dcdPlaB, dcdPlaBc,
     dcdPlaCr0En, dcdPlaCrAnd, dcdPlaCrBfEn, dcdPlaCrNegBB, dcdPlaCrNegBT, dcdPlaCrOr,
     dcdPlaCrXor, dcdPlaExe2Op, dcdPlaIsync, dcdPlaMcrf, dcdPlaMcrxr, dcdPlaMfspr, dcdPlaMtcrf,
     dcdPlaMtspr, dcdPlaRfci, dcdPlaRfi, dcdPlaSc, dcdPlaStwcx, dcdPlaTlbsx, exeDataE1,
     exeDataE2, exeDataSel, exeFlushorClear, exeMtCtr, exeMtLr,  wbDataE1, wbDataE2,
     wbFlushOrClear;

output [0:3]  exeDataBrBOL2;
output [0:4]  exeDataBrBIL2;
output [6:20]  exeDataL2;


input   CB;
input [0:2]  APU_dcdCrField;
input [5:21]  dcdDataL2;

//Internal signals
wire [0:10] exeStageC_D0;
reg [0:10] exeStageC_Mux;
reg [0:10] exeStageC_Reg;
reg exe2Stage_Mux;
reg exe2Stage_Reg;
reg [0:2] wbStage_Mux;
reg [0:2] wbStage_Reg;
wire [0:23] exeStage2_D0;
reg [0:23] exeStage2_Mux;
reg [0:23] exeStage2_Reg;
reg [0:11] exeStage1_Mux;
reg [0:11] exeStage1_Reg;
reg [0:4] exeDataCrF_Mux;
reg [0:4] exeDataCrF_Reg;

wire exeCr0EnL2_int;
wire exeIsyncL2_int;

assign exeCr0EnL2 = exeCr0EnL2_int;
assign exeIsyncL2 = exeIsyncL2_int;

//Removed the module 'dp_regIFB_exeStageC'
assign exeStageC_D0 = {dcdDataL2[5:9], dcdDataL2[11:15], dcdDataL2[21]};
assign {exeDataBr_5L2, exeDataBrBOL2[0:3], exeDataBrBIL2[0:4], exeDataBr_21L2} = exeStageC_Reg;
always @(exeStageC_D0 or exeDataSel)
  casez(exeDataSel)
    1'b0: exeStageC_Mux = exeStageC_D0;
    1'b1: exeStageC_Mux = 11'b0;
    default: exeStageC_Mux = 11'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(exeDataE1 & exeDataE2)
    1'b0: exeStageC_Reg <= exeStageC_Reg;
    1'b1: exeStageC_Reg <= exeStageC_Mux;
    default: exeStageC_Reg <= 11'bx;
  endcase

//Removed the module 'dp_regIFB_exe2Stage' 
assign exe2Cr0EnL2 = exe2Stage_Reg;
always @(exeCr0EnL2_int or PCL_exe2FlushorClear)
  casez(PCL_exe2FlushorClear)
    1'b0: exe2Stage_Mux = exeCr0EnL2_int;
    1'b1: exe2Stage_Mux = 1'b0;
    default: exe2Stage_Mux = 1'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(PCL_exe2DataE1 & PCL_exe2DataE2)
    1'b0: exe2Stage_Reg <= exe2Stage_Reg;
    1'b1: exe2Stage_Reg <= exe2Stage_Mux;
    default: exe2Stage_Reg <= 1'bx;
  endcase

//Removed the module 'dp_regIFB_wbStage' 
assign {wbIsyncL2, wbMtCtrL2, wbMtLrL2} = wbStage_Reg;
always @(exeIsyncL2_int or exeMtCtr or exeMtLr or wbFlushOrClear)
  casez(wbFlushOrClear)
    1'b0: wbStage_Mux = {exeIsyncL2_int, exeMtCtr, exeMtLr};
    1'b1: wbStage_Mux = 3'b0;
    default: wbStage_Mux = 3'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(wbDataE1 & wbDataE2)
    1'b0: wbStage_Reg <= wbStage_Reg;
    1'b1: wbStage_Reg <= wbStage_Mux;
    default: wbStage_Reg <= 3'bx;
  endcase

//Removed the module 'dp_regIFB_exeStage2' 
assign exeStage2_D0 = {dcdDataLK, dcdPlaB, dcdPlaBc, dcdMtCtr,
     dcdPlaCr0En, dcdPlaMtspr, dcdPlaMfspr, dcdPlaCrAnd, dcdPlaCrNegBB, dcdPlaCrNegBT,
     dcdPlaCrOr, dcdPlaCrXor, dcdPlaMcrf, dcdPlaMcrxr, dcdPlaMtcrf, dcdPlaStwcx, dcdPlaTlbsx,
     dcdPlaRfci, dcdPlaRfi, dcdPlaSc, dcdPlaIsync, dcdPlaExe2Op, dcdLrUpdate, 
     dcdCtrUpForBcctr}; 
assign {exeDataLKL2, exeBL2,
     exeBcL2, exeMtCtrL2, exeCr0EnL2_int, exeMtsprL2, exeMfsprL2, exeCrAndL2, exeCrNegBBL2,
     exeCrNegBTL2, exeCrOrL2, exeCrXorL2, exeMcrfL2, exeMcrxrL2, exeMtcrfL2, exeStwcxL2,
     exeTlbsxL2, exeRfciL2, exeRfiL2, exeScL2, exeIsyncL2_int, exeOpForExe2L2, exeLrUpdateL2,
     exeCtrUpForBcctrL2} = exeStage2_Reg;
always @(exeStage2_D0 or exeDataSel)
  casez(exeDataSel)
    1'b0: exeStage2_Mux = exeStage2_D0;
    1'b1: exeStage2_Mux = 24'b0;
    default: exeStage2_Mux = 24'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(exeDataE1 & exeDataE2)
    1'b0: exeStage2_Reg <= exeStage2_Reg;
    1'b1: exeStage2_Reg <= exeStage2_Mux;
    default: exeStage2_Reg <= 24'bx;
  endcase

//Removed the module 'dp_regIFB_exeStage1' 
assign exeDataL2[9:20] = exeStage1_Reg;
always @(dcdDataL2 or exeDataSel)
  casez(exeDataSel)
    1'b0: exeStage1_Mux = dcdDataL2[9:20];
    1'b1: exeStage1_Mux = 12'b0;
    default: exeStage1_Mux = 12'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(exeDataE1 & exeDataE2)
    1'b0: exeStage1_Reg <= exeStage1_Reg;
    1'b1: exeStage1_Reg <= exeStage1_Mux;
    default: exeStage1_Reg <= 12'bx;
  endcase

//Removed the module 'dp_regIFB_exeDataCrF' 
assign {exeDataL2[6:8], exeCrBfEnL2, exeCrUpdateL2} = exeDataCrF_Reg;
always @(APU_dcdCrField or APU_dcdRc or dcdDataL2 or dcdPlaCrBfEn 
           or dcdCrUpdate or exeFlushorClear or APU_dcdValidOp_Neg)
  casez({exeFlushorClear, APU_dcdValidOp_Neg})
    2'b00: exeDataCrF_Mux = {APU_dcdCrField[0:2], APU_dcdRc, APU_dcdRc};
    2'b01: exeDataCrF_Mux = {dcdDataL2[6:8], dcdPlaCrBfEn, dcdCrUpdate};
    2'b10: exeDataCrF_Mux = 5'b0;
    2'b11: exeDataCrF_Mux = 5'b0;
    default: exeDataCrF_Mux = 5'bx;
  endcase
// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(exeDataE1 & exeDataE2)
    1'b0: exeDataCrF_Reg <= exeDataCrF_Reg;
    1'b1: exeDataCrF_Reg <= exeDataCrF_Mux;
    default: exeDataCrF_Reg <= 5'bx;
  endcase

endmodule
