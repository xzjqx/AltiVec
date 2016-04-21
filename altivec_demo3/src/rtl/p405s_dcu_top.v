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
// PGM  09/12/01   1878   Wire BIST outputs out to Core PO's
// RLG  07/16/02   2274   Adding sampleCycleAlt for the Byron chip guys

module p405s_dcu_top( CAR_mmuAttr_E1, 
                      CAR_mmuAttr_E2, 
                      DCU_CA, 
                      DCU_DA, 
                      DCU_SCL2,
                      DCU_SDQ_mod_NEG, 
                      DCU_apuWbByteEn, 
                      DCU_carByteEn,
                      DCU_data_NEG, 
                      DCU_diagBus, 
                      DCU_firstCycCarStXltV,
                      DCU_icuSize, 
                      DCU_ocmAbort, 
                      DCU_ocmData, 
                      DCU_ocmLoadReq,
                      DCU_ocmStoreReq, 
                      DCU_ocmWait, 
                      DCU_pclOcmLdPendNoWait, 
                      DCU_plbABus, 
                      DCU_plbAbort,
                      DCU_plbCacheable, 
                      DCU_plbDBus, 
                      DCU_plbDTags, 
                      DCU_plbGuarded, 
                      DCU_plbPriority,
                      DCU_plbRNW, 
                      DCU_plbRequest, 
                      DCU_plbTranSize, 
                      DCU_plbU0Attr, 
                      DCU_plbWriteThru,
                      DCU_sleepReq, 
                      CAR_U0Attr, 
                      CAR_cacheable,
                      CAR_endian, 
                      CAR_guarded, 
                      CAR_writethru, 
                      CB, 
                      EXE_dcuData, 
                      ICU_dcuCCR0_L2,
                      ICU_syncAfterReset,
                      MMU_dcuShadowAbort,
                      MMU_dcuUTLBAbort, 
                      MMU_dcuXltValid, 
                      MMU_diagOut, 
                      MMU_dsRA, 
                      MMU_wbHold,
                      OCM_dsComplete, 
                      OCM_dsHold, 
                      PCL_dcuByteEn, 
                      PCL_dcuOp, 
                      PCL_dcuOp_early,
                      PCL_stSteerCntl, 
                      PLB_dcuAddrAck, 
                      PLB_dcuBusy, 
                      PLB_dcuRdDAck, 
                      PLB_dcuRdDBus,
                      PLB_dcuRdWdAddr, 
                      PLB_dcuSsize, 
                      PLB_dcuWrDAck, 
                      PLB_sampleCycle, 
                      VCT_exeAbort,
                      VCT_wbAbort, 
                      resetCore, 
                      testEn, 
                      DCU_parityError, 
                      DCU_FlushParityError,  
                      ICU_CCR1DCTE, 
                      ICU_CCR1DCDE,  
                      PLB_sampleCycleAlt, 
                      CPM_c405SyncBypass, 
                      dcu_bist_debug_si,
                      dcu_bist_debug_so,
                      dcu_bist_debug_en,
                      dcu_bist_mode_reg_in,
                      dcu_bist_mode_reg_out,
                      dcu_bist_parallel_dr,
                      dcu_bist_mode_reg_si,
                      dcu_bist_mode_reg_so,
                      dcu_bist_shift_dr,
                      dcu_bist_mbrun,
                      resetMemBist
                      );


//--------- start ---------------
// rgoldiez - added the DCU_parityError output signal for tag/data parity errors
//            added the DCU_FlushParityError output signal for castout/flush errors

output  CAR_mmuAttr_E1;
output  CAR_mmuAttr_E2;
output  DCU_CA;
output  DCU_DA;
output  DCU_SCL2;  
output  DCU_firstCycCarStXltV;
output  DCU_ocmAbort;
output  DCU_ocmLoadReq;
output  DCU_ocmStoreReq;
output  DCU_ocmWait;
output  DCU_pclOcmLdPendNoWait;
output  DCU_plbAbort;
output  DCU_plbCacheable;
output  DCU_plbGuarded;
output  DCU_plbPriority;
output  DCU_plbRNW;
output  DCU_plbRequest;
output  DCU_plbTranSize;
output  DCU_plbU0Attr;
output  DCU_plbWriteThru;
output  DCU_sleepReq;
output  DCU_parityError;
output  DCU_FlushParityError;

// hardware parity injection signal - tag and data, respectively
input  ICU_CCR1DCTE;
input  ICU_CCR1DCDE;


//--------- end -----------------

// new cu11 test requirements

input PLB_sampleCycleAlt;
input CPM_c405SyncBypass;

input  CAR_U0Attr;
input  CAR_cacheable;
input  CAR_endian;
input  CAR_guarded;
input  CAR_writethru;
input  ICU_syncAfterReset;
input  MMU_dcuShadowAbort;
input  MMU_dcuUTLBAbort;
input  MMU_dcuXltValid;
input  MMU_wbHold;
input  OCM_dsComplete;
input  OCM_dsHold;
input  PLB_dcuAddrAck;
input  PLB_dcuBusy;
input  PLB_dcuRdDAck;
input  PLB_dcuSsize;
input  PLB_dcuWrDAck;
input  PLB_sampleCycle;
input  VCT_exeAbort;
input  VCT_wbAbort;
input  resetCore;
input  testEn;

//--------- start ---------------
// rgoldiez - added these ICU BIST signals
// pmcilmoyle - added the BIST_sysPF output
//--------- end -----------------

output [0:31]  DCU_ocmData;
output [0:31]  DCU_plbABus;
output [0:7]  DCU_plbDTags;
output [0:31]  DCU_data_NEG;
output [0:63]  DCU_plbDBus;
output [0:3]  DCU_apuWbByteEn;
output [0:31]  DCU_SDQ_mod_NEG;
output [0:2]  DCU_icuSize;
output [0:20]  DCU_diagBus;
output [0:3]  DCU_carByteEn;


input [0:2]  PCL_dcuOp_early;
input CB;
input [0:63]  PLB_dcuRdDBus;
input [0:11]  ICU_dcuCCR0_L2;
input [0:3]  PCL_dcuByteEn;
input [0:29]  MMU_dsRA;
input [0:2]  PLB_dcuRdWdAddr;
input [0:31]  EXE_dcuData;
input [0:11]  PCL_dcuOp;
input [0:2]  MMU_diagOut;
input [0:9]  PCL_stSteerCntl;

input        resetMemBist;  // sync reset for dcu mbist

// BIST IO

input         dcu_bist_mbrun;
input  [3:0]  dcu_bist_debug_si;
input  [3:0]  dcu_bist_debug_en;
output [3:0]  dcu_bist_debug_so;

input   dcu_bist_shift_dr;
input   dcu_bist_mode_reg_si;
output  dcu_bist_mode_reg_so;

input          dcu_bist_parallel_dr;
input  [18:0]  dcu_bist_mode_reg_in;
output [18:0]  dcu_bist_mode_reg_out;


// Buses in the design

wire  [0:3]  bypassFillSDP_sel;
wire  [0:1]  dataIndexMuxSel;
wire  [0:31]  fillBufMuxSel0;
wire  [0:2]  bypassMuxSel;
wire  [0:1]  FDR_outMuxSel;
wire  [0:3]  writeBufHi_E2;
wire  [0:7]  fillBuf_E2;
wire  [0:15]  byteWriteData;
wire  [27:29]  CAR_OF_L2;
wire  [27:29]  SAQ_L2;
wire  [27:29]  LSA_L2;
wire  [0:3]  PLBDR_E2;
wire  [0:31]  fillBufMuxSel1;
//wire  [1:4]  CB_buf;
wire  [0:31]  writeBufMuxSelBit1;
wire  [0:3]  PLBDR_hiMuxSel;
wire  [27:29]  CAR_L2_buf2;
wire  [27:29]  CAR_L2_buf1;

wire CAR_OF_E1, CAR_OF_E2,FAR_E2, FDR_hiMuxSel, FDR_hi_E1, FDR_hi_E2;
wire FDR_holdMuxSel, FDR_loMuxSel, FDR_lo_E1, FDR_lo_E2, LSA_E1;
wire LSA_E2, PLBAR_E1, PLBAR_E2, PLBAR_selFAR, PLBAR_selSAQ, SAQ_E1;
wire SAQ_E2, SDP_FDR_muxSel, SDQ_E1, SDQ_E2, SDQ_SDP_OCM_sel, SDQ_SDP_mux;
wire bypassPendOrDcRead, byteWrite_E1, cacheableSpecialOp, carStore, dRegMuxSelBit1Byte0;
wire dRegMuxSelBit1Byte1, dRegMuxSelBit1Byte2, dRegMuxSelBit1Byte3, dataIndexLSA_dupSel;
wire dataIndexMuxSel2, dataIndex_E1, dataIndex_E2, dataReadNotWrite_In, dataReadWriteCycle_In;
wire dirtyLRU_readIndexSel, dirtyLRU_readIndex_E1, dirtyLRU_readIndex_E2, dirtyLRU_writeIndex_E1;
wire fillBuf_E1, fillUsingArray, flushHold_E2, forceDataIndexZero_mmu, loadReadFBvalid;
wire newDirty, newLRU, newU0AttrIn, newValidIn, readLRUDirty, sampleCycleL2, tagIndexDup_E1;
wire tagIndexDup_E2, tagIndexSel, tagIndex_E1, tagOutMuxSelFAR, tagReadNotWrite_In;
wire tagReadWriteCycle_In, writeBufHi_E1, writeBufLoTag_E1, writeBufLo_E2, writeBufMuxSelBit0;
wire writeDataA0, writeDataA1, writeDataB0, writeDataB1, writeDirtyA, writeDirtyB, writeLRU;
wire writeTagA0, writeTagA1, writeTagB0, writeTagB1, xltValidLth, CAR_LSAcmp, CAR_SAQcmp;
wire LRU, SAQ_FARcmp, U0AttrFAR, carOF_FARcmp, carOF_LSAcmp, dirtyA, dirtyB, hit_a, hit_a_buf1;
wire hit_b, hit_b_buf1, validA, validB, carDcRead, flushIdle_state, flushAlmostDone, flushDone;
wire fillFlushToDoL2, oneFPL2, ocmCompleteXltVNoWaitNoHold;

//DCU_clkBuf DCU_clkBufSch( CB_buf[1:4], CB[1:4]);

wire CAR_mmuAttr_E1, CAR_mmuAttr_E1_i;
assign CAR_mmuAttr_E1 = CAR_mmuAttr_E1_i;
wire CAR_mmuAttr_E2, CAR_mmuAttr_E2_i;
assign CAR_mmuAttr_E2 = CAR_mmuAttr_E2_i;
wire DCU_DA, DCU_DA_i;
assign DCU_DA = DCU_DA_i;

p405s_DCU_control
 DCU_controlSch(
  .CAR_OF_E1(CAR_OF_E1),
  .CAR_OF_E2(CAR_OF_E2),
  .CAR_mmuAttr_E1(CAR_mmuAttr_E1_i),
  .CAR_mmuAttr_E2(CAR_mmuAttr_E2_i),
  .DCU_CA(DCU_CA),
  .DCU_DA(DCU_DA_i),
  .DCU_SCL2(DCU_SCL2),
  .DCU_apuWbByteEn(DCU_apuWbByteEn[0:3]),
  .DCU_carByteEn(DCU_carByteEn[0:3]),
  .DCU_diagBus(DCU_diagBus[0:20]),
  .DCU_firstCycCarStXltV(DCU_firstCycCarStXltV),
  .DCU_ocmAbort(DCU_ocmAbort),
  .DCU_ocmLoadReq(DCU_ocmLoadReq),
  .DCU_ocmStoreReq(DCU_ocmStoreReq),
  .DCU_ocmWait(DCU_ocmWait),
  .DCU_pclOcmLdPendNoWait(DCU_pclOcmLdPendNoWait),
  .DCU_plbABus(DCU_plbABus[30:31]),
  .DCU_plbAbort(DCU_plbAbort),
  .DCU_plbCacheable(DCU_plbCacheable),
  .DCU_plbDTags(DCU_plbDTags[0:7]),
  .DCU_plbGuarded(DCU_plbGuarded),
  .DCU_plbPriority(DCU_plbPriority),
  .DCU_plbRNW(DCU_plbRNW),
  .DCU_plbRequest(DCU_plbRequest),
  .DCU_plbTranSize(DCU_plbTranSize),
  .DCU_plbU0Attr(DCU_plbU0Attr),
  .DCU_plbWriteThru(DCU_plbWriteThru),
  .DCU_sleepReq(DCU_sleepReq),
  .FAR_E2(FAR_E2),
  .FDR_hiMuxSel(FDR_hiMuxSel),
  .FDR_hi_E1(FDR_hi_E1),
  .FDR_hi_E2(FDR_hi_E2),
  .FDR_holdMuxSel(FDR_holdMuxSel),
  .FDR_loMuxSel(FDR_loMuxSel),
  .FDR_lo_E1(FDR_lo_E1),
  .FDR_lo_E2(FDR_lo_E2),
  .FDR_outMuxSel(FDR_outMuxSel[0:1]),
  .LSA_E1(LSA_E1),
  .LSA_E2(LSA_E2),
  .PLBAR_E1(PLBAR_E1),
  .PLBAR_E2(PLBAR_E2),
  .PLBAR_selFAR(PLBAR_selFAR),
  .PLBAR_selSAQ(PLBAR_selSAQ),
  .PLBDR_E2(PLBDR_E2[0:3]),
  .PLBDR_hiMuxSel(PLBDR_hiMuxSel[0:3]),
  .SAQ_E1(SAQ_E1),
  .SAQ_E2(SAQ_E2),
  .SDP_FDR_muxSel(SDP_FDR_muxSel),
  .SDQ_E1(SDQ_E1),
  .SDQ_E2(SDQ_E2),
  .SDQ_SDP_OCM_sel(SDQ_SDP_OCM_sel),
  .SDQ_SDP_mux(SDQ_SDP_mux),
  .bypassFillSDP_sel(bypassFillSDP_sel[0:3]),
  .bypassMuxSel(bypassMuxSel[0:2]),
  .bypassPendOrDcRead(bypassPendOrDcRead),
  .byteWriteData(byteWriteData[0:15]),
  .byteWrite_E1(byteWrite_E1),
  .cacheableSpecialOp(cacheableSpecialOp),
  .carStore(carStore),
  .dOutMuxSelBit1Byte0(dRegMuxSelBit1Byte0),
  .dOutMuxSelBit1Byte1(dRegMuxSelBit1Byte1),
  .dOutMuxSelBit1Byte2(dRegMuxSelBit1Byte2),
  .dOutMuxSelBit1Byte3(dRegMuxSelBit1Byte3),
  .dataIndexLSA_dupSel(dataIndexLSA_dupSel),
  .dataIndexMuxSel2(dataIndexMuxSel2),
  .dataIndexMuxSel(dataIndexMuxSel[0:1]),
  .dataIndex_E1(dataIndex_E1),
  .dataIndex_E2(dataIndex_E2),
  .dataReadNotWrite_In(dataReadNotWrite_In),
  .dataReadWriteCycle_In(dataReadWriteCycle_In),
  .dirtyLRU_readIndexSel(dirtyLRU_readIndexSel),
  .dirtyLRU_readIndex_E1(dirtyLRU_readIndex_E1),
  .dirtyLRU_readIndex_E2(dirtyLRU_readIndex_E2),
  .dirtyLRU_writeIndex_E1(dirtyLRU_writeIndex_E1),
  .fillBufMuxSel0(fillBufMuxSel0[0:31]),
  .fillBufMuxSel1(fillBufMuxSel1[0:31]),
  .fillBuf_E1(fillBuf_E1),
  .fillBuf_E2(fillBuf_E2[0:7]),
  .fillUsingArray(fillUsingArray),
  .flushHold_E2(flushHold_E2),
  .forceDataIndexZero_mmu(forceDataIndexZero_mmu),
  .loadReadFBvalid(loadReadFBvalid),
  .newDirty(newDirty),
  .newLRU(newLRU),
  .newU0AttrIn(newU0AttrIn),
  .newValidIn(newValidIn),
  .readLRUDirty(readLRUDirty),
  .sampleCycleL2(sampleCycleL2),
  .tagIndexDup_E1(tagIndexDup_E1),
  .tagIndexDup_E2(tagIndexDup_E2),
  .tagIndexSel(tagIndexSel),
  .tagIndex_E1(tagIndex_E1),
  .tagOutMuxSelFAR(tagOutMuxSelFAR),
  .tagReadNotWrite_In(tagReadNotWrite_In),
  .tagReadWriteCycle_In(tagReadWriteCycle_In),
  .writeBufHi_E1(writeBufHi_E1),
  .writeBufHi_E2(writeBufHi_E2[0:3]),
  .writeBufLoTag_E1(writeBufLoTag_E1),
  .writeBufLo_E2(writeBufLo_E2),
  .writeBufMuxSelBit0(writeBufMuxSelBit0),
  .writeBufMuxSelBit1(writeBufMuxSelBit1[0:31]),
  .writeDataA0(writeDataA0),
  .writeDataA1(writeDataA1),
  .writeDataB0(writeDataB0),
  .writeDataB1(writeDataB1),
  .writeDirtyA(writeDirtyA),
  .writeDirtyB(writeDirtyB),
  .writeLRU(writeLRU),
  .writeTagA0(writeTagA0),
  .writeTagA1(writeTagA1),
  .writeTagB0(writeTagB0),
  .writeTagB1(writeTagB1),
  .xltValidLth(xltValidLth),
  .CAR_L2_buf1(CAR_L2_buf1[27:29]),
  .CAR_L2_buf2(CAR_L2_buf2[27:29]),
  .CAR_LSAcmp(CAR_LSAcmp),
  .CAR_OF_L2(CAR_OF_L2[27:29]),
  .CAR_SAQcmp(CAR_SAQcmp),
  .CAR_U0Attr(CAR_U0Attr),
  .CAR_cacheable(CAR_cacheable),
  .CAR_guarded(CAR_guarded),
  .CAR_writethru(CAR_writethru),
  .CB(CB),
  .ICU_dcuCCR0_L2(ICU_dcuCCR0_L2[0:10]),
  .ICU_syncAfterReset(ICU_syncAfterReset),
  .LRU(LRU),
  .LSA_L2(LSA_L2[27:29]),
  .MMU_dcuShadowAbort(MMU_dcuShadowAbort),
  .MMU_dcuUTLBAbort(MMU_dcuUTLBAbort),
  .MMU_dcuXltValid(MMU_dcuXltValid),
  .MMU_wbHold(MMU_wbHold),
  .OCM_dsComplete(OCM_dsComplete),
  .OCM_dsHold(OCM_dsHold),
  .PCL_dcuByteEn(PCL_dcuByteEn[0:3]),
  .PCL_dcuOp(PCL_dcuOp[0:11]),
  .PCL_dcuOp_early(PCL_dcuOp_early[0:2]),
  .PLB_dcuAddrAck(PLB_dcuAddrAck),
  .PLB_dcuBusy(PLB_dcuBusy),
  .PLB_dcuRdDAck(PLB_dcuRdDAck),
  .PLB_dcuRdWdAddr(PLB_dcuRdWdAddr[0:2]),
  .PLB_dcuSsize(PLB_dcuSsize),
  .PLB_dcuWrDAck(PLB_dcuWrDAck),
  .PLB_sampleCycle(PLB_sampleCycle),
  .SAQ_FARcmp(SAQ_FARcmp),
  .SAQ_L2(SAQ_L2[27:29]),
  .U0AttrFAR(U0AttrFAR),
  .VCT_exeAbort(VCT_exeAbort),
  .VCT_wbAbort(VCT_wbAbort),
  .carOF_FARcmp(carOF_FARcmp),
  .carOF_LSAcmp(carOF_LSAcmp),
  .dirtyA(dirtyA),
  .dirtyB(dirtyB),
  .hit_a(hit_a),
  .hit_a_buf1(hit_a_buf1),
  .hit_b(hit_b),
  .hit_b_buf1(hit_b_buf1),
  .resetCore(resetCore),
  .testEn(testEn),
  .validA(validA),
  .validB(validB),
//--------- start ---------------
// rgoldiez - bring this signal (carDcRead) up and over to the dataflow block for dcreads
//            bring flushIdle_state over to dataFlow for parity errors on flush/castouts
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
  .carDcRead(carDcRead),
  .flushIdle_state(flushIdle_state),
  .flushAlmostDone(flushAlmostDone),
  .flushDone(flushDone),
  .fillFlushToDoL2(fillFlushToDoL2),
  .oneFPL2(oneFPL2),
//--------- end ----------------
  .ocmCompleteXltVNoWaitNoHold(ocmCompleteXltVNoWaitNoHold),     //addedforissue206
  .PLB_sampleCycleAlt(PLB_sampleCycleAlt),
  .CPM_c405SyncBypass(CPM_c405SyncBypass));



//--------- start ---------------
// rgoldiez - added the DCU_parityError output signal for tag/data parity errors
//            added the CCR0[28] (which comes across from the ICU as bit 11) for chosing parity
//              on dcreads
//            added CCR[27] (which comes across from the ICU as bit 9) which selects tag or data on a dcread
//            added carDcRead for selection help of parity/data on dcreads
//            added DCU_DA to qualify the data parity signals to clear up X's
//            added ICU_dcuParity_PF and ICU_diagOutParity for ICU BIST connection
//            added flushIdle_state for parity errors on castouts/flushes
//            added resetCore for the parity error registers for castouts/flushes
//            added DCU_FlushParityError for castout/flush parity errors
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
// pmcilmoyle - added the BIST_sysPF output

wire DCU_parityError, DCU_parityError_i;
assign DCU_parityError = DCU_parityError_i;
wire DCU_FlushParityError, DCU_FlushParityError_i;
assign DCU_FlushParityError = DCU_FlushParityError_i;

p405s_DCU_dataFlow
 DCU_dataFlowSch(
  .CAR_L2_buf1            (CAR_L2_buf1[27:29]),
  .CAR_L2_buf2            (CAR_L2_buf2[27:29]),
  .CAR_LSAcmp             (CAR_LSAcmp),
  .CAR_OF_L2              (CAR_OF_L2[27:29]),
  .CAR_SAQcmp             (CAR_SAQcmp),
  .DCU_SDQ_mod_NEG        (DCU_SDQ_mod_NEG[0:31]),
  .DCU_data_NEG           (DCU_data_NEG[0:31]),
  .DCU_icuSize            (DCU_icuSize[0:2]),
  .DCU_ocmData            (DCU_ocmData[0:31]),
  .DCU_plbABus            (DCU_plbABus[0:29]),
  .DCU_plbDBus            (DCU_plbDBus[0:63]),
  .LRU                    (LRU),
  .LSA_L2                 (LSA_L2[27:29]),
  .SAQ_FARcmp             (SAQ_FARcmp),
  .SAQ_L2                 (SAQ_L2[27:29]),
  .U0AttrFAR              (U0AttrFAR),
  .carOF_FARcmp           (carOF_FARcmp),
  .carOF_LSAcmp           (carOF_LSAcmp),
  .dirtyA                 (dirtyA),
  .dirtyB                 (dirtyB),
  .hit_a                  (hit_a),
  .hit_a_buf1             (hit_a_buf1),
  .hit_b                  (hit_b),
  .hit_b_buf1             (hit_b_buf1),
  .validA                 (validA),
  .validB                 (validB),
  .DCU_parityError        (DCU_parityError_i),
  .CAR_OF_E1              (CAR_OF_E1),
  .CAR_OF_E2              (CAR_OF_E2),
  .CAR_endian             (CAR_endian),
  .CAR_mmuAttr_E1         (CAR_mmuAttr_E1_i),
  .CAR_mmuAttr_E2         (CAR_mmuAttr_E2_i),
  .CB                     (CB),
  .EXE_dcuData            (EXE_dcuData[0:31]),
  .FAR_E2                 (FAR_E2),
  .FDR_hiMuxSel           (FDR_hiMuxSel),
  .FDR_hi_E1              (FDR_hi_E1),
  .FDR_hi_E2              (FDR_hi_E2),
  .FDR_holdMuxSel         (FDR_holdMuxSel),
  .FDR_loMuxSel           (FDR_loMuxSel),
  .FDR_lo_E1              (FDR_lo_E1),
  .FDR_lo_E2              (FDR_lo_E2),
  .FDR_outMuxSel          (FDR_outMuxSel[0:1]),
  .ICU_dcuCCR0_L2_bit10   (ICU_dcuCCR0_L2[10]),
  .ICU_dcuCCR0_L2_bit11   (ICU_dcuCCR0_L2[11]),
  .LSA_E1                 (LSA_E1),
  .LSA_E2                 (LSA_E2),
  .MMU_diagOut            (MMU_diagOut[0:2]),
  .MMU_dsRA               (MMU_dsRA[0:29]),
  .PCL_stSteerCntl        (PCL_stSteerCntl[0:9]),
  .PLBAR_E1               (PLBAR_E1),
  .PLBAR_E2               (PLBAR_E2),
  .PLBAR_selFAR           (PLBAR_selFAR),
  .PLBAR_selSAQ           (PLBAR_selSAQ),
  .PLBDR_E2               (PLBDR_E2[0:3]),
  .PLBDR_hiMuxSel         (PLBDR_hiMuxSel[0:3]),
  .PLB_dcuReadDataBus     (PLB_dcuRdDBus[0:63]),
  .SAQ_E1                 (SAQ_E1),
  .SAQ_E2                 (SAQ_E2),
  .SDP_FDR_muxSel         (SDP_FDR_muxSel),
  .SDQ_E1                 (SDQ_E1),
  .SDQ_E2                 (SDQ_E2),
  .SDQ_SDP_OCM_sel        (SDQ_SDP_OCM_sel),
  .SDQ_SDP_mux            (SDQ_SDP_mux),
  .bypassFillSDP_sel      (bypassFillSDP_sel[0:3]),
  .bypassMuxSel           (bypassMuxSel[0:2]),
  .bypassPendOrDcRead     (bypassPendOrDcRead),
  .byteWriteData          (byteWriteData[0:15]),
  .byteWrite_E1           (byteWrite_E1),
  .cacheableSpecialOp     (cacheableSpecialOp),
  .carStore               (carStore),
  .dOutMuxSelBit1Byte0    (dRegMuxSelBit1Byte0),
  .dOutMuxSelBit1Byte1    (dRegMuxSelBit1Byte1),
  .dOutMuxSelBit1Byte2    (dRegMuxSelBit1Byte2),
  .dOutMuxSelBit1Byte3    (dRegMuxSelBit1Byte3),
  .dataIndexLSA_dupSel    (dataIndexLSA_dupSel),
  .dataIndexMuxSel2       (dataIndexMuxSel2),
  .dataIndexMuxSel        (dataIndexMuxSel[0:1]),
  .dataIndex_E1           (dataIndex_E1),
  .dataIndex_E2           (dataIndex_E2),
  .dataReadNotWrite_In    (dataReadNotWrite_In),
  .dataReadWriteCycle_In  (dataReadWriteCycle_In),
  .dirtyLRU_readIndexSel  (dirtyLRU_readIndexSel),
  .dirtyLRU_readIndex_E1  (dirtyLRU_readIndex_E1),
  .dirtyLRU_readIndex_E2  (dirtyLRU_readIndex_E2),
  .dirtyLRU_writeIndex_E1 (dirtyLRU_writeIndex_E1),
  .fillBufMuxSel0         (fillBufMuxSel0[0:31]),
  .fillBufMuxSel1         (fillBufMuxSel1[0:31]),
  .fillBuf_E1             (fillBuf_E1),
  .fillBuf_E2             (fillBuf_E2[0:7]),
  .fillUsingArray         (fillUsingArray),
  .flushHold_E2           (flushHold_E2),
  .forceDataIndexZero_mmu (forceDataIndexZero_mmu),
  .loadReadFBvalid        (loadReadFBvalid),
  .newDirty               (newDirty),
  .newLRU                 (newLRU),
  .newU0AttrIn            (newU0AttrIn),
  .newValidIn             (newValidIn),
  .readLRUDirty           (readLRUDirty),
  .sampleCycleL2          (sampleCycleL2),
  .tagIndexDup_E1         (tagIndexDup_E1),
  .tagIndexDup_E2         (tagIndexDup_E2),
  .tagIndexSel            (tagIndexSel),
  .tagIndex_E1            (tagIndex_E1),
  .tagOutMuxSelFAR        (tagOutMuxSelFAR),
  .tagReadNotWrite_In     (tagReadNotWrite_In),
  .tagReadWriteCycle_In   (tagReadWriteCycle_In),
  .testEn                 (testEn),
  .writeBufHi_E1          (writeBufHi_E1),
  .writeBufHi_E2          (writeBufHi_E2[0:3]),
  .writeBufLoTag_E1       (writeBufLoTag_E1),
  .writeBufLo_E2          (writeBufLo_E2),
  .writeBufMuxSelBit0     (writeBufMuxSelBit0),
  .writeBufMuxSelBit1     (writeBufMuxSelBit1[0:31]),
  .writeDataA0            (writeDataA0),
  .writeDataA1            (writeDataA1),
  .writeDataB0            (writeDataB0),
  .writeDataB1            (writeDataB1),
  .writeDirtyA            (writeDirtyA),
  .writeDirtyB            (writeDirtyB),
  .writeLRU               (writeLRU),
  .writeTagA0             (writeTagA0),
  .writeTagA1             (writeTagA1),
  .writeTagB0             (writeTagB0),
  .writeTagB1             (writeTagB1),
  .xltValidLth            (xltValidLth),
  .carDcRead              (carDcRead),
  .flushIdle_state        (flushIdle_state),
  .flushAlmostDone        (flushAlmostDone),
  .flushDone              (flushDone),
  .fillFlushToDoL2        (fillFlushToDoL2),
  .resetCore              (resetCore),
  .DCU_DA                 (DCU_DA_i),
  .DCU_FlushParityError   (DCU_FlushParityError_i),
  .oneFPL2                (oneFPL2),
  .ocmCompleteXltVNoWaitNoHold  (ocmCompleteXltVNoWaitNoHold),
// added for issue 206
  .ICU_CCR1DCTE           (ICU_CCR1DCTE),
  .ICU_CCR1DCDE           (ICU_CCR1DCDE),
  .dcu_bist_debug_si      (dcu_bist_debug_si),
  .dcu_bist_debug_so      (dcu_bist_debug_so),
  .dcu_bist_debug_en      (dcu_bist_debug_en),
  .dcu_bist_mode_reg_in   (dcu_bist_mode_reg_in),
  .dcu_bist_mode_reg_out  (dcu_bist_mode_reg_out),
  .dcu_bist_parallel_dr   (dcu_bist_parallel_dr),
  .dcu_bist_mode_reg_si   (dcu_bist_mode_reg_si),
  .dcu_bist_mode_reg_so   (dcu_bist_mode_reg_so),
  .dcu_bist_shift_dr      (dcu_bist_shift_dr),
  .dcu_bist_mbrun         (dcu_bist_mbrun),
  .resetMemBist           (resetMemBist)
);
//--------- end -----------------

// BDZ TRANSLATE_OFF
// synopsys translate_off
// Making assertions for violated assumptions
`ifdef DCU_MONITORS_OFF
`else
always@(posedge CB)
begin
  if(DCU_parityError_i == 1'b1)
  begin
       $display("ERROR: Unexpected load parity error from the DCU!");
    #5 $finish;
  end
  if(DCU_FlushParityError_i != 1'b0)
  begin
       $display("ERROR: Unexpected flush parity error from the DCU!");
    #5 $finish;
  end
end
`endif

`ifdef DCU_WB_MONITORS_OFF
`else
always@(posedge CB)
begin
  if(({^{DCU_dataFlowSch.wbU0AttrL1,DCU_dataFlowSch.wbTagL1[0:20],newValidIn}} ^ DCU_dataFlowSch.p_wbTagL1) == 1'b1) 
  begin
       $display("ERROR: Tag WriteBuffer has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word0L2[0:7]}} ^ DCU_dataFlowSch.p_WBhi_L2[0]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 0 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word0L2[8:15]}} ^ DCU_dataFlowSch.p_WBhi_L2[1]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 1 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word0L2[16:23]}} ^ DCU_dataFlowSch.p_WBhi_L2[2]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 2 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word0L2[24:31]}} ^ DCU_dataFlowSch.p_WBhi_L2[3]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 3 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word1L2[0:7]}} ^ DCU_dataFlowSch.p_WBhi_L2[4]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 4 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word1L2[8:15]}} ^ DCU_dataFlowSch.p_WBhi_L2[5]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 5 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word1L2[16:23]}} ^ DCU_dataFlowSch.p_WBhi_L2[6]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 6 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word1L2[24:31]}} ^ DCU_dataFlowSch.p_WBhi_L2[7]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 7 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word2L2[0:7]}} ^ DCU_dataFlowSch.p_WBhi_L2[8]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 8 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word2L2[8:15]}} ^ DCU_dataFlowSch.p_WBhi_L2[9]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 9 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word2L2[16:23]}} ^ DCU_dataFlowSch.p_WBhi_L2[10]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 10 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word2L2[24:31]}} ^ DCU_dataFlowSch.p_WBhi_L2[11]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 11 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word3L2[0:7]}} ^ DCU_dataFlowSch.p_WBhi_L2[12]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 12 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word3L2[8:15]}} ^ DCU_dataFlowSch.p_WBhi_L2[13]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 13 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word3L2[16:23]}} ^ DCU_dataFlowSch.p_WBhi_L2[14]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 14 has incorrect parity bit!");
    #5 $finish;
  end
  if(({^{DCU_dataFlowSch.WB_word3L2[24:31]}} ^ DCU_dataFlowSch.p_WBhi_L2[15]) == 1'b1) 
  begin
       $display("ERROR: WriteBuffer byte 15 has incorrect parity bit!");
    #5 $finish;
  end
end
`endif
// synopsys translate_on
// BDZ TRANSLATE_ON


endmodule
