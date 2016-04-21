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

module p405s_DTLB( CAR_Endian,
             CAR_U0Attr,
             CAR_XltValid,
             CAR_cacheable,
             CAR_guarded,
             CAR_writethru,
             DTLB_I,
             DTLB_U0,
             DTLB_W,
             DTLB_WR,
             DTLB_zonePR,
             MMU_apuWbEndian,
             MMU_rdarDsRAL2,
             dsRA,
             dtlbMiss,
             isDsCacheableL2,
             isDsEndianL2,
             isDsU0AttrL2,
             isDsXltValidL2,
             CAR_mmuAttr_E1,
             CAR_mmuAttr_E2,
             CB,
             DSize,
             E,
             EXE_dsEaCP_NEG,
             EXE_eaARegBuf,
             EXE_eaBRegBuf,
             G,
             I,
             ICU_mmuRdarE2,
             LSSD_coreTestEn,
             MMU_dsRA,
             RPN,
             U0,
             W,
             WR,
             bypassRPN,
             dsAddr,
             dsEA_NEG,
             dsEPN,
             dsEReal_N,
             dsGReal_N,
             dsIReal_N,
             dsInvalidate,
             dsStateA,
             dsStateD,
             dsU0Real_N,
             dsXltValid,
             dsrdNotWrt,
             isDsIReal_N,
             msrDR,
             wtReqReal_N,
             zonePR
             );

output  CAR_Endian;
output  CAR_U0Attr;
output  CAR_XltValid;
output  CAR_cacheable;
output  CAR_guarded;
output  CAR_writethru;
output  DTLB_I;
output  DTLB_U0;
output  DTLB_W;
output  DTLB_WR;
output  MMU_apuWbEndian;
output  dtlbMiss;
output  isDsCacheableL2;
output  isDsEndianL2;
output  isDsU0AttrL2;
output  isDsXltValidL2;

input  CAR_mmuAttr_E1;
input  CAR_mmuAttr_E2;
input  E;
input  G;
input  I;
input  ICU_mmuRdarE2;
input  LSSD_coreTestEn;
input  U0;
input  W;
input  WR;
input  dsEReal_N;
input  dsGReal_N;
input  dsIReal_N;
input  dsInvalidate;
input  dsStateA;
input  dsStateD;
input  dsU0Real_N;
input  dsXltValid;
input  dsrdNotWrt;
input  isDsIReal_N;
input  msrDR;
input  wtReqReal_N;

output [0:29]  MMU_rdarDsRAL2;
output [0:1]   DTLB_zonePR;
output [0:21]  dsRA;

input [0:21]   EXE_eaBRegBuf;
input [0:21]   dsEPN;
input [0:1]    zonePR;
input [0:21]   bypassRPN;
input [0:21]   RPN;
input [0:6]    DSize;
input [0:21]   EXE_eaARegBuf;
input          CB;
input [0:2]    dsAddr;
input [0:7]    EXE_dsEaCP_NEG;
input [22:29]  MMU_dsRA;
input [0:21]   dsEA_NEG;

// Buses in the design

wire  [0:21]  RA1;
wire  [0:21]  RA2;
wire  [0:29]  symNet351;
wire  [0:1]   zonePR0;
wire  [0:23]  HitBuf;
wire  [0:1]   zonePR7;
wire  [0:21]  RA0;
wire  [0:21]  RA5;
wire  [0:21]  RA6;
wire  [0:21]  RA3;
wire  [0:1]   zonePR4;
wire  [0:1]   zonePR1;
wire  [0:1]   zonePR6;
wire  [0:21]  RA_A;
wire  [0:7]   EXE_dsEaCP1;
wire  [0:1]   zonePR5;
wire  [0:21]  RA7;
wire  [0:1]   zonePR3;
wire  [0:7]   EXE_dsEaCP0;
wire  [0:1]   zonePR2;
wire  [0:1]   zonePR_A;
wire  [0:2]   dsAddr_N;
wire  [0:1]   zonePRvirt_N;
wire  [0:21]  RAvirt_N;
wire  [0:21]  RA4;
wire  [0:1]   zonePR_B;
wire  [0:21]  RA_B;
wire  [8:21]  dsEAforMunge;

wire dsWordSel2_N;
wire dsWordSel4_N;
wire dsWordSel1_N;
wire dsWordSel5_N;
wire dsWordSel6_N;
wire dsWordSel3_N;
wire dsWordSel0_N;
wire dsWordSel7_N;

reg  [0:3]  RdarAttr_reg;  
reg  [0:6]  CARAttr_DataIn;  
reg  [0:6]  CARAttr_reg;  
reg  [0:29] MMU_rdarDsRAL2_i;  

wire  EforAPU_N_L2;
wire  Hit0;
wire  Hit1;
wire  Hit2;
wire  Hit3;
wire  Hit4;
wire  Hit5;
wire  Hit6;
wire  Hit7;
wire  symNet333;
wire  symNet335;
wire  dsI_N_L2;
wire  dsG_N_L2;
wire  dsW_N_L2;
wire  dsU0_N_L2;
wire  dsE_N_L2;
wire  Hit0_Buf1;
wire  Hit1_Buf1;
wire  Hit2_Buf1;
wire  Hit3_Buf1;
wire  Hit4_Buf1;
wire  Hit5_Buf1;
wire  Hit6_Buf1;
wire  Hit7_Buf1;
wire  Hit0_Buf2;
wire  Hit1_Buf2;
wire  Hit2_Buf2;
wire  Hit3_Buf2;
wire  Hit4_Buf2;
wire  Hit5_Buf2;
wire  Hit6_Buf2;
wire  Hit7_Buf2;
wire  Hit0_Buf3;
wire  Hit1_Buf3;
wire  Hit2_Buf3;
wire  Hit3_Buf3;
wire  Hit4_Buf3;
wire  Hit5_Buf3;
wire  Hit6_Buf3;
wire  Hit7_Buf3;
wire  isDsI;
wire  dsE;
wire  Ivirt_N;
wire  Gvirt_N;
wire  Wvirt_N;
wire  U0virt_N;
wire  Evirt_N;
wire  WRvirt_N;
wire  G_A;
wire  W_A;
wire  U0_A;
wire  I_A;
wire  E_A;
wire  WR_A;
wire  G_B;
wire  W_B;
wire  U0_B;
wire  I_B;
wire  E_B;
wire  WR_B;
wire  MissA;
wire  MissB;

wire  DTLB_U0_i;
wire  [0:21]  dsRA_i;

// Fix implicit wire declarations that LEDA flags
wire  E7;
wire  G7;
wire  I7;
wire  Miss7;
wire  U0_7;
wire  WR7;
wire  W7;
wire  E1;
wire  G1;
wire  I1;
wire  Miss1;
wire  U0_1;
wire  WR1;
wire  W1;
wire  E2;
wire  G2;
wire  I2;
wire  Miss2;
wire  U0_2;
wire  WR2;
wire  W2;
wire  E4;
wire  G4;
wire  I4;
wire  Miss4;
wire  U0_4;
wire  WR4;
wire  W4;
wire  G6;
wire  I6;
wire  Miss6;
wire  U0_6;
wire  WR6;
wire  W6;
wire  E6;
wire  E0;
wire  G0;
wire  I0;
wire  Miss0;
wire  U0_0;
wire  WR0;
wire  W0;
wire  E3;
wire  G3;
wire  I3;
wire  Miss3;
wire  U0_3;
wire  WR3;
wire  W3;
wire  E5;
wire  G5;
wire  I5;
wire  Miss5;
wire  U0_5;
wire  WR5;
wire  W5;

  assign DTLB_U0 = DTLB_U0_i;
  assign MMU_rdarDsRAL2 = MMU_rdarDsRAL2_i;  
  assign dsRA = dsRA_i;

  // Removed the module "dp_logMMU_APUInv"
  assign MMU_apuWbEndian = ~(EforAPU_N_L2);

  // Removed the module "dp_logMMU_HitInv1"
  assign HitBuf[0:23] = ~({{3{Hit0}}, {3{Hit1}}, {3{Hit2}}, {3{Hit3}} , {3{Hit4}}, 
                          {3{Hit5}}, {3{Hit6}}, {3{Hit7}}});

  // Removed the module "dp_logMMU_dsEAinvforMunge"
  assign dsEAforMunge[8:21] = ~(dsEA_NEG[8:21]);

  // Removed the module "dp_logMMU_dsCPinv" 2 instances
  assign EXE_dsEaCP0[0:7] = ~(EXE_dsEaCP_NEG[0:7]);
  assign EXE_dsEaCP1[0:7] = ~(EXE_dsEaCP_NEG[0:7]);

  // Removed the module "dp_logMMU_dsinv2"
  assign symNet333 = ~(symNet335);

  // Removed the module "dp_logMMU_dsinv1"
  assign symNet335 = ~(dsStateD);

  // Removed the module "dp_regMMU_rdarRA"
  always @(posedge CB)      
    begin        
      casez(ICU_mmuRdarE2)        
        1'b0: MMU_rdarDsRAL2_i[0:29] <= MMU_rdarDsRAL2_i[0:29];        
        1'b1: MMU_rdarDsRAL2_i[0:29] <= {dsRA_i[0:21], MMU_dsRA[22:29]};        
        default: MMU_rdarDsRAL2_i[0:29] <= 30'bx;  
      endcase        
    end        

  // Removed the module "dp_logMMU_CARrepower"
assign {CAR_cacheable,CAR_guarded,CAR_writethru,CAR_U0Attr,CAR_Endian} = ~({dsI_N_L2, 
                                             dsG_N_L2,dsW_N_L2,dsU0_N_L2,dsE_N_L2});

  // Removed the module "dp_logMMU_HitInv"
  assign {Hit0_Buf1,Hit0_Buf2,Hit0_Buf3,Hit1_Buf1,Hit1_Buf2,Hit1_Buf3,Hit2_Buf1,Hit2_Buf2, 
          Hit2_Buf3,Hit3_Buf1,Hit3_Buf2,Hit3_Buf3,Hit4_Buf1,Hit4_Buf2,Hit4_Buf3,Hit5_Buf1, 
          Hit5_Buf2,Hit5_Buf3,Hit6_Buf1,Hit6_Buf2,Hit6_Buf3,Hit7_Buf1,Hit7_Buf2,Hit7_Buf3} = 
               ~(HitBuf[0:23]);

  // Removed the module "dp_regMMU_RdarAttr"
  always @(posedge CB)      
    begin        
      casez(ICU_mmuRdarE2)        
        1'b0: RdarAttr_reg <= RdarAttr_reg;        
        1'b1: RdarAttr_reg <= {isDsI, dsE, DTLB_U0_i,dsXltValid};        
        default: RdarAttr_reg <= 4'bx;  
      endcase        
    end        

  assign {isDsCacheableL2, isDsEndianL2, isDsU0AttrL2,isDsXltValidL2} = RdarAttr_reg;

  // Removed the module "dp_regMMU_CARAttr"
  always @(dsIReal_N or dsGReal_N or wtReqReal_N or dsU0Real_N or dsEReal_N or 
           dsXltValid or dsEReal_N or Ivirt_N or Gvirt_N or Wvirt_N or U0virt_N or 
           Evirt_N or dsXltValid or Evirt_N or msrDR)    
    begin        
      casez(msrDR)        
        1'b0: CARAttr_DataIn = {dsIReal_N, dsGReal_N, wtReqReal_N, dsU0Real_N, 
                               dsEReal_N, dsXltValid, dsEReal_N};   
        1'b1: CARAttr_DataIn = {Ivirt_N, Gvirt_N, Wvirt_N, U0virt_N, Evirt_N, 
                               dsXltValid, Evirt_N};   
        default: CARAttr_DataIn = 7'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin
      casez(CAR_mmuAttr_E1 & CAR_mmuAttr_E2)
        1'b0: CARAttr_reg <= CARAttr_reg;
        1'b1: CARAttr_reg <= CARAttr_DataIn;
        default: CARAttr_reg <= 7'bx;
      endcase
    end

  assign {dsI_N_L2,dsG_N_L2,dsW_N_L2,dsU0_N_L2,dsE_N_L2,CAR_XltValid,EforAPU_N_L2} = CARAttr_reg;

  // Removed the module "dp_logMMU_RAnoRealMode"
  assign {RAvirt_N[0:21], Gvirt_N, Wvirt_N, U0virt_N, Ivirt_N, Evirt_N,zonePRvirt_N[0:1],
              WRvirt_N} = ~( {RA_A[0:21], G_A, W_A, U0_A, I_A, E_A,zonePR_A[0:1], WR_A} |
              symNet351[0:29] | {RA_B[0:21], G_B, W_B, U0_B, I_B, E_B,zonePR_B[0:1], WR_B} );

  // Removed the module "dp_logMMU_bypassAND"
  assign symNet351[0:29] = {30{symNet333}} & {bypassRPN[0:21], G, W, U0, I, E, zonePR[0:1], WR};

  // Removed the module "dp_muxMMU_dtlbRAMux1"
  assign {dsRA_i[0:21], DTLB_W, DTLB_U0_i, DTLB_I, DTLB_zonePR[0:1], DTLB_WR, dsE,isDsI} =
              ~( ({dsEA_NEG[0:21], wtReqReal_N, dsU0Real_N, dsIReal_N,1'b1, 1'b1, 1'b0,
              dsEReal_N, isDsIReal_N} & {30{~(msrDR)}} ) | ({RAvirt_N[0:21],Wvirt_N,U0virt_N,
              Ivirt_N, zonePRvirt_N[0:1], WRvirt_N, Evirt_N,Ivirt_N} & {30{msrDR}} ) );

p405s_dtlb_dsWord
 Word7( .E_out           (E7),
              .G_out           (G7),
              .Hit             (Hit7),
              .I_out           (I7),
              .Miss            (Miss7),
              .RA              (RA7[0:21]),
              .U0_out          (U0_7),
              .WR_out          (WR7),
              .W_out           (W7),
              .zonePR_out      (zonePR7[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP1[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel7_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word1( .E_out           (E1), 
              .G_out           (G1),
              .Hit             (Hit1),
              .I_out           (I1),
              .Miss            (Miss1),
              .RA              (RA1[0:21]),
              .U0_out          (U0_1),
              .WR_out          (WR1),
              .W_out           (W1),
              .zonePR_out      (zonePR1[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP0[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel1_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word2( .E_out           (E2),
              .G_out           (G2),
              .Hit             (Hit2),
              .I_out           (I2),
              .Miss            (Miss2),
              .RA              (RA2[0:21]),
              .U0_out          (U0_2),
              .WR_out          (WR2),
              .W_out           (W2),
              .zonePR_out      (zonePR2[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP0[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel2_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word4( .E_out           (E4),
              .G_out           (G4),
              .Hit             (Hit4),
              .I_out           (I4),
              .Miss            (Miss4),
              .RA              (RA4[0:21]),
              .U0_out          (U0_4),
              .WR_out          (WR4),
              .W_out           (W4),
              .zonePR_out      (zonePR4[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP1[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel4_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word6( .E_out           (E6),
              .G_out           (G6),
              .Hit             (Hit6),
              .I_out           (I6),
              .Miss            (Miss6),
              .RA              (RA6[0:21]),
              .U0_out          (U0_6),
              .WR_out          (WR6),
              .W_out           (W6),
              .zonePR_out      (zonePR6[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP1[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel6_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word0( .E_out           (E0),
              .G_out           (G0),
              .Hit             (Hit0),
              .I_out           (I0),
              .Miss            (Miss0),
              .RA              (RA0[0:21]),
              .U0_out          (U0_0),
              .WR_out          (WR0),
              .W_out           (W0),
              .zonePR_out      (zonePR0[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP0[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel0_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word3( .E_out           (E3),
              .G_out           (G3),
              .Hit             (Hit3),
              .I_out           (I3),
              .Miss            (Miss3),
              .RA              (RA3[0:21]),
              .U0_out          (U0_3),
              .WR_out          (WR3),
              .W_out           (W3),
              .zonePR_out      (zonePR3[0:1]),
              .CB              (CB),
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP0[0:7]),
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel3_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

p405s_dtlb_dsWord
 Word5( .E_out           (E5),
              .G_out           (G5),
              .Hit             (Hit5), 
              .I_out           (I5), 
              .Miss            (Miss5), 
              .RA              (RA5[0:21]), 
              .U0_out          (U0_5), 
              .WR_out          (WR5), 
              .W_out           (W5), 
              .zonePR_out      (zonePR5[0:1]),
              .CB              (CB), 
              .DSize           (DSize[0:6]),
              .E               (E),
              .EXE_dsEaCP      (EXE_dsEaCP1[0:7]), 
              .EXE_eaARegBuf   (EXE_eaARegBuf[0:21]),
              .EXE_eaBRegBuf   (EXE_eaBRegBuf[0:21]),
              .G               (G),
              .I               (I),
              .LSSD_coreTestEn (LSSD_coreTestEn),
              .RPN             (RPN[0:21]),
              .U0              (U0),
              .W               (W),
              .WR              (WR),
              .WordSel_N       (dsWordSel5_N),
              .dsEAforMunge    (dsEAforMunge[8:21]),
              .dsEPN           (dsEPN[0:21]),
              .dsStateA        (dsStateA),
              .invalidate      (dsInvalidate),
              .msrDR           (msrDR),
              .rdNotWrt        (dsrdNotWrt),
              .zonePR          (zonePR[0:1])
              );

  // Removed the module "dp_logMMU_dsNOR1"
  assign dtlbMiss = ~( MissA | MissB );

  // Removed the module "dp_logMMU_dsNAND2"
  assign MissB = ~( Miss4 & Miss5 & Miss6 & Miss7 );

  // Removed the module "dp_logMMU_dsNAND1"
  assign MissA = ~( Miss0 & Miss1 & Miss2 & Miss3 );

  // Removed the module "dp_logMMU_hitAttr_A"
  assign {G_A, W_A, U0_A, I_A, E_A, zonePR_A[0:1], WR_A} = ({Hit0_Buf3, Hit0_Buf3, Hit0_Buf3,
             Hit0_Buf3, Hit0_Buf3, Hit0_Buf3, Hit0_Buf3, Hit0_Buf3} & {G0, W0, U0_0, I0, E0,
             zonePR0[0:1], WR0}) | ({Hit1_Buf3,Hit1_Buf3, Hit1_Buf3, Hit1_Buf3, Hit1_Buf3,
             Hit1_Buf3, Hit1_Buf3, Hit1_Buf3} & {G1, W1,U0_1, I1, E1, zonePR1[0:1], WR1}) |
             ({Hit2_Buf3, Hit2_Buf3, Hit2_Buf3, Hit2_Buf3, Hit2_Buf3,Hit2_Buf3, Hit2_Buf3,
             Hit2_Buf3} & {G2, W2, U0_2, I2, E2, zonePR2[0:1], WR2}) | ({Hit3_Buf3,Hit3_Buf3,
             Hit3_Buf3, Hit3_Buf3, Hit3_Buf3, Hit3_Buf3, Hit3_Buf3, Hit3_Buf3} & {G3, W3,U0_3,
             I3, E3, zonePR3[0:1], WR3});

  // Removed the module "dp_logMMU_hitAttr_B"
  assign {G_B, W_B, U0_B, I_B, E_B, zonePR_B[0:1], WR_B} = ({Hit4_Buf3, Hit4_Buf3, Hit4_Buf3,
             Hit4_Buf3, Hit4_Buf3,Hit4_Buf3, Hit4_Buf3, Hit4_Buf3} & {G4, W4, U0_4, I4, E4,
             zonePR4[0:1], WR4}) | ({Hit5_Buf3,Hit5_Buf3, Hit5_Buf3, Hit5_Buf3, Hit5_Buf3,
             Hit5_Buf3, Hit5_Buf3, Hit5_Buf3} & {G5, W5,U0_5, I5, E5, zonePR5[0:1], WR5}) |
             ({Hit6_Buf3, Hit6_Buf3, Hit6_Buf3, Hit6_Buf3, Hit6_Buf3,Hit6_Buf3, Hit6_Buf3,
             Hit6_Buf3} & {G6, W6, U0_6, I6, E6, zonePR6[0:1], WR6}) | ({Hit7_Buf3,Hit7_Buf3,
             Hit7_Buf3, Hit7_Buf3, Hit7_Buf3, Hit7_Buf3, Hit7_Buf3, Hit7_Buf3} & {G7, W7,U0_7,
             I7, E7, zonePR7[0:1], WR7});

  // Removed the module "dp_logMMU_hitRA_B"
  assign RA_B[0:21] = ({{11{Hit4_Buf1}}, {11{Hit4_Buf2}}} & RA4[0:21]) | 
                      ({{11{Hit5_Buf1}}, {11{Hit5_Buf2}}} & RA5[0:21]) |
                      ({{11{Hit6_Buf1}}, {11{Hit6_Buf2}}} & RA6[0:21]) |
                      ({{11{Hit7_Buf1}}, {11{Hit7_Buf2}}} & RA7[0:21]);

  // Removed the module "dp_logMMU_hitRA_A"
  assign RA_A[0:21] = ({{11{Hit0_Buf1}}, {11{Hit0_Buf2}}} & RA0[0:21]) |
                      ({{11{Hit1_Buf1}}, {11{Hit1_Buf2}}} & RA1[0:21]) |
                      ({{11{Hit2_Buf1}}, {11{Hit2_Buf2}}} & RA2[0:21]) |
                      ({{11{Hit3_Buf1}}, {11{Hit3_Buf2}}} & RA3[0:21]);

   // Replacing instantiation: GTECH_NAND3 I223
   assign dsWordSel2_N = ~( dsAddr_N[0] & dsAddr[1] & dsAddr_N[2] );

   // Replacing instantiation: GTECH_NAND3 I225
   assign dsWordSel4_N = ~( dsAddr[0] & dsAddr_N[1] & dsAddr_N[2] );

   // Replacing instantiation: GTECH_NAND3 I222
   assign dsWordSel1_N = ~( dsAddr_N[0] & dsAddr_N[1] & dsAddr[2] );

   // Replacing instantiation: GTECH_NAND3 I226
   assign dsWordSel5_N = ~( dsAddr[0] & dsAddr_N[1] & dsAddr[2] );

   // Replacing instantiation: GTECH_NAND3 I227
   assign dsWordSel6_N = ~( dsAddr[0] & dsAddr[1] & dsAddr_N[2] );

   // Replacing instantiation: GTECH_NAND3 I224
   assign dsWordSel3_N = ~( dsAddr_N[0] & dsAddr[1] & dsAddr[2] );

   // Replacing instantiation: GTECH_NAND3 I221
   assign dsWordSel0_N = ~( dsAddr_N[0] & dsAddr_N[1] & dsAddr_N[2] );

   // Replacing instantiation: GTECH_NAND3 I228
   assign dsWordSel7_N = ~( dsAddr[0] & dsAddr[1] & dsAddr[2] );

   // Replacing instantiation: GTECH_NOT I218
   assign dsAddr_N[0] = ~(dsAddr[0]);

   // Replacing instantiation: GTECH_NOT I220
   assign dsAddr_N[2] = ~(dsAddr[2]);

   // Replacing instantiation: GTECH_NOT I219
   assign dsAddr_N[1] = ~(dsAddr[1]);

endmodule
