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

module p405s_DCU_parityRAM( p_dataOutA, 
                            p_dataOutB,  
                            addr, 
                            p_writeA, 
                            p_writeB, 
                            cclk, 
                            p_dataInA,
                            p_dataInB, 
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

output [0:15]  p_dataOutA;
output [0:15]  p_dataOutB;

input         cclk;
input         readWrite;
input [0:15]  p_dataInA;
input [0:15]  p_dataInB;
input [0:8]   addr;
input [0:15]  p_writeA;
input [0:15]  p_writeB;
input         sram_cen;

// RAM BIST IO

input          bist_mode;
input          bist_ce_n;
input          bist_we_n;
input [8:0]    bist_addr;
input [31:0]   bist_wr_data;
output [31:0]  bist_rd_data;
output [8:0]   cap_mem_addr;
output [31:0]  cap_mem_wr_data;
output         cap_mem_we;

wire          bist_mux_cen;
wire [0:31]   bist_mux_wen;
wire [0:8]    bist_mux_addr;
wire [0:31]   bist_mux_dataIn;
reg [0:15]    p_dataOutB_r;
reg [0:15]    p_dataOutA_r;
reg           readWrite_r;

wire         readWrite;
wire [0:15]  p_dataOutA;
wire [0:15]  p_dataOutA_b;
wire [0:15]  p_dataOutB;
wire [0:15]  p_dataOutB_b;

// BIST Shadow Capture Logic, grab data after the muxes

  assign cap_mem_addr    = 9'b0;
  assign cap_mem_wr_data = 32'b0;
  assign cap_mem_we      = 1'b0;


  assign bist_mux_dataIn = {p_dataInB[15], p_dataInB[14], p_dataInB[13], p_dataInB[12],
                            p_dataInB[11], p_dataInB[10], p_dataInB[9],  p_dataInB[8],
                            p_dataInB[7],  p_dataInB[6],  p_dataInB[5],  p_dataInB[4],
                            p_dataInB[3],  p_dataInB[2],  p_dataInB[1],  p_dataInB[0],
                            p_dataInA[15], p_dataInA[14], p_dataInA[13], p_dataInA[12],
                            p_dataInA[11], p_dataInA[10], p_dataInA[9],  p_dataInA[8],
                            p_dataInA[7],  p_dataInA[6],  p_dataInA[5],  p_dataInA[4],
                            p_dataInA[3],  p_dataInA[2],  p_dataInA[1],  p_dataInA[0]};

  assign bist_mux_addr = {addr[8], addr[7], addr[6], addr[5], addr[4],
                          addr[3], addr[2], addr[1], addr[0]};

  assign bist_mux_wen = readWrite ? 32'hffff_ffff :
                           ~{p_writeB[15], p_writeB[14], p_writeB[13], p_writeB[12],
                             p_writeB[11], p_writeB[10], p_writeB[9],  p_writeB[8],
                             p_writeB[7],  p_writeB[6],  p_writeB[5],  p_writeB[4],
                             p_writeB[3],  p_writeB[2],  p_writeB[1],  p_writeB[0],
                             p_writeA[15], p_writeA[14], p_writeA[13], p_writeA[12],
                             p_writeA[11], p_writeA[10], p_writeA[9],  p_writeA[8],
                             p_writeA[7],  p_writeA[6],  p_writeA[5],  p_writeA[4],
                             p_writeA[3],  p_writeA[2],  p_writeA[1],  p_writeA[0]};

  assign bist_mux_cen = sram_cen;

assign p_dataOutB = (readWrite_r)  ? p_dataOutB_b : p_dataOutB_r;
assign p_dataOutA = (readWrite_r)  ? p_dataOutA_b : p_dataOutA_r;

  always@(posedge cclk)
  begin

    if (~readWrite)
      readWrite_r <= 1'b0;
    else if (~bist_mux_cen)
      readWrite_r <= 1'b1;

    if (~readWrite && readWrite_r)
    begin
      p_dataOutB_r  <= p_dataOutB_b;
      p_dataOutA_r  <= p_dataOutA_b;
    end
  end

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

p405s_sram512x32_wrapper sram512x32_i (
                         .Q ({p_dataOutB_b[15], p_dataOutB_b[14], p_dataOutB_b[13], p_dataOutB_b[12],
                              p_dataOutB_b[11], p_dataOutB_b[10], p_dataOutB_b[9],  p_dataOutB_b[8],
                              p_dataOutB_b[7],  p_dataOutB_b[6],  p_dataOutB_b[5],  p_dataOutB_b[4],
                              p_dataOutB_b[3],  p_dataOutB_b[2],  p_dataOutB_b[1],  p_dataOutB_b[0],
                              p_dataOutA_b[15], p_dataOutA_b[14], p_dataOutA_b[13], p_dataOutA_b[12],
                              p_dataOutA_b[11], p_dataOutA_b[10], p_dataOutA_b[9],  p_dataOutA_b[8],
                              p_dataOutA_b[7],  p_dataOutA_b[6],  p_dataOutA_b[5],  p_dataOutA_b[4],
                              p_dataOutA_b[3],  p_dataOutA_b[2],  p_dataOutA_b[1],  p_dataOutA_b[0]}),
                         .CLK (cclk),
                         .CEN (bist_mux_cen),
                         .WEN (bist_mux_wen),
                         .A   (bist_mux_addr),
                         .D   (bist_mux_dataIn)
                        );

`else

// Artisan Specific RAM
sram512x32
 sram512x32_i (.Q ({p_dataOutB_b[15], p_dataOutB_b[14], p_dataOutB_b[13], p_dataOutB_b[12],
                              p_dataOutB_b[11], p_dataOutB_b[10], p_dataOutB_b[9],  p_dataOutB_b[8],
                              p_dataOutB_b[7],  p_dataOutB_b[6],  p_dataOutB_b[5],  p_dataOutB_b[4],
                              p_dataOutB_b[3],  p_dataOutB_b[2],  p_dataOutB_b[1],  p_dataOutB_b[0],
                              p_dataOutA_b[15], p_dataOutA_b[14], p_dataOutA_b[13], p_dataOutA_b[12],
                              p_dataOutA_b[11], p_dataOutA_b[10], p_dataOutA_b[9],  p_dataOutA_b[8],
                              p_dataOutA_b[7],  p_dataOutA_b[6],  p_dataOutA_b[5],  p_dataOutA_b[4],
                              p_dataOutA_b[3],  p_dataOutA_b[2],  p_dataOutA_b[1],  p_dataOutA_b[0]}),
                         .CLK (cclk),
                         .CEN (bist_mux_cen),
                         .WEN (bist_mux_wen),
                         .A   (bist_mux_addr),
                         .D   (bist_mux_dataIn)
                        );


`endif

assign bist_rd_data = {p_dataOutB_b[15], p_dataOutB_b[14], p_dataOutB_b[13], p_dataOutB_b[12],
                       p_dataOutB_b[11], p_dataOutB_b[10], p_dataOutB_b[9],  p_dataOutB_b[8],
                       p_dataOutB_b[7],  p_dataOutB_b[6],  p_dataOutB_b[5],  p_dataOutB_b[4],
                       p_dataOutB_b[3],  p_dataOutB_b[2],  p_dataOutB_b[1],  p_dataOutB_b[0],
                       p_dataOutA_b[15], p_dataOutA_b[14], p_dataOutA_b[13], p_dataOutA_b[12],
                       p_dataOutA_b[11], p_dataOutA_b[10], p_dataOutA_b[9],  p_dataOutA_b[8],
                       p_dataOutA_b[7],  p_dataOutA_b[6],  p_dataOutA_b[5],  p_dataOutA_b[4],
                       p_dataOutA_b[3],  p_dataOutA_b[2],  p_dataOutA_b[1],  p_dataOutA_b[0]};

endmodule
