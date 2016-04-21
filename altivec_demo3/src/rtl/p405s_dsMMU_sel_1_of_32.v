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

module p405s_dsMMU_sel_1_of_32( spr1out,
                          spr2out, 
                          ea,
                          spr1,
                          spr2 
                        );

output  spr1out;
output  spr2out;

input [0:4]   ea;
input [0:31]  spr1;
input [0:31]  spr2;

// Buses in the design

reg         spr1out;
reg         spr2out;
reg  [0:7]  spr1_8of32;
reg  [0:7]  spr2_8of32;


  // Removed the module "dp_muxMMU_dsSelSPR2"
  always @(ea or spr1_8of32 or spr2_8of32)
    begin
      case(ea[0:2])
        3'b000: {spr1out, spr2out} = ~{spr1_8of32[0], spr2_8of32[0]};
        3'b001: {spr1out, spr2out} = ~{spr1_8of32[1], spr2_8of32[1]};
        3'b010: {spr1out, spr2out} = ~{spr1_8of32[2], spr2_8of32[2]};
        3'b011: {spr1out, spr2out} = ~{spr1_8of32[3], spr2_8of32[3]};
        3'b100: {spr1out, spr2out} = ~{spr1_8of32[4], spr2_8of32[4]};
        3'b101: {spr1out, spr2out} = ~{spr1_8of32[5], spr2_8of32[5]};
        3'b110: {spr1out, spr2out} = ~{spr1_8of32[6], spr2_8of32[6]};
        3'b111: {spr1out, spr2out} = ~{spr1_8of32[7], spr2_8of32[7]};
        default: {spr1out, spr2out} = 2'bx;
      endcase 
    end 

  // Removed the module "dp_muxMMU_selSPR"
  always @(ea or spr1 or spr2)
    begin
      case({ea[3],ea[4]})
        2'b00: {spr1_8of32[0:7],spr2_8of32[0:7]} = {spr1[0],spr1[4],spr1[8],spr1[12],spr1[16],
                                                   spr1[20],spr1[24],spr1[28],spr2[0],spr2[4],
                                                   spr2[8],spr2[12],spr2[16],spr2[20],spr2[24],
                                                   spr2[28]};
        2'b01: {spr1_8of32[0:7],spr2_8of32[0:7]} = {spr1[1],spr1[5],spr1[9],spr1[13],spr1[17],
                                                   spr1[21],spr1[25],spr1[29],spr2[1],spr2[5],
                                                   spr2[9],spr2[13],spr2[17],spr2[21],spr2[25],
                                                   spr2[29]};
        2'b10: {spr1_8of32[0:7],spr2_8of32[0:7]} = {spr1[2],spr1[6],spr1[10],spr1[14],spr1[18],
                                                   spr1[22],spr1[26],spr1[30],spr2[2],spr2[6],
                                                   spr2[10],spr2[14],spr2[18],spr2[22],spr2[26],
                                                   spr2[30]};
        2'b11: {spr1_8of32[0:7],spr2_8of32[0:7]} = {spr1[3],spr1[7],spr1[11],spr1[15],spr1[19],
                                                   spr1[23],spr1[27],spr1[31],spr2[3],spr2[7],
                                                   spr2[11],spr2[15],spr2[19],spr2[23],spr2[27],
                                                   spr2[31]};
        default: {spr1_8of32[0:7],spr2_8of32[0:7]} = 16'bx;
      endcase
    end


endmodule
