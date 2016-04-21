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
// Change Log
// 02/13/98 -- Start of verilog entry.
// 06/25/98 -- Added different aborts
// 06/26/98 -- Fixed PLB_orDcuBusy to include CAR_OF_fullL2 to fix sync.
// 06/26/98 -- Fixed reset of fillValidBits for sync to include time between when fill SM
//             moved from idle to pend.
// 07/01/98 -- Modified the PLBDR_FDR_muxSel to default to the PLBDR
// 07/01/98 -- Moved the rdWdAddr mux into the functional
// 07/06/98 -- Fixed flush mux select FDR_word134567_sel1 to have fill_read2_state and flushA_L2
// 07/07/98 -- Removed the KompressErr signal now in the MMU unit
// 07/08/98 -- Added the DCU_firstCycCarXltV for the CPU debug logic to know when Store data is valid
// 07/14/98 -- Added new E1 for dataflow
// 07/21/98 -- All dcbz/dcba commands are treated as line fills.
// 08/11/98 -- Multiple timing fixes / bug fixes over the past weeks.
// 08/11/98 -- Added hit and miss to inputs from dp_log functions
// 08/11/98 -- Modified the PLB_AR mux select to handle the case of stNC/ldNC from same addr.
// 08/12/98 -- Removed hit and miss
// 08/20/98 -- Updated the PLBAR mux select
// 08/27/98 -- Modified the load NC as line to include load misses that are non-alloc
// 09/03/98 -- Added the DCU_plbAbort logic with sample cycle and qualified by DCU_request
// 09/15/98 -- Added buf of hit_a and hit_b
// 09/21/98 -- Added the U0Attr bits for flushes
// 09/24/98 -- Added the equation for WB_lineDirtyIn
// 09/29/98 -- Modified the PLBAR mux select, and carOF_OCM
// 10/07/98 -- Added the new data index mux and modified the mux selects
// 10/07/98 -- Added fill case of write2 -> read1
// 10/22/98 -- Changes from design review to DCU_CA/DCU_DA
// 10/27/98 -- Made SDQ_OF -> SDP latch
// 11/07/98 -- Timing fix to DCU_DA
// 12/02/98 -- Removed readWriteIndexComp.  Made writethru read for LRU done at latch input
// 12/03/98 -- Changes dirtyLRU_readIndex_E1 to dirtyLRU_readIndex_E2 and added a new E1
// 12/07/98 -- Fixes to OCM and bug fix to store hit pendings.
// 12/09/98 -- Added writeBufLoTag_E2 and modifed the E1 to help timing.
// 12/10/98 -- Fix to flush bug Issue 319
// 12/16/98 -- Removed writeBufLo_E2 made latch an L1 output only
// 01/22/99 -- Issue  8: Store hit in FB writing to memory and FB.
//          -- Issue 10: Fixed cmdInProg_E2 for load word as line and ccr0 attr changes
// 01/26/99 -- Modified carAborted to allow a load to be aborted when twoLoadPending.
// 02/04/99 -- Made all store hits in fill buffer go to SDP before going to fill buffer to
//          -- remove carAborted from several equations.
// 02/12/99 -- Changed dataIndex reg from L2 to L1 output and fixed mux sel.
// 02/18/99 -- Made store hits in the FB for NC as line write to FB.
// 02/26/99 -- Moved the Nor for dataout Mux select to dataflow to help timing.
// 03/01/99 -- Added dup dValidCntDoneL2, CAR_OF_full2L2 and fillSM.
// 03/08/99 -- Added xltValidL2 to qualify the OCM complete and hold terms.
// 03/10/99 -- Added additional versions of reset for timing
// 03/11/99 -- Added dup version that is early for PCL_dcuOp<0:2> as PCL_dcuOp_early<0:2>
// 03/12/99 -- Added the non buffered version of CAR_cacheable to help timing in DCU_CA
// 03/15/99 -- Added a duplicate version of xltValidL2 to help timing.
// 03/15/99 -- Added a test Enable to writeBufMuxSelBit0
// 03/16/99 -- Modified the signal fillBufMuxSel1 to allow all possible mux selects for test
// 03/17/99 -- Modified the signal dirtyLRU_readIndexSel to allow all possible mux selects for test
// 03/19/99 -- Fixed the equation for reset_validReg to reset when load the is non-cacheable as line to guarded.
// 03/24/99 -- Duplicated storeHitPend to help timing.  Added storeHitPendDupL2.
// 03/29/99 -- Fixed issue 102 equation SDQ_SDP_muxSel.  Anded storeHitFillBufPendL2 with dValidCntDone.
// 03/29/99 -- Adjusted LSA_E1 to help timing.  Moved LSA_free to E2.
// 03/30/99 -- Added twoLoadPendingL2L2 to carAborted for aborted loads in writeBack. Issue 103
// 03/30/99 -- Modified twoLoadPending_In and caEarly_In to be mux reg with miss as mux select.
// 04/08/99 -- Removed hit_x_buf2 and replaced with hit_x_buf1
// 04/22/99 -- Modified setStoreWord and FDR_hiMuxSel to help timing from PR26IPO
// 04/23/99 -- Duplicated carFullL2 named carFull2L2
// 04/28/99 -- Improvements to DCU_CA to help timing
// 04/29/99 -- Added RAW wrDAck to help timing on PLBDR_E2
// 04/30/99 -- Duplicated the carLoad signal to help timing
// 05/04/99 -- Duplicated the carStore signal to help timing
// 05/07/99 -- Duplicated the PLB_dcuSsizeBuf to help timing and change AO to OAI.
// 05/10/99 -- Modified DCU_ocmAbortOp to just be wbAbort and MMU_abort. AbortReq only exeAbort.
// 05/11/99 -- Duplicated SAQvalidNeedingPLBL2 to help timing
// 05/17/99 -- Modifications for Test to remove redudnance.  Duplicated latch dVQ_fullL2 -> dVQ_fullL2<0:3>
// 05/19/99 -- Added fillSM3_pend to help loading/timing.
// 05/26/99 -- Modified FAR_E2 and FDR_hi_E2, removed valid/dirty/lru to help timing
// 03/15/00 -- Modified dirtyLRU_readIndex_E1 and dirtyLRU_readIndex_E2 equation, see issue 176 for more detail
// 03/16/00 -- Modified carRead_In equation, see issue 177 for more detail
// 03/21/00 -- Modified forceDataIndexZero_mmu equation, see issue 178 for more detail
// 03/21/00 -- Modified carRead_In equation, see issue 181 for more detail


//------------------------------------
// CONTENTS
// --------
// - Decode the EXE_cacheOpBus
// - DCU/CPU interface signals
// - CAR signals
// - Index signals
// - Read Array signals
// - Read State Machine
// - Write signals
// - RAM result signals
// - RAM input signals
// - RAM Write signals
// - Write State Machine
// - ByteWrite Logic
// - CAR OF State machine and signals
// - LSA State Machine and signals
// - SAQ Status
// - SDQ/SDP Controls
// - PLBDR Status and signals
// - PLB_AR Status/request
// - FDR and Hold signals
// - wrAck Queue signals
// - dValid Queue signals
// - Fill signals
// - Fill State Machine
// - Fill Buf G2
// - Fill Mux Selects
// - Valid bit equations
// - Flush Status and Flush signals
// - Flush State Machine
// - dValid Counter
// - wrAck Counter
// - Bypass and two load pending
// - OCM Signals
//------------------------------------

module p405s_DCU_logic (SDQ_E1,
                        SDQ_E2,
                        DCU_CA,
                        tagIndex_E1,
                        twoFP_In,
                        CAR_mmuAttr_E1,
                        CAR_mmuAttr_E2,
                        dataIndexMuxSel,
                        forceDataIndexZero_mmu,
                        dataIndexMuxSel2,
                        dataIndex_E2,
                        xltValidLth_E2,
                        LRU_sel0,
                        newValidIn,
                        FAR_E2,
                        newDirtyIn,
                        DCU_U0Attr_In,
                        tagIndexDup_E1,
                        tagIndexDup_E2,
                        writeTagA0,
                        dirtyLRU_readIndexSel,
                        writeDataA0,
                        writeDataA1,
                        writeDirtyA0,
                        writeDirtyB0,
                        dOutMuxSelBit1Byte0,
                        LRU_sel1,
                        dOutMuxSelBit1Byte1,
                        dOutMuxSelBit1Byte2,
                        dOutMuxSelBit1Byte3,
                        flush2ndRead_In,
                        FDR_lo_E2,
                        storeWord_In,
                        carFullIn,
                        storeWriting_In,
                        past1stCycXltValid_In,
                        writeBufMuxSelBit0,
                        WB_lineDirtyIn,
                        wrAckCnt_In0X,
                        writeBufHi_E2,
                        CAR_OF_E2,
                        writeDirtyB1,
                        CAR_OF_full_In0,
                        FDR_hi_E1,
                        FDR_hi_E2,
                        FDR_lo_E1,
                        cacheOpMuxSel,
                        resetIn,
                        FDR_hiMuxSel,
                        FDR_holdMuxSel,
                        flushHold_E2,
                        SDP_FDR_muxSel,
                        wrAckQ_full_Inx1,
                        PLBDR_hiMuxSel,
                        wrAckQ_full_In10,
                        wrAckQ_sizeTran_E1,
                        wrAckQ_full_In00,
                        bypassMuxSel,
                        fillBufMuxSel0,
                        sel_CAR_OF_full,
                        fillValid_In,
                        LSA_E2,
                        fillSM_In,
                        FAR_full_In,
                        FAR_loadPending_In,
                        dVQ_In11,
                        PLBAR_selSAQ,
                        PLBAR_E2,
                        writeDirtyA1,
                        oneFP_In,
                        fillBuf_E2,
                        LSA_SM_In,
                        CAR_OF_PLB_loaded_In,
                        DCU_request_In,
                        xltValidLth,
                        SAQvalidNeedingPLB0,
                        storeHitPend_In0,
                        SAQ_E2,
                        dirtyLRU_writeIndex_E1,
                        writeTagB0,
                        DCU_sleepReq,
                        byteWriteData,
                        dValidCnt1_In,
                        wrAckCnt1_In,
                        dValidCntDone_In,
                        wrAckCntDone_In,
                        fillFlushToDo_In,
                        twoLoadPending_0_In,
                        fillLineDirty_In,
                        tagIndexSel,
                        dcbzFillHit_In,
                        PLBAR_E1,
                        SDQ_SDP_mux,
                        LSA_load_In,
                        priority_In,
                        DCU_guarded_In,
                        DCU_RNW_In,
                        dcbzFillHitA_In,
                        writeBufLoTag_E1,
                        DCU_tranSize_In,
                        DCU_cacheable_In,
                        SAQ_E1,
                        DCU_plbAddrBus_In,
                        cacheOpByteEn_E2,
                        DCU_writeThru_In,
                        cmdInProg_E2,
                        dirtyLRU_readIndex_E1,
                        SAQvalidNeedingPLB1,
                        DCU_byteEn_In,
                        ocmAbort,
                        ocmLoadReq,
                        ocmStoreReq,
                        bypassFillSDP_sel,
                        dcu_DA_sel,
                        DCU_ocmWait_In0,
                        carSpecialOp_In,
                        writeBufHi_E1,
                        caEarly_0_In,
                        DCUbypassPending_In0,
                        cacheableSpecialOp,
                        DCU_someBusy_In,
                        fill_A_In,
                        carTwoFP_In,
                        LSA_bypassPending_In,
                        cacheOpByteEn_E1,
                        FDR_outMuxSel,
                        carRead_In,
                        fillUsingArray,
                        CAR_OF_E1,
                        fillBufMuxSel1,
                        PLBAR_selFAR,
                        writeBufMuxSelBit1,
                        tagOutMuxSelFAR,
                        specialOPDone_In,
                        fillBuf_E1,
                        specialCase_In,
                        tagReadWriteCycle_In,
                        writeLRU1,
                        tagReadNotWrite_In,
                        dataReadWriteCycle_In,
                        carDcbzCmd,
                        DCU_firstCycCarStXltV,
                        PLBDR_E2,
                        writeTagB1,
                        dVQ_In00,
                        dVQ_In01,
                        LSA_E1,
                        dVQ_In10,
                        FDR_loMuxSel,
                        LRU_out_NEG,
                        writeLRU0,
                        writeDataB0,
                        writeDataB1,
                        dataReadNotWrite_In,
                        writeTagA1,
                        DCU_ocmWait_In1,
                        dcu_DA_early_NEG,
                        readLRUDirty,
                        wrAckSelInc2_11,
                        setDValidCntIdle,
                        wrAckCnt2_In,
                        dValidCnt2_In,
                        dValidCntSel,
                        wrAckSelInc2_10,
                        DCUbypassPending_In1,
                        set_storeHitPend1,
                        byteWrite_E1,
                        dataIndex_E1,
                        dirtyLRU_readIndex_E2,
                        DCU_pclOcmLdPendNoWait,
                        SDQ_SDP_OCM_sel,
                        writeBufLo_E2,
                        storeHitFillBufPend_In,
                        dataIndexLSA_dupSel,
                        loadReadFBvalid,
                        bypassPendOrDcRead,
                        twoLoadPending_1_In,
                        caEarly_1_In,
                        fillFollowedByFill_In,
                        carDcRead,
                        flushIdle_state,
                        flushAlmostDone,
                        flushDone,
                        ocmCompleteXltVNoWaitNoHold,
                        CAR_OF_fullL2,
                        dcbzFillHitA_L2,
                        fillFlushToDoL2,
                        past1stCycXltValidL2,
                        carFullL2,
                        dVQ0_sizeL2,
                        fillSM,
                        storeWritingL2,
                        xltValidL2,
                        VCT_exeAbort,
                        VCT_wbAbort,
                        storeHitPendDupL2,
                        MMU_dcuShadowAbort,
                        CAR_cacheableBuf1,
                        fill_A_L2,
                        SAQ_byteEn,
                        storeHitPendL2,
                        carOF_U0AttrL2,
                        dcbzFillHitL2,
                        ICU_dcuCCR0_L2,
                        twoLoadPendingL2L2,
                        carOF_LSAcmp,
                        U0AttrFAR,
                        carOF_FARcmp,
                        PCL_dcuOp,
                        cacheOpBusL2,
                        carOF_loadL2,
                        carOF_storeL2,
                        carOF_dcbzCmdL2,
                        carOF_dcbtL2,
                        carOF_cacheableL2,
                        carOF_writeThruL2,
                        carOF_hitAL2,
                        carOF_hitBL2,
                        carOF_byteEn,
                        OCM_dsComplete,
                        resetL2,
                        validA,
                        validB,
                        LRU,
                        specialCaseL2,
                        dirtyA,
                        dirtyB,
                        hit_a,
                        hit_b,
                        WB_lineDirtyReadL2,
                        fillLineDirtyL2,
                        CAR_writethru,
                        SAQ_L2,
                        CAR_L2_buf1,
                        dValidCntDoneL2,
                        wrAckCntDoneL2,
                        wrAckCntL2,
                        carOF_dsHoldL2,
                        PLB_dcuSsizeBuf1,
                        PLB_dcuWrDAck,
                        LSA_cacheableL2,
                        DCU_tranSize,
                        storeWordL2,
                        resetSCL2,
                        DCU_plbRNW_dupL2,
                        LSA_L2,
                        dVQ1_fullL2,
                        CAR_OF_L2,
                        fillValidL2,
                        PLB_dcuRdDAck,
                        FAR_fullL2,
                        FAR_loadPendingL2,
                        PLB_dcuRdWdAddr,
                        oneFPL2,
                        LSA_SM,
                        CAR_OF_PLB_loadedL2,
                        DCU_requestDupL2,
                        SAQ_writeThruL2,
                        dVQ1_lineL2,
                        SAQvalidNeedingPLBL2,
                        dValidCntL2,
                        twoLoadPendingL2,
                        sampleCycleL2,
                        carByteEn,
                        twoFPL2,
                        LSA_loadL2,
                        CAR_LSAcmp,
                        dVQ1_sizeL2,
                        SAQ_cacheableL2,
                        ICU_syncAfterReset,
                        dVQ0_fullL2,
                        carOF_guardedL2,
                        SAQ_FARcmp,
                        wrAckQ_sizeL2,
                        SAQ_guardedL2,
                        SAQ_U0AttrL2,
                        DCU_someBusyL2,
                        OCM_dsHold,
                        MMU_wbHold,
                        CAR_SAQcmp,
                        carSpecialOpL2,
                        caEarlyL2,
                        DCUbypassPendingL2,
                        DCU_ocmWait,
                        dVQ0_lineL2,
                        busySCL2,
                        wrAckQ_fullL2,
                        wrAckQ_lineL2,
                        carTwoFPL2,
                        LSA_bypassPendingL2,
                        carReadL2,
                        resetCore,
                        specialOPDoneL2,
                        MMU_dcuUTLBAbortL2,
                        flush2ndReadL2,
                        storeHitFillBufPendL2,
                        PLB_dcuRdDAck2,
                        dValidCntDone2L2,
                        fillSM2,
                        CAR_OF_full2L2,
                        CAR_cacheableBuf2,
                        reset4L2,
                        PCL_dcuOp_early,
                        CAR_cacheableNoBuf,
                        xltValidDupL2,
                        testEn,
                        LSA_guardedL2,
                        carFull2L2,
                        fillFollowedByFillL2,
                        PLB_dcuWrDAckBuf,
                        PLB_dcuRdDAck3,
                        carLoadDup,
                        carStoreDup,
                        CAR_L2_buf2,
                        PLB_dcuSsizeBuf2,
                        SAQvalidNeedingPLB2L2,
                        fillSM3_pend,
                        dValidCntDone3L2
                      );
       

// OUTPUTS
output  DCU_CA;
output  newValidIn;
output  PLBAR_E1;
output  carRead_In;
output  writeDirtyB1;
output  writeBufHi_E1;
output  CAR_OF_E1;
output  SDQ_E2;
output  SDQ_E1;
output  tagIndexDup_E1;
output  tagIndexDup_E2;
output  newDirtyIn;
output  dirtyLRU_readIndex_E1;
output  CAR_mmuAttr_E1;
output  CAR_mmuAttr_E2;
output  DCU_RNW_In;
output  DCU_ocmWait_In0;
output  caEarly_0_In;
output  specialOPDone_In;
output  carFullIn;
output  past1stCycXltValid_In;
output  writeTagA1;
output  writeTagB1;
output  FDR_lo_E2;
output  oneFP_In;
output  twoFP_In;
output  xltValidLth_E2;
output  cacheableSpecialOp;
output  DCU_sleepReq;
output  writeDirtyA1;
output  fillFlushToDo_In;
output  wrAckSelInc2_11;
output  dataIndexMuxSel2;
output  dataIndex_E2;
output  writeTagA0;
output  FDR_hi_E1;
output  FDR_hi_E2;
output  fillBuf_E1;
output  writeBufLo_E2;
output  writeDataA0;
output  writeDataA1;
output  writeDataB0;
output  writeDataB1;
output  writeDirtyA0;
output  writeDirtyB0;
output  FDR_lo_E1;
output  CAR_OF_E2;
output  LSA_E2;
output  carSpecialOp_In;
output  wrAckQ_full_In00;
output  wrAckQ_full_Inx1;
output  tagIndex_E1;
output  LSA_E1;
output  SDP_FDR_muxSel;
output  FAR_full_In;
output  FAR_loadPending_In;
output  dataReadNotWrite_In;
output  sel_CAR_OF_full;
output  PLBAR_E2;
output  CAR_OF_PLB_loaded_In;
output  DCU_request_In;
output  FDR_holdMuxSel;
output  cacheOpMuxSel;
output  wrAckQ_full_In10;
output  writeBufLoTag_E1;
output  dcbzFillHitA_In;
output  dirtyLRU_readIndexSel;
output  fillUsingArray;
output  DCUbypassPending_In1;
output  SAQ_E2;
output  LSA_load_In;
output  resetIn;
output  LRU_out_NEG;
output  dcu_DA_sel;
output  tagOutMuxSelFAR;
output  wrAckSelInc2_10;
output  dirtyLRU_writeIndex_E1;
output  writeTagB0;
output  dValidCntDone_In;
output  wrAckCntDone_In;
output  FAR_E2;
output  SAQ_E1;
output  twoLoadPending_0_In;
output  fillLineDirty_In;
output  dcbzFillHit_In;
output  xltValidLth;
output  dcu_DA_early_NEG;
output  dataIndex_E1;
output  priority_In;
output  ocmAbort;
output  DCU_firstCycCarStXltV;
output  carDcbzCmd;
output  specialCase_In;
output  DCU_U0Attr_In;
output  DCU_tranSize_In;
output  DCU_cacheable_In;
output  cmdInProg_E2;
output  ocmLoadReq;
output  tagReadNotWrite_In;
output  byteWrite_E1;
output  DCU_guarded_In;
output  dataReadWriteCycle_In;
output  cacheOpByteEn_E2;
output  flushHold_E2;
output  FDR_loMuxSel;
output  ocmStoreReq;
output  tagReadWriteCycle_In;
output  FDR_hiMuxSel;
output  SAQvalidNeedingPLB1;
output  storeHitFillBufPend_In;
output  DCUbypassPending_In0;
output  DCU_someBusy_In;
output  fill_A_In;
output  DCU_writeThru_In;
output  writeBufMuxSelBit0;
output  LSA_bypassPending_In;
output  SAQvalidNeedingPLB0;
output  cacheOpByteEn_E1;
output  storeWord_In;
output  flush2ndRead_In;
output  forceDataIndexZero_mmu;
output  carTwoFP_In;
output  CAR_OF_full_In0;
output  storeWriting_In;
output  LSA_SM_In;
output  WB_lineDirtyIn;
output  PLBAR_selSAQ;
output  PLBAR_selFAR;
output  writeLRU0;
output  writeLRU1;
output  setDValidCntIdle;
output  SDQ_SDP_mux;
output  tagIndexSel;
output  wrAckQ_sizeTran_E1;
output  LRU_sel0;
output  LRU_sel1;
output  readLRUDirty;
output  fillFollowedByFill_In;
output  dirtyLRU_readIndex_E2;
output  DCU_pclOcmLdPendNoWait;
output  SDQ_SDP_OCM_sel;
output  DCU_ocmWait_In1;
output  dOutMuxSelBit1Byte0;
output  dOutMuxSelBit1Byte1;
output  dOutMuxSelBit1Byte2;
output  dOutMuxSelBit1Byte3;
output  dataIndexLSA_dupSel;
output  loadReadFBvalid;
output  bypassPendOrDcRead;
output  twoLoadPending_1_In;
output  caEarly_1_In;

output [0:1]    storeHitPend_In0;
output [0:1]    FDR_outMuxSel;
output [0:1]    dValidCntSel;
output [0:1]    set_storeHitPend1;
output [0:1]    dataIndexMuxSel;
output [0:2]    bypassMuxSel;
output [0:2]    dValidCnt1_In;
output [0:2]    dValidCnt2_In;
output [0:2]    wrAckCnt1_In;
output [0:2]    wrAckCnt2_In;
output [0:2]    wrAckCnt_In0X;
output [0:3]    writeBufHi_E2;
output [0:3]    PLBDR_E2;
output [0:3]    PLBDR_hiMuxSel;
output [0:3]    bypassFillSDP_sel;
output [0:5]    fillSM_In;
output [0:6]    dVQ_In00;
output [0:6]    dVQ_In01;
output [0:6]    dVQ_In10;
output [0:6]    dVQ_In11;
output [0:7]    fillBuf_E2;
output [0:7]    DCU_byteEn_In;
output [0:15]   byteWriteData;
output [0:31]   fillValid_In;
output [0:31]   fillBufMuxSel0;
output [0:31]   fillBufMuxSel1;
output [0:31]   writeBufMuxSelBit1;
output [30:31]  DCU_plbAddrBus_In;
output          ocmCompleteXltVNoWaitNoHold; // issue 206

//--------- start ---------------
// rgoldiez - bringing this signal (carDcRead) out and over to the dataFlow block for proper selection of the parity data
//              bits or the actual data from the array on a dcread
//            bringing flushIdle_state for signal errors on ~flushIdle_state from castouts/flushes
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
output          carDcRead;
output          flushIdle_state;
output          flushAlmostDone;
output          flushDone;
//--------- end ----------------


// INPUTS
input  xltValidL2;
input  carFullL2;
input  CAR_cacheableBuf1;
input  past1stCycXltValidL2;
input  carSpecialOpL2;
input  specialCaseL2;
input  carOF_LSAcmp;
input  carOF_FARcmp;
input  resetL2;
input  DCU_someBusyL2;
input  carReadL2;
input  SAQ_writeThruL2;
input  CAR_OF_full2L2;
input  hit_a;
input  hit_b;
input  PLB_dcuRdDAck;
input  CAR_LSAcmp;
input  MMU_dcuUTLBAbortL2;
input  LSA_loadL2;
input  LSA_cacheableL2;
input  VCT_wbAbort;
input  VCT_exeAbort;
input  MMU_dcuShadowAbort;
input  LRU;
input  validA;
input  DCU_ocmWait;
input  flush2ndReadL2;
input  SAQ_FARcmp;
input  validB;
input  dirtyA;
input  dirtyB;
input  busySCL2;
input  specialOPDoneL2;
input  dVQ1_sizeL2;
input  carOF_dsHoldL2;
input  dValidCntDone2L2;
input  fillLineDirtyL2;
input  carOF_cacheableL2;
input  carOF_writeThruL2;
input  carOF_hitAL2;
input  dcbzFillHitA_L2;
input  carTwoFPL2;
input  carOF_hitBL2;
input  dValidCntDoneL2;
input  wrAckCntDoneL2;
input  CAR_writethru;
input  resetCore;
input  carOF_storeL2;
input  caEarlyL2;
input  PLB_dcuSsizeBuf1;
input  PLB_dcuWrDAck;
input  DCU_tranSize;
input  sampleCycleL2;
input  dVQ1_lineL2;
input  dVQ1_fullL2;
input  reset4L2;
input  FAR_fullL2;
input  FAR_loadPendingL2;
input  CAR_OF_PLB_loadedL2;
input  DCU_requestDupL2;
input  resetSCL2;
input  dcbzFillHitL2;
input  SAQ_cacheableL2;
input  carOF_guardedL2;
input  carOF_U0AttrL2;
input  fillFlushToDoL2;
input  storeHitFillBufPendL2;
input  carFull2L2;
input  SAQ_guardedL2;
input  SAQ_U0AttrL2;
input  twoLoadPendingL2;
input  WB_lineDirtyReadL2;
input  carOF_loadL2;
input  PLB_dcuRdDAck2;
input  OCM_dsHold;
input  MMU_wbHold;
input  DCUbypassPendingL2;
input  storeWritingL2;
input  U0AttrFAR;
input  CAR_cacheableBuf2;
input  wrAckQ_fullL2;
input  wrAckQ_lineL2;
input  wrAckQ_sizeL2;
input  fill_A_L2;
input  storeWordL2;
input  carOF_dcbtL2;
input  carOF_dcbzCmdL2;
input  CAR_OF_fullL2;
input  LSA_bypassPendingL2;
input  CAR_SAQcmp;
input  LSA_SM;
input  ICU_syncAfterReset;
input  DCU_plbRNW_dupL2;
input  SAQvalidNeedingPLBL2;
input  dVQ0_sizeL2;
input  oneFPL2;
input  twoFPL2;
input  dVQ0_lineL2;
input  OCM_dsComplete;
input  fillSM3_pend;
input  CAR_cacheableNoBuf;
input  xltValidDupL2;
input  testEn;
input  LSA_guardedL2;
input  twoLoadPendingL2L2;
input  fillFollowedByFillL2;
input  PLB_dcuWrDAckBuf;
input  PLB_dcuRdDAck3;
input  carLoadDup;
input  carStoreDup;
input  PLB_dcuSsizeBuf2;
input  SAQvalidNeedingPLB2L2;
input  dValidCntDone3L2;

input  [0:1]    storeHitPendL2;
input  [0:1]    storeHitPendDupL2;
input  [0:1]    dVQ0_fullL2;
input  [0:2]    dValidCntL2;
input  [0:2]    wrAckCntL2;
input  [0:2]    PLB_dcuRdWdAddr;
input  [0:2]    PCL_dcuOp_early;
input  [0:3]    carOF_byteEn;
input  [0:3]    carByteEn;
input  [0:3]    SAQ_byteEn;
input  [0:5]    fillSM;
input  [0:5]    fillSM2;
input  [0:9]    cacheOpBusL2;
input  [0:10]   ICU_dcuCCR0_L2;
input  [0:11]   PCL_dcuOp;
input  [0:31]   fillValidL2;
input  [27:29]  LSA_L2;
input  [27:29]  CAR_L2_buf1;
input  [27:29]  CAR_L2_buf2;
input  [27:29]  CAR_OF_L2;
input  [27:29]  SAQ_L2;


wire new_acc_command, new_cmd_aborted, carDone, carReadValid, setStoreWord, carAborted, global_addr_PL_disable;
wire carLoad, carStore, carDcbz, carDcbt, carDcbst, carDcbi, fillWrite2_state, carDccci, fill2Write2, fill_a ;
wire carDcRead, carDcbf, carDcba, fillRead1_state, fillIdle_state, OCM_dsComplete_noWait, LSA_needed;
wire exeLoad, exeDcbf, exeDcbst, exeDcRead, exeStore, exeDcbi, LSA_free, xltValidLth, MMU_dcuAbort;
wire fillUsingArray, fillNeeded, exeSync, carOF_storeQual, carOF_loadQual, carOF_dcbtQual, flushIdle_state;
wire reset_CAR_OF_full, blockLSA, blockSAQ, blockFlush, loadWordAsLine, exeDcbt, set_specialCase;
wire dVQ0Full_In00, dVQ0Full_In01, dVQ0Full_In10, dVQ0Full_In11, carOF_miss, almostDone, bypassPendingData;
wire dVQ0Size_In01, dVQ0Size_In10, dVQ0Size_In11, dVQ1Size_In10, dVQ1Size_In11, flushAlmostDone;
wire dVQ0Tran_In01, dVQ0Tran_In10, dVQ0Tran_In11, dVQ1Tran_In10, dVQ1Tran_In11, storeHitPendAB, fillPend2Read1;
wire dVQ1Full_In00, dVQ1Full_In01, dVQ1Full_In10, dVQ1Full_In11, exeDcbz, reset_storeHitPend, exeDccci, PCL_dcuCmd;
wire reset_validReg, fill_b, oneFP2twoFP_dcbf, OCM_dsHold_noWait, fillOrDcbz, fillNearEnd, carOF_dsHoldQual;
wire LSA_loadingStore, dcu_CA_exeLdSt, exeSpecialOp, exeDcba, flushDone, set_flush_hitBLatched, blockCAROF;
wire fillRead2_state, reset_carSpecialOp, wrAckAlmostDone, set_flush_hitLatched, set_carSpecialOp;
wire fillWrite1_state, fillPend_state, storeNonAlloc, block_carOF, carOF_dcbzCmdQual, carOF_OP_qual, carOF_before_SAQ;
wire loadNonAlloc, blockCAR, dontPipeReq, dcReadTagData, dcReadBnotA, set_fillLineDirty, set_LSAbypassPending;
wire fillRead1_state2, fillIdle_state2, fillWrite1_state2, fillPend_state2, fillPend2Read1_2, loadPLBAR_early;
wire fillWrite2_state2, fillRead2_state2, reset_specialCase, OCM_dsComplete_noWaitXltV;
wire PCL_dcuCmd2, exeLoad2, exeStore2, storeHitPendABDup, dcu_CA_exeSpecialOp, set_flush_hitLatched_fast;
wire [0:2]      cmpAddr;
wire [0:3]      PLBDR_E2_nor;
wire [0:7]      loadPLBword;
wire [27:29]    carMux, CAR_buf;
wire [0:31]     fillBufSel0_pre;
wire reset_storeHitPend_ocm;
wire reset_storeHitPend_no_ocm;

reg LSA_targetValid, carMuxTargetValid, PLBAR_selOF, PLBAR_E2_pre;
wire PLBAR_selFAR;
reg PLBAR_selFAR_i;
wire PLBAR_selSAQ;
reg PLBAR_selSAQ_i;
reg [0:5]   fillSM_In;
reg [0:15]  byteWriteData;
reg [30:31] DCU_plbAddrBus_In;

wire LSA_E1_i;

assign LSA_E1 = LSA_E1_i;


//--------------------------------------------------------------------------------------------
//
// Decode the EXE_cacheOpBus and latched cacheOpBus
//
//--------------------------------------------------------------------------------------------
assign PCL_dcuCmd= PCL_dcuOp[0];
assign exeLoad   = PCL_dcuOp[1];
assign exeStore  = PCL_dcuOp[2];
assign exeDcbt   = PCL_dcuOp[3];
assign exeDcbz   = PCL_dcuOp[4];
assign exeDcba   = PCL_dcuOp[5];
assign exeDcbf   = PCL_dcuOp[6];
assign exeDcbst  = PCL_dcuOp[7];
assign exeDcbi   = PCL_dcuOp[8];
assign exeDccci  = PCL_dcuOp[9];
assign exeDcRead = PCL_dcuOp[10];
assign exeSync   = PCL_dcuOp[11];

assign PCL_dcuCmd2 = PCL_dcuOp_early[0];
assign exeLoad2    = PCL_dcuOp_early[1];
assign exeStore2   = PCL_dcuOp_early[2];

assign exeSpecialOp = PCL_dcuOp[0] & ~(PCL_dcuOp[1] | PCL_dcuOp[2] | PCL_dcuOp[11]);

assign carLoad    = cacheOpBusL2[0];
assign carStore   = cacheOpBusL2[1];
assign carDcbt    = cacheOpBusL2[2];
assign carDcbz    = cacheOpBusL2[3];
assign carDcba    = cacheOpBusL2[4];
assign carDcbf    = cacheOpBusL2[5];
assign carDcbst   = cacheOpBusL2[6];
assign carDcbi    = cacheOpBusL2[7];
assign carDccci   = cacheOpBusL2[8];
wire carDcRead_i;
assign carDcRead = carDcRead_i;
assign carDcRead_i  = cacheOpBusL2[9];
wire carDcbzCmd_i;
assign carDcbzCmd = carDcbzCmd_i;
assign carDcbzCmd_i = carDcbz | carDcba;



// Decode the ICU_dcuCCR0 bus
assign blockCAR          = ICU_dcuCCR0_L2[0];
assign blockLSA          = ICU_dcuCCR0_L2[1];
assign blockSAQ          = ICU_dcuCCR0_L2[2];
assign blockCAROF        = ICU_dcuCCR0_L2[3];
assign blockFlush        = ICU_dcuCCR0_L2[4];
assign dontPipeReq       = ICU_dcuCCR0_L2[5];
assign loadWordAsLine    = ICU_dcuCCR0_L2[6];
assign loadNonAlloc      = ICU_dcuCCR0_L2[7];
assign storeNonAlloc     = ICU_dcuCCR0_L2[8];
assign dcReadTagData     = ICU_dcuCCR0_L2[9];
assign dcReadBnotA       = ICU_dcuCCR0_L2[10];


assign MMU_dcuAbort = MMU_dcuUTLBAbortL2 | MMU_dcuShadowAbort;

// Removed the module 'dp_logDCU_carBuf2'
assign CAR_buf[27:29] = CAR_L2_buf2[27:29];

// Fix for issue 206
// The fix for this issue is load the adjuct register when data is being returned for the first
// part of the unaligned store.
// 
// A new signal is created to indicate that the OCM is sending data for the first part of the store.
// 
// OCM_dsComplete_noWaitXltV means that: OCM complete, CPU not asking the OCM to wait, CPU provide translate valid.
// ~carOF_dsHoldL2 means that: The complete is not for separate OCM operation in the CAR_OF.
assign ocmCompleteXltVNoWaitNoHold = OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual; //issue 206


//--------------------------------------------------------------------------------------------
//
// DCU/CPU interface signals
//
//--------------------------------------------------------------------------------------------
// When to TURNOFF CA the next cycle
// (1) - When setting twoLoadPending
// (2) - When twoLoadPending is currently set
// (3) - When setting twoFP due to a dcbf
// (4) - When a fill is accessing or will be accessing the arrays the next cycle
// (5) - When blocking the CAR or LSA and the will be full the next cycle
// (6) - When blocking the flushes and a flush is in progress
// (7) - When specialCase is set or setting
// (8) - When a special Op is in the CAR


//assign caEarly_In = twoLoadPending_In |                                      // two loads pending
//                    twoFPL2 | oneFP2twoFP_dcbf |                             // twoFP in both for timing
//                    fillRead1_state | fillPend2Read1 |                       // Fill in progress
//                    (fillWrite1_state & fillFlushToDoL2) |
//                    (fillWrite2_state & dValidCntDoneL2 & LSA_cacheableL2 &  // fillWrite2 -> fillRead1
//                       ~(LSA_loadL2 & loadNonAlloc)) |
//                    (blockCAR & carFullIn) |                                 // Block if CAR if full
//                    (blockLSA & LSA_SM_In) |                                 // Block if LSA is not idle
//                    (blockFlush & (carDcbf | carDcbst | ~flushIdle_state)) | // Block if Flush is not idle
//                    set_specialCase | specialCaseL2;                         // special case conditions

// Input to 2:1 muxReg with mux select miss and inputs:
// 0 = caEarly_0_In
// 1 = caEarly_1_In
wire carFullIn_i;
assign carFullIn = carFullIn_i;
wire carSpecialOp_In, carSpecialOp_In_i;
assign carSpecialOp_In = carSpecialOp_In_i;
wire twoLoadPending_0_In_i;
assign twoLoadPending_0_In = twoLoadPending_0_In_i;
wire LSA_SM_In_i;
assign LSA_SM_In = LSA_SM_In_i;
wire flushIdle_state_i;
assign flushIdle_state = flushIdle_state_i;
assign caEarly_0_In = twoLoadPending_0_In_i |
                      twoFPL2 | oneFP2twoFP_dcbf |                             // twoFP in both for timing
                      fillRead1_state | fillPend2Read1 |                       // Fill in progress
                      (fillWrite1_state & fillFlushToDoL2) |
                      (fillWrite2_state & dValidCntDoneL2 & LSA_cacheableL2 &  // fillWrite2 -> fillRead1
                         ~(LSA_loadL2 & loadNonAlloc)) |
                      (blockCAR & carFullIn_i) |                                 // Block if CAR if full
                      (blockLSA & LSA_SM_In_i) |                                 // Block if LSA is not idle
                      (blockFlush & (carDcbf | carDcbst | ~flushIdle_state_i)) | // Block if Flush is not idle
                      set_specialCase | specialCaseL2 |                        // special case conditions
                      carSpecialOp_In_i;                                         // specialOp in the CAR
wire twoLoadPending_1_In_i;
assign twoLoadPending_1_In = twoLoadPending_1_In_i;
assign caEarly_1_In = twoLoadPending_1_In_i |
                      twoFPL2 | oneFP2twoFP_dcbf |                             // twoFP in both for timing
                      fillRead1_state | fillPend2Read1 |                       // Fill in progress
                      (fillWrite1_state & fillFlushToDoL2) |
                      (fillWrite2_state & dValidCntDoneL2 & LSA_cacheableL2 &  // fillWrite2 -> fillRead1
                         ~(LSA_loadL2 & loadNonAlloc)) |
                      (blockCAR & carFullIn_i) |                                 // Block if CAR if full
                      (blockLSA & LSA_SM_In_i) |                                 // Block if LSA is not idle
                      (blockFlush & (carDcbf | carDcbst | ~flushIdle_state_i)) | // Block if Flush is not idle
                      set_specialCase | specialCaseL2 |                        // special case conditions
                      carSpecialOp_In_i;                                         // specialOp in the CAR



// When to accept new commands.  These terms were not early enough to be used in the caEarly_In equation.
// Turn off CA when a new command is being presented and ...
// (1)  - A special op is being presented and prior operation is in progress
// (2)  - A new load is being presented and a line fill is almost ready to access the array and
//        a store operation needs to write it's data before the fill is done to allow the data
//        to get to the RAM incase that line is replaced.
// (3)  - A sync and the DCU is doing anything.
// (4)  - The CAR and the CAR_OF are both full and there is no where to put a new operation.
//        Or block CAR_OF is set and the CAR_OF is full.
// (5)  - The CAR has a store and there is no where to put the store data so can accept new commands.
// (6)  - The CAR is full and not yet done.
//        Or  SAQ is set and the SAQ is full.
// (7)  - A line fill is reading the array the next cycle so done accept a new operation or
//        A line fill has completed using the array and another fill is ready to use the array.
// (8)  - The caEarlyL2 is currently set.
wire DCU_CA_i;
assign DCU_CA = DCU_CA_i;
assign DCU_CA_i = ~(PCL_dcuCmd &

                (((LSA_SM | carFull2L2 | CAR_OF_full2L2 | SAQvalidNeedingPLB2L2 |// Keeps all special
                   storeHitPendABDup | storeWritingL2) & ~exeLoad2 &            // ops from starting
                   ~exeStore2) |                                                // and sync

                (exeLoad2 & fillNearEnd &                                       // Dont CA load when store hit pend
                (storeHitPendABDup | (carStoreDup & CAR_cacheableNoBuf))) |     // and cnt 6 or 7. Allow store to
                                                                                // complete before a new load because
                                                                                // the fill may replace store hit line

                (exeSync & (busySCL2 | DCU_someBusyL2)) |                       // sync

                (CAR_OF_full2L2  & (carFull2L2 | blockCAROF)) |                 // CAR OF full and carFull or
                                                                                // Dont CA if OF full and blocking

                ((carStoreDup | blockSAQ) &                                     // When SDQ and SDP full or
                    (storeHitPendABDup | SAQvalidNeedingPLB2L2)) |              // Dont CA if SAQ full and blocking

                (carFull2L2 &                                                   // Dont CA if no xltValid
                ~(carReadL2 & xltValidL2 & ~fillWrite2_state2)) |
                                                                                // carFullL2 and not carReadValidForCA

                ((fillSM3_pend | fillFollowedByFillL2) & dValidCntDone3L2) |    // beginning of line fill.
                                                                                // pend->read1 or write2->read1

                caEarlyL2));                                                    // Latched terms



// This term is used to indicate when either a load or a store is being accepted.  Removes
// unneeded special op terms form the CA equation.
// Needed to have exeLoad in this to have it be on.  If not on then set_CAR_full will not come on.
assign dcu_CA_exeLdSt = ~((exeLoad & dValidCntL2[0] & dValidCntL2[1] & dVQ0_lineL2 &
                             (storeHitPendAB | (carStore & CAR_cacheableBuf2)) & (dVQ0_sizeL2 | dValidCntL2[2])) |
                          (CAR_OF_fullL2 & carFullL2) |
                          (carStore & (storeHitPendAB | SAQvalidNeedingPLBL2)) |
                          (carFullL2 & ~(carReadL2 & xltValidL2 & ~fillWrite2_state)) |
                          carSpecialOpL2 |
                          ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |
                          (blockCAROF & CAR_OF_fullL2) |
                          (blockSAQ & SAQvalidNeedingPLBL2) |
                          caEarlyL2);


assign dcu_CA_exeSpecialOp = ~(LSA_SM | (~fillIdle_state & ~fillWrite2_state) | carFullL2 | CAR_OF_fullL2 |
                               SAQvalidNeedingPLBL2 | storeHitPendAB | storeWritingL2 | caEarlyL2);


// When to turn on data available
// On bypass from SDQ must hit in cache therefore covered by hit
// Input to a 2:1 Inverting Mux with other input ~(hit_a | hit_b)
// Line 1 covers dcRead
// Line 2 covers bypasses from FB while in the CAR
// Line 3 covers bypasses from OF or LSA for PLB data, or from CAR or OF for OCM data
assign dcu_DA_early_NEG = ~((carDcRead_i & xltValidL2) |
                            (carLoad & carReadValid & carMuxTargetValid & CAR_LSAcmp) |
                             bypassPendingData);


// Select line for 2:1 Inverting Mux
// Leg 0 is dcu_DA_early_NEG
// Leg 1 is ~(hit_a | hit_b)
assign dcu_DA_sel = carLoad & carReadValid & CAR_cacheableBuf2 & ~(CAR_LSAcmp & (LSA_SM | dValidCntDoneL2));


assign cacheOpByteEn_E1 = PCL_dcuCmd2 | carFullL2 | reset4L2;
assign cacheOpByteEn_E2 = new_acc_command | carAborted | carDone |
                          (OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual) | resetL2;

// 0 = new_cmd    1 = gnd
assign cacheOpMuxSel    = ~(new_acc_command & ~new_cmd_aborted);


// Try an E1 later
assign cmdInProg_E2 = PCL_dcuCmd | carFullL2 | carReadL2 | storeWritingL2 | CAR_OF_fullL2 |
                      ~fillIdle_state | LSA_SM | SAQvalidNeedingPLBL2 | ~flushIdle_state_i | dValidCntDoneL2 |
                      wrAckQ_fullL2 | wrAckCntDoneL2 | storeHitPendAB | DCU_requestDupL2 | resetL2;



//
// carSpecialOpL2 Latch
//
// This latch is used to indicate when the CAR has a special op and this will keep
// additional commands from being accepted until this latch is reset.
assign set_carSpecialOp = dcu_CA_exeSpecialOp & ~MMU_wbHold & ~new_cmd_aborted & exeSpecialOp;

// Dont reset if car is done with a dcba or dcbz to allow dcbz/dcba to get into the OF and start the fill
// The carOF_dcbzCmdL2 does not need to be anded with CAR_OF_fullL2 because it is loaded with carReadValid
assign reset_carSpecialOp = (carDone & ~carDcbzCmd_i) | carAborted | carOF_dcbzCmdQual | resetL2;
assign carSpecialOp_In_i = (carSpecialOpL2 & ~reset_carSpecialOp) | set_carSpecialOp;




assign DCU_sleepReq = ~(carFullL2 | CAR_OF_fullL2 | LSA_SM | ~flushIdle_state_i | storeHitPendAB |
                        SAQvalidNeedingPLBL2 | DCU_requestDupL2 | storeWritingL2);



//--------------------------------------------------------------------------------------------
//
// CAR signals
// Car, cacheOpBits, storeData, mmuAttr.
//
//--------------------------------------------------------------------------------------------
// Dont want to have a sync appear as a new command and get loaded into the CAR
assign new_acc_command = PCL_dcuCmd & DCU_CA_i & ~MMU_wbHold & ~exeSync;

assign new_cmd_aborted = VCT_exeAbort | VCT_wbAbort | MMU_dcuAbort;

wire xltValidLth_i;
assign xltValidLth = xltValidLth_i;
assign xltValidLth_i = xltValidL2 & carFullL2;

// Don't load car if command aborted (Was loading X's)
assign CAR_mmuAttr_E1 = PCL_dcuCmd2 | carFullL2;
assign CAR_mmuAttr_E2 = new_acc_command | (carFullL2 & ~xltValidL2);


// On when a command in the CAR has read the cache
// 2nd line replaces SDQ_OF_FullL2 - can't read no place for store data to go
// 3rd fillUsing array that is not redundant
assign carReadValid = carReadL2 & carFullL2 & xltValidL2 & ~twoLoadPendingL2 & ~CAR_OF_fullL2 &
                      ~(carStore & (storeHitPendAB | SAQvalidNeedingPLBL2 | fillPend2Read1_2)) &
                      ~fillRead1_state2 & ~fillRead2_state2 & ~fillWrite1_state2 & ~fillWrite2_state;



// This signal indicates when the command is done in the CAR and is either complete or moving
// Removed the OCM_dsHold_noWait from carReadValid & (load | store) term because OCM loads or stores
// now moves to the carOF when it can.
assign carDone = (carReadValid & (carLoad | carStore | carDcbt | carDcbzCmd_i | carDcRead_i)) |
                 (specialOPDoneL2 & carFullL2);


// Some special OP's are done after the 2nd cycle.
// Does not include dcbz/dcba/dcbt because they are in the CAR for only one cycle when they
// have good translation.  This is used to pick up commands that are multi cycles in the CAR.
assign specialOPDone_In = carReadL2 & xltValidL2 & ~carAborted & (carDcbst | carDcbi | carDcbf | carDccci);


assign carFullIn_i = (carFullL2 & ~carDone & ~carAborted & ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual)) |
                   (new_acc_command & ~new_cmd_aborted);


// This latch is set when a command is no longer abortable
assign past1stCycXltValid_In = (xltValidLth_i & ~carDone & ~MMU_dcuAbort & ~VCT_wbAbort &
                                  ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual)) |
                               (past1stCycXltValidL2 & ~carDone & ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual));

// Goes to PCL and control mux sel on dofDReg for Data Value Compare
assign DCU_firstCycCarStXltV = xltValidL2 & ~past1stCycXltValidL2 & carStore;
assign xltValidLth_E2        = (~xltValidL2 & carFullL2) | new_acc_command;


// Aborts
assign carAborted = carFullL2 & (~past1stCycXltValidL2 | twoLoadPendingL2 | twoLoadPendingL2L2) &
                    (MMU_dcuAbort | VCT_wbAbort);


//--------------------------------------------------------------------------------------------
//
// Index signals
// Tag/Data/Dirty LRU
//
//--------------------------------------------------------------------------------------------

// TAG signals
// Tag index dup feeds:
// dataIndex for store hits and dcbf/dcbst
// tagIndex  for fill write 1. hot B-clk on the tag index does not allow us to remember the previous address.
// FAR       for flush index bits
// dirtyLRU Index for all write of these bits
assign tagIndexDup_E1 = dValidCntDoneL2 | PCL_dcuCmd2 | carFullL2;

assign tagIndexDup_E2 = ((fillSM3_pend | fillFollowedByFillL2) & dValidCntDone2L2) |
                        (new_acc_command) |
                        (carFullL2 & ~twoFPL2 & ~fillRead1_state);

// The tagIndex reg only feeds the tag array.
// Tag index is L1 output
// Was fillPend2Read1 | ... | (fillWrite2_state & dValidCntDoneL2 & LSA_cacheableL2 & ~(LSA_loadL2 & loadNonAlloc)) |
// changed to dValidCntDoneL2 to help timing
assign tagIndex_E1 = dValidCntDone2L2 | PCL_dcuCmd2 |
                     (fillWrite2_state & carFullL2) |
                     (carFullL2 & ~xltValidDupL2 & ~fillRead1_state2);



// DATA signals
// 00 - MMU (new_acc_command)
// 01 - SAQ (Store Hit Pend)
// 10 - CAR/Tag Dup +1 (store hits, reloads when fill completing, Fills 2nd half, Flush Special 2nd half)
// 11 - LSA (Fills 1st half)/ Data Dup

assign dataIndexMuxSel[0] = // CAR
                            (fillWrite2_state & carFullL2 & xltValidL2) |
                            (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt)) |
                            (carFullL2 & xltValidL2 & carLoad & ~carDone & ~fillPend2Read1 &
                               ~fillWrite1_state & ~fillWrite2_state & ~(fillNearEnd & storeHitPendAB)) |

                            // Tag Dup
                            fillWrite1_state |
                            (carReadL2 & xltValidL2 & (carDcbf | carDcbst)) |

                            // LSA
                            ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |

                            // Data Dup
                            fillRead1_state |
                            fillRead2_state;


//assign dataIndexMuxSel[1] = // SAQ
//                            (storeHitPendAB & fillNearEnd) |
//                            (storeHitPendAB & ~fillRead1_state & ~fillWrite1_state & ~fillRead2_state &
//                                 ~(exeLoad & dcu_CA_exeLdSt) & ~(carFullL2 & ~carDone &
//                                 ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual) & ~twoFPL2)) |
//
//                            // LSA
//                            ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |
//
//                            // Data Dup
//                            fillRead1_state |
//                            fillRead2_state ;
assign dataIndexMuxSel[1] = // SAQ
                            OCM_dsComplete ? ((storeHitPendAB & fillNearEnd) |
                            (storeHitPendAB & ~fillRead1_state & ~fillWrite1_state & ~fillRead2_state &
                                 ~(exeLoad & dcu_CA_exeLdSt) & ~(carFullL2 & ~carDone &
                                 ~(~DCU_ocmWait & xltValidL2 & ~carOF_dsHoldQual) & ~twoFPL2)) |

                            // LSA
                            ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |

                            // Data Dup
                            fillRead1_state |
                            fillRead2_state) : 
                              (((storeHitPendAB & fillNearEnd) |
                              (storeHitPendAB & ~fillRead1_state & ~fillWrite1_state & ~fillRead2_state &
                                   ~(exeLoad & dcu_CA_exeLdSt) & ~(carFullL2 & ~carDone &
                                    ~twoFPL2)) |
  
                              // LSA
                              ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |
  
                              // Data Dup
                              fillRead1_state |
                              fillRead2_state)) ;
//assign OCM_dsComplete_noWaitXltV = OCM_dsComplete & ~DCU_ocmWait & xltValidL2;
// 11/8/99 fix for load problem   (carFullL2 & xltValidL2 & carLoad & ~carDone & ~fillPend2Read1 &
//  meu                           ~fillWrite1_state & ~fillWrite2_state);


// Select for CAR or TAG Dup
// 0 - CAR
// 1 - Tag Dup + 1 (Used only when forcing to 2nd half)
assign dataIndexMuxSel2 = fillWrite1_state | (carReadL2 & xltValidL2 & (carDcbf | carDcbst));


// Select for LSA or Data Dup
// 0 - Data Index Dup
// 1 - LSA
assign dataIndexLSA_dupSel = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2);



assign dataIndex_E1 = carFullL2 | storeHitPendAB | PCL_dcuCmd2 | ~fillIdle_state2;


assign dataIndex_E2 = fillPend2Read1 | fillWrite1_state | new_acc_command |
                      (storeHitPendAB & ~fillRead1_state & ~fillRead2_state) |
                      (carReadValid & carStore & CAR_cacheableBuf1) |
                      (fillWrite2_state & (dValidCntDoneL2 | (carFullL2 & xltValidL2))) |
                      (carFullL2 & ~xltValidL2 & ~fillRead1_state & ~fillRead2_state) |
                      (carReadL2 & xltValidL2 & (carDcbf | carDcbst));


// Issue 176 fix.
// Dirty LRU Gating
//assign dirtyLRU_readIndex_E1 = ~fillIdle_state2 | exeDcbf | exeDcbst | exeDcRead;
//assign dirtyLRU_readIndex_E2 = ((fillSM3_pend | fillFollowedByFillL2) & dValidCntDone2L2) |
//                               (~fillUsingArray & (exeDcbf | exeDcbst | exeDcRead));

wire fillUsingArray_i;
assign fillUsingArray = fillUsingArray_i;
assign dirtyLRU_readIndex_E1 = ~fillIdle_state2 | exeDcbf | exeDcbst | exeDcRead | ~xltValidL2;
assign dirtyLRU_readIndex_E2 = ((fillSM3_pend | fillFollowedByFillL2) & dValidCntDone2L2) |
                               (~fillUsingArray_i & (exeDcbf | exeDcbst | exeDcRead | ~xltValidL2));

assign dirtyLRU_writeIndex_E1 = (carReadL2 & xltValidDupL2) | fillRead1_state2;


// When to latch the LRU *OR* dirty bits
assign readLRUDirty = ((carDcRead_i | carDcbf | carDcbst) & xltValidDupL2 & ~specialOPDoneL2) | fillRead1_state;


// Tag Index Mux sel
// Bit [0] is fillUsingArray
// Bit [1] of two bit field
// 00 - CAR
// 01 - MMU
// 10 - Tag Dup
// 11 - LSA
// We load tag from CAR if xltValid and no carReadValid.
// We load tag Dup used to reload the tagIndex to write the tag during write1 cycle for fills.
// We load from the MMU when new_acc_command or no xltValid when not filling the array
// We load from the LSA when going to the read1 state
assign tagIndexSel = new_acc_command | (~xltValidL2 & ~fillRead1_state) |
                     ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2);


// Dirty/LRU read Mux sel
// Bit [0] is fillUsingArray
// Bit [1] of two bit field
// 00 - CAR
// 01 - MMU
// 10 - GND
// 11 - LSA
// Added or of (fillUsingArray & ~testEn) to allow all possible decodes to allow better TSV
assign dirtyLRU_readIndexSel = exeDcbf | exeDcbst | exeDcRead | ~xltValidL2 | (fillUsingArray_i & ~testEn);




//--------------------------------------------------------------------------------------------
//
// Read Array signals
//
//--------------------------------------------------------------------------------------------
// The VCT_exeAbort is here just for power
// May write for special OP's that are aborted but no byte writes will be on.
assign tagReadWriteCycle_In = (DCU_CA_i & PCL_dcuCmd & ~VCT_exeAbort & ~exeSync) |
                              (carFullL2 & ~carDone & ~twoFPL2) |
                              ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |
                              (fillRead1_state);

// Will sometimes read for store misses or stores that hit in the Fill Buffer
// May write for stores that are aborted but no byte writes will be on.
// Removed the VCT_exeAbort from the first term to help timing.
assign dataReadWriteCycle_In = (DCU_CA_i & PCL_dcuCmd & ~exeStore & ~exeSync) |
                               (carFullL2 & ~carDone & ~twoFPL2 & ~carStore) |
                               (carStore & carDone & CAR_cacheableBuf1) |
                               ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) |
                               (fillRead1_state | fillWrite1_state | fillRead2_state) |
                               storeHitPendAB;


// Removed the hit_a | hit_b because the readNotWrite line does not need to depend
// on hit/miss because the RAM tagReadWriteCycle will only read or write at the correct time.
assign tagReadNotWrite_In  = ~(fillRead1_state |
                                 (xltValidL2 & ~specialOPDoneL2 & (carDcbf | carDcbi | carDccci))) | resetL2;

// Removed the hit_a | hit_b because the readNotWrite line does not need to depend
// on hit/miss because the RAM dataReadWriteCycle will only read or write at the correct time.
assign dataReadNotWrite_In = ~(fillRead1_state | fill2Write2 | (storeHitPendAB & reset_storeHitPend) |
                               (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i)) | resetL2;



// This signal is used in the comparator.  It allows hit to not come on for non-cacheables
// except for dcbf/dcbst/dcbi special ops and never for dcRead
assign cacheableSpecialOp = (CAR_cacheableBuf1 & (carLoad | carStore | carDcbt | carDcbzCmd_i)) |
                             carDcbf | carDcbst | carDcbi;


// D-Reg mux selects
// 01 = Bypass
// 10 = Data A side
// 00 = Data B side
// 11 = Tag Read
wire [0:3] bypassFillSDP_sel_i;
assign bypassFillSDP_sel[0:3] = bypassFillSDP_sel_i[0:3];
assign dOutMuxSelBit1Byte0 = (carDcRead_i & dcReadTagData) |
                             (DCUbypassPendingL2) |
                             (carLoad & carReadValid & (LSA_SM | dValidCntDoneL2) & CAR_LSAcmp) |
                             (bypassFillSDP_sel_i[0] & CAR_SAQcmp & SAQ_byteEn[0]);

assign dOutMuxSelBit1Byte1 = (carDcRead_i & dcReadTagData) |
                             (DCUbypassPendingL2) |
                             (carLoad & carReadValid & (LSA_SM | dValidCntDoneL2) & CAR_LSAcmp) |
                             (bypassFillSDP_sel_i[1] & CAR_SAQcmp & SAQ_byteEn[1]);


assign dOutMuxSelBit1Byte2 = (carDcRead_i & dcReadTagData) |
                             (DCUbypassPendingL2) |
                             (carLoad & carReadValid & (LSA_SM | dValidCntDoneL2) & CAR_LSAcmp) |
                             (bypassFillSDP_sel_i[2] & CAR_SAQcmp & SAQ_byteEn[2]);


assign dOutMuxSelBit1Byte3 = (carDcRead_i & dcReadTagData) |
                             (DCUbypassPendingL2) |
                             (carLoad & carReadValid & (LSA_SM | dValidCntDoneL2) & CAR_LSAcmp) |
                             (bypassFillSDP_sel_i[3] & CAR_SAQcmp & SAQ_byteEn[3]);


// Mux of fill Buffer data or SDP data
// Removed CAR_SAQcmp and anded with bypassFillSDP_sel in dataflow to help dOutMuxSelByteX
// 0 - fillBypass data
// 1 - Data from SDP to bypass
assign bypassFillSDP_sel_i[0] = ((storeHitPendAB | storeHitFillBufPendL2) & SAQ_byteEn[0]) &
                              carLoad & carReadValid & (CAR_buf[27:29] == SAQ_L2[27:29]);

assign bypassFillSDP_sel_i[1] = ((storeHitPendAB | storeHitFillBufPendL2) & SAQ_byteEn[1]) &
                              carLoad & carReadValid & (CAR_buf[27:29] == SAQ_L2[27:29]);

assign bypassFillSDP_sel_i[2] = ((storeHitPendAB | storeHitFillBufPendL2) & SAQ_byteEn[2]) &
                              carLoad & carReadValid & (CAR_buf[27:29] == SAQ_L2[27:29]);

assign bypassFillSDP_sel_i[3] = ((storeHitPendAB | storeHitFillBufPendL2) & SAQ_byteEn[3]) &
                              carLoad & carReadValid & (CAR_buf[27:29] == SAQ_L2[27:29]);


assign loadReadFBvalid = carLoadDup & carReadValid & (LSA_SM | dValidCntDoneL2);

assign bypassPendOrDcRead = DCUbypassPendingL2 |
                            (carDcRead_i & ~dcReadTagData & dcReadBnotA);



//--------------------------------------------------------------------------------------------
//
// Read State Machine
//
//--------------------------------------------------------------------------------------------
// Issue 177 Fix.
// Dont need fill near end here because read data is in the RAM output latches.
//assign carRead_In = (carReadL2 & ~(carDone | (OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual) | ~carFullL2 |
//                                     twoFPL2 | carAborted | resetL2)) |
assign carRead_In = (carReadL2 & ~(carDone | (OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual) | ~carFullL2 |
                                     twoFPL2 | carAborted | resetL2 | (storeHitPendAB & fillNearEnd))) |

                  // Second read for flush special instructions
                  ((carDcbf | carDcbst) & carReadL2 & xltValidL2 & ~flush2ndReadL2) |

                  // Re-read if not a valid read yet
                  (carFullL2 & ~carReadValid &
                     ~(fillUsingArray_i | (twoLoadPendingL2 & ~bypassPendingData & ~OCM_dsComplete_noWaitXltV) | //issue 205
                       (CAR_OF_fullL2 & ~reset_CAR_OF_full) | twoFPL2 | (storeHitPendAB & fillNearEnd) |
                       (carStore & (storeHitPendAB | SAQvalidNeedingPLBL2)) | specialCaseL2)) |

                  // Read for new special ops
                  (dcu_CA_exeSpecialOp & exeSpecialOp) |

                  // Read for load or store except for when: setting TLP, setting TLP, setting TLP OCM,
                  // special case seting
                  // Don't need fillNearEnd here because it is in DCU_CA_i
                  (dcu_CA_exeLdSt & (exeStore | exeLoad) &
                     ~((LSA_bypassPendingL2 & ~LSA_targetValid & exeLoad) |

                       (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) &
                            ~OCM_dsComplete_noWait & exeLoad) |

                       // OCM cases
                       (carReadValid & OCM_dsHold_noWait) |

                       // Set of special case
                       // Issue 181 fix
                       //(carStore & carReadL2 & xltValidL2 & LSA_cacheableL2 & CAR_LSAcmp &
                       (carStore & carReadL2 & xltValidL2 & CAR_LSAcmp &
                         ~dValidCntDoneL2 & (CAR_buf[27:29] == LSA_L2[27:29]) & LSA_bypassPendingL2)));


assign flush2ndRead_In = (carDcbf | carDcbst) & carReadL2 & xltValidL2 & ~carDone;


//--------------------------------------------------------------------------------------------
//
// Write signals
//
//--------------------------------------------------------------------------------------------
// Does not actually cause a write and does not need to control exactly
// Mux/Reg inputs for 2:1 mux where select is hit_a
// Used to write the data A and then anded with byte writes
// Aborted store may write the data array but these signals will not allow the bit writes to be on
// Dupilicated to help timing
// 0 - writeDataA0
// 1 - writeDataA1
assign writeDataA0 = OCM_dsComplete ? (fill_a | (fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[0] & reset_storeHitPend_ocm)) :
                     (fill_a | (fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[0] & reset_storeHitPend_no_ocm));

assign writeDataA1 = OCM_dsComplete ? ((fill_a | (fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[0] & reset_storeHitPend_ocm)) |
                     (carStore & carReadValid & ~(~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
                        ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i)) :
                       ((fill_a | (fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[0] & reset_storeHitPend_no_ocm)) |
                     (carStore & carReadValid & ~(~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
                        ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i)); 

// Does not actually cause a write and does not need to control exactly
// Mux/Reg inputs for 2:1 mux where select is hit_b
// Used to write the data B and then anded with byte writes
// Aborted store may write the data array but these signals will not allow the bit writes to be on
// Dupilicated to help timing
// 0 - writeDataB0
// 1 - writeDataB1
assign writeDataB0 = OCM_dsComplete ? (fill_b | (~fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[1] & reset_storeHitPend_ocm)) :
                     (fill_b | (~fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[1] & reset_storeHitPend_no_ocm));

// Was using writeDataB0 but instead have subsituted it's equation here to help timing from LRU.
//assign writeDataB1 = (fill_b | (~fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
//                     (storeHitPendL2[1] & reset_storeHitPend)) |
//                     (carStore & carReadValid & ~(~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
//                        ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i);
assign writeDataB1 = OCM_dsComplete ? ((fill_b | (~fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[1] & reset_storeHitPend_ocm)) |
                     (carStore & carReadValid & ~(~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
                        ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i)) :
                        ((fill_b | (~fill_A_L2 & (fillWrite1_state | fillRead2_state)) |
                     (storeHitPendL2[1] & reset_storeHitPend_no_ocm)) |
                     (carStore & carReadValid & ~(~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
                        ~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i));
assign reset_storeHitPend_ocm = (~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i &
                             ~(carFullL2 & ~carDone & ~(~DCU_ocmWait & xltValidL2 & ~carOF_dsHoldQual)  & ~twoFPL2)) |
                                fillNearEnd | resetL2;
assign reset_storeHitPend_no_ocm = (~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i &
                             ~(carFullL2 & ~carDone &  ~twoFPL2)) |
                                fillNearEnd | resetL2;
//assign reset_storeHitPend = (~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i &
//                             ~(carFullL2 & ~carDone & ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual)  & ~twoFPL2)) |
//                                fillNearEnd | resetL2;


// Does not actually cause a write and does not need to control exactly
// 2:1 Mux/Reg Inputs (Select = hit_a | hit_b)
// writeLRU0 = 0 input
// writeLRU1 = 1 input
// writes LRU array only when needed
// Note: dcRead never hits in the cache because not in the cacheableSpecialOp signal which
//       goes to the comparator, therefore always choose writeLRU0
// Note: dcbz/dcba hit writes LRU twice.  Once after hits and again during fills, both to the same value.
assign writeLRU0 = fillRead1_state | (carDccci & xltValidL2 & carReadL2 & ~carAborted);
assign writeLRU1 = fillRead1_state | (carReadValid & ~carAborted);



// Does not actually cause a write and does not need to control exactly
// The only way to write the tag is with a line fill or invalidating.
// Tag contains only address, valid, and U0Attr
// Aborted store may write the data array but these signals will not allow the bit writes to be on
// Inputs to a 2:1 Mux/Reg with hit_a as the Mux select
// 0 - writeTagA0
// 1 - writeTagA1
assign writeTagA0 = fill_a | (xltValidL2 & ~specialOPDoneL2 & ~carAborted & carDccci);
assign writeTagA1 = fill_a | (xltValidL2 & ~specialOPDoneL2 & ~carAborted & (carDcbf | carDcbi| carDccci));


// Does not actually cause a write and does not need to control exactly
// Inputs to a 2:1 Mux/Reg with hit_b as the Mux select
// Aborted store may write the data array but these signals will not allow the bit writes to be on
// 0 - writeTagB0
// 1 - writeTagB1
assign writeTagB0 = fill_b | (xltValidL2 & ~specialOPDoneL2 & ~carAborted & carDccci);
assign writeTagB1 = fill_b | (xltValidL2 & ~specialOPDoneL2 & ~carAborted & (carDcbf | carDcbi| carDccci));



// dcbf does not write the dirty bit but writes the valid bit off when hit.
// These actually control the write of the dirty bits and need to be controled exactly
// Inputs to a 2:1 Mux/Reg with hit_a as the Mux select
// dccci can never have hit because not in the cacheable special Op signal
// which feed the comparator. That is why it is only on one leg
// 0 - writeDirtyA0
// 1 - writeDirtyA1
assign writeDirtyA0 = fill_a | (carReadValid & ~carAborted & carDccci);
assign writeDirtyA1 = fill_a | (carReadValid & ~carAborted & (carStore | carDcbst));


// dcbf does not write the dirty bit but writes the valid bit off when hit.
// These actually control the write of the dirty bits and need to be controled exactly
// Inputs to a 2:1 Mux/Reg with hit_b as the Mux select
// dccci can never have hit because not in the cacheable special Op signal
// which feed the comparator. That is why it is only on one leg
// 0 - writeDirtyB0
// 1 - writeDirtyB1
assign writeDirtyB0 = fill_b | (carReadValid & ~carAborted & carDccci);
assign writeDirtyB1 = fill_b | (carReadValid & ~carAborted & (carStore | carDcbst));



// Dont use LRU for dcbz hit's
assign fill_a = (fillRead1_state & ~dcbzFillHitL2 & ~LRU) |
                (fillRead1_state & dcbzFillHitA_L2);

assign fill_b = (fillRead1_state & ~dcbzFillHitL2 & LRU) |
                (fillRead1_state & dcbzFillHitL2 & ~dcbzFillHitA_L2);

// replaced the set term with fill_a
assign fill_A_In = (fill_A_L2 & ~fillWrite2_state) | fill_a;


// Used as the mux input for the newLRU_In
assign LRU_out_NEG = ~LRU;


// dcbz second write
assign dcbzFillHit_In = (dcbzFillHitL2 & ~fillRead1_state) | (carOF_dcbzCmdQual & (carOF_hitAL2 | carOF_hitBL2));

// dcbz Hit A latch
assign dcbzFillHitA_In = (dcbzFillHitA_L2 & ~fillRead1_state) | (carOF_dcbzCmdQual & carOF_hitAL2 );


//--------------------------------------------------------------------------------------------
//
// RAM Write signals
//
//--------------------------------------------------------------------------------------------
// 00 - SDQ/SDP
// 01 - Fill Buffer
// 10 - Gnd
// 11 - Write Buffer
// Bits 0-15 of writeBufMuxsel controls 16-byte muxes.
// writeBufMuxSelBit0 shared on the first 16 bytes
assign writeBufMuxSelBit0 = fillWrite1_state | testEn;

//Word 0
assign writeBufMuxSelBit1[0] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[1] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[2] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[3] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[3]));

//Word 1
assign writeBufMuxSelBit1[4] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[5] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[6] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[7] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[3]));

//Word 2
assign writeBufMuxSelBit1[8] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[9] = fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[10]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[11]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[3]));

//Word 3
assign writeBufMuxSelBit1[12]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[13]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[14]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[15]= fillWrite1_state | (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[3]));

// 0 - SDQ/SDP
// 1 - Fill Buffer
// Bits 16-31 of writeBufMuxsel controls 16-byte muxes.
// Word 4
assign writeBufMuxSelBit1[16]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[17]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[18]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[19]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[3]));

//Word 5
assign writeBufMuxSelBit1[20]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[21]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[22]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[23]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[3]));

//Word 6
assign writeBufMuxSelBit1[24]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[25]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[26]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[27]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[3]));

//Word 7
assign writeBufMuxSelBit1[28]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[0]));

assign writeBufMuxSelBit1[29]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[1]));

assign writeBufMuxSelBit1[30]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[2]));

assign writeBufMuxSelBit1[31]= (fillWrite2_state & dValidCntDoneL2) | (fillPend2Read1 &
                              ~((storeHitFillBufPendL2 | specialCaseL2) & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[3]));


// hi = 16 bytes in words 0-3    lo = 16 bytes in words 4-7
// words 0-3 go to the RAM
// words 4-7 feed words 0-3 for the shift
// dValidCntDoneL2 replaces fillPend2Read1 and (fillWrite2_state & dValidCntDoneL2)
assign writeBufHi_E1 = dValidCntDoneL2 | fillWrite1_state | storeHitPendAB | carStore;


// Words 0 - 3
assign writeBufHi_E2[0] = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) | fillWrite1_state |
                           (storeHitPendAB & ~(exeLoad & dcu_CA_exeLdSt) & ~fillRead1_state & ~fillRead2_state &
                              (SAQ_L2[28:29] == 2'b00)) |
                           (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt) & (CAR_buf[28:29] == 2'b00));

assign writeBufHi_E2[1] = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) | fillWrite1_state |
                           (storeHitPendAB & ~(exeLoad & dcu_CA_exeLdSt) & ~fillRead1_state & ~fillRead2_state &
                              (SAQ_L2[28:29] == 2'b01)) |
                           (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt) & (CAR_buf[28:29] == 2'b01));

assign writeBufHi_E2[2] = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) | fillWrite1_state |
                           (storeHitPendAB & ~(exeLoad & dcu_CA_exeLdSt) & ~fillRead1_state & ~fillRead2_state &
                              (SAQ_L2[28:29] == 2'b10)) |
                           (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt) & (CAR_buf[28:29] == 2'b10));

assign writeBufHi_E2[3] = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2) | fillWrite1_state |
                           (storeHitPendAB & ~(exeLoad & dcu_CA_exeLdSt) & ~fillRead1_state & ~fillRead2_state &
                               (SAQ_L2[28:29] == 2'b11)) |
                           (carStore & carReadValid & ~(exeLoad & dcu_CA_exeLdSt) & (CAR_buf[28:29] == 2'b11));



// E1 for writeBuf lo (words 4-7 16-byte regs) and the writeBuf tag, Tag does not have an E2 because L1 output.
// Using dup fillSM and dValidCntDoneL2
assign writeBufLoTag_E1 = (fillPend_state2 | fillWrite2_state2) & dValidCntDone2L2;

assign writeBufLo_E2 = ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2);



//--------------------------------------------------------------------------------------------
//
// RAM input signals
//
//--------------------------------------------------------------------------------------------
// newLRU value select
// Mux/Reg selects for 4:1 mux
// 00 = hit_a           (~hit_side)
// 01 = LRU_out_NEG     (fills)
// 10 = ~hit_a          (hit_side)
// 11 = dcbzFillHitA_L2 (dccci and dcbzHits)

// The fill read state machine is mutually exclusive with the car Special Ops
// Note: dcbz/dcba hit writes LRU twice.  Once after hits and again during fills, both to the same value.
assign LRU_sel0 = carDcbf | carDccci | carDcbi | dcbzFillHitL2;
assign LRU_sel1 = carDccci | fillRead1_state | dcbzFillHitL2;



// VALID

// Dont need hit in these equations because used in the tagReadWriteCycle equation
// which writes only when needed.
// The writeTagA and writeTagB signals control the side to write when the tagReadWriteCycle signal is on.
assign newValidIn = ~(carDccci | carDcbf | carDcbi) | fillRead1_state;



// DIRTY
// When to write the dirty bits is precisely controled by writeDirtyA and writeDirtyB
assign newDirtyIn = (fillRead1_state &  WB_lineDirtyReadL2) | (carStore & carReadValid & ~CAR_writethru);



// Fill line dirty latch
assign set_fillLineDirty = (storeHitFillBufPendL2 & ~SAQ_writeThruL2 & ~dValidCntDoneL2) |
                           (LSA_loadingStore & ~carOF_writeThruL2) | carOF_dcbzCmdQual;

assign fillLineDirty_In = (fillLineDirtyL2 & ~dValidCntDoneL2) | set_fillLineDirty;



// WB lineDirty Used for case of store that hits in fill buffer the cycle it is moving to the WB
assign WB_lineDirtyIn = fillLineDirtyL2 | (specialCaseL2 & ~SAQ_writeThruL2) |
                        (storeHitFillBufPendL2 & ~SAQ_writeThruL2 & dValidCntDoneL2);


//--------------------------------------------------------------------------------------------
//
// ByteWrite Logic
//
//--------------------------------------------------------------------------------------------
// Indicates when a fill or dcbz operation may be going to a write state
assign fillOrDcbz = fillRead1_state | fillWrite1_state | fillRead2_state;

always @(CAR_buf or fillOrDcbz or carByteEn or storeHitPendAB or SAQ_byteEn or SAQ_L2)
begin
   casez ({fillOrDcbz, storeHitPendAB})
   2'b00: begin  // store condition
             casez (CAR_buf[28:29]) 
                2'b00:   byteWriteData[0:15] = {carByteEn[0:3], 12'b000000000000};
                2'b01:   byteWriteData[0:15] = {4'b0000, carByteEn[0:3], 8'b00000000};
                2'b10:   byteWriteData[0:15] = {8'b00000000, carByteEn[0:3], 4'b0000};
                2'b11:   byteWriteData[0:15] = {12'b000000000000, carByteEn[0:3]};
                default: byteWriteData[0:15] = 16'bxxxxxxxxxxxxxxxx;
             endcase
          end
   2'b01: begin  // store condition from SAQ
             casez (SAQ_L2[28:29]) 
                2'b00:   byteWriteData[0:15] = {SAQ_byteEn[0:3], 12'b000000000000};
                2'b01:   byteWriteData[0:15] = {4'b0000, SAQ_byteEn[0:3], 8'b00000000};
                2'b10:   byteWriteData[0:15] = {8'b00000000, SAQ_byteEn[0:3], 4'b0000};
                2'b11:   byteWriteData[0:15] = {12'b000000000000, SAQ_byteEn[0:3]};
                default: byteWriteData[0:15] = 16'bxxxxxxxxxxxxxxxx;
             endcase
          end

   2'b1?: begin  // line fill or dcbzCmd fill condition
             byteWriteData[0:15] = 16'b1111111111111111;
         end
   endcase
end


// This E1 is for a latch with an L1 output
assign byteWrite_E1 = carStoreDup | storeHitPendABDup | (~fillIdle_state2 & ~fillPend_state2);


//----------------------------------------------------------------------------------------------
//
// CAR OF
//
// Comment: If in OF then command has xltValid and has read array and can't be aborted.
// Comment: When in CAR_OF can never go to the PLB without also needing to go to the LSA.
//----------------------------------------------------------------------------------------------
// Controls all OF except CAR_OF_fullL2
assign CAR_OF_E1 = carFullL2 | CAR_OF_fullL2 | reset4L2;
assign CAR_OF_E2 = carReadValid | resetL2;


// CAR_OF_full status register
// Commands that enter OF:
// (1) - Must go to the LSA
// (2) - OCM_hold
// (3) - Need data from current LSA not yet available.
// All misses (except store miss nonAlloc and store miss FB hit) (The only special ops are dcbt/dcbz/dcba).
// All load non-cache that not currently being bypassed
// Load or store with OCM_dsHold_noWait
// Set and reset are mutually exclusive: don't care about set/reset dominance
// CAR_OF_storeL2, carOF_loadL2, carOF_dcbtL2, and carOF_dcbzCmdL2 must be qualified with CAR_OF_fullL2
// OCM_dsComplete_noWait can be moved with ~hit_a and ~hit_b to help timing if needed?

// CAR_OF_fullL2 is a 2:1 Mux/Reg with:
// Leg 0 having (CAR_OF_fullL2 & ~reset_CAR_OF_full) | set_CAR_OF_full_no_hit
// Leg 1 having (~hit_A & ~hit_B)
// Sel is the set term with the ~hit_a and ~hit_b anded because miss is on leg1

assign sel_CAR_OF_full = // Miss cases and Load non-cacheable (Was anded with ~hit_a & ~hit_b)
                         (carReadValid & ~carAborted &
                          ((carDcbt & CAR_cacheableBuf1) |
                           (carLoad & ~OCM_dsComplete_noWaitXltV & ~(CAR_LSAcmp & carMuxTargetValid)) |
                           (carStore & CAR_cacheableBuf1 & ~(CAR_LSAcmp & LSA_SM & ~(LSA_loadL2 & loadNonAlloc)) &
                               ~OCM_dsComplete_noWaitXltV & ~storeNonAlloc))) & ~resetL2;


assign reset_CAR_OF_full = carOF_dcbzCmdQual |
                           (LSA_free & ((PLBAR_selOF & loadPLBAR_early) | CAR_OF_PLB_loadedL2)) |
                           (OCM_dsComplete_noWait & carOF_dsHoldQual) |
                           (carOF_loadQual & carMuxTargetValid & carOF_LSAcmp) | resetL2;

assign CAR_OF_full_In0   = (CAR_OF_fullL2 & ~reset_CAR_OF_full) |
                              (carReadValid & ~carAborted & (carDcbzCmd_i | OCM_dsHold_noWait));



// CAR OF terms
assign carOF_storeQual    = CAR_OF_fullL2 & carOF_storeL2;
assign carOF_loadQual     = CAR_OF_full2L2 & carOF_loadL2;
assign carOF_dcbtQual     = CAR_OF_fullL2 & carOF_dcbtL2;
assign carOF_dcbzCmdQual  = CAR_OF_fullL2 & carOF_dcbzCmdL2;
assign carOF_miss         = carOF_cacheableL2 & ~carOF_hitAL2 & ~carOF_hitBL2;
assign carOF_before_SAQ   = carOF_writeThruL2 & carOF_storeQual;
assign carOF_dsHoldQual   = carOF_dsHoldL2 & CAR_OF_fullL2;



// Used to block the carOF_OP from requesting a line fill to prevent the possibility of more then twoFP.
// The twoFP case is not needed because the mux sel will always choose FAR when twoFP
// Also only need dValidQ0_full because if dValidQ1_full with a line, then it is in OF and nothing else
// can go out on the PLB from the OF.
// Occurs when a flush is in progress and a fill is in progress and another fill is needed in the CAR_OF.
// The CAR_OF must wait to prevent more then twoFP.
assign block_carOF = (oneFPL2 & ((dVQ0_fullL2[0] & dVQ0_lineL2 & LSA_cacheableL2) | fillRead1_state));


// CAR_PLB_loaded latch
assign CAR_OF_PLB_loaded_In = (CAR_OF_PLB_loadedL2 | (loadPLBAR_early & PLBAR_selOF)) & ~LSA_free;



// Added condition to block PLB from loading a command from the OF when the LSA is full with the same
// address and loading a line.  It can only happens with a load that will hit in the fill buffer that
// moves to the OF.
assign carOF_OP_qual    = (carOF_loadQual & ~carOF_dsHoldL2 & ~block_carOF & ~CAR_OF_PLB_loadedL2 &
                            ~(LSA_SM & carOF_LSAcmp & (carOF_cacheableL2 | (~carOF_cacheableL2 & loadWordAsLine)))) |
                          (carOF_storeQual & ~carOF_dsHoldL2 & ~block_carOF & ~CAR_OF_PLB_loadedL2) |
                           carOF_dcbtQual;



//--------------------------------------------------------------------------------------------
//
// LSA State Machine and signals
//
//--------------------------------------------------------------------------------------------
// Second term in LSA_needed was load_nc_needed but only used here.
// ??? What about no wait
assign LSA_needed = ~carOF_dsHoldL2 &
                    (carOF_dcbtQual | carOF_storeQual |
                    (carOF_loadQual & ~(carOF_LSAcmp & LSA_SM)));


assign LSA_free   = ~LSA_SM | dValidCntDoneL2;


// Reload the LSA with another address if free and needed or if the current address has no load pending
// and a load in the CAR misses to the same address that is in the LSA but the data is not there for the
// load in the CAR.
assign LSA_E1_i      = CAR_OF_full2L2;
assign LSA_E2      = LSA_free & (LSA_needed | carOF_dcbzCmdQual);
assign LSA_load_In = carOF_loadQual;



// When LSA_SM is set there is an address valid in the LSA.
// Also it is valid whenever the dValidCntDoneL2 signal is set.
assign LSA_SM_In_i =

         (LSA_needed & PLBAR_selOF & loadPLBAR_early) |           // IL2Vl/Vl2Vl: New OP moving to PLB
         (carOF_dcbzCmdQual) |                                    // IL2Vl: New dcbz cmd
         (LSA_SM & ~dValidCntDoneL2) |                            // Vl2Vl: not done
         (LSA_needed & CAR_OF_PLB_loadedL2);                      // Vl2Vl: done and another loaded om PLB



//--------------------------------------------------------------------------------------------
//
// SAQ Status
//
//--------------------------------------------------------------------------------------------
// Controls the SAQ address register and the SAQ_byteEn, SAQ_guarded, SAQ_cacheable, SAQ_U0Attr, SAQ_writethru
// Also used for the SDP E1 and E2.
assign SAQ_E1 = carStore | carDcbz | carDcba;
assign SAQ_E2 = carReadValid;

// 2:1 Mux/Reg with miss (Also covers nonCacheables) as the select
// 0 - SAQvalidNeedingPLB0
// 1 - SAQvalidNeedingPLB1

// Hit
assign PLBAR_selSAQ = PLBAR_selSAQ_i;
assign SAQvalidNeedingPLB0 = ((carStore & ~carAborted & carReadValid & CAR_writethru) |
                              (SAQvalidNeedingPLBL2 & ~(PLBAR_selSAQ_i & loadPLBAR_early))) & ~resetL2;

// Miss/NC
// For store non-Aloc must check that the store does not hit in the fill buffer and
// that it is valid with an allocating load (Issue 8 Pass2)
assign SAQvalidNeedingPLB1 = ((carStore & ~carAborted & carReadValid &
                                  ~OCM_dsComplete_noWaitXltV & ~OCM_dsHold_noWait &
                               (~CAR_cacheableBuf2 | CAR_writethru |
                                  (storeNonAlloc & ~(CAR_LSAcmp & LSA_SM & LSA_cacheableL2 &
                                   ~(loadNonAlloc & LSA_loadL2))))) |
                              (SAQvalidNeedingPLBL2 & ~(PLBAR_selSAQ_i & loadPLBAR_early))) & ~resetL2;



//--------------------------------------------------------------------------------------------
//
// SDQ/SDP controls
//
//--------------------------------------------------------------------------------------------
assign SDQ_E1 = exeStore2 | exeDcbz | exeDcba;
assign SDQ_E2 = new_acc_command;

// 0 - SDQ
// 1 - SDP
// The output of this mux goes to the Write Buffer only.
assign SDQ_SDP_mux = storeHitPendAB | specialCaseL2 | (storeHitFillBufPendL2 & dValidCntDoneL2);


// This latch is set anytime a store hits in the FB.  Only on for one cycle (usless followed by addition
// store to the FB) because the data will move to either the FB or WB in the next cycle.
// Made stores that hit in the FB, when FB is for load word as line. It will not write the data into the cache.
assign storeHitFillBufPend_In = carStore & carReadValid & CAR_LSAcmp & LSA_SM & ~carAborted & ~dValidCntDoneL2 &
                                ~(LSA_bypassPendingL2 & (LSA_L2[27:29]==CAR_buf[27:29]));



//--------------------------------------------------------------------------------------------
//
// PLB_AR and attributes
//
//--------------------------------------------------------------------------------------------
// PLBAR mux selects
// 00 = CAR_OF
// 01 = FAR
// 1x = SAQ


//PLBAR MUX SELECT CASE STATEMENT
// 8/6/98  Added the LSA_valid_state and changed the CARMux_EQ_LSA to carMuxLSAcmp so that it can
// 8/11/98 Added the CARMux_EQ_SAQ to a couple of cases where the load from the CAR or CAR_OF was nonCache
//         and matched the address of the SAQ and the wrAckQ was busy.  Dont do the load NC.
// 8/20/98 Added the lsaFARcmp
// be promoted later in the logic.  All cases where the carMuxLSAcmp is 0 had to be coppied and have the
// 0 in both the carMuxLSAcmp and the LSA_valid_state.
// 9/29/98 New case statement. Took out ability to have NC from CAR and nothing from the LSA

assign PLBAR_selFAR = PLBAR_selFAR_i;
always @ (twoFPL2 or FAR_fullL2 or SAQvalidNeedingPLBL2 or wrAckQ_fullL2 or SAQ_FARcmp or
          carOF_OP_qual or carOF_before_SAQ or carOF_FARcmp)

begin

PLBAR_E2_pre = 1'b0;
PLBAR_selOF  = 1'b0;
PLBAR_selSAQ_i = 1'b0;
PLBAR_selFAR_i = 1'b0;

   casez ({twoFPL2, FAR_fullL2, SAQvalidNeedingPLBL2, wrAckQ_fullL2, SAQ_FARcmp,
           carOF_OP_qual,carOF_before_SAQ, carOF_FARcmp }) 
//    twoFPL2
//    |FAR_fullL2
//    ||
//    || SAQvalidNeedingPLBL2
//    || |wrAckQ_fullL2
//    || ||SAQ_FARcmp
//    || |||
//    || ||| carOF_OP_qual
//    || ||| |carOF_before_SAQ
//    || ||| ||carOF_FARcmp
//    || ||| |||
//    vv vvv vvv
// 8'b?0_0??_0??:                            // Nothing
   8'b?0_0??_1??:begin
                     PLBAR_selOF     = 1'b1;  // OF only
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b?0_10?_0??:begin
                     PLBAR_selSAQ_i    = 1'b1;  // SAQ
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b?0_10?_10?:begin
                     PLBAR_selSAQ_i    = 1'b1;  // SAQ before OF
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b?0_1??_11?:begin
                     PLBAR_selOF     = 1'b1;  // OF before SAQ
                     PLBAR_E2_pre    = 1'b1;
                  end
// 8'b?0_11?_0??:                            // SAQ wait for wrAckQ
// 8'b?0_11?_10?:                            // SAQ before OF and wait for wrAckQ
   8'b?1_00?_0??:begin
                     PLBAR_selFAR_i    = 1'b1;  // FAR to flush
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b01_0??_1?0:begin
                     PLBAR_selOF     = 1'b1;  // OF before FAR
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b?1_00?_1?1:begin
                     PLBAR_selFAR_i    = 1'b1;  // FAR to flush before OF
                     PLBAR_E2_pre    = 1'b1;
                  end
// 8'b?1_01?_0??:                            // Flush wait on wrAckQ
// 8'b?1_01?_1?1:                            // Flush before OF when equal wait on wrAckQ
   8'b01_100_0??:begin
                     PLBAR_selSAQ_i    = 1'b1;  // SAQ before flush
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b01_100_10?:begin
                     PLBAR_selSAQ_i    = 1'b1;  // SAQ before flush and OF
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b01_1?0_11?:begin
                     PLBAR_selOF     = 1'b1;  // OF before SAQ and flush
                     PLBAR_E2_pre    = 1'b1;
                  end
   8'b?1_101_???:begin
                     PLBAR_selFAR_i    = 1'b1;  // FAR before SAQ when equal
                     PLBAR_E2_pre    = 1'b1;
                  end
// 8'b?1_110_0??:                            // Flush and SAQ wait for wrAckQ
// 8'b?1_110_10?:                            // Flush, SAQ, and OF wait for wrAckQ SAQ first
// 8'b?1_111_???:                            // Flush and SAQ wait for wrAckQ when equal
   8'b1?_?0?_???:begin
                     PLBAR_selFAR_i    = 1'b1;  // FAR first when two FP
                     PLBAR_E2_pre    = 1'b1;
                  end
// 8'b1?_?1?_???:                            // Two FP wait for wrAckQ
  endcase
end



assign global_addr_PL_disable = (dontPipeReq & dVQ0_fullL2[0]) |                       // Stops pipelinning

                                (twoFPL2 & CAR_OF_fullL2 & wrAckQ_fullL2) |             // Catches oneFP->twoFP
                                                                                        // The wrAckQ_full allows
                                                                                        // the flush to go out.
                                (oneFPL2 & CAR_OF_fullL2 & ((dVQ0_fullL2[0] & dVQ0_lineL2) |
                                                            (dVQ1_fullL2 & dVQ1_lineL2) |
                                                            (fillPend2Read1_2 | fillRead1_state))) ;


// Was the PLBAR_E1 but was too late.
assign loadPLBAR_early = ((~DCU_requestDupL2 & sampleCycleL2) & ~global_addr_PL_disable);

assign PLBAR_E1 = (~DCU_requestDupL2 & sampleCycleL2);

wire PLBAR_E2_i;
assign PLBAR_E2 = PLBAR_E2_i;
assign PLBAR_E2_i = loadPLBAR_early & PLBAR_E2_pre;

// The PLBDR_E1 is sampleCycle
// Made this a NOR and added an inverter Helps to reduce input cap and timing
//dp_logDCU_DRor logDCU_DRnor( .Z(PLBDR_E2_nor[0:3]),
//                             .A({4{PLB_dcuWrDAck}}),
//                             .B({4{((PLBAR_selSAQ_i | PLBAR_selFAR_i) & loadPLBAR_early)}}));
// Removed the module 'dp_logDCU_DRor'
assign PLBDR_E2_nor[0:3] = ~( {4{PLB_dcuWrDAck}} | {4{((PLBAR_selSAQ_i | PLBAR_selFAR_i) & loadPLBAR_early)}} );


//dp_logDCU_DRinv logDCU_DRinv( .Z(PLBDR_E2[0:3]),
//                              .A(PLBDR_E2_nor[0:3]));
// Removed the module 'dp_logDCU_DRinv'
assign PLBDR_E2[0:3] = ~(PLBDR_E2_nor[0:3]);


// 2:1 Mux/Reg
// 0 - new data from either FDR or SDP
// 1 - Shift for 32 bit flushes
// AO21
// 5/7/99 Changed from AO21 -> OAI21.  Inverted inputs and changed function.
//dp_logDCU_DRsel logDCU_DRsel( .Z(PLBDR_hiMuxSel[0:3]),
//                              .A1({4{PLB_dcuSsizeBuf2}}),
//                              .A2({4{~(~wrAckQ_fullL2 & DCU_requestDupL2 & ~DCU_plbRNW_dupL2)}}),
//                              .B({4{~(wrAckQ_fullL2 & ~wrAckQ_sizeL2 & wrAckQ_lineL2 & ~wrAckCntL2[2])}}));
// Removed the module 'dp_logDCU_DRsel'
assign PLBDR_hiMuxSel[0:3] = ~( ({4{PLB_dcuSsizeBuf2}} | {4{~(~wrAckQ_fullL2 & DCU_requestDupL2 & ~DCU_plbRNW_dupL2)}}) & 
                                 {4{~(wrAckQ_fullL2 & ~wrAckQ_sizeL2 & wrAckQ_lineL2 & ~wrAckCntL2[2])}} );


// DCU request
// 2:1 Mux/Reg
// 0 - DCU_request_In
// 1 - gnd
// Sel = addrAck
assign DCU_request_In = (DCU_requestDupL2 | (~global_addr_PL_disable & PLBAR_E2_i)) & ~resetSCL2;

assign resetIn = resetCore | (resetL2 & ~resetSCL2) | ICU_syncAfterReset;




// Next Proirity
// This is the input to the priority latch and is set whenever it is a samplecycle and
// (1) Any time any load that needs data not in cache
// (2) When any load is already in request.
// (3) Whenever DCU_CA is off
assign priority_In   = ~DCU_CA_i | DCUbypassPendingL2;



// The following signals are together in the same register with the E1 = PLBAR_E1 and E2 = PLBAR_E2_i
// DCU_RNW_In, DCU_tranSize_In, DCU_cacheable_In, DCU_guarded_In, DCU_writeThru_In, DCU_U0Attr_In, DCU_byteEn_In

// Next RNW
assign DCU_RNW_In = PLBAR_selOF;



// Next plb tran size
// 0 = word
// 1 = line
// Does not need CAR_OF_fullL2 because in the PLBAR_selXXX term
assign DCU_tranSize_In = PLBAR_selFAR_i |

                        (PLBAR_selOF & carOF_cacheableL2 &
                             ((carOF_loadQual & (~loadNonAlloc | (loadNonAlloc & loadWordAsLine))) |
                               carOF_dcbtQual | carOF_storeQual)) |

                        (PLBAR_selOF & ~carOF_cacheableL2 & carOF_loadQual & loadWordAsLine & ~carOF_guardedL2);


// Next plbCachable
assign DCU_cacheable_In = PLBAR_selFAR_i | (PLBAR_selOF & carOF_cacheableL2) | (PLBAR_selSAQ_i & SAQ_cacheableL2);

// Next guarded
assign DCU_guarded_In   = (PLBAR_selOF & carOF_guardedL2) | (PLBAR_selSAQ_i & SAQ_guardedL2);

assign DCU_writeThru_In =  (PLBAR_selSAQ_i & SAQ_writeThruL2) | (PLBAR_selOF & carOF_writeThruL2);

assign DCU_U0Attr_In = ((PLBAR_selSAQ_i & SAQ_U0AttrL2) | (PLBAR_selOF & carOF_U0AttrL2) |
                        (PLBAR_selFAR_i & U0AttrFAR));


// Next byteEn

assign DCU_byteEn_In[0] = (PLBAR_selOF & carOF_byteEn[0] & ~CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[0] & ~SAQ_L2[29]);

assign DCU_byteEn_In[1] = (PLBAR_selOF & carOF_byteEn[1] & ~CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[1] & ~SAQ_L2[29]);

assign DCU_byteEn_In[2] = (PLBAR_selOF & carOF_byteEn[2] & ~CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[2] & ~SAQ_L2[29]);

assign DCU_byteEn_In[3] = (PLBAR_selOF & carOF_byteEn[3] & ~CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[3] & ~SAQ_L2[29]);

assign DCU_byteEn_In[4] = (PLBAR_selOF & carOF_byteEn[0] & CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[0] & SAQ_L2[29]);

assign DCU_byteEn_In[5] = (PLBAR_selOF & carOF_byteEn[1] & CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[1] & SAQ_L2[29]);

assign DCU_byteEn_In[6] = (PLBAR_selOF & carOF_byteEn[2] & CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[2] & SAQ_L2[29]);

assign DCU_byteEn_In[7] = (PLBAR_selOF & carOF_byteEn[3] & CAR_OF_L2[29]) |
                          (PLBAR_selSAQ_i & SAQ_byteEn[3] & SAQ_L2[29]);




// 2:1 Mux/Reg with
// 0 = DCU_plbAddrBus_In[30:31]
// 1 = gnd
// Select = DCU_tranSize_In
always @ (PLBAR_selSAQ_i or carOF_byteEn or SAQ_byteEn)

begin
   casez ({PLBAR_selSAQ_i}) 
   1'b0: begin
             DCU_plbAddrBus_In[30] = ~(carOF_byteEn[0] | carOF_byteEn[1]);
             DCU_plbAddrBus_In[31] = ~((carOF_byteEn[2] & ~carOF_byteEn[1]) | carOF_byteEn[0]);
          end
   1'b1: begin
             DCU_plbAddrBus_In[30] = ~(SAQ_byteEn[0] | SAQ_byteEn[1]);
             DCU_plbAddrBus_In[31] = ~((SAQ_byteEn[2] & ~SAQ_byteEn[1]) | SAQ_byteEn[0]);
          end
   endcase
end



assign DCU_someBusy_In = carFullL2 | CAR_OF_fullL2 | DCU_requestDupL2 | ~flushIdle_state_i | ~fillIdle_state |
                         LSA_SM | wrAckQ_fullL2 | SAQvalidNeedingPLBL2;




//--------------------------------------------------------------------------------------------
//
// wrAck Queue signals
//
//--------------------------------------------------------------------------------------------
// This signal is used to indicate that the count is almost done
// When anded with wrAck the cntDone signal will be on the next cycle.
assign wrAckAlmostDone = (wrAckCntL2[0:2] == 3'b111) | ((wrAckCntL2[0:2] == 3'b110) & wrAckQ_sizeL2);


// Reg has E1=SC and No E2
// 4:1 Mux/Reg select is PLB_dcuAdrAck and PLB_dcuWrDAck
// 00 = wrAckQ_full_In00
// x1 = wrAckQ_full_In01
// 10 = wrAckQ_full_In10
// wrAckCntDoneL2 and wrAckQ_fullL2 are mutually exclusive.  When the wrAckQfullL2 resets (equals 0) the
// wrAckCntDoneL2 will be active (equal 1).

assign wrAckQ_full_In00 = wrAckQ_fullL2 & ~resetL2;
assign wrAckQ_full_Inx1 = ~wrAckAlmostDone & ~resetL2;
assign wrAckQ_full_In10 = (~DCU_plbRNW_dupL2 | wrAckQ_fullL2) & ~resetL2;

// 2 bit latch single port.  Latches PLB_sSize and DCU_tranSize
assign wrAckQ_sizeTran_E1 = (sampleCycleL2 & ~DCU_plbRNW_dupL2 & DCU_requestDupL2) | reset4L2;



//--------------------------------------------------------------------------------------------
//
// dValid Queue signals
//
//--------------------------------------------------------------------------------------------
// This signal is used to indicate that the count is almost done
// When anded with rdDAck the cntDone signal will be on the next cycle.
assign almostDone = (dValidCntL2[0:2] == 3'b111) | ((dValidCntL2[0:2] == 3'b110) & dVQ0_sizeL2);

// The following mux selects are for the entire DV queue
// MuxSelect [0] = PLB_dcuAddrAck
// MuxSelect [1] = PLB_dcuRdDAck

// DVQ0_full
// 00 = dVQ0Full_In00
// 01 = dVQ0Full_In01
// 10 = dVQ0Full_In10
// 11 = dVQ0Full_In11
//----------------------------------------------------------------------------------------------------
assign dVQ0Full_In00 = dVQ0_fullL2[0] & ~resetL2;
assign dVQ0Full_In01 = (dVQ1_fullL2 | ~almostDone) & ~resetL2;
assign dVQ0Full_In10 = (DCU_plbRNW_dupL2 | dVQ0_fullL2[1]) & ~resetL2;
assign dVQ0Full_In11 = (dVQ1_fullL2 | DCU_plbRNW_dupL2 | ~almostDone) & ~resetL2;


// DVQ0_size (PLB_dcuSlaveSize)
// 00 = Feedback
// 01 = dVQ0Size_In01
// 10 = dVQ0Size_In10
// 11 = dVQ0Size_In11
//----------------------------------------------------------------------------------------------------
assign dVQ0Size_In01 = (~almostDone & dVQ0_sizeL2) | (almostDone & dVQ1_sizeL2);
//assign dVQ0Size_In10 = (~dVQ0_fullL2 & PLB_dcuSsize) | (dVQ0_fullL2 & dVQ0_sizeL2);
   // Replacing instantiation: GTECH_AO21 SGT_dcuSize10
   assign dVQ0Size_In10 = (PLB_dcuSsizeBuf1 & ~dVQ0_fullL2[0]) | dVQ0_fullL2[0] & dVQ0_sizeL2;


//assign dVQ0Size_In11 = (dVQ1_fullL2 & almostDone & dVQ1_sizeL2) | (~almostDone & dVQ0_sizeL2) |
//                       (~dVQ1_fullL2 & almostDone & PLB_dcuSsize);
   // Replacing instantiation: GTECH_AO21 SGT_dcuSize11
   assign dVQ0Size_In11 = (PLB_dcuSsizeBuf1 & (~dVQ1_fullL2 & almostDone)) | (dVQ1_fullL2 & almostDone & dVQ1_sizeL2) | (~almostDone & dVQ0_sizeL2);




// DVQ0_line (Transfer size 1 = Line   0 = Word)
// 00 = Feedback
// 01 = dVQ0Tran_In01
// 10 = dVQ0Tran_In10
// 11 = dVQ0Tran_In11
//----------------------------------------------------------------------------------------------------
assign dVQ0Tran_In01 = (~almostDone & dVQ0_lineL2) | (almostDone & dVQ1_lineL2);
assign dVQ0Tran_In10 = (~dVQ0_fullL2[1] & DCU_tranSize) | (dVQ0_fullL2[1] & dVQ0_lineL2);
assign dVQ0Tran_In11 = (~almostDone & dVQ0_lineL2) | (dVQ1_fullL2 & almostDone & dVQ1_lineL2) |
                       (~dVQ1_fullL2 & almostDone & DCU_tranSize);



// DVQ1_full
// 00 = dVQ1Full_In00
// 01 = dVQ1Full_In01
// 10 = dVQ1Full_In10
// 11 = dVQ1Full_In11
//----------------------------------------------------------------------------------------------------
assign dVQ1Full_In00 = dVQ1_fullL2 & ~resetL2;
assign dVQ1Full_In01 = dVQ1_fullL2 & ~almostDone & ~resetL2;
assign dVQ1Full_In10 = (DCU_plbRNW_dupL2 & dVQ0_fullL2[1] & ~resetL2) |
                       (dVQ1_fullL2 & ~resetL2);
assign dVQ1Full_In11 = (dVQ0_fullL2[1] & ~almostDone & dVQ1_fullL2 & ~resetL2) |
                       (dVQ0_fullL2[1] & DCU_plbRNW_dupL2 & ~almostDone & ~resetL2);


// DVQ1_size
// 00 = Feedback
// 01 = Feedback
// 10 = dVQ1Size_In10
// 11 = dVQ1Size_In11
//----------------------------------------------------------------------------------------------------
assign dVQ1Size_In10   = (DCU_plbRNW_dupL2 & PLB_dcuSsizeBuf1) | (~DCU_plbRNW_dupL2 & dVQ1_sizeL2);

//assign dVQ1Size_In11 = (~dVQ1_fullL2 & ~resetL2 & PLB_dcuSsize) |
//                       (dVQ1_fullL2 & dVQ1_sizeL2 & ~resetL2);
   // Replacing instantiation: GTECH_AO21 SGT_dcu_Q1size1
   assign dVQ1Size_In11 = (PLB_dcuSsizeBuf1 & (~dVQ1_fullL2 & ~resetL2)) | dVQ1_fullL2 & dVQ1_sizeL2 & ~resetL2;


// DVQ1_line (Transfer size  1 = Line  0 = Word
// 00 = Feedback
// 01 = Feedback
// 10 = dVQ1Tran_In10
// 11 = dVQ1Tran_In11
//----------------------------------------------------------------------------------------------------
assign dVQ1Tran_In10 = (DCU_plbRNW_dupL2 & DCU_tranSize) | (~DCU_plbRNW_dupL2 & dVQ1_lineL2);
assign dVQ1Tran_In11 = (~dVQ1_fullL2 & ~resetL2 & DCU_tranSize) |
                        (dVQ1_fullL2 & dVQ1_lineL2 & ~resetL2);


assign dVQ_In00[0:6] = {dVQ0Full_In00, dVQ0Full_In00, dVQ0_lineL2,
                        dVQ0_sizeL2, dVQ1Full_In00, dVQ1_lineL2, dVQ1_sizeL2};

// Added testEn to help remove redundancys.
assign dVQ_In01[0:6] = {dVQ0Full_In01, dVQ0Full_In01, dVQ0Tran_In01,
                        dVQ0Size_In01, dVQ1Full_In01, (dVQ1_lineL2 ^ testEn), (dVQ1_sizeL2 ^ testEn)};

assign dVQ_In10[0:6] = {dVQ0Full_In10, dVQ0Full_In10, dVQ0Tran_In10,
                        dVQ0Size_In10, dVQ1Full_In10, dVQ1Tran_In10, dVQ1Size_In10};

assign dVQ_In11[0:6] = {dVQ0Full_In11, dVQ0Full_In11, dVQ0Tran_In11,
                        dVQ0Size_In11, dVQ1Full_In11, dVQ1Tran_In11, dVQ1Size_In11};


//--------------------------------------------------------------------------------------------
//
// Fill signals
//
//--------------------------------------------------------------------------------------------
// Covers load/store/dcbt fills
// dcbz/dcba handeled separately
assign fillNeeded = LSA_SM & LSA_cacheableL2 & ~(LSA_loadL2 & loadNonAlloc);

assign carMux[27] = (CAR_OF_fullL2 & CAR_OF_L2[27]) | (~CAR_OF_fullL2 & CAR_L2_buf1[27]);
assign carMux[28] = (CAR_OF_fullL2 & CAR_OF_L2[28]) | (~CAR_OF_fullL2 & CAR_L2_buf1[28]);
assign carMux[29] = (CAR_OF_fullL2 & CAR_OF_L2[29]) | (~CAR_OF_fullL2 & CAR_L2_buf1[29]);




// 000 - Fill buf word 0 bypass
// 001 - Fill buf word 1 bypass
// 010 - Fill buf word 2 bypass
// 011 - Fill buf word 3 bypass
// 100 - Fill buf word 4 bypass
// 101 - Fill buf word 5 bypass
// 110 - Fill buf word 6 bypass
// 111 - Fill buf word 7 bypass
assign bypassMuxSel[0:2] = (LSA_bypassPendingL2 == 1'b1) ? LSA_L2[27:29] : carMux[27:29];



assign fillIdle_state    = fillSM[0];
assign fillPend_state    = fillSM[1];
assign fillRead1_state   = fillSM[2];
assign fillWrite1_state  = fillSM[3];
assign fillRead2_state   = fillSM[4];
assign fillWrite2_state  = fillSM[5];
assign fillPend2Read1    = fillPend_state & dValidCntDoneL2 ;

// Dup fillSM
assign fillIdle_state2    = fillSM2[0];
assign fillPend_state2    = fillSM2[1];
assign fillRead1_state2   = fillSM2[2];
assign fillWrite1_state2  = fillSM2[3];
assign fillRead2_state2   = fillSM2[4];
assign fillWrite2_state2  = fillSM2[5];
assign fillPend2Read1_2   = fillPend_state2 & dValidCntDone2L2 ;

assign fill2Write2       = fillRead2_state | (fillWrite1_state & ~fillFlushToDoL2);

assign fillFlushToDo_In  = fillRead1_state & ~dcbzFillHitL2 &
                             ((~LRU & validA & dirtyA) | (LRU & validB & dirtyB));

assign fillUsingArray_i    = fillRead1_state | fillWrite1_state | fillRead2_state |
                           ((fillPend_state2 | fillFollowedByFillL2) & dValidCntDone2L2);

// Used to indicate when a fill is completing the next cycle and is later anded with dValidCntDone to
// determin if another fill is beginning.  Used to help timing in DCU_CA.
assign fillFollowedByFill_In = fill2Write2 & LSA_cacheableL2 & ~(LSA_loadL2 & loadNonAlloc);


// Issue 178 fix.
// But 27 is forced off to the data array index regs to allow the first 4 words to be read first.
//assign forceDataIndexZero_mmu = new_acc_command & (exeDcbf | exeDcbst);

assign forceDataIndexZero_mmu = (new_acc_command & (exeDcbf | exeDcbst)) | ((carDcbf | carDcbst) & ~specialOPDoneL2);



//--------------------------------------------------------------------------------------------
//
// Fill State Machine
//
//--------------------------------------------------------------------------------------------

//
always @ (fillSM or fillNeeded or carOF_dcbzCmdQual or dValidCntDoneL2 or fillFlushToDoL2)

begin
   casez ({fillSM, fillNeeded, carOF_dcbzCmdQual, dValidCntDoneL2, fillFlushToDoL2})
         
//
//
//          fillSM
//          |
//          | fillNeeded
//          | |
//          | |carOF_dcbzCmdQual
//          | ||
//          | ||dValidCntDoneL2
//          | |||
//          | |||fillFlushToDoL2
//          | ||||
//          | ||||
//          | ||||
//          v vvvv
   ////////////
   // IDLE   //
   ////////////
   10'b1?????_00??: fillSM_In[0:5] = 6'b100000;  // idle to idle no new fillNeeded
   10'b1?????_1???: fillSM_In[0:5] = 6'b010000;  // idle to pend new fillNeeded
   10'b1?????_?1??: fillSM_In[0:5] = 6'b010000;  // idle to pend new dcbzcmd
   ////////////
   // PEND   //
   ////////////
   10'b?1????_??0?: fillSM_In[0:5] = 6'b010000;  // pend to pend not done
   10'b?1????_??1?: fillSM_In[0:5] = 6'b001000;  // pend to read1 fill done
   ////////////
   // READ 1 //
   ////////////
   10'b??1???_????: fillSM_In[0:5] = 6'b000100;  // read1 to write1
   ////////////
   // WRITE 1//
   ////////////
   10'b???1??_???0: fillSM_In[0:5] = 6'b000001;  // write1 to write2 no flush needed
   10'b???1??_???1: fillSM_In[0:5] = 6'b000010;  // write1 to read2  flush needed
   ////////////
   // READ 2 //
   ////////////
   10'b????1?_????: fillSM_In[0:5] = 6'b000001;  // read2 to write2
   ////////////
   // WRITE 2//
   ////////////
   10'b?????1_0???: fillSM_In[0:5] = 6'b100000;  // write2 to idle
   10'b?????1_1?0?: fillSM_In[0:5] = 6'b010000;  // write2 to pend
   10'b?????1_1?1?: fillSM_In[0:5] = 6'b001000;  // write2 to read1

   default:      fillSM_In[0:5] = 6'bxxxxxx;



   endcase
end


//--------------------------------------------------------------------------------------------
//
// Fill Buf Gating
//
//--------------------------------------------------------------------------------------------
// Reduced   CAR_OF_dcbzCmdQual | carOF_storeQual ->  CAR_OF_fullL2 to help timing
assign fillBuf_E1 = LSA_SM | CAR_OF_fullL2;


// LSA loading store does not include CAR_OF_dcbzCmdQual because ored everywhere LSA_loadingStore is used.
// Removed anding of LSA_free with ((PLBAR_selOF & loadPLBAR_early) | CAR_OF_PLB_loadedL2) to improve timing.
// Needed to add ~carOF_dsHoldL2 to prevent stores to OCM in OF from setting valid bits
assign LSA_loadingStore = LSA_free & carOF_storeQual & ~carOF_dsHoldL2;



// The fill buffer E2's control on word of data each.
   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E20
   assign fillBuf_E2[0] = (PLB_dcuRdDAck & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[0] |
                                 ~fillValidL2[1] | ~fillValidL2[2] | ~fillValidL2[3] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b000)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b000)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E21
   assign fillBuf_E2[1] = (PLB_dcuRdDAck & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[4] |
                                 ~fillValidL2[5] | ~fillValidL2[6] | ~fillValidL2[7] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b001)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b001)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E22
   assign fillBuf_E2[2] = (PLB_dcuRdDAck & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[8] |
                                 ~fillValidL2[9] | ~fillValidL2[10] | ~fillValidL2[11] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b010)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b010)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E23
   assign fillBuf_E2[3] = (PLB_dcuRdDAck & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[12] |
                                 ~fillValidL2[13] | ~fillValidL2[14] | ~fillValidL2[15] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b011)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b011)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E24
   assign fillBuf_E2[4] = (PLB_dcuRdDAck3 & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[16] |
                                 ~fillValidL2[17] | ~fillValidL2[18] | ~fillValidL2[19] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b100)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b100)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E25
   assign fillBuf_E2[5] = (PLB_dcuRdDAck3 & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[20] |
                                 ~fillValidL2[21] | ~fillValidL2[22] | ~fillValidL2[23] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b101)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b101)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E26
   assign fillBuf_E2[6] = (PLB_dcuRdDAck3 & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[24] |
                                 ~fillValidL2[25] | ~fillValidL2[26] | ~fillValidL2[27] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b110)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b110)) |
                               carOF_dcbzCmdQual;



   // Replacing instantiation: GTECH_AO21 SGT_dcu_FB_E27
   assign fillBuf_E2[7] = (PLB_dcuRdDAck3 & (sampleCycleL2 & (dValidCntDoneL2 | ~fillValidL2[28] |
                                 ~fillValidL2[29] | ~fillValidL2[30] | ~fillValidL2[31] ))) | (storeHitFillBufPendL2 & (SAQ_L2[27:29] == 3'b111)) |
                              (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b111)) |
                               carOF_dcbzCmdQual;





//--------------------------------------------------------------------------------------------
//
// Fill Mux Selects
//
//--------------------------------------------------------------------------------------------
// 4:1 Mux/Reg
// 00 - PLB_dcuData
// 01 - FeedBack from fillBuffer
// 10 - gnd
// 11 - SAQ/SDP data

// Added the OR of fillBufMuxSel0 to help TSV and connected 10 leg to gnd.
// Also added testEn to fillBufMuxSel0 to make mux select completely slectable.

wire [0:31] fillBufMuxSel0_i;
assign fillBufMuxSel0[0:31] = fillBufMuxSel0_i[0:31];
assign fillBufMuxSel0_i[0:31] = ({32{testEn}} | fillBufSel0_pre[0:31]);
assign fillBufMuxSel1[0:31] = ({32{LSA_SM & ~dValidCntDoneL2}} & fillValidL2[0:31]) | fillBufSel0_pre[0:31];


// WORD 0 Byte 0-3
assign fillBufSel0_pre[0]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b000) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[1]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b000) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[2]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b000) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[3]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b000) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b000) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 1 Byte 0-3
assign fillBufSel0_pre[4]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b001) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[5]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b001) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[6]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b001) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[7]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b001) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b001) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 2 Byte 0-3
assign fillBufSel0_pre[8]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b010) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[9]  = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b010) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[10] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b010) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[11] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b010) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b010) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 3 Byte 0-3
assign fillBufSel0_pre[12] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b011) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[13] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b011) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[14] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b011) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[15] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b011) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b011) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 4 Byte 0-3
assign fillBufSel0_pre[16] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b100) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[17] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b100) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[18] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b100) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[19] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b100) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b100) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 5 Byte 0-3
assign fillBufSel0_pre[20] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b101) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[21] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b101) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[22] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b101) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[23] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b101) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b101) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 6 Byte 0-3
assign fillBufSel0_pre[24] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b110) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[25] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b110) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[26] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b110) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[27] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b110) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b110) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;

// WORD 7 Byte 0-3
assign fillBufSel0_pre[28] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[0]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b111) & carOF_byteEn[0]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[29] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[1]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b111) & carOF_byteEn[1]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[30] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[2]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b111) & carOF_byteEn[2]) |
                             carOF_dcbzCmdQual;
assign fillBufSel0_pre[31] = (storeHitFillBufPendL2 & ~dValidCntDoneL2 & (SAQ_L2[27:29] == 3'b111) & SAQ_byteEn[3]) |
                            (LSA_loadingStore & (CAR_OF_L2[27:29] == 3'b111) & carOF_byteEn[3]) |
                             carOF_dcbzCmdQual;


//--------------------------------------------------------------------------------------------
//
// Valid bit equations
//
//--------------------------------------------------------------------------------------------

// For word xfers that are to 64 bit slaves the byteEnables are either F0 or 0F and only one word
// returned is good.  So we need to only mark one word as valid in case the following load
// is to that word.
// The loadPLBword[0:7] is only used to set the correct valid bits

assign loadPLBword[0] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (~PLB_dcuRdWdAddr[0] & ~PLB_dcuRdWdAddr[1] & ~PLB_dcuRdWdAddr[2])) |
                             (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b000)));

assign loadPLBword[1] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (~PLB_dcuRdWdAddr[0] & ~PLB_dcuRdWdAddr[1]) &
                                (dVQ0_sizeL2 | (~dVQ0_sizeL2 & PLB_dcuRdWdAddr[2]))) |
                              (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b001)));

assign loadPLBword[2] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (~PLB_dcuRdWdAddr[0] & PLB_dcuRdWdAddr[1] & ~PLB_dcuRdWdAddr[2])) |
                             (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b010)));

assign loadPLBword[3] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (~PLB_dcuRdWdAddr[0] & PLB_dcuRdWdAddr[1]) &
                                (dVQ0_sizeL2 | (~dVQ0_sizeL2 & PLB_dcuRdWdAddr[2]))) |
                              (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b011)));

assign loadPLBword[4] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (PLB_dcuRdWdAddr[0] & ~PLB_dcuRdWdAddr[1] & ~PLB_dcuRdWdAddr[2])) |
                             (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b100)));

assign loadPLBword[5] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (PLB_dcuRdWdAddr[0] & ~PLB_dcuRdWdAddr[1]) &
                                (dVQ0_sizeL2 | (~dVQ0_sizeL2 & PLB_dcuRdWdAddr[2]))) |
                              (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b101)));

assign loadPLBword[6] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (PLB_dcuRdWdAddr[0] & PLB_dcuRdWdAddr[1] & ~PLB_dcuRdWdAddr[2])) |
                             (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b110)));

assign loadPLBword[7] = PLB_dcuRdDAck2 & sampleCycleL2 &
                             ((dVQ0_lineL2 & (PLB_dcuRdWdAddr[0] & PLB_dcuRdWdAddr[1]) &
                                (dVQ0_sizeL2 | (~dVQ0_sizeL2 & PLB_dcuRdWdAddr[2]))) |
                              (~dVQ0_lineL2 & (cmpAddr[0:2] == 3'b111)));



// Used to sel the SDQ/SDP input to the fill buffer.
// Used to set the fill buffer valid bits
// Used to set fill buffer dirty bit
// If you have carReadValid the only bypassPending is an LSA_bypassPending because OCM and OF prevent carReadValid
// Replaced ~carAborted with the equation to help timing.
//assign storeHitFillBuf = carStore & carReadValid & CAR_LSAcmp & LSA_SM & CAR_cacheable &
//                            ~(carFullL2 & ~past1stCycXltValidL2 & (MMU_dcuAbort | VCT_wbAbort)) &
//                            ~dValidCntDoneL2 & ~(LSA_loadL2 & loadNonAlloc) &
//                            ~(LSA_bypassPendingL2 & (LSA_L2[27:29]==CAR_buf[27:29]));



// This will cause all word operations to use the LSA bits to choose what word to mux the data into.  For line
// transfers the PLB_dcuRdWdAddr signal will determine where the data word goes. The possible problem case
// is a word transfer from the odd word location on a 64 bit PLB.  The data should be on bits 32:63 of the
// data bus and the fill buffers need the correct E2 and the correct valid bits needed to be set.
//
// Also needed to mux between LSA and car_OF under condition when car_OF is loading into LSA and
// data is comming home

assign cmpAddr[0:2] = dValidCntDoneL2 ? CAR_OF_L2[27:29] : LSA_L2[27:29];





assign reset_validReg = dValidCntDoneL2 & (exeSync | carDccci | carDcbi | carDcbt | storeWordL2 | setStoreWord |
                                           carDcbzCmd_i | (~LSA_cacheableL2 & (~loadWordAsLine | LSA_guardedL2)) |
                                          ~LSA_loadL2 |
                                          (LSA_cacheableL2 & (~loadNonAlloc | (loadNonAlloc & ~loadWordAsLine))) |
                                          (carOF_storeQual & ~carOF_dsHoldL2) |
                                          (carOF_loadQual & ~carOF_LSAcmp & ~carOF_dsHoldL2));


// This latch is used to indicate when a storeNC is in progress or has occured in order to
// reset the valid bits of the fill buffer.
// 4/22/99 - changed carReadValid to xltValidL2 to help timing
assign setStoreWord = ((carStore & xltValidL2 & ~CAR_cacheableBuf2 & ~LSA_cacheableL2) |
                       (SAQvalidNeedingPLBL2 & SAQ_cacheableL2)) & (LSA_SM | dValidCntDoneL2);
assign storeWord_In = (storeWordL2 | setStoreWord) & ~dValidCntDoneL2;



// Valid word 0
assign fillValid_In[0]  = (fillValidL2[0] & ~reset_validReg) | (loadPLBword[0] | fillBufMuxSel0_i[0]);

assign fillValid_In[1]  = (fillValidL2[1] & ~reset_validReg) | (loadPLBword[0] | fillBufMuxSel0_i[1]);

assign fillValid_In[2]  = (fillValidL2[2] & ~reset_validReg) | (loadPLBword[0] | fillBufMuxSel0_i[2]);

assign fillValid_In[3]  = (fillValidL2[3] & ~reset_validReg) | (loadPLBword[0] | fillBufMuxSel0_i[3]);

// Valid word 1
assign fillValid_In[4]  = (fillValidL2[4] & ~reset_validReg) | (loadPLBword[1] | fillBufMuxSel0_i[4]);

assign fillValid_In[5]  = (fillValidL2[5] & ~reset_validReg) | (loadPLBword[1] | fillBufMuxSel0_i[5]);

assign fillValid_In[6]  = (fillValidL2[6] & ~reset_validReg) | (loadPLBword[1] | fillBufMuxSel0_i[6]);

assign fillValid_In[7]  = (fillValidL2[7] & ~reset_validReg) | (loadPLBword[1] | fillBufMuxSel0_i[7]);

// Valid word 2
assign fillValid_In[8]  = (fillValidL2[8] & ~reset_validReg) | (loadPLBword[2] | fillBufMuxSel0_i[8]);

assign fillValid_In[9]  = (fillValidL2[9] & ~reset_validReg) | (loadPLBword[2] | fillBufMuxSel0_i[9]);

assign fillValid_In[10] = (fillValidL2[10] & ~reset_validReg) | (loadPLBword[2] | fillBufMuxSel0_i[10]);

assign fillValid_In[11] = (fillValidL2[11] & ~reset_validReg) | (loadPLBword[2] | fillBufMuxSel0_i[11]);

// Valid word 3
assign fillValid_In[12] = (fillValidL2[12] & ~reset_validReg) | (loadPLBword[3] | fillBufMuxSel0_i[12]);

assign fillValid_In[13] = (fillValidL2[13] & ~reset_validReg) | (loadPLBword[3] | fillBufMuxSel0_i[13]);

assign fillValid_In[14] = (fillValidL2[14] & ~reset_validReg) | (loadPLBword[3] | fillBufMuxSel0_i[14]);

assign fillValid_In[15] = (fillValidL2[15] & ~reset_validReg) | (loadPLBword[3] | fillBufMuxSel0_i[15]);

// Valid word 4
assign fillValid_In[16] = (fillValidL2[16] & ~reset_validReg) | (loadPLBword[4] | fillBufMuxSel0_i[16]);

assign fillValid_In[17] = (fillValidL2[17] & ~reset_validReg) | (loadPLBword[4] | fillBufMuxSel0_i[17]);

assign fillValid_In[18] = (fillValidL2[18] & ~reset_validReg) | (loadPLBword[4] | fillBufMuxSel0_i[18]);

assign fillValid_In[19] = (fillValidL2[19] & ~reset_validReg) | (loadPLBword[4] | fillBufMuxSel0_i[19]);

// Valid word 5
assign fillValid_In[20] = (fillValidL2[20] & ~reset_validReg) | (loadPLBword[5] | fillBufMuxSel0_i[20]);

assign fillValid_In[21] = (fillValidL2[21] & ~reset_validReg) | (loadPLBword[5] | fillBufMuxSel0_i[21]);

assign fillValid_In[22] = (fillValidL2[22] & ~reset_validReg) | (loadPLBword[5] | fillBufMuxSel0_i[22]);

assign fillValid_In[23] = (fillValidL2[23] & ~reset_validReg) | (loadPLBword[5] | fillBufMuxSel0_i[23]);

// Valid word 6
assign fillValid_In[24] = (fillValidL2[24] & ~reset_validReg) | (loadPLBword[6] | fillBufMuxSel0_i[24]);

assign fillValid_In[25] = (fillValidL2[25] & ~reset_validReg) | (loadPLBword[6] | fillBufMuxSel0_i[25]);

assign fillValid_In[26] = (fillValidL2[26] & ~reset_validReg) | (loadPLBword[6] | fillBufMuxSel0_i[26]);

assign fillValid_In[27] = (fillValidL2[27] & ~reset_validReg) | (loadPLBword[6] | fillBufMuxSel0_i[27]);

// Valid word 7
assign fillValid_In[28] = (fillValidL2[28] & ~reset_validReg) | (loadPLBword[7] | fillBufMuxSel0_i[28]);

assign fillValid_In[29] = (fillValidL2[29] & ~reset_validReg) | (loadPLBword[7] | fillBufMuxSel0_i[29]);

assign fillValid_In[30] = (fillValidL2[30] & ~reset_validReg) | (loadPLBword[7] | fillBufMuxSel0_i[30]);

assign fillValid_In[31] = (fillValidL2[31] & ~reset_validReg) | (loadPLBword[7] | fillBufMuxSel0_i[31]);



//
// LSA Target Valid in Fill Buffer
//
always @ (LSA_L2 or fillValidL2)
begin
   casez ({LSA_L2[27:29]})
      3'b000: LSA_targetValid = fillValidL2[0]  & fillValidL2[1]  & fillValidL2[2]  & fillValidL2[3];
      3'b001: LSA_targetValid = fillValidL2[4]  & fillValidL2[5]  & fillValidL2[6]  & fillValidL2[7];
      3'b010: LSA_targetValid = fillValidL2[8]  & fillValidL2[9]  & fillValidL2[10] & fillValidL2[11];
      3'b011: LSA_targetValid = fillValidL2[12] & fillValidL2[13] & fillValidL2[14] & fillValidL2[15];
      3'b100: LSA_targetValid = fillValidL2[16] & fillValidL2[17] & fillValidL2[18] & fillValidL2[19];
      3'b101: LSA_targetValid = fillValidL2[20] & fillValidL2[21] & fillValidL2[22] & fillValidL2[23];
      3'b110: LSA_targetValid = fillValidL2[24] & fillValidL2[25] & fillValidL2[26] & fillValidL2[27];
      3'b111: LSA_targetValid = fillValidL2[28] & fillValidL2[29] & fillValidL2[30] & fillValidL2[31];
      default: LSA_targetValid = 1'bx;
   endcase
end



//
// CAR Target Valid in Fill Buffer
// Can bypass from CAR of CAR_OF
//
always @ (carMux or fillValidL2)
begin
   casez ({carMux[27:29]})
      3'b000: carMuxTargetValid = fillValidL2[0]  & fillValidL2[1]  & fillValidL2[2]  & fillValidL2[3];
      3'b001: carMuxTargetValid = fillValidL2[4]  & fillValidL2[5]  & fillValidL2[6]  & fillValidL2[7];
      3'b010: carMuxTargetValid = fillValidL2[8]  & fillValidL2[9]  & fillValidL2[10] & fillValidL2[11];
      3'b011: carMuxTargetValid = fillValidL2[12] & fillValidL2[13] & fillValidL2[14] & fillValidL2[15];
      3'b100: carMuxTargetValid = fillValidL2[16] & fillValidL2[17] & fillValidL2[18] & fillValidL2[19];
      3'b101: carMuxTargetValid = fillValidL2[20] & fillValidL2[21] & fillValidL2[22] & fillValidL2[23];
      3'b110: carMuxTargetValid = fillValidL2[24] & fillValidL2[25] & fillValidL2[26] & fillValidL2[27];
      3'b111: carMuxTargetValid = fillValidL2[28] & fillValidL2[29] & fillValidL2[30] & fillValidL2[31];
      default: carMuxTargetValid = 1'bx;
   endcase
end




//--------------------------------------------------------------------------------------------
//
// FDR and Hold signals
//
//--------------------------------------------------------------------------------------------
// FDR output muxing
// 00 word 2 and word 3
// 01 word 4 and word 5
// 10 word 6 and word 7
// 11 word 0 and word 1
assign FDR_outMuxSel[0] = (wrAckCntDoneL2 & (oneFPL2 | twoFPL2)) |
                          (~wrAckQ_fullL2 & ~(DCU_requestDupL2 & ~DCU_plbRNW_dupL2 & DCU_tranSize)) |
                          (wrAckCntL2[0] & wrAckQ_lineL2);
assign FDR_outMuxSel[1] = (wrAckCntDoneL2 & (oneFPL2 | twoFPL2)) |
                          (~wrAckQ_fullL2 & ~(DCU_requestDupL2 & ~DCU_plbRNW_dupL2 & DCU_tranSize)) |
                          (wrAckCntL2[1] & wrAckQ_lineL2);

// Flush Almost Done
// added wrAckQ_fullL2 to flushAlmostDone for Issue213
// added flushDone to flushAlmostDone for Issue213 to get flushAlmostDone to come on for both the second last and
//   last cycle of flush
wire flushAlmostDone_i;
wire flushDone_i;
assign flushDone = flushDone_i;
assign flushAlmostDone = flushAlmostDone_i;
assign flushAlmostDone_i = (wrAckQ_fullL2 & wrAckQ_lineL2 & (wrAckCntDoneL2 | (wrAckCntL2[0] & wrAckCntL2[1]))) |
                         flushDone_i;




// FDR HI SIGNALS
//------------------------------------------------------------------
// Also used for the FAR E1
assign FDR_hi_E1 = fillRead1_state2 | carSpecialOpL2 | twoFPL2;


// Removed valid/dirty/LRU from second term to help timing
assign FDR_hi_E2 = ((carDcbf | carDcbst) & carReadValid & ~specialOPDoneL2 &
                      (flushIdle_state_i | (oneFPL2 & flushAlmostDone_i))) |

                   (fillRead1_state & ~dcbzFillHitL2 & (flushIdle_state_i | (oneFPL2 & flushAlmostDone_i))) |

                   (oneFP2twoFP_dcbf & flushAlmostDone_i) |

                   (twoFPL2 & flushAlmostDone_i);


// FDR_hiMuxSel is Bit 0 of two bit mux select.
// FDR_holdMuxSel is bit 1
// 4:1 mux
// 00 - B side
// 01 - A side
// 1? - Hold
// Look at hold reg if oneFP2twoFP caused by dcbf/dcbst.  If oneFP2twoFP caused by fill completing then
// hold reg will not be loaded if flushAlmostDone.
assign FDR_hiMuxSel   = (oneFP2twoFP_dcbf | twoFPL2) & flushAlmostDone_i;


// Mux/Reg select for FDR hi and Hold Reg
// 0 = B side data
// 1 = A side data
   // Replacing instantiation: GTECH_AO21 SGT_FDR_holdMux
   assign FDR_holdMuxSel = (hit_a & (carDcbf | carDcbst)) | fillRead1_state & ~LRU;





// FDR LO SIGNALS
//------------------------------------------------------------------
assign FDR_lo_E1 = carDcbf | carDcbst | fillRead2_state | twoFPL2;


assign FDR_lo_E2 = ((carDcbf | carDcbst) & specialOPDoneL2 & (flushIdle_state_i | (oneFPL2 & flushAlmostDone_i))) |

                   (fillRead2_state & oneFPL2) |

                   (twoFPL2 & flushAlmostDone_i);


// When this latch is set, twoFPL2 was caused by a dcbf or dcbst
// When this latch is NOT set, twoFPL2 was caused by a line fill.
assign carTwoFP_In = (carTwoFPL2 & ~flushDone_i) |
                     ((carDcbf | carDcbst) & specialOPDoneL2 & oneFPL2 & ~flushDone_i &
                                ((carOF_hitAL2 & dirtyA) | (carOF_hitBL2 & dirtyB)));

// FDR lo mux
// 0 - B
// 1 - A
// Using the latched LRU bit not the LRU mux because the LRU will not change until another carReadValid
// of when the fill SM is in the fillRead1_state
assign FDR_loMuxSel = ((carDcbf | carDcbst) & carOF_hitAL2 & (flushIdle_state_i | (oneFPL2 & flushAlmostDone_i))) |

                      (fillRead2_state & oneFPL2 & ~LRU) |

                      (twoFPL2 & ((carTwoFPL2 & carOF_hitAL2) | (~carTwoFPL2 & ~LRU)));





// HOLD SIGNALS
//------------------------------------------------------------------
// The flushHold E1 is shared with the FDR_hi_E1
// If this signal becomes a timing problem we can remove the LRU/Dirty/Valid bits because they are
// only here for power.
// Removed ~flushAlmostDone for bug fix.  May load more often then needed sometimes.
// 4/22/99 removing LRU/Dirty/Valid to help timing
//assign flushHold_E2 = ((carDcbf | carDcbst) & carReadValid & ~specialOPDoneL2 & oneFPL2) |
//                      (fillRead1_state & oneFPL2 & ((~LRU & validA & dirtyA) | (LRU & validB & dirtyB)));
assign flushHold_E2 = ((carDcbf | carDcbst) & carReadValid & ~specialOPDoneL2 & oneFPL2) |
                      (fillRead1_state & oneFPL2);




// 0 - Data from FDR
// 1 - Data from SDP
assign SDP_FDR_muxSel = PLBAR_selSAQ_i & loadPLBAR_early;


//--------------------------------------------------------------------------------------------
//
// Flush Status and Flush signals
//
//--------------------------------------------------------------------------------------------
// FAR_fullL2 --- 0 = FAR empty
//            --- 1 = FAR waiting for PLB_AR

assign FAR_full_In   = set_flush_hitLatched |
                       FAR_loadPendingL2 |
                       (FAR_fullL2 & ~(PLBAR_selFAR_i & loadPLBAR_early));


// Using carOF_hitAL2 and carOF_hitBL2 because it will be latched with carReadValid
assign set_flush_hitLatched = ((carDcbf | carDcbst) & specialOPDoneL2 &
                                ((carOF_hitAL2 & dirtyA) | (carOF_hitBL2 & dirtyB))) |
                              (fillRead1_state & ((~LRU & validA & dirtyA) | (LRU & validB & dirtyB)) &
                                ~dcbzFillHitL2);

// This is a copy of set_flush_hitLatched with valid/dirty/LRU removed to help timing
assign set_flush_hitLatched_fast = ((carDcbf | carDcbst) & specialOPDoneL2 &
                                   ((carOF_hitAL2 & dirtyA) | (carOF_hitBL2 & dirtyB))) |
                                   (fillRead1_state & ~dcbzFillHitL2);




// 0 - A-side tag
// 1 - B-side tag
assign tagOutMuxSelFAR = (~twoFPL2 & set_flush_hitBLatched) |
                         (twoFPL2 & ((carTwoFPL2 & carOF_hitBL2) | (~carTwoFPL2 & LRU)));


assign set_flush_hitBLatched = ((carDcbf | carDcbst) & specialOPDoneL2 & carOF_hitBL2 & dirtyB) |
                               (fillRead1_state & LRU & validB & dirtyB & ~dcbzFillHitL2);


// Flush waiting to Load FAR
// Made reset dominant.
assign FAR_loadPending_In = (FAR_loadPendingL2 | (FAR_fullL2 & set_flush_hitLatched)) &
                            ~(PLBAR_selFAR_i & loadPLBAR_early);


// Uses the FDR_hi_E1
assign FAR_E2 = (set_flush_hitLatched_fast & ~FAR_fullL2) |
                (FAR_loadPendingL2 & PLBAR_selFAR_i & loadPLBAR_early) |
                (FAR_fullL2 & set_flush_hitLatched_fast & PLBAR_selFAR_i & loadPLBAR_early);


//--------------------------------------------------------------------------------------------
//
// Flush State Machine
//
//--------------------------------------------------------------------------------------------

assign flushDone_i        = wrAckQ_lineL2 & wrAckCntDoneL2;
assign flushIdle_state_i  = ~oneFPL2 & ~twoFPL2;
assign oneFP2twoFP_dcbf = oneFPL2 & ~flushDone_i &
                            ((carDcbf | carDcbst) & specialOPDoneL2 &
                            ((carOF_hitAL2 & dirtyA) | (carOF_hitBL2 & dirtyB)));


assign oneFP_In = (oneFPL2 & ~set_flush_hitLatched & ~flushDone_i) |   // Hold oneFP
                  (~oneFPL2 & set_flush_hitLatched) |                // Idle and setting new flush
                  (set_flush_hitLatched & flushDone_i) |               // oneFP done and setting another
                  (twoFPL2 & flushDone_i);                             // twoFP and going to oneFP


assign twoFP_In = (twoFPL2 & ~flushDone_i) |                           // twoFP -> twoFP
                  (oneFPL2 & set_flush_hitLatched & ~flushDone_i);     // oneFP -> twoFP




//--------------------------------------------------------------------------------------------
//
// dValid Counter
//
//--------------------------------------------------------------------------------------------
// E1 = SC  No E2
assign dValidCnt1_In[0:2] = dValidCntL2[0:2] + 3'b001;  // Increment by 1
assign dValidCnt2_In[0:2] = dValidCntL2[0:2] + 3'b010;  // Increment by 2


// 2:1 Mux
// 0 = Feedback
// 1 = setting 1's or 0's
assign setDValidCntIdle   = ((~dVQ0_fullL2[1] | (dVQ1_fullL2 & dValidCntDoneL2)) &
                                DCU_requestDupL2 & DCU_plbRNW_dupL2 & ~DCU_tranSize) | resetL2;


// 4:1 Mux
// 00 - Inc 1
// 01 - Inc 2
// 1X - Set 7's or 0's
assign dValidCntSel[0] = ((dValidCntL2[0:2] == 3'b111) | (dValidCntL2[0] & dValidCntL2[1] & dVQ0_sizeL2)) &
                               ((dVQ1_fullL2 & ~dVQ1_lineL2) |
                               (~dVQ1_fullL2 & DCU_requestDupL2 & DCU_plbRNW_dupL2 & ~DCU_tranSize));
assign dValidCntSel[1] = dVQ0_fullL2[1] & dVQ0_lineL2 & dVQ0_sizeL2;



// No E1 or E2
assign dValidCntDone_In = ((dValidCntDoneL2 & ~reset_validReg) | carOF_dcbzCmdQual |
                            (PLB_dcuRdDAck3 & sampleCycleL2 &
                            ((dValidCntL2[0:2] == 3'b111) | (dValidCntL2[0] & dValidCntL2[1] & dVQ0_sizeL2)))) &
                           ~resetL2;


//--------------------------------------------------------------------------------------------
//
// wrAck Counter
//
//--------------------------------------------------------------------------------------------
assign wrAckCnt1_In = wrAckCntL2[0:2] + 3'b001;
assign wrAckCnt2_In = wrAckCntL2[0:2] + 3'b010;


// 4:1 Mux/Reg
// 0x - wrAckCnt_In0X
// 10 - wrAck/sSize = 32 bit Choose 10 mux
// 11 - wrAck/sSize = 64 bit Choose 11 mux
assign wrAckCnt_In0X[0:2] = ({3{~resetL2 & ~(PLBAR_selSAQ_i & loadPLBAR_early)}} & wrAckCntL2[0:2]) |
                             {3{~resetL2 & PLBAR_selSAQ_i & loadPLBAR_early}};

// 2 - 2:1 Muxs
// 0 - Inc. by 1
// 1 - Inc. by 2
// Mux out feeds the 4:1 mux above
// Select[0] = wrAck and Select[1] = sSize
// WrAck = 1 and Ssize = 0 (32-bit)
// Included ~wrAckCntL2[2] term to insure that 64-bit store words only inc by 1
// wrAck cnt set to 7's as entering request for store words.
// When wrAckQ is empty and getting wrAck need to look at cnt to determin if doing a store or a flush
// If a flush the cnt = 0 and if a store word the cnt = 7
assign wrAckSelInc2_10 = wrAckQ_fullL2 & wrAckQ_sizeL2 & ~wrAckCntL2[2];

// WrAck = 1 and Ssize = 1 (64-bit)
assign wrAckSelInc2_11 = (wrAckQ_fullL2  & wrAckQ_sizeL2 & ~wrAckCntL2[2]) |
                         (~wrAckQ_fullL2 & ~wrAckCntL2[2]);


// This nand feeds an inverting latch
// wrAckCntDoneL2 and wrAckQ_fullL2 are mutually exclusive.  When the wrAckQfullL2 resets (equals 0) the
// wrAckCntDoneL2 will be active (equal 1).
   // Replacing instantiation: GTECH_NAND2 SGT_wrAckCntDone
   assign wrAckCntDone_In = ~( PLB_dcuWrDAckBuf & ((sampleCycleL2 & ((wrAckCntL2[0:2] == 3'b111) |
                                  (wrAckCntL2[0] & wrAckCntL2[1] & wrAckQ_sizeL2)) & ~resetL2)) );



//--------------------------------------------------------------------------------------------
//
// Bypass and two load pending
//
//--------------------------------------------------------------------------------------------
// Used in the creation of DCU_DA and elsewhere
assign bypassPendingData   = (LSA_bypassPendingL2 & LSA_targetValid) |
                             (DCUbypassPendingL2 & carMuxTargetValid & carOF_LSAcmp &
                                carOF_loadQual);




// DCU Bypass Pending Latch (No OCM)
// non OCM load pending - includes LSA_bypasspend and car_of bypass pending
// used to keep OCM data from being done when dcu has a load pending
// 2:1 Mux/Reg
// Select is miss
// Leg 0 is DCUbypassPending_In0
// Leg 1 is DCUbypassPending_In1
assign DCUbypassPending_In0 = DCUbypassPendingL2 & ~bypassPendingData & ~resetL2;

assign DCUbypassPending_In1 = ((carLoad  & carReadValid & ~carAborted &
                                 ~OCM_dsHold_noWait & ~OCM_dsComplete_noWaitXltV &
                                 ~(carMuxTargetValid & CAR_LSAcmp)) | (DCUbypassPendingL2 & ~bypassPendingData)) &
                              ~resetL2;


// LSA bypass Pending
// Used to insure that the LSA only gets bypassed once
// A miss or a non-cacheable WILL have to go into the LSA unless bypassed from the fill buffer
// Will never set this latch if the addresses are the same
assign set_LSAbypassPending   = LSA_free & carOF_loadQual & ~(carOF_LSAcmp & LSA_SM) & ~carOF_dsHoldL2;
assign LSA_bypassPending_In   = (LSA_bypassPendingL2 & ~LSA_targetValid) | set_LSAbypassPending;



// Two Load Pending Latch
// In DCU or OCM any two load pending
// Don't deliver carLoad data before delivering LSA load data or CAR_OF load data.  Load must complete in order.
// (a) Setting case: Load in CAR not returning data followed by a new load that will move to the CAR
// (b) Setting case: Load in the LSA that is no currently returning data with nothing  or a store in the
//     CAR followed by a new load that will move to the CAR
// (c) Set and holding: Load in the LSA that is not returning data and load in the CAR
// (d) Set and holding: Load in the CAR_OF that is not returning data and Load in the CAR
// (e) Setting case: Load in CAR_OF not returning data followed by a new load that will move to the CAR

// Rule: cannot be setting and resetting two load pending in the same cycle.
// IF THIS EQUATION CHANGES THE READ STATE MACHINE EQUATION MUST CHANGE.

//assign twoLoadPending_In =
//                            // (a)
//                            (carLoad & carReadValid & ~carAborted & exeLoad & dcu_CA_exeLdSt & ~new_cmd_aborted &
//                                ~hit_a_buf1 & ~hit_b_buf1 & ~OCM_dsComplete_noWaitXltV &
//                                ~(CAR_LSAcmp & carMuxTargetValid)) |
//
//                            // (b)
//                            (LSA_bypassPendingL2 & ~LSA_targetValid & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt) |
//
//                            // (c)
//                            (LSA_bypassPendingL2 & ~LSA_targetValid & carLoad & ~carAborted) |
//
//                            // (d)
//                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) & ~OCM_dsComplete_noWait &
//                                 carLoad & ~carAborted) |
//
//                            // (e)
//                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) &
//                            ~OCM_dsComplete_noWait & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt);

// 2:1 Mux with mux select miss = ~hit_a_buf1 & ~hit_b_buf1 and inputs:
// 0 = twoLoadPending_0_In
// 1 = twoLoadPending_1_In
//
assign twoLoadPending_0_In_i =
                            // (b)
                            (LSA_bypassPendingL2 & ~LSA_targetValid & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt) |

                            // (c)
                            (LSA_bypassPendingL2 & ~LSA_targetValid & carLoad & ~carAborted) |

                            // (d)
                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) & ~OCM_dsComplete_noWait &
                                 carLoad & ~carAborted) |

                            // (e)
                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) &
                            ~OCM_dsComplete_noWait & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt);


assign twoLoadPending_1_In_i =
                            (carLoad & carReadValid & ~carAborted & exeLoad & dcu_CA_exeLdSt & ~new_cmd_aborted &
                                ~OCM_dsComplete_noWaitXltV & ~(CAR_LSAcmp & carMuxTargetValid)) |

                            // (b)
                            (LSA_bypassPendingL2 & ~LSA_targetValid & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt) |

                            // (c)
                            (LSA_bypassPendingL2 & ~LSA_targetValid & carLoad & ~carAborted) |

                            // (d)
                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) & ~OCM_dsComplete_noWait &
                                 carLoad & ~carAborted) |

                            // (e)
                            (carOF_loadQual & ~(carOF_LSAcmp & carMuxTargetValid) &
                            ~OCM_dsComplete_noWait & exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt);


//--------------------------------------------------------------------------------------------
//
// Store Hit Pend
//
//--------------------------------------------------------------------------------------------
assign storeHitPendAB = storeHitPendL2[0] | storeHitPendL2[1];
assign storeHitPendABDup = storeHitPendDupL2[0] | storeHitPendDupL2[1];

// 2:1 Mux/Reg with select = hit_a
// Leg 0 = storeHitPend_In0[0]
// Leg 1 = set_storeHitPend1[0]
assign set_storeHitPend1[0] = (storeHitPendL2[0] & ~reset_storeHitPend) |
                                 (carStore & ~carAborted & carReadValid & ((dcu_CA_exeLdSt & exeLoad) |
                                    fillPend2Read1) & ~resetL2);


// 2:1 Mux/Reg with select = hit_b
// Leg 0 = storeHitPend_In0[1]
// Leg 1 = set_storeHitPend1[1]
assign set_storeHitPend1[1] = (storeHitPendL2[1] & ~reset_storeHitPend) |
                                 (carStore & ~carAborted & carReadValid & ((dcu_CA_exeLdSt & exeLoad) |
                                    fillPend2Read1) & ~resetL2);



// The last term is used to stop the storeHitPend from completing if command in the CAR is not done
// unless there are twoFP because 2FP stops all reads of the array.
assign reset_storeHitPend = (~(exeLoad & dcu_CA_exeLdSt) & ~fillUsingArray_i &
                             ~(carFullL2 & ~carDone & ~(OCM_dsComplete_noWaitXltV & ~carOF_dsHoldQual)  & ~twoFPL2)) |
                                fillNearEnd | resetL2;


// Set and reset mutually exclusive
assign storeHitPend_In0[0] = storeHitPendL2[0] & ~reset_storeHitPend;
assign storeHitPend_In0[1] = storeHitPendL2[1] & ~reset_storeHitPend;


assign fillNearEnd = dValidCntL2[0] & dValidCntL2[1] & dVQ0_lineL2 & (dVQ0_sizeL2 | dValidCntL2[2]);


// Special case is a store hit in fill buffer but to same word waiting to be bypassed.
// The store will wait in the SDP until the fill completes and then move the store data into the WB as
// the FB is moving to the WB.
// Removed the LSA_cacheableL2 or (loadNonAlloc & LSA_loadL2) and allowed to be set for load NC as line
// Also modifed reset to reset under those cases.
assign set_specialCase = carStore & ~carAborted & carReadValid & CAR_LSAcmp & (CAR_buf[27:29] == LSA_L2[27:29]) &
                         LSA_bypassPendingL2 & ~dValidCntDoneL2;

assign reset_specialCase = fillRead1_state | (dValidCntDoneL2 & (~LSA_cacheableL2 | (loadNonAlloc & LSA_loadL2)));
assign specialCase_In = (specialCaseL2 & ~reset_specialCase) | set_specialCase;



// This latch is used in DCU_CA to allow a store hit to complete when followed by a special OP
// It does not need hit because if it was a miss, CAR_OF_fullL2 would keep CA off.
// It will be on for only one cycle and does not need feedback or a reset equation.
assign storeWriting_In = carStore & carReadValid;


//--------------------------------------------------------------------------------------------
//
// OCM Signals
//
//--------------------------------------------------------------------------------------------
assign ocmAbort    =  MMU_dcuAbort | VCT_wbAbort;
assign ocmLoadReq  = ~MMU_wbHold & dcu_CA_exeLdSt & exeLoad;
assign ocmStoreReq = ~MMU_wbHold & dcu_CA_exeLdSt & exeStore;


// Tells the OCM to hld it's load data because the CPU is waiting for a prior non-OCM load to return data.
// 2:1 Mux/Reg with select of miss
// 0 = DCU_ocmWait_In0
// 1 = DCU_ocmWait_In1
assign DCU_ocmWait_In0 = (DCU_ocmWait & ~carAborted & ~(bypassPendingData | resetL2)) |
                         (exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt & ~MMU_wbHold &
                           DCUbypassPendingL2 & ~bypassPendingData);

assign DCU_ocmWait_In1 = (DCU_ocmWait & ~carAborted & ~(bypassPendingData | resetL2)) |
                         ((exeLoad & ~new_cmd_aborted & dcu_CA_exeLdSt & ~MMU_wbHold) &
                         ((DCUbypassPendingL2 & ~bypassPendingData) |
                          (carLoad & carReadValid & ~OCM_dsHold_noWait & ~OCM_dsComplete_noWaitXltV &
                             ~(carMuxTargetValid & CAR_LSAcmp))));


// Qualify the OCM_hold and OCM_complete with the fact that the DCU is not holding the OCM.
assign OCM_dsHold_noWait         = OCM_dsHold & ~DCU_ocmWait;
assign OCM_dsComplete_noWait     = OCM_dsComplete & ~DCU_ocmWait;
assign OCM_dsComplete_noWaitXltV = OCM_dsComplete & ~DCU_ocmWait & xltValidL2;


// Steers the correct data to the OCM for stores
assign SDQ_SDP_OCM_sel = carOF_storeQual & carOF_dsHoldL2;


// Tells the PCL when to look at the complete signals from the OCM for loads.
//Issue 202 fix
//assign DCU_pclOcmLdPendNoWait =  ~DCU_ocmWait & ((carOF_loadQual & carOF_dsHoldL2 ) |
//                                                 (carLoad & ~carOF_dsHoldQual));
assign DCU_pclOcmLdPendNoWait =  ~DCU_ocmWait & ((carOF_loadQual & carOF_dsHoldL2 ) |
                                                 (carLoad & ~carOF_dsHoldQual & xltValidL2));

endmodule
