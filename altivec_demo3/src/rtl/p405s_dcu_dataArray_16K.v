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

module p405s_dcu_dataArray_16K( dataOutA,
                                dataOutB, 
                                p_dataOutA, 
                                p_dataOutB,
                                CB, 
                                byteWrite, 
                                byteWrite_E1, 
                                dataIn, 
                                p_WBhi_L2, 
                                dataIndexA, 
                                dataIndexB, 
                                p_dataIndexP,
                                dataReadNotWrite_In, 
                                dataReadWriteCycle_In, 
                                hit_a_buf2, 
                                hit_b_buf2, 
                                testEn,
                                writeDataA0, 
                                writeDataA1, 
                                writeDataB0, 
                                writeDataB1,
                                bist_mode,
                                bist_ce_n_m0,
                                bist_we_n_m0,
                                bist_addr_m0,
                                bist_wr_data_m0,
                                bist_rd_data_m0,
                                bist_ce_n_m1,
                                bist_we_n_m1,
                                bist_addr_m1,
                                bist_wr_data_m1,
                                bist_rd_data_m1,
                                bist_ce_n_m2,
                                bist_we_n_m2,
                                bist_addr_m2,
                                bist_wr_data_m2,
                                bist_rd_data_m2,
                                cap_mem_addr_m0,
                                cap_mem_wr_data_m0,
                                cap_mem_we_m0,
                                cap_mem_addr_m1,
                                cap_mem_wr_data_m1,
                                cap_mem_we_m1,
                                cap_mem_addr_m2,
                                cap_mem_wr_data_m2,
                                cap_mem_we_m2
                               );

input   [0:9]  p_dataIndexP;
input   [0:15] p_WBhi_L2;
output  [0:15] p_dataOutA;
output  [0:15] p_dataOutB;

input  byteWrite_E1;
input  dataReadNotWrite_In;
input  dataReadWriteCycle_In;
input  hit_a_buf2;
input  hit_b_buf2;
input  testEn;
input  writeDataA0;
input  writeDataA1;
input  writeDataB0;
input  writeDataB1;

output [0:127]  dataOutA;
output [0:127]  dataOutB;

input [0:9]  dataIndexA;
input [0:9]  dataIndexB;
input [0:127]  dataIn;
input [0:15]  byteWrite;
input         CB;

// RAM BIST IO

output [127:0]  bist_rd_data_m0;
output [127:0]  bist_rd_data_m1;
output [31:0]   bist_rd_data_m2;

input  bist_mode;
input  bist_ce_n_m0;
input  bist_we_n_m0;
input [8:0] bist_addr_m0;
input [127:0]  bist_wr_data_m0;
input  bist_ce_n_m1;
input  bist_we_n_m1;
input [8:0] bist_addr_m1;
input [127:0] bist_wr_data_m1;
input  bist_ce_n_m2;
input  bist_we_n_m2;
input [8:0] bist_addr_m2;
input [31:0] bist_wr_data_m2;
output [8:0]   cap_mem_addr_m0;
output [127:0] cap_mem_wr_data_m0;
output         cap_mem_we_m0;
output [8:0]   cap_mem_addr_m1;
output [127:0] cap_mem_wr_data_m1;
output         cap_mem_we_m1;
output [8:0]   cap_mem_addr_m2;
output [31:0]  cap_mem_wr_data_m2;
output         cap_mem_we_m2;
  

// Buses in the design

wire  [0:15]  writeAndByteWriteB0;
wire  [0:15]  writeAndByteWriteB1;
reg   [0:15]  bwB;
wire  [0:15]  byteWriteAL2;
reg   [0:15]  bwA;
wire  [0:15]  writeAndByteWriteA1;
wire  [0:15]  writeAndByteWriteA0;
wire  [0:7]  writeDataBmux2;
wire  [0:7]  writeDataBmux;
wire  [0:7]  writeDataAmux;
wire  [0:7]  writeDataAmux2;
wire  [0:15]  byteWriteBL2;
wire  [0:15]  byteWriteTest;
wire  [0:15]  byteWriteInv;
reg   [0:7]  b1noConn;
reg   [0:7]  b0noConn;
reg   [0:7]  a1noConn;
reg   [0:7]  a0noConn;

// New sram_enable
wire readWriteCycleL1;

wire writeA0Buf1;
wire writeA1Buf1;
wire writeB0Buf1;
wire writeB1Buf1;
wire writeA0Buf2;
wire writeA1Buf2;
wire writeB0Buf2;
wire writeB1Buf2;

wire byteWrite_E1Inv;
wire byteWrite_E1_buf1;
wire byteWrite_E1_buf2;

// Regs for component removal
reg  RNW_noConn;
reg  readNotWriteL1;

assign byteWrite_E1Inv = ~(byteWrite_E1);
assign byteWrite_E1_buf1 = ~(byteWrite_E1Inv);
assign byteWrite_E1_buf2 = ~(byteWrite_E1Inv);

assign byteWriteTest[0:15] = byteWriteInv[0:15] ^ {16{testEn}};
assign byteWriteInv[0:15] = ~(byteWrite[0:15]);

// ByteWrite NOR gates
assign writeAndByteWriteA0[0:7] = ~( {8{writeA0Buf1}} | {byteWriteInv[0:1],byteWriteInv[4:5], 
                                     byteWriteInv[8:9], byteWriteInv[12:13]} );
assign writeAndByteWriteA1[0:7] = ~( {8{writeA1Buf1}} | {byteWriteTest[0:1],byteWriteTest[4:5], 
                                     byteWriteTest[8:9], byteWriteTest[12:13]} );
assign writeAndByteWriteA0[8:15] = ~( {8{writeA0Buf2}} | {byteWriteInv[2:3],byteWriteInv[6:7], 
                                      byteWriteInv[10:11], byteWriteInv[14:15]} );
assign writeAndByteWriteA1[8:15] = ~( {8{writeA1Buf2}} | {byteWriteTest[2:3],byteWriteTest[6:7],
                                      byteWriteTest[10:11], byteWriteTest[14:15]} );

assign writeAndByteWriteB0[0:7] = ~( {8{writeB0Buf1}} | {byteWriteInv[0:1],byteWriteInv[4:5], 
                                     byteWriteInv[8:9], byteWriteInv[12:13]} );
assign writeAndByteWriteB1[0:7] = ~( {8{writeB1Buf1}} | {byteWriteTest[0:1],byteWriteTest[4:5], 
                                     byteWriteTest[8:9], byteWriteTest[12:13]} );
assign writeAndByteWriteB0[8:15] = ~( {8{writeB0Buf2}} | {byteWriteInv[2:3],byteWriteInv[6:7], 
                                      byteWriteInv[10:11], byteWriteInv[14:15]} );
assign writeAndByteWriteB1[8:15] = ~( {8{writeB1Buf2}} | {byteWriteTest[2:3],byteWriteTest[6:7],
                                      byteWriteTest[10:11], byteWriteTest[14:15]} );

// DCU Data Rams, posedge clocked
p405s_dcu_cdsModule_0
 ram2Sch (  
     .dataOutA1   (dataOutA[16:31]),
     .dataOutA2   (dataOutA[48:63]),
     .dataOutA3   (dataOutA[80:95]),
     .dataOutA4   (dataOutA[112:127]),
     .dataOutB1   (dataOutB[16:31]),
     .dataOutB2   (dataOutB[48:63]),
     .dataOutB3   (dataOutB[80:95]),
     .dataOutB4   (dataOutB[112:127]),
     .addr        (dataIndexB[1:9]),
     .byteWriteA  ({byteWriteAL2[2:3], byteWriteAL2[6:7], byteWriteAL2[10:11], 
                   byteWriteAL2[14:15]}),
     .byteWriteB  ({byteWriteBL2[2:3], byteWriteBL2[6:7], byteWriteBL2[10:11], 
                   byteWriteBL2[14:15]}),
     .cclk        (CB),
     .dataIn      ({dataIn[16:31], dataIn[48:63], dataIn[80:95], dataIn[112:127]}),
     .readWrite   (readNotWriteL1),
     .sram_cen    (~readWriteCycleL1),    // chip enable not
     .bist_mode   (bist_mode),
     .bist_ce_n   (bist_ce_n_m0),
     .bist_we_n   (bist_we_n_m0),
     .bist_addr   (bist_addr_m0),
     .bist_wr_data     (bist_wr_data_m0),
     .bist_rd_data     (bist_rd_data_m0),
     .cap_mem_addr     (cap_mem_addr_m0),
     .cap_mem_wr_data  (cap_mem_wr_data_m0),
     .cap_mem_we       (cap_mem_we_m0)
     );

p405s_dcu_cdsModule_0
 ram1Sch (
     .dataOutA1  (dataOutA[0:15]),
     .dataOutA2  (dataOutA[32:47]),
     .dataOutA3  (dataOutA[64:79]),
     .dataOutA4  (dataOutA[96:111]),
     .dataOutB1  (dataOutB[0:15]),
     .dataOutB2  (dataOutB[32:47]),
     .dataOutB3  (dataOutB[64:79]),
     .dataOutB4  (dataOutB[96:111]),
     .addr       (dataIndexA[1:9]),
     .byteWriteA ({byteWriteAL2[0:1], byteWriteAL2[4:5], byteWriteAL2[8:9], 
                   byteWriteAL2[12:13]}),
     .byteWriteB ({byteWriteBL2[0:1], byteWriteBL2[4:5], byteWriteBL2[8:9], 
                   byteWriteBL2[12:13]}),
     .cclk       (CB),
     .dataIn     ({dataIn[0:15], dataIn[32:47], dataIn[64:79], dataIn[96:111]}),
     .readWrite  (readNotWriteL1),
     .sram_cen   (~readWriteCycleL1),   // chip enable not
     .bist_mode  (bist_mode),
     .bist_ce_n  (bist_ce_n_m1),
     .bist_we_n  (bist_we_n_m1),
     .bist_addr  (bist_addr_m1),
     .bist_wr_data     (bist_wr_data_m1),
     .bist_rd_data     (bist_rd_data_m1),
     .cap_mem_addr     (cap_mem_addr_m1),
     .cap_mem_wr_data  (cap_mem_wr_data_m1),
     .cap_mem_we       (cap_mem_we_m1)
     );


// DCU Parity Ram, posedge clocked
p405s_DCU_parityRAM
 parityRam(.p_dataOutA  (p_dataOutA[0:15]),
                        .p_dataOutB  (p_dataOutB[0:15]),
                        .addr        (p_dataIndexP[1:9]),
                        .p_writeA    (byteWriteAL2[0:15]),
                        .p_writeB    (byteWriteBL2[0:15]),
                        .cclk        (CB), 
                        .p_dataInA   (p_WBhi_L2[0:15]),
                        .p_dataInB   (p_WBhi_L2[0:15]),
                        .readWrite   (readNotWriteL1),
                        .sram_cen    (~readWriteCycleL1),
                        .bist_mode   (bist_mode),
                        .bist_ce_n   (bist_ce_n_m2),
                        .bist_we_n   (bist_we_n_m2),
                        .bist_addr   (bist_addr_m2),
                        .bist_wr_data     (bist_wr_data_m2),
                        .bist_rd_data     (bist_rd_data_m2),
                        .cap_mem_addr     (cap_mem_addr_m2),
                        .cap_mem_wr_data  (cap_mem_wr_data_m2),
                        .cap_mem_we       (cap_mem_we_m2)
                       );


// Data Muxes
assign writeDataBmux2[0:7] = (writeAndByteWriteB0[8:15] & {8{~(hit_b_buf2)}} ) | 
                             (writeAndByteWriteB1[8:15] & {8{hit_b_buf2}} );
assign writeDataBmux[0:7] = (writeAndByteWriteB0[0:7] & {8{~(hit_b_buf2)}} ) | 
                            (writeAndByteWriteB1[0:7] & {8{hit_b_buf2}} );
assign writeDataAmux2[0:7] = (writeAndByteWriteA0[8:15] & {8{~(hit_a_buf2)}} ) | 
                             (writeAndByteWriteA1[8:15] & {8{hit_a_buf2}} );
assign writeDataAmux[0:7] = (writeAndByteWriteA0[0:7] & {8{~(hit_a_buf2)}} ) | 
                            (writeAndByteWriteA1[0:7] & {8{hit_a_buf2}} );

// Byte Write Regs

// Removed the module "dp_regDCU_byteWrDataB1"
  always @(posedge CB)      
    begin        
      casez(byteWrite_E1_buf2)        
        1'b0: b1noConn[0:7] <= b1noConn[0:7];        
        1'b1: b1noConn[0:7] <= writeDataBmux2[0:7];        
        default: b1noConn[0:7] <= 8'bx;  
      endcase        
    end        

`ifdef CBS         // for cycle-based simulators (MESA)
   always @(negedge CB)      
    begin
    casez(byteWrite_E1_buf2)
     1'b0: bwB[8:15] <= bwB[8:15];
     1'b1: bwB[8:15] <= writeDataBmux2[0:7];
      default: bwB[8:15] <= 8'bx;
    endcase
   end
`else
  always @(CB or writeDataBmux2 or byteWrite_E1_buf2 or bwB)
    begin  
      casez(~CB & byteWrite_E1_buf2)
        1'b0: ;
        1'b1: bwB[8:15] = writeDataBmux2[0:7];
        default: bwB[8:15] = bwB[8:15] ;
      endcase
    end     
`endif

// Removed the module "dp_regDCU_byteWrDataB0"
  always @(posedge CB)      
    begin        
      casez(byteWrite_E1_buf1)        
        1'b0: b0noConn[0:7] <= b0noConn[0:7];        
        1'b1: b0noConn[0:7] <= writeDataBmux[0:7];        
        default: b0noConn[0:7] <= 8'bx;  
      endcase        
    end        

`ifdef CBS         // for cycle-based simulators (MESA)
   always @(negedge CB)      
    begin
    casez(byteWrite_E1_buf1)
     1'b0: bwB[0:7] <= bwB[0:7];
     1'b1: bwB[0:7] <= writeDataBmux[0:7];
      default: bwB[0:7] <= 8'bx;
    endcase
   end
`else
  always @(CB or writeDataBmux or byteWrite_E1_buf1 or bwB)
    begin  
      casez(~CB & byteWrite_E1_buf1)
        1'b0: ;
        1'b1: bwB[0:7] = writeDataBmux[0:7];
        default: bwB[0:7] = bwB[0:7] ;
      endcase
    end     
`endif

// Removed the module "dp_regDCU_byteWrDataA1"
  always @(posedge CB)      
    begin        
      casez(byteWrite_E1_buf2)        
        1'b0: a1noConn[0:7] <= a1noConn[0:7];        
        1'b1: a1noConn[0:7] <= writeDataAmux2[0:7];        
        default: a1noConn[0:7] <= 8'bx;  
      endcase        
    end        
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin
    casez(byteWrite_E1_buf2)
     1'b0: bwA[8:15] <= bwA[8:15];
     1'b1: bwA[8:15] <= writeDataAmux2[0:7];
      default: bwA[8:15] <= 8'bx;
    endcase
   end
`else
  always @(CB or writeDataAmux2 or byteWrite_E1_buf2 or bwA)
    begin  
      casez(~CB & byteWrite_E1_buf2)
        1'b0: ;
        1'b1: bwA[8:15] = writeDataAmux2[0:7];
        default: bwA[8:15] = bwA[8:15] ;
      endcase
    end     
`endif

// Removed the module "dp_regDCU_byteWrDataA0"
  always @(posedge CB)      
    begin        
      casez(byteWrite_E1_buf1)        
        1'b0: a0noConn[0:7] <= a0noConn[0:7];        
        1'b1: a0noConn[0:7] <= writeDataAmux[0:7];        
        default: a0noConn[0:7] <= 8'bx;  
      endcase        
    end        
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin
    casez(byteWrite_E1_buf1)
     1'b0: bwA[0:7] <= bwA[0:7];
     1'b1: bwA[0:7] <= writeDataAmux[0:7];
      default: bwA[0:7] <= 8'bx;
    endcase
   end     
`else
  always @(CB or writeDataAmux or byteWrite_E1_buf1 or bwA)
    begin
      casez(~CB & byteWrite_E1_buf1)
        1'b0: ;
        1'b1: bwA[0:7] = writeDataAmux[0:7];
        default: bwA[0:7] = bwA[0:7] ;
      endcase
    end     
`endif

// Read/Write register

// Removed the module "dp_regDCU_dataRNW"
  always @(posedge CB)      
    begin        
       RNW_noConn <= dataReadNotWrite_In;        
  end        
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin        
      readNotWriteL1 <= dataReadNotWrite_In;        
   end        
`else        
  always @(CB or dataReadNotWrite_In or readNotWriteL1)
    begin
      casez(~CB)
        1'b0: ;
        1'b1: readNotWriteL1 = dataReadNotWrite_In;
        default: readNotWriteL1 = readNotWriteL1 ;
      endcase
    end
`endif

assign {writeA0Buf1,writeA0Buf2,writeA1Buf1,writeA1Buf2,writeB0Buf1,writeB0Buf2,
        writeB1Buf1,writeB1Buf2} = ~({writeDataA0,writeDataA0,writeDataA1,writeDataA1,
        writeDataB0,writeDataB0,writeDataB1,writeDataB1});

assign {byteWriteAL2[0:1],byteWriteAL2[4:5],byteWriteAL2[8:9],byteWriteAL2[12:13]} = bwA[0:7];
assign {byteWriteBL2[0:1],byteWriteBL2[4:5],byteWriteBL2[8:9],byteWriteBL2[12:13]} = bwB[0:7];
assign {byteWriteAL2[2:3],byteWriteAL2[6:7],byteWriteAL2[10:11],byteWriteAL2[14:15]} = bwA[8:15];
assign {byteWriteBL2[2:3],byteWriteBL2[6:7],byteWriteBL2[10:11],byteWriteBL2[14:15]} = bwB[8:15];

assign readWriteCycleL1 = dataReadWriteCycle_In;


endmodule
