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

// change history
// 8-06-01      JRS             Fix bit width in output data declaration

module p405s_icu_ram_parityArray( parityOut, 
                                  CB,
                                  bitWrite, 
                                  cycleParityRam, 
                                  parityIn,
                                  dataIndexA, 
                                  readWrParity,
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

input  cycleParityRam;
input  readWrParity;

output [0:7]   parityOut;

input          CB;
input [0:7]    bitWrite;
input [0:9]    dataIndexA;
input [0:7]    parityIn;

// RAM BIST IO
 
input         bist_mode;
input         bist_ce_n;
input         bist_we_n;
input [8:0]   bist_addr;
input [7:0]   bist_wr_data;
output [7:0]  bist_rd_data;
output [8:0]  cap_mem_addr;
output [7:0]  cap_mem_wr_data;
output        cap_mem_we;

wire [0:7]   parityOut_b;
wire [0:7]   parityOut;
wire [0:7]   bitWrite_b;

reg  [0:7]   parityOut_r;
reg          readWrParity_r;
reg          cycleParityRam_r;


assign parityOut = (readWrParity_r)  ? parityOut_b : parityOut_r;

assign bitWrite_b = readWrParity ? 8'hff : bitWrite;

  always@(posedge CB)
  begin
    cycleParityRam_r <= cycleParityRam;

    if (~readWrParity)
      readWrParity_r <= 1'b0;
    else if (cycleParityRam)
      readWrParity_r <= 1'b1;

    if (~readWrParity && readWrParity_r)
      parityOut_r  <= parityOut_b;
  end
  


p405s_icu_SRAM_512wordsX8bits
 dataA (  
                .parityOut   ({parityOut_b[7], parityOut_b[3], parityOut_b[6],
                               parityOut_b[2], parityOut_b[5], parityOut_b[1], 
                               parityOut_b[4], parityOut_b[0]}),
                .addr        (dataIndexA[1:9]),
                .bitWrite    ({bitWrite_b[7], bitWrite_b[3], bitWrite_b[6], 
                               bitWrite_b[2], bitWrite_b[5], bitWrite_b[1],
                               bitWrite_b[4], bitWrite_b[0]}),
                .cclk        (CB),
                .parityIn    ({parityIn[7], parityIn[3], parityIn[6], 
                               parityIn[2], parityIn[5], parityIn[1],
                               parityIn[4], parityIn[0]}),
                .readWrite   (readWrParity),
                .sram_cen    (~cycleParityRam),
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
