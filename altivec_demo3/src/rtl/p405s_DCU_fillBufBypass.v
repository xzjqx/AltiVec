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

module p405s_DCU_fillBufBypass( bypassMuxOut,
                                SDQ_mux,
                                bypassFillSDP_sel,
                                bypassMuxSel,
                                fillBufWord0_L2,
                                fillBufWord1_L2,
                                fillBufWord2_L2,
                                fillBufWord3_L2,
                                fillBufWord4_L2,
                                fillBufWord5_L2,
                                fillBufWord6_L2,
                                fillBufWord7_L2 
                               );

output [0:31]  bypassMuxOut;


input [0:31]  fillBufWord5_L2;
input [0:31]  fillBufWord3_L2;
input [0:2]  bypassMuxSel;
input [0:3]  bypassFillSDP_sel;
input [0:31]  SDQ_mux;
input [0:31]  fillBufWord4_L2;
input [0:31]  fillBufWord6_L2;
input [0:31]  fillBufWord7_L2;
input [0:31]  fillBufWord2_L2;
input [0:31]  fillBufWord1_L2;
input [0:31]  fillBufWord0_L2;

// Buses in the design

reg  [0:7]  fillBypassMux2Byte1;
reg  [0:7]  fillBypassMux2Byte3;
reg  [0:7]  fillBypassMux1Byte2;
reg  [0:7]  fillBypassMux1Byte0;
wire  [0:2]  bypassMuxSelBuf23;
reg  [0:7]  fillBypassMux2Byte2;
reg  [0:7]  fillBypassMux1Byte3;
reg  [0:7]  fillBypassMux2Byte0;
wire  [0:2]  bypassMuxSelBuf01;
wire  [0:31]  fillBufferBypassData;
wire  [0:2]  symNet25;
reg  [0:7]  fillBypassMux1Byte1;


// Removed the module 'dp_logDCU_muxPwr2'
assign bypassMuxSelBuf23[0:2] = ~(symNet25[0:2]);

// Removed the module 'dp_logDCU_muxPwr1'
assign bypassMuxSelBuf01[0:2] = ~(symNet25[0:2]);

// Removed the module 'dp_logDCU_muxPwr0'
assign symNet25[0:2] = ~(bypassMuxSel[0:2]);

// Removed the module 'dp_muxDCU_byPassSDQ3'
assign bypassMuxOut[24:31] = (fillBufferBypassData[24:31] & {(8){~(bypassFillSDP_sel[3])}} ) | (SDQ_mux[24:31] & {(8){bypassFillSDP_sel[3]}} );

// Removed the module 'dp_muxDCU_byPassSDQ2'
assign bypassMuxOut[16:23] = (fillBufferBypassData[16:23] & {(8){~(bypassFillSDP_sel[2])}} ) | (SDQ_mux[16:23] & {(8){bypassFillSDP_sel[2]}} );

// Removed the module 'dp_muxDCU_byPassSDQ1'
assign bypassMuxOut[8:15] = (fillBufferBypassData[8:15] & {(8){~(bypassFillSDP_sel[1])}} ) | (SDQ_mux[8:15] & {(8){bypassFillSDP_sel[1]}} );

// Removed the module 'dp_muxDCU_byPassSDQ0'
assign bypassMuxOut[0:7] = (fillBufferBypassData[0:7] & {(8){~(bypassFillSDP_sel[0])}} ) | ( SDQ_mux[0:7] & {(8){bypassFillSDP_sel[0]}} );

// Removed the module 'dp_muxDCU_fillBypassMux2Byte3'
assign fillBufferBypassData[24:31] = 
      (fillBypassMux1Byte3[0:7] & {(8){~( bypassMuxSelBuf23[0])}} ) | (fillBypassMux2Byte3[0:7] & {(8){bypassMuxSelBuf23[0]}} );

// Removed the module 'dp_muxDCU_fillBypassMux2Byte2'
assign fillBufferBypassData[16:23] = 
      (fillBypassMux1Byte2[0:7] & {(8){~(bypassMuxSelBuf23[0])}} ) | (fillBypassMux2Byte2[0:7] & {(8){bypassMuxSelBuf23[0]}} );

// Removed the module 'dp_muxDCU_fillBypassMux2Byte1'
assign fillBufferBypassData[8:15] = 
      (fillBypassMux1Byte1[0:7] & {(8){~(bypassMuxSelBuf01[0])}} ) | (fillBypassMux2Byte1[0:7] & {(8){bypassMuxSelBuf01[0]}} );

// Removed the module 'dp_muxDCU_fillBypassMux2Byte0'
assign fillBufferBypassData[0:7] = 
      (fillBypassMux1Byte0[0:7] & {(8){~(bypassMuxSelBuf01[0])}} ) | (fillBypassMux2Byte0[0:7] & {(8){bypassMuxSelBuf01[0]}} );

// Removed the module 'dp_muxDCU_fillBypassMuxByte7'
always @(fillBufWord4_L2 or fillBufWord5_L2 or fillBufWord6_L2 or fillBufWord7_L2 or bypassMuxSelBuf23)
    begin                                           
    case({bypassMuxSelBuf23[1], bypassMuxSelBuf23[2]})
     2'b00: fillBypassMux2Byte3[0:7] = fillBufWord4_L2[24:31]; 
     2'b01: fillBypassMux2Byte3[0:7] = fillBufWord5_L2[24:31];    
     2'b10: fillBypassMux2Byte3[0:7] = fillBufWord6_L2[24:31];    
     2'b11: fillBypassMux2Byte3[0:7] = fillBufWord7_L2[24:31];    
      default: fillBypassMux2Byte3[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_fillBypassMuxByte6'
always @(fillBufWord0_L2 or fillBufWord1_L2 or fillBufWord2_L2 or fillBufWord3_L2 or bypassMuxSelBuf23)
    begin                                           
    case({bypassMuxSelBuf23[1], bypassMuxSelBuf23[2]})
     2'b00: fillBypassMux1Byte3[0:7] = fillBufWord0_L2[24:31];    
     2'b01: fillBypassMux1Byte3[0:7] = fillBufWord1_L2[24:31];    
     2'b10: fillBypassMux1Byte3[0:7] = fillBufWord2_L2[24:31];    
     2'b11: fillBypassMux1Byte3[0:7] = fillBufWord3_L2[24:31];    
      default: fillBypassMux1Byte3[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_fillBypassMuxByte5'
always @(fillBufWord4_L2 or fillBufWord5_L2 or fillBufWord6_L2 or fillBufWord7_L2 or bypassMuxSelBuf23)
    begin                                           
    case({bypassMuxSelBuf23[1], bypassMuxSelBuf23[2]})
     2'b00: fillBypassMux2Byte2[0:7] = fillBufWord4_L2[16:23];    
     2'b01: fillBypassMux2Byte2[0:7] = fillBufWord5_L2[16:23];    
     2'b10: fillBypassMux2Byte2[0:7] = fillBufWord6_L2[16:23];    
     2'b11: fillBypassMux2Byte2[0:7] = fillBufWord7_L2[16:23];    
      default: fillBypassMux2Byte2[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_fillBypassMuxByte4'
always @(fillBufWord0_L2 or fillBufWord1_L2 or fillBufWord2_L2 or fillBufWord3_L2 or bypassMuxSelBuf23)
    begin                                           
    case({bypassMuxSelBuf23[1], bypassMuxSelBuf23[2]})
     2'b00: fillBypassMux1Byte2[0:7] = fillBufWord0_L2[16:23];    
     2'b01: fillBypassMux1Byte2[0:7] = fillBufWord1_L2[16:23];    
     2'b10: fillBypassMux1Byte2[0:7] = fillBufWord2_L2[16:23];    
     2'b11: fillBypassMux1Byte2[0:7] = fillBufWord3_L2[16:23];    
      default: fillBypassMux1Byte2[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_fillBypassMuxByte3'
always @(fillBufWord4_L2 or fillBufWord5_L2 or fillBufWord6_L2 or fillBufWord7_L2 or bypassMuxSelBuf01)
    begin                                           
    case({bypassMuxSelBuf01[1],bypassMuxSelBuf01[2]})
     2'b00: fillBypassMux2Byte1[0:7] = fillBufWord4_L2[8:15];    
     2'b01: fillBypassMux2Byte1[0:7] = fillBufWord5_L2[8:15];    
     2'b10: fillBypassMux2Byte1[0:7] = fillBufWord6_L2[8:15];    
     2'b11: fillBypassMux2Byte1[0:7] = fillBufWord7_L2[8:15];    
      default: fillBypassMux2Byte1[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_fillBypassMuxByte2'
always @(fillBufWord0_L2 or fillBufWord1_L2 or fillBufWord2_L2 or fillBufWord3_L2 or bypassMuxSelBuf01)
    begin                                           
    case({bypassMuxSelBuf01[1],bypassMuxSelBuf01[2]})
     2'b00: fillBypassMux1Byte1[0:7] = fillBufWord0_L2[8:15]; 
     2'b01: fillBypassMux1Byte1[0:7] = fillBufWord1_L2[8:15];    
     2'b10: fillBypassMux1Byte1[0:7] = fillBufWord2_L2[8:15];    
     2'b11: fillBypassMux1Byte1[0:7] = fillBufWord3_L2[8:15];    
      default: fillBypassMux1Byte1[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_fillBypassMuxByte1'
always @(fillBufWord4_L2 or fillBufWord5_L2 or fillBufWord6_L2 or fillBufWord7_L2 or bypassMuxSelBuf01)
    begin                                           
    case({bypassMuxSelBuf01[1],bypassMuxSelBuf01[2]})
     2'b00: fillBypassMux2Byte0[0:7] = fillBufWord4_L2[0:7]; 
     2'b01: fillBypassMux2Byte0[0:7] = fillBufWord5_L2[0:7];    
     2'b10: fillBypassMux2Byte0[0:7] = fillBufWord6_L2[0:7];    
     2'b11: fillBypassMux2Byte0[0:7] = fillBufWord7_L2[0:7];    
      default: fillBypassMux2Byte0[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_fillBypassMuxByte0'
always @(fillBufWord0_L2 or fillBufWord1_L2 or fillBufWord2_L2 or fillBufWord3_L2 or bypassMuxSelBuf01)
    begin                                           
    case({bypassMuxSelBuf01[1],bypassMuxSelBuf01[2]})
     2'b00: fillBypassMux1Byte0[0:7] = fillBufWord0_L2[0:7]; 
     2'b01: fillBypassMux1Byte0[0:7] = fillBufWord1_L2[0:7];    
     2'b10: fillBypassMux1Byte0[0:7] = fillBufWord2_L2[0:7];    
     2'b11: fillBypassMux1Byte0[0:7] = fillBufWord3_L2[0:7];    
      default: fillBypassMux1Byte0[0:7] = 8'bx;        
    endcase                                    
   end 

endmodule
