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

module p405s_adm_top( EXE_admMco, EXE_divMco, EXE_multMco, aRegMuxSel, aRegZ4dndSEIn,
     addCA, addOV, admCcBits, admCcMuxSel, admOut, bRegMuxSel,
     divNxtToLastSt, divOV, divPathEn, macOV, macOVSat_NEG, macSatValue,
     multHiEOAnsCc, multLo4CycAnsCc, multLo5CycAnsCc, multOV, nxtQ, nxtQ_NEG,
     resetL2, sRegMuxSel, srmMuxSel, trap, CB, LSSD_coreTestEn,
     PCL_aPortRregBypass, PCL_addFour, PCL_bPortLitGenSel, PCL_bPortRregBypass,
     PCL_dcdAregLoadUse, PCL_dcdBregLoadUse, PCL_dcdHotCIn, PCL_dcdMdSelQ, PCL_dcdMrSelQ,
     PCL_dcdSregLoadUse, PCL_dcdSrmBpSel, PCL_dcdXerCa, PCL_exe2AccRegMuxSel,
     PCL_exe2Hold, PCL_exe2MacEn, PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG,
     PCL_exe2MacSat, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp,
     PCL_exe2XerOvEn, PCL_exeAddSgndOp_NEG, PCL_exeAdmCntl, PCL_exeAregLoadUse,
     PCL_exeBregLoadUse, PCL_exeCmplmntA, PCL_exeCmplmntA_NEG, PCL_exeDivEn,
     PCL_exeDivEnForLSSD, PCL_exeDivEnForMuxSel, PCL_exeDivEn_NEG, PCL_exeDivSgndOp,
     PCL_exeDvcHold, PCL_exeLoadUseHold, PCL_exeMacEn, PCL_exeMultEn,
     PCL_exeMultEnForMuxSel, PCL_exeMultEn_NEG, PCL_exeNegMac, PCL_exeSregLoadUse,
     PCL_exeSrmBpSel, PCL_exeXerOvEn, PCL_gateZeroToAreg, PCL_gateZeroToSreg, PCL_holdCIn,
     PCL_holdMdMr, PCL_sPortRregBypass, PCL_wbHold, aReg_NEG, bReg_NEG,
     coreReset, deterministicMult, exeMacOrMultEn_NEG, nxtXerCa, rRegBypassForAccReg,
     sBus, trapCond, PCL_exeDvcOrParityHold);
output  EXE_admMco, EXE_divMco, EXE_multMco, addCA, addOV, divNxtToLastSt, divOV,
     divPathEn, macOV, macOVSat_NEG, multOV, nxtQ, nxtQ_NEG, resetL2, trap;


input  LSSD_coreTestEn, PCL_aPortRregBypass, PCL_addFour, PCL_bPortLitGenSel,
     PCL_bPortRregBypass, PCL_dcdAregLoadUse, PCL_dcdBregLoadUse, PCL_dcdHotCIn, PCL_dcdMdSelQ,
     PCL_dcdMrSelQ, PCL_dcdSregLoadUse, PCL_dcdXerCa, PCL_exe2Hold, PCL_exe2MacEn,
     PCL_exe2MacSat, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp,
     PCL_exe2XerOvEn, PCL_exeAregLoadUse, PCL_exeBregLoadUse, PCL_exeCmplmntA,
     PCL_exeCmplmntA_NEG, PCL_exeDivEn, PCL_exeDivEnForLSSD, PCL_exeDivEn_NEG,
     PCL_exeDivSgndOp, PCL_exeDvcHold, PCL_exeLoadUseHold, PCL_exeMacEn, PCL_exeMultEn,
     PCL_exeNegMac, PCL_exeSregLoadUse, PCL_exeXerOvEn, PCL_gateZeroToAreg, PCL_gateZeroToSreg,
     PCL_holdCIn, PCL_holdMdMr, PCL_sPortRregBypass, PCL_wbHold, coreReset,
     deterministicMult, exeMacOrMultEn_NEG, nxtXerCa, PCL_exeDvcOrParityHold;

output [0:2]  multLo5CycAnsCc;
output [0:2]  multLo4CycAnsCc;
output [0:1]  sRegMuxSel;
output [0:1]  bRegMuxSel;
output [0:2]  macSatValue;
output [0:4]  aRegZ4dndSEIn;
output [0:5]  srmMuxSel;
output [0:31]  admOut;
output [0:1]  admCcMuxSel;
output [0:2]  multHiEOAnsCc;
output [0:2]  admCcBits;
output [0:1]  aRegMuxSel;


input [0:1]  PCL_exeDivEnForMuxSel;
input [0:4]  trapCond;
input [0:31]  aReg_NEG;
input [0:1]  PCL_exeAddSgndOp_NEG;
input [0:1]  PCL_exe2MacOrMultEnForMS;
input [0:2]  PCL_exeSrmBpSel;
input [0:2]  PCL_dcdSrmBpSel;
input [0:1]  PCL_exe2MacOrMultEn_NEG;
input [0:1]  PCL_exeMultEnForMuxSel;
input [0:31]  bReg_NEG;
//input [0:4]  CB;
input CB;
input [0:1]  PCL_exe2AccRegMuxSel;
input [0:1]  PCL_exeMultEn_NEG;
input [0:31]  sBus;
input [0:31]  rRegBypassForAccReg;
input [0:3]  PCL_exeAdmCntl;

// Buses in the design

wire  [0:31]  bBusNeg;

wire  [0:16]  MMD;

wire  [0:32]  wtPS;

wire  [0:1]  tczPSHiMuxSel;

wire  [0:1]  tczPCHiMuxSel;

wire  [0:31]  NbBus;

wire  [0:15]  MR_NEG;

wire  [0:1]  admAdderBInMuxSel;

//wire  [0:16]  RS_L2;

wire  [0:31]  RS;

wire  [0:1]  admOutMuxSel;

wire  [0:31]  bInBuf;

//wire  [0:15]  multLWAnsLo;

wire  [0:15]  multLoAnsHi;

wire  [0:31]  aInBuf;

wire  [0:31]  aBusNeg;

wire  [0:1]  macRsLoEn;

wire  [0:15]  MD_NEG;

wire  [0:31]  RC;

//wire  [0:15]  multLWAnsHi;

//wire  [0:31]  aIn_NEG;

wire  [0:31]  NaBus;

wire  [0:1]  admAdderAInMuxSel;

wire  [0:32]  wtPC;

wire  [0:31]  bBusBuf;

wire  [0:31]  aBusBuf;

wire  [0:31]  multHWAns;

wire  [1:16]  adderOut_NEG;

wire  [0:15]  MD;

wire  [0:15]  MR;

wire  [0:32]  PS_NEG;

//wire  [0:32]  PC_L2;

//wire  [0:31]  macAccL2;

wire  [17:32]  adderOutBuf;

wire  [0:32]  PS;

wire  [1:32]  PC;

wire  [1:32]  PC_NEG;

//wire  [0:16]  RC_L2;

wire  [0:1]  macRcLoEn;

wire  [0:32]  macCarry;

wire  [0:31]  bIn;

wire  [0:31]  aIn;

wire  [0:31]  bIn_NEG;

wire  [0:32]  macSum;

//wire  [0:32]  PS_L2;

wire  [0:1]  nxtMultSt;

reg  [0:1]  divLastStOrSt0L2_NEG;

wire  [0:1]  nxtMultCntr;

reg  [0:5]  divSt;

wire  [0:5]  nxtDivSt;

//wire  [0:1]  multSt;

//wire  [0:1]  multCntr;

wire  [0:32]  adderOut;
// Wires added for instantiation
wire sgndOpNotZero;
wire bSE;
//wire aSe_NEG;
wire bSe_NEG;
wire exe2MacE1;
wire exe2MacE2;
wire accRegE1;
wire multLoAnsMuxSel;
wire macRsHiEn;
wire macRcHiEn;
wire tcPSLoMuxSel;
wire tcPCLoMuxSel;
wire macMrMuxSel;
wire macMdMuxSel;
wire NbSE;
wire NaSE;
wire multLWAnsHiE1;
wire multLWAnsLoE1;
wire multStE1;
wire multStE2;
wire divStE1;
wire divStE2;
//wire divLastStOrSt0L2;
wire nxtSt0Or1;
wire aOut1Inv1;
wire exe2SignedOp_NEG;
wire aOut1Inv2;
wire exe2Mult16x32_NEG;
wire exe2Mult16x16Signed_NEG;
wire exe2Mult16x32;
wire exe2Mult16x16Signed;
wire md2CompEn;
wire nxtSt1;
wire nxtSt1_NEG;
wire nxtLastStOrSt0;
wire nxtLastStOrSt0_NEG;
wire lastCycSgnMd;

wire adderOutBit0_C, cInBit1, cIn_1, dndSE_NEG, exe2MacProdSgndL2, exe2MacSatUnsigned;
wire exe2Md16BitOprndL2, exe2Mr16BitOprndL2, potSOV,sumBit1,CO16, adderOutBit0_B;
wire adderOutBit1_B, adderOutBit1_C, adderOutBit17_B, adderOutBit16_B;
wire CIn, aSeIn, bSeIn, N_OP, N_ZP, OPLo16, ZPLo16, mdSgn, mrSgn, firstCycSgnMd;
wire symNet539, symNet541, symNet542,symNet540, symNet545, ZPHi16, OPHi16;

reg [0:16] RC_L2;
reg [0:16] RS_L2;
reg [0:31] macAccL2;
reg [16:31] regEXE_accRegLo_muxout;
reg [0:15] regEXE_accRegHi_muxout;
reg [0:32] PS_L2;
reg [8:16] regEXE_macPSMid_muxout;
reg [0:32] PC_L2;
reg [8:16] regEXE_macPCMid_muxout;
reg [0:7] regEXE_macPSHi_muxout;
reg [17:32] regEXE_macPSLo_muxout;
reg [17:32] regEXE_macPCLo_muxout;
reg [0:7] regEXE_macPCHi_muxout;
reg [1:17] muxEXE_admAdderBInHi_muxout;
reg [16:31] muxEXE_admAdderBInLo_muxout;
reg [0:31] aIn_NEG;
reg [0:15] multLWAnsHi;
reg [0:15] multLWAnsLo;
reg [0:1] multSt;
reg [0:1] multCntr;
reg divSt0Or1;
reg divSt1_NEG;
reg divLastStOrSt0L2_1;
reg divLastStOrSt0L2;
reg aSe_NEG;



//specify
//    specparam CDS_LIBNAME  = "PR_exe";
//    specparam CDS_CELLNAME = "adm_top";
//    specparam CDS_VIEWNAME = "schematic";
//endspecify

p405s_sdtGates
 sdtGateSch(
  .aRegZ4dndSEIn(aRegZ4dndSEIn[0:4]),
  .admAdderAInMuxSel(admAdderAInMuxSel[0:1]),
  .admAdderBInMuxSel(admAdderBInMuxSel[0:1]),
  .admCcMuxSel(admCcMuxSel[0:1]),
  .macOVSat_NEG(macOVSat_NEG),
  .macSatValue(macSatValue[0:2]),
  .PCL_addFour(PCL_addFour),
  .PCL_exe2MacOrMultEnForMS(PCL_exe2MacOrMultEnForMS[0:1]),
  .PCL_exe2MacOrMultEn_NEG(PCL_exe2MacOrMultEn_NEG[0:1]),
  .PCL_exe2MultEn(PCL_exe2MultEn),
  .PCL_exe2MultHiWd(PCL_exe2MultHiWd),
  .PCL_exe2SignedOp(PCL_exe2SignedOp),
  .PCL_exe2XerOvEn(PCL_exe2XerOvEn),
  .PCL_exeCmplmntA_NEG(PCL_exeCmplmntA_NEG),
  .PCL_exeDivEnForMuxSel(PCL_exeDivEnForMuxSel[0:1]),
  .PCL_exeMultEnForMuxSel(PCL_exeMultEnForMuxSel[0:1]),
  .PCL_exeMultEn_NEG(PCL_exeMultEn_NEG[0:1]),
  .adderOutBit0(adderOutBit0_C),
  .cInBit1(cInBit1),
  .cIn_1(cIn_1),
  .divLastStOrSt0L2_1(divLastStOrSt0L2_1),
  .divLastStOrSt0L2_NEG(divLastStOrSt0L2_NEG[0]),
  .dndSE_NEG(dndSE_NEG),
  .exe2MacProdSgndL2(exe2MacProdSgndL2),
  .exe2MacSatUnsigned(exe2MacSatUnsigned),
  .exe2Md16BitOprndL2(exe2Md16BitOprndL2),
  .exe2Mr16BitOprndL2(exe2Mr16BitOprndL2),
  .macAccL2Bit0(macAccL2[0]),
  .potSOV(potSOV),
  .sumBit1(sumBit1));

//dp_muxEXE_bBusForLSSD muxEXE_bBusForLSSD(bBusNeg[0:31], bBusBuf[0:31], LSSD_coreTestEn,
//     NbBus[0:31]);
// Removed the module 'dp_muxEXE_bBusForLSSD'
assign NbBus[0:31] = (bBusNeg[0:31] & {(32){~(LSSD_coreTestEn)}} ) | (bBusBuf[0:31] & {(32){LSSD_coreTestEn}} );
//dp_muxEXE_aBusForLSSD muxEXE_aBusForLSSD(aBusNeg[0:31], aBusBuf[0:31], LSSD_coreTestEn,
//     NaBus[0:31]);
// Removed the module 'dp_muxEXE_aBusForLSSD'
assign NaBus[0:31] = (aBusNeg[0:31] & {(32){~(LSSD_coreTestEn)}} ) | (aBusBuf[0:31] & {(32){LSSD_coreTestEn}} );
//dp_logEXE_mdNAND2CINV logEXE_mdNAND2CINV(MD_NEG[0:15], exeMacOrMultEn_NEG, MD[0:15]);
// Removed the module 'dp_logEXE_mdNAND2CINV'
assign MD[0:15] = ~(MD_NEG[0:15] & ~({(16){exeMacOrMultEn_NEG}}) );
//dp_logEXE_mrNAND2CINV logEXE_mrNAND2CINV(MR_NEG[0:15], exeMacOrMultEn_NEG, MR[0:15]);
// Removed the module 'dp_logEXE_mrNAND2CINV'
assign MR[0:15] = ~(MR_NEG[0:15] & ~({(16){exeMacOrMultEn_NEG}}) );

wire addCA, addCA_i;
assign addCA = addCA_i;
p405s_SM_ADD33CICO16_P2
 adder(
  .CO(addCA_i),
  .CO16(CO16),
  .CO30(cInBit1),
  .SUM32_B(adderOutBit0_B),
  .SUM32_C(adderOutBit0_C),
  .SUM31_B(adderOutBit1_B),
  .SUM31_C(adderOutBit1_C),
  .SUM15_B(adderOutBit17_B),
  .SUM16_B(adderOutBit16_B),
  .SUM(adderOut[0:32]),
  .CI(CIn),
  .A({aSeIn,aIn[0:31]}),
  .B({bSeIn,bIn[0:31]}));

//dp_logEXE_PCINV1 logEXE_PCINV1(wtPC[1:32], PC_NEG[1:32]);
// Removed the module 'dp_logEXE_PCINV1'
assign PC_NEG[1:32] = ~(wtPC[1:32]);
//dp_logEXE_PCINV2 logEXE_PCINV2(PC_NEG[1:32], PC[1:32]);
// Removed the module 'dp_logEXE_PCINV2'
assign PC[1:32] = ~(PC_NEG[1:32]);
//dp_logEXE_PSINV2 logEXE_PSINV2(PS_NEG[0:32], PS[0:32]);
// Removed the module 'dp_logEXE_PSINV2'
assign PS[0:32] = ~(PS_NEG[0:32]);
//dp_logEXE_PSINV1 logEXE_PSINV1(wtPS[0:32], PS_NEG[0:32]);
// Removed the module 'dp_logEXE_PSINV1'
assign PS_NEG[0:32] = ~(wtPS[0:32]);
//dp_logEXE_admBregINV logEXE_admBregINV(bReg_NEG[0:31], bBusBuf[0:31]);
// Removed the module 'dp_logEXE_admBregINV'
assign bBusBuf[0:31] = ~(bReg_NEG[0:31]);
//dp_logEXE_admAregINV logEXE_admAregINV(aReg_NEG[0:31], aBusBuf[0:31]);
// Removed the module 'dp_logEXE_admAregINV'
assign aBusBuf[0:31] = ~(aReg_NEG[0:31]);

p405s_zeroOnePredict
 ZOP(
.N_OP(N_OP),
.N_ZP(N_ZP),
.OPLo16(OPLo16),
.ZPLo16(ZPLo16),
.aIn(aInBuf[0:31]),
.bIn(bInBuf[0:31]),
.cIn(CIn));

//dp_logEXE_admAInInv2 logEXE_admAInInv2({aSe_NEG, aIn_NEG[0:31]}, {aSeIn, aIn[0:31]});
// Removed the module 'dp_logEXE_admAInInv2'
assign {aSeIn, aIn[0:31]} = ~({aSe_NEG, aIn_NEG[0:31]});
//dp_logEXE_admBInInv2 logEXE_admBInInv2({bSe_NEG, bIn_NEG[0:31]}, {bSeIn, bIn[0:31]});
// Removed the module 'dp_logEXE_admBInInv2'
assign {bSeIn, bIn[0:31]} = ~({bSe_NEG, bIn_NEG[0:31]});
//dp_logEXE_admAInInv1 logEXE_admAInInv1(aIn_NEG[0:31], aInBuf[0:31]);
// Removed the module 'dp_logEXE_admAInInv1'
assign aInBuf[0:31] = ~(aIn_NEG[0:31]);
//dp_logEXE_admBInInv1 logEXE_admBInInv1(bIn_NEG[0:31], bInBuf[0:31]);
// Removed the module 'dp_logEXE_admBInInv1'
assign bInBuf[0:31] = ~(bIn_NEG[0:31]);
   // Replacing instantiation: GTECH_NOT I577
   assign nxtSt1_NEG = ~(nxtSt1);

   // Replacing instantiation: GTECH_NOT I552
   assign nxtLastStOrSt0_NEG = ~(nxtLastStOrSt0);

//dp_regEXE_macRCHi regEXE_macRCHi(CB[0:4], PC[1:17], exe2MacE1, exe2MacE2, macRSHiSO,
//     RC_L2[0:16], SO);
// Removed the module 'dp_regEXE_macRCHi'
always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: RC_L2[0:16] <= RC_L2[0:16];                
     1'b1: RC_L2[0:16] <= PC[1:17];            
      default: RC_L2[0:16] <= 17'bx;  
    endcase                             
   end   
//dp_regEXE_macRSHi regEXE_macRSHi(CB[0:4], PS[0:16], exe2MacE1, exe2MacE2, macPCLoSO,
//     RS_L2[0:16], macRSHiSO);
// Removed the module 'dp_regEXE_macRSHi'
always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: RS_L2[0:16] <= RS_L2[0:16];                
     1'b1: RS_L2[0:16] <= PS[0:16];            
      default: RS_L2[0:16] <= 17'bx;  
    endcase                             
   end   
//dp_regEXE_accRegLo regEXE_accRegLo(CB[0:4], sBus[16:31], rRegBypassForAccReg[16:31],
//     {1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1}, {1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, accRegE1, exe2MacE2, accRegHiSO,
//     PCL_exe2AccRegMuxSel[0:1], macAccL2[16:31], accRegLoSO);
// Removed the module 'dp_regEXE_accRegLo'
always @(sBus or rRegBypassForAccReg or PCL_exe2AccRegMuxSel)
    begin                                       
    casez(PCL_exe2AccRegMuxSel[0:1])                    
     2'b00: regEXE_accRegLo_muxout = sBus[16:31];
     2'b01: regEXE_accRegLo_muxout = rRegBypassForAccReg[16:31];  
     2'b10: regEXE_accRegLo_muxout = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1};  
     2'b11: regEXE_accRegLo_muxout = {1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
      default: regEXE_accRegLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((accRegE1 & exe2MacE2))                        
     1'b0: macAccL2[16:31] <= macAccL2[16:31];                
     1'b1: macAccL2[16:31] <= regEXE_accRegLo_muxout;       
      default: macAccL2[16:31] <= 16'bx;  
    endcase                             
   end   
//dp_regEXE_accRegHi regEXE_accRegHi(CB[0:4], sBus[0:15], rRegBypassForAccReg[0:15],
//     {1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1}, {1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, accRegE1, exe2MacE2, multLWAnsHiSO,
//     PCL_exe2AccRegMuxSel[0:1], macAccL2[0:15], accRegHiSO);
// Removed the module 'dp_regEXE_accRegHi'
always @(sBus or rRegBypassForAccReg or PCL_exe2AccRegMuxSel)
    begin                                       
    casez(PCL_exe2AccRegMuxSel[0:1])                    
     2'b00: regEXE_accRegHi_muxout = sBus[0:15];
     2'b01: regEXE_accRegHi_muxout = rRegBypassForAccReg[0:15];  
     2'b10: regEXE_accRegHi_muxout = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
     1'b1};  
     2'b11: regEXE_accRegHi_muxout = {1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
      default: regEXE_accRegHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((accRegE1 & exe2MacE2))                        
     1'b0: macAccL2[0:15] <= macAccL2[0:15];                
     1'b1: macAccL2[0:15] <= regEXE_accRegHi_muxout;       
      default: macAccL2[0:15] <= 16'bx;  
    endcase                             
   end 

//dp_regEXE_macPSMid regEXE_macPSMid(CB[0:4], PS[8:16], PS_NEG[8:16], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, exe2MacE1, exe2MacE2, macPSHiSO,
//     tczPCHiMuxSel[0:1], PS_L2[8:16], macPSMidSO);
// Removed the module 'dp_regEXE_macPSMid'
 always @(PS or PS_NEG or tczPCHiMuxSel)
    begin                                       
    casez(tczPCHiMuxSel[0:1])                    
     2'b00: regEXE_macPSMid_muxout = PS[8:16];
     2'b01: regEXE_macPSMid_muxout = PS_NEG[8:16]; 
     2'b10: regEXE_macPSMid_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
     2'b11: regEXE_macPSMid_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
      default: regEXE_macPSMid_muxout = 9'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: PS_L2[8:16] <= PS_L2[8:16];                
     1'b1: PS_L2[8:16] <= regEXE_macPSMid_muxout;       
      default: PS_L2[8:16] <= 9'bx;  
    endcase                             
   end     

//dp_regEXE_macPCMid regEXE_macPCMid(CB[0:4], PC[9:17], PC_NEG[9:17], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, exe2MacE1, exe2MacE2, macPCHiSO,
//     tczPCHiMuxSel[0:1], PC_L2[8:16], macPCMidSO);
// Removed the module 'dp_regEXE_macPCMid'
always @(PC or PC_NEG or tczPCHiMuxSel)
    begin                                       
    casez(tczPCHiMuxSel[0:1])                    
     2'b00: regEXE_macPCMid_muxout = PC[9:17];
     2'b01: regEXE_macPCMid_muxout = PC_NEG[9:17];  
     2'b10: regEXE_macPCMid_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
     2'b11: regEXE_macPCMid_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0};  
      default: regEXE_macPCMid_muxout = 9'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: PC_L2[8:16] <= PC_L2[8:16];                
     1'b1: PC_L2[8:16] <= regEXE_macPCMid_muxout;       
      default: PC_L2[8:16] <= 9'bx;  
    endcase                             
   end      
//dp_logEXE_admAdderHiInv logEXE_admAdderHiInv(adderOut[1:16], adderOut_NEG[1:16]);
// Removed the module 'dp_logEXE_admAdderHiInv'
assign adderOut_NEG[1:16] = ~(adderOut[1:16]);
//dp_logEXE_multHWAnsInInv logEXE_multHWAnsInInv({PCL_exe2SignedOp, adderOutBit1_C,
//     adderOutBit1_C, exe2Mult16x32, exe2Mult16x16Signed}, {exe2SignedOp_NEG, aOut1Inv1,
//     aOut1Inv2, exe2Mult16x32_NEG, exe2Mult16x16Signed_NEG});
// Removed the module 'dp_logEXE_multHWAnsInInv'
assign {exe2SignedOp_NEG, aOut1Inv1, aOut1Inv2, exe2Mult16x32_NEG, exe2Mult16x16Signed_NEG} 
   = ~({PCL_exe2SignedOp, adderOutBit1_C, adderOutBit1_C, exe2Mult16x32, exe2Mult16x16Signed});
//dp_logEXE_multHWAnsLoOAI22 logEXE_multHWAnsLoOAI22({exe2Mult16x16Signed_NEG,
//     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
//     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
//     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
//     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
//     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG}, {aOut1Inv2,
//     aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2,
//     aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2},
//     adderOut_NEG[1:16], {exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
//     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
//     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
//     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
//     exe2Mult16x32_NEG}, multHWAns[16:31]);
// Removed the module 'dp_logEXE_multHWAnsLoOAI22'
assign multHWAns[16:31] = ~( ({exe2Mult16x16Signed_NEG,
     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG,
     exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG, exe2Mult16x16Signed_NEG} | {aOut1Inv2,
     aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2,
     aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2, aOut1Inv2}) & (adderOut_NEG[1:16] | 
     {exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
     exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG, exe2Mult16x32_NEG,
     exe2Mult16x32_NEG}) );
//dp_logEXE_multHWAnsHiNOR2 logEXE_multHWAnsHiNOR2({aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1,
//     aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1,
//     aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1}, {exe2SignedOp_NEG, exe2SignedOp_NEG,
//     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG,
//     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG,
//     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG}, multHWAns[0:15]);
// Removed the module 'dp_logEXE_multHWAnsHiNOR2'
assign multHWAns[0:15] = ~( {aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1,
     aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1,
     aOut1Inv1, aOut1Inv1, aOut1Inv1, aOut1Inv1} | {exe2SignedOp_NEG, exe2SignedOp_NEG,
     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG,
     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG,
     exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG, exe2SignedOp_NEG} );
//dp_muxEXE_multLoAns muxEXE_multLoAns(adderOut[17:32], multLWAnsHi[0:15], multLoAnsMuxSel,
//     multLoAnsHi[0:15]);
// Removed the module 'dp_muxEXE_multLoAns'
assign multLoAnsHi[0:15] = (adderOut[17:32] & {(16){~(multLoAnsMuxSel)}} ) | (multLWAnsHi[0:15] & {(16){multLoAnsMuxSel}} );
//dp_logEXE_macRSHiAND2 logEXE_macRSHiAND2(RS_L2[1:15], {macRsHiEn, macRsHiEn, macRsHiEn,
//     macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn,
//     macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn}, RS[0:14]);
// Removed the module 'dp_logEXE_macRSHiAND2'
assign RS[0:14] = RS_L2[1:15] & {macRsHiEn, macRsHiEn, macRsHiEn,
     macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn,
     macRsHiEn, macRsHiEn, macRsHiEn, macRsHiEn};

//md2Comp md2CompFunc(MD_NEG[0:15], MMD[0:16], md2CompEn, lastCycSgnMd);
// Removed the module 'md2Comp'
assign MMD[0:16] = {(lastCycSgnMd & MD_NEG[0]), MD_NEG[0:15]} + md2CompEn;

//dp_logEXE_macRCLoAO22 logEXE_macRCLoAO22(RC_L2[0:16], {macRcLoEn[1], macRcLoEn[1],
//     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1],
//     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1],
//     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1]}, {macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
//     macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
//     macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
//     macRcLoEn[0], macRcLoEn[0]}, PC_L2[16:32], RC[15:31]);
// Removed the module 'dp_logEXE_macRCLoAO22'
assign RC[15:31] = (RC_L2[0:16] & {macRcLoEn[1], macRcLoEn[1],
     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1],
     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1], macRcLoEn[1],
     macRcLoEn[1], macRcLoEn[1], macRcLoEn[1]}) | ({macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
     macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
     macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0], macRcLoEn[0],
     macRcLoEn[0], macRcLoEn[0]} & PC_L2[16:32]);
//dp_logEXE_macRCHiAND2 logEXE_macRCHiAND2(RC_L2[1:15], {macRcHiEn, macRcHiEn, macRcHiEn,
//     macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn,
//     macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn}, RC[0:14]);
// Removed the module 'dp_logEXE_macRCHiAND2'
assign RC[0:14] = RC_L2[1:15] & {macRcHiEn, macRcHiEn, macRcHiEn,
     macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn,
     macRcHiEn, macRcHiEn, macRcHiEn, macRcHiEn};
//dp_logEXE_macRSLoAO22 logEXE_macRSLoAO22(RS_L2[0:16], {macRsLoEn[1], macRsLoEn[1],
//     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1],
//     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1],
//     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1]}, {macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
//     macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
//     macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
//     macRsLoEn[0], macRsLoEn[0]}, PS_L2[16:32], RS[15:31]);
// Removed the module 'dp_logEXE_macRSLoAO22'
assign RS[15:31] = (RS_L2[0:16] & {macRsLoEn[1], macRsLoEn[1],
     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1],
     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1], macRsLoEn[1],
     macRsLoEn[1], macRsLoEn[1], macRsLoEn[1]}) | ({macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
     macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
     macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0], macRsLoEn[0],
     macRsLoEn[0], macRsLoEn[0]} & PS_L2[16:32]);
//dp_logEXE_compress3To2 logEXE_compress3To2(PC_L2[0:32], PS_L2[0:32], {1'b0,
//     macAccL2[0:31]}, macCarry[0:32], macSum[0:32]);
// Removed the module 'dp_logEXE_compress3To2'
assign macCarry[0:32] = (({1'b0,macAccL2[0:31]} & PS_L2[0:32]) | (({1'b0,macAccL2[0:31]} & PC_L2[0:32]) 
                           | (PS_L2[0:32] & PC_L2[0:32])));  
assign macSum[0:32] = ({1'b0,macAccL2[0:31]} ^ (PS_L2[0:32] ^ PC_L2[0:32]));
//dp_logEXE_admAdderLoBuf logEXE_admAdderLoBuf(adderOut[17:32], adderOutBuf[17:32]);
// Removed the module 'dp_logEXE_admAdderLoBuf'
assign adderOutBuf[17:32] = adderOut[17:32];
//dp_regEXE_macPSHi regEXE_macPSHi(CB[0:4], PS[0:7], PS_NEG[0:7], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, {1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0}, exe2MacE1, exe2MacE2, accRegLoSO, tczPSHiMuxSel[0:1], PS_L2[0:7],
//     macPSHiSO);
// Removed the module 'dp_regEXE_macPSHi'
always @(PS or PS_NEG or tczPSHiMuxSel)
    begin                                       
    casez(tczPSHiMuxSel[0:1])                    
     2'b00: regEXE_macPSHi_muxout = PS[0:7];
     2'b01: regEXE_macPSHi_muxout = PS_NEG[0:7];  
     2'b10: regEXE_macPSHi_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};  
     2'b11: regEXE_macPSHi_muxout = {1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0};  
      default: regEXE_macPSHi_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: PS_L2[0:7] <= PS_L2[0:7];                
     1'b1: PS_L2[0:7] <= regEXE_macPSHi_muxout;       
      default: PS_L2[0:7] <= 8'bx;  
    endcase                             
   end   
//dp_regEXE_macPSLo regEXE_macPSLo(CB[0:4], PS[17:32], PS_NEG[17:32], exe2MacE1, exe2MacE2,
//     macPSMidSO, tcPSLoMuxSel, PS_L2[17:32], macPSLoSO);
// Removed the module 'dp_regEXE_macPSLo'
always @(PS or PS_NEG  or tcPSLoMuxSel)
    begin                                       
    casez(tcPSLoMuxSel)                    
     1'b0: regEXE_macPSLo_muxout = PS[17:32];   
     1'b1: regEXE_macPSLo_muxout = PS_NEG[17:32];   
      default: regEXE_macPSLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2)) 
     1'b0: PS_L2[17:32] <= PS_L2[17:32];                
     1'b1: PS_L2[17:32] <= regEXE_macPSLo_muxout;       
      default: PS_L2[17:32] <= 16'bx;  
    endcase                             
   end     
//dp_regEXE_macPCLo regEXE_macPCLo(CB[0:4], {PC[18:32], PCL_exeNegMac}, {PC_NEG[18:32],
//     PCL_exeNegMac}, exe2MacE1, exe2MacE2, macPCMidSO, tcPCLoMuxSel, PC_L2[17:32], macPCLoSO);
// Removed the module 'dp_regEXE_macPCLo'
always @(PC or PCL_exeNegMac or PC_NEG or tcPCLoMuxSel)
    begin                                       
    casez(tcPCLoMuxSel)                    
     1'b0: regEXE_macPCLo_muxout = {PC[18:32], PCL_exeNegMac};   
     1'b1: regEXE_macPCLo_muxout = {PC_NEG[18:32],PCL_exeNegMac};   
      default: regEXE_macPCLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: PC_L2[17:32] <= PC_L2[17:32];                
     1'b1: PC_L2[17:32] <= regEXE_macPCLo_muxout;       
      default: PC_L2[17:32] <= 16'bx;  
    endcase                             
   end     
//dp_regEXE_macPCHi regEXE_macPCHi(CB[0:4], PC[1:8], PC_NEG[1:8], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, {1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0}, exe2MacE1, exe2MacE2, macPSLoSO, tczPCHiMuxSel[0:1], PC_L2[0:7],
//     macPCHiSO);
// Removed the module 'dp_regEXE_macPCHi'
always @(PC or PC_NEG or tczPCHiMuxSel)
    begin                                       
    casez(tczPCHiMuxSel[0:1])                    
     2'b00: regEXE_macPCHi_muxout = PC[1:8];  
     2'b01: regEXE_macPCHi_muxout = PC_NEG[1:8];  
     2'b10: regEXE_macPCHi_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};  
     2'b11: regEXE_macPCHi_muxout = {1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0};  
      default: regEXE_macPCHi_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((exe2MacE1 & exe2MacE2))                        
     1'b0: PC_L2[0:7] <= PC_L2[0:7];                
     1'b1: PC_L2[0:7] <= regEXE_macPCHi_muxout;       
      default: PC_L2[0:7] <= 8'bx;  
    endcase                             
   end    
//dp_muxEXE_macMr muxEXE_macMr(bBusBuf[16:31], bBusBuf[0:15], macMrMuxSel, MR_NEG[0:15]);
// Removed the module 'dp_muxEXE_macMr'
assign MR_NEG[0:15] = ~( (bBusBuf[16:31] & {(16){~(macMrMuxSel)}} ) | (bBusBuf[0:15] & {(16){macMrMuxSel}} ) );
//dp_muxEXE_macMd muxEXE_macMd(aBusBuf[16:31], aBusBuf[0:15], macMdMuxSel, MD_NEG[0:15]);
// Removed the module 'dp_muxEXE_macMd'
assign MD_NEG[0:15] = ~( (aBusBuf[16:31] & {(16){~(macMdMuxSel)}} ) | (aBusBuf[0:15] & {(16){macMdMuxSel}} ) );
   // Replacing instantiation: GTECH_AO22 I207
   wire nonDivASeEn;
   wire divASeEn;
   reg adderOutSgnBitLtch;
   wire aSE;
   assign aSE = (adderOutSgnBitLtch & divASeEn) | (aBusBuf[0] & nonDivASeEn);

//dp_muxEXE_admAdderBInHi muxEXE_admAdderBInHi({bSE, bBusBuf[0:15]}, {NbSE, NbBus[0:15]},
//     {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, macCarry[1:17], admAdderBInMuxSel[0:1], {bSe_NEG,
//     bIn_NEG[0:15]});
// Removed the module 'dp_muxEXE_admAdderBInHi'
assign {bSe_NEG, bIn_NEG[0:15]} = ~(muxEXE_admAdderBInHi_muxout);
always @(bSE or bBusBuf or NbSE or NbBus or macCarry or admAdderBInMuxSel)
    begin                                           
    case(admAdderBInMuxSel[0:1])                       
     2'b00: muxEXE_admAdderBInHi_muxout = {bSE, bBusBuf[0:15]};
     2'b01: muxEXE_admAdderBInHi_muxout = {NbSE, NbBus[0:15]};   
     2'b10: muxEXE_admAdderBInHi_muxout = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};   
     2'b11: muxEXE_admAdderBInHi_muxout = macCarry[1:17];   
      default: muxEXE_admAdderBInHi_muxout = 17'bx;   
    endcase                                    
   end 

//dp_muxEXE_admAdderBInLo muxEXE_admAdderBInLo(bBusBuf[16:31], NbBus[16:31], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
//     {macCarry[18:32], PC_L2[32]}, admAdderBInMuxSel[0:1], bIn_NEG[16:31]);
// Removed the module 'dp_muxEXE_admAdderBInLo'
assign bIn_NEG[16:31] = ~(muxEXE_admAdderBInLo_muxout);
always @(admAdderBInMuxSel or bBusBuf or NbBus or macCarry or PC_L2)
    begin                                           
    case(admAdderBInMuxSel[0:1])                       
     2'b00: muxEXE_admAdderBInLo_muxout = bBusBuf[16:31];
     2'b01: muxEXE_admAdderBInLo_muxout = NbBus[16:31];   
     2'b10: muxEXE_admAdderBInLo_muxout = {1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0};   
     2'b11: muxEXE_admAdderBInLo_muxout = {macCarry[18:32], PC_L2[32]};   
      default: muxEXE_admAdderBInLo_muxout = 16'bx;   
    endcase                                    
   end   
//dp_muxEXE_admAdderAInLo muxEXE_admAdderAInLo(aBusBuf[16:31], NaBus[16:31], {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
//     macSum[17:32], admAdderAInMuxSel[0:1], aIn_NEG[16:31]);
// Removed the module 'dp_muxEXE_admAdderAInLo'
always @(aBusBuf or NaBus or macSum or admAdderAInMuxSel)
    begin                                           
    case(admAdderAInMuxSel[0:1])                       
     2'b00: aIn_NEG[16:31] = ~(aBusBuf[16:31]);
     2'b01: aIn_NEG[16:31] = ~(NaBus[16:31]);   
     2'b10: aIn_NEG[16:31] = ~({1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0});   
     2'b11: aIn_NEG[16:31] = ~(macSum[17:32]);   
      default: aIn_NEG[16:31] = 16'bx;   
    endcase                                    
   end  
//dp_muxEXE_admAdderAInHi muxEXE_admAdderAInHi({aSE, aBusBuf[0:15]}, {NaSE, NaBus[0:15]},
//     {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, macSum[0:16], admAdderAInMuxSel[0:1], {aSe_NEG,
//     aIn_NEG[0:15]});
// Removed the module 'dp_muxEXE_admAdderAInHi'
always @(aSE or aBusBuf or NaSE or NaBus or macSum or admAdderAInMuxSel)
    begin                                           
    case(admAdderAInMuxSel[0:1])                       
     2'b00: {aSe_NEG,aIn_NEG[0:15]} = ~{aSE, aBusBuf[0:15]};   
     2'b01: {aSe_NEG,aIn_NEG[0:15]} = ~{NaSE, NaBus[0:15]};   
     2'b10: {aSe_NEG,aIn_NEG[0:15]} = ~{1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};   
     2'b11: {aSe_NEG,aIn_NEG[0:15]} = ~macSum[0:16];   
      default: {aSe_NEG,aIn_NEG[0:15]} = 17'bx;   
    endcase                                    
   end 

p405s_SM_wallaceTree
 wallaceTreeMac(
  .PC(wtPC[0:32]),
  .RS(RS[0:31]),
  .MD(MD[0:15]),
  .MR(MR[0:15]),
  .PS(wtPS[0:32]),
  .mdSgn(mdSgn),
  .mrSgn(mrSgn),
  .FSMD(firstCycSgnMd),
  .RC(RC[0:31]),
  .LSMD(lastCycSgnMd),
  .MMD(MMD[0:16]),
  .TE(LSSD_coreTestEn));

//dp_regEXE_multLWAnsHi regEXE_multLWAnsHi(CB[0:4], adderOutBuf[17:32], multLWAnsHiE1,
//     multLWAnsLoSO, multLWAnsHi[0:15], multLWAnsHiSO);
// Removed the module 'dp_regEXE_multLWAnsHi'
always @(posedge CB)      
    begin                                       
    casez(multLWAnsHiE1)                    
     1'b0: multLWAnsHi[0:15] <= multLWAnsHi[0:15];                
     1'b1: multLWAnsHi[0:15] <= adderOutBuf[17:32];
      default: multLWAnsHi[0:15] <= 16'bx;  
    endcase                             
   end
//dp_regEXE_multLWAnsLo regEXE_multLWAnsLo(CB[0:4], adderOutBuf[17:32], multLWAnsLoE1,
//     multStateSO, multLWAnsLo[0:15], multLWAnsLoSO);
// Removed the module 'dp_regEXE_multLWAnsLo'
always @(posedge CB)      
    begin                                       
    casez(multLWAnsLoE1)                    
     1'b0: multLWAnsLo[0:15] <= multLWAnsLo[0:15];                
     1'b1: multLWAnsLo[0:15] <= adderOutBuf[17:32];            
      default: multLWAnsLo[0:15] <= 16'bx;  
    endcase                             
   end 

p405s_admCc
 admCcPla(
  .admCCbits(admCcBits[0:2]),
  .trap(trap),
  .N_zeroDetect(N_ZP),
  .adderOut(adderOut[0:1]),
  .cout(addCA_i),
  .compInstr(PCL_exeAdmCntl[0]),
  .trapInstr(PCL_exeAdmCntl[1]),
  .trapCond(trapCond[0:4]));

p405s_zeroOneDetect
 ZODetect(
  .aBytes01Eq0(symNet539),
  .bBytes23Eq0(symNet541),
  .bBytes01Eq0(symNet542),
  .bBytes01Eq1(symNet540),
  .aBytes01Eq1(symNet545),
  .bBus(bBusBuf[0:31]),
  .aBus(aBusBuf[0:15]),
  .bIn(bInBuf[0:15]),
  .aIn(aInBuf[0:15]),
  .CO16(CO16),
  .ZPHi16(ZPHi16),
  .OPHi16(OPHi16));

//dp_regEXE_multState regEXE_multState(CB[0:4], {nxtMultSt[0:1], nxtMultCntr[0:1]}, multStE1,
//     multStE2, divStateSO, {multSt[0:1], multCntr[0:1]}, multStateSO);
// Removed the module 'dp_regEXE_multState'
always @(posedge CB)      
    begin                                       
    casez(multStE1 & multStE2)
     1'b0: {multSt[0:1], multCntr[0:1]} <= {multSt[0:1], multCntr[0:1]};                
     1'b1: {multSt[0:1], multCntr[0:1]} <= {nxtMultSt[0:1], nxtMultCntr[0:1]}; 
      default: {multSt[0:1], multCntr[0:1]} <= 4'bx;  
    endcase                             
   end 
//dp_regEXE_divState regEXE_divState(CB[0:4], {nxtDivSt[0:5], adderOut[1], nxtLastStOrSt0,
//     nxtLastStOrSt0, nxtLastStOrSt0_NEG, nxtLastStOrSt0_NEG, nxtSt0Or1, nxtSt1_NEG}, divStE1,
//     divStE2, admCntlSO, {divSt[0:5], adderOutSgnBitLtch, divLastStOrSt0L2, divLastStOrSt0L2_1,
//     divLastStOrSt0L2_NEG[0:1], divSt0Or1, divSt1_NEG}, divStateSO);
// Removed the module 'dp_regEXE_divState'
always @(posedge CB)      
    begin                                       
    casez(divStE1 & divStE2)                        
     1'b0: {divSt[0:5], adderOutSgnBitLtch, divLastStOrSt0L2, divLastStOrSt0L2_1,
     divLastStOrSt0L2_NEG[0:1], divSt0Or1, divSt1_NEG} <= {divSt[0:5], adderOutSgnBitLtch, divLastStOrSt0L2, divLastStOrSt0L2_1, divLastStOrSt0L2_NEG[0:1], divSt0Or1, divSt1_NEG};
     1'b1: {divSt[0:5], adderOutSgnBitLtch, divLastStOrSt0L2, divLastStOrSt0L2_1,
     divLastStOrSt0L2_NEG[0:1], divSt0Or1, divSt1_NEG} <= {nxtDivSt[0:5], adderOut[1], nxtLastStOrSt0,
     nxtLastStOrSt0, nxtLastStOrSt0_NEG, nxtLastStOrSt0_NEG, nxtSt0Or1, nxtSt1_NEG};            
      default: {divSt[0:5], adderOutSgnBitLtch, divLastStOrSt0L2, divLastStOrSt0L2_1,
     divLastStOrSt0L2_NEG[0:1], divSt0Or1, divSt1_NEG} <= 13'bx;  
    endcase                             
   end 

wire EXE_multMco, EXE_multMco_i;
assign EXE_multMco = EXE_multMco_i;
wire resetL2, resetL2_i;
assign resetL2 = resetL2_i;
p405s_multSM
 multSMPla(
  .nxtMultSt(nxtMultSt[0:1]),
  .multStE1(multStE1),
  .resetL2(resetL2_i),
  .multEn(PCL_exeMultEn),
  .multMCO(EXE_multMco_i),
  .multSt(multSt[0:1]));

p405s_admCntl
 admCntlFunc(
  .EXE_admMco(EXE_admMco),
  .aRegMuxSel(aRegMuxSel[0:1]),
  .admOutMuxSel(admOutMuxSel[0:1]),
  .multLoAnsMuxSel(multLoAnsMuxSel),
  .bRegMuxSel(bRegMuxSel[0:1]),
  .sgndOpNotZero(sgndOpNotZero),
  .dndSE_NEG(dndSE_NEG),
  .sRegMuxSel(sRegMuxSel[0:1]),
  .addOV(addOV),
  .divOV(divOV),
  .nxtQ(nxtQ),
  .PCL_aPortRregBypass(PCL_aPortRregBypass),
  .PCL_bPortRregBypass(PCL_bPortRregBypass),
  .PCL_exeCmplmntA(PCL_exeCmplmntA),
  .PCL_dcdHotCIn(PCL_dcdHotCIn),
  .PCL_dcdXerCa(PCL_dcdXerCa),
  .PCL_exeDivEn(PCL_exeDivEn),
  .PCL_exeMultEn(PCL_exeMultEn),
  .PCL_sPortRregBypass(PCL_sPortRregBypass),
  .N_ZP(N_ZP),
  .aBytes01Eq0(symNet539),
  .bBytes23Eq0(symNet541),
  .adderOutBit0(adderOutBit0_B),
  .adderOutBit16(adderOutBit17_B),
  .adderOutSgnBit(adderOutBit1_B),
  .coreReset(coreReset),
  .deterministicMult(deterministicMult),
  .divSt(divSt[0:5]),
  .bBusBit0(bBusBuf[0]),
  .sBusBit0(sBus[0]),
  .bBytes01Eq0(symNet542),
  .N_OP(N_OP),
  .multHiWd(PCL_exeAdmCntl[3]),
  .nxtXerCa(nxtXerCa),
  .aBusBit0(aBusBuf[0]),
  .aBusBit16(aBusBuf[16]),
  .bBusBit16(bBusBuf[16]),
  .signedOp(PCL_exeAdmCntl[2]),
  .bBytes01Eq1(symNet540),
  .aBytes01Eq1(symNet545),
  .PCL_holdCIn(PCL_holdCIn),
  .PCL_gateZeroToAreg(PCL_gateZeroToAreg),
  .PCL_gateZeroToSreg(PCL_gateZeroToSreg),
  .PCL_addFour(PCL_addFour),
  .multSt(multSt[0:1]),
  .CB(CB),
  .CIn(CIn),
  .PCL_dcdSrmBpSel(PCL_dcdSrmBpSel[0:2]),
  .srmMuxSel(srmMuxSel[0:5]),
  .multOV(multOV),
  .EXE_multMco(EXE_multMco_i),
  .divStE2(divStE2),
  .multStE2(multStE2),
  .PCL_wbHold(PCL_wbHold),
  .multAnsLoBit0(multLWAnsHi[0]),
  .multLWAnsLoE1(multLWAnsLoE1),
  .multLWAnsHiE1(multLWAnsHiE1),
  .divPathEn(divPathEn),
  .PCL_exeXerOvEn(PCL_exeXerOvEn),
  .PCL_dcdAregLoadUse(PCL_dcdAregLoadUse),
  .PCL_dcdBregLoadUse(PCL_dcdBregLoadUse),
  .PCL_dcdSregLoadUse(PCL_dcdSregLoadUse),
  .PCL_bPortLitGenSel(PCL_bPortLitGenSel),
  .PCL_exeAregLoadUse(PCL_exeAregLoadUse),
  .PCL_exeBregLoadUse(PCL_exeBregLoadUse),
  .PCL_exeSregLoadUse(PCL_exeSregLoadUse),
  .mdSgn(mdSgn),
  .mrSgn(mrSgn),
  .EXE_divMco(EXE_divMco),
  .divASeEn(divASeEn),
  .nonDivASeEn(nonDivASeEn),
  .macMdMuxSel(macMdMuxSel),
  .macMrMuxSel(macMrMuxSel),
  .macRsHiEn(macRsHiEn),
  .macRsLoEn(macRsLoEn[0:1]),
  .lastCycSgnMd(lastCycSgnMd),
  .firstCycSgnMd(firstCycSgnMd),
  .exe2MacE1(exe2MacE1),
  .accRegE1(accRegE1),
  .PCL_dcdMrSelQ(PCL_dcdMrSelQ),
  .PCL_dcdMdSelQ(PCL_dcdMdSelQ),
  .macRcHiEn(macRcHiEn),
  .macRcLoEn(macRcLoEn[0:1]),
  .tczPSHiMuxSel(tczPSHiMuxSel[0:1]),
  .tcPSLoMuxSel(tcPSLoMuxSel),
  .tczPCHiMuxSel(tczPCHiMuxSel[0:1]),
  .tcPCLoMuxSel(tcPCLoMuxSel),
  .md2CompEn(md2CompEn),
  .PCL_exe2MultEn(PCL_exe2MultEn),
  .PCL_exe2MultHiWd(PCL_exe2MultHiWd),
  .PCL_exe2XerOvEn(PCL_exe2XerOvEn),
  .PCL_exe2Hold(PCL_exe2Hold),
  .PCL_exe2NegMac(PCL_exe2NegMac),
  .PCL_exeMacEn(PCL_exeMacEn),
  .multCntr(multCntr[0:1]),
  .nxtMultCntr(nxtMultCntr[0:1]),
  .adderOutBit15(adderOutBit16_B),
  .divNxtToLastSt(divNxtToLastSt),
  .divLastStOrSt0L2(divLastStOrSt0L2),
  .OPHi16(OPHi16),
  .ZPHi16(ZPHi16),
  .exe2Mult16x32(exe2Mult16x32),
  .exe2Mult16x16Signed(exe2Mult16x16Signed),
  .resetL2(resetL2_i),
  .ZPLo16(ZPLo16),
  .OPLo16(OPLo16),
  .multLWAnsLo(multLWAnsLo[0:15]),
  .multLWAnsHi(multLWAnsHi[0:15]),
  .PCL_exeNegMac(PCL_exeNegMac),
  .multHiEOAnsCc(multHiEOAnsCc[0:2]),
  .multLo4CycAnsCc(multLo4CycAnsCc[0:2]),
  .multLo5CycAnsCc(multLo5CycAnsCc[0:2]),
  .PCL_exe2MacEn(PCL_exe2MacEn),
  .PCL_exe2MacSat(PCL_exe2MacSat),
  .macOV(macOV),
  .PCL_exeLoadUseHold(PCL_exeLoadUseHold),
  .PCL_exeDvcHold(PCL_exeDvcHold),
  .PCL_exeSrmBpSel(PCL_exeSrmBpSel[0:2]),
  .MDBit0(MD[0]),
  .MRBit0(MR[0]),
  .macAccL2Bit0(macAccL2[0]),
  .PCL_exe2SignedOp(PCL_exe2SignedOp),
  .PCL_holdMdMr(PCL_holdMdMr),
  .exe2MacE2(exe2MacE2),
  .divLastStOrSt0L2_NEG(divLastStOrSt0L2_NEG[1]),
  .macCarryBit2(macCarry[2]),
  .macSumBit1(macSum[1]),
  .PCL_exeAddSgndOp_NEG(PCL_exeAddSgndOp_NEG[0:1]),
  .PCL_exeDivSgndOp(PCL_exeDivSgndOp),
  .PCL_exeDivEn_NEG(PCL_exeDivEn_NEG),
  .divSt1_NEG(divSt1_NEG),
  .divSt0Or1(divSt0Or1),
  .PCL_exeDivEnForLSSD(PCL_exeDivEnForLSSD),
  .cIn_1(cIn_1),
  .exe2MacProdSgndL2(exe2MacProdSgndL2),
  .exe2MacSatUnsigned(exe2MacSatUnsigned),
  .exe2Md16BitOprndL2(exe2Md16BitOprndL2),
  .exe2Mr16BitOprndL2(exe2Mr16BitOprndL2),
  .potSOV(potSOV),
  .sumBit1(sumBit1),
  .nxtQ_NEG(nxtQ_NEG),
  .PCL_exeDvcOrParityHold(PCL_exeDvcOrParityHold));

//dp_muxEXE_admOut muxEXE_admOut({adderOut[1:16], adderOutBuf[17:32]}, multHWAns[0:31],
//     {multLoAnsHi[0:15], multLWAnsLo[0:15]}, {adderOut[2:32], sBus[0]}, admOutMuxSel[0:1],
//     admOut[0:31]);
// Removed the module 'dp_muxEXE_admOut'
reg [0:31] admOut;
always @(admOutMuxSel or adderOut or adderOutBuf or multHWAns or multLoAnsHi or multLWAnsLo or sBus or adderOut)
    begin                                           
    case(admOutMuxSel[0:1])                       
     2'b00: admOut[0:31] = ~{adderOut[1:16], adderOutBuf[17:32]};   
     2'b01: admOut[0:31] = ~multHWAns[0:31];   
     2'b10: admOut[0:31] = ~{multLoAnsHi[0:15], multLWAnsLo[0:15]};   
     2'b11: admOut[0:31] = ~{adderOut[2:32], sBus[0]};   
      default: admOut[0:31] = 32'bx;   
    endcase                                    
   end   
//dp_logEXE_bBusInv logEXE_bBusInv({bSE, bBusBuf[0:31]}, {NbSE, bBusNeg[0:31]});
// Removed the module 'dp_logEXE_bBusInv'
assign {NbSE, bBusNeg[0:31]} = ~({bSE, bBusBuf[0:31]});
//dp_logEXE_aBusInv logEXE_aBusInv({aSE, aBusBuf[0:31]}, {NaSE, aBusNeg[0:31]});
// Removed the module 'dp_logEXE_aBusInv'
assign {NaSE, aBusNeg[0:31]} = ~({aSE, aBusBuf[0:31]});
   // Replacing instantiation: GTECH_AND2 SGT_bSE
   assign bSE = sgndOpNotZero & bBusBuf[0];

p405s_divSM
 divSMPla(
  .nxtDivSt(nxtDivSt[0:5]),
  .divStE1(divStE1),
  .nxtLastStOrSt0(nxtLastStOrSt0),
  .nxtSt0Or1(nxtSt0Or1),
  .nxtSt1(nxtSt1),
  .resetL2(resetL2_i),
  .divideEn(PCL_exeDivEn),
  .pState(divSt[0:5]));

endmodule
