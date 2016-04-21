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

module p405s_dcu_tagArray_16K( DCU_icuSize, 
                               U0AttrA, 
                               U0AttrB, 
                               tagAOut, 
                               tagBOut, 
                               p_parityA, 
                               p_parityB, 
                               validA, 
                               validB, 
                               CB, 
                               dataIn, 
                               p_tag, 
                               hit_a_buf2, 
                               hit_b_buf2, 
                               newValidIn, 
                               tagIndex, 
                               tagReadNotWrite_In, 
                               tagReadWriteCycle_In, 
                               wbU0AttrL1, 
                               writeTagA0,
                               writeTagA1, 
                               writeTagB0, 
                               writeTagB1, 
                               bist_mode,
                               bist_ce_n,
                               bist_we_n,
                               bist_addr,
                               bist_wr_data,
                               bist_rd_data,
                               cap_mem_addr,
                               cap_mem_wr_data,
                               cap_mem_we
                             );

output  U0AttrA;
output  U0AttrB;
output  validA;
output  validB;

input   hit_a_buf2; 
input   hit_b_buf2; 
input   newValidIn; 
input   tagReadNotWrite_In;
input   tagReadWriteCycle_In; 
input   wbU0AttrL1; 
input   writeTagA0; 
input   writeTagA1; 
input   writeTagB0; 
input   writeTagB1;

output [0:20]  tagBOut;
output [0:20]  tagAOut;
output [0:2]   DCU_icuSize;

input   p_tag;
output  p_parityA;
output  p_parityB;

input [0:20]  dataIn;
input         CB;
input [0:9]   tagIndex;

// RAM BIST IO

output [47:0]  bist_rd_data;
input          bist_mode;
input          bist_ce_n;
input          bist_we_n;
input [7:0]    bist_addr;
input [47:0]   bist_wr_data;
output [7:0]   cap_mem_addr;
output [47:0]  cap_mem_wr_data;
output         cap_mem_we;

// Buses in the design

reg   [0:5]  bitWriteB;
reg   [0:5]  bitWriteA;
wire  [0:5]  writeA;
wire  [0:5]  writeB;
reg   [0:5]  writeBNoConn;
reg   [0:5]  writeANoConn;
reg   [0:2]  validU0NoConn;

// New sram_enable
wire readWriteCycleL1;

reg  newValid;
reg  readNotWriteL1;

// DCU Tag Sram wraper instance
p405s_dcu_SRAM_256wordsX48bits
 tag( .U0AttrA    (U0AttrA), 
                          .U0AttrB    (U0AttrB), 
                          .dataOutA   (tagAOut[0:20]), 
                          .dataOutB   (tagBOut[0:20]), 
                          .p_parityA  (p_parityA), 
                          .p_parityB  (p_parityB),
                          .validA     (validA), 
                          .validB     (validB), 
                          .addr       (tagIndex[1:8]), 
                          .bitWriteA  (bitWriteA[0:5]),
                          .bitWriteB  (bitWriteB[0:5]), 
                          .cclk       (CB), 
                          .dataIn     (dataIn[0:20]), 
                          .p_tag      (p_tag), 
                          .newU0Attr  (wbU0AttrL1), 
                          .newValidA  (newValid), 
                          .newValidB  (newValid), 
                          .readWrite  (readNotWriteL1),
                          .sram_cen   (~readWriteCycleL1),
                          .bist_mode  (bist_mode),
                          .bist_ce_n  (bist_ce_n),
                          .bist_we_n  (bist_we_n),
                          .bist_addr  (bist_addr),
                          .bist_wr_data     (bist_wr_data),
                          .bist_rd_data     (bist_rd_data),
                          .cap_mem_addr     (cap_mem_addr),
                          .cap_mem_wr_data  (cap_mem_wr_data),
                          .cap_mem_we       (cap_mem_we)
                       );

// Bit write A mux
assign writeA[0:5] = ({6{writeTagA0}} & {6{~(hit_a_buf2)}} ) |
                     ({6{writeTagA1}} & {6{hit_a_buf2}} );

// Register for A bit writes

// Removed the module "dp_regDCU_tagWriteA"
  always @(posedge CB)      
    begin        
       writeANoConn[0:5] <= writeA[0:5];        
    end             

`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin
      bitWriteA[0:5] <= writeA[0:5];
   end
`else
  always @(CB or writeA or bitWriteA)     
    begin          
      casez(~CB)   
        1'b0: ;       
        1'b1: bitWriteA[0:5] = writeA[0:5];
        default: bitWriteA[0:5] = bitWriteA[0:5] ;
      endcase        
    end             
`endif

// Bit write B mux
assign writeB[0:5] = ({6{writeTagB0}} & {6{~(hit_b_buf2)}} ) | 
                     ({6{writeTagB1}} & {6{hit_b_buf2}} );

// Register for B bit writes

// Removed the module "dp_regDCU_tagWriteB"
  always @(posedge CB)      
    begin        
       writeBNoConn[0:5] <= writeB[0:5];        
    end        

`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin
      bitWriteB[0:5] <= writeB[0:5];
   end
`else
  always @(CB or writeB or bitWriteB)     
    begin          
      casez(~CB)   
        1'b0: ;       
        1'b1: bitWriteB[0:5] = writeB[0:5];
        default: bitWriteB[0:5] = bitWriteB[0:5] ;
      endcase        
    end             
`endif

// Register for a few sram control bits

// Removed the module "dp_regDCU_tagValidU0"
  always @(posedge CB)      
    begin        
       validU0NoConn[0:1] <= {newValidIn, tagReadNotWrite_In};        
    end        
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin
      {newValid, readNotWriteL1} <= {newValidIn, tagReadNotWrite_In};
   end     
`else
  always @(CB or newValidIn or tagReadNotWrite_In or newValid or readNotWriteL1)     
    begin          
      casez(~CB)   
        1'b0: ;       
        1'b1: {newValid, readNotWriteL1} = {newValidIn, tagReadNotWrite_In};
        default: {newValid, readNotWriteL1} = {newValid, readNotWriteL1} ;
      endcase        
    end             
`endif

// TRC removed the latch and added assign statement
assign readWriteCycleL1 = tagReadWriteCycle_In;

// Removed the module "dp_logDCU_size"
assign DCU_icuSize[0:2] = {1'b1, 1'b0, 1'b1};


endmodule
