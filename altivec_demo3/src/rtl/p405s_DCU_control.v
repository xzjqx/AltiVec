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
// RLG  07/16/02   2274   Adding sampleCycleAlt for the Byron chip guys

module p405s_DCU_control( CAR_OF_E1,
                          CAR_OF_E2,
                          CAR_mmuAttr_E1,
                          CAR_mmuAttr_E2,
                          DCU_CA,
                          DCU_DA,
                          DCU_SCL2,
                          DCU_apuWbByteEn,
                          DCU_carByteEn,
                          DCU_diagBus,
                          DCU_firstCycCarStXltV,
                          DCU_ocmAbort,
                          DCU_ocmLoadReq,
                          DCU_ocmStoreReq,
                          DCU_ocmWait,
                          DCU_pclOcmLdPendNoWait,
                          DCU_plbABus,
                          DCU_plbAbort,
                          DCU_plbCacheable,
                          DCU_plbDTags,
                          DCU_plbGuarded,
                          DCU_plbPriority,
                          DCU_plbRNW,
                          DCU_plbRequest,
                          DCU_plbTranSize,
                          DCU_plbU0Attr,
                          DCU_plbWriteThru,
                          DCU_sleepReq,
                          FAR_E2,
                          FDR_hiMuxSel,
                          FDR_hi_E1,
                          FDR_hi_E2,
                          FDR_holdMuxSel,
                          FDR_loMuxSel,
                          FDR_lo_E1,
                          FDR_lo_E2,
                          FDR_outMuxSel,
                          LSA_E1,
                          LSA_E2,
                          PLBAR_E1,
                          PLBAR_E2,
                          PLBAR_selFAR,
                          PLBAR_selSAQ,
                          PLBDR_E2,
                          PLBDR_hiMuxSel,
                          SAQ_E1,
                          SAQ_E2,
                          SDP_FDR_muxSel,
                          SDQ_E1,
                          SDQ_E2,
                          SDQ_SDP_OCM_sel,
                          SDQ_SDP_mux,
                          bypassFillSDP_sel,
                          bypassMuxSel,
                          bypassPendOrDcRead,
                          byteWriteData,
                          byteWrite_E1,
                          cacheableSpecialOp,
                          carStore,
                          dOutMuxSelBit1Byte0,
                          dOutMuxSelBit1Byte1,
                          dOutMuxSelBit1Byte2,
                          dOutMuxSelBit1Byte3,
                          dataIndexLSA_dupSel,
                          dataIndexMuxSel2,
                          dataIndexMuxSel,
                          dataIndex_E1,
                          dataIndex_E2,
                          dataReadNotWrite_In,
                          dataReadWriteCycle_In,
                          dirtyLRU_readIndexSel,
                          dirtyLRU_readIndex_E1,
                          dirtyLRU_readIndex_E2,
                          dirtyLRU_writeIndex_E1,
                          fillBufMuxSel0,
                          fillBufMuxSel1,
                          fillBuf_E1,
                          fillBuf_E2,
                          fillUsingArray,
                          flushHold_E2,
                          forceDataIndexZero_mmu,
                          loadReadFBvalid,
                          newDirty,
                          newLRU,
                          newU0AttrIn,
                          newValidIn,
                          readLRUDirty,
                          sampleCycleL2,
                          tagIndexDup_E1,
                          tagIndexDup_E2,
                          tagIndexSel,
                          tagIndex_E1,
                          tagOutMuxSelFAR,
                          tagReadNotWrite_In,
                          tagReadWriteCycle_In,
                          writeBufHi_E1,
                          writeBufHi_E2,
                          writeBufLoTag_E1,
                          writeBufLo_E2,
                          writeBufMuxSelBit0,
                          writeBufMuxSelBit1,
                          writeDataA0,
                          writeDataA1,
                          writeDataB0,
                          writeDataB1,
                          writeDirtyA,
                          writeDirtyB,
                          writeLRU,
                          writeTagA0,
                          writeTagA1,
                          writeTagB0,
                          writeTagB1,
                          xltValidLth,
                          CAR_L2_buf1,
                          CAR_L2_buf2,
                          CAR_LSAcmp,
                          CAR_OF_L2,
                          CAR_SAQcmp,
                          CAR_U0Attr,
                          CAR_cacheable,
                          CAR_guarded,
                          CAR_writethru,
                          CB,
                          ICU_dcuCCR0_L2,
                          ICU_syncAfterReset,
                          LRU,
                          LSA_L2,
                          MMU_dcuShadowAbort,
                          MMU_dcuUTLBAbort,
                          MMU_dcuXltValid,
                          MMU_wbHold,
                          OCM_dsComplete,
                          OCM_dsHold,
                          PCL_dcuByteEn,
                          PCL_dcuOp,
                          PCL_dcuOp_early,
                          PLB_dcuAddrAck,
                          PLB_dcuBusy,
                          PLB_dcuRdDAck,
                          PLB_dcuRdWdAddr,
                          PLB_dcuSsize,
                          PLB_dcuWrDAck,
                          PLB_sampleCycle,
                          SAQ_FARcmp,
                          SAQ_L2,
                          U0AttrFAR,
                          VCT_exeAbort,
                          VCT_wbAbort,
                          carOF_FARcmp,
                          carOF_LSAcmp,
                          dirtyA,
                          dirtyB,
                          hit_a,
                          hit_a_buf1,
                          hit_b,
                          hit_b_buf1,
                          resetCore,
                          testEn,
                          validA,
                          validB,
                          carDcRead,
                          flushIdle_state,
                          flushAlmostDone,
                          flushDone,
                          fillFlushToDoL2,
                          oneFPL2,
                          ocmCompleteXltVNoWaitNoHold,
                          PLB_sampleCycleAlt,
                          CPM_c405SyncBypass
                        );

output  CAR_OF_E1;
output  CAR_OF_E2;
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
output  FAR_E2;
output  FDR_hiMuxSel;
output  FDR_hi_E1;
output  FDR_hi_E2;
output  FDR_holdMuxSel;
output  FDR_loMuxSel;
output  FDR_lo_E1;
output  FDR_lo_E2;
output  LSA_E1;
output  LSA_E2;
output  PLBAR_E1;
output  PLBAR_E2;
output  PLBAR_selFAR;
output  PLBAR_selSAQ;
output  SAQ_E1;
output  SAQ_E2;
output  SDP_FDR_muxSel;
output  SDQ_E1;
output  SDQ_E2;
output  SDQ_SDP_OCM_sel;
output  SDQ_SDP_mux;
output  bypassPendOrDcRead;
output  byteWrite_E1;
output  cacheableSpecialOp;
output  carStore;
output  dOutMuxSelBit1Byte0;
output  dOutMuxSelBit1Byte1;
output  dOutMuxSelBit1Byte2;
output  dOutMuxSelBit1Byte3;
output  dataIndexLSA_dupSel;
output  dataIndexMuxSel2;
output  dataIndex_E1;
output  dataIndex_E2;
output  dataReadNotWrite_In;
output  dataReadWriteCycle_In;
output  dirtyLRU_readIndexSel;
output  dirtyLRU_readIndex_E1;
output  dirtyLRU_readIndex_E2;
output  dirtyLRU_writeIndex_E1;
output  fillBuf_E1;
output  fillUsingArray;
output  flushHold_E2;
output  forceDataIndexZero_mmu;
output  loadReadFBvalid;
output  newDirty;
output  newLRU;
output  newU0AttrIn;
output  newValidIn;
output  readLRUDirty;
output  sampleCycleL2;
output  tagIndexDup_E1;
output  tagIndexDup_E2;
output  tagIndexSel;
output  tagIndex_E1;
output  tagOutMuxSelFAR;
output  tagReadNotWrite_In;
output  tagReadWriteCycle_In;
output  writeBufHi_E1;
output  writeBufLoTag_E1;
output  writeBufLo_E2;
output  writeBufMuxSelBit0;
output  writeDataA0;
output  writeDataA1;
output  writeDataB0;
output  writeDataB1;
output  writeDirtyA;
output  writeDirtyB;
output  writeLRU;
output  writeTagA0;
output  writeTagA1;
output  writeTagB0;
output  writeTagB1;
output  xltValidLth;
output  ocmCompleteXltVNoWaitNoHold;

//--------- start ---------------
// rgoldiez - bringing this signal (carDcRead) over to the dataflow block for dcreads
//            bringing flushIdle_state to the flush data reg for signalling parity errors
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement

output carDcRead;
output flushIdle_state;
output flushAlmostDone;
output flushDone;
output fillFlushToDoL2;
output oneFPL2;

//--------- end ----------------

// added for tbird
input PLB_sampleCycleAlt;
input CPM_c405SyncBypass;

input  CAR_LSAcmp;
input  CAR_SAQcmp;
input  CAR_U0Attr;
input  CAR_cacheable;
input  CAR_guarded;
input  CAR_writethru;
input  ICU_syncAfterReset;
input  LRU;
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
input  SAQ_FARcmp;
input  U0AttrFAR;
input  VCT_exeAbort;
input  VCT_wbAbort;
input  carOF_FARcmp;
input  carOF_LSAcmp;
input  dirtyA;
input  dirtyB;
input  hit_a;
input  hit_a_buf1;
input  hit_b;
input  hit_b_buf1;
input  resetCore;
input  testEn;
input  validA;
input  validB;

output [0:3]  PLBDR_E2;
output [0:2]  bypassMuxSel;
output [0:31]  fillBufMuxSel1;
output [0:3]  bypassFillSDP_sel;
output [0:1]  dataIndexMuxSel;
output [0:3]  DCU_apuWbByteEn;
output [0:3]  DCU_carByteEn;
output [0:7]  DCU_plbDTags;
output [30:31]  DCU_plbABus;
output [0:31]  writeBufMuxSelBit1;
output [0:15]  byteWriteData;
output [0:3]  PLBDR_hiMuxSel;
output [0:20]  DCU_diagBus;
output [0:31]  fillBufMuxSel0;
output [0:7]  fillBuf_E2;
output [0:1]  FDR_outMuxSel;
output [0:3]  writeBufHi_E2;

input [0:3]  PCL_dcuByteEn;
input [27:29]  SAQ_L2;
input [0:2]  PCL_dcuOp_early;
input [27:29]  LSA_L2;
input CB;
input [27:29]  CAR_L2_buf2;
input [0:2]  PLB_dcuRdWdAddr;
input [27:29]  CAR_OF_L2;
input [0:10]  ICU_dcuCCR0_L2;
input [27:29]  CAR_L2_buf1;
input [0:11]  PCL_dcuOp;

// Buses in the design

wire  [0:2]  dValidCntSet;
wire  [0:2]  dVInc;
wire  [0:2]  setReset;
wire  [0:2]  dValidCnt_In1;
wire  [0:2]  wrAckCnt_In10;
wire  [0:2]  wrAckCnt_In11;
wire  [0:2]  wrAckCntInv;
wire  [0:6]  dValidQNeg;
//wire  [0:31]  fillValidL2;
reg  [0:1]  storeHitPendL2;
wire  [0:7]  DCU_byteEn_In;
wire  [30:31]  DCU_plbAddrBus_In;
reg  [0:1]  storeHitPendDupL2;
wire  [0:2]  wrAckCntL2;
//wire  [0:2]  dValidCntL2;
wire  [0:2]  dValidCnt1_In;
wire  [0:1]  storeHitPend_In0;
wire  [0:5]  fillSM_In;
//wire  [0:9]  cacheOpBusL2;
wire  [0:31]  fillValid_In;
wire  [0:2]  wrAckCnt1_In;
wire  [0:6]  dVQ_In11;
//wire  [3:3]  CB_buf;
wire  [0:6]  dVQ_In10;
wire  [0:6]  dVQ_In01;
wire  [0:6]  dVQ_In00;
wire  [0:1]  dVQ0_fullL2;
wire  [0:2]  wrAckCnt_In0X;
wire  [30:31]  DCU_ABusL2;
wire  [0:2]  wrAckCnt2_In;
wire  [0:1]  dValidCntSel;
wire  [0:2]  dValidCnt2_In;
wire  [0:8]  repower_inv;
wire  [0:20]  diagBufBuf;
wire  [0:7]  DCU_dTagsL2;
//wire  [0:3]  carOF_byteEn;
//wire  [0:5]  fillSM2;
//wire  [0:5]  fillSM;
//wire  [0:3]  SAQ_byteEn;
wire  [0:1]  set_storeHitPend1;
wire  [0:2]  rdWdAddrBuf;
// declare wires after replacing instantiations
wire DCU_requestDupInvL2;
wire DCU_requestDupL2;
wire DCU_RNW_dupInvL2;
wire DCU_RNW_dupL2;
//wire reset3L2;

wire sampleCycleBuf1, sampleCycleBuf2, sampleCycleBuf3, writeLRU_NEG;
reg twoLoadPendingL2;
reg SAQvalidNeedingPLBL2;
wire dVQ0_lineL2, dVQ0_sizeL2, dVQ1_fullL2, dVQ1_lineL2, dVQ1_sizeL2, rdDAckBuf2;
wire rdDAckBuf3, wrDAckBuf2, CAR_cacheableBuf2, PLB_dcuSsizeBuf2;
wire rdDAckBuf1, rdDAckBuf4, wrDAckBuf, CAR_cacheableBuf1, PLB_dcuSsizeBuf1, readLRUDirtyPre;
wire wrAckSelInc2_11, wrAckSelInc2_10, dValidCntDone_In;
wire wrAckCntDone_In, resetIn, DCU_someBusy_In, setDValidCntIdle, DCU_plbtranSize_In;
wire SAQvalidNeedingPLB0, DCUbypassPending_In0, DCU_ocmWait_In0, twoLoadPending_0_In;
wire caEarly_0_In,SAQvalidNeedingPLB1, DCUbypassPending_In1, DCU_ocmWait_In1;
wire twoLoadPending_1_In, caEarly_1_In, miss;
reg SAQvalidNeedingPLB2L2;
reg DCUbypassPendingL2;
reg DCU_ocmWaitL2, caEarlyL2, writeDirtyA;
reg [0:3] SAQ_byteEn;
reg SAQ_U0AttrL2;
wire dcu_DA_early_NEG, dcu_DA_sel, CAR_OF_full_In0;
wire sel_CAR_OF_full, writeDirtyB0, writeDirtyB1;
wire writeDirtyA0;

wire LRU_out_NEG,LRU_sel0, LRU_sel1, writeDirtyA1;
wire writeLRU0, writeLRU1, wrAckQ_sizeTran_E1, wrAckQ_full_In00, wrAckQ_full_Inx1;
wire wrAckQ_full_In10;
wire past1stCycXltValid_In, FAR_loadPending_In,CAR_OF_PLB_loaded_In,carTwoFP_In,carRead_In;
wire WB_lineDirtyIn,storeWord_In,specialOPDone_In,newDirtyIn,fillFlushToDo_In;
wire cmdInProg_E2, ocmStoreReq, ocmLoadReq, ocmAbort, DCU_cacheableL2, DCU_guardedL2;
wire DCU_RNWL2, DCU_tranSizeL2, DCU_priorityL2;
wire DCU_requestL2, DCU_writeThruL2, DCU_U0AttrL2, DCU_request_In, priority_In, fill_a;
wire LSA_bypassPending_In, specialCase_In, flush2ndRead_In, dcbzFillHitA_In;
wire carSpecialOp_In, fillLineDirty_In, dcbzFillHit_In, storeHitFillBufPend_In;
reg SAQ_guardedL2, SAQ_cacheableL2;
reg SAQ_writeThruL2;
wire fillFollowedByFill_In, LSA_load_In;
wire carDcbzCmd;
wire carFullIn, storeWriting_In, LSA_SM_In, FAR_full_In, oneFP_In, twoFP_In, cacheOpMuxSel;
wire cacheOpByteEn_E1, cacheOpByteEn_E2, xltValidLth_E2;
wire DCU_cacheable_In, DCU_guarded_In, DCU_RNW_In, DCU_writeThru_In, DCU_U0Attr_In;

reg dValidCntDoneL2, dValidCntDone2L2, dValidCntDone3L2, resetL2;
reg reset2L2, reset3L2, reset4L2, sampleCycleL2prime, DCU_someBusyL2;
reg [30:31] regDCU_PLBAR_bits_muxout, DCU_ABusL2_L2;
reg [0:2] regDCU_dVCnt_muxout;
reg [0:2] dValidCntL2;
reg [0:2] regDCU_wrAckCnt_muxout, regDCU_wrAckCnt_L2;
reg CAR_OF_fullL2, CAR_OF_full2L2;
reg [0:1] regDCU_CAR_OF_full_muxout;
reg [0:2] regDCU_writeDirty_muxout;
reg writeDirtyB;
reg [0:5] regDCU_SAQval_muxout;
reg regDCU_newLRU_muxout, newLRU;
reg [0:2] regDCU_writeDirtyLRU_muxout;
reg regDCU_writeLRU_L2,regDCU_writeLRU_muxout;
reg [0:6] regDCU_dValidQ_muxout, regDCU_dValidQ_L2;
reg [0:1] regDCU_wrAckQ_muxout;
reg wrAckQ_sizeL2, wrAckQ_lineL2;
reg regDCU_wrAckFull_muxout, wrAckQ_fullL2;
reg busySCL2,resetSCL2;
reg [0:10] regDCU_misc2_muxout;
reg past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2, carTwoFPL2, carReadL2,
    WB_lineDirtyReadL2, storeWordL2, specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
    fillFlushToDoL2_i;
wire fillFlushToDoL2;
wire newDirty;
reg [0:2] regDCU_request_muxout, regDCU_request_L2;
reg  twoLoadPendingL2L2, fill_A_L2, LSA_bypassPendingL2, specialCaseL2;
reg  flush2ndReadL2, dcbzFillHitA_L2, carSpecialOpL2;
reg  fillLineDirtyL2, dcbzFillHitL2, storeHitFillBufPendL2, fillFollowedByFillL2;
reg [0:10] regDCU_misc1_muxout;
reg [0:15] regDCU_PLBAR_L2;
reg [0:31] fillValidL2, regDCU_fillBufValidBits_muxout;
reg LSA_cacheableL2, newU0AttrIn_i,LSA_loadL2, LSA_guardedL2;
wire newU0AttrIn;
reg [0:3] carOF_byteEn;
reg carOF_cacheableL2, carOF_writeThruL2, carOF_guardedL2,
    carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2, carOF_dcbzCmdL2,
    carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2;
reg [0:14] regDCU_carOF_bits_muxout;
reg carFullL2,carFull2L2, storeWritingL2, fillSM3_pend,
            LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2;
wire oneFPL2;
reg [0:5] fillSM2, fillSM;
reg [0:19] regDCU_stateMachine_muxout;
reg carLoadDup, carStoreDup;
reg [0:9] cacheOpBusL2;
reg [0:3] DCU_carByteEn_i;
wire [0:3] DCU_carByteEn;
reg [0:15] regDCU_cacheOpByteEn_muxout;
reg wrAckCntDoneL2_L2;
wire wrAckCntDoneL2;
wire CAR_OF_E1, CAR_OF_E1_i;
assign CAR_OF_E1 = CAR_OF_E1_i;
wire CAR_OF_E2, CAR_OF_E2_i;
assign CAR_OF_E2 = CAR_OF_E2_i;
wire DCU_CA, DCU_CA_i;
assign DCU_CA = DCU_CA_i;

// Removed the module 'dp_logDCU_sampleCycleBuf2'
wire sampleCycleL2, sampleCycleL2_i;
assign sampleCycleL2 = sampleCycleL2_i;
assign {DCU_SCL2, sampleCycleBuf1, sampleCycleBuf2, sampleCycleBuf3} = {sampleCycleL2_i, sampleCycleL2_i, sampleCycleL2_i,sampleCycleL2_i};
// Removed the module 'dp_logDCU_writeLRU'
assign writeLRU = ~(writeLRU_NEG);
// Removed the module 'dp_logDCU_diagBuf2'
assign DCU_diagBus[0:20] = diagBufBuf[0:20];
// Removed the module 'dp_logDCU_diagBuf1'
assign diagBufBuf[0:20] = {DCU_requestDupL2, DCU_RNW_dupL2, carFullL2, CAR_OF_fullL2,
     SAQvalidNeedingPLBL2, LSA_SM, busySCL2, fillSM[1:5], DCU_CA_i, twoLoadPendingL2, twoFPL2,
     dValidCntL2[0:2], wrAckCntL2[0:2]};
// Removed the module 'dp_logDCU_dValidQBuf'
assign {dVQ0_fullL2[0:1], dVQ0_lineL2, dVQ0_sizeL2, dVQ1_fullL2, dVQ1_lineL2, dVQ1_sizeL2 } = ~(dValidQNeg[0:6]);
// Removed the module 'dp_logDCU_wrAckCntInv'
assign wrAckCntL2[0:2] = ~(wrAckCntInv[0:2]);
// Removed the module 'dp_muxDCU_dVsetInc2'
assign dVInc[0:2] = (dValidCnt1_In[0:2] & {(3){~(dValidCntSel[1])}} ) | (dValidCnt2_In[0:2] & {(3){dValidCntSel[1]}} );
// Removed the module 'dp_logDCU_PLB_repower3'
assign {rdDAckBuf2, rdDAckBuf3, wrDAckBuf2, CAR_cacheableBuf2,PLB_dcuSsizeBuf2}
  = ~({repower_inv[0], repower_inv[1], repower_inv[2],repower_inv[6], repower_inv[8]});
// Removed the module 'dp_logDCU_apuBE'
assign DCU_carByteEn[0:3] = DCU_carByteEn_i[0:3];
assign DCU_apuWbByteEn[0:3] = DCU_carByteEn_i[0:3];
// Removed the module 'dp_logDCU_PLB_repower2'
assign {rdDAckBuf1, rdDAckBuf4,wrDAckBuf, rdWdAddrBuf[0:2], CAR_cacheableBuf1, readLRUDirty, PLB_dcuSsizeBuf1} = ~(repower_inv[0:8]);
// Removed the module 'dp_logDCU_PLB_repower1'
assign repower_inv[0:8] = ~({PLB_dcuRdDAck, PLB_dcuRdDAck, PLB_dcuWrDAck,
     PLB_dcuRdWdAddr[0:2], CAR_cacheable, readLRUDirtyPre, PLB_dcuSsize});
// Removed the module 'dp_regDCU_wrAckCntDone'
assign wrAckCntDoneL2 = ~(wrAckCntDoneL2_L2);
always @(posedge CB)
    begin
     wrAckCntDoneL2_L2 <= wrAckCntDone_In;
   end
// Removed the module 'dp_muxDCU_wrAcksetInc1'
assign wrAckCnt_In11[0:2] = (wrAckCnt1_In[0:2] & {(3){~(wrAckSelInc2_11)}} ) | (wrAckCnt2_In[0:2] & {(3){wrAckSelInc2_11}} );
// Removed the module 'dp_muxDCU_wrAcksetInc0'
assign wrAckCnt_In10[0:2] = (wrAckCnt1_In[0:2] & {(3){~(wrAckSelInc2_10)}} ) | (wrAckCnt2_In[0:2] & {(3){wrAckSelInc2_10}} );
// rlg - 07/16/02 - for the Byron chip guys, we are adding a second sample cycle signal
//                   that is OR'ed in after this latch
//dp_regDCU_dValidCntDone regDCU_dValidCntDone({CB[0:2], CB_buf[3], CB[4]}, {dValidCntDone_In,
//     dValidCntDone_In, dValidCntDone_In, resetIn, resetIn, resetIn, resetIn, PLB_sampleCycle,
//     DCU_someBusy_In}, scan27, {dValidCntDoneL2, dValidCntDone2L2, dValidCntDone3L2, resetL2,
//     reset2L2, reset3L2, reset4L2, sampleCycleL2, DCU_someBusyL2}, scan28);
//wire   sampleCycleL2prime;
assign sampleCycleL2_i = sampleCycleL2prime | PLB_sampleCycleAlt | ~CPM_c405SyncBypass;
// Removed the module 'dp_regDCU_dValidCntDone'
always @(posedge CB)
    begin
     {dValidCntDoneL2, dValidCntDone2L2, dValidCntDone3L2, resetL2,
     reset2L2, reset3L2, reset4L2, sampleCycleL2prime, DCU_someBusyL2} <= {dValidCntDone_In,
     dValidCntDone_In, dValidCntDone_In, resetIn, resetIn, resetIn, resetIn, PLB_sampleCycle,
     DCU_someBusy_In};
   end
// Removed the module 'dp_muxDCU_dVsetFB'
assign dValidCntSet[0:2] = (dValidCntL2[0:2] & {(3){~(setDValidCntIdle)}} ) | (setReset[0:2] & {(3){setDValidCntIdle}} );
// Removed the module 'dp_muxDCU_dVsetInc'
assign dValidCnt_In1[0:2] = (dVInc[0:2] & {(3){~(dValidCntSel[0])}} ) | (setReset[0:2] & {(3){dValidCntSel[0]}} );
// Removed the module 'dp_regDCU_PLBAR_bits'
wire PLBAR_E1, PLBAR_E1_i;
assign PLBAR_E1 = PLBAR_E1_i;
wire PLBAR_E2, PLBAR_E2_i;
assign  PLBAR_E2 = PLBAR_E2_i;
assign DCU_ABusL2[30:31] = ~(DCU_ABusL2_L2);
always @(DCU_plbAddrBus_In or DCU_plbtranSize_In)
    begin
    casez(DCU_plbtranSize_In)
     1'b0: regDCU_PLBAR_bits_muxout = DCU_plbAddrBus_In[30:31];
     1'b1: regDCU_PLBAR_bits_muxout = {1'b0, 1'b0};
      default: regDCU_PLBAR_bits_muxout = 2'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez((PLBAR_E1_i & PLBAR_E2_i))
     1'b0: DCU_ABusL2_L2[30:31] <= DCU_ABusL2_L2[30:31];
     1'b1: DCU_ABusL2_L2[30:31] <= regDCU_PLBAR_bits_muxout;
      default: DCU_ABusL2_L2[30:31] <= 2'bx;
    endcase
   end
// Removed the module 'dp_regDCU_dVCnt'
always @(dValidCntSet or dValidCnt_In1 or rdDAckBuf4)
    begin
    casez(rdDAckBuf4)
     1'b0: regDCU_dVCnt_muxout = dValidCntSet[0:2];
     1'b1: regDCU_dVCnt_muxout = dValidCnt_In1[0:2];
      default: regDCU_dVCnt_muxout = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(sampleCycleBuf1)
     1'b0: dValidCntL2[0:2] <= dValidCntL2[0:2];
     1'b1: dValidCntL2[0:2] <= regDCU_dVCnt_muxout;
      default: dValidCntL2[0:2] <= 3'bx;
    endcase
   end
// Removed the module 'dp_regDCU_wrAckCnt'
assign wrAckCntInv[0:2] = ~(regDCU_wrAckCnt_L2[0:2]);
always @(wrDAckBuf or PLB_dcuSsize or wrAckCnt_In0X or wrAckCnt_In0X or wrAckCnt_In10 or wrAckCnt_In11)
    begin
    casez({wrDAckBuf, PLB_dcuSsize})
     2'b00: regDCU_wrAckCnt_muxout = wrAckCnt_In0X[0:2];
     2'b01: regDCU_wrAckCnt_muxout = wrAckCnt_In0X[0:2];
     2'b10: regDCU_wrAckCnt_muxout = wrAckCnt_In10[0:2];
     2'b11: regDCU_wrAckCnt_muxout = wrAckCnt_In11[0:2];
      default: regDCU_wrAckCnt_muxout = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(sampleCycleBuf1)
     1'b0: regDCU_wrAckCnt_L2 <= regDCU_wrAckCnt_L2;
     1'b1: regDCU_wrAckCnt_L2 <= regDCU_wrAckCnt_muxout;
      default: regDCU_wrAckCnt_L2 <= 3'bx;
    endcase
   end
// Removed the module 'dp_regDCU_SAQval'
always @(SAQvalidNeedingPLB0 or SAQvalidNeedingPLB0 or DCUbypassPending_In0 or DCU_ocmWait_In0 or
         twoLoadPending_0_In or caEarly_0_In or SAQvalidNeedingPLB1 or SAQvalidNeedingPLB1 or
         DCUbypassPending_In1 or DCU_ocmWait_In1 or twoLoadPending_1_In or caEarly_1_In or miss)
    begin
    casez(miss)
     1'b0: regDCU_SAQval_muxout = {SAQvalidNeedingPLB0,
     SAQvalidNeedingPLB0, DCUbypassPending_In0, DCU_ocmWait_In0, twoLoadPending_0_In,
     caEarly_0_In};
     1'b1: regDCU_SAQval_muxout = {SAQvalidNeedingPLB1, SAQvalidNeedingPLB1, DCUbypassPending_In1,
     DCU_ocmWait_In1, twoLoadPending_1_In, caEarly_1_In};
      default: regDCU_SAQval_muxout = 6'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     {SAQvalidNeedingPLBL2,SAQvalidNeedingPLB2L2, DCUbypassPendingL2,
      DCU_ocmWaitL2, twoLoadPendingL2, caEarlyL2} <= regDCU_SAQval_muxout;
   end
// Removed the module 'dp_logmiss'
assign miss = ~( hit_a | hit_b );
// Removed the module 'dp_muxDCU_DA'
assign DCU_DA = ~( (dcu_DA_early_NEG & {(1){~(dcu_DA_sel)}} ) | (miss & {(1){dcu_DA_sel}} ) );
// Removed the module 'dp_regDCU_CAR_OF_full'
always @(CAR_OF_full_In0 or CAR_OF_full_In0 or miss or sel_CAR_OF_full)
    begin
    casez(sel_CAR_OF_full)
     1'b0: regDCU_CAR_OF_full_muxout = {CAR_OF_full_In0,CAR_OF_full_In0};
     1'b1: regDCU_CAR_OF_full_muxout = {miss, miss};
      default: regDCU_CAR_OF_full_muxout = 2'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(CAR_OF_E1_i)
     1'b0: {CAR_OF_fullL2,CAR_OF_full2L2} <= {CAR_OF_fullL2,CAR_OF_full2L2};
     1'b1: {CAR_OF_fullL2,CAR_OF_full2L2} <= regDCU_CAR_OF_full_muxout;
      default: {CAR_OF_fullL2,CAR_OF_full2L2} <= 2'bx;
    endcase
   end
// Removed the module 'dp_regDCU_writeDirty'
always @(writeDirtyB0 or storeHitPend_In0 or writeDirtyB1 or set_storeHitPend1 or hit_b_buf1)
    begin
    casez(hit_b_buf1)
     1'b0: regDCU_writeDirty_muxout = {writeDirtyB0,storeHitPend_In0[1], storeHitPend_In0[1]};
     1'b1: regDCU_writeDirty_muxout = {writeDirtyB1, set_storeHitPend1[1],set_storeHitPend1[1]};
      default: regDCU_writeDirty_muxout = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     {writeDirtyB, storeHitPendL2[1],storeHitPendDupL2[1]} <= regDCU_writeDirty_muxout;
   end

   // Replacing instantiation: GTECH_NOT SGT_dupInv_0_
   assign DCU_requestDupL2 = ~(DCU_requestDupInvL2);

   // Replacing instantiation: GTECH_NOT SGT_dupInv_1_
   assign DCU_RNW_dupL2 = ~(DCU_RNW_dupInvL2);

   // Replacing instantiation: GTECH_NOT SGT_dupInv_2_
   wire DCU_tranSize_dupInvL2;
   wire DCU_tranSize_dupL2;
   assign DCU_tranSize_dupL2 = ~(DCU_tranSize_dupInvL2);

   // Replacing instantiation: GTECH_NOT SGT_reset_not_0_
   assign setReset[0] = ~(reset3L2);

   // Replacing instantiation: GTECH_NOT SGT_reset_not_1_
   assign setReset[1] = ~(reset3L2);

   // Replacing instantiation: GTECH_NOT SGT_reset_not_2_
   assign setReset[2] = ~(reset3L2);

   // Replacing instantiation: GTECH_NOT SGT_notHitA
   wire hit_a_buf2_not;
   assign hit_a_buf2_not = ~(hit_a_buf1);

   // Replacing instantiation: GTECH_OR2 SGT_hita_or_hitb
   wire hit_a_or_b;
   assign hit_a_or_b = hit_a_buf1 | hit_b_buf1;

// Removed the module 'dp_regDCU_newLRU'
always @(hit_a_buf1 or LRU_out_NEG or hit_a_buf2_not or dcbzFillHitA_L2 or LRU_sel0 or LRU_sel1)
    begin
    casez({LRU_sel0, LRU_sel1})
     2'b00: regDCU_newLRU_muxout = hit_a_buf1;
     2'b01: regDCU_newLRU_muxout = LRU_out_NEG;
     2'b10: regDCU_newLRU_muxout = hit_a_buf2_not;
     2'b11: regDCU_newLRU_muxout = dcbzFillHitA_L2;
      default: regDCU_newLRU_muxout = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     newLRU <= regDCU_newLRU_muxout;
   end
// Removed the module 'dp_regDCU_writeDirtyLRU'
always @(writeDirtyA0 or storeHitPend_In0 or storeHitPend_In0 or writeDirtyA1 or set_storeHitPend1 or set_storeHitPend1 or hit_a_buf1)
    begin
    casez(hit_a_buf1)
     1'b0: regDCU_writeDirtyLRU_muxout = {writeDirtyA0,storeHitPend_In0[0], storeHitPend_In0[0]};
     1'b1: regDCU_writeDirtyLRU_muxout = {writeDirtyA1, set_storeHitPend1[0],set_storeHitPend1[0]};
      default: regDCU_writeDirtyLRU_muxout = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     {writeDirtyA, storeHitPendL2[0],storeHitPendDupL2[0]} <= regDCU_writeDirtyLRU_muxout;
   end
// Removed the module 'dp_regDCU_writeLRU'
assign writeLRU_NEG = ~(regDCU_writeLRU_L2);
always @(writeLRU0 or writeLRU1 or hit_a_or_b)
    begin
    casez(hit_a_or_b)
     1'b0: regDCU_writeLRU_muxout = writeLRU0;
     1'b1: regDCU_writeLRU_muxout = writeLRU1;
      default: regDCU_writeLRU_muxout = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
     regDCU_writeLRU_L2 <= regDCU_writeLRU_muxout;
   end
// Removed the module 'dp_regDCU_dValidQ'
assign dValidQNeg[0:6] = ~(regDCU_dValidQ_L2[0:6]);
always @(dVQ_In00 or dVQ_In01 or dVQ_In10 or dVQ_In11 or PLB_dcuAddrAck or rdDAckBuf4)
    begin
    casez({PLB_dcuAddrAck, rdDAckBuf4})
     2'b00: regDCU_dValidQ_muxout = dVQ_In00[0:6];
     2'b01: regDCU_dValidQ_muxout = dVQ_In01[0:6];
     2'b10: regDCU_dValidQ_muxout = dVQ_In10[0:6];
     2'b11: regDCU_dValidQ_muxout = dVQ_In11[0:6];
      default: regDCU_dValidQ_muxout = 7'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(sampleCycleBuf2)
     1'b0: regDCU_dValidQ_L2 <= regDCU_dValidQ_L2;
     1'b1: regDCU_dValidQ_L2 <= regDCU_dValidQ_muxout;
      default: regDCU_dValidQ_L2 <= 7'bx;
    endcase
   end
// Removed the module 'dp_regDCU_wrAckQ'
always @(PLB_dcuSsize or DCU_tranSize_dupL2 or reset3L2)
    begin
    casez(reset3L2)
     1'b0: regDCU_wrAckQ_muxout = {PLB_dcuSsize, DCU_tranSize_dupL2};
     1'b1: regDCU_wrAckQ_muxout = {1'b0, 1'b0};
      default: regDCU_wrAckQ_muxout = 2'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(wrAckQ_sizeTran_E1)
     1'b0: {wrAckQ_sizeL2, wrAckQ_lineL2} <= {wrAckQ_sizeL2, wrAckQ_lineL2};
     1'b1: {wrAckQ_sizeL2, wrAckQ_lineL2} <= regDCU_wrAckQ_muxout;
      default: {wrAckQ_sizeL2, wrAckQ_lineL2} <= 2'bx;
    endcase
   end
// Removed the module 'dp_regDCU_wrAckFull'
always @(wrAckQ_full_In00 or wrAckQ_full_Inx1 or wrAckQ_full_In10 or wrAckQ_full_Inx1 or PLB_dcuAddrAck or wrDAckBuf)
    begin
    casez({PLB_dcuAddrAck, wrDAckBuf})
     2'b00: regDCU_wrAckFull_muxout = wrAckQ_full_In00;
     2'b01: regDCU_wrAckFull_muxout = wrAckQ_full_Inx1;
     2'b10: regDCU_wrAckFull_muxout = wrAckQ_full_In10;
     2'b11: regDCU_wrAckFull_muxout = wrAckQ_full_Inx1;
      default: regDCU_wrAckFull_muxout = 1'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(sampleCycleBuf2)
     1'b0: wrAckQ_fullL2 <= wrAckQ_fullL2;
     1'b1: wrAckQ_fullL2 <= regDCU_wrAckFull_muxout;
      default: wrAckQ_fullL2 <= 1'bx;
    endcase
   end
// Removed the module 'dp_regDCU_resetBusy'
always @(posedge CB)
    begin
    casez(sampleCycleBuf1)
     1'b0: {busySCL2, resetSCL2} <= {busySCL2, resetSCL2};
     1'b1: {busySCL2, resetSCL2} <= {PLB_dcuBusy, reset2L2};
      default: {busySCL2, resetSCL2} <= 2'bx;
    endcase
   end
// Removed the module 'dp_regDCU_misc2'
//newedit1
wire [0:10] Mikemisc2;
assign Mikemisc2={past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2,
        carTwoFPL2, carReadL2, WB_lineDirtyReadL2, storeWordL2,
        specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
        fillFlushToDoL2_i};
//newedit1 end

assign newDirty = newDirty_i;
assign fillFlushToDoL2 = fillFlushToDoL2_i;
always @(past1stCycXltValid_In or FAR_loadPending_In or CAR_OF_PLB_loaded_In or carTwoFP_In or
         carRead_In or WB_lineDirtyIn or storeWord_In or specialOPDone_In or MMU_dcuUTLBAbort or
         newDirtyIn or fillFlushToDo_In or reset2L2)
    begin
    casez(reset2L2)
     1'b0: regDCU_misc2_muxout[0:10] = {past1stCycXltValid_In,
     FAR_loadPending_In, CAR_OF_PLB_loaded_In, carTwoFP_In, carRead_In, WB_lineDirtyIn,
     storeWord_In, specialOPDone_In, MMU_dcuUTLBAbort, newDirtyIn, fillFlushToDo_In};
     1'b1: regDCU_misc2_muxout[0:10] = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0};
      default: regDCU_misc2_muxout[0:10] = 11'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(cmdInProg_E2)
     1'b0: {past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2, carTwoFPL2, carReadL2,
        WB_lineDirtyReadL2, storeWordL2, specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
        fillFlushToDoL2_i} <= {past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2, carTwoFPL2, carReadL2,
        WB_lineDirtyReadL2, storeWordL2, specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
        fillFlushToDoL2_i};
     1'b1: {past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2, carTwoFPL2, carReadL2,
        WB_lineDirtyReadL2, storeWordL2, specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
        fillFlushToDoL2_i} <= regDCU_misc2_muxout[0:10];
      default: {past1stCycXltValidL2, FAR_loadPendingL2, CAR_OF_PLB_loadedL2, carTwoFPL2, carReadL2,
        WB_lineDirtyReadL2, storeWordL2, specialOPDoneL2, MMU_dcuUTLBAbortL2, newDirty_i,
        fillFlushToDoL2_i} <= 11'bx;
    endcase
   end
// Removed the module 'dp_logDCU_ocmBuf'
assign {DCU_ocmStoreReq, DCU_ocmLoadReq, DCU_ocmAbort, DCU_plbAbort} = {ocmStoreReq, ocmLoadReq, ocmAbort, resetSCL2};
// Removed the module 'dp_logDCU_plbBuf'
assign {DCU_plbABus[30:31], DCU_plbCacheable, DCU_plbGuarded, DCU_plbRNW,
     DCU_plbTranSize, DCU_plbDTags[0:7], DCU_plbPriority, DCU_plbRequest, DCU_plbWriteThru,
     DCU_plbU0Attr} = ~({DCU_ABusL2[30:31], DCU_cacheableL2, DCU_guardedL2, DCU_RNWL2,
     DCU_tranSizeL2, DCU_dTagsL2[0:7], DCU_priorityL2, DCU_requestL2, DCU_writeThruL2,
     DCU_U0AttrL2});
// Removed the module 'dp_logDCU_ocmWaitBuf'
assign {DCU_ocmWait,carStore} = {DCU_ocmWaitL2, cacheOpBusL2[1]};

//dp_logDCU_aclkbuf_cntl logDCU_aclkbuf_cntl(CB[3], CB_buf[3]);
// Removed the module 'dp_logDCU_aclkbuf_cntl'


// Removed the module 'dp_regDCU_request'
assign {DCU_requestL2, DCU_requestDupInvL2, DCU_priorityL2} = ~(regDCU_request_L2[0:2]);
 always @(DCU_request_In or DCU_request_In or priority_In or PLB_dcuAddrAck)
    begin
    casez(PLB_dcuAddrAck)
     1'b0: regDCU_request_muxout = {DCU_request_In, DCU_request_In,priority_In};
     1'b1: regDCU_request_muxout = {1'b0, 1'b0, 1'b0};
      default: regDCU_request_muxout = 3'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(sampleCycleBuf2)
     1'b0: regDCU_request_L2 <= regDCU_request_L2;
     1'b1: regDCU_request_L2 <= regDCU_request_muxout;
      default: regDCU_request_L2 <= 3'bx;
    endcase
   end
// Removed the module 'dp_regDCU_misc1'

//newedit2
wire [0:10] Mikemisc1;
assign Mikemisc1={twoLoadPendingL2L2, fill_A_L2,LSA_bypassPendingL2, specialCaseL2,
            flush2ndReadL2, dcbzFillHitA_L2, carSpecialOpL2,fillLineDirtyL2,
            dcbzFillHitL2, storeHitFillBufPendL2, fillFollowedByFillL2};
//newedit2 end

always @(twoLoadPendingL2 or fill_a or LSA_bypassPending_In or specialCase_In or flush2ndRead_In or
         dcbzFillHitA_In or carSpecialOp_In or fillLineDirty_In or dcbzFillHit_In or
         storeHitFillBufPend_In or fillFollowedByFill_In or reset2L2)
    begin
    casez(reset2L2)
     1'b0: regDCU_misc1_muxout = {twoLoadPendingL2, fill_a,
     LSA_bypassPending_In, specialCase_In, flush2ndRead_In, dcbzFillHitA_In, carSpecialOp_In,
     fillLineDirty_In, dcbzFillHit_In, storeHitFillBufPend_In, fillFollowedByFill_In};
     1'b1: regDCU_misc1_muxout = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0};
      default: regDCU_misc1_muxout = 11'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(cmdInProg_E2)
     1'b0: {twoLoadPendingL2L2, fill_A_L2,LSA_bypassPendingL2, specialCaseL2, flush2ndReadL2,
            dcbzFillHitA_L2, carSpecialOpL2,fillLineDirtyL2, dcbzFillHitL2, storeHitFillBufPendL2,
            fillFollowedByFillL2} <= {twoLoadPendingL2L2, fill_A_L2,LSA_bypassPendingL2, specialCaseL2,
            flush2ndReadL2, dcbzFillHitA_L2, carSpecialOpL2,fillLineDirtyL2, dcbzFillHitL2,
            storeHitFillBufPendL2, fillFollowedByFillL2};
     1'b1: {twoLoadPendingL2L2, fill_A_L2,LSA_bypassPendingL2, specialCaseL2, flush2ndReadL2,
            dcbzFillHitA_L2, carSpecialOpL2,fillLineDirtyL2, dcbzFillHitL2, storeHitFillBufPendL2,
            fillFollowedByFillL2} <= regDCU_misc1_muxout;
      default: {twoLoadPendingL2L2, fill_A_L2,LSA_bypassPendingL2, specialCaseL2, flush2ndReadL2,
                dcbzFillHitA_L2, carSpecialOpL2,fillLineDirtyL2, dcbzFillHitL2, storeHitFillBufPendL2,
                fillFollowedByFillL2} <= 11'bx;
    endcase
   end
// Removed the module 'dp_regDCU_fillBufValidBits'
always @(fillValid_In or reset3L2)
    begin
    casez(reset3L2)
     1'b0: regDCU_fillBufValidBits_muxout = fillValid_In[0:31];
     1'b1: regDCU_fillBufValidBits_muxout = 32'b0;
      default: regDCU_fillBufValidBits_muxout = 32'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(cmdInProg_E2)
     1'b0: fillValidL2[0:31] <= fillValidL2[0:31];
     1'b1: fillValidL2[0:31] <= regDCU_fillBufValidBits_muxout;
      default: fillValidL2[0:31] <= 32'bx;
    endcase
   end
// Removed the module 'dp_regDCU_SAQ_bits'
wire SAQ_E1, SAQ_E1_i, SAQ_E2, SAQ_E2_i;
assign SAQ_E1 = SAQ_E1_i;
assign SAQ_E2 = SAQ_E2_i;
always @(posedge CB)
    begin
    casez(SAQ_E1_i & SAQ_E2_i)
     1'b0: {SAQ_byteEn[0:3], SAQ_guardedL2, SAQ_cacheableL2, SAQ_U0AttrL2, SAQ_writeThruL2} <=
           {SAQ_byteEn[0:3], SAQ_guardedL2, SAQ_cacheableL2, SAQ_U0AttrL2, SAQ_writeThruL2};
     1'b1: {SAQ_byteEn[0:3], SAQ_guardedL2, SAQ_cacheableL2, SAQ_U0AttrL2, SAQ_writeThruL2} <=
           {DCU_carByteEn_i[0:3], CAR_guarded, CAR_cacheableBuf2, CAR_U0Attr, CAR_writethru};
      default: {SAQ_byteEn[0:3], SAQ_guardedL2, SAQ_cacheableL2, SAQ_U0AttrL2, SAQ_writeThruL2} <= 8'bx;
    endcase
   end
// Removed the module 'dp_regDCU_LSA_bits'
wire LSA_E1, LSA_E1_i;
wire LSA_E2, LSA_E2_i;
assign LSA_E1 = LSA_E1_i;
assign LSA_E2 = LSA_E2_i;
assign newU0AttrIn = newU0AttrIn_i;
always @(posedge CB)
    begin
    casez(LSA_E1_i & LSA_E2_i)
     1'b0: {LSA_cacheableL2,newU0AttrIn_i, LSA_loadL2, LSA_guardedL2} <= {LSA_cacheableL2,newU0AttrIn_i, LSA_loadL2, LSA_guardedL2};
     1'b1: {LSA_cacheableL2,newU0AttrIn_i, LSA_loadL2, LSA_guardedL2} <= {carOF_cacheableL2,carOF_U0AttrL2, LSA_load_In, carOF_guardedL2};
      default: {LSA_cacheableL2,newU0AttrIn_i, LSA_loadL2, LSA_guardedL2} <= 4'bx;
    endcase
   end
// Removed the module 'dp_regDCU_carOF_bits'

//newedit3
wire [0:14] MikecareOfBit;
assign MikecareOfBit={carOF_byteEn[0:3], carOF_cacheableL2, carOF_writeThruL2,
     carOF_guardedL2, carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2,
     carOF_dcbzCmdL2, carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2};
//newedit3 end

always @(DCU_carByteEn_i or CAR_cacheableBuf2 or CAR_writethru or CAR_guarded or CAR_U0Attr or cacheOpBusL2 or
         hit_a_buf1 or hit_b_buf1 or OCM_dsHold or carDcbzCmd or reset2L2)
    begin
    casez(reset2L2)
     1'b0: regDCU_carOF_bits_muxout = {DCU_carByteEn_i[0:3],
     CAR_cacheableBuf2, CAR_writethru, CAR_guarded, CAR_U0Attr, cacheOpBusL2[0:2], carDcbzCmd,
     hit_a_buf1, hit_b_buf1, OCM_dsHold};
     1'b1: regDCU_carOF_bits_muxout = 15'b0;
      default: regDCU_carOF_bits_muxout = 15'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(CAR_OF_E1_i & CAR_OF_E2_i)
     1'b0: {carOF_byteEn[0:3], carOF_cacheableL2, carOF_writeThruL2, carOF_guardedL2,
            carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2, carOF_dcbzCmdL2,
            carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2} <=
           {carOF_byteEn[0:3], carOF_cacheableL2, carOF_writeThruL2, carOF_guardedL2,
            carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2, carOF_dcbzCmdL2,
            carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2};
     1'b1: {carOF_byteEn[0:3], carOF_cacheableL2, carOF_writeThruL2, carOF_guardedL2,
            carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2, carOF_dcbzCmdL2,
            carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2} <= regDCU_carOF_bits_muxout;
      default: {carOF_byteEn[0:3], carOF_cacheableL2, carOF_writeThruL2, carOF_guardedL2,
                carOF_U0AttrL2, carOF_loadL2, carOF_storeL2, carOF_dcbtL2, carOF_dcbzCmdL2,
                carOF_hitAL2,carOF_hitBL2, carOF_dsHoldL2} <= 15'bx;
    endcase
   end

// Removed the module 'dp_regDCU_stateMachine'
//newedit4
wire [0:19] MikestateMachine;
assign MikestateMachine={carFullL2,carFull2L2, storeWritingL2, fillSM[0:5],
       fillSM2[0:5], fillSM3_pend, LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2};
//newedit4 end


assign oneFPL2 = oneFPL2_i;
always @(carFullIn or carFullIn or storeWriting_In or fillSM_In or fillSM_In or
         fillSM_In or LSA_SM_In or FAR_full_In or oneFP_In or twoFP_In or reset2L2)
    begin
    casez(reset2L2)
     1'b0: regDCU_stateMachine_muxout = {carFullIn, carFullIn,
     storeWriting_In, fillSM_In[0:5], fillSM_In[0:5], fillSM_In[1], LSA_SM_In, FAR_full_In,
     oneFP_In, twoFP_In};
     1'b1: regDCU_stateMachine_muxout =  {1'b0, 1'b0, 1'b0,
     1'b1, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b1, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};
      default: regDCU_stateMachine_muxout = 20'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(cmdInProg_E2)
     1'b0: {carFullL2,carFull2L2, storeWritingL2, fillSM[0:5], fillSM2[0:5], fillSM3_pend,
            LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2} <=
           {carFullL2,carFull2L2, storeWritingL2, fillSM[0:5], fillSM2[0:5], fillSM3_pend,
            LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2};
     1'b1: {carFullL2,carFull2L2, storeWritingL2, fillSM[0:5], fillSM2[0:5], fillSM3_pend,
            LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2} <= regDCU_stateMachine_muxout;
      default: {carFullL2,carFull2L2, storeWritingL2, fillSM[0:5], fillSM2[0:5], fillSM3_pend,
                LSA_SM, FAR_fullL2,oneFPL2_i, twoFPL2} <= 20'bx;
    endcase
   end

// Removed the module 'dp_regDCU_cacheOpByteEn'
//newedit5
wire [0:15] MikecacheByteEn;
assign MikecacheByteEn={carLoadDup, carStoreDup, cacheOpBusL2[0:9],DCU_carByteEn_i[0:3]};
//newedit5 end


always @(PCL_dcuOp or PCL_dcuByteEn or cacheOpMuxSel)
    begin
    casez(cacheOpMuxSel)
     1'b0: regDCU_cacheOpByteEn_muxout = {PCL_dcuOp[1],
     PCL_dcuOp[2], PCL_dcuOp[1:10], PCL_dcuByteEn[0:3]};
     1'b1: regDCU_cacheOpByteEn_muxout = 16'b0;
      default: regDCU_cacheOpByteEn_muxout = 16'bx;
    endcase
   end
   // L2 Output modeled as posedge FF
   always @(posedge CB)
    begin
    casez(cacheOpByteEn_E1 & cacheOpByteEn_E2)
     1'b0: {carLoadDup, carStoreDup, cacheOpBusL2[0:9],DCU_carByteEn_i[0:3]} <=
           {carLoadDup, carStoreDup, cacheOpBusL2[0:9],DCU_carByteEn_i[0:3]};
     1'b1: {carLoadDup, carStoreDup, cacheOpBusL2[0:9],DCU_carByteEn_i[0:3]} <= regDCU_cacheOpByteEn_muxout;
      default: {carLoadDup, carStoreDup, cacheOpBusL2[0:9],DCU_carByteEn_i[0:3]} <= 16'bx;
    endcase
   end
// Removed the module 'dp_regDCU_xltValid'
reg xltValidL2, xltValidDupL2;
always @(posedge CB)
    begin
    casez(xltValidLth_E2)
     1'b0: {xltValidL2, xltValidDupL2} <= {xltValidL2, xltValidDupL2};
     1'b1: {xltValidL2, xltValidDupL2} <= {MMU_dcuXltValid,MMU_dcuXltValid};
      default: {xltValidL2, xltValidDupL2} <= 2'bx;
    endcase
   end
// Removed the module 'dp_regDCU_PLBAR'
assign {DCU_cacheableL2, DCU_guardedL2, DCU_RNWL2, DCU_RNW_dupInvL2, DCU_tranSizeL2,
        DCU_tranSize_dupInvL2, DCU_dTagsL2[0:7], DCU_writeThruL2, DCU_U0AttrL2}
   =  ~(regDCU_PLBAR_L2[0:15]);
always @(posedge CB)
    begin
    casez(PLBAR_E1_i & PLBAR_E2_i)
     1'b0: regDCU_PLBAR_L2 <= regDCU_PLBAR_L2;
     1'b1: regDCU_PLBAR_L2 <= {DCU_cacheable_In, DCU_guarded_In,
     DCU_RNW_In, DCU_RNW_In, DCU_plbtranSize_In, DCU_plbtranSize_In, DCU_byteEn_In[0:7],
     DCU_writeThru_In, DCU_U0Attr_In};
      default: regDCU_PLBAR_L2 <= 16'bx;
    endcase
   end

p405s_DCU_logic
 DCU_logicFun(
  .SDQ_E1(SDQ_E1),
  .SDQ_E2(SDQ_E2),
  .DCU_CA(DCU_CA_i),
  .tagIndex_E1(tagIndex_E1),
  .twoFP_In(twoFP_In),
  .CAR_mmuAttr_E1(CAR_mmuAttr_E1),
  .CAR_mmuAttr_E2(CAR_mmuAttr_E2),
  .dataIndexMuxSel(dataIndexMuxSel[0:1]),
  .forceDataIndexZero_mmu(forceDataIndexZero_mmu),
  .dataIndexMuxSel2(dataIndexMuxSel2),
  .dataIndex_E2(dataIndex_E2),
  .xltValidLth_E2(xltValidLth_E2),
  .LRU_sel0(LRU_sel0),
  .newValidIn(newValidIn),
  .FAR_E2(FAR_E2),
  .newDirtyIn(newDirtyIn),
  .DCU_U0Attr_In(DCU_U0Attr_In),
  .tagIndexDup_E1(tagIndexDup_E1),
  .tagIndexDup_E2(tagIndexDup_E2),
  .writeTagA0(writeTagA0),
  .dirtyLRU_readIndexSel(dirtyLRU_readIndexSel),
  .writeDataA0(writeDataA0),
  .writeDataA1(writeDataA1),
  .writeDirtyA0(writeDirtyA0),
  .writeDirtyB0(writeDirtyB0),
  .dOutMuxSelBit1Byte0(dOutMuxSelBit1Byte0),
  .LRU_sel1(LRU_sel1),
  .dOutMuxSelBit1Byte1(dOutMuxSelBit1Byte1),
  .dOutMuxSelBit1Byte2(dOutMuxSelBit1Byte2),
  .dOutMuxSelBit1Byte3(dOutMuxSelBit1Byte3),
  .flush2ndRead_In(flush2ndRead_In),
  .FDR_lo_E2(FDR_lo_E2),
  .storeWord_In(storeWord_In),
  .carFullIn(carFullIn),
  .storeWriting_In(storeWriting_In),
  .past1stCycXltValid_In(past1stCycXltValid_In),
  .writeBufMuxSelBit0(writeBufMuxSelBit0),
  .WB_lineDirtyIn(WB_lineDirtyIn),
  .wrAckCnt_In0X(wrAckCnt_In0X[0:2]),
  .writeBufHi_E2(writeBufHi_E2[0:3]),
  .CAR_OF_E2(CAR_OF_E2_i),
  .writeDirtyB1(writeDirtyB1),
  .CAR_OF_full_In0(CAR_OF_full_In0),
  .FDR_hi_E1(FDR_hi_E1),
  .FDR_hi_E2(FDR_hi_E2),
  .FDR_lo_E1(FDR_lo_E1),
  .cacheOpMuxSel(cacheOpMuxSel),
  .resetIn(resetIn),
  .FDR_hiMuxSel(FDR_hiMuxSel),
  .FDR_holdMuxSel(FDR_holdMuxSel),
  .flushHold_E2(flushHold_E2),
  .SDP_FDR_muxSel(SDP_FDR_muxSel),
  .wrAckQ_full_Inx1(wrAckQ_full_Inx1),
  .PLBDR_hiMuxSel(PLBDR_hiMuxSel[0:3]),
  .wrAckQ_full_In10(wrAckQ_full_In10),
  .wrAckQ_sizeTran_E1(wrAckQ_sizeTran_E1),
  .wrAckQ_full_In00(wrAckQ_full_In00),
  .bypassMuxSel(bypassMuxSel[0:2]),
  .fillBufMuxSel0(fillBufMuxSel0[0:31]),
  .sel_CAR_OF_full(sel_CAR_OF_full),
  .fillValid_In(fillValid_In[0:31]),
  .LSA_E2(LSA_E2_i),
  .fillSM_In(fillSM_In[0:5]),
  .FAR_full_In(FAR_full_In),
  .FAR_loadPending_In(FAR_loadPending_In),
  .dVQ_In11(dVQ_In11[0:6]),
  .PLBAR_selSAQ(PLBAR_selSAQ),
  .PLBAR_E2(PLBAR_E2_i),
  .writeDirtyA1(writeDirtyA1),
  .oneFP_In(oneFP_In),
  .fillBuf_E2(fillBuf_E2[0:7]),
  .LSA_SM_In(LSA_SM_In),
  .CAR_OF_PLB_loaded_In(CAR_OF_PLB_loaded_In),
  .DCU_request_In(DCU_request_In),
  .xltValidLth(xltValidLth),
  .SAQvalidNeedingPLB0(SAQvalidNeedingPLB0),
  .storeHitPend_In0(storeHitPend_In0[0:1]),
  .SAQ_E2(SAQ_E2_i),
  .dirtyLRU_writeIndex_E1(dirtyLRU_writeIndex_E1),
  .writeTagB0(writeTagB0),
  .DCU_sleepReq(DCU_sleepReq),
  .byteWriteData(byteWriteData[0:15]),
  .dValidCnt1_In(dValidCnt1_In[0:2]),
  .wrAckCnt1_In(wrAckCnt1_In[0:2]),
  .dValidCntDone_In(dValidCntDone_In),
  .wrAckCntDone_In(wrAckCntDone_In),
  .fillFlushToDo_In(fillFlushToDo_In),
  .twoLoadPending_0_In(twoLoadPending_0_In),
  .fillLineDirty_In(fillLineDirty_In),
  .tagIndexSel(tagIndexSel),
  .dcbzFillHit_In(dcbzFillHit_In),
  .PLBAR_E1(PLBAR_E1_i),
  .SDQ_SDP_mux(SDQ_SDP_mux),
  .LSA_load_In(LSA_load_In),
  .priority_In(priority_In),
  .DCU_guarded_In(DCU_guarded_In),
  .DCU_RNW_In(DCU_RNW_In),
  .dcbzFillHitA_In(dcbzFillHitA_In),
  .writeBufLoTag_E1(writeBufLoTag_E1),
  .DCU_tranSize_In(DCU_plbtranSize_In),
  .DCU_cacheable_In(DCU_cacheable_In),
  .SAQ_E1(SAQ_E1_i),
  .DCU_plbAddrBus_In(DCU_plbAddrBus_In[30:31]),
  .cacheOpByteEn_E2(cacheOpByteEn_E2),
  .DCU_writeThru_In(DCU_writeThru_In),
  .cmdInProg_E2(cmdInProg_E2),
  .dirtyLRU_readIndex_E1(dirtyLRU_readIndex_E1),
  .SAQvalidNeedingPLB1(SAQvalidNeedingPLB1),
  .DCU_byteEn_In(DCU_byteEn_In[0:7]),
  .ocmAbort(ocmAbort),
  .ocmLoadReq(ocmLoadReq),
  .ocmStoreReq(ocmStoreReq),
  .bypassFillSDP_sel(bypassFillSDP_sel[0:3]),
  .dcu_DA_sel(dcu_DA_sel),
  .DCU_ocmWait_In0(DCU_ocmWait_In0),
  .carSpecialOp_In(carSpecialOp_In),
  .writeBufHi_E1(writeBufHi_E1),
  .caEarly_0_In(caEarly_0_In),
  .DCUbypassPending_In0(DCUbypassPending_In0),
  .cacheableSpecialOp(cacheableSpecialOp),
  .DCU_someBusy_In(DCU_someBusy_In),
  .fill_A_In(fill_a),
  .carTwoFP_In(carTwoFP_In),
  .LSA_bypassPending_In(LSA_bypassPending_In),
  .cacheOpByteEn_E1(cacheOpByteEn_E1),
  .FDR_outMuxSel(FDR_outMuxSel[0:1]),
  .carRead_In(carRead_In),
  .fillUsingArray(fillUsingArray),
  .CAR_OF_E1(CAR_OF_E1_i),
  .fillBufMuxSel1(fillBufMuxSel1[0:31]),
  .PLBAR_selFAR(PLBAR_selFAR),
  .writeBufMuxSelBit1(writeBufMuxSelBit1[0:31]),
  .tagOutMuxSelFAR(tagOutMuxSelFAR),
  .specialOPDone_In(specialOPDone_In),
  .fillBuf_E1(fillBuf_E1),
  .specialCase_In(specialCase_In),
  .tagReadWriteCycle_In(tagReadWriteCycle_In),
  .writeLRU1(writeLRU1),
  .tagReadNotWrite_In(tagReadNotWrite_In),
  .dataReadWriteCycle_In(dataReadWriteCycle_In),
  .carDcbzCmd(carDcbzCmd),
  .DCU_firstCycCarStXltV(DCU_firstCycCarStXltV),
  .PLBDR_E2(PLBDR_E2[0:3]),
  .writeTagB1(writeTagB1),
  .dVQ_In00(dVQ_In00[0:6]),
  .dVQ_In01(dVQ_In01[0:6]),
  .LSA_E1(LSA_E1_i),
  .dVQ_In10(dVQ_In10[0:6]),
  .FDR_loMuxSel(FDR_loMuxSel),
  .LRU_out_NEG(LRU_out_NEG),
  .writeLRU0(writeLRU0),
  .writeDataB0(writeDataB0),
  .writeDataB1(writeDataB1),
  .dataReadNotWrite_In(dataReadNotWrite_In),
  .writeTagA1(writeTagA1),
  .DCU_ocmWait_In1(DCU_ocmWait_In1),
  .dcu_DA_early_NEG(dcu_DA_early_NEG),
  .readLRUDirty(readLRUDirtyPre),
  .wrAckSelInc2_11(wrAckSelInc2_11),
  .setDValidCntIdle(setDValidCntIdle),
  .wrAckCnt2_In(wrAckCnt2_In[0:2]),
  .dValidCnt2_In(dValidCnt2_In[0:2]),
  .dValidCntSel(dValidCntSel[0:1]),
  .wrAckSelInc2_10(wrAckSelInc2_10),
  .DCUbypassPending_In1(DCUbypassPending_In1),
  .set_storeHitPend1(set_storeHitPend1[0:1]),
  .byteWrite_E1(byteWrite_E1),
  .dataIndex_E1(dataIndex_E1),
  .dirtyLRU_readIndex_E2(dirtyLRU_readIndex_E2),
  .DCU_pclOcmLdPendNoWait(DCU_pclOcmLdPendNoWait),
  .SDQ_SDP_OCM_sel(SDQ_SDP_OCM_sel),
  .writeBufLo_E2(writeBufLo_E2),
  .storeHitFillBufPend_In(storeHitFillBufPend_In),
  .dataIndexLSA_dupSel(dataIndexLSA_dupSel),
  .loadReadFBvalid(loadReadFBvalid),
  .bypassPendOrDcRead(bypassPendOrDcRead),
  .twoLoadPending_1_In(twoLoadPending_1_In),
  .caEarly_1_In(caEarly_1_In),
  .fillFollowedByFill_In(fillFollowedByFill_In),
//--------- start ---------------
// rgoldiez - bringing the carDcRead signal over to the dataflow block for dcreads
//            bringing the flushIdle_state for parity errors on flushes
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
  .carDcRead(carDcRead),
  .flushIdle_state(flushIdle_state),
  .flushAlmostDone(flushAlmostDone),
  .flushDone(flushDone),
//--------- end ----------------
  .ocmCompleteXltVNoWaitNoHold(ocmCompleteXltVNoWaitNoHold), // added for issue 206
  .CAR_OF_fullL2(CAR_OF_fullL2),
  .dcbzFillHitA_L2(dcbzFillHitA_L2),
  .fillFlushToDoL2(fillFlushToDoL2_i),
  .past1stCycXltValidL2(past1stCycXltValidL2),
  .carFullL2(carFullL2),
  .dVQ0_sizeL2(dVQ0_sizeL2),
  .fillSM(fillSM[0:5]),
  .storeWritingL2(storeWritingL2),
  .xltValidL2(xltValidL2),
  .VCT_exeAbort(VCT_exeAbort),
  .VCT_wbAbort(VCT_wbAbort),
  .storeHitPendDupL2(storeHitPendDupL2[0:1]),
  .MMU_dcuShadowAbort(MMU_dcuShadowAbort),
  .CAR_cacheableBuf1(CAR_cacheableBuf1),
  .fill_A_L2(fill_A_L2),
  .SAQ_byteEn(SAQ_byteEn[0:3]),
  .storeHitPendL2(storeHitPendL2[0:1]),
  .carOF_U0AttrL2(carOF_U0AttrL2),
  .dcbzFillHitL2(dcbzFillHitL2),
  .ICU_dcuCCR0_L2(ICU_dcuCCR0_L2[0:10]),
  .twoLoadPendingL2L2(twoLoadPendingL2L2),
  .carOF_LSAcmp(carOF_LSAcmp),
  .U0AttrFAR(U0AttrFAR),
  .carOF_FARcmp(carOF_FARcmp),
  .PCL_dcuOp(PCL_dcuOp[0:11]),
  .cacheOpBusL2(cacheOpBusL2[0:9]),
  .carOF_loadL2(carOF_loadL2),
  .carOF_storeL2(carOF_storeL2),
  .carOF_dcbzCmdL2(carOF_dcbzCmdL2),
  .carOF_dcbtL2(carOF_dcbtL2),
  .carOF_cacheableL2(carOF_cacheableL2),
  .carOF_writeThruL2(carOF_writeThruL2),
  .carOF_hitAL2(carOF_hitAL2),
  .carOF_hitBL2(carOF_hitBL2),
  .carOF_byteEn(carOF_byteEn[0:3]),
  .OCM_dsComplete(OCM_dsComplete),
  .resetL2(resetL2),
  .validA(validA),
  .validB(validB),
  .LRU(LRU),
  .specialCaseL2(specialCaseL2),
  .dirtyA(dirtyA),
  .dirtyB(dirtyB),
  .hit_a(hit_a),
  .hit_b(hit_b),
  .WB_lineDirtyReadL2(WB_lineDirtyReadL2),
  .fillLineDirtyL2(fillLineDirtyL2),
  .CAR_writethru(CAR_writethru),
  .SAQ_L2(SAQ_L2[27:29]),
  .CAR_L2_buf1(CAR_L2_buf1[27:29]),
  .dValidCntDoneL2(dValidCntDoneL2),
  .wrAckCntDoneL2(wrAckCntDoneL2),
  .wrAckCntL2(wrAckCntL2[0:2]),
  .carOF_dsHoldL2(carOF_dsHoldL2),
  .PLB_dcuSsizeBuf1(PLB_dcuSsizeBuf1),
  .PLB_dcuWrDAck(wrDAckBuf2),
  .LSA_cacheableL2(LSA_cacheableL2),
  .DCU_tranSize(DCU_tranSize_dupL2),
  .storeWordL2(storeWordL2),
  .resetSCL2(resetSCL2),
  .DCU_plbRNW_dupL2(DCU_RNW_dupL2),
  .LSA_L2(LSA_L2[27:29]),
  .dVQ1_fullL2(dVQ1_fullL2),
  .CAR_OF_L2(CAR_OF_L2[27:29]),
  .fillValidL2(fillValidL2[0:31]),
  .PLB_dcuRdDAck(rdDAckBuf1),
  .FAR_fullL2(FAR_fullL2),
  .FAR_loadPendingL2(FAR_loadPendingL2),
  .PLB_dcuRdWdAddr(rdWdAddrBuf[0:2]),
  .oneFPL2(oneFPL2_i),
  .LSA_SM(LSA_SM),
  .CAR_OF_PLB_loadedL2(CAR_OF_PLB_loadedL2),
  .DCU_requestDupL2(DCU_requestDupL2),
  .SAQ_writeThruL2(SAQ_writeThruL2),
  .dVQ1_lineL2(dVQ1_lineL2),
  .SAQvalidNeedingPLBL2(SAQvalidNeedingPLBL2),
  .dValidCntL2(dValidCntL2[0:2]),
  .twoLoadPendingL2(twoLoadPendingL2),
  .sampleCycleL2(sampleCycleBuf3),
  .carByteEn(DCU_carByteEn_i[0:3]),
  .twoFPL2(twoFPL2),
  .LSA_loadL2(LSA_loadL2),
  .CAR_LSAcmp(CAR_LSAcmp),
  .dVQ1_sizeL2(dVQ1_sizeL2),
  .SAQ_cacheableL2(SAQ_cacheableL2),
  .ICU_syncAfterReset(ICU_syncAfterReset),
  .dVQ0_fullL2(dVQ0_fullL2[0:1]),
  .carOF_guardedL2(carOF_guardedL2),
  .SAQ_FARcmp(SAQ_FARcmp),
  .wrAckQ_sizeL2(wrAckQ_sizeL2),
  .SAQ_guardedL2(SAQ_guardedL2),
  .SAQ_U0AttrL2(SAQ_U0AttrL2),
  .DCU_someBusyL2(DCU_someBusyL2),
  .OCM_dsHold(OCM_dsHold),
  .MMU_wbHold(MMU_wbHold),
  .CAR_SAQcmp(CAR_SAQcmp),
  .carSpecialOpL2(carSpecialOpL2),
  .caEarlyL2(caEarlyL2),
  .DCUbypassPendingL2(DCUbypassPendingL2),
  .DCU_ocmWait(DCU_ocmWaitL2),
  .dVQ0_lineL2(dVQ0_lineL2),
  .busySCL2(busySCL2),
  .wrAckQ_fullL2(wrAckQ_fullL2),
  .wrAckQ_lineL2(wrAckQ_lineL2),
  .carTwoFPL2(carTwoFPL2),
  .LSA_bypassPendingL2(LSA_bypassPendingL2),
  .carReadL2(carReadL2),
  .resetCore(resetCore),
  .specialOPDoneL2(specialOPDoneL2),
  .MMU_dcuUTLBAbortL2(MMU_dcuUTLBAbortL2),
  .flush2ndReadL2(flush2ndReadL2),
  .storeHitFillBufPendL2(storeHitFillBufPendL2),
  .PLB_dcuRdDAck2(rdDAckBuf2),
  .dValidCntDone2L2(dValidCntDone2L2),
  .fillSM2(fillSM2[0:5]),
  .CAR_OF_full2L2(CAR_OF_full2L2),
  .CAR_cacheableBuf2(CAR_cacheableBuf2),
  .reset4L2(reset4L2),
  .PCL_dcuOp_early(PCL_dcuOp_early[0:2]),
  .CAR_cacheableNoBuf(CAR_cacheable),
  .xltValidDupL2(xltValidDupL2),
  .testEn(testEn),
  .LSA_guardedL2(LSA_guardedL2),
  .carFull2L2(carFull2L2),
  .fillFollowedByFillL2(fillFollowedByFillL2),
  .PLB_dcuWrDAckBuf(wrDAckBuf),
  .PLB_dcuRdDAck3(rdDAckBuf3),
  .carLoadDup(carLoadDup),
  .carStoreDup(carStoreDup),
  .CAR_L2_buf2(CAR_L2_buf2[27:29]),
  .PLB_dcuSsizeBuf2(PLB_dcuSsizeBuf2),
  .SAQvalidNeedingPLB2L2(SAQvalidNeedingPLB2L2),
  .fillSM3_pend(fillSM3_pend),
  .dValidCntDone3L2(dValidCntDone3L2));


endmodule

