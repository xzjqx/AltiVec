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
module p405s_pipeCntl (PCL_dcdAregLoadUse, PCL_aPortRregBypass, PCL_abRegE1, PCL_aRegE2,
           PCL_dcdBregLoadUse, PCL_bPortRregBypass, PCL_bRegE2, PCL_blkFlush,
           PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dcdHoldForIfb, PCL_dofDRegE1,
           PCL_dofDRegMuxSel, PCL_exeIarHold, PCL_mfDCR, PCL_mtDCR, PCL_gateZeroToAreg,
           PCL_gateZeroToSreg, PCL_holdCIn, PCL_ldAdjE1, PCL_ldAdjMuxSel, PCL_ldMuxSel,
           PCL_lwbLpWrEn, /*PCL_resultMuxSel,*/ PCL_resultRegE1, PCL_resultRegE2,
           PCL_dcdSregLoadUse, PCL_sPortRregBypass, PCL_sRegE1, PCL_sRegE2,
           PCL_sraRegE1, PCL_dIcmpForStep, PCL_srmRegE1, PCL_srmRegE2, PCL_wbHold,
           PCL_xerL2Hold, countE2, dcdStringImmediate, dcdXerTBCUpdInstr,
           exeClearOrFlush, exeE1, exeE2, exeLpAddrE2, exeLpMuxSel, exeRpAddrE2,
           gtErr, loadSteerMuxSel, lwbE1, nxtWbLpWrEn, storageStMachE2, storeRSE2,
           PCL_wbClearOrFlush, wbE1, wbE2, APU_exeBlkingMco, APU_exeBusy,
           APU_exeNonBlkingMco, CB, DCU_CA, DCU_DA, DCU_DOF, EXE_admMco, ICU_dsCA,
           IFB_dcdFull, gprLpeqRp, MMU_BMCO, MMU_wbHold, NplaApRdEn, NplaAregEn,
           NplaBpRdEn, NplaBregEn, plaSpRdEn, NplaSregEn, OCM_dsComplete, OCM_DOF,
           VCT_exeSuppress, VCT_wbFlush, coreReset, dcdRAL2, dcdSPRN, XXX_dcrAck, exeEaCalc,
           exeLSSMIURA, lwbLpEqdcdApAddr, lwbLpEqdcdBpAddr, lwbLpEqdcdSpAddr, exeMfdcr,
           exeMtdcr, exeRTeqRA, exeRTeqRB, exeRpEqdcdApAddr, exeRpEqdcdBpAddr,
           exeRpEqdcdSpAddr, exeRpEqlwbLpAddr, exeRpEqwbLpAddr, exeRpWrEn, exeStrgSt,
           ldAdjSel, lwbLpEqexeApAddr, lwbLpEqexeBpAddr, lwbLpEqexeSpAddr, nopStringIndexed,
           plaLSSMIURA, plaLogicalCntl, plaMtspr, plaRaEq0Ck, plaSrmEn, priOp, strgEnd,
           strgLpWrEn, wbFull, wbLoad, wbLpEqdcdApAddr, wbLpEqdcdBpAddr, wbLpEqdcdSpAddr,
           wbLpWrEn, sPortSelInc, sprHold, exeRpWrEnQ, nxtExeFull, exeFull, IFB_exeCorrect,
           IFB_trcPipeHold, wbRpAddrE2, plaLpWrEn, PCL_wbRpWrEn, wbStrgLS, PCL_exeAbort,
           exeStwcx, wbLwarx, wbStwcx, VCT_wbSuppress, wbLpEqexeApAddr, wbLpEqexeBpAddr,
           wbLpEqexeSpAddr, exeApRdEn, exeBpRdEn, exeSpRdEn, exeSpAddrE2,
           PCL_exeAregLoadUse, PCL_exeBregLoadUse, PCL_exeSregLoadUse,
           EXE_divMco, IFB_dcdBubble, plaTrap,
           exeSrmUnitEn, NdcdApRdEn, DCU_pclOcmLdPendNoWait, PCL_Rbit, ICU_LDBE,
           PCL_apuLwbLoadDV, PCL_apuTrcLoadEn, wbApuFpuLoad, exeApuFpuOp,
           IFB_exeFlush, plaDcuOp, VCT_errorSprSuppress,
           DCU_firstCycCarStXltV, DBG_dvcRdEn, DBG_dvcWrEn, exeDcbz, exeDcba,
           exeMultEn, exeDivEn, exeMacEn, PCL_apuExeHold,
           PCL_apuExeFlush, EXE_trap, PCL_exeTrap, exe2Full,
           plaMacEn, DBG_icmpEn,
           PCL_exeDvcHold, PCL_wbStorageOp,
           PCL_exe2Hold, EXE_multMco,
           PCL_dvcCmpEn, PCL_exe2IarE1, PCL_exe2IarE2, PCL_exe2DataE1,
           PCL_exe2DataE2, PCL_exe2ClearOrFlush, wbLdOrStWUD, exeMacOrMultRpAddrE2,
           exeRpAddrMuxSel, dcdMmuSprDcd, PCL_trcLoadDV, wbStrgC1, PCL_wbDbgIcmp,
           MMU_dsStatus, IFB_exeRfciL2, IFB_exeRfiL2, IFB_exeScL2, VCT_wbFlushAsync,
           IFB_stepStL2, PCL_mfDCRL2, PCL_wbHoldNonErr, PCL_wbFullForPO,
           PCL_wbComplete, PCL_apuDcdHold, exeMorMRpEqdcdApAddr, exeMorMRpEqdcdBpAddr,
           lwbFullL2, VCT_wbLoadSuppress, plaMultEn, plaLogicalUnitEn, plaVal, blkExeSpAddr,
           storageStMachE1, wbLpAddrE1, PCL_exeHoldForCr, PCL_wbClearTerms, dcdMultiple,
           dcdStringIndexed, PCL_dIcmpForStuff, IFB_stuffStL2, PCL_sdqMuxSel,
           PCL_wbStrgEnd, DBG_exeIacSuppress, plaMrSel, plaMdSel, PCL_dcdMrSelQ,
           PCL_dcdMdSelQ, PCL_mmuExeAbort, PCL_wbAlgnErr, DBG_wbDacSuppress,
           VCT_exeSuppForApu, exeMmuOp, PCL_exeLoadUseHold,
           PCL_holdMdMr, PCL_exeSrmBpSel, plaStwcx, exeLwarx,
           PCL_dIcmpForWbFlushQDlydL2, exeRpEqexe2RpAddr, exeMorMRpEqwbLpAddr,
           exeMorMRpEqlwbLpAddr, VCT_exeSuppForExe2Clear, wbByteEn, DCU_carByteEn,
           PCL_dvcByteEnL2, PCL_aRegForEaE2, PCL_bRegForEaE2, PCL_apuWbHold,
           exeApuExeWbLdUseL2, exeApuExeLwbLdUseL2, ltchDA, dcdTimSprDcd,
           dcdIcuSprDcd, plaMfspr, VCT_exeSuppForCr, dcdDbgSprDcd, dcdExeSprDcd,
           dcdVctSprDcd, resetL2, PCL_dcdLitCntl, plaEaCalc, exeFullForE1_NEG,
           exe2FullForE1_NEG, wbFullForPO, plaApuDiv, LSSD_coreTestEn, PCL_ocmAbortReq,
           exeStrgStC0, wbLoadForApu, PCL_blkFlushForVct, dcdJtgSprDcd, 
	   PCL_sraRegE2, VCT_sxrOR_L2, PCL_exeDvcOrParityHold,
	   CAR_cacheable, PCL_lwbCacheableL2, PCL_dofDregFull, ICU_CCR0DPP);
    output PCL_dcdAregLoadUse;
    output PCL_aPortRregBypass;
    output PCL_abRegE1;
    output PCL_aRegE2;
    output PCL_dcdBregLoadUse;
    output PCL_bPortRregBypass;
    output PCL_bRegE2;
    output PCL_blkFlush;
    output [0:2] PCL_blkFlushForVct;
    output PCL_dRegBypassMuxSel;
    output PCL_dRegE1;
    output [0:2] PCL_dcdHoldForIfb;
    output PCL_dofDRegE1;
    output [0:1] PCL_dofDRegMuxSel;
    output PCL_exeIarHold;
    output PCL_mfDCR;
    output PCL_mtDCR;
    output PCL_gateZeroToAreg;
    output PCL_gateZeroToSreg;
    output PCL_holdCIn;
    output PCL_ldAdjE1;
    output [0:1] PCL_ldAdjMuxSel;
    output [0:7] PCL_ldMuxSel;
    output PCL_lwbLpWrEn;
  //  output PCL_resultMuxSel;
    output PCL_resultRegE1;
    output PCL_resultRegE2;
    output PCL_dcdSregLoadUse;
    output PCL_sPortRregBypass;
    output PCL_sRegE1;
    output PCL_sRegE2;
    output PCL_sraRegE1;
    output PCL_dIcmpForStep;
    output PCL_dIcmpForStuff;
    output PCL_srmRegE1;
    output [0:2] PCL_srmRegE2;
    output sprHold;
    output PCL_wbHold;
    output PCL_xerL2Hold;
    output countE2;
    output dcdStringImmediate;
    output dcdXerTBCUpdInstr;
    output exeClearOrFlush;
    output exeE1;
    output exeE2;
    output exeLpAddrE2;
    output exeLpMuxSel;
    output exeRpAddrE2;
    output gtErr;
    output loadSteerMuxSel;
    output lwbE1;
    output nxtWbLpWrEn;
    output storageStMachE2;
    output storeRSE2;
    output PCL_wbClearOrFlush;
    output wbE1;
    output wbE2;
    output exeRpWrEnQ;
    output nxtExeFull;
    output wbRpAddrE2;
    output exeSpAddrE2;
    output PCL_exeAbort;
    output PCL_exeAregLoadUse;
    output PCL_exeBregLoadUse;
    output PCL_exeSregLoadUse;
    output NdcdApRdEn;
    output PCL_Rbit;
    output PCL_apuTrcLoadEn;
    output PCL_apuLwbLoadDV;
    output PCL_apuExeHold;
    output PCL_apuExeFlush;
    output PCL_exeTrap;
    output PCL_exeDvcHold;
    output PCL_exe2Hold;
    output PCL_dvcCmpEn;
    output PCL_exe2IarE1;
    output PCL_exe2IarE2;
    output PCL_exe2DataE1;
    output PCL_exe2DataE2;
    output PCL_exe2ClearOrFlush;
    output exeMacOrMultRpAddrE2;
    output exeRpAddrMuxSel;
    output [0:8] dcdMmuSprDcd;
    output PCL_trcLoadDV;
    output PCL_wbDbgIcmp;
    output PCL_mfDCRL2;
    output PCL_wbHoldNonErr;
    output PCL_wbFullForPO;
    output PCL_wbComplete;
    output PCL_apuDcdHold;
    output lwbFullL2;
    output storageStMachE1;
    output wbLpAddrE1;
    output PCL_exeHoldForCr;
    output PCL_wbClearTerms;
    output dcdStringIndexed;
    output dcdMultiple;
    output PCL_sdqMuxSel;
    output PCL_dcdMrSelQ;
    output PCL_dcdMdSelQ;
    output PCL_mmuExeAbort;
    output PCL_exeLoadUseHold;
    output PCL_holdMdMr;
    output PCL_dIcmpForWbFlushQDlydL2;
    output [0:3] PCL_dvcByteEnL2;
    output PCL_aRegForEaE2;
    output PCL_bRegForEaE2;
    output PCL_apuWbHold;
    output ltchDA;
    
    output [0:2] dcdIcuSprDcd;
       
    output [0:5] dcdTimSprDcd;
    output [0:3] dcdDbgSprDcd;
    output [0:4] dcdExeSprDcd;

    output [0:5] dcdVctSprDcd;              // Took out MCSRS decode 
         
    output dcdJtgSprDcd;
    output resetL2;
    output PCL_ocmAbortReq;
    output PCL_sraRegE2;
    output PCL_exeDvcOrParityHold;
    output PCL_lwbCacheableL2;
    output PCL_dofDregFull;
    
    input exeStrgStC0;
    input APU_exeBlkingMco;
    input APU_exeBusy;
    input APU_exeNonBlkingMco;
    input CB;
    input DCU_CA;
    input DCU_DA;
    input DCU_DOF;
    input EXE_admMco;
    input ICU_dsCA;
    input IFB_dcdFull;
    input VCT_sxrOR_L2;
    input gprLpeqRp;
    input MMU_BMCO;
    input MMU_wbHold;
    input NplaApRdEn;
    input NplaAregEn;
    input NplaBpRdEn;
    input NplaBregEn;
    input plaSpRdEn;
    input NplaSregEn;
    input OCM_dsComplete;
    input OCM_DOF;
    input VCT_exeSuppress;
    input VCT_wbFlush;
    input coreReset;
    input [0:4] dcdRAL2;
    input [0:9] dcdSPRN;
    input XXX_dcrAck;
    input exeEaCalc;
    input [0:5] exeLSSMIURA;
    input lwbLpEqdcdApAddr;
    input lwbLpEqdcdBpAddr;
    input lwbLpEqdcdSpAddr;
    input exeMfdcr;
    input exeMtdcr;
    input exeRTeqRA;
    input exeRTeqRB;
    input exeRpEqdcdApAddr;
    input exeRpEqdcdBpAddr;
    input exeRpEqdcdSpAddr;
    input exeRpEqlwbLpAddr;
    input exeRpEqwbLpAddr;
    input exeRpWrEn;
    input [0:2] exeStrgSt;
    input [1:3] ldAdjSel;
    input lwbLpEqexeApAddr;
    input lwbLpEqexeBpAddr;
    input lwbLpEqexeSpAddr;
    input nopStringIndexed;
    input [0:4] plaLSSMIURA;
    input [6:7] plaLogicalCntl;
    input plaMtspr;
    input plaRaEq0Ck;
    input plaSrmEn;
    input [0:5] priOp;
    input strgEnd;
    input strgLpWrEn;
    input wbFull;
    input wbLoad;
    input wbLpEqdcdApAddr;
    input wbLpEqdcdBpAddr;
    input wbLpEqdcdSpAddr;
    input wbLpWrEn;
    input sPortSelInc;
    input exeFull;
    input IFB_exeCorrect;
    input IFB_trcPipeHold;
    input plaLpWrEn;
    input PCL_wbRpWrEn;
    input wbStrgLS;
    input exeStwcx;
    input wbLwarx;
    input wbStwcx;
    input VCT_wbSuppress;
    input wbLpEqexeApAddr;
    input wbLpEqexeBpAddr;
    input wbLpEqexeSpAddr;
    input exeApRdEn;
    input exeBpRdEn;
    input exeSpRdEn;
    input EXE_divMco;
    input IFB_dcdBubble;
    input plaTrap;
    input exeSrmUnitEn;
    input DCU_pclOcmLdPendNoWait;
    input ICU_LDBE;
    input wbApuFpuLoad;
    input exeApuFpuOp;
    input IFB_exeFlush;
    input [4:5] plaDcuOp;
    input VCT_errorSprSuppress;
    input DCU_firstCycCarStXltV;
    input DBG_dvcRdEn;
    input DBG_dvcWrEn;
    input exeDcbz;
    input exeDcba;
    input exeMultEn;
    input exeDivEn;
    input exeMacEn;
    input EXE_trap;
    input exe2Full;
    input plaMacEn;
    input DBG_icmpEn;
    input PCL_wbStorageOp;
    input EXE_multMco;
    input wbLdOrStWUD;
    input wbStrgC1;
    input [0:4] MMU_dsStatus;
    input IFB_exeRfciL2;
    input IFB_exeRfiL2;
    input IFB_exeScL2;
    input IFB_stepStL2;
    input VCT_wbFlushAsync;
    input exeMorMRpEqdcdApAddr;
    input exeMorMRpEqdcdBpAddr;
    input VCT_wbLoadSuppress;
    input plaLogicalUnitEn;
    input plaMultEn;
    input plaVal;
    input blkExeSpAddr;
    input IFB_stuffStL2;
    input PCL_wbStrgEnd;
    input DBG_exeIacSuppress;
    input plaMrSel;
    input plaMdSel;
    input PCL_wbAlgnErr;
    input DBG_wbDacSuppress;
    input VCT_exeSuppForApu;
    input exeMmuOp;
    input [0:2] PCL_exeSrmBpSel;
    input plaStwcx;
    input exeLwarx;
    input exeRpEqexe2RpAddr;
    input exeMorMRpEqwbLpAddr;
    input exeMorMRpEqlwbLpAddr;
    input VCT_exeSuppForExe2Clear;
    input [0:3] wbByteEn;
    input [0:3] DCU_carByteEn;
    input exeApuExeWbLdUseL2;
    input exeApuExeLwbLdUseL2;
    input plaMfspr;
    input VCT_exeSuppForCr;
    input [2:4] PCL_dcdLitCntl;
    input plaEaCalc;
    input exeFullForE1_NEG;
    input exe2FullForE1_NEG;
    input wbFullForPO;
    input plaApuDiv;
    input LSSD_coreTestEn;
    input wbLoadForApu;
    input CAR_cacheable;
    input ICU_CCR0DPP;

// Changes:
// 01/05/99 SBP Change the PCL_resultRegE2 equation. See issue 348 for more detail.
// 01/06/99 SBP Change exeRpAddrE2 equation. See issue 351 for more detail.
// 01/08/99 SBP Change PCL_sRegE2 and PCL_sPortRregBypass equation.
//              See issue 353 for more detail.
// 01/11/99 SBP Change PCL_exe2ClearOrFlush equation. See issue 357 for more detail.
// 01/11/99 SBP Change exeRpEqwbOrlwbLpAddr equation. See issue 358 for more detail.
// 05/02/99 SBP Added PCL_sraRegE2 output signal and updated wbRpAddrE2.
//              See issue 137 pass2 for more detail.
// 06/24/99 SBP ORed wbHold to PCL_exeAbort to abort load string with LS in WB.
//              See issue 139 pass2 for more detail.
// 06/29/99 SBP Changed dcrCntIn equation. See issue 140 pass2 for more detail.
// 06/30/99 SBP Added IFB_exeFlush to dcrCntIn equation.
// 07/26/99 SBP Changed PCL_exeAbort and PCL_mmuExeAbort equation. See issue 383 for more detail.
// 09/08/99 SBP Changed PCL_gateZeroToSreg equation. See issue 150 for more detail.
// 09/08/99 SBP Changed exeFlushForApu_NEG equation. See issue 151 for more detail.
// 09/24/99 SBP Changed PCL_dcdSregLoadUse equation. See issue 154 for more detail.
// 10/07/99 SBP Changed exeHoldForApu_NEG equation. See issue 157 for more detail.
// 02/17/00 SBP Changed PCL_srmRegE1 equation. See issue 170 for more detail.
// 04/04/00 SBP Changed gtErr equation. See issue 184 for more detail.
// 07/11/00 SBP Changed PCL_dRegE1 equation. See issue 192 for more detail for PTcruiser only.
// 07/25/00 SBP Changed PCL_dRegE1 equation. See issue 193 for more detail. Undo the change for PTcruiser.
//

//***********************************************************************************************//
//................................COBRA Changes..................................................//
//***********************************************************************************************//

//
//    Date              By Whom                    Description
// ~~~~~~~~~           ~~~~~~~~~              ~~~~~~~~~~~~~~~~~~~~~~~
//  07/30/01             JBB           Initial changes made per Cobra Workbook:
//
//                                     (1) Added exeParityHold and exeDvcOrParityHold
//                                         equations
//                                     (2) Added new outputs PCL_exeDvcOrParityHold
//                                         and PCL_lwbCacheableL2
//                                     (3) Brought in CAR_cacheable (from MMU) 
//                                         and ICU_CCR0DPP (from ICU) through pcl_top.v
//                                     (4) Added exeDvcOrParityHold to all equations
//                                         that formerly only had exeDvcHold in them
//                                     (5) Put in new signal lwbCacheable into
//                                         LWB control logic 
//                                     (6) Widened regPCL_pipeCntl register to 
//                                         accommodate lwbCacheable/lwbCacheableL2
//                                     (7) Widened dcdVctSprDcd bus for MCSR/MCSRS
//                                     (8) Widened register regPCL_exeCacheCntl 
//                                         for new dcdVctSprDcd bits 
//---------------------------------------------------------------------------------------------------- 
//  08/06/01              JBB          Changed address decode numbers of MCSR and MCSRS:  
//                                     MCSR  [SPRN] was 0x3d6 ---> 0x23c.
//                                     MCSRS [SPRN] was 0x3d7 ---> 0x33c.
//                                     (defect 1803)
//----------------------------------------------------------------------------------------------------
//  08/08/01              JBB          Put exeLoadUseHold back into PCL_mmuExeAbort equation 
//                                     (defect 1818)
//----------------------------------------------------------------------------------------------------
//  08/20/01              JBB          Removed (| lwbCacheable & ~ltchDA) part of lwbCacheable 
//                                     equation (defect 1841)
//----------------------------------------------------------------------------------------------------
//  08/28/01              JBB          (1) Changed lwbCacheable to lwbCacheableL2 in exeParityHold
//                                         equation.
//                                     (2) Renamed lwbCacheable nxtLwbCacheable.  
//                                     (3) Changed free running latch equations to reflect (2)
//                                     (4) Put lwbCacheableL2/nxtLwbCacheable on front side of
//                                         regPCL_pipeCntl (for Formality compatibility)
//                                         (defect 1861)
//----------------------------------------------------------------------------------------------------
//  09/14/01              JBB          Removed exeParityHold from the equation for PCL_mmuExeAbort
//                                     (exeDvcOrParityHold covers exeParityHold and is already in the eq).
//----------------------------------------------------------------------------------------------------
//  10/05/01              JBB          (1) Added/widened dcdVctSprDcd bus by one bit.  Needed
//                                         the extra bit for the hardware injection register (CCR1 -- SPR 0x378).
//                                         (defect 1935)
//----------------------------------------------------------------------------------------------------
//  10/11/01              JBB          (1) Widened dcdIcuSprDcd bus by one bit.  Took out bit in 
//                                         dcdVctSprDcd bus.  Corrected previous change.
//                                         (defect 1955)
//----------------------------------------------------------------------------------------------------
//  10/17/01              JBB          Took out mcsrsDcd here and its bit on the dcdVctSprDcd bus
//                                     (defect 1971)
//----------------------------------------------------------------------------------------------------
//  11/13/01              JBB          Removed wbCacheable and lwbCacheableL2 from exeParityHold
//                                     equation (defect 2045)
//----------------------------------------------------------------------------------------------------
//  11/30/01              JBB          Modified Block Flush logic --- Added a term to setBlkFlush
//                                     and rstBlkFlush to account for precise mode loads. 
//                                     (defect 2062)
//----------------------------------------------------------------------------------------------------
//
//****************************************************************************************************                                   
wire dofDregFullIn0, dofDregFullIn1, exeHoldForStDvc, nxtLwbStrgLS;
wire exeStrgC1, exeStrgLS, exeStrgE0, exeStrgC0orC1;
wire dcrMco, dcrAck, dofDregFull, exeLoadUseHold, nxtTrapMco;
wire wbHold, aRegLoadUseHold,  bRegLoadUseHold, sRegLoadUseHold;
wire steerOCM, dcdXerDcd, trcLoadDVIn0, trcLoadDVIn1, ltchDAIn0;
wire storageMco, dcdHold, apuLoadDVIn0, apuLoadDVIn1, ltchDAIn1, exeHoldForApu_NEG;
wire nxtLwbFull, PCL_exeIarHold, exe1HoldForExe2;
wire nxtLwbLpWrEn, exeLpWrEnQ, dcdBubbleForApu;
wire nxtBlkFlush, setBlkFlush, rstBlkFlush, wbHoldForExeOprd;
wire setRbit, rstRbit, nxtRbit, exeRpEqwbOrlwbLpAddr;
wire lwbLpEqexeApAddrQ, lwbLpEqexeBpAddrQ, lwbLpEqexeSpAddrQ, exeHoldForWb;
wire wbLpEqexeApAddrQ, wbLpEqexeBpAddrQ, wbLpEqexeSpAddrQ, sprLoadUseHold;
wire exeRpEqdcdApAddrQ, lwbLpEqdcdApAddrQ, wbLpEqdcdApAddrQ, nxtLwbApuFpu;
wire exePotStDvc, exeDvcHold, nxtDofStValid, potDvc, nxtWbStDvc, nxtdIcmpForWbFlush;
wire nxtExeTrap, setTrapMco, rstTrapMco, dcdBubble;
wire exeFlushForApu_NEG, exeStwcxC0, exeStwcxC1;
wire apuLoadUseHold, exeHoldForBlkFlush;
wire apuTrcLoadEnIn0, apuTrcLoadEnIn1;
reg lwbFullForApuL2;
wire [0:1] dvcByteEnMuxSel;
reg dofDregFullL2_NEG_i;
reg apuLoadDVL2_NEG_i;
reg ltchDAL2_NEG_i;
reg ltchDAForApuL2_NEG_i;
reg trcLoadDVL2_NEG_i;
reg apuTrcLoadEnL2_NEG_i;
wire dofDregFullL2_NEG;
wire apuLoadDVL2_NEG;
wire ltchDAL2_NEG;
wire ltchDAForApuL2_NEG;
wire trcLoadDVL2_NEG;
wire apuTrcLoadEnL2_NEG;


reg lwbStrgLSL2;
reg lwbLpWrEnL2;
reg lwbFullL2_i;
reg PCL_blkFlush_i;
reg [0:2] PCL_blkFlushForVct_i;
reg PCL_Rbit_i;
reg trapMco;
reg lwbApuFpu;
reg dofStValidL2;
reg wbStDvcL2;
reg PCL_exeTrap;
reg apuBMcoDlydL2;
reg PCL_dIcmpForWbFlushQDlydL2;

wire plaLd, plaSt, plaString, plaMult, plaIndexed;
wire exeLd, exeSt, exeString, exeMult, exeIndexed, exeWUD;
wire dvcWrEn, dvcRdEn;
wire  setMtdcr, setMfdcr, nxtMtdcr, nxtMfdcr, rstMtdcr, rstMfdcr, dcrE1;
wire [0:6] dcrCntInc, dcrCntIn;
wire ltchDAForApu;
reg resetL2_i;
reg [0:6] dcrCnt;
reg mtDCRL2;
reg PCL_mfDCRL2_i;
reg dcrAckL2;

wire wbCacheable;
wire exeParityHold;
wire exeDvcOrParityHold;
wire PCL_lwbCacheableL2;
reg lwbCacheableL2;
wire PCL_dofDregFull;
wire nxtLwbCacheable;


reg [0:3] PCL_dvcByteEnL2_i;
wire ltchDA_i;
wire PCL_exeSregLoadUse_i;
wire PCL_exeBregLoadUse_i;
wire PCL_exeAregLoadUse_i;
wire PCL_exeAbort_i;
wire exeRpWrEnQ_i;
wire gtErr_i;
wire PCL_sPortRregBypass_i;
wire PCL_exeIarHold_i;
wire PCL_bPortRregBypass_i;
wire PCL_aPortRregBypass_i;

assign PCL_aPortRregBypass = PCL_aPortRregBypass_i;
assign PCL_bPortRregBypass = PCL_bPortRregBypass_i;
assign PCL_exeIarHold = PCL_exeIarHold_i;
assign PCL_sPortRregBypass = PCL_sPortRregBypass_i;
assign gtErr = gtErr_i;
assign exeRpWrEnQ = exeRpWrEnQ_i;
assign PCL_exeAbort = PCL_exeAbort_i;
assign PCL_exeAregLoadUse = PCL_exeAregLoadUse_i;
assign PCL_exeBregLoadUse = PCL_exeBregLoadUse_i;
assign PCL_exeSregLoadUse = PCL_exeSregLoadUse_i;
assign ltchDA = ltchDA_i;

assign PCL_dvcByteEnL2 = PCL_dvcByteEnL2_i;

//************************************************************************
// Parity Hold for WB and LWB
//************************************************************************



assign lwbFullL2 = lwbFullL2_i;
assign PCL_blkFlush = PCL_blkFlush_i;
assign PCL_blkFlushForVct = PCL_blkFlushForVct_i;
assign PCL_Rbit = PCL_Rbit_i;
assign resetL2 = resetL2_i;
assign PCL_mfDCRL2 = PCL_mfDCRL2_i;

assign wbCacheable = CAR_cacheable;

//assign exeParityHold = ICU_CCR0DPP & ((wbLoad & wbCacheable) | (lwbFullL2_i & lwbCacheableL2));
assign exeParityHold = ICU_CCR0DPP & (wbLoad | lwbFullL2_i) & exeFull;

assign exeDvcOrParityHold     = exeDvcHold | exeParityHold;
assign PCL_exeDvcOrParityHold = exeDvcOrParityHold;   
assign PCL_lwbCacheableL2 = lwbCacheableL2; // See LWB Control free running latch
assign PCL_dofDregFull = dofDregFull;
           
//************************************************************************
// Bus Expansion
//************************************************************************
assign plaLd =  plaLSSMIURA[0];
assign plaSt =  plaLSSMIURA[1];
assign plaString =  plaLSSMIURA[2];
assign plaMult =  plaLSSMIURA[3];
assign plaIndexed =  plaLSSMIURA[4];

assign exeLd =  exeLSSMIURA[0];
assign exeSt =  exeLSSMIURA[1];
assign exeString =  exeLSSMIURA[2];
assign exeMult =  exeLSSMIURA[3];
assign exeIndexed =  exeLSSMIURA[4];
assign exeWUD =  exeLSSMIURA[5];

//************************************************************************
// EXE Unit Cntl Logic
//************************************************************************
//*********************
// Decode Stage Logic *
//*********************
assign exeRpEqwbOrlwbLpAddr = (exeRpWrEn & exeStrgStC0 &
                              ((exeRpEqwbLpAddr & wbLpWrEn) | (exeRpEqlwbLpAddr & lwbLpWrEnL2))) |
                              ((exeMorMRpEqwbLpAddr & wbLpWrEn) | (exeMorMRpEqlwbLpAddr & lwbLpWrEnL2));
assign exeRpEqdcdApAddrQ = exeRpEqdcdApAddr & ~(plaRaEq0Ck & ~|dcdRAL2[0:4]);
assign lwbLpEqdcdApAddrQ = lwbLpEqdcdApAddr & ~(plaRaEq0Ck & ~|dcdRAL2[0:4]);
assign wbLpEqdcdApAddrQ = wbLpEqdcdApAddr & ~(plaRaEq0Ck & ~|dcdRAL2[0:4]);

assign lwbLpEqexeApAddrQ = lwbLpEqexeApAddr & exeApRdEn & lwbLpWrEnL2;
assign lwbLpEqexeBpAddrQ = lwbLpEqexeBpAddr & exeBpRdEn & lwbLpWrEnL2;
assign lwbLpEqexeSpAddrQ = lwbLpEqexeSpAddr & exeSpRdEn & lwbLpWrEnL2;
assign wbLpEqexeApAddrQ = wbLpEqexeApAddr & exeApRdEn & wbLpWrEn;
assign wbLpEqexeBpAddrQ = wbLpEqexeBpAddr & exeBpRdEn & wbLpWrEn;
assign wbLpEqexeSpAddrQ = wbLpEqexeSpAddr & exeSpRdEn & wbLpWrEn;

assign PCL_dcdAregLoadUse = (~PCL_aPortRregBypass_i & ~NplaApRdEn) &
                            ((wbLpEqdcdApAddrQ & wbLpWrEn) |
                             (lwbLpWrEnL2 & lwbLpEqdcdApAddrQ & (~ltchDA_i | dofDregFull)));

assign PCL_dcdBregLoadUse = (~PCL_bPortRregBypass_i & ~NplaBpRdEn) &
                            ((wbLpEqdcdBpAddr & wbLpWrEn) |
                             (lwbLpWrEnL2 & lwbLpEqdcdBpAddr & (~ltchDA_i | dofDregFull)));

// issue154 fix.
assign PCL_dcdSregLoadUse = (~PCL_sPortRregBypass_i & (plaSpRdEn | sPortSelInc)) &
                            ((wbLpEqdcdSpAddr & wbLpWrEn) |
                             (lwbLpWrEnL2 & lwbLpEqdcdSpAddr & (~ltchDA_i | dofDregFull)));

assign PCL_exeAregLoadUse_i = (lwbLpEqexeApAddrQ & (~ltchDA_i | dofDregFull)) |
                             wbLpEqexeApAddrQ;

assign PCL_exeBregLoadUse_i = (lwbLpEqexeBpAddrQ & (~ltchDA_i | dofDregFull)) |
                             wbLpEqexeBpAddrQ;

assign PCL_exeSregLoadUse_i = (lwbLpEqexeSpAddrQ & (~ltchDA_i | dofDregFull)) |
                             wbLpEqexeSpAddrQ;

assign aRegLoadUseHold = ((~ltchDA_i | dofDregFull) &
                         (lwbLpEqexeSpAddrQ | lwbLpEqexeBpAddrQ)) |
                          wbLpEqexeSpAddrQ | wbLpEqexeBpAddrQ | exeRpEqwbOrlwbLpAddr |
                          apuLoadUseHold;

assign bRegLoadUseHold = ((~ltchDA_i | dofDregFull) &
                         (lwbLpEqexeSpAddrQ | lwbLpEqexeApAddrQ)) |
                          wbLpEqexeSpAddrQ | wbLpEqexeApAddrQ | exeRpEqwbOrlwbLpAddr |
                          apuLoadUseHold;

assign sRegLoadUseHold = ((~ltchDA_i | dofDregFull) &
                         (lwbLpEqexeApAddrQ | lwbLpEqexeBpAddrQ)) |
                          wbLpEqexeApAddrQ | wbLpEqexeBpAddrQ | exeRpEqwbOrlwbLpAddr |
                          apuLoadUseHold;

// sprLoadUseHold = aRegLoadUseHold OR bRegLoadUseHold OR exeRport wants to overwrite
// Lport data.
assign sprLoadUseHold = ((~ltchDA_i | dofDregFull) &
                        (lwbLpEqexeApAddrQ | lwbLpEqexeBpAddrQ)) |
                         wbLpEqexeApAddrQ | wbLpEqexeBpAddrQ | exeRpEqwbOrlwbLpAddr;

// exeLoadUseHold = aRegLoadUseHold OR bRegLoadUseHold OR sRegLoadUseHold OR
// exeRport wants to overwrite Lport data.
assign exeLoadUseHold = ((~ltchDA_i | dofDregFull) &
                        (lwbLpEqexeApAddrQ | lwbLpEqexeBpAddrQ | lwbLpEqexeSpAddrQ)) |
                         wbLpEqexeApAddrQ | wbLpEqexeBpAddrQ | wbLpEqexeSpAddrQ |
                         exeRpEqwbOrlwbLpAddr | apuLoadUseHold;

assign apuLoadUseHold = (exeApuExeWbLdUseL2 & (wbApuFpuLoad | lwbApuFpu)) |
                        (exeApuExeLwbLdUseL2 & lwbApuFpu);

assign PCL_exeLoadUseHold = exeLoadUseHold;

assign PCL_gateZeroToAreg = (plaRaEq0Ck & ~|dcdRAL2[0:4]);

// Force zero into Sreg for DCBZ or DCBA.
// issue 200 fix
//assign PCL_gateZeroToSreg = ~NplaSregEn & (plaDcuOp[4] | plaDcuOp[5]) & strgEnd;
assign PCL_gateZeroToSreg = ~NplaSregEn & (plaDcuOp[4] | plaDcuOp[5]) & strgEnd & IFB_dcdFull;

assign PCL_aPortRregBypass_i = exeRpWrEnQ_i & ~NplaApRdEn & exeRpEqdcdApAddrQ;

assign PCL_bPortRregBypass_i = exeRpWrEnQ_i & ~NplaBpRdEn & exeRpEqdcdBpAddr;

assign PCL_sPortRregBypass_i = (exeRpWrEnQ_i & plaSpRdEn & exeRpEqdcdSpAddr) |
                             (exeRpEqexe2RpAddr & sprLoadUseHold);

assign PCL_abRegE1 = ~(~IFB_dcdFull & exeFullForE1_NEG);

// exeMacEn is for exeLoadUse case.
assign PCL_sRegE1 = (IFB_dcdFull | exeDivEn | exeMacEn | exeSt);

// exeSrmUnitEn is for exeLoadUse case.
// exeSrmUnitEn is a negative active signal.
assign PCL_srmRegE1 = (IFB_dcdFull | ~exeSrmUnitEn);



assign PCL_aRegForEaE2 =  (~(~DCU_CA | ~ICU_dsCA | APU_exeNonBlkingMco | APU_exeBlkingMco |
                             MMU_BMCO | dcrMco | trapMco | IFB_trcPipeHold | EXE_admMco |
                           aRegLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd) &
			   (plaEaCalc | ~plaVal | exeEaCalc)) |
                           (PCL_exeAregLoadUse_i & exeEaCalc);

assign PCL_bRegForEaE2 = (~(~DCU_CA | ~ICU_dsCA | APU_exeNonBlkingMco | APU_exeBlkingMco |
                            MMU_BMCO | dcrMco | trapMco | IFB_trcPipeHold | EXE_admMco |
                            bRegLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd) 
                            & (plaEaCalc | ~plaVal | exeEaCalc)) |
                          (PCL_exeBregLoadUse_i & exeEaCalc);


assign PCL_aRegE2 =  ~(~DCU_CA | ~ICU_dsCA | APU_exeNonBlkingMco | APU_exeBlkingMco |
                       MMU_BMCO | dcrMco | trapMco | IFB_trcPipeHold | EXE_multMco |
                       aRegLoadUseHold | exeDvcOrParityHold | (wbHoldForExeOprd & ~EXE_divMco)) |
                       PCL_exeAregLoadUse_i;

assign PCL_bRegE2 = ~(~DCU_CA | ~ICU_dsCA | APU_exeNonBlkingMco | APU_exeBlkingMco |
                      MMU_BMCO | dcrMco | trapMco | IFB_trcPipeHold | EXE_admMco |
                      bRegLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd) |
		      PCL_exeBregLoadUse_i;

// Sreg is used by Stores, Mac, Divide, DCBZ, DCBA instruction.

assign PCL_sRegE2 = (~(~DCU_CA | ~ICU_dsCA | APU_exeNonBlkingMco | APU_exeBlkingMco |
                       EXE_multMco | exeDvcOrParityHold  | wbHoldForExeOprd | sRegLoadUseHold) &
		       (~NplaSregEn | exeSt)) | PCL_exeSregLoadUse_i | EXE_divMco | 
		       (exeRpEqexe2RpAddr & sprLoadUseHold);

assign PCL_srmRegE2[0] = (~(EXE_admMco | APU_exeNonBlkingMco | APU_exeBlkingMco |
                           storageMco | exeDvcOrParityHold | exeLoadUseHold | wbHoldForExeOprd) &
			   plaSrmEn) | (PCL_exeBregLoadUse_i & PCL_exeSrmBpSel[0]);


assign PCL_srmRegE2[1] = (~(EXE_admMco | APU_exeNonBlkingMco | APU_exeBlkingMco |
                           storageMco | exeDvcOrParityHold | exeLoadUseHold | wbHoldForExeOprd) &
                          plaSrmEn) | (PCL_exeBregLoadUse_i & PCL_exeSrmBpSel[1]);

assign PCL_srmRegE2[2] = (~(EXE_admMco | APU_exeNonBlkingMco | APU_exeBlkingMco |
                           storageMco | exeDvcOrParityHold | exeLoadUseHold | wbHoldForExeOprd) &
                          plaSrmEn) | (PCL_exeBregLoadUse_i & PCL_exeSrmBpSel[2]);


// Instr  Loading Stage   Used Stage    Holding Cond
// ----   -------------   ----------    ------------
// MAC    EXE1            EXE2          wbHold & exe2Full
// MULT   EXE1            EXE2          wbHold & exe2Full
// DIV    EXE1            EXE1          divEn & divLastSt & wbHold
// Other  DCD             EXE1          ~divMco & ~exeMultEn & ~exeMacEn & PCL_holdCIn

assign PCL_holdCIn = exeLoadUseHold | exeDvcOrParityHold | trapMco | (wbHold & exeFull);

assign PCL_dcdMdSelQ = plaMdSel & ~exeLoadUseHold & ~exeDvcOrParityHold & ~wbHoldForExeOprd;

assign PCL_dcdMrSelQ = plaMrSel & ~exeLoadUseHold & ~exeDvcOrParityHold & ~wbHoldForExeOprd;

assign PCL_holdMdMr = exeLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd;


//*********************
// Execute Stage Logic *
//*********************
assign PCL_sraRegE1 = (~exeFullForE1_NEG & exeStrgStC0 & exeWUD & (exeLd | exeSt));

assign PCL_sraRegE2 = ~(gtErr_i | VCT_wbSuppress | wbHold);

assign PCL_xerL2Hold = ((EXE_admMco | APU_exeNonBlkingMco | APU_exeBlkingMco |
                         sprLoadUseHold | VCT_exeSuppress) & ~exe2Full) |
                         exeDvcOrParityHold |  IFB_exeFlush | VCT_wbSuppress | wbHold;

// Not used in XER or CR. sprHold is used in LR and CTR. Les OR's in tracePipeHold.
assign sprHold = VCT_errorSprSuppress | IFB_exeFlush | wbHold | sprLoadUseHold |
                 exeDvcOrParityHold;

assign PCL_exeAbort_i =  nopStringIndexed | exeStrgLS  | (exeStwcx & (~PCL_Rbit_i | exeStrgC1 | rstRbit)) |
                       exeLoadUseHold   | exeDvcOrParityHold | DBG_exeIacSuppress | wbHold;

assign PCL_mmuExeAbort = nopStringIndexed | exeStrgLS | (exeStwcx & (~PCL_Rbit_i | exeStrgC1 | rstRbit)) |
                         exeLoadUseHold | exeDvcOrParityHold  | PCL_wbAlgnErr | DBG_wbDacSuppress;

// PCL_sdqMuxSel
// 0 -  sBus<0:31>
// 1 -  APU_exeResult<0:31>
assign PCL_sdqMuxSel = exeApuFpuOp & exeSt;

//*************************
// Write Back Stage Logic *
//*************************
// PCL_resultMuxSel
// 0 -  rReg<0:31>
// 1 -  sraReg<0:31>
//assign PCL_resultMuxSel = exeStrgE0;

assign PCL_resultRegE1 = exeRpWrEnQ_i;

// Do not block the rReg E2 for MCO which can occur due to mult in exe1 if exe2 is full.
// Fix for issue 348.

assign PCL_resultRegE2 = ~(((EXE_admMco | APU_exeNonBlkingMco | APU_exeBlkingMco |
                             exeLoadUseHold) & ~exe2Full) |
                           exeDvcOrParityHold | MMU_BMCO | dcrMco | trapMco | wbHold);


//**********************
// Load Steering Logic *
//**********************
// dofDreg has no E2. Data in dofDreg only needs to be valid for one cycle.
assign PCL_dofDRegE1 = ((wbLoad | lwbFullL2_i | wbStDvcL2) &
                        (potDvc | OCM_DOF | DCU_DOF | ICU_LDBE)) | wbApuFpuLoad | lwbApuFpu;

// dReg has no E2. Data in dReg only needs to be valid for one cycle.
//Fix for issue 193.
assign PCL_dRegE1 = (~dofDregFull) & (wbLoad | (lwbFullL2_i & ~ltchDA_i));

// ldAdjE2 comes from wbStage.
assign PCL_ldAdjE1 = wbLoad | (lwbFullL2_i & ~ltchDA_i) | dofDregFull;

// loadSteerMuxSel
// 0 - wb Load Steering Cntl
// 1 - lwb Load Steering Cntl
assign loadSteerMuxSel = dofDregFull | (lwbFullL2_i & ~ltchDA_i);

// PCL_dRegBypassMuxSel
// 0 -  dReg<0:31>
// 1 -  dRegBypass<0:31>
assign PCL_dRegBypassMuxSel = dofDregFull;

// dofDregMuxSel[0:1]
// 00 -  DCU_data
// 01 -  OCM_data
// 10 -  Unused
// 11 -  DCU_sdqMod
assign PCL_dofDRegMuxSel[0] = (potDvc & DCU_firstCycCarStXltV) | LSSD_coreTestEn;
assign PCL_dofDRegMuxSel[1] = (OCM_dsComplete & DCU_pclOcmLdPendNoWait) |
                              (potDvc & DCU_firstCycCarStXltV);

// ldAdjMuxSel[0:1]
// 00 -  FEEDBACK
// 01 -  OCM
// 10 -  DCU
// 11 -  dofDreg
assign PCL_ldAdjMuxSel[0] = dofDregFull | (DCU_DA & ~DCU_DOF);
assign PCL_ldAdjMuxSel[1] = dofDregFull | (OCM_dsComplete & DCU_pclOcmLdPendNoWait & ~OCM_DOF);

// ldMuxSel[0:1]
// 00 -  DCU
// 01 -  OCM
// 10 -  dofDreg
// 11 -  AdjReg (except for byte0 which is gnd.)
// dofDregFull and steerOCM are mutually exclusive.

assign steerOCM = (OCM_dsComplete & DCU_pclOcmLdPendNoWait) & ~OCM_DOF & ~dofDregFull;
// Byte0
assign PCL_ldMuxSel[0] = dofDregFull | LSSD_coreTestEn;
assign PCL_ldMuxSel[1] = steerOCM;
// Byte1
assign PCL_ldMuxSel[2] = ldAdjSel[1] | dofDregFull;
assign PCL_ldMuxSel[3] = ldAdjSel[1] | steerOCM;
// Byte2
assign PCL_ldMuxSel[4] = ldAdjSel[2] | dofDregFull;
assign PCL_ldMuxSel[5] = ldAdjSel[2] | steerOCM;
// Byte3
assign PCL_ldMuxSel[6] = ldAdjSel[3] | dofDregFull;
assign PCL_ldMuxSel[7] = ldAdjSel[3] | steerOCM;


//****************
// DOF DREG FULL *
//****************
//Only set when Disable Operand Forwarding(DOF) is used and data is valid in dofDreg.
//Note dofDreg can be full in case of error. MuxSel is DCU_DA.
assign dofDregFullIn0 = (((dofDregFull | OCM_DOF) & OCM_dsComplete & DCU_pclOcmLdPendNoWait) |
                         (dofDregFull & wbStrgLS)) & ~resetL2_i ;
assign dofDregFullIn1 = (dofDregFull | DCU_DOF);

//********************************
// APU FPU Load Data Valid Logic *
//********************************
assign PCL_wbComplete = ~(wbHold | VCT_wbSuppress | VCT_wbFlush);

assign apuLoadDVIn1 = (~VCT_wbSuppress & ~VCT_wbFlush & wbApuFpuLoad & (~lwbFullL2_i | ltchDA_i)) |
                      (lwbApuFpu & ~ltchDA_i);
assign apuLoadDVIn0 = apuLoadDVIn1 & OCM_dsComplete & DCU_pclOcmLdPendNoWait;

assign ltchDAIn1 = (~VCT_wbLoadSuppress & ~VCT_wbFlush & wbLoad) | (lwbFullL2_i & ~ltchDA_i);
assign ltchDAIn0 = (ltchDAIn1 & OCM_dsComplete & DCU_pclOcmLdPendNoWait) |
                   (wbStrgLS & (~lwbFullL2_i | ltchDA_i) & ~VCT_wbLoadSuppress & ~VCT_wbFlush);

assign trcLoadDVIn1 = ltchDAIn1 & ICU_LDBE;
assign trcLoadDVIn0 = ltchDAIn1 & ICU_LDBE & OCM_dsComplete & DCU_pclOcmLdPendNoWait;

assign apuTrcLoadEnIn0 = (apuLoadDVIn0 | trcLoadDVIn0);
assign apuTrcLoadEnIn1 = (apuLoadDVIn1 | trcLoadDVIn1);
//************************************************************************
// dcuDASel Free running Latch
//************************************************************************
//Removed the module dp_regPCL_dcuDASel  
always @(posedge CB)
  begin: dp_regPCL_dcuDASel_PROC
    if (DCU_DA)
      {dofDregFullL2_NEG_i,apuLoadDVL2_NEG_i,ltchDAL2_NEG_i,ltchDAForApuL2_NEG_i,
       trcLoadDVL2_NEG_i,apuTrcLoadEnL2_NEG_i} <= {dofDregFullIn1, apuLoadDVIn1, ltchDAIn1, ltchDAIn1,
                                                trcLoadDVIn1, apuTrcLoadEnIn1};
    else
      {dofDregFullL2_NEG_i,apuLoadDVL2_NEG_i,ltchDAL2_NEG_i,ltchDAForApuL2_NEG_i,
       trcLoadDVL2_NEG_i,apuTrcLoadEnL2_NEG_i} <= {dofDregFullIn0, apuLoadDVIn0, ltchDAIn0, ltchDAIn0,
                                                trcLoadDVIn0, apuTrcLoadEnIn0};
  end // dp_regPCL_dcuDASel_PROC

assign {dofDregFullL2_NEG,apuLoadDVL2_NEG,ltchDAL2_NEG,ltchDAForApuL2_NEG,
       trcLoadDVL2_NEG,apuTrcLoadEnL2_NEG} = 
       ~{dofDregFullL2_NEG_i,apuLoadDVL2_NEG_i,ltchDAL2_NEG_i,ltchDAForApuL2_NEG_i,
       trcLoadDVL2_NEG_i,apuTrcLoadEnL2_NEG_i};
       
//Removed the module dp_logPCL_dcuDASelInv   
assign {dofDregFull, PCL_apuLwbLoadDV, ltchDA_i, ltchDAForApu,
        PCL_trcLoadDV, PCL_apuTrcLoadEn} = 
       ~{dofDregFullL2_NEG,apuLoadDVL2_NEG,ltchDAL2_NEG,ltchDAForApuL2_NEG,
        trcLoadDVL2_NEG, apuTrcLoadEnL2_NEG};
//************************************************************************
// Dcd Cntl Logic
//************************************************************************
assign NdcdApRdEn = NplaApRdEn | (plaRaEq0Ck & ~|dcdRAL2[0:4]);

// XER TBC updated by mtxer or dlmzb instr. If xerTBC needed, use its inputs when mtxer
// Or dlmzb is in EXE.
assign dcdXerDcd = (dcdSPRN == {2'b00,8'h01}) ? 1'b1 : 1'b0;
assign dcdXerTBCUpdInstr = ((plaLogicalCntl[6] & plaLogicalCntl[7] & plaLogicalUnitEn) |
                            (dcdXerDcd & plaMtspr));

// MMU Spr Address decodes.
assign dcdMmuSprDcd[0] = (dcdSPRN[0:9] == 10'h3fa);                      // seldccr
assign dcdMmuSprDcd[1] = (dcdSPRN[0:9] == 10'h3fb);                      // seliccr
assign dcdMmuSprDcd[2] = (dcdSPRN[0:9] == 10'h3b0);                      // selzone
assign dcdMmuSprDcd[3] = (dcdSPRN[0:9] == 10'h3b1);                      // selpid
assign dcdMmuSprDcd[4] = (dcdSPRN[0:9] == 10'h3b9);                      // selsgr
assign dcdMmuSprDcd[5] = (dcdSPRN[0:9] == 10'h3ba);                      // seldcwr
assign dcdMmuSprDcd[6] = (dcdSPRN[0:9] == 10'h3bb);                      // selsler
assign dcdMmuSprDcd[7] = (dcdSPRN[0:9] == 10'h3bc);                      // selskr
assign dcdMmuSprDcd[8] = (dcdSPRN[0:9] == 10'h3d5);                      // seldear

// ICU Spr Address decodes.
assign dcdIcuSprDcd[0] = (dcdSPRN[0:9] == {2'b11,8'hb3}) ? 1'b1 : 1'b0;  //selccr0
assign dcdIcuSprDcd[1] = (dcdSPRN[0:9] == {2'b11,8'hd3}) ? 1'b1 : 1'b0;  //selcdbdr
assign dcdIcuSprDcd[2] = (dcdSPRN[0:9] == {2'b11,8'h78}) ? 1'b1 : 1'b0;  //selccr1

// TIM Spr Address decodes.
// don't care on bit 5 of the SPRN for time base high/low (user/priv)
assign dcdTimSprDcd[0] = (dcdSPRN[0:9] == {2'b11,8'hda}) ? 1'b1 : 1'b0;  //seltcr
assign dcdTimSprDcd[1] = (dcdSPRN[0:9] == {2'b11,8'hd8}) ? 1'b1 : 1'b0;  //seltimerRstStat
assign dcdTimSprDcd[2] = (dcdSPRN[0:9] == {2'b11,8'hd9}) ? 1'b1 : 1'b0;  //seltimerSetStat
assign dcdTimSprDcd[3] = (dcdSPRN[0:9] == {2'b11,8'hdb}) ? 1'b1 : 1'b0;  //selpit
assign dcdTimSprDcd[4] = ({dcdSPRN[0:4],(dcdSPRN[5] | plaMfspr),dcdSPRN[6:9]} == {2'b01,8'h1c}) ? 1'b1 : 1'b0;  //seltblo
assign dcdTimSprDcd[5] = ({dcdSPRN[0:4],(dcdSPRN[5] | plaMfspr),dcdSPRN[6:9]} == {2'b01,8'h1d}) ? 1'b1 : 1'b0;  //seltbhi

// DBG Spr Address decodes.
assign dcdDbgSprDcd[0] = (dcdSPRN[0:9] == {2'b11,8'hf2}) ? 1'b1 : 1'b0;  //dbcr0Dcd
assign dcdDbgSprDcd[1] = (dcdSPRN[0:9] == {2'b11,8'hbd}) ? 1'b1 : 1'b0;  //dbcr1Dcd
assign dcdDbgSprDcd[2] = (dcdSPRN[0:9] == {2'b11,8'hf0}) ? 1'b1 : 1'b0;  //dbsrDcd
assign dcdDbgSprDcd[3] = (dcdSPRN[0:9] == {2'b11,8'hf1}) ? 1'b1 : 1'b0;  //dbsrSetDcd

// EXE Spr Address decodes.
assign dcdExeSprDcd[0] = (dcdSPRN[0:9] == {2'b11,8'hf6}) ? 1'b1 : 1'b0;  //dac1Dcd
assign dcdExeSprDcd[1] = (dcdSPRN[0:9] == {2'b11,8'hf7}) ? 1'b1 : 1'b0;  //dac2Dcd
assign dcdExeSprDcd[2] = (dcdSPRN[0:9] == {2'b11,8'hb6}) ? 1'b1 : 1'b0;  //dvc1Dcd
assign dcdExeSprDcd[3] = (dcdSPRN[0:9] == {2'b11,8'hb7}) ? 1'b1 : 1'b0;  //dvc2Dcd
assign dcdExeSprDcd[4] = (dcdSPRN[0:9] == {2'b00,8'h01}) ? 1'b1 : 1'b0;  //xerDcd

// VCT Spr Address decodes.
assign dcdVctSprDcd[0] = (PCL_dcdLitCntl[2:4] == 3'b101) ? 1'b1 : 1'b0;  //msrDcd
assign dcdVctSprDcd[1] = (dcdSPRN[0:9] == {2'b00,8'h1b}) ? 1'b1 : 1'b0;  //srr1Dcd
assign dcdVctSprDcd[2] = (dcdSPRN[0:9] == {2'b11,8'hdf}) ? 1'b1 : 1'b0;  //srr3Dcd
assign dcdVctSprDcd[3] = (dcdSPRN[0:9] == {2'b11,8'hd4}) ? 1'b1 : 1'b0;  //esrDcd
assign dcdVctSprDcd[4] = (dcdSPRN[0:9] == {2'b01,8'h1f}) ? 1'b1 : 1'b0;  //pvrDcd

// VCT Address decodes for MCSR and MCSRS
assign dcdVctSprDcd[5] = (dcdSPRN[0:9] == {2'b10,8'h3c}) ? 1'b1 : 1'b0;  //mcsrDcd
//assign dcdVctSprDcd[6] = (dcdSPRN[0:9] == {2'b11,8'h3c}) ? 1'b1 : 1'b0;  //mcsrsDcd

// dont need this to go to vct...goes to icu instead...see the change in ICU 
// address decode equations...
// VCT Address decode for CCR1
//assign dcdVctSprDcd[7] = (dcdSPRN[0:9] == {2'b11,8'h78}) ? 1'b1 : 1'b0;  //ccr1Dcd

// JTG Spr Address decodes.
assign dcdJtgSprDcd = (dcdSPRN[0:9] == {2'b11,8'hf3}) ? 1'b1 : 1'b0;     //dbdrDcd


//************************************************************************
// File Addr Gen Cntl Logic
//************************************************************************
// blkExeSpAddr is generated in storageCntlPla to prevent the exeSpAddr from changing when
// the Sport is not re-read. This will prevent a false exeLoadUseHold.

assign exeSpAddrE2 = (~(~DCU_CA | exeLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd) &
                       ((IFB_dcdFull & strgEnd & plaSpRdEn) |
                        ((exeMult | exeString) & ~blkExeSpAddr)));

// Same as countE1 as using countE1 instead coming from exeStage functional.

assign storeRSE2 = (~(~DCU_CA | exeLoadUseHold | exeDvcOrParityHold | (exeFull & wbHold)) &
                     ((IFB_dcdFull & strgEnd & plaSpRdEn) | sPortSelInc));

assign exeLpAddrE2 = (~(~DCU_CA | exeLoadUseHold | exeDvcOrParityHold | (exeFull & wbHold)) &
                       ((plaLpWrEn & strgEnd & IFB_dcdFull) | (exeLpWrEnQ & ~strgEnd)));

// exeLpMuxSel
// 0 -  dcdRSRT<0:4>
// 1 -  exeLpAddrInc<0:4>
assign exeLpMuxSel = exeLd & ~strgEnd & (exeString | exeMult);

// E1 for this latch = exeE1
// Gate the reg if either exe1 or exe2 is full and holding.
assign exeRpAddrE2 = ~(PCL_exeIarHold_i | (exe2Full & wbHold));

// E1 for this latch = IFB_dcdFull

assign exeMacOrMultRpAddrE2 = (plaMacEn | plaMultEn) &
                             ~(EXE_admMco | exeLoadUseHold | exeDvcOrParityHold |
                              (exeFull & exe2Full & wbHold));

// exeRpAddrMuxSel
// 0 -  dcdRpAddr<0:4>
// 1 -  exeMacOrMultRpAddrInc<0:4>
assign exeRpAddrMuxSel = exeFull & (exeMacEn | exeMultEn);

assign wbRpAddrE2 = (exeRpWrEnQ_i & ~wbHold & ~VCT_wbSuppress) | gtErr_i;

// wbRpAddrMuxSel = gtErr_i
// 0 -  exeRpAddr<0:4>
// 1 -  wbRA<0:4>

// wbLpAddr has no E2.
assign wbLpAddrE1 = ~exeFullForE1_NEG & ~wbHold;
//************************************************************************
// Storage Cntl Logic
//************************************************************************

assign exeStrgC1 = exeStrgSt[2];
assign exeStrgLS = exeStrgSt[1];
assign exeStrgE0 = exeStrgSt[0];
assign exeStrgC0orC1 = ~|exeStrgSt[0:1];
assign exeStwcxC0 = exeStwcx & exeStrgStC0;
assign exeStwcxC1 = exeStwcx & exeStrgC1;

// Issue 184 Fix SBP 4/4/00
assign gtErr_i =  (VCT_wbFlush & wbLdOrStWUD) |

//hotfix jd meu 4/12/00 addtional fix for issue 184
//hotfix jd     (VCT_wbFlushAsync & exeStrgC1 & exeWUD & (exeLd | exeSt));

                (VCT_wbFlushAsync & exeStrgC1 & exeWUD &
                ~ VCT_sxrOR_L2 &
                ~ DBG_exeIacSuppress &
                (exeLd | exeSt));


//countE1 = (IFB_dcdFull | exeEaCalc);
// Generated in exeStage functional.
assign countE2 = (~(~DCU_CA | ~ICU_dsCA | exeLoadUseHold | exeDvcOrParityHold | MMU_BMCO | (exeFull & wbHold)) &
                   (((plaEaCalc | ~plaVal) & IFB_dcdFull) | exeEaCalc));

assign storageStMachE1 = exeEaCalc | wbLdOrStWUD | exeStrgE0 | resetL2_i;

assign storageStMachE2 = ~(~DCU_CA | ~ICU_dsCA |  exeLoadUseHold | exeDvcOrParityHold |
                           (exeFull & wbHold)) |
                         exeStrgE0 | gtErr_i | IFB_exeFlush;

assign dcdStringImmediate = ((plaLd |plaSt) & plaString & IFB_dcdFull & ~plaIndexed);

assign dcdStringIndexed = ((plaLd |plaSt) & plaString & IFB_dcdFull & plaIndexed);

assign dcdMultiple = ((plaLd |plaSt) & plaMult & IFB_dcdFull);

//************************************************************************
// Pipe Movement Cntl Logic
//************************************************************************
//*****************
// MCO Generation *
//*****************
assign storageMco = exeEaCalc & ~strgEnd;

//********************
// Trap MCO Logic    *
//********************
// Used for trap Condition Met.

assign nxtExeTrap = trapMco & EXE_trap & ~IFB_exeFlush & ~VCT_exeSuppress &
                    ~VCT_wbSuppress & ~(exeLoadUseHold | wbHold | exeDvcOrParityHold);

assign setTrapMco = plaTrap & IFB_dcdFull & ~PCL_exeIarHold_i & ~dcdBubble & ~IFB_dcdBubble &
                    ~IFB_exeCorrect & ~IFB_exeFlush;
assign rstTrapMco = (trapMco & ~(exeLoadUseHold | wbHold | exeDvcOrParityHold)) |
                    IFB_exeFlush | VCT_exeSuppress | VCT_wbSuppress;
		    
// Used for trap MCO.
assign nxtTrapMco = (trapMco & ~rstTrapMco) | setTrapMco;

//********************
// Block Flush Logic *
//********************
// At times a flush due to an async interrupt must
// be held off. This situation occurs when:
// 1) A blocking MCO cycle is currently in progress. The first
//    cycle of a blocking MCO is interruptable.
// 2) A load or store with potential DVC that is past exe. Once past
//    exe the exeDvcHold has been set. The flush is held off unitl
//    the load or store is completed.
// 3) CPU_exeMtdcr or CPU_exeMfdcr is asserted.   Since the dcr bus
//    does not have a hold signal (like CPU_exeSprHold) it cannot be interrupted
//    once the operation is begun.
// 4) A load is past exe and the processor is in precise parity mode. 
//    Hold off the flush until the load completes.
//


assign exeHoldForBlkFlush = ~DCU_CA | exeLoadUseHold | exeDvcOrParityHold | wbHoldForExeOprd;


assign setBlkFlush = (APU_exeBlkingMco                  | 
                      MMU_BMCO                          |
                      ((exeMtdcr | exeMfdcr) & ~dcrAck) |
		      ((((exeLd | exeSt) & ~nopStringIndexed & ~(exeStwcxC0 & ~PCL_Rbit_i) & ~exeStwcxC1) | exeDcbz | exeDcba) & potDvc) |
		      (exeLd & ICU_CCR0DPP)) & 
                      ~exeHoldForBlkFlush & ~(IFB_exeFlush | VCT_exeSuppress | VCT_wbSuppress);

assign rstBlkFlush =   ((mtDCRL2 | PCL_mfDCRL2_i) & dcrAck) |
                       (potDvc & ((lwbFullL2_i & ltchDA_i) | dofStValidL2 | VCT_wbSuppress | VCT_wbFlush)) |
                       (ICU_CCR0DPP & ((lwbFullL2_i & ltchDA_i)  | VCT_wbSuppress | VCT_wbFlush)) |
		       (exeMmuOp & ~MMU_BMCO)  |
                       (apuBMcoDlydL2 & ~APU_exeBlkingMco);

assign nxtBlkFlush = (PCL_blkFlush_i & ~rstBlkFlush) | setBlkFlush;

//*****************
// DCD Cntl Logic *
//*****************
//Does not contain IFB_dcdBubble(exeRfi,exeRfci,exeSC).
//1. dIcmp bubble, allow only one instr thru a pipe to avoid additional exeSuppress.
//2. MacOrMult followed by NonMacOrMult bubble, to avoid CR, XER update, rport contention.
//3. exe2Full & wbHold followed by NonMacOrMult, to avoid CR,XER update,rport contention.
//4. macDepend bubble, exeMacOrMultRT=dcdRA | dcdRB.
//5. Apu bubble, APU autonomous MCO's(AMCO's).
//6. AtomicOp Bubble, lwarx in exe or wb and stwcx in dcd
assign dcdBubble = ((DBG_icmpEn | IFB_stepStL2) & (exeFull | exe2Full | wbFull)) |
                   ((exeMacEn | exeMultEn | (exe2Full & wbHold)) &
                               ~((plaMacEn | plaMultEn) & IFB_dcdFull)) |
                   exeMorMRpEqdcdApAddr | exeMorMRpEqdcdBpAddr |
                   (APU_exeBusy & IFB_dcdFull & (~plaVal | plaApuDiv)) |
                   (plaStwcx & (exeLwarx | wbLwarx));

// dcdBubble without APU_exeBusy term. OR'ed with IFB_dcdBubble.
assign dcdBubbleForApu = ((DBG_icmpEn | IFB_stepStL2) & (exeFull | exe2Full | wbFull)) |
                         ((exeMacEn | exeMultEn | (exe2Full & wbHold)) &
                               ~((plaMacEn | plaMultEn) & IFB_dcdFull)) |
                          exeMorMRpEqdcdApAddr | exeMorMRpEqdcdBpAddr | IFB_dcdBubble;

// Does not contain IFB_dcdBubble or IFB_trcPipeHold.
// IFB will OR in IFB_dcdBubble and IFB_trcPipeHold to PCL_dcdHoldForIfb.

assign PCL_dcdHoldForIfb[0] = (~ICU_dsCA | ~DCU_CA | EXE_admMco | storageMco | MMU_BMCO |
                             APU_exeNonBlkingMco | APU_exeBlkingMco | exeLoadUseHold |
                             exeDvcOrParityHold | trapMco | dcrMco | wbHoldForExeOprd |
                             dcdBubble);

assign PCL_dcdHoldForIfb[1] = (~ICU_dsCA | ~DCU_CA | EXE_admMco | storageMco | MMU_BMCO |
                              exeDvcOrParityHold | trapMco | dcrMco | wbHoldForExeOprd |
                             APU_exeNonBlkingMco | APU_exeBlkingMco | exeLoadUseHold |
                             dcdBubble);

assign PCL_dcdHoldForIfb[2] = (APU_exeNonBlkingMco | APU_exeBlkingMco | exeLoadUseHold |
                               ~ICU_dsCA | ~DCU_CA | EXE_admMco | storageMco | MMU_BMCO |
                                exeDvcOrParityHold | trapMco | dcrMco | wbHoldForExeOprd |
			       dcdBubble);

// Complete dcdHold, includes IFB_dcdBubble, for use in pipeCntl.

assign dcdHold = ~ICU_dsCA | ~DCU_CA | EXE_admMco | storageMco | MMU_BMCO | dcrMco |
                  APU_exeNonBlkingMco | APU_exeBlkingMco | exeLoadUseHold |
                  exeDvcOrParityHold | trapMco | IFB_trcPipeHold | wbHoldForExeOprd |
                  dcdBubble | IFB_dcdBubble;


assign PCL_apuDcdHold = ~ICU_dsCA | ~DCU_CA | EXE_admMco | storageMco | MMU_BMCO |
                         trapMco | IFB_trcPipeHold | dcrMco | wbHoldForExeOprd |
                         dcdBubbleForApu;

//******************
// EXE1 Cntl Logic *
//******************

//assign exeHoldForApu_NEG = ~(~DCU_CA | exeLoadUseHold | exeDvcHold);
assign exeHoldForApu_NEG = ~(~DCU_CA | exeLoadUseHold | exeDvcOrParityHold);


assign exeFlushForApu_NEG = ~(IFB_exeFlush | VCT_exeSuppForApu | VCT_wbSuppress | IFB_exeCorrect);

//Removed the module dp_logPCL_exeApuHoldFlushInv 
assign {PCL_apuExeHold, PCL_apuExeFlush} = ~{exeHoldForApu_NEG, exeFlushForApu_NEG};

assign PCL_exeIarHold_i = ~ICU_dsCA | ~DCU_CA | VCT_exeSuppress | EXE_admMco | exeDvcOrParityHold |
                         APU_exeNonBlkingMco | trapMco | IFB_trcPipeHold |
                         APU_exeBlkingMco | MMU_BMCO | dcrMco | storageMco |
                         exeLoadUseHold | wbHoldForExeOprd;
			  
assign exeHoldForStDvc = ~DCU_CA | exeLoadUseHold | exeDvcOrParityHold | wbHold |
                          VCT_exeSuppress | VCT_wbSuppress;

assign exeHoldForWb = ~ICU_dsCA | ~DCU_CA | exeDvcOrParityHold | trapMco | IFB_trcPipeHold |
                       MMU_BMCO | dcrMco | ((exeLoadUseHold | EXE_admMco | VCT_exeSuppress |
	               APU_exeNonBlkingMco | APU_exeBlkingMco) & ~exe2Full);	
		              
assign PCL_exeHoldForCr = ~DCU_CA | exeDvcOrParityHold | EXE_divMco | MMU_BMCO | 
                          (exeStwcx & exeStrgStC0) | wbHold | VCT_wbSuppress | 
			  ((EXE_multMco | exeLoadUseHold | APU_exeBlkingMco | APU_exeNonBlkingMco | 
			   VCT_exeSuppForCr) & ~exe2Full);

//Used to create EXE2 Clear.
assign exe1HoldForExe2 = EXE_admMco | exeLoadUseHold | exeDvcOrParityHold;

assign exeE1 = IFB_dcdFull | ~exeFullForE1_NEG | resetL2_i;

assign exeE2 = ~PCL_exeIarHold_i | IFB_exeFlush;

assign exeClearOrFlush = IFB_exeFlush | ~IFB_dcdFull | dcdHold | IFB_exeCorrect;

assign nxtExeFull = (~IFB_exeCorrect & ~IFB_exeFlush & IFB_dcdFull & ~dcdHold)
                   | (PCL_exeIarHold_i & ~IFB_exeFlush);

assign exeLpWrEnQ = strgLpWrEn & exeLd & ~exeApuFpuOp & ~nopStringIndexed;

// exeStrgStC0 was included to prevent unalgn Ld or St WUD's from writing RA a second time.
// All mac & mult write the rReg from exe2.
assign exeRpWrEnQ_i = (exeRpWrEn & exeStrgStC0 & ~(exeMacEn | exeMultEn)) |
                     exe2Full;

//******************
// EXE2 Cntl Logic *
//******************
assign PCL_exe2DataE1 = exeMacEn | exeMultEn | exe2Full | resetL2_i;

assign PCL_exe2DataE2 = (exe2Full & ~wbHold) | (~exe2Full & (exeMacEn | exeMultEn)) |
                        IFB_exeFlush | resetL2_i;

assign PCL_exe2ClearOrFlush = IFB_exeFlush | ~(exeMacEn | exeMultEn) |
                              exe1HoldForExe2 | VCT_exeSuppForExe2Clear | resetL2_i;

assign PCL_exe2IarE1 = (exeMacEn | exeMultEn);

assign PCL_exe2IarE2 = ~(exe2Full & wbHold);

// Used to cntl exe2 latches in ADM(EXE unit).
assign PCL_exe2Hold = exe2Full & wbHold;

//****************
// WB Cntl Logic *
//****************
// Block GPR Lport write if RA in range of regs for updating & any load,
// or if RB in range of regs for lswx, if not final storage op.
assign nxtWbLpWrEn = exeLpWrEnQ & ((~exeRTeqRA & ~exeRTeqRB) | (~exeRTeqRA & ~exeIndexed)
                                   | strgEnd);

assign wbHold  = MMU_wbHold | (lwbFullL2_i & ~ltchDA_i & wbLoad);
assign PCL_wbHold = wbHold;

assign PCL_apuWbHold  = MMU_wbHold | (lwbFullForApuL2 & ~ltchDAForApu & wbLoadForApu);

// This wbHold without MMU_wbHold for the MMU.
assign PCL_wbHoldNonErr = lwbFullL2_i & ~ltchDA_i & wbLoad;

assign wbE1 = ~exeFullForE1_NEG | ~exe2FullForE1_NEG | wbFull | resetL2_i;

assign wbE2 =  (~wbHold & ~VCT_wbSuppress) | VCT_wbFlush;

// PCL_wbClearOrFlush does not have VCT_wbFlush in it since exeFlush has all the wbFlush terms.
// Used in DBG and PCL unit.
assign PCL_wbClearOrFlush = ~(exeFull | exe2Full) | exeHoldForWb |
                             IFB_exeFlush | ((exeMacEn | exeMultEn) & ~exe2Full);

assign PCL_wbClearTerms = ~(exeFull | exe2Full) | exeHoldForWb |
                           ((exeMacEn | exeMultEn) & ~exe2Full);

// Want exe1 operands to load if exe1 empty or if exe1 moving to exe2 even when wbHold
// is asserted. Can't load exe1 when
// 1) both exe1 and exe2 full and wbHold is asserted.
// 2) exe1 has nonMacOrMult and wbHold is asserted.
assign wbHoldForExeOprd = ((exeFull & ~(exeMacEn | exeMultEn)) |
                           (exeFull & exe2Full)) & wbHold;

//*****************
// LWB Cntl Logic *
//*****************

//FULL
assign nxtLwbFull = (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & wbLoad) |
                    (lwbFullL2_i & ~ltchDA_i);

//ApuFpuLoad
assign nxtLwbApuFpu = (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & wbApuFpuLoad) |
                      (lwbApuFpu & ~ltchDA_i);

//strgLS
assign nxtLwbStrgLS = (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & wbStrgLS) |
                      (lwbStrgLSL2 & ~ltchDA_i);

//LpWrEn
assign nxtLwbLpWrEn = (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & wbLpWrEn) |
                      (lwbFullL2_i & ~ltchDA_i & lwbLpWrEnL2);

//LpWrite. Block the GPR write if LpAddr==RpAddr. Can occur only in LSSD test.
assign PCL_lwbLpWrEn = lwbLpWrEnL2 & ltchDA_i & ~(gprLpeqRp & PCL_wbRpWrEn);

//lwb has no E2. Loads loadSteering and lpAddr into lwb.
assign lwbE1 = ((~lwbFullL2_i & wbLoad) | (ltchDA_i & wbLoad) | resetL2_i);

//nxtLwbCacheable...really lwbCacheable...Added for Cobra
assign nxtLwbCacheable = (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & CAR_cacheable);

// Removed second half of this equation for Cobra (JBB...see defect 1841)
//                      (| lwbCacheableL2 & ~ltchDA_i);
		      
//************************************************************************
// Reservation Bit Cntl (Atomic Op's using lwarx and stwcx)
//************************************************************************
assign setRbit = wbLwarx & ~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush;

assign rstRbit = wbStwcx &  wbStrgC1;

assign nxtRbit = setRbit | (PCL_Rbit_i & ~rstRbit);

//************************************************************************
// Debug Data Value Compare Cntl
//************************************************************************
assign dvcWrEn =  DBG_dvcWrEn ^ LSSD_coreTestEn;
assign dvcRdEn =  DBG_dvcRdEn ^ LSSD_coreTestEn;

assign PCL_dvcCmpEn = (dvcWrEn & dofStValidL2) |
                      (dvcRdEn & lwbFullL2_i & ltchDA_i & ~lwbStrgLSL2);

assign potDvc = DBG_dvcRdEn | DBG_dvcWrEn;

assign exePotStDvc = potDvc & exeSt & ~nopStringIndexed &
                     ~(exeStwcxC0 & ~PCL_Rbit_i) & ~exeStwcxC1;

assign exeDvcHold = (potDvc & ((wbLoad | lwbFullL2_i) | wbStDvcL2)) & exeFull & ~exeStwcxC1;
assign PCL_exeDvcHold = exeDvcHold;

assign nxtDofStValid = potDvc & DCU_firstCycCarStXltV;

assign nxtWbStDvc = (exePotStDvc & ~exeHoldForStDvc & ~IFB_exeFlush) |
                    (wbStDvcL2 & ~VCT_wbFlush & ~dofStValidL2);

// dIcmp for DBSR.
assign PCL_wbDbgIcmp = wbFull & ~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush &
                       PCL_wbStrgEnd;

// dIcmp for CPU state machine.
assign PCL_dIcmpForStep = (wbFull & ~wbHold & ~VCT_wbFlush & PCL_wbStrgEnd) |
                          ((VCT_exeSuppress | VCT_wbSuppress | (|MMU_dsStatus[0:4]) |
                          IFB_exeRfciL2 | IFB_exeRfiL2 | IFB_exeScL2) & ~VCT_wbFlushAsync);

// dIcmp for CPU state machine.
assign PCL_dIcmpForStuff = (wbFull & ~wbHold & PCL_wbStrgEnd) |
                           VCT_exeSuppress | VCT_wbSuppress | (|MMU_dsStatus[0:4]);

// dIcmp for wbFlush.
assign nxtdIcmpForWbFlush = (((wbFull & ~wbHold & ~VCT_wbFlush & PCL_wbStrgEnd) |
                            ((VCT_exeSuppress | VCT_wbSuppress | (|MMU_dsStatus[0:4]))
                             & ~VCT_wbFlushAsync)) & IFB_stepStL2) |
                            (((wbFull & ~wbHold & PCL_wbStrgEnd) |
                             VCT_exeSuppress | VCT_wbSuppress | (|MMU_dsStatus[0:4])) &
                             IFB_stuffStL2);


// dvcByteEnMuxSel[0:1]
// 00 -  dvcByteEnL2[0:3] FeedBack
// 01 -  wbByteEnL2[0:3] wbStage
// 10 -  Unused
// 11 -  DCU_carByteEn[0:3]
assign dvcByteEnMuxSel[0] = DCU_firstCycCarStXltV;
assign dvcByteEnMuxSel[1] = DCU_firstCycCarStXltV |
                            (~wbHold & ~VCT_wbSuppress & ~VCT_wbFlush & wbLoad);

//************************************************************************
// dvcByteEn Free running Latch
//************************************************************************
//Removed the module dp_regPCL_dvcByteEn  
always @(posedge CB)
  begin: dp_regPCL_dvcByteEn_PROC
    case(dvcByteEnMuxSel)
      2'b00 : PCL_dvcByteEnL2_i <= PCL_dvcByteEnL2_i;
      2'b01 : PCL_dvcByteEnL2_i <= wbByteEn;
      2'b10 : PCL_dvcByteEnL2_i <= 4'b0;
      2'b11 : PCL_dvcByteEnL2_i <= DCU_carByteEn;
      default:  PCL_dvcByteEnL2_i <= 4'bxxxx;
    endcase
  end // dp_regPCL_dvcByteEn_PROC
  
//************************************************************************
// Free running Latch
//************************************************************************
//Removed the module dp_regPCL_pipeCntl  
always @(posedge CB)
  begin: dp_regPCL_pipeCntl_PROC
    if (resetL2_i)
      {lwbCacheableL2,
       lwbStrgLSL2,
       lwbLpWrEnL2,
       lwbFullL2_i,
       lwbFullForApuL2,
        PCL_blkFlush_i,
        PCL_blkFlushForVct_i,
	PCL_Rbit_i,
	trapMco,
        lwbApuFpu,
        dofStValidL2,
	wbStDvcL2,
        PCL_exeTrap,
        apuBMcoDlydL2,
	PCL_dIcmpForWbFlushQDlydL2} <= 17'b0;
    else
      {lwbCacheableL2,
       lwbStrgLSL2,
       lwbLpWrEnL2,
       lwbFullL2_i,
       lwbFullForApuL2,
        PCL_blkFlush_i,
        PCL_blkFlushForVct_i,
	PCL_Rbit_i,
	trapMco,
        lwbApuFpu,
        dofStValidL2,
	wbStDvcL2,
        PCL_exeTrap,
        apuBMcoDlydL2,
	PCL_dIcmpForWbFlushQDlydL2} <= 
	{nxtLwbCacheable,
	nxtLwbStrgLS,
	nxtLwbLpWrEn,
	{2{nxtLwbFull}},
        {4{nxtBlkFlush}},
	nxtRbit,
	nxtTrapMco,
        nxtLwbApuFpu,
	nxtDofStValid,
	nxtWbStDvc,
        nxtExeTrap,
	APU_exeBlkingMco,
	nxtdIcmpForWbFlush};
  end // dp_regPCL_pipeCntl_PROC


//************************************************************************
// Free running reset Latch
//************************************************************************
//Removed the module dp_regPCL_reset  
always @(posedge CB)
  begin: dp_regPCL_reset_PROC
    resetL2_i <= coreReset;
  end // dp_regPCL_reset_PROC
  
//************************************************************************
// DCR Bus Cntl
//************************************************************************

assign nxtMtdcr = (setMtdcr | mtDCRL2) & ~rstMtdcr;
assign nxtMfdcr = (setMfdcr | PCL_mfDCRL2_i) & ~rstMfdcr;

//assign setMtdcr = exeMtdcr & ~dcrAckL2 & ~exeLoadUseHold & ~exeDvcHold & ~wbHold &
//                  ~VCT_errorSprSuppress & ~IFB_exeFlush;

assign setMtdcr = exeMtdcr & ~dcrAckL2 & ~exeLoadUseHold & ~exeDvcOrParityHold & ~wbHold &
                  ~VCT_errorSprSuppress & ~IFB_exeFlush;

assign setMfdcr = exeMfdcr & ~dcrAckL2 & ~exeLoadUseHold & ~exeDvcOrParityHold & 
                  ~wbHold & ~VCT_errorSprSuppress & ~IFB_exeFlush;

assign rstMtdcr = (exeMtdcr & dcrAck) | resetL2_i;
assign rstMfdcr = (exeMfdcr & dcrAck) | resetL2_i;

assign dcrCntInc[0:6] = dcrCnt[0:6] + 1;

assign dcrCntIn[0:6] = dcrCntInc[0:6] &
                      {7{~(resetL2_i | dcrAck | exeLoadUseHold | exeDvcOrParityHold | wbHold | IFB_exeFlush)}};

assign dcrE1 = (exeMtdcr | exeMfdcr | mtDCRL2 | PCL_mfDCRL2_i | dcrAck | resetL2_i);

assign dcrMco = (exeMtdcr & ~mtDCRL2) | (exeMfdcr & ~PCL_mfDCRL2_i) |
                ((mtDCRL2 | PCL_mfDCRL2_i) & ~dcrAck);

assign dcrAck = dcrAckL2 | dcrCnt[0];

//*****************
// DCR Cntl Latch *
//*****************
//Removed the module dp_regPCL_dcrCntl  
always @(posedge CB)
  begin: dp_regPCL_dcrCntl_PROC
    if (dcrE1)
      {dcrCnt, mtDCRL2, PCL_mfDCRL2_i, dcrAckL2} <= {dcrCntIn, nxtMtdcr, nxtMfdcr, XXX_dcrAck};
  end // dp_regPCL_dcrCntl_PROC

//Removed the module dp_logPCL_pipeCntlBuf 
assign {PCL_mtDCR,PCL_mfDCR,PCL_wbFullForPO, PCL_ocmAbortReq} = 
       {mtDCRL2,PCL_mfDCRL2_i,wbFullForPO, PCL_exeAbort_i};
       
endmodule
