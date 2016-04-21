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

module p405s_icu_SRAM_512wordsX128bits( dataOutA0, 
                                        dataOutA1, 
                                        dataOutA2,
                                        dataOutA3, 
                                        dataOutA4, 
                                        dataOutA5, 
                                        dataOutA6, 
                                        dataOutA7,
                                        dataOutA8, 
                                        dataOutA9, 
                                        dataOutA10, 
                                        dataOutA11,
                                        dataOutA12, 
                                        dataOutA13, 
                                        dataOutA14, 
                                        dataOutA15,
                                        addr, 
                                        byteWrite, 
                                        cclk, 
                                        dataInA0,
                                        dataInA1, 
                                        dataInA2, 
                                        dataInA3, 
                                        dataInA4, 
                                        dataInA5,
                                        dataInA6, 
                                        dataInA7, 
                                        dataInA8, 
                                        dataInA9, 
                                        dataInA10,
                                        dataInA11, 
                                        dataInA12, 
                                        dataInA13, 
                                        dataInA14,
                                        dataInA15, 
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


output [0:7]      dataOutA0;
output [8:15]     dataOutA1;
output [16:23]    dataOutA2;
output [24:31]    dataOutA3;
output [32:39]    dataOutA4;
output [40:47]    dataOutA5;
output [48:55]    dataOutA6;
output [56:63]    dataOutA7;
output [64:71]    dataOutA8;
output [72:79]    dataOutA9;
output [80:87]    dataOutA10;
output [88:95]    dataOutA11;
output [96:103]   dataOutA12;
output [104:111]  dataOutA13;
output [112:119]  dataOutA14;
output [120:127]  dataOutA15;

input  cclk;
input  readWrite;
input  sram_cen;

input [0:8]  addr;
input [0:15]  byteWrite;

input [0:7]    dataInA0;
input [8:15 ]  dataInA1;
input [16:23]  dataInA2;
input [24:31]  dataInA3;
input [32:39]  dataInA4;
input [40:47]  dataInA5;
input [48:55]  dataInA6;
input [56:63]  dataInA7;
input [64:71]  dataInA8;
input [72:79]  dataInA9;
input [80:87]  dataInA10;
input [88:95]  dataInA11;
input [96:103]  dataInA12;
input [104:111]  dataInA13;
input [112:119]  dataInA14;
input [120:127]  dataInA15;

// RAM BIST IO

input           bist_mode;
input           bist_ce_n;
input           bist_we_n;
input [8:0]     bist_addr;
input [127:0]   bist_wr_data;
output [127:0]  bist_rd_data;
output [8:0]    cap_mem_addr;
output [127:0]  cap_mem_wr_data;
output          cap_mem_we;

wire [0:127]  dataOutA;

wire          bist_mux_cen;
wire [0:15]   bist_mux_wen;
wire [0:8]    bist_mux_addr;
wire [0:127]  bist_mux_dataIn;
reg  [0:127]  dataOutA_r;
reg           mux_wen_0_r;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 9'b0;
  assign cap_mem_wr_data = 128'b0;
  assign cap_mem_we      = 1'b0;


  assign bist_mux_dataIn = {dataInA0,dataInA1,dataInA2,dataInA3,
                     dataInA4,dataInA5,dataInA6,dataInA7,
                     dataInA8,dataInA9,dataInA10,dataInA11,
                     dataInA12,dataInA13,dataInA14,dataInA15};

  assign bist_mux_addr = addr;

  assign bist_mux_wen = byteWrite;

  assign bist_mux_cen = sram_cen;

  assign {dataOutA0,  dataOutA1, dataOutA2, dataOutA3,
          dataOutA4,  dataOutA5, dataOutA6, dataOutA7,
          dataOutA8,  dataOutA9,dataOutA10,dataOutA11,
          dataOutA12,dataOutA13,dataOutA14,dataOutA15} = (mux_wen_0_r)  ? dataOutA : dataOutA_r;

  always@(posedge cclk)
  begin

    if (~bist_mux_wen[0])
      mux_wen_0_r <= 1'b0;
    else if (~bist_mux_cen)
      mux_wen_0_r <= 1'b1;
    
    if (~bist_mux_wen[0] && mux_wen_0_r)
     dataOutA_r  <= dataOutA;
  end

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

  p405s_sramBytWr512x128_wrapper sramBytWr512x128_i ( 
                                       .Q(dataOutA),
                                       .CLK(cclk),
                                       .CEN(bist_mux_cen),
                                       .WEN(bist_mux_wen),
                                       .A(bist_mux_addr),
                                       .D(bist_mux_dataIn)
                                     );
`else

  // Artisan Specific RAM
  sramBytWr512x128
   sramBytWr512x128_i ( 
                                       .Q(dataOutA),
                                       .CLK(cclk),
                                       .CEN(bist_mux_cen),
                                       .WEN(bist_mux_wen),
                                       .A(bist_mux_addr),
                                       .D(bist_mux_dataIn)
                                     );
`endif
  assign  bist_rd_data = dataOutA;

endmodule
