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

module p405s_ram_lruVaVb_16K( lruOut, 
                              vaOut, 
                              vbOut, 
                              CB, 
                              lruRdIndex, 
                              lruWrCycle,
                              lruWrIndex, 
                              newLruBit, 
                              newVaBit, 
                              newVbBit, 
                              vaRdIndex, 
                              vaWrCycle,
                              vaWrIndex, 
                              vbRdIndex, 
                              vbWrCycle, 
                              vbWrIndex, 
                              wrFlash 
                            );

output  lruOut;
output  vaOut;
output  vbOut;

input  lruWrCycle;
input  newLruBit;
input  newVaBit;
input  newVbBit;
input  vaWrCycle;
input  vbWrCycle;
input  wrFlash;

input        CB;
input [0:8]  vbWrIndex;
input [0:8]  vaWrIndex;
input [0:8]  lruWrIndex;
input [0:8]  lruRdIndex;
input [0:8]  vaRdIndex;
input [0:8]  vbRdIndex;

reg  lruOut;
reg  vaOut;
reg  vbOut;

// Buses in the design

reg          lru0E1;
reg          lru1E1;
reg          lru2E1;
reg          lru3E1;
reg          lru4E1;
reg          lru5E1;
reg          lru6E1;
reg          lru7E1;

reg   [0:31]  feedback1va;
wire  [0:31]  va7_L2;
reg   [0:31]  feedbackVb;
reg   [0:31]  LRU4_L2;
reg   [0:31]  LRU1_L2;
reg   [0:31]  LRU6_L2;
reg   [0:31]  feedback0;
wire  [0:31]  vb3_L2;
wire  [0:31]  vb5_L2;
reg   [0:31]  LRU5_L2;
wire  [0:31]  vb1_L2;
reg   [0:31]  LRU3_L2;
wire  [0:31]  va0_L2;
reg   [0:31]  feedback0va;
reg   [0:31]  LRU2_L2;
wire  [0:31]  va2_L2;
reg   [0:31]  LRU7_L2;
reg   [0:31]  feedback1;
wire  [0:31]  va5_L2;
reg   [0:31]  feedback1vb;
wire  [0:31]  va6_L2;
reg   [0:31]  feedback;
wire  [0:31]  va4_L2;
reg   [0:31]  newVa;
wire  [0:31]  vb6_L2;
wire  [0:31]  vb4_L2;
reg   [0:31]  lruOut1;
reg   [0:31]  newVb;
reg   [0:31]  feedbackVa;
reg   [0:31]  lruOut2;
reg   [0:31]  vaOut1;
reg   [0:31]  feedback0vb;
wire  [0:31]  vb2_L2;
wire  [0:31]  va1_L2;
reg   [0:31]  LRU0_L2;
reg   [0:31]  vaOut2;
reg   [0:31]  vbOut2;
wire  [0:31]  va3_L2;
reg   [0:7]   vaOut3;
reg   [0:31]  vbOut1;
wire  [0:31]  vb0_L2;
reg   [0:7]   vbOut3;
reg   [0:31]  newLru;
reg   [0:7]   lruOut3;
wire  [0:31]  vb7_L2;

reg  va0E1; 
reg  va1E1; 
reg  va2E1; 
reg  va3E1; 
reg  va4E1; 
reg  va5E1; 
reg  va6E1; 
reg  va7E1; 
reg  vb0E1; 
reg  vb1E1; 
reg  vb2E1; 
reg  vb3E1; 
reg  vb4E1; 
reg  vb5E1; 
reg  vb6E1; 
reg  vb7E1; 


// Removed module dp_muxICU_mux8to1Lru0

   always @(lruRdIndex or lruOut3)
    begin
    case(lruRdIndex[6:8])
     3'b000: lruOut = ~lruOut3[0];
     3'b001: lruOut = ~lruOut3[1];
     3'b010: lruOut = ~lruOut3[2];
     3'b011: lruOut = ~lruOut3[3];
     3'b100: lruOut = ~lruOut3[4];
     3'b101: lruOut = ~lruOut3[5];
     3'b110: lruOut = ~lruOut3[6];
     3'b111: lruOut = ~lruOut3[7];
      default: lruOut = 1'bx;
    endcase
   end

// Removed module dp_muxICU_mux8to1Lru1

   always @(lruRdIndex or lruRdIndex or lruOut1 or lruOut2)
    begin
    case({lruRdIndex[1], lruRdIndex[4:5]})
     3'b000: lruOut3[0:7] = ~lruOut1[0:7];
     3'b001: lruOut3[0:7] = ~lruOut1[8:15];
     3'b010: lruOut3[0:7] = ~lruOut1[16:23];
     3'b011: lruOut3[0:7] = ~lruOut1[24:31];
     3'b100: lruOut3[0:7] = ~lruOut2[0:7];
     3'b101: lruOut3[0:7] = ~lruOut2[8:15];
     3'b110: lruOut3[0:7] = ~lruOut2[16:23];
     3'b111: lruOut3[0:7] = ~lruOut2[24:31];
      default: lruOut3[0:7] = 8'bx;
    endcase
   end

// Removed module dp_muxICU_vaOut2

   always @(vaRdIndex or va4_L2 or va5_L2 or va6_L2 or va7_L2)
    begin
    case({vaRdIndex[2],vaRdIndex[3]})
     2'b00: vaOut2[0:31] = va4_L2[0:31];
     2'b01: vaOut2[0:31] = va5_L2[0:31];
     2'b10: vaOut2[0:31] = va6_L2[0:31];
     2'b11: vaOut2[0:31] = va7_L2[0:31];
      default: vaOut2[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vbOut2

   always @(vbRdIndex or vb4_L2 or vb5_L2 or vb6_L2 or vb7_L2)
    begin
    case({vbRdIndex[2],vbRdIndex[3]})
     2'b00: vbOut2[0:31] = vb4_L2[0:31];
     2'b01: vbOut2[0:31] = vb5_L2[0:31];
     2'b10: vbOut2[0:31] = vb6_L2[0:31];
     2'b11: vbOut2[0:31] = vb7_L2[0:31];
      default: vbOut2[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vbOut0

   always @(vbRdIndex or vb0_L2 or vb1_L2 or vb2_L2 or vb3_L2)
    begin
    case({vbRdIndex[2],vbRdIndex[3]})
     2'b00: vbOut1[0:31] = vb0_L2[0:31];
     2'b01: vbOut1[0:31] = vb1_L2[0:31];
     2'b10: vbOut1[0:31] = vb2_L2[0:31];
     2'b11: vbOut1[0:31] = vb3_L2[0:31];
      default: vbOut1[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vaOut0

   always @(vaRdIndex or va0_L2 or va1_L2 or va2_L2 or va3_L2)
    begin
    case({vaRdIndex[2],vaRdIndex[3]})
     2'b00: vaOut1[0:31] = va0_L2[0:31];
     2'b01: vaOut1[0:31] = va1_L2[0:31];
     2'b10: vaOut1[0:31] = va2_L2[0:31];
     2'b11: vaOut1[0:31] = va3_L2[0:31];
      default: vaOut1[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_mux8to1Vb1

   always @(vbRdIndex or vbRdIndex or vbOut1 or vbOut2)
    begin
    case({vbRdIndex[1], vbRdIndex[4:5]})
     3'b000: vbOut3[0:7] = ~vbOut1[0:7];
     3'b001: vbOut3[0:7] = ~vbOut1[8:15];
     3'b010: vbOut3[0:7] = ~vbOut1[16:23];
     3'b011: vbOut3[0:7] = ~vbOut1[24:31];
     3'b100: vbOut3[0:7] = ~vbOut2[0:7];
     3'b101: vbOut3[0:7] = ~vbOut2[8:15];
     3'b110: vbOut3[0:7] = ~vbOut2[16:23];
     3'b111: vbOut3[0:7] = ~vbOut2[24:31];
      default: vbOut3[0:7] = 8'bx;
    endcase
   end

// Removed module dp_muxICU_mux8to1Vb0

   always @(vbRdIndex or vbOut3)
    begin
    case(vbRdIndex[6:8])
     3'b000: vbOut = ~vbOut3[0];
     3'b001: vbOut = ~vbOut3[1];
     3'b010: vbOut = ~vbOut3[2];
     3'b011: vbOut = ~vbOut3[3];
     3'b100: vbOut = ~vbOut3[4];
     3'b101: vbOut = ~vbOut3[5];
     3'b110: vbOut = ~vbOut3[6];
     3'b111: vbOut = ~vbOut3[7];
      default: vbOut = 1'bx;
    endcase
   end

// Removed module dp_muxICU_mux8to1Va1

   always @(vaRdIndex or vaRdIndex or vaOut1 or vaOut2)
    begin
    case({vaRdIndex[1], vaRdIndex[4:5]})
     3'b000: vaOut3[0:7] = ~vaOut1[0:7];
     3'b001: vaOut3[0:7] = ~vaOut1[8:15];
     3'b010: vaOut3[0:7] = ~vaOut1[16:23];
     3'b011: vaOut3[0:7] = ~vaOut1[24:31];
     3'b100: vaOut3[0:7] = ~vaOut2[0:7];
     3'b101: vaOut3[0:7] = ~vaOut2[8:15];
     3'b110: vaOut3[0:7] = ~vaOut2[16:23];
     3'b111: vaOut3[0:7] = ~vaOut2[24:31];
      default: vaOut3[0:7] = 8'bx;
    endcase
   end

// Removed module dp_muxICU_mux8to1Va0

   always @(vaRdIndex or vaOut3)
    begin
    case(vaRdIndex[6:8])
     3'b000: vaOut = ~vaOut3[0];
     3'b001: vaOut = ~vaOut3[1];
     3'b010: vaOut = ~vaOut3[2];
     3'b011: vaOut = ~vaOut3[3];
     3'b100: vaOut = ~vaOut3[4];
     3'b101: vaOut = ~vaOut3[5];
     3'b110: vaOut = ~vaOut3[6];
     3'b111: vaOut = ~vaOut3[7];
      default: vaOut = 1'bx;
    endcase
   end

// Removed module dp_logicICU_aClk004

// Removed module dp_logicICU_aClk03

// Removed module dp_regICU_lru0

   always @(posedge CB)      
    begin                                       
    if (lru0E1)                    
      LRU0_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru1

   always @(posedge CB)      
    begin                                       
    if (lru1E1)                    
      LRU1_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru2

   always @(posedge CB)      
    begin                                       
    if (lru2E1)                    
      LRU2_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru3

   always @(posedge CB)      
    begin                                       
    if (lru3E1)                    
      LRU3_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru4

   always @(posedge CB)      
    begin                                       
    if (lru4E1)                    
      LRU4_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru5

   always @(posedge CB)      
    begin                                       
    if (lru5E1)                    
      LRU5_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru6

   always @(posedge CB)      
    begin                                       
    if (lru6E1)                    
      LRU6_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_regICU_lru7

   always @(posedge CB)      
    begin                                       
    if (lru7E1)                    
      LRU7_L2[0:31] <= newLru[0:31];            
   end                                  

// Removed module dp_muxICU_lruFeedback0

   always @(lruWrIndex or LRU0_L2 or LRU1_L2 or LRU2_L2 or LRU3_L2)
    begin
    case(lruWrIndex[2:3])
     2'b00: feedback0[0:31] = ~LRU0_L2[0:31];
     2'b01: feedback0[0:31] = ~LRU1_L2[0:31];
     2'b10: feedback0[0:31] = ~LRU2_L2[0:31];
     2'b11: feedback0[0:31] = ~LRU3_L2[0:31];
      default: feedback0[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_lruFeedback1

   always @(lruWrIndex or LRU4_L2 or LRU5_L2 or LRU6_L2 or LRU7_L2)
    begin
    case(lruWrIndex[2:3])
     2'b00: feedback1[0:31] = ~LRU4_L2[0:31];
     2'b01: feedback1[0:31] = ~LRU5_L2[0:31];
     2'b10: feedback1[0:31] = ~LRU6_L2[0:31];
     2'b11: feedback1[0:31] = ~LRU7_L2[0:31];
      default: feedback1[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_lruFeedback2

   always @(lruWrIndex or feedback0 or feedback1)
    begin
    case(lruWrIndex[1])
     1'b0: feedback[0:31] = ~feedback0[0:31];
     1'b1: feedback[0:31] = ~feedback1[0:31];
      default: feedback[0:31] = 32'bx;
    endcase
   end

// Removed module muxICU_lruOut0

   always @(lruRdIndex or LRU0_L2 or LRU1_L2 or LRU2_L2 or LRU3_L2)
    begin
    case(lruRdIndex[2:3])
     2'b00: lruOut1[0:31] = LRU0_L2[0:31];
     2'b01: lruOut1[0:31] = LRU1_L2[0:31];
     2'b10: lruOut1[0:31] = LRU2_L2[0:31];
     2'b11: lruOut1[0:31] = LRU3_L2[0:31];
      default: lruOut1[0:31] = 32'bx;
    endcase
   end

// Removed module muxICU_lruOut1

   always @(lruRdIndex or LRU4_L2 or LRU5_L2 or LRU6_L2 or LRU7_L2)
    begin
    case(lruRdIndex[2:3])
     2'b00: lruOut2[0:31] = LRU4_L2[0:31];
     2'b01: lruOut2[0:31] = LRU5_L2[0:31];
     2'b10: lruOut2[0:31] = LRU6_L2[0:31];
     2'b11: lruOut2[0:31] = LRU7_L2[0:31];
      default: lruOut2[0:31] = 32'bx;
    endcase
   end

// Removed module "icu_lruG2Gen"

always @ (wrFlash or lruWrIndex or lruWrCycle)
 begin
   casez ({wrFlash, lruWrCycle, lruWrIndex[1:3]}) //synopsys parallel_case

  5'b1????: begin
            lru0E1 = 1'b1; 
            lru1E1 = 1'b1; 
            lru2E1 = 1'b1; 
            lru3E1 = 1'b1; 
            lru4E1 = 1'b1; 
            lru5E1 = 1'b1; 
            lru6E1 = 1'b1; 
            lru7E1 = 1'b1; 
           end
  5'b00???: begin
            lru0E1 = 1'b0; 
            lru1E1 = 1'b0; 
            lru2E1 = 1'b0; 
            lru3E1 = 1'b0; 
            lru4E1 = 1'b0; 
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01000: begin
            lru0E1 = 1'b1;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01001: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b1;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end

  5'b01010: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b1;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01011: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b1;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01100: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b1;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01101: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b1;
            lru6E1 = 1'b0;
            lru7E1 = 1'b0;
           end
  5'b01110: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b1;
            lru7E1 = 1'b0;
           end
  5'b01111: begin
            lru0E1 = 1'b0;
            lru1E1 = 1'b0;
            lru2E1 = 1'b0;
            lru3E1 = 1'b0;
            lru4E1 = 1'b0;
            lru5E1 = 1'b0;
            lru6E1 = 1'b0;
            lru7E1 = 1'b1;
           end
  default: begin
            lru0E1 = 1'bx;
            lru1E1 = 1'bx;
            lru2E1 = 1'bx;
            lru3E1 = 1'bx;
            lru4E1 = 1'bx;
            lru5E1 = 1'bx;
            lru6E1 = 1'bx;
            lru7E1 = 1'bx;
           end
   endcase
 end

// Removed the module "icu_newLruGen"

always @ (wrFlash or newLruBit or lruWrIndex or feedback)
 begin
   casez({wrFlash, lruWrIndex[4:8]}) //synopsys parallel_case 

  6'b1?????: newLru[0:31] = 32'b00000000000000000000000000000000; 
  6'b000000: newLru[0:31] = {newLruBit, feedback[1:31]} ;
  6'b000001: newLru[0:31] = {feedback[0], newLruBit, feedback[2:31]} ;
  6'b000010: newLru[0:31] = {feedback[0:1], newLruBit, feedback[3:31]} ;
  6'b000011: newLru[0:31] = {feedback[0:2], newLruBit, feedback[4:31]} ;
  6'b000100: newLru[0:31] = {feedback[0:3], newLruBit, feedback[5:31]} ;
  6'b000101: newLru[0:31] = {feedback[0:4], newLruBit, feedback[6:31]} ;
  6'b000110: newLru[0:31] = {feedback[0:5], newLruBit, feedback[7:31]} ;
  6'b000111: newLru[0:31] = {feedback[0:6], newLruBit, feedback[8:31]} ;
  6'b001000: newLru[0:31] = {feedback[0:7], newLruBit, feedback[9:31]} ;
  6'b001001: newLru[0:31] = {feedback[0:8], newLruBit, feedback[10:31]} ;
  6'b001010: newLru[0:31] = {feedback[0:9], newLruBit, feedback[11:31]} ;
  6'b001011: newLru[0:31] = {feedback[0:10], newLruBit, feedback[12:31]} ;
  6'b001100: newLru[0:31] = {feedback[0:11], newLruBit, feedback[13:31]} ;
  6'b001101: newLru[0:31] = {feedback[0:12], newLruBit, feedback[14:31]} ;
  6'b001110: newLru[0:31] = {feedback[0:13], newLruBit, feedback[15:31]} ;
  6'b001111: newLru[0:31] = {feedback[0:14], newLruBit, feedback[16:31]} ;
  6'b010000: newLru[0:31] = {feedback[0:15], newLruBit, feedback[17:31]} ;
  6'b010001: newLru[0:31] = {feedback[0:16], newLruBit, feedback[18:31]} ;
  6'b010010: newLru[0:31] = {feedback[0:17], newLruBit, feedback[19:31]} ;
  6'b010011: newLru[0:31] = {feedback[0:18], newLruBit, feedback[20:31]} ;
  6'b010100: newLru[0:31] = {feedback[0:19], newLruBit, feedback[21:31]} ;
  6'b010101: newLru[0:31] = {feedback[0:20], newLruBit, feedback[22:31]} ;
  6'b010110: newLru[0:31] = {feedback[0:21], newLruBit, feedback[23:31]} ;
  6'b010111: newLru[0:31] = {feedback[0:22], newLruBit, feedback[24:31]} ;
  6'b011000: newLru[0:31] = {feedback[0:23], newLruBit, feedback[25:31]} ;
  6'b011001: newLru[0:31] = {feedback[0:24], newLruBit, feedback[26:31]} ;
  6'b011010: newLru[0:31] = {feedback[0:25], newLruBit, feedback[27:31]} ;
  6'b011011: newLru[0:31] = {feedback[0:26], newLruBit, feedback[28:31]} ;
  6'b011100: newLru[0:31] = {feedback[0:27], newLruBit, feedback[29:31]} ;
  6'b011101: newLru[0:31] = {feedback[0:28], newLruBit, feedback[30:31]} ;
  6'b011110: newLru[0:31] = {feedback[0:29], newLruBit, feedback[31]} ;
  6'b011111: newLru[0:31] = {feedback[0:30], newLruBit} ;
 
  default: newLru[0:31] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
   endcase
 end

// Removed the module "icu_newVaGen"

always @ (wrFlash or newVaBit or vaWrIndex or feedbackVa)
 begin
   casez({wrFlash,vaWrIndex[4:8]}) //synopsys parallel_case 

  6'b1?????: newVa[0:31] = 32'b00000000000000000000000000000000 ;
  6'b000000: newVa[0:31] = {newVaBit, feedbackVa[1:31]} ;
  6'b000001: newVa[0:31] = {feedbackVa[0], newVaBit, feedbackVa[2:31]} ;
  6'b000010: newVa[0:31] = {feedbackVa[0:1], newVaBit, feedbackVa[3:31]} ;
  6'b000011: newVa[0:31] = {feedbackVa[0:2], newVaBit, feedbackVa[4:31]} ;
  6'b000100: newVa[0:31] = {feedbackVa[0:3], newVaBit, feedbackVa[5:31]} ;
  6'b000101: newVa[0:31] = {feedbackVa[0:4], newVaBit, feedbackVa[6:31]} ;
  6'b000110: newVa[0:31] = {feedbackVa[0:5], newVaBit, feedbackVa[7:31]} ;
  6'b000111: newVa[0:31] = {feedbackVa[0:6], newVaBit, feedbackVa[8:31]} ;
  6'b001000: newVa[0:31] = {feedbackVa[0:7], newVaBit, feedbackVa[9:31]} ;
  6'b001001: newVa[0:31] = {feedbackVa[0:8], newVaBit, feedbackVa[10:31]} ;
  6'b001010: newVa[0:31] = {feedbackVa[0:9], newVaBit, feedbackVa[11:31]} ;
  6'b001011: newVa[0:31] = {feedbackVa[0:10], newVaBit, feedbackVa[12:31]} ;
  6'b001100: newVa[0:31] = {feedbackVa[0:11], newVaBit, feedbackVa[13:31]} ;
  6'b001101: newVa[0:31] = {feedbackVa[0:12], newVaBit, feedbackVa[14:31]} ;
  6'b001110: newVa[0:31] = {feedbackVa[0:13], newVaBit, feedbackVa[15:31]} ;
  6'b001111: newVa[0:31] = {feedbackVa[0:14], newVaBit, feedbackVa[16:31]} ;
  6'b010000: newVa[0:31] = {feedbackVa[0:15], newVaBit, feedbackVa[17:31]} ;
  6'b010001: newVa[0:31] = {feedbackVa[0:16], newVaBit, feedbackVa[18:31]} ;
  6'b010010: newVa[0:31] = {feedbackVa[0:17], newVaBit, feedbackVa[19:31]} ;
  6'b010011: newVa[0:31] = {feedbackVa[0:18], newVaBit, feedbackVa[20:31]} ;
  6'b010100: newVa[0:31] = {feedbackVa[0:19], newVaBit, feedbackVa[21:31]} ;
  6'b010101: newVa[0:31] = {feedbackVa[0:20], newVaBit, feedbackVa[22:31]} ;
  6'b010110: newVa[0:31] = {feedbackVa[0:21], newVaBit, feedbackVa[23:31]} ;
  6'b010111: newVa[0:31] = {feedbackVa[0:22], newVaBit, feedbackVa[24:31]} ;
  6'b011000: newVa[0:31] = {feedbackVa[0:23], newVaBit, feedbackVa[25:31]} ;
  6'b011001: newVa[0:31] = {feedbackVa[0:24], newVaBit, feedbackVa[26:31]} ;
  6'b011010: newVa[0:31] = {feedbackVa[0:25], newVaBit, feedbackVa[27:31]} ;
  6'b011011: newVa[0:31] = {feedbackVa[0:26], newVaBit, feedbackVa[28:31]} ;
  6'b011100: newVa[0:31] = {feedbackVa[0:27], newVaBit, feedbackVa[29:31]} ;
  6'b011101: newVa[0:31] = {feedbackVa[0:28], newVaBit, feedbackVa[30:31]} ;
  6'b011110: newVa[0:31] = {feedbackVa[0:29], newVaBit, feedbackVa[31]} ;
  6'b011111: newVa[0:31] = {feedbackVa[0:30], newVaBit} ;
 
  default: newVa[0:31] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
   endcase
 end


// Removed the module "icu_newVaGen"

always @ (wrFlash or vaWrIndex or vaWrCycle)
 begin
   casez ({wrFlash, vaWrCycle, vaWrIndex[1:3]}) //synopsys parallel_case

  5'b1????: begin
            va0E1 = 1'b1; 
            va1E1 = 1'b1; 
            va2E1 = 1'b1; 
            va3E1 = 1'b1; 
            va4E1 = 1'b1; 
            va5E1 = 1'b1; 
            va6E1 = 1'b1; 
            va7E1 = 1'b1; 
           end
  5'b00???: begin
            va0E1 = 1'b0; 
            va1E1 = 1'b0; 
            va2E1 = 1'b0; 
            va3E1 = 1'b0; 
            va4E1 = 1'b0; 
            va5E1 = 1'b0; 
            va6E1 = 1'b0; 
            va7E1 = 1'b0;
           end
  5'b01000: begin
            va0E1 = 1'b1;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01001: begin
            va0E1 = 1'b0;
            va1E1 = 1'b1;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01010: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b1;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01011: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b1;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01100: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b1;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01101: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b1;
            va6E1 = 1'b0;
            va7E1 = 1'b0;
           end
  5'b01110: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b1;
            va7E1 = 1'b0;
           end
  5'b01111: begin
            va0E1 = 1'b0;
            va1E1 = 1'b0;
            va2E1 = 1'b0;
            va3E1 = 1'b0;
            va4E1 = 1'b0;
            va5E1 = 1'b0;
            va6E1 = 1'b0;
            va7E1 = 1'b1;
           end
  default: begin
            va0E1 = 1'bx;
            va1E1 = 1'bx;
            va2E1 = 1'bx;
            va3E1 = 1'bx;
            va4E1 = 1'bx;
            va5E1 = 1'bx;
            va6E1 = 1'bx;
            va7E1 = 1'bx;
           end
   endcase
 end

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va0
 regICU_va0 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va0E1),
                      .L2   (va0_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va1
 regICU_va1 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va1E1),
                      .L2   (va1_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va2
 regICU_va2 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va2E1),
                      .L2   (va2_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va3
 regICU_va3 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va3E1),
                      .L2   (va3_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va4
 regICU_va4 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va4E1),
                      .L2   (va4_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va5
 regICU_va5 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va5E1),
                      .L2   (va5_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va6
 regICU_va6 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va6E1),
                      .L2   (va6_L2[0:31])
                      );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_va7
 regICU_va7 (
                      .CB   (CB),
                      .D    (newVa[0:31]),
                      .E1   (va7E1),
                      .L2   (va7_L2[0:31])
                      );

// Removed the module "icu_vbG2Gen"

always @ (wrFlash or vbWrIndex or vbWrCycle)
 begin
   casez ({wrFlash, vbWrCycle, vbWrIndex[1:3]}) //synopsys parallel_case

  5'b1????: begin
            vb0E1 = 1'b1;
            vb1E1 = 1'b1;
            vb2E1 = 1'b1;
            vb3E1 = 1'b1;
            vb4E1 = 1'b1;
            vb5E1 = 1'b1;
            vb6E1 = 1'b1;
            vb7E1 = 1'b1;
           end
  5'b00???: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01000: begin
            vb0E1 = 1'b1;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01001:begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b1;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01010: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b1;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01011: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b1;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01100: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b1;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01101: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b1;
            vb6E1 = 1'b0;
            vb7E1 = 1'b0;
           end
  5'b01110: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b1;
            vb7E1 = 1'b0;
           end
  5'b01111: begin
            vb0E1 = 1'b0;
            vb1E1 = 1'b0;
            vb2E1 = 1'b0;
            vb3E1 = 1'b0;
            vb4E1 = 1'b0;
            vb5E1 = 1'b0;
            vb6E1 = 1'b0;
            vb7E1 = 1'b1;
           end
  default: begin
            vb0E1 = 1'bx;
            vb1E1 = 1'bx;
            vb2E1 = 1'bx;
            vb3E1 = 1'bx;
            vb4E1 = 1'bx;
            vb5E1 = 1'bx;
            vb6E1 = 1'bx;
            vb7E1 = 1'bx;
           end
   endcase
 end

// Removed the module "icu_newVbGen"

always @ (wrFlash or newVbBit or vbWrIndex or feedbackVb)
 begin
   casez({wrFlash, vbWrIndex[4:8]}) //synopsys parallel_case 

  6'b1?????: newVb[0:31] = 32'b00000000000000000000000000000000 ;
  6'b000000: newVb[0:31] = {newVbBit, feedbackVb[1:31]} ;
  6'b000001: newVb[0:31] = {feedbackVb[0], newVbBit, feedbackVb[2:31]} ;
  6'b000010: newVb[0:31] = {feedbackVb[0:1], newVbBit, feedbackVb[3:31]} ;
  6'b000011: newVb[0:31] = {feedbackVb[0:2], newVbBit, feedbackVb[4:31]} ;
  6'b000100: newVb[0:31] = {feedbackVb[0:3], newVbBit, feedbackVb[5:31]} ;
  6'b000101: newVb[0:31] = {feedbackVb[0:4], newVbBit, feedbackVb[6:31]} ;
  6'b000110: newVb[0:31] = {feedbackVb[0:5], newVbBit, feedbackVb[7:31]} ;
  6'b000111: newVb[0:31] = {feedbackVb[0:6], newVbBit, feedbackVb[8:31]} ;
  6'b001000: newVb[0:31] = {feedbackVb[0:7], newVbBit, feedbackVb[9:31]} ;
  6'b001001: newVb[0:31] = {feedbackVb[0:8], newVbBit, feedbackVb[10:31]} ;
  6'b001010: newVb[0:31] = {feedbackVb[0:9], newVbBit, feedbackVb[11:31]} ;
  6'b001011: newVb[0:31] = {feedbackVb[0:10], newVbBit, feedbackVb[12:31]} ;
  6'b001100: newVb[0:31] = {feedbackVb[0:11], newVbBit, feedbackVb[13:31]} ;
  6'b001101: newVb[0:31] = {feedbackVb[0:12], newVbBit, feedbackVb[14:31]} ;
  6'b001110: newVb[0:31] = {feedbackVb[0:13], newVbBit, feedbackVb[15:31]} ;
  6'b001111: newVb[0:31] = {feedbackVb[0:14], newVbBit, feedbackVb[16:31]} ;
  6'b010000: newVb[0:31] = {feedbackVb[0:15], newVbBit, feedbackVb[17:31]} ;
  6'b010001: newVb[0:31] = {feedbackVb[0:16], newVbBit, feedbackVb[18:31]} ;
  6'b010010: newVb[0:31] = {feedbackVb[0:17], newVbBit, feedbackVb[19:31]} ;
  6'b010011: newVb[0:31] = {feedbackVb[0:18], newVbBit, feedbackVb[20:31]} ;
  6'b010100: newVb[0:31] = {feedbackVb[0:19], newVbBit, feedbackVb[21:31]} ;
  6'b010101: newVb[0:31] = {feedbackVb[0:20], newVbBit, feedbackVb[22:31]} ;
  6'b010110: newVb[0:31] = {feedbackVb[0:21], newVbBit, feedbackVb[23:31]} ;
  6'b010111: newVb[0:31] = {feedbackVb[0:22], newVbBit, feedbackVb[24:31]} ;
  6'b011000: newVb[0:31] = {feedbackVb[0:23], newVbBit, feedbackVb[25:31]} ;
  6'b011001: newVb[0:31] = {feedbackVb[0:24], newVbBit, feedbackVb[26:31]} ;
  6'b011010: newVb[0:31] = {feedbackVb[0:25], newVbBit, feedbackVb[27:31]} ;
  6'b011011: newVb[0:31] = {feedbackVb[0:26], newVbBit, feedbackVb[28:31]} ;
  6'b011100: newVb[0:31] = {feedbackVb[0:27], newVbBit, feedbackVb[29:31]} ;
  6'b011101: newVb[0:31] = {feedbackVb[0:28], newVbBit, feedbackVb[30:31]} ;
  6'b011110: newVb[0:31] = {feedbackVb[0:29], newVbBit, feedbackVb[31]} ;
  6'b011111: newVb[0:31] = {feedbackVb[0:30], newVbBit} ;
 
  default: newVb[0:31] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
   endcase
 end


// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb0
 regICU_vb0(
                                  .CB   (CB),
                                  .D    (newVb[0:31]),
                                  .E1   (vb0E1),
                                  .L2   (vb0_L2[0:31])
                                  );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb1
 regICU_vb1(
                                  .CB   (CB),
                                  .D    (newVb[0:31]), 
                                  .E1   (vb1E1),
                                  .L2   (vb1_L2[0:31])
                                   );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb2
 regICU_vb2(
                                  .CB   (CB),
                                  .D    (newVb[0:31]),
                                  .E1   (vb2E1),
                                  .L2   (vb2_L2[0:31])
                                   );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb3
 regICU_vb3(
                                  .CB   (CB),
                                  .D    (newVb[0:31]),
                                  .E1   (vb3E1),
                                  .L2   (vb3_L2[0:31])
                                  );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb4
 regICU_vb4(
                                  .CB  (CB),
                                  .D   (newVb[0:31]),
                                  .E1  (vb4E1),
                                  .L2  (vb4_L2[0:31])
                                  );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb5
 regICU_vb5(
                                  .CB  (CB),
                                  .D   (newVb[0:31]),
                                  .E1  (vb5E1),
                                  .L2  (vb5_L2[0:31])
                                  );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb6
 regICU_vb6(
                                  .CB  (CB),
                                  .D   (newVb[0:31]),
                                  .E1  (vb6E1),
                                  .L2  (vb6_L2[0:31])
                                  );

// Keep these registers in hierarchy
p405s_icu_dp_regICU_vb7
 regICU_vb7(
                                  .CB  (CB),
                                  .D   (newVb[0:31]),
                                  .E1  (vb7E1),
                                  .L2  (vb7_L2[0:31])
                                   );

// Removed module dp_muxICU_vaFeedback0

   always @(vaWrIndex or va0_L2 or va1_L2 or va2_L2 or va3_L2)
    begin
    case(vaWrIndex[2:3])
     2'b00: feedback0va[0:31] = ~va0_L2[0:31];
     2'b01: feedback0va[0:31] = ~va1_L2[0:31];
     2'b10: feedback0va[0:31] = ~va2_L2[0:31];
     2'b11: feedback0va[0:31] = ~va3_L2[0:31];
      default: feedback0va[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vaFeedback2

   always @(vaWrIndex or feedback0va or feedback1va)
    begin
    case(vaWrIndex[1])
     1'b0: feedbackVa[0:31] = ~feedback0va[0:31];
     1'b1: feedbackVa[0:31] = ~feedback1va[0:31];
      default: feedbackVa[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vaFeedback1

   always @(vaWrIndex or va4_L2 or va5_L2 or va6_L2 or va7_L2)
    begin
    case(vaWrIndex[2:3])
     2'b00: feedback1va[0:31] = ~va4_L2[0:31];
     2'b01: feedback1va[0:31] = ~va5_L2[0:31];
     2'b10: feedback1va[0:31] = ~va6_L2[0:31];
     2'b11: feedback1va[0:31] = ~va7_L2[0:31];
      default: feedback1va[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vbFeedback0

   always @(vbWrIndex or vb0_L2 or vb1_L2 or vb2_L2 or vb3_L2)
    begin
    case(vbWrIndex[2:3])
     2'b00: feedback0vb[0:31] = ~vb0_L2[0:31];
     2'b01: feedback0vb[0:31] = ~vb1_L2[0:31];
     2'b10: feedback0vb[0:31] = ~vb2_L2[0:31];
     2'b11: feedback0vb[0:31] = ~vb3_L2[0:31];
      default: feedback0vb[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vbFeedback2

   always @(vbWrIndex or feedback0vb or feedback1vb)
    begin
    case(vbWrIndex[1])
     1'b0: feedbackVb[0:31] = ~feedback0vb[0:31];
     1'b1: feedbackVb[0:31] = ~feedback1vb[0:31];
      default: feedbackVb[0:31] = 32'bx;
    endcase
   end

// Removed module dp_muxICU_vbFeedback1

   always @(vbWrIndex or vb4_L2 or vb5_L2 or vb6_L2 or vb7_L2)
    begin
    case(vbWrIndex[2:3])
     2'b00: feedback1vb[0:31] = ~vb4_L2[0:31];
     2'b01: feedback1vb[0:31] = ~vb5_L2[0:31];
     2'b10: feedback1vb[0:31] = ~vb6_L2[0:31];
     2'b11: feedback1vb[0:31] = ~vb7_L2[0:31];
      default: feedback1vb[0:31] = 32'bx;
    endcase
   end

endmodule
