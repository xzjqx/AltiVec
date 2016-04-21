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

module p405s_dcu_cdsModule_0( dataOutA1, 
                              dataOutA2, 
                              dataOutA3, 
                              dataOutA4,
                              dataOutB1, 
                              dataOutB2, 
                              dataOutB3, 
                              dataOutB4,
                              addr, 
                              byteWriteA, 
                              byteWriteB, 
                              cclk, 
                              dataIn,
                              readWrite, 
                              sram_cen,
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

input  cclk;
input  readWrite;
input  sram_cen;

output [0:15]  dataOutB4;
output [0:15]  dataOutB3;
output [0:15]  dataOutB1;
output [0:15]  dataOutB2;
output [0:15]  dataOutA4;
output [0:15]  dataOutA3;
output [0:15]  dataOutA2;
output [0:15]  dataOutA1;

input [0:63]  dataIn;
input [0:8]   addr;
input [0:7]   byteWriteA;
input [0:7]   byteWriteB;

// RAM BIST IO

output [127:0]  bist_rd_data;
input           bist_mode;
input           bist_ce_n;
input           bist_we_n;
input [8:0]     bist_addr;
input [127:0]   bist_wr_data;
output [8:0]    cap_mem_addr;
output [127:0]  cap_mem_wr_data;
output          cap_mem_we;

wire [0:15]  dataOutB4_b;
wire [0:15]  dataOutB3_b;
wire [0:15]  dataOutB1_b;
wire [0:15]  dataOutB2_b;
wire [0:15]  dataOutA4_b;
wire [0:15]  dataOutA3_b;
wire [0:15]  dataOutA2_b;
wire [0:15]  dataOutA1_b;

wire [0:15]  dataOutB4;
wire [0:15]  dataOutB3;
wire [0:15]  dataOutB1;
wire [0:15]  dataOutB2;
wire [0:15]  dataOutA4;
wire [0:15]  dataOutA3;
wire [0:15]  dataOutA2;
wire [0:15]  dataOutA1;

reg [0:15]  dataOutB4_r;
reg [0:15]  dataOutB3_r;
reg [0:15]  dataOutB1_r;
reg [0:15]  dataOutB2_r;
reg [0:15]  dataOutA4_r;
reg [0:15]  dataOutA3_r;
reg [0:15]  dataOutA2_r;
reg [0:15]  dataOutA1_r;

wire          bist_mux_cen;
wire [0:127]  bist_mux_wen;
wire [0:8]    bist_mux_addr;
wire [0:127]  bist_mux_dataIn;

reg          readWrite_r;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 9'b0;
  assign cap_mem_wr_data = 128'b0;
  assign cap_mem_we      = 1'b0;


  assign bist_mux_dataIn = {dataIn[63],dataIn[47],dataIn[31],dataIn[15],
                            dataIn[63],dataIn[47],dataIn[31],dataIn[15],
                            dataIn[62],dataIn[46],dataIn[30],dataIn[14],
                            dataIn[62],dataIn[46],dataIn[30],dataIn[14],
                            dataIn[61],dataIn[45],dataIn[29],dataIn[13],
                            dataIn[61],dataIn[45],dataIn[29],dataIn[13],
                            dataIn[60],dataIn[44],dataIn[28],dataIn[12],
                            dataIn[60],dataIn[44],dataIn[28],dataIn[12],
                            dataIn[59],dataIn[43],dataIn[27],dataIn[11],
                            dataIn[59],dataIn[43],dataIn[27],dataIn[11],
                            dataIn[58],dataIn[42],dataIn[26],dataIn[10],
                            dataIn[58],dataIn[42],dataIn[26],dataIn[10],
                            dataIn[57],dataIn[41],dataIn[25],dataIn[9],
                            dataIn[57],dataIn[41],dataIn[25],dataIn[9],
                            dataIn[56],dataIn[40],dataIn[24],dataIn[8],
                            dataIn[56],dataIn[40],dataIn[24],dataIn[8],
                            dataIn[55],dataIn[39],dataIn[23],dataIn[7],
                            dataIn[55],dataIn[39],dataIn[23],dataIn[7],
                            dataIn[54],dataIn[38],dataIn[22],dataIn[6],
                            dataIn[54],dataIn[38],dataIn[22],dataIn[6],
                            dataIn[53],dataIn[37],dataIn[21],dataIn[5],
                            dataIn[53],dataIn[37],dataIn[21],dataIn[5],
                            dataIn[52],dataIn[36],dataIn[20],dataIn[4],
                            dataIn[52],dataIn[36],dataIn[20],dataIn[4],
                            dataIn[51],dataIn[35],dataIn[19],dataIn[3],
                            dataIn[51],dataIn[35],dataIn[19],dataIn[3],
                            dataIn[50],dataIn[34],dataIn[18],dataIn[2],
                            dataIn[50],dataIn[34],dataIn[18],dataIn[2],
                            dataIn[49],dataIn[33],dataIn[17],dataIn[1],
                            dataIn[49],dataIn[33],dataIn[17],dataIn[1],
                            dataIn[48],dataIn[32],dataIn[16],dataIn[0],
                            dataIn[48],dataIn[32],dataIn[16],dataIn[0]};

  assign bist_mux_addr = {addr[8],addr[7],addr[6],addr[5],addr[4], 
                          addr[3],addr[2],addr[1],addr[0]};

  assign bist_mux_wen =  readWrite ? {128{1'b1}} :
                        ~{byteWriteB[7],byteWriteB[5],byteWriteB[3],
                          byteWriteB[1],byteWriteA[7],byteWriteA[5],
                          byteWriteA[3],byteWriteA[1],byteWriteB[7],
                          byteWriteB[5],byteWriteB[3],byteWriteB[1],
                          byteWriteA[7],byteWriteA[5],byteWriteA[3],
                          byteWriteA[1],byteWriteB[7],byteWriteB[5],
                          byteWriteB[3],byteWriteB[1],byteWriteA[7],
                          byteWriteA[5],byteWriteA[3],byteWriteA[1],
                          byteWriteB[7],byteWriteB[5],byteWriteB[3],
                          byteWriteB[1],byteWriteA[7],byteWriteA[5],
                          byteWriteA[3],byteWriteA[1],byteWriteB[7],
                          byteWriteB[5],byteWriteB[3],byteWriteB[1],
                          byteWriteA[7],byteWriteA[5],byteWriteA[3],
                          byteWriteA[1],byteWriteB[7],byteWriteB[5],
                          byteWriteB[3],byteWriteB[1],byteWriteA[7],
                          byteWriteA[5],byteWriteA[3],byteWriteA[1],
                          byteWriteB[7],byteWriteB[5],byteWriteB[3],
                          byteWriteB[1],byteWriteA[7],byteWriteA[5],
                          byteWriteA[3],byteWriteA[1],byteWriteB[7],
                          byteWriteB[5],byteWriteB[3],byteWriteB[1],
                          byteWriteA[7],byteWriteA[5],byteWriteA[3],
                          byteWriteA[1],byteWriteB[6],byteWriteB[4],
                          byteWriteB[2],byteWriteB[0],byteWriteA[6],
                          byteWriteA[4],byteWriteA[2],byteWriteA[0],
                          byteWriteB[6],byteWriteB[4],byteWriteB[2],
                          byteWriteB[0],byteWriteA[6],byteWriteA[4],
                          byteWriteA[2],byteWriteA[0],byteWriteB[6],
                          byteWriteB[4],byteWriteB[2],byteWriteB[0],
                          byteWriteA[6],byteWriteA[4],byteWriteA[2],
                          byteWriteA[0],byteWriteB[6],byteWriteB[4],
                          byteWriteB[2],byteWriteB[0],byteWriteA[6],
                          byteWriteA[4],byteWriteA[2],byteWriteA[0],
                          byteWriteB[6],byteWriteB[4],byteWriteB[2],
                          byteWriteB[0],byteWriteA[6],byteWriteA[4],
                          byteWriteA[2],byteWriteA[0],byteWriteB[6],
                          byteWriteB[4],byteWriteB[2],byteWriteB[0],
                          byteWriteA[6],byteWriteA[4],byteWriteA[2],
                          byteWriteA[0],byteWriteB[6],byteWriteB[4],
                          byteWriteB[2],byteWriteB[0],byteWriteA[6],
                          byteWriteA[4],byteWriteA[2],byteWriteA[0],
                          byteWriteB[6],byteWriteB[4],byteWriteB[2],
                          byteWriteB[0],byteWriteA[6],byteWriteA[4],
                          byteWriteA[2],byteWriteA[0]};

  assign bist_mux_cen = sram_cen;

  assign dataOutB4 = (readWrite_r) ? dataOutB4_b : dataOutB4_r;
  assign dataOutB3 = (readWrite_r) ? dataOutB3_b : dataOutB3_r;
  assign dataOutB2 = (readWrite_r) ? dataOutB2_b : dataOutB2_r;
  assign dataOutB1 = (readWrite_r) ? dataOutB1_b : dataOutB1_r;
  assign dataOutA4 = (readWrite_r) ? dataOutA4_b : dataOutA4_r;
  assign dataOutA3 = (readWrite_r) ? dataOutA3_b : dataOutA3_r;
  assign dataOutA2 = (readWrite_r) ? dataOutA2_b : dataOutA2_r;
  assign dataOutA1 = (readWrite_r) ? dataOutA1_b : dataOutA1_r;

  always@(posedge cclk)
  begin

    if (~readWrite)
      readWrite_r <= 1'b0;
    else if (~bist_mux_cen)
      readWrite_r <= 1'b1;
    
    if (~readWrite && readWrite_r)
    begin
      dataOutB4_r <= dataOutB4_b;
      dataOutB3_r <= dataOutB3_b;
      dataOutB2_r <= dataOutB2_b;
      dataOutB1_r <= dataOutB1_b;
      dataOutA4_r <= dataOutA4_b;
      dataOutA3_r <= dataOutA3_b;
      dataOutA2_r <= dataOutA2_b;
      dataOutA1_r <= dataOutA1_b;
    end
  end

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

  p405s_sram512x128_wrapper sram512x128_i ( 
                             .Q({dataOutB4_b[15], dataOutB3_b[15],
                                 dataOutB2_b[15], dataOutB1_b[15], dataOutA4_b[15],
                                 dataOutA3_b[15], dataOutA2_b[15], dataOutA1_b[15],
                                 dataOutB4_b[14], dataOutB3_b[14], dataOutB2_b[14],
                                 dataOutB1_b[14], dataOutA4_b[14], dataOutA3_b[14],
                                 dataOutA2_b[14], dataOutA1_b[14], dataOutB4_b[13],
                                 dataOutB3_b[13], dataOutB2_b[13], dataOutB1_b[13],
                                 dataOutA4_b[13], dataOutA3_b[13], dataOutA2_b[13],
                                 dataOutA1_b[13], dataOutB4_b[12], dataOutB3_b[12],
                                 dataOutB2_b[12], dataOutB1_b[12], dataOutA4_b[12],
                                 dataOutA3_b[12], dataOutA2_b[12], dataOutA1_b[12],
                                 dataOutB4_b[11], dataOutB3_b[11], dataOutB2_b[11],
                                 dataOutB1_b[11], dataOutA4_b[11], dataOutA3_b[11],
                                 dataOutA2_b[11], dataOutA1_b[11], dataOutB4_b[10],
                                 dataOutB3_b[10], dataOutB2_b[10], dataOutB1_b[10],
                                 dataOutA4_b[10], dataOutA3_b[10], dataOutA2_b[10],
                                 dataOutA1_b[10], dataOutB4_b[9],  dataOutB3_b[9],
                                 dataOutB2_b[9],  dataOutB1_b[9],  dataOutA4_b[9],
                                 dataOutA3_b[9],  dataOutA2_b[9],  dataOutA1_b[9],
                                 dataOutB4_b[8],  dataOutB3_b[8],  dataOutB2_b[8],
                                 dataOutB1_b[8],  dataOutA4_b[8],  dataOutA3_b[8],
                                 dataOutA2_b[8],  dataOutA1_b[8],  dataOutB4_b[7],
                                 dataOutB3_b[7],  dataOutB2_b[7],  dataOutB1_b[7],
                                 dataOutA4_b[7],  dataOutA3_b[7],  dataOutA2_b[7],
                                 dataOutA1_b[7],  dataOutB4_b[6],  dataOutB3_b[6],
                                 dataOutB2_b[6],  dataOutB1_b[6],  dataOutA4_b[6],
                                 dataOutA3_b[6],  dataOutA2_b[6],  dataOutA1_b[6],
                                 dataOutB4_b[5],  dataOutB3_b[5],  dataOutB2_b[5],
                                 dataOutB1_b[5],  dataOutA4_b[5],  dataOutA3_b[5],
                                 dataOutA2_b[5],  dataOutA1_b[5],  dataOutB4_b[4],
                                 dataOutB3_b[4],  dataOutB2_b[4],  dataOutB1_b[4],
                                 dataOutA4_b[4],  dataOutA3_b[4],  dataOutA2_b[4],
                                 dataOutA1_b[4],  dataOutB4_b[3],  dataOutB3_b[3],
                                 dataOutB2_b[3],  dataOutB1_b[3],  dataOutA4_b[3],
                                 dataOutA3_b[3],  dataOutA2_b[3],  dataOutA1_b[3],
                                 dataOutB4_b[2],  dataOutB3_b[2],  dataOutB2_b[2],
                                 dataOutB1_b[2],  dataOutA4_b[2],  dataOutA3_b[2],
                                 dataOutA2_b[2],  dataOutA1_b[2],  dataOutB4_b[1],
                                 dataOutB3_b[1],  dataOutB2_b[1],  dataOutB1_b[1],
                                 dataOutA4_b[1],  dataOutA3_b[1],  dataOutA2_b[1],
                                 dataOutA1_b[1],  dataOutB4_b[0],  dataOutB3_b[0],
                                 dataOutB2_b[0],  dataOutB1_b[0],  dataOutA4_b[0],
                                 dataOutA3_b[0],  dataOutA2_b[0],  dataOutA1_b[0]}),
                            .CLK (cclk),
                            .CEN (bist_mux_cen),
                            .WEN (bist_mux_wen),
                            .A   (bist_mux_addr),
                            .D   (bist_mux_dataIn)
                          );

`else

  // Artisan Specific RAM
  sram512x128
   sram512x128_i ( 
                            .Q({dataOutB4_b[15], dataOutB3_b[15],
                                 dataOutB2_b[15], dataOutB1_b[15], dataOutA4_b[15],
                                 dataOutA3_b[15], dataOutA2_b[15], dataOutA1_b[15],
                                 dataOutB4_b[14], dataOutB3_b[14], dataOutB2_b[14],
                                 dataOutB1_b[14], dataOutA4_b[14], dataOutA3_b[14],
                                 dataOutA2_b[14], dataOutA1_b[14], dataOutB4_b[13],
                                 dataOutB3_b[13], dataOutB2_b[13], dataOutB1_b[13],
                                 dataOutA4_b[13], dataOutA3_b[13], dataOutA2_b[13],
                                 dataOutA1_b[13], dataOutB4_b[12], dataOutB3_b[12],
                                 dataOutB2_b[12], dataOutB1_b[12], dataOutA4_b[12],
                                 dataOutA3_b[12], dataOutA2_b[12], dataOutA1_b[12],
                                 dataOutB4_b[11], dataOutB3_b[11], dataOutB2_b[11],
                                 dataOutB1_b[11], dataOutA4_b[11], dataOutA3_b[11],
                                 dataOutA2_b[11], dataOutA1_b[11], dataOutB4_b[10],
                                 dataOutB3_b[10], dataOutB2_b[10], dataOutB1_b[10],
                                 dataOutA4_b[10], dataOutA3_b[10], dataOutA2_b[10],
                                 dataOutA1_b[10], dataOutB4_b[9],  dataOutB3_b[9],
                                 dataOutB2_b[9],  dataOutB1_b[9],  dataOutA4_b[9],
                                 dataOutA3_b[9],  dataOutA2_b[9],  dataOutA1_b[9],
                                 dataOutB4_b[8],  dataOutB3_b[8],  dataOutB2_b[8],
                                 dataOutB1_b[8],  dataOutA4_b[8],  dataOutA3_b[8],
                                 dataOutA2_b[8],  dataOutA1_b[8],  dataOutB4_b[7],
                                 dataOutB3_b[7],  dataOutB2_b[7],  dataOutB1_b[7],
                                 dataOutA4_b[7],  dataOutA3_b[7],  dataOutA2_b[7],
                                 dataOutA1_b[7],  dataOutB4_b[6],  dataOutB3_b[6],
                                 dataOutB2_b[6],  dataOutB1_b[6],  dataOutA4_b[6],
                                 dataOutA3_b[6],  dataOutA2_b[6],  dataOutA1_b[6],
                                 dataOutB4_b[5],  dataOutB3_b[5],  dataOutB2_b[5],
                                 dataOutB1_b[5],  dataOutA4_b[5],  dataOutA3_b[5],
                                 dataOutA2_b[5],  dataOutA1_b[5],  dataOutB4_b[4],
                                 dataOutB3_b[4],  dataOutB2_b[4],  dataOutB1_b[4],
                                 dataOutA4_b[4],  dataOutA3_b[4],  dataOutA2_b[4],
                                 dataOutA1_b[4],  dataOutB4_b[3],  dataOutB3_b[3],
                                 dataOutB2_b[3],  dataOutB1_b[3],  dataOutA4_b[3],
                                 dataOutA3_b[3],  dataOutA2_b[3],  dataOutA1_b[3],
                                 dataOutB4_b[2],  dataOutB3_b[2],  dataOutB2_b[2],
                                 dataOutB1_b[2],  dataOutA4_b[2],  dataOutA3_b[2],
                                 dataOutA2_b[2],  dataOutA1_b[2],  dataOutB4_b[1],
                                 dataOutB3_b[1],  dataOutB2_b[1],  dataOutB1_b[1],
                                 dataOutA4_b[1],  dataOutA3_b[1],  dataOutA2_b[1],
                                 dataOutA1_b[1],  dataOutB4_b[0],  dataOutB3_b[0],
                                 dataOutB2_b[0],  dataOutB1_b[0],  dataOutA4_b[0],
                                 dataOutA3_b[0],  dataOutA2_b[0],  dataOutA1_b[0]}),
                            .CLK (cclk),
                            .CEN (bist_mux_cen),
                            .WEN (bist_mux_wen),
                            .A   (bist_mux_addr),
                            .D   (bist_mux_dataIn)
                          );

`endif

assign bist_rd_data =         {dataOutB4_b[15], dataOutB3_b[15],
                               dataOutB2_b[15], dataOutB1_b[15], dataOutA4_b[15],
                               dataOutA3_b[15], dataOutA2_b[15], dataOutA1_b[15],
                               dataOutB4_b[14], dataOutB3_b[14], dataOutB2_b[14],
                               dataOutB1_b[14], dataOutA4_b[14], dataOutA3_b[14],
                               dataOutA2_b[14], dataOutA1_b[14], dataOutB4_b[13],
                               dataOutB3_b[13], dataOutB2_b[13], dataOutB1_b[13],
                               dataOutA4_b[13], dataOutA3_b[13], dataOutA2_b[13],
                               dataOutA1_b[13], dataOutB4_b[12], dataOutB3_b[12],
                               dataOutB2_b[12], dataOutB1_b[12], dataOutA4_b[12],
                               dataOutA3_b[12], dataOutA2_b[12], dataOutA1_b[12],
                               dataOutB4_b[11], dataOutB3_b[11], dataOutB2_b[11],
                               dataOutB1_b[11], dataOutA4_b[11], dataOutA3_b[11],
                               dataOutA2_b[11], dataOutA1_b[11], dataOutB4_b[10],
                               dataOutB3_b[10], dataOutB2_b[10], dataOutB1_b[10],
                               dataOutA4_b[10], dataOutA3_b[10], dataOutA2_b[10],
                               dataOutA1_b[10], dataOutB4_b[9],  dataOutB3_b[9],
                               dataOutB2_b[9],  dataOutB1_b[9],  dataOutA4_b[9],
                               dataOutA3_b[9],  dataOutA2_b[9],  dataOutA1_b[9],
                               dataOutB4_b[8],  dataOutB3_b[8],  dataOutB2_b[8],
                               dataOutB1_b[8],  dataOutA4_b[8],  dataOutA3_b[8],
                               dataOutA2_b[8],  dataOutA1_b[8],  dataOutB4_b[7],
                               dataOutB3_b[7],  dataOutB2_b[7],  dataOutB1_b[7],
                               dataOutA4_b[7],  dataOutA3_b[7],  dataOutA2_b[7],
                               dataOutA1_b[7],  dataOutB4_b[6],  dataOutB3_b[6],
                               dataOutB2_b[6],  dataOutB1_b[6],  dataOutA4_b[6],
                               dataOutA3_b[6],  dataOutA2_b[6],  dataOutA1_b[6],
                               dataOutB4_b[5],  dataOutB3_b[5],  dataOutB2_b[5],
                               dataOutB1_b[5],  dataOutA4_b[5],  dataOutA3_b[5],
                               dataOutA2_b[5],  dataOutA1_b[5],  dataOutB4_b[4],
                               dataOutB3_b[4],  dataOutB2_b[4],  dataOutB1_b[4],
                               dataOutA4_b[4],  dataOutA3_b[4],  dataOutA2_b[4],
                               dataOutA1_b[4],  dataOutB4_b[3],  dataOutB3_b[3],
                               dataOutB2_b[3],  dataOutB1_b[3],  dataOutA4_b[3],
                               dataOutA3_b[3],  dataOutA2_b[3],  dataOutA1_b[3],
                               dataOutB4_b[2],  dataOutB3_b[2],  dataOutB2_b[2],
                               dataOutB1_b[2],  dataOutA4_b[2],  dataOutA3_b[2],
                               dataOutA2_b[2],  dataOutA1_b[2],  dataOutB4_b[1],
                               dataOutB3_b[1],  dataOutB2_b[1],  dataOutB1_b[1],
                               dataOutA4_b[1],  dataOutA3_b[1],  dataOutA2_b[1],
                               dataOutA1_b[1],  dataOutB4_b[0],  dataOutB3_b[0],
                               dataOutB2_b[0],  dataOutB1_b[0],  dataOutA4_b[0],
                               dataOutA3_b[0],  dataOutA2_b[0],  dataOutA1_b[0]};

endmodule
