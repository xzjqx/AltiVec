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

module p405s_icu_newVbGen(newVb, vbWrIndex, newVbBit, feedbackVb, wrFlash) ;

output[0:31]     newVb ;

input            newVbBit;
input            wrFlash ;
input[4:8]       vbWrIndex ;
input[0:31]      feedbackVb ;

reg[0:31]     newVb ;

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
endmodule
