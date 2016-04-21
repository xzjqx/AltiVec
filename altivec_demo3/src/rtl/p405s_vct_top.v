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

module p405s_vct_top (VCT_errorOut, VCT_msrDR, VCT_msrIR, VCT_wbRfci, VCT_wbRfi, VCT_sxr,
           VCT_swap01, VCT_swap23, VCT_vectorBus, VCT_msrWE, VCT_errorSprSuppress,
           VCT_sprDataBus, VCT_msrDE, VCT_swapQ01, VCT_swapQ23, PLB_dcuErr,
           PCL_wbLdNotSt, PCL_mtSPR, PCL_sprHold, EIC_critIntrp, EIC_extIntrp,
           PCL_algnErr, IFB_exeFlush, PCL_exeCpuOp, IFB_exeIfetchErr, PCL_exeWrExtEn,
           PCL_exePrivOp, IFB_stuffStL2, IFB_swapEnable, CB, coreReset, MMU_dsStatus,
           EXE_wrteeIn, DBG_intrp, DBG_exeIacSuppress, DBG_trapEnQ, TIM_fitIntrp,
           TIM_pitIntrp, PCL_exeTrap, TIM_watchDogIntrp, PGM_pvrBus,
           VCT_exeSuppress, VCT_anySwap, PCL_exeApuOp, DBG_exeSuppress, VCT_msrCE,
           VCT_msrEE, DBG_wbDacSuppress, PCL_exeApuValidOp, VCT_timerIntrp, VCT_sxrOR_L2,
           PCL_exeFull, JTG_stopReq, DBG_stopReq, IFB_runStL2, APU_exception,
           VCT_msrPR, PGM_mmuEn, PCL_dIcmpForWbFlushQDlydL2, EXE_vctSprDcds,
           EXE_sprDataBus, VCT_dcuWbAbort, VCT_wbSuppress, IFB_exeRfi, IFB_exeRfci,
           IFB_exeSc, PCL_wbFull, VCT_dearE2, VCT_wbFlush, PCL_blkFlush, VCT_icuWbAbort,
           PCL_exeDvcHold,  PCL_exeDvcOrParityHold, MMU_dsStateBorC, PCL_exeFpuOp, FPU_exception,
           PCL_wbHold, DBG_udeIntrp, DBG_weakStopReq, VCT_msrFE0, VCT_msrFE1, VCT_msrDWE,
           VCT_wbErrSuppress, VCT_stuffStepSupL2, VCT_srr1DWE, VCT_srr3DWE, IFB_stepStL2,
           VCT_exeBrTrapErrSuppress, VCT_wbFlushAsync, VCT_msrWEL2, PCL_wbStorageOp,
           VCT_wbLoadSuppress, IFB_swapStL2, PCL_exe2Full, JTG_dbgWaitEn,
           IFB_dcdFullL2, VCT_mmuWbAbort, MMU_wbHold, VCT_mmuExeSuppress,
           VCT_exeSuppForApu, DCU_SCL2, PCL_wbHoldNonErr,
           VCT_exeSuppForExe2Clear, VCT_apuWbFlush, VCT_exeSuppForCr, LSSD_coreTestEn,
           JTG_stepUPD, JTG_stuffUPD, MMU_dsParityErr, 
           MMU_tlbSXParityErr, MMU_tlbREParityErr, PCL_dofDregFull, 
           EXE_dofDregParityErrL2, lwbFullL2, IFB_exeISideMachChk, 
           PCL_lwbCacheableL2, ICU_CCR0DPE, ICU_CCR0DPP, 
           ICU_CCR0IPE, ICU_CCR0TPE, DCU_FlushParityError);

    output [0:31] VCT_sprDataBus;
    output [0:11] VCT_sxr;
    output [0:7] VCT_vectorBus;
    output VCT_swap01, VCT_swap23, VCT_swapQ01, VCT_swapQ23, VCT_anySwap;
    output VCT_msrFE0, VCT_msrFE1, VCT_msrPR, VCT_msrDR, VCT_msrIR, VCT_wbRfci, VCT_wbRfi;
    output VCT_msrWEL2, VCT_msrWE, VCT_msrDE, VCT_msrCE, VCT_msrEE, VCT_sxrOR_L2, VCT_msrDWE;
    output VCT_errorSprSuppress, VCT_exeSuppress, VCT_exeSuppForCr, VCT_exeSuppForApu;
    output VCT_exeSuppForExe2Clear, VCT_mmuExeSuppress, VCT_exeBrTrapErrSuppress;
    output VCT_wbSuppress, VCT_wbErrSuppress, VCT_wbLoadSuppress;
    output VCT_dcuWbAbort, VCT_icuWbAbort, VCT_mmuWbAbort;
    output VCT_apuWbFlush, VCT_wbFlush, VCT_wbFlushAsync;
    output VCT_timerIntrp, VCT_stuffStepSupL2, VCT_errorOut;
    output VCT_dearE2, VCT_srr1DWE, VCT_srr3DWE;

    input JTG_stepUPD, JTG_stuffUPD;

    input [0:4] IFB_exeIfetchErr;

    input [0:7] MMU_dsStatus;
    
    input [0:31] EXE_sprDataBus;
    input [0:31] PGM_pvrBus;

    input CB;
    input IFB_stepStL2, IFB_swapStL2, IFB_runStL2, IFB_stuffStL2;
    input IFB_exeRfi, IFB_exeRfci, IFB_exeSc, IFB_dcdFullL2;
    input IFB_swapEnable, IFB_exeFlush;
    input PCL_exeWrExtEn, PCL_exeTrap, PCL_mtSPR, PCL_sprHold;
    input PCL_exePrivOp, PCL_exeCpuOp, PCL_exeApuOp, PCL_exeFpuOp, PCL_exeApuValidOp;
    input PCL_exeFull, PCL_exe2Full, PCL_exeDvcHold;
    input PCL_wbFull, PCL_wbHold, PCL_wbHoldNonErr, PCL_wbLdNotSt, PCL_algnErr;
    input MMU_dsStateBorC, MMU_wbHold, PCL_wbStorageOp, PCL_dIcmpForWbFlushQDlydL2;
    input DBG_intrp, DBG_trapEnQ, DBG_exeIacSuppress, DBG_exeSuppress,  DBG_stopReq;
    input DBG_udeIntrp, DBG_weakStopReq, DBG_wbDacSuppress;
    input TIM_fitIntrp, TIM_pitIntrp, TIM_watchDogIntrp;
    input JTG_stopReq, JTG_dbgWaitEn, PGM_mmuEn, DCU_SCL2;
    input EIC_critIntrp, EIC_extIntrp;
    input APU_exception, FPU_exception, PLB_dcuErr, EXE_wrteeIn;
    input LSSD_coreTestEn, coreReset;
    input [0:2] PCL_blkFlush;

//
//..................Cobra Input/Output Changes .....................................................
//
    input IFB_exeISideMachChk;            // OR of PLB Bus, MMU Iside Parity, 
                                          // and I$ Data or I$ Tag Parity Errors   
    input MMU_dsParityErr;                // From MMU_top.v 
    input MMU_tlbSXParityErr;             // From MMU_top.v
    input MMU_tlbREParityErr;             // From MMU_top.v
    input PCL_exeDvcOrParityHold;         // Logical OR of DVC and Parity Hold    
    input PCL_dofDregFull;
    input EXE_dofDregParityErrL2;         // From new latch in exe_top.v
    input lwbFullL2;                      // From pcl_top.v via pipeCntl.v
    input [0:5] EXE_vctSprDcds;           // Was 7 bits wide, took out mcsrs    
    input ICU_CCR0DPE;                    // From icu_top.v -> Data Cache Parity Enable Bit
    input ICU_CCR0DPP;                    // From icu_top.v -> Data Cache Parity Precision Bit
    input ICU_CCR0IPE;                    // From icu_top.v -> Instruction Cache Parity Enable Bit
    input ICU_CCR0TPE;                    // From icu_top.v -> Translation Lookaside 
                                          //                   Buffer Parity Enable Bit
    input PCL_lwbCacheableL2;             // From free running LWB control latch
                                          // in pipeCntl.v (through pcl_top.v)
    input DCU_FlushParityError;           // From dcu_top.v through core_top.v, etc
    

// Changes:
// 02/23/99 SBP Change the VCT_dcuWbAbort and VCT_mmuWbAbort equation. See issue 28 pass2 for more detail.
// 02/24/99 SBP Added VCT_apuWbFlush output.
// 02/26/99 SBP Added VCT_exeSuppForCr output.
// 03/05/99 SBP Removed failedTakeOVer of Divide by APU from program exception. APU does not assert apuOp for
//              divide which is executed by apu. Only validOp, divEn and apuPresent should be tied 1.
// 05/05/99 SBP Removed VCT_ocmAbortReq signal. ocmAbortReq is only PCL_exeAbort.
// 05/17/99 SBP Created 3 copy of PCL_blkFlush to improve VCT_apuWbFlush timing.
// 02/17/00 SBP Changed nxtStuffStepSup equation. See issue 171 for detail.
// 03/13/00 SBP Added Overrun, StepUPD, StuffUPD input for issue 171.
// 03/15/00 SBP Added JTG_step, JTG_stuff input for issue 171.
// 03/15/00 SBP Changed the mind, remove JTG_step, JTG_stuff, JTG_overrun input for issue 171.

//*********************************************************************************************************//
//.........................COBRA Changes...................................................................//
//*********************************************************************************************************//
//
//   DATE            WHO                             DESCRIPTION
// ~~~~~~~~~       ~~~~~~~                         ~~~~~~~~~~~~~~~
//  07/20/01         JBB           Initial logic entry per Cobra Workbook:
//
//                             (1) Added new inputs IFB_exeISideMachChk, MMU_dsParityErr, 
//                                 MMU_tlbSXParityErr, MMU_tlbREParityErr, PCL_exeDvcOrParityHold,
//                                 PCL_dofDregFull, EXE_dofDregParityErrL2, lwbFullL2, and PCL_lwbCacheableL2
//                                 
//                             (2) Added an equation for nxtParityErr and included its 
//                                 L2 signal in machCheckDsideQual
//
//                             (3) Added a new parity error latch (regVCT_parErr)
//
//                             (4) Changed the Scanout (SO) of regVCT_reset
//
//                             (5) Added the new MCSR register (regVCT_mcsr)  
//
//                             (6) Added Hw and Sw set equations for the MCSR
//
//                             (7) Added a new mux (muxVCT_sprMcsr) for selecting between the old
//                                 vctSprDataBus and the new data from the MCSR register    
//
//                             (8) Widened the EXE_vctSprDcds bus
//
//---------------------------------------------------------------------------------------------------------//
// 08/08/01         JBB        Changed equation for machCheckDsideQual (defect 1815)
//---------------------------------------------------------------------------------------------------------//
// 08/17/01         JBB        (1) Added DCU_FlushParityError to mcsr equations      (defect 1835)
//                             (2) Rearranged MCSR bits to match Avenger MCSR setup
//                                 See comments in MCSR hardware set equations
//                             (3) Widened the MCSR register by two bits (D$ Flush Parity and
//                                 reserved bit 3)                    
//---------------------------------------------------------------------------------------------------------//
// 08/28/01         JBB        (1) Took out ~sxrExeTypeHold from MCSR hardware set
//                                 equations and replaced it with ~esrExeTypeHold.
//                             (2) Removed MCSR[3] (was assigned to zero going into
//                                 the MCSR mux).  Changed this in the mcsr mux also.
//                             (3) Added mcsrIsideMachChkIn and mcsrDsideMachChkIn
//                                 into the mcsr register.  These are used to cause
//                                 IMCs and DMCs by software only. 
//                             (4) Split up bits in the MCSR register (note 2).
//                             (5) Added mcsrIsideMachChkIn and mcsrDsideMachChkIn
//                                 into iSideMachChkSet and machCheckDsideQual
//                                 (defect 1861)
//---------------------------------------------------------------------------------------------------------//
// 09/25/01         JBB        (1) Split up iSideMachChkSet and defined a new wire/signal
//                                 (asyncIsideMachChkSet) to cover IMCs caused by MCSR sets.
//                             (2) Brought asyncIsideMachChkSet into other async type equations
//                                 (wbFlushAsyncForWbFlush and wbFlushAsync).
//                             (3) Added ~asyncIsideMachChkSet to qual equations of lower 
//                                 priority interrupts (dbgIntrpQual,critIntrpQual,
//                                 watchDogIntrpQual,extIntrpQual, fitIntrpQual, pitIntrpQual).
//                             (4) Ored sxr[6] and asynchronous IMC and put into priority
//                                 logic's case statement.
//                             (5) Added asyncIsideMachChkSet to all suppress logic that previously
//                                 contained iSideMachChkSet.
//                             (6) Added asyncIsideMachChkSet to equation for VCT_anySwap.
//                             (7) Added it to equation for esrExeTypeHold.
//                             (8) Broke up swSetMcsr and swResetMcsr bits to elimenate a
//                                 read/write of bit 3
//                                 (defect 1894)
//---------------------------------------------------------------------------------------------------------//
// 09/27/01         JBB        (1) Added asyncIsideOrSxrSix to the always@ term of priority
//                                 sxr priority block.
//                                 (defect 1916) 
//---------------------------------------------------------------------------------------------------------// 
// 10/05/01         JBB        Widened dp_regVCT_mcsr.  Put the imprecise bit first
//                             (formality reasons)
//                             (defect 1935)                       
//---------------------------------------------------------------------------------------------------------// 
// 10/11/01         JBB        (1) Added an imprecise bit in the MCSR to update
//                                 during asynchronous machine check events.
//                             (2) Changed dp_muxVCT_sprMcsr back to a 2:1 from a 3:1
//                                 Pulled out CCR1 leg of it. (defect 1955) 
//---------------------------------------------------------------------------------------------------------// 
// 10/17/01         JBB        Made changes which were recommended in 10/16/01 logic reviews:
//                             (1) Added terms to the nxtParityErr latch for servicing 
//                                 single and multiple flush parity errors.
//                             (2) Removed mcsrDsideMachChkLtch from machCheckDsideQual equation.
//                             (3) Removed asyncIsideMachChkSet and asyncIsideOrSxrSix from ESR, SXR
//                                 suppress control, and interrupt vector priority logic.  
//                             (4) Added ~IFB_exeIfetchErr[3] (TLB Error) to isiSet equations
//                             (5) Removed MCSR[11] (imprecise/async bit) from MCSR.  Took it out of
//                                 muxVCT_sprMcsr and regVCT_mcsr also.
//                             (6) Removed mcsrSetAccess, mcsrsDcd, and swSetMcsr from MCSR logic. 
//                                 No software set access at all in new level.
//                             (7) Removed mcsrIsideMachChkIn and mcsrDsideMachChkIn
//                             (8) Added wires for SO chains (resolve verilint warnings)
//                             (9) Removed dpReg_VCTparErr latch and added parityErrLtch bit
//                                 to dp_regVCT_sxr latch.  Widened the latch by one bit (to 18 bits).
//                                 Changed SI and SO chain accordingly. 
//                                 (defect 1971)
//---------------------------------------------------------------------------------------------------------// 
//*********************************************************************************************************//
//

reg        resetL2;

wire VCT_swap01, VCT_swap23, VCT_wbRfi, VCT_wbRfci;
reg VCT_swap01_i, VCT_swap23_i, VCT_wbRfi_i, VCT_wbRfci_i;  //internal nodes
assign VCT_swap01 = VCT_swap01_i;
assign VCT_swap23 = VCT_swap23_i;
assign VCT_wbRfi = VCT_wbRfi_i;
assign VCT_wbRfci = VCT_wbRfci_i;

wire [0:7] VCT_vectorBus; 
reg [0:7] VCT_vectorBus_i;  // Address bits 18:23, 26:27 // internal node
assign VCT_vectorBus = VCT_vectorBus_i;  

reg [0:2] msrRstMask;
reg [0:9] esrInput;
reg [0:13] msrFb;

wire machCheckDsideQual; 
wire dbgIntrpQual; 
wire watchDogIntrpQual, extIntrpQual;
wire fitIntrpQual, pitIntrpQual, fpuUnimplementedSet;
wire dsMachChkVctr, nxtDcuErr, dcuErrLtch, illegalOpSet, apuExcSet;
wire esrWrite, critIntrpQual, dsiSet, anyStopQual, fpuExcSet;
wire algnSet, iiSet, scSet, rfiSet, rfciSet, isiSet, dMissSet;
wire msrrSprWr, privViolSet, trapSet, iSideMachChkSet, iMissSet;
wire isiZoneSet, isiExSet, sxrOR_L2, dsiU0Set, extIntrpL2, critIntrpL2;
wire msrVEC, msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,msrME,msrFE0,msrDWE,msrDE;
wire msrFE1,msrIR,msrDR, wbFlushAsync, sxrExeTypeHold, apuUnimplementedSet;
wire apuUnavailableSet, srr3Dcd, msrDcd, srr1Dcd, esrDcd, pvrDcd;
wire dbgUdeIntrpQual, fpuUnavailableSet, esrDmissSet, esrExeTypeHold, esrDsiSet;
wire msrrE2; 
wire nxtStuffStepSup,  wbFlushAsyncForWbFlush;
wire VCT_wbSuppress_i;
wire VCT_dcuWbAbort_i;
wire VCT_wbFlush_i;
wire VCT_stuffStepSupL2_i;


wire [0:11] sxrHold, setSxr, rstSxr, sxr, sxrInput;
wire [0:13] sprMsrr, srr13, msr, srr13MsrForLSSD;
reg [0:13] srr1, srr3;
reg [0:13] srr1_Reg_DataIn;
wire [0:13] srr1_MuxD1;
reg [0:13] srr3_Reg_DataIn;
wire [0:13] srr3_MuxD1;
wire [0:1] srr3MuxSel, srr1MuxSel, msrMuxSel;
reg [0:17] sxr_Reg;
reg [0:17] sxr_Reg_DataIn;
wire [0:17] sxr_MuxD0;
reg [0:9] esr;
reg [0:9] esr_Reg_DataIn;
wire nxtParityErr;
wire parityErrLtch;

// msr[0] -> regBit[06] VEC bit.
// msr[1] -> regBit[12] APE bit.
// msr[2] -> regBit[13] WE bit.
// msr[3] -> regBit[14] CE bit.
// msr[4] -> regBit[16] EE bit.
// msr[5] -> regBit[17] PR bit.
// msr[6] -> regBit[18] FPA bit.
// msr[7] -> regBit[19] ME bit.
// msr[8] -> regBit[20] FE0 bit.
// msr[9] -> regBit[21] DWE bit.
// msr[10]-> regBit[22] DE bit.
// msr[11]-> regBit[23] FE1 bit.
// msr[12]-> regBit[26] IR bit.
// msr[13]-> regBit[27] DR bit.

// Turn off swap requests due to non-program type interrupts because:
// a stuffed instruction is expected to complete if the sxr bits
// (which are available to the jtag interface for reading via the jdsr)
// are all off before the instruction is stuffed.

// For Core + ASICs the PLB_dcuErr will be a pulse from the BCU.  So, the irpt logic
// must remember the bus error until it gets vectored to.  This is done by holding the
// input to dcuErr bit of the free running latch until the dsMachChk vector occurs.

//  NOTE NEEDS TO BE MODIFIED FROM TESTPLAN................
// For the SXR rules below, the following catagories apply:
//   I. The bit sxr[x] is trying to set and can be set simultaneously with sxr[y].
//  II. The bit sxr[x] is trying to set when sxr[y] is already set.
//       a. Immediate swapEnable prevents setting due to reset dominance.
//       b. Delayed swapEnable allows setting.
//
// sxr[x]         sxr[y]            Setting Priority
// ======         ======            ================
// sxr[0]:     I. sxr[1,8]          sxr[0] beats sxr[1]
//                                  sxr[0] beaten by sxr[8]
//            II. sxr[2,6,7,9]      sxr[0] beaten by sxr[2,6,7,9]
//                [2] for priv
//                only
//
//                                                                                           Priority
// sxr[0] -> DSI                                                                                2
// sxr[1] -> alignment class                                                                    3
// sxr[2] -> Priv,trap,ApuExc,FpuExc,ApuUnimp,FpuUnimp,TrueIllegalOp
// sxr[3] -> sc                                                                                 9
// sxr[4] -> rfi                                                                               10
// sxr[5] -> rfci                                                                              11
// sxr[6] -> i-side Machine check                                                               6
// sxr[7] -> isi                                                                                4
// sxr[8] -> d-side TLB miss                                                                    1
// sxr[9] -> i-side TLB miss                                                                    5
// sxr[10] -> FPU Unavailable                                                                   7
// sxr[11] -> APU Unavailable                                                                  12
//
// issue 171 changes
// Old Equation.
//assign nxtStuffStepSup = 
//      (((|setSxr[0:2]) | (|setSxr[6:11])) & (IFB_stuffStL2 | IFB_stepStL2) &   //setTerm
//     ~IFB_swapEnable & JTG_dbgWaitEn & msrDWE) |
//     (VCT_stuffStepSupL2 & ~(((IFB_stuffStL2 | IFB_stepStL2) & IFB_dcdFullL2 & //resetTerm
//     ~PCL_exeFull & ~PCL_exe2Full & ~PCL_wbFull) | resetL2));

assign nxtStuffStepSup = 
      (((|setSxr[0:2]) | (|setSxr[6:11])) & (IFB_stuffStL2 | IFB_stepStL2) &     //setTerm
      ~IFB_swapEnable & JTG_dbgWaitEn & msrDWE) |
      (VCT_stuffStepSupL2_i & ~resetL2 & ~(JTG_stepUPD | JTG_stuffUPD));         //resetTerm

assign dsMachChkVctr = (VCT_vectorBus_i[0:7] == 8'h08) & IFB_swapEnable;
assign nxtDcuErr = (PLB_dcuErr & DCU_SCL2) | (dcuErrLtch & ~dsMachChkVctr);

assign nxtParityErr = 
    (lwbFullL2 & PCL_lwbCacheableL2 & EXE_dofDregParityErrL2 & PCL_dofDregFull & ICU_CCR0DPE) |               
    ((MMU_dsParityErr | MMU_tlbSXParityErr | MMU_tlbREParityErr) & ICU_CCR0TPE) |                     
    (DCU_FlushParityError & ICU_CCR0DPE) | (parityErrLtch & ~dsMachChkVctr);
                      
assign machCheckDsideQual = 
   (dcuErrLtch | parityErrLtch) & msrME & ~PCL_blkFlush[0] & ~IFB_stuffStL2;

//msrDE ANDed in DBG.
assign dbgUdeIntrpQual = DBG_udeIntrp & ~PCL_blkFlush[0] & ~IFB_stuffStL2;

//msrDE ANDed in DBG.
assign dbgIntrpQual = DBG_intrp & ~PCL_blkFlush[0] & ~IFB_stuffStL2;
assign critIntrpQual = critIntrpL2 & msrCE & ~PCL_blkFlush[0] & ~IFB_stuffStL2;
assign watchDogIntrpQual = TIM_watchDogIntrp & msrCE & ~PCL_blkFlush[1] & ~IFB_stuffStL2;
assign extIntrpQual = extIntrpL2 & msrEE & ~PCL_blkFlush[1] & ~IFB_stuffStL2;
assign fitIntrpQual = TIM_fitIntrp & msrEE & ~PCL_blkFlush[1] & ~IFB_stuffStL2; 
assign pitIntrpQual = TIM_pitIntrp & msrEE & ~PCL_blkFlush[1] & ~IFB_stuffStL2;

//************************************************************************
// Interrupt Vector Priority Logic
//************************************************************************

always @(sxr or machCheckDsideQual or dbgIntrpQual or critIntrpQual or
         watchDogIntrpQual or extIntrpQual or fitIntrpQual or pitIntrpQual)
begin
   // init to zero, 1'b1 values in case statement;
   VCT_vectorBus_i[0:7] = 8'h00;
   casez({sxr[8],sxr[0:1],sxr[7],sxr[9],sxr[6],sxr[10],sxr[2:5],
          sxr[11],machCheckDsideQual,dbgIntrpQual,critIntrpQual,
          watchDogIntrpQual,extIntrpQual,fitIntrpQual,pitIntrpQual})
      // Removed full_case and parallel_case statements
      // No interrupts.
      19'b000_000_00_000_0_0000000:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h00; 
         msrRstMask[0:2] = 3'b000;
      end
      // pit interrupt, clear VEC,EE,WE,PR,DR,IR, vector address 1000h, use srr0,1.
      19'b000_000_00_000_0_0000001:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h40; 
         msrRstMask[0:2] = 3'b001;   //class 1 type reset
      end
      // fit interrupt, clear VEC,EE,WE,PR,DR,IR, vector address 1010h, use srr0,1.
      19'b000_000_00_000_0_000001?:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h41; 
         msrRstMask[0:2] = 3'b001;
      end
      // ext interrupt, clear VEC,EE,WE,PR,DR,IR, vector address 0500h, use srr0,1.
      19'b000_000_00_000_0_00001??:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h14; 
         msrRstMask[0:2] = 3'b001;
      end
      // watchDog interrupt, clear VEC,EE,WE,PR,CE,DE,DR,IR, vector address 1020h, use srr2,3.
      // Note: CE and DE added for Class 2.
      19'b000_000_00_000_0_0001???:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b1; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h42; 
         msrRstMask[0:2] = 3'b010;   //class 2 type reset
      end
      // critical interrupt, clear VEC,EE,WE,PR,CE,DE,DR,IR, vector address 0100h, use srr2,3.
      19'b000_000_00_000_0_001????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b1; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h04; 
         msrRstMask[0:2] = 3'b010;
      end
      // debug interrupt, clear VEC,EE,WE,PR,CE,DE,DR,IR, vector address 2000h, use srr2,3.
      19'b000_000_00_000_0_01?????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b1; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h80; 
         msrRstMask[0:2] = 3'b010;
      end
      // D-side machine check, clear VEC,EE,WE,PR,CE,DE,ME,DR,IR, vector address 0200h, use srr2,3.
      // Note: Me added for class 3.
      19'b000_000_00_000_0_1??????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b1; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h08; 
         msrRstMask[0:2] = 3'b100;   //class 3 type reset
      end
      // apu unavailable, clear VEC,EE,WE,PR,DR,IR, vector address 0F20h, use srr0,1.
      19'b?00_000_?0_???_1_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h3e; 
         msrRstMask[0:2] = 3'b001;
      end
      // rfci, msr <- srr3.
      19'b?00_000_?0_??1_?_???????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b1;
         msrRstMask[0:2] = 3'b000;
      end
      // rfi, msr <- srr1.
      19'b?00_000_?0_?1?_?_???????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b1; 
         VCT_wbRfci_i = 1'b0;
         msrRstMask[0:2] = 3'b000;
      end
      // system call, clear VEC,EE,WE,PR,DR,IR, vector address 0C00h, use srr0,1.
      19'b?00_000_??_1??_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h30; 
         msrRstMask[0:2] = 3'b001;
      end
      // illegal instr or trap or priv, clear VEC,EE,WE,PR,DR,IR, vector address 0700h, use srr0,1.
      19'b?00_000_01_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h1c; 
         msrRstMask[0:2] = 3'b001;
      end
      // fpu unavailable, clear VEC,EE,WE,PR,DR,IR, vector address 0800h, use srr0,1.
      19'b?00_000_1?_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h20; 
         msrRstMask[0:2] = 3'b001;
      end
      // I-side machine check, clear VEC,EE,WE,PR,CE,DE,ME,DR,IR, vector address 0200h, use srr2,3.
      19'b?00_001_??_???_?_???????:begin
         VCT_swap01_i = 1'b0; 
         VCT_swap23_i = 1'b1; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h08; 
         msrRstMask[0:2] = 3'b100;
      end
      // I-side TLB miss, clear VEC,EE,WE,PR,DR,IR, vector address 1200h, use srr0,1.
      19'b?00_?1?_??_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h48; 
         msrRstMask[0:2] = 3'b001;
      end
      // ISI (protection, fetch to G=1/IR=1), clear VEC,EE,WE,PR,DR,IR, vector address 0400h, use srr0,1.
      19'b?00_1??_??_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h10; 
         msrRstMask[0:2] = 3'b001;
      end
      // alignment error or dcbz to non-cacheable, or dcbz to write-thru
      // congruence class, clear VEC,EE,WE,PR,DR,IR, vector address 0600h, use srr0,1.
      19'b?01_???_??_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h18; 
         msrRstMask[0:2] = 3'b001;
      end
      // DSI protection, clear VEC,EE,WE,PR,DR,IR, vector address 0300h, use srr0,1.
      19'b?1?_???_??_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h0c; 
         msrRstMask[0:2] = 3'b001;
      end
      // D-side TLB miss, clear VEC,EE,WE,PR,DR,IR, vector address 1100h, use srr0,1.
      19'b1??_???_??_???_?_???????:begin
         VCT_swap01_i = 1'b1; 
         VCT_swap23_i = 1'b0; 
         VCT_wbRfi_i = 1'b0; 
         VCT_wbRfci_i = 1'b0;
         VCT_vectorBus_i[0:7] = 8'h44; 
         msrRstMask[0:2] = 3'b001;
      end
      // x catcher.
      default:begin
         VCT_swap01_i = 1'bx; 
         VCT_swap23_i = 1'bx; 
         VCT_wbRfi_i = 1'bx; 
         VCT_wbRfci_i = 1'bx;
         VCT_vectorBus_i[0:7] = 8'hxx; 
         msrRstMask[0:2] = 3'bxxx;
      end
   endcase
end //always

//************************************************************************
// MSR Cntl Logic
//************************************************************************
// MSR settings
assign msr[0:13] = {msrVEC,msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,
                    msrME,msrFE0,msrDWE,msrDE,msrFE1,msrIR,msrDR};

always @(resetL2 or IFB_swapEnable or PCL_exeWrExtEn or msrRstMask or msr or
         msrWE or msrCE or msrPR or msrME or msrDE or EXE_wrteeIn or
         msrIR or msrDR or msrVEC or msrAPE or msrFE0 or msrFE1 or msrFPA or msrDWE)
  casez({resetL2,IFB_swapEnable,PCL_exeWrExtEn,msrRstMask})
    // use feedback path.
    6'b000???: msrFb = msr;
    // write EE bit instruction.
    6'b001???: msrFb = {msrVEC,msrAPE,msrWE,msrCE,EXE_wrteeIn,msrPR,msrFPA,msrME,
                  msrFE0,msrDWE,msrDE,msrFE1,msrIR,msrDR};
    // swap for wbRfi, wbRfci use msr as fb, (doesn't really matter).
    // on the schematic the appropriate srr is selected.
    6'b01?000: msrFb = msr; 
    // swap where only VEC,WE,EE,PR,FPA,IR,DR (class 1 reset) are cleared in msr.
    6'b01???1: msrFb = {3'b000,msrCE,3'b000,msrME,2'b00,msrDE,3'b00};
    // swap where VEC,WE,EE,PR,FPA,CE,DE,IR,DR (class 2 reset) are cleared in msr.
    6'b01??1?: msrFb = {7'b0000000,msrME,6'b000000};
    // swap where VEC,WE,EE,PR,FPA,CE,DE,ME,IR,DR (class 3 reset) are cleared in msr.
    6'b01?1??: msrFb = {14'b00000000000000};
    // reset - all msr bits are cleared.
    6'b1?????: msrFb = 14'b00000000000000;
    // x catcher.
    default: msrFb = 14'bxxxxxxxxxxxxxx;
  endcase

//************************************************************************
// SXR Cntl Logic
//************************************************************************
// sxr bit definition:
//                                                                                           Priority
// sxr[0] -> DSI                                                                                2
// sxr[1] -> alignment class                                                                    3
// sxr[2] -> Priv,trap,ApuExc,FpuExc,ApuUnimp,FpuUnimp,TrueIllegalOp
// sxr[3] -> sc                                                                                 9
// sxr[4] -> rfi                                                                               10
// sxr[5] -> rfci                                                                              11
// sxr[6] -> i-side Machine check                                                               6
// sxr[7] -> isi                                                                                4
// sxr[8] -> d-side TLB miss                                                                    1
// sxr[9] -> i-side TLB miss                                                                    5
// sxr[10] -> FPU Unavailable                                                                   7
// sxr[11] -> APU Unavailable                                                                  12
//
// MMU_dsStatus bit definition:
//
// [0] - Zone fault from the UTLB
// [1] - Write Fault from the UTLB
// [2] - Miss in UTLB
// [3] - Alignment in UTLB
// [4] - U0 attribute exception in UTLB
// [5] - Write Fault from the Shadow
// [6] - Alignment exception from the Shadow
// [7] - U0 attribute exception from the Shadow
//
// IFB_exeIfetchErr bit definition:
//
// [0] - Machine Check
// [1:2] 00 None
//       01 Zone Fault
//       10 EX Fault (EX=0, G=1)
//       11 I-Miss
//

assign dsiU0Set = MMU_dsStatus[4] | MMU_dsStatus[7];
assign dsiSet = ((|MMU_dsStatus[0:1]) | (|MMU_dsStatus[4:5]) | MMU_dsStatus[7]) & ~sxrOR_L2;
assign dMissSet = MMU_dsStatus[2] & ~sxrOR_L2;

assign algnSet = 
   ((PCL_algnErr & ~MMU_dsStateBorC) | MMU_dsStatus[3] | MMU_dsStatus[6]) & ~sxrOR_L2 & ~MMU_dsStatus[2];

// A privileged violation occurs when in PRoblem state and executing a
// privileged instruction. Stuffed instructions operate in privileged
// mode even if the msrPR says problem state.
assign privViolSet = PCL_exePrivOp & msrPR & ~IFB_stuffStL2;

// Don't let trap set sxr if it will cause a dbg intrp or dbg stop.
assign trapSet = PCL_exeTrap & ~ DBG_trapEnQ;

assign apuUnavailableSet = ~msrVEC & PCL_exeApuOp & ~PCL_exeCpuOp;
assign fpuUnavailableSet = ~msrFPA & PCL_exeFpuOp;
assign apuExcSet = msrVEC & APU_exception & msrAPE & PCL_exeApuOp;
assign fpuExcSet = msrFPA & FPU_exception & (msrFE0 | msrFE1) & PCL_exeFpuOp;
assign apuUnimplementedSet = msrVEC & PCL_exeApuOp & ~PCL_exeApuValidOp;
assign fpuUnimplementedSet = msrFPA & PCL_exeFpuOp & ~PCL_exeApuValidOp;
//added by clp,PCL_exeApuOp is the signal to indicate whether this is a Valid APU instruction
assign illegalOpSet = ~PCL_exeApuOp & ~PCL_exeFpuOp & ~PCL_exeCpuOp & PCL_exeFull;
assign iiSet = privViolSet | trapSet | apuExcSet | fpuExcSet |
               fpuUnimplementedSet | apuUnimplementedSet | illegalOpSet;
assign scSet = IFB_exeSc;
assign rfiSet = IFB_exeRfi;
assign rfciSet = IFB_exeRfci;
assign   iSideMachChkSet      = IFB_exeISideMachChk  & msrME;
assign isiZoneSet = ~IFB_exeIfetchErr[1] & IFB_exeIfetchErr[2] & ~IFB_exeIfetchErr[3];
assign isiExSet   = IFB_exeIfetchErr[1] & ~IFB_exeIfetchErr[2] & ~IFB_exeIfetchErr[3];
assign isiSet = (isiZoneSet | isiExSet) & ~IFB_exeIfetchErr[3] ;
assign iMissSet = IFB_exeIfetchErr[1] & IFB_exeIfetchErr[2];
assign anyStopQual = (DBG_stopReq | JTG_stopReq | DBG_weakStopReq) &
                      ~PCL_blkFlush[2] & IFB_runStL2;
assign wbFlushAsyncForWbFlush = machCheckDsideQual | extIntrpQual | critIntrpQual |
                                watchDogIntrpQual  | fitIntrpQual | pitIntrpQual  |
                                dbgUdeIntrpQual    | anyStopQual;
assign wbFlushAsync = (machCheckDsideQual | extIntrpQual | critIntrpQual |
                       watchDogIntrpQual | fitIntrpQual | pitIntrpQual |
                       dbgUdeIntrpQual | anyStopQual) &
                       (IFB_runStL2 | IFB_swapStL2 | (IFB_stepStL2 & (DBG_stopReq | JTG_stopReq)));
assign VCT_wbFlushAsync = wbFlushAsync;
assign sxrExeTypeHold = DBG_exeIacSuppress | DBG_wbDacSuppress | PCL_exeDvcOrParityHold |
                        PCL_wbHold | IFB_exeFlush;
assign sxrHold[0:11] = {{2{wbFlushAsync}},{6{sxrExeTypeHold}},
                         wbFlushAsync,{3{sxrExeTypeHold}}};
assign setSxr[0:11] = ({dsiSet,algnSet,iiSet,scSet,rfiSet,rfciSet,iSideMachChkSet,
                       isiSet,dMissSet,iMissSet,fpuUnavailableSet,apuUnavailableSet})
                      & ~sxrHold[0:11];
assign rstSxr[0:11] = {12{IFB_swapEnable}};
assign sxrInput[0:11] = (sxr | setSxr) & ~rstSxr;
assign VCT_sxr[0:11] = sxr[0:11];

//************************************************************************
// ESR Cntl Logic
//************************************************************************
// esr bit definition:

// esr[0] -> regBit[0] - i-side machine check

// esr[1:3] --> regBit[4:6] - are just syndrome for the program vector.
// bit 1 - illegalOp detected.
// bit 2 - privileged Error.
// bit 3 - trap detected.

// esr[4] -> regBit[7] - Enabled but Unimplemented fpu or apu.
//                       Works with regBits 12 and 13. When bit 12 or 13 is set and
//                       regBit[7] = 0 then the exception is due to FPU_cpuException or
//                       APU_cpuException and indicated by bit 12 and 13.
//                       When regBit 12 or 13 is set and regBit 7 = 1 then the exception
//                       is due to fpu or apu available but unimplemented as indicated by
//                       bit 12 and 13.
// esr[5:6] --> regBit[8:9] - are set for DSI/ISI
// bit 5 - excepting DSI operation was a store-type (includes dcbz, dcbi, dccci)
// bit 6 - excepting condition was a zone fault
// esr[7] --> regBit[12] - FPU - Enabled but unimplemented or FPU_cpuException.
// esr[8] --> regBit[13] - APU - Enabled but unimplemented or APU_cpuException.
// esr[9] --> regbit[16] - set if a DSI interrupt due to a U0 FAULT occurs.


assign esrWrite = PCL_mtSPR & esrDcd & ~PCL_sprHold;
assign esrExeTypeHold = DBG_exeIacSuppress | DBG_wbDacSuppress | PCL_exeDvcOrParityHold | iMissSet | 
                        PCL_wbHold | IFB_exeFlush | MMU_dsStatus[5] | MMU_dsStatus[7] |
                        PCL_algnErr | MMU_dsStatus[6];
assign esrDmissSet = dMissSet & ~wbFlushAsync;
assign esrDsiSet = dsiSet & ~wbFlushAsync;

always @(esrExeTypeHold or msrME or EXE_sprDataBus or illegalOpSet or
         esrDmissSet or privViolSet or trapSet or esrWrite or dsiU0Set or
         esrDsiSet or esr or MMU_dsStatus or PCL_wbLdNotSt or 
         fpuUnimplementedSet or apuExcSet or isiZoneSet or isiSet or
         fpuExcSet or IFB_exeIfetchErr or apuUnimplementedSet)
   casez({esrDmissSet,esrDsiSet,esrExeTypeHold,msrME,IFB_exeIfetchErr[0],
          isiSet,fpuUnimplementedSet,fpuExcSet,illegalOpSet,
           privViolSet,trapSet,apuUnimplementedSet,apuExcSet,esrWrite})     
      // nothing happening.
      14'b00_??0_0_00_000_00_0: esrInput[0:9] = esr[0:9];
      // spr write path (mtspr of esr)
      14'b??_??0_?_??_???_??_1: esrInput[0:9] = {EXE_sprDataBus[0],EXE_sprDataBus[4:9],
                                     EXE_sprDataBus[12:13],EXE_sprDataBus[16]};
      // apu exception status.
      14'b??_0?0_0_??_?0?_01_?: esrInput[0:9] = {esr[0],9'b000000010};
      // apu unimplemented intrpt status.
      14'b??_0?0_0_??_?0?_1?_?: esrInput[0:9] = {esr[0],9'b000100010};
      // trap status.
      14'b??_??0_?_??_??1_??_?: esrInput[0:9] = {esr[0],9'b001000000};
      // privileged violation status.
      14'b??_0?0_0_??_?1?_??_?: esrInput[0:9] = {esr[0],9'b010000000};
      // illegalOp  status.
      14'b??_0?0_0_??_1??_??_?: esrInput[0:9] = {esr[0],9'b100000000};
      // fpu exception status.
      14'b??_0?0_0_01_???_??_?: esrInput[0:9] = {esr[0],9'b000000100};
      // fpu unimplemented intrpt status.
      14'b??_0?0_0_1?_???_??_?: esrInput[0:9] = {esr[0],9'b000100100};
      // ISI ESR sets.
      14'b??_0??_1_??_???_??_?: esrInput[0:9] = {esr[0],5'b00000,isiZoneSet,3'b000};

      // i-side bus error with msrME =0 and no other sets.
      14'b??_001_0_00_000_00_0: esrInput[0:9] = {1'b1,esr[1:9]};
      //  i-side bus error with msrME =0 and spr write path.
      14'b??_?01_?_??_???_??_1: esrInput[0:9] = {1'b1,EXE_sprDataBus[4:9],
                                                  EXE_sprDataBus[12:13],EXE_sprDataBus[16]};
      // i-side bus error with msrME =0 and apu exception status.
      14'b??_001_0_??_?0?_01_?: esrInput[0:9] = 10'b1000000010;
      // i-side bus error with msrME =0 and apu unimplemented intrpt status.
      14'b??_001_0_??_?0?_1?_?: esrInput[0:9] = 10'b1000100010;
      // i-side bus error with msrME =0 and trap status.
      14'b??_?01_0_??_??1_??_?: esrInput[0:9] = 10'b1001000000;
      // i-side bus error with msrME =0 and privileged violation status.
      14'b??_001_0_??_?1?_??_?: esrInput[0:9] = 10'b1010000000;
      // i-side bus error with msrME =0 and illegalOp  status.
      14'b??_001_0_??_1??_??_?: esrInput[0:9] = 10'b1100000000;
      // i-side bus error with msrME =0 and fpu exception status.
      14'b??_001_0_01_???_??_?: esrInput[0:9] = 10'b1000000100;
      // i-side bus error with msrME =0 and fpu unimplemented intrpt status.
      14'b??_001_0_1?_???_??_?: esrInput[0:9] = 10'b1000100100;
      // i-side bus error with msrME =0 and ISI ESR sets.
      14'b??_001_1_??_???_??_?: esrInput[0:9] = {6'b100000,isiZoneSet,3'b000};
      // i-side bus error with msrME =1.
      14'b??_011_?_??_???_??_?: esrInput[0:9] = 10'b1000000000;
      // esrExeTypeHold overrides the rest of the sets.
      14'b00_1??_?_??_???_??_?: esrInput[0:9] = esr[0:9];
      // DSI status.
      14'b?1_???_?_??_???_??_?: esrInput[0:9] = {esr[0],4'b0000,~PCL_wbLdNotSt,
                                                  MMU_dsStatus[0],2'b00,dsiU0Set};
      // D-Miss status.
      14'b1?_???_?_??_???_??_?: esrInput[0:9] = {esr[0],4'b0000,~PCL_wbLdNotSt,
                                                  4'b0000};
      // x catcher.
      default: esrInput[0:9] = 10'bx;
   endcase

assign VCT_sxrOR_L2 = sxrOR_L2;
assign VCT_msrWEL2 = msrWE;
assign VCT_msrPR = msrPR;
assign VCT_msrDE = msrDE;
assign VCT_msrIR = msrIR;
assign VCT_msrDR = msrDR;
assign VCT_msrDWE = msrDWE;
assign VCT_srr1DWE = srr1[9];
assign VCT_srr3DWE = srr3[9];

//************************************************************************
// Suppress Cntl Logic
//************************************************************************
// VCT_errorSprSuppress is a component of PCL_sprHold.
assign VCT_errorSprSuppress =  iSideMachChkSet | privViolSet | isiSet | iMissSet |
                               DBG_exeIacSuppress | DBG_wbDacSuppress | MMU_dsStatus[5] |
                               MMU_dsStatus[6] | MMU_dsStatus[7] |
                               PCL_algnErr;


// Wb suppress to DBG include all wb suppress type error.
assign VCT_wbErrSuppress = PCL_algnErr |
                           MMU_dsStatus[6] | MMU_dsStatus[5] | MMU_dsStatus[7];

// Only for Branches because trap can't get to exeC1 under this condition.
assign VCT_exeBrTrapErrSuppress =  isiSet | iMissSet | iSideMachChkSet;
assign VCT_exeSuppress =  DBG_exeSuppress | DBG_exeIacSuppress | trapSet |
                          privViolSet | apuExcSet | fpuExcSet | apuUnavailableSet |
                          fpuUnimplementedSet | apuUnimplementedSet | illegalOpSet |
                          isiSet | iMissSet | iSideMachChkSet | fpuUnavailableSet;
assign VCT_exeSuppForCr = DBG_exeIacSuppress | trapSet |
                          privViolSet | apuExcSet | fpuExcSet | apuUnavailableSet |
                          fpuUnimplementedSet | apuUnimplementedSet | illegalOpSet |
                          isiSet | iMissSet | iSideMachChkSet | fpuUnavailableSet;
assign VCT_exeSuppForExe2Clear =  DBG_exeIacSuppress | isiSet | iMissSet | iSideMachChkSet;
assign VCT_exeSuppForApu =  DBG_exeIacSuppress | privViolSet | apuUnavailableSet |
                            fpuUnimplementedSet | apuUnimplementedSet | illegalOpSet |
                            isiSet | iMissSet | iSideMachChkSet | fpuUnavailableSet;
assign VCT_mmuExeSuppress =  DBG_exeIacSuppress | privViolSet | apuExcSet | fpuExcSet |
                             apuUnavailableSet | fpuUnimplementedSet | isiSet |
                             iMissSet | iSideMachChkSet | fpuUnavailableSet;

// DAC, DSI(shadow) and Algn(shadow and cpu)
assign VCT_wbSuppress_i = ((DBG_wbDacSuppress | PCL_algnErr) & ~MMU_dsStateBorC & ~PCL_wbHoldNonErr) |
                        MMU_dsStatus[6] | MMU_dsStatus[5] | MMU_dsStatus[7];

assign VCT_wbSuppress = VCT_wbSuppress_i;  //output port assignment;

// Used in ltchDA equation to prevent ltchDA fron coming ON.
assign VCT_wbLoadSuppress = DBG_wbDacSuppress | PCL_algnErr;

assign VCT_wbFlush_i = 
    (sxr[0] | sxr[1] | sxr[8] | dbgIntrpQual | (wbFlushAsyncForWbFlush & PCL_wbStorageOp)) &
    (IFB_runStL2 | (IFB_stepStL2 & ~PCL_blkFlush[2] & (DBG_stopReq | JTG_stopReq))
    | IFB_swapStL2) | PCL_dIcmpForWbFlushQDlydL2 | resetL2;
assign VCT_wbFlush = VCT_wbFlush_i;  //output port assignment
assign VCT_apuWbFlush = VCT_wbFlush_i | VCT_wbSuppress_i;
assign VCT_swapQ23 = IFB_swapEnable & VCT_swap23_i;
assign VCT_swapQ01 = IFB_swapEnable & VCT_swap01_i;
assign VCT_anySwap = sxrOR_L2 | machCheckDsideQual | dbgIntrpQual | watchDogIntrpQual |
                     critIntrpQual  | extIntrpQual | fitIntrpQual | pitIntrpQual;

//************************************************************************
// ABORT Cntl Logic (Aborting the last data side (incl I$ and D$ ops) command)
//************************************************************************
assign VCT_dcuWbAbort_i =  
     ((DBG_wbDacSuppress | PCL_algnErr) & ~MMU_dsStateBorC) | wbFlushAsync |
     ((dbgIntrpQual | sxrOR_L2) & ~IFB_stuffStL2) | PCL_dIcmpForWbFlushQDlydL2;
assign VCT_dcuWbAbort =  VCT_dcuWbAbort_i;  //output port assignment
assign VCT_icuWbAbort =  VCT_dcuWbAbort_i;
assign VCT_mmuWbAbort =  
     ((dbgIntrpQual | sxrOR_L2) & ~IFB_stuffStL2) | wbFlushAsync | PCL_dIcmpForWbFlushQDlydL2;

//************************************************************************
// Timer Interrupt
//************************************************************************
// This signal is intended to be used by CPM to wake up the CORE if timers
// are running and the reset of the CORE is not.
assign VCT_timerIntrp = (TIM_fitIntrp & msrEE) | (TIM_pitIntrp & msrEE) |
                        (TIM_watchDogIntrp & msrCE);

//************************************************************************
// DEAR Cntl Logic
//************************************************************************
assign VCT_dearE2 = (dsiSet | algnSet | dMissSet) & ~VCT_wbFlush_i;

// Clear MSR IR and DR bits if MMU is not enabled.
assign sprMsrr[12:13] = EXE_sprDataBus[26:27] & {2{PGM_mmuEn}};
assign sprMsrr[0:11] = {EXE_sprDataBus[6],EXE_sprDataBus[12:14],EXE_sprDataBus[16:23]};

// IFB_exeFlush is active when:
// 1) going to stop state due to stop req.
// 2) going to swap state.
// 3) going to stop state due to wait.
// 4) isync in wb.
// Exclusivity rules:
// 1) going to stop due to stop req IFB_swapEnable will be off even if a swap req is on.
// 2) going to stop due to wait means there is no swap req since swap overrides wait.
// 3) if IFB_exeFlush is on due to isync, only IFB_swapEnable is not blocked.

// msr,srr1,srr3 are separate physical register.
// The E1 is allowed to load with reset, mtspr to any of the 3 architected regs, or any time
//   a vector is being taken.
// The E2 blocks (by withholding swapEnable, except 4.) when:
// 1. tracePipeHold
// 2. going to stop state - if due to stopReq IFB_swapEnable =0.
//                          this blocks mtspr and swapReq.
// 3. going to stop state - due to wait by definition swapReq is zero since swap overrides wait.
//                          this would block a mtspr.
// Note: isync in WB is mutually exclusive with mtspr (to msr) in EXE.

assign msrDcd = EXE_vctSprDcds[0];
assign srr1Dcd = EXE_vctSprDcds[1];
assign srr3Dcd = EXE_vctSprDcds[2];
assign esrDcd = EXE_vctSprDcds[3];
assign pvrDcd = EXE_vctSprDcds[4];

wire mcsrDcd; // mcsrsDcd;

assign mcsrDcd  = EXE_vctSprDcds[5];
assign msrrSprWr = PCL_mtSPR & (msrDcd | srr1Dcd | srr3Dcd);
assign msrrE2 = (IFB_swapEnable | ((msrrSprWr | PCL_exeWrExtEn) & ~PCL_sprHold))
                 | resetL2;

// msr mux controls.
// 00 - select fb path, this path has updates for enable bits due to
//      intrp swap, the wrtEE(i) bitinstr, and feedback.
// 01 - spr data bus path.
// 10 - srr1 for wbRfi instr.
// 11 - srr3 for wbRfci instr.
assign msrMuxSel[0] = IFB_swapEnable & (VCT_wbRfi_i | VCT_wbRfci_i) & ~resetL2;
assign msrMuxSel[1] = ((PCL_mtSPR & msrDcd & ~IFB_swapEnable) | (IFB_swapEnable & VCT_wbRfci_i))
                   & ~resetL2;

// srr1 mux controls.
// 00 - select fb path.
// x1 - interrupt that uses srr0,1.
// 10 - spr path.
// Note: The ~IFB_swapEnable prevents a mtsrr1 from occurring during a critical class irpt.
// Note: resetL2 term insures the spr path is selected during reset so bits are cleared.
assign srr1MuxSel[0] = (PCL_mtSPR & srr1Dcd & ~IFB_swapEnable) | resetL2;
assign srr1MuxSel[1] = IFB_swapEnable & VCT_swap01_i;

// srr3 mux controls.
// 00 - select fb path.
// x1 - interrupt that uses srr2,3.
// 10 - spr path.
// Note: The ~IFB_swapEnable prevents a mtsrr3 from occurring during a critical class irpt.
// Note: resetL2 term insures the spr path is selected during reset so bits are cleared.
assign srr3MuxSel[0] = (PCL_mtSPR & srr3Dcd & ~IFB_swapEnable) | resetL2;
assign srr3MuxSel[1] = IFB_swapEnable & VCT_swap23_i;

assign srr13MsrForLSSD[0:13] = 
     ({msrVEC,msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,msrME,msrFE0,msrDWE,
     msrDE,msrFE1,msrIR,msrDR}) ^ ({14{LSSD_coreTestEn}});

//************************************************************************
// MCSR Control Logic
//************************************************************************
// MCSR Summary
// MCSR[0]   -- MCS Summary - A machine check exception was detected
// MCSR[1]   -- IPBLE - Instruction Processor Local Bus Error
// MCSR[2]   -- DPBLE - Data Processor Local Bus Error
// MCSR[3]   -- Reserved/No function
// MCSR[4]   -- TLBE  - Translation Lookaside Buffer Parity Error
// MCSR[5]   -- ICPE  - Instruction Cache Parity Error
// MCSR[6]   -- DCLPE - Data Cache Load Parity Error
// MCSR[7]   -- DCFPE - Data Cache Flush Parity Error
// MCSR[8]   -- IMCE  - Imprecise Machine Check Exception 
//                      (Imprecise Data Cache Parity Error)
// MCSR[9:10]-- TLBS  - Translation Lookaside Buffer Parity Source
//                00  - Instruction Fetch Parity Error
//                01  - Data Fetch Parity Error
//                10  - TLBSX resulted in a parity error
//                11  - TLBRE resulted in a parity error
//

wire mcsrResetAccess, hwSetIBusErr, hwSetDBusErr, hwSetMmuIfetchParErr;
wire hwSetMmuDfetchParErr, hwSettlbsxParErr, hwSettlbreParErr, hwSetIcacheParErr;
wire hwSetDcacheParErr, hwSetDcacheFlushParErr;

 wire [0:9] nxtMcsr;
 wire [0:9] swResetMcsr;
 wire [0:9] hwSetMcsr; 
 reg [0:9] mcsrLtch;
 reg [0:9] mcsrLtch_DataIn;
 reg [0:31] oldVCT_sprDataBus; 
 reg [0:13] msr_Reg;
 reg [0:13] msr_Reg_DataIn;
 wire [0:31] dp_Mux_D0;
 wire [0:31] dp_Mux_D1;
 wire [0:31] dp_Mux_D2;
 wire [0:31] dp_Mux_D3;
 wire [0:1]  dp_Mux_SD;

assign
    
    mcsrResetAccess        = PCL_mtSPR & mcsrDcd & ~PCL_sprHold,
    swResetMcsr[0:9]       = {{EXE_sprDataBus[0:2]  & {3{mcsrResetAccess}}},
                             {EXE_sprDataBus[4:10] & {7{mcsrResetAccess}}}},
    hwSetIBusErr           = IFB_exeIfetchErr[0] & ~esrExeTypeHold,
    hwSetDBusErr           = PLB_dcuErr  & DCU_SCL2,
    hwSetMmuIfetchParErr   = IFB_exeIfetchErr[3] & ICU_CCR0TPE & ~esrExeTypeHold,
    hwSetMmuDfetchParErr   = MMU_dsParityErr & ICU_CCR0TPE,
    hwSettlbsxParErr       = MMU_tlbSXParityErr & ICU_CCR0TPE,
    hwSettlbreParErr       = MMU_tlbREParityErr & ICU_CCR0TPE,
    hwSetIcacheParErr      = IFB_exeIfetchErr[4] & ICU_CCR0IPE & ~esrExeTypeHold,
    hwSetDcacheParErr      = lwbFullL2 & PCL_lwbCacheableL2 & EXE_dofDregParityErrL2 &
                             PCL_dofDregFull & ICU_CCR0DPE,
    hwSetDcacheFlushParErr = DCU_FlushParityError & ICU_CCR0DPE,
    
    hwSetMcsr[0]         = (hwSetIBusErr        | hwSetDBusErr      | hwSetMmuIfetchParErr |
                            hwSetMmuDfetchParErr| hwSettlbsxParErr  | hwSettlbreParErr     |
                            hwSetIcacheParErr   | hwSetDcacheParErr | hwSetDcacheFlushParErr ),
                            
    hwSetMcsr[1]         = hwSetIBusErr,
    hwSetMcsr[2]         = hwSetDBusErr,
    hwSetMcsr[3]         = hwSetMmuIfetchParErr | hwSetMmuDfetchParErr | 
                           hwSettlbsxParErr     | hwSettlbreParErr,
    
    hwSetMcsr[4]         = hwSetIcacheParErr,                  
    hwSetMcsr[5]         = hwSetDcacheParErr & ICU_CCR0DPP,
    hwSetMcsr[6]         = hwSetDcacheFlushParErr,
    hwSetMcsr[7]         = hwSetDcacheParErr & ~ICU_CCR0DPP,
    hwSetMcsr[8:9]       = {hwSettlbsxParErr     | hwSettlbreParErr,
                            hwSetMmuDfetchParErr | hwSettlbreParErr},
    nxtMcsr[0:9]       = (mcsrLtch[0:9] & ~swResetMcsr[0:9]) | hwSetMcsr[0:9];
                           
    
//************************************************************************
// SPR Old Data vs New MCSR Data Mux
//************************************************************************
//Removed the module 'dp_muxVCT_sprMcsr' 
assign VCT_sprDataBus[0:31] = 
   (oldVCT_sprDataBus[0:31] & {(32){~(mcsrDcd)}} ) | 
   ({mcsrLtch[0:2], 1'b0, mcsrLtch[3:9], 21'h000} & {(32){mcsrDcd}} );

//************************************************************************
// Clk Buffer
//************************************************************************
//Removed the module 'vctClkBuf' 
//Removed the module 'dp_logVCT_clkInv'
//Removed the module 'dp_logVCT_clkBuf'

//************************************************************************
// MSR Register
//************************************************************************
//Removed the module 'dp_regVCT_msr'
// 4-1 Mux input to register
always @(msrFb or sprMsrr or srr1 or srr3 or msrMuxSel)
  casez(msrMuxSel)
    2'b00: msr_Reg_DataIn = msrFb[0:13];
    2'b01: msr_Reg_DataIn = sprMsrr[0:13];
    2'b10: msr_Reg_DataIn = srr1[0:13];
    2'b11: msr_Reg_DataIn = srr3[0:13];
    default: msr_Reg_DataIn = 14'bx;
  endcase

// posedge FF
always @(posedge CB)
  casez(msrrE2)
    1'b0: msr_Reg <= msr_Reg;
    1'b1: msr_Reg <= msr_Reg_DataIn;
    default: msr_Reg <= 14'bx;
  endcase

assign {msrVEC,msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,msrME,
                 msrFE0,msrDWE,msrDE,msrFE1,msrIR,msrDR} = msr_Reg;

//************************************************************************
// SRR1 Register
//************************************************************************
//Removed the module 'dp_regVCT_srr1'

assign srr1_MuxD1 = {msrVEC,msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,
                          msrME,msrFE0,msrDWE,msrDE,msrFE1,msrIR,msrDR};

// 4-1 Mux input to register
always @(srr1 or srr1_MuxD1 or sprMsrr or srr13MsrForLSSD or srr1MuxSel)
  casez(srr1MuxSel)
    2'b00: srr1_Reg_DataIn = srr1;
    2'b01: srr1_Reg_DataIn = srr1_MuxD1;
    2'b10: srr1_Reg_DataIn = sprMsrr;
    2'b11: srr1_Reg_DataIn = srr13MsrForLSSD;
    default: srr1_Reg_DataIn = 14'bx;
  endcase

// posedge FF
always @(posedge CB)
  casez(msrrE2)
    1'b0: srr1 <= srr1;
    1'b1: srr1 <= srr1_Reg_DataIn;
    default: srr1 <= 14'bx;
  endcase


//************************************************************************
// SRR3 Register
//************************************************************************
//Removed the module 'dp_regVCT_srr3'

assign srr3_MuxD1 = {msrVEC,msrAPE,msrWE,msrCE,msrEE,msrPR,msrFPA,
                       msrME,msrFE0,msrDWE,msrDE,msrFE1,msrIR,msrDR};

// 4-1 Mux input to register
always @(srr3 or srr3_MuxD1 or sprMsrr or srr13MsrForLSSD or srr3MuxSel)
  casez(srr3MuxSel)
    2'b00: srr3_Reg_DataIn = srr3;
    2'b01: srr3_Reg_DataIn = srr3_MuxD1;
    2'b10: srr3_Reg_DataIn = sprMsrr;
    2'b11: srr3_Reg_DataIn = srr13MsrForLSSD;
    default: srr3_Reg_DataIn = 14'bx;
  endcase

// L2 Output modeled as posedge FF
always @(posedge CB)
  casez(msrrE2)
    1'b0: srr3 <= srr3;
    1'b1: srr3 <= srr3_Reg_DataIn;
    default: srr3 <= 14'bx;
  endcase


//************************************************************************
// ESR Register
//************************************************************************
//Removed the module 'dp_regVCT_esr' 

// 2-1 Mux input to register
always @(esrInput or resetL2)
  casez(resetL2)
    1'b0: esr_Reg_DataIn = esrInput;
    1'b1: esr_Reg_DataIn = 10'b0;
    default: esr_Reg_DataIn = 10'bx;
  endcase

// posedge FF
always @(posedge CB)
   esr <= esr_Reg_DataIn;


//************************************************************************
// SXR Register
//************************************************************************
//Removed the module 'dp_regVCT_sxr'
 
assign sxr_MuxD0 = {nxtParityErr, sxrInput[0:11], EIC_critIntrp, 
                    EIC_extIntrp, nxtDcuErr, (|sxrInput[0:11]), nxtStuffStepSup};

// 2-1 Mux input to register
always @(sxr_MuxD0 or resetL2)
  casez(resetL2)
    1'b0: sxr_Reg_DataIn = sxr_MuxD0;
    1'b1: sxr_Reg_DataIn = 18'b0;
    default: sxr_Reg_DataIn = 18'bx;
  endcase

// posedge FF
always @(posedge CB)
  sxr_Reg <= sxr_Reg_DataIn;

assign {parityErrLtch, sxr[0:11], critIntrpL2, extIntrpL2, 
             dcuErrLtch, sxrOR_L2, VCT_stuffStepSupL2_i} = sxr_Reg;
assign VCT_stuffStepSupL2 = VCT_stuffStepSupL2_i; //output port assignment
                         
//************************************************************************
// Free running Reset Latch
//************************************************************************
//Removed the module 'dp_regVCT_reset'
// posedge FF
always @(posedge CB)
  resetL2 <= coreReset;

                             
//************************************************************************
//Parity Error Latch
//************************************************************************
// Dont need this...see defect 1971 note 9...JBB

//************************************************************************
// MCSR Register
//************************************************************************
//Removed the module 'dp_regVCT_mcsr'
// 2-1 Mux input to register
always @(nxtMcsr or resetL2)
  casez(resetL2)
    1'b0: mcsrLtch_DataIn = nxtMcsr;
    1'b1: mcsrLtch_DataIn = 10'b0;
    default: mcsrLtch_DataIn = 10'bx;
  endcase

// posedge FF
always @(posedge CB)
  mcsrLtch <= mcsrLtch_DataIn;

                           
//************************************************************************
// SPR SRR1,3 MUX OUT
//************************************************************************
//Removed the module 'dp_muxVCT_sprSrr13'
assign srr13 = (srr1 & {(14){~(srr3Dcd)}} ) | (srr3 & {(14){srr3Dcd}} );

//************************************************************************
// SPR BUS MUX OUT
//************************************************************************
//Removed the module 'dp_muxVCT_sprOut'

assign dp_Mux_SD = {(pvrDcd | esrDcd | LSSD_coreTestEn), (pvrDcd | msrDcd | LSSD_coreTestEn)};
assign dp_Mux_D0 = {6'b0,srr13[0],5'b0,srr13[1:3],1'b0, srr13[4:11],2'b0,srr13[12:13],4'b0};
assign dp_Mux_D1 = {6'b0,msrVEC,5'b0,msrAPE,msrWE,msrCE,1'b0, msrEE,msrPR,msrFPA,msrME,msrFE0,msrDWE,
                           msrDE,msrFE1,2'b00,msrIR,msrDR,4'b0000};
assign dp_Mux_D2 = {esr[0],3'b0,esr[1:6],2'b00,esr[7:8], 2'b00,esr[9],15'b0};
assign dp_Mux_D3 = PGM_pvrBus[0:31];
always @(dp_Mux_SD or dp_Mux_D0 or dp_Mux_D1 or dp_Mux_D2 or dp_Mux_D3)
begin
  case(dp_Mux_SD)
    2'b00: oldVCT_sprDataBus = dp_Mux_D0;
    2'b01: oldVCT_sprDataBus = dp_Mux_D1;
    2'b10: oldVCT_sprDataBus = dp_Mux_D2;
    2'b11: oldVCT_sprDataBus = dp_Mux_D3;
    default: oldVCT_sprDataBus = 32'bx;
  endcase
end

                          
//************************************************************************
// VCT PO BUffer
//************************************************************************
//Removed the module 'dp_logVCT_vctPOBuf'
assign VCT_msrFE0 = msrFE0;
assign VCT_msrFE1 = msrFE1;
assign VCT_msrCE = msrCE;
assign VCT_msrEE = msrEE;
assign VCT_errorOut = esr[0];
assign VCT_msrWE = msrWE;

endmodule
