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

module p405s_icu_SRAM_512wordsX8bits( parityOut, 
                                      addr, 
                                      bitWrite, 
                                      cclk, 
                                      parityIn, 
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

output [0:7]  parityOut;

input [0:7]  parityIn;
input [0:8]  addr;
input [0:7]  bitWrite;

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

wire         bist_mux_cen;
wire [0:7]   bist_mux_wen;
wire [0:8]   bist_mux_addr;
wire [0:7]   bist_mux_dataIn;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 9'b0;
  assign cap_mem_wr_data = 8'b0;
  assign cap_mem_we      = 1'b0;


  assign bist_mux_dataIn = parityIn;

  assign bist_mux_addr = addr;

  assign bist_mux_wen = bitWrite;

  assign bist_mux_cen = sram_cen;

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

  p405s_sram512x8_wrapper paritySram (
                        .Q    (parityOut),
                        .CLK  (cclk),
                        .CEN  (bist_mux_cen),
                        .WEN  (bist_mux_wen),
                        .A    (bist_mux_addr),
                        .D    (bist_mux_dataIn)
                      );

`else
  // Artisan Specific RAM
  sram512x8
   paritySram ( 
                        .Q    (parityOut),
                        .CLK  (cclk),
                        .CEN  (bist_mux_cen),
                        .WEN  (bist_mux_wen),
                        .A    (bist_mux_addr),
                        .D    (bist_mux_dataIn)
                      );
`endif

  assign bist_rd_data = parityOut;

endmodule
