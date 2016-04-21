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

module p405s_ITLB( ITLB_E,
             ITLB_I_NEG,
             ITLB_U0,
             isRA_NEG,
             itlbMiss,
             CB,
             CompE2,
             DSize,
             E,
             I,
             LoadRealRaAttr,
             RPN,
             U0,
             VCT_msrIR,
             isAbort,
             isAddr,
             isEA_NEG,
             isEPN,
             isEReal_N,
             isIReal_N,
             isInvalidate,
             isU0Real_N,
             isrdNotWrt,
             msrIrL2
             );

output  ITLB_E;
output  ITLB_U0;
output  itlbMiss;

input  CompE2;
input  E;
input  I;
input  LoadRealRaAttr;
input  U0;
input  VCT_msrIR;
input  isAbort;
input  isEReal_N;
input  isIReal_N;
input  isInvalidate;
input  isU0Real_N;
input  isrdNotWrt;
input  msrIrL2;

output [0:21]  isRA_NEG;
output [0:2]  ITLB_I_NEG;

input [0:21]  RPN;
input [0:1]  isAddr;
input [0:21]  isEA_NEG;
input [0:21]  isEPN;
input [0:6]  DSize;
input        CB;

// Buses in the design

wire  [0:21]  RA1;
wire  [0:21]  RA2;
wire  [0:21]  RA3;
wire  [0:2]  isI;
wire  [0:11]  symNet432;
wire  [0:2]  Hit3_Buf;
wire  [0:2]  Hit2_Buf;
wire  [0:2]  Hit0_Buf;
wire  [0:21]  isEA;
wire  [0:4]  symNet437;
wire  [0:21]  RPN_out;
wire  [0:2]  Hit1_Buf;
wire  [0:21]  RA0;

wire  isWordSel3_N;
wire  isAddr0_N;
wire  isWordSel1_N;
wire  isAddr1_N;
wire  isWordSel0_N;
wire  isWordSel2_N;
wire  Miss0;
wire  Miss3;
wire  Miss2;
wire  Miss1;
wire  writeShadow;
wire  isAbort_N;

// To get rid of hte implicit wire declarations that LEDA flags
wire  E0_N;
wire  Hit0;
wire  I0_N;
wire  U0_0_N;
wire  E3;
wire  Hit3;
wire  I3;
wire  U0_3;
wire  E2;
wire  Hit2;
wire  I2;
wire  U0_2;
wire  E1;
wire  Hit1;
wire  I1;
wire  U0_1;


  // Removed the module "dp_logMMU_isrepower"
  assign {writeShadow, isAbort_N} = ~({isrdNotWrt, isAbort});

  // Removed the module "dp_logMMU_isEAinvforITLB"
  assign isEA[0:21] = ~(isEA_NEG[0:21]);

  // Removed the module "dp_muxMMU_isI_redrive"
  assign ITLB_I_NEG[0:2] = ~(isI[0:2]);

  // Removed the module "dp_logMMU_isRAredrive"
  assign isRA_NEG[0:21] = ~(RPN_out[0:21]);

p405s_itlb_isWord0
 Word0( .E_out_N        (E0_N), 
               .Hit            (Hit0), 
               .I_out_N        (I0_N), 
               .Miss           (Miss0), 
               .RA             (RA0[0:21]), 
               .U0_out_N       (U0_0_N), 
               .CB             (CB), 
               .CompE2         (CompE2),
               .DSize          (DSize[0:6]), 
               .E              (E), 
               .I              (I), 
               .LoadRealRaAttr (LoadRealRaAttr), 
               .RPN            (RPN[0:21]), 
               .U0             (U0), 
               .VCT_msrIR      (VCT_msrIR), 
               .WordSel_N      (isWordSel0_N),
               .invalidate     (isInvalidate), 
               .isAbort_N      (isAbort_N), 
               .isEA           (isEA[0:21]), 
               .isEA_NEG       (isEA_NEG[0:21]), 
               .isEPN          (isEPN[0:21]), 
               .msrIrL2        (msrIrL2), 
               .rdNotWrt       (isrdNotWrt),
               .writeShadow    (writeShadow)
               );

p405s_itlb_isWord1_3
 Word3( .E_out       (E3), 
                 .Hit         (Hit3), 
                 .I_out       (I3), 
                 .Miss        (Miss3), 
                 .RA          (RA3[0:21]), 
                 .U0_out      (U0_3), 
                 .CB          (CB), 
                 .CompE2      (CompE2), 
                 .DSize       (DSize[0:6]), 
                 .E           (E),
                 .I           (I), 
                 .RPN         (RPN[0:21]), 
                 .U0          (U0), 
                 .WordSel_N   (isWordSel3_N), 
                 .invalidate  (isInvalidate), 
                 .isAbort_N   (isAbort_N), 
                 .isEA        (isEA[0:21]),
                 .isEPN       (isEPN[0:21]), 
                 .msrIrL2     (msrIrL2), 
                 .rdNotWrt    (isrdNotWrt), 
                 .writeShadow (writeShadow)
                 );

p405s_itlb_isWord1_3
 Word2( .E_out       (E2), 
                 .Hit         (Hit2), 
                 .I_out       (I2), 
                 .Miss        (Miss2), 
                 .RA          (RA2[0:21]), 
                 .U0_out      (U0_2), 
                 .CB          (CB), 
                 .CompE2      (CompE2), 
                 .DSize       (DSize[0:6]),
                 .E           (E), 
                 .I           (I), 
                 .RPN         (RPN[0:21]), 
                 .U0          (U0), 
                 .WordSel_N   (isWordSel2_N), 
                 .invalidate  (isInvalidate), 
                 .isAbort_N   (isAbort_N), 
                 .isEA        (isEA[0:21]),
                 .isEPN       (isEPN[0:21]), 
                 .msrIrL2     (msrIrL2), 
                 .rdNotWrt    (isrdNotWrt), 
                 .writeShadow (writeShadow)
                 );

p405s_itlb_isWord1_3
 Word1( .E_out       (E1), 
                 .Hit         (Hit1), 
                 .I_out       (I1), 
                 .Miss        (Miss1), 
                 .RA          (RA1[0:21]),  
                 .U0_out      (U0_1), 
                 .CB          (CB), 
                 .CompE2      (CompE2), 
                 .DSize       (DSize[0:6]),
                 .E           (E), 
                 .I           (I), 
                 .RPN         (RPN[0:21]), 
                 .U0          (U0), 
                 .WordSel_N   (isWordSel1_N), 
                 .invalidate  (isInvalidate), 
                 .isAbort_N   (isAbort_N), 
                 .isEA        (isEA[0:21]),
                 .isEPN       (isEPN[0:21]), 
                 .msrIrL2     (msrIrL2), 
                 .rdNotWrt    (isrdNotWrt), 
                 .writeShadow (writeShadow)
                 );

  // Removed the module "dp_logMMU_isHitInv"
  assign symNet432[0:11] = ~({{3{Hit0}}, {3{Hit1}}, {3{Hit2}}, {3{Hit3}}});

  // Removed the module "dp_logMMU_isHitInv"
  assign {Hit0_Buf[0:2], Hit1_Buf[0:2], Hit2_Buf[0:2],Hit3_Buf[0:2]} = ~(symNet432[0:11]);

  // Removed the module "dp_muxMMU_isStuff"
  assign symNet437[0:4] = ~( ({isU0Real_N, isIReal_N, isIReal_N, isIReal_N, isEReal_N} &
                            {5{~(msrIrL2)}} ) | ({U0_0_N, I0_N, I0_N, I0_N, E0_N} & 
                            {5{msrIrL2}}));


   // Replacing instantiation: GTECH_NAND2 I65
   assign isWordSel3_N = ~( isAddr[0] & isAddr[1] );

   // Replacing instantiation: GTECH_NAND2 I63
   assign isWordSel1_N = ~( isAddr0_N & isAddr[1] );

   // Replacing instantiation: GTECH_NAND2 I64
   assign isWordSel2_N = ~( isAddr1_N & isAddr[0] );

   // Replacing instantiation: GTECH_NAND2 I62
   assign isWordSel0_N = ~( isAddr0_N & isAddr1_N );

   // Replacing instantiation: GTECH_NOT I61
   assign isAddr1_N = ~(isAddr[1]);

   // Replacing instantiation: GTECH_NOT I60
   assign isAddr0_N = ~(isAddr[0]);

   // Replacing instantiation: GTECH_AND4 I58
   assign itlbMiss = Miss0 & Miss1 & Miss2 & Miss3;

  // Removed the module "dp_logMMU_isHitAttr"
  assign {ITLB_U0, isI[0:2], ITLB_E} = ({Hit0_Buf[2], Hit0_Buf[2], Hit0_Buf[2], Hit0_Buf[2],
                                         Hit0_Buf[2]} & symNet437[0:4]) | 
                                       ({Hit1_Buf[2], Hit1_Buf[2], Hit1_Buf[2], Hit1_Buf[2],
                                         Hit1_Buf[2]} & {U0_1, I1, I1, I1, E1}) | 
                                       ({Hit2_Buf[2], Hit2_Buf[2], Hit2_Buf[2], Hit2_Buf[2],
                                         Hit2_Buf[2]} & {U0_2, I2, I2, I2, E2}) | 
                                       ({Hit3_Buf[2], Hit3_Buf[2], Hit3_Buf[2], Hit3_Buf[2],
                                         Hit3_Buf[2]} & {U0_3, I3, I3, I3, E3});

  // Removed the module "dp_logMMU_hitRA"
  assign RPN_out[0:21] = ({{9{Hit0_Buf[0]}},{9{Hit0_Buf[1]}},{4{Hit0_Buf[2]}}} & RA0[0:21]) |
                         ({{9{Hit1_Buf[0]}},{9{Hit1_Buf[1]}},{4{Hit1_Buf[2]}}} & RA1[0:21]) |
                         ({{9{Hit2_Buf[0]}},{9{Hit2_Buf[1]}},{4{Hit2_Buf[2]}}} & RA2[0:21]) |
                         ({{9{Hit3_Buf[0]}},{9{Hit3_Buf[1]}},{4{Hit3_Buf[2]}}} & RA3[0:21]);

endmodule
