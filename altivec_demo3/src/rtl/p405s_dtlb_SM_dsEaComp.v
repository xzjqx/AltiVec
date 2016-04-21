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

module p405s_dtlb_SM_dsEaComp( Hit,
                    Miss,
                    EXE_dsEaCP,
                    FC,
                    FS,
                    LSSD_coreTestEn,
                    Size,
                    Valid,
                    dsStateA,
                    msrDR_NEG
                    );

output  Hit;
output  Miss;

input  LSSD_coreTestEn;
input  Valid;
input  dsStateA;
input  msrDR_NEG;

input [0:7]   EXE_dsEaCP;
input [0:21]  FS;
input [0:21]  FC;
input [0:6]   Size;

// Buses in the design

wire  [0:6]   Size_NEG;
wire  [0:21]  sum_NEG;
wire  [8:21]  sum;
wire  [0:21]  sumNegNoRedund;
wire  [8:22]  carry;

wire  stateValid;
wire  FC1;
wire  FC2;
wire  FC3;
wire  FC4;
wire  FC5;
wire  FC6;
wire  FC7;

wire  Hit_i;

  assign Hit = Hit_i;

assign Hit_i = ( (~msrDR_NEG) &
               (~stateValid) &
               ((~sum[21] & carry[22]) | (~sumNegNoRedund[21] & ~carry[22])) &
               ((~sum[20] & carry[21]) | (~sumNegNoRedund[20] & ~carry[21])) &
               ((~sum[19] & carry[20]) | (~sumNegNoRedund[19] & ~carry[20])) &
               ((~sum[18] & carry[19]) | (~sumNegNoRedund[18] & ~carry[19])) &
               ((~sum[17] & carry[18]) | (~sumNegNoRedund[17] & ~carry[18])) &
               ((~sum[16] & carry[17]) | (~sumNegNoRedund[16] & ~carry[17])) &
               ((~sum[15] & carry[16]) | (~sumNegNoRedund[15] & ~carry[16])) &
               ((~sum[14] & carry[15]) | (~sumNegNoRedund[14] & ~carry[15])) &
               ((~sum[13] & carry[14]) | (~sumNegNoRedund[13] & ~carry[14])) &
               ((~sum[12] & carry[13]) | (~sumNegNoRedund[12] & ~carry[13])) &
               ((~sum[11] & carry[12]) | (~sumNegNoRedund[11] & ~carry[12])) &
               ((~sum[10] & carry[11]) | (~sumNegNoRedund[10] & ~carry[11])) &
               ((~sum[9] & carry[10]) | (~sumNegNoRedund[9] & ~carry[10])) &
               ((~sum[8] & carry[9]) | (~sumNegNoRedund[8] & ~carry[9])) &
               ((~FS[7] & carry[8]) | (~sumNegNoRedund[7] & ~carry[8])) &
               ((~FS[6] & FC[7]) | (~sumNegNoRedund[6] & ~FC[7])) &
               ((~FS[5] & FC[6]) | (~sumNegNoRedund[5] & ~FC[6])) &
               ((~FS[4] & FC[5]) | (~sumNegNoRedund[4] & ~FC[5])) &
               ((~FS[3] & FC[4]) | (~sumNegNoRedund[3] & ~FC[4])) &
               ((~FS[2] & FC[3]) | (~sumNegNoRedund[2] & ~FC[3])) &
               ((~FS[1] & FC[2]) | (~sumNegNoRedund[1] & ~FC[2])) &
               ((~FS[0] & FC[1]) | (~sumNegNoRedund[0] & ~FC[1])) ); 

assign Miss = ~Hit_i;
               
  // Removed the module "dp_muxMMU_dsCompRedund"
  assign sumNegNoRedund[0:21] = ~( ({FS[0:7], sum[8:21]} & {(22){~(LSSD_coreTestEn)}} ) |
                                   (sum_NEG[0:21] & {(22){LSSD_coreTestEn}} ) );

  // Removed the module "dp_logMMU_dsCompSV"
  assign stateValid = ~( Valid & dsStateA );

  // Removed the module "dp_logMMU_dsCompSumBar"
  assign sum_NEG[8:21] = ~(sum[8:21]);

  // Removed the module "dp_logMMU_dsCompSum"
  assign sum[8:21] = ~( FS[8:21] & {Size_NEG[0],Size_NEG[0],Size_NEG[1],Size_NEG[1],Size_NEG[2],
                        Size_NEG[2],Size_NEG[3],Size_NEG[3],Size_NEG[4],Size_NEG[4],Size_NEG[5],
                        Size_NEG[5],Size_NEG[6],Size_NEG[6]} );

  // Removed the module "dp_logMMU_dsCompSum1"
  assign sum_NEG[0:7] = ~(FS[0:7]);

  // Removed the module "dp_logMMU_dsCompCarry2"
  assign {carry[9],carry[11],carry[13],carry[15],carry[17],carry[19],carry[21],carry[22]} =
                      ~( {FC[9],FC[11],FC[13],FC[15],FC[17],FC[19],FC[21],EXE_dsEaCP[7]} |
                      {Size[0:6],Size[6]} );

  // Removed the module "dp_logMMU_dsCompCarry"
    assign {carry[10], carry[12], carry[14], carry[16], carry[18], carry[20]} = 
                    ~( (EXE_dsEaCP[1:6] & Size[1:6]) | {FC6, FC5, FC4, FC3, FC2, FC1} );

  // Removed the module "dp_logMMU_dsCompC8"
  assign carry[8] = (EXE_dsEaCP[0] & Size[0]) | FC7;

  // Removed the module "dp_logMMU_dsCompFCS7"
  assign FC7 = Size_NEG[0] & FC[8];

  // Removed the module "dp_logMMU_dsCompFCS"
  assign {FC6, FC5, FC4, FC3, FC2, FC1} = (Size_NEG[1:6] & {FC[10], FC[12], FC[14], FC[16],
                                           FC[18],FC[20]}) | Size[0:5];

  // Removed the module "dp_logMMU_dsCompInv"
  assign Size_NEG[0:6] = ~(Size[0:6]);

endmodule
