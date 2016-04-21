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
module p405s_exeStage (PCL_dcuOp, PCL_dsMmuOp, PCL_exeAdmCntl, PCL_exeCmplmntA, PCL_exeApuOp,
           PCL_exeCpuOp, PCL_exeWrExtEn, PCL_exeLogicalCntl, PCL_exePrivOp,
           PCL_exeSprDataEn_NEG, PCL_exeSrmCntl, PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_icuOp,
           PCL_ldNotSt, PCL_mfSPR, PCL_mtSPR, PCL_nopStringIndexed, PCL_tlbRE, PCL_tlbSX,
           PCL_tlbWE, PCL_tlbWS, exeFull, exeLSSMIURA, exeMfdcr, exeMtdcr, exeRpWrEn,
           exeXerTBCUpdInstr, APU_dcdPrivOp, CB, EXE_xerTBCNotEqZero, APU_dcdApuOp,
           plaVal, dcdRegBit20, dcdXerTBCUpdInstr, exeClearOrFlush, exeE1, exeE2, gtErr,
           plaAdmCntl, plaAddEn, plaCmplmntA, plaDcuOp, plaEaCalc, plaIcuOp, plaWrExtEn,
           plaLSSMIURA, plaLdNotSt, plaLogicalCntl, plaMfdcr, plaMfspr, plaMmuCode,
           plaMtdcr, plaMtspr, plaOeCk, plaPriv, plaRpWrEn, plaSrmCntl, plaUnitEn,
           plaXerCaEn, nxtExeFull, exeStorageOp, plaLwarx, plaStwcx, exeLwarx, exeStwcx,
           NplaApRdEn, NplaBpRdEn, plaSpRdEn, exeApRdEn, exeBpRdEn, exeSpRdEn, plaWrtee,
           PCL_exeWrtee, APU_dcdLoad, APU_dcdStore, APU_dcdUpdate, APU_dcdFpuOp, exeApuFpuOp,
           exeApuFpuLoad, PCL_exe2DataE1, PCL_exe2DataE2, exe2ClearOrFlush, exe2Full,
           PCL_exeNegMac, PCL_exeFpuOp, dcdApuValidOp_NEG, APU_dcdGprWr, PCL_exeApuValidOp,
           plaMac, plaNegMac, exeRpEqexe2RpAddr, PCL_exe2AccRegMuxSel, PCL_exe2NegMac,
           PCL_exe2MacEn, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2XerOvEn, PCL_exeRbEn,
           PCL_exeDbgRdOp, PCL_exeDbgWrOp, APU_dcdXerCAEn, APU_dcdXerOVEn, dcdMmuSprDcd,
           PCL_mmuSprDcd, exeStrgSt, PCL_exeMultEn, PCL_exeDivEn, PCL_exeLogicalUnitEn_NEG,
           PCL_exeSrmUnitEn_NEG, PCL_exeSprUnitEn_NEG, exeEaCalc, PCL_exeAddEn, PCL_exeMacEn,
           PCL_exeRaEn, PCL_exeStringMultiple, plaGateZeroToAccReg, dcdSecOpBit21L2,
           dcdRSRTL2, PCL_exeTrapCond, exeLoadQ, plaMacSat, PCL_exe2MacSat, exeMmuOp,
           PCL_Rbit, plaSrmBpSel, PCL_exeSrmBpSel, PCL_exe2SignedOp, exeMultEn,
           exeMacEn, PCL_exeDbgLdOp, PCL_exeDbgStOp, APU_dcdRaEn, APU_dcdRbEn,
           APU_dcdForceAlgn, APU_dcdExeLdDepend, exeDivEn, APU_dcdWbLdDepend,
           APU_dcdLwbLdDepend, exeApuExeWbLdUseL2, exeApuExeLwbLdUseL2, PCL_exeMultEn_NEG,
           PCL_exeDivEnForMuxSel, PCL_exeCmplmntA_NEG, PCL_exe2MacOrMultEn_NEG,
           PCL_exe2MacOrMultEnForMS, PCL_exeMultEnForMuxSel, wbHold, ltchDA,
           PCL_exeEaCalc, plaApuLdSt, exeForceAlgn, dcdIcuSprDcd, dcdTimSprDcd,
           PCL_icuSprDcds, PCL_timSprDcds, dcdDbgSprDcd, dcdExeSprDcd, dcdVctSprDcd,
           PCL_dbgSprDcds, PCL_exeSprDcds, PCL_vctSprDcds, resetL2, plaForceAlgn,
           PCL_exeAddSgndOp_NEG, PCL_exeDivSgndOp, PCL_exeDivEn_NEG, PCL_dcuOp_early,
           exeFullForE1_NEG, exe2FullForE1_NEG, APU_dcdTrapLE, APU_dcdTrapBE,
           APU_dcdForceBESteering, exeTrapLE, exeTrapBE, exeForceBESteering,
           PCL_exeMacOrMultEn_NEG, plaMtcrf, LSSD_coreTestEn,
           PCL_exeDivEnForLSSD, IFB_dcdFull, countE1, PCL_exeSrmUnitEnForLSSD,
           exeApuFpuLdSt, PCL_exeLogicalUnitEnForLSSD, exeStrgStC0, PCL_exeTlbOp,
           dcdJtgSprDcd, PCL_jtgSprDcd);
    output [0:11] PCL_dcuOp;
    output [0:7] PCL_exeLogicalCntl;
    output [0:7] exeLSSMIURA;
    output [0:1] PCL_exe2AccRegMuxSel;
    output [0:3] PCL_exeAdmCntl, PCL_exeSrmCntl, PCL_dsMmuOp, PCL_icuOp;
    output [0:3] PCL_exeRbEn, PCL_exeRaEn;
    output [0:8] PCL_mmuSprDcd;
    output [0:2] PCL_exeSrmBpSel;
    output [0:4] PCL_exeTrapCond;
    output [0:1] PCL_exeMultEn_NEG, PCL_exeDivEnForMuxSel, PCL_exeMultEnForMuxSel;
    output [0:1] PCL_exe2MacOrMultEn_NEG, PCL_exe2MacOrMultEnForMS;

    output [0:1] PCL_exeAddSgndOp_NEG;
    output [0:2] PCL_icuSprDcds;    
    
    output [0:5] PCL_timSprDcds;
    output [0:4] PCL_exeSprDcds;

    output [0:5] PCL_vctSprDcds;
      
    output [0:3] PCL_dbgSprDcds;
    output [0:2] PCL_dcuOp_early;
    output PCL_exeCmplmntA, PCL_exeApuOp, PCL_exeCpuOp, PCL_exePrivOp;
    output PCL_exeSprDataEn_NEG, PCL_exeWrExtEn, PCL_nopStringIndexed;
    output PCL_exeXerCaEn, PCL_exeXerOvEn;
    output PCL_ldNotSt, PCL_tlbRE, PCL_tlbSX, PCL_tlbWE, PCL_tlbWS, PCL_exeTlbOp;
    output PCL_mfSPR, PCL_mtSPR, exeMfdcr, exeMtdcr;
    output exeXerTBCUpdInstr, exeRpWrEn, exeApuFpuLdSt;
    output exeStwcx, exeLwarx, exeStorageOp, exeFull;
    output exeApRdEn, exeBpRdEn, exeSpRdEn, exe2Full;
    output exeApuFpuOp, exeApuFpuLoad, PCL_exeWrtee;
    output PCL_exe2NegMac, PCL_exeApuValidOp, PCL_exeFpuOp, PCL_exeNegMac;
    output PCL_exe2XerOvEn, PCL_exe2MultHiWd, PCL_exe2MacEn, PCL_exe2MultEn;
    output PCL_exeDbgWrOp, PCL_exeDbgRdOp, PCL_exeLogicalUnitEnForLSSD;
    output PCL_exeDivEn, PCL_exeMultEn, PCL_exeDivEnForLSSD, PCL_exeSrmUnitEnForLSSD;
    output PCL_exeSrmUnitEn_NEG, PCL_exeSprUnitEn_NEG, PCL_exeLogicalUnitEn_NEG;
    output PCL_exe2MacSat, PCL_exeStringMultiple, PCL_exeMacEn, PCL_exeAddEn;
    output PCL_exeDbgLdOp, PCL_exeDbgStOp, PCL_exe2SignedOp, exeMmuOp, exeLoadQ;
    output exeApuExeWbLdUseL2, exeApuExeLwbLdUseL2, exeDivEn, exeMacEn, exeMultEn;
    output exeFullForE1_NEG, PCL_exeDivEn_NEG, PCL_exeDivSgndOp, exe2FullForE1_NEG;
    output exeTrapLE, exeTrapBE, exeForceBESteering, exeForceAlgn, PCL_exeMacOrMultEn_NEG;
    output PCL_exeCmplmntA_NEG, PCL_exeEaCalc, exeEaCalc, countE1, PCL_jtgSprDcd;

    input       CB;
    input [0:11] plaDcuOp;
    input [0:3] plaIcuOp;
    input [0:7] plaLSSMIURA;
    input [0:7] plaLogicalCntl;
    input [0:6] plaMmuCode;
    input [0:3] plaAdmCntl;
    input [0:3] plaSrmCntl;
    input [0:4] plaUnitEn;
    input [0:8] dcdMmuSprDcd;
    input [1:2] exeStrgSt;
    input [0:4] dcdRSRTL2;
    input [0:5] dcdTimSprDcd;

    input [0:2] dcdIcuSprDcd;
        
    input [0:3] dcdDbgSprDcd;
    input [0:4] dcdExeSprDcd;
    
    input [0:5] dcdVctSprDcd;        // Took out MCSRS bit
        
    input [0:2] plaSrmBpSel;
    input plaAddEn, plaCmplmntA, plaEaCalc, plaWrExtEn;
    input plaMfdcr, plaMfspr, plaMtdcr, plaMtspr;
    input plaOeCk, plaVal, plaPriv, plaXerCaEn;
    input plaLwarx, plaStwcx, plaLdNotSt, plaWrtee, plaGateZeroToAccReg;
    input NplaApRdEn, NplaBpRdEn, plaSpRdEn, plaRpWrEn;
    input plaMac, plaNegMac, plaMacSat, plaApuLdSt, plaForceAlgn, plaMtcrf;
    input APU_dcdLoad, APU_dcdStore, APU_dcdApuOp, APU_dcdFpuOp, dcdApuValidOp_NEG;
    input APU_dcdPrivOp, APU_dcdUpdate, APU_dcdGprWr, APU_dcdXerCAEn, APU_dcdXerOVEn;
    input APU_dcdRaEn, APU_dcdRbEn, APU_dcdForceAlgn;
    input APU_dcdExeLdDepend, APU_dcdWbLdDepend, APU_dcdLwbLdDepend;
    input APU_dcdTrapLE, APU_dcdTrapBE, APU_dcdForceBESteering;
    input dcdRegBit20, dcdSecOpBit21L2, dcdXerTBCUpdInstr, exeStrgStC0, dcdJtgSprDcd;
    input exeClearOrFlush, exe2ClearOrFlush, exeRpEqexe2RpAddr, exeE1, exeE2, gtErr;
    input PCL_exe2DataE1, PCL_exe2DataE2, EXE_xerTBCNotEqZero, IFB_dcdFull;
    input ltchDA, resetL2, wbHold, PCL_Rbit, nxtExeFull,  LSSD_coreTestEn;

wire dcdXerOvEn, exeStrgLS, dcdSprDataEn;
wire exeStwcxC0, exeStwcxC1, dcdTlbOp;
wire apuExeWbUseIn, apuExeLwbUseIn, exeLwbUseClear, dcdApuLdOrSt;
reg exeFullForE1L2;

reg exeMacOrMultEnL2_NEG_i;
reg exeSprDataEnL2_NEG_i;
wire exeMacOrMultEnL2_NEG;
wire exeSprDataEnL2_NEG;

wire dcdLdNotSt;
wire [0:2] dcdDcuOp;
wire [0:3] exeDsMmuOp;
reg [0:3] exeIcuOp;
reg [0:11] exeDcuOp;
wire [1:3] dcdDsMmuOp;
wire [0:4] exeEUnitEn;
wire [0:6] apuLdStOptions;
reg [0:3] exeRaEn_NEG_i;
reg [0:3] exeRbEn_NEG_i;
wire [0:3] exeRaEn_NEG;
wire [0:3] exeRbEn_NEG;

wire dcdApuLoad_NEG, dcdApuStore_NEG, dcdApuLoad, dcdApuStore;

reg exeApuExeLwbLdUseL2_i;
reg exeApRdEnL2, exeBpRdEnL2;
reg exeRpWrEn;
reg [0:7] exeLSSMIURA_i;
reg exeForceAlgn;
reg PCL_exeApuValidOp;
reg exeApuExeWbLdUseL2;
reg PCL_exePrivOp;
reg PCL_exeXerOvEn_i;
reg PCL_exeXerCaEn;
reg exeTrapLE;
reg exeTrapBE;
reg exeForceBESteering;
reg [0:5] PCL_vctSprDcds;
reg [0:2] PCL_icuSprDcds;    
reg [0:5] PCL_timSprDcds;
reg PCL_tlbRE_i;
reg PCL_tlbWE_i;
reg PCL_tlbSX_i;
reg PCL_tlbWS;
reg PCL_exeTlbOp;
reg [0:8] PCL_mmuSprDcd;
reg [0:3] PCL_dbgSprDcds;
reg [0:4] PCL_exeSprDcds;
reg PCL_jtgSprDcd;
reg PCL_exeMultEn_i;
reg PCL_exeDivEn;
reg PCL_exeDivEnForLSSD;
reg PCL_exeMacEn_i;
reg PCL_exeAddEn;
reg PCL_exeCmplmntA;
reg [0:3] PCL_exeAdmCntl_i;
reg [0:7] PCL_exeLogicalCntl;
reg [0:4] PCL_exeTrapCond;
reg [0:2] PCL_exeSrmBpSel;
reg PCL_exeLogicalUnitEnForLSSD;
reg PCL_exeSrmUnitEnForLSSD;
reg exeXerTBCUpdInstr;
reg PCL_exeApuOp_i;
reg PCL_exeCpuOp;
reg PCL_mfSPR;
reg PCL_mtSPR;
reg exeMfdcr;
reg exeMtdcr;
reg PCL_exeWrExtEn;
reg PCL_exeWrtee;
reg exeFull;
reg exeLwarx;
reg exeStwcx_i;
reg exeSpRdEn;
reg PCL_exeFpuOp_i;
reg exeGateZeroToAccReg;
reg exeMacSat;
reg exeMultEn_i;
reg exeMacEn_i;
reg exeEaCalcL2;
reg PCL_exeNegMac_i;
reg exeDivEn;
wire [0:2] issue210_dcuOp_early;
wire dcdAddSgndOp_NEG, dcdDivSgndOp, dcdMacOrMultEn;

reg [0:2] exeDcuOp_early_i;
wire [0:2] exeDcuOp_early;

reg [0:3] exeDsMmuOp_NEG_i;
reg exeLdNotSt_NEG_i;
wire [0:3] exeDsMmuOp_NEG;
wire exeLdNotSt_NEG;

wire [0:3] exeSrmCntlL2_NEG;
reg [0:3] exeSrmCntlL2_NEG_i;

reg exe2FullForE1L2;
reg [0:1] PCL_exe2MacOrMultEnForMS;
reg [0:1] PCL_exe2MacOrMultEn_NEG;

reg exeLogicalUnitEnL2_NEG_i;
reg exeSrmUnitEnL2_NEG_i;
reg exeSprUnitEnL2_NEG_i;
wire exeLogicalUnitEnL2_NEG;
wire exeSrmUnitEnL2_NEG;
wire exeSprUnitEnL2_NEG;

reg [0:1] PCL_exeMultEn_NEG;
reg [0:1] PCL_exeMultEnForMuxSel;
reg PCL_exeDivEn_NEG;
reg [0:1] PCL_exeDivEnForMuxSel;
reg PCL_exeCmplmntA_NEG;
reg [0:1] PCL_exeAddSgndOp_NEG;
reg PCL_exeDivSgndOp;
reg exe2Full;
reg PCL_exe2NegMac;
reg PCL_exe2MultEn;
reg PCL_exe2MacEn;
reg PCL_exe2MultHiWd;
reg PCL_exe2XerOvEn;
reg PCL_exe2MacSat;
reg PCL_exe2SignedOp;
wire PCL_nopStringIndexed_i;

assign PCL_nopStringIndexed = PCL_nopStringIndexed_i;
assign exeApuExeLwbLdUseL2 = exeApuExeLwbLdUseL2_i;
assign exeLSSMIURA = exeLSSMIURA_i;
assign PCL_exeXerOvEn = PCL_exeXerOvEn_i;
assign PCL_tlbRE = PCL_tlbRE_i;
assign PCL_tlbWE = PCL_tlbWE_i;
assign PCL_tlbSX = PCL_tlbSX_i;
assign PCL_exeMultEn = PCL_exeMultEn_i;
assign PCL_exeMacEn = PCL_exeMacEn_i;
assign PCL_exeAdmCntl = PCL_exeAdmCntl_i;
assign PCL_exeApuOp = PCL_exeApuOp_i;
assign exeStwcx = exeStwcx_i;
assign PCL_exeFpuOp = PCL_exeFpuOp_i;
assign exeMultEn = exeMultEn_i;
assign exeMacEn = exeMacEn_i;
assign PCL_exeNegMac = PCL_exeNegMac_i;

//***********************************************************************************************//
//................................COBRA Changes..................................................//
//***********************************************************************************************//
//
//    Date              By Whom                    Description
// ~~~~~~~~~           ~~~~~~~~~              ~~~~~~~~~~~~~~~~~~~~~~~
//  06/05/01             JBB          Initial changes made per Cobra Workbook:
//
//                                    Widened dp_regPCL_exeCacheCntl to accomodate
//                                    new bits for MCSR/MCSRS                                        
//----------------------------------------------------------------------------------------------------         
//  08/28/01             JBB          Modified input and output bits of dp_regPCL_exeCacheCntl
//                                    for Formality compatibility (added bits in first)
//                                    (defect 1861)
//----------------------------------------------------------------------------------------------------         
//  09/24/01             JBB          Added fixes for Prowler Pass 2 issues 209 and 210
//                       (from SBP)   (defect 1901)
//----------------------------------------------------------------------------------------------------
//  10/05/01             JBB          (1) Widened dp_regPCL_exeCacheCntl again for the CCR1 decode
//                                        spr bit (was 7 bits wide, made it 8 bits wide). 
//                                    (2) Added another bit for the output to ICU (PCL_icuSprDcds[2]).
//                                        Put new bits first (Formality reasons).
//                                        (defect 1935)
//----------------------------------------------------------------------------------------------------
//  10/11/01             JBB          (1) Corrected a mistake in previous change.  Made dcdIcuSprDcd
//                                        wider and narrowed dcdVctSprDcd by 1 bit.  
//                                    (2) Did the same to outputs PCL_vctSprDcds and PCL_icuSprDcds
//                                        which come out of dp_regPCL_exeCacheCntl. Changed its width
//                                        to 29 bits (from 30 bits)
//                                        (defect 1955)
//----------------------------------------------------------------------------------------------------
//  10/17/01             JBB          Took out the bit in dcdVctSprDcd and PCL_vctSprDcds
//                                    for MCSRS in i/o list and in regPCL_exeCacheCntl
//                                    (defect 1971)
//----------------------------------------------------------------------------------------------------                    

//****************************************************************************************************
//Removed the module dp_logPCL_dcdApuLdStInv  
assign {dcdApuLoad_NEG, dcdApuStore_NEG} = ~{APU_dcdLoad, APU_dcdStore};

//Removed the module dp_logPCL_dcdApuLdStInv1  
assign {dcdApuLoad, dcdApuStore} = ~{dcdApuLoad_NEG, dcdApuStore_NEG};

assign dcdXerOvEn = (plaOeCk & dcdSecOpBit21L2);
assign dcdApuLdOrSt = ~(dcdApuLoad_NEG & dcdApuStore_NEG);
assign dcdSprDataEn = plaMtspr | plaMtdcr | plaMtcrf | plaMmuCode[5];
assign exeStwcxC0 = exeStwcx_i & exeStrgStC0;
assign exeStwcxC1 = exeStwcx_i & exeStrgSt[2];
assign exeStrgLS = exeStrgSt[1];

//************************************************************************
// APU Control Latch
//************************************************************************
assign apuExeWbUseIn = APU_dcdExeLdDepend | (APU_dcdWbLdDepend & wbHold);
assign apuExeLwbUseIn = (APU_dcdWbLdDepend & ~wbHold) | (APU_dcdLwbLdDepend & ~ltchDA);
assign exeLwbUseClear = ltchDA & exeApuExeLwbLdUseL2_i;

//Removed the module dp_regPCL_exeApuCntl0  
always @(posedge CB)
  begin: dp_regPCL_exeApuCntl0_PROC
    if (exeE1 & (exeE2 | exeLwbUseClear))
      begin
        if (exeClearOrFlush | exeLwbUseClear)
          exeApuExeLwbLdUseL2_i <= 1'b0;
        else
          exeApuExeLwbLdUseL2_i <= apuExeLwbUseIn;
      end
  end // dp_regPCL_exeApuCntl0_PROC

assign apuLdStOptions[0:6] = {plaForceAlgn, plaLSSMIURA[0], plaLSSMIURA[1],
                              plaLSSMIURA[5], plaRpWrEn, ~NplaApRdEn, ~NplaBpRdEn} &
                             {7{~exeClearOrFlush}};

assign dcdDcuOp[0:2] = plaDcuOp[0:2] & {3{~exeClearOrFlush}};
assign dcdDsMmuOp[1:3] = plaMmuCode[1:3] & {3{~exeClearOrFlush}};
assign dcdLdNotSt = plaLdNotSt & ~exeClearOrFlush;
assign dcdTlbOp = plaMmuCode[0] | plaMmuCode[4] | plaMmuCode[5] | plaMmuCode[6];

//Removed the module dp_regPCL_exeApuCntl2 
always @(posedge CB)
  begin: dp_regPCL_exeApuCntl2_PROC
    if (exeE1 & exeE2)
      begin
        case ({(exeClearOrFlush | plaApuLdSt), dcdApuValidOp_NEG})
          2'b00: {exeForceAlgn, exeLSSMIURA_i[0], exeLSSMIURA_i[1], exeLSSMIURA_i[5], exeRpWrEn,
                  exeApRdEnL2, exeBpRdEnL2, exeDcuOp[0:2]} <= 
                        {APU_dcdForceAlgn, dcdApuLoad, dcdApuStore, APU_dcdUpdate, APU_dcdGprWr,
                        APU_dcdRaEn, APU_dcdRbEn, dcdApuLdOrSt, dcdApuLoad, dcdApuStore};
          2'b01: {exeForceAlgn, exeLSSMIURA_i[0], exeLSSMIURA_i[1], exeLSSMIURA_i[5], exeRpWrEn,
                  exeApRdEnL2, exeBpRdEnL2, exeDcuOp[0:2]} <= 
                        {plaForceAlgn, plaLSSMIURA[0], plaLSSMIURA[1], plaLSSMIURA[5], plaRpWrEn,
                        ~NplaApRdEn, ~NplaBpRdEn, plaDcuOp[0:2]};
          2'b10: {exeForceAlgn, exeLSSMIURA_i[0], exeLSSMIURA_i[1], exeLSSMIURA_i[5], exeRpWrEn,
                  exeApRdEnL2, exeBpRdEnL2, exeDcuOp[0:2]} <= {apuLdStOptions,dcdDcuOp};
          2'b11: {exeForceAlgn, exeLSSMIURA_i[0], exeLSSMIURA_i[1], exeLSSMIURA_i[5], exeRpWrEn,
                  exeApRdEnL2, exeBpRdEnL2, exeDcuOp[0:2]} <= {apuLdStOptions, dcdDcuOp};
          default: {exeForceAlgn, exeLSSMIURA_i[0], exeLSSMIURA_i[1], exeLSSMIURA_i[5], exeRpWrEn,
                  exeApRdEnL2, exeBpRdEnL2, exeDcuOp[0:2]} <= 10'bx;  
        endcase
      end
  end // dp_regPCL_exeApuCntl2_PROC

//Removed the module dp_regPCL_exeApuCntl1 
always @(posedge CB)
  begin: dp_regPCL_exeApuCntl1_PROC
    if (exeE1 & exeE2)
      begin
        case ({exeClearOrFlush, dcdApuValidOp_NEG})
          2'b00: {PCL_exeApuValidOp, exeApuExeWbLdUseL2, PCL_exePrivOp, PCL_exeXerOvEn_i,
                  PCL_exeXerCaEn, exeTrapLE, exeTrapBE, exeForceBESteering} <= 
                        {1'b1, apuExeWbUseIn, APU_dcdPrivOp,
                         APU_dcdXerOVEn, APU_dcdXerCAEn, APU_dcdTrapLE, 
                         APU_dcdTrapBE, APU_dcdForceBESteering};
          2'b01: {PCL_exeApuValidOp, exeApuExeWbLdUseL2, PCL_exePrivOp, PCL_exeXerOvEn_i,
                  PCL_exeXerCaEn, exeTrapLE, exeTrapBE, exeForceBESteering} <= 
                        {2'b0, plaPriv, dcdXerOvEn, plaXerCaEn, 3'b0};
          2'b10: {PCL_exeApuValidOp, exeApuExeWbLdUseL2, PCL_exePrivOp, PCL_exeXerOvEn_i,
                  PCL_exeXerCaEn, exeTrapLE, exeTrapBE, exeForceBESteering} <= 8'b0;
          2'b11: {PCL_exeApuValidOp, exeApuExeWbLdUseL2, PCL_exePrivOp, PCL_exeXerOvEn_i,
                  PCL_exeXerCaEn, exeTrapLE, exeTrapBE, exeForceBESteering} <= 8'b0;
          default: {PCL_exeApuValidOp, exeApuExeWbLdUseL2, PCL_exePrivOp, PCL_exeXerOvEn_i,
                  PCL_exeXerCaEn, exeTrapLE, exeTrapBE, exeForceBESteering} <= 8'bx;  
        endcase
      end
  end // dp_regPCL_exeApuCntl1_PROC

//************************************************************************
// Cache MMU Control Latch
//************************************************************************

//Removed the module dp_regPCL_exeCacheCntl  
always @(posedge CB)
  begin: dp_regPCL_exeCacheCntl_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {PCL_icuSprDcds[2],
	   PCL_vctSprDcds[5],
           exeIcuOp[0:3], 
           exeDcuOp[3:11],
           PCL_icuSprDcds[0:1], 
           PCL_timSprDcds[0:5],
           PCL_vctSprDcds[0:4]} <= 28'b0;
        else
          {PCL_icuSprDcds[2],
	   PCL_vctSprDcds[5],
           exeIcuOp[0:3], 
           exeDcuOp[3:11],
           PCL_icuSprDcds[0:1], 
           PCL_timSprDcds[0:5],
           PCL_vctSprDcds[0:4]} <= {dcdIcuSprDcd[2], 
	                            dcdVctSprDcd[5],
                                    plaIcuOp[0:3],
                                    plaDcuOp[3:11],
                                    dcdIcuSprDcd[0:1], 
                                    dcdTimSprDcd[0:5],
                                    dcdVctSprDcd[0:4]};
      end
  end // dp_regPCL_exeCacheCntl_PROC


//************************************************************************
// MMU Control Latch
//************************************************************************
//Removed the module dp_regPCL_exeCacheCntl  
always @(posedge CB)
  begin: dp_regPCL_exeMmuCntl_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {PCL_tlbRE_i, 
           PCL_tlbWE_i, 
           PCL_tlbSX_i, 
           PCL_tlbWS, 
           PCL_exeTlbOp, 
           PCL_mmuSprDcd,
           PCL_dbgSprDcds, 
           PCL_exeSprDcds, 
           PCL_jtgSprDcd} <= 24'b0;
        else
          {PCL_tlbRE_i, 
           PCL_tlbWE_i, 
           PCL_tlbSX_i, 
           PCL_tlbWS, 
           PCL_exeTlbOp, 
           PCL_mmuSprDcd,
           PCL_dbgSprDcds, 
           PCL_exeSprDcds, 
           PCL_jtgSprDcd} <= {plaMmuCode[4:6], 
                              dcdRegBit20, 
                              dcdTlbOp, 
                              dcdMmuSprDcd, 
                              dcdDbgSprDcd,
                              dcdExeSprDcd, 
                              dcdJtgSprDcd};
      end
  end // dp_regPCL_exeMmuCntl_PROC

//************************************************************************
// EXE Unit Control Latch
//************************************************************************
//Removed the module dp_regPCL_exeUnitCntl  
always @(posedge CB)
  begin: dp_regPCL_exeUnitCntl_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {PCL_exeMultEn_i, 
           PCL_exeDivEn, 
           PCL_exeMacEn_i, 
           PCL_exeAddEn, 
           PCL_exeCmplmntA,
           PCL_exeAdmCntl_i, 
           PCL_exeLogicalCntl,
           PCL_exeTrapCond, 
           PCL_exeSrmBpSel, 
           PCL_exeDivEnForLSSD,
           PCL_exeLogicalUnitEnForLSSD, 
           PCL_exeSrmUnitEnForLSSD} <= 28'b0;
        else
          {PCL_exeMultEn_i, 
           PCL_exeDivEn, 
           PCL_exeMacEn_i, 
           PCL_exeAddEn, 
           PCL_exeCmplmntA,
           PCL_exeAdmCntl_i, 
           PCL_exeLogicalCntl,
           PCL_exeTrapCond, 
           PCL_exeSrmBpSel, 
           PCL_exeDivEnForLSSD,
           PCL_exeLogicalUnitEnForLSSD, 
           PCL_exeSrmUnitEnForLSSD} <= {plaUnitEn[0:1], 
                                        plaMac, 
                                        plaAddEn, 
                                        plaCmplmntA, 
                                        plaAdmCntl, 
                                        plaLogicalCntl,
                                        dcdRSRTL2, 
                                        plaSrmBpSel, 
                                        plaUnitEn[1:3]};
      end
  end // dp_regPCL_exeUnitCntl_PROC

//************************************************************************
// storage/spr/VCT Control Latch
//************************************************************************
//Removed the module dp_regPCL_strgSprVct 
always @(posedge CB)
  begin: dp_regPCL_strgSprVct_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {exeLSSMIURA_i[2:4], 
           exeLSSMIURA_i[6:7],
           exeXerTBCUpdInstr, 
           PCL_exeApuOp_i, 
           PCL_exeCpuOp,
           PCL_mfSPR, 
           PCL_mtSPR, 
           exeMfdcr, 
           exeMtdcr, 
           PCL_exeWrExtEn, 
           PCL_exeWrtee, 
           exeFull,
           exeLwarx, 
           exeStwcx_i, 
           exeSpRdEn, 
           PCL_exeFpuOp_i, 
           exeGateZeroToAccReg,
           exeMacSat, 
           exeMultEn_i, 
           exeMacEn_i, 
           exeEaCalcL2, 
           PCL_exeNegMac_i, 
           exeDivEn} <= 26'b0;
        else
          {exeLSSMIURA_i[2:4], 
           exeLSSMIURA_i[6:7],
           exeXerTBCUpdInstr, 
           PCL_exeApuOp_i, 
           PCL_exeCpuOp,
           PCL_mfSPR, 
           PCL_mtSPR, 
           exeMfdcr, 
           exeMtdcr, 
           PCL_exeWrExtEn, 
           PCL_exeWrtee, 
           exeFull,
           exeLwarx, 
           exeStwcx_i, 
           exeSpRdEn, 
           PCL_exeFpuOp_i, 
           exeGateZeroToAccReg,
           exeMacSat, 
           exeMultEn_i, 
           exeMacEn_i, 
           exeEaCalcL2, 
           PCL_exeNegMac_i, 
           exeDivEn} <= {plaLSSMIURA[2:4], 
                         plaLSSMIURA[6:7], 
                         dcdXerTBCUpdInstr, 
                         APU_dcdApuOp, 
                         plaVal,
                         plaMfspr, 
                         plaMtspr, 
                         plaMfdcr, 
                         plaMtdcr, 
                         plaWrExtEn, 
                         plaWrtee, 
                         nxtExeFull,
                         plaLwarx, 
                         plaStwcx, 
                         plaSpRdEn, 
                         APU_dcdFpuOp, 
                         plaGateZeroToAccReg,
                         plaMacSat,
                         plaUnitEn[0],
                         plaMac,
                         plaEaCalc,
                         plaNegMac, 
                         plaUnitEn[1]};
      end
  end // dp_regPCL_strgSprVct_PROC
  
//************************************************************************
// EXE2 Unit Control Latch
//************************************************************************
//Removed the module dp_regPCL_exe2Stage
always @(posedge CB)
  begin: dp_regPCL_exe2Stage_PROC
    if (PCL_exe2DataE1 & PCL_exe2DataE2)
      begin
        if (exe2ClearOrFlush)
          {exe2Full,
           PCL_exe2NegMac,
           PCL_exe2MultEn,
           PCL_exe2MacEn,
           PCL_exe2MultHiWd,
           PCL_exe2XerOvEn,
           PCL_exe2MacSat,
           PCL_exe2SignedOp} <= 8'b0;
        else
          {exe2Full,
           PCL_exe2NegMac,
           PCL_exe2MultEn,
           PCL_exe2MacEn,
           PCL_exe2MultHiWd,
           PCL_exe2XerOvEn,
           PCL_exe2MacSat,
           PCL_exe2SignedOp} <= {1'b1,
                                 PCL_exeNegMac_i,
                                 PCL_exeMultEn_i,
                                 PCL_exeMacEn_i,
                                 PCL_exeAdmCntl_i[3],
                                 PCL_exeXerOvEn_i,
                                 exeMacSat,
                                 PCL_exeAdmCntl_i[2]};
      end
  end // dp_regPCL_exe2Stage_PROC
  
//************************************************************************
// EXE Unit High power Latch
//************************************************************************
assign dcdAddSgndOp_NEG = ~(plaAddEn & plaAdmCntl[2]);
assign dcdDivSgndOp = plaUnitEn[1] & plaAdmCntl[2];
assign dcdMacOrMultEn = plaUnitEn[0] | plaMac;

//Removed the module dp_regPCL_exeHiPwr 
always @(posedge CB)
  begin: dp_regPCL_exeHiPwr_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {exeFullForE1L2, 
           PCL_exeMultEn_NEG, 
           PCL_exeMultEnForMuxSel,
           PCL_exeDivEn_NEG, 
           PCL_exeDivEnForMuxSel, 
           PCL_exeCmplmntA_NEG,
           PCL_exeAddSgndOp_NEG, 
           PCL_exeDivSgndOp} <= 12'h0;
        else
          {exeFullForE1L2, 
           PCL_exeMultEn_NEG, 
           PCL_exeMultEnForMuxSel,
           PCL_exeDivEn_NEG, 
           PCL_exeDivEnForMuxSel, 
           PCL_exeCmplmntA_NEG,
           PCL_exeAddSgndOp_NEG, 
           PCL_exeDivSgndOp} <= {nxtExeFull, 
                                 ~plaUnitEn[0], 
                                 ~plaUnitEn[0], 
                                 plaUnitEn[0], 
                                 plaUnitEn[0],
                                 ~plaUnitEn[1], 
                                 plaUnitEn[1],
                                 plaUnitEn[1], 
                                 ~plaCmplmntA,
                                 dcdAddSgndOp_NEG,
                                 dcdAddSgndOp_NEG, 
                                 dcdDivSgndOp};
      end
  end // dp_regPCL_exeHiPwr_PROC

//Removed the module dp_regPCL_eUnitEn 
always @(posedge CB)
  begin: dp_regPCL_eUnitEn_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          {exeLogicalUnitEnL2_NEG_i, 
           exeSrmUnitEnL2_NEG_i, 
           exeSprUnitEnL2_NEG_i, 
           exeMacOrMultEnL2_NEG_i,
           exeSprDataEnL2_NEG_i} <= 5'h0;
        else
          {exeLogicalUnitEnL2_NEG_i, 
           exeSrmUnitEnL2_NEG_i, 
           exeSprUnitEnL2_NEG_i, 
           exeMacOrMultEnL2_NEG_i,
           exeSprDataEnL2_NEG_i} <= {plaUnitEn[2:4], dcdMacOrMultEn, dcdSprDataEn};
      end
  end // dp_regPCL_eUnitEn_PROC

assign {exeLogicalUnitEnL2_NEG, 
           exeSrmUnitEnL2_NEG, 
           exeSprUnitEnL2_NEG, 
           exeMacOrMultEnL2_NEG,
           exeSprDataEnL2_NEG} =
       ~{exeLogicalUnitEnL2_NEG_i, 
           exeSrmUnitEnL2_NEG_i, 
           exeSprUnitEnL2_NEG_i, 
           exeMacOrMultEnL2_NEG_i,
           exeSprDataEnL2_NEG_i};
           
//Removed the module dp_logPCL_eUnitEnInv 
assign exeEUnitEn = ~{exeSprDataEnL2_NEG, exeSprUnitEnL2_NEG, 
                     exeSrmUnitEnL2_NEG, exeLogicalUnitEnL2_NEG,
                     exeMacOrMultEnL2_NEG};

//Removed the module dp_logPCL_eUnitEnInv1  
assign {PCL_exeSprDataEn_NEG, PCL_exeSprUnitEn_NEG, PCL_exeSrmUnitEn_NEG,
        PCL_exeLogicalUnitEn_NEG, PCL_exeMacOrMultEn_NEG} = ~exeEUnitEn;      

//Removed the module dp_regPCL_exeApuHiPwr 
always @(posedge CB)
  begin: dp_regPCL_exeApuHiPwr_PROC
    if (exeE1 & exeE2)
      begin
        case ({(exeClearOrFlush | plaApuLdSt), dcdApuValidOp_NEG})
          2'b00 : exeDcuOp_early_i <= {dcdApuLdOrSt, dcdApuLoad, dcdApuStore};
          2'b01 : exeDcuOp_early_i <= plaDcuOp[0:2];
          2'b10 : exeDcuOp_early_i <= dcdDcuOp;
          2'b11 : exeDcuOp_early_i <= dcdDcuOp;
          default : exeDcuOp_early_i <= 3'bxxx;
        endcase
      end
  end // dp_regPCL_exeApuHiPwr_PROC

assign exeDcuOp_early = ~exeDcuOp_early_i;
  
//Removed the module dp_logPCL_exeDcuOpEarlyINV 
assign issue210_dcuOp_early = ~exeDcuOp_early;

assign PCL_dcuOp_early[0:2] = {issue210_dcuOp_early[0:1], (issue210_dcuOp_early[2] & ~exeStwcxC1)};

//Removed the module dp_regPCL_exeMmuHiPwr 
always @(posedge CB)
  begin: dp_regPCL_exeMmuHiPwr_PROC
    if (exeE1 & exeE2)
      begin
        case ({(exeClearOrFlush | plaApuLdSt), dcdApuValidOp_NEG})
          2'b00 : {exeDsMmuOp_NEG_i, exeLdNotSt_NEG_i} <= {1'b0, {3{dcdApuLdOrSt}}, dcdApuLoad};
          2'b01 : {exeDsMmuOp_NEG_i, exeLdNotSt_NEG_i} <= {plaMmuCode[0:3], plaLdNotSt};
          2'b10 : {exeDsMmuOp_NEG_i, exeLdNotSt_NEG_i} <= {1'b0, dcdDsMmuOp[1:3], dcdLdNotSt};
          2'b11 : {exeDsMmuOp_NEG_i, exeLdNotSt_NEG_i} <= {1'b0, dcdDsMmuOp[1:3], dcdLdNotSt};
          default : {exeDsMmuOp_NEG_i, exeLdNotSt_NEG_i} <= 5'bxxxxx;
        endcase
      end
  end // dp_regPCL_exeMmuHiPwr_PROC
  
assign exeDsMmuOp_NEG = ~exeDsMmuOp_NEG_i;
assign exeLdNotSt_NEG = ~exeLdNotSt_NEG_i;

//Removed the module dp_logPCL_exeMmuOpEarlyINV
assign {exeDsMmuOp[0:3],PCL_ldNotSt} = ~{exeDsMmuOp_NEG,exeLdNotSt_NEG};

//Removed the module dp_regPCL_exeSrmCntl 
always @(posedge CB)
  begin: dp_regPCL_exeSrmCntl_PROC
    if (exeE1 & exeE2)
      begin
        if (exeClearOrFlush)
          exeSrmCntlL2_NEG_i <= 4'h0;
        else
          exeSrmCntlL2_NEG_i <= plaSrmCntl;
      end
  end // dp_regPCL_exeSrmCntl_PROC

assign exeSrmCntlL2_NEG = ~exeSrmCntlL2_NEG_i;

//Removed the module dp_logPCL_exeSrmCntlInv 
assign PCL_exeSrmCntl = ~exeSrmCntlL2_NEG;

//Removed the module dp_regPCL_exeRaRbEn 
always @(posedge CB)
  begin: dp_regPCL_exeRaRbEn_PROC
    if (exeE1 & exeE2)
      begin
        if (dcdApuValidOp_NEG)
          {exeRaEn_NEG_i, exeRbEn_NEG_i} <= 8'h0;
        else
          {exeRaEn_NEG_i, exeRbEn_NEG_i} <= {{4{APU_dcdRaEn}}, {4{APU_dcdRbEn}}};
      end
  end // dp_regPCL_exeRaRbEn_PROC

assign exeRaEn_NEG = ~exeRaEn_NEG_i;
assign exeRbEn_NEG = ~exeRbEn_NEG_i;

//Removed the module dp_logPCL_exeRaRbEnInv 
assign {PCL_exeRaEn, PCL_exeRbEn} = ~{exeRaEn_NEG, exeRbEn_NEG};

//************************************************************************
// EXE2 Unit High power Latch
//************************************************************************
//Removed the module dp_regPCL_exe2HiPwr 
always @(posedge CB)
  begin: dp_regPCL_exe2HiPwr_PROC
    if (PCL_exe2DataE1 & PCL_exe2DataE2)
      begin
        if (exe2ClearOrFlush)
          {exe2FullForE1L2, PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG} <= 5'b00011;
        else
          {exe2FullForE1L2, PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG} <= 
              {1'b1, {2{(exeMultEn_i |  exeMacEn_i)}}, {2{(~(exeMultEn_i |  exeMacEn_i))}}};
      end
  end // dp_regPCL_exe2HiPwr_PROC

//Removed the module dp_logPCL_exeStageInv
assign {exeFullForE1_NEG, exe2FullForE1_NEG} = ~{exeFullForE1L2, exe2FullForE1L2};

// AccRegMuxSel[0:1]
// 00 -  SReg         # Mac's only
// 01 -  rRegBypass   # RT2RT dependencies. exe2 has Mac or Mult, exe1 has Mac
// 10 -  Unused (vdd) #
// 11 -  gnd          # All Mults
assign PCL_exe2AccRegMuxSel[0] = exeGateZeroToAccReg | LSSD_coreTestEn;
assign PCL_exe2AccRegMuxSel[1] = exeGateZeroToAccReg | exeRpEqexe2RpAddr;

assign PCL_nopStringIndexed_i = ~(EXE_xerTBCNotEqZero | ~exeLSSMIURA_i[2] |
                                ~exeLSSMIURA_i[4]) & (exeLSSMIURA_i[0] | exeLSSMIURA_i[1]);

assign PCL_icuOp[0:3] = exeIcuOp[0:3];

// Issue 210 fix. SBP 08/30/01...JBB 09/24/01
//assign PCL_dcuOp[0:11] = exeDcuOp[0:11];
assign PCL_dcuOp[0:11] = {(exeDcuOp[0] & ~exeStwcxC1), exeDcuOp[1], (exeDcuOp[2] & ~exeStwcxC1), exeDcuOp[3:11]};

assign PCL_dsMmuOp[0:3] = exeDsMmuOp[0:3];


//Suppress=0111 Or NonSuppress=0110 type Op.
assign exeStorageOp = (~exeDsMmuOp[0] & exeDsMmuOp[1] & exeDsMmuOp[2]) &
                       ~exeStwcxC1 ;  // C1 cycle of stwrx for CR update.

assign exeApuFpuOp = PCL_exeApuOp_i | PCL_exeFpuOp_i;

assign exeApuFpuLoad = exeLSSMIURA_i[0] & (PCL_exeApuOp_i | PCL_exeFpuOp_i);

assign exeApuFpuLdSt = (exeLSSMIURA_i[0] | exeLSSMIURA_i[1]) & (PCL_exeApuOp_i | PCL_exeFpuOp_i);

assign exeApRdEn = exeApRdEnL2 | ((exeLSSMIURA_i[0] | exeLSSMIURA_i[1]) & PCL_exeApuOp_i);

assign exeBpRdEn = exeBpRdEnL2 | ((exeLSSMIURA_i[0] | exeLSSMIURA_i[1]) & PCL_exeApuOp_i);

assign PCL_exeStringMultiple = exeLSSMIURA_i[2] | exeLSSMIURA_i[3];

// nopString Load, dcbt/dcbtst, icbt, icbi.
assign PCL_exeDbgRdOp =  (exeLSSMIURA_i[0] & ~PCL_nopStringIndexed_i & ~exeDcuOp[10] & ~exeStrgLS) |
                       exeDcuOp[3] |
                      (~exeIcuOp[1] & ~exeIcuOp[2] & exeIcuOp[3]) |
                      (~exeIcuOp[1] & exeIcuOp[2] & ~exeIcuOp[3]);

// nopString Load
assign PCL_exeDbgLdOp =  (exeLSSMIURA_i[0] & ~PCL_nopStringIndexed_i & ~exeDcuOp[10] & ~exeStrgLS);

// nopString Store, dcbf, dcbst, dcbz, dcbi, dcba.
assign PCL_exeDbgWrOp =  (exeLSSMIURA_i[1] & ~PCL_nopStringIndexed_i & ~(exeStwcxC0 & ~PCL_Rbit) & ~exeStwcxC1) |
                      exeDcuOp[6] | exeDcuOp[7] | exeDcuOp[4] | exeDcuOp[8] | exeDcuOp[5];

// nopString Store.
assign PCL_exeDbgStOp =  (exeLSSMIURA_i[1] & ~PCL_nopStringIndexed_i & ~(exeStwcxC0 & ~PCL_Rbit) & ~exeStwcxC1);

assign exeLoadQ = exeLSSMIURA_i[0] & ~(exeLSSMIURA_i[2] & exeLSSMIURA_i[4] & ~EXE_xerTBCNotEqZero);

assign exeMmuOp = exeDsMmuOp[0] | PCL_tlbRE_i | PCL_tlbWE_i | PCL_tlbSX_i;

assign PCL_exeEaCalc = exeEaCalcL2 | exeLSSMIURA_i[0] | exeLSSMIURA_i[1];

assign exeEaCalc = exeEaCalcL2 | exeLSSMIURA_i[0] | exeLSSMIURA_i[1];

assign countE1 = exeEaCalcL2 | exeLSSMIURA_i[0] | exeLSSMIURA_i[1] | IFB_dcdFull;

endmodule
