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

module p405s_DCU_flushReg( FDR_L2mux,
                           CB,
                           FDR_hiMuxSel,
                           FDR_hi_E1,
                           FDR_hi_E2,
                           FDR_holdMuxSel,
                           FDR_loMuxSel,
                           FDR_lo_E1,
                           FDR_lo_E2,
                           FDR_outMuxSel,
                           dataOutPos_A,
                           p_aSideErrorRaw,
                           hit_a,
                           dataOutPos_B,
                           p_bSideErrorRaw,
                           hit_b,
                           flushIdle_state,
                           flushAlmostDone,
                           flushDone,
                           fillFlushToDoL2,
                           oneFPL2,
                           resetCore,
                           holdDataRegWord0_L2,
                           holdDataRegWord1_L2,
                           holdDataRegWord2_L2,
                           holdDataRegWord3_L2,
                           p_holdDataReg_L2,
                           tagParityError,
                           DCU_FlushParityError
                          );

input  FDR_hiMuxSel;
input  FDR_hi_E2;
input  FDR_loMuxSel;
input  FDR_lo_E2;

//--------- start ---------------
// rgoldiez - added p_aSideErrorRaw and p_bSideErrorRaw, one of which will get selected if
//             a flush is occuring
//            added flushIdle_state and resetCore for signalling parity errors for flush/castouts
//            added DCU_FlushParityError which is signalled when a castout error occurs
//            added tagParityError for tag errors on castout lines
//            added hit_a and hit_b since hit is necessary for a dcbf/dcbst to occur
//            added p_holdDataReg_L2 for holdDR parity errors
//            bringing the flushAlmostDone for holdDR -> FDR parity error movement
input  p_aSideErrorRaw;
input  p_bSideErrorRaw;
input  flushIdle_state;
input  flushAlmostDone;
input  flushDone;
input  fillFlushToDoL2;
input  oneFPL2;
input  resetCore;
input  tagParityError;
input  hit_a; 
input  hit_b;
input  p_holdDataReg_L2;
output DCU_FlushParityError;
//--------- end -----------------

output [0:63]  FDR_L2mux;

input [0:31]  holdDataRegWord0_L2;
input [0:31]  holdDataRegWord2_L2;
input [0:1]  FDR_outMuxSel;
input [0:127]  dataOutPos_B;
input [0:3]  FDR_hi_E1;
input [0:3]  FDR_lo_E1;
input [0:31]  holdDataRegWord1_L2;
input [0:3]  FDR_holdMuxSel;
input [0:127]  dataOutPos_A;
input [0:31]  holdDataRegWord3_L2;
input CB;

// Buses in the design

reg  [0:7]  FDR_word0Byte0_In;
reg  [0:7]  FDR_word0Byte1_In;
reg  [0:7]  FDR_word0Byte2_In;
reg  [0:7]  FDR_word0Byte3_In;
reg  [0:7]  FDR_word1Byte0_In;
reg  [0:7]  FDR_word2Byte3_In;
reg  [0:7]  FDR_word2Byte2_In;
reg  [0:7]  FDR_word2Byte1_In;
reg  [0:7]  FDR_word2Byte0_In;
wire  [0:5]  controlByte23;
wire  [0:5]  controlByte01;
reg  [0:7]  FDR_word1Byte1_In;
reg  [0:7]  FDR_word1Byte2_In;
reg  [0:7]  FDR_word1Byte3_In;
reg  [0:7]  FDR_word3Byte2_In;
reg  [0:7]  FDR_word3Byte1_In;
reg  [0:7]  FDR_word3Byte0_In;
reg  [0:31]  FDR_word5_L2;
reg  [0:7]  FDR_word3Byte3_In;
reg  [0:31]  FDR_word1_L2;
reg  [0:31]  FDR_word0_L2;
reg  [0:31]  FDR_word3_L2;
reg  [0:31]  FDR_word6_L2;
reg  [0:31]  FDR_word2_L2;
reg  [0:31]  FDR_word7_L2;
reg  [0:31]  FDR_word4_L2;
wire  [0:1]  FDR_outMuxSelByte23;
wire  [0:1]  FDR_outMuxSelByte01;
// wires from instantiation
wire FDR_hi_byte01_E2;
wire p_parityFDRhiE2;
wire flushAlmostDoneBlip_N;
wire FDR_hiMuxSelByte01;
wire p_FDRhi_L2;
wire FDR_lo_byte01_E2;
wire p_parityFDRloE2;
wire FDR_loMuxSelByte01;
wire p_FDRlo_L2;

wire FDR_loMuxSelByte23, FDR_hiMuxSelByte23, FDR_lo_byte23_E2;
wire FDR_hi_byte23_E2;

reg [24:31] regDCU_FDRword7Byte3_muxout;
reg [16:23] regDCU_FDRword7Byte2_muxout;
reg [8:15] regDCU_FDRword7Byte1_muxout;
reg [0:7] regDCU_FDRword7Byte0_muxout;
reg [24:31] regDCU_FDRword6Byte3_muxout;
reg [16:23] regDCU_FDRword6Byte2_muxout;
reg [8:15] regDCU_FDRword6Byte1_muxout;
reg [0:7] regDCU_FDRword6Byte0_muxout;
reg [24:31] regDCU_FDRword5Byte3_muxout;
reg [16:23] regDCU_FDRword5Byte2_muxout;
reg [8:15] regDCU_FDRword5Byte1_muxout;
reg [0:7] regDCU_FDRword5Byte0_muxout;
reg [24:31] regDCU_FDRword4Byte3_muxout;

reg [0:63]  FDR_L2mux;

// Removed the module 'dp_logDCU_FDR_inv4'
assign {FDR_loMuxSelByte23, FDR_hiMuxSelByte23,
     FDR_lo_byte23_E2, FDR_hi_byte23_E2, FDR_outMuxSelByte23[0:1]} = ~(controlByte23[0:5]);

// Removed the module 'dp_logDCU_FDR_inv3'
assign {FDR_loMuxSelByte01, FDR_hiMuxSelByte01,
     FDR_lo_byte01_E2, FDR_hi_byte01_E2, FDR_outMuxSelByte01[0:1]} = ~(controlByte01[0:5]);

// Removed the module 'dp_logDCU_FDR_inv2'
assign controlByte23[0:5] = ~({FDR_loMuxSel, FDR_hiMuxSel, FDR_lo_E2, FDR_hi_E2,FDR_outMuxSel[0:1]});

// Removed the module 'dp_logDCU_FDR_inv1'
assign controlByte01[0:5] = ~({FDR_loMuxSel, FDR_hiMuxSel, FDR_lo_E2, FDR_hi_E2,FDR_outMuxSel[0:1]});

// Removed the module 'dp_muxDCU_FDRbyte0_out2'
always @(FDR_word3_L2 or FDR_word5_L2 or FDR_word7_L2 or FDR_word1_L2 or FDR_outMuxSelByte01)
    begin                                           
    case({FDR_outMuxSelByte01[0], FDR_outMuxSelByte01[1]})
     2'b00: FDR_L2mux[32:39] = FDR_word3_L2[0:7];    
     2'b01: FDR_L2mux[32:39] = FDR_word5_L2[0:7];    
     2'b10: FDR_L2mux[32:39] = FDR_word7_L2[0:7];    
     2'b11: FDR_L2mux[32:39] = FDR_word1_L2[0:7];    
      default: FDR_L2mux[32:39] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRbyte1_out2'
always @(FDR_word3_L2 or FDR_word5_L2 or FDR_word7_L2 or FDR_word1_L2 or FDR_outMuxSelByte01)
    begin                                           
    case({FDR_outMuxSelByte01[0], FDR_outMuxSelByte01[1]})
     2'b00: FDR_L2mux[40:47] = FDR_word3_L2[8:15]; 
     2'b01: FDR_L2mux[40:47] = FDR_word5_L2[8:15];    
     2'b10: FDR_L2mux[40:47] = FDR_word7_L2[8:15];    
     2'b11: FDR_L2mux[40:47] = FDR_word1_L2[8:15];    
      default: FDR_L2mux[40:47] = 8'bx;        
    endcase                                    
   end                                         

// Removed the module 'dp_muxDCU_FDRbyte2_out2'
always @(FDR_word3_L2 or FDR_word5_L2 or FDR_word7_L2 or FDR_word1_L2 or FDR_outMuxSelByte23)
    begin                                           
    case({FDR_outMuxSelByte23[0], FDR_outMuxSelByte23[1]})
     2'b00: FDR_L2mux[48:55] = FDR_word3_L2[16:23];    
     2'b01: FDR_L2mux[48:55] = FDR_word5_L2[16:23];    
     2'b10: FDR_L2mux[48:55] = FDR_word7_L2[16:23];    
     2'b11: FDR_L2mux[48:55] = FDR_word1_L2[16:23];    
      default: FDR_L2mux[48:55] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRbyte3_out2'
always @(FDR_word3_L2 or FDR_word5_L2 or FDR_word7_L2 or FDR_word1_L2 or FDR_outMuxSelByte23)
    begin                                           
    case({FDR_outMuxSelByte23[0], FDR_outMuxSelByte23[1]})
     2'b00: FDR_L2mux[56:63] = FDR_word3_L2[24:31];    
     2'b01: FDR_L2mux[56:63] = FDR_word5_L2[24:31];    
     2'b10: FDR_L2mux[56:63] = FDR_word7_L2[24:31];    
     2'b11: FDR_L2mux[56:63] = FDR_word1_L2[24:31];    
      default: FDR_L2mux[56:63] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRbyte3_out1'
always @(FDR_word2_L2 or FDR_word4_L2 or FDR_word6_L2 or FDR_word0_L2 or FDR_outMuxSelByte23)
    begin                                           
    case({FDR_outMuxSelByte23[0], FDR_outMuxSelByte23[1]})
     2'b00: FDR_L2mux[24:31] = FDR_word2_L2[24:31];    
     2'b01: FDR_L2mux[24:31] = FDR_word4_L2[24:31];    
     2'b10: FDR_L2mux[24:31] = FDR_word6_L2[24:31];    
     2'b11: FDR_L2mux[24:31] = FDR_word0_L2[24:31];    
      default: FDR_L2mux[24:31] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRbyte2_out1'
always @(FDR_word2_L2 or FDR_word4_L2 or FDR_word6_L2 or FDR_word0_L2 or FDR_outMuxSelByte23)
    begin                                           
    case({FDR_outMuxSelByte23[0], FDR_outMuxSelByte23[1]})
     2'b00: FDR_L2mux[16:23] = FDR_word2_L2[16:23];    
     2'b01: FDR_L2mux[16:23] = FDR_word4_L2[16:23];    
     2'b10: FDR_L2mux[16:23] = FDR_word6_L2[16:23];    
     2'b11: FDR_L2mux[16:23] = FDR_word0_L2[16:23];    
      default: FDR_L2mux[16:23] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRbyte1_out1'
always @(FDR_word2_L2 or FDR_word4_L2 or FDR_word6_L2 or FDR_word0_L2 or FDR_outMuxSelByte01)
    begin                                           
    case({FDR_outMuxSelByte01[0], FDR_outMuxSelByte01[1]})
     2'b00: FDR_L2mux[8:15] = FDR_word2_L2[8:15];    
     2'b01: FDR_L2mux[8:15] = FDR_word4_L2[8:15];    
     2'b10: FDR_L2mux[8:15] = FDR_word6_L2[8:15];    
     2'b11: FDR_L2mux[8:15] = FDR_word0_L2[8:15];    
      default: FDR_L2mux[8:15] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRbyte0_out1'
always @(FDR_word2_L2 or FDR_word4_L2 or FDR_word6_L2 or FDR_word0_L2 or FDR_outMuxSelByte01)
    begin                                           
    case({FDR_outMuxSelByte01[0], FDR_outMuxSelByte01[1]})
     2'b00: FDR_L2mux[0:7] = FDR_word2_L2[0:7];    
     2'b01: FDR_L2mux[0:7] = FDR_word4_L2[0:7];    
     2'b10: FDR_L2mux[0:7] = FDR_word6_L2[0:7];    
     2'b11: FDR_L2mux[0:7] = FDR_word0_L2[0:7];    
      default: FDR_L2mux[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_regDCU_FDRword7Byte3'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword7Byte3_muxout = dataOutPos_B[120:127];
     1'b1: regDCU_FDRword7Byte3_muxout = dataOutPos_A[120:127];   
      default: regDCU_FDRword7Byte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[3] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word7_L2[24:31] <= FDR_word7_L2[24:31];                
     1'b1: FDR_word7_L2[24:31] <= regDCU_FDRword7Byte3_muxout;       
      default: FDR_word7_L2[24:31] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword7Byte2'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword7Byte2_muxout = dataOutPos_B[112:119];
     1'b1: regDCU_FDRword7Byte2_muxout = dataOutPos_A[112:119];   
      default: regDCU_FDRword7Byte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[2]&FDR_lo_byte23_E2)                        
     1'b0: FDR_word7_L2[16:23] <= FDR_word7_L2[16:23];                
     1'b1: FDR_word7_L2[16:23] <= regDCU_FDRword7Byte2_muxout;       
      default: FDR_word7_L2[16:23] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword7Byte1'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword7Byte1_muxout = dataOutPos_B[104:111];
     1'b1: regDCU_FDRword7Byte1_muxout = dataOutPos_A[104:111];   
      default: regDCU_FDRword7Byte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[1] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word7_L2[8:15] <= FDR_word7_L2[8:15];                
     1'b1: FDR_word7_L2[8:15] <= regDCU_FDRword7Byte1_muxout;       
      default: FDR_word7_L2[8:15] <= 8'bx;  
    endcase                             
   end    

// Removed the module 'dp_regDCU_FDRword7Byte0'
 always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword7Byte0_muxout = dataOutPos_B[96:103];
     1'b1: regDCU_FDRword7Byte0_muxout = dataOutPos_A[96:103];   
      default: regDCU_FDRword7Byte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[0] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word7_L2[0:7] <= FDR_word7_L2[0:7];                
     1'b1: FDR_word7_L2[0:7] <= regDCU_FDRword7Byte0_muxout;       
      default: FDR_word7_L2[0:7] <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_FDRword6Byte3'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword6Byte3_muxout = dataOutPos_B[88:95];
     1'b1: regDCU_FDRword6Byte3_muxout = dataOutPos_A[88:95];   
      default: regDCU_FDRword6Byte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[3] & FDR_lo_byte23_E2)
     1'b0: FDR_word6_L2[24:31] <= FDR_word6_L2[24:31];                
     1'b1: FDR_word6_L2[24:31] <= regDCU_FDRword6Byte3_muxout;       
      default: FDR_word6_L2[24:31] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword6Byte2'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword6Byte2_muxout = dataOutPos_B[80:87];   
     1'b1: regDCU_FDRword6Byte2_muxout = dataOutPos_A[80:87];   
      default: regDCU_FDRword6Byte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[2] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word6_L2[16:23] <= FDR_word6_L2[16:23];                
     1'b1: FDR_word6_L2[16:23] <= regDCU_FDRword6Byte2_muxout;       
      default: FDR_word6_L2[16:23] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword6Byte1'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword6Byte1_muxout = dataOutPos_B[72:79];
     1'b1: regDCU_FDRword6Byte1_muxout = dataOutPos_A[72:79];   
      default: regDCU_FDRword6Byte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[1] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word6_L2[8:15] <= FDR_word6_L2[8:15];                
     1'b1: FDR_word6_L2[8:15] <= regDCU_FDRword6Byte1_muxout;       
      default: FDR_word6_L2[8:15] <= 8'bx;  
    endcase                             
   end   

// Removed the module 'dp_regDCU_FDRword6Byte0'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword6Byte0_muxout = dataOutPos_B[64:71];   
     1'b1: regDCU_FDRword6Byte0_muxout = dataOutPos_A[64:71];   
      default: regDCU_FDRword6Byte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[0] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word6_L2[0:7] <= FDR_word6_L2[0:7];                
     1'b1: FDR_word6_L2[0:7] <= regDCU_FDRword6Byte0_muxout;       
      default: FDR_word6_L2[0:7] <= 8'bx;  
    endcase
   end

// Removed the module 'dp_regDCU_FDRword5Byte3'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword5Byte3_muxout = dataOutPos_B[56:63];   
     1'b1: regDCU_FDRword5Byte3_muxout = dataOutPos_A[56:63];   
      default: regDCU_FDRword5Byte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[3] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word5_L2[24:31] <= FDR_word5_L2[24:31];                
     1'b1: FDR_word5_L2[24:31] <= regDCU_FDRword5Byte3_muxout;       
      default: FDR_word5_L2[24:31] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword5Byte2'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword5Byte2_muxout = dataOutPos_B[48:55];   
     1'b1: regDCU_FDRword5Byte2_muxout = dataOutPos_A[48:55];   
      default: regDCU_FDRword5Byte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[2] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word5_L2[16:23] <= FDR_word5_L2[16:23];                
     1'b1: FDR_word5_L2[16:23] <= regDCU_FDRword5Byte2_muxout;       
      default: FDR_word5_L2[16:23] <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_FDRword5Byte1'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword5Byte1_muxout = dataOutPos_B[40:47];   
     1'b1: regDCU_FDRword5Byte1_muxout = dataOutPos_A[40:47];   
      default: regDCU_FDRword5Byte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[1] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word5_L2[8:15] <= FDR_word5_L2[8:15];                
     1'b1: FDR_word5_L2[8:15] <= regDCU_FDRword5Byte1_muxout;       
      default: FDR_word5_L2[8:15] <= 8'bx;  
    endcase                             
   end                                  

// Removed the module 'dp_regDCU_FDRword5Byte0'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword5Byte0_muxout = dataOutPos_B[32:39];   
     1'b1: regDCU_FDRword5Byte0_muxout = dataOutPos_A[32:39];   
      default: regDCU_FDRword5Byte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[0] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word5_L2[0:7] <= FDR_word5_L2[0:7];                
     1'b1: FDR_word5_L2[0:7] <= regDCU_FDRword5Byte0_muxout;       
      default: FDR_word5_L2[0:7] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword4Byte3'
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword4Byte3_muxout = dataOutPos_B[24:31];   
     1'b1: regDCU_FDRword4Byte3_muxout = dataOutPos_A[24:31];   
      default: regDCU_FDRword4Byte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[3] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word4_L2[24:31] <= FDR_word4_L2[24:31];                
     1'b1: FDR_word4_L2[24:31] <= regDCU_FDRword4Byte3_muxout;       
      default: FDR_word4_L2[24:31] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword4Byte2'
reg [16:23] regDCU_FDRword4Byte2_muxout;
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte23)
    begin                                       
    casez(FDR_loMuxSelByte23)                    
     1'b0: regDCU_FDRword4Byte2_muxout = dataOutPos_B[16:23];   
     1'b1: regDCU_FDRword4Byte2_muxout = dataOutPos_A[16:23];   
      default: regDCU_FDRword4Byte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[2] & FDR_lo_byte23_E2)                        
     1'b0: FDR_word4_L2[16:23] <= FDR_word4_L2[16:23];                
     1'b1: FDR_word4_L2[16:23] <= regDCU_FDRword4Byte2_muxout;       
      default: FDR_word4_L2[16:23] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword4Byte1'
reg [8:15] regDCU_FDRword4Byte1_muxout;
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword4Byte1_muxout = dataOutPos_B[8:15];   
     1'b1: regDCU_FDRword4Byte1_muxout = dataOutPos_A[8:15];   
      default: regDCU_FDRword4Byte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[1] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word4_L2[8:15] <= FDR_word4_L2[8:15];                
     1'b1: FDR_word4_L2[8:15] <= regDCU_FDRword4Byte1_muxout;       
      default: FDR_word4_L2[8:15] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword4Byte0'
reg [0:7] regDCU_FDRword4Byte0_muxout;
always @(dataOutPos_B or dataOutPos_A or FDR_loMuxSelByte01)
    begin                                       
    casez(FDR_loMuxSelByte01)                    
     1'b0: regDCU_FDRword4Byte0_muxout = dataOutPos_B[0:7];   
     1'b1: regDCU_FDRword4Byte0_muxout = dataOutPos_A[0:7];   
      default: regDCU_FDRword4Byte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(FDR_lo_E1[0] & FDR_lo_byte01_E2)                        
     1'b0: FDR_word4_L2[0:7] <= FDR_word4_L2[0:7];                
     1'b1: FDR_word4_L2[0:7] <= regDCU_FDRword4Byte0_muxout;       
      default: FDR_word4_L2[0:7] <= 8'bx;  
    endcase                             
   end                                  

// Removed the module 'dp_muxDCU_FDRword3Byte0'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord3_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01, FDR_holdMuxSel[0]})
     2'b00: FDR_word3Byte0_In[0:7] = dataOutPos_B[96:103];    
     2'b01: FDR_word3Byte0_In[0:7] = dataOutPos_A[96:103];    
     2'b10: FDR_word3Byte0_In[0:7] = holdDataRegWord3_L2[0:7];    
     2'b11: FDR_word3Byte0_In[0:7] = holdDataRegWord3_L2[0:7];    
      default: FDR_word3Byte0_In[0:7] = 8'bx;        
    endcase                                    
   end 
// Removed the module 'dp_muxDCU_FDRword3Byte1'

always @(dataOutPos_B or dataOutPos_A or holdDataRegWord3_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[1]})
     2'b00: FDR_word3Byte1_In[0:7] = dataOutPos_B[104:111];    
     2'b01: FDR_word3Byte1_In[0:7] = dataOutPos_A[104:111];    
     2'b10: FDR_word3Byte1_In[0:7] = holdDataRegWord3_L2[8:15];    
     2'b11: FDR_word3Byte1_In[0:7] = holdDataRegWord3_L2[8:15];    
      default: FDR_word3Byte1_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword3Byte2'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord3_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[2]})
     2'b00: FDR_word3Byte2_In[0:7] = dataOutPos_B[112:119];    
     2'b01: FDR_word3Byte2_In[0:7] = dataOutPos_A[112:119];    
     2'b10: FDR_word3Byte2_In[0:7] = holdDataRegWord3_L2[16:23];    
     2'b11: FDR_word3Byte2_In[0:7] = holdDataRegWord3_L2[16:23];    
      default: FDR_word3Byte2_In[0:7] = 8'bx;        
    endcase                                    
   end   

// Removed the module 'dp_muxDCU_FDRword3Byte3'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord3_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[3]})
     2'b00: FDR_word3Byte3_In[0:7] = dataOutPos_B[120:127];    
     2'b01: FDR_word3Byte3_In[0:7] = dataOutPos_A[120:127];    
     2'b10: FDR_word3Byte3_In[0:7] = holdDataRegWord3_L2[24:31];    
     2'b11: FDR_word3Byte3_In[0:7] = holdDataRegWord3_L2[24:31];    
      default: FDR_word3Byte3_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword2Byte3'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord2_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[3]})
     2'b00: FDR_word2Byte3_In[0:7] = dataOutPos_B[88:95];    
     2'b01: FDR_word2Byte3_In[0:7] = dataOutPos_A[88:95];    
     2'b10: FDR_word2Byte3_In[0:7] = holdDataRegWord2_L2[24:31];    
     2'b11: FDR_word2Byte3_In[0:7] = holdDataRegWord2_L2[24:31];    
      default: FDR_word2Byte3_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword2Byte2'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord2_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[2]})
     2'b00: FDR_word2Byte2_In[0:7] = dataOutPos_B[80:87];    
     2'b01: FDR_word2Byte2_In[0:7] = dataOutPos_A[80:87];    
     2'b10: FDR_word2Byte2_In[0:7] = holdDataRegWord2_L2[16:23];    
     2'b11: FDR_word2Byte2_In[0:7] = holdDataRegWord2_L2[16:23];    
      default: FDR_word2Byte2_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword2Byte1'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord2_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[1]})
     2'b00: FDR_word2Byte1_In[0:7] = dataOutPos_B[72:79];    
     2'b01: FDR_word2Byte1_In[0:7] = dataOutPos_A[72:79];    
     2'b10: FDR_word2Byte1_In[0:7] = holdDataRegWord2_L2[8:15];    
     2'b11: FDR_word2Byte1_In[0:7] = holdDataRegWord2_L2[8:15];    
      default: FDR_word2Byte1_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword2Byte0'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord2_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01, FDR_holdMuxSel[0]})
     2'b00: FDR_word2Byte0_In[0:7] = dataOutPos_B[64:71];    
     2'b01: FDR_word2Byte0_In[0:7] = dataOutPos_A[64:71];    
     2'b10: FDR_word2Byte0_In[0:7] = holdDataRegWord2_L2[0:7];    
     2'b11: FDR_word2Byte0_In[0:7] = holdDataRegWord2_L2[0:7];    
      default: FDR_word2Byte0_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_regDCU_FDRword3Byte0'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[0] & FDR_hi_byte01_E2)
     1'b0: FDR_word3_L2[0:7] <= FDR_word3_L2[0:7];                
     1'b1: FDR_word3_L2[0:7] <= FDR_word3Byte0_In[0:7]; 
      default: FDR_word3_L2[0:7] <= 8'bx;  
    endcase                             
   end                                  

// Removed the module 'dp_regDCU_FDRword3Byte1'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[1] & FDR_hi_byte01_E2)
     1'b0: FDR_word3_L2[8:15] <= FDR_word3_L2[8:15];                
     1'b1: FDR_word3_L2[8:15] <= FDR_word3Byte1_In[0:7];            
      default: FDR_word3_L2[8:15] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword3Byte2'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[2] & FDR_hi_byte23_E2)
     1'b0: FDR_word3_L2[16:23] <= FDR_word3_L2[16:23];                
     1'b1: FDR_word3_L2[16:23] <= FDR_word3Byte2_In[0:7];            
      default: FDR_word3_L2[16:23] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword3Byte3'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[3] & FDR_hi_byte23_E2)                
     1'b0: FDR_word3_L2[24:31] <= FDR_word3_L2[24:31];                
     1'b1: FDR_word3_L2[24:31] <= FDR_word3Byte3_In[0:7];            
      default: FDR_word3_L2[24:31] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword2Byte3'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[3] & FDR_hi_byte23_E2)                
     1'b0: FDR_word2_L2[24:31] <= FDR_word2_L2[24:31];                
     1'b1: FDR_word2_L2[24:31] <= FDR_word2Byte3_In[0:7];            
      default: FDR_word2_L2[24:31] <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_FDRword2Byte2'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[2]& FDR_hi_byte23_E2)                
     1'b0: FDR_word2_L2[16:23] <= FDR_word2_L2[16:23];                
     1'b1: FDR_word2_L2[16:23] <= FDR_word2Byte2_In[0:7];            
      default: FDR_word2_L2[16:23] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword2Byte1'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[1]& FDR_hi_byte01_E2)                
     1'b0: FDR_word2_L2[8:15] <= FDR_word2_L2[8:15];                
     1'b1: FDR_word2_L2[8:15] <= FDR_word2Byte1_In[0:7];            
      default: FDR_word2_L2[8:15] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword2Byte0'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[0]& FDR_hi_byte01_E2)                
     1'b0: FDR_word2_L2[0:7] <= FDR_word2_L2[0:7];                
     1'b1: FDR_word2_L2[0:7] <= FDR_word2Byte0_In[0:7];            
      default: FDR_word2_L2[0:7] <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_FDRword1Byte3'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[3] & FDR_hi_byte23_E2)                
     1'b0: FDR_word1_L2[24:31] <= FDR_word1_L2[24:31];                
     1'b1: FDR_word1_L2[24:31] <= FDR_word1Byte3_In[0:7];            
      default: FDR_word1_L2[24:31] <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_FDRword1Byte2'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[2]& FDR_hi_byte23_E2)                
     1'b0: FDR_word1_L2[16:23] <= FDR_word1_L2[16:23];                
     1'b1: FDR_word1_L2[16:23] <=  FDR_word1Byte2_In[0:7];            
      default: FDR_word1_L2[16:23] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword1Byte1'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[1]& FDR_hi_byte01_E2)                
     1'b0: FDR_word1_L2[8:15] <= FDR_word1_L2[8:15];                
     1'b1: FDR_word1_L2[8:15] <= FDR_word1Byte1_In[0:7];            
      default: FDR_word1_L2[8:15] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword1Byte0'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[0] & FDR_hi_byte01_E2)                
     1'b0: FDR_word1_L2[0:7] <= FDR_word1_L2[0:7];                
     1'b1: FDR_word1_L2[0:7] <= FDR_word1Byte0_In[0:7];            
      default: FDR_word1_L2[0:7] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_muxDCU_FDRword1Byte3'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord1_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[3]})       
     2'b00: FDR_word1Byte3_In[0:7] = dataOutPos_B[56:63];    
     2'b01: FDR_word1Byte3_In[0:7] = dataOutPos_A[56:63];    
     2'b10: FDR_word1Byte3_In[0:7] = holdDataRegWord1_L2[24:31];    
     2'b11: FDR_word1Byte3_In[0:7] = holdDataRegWord1_L2[24:31];    
      default: FDR_word1Byte3_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword1Byte2'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord1_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[2]})       
     2'b00: FDR_word1Byte2_In[0:7] = dataOutPos_B[48:55];    
     2'b01: FDR_word1Byte2_In[0:7] = dataOutPos_A[48:55];    
     2'b10: FDR_word1Byte2_In[0:7] = holdDataRegWord1_L2[16:23];    
     2'b11: FDR_word1Byte2_In[0:7] = holdDataRegWord1_L2[16:23];    
      default: FDR_word1Byte2_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword1Byte1'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord1_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[1]})       
     2'b00: FDR_word1Byte1_In[0:7] = dataOutPos_B[40:47];    
     2'b01: FDR_word1Byte1_In[0:7] = dataOutPos_A[40:47];    
     2'b10: FDR_word1Byte1_In[0:7] = holdDataRegWord1_L2[8:15];    
     2'b11: FDR_word1Byte1_In[0:7] = holdDataRegWord1_L2[8:15];    
      default: FDR_word1Byte1_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword1Byte0'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord1_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[0]})       
     2'b00: FDR_word1Byte0_In[0:7] = dataOutPos_B[32:39];    
     2'b01: FDR_word1Byte0_In[0:7] = dataOutPos_A[32:39];    
     2'b10: FDR_word1Byte0_In[0:7] = holdDataRegWord1_L2[0:7];    
     2'b11: FDR_word1Byte0_In[0:7] = holdDataRegWord1_L2[0:7];    
      default: FDR_word1Byte0_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_regDCU_FDRword0Byte3'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[3]& FDR_hi_byte23_E2)                
     1'b0: FDR_word0_L2[24:31] <= FDR_word0_L2[24:31];                
     1'b1: FDR_word0_L2[24:31] <= FDR_word0Byte3_In[0:7];            
      default: FDR_word0_L2[24:31] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword0Byte2'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[2] & FDR_hi_byte23_E2)                
     1'b0: FDR_word0_L2[16:23] <= FDR_word0_L2[16:23];                
     1'b1: FDR_word0_L2[16:23] <= FDR_word0Byte2_In[0:7];            
      default: FDR_word0_L2[16:23] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_FDRword0Byte1'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[1] & FDR_hi_byte01_E2)                
     1'b0: FDR_word0_L2[8:15] <= FDR_word0_L2[8:15];                
     1'b1: FDR_word0_L2[8:15] <= FDR_word0Byte1_In[0:7];            
      default: FDR_word0_L2[8:15] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_FDRword0Byte0'
always @(posedge CB)      
    begin                                       
    casez(FDR_hi_E1[0] & FDR_hi_byte01_E2)                
     1'b0: FDR_word0_L2[0:7] <= FDR_word0_L2[0:7];                
     1'b1: FDR_word0_L2[0:7] <= FDR_word0Byte0_In[0:7];            
      default: FDR_word0_L2[0:7] <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_muxDCU_FDRword0Byte3'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord0_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[3]})       
     2'b00: FDR_word0Byte3_In[0:7] = dataOutPos_B[24:31];    
     2'b01: FDR_word0Byte3_In[0:7] = dataOutPos_A[24:31];    
     2'b10: FDR_word0Byte3_In[0:7] = holdDataRegWord0_L2[24:31];    
     2'b11: FDR_word0Byte3_In[0:7] = holdDataRegWord0_L2[24:31];    
      default: FDR_word0Byte3_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword0Byte2'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord0_L2 or FDR_hiMuxSelByte23 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte23,FDR_holdMuxSel[2]})       
     2'b00: FDR_word0Byte2_In[0:7] = dataOutPos_B[16:23];    
     2'b01: FDR_word0Byte2_In[0:7] = dataOutPos_A[16:23];    
     2'b10: FDR_word0Byte2_In[0:7] = holdDataRegWord0_L2[16:23];    
     2'b11: FDR_word0Byte2_In[0:7] = holdDataRegWord0_L2[16:23];    
      default: FDR_word0Byte2_In[0:7] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_FDRword0Byte1'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord0_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[1]})       
     2'b00: FDR_word0Byte1_In[0:7] = dataOutPos_B[8:15];    
     2'b01: FDR_word0Byte1_In[0:7] = dataOutPos_A[8:15];    
     2'b10: FDR_word0Byte1_In[0:7] = holdDataRegWord0_L2[8:15];    
     2'b11: FDR_word0Byte1_In[0:7] = holdDataRegWord0_L2[8:15];    
      default: FDR_word0Byte1_In[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_FDRword0Byte0'
always @(dataOutPos_B or dataOutPos_A or holdDataRegWord0_L2 or FDR_hiMuxSelByte01 or FDR_holdMuxSel)
    begin                                           
    case({FDR_hiMuxSelByte01,FDR_holdMuxSel[0]})
     2'b00:  FDR_word0Byte0_In[0:7] = dataOutPos_B[0:7];    
     2'b01:  FDR_word0Byte0_In[0:7] = dataOutPos_A[0:7];    
     2'b10:  FDR_word0Byte0_In[0:7] = holdDataRegWord0_L2[0:7];    
     2'b11:  FDR_word0Byte0_In[0:7] = holdDataRegWord0_L2[0:7];    
      default:  FDR_word0Byte0_In[0:7] = 8'bx;        
    endcase                                    
   end 

//--------- start ---------------
// rgoldiez - added this register to select the proper parity error signal
//
// We will generate a parity error signal if any byte in the half line has an error.  The particular
// selects used in the mux-reg is not important since we keep the error signal on for the entire half
// line.

// do we really need this stuff if we qualify the output with flushIdle_state_N
// OR2_J  logDCU_parityFlushType(.Z(flushInst), .A(carDcbf), .B(carDcbst));
// NOR2_J logDCU_parityNotFlushType(.Z(flushInst_N), .A(carDcbf), .B(carDcbst));

// do we really need this stuff if we qualify the output with flushIdle_state_N
// AO22_H logDCU_parityErrorAllowedA (.Z(p_allowA), .A1(flushInst), .A2(hit_a), .B1(flushInst_N), .B2(validA));
// AO22_H logDCU_parityErrorAllowedB (.Z(p_allowB), .A1(flushInst), .A2(hit_b), .B1(flushInst_N), .B2(validB));

// do we really need this stuff if we qualify the output with flushIdle_state_N
// AND2_J logDCU_parityDirtyAndAllowedA (.Z(p_dirtyAndAllowedA), .A(dirtyA), .B(p_allowA));
// AND2_J logDCU_parityDirtyAndAllowedB (.Z(p_dirtyAndAllowedB), .A(dirtyB), .B(p_allowB));

// OA21_H logDCU_parityTagOrDataErrA (.A1(p_aSideErrorRaw), .A2(p_tagErrorA), .B(p_dirtyAndAllowedA), .Z(p_aSideError));
// OA21_H logDCU_parityTagOrDataErrB (.A1(p_bSideErrorRaw), .A2(p_tagErrorB), .B(p_dirtyAndAllowedB), .Z(p_bSideError));

// new! added this to detect all multi-hit errors
   // Replacing instantiation: AND2 logDCU_parityMultiHit
   wire p_flushMultiHit;
   assign p_flushMultiHit = hit_a & hit_b;

// new! changed to cause an error for a bad tag on either way, not just the hit way
   // Replacing instantiation: OR3 logDCU_parityTagOrDataErrA
   wire p_aSideError;
   assign p_aSideError = p_aSideErrorRaw | tagParityError | p_flushMultiHit;

   // Replacing instantiation: OR3 logDCU_parityTagOrDataErrB
   wire p_bSideError;
   assign p_bSideError = p_bSideErrorRaw | tagParityError | p_flushMultiHit;


// rgoldiez - We need to qualify the bSideError signal with reset since at reset the bSideError leg
//             is the default.  Qualifying it with zero forces this leg to be zero and we can reset
//             the register
   // Replacing instantiation: INVERT logDCU_parityResetInv
   wire resetCore_N;
   assign resetCore_N = ~(resetCore);

// AND2_J logDCU_parityBSideResetQual(.A(p_bSideError), .B(resetCore_N), .Z(p_bSideErrorAndNotReset));

// rgoldiez - these OR gates are to enable the E1/E2 signals during reset to reset the
//             registers
// new! Changed to fix def2018 by added the 'C' leg to these OR gates
   // Replacing instantiation: OR3 logDCU_parityResetQualHi1
   wire flushAlmostDoneBlip;
   wire p_parityFDRhiE1;
   assign p_parityFDRhiE1 = FDR_hi_E1[0] | resetCore | flushAlmostDoneBlip;

   // Replacing instantiation: OR3 logDCU_parityResetQualHi2
   assign p_parityFDRhiE2 = FDR_hi_byte01_E2 | resetCore | flushAlmostDoneBlip;


// rgoldiez - made this a 3-port mux-reg since D2 and "D3" need the same signal (def1940)
// new! Changed to fix def2018 further gating the D0/D1 inputs with the 'blip' signal
//      we need to gate if off with flushAlmostDone"Blip" and not if there is still a 
//        flush pending (hence the oneFPL2)
   // Replacing instantiation: PDP_P3EEL2 dp_regDCU_parityFDRhi
   reg dp_regDCU_parityFDRhi_regL2;
   reg dp_regDCU_parityFDRhi_DataIn;
   wire dp_regDCU_parityFDRhi_D0,dp_regDCU_parityFDRhi_D1; 
   wire dp_regDCU_parityFDRhi_D2; 
   wire [0:1] dp_regDCU_parityFDRhi_SD; 
   wire dp_regDCU_parityFDRhi_E1; 
   wire dp_regDCU_parityFDRhi_E2; 
   assign p_FDRhi_L2 = dp_regDCU_parityFDRhi_regL2;     	
   assign dp_regDCU_parityFDRhi_E1 = p_parityFDRhiE1;     
   assign dp_regDCU_parityFDRhi_E2 = p_parityFDRhiE2;     
   assign dp_regDCU_parityFDRhi_SD = {FDR_hiMuxSelByte01,FDR_holdMuxSel[0]};    	
   assign dp_regDCU_parityFDRhi_D0 = (p_bSideError & resetCore_N & (flushAlmostDoneBlip_N));    	
   assign dp_regDCU_parityFDRhi_D1 = (p_aSideError & (flushAlmostDoneBlip_N));    	
   assign dp_regDCU_parityFDRhi_D2 = p_holdDataReg_L2;    	
                                           
   // 3-1 Mux input to register	      	
   always @(dp_regDCU_parityFDRhi_D0 or dp_regDCU_parityFDRhi_D1 or dp_regDCU_parityFDRhi_D2 or dp_regDCU_parityFDRhi_SD)  	
    begin				  	
    casex(dp_regDCU_parityFDRhi_SD)			
     2'b00: dp_regDCU_parityFDRhi_DataIn = dp_regDCU_parityFDRhi_D0;	
     2'b01: dp_regDCU_parityFDRhi_DataIn = dp_regDCU_parityFDRhi_D1;	
     2'b1x: dp_regDCU_parityFDRhi_DataIn = dp_regDCU_parityFDRhi_D2;	
      default: dp_regDCU_parityFDRhi_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_parityFDRhi_E1 & dp_regDCU_parityFDRhi_E2)		
     1'b0: dp_regDCU_parityFDRhi_regL2 <= dp_regDCU_parityFDRhi_regL2;		
     1'b1: dp_regDCU_parityFDRhi_regL2 <= dp_regDCU_parityFDRhi_DataIn;	
      default: dp_regDCU_parityFDRhi_regL2 <= 1'bx;  
    endcase		 		
   end			 		


// rgoldiez - these OR gates are to enable the E1/E2 signals during reset to reset the
//             registers
// new! Changed to fix def2018 by added the 'C' leg to these OR gates
   // Replacing instantiation: OR3 logDCU_parityResetQualLo1
   wire p_parityFDRloE1;
   assign p_parityFDRloE1 = FDR_lo_E1[0] | resetCore | flushAlmostDoneBlip;

   // Replacing instantiation: OR3 logDCU_parityResetQualLo2
   assign p_parityFDRloE2 = FDR_lo_byte01_E2 | resetCore | flushAlmostDoneBlip;


// new! Changed to fix def2018 further gating the D0/D1 inputs with the 'blip' signal
   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityFDRlo
   reg dp_regDCU_parityFDRlo_regL2;
   reg dp_regDCU_parityFDRlo_DataIn;
   wire dp_regDCU_parityFDRlo_D0,dp_regDCU_parityFDRlo_D1; 
   wire dp_regDCU_parityFDRlo_SD; 
   wire dp_regDCU_parityFDRlo_E1; 
   assign p_FDRlo_L2 = dp_regDCU_parityFDRlo_regL2;     	
   assign dp_regDCU_parityFDRlo_E1 = p_parityFDRloE1 & p_parityFDRloE2;     
   assign dp_regDCU_parityFDRlo_SD = FDR_loMuxSelByte01;    	
   assign dp_regDCU_parityFDRlo_D0 = (p_bSideError & resetCore_N & (flushAlmostDoneBlip_N));    	
   assign dp_regDCU_parityFDRlo_D1 = (p_aSideError & (flushAlmostDoneBlip_N));    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityFDRlo_D0 or dp_regDCU_parityFDRlo_D1 or dp_regDCU_parityFDRlo_SD)  	
    begin				  	
    casez(dp_regDCU_parityFDRlo_SD)			
     1'b0: dp_regDCU_parityFDRlo_DataIn = dp_regDCU_parityFDRlo_D0;	
     1'b1: dp_regDCU_parityFDRlo_DataIn = dp_regDCU_parityFDRlo_D1;	
      default: dp_regDCU_parityFDRlo_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_parityFDRlo_E1)			
     1'b0: dp_regDCU_parityFDRlo_regL2 <= dp_regDCU_parityFDRlo_regL2;		
     1'b1: dp_regDCU_parityFDRlo_regL2 <= dp_regDCU_parityFDRlo_DataIn;	
      default: dp_regDCU_parityFDRlo_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: NAND2 logDCU_parityFlushStateQual
   wire flushIdle_stateL2_Qual;
   wire flushIdle_stateL2;
   assign flushIdle_stateL2_Qual = ~( flushIdle_stateL2 & resetCore_N );

   // Replacing instantiation: OR2 logDCU_parityLastCycleE1
   wire parityFlushErrorLastCycleE1;
   wire flushIdle_state_N;
   assign parityFlushErrorLastCycleE1 = flushIdle_state_N | flushIdle_stateL2_Qual;

   // Replacing instantiation: OA21 logDCU_parityErrorLastCycle
   wire p_FlushErrorLastCycle;
   assign p_FlushErrorLastCycle = (p_FDRhi_L2 | p_FDRlo_L2) & flushIdle_state_N;

   // Replacing instantiation: AND2 logDCU_parityErrorLastCycleIn
   wire p_FlushErrorLastCycleIn;
   assign p_FlushErrorLastCycleIn = p_FlushErrorLastCycle & ~flushDone;

// changing this below due to problem found with /afs/peps/p/cobra/src/kmagill/testcode/dcu/code/dcu_TF_Monitors_Test.scr
// INVERT_F logDCU_parityFADInv (.Z(flushAlmostDoneL2_N), .A(flushAlmostDoneL2));
// NAND2_F  logDCU_parityFADBlipIn (.Z(flushAlmostDoneBlip_N), .A(flushAlmostDone), .B(flushAlmostDoneL2_N));
   // Replacing instantiation: INVERT logDCU_parityFADInv
   wire flushAlmostDone_N;
   assign flushAlmostDone_N = ~(flushAlmostDone);

   // Replacing instantiation: NAND2 logDCU_parityFADBlipIn
   wire flushAlmostDoneL2;
   assign flushAlmostDoneBlip_N = ~( flushAlmostDone & ~flushAlmostDoneL2 );

// new! Added to fix def2018
   // Replacing instantiation: INVERT logDCU_parityFADBlip_Buf
   assign flushAlmostDoneBlip = ~(flushAlmostDoneBlip_N);


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_parityFlushErrorLastCycle
   wire p_FlushErrorLastCycleL2;
   reg [0:2] dp_regDCU_parityFlushErrorLastCycle_regL2;
   wire [0:2] dp_regDCU_parityFlushErrorLastCycle_D; 
   wire dp_regDCU_parityFlushErrorLastCycle_E1; 
   assign {p_FlushErrorLastCycleL2,flushIdle_stateL2,flushAlmostDoneL2} = dp_regDCU_parityFlushErrorLastCycle_regL2;     	
   assign dp_regDCU_parityFlushErrorLastCycle_E1 = parityFlushErrorLastCycleE1;     
   assign dp_regDCU_parityFlushErrorLastCycle_D = {p_FlushErrorLastCycleIn,flushIdle_state,flushAlmostDone};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_parityFlushErrorLastCycle_E1)	                
     1'b0: dp_regDCU_parityFlushErrorLastCycle_regL2 <= dp_regDCU_parityFlushErrorLastCycle_regL2;		
     1'b1: dp_regDCU_parityFlushErrorLastCycle_regL2 <= dp_regDCU_parityFlushErrorLastCycle_D;		
      default: dp_regDCU_parityFlushErrorLastCycle_regL2 <= 3'bx;  
    endcase		 		
   end			 		



   // Replacing instantiation: INVERT logDCU_parityFlushIdleInv
   assign flushIdle_state_N = ~(flushIdle_state);

   // Replacing instantiation: INVERT logDCU_parityFlushErrorLastInv
   wire p_FlushErrorLastCycle_N;
   assign p_FlushErrorLastCycle_N = ~(p_FlushErrorLastCycleL2);

   // Replacing instantiation: AO22 logDCU_parityFlushReduction
   wire FlushParityError;
   assign FlushParityError = (p_FDRhi_L2 & flushIdle_state_N) | (p_FDRlo_L2 & flushIdle_state_N);

   // Replacing instantiation: AND3 logDCU_parityFlushError
   assign DCU_FlushParityError = p_FlushErrorLastCycle_N & FlushParityError & oneFPL2;

//--------- end -----------------


endmodule
