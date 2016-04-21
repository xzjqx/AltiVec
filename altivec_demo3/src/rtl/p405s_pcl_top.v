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
//
//-------------------------------------------------------------------------------------
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1
// JBB  10/09/01   1935   Widened PCL_vctSprDcds and PCL_icuSprDcds to include CCR1
// JBB  10/11/01   1955   Modified previous change.  Removed extra PCL_vctSprDcds bit. 
// JBB  10/17/01   1971   Removed a bit from PCL_vctSprDcds for MCSRS 
// JBB  10/22/02   2297   Added PCL_gprRdClk signal for GPR read clock
// JBB  11/08/02   2299   No changes.  Didn't need this module. Syncing with CMVC.
//-------------------------------------------------------------------------------------

module p405s_pcl_top( PCL_LpEqSp, PCL_Rbit, PCL_aPortRregBypass, PCL_aRegE2, PCL_aRegForEaE2,
     PCL_abRegE1, PCL_addFour, PCL_apuDcdHold, PCL_apuExeFlush, PCL_apuExeHold,
     PCL_apuExeWdCnt, PCL_apuLwbLoadDV, PCL_apuTrcLoadEn, PCL_apuWbHold,
     PCL_bPortLitGenSel, PCL_bPortRregBypass, PCL_bRegE2, PCL_bRegForEaE2, PCL_blkFlush,
     PCL_blkFlushForVct, PCL_dIcmpForStep, PCL_dIcmpForStuff, PCL_dIcmpForWbFlushQDlydL2,
     PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dbgSprDcds, PCL_dcdApAddr,
     PCL_dcdAregLoadUse, PCL_dcdBpAddr, PCL_dcdBregLoadUse, PCL_dcdHoldForIfb,
     PCL_dcdHotCIn, PCL_dcdImmd, PCL_dcdLitCntl, PCL_dcdMdSelQ, PCL_dcdMrSelQ,
     PCL_dcdSpAddr, PCL_dcdSregLoadUse, PCL_dcdSrmBpSel, PCL_dcdXerCa,
     PCL_dcuByteEn, PCL_dcuOp, PCL_dcuOp_early, PCL_diagBus,
     PCL_dofDRegE1, PCL_dofDRegMuxSel, PCL_dsMmuOp, PCL_dsOcmByteEn,
     PCL_dvcByteEnL2, PCL_dvcCmpEn, PCL_exe2AccRegMuxSel, PCL_exe2ClearOrFlush,
     PCL_exe2DataE1, PCL_exe2DataE2, PCL_exe2Full, PCL_exe2Hold, PCL_exe2IarE1, PCL_exe2IarE2,
     PCL_exe2MacEn, PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG,
     PCL_exe2MacSat, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp,
     PCL_exe2XerOvEn, PCL_exeAbort, PCL_exeAddEn, PCL_exeAddSgndOp_NEG,
     PCL_exeAdmCntl, PCL_exeApuOp, PCL_exeApuValidOp, PCL_exeAregLoadUse,
     PCL_exeBregLoadUse, PCL_exeCmplmntA, PCL_exeCmplmntA_NEG, PCL_exeCpuOp, PCL_exeDbgLdOp,
     PCL_exeDbgRdOp, PCL_exeDbgStOp, PCL_exeDbgWrOp, PCL_exeDivEn, PCL_exeDivEnForLSSD,
     PCL_exeDivEnForMuxSel, PCL_exeDivEn_NEG, PCL_exeDivSgndOp, PCL_exeDvcHold,
     PCL_exeEaCalc, PCL_exeEaQwEn, PCL_exeFpuOp, PCL_exeFull, PCL_exeHoldForCr,
     PCL_exeIarHold, PCL_exeLdNotSt, PCL_exeLoadUseHold, PCL_exeLogicalCntl,
     PCL_exeLogicalUnitEnForLSSD, PCL_exeLogicalUnitEn_NEG, PCL_exeMacEn,
     PCL_exeMacOrMultEn_NEG, PCL_exeMultEn, PCL_exeMultEnForMuxSel,
     PCL_exeMultEn_NEG, PCL_exeNegMac, PCL_exePrivOp, PCL_exeRaEn, PCL_exeRbEn,
     PCL_exeSprDataEn_NEG, PCL_exeSprDcds, PCL_exeSprUnitEn_NEG, PCL_exeSregLoadUse,
     PCL_exeSrmBpSel, PCL_exeSrmCntl, PCL_exeSrmUnitEnForLSSD, PCL_exeSrmUnitEn_NEG,
     PCL_exeStorageOp, PCL_exeStringMultiple, PCL_exeTlbOp, PCL_exeTrap, PCL_exeTrapCond,
     PCL_exeWrExtEn, PCL_exeWrtee, PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_gateZeroToAreg,
     PCL_gateZeroToSreg, PCL_holdCIn, PCL_holdMdMr, PCL_icuOp, PCL_icuSprDcds,
     PCL_ifbSprHold, PCL_jtgSprDcd, PCL_ldAdjE1, PCL_ldAdjE2, PCL_ldAdjMuxSel,
     PCL_ldFillBypassMuxSel, PCL_ldMuxSel, PCL_ldSteerMuxSel,
     PCL_lwbLpAddr, PCL_lwbLpEqdcdApAddr, PCL_lwbLpEqdcdBpAddr, PCL_lwbLpWrEn, PCL_mfDCR,
     PCL_mfDCRL2, PCL_mfSPR, PCL_mmuExeAbort, PCL_mmuIcuSprHold, PCL_mmuSprDcd, PCL_mtDCR,
     PCL_mtSPR, PCL_ocmAbortReq, PCL_resultMuxSel, PCL_resultRegE1, PCL_resultRegE2,
     PCL_sPortRregBypass, PCL_sRegE1, PCL_sRegE2, PCL_sdqMuxSel, PCL_sraRegE1, PCL_sraRegE2,
     PCL_srmRegE1, PCL_srmRegE2, PCL_stSteerCntl, PCL_timJtgSprHold,
     PCL_timSprDcds, PCL_tlbRE, PCL_tlbSX, PCL_tlbWE, PCL_tlbWS, PCL_trcLoadDV,
     PCL_vctDbgSprHold, PCL_vctSprDcds, PCL_wbAlgnErr, PCL_wbClearOrFlush,
     PCL_wbClearTerms, PCL_wbComplete, PCL_wbDbgIcmp, PCL_wbFullForPO, PCL_wbFullL2,
     PCL_wbHold, PCL_wbHoldNonErr, PCL_wbLdNotSt, PCL_wbRpAddr, PCL_wbRpEqdcdApAddr,
     PCL_wbRpEqdcdBpAddr, PCL_wbRpEqdcdSpAddr, PCL_wbRpWrEn, PCL_wbStorageOp, PCL_wbStrgEnd,
     PCL_xerL2Hold, APU_dcdApuOp, APU_dcdExeLdDepend, APU_dcdForceAlgn,
     APU_dcdForceBESteering, APU_dcdFpuOp, APU_dcdGprWr, APU_dcdLdStByte, APU_dcdLdStDw,
     APU_dcdLdStHw, APU_dcdLdStQw, APU_dcdLdStWd, APU_dcdLoad, APU_dcdLwbLdDepend,
     APU_dcdPrivOp, APU_dcdRaEn, APU_dcdRbEn, APU_dcdStore, APU_dcdTrapBE, APU_dcdTrapLE,
     APU_dcdUpdate, APU_dcdWbLdDepend, APU_dcdXerCAEn, APU_dcdXerOVEn, APU_exeBlkingMco,
     APU_exeBusy, APU_exeNonBlkingMco, CAR_endian, CB, DBG_dvcRdEn, DBG_dvcWrEn,
     DBG_exeIacSuppress, DBG_icmpEn, DBG_wbDacSuppress, DCU_CA, DCU_DA, DCU_DOF,
     DCU_carByteEn, DCU_firstCycCarStXltV, DCU_pclOcmLdPendNoWait, EXE_admMco, EXE_divMco,
     EXE_ea, EXE_multMco, EXE_trap, EXE_xerTBC, EXE_xerTBCIn,
     EXE_xerTBCNotEqZero, ICU_LDBE, ICU_dsCA, ICU_gprDRCC, IFB_dcdBubble,
     IFB_dcdDataIn_NEG, IFB_dcdFull, IFB_dcdRegE1, IFB_dcdRegE2, IFB_exeCorrect,
     IFB_exeFlush, IFB_exeRfciL2, IFB_exeRfiL2, IFB_exeScL2, IFB_stepStL2, IFB_stuffStL2,
     IFB_trcPipeHold, LSSD_coreTestEn, MMU_BMCO, MMU_dsStatus, MMU_wbHold, OCM_DOF,
     OCM_dsComplete, PGM_divEn, PGM_mmuEn, VCT_errorSprSuppress, VCT_exeSuppForApu,
     VCT_exeSuppForCr, VCT_exeSuppForExe2Clear, VCT_exeSuppress, VCT_sxrOR_L2, VCT_wbFlush,
     VCT_wbFlushAsync, VCT_wbLoadSuppress, VCT_wbSuppress, XXX_dcrAck, c2Clk, coreReset,
     dcdApuValidOp_NEG, PCL_exeDvcOrParityHold, ICU_CCR0DPP, CAR_cacheable,
// Defect 2297
//   lwbFullL2, PCL_lwbCacheableL2, PCL_dofDregFull, TIE_c405BypassE1E2, PCL_BpEqSp);
     lwbFullL2, PCL_lwbCacheableL2, PCL_dofDregFull, PCL_BpEqSp , 
     PCL_gprRdClk);

output  PCL_LpEqSp, PCL_Rbit, PCL_aPortRregBypass, PCL_aRegE2, PCL_aRegForEaE2, PCL_abRegE1,
     PCL_addFour, PCL_apuDcdHold, PCL_apuExeFlush, PCL_apuExeHold, PCL_apuLwbLoadDV,
     PCL_apuTrcLoadEn, PCL_apuWbHold, PCL_bPortLitGenSel, PCL_bPortRregBypass, PCL_bRegE2,
     PCL_bRegForEaE2, PCL_blkFlush, PCL_dIcmpForStep, PCL_dIcmpForStuff,
     PCL_dIcmpForWbFlushQDlydL2, PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dcdAregLoadUse,
     PCL_dcdBregLoadUse, PCL_dcdHotCIn, PCL_dcdMdSelQ, PCL_dcdMrSelQ, PCL_dcdSregLoadUse,
     PCL_dcdXerCa, PCL_dofDRegE1, PCL_dvcCmpEn, PCL_exe2ClearOrFlush, PCL_exe2DataE1,
     PCL_exe2DataE2, PCL_exe2Full, PCL_exe2Hold, PCL_exe2IarE1, PCL_exe2IarE2, PCL_exe2MacEn,
     PCL_exe2MacSat, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2NegMac, PCL_exe2SignedOp,
     PCL_exe2XerOvEn, PCL_exeAbort, PCL_exeAddEn, PCL_exeApuOp, PCL_exeApuValidOp,
     PCL_exeAregLoadUse, PCL_exeBregLoadUse, PCL_exeCmplmntA, PCL_exeCmplmntA_NEG,
     PCL_exeCpuOp, PCL_exeDbgLdOp, PCL_exeDbgRdOp, PCL_exeDbgStOp, PCL_exeDbgWrOp,
     PCL_exeDivEn, PCL_exeDivEnForLSSD, PCL_exeDivEn_NEG, PCL_exeDivSgndOp, PCL_exeDvcHold,
     PCL_exeEaCalc, PCL_exeFpuOp, PCL_exeFull, PCL_exeHoldForCr, PCL_exeIarHold,
     PCL_exeLdNotSt, PCL_exeLoadUseHold, PCL_exeLogicalUnitEnForLSSD, PCL_exeLogicalUnitEn_NEG,
     PCL_exeMacEn, PCL_exeMacOrMultEn_NEG, PCL_exeMultEn, PCL_exeNegMac, PCL_exePrivOp,
     PCL_exeSprDataEn_NEG, PCL_exeSprUnitEn_NEG, PCL_exeSregLoadUse, PCL_exeSrmUnitEnForLSSD,
     PCL_exeSrmUnitEn_NEG, PCL_exeStorageOp, PCL_exeStringMultiple, PCL_exeTlbOp, PCL_exeTrap,
     PCL_exeWrExtEn, PCL_exeWrtee, PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_gateZeroToAreg,
     PCL_gateZeroToSreg, PCL_holdCIn, PCL_holdMdMr, PCL_ifbSprHold, PCL_jtgSprDcd, PCL_ldAdjE1,
     PCL_lwbLpEqdcdApAddr, PCL_lwbLpEqdcdBpAddr, PCL_lwbLpWrEn, PCL_mfDCR, PCL_mfDCRL2,
     PCL_mfSPR, PCL_mmuExeAbort, PCL_mmuIcuSprHold, PCL_mtDCR, PCL_mtSPR, PCL_ocmAbortReq,
     PCL_resultMuxSel, PCL_resultRegE1, PCL_resultRegE2, PCL_sPortRregBypass, PCL_sRegE1,
     PCL_sRegE2, PCL_sdqMuxSel, PCL_sraRegE1, PCL_sraRegE2, PCL_srmRegE1, PCL_timJtgSprHold,
     PCL_tlbRE, PCL_tlbSX, PCL_tlbWE, PCL_tlbWS, PCL_trcLoadDV, PCL_vctDbgSprHold,
     PCL_wbAlgnErr, PCL_wbClearOrFlush, PCL_wbClearTerms, PCL_wbComplete, PCL_wbDbgIcmp,
     PCL_wbFullForPO, PCL_wbFullL2, PCL_wbHold, PCL_wbHoldNonErr, PCL_wbLdNotSt,
     PCL_wbRpEqdcdApAddr, PCL_wbRpEqdcdBpAddr, PCL_wbRpEqdcdSpAddr, PCL_wbRpWrEn,
     PCL_wbStorageOp, PCL_wbStrgEnd, PCL_xerL2Hold, PCL_exeDvcOrParityHold,
     lwbFullL2, PCL_lwbCacheableL2, PCL_dofDregFull;

// rlg - added for tbird
output PCL_BpEqSp;
// Defect 2297
output PCL_gprRdClk;

input  APU_dcdApuOp, APU_dcdExeLdDepend, APU_dcdForceAlgn, APU_dcdForceBESteering,
     APU_dcdFpuOp, APU_dcdGprWr, APU_dcdLdStByte, APU_dcdLdStDw, APU_dcdLdStHw, APU_dcdLdStQw,
     APU_dcdLdStWd, APU_dcdLoad, APU_dcdLwbLdDepend, APU_dcdPrivOp, APU_dcdRaEn, APU_dcdRbEn,
     APU_dcdStore, APU_dcdTrapBE, APU_dcdTrapLE, APU_dcdUpdate, APU_dcdWbLdDepend,
     APU_dcdXerCAEn, APU_dcdXerOVEn, APU_exeBlkingMco, APU_exeBusy, APU_exeNonBlkingMco,
     CAR_endian, DBG_dvcRdEn, DBG_dvcWrEn, DBG_exeIacSuppress, DBG_icmpEn, DBG_wbDacSuppress,
     DCU_CA, DCU_DA, DCU_DOF, DCU_firstCycCarStXltV, DCU_pclOcmLdPendNoWait, EXE_admMco,
     EXE_divMco, EXE_multMco, EXE_trap, EXE_xerTBCNotEqZero, ICU_LDBE, ICU_dsCA, ICU_gprDRCC,
     IFB_dcdBubble, IFB_dcdFull, IFB_dcdRegE1, IFB_dcdRegE2, IFB_exeCorrect, IFB_exeFlush,
     IFB_exeRfciL2, IFB_exeRfiL2, IFB_exeScL2, IFB_stepStL2, IFB_stuffStL2, IFB_trcPipeHold,
     LSSD_coreTestEn, MMU_BMCO, MMU_wbHold, OCM_DOF, OCM_dsComplete, PGM_divEn, PGM_mmuEn,
     VCT_errorSprSuppress, VCT_exeSuppForApu, VCT_exeSuppForCr, VCT_exeSuppForExe2Clear,
     VCT_exeSuppress, VCT_sxrOR_L2, VCT_wbFlush, VCT_wbFlushAsync, VCT_wbLoadSuppress,
     VCT_wbSuppress, XXX_dcrAck, c2Clk, coreReset, dcdApuValidOp_NEG,
     ICU_CCR0DPP, CAR_cacheable;

output [0:3]  PCL_exeEaQwEn;
output [0:4]  PCL_wbRpAddr;
output [0:1]  PCL_exeMultEn_NEG;
output [0:7]  PCL_ldMuxSel;
output [0:5]  PCL_timSprDcds;
output [0:3]  PCL_dbgSprDcds;
output [0:1]  PCL_dofDRegMuxSel;
output [1:3]  PCL_ldAdjE2;
output [0:5]  PCL_ldFillBypassMuxSel;
output [0:2]  PCL_dcdSrmBpSel;
output [0:3]  PCL_dcuByteEn;
output [0:1]  PCL_ldAdjMuxSel;
output [0:3]  PCL_dsOcmByteEn;
output [0:9]  PCL_dcdBpAddr;
output [0:1]  PCL_exeAddSgndOp_NEG;
output [0:1]  PCL_exe2MacOrMultEnForMS;
output [0:1]  PCL_apuExeWdCnt;
output [0:7]  PCL_ldSteerMuxSel;
output [0:1]  PCL_exe2MacOrMultEn_NEG;

output [0:2]  PCL_icuSprDcds;

output [0:3]  PCL_dsMmuOp;
output [0:3]  PCL_exeAdmCntl;
output [0:3]  PCL_dvcByteEnL2;
output [0:1]  PCL_exe2AccRegMuxSel;
output [0:2]  PCL_exeSrmBpSel;
output [0:3]  PCL_exeSrmCntl;
output [0:4]  PCL_lwbLpAddr;
output [0:2]  PCL_srmRegE2;
output [0:4]  PCL_dcdLitCntl;
output [0:2]  PCL_blkFlushForVct;
output [0:8]  PCL_mmuSprDcd;
output [0:9]  PCL_stSteerCntl;
output [0:2]  PCL_dcuOp_early;
output [0:9]  PCL_dcdSpAddr;
output [0:4]  PCL_exeTrapCond;
output [0:3]  PCL_exeRbEn;
output [0:4]  PCL_exeSprDcds;
output [0:3]  PCL_exeRaEn;
output [0:7]  PCL_exeLogicalCntl;

output [0:5]  PCL_vctSprDcds;                // Removed MCSRS bit (defect 1971)	

output [0:2]  PCL_dcdHoldForIfb;
output [0:9]  PCL_diagBus;
output [0:9]  PCL_dcdApAddr;
output [0:3]  PCL_icuOp;
output [0:1]  PCL_exeMultEnForMuxSel;
output [0:11]  PCL_dcuOp;
output [0:1]  PCL_exeDivEnForMuxSel;
output [11:31]  PCL_dcdImmd;

input [0:6]  EXE_xerTBCIn;
input [0:31]  IFB_dcdDataIn_NEG;
input [30:31]  EXE_ea;
input [0:6]  EXE_xerTBC;
input        CB;
input [0:4]  MMU_dsStatus;
input [0:3]  DCU_carByteEn;

// Buses in the design

reg  [0:31]  dcdData2NegL2_i;
wire  [0:31]  dcdData2NegL2;

reg  [0:31]  dcdData1NegL2_i;
wire  [0:31]  dcdData1NegL2;

wire  [0:9]  diagBus;

wire  [0:4]  plaByteCnt;

wire  [0:11]  plaDcuOp;

wire  [0:6]  plaMmuCode;

wire  [0:3]  plaIcuOp;

wire  [0:3]  wbByteEn;

wire  [0:4]  wbRAL2;

wire  [0:4]  exeRA;

wire  [1:2]  wbStrgSt;

wire  [0:5]  dcdTimSprDcd;

wire  [0:7]  plaLSSMIURA;

wire  [0:4]  plaUnitEn;

wire  [0:3]  plaAdmCntl;

wire  [0:7]  plaLogicalCntl;

wire  [0:3]  plaSrmCntl;

wire  [0:5]  dcdVctSprDcd;

wire  [0:8]  dcdMmuSprDcd;

wire  [0:2]  dcdIcuSprDcd;

wire  [0:3]  dcdDbgSprDcd;

wire  [0:4]  dcdExeSprDcd;

wire  [1:3]  ldAdjSel;

wire  [6:7]  byteCount;

wire  [0:2]  exeStrgSt;

wire  [0:7]  exeLSSMIURA;

wire  [0:4]  dcd1RAL2;

wire  [0:4]  dcd1RSRTL2;

wire  [0:5]  dcd1PriOpL2;

wire  [0:4]  dcd2RAL2;

wire  [0:4]  dcd2RSRTL2;

wire  [0:5]  dcd2PriOpL2;

wire  [21:31]  dcd2SecOpL2;

wire  [0:4]  dcd2RBL2;

wire  [21:31]  dcd1SecOpL2;

wire  [0:4]  dcd1RBL2;

wire exeForceBESteering;

wire PCL_exeFull_i;
wire PCL_exe2Full_i;
wire PCL_wbFullL2_i;
wire lwbFullL2_i;
wire sprHold;
wire ocmDofBuf;
wire cntGtEq4;
wire nxtWbLpWrEn;
wire lwbE1;
wire loadSteerMuxSel;
wire gtErr;
wire exeRpAddrE2;
wire exeLpMuxSel;
wire exeLpAddrE2;
wire exeE2;
wire exeE1;
wire exeClearOrFlush;
wire dcdXerTBCUpdInstr;
wire dcdStringImmediate;
wire countE2;
wire wbLoadForApu;
wire exeApuFpuLdSt;
wire exeTrapBE;
wire exeTrapLE;
wire wbFullForPO;
wire strgEnd;
wire wbStrgC1;
wire wbLdOrStWUD;
wire algnErr;
wire wbApuFpuLoad;
wire exeApuFpuLoad;
wire wbStwcx;
wire wbLwarx;
wire exeStwcx;
wire exeLwarx;
wire wbStrgLS;
wire wbE2;
wire wbE1;
wire exeRpWrEnQ;
wire exeLoadQ;
wire wbLpWrEn;
wire wbLoad;
wire wbLpEqexeApAddr;
wire wbLpEqexeBpAddr;
wire wbLpEqexeSpAddr;
wire plaLpWrEn;
wire wbRpAddrE2;
wire nxtExeFull;
wire sPortSelInc;
wire wbLpEqdcdApAddr;
wire wbLpEqdcdBpAddr;
wire wbLpEqdcdSpAddr;
wire strgLpWrEn;
wire plaSrmEn;
wire plaRaEq0Ck;
wire plaMtspr;
wire nopStringIndexed;
wire lwbLpEqexeApAddr;
wire lwbLpEqexeBpAddr;
wire lwbLpEqexeSpAddr;
wire exeRpWrEn;
wire exeRpEqwbLpAddr;
wire exeRpEqlwbLpAddr;
wire exeRpEqdcdApAddr;
wire exeRpEqdcdBpAddr;
wire exeRpEqdcdSpAddr;
wire exeRTeqRB;
wire exeRTeqRA;
wire exeMtdcr;
wire exeMfdcr;
wire lwbLpEqdcdSpAddr;
wire exeEaCalc;
wire NplaSregEn;
wire plaSpRdEn;
wire NplaBregEn;
wire NplaBpRdEn;
wire NplaAregEn;
wire NplaApRdEn;
wire gprLpeqRp;
wire storeRSE2;
wire storageStMachE2;
wire wbFullForDepend;
wire exeXerTBCUpdInstr;
wire dcdJtgSprDcd;
wire exeStrgStC0;
wire plaApuDiv;
wire exe2FullForE1_NEG;
wire exeFullForE1_NEG;
wire plaEaCalc;
wire resetL2;
wire plaMfspr;
wire ltchDA;
wire exeApuExeLwbLdUseL2;
wire exeApuExeWbLdUseL2;
wire exeMorMRpEqlwbLpAddr;
wire exeMorMRpEqwbLpAddr;
wire exeRpEqexe2RpAddr;
wire plaStwcx;
wire exeMmuOp;
wire plaMdSel;
wire plaMrSel;
wire dcdMultiple;
wire dcdStringIndexed;
wire wbLpAddrE1;
wire storageStMachE1;
wire blkExeSpAddr;
wire plaVal;
wire exeMorMpEqdcdBpAddr;
wire exeMorMRpEqdcdApAddr;
wire exeRpAddrMuxSel;
wire exeMacOrMultRpAddrE2;
wire plaMac;
wire exeMacEn;
wire exeDivEn;
wire exeMultEn;
wire exeApuFpuOp;
wire NdcdApRdEn;
wire exeSpAddrE2;
wire exeSpRdEn;
wire exeBpRdEn;
wire exeApRdEn;
wire plaNegMac;
wire plaLwarx;
wire plaLdNotSt;
wire plaWrtee;
wire plaWrExtEn;
wire plaMfdcr;
wire plaMtdcr;
wire plaXerCaEn;
wire plaOeCk;
wire plaAddEn;
wire plaCmplmntA;
wire plaRpMuxSel;
wire plaRpWrEn;
wire plaPriv;
wire plaApuLdSt;
wire countE1;
wire exeForceAlgn;
wire plaMtcrf;
wire plaForceAlgn;
wire plaMacSat;
wire plaGateZeroToAccReg;



wire [0:11]  PCL_dcuOp_i;
wire [0:4]  PCL_dcdLitCntl_i;
wire [0:2]  PCL_exeSrmBpSel_i;
wire [0:3]  PCL_dcuByteEn_i;
wire [0:2]  PCL_dcdSrmBpSel_i;
wire PCL_wbStrgEnd_i;
wire PCL_wbStorageOp_i;
wire PCL_wbRpWrEn_i;
wire PCL_wbHold_i;
wire PCL_wbClearOrFlush_i;
wire PCL_wbAlgnErr_i;
wire PCL_lwbLpEqdcdBpAddr_i;
wire PCL_lwbLpEqdcdApAddr_i;
wire PCL_exeStorageOp_i;
wire PCL_exeSrmUnitEn_NEG_i;
wire PCL_exeLdNotSt_i;
wire PCL_exe2DataE2_i;
wire PCL_exe2DataE1_i;
wire PCL_exe2ClearOrFlush_i;
wire PCL_Rbit_i;

assign PCL_Rbit = PCL_Rbit_i;
assign PCL_exe2ClearOrFlush = PCL_exe2ClearOrFlush_i;
assign PCL_exe2DataE1 = PCL_exe2DataE1_i;
assign PCL_exe2DataE2 = PCL_exe2DataE2_i;
assign PCL_exeLdNotSt = PCL_exeLdNotSt_i;
assign PCL_exeSrmUnitEn_NEG = PCL_exeSrmUnitEn_NEG_i;
assign PCL_exeStorageOp = PCL_exeStorageOp_i;
assign PCL_lwbLpEqdcdApAddr = PCL_lwbLpEqdcdApAddr_i;
assign PCL_lwbLpEqdcdBpAddr = PCL_lwbLpEqdcdBpAddr_i;
assign PCL_wbAlgnErr = PCL_wbAlgnErr_i;
assign PCL_wbClearOrFlush = PCL_wbClearOrFlush_i;
assign PCL_wbHold = PCL_wbHold_i;
assign PCL_wbRpWrEn = PCL_wbRpWrEn_i;
assign PCL_wbStorageOp = PCL_wbStorageOp_i;
assign PCL_wbStrgEnd = PCL_wbStrgEnd_i;
assign PCL_dcdSrmBpSel = PCL_dcdSrmBpSel_i;
assign PCL_dcuByteEn = PCL_dcuByteEn_i;
assign PCL_exeSrmBpSel = PCL_exeSrmBpSel_i;
assign PCL_dcdLitCntl = PCL_dcdLitCntl_i;
assign PCL_dcuOp = PCL_dcuOp_i;

assign PCL_exeFull = PCL_exeFull_i;
assign PCL_exe2Full = PCL_exe2Full_i;
assign PCL_wbFullL2 = PCL_wbFullL2_i;
assign lwbFullL2 = lwbFullL2_i;

//Removed the module dp_logPCL_ocmDofBuf 
assign ocmDofBuf = OCM_DOF;

//Removed the module dp_logPCL_dcdData2HiInv 
assign {dcd2PriOpL2, dcd2RSRTL2, dcd2RAL2} = ~dcdData2NegL2[0:15];

//Removed the module dp_logPCL_dcdData2LoInv 
assign {dcd2RBL2, dcd2SecOpL2} = ~dcdData2NegL2[16:31];

//Removed the module dp_logPCL_dcdData1LoInv 
assign {dcd1RBL2, dcd1SecOpL2} = ~dcdData1NegL2[16:31];

//Removed the module dp_logPCL_dcdData1HiInv 
assign {dcd1PriOpL2, dcd1RSRTL2, dcd1RAL2} = ~dcdData1NegL2[0:15];

//Removed the module dp_logPCL_diagBusBUF 
assign PCL_diagBus = diagBus;

//Removed the module dp_logPCL_diagPreBUF 
assign diagBus = {IFB_dcdFull, PCL_exeFull_i, PCL_exe2Full_i, PCL_wbFullL2_i,
                  lwbFullL2_i, exeStrgSt[0:2], wbStrgSt[1:2]};

//Removed the module dp_regPCL_dcdData2Lo 
//Removed the module dp_regPCL_dcdData2Hi 
always @(posedge CB)
  begin: dp_regPCL_dcdData2_PROC
    if (IFB_dcdRegE1 & IFB_dcdRegE2)
      dcdData2NegL2_i <= IFB_dcdDataIn_NEG;
  end // dp_regPCL_dcdData2_PROC
  
assign dcdData2NegL2 = ~dcdData2NegL2_i;

//Removed the module dp_regPCL_dcdData1Lo 
//Removed the module dp_regPCL_dcdData1Hi 
always @(posedge CB)
  begin: dp_regPCL_dcdData1_PROC
    if (IFB_dcdRegE1 & IFB_dcdRegE2)
      dcdData1NegL2_i <= IFB_dcdDataIn_NEG;
  end // dp_regPCL_dcdData1_PROC

assign dcdData1NegL2 = ~dcdData1NegL2_i;

//Removed the module dp_logPCL_sprHoldBuf 
assign PCL_ifbSprHold = sprHold;
assign PCL_vctDbgSprHold = sprHold;
assign PCL_timJtgSprHold = sprHold;
assign PCL_mmuIcuSprHold = sprHold;

//Removed the module dp_logPCL_stSteerCntlBuf
assign PCL_stSteerCntl = {EXE_ea, byteCount, cntGtEq4, exeStrgSt[2], exeLSSMIURA[2:3], 
                          exeLSSMIURA[6], exeForceBESteering};

//Removed the module dp_logPCL_dcdImmdBuf 
assign PCL_dcdImmd = {dcd1RAL2, dcd1RBL2, dcd1SecOpL2};

//Removed the module pclClkBuf 

p405s_wbStage
 wbStg(.PCL_ldAdjE2(PCL_ldAdjE2), 
                    .PCL_ldFillByPassMuxSel(PCL_ldFillBypassMuxSel[0:5]), 
                    .ldAdjSel(ldAdjSel),
                    .PCL_ldSteerMuxSel(PCL_ldSteerMuxSel), 
                    .PCL_wbRpWrEn(PCL_wbRpWrEn_i), 
                    .wbFull(PCL_wbFullL2_i), 
                    .wbLoad(wbLoad), 
                    .wbLpWrEn(wbLpWrEn), 
                    .CB(CB),
                    .byteCount(byteCount), 
                    .cntGtEq4(cntGtEq4), 
                    .exeAlg(exeLSSMIURA[7]), 
                    .exeByteRev(exeLSSMIURA[6]),
                    .exeStorageOp(PCL_exeStorageOp_i), 
                    .exeEA(EXE_ea), 
                    .exeLoadQ(exeLoadQ), 
                    .exeMultiple(exeLSSMIURA[3]), 
                    .exeRpWrEnQ(exeRpWrEnQ), 
                    .exeStrgSt(exeStrgSt),
                    .exeString(exeLSSMIURA[2]), 
                    .loadSteerMuxSel(loadSteerMuxSel), 
                    .lwbE1(lwbE1), 
                    .nxtWbLpWrEn(nxtWbLpWrEn), 
                    .PCL_wbStorageOp(PCL_wbStorageOp_i), 
                    .wbClearOrFlush(PCL_wbClearOrFlush_i),
                    .wbEndian(CAR_endian), 
                    .wbE1(wbE1), 
                    .wbE2(wbE2), 
                    .wbStrgLS(wbStrgLS), 
                    .exeLwarx(exeLwarx), 
                    .exeStwcx(exeStwcx), 
                    .wbLwarx(wbLwarx), 
                    .wbStwcx(wbStwcx), 
                    .exeApuFpuLoad(exeApuFpuLoad),
                    .wbApuFpuLoad(wbApuFpuLoad), 
                    .algnErr(algnErr), 
                    .PCL_wbAlgnErr(PCL_wbAlgnErr_i), 
                    .exeLdNotSt(PCL_exeLdNotSt_i), 
                    .PCL_wbLdNotSt(PCL_wbLdNotSt), 
                    .exeStore(exeLSSMIURA[1]),
                    .exeWUD(exeLSSMIURA[5]), 
                    .wbLdOrStWUD(wbLdOrStWUD), 
                    .wbStrgC1(wbStrgC1), 
                    .exeRA(exeRA), 
                    .wbRAL2(wbRAL2), 
                    .exeStrgEnd(strgEnd), 
                    .PCL_wbStrgEnd(PCL_wbStrgEnd_i),
                    .exeByteEn(PCL_dcuByteEn_i), 
                    .wbByteEn(wbByteEn), 
                    .wbFullForPO(wbFullForPO), 
                    .exeTrapLE(exeTrapLE), 
                    .exeTrapBE(exeTrapBE), 
                    .exeApuFpuLdSt(exeApuFpuLdSt),
                    .wbStrgSt(wbStrgSt), 
                    .wbFullForDepend(wbFullForDepend), 
                    .wbLoadForApu(wbLoadForApu));
                          
assign PCL_resultMuxSel = exeStrgSt[0];

p405s_pipeCntl
 pipeCtl(.PCL_dcdAregLoadUse(PCL_dcdAregLoadUse), 
                       .PCL_aPortRregBypass(PCL_aPortRregBypass), 
                       .PCL_abRegE1(PCL_abRegE1), 
                       .PCL_aRegE2(PCL_aRegE2),
                       .PCL_dcdBregLoadUse(PCL_dcdBregLoadUse), 
                       .PCL_bPortRregBypass(PCL_bPortRregBypass), 
                       .PCL_bRegE2(PCL_bRegE2), 
                       .PCL_blkFlush(PCL_blkFlush), 
                       .PCL_dRegBypassMuxSel(PCL_dRegBypassMuxSel),
                       .PCL_dRegE1(PCL_dRegE1), 
                       .PCL_dcdHoldForIfb(PCL_dcdHoldForIfb), 
                       .PCL_dofDRegE1(PCL_dofDRegE1), 
                       .PCL_dofDRegMuxSel(PCL_dofDRegMuxSel), 
                       .PCL_exeIarHold(PCL_exeIarHold),
                       .PCL_mfDCR(PCL_mfDCR), 
                       .PCL_mtDCR(PCL_mtDCR), 
                       .PCL_gateZeroToAreg(PCL_gateZeroToAreg), 
                       .PCL_gateZeroToSreg(PCL_gateZeroToSreg), 
                       .PCL_holdCIn(PCL_holdCIn), 
                       .PCL_ldAdjE1(PCL_ldAdjE1),
                       .PCL_ldAdjMuxSel(PCL_ldAdjMuxSel), 
                       .PCL_ldMuxSel(PCL_ldMuxSel), 
                       .PCL_lwbLpWrEn(PCL_lwbLpWrEn), 
                       //.PCL_resultMuxSel(PCL_resultMuxSel), //feedthrough
                       .PCL_resultRegE1(PCL_resultRegE1),
                       .PCL_resultRegE2(PCL_resultRegE2), 
                       .PCL_dcdSregLoadUse(PCL_dcdSregLoadUse), 
                       .PCL_sPortRregBypass(PCL_sPortRregBypass), 
                       .PCL_sRegE1(PCL_sRegE1), 
                       .PCL_sRegE2(PCL_sRegE2),
                       .PCL_sraRegE1(PCL_sraRegE1), 
                       .PCL_dIcmpForStep(PCL_dIcmpForStep), 
                       .PCL_srmRegE1(PCL_srmRegE1), 
                       .PCL_srmRegE2(PCL_srmRegE2), 
                       .PCL_wbHold(PCL_wbHold_i),
                       .PCL_xerL2Hold(PCL_xerL2Hold), 
                       .countE2(countE2), 
                       .dcdStringImmediate(dcdStringImmediate), 
                       .dcdXerTBCUpdInstr(dcdXerTBCUpdInstr),
                       .exeClearOrFlush(exeClearOrFlush), 
                       .exeE1(exeE1), 
                       .exeE2(exeE2), 
                       .exeLpAddrE2(exeLpAddrE2), 
                       .exeLpMuxSel(exeLpMuxSel), 
                       .exeRpAddrE2(exeRpAddrE2), 
                       .gtErr(gtErr),
                       .loadSteerMuxSel(loadSteerMuxSel), 
                       .lwbE1(lwbE1), 
                       .nxtWbLpWrEn(nxtWbLpWrEn), 
                       .storageStMachE2(storageStMachE2), 
                       .storeRSE2(storeRSE2), 
                       .PCL_wbClearOrFlush(PCL_wbClearOrFlush_i), 
                       .wbE1(wbE1),
                       .wbE2(wbE2), 
                       .APU_exeBlkingMco(APU_exeBlkingMco), 
                       .APU_exeBusy(APU_exeBusy), 
                       .APU_exeNonBlkingMco(APU_exeNonBlkingMco), 
                       .CB(CB), 
                       .DCU_CA(DCU_CA),
                       .DCU_DA(DCU_DA), 
                       .DCU_DOF(DCU_DOF), 
                       .EXE_admMco(EXE_admMco), 
                       .ICU_dsCA(ICU_dsCA), 
                       .IFB_dcdFull(IFB_dcdFull), 
                       .gprLpeqRp(gprLpeqRp), 
                       .MMU_BMCO(MMU_BMCO), 
                       .MMU_wbHold(MMU_wbHold),
                       .NplaApRdEn(NplaApRdEn), 
                       .NplaAregEn(NplaAregEn), 
                       .NplaBpRdEn(NplaBpRdEn), 
                       .NplaBregEn(NplaBregEn), 
                       .plaSpRdEn(plaSpRdEn), 
                       .NplaSregEn(NplaSregEn), 
                       .OCM_dsComplete(OCM_dsComplete),
                       .OCM_DOF(ocmDofBuf), 
                       .VCT_exeSuppress(VCT_exeSuppress), 
                       .VCT_wbFlush(VCT_wbFlush), 
                       .coreReset(coreReset), 
                       .dcdRAL2(dcd1RAL2),
                       .dcdSPRN({dcd1RBL2, dcd1RAL2}), 
                       .XXX_dcrAck(XXX_dcrAck), 
                       .exeEaCalc(exeEaCalc), 
                       .exeLSSMIURA(exeLSSMIURA[0:5]),
                       .lwbLpEqdcdApAddr(PCL_lwbLpEqdcdApAddr_i), 
                       .lwbLpEqdcdBpAddr(PCL_lwbLpEqdcdBpAddr_i), 
                       .lwbLpEqdcdSpAddr(lwbLpEqdcdSpAddr), 
                       .exeMfdcr(exeMfdcr), 
                       .exeMtdcr(exeMtdcr),
                       .exeRTeqRA(exeRTeqRA), 
                       .exeRTeqRB(exeRTeqRB), 
                       .exeRpEqdcdApAddr(exeRpEqdcdApAddr), 
                       .exeRpEqdcdBpAddr(exeRpEqdcdBpAddr), 
                       .exeRpEqdcdSpAddr(exeRpEqdcdSpAddr),
                       .exeRpEqlwbLpAddr(exeRpEqlwbLpAddr), 
                       .exeRpEqwbLpAddr(exeRpEqwbLpAddr), 
                       .exeRpWrEn(exeRpWrEn), 
                       .exeStrgSt(exeStrgSt), 
                       .ldAdjSel(ldAdjSel),
                       .lwbLpEqexeApAddr(lwbLpEqexeApAddr), 
                       .lwbLpEqexeBpAddr(lwbLpEqexeBpAddr), 
                       .lwbLpEqexeSpAddr(lwbLpEqexeSpAddr), 
                       .nopStringIndexed(nopStringIndexed), 
                       .plaLSSMIURA(plaLSSMIURA[0:4]),
                       .plaLogicalCntl(plaLogicalCntl[6:7]), 
                       .plaMtspr(plaMtspr), 
                       .plaRaEq0Ck(plaRaEq0Ck), 
                       .plaSrmEn(plaSrmEn), 
                       .priOp(dcd1PriOpL2), 
                       .strgEnd(strgEnd),
                       .strgLpWrEn(strgLpWrEn), 
                       .wbFull(PCL_wbFullL2_i), 
                       .wbLoad(wbLoad), 
                       .wbLpEqdcdApAddr(wbLpEqdcdApAddr), 
                       .wbLpEqdcdBpAddr(wbLpEqdcdBpAddr), 
                       .wbLpEqdcdSpAddr(wbLpEqdcdSpAddr),
                       .wbLpWrEn(wbLpWrEn), 
                       .sPortSelInc(sPortSelInc), 
                       .sprHold(sprHold), 
                       .exeRpWrEnQ(exeRpWrEnQ), 
                       .nxtExeFull(nxtExeFull), 
                       .exeFull(PCL_exeFull_i), 
                       .IFB_exeCorrect(IFB_exeCorrect),
                       .IFB_trcPipeHold(IFB_trcPipeHold), 
                       .wbRpAddrE2(wbRpAddrE2), 
                       .plaLpWrEn(plaLpWrEn), 
                       .PCL_wbRpWrEn(PCL_wbRpWrEn_i), 
                       .wbStrgLS(wbStrgLS), 
                       .PCL_exeAbort(PCL_exeAbort), 
                       .exeStwcx(exeStwcx),
                       .wbLwarx(wbLwarx), 
                       .wbStwcx(wbStwcx), 
                       .VCT_wbSuppress(VCT_wbSuppress), 
                       .wbLpEqexeApAddr(wbLpEqexeApAddr), 
                       .wbLpEqexeBpAddr(wbLpEqexeBpAddr), 
                       .wbLpEqexeSpAddr(wbLpEqexeSpAddr),
                       .exeApRdEn(exeApRdEn), 
                       .exeBpRdEn(exeBpRdEn), 
                       .exeSpRdEn(exeSpRdEn), 
                       .exeSpAddrE2(exeSpAddrE2), 
                       .PCL_exeAregLoadUse(PCL_exeAregLoadUse), 
                       .PCL_exeBregLoadUse(PCL_exeBregLoadUse),
                       .PCL_exeSregLoadUse(PCL_exeSregLoadUse), 
                       .EXE_divMco(EXE_divMco), 
                       .IFB_dcdBubble(IFB_dcdBubble), 
                       .plaTrap(plaAdmCntl[1]), 
                       .exeSrmUnitEn(PCL_exeSrmUnitEn_NEG_i),
                       .NdcdApRdEn(NdcdApRdEn), 
                       .DCU_pclOcmLdPendNoWait(DCU_pclOcmLdPendNoWait), 
                       .PCL_Rbit(PCL_Rbit_i), 
                       .ICU_LDBE(ICU_LDBE), 
                       .PCL_apuLwbLoadDV(PCL_apuLwbLoadDV),
                       .PCL_apuTrcLoadEn(PCL_apuTrcLoadEn), 
                       .wbApuFpuLoad(wbApuFpuLoad), 
                       .exeApuFpuOp(exeApuFpuOp), 
                       .IFB_exeFlush(IFB_exeFlush), 
                       .plaDcuOp(plaDcuOp[4:5]),
                       .VCT_errorSprSuppress(VCT_errorSprSuppress), 
                       .DCU_firstCycCarStXltV(DCU_firstCycCarStXltV), 
                       .DBG_dvcRdEn(DBG_dvcRdEn), 
                       .DBG_dvcWrEn(DBG_dvcWrEn), 
                       .exeDcbz(PCL_dcuOp_i[4]),
                       .exeDcba(PCL_dcuOp_i[5]), 
                       .exeMultEn(exeMultEn), 
                       .exeDivEn(exeDivEn), 
                       .exeMacEn(exeMacEn), 
                       .PCL_apuExeHold(PCL_apuExeHold), 
                       .PCL_apuExeFlush(PCL_apuExeFlush), 
                       .EXE_trap(EXE_trap),
                       .PCL_exeTrap(PCL_exeTrap), 
                       .exe2Full(PCL_exe2Full_i), 
                       .plaMacEn(plaMac), 
                       .DBG_icmpEn(DBG_icmpEn), 
                       .PCL_exeDvcHold(PCL_exeDvcHold), 
                       .PCL_wbStorageOp(PCL_wbStorageOp_i),
                       .PCL_exe2Hold(PCL_exe2Hold), 
                       .EXE_multMco(EXE_multMco), 
                       .PCL_dvcCmpEn(PCL_dvcCmpEn), 
                       .PCL_exe2IarE1(PCL_exe2IarE1), 
                       .PCL_exe2IarE2(PCL_exe2IarE2), 
                       .PCL_exe2DataE1(PCL_exe2DataE1_i),
                       .PCL_exe2DataE2(PCL_exe2DataE2_i), 
                       .PCL_exe2ClearOrFlush(PCL_exe2ClearOrFlush_i), 
                       .wbLdOrStWUD(wbLdOrStWUD), 
                       .exeMacOrMultRpAddrE2(exeMacOrMultRpAddrE2), 
                       .exeRpAddrMuxSel(exeRpAddrMuxSel),
                       .dcdMmuSprDcd(dcdMmuSprDcd), 
                       .PCL_trcLoadDV(PCL_trcLoadDV), 
                       .wbStrgC1(wbStrgC1), 
                       .PCL_wbDbgIcmp(PCL_wbDbgIcmp), 
                       .MMU_dsStatus(MMU_dsStatus),
                       .IFB_exeRfciL2(IFB_exeRfciL2), 
                       .IFB_exeRfiL2(IFB_exeRfiL2), 
                       .IFB_exeScL2(IFB_exeScL2), 
                       .VCT_wbFlushAsync(VCT_wbFlushAsync), 
                       .IFB_stepStL2(IFB_stepStL2), 
                       .PCL_mfDCRL2(PCL_mfDCRL2),
                       .PCL_wbHoldNonErr(PCL_wbHoldNonErr), 
                       .PCL_wbFullForPO(PCL_wbFullForPO), 
                       .PCL_wbComplete(PCL_wbComplete), 
                       .PCL_apuDcdHold(PCL_apuDcdHold), 
                       .exeMorMRpEqdcdApAddr(exeMorMRpEqdcdApAddr),
                       .exeMorMRpEqdcdBpAddr(exeMorMpEqdcdBpAddr), 
                       .lwbFullL2(lwbFullL2_i), 
                       .VCT_wbLoadSuppress(VCT_wbLoadSuppress), 
                       .plaMultEn(plaUnitEn[0]), 
                       .plaLogicalUnitEn(plaUnitEn[2]), 
                       .plaVal(plaVal),
                       .blkExeSpAddr(blkExeSpAddr), 
                       .storageStMachE1(storageStMachE1), 
                       .wbLpAddrE1(wbLpAddrE1), 
                       .PCL_exeHoldForCr(PCL_exeHoldForCr), 
                       .PCL_wbClearTerms(PCL_wbClearTerms),
                       .dcdMultiple(dcdMultiple), 
                       .dcdStringIndexed(dcdStringIndexed), 
                       .PCL_dIcmpForStuff(PCL_dIcmpForStuff), 
                       .IFB_stuffStL2(IFB_stuffStL2), 
                       .PCL_sdqMuxSel(PCL_sdqMuxSel),
                       .PCL_wbStrgEnd(PCL_wbStrgEnd_i), 
                       .DBG_exeIacSuppress(DBG_exeIacSuppress), 
                       .plaMrSel(plaMrSel), 
                       .plaMdSel(plaMdSel), 
                       .PCL_dcdMrSelQ(PCL_dcdMrSelQ), 
                       .PCL_dcdMdSelQ(PCL_dcdMdSelQ),
                       .PCL_mmuExeAbort(PCL_mmuExeAbort), 
                       .PCL_wbAlgnErr(PCL_wbAlgnErr_i), 
                       .DBG_wbDacSuppress(DBG_wbDacSuppress), 
                       .VCT_exeSuppForApu(VCT_exeSuppForApu), 
                       .exeMmuOp(exeMmuOp),
                       .PCL_exeLoadUseHold(PCL_exeLoadUseHold), 
                       .PCL_holdMdMr(PCL_holdMdMr), 
                       .PCL_exeSrmBpSel(PCL_exeSrmBpSel_i), 
                       .plaStwcx(plaStwcx), 
                       .exeLwarx(exeLwarx),
                       .PCL_dIcmpForWbFlushQDlydL2(PCL_dIcmpForWbFlushQDlydL2), 
                       .exeRpEqexe2RpAddr(exeRpEqexe2RpAddr), 
                       .exeMorMRpEqwbLpAddr(exeMorMRpEqwbLpAddr), 
                       .exeMorMRpEqlwbLpAddr(exeMorMRpEqlwbLpAddr),
                       .VCT_exeSuppForExe2Clear(VCT_exeSuppForExe2Clear), 
                       .wbByteEn(wbByteEn), 
                       .DCU_carByteEn(DCU_carByteEn), 
                       .PCL_dvcByteEnL2(PCL_dvcByteEnL2),
                       .PCL_aRegForEaE2(PCL_aRegForEaE2), 
                       .PCL_bRegForEaE2(PCL_bRegForEaE2), 
                       .PCL_apuWbHold(PCL_apuWbHold), 
                       .exeApuExeWbLdUseL2(exeApuExeWbLdUseL2), 
                       .exeApuExeLwbLdUseL2(exeApuExeLwbLdUseL2),
                       .ltchDA(ltchDA), 
                       .dcdTimSprDcd(dcdTimSprDcd), 
                       .dcdIcuSprDcd(dcdIcuSprDcd), 
                       .plaMfspr(plaMfspr), 
                       .VCT_exeSuppForCr(VCT_exeSuppForCr),
                       .dcdDbgSprDcd(dcdDbgSprDcd), 
                       .dcdExeSprDcd(dcdExeSprDcd), 
                       .dcdVctSprDcd(dcdVctSprDcd), 
                       .resetL2(resetL2), 
                       .PCL_dcdLitCntl(PCL_dcdLitCntl_i[2:4]), 
                       .plaEaCalc(plaEaCalc), 
                       .exeFullForE1_NEG(exeFullForE1_NEG), 
                       .exe2FullForE1_NEG(exe2FullForE1_NEG), 
                       .wbFullForPO(wbFullForPO), 
                       .plaApuDiv(plaApuDiv), 
                       .LSSD_coreTestEn(LSSD_coreTestEn),
                       .PCL_ocmAbortReq(PCL_ocmAbortReq), 
                       .exeStrgStC0(exeStrgStC0), 
                       .wbLoadForApu(wbLoadForApu), 
                       .PCL_blkFlushForVct(PCL_blkFlushForVct), 
                       .dcdJtgSprDcd(dcdJtgSprDcd),
                       .PCL_sraRegE2(PCL_sraRegE2), 
                       .VCT_sxrOR_L2(VCT_sxrOR_L2) ,
                       .PCL_exeDvcOrParityHold(PCL_exeDvcOrParityHold), 
                       .CAR_cacheable(CAR_cacheable),
                       .PCL_lwbCacheableL2(PCL_lwbCacheableL2), 
                       .PCL_dofDregFull(PCL_dofDregFull), 
                       .ICU_CCR0DPP(ICU_CCR0DPP));
                             
p405s_exeStage
 exeStg( .PCL_dcuOp(PCL_dcuOp_i), 
                       .PCL_dsMmuOp(PCL_dsMmuOp), 
                       .PCL_exeAdmCntl(PCL_exeAdmCntl), 
                       .PCL_exeCmplmntA(PCL_exeCmplmntA),
                       .PCL_exeApuOp(PCL_exeApuOp), 
                       .PCL_exeCpuOp(PCL_exeCpuOp), 
                       .PCL_exeWrExtEn(PCL_exeWrExtEn), 
                       .PCL_exeLogicalCntl(PCL_exeLogicalCntl), 
                       .PCL_exePrivOp(PCL_exePrivOp),
                       .PCL_exeSprDataEn_NEG(PCL_exeSprDataEn_NEG), 
                       .PCL_exeSrmCntl(PCL_exeSrmCntl), 
                       .PCL_exeXerCaEn(PCL_exeXerCaEn), 
                       .PCL_exeXerOvEn(PCL_exeXerOvEn), 
                       .PCL_icuOp(PCL_icuOp),
                       .PCL_ldNotSt(PCL_exeLdNotSt_i), 
                       .PCL_mfSPR(PCL_mfSPR), 
                       .PCL_mtSPR(PCL_mtSPR), 
                       .PCL_nopStringIndexed(nopStringIndexed), 
                       .PCL_tlbRE(PCL_tlbRE), 
                       .PCL_tlbSX(PCL_tlbSX), 
                       .PCL_tlbWE(PCL_tlbWE),
                       .PCL_tlbWS(PCL_tlbWS), 
                       .exeFull(PCL_exeFull_i), 
                       .exeLSSMIURA(exeLSSMIURA), 
                       .exeMfdcr(exeMfdcr), 
                       .exeMtdcr(exeMtdcr), 
                       .exeRpWrEn(exeRpWrEn),
                       .exeXerTBCUpdInstr(exeXerTBCUpdInstr), 
                       .APU_dcdPrivOp(APU_dcdPrivOp), 
                       .CB(CB), 
                       .EXE_xerTBCNotEqZero(EXE_xerTBCNotEqZero), 
                       .APU_dcdApuOp(APU_dcdApuOp), 
                       .plaVal(plaVal), 
                       .dcdRegBit20(dcd1RBL2[4]), 
                       .dcdXerTBCUpdInstr(dcdXerTBCUpdInstr), 
                       .exeClearOrFlush(exeClearOrFlush), 
                       .exeE1(exeE1), 
                       .exeE2(exeE2),
                       .gtErr(gtErr), 
                       .plaAdmCntl(plaAdmCntl), 
                       .plaAddEn(plaAddEn), 
                       .plaCmplmntA(plaCmplmntA), 
                       .plaDcuOp(plaDcuOp), 
                       .plaEaCalc(plaEaCalc), 
                       .plaIcuOp(plaIcuOp),
                       .plaWrExtEn(plaWrExtEn), 
                       .plaLSSMIURA(plaLSSMIURA), 
                       .plaLdNotSt(plaLdNotSt), 
                       .plaLogicalCntl(plaLogicalCntl), 
                       .plaMfdcr(plaMfdcr), 
                       .plaMfspr(plaMfspr),
                       .plaMmuCode(plaMmuCode), 
                       .plaMtdcr(plaMtdcr), 
                       .plaMtspr(plaMtspr), 
                       .plaOeCk(plaOeCk), 
                       .plaPriv(plaPriv), 
                       .plaRpWrEn(plaRpWrEn), 
                       .plaSrmCntl(plaSrmCntl),
                       .plaUnitEn(plaUnitEn), 
                       .plaXerCaEn(plaXerCaEn), 
                       .nxtExeFull(nxtExeFull), 
                       .exeStorageOp(PCL_exeStorageOp_i), 
                       .plaLwarx(plaLwarx), 
                       .plaStwcx(plaStwcx), 
                       .exeLwarx(exeLwarx),
                       .exeStwcx(exeStwcx), 
                       .NplaApRdEn(NdcdApRdEn), 
                       .NplaBpRdEn(NplaBpRdEn), 
                       .plaSpRdEn(plaSpRdEn), 
                       .exeApRdEn(exeApRdEn), 
                       .exeBpRdEn(exeBpRdEn), 
                       .exeSpRdEn(exeSpRdEn), 
                       .plaWrtee(plaWrtee),
                       .PCL_exeWrtee(PCL_exeWrtee), 
                       .APU_dcdLoad(APU_dcdLoad), 
                       .APU_dcdStore(APU_dcdStore), 
                       .APU_dcdUpdate(APU_dcdUpdate), 
                       .APU_dcdFpuOp(APU_dcdFpuOp), 
                       .exeApuFpuOp(exeApuFpuOp),
                       .exeApuFpuLoad(exeApuFpuLoad), 
                       .PCL_exe2DataE1(PCL_exe2DataE1_i), 
                       .PCL_exe2DataE2(PCL_exe2DataE2_i), 
                       .exe2ClearOrFlush(PCL_exe2ClearOrFlush_i), 
                       .exe2Full(PCL_exe2Full_i),
                       .PCL_exeNegMac(PCL_exeNegMac), 
                       .PCL_exeFpuOp(PCL_exeFpuOp), 
                       .dcdApuValidOp_NEG(dcdApuValidOp_NEG), 
                       .APU_dcdGprWr(APU_dcdGprWr), 
                       .PCL_exeApuValidOp(PCL_exeApuValidOp), 
                       .plaMac(plaMac),
                       .plaNegMac(plaNegMac), 
                       .exeRpEqexe2RpAddr(exeRpEqexe2RpAddr), 
                       .PCL_exe2AccRegMuxSel(PCL_exe2AccRegMuxSel), 
                       .PCL_exe2NegMac(PCL_exe2NegMac), 
                       .PCL_exe2MacEn(PCL_exe2MacEn),
                       .PCL_exe2MultEn(PCL_exe2MultEn), 
                       .PCL_exe2MultHiWd(PCL_exe2MultHiWd), 
                       .PCL_exe2XerOvEn(PCL_exe2XerOvEn), 
                       .PCL_exeRbEn(PCL_exeRbEn), 
                       .PCL_exeDbgRdOp(PCL_exeDbgRdOp),
                       .PCL_exeDbgWrOp(PCL_exeDbgWrOp), 
                       .APU_dcdXerCAEn(APU_dcdXerCAEn), 
                       .APU_dcdXerOVEn(APU_dcdXerOVEn), 
                       .dcdMmuSprDcd(dcdMmuSprDcd), 
                       .PCL_mmuSprDcd(PCL_mmuSprDcd),
                       .exeStrgSt(exeStrgSt[1:2]), 
                       .PCL_exeMultEn(PCL_exeMultEn), 
                       .PCL_exeDivEn(PCL_exeDivEn), 
                       .PCL_exeLogicalUnitEn_NEG(PCL_exeLogicalUnitEn_NEG),
                       .PCL_exeSrmUnitEn_NEG(PCL_exeSrmUnitEn_NEG_i), 
                       .PCL_exeSprUnitEn_NEG(PCL_exeSprUnitEn_NEG), 
                       .exeEaCalc(exeEaCalc), 
                       .PCL_exeAddEn(PCL_exeAddEn), 
                       .PCL_exeMacEn(PCL_exeMacEn),
                       .PCL_exeRaEn(PCL_exeRaEn), 
                       .PCL_exeStringMultiple(PCL_exeStringMultiple), 
                       .plaGateZeroToAccReg(plaGateZeroToAccReg), 
                       .dcdSecOpBit21L2(dcd1SecOpL2[21]),
                       .dcdRSRTL2(dcd1RSRTL2), 
                       .PCL_exeTrapCond(PCL_exeTrapCond), 
                       .exeLoadQ(exeLoadQ), 
                       .plaMacSat(plaMacSat), 
                       .PCL_exe2MacSat(PCL_exe2MacSat), 
                       .exeMmuOp(exeMmuOp),
                       .PCL_Rbit(PCL_Rbit_i), 
                       .plaSrmBpSel(PCL_dcdSrmBpSel_i), 
                       .PCL_exeSrmBpSel(PCL_exeSrmBpSel_i), 
                       .PCL_exe2SignedOp(PCL_exe2SignedOp), 
                       .exeMultEn(exeMultEn),
                       .exeMacEn(exeMacEn), 
                       .PCL_exeDbgLdOp(PCL_exeDbgLdOp), 
                       .PCL_exeDbgStOp(PCL_exeDbgStOp), 
                       .APU_dcdRaEn(APU_dcdRaEn), 
                       .APU_dcdRbEn(APU_dcdRbEn), 
                       .APU_dcdForceAlgn(APU_dcdForceAlgn),
                       .APU_dcdExeLdDepend(APU_dcdExeLdDepend), 
                       .exeDivEn(exeDivEn), 
                       .APU_dcdWbLdDepend(APU_dcdWbLdDepend), 
                       .APU_dcdLwbLdDepend(APU_dcdLwbLdDepend), 
                       .exeApuExeWbLdUseL2(exeApuExeWbLdUseL2),
                       .exeApuExeLwbLdUseL2(exeApuExeLwbLdUseL2), 
                       .PCL_exeMultEn_NEG(PCL_exeMultEn_NEG), 
                       .PCL_exeDivEnForMuxSel(PCL_exeDivEnForMuxSel),
                       .PCL_exeCmplmntA_NEG(PCL_exeCmplmntA_NEG), 
                       .PCL_exe2MacOrMultEn_NEG(PCL_exe2MacOrMultEn_NEG), 
                       .PCL_exe2MacOrMultEnForMS(PCL_exe2MacOrMultEnForMS),
                       .PCL_exeMultEnForMuxSel(PCL_exeMultEnForMuxSel), 
                       .wbHold(PCL_wbHold_i), 
                       .ltchDA(ltchDA), 
                       .PCL_exeEaCalc(PCL_exeEaCalc), 
                       .plaApuLdSt(plaApuLdSt), 
                       .exeForceAlgn(exeForceAlgn),
                       .dcdIcuSprDcd(dcdIcuSprDcd), 
                       .dcdTimSprDcd(dcdTimSprDcd), 
                       .PCL_icuSprDcds(PCL_icuSprDcds), 
                       .PCL_timSprDcds(PCL_timSprDcds), 
                       .dcdDbgSprDcd(dcdDbgSprDcd), 
                       .dcdExeSprDcd(dcdExeSprDcd), 
                       .dcdVctSprDcd(dcdVctSprDcd), 
                       .PCL_dbgSprDcds(PCL_dbgSprDcds), 
                       .PCL_exeSprDcds(PCL_exeSprDcds), 
                       .PCL_vctSprDcds(PCL_vctSprDcds), 
                       .resetL2(resetL2), 
                       .plaForceAlgn(plaForceAlgn), 
                       .PCL_exeAddSgndOp_NEG(PCL_exeAddSgndOp_NEG), 
                       .PCL_exeDivSgndOp(PCL_exeDivSgndOp), 
                       .PCL_exeDivEn_NEG(PCL_exeDivEn_NEG), 
                       .PCL_dcuOp_early(PCL_dcuOp_early),
                       .exeFullForE1_NEG(exeFullForE1_NEG), 
                       .exe2FullForE1_NEG(exe2FullForE1_NEG), 
                       .APU_dcdTrapLE(APU_dcdTrapLE), 
                       .APU_dcdTrapBE(APU_dcdTrapBE), 
                       .APU_dcdForceBESteering(APU_dcdForceBESteering),
                       .exeTrapLE(exeTrapLE), 
                       .exeTrapBE(exeTrapBE), 
                       .exeForceBESteering(exeForceBESteering), 
                       .PCL_exeMacOrMultEn_NEG(PCL_exeMacOrMultEn_NEG), 
                       .plaMtcrf(plaMtcrf),
                       .LSSD_coreTestEn(LSSD_coreTestEn), 
                       .PCL_exeDivEnForLSSD(PCL_exeDivEnForLSSD), 
                       .IFB_dcdFull(IFB_dcdFull), 
                       .countE1(countE1), 
                       .PCL_exeSrmUnitEnForLSSD(PCL_exeSrmUnitEnForLSSD),
                       .exeApuFpuLdSt(exeApuFpuLdSt), 
                       .PCL_exeLogicalUnitEnForLSSD(PCL_exeLogicalUnitEnForLSSD), 
                       .exeStrgStC0(exeStrgStC0), 
                       .PCL_exeTlbOp(PCL_exeTlbOp), 
                       .dcdJtgSprDcd(dcdJtgSprDcd),
                       .PCL_jtgSprDcd(PCL_jtgSprDcd));
                             
p405s_storage
 storageSch(.PCL_addFour(PCL_addFour), 
                         .PCL_apuExeWdCnt(PCL_apuExeWdCnt), 
                         .PCL_dcuByteEn(PCL_dcuByteEn_i),
                         .PCL_dsOcmByteEn(PCL_dsOcmByteEn), 
                         .PCL_exeEaQwEn(PCL_exeEaQwEn), 
                         .algnErr(algnErr), 
                         .blkExeSpAddr(blkExeSpAddr), 
                         .byteCount(byteCount),
                         .cntGtEq4(cntGtEq4), 
                         .exeStrgSt(exeStrgSt), 
                         .exeStrgStC0(exeStrgStC0), 
                         .sPortSelInc(sPortSelInc), 
                         .strgEnd(strgEnd), 
                         .strgLpWrEn(strgLpWrEn), 
                         .APU_dcdLdStByte(APU_dcdLdStByte),
                         .APU_dcdLdStDw(APU_dcdLdStDw), 
                         .APU_dcdLdStHw(APU_dcdLdStHw), 
                         .APU_dcdLdStQw(APU_dcdLdStQw), 
                         .APU_dcdLdStWd(APU_dcdLdStWd), 
                         .CB(CB), 
                         .EXE_ea(EXE_ea), 
                         .EXE_xerTBC(EXE_xerTBC), 
                         .EXE_xerTBCIn(EXE_xerTBCIn), 
                         .IFB_exeFlush(IFB_exeFlush), 
                         .PCL_Rbit(PCL_Rbit_i), 
                         .countE1(countE1), 
                         .countE2(countE2), 
                         .dcdMultiple(dcdMultiple), 
                         .dcdRBL2(dcd1RBL2), 
                         .dcdRSRTL2(dcd1RSRTL2), 
                         .dcdStringImmediate(dcdStringImmediate),
                         .dcdStringIndexed(dcdStringIndexed), 
                         .exeAlg(exeLSSMIURA[7]), 
                         .exeApuFpuOp(exeApuFpuOp), 
                         .exeByteRev(exeLSSMIURA[6]), 
                         .exeDcread(PCL_dcuOp_i[10]), 
                         .exeEaCalc(exeEaCalc),
                         .exeForceAlgn(exeForceAlgn), 
                         .exeLd(exeLSSMIURA[0]), 
                         .exeLwarx(exeLwarx), 
                         .exeMultiple(exeLSSMIURA[3]), 
                         .exeStore(exeLSSMIURA[1]), 
                         .exeString(exeLSSMIURA[2]),
                         .exeStwcx(exeStwcx), 
                         .exeXerTBCUpdInstr(exeXerTBCUpdInstr), 
                         .gtErr(gtErr), 
                         .nopStringIndexed(nopStringIndexed), 
                         .plaApuLdSt(plaApuLdSt), 
                         .plaLdStByte(plaByteCnt[0]),
                         .plaLdStDw(plaByteCnt[3]), 
                         .plaLdStHw(plaByteCnt[1]), 
                         .plaLdStQw(plaByteCnt[4]), 
                         .plaLdStWd(plaByteCnt[2]), 
                         .plaVal(plaVal), 
                         .storageStMachE1(storageStMachE1),
                         .storageStMachE2(storageStMachE2));
                             
p405s_fileAddrGen
 fileAddrGenSch(.PCL_LpEqAp(PCL_lwbLpEqdcdApAddr_i), 
                                 .PCL_LpEqBp(PCL_lwbLpEqdcdBpAddr_i), 
                                 .PCL_LpEqSp(PCL_LpEqSp),
                                 .PCL_RpEqAp(PCL_wbRpEqdcdApAddr), 
                                 .PCL_RpEqBp(PCL_wbRpEqdcdBpAddr), 
                                 .PCL_RpEqSp(PCL_wbRpEqdcdSpAddr), 
                                 .PCL_dcdApAddr(PCL_dcdApAddr),
                                 .PCL_dcdBpAddr(PCL_dcdBpAddr), 
                                 .PCL_dcdSpAddr(PCL_dcdSpAddr), 
                                 .PCL_lwbLpAddr(PCL_lwbLpAddr), 
                                 .PCL_wbRpAddr(PCL_wbRpAddr),
                                 .exeApAddrL2(exeRA), 
                                 .exeMorMRpEqdcdApAddr(exeMorMRpEqdcdApAddr), 
                                 .exeMorMRpEqdcdBpAddr(exeMorMpEqdcdBpAddr), 
                                 .exeMorMRpEqexeRpAddr(exeRpEqexe2RpAddr),
                                 .exeMorMRpEqlwbLpAddr(exeMorMRpEqlwbLpAddr), 
                                 .exeMorMRpEqwbLpAddr(exeMorMRpEqwbLpAddr), 
                                 .exeRTeqRA(exeRTeqRA), 
                                 .exeRTeqRB(exeRTeqRB), 
                                 .exeRpEqdcdApAddr(exeRpEqdcdApAddr),
                                 .exeRpEqdcdBpAddr(exeRpEqdcdBpAddr), 
                                 .exeRpEqdcdSpAddr(exeRpEqdcdSpAddr), 
                                 .exeRpEqlwbLpAddr(exeRpEqlwbLpAddr), 
                                 .exeRpEqwbLpAddr(exeRpEqwbLpAddr), 
                                 .gprLpeqRp(gprLpeqRp),
                                 .lwbLpEqdcdSpAddr(lwbLpEqdcdSpAddr), 
                                 .lwbLpEqexeApAddr(lwbLpEqexeApAddr), 
                                 .lwbLpEqexeBpAddr(lwbLpEqexeBpAddr), 
                                 .lwbLpEqexeSpAddr(lwbLpEqexeSpAddr), 
                                 .wbLpEqdcdApAddr(wbLpEqdcdApAddr),
                                 .wbLpEqdcdBpAddr(wbLpEqdcdBpAddr), 
                                 .wbLpEqdcdSpAddr(wbLpEqdcdSpAddr), 
                                 .wbLpEqexeApAddr(wbLpEqexeApAddr), 
                                 .wbLpEqexeBpAddr(wbLpEqexeBpAddr), 
                                 .wbLpEqexeSpAddr(wbLpEqexeSpAddr),
                                 .APU_dcdUpdate(APU_dcdUpdate), 
                                 .CB(CB), 
                                 .DRCC(ICU_gprDRCC), 
                                 .ERC(1'b1), 
                                 .IFB_dcdFullL2(IFB_dcdFull),
                                 .LSSD_coreTestEn(LSSD_coreTestEn), 
                                 .PCL_exeMacEnL2(exeMacEn), 
                                 .PCL_exeMultEnL2(exeMultEn), 
                                 .c2Clk(c2Clk), 
                                 .dcdPriOpL2(dcd2PriOpL2), 
                                 .dcdRAL2(dcd2RAL2),
                                 .dcdRBL2(dcd2RBL2), 
                                 .dcdRSRTL2(dcd2RSRTL2), 
                                 .dcdSecOpL2(dcd2SecOpL2), 
                                 .exe1FullL2(PCL_exeFull_i), 
                                 .exe2FullL2(PCL_exe2Full_i), 
                                 .exeE1(exeE1),
                                 .exeE2(exeE2), 
                                 .exeLpAddrE2(exeLpAddrE2), 
                                 .exeLpMuxSel(exeLpMuxSel), 
                                 .exeMacOrMultRpAddrE2(exeMacOrMultRpAddrE2), 
                                 .exeRpAddrE2(exeRpAddrE2), 
                                 .exeRpAddrMuxSel(exeRpAddrMuxSel),
                                 .exeSpAddrE2(exeSpAddrE2), 
                                 .exeStore(exeLSSMIURA[1]), 
                                 .gtErr(gtErr), 
                                 .lwbE1(lwbE1), 
                                 .lwbFullL2(lwbFullL2_i), 
                                 .plaRpMuxSel(plaRpMuxSel), 
                                 .sPortSelInc(sPortSelInc), 
                                 .storeRSE1(countE1),
                                 .storeRSE2(storeRSE2), 
                                 .wbE1(wbE1), 
                                 .wbFullL2(wbFullForDepend), 
                                 .wbLpAddrE1(wbLpAddrE1), 
                                 .wbRAL2(wbRAL2), 
                                 .wbRpAddrE2(wbRpAddrE2), 
    //   Defect 2297
    //   PCL_BpEqSp);
                                 .PCL_BpEqSp(PCL_BpEqSp), 
                                 .PCL_gprRdClk(PCL_gprRdClk));
                             
p405s_dcdPla
 dcdPLA(.plaApuLdSt(plaApuLdSt), 
                    .plaMac(plaMac), 
                    .plaVal(plaVal), 
                    .plaPriv(plaPriv), 
                    .plaRaEq0Ck(plaRaEq0Ck), 
                    .NplaApRdEn(NplaApRdEn), 
                    .NplaBpRdEn(NplaBpRdEn),
                    .plaSpRdEn(plaSpRdEn), 
                    .plaLpWrEn(plaLpWrEn), 
                    .plaRpWrEn(plaRpWrEn), 
                    .plaRpMuxSel(plaRpMuxSel), 
                    .plaLitCntl(PCL_dcdLitCntl_i), 
                    .plaBpLitGenSel(PCL_bPortLitGenSel),
                    .plaCmplmntA(plaCmplmntA), 
                    .NplaAregEn(NplaAregEn), 
                    .NplaBregEn(NplaBregEn), 
                    .NplaSregEn(NplaSregEn), 
                    .plaSrmEn(plaSrmEn), 
                    .plaSrmMuxSel(PCL_dcdSrmBpSel_i),
                    .plaUnitEn(plaUnitEn), 
                    .plaAdmCntl(plaAdmCntl), 
                    .plaLogicalCntl(plaLogicalCntl), 
                    .plaSrmCntl(plaSrmCntl), 
                    .plaEaCalc(plaEaCalc),
                    .plaAddEn(plaAddEn), 
                    .plaLSSMIURA(plaLSSMIURA), 
                    .plaByteCnt(plaByteCnt), 
                    .plaIcuOp(plaIcuOp), 
                    .plaDcuOp(plaDcuOp),
                    .plaMmuCode(plaMmuCode), 
                    .PCL_dcdHotCIn(PCL_dcdHotCIn), 
                    .PCL_dcdXerCa(PCL_dcdXerCa), 
                    .plaOeCk(plaOeCk), 
                    .plaXerCaEn(plaXerCaEn), 
                    .plaMtspr(plaMtspr), 
                    .plaMfspr(plaMfspr),
                    .plaMtdcr(plaMtdcr), 
                    .plaMfdcr(plaMfdcr), 
                    .plaWrExtEn(plaWrExtEn), 
                    .plaWrtee(plaWrtee), 
                    .accTyp(plaLdNotSt), 
                    .plaLwarx(plaLwarx), 
                    .plaStwcx(plaStwcx), 
                    .plaMrSel(plaMrSel),
                    .plaMdSel(plaMdSel), 
                    .plaNegMac(plaNegMac), 
                    .plaGateZeroToAccReg(plaGateZeroToAccReg), 
                    .plaMacSat(plaMacSat), 
                    .plaForceAlgn(plaForceAlgn), 
                    .plaApuDiv(plaApuDiv), 
                    .plaMtcrf(plaMtcrf),
                    .priOp(dcd1PriOpL2), 
                    .sprMsb(dcd1RAL2[0]), 
                    .secOp(dcd1SecOpL2), 
                    .pgmEn({PGM_divEn, PGM_mmuEn}));

endmodule
