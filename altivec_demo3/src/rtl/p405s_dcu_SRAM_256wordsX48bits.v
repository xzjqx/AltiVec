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

module p405s_dcu_SRAM_256wordsX48bits( U0AttrA,  
                             U0AttrB, 
                             dataOutA, 
                             dataOutB, 
                             p_parityA,
                             p_parityB, 
                             validA, 
                             validB, 
                             addr,
                             bitWriteA, 
                             bitWriteB, 
                             cclk, 
                             dataIn, 
                             p_tag, 
                             newU0Attr, 
                             newValidA,
                             newValidB, 
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
input  newU0Attr;
input  newValidA;
input  newValidB;
input  readWrite;
input  sram_cen;

output  U0AttrA;
output  U0AttrB;
output  validA;
output  validB;

output [0:20]  dataOutA;
output [0:20]  dataOutB;

input   p_tag;
output  p_parityA;
output  p_parityB;

input [0:20]  dataIn;
input [0:7]  addr;
input [0:5]  bitWriteB;
input [0:5]  bitWriteA;

// RAM BIST IO

input          bist_mode;
input          bist_ce_n;
input          bist_we_n;
input [7:0]    bist_addr;
input [47:0]   bist_wr_data;
output [47:0]  bist_rd_data;
output [7:0]   cap_mem_addr;
output [47:0]  cap_mem_wr_data;
output         cap_mem_we;

wire         readWrite;
wire         p_parityB;
wire         p_parityA;
wire         U0AttrB;
wire         U0AttrA;
wire         validB;
wire         validA;
wire [0:20]  dataOutB;
wire [0:20]  dataOutA;
wire         p_parityB_b;
wire         p_parityA_b;
wire         U0AttrB_b;
wire         U0AttrA_b;
wire         validB_b;
wire         validA_b;
wire [0:20]  dataOutB_b;
wire [0:20]  dataOutA_b;
wire [0:47]   mux_wen_b;

reg          readWrite_r;
reg          p_parityB_r;
reg          p_parityA_r;
reg          U0AttrB_r;
reg          U0AttrA_r;
reg          validB_r;
reg          validA_r;
reg  [0:20]  dataOutB_r;
reg  [0:20]  dataOutA_r;

wire          bist_mux_cen;
wire [0:47]   bist_mux_wen;
wire [0:7]    bist_mux_addr;
wire [0:47]   bist_mux_dataIn;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 8'b0;
  assign cap_mem_wr_data = 48'b0;
  assign cap_mem_we      = 1'b0;


  assign bist_mux_dataIn = {p_tag,      p_tag,      newU0Attr,  newU0Attr, 
                            newValidB,  newValidA,  dataIn[20], dataIn[20],
                            dataIn[19], dataIn[19], dataIn[18], dataIn[18],
                            dataIn[17], dataIn[17], dataIn[16], dataIn[16],
                            dataIn[15], dataIn[15], dataIn[14], dataIn[14],
                            dataIn[13], dataIn[13], dataIn[12], dataIn[12],
                            dataIn[11], dataIn[11], dataIn[10], dataIn[10],
                            dataIn[9],  dataIn[9],  dataIn[8],  dataIn[8], 
                            dataIn[7],  dataIn[7],  dataIn[6],  dataIn[6], 
                            dataIn[5],  dataIn[5],  dataIn[4],  dataIn[4], 
                            dataIn[3],  dataIn[3],  dataIn[2],  dataIn[2], 
                            dataIn[1],  dataIn[1],  dataIn[0],  dataIn[0]};

  assign bist_mux_addr = {addr[7], addr[6], addr[5], addr[4],
                          addr[3], addr[2], addr[1], addr[0]};

  assign bist_mux_wen =   readWrite ? 48'hffff_ffff_ffff :
                        ~{bitWriteB[5], bitWriteA[5], bitWriteB[5], bitWriteA[5],
                          bitWriteB[5], bitWriteA[5], bitWriteB[5], bitWriteA[5],
                          bitWriteB[4], bitWriteA[4], bitWriteB[4], bitWriteA[4],
                          bitWriteB[4], bitWriteA[4], bitWriteB[4], bitWriteA[4],
                          bitWriteB[3], bitWriteA[3], bitWriteB[3], bitWriteA[3],
                          bitWriteB[3], bitWriteA[3], bitWriteB[3], bitWriteA[3],
                          bitWriteB[2], bitWriteA[2], bitWriteB[2], bitWriteA[2],
                          bitWriteB[2], bitWriteA[2], bitWriteB[2], bitWriteA[2],
                          bitWriteB[1], bitWriteA[1], bitWriteB[1], bitWriteA[1],
                          bitWriteB[1], bitWriteA[1], bitWriteB[1], bitWriteA[1],
                          bitWriteB[0], bitWriteA[0], bitWriteB[0], bitWriteA[0],
                          bitWriteB[0], bitWriteA[0], bitWriteB[0], bitWriteA[0]};

  assign bist_mux_cen = sram_cen;

assign p_parityB = (readWrite_r) ? p_parityB_b : p_parityB_r;
assign p_parityA = (readWrite_r) ? p_parityA_b : p_parityA_r;
assign U0AttrB   = (readWrite_r) ? U0AttrB_b   : U0AttrB_r;
assign U0AttrA   = (readWrite_r) ? U0AttrA_b   : U0AttrA_r;
assign validB    = (readWrite_r) ? validB_b    : validB_r;
assign validA    = (readWrite_r) ? validA_b    : validA_r;
assign dataOutB  = (readWrite_r) ? dataOutB_b  : dataOutB_r;
assign dataOutA  = (readWrite_r) ? dataOutA_b  : dataOutA_r;


  always@(posedge cclk)
  begin

    if (~readWrite)
      readWrite_r <= 1'b0;
    else if (~bist_mux_cen)
      readWrite_r <= 1'b1;

    if (~readWrite && readWrite_r)
    begin
      p_parityB_r        <= p_parityB_b;
      p_parityA_r        <= p_parityA_b;
      U0AttrB_r          <= U0AttrB_b;
      U0AttrA_r          <= U0AttrA_b;
      validB_r           <= validB_b;
      validA_r           <= validA_b;
      dataOutB_r         <= dataOutB_b;
      dataOutA_r         <= dataOutA_b;
    end
  end

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

p405s_sram256x48_wrapper tagSram256x48 ( 
                               .Q ({p_parityB_b,    p_parityA_b,    U0AttrB_b,      U0AttrA_b,     
                               validB_b,       validA_b,       dataOutB_b[20], dataOutA_b[20],
                               dataOutB_b[19], dataOutA_b[19], dataOutB_b[18], dataOutA_b[18],
                               dataOutB_b[17], dataOutA_b[17], dataOutB_b[16], dataOutA_b[16],
                               dataOutB_b[15], dataOutA_b[15], dataOutB_b[14], dataOutA_b[14],
                               dataOutB_b[13], dataOutA_b[13], dataOutB_b[12], dataOutA_b[12],
                               dataOutB_b[11], dataOutA_b[11], dataOutB_b[10], dataOutA_b[10],
                               dataOutB_b[9],  dataOutA_b[9],  dataOutB_b[8],  dataOutA_b[8],
                               dataOutB_b[7],  dataOutA_b[7],  dataOutB_b[6],  dataOutA_b[6],
                               dataOutB_b[5],  dataOutA_b[5],  dataOutB_b[4],  dataOutA_b[4],
                               dataOutB_b[3],  dataOutA_b[3],  dataOutB_b[2],  dataOutA_b[2],
                               dataOutB_b[1],  dataOutA_b[1],  dataOutB_b[0],  dataOutA_b[0]}),
                          .CLK (cclk),
                          .CEN (bist_mux_cen),
                          .WEN (bist_mux_wen),
                          .A   (bist_mux_addr),
                          .D   (bist_mux_dataIn)
                         );

`else

// Artisan Specific RAM
sram256x48
 tagSram256x48 ( 
                          .Q ({p_parityB_b,    p_parityA_b,    U0AttrB_b,      U0AttrA_b,     
                               validB_b,       validA_b,       dataOutB_b[20], dataOutA_b[20],
                               dataOutB_b[19], dataOutA_b[19], dataOutB_b[18], dataOutA_b[18],
                               dataOutB_b[17], dataOutA_b[17], dataOutB_b[16], dataOutA_b[16],
                               dataOutB_b[15], dataOutA_b[15], dataOutB_b[14], dataOutA_b[14],
                               dataOutB_b[13], dataOutA_b[13], dataOutB_b[12], dataOutA_b[12],
                               dataOutB_b[11], dataOutA_b[11], dataOutB_b[10], dataOutA_b[10],
                               dataOutB_b[9],  dataOutA_b[9],  dataOutB_b[8],  dataOutA_b[8],
                               dataOutB_b[7],  dataOutA_b[7],  dataOutB_b[6],  dataOutA_b[6],
                               dataOutB_b[5],  dataOutA_b[5],  dataOutB_b[4],  dataOutA_b[4],
                               dataOutB_b[3],  dataOutA_b[3],  dataOutB_b[2],  dataOutA_b[2],
                               dataOutB_b[1],  dataOutA_b[1],  dataOutB_b[0],  dataOutA_b[0]}),
                          .CLK (cclk),
                          .CEN (bist_mux_cen),
                          .WEN (bist_mux_wen),
                          .A   (bist_mux_addr),
                          .D   (bist_mux_dataIn)
                         );

`endif


assign bist_rd_data =         {p_parityB_b,    p_parityA_b,    U0AttrB_b,      U0AttrA_b,
                               validB_b,       validA_b,       dataOutB_b[20], dataOutA_b[20],
                               dataOutB_b[19], dataOutA_b[19], dataOutB_b[18], dataOutA_b[18],
                               dataOutB_b[17], dataOutA_b[17], dataOutB_b[16], dataOutA_b[16],
                               dataOutB_b[15], dataOutA_b[15], dataOutB_b[14], dataOutA_b[14],
                               dataOutB_b[13], dataOutA_b[13], dataOutB_b[12], dataOutA_b[12],
                               dataOutB_b[11], dataOutA_b[11], dataOutB_b[10], dataOutA_b[10],
                               dataOutB_b[9],  dataOutA_b[9],  dataOutB_b[8],  dataOutA_b[8],
                               dataOutB_b[7],  dataOutA_b[7],  dataOutB_b[6],  dataOutA_b[6],
                               dataOutB_b[5],  dataOutA_b[5],  dataOutB_b[4],  dataOutA_b[4],
                               dataOutB_b[3],  dataOutA_b[3],  dataOutB_b[2],  dataOutA_b[2],
                               dataOutB_b[1],  dataOutA_b[1],  dataOutB_b[0],  dataOutA_b[0]};

endmodule
