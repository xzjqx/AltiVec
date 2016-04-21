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
module p405s_SM_wallaceTree (PC, RS, MD, MR, PS, mdSgn, mrSgn, FSMD, RC,
           LSMD, MMD, TE);
    output [0:32] PC;
    output [0:32] PS;
    input [0:31] RS;
    input [0:31] RC;
    input [0:16] MMD;
    input [0:15] MD;
    input [0:15] MR;
    input mdSgn;
    input mrSgn;
    input FSMD;
    input LSMD;
    input TE;

// Changes:
// 01/05/99 SBP Moved the muxing of mmdSgnBit to 1/2's comp function. See issue 350 for detail.

wire r0MSB, r1MSB, r2MSB, r3MSB, r4MSB, r5MSB, r6MSB, r7MSB, r8MSB, r9MSB, r10MSB, r11MSB, r12MSB, r13MSB, r14MSB, r15MSB;
wire [0:15] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [0:16] r0c, d0;
wire mdMrSgn;

assign mdMrSgn = mdSgn & mrSgn;

assign d0[0:16]  = (({17{mrSgn}} & r0c[0:16]) | ({17{~mrSgn}} & {1'b0,r0MSB,r0[1:15]}));
assign r0c[0:16] = ({17{MR[0]}} & MMD[0:16]);
assign r0[0:15]  = ({16{MR[0]}} & MD[0:15]);
assign r1[0:15]  = ({16{MR[1]}} & MD[0:15]);
assign r2[0:15]  = ({16{MR[2]}} & MD[0:15]);
assign r3[0:15]  = ({16{MR[3]}} & MD[0:15]);
assign r4[0:15]  = ({16{MR[4]}} & MD[0:15]);
assign r5[0:15]  = ({16{MR[5]}} & MD[0:15]);
assign r6[0:15]  = ({16{MR[6]}} & MD[0:15]);
assign r7[0:15]  = ({16{MR[7]}} & MD[0:15]);
assign r8[0:15]  = ({16{MR[8]}} & MD[0:15]);
assign r9[0:15]  = ({16{MR[9]}} & MD[0:15]);
assign r10[0:15] = ({16{MR[10]}} & MD[0:15]);
assign r11[0:15] = ({16{MR[11]}} & MD[0:15]);
assign r12[0:15] = ({16{MR[12]}} & MD[0:15]);
assign r13[0:15] = ({16{MR[13]}} & MD[0:15]);
assign r14[0:15] = ({16{MR[14]}} & MD[0:15]);
assign r15[0:15] = ({16{MR[15]}} & MD[0:15]);
assign r0MSB = r0[0] ^ mdSgn;
assign r1MSB = r1[0] ^ mdSgn;
assign r2MSB = r2[0] ^ mdSgn;
assign r3MSB = r3[0] ^ mdSgn;
assign r4MSB = r4[0] ^ mdSgn;
assign r5MSB = r5[0] ^ mdSgn;
assign r6MSB = r6[0] ^ mdSgn;
assign r7MSB = r7[0] ^ mdSgn;
assign r8MSB = r8[0] ^ mdSgn;
assign r9MSB = r9[0] ^ mdSgn;
assign r10MSB = r10[0] ^ mdSgn;
assign r11MSB = r11[0] ^ mdSgn;
assign r12MSB = r12[0] ^ mdSgn;
assign r13MSB = r13[0] ^ mdSgn;
assign r14MSB = r14[0] ^ mdSgn;
assign r15MSB = r15[0] ^ mdSgn;

// Level1-1
wire [13:28] C11, S11, cout11;
p405s_Compressor4To2
  l11_28(.C(C11[28]), .S(S11[28]), .cout(cout11[28]), .cin(1'b0),       .w(r14[13]), .x(r13[14]), .y(r12[15]), .z(1'b0));
p405s_Compressor4To2
  l11_27(.C(C11[27]), .S(S11[27]), .cout(cout11[27]), .cin(cout11[28]), .w(r14[12]), .x(r13[13]), .y(r12[14]), .z(r11[15]));
p405s_Compressor4To2
  l11_26(.C(C11[26]), .S(S11[26]), .cout(cout11[26]), .cin(cout11[27]), .w(r14[11]), .x(r13[12]), .y(r12[13]), .z(r11[14]));
p405s_Compressor4To2
  l11_25(.C(C11[25]), .S(S11[25]), .cout(cout11[25]), .cin(cout11[26]), .w(r14[10]), .x(r13[11]), .y(r12[12]), .z(r11[13]));
p405s_Compressor4To2
  l11_24(.C(C11[24]), .S(S11[24]), .cout(cout11[24]), .cin(cout11[25]), .w(r14[9]),  .x(r13[10]), .y(r12[11]), .z(r11[12]));
p405s_Compressor4To2
  l11_23(.C(C11[23]), .S(S11[23]), .cout(cout11[23]), .cin(cout11[24]), .w(r14[8]),  .x(r13[9]),  .y(r12[10]), .z(r11[11]));
p405s_Compressor4To2
  l11_22(.C(C11[22]), .S(S11[22]), .cout(cout11[22]), .cin(cout11[23]), .w(r14[7]),  .x(r13[8]),  .y(r12[9]),  .z(r11[10]));
p405s_Compressor4To2
  l11_21(.C(C11[21]), .S(S11[21]), .cout(cout11[21]), .cin(cout11[22]), .w(r14[6]),  .x(r13[7]),  .y(r12[8]),  .z(r11[9]));
p405s_Compressor4To2
  l11_20(.C(C11[20]), .S(S11[20]), .cout(cout11[20]), .cin(cout11[21]), .w(r14[5]),  .x(r13[6]),  .y(r12[7]),  .z(r11[8]));
p405s_Compressor4To2
  l11_19(.C(C11[19]), .S(S11[19]), .cout(cout11[19]), .cin(cout11[20]), .w(r14[4]),  .x(r13[5]),  .y(r12[6]),  .z(r11[7]));
p405s_Compressor4To2
  l11_18(.C(C11[18]), .S(S11[18]), .cout(cout11[18]), .cin(cout11[19]), .w(r14[3]),  .x(r13[4]),  .y(r12[5]),  .z(r11[6]));
p405s_Compressor4To2
  l11_17(.C(C11[17]), .S(S11[17]), .cout(cout11[17]), .cin(cout11[18]), .w(r14[2]),  .x(r13[3]),  .y(r12[4]),  .z(r11[5]));
p405s_Compressor4To2
  l11_16(.C(C11[16]), .S(S11[16]), .cout(cout11[16]), .cin(cout11[17]), .w(r14[1]),  .x(r13[2]),  .y(r12[3]),  .z(r11[4]));
p405s_Compressor4To2
  l11_15(.C(C11[15]), .S(S11[15]), .cout(cout11[15]), .cin(cout11[16]), .w(1'b0),    .x(r13[1]),  .y(r12[2]),  .z(r11[3]));
p405s_Compressor4To2
  l11_14(.C(C11[14]), .S(S11[14]), .cout(cout11[14]), .cin(cout11[15]), .w(1'b0),    .x(TE),      .y(r12[1]),  .z(r11[2]));
p405s_Compressor4To2
  l11_13(.C(C11[13]), .S(S11[13]), .cout(cout11[13]), .cin(cout11[14]), .w(1'b0),    .x(1'b0),    .y(1'b0),    .z(r11[1]));

// Level1-2
wire [9:24] C12, S12, cout12;
p405s_Compressor4To2
  l12_24(.C(C12[24]), .S(S12[24]), .cout(cout12[24]), .cin(1'b0),       .w(r10[13]), .x(r9[14]),  .y(r8[15]), .z(1'b0));
p405s_Compressor4To2
  l12_23(.C(C12[23]), .S(S12[23]), .cout(cout12[23]), .cin(cout12[24]), .w(r10[12]), .x(r9[13]),  .y(r8[14]), .z(r7[15]));
p405s_Compressor4To2
  l12_22(.C(C12[22]), .S(S12[22]), .cout(cout12[22]), .cin(cout12[23]), .w(r10[11]), .x(r9[12]),  .y(r8[13]), .z(r7[14]));
p405s_Compressor4To2
  l12_21(.C(C12[21]), .S(S12[21]), .cout(cout12[21]), .cin(cout12[22]), .w(r10[10]), .x(r9[11]),  .y(r8[12]), .z(r7[13]));
p405s_Compressor4To2
  l12_20(.C(C12[20]), .S(S12[20]), .cout(cout12[20]), .cin(cout12[21]), .w(r10[9]),  .x(r9[10]),  .y(r8[11]), .z(r7[12]));
p405s_Compressor4To2
  l12_19(.C(C12[19]), .S(S12[19]), .cout(cout12[19]), .cin(cout12[20]), .w(r10[8]),  .x(r9[9]),   .y(r8[10]), .z(r7[11]));
p405s_Compressor4To2
  l12_18(.C(C12[18]), .S(S12[18]), .cout(cout12[18]), .cin(cout12[19]), .w(r10[7]),  .x(r9[8]),   .y(r8[9]),  .z(r7[10]));
p405s_Compressor4To2
  l12_17(.C(C12[17]), .S(S12[17]), .cout(cout12[17]), .cin(cout12[18]), .w(r10[6]),  .x(r9[7]),   .y(r8[8]),  .z(r7[9]));
p405s_Compressor4To2
  l12_16(.C(C12[16]), .S(S12[16]), .cout(cout12[16]), .cin(cout12[17]), .w(r10[5]),  .x(r9[6]),   .y(r8[7]),  .z(r7[8]));
p405s_Compressor4To2
  l12_15(.C(C12[15]), .S(S12[15]), .cout(cout12[15]), .cin(cout12[16]), .w(r10[4]),  .x(r9[5]),   .y(r8[6]),  .z(r7[7]));
p405s_Compressor4To2
  l12_14(.C(C12[14]), .S(S12[14]), .cout(cout12[14]), .cin(cout12[15]), .w(r10[3]),  .x(r9[4]),   .y(r8[5]),  .z(r7[6]));
p405s_Compressor4To2
  l12_13(.C(C12[13]), .S(S12[13]), .cout(cout12[13]), .cin(cout12[14]), .w(r10[2]),  .x(r9[3]),   .y(r8[4]),  .z(r7[5]));
p405s_Compressor4To2
  l12_12(.C(C12[12]), .S(S12[12]), .cout(cout12[12]), .cin(cout12[13]), .w(r10[1]),  .x(r9[2]),   .y(r8[3]),  .z(r7[4]));
p405s_Compressor4To2
  l12_11(.C(C12[11]), .S(S12[11]), .cout(cout12[11]), .cin(cout12[12]), .w(1'b0),    .x(r9[1]),   .y(r8[2]),  .z(r7[3]));
p405s_Compressor4To2
  l12_10(.C(C12[10]), .S(S12[10]), .cout(cout12[10]), .cin(cout12[11]), .w(1'b0),    .x(TE),      .y(r8[1]),  .z(r7[2]));
p405s_Compressor4To2
  l12_09(.C(C12[9]),  .S(S12[9]),  .cout(cout12[9]),  .cin(cout12[10]), .w(1'b0),    .x(1'b0),    .y(1'b0),   .z(r7[1]));

// Level1-3
wire [5:20] C13, S13, cout13;
p405s_Compressor4To2
  l13_20(.C(C13[20]), .S(S13[20]), .cout(cout13[20]), .cin(1'b0),       .w(r6[13]), .x(r5[14]), .y(r4[15]), .z(1'b0));
p405s_Compressor4To2
  l13_19(.C(C13[19]), .S(S13[19]), .cout(cout13[19]), .cin(cout13[20]), .w(r6[12]), .x(r5[13]), .y(r4[14]), .z(r3[15]));
p405s_Compressor4To2
  l13_18(.C(C13[18]), .S(S13[18]), .cout(cout13[18]), .cin(cout13[19]), .w(r6[11]), .x(r5[12]), .y(r4[13]), .z(r3[14]));
p405s_Compressor4To2
  l13_17(.C(C13[17]), .S(S13[17]), .cout(cout13[17]), .cin(cout13[18]), .w(r6[10]), .x(r5[11]), .y(r4[12]), .z(r3[13]));
p405s_Compressor4To2
  l13_16(.C(C13[16]), .S(S13[16]), .cout(cout13[16]), .cin(cout13[17]), .w(r6[9]),  .x(r5[10]), .y(r4[11]), .z(r3[12]));
p405s_Compressor4To2
  l13_15(.C(C13[15]), .S(S13[15]), .cout(cout13[15]), .cin(cout13[16]), .w(r6[8]),  .x(r5[9]),  .y(r4[10]), .z(r3[11]));
p405s_Compressor4To2
  l13_14(.C(C13[14]), .S(S13[14]), .cout(cout13[14]), .cin(cout13[15]), .w(r6[7]),  .x(r5[8]),  .y(r4[9]),  .z(r3[10]));
p405s_Compressor4To2
  l13_13(.C(C13[13]), .S(S13[13]), .cout(cout13[13]), .cin(cout13[14]), .w(r6[6]),  .x(r5[7]),  .y(r4[8]),  .z(r3[9]));
p405s_Compressor4To2
  l13_12(.C(C13[12]), .S(S13[12]), .cout(cout13[12]), .cin(cout13[13]), .w(r6[5]),  .x(r5[6]),  .y(r4[7]),  .z(r3[8]));
p405s_Compressor4To2
  l13_11(.C(C13[11]), .S(S13[11]), .cout(cout13[11]), .cin(cout13[12]), .w(r6[4]),  .x(r5[5]),  .y(r4[6]),  .z(r3[7]));
p405s_Compressor4To2
  l13_10(.C(C13[10]), .S(S13[10]), .cout(cout13[10]), .cin(cout13[11]), .w(r6[3]),  .x(r5[4]),  .y(r4[5]),  .z(r3[6]));
p405s_Compressor4To2
  l13_09(.C(C13[9]),  .S(S13[9]),  .cout(cout13[9]),  .cin(cout13[10]), .w(r6[2]),  .x(r5[3]),  .y(r4[4]),  .z(r3[5]));
p405s_Compressor4To2
  l13_08(.C(C13[8]),  .S(S13[8]),  .cout(cout13[8]),  .cin(cout13[9]),  .w(r6[1]),  .x(r5[2]),  .y(r4[3]),  .z(r3[4]));
p405s_Compressor4To2
  l13_07(.C(C13[7]),  .S(S13[7]),  .cout(cout13[7]),  .cin(cout13[8]),  .w(1'b0),   .x(r5[1]),  .y(r4[2]),  .z(r3[3]));
p405s_Compressor4To2
  l13_06(.C(C13[6]),  .S(S13[6]),  .cout(cout13[6]),  .cin(cout13[7]),  .w(1'b0),   .x(TE),     .y(r4[1]),  .z(r3[2]));
p405s_Compressor4To2
  l13_05(.C(C13[5]),  .S(S13[5]),  .cout(cout13[5]),  .cin(cout13[6]),  .w(1'b0),   .x(1'b0),   .y(1'b0),   .z(r3[1]));

// Level1-4
wire [0:18] C14, S14, cout14;
p405s_Compressor4To2
  l14_18(.C(C14[18]), .S(S14[18]), .cout(cout14[18]), .cin(1'b0),       .w(r2[15]), .x(1'b0),   .y(RC[18]), .z(RS[18]));
p405s_Compressor4To2
  l14_17(.C(C14[17]), .S(S14[17]), .cout(cout14[17]), .cin(cout14[18]), .w(r2[14]), .x(r1[15]), .y(RC[17]), .z(RS[17]));
p405s_Compressor4To2
  l14_16(.C(C14[16]), .S(S14[16]), .cout(cout14[16]), .cin(cout14[17]), .w(r2[13]), .x(r1[14]), .y(RC[16]), .z(RS[16]));
p405s_Compressor4To2
  l14_15(.C(C14[15]), .S(S14[15]), .cout(cout14[15]), .cin(cout14[16]), .w(r2[12]), .x(r1[13]), .y(RC[15]), .z(RS[15]));
p405s_Compressor4To2
  l14_14(.C(C14[14]), .S(S14[14]), .cout(cout14[14]), .cin(cout14[15]), .w(r2[11]), .x(r1[12]), .y(RC[14]), .z(RS[14]));
p405s_Compressor4To2
  l14_13(.C(C14[13]), .S(S14[13]), .cout(cout14[13]), .cin(cout14[14]), .w(r2[10]), .x(r1[11]), .y(RC[13]), .z(RS[13]));
p405s_Compressor4To2
  l14_12(.C(C14[12]), .S(S14[12]), .cout(cout14[12]), .cin(cout14[13]), .w(r2[9]),  .x(r1[10]), .y(RC[12]), .z(RS[12]));
p405s_Compressor4To2
  l14_11(.C(C14[11]), .S(S14[11]), .cout(cout14[11]), .cin(cout14[12]), .w(r2[8]),  .x(r1[9]),  .y(RC[11]), .z(RS[11]));
p405s_Compressor4To2
  l14_10(.C(C14[10]), .S(S14[10]), .cout(cout14[10]), .cin(cout14[11]), .w(r2[7]),  .x(r1[8]),  .y(RC[10]), .z(RS[10]));
p405s_Compressor4To2
  l14_09(.C(C14[9]),  .S(S14[9]),  .cout(cout14[9]),  .cin(cout14[10]), .w(r2[6]),  .x(r1[7]),  .y(RC[9]),  .z(RS[9]));
p405s_Compressor4To2
  l14_08(.C(C14[8]),  .S(S14[8]),  .cout(cout14[8]),  .cin(cout14[9]),  .w(r2[5]),  .x(r1[6]),  .y(RC[8]),  .z(RS[8]));
p405s_Compressor4To2
  l14_07(.C(C14[7]),  .S(S14[7]),  .cout(cout14[7]),  .cin(cout14[8]),  .w(r2[4]),  .x(r1[5]),  .y(RC[7]),  .z(RS[7]));
p405s_Compressor4To2
  l14_06(.C(C14[6]),  .S(S14[6]),  .cout(cout14[6]),  .cin(cout14[7]),  .w(r2[3]),  .x(r1[4]),  .y(RC[6]),  .z(RS[6]));
p405s_Compressor4To2
  l14_05(.C(C14[5]),  .S(S14[5]),  .cout(cout14[5]),  .cin(cout14[6]),  .w(r2[2]),  .x(r1[3]),  .y(RC[5]),  .z(RS[5]));
p405s_Compressor4To2
  l14_04(.C(C14[4]),  .S(S14[4]),  .cout(cout14[4]),  .cin(cout14[5]),  .w(r2[1]),  .x(r1[2]),  .y(RC[4]),  .z(RS[4]));
p405s_Compressor4To2
  l14_03(.C(C14[3]),  .S(S14[3]),  .cout(cout14[3]),  .cin(cout14[4]),  .w(1'b0),   .x(r1[1]),  .y(RC[3]),  .z(RS[3]));
p405s_Compressor4To2
  l14_02(.C(C14[2]),  .S(S14[2]),  .cout(cout14[2]),  .cin(cout14[3]),  .w(1'b0),   .x(1'b0),   .y(RC[2]),  .z(RS[2]));
p405s_Compressor4To2
  l14_01(.C(C14[1]),  .S(S14[1]),  .cout(cout14[1]),  .cin(cout14[2]),  .w(1'b0),   .x(1'b0),   .y(RC[1]),  .z(RS[1]));
p405s_Compressor4To2
  l14_00(.C(C14[0]),  .S(S14[0]),  .cout(cout14[0]),  .cin(cout14[1]),  .w(1'b0),   .x(1'b0),   .y(RC[0]),  .z(RS[0]));

// Level2-1
wire [8:26] C21, S21, cout21;
p405s_Compressor4To2
  l21_26(.C(C21[26]), .S(S21[26]), .cout(cout21[26]), .cin(1'b0),       .w(S11[26]),    .x(C11[27]), .y(r10[15]),     .z(1'b0));
p405s_Compressor4To2
  l21_25(.C(C21[25]), .S(S21[25]), .cout(cout21[25]), .cin(cout21[26]), .w(S11[25]),    .x(C11[26]), .y(r10[14]),     .z(r9[15]));
p405s_Compressor4To2
  l21_24(.C(C21[24]), .S(S21[24]), .cout(cout21[24]), .cin(cout21[25]), .w(S11[24]),    .x(C11[25]), .y(S12[24]),     .z(1'b0));
p405s_Compressor4To2
  l21_23(.C(C21[23]), .S(S21[23]), .cout(cout21[23]), .cin(cout21[24]), .w(S11[23]),    .x(C11[24]), .y(S12[23]),     .z(C12[24]));
p405s_Compressor4To2
  l21_22(.C(C21[22]), .S(S21[22]), .cout(cout21[22]), .cin(cout21[23]), .w(S11[22]),    .x(C11[23]), .y(S12[22]),     .z(C12[23]));
p405s_Compressor4To2
  l21_21(.C(C21[21]), .S(S21[21]), .cout(cout21[21]), .cin(cout21[22]), .w(S11[21]),    .x(C11[22]), .y(S12[21]),     .z(C12[22]));
p405s_Compressor4To2
  l21_20(.C(C21[20]), .S(S21[20]), .cout(cout21[20]), .cin(cout21[21]), .w(S11[20]),    .x(C11[21]), .y(S12[20]),     .z(C12[21]));
p405s_Compressor4To2
  l21_19(.C(C21[19]), .S(S21[19]), .cout(cout21[19]), .cin(cout21[20]), .w(S11[19]),    .x(C11[20]), .y(S12[19]),     .z(C12[20]));
p405s_Compressor4To2
  l21_18(.C(C21[18]), .S(S21[18]), .cout(cout21[18]), .cin(cout21[19]), .w(S11[18]),    .x(C11[19]), .y(S12[18]),     .z(C12[19]));
p405s_Compressor4To2
  l21_17(.C(C21[17]), .S(S21[17]), .cout(cout21[17]), .cin(cout21[18]), .w(S11[17]),    .x(C11[18]), .y(S12[17]),     .z(C12[18]));
p405s_Compressor4To2
  l21_16(.C(C21[16]), .S(S21[16]), .cout(cout21[16]), .cin(cout21[17]), .w(S11[16]),    .x(C11[17]), .y(S12[16]),     .z(C12[17]));
p405s_Compressor4To2
  l21_15(.C(C21[15]), .S(S21[15]), .cout(cout21[15]), .cin(cout21[16]), .w(S11[15]),    .x(C11[16]), .y(S12[15]),     .z(C12[16]));
p405s_Compressor4To2
  l21_14(.C(C21[14]), .S(S21[14]), .cout(cout21[14]), .cin(cout21[15]), .w(S11[14]),    .x(C11[15]), .y(S12[14]),     .z(C12[15]));
p405s_Compressor4To2
  l21_13(.C(C21[13]), .S(S21[13]), .cout(cout21[13]), .cin(cout21[14]), .w(S11[13]),    .x(C11[14]), .y(S12[13]),     .z(C12[14]));
p405s_Compressor4To2
  l21_12(.C(C21[12]), .S(S21[12]), .cout(cout21[12]), .cin(cout21[13]), .w(1'b0),       .x(C11[13]), .y(S12[12]),     .z(C12[13]));
p405s_Compressor4To2
  l21_11(.C(C21[11]), .S(S21[11]), .cout(cout21[11]), .cin(cout21[12]), .w(1'b0),       .x(1'b0),    .y(S12[11]),     .z(C12[12]));
p405s_Compressor4To2
  l21_10(.C(C21[10]), .S(S21[10]), .cout(cout21[10]), .cin(cout21[11]), .w(1'b0),       .x(1'b0),    .y(S12[10]),     .z(C12[11]));
p405s_Compressor4To2
  l21_09(.C(C21[9]),  .S(S21[9]),  .cout(cout21[9]),  .cin(cout21[10]), .w(1'b0),       .x(1'b0),    .y(S12[9]),      .z(C12[10]));
p405s_Compressor4To2
  l21_08(.C(C21[8]),  .S(S21[8]),  .cout(cout21[8]),  .cin(cout21[9]),  .w(1'b0),       .x(1'b0),    .y(1'b0),        .z(C12[9]));

// Level2-2
wire [0:23] C22, S22, cout22;
p405s_Compressor4To2
  l22_22(.C(C22[23]), .S(S22[23]), .cout(cout22[23]), .cin(1'b0),       .w(r6[15]),     .x(1'b0),    .y(RC[22]),     .z(RS[22]));
p405s_Compressor4To2
  l22_21(.C(C22[22]), .S(S22[22]), .cout(cout22[22]), .cin(cout22[23]), .w(r6[14]),     .x(r5[15]),  .y(RC[21]),     .z(RS[21]));
p405s_Compressor4To2
  l22_20(.C(C22[21]), .S(S22[21]), .cout(cout22[21]), .cin(cout22[22]), .w(S13[20]),    .x(1'b0),    .y(RC[20]),     .z(RS[20]));
p405s_Compressor4To2
  l22_19(.C(C22[20]), .S(S22[20]), .cout(cout22[20]), .cin(cout22[21]), .w(S13[19]),    .x(C13[20]), .y(RC[19]),     .z(RS[19]));
p405s_Compressor4To2
  l22_18(.C(C22[19]), .S(S22[19]), .cout(cout22[19]), .cin(cout22[20]), .w(S13[18]),    .x(C13[19]), .y(S14[18]),    .z(1'b0));
p405s_Compressor4To2
  l22_17(.C(C22[18]), .S(S22[18]), .cout(cout22[18]), .cin(cout22[19]), .w(S13[17]),    .x(C13[18]), .y(S14[17]),    .z(C14[18]));
p405s_Compressor4To2
  l22_16(.C(C22[17]), .S(S22[17]), .cout(cout22[17]), .cin(cout22[18]), .w(S13[16]),    .x(C13[17]), .y(S14[16]),    .z(C14[17]));
p405s_Compressor4To2
  l22_15(.C(C22[16]), .S(S22[16]), .cout(cout22[16]), .cin(cout22[17]), .w(S13[15]),    .x(C13[16]), .y(S14[15]),    .z(C14[16]));
p405s_Compressor4To2
  l22_14(.C(C22[15]), .S(S22[15]), .cout(cout22[15]), .cin(cout22[16]), .w(S13[14]),    .x(C13[15]), .y(S14[14]),    .z(C14[15]));
p405s_Compressor4To2
  l22_13(.C(C22[14]), .S(S22[14]), .cout(cout22[14]), .cin(cout22[15]), .w(S13[13]),    .x(C13[14]), .y(S14[13]),    .z(C14[14]));
p405s_Compressor4To2
  l22_12(.C(C22[13]), .S(S22[13]), .cout(cout22[13]), .cin(cout22[14]), .w(S13[12]),    .x(C13[13]), .y(S14[12]),    .z(C14[13]));
p405s_Compressor4To2
  l22_11(.C(C22[12]), .S(S22[12]), .cout(cout22[12]), .cin(cout22[13]), .w(S13[11]),    .x(C13[12]), .y(S14[11]),    .z(C14[12]));
p405s_Compressor4To2
  l22_10(.C(C22[11]), .S(S22[11]), .cout(cout22[11]), .cin(cout22[12]), .w(S13[10]),    .x(C13[11]), .y(S14[10]),    .z(C14[11]));
p405s_Compressor4To2
  l22_09(.C(C22[10]), .S(S22[10]), .cout(cout22[10]), .cin(cout22[11]), .w(S13[9]),     .x(C13[10]), .y(S14[9]),     .z(C14[10]));
p405s_Compressor4To2
  l22_08(.C(C22[9]),  .S(S22[9]),  .cout(cout22[9]),  .cin(cout22[10]), .w(S13[8]),     .x(C13[9]),  .y(S14[8]),     .z(C14[9]));
p405s_Compressor4To2
  l22_07(.C(C22[8]),  .S(S22[8]),  .cout(cout22[8]),  .cin(cout22[9]),  .w(S13[7]),     .x(C13[8]),  .y(S14[7]),     .z(C14[8]));
p405s_Compressor4To2
  l22_06(.C(C22[7]),  .S(S22[7]),  .cout(cout22[7]),  .cin(cout22[8]),  .w(S13[6]),     .x(C13[7]),  .y(S14[6]),     .z(C14[7]));
p405s_Compressor4To2
  l22_05(.C(C22[6]),  .S(S22[6]),  .cout(cout22[6]),  .cin(cout22[7]),  .w(S13[5]),     .x(C13[6]),  .y(S14[5]),     .z(C14[6]));
p405s_Compressor4To2
  l22_04(.C(C22[5]),  .S(S22[5]),  .cout(cout22[5]),  .cin(cout22[6]),  .w(1'b0),       .x(C13[5]),  .y(S14[4]),     .z(C14[5]));
p405s_Compressor4To2
  l22_03(.C(C22[4]),  .S(S22[4]),  .cout(cout22[4]),  .cin(cout22[5]),  .w(1'b0),       .x(1'b0),    .y(S14[3]),     .z(C14[4]));
p405s_Compressor4To2
  l22_02(.C(C22[3]),  .S(S22[3]),  .cout(cout22[3]),  .cin(cout22[4]),  .w(1'b0),       .x(1'b0),    .y(S14[2]),     .z(C14[3]));
p405s_Compressor4To2
  l22_01(.C(C22[2]),  .S(S22[2]),  .cout(cout22[2]),  .cin(cout22[3]),  .w(1'b0),       .x(1'b0),    .y(S14[1]),     .z(C14[2]));
p405s_Compressor4To2
  l22_00(.C(C22[1]),  .S(S22[1]),  .cout(cout22[1]),  .cin(cout22[2]),  .w(1'b0),       .x(1'b0),    .y(S14[0]),     .z(C14[1]));
p405s_Compressor4To2
  l22_M1(.C(C22[0]),  .S(S22[0]),  .cout(cout22[0]),  .cin(cout22[1]),  .w(1'b0),       .x(1'b0),    .y(cout14[0]),  .z(C14[0]));

// Level3-1
wire [0:32] C31, S31, cout31;
p405s_Compressor4To2
  l31_31(.C(C31[32]), .S(S31[32]), .cout(cout31[32]), .cin(1'b0),       .w(FSMD),       .x(1'b0),    .y(RC[31]),  .z(RS[31]));
p405s_Compressor4To2
  l31_30(.C(C31[31]), .S(S31[31]), .cout(cout31[31]), .cin(cout31[32]), .w(r14[15]),    .x(1'b0),    .y(RC[30]),  .z(RS[30]));
p405s_Compressor4To2
  l31_29(.C(C31[30]), .S(S31[30]), .cout(cout31[30]), .cin(cout31[31]), .w(r14[14]),    .x(r13[15]), .y(RC[29]),  .z(RS[29]));
p405s_Compressor4To2
  l31_28(.C(C31[29]), .S(S31[29]), .cout(cout31[29]), .cin(cout31[30]), .w(S11[28]),    .x(1'b0),    .y(RC[28]),  .z(RS[28]));
p405s_Compressor4To2
  l31_27(.C(C31[28]), .S(S31[28]), .cout(cout31[28]), .cin(cout31[29]), .w(S11[27]),    .x(C11[28]), .y(RC[27]),  .z(RS[27]));
p405s_Compressor4To2
  l31_26(.C(C31[27]), .S(S31[27]), .cout(cout31[27]), .cin(cout31[28]), .w(S21[26]),    .x(1'b0),    .y(RC[26]),  .z(RS[26]));
p405s_Compressor4To2
  l31_25(.C(C31[26]), .S(S31[26]), .cout(cout31[26]), .cin(cout31[27]), .w(S21[25]),    .x(C21[26]), .y(RC[25]),  .z(RS[25]));
p405s_Compressor4To2
  l31_24(.C(C31[25]), .S(S31[25]), .cout(cout31[25]), .cin(cout31[26]), .w(S21[24]),    .x(C21[25]), .y(RC[24]),  .z(RS[24]));
p405s_Compressor4To2
  l31_23(.C(C31[24]), .S(S31[24]), .cout(cout31[24]), .cin(cout31[25]), .w(S21[23]),    .x(C21[24]), .y(RC[23]),  .z(RS[23]));
p405s_Compressor4To2
  l31_22(.C(C31[23]), .S(S31[23]), .cout(cout31[23]), .cin(cout31[24]), .w(S21[22]),    .x(C21[23]), .y(S22[23]), .z(1'b0));
p405s_Compressor4To2
  l31_21(.C(C31[22]), .S(S31[22]), .cout(cout31[22]), .cin(cout31[23]), .w(S21[21]),    .x(C21[22]), .y(S22[22]), .z(C22[23]));
p405s_Compressor4To2
  l31_20(.C(C31[21]), .S(S31[21]), .cout(cout31[21]), .cin(cout31[22]), .w(S21[20]),    .x(C21[21]), .y(S22[21]), .z(C22[22]));
p405s_Compressor4To2
  l31_19(.C(C31[20]), .S(S31[20]), .cout(cout31[20]), .cin(cout31[21]), .w(S21[19]),    .x(C21[20]), .y(S22[20]), .z(C22[21]));
p405s_Compressor4To2
  l31_18(.C(C31[19]), .S(S31[19]), .cout(cout31[19]), .cin(cout31[20]), .w(S21[18]),    .x(C21[19]), .y(S22[19]), .z(C22[20]));
p405s_Compressor4To2
  l31_17(.C(C31[18]), .S(S31[18]), .cout(cout31[18]), .cin(cout31[19]), .w(S21[17]),    .x(C21[18]), .y(S22[18]), .z(C22[19]));
p405s_Compressor4To2
  l31_16(.C(C31[17]), .S(S31[17]), .cout(cout31[17]), .cin(cout31[18]), .w(S21[16]),    .x(C21[17]), .y(S22[17]), .z(C22[18]));
p405s_Compressor4To2
  l31_15(.C(C31[16]), .S(S31[16]), .cout(cout31[16]), .cin(cout31[17]), .w(S21[15]),    .x(C21[16]), .y(S22[16]), .z(C22[17]));
p405s_Compressor4To2
  l31_14(.C(C31[15]), .S(S31[15]), .cout(cout31[15]), .cin(cout31[16]), .w(S21[14]),    .x(C21[15]), .y(S22[15]), .z(C22[16]));
p405s_Compressor4To2
  l31_13(.C(C31[14]), .S(S31[14]), .cout(cout31[14]), .cin(cout31[15]), .w(S21[13]),    .x(C21[14]), .y(S22[14]), .z(C22[15]));
p405s_Compressor4To2
  l31_12(.C(C31[13]), .S(S31[13]), .cout(cout31[13]), .cin(cout31[14]), .w(S21[12]),    .x(C21[13]), .y(S22[13]), .z(C22[14]));
p405s_Compressor4To2
  l31_11(.C(C31[12]), .S(S31[12]), .cout(cout31[12]), .cin(cout31[13]), .w(S21[11]),    .x(C21[12]), .y(S22[12]), .z(C22[13]));
p405s_Compressor4To2
  l31_10(.C(C31[11]), .S(S31[11]), .cout(cout31[11]), .cin(cout31[12]), .w(S21[10]),    .x(C21[11]), .y(S22[11]), .z(C22[12]));
p405s_Compressor4To2
  l31_09(.C(C31[10]), .S(S31[10]), .cout(cout31[10]), .cin(cout31[11]), .w(S21[9]),     .x(C21[10]), .y(S22[10]), .z(C22[11]));
p405s_Compressor4To2
  l31_08(.C(C31[9]),  .S(S31[9]),  .cout(cout31[9]),  .cin(cout31[10]), .w(S21[8]),     .x(C21[9]),  .y(S22[9]),  .z(C22[10]));
p405s_Compressor4To2
  l31_07(.C(C31[8]),  .S(S31[8]),  .cout(cout31[8]),  .cin(cout31[9]),  .w(1'b0),       .x(C21[8]),  .y(S22[8]),  .z(C22[9]));
p405s_Compressor4To2
  l31_06(.C(C31[7]),  .S(S31[7]),  .cout(cout31[7]),  .cin(cout31[8]),  .w(1'b0),       .x(1'b0),    .y(S22[7]),  .z(C22[8]));
p405s_Compressor4To2
  l31_05(.C(C31[6]),  .S(S31[6]),  .cout(cout31[6]),  .cin(cout31[7]),  .w(1'b0),       .x(1'b0),    .y(S22[6]),  .z(C22[7]));
p405s_Compressor4To2
  l31_04(.C(C31[5]),  .S(S31[5]),  .cout(cout31[5]),  .cin(cout31[6]),  .w(1'b0),       .x(1'b0),    .y(S22[5]),  .z(C22[6]));
p405s_Compressor4To2
  l31_03(.C(C31[4]),  .S(S31[4]),  .cout(cout31[4]),  .cin(cout31[5]),  .w(1'b0),       .x(1'b0),    .y(S22[4]),  .z(C22[5]));
p405s_Compressor4To2
  l31_02(.C(C31[3]),  .S(S31[3]),  .cout(cout31[3]),  .cin(cout31[4]),  .w(1'b0),       .x(1'b0),    .y(S22[3]),  .z(C22[4]));
p405s_Compressor4To2
  l31_01(.C(C31[2]),  .S(S31[2]),  .cout(cout31[2]),  .cin(cout31[3]),  .w(1'b0),       .x(1'b0),    .y(S22[2]),  .z(C22[3]));
p405s_Compressor4To2
  l31_00(.C(C31[1]),  .S(S31[1]),  .cout(cout31[1]),  .cin(cout31[2]),  .w(1'b0),       .x(1'b0),    .y(S22[1]),  .z(C22[2]));
p405s_Compressor4To2
  l31_M1(.C(C31[0]),  .S(S31[0]),  .cout(cout31[0]),  .cin(cout31[1]),  .w(1'b0),       .x(1'b0),    .y(S22[0]),  .z(C22[1]));


// Level4-1
wire [0:32] cout41;
p405s_Compressor4To2
  l41_31(.C(PC[32]), .S(PS[32]), .cout(cout41[32]), .cin(1'b0),       .w(S31[32]),    .x(1'b0),    .y(FSMD),      .z(r15[15]));
p405s_Compressor4To2
  l41_30(.C(PC[31]), .S(PS[31]), .cout(cout41[31]), .cin(cout41[32]), .w(S31[31]),    .x(C31[32]), .y(FSMD),      .z(r15[14]));
p405s_Compressor4To2
  l41_29(.C(PC[30]), .S(PS[30]), .cout(cout41[30]), .cin(cout41[31]), .w(S31[30]),    .x(C31[31]), .y(FSMD),      .z(r15[13]));
p405s_Compressor4To2
  l41_28(.C(PC[29]), .S(PS[29]), .cout(cout41[29]), .cin(cout41[30]), .w(S31[29]),    .x(C31[30]), .y(FSMD),      .z(r15[12]));
p405s_Compressor4To2
  l41_27(.C(PC[28]), .S(PS[28]), .cout(cout41[28]), .cin(cout41[29]), .w(S31[28]),    .x(C31[29]), .y(FSMD),      .z(r15[11]));
p405s_Compressor4To2
  l41_26(.C(PC[27]), .S(PS[27]), .cout(cout41[27]), .cin(cout41[28]), .w(S31[27]),    .x(C31[28]), .y(FSMD),      .z(r15[10]));
p405s_Compressor4To2
  l41_25(.C(PC[26]), .S(PS[26]), .cout(cout41[26]), .cin(cout41[27]), .w(S31[26]),    .x(C31[27]), .y(FSMD),      .z(r15[9]));
p405s_Compressor4To2
  l41_24(.C(PC[25]), .S(PS[25]), .cout(cout41[25]), .cin(cout41[26]), .w(S31[25]),    .x(C31[26]), .y(FSMD),      .z(r15[8]));
p405s_Compressor4To2
  l41_23(.C(PC[24]), .S(PS[24]), .cout(cout41[24]), .cin(cout41[25]), .w(S31[24]),    .x(C31[25]), .y(FSMD),      .z(r15[7]));
p405s_Compressor4To2
  l41_22(.C(PC[23]), .S(PS[23]), .cout(cout41[23]), .cin(cout41[24]), .w(S31[23]),    .x(C31[24]), .y(FSMD),      .z(r15[6]));
p405s_Compressor4To2
  l41_21(.C(PC[22]), .S(PS[22]), .cout(cout41[22]), .cin(cout41[23]), .w(S31[22]),    .x(C31[23]), .y(FSMD),      .z(r15[5]));
p405s_Compressor4To2
  l41_20(.C(PC[21]), .S(PS[21]), .cout(cout41[21]), .cin(cout41[22]), .w(S31[21]),    .x(C31[22]), .y(FSMD),      .z(r15[4]));
p405s_Compressor4To2
  l41_19(.C(PC[20]), .S(PS[20]), .cout(cout41[20]), .cin(cout41[21]), .w(S31[20]),    .x(C31[21]), .y(FSMD),      .z(r15[3]));
p405s_Compressor4To2
  l41_18(.C(PC[19]), .S(PS[19]), .cout(cout41[19]), .cin(cout41[20]), .w(S31[19]),    .x(C31[20]), .y(FSMD),      .z(r15[2]));
p405s_Compressor4To2
  l41_17(.C(PC[18]), .S(PS[18]), .cout(cout41[18]), .cin(cout41[19]), .w(S31[18]),    .x(C31[19]), .y(FSMD),      .z(r15[1]));
p405s_Compressor4To2
  l41_16(.C(PC[17]), .S(PS[17]), .cout(cout41[17]), .cin(cout41[18]), .w(S31[17]),    .x(C31[18]), .y(d0[16]),    .z(r15MSB));
p405s_Compressor4To2
  l41_15(.C(PC[16]), .S(PS[16]), .cout(cout41[16]), .cin(cout41[17]), .w(S31[16]),    .x(C31[17]), .y(d0[15]),    .z(r14MSB));
p405s_Compressor4To2
  l41_14(.C(PC[15]), .S(PS[15]), .cout(cout41[15]), .cin(cout41[16]), .w(S31[15]),    .x(C31[16]), .y(d0[14]),    .z(r13MSB));
p405s_Compressor4To2
  l41_13(.C(PC[14]), .S(PS[14]), .cout(cout41[14]), .cin(cout41[15]), .w(S31[14]),    .x(C31[15]), .y(d0[13]),    .z(r12MSB));
p405s_Compressor4To2
  l41_12(.C(PC[13]), .S(PS[13]), .cout(cout41[13]), .cin(cout41[14]), .w(S31[13]),    .x(C31[14]), .y(d0[12]),    .z(r11MSB));
p405s_Compressor4To2
  l41_11(.C(PC[12]), .S(PS[12]), .cout(cout41[12]), .cin(cout41[13]), .w(S31[12]),    .x(C31[13]), .y(d0[11]),    .z(r10MSB));
p405s_Compressor4To2
  l41_10(.C(PC[11]), .S(PS[11]), .cout(cout41[11]), .cin(cout41[12]), .w(S31[11]),    .x(C31[12]), .y(d0[10]),     .z(r9MSB));
p405s_Compressor4To2
  l41_09(.C(PC[10]), .S(PS[10]), .cout(cout41[10]), .cin(cout41[11]), .w(S31[10]),    .x(C31[11]), .y(d0[9]),     .z(r8MSB));
p405s_Compressor4To2
  l41_08(.C(PC[9]),  .S(PS[9]),  .cout(cout41[9]),  .cin(cout41[10]), .w(S31[9]),     .x(C31[10]), .y(d0[8]),     .z(r7MSB));
p405s_Compressor4To2
  l41_07(.C(PC[8]),  .S(PS[8]),  .cout(cout41[8]),  .cin(cout41[9]),  .w(S31[8]),     .x(C31[9]),  .y(d0[7]),     .z(r6MSB));
p405s_Compressor4To2
  l41_06(.C(PC[7]),  .S(PS[7]),  .cout(cout41[7]),  .cin(cout41[8]),  .w(S31[7]),     .x(C31[8]),  .y(d0[6]),     .z(r5MSB));
p405s_Compressor4To2
  l41_05(.C(PC[6]),  .S(PS[6]),  .cout(cout41[6]),  .cin(cout41[7]),  .w(S31[6]),     .x(C31[7]),  .y(d0[5]),     .z(r4MSB));
p405s_Compressor4To2
  l41_04(.C(PC[5]),  .S(PS[5]),  .cout(cout41[5]),  .cin(cout41[6]),  .w(S31[5]),     .x(C31[6]),  .y(d0[4]),     .z(r3MSB));
p405s_Compressor4To2
  l41_03(.C(PC[4]),  .S(PS[4]),  .cout(cout41[4]),  .cin(cout41[5]),  .w(S31[4]),     .x(C31[5]),  .y(d0[3]),     .z(r2MSB));
p405s_Compressor4To2
  l41_02(.C(PC[3]),  .S(PS[3]),  .cout(cout41[3]),  .cin(cout41[4]),  .w(S31[3]),     .x(C31[4]),  .y(d0[2]),     .z(r1MSB));
p405s_Compressor4To2
  l41_01(.C(PC[2]),  .S(PS[2]),  .cout(cout41[2]),  .cin(cout41[3]),  .w(S31[2]),     .x(C31[3]),  .y(d0[1]),     .z(mdMrSgn));
p405s_Compressor4To2
  l41_00(.C(PC[1]),  .S(PS[1]),  .cout(cout41[1]),  .cin(cout41[2]),  .w(S31[1]),     .x(C31[2]),  .y(d0[0]),     .z(LSMD));
p405s_Compressor4To2
  l41_M1(.C(PC[0]),  .S(PS[0]),  .cout(cout41[0]),  .cin(cout41[1]),  .w(S31[0]),     .x(C31[1]),  .y(1'b0),      .z(1'b0));

endmodule
