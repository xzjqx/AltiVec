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
// JRS   7-24-01          Added ICU_dcuParity_PF and  ICU_diagOutParity as outputs of icu_top,
//                         coming from icu_ram_data_flow_16K. Both are the BIST pass/fail outputs from the
//                         new parity array and are logically equivalent. ICU_dcuParity_PF must go to
//                         the BIST controller. ICU_diagOutParity is for external monitoring and should
//                         be a primary output of the core.
// JRS   7-24-01          Added ICU_dcuCCR0_L2[11] as output of icu_top, coming from icu_data_flow.
//                         Is the ICU_paritySel signal from CCR0 that is used to choose parity output
//                         icread/dcread ops.  It goes to the DCU on this output.
// PGM  07/31/01   1785   Remove port size information in module definition
// JRS  07/02/01   1793   Adding parity enables and precision as PO's
//                         (ICU_CCR0DPE, ICU_CCR0DPP, ICU_CCR0IPE, ICU_CCR0TPE).
// JRS  08/03/01   1799   Adding data parity array cycle signals and bit enables.
// RLG  07/10/02   2774   Adding PLB_sampleCycleAlt for the Byron chip guys


module p405s_icu_top( DCU_plbPriorityBit1,
                      ICU_ABus,
                      ICU_CCR0DDK,
                      ICU_EO,
                      ICU_GPRC,
                      ICU_LDBE,
                      ICU_U0Attr,
                      ICU_abort,
                      ICU_cacheable,
                      ICU_dcuCCR0_L2,
                      ICU_diagBus,
                      ICU_dsCA,
                      ICU_ifbError,
                      ICU_isBus,
                      ICU_isCA,
                      ICU_mmuEoOdd,
                      ICU_mmuRdarE2,
                      ICU_ocmIcuReady,
                      ICU_ocmReqPending,
                      ICU_plbPriority,
                      ICU_request,
                      ICU_scanout,
                      ICU_sleepReq,
                      ICU_sprData,
                      ICU_syncAfterReset,
                      ICU_traceEnable,
                      ICU_tranSize,
                      CB,
                      DCU_icuSize,
                      EXE_dsEA_NEG,
                      EXE_icuSprDcds,
                      EXE_sprData,
                      ICU_scanin,
                      IFB_cntxSync,
                      IFB_fetchReq,
                      IFB_icuCancelData,
                      IFB_isAbort,
                      IFB_isEA,
                      IFB_isNL,
                      JTG_iCacheWr_NEG,
                      JTG_inst,
                      MMU_dsEndianL2,
                      MMU_dsU0AttrL2,
                      MMU_icuDsAbort,
                      MMU_icuIsAbort,
                      MMU_isCacheableNEG,
                      MMU_isDsCacheableL2,
                      MMU_isDsXltValidL2,
                      MMU_isEndian,
                      MMU_isRANEG,
                      MMU_isU0Attr,
                      MMU_isXltValid,
                      MMU_rdarDsRAL2,
                      OCM_isDATA,
                      OCM_isDValid,
                      OCM_isHold,
                      PCL_icuOp,
                      PCL_mfSPR,
                      PCL_mtSPR,
                      PCL_sprHold,
                      PLB_dcuBusy,
                      PLB_icuAddrAck,
                      PLB_icuBusy,
                      PLB_icuDBus,
                      PLB_icuError,
                      PLB_icuRdDAck,
                      PLB_icuRdWdAddr,
                      PLB_sSize,
                      PLB_sampleCycle,
                      VCT_exeAbort,
                      VCT_icuWbAbort,
                      resetCoreIn,
                      testEn,
                      VCT_msrIR,
                      ICU_parityErrE,
                      ICU_parityErrO,
                      ICU_tagParityErr,
                      ICU_CCR0DPE,
                      ICU_CCR0DPP,
                      ICU_CCR0IPE,
                      ICU_CCR0TPE,
                      ICU_CCR1DCTE,
                      ICU_CCR1DCDE,
                      ICU_CCR1TLBE,
                      PLB_sampleCycleAlt,
                      CPM_c405SyncBypass,
                      icu_bist_debug_si,
                      icu_bist_debug_so,
                      icu_bist_debug_en,
                      icu_bist_mode_reg_in,
                      icu_bist_mode_reg_out,
                      icu_bist_parallel_dr,
                      icu_bist_mode_reg_si,
                      icu_bist_mode_reg_so,
                      icu_bist_shift_dr,
                      icu_bist_mbrun,
                      resetMemBist
                    );

output DCU_plbPriorityBit1;
output ICU_CCR0DDK;
output ICU_GPRC;
output ICU_LDBE;
output ICU_U0Attr;
output ICU_abort;
output ICU_cacheable; 
output ICU_dsCA;
output ICU_isCA;
output ICU_mmuEoOdd;
output ICU_mmuRdarE2;
output ICU_ocmIcuReady;
output ICU_ocmReqPending;
output ICU_request;
output ICU_sleepReq;
output ICU_syncAfterReset;
output ICU_traceEnable;
output ICU_CCR0DPE;
output ICU_CCR0DPP;
output ICU_CCR0IPE;
output ICU_CCR0TPE;
output ICU_CCR1DCTE;
output ICU_CCR1DCDE;
output ICU_CCR1TLBE;

// added for tbird
input PLB_sampleCycleAlt;
input CPM_c405SyncBypass;

input  IFB_cntxSync;
input IFB_fetchReq;
input IFB_icuCancelData;
input IFB_isNL;
input JTG_iCacheWr_NEG;
input MMU_dsEndianL2;
input MMU_dsU0AttrL2;
input MMU_icuDsAbort;
input MMU_icuIsAbort;
input MMU_isDsCacheableL2;
input MMU_isDsXltValidL2;
input MMU_isEndian;
input MMU_isU0Attr;
input MMU_isXltValid;
input OCM_isHold;
input PCL_mfSPR;
input PCL_mtSPR;
input PCL_sprHold;
input PLB_dcuBusy;
input PLB_icuAddrAck;
input PLB_icuBusy;
input PLB_icuError;
input PLB_icuRdDAck;
input PLB_sSize;
input PLB_sampleCycle;
input VCT_exeAbort;
input VCT_icuWbAbort;
input resetCoreIn;
input testEn;
input VCT_msrIR;

output [0:1]  ICU_ifbError;
output [0:22]  ICU_diagBus;
output [0:63]  ICU_isBus;
output [0:31]  ICU_sprData;
output [0:1]  ICU_plbPriority;
output [0:1]  ICU_EO;
output [2:3]  ICU_tranSize;
output [0:29]  ICU_ABus;
output [0:2]  ICU_scanout;
output [0:11]  ICU_dcuCCR0_L2;  // JRS 7-24-01
                                // added ICU_paritySel as bit 11
                                // goes to DCU and also out on ICU_sprData as bit 28
                                // won't send to icu_PrControl for JTAG since generating parity
                                //   off the JTAG data

output          ICU_parityErrE; // parity error for fetch on high-order word ICU_isBus[0:31]
output          ICU_parityErrO;  // parity error for fetch on low-order word ICU_isBus[32:63]
output          ICU_tagParityErr;     // parity error for fetch on tag hit


input [0:63]  OCM_isDATA;
input [0:29]  MMU_isRANEG;
input [0:29]  MMU_rdarDsRAL2;
input [1:3]  PLB_icuRdWdAddr;
input [0:2]  MMU_isCacheableNEG;
input [0:63]  PLB_icuDBus;
input [0:31]  EXE_sprData;
input [0:3]  PCL_icuOp;
input [0:29]  EXE_dsEA_NEG;
input [0:31]  JTG_inst;
input [0:1]  OCM_isDValid;
input [0:2]  IFB_isAbort;
input        CB;
input [0:2]  EXE_icuSprDcds;
input [0:2]  ICU_scanin;
input [0:29]  IFB_isEA;
input [0:2]  DCU_icuSize;

input        resetMemBist;  // sync reset for icu memory bist

// BIST IO

input         icu_bist_mbrun;
input  [3:0]  icu_bist_debug_si;
input  [3:0]  icu_bist_debug_en;
output [3:0]  icu_bist_debug_so;

input   icu_bist_shift_dr;
input   icu_bist_mode_reg_si;
output  icu_bist_mode_reg_so;

input          icu_bist_parallel_dr;
input  [18:0]  icu_bist_mode_reg_in;
output [18:0]  icu_bist_mode_reg_out;


// Buses in the design

wire  [0:29]  icu_ABus_NEG;

wire  [0:22]  symNet249;

wire  [0:21]  rars;

wire  [0:29]  df_rdar;

wire  [18:26]  df_lruWrVCcIn;

wire  [18:26]  df_tagVccRegInNeg;

wire  [0:31]  icreadData;

wire  [0:7]  fillBE2;

wire  [0:7]  fillAE2;

wire  [0:3]  wbHighE2;

wire  [0:1]  isBusSel;

wire  [0:2]  icuCacheSize;

wire  [18:26]  df_jtagIsEa_NEG;

wire  [0:2]  wrLruIn;

wire  [0:2]  VaVbRdSel;

wire  [27:29]  df_cpuEa;

wire  [0:1]  icu_size_NEG;

wire  [0:2]  MMU_isCacheable;

wire  [0:29]  MMU_isRA;

wire  [0:1]  vcarspSe;

wire  [0:1]  plbLowSel;

wire  [0:1]  vcarsSel;

wire  [0:1]  rarsSel;

wire  [0:3]  dataCcSel;

wire  [0:1]  plbHighSel;

wire  [0:22]  diagBus;

wire  [18:26]  df_lruRdCcInNEG;

wire  [18:27]  df_dataCc;


wire            cycleParityRegIn;       // JRS 7-24-01 Added to icu_ram_data_flow_16K as enable for parity register.
                                        //      Gets latched in icu_ram_data_flow_16K before going to splitter.

wire            cycle_parity_p3_NEG;    // JRS 08-03-01 added as input signal for cycleParityRegIn
                                        //      generation logic.
wire icu_ocmICUReady_NEG;
wire compAlru_NEG;
wire compB_NEG;
wire cycleDataRegAIn;
wire cycleDataRegBIn;
wire cycleTagRegIn;
wire forceNlIn;
wire lxFetchValidIn;
wire lxSel;
wire missIn;
wire nxtFetchRd;
wire nxtWait;
wire rdStateIn;
wire vcarSelHi_NEG;
wire vcarSelLow_NEG;
wire vcarSel_pri_NEG;
wire VaVb_VR_pg4_NEG;
wire bufValidL2_NEG;
wire compareA;
wire compareA_NEG;
wire compareB;
wire compareB_NEG;
wire cycle_RA_p3_NEG;
wire cycle_RB_p3_NEG;
wire cycle_RT_p3_NEG;
wire eo_q;
wire eo_r;
wire eo_y_NEG;
wire eo_z2_NEG;
wire eo_z_NEG;
wire forceNl2;
wire frAndDsRdy;
wire ldcc2RdNoAb_NEG;
wire lxFetchValidIn_A_NEG;
wire lxFetchValidIn_B_NEG;
wire lxFetchValidL2;
wire lxSel_C_NEG;
wire lxSel_D_NEG;
wire missL2;
wire nfr_ABC_p2_NEG;
wire nxtWa_W_NEG;
wire nxtWa_X_NEG;
wire ocmDvQ_1_NEG;
wire rdOrWaAndXtlValid;
wire rdSt_RDA_pg4_NEG;
wire setForceNl;
wire tagSelBit0_E_NEG;
wire tagSelBit0_F_NEG;
wire vcarSel_noEO;
wire wrLruNoHit_NEG;
wire dsCompA;
wire dsCompB;
wire lruOut;
wire VaOut;
wire vbOut;
wire Lx27Sel;
wire LX28Sel;
wire Lx29Sel;
wire VaVbWrE1;
wire dataRdWrRegIn;
wire dsRD1cycle;
wire fillWr0L2;
wire lruRdCcE1;
wire newLruBitIn;
wire newVaBitIn;
wire newVbBitIn;
wire symNet703;
wire scL2;
wire tagBWE1;
wire tagRdWrRegIn;
wire vaQual;
wire vbQual;
wire wbLowE2;
wire wbTagE1;
wire wrATagNotB;
wire wrFlashIn;
wire wrVaIn;
wire wrVbIn;
wire ICU_CCR1ICTE;
wire ICU_CCR1ICDE;
wire df_forceOnly1Req;
wire df_ftchMissBlkWr;
wire df_nonC_8;
wire df_nonCpreFetchEn;
wire df_plb27L2;
wire df_plbaOverflow;
wire df_preFetchEnable;
wire df_rarsTLE;
wire df_selCCR0;
wire df_vcarVcarsCompare;
wire BufValidIn_NEG;
wire isU0AttrL2;
wire cdbdrE1;
wire dsRdMuxSel;
wire dsVcar1E2;
wire dsVcar2E2;
wire icuRdarE1;
wire icuRdarE2;
wire jtag2ndWr;
wire lruRdSel;
wire resetCoreL2;
wire tagVSel_0;
wire tagVSel_1;
wire vcarE2;
wire vcarInselL2;
wire vcarsCCE2;


p405s_icu_hitPath
 SDT_hitPathSch( 
     .BufValidIn_NEG(BufValidIn_NEG), 
     .ICU_mmuEoOdd(ICU_mmuEoOdd), 
     .ICU_ocmIcuReady_NEG(icu_ocmICUReady_NEG), 
     .VaVbRdSel(VaVbRdSel[0:2]),
     .compAlru_NEG(compAlru_NEG), 
     .compB_NEG(compB_NEG), 
     .cycleDataRegAIn(cycleDataRegAIn), 
     .cycleDataRegBIn(cycleDataRegBIn), 
     .cycleParityRegIn(cycleParityRegIn), 
     .cycleTagRegIn(cycleTagRegIn),
     .eo_0(ICU_EO[0]), 
     .eo_1(ICU_EO[1]), 
     .forceNlIn(forceNlIn), 
     .lxFetchValidIn(lxFetchValidIn), 
     .lxSel(lxSel), 
     .missIn(missIn), 
     .nxtFetchRd(nxtFetchRd), 
     .nxtWait(nxtWait), 
     .rdStateIn(rdStateIn),
     .tagVSel_0(tagVSel_0), 
     .vcarSelHi_NEG(vcarSelHi_NEG), 
     .vcarSelLow_NEG(vcarSelLow_NEG), 
     .vcarSel_pri_NEG(vcarSel_pri_NEG), 
     .wrLruIn(wrLruIn[0:2]), 
     .IFB_isAbort2(IFB_isAbort[2]),
     .IFB_isNL(IFB_isNL), 
     .OCM_isHold(OCM_isHold), 
     .VaVb_VR_pg4_NEG(VaVb_VR_pg4_NEG), 
     .bufValidL2_NEG(bufValidL2_NEG), 
     .compareA(compareA), 
     .compareA_NEG(compareA_NEG), 
     .compareB(compareB),
     .compareB_NEG(compareB_NEG), 
     .cycle_RA_p3_NEG(cycle_RA_p3_NEG), 
     .cycle_RB_p3_NEG(cycle_RB_p3_NEG), 
     .cycle_parity_p3_NEG(cycle_parity_p3_NEG), 
     .cycle_RT_p3_NEG(cycle_RT_p3_NEG), 
     .eo_q(eo_q), 
     .eo_r(eo_r),
     .eo_y_NEG(eo_y_NEG), 
     .eo_z2_NEG(eo_z2_NEG), 
     .eo_z_NEG(eo_z_NEG), 
     .forceNlL2(forceNl2), 
     .frAndDsRdy(frAndDsRdy), 
     .ldcc2RdNoAb_NEG(ldcc2RdNoAb_NEG), 
     .lxFetchValidIn_A_NEG(lxFetchValidIn_A_NEG),
     .lxFetchValidIn_B_NEG(lxFetchValidIn_B_NEG), 
     .lxFetchValidL2(lxFetchValidL2), 
     .lxSel_C_NEG(lxSel_C_NEG), 
     .lxSel_D_NEG(lxSel_D_NEG), 
     .missL2(missL2), 
     .nfr_ABC_p2_NEG(nfr_ABC_p2_NEG),
     .nxtWa_W_NEG(nxtWa_W_NEG), 
     .nxtWa_X_NEG(nxtWa_X_NEG), 
     .ocmDvQ_1_NEG(ocmDvQ_1_NEG), 
     .rdOrWaAndXltValid(rdOrWaAndXtlValid), 
     .rdSt_RDA_pg4_NEG(rdSt_RDA_pg4_NEG), 
     .setForceNl(setForceNl),
     .tagSelBit0_E_NEG(tagSelBit0_E_NEG), 
     .tagSelBit0_F_NEG(tagSelBit0_F_NEG), 
     .vcarSel_noEO(vcarSel_noEO), 
     .wrLruNoHit_NEG(wrLruNoHit_NEG));

// Removing module dp_logicICU_diag2Inv
//dp_logicICU_diag2Inv logicICU_diag2Inv(symNet249[0:22], ICU_diagBus[0:22]);
assign ICU_diagBus[0:22] = ~symNet249[0:22];

// Removing module dp_logicICU_diag1Inv
//dp_logicICU_diag1Inv logicICU_diag1Inv(diagBus[0:22], symNet249[0:22]);
assign symNet249[0:22] = ~diagBus[0:22];

// Removing module dp_logicICU_xltValidInv
//dp_logicICU_xltValidInv logicICU_xltValidInv(MMU_isXltValid, MMU_isXltValid_NEG);
wire MMU_isXltValid_NEG;
assign MMU_isXltValid_NEG = ~MMU_isXltValid;

// Removing module dp_logicICU_testEnInv
//dp_logicICU_testEnInv logicICU_testEnInv(testEn, testEn_NEG);
wire testEn_NEG;
assign testEn_NEG = ~testEn;

// Removing module dp_logicICU_iCacheWrInv
//dp_logicICU_iCacheWrInv logicICU_iCacheWrInv(JTG_iCacheWr_NEG, JTG_iCacheWr);
wire JTG_iCacheWr;
assign JTG_iCacheWr = ~JTG_iCacheWr_NEG;

// Removing module dp_logicICU_PrioInv
//dp_logicICU_PrioInv logicICU_PrioInv({DPP1_NEG, IPP0_NEG, IPP1_NEG}, {DCU_plbPriorityBit1,
//     ICU_plbPriority[0:1]});
wire DPP1_NEG;
wire IPP0_NEG;
wire IPP1_NEG;
assign {DCU_plbPriorityBit1, ICU_plbPriority[0:1]} = ~{DPP1_NEG, IPP0_NEG, IPP1_NEG};

// Removing module dp_logicICU_isCAinv
//dp_logicICU_isCAinv logicICU_isCAinv(MMU_isCacheableNEG[0:2], MMU_isCacheable[0:2]);
assign MMU_isCacheable[0:2] = ~MMU_isCacheableNEG[0:2];

// Removing module dp_logicICU_isRAinv
//dp_logicICU_isRAinv logicICU_isRAinv(MMU_isRANEG[0:29], MMU_isRA[0:29]);
assign MMU_isRA[0:29] = ~MMU_isRANEG[0:29];

p405s_icu_ram_data_flow_16K
 icuRamDataFlow(
     .ICU_isBus              (ICU_isBus[0:63]),
     .ICU_parityErrE         (ICU_parityErrE),
     .ICU_parityErrO         (ICU_parityErrO),
     .ICU_tagParityErr       (ICU_tagParityErr),
     .compareA               (compareA),
     .compareA_NEG           (compareA_NEG),
     .compareB               (compareB),
     .compareB_NEG           (compareB_NEG),
     .dsCompA                (dsCompA),
     .dsCompB                (dsCompB),
     .icReadData             (icreadData[0:31]),
     .icuCacheSize           (icuCacheSize[0:2]),
     .lruOut                 (lruOut),
     .vaOut                  (VaOut),
     .vbOut                  (vbOut),
     .CB                     (CB),
     .ICU_paritySel          (ICU_dcuCCR0_L2[11]),
     .ICU_baSel              (ICU_dcuCCR0_L2[10]),
     .ICU_tagDataSel         (ICU_dcuCCR0_L2[9]),
     .JTG_iCacheWr           (JTG_iCacheWr),
     .JTG_inst               (JTG_inst[0:31]),
     .Lx27Sel                (Lx27Sel),
     .Lx28Sel                (LX28Sel),
     .Lx29Sel                (Lx29Sel),
     .MMU_isCacheable        (MMU_isCacheable[0]),
     .MMU_isRA               (MMU_isRA[0:21]),
     .OCM_isData             (OCM_isDATA[0:63]),
     .PLB_icuDBus            (PLB_icuDBus[0:63]),
     .VaVbRdSel              (VaVbRdSel[0:2]),
     .VaVbWrE1               (VaVbWrE1),
     .cycleDataRegAIn        (cycleDataRegAIn),
     .cycleDataRegBIn        (cycleDataRegBIn),
     .cycleTagRegIn          (cycleTagRegIn),
     .cycleParityRegIn       (cycleParityRegIn),
     .dataRdWrRegIn          (dataRdWrRegIn),
     .df_dataCc              (df_dataCc[18:27]),
     .df_jtagIsEa_NEG        (df_jtagIsEa_NEG[18:26]),
     .df_lruRdCcInNEG        (df_lruRdCcInNEG[18:26]),
     .df_lruWrCcIn           (df_lruWrVCcIn[18:26]),
     .df_rars                (rars[0:21]),
     .df_rarsTLE             (df_rarsTLE),
     .df_tagVccRegIn         (df_tagVccRegInNeg[18:26]),
     .dsRD1cycle             (dsRD1cycle),
     .fillAE2                (fillAE2[0:7]),
     .fillBE2                (fillBE2[0:7]),
     .fillWr0L2              (fillWr0L2),
     .isBusSel               (isBusSel[0:1]),
     .lruRdCcE1              (lruRdCcE1),
     .newLruBitIn            (newLruBitIn),
     .newVaBitIn             (newVaBitIn),
     .newVbBitIn             (newVbBitIn),
     .rdStateL2              (symNet703),
     .rdar                   (df_rdar[0:29]),
     .scL2                   (scL2),
     .tagBWE1                (tagBWE1),
     .tagRdWrRegIn           (tagRdWrRegIn),
     .vaOutL2                (vaQual),
     .vbOutL2                (vbQual),
     .wbHighE2               (wbHighE2[0:3]),
     .wbLowE2                (wbLowE2),
     .wbTagE1                (wbTagE1),
     .wrATagNotB             (wrATagNotB),
     .wrFlashIn              (wrFlashIn),
     .wrLruIn                (wrLruIn[0:2]),
     .wrVaIn                 (wrVaIn),
     .wrVbIn                 (wrVbIn),
     .ICU_CCR1ICTE           (ICU_CCR1ICTE),
     .ICU_CCR1ICDE           (ICU_CCR1ICDE),
     .resetMemBist           (resetMemBist),
     .icu_bist_debug_si      (icu_bist_debug_si),
     .icu_bist_debug_so      (icu_bist_debug_so),
     .icu_bist_debug_en      (icu_bist_debug_en),
     .icu_bist_mode_reg_in   (icu_bist_mode_reg_in),
     .icu_bist_mode_reg_out  (icu_bist_mode_reg_out),
     .icu_bist_parallel_dr   (icu_bist_parallel_dr),
     .icu_bist_mode_reg_si   (icu_bist_mode_reg_si),
     .icu_bist_mode_reg_so   (icu_bist_mode_reg_so),
     .icu_bist_shift_dr      (icu_bist_shift_dr),
     .icu_bist_mbrun         (icu_bist_mbrun)
   );

// Removing module dp_logicICU_ioBufPLB1
//dp_logicICU_ioBufPLB1 logicICU_ioBufPLB1({icu_ABus_NEG[0:29], icu_U0Attr_NEG}, {ICU_ABus[0:29],
//     ICU_U0Attr});
wire icu_U0Attr_NEG;
assign {ICU_ABus[0:29], ICU_U0Attr} = ~{icu_ABus_NEG[0:29], icu_U0Attr_NEG};

// Removing module dp_logicICU_ioBufPLB
//dp_logicICU_ioBufPLB logicICU_ioBufPLB({icu_request_NEG, icu_size_NEG[0:1], icu_Abort_NEG,
//     icu_cacheable_NEG}, {ICU_request, ICU_tranSize[2:3], ICU_abort, ICU_cacheable});
wire icu_request_NEG;
wire icu_Abort_NEG;
wire icu_cacheable_NEG;
assign {ICU_request, ICU_tranSize[2:3], ICU_abort, ICU_cacheable} = ~{icu_request_NEG, icu_size_NEG[0:1], icu_Abort_NEG, icu_cacheable_NEG};

// Removing module dp_logicICU_ioBuf0CM
//dp_logicICU_ioBuf0CM logicICU_ioBuf0CM({icu_ocmReqPending_NEG, icu_ocmICUReady_NEG},
//     {ICU_ocmReqPending, ICU_ocmIcuReady});
wire icu_ocmReqPending_NEG;
assign {ICU_ocmReqPending, ICU_ocmIcuReady} = ~{icu_ocmReqPending_NEG, icu_ocmICUReady_NEG};

// Removing module dp_logicICU_aClk000
//dp_logicICU_aClk000 logicICU_aClk000(CB_buf[3], symNet341);

// Removing module dp_logicICU_aClk01
//dp_logicICU_aClk01 logicICU_aClk01(symNet341, a1);

// Removing module dp_logicICU_aClk00
//dp_logicICU_aClk00 logicICU_aClk00(symNet341, a0);

// Removing module icu_clkBuf
//icu_clkBuf I117( CB_buf[1:4], CB[1:4]);

p405s_icu_data_flow
 icuDataFlow( 
     .BlockFlush(ICU_dcuCCR0_L2[4]), 
     .Block_CAR(ICU_dcuCCR0_L2[0]), 
     .Block_COF(ICU_dcuCCR0_L2[3]),
     .Block_LSA(ICU_dcuCCR0_L2[1]), 
     .Block_SAQ(ICU_dcuCCR0_L2[2]), 
     .Block_mult_req(ICU_dcuCCR0_L2[5]), 
     .DPP1_NEG(DPP1_NEG), 
     .ICU_ABus_NEG(icu_ABus_NEG[0:29]),
     .ICU_CCR0DDK(ICU_CCR0DDK), 
     .ICU_GPRC(ICU_GPRC), 
     .ICU_LDBE(ICU_LDBE), 
     .ICU_U0Attr_NEG(icu_U0Attr_NEG), 
     .ICU_baSel(ICU_dcuCCR0_L2[10]), 
     .ICU_dcuLNC(ICU_dcuCCR0_L2[6]),
     .ICU_dcuLOA(ICU_dcuCCR0_L2[7]), 
     .ICU_dcuWOA(ICU_dcuCCR0_L2[8]), 
     .ICU_sprData(ICU_sprData[0:31]), 
     .ICU_tagDataSel(ICU_dcuCCR0_L2[9]), 
     .ICU_paritySel(ICU_dcuCCR0_L2[11]),
     .ICU_traceEnable(ICU_traceEnable), 
     .IPP0_NEG(IPP0_NEG), 
     .IPP1_NEG(IPP1_NEG), 
     .df_cpuEa(df_cpuEa[27:29]), 
     .df_dataCc(df_dataCc[18:27]), 
     .df_forceOnly1Req(df_forceOnly1Req),
     .df_ftchMissBlkWr(df_ftchMissBlkWr), 
     .df_jtagIsEa_NEG(df_jtagIsEa_NEG[18:26]), 
     .df_lruRdCcInNEG(df_lruRdCcInNEG[18:26]), 
     .df_lruWrCcIn(df_lruWrVCcIn[18:26]),
     .df_nonC_8(df_nonC_8), 
     .df_nonCpreFetchEn(df_nonCpreFetchEn), 
     .df_plb27L2(df_plb27L2), 
     .df_plbaOverflow(df_plbaOverflow), 
     .df_preFetchEnable(df_preFetchEnable), 
     .df_rars(rars[0:21]),
     .df_rarsTLE(df_rarsTLE), 
     .df_selCCR0(df_selCCR0), 
     .df_tagVccRegIn(df_tagVccRegInNeg[18:26]), 
     .df_vcarVcarsCompare(df_vcarVcarsCompare), 
     .rdar(df_rdar[0:29]),
     .CB(CB), 
     .DCU_icuSize(DCU_icuSize[0:2]), 
     .EXE_dsEA_NEG(EXE_dsEA_NEG[0:29]),
     .EXE_icuSprDcds(EXE_icuSprDcds[0:2]), 
     .EXE_sprData(EXE_sprData[0:31]), 
     .IFB_isEA(IFB_isEA[0:29]), 
     .MMU_dsEndianL2(MMU_dsEndianL2), 
     .MMU_dsU0AttrL2(MMU_dsU0AttrL2),
     .MMU_isEndian(MMU_isEndian), 
     .MMU_isRA(MMU_isRA[0:29]), 
     .MMU_isU0Attr(isU0AttrL2), 
     .MMU_rdarDsRAL2(MMU_rdarDsRAL2[0:29]), 
     .PCL_mfSPR(PCL_mfSPR), 
     .PCL_mtSPR(PCL_mtSPR),
     .PCL_sprHold(PCL_sprHold), 
     .cdbdrE1(cdbdrE1), 
     .dataCcSel(dataCcSel[0:3]), 
     .dsRdMuxSel(dsRdMuxSel), 
     .dsVcar1E2(dsVcar1E2), 
     .dsVcar2E2(dsVcar2E2), 
     .fillWr0L2(fillWr0L2),
     .icReadData(icreadData[0:31]), 
     .icuCacheSize(icuCacheSize[0:2]), 
     .icuRdarE1(icuRdarE1), 
     .icuRdarE2(icuRdarE2), 
     .jtag2ndWr(jtag2ndWr), 
     .lruRdSel(lruRdSel),
     .plbHighSel(plbHighSel[0:1]), 
     .plbLowSel(plbLowSel[0:1]), 
     .rarsSel(rarsSel[0:1]), 
     .resetCore(resetCoreL2), 
     .scL2(scL2), 
     .tagVSel({tagVSel_0, tagVSel_1}), 
     .vcarE2(vcarE2), 
     .vcarInSelL2(vcarInselL2), 
     .vcarSelHi_NEG(vcarSelHi_NEG), 
     .vcarSelLow_NEG(vcarSelLow_NEG), 
     .vcarsCCE2(vcarsCCE2),
     .vcarsSel(vcarsSel[0:1]), 
     .vcarspSel(vcarspSe[0:1]), 
     .VCT_msrIR(VCT_msrIR), 
     .ICU_CCR0DPE(ICU_CCR0DPE), 
     .ICU_CCR0DPP(ICU_CCR0DPP), 
     .ICU_CCR0IPE(ICU_CCR0IPE), 
     .ICU_CCR0TPE(ICU_CCR0TPE),
     .ICU_CCR1ICTE(ICU_CCR1ICTE), 
     .ICU_CCR1ICDE(ICU_CCR1ICDE),
     .ICU_CCR1DCTE(ICU_CCR1DCTE), 
     .ICU_CCR1DCDE(ICU_CCR1DCDE), 
     .ICU_CCR1TLBE(ICU_CCR1TLBE));

p405s_icu_PrControl
 icuControl(
     .ICU_request_NEG(icu_request_NEG), 
     .ICU_size_NEG(icu_size_NEG[0:1]), 
     .ICU_Abort_NEG(icu_Abort_NEG), 
     .ICU_cacheable_NEG(icu_cacheable_NEG),
     .ICU_ocmReqPending_NEG(icu_ocmReqPending_NEG), 
     .ICU_isCA(ICU_isCA), 
     .ICU_dsCA(ICU_dsCA), 
     .ICU_sleepReq(ICU_sleepReq), 
     .ICU_syncAfterReset(ICU_syncAfterReset),
     .ICU_ifbError(ICU_ifbError[0:1]), 
     .ICU_mmuRdarE2(ICU_mmuRdarE2), 
     .tagVSel_1(tagVSel_1), 
     .lruRdSel(lruRdSel), 
     .dataCcSel(dataCcSel[0:3]), 
     .plbLowSel(plbLowSel[0:1]),
     .plbHighSel(plbHighSel[0:1]), 
     .rarsSel(rarsSel[0:1]), 
     .vcarsSel(vcarsSel[0:1]), 
     .dsRdMuxSel(dsRdMuxSel), 
     .vcarE2(vcarE2), 
     .isU0AttrL2(isU0AttrL2), 
     .cdbdrE1(cdbdrE1),
     .fillWr0L2(fillWr0L2), 
     .vcarsCCE2(vcarsCCE2), 
     .vcarInSelL2(vcarInselL2), 
     .vcarspSel(vcarspSe[0:1]), 
     .icuRdarE1(icuRdarE1), 
     .icuRdarE2(icuRdarE2), 
     .dsVcar1E2(dsVcar1E2),
     .dsVcar2E2(dsVcar2E2), 
     .isBusSel(isBusSel[0:1]), 
     .Lx27Sel(Lx27Sel), 
     .Lx28Sel(LX28Sel), 
     .Lx29Sel(Lx29Sel), 
     .lruRdCcE1(lruRdCcE1), 
     .VaVbWrE1(VaVbWrE1), 
     .vcarSel_pri_NEG(vcarSel_pri_NEG),
     .tagBWE1(tagBWE1), 
     .wbHighE2(wbHighE2[0:3]), 
     .wbLowE2(wbLowE2), 
     .wbTagE1(wbTagE1), 
     .fillAE2(fillAE2[0:7]), 
     .fillBE2(fillBE2[0:7]), 
     .newLruBitIn(newLruBitIn), 
     .wrVaIn(wrVaIn),
     .newVaBitIn(newVaBitIn), 
     .wrVbIn(wrVbIn), 
     .newVbBitIn(newVbBitIn), 
     .dataRdWrRegIn(dataRdWrRegIn), 
     .tagRdWrRegIn(tagRdWrRegIn), 
     .wrATagNotB(wrATagNotB), 
     .vaOutL2(vaQual), 
     .vbOutL2(vbQual),
     .eo_y_NEG(eo_y_NEG), 
     .eo_z_NEG(eo_z_NEG), 
     .eo_r(eo_r), 
     .eo_q(eo_q), 
     .rdStateL2(symNet703), 
     .dsRD1cycle(dsRD1cycle), 
     .wrFlashIn(wrFlashIn), 
     .resetCore2L2(resetCoreL2), 
     .sc3L2(scL2),
     .jtag2ndWr(jtag2ndWr), 
     .diagBus(diagBus[0:22]), 
     .rdOrWaAndXltValid(rdOrWaAndXtlValid), 
     .frAndDsRdy(frAndDsRdy), 
     .cycle_RA_p3_NEG(cycle_RA_p3_NEG), 
     .cycle_RB_p3_NEG(cycle_RB_p3_NEG),
     .cycle_RT_p3_NEG(cycle_RT_p3_NEG), 
     .cycle_parity_p3_NEG(cycle_parity_p3_NEG), 
     .forceNlL2(forceNl2), 
     .setForceNl(setForceNl), 
     .rdSt_RDA_pg4_NEG(rdSt_RDA_pg4_NEG), 
     .VaVb_VR_pg4_NEG(VaVb_VR_pg4_NEG),
     .bufValidL2_NEG(bufValidL2_NEG), 
     .ldcc2RdNoAb_NEG(ldcc2RdNoAb_NEG), 
     .wrLruNoHit_NEG(wrLruNoHit_NEG), 
     .nfr_ABC_p2_NEG(nfr_ABC_p2_NEG), 
     .eo_z2_NEG(eo_z2_NEG),
     .lxFetchValidIn_A_NEG(lxFetchValidIn_A_NEG), 
     .lxFetchValidIn_B_NEG(lxFetchValidIn_B_NEG), 
     .lxSel_C_NEG(lxSel_C_NEG), 
     .lxSel_D_NEG(lxSel_D_NEG), 
     .lxFetchValidL2(lxFetchValidL2),
     .vcarSel_noEO(vcarSel_noEO), 
     .tagSelBit0_E_NEG(tagSelBit0_E_NEG), 
     .tagSelBit0_F_NEG(tagSelBit0_F_NEG), 
     .ocmDvQ_1_NEG(ocmDvQ_1_NEG), 
     .nxtWa_W_NEG(nxtWa_W_NEG), 
     .nxtWa_X_NEG(nxtWa_X_NEG),
     .missL2(missL2), 
     .PCL_mtSPR(PCL_mtSPR), 
     .PLB_icuAddrAck(PLB_icuAddrAck), 
     .PLB_icuRdDAck(PLB_icuRdDAck), 
     .PLB_icuError(PLB_icuError), 
     .PLB_icuBusy(PLB_icuBusy),
     .PLB_dcuBusy(PLB_dcuBusy), 
     .PLB_icuRdWrAddr(PLB_icuRdWdAddr[1:3]), 
     .PLB_sSize(PLB_sSize), 
     .PLB_sampleCycle(PLB_sampleCycle), 
     .OCM_isDValid(OCM_isDValid[0:1]),
     .OCM_isHold(OCM_isHold), 
     .IFB_fetchReq(IFB_fetchReq), 
     .df_cpuEa(df_cpuEa[27:29]), 
     .IFB_isNL(IFB_isNL), 
     .IFB_isAbort(IFB_isAbort[0:2]), 
     .IFB_icuCancelData(IFB_icuCancelData),
     .PCL_icuOp(PCL_icuOp[0:3]), 
     .VCT_icuWbAbort(VCT_icuWbAbort), 
     .VCT_exeAbort(VCT_exeAbort), 
     .IFB_cntxSync(IFB_cntxSync), 
     .MMU_isDsXltValidL2(MMU_isDsXltValidL2),
     .MMU_isDsCacheableL2(MMU_isDsCacheableL2), 
     .MMU_icuDsAbort(MMU_icuDsAbort), 
     .MMU_isXltValid_NEG(MMU_isXltValid_NEG), 
     .MMU_isCacheable(MMU_isCacheable[1:2]),
     .MMU_icuIsAbort(MMU_icuIsAbort), 
     .MMU_isU0Attr(MMU_isU0Attr), 
     .df_preFetchEnable(df_preFetchEnable), 
     .df_forceOnly1Req(df_forceOnly1Req), 
     .df_ftchMissBlkWr(df_ftchMissBlkWr),
     .df_nonC_8(df_nonC_8), 
     .df_nonCpreFetchEn(df_nonCpreFetchEn), 
     .df_plbaOverflow(df_plbaOverflow), 
     .df_vcarVcarsCompare(df_vcarVcarsCompare), 
     .df_plb27L2(df_plb27L2), 
     .compB_NEG(compB_NEG),
     .compAlru_NEG(compAlru_NEG), 
     .dsCompA(dsCompA), 
     .dsCompB(dsCompB), 
     .lruOut(lruOut), 
     .vaOut(VaOut), 
     .vbOut(vbOut), 
     .forceNlIn(forceNlIn), 
     .rdStateIn(rdStateIn), 
     .nxtFetchRd(nxtFetchRd),
     .lxSel(lxSel), 
     .lxFetchValidIn(lxFetchValidIn), 
     .nxtWait(nxtWait), 
     .bufValidIn_NEG(BufValidIn_NEG), 
     .df_selCCR0(df_selCCR0), 
     .JTG_iCacheWr(JTG_iCacheWr),
     .icuTagDataSel(ICU_dcuCCR0_L2[9]), 
     .icuBaSel(ICU_dcuCCR0_L2[10]), 
     .CB(CB), 
     .resetCoreIn(resetCoreIn),
     .testEn_NEG(testEn_NEG), 
     .missIn(missIn), 
     .PLB_sampleCycleAlt(PLB_sampleCycleAlt), 
     .CPM_c405SyncBypass(CPM_c405SyncBypass)
   );

// BDZ TRANSLATE_OFF
// synopsys translate_off
// Making assertions for violated assumptions
`ifdef ICU_MONITORS_OFF
`else
always@(posedge CB)
begin
  if((ICU_parityErrE || ICU_tagParityErr) && ICU_EO[0])
  begin
       $display("\nERROR:\n\tUnexpected parity error from the even word of ICU!");
       $display("\tIf expect ICU parity error must include empty ICUParityErrEn file in testcase directory.");
    #5 $finish;
  end
  if((ICU_parityErrO || ICU_tagParityErr) && ICU_EO[1])
  begin
       $display("\nERROR:\n\tUnexpected parity error from the odd word of ICU!");
       $display("\tIf expect ICU parity error must include empty ICUParityErrEn file in testcase directory.");
    #5 $finish;
  end
end
`endif
// synopsys translate_on
// BDZ TRANSLATE_ON

endmodule
