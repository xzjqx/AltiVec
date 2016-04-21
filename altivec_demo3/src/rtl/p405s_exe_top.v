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
// Cobra Change History
// NAME   DATE    DEFECT  DESCRIPTION
// JBB  07/13/01   1784   Widened PCL_vctSprDcds bus for MCSR and MCSRS
//                         in sprMux_top.v
//                        Added PCL_exeDvcOrParityHold to admTop.v (had to go into admCtl.v
//                         equations for divStE2 and divFirstOpSub)
// PGM  07/31/01   1785   Remove port size information in module definition
// JBB  08/01/01   1792   Added inputs and outputs for dp_regEXE_dofDregParErr
//                        (into loadSteering.v)
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1
// JBB  10/05/01   1935   Added another bit to PCL_vctSprDcds bus for CCR1 here
//                        and in sprMux_top.v
// JBB  10/11/01   1955   Removed previously added PCL_vctSprDcds bus bit for CCR1 and
//                        in sprMux_top.v 
// JBB  10/17/01   1971   Removed another PCL_vctSprDcds bus bit for MCSRS here
//                        and in sprMux_top.v
//
// JBB  10/22/02   2297   (1) Changed I/O for Tbird low power GPR mods.  Added
//                            EXE_gprDetectBypass, EXE_gprFmin_enable, EXE_gprV_detect, 
//                            EXE_gprSysClkPI, EXE_gprRen to the port list and the macro
//                            call to SM_GPR2W3R32X32_RTP.
//
//                        (2) Added wires for the widened GPR scan chains.
//
//                        (3) Added an instance to the gproscDelayElem.v module
//                            (Tbird GPR oscillator delay).
//
// JBB  11/08/02   2299   Added LSSD inputs  (EXE_gprLc and EXE_gprTe) here and
//                        in the call to SM_GPR2W3R32X32_RTP.v
//
//******************************************************************************************

module p405s_exe_top( EXE_admMco, EXE_apuLoadData, EXE_cc, EXE_dac1CO, EXE_dac1SumBit30Eq,
     EXE_dac1SumBit31Eq, EXE_dac1SumBits0thru27Eq, EXE_dac1SumBits28and29Eq, EXE_dac2CO,
     EXE_dac2SumBit30Eq, EXE_dac2SumBit31Eq, EXE_dac2SumBits0thru27Eq,
     EXE_dac2SumBits28and29Eq, EXE_dcrAddr, EXE_dcrDataBus, EXE_dcuData,
     EXE_divMco, EXE_dsEA_NEG, EXE_dsEaCP_NEG, EXE_dvc1ByteCmp,
     EXE_dvc2ByteCmp, EXE_ea, EXE_eaARegBuf, EXE_eaBRegBuf,
     EXE_ifbSprDataBus, EXE_mmuIcuSprDataBus, EXE_multMco,
     EXE_raData, EXE_rbData, EXE_sprAddr, EXE_timJtgSprDataBus,
     EXE_trap, EXE_vctDbgSprDataBus, EXE_wrteeIn, EXE_xer, EXE_xerCa,
     EXE_xerTBC, EXE_xerTBCIn, EXE_xerTBCNotEqZero, APU_exeCa, APU_exeCr,
     APU_exeOv, APU_exeResult, CB, DBG_dacEn, DBG_sprDataBus,
     DCU_SDQ_mod_NEG, DCU_data_NEG, ICU_sprDataBus,
     IFB_exeMcrxr, IFB_exeOpForExe2L2, IFB_sprDataBus, JTG_sprDataBus,
     LSSD_coreTestEn, MMU_sprDataBus, OCM_dsData,
     PCL_aPortRregBypass, PCL_aRegE2, PCL_aRegForEaE2, PCL_abRegE1, PCL_addFour,
     PCL_apuTrcLoadEn, PCL_bPortLitGenSel, PCL_bPortRregBypass, PCL_bRegE2, PCL_bRegForEaE2,
     PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dbgSprDcds, PCL_dcdApAddr,
     PCL_dcdAregLoadUse, PCL_dcdBpAddr, PCL_dcdBregLoadUse, PCL_dcdHotCIn,
     PCL_dcdImmd, PCL_dcdLitCntl, PCL_dcdMdSelQ, PCL_dcdMrSelQ, PCL_dcdSpAddr,
     PCL_dcdSregLoadUse, PCL_dcdSrmBpSel, PCL_dcdXerCa, PCL_dofDregE1,
     PCL_dofDregMuxSel, PCL_dvcByteEnL2, PCL_dvcCmpEn, PCL_exe2AccRegMuxSel,
     PCL_exe2Hold, PCL_exe2MacEn, PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG,
     PCL_exe2MacSat, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp,
     PCL_exe2XerOvEn, PCL_exeAddEn, PCL_exeAddSgndOp_NEG, PCL_exeAdmCntl,
     PCL_exeApuValidOp, PCL_exeAregLoadUse, PCL_exeBregLoadUse, PCL_exeCmplmntA,
     PCL_exeCmplmntA_NEG, PCL_exeDivEn, PCL_exeDivEnForLSSD, PCL_exeDivEnForMuxSel,
     PCL_exeDivEn_NEG, PCL_exeDivSgndOp, PCL_exeDvcHold, PCL_exeEaCalc, PCL_exeEaQwEn,
     PCL_exeFpuOp, PCL_exeLoadUseHold, PCL_exeLogicalCntl, PCL_exeLogicalUnitEnForLSSD,
     PCL_exeLogicalUnitEn_NEG, PCL_exeMacEn, PCL_exeMacOrMultEn_NEG, PCL_exeMfspr,
     PCL_exeMtspr, PCL_exeMultEn, PCL_exeMultEnForMuxSel, PCL_exeMultEn_NEG,
     PCL_exeNegMac, PCL_exeRaEn, PCL_exeRbEn, PCL_exeSprDataEn_NEG,
     PCL_exeSprDcds, PCL_exeSprUnitEn_NEG, PCL_exeSregLoadUse, PCL_exeSrmBpSel,
     PCL_exeSrmCntl, PCL_exeSrmUnitEnForLSSD, PCL_exeSrmUnitEn_NEG, PCL_exeTrapCond,
     PCL_exeWrtee, PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_gateZeroToAreg, PCL_gateZeroToSreg,
     PCL_holdCIn, PCL_holdMdMr, PCL_ldAdjE1, PCL_ldAdjE2, PCL_ldAdjMuxSel,
     PCL_ldFillByPassMuxSel, PCL_ldMuxSel, PCL_ldSteerMuxSel,
     PCL_lwbLpAddr, PCL_lwbLpEqdcdApAddr, PCL_lwbLpEqdcdBpAddr, PCL_lwbLpEqdcdSpAddr,
     PCL_lwbLpWrEn, PCL_mfDCRL2, PCL_resultMuxSel, PCL_resultRegE1, PCL_resultRegE2,
     PCL_sPortRregBypass, PCL_sRegE1, PCL_sRegE2, PCL_sdqMuxSel, PCL_sprHold, PCL_sraRegE1,
     PCL_sraRegE2, PCL_srmRegE1, PCL_srmRegE2, PCL_timSprDcds, PCL_vctSprDcds,
     PCL_wbHold, PCL_wbRpAddr, PCL_wbRpEqdcdApAddr, PCL_wbRpEqdcdBpAddr,
     PCL_wbRpEqdcdSpAddr, PCL_wbRpWrEn, PCL_xerL2Hold, PGM_deterministicMult, 
     TIM_sprDataBus, VCT_sprDataBus, XXX_dcrDataBus,
     coreReset, PCL_exeDvcOrParityHold, DCU_parityError,
     EXE_dofDregParityErrL2, PCL_BpEqSp, 
     EXE_gprSysClkPI, EXE_gprRen);
     
output  EXE_admMco, EXE_dac1CO, EXE_dac1SumBit30Eq, EXE_dac1SumBit31Eq,
     EXE_dac1SumBits0thru27Eq, EXE_dac1SumBits28and29Eq, EXE_dac2CO, EXE_dac2SumBit30Eq,
     EXE_dac2SumBit31Eq, EXE_dac2SumBits0thru27Eq, EXE_dac2SumBits28and29Eq, EXE_divMco,
     EXE_multMco, EXE_trap, EXE_wrteeIn, EXE_xerCa, EXE_xerTBCNotEqZero,
     EXE_dofDregParityErrL2;

// rlg - added for tbird
input PCL_BpEqSp;

input  APU_exeCa, APU_exeOv, DBG_dacEn, IFB_exeMcrxr, IFB_exeOpForExe2L2, 
     LSSD_coreTestEn, PCL_aPortRregBypass, PCL_aRegE2, PCL_aRegForEaE2, PCL_abRegE1,
     PCL_addFour, PCL_apuTrcLoadEn, PCL_bPortLitGenSel, PCL_bPortRregBypass, PCL_bRegE2,
     PCL_bRegForEaE2, PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dcdAregLoadUse, PCL_dcdBregLoadUse,
     PCL_dcdHotCIn, PCL_dcdMdSelQ, PCL_dcdMrSelQ, PCL_dcdSregLoadUse, PCL_dcdXerCa,
     PCL_dofDregE1, PCL_dvcCmpEn, PCL_exe2Hold, PCL_exe2MacEn, PCL_exe2MacSat, PCL_exe2MultEn,
     PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp, PCL_exe2XerOvEn, PCL_exeAddEn,
     PCL_exeApuValidOp, PCL_exeAregLoadUse, PCL_exeBregLoadUse, PCL_exeCmplmntA,
     PCL_exeCmplmntA_NEG, PCL_exeDivEn, PCL_exeDivEnForLSSD, PCL_exeDivEn_NEG,
     PCL_exeDivSgndOp, PCL_exeDvcHold, PCL_exeEaCalc, PCL_exeFpuOp, PCL_exeLoadUseHold,
     PCL_exeLogicalUnitEnForLSSD, PCL_exeLogicalUnitEn_NEG, PCL_exeMacEn,
     PCL_exeMacOrMultEn_NEG, PCL_exeMfspr, PCL_exeMtspr, PCL_exeMultEn, PCL_exeNegMac,
     PCL_exeSprDataEn_NEG, PCL_exeSprUnitEn_NEG, PCL_exeSregLoadUse, PCL_exeSrmUnitEnForLSSD,
     PCL_exeSrmUnitEn_NEG, PCL_exeWrtee, PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_gateZeroToAreg,
     PCL_gateZeroToSreg, PCL_holdCIn, PCL_holdMdMr, PCL_ldAdjE1, PCL_lwbLpEqdcdApAddr,
     PCL_lwbLpEqdcdBpAddr, PCL_lwbLpEqdcdSpAddr, PCL_lwbLpWrEn, PCL_mfDCRL2, PCL_resultMuxSel,
     PCL_resultRegE1, PCL_resultRegE2, PCL_sPortRregBypass, PCL_sRegE1, PCL_sRegE2,
     PCL_sdqMuxSel, PCL_sprHold, PCL_sraRegE1, PCL_sraRegE2, PCL_srmRegE1, PCL_wbHold,
     PCL_wbRpEqdcdApAddr, PCL_wbRpEqdcdBpAddr, PCL_wbRpEqdcdSpAddr, PCL_wbRpWrEn,
     PCL_xerL2Hold, PGM_deterministicMult, coreReset,
     PCL_exeDvcOrParityHold, DCU_parityError;

output [0:31]  EXE_dcrDataBus;
output [0:31]  EXE_dcuData;
output [0:31]  EXE_raData;
output [0:3]  EXE_dvc1ByteCmp;
output [0:31]  EXE_timJtgSprDataBus;
output [0:9]  EXE_dcrAddr;
output [0:31]  EXE_dsEA_NEG;
output [0:3]  EXE_cc;
output [4:9]  EXE_sprAddr;
output [0:31]  EXE_mmuIcuSprDataBus;
output [0:31]  EXE_apuLoadData;
output [0:31]  EXE_ifbSprDataBus;
output [0:6]  EXE_xerTBC;
output [0:21]  EXE_eaARegBuf;
output [0:31]  EXE_rbData;
output [0:3]  EXE_dvc2ByteCmp;
output [0:2]  EXE_xer;
output [0:21]  EXE_eaBRegBuf;
output [0:31]  EXE_vctDbgSprDataBus;
output [30:31]  EXE_ea;
output [0:7]  EXE_dsEaCP_NEG;
output [0:6]  EXE_xerTBCIn;


input [0:3]  PCL_dbgSprDcds;
//input [0:1]  EXE_gprSI;
input [11:31]  PCL_dcdImmd;
input [0:7]  PCL_exeLogicalCntl;
input [0:1]  PCL_exe2AccRegMuxSel;
input [0:31]  VCT_sprDataBus;
input [0:31]  XXX_dcrDataBus;
input [0:3]  PCL_dvcByteEnL2;
input [0:31]  DBG_sprDataBus;
input [0:4]  PCL_dcdLitCntl;
input [0:1]  PCL_exeMultEn_NEG;
input [0:1]  PCL_ldAdjMuxSel;

//input [0:4]  PCL_vctSprDcds;
//input [0:7]  PCL_vctSprDcds;
//input [0:6]  PCL_vctSprDcds;
input [0:5]  PCL_vctSprDcds;

input [0:31]  OCM_dsData;
input [0:2]  PCL_dcdSrmBpSel;
input [0:3]  PCL_exeSrmCntl;
input [0:31]  APU_exeResult;
input [0:31]  IFB_sprDataBus;
input [0:2]  PCL_exeSrmBpSel;
input [0:4]  PCL_exeTrapCond;
input [0:31]  DCU_SDQ_mod_NEG;
input [0:31]  JTG_sprDataBus;
input [0:1]  PCL_exeDivEnForMuxSel;
input [0:7]  PCL_ldSteerMuxSel;
input [0:3]  APU_exeCr;
input [0:31]  DCU_data_NEG;
input [0:9]  PCL_dcdApAddr;
input [0:1]  PCL_exeMultEnForMuxSel;
input [0:4]  PCL_wbRpAddr;
input [0:7]  PCL_ldMuxSel;
input [0:9]  PCL_dcdSpAddr;
input [0:4]  PCL_exeSprDcds;
input [0:31]  TIM_sprDataBus;
input [0:3]  PCL_exeRbEn;
input [0:9]  PCL_dcdBpAddr;
input [0:3]  PCL_exeRaEn;
input [1:3]  PCL_ldAdjE2;
input [0:1]  PCL_exe2MacOrMultEnForMS;
input [0:5]  PCL_timSprDcds;
input [0:5]  PCL_ldFillByPassMuxSel;
input [0:4]  PCL_lwbLpAddr;
input [0:1]  PCL_exe2MacOrMultEn_NEG;
input [0:3]  PCL_exeAdmCntl;
input [0:1]  PCL_exeAddSgndOp_NEG;
//input [0:4]  CB;
input CB;
input [0:2]  PCL_srmRegE2;
input [0:1]  PCL_dofDregMuxSel;
input [0:31]  MMU_sprDataBus;
input [0:3]  PCL_exeEaQwEn;
input [0:31]  ICU_sprDataBus;
// Defect 2297
input EXE_gprSysClkPI;
input EXE_gprRen;
// Defect 2299

// Buses in the design

wire  [0:1]  bRegMuxSel;

//wire  [0:31]  sRegL2;

wire  [0:1]  rRegBypassMuxSel;

wire  [0:2]  multHiEOAnsCc;

wire  [0:1]  sRegMuxSel;

wire  [0:1]  admCcMuxSel;

wire  [0:2]  multLo4CycAnsCc;

wire  [0:15]  srmL2;

//wire  [0:4]  srmME_NEG_L2;

wire  [0:31]  rRegBypassForAccReg;

wire  [0:7]  EXE_dsEaCP;

wire  [0:1]  symNet1439;

wire  [0:2]  srmCcBits;

wire  [0:5]  srmShift_NEG;

wire  [0:2]  logicalCcBits;

wire  [0:1]  exeResultMuxSel;

wire  [0:31]  gprLpIn;

wire  [28:31]  dsQwEa;

wire  [0:31]  logicalOut;

wire  [0:4]  symNet1622;

wire  [0:2]  admCcBits;

//wire  [0:5]  srmShiftL2;

wire  [0:31]  bBusForEa;

wire  [0:2]  macSatValue;

wire  [0:31]  dac2L2;

wire  [0:4]  srmMB_NEG;

//wire  [0:31]  sraRegL2;

wire  [0:31]  bRegForEaL2_NEG;

wire  [0:31]  dsEaForResult;

wire  [0:31]  rbData_NEG;

wire  [26:31]  rRegBypassForSrm;

wire  [0:31]  raData_NEG;

wire  [0:31]  admOut;

wire  [0:31]  sPort;

wire  [0:31]  divOrZero;

wire  [0:31]  dac1L2;

//wire  [0:31]  bRegL2;

wire  [0:31]  rRegBypass_NEG;

wire  [0:31]  resultBus;

wire  [0:31]  bReg_NEG;

wire  [0:1]  aRegMuxSel;

//wire  [0:31]  aRegL2;

wire  [0:31]  sprBusEnd;

wire  [0:31]  apuExeResult_NEG;

//wire  [0:31]  symNet1512;

//wire  [0:31]  exeResult;

wire  [0:31]  rRegL2;

wire  [0:31]  aBus;

wire  [0:31]  sBus;

wire  [0:2]  multLo5CycAnsCc;

wire  [0:31]  srmOut;

//wire  [1:4]  CB_buf;

wire  [0:31]  aPort;

//wire  [3:3]  CB_buf2;

//wire  [3:3]  CB_buf1;

wire  [0:31]  bBus;

//wire  [0:4]  srmMBL2;

wire  [0:31]  dsEa;

wire  [0:31]  dsEaForDAC;

wire  [0:31]  aBusForEa;

wire  [0:31]  dRegBypass;

wire  [0:31]  exeSprDataBus;

wire  [0:31]  aReg_NEG;

wire  [0:5]  srmMuxSel;

wire  [0:31]  apuExeResultBuf;

wire  [0:31]  dvc2L2;

wire  [0:31]  dvc1L2;

wire  [0:4]  aRegZ4dndSEIn;

wire  [0:31]  litGen;

wire  [0:31]  rRegBypass;

wire  [0:31]  bPort;

wire  [0:31]  aRegForEaL2_NEG;

wire  [0:31]  sReg_NEG;

// Defect 2297
//wire osc_return;
//wire oscnandout; 
wire macOVSat_NEG;

wire nxtXerCa, addCA, addOV, resetL2, divOV, dlmzb, multOV, srmCA, divNxtToLastSt, macOV;

reg [16:31] regEXE_bRegLo_muxout;
reg [0:31] bRegL2;
reg [0:31] aRegL2;
reg [16:31] regEXE_sRegLo_muxout;
reg [0:31] sRegL2;
reg [0:15] regEXE_sRegHi_muxout;
reg [0:4] regEXE_srmMB_muxout;
reg [0:4] srmMBL2;
reg [0:4] regEXE_srmME_muxout;
reg [0:4] srmME_NEG_L2;
reg [16:31] regEXE_bRegForEaLo_muxout;
reg [16:31] regEXE_bRegForEaLo_L2;
reg [0:15] regEXE_bRegForEaHi_muxout;
reg [0:15] regEXE_bRegForEaHi_L2;
reg [16:31] regEXE_aRegForEaLo_muxout;
reg [16:31] regEXE_aRegForEaLo_L2;
reg [0:15] regEXE_aRegForEaHi_muxout;
reg [0:15] regEXE_aRegForEaHi_L2;
reg [0:15] regEXE_bRegHi_muxout;
reg [16:31] regEXE_aRegLo_muxout;
reg [0:15] regEXE_aRegHi_muxout;
reg [0:5] regEXE_srmShift_muxout;
reg [0:5] srmShiftL2;
reg [0:31] exeResult;
reg [0:31] symNet1512;
reg [0:31] regEXE_rReg_L2;
reg [0:31] sraRegL2;
wire nxtQ_NEG;

//specify
//    specparam CDS_LIBNAME  = "PR_exe";
//    specparam CDS_CELLNAME = "exe_top";
//    specparam CDS_VIEWNAME = "schematic";
//endspecify

   // Replacing instantiation: GTECH_XOR2 I599
   wire dacEn;
   assign dacEn = LSSD_coreTestEn ^ DBG_dacEn;

//dp_logEXE_rRegBypassForAccInv logEXE_rRegBypassForAccInv(rRegBypass_NEG[0:31],
//     rRegBypassForAccReg[0:31]);
// Removed the module 'dp_logEXE_rRegBypassForAccInv'
assign rRegBypassForAccReg[0:31] = ~(rRegBypass_NEG[0:31]);
//dp_logEXE_apuExeResultInv1 logEXE_apuExeResultInv1(apuExeResult_NEG[0:31],
//     apuExeResultBuf[0:31]);
// Removed the module 'dp_logEXE_apuExeResultInv1'
assign apuExeResultBuf[0:31] = ~(apuExeResult_NEG[0:31]);
//dp_logEXE_dsEaCPInv logEXE_dsEaCPInv(EXE_dsEaCP[0:7], EXE_dsEaCP_NEG[0:7]);
// Removed the module 'dp_logEXE_dsEaCPInv'
assign EXE_dsEaCP_NEG[0:7] = ~(EXE_dsEaCP[0:7]);
//dp_logEXE_ea3031INV logEXE_ea3031INV(symNet1439[0:1], EXE_ea[30:31]);
// Removed the module 'dp_logEXE_ea3031INV'
assign EXE_ea[30:31] = ~(symNet1439[0:1]);
//dp_logEXE_dsEaForceAlgnNAND2 logEXE_dsEaForceAlgnNAND2(PCL_exeEaQwEn[2:3], dsQwEa[30:31],
//     symNet1439[0:1]);
// Removed the module 'dp_logEXE_dsEaForceAlgnNAND2'
assign symNet1439[0:1] = ~(PCL_exeEaQwEn[2:3] & dsQwEa[30:31]);
//dp_logEXE_dsEaDacLoNAND2 logEXE_dsEaDacLoNAND2(dsEa[16:31], dacEn, dsEaForDAC[16:31]);
// Removed the module 'dp_logEXE_dsEaDacLoNAND2'
assign dsEaForDAC[16:31] = ~(dsEa[16:31] & {(16){dacEn}} );
//dp_logEXE_dsEaDacHiNAND2 logEXE_dsEaDacHiNAND2(dsEa[0:15], dacEn, dsEaForDAC[0:15]);
// Removed the module 'dp_logEXE_dsEaDacHiNAND2'
assign dsEaForDAC[0:15] = ~(dsEa[0:15] & {(16){dacEn}} );

p405s_SM_ADD32INTCO
 eaAdder(
  .CP(EXE_dsEaCP[0:7]),
  .SUM({dsEa[0:27], dsQwEa[28:31]}),
  .A(aBusForEa[0:31]),
  .B(bBusForEa[0:31]));

//dp_logEXE_rRegBypassForSrmInv logEXE_rRegBypassForSrmInv(rRegBypass_NEG[26:31],
//     rRegBypassForSrm[26:31]);
// Removed the module 'dp_logEXE_rRegBypassForSrmInv'
assign rRegBypassForSrm[26:31] = ~(rRegBypass_NEG[26:31]);
//dp_logEXE_dsEaForceAlgnAND2 logEXE_dsEaForceAlgnAND2(PCL_exeEaQwEn[0:3], dsQwEa[28:31],
//     dsEa[28:31]);
// Removed the module 'dp_logEXE_dsEaForceAlgnAND2'
assign dsEa[28:31] = PCL_exeEaQwEn[0:3] & dsQwEa[28:31];
//dp_logEXE_dsEaForResultBuf logEXE_dsEaForResultBuf(dsEa[0:31], dsEaForResult[0:31]);
// Removed the module 'dp_logEXE_dsEaForResultBuf'
assign dsEaForResult[0:31] = dsEa[0:31];
//dp_logEXE_bRegForEaInv1 logEXE_bRegForEaInv1(bRegForEaL2_NEG[0:31], bBusForEa[0:31]);
// Removed the module 'dp_logEXE_bRegForEaInv1'
assign bBusForEa[0:31] = ~(bRegForEaL2_NEG[0:31]);
//dp_logEXE_aRegForEaInv1 logEXE_aRegForEaInv1(aRegForEaL2_NEG[0:31], aBusForEa[0:31]);
// Removed the module 'dp_logEXE_aRegForEaInv1'
assign aBusForEa[0:31] = ~(aRegForEaL2_NEG[0:31]);
//dp_regEXE_bRegForEaLo regEXE_bRegForEaLo({CB, CB_buf[1:4]}, bPort[16:31], rRegBypass[16:31],
//     dRegBypass[16:31], litGen[16:31], PCL_abRegE1, PCL_bRegForEaE2, bRegForEaHiSO,
//    bRegMuxSel[0:1], bRegForEaL2_NEG[16:31], bRegForEaLoSO);
// Removed the module 'dp_regEXE_bRegForEaLo'
assign bRegForEaL2_NEG[16:31] = ~(regEXE_bRegForEaLo_L2[16:31]);
 always @(bPort or rRegBypass or dRegBypass or litGen or bRegMuxSel)      
    begin                                       
    casez(bRegMuxSel[0:1])                    
     2'b00: regEXE_bRegForEaLo_muxout = bPort[16:31];  
     2'b01: regEXE_bRegForEaLo_muxout = rRegBypass[16:31];  
     2'b10: regEXE_bRegForEaLo_muxout = dRegBypass[16:31];  
     2'b11: regEXE_bRegForEaLo_muxout = litGen[16:31];  
      default: regEXE_bRegForEaLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_bRegForEaE2)                
     1'b0: regEXE_bRegForEaLo_L2[16:31] <= regEXE_bRegForEaLo_L2[16:31];                
     1'b1: regEXE_bRegForEaLo_L2[16:31] <= regEXE_bRegForEaLo_muxout;       
      default: regEXE_bRegForEaLo_L2[16:31] <= 16'bx;  
    endcase                             
   end   
//dp_regEXE_bRegForEaHi regEXE_bRegForEaHi({CB, CB_buf[1:4]}, bPort[0:15], rRegBypass[0:15],
//     dRegBypass[0:15], litGen[0:15], PCL_abRegE1, PCL_bRegForEaE2, aRegForEaLoSO,
//     bRegMuxSel[0:1], bRegForEaL2_NEG[0:15], bRegForEaHiSO);
// Removed the module 'dp_regEXE_bRegForEaHi'
assign bRegForEaL2_NEG[0:15] = ~(regEXE_bRegForEaHi_L2);
always @(bPort or rRegBypass or dRegBypass or litGen or bRegMuxSel)      
    begin                                       
    casez(bRegMuxSel[0:1])                    
     2'b00: regEXE_bRegForEaHi_muxout = bPort[0:15];  
     2'b01: regEXE_bRegForEaHi_muxout = rRegBypass[0:15];  
     2'b10: regEXE_bRegForEaHi_muxout = dRegBypass[0:15];  
     2'b11: regEXE_bRegForEaHi_muxout = litGen[0:15];  
      default: regEXE_bRegForEaHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_bRegForEaE2)                
     1'b0: regEXE_bRegForEaHi_L2 <= regEXE_bRegForEaHi_L2;                
     1'b1: regEXE_bRegForEaHi_L2 <= regEXE_bRegForEaHi_muxout;       
      default: regEXE_bRegForEaHi_L2 <= 16'bx;  
    endcase                             
   end  
//dp_regEXE_aRegForEaLo regEXE_aRegForEaLo({CB, CB_buf[1:4]}, aPort[16:31], rRegBypass[16:31],
//     dRegBypass[16:31], {aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
//     aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
//     aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
//     aRegZ4dndSEIn[4], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3]}, PCL_abRegE1, PCL_aRegForEaE2,
//     aRegForEaHiSO, aRegMuxSel[0:1], aRegForEaL2_NEG[16:31], aRegForEaLoSO);
// Removed the module 'dp_regEXE_aRegForEaLo'
assign aRegForEaL2_NEG[16:31] = ~(regEXE_aRegForEaLo_L2);
always @(aPort or rRegBypass or dRegBypass or aRegZ4dndSEIn or aRegMuxSel)      
    begin                                       
    casez(aRegMuxSel[0:1])
     2'b00: regEXE_aRegForEaLo_muxout = aPort[16:31];  
     2'b01: regEXE_aRegForEaLo_muxout = rRegBypass[16:31];  
     2'b10: regEXE_aRegForEaLo_muxout = dRegBypass[16:31];  
     2'b11: regEXE_aRegForEaLo_muxout = {aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
     aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
     aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3],
     aRegZ4dndSEIn[4], aRegZ4dndSEIn[3], aRegZ4dndSEIn[3]};  
      default: regEXE_aRegForEaLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_aRegForEaE2)                
     1'b0: regEXE_aRegForEaLo_L2 <= regEXE_aRegForEaLo_L2;                
     1'b1: regEXE_aRegForEaLo_L2 <= regEXE_aRegForEaLo_muxout;       
      default: regEXE_aRegForEaLo_L2 <= 16'bx;  
    endcase                             
   end   
//dp_regEXE_aRegForEaHi regEXE_aRegForEaHi({CB, CB_buf[1:4]}, aPort[0:15], rRegBypass[0:15],
//     dRegBypass[0:15], {aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
//     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
//     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
//     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2]}, PCL_abRegE1, PCL_aRegForEaE2, ldSteerSO,
//     aRegMuxSel[0:1], aRegForEaL2_NEG[0:15], aRegForEaHiSO);
// Removed the module 'dp_regEXE_aRegForEaHi'
assign aRegForEaL2_NEG[0:15] = ~(regEXE_aRegForEaHi_L2[0:15]);
always @(aPort or rRegBypass or dRegBypass or aRegZ4dndSEIn or aRegMuxSel)      
    begin                                       
    casez(aRegMuxSel[0:1])                    
     2'b00: regEXE_aRegForEaHi_muxout = aPort[0:15];  
     2'b01: regEXE_aRegForEaHi_muxout = rRegBypass[0:15];  
     2'b10: regEXE_aRegForEaHi_muxout = dRegBypass[0:15];  
     2'b11: regEXE_aRegForEaHi_muxout = {aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2], aRegZ4dndSEIn[2],
     aRegZ4dndSEIn[2], aRegZ4dndSEIn[2]};  
      default: regEXE_aRegForEaHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_aRegForEaE2)                
     1'b0: regEXE_aRegForEaHi_L2 <= regEXE_aRegForEaHi_L2;                
     1'b1: regEXE_aRegForEaHi_L2 <= regEXE_aRegForEaHi_muxout;       
      default: regEXE_aRegForEaHi_L2 <= 16'bx;  
    endcase                             
   end 
//dp_logEXE_rRegBypassInv logEXE_rRegBypassInv(rRegBypass_NEG[0:31], rRegBypass[0:31]);
// Removed the module 'dp_logEXE_rRegBypassInv'
assign rRegBypass[0:31] = ~(rRegBypass_NEG[0:31]);

//dp_muxEXE_macSat muxEXE_macSat({macSatValue[0], macSatValue[1], macSatValue[1], macSatValue[1],
//     macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1],
//     macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1],
//     macSatValue[1], macSatValue[1], macSatValue[2], macSatValue[2], macSatValue[2],
//     macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2],
//     macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2],
//     macSatValue[2], macSatValue[2], macSatValue[2]}, symNet1512[0:31], macOVSat_NEG,
//     rRegBypass_NEG[0:31]);
// Removed the module 'dp_muxEXE_macSat'
assign rRegBypass_NEG[0:31] = ~( (({macSatValue[0], macSatValue[1], macSatValue[1], macSatValue[1],
     macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1],
     macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1], macSatValue[1],
     macSatValue[1], macSatValue[1], macSatValue[2], macSatValue[2], macSatValue[2],
     macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2],
     macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2], macSatValue[2],
     macSatValue[2], macSatValue[2], macSatValue[2]}) & {(32){~(macOVSat_NEG)}} ) | (symNet1512[0:31] & {(32){macOVSat_NEG}} ) );
//dp_muxEXE_SDQmux muxEXE_SDQmux(sBus[0:31], apuExeResultBuf[0:31], PCL_sdqMuxSel,
//     EXE_dcuData[0:31]);
// Removed the module 'dp_muxEXE_SDQmux'
assign EXE_dcuData[0:31] = (sBus[0:31] & {(32){~(PCL_sdqMuxSel)}} ) | (apuExeResultBuf[0:31] & {(32){PCL_sdqMuxSel}} );
//dp_logEXE_bRegInv1 logEXE_bRegInv1(bRegL2[0:31], bReg_NEG[0:31]);
// Removed the module 'dp_logEXE_bRegInv1'
assign bReg_NEG[0:31] = ~(bRegL2[0:31]);
//dp_logEXE_bRegInv2 logEXE_bRegInv2(bReg_NEG[0:31], bBus[0:31]);
// Removed the module 'dp_logEXE_bRegInv2'
assign bBus[0:31] = ~(bReg_NEG[0:31]);
//dp_logEXE_aRegInv2 logEXE_aRegInv2(aReg_NEG[0:31], aBus[0:31]);
// Removed the module 'dp_logEXE_aRegInv2'
assign aBus[0:31] = ~(aReg_NEG[0:31]);
//dp_logEXE_aRegInv1 logEXE_aRegInv1(aRegL2[0:31], aReg_NEG[0:31]);
// Removed the module 'dp_logEXE_aRegInv1'
assign aReg_NEG[0:31] = ~(aRegL2[0:31]);
//dp_logEXE_sRegInv2 logEXE_sRegInv2(sReg_NEG[0:31], sBus[0:31]);
// Removed the module 'dp_logEXE_sRegInv2'
assign sBus[0:31] = ~(sReg_NEG[0:31]);
//dp_logEXE_sRegInv1 logEXE_sRegInv1(sRegL2[0:31], sReg_NEG[0:31]);
// Removed the module 'dp_logEXE_sRegInv1'
assign sReg_NEG[0:31] = ~(sRegL2[0:31]);
//dp_logEXE_srmShiftInv2 logEXE_srmShiftInv2(srmShift_NEG[0:5], srmL2[0:5]);
// Removed the module 'dp_logEXE_srmShiftInv2'
assign srmL2[0:5] = ~(srmShift_NEG[0:5]);
//dp_logEXE_srmShiftInv1 logEXE_srmShiftInv1(srmShiftL2[0:5], srmShift_NEG[0:5]);
// Removed the module 'dp_logEXE_srmShiftInv1'
assign srmShift_NEG[0:5] = ~(srmShiftL2[0:5]);
//dp_logEXE_srmMBInv2 logEXE_srmMBInv2(srmMB_NEG[0:4], srmL2[6:10]);
// Removed the module 'dp_logEXE_srmMBInv2'
assign srmL2[6:10] = ~(srmMB_NEG[0:4]);
//dp_logEXE_srmMBInv1 logEXE_srmMBInv1(srmMBL2[0:4], srmMB_NEG[0:4]);
// Removed the module 'dp_logEXE_srmMBInv1'
assign srmMB_NEG[0:4] = ~(srmMBL2[0:4]);
//dp_logEXE_srmMEInv logEXE_srmMEInv(srmME_NEG_L2[0:4], srmL2[11:15]);
// Removed the module 'dp_logEXE_srmMEInv'
assign srmL2[11:15] = ~(srmME_NEG_L2[0:4]);
//dp_regEXE_bRegLo regEXE_bRegLo({CB, CB_buf[1:4]}, bPort[16:31], rRegBypass[16:31],
//     dRegBypass[16:31], litGen[16:31], PCL_abRegE1, PCL_bRegE2, bRegHiSO, bRegMuxSel[0:1],
//     bRegL2[16:31], bRegLoSO);
// Removed the module 'dp_regEXE_bRegLo'
always @(bPort or rRegBypass or dRegBypass or litGen or bRegMuxSel)      
    begin                                       
    casez(bRegMuxSel[0:1])                    
     2'b00: regEXE_bRegLo_muxout = bPort[16:31];  
     2'b01: regEXE_bRegLo_muxout = rRegBypass[16:31];  
     2'b10: regEXE_bRegLo_muxout = dRegBypass[16:31];  
     2'b11: regEXE_bRegLo_muxout = litGen[16:31];  
      default: regEXE_bRegLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_bRegE2)                
     1'b0: bRegL2[16:31] <= bRegL2[16:31];                
     1'b1: bRegL2[16:31] <= regEXE_bRegLo_muxout;       
      default: bRegL2[16:31] <= 16'bx;  
    endcase                             
   end       
//dp_regEXE_bRegHi regEXE_bRegHi({CB, CB_buf[1:4]}, bPort[0:15], rRegBypass[0:15],
//     dRegBypass[0:15], litGen[0:15], PCL_abRegE1, PCL_bRegE2, aRegLoSO, bRegMuxSel[0:1],
//     bRegL2[0:15], bRegHiSO);
// Removed the module 'dp_regEXE_bRegHi'
always @(bPort or rRegBypass or dRegBypass or litGen or bRegMuxSel)      
    begin                                       
    casez(bRegMuxSel[0:1])                    
     2'b00: regEXE_bRegHi_muxout = bPort[0:15];  
     2'b01: regEXE_bRegHi_muxout = rRegBypass[0:15];  
     2'b10: regEXE_bRegHi_muxout = dRegBypass[0:15];  
     2'b11: regEXE_bRegHi_muxout = litGen[0:15];  
      default: regEXE_bRegHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_bRegE2)                
     1'b0: bRegL2[0:15] <= bRegL2[0:15];                
     1'b1: bRegL2[0:15] <= regEXE_bRegHi_muxout;       
      default: bRegL2[0:15] <= 16'bx;  
    endcase                             
   end  
//dp_regEXE_aRegLo regEXE_aRegLo({CB, CB_buf[1:4]}, aPort[16:31], rRegBypass[16:31],
//     dRegBypass[16:31], {aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
//     aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
//     aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
//     aRegZ4dndSEIn[4], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1]}, PCL_abRegE1, PCL_aRegE2, aRegHiSO,
//     aRegMuxSel[0:1], aRegL2[16:31], aRegLoSO);
// Removed the module 'dp_regEXE_bRegHi'
always @(aPort or rRegBypass or dRegBypass or aRegZ4dndSEIn or aRegMuxSel)      
    begin                                       
    casez(aRegMuxSel[0:1])                    
     2'b00: regEXE_aRegLo_muxout = aPort[16:31];  
     2'b01: regEXE_aRegLo_muxout = rRegBypass[16:31];  
     2'b10: regEXE_aRegLo_muxout = dRegBypass[16:31];  
     2'b11: regEXE_aRegLo_muxout = {aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
     aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
     aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1],
     aRegZ4dndSEIn[4], aRegZ4dndSEIn[1], aRegZ4dndSEIn[1]};  
      default: regEXE_aRegLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_aRegE2)                
     1'b0: aRegL2[16:31] <= aRegL2[16:31];                
     1'b1: aRegL2[16:31] <= regEXE_aRegLo_muxout;       
      default: aRegL2[16:31] <= 16'bx;  
    endcase                             
   end 
//dp_regEXE_aRegHi regEXE_aRegHi({CB, CB_buf[1:4]}, aPort[0:15], rRegBypass[0:15],
//     dRegBypass[0:15], {aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
//     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
//     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
//     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0]}, PCL_abRegE1, PCL_aRegE2, sRegLoSO, aRegMuxSel[0:1],
//     aRegL2[0:15], aRegHiSO);
// Removed the module 'dp_regEXE_aRegHi'
always @(aPort or rRegBypass or dRegBypass or aRegZ4dndSEIn or aRegMuxSel)
    begin                                       
    casez(aRegMuxSel[0:1])                    
     2'b00: regEXE_aRegHi_muxout = aPort[0:15];  
     2'b01: regEXE_aRegHi_muxout = rRegBypass[0:15];  
     2'b10: regEXE_aRegHi_muxout = dRegBypass[0:15];  
     2'b11: regEXE_aRegHi_muxout = {aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0], aRegZ4dndSEIn[0],
     aRegZ4dndSEIn[0], aRegZ4dndSEIn[0]};  
      default: regEXE_aRegHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_abRegE1 & PCL_aRegE2)
     1'b0: aRegL2[0:15] <= aRegL2[0:15];                
     1'b1: aRegL2[0:15] <= regEXE_aRegHi_muxout;       
      default: aRegL2[0:15] <= 16'bx;  
    endcase                             
   end  
//dp_regEXE_sRegLo regEXE_sRegLo({CB, CB_buf[1:4]}, sPort[16:31], rRegBypass[16:31],
//     dRegBypass[16:31], divOrZero[16:31], PCL_sRegE1, PCL_sRegE2, sRegHiSO, sRegMuxSel[0:1],
//     sRegL2[16:31], sRegLoSO);
// Removed the module 'dp_regEXE_sRegLo'
always @(sPort or rRegBypass or dRegBypass or divOrZero or sRegMuxSel)
    begin                                       
    casez(sRegMuxSel[0:1])                    
     2'b00: regEXE_sRegLo_muxout = sPort[16:31];  
     2'b01: regEXE_sRegLo_muxout = rRegBypass[16:31];  
     2'b10: regEXE_sRegLo_muxout = dRegBypass[16:31];  
     2'b11: regEXE_sRegLo_muxout = divOrZero[16:31];  
      default: regEXE_sRegLo_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_sRegE1 & PCL_sRegE2)                
     1'b0: sRegL2[16:31] <= sRegL2[16:31];                
     1'b1: sRegL2[16:31] <= regEXE_sRegLo_muxout;       
      default: sRegL2[16:31] <= 16'bx;  
    endcase                             
   end     
//dp_regEXE_sRegHi regEXE_sRegHi({CB, CB_buf[1:4]}, sPort[0:15], rRegBypass[0:15],
//     dRegBypass[0:15], divOrZero[0:15], PCL_sRegE1, PCL_sRegE2, bRegForEaLoSO, sRegMuxSel[0:1],
//     sRegL2[0:15], sRegHiSO);
// Removed the module 'dp_regEXE_sRegHi'
   always @(sPort or rRegBypass or dRegBypass or divOrZero or sRegMuxSel)
    begin                                       
    casez(sRegMuxSel[0:1])
     2'b00: regEXE_sRegHi_muxout = sPort[0:15];
     2'b01: regEXE_sRegHi_muxout = rRegBypass[0:15];  
     2'b10: regEXE_sRegHi_muxout = dRegBypass[0:15];  
     2'b11: regEXE_sRegHi_muxout = divOrZero[0:15];  
      default: regEXE_sRegHi_muxout = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_sRegE1 & PCL_sRegE2)
     1'b0: sRegL2[0:15] <= sRegL2[0:15];                
     1'b1: sRegL2[0:15] <= regEXE_sRegHi_muxout;       
      default: sRegL2[0:15] <= 16'bx;  
    endcase                             
   end                                  
//dp_logEXE_xerCaBuf logEXE_xerCaBuf(EXE_xer[2], EXE_xerCa);
// Removed the module 'dp_logEXE_xerCaBuf'
wire [0:2] EXE_xer, EXE_xer_i;
assign EXE_xer = EXE_xer_i;
assign EXE_xerCa = EXE_xer_i[2];
//dp_logEXE_eaBregBuf logEXE_eaBregBuf(bBusForEa[0:21], EXE_eaBRegBuf[0:21]);
// Removed the module 'dp_logEXE_eaBregBuf'
assign EXE_eaBRegBuf[0:21] = bBusForEa[0:21];
//dp_logEXE_eaAregBuf logEXE_eaAregBuf(aBusForEa[0:21], EXE_eaARegBuf[0:21]);
// Removed the module 'dp_logEXE_eaAregBuf'
assign EXE_eaARegBuf[0:21] = aBusForEa[0:21];
//dp_logEXE_apuExeResultInv logEXE_apuExeResultInv(APU_exeResult[0:31], apuExeResult_NEG[0:31]);
// Removed the module 'dp_logEXE_apuExeResultInv'
assign apuExeResult_NEG[0:31] = ~(APU_exeResult[0:31]);
//dp_logEXE_dsEaInv logEXE_dsEaInv(dsEa[0:31], EXE_dsEA_NEG[0:31]);
// Removed the module 'dp_logEXE_dsEaInv'
assign EXE_dsEA_NEG[0:31] = ~(dsEa[0:31]);
//dp_logEXE_divOrZeroAND2 logEXE_divOrZeroAND2({divPathEn, divPathEn, divPathEn, divPathEn,
//     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
//     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
//     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
//     divPathEn, divPathEn, divPathEn, divPathEn}, {sBus[1:31], nxtQ}, divOrZero[0:31]);
// Removed the module 'dp_logEXE_divOrZeroAND2'
wire divPathEn;
wire nxtQ;
assign divOrZero[0:31] = {divPathEn, divPathEn, divPathEn, divPathEn,
     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
     divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn, divPathEn,
     divPathEn, divPathEn, divPathEn, divPathEn} & {sBus[1:31], nxtQ};
//dp_regEXE_srmME regEXE_srmME({CB, CB_buf[1:4]}, symNet1622[0:4], dRegBypass[27:31],
//     bPort[27:31], rRegBypassForSrm[27:31], PCL_srmRegE1, PCL_srmRegE2[2], srmMBSO,
//     srmMuxSel[4:5], srmME_NEG_L2[0:4], srmMESO);
// Removed the module 'dp_regEXE_srmME'
always @(symNet1622 or dRegBypass or bPort or rRegBypassForSrm or srmMuxSel)
    begin                                       
    casez(srmMuxSel[4:5])                    
     2'b00: regEXE_srmME_muxout = symNet1622[0:4];  
     2'b01: regEXE_srmME_muxout = dRegBypass[27:31];  
     2'b10: regEXE_srmME_muxout = bPort[27:31];  
     2'b11: regEXE_srmME_muxout = rRegBypassForSrm[27:31];  
      default: regEXE_srmME_muxout = 5'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_srmRegE1 & PCL_srmRegE2[2])                
     1'b0: srmME_NEG_L2[0:4] <= srmME_NEG_L2[0:4];                
     1'b1: srmME_NEG_L2[0:4] <= regEXE_srmME_muxout;       
      default: srmME_NEG_L2[0:4] <= 5'bx;  
    endcase                             
   end 
//dp_regEXE_srmMB regEXE_srmMB({CB, CB_buf[1:4]}, litGen[21:25], dRegBypass[27:31],
//     bPort[27:31], rRegBypassForSrm[27:31], PCL_srmRegE1, PCL_srmRegE2[1], srmShiftSO,
//     srmMuxSel[2:3], srmMBL2[0:4], srmMBSO);
// Removed the module 'dp_regEXE_srmMB'
always @(litGen or dRegBypass or bPort or rRegBypassForSrm or srmMuxSel)
    begin                                       
    casez(srmMuxSel[2:3])                    
     2'b00: regEXE_srmMB_muxout = litGen[21:25];
     2'b01: regEXE_srmMB_muxout = dRegBypass[27:31];  
     2'b10: regEXE_srmMB_muxout = bPort[27:31];  
     2'b11: regEXE_srmMB_muxout = rRegBypassForSrm[27:31];  
      default: regEXE_srmMB_muxout = 5'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_srmRegE1 & PCL_srmRegE2[1])                
     1'b0: srmMBL2[0:4] <= srmMBL2[0:4];                
     1'b1: srmMBL2[0:4] <= regEXE_srmMB_muxout;       
      default: srmMBL2[0:4] <= 5'bx;  
    endcase
  end
//dp_regEXE_srmShift regEXE_srmShift({CB, CB_buf[1:4]}, litGen[15:20], dRegBypass[26:31],
//     bPort[26:31], rRegBypassForSrm[26:31], PCL_srmRegE1, PCL_srmRegE2[0], bRegLoSO,
//     srmMuxSel[0:1], srmShiftL2[0:5], srmShiftSO);
// Removed the module 'dp_regEXE_srmShift'
always @(litGen or dRegBypass or bPort or rRegBypassForSrm or srmMuxSel)
    begin                                       
    casez(srmMuxSel[0:1])                    
     2'b00: regEXE_srmShift_muxout = litGen[15:20];  
     2'b01: regEXE_srmShift_muxout = dRegBypass[26:31];  
     2'b10: regEXE_srmShift_muxout = bPort[26:31];  
     2'b11: regEXE_srmShift_muxout = rRegBypassForSrm[26:31];  
      default: regEXE_srmShift_muxout = 6'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_srmRegE1 & PCL_srmRegE2[0])
     1'b0: srmShiftL2[0:5] <= srmShiftL2[0:5];                
     1'b1: srmShiftL2[0:5] <= regEXE_srmShift_muxout;       
      default: srmShiftL2[0:5] <= 6'bx;  
    endcase                             
   end 
//dp_muxEXE_exeResult muxEXE_exeResult(dsEaForResult[0:31], srmOut[0:31], logicalOut[0:31],
//     sprBusEnd[0:31], exeResultMuxSel[0:1], exeResult[0:31]);
// Removed the module 'dp_muxEXE_exeResult'
always @(exeResultMuxSel or dsEaForResult or srmOut or logicalOut or sprBusEnd)
    begin                                           
    case(exeResultMuxSel[0:1])                       
     2'b00: exeResult[0:31] = ~dsEaForResult[0:31];
     2'b01: exeResult[0:31] = ~srmOut[0:31];   
     2'b10: exeResult[0:31] = ~logicalOut[0:31];   
     2'b11: exeResult[0:31] = ~sprBusEnd[0:31];   
      default: exeResult[0:31] = 32'bx;   
    endcase                                    
   end 
//dp_logEXE_aClkBuf logEXE_aClkBuf({CB[3], CB[3]}, {CB_buf1[3], CB_buf2[3]});
// Removed the module 'dp_logEXE_aClkBuf'
//assign {CB_buf1[3], CB_buf2[3]} = {CB[3], CB[3]};
//dp_logEXE_rbDataNAND2 logEXE_rbDataNAND2(bBus[0:31], {PCL_exeRbEn[0], PCL_exeRbEn[0],
//     PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0],
//     PCL_exeRbEn[0], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1],
//     PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[2],
//     PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2],
//     PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3],
//     PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3]},
//     rbData_NEG[0:31]);
// Removed the module 'dp_logEXE_rbDataNAND2'
assign rbData_NEG[0:31] = ~( bBus[0:31] & {PCL_exeRbEn[0], PCL_exeRbEn[0],
     PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0], PCL_exeRbEn[0],
     PCL_exeRbEn[0], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1],
     PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[1], PCL_exeRbEn[2],
     PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[2],
     PCL_exeRbEn[2], PCL_exeRbEn[2], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3],
     PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3], PCL_exeRbEn[3]} );
//dp_logEXE_rbDataINV logEXE_rbDataINV(rbData_NEG[0:31], EXE_rbData[0:31]);
// Removed the module 'dp_logEXE_rbDataINV'
assign EXE_rbData[0:31] = ~(rbData_NEG[0:31]);
//dp_logEXE_raDataINV logEXE_raDataINV(raData_NEG[0:31], EXE_raData[0:31]);
// Removed the module 'dp_logEXE_raDataINV'
assign EXE_raData[0:31] = ~(raData_NEG[0:31]);
//dp_logEXE_raDataNAND2 logEXE_raDataNAND2({PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0],
//     PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0],
//     PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1],
//     PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[2], PCL_exeRaEn[2],
//     PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2],
//     PCL_exeRaEn[2], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3],
//     PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3]}, aBus[0:31],
//     raData_NEG[0:31]);
// Removed the module 'dp_logEXE_raDataNAND2'
assign raData_NEG[0:31] = ~( {PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0],
     PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0], PCL_exeRaEn[0],
     PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1],
     PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[1], PCL_exeRaEn[2], PCL_exeRaEn[2],
     PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2], PCL_exeRaEn[2],
     PCL_exeRaEn[2], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3],
     PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3], PCL_exeRaEn[3]} & aBus[0:31] );

p405s_SM_GPR2W3R32X32_RTP
 gpr(
  .aPort(aPort[0:31]),
  .bPort(bPort[0:31]),
  .sPort(sPort[0:31]),
  .lPort(gprLpIn[0:31]),
  .rPort(resultBus[0:31]),
  .ApAddr(PCL_dcdApAddr[0:9]),
  .BpAddr(PCL_dcdBpAddr[0:9]),
  .SpAddr(PCL_dcdSpAddr[0:9]),
  .LpAddr(PCL_lwbLpAddr[0:4]),
  .LpWE(PCL_lwbLpWrEn),
  .RpAddr(PCL_wbRpAddr[0:4]),
  .RpWE(PCL_wbRpWrEn),
  .LpEqAp(PCL_lwbLpEqdcdApAddr),
  .LpEqBp(PCL_lwbLpEqdcdBpAddr),
  .LpEqSp(PCL_lwbLpEqdcdSpAddr),
  .RpEqAp(PCL_wbRpEqdcdApAddr),
  .RpEqBp(PCL_wbRpEqdcdBpAddr),
  .RpEqSp(PCL_wbRpEqdcdSpAddr),
  .BpEqSp(PCL_BpEqSp),
  .SysClk(CB),
  .EXE_gprRen(EXE_gprRen),
  .EXE_gprSysClkPI(EXE_gprSysClkPI));

      
//exeClkBuf exeClkBufSch( CB_buf[1:4], gprAClk_NEG, gprBClk_NEG, CB[1:4]);
// Removed the module 'exeClkBuf'


p405s_SM_ADD32CODETONE
 dac1Adder(
  .CO(EXE_dac1CO),
  .SUMEQ0(EXE_dac1SumBit31Eq),
  .SUMEQ1(EXE_dac1SumBit30Eq),
  .SUMEQ4TO2(EXE_dac1SumBits28and29Eq),
  .SUMEQ31TO5(EXE_dac1SumBits0thru27Eq),
  .A(dac1L2[0:31]),
  .B(dsEaForDAC[0:31]));

p405s_SM_ADD32CODETONE
 dac2Adder(
  .CO(EXE_dac2CO),
  .SUMEQ0(EXE_dac2SumBit31Eq),
  .SUMEQ1(EXE_dac2SumBit30Eq),
  .SUMEQ4TO2(EXE_dac2SumBits28and29Eq),
  .SUMEQ31TO5(EXE_dac2SumBits0thru27Eq),
  .A(dac2L2[0:31]),
  .B(dsEaForDAC[0:31]));

   // Replacing instantiation: GTECH_AO22 I251
   wire symNet1715;
   assign EXE_wrteeIn = (bBus[16] & symNet1715) | (PCL_exeWrtee & aBus[16]);
wire [0:6] EXE_xerTBC, EXE_xerTBC_i;
assign EXE_xerTBC = EXE_xerTBC_i;
p405s_xer_top
 xer(
  .EXE_cc(EXE_cc[0:3]),
  .EXE_xer(EXE_xer_i[0:2]),
  .EXE_xerTBC(EXE_xerTBC_i[0:6]),
  .EXE_xerTBCNotEqZero(EXE_xerTBCNotEqZero),
  .nxtXerCa(nxtXerCa),
  .rRegBypassMuxSel(rRegBypassMuxSel[0:1]),
  .APU_exeCa(APU_exeCa),
  .APU_exeOv(APU_exeOv),
  .CB(CB),
  .PCL_exeLogicalUnitEnForLSSD(PCL_exeLogicalUnitEnForLSSD),
  .APU_exeCr(APU_exeCr[0:3]),
  .PCL_exeMcrxr(IFB_exeMcrxr),
  .PCL_exeMtspr(PCL_exeMtspr),
  .PCL_exeSprUnitEn_NEG(PCL_exeSprUnitEn_NEG),
  .PCL_exeSrmUnitEnForLSSD(PCL_exeSrmUnitEnForLSSD),
  .PCL_exeXerCaEn(PCL_exeXerCaEn),
  .PCL_exeXerOvEn(PCL_exeXerOvEn),
  .PCL_xerL2Hold(PCL_xerL2Hold),
  .addCA(addCA),
  .addOV(addOV),
  .addUnitEn(PCL_exeAddEn),
  .admCcBits(admCcBits[0:2]),
  .resetL2(resetL2),
  .divOV(divOV),
  .dlmzb(dlmzb),
  .logicalCcBits(logicalCcBits[0:2]),
  .lsaOut(logicalOut[28:31]),
  .multOV(multOV),
  .sprBusIn(exeSprDataBus[0:31]),
  .srmCA(srmCA),
  .xerDcd(PCL_exeSprDcds[4]),
  .EXE_xerTBCIn(EXE_xerTBCIn[0:6]),
  .srmCcBits(srmCcBits[0:2]),
  .PCL_exe2XerOvEn(PCL_exe2XerOvEn),
  .exeResultMuxSel(exeResultMuxSel[0:1]),
  .PCL_exeEaCalc(PCL_exeEaCalc),
  .divNxtToLastSt(divNxtToLastSt),
  .macOV(macOV),
  .multHiEOAnsCc(multHiEOAnsCc[0:2]),
  .multLo4CycAnsCc(multLo4CycAnsCc[0:2]),
  .multLo5CycAnsCc(multLo5CycAnsCc[0:2]),
  .admCcMuxSel(admCcMuxSel[0:1]),
  .IFB_exeOpForExe2L2(IFB_exeOpForExe2L2),
  .PCL_exeFpuOp(PCL_exeFpuOp),
  .PCL_exeApuValidOp(PCL_exeApuValidOp));

p405s_logical_top
 logical(
  .logicalCcBits(logicalCcBits[0:2]),
  .logicalOut(logicalOut[0:31]),
  .dlmzb(dlmzb),
  .exeLogicalUnitEn_NEG(PCL_exeLogicalUnitEn_NEG),
  .aBus(aBus[0:31]),
  .bBus(bBus[0:31]),
  .logicalCntl(PCL_exeLogicalCntl[0:7]));


//dp_muxEXE_result muxEXE_result(rRegL2[0:31], sraRegL2[0:31], PCL_resultMuxSel,
//     resultBus[0:31]);
// Removed the module 'dp_muxEXE_result'
assign resultBus[0:31] = (rRegL2[0:31] & {(32){~(PCL_resultMuxSel)}} ) | (sraRegL2[0:31] & {(32){PCL_resultMuxSel}} );
//dp_regEXE_sraReg regEXE_sraReg({CB, CB_buf[1:4]}, aBus[0:31], PCL_sraRegE1, PCL_sraRegE2,
//     admSO, sraRegL2[0:31], sraRegSO);
// Removed the module 'dp_regEXE_sraReg'
always @(posedge CB)      
    begin                                       
    casez(PCL_sraRegE1 & PCL_sraRegE2)                
     1'b0: sraRegL2[0:31] <= sraRegL2[0:31];                
     1'b1: sraRegL2[0:31] <= aBus[0:31];            
      default: sraRegL2[0:31] <= 32'bx;  
    endcase                             
   end   

p405s_sprMux_top
 sprMux(
  .sprBusEnd(sprBusEnd[0:31]),
  .DBG_sprDataBus(DBG_sprDataBus[0:31]),
  .EXE_xer(EXE_xer_i[0:2]),
  .EXE_xerSIL(EXE_xerTBC_i[0:6]),
  .IFB_sprDataBus(IFB_sprDataBus[0:31]),
  .JTG_sprDataBus(JTG_sprDataBus[0:31]),
  .PCL_mfDCRL2(PCL_mfDCRL2),
  .PCL_exeMfspr(PCL_exeMfspr),
  .TIM_sprDataBus(TIM_sprDataBus[0:31]),
  .VCT_sprDataBus(VCT_sprDataBus[0:31]),
  .XXX_dcrDataBus(XXX_dcrDataBus[0:31]),
  .ICU_sprDataBus(ICU_sprDataBus[0:31]),
  .MMU_sprDataBus(MMU_sprDataBus[0:31]),
  .sprDataBus(exeSprDataBus[0:31]),
  .PCL_sprHold(PCL_sprHold),
  .CB(CB),
  .dac1L2(dac1L2[0:31]),
  .dac2L2(dac2L2[0:31]),
  .PCL_exeMtspr(PCL_exeMtspr),
  .dvc1L2(dvc1L2[0:31]),
  .dvc2L2(dvc2L2[0:31]),
  .PCL_timSprDcds(PCL_timSprDcds[0:5]),
  .PCL_dbgSprDcds(PCL_dbgSprDcds[0:3]),
  .PCL_exeSprDcds(PCL_exeSprDcds[0:4]),
  .PCL_vctSprDcds(PCL_vctSprDcds[0:5]));

//dp_muxEXE_rRegBypass muxEXE_rRegBypass(admOut[0:31], exeResult[0:31], {sReg_NEG[1:31],
//     nxtQ_NEG}, apuExeResult_NEG[0:31], rRegBypassMuxSel[0:1], symNet1512[0:31]);
// Removed the module 'dp_muxEXE_rRegBypass'
always @(rRegBypassMuxSel or admOut or exeResult or sReg_NEG or nxtQ_NEG or apuExeResult_NEG)
    begin                                           
    case(rRegBypassMuxSel[0:1])                       
     2'b00: symNet1512[0:31] = ~admOut[0:31];
     2'b01: symNet1512[0:31] = ~exeResult[0:31];   
     2'b10: symNet1512[0:31] = ~{sReg_NEG[1:31],nxtQ_NEG};   
     2'b11: symNet1512[0:31] = ~apuExeResult_NEG[0:31];   
      default: symNet1512[0:31] = 32'bx;   
    endcase                                    
   end 
//dp_regEXE_rReg regEXE_rReg({CB, CB_buf[1:4]}, rRegBypass_NEG[0:31], PCL_resultRegE1,
//     PCL_resultRegE2, xerRegSO, rRegL2[0:31], rRegSO);
// Removed the module 'dp_regEXE_rReg'
assign rRegL2[0:31] = ~(regEXE_rReg_L2[0:31]);
always @(posedge CB)      
    begin                                       
    casez(PCL_resultRegE1 & PCL_resultRegE2)
     1'b0: regEXE_rReg_L2[0:31] <= regEXE_rReg_L2[0:31];                
     1'b1: regEXE_rReg_L2[0:31] <= rRegBypass_NEG[0:31];
      default: regEXE_rReg_L2[0:31] <= 32'bx;  
    endcase                             
   end 
p405s_adm_top
 adm(
  .EXE_admMco(EXE_admMco),
  .EXE_divMco(EXE_divMco),
  .EXE_multMco(EXE_multMco),
  .aRegMuxSel(aRegMuxSel[0:1]),
  .aRegZ4dndSEIn(aRegZ4dndSEIn[0:4]),
  .addCA(addCA),
  .addOV(addOV),
  .admCcBits(admCcBits[0:2]),
  .admCcMuxSel(admCcMuxSel[0:1]),
  .admOut(admOut[0:31]),
  .bRegMuxSel(bRegMuxSel[0:1]),
  .divNxtToLastSt(divNxtToLastSt),
  .divOV(divOV),
  .divPathEn(divPathEn),
  .macOV(macOV),
  .macOVSat_NEG(macOVSat_NEG),
  .macSatValue(macSatValue[0:2]),
  .multHiEOAnsCc(multHiEOAnsCc[0:2]),
  .multLo4CycAnsCc(multLo4CycAnsCc[0:2]),
  .multLo5CycAnsCc(multLo5CycAnsCc[0:2]),
  .multOV(multOV),
  .nxtQ(nxtQ),
  .nxtQ_NEG(nxtQ_NEG),
  .resetL2(resetL2),
  .sRegMuxSel(sRegMuxSel[0:1]),
  .srmMuxSel(srmMuxSel[0:5]),
  .trap(EXE_trap),
  .CB(CB),
  .LSSD_coreTestEn(LSSD_coreTestEn),
  .PCL_aPortRregBypass(PCL_aPortRregBypass),
  .PCL_addFour(PCL_addFour),
  .PCL_bPortLitGenSel(PCL_bPortLitGenSel),
  .PCL_bPortRregBypass(PCL_bPortRregBypass),
  .PCL_dcdAregLoadUse(PCL_dcdAregLoadUse),
  .PCL_dcdBregLoadUse(PCL_dcdBregLoadUse),
  .PCL_dcdHotCIn(PCL_dcdHotCIn),
  .PCL_dcdMdSelQ(PCL_dcdMdSelQ),
  .PCL_dcdMrSelQ(PCL_dcdMrSelQ),
  .PCL_dcdSregLoadUse(PCL_dcdSregLoadUse),
  .PCL_dcdSrmBpSel(PCL_dcdSrmBpSel[0:2]),
  .PCL_dcdXerCa(PCL_dcdXerCa),
  .PCL_exe2AccRegMuxSel(PCL_exe2AccRegMuxSel[0:1]),
  .PCL_exe2Hold(PCL_exe2Hold),
  .PCL_exe2MacEn(PCL_exe2MacEn),
  .PCL_exe2MacOrMultEnForMS(PCL_exe2MacOrMultEnForMS[0:1]),
  .PCL_exe2MacOrMultEn_NEG(PCL_exe2MacOrMultEn_NEG[0:1]),
  .PCL_exe2MacSat(PCL_exe2MacSat),
  .PCL_exe2MultEn(PCL_exe2MultEn),
  .PCL_exe2MultHiWd(PCL_exe2MultHiWd),
  .PCL_exe2NegMac(PCL_exe2NegMac),
  .PCL_exe2SignedOp(PCL_exe2SignedOp),
  .PCL_exe2XerOvEn(PCL_exe2XerOvEn),
  .PCL_exeAddSgndOp_NEG(PCL_exeAddSgndOp_NEG[0:1]),
  .PCL_exeAdmCntl(PCL_exeAdmCntl[0:3]),
  .PCL_exeAregLoadUse(PCL_exeAregLoadUse),
  .PCL_exeBregLoadUse(PCL_exeBregLoadUse),
  .PCL_exeCmplmntA(PCL_exeCmplmntA),
  .PCL_exeCmplmntA_NEG(PCL_exeCmplmntA_NEG),
  .PCL_exeDivEn(PCL_exeDivEn),
  .PCL_exeDivEnForLSSD(PCL_exeDivEnForLSSD),
  .PCL_exeDivEnForMuxSel(PCL_exeDivEnForMuxSel[0:1]),
  .PCL_exeDivEn_NEG(PCL_exeDivEn_NEG),
  .PCL_exeDivSgndOp(PCL_exeDivSgndOp),
  .PCL_exeDvcHold(PCL_exeDvcHold),
  .PCL_exeLoadUseHold(PCL_exeLoadUseHold),
  .PCL_exeMacEn(PCL_exeMacEn),
  .PCL_exeMultEn(PCL_exeMultEn),
  .PCL_exeMultEnForMuxSel(PCL_exeMultEnForMuxSel[0:1]),
  .PCL_exeMultEn_NEG(PCL_exeMultEn_NEG[0:1]),
  .PCL_exeNegMac(PCL_exeNegMac),
  .PCL_exeSregLoadUse(PCL_exeSregLoadUse),
  .PCL_exeSrmBpSel(PCL_exeSrmBpSel[0:2]),
  .PCL_exeXerOvEn(PCL_exeXerOvEn),
  .PCL_gateZeroToAreg(PCL_gateZeroToAreg),
  .PCL_gateZeroToSreg(PCL_gateZeroToSreg),
  .PCL_holdCIn(PCL_holdCIn),
  .PCL_holdMdMr(PCL_holdMdMr),
  .PCL_sPortRregBypass(PCL_sPortRregBypass),
  .PCL_wbHold(PCL_wbHold),
  .aReg_NEG(aReg_NEG[0:31]),
  .bReg_NEG(bReg_NEG[0:31]),
  .coreReset(coreReset),
  .deterministicMult(PGM_deterministicMult),
  .exeMacOrMultEn_NEG(PCL_exeMacOrMultEn_NEG),
  .nxtXerCa(nxtXerCa),
  .rRegBypassForAccReg(rRegBypassForAccReg[0:31]),
  .sBus(sBus[0:31]),
  .trapCond(PCL_exeTrapCond[0:4]),
  .PCL_exeDvcOrParityHold(PCL_exeDvcOrParityHold));

p405s_spr_top
 spr(
  .exeSprDataBus(exeSprDataBus[0:31]),
  .EXE_vctDbgSprDataBus(EXE_vctDbgSprDataBus[0:31]),
  .EXE_timJtgSprDataBus(EXE_timJtgSprDataBus[0:31]),
  .EXE_mmuIcuSprDataBus(EXE_mmuIcuSprDataBus[0:31]),
  .EXE_ifbSprDataBus(EXE_ifbSprDataBus[0:31]),
  .EXE_dcrDataBus(EXE_dcrDataBus[0:31]),
  .EXE_sprAddr(EXE_sprAddr[4:9]),
  .EXE_dcrAddr(EXE_dcrAddr[0:9]),
  .exeSprDataEn_NEG(PCL_exeSprDataEn_NEG),
  .exeSprUnitEn_NEG(PCL_exeSprUnitEn_NEG),
  .aBus(aBus[0:31]),
  .bBus(bBus[22:31]));

p405s_srm_top
 srm(
  .srmCA(srmCA),
  .srmOut(srmOut[0:31]),
  .exeSrmUnitEn_NEG(PCL_exeSrmUnitEn_NEG),
  .aBus(aBus[0:31]),
  .bBus(bBus[0:31]),
  .srmCntlBus(PCL_exeSrmCntl[0:3]),
  .srmL2(srmL2[0:15]),
  .srmCcBits(srmCcBits[0:2]));

p405s_loadSteering
 loadSteeringSch( 
    .EXE_apuLoadData(EXE_apuLoadData[0:31]),
    .EXE_dvc1ByteCmp(EXE_dvc1ByteCmp[0:3]),
    .EXE_dvc2ByteCmp(EXE_dvc2ByteCmp[0:3]),
    .dRegBypass(dRegBypass[0:31]),
    .gprLpIn(gprLpIn[0:31]),
    .CB(CB),
    .DCU_SDQ_mod_NEG(DCU_SDQ_mod_NEG[0:31]),
    .DCU_data_NEG(DCU_data_NEG[0:31]),
    .LSSD_coreTestEn(LSSD_coreTestEn),
    .OCM_dsData(OCM_dsData[0:31]),
    .PCL_apuTrcLoadEn(PCL_apuTrcLoadEn),
    .PCL_dRegBypassMuxSel(PCL_dRegBypassMuxSel),
    .PCL_dRegE1(PCL_dRegE1),
    .PCL_dofDregE1(PCL_dofDregE1),
    .PCL_dofDregMuxSel(PCL_dofDregMuxSel[0:1]),
    .PCL_dvcByteEnL2(PCL_dvcByteEnL2[0:3]),
    .PCL_dvcCmpEn(PCL_dvcCmpEn),
    .PCL_ldAdjE1(PCL_ldAdjE1),
    .PCL_ldAdjE2(PCL_ldAdjE2[1:3]),
    .PCL_ldAdjMuxSel(PCL_ldAdjMuxSel[0:1]),
    .PCL_ldFillByPassMuxSel(PCL_ldFillByPassMuxSel[0:5]),
    .PCL_ldMuxSel(PCL_ldMuxSel[0:7]),
    .PCL_ldSteerMuxSel(PCL_ldSteerMuxSel[0:7]),
    .dvc1L2(dvc1L2[0:31]),
    .dvc2L2(dvc2L2[0:31]),
    .DCU_parityError(DCU_parityError),
    .EXE_dofDregParityErrL2(EXE_dofDregParityErrL2));


   // Replacing instantiation: GTECH_NOT I253
   assign symNet1715 = ~(PCL_exeWrtee);

   // Replacing instantiation: GTECH_NOT SGT_srmMEInv_0_
   assign symNet1622[0] = ~(litGen[26]);

   // Replacing instantiation: GTECH_NOT SGT_srmMEInv_1_
   assign symNet1622[1] = ~(litGen[27]);

   // Replacing instantiation: GTECH_NOT SGT_srmMEInv_2_
   assign symNet1622[2] = ~(litGen[28]);

   // Replacing instantiation: GTECH_NOT SGT_srmMEInv_3_
   assign symNet1622[3] = ~(litGen[29]);

   // Replacing instantiation: GTECH_NOT SGT_srmMEInv_4_
   assign symNet1622[4] = ~(litGen[30]);

// defect 2302 - tbird - added LSSD_coreTestEn to increase test coverage in the litGen module
//literalGen litGenFunc(litGen[0:31], PCL_dcdImmd[11:31], PCL_dcdLitCntl[0:4], LSSD_coreTestEn);
p405s_literalGen
 litGenFunc(
   .litGen(litGen[0:31]),
   .PCL_dcdImmd(PCL_dcdImmd[11:31]),
   .litCntl(PCL_dcdLitCntl[0:4]),
   .LSSD_coreTestEn(LSSD_coreTestEn));

endmodule
