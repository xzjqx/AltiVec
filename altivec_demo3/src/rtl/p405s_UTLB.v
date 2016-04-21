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

module p405s_UTLB( UTLB_CacheInhibit,
             UTLB_DSize,
             UTLB_DT,
             UTLB_E,
             UTLB_EPN,
             UTLB_EX,
             UTLB_G,
             UTLB_M,
             UTLB_RPN,
             UTLB_TID,
             UTLB_U0, 
             UTLB_V,
             UTLB_W, 
             UTLB_WR,
             UTLB_ZSEL,
             UTLB_index,
             UTLB_miss,
             dataComp,
             tagComp,
             EN_C1,
             DSize,
             DT,
             EPN_EA,
             EX,
             RPN,
             TID,
             TestM1,
             TestComp,
             WR,
             ZSEL,
             EN_ARRAYL1,
             dataEn,
             indexLookupb,
             rdWrb,
             tagEn,
             tlbCacheInhibit,
             tlbE,
             tlbG,
             tlbM,
             tlbU0,
             tlbV,
             tlbW,
             tlb_invalidate,
             tlbaddr,
             CB,
             tagPar1,
             tagPar2,
             tagPar3,
             tagPar4,
             ramPar1,
             ramPar2,
             UTLB_T1,
             UTLB_T2,
             UTLB_T3,
             UTLB_T4,
             UTLB_R1,
             UTLB_R2,
             DVS
             );

output  UTLB_CacheInhibit;
output  UTLB_DT;
output  UTLB_E;
output  UTLB_EX;
output  UTLB_G;
output  UTLB_M;
output  UTLB_U0;
output  UTLB_V;
output  UTLB_W;
output  UTLB_WR;
output  UTLB_miss;
output  dataComp;
output  tagComp;
output  UTLB_T1;
output  UTLB_T2;
output  UTLB_T3;
output  UTLB_T4;
output  UTLB_R1;
output  UTLB_R2;

input  CB;
input  EN_C1;
input  DT;
input  EX;
input  TestM1;
input  TestComp;
input  WR;
input  EN_ARRAYL1;
input  dataEn;
input  indexLookupb;
input  rdWrb;
input  tagEn;
input  tlbCacheInhibit;
input  tlbE;
input  tlbG;
input  tlbM;
input  tlbU0;
input  tlbV;
input  tlbW;
input  tlb_invalidate;
input  tagPar1;
input  tagPar2;
input  tagPar3;
input  tagPar4;
input  ramPar1;
input  ramPar2;
input  DVS;

output [0:6]   UTLB_DSize;
output [0:3]   UTLB_ZSEL;
output [0:21]  UTLB_RPN;
output [0:5]   UTLB_index;
output [0:7]   UTLB_TID;
output [0:21]  UTLB_EPN;

input [0:21]  EPN_EA;
input [0:7]   TID;
input [0:5]   tlbaddr;
input [0:21]  RPN;
input [0:3]   ZSEL;
input [0:6]   DSize;

// TRI 08/01/01
// Added 6 input and 6 output pins for parity
p405s_mmu_utlb
  TLB( .MISS(UTLB_miss), .DO_E(UTLB_E), .DT_OUT(UTLB_DT), .DI_K(tlbU0), .DI_E(tlbE),
     .INVAL(tlb_invalidate), .DATA_EN(dataEn), .TAG_EN(tagEn), .RD_WRB(rdWrb),
     .INDEX_LOOKUPB(indexLookupb), .DI_G(tlbG), .DI_M(tlbM), .DI_I(tlbCacheInhibit), .DI_W(tlbW),
     .ZSEL_3(ZSEL[3]), .ZSEL_2(ZSEL[2]), .ZSEL_1(ZSEL[1]), .ZSEL_0(ZSEL[0]), .WR(WR), .EX(EX),
     .DI_21(RPN[21]), .DI_20(RPN[20]), .DI_19(RPN[19]), .DI_18(RPN[18]), .DI_17(RPN[17]), .DI_16(RPN[16]),
     .DI_15(RPN[15]), .DI_14(RPN[14]), .DI_13(RPN[13]), .DI_12(RPN[12]), .DI_11(RPN[11]), .DI_10(RPN[10]),
     .DI_09(RPN[9]), .DI_08(RPN[8]), .DI_07(RPN[7]), .DI_06(RPN[6]), .DI_05(RPN[5]), .DI_04(RPN[4]),
     .DI_03(RPN[3]), .DI_02(RPN[2]), .DI_01(RPN[1]), .DI_00(RPN[0]), .DSIZ_6(DSize[6]), .DSIZ_5(DSize[5]),
     .DSIZ_4(DSize[4]), .DSIZ_3(DSize[3]), .DSIZ_2(DSize[2]), .DSIZ_1(DSize[1]), .DSIZ_0(DSize[0]), .DT(DT),
     .DI_V(tlbV), .TID_7(TID[7]), .TID_6(TID[6]), .TID_5(TID[5]), .TID_4(TID[4]), .TID_3(TID[3]),
     .TID_2(TID[2]), .TID_1(TID[1]), .TID_0(TID[0]), .DI_CI_21_TEST_ODD(EPN_EA[21]), .DI_CI_20_TEST_EVEN(EPN_EA[20]),
     .DI_CI_19(EPN_EA[19]), .DI_CI_18(EPN_EA[18]), .DI_CI_17(EPN_EA[17]), .DI_CI_16(EPN_EA[16]), .DI_CI_15(EPN_EA[15]),
     .DI_CI_14(EPN_EA[14]), .DI_CI_13(EPN_EA[13]), .DI_CI_12(EPN_EA[12]), .DI_CI_11(EPN_EA[11]), .DI_CI_10(EPN_EA[10]),
     .DI_CI_09(EPN_EA[9]), .DI_CI_08(EPN_EA[8]), .DI_CI_07(EPN_EA[7]), .DI_CI_06(EPN_EA[6]), .DI_CI_05(EPN_EA[5]),
     .DI_CI_04(EPN_EA[4]), .DI_CI_03(EPN_EA[3]), .DI_CI_02(EPN_EA[2]), .DI_CI_01(EPN_EA[1]), .DI_CI_00(EPN_EA[0]),
     .SYS_CLK(CB), .TEST_M1(TestM1), .TEST_COMP(TestComp),
     .EN_C1(EN_C1), .EN_ARRAYL1(EN_ARRAYL1),
     .INDEX_5(tlbaddr[5]), .INDEX_4(tlbaddr[4]), .INDEX_3(tlbaddr[3]), .INDEX_2(tlbaddr[2]), .INDEX_1(tlbaddr[1]), .INDEX_0(tlbaddr[0]),
     .DATA_COMP(dataComp), .TAG_COMP(tagComp), .DO_G(UTLB_G), .DO_M(UTLB_M),
     .DO_I(UTLB_CacheInhibit), .DO_W(UTLB_W), .ZSEL_OUT_3(UTLB_ZSEL[3]), .ZSEL_OUT_2(UTLB_ZSEL[2]),
     .ZSEL_OUT_1(UTLB_ZSEL[1]), .ZSEL_OUT_0(UTLB_ZSEL[0]), .WR_OUT(UTLB_WR), .EX_OUT(UTLB_EX), .DO_21(UTLB_RPN[21]),
     .DO_20(UTLB_RPN[20]), .DO_19(UTLB_RPN[19]), .DO_18(UTLB_RPN[18]), .DO_17(UTLB_RPN[17]),
     .DO_16(UTLB_RPN[16]), .DO_15(UTLB_RPN[15]), .DO_14(UTLB_RPN[14]), .DO_13(UTLB_RPN[13]),
     .DO_12(UTLB_RPN[12]), .DO_11(UTLB_RPN[11]), .DO_10(UTLB_RPN[10]), .DO_09(UTLB_RPN[9]),
     .DO_08(UTLB_RPN[8]), .DO_07(UTLB_RPN[7]), .DO_06(UTLB_RPN[6]), .DO_05(UTLB_RPN[5]),
     .DO_04(UTLB_RPN[4]), .DO_03(UTLB_RPN[3]), .DO_02(UTLB_RPN[2]), .DO_01(UTLB_RPN[1]),
     .DO_00(UTLB_RPN[0]), .INDEX_OUT_5(UTLB_index[5]), .INDEX_OUT_4(UTLB_index[4]), .INDEX_OUT_3(UTLB_index[3]),
     .INDEX_OUT_2(UTLB_index[2]), .INDEX_OUT_1(UTLB_index[1]), .INDEX_OUT_0(UTLB_index[0]), .DO_K(UTLB_U0),
     .DSIZ_OUT_6(UTLB_DSize[6]), .DSIZ_OUT_5(UTLB_DSize[5]), .DSIZ_OUT_4(UTLB_DSize[4]), .DSIZ_OUT_3(UTLB_DSize[3]),
     .DSIZ_OUT_2(UTLB_DSize[2]), .DSIZ_OUT_1(UTLB_DSize[1]), .DSIZ_OUT_0(UTLB_DSize[0]), .DO_V(UTLB_V),
     .TID_OUT_7(UTLB_TID[7]), .TID_OUT_6(UTLB_TID[6]), .TID_OUT_5(UTLB_TID[5]), .TID_OUT_4(UTLB_TID[4]),
     .TID_OUT_3(UTLB_TID[3]), .TID_OUT_2(UTLB_TID[2]), .TID_OUT_1(UTLB_TID[1]), .TID_OUT_0(UTLB_TID[0]),
     .EPN_OUT_21(UTLB_EPN[21]), .EPN_OUT_20(UTLB_EPN[20]), .EPN_OUT_19(UTLB_EPN[19]), .EPN_OUT_18(UTLB_EPN[18]),
     .EPN_OUT_17(UTLB_EPN[17]), .EPN_OUT_16(UTLB_EPN[16]), .EPN_OUT_15(UTLB_EPN[15]), .EPN_OUT_14(UTLB_EPN[14]),
     .EPN_OUT_13(UTLB_EPN[13]), .EPN_OUT_12(UTLB_EPN[12]), .EPN_OUT_11(UTLB_EPN[11]), .EPN_OUT_10(UTLB_EPN[10]),
     .EPN_OUT_09(UTLB_EPN[9]), .EPN_OUT_08(UTLB_EPN[8]), .EPN_OUT_07(UTLB_EPN[7]), .EPN_OUT_06(UTLB_EPN[6]),
     .EPN_OUT_05(UTLB_EPN[5]), .EPN_OUT_04(UTLB_EPN[4]), .EPN_OUT_03(UTLB_EPN[3]), .EPN_OUT_02(UTLB_EPN[2]),
     .EPN_OUT_01(UTLB_EPN[1]), .EPN_OUT_00(UTLB_EPN[0]), .DI_PT_0(tagPar1), .DI_PT_1(tagPar2), .DI_PT_2(tagPar3), 
     .DI_PT_3(tagPar4), .DI_PD_0(ramPar1), .DI_PD_1(ramPar2), .DO_PT_0(UTLB_T1), .DO_PT_1(UTLB_T2),  .DO_PT_2(UTLB_T3),
     .DO_PT_3(UTLB_T4), .DO_PD_0(UTLB_R1), .DO_PD_1(UTLB_R2), .DVS(DVS), .reset(1'b1) );
endmodule
