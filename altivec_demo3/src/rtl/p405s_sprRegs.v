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

module p405s_sprRegs( IFB_sprDataBus, ctrEq1, ctrEq2, ctrL2, evprL2, exeMtCtr,
     exeMtLr, iac1L2, iac2L2, iac3L2, iac4L2, linkL2,
     lrCtrNormal_Neg, lrCtrSe_Neg,  srr02_Neg, CB,
     EXE_sprDataBus, PCL_sprHold, VCT_swap01, VCT_swap23, VCT_wbRfci, coreResetL2,
     crL2, exeBcL2, exeBrAndLink, exeDataBO_2, exeDataSprf, exeIar,
     exeMfsprL2, exeMtsprL2, refetchPipeAddr, saveForTraceE1, saveForTraceE2, 
     seCtrSt, swapEnable, tracePipeHold, wbMtCtrL2 );
output  ctrEq1, ctrEq2, exeMtCtr, exeMtLr;


input  PCL_sprHold, VCT_swap01, VCT_swap23, VCT_wbRfci, coreResetL2, exeBcL2, exeBrAndLink,
     exeDataBO_2, exeMfsprL2, exeMtsprL2, saveForTraceE1, saveForTraceE2, seCtrSt,
     swapEnable, tracePipeHold, wbMtCtrL2;

output [0:29]  iac4L2;
output [0:29]  srr02_Neg;
output [0:15]  evprL2;
output [0:29]  lrCtrSe_Neg;
output [0:31]  ctrL2;
output [0:31]  linkL2;
output [0:31]  IFB_sprDataBus;
output [0:29]  iac3L2;
output [0:29]  iac2L2;
output [0:29]  iac1L2;
output [0:29]  lrCtrNormal_Neg;


input [11:20]  exeDataSprf;
input [0:29]  exeIar;
input [0:31]  EXE_sprDataBus;
input [0:29]  refetchPipeAddr;
input        CB;
input [0:31]  crL2;

// Buses in the design
wire  [0:31]  sprg0L2;
wire  [0:31]  sprg1L2;
wire  [0:31]  sprg2L2;
wire  [0:31]  sprg3L2;
wire  [0:31]  sprg4L2;
wire  [0:31]  sprg5L2;
wire  [0:31]  sprg6L2;
wire  [0:31]  sprg7L2;
wire  [0:31]  sprg04;
wire  [0:31]  sprg57;
wire  [0:29]  srr0L2;
wire  [0:29]  srr2L2;
wire  [0:31]  sprGroup2;
wire  [0:29]  iac04;
wire  [0:29]  srr02;
wire  [0:31]  usprg0;
wire  [0:29]  cdsbus0;
wire  [0:31]  nxtCtr;
wire  [0:1]  sprGroup1Sel;
wire  [0:1]  iacGroupSel;
wire  [0:1]  ifbSprsSel;
wire  [0:31]  sprGroup1;
wire  [0:29]  lrSe;
wire  [0:29]  ctrSe;
wire  [0:31]  cdsbus1;
wire  [0:1]  sprGroup2Sel;
wire  [0:1]  sprg47GroupSel;
wire  [0:1]  sprg03GroupSel;
reg [0:31] regUsprg0_Reg;
reg [0:29] lrForTrace_Reg;
reg [0:29] ctrForTrace_Reg;
wire usprg0E2;
reg [0:29] Iac4_Reg;
wire iac4E2; 
wire srr02MuxSel;
wire crSel, evprSel, lrSel, ctrSel, iac1Sel, iac2Sel, iac3Sel;
wire iac4Sel, sprg0Sel, sprg1Sel, sprg2Sel, sprg3Sel, sprg4RdSel;
wire sprg5RdSel, sprg6RdSel, sprg7RdSel, sprg4WrSel, sprg5WrSel;
wire sprg6WrSel, sprg7WrSel, srr0Sel, srr2Sel, usprg0Sel, sprHold_Neg;
wire [0:9]   exeDataSprn;
wire evprE2, lrE2, ctrE2, exeDecCtr, iac1E2, iac2E2, iac3E2, sprg0E2, sprg1E2; 
wire sprg2E2, sprg3E2, sprg4E2, sprg5E2, sprg6E2, sprg7E2, srr0E2, srr2E2; 
wire srr0InMuxSel, srr2InMuxSel;
reg [0:31] ctr_mux;
wire nxtCtrEq1, nxtCtrEq2;
reg [0:31] sprGroup2_mux;
reg [0:31] sprGroup1_mux;
reg [0:31] sprDataBus_mux;
reg [0:15] evpr_Reg;
reg [0:29] iacSpr_mux;
reg [0:31] sprg47_mux;
reg [0:31] sprg03_mux;
reg [0:29] srr2_Reg_next;
reg [0:29] srr2_Reg;
reg [0:29] srr0_Reg_next;
reg [0:29] srr0_Reg;
reg [0:29] Iac3_Reg;
reg [0:29] Iac2_Reg;
reg [0:29] Iac1_Reg;
reg [0:31] sprg7_Reg;
reg [0:31] sprg6_Reg;
reg [0:31] sprg5_Reg;
reg [0:31] sprg4_Reg;
reg [0:31] sprg3_Reg;
reg [0:31] sprg2_Reg;
reg [0:31] sprg1_Reg;
reg [0:31] sprg0_Reg;
reg [0:1] ctrCompares_Reg;
reg [0:31] ctr_Reg;
reg [0:31] link_Reg;
reg [0:31] link_Reg_next;

wire [0:29] iac4L2_int;
wire [0:29] srr02_Neg_int;
wire [0:15] evprL2_int;
wire [0:31] ctrL2_int;
wire [0:31] linkL2_int;
wire [0:29] iac3L2_int;
wire [0:29] iac2L2_int;
wire [0:29] iac1L2_int;

assign iac4L2 =  iac4L2_int;
assign srr02_Neg =  srr02_Neg_int;
assign evprL2 =  evprL2_int;
assign ctrL2 =  ctrL2_int;
assign linkL2 =  linkL2_int;
assign iac3L2 =  iac3L2_int;
assign iac2L2 =  iac2L2_int;
assign iac1L2 =  iac1L2_int;



//Removed the module 'dp_macIFB_lrInc' 
assign cdsbus0[0:29] = exeIar[0:29] + 1;

//Removed the module 'dp_macIFB_ctrDec' 
assign cdsbus1[0:31] = ctrL2_int[0:31] - 1;

//Removed the module 'dp_regIFB_regUsprg0' 
assign  usprg0[0:31] = regUsprg0_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & usprg0E2)
    1'b0: regUsprg0_Reg <= regUsprg0_Reg;
    1'b1: regUsprg0_Reg <= EXE_sprDataBus[0:31];
    default: regUsprg0_Reg <= 32'bx;
  endcase

//Removed the module 'dp_muxIFB_traceLrCtrNormal' 
assign lrCtrNormal_Neg[0:29] = 
         ~((linkL2_int[0:29] & {(30){~(wbMtCtrL2)}} ) | (ctrL2_int[0:29] & {(30){wbMtCtrL2}}));

//Removed the module 'dp_muxIFB_traceLrCtrSe' 
assign lrCtrSe_Neg[0:29] = 
         ~((lrSe[0:29] & {(30){~(seCtrSt)}} ) | (ctrSe[0:29] & {(30){seCtrSt}}));

//Removed the module 'dp_regIFB_lrForTrace'
assign lrSe[0:29] = lrForTrace_Reg;
//posedge FF
always @(posedge CB)
  casez(saveForTraceE1 & saveForTraceE2)
    1'b0: lrForTrace_Reg <= lrForTrace_Reg;
    1'b1: lrForTrace_Reg <= linkL2_int[0:29];
    default: lrForTrace_Reg <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_ctrForTrace'
assign ctrSe[0:29] = ctrForTrace_Reg;
//posedge FF
always @(posedge CB)
  casez(saveForTraceE1 & saveForTraceE2)
    1'b0: ctrForTrace_Reg <= ctrForTrace_Reg;
    1'b1: ctrForTrace_Reg <= ctrL2_int[0:29];
    default: ctrForTrace_Reg <= 30'bx;
  endcase

//Removed the module 'dp_logIFB_srr02SprBusInv'
assign srr02[0:29] = ~srr02_Neg_int[0:29];

//Removed the module 'dp_logIFB_sprAclk'
//Removed the module 'dp_regIFB_Iac4'
assign iac4L2_int[0:29] = Iac4_Reg;
//posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & iac4E2)
    1'b0: Iac4_Reg <= Iac4_Reg;
    1'b1: Iac4_Reg <= EXE_sprDataBus[0:29];
    default: Iac4_Reg <= 30'bx;
  endcase

//Removed the module 'dp_muxIFB_srr02Mux'
assign srr02_Neg_int[0:29] = 
       ~((srr0L2[0:29] & {(30){~(srr02MuxSel)}} ) | (srr2L2[0:29] & {(30){srr02MuxSel}} ));

//Removed the module 'sprEqs'
//***********************
//***********************
// Spr Equations        *
//***********************
//***********************
// The IFB unit has 18 sprs as follows:
// 1-4) IAC1-4   - Instr Addr Compare : for trace and dbg
// 5)   EVPR     - Exception Vector Prefix Register : provides 16
//                most sig bits of vector address
// 6)   CR       - Condition code Register
// 7)   LR       - Link Register
// 8)   CTR      - CounT Register
// 9-16) SPRG0-7
// 17)  SRR0     - Save and Restore Reg 0
// 18)  SRR2     - Save and Restore Reg 2

// Rename some signals.
assign exeDataSprn[0:9] = {exeDataSprf[16:20],exeDataSprf[11:15]};
assign sprHold_Neg = ~PCL_sprHold;

// The E2 to the IFD sprs is simply exeMtspr (For iac, sprg, evpr
// assign sprE2 = PCL_sprHold;

// spr addr decodes.
assign crSel     = (exeDataSprn[0:9] == 10'h000);
assign evprSel   = (exeDataSprn[0:9] == 10'h3d6);
assign lrSel     = (exeDataSprn[0:9] == 10'h008);
assign ctrSel    = (exeDataSprn[0:9] == 10'h009);
assign iac1Sel   = (exeDataSprn[0:9] == 10'h3f4);
assign iac2Sel   = (exeDataSprn[0:9] == 10'h3f5);
assign iac3Sel   = (exeDataSprn[0:9] == 10'h3b4);
assign iac4Sel   = (exeDataSprn[0:9] == 10'h3b5);
assign usprg0Sel  = (exeDataSprn[0:9] == 10'h100);
assign sprg0Sel  = (exeDataSprn[0:9] == 10'h110);
assign sprg1Sel  = (exeDataSprn[0:9] == 10'h111);
assign sprg2Sel  = (exeDataSprn[0:9] == 10'h112);
assign sprg3Sel  = (exeDataSprn[0:9] == 10'h113);
assign sprg4RdSel = ((exeDataSprn[0:9] == 10'h104) |
                     (exeDataSprn[0:9] == 10'h114));
assign sprg5RdSel = ((exeDataSprn[0:9] == 10'h105) |
                     (exeDataSprn[0:9] == 10'h115));
assign sprg6RdSel = ((exeDataSprn[0:9] == 10'h106) |
                     (exeDataSprn[0:9] == 10'h116));
assign sprg7RdSel = ((exeDataSprn[0:9] == 10'h107) |
                     (exeDataSprn[0:9] == 10'h117));
assign sprg4WrSel = (exeDataSprn[0:9] == 10'h114);
assign sprg5WrSel = (exeDataSprn[0:9] == 10'h115);
assign sprg6WrSel = (exeDataSprn[0:9] == 10'h116);
assign sprg7WrSel = (exeDataSprn[0:9] == 10'h117);
assign srr0Sel   = (exeDataSprn[0:9] == 10'h01a);
assign srr2Sel   = (exeDataSprn[0:9] == 10'h3de);

//*Need to minimize some of these equations not all bit are needed in some cases

// Group1: evpr, cr, lr, ctr Mux
// 00 - cr
// 01 - evpr
// 10 - lr
// 11 - ctr
assign sprGroup1Sel[0:1] = {(lrSel | ctrSel),(evprSel | ctrSel)};

// iac Select spr Mux
// 00 - iac1
// 01 - iac2
// 10 - iac3
// 11 - iac4
assign iacGroupSel[0:1] = {(iac3Sel | iac4Sel),(iac2Sel | iac4Sel)};

// sprg03 Select spr Mux
// 00 - sprg0
// 01 - sprg1
// 10 - sprg2
// 11 - sprg3
assign sprg03GroupSel[0:1] = {(sprg2Sel | sprg3Sel),(sprg1Sel | sprg3Sel)};

// sprg47 Select spr Mux
// 00 - sprg4
// 01 - sprg5
// 10 - sprg6
// 11 - sprg7
assign sprg47GroupSel[0:1] = {(sprg6RdSel | sprg7RdSel),
                              (sprg5RdSel | sprg7RdSel)};

// group2 Select spr Mux
// 00 - sprg03
// 01 - sprg47
// 10 - srr0
// 11 - srr2
assign sprGroup2Sel[0:1] = {(srr0Sel | srr2Sel | usprg0Sel),
            (sprg4RdSel | sprg5RdSel | sprg6RdSel | sprg7RdSel | usprg0Sel)};

// exeRfi, exeRfci cause a bubble so there can't be anything in exe when
// rfi or rfci is in wb.
assign srr02MuxSel = VCT_wbRfci | srr2Sel;

// ifb Sprs Bypass Mux
// 00 - Bypass
// 01 - iacGroup
// 10 - sprGroup1
// 11 - sprGroup2
assign ifbSprsSel[0:1] =
              {(exeMfsprL2 & (crSel | lrSel | ctrSel | evprSel |
               srr0Sel | srr2Sel | sprg0Sel | sprg1Sel | sprg2Sel | sprg3Sel |
               sprg4RdSel | sprg5RdSel | sprg6RdSel | sprg7RdSel | usprg0Sel)),
              (exeMfsprL2 & (iac1Sel | iac2Sel | iac3Sel | iac4Sel |
               srr0Sel | srr2Sel | sprg0Sel | sprg1Sel | sprg2Sel | sprg3Sel |
               sprg4RdSel | sprg5RdSel | sprg6RdSel | sprg7RdSel | usprg0Sel))};

// E1 equation for sprs is simply exeMtspr
// sprE1 = exeMtSprL2;

// evpr equations.
//assign evprE1 = evprSel & exeMtsprL2;
assign evprE2 = evprSel & sprHold_Neg;

// lr equations.
//assign lrE1 = exeBrAndLink | (lrSel & exeMtsprL2);
//assign lrCtrE2 = coreResetL2 | ~(PCL_sprHold | tracePipeHold);
assign lrE2 = (exeBrAndLink | (lrSel & exeMtsprL2)) &
                ~(PCL_sprHold | tracePipeHold);

// ctr equations.
//assign ctrE1 = coreResetL2 |
//             (exeBcL2 & ~exeDataBO_2) | (ctrSel & exeMtsprL2);
//assign ctrE2 = coreResetL2 | ~(PCL_sprHold | tracePipeHold);
assign ctrE2 = coreResetL2 |
               ((exeBcL2 & ~exeDataBO_2) | (ctrSel & exeMtsprL2)) &
               ~(PCL_sprHold | tracePipeHold);
assign exeDecCtr = exeBcL2 & ~exeDataBO_2;

// iac equations.
//assign iac1E1 = iac1Sel & exeMtsprL2;
assign iac1E2 = iac1Sel & sprHold_Neg;
//assign iac2E1 = iac2Sel & exeMtsprL2;
assign iac2E2 = iac2Sel & sprHold_Neg;
//assign iac3E1 = iac3Sel & exeMtsprL2;
assign iac3E2 = iac3Sel & sprHold_Neg;
//assign iac4E1 = iac4Sel & exeMtsprL2;
assign iac4E2 = iac4Sel & sprHold_Neg;

// usprg0 equations. (for VMX)
//assign usprg0E1 = usprg0Sel & exeMtsprL2;
assign usprg0E2 = usprg0Sel & sprHold_Neg;

// sprg0-3 equations.
//assign sprg0E1 = sprg0Sel & exeMtsprL2;
assign sprg0E2 = sprg0Sel & sprHold_Neg;
//assign sprg1E1 = sprg1Sel & exeMtsprL2;
assign sprg1E2 = sprg1Sel & sprHold_Neg;
//assign sprg2E1 = sprg2Sel & exeMtsprL2;
assign sprg2E2 = sprg2Sel & sprHold_Neg;
//assign sprg3E1 = sprg3Sel & exeMtsprL2;
assign sprg3E2 = sprg3Sel & sprHold_Neg;
//assign sprg4E1 = sprg4WrSel & exeMtsprL2;
assign sprg4E2 = sprg4WrSel & sprHold_Neg;
//assign sprg5E1 = sprg5WrSel & exeMtsprL2;
assign sprg5E2 = sprg5WrSel & sprHold_Neg;
//assign sprg6E1 = sprg6WrSel & exeMtsprL2;
assign sprg6E2 = sprg6WrSel & sprHold_Neg;
//assign sprg7E1 = sprg7WrSel & exeMtsprL2;
assign sprg7E2 = sprg7WrSel & sprHold_Neg;

// srr0,2 equations.
assign srr0E2 = (exeMtsprL2 & srr0Sel & ~PCL_sprHold) |
                  (VCT_swap01 & swapEnable);
assign srr2E2 = (exeMtsprL2 & srr2Sel & ~PCL_sprHold) |
                  (VCT_swap23 & swapEnable);

assign srr0InMuxSel = VCT_swap01 & swapEnable;
assign srr2InMuxSel = VCT_swap23 & swapEnable;

// Input to wb stage register for Trace.
assign exeMtLr = lrSel & exeMtsprL2;
assign exeMtCtr = ctrSel & exeMtsprL2;


//Removed the module 'ctrCompareEqs'
assign nxtCtrEq1 = nxtCtr == 32'h00000001;
assign nxtCtrEq2 = nxtCtr == 32'h00000002;

//Removed the module 'dp_muxIFB_ctr'
assign nxtCtr[0:31] = ctr_mux;
always @(coreResetL2 or exeDecCtr or EXE_sprDataBus or cdsbus1)
  case({coreResetL2, exeDecCtr})
    2'b00: ctr_mux = EXE_sprDataBus[0:31];
    2'b01: ctr_mux = cdsbus1[0:31];
    2'b10: ctr_mux = 32'hffffffff;
    2'b11: ctr_mux = 32'hffffffff;
    default: ctr_mux = 32'bx;
  endcase

//Removed the module 'dp_muxIFB_sprGroup2'
assign sprGroup2[0:31] = sprGroup2_mux;
always @(sprGroup2Sel or sprg04 or sprg57 or srr02 or usprg0)
  case(sprGroup2Sel[0:1])
    2'b00: sprGroup2_mux = sprg04;
    2'b01: sprGroup2_mux = sprg57;
    2'b10: sprGroup2_mux = {srr02[0:29], 2'b0};
    2'b11: sprGroup2_mux = usprg0;
    default: sprGroup2_mux = 32'bx;
  endcase

//Removed the module 'dp_muxIFB_sprGroup1'
assign sprGroup1 = sprGroup1_mux;
always @(sprGroup1Sel or crL2 or evprL2_int or linkL2_int or ctrL2_int)
  case(sprGroup1Sel)
    2'b00: sprGroup1_mux = crL2;
    2'b01: sprGroup1_mux =  {evprL2_int[0:15], 16'b0};
    2'b10: sprGroup1_mux = linkL2_int;
    2'b11: sprGroup1_mux = ctrL2_int;
    default: sprGroup1_mux = 32'bx;
  endcase

//Removed the module 'dp_muxIFB_ifbSprs'
assign IFB_sprDataBus = sprDataBus_mux;
always @(ifbSprsSel or EXE_sprDataBus or iac04 or sprGroup1 or sprGroup2)
  case(ifbSprsSel)
    2'b00: sprDataBus_mux = EXE_sprDataBus;
    2'b01: sprDataBus_mux = {iac04[0:29], 2'b0};
    2'b10: sprDataBus_mux = sprGroup1;
    2'b11: sprDataBus_mux = sprGroup2;
    default: sprDataBus_mux = 32'bx;
  endcase

//Removed the module 'dp_regIFB_evpr'
assign evprL2_int = evpr_Reg;
//posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & evprE2)
    1'b0: evpr_Reg <= evpr_Reg;
    1'b1: evpr_Reg <= EXE_sprDataBus[0:15];
    default: evpr_Reg <= 16'bx;
  endcase

//Removed the module 'dp_muxIFB_iacSpr'
assign iac04 = iacSpr_mux;
always @(iacGroupSel or iac1L2_int or iac2L2_int or iac3L2_int or iac4L2_int)
   case(iacGroupSel)
     2'b00: iacSpr_mux = iac1L2_int;
     2'b01: iacSpr_mux = iac2L2_int;
     2'b10: iacSpr_mux = iac3L2_int;
     2'b11: iacSpr_mux = iac4L2_int;
     default: iacSpr_mux = 30'bx;
   endcase

//Removed the module 'dp_muxIFB_sprg47'
assign sprg57 = sprg47_mux;
always @(sprg47GroupSel or sprg4L2 or sprg5L2 or sprg6L2 or sprg7L2)
   case(sprg47GroupSel)
     2'b00: sprg47_mux = sprg4L2;
     2'b01: sprg47_mux = sprg5L2;
     2'b10: sprg47_mux = sprg6L2;
     2'b11: sprg47_mux = sprg7L2;
     default: sprg47_mux = 32'bx;
   endcase

//Removed the module 'dp_muxIFB_sprg03'
assign sprg04 = sprg03_mux;
always @(sprg03GroupSel or sprg0L2 or sprg1L2 or sprg2L2 or sprg3L2)
   case(sprg03GroupSel)
     2'b00: sprg03_mux = sprg0L2;
     2'b01: sprg03_mux = sprg1L2;
     2'b10: sprg03_mux = sprg2L2;
     2'b11: sprg03_mux = sprg3L2;
     default: sprg03_mux = 32'bx;
   endcase

assign srr2L2 = srr2_Reg;
//Removed the module 'dp_regIFB_srr2'
// 2-1 Mux input to register
always @(EXE_sprDataBus or refetchPipeAddr or srr2InMuxSel)
  casez(srr2InMuxSel)
    1'b0: srr2_Reg_next = EXE_sprDataBus[0:29];
    1'b1: srr2_Reg_next = refetchPipeAddr[0:29];
    default: srr2_Reg_next = 30'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(srr2E2)
    1'b0: srr2_Reg <= srr2_Reg;
    1'b1: srr2_Reg <= srr2_Reg_next;
    default: srr2_Reg <= 30'bx;
  endcase


//Removed the module 'dp_regIFB_srr0'
assign srr0L2 = srr0_Reg;
// 2-1 Mux input to register
always @(EXE_sprDataBus or refetchPipeAddr or srr0InMuxSel)
  casez(srr0InMuxSel)
    1'b0: srr0_Reg_next = EXE_sprDataBus[0:29];
    1'b1: srr0_Reg_next = refetchPipeAddr[0:29];
    default: srr0_Reg_next = 30'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(srr0E2)
    1'b0: srr0_Reg <= srr0_Reg;
    1'b1: srr0_Reg <= srr0_Reg_next;
    default: srr0_Reg <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_Iac3'
assign iac3L2_int = Iac3_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & iac3E2)
    1'b0: Iac3_Reg <= Iac3_Reg;
    1'b1: Iac3_Reg <= EXE_sprDataBus[0:29];
    default: Iac3_Reg <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_Iac2'
assign iac2L2_int = Iac2_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & iac2E2)
    1'b0: Iac2_Reg <= Iac2_Reg;
    1'b1: Iac2_Reg <= EXE_sprDataBus[0:29];
    default: Iac2_Reg <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_Iac1'
assign iac1L2_int = Iac1_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & iac1E2)
    1'b0: Iac1_Reg <= Iac1_Reg;
    1'b1: Iac1_Reg <= EXE_sprDataBus[0:29];
    default: Iac1_Reg <= 30'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg7'
assign sprg7L2 = sprg7_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg7E2)
    1'b0: sprg7_Reg <= sprg7_Reg;
    1'b1: sprg7_Reg <= EXE_sprDataBus[0:31];
    default: sprg7_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg6'
assign sprg6L2 = sprg6_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg6E2)
    1'b0: sprg6_Reg <= sprg6_Reg;
    1'b1: sprg6_Reg <= EXE_sprDataBus[0:31];
    default: sprg6_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg5'
assign sprg5L2 = sprg5_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg5E2)
    1'b0: sprg5_Reg <= sprg5_Reg;
    1'b1: sprg5_Reg <= EXE_sprDataBus[0:31];
    default: sprg5_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg4'
assign sprg4L2 = sprg4_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg4E2)
    1'b0: sprg4_Reg <= sprg4_Reg;
    1'b1: sprg4_Reg <= EXE_sprDataBus[0:31];
    default: sprg4_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg3'
assign sprg3L2 = sprg3_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg3E2)
    1'b0: sprg3_Reg <= sprg3_Reg;
    1'b1: sprg3_Reg <= EXE_sprDataBus[0:31];
    default: sprg3_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg2'
assign sprg2L2 = sprg2_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg2E2)
    1'b0: sprg2_Reg <= sprg2_Reg;
    1'b1: sprg2_Reg <= EXE_sprDataBus[0:31];
    default: sprg2_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg1'
assign sprg1L2 = sprg1_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg1E2)
    1'b0: sprg1_Reg <= sprg1_Reg;
    1'b1: sprg1_Reg <= EXE_sprDataBus[0:31];
    default: sprg1_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_regSprg0'
assign sprg0L2 = sprg0_Reg;
// posedge FF
always @(posedge CB)
  casez(exeMtsprL2 & sprg0E2)
    1'b0: sprg0_Reg <= sprg0_Reg;
    1'b1: sprg0_Reg <= EXE_sprDataBus[0:31];
    default: sprg0_Reg <= 32'bx;
  endcase

//Removed the module 'dp_regIFB_ctrCompares'
assign {ctrEq1, ctrEq2} = ctrCompares_Reg;
// posedge FF
always @(posedge CB)
  casez(ctrE2)
    1'b0: ctrCompares_Reg <= ctrCompares_Reg;
    1'b1: ctrCompares_Reg <= {nxtCtrEq1, nxtCtrEq2};
    default: ctrCompares_Reg <= 2'bx;
  endcase

//Removed the module 'dp_regIFB_ctr'
assign ctrL2_int = ctr_Reg;
// posedge FF
always @(posedge CB)
  casez(ctrE2)
    1'b0: ctr_Reg <= ctr_Reg;
    1'b1: ctr_Reg <= nxtCtr;
    default: ctr_Reg <= 32'bx;
  endcase

assign linkL2_int = link_Reg;
//Removed the module 'dp_regIFB_link'
// 2-1 Mux input to register
always @(EXE_sprDataBus or cdsbus0 or exeBrAndLink)
  casez(exeBrAndLink)
    1'b0: link_Reg_next = EXE_sprDataBus[0:31];
    1'b1: link_Reg_next = {cdsbus0[0:29], 2'b0};
    default: link_Reg_next = 32'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(lrE2)
    1'b0: link_Reg <= link_Reg;
    1'b1: link_Reg <= link_Reg_next;
    default: link_Reg <= 32'bx;
  endcase


endmodule
