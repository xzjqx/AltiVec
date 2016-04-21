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

module p405s_icu_ram_tagArray_16K( icuCacheSize, 
                                   tagAOut,
                                   tagAOutParityBit, 
                                   tagBOut, 
                                   tagBOutParityBit, 
                                   CB, 
                                   dataIn, 
                                   dataInParityBit, 
                                   readWr, 
                                   tagCycle, 
                                   tagIndex, 
                                   writeTagANotB,
                                   bist_mode,
                                   bist_ce_n,
                                   bist_we_n,
                                   bist_addr,
                                   bist_rd_data,
                                   bist_wr_data,
                                   cap_mem_addr,
                                   cap_mem_wr_data,
                                   cap_mem_we
                                 );

input  readWr;
input  tagCycle;

output [0:21]  tagAOut;
output         tagAOutParityBit;
output [0:21]  tagBOut;
output         tagBOutParityBit;
output [0:2]   icuCacheSize;

input [0:21]  dataIn;
input         dataInParityBit;
input [0:8]   tagIndex;
input [0:22]  writeTagANotB;
input         CB;

// RAM BIST IO
 
input         bist_mode;
input         bist_ce_n;
input         bist_we_n;
input [7:0]   bist_addr;
input [45:0]  bist_wr_data;
output [45:0] bist_rd_data;
output [7:0]  cap_mem_addr;
output [45:0] cap_mem_wr_data;
output        cap_mem_we;


// Buses in the design

wire  [0:22]  BwrB;

wire   [0:21]  tagAOut;
wire           tagAOutParityBit;
wire   [0:21]  tagBOut;
wire           tagBOutParityBit;
wire   [0:21]  tagAOut_b;
wire           tagAOutParityBit_b;
wire   [0:21]  tagBOut_b;
wire           tagBOutParityBit_b;
wire   [0:22]  writeTagANotB_b;

reg    [0:21]  tagAOut_r;
reg            tagAOutParityBit_r;
reg    [0:21]  tagBOut_r;
reg            tagBOutParityBit_r;
reg            readWr_r;
reg            tagCycle_r;

assign BwrB[0:22] = readWr ? 23'h7f_ffff : ~(writeTagANotB[0:22]);
assign writeTagANotB_b = readWr ? 23'h7f_ffff : writeTagANotB;

assign icuCacheSize[0] = 1'b1;
assign icuCacheSize[1] = 1'b0;
assign icuCacheSize[2] = 1'b1;

assign tagAOut          = (readWr_r) ? tagAOut_b : tagAOut_r;
assign tagAOutParityBit = (readWr_r) ? tagAOutParityBit_b : tagAOutParityBit_r;
assign tagBOut          = (readWr_r) ? tagBOut_b : tagBOut_r;
assign tagBOutParityBit = (readWr_r) ? tagBOutParityBit_b : tagBOutParityBit_r;

  always@(posedge CB)
  begin
    tagCycle_r <= tagCycle;

    if (~readWr)
      readWr_r <= 1'b0;
    else if (tagCycle)
      readWr_r <= 1'b1;

    if (~readWr && readWr_r) 
    begin
      tagAOut_r          <= tagAOut_b;
      tagAOutParityBit_r <= tagAOutParityBit_b;
      tagBOut_r          <= tagBOut_b;
      tagBOutParityBit_r <= tagBOutParityBit_b;
    end
  end

p405s_icu_SRAM_256wordsX46bits
 icu_tag( .dataOut     ({tagAOut_b[0:21],tagAOutParityBit_b,
                                             tagBOut_b[0:21],tagBOutParityBit_b}), 
                              .addr        (tagIndex[1:8]), 
                              .bitWrA      (writeTagANotB_b[0:22]),
                              .bitWrB      (BwrB[0:22]), 
                              .cclk        (CB), 
                              .dataIn      ({dataIn[0:21],dataInParityBit, 
                                             dataIn[0:21],dataInParityBit}), 
                              .readWrite   (readWr), 
                              .sram_cen    (~tagCycle),
                              .bist_mode   (bist_mode),
                              .bist_ce_n   (bist_ce_n),
                              .bist_we_n   (bist_we_n),
                              .bist_addr   (bist_addr),
                              .bist_rd_data     (bist_rd_data),
                              .bist_wr_data     (bist_wr_data),
                              .cap_mem_addr     (cap_mem_addr),
                              .cap_mem_wr_data  (cap_mem_wr_data),
                              .cap_mem_we       (cap_mem_we)
                           );

endmodule
