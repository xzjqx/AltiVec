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

module p405s_DCU_ram16K( DCU_icuSize, 
                   LRU,  
                   U0AttrA, 
                   U0AttrB,
                   dataOut_A, 
                   dataOut_B, 
                   p_dataOutA, 
                   p_dataOutB,
                   dirtyA, 
                   dirtyB, 
                   hit_a, 
                   hit_a_buf1, 
                   hit_b, 
                   hit_b_buf1,
                   tagAOut, 
                   tagBOut, 
                   p_parityA, 
                   p_parityB, 
                   validA, 
                   validB, 
                   CAR_L2, 
                   CAR_L2_NEG,
                   CB, 
                   MMU_diagOut, 
                   WB_L2, 
                   p_WBhi_L2, 
                   WB_tagL1, 
                   p_wbTagL1, 
                   byteWriteData,
                   byteWrite_E1, 
                   cacheableSpecialOp, 
                   dataIndexA, 
                   dataIndexB, 
                   p_dataIndexP, 
                   dataReadNotWrite_In,
                   dataReadWriteCycle_In, 
                   dirtyLRUreadIndexL2, 
                   dirtyLRUwriteIndexL2, 
                   newDirty,
                   newLRU, 
                   newValidIn, 
                   readLRUDirty, 
                   tagIndex, 
                   tagReadNotWrite_In,
                   tagReadWriteCycle_In, 
                   testEn, 
                   wbU0AttrL1, 
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
                   resetMemBist,
                   dcu_bist_debug_si,
                   dcu_bist_debug_so,
                   dcu_bist_debug_en,
                   dcu_bist_mode_reg_in,
                   dcu_bist_mode_reg_out,
                   dcu_bist_parallel_dr,
                   dcu_bist_mode_reg_si,
                   dcu_bist_mode_reg_so,
                   dcu_bist_shift_dr,
                   dcu_bist_mbrun
                  );


// Modified to match Prowler edits:  RDE 4/12/00
//      newLRU, newU0AttrIn, newValidIn, readLRUDirty, scanIn, tagIndex[0:9], tagReadNotWrite_In,
//     tagReadWriteCycle_In, testEn, writeDataA0, writeDataA1, writeDataB0, writeDataB1,
//     writeDirtyA, writeDirtyB, writeLRU, writeTagA0, writeTagA1, writeTagB0, writeTagB1,
//     xltValidLth );

output  LRU;
output  U0AttrA;
output  U0AttrB;
output  dirtyA;
output  dirtyB;
output  hit_a;
output  hit_a_buf1;
output  hit_b;
output  hit_b_buf1;
output  validA;
output  validB;

input  byteWrite_E1;
input  cacheableSpecialOp;
input  dataReadNotWrite_In;
input  dataReadWriteCycle_In;
input  newDirty;
input  newLRU;
input  newValidIn;
input  readLRUDirty;
input  tagReadNotWrite_In;
input  tagReadWriteCycle_In;
input  testEn;
input  wbU0AttrL1;
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


//--------- start ---------------
// rgoldiez - added this for ICU BIST connection
//--------- end -----------------

// Modified to match Prowler edits:  RDE 4/12/00
//     newU0AttrIn, newValidIn, readLRUDirty, scanIn, tagReadNotWrite_In, tagReadWriteCycle_In,
//     testEn, writeDataA0, writeDataA1, writeDataB0, writeDataB1, writeDirtyA, writeDirtyB,

output [0:127]  dataOut_B;
output [0:2]  DCU_icuSize;
output [0:20]  tagAOut;
output [0:20]  tagBOut;
output [0:127]  dataOut_A;

//--------- start ---------------
// rgoldiez - added these IOs for the parity data to and from the parity array
output [0:15]  p_dataOutA;
output [0:15]  p_dataOutB;
output         p_parityA; 
output         p_parityB;
input  [0:15]  p_WBhi_L2;
input  [0:9]   p_dataIndexP;
input          p_wbTagL1;
//--------- end -----------------

input [0:9]  tagIndex;
input [0:2]  MMU_diagOut;
input [0:127]  WB_L2;
input [0:20]  CAR_L2_NEG;
input [0:20]  CAR_L2;
input        CB;
input [0:8]  dirtyLRUwriteIndexL2;
input [0:8]  dirtyLRUreadIndexL2;
input [0:9]  dataIndexA;
input [0:15]  byteWriteData;
input [0:20]  WB_tagL1;
input [0:9]  dataIndexB;

input resetMemBist;   // sync reset for dcu membist

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


wire  hit_aInv;
wire  hit_bInv;

wire  hit_a_buf2;
wire  hit_b_buf2;

// Don't read from output ports

wire  hit_a_i;
wire  hit_b_i;
wire  validA_i;
wire  validB_i;

wire [0:20]  tagAOut_i;
wire [0:20]  tagBOut_i;

assign hit_a   = hit_a_i;
assign hit_b   = hit_b_i;
assign validA  = validA_i;
assign validB  = validB_i;
assign tagAOut = tagAOut_i;
assign tagBOut = tagBOut_i;


// BIST wires and regs

wire          dcu_bist_mode;
wire          bist_ce_n_m0;
wire          bist_we_n_m0;
wire [8:0]    bist_addr_m0;
wire [127:0]  bist_wr_data_m0;
wire [127:0]  bist_rd_data_m0;
wire          bist_ce_n_m1;
wire          bist_we_n_m1;
wire [8:0]    bist_addr_m1;
wire [127:0]  bist_wr_data_m1;
wire [127:0]  bist_rd_data_m1;
wire          bist_ce_n_m2;
wire          bist_we_n_m2;
wire [7:0]    bist_addr_m2;
wire [47:0]   bist_wr_data_m2;
wire [47:0]   bist_rd_data_m2;
wire          bist_ce_n_m3;
wire          bist_we_n_m3;
wire [8:0]    bist_addr_m3;
wire [31:0]   bist_wr_data_m3;
wire [31:0]   bist_rd_data_m3;
wire [8:0]    cap_mem_addr_m0;
wire [127:0]  cap_mem_wr_data_m0;
wire          cap_mem_we_m0;
wire [8:0]    cap_mem_addr_m1;
wire [127:0]  cap_mem_wr_data_m1;
wire          cap_mem_we_m1;
wire [7:0]    cap_mem_addr_m2;
wire [47:0]   cap_mem_wr_data_m2;
wire          cap_mem_we_m2;
wire [8:0]    cap_mem_addr_m3;
wire [31:0]   cap_mem_wr_data_m3;
wire          cap_mem_we_m3;


p405s_dcu_dirtyLRU_16K
 dirtyLRU_Sch( .LRU  (LRU),
                           .dirtyA        (dirtyA),
                           .dirtyB        (dirtyB),
                           .CB            (CB),
                           .dirtyLRUreadIndexL2   (dirtyLRUreadIndexL2[0:8]),
                           .dirtyLRUwriteIndexL2  (dirtyLRUwriteIndexL2[0:8]),
                           .newDirty      (newDirty),
                           .newLRU        (newLRU),
                           .readLRUDirty  (readLRUDirty),
                           .writeDirtyA   (writeDirtyA),
                           .writeDirtyB   (writeDirtyB),
                           .writeLRU      (writeLRU)
                          );

//--------- start ---------------
// rgoldiez - added p_ connections for the parity data to and from the tag array

p405s_dcu_tagArray_16K
 tag ( 
     .DCU_icuSize   (DCU_icuSize[0:2]),
     .U0AttrA       (U0AttrA),
     .U0AttrB       (U0AttrB),
     .tagAOut       (tagAOut_i[0:20]),
     .tagBOut       (tagBOut_i[0:20]),
     .p_parityA     (p_parityA),
     .p_parityB     (p_parityB),
     .validA        (validA_i),
     .validB        (validB_i),
     .CB            (CB),
     .dataIn        (WB_tagL1[0:20]),
     .p_tag         (p_wbTagL1),
     .hit_a_buf2    (hit_a_buf2),
     .hit_b_buf2    (hit_b_buf2),
     .newValidIn    (newValidIn),
     .tagIndex      (tagIndex[0:9]),
     .tagReadNotWrite_In     (tagReadNotWrite_In),
     .tagReadWriteCycle_In   (tagReadWriteCycle_In),
     .wbU0AttrL1    (wbU0AttrL1),
     .writeTagA0    (writeTagA0),
     .writeTagA1    (writeTagA1),
     .writeTagB0    (writeTagB0),
     .writeTagB1    (writeTagB1),
     .bist_mode     (dcu_bist_mode),
     .bist_ce_n     (bist_ce_n_m2),
     .bist_we_n     (bist_we_n_m2),
     .bist_addr     (bist_addr_m2),
     .bist_wr_data  (bist_wr_data_m2),
     .bist_rd_data  (bist_rd_data_m2),
     .cap_mem_addr     (cap_mem_addr_m2),
     .cap_mem_wr_data  (cap_mem_wr_data_m2),
     .cap_mem_we       (cap_mem_we_m2)
    );

//--------- end -----------------

// Modified to match Prowler edits:  RDE 4/12/00
//     WB_tagL1[0:20], hit_a_buf2, hit_b_buf2, newU0AttrIn, newValidIn, dataArrayScanOut,
//     tagIndex[0:9], tagReadNotWrite_In, tagReadWriteCycle_In, writeTagA0, writeTagA1,
//     writeTagB0, writeTagB1);

//--------- start ---------------
// rgoldiez - added p_ connections for the parity data to and from the arrays

p405s_dcu_dataArray_16K
 data ( 
     .dataOutA       (dataOut_A[0:127]),
     .dataOutB       (dataOut_B[0:127]),
     .p_dataOutA     (p_dataOutA[0:15]),
     .p_dataOutB     (p_dataOutB[0:15]),
     .CB             (CB),
     .byteWrite      (byteWriteData[0:15]),
     .byteWrite_E1   (byteWrite_E1),
     .dataIn         (WB_L2[0:127]),
     .p_WBhi_L2      (p_WBhi_L2[0:15]),
     .dataIndexA     (dataIndexA[0:9]),
     .dataIndexB     (dataIndexB[0:9]),
     .p_dataIndexP   (p_dataIndexP[0:9]),
     .dataReadNotWrite_In    (dataReadNotWrite_In),
     .dataReadWriteCycle_In  (dataReadWriteCycle_In),
     .hit_a_buf2     (hit_a_buf2),
     .hit_b_buf2     (hit_b_buf2),
     .testEn         (testEn),
     .writeDataA0    (writeDataA0),
     .writeDataA1    (writeDataA1),
     .writeDataB0    (writeDataB0),
     .writeDataB1    (writeDataB1),
     .bist_mode       (dcu_bist_mode),
     .bist_ce_n_m0    (bist_ce_n_m0),
     .bist_we_n_m0    (bist_we_n_m0),
     .bist_addr_m0    (bist_addr_m0),
     .bist_wr_data_m0 (bist_wr_data_m0),
     .bist_rd_data_m0 (bist_rd_data_m0),
     .bist_ce_n_m1    (bist_ce_n_m1),
     .bist_we_n_m1    (bist_we_n_m1),
     .bist_addr_m1    (bist_addr_m1),
     .bist_wr_data_m1 (bist_wr_data_m1),
     .bist_rd_data_m1 (bist_rd_data_m1),
     .bist_ce_n_m2    (bist_ce_n_m3),
     .bist_we_n_m2    (bist_we_n_m3),
     .bist_addr_m2    (bist_addr_m3),
     .bist_wr_data_m2 (bist_wr_data_m3),
     .bist_rd_data_m2 (bist_rd_data_m3),
     .cap_mem_addr_m0     (cap_mem_addr_m0),
     .cap_mem_wr_data_m0  (cap_mem_wr_data_m0),
     .cap_mem_we_m0       (cap_mem_we_m0),
     .cap_mem_addr_m1     (cap_mem_addr_m1),
     .cap_mem_wr_data_m1  (cap_mem_wr_data_m1),
     .cap_mem_we_m1       (cap_mem_we_m1),
     .cap_mem_addr_m2     (cap_mem_addr_m3),
     .cap_mem_wr_data_m2  (cap_mem_wr_data_m3),
     .cap_mem_we_m2       (cap_mem_we_m3)
   );

//--------- end -----------------

// Removed the module "dp_logDCU_hitBuf"
  assign {hit_a_buf1, hit_b_buf1} = ~({hit_aInv, hit_bInv});

// Removed the module "dp_logDCU_hitBuf2"
  assign {hit_aInv, hit_bInv} = ~({hit_a_i, hit_b_i});

// Removed the module "dp_logDCU_hitBuf3"
  assign {hit_a_buf2, hit_b_buf2} = ~({hit_aInv, hit_bInv});

// Removed the module "dp_logDCU_bclkInv"
// The output was not used so it was removed.

// Removed the module "HM_COMP24B"
assign hit_b_i = (cacheableSpecialOp & xltValidLth & validB_i) &
               (((tagBOut_i[20] & CAR_L2[20]) | (~tagBOut_i[20] & CAR_L2_NEG[20])) &
                ((tagBOut_i[19] & CAR_L2[19]) | (~tagBOut_i[19] & CAR_L2_NEG[19])) &
                ((tagBOut_i[18] & CAR_L2[18]) | (~tagBOut_i[18] & CAR_L2_NEG[18])) &
                ((tagBOut_i[17] & CAR_L2[17]) | (~tagBOut_i[17] & CAR_L2_NEG[17])) &
                ((tagBOut_i[16] & CAR_L2[16]) | (~tagBOut_i[16] & CAR_L2_NEG[16])) &
                ((tagBOut_i[15] & CAR_L2[15]) | (~tagBOut_i[15] & CAR_L2_NEG[15])) &
                ((tagBOut_i[14] & CAR_L2[14]) | (~tagBOut_i[14] & CAR_L2_NEG[14])) &
                ((tagBOut_i[13] & CAR_L2[13]) | (~tagBOut_i[13] & CAR_L2_NEG[13])) &
                ((tagBOut_i[12] & CAR_L2[12]) | (~tagBOut_i[12] & CAR_L2_NEG[12])) &
                ((tagBOut_i[11] & CAR_L2[11]) | (~tagBOut_i[11] & CAR_L2_NEG[11])) &
                ((tagBOut_i[10] & CAR_L2[10]) | (~tagBOut_i[10] & CAR_L2_NEG[10])) &
                ((tagBOut_i[9] & CAR_L2[9]) | (~tagBOut_i[9] & CAR_L2_NEG[9])) &
                ((tagBOut_i[8] & CAR_L2[8]) | (~tagBOut_i[8] & CAR_L2_NEG[8])) &
                ((tagBOut_i[7] & CAR_L2[7]) | (~tagBOut_i[7] & CAR_L2_NEG[7])) &
                ((tagBOut_i[6] & CAR_L2[6]) | (~tagBOut_i[6] & CAR_L2_NEG[6])) &
                ((tagBOut_i[5] & CAR_L2[5]) | (~tagBOut_i[5] & CAR_L2_NEG[5])) &
                ((tagBOut_i[4] & CAR_L2[4]) | (~tagBOut_i[4] & CAR_L2_NEG[4])) &
                ((tagBOut_i[3] & CAR_L2[3]) | (~tagBOut_i[3] & CAR_L2_NEG[3])) &
                ((tagBOut_i[2] & CAR_L2[2]) | (~tagBOut_i[2] & CAR_L2_NEG[2])) &
                ((tagBOut_i[1] & CAR_L2[1]) | (~tagBOut_i[1] & CAR_L2_NEG[1])) &
                ((tagBOut_i[0] & CAR_L2[0]) | (~tagBOut_i[0] & CAR_L2_NEG[0])));

assign hit_a_i = (cacheableSpecialOp & xltValidLth & validA_i) &
               (((tagAOut_i[20] & CAR_L2[20]) | (~tagAOut_i[20] & CAR_L2_NEG[20])) &
                ((tagAOut_i[19] & CAR_L2[19]) | (~tagAOut_i[19] & CAR_L2_NEG[19])) &
                ((tagAOut_i[18] & CAR_L2[18]) | (~tagAOut_i[18] & CAR_L2_NEG[18])) &
                ((tagAOut_i[17] & CAR_L2[17]) | (~tagAOut_i[17] & CAR_L2_NEG[17])) &
                ((tagAOut_i[16] & CAR_L2[16]) | (~tagAOut_i[16] & CAR_L2_NEG[16])) &
                ((tagAOut_i[15] & CAR_L2[15]) | (~tagAOut_i[15] & CAR_L2_NEG[15])) &
                ((tagAOut_i[14] & CAR_L2[14]) | (~tagAOut_i[14] & CAR_L2_NEG[14])) &
                ((tagAOut_i[13] & CAR_L2[13]) | (~tagAOut_i[13] & CAR_L2_NEG[13])) &
                ((tagAOut_i[12] & CAR_L2[12]) | (~tagAOut_i[12] & CAR_L2_NEG[12])) &
                ((tagAOut_i[11] & CAR_L2[11]) | (~tagAOut_i[11] & CAR_L2_NEG[11])) &
                ((tagAOut_i[10] & CAR_L2[10]) | (~tagAOut_i[10] & CAR_L2_NEG[10])) &
                ((tagAOut_i[9] & CAR_L2[9]) | (~tagAOut_i[9] & CAR_L2_NEG[9])) &
                ((tagAOut_i[8] & CAR_L2[8]) | (~tagAOut_i[8] & CAR_L2_NEG[8])) &
                ((tagAOut_i[7] & CAR_L2[7]) | (~tagAOut_i[7] & CAR_L2_NEG[7])) &
                ((tagAOut_i[6] & CAR_L2[6]) | (~tagAOut_i[6] & CAR_L2_NEG[6])) &
                ((tagAOut_i[5] & CAR_L2[5]) | (~tagAOut_i[5] & CAR_L2_NEG[5])) &
                ((tagAOut_i[4] & CAR_L2[4]) | (~tagAOut_i[4] & CAR_L2_NEG[4])) &
                ((tagAOut_i[3] & CAR_L2[3]) | (~tagAOut_i[3] & CAR_L2_NEG[3])) &
                ((tagAOut_i[2] & CAR_L2[2]) | (~tagAOut_i[2] & CAR_L2_NEG[2])) &
                ((tagAOut_i[1] & CAR_L2[1]) | (~tagAOut_i[1] & CAR_L2_NEG[1])) &
                ((tagAOut_i[0] & CAR_L2[0]) | (~tagAOut_i[0] & CAR_L2_NEG[0])));

//--------- start ---------------
// rgoldiez - added p_DCU_diagOutRamP for DCU BIST checking
// rgoldiez - added ICU_diagOutParity for ICU BIST checking
 // this logic is removed, IBM BIST IS NOT USED FOR I/D CACHE for Soft COre.

//DCU_diagMux DCU_diagMuxSch( DCU_diagOut, diagScanOut, DCU_diagOutRam1, DCU_diagOutRam2,
//     DCU_diagOutTag, p_DCU_diagOutRamP, ICU_diagOutDataA, ICU_diagOutDataB, ICU_diagOutTag, ICU_diagOutParity,
//     MMU_diagOut[0:2], CB[3], bclkInv, vldArrayScanOut);


//--------- end -----------------
//--------- start ---------------
// rgoldiez - added p_PFP for DCU parity pass/fail
// rgoldiez - added ICU_dcuParity_PF for ICU parity pass/fail
// pmcilmoyle - added BIST_sysPF[0:7] as outputs to go up to core PO's
//

//BIST1N  bist( .ABDONE(DCU_abDone), .MI00(MI[0]), .MI01(MI[1]), .MI02(MI[2]), .MI03(MI[3]),
//     .MI04(MI[4]), .MI05(MI[5]), .MI06(MI[6]), .MI07(MI[7]), .MI08(MI[8]), .MI09(MI[9]),
//     .MI10(MI[10]), .MI11(MI[11]), .MI12(MI[12]), .MI13(MI[13]), .MI14(MI[14]), .MI15(MI[15]),
//     .MI16(MI[16]), .MI17(MI[17]), .MI18(MI[18]), .MI19(MI[19]), .MI20(MI[20]), .MI21(MI[21]),
//     .MI22(MI[22]), .MI23(MI[23]), .MI24(MI[24]), .MI25(MI[25]), .SCANOUT(scanOut), .SYSPF00(BIST_sysPF[0]),
//     .SYSPF01(BIST_sysPF[1]), .SYSPF02(BIST_sysPF[2]), .SYSPF03(BIST_sysPF[3]), .SYSPF04(BIST_sysPF[4]),
//     .SYSPF05(BIST_sysPF[5]), .SYSPF06(BIST_sysPF[6]), .SYSPF07(BIST_sysPF[7]), .SYSPF08(pf08noConn),
//     .SYSPF09(pf09noCon), .SYSPF10(pf10noConn), .SYSPF11(pf11noConn), .SYSPF12(pf12noConn),
//     .SYSPF13(pf13noConn), .SYSPF14(pf14noConn), .SYSPF15(pf15noConn), .ACLK(CB[3]),
//     .BCLK(bclkInv), .CCLK(LSSD_bistCClk), .ENABLE(LSSD_c405BistCE1Enable), .EVS(LSSD_c405CE0EVS), .LBIST(LSSD_c405BistCE0LBist),
//     .PF00(PF00), .PF01(PF01), .PF02(PF02), .PF03(ICU_dcuTag_PF), .PF04(ICU_dcuDataA_PF),
//     .PF05(ICU_dcuDataB_PF), .PF06(p_PFP), .PF07(ICU_dcuParity_PF),
//     .PF08(1'b0), .PF09(1'b0), .PF10(1'b0),
//     .PF11(1'b0), .PF12(1'b0), .PF13(1'b0),
//     .PF14(1'b0), .PF15(1'b0), .PG1(LSSD_c405BistCE1PG1),
//     .SCANIN(diagScanOut), .STCLK(LSSD_c405BistCE0StClk), .TESTM1(LSSD_testM1),
//     .TESTM3(LSSD_testM3));
//--------- end -----------------

// Drive the dw_rambist placeholder ports

  assign dcu_bist_mode  = 1'b0;
  assign dcu_bist_mode_reg_so  = 1'b0;
  assign dcu_bist_mode_reg_out  = 19'b0;
  assign dcu_bist_debug_so  = 4'b0;
  assign bist_addr_m0  = 9'b0;
  assign bist_wr_data_m0  = 128'b0;
  assign bist_ce_n_m0  = 1'b1;
  assign bist_we_n_m0  = 1'b1;
  assign bist_addr_m1  = 9'b0;
  assign bist_wr_data_m1  = 128'b0;
  assign bist_ce_n_m1  = 1'b1;
  assign bist_we_n_m1  = 1'b1;
  assign bist_addr_m2  = 8'b0;
  assign bist_wr_data_m2  = 48'b0;
  assign bist_ce_n_m2  = 1'b1;
  assign bist_we_n_m2  = 1'b1;
  assign bist_addr_m3  = 9'b0;
  assign bist_wr_data_m3  = 32'b0;
  assign bist_ce_n_m3  = 1'b1;
  assign bist_we_n_m3  = 1'b1;

endmodule
