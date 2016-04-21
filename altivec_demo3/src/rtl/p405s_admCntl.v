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
module p405s_admCntl (EXE_admMco, aRegMuxSel, admOutMuxSel, multLoAnsMuxSel,
           bRegMuxSel, sgndOpNotZero, dndSE_NEG, sRegMuxSel, addOV,
           divOV, nxtQ, PCL_aPortRregBypass,
           PCL_bPortRregBypass, PCL_exeCmplmntA, PCL_dcdHotCIn,
           PCL_dcdXerCa, PCL_exeDivEn, PCL_exeMultEn, PCL_sPortRregBypass,
           N_ZP, aBytes01Eq0, bBytes23Eq0, adderOutBit0,
           adderOutBit16, adderOutSgnBit, coreReset, deterministicMult,
           divSt, bBusBit0, sBusBit0, bBytes01Eq0, N_OP,
           multHiWd, nxtXerCa, aBusBit0, aBusBit16, bBusBit16,
           signedOp, bBytes01Eq1, aBytes01Eq1,
           PCL_holdCIn, PCL_gateZeroToAreg,
           PCL_gateZeroToSreg, PCL_addFour, multSt,
           CB, CIn, PCL_dcdSrmBpSel, srmMuxSel,
           multOV, EXE_multMco, divStE2, multStE2, PCL_wbHold, multAnsLoBit0,
           multLWAnsLoE1, multLWAnsHiE1, divPathEn,
           PCL_exeXerOvEn, PCL_dcdAregLoadUse, PCL_dcdBregLoadUse,
           PCL_dcdSregLoadUse, PCL_bPortLitGenSel, PCL_exeAregLoadUse,
           PCL_exeBregLoadUse, PCL_exeSregLoadUse, mdSgn, mrSgn, EXE_divMco,
           divASeEn, nonDivASeEn, macMdMuxSel, macMrMuxSel,
           macRsHiEn, macRsLoEn, lastCycSgnMd, firstCycSgnMd, exe2MacE1,
           accRegE1, PCL_dcdMrSelQ, PCL_dcdMdSelQ, macRcHiEn, macRcLoEn,
           tczPSHiMuxSel, tcPSLoMuxSel, tczPCHiMuxSel, tcPCLoMuxSel, md2CompEn,
           PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2XerOvEn, PCL_exe2Hold,
           PCL_exe2NegMac, PCL_exeMacEn,
           multCntr, nxtMultCntr, adderOutBit15, divNxtToLastSt,
           divLastStOrSt0L2, OPHi16, ZPHi16, exe2Mult16x32,
           exe2Mult16x16Signed, resetL2, ZPLo16, OPLo16,
           multLWAnsLo, multLWAnsHi,PCL_exeNegMac, multHiEOAnsCc, multLo4CycAnsCc,
           multLo5CycAnsCc, PCL_exe2MacEn, PCL_exe2MacSat,
           macOV, PCL_exeLoadUseHold, PCL_exeDvcHold,
           PCL_exeSrmBpSel, MDBit0, MRBit0, macAccL2Bit0, PCL_exe2SignedOp,
           PCL_holdMdMr, exe2MacE2,
           divLastStOrSt0L2_NEG,
           macCarryBit2, macSumBit1, PCL_exeAddSgndOp_NEG, PCL_exeDivSgndOp,
           PCL_exeDivEn_NEG, divSt1_NEG, divSt0Or1, PCL_exeDivEnForLSSD, cIn_1,
           exe2MacProdSgndL2, exe2MacSatUnsigned, exe2Md16BitOprndL2, exe2Mr16BitOprndL2,
           potSOV, sumBit1, nxtQ_NEG, PCL_exeDvcOrParityHold);

    input  PCL_exe2SignedOp;
    input  PCL_exe2MacSat;
    output macOV;
    output EXE_admMco;
    output [0:1] aRegMuxSel;
    output [0:1] admOutMuxSel;
    output multLoAnsMuxSel;
    output [0:1] bRegMuxSel;
    output sgndOpNotZero;
    output dndSE_NEG;
    output [0:1] sRegMuxSel;
    output addOV;
    output divOV;
    output nxtQ;
    output multLWAnsLoE1;
    output multLWAnsHiE1;
    output [0:2] multHiEOAnsCc;
    output [0:2] multLo4CycAnsCc;
    output [0:2] multLo5CycAnsCc;
    input PCL_aPortRregBypass;
    input PCL_bPortRregBypass;
    input PCL_exeCmplmntA;
    input PCL_dcdHotCIn;
    input PCL_dcdXerCa;
    input PCL_exeDivEn;
    input PCL_exeMultEn;
    input PCL_sPortRregBypass;
    input PCL_gateZeroToAreg;
    input N_ZP;
    input aBytes01Eq0;
    input bBytes23Eq0;
    input adderOutBit0;
    input adderOutBit16;
    input adderOutSgnBit;
    input coreReset;
    input deterministicMult;
    input [0:5] divSt;
    input bBusBit0;
    input sBusBit0;
    input bBytes01Eq0;
    input N_OP;
    input multHiWd;
    input nxtXerCa;
    input aBusBit0;
    input aBusBit16;
    input bBusBit16;
    input signedOp;
    input bBytes01Eq1;
    input aBytes01Eq1;
    input PCL_holdCIn;
    input PCL_gateZeroToSreg;
    input PCL_addFour;
    input [0:1] multSt;
    //input [0:4] CB;
    input CB;
    output CIn;
    input [0:2] PCL_dcdSrmBpSel;
    input [0:2] PCL_exeSrmBpSel;
    output [0:5] srmMuxSel;
    output multOV;
    output EXE_multMco;
    output divStE2;
    output multStE2;
    input PCL_wbHold;
    input multAnsLoBit0;
    output divPathEn;
    input PCL_exeXerOvEn;
    input PCL_dcdAregLoadUse;
    input PCL_dcdBregLoadUse;
    input PCL_dcdSregLoadUse;
    input PCL_bPortLitGenSel;
    input PCL_exeAregLoadUse;
    input PCL_exeBregLoadUse;
    input PCL_exeSregLoadUse;
    output mdSgn;
    output mrSgn;
    output EXE_divMco;
    output divASeEn;
    output nonDivASeEn;
    output macMdMuxSel;
    output macMrMuxSel;
    output macRsHiEn;
    output [0:1] macRsLoEn;
    output [0:1] macRcLoEn;
    output macRcHiEn;
    output [0:1] tczPSHiMuxSel;
    output tcPSLoMuxSel;
    output [0:1] tczPCHiMuxSel;
    output tcPCLoMuxSel;
    output lastCycSgnMd;
    output firstCycSgnMd;
    output exe2MacE1;
    output accRegE1;
    input PCL_dcdMrSelQ;
    input PCL_dcdMdSelQ;
    output md2CompEn;
    input PCL_exe2MultEn;
    input PCL_exe2MultHiWd;
    input PCL_exe2XerOvEn;
    input PCL_exe2Hold;
    input PCL_exe2NegMac;
    input PCL_exeNegMac;
    input PCL_exeMacEn;
    input [0:1] multCntr;
    output [0:1] nxtMultCntr;
    input adderOutBit15;
    output divNxtToLastSt;
    input divLastStOrSt0L2;
    input divLastStOrSt0L2_NEG;
    input ZPHi16;
    input OPHi16;
    output exe2Mult16x32;
    output exe2Mult16x16Signed;
    output resetL2;
    input ZPLo16;
    input OPLo16;
    input [0:15] multLWAnsLo;
    input [0:15] multLWAnsHi;
    input PCL_exe2MacEn;
    input PCL_exeLoadUseHold;
    input PCL_exeDvcHold;
    input MDBit0;
    input MRBit0;
    input macAccL2Bit0;
    input PCL_holdMdMr;
    output exe2MacE2;
    input macCarryBit2;
    input macSumBit1;
    input [0:1] PCL_exeAddSgndOp_NEG;
    input PCL_exeDivSgndOp;
    input PCL_exeDivEn_NEG;
    input divSt1_NEG;
    input divSt0Or1;
    input PCL_exeDivEnForLSSD;
    output cIn_1;
    output exe2MacProdSgndL2;
    output exe2MacSatUnsigned;
    output exe2Md16BitOprndL2;
    output exe2Mr16BitOprndL2;
    output potSOV, sumBit1;
    output nxtQ_NEG;
    input  PCL_exeDvcOrParityHold;
    
// Changes:
// 01/05/99 SBP Change multNxtCIn equation. See issue 349 for more details.
// 01/07/99 SBP Change nxtExe2MacProdSgndL2 equation. See issue 352 for more details.
// 01/20/99 SBP Change tczPSHiMuxSel<0:1>, tczPSLoMuxSel, tczPCHiMuxSel<0:1>,
//              tczPCLoMuxSel to move the mux from exe2 to exe1 cycle.
// 05/07/99 SBP Moved some logic into sdtGates cell for timing.
//
// 07/13/01 JBB Added PCL_exeDvcOrParityHold to divStE2 and divFirstOpSub equations
//              per Cobra workbook
            
//************************************************************************
// State Definition Generation
//************************************************************************
wire   nxtMacMdMuxSel, nxtMacMrMuxSel, multNxtCIn;
wire multSt0, divSt0, divLastSt, divNxtToNxtToLastSt;
wire earlyOutDetect, posDivPos, posDivNeg, negDivPos, negDivNeg;
wire divSt1, multSt3, multSt1, multSt2, md16BitOprnd, mr16BitOprnd;
wire divByZeroIn, dndSgnBit, dsrSgnBit, dzEOsgnE1;
wire zrdE1, zrdIn, resetZrd, multDecSel;
wire [0:1] setMultCntr, decMultCntr;
wire setExe2MdMrOprd;
wire nxtExe2Md16BitOprndL2, nxtExe2Mr16BitOprndL2;
wire nxtExe2MacProdSgndL2, multLWAnsLoZero, multLWAnsHiZero;

reg cIn_1;
reg CIn_i;
wire CIn;
reg resetL2_i;
wire resetL2;
reg exe2Md16BitOprndL2_i;
wire exe2Md16BitOprndL2;
reg exe2Mr16BitOprndL2_i;
wire exe2Mr16BitOprndL2;
reg exe2MacProdSgndL2_i;
wire exe2MacProdSgndL2;
reg macMdMuxSel_i;
wire macMdMuxSel;
reg macMrMuxSel_i;
wire macMrMuxSel;
reg zrd;
reg divByZeroL2;
reg dndSgnL2;
reg dsrSgnL2;
reg md16BitOprndL2;
reg mr16BitOprndL2;

assign multSt0 = PCL_exeMultEn & ~|multSt[0:1];
assign multSt1 = ~multSt[0] & multSt[1];
assign multSt3 = &multSt[0:1];
assign multSt2 = multSt[0] & ~multSt[1];

assign divSt0 = PCL_exeDivEn & ~(|divSt[0:5]);
assign divSt1 = ~|divSt[0:4] & divSt[5];
assign divNxtToNxtToLastSt = ~divSt[0] & divSt[1] & divSt[2] & ~|divSt[3:5];
wire divNxtToLastSt, divNxtToLastSt_i;
assign divNxtToLastSt = divNxtToLastSt_i;
assign divNxtToLastSt_i = divSt[0] & ~|divSt[1:4] & divSt[5];
assign divLastSt = divSt[0] & ~|divSt[1:5];

wire EXE_divMco, EXE_divMco_i;
assign EXE_divMco = EXE_divMco_i;
assign EXE_divMco_i = PCL_exeDivEn & ~divLastSt;
wire EXE_multMco, EXE_multMco_i;
assign EXE_multMco = EXE_multMco_i;
assign EXE_multMco_i = multSt0 | (|multCntr[0:1]);
assign EXE_admMco = EXE_multMco_i | EXE_divMco_i;

assign multStE2 = ~PCL_holdMdMr;
//assign divStE2 = ~(PCL_exeLoadUseHold | PCL_exeDvcHold | (PCL_exeDivEn & PCL_wbHold & divLastSt));

assign divStE2 = ~(PCL_exeLoadUseHold | PCL_exeDvcOrParityHold | 
                  (PCL_exeDivEn & PCL_wbHold & divLastSt));

// When zero is being added to the PP make sure its sgn ext is also zero.
//assign sgndOpNotZero = (signedOp & ~PCL_exeDivEn & ~PCL_exeMultEn) |
//                       (PCL_exeDivEn & signedOp & ~divLastStOrSt0L2);
assign  sgndOpNotZero = ~(PCL_exeAddSgndOp_NEG[0] & (~(PCL_exeDivSgndOp & divLastStOrSt0L2_NEG)));

//assign nonDivASeEn =  (signedOp & ~PCL_exeDivEn & ~PCL_exeMultEn) | divSt1;
assign  nonDivASeEn = ~(PCL_exeAddSgndOp_NEG[1] & divSt1_NEG);

//assign divASeEn = PCL_exeDivEn & ~divSt0 & ~divSt1;
assign  divASeEn = ~(PCL_exeDivEn_NEG | divSt0Or1);

// assign addUnitEn = PCL_exeAddEn & ~PCL_exeDivEn & ~PCL_exeMultEn & ~PCL_exeEaCalc;
assign addOV = adderOutBit0 ^ adderOutSgnBit;


// Valid during state0 only.
assign dndSgnBit = signedOp & aBusBit0;
assign dsrSgnBit = signedOp & bBusBit0;

//************************************************************************
// Divide Control Equations
//************************************************************************
wire divByZeroDetect, abortDivOp, divFirstOpSub, divNxtSub, divCorrectAddOne;
wire divNxtCIn;

// Valid after state0.
assign posDivPos = ~dndSgnL2 & ~dsrSgnL2;
assign posDivNeg = ~dndSgnL2 &  dsrSgnL2;
assign negDivPos =  dndSgnL2 & ~dsrSgnL2;
assign negDivNeg =  dndSgnL2 &  dsrSgnL2;

// Dsr is in bReg during state0 of divide.
assign divByZeroIn = PCL_exeDivEn & bBytes01Eq0 & bBytes23Eq0;

assign divByZeroDetect = PCL_exeDivEn & divByZeroL2;

assign abortDivOp = ~PCL_exeDivEn & (|divSt[0:5]);

wire nxtQ;
wire nxtQ_i;
assign nxtQ = nxtQ_i;
assign nxtQ_i = (adderOutBit0) ~^ ((dsrSgnBit & divSt0) | (dsrSgnL2 & ~divSt0));

assign nxtQ_NEG = (adderOutBit0) ^ ((dsrSgnBit & divSt0) | (dsrSgnL2 & ~divSt0));

// Divide 1st sub if posDivPos or negDivNeg during divSt1. PCL_exeLoadUseHold and
// PCL_exeDvcHold prevent CIn from being set during divSt0. We want to add zero to
// the DND during divSt0 to move DND from Areg to Sreg via rRegBypass.

//assign divFirstOpSub = (~signedOp | (aBusBit0 ~^ bBusBit0)) & divSt0 &
//                        ~PCL_exeLoadUseHold & ~PCL_exeDvcHold;

assign divFirstOpSub = (~signedOp | (aBusBit0 ~^ bBusBit0)) & divSt0 & 
                       ~PCL_exeLoadUseHold & ~PCL_exeDvcOrParityHold;

assign divNxtSub = nxtQ_i & ~divNxtToLastSt_i & ~divLastStOrSt0L2;

// Use input to zrd latch because must set cIn latch for last cycle correct.
assign divCorrectAddOne = divNxtToLastSt_i &
                          (posDivNeg | (negDivPos & ~zrdIn) | (negDivNeg & zrdIn));

assign divNxtCIn = divFirstOpSub | divNxtSub | divCorrectAddOne;

// divide overflow is anything  divided by zero OR negDivNeg with result neg.
assign divOV = (divByZeroDetect | (signedOp & negDivNeg & adderOutSgnBit)) & PCL_exeDivEn;

//************************************************************************
// Multiply Control Equations
//************************************************************************
// All 32-bit mult instruction assert PCL_exeMultEn.
// All 16-bit mult instruction assert PCL_exeMacEn.
// 00 - 0/1 cyc Mco, All mac and 16-bit mult instr are 0 cyc Mco.
//                   16x32 or 32x16 Hi/Lo results are 1 cyc Mco.
// 01 - 2 cyc Mco, 32x32 Lo result with no OV.
// 10 - 3 cyc Mco, 32x32 Lo result with OV or Hi results.
//                 All 32x32 bit mult with deterministic mult.
// 11 - Not Used,  None.
assign setMultCntr[0] = ((PCL_exeXerOvEn | multHiWd) & ~earlyOutDetect) | deterministicMult ;
assign setMultCntr[1] = ~PCL_exeXerOvEn & ~multHiWd & ~earlyOutDetect & ~deterministicMult;

assign decMultCntr[0:1] = ({1'b0, multCntr[0]});

assign multDecSel =  PCL_exeMultEn & ~multSt0;

assign nxtMultCntr[0:1] = ({2{multSt0}} & setMultCntr[0:1]) |
                          ({2{multDecSel}} & decMultCntr[0:1]);

assign multLWAnsLoE1 = multSt1 & ~multHiWd;

assign multLWAnsHiE1 = multSt2 & ~multHiWd;

assign exe2MacE1 = (PCL_exeMultEn | PCL_exeMacEn);

assign accRegE1 = (PCL_exeMacEn | multSt0);

assign exe2MacE2 =  ~PCL_exe2Hold;

//MacMdMuxSel
// 0 - AReg[16:31]
// 1 - AReg[0:15]
assign macMdMuxSel = macMdMuxSel_i;
assign nxtMacMdMuxSel = (~EXE_multMco_i & PCL_dcdMdSelQ) |
                        (PCL_holdMdMr & macMdMuxSel_i) |
                        (multSt0 & ~PCL_holdMdMr &
                        (deterministicMult | ~md16BitOprnd | mr16BitOprnd)) |
                        (multCntr[1] & multSt3);

//MacMrMuxSel
// 0 - BReg[16:31]
// 1 - BReg[0:15]
assign macMrMuxSel = macMrMuxSel_i;
assign nxtMacMrMuxSel = (~EXE_multMco_i & PCL_dcdMrSelQ) |
                        (PCL_holdMdMr & macMrMuxSel_i) |
                        (multSt0 & ~PCL_holdMdMr & md16BitOprnd & ~mr16BitOprnd) |
                        ((|multCntr[0:1]) & (multSt1 | multSt3));

assign setExe2MdMrOprd = PCL_exeMultEn & ~PCL_exe2Hold & ~EXE_multMco_i;

assign resetL2 = resetL2_i;
assign exe2Md16BitOprndL2 = exe2Md16BitOprndL2_i;
assign nxtExe2Md16BitOprndL2 =  ((md16BitOprndL2 & setExe2MdMrOprd) |
                                (exe2Md16BitOprndL2_i & ~setExe2MdMrOprd)) & ~resetL2_i;
assign exe2Mr16BitOprndL2 = exe2Mr16BitOprndL2_i;
assign nxtExe2Mr16BitOprndL2 =  ((mr16BitOprndL2 & setExe2MdMrOprd) |
                                (exe2Mr16BitOprndL2_i & ~setExe2MdMrOprd)) & ~resetL2_i;

// Invert the signed if NMAC.
assign exe2MacProdSgndL2 = exe2MacProdSgndL2_i;
assign nxtExe2MacProdSgndL2 =  (((PCL_exeNegMac ^ (MDBit0 ^ MRBit0)) & PCL_exeMacEn & ~PCL_exe2Hold) |
                                (exe2MacProdSgndL2_i & ~(PCL_exeMacEn & ~PCL_exe2Hold))) & ~resetL2_i;

assign exe2Mult16x32 = exe2Mr16BitOprndL2_i ^ exe2Md16BitOprndL2_i;

assign exe2Mult16x16Signed = exe2Mr16BitOprndL2_i & exe2Md16BitOprndL2_i &
                             PCL_exe2SignedOp;

// rlg - added the term "& ~deterministicMult" to fix issue 211 (powler2 database)
assign md16BitOprnd = ((~signedOp & aBytes01Eq0) |
                       (signedOp & aBytes01Eq0 & ~aBusBit16) |
                       (signedOp & aBytes01Eq1 & aBusBit16)) & ~deterministicMult;

// rlg - added the term "& ~deterministicMult" to fix issue 211 (powler2 database)
assign mr16BitOprnd = ((~signedOp & bBytes01Eq0) |
                       (signedOp & bBytes01Eq0 & ~bBusBit16) |
                       (signedOp & bBytes01Eq1 & bBusBit16)) & ~deterministicMult;

assign earlyOutDetect = md16BitOprnd | mr16BitOprnd;

assign mdSgn = signedOp & ((md16BitOprnd & ~mr16BitOprnd & multSt0) |
                           PCL_exeMacEn | (multSt[0] ^ multSt[1]));

assign mrSgn = signedOp & ((mr16BitOprnd & multSt0) | PCL_exeMacEn |
                           ((md16BitOprndL2 | mr16BitOprndL2) & multSt1) |
                            multSt[0]);

assign md2CompEn = multSt3 | (md16BitOprndL2 &  ~mr16BitOprndL2 & multSt1) |
                   (bBytes01Eq1 & bBusBit16 & multSt0) | PCL_exeMacEn ;

assign lastCycSgnMd = signedOp & (multSt2  | PCL_exeMacEn |
                                 (multSt1 & (md16BitOprndL2 | mr16BitOprndL2)));

assign firstCycSgnMd =  signedOp & ((md16BitOprnd & ~mr16BitOprnd & multSt0) | PCL_exeMacEn |
                                    (multSt1 & ~(md16BitOprndL2 & ~mr16BitOprndL2)));

// Mult overflow occurs when the sign bit of the lo word ans does not
// match all of the bits in the hi word ans. The hi word ans should be the
// sign extension of the low result. OV can not occur with a 16x16 mult.
assign multOV = PCL_exe2MultEn &
                ((~(exe2Mr16BitOprndL2_i | exe2Md16BitOprndL2_i) &
                 ((multAnsLoBit0 & N_OP) | (~multAnsLoBit0 & N_ZP))) |
                 ((exe2Mr16BitOprndL2_i ^ exe2Md16BitOprndL2_i) &
                  ((adderOutBit16 & ~OPHi16) | (~adderOutBit16 & ~ZPHi16))));

assign macOV = PCL_exe2MacEn &
               ((~PCL_exe2SignedOp & adderOutBit0) |
                (PCL_exe2SignedOp & (adderOutSgnBit ^ macAccL2Bit0) & (exe2MacProdSgndL2_i ~^ macAccL2Bit0)));

//assign macOVSat = PCL_exe2MacSat &
//                  ((~PCL_exe2SignedOp & adderOutBit0) |
//                   (PCL_exe2SignedOp & (adderOutSgnBit ^ macAccL2Bit0) & (exe2MacProdSgndL2_i ~^ macAccL2Bit0)));
//
assign potSOV = PCL_exe2MacSat & PCL_exe2SignedOp & (exe2MacProdSgndL2_i ~^ macAccL2Bit0);
assign sumBit1 = macCarryBit2 ^ macSumBit1;
assign exe2MacSatUnsigned = PCL_exe2MacSat & ~PCL_exe2SignedOp;

//assign macOVSat_NEG = ~((cInBit1 & (sumBit1 ~^ macAccL2Bit0) & potSOV) |
//                        (~cInBit1 & (sumBit1 ^ macAccL2Bit0) & potSOV) |
//                        (PCL_exe2MacSat & ~PCL_exe2SignedOp & adderOutBit0));
//
//assign macSatValue[0:31] = ({(~PCL_exe2SignedOp | exe2MacProdSgndL2_i),
//                             {31{(~PCL_exe2SignedOp | ~exe2MacProdSgndL2_i)}}});

assign multLWAnsLoZero = ~(|multLWAnsLo[0:15]);
assign multLWAnsHiZero = ~(|multLWAnsHi[0:15]);

assign multHiEOAnsCc[0] =  adderOutSgnBit & PCL_exe2SignedOp;
assign multHiEOAnsCc[1] =  ~(adderOutSgnBit & PCL_exe2SignedOp) & ~ZPHi16 ;
assign multHiEOAnsCc[2] =   ZPHi16;

assign multLo4CycAnsCc[0] =  adderOutBit16;
assign multLo4CycAnsCc[1] =  ~adderOutBit16 & ~(multLWAnsLoZero & ZPLo16);
assign multLo4CycAnsCc[2] =  multLWAnsLoZero & ZPLo16;

assign multLo5CycAnsCc[0] =  (PCL_exe2MultEn & multAnsLoBit0) |
                             (PCL_exe2MacEn & (~PCL_exe2SignedOp | exe2MacProdSgndL2_i));
assign multLo5CycAnsCc[1] =  (PCL_exe2MultEn & ~multAnsLoBit0 & ~(multLWAnsLoZero & multLWAnsHiZero)) |
                             (PCL_exe2MacEn & PCL_exe2SignedOp & ~exe2MacProdSgndL2_i);
assign multLo5CycAnsCc[2] =  PCL_exe2MultEn & multLWAnsLoZero & multLWAnsHiZero;

// admccMuxSel[0:1]
// 00 -  pla
// 01 -  MultHiEOAns
// 10 -  MultLo4CycAns
// 11 -  MultLo5CycAns
//assign admCcMuxSel[0] = ~macOVSat_NEG | (PCL_exe2MultEn & ~PCL_exe2MultHiWd);
//assign admCcMuxSel[1] = ~macOVSat_NEG | (PCL_exe2MultEn & ((~PCL_exe2MultHiWd & PCL_exe2XerOvEn & ~(exe2Mr16BitOprndL2_i | exe2Md16BitOprndL2_i)) |
//                        (PCL_exe2MultHiWd & (exe2Mr16BitOprndL2_i | exe2Md16BitOprndL2_i))));

// Should set to zero during State0 and hold during state3.
assign CIn = CIn_i;
assign multNxtCIn = ((multSt1 | multSt2) & adderOutBit15) |
                    (multSt3 & CIn_i);

assign macRcLoEn[0] = multSt3;
assign macRcLoEn[1] = multSt1 | multSt2;

assign macRcHiEn = multSt3;

assign macRsLoEn[0] = multSt3;
assign macRsLoEn[1] = multSt1 | multSt2;

assign macRsHiEn = multSt3;

assign tczPSHiMuxSel[0] = multSt0 | multSt3;
assign tczPSHiMuxSel[1] = PCL_exeNegMac;

assign tcPSLoMuxSel = PCL_exeNegMac;

assign tczPCHiMuxSel[0] = multSt0 | multSt3;
assign tczPCHiMuxSel[1] = PCL_exeNegMac;

assign tcPCLoMuxSel = PCL_exeNegMac;

//************************************************************************
// Mux Control Equations
//************************************************************************
wire multLoAns, multEarlyOutHiAns;
wire divPathForMS, divSt0ForMS, divMcoForMS;

// Using sepeate DivEn for LSSD.
assign divPathForMS = PCL_exeDivEnForLSSD & ~divLastStOrSt0L2;
assign divSt0ForMS = PCL_exeDivEnForLSSD & ~(|divSt[0:5]);
assign divMcoForMS = PCL_exeDivEnForLSSD & ~divLastSt;

// admMuxSelect div/mult leg.
assign divPathEn = PCL_exeDivEn & ~divLastStOrSt0L2;

// dndSE
assign dndSE_NEG = ~(divSt0 & signedOp & aBusBit0);

// admMuxSelect div/mult leg.
assign multLoAns =  PCL_exe2MultEn & ~PCL_exe2MultHiWd;

assign multEarlyOutHiAns = PCL_exe2MultEn & PCL_exe2MultHiWd & ~deterministicMult &
                            (exe2Md16BitOprndL2_i | exe2Mr16BitOprndL2_i);

// multLoAnsMuxSel
// 0 -  adderOut[17:32],multLWAnsLo<0:15>     //3 cycle OE=0
// 1 -  multLWAnsHi<0:15>,multLWAnsLo<0:15>   //4 cycle OE=1
assign multLoAnsMuxSel = (PCL_exe2MultEn & PCL_exe2XerOvEn &
                          ~(exe2Md16BitOprndL2_i | exe2Mr16BitOprndL2_i)) | deterministicMult;

// admAdderAInMuxSel[0:1]
// 00 -  aBus            : Adds
// 01 -  Complement aBus : Subtracts
// 10 -  Zero (Not Used) :
// 11 -  PC,PS Reg       : All mult states, mac in exe2
//assign admAdderAInMuxSel[0] = ~(PCL_exeMultEn_NEG[0] & PCL_exe2MacOrMultEn_NEG[0]);
//assign admAdderAInMuxSel[1] = ~(PCL_exeMultEn_NEG[1] & PCL_exe2MacOrMultEn_NEG[1] & PCL_exeCmplmntA_NEG);

// admAdderBInMuxSel[0:1]
// 00 -  bBus            : Adds
// 01 -  Complement bBus : Div intermediate state, subtract.
// 10 -  Zero            : Div first and last state
// 11 -  PC,PS Reg       : All mult states, mac in exe2
//assign admAdderBInMuxSel[0] = ~(~(PCL_exeMultEnForMuxSel[0] | PCL_exe2MacOrMultEnForMS[0]) &
//                              ~(PCL_exeDivEnForMuxSel[0] & divLastStOrSt0L2_1));
//assign admAdderBInMuxSel[1] = ~(~(PCL_exeMultEnForMuxSel[1] | PCL_exe2MacOrMultEnForMS[1]) &
//                                ~(PCL_exeDivEnForMuxSel[1] & cIn_1 & divLastStOrSt0L2_NEG[0]));

// admOutMuxSel[0:1]
// 00 -  adderOut[1:32]      : divFirstOrLastCyc, Adds, Subs, mult hiAns for 32x32,
//                           : all macs & nmac, all 16x16 mult
// 01 -  multHi for earlyout : SE,adderOutHi
// 10 -  multLoAns           : 2:1mux 0-(adderOutLo,Lo) for 32x32 Lo no OV 1-(Hi,Lo) for 32x32 Lo OV.
// 11 -  divPath             : Div intermidiate state
assign admOutMuxSel[0] = divPathForMS | multLoAns;
assign admOutMuxSel[1] = divPathForMS | multEarlyOutHiAns;

// aRegMuxSel[0:1]
// 00 -  GPR Aport
// 01 -  Rreg Bypass  (div intermediate state, aportRregBypass)
// 10 -  Dreg Bypass
// 11 -  multLitMux   (divSt0, addFour for storageOps, gateZeroToAreg)
assign aRegMuxSel[0] = PCL_exeAregLoadUse | PCL_addFour | divSt0ForMS |
                       (~divPathForMS & (PCL_gateZeroToAreg | PCL_dcdAregLoadUse));
assign aRegMuxSel[1] = (PCL_aPortRregBypass | PCL_gateZeroToAreg |
                        PCL_addFour | divMcoForMS) & ~PCL_exeAregLoadUse;

//assign aRegZ4dndSEIn[0:31] =({{29{dndSE}},(dndSE | PCL_addFour),{2{dndSE}}});

// bRegMuxSel[0:1]
// 00 -  GPR Bport
// 01 -  Rreg Bypass (LD,ST,RregBypass)
// 10 -  Dreg Bypass
// 11 -  Mult/LitGen (FB shift and rotate 16 bits or LitGen).
assign bRegMuxSel[0] = PCL_exeBregLoadUse |
                       (~PCL_addFour & (PCL_bPortLitGenSel | PCL_dcdBregLoadUse));
assign bRegMuxSel[1] = (PCL_bPortRregBypass | PCL_addFour |
                        PCL_bPortLitGenSel) & ~PCL_exeBregLoadUse ;

// sRegMuxSel[0:1]
// 00 -  GPR Sport
// 01 -  Rreg Bypass (divSt0, RregBypass)
// 10 -  Dreg Bypass
// 11 -  divPathorZero  (divPath(dndNxtQ, dcbz, dcba)
// Prowler pass2 issue200 fix.
//assign sRegMuxSel[0] = PCL_exeSregLoadUse | divPathForMS | (PCL_gateZeroToSreg & ~divSt0ForMS) |
assign sRegMuxSel[0] = PCL_exeSregLoadUse | divPathForMS | (PCL_gateZeroToSreg & ~divSt0ForMS & ~PCL_sPortRregBypass) |
                       (PCL_dcdSregLoadUse & ~divSt0ForMS);
assign sRegMuxSel[1] = (divMcoForMS | PCL_gateZeroToSreg | PCL_sPortRregBypass) & ~PCL_exeSregLoadUse;

// srmMuxSel[0:5]
// 00 -  Lit Gen
// 01 -  Dreg Bypass
// 10 -  GPR Bport
// 11 -  Rreg Bypass (RregBypass)
assign srmMuxSel[0] = PCL_dcdSrmBpSel[0] & ~PCL_dcdBregLoadUse & ~PCL_exeBregLoadUse;
assign srmMuxSel[1] = (PCL_dcdSrmBpSel[0] & (PCL_bPortRregBypass | PCL_dcdBregLoadUse)) |
                      (PCL_exeSrmBpSel[0] &  PCL_exeBregLoadUse);
assign srmMuxSel[2] = PCL_dcdSrmBpSel[1] & ~PCL_dcdBregLoadUse & ~PCL_exeBregLoadUse;
assign srmMuxSel[3] = (PCL_dcdSrmBpSel[1] & (PCL_bPortRregBypass | PCL_dcdBregLoadUse)) |
                      (PCL_exeSrmBpSel[1] & PCL_exeBregLoadUse);
assign srmMuxSel[4] = PCL_dcdSrmBpSel[2] & ~PCL_dcdBregLoadUse & ~PCL_exeBregLoadUse;
assign srmMuxSel[5] = (PCL_dcdSrmBpSel[2] & (PCL_bPortRregBypass | PCL_dcdBregLoadUse)) |
                      (PCL_exeSrmBpSel[2] & PCL_exeBregLoadUse);

//************************************************************************
// Carry In Equation
//************************************************************************
wire  nxtCIn;

// Instr  Loading Stage   Used Stage    Holding Cond
// ----   -------------   ----------    ------------
// MAC    EXE1            EXE2          wbHold & exe2Full
// MULT   EXE1            EXE2          wbHold & exe2Full
// DIV    EXE1            EXE1          divEn & divLastSt & wbHold
// Other  DCD             EXE1          ~divMco & ~exeMultEn & ~exeMacEn & PCL_holdCIn
// PCL_holdCIn = exeLoadUseHold | exeDvcHold | trapMco | (wbHold & exeFull);
// PCL_exe2Hold = exe2Full & wbHold;
// term1 - During divMco want divNxtCIn,
// term2 - mult not stopped by exe2
// term3 - mac not stopped by exe2
// term4 - mac or mult in exe2 and holding
// term5 - divLastSt and other group holding
// term6 - divLastSt and other group not holding
// If no group holding let CI be controlled  by PCL_dcdHotCIn and PCL_dcdXerCA.
assign nxtCIn = ((EXE_divMco_i & divNxtCIn) |
                 (PCL_exeMultEn & multNxtCIn & ~PCL_exe2Hold) |
                 (PCL_exeMacEn & PCL_exeNegMac & ~PCL_exe2Hold) |
                 (PCL_exe2Hold & CIn_i) |
                 (~EXE_divMco_i & ~PCL_exeMultEn & ~PCL_exeMacEn & PCL_holdCIn & CIn_i) |
                 (~EXE_divMco_i & ~PCL_exeMultEn & ~PCL_exeMacEn & ~PCL_holdCIn & ~PCL_exe2Hold &
                                 (PCL_dcdHotCIn | (PCL_dcdXerCa & nxtXerCa))));

//************************************************************************
// Carry In Latch
//************************************************************************
//dp_regEXE_CIn       regEXE_CIn(.D({nxtCIn, coreReset, nxtExe2Md16BitOprndL2,
//                                   nxtExe2Mr16BitOprndL2, nxtExe2MacProdSgndL2}),
//                               .I(SI),
//                               .CB(CB[0:4]),
//                               .L2({CIn, resetL2_i, exe2Md16BitOprndL2_i,
//                                    exe2Mr16BitOprndL2_i, exe2MacProdSgndL2_i}),
//                               .SO(S1));
// Removed the module 'dp_regEXE_CIn'
always @(posedge CB)      
    begin                                       
     {CIn_i, resetL2_i, exe2Md16BitOprndL2_i, exe2Mr16BitOprndL2_i, exe2MacProdSgndL2_i} 
      <= {nxtCIn, coreReset, nxtExe2Md16BitOprndL2,nxtExe2Mr16BitOprndL2, nxtExe2MacProdSgndL2};
   end

//dp_regEXE_cInHiPwr  regEXE_cInHiPwr(.D(nxtCIn),
//                               .I(S1),
//                               .CB(CB[0:4]),
//                               .L2(cIn_1),
//                               .SO(S2));
// Removed the module 'dp_regEXE_cInHiPwr'
always @(posedge CB)      
    begin                                       
     cIn_1 <= nxtCIn;
   end

//dp_regEXE_macMdMrMuxSel  regEXE_macMdMrMuxSel(.D({nxtMacMdMuxSel,nxtMacMrMuxSel}),
//                               .I(S2),
//                               .CB(CB[0:4]),
//                               .L2({macMdMuxSel_i, macMrMuxSel_i}),
//                               .SO(S3));
// Removed the module 'dp_regEXE_macMdMrMuxSel'
always @(posedge CB)      
    begin                                       
     {macMdMuxSel_i, macMrMuxSel_i} <= {nxtMacMdMuxSel,nxtMacMrMuxSel};
   end 
//************************************************************************
// Zero Detect Equation
//************************************************************************
assign resetZrd = (sBusBit0 & ~divNxtToLastSt_i) | divLastStOrSt0L2 | resetL2_i | abortDivOp;
assign zrdIn = (~N_ZP | zrd) & ~resetZrd;

assign zrdE1 = (PCL_exeDivEn | resetL2_i | abortDivOp);

//************************************************************************
// Zero Detect Latch
//************************************************************************
//dp_regEXE_zrd       regEXE_zrd(.E1(zrdE1),
//                               .D(zrdIn),
//                               .I(S3),
//                               .CB(CB[0:4]),
//                               .L2(zrd),
//                               .SO(S4));
// Removed the module 'dp_regEXE_zrd'
always @(posedge CB)      
    begin                                       
    casez(zrdE1)                    
     1'b0: zrd <= zrd;                
     1'b1: zrd <= zrdIn;
      default: zrd <= 1'bx;  
    endcase                             
   end 

//************************************************************************
// divByZeroDetect,dndSgnBit,dsrSgnBit Equation
//************************************************************************
assign dzEOsgnE1 = divSt0 | multSt0;

//************************************************************************
// divByZeroDetect,dndSgnBit,dsrSgnBit Latch
//************************************************************************
//dp_regEXE_dzEOsgn   regEXE_dzEOsgn(.E1(dzEOsgnE1),
//                                   .D({divByZeroIn,dndSgnBit,dsrSgnBit,
//                                       md16BitOprnd,mr16BitOprnd}),
//                                   .I(S4),
//                                   .CB(CB[0:4]),
//                                   .L2({divByZeroL2,dndSgnL2,dsrSgnL2,
//                                        md16BitOprndL2,mr16BitOprndL2}),
//                                   .SO(SO));
// Removed the module 'dp_regEXE_dzEOsgn'
always @(posedge CB)      
    begin                                       
    casez(dzEOsgnE1) 
     1'b0: {divByZeroL2,dndSgnL2,dsrSgnL2,md16BitOprndL2,mr16BitOprndL2} <= {divByZeroL2,dndSgnL2,dsrSgnL2,md16BitOprndL2,mr16BitOprndL2};                
     1'b1: {divByZeroL2,dndSgnL2,dsrSgnL2,md16BitOprndL2,mr16BitOprndL2} <= {divByZeroIn,dndSgnBit,dsrSgnBit,md16BitOprnd,mr16BitOprnd}; 
      default: {divByZeroL2,dndSgnL2,dsrSgnL2,md16BitOprndL2,mr16BitOprndL2} <= 5'bx;  
    endcase                             
   end


endmodule
