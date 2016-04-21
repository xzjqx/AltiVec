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

module p405s_DCU_dataFlow( CAR_L2_buf1,
                           CAR_L2_buf2,
                           CAR_LSAcmp,
                           CAR_OF_L2,
                           CAR_SAQcmp,
                           DCU_SDQ_mod_NEG,
                           DCU_data_NEG,
                           DCU_icuSize,
                           DCU_ocmData,
                           DCU_plbABus,
                           DCU_plbDBus,
                           LRU,
                           LSA_L2,
                           SAQ_FARcmp,
                           SAQ_L2,
                           U0AttrFAR,
                           carOF_FARcmp,
                           carOF_LSAcmp,
                           dirtyA,
                           dirtyB,
                           hit_a,
                           hit_a_buf1,
                           hit_b,
                           hit_b_buf1,
                           validA,
                           validB,
                           DCU_parityError,
                           CAR_OF_E1,
                           CAR_OF_E2,
                           CAR_endian,
                           CAR_mmuAttr_E1,
                           CAR_mmuAttr_E2,
                           CB,
                           EXE_dcuData,
                           FAR_E2,
                           FDR_hiMuxSel,
                           FDR_hi_E1,
                           FDR_hi_E2,
                           FDR_holdMuxSel,
                           FDR_loMuxSel,
                           FDR_lo_E1,
                           FDR_lo_E2,
                           FDR_outMuxSel,
                           ICU_dcuCCR0_L2_bit10,
                           ICU_dcuCCR0_L2_bit11,
                           LSA_E1,
                           LSA_E2,
                           MMU_diagOut,
                           MMU_dsRA,
                           PCL_stSteerCntl,
                           PLBAR_E1,
                           PLBAR_E2,
                           PLBAR_selFAR,
                           PLBAR_selSAQ,
                           PLBDR_E2,
                           PLBDR_hiMuxSel,
                           PLB_dcuReadDataBus,
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
                           testEn,
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
                           carDcRead,
                           flushIdle_state,
                           flushAlmostDone,
                           flushDone,
                           fillFlushToDoL2,
                           resetCore,
                           DCU_DA,
                           DCU_FlushParityError,
                           oneFPL2,
                           ocmCompleteXltVNoWaitNoHold,
                           ICU_CCR1DCTE,
                           ICU_CCR1DCDE,
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

output  CAR_LSAcmp;
output  CAR_SAQcmp;
output  LRU;
output  SAQ_FARcmp;
output  U0AttrFAR;
output  carOF_FARcmp;
output  carOF_LSAcmp;
output  dirtyA;
output  dirtyB;
output  hit_a;
output  hit_a_buf1;
output  hit_b;
output  hit_b_buf1;
output  validA;
output  validB;
output  DCU_parityError;
output  DCU_FlushParityError;

//--------- end ----------------

input  ocmCompleteXltVNoWaitNoHold;  // added for issue 206

// new cu11 test requirements


//--------- start ---------------
// rgoldiez - added the CCR0[28] (which comes across from the ICU as bit 11) for chosing parity
//              on dcreads
//            added CCR[27] (which comes across from the ICU as bit 9) which selects tag or data on a dcread
//            added carDcRead for selection help of parity/data on dcreads
//            added flushIdle_state for parity errors on castouts/flushes
//            added resetCore for parity error registers for castouts/flushes
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement

input  CAR_OF_E1;
input  CAR_OF_E2;
input  CAR_endian;
input  CAR_mmuAttr_E1;
input  CAR_mmuAttr_E2;
input  FAR_E2;
input  FDR_hiMuxSel;
input  FDR_hi_E1;
input  FDR_hi_E2;
input  FDR_holdMuxSel;
input  FDR_loMuxSel;
input  FDR_lo_E1;
input  FDR_lo_E2;
input  ICU_dcuCCR0_L2_bit10;
input  ICU_dcuCCR0_L2_bit11;
input  LSA_E1;
input  LSA_E2;
input  PLBAR_E1;
input  PLBAR_E2;
input  PLBAR_selFAR;
input  PLBAR_selSAQ;
input  SAQ_E1;
input  SAQ_E2;
input  SDP_FDR_muxSel;
input  SDQ_E1;
input  SDQ_E2;
input  SDQ_SDP_OCM_sel;
input  SDQ_SDP_mux;
input  bypassPendOrDcRead;
input  byteWrite_E1;
input  cacheableSpecialOp;
input  carStore;
input  dOutMuxSelBit1Byte0;
input  dOutMuxSelBit1Byte1;
input  dOutMuxSelBit1Byte2;
input  dOutMuxSelBit1Byte3;
input  dataIndexLSA_dupSel;
input  dataIndexMuxSel2;
input  dataIndex_E1;
input  dataIndex_E2;
input  dataReadNotWrite_In;
input  dataReadWriteCycle_In;
input  dirtyLRU_readIndexSel;
input  dirtyLRU_readIndex_E1;
input  dirtyLRU_readIndex_E2;
input  dirtyLRU_writeIndex_E1;
input  fillBuf_E1;
input  fillUsingArray;
input  flushHold_E2;
input  forceDataIndexZero_mmu;
input  loadReadFBvalid;
input  newDirty;
input  newLRU;
input  newU0AttrIn;
input  newValidIn;
input  readLRUDirty;
input  sampleCycleL2;
input  tagIndexDup_E1;
input  tagIndexDup_E2;
input  tagIndexSel;
input  tagIndex_E1;
input  tagOutMuxSelFAR;
input  tagReadNotWrite_In;
input  tagReadWriteCycle_In;
input  testEn;
input  writeBufHi_E1;
input  writeBufLoTag_E1;
input  writeBufLo_E2;
input  writeBufMuxSelBit0;
input  writeDataA0;
input  writeDataA1;
input  writeDataB0;
input  writeDataB1;
input  writeDirtyA;
input  writeDirtyB;
input  writeLRU;
input  writeTagA0;
input  writeTagA1;
input  writeTagB0;
input  writeTagB1;
input  xltValidLth;
input  carDcRead;
input  flushIdle_state;
input  flushAlmostDone;
input  flushDone;
input  fillFlushToDoL2;
input  oneFPL2;
input  resetCore;
input  DCU_DA;

input  ICU_CCR1DCTE;
input  ICU_CCR1DCDE; // added for parity injection

//--------- end ----------------

//--------- start ---------------
// rgoldiez - added these signals for ICU BIST connection
//--------- end ----------------

output [0:31]  DCU_ocmData;
output [27:29]  CAR_L2_buf1;
output [27:29]  SAQ_L2;
output [27:29]  CAR_OF_L2;
output [0:29]  DCU_plbABus;
output [27:29]  LSA_L2;
output [27:29]  CAR_L2_buf2;
output [0:2]  DCU_icuSize;
output [0:31]  DCU_data_NEG;
output [0:63]  DCU_plbDBus;
output [0:31]  DCU_SDQ_mod_NEG;

input [0:3]  writeBufHi_E2;
input [0:31]  fillBufMuxSel1;
input [0:63]  PLB_dcuReadDataBus;
input [0:3]  PLBDR_hiMuxSel;
input [0:7]  fillBuf_E2;
input [0:31]  writeBufMuxSelBit1;
input [0:31]  EXE_dcuData;
input [0:15]  byteWriteData;
input [0:29]  MMU_dsRA;
input [0:1]  FDR_outMuxSel;
input [0:2]  MMU_diagOut;
input CB;
input [0:31]  fillBufMuxSel0;
input [0:2]  bypassMuxSel;
input [0:3]  bypassFillSDP_sel;
input [0:3]  PLBDR_E2;
input [0:1]  dataIndexMuxSel;
input [0:9]  PCL_stSteerCntl;

input        resetMemBist;    // sync reset for dcu mbist

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

wire  [0:31]  holdDataRegWord3_L2;
wire  [0:31]  holdDataRegWord0_L2;
wire  [0:63]  FDR_L2mux;
wire  [0:23]  tagB_inv;
wire  [0:23]  tagA_inv;
wire  [0:3]  FDR_holdMuxSelBuf;
wire  [0:3]  FDR_loBuf_E1;
wire  [0:21]  outFAR_inv;
wire  [0:31]  wordMuxA;
wire  [0:3]  FDR_hiBuf_E1;
wire  [0:3]  flush_holdBuf;
wire  [0:127]  dataOutPos_B;
wire  [0:127]  dataOutPos_A;
wire  [0:31]  holdDataRegWord2_L2;
wire  [0:31]  holdDataRegWord1_L2;
wire  [0:23]  tagMuxOut;
wire  [0:31]  wordMuxB;
wire  [0:31]  DCU_SDQ_modified;
reg   [0:31]  SDQ_L2;
wire  [0:29]  PLB_ARmuxOut;
wire  [0:20]  tagMuxOutFAR;
reg   [0:29]  DCU_plbABus_i;
wire  [0:29]  DCU_plbABus;
wire  [0:29]  plbABusNeg;
// Changed to match Prowler mods:  RDE 04/11/00
// wire  [0:4]  wbTag2noConn;
reg   [0:5]  wbTag2noConn;
reg   [0:15]  wbTag1noConn;
wire  [0:29]  LSA_inv;
wire  [0:31]  SDP_inv;
wire  [28:29]  CAR_buf3;
reg   [0:31]  SDP_data;
wire  [28:29]  CAR_buf2;
wire  [0:29]  FAR_OF;
wire  [0:31]  SDQ_SDP_muxOcm;
wire  [0:31]  SDQ_SDP_muxOut;
wire  [0:31]  fillBufWord1_L2;
wire  [0:31]  fillBufWord2_L2;
wire  [0:31]  fillBufWord3_L2;
wire  [0:31]  fillBufWord5_L2;
wire  [0:31]  fillBufWord6_L2;
wire  [0:31]  fillBufWord7_L2;
wire  [0:31]  fillBufWord4_L2;
reg   [0:20]  wbTagL1;
wire  [0:31]  SDP_buf;
wire  [0:20]  CAR_bufComp;
wire  [0:31]  SDQ_SDP_muxBuf;
wire  [0:31]  SDQ_SDP_muxBuf_Neg;
wire  [0:31]  fillBufWord0_L2;
wire  [0:20]  CAR_L2_NEG_mod;
wire  [0:31]  WB_word2L2;
wire  [0:31]  WB_word1L2;
wire  [0:31]  WB_word3L2;
wire  [0:31]  WB_word0L2;
wire  [0:9]  dataIndexMuxPre;
wire  [0:3]  bypassFillSDQ_selMod;
wire  [0:8]  dirtyLRUwriteIndexL2;
wire  [0:8]  dirtyLRUreadIndexL2;
reg   [0:9]  dataIndexOutB;
reg   [0:9]  dataIndexOutA;
wire  [0:9]  tagIndexOut;
reg   [0:9]  tagIndexIn_NEG;
reg   [0:9]  dataIndexIn_NEG;
wire  [0:9]  dataIndexDupDly;
wire  [0:9]  dataIndexDly1;
wire  [18:27]  SAQDly;
wire  [0:9]  SAQDly1;
wire  [0:9]  LSADly;
wire  [0:9]  tagLSADly1;
wire  [0:9]  tagIndexDly1;
wire  [0:9]  tagCARDly1;
reg   [0:8]  dirtyLRUreadIndexNEG;
wire  [0:9]  dataIndexIn_buf;
reg   [0:9]  dataIndexDup;
wire  [0:9]  dataIndexMuxLSA_dup;
wire  [0:3]  dOutMuxSelNoHit;
wire  [27:29]  CAR_buf;
wire  [18:26]  CAR_buf_index;
wire  [0:9]  tagIndexDupDly;
wire  [0:9]  tagCARDly;
reg   [0:9]  tagIndexOutDup;
reg   [0:8]  dirtyLRU_indexIn_NEG;
reg   [0:26]  FAR_L2;
wire  [0:29]  CAR_L2_NEG;
wire  [0:127]  dataOut_B;
wire  [0:127]  dataOut_A;
wire  [0:31]  bypassMuxOut;
wire  [0:20]  tagAOut;
wire  [0:20]  tagBOut;
reg   [0:29]  CAR_L2;
reg   [0:29]  CAR_OF_L2_i;

//--------- start ---------------
// rgoldiez - wires added for parity data flow

wire  [0:3]  p_EXE_dcuData;
wire  [0:3]  p_SDQ_L2;
wire  [0:3]  p_DCU_SDQ_modified;
wire  [0:3]  p_SDP_buf;
wire  [0:3]  p_SDP_inv;
wire  [0:3]  p_SDP_data;
wire  [0:3]  p_SDQ_SDP_muxOut;
wire  [0:3]  p_SDQ_SDP_muxOut_Neg;
wire  [0:3]  p_SDQ_SDP_muxBuf;
wire  [0:15] p_dataOutA;
wire  [0:15] p_dataOutB;
wire  [0:15] p_WBhi_L2;
wire  [0:9]  p_dataIndexOutP;
wire  [0:31] p_fillBuf_L2;
wire  [0:31] dcReadTag;
wire  [0:31] wordMuxAwoParity;
wire  [0:31] wordMuxBwoParity;
wire         p_tagParityOut;
wire         p_tagParityOutGated;
wire  [0:3]  p_aSideLoadError;
wire  [0:3]  p_bSideLoadError;
wire  [0:3]  p_ramBypassA;
wire  [0:3]  p_ramBypassB;
wire  [0:3]  loadParityError;
wire  [0:15] p_dataErrorA;
wire  [0:15] p_dataErrorB;
wire         p_aSideErrorRaw;
wire         p_bSideErrorRaw;

//--------- end -----------------
// Add new wires after instantiation

wire tagParityError;
wire p_tagErrorA;
wire p_tagErrorB;
wire p_parityA;
wire p_parityB;
wire p_parityAInv;
wire p_parityBInv;
wire p_Injected_LSA;
wire p_LSA;
wire p_wbTagL1preValid;
wire writeBufLoTag_E1Buf;
wire dp_regDCU_wbTagP_D; 
wire dp_regDCU_wbTagP_E1; 
wire dOutMuxSelBit0Byte0;
wire dOutMuxSelBit0Byte1;
wire dOutMuxSelBit0Byte2;
wire dOutMuxSelBit0Byte3;
wire MMU_27_mod;
wire p_wbTagL1;
reg  wbU0AttrL1;

wire LRU_i;
reg  [0:29] SAQ_L2_i;
wire U0AttrA, U0AttrB, valid_A, valid_B;

wire p_holdDataReg_L2;
   
//--------- start ---------------
// rgoldiez - added the p_ IOs for the parity data to and from the parity array
// rgoldiez - added the p_ IOs for the parity data to and from the tag array
// pmcilmoyle - added the BIST_sysPF output

assign LRU = LRU_i;
wire dirtyA_i;
assign dirtyA = dirtyA_i;
wire dirtyB_i;
assign dirtyB = dirtyB_i;
wire hit_a_i;
assign hit_a = hit_a_i;
wire hit_b_i;
assign hit_b = hit_b_i;

p405s_DCU_ram16K
 ram ( 
     .DCU_icuSize            (DCU_icuSize[0:2]),
     .LRU                    (LRU_i),
     .U0AttrA                (U0AttrA),
     .U0AttrB                (U0AttrB),
     .dataOut_A              (dataOut_A[0:127]),
     .dataOut_B              (dataOut_B[0:127]),
     .p_dataOutA             (p_dataOutA[0:15]),
     .p_dataOutB             (p_dataOutB[0:15]),
     .dirtyA                 (dirtyA_i),
     .dirtyB                 (dirtyB_i),
     .hit_a                  (hit_a_i),
     .hit_a_buf1             (hit_a_buf1),
     .hit_b                  (hit_b_i),
     .hit_b_buf1             (hit_b_buf1),
     .tagAOut                (tagAOut[0:20]),
     .tagBOut                (tagBOut[0:20]),
     .p_parityA              (p_parityA),
     .p_parityB              (p_parityB),
     .validA                 (valid_A),
     .validB                 (valid_B),
     .CAR_L2                 (CAR_bufComp[0:20]),
     .CAR_L2_NEG             (CAR_L2_NEG_mod[0:20]),
     .CB                     (CB), 
     .MMU_diagOut            (MMU_diagOut[0:2]),
     .WB_L2                  ({WB_word0L2[0:31], WB_word1L2[0:31], 
                               WB_word2L2[0:31], WB_word3L2[0:31]}),
     .p_WBhi_L2              (p_WBhi_L2[0:15]),
     .WB_tagL1               (wbTagL1[0:20]),
     .p_wbTagL1              (p_wbTagL1),
     .byteWriteData          (byteWriteData[0:15]),
     .byteWrite_E1           (byteWrite_E1),
     .cacheableSpecialOp     (cacheableSpecialOp),
     .dataIndexA             (dataIndexOutA[0:9]),
     .dataIndexB             (dataIndexOutB[0:9]),
     .p_dataIndexP           (p_dataIndexOutP[0:9]),
     .dataReadNotWrite_In    (dataReadNotWrite_In),
     .dataReadWriteCycle_In  (dataReadWriteCycle_In),
     .dirtyLRUreadIndexL2    (dirtyLRUreadIndexL2[0:8]),
     .dirtyLRUwriteIndexL2   (dirtyLRUwriteIndexL2[0:8]),
     .newDirty               (newDirty),
     .newLRU                 (newLRU),
     .newValidIn             (newValidIn),
     .readLRUDirty           (readLRUDirty),
     .tagIndex               (tagIndexOut[0:9]),
     .tagReadNotWrite_In     (tagReadNotWrite_In),
     .tagReadWriteCycle_In   (tagReadWriteCycle_In),
     .testEn                 (testEn),
     .wbU0AttrL1             (wbU0AttrL1),
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
     .resetMemBist           (resetMemBist),
     .dcu_bist_debug_si      (dcu_bist_debug_si),
     .dcu_bist_debug_so      (dcu_bist_debug_so),
     .dcu_bist_debug_en      (dcu_bist_debug_en),
     .dcu_bist_mode_reg_in   (dcu_bist_mode_reg_in),
     .dcu_bist_mode_reg_out  (dcu_bist_mode_reg_out),
     .dcu_bist_parallel_dr   (dcu_bist_parallel_dr),
     .dcu_bist_mode_reg_si   (dcu_bist_mode_reg_si),
     .dcu_bist_mode_reg_so   (dcu_bist_mode_reg_so),
     .dcu_bist_shift_dr      (dcu_bist_shift_dr),
     .dcu_bist_mbrun         (dcu_bist_mbrun)
    );


// Removed the module 'module dp_logDCU_parityGen24, 2 instances
   assign p_tagErrorA = ^{p_parityA,tagAOut[0:20],valid_A,U0AttrA};
   assign p_tagErrorB = ^{p_parityB,tagBOut[0:20],valid_B,U0AttrB};

// Removed the module 'module dp_logDCU_parityGen9, 32 instances

   wire [0:15] p_dataErrorAByte;
   wire [0:15] p_dataErrorBByte;
   
   assign p_dataErrorAByte[0] = ^{dataOut_A[0:7],p_dataOutA[0]};
   assign p_dataErrorAByte[1] = ^{dataOut_A[8:15],p_dataOutA[1]};
   assign p_dataErrorAByte[2] = ^{dataOut_A[16:23],p_dataOutA[2]};
   assign p_dataErrorAByte[3] = ^{dataOut_A[24:31],p_dataOutA[3]};
   assign p_dataErrorAByte[4] = ^{dataOut_A[32:39],p_dataOutA[4]};
   assign p_dataErrorAByte[5] = ^{dataOut_A[40:47],p_dataOutA[5]};
   assign p_dataErrorAByte[6] = ^{dataOut_A[48:55],p_dataOutA[6]};
   assign p_dataErrorAByte[7] = ^{dataOut_A[56:63],p_dataOutA[7]};
   assign p_dataErrorAByte[8] = ^{dataOut_A[64:71],p_dataOutA[8]};
   assign p_dataErrorAByte[9] = ^{dataOut_A[72:79],p_dataOutA[9]};
   assign p_dataErrorAByte[10] = ^{dataOut_A[80:87],p_dataOutA[10]};
   assign p_dataErrorAByte[11] = ^{dataOut_A[88:95],p_dataOutA[11]};
   assign p_dataErrorAByte[12] = ^{dataOut_A[96:103],p_dataOutA[12]};
   assign p_dataErrorAByte[13] = ^{dataOut_A[104:111],p_dataOutA[13]};
   assign p_dataErrorAByte[14] = ^{dataOut_A[112:119],p_dataOutA[14]};
   assign p_dataErrorAByte[15] = ^{dataOut_A[120:127],p_dataOutA[15]};

   assign p_dataErrorBByte[0] = ^{dataOut_B[0:7],p_dataOutB[0]};
   assign p_dataErrorBByte[1] = ^{dataOut_B[8:15],p_dataOutB[1]};
   assign p_dataErrorBByte[2] = ^{dataOut_B[16:23],p_dataOutB[2]};
   assign p_dataErrorBByte[3] = ^{dataOut_B[24:31],p_dataOutB[3]};
   assign p_dataErrorBByte[4] = ^{dataOut_B[32:39],p_dataOutB[4]};
   assign p_dataErrorBByte[5] = ^{dataOut_B[40:47],p_dataOutB[5]};
   assign p_dataErrorBByte[6] = ^{dataOut_B[48:55],p_dataOutB[6]};
   assign p_dataErrorBByte[7] = ^{dataOut_B[56:63],p_dataOutB[7]};
   assign p_dataErrorBByte[8] = ^{dataOut_B[64:71],p_dataOutB[8]};
   assign p_dataErrorBByte[9] = ^{dataOut_B[72:79],p_dataOutB[9]};
   assign p_dataErrorBByte[10] = ^{dataOut_B[80:87],p_dataOutB[10]};
   assign p_dataErrorBByte[11] = ^{dataOut_B[88:95],p_dataOutB[11]};
   assign p_dataErrorBByte[12] = ^{dataOut_B[96:103],p_dataOutB[12]};
   assign p_dataErrorBByte[13] = ^{dataOut_B[104:111],p_dataOutB[13]};
   assign p_dataErrorBByte[14] = ^{dataOut_B[112:119],p_dataOutB[14]};
   assign p_dataErrorBByte[15] = ^{dataOut_B[120:127],p_dataOutB[15]};

   assign p_dataErrorA = p_dataErrorAByte;
   assign p_dataErrorB = p_dataErrorBByte;
// now only used for the flush path

// Removed the module 'module dp_logDCU_parityORtree, 2 instances
   
   assign p_aSideErrorRaw = |p_dataErrorAByte[0:15];
   assign p_bSideErrorRaw = |p_dataErrorBByte[0:15];
// report parity errors from any valid tag (regardless of hit)
// don't need xltValidLth any more since we won't have DCU_DA if there was no translation
//   AND2_J dp_logDCU_parityValidGatedA(.Z(validAGated), .A(validA), .B(xltValidLth));
//   AND2_J dp_logDCU_parityValidGatedB(.Z(validBGated), .A(validB), .B(xltValidLth));
//   AO22_J dp_logDCU_tagParityError(.Z(tagParityError), .A1(p_tagErrorA), .A2(validAGated), .B1(p_tagErrorB), .B2(validBGated));
// new! now reporting errors on invalid entries too (if there was a hit on either side)
// AO22_J dp_logDCU_tagParityError(.Z(tagParityError), .A1(p_tagErrorA), .A2(validA), .B1(p_tagErrorB), .B2(validB));
   // Replacing instantiation: OR2 dp_logDCU_tagParityError
   assign tagParityError = p_tagErrorA | p_tagErrorB;

// changed this for detecting all multi-hit scenarios (added the C1, C2 inputs)
// changed for the removal of the big OR reduction tree
   // Replacing instantiation: AO22 dp_logDCU_parityTagOrMulti
   wire p_tagOrMultiError;
   assign p_tagOrMultiError = (tagParityError & DCU_DA) | (hit_a_i & hit_b_i);


   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualA0
   assign p_aSideLoadError[0] = p_ramBypassA[0] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualA1
   assign p_aSideLoadError[1] = p_ramBypassA[1] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualA2
   assign p_aSideLoadError[2] = p_ramBypassA[2] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualA3
   assign p_aSideLoadError[3] = p_ramBypassA[3] | p_tagOrMultiError;


   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualB0
   assign p_bSideLoadError[0] = p_ramBypassB[0] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualB1
   assign p_bSideLoadError[1] = p_ramBypassB[1] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualB2
   assign p_bSideLoadError[2] = p_ramBypassB[2] | p_tagOrMultiError;

   // Replacing instantiation: OR2 dp_logDCU_parityErrorQualB3
   assign p_bSideLoadError[3] = p_ramBypassB[3] | p_tagOrMultiError;

//--------- end -----------------


// Modified to match Prowler changes.  RDE 4/11/00
//     newLRU, newU0AttrIn, newValidIn, readLRUDirty, writeBufScanOut, tagIndexOut[0:9],
//     tagReadNotWrite_In, tagReadWriteCycle_In, testEn, writeDataA0, writeDataA1, writeDataB0,


// Removed the module 'module dp_regDCU_LSA
// Removed the module 'module dp_regDCU_LSA2
// Removed the module 'module dp_logDCU_dataIndexInv
   reg [0:29]  LSA_non_inv;
   assign CAR_OF_L2 = CAR_OF_L2_i[27:29];
   always @(posedge CB)      
     begin                                       
	case(LSA_E1 & LSA_E2)                
	  1'b0: LSA_non_inv[0:29] <= LSA_non_inv[0:29];                
	  1'b1: LSA_non_inv[0:29] <= CAR_OF_L2_i[0:29];            
	  default: LSA_non_inv[0:29] <= 30'bx;  
	endcase                             
     end                                  
   assign LSA_inv[0:29] = ~LSA_non_inv[0:29];
   
   assign dataIndexIn_buf[0:9] = ~dataIndexIn_NEG[0:9];
   
   
   // Replacing instantiation: DELAY4 SDT_dly2_0_
assign tagCARDly[0] = tagCARDly1[0];

   // Replacing instantiation: DELAY4 SDT_dly2_1_
assign tagCARDly[1] = tagCARDly1[1];

   // Replacing instantiation: DELAY4 SDT_dly2_2_
assign tagCARDly[2] = tagCARDly1[2];

   // Replacing instantiation: DELAY4 SDT_dly2_3_
assign tagCARDly[3] = tagCARDly1[3];

   // Replacing instantiation: DELAY4 SDT_dly2_4_
assign tagCARDly[4] = tagCARDly1[4];

   // Replacing instantiation: DELAY4 SDT_dly2_5_
assign tagCARDly[5] = tagCARDly1[5];

   // Replacing instantiation: DELAY4 SDT_dly2_6_
assign tagCARDly[6] = tagCARDly1[6];

   // Replacing instantiation: DELAY4 SDT_dly2_7_
assign tagCARDly[7] = tagCARDly1[7];

   // Replacing instantiation: DELAY4 SDT_dly2_8_
assign tagCARDly[8] = tagCARDly1[8];

   // Replacing instantiation: DELAY4 SDT_dly2_9_
assign tagCARDly[9] = tagCARDly1[9];

   // Replacing instantiation: DELAY4 SDT_dly1_0_
assign tagCARDly1[0] = CAR_buf_index[18];

   // Replacing instantiation: DELAY4 SDT_dly1_1_
assign tagCARDly1[1] = CAR_buf_index[19];

   // Replacing instantiation: DELAY4 SDT_dly1_2_
assign tagCARDly1[2] = CAR_buf_index[20];

   // Replacing instantiation: DELAY4 SDT_dly1_3_
assign tagCARDly1[3] = CAR_buf_index[21];

   // Replacing instantiation: DELAY4 SDT_dly1_4_
assign tagCARDly1[4] = CAR_buf_index[22];

   // Replacing instantiation: DELAY4 SDT_dly1_5_
assign tagCARDly1[5] = CAR_buf_index[23];

   // Replacing instantiation: DELAY4 SDT_dly1_6_
assign tagCARDly1[6] = CAR_buf_index[24];

   // Replacing instantiation: DELAY4 SDT_dly1_7_
assign tagCARDly1[7] = CAR_buf_index[25];

   // Replacing instantiation: DELAY4 SDT_dly1_8_
assign tagCARDly1[8] = CAR_buf_index[26];

   // Replacing instantiation: DELAY4 SDT_dly1_9_
assign tagCARDly1[9] = CAR_buf[27];

   // Replacing instantiation: DELAY4 SDT_dly3_0_
assign tagIndexDly1[0] = tagIndexOutDup[0];

   // Replacing instantiation: DELAY4 SDT_dly3_1_
assign tagIndexDly1[1] = tagIndexOutDup[1];

   // Replacing instantiation: DELAY4 SDT_dly3_2_
assign tagIndexDly1[2] = tagIndexOutDup[2];

   // Replacing instantiation: DELAY4 SDT_dly3_3_
assign tagIndexDly1[3] = tagIndexOutDup[3];

   // Replacing instantiation: DELAY4 SDT_dly3_4_
assign tagIndexDly1[4] = tagIndexOutDup[4];

   // Replacing instantiation: DELAY4 SDT_dly3_5_
assign tagIndexDly1[5] = tagIndexOutDup[5];

   // Replacing instantiation: DELAY4 SDT_dly3_6_
assign tagIndexDly1[6] = tagIndexOutDup[6];

   // Replacing instantiation: DELAY4 SDT_dly3_7_
assign tagIndexDly1[7] = tagIndexOutDup[7];

   // Replacing instantiation: DELAY4 SDT_dly3_8_
assign tagIndexDly1[8] = tagIndexOutDup[8];

   // Replacing instantiation: DELAY4 SDT_dly3_9_
assign tagIndexDly1[9] = tagIndexOutDup[9];

   // Replacing instantiation: DELAY4 SDT_dly4_0_
assign tagIndexDupDly[0] = tagIndexDly1[0];

   // Replacing instantiation: DELAY4 SDT_dly4_1_
assign tagIndexDupDly[1] = tagIndexDly1[1];

   // Replacing instantiation: DELAY4 SDT_dly4_2_
assign tagIndexDupDly[2] = tagIndexDly1[2];

   // Replacing instantiation: DELAY4 SDT_dly4_3_
assign tagIndexDupDly[3] = tagIndexDly1[3];

   // Replacing instantiation: DELAY4 SDT_dly4_4_
assign tagIndexDupDly[4] = tagIndexDly1[4];

   // Replacing instantiation: DELAY4 SDT_dly4_5_
assign tagIndexDupDly[5] = tagIndexDly1[5];

   // Replacing instantiation: DELAY4 SDT_dly4_6_
assign tagIndexDupDly[6] = tagIndexDly1[6];

   // Replacing instantiation: DELAY4 SDT_dly4_7_
assign tagIndexDupDly[7] = tagIndexDly1[7];

   // Replacing instantiation: DELAY4 SDT_dly4_8_
assign tagIndexDupDly[8] = tagIndexDly1[8];

   // Replacing instantiation: DELAY4 SDT_dly4_9_
assign tagIndexDupDly[9] = tagIndexDly1[9];

   // Replacing instantiation: DELAY4 SDT_dly6_0_
assign LSADly[0] = tagLSADly1[0];

   // Replacing instantiation: DELAY4 SDT_dly6_1_
assign LSADly[1] = tagLSADly1[1];

   // Replacing instantiation: DELAY4 SDT_dly6_2_
assign LSADly[2] = tagLSADly1[2];

   // Replacing instantiation: DELAY4 SDT_dly6_3_
assign LSADly[3] = tagLSADly1[3];

   // Replacing instantiation: DELAY4 SDT_dly6_4_
assign LSADly[4] = tagLSADly1[4];

   // Replacing instantiation: DELAY4 SDT_dly6_5_
assign LSADly[5] = tagLSADly1[5];

   // Replacing instantiation: DELAY4 SDT_dly6_6_
assign LSADly[6] = tagLSADly1[6];

   // Replacing instantiation: DELAY4 SDT_dly6_7_
assign LSADly[7] = tagLSADly1[7];

   // Replacing instantiation: DELAY4 SDT_dly6_8_
assign LSADly[8] = tagLSADly1[8];

   // Replacing instantiation: DELAY4 SDT_dly6_9_
assign LSADly[9] = tagLSADly1[9];

   // Replacing instantiation: DELAY4 SDT_dly5_0_
wire [0:29] LSA_L2_i;
assign LSA_L2 = LSA_L2_i[27:29];
assign tagLSADly1[0] = LSA_L2_i[18];

   // Replacing instantiation: DELAY4 SDT_dly5_1_
assign tagLSADly1[1] = LSA_L2_i[19];

   // Replacing instantiation: DELAY4 SDT_dly5_2_
assign tagLSADly1[2] = LSA_L2_i[20];

   // Replacing instantiation: DELAY4 SDT_dly5_3_
assign tagLSADly1[3] = LSA_L2_i[21];

   // Replacing instantiation: DELAY4 SDT_dly5_4_
assign tagLSADly1[4] = LSA_L2_i[22];

   // Replacing instantiation: DELAY4 SDT_dly5_5_
assign tagLSADly1[5] = LSA_L2_i[23];

   // Replacing instantiation: DELAY4 SDT_dly5_6_
assign tagLSADly1[6] = LSA_L2_i[24];

   // Replacing instantiation: DELAY4 SDT_dly5_7_
assign tagLSADly1[7] = LSA_L2_i[25];

   // Replacing instantiation: DELAY4 SDT_dly5_8_
assign tagLSADly1[8] = LSA_L2_i[26];

   // Replacing instantiation: DELAY4 SDT_dly5_9_
assign tagLSADly1[9] = LSA_L2_i[27];

   // Replacing instantiation: DELAY4 SDT_dly8_0_
assign SAQDly[18] = SAQDly1[0];

   // Replacing instantiation: DELAY4 SDT_dly8_1_
assign SAQDly[19] = SAQDly1[1];

   // Replacing instantiation: DELAY4 SDT_dly8_2_
assign SAQDly[20] = SAQDly1[2];

   // Replacing instantiation: DELAY4 SDT_dly8_3_
assign SAQDly[21] = SAQDly1[3];

   // Replacing instantiation: DELAY4 SDT_dly8_4_
assign SAQDly[22] = SAQDly1[4];

   // Replacing instantiation: DELAY4 SDT_dly8_5_
assign SAQDly[23] = SAQDly1[5];

   // Replacing instantiation: DELAY4 SDT_dly8_6_
assign SAQDly[24] = SAQDly1[6];

   // Replacing instantiation: DELAY4 SDT_dly8_7_
assign SAQDly[25] = SAQDly1[7];

   // Replacing instantiation: DELAY4 SDT_dly8_8_
assign SAQDly[26] = SAQDly1[8];

   // Replacing instantiation: DELAY4 SDT_dly8_9_
assign SAQDly[27] = SAQDly1[9];

   // Replacing instantiation: DELAY4 SDT_dly7_0_
assign SAQDly1[0] = SAQ_L2_i[18];

   // Replacing instantiation: DELAY4 SDT_dly7_1_
assign SAQDly1[1] = SAQ_L2_i[19];

   // Replacing instantiation: DELAY4 SDT_dly7_2_
assign SAQDly1[2] = SAQ_L2_i[20];

   // Replacing instantiation: DELAY4 SDT_dly7_3_
assign SAQDly1[3] = SAQ_L2_i[21];

   // Replacing instantiation: DELAY4 SDT_dly7_4_
assign SAQDly1[4] = SAQ_L2_i[22];

   // Replacing instantiation: DELAY4 SDT_dly7_5_
assign SAQDly1[5] = SAQ_L2_i[23];

   // Replacing instantiation: DELAY4 SDT_dly7_6_
assign SAQDly1[6] = SAQ_L2_i[24];

   // Replacing instantiation: DELAY4 SDT_dly7_7_
assign SAQDly1[7] = SAQ_L2_i[25];

   // Replacing instantiation: DELAY4 SDT_dly7_8_
assign SAQDly1[8] = SAQ_L2_i[26];

   // Replacing instantiation: DELAY4 SDT_dly7_9_
assign SAQDly1[9] = SAQ_L2_i[27];

   // Replacing instantiation: DELAY4 SDT_dly9_0_
assign dataIndexDly1[0] = dataIndexDup[0];

   // Replacing instantiation: DELAY4 SDT_dly9_1_
assign dataIndexDly1[1] = dataIndexDup[1];

   // Replacing instantiation: DELAY4 SDT_dly9_2_
assign dataIndexDly1[2] = dataIndexDup[2];

   // Replacing instantiation: DELAY4 SDT_dly9_3_
assign dataIndexDly1[3] = dataIndexDup[3];

   // Replacing instantiation: DELAY4 SDT_dly9_4_
assign dataIndexDly1[4] = dataIndexDup[4];

   // Replacing instantiation: DELAY4 SDT_dly9_5_
assign dataIndexDly1[5] = dataIndexDup[5];

   // Replacing instantiation: DELAY4 SDT_dly9_6_
assign dataIndexDly1[6] = dataIndexDup[6];

   // Replacing instantiation: DELAY4 SDT_dly9_7_
assign dataIndexDly1[7] = dataIndexDup[7];

   // Replacing instantiation: DELAY4 SDT_dly9_8_
assign dataIndexDly1[8] = dataIndexDup[8];

   // Replacing instantiation: DELAY4 SDT_dly9_9_
assign dataIndexDly1[9] = dataIndexDup[9];

   // Replacing instantiation: DELAY4 SDT_dly10_0_
assign dataIndexDupDly[0] = dataIndexDly1[0];

   // Replacing instantiation: DELAY4 SDT_dly10_1_
assign dataIndexDupDly[1] = dataIndexDly1[1];

   // Replacing instantiation: DELAY4 SDT_dly10_2_
assign dataIndexDupDly[2] = dataIndexDly1[2];

   // Replacing instantiation: DELAY4 SDT_dly10_3_
assign dataIndexDupDly[3] = dataIndexDly1[3];

   // Replacing instantiation: DELAY4 SDT_dly10_4_
assign dataIndexDupDly[4] = dataIndexDly1[4];

   // Replacing instantiation: DELAY4 SDT_dly10_5_
assign dataIndexDupDly[5] = dataIndexDly1[5];

   // Replacing instantiation: DELAY4 SDT_dly10_6_
assign dataIndexDupDly[6] = dataIndexDly1[6];

   // Replacing instantiation: DELAY4 SDT_dly10_7_
assign dataIndexDupDly[7] = dataIndexDly1[7];

   // Replacing instantiation: DELAY4 SDT_dly10_8_
assign dataIndexDupDly[8] = dataIndexDly1[8];

   // Replacing instantiation: DELAY4 SDT_dly10_9_
assign dataIndexDupDly[9] = dataIndexDly1[9];

// Removed the module 'module dp_logDCU_CAR_buf2
// Removed the module 'module dp_logDCU_CAR_buf1
// Removed the module 'module dp_logDCU_wbLoBuf

   assign CAR_buf_index[18:26] = CAR_L2[18:26];
   assign CAR_bufComp[0:20] = CAR_L2[0:20];
   assign writeBufLoTag_E1Buf = writeBufLoTag_E1;
   
//DCU_indexDelayDataB indexDelayDataBFun(dataIndexOutB[0:9], dataIndexIn_buf[0:9]);

// Removed the module 'module dp_regDCU_AddrRam2
// Removed the module 'module dp_regDCU_AddrRam1
   
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin                                       
     dataIndexOutB[0:9] <= dataIndexIn_buf[0:9];          
   end                                  
`else                                   
   // L1 Output modeled as a transparent latch     
   always @(CB or dataIndexIn_buf or dataIndexOutB)          
    begin                                       
    case(~CB)       
     1'b0: ;                            
     1'b1: dataIndexOutB[0:9] = dataIndexIn_buf[0:9];             
      default: dataIndexOutB[0:9] = dataIndexOutB[0:9];
    endcase                             
   end                                  
`endif                                  

//DCU_indexDelayDataA indexDelayDataAFun(dataIndexOutA[0:9], dataIndexIn_buf[0:9]);

`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
     begin                                       
	dataIndexOutA[0:9] <= dataIndexIn_buf[0:9];          
     end                                  
`else                                   
   // L1 Output modeled as a transparent latch     
   always @(CB or dataIndexIn_buf or dataIndexOutA)          
     begin                                       
	case(~CB)       
	  1'b0: ;                            
	  1'b1: dataIndexOutA[0:9] = dataIndexIn_buf[0:9];             
	  default: dataIndexOutA[0:9] = dataIndexOutA[0:9] ;
	endcase                             
     end                                  
`endif                                  

//--------- start ---------------
// rgoldiez - added to generate the addr for the parity array off it's own L1 latch
   // Replacing instantiation: PDP_P1UUL1L2 dp_regDCU_AddrRamP
   reg [0:9] dp_regDCU_AddrRamP_regL1;
   reg [0:9] dp_regDCU_AddrRamP_regL2;
   wire [0:9] dp_regDCU_AddrRamP_D; 
   assign p_dataIndexOutP = dp_regDCU_AddrRamP_regL1 ;     	
   assign dp_regDCU_AddrRamP_D = dataIndexIn_buf[0:9];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
     dp_regDCU_AddrRamP_regL2 <= dp_regDCU_AddrRamP_D;		
   end			 		
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)  	
    begin				  	
     dp_regDCU_AddrRamP_regL1 <= dp_regDCU_AddrRamP_D;		
   end			 		
`else                                 	
   // L1 Output modeled as a transparent latch     
   always @(CB or dp_regDCU_AddrRamP_D or dp_regDCU_AddrRamP_regL1)  	
    begin				  	
    case(~CB)	
     1'b0: ;				
     1'b1: dp_regDCU_AddrRamP_regL1 = dp_regDCU_AddrRamP_D;		
      //default: dp_regDCU_AddrRamP_regL1 = 10'bx;  
      default: dp_regDCU_AddrRamP_regL1 = dp_regDCU_AddrRamP_regL1 ;  
    endcase		 		
   end			 		
`endif                                	

//--------- end -----------------


// Removed the module 'module dp_logDCU_validBuf2
// Removed the module 'module dp_logDCU_validBuf1
// Removed the module 'module dp_logDCU_tagAddr2Inv
// Removed the module 'module dp_logDCU_SDQmodBuf
// Removed the module 'module dp_logDCU_carInv5
// Removed the module 'module dp_logDCU_carInv4
// Removed the module 'module DCU_indexDelayTag
// Removed the module 'module DCU_addrCompare, 7 instances

   wire validA_inv;
   wire validB_inv;
   wire U0AttrFARMux;
   
   assign {validA, validB} = ~{validA_inv, validB_inv}; 
   assign {validA_inv, validB_inv} = ~{valid_A, valid_B};
   assign {tagMuxOutFAR[0:20], U0AttrFARMux} = ~outFAR_inv[0:21];
   assign DCU_SDQ_mod_NEG[0:31] = ~DCU_SDQ_modified[0:31];
   assign CAR_L2_buf2[27:29] = ~CAR_L2_NEG[27:29];
   assign CAR_L2_buf1[27:29] = ~CAR_L2_NEG[27:29];
   
   //assign #4 tagIndexOut[0:9] = ~tagIndexIn_NEG[0:9];      
   assign tagIndexOut[0:9] = ~tagIndexIn_NEG[0:9];      

   
   wire  CAR_LSAcmp2;
   wire  CAR_SAQcmp2;

   assign CAR_LSAcmp2 = (CAR_L2[0:26] == LSA_L2_i[0:26]);
   assign CAR_SAQcmp2 = (SAQ_L2_i[0:26] == CAR_L2[0:26]);
   
   assign SAQ_FARcmp = (FAR_L2[0:26] == SAQ_L2_i[0:26]);
   assign CAR_SAQcmp = (SAQ_L2_i[0:26] == CAR_L2[0:26]);
   assign carOF_LSAcmp = (CAR_OF_L2_i[0:26] == LSA_L2_i[0:26]);
   assign carOF_FARcmp = (FAR_L2[0:26] == CAR_OF_L2_i[0:26]);
   assign CAR_LSAcmp = (CAR_L2[0:26] == LSA_L2_i[0:26]);
   


// Removed the module 'module dp_logDCU_LSAinv
// Removed the module 'module dp_muxDCU_CARnegTest
// Removed the module 'module dp_logDCU_dirtyLRUreadIndexInv
// Removed the module 'module dp_logDCU_hitB_nor3
// Removed the module 'module dp_logDCU_hitB_nor2
// Removed the module 'module dp_logDCU_hitB_nor1
// Removed the module 'module dp_logDCU_hitB_nor0
// Removed the module 'module dp_logDCU_muxSelFB_SDP
// Removed the module 'module dp_logDCU_muxSelAO

   assign LSA_L2_i[0:29] = ~LSA_inv[0:29];
   assign CAR_L2_NEG_mod[0:20] = (CAR_L2_NEG[0:20] & {21{~testEn}}) | 
				 (CAR_L2[0:20] & {(21){testEn}}); 
   
   assign dirtyLRUreadIndexL2[0:8] = ~dirtyLRUreadIndexNEG[0:8];
   assign dOutMuxSelBit0Byte3 = ~(hit_b_i | dOutMuxSelNoHit[3]);
   assign dOutMuxSelBit0Byte2 = ~(hit_b_i | dOutMuxSelNoHit[2]);
   assign dOutMuxSelBit0Byte1 = ~(hit_b_i | dOutMuxSelNoHit[1]);
   assign dOutMuxSelBit0Byte0 = ~(hit_b_i | dOutMuxSelNoHit[0]);
   
   assign bypassFillSDQ_selMod[0:3] = bypassFillSDP_sel[0:3] & {4{CAR_SAQcmp2}};
   assign dOutMuxSelNoHit[0:3] = (bypassFillSDP_sel[0:3] & {4{CAR_SAQcmp2}}) |
				 ({4{loadReadFBvalid}} & {4{CAR_LSAcmp2}}) |
				 ({4{bypassPendOrDcRead}} & {4{1'b1}});
   

// Removed the module 'module dp_logDCU_hold_inv6
// Removed the module 'module dp_logDCU_hold_inv5
// Removed the module 'module dp_logDCU_hold_inv4
// Removed the module 'module dp_logDCU_hold_inv1
// Removed the module 'module dp_logDCU_hold_inv2
// Removed the module 'module dp_logDCU_hold_inv3
// Removed the module 'module dp_logDCU_tagBufB
// Removed the module 'module dp_logDCU_tagBufA

   wire  hiInv2_E1;
   wire  hiInv1_E1;
   wire  loInv2_E1;
   wire  loInv1_E1;
   wire  muxSelInv2;
   wire  muxSelInv1;
   wire  hold_E2inv2;
   wire  hold_E2inv1;

   assign {FDR_hiBuf_E1[3], FDR_loBuf_E1[3], FDR_holdMuxSelBuf[3], flush_holdBuf[3]} = ~{hiInv2_E1, loInv2_E1, muxSelInv2, hold_E2inv2};
   assign {FDR_hiBuf_E1[2], FDR_loBuf_E1[2], FDR_holdMuxSelBuf[2], flush_holdBuf[2]} = ~{hiInv2_E1, loInv2_E1, muxSelInv2, hold_E2inv2};
   assign {FDR_hiBuf_E1[1], FDR_loBuf_E1[1], FDR_holdMuxSelBuf[1], flush_holdBuf[1]} = ~{hiInv1_E1, loInv1_E1, muxSelInv1, hold_E2inv1};
   assign {FDR_hiBuf_E1[0], FDR_loBuf_E1[0], FDR_holdMuxSelBuf[0], flush_holdBuf[0]} = ~{hiInv1_E1, loInv1_E1, muxSelInv1, hold_E2inv1};
   assign {hiInv2_E1, loInv2_E1, muxSelInv2, hold_E2inv2} = ~{FDR_hi_E1, FDR_lo_E1, FDR_holdMuxSel, flushHold_E2};
   assign {hiInv1_E1, loInv1_E1, muxSelInv1, hold_E2inv1} = ~{FDR_hi_E1, FDR_lo_E1, FDR_holdMuxSel, flushHold_E2};
   assign tagB_inv[0:23] = ~{tagBOut[0:20], U0AttrB, dirtyB_i, valid_B};
   assign tagA_inv[0:23] = ~{tagAOut[0:20], U0AttrA, dirtyA_i, valid_A};
   
//--------- start ---------------
// rgoldiez - added these inverters to repower the tag parity bits for a dcread
   // Replacing instantiation: GS_INVERT dp_logDCU_parityTagBuf
   assign {p_parityAInv,p_parityBInv} = ~({p_parityA,p_parityB});

//--------- end -----------------

// Removed the module 'module dp_regDCU_dataIndexDup
// Removed the module 'module dp_muxDCU_dataIndexPre2
   
   always @(posedge CB)  	
     begin				  	
	case(dataIndex_E1 & dataIndex_E2)	                
	  1'b0: dataIndexDup[0:9] <= dataIndexDup[0:9];		
	  1'b1: dataIndexDup[0:9] <= dataIndexIn_NEG[0:9];		
	  default: dataIndexDup[0:9] <= 10'bx;  
	endcase		 		
     end			 		

   assign dataIndexMuxLSA_dup[0:9] = (dataIndexDupDly[0:9] & {10{~dataIndexLSA_dupSel}}) | 
				     ({LSADly[0:8],1'b0} & {10{dataIndexLSA_dupSel}}); 

// From Prowler:  4/12/00

// Removed the module 'module dp_regDCU_wbTag2
   
   always @(posedge CB)  	
     begin				  	
	case(writeBufLoTag_E1Buf)	                
	  1'b0: wbTag2noConn[0:5] <= wbTag2noConn[0:5];		
	  1'b1: wbTag2noConn[0:5] <= {newU0AttrIn, LSA_L2_i[16:20]};		
	  default: wbTag2noConn[0:5] <= 6'bx;  
	endcase		 		
     end			 		
                                           
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)  	
     begin				  	
	case(writeBufLoTag_E1Buf)			
	  1'b0: {wbU0AttrL1, wbTagL1[16:20]} <= {wbU0AttrL1, wbTagL1[16:20]};		
	  1'b1: {wbU0AttrL1, wbTagL1[16:20]} <= {newU0AttrIn, LSA_L2_i[16:20]};		
	  default: {wbU0AttrL1, wbTagL1[16:20]} <= 6'bx;  
	endcase		 		
     end			 		
`else                                 	
   // L1 Output modeled as a transparent latch     
   always @(CB or writeBufLoTag_E1Buf or newU0AttrIn or LSA_L2_i or wbTagL1 or wbU0AttrL1)  	
     begin				  	
	case(~CB & writeBufLoTag_E1Buf)	
	  1'b0: ;				
	  1'b1: {wbU0AttrL1, wbTagL1[16:20]} = {newU0AttrIn, LSA_L2_i[16:20]};		
	  default: {wbU0AttrL1, wbTagL1[16:20]} = {wbU0AttrL1, wbTagL1[16:20]};
	endcase		 		
     end			 		
`endif                                	

// Modified to match Prowler changes.  RDE 4/11/00
// dp_regDCU_wbTag2 regDCU_wbTag2({CB[0:2], CB_buf4[3], CB[4]}, LSA_L2_i[16:20],
//      writeBufLoTag_E1Buf, 1'b1, SAQ_scanOut, wbTagL1[16:20], wbTag2noConn[0:4],
//      WB_tag_scanOut1);

// Removed the module 'module dp_regDCU_wbTag1

   always @(posedge CB)  	
     begin				  	
	case(writeBufLoTag_E1Buf)	                
	  1'b0: wbTag1noConn[0:15] <= wbTag1noConn[0:15];		
	  1'b1: wbTag1noConn[0:15] <= LSA_L2_i[0:15];		
	  default: wbTag1noConn[0:15] <= 16'bx;  
	endcase		 		
     end			 		
                                           
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)  	
     begin				  	
	case(writeBufLoTag_E1Buf)			
	  1'b0: wbTagL1[0:15] <= wbTagL1[0:15];		
	  1'b1: wbTagL1[0:15] <= LSA_L2_i[0:15];		
	  default: wbTagL1[0:15] <= 16'bx;  
	endcase		 		
     end			 		
`else                                 	
   // L1 Output modeled as a transparent latch     
   always @(CB or LSA_L2_i or writeBufLoTag_E1Buf)  	
     begin				  	
	case(~CB & writeBufLoTag_E1Buf)	
	  1'b0: ;				
	  1'b1: wbTagL1[0:15] = LSA_L2_i[0:15];		
	  default: wbTagL1[0:15] = wbTagL1[0:15];
	endcase		 		
     end			 		
`endif                                	
//--------- start ---------------
// rgoldiez - added this register to store parity bits for the LSA (tag parity)
// rgoldiez - The dp_logDCU_parityGen22 module does not need the valid bit as an input
//            since we know that the valid bit is going to be asserted for a tag write.
//            So, instead of feeding the valid bit in we can make the final XOR stage an
//            XNOR which will generate the appropriate valid bit.
// rgoldiez - mistakenly had a problem where wbTagL1 fed into this XOR (as well as wbU0AttrL1

// Removed the module 'module dp_logDCU_parityGen22
   assign p_LSA = (^{newU0AttrIn, LSA_L2_i[0:20]});

// added for hw tag error injection
   // Replacing instantiation: XOR2 dp_logDCU_hwTagParityInjection
   assign p_Injected_LSA = p_LSA ^ ICU_CCR1DCTE;

   // Replacing instantiation: PDP_P1EUL1 dp_regDCU_wbTagP
   reg dp_regDCU_wbTagP_regL1;
   assign p_wbTagL1preValid = dp_regDCU_wbTagP_regL1;    
   assign dp_regDCU_wbTagP_E1 = writeBufLoTag_E1Buf;     
   assign dp_regDCU_wbTagP_D = p_Injected_LSA;       
                                           
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_wbTagP_E1)			
     1'b0: dp_regDCU_wbTagP_regL1 <= dp_regDCU_wbTagP_regL1;		
     1'b1: dp_regDCU_wbTagP_regL1 <= dp_regDCU_wbTagP_D;		
      default: dp_regDCU_wbTagP_regL1 <= 1'bx;  
    endcase		 		
   end			 		
`else                                 	
   // L1 Output modeled as a transparent latch     
   always @(CB or dp_regDCU_wbTagP_D or dp_regDCU_wbTagP_E1 or dp_regDCU_wbTagP_regL1)  	
    begin				  	
    case(~CB & dp_regDCU_wbTagP_E1)	
     1'b0: ;				
     1'b1: dp_regDCU_wbTagP_regL1 = dp_regDCU_wbTagP_D;		
      //default: dp_regDCU_wbTagP_regL1 = 1'bx;  
      default: dp_regDCU_wbTagP_regL1 = dp_regDCU_wbTagP_regL1;  
    endcase		 		
   end			 		
`endif                                	


   // Replacing instantiation: XOR2 dp_logDCU_parityTagValidBitInsertion
   assign p_wbTagL1 = p_wbTagL1preValid ^ newValidIn;

//--------- end -----------------

// Removed the module 'module dp_logDCU_SDP_inv
// Removed the module 'module dp_logDCU_SDP_buf

   assign SDP_inv[0:31] = ~SDP_data[0:31];
   assign SDP_buf[0:31] = ~SDP_inv[0:31];

//--------- start ---------------
// rgoldiez - added this register to store parity bits for the SDP register
   // Replacing instantiation: GS_INVERT dp_logDCU_parity_SDP_inv
   assign p_SDP_inv[0:3] = ~(p_SDP_data[0:3]);

   // Replacing instantiation: GS_INVERT dp_logDCU_parity_SDP_buf
   assign p_SDP_buf[0:3] = ~(p_SDP_inv[0:3]);

//--------- end -----------------

// Removed the module 'module dp_logDCU_carBuf4
// Removed the module 'module dp_logDCU_carBuf3
// Removed the module 'module dp_logDCU_carBuf
// Removed the module 'module dp_muxDCU_vdlIndex
// Removed the module 'module dp_muxDCU_tagIndex
// Removed the module 'module dp_muxDCU_SDPocm
// Removed the module 'module dp_muxDCU_SDP

   assign CAR_buf3[28:29] = CAR_buf[28:29];
   assign CAR_buf2[28:29] = CAR_buf[28:29];
   assign CAR_buf[27:29] = CAR_L2[27:29];

  
   always @(fillUsingArray or dirtyLRU_readIndexSel or CAR_buf_index or MMU_dsRA or LSA_L2_i) 
     begin 					    
	case({fillUsingArray,dirtyLRU_readIndexSel})    		    	
	  2'b00: dirtyLRU_indexIn_NEG[0:8] = CAR_buf_index[18:26];    
	  2'b01: dirtyLRU_indexIn_NEG[0:8] = MMU_dsRA[18:26];    
	  2'b10: dirtyLRU_indexIn_NEG[0:8] = 9'b0;    
	  2'b11: dirtyLRU_indexIn_NEG[0:8] = LSA_L2_i[18:26];    
	  default: dirtyLRU_indexIn_NEG[0:8] = 9'bx;   
	endcase                                    
     end                                         

   always @(dataIndexMuxSel or MMU_dsRA or MMU_27_mod or SAQDly or dataIndexMuxPre or dataIndexMuxLSA_dup) 
     begin 					    
	case(dataIndexMuxSel[0:1])    		    	
	  2'b00: dataIndexIn_NEG[0:9] = {MMU_dsRA[18:26], MMU_27_mod};    
	  2'b01: dataIndexIn_NEG[0:9] = SAQDly[18:27];    
	  2'b10: dataIndexIn_NEG[0:9] = dataIndexMuxPre[0:9];    
	  2'b11: dataIndexIn_NEG[0:9] = dataIndexMuxLSA_dup[0:9];    
	  default: dataIndexIn_NEG[0:9] = 10'bx;   
	endcase                                    
     end                                         

   always @(fillUsingArray or tagIndexSel or tagCARDly or MMU_dsRA or tagIndexDupDly or LSADly) 
     begin 					    
	case({fillUsingArray, tagIndexSel})    		    	
	  2'b00: tagIndexIn_NEG[0:9] = tagCARDly[0:9];    
	  2'b01: tagIndexIn_NEG[0:9] = MMU_dsRA[18:27];    
	  2'b10: tagIndexIn_NEG[0:9] = tagIndexDupDly[0:9];    
	  2'b11: tagIndexIn_NEG[0:9] = LSADly[0:9];    
	  default: tagIndexIn_NEG[0:9] = 10'bx;   
	endcase                                    
     end                               
          

   assign SDQ_SDP_muxOcm[0:31] = ~((DCU_SDQ_modified[0:31] & {32{~SDQ_SDP_OCM_sel}}) | 
				   (SDP_data[0:31] & {32{SDQ_SDP_OCM_sel}} ) ); 

   assign SDQ_SDP_muxOut[0:31] = (DCU_SDQ_modified[0:31] & {32{~SDQ_SDP_mux}}) | 
				 (SDP_data[0:31] & {32{SDQ_SDP_mux}}); 

 //--------- start ---------------
// rgoldiez - added this register to store parity bits for the SDP register
   // Replacing instantiation: PDP_MUX2C dp_muxDCU_paritySDP
   assign p_SDQ_SDP_muxOut[0:3] = (p_DCU_SDQ_modified[0:3] & {(4){~(SDQ_SDP_mux)}} ) | (p_SDP_data[0:3] & {(4){SDQ_SDP_mux}} ); 

//--------- end -----------------

// Removed the module 'module dp_regDCU_SDP

   always @(posedge CB)  	
     begin				  	
	case(SAQ_E1 & SAQ_E2)		
	  1'b0: SDP_data[0:31] <= SDP_data[0:31];		
	  1'b1: SDP_data[0:31] <= DCU_SDQ_modified[0:31];		
	  default: SDP_data[0:31] <= 32'bx;  
	endcase		 		
     end			 		
 //--------- start ---------------
// rgoldiez - added this register to store parity bits for the SDP register
   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_paritySDP
   reg [0:3] dp_regDCU_paritySDP_regL2;
   wire [0:3] dp_regDCU_paritySDP_D; 
   wire dp_regDCU_paritySDP_E1; 
   assign p_SDP_data[0:3] = dp_regDCU_paritySDP_regL2;     	
   assign dp_regDCU_paritySDP_E1 = SAQ_E1 & SAQ_E2;     
   assign dp_regDCU_paritySDP_D = p_DCU_SDQ_modified[0:3];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_paritySDP_E1)	                
     1'b0: dp_regDCU_paritySDP_regL2 <= dp_regDCU_paritySDP_regL2;		
     1'b1: dp_regDCU_paritySDP_regL2 <= dp_regDCU_paritySDP_D;		
      default: dp_regDCU_paritySDP_regL2 <= 4'bx;  
    endcase		 		
   end			 		

//--------- end -----------------
p405s_DCU_plbMux
 DCU_plbMuxSch( 
  .DCU_plbDBus(DCU_plbDBus[0:63]),
  .CB(CB),
  .FDR_L2mux(FDR_L2mux[0:63]),
  .PLBDR_E2(PLBDR_E2[0:3]),
  .PLBDR_hiMuxSel(PLBDR_hiMuxSel[0:3]),
  .SDP_FDR_muxSel(SDP_FDR_muxSel),
  .SDP_dataL2(SDP_buf[0:31]),
  .sampleCycleL2(sampleCycleL2));


// Removed the module 'module dp_muxDCU_dataIndexPre
// Removed the module 'module dp_regDCU_tagIndexDup
// Removed the module 'module dp_muxDCU_PLB_AR2
// Removed the module 'module dp_logDCU_SDQ_fillWB_inv1
// Removed the module 'module dp_logDCU_SDQ_WB_inv2

   assign dataIndexMuxPre[0:9] = (tagCARDly[0:9] & {10{~dataIndexMuxSel2}}) | 
				 ({tagIndexDupDly[0:8],1'b1} & {10{dataIndexMuxSel2}}); 

   always @(posedge CB)  	
     begin				  	
	case(tagIndexDup_E1 & tagIndexDup_E2)	                
	  1'b0: tagIndexOutDup[0:9] <= tagIndexOutDup[0:9];		
	  1'b1: tagIndexOutDup[0:9] <= tagIndexIn_NEG[0:9];		
	  default: tagIndexOutDup[0:9] <= 10'bx;  
	endcase		 		
   end			 		

   assign FAR_OF[0:29] = (CAR_OF_L2_i[0:29] & {30{~PLBAR_selFAR}}) | 
			 ({FAR_L2[0:26],3'b0} & {30{PLBAR_selFAR}}); 

   assign SDQ_SDP_muxBuf_Neg[0:31] = ~SDQ_SDP_muxOut[0:31];

   assign SDQ_SDP_muxBuf[0:31] = ~SDQ_SDP_muxBuf_Neg[0:31];

//--------- start ---------------
// rgoldiez - added this buffering for the parity bits from the SDQ_SDP mux
   // Replacing instantiation: GS_INVERT dp_logDCU_parity_SDQ_fillWB_inv
   assign p_SDQ_SDP_muxOut_Neg[0:3] = ~(p_SDQ_SDP_muxOut[0:3]);

   // Replacing instantiation: GS_INVERT dp_logDCU_parity_SDQ_fillWB_buf
   assign p_SDQ_SDP_muxBuf[0:3] = ~(p_SDQ_SDP_muxOut_Neg[0:3]);

//--------- end -----------------
//--------- start ---------------
// rgoldiez - new! we are now reporting errors only on the data returned!!!
p405s_DCU_ramBypass
 DCU_ramBypassSch(
  .wordMuxA(wordMuxAwoParity[0:31]),
  .wordMuxB(wordMuxBwoParity[0:31]),
  .p_ramBypassA(p_ramBypassA[0:3]),
  .p_ramBypassB(p_ramBypassB[0:3]),
  .CAR_buf2(CAR_buf2[28:29]),
  .CAR_buf3(CAR_buf3[28:29]),
  .dataOut_A(dataOut_A[0:127]),
  .dataOut_B(dataOut_B[0:127]),
  .p_dataOutA(p_dataErrorA[0:15]),
  .p_dataOutB(p_dataErrorB[0:15]));


//--------- end -----------------
//--------- start ---------------
// rgoldiez - added these 32-bit muxes for selecting the parity array on dcreads
//              whether select A-way or B-way, you get the parity bits for both side of that
//              half line

// adding tihs AND gate so that we only select the parity output if we are doing a dcread and CCR0[CPS] is set
   // Replacing instantiation: AND2 dp_logDCU_dcreadSelectsDataParity
   wire selectParity;
   assign selectParity = ICU_dcuCCR0_L2_bit11 & carDcRead;

   // Replacing instantiation: PDP_MUX2D dp_muxDCU_parityDataADcread
   assign wordMuxA[0:31] = (wordMuxAwoParity[0:31] & {(32){~(selectParity)}} ) | ({p_dataOutA[0:15],p_dataOutB[0:15]} & {(32){selectParity}} ); 

   // Replacing instantiation: PDP_MUX2D dp_muxDCU_parityDataBDcread
   assign wordMuxB[0:31] = (wordMuxBwoParity[0:31] & {(32){~(selectParity)}} ) | ({p_dataOutA[0:15],p_dataOutB[0:15]} & {(32){selectParity}} ); 


//--------- end -----------------
p405s_DCU_fillBufBypass
 DCU_fillBufBypassSch(
  .bypassMuxOut(bypassMuxOut[0:31]),
  .SDQ_mux(SDP_buf[0:31]),
  .bypassFillSDP_sel(bypassFillSDQ_selMod[0:3]),
  .bypassMuxSel(bypassMuxSel[0:2]),
  .fillBufWord0_L2(fillBufWord0_L2[0:31]),
  .fillBufWord1_L2(fillBufWord1_L2[0:31]),
  .fillBufWord2_L2(fillBufWord2_L2[0:31]),
  .fillBufWord3_L2(fillBufWord3_L2[0:31]),
  .fillBufWord4_L2(fillBufWord4_L2[0:31]),
  .fillBufWord5_L2(fillBufWord5_L2[0:31]),
  .fillBufWord6_L2(fillBufWord6_L2[0:31]),
  .fillBufWord7_L2(fillBufWord7_L2[0:31]));


// Removed the module 'module dp_logDCU_SDQ_OCM_buf

   assign DCU_ocmData[0:31] = ~SDQ_SDP_muxOcm[0:31];

//--------- start ---------------
// rgoldiez - added p_aSideErrorRaw and p_bSideErrorRaw, one of which will get selected if
//             a flush is occuring
//            added DCU_FlushParityError to signal parity errors on castout/flushes
//            added hit_a, hit_b for flush parity errors
//
//            added a parity error latch bit to the holdReg which could feed the FDR
//            wired the new holdDR error signal p_holdDataReg_L2 from the hold reg to the FDR
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
p405s_DCU_flushReg
 DCU_flushRegSch( 
  .FDR_L2mux(FDR_L2mux[0:63]),
  .CB(CB),
  .FDR_hiMuxSel(FDR_hiMuxSel),
  .FDR_hi_E1(FDR_hiBuf_E1[0:3]),
  .FDR_hi_E2(FDR_hi_E2),
  .FDR_holdMuxSel(FDR_holdMuxSelBuf[0:3]),
  .FDR_loMuxSel(FDR_loMuxSel),
  .FDR_lo_E1(FDR_loBuf_E1[0:3]),
  .FDR_lo_E2(FDR_lo_E2),
  .FDR_outMuxSel(FDR_outMuxSel[0:1]),
  .dataOutPos_A(dataOutPos_A[0:127]),
  .p_aSideErrorRaw(p_aSideErrorRaw),
  .hit_a(hit_a_i),
  .dataOutPos_B(dataOutPos_B[0:127]),
  .p_bSideErrorRaw(p_bSideErrorRaw),
  .hit_b(hit_b_i),
  .flushIdle_state(flushIdle_state),
  .flushAlmostDone(flushAlmostDone),
  .flushDone(flushDone),
  .fillFlushToDoL2(fillFlushToDoL2),
  .oneFPL2(oneFPL2),
  .resetCore(resetCore),
  .holdDataRegWord0_L2(holdDataRegWord0_L2[0:31]),
  .holdDataRegWord1_L2(holdDataRegWord1_L2[0:31]),
  .holdDataRegWord2_L2(holdDataRegWord2_L2[0:31]),
  .holdDataRegWord3_L2(holdDataRegWord3_L2[0:31]),
  .p_holdDataReg_L2(p_holdDataReg_L2),
  .tagParityError(tagParityError),
  .DCU_FlushParityError(DCU_FlushParityError));

p405s_DCU_holdReg
 DCU_holdRegSch( 
  .holdDataRegWord0_L2(holdDataRegWord0_L2[0:31]),
  .holdDataRegWord1_L2(holdDataRegWord1_L2[0:31]),
  .holdDataRegWord2_L2(holdDataRegWord2_L2[0:31]),
  .holdDataRegWord3_L2(holdDataRegWord3_L2[0:31]),
  .p_holdDataReg_L2(p_holdDataReg_L2),
  .CB(CB),
  .FDR_hi_E1(FDR_hiBuf_E1[0:3]),
  .FDR_holdMuxSel(FDR_holdMuxSelBuf[0:3]),
  .dataOut_A(dataOut_A[0:127]),
  .p_aSideErrorRaw(p_aSideErrorRaw),
  .dataOut_B(dataOut_B[0:127]),
  .p_bSideErrorRaw(p_bSideErrorRaw),
  .tagParityError(tagParityError),
  .flushHold_E2(flush_holdBuf[0:3]));


//--------- end -----------------
//--------- start ---------------
// rgoldiez - modified both to add parity generation for the PLB read bus and parity handling write/fill buffer

// added this for hw parity injection of the data parity bits for bytes 0 and 31
   // Replacing instantiation: XOR2 dp_logDCU_hwDataParityInjection_B0
   wire p_hwInjected_fillBufB0;
   assign p_hwInjected_fillBufB0 = p_fillBuf_L2[0] ^ ICU_CCR1DCDE;

   // Replacing instantiation: XOR2 dp_logDCU_hwDataParityInjection_B31
   wire p_hwInjected_fillBufB31;
   assign p_hwInjected_fillBufB31 = p_fillBuf_L2[31] ^ ICU_CCR1DCDE;


p405s_DCU_writeBuf
 DCU_writeBufSch( 
  .WB_word0L2(WB_word0L2[0:31]),
  .WB_word1L2(WB_word1L2[0:31]),
  .WB_word2L2(WB_word2L2[0:31]),
  .WB_word3L2(WB_word3L2[0:31]),
  .p_WBhi_L2(p_WBhi_L2[0:15]),
  .CB(CB),
  .SDQ_SDP_mux(SDQ_SDP_muxBuf[0:31]),
  .p_SDQ_SDP_mux(p_SDQ_SDP_muxBuf[0:3]),
  .fillBufWord0_L2(fillBufWord0_L2[0:31]),
  .fillBufWord1_L2(fillBufWord1_L2[0:31]),
  .fillBufWord2_L2(fillBufWord2_L2[0:31]),
  .fillBufWord3_L2(fillBufWord3_L2[0:31]),
  .fillBufWord4_L2(fillBufWord4_L2[0:31]),
  .fillBufWord5_L2(fillBufWord5_L2[0:31]),
  .fillBufWord6_L2(fillBufWord6_L2[0:31]),
  .fillBufWord7_L2(fillBufWord7_L2[0:31]),
  .p_fillBuf_L2({p_hwInjected_fillBufB0,p_fillBuf_L2[1:30],p_hwInjected_fillBufB31}),
  .writeBufHi_E1(writeBufHi_E1),
  .writeBufHi_E2(writeBufHi_E2[0:3]),
  .writeBufLoTag_E1(writeBufLoTag_E1),
  .writeBufLoTag_E2(writeBufLo_E2),
  .writeBufMuxSelBit0(writeBufMuxSelBit0),
  .writeBufMuxSelBit1(writeBufMuxSelBit1[0:31]));



p405s_DCU_fillBuf
 DCU_fillBufSch( 
  .fillBufWord0_L2(fillBufWord0_L2[0:31]),
  .fillBufWord1_L2(fillBufWord1_L2[0:31]),
  .fillBufWord2_L2(fillBufWord2_L2[0:31]),
  .fillBufWord3_L2(fillBufWord3_L2[0:31]),
  .fillBufWord4_L2(fillBufWord4_L2[0:31]),
  .fillBufWord5_L2(fillBufWord5_L2[0:31]),
  .fillBufWord6_L2(fillBufWord6_L2[0:31]),
  .fillBufWord7_L2(fillBufWord7_L2[0:31]),
  .p_fillBuf_L2(p_fillBuf_L2[0:31]),
  .CB(CB),
  .PLB_dcuReadDataBus(PLB_dcuReadDataBus[0:63]),
  .SDQ_SDP_mux(SDP_buf[0:31]),
  .p_SDQ_SDP_mux(p_SDP_buf[0:3]),
  .fillBufMuxSel0(fillBufMuxSel0[0:31]),
  .fillBufMuxSel1(fillBufMuxSel1[0:31]),
  .fillBuf_E1(fillBuf_E1),
  .fillBuf_E2(fillBuf_E2[0:7]));


//--------- end -----------------
//--------- start ---------------
// rgoldiez - added to piggy back on the bypass mux that supplies data to the CPU
//            Bypassed data or dcread data of the tag cannot cause a parity error (dcread of the data too?).
// (removed)  OR reducing the byte mux selects to ensure bypassed paths for just a byte always pass zero out
// OR4_J logDCU_parityErrorBypassMuxSelB1 (
//       .Z(parityErrorBypassMuxSelB1),
//       .A(dOutMuxSelBit0Byte0),
//       .B(dOutMuxSelBit0Byte1),
//       .C(dOutMuxSelBit0Byte2),
//       .D(dOutMuxSelBit0Byte3));
// OR4_J logDCU_parityErrorBypassMuxSelB2 (
//       .Z(parityErrorBypassMuxSelB2),
//       .A(dOutMuxSelBit1Byte0),
//       .B(dOutMuxSelBit1Byte1),
//       .C(dOutMuxSelBit1Byte2),
//       .D(dOutMuxSelBit1Byte3));
   // Replacing instantiation: PDP_MUX4C dp_muxDCU_parityErrorBypassMux0
   reg dp_muxDCU_parityErrorBypassMux0_muxOut;
   wire dp_muxDCU_parityErrorBypassMux0_D0,dp_muxDCU_parityErrorBypassMux0_D1; 
   wire dp_muxDCU_parityErrorBypassMux0_D2; 
   wire dp_muxDCU_parityErrorBypassMux0_D3; 
   wire dp_muxDCU_parityErrorBypassMux0_SD1,dp_muxDCU_parityErrorBypassMux0_SD2; 
   assign loadParityError[0] = dp_muxDCU_parityErrorBypassMux0_muxOut;       
   assign dp_muxDCU_parityErrorBypassMux0_SD1 = dOutMuxSelBit0Byte0;       
   assign dp_muxDCU_parityErrorBypassMux0_SD2 = dOutMuxSelBit1Byte0;       
   assign dp_muxDCU_parityErrorBypassMux0_D0 = p_bSideLoadError[0];         
   assign dp_muxDCU_parityErrorBypassMux0_D1 = 1'b0;         
   assign dp_muxDCU_parityErrorBypassMux0_D2 = p_aSideLoadError[0];         
   assign dp_muxDCU_parityErrorBypassMux0_D3 = 1'b0;         
                                               
   always @(dp_muxDCU_parityErrorBypassMux0_SD1 or dp_muxDCU_parityErrorBypassMux0_SD2 or dp_muxDCU_parityErrorBypassMux0_D0 or dp_muxDCU_parityErrorBypassMux0_D1 or  
            dp_muxDCU_parityErrorBypassMux0_D2 or dp_muxDCU_parityErrorBypassMux0_D3)  	    
    begin 					    
    case({dp_muxDCU_parityErrorBypassMux0_SD1,dp_muxDCU_parityErrorBypassMux0_SD2})    	
     2'b00: dp_muxDCU_parityErrorBypassMux0_muxOut = dp_muxDCU_parityErrorBypassMux0_D0;    
     2'b01: dp_muxDCU_parityErrorBypassMux0_muxOut = dp_muxDCU_parityErrorBypassMux0_D1;    
     2'b10: dp_muxDCU_parityErrorBypassMux0_muxOut = dp_muxDCU_parityErrorBypassMux0_D2;    
     2'b11: dp_muxDCU_parityErrorBypassMux0_muxOut = dp_muxDCU_parityErrorBypassMux0_D3;    
      default: dp_muxDCU_parityErrorBypassMux0_muxOut = 1'bx;        
    endcase                                    
   end                                         
			//  leg which always cannot have a parity error
   // Replacing instantiation: PDP_MUX4C dp_muxDCU_parityErrorBypassMux1
   reg dp_muxDCU_parityErrorBypassMux1_muxOut;
   wire dp_muxDCU_parityErrorBypassMux1_D0,dp_muxDCU_parityErrorBypassMux1_D1; 
   wire dp_muxDCU_parityErrorBypassMux1_D2; 
   wire dp_muxDCU_parityErrorBypassMux1_D3; 
   wire dp_muxDCU_parityErrorBypassMux1_SD1,dp_muxDCU_parityErrorBypassMux1_SD2; 
   assign loadParityError[1] = dp_muxDCU_parityErrorBypassMux1_muxOut;       
   assign dp_muxDCU_parityErrorBypassMux1_SD1 = dOutMuxSelBit0Byte1;       
   assign dp_muxDCU_parityErrorBypassMux1_SD2 = dOutMuxSelBit1Byte1;       
   assign dp_muxDCU_parityErrorBypassMux1_D0 = p_bSideLoadError[1];         
   assign dp_muxDCU_parityErrorBypassMux1_D1 = 1'b0;         
   assign dp_muxDCU_parityErrorBypassMux1_D2 = p_aSideLoadError[1];         
   assign dp_muxDCU_parityErrorBypassMux1_D3 = 1'b0;         
                                               
   always @(dp_muxDCU_parityErrorBypassMux1_SD1 or dp_muxDCU_parityErrorBypassMux1_SD2 or dp_muxDCU_parityErrorBypassMux1_D0 or dp_muxDCU_parityErrorBypassMux1_D1 or  
            dp_muxDCU_parityErrorBypassMux1_D2 or dp_muxDCU_parityErrorBypassMux1_D3)  	    
    begin 					    
    case({dp_muxDCU_parityErrorBypassMux1_SD1,dp_muxDCU_parityErrorBypassMux1_SD2})    	
     2'b00: dp_muxDCU_parityErrorBypassMux1_muxOut = dp_muxDCU_parityErrorBypassMux1_D0;    
     2'b01: dp_muxDCU_parityErrorBypassMux1_muxOut = dp_muxDCU_parityErrorBypassMux1_D1;    
     2'b10: dp_muxDCU_parityErrorBypassMux1_muxOut = dp_muxDCU_parityErrorBypassMux1_D2;    
     2'b11: dp_muxDCU_parityErrorBypassMux1_muxOut = dp_muxDCU_parityErrorBypassMux1_D3;    
      default: dp_muxDCU_parityErrorBypassMux1_muxOut = 1'bx;        
    endcase                                    
   end                                         
			//  leg which always cannot have a parity error
   // Replacing instantiation: PDP_MUX4C dp_muxDCU_parityErrorBypassMux2
   reg dp_muxDCU_parityErrorBypassMux2_muxOut;
   wire dp_muxDCU_parityErrorBypassMux2_D0,dp_muxDCU_parityErrorBypassMux2_D1; 
   wire dp_muxDCU_parityErrorBypassMux2_D2; 
   wire dp_muxDCU_parityErrorBypassMux2_D3; 
   wire dp_muxDCU_parityErrorBypassMux2_SD1,dp_muxDCU_parityErrorBypassMux2_SD2; 
   assign loadParityError[2] = dp_muxDCU_parityErrorBypassMux2_muxOut;       
   assign dp_muxDCU_parityErrorBypassMux2_SD1 = dOutMuxSelBit0Byte2;       
   assign dp_muxDCU_parityErrorBypassMux2_SD2 = dOutMuxSelBit1Byte2;       
   assign dp_muxDCU_parityErrorBypassMux2_D0 = p_bSideLoadError[2];         
   assign dp_muxDCU_parityErrorBypassMux2_D1 = 1'b0;         
   assign dp_muxDCU_parityErrorBypassMux2_D2 = p_aSideLoadError[2];         
   assign dp_muxDCU_parityErrorBypassMux2_D3 = 1'b0;         
                                               
   always @(dp_muxDCU_parityErrorBypassMux2_SD1 or dp_muxDCU_parityErrorBypassMux2_SD2 or dp_muxDCU_parityErrorBypassMux2_D0 or dp_muxDCU_parityErrorBypassMux2_D1 or  
            dp_muxDCU_parityErrorBypassMux2_D2 or dp_muxDCU_parityErrorBypassMux2_D3)  	    
    begin 					    
    case({dp_muxDCU_parityErrorBypassMux2_SD1,dp_muxDCU_parityErrorBypassMux2_SD2})    	
     2'b00: dp_muxDCU_parityErrorBypassMux2_muxOut = dp_muxDCU_parityErrorBypassMux2_D0;    
     2'b01: dp_muxDCU_parityErrorBypassMux2_muxOut = dp_muxDCU_parityErrorBypassMux2_D1;    
     2'b10: dp_muxDCU_parityErrorBypassMux2_muxOut = dp_muxDCU_parityErrorBypassMux2_D2;    
     2'b11: dp_muxDCU_parityErrorBypassMux2_muxOut = dp_muxDCU_parityErrorBypassMux2_D3;    
      default: dp_muxDCU_parityErrorBypassMux2_muxOut = 1'bx;        
    endcase                                    
   end                                         
			//  leg which always cannot have a parity error
   // Replacing instantiation: PDP_MUX4C dp_muxDCU_parityErrorBypassMux3
   reg dp_muxDCU_parityErrorBypassMux3_muxOut;
   wire dp_muxDCU_parityErrorBypassMux3_D0,dp_muxDCU_parityErrorBypassMux3_D1; 
   wire dp_muxDCU_parityErrorBypassMux3_D2; 
   wire dp_muxDCU_parityErrorBypassMux3_D3; 
   wire dp_muxDCU_parityErrorBypassMux3_SD1,dp_muxDCU_parityErrorBypassMux3_SD2; 
   assign loadParityError[3] = dp_muxDCU_parityErrorBypassMux3_muxOut;       
   assign dp_muxDCU_parityErrorBypassMux3_SD1 = dOutMuxSelBit0Byte3;       
   assign dp_muxDCU_parityErrorBypassMux3_SD2 = dOutMuxSelBit1Byte3;       
   assign dp_muxDCU_parityErrorBypassMux3_D0 = p_bSideLoadError[3];         
   assign dp_muxDCU_parityErrorBypassMux3_D1 = 1'b0;         
   assign dp_muxDCU_parityErrorBypassMux3_D2 = p_aSideLoadError[3];         
   assign dp_muxDCU_parityErrorBypassMux3_D3 = 1'b0;         
                                               
   always @(dp_muxDCU_parityErrorBypassMux3_SD1 or dp_muxDCU_parityErrorBypassMux3_SD2 or dp_muxDCU_parityErrorBypassMux3_D0 or dp_muxDCU_parityErrorBypassMux3_D1 or  
            dp_muxDCU_parityErrorBypassMux3_D2 or dp_muxDCU_parityErrorBypassMux3_D3)  	    
    begin 					    
    case({dp_muxDCU_parityErrorBypassMux3_SD1,dp_muxDCU_parityErrorBypassMux3_SD2})    	
     2'b00: dp_muxDCU_parityErrorBypassMux3_muxOut = dp_muxDCU_parityErrorBypassMux3_D0;    
     2'b01: dp_muxDCU_parityErrorBypassMux3_muxOut = dp_muxDCU_parityErrorBypassMux3_D1;    
     2'b10: dp_muxDCU_parityErrorBypassMux3_muxOut = dp_muxDCU_parityErrorBypassMux3_D2;    
     2'b11: dp_muxDCU_parityErrorBypassMux3_muxOut = dp_muxDCU_parityErrorBypassMux3_D3;    
      default: dp_muxDCU_parityErrorBypassMux3_muxOut = 1'bx;        
    endcase                                    
   end                                         
			//  leg which always cannot have a parity error

   // Replacing instantiation: INVERT dp_logDCU_parityDcreadInv
   wire carDcRead_N;
   assign carDcRead_N = ~(carDcRead);

   // Replacing instantiation: AND2 dp_logDCU_parityOutputGate
   wire DCU_DA_gated;
   assign DCU_DA_gated = DCU_DA & carDcRead_N;


   // Replacing instantiation: AO2222 logDCU_parityErrorOut
   assign DCU_parityError = (loadParityError[0] & DCU_DA_gated) | (loadParityError[1] & DCU_DA_gated) | (loadParityError[2] & DCU_DA_gated) | (loadParityError[3] & DCU_DA_gated);

// added the parity for the selected way, which is used for dcread
// ICU_dcuCCR0_L2_bit11:  1 when parity read, 0 when no parity is read
//   this is used to gate off the tag parity bit on dcreads of the tag
   // Replacing instantiation: AND2 dp_logDCU_tagParityGate
   assign p_tagParityOutGated = ICU_dcuCCR0_L2_bit11 & p_tagParityOut;

assign dcReadTag = {tagMuxOut[0:20],3'b0,tagMuxOut[21], p_tagParityOutGated, tagMuxOut[22:23],3'b0,LRU_i};
p405s_DCU_bypassMux
 DCU_bypassMuxSch(
  .DCU_data_NEG(DCU_data_NEG[0:31]),
  .bypassMuxOut(bypassMuxOut[0:31]),
  .dOutMuxSelByte0({dOutMuxSelBit0Byte0,dOutMuxSelBit1Byte0}),
  .dOutMuxSelByte1({dOutMuxSelBit0Byte1,dOutMuxSelBit1Byte1}),
  .dOutMuxSelByte2({dOutMuxSelBit0Byte2,dOutMuxSelBit1Byte2}),
  .dOutMuxSelByte3({dOutMuxSelBit0Byte3,dOutMuxSelBit1Byte3}),
  .dcReadTag(dcReadTag[0:31]),
  .wordMuxA(wordMuxA[0:31]),
  .wordMuxB(wordMuxB[0:31]));

//--------- end -----------------


// Removed the module 'module dp_logDCU_aclkbuf_df
// Removed the module 'module dp_muxDCU_tagAddr2

   assign outFAR_inv[0:21] = (tagA_inv[0:21] & {22{~tagOutMuxSelFAR}}) | 
			     (tagB_inv[0:21] & {22{tagOutMuxSelFAR}}); 

// Removed the module 'module dp_logDCU_invA3
// Removed the module 'module dp_logDCU_invB3
// Removed the module 'module dp_logDCU_invB2
// Removed the module 'module dp_logDCU_invA2
// Removed the module 'module dp_logDCU_invA1
// Removed the module 'module dp_logDCU_invB1
// Removed the module 'module dp_logDCU_invB0
// Removed the module 'module dp_logDCU_invA0

   assign dataOutPos_A[0:127] = ~dataOut_A[0:127];
   assign dataOutPos_B[0:127] = ~dataOut_B[0:127];
   
   // Replacing instantiation: GTECH_NOT SGT_forceMMU_inv
   wire forceMMU;
   assign forceMMU = ~(forceDataIndexZero_mmu);

   // Replacing instantiation: GTECH_AND2 SGT_dcuDataIndexMod3
   assign MMU_27_mod = MMU_dsRA[27] & forceMMU;


// Removed the module 'module dp_regDCU_dirtyLRUwriteIndex 
// Removed the module 'module dp_regDCU_dirtyLRUreadIndex
// Removed the module 'module dp_muxDCU_PLB_AR
// Removed the module 'module dp_regDCU_PLB_AR
// Removed the module 'module dp_regDCU_SAQ
// Removed the module 'module dp_regDCU_CAR_OF
// Removed the module 'module dp_regDCU_CAR
// Removed the module 'module dp_regDCU_FAR
// Removed the module 'module dp_muxDCU_tagAddr

assign DCU_plbABus = DCU_plbABus_i;
   always @(posedge CB)  	
     begin				  	
	case(PLBAR_E1 & PLBAR_E2)		
	  1'b0: DCU_plbABus_i[0:29] <= DCU_plbABus_i[0:29];		
	  1'b1: DCU_plbABus_i[0:29] <= PLB_ARmuxOut[0:29];		
	  default: DCU_plbABus_i[0:29] <= 30'bx;  
	endcase		 		
   end			 		
   assign plbABusNeg = ~DCU_plbABus_i;
   
   
   assign SAQ_L2 = SAQ_L2_i[27:29];
   always @(posedge CB)  	
     begin				  	
	case(SAQ_E1 & SAQ_E2)		
	  1'b0: SAQ_L2_i[0:29] <= SAQ_L2_i[0:29];		
	  1'b1: SAQ_L2_i[0:29] <= {CAR_L2[0:26], CAR_buf[27:29]};		
	  default: SAQ_L2_i[0:29] <= 30'bx;  
	endcase		 		
   end			 		

   always @(posedge CB)  	
     begin				  	
	case(CAR_OF_E1 & CAR_OF_E2)		
	  1'b0: CAR_OF_L2_i[0:29] <= CAR_OF_L2_i[0:29];		
	  1'b1: CAR_OF_L2_i[0:29] <= CAR_L2[0:29];		
	  default: CAR_OF_L2_i[0:29] <= 30'bx;  
	endcase		 		
   end			 		

   always @(posedge CB)  	
     begin				  	
	case(CAR_mmuAttr_E1 & CAR_mmuAttr_E2)		
	  1'b0: CAR_L2[0:29] <= CAR_L2[0:29];		
	  1'b1: CAR_L2[0:29] <= MMU_dsRA[0:29];		
	  default: CAR_L2[0:29] <= 30'bx;  
	endcase		 		
   end			 		
   assign CAR_L2_NEG[0:29] = ~CAR_L2[0:29];

   reg    U0AttrFAR_i;
   wire	  U0AttrFAR;
   assign U0AttrFAR = U0AttrFAR_i;
   
   always @(posedge CB)  	
     begin				  	
	case(FDR_hi_E1 & FAR_E2)		
	  1'b0: {FAR_L2[0:26],U0AttrFAR_i} <= {FAR_L2[0:26],U0AttrFAR_i};		
	  1'b1: {FAR_L2[0:26],U0AttrFAR_i} <= {tagMuxOutFAR[0:20],tagIndexOutDup[3:8], U0AttrFARMux};		
	  default: {FAR_L2[0:26],U0AttrFAR_i} <= 28'bx;  
	endcase		 		
     end			 		

   always @(posedge CB)  	
     begin				  	
	case(dirtyLRU_readIndex_E1 & dirtyLRU_readIndex_E2)		
	  1'b0: dirtyLRUreadIndexNEG[0:8] <= dirtyLRUreadIndexNEG[0:8];		
	  1'b1: dirtyLRUreadIndexNEG[0:8] <= dirtyLRU_indexIn_NEG[0:8];		
	  default: dirtyLRUreadIndexNEG[0:8] <= 9'bx;  
	endcase		 		
     end			 		

   reg [0:8] dirtyLRUwriteIndexL2Neg;
   
   always @(posedge CB)  	
     begin				  	
	case(dirtyLRU_writeIndex_E1)		
	  1'b0: dirtyLRUwriteIndexL2Neg[0:8] <= dirtyLRUwriteIndexL2Neg[0:8];		
	  1'b1: dirtyLRUwriteIndexL2Neg[0:8] <= tagIndexOutDup[0:8];		
	  default: dirtyLRUwriteIndexL2Neg[0:8] <= 9'bx;  
	endcase		 		
     end			 		
   assign dirtyLRUwriteIndexL2 = ~dirtyLRUwriteIndexL2Neg;
   
   assign tagMuxOut[0:23] = ~((tagA_inv[0:23] & {24{~ICU_dcuCCR0_L2_bit10}}) | 
			      (tagB_inv[0:23] & {24{ICU_dcuCCR0_L2_bit10}})); 

   assign PLB_ARmuxOut[0:29] = (FAR_OF[0:29] & {30{~PLBAR_selSAQ}}) | (SAQ_L2_i[0:29] & {30{PLBAR_selSAQ}}); 
//--------- start ---------------
// rgoldiez - added to mux the parity bit for A/B on a dcread
   // Replacing instantiation: PDP_MUX2DI dp_muxDCU_parityTagAddr
   assign p_tagParityOut = ~( (p_parityAInv & {(1){~(ICU_dcuCCR0_L2_bit10)}} ) | (p_parityBInv & {(1){ICU_dcuCCR0_L2_bit10}} ) ); 

//--------- end -----------------
//--------- start ---------------
// rgoldiez - changed to added parity bits that need to be steered with its data

p405s_DCU_dataSteering
 
  dataSteeringSch(.SDQ_mod            (DCU_SDQ_modified[0:31]), 
		  .p_SDQ_mod          (p_DCU_SDQ_modified[0:3]),
		  .CAR_endian         (CAR_endian), 
		  .CB                 (CB), 
		  .PCL_stSteerCntl    (PCL_stSteerCntl[0:9]),
		  .SAQ_E2             (SAQ_E2), 
		  .SDQ_E1             (SDQ_E1), 
		  .SDQ_E2             (SDQ_E2), 
		  .SDQ_L2             (SDQ_L2[0:31]), 
		  .p_SDQ_L2           (p_SDQ_L2[0:3]), 
		  .carStore           (carStore), 
		  .ocmCompleteXltVNoWaitNoHold (ocmCompleteXltVNoWaitNoHold)); // added for issue 206

//--------- end -----------------


// Removed the module 'module dp_regDCU_SDQ

   always @(posedge CB)  	
     begin				  	
	case(SDQ_E1 & SDQ_E2)		
	  1'b0: SDQ_L2[0:31] <= SDQ_L2[0:31];		
	  1'b1: SDQ_L2[0:31] <= EXE_dcuData[0:31];		
	  default: SDQ_L2[0:31] <= 32'bx;  
	endcase		 		
     end			 		

//--------- start ---------------
// rgoldiez - added for parity generation on the EXE results that are going to be stored
   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_paritySDQ
   reg [0:3] dp_regDCU_paritySDQ_regL2;
   wire [0:3] dp_regDCU_paritySDQ_D; 
   wire dp_regDCU_paritySDQ_E1; 
   assign p_SDQ_L2[0:3] = dp_regDCU_paritySDQ_regL2;     	
   assign dp_regDCU_paritySDQ_E1 = SDQ_E1 & SDQ_E2;     
   assign dp_regDCU_paritySDQ_D = p_EXE_dcuData[0:3];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_paritySDQ_E1)	                
     1'b0: dp_regDCU_paritySDQ_regL2 <= dp_regDCU_paritySDQ_regL2;		
     1'b1: dp_regDCU_paritySDQ_regL2 <= dp_regDCU_paritySDQ_D;		
      default: dp_regDCU_paritySDQ_regL2 <= 4'bx;  
    endcase		 		
   end			 		

// Removed the module 'module dp_logDCU_parityGen8, 4 instances

   assign p_EXE_dcuData[0] = ^{EXE_dcuData[0:7]};
   assign p_EXE_dcuData[1] = ^{EXE_dcuData[8:15]};
   assign p_EXE_dcuData[2] = ^{EXE_dcuData[16:23]};
   assign p_EXE_dcuData[3] = ^{EXE_dcuData[24:31]};

endmodule

