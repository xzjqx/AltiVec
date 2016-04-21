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

// change history
// JRS 08-03-01 added cycle signal for parity RAM (cycle_parity_p3_NEG)
//              same as A and B cycle signals except remove all lru and ba_sel references,
//                 must include those in bit enables since have to write parity array for either
//                 data array

module p405s_icu_PrControl(
                            ICU_request_NEG,
                            ICU_size_NEG,
                            ICU_Abort_NEG,
                            ICU_cacheable_NEG,
                            ICU_ocmReqPending_NEG,
                            ICU_isCA,
                            ICU_dsCA,
                            ICU_sleepReq,
                            ICU_syncAfterReset,
                            ICU_ifbError,
                            ICU_mmuRdarE2,
                            tagVSel_1,
                            lruRdSel,
                            dataCcSel,
                            plbLowSel,
                            plbHighSel,
                            rarsSel,
                            vcarsSel,
                            dsRdMuxSel,
                            vcarE2,
                            isU0AttrL2,
                            cdbdrE1,
                            fillWr0L2,
                            vcarsCCE2,
                            vcarInSelL2,
                            vcarspSel,
                            icuRdarE1,
                            icuRdarE2,
                            dsVcar1E2,
                            dsVcar2E2,
                            isBusSel,
                            Lx27Sel,
                            Lx28Sel,
                            Lx29Sel,
                            lruRdCcE1,
                            VaVbWrE1,
                            vcarSel_pri_NEG,
                            tagBWE1,
                            wbHighE2,
                            wbLowE2,
                            wbTagE1,
                            fillAE2,
                            fillBE2,
                            newLruBitIn,
                            wrVaIn,
                            newVaBitIn,
                            wrVbIn,
                            newVbBitIn,
                            dataRdWrRegIn,
                            tagRdWrRegIn,
                            wrATagNotB,
                            vaOutL2,
                            vbOutL2,
                            eo_y_NEG,
                            eo_z_NEG,
                            eo_r,
                            eo_q,
                            rdStateL2,
                            dsRD1cycle,
                            wrFlashIn,
                            resetCore2L2,
                            sc3L2,
                            jtag2ndWr,
                            diagBus,
                            rdOrWaAndXltValid,
                            frAndDsRdy,
                            cycle_RA_p3_NEG,
                            cycle_RB_p3_NEG,
                            cycle_RT_p3_NEG,
                            cycle_parity_p3_NEG,
                            forceNlL2,
                            setForceNl,
                            rdSt_RDA_pg4_NEG,
                            VaVb_VR_pg4_NEG,
                            bufValidL2_NEG,
                            ldcc2RdNoAb_NEG,
                            wrLruNoHit_NEG,
                            nfr_ABC_p2_NEG,
                            eo_z2_NEG,
                            lxFetchValidIn_A_NEG,
                            lxFetchValidIn_B_NEG,
                            lxSel_C_NEG,
                            lxSel_D_NEG,
                            lxFetchValidL2,
                            vcarSel_noEO,
                            tagSelBit0_E_NEG,
                            tagSelBit0_F_NEG,
                            ocmDvQ_1_NEG,
                            nxtWa_W_NEG,
                            nxtWa_X_NEG,
                            missL2,
                            PCL_mtSPR,
                            PLB_icuAddrAck,
                            PLB_icuRdDAck,
                            PLB_icuError,
                            PLB_icuBusy,
                            PLB_dcuBusy,
                            PLB_icuRdWrAddr,
                            PLB_sSize,
                            PLB_sampleCycle,
                            OCM_isDValid,
                            OCM_isHold,
                            IFB_fetchReq,
                            df_cpuEa,
                            IFB_isNL,
                            IFB_isAbort,
                            IFB_icuCancelData,
                            PCL_icuOp,
                            VCT_icuWbAbort,
                            VCT_exeAbort,
                            IFB_cntxSync,
                            MMU_isDsXltValidL2,
                            MMU_isDsCacheableL2,
                            MMU_icuDsAbort,
                            MMU_isXltValid_NEG,
                            MMU_isCacheable,
                            MMU_icuIsAbort,
                            MMU_isU0Attr,
                            df_preFetchEnable,
                            df_forceOnly1Req,
                            df_ftchMissBlkWr,
                            df_nonC_8,
                            df_nonCpreFetchEn,
                            df_plbaOverflow,
                            df_vcarVcarsCompare,
                            df_plb27L2,
                            compB_NEG,
                            compAlru_NEG,
                            dsCompA,
                            dsCompB,
                            lruOut,
                            vaOut,
                            vbOut,
                            forceNlIn,
                            rdStateIn,
                            nxtFetchRd,
                            lxSel,
                            lxFetchValidIn,
                            nxtWait,
                            bufValidIn_NEG,
                            df_selCCR0,
                            JTG_iCacheWr,
                            icuTagDataSel,
                            icuBaSel,
                            CB,
                            resetCoreIn,
                            testEn_NEG,
                            missIn,
                            PLB_sampleCycleAlt,
                            CPM_c405SyncBypass
                           );


//
//Page 2
///////////////////////// parameters /////////////////////////////////////////
parameter   iSideIdle = 2'b10 ;
parameter   iSideWa   = 2'b01 ;

parameter   dSideIdle = 3'b100 ;
parameter   dSideLdCc = 3'b010 ;
parameter   dSideRd   = 3'b001 ;

parameter   fillSmIdle = 6'b100000;
parameter   fillSmReq  = 6'b010000;
parameter   fillSmFill = 6'b001000;
parameter   fillSmWb   = 6'b000100;
parameter   fillSmWr0  = 6'b000010;
parameter   fillSmWr1  = 6'b000001;

parameter   preSmIdle = 5'b10000;
parameter   preSmRd   = 5'b01000;
parameter   preSmWfr  = 5'b00100;
parameter   preSmReq  = 5'b00010;
parameter   preSmWf   = 5'b00001;

parameter  jtag0 = 9'b100000000;
parameter  jtag1 = 9'b010000000;
parameter  jtag2 = 9'b001000000;
parameter  jtag3 = 9'b000100000;
parameter  jtag4 = 9'b000010000;
parameter  jtag5 = 9'b000001000;
parameter  jtag6 = 9'b000000100;
parameter  jtag7 = 9'b000000010;
parameter  jtag8 = 9'b000000001;



//
//                                                                        Page 3
///////////////////////// outputs /////////////////////////////////////////

// outputs of ICU
output ICU_request_NEG;
output ICU_Abort_NEG;
output ICU_cacheable_NEG;
output ICU_mmuRdarE2 ;
output ICU_ocmReqPending_NEG ;
output ICU_isCA;
output ICU_dsCA;
output ICU_sleepReq;
output ICU_syncAfterReset ;
output[0:1] ICU_size_NEG;
output[0:1] ICU_ifbError ;

// added for tbird
input PLB_sampleCycleAlt;
input CPM_c405SyncBypass;
// outputs to data flow
output[0:1] plbLowSel;
output[0:1] plbHighSel;
output[0:1] rarsSel;
output[0:1] vcarspSel ;
output[0:3] dataCcSel;
output[0:1] vcarsSel;
output tagVSel_1;
output lruRdSel;
output isU0AttrL2 ;
output vcarE2 ;
output fillWr0L2;
output cdbdrE1;
output resetCore2L2 ;
output newLruBitIn;
output wrVaIn;
output newVaBitIn;
output wrVbIn;
output newVbBitIn ;
output vcarsCCE2;
output dsRdMuxSel ;
output vcarInSelL2;
output icuRdarE1;
output icuRdarE2;
output dsVcar1E2;
output dsVcar2E2;

// ouputs to ram data flow
output[0:1]   isBusSel ;
output Lx27Sel;
output Lx28Sel;
output Lx29Sel ;
output tagBWE1 ;
output lruRdCcE1;
output VaVbWrE1;
output wbTagE1 ;
output[0:7] fillAE2;
output[0:7] fillBE2 ;
output[0:3] wbHighE2 ;
output dataRdWrRegIn ;
output tagRdWrRegIn;
output wrATagNotB;
output vaOutL2;
output vbOutL2;
output rdStateL2 ;
output wrFlashIn;
output sc3L2;
output dsRD1cycle;
output wbLowE2 ;
output eo_z_NEG;
output eo_y_NEG;
output eo_r;
output eo_q ;
output jtag2ndWr;

output rdOrWaAndXltValid;
output frAndDsRdy;
output cycle_RA_p3_NEG;
output cycle_RB_p3_NEG;
output cycle_RT_p3_NEG;
output cycle_parity_p3_NEG;
output forceNlL2;
output setForceNl;
output rdSt_RDA_pg4_NEG;
output VaVb_VR_pg4_NEG;
output bufValidL2_NEG;
output ldcc2RdNoAb_NEG;
output wrLruNoHit_NEG;
output lxFetchValidIn_A_NEG;
output lxFetchValidIn_B_NEG;
output lxSel_C_NEG;
output lxSel_D_NEG;
output vcarSel_noEO;
output nfr_ABC_p2_NEG;
output tagSelBit0_E_NEG;
output tagSelBit0_F_NEG;
output ocmDvQ_1_NEG;
output lxFetchValidL2;
output nxtWa_W_NEG;
output nxtWa_X_NEG;
output eo_z2_NEG;
output missL2;

// misc outputs
output[0:22]  diagBus ;

/////////////////////// inputs ///////////////////////////////////////////

input PLB_icuAddrAck;
input PLB_icuRdDAck;
input PLB_icuBusy;
input PLB_dcuBusy ;
input PLB_sSize;
input PLB_sampleCycle ;
input PLB_icuError ;
input[1:3]    PLB_icuRdWrAddr ;

input OCM_isHold ;
input[0:1]    OCM_isDValid ;

input IFB_fetchReq;
input IFB_isNL;
input IFB_icuCancelData ;
input[0:2]    IFB_isAbort;
input[27:29]  df_cpuEa ;
input VCT_icuWbAbort;
input VCT_exeAbort;
input IFB_cntxSync ;
input[0:3]    PCL_icuOp ;

input MMU_isDsXltValidL2;
input MMU_isDsCacheableL2;
input MMU_icuDsAbort ;
input MMU_isXltValid_NEG;
input MMU_icuIsAbort;
input MMU_isU0Attr ;
input[1:2]    MMU_isCacheable;

input df_preFetchEnable;
input df_forceOnly1Req;
input df_ftchMissBlkWr;
input df_nonC_8 ;
input df_nonCpreFetchEn;
input df_plbaOverflow;
input df_vcarVcarsCompare ;
input df_plb27L2;

input compAlru_NEG;
input dsCompA;
input dsCompB;
input lruOut;
input vaOut;
input vbOut ;
input df_selCCR0;
input JTG_iCacheWr;
input icuTagDataSel;
input icuBaSel;

input PCL_mtSPR;
input missIn;
input compB_NEG;
input testEn_NEG;
input resetCoreIn ;
input CB ;
input vcarSel_pri_NEG;

input forceNlIn;
input rdStateIn;
input nxtFetchRd;
input lxSel;
input lxFetchValidIn;
input nxtWait;
input bufValidIn_NEG;

//
//Page 4
/////////////////////// wires ///////////////////////////////////////////

wire ICU_isCA_i;
wire ICU_isCA;
wire ICU_dsCA_i;
wire ICU_dsCA;
wire[0:1] ICU_size_NEG_i;
wire[0:1] ICU_size_NEG;
wire[0:3] dataCcSel_i;
wire[0:3] dataCcSel;
wire vcarE2_i ;
wire vcarE2 ;
wire fillWr0L2_i;
wire resetCore2L2_i ;
wire icuRdarE1_i;
wire icuRdarE1;
wire icuRdarE2_i;
wire icuRdarE2;
wire dsVcar1E2_i;
wire dsVcar1E2;
wire dsVcar2E2_i;
wire dsVcar2E2;
reg [0:7] fillAE2_i;
wire rdStateL2_i ;
wire dsRD1cycle_i;
wire dsRD1cycle;
wire frAndDsRdy_i;
wire forceNlL2_i;
wire bufValidL2_NEG_i;
wire ocmDvQ_1_NEG_i;
wire lxFetchValidL2_i;
wire eo_z2_NEG_i;
wire missL2_i;
wire        fillBlkRd, fillBlkDs, priwait4XltV, syncAfterResetIn ;
wire        fetchIdle, fetchRdL2, fetchWaL2, dsIdleL2, dsLdCcL2, dsRdL2 ;
wire        fillIdleL2, fillReqL2, fillFillL2, fillWbL2, fillWr0L2 ;
wire        fillWr1L2, halfFull, full, filling ;
wire        preIdleL2, preRdL2, preWfrL2, preReqL2, preWfL2 ;
wire        evenBypdL2, evenBypdIn, setevenBypd, resetevenBypd ;
wire        setForceNl, forceNlIn, forceNlL2 ;
wire        lxFetchValidL2 ;
reg         err0L2, err1L2, err2L2, err3L2, err4L2, err5L2, err6L2, err7L2 ;
wire        valid0L2, valid1L2, valid2L2, valid3L2 ;
wire        valid4L2, valid5L2, valid6L2, valid7L2 ;
wire        valid0In, valid1In, valid2In, valid3In ;
wire        valid4In, valid5In, valid6In, valid7In ;
wire        rarsCaL2, plbaCaL2_NEG, plba2CaL2,  fillLruL2 ;
wire        acceptL2, plbAbort2L2, resetValidBits ;
wire        plbaCaIn, rarsCaL2In, rarsCaQ, rars27Q ;
wire        dsHit, dsMiss, ocmDv_1_NEG ;
wire        priFtchL2, priIcbtL2, priIcbiL2, priIccciL2, priIcReadL2 ;
wire        priIcbtIn, priIcbiIn, priIccciIn, priIcReadIn ;
wire        prifetchIn, vcarIcbtIn, vcarIcbiIn, vcarIccciIn, vcarIcReadIn ;
wire        scL2, sc2L2, sc3L2, savedAbort, plbaFetchIn, plbaFtchL2;
wire        icuRequestIn, plbAbort2In, saveAbortIn, dsVcar1FullInv, dsVcar2FullInv ;
wire        dsNeedsFill, fetchNeedsFill, plbSize, turnOff ;
reg [27:29] lxL2 ;
wire[0:1]   sizeIn ;
wire        anyPlbError;
wire        fetchReqState;
wire        int_isCA, vcarsValidIn, vcarsValidL2, fillTakingPre ;
wire        rars27In, rars27L2, rarsFetchIn, rarsFetchL2, vcarVcarsCompAndValid ;
wire        timeForRequestNoScL2, timeForRequestScL2 ;
wire        bufValidL2, bufValidL2_NEG, bit27Eq, ocm_EO, eo_r ;
wire        rdStateL2, vaOutL2, vbOutL2 ;
wire        vcarspFullL2, vcarspFullIn, vcarspValidIn, vcarspValidL2 ;
wire        vcarsp27L2, vcarsp27In, vcarspFtchIn, vcarspFtchL2 ;
wire        resetCore2In, syncAfterResetL2, syncAfterReset2L2, eo_z2_NEG, ocmDvQ_0, ocmDvQ_1 ;
wire        fillTakingPreAdd, preSizeE1, preSizeL2, fillSizeL2, fillSizeSel ;
wire        sizeSel, icuRequest2L2, fillSizeIn, icu_Abort, ocmDvQ_1_NEG ;
wire[0:7]   fillBE2, errorSel, setValidIn ;
wire[0:1]   bypEO;
wire        ignoreAB1L2, ignoreAB2L2, ignoreAB1In, ignoreAB2In;
wire        dsVcar1FullL2, dsVcar2FullL2, dsVcar1FullIn, dsVcar2FullIn;
wire        ldcc2RdNoAb, anyCacheOp, vaNotpreRd, vbNotpreRd;
wire        vcar1IcbtL2, vcar1IcbiL2, vcar1IccciL2, vcar1IcReadL2;
wire        vcar2IcbtL2, vcar2IcbiL2, vcar2IccciL2, vcar2IcReadL2;
wire        frAndDsRdy ;
wire        selectRars, vdd, gnd, priIsDsCacheableL2;
wire        vcarspGate, plbLowGate, plbHighGate, vcarsRarsGate, isXltValid;
wire       jtagE1, jtagWrTag, jtagWrVa, jtagWrVb, errE1, cdAbortIn ;
wire       jtagWrData0, jtagWrData1, jtagWrData2, jtagWrData3 ;
wire       isXltValidL2, isAbortL2, isCacheableL2, isHoldL2, vcarVcarsCompareL2;
wire       cdAbortL2, missL2, timeForRequestNoScL2L2, resetCore2L2, resetCoreL2 ;
wire       wrLruNoHit;
wire[0:8]  jtagL2;
/////////////////////// regs ////////////////////////////////////////////
reg         bypEO_0, bypEO_1;
reg[0:2]    nxtStDs ;
reg[0:4]    nxtStPre ;
reg[0:5]    nxtStFill ;
wire[0:7]    fillAE2 ;
reg[0:8]    nxtStJtag ;
reg         goingToPreRd;

////////////////////////////////////////////////////////////////////////////////

assign ICU_dsCA = ICU_dsCA_i;
assign ICU_isCA = ICU_isCA_i;
assign ICU_size_NEG = ICU_size_NEG_i;
assign dataCcSel = dataCcSel_i;
assign vcarE2 = vcarE2_i;
assign fillWr0L2 = fillWr0L2_i;
assign resetCore2L2 = resetCore2L2_i;
assign icuRdarE1 = icuRdarE1_i;
assign icuRdarE2 = icuRdarE2_i;
assign dsVcar1E2 = dsVcar1E2_i;
assign dsVcar2E2 = dsVcar2E2_i;
assign fillAE2 = fillAE2_i;
assign rdStateL2 = rdStateL2_i;
assign dsRD1cycle = dsRD1cycle_i;
assign frAndDsRdy = frAndDsRdy_i;
assign forceNlL2 = forceNlL2_i;
assign bufValidL2_NEG = bufValidL2_NEG_i;
assign ocmDvQ_1_NEG = ocmDvQ_1_NEG_i;
assign lxFetchValidL2 = lxFetchValidL2_i;
assign eo_z2_NEG = eo_z2_NEG_i;
assign missL2 = missL2_i;
assign rdOrWaAndXltValid = (fetchRdL2 | fetchWaL2) & isXltValid ;

assign nfr_ABC_p2_NEG = ~((dsIdleL2 & ~fillBlkRd & fetchIdle & forceNlL2_i &
                         ((lxFetchValidL2_i & ~bypEO[1] & ~ocmDvQ_1) |
                         (~anyCacheOp & IFB_fetchReq))) |
                         (frAndDsRdy_i & IFB_isNL & ~lxFetchValidL2_i) |
                         (frAndDsRdy_i & IFB_isNL & ocmDvQ_1) |
                         (frAndDsRdy_i & IFB_isNL & MMU_icuIsAbort) |
                         (frAndDsRdy_i & IFB_icuCancelData & IFB_isNL)) ;

assign cycle_RA_p3_NEG = ~((fillWbL2 & ~priwait4XltV & ~lruOut) |
                         (fillWr0L2_i & ~fillLruL2) |
                         ldcc2RdNoAb |
                          (jtagWrData3 & ~icuBaSel)) ;

assign cycle_RB_p3_NEG = ~((fillWbL2 & ~priwait4XltV & lruOut) |
                         (fillWr0L2_i & fillLruL2) |
                         ldcc2RdNoAb |
                         (jtagWrData3 & icuBaSel)) ;

// JRS 08-03-01 added cycle signal for parity RAM (cycle_parity_p3_NEG)
//              same as A and B cycle signals except remove all lru and ba_sel references,
//                 must include those in bit enables since have to write parity array for either
//                 data array
assign cycle_parity_p3_NEG = ~((fillWbL2 & ~priwait4XltV) |
                               fillWr0L2_i |
                               ldcc2RdNoAb |
                               jtagWrData3) ;

assign cycle_RT_p3_NEG = ~(fillWr0L2_i | ldcc2RdNoAb | jtagWrTag |
                           goingToPreRd) ;

assign rdSt_RDA_pg4_NEG = ~(goingToPreRd | ldcc2RdNoAb | (dsRdL2 & dsRD1cycle_i)) ;

assign VaVb_VR_pg4_NEG = ~( (dsLdCcL2 & ~fillBlkDs) |
                           (fillIdleL2 & preIdleL2 & ~fetchIdle &
                           (df_preFetchEnable | df_nonCpreFetchEn))) ;

assign ldcc2RdNoAb_NEG = ~ldcc2RdNoAb ;

assign wrLruNoHit_NEG = ~wrLruNoHit;

assign lxFetchValidIn_A_NEG = ~((lxFetchValidL2_i & ~(MMU_icuIsAbort | IFB_icuCancelData)) |
                              (((~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) &
                                ~fillBlkRd & dsIdleL2) & IFB_fetchReq) &
                               (~lxFetchValidL2_i | IFB_icuCancelData)));

assign lxFetchValidIn_B_NEG = ~((~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) &
                           ~fillBlkRd & dsIdleL2) & IFB_fetchReq);

assign lxSel_C_NEG = ~((((~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) &
                           ~fillBlkRd & dsIdleL2) & IFB_fetchReq) &
                       (~lxFetchValidL2_i | IFB_icuCancelData)) |
                        (dsLdCcL2 & ~fillBlkRd));

assign lxSel_D_NEG = ~(((~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) &
                                ~fillBlkRd & dsIdleL2) & IFB_fetchReq) |
                       (dsLdCcL2 & ~fillBlkRd));

assign tagSelBit0_F_NEG = ~(dsLdCcL2 | fillWr0L2_i );

assign tagSelBit0_E_NEG = ~((~fillBlkRd & fetchIdle & forceNlL2_i &
                             ~IFB_icuCancelData & lxFetchValidL2_i) |
                            dsLdCcL2 | fillWr0L2_i);

assign nxtWa_W_NEG = ~((fetchRdL2 | fetchWaL2) &
                       ((~MMU_icuIsAbort & ~isXltValid & ~IFB_icuCancelData) |
                       (~MMU_icuIsAbort & ~isXltValid & ~anyCacheOp &
                       ~forceNlL2_i & ~IFB_isNL) |
                       (( ~MMU_icuIsAbort & isXltValid &
                         ~(timeForRequestScL2 & isXltValidL2 & fetchWaL2) & ~forceNlL2_i &
                         (~vcarVcarsCompAndValid | (~bit27Eq & ~MMU_isCacheable[1]) |
                         (MMU_isCacheable[1] & ~rarsCaL2))) &
                        (~IFB_icuCancelData | (~anyCacheOp & ~IFB_isNL)))));

assign nxtWa_X_NEG = ~((fetchRdL2 | fetchWaL2) &
                     ((~MMU_icuIsAbort & ~isXltValid & ~IFB_icuCancelData) |
                      (~MMU_icuIsAbort & ~isXltValid & ~anyCacheOp &
                      ~forceNlL2_i & ~IFB_isNL))) ;


//
//                                                                        Page 5
////////////////// registers ///////////////////////////////////////////////////////

// Removing module dp_regICU_err0
//dp_regICU_err0 regICU_err0( .L2(err0L2),
//                            .E1(errE1),
//                            .D0(err0L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[0]),
//                            .I(scanin),
//                            .SO(scan1),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err0_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err0L2 or PLB_icuError)
    begin
    casez(errorSel[0])
     1'b0: regICU_err0_DataIn = err0L2 & ~syncAfterResetL2;
     1'b1: regICU_err0_DataIn = PLB_icuError;
      default: regICU_err0_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err0L2 <= regICU_err0_DataIn;
   end

// Removing module dp_regICU_err1
//dp_regICU_err1 regICU_err1( .L2(err1L2),
//                            .E1(errE1),
//                            .D0(err1L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[1]),
//                            .I(scan1),
//                            .SO(scan2),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err1_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err1L2 or PLB_icuError)
    begin
    casez(errorSel[1])
     1'b0: regICU_err1_DataIn = err1L2 & ~syncAfterResetL2;
     1'b1: regICU_err1_DataIn = PLB_icuError;
      default: regICU_err1_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err1L2 <= regICU_err1_DataIn;
   end

// Removing module dp_regICU_err2
//dp_regICU_err2 regICU_err2( .L2(err2L2),
//                            .E1(errE1),
//                            .D0(err2L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[2]),
//                            .I(scan2),
//                            .SO(scan3),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err2_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err2L2 or PLB_icuError)
    begin
    casez(errorSel[2])
     1'b0: regICU_err2_DataIn = err2L2 & ~syncAfterResetL2;
     1'b1: regICU_err2_DataIn = PLB_icuError;
      default: regICU_err2_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err2L2 <= regICU_err2_DataIn;
   end

// Removing module dp_regICU_err3
//dp_regICU_err3 regICU_err3( .L2(err3L2),
//                            .E1(errE1),
//                            .D0(err3L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[3]),
//                            .I(scan3),
//                            .SO(scan4),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err3_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err3L2 or PLB_icuError)
    begin
    casez(errorSel[3])
     1'b0: regICU_err3_DataIn = err3L2 & ~syncAfterResetL2;
     1'b1: regICU_err3_DataIn = PLB_icuError;
      default: regICU_err3_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err3L2 <= regICU_err3_DataIn;
   end

// Removing module dp_regICU_err4
//dp_regICU_err4 regICU_err4( .L2(err4L2),
//                            .E1(errE1),
//                            .D0(err4L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[4]),
//                            .I(scan4),
//                            .SO(scan5),
//                            .CB(CB[0:4]) ) ;
//
//Page 6
////////////////////////// registers ////////////////////////////////////////


   reg regICU_err4_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err4L2 or PLB_icuError)
    begin
    casez(errorSel[4])
     1'b0: regICU_err4_DataIn = err4L2 & ~syncAfterResetL2;
     1'b1: regICU_err4_DataIn = PLB_icuError;
      default: regICU_err4_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err4L2 <= regICU_err4_DataIn;
   end

// Removing module dp_regICU_err5
//dp_regICU_err5 regICU_err5( .L2(err5L2),
//                            .E1(errE1),
//                            .D0(err5L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[5]),
//                            .I(scan5),
//                            .SO(scan6),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err5_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err5L2 or PLB_icuError)
    begin
    casez(errorSel[5])
     1'b0: regICU_err5_DataIn = err5L2 & ~syncAfterResetL2;
     1'b1: regICU_err5_DataIn = PLB_icuError;
      default: regICU_err5_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err5L2 <= regICU_err5_DataIn;
   end

// Removing module dp_regICU_err6
//dp_regICU_err6 regICU_err6( .L2(err6L2),
//                            .E1(errE1),
//                            .D0(err6L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[6]),
//                            .I(scan6),
//                            .SO(scan7),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err6_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err6L2 or PLB_icuError)
    begin
    casez(errorSel[6])
     1'b0: regICU_err6_DataIn = err6L2 & ~syncAfterResetL2;
     1'b1: regICU_err6_DataIn = PLB_icuError;
      default: regICU_err6_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err6L2 <= regICU_err6_DataIn;
   end

// Removing module dp_regICU_err7
//dp_regICU_err7 regICU_err7( .L2(err7L2),
//                            .E1(errE1),
//                            .D0(err7L2 & ~syncAfterResetL2),
//                            .D1(PLB_icuError),
//                            .SD(errorSel[7]),
//                            .I(scan7),
//                            .SO(scan8),
//                            .CB(CB[0:4]) ) ;

   reg regICU_err7_DataIn;

   // 2-1 Mux input to register
   always @(errorSel or syncAfterResetL2 or err7L2 or PLB_icuError)
    begin
    casez(errorSel[7])
     1'b0: regICU_err7_DataIn = err7L2 & ~syncAfterResetL2;
     1'b1: regICU_err7_DataIn = PLB_icuError;
      default: regICU_err7_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (errE1)
      err7L2 <= regICU_err7_DataIn;
   end

// Removing module dp_regICU_valid0
//dp_regICU_valid0 regICU_valid0( .L2({valid0L2, valid1L2, valid2L2, valid3L2,
//                                    valid4L2, valid5L2, valid6L2, valid7L2}),
//                                .E1(resetCore2L2 | ~fillIdleL2 | ~fetchIdle | dsRdL2),
//                                .D({valid0In, valid1In, valid2In, valid3In,
//                                   valid4In, valid5In, valid6In, valid7In}),
//                                .I(scan8),
//                                .SO(scan9),
//                                .CB(CB[0:4]) ) ;

   wire       regICU_valid0_E1;
   reg  [0:7] regICU_valid0_L2;
   assign     regICU_valid0_E1 = resetCore2L2_i | ~fillIdleL2 | ~fetchIdle | dsRdL2;

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_valid0_E1)
      regICU_valid0_L2 <= {valid0In, valid1In, valid2In, valid3In, valid4In, valid5In, valid6In, valid7In};
   end

   assign {valid0L2, valid1L2, valid2L2, valid3L2, valid4L2, valid5L2, valid6L2, valid7L2} = regICU_valid0_L2[0:7];


//
//                                                                        Page 7
////////////////////////// registers ////////////////////////////////////////

// Removing module dp_regICU_lx
//dp_regICU_lx regICU_lx (.L2(lxL2[27:29]),
//                        .E2(vcarE2),
//                        .SD(lxSel),
//                        .D0(lxL2[27:29]),
//                        .D1(df_cpuEa[27:29]),
//                        .I(scan9),
//                        .SO(scan17),
//                        .CB(CB[0:4]) ) ;

   reg [0:2] regICU_lx_DataIn;

   // 2-1 Mux input to register
   always @(lxSel or lxL2 or df_cpuEa)
    begin
    casez(lxSel)
     1'b0: regICU_lx_DataIn = lxL2[27:29];
     1'b1: regICU_lx_DataIn = df_cpuEa[27:29];
      default: regICU_lx_DataIn = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (vcarE2_i)
      lxL2[27:29] <= regICU_lx_DataIn;
   end

// Removing module dp_regICU_Pri
//dp_regICU_Pri  regICU_Pri( .L2({priFtchL2, priIcbtL2, priIcbiL2,
//                                priIccciL2, priIcReadL2}),
//                           .D1({priFtchL2, priIcbtL2, priIcbiL2,
//                                priIccciL2, priIcReadL2}),
//                           .D0({prifetchIn, priIcbtIn, priIcbiIn,
//                                priIccciIn, priIcReadIn}),
//                           .SD(vcarSel_pri_NEG),
//                           .E2(vcarE2),
//                           .I(scan17),
//                           .SO(scan18),
//                           .CB(CB[0:4]) ) ;

   reg [0:4] regICU_Pri_DataIn;
   reg [0:4] regICU_Pri_L2;
   wire [0:4] regICU_Pri_D0;
   wire [0:4] regICU_Pri_D1;

   assign regICU_Pri_D0 = {prifetchIn, priIcbtIn, priIcbiIn, priIccciIn, priIcReadIn};
   assign regICU_Pri_D1 = {priFtchL2, priIcbtL2, priIcbiL2, priIccciL2, priIcReadL2};

   // 2-1 Mux input to register
   always @(vcarSel_pri_NEG or regICU_Pri_D0 or regICU_Pri_D1)
    begin
    casez(vcarSel_pri_NEG)
     1'b0: regICU_Pri_DataIn[0:4] = regICU_Pri_D0[0:4];
     1'b1: regICU_Pri_DataIn[0:4] = regICU_Pri_D1[0:4];
      default: regICU_Pri_DataIn[0:4] = 5'bx;
    endcase
   end
   // L2 Output modeled as pose[0:4]dge FF
   always @(posedge CB)
    begin
    if (vcarE2_i)
      regICU_Pri_L2[0:4] <= regICU_Pri_DataIn[0:4];
   end

   assign {priFtchL2, priIcbtL2, priIcbiL2, priIccciL2, priIcReadL2} = regICU_Pri_L2[0:4];

// Removing module dp_regICU_size
//dp_regICU_size regICU_size( .L2({ICU_size_NEG[0:1],plbaCaL2_NEG, plba2CaL2, plbaFtchL2}),
//                            .E1(sc2L2 & (dsRdL2 | ~fetchIdle)),
//                            .SD(plbHighGate),
//                            .D0({ICU_size_NEG[0:1],plbaCaL2_NEG, plba2CaL2, plbaFtchL2}),
//                            .D1({~sizeIn[0:1],~plbaCaIn, plbaCaIn, plbaFetchIn}),
//                            .I(scan18),
//                            .SO(scan19),
//                            .CB(CB[0:4]) ) ;

   reg [0:4] regICU_size_DataIn;
   reg [0:4] regICU_size_L2;
   wire       regICU_size_E1;
   wire [0:4] regICU_size_D0;
   wire [0:4] regICU_size_D1;

   assign regICU_size_E1 = sc2L2 & (dsRdL2 | ~fetchIdle);
   assign regICU_size_D0 = {ICU_size_NEG_i[0:1],plbaCaL2_NEG, plba2CaL2, plbaFtchL2};
   assign regICU_size_D1 = {~sizeIn[0:1],~plbaCaIn, plbaCaIn, plbaFetchIn};

   // 2-1 Mux input to register
   always @(plbHighGate or regICU_size_D0 or regICU_size_D1)
    begin
    casez(plbHighGate)
     1'b0: regICU_size_DataIn[0:4] = regICU_size_D0[0:4];
     1'b1: regICU_size_DataIn[0:4] = regICU_size_D1[0:4];
      default: regICU_size_DataIn[0:4] = 5'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_size_E1)
      regICU_size_L2[0:4] <= regICU_size_DataIn[0:4];
   end

   assign {ICU_size_NEG_i[0:1],plbaCaL2_NEG, plba2CaL2, plbaFtchL2} = regICU_size_L2[0:4];

// Removing module dp_regICU_g2Gate
//dp_regICU_g2Gate regICU_g2Gate( .L2({acceptL2,icu_Abort,plbAbort2L2}),
//                                .E1(sc2L2),
//                                .D({PLB_icuAddrAck,plbAbort2In, plbAbort2In}),
//                                .I(scan19),
//                                .SO(scan20),
//                                .CB(CB[0:4]) ) ;


   reg [0:2] regICU_g2Gate_L2;
   wire       regICU_g2Gate_E1;
   wire [0:2] regICU_g2Gate_D;

   assign regICU_g2Gate_E1 = sc2L2;
   assign regICU_g2Gate_D  = {PLB_icuAddrAck,plbAbort2In, plbAbort2In};

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_g2Gate_E1)
      regICU_g2Gate_L2[0:2] <= regICU_g2Gate_D[0:2];
   end

   assign {acceptL2,icu_Abort,plbAbort2L2} = regICU_g2Gate_L2[0:2];

// Removing module dp_regICU_rdarCa
//dp_regICU_rdarCa regICU_rdarCa( .L2(priIsDsCacheableL2),
//                                .E1(icuRdarE1),
//                                .E2(icuRdarE2),
//                                .D(MMU_isDsCacheableL2),
//                                .I(scan20),
//                                .SO(scan21),
//                                .CB(CB[0:4]) ) ;

   reg   regICU_rdarCa_L2;
   wire  regICU_rdarCa_E1;
   wire  regICU_rdarCa_D;

   assign regICU_rdarCa_E1 = icuRdarE1_i & icuRdarE2_i;
   assign regICU_rdarCa_D  = MMU_isDsCacheableL2;

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_rdarCa_E1)
      regICU_rdarCa_L2 <= regICU_rdarCa_D;
   end

   assign priIsDsCacheableL2 = regICU_rdarCa_L2;

// Removing module dp_regICU_rarsCa
//dp_regICU_rarsCa regICU_rarsCa( .L2({rarsCaL2, rars27L2, rarsFetchL2}),
//                                    .E1(preWfL2 | ~fetchIdle | dsRdL2 | resetCore2L2),
//                                    .SD(vcarsRarsGate),
//                                    .D0({rarsCaL2, rars27L2, rarsFetchL2}),
//                                    .D1({rarsCaL2In, rars27In, rarsFetchIn}),
//                                    .I(scan21),
//                                    .SO(scan23),
//                                    .CB(CB[0:4]) ) ;

   reg [0:2]  regICU_rarsCa_DataIn;
   reg [0:2]  regICU_rarsCa_L2;
   wire       regICU_rarsCa_E1;
   wire       regICU_rarsCa_SD;
   wire [0:2] regICU_rarsCa_D0;
   wire [0:2] regICU_rarsCa_D1;

   assign regICU_rarsCa_E1 = (preWfL2 | ~fetchIdle | dsRdL2 | resetCore2L2_i);
   assign regICU_rarsCa_SD = vcarsRarsGate;
   assign regICU_rarsCa_D0 = {rarsCaL2, rars27L2, rarsFetchL2};
   assign regICU_rarsCa_D1 = {rarsCaL2In, rars27In, rarsFetchIn};

   // 2-1 Mux input to register
   always @(regICU_rarsCa_SD or regICU_rarsCa_D0 or regICU_rarsCa_D1)
    begin
    casez(regICU_rarsCa_SD)
     1'b0: regICU_rarsCa_DataIn[0:2] = regICU_rarsCa_D0[0:2];
     1'b1: regICU_rarsCa_DataIn[0:2] = regICU_rarsCa_D1[0:2];
      default: regICU_rarsCa_DataIn[0:2] = 3'bxxx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_rarsCa_E1)
      regICU_rarsCa_L2[0:2] <= regICU_rarsCa_DataIn[0:2];
   end

   assign {rarsCaL2, rars27L2, rarsFetchL2} = regICU_rarsCa_L2[0:2];

//
//Page 8
/////////////////////////////// registers //////////////////////////////////////
// Removing module dp_regICU_fetchWaSm
//dp_regICU_fetchWaSm  regICU_fetchWaSm( .L2(fetchWaL2),
//                                       .D1(nxtWait),
//                                       .D0(gnd),
//                                       .SD(~(resetCoreL2 | IFB_isAbort[0])),
//                                       .I(scan23),
//                                       .SO(scan24),
//                                       .CB(CB[0:4]) ) ;

   reg   regICU_fetchWaSm_DataIn;
   reg   regICU_fetchWaSm_L2;
   wire  regICU_fetchWaSm_SD;
   wire  regICU_fetchWaSm_D0;
   wire  regICU_fetchWaSm_D1;

   assign regICU_fetchWaSm_SD = ~(resetCoreL2 | IFB_isAbort[0]);
   assign regICU_fetchWaSm_D0 = gnd;
   assign regICU_fetchWaSm_D1 = nxtWait;

   // 2-1 Mux input to register
   always @(regICU_fetchWaSm_SD or regICU_fetchWaSm_D0 or regICU_fetchWaSm_D1)
    begin
    casez(regICU_fetchWaSm_SD)
     1'b0: regICU_fetchWaSm_DataIn = regICU_fetchWaSm_D0;
     1'b1: regICU_fetchWaSm_DataIn = regICU_fetchWaSm_D1;
      default: regICU_fetchWaSm_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_fetchWaSm_L2 <= regICU_fetchWaSm_DataIn;
   end

   assign fetchWaL2 = regICU_fetchWaSm_L2;

// Removing module regICU_fetchSm
//dp_regICU_fetchSm  regICU_fetchSm( .L2(fetchRdL2),
//                                   .D0(nxtFetchRd),
//                                   .D1(gnd),
//                                   .SD(resetCoreL2),
//                                   .I(scan24),
//                                   .SO(scan25),
//                                   .CB(CB[0:4]) ) ;


   reg   regICU_fetchSm_DataIn;
   reg   regICU_fetchSm_L2;
   wire  regICU_fetchSm_SD;
   wire  regICU_fetchSm_D0;
   wire  regICU_fetchSm_D1;

   assign regICU_fetchSm_SD = resetCoreL2;
   assign regICU_fetchSm_D0 = nxtFetchRd;
   assign regICU_fetchSm_D1 = gnd;

   // 2-1 Mux input to register
   always @(regICU_fetchSm_SD or regICU_fetchSm_D0 or regICU_fetchSm_D1)
    begin
    casez(regICU_fetchSm_SD)
     1'b0: regICU_fetchSm_DataIn = regICU_fetchSm_D0;
     1'b1: regICU_fetchSm_DataIn = regICU_fetchSm_D1;
      default: regICU_fetchSm_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_fetchSm_L2 <= regICU_fetchSm_DataIn;
   end

   assign fetchRdL2 = regICU_fetchSm_L2;

// Removing module dp_regICU_dsSm
//dp_regICU_dsSm  regICU_dsSm( .L2({dsIdleL2, dsLdCcL2, dsRdL2}),
//                             .D0(nxtStDs[0:2]),
//                             .D1({vdd,gnd,gnd}),
//                             .SD(resetCoreL2),
//                             .I(scan25),
//                             .SO(scan26),
//                             .CB(CB[0:4]) ) ;

   reg   [0:2] regICU_dsSm_DataIn;
   reg   [0:2] regICU_dsSm_L2;
   wire  regICU_dsSm_SD;
   wire  [0:2] regICU_dsSm_D0;
   wire  [0:2] regICU_dsSm_D1;

   assign regICU_dsSm_SD = resetCoreL2;
   assign regICU_dsSm_D0 = nxtStDs[0:2];
   assign regICU_dsSm_D1 = {vdd,gnd,gnd};

   // 2-1 Mux input to register
   always @(regICU_dsSm_SD or regICU_dsSm_D0 or regICU_dsSm_D1)
    begin
    casez(regICU_dsSm_SD)
     1'b0: regICU_dsSm_DataIn[0:2] = regICU_dsSm_D0[0:2];
     1'b1: regICU_dsSm_DataIn[0:2] = regICU_dsSm_D1[0:2];
      default: regICU_dsSm_DataIn[0:2] = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_dsSm_L2[0:2] <= regICU_dsSm_DataIn[0:2];
   end

   assign {dsIdleL2, dsLdCcL2, dsRdL2} = regICU_dsSm_L2[0:2];

// Removing module dp_regICU_fillSm
//dp_regICU_fillSm  regICU_fillSm( .L2({fillIdleL2, fillReqL2, fillFillL2, fillWbL2,
//                                      fillWr0L2, fillWr1L2}),
//                                 .D0(nxtStFill[0:5]),
//                                 .D1({vdd,gnd,gnd,gnd,gnd,gnd}),
//                                 .SD(resetCoreL2),
//                                 .I(scan26),
//                                 .SO(scan27),
//                                 .CB(CB[0:4]) ) ;

   reg   [0:5] regICU_fillSm_DataIn;
   reg   [0:5] regICU_fillSm_L2;
   wire  regICU_fillSm_SD;
   wire  [0:5] regICU_fillSm_D0;
   wire  [0:5] regICU_fillSm_D1;

   assign regICU_fillSm_SD = resetCoreL2;
   assign regICU_fillSm_D0 = nxtStFill[0:5];
   assign regICU_fillSm_D1 = {vdd,gnd,gnd,gnd,gnd,gnd};

   // 2-1 Mux input to register
   always @(regICU_fillSm_SD or regICU_fillSm_D0 or regICU_fillSm_D1)
    begin
    casez(regICU_fillSm_SD)
     1'b0: regICU_fillSm_DataIn[0:5] = regICU_fillSm_D0[0:5];
     1'b1: regICU_fillSm_DataIn[0:5] = regICU_fillSm_D1[0:5];
      default: regICU_fillSm_DataIn[0:5] = 6'bxxxxxx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_fillSm_L2[0:5] <= regICU_fillSm_DataIn[0:5];
   end

   assign {fillIdleL2, fillReqL2, fillFillL2, fillWbL2, fillWr0L2_i, fillWr1L2} = regICU_fillSm_L2[0:5];

// Removing module dp_regICU_preSm
//dp_regICU_preSm  regICU_preSm( .L2({preIdleL2, preRdL2, preWfrL2, preReqL2, preWfL2}),
//                               .D0(nxtStPre[0:4]),
//                               .D1({vdd,gnd,gnd,gnd,gnd}),
//                               .SD(resetCoreL2),
//                               .I(scan27),
//                               .SO(scan28),
//                               .CB(CB[0:4]) ) ;

   reg   [0:4] regICU_preSm_DataIn;
   reg   [0:4] regICU_preSm_L2;
   wire  regICU_preSm_SD;
   wire  [0:4] regICU_preSm_D0;
   wire  [0:4] regICU_preSm_D1;

   assign regICU_preSm_SD = resetCoreL2;
   assign regICU_preSm_D0 = nxtStPre[0:4];
   assign regICU_preSm_D1 = {vdd,gnd,gnd,gnd,gnd};

   // 2-1 Mux input to register
   always @(regICU_preSm_SD or regICU_preSm_D0 or regICU_preSm_D1)
    begin
    casez(regICU_preSm_SD)
     1'b0: regICU_preSm_DataIn[0:4] = regICU_preSm_D0[0:4];
     1'b1: regICU_preSm_DataIn[0:4] = regICU_preSm_D1[0:4];
      default: regICU_preSm_DataIn[0:4] = 5'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_preSm_L2[0:4] <= regICU_preSm_DataIn[0:4];
   end

   assign {preIdleL2, preRdL2, preWfrL2, preReqL2, preWfL2} = regICU_preSm_L2[0:4];

// Removing module dp_logicICU_vcarFullInv
//dp_logicICU_vcarFullInv logicICU_vcarFullInv( .Z({dsVcar1FullL2, dsVcar2FullL2}),
//                                              .A({dsVcar1FullInv, dsVcar2FullInv}));

   assign {dsVcar1FullL2, dsVcar2FullL2} = ~{dsVcar1FullInv, dsVcar2FullInv};

assign bufValidL2 = ~bufValidL2_NEG_i;

wire isAbortOLDL2;
assign isAbortL2 = isAbortOLDL2 | IFB_cntxSync;

// Removing module dp_regICU_noGate
//dp_regICU_noGate regICU_noGate( .L2({forceNlL2, lxFetchValidL2,
//                                     savedAbort,
//                                     evenBypdL2, ignoreAB1L2, ignoreAB2L2,
//                                     dsVcar1FullInv, dsVcar2FullInv,
//                                     vcarsValidL2,
//                                     rdStateL2,bufValidL2_NEG,
//                                     vcarspFullL2,vcarsp27L2,vcarspFtchL2,
//                                     vcarspValidL2,dsRD1cycle,
//                                     isXltValidL2,isAbortOLDL2, isCacheableL2,
//                                     isHoldL2, isU0AttrL2,vcarVcarsCompareL2,
//                                     timeForRequestNoScL2L2, cdAbortL2, missL2}),
//                                .D0({forceNlIn, lxFetchValidIn,
//                                    saveAbortIn,
//                                    evenBypdIn, ignoreAB1In, ignoreAB2In,
//                                    dsVcar1FullIn, dsVcar2FullIn,
//                                    vcarsValidIn,
//                                    rdStateIn, bufValidIn_NEG,
//                                    vcarspFullIn,vcarsp27In,vcarspFtchIn,
//                                    vcarspValidIn,ldcc2RdNoAb,
//                                    isXltValid, IFB_isAbort[2], MMU_isCacheable[2],
//                                    OCM_isHold, MMU_isU0Attr, df_vcarVcarsCompare,
//                                    1'b1, cdAbortIn , missIn}),
//                                .D1({{6{gnd}},{2{vdd}},{17{gnd}}}),
//                                .SD(resetCoreL2),
//                                .I(scan28),
//                                .SO(scan29),
//                                .CB(CB[0:4]) ) ;

   reg   [0:24] regICU_noGate_DataIn;
   reg   [0:24] regICU_noGate_L2;
   wire  regICU_noGate_SD;
   wire  [0:24] regICU_noGate_D0;
   wire  [0:24] regICU_noGate_D1;

   assign regICU_noGate_SD = resetCoreL2;
   assign regICU_noGate_D0 = {forceNlIn, lxFetchValidIn, 
                              saveAbortIn, 
                              evenBypdIn, ignoreAB1In, ignoreAB2In, 
                              dsVcar1FullIn, dsVcar2FullIn, 
                              vcarsValidIn, 
                              rdStateIn, bufValidIn_NEG, 
                              vcarspFullIn,vcarsp27In,vcarspFtchIn, 
                              vcarspValidIn,ldcc2RdNoAb, 
                              isXltValid, IFB_isAbort[2], MMU_isCacheable[2], 
                              OCM_isHold, MMU_isU0Attr, df_vcarVcarsCompare,
                              1'b1, cdAbortIn , missIn};
   assign regICU_noGate_D1 =  {{6{gnd}},{2{vdd}},{17{gnd}}};

   // 2-1 Mux input to register
   always @(regICU_noGate_SD or regICU_noGate_D0 or regICU_noGate_D1)
    begin
    casez(regICU_noGate_SD)
     1'b0: regICU_noGate_DataIn[0:24] = regICU_noGate_D0[0:24];
     1'b1: regICU_noGate_DataIn[0:24] = regICU_noGate_D1[0:24];
      default: regICU_noGate_DataIn[0:24] = 25'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_noGate_L2[0:24] <= regICU_noGate_DataIn[0:24];
   end

   assign {forceNlL2_i, lxFetchValidL2_i,
           savedAbort,
           evenBypdL2, ignoreAB1L2, ignoreAB2L2,
           dsVcar1FullInv, dsVcar2FullInv,
           vcarsValidL2,
           rdStateL2_i,bufValidL2_NEG_i,
           vcarspFullL2,vcarsp27L2,vcarspFtchL2,
           vcarspValidL2,dsRD1cycle_i,
           isXltValidL2,isAbortOLDL2, isCacheableL2,
           isHoldL2, isU0AttrL2,vcarVcarsCompareL2,
           timeForRequestNoScL2L2, cdAbortL2, missL2_i} = regICU_noGate_L2[0:24];

//
//                                                                        Page 9
///////////////////////////////////registers////////////////////////////////////

// Removing module dp_regICU_validBits
//dp_regICU_validBits regICU_validBits( .L2({vaOutL2, vbOutL2}),
//                                      .E1(rdStateL2),
//                                      .D({vaNotpreRd,vbNotpreRd}),
//                                      .I(scan29),
//                                      .SO(scan30),
//                                      .CB(CB[0:4]) ) ;

   reg  [0:1] regICU_validBits_L2;
   wire       regICU_validBits_E1;
   wire [0:1] regICU_validBits_D;

   assign regICU_validBits_E1 = rdStateL2_i;
   assign regICU_validBits_D  = {vaNotpreRd,vbNotpreRd};

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_validBits_E1)
      regICU_validBits_L2[0:1] <= regICU_validBits_D[0:1];
   end

   assign {vaOutL2, vbOutL2} = regICU_validBits_L2[0:1];

// Removing module dp_regICU_icuRequest
//dp_regICU_icuRequest regICU_icuRequest( .L2({ICU_request_NEG,icuRequest2L2}),
//                                        .E1(sc2L2),
//                                        .D0({~icuRequestIn,icuRequestIn}),
//                                        .D1({vdd,turnOff}),
//                                        .SD(PLB_icuAddrAck),
//                                        .I(scan30),
//                                        .SO(scan31),
//                                        .CB(CB[0:4]) ) ;

   reg  [0:1] regICU_icuRequest_DataIn;
   reg  [0:1] regICU_icuRequest_L2;
   wire       regICU_icuRequest_E1;
   wire       regICU_icuRequest_SD;
   wire [0:1] regICU_icuRequest_D0;
   wire [0:1] regICU_icuRequest_D1;

   assign regICU_icuRequest_E1 = sc2L2;
   assign regICU_icuRequest_SD = PLB_icuAddrAck;
   assign regICU_icuRequest_D0 = {~icuRequestIn,icuRequestIn};
   assign regICU_icuRequest_D1 = {vdd,turnOff};

   // 2-1 Mux input to register
   always @(regICU_icuRequest_SD or regICU_icuRequest_D0 or regICU_icuRequest_D1)
    begin
    casez(regICU_icuRequest_SD)
     1'b0: regICU_icuRequest_DataIn[0:1] = regICU_icuRequest_D0[0:1];
     1'b1: regICU_icuRequest_DataIn[0:1] = regICU_icuRequest_D1[0:1];
      default: regICU_icuRequest_DataIn[0:1] = 2'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_icuRequest_E1)
      regICU_icuRequest_L2[0:1] <= regICU_icuRequest_DataIn[0:1];
   end

   assign {ICU_request_NEG,icuRequest2L2} = regICU_icuRequest_L2[0:1];

// rlg - 07/16/02 - for byron, we are added a second sample cycle signal that is 
//                   fed in after the latch.
//dp_regICU_reset regICU_reset( .L2({resetCoreL2, resetCore2L2, syncAfterResetL2,
//                                   syncAfterReset2L2, scL2,
//                                    sc2L2,sc3L2}),
//                              .D({resetCore2In, resetCore2In, syncAfterResetIn,
//                                   syncAfterResetIn, PLB_sampleCycle,
//                                    PLB_sampleCycle, PLB_sampleCycle}),
//                              .I(scan31),
//                              .SO(scan33),
//                              .CB(CB[0:4]) ) ;

wire scL2prime,sc2L2prime,sc3L2prime;
assign scL2 = scL2prime | PLB_sampleCycleAlt | ~CPM_c405SyncBypass;
assign sc2L2 = sc2L2prime | PLB_sampleCycleAlt | ~CPM_c405SyncBypass;
assign sc3L2 = sc3L2prime | PLB_sampleCycleAlt | ~CPM_c405SyncBypass;

// Removing module dp_regICU_reset
//dp_regICU_reset regICU_reset( .L2({resetCoreL2, resetCore2L2, syncAfterResetL2,
//                                   syncAfterReset2L2, scL2prime,
//                                    sc2L2prime,sc3L2prime}),
//                              .D({resetCore2In, resetCore2In, syncAfterResetIn,
//                                   syncAfterResetIn, PLB_sampleCycle,
//                                    PLB_sampleCycle, PLB_sampleCycle}),
//                              .I(scan31),
//                              .SO(scan33),
//                              .CB(CB[0:4]) ) ;

   reg  [0:6] regICU_reset_L2;
   wire [0:6] regICU_reset_D;

   assign regICU_reset_D = {resetCore2In, resetCore2In, syncAfterResetIn, syncAfterResetIn, PLB_sampleCycle, PLB_sampleCycle, PLB_sampleCycle};

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regICU_reset_L2[0:6] <= regICU_reset_D[0:6];
   end

   assign {resetCoreL2, resetCore2L2_i, syncAfterResetL2, syncAfterReset2L2, scL2prime, sc2L2prime,sc3L2prime} = regICU_reset_L2[0:6];


// Removing module regICU_fillLru
//dp_regICU_fillLru regICU_fillLru( .L2(fillLruL2),
//                                  .E1(fillWbL2),
//                                  .D(lruOut),
//                                  .I(scan33),
//                                  .SO(scan34),
//                                  .CB(CB[0:4]) ) ;

   reg   regICU_fillLru_L2;
   wire  regICU_fillLru_E1;
   wire  regICU_fillLru_D;

   assign regICU_fillLru_E1 = fillWbL2;
   assign regICU_fillLru_D  = lruOut;

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_fillLru_E1)
      regICU_fillLru_L2 <= regICU_fillLru_D;
   end

   assign fillLruL2 = regICU_fillLru_L2;

// Removing module regICU_preSize
//dp_regICU_preSize regICU_preSize( .L2(preSizeL2),
//                                  .E1(preSizeE1),
//                                  .D(PLB_sSize),
//                                  .I(scan34),
//                                  .SO(scan35),
//                                  .CB(CB[0:4]) ) ;

   reg   regICU_preSize_L2;
   wire  regICU_preSize_E1;
   wire  regICU_preSize_D;

   assign regICU_preSize_E1 = preSizeE1;
   assign regICU_preSize_D  = PLB_sSize;

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_preSize_E1)
      regICU_preSize_L2 <= regICU_preSize_D;
   end

   assign preSizeL2 = regICU_preSize_L2;

// Removing module regICU_fillSize
//dp_regICU_fillSize regICU_fillSize( .L2(fillSizeL2),
//                                    .E1(preWfL2 | fillReqL2),
//                                    .SD(fillSizeSel),
//                                    .D0(fillSizeL2),
//                                    .D1(fillSizeIn),
//                                    .I(scan35),
//                                    .SO(scan36),
//                                    .CB(CB[0:4]) ) ;

   reg  regICU_fillSize_DataIn;
   reg  regICU_fillSize_L2;
   wire regICU_fillSize_E1;
   wire regICU_fillSize_SD;
   wire regICU_fillSize_D0;
   wire regICU_fillSize_D1;

   assign regICU_fillSize_E1 = preWfL2 | fillReqL2;
   assign regICU_fillSize_SD = fillSizeSel;
   assign regICU_fillSize_D0 = fillSizeL2;
   assign regICU_fillSize_D1 = fillSizeIn;

   // 2-1 Mux input to register
   always @(regICU_fillSize_SD or regICU_fillSize_D0 or regICU_fillSize_D1)
    begin
    casez(regICU_fillSize_SD)
     1'b0: regICU_fillSize_DataIn = regICU_fillSize_D0;
     1'b1: regICU_fillSize_DataIn = regICU_fillSize_D1;
      default: regICU_fillSize_DataIn = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_fillSize_E1)
      regICU_fillSize_L2 <= regICU_fillSize_DataIn;
   end

   assign fillSizeL2 = regICU_fillSize_L2;

//
//Page 10
/////////////////////////////// registers //////////////////////////////////////

// Removing module dp_regICU_vcar1Ops
//dp_regICU_vcar1Ops  regICU_vcar1Ops( .L2({vcar1IcbtL2, vcar1IcbiL2,
//                                          vcar1IccciL2, vcar1IcReadL2}),
//                                     .E2(dsVcar1E2),
//                                     .D({vcarIcbtIn, vcarIcbiIn,
//                                         vcarIccciIn, vcarIcReadIn}),
//                                     .I(scan36),
//                                     .SO(scan37),
//                                     .CB(CB[0:4]) ) ;

   reg  [0:3] regICU_vcar1Ops_L2;
   wire       regICU_vcar1Ops_E2;
   wire [0:3] regICU_vcar1Ops_D;

   assign regICU_vcar1Ops_E2 = dsVcar1E2_i;
   assign regICU_vcar1Ops_D[0:3]  = {vcarIcbtIn, vcarIcbiIn, vcarIccciIn, vcarIcReadIn};

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_vcar1Ops_E2)
      regICU_vcar1Ops_L2[0:3] <= regICU_vcar1Ops_D[0:3];
   end

   assign {vcar1IcbtL2, vcar1IcbiL2, vcar1IccciL2, vcar1IcReadL2} = regICU_vcar1Ops_L2[0:3];

// Removing module dp_regICU_vcar2Ops
//dp_regICU_vcar2Ops  regICU_vcar2Ops( .L2({vcar2IcbtL2, vcar2IcbiL2,
//                                          vcar2IccciL2, vcar2IcReadL2}),
//                                     .E2(dsVcar2E2),
//                                     .D({vcarIcbtIn, vcarIcbiIn,
//                                         vcarIccciIn, vcarIcReadIn}),
//                                     .I(scan37),
//                                     .SO(scan38),
//                                     .CB(CB[0:4]) ) ;

   reg  [0:3] regICU_vcar2Ops_L2;
   wire       regICU_vcar2Ops_E2;
   wire [0:3] regICU_vcar2Ops_D;

   assign regICU_vcar2Ops_E2 = dsVcar2E2_i;
   assign regICU_vcar2Ops_D[0:3]  = {vcarIcbtIn, vcarIcbiIn, vcarIccciIn, vcarIcReadIn};

   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_vcar2Ops_E2)
      regICU_vcar2Ops_L2[0:3] <= regICU_vcar2Ops_D[0:3];
   end

   assign {vcar2IcbtL2, vcar2IcbiL2, vcar2IccciL2, vcar2IcReadL2} = regICU_vcar2Ops_L2[0:3];

// Removing module dp_regICU_jtagSm
//dp_regICU_jtagSm regICU_jtagSm(.L2(jtagL2[0:8]),
//                               .D0(nxtStJtag[0:8]),
//                               .D1({vdd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd}),
//                               .SD(df_selCCR0 | resetCoreL2),
//                               .E1(jtagE1),
//                               .I(scan38),
//                               .SO(scanout),
//                               .CB(CB[0:4]));

   reg  [0:8] regICU_jtagSm_DataIn;
   reg  [0:8] regICU_jtagSm_L2;
   wire       regICU_jtagSm_E1;
   wire       regICU_jtagSm_SD;
   wire [0:8] regICU_jtagSm_D0;
   wire [0:8] regICU_jtagSm_D1;

   assign regICU_jtagSm_E1 = jtagE1;
   assign regICU_jtagSm_SD = df_selCCR0 | resetCoreL2;
   assign regICU_jtagSm_D0[0:8] = nxtStJtag[0:8];
   assign regICU_jtagSm_D1[0:8] = {vdd,gnd,gnd,gnd,gnd,gnd,gnd,gnd,gnd};

   // 2-1 Mux input to register
   always @(regICU_jtagSm_SD or regICU_jtagSm_D0 or regICU_jtagSm_D1)
    begin
    casez(regICU_jtagSm_SD)
     1'b0: regICU_jtagSm_DataIn[0:8] = regICU_jtagSm_D0[0:8];
     1'b1: regICU_jtagSm_DataIn[0:8] = regICU_jtagSm_D1[0:8];
      default: regICU_jtagSm_DataIn[0:8] = 9'bxxxxxxxxx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    if (regICU_jtagSm_E1)
      regICU_jtagSm_L2[0:8] <= regICU_jtagSm_DataIn[0:8];
   end

   assign jtagL2[0:8] = regICU_jtagSm_L2[0:8];

//
//                                                                        Page 11
/////////////////////// start new ds logic /////////////////////////////////////

assign diagBus[0:22] = {icuRequest2L2,ICU_isCA_i,ICU_dsCA_i,fetchRdL2,fetchWaL2,
                        dsIdleL2, dsLdCcL2, dsRdL2,fillIdleL2, fillReqL2,
                        fillFillL2, fillWbL2,fillWr0L2_i, fillWr1L2,
                        preIdleL2, preRdL2, preWfrL2, preReqL2, preWfL2,
                        lxFetchValidL2_i,dsVcar1FullL2, dsVcar2FullL2,evenBypdL2};

assign vdd = 1'b1;
assign gnd = 1'b0;

assign vcarInSelL2 = dsVcar1FullL2;

assign dsRdMuxSel = dsLdCcL2 & ~fillBlkDs;

assign dsVcar1E2_i = dsIdleL2 & ~dsVcar1FullL2 & ~dsVcar2FullL2 & PCL_icuOp[0];
assign dsVcar2E2_i = dsIdleL2 & dsVcar1FullL2 & ~dsVcar2FullL2 & PCL_icuOp[0];

assign ignoreAB1In = (ignoreAB1L2 & ~(dsLdCcL2 & ~fillBlkDs)) |
                     (~ignoreAB1L2 & dsVcar1FullL2 & MMU_isDsXltValidL2 &
                      ~VCT_icuWbAbort & ~(dsLdCcL2 & ~fillBlkDs));

assign ignoreAB2In = (ignoreAB2L2 & dsVcar1FullL2) |
                     (ignoreAB2L2 & ~dsLdCcL2) |
                     (dsVcar1FullL2 & dsVcar2FullL2 & MMU_isDsXltValidL2 &
                      ~VCT_icuWbAbort) |
                     (~dsLdCcL2 & dsVcar2FullL2 & MMU_isDsXltValidL2 &
                      ~VCT_icuWbAbort) |
                     (ignoreAB2L2 & ~dsVcar1FullL2 & fillBlkDs) |
                     (dsVcar2FullL2 & MMU_isDsXltValidL2 & ~VCT_icuWbAbort &
                      fillBlkDs) ;

            // 1 wait for xltV
            // 2 in dsIdleL2 or wait for fill
            // 3 in dsIdleL2 or wait for fill
            // 4 new cmd
assign dsVcar1FullIn = ~((dsVcar1FullL2 & ~ignoreAB1L2 & ~MMU_isDsXltValidL2 &
                        ~VCT_icuWbAbort & ~MMU_icuDsAbort) |
                       (dsVcar1FullL2 & ~ignoreAB1L2 & MMU_isDsXltValidL2 &
                        ~VCT_icuWbAbort & ~(dsLdCcL2 & ~fillBlkDs)) |
                       (dsVcar1FullL2 & ignoreAB1L2 & ~(dsLdCcL2 & ~fillBlkDs)) |
                       (dsIdleL2 & ~dsVcar1FullL2 & ~dsVcar2FullL2 &
                        ~VCT_exeAbort & ~VCT_icuWbAbort & PCL_icuOp[0])) ;
//
//Page 12
/////////////////////////////new ds logic/////////////////////////////////////////

              // 1 dsVcar2 availiable for new op[0] getting XltV for 1
              // 2 dsVcar2 availiable for new op[0] already received XltV
              // 3 hold full2 on waiting for XltV
              // 4 hold full2 getting XltV
              // 5 both full waiting to turn off ignore1 and full1
              // 6 in Ldcc waitng for XltV
              // 7 in Ldcc receiving XltV waiting for FBDS to go away
              // 8 in Ldcc received XltV waiting for FBDS to go away
              // 9 in rd and dsVcar2FullL2
assign dsVcar2FullIn = ~((dsIdleL2 & dsVcar1FullL2 & ~ignoreAB1L2 & ~dsVcar2FullL2 &
                        MMU_isDsXltValidL2 & ~VCT_exeAbort &
                        ~VCT_icuWbAbort & PCL_icuOp[0]) |
                       (dsIdleL2 & dsVcar1FullL2 & ignoreAB1L2 & ~dsVcar2FullL2 &
                        ~VCT_exeAbort & ~VCT_icuWbAbort & PCL_icuOp[0]) |
                       (dsVcar2FullL2 & ~ignoreAB2L2 &
                        ~MMU_isDsXltValidL2 & ~VCT_icuWbAbort & ~MMU_icuDsAbort) |
                       (dsIdleL2 & dsVcar2FullL2 & ~ignoreAB2L2 &
                        MMU_isDsXltValidL2 & ~VCT_icuWbAbort) |
                       (dsIdleL2 & dsVcar2FullL2 & ignoreAB2L2) |
                       (dsVcar1FullL2 & dsVcar2FullL2 & ~ignoreAB2L2 &
                        MMU_isDsXltValidL2 & ~VCT_icuWbAbort) |
                       (dsVcar2FullL2 & ~ignoreAB2L2 &
                        MMU_isDsXltValidL2 & ~VCT_icuWbAbort & fillBlkDs) |
                       (dsVcar2FullL2 & ignoreAB2L2 & fillBlkDs) |
                       (dsVcar1FullL2 & dsVcar2FullL2 & ignoreAB2L2) |
                       (dsRdL2 & dsVcar2FullL2 & ignoreAB2L2) |
                       (dsRdL2 & dsVcar2FullL2 & ~ignoreAB2L2 & MMU_isDsXltValidL2 &
                        ~VCT_icuWbAbort));

assign ICU_mmuRdarE2 = (dsVcar1FullL2 & ~ignoreAB1L2 & ~MMU_isDsXltValidL2) |
                       (dsVcar2FullL2 & ~ignoreAB2L2 & ~MMU_isDsXltValidL2) |
                       (PCL_icuOp[0] & dsIdleL2 & ~dsVcar2FullL2);



assign ldcc2RdNoAb = dsLdCcL2 & ~fillBlkDs & (MMU_isDsXltValidL2 | ignoreAB1L2 | ignoreAB2L2);

// 04/14/99 assign icuRdarE1 = dsVcar1FullL2 | dsVcar2FullL2 ;
assign icuRdarE1_i = ~(dsVcar1FullInv & dsVcar2FullInv) ;
assign icuRdarE2_i = (ldcc2RdNoAb & ~(dsVcar1FullL2 & dsVcar2FullL2)) |
                   (MMU_isDsXltValidL2 & dsIdleL2 & dsVcar1FullL2 & ~ignoreAB1L2);



//
//                                                                        Page 13
/////////////////////// start logic ////////////////////////////////////////////

assign isXltValid = ~MMU_isXltValid_NEG;

assign cdAbortIn = IFB_icuCancelData & (IFB_isNL | anyCacheOp) ;

assign errE1 = sc2L2 & ((~fillIdleL2 & ~fillReqL2) | syncAfterReset2L2);

assign fetchIdle = ~(fetchWaL2 | fetchRdL2) ;

//assign vaNotpreRd = vaOut & ~preRdL2 ;
//assign vbNotpreRd = vbOut & ~preRdL2 ;
assign vaNotpreRd = vaOut & (dsRdL2 | fetchRdL2) ;
assign vbNotpreRd = vbOut & (dsRdL2 | fetchRdL2) ;

assign ocmDvQ_0 = OCM_isDValid[0] & isXltValid ;

// Removing module dp_logicICU_ocmDVInv
//dp_logicICU_ocmDVInv logicICU_ocmDVInv( .Z(ocmDv_1_NEG),
//                                        .A(OCM_isDValid[1]));

   assign ocmDv_1_NEG = ~(OCM_isDValid[1]);

//nor
// Removing module dp_logicICU_ocmDV1
//dp_logicICU_ocmDV1 logicICU_ocmDV1( .Z(ocmDvQ_1),
//                                    .A(ocmDv_1_NEG),
//                                    .B(~isXltValid));

   assign ocmDvQ_1 = ~( ocmDv_1_NEG | ~isXltValid );

//or
// Removing module dp_logicICU_ocmDV
//dp_logicICU_ocmDV logicICU_ocmDV( .Z(ocmDvQ_1_NEG),
//                                  .A(ocmDv_1_NEG),
//                                  .B(~isXltValid));

   assign ocmDvQ_1_NEG_i = ( ocmDv_1_NEG | ~isXltValid );

assign ICU_Abort_NEG = ~(icu_Abort & icuRequest2L2) ;

assign resetCore2In = resetCoreIn | (~plbAbort2L2 & resetCoreL2) ;

assign fillTakingPreAdd = (preWfL2 &  vcarspFullL2 &
                         (full | halfFull | fillWbL2 | fillWr0L2_i | fillWr1L2));

assign vcarspFullIn = vcarspGate | (vcarspFullL2 &
                       ~(preReqL2 & plbAbort2L2 & ~acceptL2) &
                       ~fillTakingPreAdd) ;

assign vcarspValidIn = vcarspGate | (vcarspValidL2 &
                       ~(preReqL2 & plbAbort2L2 & ~acceptL2) &
                       ~fillTakingPreAdd &
                       ~(IFB_cntxSync & ~plba2CaL2)) ;

assign vcarsp27In = (lxL2[27] & ~vcarspFullL2) | (vcarsp27L2 & vcarspFullL2);

assign vcarspFtchIn = (priFtchL2 & ~vcarspFullL2) | (vcarspFtchL2 & vcarspFullL2);

assign vcarspGate = (preWfrL2 & acceptL2 & ~isAbortL2 & scL2) |
                  ((fetchNeedsFill | dsNeedsFill) &
                   filling & preIdleL2 & ~df_forceOnly1Req);

assign vcarspSel[0] = preWfrL2 & vcarspGate;
assign vcarspSel[1] = vcarspGate & testEn_NEG;

assign turnOff = 1'b0;

//
//Page 14
////////////////new size logic//////////////////////////////////////////////////

assign preSizeE1 = sc2L2 & icuRequest2L2 & preReqL2 ;

assign fillSizeSel = (scL2 & icuRequest2L2 & fillReqL2) | fillTakingPre ;

assign sizeSel = full | halfFull | fillWbL2 | fillWr0L2_i | fillWr1L2 ;

assign fillSizeIn = (PLB_sSize & icuRequest2L2) | (preSizeL2 & ~icuRequest2L2);

assign plbSize = (preSizeL2 & sizeSel) | (fillSizeL2 & ~sizeSel);

////////////////////////////////////////////////////////////////////////////////

assign full = valid0L2 & valid1L2 & valid2L2 & valid3L2 &
              valid4L2 & valid5L2 & valid6L2 & valid7L2 ;

assign halfFull = (valid0L2 & valid1L2 & valid2L2 & valid3L2 & ~df_nonC_8 & ~rarsCaL2) |
                  (valid4L2 & valid5L2 & valid6L2 & valid7L2 & ~df_nonC_8 & ~rarsCaL2) ;

assign valid0In = setValidIn[0] | (valid0L2 & ~resetValidBits) ;

assign valid1In = setValidIn[1] | (valid1L2 & ~resetValidBits) ;

assign valid2In = setValidIn[2] | (valid2L2 & ~resetValidBits) ;

assign valid3In = setValidIn[3] | (valid3L2 & ~resetValidBits) ;

assign valid4In = setValidIn[4] | (valid4L2 & ~resetValidBits) ;

assign valid5In = setValidIn[5] | (valid5L2 & ~resetValidBits) ;

assign valid6In = setValidIn[6] | (valid6L2 & ~resetValidBits) ;

assign valid7In = setValidIn[7] | (valid7L2 & ~resetValidBits) ;

//
//                                                                  Page 15
///////////////////////// logic /////////////////////////////////////////

assign frAndDsRdy_i = IFB_fetchReq & ~anyCacheOp & dsIdleL2 & ~fillBlkRd ;

//assign nxtFetchRd = (dsIdleL2 & ~fillBlkRd & fetchIdle & forceNlL2 &
 //                    ((lxFetchValidL2 & ~bypEO[1] & ~ocmDvQ_1) |
 //                     (~anyCacheOp & IFB_fetchReq))) |
 //                   (frAndDsRdy & IFB_isNL & ~lxFetchValidL2) |
 //                   (frAndDsRdy & IFB_isNL & ocmDvQ_1) |
 //                   (frAndDsRdy & IFB_isNL & EO1Reset) |
 //                   (frAndDsRdy & IFB_isNL & MMU_icuIsAbort) |
 //                   (frAndDsRdy & IFB_icuCancelData & IFB_isNL) |
 //                   (frAndDsRdy & IFB_isAbort[0])  ;



//dp_logicICU_nxtFRd logicICU_nxtFRd( .Z(nxtRdAb),
  //                                  .A(IFB_isAbort[0]),
  //                                  .B(frAndDsRdy));

//dp_logicICU_nxtFRd1 logicICU_nxtFRd1( .Z(nxtFetchRd),
  //                                  .A(nxtRdAb),
  //                                  .B(~nxtRdNAb));

//change from abort late to eo1/////////////////////////////////////////////////////////
//dp_logicICU_nxtFRd2 logicICU_nxtFRd2( .Z(nxtRdAb2),
  //                                    .A(IFB_isAbort[0]),
  //                                    .B(frAndDsRdy));
//dp_logicICU_nxtFRd2 logicICU_nxtFRd2( .Z(nxtRdAb2),
  //        .A( ~((~eo_r & eo_z2_NEG) | (isCompA_NEG_1 & isCompB_NEG_1 & eo_z2_NEG))),
  //                                    .B(frAndDsRdy & IFB_isNL));

//dp_logicICU_nxtFRd3 logicICU_nxtFRd3( .Z(nxtFetchRd2),
  //                                    .A(nxtRdAb2),
  //                                    .B(~nxtRdNEO1));

//assign nxtRdNEO1 = (dsIdleL2 & ~fillBlkRd & fetchIdle & forceNlL2 &
  //                  ((lxFetchValidL2 & ~bypEO[1] & ocmDvQ_1_NEG) |
  //                    (~anyCacheOp & IFB_fetchReq))) |
  //                  (frAndDsRdy & IFB_isNL & ~lxFetchValidL2) |
  //                  (frAndDsRdy & IFB_isNL & ocmDvQ_1) |
  //                  (frAndDsRdy & IFB_isAbort[0]) |
  //                  (frAndDsRdy & IFB_isNL & MMU_icuIsAbort) |
  //                  (frAndDsRdy & IFB_icuCancelData & IFB_isNL) ;
//change from abort late to eo1///////////////////////////////////////////////////

//replace EO1Reset_1
//assign nxtRdNAb = (dsIdleL2 & ~fillBlkRd & fetchIdle & forceNlL2 &
  //                  ((lxFetchValidL2 & ~bypEO[1] & ocmDvQ_1_NEG) |
  //                    (~anyCacheOp & IFB_fetchReq))) |
  //                  (frAndDsRdy & IFB_isNL & ~lxFetchValidL2) |
  //                  (frAndDsRdy & IFB_isNL & ocmDvQ_1) |
  //                  (frAndDsRdy & IFB_isNL &
  //     ~((~eo_r & eo_z2_NEG) | (isCompA_NEG_1 & isCompB_NEG_1 & eo_z2_NEG))) |
  //                  (frAndDsRdy & IFB_isNL & MMU_icuIsAbort) |
  //                  (frAndDsRdy & IFB_icuCancelData & IFB_isNL) ;

//assign nxtWait = (fetchRdL2 | fetchWaL2) & ~IFB_isAbort[0] &
  //               ((~MMU_icuIsAbort & ~isXltValid & ~IFB_icuCancelData) |
  //                (~MMU_icuIsAbort & ~isXltValid & IFB_icuCancelData &
  //                 ~anyCacheOp & ~forceNlL2 & ~IFB_isNL) |
  //                (~EO1Reset & ~MMU_icuIsAbort & isXltValid &
  //                 IFB_icuCancelData & ~anyCacheOp & ~timeForRequestScL2 &
  //                 ~ocmDvQ_1 & ~OCM_isHold & ~forceNlL2 &
  //                 ~IFB_isNL & (~vcarVcarsCompAndValid |
  //                  (~bit27Eq & ~MMU_isCacheable[1]) |
  //                 (MMU_isCacheable[1] & ~rarsCaL2))) |
  //                (~EO1Reset & ~MMU_icuIsAbort & isXltValid &
  //                 ~IFB_icuCancelData & ~timeForRequestScL2 & ~ocmDvQ_1 &
  //                 ~OCM_isHold & ~forceNlL2  &
  //                 (~vcarVcarsCompAndValid | (~bit27Eq & ~MMU_isCacheable[1]) |
  //                 (MMU_isCacheable[1] & ~rarsCaL2))));

//replace ~EO1Reset
//assign rdToWait = fetchRdL2 &
  //                ((~isXltValid & ~IFB_icuCancelData) |
  //                 (~isXltValid & ~anyCacheOp & ~forceNlL2 & ~IFB_isNL) |
  //                 ((isXltValid &
  //             ((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG)) &
  //                   ocmDvQ_1_NEG & ~OCM_isHold & ~forceNlL2 &
  //                   (~vcarVcarsCompAndValid | (~bit27Eq & ~MMU_isCacheable[1]) |
  //                    (MMU_isCacheable[1] & ~rarsCaL2))) &
  //                   (~IFB_icuCancelData | (~anyCacheOp & ~IFB_isNL)))) ;

//replace ~EO1Reset
//assign waToWait = fetchWaL2 &
  //                ((~MMU_icuIsAbort & ~isXltValid & ~IFB_icuCancelData) |
  //                 (~MMU_icuIsAbort & ~isXltValid & ~anyCacheOp &
  //                    ~forceNlL2 & ~IFB_isNL) |
  //                 (( ((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG)) &
  //                     ~MMU_icuIsAbort & isXltValid &
  //                    ~(timeForRequestScL2 & isXltValidL2) &
  //                    ~isHoldL2 & ocmDvQ_1_NEG & ~forceNlL2 &
  //                    (~vcarVcarsCompAndValid | (~bit27Eq & ~MMU_isCacheable[1]) |
  //                    (MMU_isCacheable[1] & ~rarsCaL2))) &
  //                    (~IFB_icuCancelData | (~anyCacheOp & ~IFB_isNL)))) ;

//assign nxtWait = ~IFB_isAbort[0] & (rdToWait | waToWait);

//assign nxtWait = ~IFB_isAbort[0] & (fetchRdL2 | fetchWaL2) &
  //               ((~MMU_icuIsAbort & ~isXltValid & ~IFB_icuCancelData) |
  //                 (~MMU_icuIsAbort & ~isXltValid & ~anyCacheOp &
  //                    ~forceNlL2 & ~IFB_isNL) |
  //                 (( ((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG)) &
  //                     ~MMU_icuIsAbort & isXltValid &
  //                    ~(timeForRequestScL2 & isXltValidL2 & fetchWaL2) &
  //                    ~OCM_isHold & ocmDvQ_1_NEG & ~forceNlL2 &
  //                    (~vcarVcarsCompAndValid | (~bit27Eq & ~MMU_isCacheable[1]) |
  //                    (MMU_isCacheable[1] & ~rarsCaL2))) &
  //                    (~IFB_icuCancelData | (~anyCacheOp & ~IFB_isNL)))) ;
//
//Page 16
////////////////////////////////////////////////////////////////////////////////

assign fillBlkRd = (fillWbL2 | fillWr0L2_i);
assign fillBlkDs = ~fillIdleL2 ;

assign priwait4XltV = ((fetchRdL2 | fetchWaL2) & ~isXltValid) ;

//!!// for pass 2 rework this to just setForceNl when we are going to write cache
assign setForceNl = dsRdL2 |
                    (fillFillL2 & (full | halfFull))   |
                    (plbAbort2L2 & ~acceptL2) ;

//assign forceNlIn = (forceNlL2 & ~nxtFetchRd) | setForceNl  ;

//assign lxSel = (priCanSetLxValid & IFB_fetchReq) | dsRdMuxSel ;


// set dom latch
//replace EO1Reset
//assign priCanSetLxValid = (~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) &
  //                         ~fillBlkRd & dsIdleL2) &
  //                        (~lxFetchValidL2 | IFB_icuCancelData |
  //                        IFB_isAbort[1] | ocmDvQ_1 |
  //                   ~((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG))) ;

//assign setLxFetchValid = priCanSetLxValid & IFB_fetchReq ;

//replace EO1Reset
//assign resetLxFetchValid = ~((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG)) |
  //                   ocmDvQ_1 | IFB_icuCancelData | IFB_isAbort[1] |
  //                         MMU_icuIsAbort ;

//assign lxFetchValidIn = (lxFetchValidL2 & ~resetLxFetchValid) |
  //                          setLxFetchValid ;

//
//                                                                        Page 17
// save requests that are loaded into VCAR ///////////////////////////////////////

assign prifetchIn = IFB_fetchReq &
                   ~(PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2) ;

            // ds vcar inputs comeback
assign vcarIcbtIn = PCL_icuOp[0] & ~PCL_icuOp[1] &
                   ~PCL_icuOp[2] & PCL_icuOp[3] ;

//assign vcarIcbtIn = PCL_icuOp[0] & ~PCL_icuOp[1] &
 //                  ~PCL_icuOp[2] ;

assign vcarIcbiIn = PCL_icuOp[0] & ~PCL_icuOp[1] &
                   PCL_icuOp[2] & ~PCL_icuOp[3] ;

//assign vcarIcbiIn = PCL_icuOp[0] & ~PCL_icuOp[1] &
 //                  PCL_icuOp[2] ;

assign vcarIccciIn = PCL_icuOp[0] & ~PCL_icuOp[1] &
                    PCL_icuOp[2] & PCL_icuOp[3] ;

//assign vcarIccciIn = PCL_icuOp[0] & PCL_icuOp[1] &
 //                   ~PCL_icuOp[2] ;

assign vcarIcReadIn = PCL_icuOp[0] & PCL_icuOp[1] &
                   ~PCL_icuOp[2] & ~PCL_icuOp[3] ;

//assign vcarIcReadIn = PCL_icuOp[0] & PCL_icuOp[1] &
 //                    PCL_icuOp[2] ;

assign priIcbtIn = (dsVcar2FullL2 & ~dsVcar1FullL2 & vcar2IcbtL2) |
                   (dsVcar1FullL2 & vcar1IcbtL2) ;

assign priIcbiIn = (dsVcar2FullL2 & ~dsVcar1FullL2 & vcar2IcbiL2) |
                   (dsVcar1FullL2 & vcar1IcbiL2) ;

assign priIccciIn = (dsVcar2FullL2 & ~dsVcar1FullL2 & vcar2IccciL2) |
                    (dsVcar1FullL2 & vcar1IccciL2) ;

assign priIcReadIn = (dsVcar2FullL2 & ~dsVcar1FullL2 & vcar2IcReadL2) |
                     (dsVcar1FullL2 & vcar1IcReadL2) ;

//replace fetchHit with terms
//05/20/99 remove ~(ocmDvQ_0 | ocmDvQ_1)
//assign bufValidIn = ~(ldcc2RdNoAb | nxtFetchRd) &
  //                   (bufValidL2 | ((fetchRdL2 | fetchWaL2) &
  //                 fetchHit))  ;
       //            fetchHit))  &
       //            ~(ocmDvQ_0 | ocmDvQ_1) ;

//assign rdStateIn = (goingToPreRd | ldcc2RdNoAb | (dsRdL2 & dsRD1cycle) | nxtFetchRd) ;



//
//Page 18
//---------------------------ICU outputs------------------------------------------//

assign icuRequestIn = (timeForRequestNoScL2 &
                      (fetchNeedsFill | dsNeedsFill)) |
                      (preWfrL2 & acceptL2 & ~isAbortL2) |
                      (icuRequest2L2 & ~acceptL2 & ~plbAbort2L2) ;
           //         ((fillReqL2 | preReqL2) & ~acceptL2 & ~plbAbort2L2) ;

assign sizeIn[0] =  plbaCaIn | (~plbaCaIn & df_nonC_8) ;
assign sizeIn[1] = ~plbaCaIn & ~df_nonC_8 ;

assign fetchReqState = (fillReqL2 | preReqL2) & plbaFtchL2 ;

assign saveAbortIn = (~scL2 & savedAbort) |
                     (fetchReqState & ~scL2 & IFB_isAbort[1] & ~acceptL2) ;

assign plbAbort2In = (IFB_isAbort[1] & fetchReqState) |
                      savedAbort | resetCoreL2 ;

assign ICU_cacheable_NEG = plbaCaL2_NEG ;

assign ICU_ocmReqPending_NEG = ~(IFB_fetchReq & ~PCL_icuOp[0] &
                                 ~dsVcar1FullL2 & ~dsVcar2FullL2 &
                                 ~fillBlkRd & dsIdleL2) ;

//replace EO1Reset_1
//assign ICU_ocmIcuReady_NEG = ~(~lxFetchValidL2 |
  //                   ~((~eo_r & eo_z2_NEG) | (isCompA_NEG_1 & isCompB_NEG_1 & eo_z2_NEG))) ;

// comeback les should output
//assign ICU_ocmAbort = IFB_isAbort | IFB_icuCancelData |
  //                    resetCoreL2 ;

assign ICU_isCA_i = ~(IFB_fetchReq &
                    (PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2 |
                     fillBlkRd | ~dsIdleL2));

assign int_isCA = ~(IFB_fetchReq &
                    (PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2 |
                     fillBlkRd | ~dsIdleL2));

assign ICU_dsCA_i = ~(PCL_icuOp[0] & (~dsIdleL2 | dsVcar2FullL2 |
                   (dsVcar1FullL2 & ~ignoreAB1L2 & ~MMU_isDsXltValidL2)));

assign ICU_sleepReq = fetchIdle & dsIdleL2 & fillIdleL2 & preIdleL2 &
                      ~dsVcar1FullL2 & ~dsVcar2FullL2;

assign syncAfterResetIn = resetCoreL2 | (syncAfterResetL2 & scL2 &
                          (PLB_icuBusy | PLB_dcuBusy)) |
                          (syncAfterResetL2 & ~scL2) ;

assign ICU_syncAfterReset = syncAfterResetL2 ;


//
//                                                                        Page 19
// generation of ICU_EO //////////////////////////////////////////////////////////
assign setevenBypd = bypEO[0] & ~bypEO[1] ;
assign resetevenBypd = bypEO[1] | IFB_isAbort[1] | IFB_icuCancelData  ;
assign evenBypdIn = (evenBypdL2 | setevenBypd) & ~resetevenBypd ;

always @ (evenBypdL2 or lxFetchValidL2_i or df_vcarVcarsCompare or vcarsValidL2 or
          isXltValid or lxL2 or valid0L2 or valid2L2 or valid4L2 or valid6L2)

 begin
   casez({evenBypdL2, lxFetchValidL2_i, df_vcarVcarsCompare, vcarsValidL2,
          isXltValid, lxL2[27], lxL2[28], lxL2[29],
          valid0L2, valid2L2, valid4L2, valid6L2}) 

//     evenBypdL2
//     |lxFetchValidL2
//     ||df_vcarVcarsCompare
//     |||vcarsValidL2
//     ||||isXltValid
//     |||||
//     ||||| lxL2[27]
//     ||||| |lxL2[28]
//     ||||| ||lxL2[29]
//     ||||| |||
//     ||||| ||| valid0L2
//     ||||| ||| |valid2L2
//     ||||| ||| ||valid4L2
//     ||||| ||| |||valid6L2
//     ||||| ||| ||||
   12'b1????_???_????: bypEO_0 = 1'b0 ;
   12'b?0???_???_????: bypEO_0 = 1'b0 ;
   12'b??0??_???_????: bypEO_0 = 1'b0 ;
   12'b???0?_???_????: bypEO_0 = 1'b0 ;
   12'b????0_???_????: bypEO_0 = 1'b0 ;
   12'b?????_00?_0???: bypEO_0 = 1'b0 ;
   12'b01111_000_1???: bypEO_0 = 1'b1 ;
   12'b?????_01?_?0??: bypEO_0 = 1'b0 ;
   12'b01111_010_?1??: bypEO_0 = 1'b1 ;
   12'b?????_10?_??0?: bypEO_0 = 1'b0 ;
   12'b01111_100_??1?: bypEO_0 = 1'b1 ;
   12'b?????_11?_???0: bypEO_0 = 1'b0 ;
   12'b01111_110_???1: bypEO_0 = 1'b1 ;
   12'b?????_??1_????: bypEO_0 = 1'b0 ;
   default:            bypEO_0 = 1'bx ;
   endcase
 end

//
// Page 20
//////////////////////////////////////////////////////////////////////////////

wire valid1_fix, valid3_fix, valid5_fix, valid7_fix;

assign valid1_fix = (lxL2[29] & valid1L2) | (valid0L2 & valid1L2);
assign valid3_fix = (lxL2[29] & valid3L2) | (valid2L2 & valid3L2);
assign valid5_fix = (lxL2[29] & valid5L2) | (valid4L2 & valid5L2);
assign valid7_fix = (lxL2[29] & valid7L2) | (valid6L2 & valid7L2);

//always @ (lxFetchValidL2 or df_vcarVcarsCompare or vcarsValidL2 or
 //         isXltValid or lxL2 or valid1L2 or valid3L2 or valid5L2 or valid7L2)
always @ (lxFetchValidL2_i or df_vcarVcarsCompare or vcarsValidL2 or
          isXltValid or lxL2 or valid1_fix or valid3_fix or valid5_fix or valid7_fix)

// begin
 //  casez({lxFetchValidL2, df_vcarVcarsCompare, vcarsValidL2,
 //         isXltValid, lxL2[27], lxL2[28],
 //         valid1L2, valid3L2, valid5L2, valid7L2})
 begin
   casez({lxFetchValidL2_i, df_vcarVcarsCompare, vcarsValidL2,
          isXltValid, lxL2[27], lxL2[28],
          valid1_fix, valid3_fix, valid5_fix, valid7_fix})

//     lxFetchValidL2
//     |df_vcarVcarsCompare
//     ||vcarsValidL2
//     |||isXltValid
//     ||||
//     |||| lxL2[27]
//     |||| |lxL2[28]
//     |||| ||
//     |||| || valid1L2/fix
//     |||| || |valid3L2/fix
//     |||| || ||valid5L2/fix
//     |||| || |||valid7L2/fix
//     |||| || ||||
   10'b0???_??_????: bypEO_1 = 1'b0 ;
   10'b?0??_??_????: bypEO_1 = 1'b0 ;
   10'b??0?_??_????: bypEO_1 = 1'b0 ;
   10'b???0_??_????: bypEO_1 = 1'b0 ;
   10'b????_00_0???: bypEO_1 = 1'b0 ;
   10'b1111_00_1???: bypEO_1 = 1'b1 ;
   10'b????_01_?0??: bypEO_1 = 1'b0 ;
   10'b1111_01_?1??: bypEO_1 = 1'b1 ;
   10'b????_10_??0?: bypEO_1 = 1'b0 ;
   10'b1111_10_??1?: bypEO_1 = 1'b1 ;
   10'b????_11_???0: bypEO_1 = 1'b0 ;
   10'b1111_11_???1: bypEO_1 = 1'b1 ;
   default:          bypEO_1 = 1'bx ;
   endcase
 end

assign bypEO[0:1] = {bypEO_0, bypEO_1};

//
//                                                                     Page 21
///////////////////////////////////////////////////////////////////////////////

assign eo_y_NEG = ~(bypEO[0] | ocmDvQ_0 | (lxFetchValidL2_i & bufValidL2 & ~lxL2[29]));

assign eo_q = lxFetchValidL2_i & ~lxL2[29] & (fetchRdL2 | fetchWaL2) & isXltValid ;

assign eo_z_NEG = ~(bypEO[1] | ocmDvQ_1 | (lxFetchValidL2_i & bufValidL2));
assign eo_z2_NEG_i = ~(bypEO[1] | (lxFetchValidL2_i & bufValidL2));

assign eo_r = lxFetchValidL2_i & (fetchRdL2 | fetchWaL2) & isXltValid ;



//assign EO1Reset_1 = ~((~eo_r | isCompA_NEG_1) & (~eo_r | isCompB_NEG_1) & eo_z2_NEG);
//assign EO1Reset = ~((~eo_r | isCompA_NEG) & (~eo_r | isCompB_NEG) & eo_z2_NEG);
//assign EO1Reset = ~((~eo_r & eo_z2_NEG) | (isCompA_NEG & isCompB_NEG & eo_z2_NEG));


//nand2
//dp_logicICU_EOCompR0 logicICU_EOCompR0 ( .Z(isCompAR),
  //                                       .A(eo_r),
  //                                       .B(isCompA));
//nand2
//dp_logicICU_EOCompR1 logicICU_EOCompR1 ( .Z(isCompBR),
  //                                       .A(eo_r),
  //                                       .B(isCompB));
//nand3
//dp_logicICU_EO_out1DUP logicICU_EO_out1DUP ( .Z(EO1Reset),
    //                                           .A(eo_z2_NEG),
    //                                           .B(isCompAR),
   //                                            .C(isCompBR));

assign ICU_ifbError[0] = ((err0L2 & ~lxL2[27] & ~lxL2[28] & valid0L2) |
                          (err2L2 & ~lxL2[27] & lxL2[28] & valid2L2) |
                          (err4L2 & lxL2[27] & ~lxL2[28] & valid4L2) |
                          (err6L2 & lxL2[27] & lxL2[28] & valid6L2)) &
                          ~lxL2[29] & ~evenBypdL2 & vcarVcarsCompAndValid &
                          lxFetchValidL2_i ;

assign ICU_ifbError[1] = ((err1L2 & ~lxL2[27] & ~lxL2[28] & valid1L2) |
                         (err3L2 & ~lxL2[27] & lxL2[28] & valid3L2) |
                         (err5L2 & lxL2[27] & ~lxL2[28] & valid5L2) |
                         (err7L2 & lxL2[27] & lxL2[28] & valid7L2)) &
                           vcarVcarsCompAndValid & lxFetchValidL2_i ;

//sys2
assign anyPlbError = (err0L2 | err1L2 | err2L2 | err3L2 | err4L2 |
                        err5L2 | err6L2 | err7L2 | ~vcarsValidL2) ;
//
// Page 22
//---------------------------data flow outputs mux selects---------------------------//

// inputs for dataSelCC mux
// 00 = isEA                     : normal fetch
// 01 = VCAR/dsVcar1 | dsVcar2   : dsOps and fetch rereads
// 10 = gnd
// 11 = VCARSCC                  : line fill writes

assign dataCcSel_i[0] = fillWbL2 | fillWr0L2_i | JTG_iCacheWr ;

//changed 3/25/99 for timing
//assign dataCcSel[1] = (~EO1Reset & ~ocmDvQ_1 & ~fillBlkRd &
 //                      fetchIdle & forceNlL2 & ~IFB_isAbort[1] &
 //                      ~IFB_icuCancelData & lxFetchValidL2) |
 //                     dsLdCcL2 | fillWbL2 | fillWr0L2 ;
assign dataCcSel_i[1] = (eo_z2_NEG_i & ocmDvQ_1_NEG_i & ~fillBlkRd &
                       fetchIdle & forceNlL2_i & ~IFB_isAbort[1] &
                       ~IFB_icuCancelData & lxFetchValidL2_i) |
                      dsLdCcL2 | fillWbL2 | fillWr0L2_i ;
assign dataCcSel_i[2] = dataCcSel_i[1] | JTG_iCacheWr;
assign dataCcSel_i[3] = fillWbL2 | fillWr0L2_i ;

// inputs for tagSelCC mux
// 00 = isEA                     : normal fetch
// 01 = VCAR +20                 : check for pre fetch in cache
// 10 = VCAR/dsVcar1 | dsVcar2   : dsOps and fetch rereads
// 11 = VCARSCC                  : line fill writes

//replace ~EO1Reset_1
//assign tagVSel[0] = (((~eo_r & eo_z2_NEG) | (isCompA_NEG_1 & isCompB_NEG_1 & eo_z2_NEG)) &
  //                   ocmDvQ_1_NEG & ~fillBlkRd &
  //                   fetchIdle & forceNlL2 & ~IFB_isAbort[2] &
  //                  ~IFB_icuCancelData & lxFetchValidL2) |
  //                  dsLdCcL2 | fillWr0L2 ;
assign tagVSel_1 = (goingToPreRd & ~IFB_isAbort[1]) | fillWr0L2_i ;

// inputs for lruRdSelCC mux
// 0 = VCAR   : icread path
// 1 = VCARS  : fill path

//icread fix 7/14/99
//assign lruRdSel = ~(priIcReadL2 & dsLdCcL2 & ~fillBlkDs) ;
assign lruRdSel = fillBlkDs ;

assign vcarsCCE2 = fillFillL2 & full & rarsCaL2 ;

// PLBA low mux and reg           If fill or pre takes ICBT it
// inputs for PLBA low mux        moves to the PLB at the same time.
// 00 = feedback                  preWfrL2 is mutually exclusive with
// 01 = isRA                      dsRdL2 because if in preWfrL2 the
// 10 = PLB+20                    lxFtechValidL2 must be set. If lxFtechValidL2
// 11 = icuRDARL2                 is set the data side must be in idle.

//
//                                                                              Page 23
//---------------------------data flow outputs mux selects---------------------------//


assign plbLowSel[0] = plbLowGate & (dsRdL2 | preWfrL2) ;
assign plbLowSel[1] = plbLowGate & ~preWfrL2 ;

// PLBA high mux and reg          If fill or pre takes ICBT it
// inputs for PLBA high mux       moves to the PLB at the same time.
// 00 = feedback                  preWfrL2 is mutually exclusive with
// 01 = isRA                      dsRdL2 because if in preWfrL2 the
// 10 = gnd                       lxFtechValidL2 must be set. If lxFtechValidL2
// 11 = icuRDARL2

assign plbHighSel[0] = plbHighGate & dsRdL2;
assign plbHighSel[1] = plbHighGate & testEn_NEG ;

// RARS mux and reg
// inputs for Rars mux
// 00 = feedback
// 01 = isRA
// 10 = icuRDARL2
// 11 = PLB

assign rarsSel[0] = vcarsRarsGate & (vcarspFullL2 | dsRdL2) ;
assign rarsSel[1] = vcarsRarsGate & (~dsRdL2 | vcarspFullL2) ;

// VCARS mux and reg
// inputs for Rars mux
// 00 = feedback
// 01 = vcar
// 10 = gnd
// 11 = vcarsp

assign vcarsSel[0] = vcarsRarsGate & vcarspFullL2 ;
assign vcarsSel[1] = vcarsRarsGate & testEn_NEG ;

//
//Page 24
//---------------------data flow outputs g2 gates ----------------------------------//
//

assign plbHighGate = timeForRequestNoScL2 &
               (dsNeedsFill | fetchNeedsFill) ;

assign plbLowGate = (timeForRequestNoScL2 &
               (dsNeedsFill | fetchNeedsFill)) |
               (preWfrL2 & acceptL2) ;

assign fillTakingPre = (fillWr1L2 | (full & (~rarsCaL2 | anyPlbError |
                 (df_ftchMissBlkWr & rarsFetchL2))) | halfFull) & preWfL2 ;

assign vcarsRarsGate = ((fetchNeedsFill | dsNeedsFill) &
                      (fillIdleL2 | (fillWr1L2 & preIdleL2))) |
                       fillTakingPreAdd | resetCoreL2;

//assign resetValidBits = vcarsRarsGate |
  //                      (full & rarsCaL2 & fillFillL2 & ~df_ftchMissBlkWr) |
  //                       (anyPlbError & fillFillL2 & (full | halfFull)) ;

//assign fillTakingPreAdd = (preWfL2 &  vcarspFullL2 &
  //                       (full | halfFull | fillWbL2 | fillWr0L2 | fillWr1L2));
//fix for fast plb
assign resetValidBits = (preWfL2 &  vcarspFullL2 & (full | halfFull)) |
                        ((fetchNeedsFill | dsNeedsFill) &
                        (fillIdleL2 | (fillWr1L2 & preIdleL2))) | resetCoreL2 |
                        (full & rarsCaL2 & fillFillL2 & ~df_ftchMissBlkWr) |
                         (anyPlbError & fillFillL2 & (full | halfFull)) |
                        ((full | halfFull) & PLB_icuRdDAck & scL2) ;

assign vcarsValidIn = (((fetchNeedsFill | dsNeedsFill) &
                      (fillIdleL2 | (fillWr1L2 & preIdleL2))) |
                      (fillTakingPreAdd & vcarspValidL2 &
                       ~(IFB_cntxSync & ~plba2CaL2))) |
                      (vcarsValidL2 &
                      ~(fillReqL2 & plbAbort2L2 & ~acceptL2) &
                      ~(full & rarsCaL2 & fillFillL2 & ~df_ftchMissBlkWr) &
                      ~(anyPlbError & fillFillL2 & (full | halfFull)) &
                      ~(IFB_cntxSync & ~rarsCaL2));

assign vcarE2_i = (IFB_fetchReq | dsVcar1FullL2 | dsVcar2FullL2);


//assign vcarSel = (dsIdleL2 & ~fillBlkRd & fetchIdle &
  //                   forceNlL2 & ~lxFetchValidL2 & ~anyCacheOp & IFB_fetchReq) |
  //                  (frAndDsRdy & IFB_isNL & ~lxFetchValidL2) |
  //                  (frAndDsRdy & IFB_isNL & ocmDvQ_1) |
  //                  (frAndDsRdy & IFB_isNL & EO1Reset_1) |
  //                  (frAndDsRdy & IFB_isNL & MMU_icuIsAbort) |
  //                  (frAndDsRdy & IFB_icuCancelData & IFB_isNL) |
  //                  (frAndDsRdy & IFB_isAbort[0]) |
  //                  ldcc2RdNoAb  ;

assign vcarSel_noEO = (dsIdleL2 & ~fillBlkRd & fetchIdle &
                     forceNlL2_i & ~lxFetchValidL2_i & ~anyCacheOp & IFB_fetchReq) |
                    (frAndDsRdy_i & IFB_isNL & ~lxFetchValidL2_i) |
                    (frAndDsRdy_i & IFB_isNL & ocmDvQ_1) |
                    (frAndDsRdy_i & IFB_isNL & MMU_icuIsAbort) |
                    (frAndDsRdy_i & IFB_icuCancelData & IFB_isNL) |
                    (frAndDsRdy_i & IFB_isAbort[0]) |
                    ldcc2RdNoAb  ;

//replace EO1Reset_1
//dp_logicICU_vcarSel_nand logicICU_vcarSel_nand( .Z(vcarSel_EO1),
  //                   .A(~((~eo_r & eo_z2_NEG) | (isCompA_NEG_1 & isCompB_NEG_1 & eo_z2_NEG))),
  //                                              .B(frAndDsRdy),
  //                                              .C(IFB_isNL));

//dp_logicICU_vcarSel_nand1 logicICU_vcarSel_nand1( .Z(vcarSel),
 //                                                 .A(vcarSel_EO1),
 //                                                 .B(~vcarSel_noEO));



assign cdbdrE1 = (dsRdL2 & priIcReadL2 & MMU_isDsXltValidL2) | resetCore2L2_i;


//
//                                                                           Page 25
//---------------------------ram data flow outputs mux selects--------------------//

// Removing module dp_logicICU_OCM_dvNor
//dp_logicICU_OCM_dvNor  logicICU_OCM_dvNor ( .Z(ocm_EO),
//                                            .A(ocmDvQ_0),
//                                            .B(ocmDvQ_1));

   assign ocm_EO = ~( ocmDvQ_0 | ocmDvQ_1 );

// Removing module dp_logicICU_isSelNand0
//dp_logicICU_isSelNand0 logicICU_isSelNand0 ( .Z(isBusSel[0]),
//                                             .A(compAlru_NEG),
//                                             .B(ocm_EO));

   assign isBusSel[0] = ~( compAlru_NEG & ocm_EO );

// Removing module dp_logicICU_isSelNand1
//dp_logicICU_isSelNand1 logicICU_isSelNand1 ( .Z(isBusSel[1]),
//                                             .A(compB_NEG),
//                                             .B(ocm_EO));

   assign isBusSel[1] = ~( compB_NEG & ocm_EO );

assign Lx27Sel = lxL2[27] ;

assign Lx28Sel = lxL2[28] ;

assign Lx29Sel = lxL2[29] ;


//
//Page 26
//---------------------ram data flow outputs g2 gates -------------------------//

//assign dataCcE2 = fillWr0L2 | (JTG_iCacheWr & (jtagL2[0] | jtagL2[4])) |
  //                (dsLdCcL2 & ~fillBlkDs) |
  //                fillWbL2 |
  //                nxtFetchRd2 ;

//assign tagCcE2 = fillWr0L2 | jtagWrTag |
  //              (dsLdCcL2 & ~fillBlkDs) |
    //            nxtFetchRd2 |
    //            (fillIdleL2 & preIdleL2 & ~fetchIdle &
    //             (df_preFetchEnable | df_nonCpreFetchEn)) ;
//assign tagCcSel = fillWr0L2 | jtagWrTag |
  //              (dsLdCcL2 & ~fillBlkDs) |
  //              (fillIdleL2 & preIdleL2 & ~fetchIdle &
  //               (df_preFetchEnable | df_nonCpreFetchEn)) |
  //               (IFB_fetchReq & ~fillBlkRd) |
  //               (fetchIdle & forceNlL2) ;

//assign VaVbRdSel = nxtFetchRd2 |
  //                (dsLdCcL2 & ~fillBlkDs) |
  //                (fillIdleL2 & preIdleL2 & ~fetchIdle &
  //                 (df_preFetchEnable | df_nonCpreFetchEn)) ;

assign VaVbWrE1 = fillWr0L2_i | dsRdL2 | jtagWrTag ;

// 4/14/99
//assign lruRdCcE1 = (full & fillFillL2 & rarsCaL2) |
  //                 (dsLdCcL2 & ~fillBlkDs) ;
assign lruRdCcE1 = (full & fillFillL2) |
                      dsLdCcL2 ;

////////////////////////////////////////////////////////////////////////////////

assign dataRdWrRegIn = ~(fillWbL2 | fillWr0L2_i | jtagWrData3) | resetCoreL2 ;

assign tagRdWrRegIn = ~(fillWr0L2_i | (jtagL2[0] & JTG_iCacheWr)) | resetCoreL2 ;

/////////////////////////////////////////////////////////////////////////////////

assign tagBWE1 = fillWr0L2_i | JTG_iCacheWr ;

assign wbHighE2[0] = (fillFillL2 & full & rarsCaL2) | (fillWr0L2_i) | jtagWrData0 ;
assign wbHighE2[1] = (fillFillL2 & full & rarsCaL2) | (fillWr0L2_i) | jtagWrData1 ;
assign wbHighE2[2] = (fillFillL2 & full & rarsCaL2) | (fillWr0L2_i) | jtagWrData2 ;
assign wbHighE2[3] = (fillFillL2 & full & rarsCaL2) | (fillWr0L2_i) | jtagWrData3 ;

assign wbLowE2 = (fillFillL2 & full & rarsCaL2) ;

assign wbTagE1 = JTG_iCacheWr | (fillFillL2 & full & rarsCaL2) ;



//
//                                                                  Page 27
////////////////////////////////////////////////////////////////////////

assign selectRars = fillFillL2 & ~(halfFull | full) ;

assign rarsCaQ = (selectRars & rarsCaL2) |
                 (~selectRars & plba2CaL2);

assign rars27Q = (selectRars & rars27L2) |
                 (~selectRars & df_plb27L2);

always @ (PLB_icuRdDAck or plbSize or
          rarsCaQ or df_nonC_8 or rars27Q or PLB_icuRdWrAddr)

 begin
   casez ({PLB_icuRdDAck, plbSize,
           rarsCaQ, df_nonC_8, rars27Q, PLB_icuRdWrAddr[1:3]}) 
   8'b0?_???_???: fillAE2_i[0:7] = 8'b00000000 ;
   8'b10_000_?00: fillAE2_i[0:7] = 8'b10000000 ;
   8'b10_000_?01: fillAE2_i[0:7] = 8'b01000000 ;
   8'b10_000_?10: fillAE2_i[0:7] = 8'b00100000 ;
   8'b10_000_?11: fillAE2_i[0:7] = 8'b00010000 ;
   8'b10_001_?00: fillAE2_i[0:7] = 8'b00001000 ;
   8'b10_001_?01: fillAE2_i[0:7] = 8'b00000100 ;
   8'b10_001_?10: fillAE2_i[0:7] = 8'b00000010 ;
   8'b10_001_?11: fillAE2_i[0:7] = 8'b00000001 ;
   8'b10_?1?_000: fillAE2_i[0:7] = 8'b10000000 ;
   8'b10_?1?_001: fillAE2_i[0:7] = 8'b01000000 ;
   8'b10_?1?_010: fillAE2_i[0:7] = 8'b00100000 ;
   8'b10_?1?_011: fillAE2_i[0:7] = 8'b00010000 ;
   8'b10_?1?_100: fillAE2_i[0:7] = 8'b00001000 ;
   8'b10_?1?_101: fillAE2_i[0:7] = 8'b00000100 ;
   8'b10_?1?_110: fillAE2_i[0:7] = 8'b00000010 ;
   8'b10_?1?_111: fillAE2_i[0:7] = 8'b00000001 ;
   8'b10_1??_000: fillAE2_i[0:7] = 8'b10000000 ;
   8'b10_1??_001: fillAE2_i[0:7] = 8'b01000000 ;
   8'b10_1??_010: fillAE2_i[0:7] = 8'b00100000 ;
   8'b10_1??_011: fillAE2_i[0:7] = 8'b00010000 ;
   8'b10_1??_100: fillAE2_i[0:7] = 8'b00001000 ;
   8'b10_1??_101: fillAE2_i[0:7] = 8'b00000100 ;
   8'b10_1??_110: fillAE2_i[0:7] = 8'b00000010 ;
   8'b10_1??_111: fillAE2_i[0:7] = 8'b00000001 ;
   8'b11_000_?0?: fillAE2_i[0:7] = 8'b11000000 ;
   8'b11_000_?1?: fillAE2_i[0:7] = 8'b00110000 ;
   8'b11_001_?0?: fillAE2_i[0:7] = 8'b00001100 ;
   8'b11_001_?1?: fillAE2_i[0:7] = 8'b00000011 ;
   8'b11_?1?_00?: fillAE2_i[0:7] = 8'b11000000 ;
   8'b11_?1?_01?: fillAE2_i[0:7] = 8'b00110000 ;
   8'b11_?1?_10?: fillAE2_i[0:7] = 8'b00001100 ;
   8'b11_?1?_11?: fillAE2_i[0:7] = 8'b00000011 ;
   8'b11_1??_00?: fillAE2_i[0:7] = 8'b11000000 ;
   8'b11_1??_01?: fillAE2_i[0:7] = 8'b00110000 ;
   8'b11_1??_10?: fillAE2_i[0:7] = 8'b00001100 ;
   8'b11_1??_11?: fillAE2_i[0:7] = 8'b00000011 ;
   default: fillAE2_i[0:7] = 8'bxxxxxxxx ;
   endcase
 end

assign fillBE2[0:7] = fillAE2_i[0:7] ;
assign errorSel[0:7] = fillAE2_i[0:7] & {8{~syncAfterResetL2}} ;
assign setValidIn[0:7] = ({8{~syncAfterResetL2 & scL2}} & fillAE2_i[0:7]);

//
// Page 28
//////////////////////////////////////////////////////////////////////////

assign wrLruNoHit= fillWr0L2_i | jtagWrTag |
                 (dsRdL2 & ~dsRD1cycle_i & dsHit &
                 (priIcbiL2 | (priIcbtL2 & priIsDsCacheableL2))) ;

//assign wrLruIn = wrLruNoHit |
  //              ((fetchRdL2 | fetchWaL2) & isXltValid &
  //               ~(isCompA_NEG_1 & isCompB_NEG_1) & ~IFB_isAbort[2]) ;

//assign wrLruIn = fillWr0L2 | jtagWrTag |
  //               ((fetchRdL2 | fetchWaL2) & fetchHit & ~IFB_isAbort[2]) |
  //               (dsRdL2 & ~dsRD1cycle & dsHit &
  //               (priIcbiL2 | (priIcbtL2 & priIsDsCacheableL2))) ;

assign newLruBitIn = (fillWr0L2_i & ~fillLruL2) |
                     ((fetchRdL2 | fetchWaL2) & ~compAlru_NEG) |
                     (dsRdL2 & ~dsRD1cycle_i & ((priIcbiL2 & dsCompB) |
                     (priIcbtL2 & priIsDsCacheableL2 & dsCompA))) ;

assign wrVaIn = (fillWr0L2_i & ~fillLruL2) | jtagWrVa  |
                (dsRdL2 & ~dsRD1cycle_i & (priIcbiL2 & dsCompA));

// !!!! don't forget to remove resetCoreL2
//assign wrFlashIn = (dsRdL2 & priIccciL2) | resetCoreL2 ;
assign wrFlashIn = dsRdL2 & priIccciL2 ;

assign newVaBitIn = fillWr0L2_i ;

assign wrVbIn = (fillWr0L2_i & fillLruL2) | jtagWrVb |
                (dsRdL2 & ~dsRD1cycle_i & (priIcbiL2 & dsCompB));

assign newVbBitIn = fillWr0L2_i ;

//assign cycleDataRegAIn = (fillWbL2 & ~priwait4XltV & ~lruOut) |
  //                       (fillWr0L2 & ~fillLruL2) |
  //                       ldcc2RdNoAb | nxtFetchRd2 |
  //                        (jtagWrData3 & ~icuBaSel) ;

//assign cycleDataRegBIn = (fillWbL2 & ~priwait4XltV & lruOut) |
  //                       (fillWr0L2 & fillLruL2) |
  //                       ldcc2RdNoAb | nxtFetchRd2 |
  //                       (jtagWrData3 & icuBaSel) ;

//assign cycleTagRegIn = fillWr0L2 | ldcc2RdNoAb | jtagWrTag |
  //                     nxtFetchRd2 | goingToPreRd ;

//assign dataRdWrRegIn = ~(JTG_iCacheWr | fillWbL2) | resetCoreL2 | jtagL2[7] ;
//assign tagRdWrRegIn = ~(fillWr0L2 | jtagWrTag) | resetCoreL2 ;
assign wrATagNotB = ~fillLruL2 ;


//
//                                                                           Page 29
// dsXltValid And cacheable registers////////////////////////////////////////////////

assign plbaCaIn = (isCacheableL2 & ~dsRdL2) |
                  (priIsDsCacheableL2 & dsRdL2) ;

assign rarsCaL2In = (isCacheableL2 & ~vcarspFullL2 & ~dsRdL2) |
                    (priIsDsCacheableL2 & dsRdL2) |
                    (plba2CaL2 & vcarspFullL2) ;

assign plbaFetchIn = priFtchL2 ;

assign rarsFetchIn = (~vcarspFullL2 & priFtchL2) | (vcarspFullL2 & vcarspFtchL2) ;

assign rars27In = (~vcarspFullL2 & lxL2[27]) | (vcarspFullL2 & vcarsp27L2)  ;
//wire   fetchHit;
//assign fetchHit = isXltValid & ~missIn  ;

assign dsHit = dsCompA | dsCompB ;

assign dsMiss = MMU_isDsXltValidL2 & ~(dsCompA | dsCompB) ;

assign anyCacheOp = PCL_icuOp[0] | dsVcar1FullL2 | dsVcar2FullL2;

assign bit27Eq = ((~rars27L2 ^ lxL2[27]) | df_nonC_8) & vcarsValidL2 ;

assign vcarVcarsCompAndValid = df_vcarVcarsCompare & vcarsValidL2 ;

//
// Page 30
/////////////////////d side primary state machine//////////////////////////

always @ (dsRdL2 or dsLdCcL2 or dsIdleL2 or lxFetchValidL2_i or dsVcar1FullL2 or
          ignoreAB1L2 or dsVcar2FullL2 or ignoreAB2L2 or MMU_isDsXltValidL2 or
          VCT_exeAbort or VCT_icuWbAbort or MMU_icuDsAbort or fillBlkDs or
          PCL_icuOp or priIcbtL2 or priIsDsCacheableL2 or dsMiss or
          timeForRequestScL2 or dsRD1cycle_i)
 begin
   casez ({
           dsRdL2, dsLdCcL2, dsIdleL2, lxFetchValidL2_i, dsVcar1FullL2,
           ignoreAB1L2, dsVcar2FullL2, ignoreAB2L2, MMU_isDsXltValidL2,
           VCT_exeAbort, VCT_icuWbAbort, MMU_icuDsAbort, fillBlkDs,
           PCL_icuOp[0], priIcbtL2, priIsDsCacheableL2, dsMiss,
           timeForRequestScL2, dsRD1cycle_i
          })

//
//                                                                         Page 31
/////////////////////d side primary state machine///// idle /////////////////////
//        dsRdL2
//        |dsLdCcL2
//        ||dsIdleL2
//        |||lxFetchValidL2
//        ||||dsVcar1FullL2
//        |||||ignoreAB1L2
//        ||||||dsVcar2FullL2
//        |||||||ignoreAB2L2
//        ||||||||MMU_isDsXltValidL2
//        |||||||||VCT_exeAbort
//        ||||||||||VCT_icuWbAbort
//        |||||||||||MMU_icuDsAbort
//        ||||||||||||fillBlkDs
//        |||||||||||||PCL_icuOp[0]
//        ||||||||||||||priIcbtL2
//        |||||||||||||||priIsDsCacheableL2
//        ||||||||||||||||dsMiss
//        |||||||||||||||||timeForRequestScL2
//        ||||||||||||||||||dsRD1cycle
//        |||||||||||||||||||
      19'b??1?0?0??????0?????: nxtStDs[0:2] = dSideIdle ;
      19'b??100?0??00??1?????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1?0?0???1????????: nxtStDs[0:2] = dSideIdle ;
      19'b??1?0?0??1?????????: nxtStDs[0:2] = dSideIdle ;
      19'b??1?0?100?00???????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1?0?10???1???????: nxtStDs[0:2] = dSideIdle ;
      19'b??1?0?10??1????????: nxtStDs[0:2] = dSideIdle ;
      19'b??1?0?101?0????????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1?0?11???????????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1010??0?00???????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1?10?????1???????: nxtStDs[0:2] = dSideIdle ;
      19'b??1?10????1????????: nxtStDs[0:2] = dSideIdle ;
      19'b??1010??1?0????????: nxtStDs[0:2] = dSideLdCc ;
      19'b??1011?????????????: nxtStDs[0:2] = dSideLdCc ;
      19'b??11???????????????: nxtStDs[0:2] = dSideIdle ;


//
//Page 32
/////////////////////d side primary state machine////// dsLdCc ////////////////////
//        dsRdL2
//        |dsLdCcL2
//        ||dsIdleL2
//        |||lxFetchValidL2
//        ||||dsVcar1FullL2
//        |||||ignoreAB1L2
//        ||||||dsVcar2FullL2
//        |||||||ignoreAB2L2
//        ||||||||MMU_isDsXltValidL2
//        |||||||||VCT_exeAbort
//        ||||||||||VCT_icuWbAbort
//        |||||||||||MMU_icuDsAbort
//        ||||||||||||fillBlkDs
//        |||||||||||||PCL_icuOp[0]
//        ||||||||||||||priIcbtL2
//        |||||||||||||||priIsDsCacheableL2
//        ||||||||||||||||dsMiss
//        |||||||||||||||||timeForRequestScL2
//        ||||||||||||||||||dsRD1cycle
//        |||||||||||||||||||
      19'b?1??0?100?00???????: nxtStDs[0:2] = dSideLdCc ;
      19'b?1??0?10???1???????: nxtStDs[0:2] = dSideIdle ;
      19'b?1??0?10??1????????: nxtStDs[0:2] = dSideIdle ;
      19'b?1????101?0?0??????: nxtStDs[0:2] = dSideRd ;
      19'b?1??0?101?0?1??????: nxtStDs[0:2] = dSideLdCc ;
      19'b?1????11????0??????: nxtStDs[0:2] = dSideRd ;
      19'b?1??0?11????1??????: nxtStDs[0:2] = dSideLdCc ;
      19'b?1??10??0?00???????: nxtStDs[0:2] = dSideLdCc ;
      19'b?1??10?????1???????: nxtStDs[0:2] = dSideIdle ;
      19'b?1??10????1????????: nxtStDs[0:2] = dSideIdle ;
      19'b?1??10??1?0?0??????: nxtStDs[0:2] = dSideRd ;
      19'b?1??10??1?0?1??????: nxtStDs[0:2] = dSideLdCc ;
      19'b?1??11??????0??????: nxtStDs[0:2] = dSideRd ;
      19'b?1??11??????1??????: nxtStDs[0:2] = dSideLdCc ;

      19'b1?????????????????1: nxtStDs[0:2] = dSideRd ;
      19'b1?????????????0???0: nxtStDs[0:2] = dSideIdle ;
      19'b1?????????????10??0: nxtStDs[0:2] = dSideIdle ;
      19'b1?????????????110?0: nxtStDs[0:2] = dSideIdle ;
      19'b1?????????????1110?: nxtStDs[0:2] = dSideRd ;
      19'b1?????????????11110: nxtStDs[0:2] = dSideIdle ;
      default:                          nxtStDs[0:2] = 3'bxxx ;
   endcase
 end


//
//                                                                        Page 33
///////////////////// fill state machine//////////////////////////

assign dsNeedsFill = dsRdL2 & ~dsRD1cycle_i & dsMiss &
                     priIsDsCacheableL2 & priIcbtL2 & scL2 ;

//assign fetchNeedsFill = (fetchRdL2 | fetchWaL2) & scL2 &
  //                      isXltValid & ~IFB_isAbort[2] & ~forceNlL2 &
  //                      ~(IFB_icuCancelData & (IFB_isNL | anyCacheOp)) &
  //                      ~OCM_isHold & ~ocmDvQ_1 &
  //                      ((~MMU_isCacheable[1] & (((rars27L2 ^ lxL2[27]) & ~df_nonC_8) |
  //                       ~df_vcarVcarsCompare | ~vcarsValidL2)) |
  //                       (MMU_isCacheable[1] & (~(isCompA | isCompB) &
  //                       (~df_vcarVcarsCompare | ~vcarsValidL2 | ~rarsCaL2)))) ;

//assign fetchNeedsFill = fetchWaL2 & scL2 & timeForRequestNoScL2L2 &
  //                      isXltValidL2 & ~isAbortL2 & ~forceNlL2 &
 //                       ~cdAbortL2 & ~isHoldL2 & ocmDvQ_1_NEG &
 //                       ((~isCacheableL2 & (((rars27L2 ^ lxL2[27]) & ~df_nonC_8) |
 //                         ~df_vcarVcarsCompare | ~vcarsValidL2)) |
 //                        (isCacheableL2 & missL2 &
 //                        (~df_vcarVcarsCompare | ~vcarsValidL2 | ~rarsCaL2))) ;
assign fetchNeedsFill = fetchWaL2 & scL2 & timeForRequestNoScL2L2 &
                        isXltValidL2 & ~isAbortL2 & ~forceNlL2_i &
                        ~cdAbortL2 & ~isHoldL2 &
                        ((~isCacheableL2 & (((rars27L2 ^ lxL2[27]) & ~df_nonC_8) |
                          ~df_vcarVcarsCompare | ~vcarsValidL2)) |
                         (isCacheableL2 & missL2_i &
                         (~df_vcarVcarsCompare | ~vcarsValidL2 | ~rarsCaL2))) ;



assign timeForRequestNoScL2 = fillIdleL2 | (fillWr1L2 & preIdleL2) |
                        (preIdleL2 & filling & ~df_forceOnly1Req) ;

assign timeForRequestScL2 = (fillIdleL2 | (fillWr1L2 & preIdleL2) |
                        (preIdleL2 & filling & ~df_forceOnly1Req)) & scL2 ;

always @ (fillIdleL2 or fillReqL2 or fillFillL2 or
          fillWbL2 or
          fillWr0L2_i or fillWr1L2 or fetchNeedsFill or plbaFtchL2 or
          dsNeedsFill or acceptL2 or plbAbort2L2 or
          full or halfFull or anyPlbError or rarsCaL2 or
          df_ftchMissBlkWr or rarsFetchL2 or priwait4XltV or
          preIdleL2 or preWfL2 or scL2)
 begin
   casez ({
           fillIdleL2, fillReqL2, fillFillL2, fillWbL2, fillWr0L2_i, fillWr1L2,
           fetchNeedsFill, plbaFtchL2, dsNeedsFill, acceptL2, plbAbort2L2,
           full, halfFull, anyPlbError, rarsCaL2, df_ftchMissBlkWr, rarsFetchL2,
           priwait4XltV,
           preIdleL2, preWfL2, scL2
          }) 

//
//Page 34
///////////////////// fill state machine/////////// idle to fill ///////////////
//        fillIdleL2
//        |fillReqL2
//        ||fillFillL2
//        |||fillWbL2
//        ||||fillWr0L2
//        |||||fillWr1L2
//        ||||||
//        ||||||  fetchNeedsFill
//        ||||||  |plbaFtchL2
//        ||||||  ||dsNeedsFill
//        ||||||  |||acceptL2
//        ||||||  ||||plbAbort2L2
//        ||||||  |||||
//        ||||||  ||||| full
//        ||||||  ||||| |halfFull
//        ||||||  ||||| ||anyPlbError
//        ||||||  ||||| |||rarsCaL2
//        ||||||  ||||| ||||df_ftchMissBlkWr
//        ||||||  ||||| |||||rarsFetchL2
//        ||||||  ||||| ||||||
//        ||||||  ||||| |||||| priwait4XltV
//        ||||||  ||||| |||||| |
//        ||||||  ||||| |||||| | preIdleL2
//        ||||||  ||||| |||||| | |preWfL2
//        ||||||  ||||| |||||| | ||
//        ||||||  ||||| |||||| | || scL2
//        ||||||  ||||| |||||| | || |
      21'b1?????__0?0??_??????_?_??_?: nxtStFill[0:5] = fillSmIdle ;
      21'b1?????__1????_??????_?_??_?: nxtStFill[0:5] = fillSmReq ;
      21'b1?????__??1??_??????_?_??_?: nxtStFill[0:5] = fillSmReq ;

      21'b?1????__?????_??????_?_??_0: nxtStFill[0:5] = fillSmReq ;
      21'b?1????__???00_??????_?_??_?: nxtStFill[0:5] = fillSmReq ;
      21'b?1????__???01_??????_?_??_1: nxtStFill[0:5] = fillSmIdle ;
      21'b?1????__???1?_??????_?_??_1: nxtStFill[0:5] = fillSmFill ;

      21'b??1???__?????_00????_?_??_?: nxtStFill[0:5] = fillSmFill ;
      21'b??1???__?????_?1????_?_?0_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b??1???__?????_?1????_?_?1_?: nxtStFill[0:5] = fillSmFill ;
      21'b??1???__?????_1??0??_?_?0_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b??1???__?????_1??0??_?_?1_?: nxtStFill[0:5] = fillSmFill ;
      21'b??1???__?????_1?01?0_?_??_?: nxtStFill[0:5] = fillSmWb ;
      21'b??1???__?????_1?0101_?_??_?: nxtStFill[0:5] = fillSmWb ;
      21'b??1???__?????_1???11_?_?0_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b??1???__?????_1???11_?_?1_?: nxtStFill[0:5] = fillSmFill ;
      21'b??1???__?????_1?1???_?_?0_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b??1???__?????_1?1???_?_?1_?: nxtStFill[0:5] = fillSmFill ;


//
//                                                                     Page 35
///////////////////// fill state machine//////////// wb to wr1 //////////////
//        fillIdleL2
//        |fillReqL2
//        ||fillFillL2
//        |||fillWbL2
//        ||||fillWr0L2
//        |||||fillWr1L2
//        ||||||
//        ||||||  fetchNeedsFill
//        ||||||  |plbaFtchL2
//        ||||||  ||dsNeedsFill
//        ||||||  |||acceptL2
//        ||||||  ||||plbAbort2L2
//        ||||||  |||||
//        ||||||  ||||| full
//        ||||||  ||||| |halfFull
//        ||||||  ||||| ||anyPlbError
//        ||||||  ||||| |||rarsCaL2
//        ||||||  ||||| ||||df_ftchMissBlkWr
//        ||||||  ||||| |||||rarsFetchL2
//        ||||||  ||||| ||||||
//        ||||||  ||||| |||||| priwait4XltV
//        ||||||  ||||| |||||| |
//        ||||||  ||||| |||||| | preIdleL2
//        ||||||  ||||| |||||| | |preWfL2
//        ||||||  ||||| |||||| | ||
//        ||||||  ||||| |||||| | || scL2
//        ||||||  ||||| |||||| | || |
      21'b???1??__?????_??????_0_??_?: nxtStFill[0:5] = fillSmWr0 ;
      21'b???1??__?????_??????_1_??_?: nxtStFill[0:5] = fillSmWb ;
      21'b????1?__?????_??????_?_??_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b?????1__?????_??????_?_00_?: nxtStFill[0:5] = fillSmWr1 ;
      21'b?????1__?????_??????_?_?1_?: nxtStFill[0:5] = fillSmFill ;
      21'b?????1__0?0??_??????_?_1?_?: nxtStFill[0:5] = fillSmIdle ;
      21'b?????1__??1??_??????_?_1?_?: nxtStFill[0:5] = fillSmReq ;
      21'b?????1__1????_??????_?_1?_?: nxtStFill[0:5] = fillSmReq ;

      default:                      nxtStFill[0:5] =  6'bxxxxxx ;

   endcase
 end

//
//Page 36
///////////////////// pre state machine//////////////////////////

//filling doesn't need scL2 but make sure it is qualified every where it is used.

assign filling = fillFillL2 | fillWbL2 |
                 fillWr0L2_i | (fillReqL2 & acceptL2)  ;


always @ (preIdleL2 or preRdL2 or preWfrL2 or preReqL2 or preWfL2 or
          fetchNeedsFill or plbaFtchL2 or dsNeedsFill or acceptL2 or
          plbAbort2L2 or isAbortL2 or fillTakingPre or
          fillIdleL2 or fillWr1L2 or filling or fillReqL2 or
          df_forceOnly1Req or df_preFetchEnable or df_nonCpreFetchEn or
          isCacheableL2 or df_plbaOverflow or scL2 or
          missIn )

 begin
   goingToPreRd = 1'b0;
   casez ({
          preIdleL2, preRdL2, preWfrL2, preReqL2, preWfL2,
          fetchNeedsFill, plbaFtchL2, dsNeedsFill, acceptL2,
          plbAbort2L2, isAbortL2, fillTakingPre,
          fillIdleL2, fillWr1L2, filling, fillReqL2,
          df_forceOnly1Req, df_preFetchEnable, df_nonCpreFetchEn,
          isCacheableL2, df_plbaOverflow, scL2,
          missIn
          }) 

//
//                                                                   Page 37
/////////////////////////////////////////////////////////////////////////////
//        preIdleL2
//        |preRdL2
//        ||preWfrL2
//        |||preReqL2
//        ||||preWfL2
//        |||||
//        ||||| fetchNeedsFill
//        ||||| |plbaFtchL2
//        ||||| ||dsNeedsFill
//        ||||| |||acceptL2
//        ||||| ||||plbAbort2L2
//        ||||| |||||isAbortL2
//        ||||| ||||||
//        ||||| |||||| fillTakingPre
//        ||||| |||||| |fillIdleL2
//        ||||| |||||| ||fillWr1L2
//        ||||| |||||| |||filling
//        ||||| |||||| ||||fillReq
//        ||||| |||||| |||||
//        ||||| |||||| ||||| df_forceOnly1Req
//        ||||| |||||| ||||| |df_preFetchEnable
//        ||||| |||||| ||||| ||df_nonCpreFetchEn
//        ||||| |||||| ||||| |||isCacheableL2
//        ||||| |||||| ||||| ||||df_plbaOverflow
//        ||||| |||||| ||||| |||||
//        ||||| |||||| ||||| ||||| scL2
//        ||||| |||||| ||||| ||||| |
//        ||||| |||||| ||||| ||||| | missIn
//        ||||| |||||| ||||| ||||| | |
      23'b1????_0?0???_?????_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_??1??_?0?1?_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_?1???_?0?1?_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_??1??_??00?_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_?1???_??00?_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_?????_1????_?_?: nxtStPre[0:4] = preSmIdle ;

      23'b1????_??0???_?1???_????1_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??0???_??1??_????1_?_?: nxtStPre[0:4] = preSmIdle ;

      23'b1????_???0??_????1_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??????_????1_?????_0_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??1???_?1???_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b1????_??1???_??1??_?????_?_?: nxtStPre[0:4] = preSmIdle ;

      23'b1????_1?????_?1???_01?10_?_?: begin nxtStPre[0:4] = preSmRd ;
                                              goingToPreRd = 1'b1; end
      23'b1????_1?????_?1???_0?100_?_?: begin nxtStPre[0:4] = preSmRd ;
                                              goingToPreRd = 1'b1; end
      23'b1????_1?????_??1??_01?10_?_?: begin nxtStPre[0:4] = preSmRd ;
                                               goingToPreRd = 1'b1; end
      23'b1????_1?????_??1??_0?100_?_?: begin nxtStPre[0:4] = preSmRd ;
                                              goingToPreRd = 1'b1; end
      23'b1????_1?????_???1?_0????_?_?: nxtStPre[0:4] = preSmReq ;
      23'b1????_??1???_???1?_0????_?_?: nxtStPre[0:4] = preSmReq ;

      23'b?1???_?????1_?????_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b?1???_??????_?????_?????_?_0: nxtStPre[0:4] = preSmIdle ;
      23'b?1???_?????0_?????_?????_?_1: nxtStPre[0:4] = preSmWfr ;

//
//Page 38
/////////////////////////////////////////////////////////////////////////////////
//        preIdleL2
//        |preRdL2
//        ||preWfrL2
//        |||preReqL2
//        ||||preWfL2
//        |||||
//        ||||| fetchNeedsFill
//        ||||| |plbaFtchL2
//        ||||| ||dsNeedsFill
//        ||||| |||acceptL2
//        ||||| ||||plbAbort2L2
//        ||||| |||||isAbortL2
//        ||||| |||||| fillTakingPre
//        ||||| |||||| |fillIdleL2
//        ||||| |||||| ||fillWr1L2
//        ||||| |||||| |||filling
//        ||||| |||||| ||||fillReq
//        ||||| |||||| ||||| df_forceOnly1Req
//        ||||| |||||| ||||| |df_preFetchEnable
//        ||||| |||||| ||||| ||df_nonCpreFetchEn
//        ||||| |||||| ||||| |||isCacheableL2
//        ||||| |||||| ||||| ||||df_plbaOverflow
//        ||||| |||||| ||||| |||||
//        ||||| |||||| ||||| ||||| scL2
//        ||||| |||||| ||||| ||||| |
//        ||||| |||||| ||||| ||||| | missIn
//        ||||| |||||| ||||| ||||| | |
      23'b??1??_?????1_?????_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b??1??_???0?0_?????_?????_?_?: nxtStPre[0:4] = preSmWfr ;
      23'b??1??_?????0_?????_?????_0_?: nxtStPre[0:4] = preSmWfr ;
      23'b??1??_???1?0_?????_?????_1_?: nxtStPre[0:4] = preSmReq ;

      23'b???1?_???01?_?????_?????_1_?: nxtStPre[0:4] = preSmIdle ;
      23'b???1?_???00?_?????_?????_?_?: nxtStPre[0:4] = preSmReq ;
      23'b???1?_??????_?????_?????_0_?: nxtStPre[0:4] = preSmReq ;
      23'b???1?_???1??_?????_?????_1_?: nxtStPre[0:4] = preSmWf ;

      23'b????1_??????_1????_?????_?_?: nxtStPre[0:4] = preSmIdle ;
      23'b????1_??????_0????_?????_?_?: nxtStPre[0:4] = preSmWf ;

      default:                             nxtStPre[0:4] =  5'bxxxxx ;

   endcase
 end

//
//                                                                      Page 39
///////////////////////////////jtag//////////////////////////////////

assign jtag2ndWr = jtagL2[7];

assign jtagE1 = resetCoreL2 | JTG_iCacheWr | PCL_mtSPR | jtagL2[1] | jtagL2[8] ;

assign jtagWrTag = jtagL2[0] & icuTagDataSel & JTG_iCacheWr ;

assign jtagWrVa = jtagWrTag & ~icuBaSel;

assign jtagWrVb = jtagWrTag & icuBaSel;

assign jtagWrData0 = ((jtagL2[0] & ~icuTagDataSel) | jtagL2[4]) & JTG_iCacheWr ;
assign jtagWrData1 = ((jtagL2[1] & ~icuTagDataSel) | jtagL2[5]) & JTG_iCacheWr ;
assign jtagWrData2 = (jtagL2[2] | jtagL2[6]) & JTG_iCacheWr ;
assign jtagWrData3 = (jtagL2[3] | jtagL2[7]) & JTG_iCacheWr ;

//
//Page 40
//////////////////////////////////jtag state machine//////////////////////////

always @ (jtagL2 or icuTagDataSel or JTG_iCacheWr)

 begin
   casez ({jtagL2[0:8], icuTagDataSel,
           JTG_iCacheWr
          }) 


//
//        jtag[0]
//        |jtag[1]
//        ||jtag[2]
//        |||jtag[3]
//        ||||jtag[4]
//        |||||jtag[5]
//        ||||||jtag[6]
//        |||||||jtag[7]
//        ||||||||jtag[8]
//        |||||||||
//        ||||||||| icuTagDataSel
//        ||||||||| |
//        ||||||||| | JTG_iCacheWr
//        ||||||||| | |
      11'b1????????_?_0: nxtStJtag[0:8] = jtag0 ;
      11'b1????????_?_1: nxtStJtag[0:8] = jtag1 ;
      11'b?1???????_1_?: nxtStJtag[0:8] = jtag0 ;
      11'b?1???????_0_0: nxtStJtag[0:8] = jtag1 ;
      11'b?1???????_0_1: nxtStJtag[0:8] = jtag2 ;
      11'b??1??????_?_0: nxtStJtag[0:8] = jtag2 ;
      11'b??1??????_?_1: nxtStJtag[0:8] = jtag3 ;
      11'b???1?????_?_0: nxtStJtag[0:8] = jtag3 ;
      11'b???1?????_?_1: nxtStJtag[0:8] = jtag4 ;
      11'b????1????_?_0: nxtStJtag[0:8] = jtag4 ;
      11'b????1????_?_1: nxtStJtag[0:8] = jtag5 ;
      11'b?????1???_?_0: nxtStJtag[0:8] = jtag5 ;
      11'b?????1???_?_1: nxtStJtag[0:8] = jtag6 ;
      11'b??????1??_?_0: nxtStJtag[0:8] = jtag6 ;
      11'b??????1??_?_1: nxtStJtag[0:8] = jtag7 ;
      11'b???????1?_?_0: nxtStJtag[0:8] = jtag7 ;
      11'b???????1?_?_1: nxtStJtag[0:8] = jtag8 ;
      11'b????????1_?_?: nxtStJtag[0:8] = jtag0 ;
      default:          nxtStJtag[0:8] = 9'bxxxxxxxxx;
   endcase
 end



endmodule

