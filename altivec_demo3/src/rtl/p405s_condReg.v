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

module p405s_condReg( 
     crL2, CB, EXE_cc, EXE_sprDataBus, EXE_xer,
     MMU_tlbSXHit, PCL_Rbit, PCL_exeHoldForCr, coreResetL2, exe2Cr0EnL2, exeCr0EnL2,
     exeCrAndL2, exeCrBfEnL2, exeCrNegBBL2, exeCrNegBTL2, exeCrOrL2, exeCrXorL2,
     exeDataL2, exeFlush, exeMcrfL2, exeMcrxrL2, exeMtcrfL2, exeOpForExe2L2, exeStwcxL2,
     exeTlbsxL2
);


output [0:31]  crL2;

input  MMU_tlbSXHit, PCL_Rbit, PCL_exeHoldForCr, coreResetL2, exe2Cr0EnL2, exeCr0EnL2,
     exeCrAndL2, exeCrBfEnL2, exeCrNegBBL2, exeCrNegBTL2, exeCrOrL2, exeCrXorL2, exeFlush,
     exeMcrfL2, exeMcrxrL2, exeMtcrfL2, exeOpForExe2L2, exeStwcxL2, exeTlbsxL2;

input        CB;
input [0:3]  EXE_cc;
input [0:2]  EXE_xer;
input [0:31]  EXE_sprDataBus;
input [6:20]  exeDataL2;

// Buses in the design
wire  [0:3]  EXE_cc_Neg;
wire  [0:3]  crBFA;
wire  [0:1]  crInstMuxSel;
wire  [0:3]  crInst_Neg;
wire  [0:31]  EXE_sprDataBus_Neg;
wire  [0:15]  crBABFA_0;
wire  [0:15]  crMuxSelBus;
wire  [0:31]  crRegNeg;
wire  [0:3]  crBFANeg;
wire  [0:3]  crBB_12;
wire  [0:15]  crBB_0;
wire  [0:3]  crLogMcrf;
wire  [0:31]  crFeedBack_Neg;
wire  [0:15]  crBTField_0;
wire  [0:3]  crBTField;
wire  [0:3]  crLogical;
wire  coreReset_Neg;
wire  crLog, crBBwComp, crAnd, crOr, crXor;
wire  [0:7]   selCC, selCrInst, selSprBus;
reg   [0:7]   bfSel;
wire crBB, crBA, crBTNeg, crE1, crE2;
wire [6:8] exeDataL2_lo;
wire [12:19] exeDataL2_hi;
reg [0:3] crReg7_next, crReg7;
reg [0:3] crReg6_next, crReg6;
reg [0:3] crReg5_next, crReg5;
reg [0:3] crReg4_next, crReg4;
reg [0:3] crReg3_next, crReg3;
reg [0:3] crReg2_next, crReg2;
reg [0:3] crReg1_next, crReg1;
reg [0:3] crReg0_next, crReg0;
reg [0:3] crInstr_mux;
reg [0:3] crBT_34_mux;
reg [0:3] crBT_12_mux;
reg crBB_34_mux;
reg crBA_34_mux;
reg [0:3] crBABFA_12_mux;
reg [0:3] crBB_12_mux;


wire [0:31]  crL2_int;
assign crL2 = crL2_int;

//Removed the module 'dp_logIFB_sprBusInv' 
assign EXE_sprDataBus_Neg = ~EXE_sprDataBus;

//Removed the module 'dp_logIFB_condCodeInv' 
assign EXE_cc_Neg = ~EXE_cc;

//Removed the module 'dp_logIFB_crFeedback'
assign crFeedBack_Neg = ~({32{coreReset_Neg}} & crL2_int); 

//Removed the module 'condRegEqs' 
//
// cr logical instruction
assign crLog = exeCrAndL2 | exeCrOrL2 | exeCrXorL2;
//
// cr controls as follows
// crBBwComp - invert BB input
// crAnd     - execute And function
// crOr      - execute Or function
// crXor     - execute Xor function
// crBTNeg   - invert the function output
assign crBBwComp = crBB ^ exeCrNegBBL2;
assign crAnd = crBA & crBBwComp;
assign crOr = crBA | crBBwComp;
assign crXor = crBA ^ crBBwComp;
assign crBTNeg = exeCrNegBTL2 ^~
           ((exeCrAndL2 & crAnd) | (exeCrOrL2 & crOr) | (exeCrXorL2 & crXor));

// Select for crInst mux.
// 00 - cr logical
// 01 - tlbsx
// 10 - stwcx
// 11 - mcrxr
assign crInstMuxSel[0] = exeStwcxL2 | exeMcrxrL2;
assign crInstMuxSel[1] = exeTlbsxL2 | exeMcrxrL2;

// crE1 equation
// exeCr0EnL2 contains exeStwcxL2 and exeTlbsxL2 and many others.
// exeCrBfEnL2 contains mcrxr and mcrf and many others.
// crLog contains all CR logical instructions
assign crE1 = coreResetL2 | (exeCr0EnL2 & ~exeOpForExe2L2) | exe2Cr0EnL2 |
              exeCrBfEnL2 | crLog | exeMtcrfL2;
assign crE2 = coreResetL2 | (~PCL_exeHoldForCr & ~exeFlush);

assign coreReset_Neg = ~coreResetL2;

// *******************
// Build crMuxSelBus *
// *******************

// Decode exeBT_BF field.
always @(exeDataL2_lo)
begin
   casez(exeDataL2_lo)
     3'b000: bfSel[0:7] = 8'h80;
     3'b001: bfSel[0:7] = 8'h40;
     3'b010: bfSel[0:7] = 8'h20;
     3'b011: bfSel[0:7] = 8'h10;
     3'b100: bfSel[0:7] = 8'h08;
     3'b101: bfSel[0:7] = 8'h04;
     3'b110: bfSel[0:7] = 8'h02;
     3'b111: bfSel[0:7] = 8'h01;
     default: bfSel[0:7] = 8'hxx;
   endcase
end


// cr reg input mux selection
// 00 - feedback
// 01 - spr bus
// 10 - cr instructions
// 11 - exe CC
// APU will be included in exeCrBfEnL2 and exeDataBF when loading exe registers
// exeCr0EnL2 includes stwcx and tlbsx.
// Will rely on exe stage regs being cleared by reset so that crMuxSel will
// select the reset/hold leg 16'h0000
assign exeDataL2_hi[12:19] = exeDataL2[12:19];
assign exeDataL2_lo[6:8] =  exeDataL2[6:8];
assign selSprBus[0:7] = ({8{exeMtcrfL2}} & exeDataL2_hi[12:19]);
assign selCrInst[0:7] = ({8{(exeMcrxrL2 | exeMcrfL2 | crLog)}} & bfSel[0:7]);
assign selCC[0:7] = ({8{exeCrBfEnL2 & ~(crLog | exeMcrfL2 | exeMcrxrL2)}}
                    & bfSel[0:7]);

// CR0 has additional instructions that only update cr0.
// stwcx and tlbsx are included in exeCr0EnL2 but get there cr update from
// the cr instruction leg of the mux.
// Don't need to qualify exeCr0EnL2 with exeOpForExe2L2 because E1
// blocks update.
assign crMuxSelBus[0] = selCC[0] | selCrInst[0] | exeCr0EnL2 | exe2Cr0EnL2;
assign crMuxSelBus[1] = selCC[0] | selSprBus[0] |
                        (exeCr0EnL2 & ~(exeStwcxL2 | exeTlbsxL2)) | exe2Cr0EnL2;

assign crMuxSelBus[2] = selCC[1] | selCrInst[1];
assign crMuxSelBus[3] = selCC[1] | selSprBus[1];

assign crMuxSelBus[4] = selCC[2] | selCrInst[2];
assign crMuxSelBus[5] = selCC[2] | selSprBus[2];

assign crMuxSelBus[6] = selCC[3] | selCrInst[3];
assign crMuxSelBus[7] = selCC[3] | selSprBus[3];

assign crMuxSelBus[8] = selCC[4] | selCrInst[4];
assign crMuxSelBus[9] = selCC[4] | selSprBus[4];

assign crMuxSelBus[10] = selCC[5] | selCrInst[5];
assign crMuxSelBus[11] = selCC[5] | selSprBus[5];

assign crMuxSelBus[12] = selCC[6] | selCrInst[6];
assign crMuxSelBus[13] = selCC[6] | selSprBus[6];

assign crMuxSelBus[14] = selCC[7] | selCrInst[7];
assign crMuxSelBus[15] = selCC[7] | selSprBus[7];


//Removed the module 'dp_regIFB_crReg7'
//Removed the module 'dp_regIFB_crReg6'
//Removed the module 'dp_regIFB_crReg5'
//Removed the module 'dp_regIFB_crReg4'
//Removed the module 'dp_regIFB_crReg3'
//Removed the module 'dp_regIFB_crReg2'
//Removed the module 'dp_regIFB_crReg1'
//Removed the module 'dp_regIFB_crReg0'


assign crL2_int[28:31] = ~crReg7;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg 
              or EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[14:15])
    2'b00: crReg7_next = crFeedBack_Neg[28:31];
    2'b01: crReg7_next = EXE_sprDataBus_Neg[28:31];
    2'b10: crReg7_next = crInst_Neg[0:3];
    2'b11: crReg7_next = EXE_cc_Neg[0:3];
    default: crReg7_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg7 <= crReg7;
    1'b1: crReg7 <= crReg7_next;
    default: crReg7 <= 4'bx;
  endcase

assign crL2_int[24:27] = ~crReg6;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg or 
            EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[12:13])
    2'b00: crReg6_next = crFeedBack_Neg[24:27];
    2'b01: crReg6_next = EXE_sprDataBus_Neg[24:27];
    2'b10: crReg6_next = crInst_Neg[0:3];
    2'b11: crReg6_next = EXE_cc_Neg[0:3];
    default: crReg6_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg6 <= crReg6;
    1'b1: crReg6 <= crReg6_next;
    default: crReg6 <= 4'bx;
  endcase

assign crL2_int[20:23] = ~crReg5;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg or 
            EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[10:11])
    2'b00: crReg5_next = crFeedBack_Neg[20:23];
    2'b01: crReg5_next = EXE_sprDataBus_Neg[20:23];
    2'b10: crReg5_next = crInst_Neg[0:3];
    2'b11: crReg5_next = EXE_cc_Neg[0:3];
    default: crReg5_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg5 <= crReg5;
    1'b1: crReg5 <= crReg5_next;
    default: crReg5 <= 4'bx;
  endcase

assign crL2_int[16:19] = ~crReg4;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg or 
            EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[8:9])
    2'b00: crReg4_next = crFeedBack_Neg[16:19];
    2'b01: crReg4_next = EXE_sprDataBus_Neg[16:19];
    2'b10: crReg4_next = crInst_Neg[0:3];
    2'b11: crReg4_next = EXE_cc_Neg[0:3];
    default: crReg4_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg4 <= crReg4;
    1'b1: crReg4 <= crReg4_next;
    default: crReg4 <= 4'bx;
  endcase

assign crL2_int[12:15] = ~crReg3;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or 
         crInst_Neg or EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[6:7])
    2'b00: crReg3_next = crFeedBack_Neg[12:15];
    2'b01: crReg3_next = EXE_sprDataBus_Neg[12:15];
    2'b10: crReg3_next = crInst_Neg[0:3];
    2'b11: crReg3_next = EXE_cc_Neg[0:3];
    default: crReg3_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg3 <= crReg3;
    1'b1: crReg3 <= crReg3_next;
    default: crReg3 <= 4'bx;
  endcase

assign crL2_int[8:11] = ~crReg2;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg 
             or EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[4:5])
    2'b00: crReg2_next = crFeedBack_Neg[8:11];
    2'b01: crReg2_next = EXE_sprDataBus_Neg[8:11];
    2'b10: crReg2_next = crInst_Neg[0:3];
    2'b11: crReg2_next = EXE_cc_Neg[0:3];
    default: crReg2_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg2 <= crReg2;
    1'b1: crReg2 <= crReg2_next;
    default: crReg2 <= 4'bx;
  endcase

assign crL2_int[4:7] = ~crReg1;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg or 
           EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[2:3])
    2'b00: crReg1_next = crFeedBack_Neg[4:7];
    2'b01: crReg1_next = EXE_sprDataBus_Neg[4:7];
    2'b10: crReg1_next = crInst_Neg[0:3];
    2'b11: crReg1_next = EXE_cc_Neg[0:3];
    default: crReg1_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg1 <= crReg1;
    1'b1: crReg1 <= crReg1_next;
    default: crReg1 <= 4'bx;
  endcase

assign crL2_int[0:3] = ~crReg0;
// 4-1 Mux input to register
always @(crFeedBack_Neg or EXE_sprDataBus_Neg or crInst_Neg or 
            EXE_cc_Neg or crMuxSelBus)
  casez(crMuxSelBus[0:1])
    2'b00: crReg0_next = crFeedBack_Neg[0:3];
    2'b01: crReg0_next = EXE_sprDataBus_Neg[0:3];
    2'b10: crReg0_next = crInst_Neg[0:3];
    2'b11: crReg0_next = EXE_cc_Neg[0:3];
    default: crReg0_next = 4'bx;
  endcase
// posedge FF
always @(posedge CB)
  casez(crE1 & crE2)
    1'b0: crReg0 <= crReg0;
    1'b1: crReg0 <= crReg0_next;
    default: crReg0 <= 4'bx;
  endcase

//Removed the module 'dp_logIFB_crInv' 
assign crRegNeg[0:31] = ~crL2_int[0:31];

//Removed the module 'dp_logIFB_crBFAInv'
assign crBFA[0:3] = ~crBFANeg[0:3];

//Removed the module 'dp_muxIFB_crLogMcrf' 
assign crLogMcrf[0:3] = 
      (crLogical[0:3] & {(4){~(exeMcrfL2)}} ) | (crBFA[0:3] & {(4){exeMcrfL2}});

//Removed the module 'dp_muxIFB_crInstr' 
assign crInst_Neg[0:3] = crInstr_mux[0:3];
always @(crInstMuxSel or crLogMcrf or MMU_tlbSXHit or EXE_xer or PCL_Rbit)
  case(crInstMuxSel[0:1])
    2'b00: crInstr_mux = ~crLogMcrf[0:3];
    2'b01: crInstr_mux = ~{1'b0, 1'b0, MMU_tlbSXHit, EXE_xer[0]};
    2'b10: crInstr_mux = ~{1'b0, 1'b0, PCL_Rbit, EXE_xer[0]};
    2'b11: crInstr_mux = ~{EXE_xer[0:2], 1'b0};
    default: crInstr_mux = 4'bx;
  endcase

//Removed the module 'dp_muxIFB_crBT_34' 
assign crLogical[0:3] = crBT_34_mux[0:3];
always @(crBTNeg or crBTField or exeDataL2)
  case(exeDataL2[9:10])
    2'b00: crBT_34_mux = ~{crBTNeg, crBTField[1:3]};
    2'b01: crBT_34_mux = ~{crBTField[0], crBTNeg, crBTField[2:3]};
    2'b10: crBT_34_mux = ~{crBTField[0:1], crBTNeg, crBTField[3]};
    2'b11: crBT_34_mux = ~{crBTField[0:2], crBTNeg};
    default: crBT_34_mux = 4'bx;
  endcase

//Removed the module 'dp_muxIFB_crBT_12' 
assign crBTField[0:3] = crBT_12_mux[0:3];
always @(crBTField_0 or exeDataL2)
  case(exeDataL2[7:8])
    2'b00: crBT_12_mux = ~crBTField_0[0:3];
    2'b01: crBT_12_mux = ~crBTField_0[4:7];
    2'b10: crBT_12_mux = ~crBTField_0[8:11];
    2'b11: crBT_12_mux = ~crBTField_0[12:15];
    default: crBT_12_mux = 4'bx;
  endcase

//Removed the module 'dp_muxIFB_crBT_0' 
assign crBTField_0[0:15] = 
    ~( (crRegNeg[0:15] & {(16){~(exeDataL2[6])}} ) | (crRegNeg[16:31] & {(16){exeDataL2[6]}} ) );

//Removed the module 'dp_muxIFB_crBB_34' 
assign crBB = crBB_34_mux;
always @(crBB_12 or exeDataL2)
  case(exeDataL2[19:20])
    2'b00: crBB_34_mux = ~crBB_12[0];
    2'b01: crBB_34_mux = ~crBB_12[1];
    2'b10: crBB_34_mux = ~crBB_12[2];
    2'b11: crBB_34_mux = ~crBB_12[3];
    default: crBB_34_mux = 1'bx;
  endcase

//Removed the module 'dp_muxIFB_crBA_34' 
assign crBA = crBA_34_mux;
always @(crBFANeg or exeDataL2)
  case(exeDataL2[14:15])
    2'b00: crBA_34_mux = ~crBFANeg[0];
    2'b01: crBA_34_mux = ~crBFANeg[1];
    2'b10: crBA_34_mux = ~crBFANeg[2];
    2'b11: crBA_34_mux = ~crBFANeg[3];
    default: crBA_34_mux = 1'bx;
  endcase

//Removed the module 'dp_muxIFB_crBABFA_12' 
assign crBFANeg[0:3] = crBABFA_12_mux[0:3];
always @(crBABFA_0 or exeDataL2)
  case(exeDataL2[12:13])
    2'b00: crBABFA_12_mux = ~crBABFA_0[0:3];
    2'b01: crBABFA_12_mux = ~crBABFA_0[4:7];
    2'b10: crBABFA_12_mux = ~crBABFA_0[8:11];
    2'b11: crBABFA_12_mux = ~crBABFA_0[12:15];
    default: crBABFA_12_mux = 4'bx;
  endcase

//Removed the module 'dp_muxIFB_crBABFA_0'
assign crBABFA_0[0:15] = 
    ~( (crRegNeg[0:15] & {(16){~(exeDataL2[11])}} ) | (crRegNeg[16:31] & {(16){exeDataL2[11]}} ) );

//Removed the module 'dp_muxIFB_crBB_12' 
assign crBB_12[0:3] = crBB_12_mux[0:3];
always @(crBB_0 or exeDataL2)
  case(exeDataL2[17:18])
    2'b00: crBB_12_mux = ~crBB_0[0:3];
    2'b01: crBB_12_mux = ~crBB_0[4:7];
    2'b10: crBB_12_mux = ~crBB_0[8:11];
    2'b11: crBB_12_mux = ~crBB_0[12:15];
    default: crBB_12_mux = 4'bx;
  endcase

//Removed the module 'dp_muxIFB_crBB_0'
assign crBB_0[0:15] = 
    ~((crRegNeg[0:15] & {(16){~(exeDataL2[16])}} ) | (crRegNeg[16:31] & {(16){exeDataL2[16]}}));


endmodule
