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

module p405s_icu_SRAM_256wordsX46bits( dataOut, 
                                       addr,
                                       bitWrA, 
                                       bitWrB, 
                                       cclk, 
                                       dataIn, 
                                       readWrite, 
                                       sram_cen,
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

input  cclk;
input  readWrite;
input  sram_cen;

output [0:45]  dataOut;

input [0:22]  bitWrA;
input [0:7]   addr;
input [0:22]  bitWrB;
input [0:45]  dataIn;

// RAM BIST IO

input          bist_mode;
input          bist_ce_n;
input          bist_we_n;
input [7:0]    bist_addr;
input [45:0]   bist_wr_data;
output [45:0]  bist_rd_data;
output [7:0]   cap_mem_addr;
output [45:0]  cap_mem_wr_data;
output         cap_mem_we;

wire          bist_mux_cen;
wire [0:45]   bist_mux_wen;
wire [0:7]    bist_mux_addr;
wire [0:45]   bist_mux_dataIn;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 8'b0;
  assign cap_mem_wr_data = 46'b0;
  assign cap_mem_we      = 1'b0;

  assign bist_mux_dataIn = dataIn;

  assign bist_mux_addr = addr;

  assign bist_mux_wen = {bitWrB,bitWrA};

  assign bist_mux_cen = sram_cen;

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

  p405s_sram256x46_wrapper tagSram ( 
                      .Q    (dataOut),
                      .CLK  (cclk),
                      .CEN  (bist_mux_cen),
                      .WEN  (bist_mux_wen),
                      .A    (bist_mux_addr),
                      .D    (bist_mux_dataIn)
                     );

`else

  // Artisan Specific RAM
  sram256x46
   tagSram ( 
                      .Q    (dataOut),
                      .CLK  (cclk),
                      .CEN  (bist_mux_cen),
                      .WEN  (bist_mux_wen),
                      .A    (bist_mux_addr),
                      .D    (bist_mux_dataIn)
                     );
`endif

  assign bist_rd_data = dataOut;

endmodule
