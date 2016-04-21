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

module p405s_dcu_dirtyLRU_16K( LRU,
                     dirtyA,
                     dirtyB,
                     CB,
                     dirtyLRUreadIndexL2,
                     dirtyLRUwriteIndexL2,
                     newDirty,
                     newLRU,
                     readLRUDirty,
                     writeDirtyA,
                     writeDirtyB,
                     writeLRU
                    );

output  LRU;
output  dirtyA;
output  dirtyB;

input  newDirty;
input  newLRU;
input  readLRUDirty;
input  writeDirtyA;
input  writeDirtyB;
input  writeLRU;

input        CB;
input [0:8]  dirtyLRUwriteIndexL2;
input [0:8]  dirtyLRUreadIndexL2;

// Buses in the design

reg   [0:7]   dirtyA_8bit;
reg   [0:31]  dbFB2;
reg   [0:31]  daFB1;
reg   [0:31]  dbFB1;
reg   [0:31]  daFB2;
reg   [0:7]   dirtyB_8bit;
wire  [0:2]   writeInv;
wire  [0:31]  LRU3_L2;
wire  [0:31]  fb3;
wire  [0:31]  newValue;
wire  [0:31]  newValueDA;
wire  [0:31]  daFB3;
wire  [0:31]  sel1;
wire  [0:31]  sel2;
wire  [0:31]  LRU7_L2;
wire  [0:31]  LRU5_L2;
wire  [3:3]   CB_buf1;
wire  [0:31]  LRU6_L2;
wire  [0:31]  LRU2_L2;
wire  [0:31]  LRU1_L2;
wire  [0:31]  LRU4_L2;
wire  [0:31]  LRU0_L2;
wire  [0:31]  DA1_L2;
wire  [0:31]  DA0_L2;
wire  [0:31]  newValueDB;
wire  [0:31]  dbFB3;
wire  [0:31]  sel3;
wire  [0:31]  DA2_L2;
reg   [0:31]  writeMuxSel;
wire  [3:3]   CB_buf3;
wire  [3:3]   CB_buf4;
wire  [0:31]  DA7_L2;
wire  [0:31]  DA6_L2;
wire  [0:31]  DA5_L2;
wire  [0:31]  DA4_L2;
wire  [0:31]  DB1_L2;
wire  [3:3]   CB_buf2;
wire  [0:31]  DB6_L2;
wire  [0:31]  DB5_L2;
wire  [0:31]  DB7_L2;
wire  [0:31]  DB2_L2;
wire  [0:31]  DB3_L2;
wire  [0:31]  DB0_L2;
wire  [0:31]  DA3_L2;
wire  [0:31]  DB4_L2;
reg   [0:31]  dirtyB_muxHi;
reg   [0:31]  dirtyB_muxLo;
reg   [0:31]  dirtyA_muxHi;
reg   [0:31]  dirtyA_muxLo;
reg   [0:31]  LRU_muxHi;
reg   [0:31]  LRU_muxLo;
reg   [0:7]   LRU_8bit;
reg   [0:31]  fb1;
reg   [0:31]  fb2;

reg  [0:31]  dirtyB8_reg;
reg  [0:31]  dirtyB7_reg;
reg  [0:31]  dirtyB6_reg;
reg  [0:31]  dirtyB5_reg;
reg  [0:31]  dirtyB4_reg;
reg  [0:31]  dirtyB3_reg;
reg  [0:31]  dirtyB2_reg;
reg  [0:31]  dirtyB1_reg;
reg  [0:31]  dirtyA8_reg;
reg  [0:31]  dirtyA7_reg;
reg  [0:31]  dirtyA6_reg;
reg  [0:31]  dirtyA5_reg;
reg  [0:31]  dirtyA4_reg;
reg  [0:31]  dirtyA3_reg;
reg  [0:31]  dirtyA2_reg;
reg  [0:31]  dirtyA1_reg;
reg  [0:31]  LRU8_reg;
reg  [0:31]  LRU7_reg;
reg  [0:31]  LRU6_reg;
reg  [0:31]  LRU5_reg;
reg  [0:31]  LRU4_reg;
reg  [0:31]  LRU3_reg;
reg  [0:31]  LRU2_reg;
reg  [0:31]  LRU1_reg;

wire  writeDirtyABuf1;
wire  writeDirtyBBuf1;
wire  writeDirtyLRUBuf1;
wire  writeDirtyABuf2;
wire  writeDirtyBBuf2;
wire  writeLRUBuf1;
wire  writeLRUBuf2;
wire  newLRUinv;
wire  readWriteComp;
wire  dirtyA_inv;
wire  dirtyB_inv;
wire  LRU_inv;
reg   LRU_latch;
reg   dirtyA_1bit;
reg   dirtyB_1bit;
reg   LRU_1bit;
wire  LRU_muxOut;

wire  LRU_bank0E2;
wire  LRU_bank1E2;
wire  LRU_bank2E2;
wire  LRU_bank3E2;
wire  LRU_bank4E2;
wire  LRU_bank5E2;
wire  LRU_bank6E2;
wire  LRU_bank7E2;
wire  dirty_bank0AE2;
wire  dirty_bank1AE2;
wire  dirty_bank2AE2;
wire  dirty_bank3AE2;
wire  dirty_bank4AE2;
wire  dirty_bank5AE2;
wire  dirty_bank6AE2;
wire  dirty_bank7AE2;
wire  dirty_bank0BE2;
wire  dirty_bank1BE2;
wire  dirty_bank2BE2;
wire  dirty_bank3BE2;
wire  dirty_bank4BE2;
wire  dirty_bank5BE2;
wire  dirty_bank6BE2;
wire  dirty_bank7BE2;

reg  dirtyA_latchOut;
reg  dirtyB_latchOut;

// Removed the module "dp_logDCU_writeInv1"
// Removed the module "dp_logDCU_writeInv2"
// Removed the module "dp_logDCU_writeInv3"
  assign writeInv[0:2] = ~({writeDirtyA, writeDirtyB, writeLRU});
  assign {writeDirtyABuf1, writeDirtyBBuf1,writeLRUBuf1} = ~(writeInv[0:2]);
  assign {writeDirtyABuf2, writeDirtyBBuf2,writeLRUBuf2} = ~(writeInv[0:2]);

// Removed the module "dp_logDCU_newLRUinv"
  assign newLRUinv = ~(newLRU);

// Removed the module "DCU_indexCompare16K"
  assign readWriteComp = writeLRU & (dirtyLRUreadIndexL2[1:8] == 
                                     dirtyLRUwriteIndexL2[1:8]);

// Removed the module "dp_logDCU_dirtyB_inv"
// Removed the module "dp_logDCU_dirtyA_inv"
  assign dirtyB = ~(dirtyB_inv);
  assign dirtyA = ~(dirtyA_inv);

// Removed the module "dp_logDCU_LRU_inv"
  assign LRU = ~(LRU_inv);

// Removed the module "dp_logDCU_dirtyLRU_CB_buf3_16K"

// Removed the module "dp_muxDCU_dirtyB16K3"
   always @(dirtyLRUreadIndexL2 or dirtyB_8bit)
    begin
    case(dirtyLRUreadIndexL2[6:8])
     3'b000: dirtyB_1bit = ~dirtyB_8bit[0];
     3'b001: dirtyB_1bit = ~dirtyB_8bit[1];
     3'b010: dirtyB_1bit = ~dirtyB_8bit[2];
     3'b011: dirtyB_1bit = ~dirtyB_8bit[3];
     3'b100: dirtyB_1bit = ~dirtyB_8bit[4];
     3'b101: dirtyB_1bit = ~dirtyB_8bit[5];
     3'b110: dirtyB_1bit = ~dirtyB_8bit[6];
     3'b111: dirtyB_1bit = ~dirtyB_8bit[7];
      default: dirtyB_1bit = 1'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyB16K2"
   always @(dirtyLRUreadIndexL2 or dirtyB_muxHi or dirtyB_muxLo) 
    begin
    case({dirtyLRUreadIndexL2[1],dirtyLRUreadIndexL2[4:5]})
     3'b000: dirtyB_8bit[0:7] = ~(dirtyB_muxHi[0:7]);
     3'b001: dirtyB_8bit[0:7] = ~(dirtyB_muxHi[8:15]);
     3'b010: dirtyB_8bit[0:7] = ~(dirtyB_muxHi[16:23]);
     3'b011: dirtyB_8bit[0:7] = ~(dirtyB_muxHi[24:31]);
     3'b100: dirtyB_8bit[0:7] = ~(dirtyB_muxLo[0:7]);
     3'b101: dirtyB_8bit[0:7] = ~(dirtyB_muxLo[8:15]);
     3'b110: dirtyB_8bit[0:7] = ~(dirtyB_muxLo[16:23]);
     3'b111: dirtyB_8bit[0:7] = ~(dirtyB_muxLo[24:31]);
      default: dirtyB_8bit[0:7] = 8'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyB16K1"
   always @(dirtyLRUreadIndexL2 or DB4_L2 or DB5_L2 or DB6_L2 or DB7_L2)
    begin        
    case({dirtyLRUreadIndexL2[2],dirtyLRUreadIndexL2[3]})       
     2'b00: dirtyB_muxLo[0:31] = DB4_L2[0:31];    
     2'b01: dirtyB_muxLo[0:31] = DB5_L2[0:31];    
     2'b10: dirtyB_muxLo[0:31] = DB6_L2[0:31];    
     2'b11: dirtyB_muxLo[0:31] = DB7_L2[0:31];    
      default: dirtyB_muxLo[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_dirtyB16K"
   always @(dirtyLRUreadIndexL2 or DB0_L2 or DB1_L2 or DB2_L2 or DB3_L2)
    begin        
    case({dirtyLRUreadIndexL2[2],dirtyLRUreadIndexL2[3]})       
     2'b00: dirtyB_muxHi[0:31] = DB0_L2[0:31];    
     2'b01: dirtyB_muxHi[0:31] = DB1_L2[0:31];    
     2'b10: dirtyB_muxHi[0:31] = DB2_L2[0:31];    
     2'b11: dirtyB_muxHi[0:31] = DB3_L2[0:31];    
      default: dirtyB_muxHi[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_dirtyB_fb4"
  assign dbFB3[0:31] = (dbFB1[0:31] & {(32){~(dirtyLRUwriteIndexL2[1])}} ) | 
                       (dbFB2[0:31] & {(32){dirtyLRUwriteIndexL2[1]}} );

// Removed the module "dp_muxDCU_dirtyB_fb3"
   always @(dirtyLRUwriteIndexL2 or DB4_L2 or DB5_L2 or DB6_L2 or DB7_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: dbFB2[0:31] = ~(DB4_L2[0:31]);   
     2'b01: dbFB2[0:31] = ~(DB5_L2[0:31]);   
     2'b10: dbFB2[0:31] = ~(DB6_L2[0:31]);   
     2'b11: dbFB2[0:31] = ~(DB7_L2[0:31]);   
      default: dbFB2[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxDCU_dirtyA16K3"
   always @(dirtyLRUreadIndexL2 or dirtyA_8bit)
    begin
    case(dirtyLRUreadIndexL2[6:8])
     3'b000: dirtyA_1bit = ~(dirtyA_8bit[0]);
     3'b001: dirtyA_1bit = ~(dirtyA_8bit[1]);
     3'b010: dirtyA_1bit = ~(dirtyA_8bit[2]);
     3'b011: dirtyA_1bit = ~(dirtyA_8bit[3]);
     3'b100: dirtyA_1bit = ~(dirtyA_8bit[4]);
     3'b101: dirtyA_1bit = ~(dirtyA_8bit[5]);
     3'b110: dirtyA_1bit = ~(dirtyA_8bit[6]);
     3'b111: dirtyA_1bit = ~(dirtyA_8bit[7]);
      default: dirtyA_1bit = 1'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyA16K2"
   always @(dirtyLRUreadIndexL2 or dirtyA_muxHi or dirtyA_muxLo)
    begin
    case({dirtyLRUreadIndexL2[1],dirtyLRUreadIndexL2[4:5]})
     3'b000: dirtyA_8bit[0:7] = ~(dirtyA_muxHi[0:7]);
     3'b001: dirtyA_8bit[0:7] = ~(dirtyA_muxHi[8:15]);
     3'b010: dirtyA_8bit[0:7] = ~(dirtyA_muxHi[16:23]);
     3'b011: dirtyA_8bit[0:7] = ~(dirtyA_muxHi[24:31]);
     3'b100: dirtyA_8bit[0:7] = ~(dirtyA_muxLo[0:7]);
     3'b101: dirtyA_8bit[0:7] = ~(dirtyA_muxLo[8:15]);
     3'b110: dirtyA_8bit[0:7] = ~(dirtyA_muxLo[16:23]);
     3'b111: dirtyA_8bit[0:7] = ~(dirtyA_muxLo[24:31]);
      default: dirtyA_8bit[0:7] = 8'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyA16K1"
   always @(dirtyLRUreadIndexL2 or DA4_L2 or DA5_L2 or DA6_L2 or DA7_L2) 
    begin        
    case({dirtyLRUreadIndexL2[2],dirtyLRUreadIndexL2[3]})       
     2'b00: dirtyA_muxLo[0:31] = DA4_L2[0:31];    
     2'b01: dirtyA_muxLo[0:31] = DA5_L2[0:31];    
     2'b10: dirtyA_muxLo[0:31] = DA6_L2[0:31];    
     2'b11: dirtyA_muxLo[0:31] = DA7_L2[0:31];    
      default: dirtyA_muxLo[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_dirtyA16K"
   always @(dirtyLRUreadIndexL2 or DA0_L2 or DA1_L2 or DA2_L2 or DA3_L2) 
    begin        
    case({dirtyLRUreadIndexL2[2],dirtyLRUreadIndexL2[3]})       
     2'b00: dirtyA_muxHi[0:31] = DA0_L2[0:31];    
     2'b01: dirtyA_muxHi[0:31] = DA1_L2[0:31];    
     2'b10: dirtyA_muxHi[0:31] = DA2_L2[0:31];    
     2'b11: dirtyA_muxHi[0:31] = DA3_L2[0:31];    
      default: dirtyA_muxHi[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_dirtyA_fb4"
  assign daFB3[0:31] = (daFB1[0:31] & {(32){~(dirtyLRUwriteIndexL2[1])}} ) | 
                       (daFB2[0:31] & {(32){dirtyLRUwriteIndexL2[1]}} );

// Removed the module "dp_muxDCU_dirtyA_fb3"
   always @(dirtyLRUwriteIndexL2 or DA4_L2 or DA5_L2 or DA6_L2 or DA7_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: daFB2[0:31] = ~(DA4_L2[0:31]);   
     2'b01: daFB2[0:31] = ~(DA5_L2[0:31]);   
     2'b10: daFB2[0:31] = ~(DA6_L2[0:31]);   
     2'b11: daFB2[0:31] = ~(DA7_L2[0:31]);   
      default: daFB2[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxDCU_LRU16K4"
  assign LRU_muxOut = (LRU_1bit & ~(readWriteComp) ) | (newLRUinv & readWriteComp );

// Removed the module "dp_muxDCU_LRU16K3"
   always @(dirtyLRUreadIndexL2 or LRU_8bit)
    begin
    case(dirtyLRUreadIndexL2[6:8])
     3'b000: LRU_1bit = ~(LRU_8bit[0]);
     3'b001: LRU_1bit = ~(LRU_8bit[1]);
     3'b010: LRU_1bit = ~(LRU_8bit[2]);
     3'b011: LRU_1bit = ~(LRU_8bit[3]);
     3'b100: LRU_1bit = ~(LRU_8bit[4]);
     3'b101: LRU_1bit = ~(LRU_8bit[5]);
     3'b110: LRU_1bit = ~(LRU_8bit[6]);
     3'b111: LRU_1bit = ~(LRU_8bit[7]);
      default: LRU_1bit = 1'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyLRU16K1"
   always @(dirtyLRUreadIndexL2 or LRU4_L2 or LRU5_L2 or LRU6_L2 or LRU7_L2)
    begin        
    case({dirtyLRUreadIndexL2[2], dirtyLRUreadIndexL2[3]})       
     2'b00: LRU_muxLo[0:31] = LRU4_L2[0:31];    
     2'b01: LRU_muxLo[0:31] = LRU5_L2[0:31];    
     2'b10: LRU_muxLo[0:31] = LRU6_L2[0:31];    
     2'b11: LRU_muxLo[0:31] = LRU7_L2[0:31];    
      default: LRU_muxLo[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_LRU16K2"
   always @(dirtyLRUreadIndexL2 or LRU_muxHi or LRU_muxLo)
    begin
    case({dirtyLRUreadIndexL2[1], dirtyLRUreadIndexL2[4:5]})
     3'b000: LRU_8bit[0:7] = ~(LRU_muxHi[0:7]);
     3'b001: LRU_8bit[0:7] = ~(LRU_muxHi[8:15]);
     3'b010: LRU_8bit[0:7] = ~(LRU_muxHi[16:23]);
     3'b011: LRU_8bit[0:7] = ~(LRU_muxHi[24:31]);
     3'b100: LRU_8bit[0:7] = ~(LRU_muxLo[0:7]);
     3'b101: LRU_8bit[0:7] = ~(LRU_muxLo[8:15]);
     3'b110: LRU_8bit[0:7] = ~(LRU_muxLo[16:23]);
     3'b111: LRU_8bit[0:7] = ~(LRU_muxLo[24:31]);
      default: LRU_8bit[0:7] = 8'bx;
    endcase
   end

// Removed the module "dp_muxDCU_dirtyLRU16K"
   always @(dirtyLRUreadIndexL2 or LRU0_L2 or LRU1_L2 or LRU2_L2 or LRU3_L2)
    begin        
    case({dirtyLRUreadIndexL2[2],dirtyLRUreadIndexL2[3]})       
     2'b00: LRU_muxHi[0:31] = LRU0_L2[0:31];    
     2'b01: LRU_muxHi[0:31] = LRU1_L2[0:31];    
     2'b10: LRU_muxHi[0:31] = LRU2_L2[0:31];    
     2'b11: LRU_muxHi[0:31] = LRU3_L2[0:31];    
      default: LRU_muxHi[0:31] = 32'bx;        
    endcase
   end

// Removed the module "dp_muxDCU_dirtyLRU_feedback4"
  assign fb3[0:31] = (fb1[0:31] & {(32){~(dirtyLRUwriteIndexL2[1])}} ) | 
                     (fb2[0:31] & {(32){dirtyLRUwriteIndexL2[1]}} );

// Removed the module "dp_muxDCU_dirtyLRU_feedback3"
   always @(dirtyLRUwriteIndexL2 or LRU4_L2 or LRU5_L2 or LRU6_L2 or LRU7_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: fb2[0:31] = ~(LRU4_L2[0:31]);   
     2'b01: fb2[0:31] = ~(LRU5_L2[0:31]);   
     2'b10: fb2[0:31] = ~(LRU6_L2[0:31]);   
     2'b11: fb2[0:31] = ~(LRU7_L2[0:31]);   
      default: fb2[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "DCU_dirtyLRU_decode16K"
    assign LRU_bank0E2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                    ~dirtyLRUwriteIndexL2[3];

    assign LRU_bank1E2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                     dirtyLRUwriteIndexL2[3];

    assign LRU_bank2E2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                    ~dirtyLRUwriteIndexL2[3];

    assign LRU_bank3E2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                     dirtyLRUwriteIndexL2[3];

    assign LRU_bank4E2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                    ~dirtyLRUwriteIndexL2[3];

    assign LRU_bank5E2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                     dirtyLRUwriteIndexL2[3];

    assign LRU_bank6E2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                    ~dirtyLRUwriteIndexL2[3];

    assign LRU_bank7E2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                     dirtyLRUwriteIndexL2[3];

// Removed the module "DCU_dirtyLRU_decode16K"
    assign dirty_bank0AE2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank1AE2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank2AE2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank3AE2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank4AE2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank5AE2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank6AE2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank7AE2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];

// Removed the module "DCU_dirtyLRU_decode16K"
    assign dirty_bank0BE2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank1BE2 = ~dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank2BE2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank3BE2 = ~dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank4BE2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank5BE2 =  dirtyLRUwriteIndexL2[1] & ~dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];
    assign dirty_bank6BE2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] & 
                                                       ~dirtyLRUwriteIndexL2[3];
    assign dirty_bank7BE2 =  dirtyLRUwriteIndexL2[1] &  dirtyLRUwriteIndexL2[2] &  
                                                        dirtyLRUwriteIndexL2[3];

// Removed the module "dp_regDCU_dirtyB8"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank7BE2)        
     1'b0: dirtyB8_reg <= dirtyB8_reg;        
     1'b1: dirtyB8_reg <= newValueDB[0:31];        
      default: dirtyB8_reg <= 32'bx;  
    endcase        
   end        

  assign DB7_L2[0:31] = ~(dirtyB8_reg);

// Removed the module "dp_regDCU_dirtyB7"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank6BE2)        
     1'b0: dirtyB7_reg <= dirtyB7_reg;        
     1'b1: dirtyB7_reg <= newValueDB[0:31];        
      default: dirtyB7_reg <= 32'bx;  
    endcase        
   end        

  assign DB6_L2[0:31] = ~(dirtyB7_reg);

// Removed the module "dp_regDCU_dirtyB6"
  always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank5BE2)        
     1'b0: dirtyB6_reg <= dirtyB6_reg;        
     1'b1: dirtyB6_reg <= newValueDB[0:31];        
      default: dirtyB6_reg <= 32'bx;  
    endcase        
   end        

  assign DB5_L2[0:31] = ~(dirtyB6_reg);

// Removed the module "dp_regDCU_dirtyB5"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank4BE2)        
     1'b0: dirtyB5_reg <= dirtyB5_reg;        
     1'b1: dirtyB5_reg <= newValueDB[0:31];        
      default: dirtyB5_reg <= 32'bx;  
    endcase        
   end        

  assign DB4_L2[0:31] = ~(dirtyB5_reg);

// Removed the module "dp_regDCU_dirtyA8"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank7AE2)        
     1'b0: dirtyA8_reg <= dirtyA8_reg;        
     1'b1: dirtyA8_reg <= newValueDA[0:31];        
      default: dirtyA8_reg <= 32'bx;  
    endcase        
   end        

  assign DA7_L2[0:31] = ~(dirtyA8_reg);

// Removed the module "dp_regDCU_dirtyA7"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank6AE2)        
     1'b0: dirtyA7_reg <= dirtyA7_reg;        
     1'b1: dirtyA7_reg <= newValueDA[0:31];        
      default: dirtyA7_reg <= 32'bx;  
    endcase        
   end        

  assign DA6_L2[0:31] = ~(dirtyA7_reg);

// Removed the module "dp_regDCU_dirtyA6"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank5AE2)        
     1'b0: dirtyA6_reg <= dirtyA6_reg;        
     1'b1: dirtyA6_reg <= newValueDA[0:31];        
      default: dirtyA6_reg <= 32'bx;  
    endcase        
   end        

  assign DA5_L2[0:31] = ~(dirtyA6_reg);

// Removed the module "dp_regDCU_dirtyA6"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank4AE2)        
     1'b0: dirtyA5_reg <= dirtyA5_reg;        
     1'b1: dirtyA5_reg <= newValueDA[0:31];        
      default: dirtyA5_reg <= 32'bx;  
    endcase        
   end        

  assign DA4_L2[0:31] = ~(dirtyA5_reg);

// Removed the module "dp_regDCU_LRU8"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank7E2)        
     1'b0: LRU8_reg <= LRU8_reg;        
     1'b1: LRU8_reg <= newValue[0:31];        
      default: LRU8_reg <= 32'bx;  
    endcase        
   end        

  assign LRU7_L2[0:31] = ~(LRU8_reg);

// Removed the module "dp_regDCU_LRU7"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank6E2)        
     1'b0: LRU7_reg <= LRU7_reg;        
     1'b1: LRU7_reg <= newValue[0:31];        
      default: LRU7_reg <= 32'bx;  
    endcase        
   end        

  assign LRU6_L2[0:31] = ~(LRU7_reg);

// Removed the module "dp_regDCU_LRU6"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank5E2)        
     1'b0: LRU6_reg <= LRU6_reg;        
     1'b1: LRU6_reg <= newValue[0:31];        
      default: LRU6_reg <= 32'bx;  
    endcase        
   end        

  assign LRU5_L2[0:31]= ~(LRU6_reg);

// Removed the module "dp_regDCU_LRU5"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank4E2)        
     1'b0: LRU5_reg <= LRU5_reg;        
     1'b1: LRU5_reg <= newValue[0:31];        
      default: LRU5_reg <= 32'bx;  
    endcase        
   end        

  assign LRU4_L2[0:31] = ~(LRU5_reg);

// Removed the module "dp_muxDCU_dirtyB"
  assign dirtyB_inv = (dirtyB_latchOut & ~(readLRUDirty)) | (dirtyB_1bit & readLRUDirty);

// Removed the module "dp_muxDCU_dirtyA"
   assign dirtyA_inv = (dirtyA_latchOut & ~(readLRUDirty)) | (dirtyA_1bit & readLRUDirty);

// Removed the module "dp_muxDCU_LRU"
  assign LRU_inv = (LRU_latch & ~(readLRUDirty)) | (LRU_muxOut & readLRUDirty);

// Removed the module "dp_regDCU_dirtyB"
   always @(posedge CB)      
    begin        
    casez(readLRUDirty)        
     1'b0: dirtyB_latchOut <= dirtyB_latchOut;        
     1'b1: dirtyB_latchOut <= dirtyB_1bit;        
      default: dirtyB_latchOut <= 1'bx;  
    endcase        
   end        

// Removed the module "dp_regDCU_dirtyA"
   always @(posedge CB)      
    begin        
    casez(readLRUDirty)        
     1'b0: dirtyA_latchOut <= dirtyA_latchOut;        
     1'b1: dirtyA_latchOut <= dirtyA_1bit;        
      default: dirtyA_latchOut <= 1'bx;  
    endcase        
   end        

// Removed the module "dp_regDCU_LRU"
   always @(posedge CB)      
    begin        
    casez(readLRUDirty)        
     1'b0: LRU_latch <= LRU_latch;        
     1'b1: LRU_latch <= LRU_muxOut;        
      default: LRU_latch <= 1'bx;  
    endcase        
   end        

// Removed the module "dp_regDCU_LRU"
  assign sel1[0:31] = ~(writeMuxSel[0:31]);

// Removed the module "DCU_indexDecode"
  always @ (dirtyLRUwriteIndexL2)

  begin
    casez (dirtyLRUwriteIndexL2[4:8]) // synopsys parallel_case full_case
    
    5'b00000: writeMuxSel[0:31]  = 32'b10000000000000000000000000000000;
    5'b00001: writeMuxSel[0:31]  = 32'b01000000000000000000000000000000;
    5'b00010: writeMuxSel[0:31]  = 32'b00100000000000000000000000000000;
    5'b00011: writeMuxSel[0:31]  = 32'b00010000000000000000000000000000;
    5'b00100: writeMuxSel[0:31]  = 32'b00001000000000000000000000000000;
    5'b00101: writeMuxSel[0:31]  = 32'b00000100000000000000000000000000;
    5'b00110: writeMuxSel[0:31]  = 32'b00000010000000000000000000000000;
    5'b00111: writeMuxSel[0:31]  = 32'b00000001000000000000000000000000;
    5'b01000: writeMuxSel[0:31]  = 32'b00000000100000000000000000000000;
    5'b01001: writeMuxSel[0:31]  = 32'b00000000010000000000000000000000;
    5'b01010: writeMuxSel[0:31]  = 32'b00000000001000000000000000000000;
    5'b01011: writeMuxSel[0:31]  = 32'b00000000000100000000000000000000;
    5'b01100: writeMuxSel[0:31]  = 32'b00000000000010000000000000000000;
    5'b01101: writeMuxSel[0:31]  = 32'b00000000000001000000000000000000;
    5'b01110: writeMuxSel[0:31]  = 32'b00000000000000100000000000000000;
    5'b01111: writeMuxSel[0:31]  = 32'b00000000000000010000000000000000;
    5'b10000: writeMuxSel[0:31]  = 32'b00000000000000001000000000000000;
    5'b10001: writeMuxSel[0:31]  = 32'b00000000000000000100000000000000;
    5'b10010: writeMuxSel[0:31]  = 32'b00000000000000000010000000000000;
    5'b10011: writeMuxSel[0:31]  = 32'b00000000000000000001000000000000;
    5'b10100: writeMuxSel[0:31]  = 32'b00000000000000000000100000000000;
    5'b10101: writeMuxSel[0:31]  = 32'b00000000000000000000010000000000;
    5'b10110: writeMuxSel[0:31]  = 32'b00000000000000000000001000000000;
    5'b10111: writeMuxSel[0:31]  = 32'b00000000000000000000000100000000;
    5'b11000: writeMuxSel[0:31]  = 32'b00000000000000000000000010000000;
    5'b11001: writeMuxSel[0:31]  = 32'b00000000000000000000000001000000;
    5'b11010: writeMuxSel[0:31]  = 32'b00000000000000000000000000100000;
    5'b11011: writeMuxSel[0:31]  = 32'b00000000000000000000000000010000;
    5'b11100: writeMuxSel[0:31]  = 32'b00000000000000000000000000001000;
    5'b11101: writeMuxSel[0:31]  = 32'b00000000000000000000000000000100;
    5'b11110: writeMuxSel[0:31]  = 32'b00000000000000000000000000000010;
    5'b11111: writeMuxSel[0:31]  = 32'b00000000000000000000000000000001;
        default:  writeMuxSel[0:31]  = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  endcase
  end

// Removed the module "dp_muxDCU_dirtyB_fb2"
   always @(dirtyLRUwriteIndexL2 or DB0_L2 or DB1_L2 or DB2_L2 or DB3_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: dbFB1[0:31] = ~(DB0_L2[0:31]);   
     2'b01: dbFB1[0:31] = ~(DB1_L2[0:31]);   
     2'b10: dbFB1[0:31] = ~(DB2_L2[0:31]);   
     2'b11: dbFB1[0:31] = ~(DB3_L2[0:31]);   
      default: dbFB1[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxDCU_dirtyA_fb2"
   always @(dirtyLRUwriteIndexL2 or DA0_L2 or DA1_L2 or DA2_L2 or DA3_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: daFB1[0:31] = ~(DA0_L2[0:31]);   
     2'b01: daFB1[0:31] = ~(DA1_L2[0:31]);   
     2'b10: daFB1[0:31] = ~(DA2_L2[0:31]);   
     2'b11: daFB1[0:31] = ~(DA3_L2[0:31]);   
      default: daFB1[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_logDCU_fbSelDB"
  assign sel3[0:31] = ~(writeMuxSel[0:31]);

// Removed the module "dp_logDCU_fbMuxDB"
  assign newValueDB[0:31] = ({32{newDirty}} & writeMuxSel[0:31]) | 
                               (dbFB3[0:31] & sel3[0:31]);

// Removed the module "dp_logDCU_fbSelDA"
  assign sel2[0:31] = ~(writeMuxSel[0:31]);

// Removed the module "dp_logDCU_fbMuxDA"
  assign newValueDA[0:31] = ({32{newDirty}} & writeMuxSel[0:31]) | 
                               (daFB3[0:31] & sel2[0:31]);

// Removed the module "dp_regDCU_dirtyB4"
  always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank3BE2)        
     1'b0: dirtyB4_reg <= dirtyB4_reg;        
     1'b1: dirtyB4_reg <= newValueDB[0:31];        
      default: dirtyB4_reg <= 32'bx;  
    endcase        
   end        

  assign DB3_L2[0:31] = ~(dirtyB4_reg);

// Removed the module "dp_regDCU_dirtyB3"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank2BE2)        
     1'b0: dirtyB3_reg <= dirtyB3_reg;        
     1'b1: dirtyB3_reg <= newValueDB[0:31];        
      default: dirtyB3_reg <= 32'bx;  
    endcase        
   end        

  assign DB2_L2[0:31] = ~(dirtyB3_reg);

// Removed the module "dp_regDCU_dirtyB2"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank1BE2)        
     1'b0: dirtyB2_reg <= dirtyB2_reg;        
     1'b1: dirtyB2_reg <= newValueDB[0:31];        
      default: dirtyB2_reg <= 32'bx;  
    endcase        
   end        

  assign DB1_L2[0:31] = ~(dirtyB2_reg);

// Removed the module "dp_regDCU_dirtyB1"
   always @(posedge CB)      
    begin        
    casez(writeDirtyBBuf2 & dirty_bank0BE2)        
     1'b0: dirtyB1_reg <= dirtyB1_reg;        
     1'b1: dirtyB1_reg <= newValueDB[0:31];        
      default: dirtyB1_reg <= 32'bx;  
    endcase        
   end        

  assign DB0_L2[0:31] = ~(dirtyB1_reg);

// Removed the module "dp_regDCU_dirtyA4"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank3AE2)        
     1'b0: dirtyA4_reg <= dirtyA4_reg;        
     1'b1: dirtyA4_reg <= newValueDA[0:31];        
      default: dirtyA4_reg <= 32'bx;  
    endcase        
   end        

  assign DA3_L2[0:31] = ~(dirtyA4_reg);

// Removed the module "dp_regDCU_dirtyA3"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank2AE2)        
     1'b0: dirtyA3_reg <= dirtyA3_reg;        
     1'b1: dirtyA3_reg <= newValueDA[0:31];        
      default: dirtyA3_reg <= 32'bx;  
    endcase        
   end        

  assign DA2_L2[0:31] = ~(dirtyA3_reg);

// Removed the module "dp_regDCU_dirtyA2"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank1AE2)        
     1'b0: dirtyA2_reg <= dirtyA2_reg;        
     1'b1: dirtyA2_reg <= newValueDA[0:31];        
      default: dirtyA2_reg <= 32'bx;  
    endcase        
   end        

  assign DA1_L2[0:31] = ~(dirtyA2_reg);

// Removed the module "dp_regDCU_dirtyA1"
   always @(posedge CB)      
    begin        
    casez(writeDirtyABuf2 & dirty_bank0AE2)        
     1'b0: dirtyA1_reg <= dirtyA1_reg;        
     1'b1: dirtyA1_reg <= newValueDA[0:31];        
      default: dirtyA1_reg <= 32'bx;  
    endcase        
   end        

  assign DA0_L2[0:31] = ~(dirtyA1_reg);

// Removed the module "dp_muxDCU_dirtyLRU_feedback2"
   always @(dirtyLRUwriteIndexL2 or LRU0_L2 or LRU1_L2 or LRU2_L2 or LRU3_L2) 
    begin        
    case(dirtyLRUwriteIndexL2[2:3])        
     2'b00: fb1[0:31] = ~(LRU0_L2[0:31]);   
     2'b01: fb1[0:31] = ~(LRU1_L2[0:31]);   
     2'b10: fb1[0:31] = ~(LRU2_L2[0:31]);   
     2'b11: fb1[0:31] = ~(LRU3_L2[0:31]);   
      default: fb1[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_logDCU_fbMux"
  assign newValue[0:31] = ({32{newLRU}} & writeMuxSel[0:31]) | (fb3[0:31] & sel1[0:31]);
  
// Removed the module "dp_regDCU_LRU4"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank3E2)        
     1'b0: LRU4_reg <= LRU4_reg;        
     1'b1: LRU4_reg <= newValue[0:31];        
      default: LRU4_reg <= 32'bx;  
    endcase        
   end        

  assign LRU3_L2[0:31] = ~(LRU4_reg);

// Removed the module "dp_regDCU_LRU3"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank2E2)        
     1'b0: LRU3_reg <= LRU3_reg;        
     1'b1: LRU3_reg <= newValue[0:31];        
      default: LRU3_reg <= 32'bx;  
    endcase        
   end        

  assign LRU2_L2[0:31] = ~(LRU3_reg);

// Removed the module "dp_regDCU_LRU2"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank1E2)        
     1'b0: LRU2_reg <= LRU2_reg;        
     1'b1: LRU2_reg <= newValue[0:31];        
      default: LRU2_reg <= 32'bx;  
    endcase        
   end        

  assign LRU1_L2[0:31] = ~(LRU2_reg);

// Removed the module "dp_regDCU_LRU1"
   always @(posedge CB)      
    begin        
    casez(writeLRUBuf2 & LRU_bank0E2)        
     1'b0: LRU1_reg <= LRU1_reg;        
     1'b1: LRU1_reg <= newValue[0:31];        
      default: LRU1_reg <= 32'bx;  
    endcase        
   end        

  assign LRU0_L2[0:31] = ~(LRU1_reg);

endmodule
