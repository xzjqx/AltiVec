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

module p405s_DCU_writeBuf( WB_word0L2,
                           WB_word1L2,
                           WB_word2L2,
                           WB_word3L2,
                           p_WBhi_L2,
                           CB,
                           SDQ_SDP_mux,
                           p_SDQ_SDP_mux,
                           fillBufWord0_L2,
                           fillBufWord1_L2,
                           fillBufWord2_L2,
                           fillBufWord3_L2,
                           fillBufWord4_L2,
                           fillBufWord5_L2,
                           fillBufWord6_L2,
                           fillBufWord7_L2,
                           p_fillBuf_L2, 
                           writeBufHi_E1,
                           writeBufHi_E2,
                           writeBufLoTag_E1,
                           writeBufLoTag_E2,
                           writeBufMuxSelBit0,
                           writeBufMuxSelBit1
                         );


input  writeBufHi_E1;
input  writeBufLoTag_E1;
input  writeBufLoTag_E2;
input  writeBufMuxSelBit0;

output [0:31]  WB_word0L2;
output [0:31]  WB_word1L2;
output [0:31]  WB_word3L2;
output [0:31]  WB_word2L2;

//--------- start ---------------
// rgoldiez - added this ports for the 16 bytes of data to be written to the parity array
output [0:15]  p_WBhi_L2;
//--------- end -----------------

input [0:31]  fillBufWord6_L2;
input [0:31]  fillBufWord7_L2;
input [0:3]  writeBufHi_E2;
input [0:31]  fillBufWord0_L2;
input [0:31]  fillBufWord1_L2;
input [0:31]  fillBufWord4_L2;
input [0:31]  fillBufWord5_L2;
input CB;
input [0:31]  SDQ_SDP_mux;
input [0:31]  fillBufWord3_L2;
input [0:31]  fillBufWord2_L2;
input [0:31]  writeBufMuxSelBit1;

//--------- start ---------------
// rgoldiez - added these ports to feed in the parity bits from the fill buffer and SDQ/SDP mux

input [0:3]  p_SDQ_SDP_mux;
input [0:31] p_fillBuf_L2;

//--------- end -----------------

// Buses in the design

reg  [0:31]  WB_word6L2;
reg  [0:31]  WB_word7L2;
wire  [0:5]  controlByte23;
wire  [0:5]  controlByte01;
reg   [0:31]  WB_word4L2;
reg   [0:31]  WB_word5L2;


wire  [0:3]  writeBufHiByte23_E2;

wire  [0:3]  writeBufHiByte01_E2;
// wires from instantiation
wire WB_loByte3_E1;
wire writeBufLoTagByte23_E2;
wire WB_loByte2_E1;
wire WB_loByte1_E1;
wire writeBufLoTagByte01_E2;
wire WB_hiByte3_E1;
wire WB_loByte0_E1;
wire writeBufMuxSelByte23Bit0;
wire WB_hiByte2_E1;
wire WB_hiByte1_E1;
wire WB_hiByte0_E1;
wire writeBufMuxSelByte01Bit0;

//--------- start ---------------
// rgoldiez - added this wire for the lower 16 bytes that will go to the p_WBhi_L2 next cycle
wire  [0:15] p_WBlo_L2;
//--------- end -----------------

// Removed the module 'module dp_logDCU_WB_inv10
// Removed the module 'module dp_logDCU_WB_inv9
// Removed the module 'module dp_logDCU_WB_inv8
// Removed the module 'module dp_logDCU_WB_inv7
// Removed the module 'module dp_logDCU_WB_inv6
// Removed the module 'module dp_logDCU_WB_inv5
// Removed the module 'module dp_logDCU_WB_inv4
// Removed the module 'module dp_logDCU_WB_inv3
// Removed the module 'module dp_logDCU_WB_inv2
// Removed the module 'module dp_logDCU_WB_inv1

   wire       hiE1_inv2, loE1_inv2,  hiE1_inv1, loE1_inv1;
   
   assign {writeBufHiByte23_E2[0:3],writeBufLoTagByte23_E2, writeBufMuxSelByte23Bit0} = ~controlByte23[0:5];
   assign {writeBufHiByte01_E2[0:3],writeBufLoTagByte01_E2, writeBufMuxSelByte01Bit0} = ~controlByte01[0:5];
   assign controlByte23[0:5] = ~{writeBufHi_E2[0:3], writeBufLoTag_E2, writeBufMuxSelBit0};
   assign controlByte01[0:5] = ~{writeBufHi_E2[0:3], writeBufLoTag_E2, writeBufMuxSelBit0};
   assign {WB_hiByte3_E1, WB_loByte3_E1} = ~{hiE1_inv2, loE1_inv2};
   assign {WB_hiByte2_E1, WB_loByte2_E1} = ~{hiE1_inv2, loE1_inv2};
   assign {WB_hiByte1_E1, WB_loByte1_E1} = ~{hiE1_inv1, loE1_inv1};
   assign {WB_hiByte0_E1, WB_loByte0_E1} = ~{hiE1_inv1, loE1_inv1};
   assign {hiE1_inv2, loE1_inv2} = ~{writeBufHi_E1, writeBufLoTag_E1};
   assign {hiE1_inv1, loE1_inv1} = ~{writeBufHi_E1, writeBufLoTag_E1};
   

// Removed the module 'module dp_regDCU_WBword7Byte3
// Removed the module 'module dp_regDCU_WBword7Byte2
// Removed the module 'module dp_regDCU_WBword7Byte1
// Removed the module 'module dp_regDCU_WBword7Byte0
// Removed the module 'module dp_regDCU_WBword6Byte3
// Removed the module 'module dp_regDCU_WBword6Byte2
// Removed the module 'module dp_regDCU_WBword6Byte1
// Removed the module 'module dp_regDCU_WBword6Byte0
// Removed the module 'module dp_regDCU_WBword5Byte3
// Removed the module 'module dp_regDCU_WBword5Byte2
// Removed the module 'module dp_regDCU_WBword5Byte1
// Removed the module 'module dp_regDCU_WBword5Byte0
// Removed the module 'module dp_regDCU_WBword4Byte3
// Removed the module 'module dp_regDCU_WBword4Byte2
// Removed the module 'module dp_regDCU_WBword4Byte1
// Removed the module 'module dp_regDCU_WBword4Byte0
// Removed the module 'module dp_regDCU_WBword3Byte3
// Removed the module 'module dp_regDCU_WBword3Byte2
// Removed the module 'module dp_regDCU_WBword3Byte1
// Removed the module 'module dp_regDCU_WBword3Byte0
// Removed the module 'module dp_regDCU_WBword2Byte3
// Removed the module 'module dp_regDCU_WBword2Byte2
// Removed the module 'module dp_regDCU_WBword2Byte1
// Removed the module 'module dp_regDCU_WBword2Byte0
// Removed the module 'module dp_regDCU_WBword1Byte3
// Removed the module 'module dp_regDCU_WBword1Byte2
// Removed the module 'module dp_regDCU_WBword1Byte1
// Removed the module 'module dp_regDCU_WBword1Byte0
// Removed the module 'module dp_regDCU_WBword0Byte3
// Removed the module 'module dp_regDCU_WBword0Byte2
// Removed the module 'module dp_regDCU_WBword0Byte1
// Removed the module 'module dp_regDCU_WBword0Byte0

   reg [0:31] dp_Reg_DataIn7;
   
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord7_L2)        
     begin                                       
	case(writeBufMuxSelBit1[31])                    
	  1'b0: dp_Reg_DataIn7[24:31] = SDQ_SDP_mux[24:31];   
	  1'b1: dp_Reg_DataIn7[24:31] = fillBufWord7_L2[24:31];   
	  default: dp_Reg_DataIn7[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte3_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word7L2[24:31] <= WB_word7L2[24:31];                
	  1'b1: WB_word7L2[24:31] <= dp_Reg_DataIn7[24:31];       
	  default: WB_word7L2[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord7_L2)        
     begin                                       
	case(writeBufMuxSelBit1[30])                    
	  1'b0: dp_Reg_DataIn7[16:23] = SDQ_SDP_mux[16:23];   
	  1'b1: dp_Reg_DataIn7[16:23] = fillBufWord7_L2[16:23];   
	  default: dp_Reg_DataIn7[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte2_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word7L2[16:23] <= WB_word7L2[16:23];                
	  1'b1: WB_word7L2[16:23] <= dp_Reg_DataIn7[16:23];       
	  default: WB_word7L2[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord7_L2)        
     begin                                       
	case(writeBufMuxSelBit1[29])                    
	  1'b0: dp_Reg_DataIn7[8:15] = SDQ_SDP_mux[8:15];   
	  1'b1: dp_Reg_DataIn7[8:15] = fillBufWord7_L2[8:15];   
	  default: dp_Reg_DataIn7[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte1_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word7L2[8:15] <= WB_word7L2[8:15];                
	  1'b1: WB_word7L2[8:15] <= dp_Reg_DataIn7[8:15];       
	  default: WB_word7L2[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord7_L2)        
     begin                                       
	case(writeBufMuxSelBit1[28])                    
	  1'b0: dp_Reg_DataIn7[0:7] = SDQ_SDP_mux[0:7];   
	  1'b1: dp_Reg_DataIn7[0:7] = fillBufWord7_L2[0:7];   
	  default: dp_Reg_DataIn7[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte0_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word7L2[0:7] <= WB_word7L2[0:7];                
	  1'b1: WB_word7L2[0:7] <= dp_Reg_DataIn7[0:7];       
	  default: WB_word7L2[0:7] <= 8'bx;  
	endcase                             
     end  

   reg [0:31] dp_Reg_DataIn6;
   
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord6_L2)        
     begin                                       
	case(writeBufMuxSelBit1[27])                    
	  1'b0: dp_Reg_DataIn6[24:31] = SDQ_SDP_mux[24:31];   
	  1'b1: dp_Reg_DataIn6[24:31] = fillBufWord6_L2[24:31];   
	  default: dp_Reg_DataIn6[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte3_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word6L2[24:31] <= WB_word6L2[24:31];                
	  1'b1: WB_word6L2[24:31] <= dp_Reg_DataIn6[24:31];       
	  default: WB_word6L2[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord6_L2)        
     begin                                       
	case(writeBufMuxSelBit1[26])                    
	  1'b0: dp_Reg_DataIn6[16:23] = SDQ_SDP_mux[16:23];   
	  1'b1: dp_Reg_DataIn6[16:23] = fillBufWord6_L2[16:23];   
	  default: dp_Reg_DataIn6[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte2_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word6L2[16:23] <= WB_word6L2[16:23];                
	  1'b1: WB_word6L2[16:23] <= dp_Reg_DataIn6[16:23];       
	  default: WB_word6L2[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord6_L2)        
     begin                                       
	case(writeBufMuxSelBit1[25])                    
	  1'b0: dp_Reg_DataIn6[8:15] = SDQ_SDP_mux[8:15];   
	  1'b1: dp_Reg_DataIn6[8:15] = fillBufWord6_L2[8:15];   
	  default: dp_Reg_DataIn6[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte1_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word6L2[8:15] <= WB_word6L2[8:15];                
	  1'b1: WB_word6L2[8:15] <= dp_Reg_DataIn6[8:15];       
	  default: WB_word6L2[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord6_L2)        
     begin                                       
	case(writeBufMuxSelBit1[24])                    
	  1'b0: dp_Reg_DataIn6[0:7] = SDQ_SDP_mux[0:7];   
	  1'b1: dp_Reg_DataIn6[0:7] = fillBufWord6_L2[0:7];   
	  default: dp_Reg_DataIn6[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte0_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word6L2[0:7] <= WB_word6L2[0:7];                
	  1'b1: WB_word6L2[0:7] <= dp_Reg_DataIn6[0:7];       
	  default: WB_word6L2[0:7] <= 8'bx;  
	endcase                             
     end  
   
   reg [0:31] dp_Reg_DataIn5;
   
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord5_L2)        
     begin                                       
	case(writeBufMuxSelBit1[23])                    
	  1'b0: dp_Reg_DataIn5[24:31] = SDQ_SDP_mux[24:31];   
	  1'b1: dp_Reg_DataIn5[24:31] = fillBufWord5_L2[24:31];   
	  default: dp_Reg_DataIn5[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte3_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word5L2[24:31] <= WB_word5L2[24:31];                
	  1'b1: WB_word5L2[24:31] <= dp_Reg_DataIn5[24:31];       
	  default: WB_word5L2[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord5_L2)        
     begin                                       
	case(writeBufMuxSelBit1[22])                    
	  1'b0: dp_Reg_DataIn5[16:23] = SDQ_SDP_mux[16:23];   
	  1'b1: dp_Reg_DataIn5[16:23] = fillBufWord5_L2[16:23];   
	  default: dp_Reg_DataIn5[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte2_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word5L2[16:23] <= WB_word5L2[16:23];                
	  1'b1: WB_word5L2[16:23] <= dp_Reg_DataIn5[16:23];       
	  default: WB_word5L2[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord5_L2)        
     begin                                       
	case(writeBufMuxSelBit1[21])                    
	  1'b0: dp_Reg_DataIn5[8:15] = SDQ_SDP_mux[8:15];   
	  1'b1: dp_Reg_DataIn5[8:15] = fillBufWord5_L2[8:15];   
	  default: dp_Reg_DataIn5[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte1_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word5L2[8:15] <= WB_word5L2[8:15];                
	  1'b1: WB_word5L2[8:15] <= dp_Reg_DataIn5[8:15];       
	  default: WB_word5L2[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord5_L2)        
     begin                                       
	case(writeBufMuxSelBit1[20])                    
	  1'b0: dp_Reg_DataIn5[0:7] = SDQ_SDP_mux[0:7];   
	  1'b1: dp_Reg_DataIn5[0:7] = fillBufWord5_L2[0:7];   
	  default: dp_Reg_DataIn5[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte0_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word5L2[0:7] <= WB_word5L2[0:7];                
	  1'b1: WB_word5L2[0:7] <= dp_Reg_DataIn5[0:7];       
	  default: WB_word5L2[0:7] <= 8'bx;  
	endcase                             
     end  

   reg [0:31] dp_Reg_DataIn4;
   
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord4_L2)        
     begin                                       
	case(writeBufMuxSelBit1[19])                    
	  1'b0: dp_Reg_DataIn4[24:31] = SDQ_SDP_mux[24:31];   
	  1'b1: dp_Reg_DataIn4[24:31] = fillBufWord4_L2[24:31];   
	  default: dp_Reg_DataIn4[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte3_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word4L2[24:31] <= WB_word4L2[24:31];                
	  1'b1: WB_word4L2[24:31] <= dp_Reg_DataIn4[24:31];       
	  default: WB_word4L2[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord4_L2)        
     begin                                       
	case(writeBufMuxSelBit1[18])                    
	  1'b0: dp_Reg_DataIn4[16:23] = SDQ_SDP_mux[16:23];   
	  1'b1: dp_Reg_DataIn4[16:23] = fillBufWord4_L2[16:23];   
	  default: dp_Reg_DataIn4[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte2_E1 & writeBufLoTagByte23_E2)                        
	  1'b0: WB_word4L2[16:23] <= WB_word4L2[16:23];                
	  1'b1: WB_word4L2[16:23] <= dp_Reg_DataIn4[16:23];       
	  default: WB_word4L2[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord4_L2)        
     begin                                       
	case(writeBufMuxSelBit1[17])                    
	  1'b0: dp_Reg_DataIn4[8:15] = SDQ_SDP_mux[8:15];   
	  1'b1: dp_Reg_DataIn4[8:15] = fillBufWord4_L2[8:15];   
	  default: dp_Reg_DataIn4[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte1_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word4L2[8:15] <= WB_word4L2[8:15];                
	  1'b1: WB_word4L2[8:15] <= dp_Reg_DataIn4[8:15];       
	  default: WB_word4L2[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or SDQ_SDP_mux or fillBufWord4_L2)        
     begin                                       
	case(writeBufMuxSelBit1[16])                    
	  1'b0: dp_Reg_DataIn4[0:7] = SDQ_SDP_mux[0:7];   
	  1'b1: dp_Reg_DataIn4[0:7] = fillBufWord4_L2[0:7];   
	  default: dp_Reg_DataIn4[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(WB_loByte0_E1 & writeBufLoTagByte01_E2)                        
	  1'b0: WB_word4L2[0:7] <= WB_word4L2[0:7];                
	  1'b1: WB_word4L2[0:7] <= dp_Reg_DataIn4[0:7];       
	  default: WB_word4L2[0:7] <= 8'bx;  
	endcase                             
     end  

   reg [0:31]  dp_Reg_DataIn3;
   reg [0:31]  WB_word3L2n;
   wire [0:31] WB_word3L2;
   assign      WB_word3L2 = ~WB_word3L2n;
      
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord3_L2 or WB_word7L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[15]})                    
	  2'b00: dp_Reg_DataIn3[24:31] = SDQ_SDP_mux[24:31];   
	  2'b01: dp_Reg_DataIn3[24:31] = fillBufWord3_L2[24:31];   
	  2'b10: dp_Reg_DataIn3[24:31] = 8'b0;   
	  2'b11: dp_Reg_DataIn3[24:31] = WB_word7L2[24:31];   
	  default: dp_Reg_DataIn3[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte3_E1 & writeBufHiByte23_E2[3])                        
	  1'b0: WB_word3L2n[24:31] <= WB_word3L2n[24:31];                
	  1'b1: WB_word3L2n[24:31] <= dp_Reg_DataIn3[24:31];       
	  default: WB_word3L2n[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord3_L2 or WB_word7L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[14]})                    
	  2'b00: dp_Reg_DataIn3[16:23] = SDQ_SDP_mux[16:23];   
	  2'b01: dp_Reg_DataIn3[16:23] = fillBufWord3_L2[16:23];   
	  2'b10: dp_Reg_DataIn3[16:23] = 8'b0;   
	  2'b11: dp_Reg_DataIn3[16:23] = WB_word7L2[16:23];   
	  default: dp_Reg_DataIn3[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte2_E1 & writeBufHiByte23_E2[3])                        
	  1'b0: WB_word3L2n[16:23] <= WB_word3L2n[16:23];                
	  1'b1: WB_word3L2n[16:23] <= dp_Reg_DataIn3[16:23];       
	  default: WB_word3L2n[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord3_L2 or WB_word7L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[13]})                    
	  2'b00: dp_Reg_DataIn3[8:15] = SDQ_SDP_mux[8:15];   
	  2'b01: dp_Reg_DataIn3[8:15] = fillBufWord3_L2[8:15];   
	  2'b10: dp_Reg_DataIn3[8:15] = 8'b0;   
	  2'b11: dp_Reg_DataIn3[8:15] = WB_word7L2[8:15];   
	  default: dp_Reg_DataIn3[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte1_E1 & writeBufHiByte01_E2[3])                        
	  1'b0: WB_word3L2n[8:15] <= WB_word3L2n[8:15];                
	  1'b1: WB_word3L2n[8:15] <= dp_Reg_DataIn3[8:15];       
	  default: WB_word3L2n[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord3_L2 or WB_word7L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[12]})                    
	  2'b00: dp_Reg_DataIn3[0:7] = SDQ_SDP_mux[0:7];   
	  2'b01: dp_Reg_DataIn3[0:7] = fillBufWord3_L2[0:7];   
	  2'b10: dp_Reg_DataIn3[0:7] = 8'b0;   
	  2'b11: dp_Reg_DataIn3[0:7] = WB_word7L2[0:7];   
	  default: dp_Reg_DataIn3[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte0_E1 & writeBufHiByte01_E2[3])                        
	  1'b0: WB_word3L2n[0:7] <= WB_word3L2n[0:7];                
	  1'b1: WB_word3L2n[0:7] <= dp_Reg_DataIn3[0:7];       
	  default: WB_word3L2n[0:7] <= 8'bx;  
	endcase                             
     end  
 
   reg [0:31]  dp_Reg_DataIn2;
   reg [0:31]  WB_word2L2n;
   wire [0:31] WB_word2L2;
   assign      WB_word2L2 = ~WB_word2L2n;
      
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord2_L2 or WB_word6L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[11]})                    
	  2'b00: dp_Reg_DataIn2[24:31] = SDQ_SDP_mux[24:31];   
	  2'b01: dp_Reg_DataIn2[24:31] = fillBufWord2_L2[24:31];   
	  2'b10: dp_Reg_DataIn2[24:31] = 8'b0;   
	  2'b11: dp_Reg_DataIn2[24:31] = WB_word6L2[24:31];   
	  default: dp_Reg_DataIn2[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte3_E1 & writeBufHiByte23_E2[2])                        
	  1'b0: WB_word2L2n[24:31] <= WB_word2L2n[24:31];                
	  1'b1: WB_word2L2n[24:31] <= dp_Reg_DataIn2[24:31];       
	  default: WB_word2L2n[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord2_L2 or WB_word6L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[10]})                    
	  2'b00: dp_Reg_DataIn2[16:23] = SDQ_SDP_mux[16:23];   
	  2'b01: dp_Reg_DataIn2[16:23] = fillBufWord2_L2[16:23];   
	  2'b10: dp_Reg_DataIn2[16:23] = 8'b0;   
	  2'b11: dp_Reg_DataIn2[16:23] = WB_word6L2[16:23];   
	  default: dp_Reg_DataIn2[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte2_E1 & writeBufHiByte23_E2[2])                        
	  1'b0: WB_word2L2n[16:23] <= WB_word2L2n[16:23];                
	  1'b1: WB_word2L2n[16:23] <= dp_Reg_DataIn2[16:23];       
	  default: WB_word2L2n[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord2_L2 or WB_word6L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[9]})                    
	  2'b00: dp_Reg_DataIn2[8:15] = SDQ_SDP_mux[8:15];   
	  2'b01: dp_Reg_DataIn2[8:15] = fillBufWord2_L2[8:15];   
	  2'b10: dp_Reg_DataIn2[8:15] = 8'b0;   
	  2'b11: dp_Reg_DataIn2[8:15] = WB_word6L2[8:15];   
	  default: dp_Reg_DataIn2[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte1_E1 & writeBufHiByte01_E2[2])                        
	  1'b0: WB_word2L2n[8:15] <= WB_word2L2n[8:15];                
	  1'b1: WB_word2L2n[8:15] <= dp_Reg_DataIn2[8:15];       
	  default: WB_word2L2n[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord2_L2 or WB_word6L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[8]})                    
	  2'b00: dp_Reg_DataIn2[0:7] = SDQ_SDP_mux[0:7];   
	  2'b01: dp_Reg_DataIn2[0:7] = fillBufWord2_L2[0:7];   
	  2'b10: dp_Reg_DataIn2[0:7] = 8'b0;   
	  2'b11: dp_Reg_DataIn2[0:7] = WB_word6L2[0:7];   
	  default: dp_Reg_DataIn2[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte0_E1 & writeBufHiByte01_E2[2])                        
	  1'b0: WB_word2L2n[0:7] <= WB_word2L2n[0:7];                
	  1'b1: WB_word2L2n[0:7] <= dp_Reg_DataIn2[0:7];       
	  default: WB_word2L2n[0:7] <= 8'bx;  
	endcase                             
     end  
 
   reg [0:31]  dp_Reg_DataIn1;
   reg [0:31]  WB_word1L2n;
   wire [0:31] WB_word1L2;
   assign      WB_word1L2 = ~WB_word1L2n;
      
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord1_L2 or WB_word5L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[7]})                    
	  2'b00: dp_Reg_DataIn1[24:31] = SDQ_SDP_mux[24:31];   
	  2'b01: dp_Reg_DataIn1[24:31] = fillBufWord1_L2[24:31];   
	  2'b10: dp_Reg_DataIn1[24:31] = 8'b0;   
	  2'b11: dp_Reg_DataIn1[24:31] = WB_word5L2[24:31];   
	  default: dp_Reg_DataIn1[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte3_E1 & writeBufHiByte23_E2[1])                        
	  1'b0: WB_word1L2n[24:31] <= WB_word1L2n[24:31];                
	  1'b1: WB_word1L2n[24:31] <= dp_Reg_DataIn1[24:31];       
	  default: WB_word1L2n[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord1_L2 or WB_word5L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[6]})                    
	  2'b00: dp_Reg_DataIn1[16:23] = SDQ_SDP_mux[16:23];   
	  2'b01: dp_Reg_DataIn1[16:23] = fillBufWord1_L2[16:23];   
	  2'b10: dp_Reg_DataIn1[16:23] = 8'b0;   
	  2'b11: dp_Reg_DataIn1[16:23] = WB_word5L2[16:23];   
	  default: dp_Reg_DataIn1[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte2_E1 & writeBufHiByte23_E2[1])                        
	  1'b0: WB_word1L2n[16:23] <= WB_word1L2n[16:23];                
	  1'b1: WB_word1L2n[16:23] <= dp_Reg_DataIn1[16:23];       
	  default: WB_word1L2n[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord1_L2 or WB_word5L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[5]})                    
	  2'b00: dp_Reg_DataIn1[8:15] = SDQ_SDP_mux[8:15];   
	  2'b01: dp_Reg_DataIn1[8:15] = fillBufWord1_L2[8:15];   
	  2'b10: dp_Reg_DataIn1[8:15] = 8'b0;   
	  2'b11: dp_Reg_DataIn1[8:15] = WB_word5L2[8:15];   
	  default: dp_Reg_DataIn1[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte1_E1 & writeBufHiByte01_E2[1])                        
	  1'b0: WB_word1L2n[8:15] <= WB_word1L2n[8:15];                
	  1'b1: WB_word1L2n[8:15] <= dp_Reg_DataIn1[8:15];       
	  default: WB_word1L2n[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord1_L2 or WB_word5L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[4]})                    
	  2'b00: dp_Reg_DataIn1[0:7] = SDQ_SDP_mux[0:7];   
	  2'b01: dp_Reg_DataIn1[0:7] = fillBufWord1_L2[0:7];   
	  2'b10: dp_Reg_DataIn1[0:7] = 8'b0;   
	  2'b11: dp_Reg_DataIn1[0:7] = WB_word5L2[0:7];   
	  default: dp_Reg_DataIn1[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH    always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte0_E1 & writeBufHiByte01_E2[1])                        
	  1'b0: WB_word1L2n[0:7] <= WB_word1L2n[0:7];                
	  1'b1: WB_word1L2n[0:7] <= dp_Reg_DataIn1[0:7];       
	  default: WB_word1L2n[0:7] <= 8'bx;  
	endcase                             
     end  
 
   reg [0:31]  dp_Reg_DataIn0;
   reg [0:31]  WB_word0L2n;
   wire [0:31] WB_word0L2;
   assign      WB_word0L2 = ~WB_word0L2n;
      
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord0_L2 or WB_word4L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[3]})                    
	  2'b00: dp_Reg_DataIn0[24:31] = SDQ_SDP_mux[24:31];   
	  2'b01: dp_Reg_DataIn0[24:31] = fillBufWord0_L2[24:31];   
	  2'b10: dp_Reg_DataIn0[24:31] = 8'b0;   
	  2'b11: dp_Reg_DataIn0[24:31] = WB_word4L2[24:31];   
	  default: dp_Reg_DataIn0[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte3_E1 & writeBufHiByte23_E2[0])                        
	  1'b0: WB_word0L2n[24:31] <= WB_word0L2n[24:31];                
	  1'b1: WB_word0L2n[24:31] <= dp_Reg_DataIn0[24:31];       
	  default: WB_word0L2n[24:31] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte23Bit0 or SDQ_SDP_mux or fillBufWord0_L2 or WB_word4L2)        
     begin                                       
	case({writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[2]})                    
	  2'b00: dp_Reg_DataIn0[16:23] = SDQ_SDP_mux[16:23];   
	  2'b01: dp_Reg_DataIn0[16:23] = fillBufWord0_L2[16:23];   
	  2'b10: dp_Reg_DataIn0[16:23] = 8'b0;   
	  2'b11: dp_Reg_DataIn0[16:23] = WB_word4L2[16:23];   
	  default: dp_Reg_DataIn0[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte2_E1 & writeBufHiByte23_E2[0])                        
	  1'b0: WB_word0L2n[16:23] <= WB_word0L2n[16:23];                
	  1'b1: WB_word0L2n[16:23] <= dp_Reg_DataIn0[16:23];       
	  default: WB_word0L2n[16:23] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord0_L2 or WB_word4L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[1]})                    
	  2'b00: dp_Reg_DataIn0[8:15] = SDQ_SDP_mux[8:15];   
	  2'b01: dp_Reg_DataIn0[8:15] = fillBufWord0_L2[8:15];   
	  2'b10: dp_Reg_DataIn0[8:15] = 8'b0;   
	  2'b11: dp_Reg_DataIn0[8:15] = WB_word4L2[8:15];   
	  default: dp_Reg_DataIn0[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte1_E1 & writeBufHiByte01_E2[0])                        
	  1'b0: WB_word0L2n[8:15] <= WB_word0L2n[8:15];                
	  1'b1: WB_word0L2n[8:15] <= dp_Reg_DataIn0[8:15];       
	  default: WB_word0L2n[8:15] <= 8'bx;  
	endcase                             
     end  
 
   always @(writeBufMuxSelBit1 or writeBufMuxSelByte01Bit0 or SDQ_SDP_mux or fillBufWord0_L2 or WB_word4L2)        
     begin                                       
	case({writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[0]})                    
	  2'b00: dp_Reg_DataIn0[0:7] = SDQ_SDP_mux[0:7];   
	  2'b01: dp_Reg_DataIn0[0:7] = fillBufWord0_L2[0:7];   
	  2'b10: dp_Reg_DataIn0[0:7] = 8'b0;   
	  2'b11: dp_Reg_DataIn0[0:7] = WB_word4L2[0:7];   
	  default: dp_Reg_DataIn0[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)      
   always @(negedge CB)      
     begin                                       
	case(WB_hiByte0_E1 & writeBufHiByte01_E2[0])                        
	  1'b0: WB_word0L2n[0:7] <= WB_word0L2n[0:7];                
	  1'b1: WB_word0L2n[0:7] <= dp_Reg_DataIn0[0:7];       
	  default: WB_word0L2n[0:7] <= 8'bx;  
	endcase                             
     end  
 
//--------- start ---------------
// rgoldiez - added these registers for parity to mimic the data registers above
//
// NOTE:  The following latches could be grouped better to minimize overhead circuits.  But, it would not be
//        as straightforward logically.  Every 4th latch uses the same enables and selects (in the first sixteen
//        and then the second sixteen).  At this point I am going to leave things as is (w/o minimizations) and that
//        can be done later if there is space problem in PD.
   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword7Byte3
   reg dp_regDCU_parityWBword7Byte3_regL2;
   reg dp_regDCU_parityWBword7Byte3_DataIn;
   wire dp_regDCU_parityWBword7Byte3_D0,dp_regDCU_parityWBword7Byte3_D1; 
   wire dp_regDCU_parityWBword7Byte3_SD; 
   wire dp_regDCU_parityWBword7Byte3_E1; 
   assign p_WBlo_L2[15] = dp_regDCU_parityWBword7Byte3_regL2;     	
   assign dp_regDCU_parityWBword7Byte3_E1 = WB_loByte3_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword7Byte3_SD = writeBufMuxSelBit1[31];    	
   assign dp_regDCU_parityWBword7Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword7Byte3_D1 = p_fillBuf_L2[31];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword7Byte3_D0 or dp_regDCU_parityWBword7Byte3_D1 or dp_regDCU_parityWBword7Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte3_SD)			
     1'b0: dp_regDCU_parityWBword7Byte3_DataIn = dp_regDCU_parityWBword7Byte3_D0;	
     1'b1: dp_regDCU_parityWBword7Byte3_DataIn = dp_regDCU_parityWBword7Byte3_D1;	
      default: dp_regDCU_parityWBword7Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte3_E1)			
     1'b0: dp_regDCU_parityWBword7Byte3_regL2 <= dp_regDCU_parityWBword7Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword7Byte3_regL2 <= dp_regDCU_parityWBword7Byte3_DataIn;	
      default: dp_regDCU_parityWBword7Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword7Byte2
   reg dp_regDCU_parityWBword7Byte2_regL2;
   reg dp_regDCU_parityWBword7Byte2_DataIn;
   wire dp_regDCU_parityWBword7Byte2_D0,dp_regDCU_parityWBword7Byte2_D1; 
   wire dp_regDCU_parityWBword7Byte2_SD; 
   wire dp_regDCU_parityWBword7Byte2_E1; 
   assign p_WBlo_L2[14] = dp_regDCU_parityWBword7Byte2_regL2;     	
   assign dp_regDCU_parityWBword7Byte2_E1 = WB_loByte2_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword7Byte2_SD = writeBufMuxSelBit1[30];    	
   assign dp_regDCU_parityWBword7Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword7Byte2_D1 = p_fillBuf_L2[30];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword7Byte2_D0 or dp_regDCU_parityWBword7Byte2_D1 or dp_regDCU_parityWBword7Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte2_SD)			
     1'b0: dp_regDCU_parityWBword7Byte2_DataIn = dp_regDCU_parityWBword7Byte2_D0;	
     1'b1: dp_regDCU_parityWBword7Byte2_DataIn = dp_regDCU_parityWBword7Byte2_D1;	
      default: dp_regDCU_parityWBword7Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte2_E1)			
     1'b0: dp_regDCU_parityWBword7Byte2_regL2 <= dp_regDCU_parityWBword7Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword7Byte2_regL2 <= dp_regDCU_parityWBword7Byte2_DataIn;	
      default: dp_regDCU_parityWBword7Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword7Byte1
   reg dp_regDCU_parityWBword7Byte1_regL2;
   reg dp_regDCU_parityWBword7Byte1_DataIn;
   wire dp_regDCU_parityWBword7Byte1_D0,dp_regDCU_parityWBword7Byte1_D1; 
   wire dp_regDCU_parityWBword7Byte1_SD; 
   wire dp_regDCU_parityWBword7Byte1_E1; 
   assign p_WBlo_L2[13] = dp_regDCU_parityWBword7Byte1_regL2;     	
   assign dp_regDCU_parityWBword7Byte1_E1 = WB_loByte1_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword7Byte1_SD = writeBufMuxSelBit1[29];    	
   assign dp_regDCU_parityWBword7Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword7Byte1_D1 = p_fillBuf_L2[29];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword7Byte1_D0 or dp_regDCU_parityWBword7Byte1_D1 or dp_regDCU_parityWBword7Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte1_SD)			
     1'b0: dp_regDCU_parityWBword7Byte1_DataIn = dp_regDCU_parityWBword7Byte1_D0;	
     1'b1: dp_regDCU_parityWBword7Byte1_DataIn = dp_regDCU_parityWBword7Byte1_D1;	
      default: dp_regDCU_parityWBword7Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte1_E1)			
     1'b0: dp_regDCU_parityWBword7Byte1_regL2 <= dp_regDCU_parityWBword7Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword7Byte1_regL2 <= dp_regDCU_parityWBword7Byte1_DataIn;	
      default: dp_regDCU_parityWBword7Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword7Byte0
   reg dp_regDCU_parityWBword7Byte0_regL2;
   reg dp_regDCU_parityWBword7Byte0_DataIn;
   wire dp_regDCU_parityWBword7Byte0_D0,dp_regDCU_parityWBword7Byte0_D1; 
   wire dp_regDCU_parityWBword7Byte0_SD; 
   wire dp_regDCU_parityWBword7Byte0_E1; 
   assign p_WBlo_L2[12] = dp_regDCU_parityWBword7Byte0_regL2;     	
   assign dp_regDCU_parityWBword7Byte0_E1 = WB_loByte0_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword7Byte0_SD = writeBufMuxSelBit1[28];    	
   assign dp_regDCU_parityWBword7Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword7Byte0_D1 = p_fillBuf_L2[28];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword7Byte0_D0 or dp_regDCU_parityWBword7Byte0_D1 or dp_regDCU_parityWBword7Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte0_SD)			
     1'b0: dp_regDCU_parityWBword7Byte0_DataIn = dp_regDCU_parityWBword7Byte0_D0;	
     1'b1: dp_regDCU_parityWBword7Byte0_DataIn = dp_regDCU_parityWBword7Byte0_D1;	
      default: dp_regDCU_parityWBword7Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword7Byte0_E1)			
     1'b0: dp_regDCU_parityWBword7Byte0_regL2 <= dp_regDCU_parityWBword7Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword7Byte0_regL2 <= dp_regDCU_parityWBword7Byte0_DataIn;	
      default: dp_regDCU_parityWBword7Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword6Byte3
   reg dp_regDCU_parityWBword6Byte3_regL2;
   reg dp_regDCU_parityWBword6Byte3_DataIn;
   wire dp_regDCU_parityWBword6Byte3_D0,dp_regDCU_parityWBword6Byte3_D1; 
   wire dp_regDCU_parityWBword6Byte3_SD; 
   wire dp_regDCU_parityWBword6Byte3_E1; 
   assign p_WBlo_L2[11] = dp_regDCU_parityWBword6Byte3_regL2;     	
   assign dp_regDCU_parityWBword6Byte3_E1 = WB_loByte3_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword6Byte3_SD = writeBufMuxSelBit1[27];    	
   assign dp_regDCU_parityWBword6Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword6Byte3_D1 = p_fillBuf_L2[27];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword6Byte3_D0 or dp_regDCU_parityWBword6Byte3_D1 or dp_regDCU_parityWBword6Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte3_SD)			
     1'b0: dp_regDCU_parityWBword6Byte3_DataIn = dp_regDCU_parityWBword6Byte3_D0;	
     1'b1: dp_regDCU_parityWBword6Byte3_DataIn = dp_regDCU_parityWBword6Byte3_D1;	
      default: dp_regDCU_parityWBword6Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte3_E1)			
     1'b0: dp_regDCU_parityWBword6Byte3_regL2 <= dp_regDCU_parityWBword6Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword6Byte3_regL2 <= dp_regDCU_parityWBword6Byte3_DataIn;	
      default: dp_regDCU_parityWBword6Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword6Byte2
   reg dp_regDCU_parityWBword6Byte2_regL2;
   reg dp_regDCU_parityWBword6Byte2_DataIn;
   wire dp_regDCU_parityWBword6Byte2_D0,dp_regDCU_parityWBword6Byte2_D1; 
   wire dp_regDCU_parityWBword6Byte2_SD; 
   wire dp_regDCU_parityWBword6Byte2_E1; 
   assign p_WBlo_L2[10] = dp_regDCU_parityWBword6Byte2_regL2;     	
   assign dp_regDCU_parityWBword6Byte2_E1 = WB_loByte2_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword6Byte2_SD = writeBufMuxSelBit1[26];    	
   assign dp_regDCU_parityWBword6Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword6Byte2_D1 = p_fillBuf_L2[26];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword6Byte2_D0 or dp_regDCU_parityWBword6Byte2_D1 or dp_regDCU_parityWBword6Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte2_SD)			
     1'b0: dp_regDCU_parityWBword6Byte2_DataIn = dp_regDCU_parityWBword6Byte2_D0;	
     1'b1: dp_regDCU_parityWBword6Byte2_DataIn = dp_regDCU_parityWBword6Byte2_D1;	
      default: dp_regDCU_parityWBword6Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte2_E1)			
     1'b0: dp_regDCU_parityWBword6Byte2_regL2 <= dp_regDCU_parityWBword6Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword6Byte2_regL2 <= dp_regDCU_parityWBword6Byte2_DataIn;	
      default: dp_regDCU_parityWBword6Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword6Byte1
   reg dp_regDCU_parityWBword6Byte1_regL2;
   reg dp_regDCU_parityWBword6Byte1_DataIn;
   wire dp_regDCU_parityWBword6Byte1_D0,dp_regDCU_parityWBword6Byte1_D1; 
   wire dp_regDCU_parityWBword6Byte1_SD; 
   wire dp_regDCU_parityWBword6Byte1_E1; 
   assign p_WBlo_L2[9] = dp_regDCU_parityWBword6Byte1_regL2;     	
   assign dp_regDCU_parityWBword6Byte1_E1 = WB_loByte1_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword6Byte1_SD = writeBufMuxSelBit1[25];    	
   assign dp_regDCU_parityWBword6Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword6Byte1_D1 = p_fillBuf_L2[25];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword6Byte1_D0 or dp_regDCU_parityWBword6Byte1_D1 or dp_regDCU_parityWBword6Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte1_SD)			
     1'b0: dp_regDCU_parityWBword6Byte1_DataIn = dp_regDCU_parityWBword6Byte1_D0;	
     1'b1: dp_regDCU_parityWBword6Byte1_DataIn = dp_regDCU_parityWBword6Byte1_D1;	
      default: dp_regDCU_parityWBword6Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte1_E1)			
     1'b0: dp_regDCU_parityWBword6Byte1_regL2 <= dp_regDCU_parityWBword6Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword6Byte1_regL2 <= dp_regDCU_parityWBword6Byte1_DataIn;	
      default: dp_regDCU_parityWBword6Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword6Byte0
   reg dp_regDCU_parityWBword6Byte0_regL2;
   reg dp_regDCU_parityWBword6Byte0_DataIn;
   wire dp_regDCU_parityWBword6Byte0_D0,dp_regDCU_parityWBword6Byte0_D1; 
   wire dp_regDCU_parityWBword6Byte0_SD; 
   wire dp_regDCU_parityWBword6Byte0_E1; 
   assign p_WBlo_L2[8] = dp_regDCU_parityWBword6Byte0_regL2;     	
   assign dp_regDCU_parityWBword6Byte0_E1 = WB_loByte0_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword6Byte0_SD = writeBufMuxSelBit1[24];    	
   assign dp_regDCU_parityWBword6Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword6Byte0_D1 = p_fillBuf_L2[24];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword6Byte0_D0 or dp_regDCU_parityWBword6Byte0_D1 or dp_regDCU_parityWBword6Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte0_SD)			
     1'b0: dp_regDCU_parityWBword6Byte0_DataIn = dp_regDCU_parityWBword6Byte0_D0;	
     1'b1: dp_regDCU_parityWBword6Byte0_DataIn = dp_regDCU_parityWBword6Byte0_D1;	
      default: dp_regDCU_parityWBword6Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword6Byte0_E1)			
     1'b0: dp_regDCU_parityWBword6Byte0_regL2 <= dp_regDCU_parityWBword6Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword6Byte0_regL2 <= dp_regDCU_parityWBword6Byte0_DataIn;	
      default: dp_regDCU_parityWBword6Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword5Byte3
   reg dp_regDCU_parityWBword5Byte3_regL2;
   reg dp_regDCU_parityWBword5Byte3_DataIn;
   wire dp_regDCU_parityWBword5Byte3_D0,dp_regDCU_parityWBword5Byte3_D1; 
   wire dp_regDCU_parityWBword5Byte3_SD; 
   wire dp_regDCU_parityWBword5Byte3_E1; 
   assign p_WBlo_L2[7] = dp_regDCU_parityWBword5Byte3_regL2;     	
   assign dp_regDCU_parityWBword5Byte3_E1 = WB_loByte3_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword5Byte3_SD = writeBufMuxSelBit1[23];    	
   assign dp_regDCU_parityWBword5Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword5Byte3_D1 = p_fillBuf_L2[23];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword5Byte3_D0 or dp_regDCU_parityWBword5Byte3_D1 or dp_regDCU_parityWBword5Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte3_SD)			
     1'b0: dp_regDCU_parityWBword5Byte3_DataIn = dp_regDCU_parityWBword5Byte3_D0;	
     1'b1: dp_regDCU_parityWBword5Byte3_DataIn = dp_regDCU_parityWBword5Byte3_D1;	
      default: dp_regDCU_parityWBword5Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte3_E1)			
     1'b0: dp_regDCU_parityWBword5Byte3_regL2 <= dp_regDCU_parityWBword5Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword5Byte3_regL2 <= dp_regDCU_parityWBword5Byte3_DataIn;	
      default: dp_regDCU_parityWBword5Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword5Byte2
   reg dp_regDCU_parityWBword5Byte2_regL2;
   reg dp_regDCU_parityWBword5Byte2_DataIn;
   wire dp_regDCU_parityWBword5Byte2_D0,dp_regDCU_parityWBword5Byte2_D1; 
   wire dp_regDCU_parityWBword5Byte2_SD; 
   wire dp_regDCU_parityWBword5Byte2_E1; 
   assign p_WBlo_L2[6] = dp_regDCU_parityWBword5Byte2_regL2;     	
   assign dp_regDCU_parityWBword5Byte2_E1 = WB_loByte2_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword5Byte2_SD = writeBufMuxSelBit1[22];    	
   assign dp_regDCU_parityWBword5Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword5Byte2_D1 = p_fillBuf_L2[22];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword5Byte2_D0 or dp_regDCU_parityWBword5Byte2_D1 or dp_regDCU_parityWBword5Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte2_SD)			
     1'b0: dp_regDCU_parityWBword5Byte2_DataIn = dp_regDCU_parityWBword5Byte2_D0;	
     1'b1: dp_regDCU_parityWBword5Byte2_DataIn = dp_regDCU_parityWBword5Byte2_D1;	
      default: dp_regDCU_parityWBword5Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte2_E1)			
     1'b0: dp_regDCU_parityWBword5Byte2_regL2 <= dp_regDCU_parityWBword5Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword5Byte2_regL2 <= dp_regDCU_parityWBword5Byte2_DataIn;	
      default: dp_regDCU_parityWBword5Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword5Byte1
   reg dp_regDCU_parityWBword5Byte1_regL2;
   reg dp_regDCU_parityWBword5Byte1_DataIn;
   wire dp_regDCU_parityWBword5Byte1_D0,dp_regDCU_parityWBword5Byte1_D1; 
   wire dp_regDCU_parityWBword5Byte1_SD; 
   wire dp_regDCU_parityWBword5Byte1_E1; 
   assign p_WBlo_L2[5] = dp_regDCU_parityWBword5Byte1_regL2;     	
   assign dp_regDCU_parityWBword5Byte1_E1 = WB_loByte1_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword5Byte1_SD = writeBufMuxSelBit1[21];    	
   assign dp_regDCU_parityWBword5Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword5Byte1_D1 = p_fillBuf_L2[21];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword5Byte1_D0 or dp_regDCU_parityWBword5Byte1_D1 or dp_regDCU_parityWBword5Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte1_SD)			
     1'b0: dp_regDCU_parityWBword5Byte1_DataIn = dp_regDCU_parityWBword5Byte1_D0;	
     1'b1: dp_regDCU_parityWBword5Byte1_DataIn = dp_regDCU_parityWBword5Byte1_D1;	
      default: dp_regDCU_parityWBword5Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte1_E1)			
     1'b0: dp_regDCU_parityWBword5Byte1_regL2 <= dp_regDCU_parityWBword5Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword5Byte1_regL2 <= dp_regDCU_parityWBword5Byte1_DataIn;	
      default: dp_regDCU_parityWBword5Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword5Byte0
   reg dp_regDCU_parityWBword5Byte0_regL2;
   reg dp_regDCU_parityWBword5Byte0_DataIn;
   wire dp_regDCU_parityWBword5Byte0_D0,dp_regDCU_parityWBword5Byte0_D1; 
   wire dp_regDCU_parityWBword5Byte0_SD; 
   wire dp_regDCU_parityWBword5Byte0_E1; 
   assign p_WBlo_L2[4] = dp_regDCU_parityWBword5Byte0_regL2;     	
   assign dp_regDCU_parityWBword5Byte0_E1 = WB_loByte0_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword5Byte0_SD = writeBufMuxSelBit1[20];    	
   assign dp_regDCU_parityWBword5Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword5Byte0_D1 = p_fillBuf_L2[20];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword5Byte0_D0 or dp_regDCU_parityWBword5Byte0_D1 or dp_regDCU_parityWBword5Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte0_SD)			
     1'b0: dp_regDCU_parityWBword5Byte0_DataIn = dp_regDCU_parityWBword5Byte0_D0;	
     1'b1: dp_regDCU_parityWBword5Byte0_DataIn = dp_regDCU_parityWBword5Byte0_D1;	
      default: dp_regDCU_parityWBword5Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword5Byte0_E1)			
     1'b0: dp_regDCU_parityWBword5Byte0_regL2 <= dp_regDCU_parityWBword5Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword5Byte0_regL2 <= dp_regDCU_parityWBword5Byte0_DataIn;	
      default: dp_regDCU_parityWBword5Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword4Byte3
   reg dp_regDCU_parityWBword4Byte3_regL2;
   reg dp_regDCU_parityWBword4Byte3_DataIn;
   wire dp_regDCU_parityWBword4Byte3_D0,dp_regDCU_parityWBword4Byte3_D1; 
   wire dp_regDCU_parityWBword4Byte3_SD; 
   wire dp_regDCU_parityWBword4Byte3_E1; 
   assign p_WBlo_L2[3] = dp_regDCU_parityWBword4Byte3_regL2;     	
   assign dp_regDCU_parityWBword4Byte3_E1 = WB_loByte3_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword4Byte3_SD = writeBufMuxSelBit1[19];    	
   assign dp_regDCU_parityWBword4Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword4Byte3_D1 = p_fillBuf_L2[19];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword4Byte3_D0 or dp_regDCU_parityWBword4Byte3_D1 or dp_regDCU_parityWBword4Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte3_SD)			
     1'b0: dp_regDCU_parityWBword4Byte3_DataIn = dp_regDCU_parityWBword4Byte3_D0;	
     1'b1: dp_regDCU_parityWBword4Byte3_DataIn = dp_regDCU_parityWBword4Byte3_D1;	
      default: dp_regDCU_parityWBword4Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte3_E1)			
     1'b0: dp_regDCU_parityWBword4Byte3_regL2 <= dp_regDCU_parityWBword4Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword4Byte3_regL2 <= dp_regDCU_parityWBword4Byte3_DataIn;	
      default: dp_regDCU_parityWBword4Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword4Byte2
   reg dp_regDCU_parityWBword4Byte2_regL2;
   reg dp_regDCU_parityWBword4Byte2_DataIn;
   wire dp_regDCU_parityWBword4Byte2_D0,dp_regDCU_parityWBword4Byte2_D1; 
   wire dp_regDCU_parityWBword4Byte2_SD; 
   wire dp_regDCU_parityWBword4Byte2_E1; 
   assign p_WBlo_L2[2] = dp_regDCU_parityWBword4Byte2_regL2;     	
   assign dp_regDCU_parityWBword4Byte2_E1 = WB_loByte2_E1 & writeBufLoTagByte23_E2;     
   assign dp_regDCU_parityWBword4Byte2_SD = writeBufMuxSelBit1[18];    	
   assign dp_regDCU_parityWBword4Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword4Byte2_D1 = p_fillBuf_L2[18];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword4Byte2_D0 or dp_regDCU_parityWBword4Byte2_D1 or dp_regDCU_parityWBword4Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte2_SD)			
     1'b0: dp_regDCU_parityWBword4Byte2_DataIn = dp_regDCU_parityWBword4Byte2_D0;	
     1'b1: dp_regDCU_parityWBword4Byte2_DataIn = dp_regDCU_parityWBword4Byte2_D1;	
      default: dp_regDCU_parityWBword4Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte2_E1)			
     1'b0: dp_regDCU_parityWBword4Byte2_regL2 <= dp_regDCU_parityWBword4Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword4Byte2_regL2 <= dp_regDCU_parityWBword4Byte2_DataIn;	
      default: dp_regDCU_parityWBword4Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword4Byte1
   reg dp_regDCU_parityWBword4Byte1_regL2;
   reg dp_regDCU_parityWBword4Byte1_DataIn;
   wire dp_regDCU_parityWBword4Byte1_D0,dp_regDCU_parityWBword4Byte1_D1; 
   wire dp_regDCU_parityWBword4Byte1_SD; 
   wire dp_regDCU_parityWBword4Byte1_E1; 
   assign p_WBlo_L2[1] = dp_regDCU_parityWBword4Byte1_regL2;     	
   assign dp_regDCU_parityWBword4Byte1_E1 = WB_loByte1_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword4Byte1_SD = writeBufMuxSelBit1[17];    	
   assign dp_regDCU_parityWBword4Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword4Byte1_D1 = p_fillBuf_L2[17];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword4Byte1_D0 or dp_regDCU_parityWBword4Byte1_D1 or dp_regDCU_parityWBword4Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte1_SD)			
     1'b0: dp_regDCU_parityWBword4Byte1_DataIn = dp_regDCU_parityWBword4Byte1_D0;	
     1'b1: dp_regDCU_parityWBword4Byte1_DataIn = dp_regDCU_parityWBword4Byte1_D1;	
      default: dp_regDCU_parityWBword4Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte1_E1)			
     1'b0: dp_regDCU_parityWBword4Byte1_regL2 <= dp_regDCU_parityWBword4Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword4Byte1_regL2 <= dp_regDCU_parityWBword4Byte1_DataIn;	
      default: dp_regDCU_parityWBword4Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityWBword4Byte0
   reg dp_regDCU_parityWBword4Byte0_regL2;
   reg dp_regDCU_parityWBword4Byte0_DataIn;
   wire dp_regDCU_parityWBword4Byte0_D0,dp_regDCU_parityWBword4Byte0_D1; 
   wire dp_regDCU_parityWBword4Byte0_SD; 
   wire dp_regDCU_parityWBword4Byte0_E1; 
   assign p_WBlo_L2[0] = dp_regDCU_parityWBword4Byte0_regL2;     	
   assign dp_regDCU_parityWBword4Byte0_E1 = WB_loByte0_E1 & writeBufLoTagByte01_E2;     
   assign dp_regDCU_parityWBword4Byte0_SD = writeBufMuxSelBit1[16];    	
   assign dp_regDCU_parityWBword4Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword4Byte0_D1 = p_fillBuf_L2[16];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword4Byte0_D0 or dp_regDCU_parityWBword4Byte0_D1 or dp_regDCU_parityWBword4Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte0_SD)			
     1'b0: dp_regDCU_parityWBword4Byte0_DataIn = dp_regDCU_parityWBword4Byte0_D0;	
     1'b1: dp_regDCU_parityWBword4Byte0_DataIn = dp_regDCU_parityWBword4Byte0_D1;	
      default: dp_regDCU_parityWBword4Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword4Byte0_E1)			
     1'b0: dp_regDCU_parityWBword4Byte0_regL2 <= dp_regDCU_parityWBword4Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword4Byte0_regL2 <= dp_regDCU_parityWBword4Byte0_DataIn;	
      default: dp_regDCU_parityWBword4Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword3Byte3
   reg dp_regDCU_parityWBword3Byte3_regL2;
   reg dp_regDCU_parityWBword3Byte3_DataIn;
   wire dp_regDCU_parityWBword3Byte3_D0,dp_regDCU_parityWBword3Byte3_D1; 
   wire dp_regDCU_parityWBword3Byte3_D2; 
   wire dp_regDCU_parityWBword3Byte3_D3; 
   wire [0:1] dp_regDCU_parityWBword3Byte3_SD; 
   wire dp_regDCU_parityWBword3Byte3_E1; 
   wire dp_regDCU_parityWBword3Byte3_E2; 
   assign p_WBhi_L2[15] = dp_regDCU_parityWBword3Byte3_regL2;     	
   assign dp_regDCU_parityWBword3Byte3_E1 = WB_hiByte3_E1;     
   assign dp_regDCU_parityWBword3Byte3_E2 = writeBufHiByte23_E2[3];     
   assign dp_regDCU_parityWBword3Byte3_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[15]};    	
   assign dp_regDCU_parityWBword3Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword3Byte3_D1 = p_fillBuf_L2[15];    	
   assign dp_regDCU_parityWBword3Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword3Byte3_D3 = p_WBlo_L2[15];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword3Byte3_D0 or dp_regDCU_parityWBword3Byte3_D1 or dp_regDCU_parityWBword3Byte3_D2 or dp_regDCU_parityWBword3Byte3_D3 or dp_regDCU_parityWBword3Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte3_SD)			
     2'b00: dp_regDCU_parityWBword3Byte3_DataIn = dp_regDCU_parityWBword3Byte3_D0;	
     2'b01: dp_regDCU_parityWBword3Byte3_DataIn = dp_regDCU_parityWBword3Byte3_D1;	
     2'b10: dp_regDCU_parityWBword3Byte3_DataIn = dp_regDCU_parityWBword3Byte3_D2;	
     2'b11: dp_regDCU_parityWBword3Byte3_DataIn = dp_regDCU_parityWBword3Byte3_D3;	
      default: dp_regDCU_parityWBword3Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte3_E1 & dp_regDCU_parityWBword3Byte3_E2)		
     1'b0: dp_regDCU_parityWBword3Byte3_regL2 <= dp_regDCU_parityWBword3Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword3Byte3_regL2 <= dp_regDCU_parityWBword3Byte3_DataIn;	
      default: dp_regDCU_parityWBword3Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword3Byte2
   reg dp_regDCU_parityWBword3Byte2_regL2;
   reg dp_regDCU_parityWBword3Byte2_DataIn;
   wire dp_regDCU_parityWBword3Byte2_D0,dp_regDCU_parityWBword3Byte2_D1; 
   wire dp_regDCU_parityWBword3Byte2_D2; 
   wire dp_regDCU_parityWBword3Byte2_D3; 
   wire [0:1] dp_regDCU_parityWBword3Byte2_SD; 
   wire dp_regDCU_parityWBword3Byte2_E1; 
   wire dp_regDCU_parityWBword3Byte2_E2; 
   assign p_WBhi_L2[14] = dp_regDCU_parityWBword3Byte2_regL2;     	
   assign dp_regDCU_parityWBword3Byte2_E1 = WB_hiByte2_E1;     
   assign dp_regDCU_parityWBword3Byte2_E2 = writeBufHiByte23_E2[3];     
   assign dp_regDCU_parityWBword3Byte2_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[14]};    	
   assign dp_regDCU_parityWBword3Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword3Byte2_D1 = p_fillBuf_L2[14];    	
   assign dp_regDCU_parityWBword3Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword3Byte2_D3 = p_WBlo_L2[14];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword3Byte2_D0 or dp_regDCU_parityWBword3Byte2_D1 or dp_regDCU_parityWBword3Byte2_D2 or dp_regDCU_parityWBword3Byte2_D3 or dp_regDCU_parityWBword3Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte2_SD)			
     2'b00: dp_regDCU_parityWBword3Byte2_DataIn = dp_regDCU_parityWBword3Byte2_D0;	
     2'b01: dp_regDCU_parityWBword3Byte2_DataIn = dp_regDCU_parityWBword3Byte2_D1;	
     2'b10: dp_regDCU_parityWBword3Byte2_DataIn = dp_regDCU_parityWBword3Byte2_D2;	
     2'b11: dp_regDCU_parityWBword3Byte2_DataIn = dp_regDCU_parityWBword3Byte2_D3;	
      default: dp_regDCU_parityWBword3Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte2_E1 & dp_regDCU_parityWBword3Byte2_E2)		
     1'b0: dp_regDCU_parityWBword3Byte2_regL2 <= dp_regDCU_parityWBword3Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword3Byte2_regL2 <= dp_regDCU_parityWBword3Byte2_DataIn;	
      default: dp_regDCU_parityWBword3Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword3Byte1
   reg dp_regDCU_parityWBword3Byte1_regL2;
   reg dp_regDCU_parityWBword3Byte1_DataIn;
   wire dp_regDCU_parityWBword3Byte1_D0,dp_regDCU_parityWBword3Byte1_D1; 
   wire dp_regDCU_parityWBword3Byte1_D2; 
   wire dp_regDCU_parityWBword3Byte1_D3; 
   wire [0:1] dp_regDCU_parityWBword3Byte1_SD; 
   wire dp_regDCU_parityWBword3Byte1_E1; 
   wire dp_regDCU_parityWBword3Byte1_E2; 
   assign p_WBhi_L2[13] = dp_regDCU_parityWBword3Byte1_regL2;     	
   assign dp_regDCU_parityWBword3Byte1_E1 = WB_hiByte1_E1;     
   assign dp_regDCU_parityWBword3Byte1_E2 = writeBufHiByte01_E2[3];     
   assign dp_regDCU_parityWBword3Byte1_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[13]};    	
   assign dp_regDCU_parityWBword3Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword3Byte1_D1 = p_fillBuf_L2[13];    	
   assign dp_regDCU_parityWBword3Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword3Byte1_D3 = p_WBlo_L2[13];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword3Byte1_D0 or dp_regDCU_parityWBword3Byte1_D1 or dp_regDCU_parityWBword3Byte1_D2 or dp_regDCU_parityWBword3Byte1_D3 or dp_regDCU_parityWBword3Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte1_SD)			
     2'b00: dp_regDCU_parityWBword3Byte1_DataIn = dp_regDCU_parityWBword3Byte1_D0;	
     2'b01: dp_regDCU_parityWBword3Byte1_DataIn = dp_regDCU_parityWBword3Byte1_D1;	
     2'b10: dp_regDCU_parityWBword3Byte1_DataIn = dp_regDCU_parityWBword3Byte1_D2;	
     2'b11: dp_regDCU_parityWBword3Byte1_DataIn = dp_regDCU_parityWBword3Byte1_D3;	
      default: dp_regDCU_parityWBword3Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte1_E1 & dp_regDCU_parityWBword3Byte1_E2)		
     1'b0: dp_regDCU_parityWBword3Byte1_regL2 <= dp_regDCU_parityWBword3Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword3Byte1_regL2 <= dp_regDCU_parityWBword3Byte1_DataIn;	
      default: dp_regDCU_parityWBword3Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword3Byte0
   reg dp_regDCU_parityWBword3Byte0_regL2;
   reg dp_regDCU_parityWBword3Byte0_DataIn;
   wire dp_regDCU_parityWBword3Byte0_D0,dp_regDCU_parityWBword3Byte0_D1; 
   wire dp_regDCU_parityWBword3Byte0_D2; 
   wire dp_regDCU_parityWBword3Byte0_D3; 
   wire [0:1] dp_regDCU_parityWBword3Byte0_SD; 
   wire dp_regDCU_parityWBword3Byte0_E1; 
   wire dp_regDCU_parityWBword3Byte0_E2; 
   assign p_WBhi_L2[12] = dp_regDCU_parityWBword3Byte0_regL2;     	
   assign dp_regDCU_parityWBword3Byte0_E1 = WB_hiByte0_E1;     
   assign dp_regDCU_parityWBword3Byte0_E2 = writeBufHiByte01_E2[3];     
   assign dp_regDCU_parityWBword3Byte0_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[12]};    	
   assign dp_regDCU_parityWBword3Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword3Byte0_D1 = p_fillBuf_L2[12];    	
   assign dp_regDCU_parityWBword3Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword3Byte0_D3 = p_WBlo_L2[12];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword3Byte0_D0 or dp_regDCU_parityWBword3Byte0_D1 or dp_regDCU_parityWBword3Byte0_D2 or dp_regDCU_parityWBword3Byte0_D3 or dp_regDCU_parityWBword3Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte0_SD)			
     2'b00: dp_regDCU_parityWBword3Byte0_DataIn = dp_regDCU_parityWBword3Byte0_D0;	
     2'b01: dp_regDCU_parityWBword3Byte0_DataIn = dp_regDCU_parityWBword3Byte0_D1;	
     2'b10: dp_regDCU_parityWBword3Byte0_DataIn = dp_regDCU_parityWBword3Byte0_D2;	
     2'b11: dp_regDCU_parityWBword3Byte0_DataIn = dp_regDCU_parityWBword3Byte0_D3;	
      default: dp_regDCU_parityWBword3Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword3Byte0_E1 & dp_regDCU_parityWBword3Byte0_E2)		
     1'b0: dp_regDCU_parityWBword3Byte0_regL2 <= dp_regDCU_parityWBword3Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword3Byte0_regL2 <= dp_regDCU_parityWBword3Byte0_DataIn;	
      default: dp_regDCU_parityWBword3Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword2Byte3
   reg dp_regDCU_parityWBword2Byte3_regL2;
   reg dp_regDCU_parityWBword2Byte3_DataIn;
   wire dp_regDCU_parityWBword2Byte3_D0,dp_regDCU_parityWBword2Byte3_D1; 
   wire dp_regDCU_parityWBword2Byte3_D2; 
   wire dp_regDCU_parityWBword2Byte3_D3; 
   wire [0:1] dp_regDCU_parityWBword2Byte3_SD; 
   wire dp_regDCU_parityWBword2Byte3_E1; 
   wire dp_regDCU_parityWBword2Byte3_E2; 
   assign p_WBhi_L2[11] = dp_regDCU_parityWBword2Byte3_regL2;     	
   assign dp_regDCU_parityWBword2Byte3_E1 = WB_hiByte3_E1;     
   assign dp_regDCU_parityWBword2Byte3_E2 = writeBufHiByte23_E2[2];     
   assign dp_regDCU_parityWBword2Byte3_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[11]};    	
   assign dp_regDCU_parityWBword2Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword2Byte3_D1 = p_fillBuf_L2[11];    	
   assign dp_regDCU_parityWBword2Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword2Byte3_D3 = p_WBlo_L2[11];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword2Byte3_D0 or dp_regDCU_parityWBword2Byte3_D1 or dp_regDCU_parityWBword2Byte3_D2 or dp_regDCU_parityWBword2Byte3_D3 or dp_regDCU_parityWBword2Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte3_SD)			
     2'b00: dp_regDCU_parityWBword2Byte3_DataIn = dp_regDCU_parityWBword2Byte3_D0;	
     2'b01: dp_regDCU_parityWBword2Byte3_DataIn = dp_regDCU_parityWBword2Byte3_D1;	
     2'b10: dp_regDCU_parityWBword2Byte3_DataIn = dp_regDCU_parityWBword2Byte3_D2;	
     2'b11: dp_regDCU_parityWBword2Byte3_DataIn = dp_regDCU_parityWBword2Byte3_D3;	
      default: dp_regDCU_parityWBword2Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte3_E1 & dp_regDCU_parityWBword2Byte3_E2)		
     1'b0: dp_regDCU_parityWBword2Byte3_regL2 <= dp_regDCU_parityWBword2Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword2Byte3_regL2 <= dp_regDCU_parityWBword2Byte3_DataIn;	
      default: dp_regDCU_parityWBword2Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword2Byte2
   reg dp_regDCU_parityWBword2Byte2_regL2;
   reg dp_regDCU_parityWBword2Byte2_DataIn;
   wire dp_regDCU_parityWBword2Byte2_D0,dp_regDCU_parityWBword2Byte2_D1; 
   wire dp_regDCU_parityWBword2Byte2_D2; 
   wire dp_regDCU_parityWBword2Byte2_D3; 
   wire [0:1] dp_regDCU_parityWBword2Byte2_SD; 
   wire dp_regDCU_parityWBword2Byte2_E1; 
   wire dp_regDCU_parityWBword2Byte2_E2; 
   assign p_WBhi_L2[10] = dp_regDCU_parityWBword2Byte2_regL2;     	
   assign dp_regDCU_parityWBword2Byte2_E1 = WB_hiByte2_E1;     
   assign dp_regDCU_parityWBword2Byte2_E2 = writeBufHiByte23_E2[2];     
   assign dp_regDCU_parityWBword2Byte2_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[10]};    	
   assign dp_regDCU_parityWBword2Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword2Byte2_D1 = p_fillBuf_L2[10];    	
   assign dp_regDCU_parityWBword2Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword2Byte2_D3 = p_WBlo_L2[10];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword2Byte2_D0 or dp_regDCU_parityWBword2Byte2_D1 or dp_regDCU_parityWBword2Byte2_D2 or dp_regDCU_parityWBword2Byte2_D3 or dp_regDCU_parityWBword2Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte2_SD)			
     2'b00: dp_regDCU_parityWBword2Byte2_DataIn = dp_regDCU_parityWBword2Byte2_D0;	
     2'b01: dp_regDCU_parityWBword2Byte2_DataIn = dp_regDCU_parityWBword2Byte2_D1;	
     2'b10: dp_regDCU_parityWBword2Byte2_DataIn = dp_regDCU_parityWBword2Byte2_D2;	
     2'b11: dp_regDCU_parityWBword2Byte2_DataIn = dp_regDCU_parityWBword2Byte2_D3;	
      default: dp_regDCU_parityWBword2Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte2_E1 & dp_regDCU_parityWBword2Byte2_E2)		
     1'b0: dp_regDCU_parityWBword2Byte2_regL2 <= dp_regDCU_parityWBword2Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword2Byte2_regL2 <= dp_regDCU_parityWBword2Byte2_DataIn;	
      default: dp_regDCU_parityWBword2Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword2Byte1
   reg dp_regDCU_parityWBword2Byte1_regL2;
   reg dp_regDCU_parityWBword2Byte1_DataIn;
   wire dp_regDCU_parityWBword2Byte1_D0,dp_regDCU_parityWBword2Byte1_D1; 
   wire dp_regDCU_parityWBword2Byte1_D2; 
   wire dp_regDCU_parityWBword2Byte1_D3; 
   wire [0:1] dp_regDCU_parityWBword2Byte1_SD; 
   wire dp_regDCU_parityWBword2Byte1_E1; 
   wire dp_regDCU_parityWBword2Byte1_E2; 
   assign p_WBhi_L2[9] = dp_regDCU_parityWBword2Byte1_regL2;     	
   assign dp_regDCU_parityWBword2Byte1_E1 = WB_hiByte1_E1;     
   assign dp_regDCU_parityWBword2Byte1_E2 = writeBufHiByte01_E2[2];     
   assign dp_regDCU_parityWBword2Byte1_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[9]};    	
   assign dp_regDCU_parityWBword2Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword2Byte1_D1 = p_fillBuf_L2[9];    	
   assign dp_regDCU_parityWBword2Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword2Byte1_D3 = p_WBlo_L2[9];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword2Byte1_D0 or dp_regDCU_parityWBword2Byte1_D1 or dp_regDCU_parityWBword2Byte1_D2 or dp_regDCU_parityWBword2Byte1_D3 or dp_regDCU_parityWBword2Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte1_SD)			
     2'b00: dp_regDCU_parityWBword2Byte1_DataIn = dp_regDCU_parityWBword2Byte1_D0;	
     2'b01: dp_regDCU_parityWBword2Byte1_DataIn = dp_regDCU_parityWBword2Byte1_D1;	
     2'b10: dp_regDCU_parityWBword2Byte1_DataIn = dp_regDCU_parityWBword2Byte1_D2;	
     2'b11: dp_regDCU_parityWBword2Byte1_DataIn = dp_regDCU_parityWBword2Byte1_D3;	
      default: dp_regDCU_parityWBword2Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte1_E1 & dp_regDCU_parityWBword2Byte1_E2)		
     1'b0: dp_regDCU_parityWBword2Byte1_regL2 <= dp_regDCU_parityWBword2Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword2Byte1_regL2 <= dp_regDCU_parityWBword2Byte1_DataIn;	
      default: dp_regDCU_parityWBword2Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword2Byte0
   reg dp_regDCU_parityWBword2Byte0_regL2;
   reg dp_regDCU_parityWBword2Byte0_DataIn;
   wire dp_regDCU_parityWBword2Byte0_D0,dp_regDCU_parityWBword2Byte0_D1; 
   wire dp_regDCU_parityWBword2Byte0_D2; 
   wire dp_regDCU_parityWBword2Byte0_D3; 
   wire [0:1] dp_regDCU_parityWBword2Byte0_SD; 
   wire dp_regDCU_parityWBword2Byte0_E1; 
   wire dp_regDCU_parityWBword2Byte0_E2; 
   assign p_WBhi_L2[8] = dp_regDCU_parityWBword2Byte0_regL2;     	
   assign dp_regDCU_parityWBword2Byte0_E1 = WB_hiByte0_E1;     
   assign dp_regDCU_parityWBword2Byte0_E2 = writeBufHiByte01_E2[2];     
   assign dp_regDCU_parityWBword2Byte0_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[8]};    	
   assign dp_regDCU_parityWBword2Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword2Byte0_D1 = p_fillBuf_L2[8];    	
   assign dp_regDCU_parityWBword2Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword2Byte0_D3 = p_WBlo_L2[8];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword2Byte0_D0 or dp_regDCU_parityWBword2Byte0_D1 or dp_regDCU_parityWBword2Byte0_D2 or dp_regDCU_parityWBword2Byte0_D3 or dp_regDCU_parityWBword2Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte0_SD)			
     2'b00: dp_regDCU_parityWBword2Byte0_DataIn = dp_regDCU_parityWBword2Byte0_D0;	
     2'b01: dp_regDCU_parityWBword2Byte0_DataIn = dp_regDCU_parityWBword2Byte0_D1;	
     2'b10: dp_regDCU_parityWBword2Byte0_DataIn = dp_regDCU_parityWBword2Byte0_D2;	
     2'b11: dp_regDCU_parityWBword2Byte0_DataIn = dp_regDCU_parityWBword2Byte0_D3;	
      default: dp_regDCU_parityWBword2Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword2Byte0_E1 & dp_regDCU_parityWBword2Byte0_E2)		
     1'b0: dp_regDCU_parityWBword2Byte0_regL2 <= dp_regDCU_parityWBword2Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword2Byte0_regL2 <= dp_regDCU_parityWBword2Byte0_DataIn;	
      default: dp_regDCU_parityWBword2Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword1Byte3
   reg dp_regDCU_parityWBword1Byte3_regL2;
   reg dp_regDCU_parityWBword1Byte3_DataIn;
   wire dp_regDCU_parityWBword1Byte3_D0,dp_regDCU_parityWBword1Byte3_D1; 
   wire dp_regDCU_parityWBword1Byte3_D2; 
   wire dp_regDCU_parityWBword1Byte3_D3; 
   wire [0:1] dp_regDCU_parityWBword1Byte3_SD; 
   wire dp_regDCU_parityWBword1Byte3_E1; 
   wire dp_regDCU_parityWBword1Byte3_E2; 
   assign p_WBhi_L2[7] = dp_regDCU_parityWBword1Byte3_regL2;     	
   assign dp_regDCU_parityWBword1Byte3_E1 = WB_hiByte3_E1;     
   assign dp_regDCU_parityWBword1Byte3_E2 = writeBufHiByte23_E2[1];     
   assign dp_regDCU_parityWBword1Byte3_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[7]};    	
   assign dp_regDCU_parityWBword1Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword1Byte3_D1 = p_fillBuf_L2[7];    	
   assign dp_regDCU_parityWBword1Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword1Byte3_D3 = p_WBlo_L2[7];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword1Byte3_D0 or dp_regDCU_parityWBword1Byte3_D1 or dp_regDCU_parityWBword1Byte3_D2 or dp_regDCU_parityWBword1Byte3_D3 or dp_regDCU_parityWBword1Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte3_SD)			
     2'b00: dp_regDCU_parityWBword1Byte3_DataIn = dp_regDCU_parityWBword1Byte3_D0;	
     2'b01: dp_regDCU_parityWBword1Byte3_DataIn = dp_regDCU_parityWBword1Byte3_D1;	
     2'b10: dp_regDCU_parityWBword1Byte3_DataIn = dp_regDCU_parityWBword1Byte3_D2;	
     2'b11: dp_regDCU_parityWBword1Byte3_DataIn = dp_regDCU_parityWBword1Byte3_D3;	
      default: dp_regDCU_parityWBword1Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte3_E1 & dp_regDCU_parityWBword1Byte3_E2)		
     1'b0: dp_regDCU_parityWBword1Byte3_regL2 <= dp_regDCU_parityWBword1Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword1Byte3_regL2 <= dp_regDCU_parityWBword1Byte3_DataIn;	
      default: dp_regDCU_parityWBword1Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword1Byte2
   reg dp_regDCU_parityWBword1Byte2_regL2;
   reg dp_regDCU_parityWBword1Byte2_DataIn;
   wire dp_regDCU_parityWBword1Byte2_D0,dp_regDCU_parityWBword1Byte2_D1; 
   wire dp_regDCU_parityWBword1Byte2_D2; 
   wire dp_regDCU_parityWBword1Byte2_D3; 
   wire [0:1] dp_regDCU_parityWBword1Byte2_SD; 
   wire dp_regDCU_parityWBword1Byte2_E1; 
   wire dp_regDCU_parityWBword1Byte2_E2; 
   assign p_WBhi_L2[6] = dp_regDCU_parityWBword1Byte2_regL2;     	
   assign dp_regDCU_parityWBword1Byte2_E1 = WB_hiByte2_E1;     
   assign dp_regDCU_parityWBword1Byte2_E2 = writeBufHiByte23_E2[1];     
   assign dp_regDCU_parityWBword1Byte2_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[6]};    	
   assign dp_regDCU_parityWBword1Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword1Byte2_D1 = p_fillBuf_L2[6];    	
   assign dp_regDCU_parityWBword1Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword1Byte2_D3 = p_WBlo_L2[6];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword1Byte2_D0 or dp_regDCU_parityWBword1Byte2_D1 or dp_regDCU_parityWBword1Byte2_D2 or dp_regDCU_parityWBword1Byte2_D3 or dp_regDCU_parityWBword1Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte2_SD)			
     2'b00: dp_regDCU_parityWBword1Byte2_DataIn = dp_regDCU_parityWBword1Byte2_D0;	
     2'b01: dp_regDCU_parityWBword1Byte2_DataIn = dp_regDCU_parityWBword1Byte2_D1;	
     2'b10: dp_regDCU_parityWBword1Byte2_DataIn = dp_regDCU_parityWBword1Byte2_D2;	
     2'b11: dp_regDCU_parityWBword1Byte2_DataIn = dp_regDCU_parityWBword1Byte2_D3;	
      default: dp_regDCU_parityWBword1Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte2_E1 & dp_regDCU_parityWBword1Byte2_E2)		
     1'b0: dp_regDCU_parityWBword1Byte2_regL2 <= dp_regDCU_parityWBword1Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword1Byte2_regL2 <= dp_regDCU_parityWBword1Byte2_DataIn;	
      default: dp_regDCU_parityWBword1Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword1Byte1
   reg dp_regDCU_parityWBword1Byte1_regL2;
   reg dp_regDCU_parityWBword1Byte1_DataIn;
   wire dp_regDCU_parityWBword1Byte1_D0,dp_regDCU_parityWBword1Byte1_D1; 
   wire dp_regDCU_parityWBword1Byte1_D2; 
   wire dp_regDCU_parityWBword1Byte1_D3; 
   wire [0:1] dp_regDCU_parityWBword1Byte1_SD; 
   wire dp_regDCU_parityWBword1Byte1_E1; 
   wire dp_regDCU_parityWBword1Byte1_E2; 
   assign p_WBhi_L2[5] = dp_regDCU_parityWBword1Byte1_regL2;     	
   assign dp_regDCU_parityWBword1Byte1_E1 = WB_hiByte1_E1;     
   assign dp_regDCU_parityWBword1Byte1_E2 = writeBufHiByte01_E2[1];     
   assign dp_regDCU_parityWBword1Byte1_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[5]};    	
   assign dp_regDCU_parityWBword1Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword1Byte1_D1 = p_fillBuf_L2[5];    	
   assign dp_regDCU_parityWBword1Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword1Byte1_D3 = p_WBlo_L2[5];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword1Byte1_D0 or dp_regDCU_parityWBword1Byte1_D1 or dp_regDCU_parityWBword1Byte1_D2 or dp_regDCU_parityWBword1Byte1_D3 or dp_regDCU_parityWBword1Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte1_SD)			
     2'b00: dp_regDCU_parityWBword1Byte1_DataIn = dp_regDCU_parityWBword1Byte1_D0;	
     2'b01: dp_regDCU_parityWBword1Byte1_DataIn = dp_regDCU_parityWBword1Byte1_D1;	
     2'b10: dp_regDCU_parityWBword1Byte1_DataIn = dp_regDCU_parityWBword1Byte1_D2;	
     2'b11: dp_regDCU_parityWBword1Byte1_DataIn = dp_regDCU_parityWBword1Byte1_D3;	
      default: dp_regDCU_parityWBword1Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte1_E1 & dp_regDCU_parityWBword1Byte1_E2)		
     1'b0: dp_regDCU_parityWBword1Byte1_regL2 <= dp_regDCU_parityWBword1Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword1Byte1_regL2 <= dp_regDCU_parityWBword1Byte1_DataIn;	
      default: dp_regDCU_parityWBword1Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword1Byte0
   reg dp_regDCU_parityWBword1Byte0_regL2;
   reg dp_regDCU_parityWBword1Byte0_DataIn;
   wire dp_regDCU_parityWBword1Byte0_D0,dp_regDCU_parityWBword1Byte0_D1; 
   wire dp_regDCU_parityWBword1Byte0_D2; 
   wire dp_regDCU_parityWBword1Byte0_D3; 
   wire [0:1] dp_regDCU_parityWBword1Byte0_SD; 
   wire dp_regDCU_parityWBword1Byte0_E1; 
   wire dp_regDCU_parityWBword1Byte0_E2; 
   assign p_WBhi_L2[4] = dp_regDCU_parityWBword1Byte0_regL2;     	
   assign dp_regDCU_parityWBword1Byte0_E1 = WB_hiByte0_E1;     
   assign dp_regDCU_parityWBword1Byte0_E2 = writeBufHiByte01_E2[1];     
   assign dp_regDCU_parityWBword1Byte0_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[4]};    	
   assign dp_regDCU_parityWBword1Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword1Byte0_D1 = p_fillBuf_L2[4];    	
   assign dp_regDCU_parityWBword1Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword1Byte0_D3 = p_WBlo_L2[4];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword1Byte0_D0 or dp_regDCU_parityWBword1Byte0_D1 or dp_regDCU_parityWBword1Byte0_D2 or dp_regDCU_parityWBword1Byte0_D3 or dp_regDCU_parityWBword1Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte0_SD)			
     2'b00: dp_regDCU_parityWBword1Byte0_DataIn = dp_regDCU_parityWBword1Byte0_D0;	
     2'b01: dp_regDCU_parityWBword1Byte0_DataIn = dp_regDCU_parityWBword1Byte0_D1;	
     2'b10: dp_regDCU_parityWBword1Byte0_DataIn = dp_regDCU_parityWBword1Byte0_D2;	
     2'b11: dp_regDCU_parityWBword1Byte0_DataIn = dp_regDCU_parityWBword1Byte0_D3;	
      default: dp_regDCU_parityWBword1Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword1Byte0_E1 & dp_regDCU_parityWBword1Byte0_E2)		
     1'b0: dp_regDCU_parityWBword1Byte0_regL2 <= dp_regDCU_parityWBword1Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword1Byte0_regL2 <= dp_regDCU_parityWBword1Byte0_DataIn;	
      default: dp_regDCU_parityWBword1Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword0Byte3
   reg dp_regDCU_parityWBword0Byte3_regL2;
   reg dp_regDCU_parityWBword0Byte3_DataIn;
   wire dp_regDCU_parityWBword0Byte3_D0,dp_regDCU_parityWBword0Byte3_D1; 
   wire dp_regDCU_parityWBword0Byte3_D2; 
   wire dp_regDCU_parityWBword0Byte3_D3; 
   wire [0:1] dp_regDCU_parityWBword0Byte3_SD; 
   wire dp_regDCU_parityWBword0Byte3_E1; 
   wire dp_regDCU_parityWBword0Byte3_E2; 
   assign p_WBhi_L2[3] = dp_regDCU_parityWBword0Byte3_regL2;     	
   assign dp_regDCU_parityWBword0Byte3_E1 = WB_hiByte3_E1;     
   assign dp_regDCU_parityWBword0Byte3_E2 = writeBufHiByte23_E2[0];     
   assign dp_regDCU_parityWBword0Byte3_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[3]};    	
   assign dp_regDCU_parityWBword0Byte3_D0 = p_SDQ_SDP_mux[3];    	
   assign dp_regDCU_parityWBword0Byte3_D1 = p_fillBuf_L2[3];    	
   assign dp_regDCU_parityWBword0Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword0Byte3_D3 = p_WBlo_L2[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword0Byte3_D0 or dp_regDCU_parityWBword0Byte3_D1 or dp_regDCU_parityWBword0Byte3_D2 or dp_regDCU_parityWBword0Byte3_D3 or dp_regDCU_parityWBword0Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte3_SD)			
     2'b00: dp_regDCU_parityWBword0Byte3_DataIn = dp_regDCU_parityWBword0Byte3_D0;	
     2'b01: dp_regDCU_parityWBword0Byte3_DataIn = dp_regDCU_parityWBword0Byte3_D1;	
     2'b10: dp_regDCU_parityWBword0Byte3_DataIn = dp_regDCU_parityWBword0Byte3_D2;	
     2'b11: dp_regDCU_parityWBword0Byte3_DataIn = dp_regDCU_parityWBword0Byte3_D3;	
      default: dp_regDCU_parityWBword0Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte3_E1 & dp_regDCU_parityWBword0Byte3_E2)		
     1'b0: dp_regDCU_parityWBword0Byte3_regL2 <= dp_regDCU_parityWBword0Byte3_regL2;		
     1'b1: dp_regDCU_parityWBword0Byte3_regL2 <= dp_regDCU_parityWBword0Byte3_DataIn;	
      default: dp_regDCU_parityWBword0Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword0Byte2
   reg dp_regDCU_parityWBword0Byte2_regL2;
   reg dp_regDCU_parityWBword0Byte2_DataIn;
   wire dp_regDCU_parityWBword0Byte2_D0,dp_regDCU_parityWBword0Byte2_D1; 
   wire dp_regDCU_parityWBword0Byte2_D2; 
   wire dp_regDCU_parityWBword0Byte2_D3; 
   wire [0:1] dp_regDCU_parityWBword0Byte2_SD; 
   wire dp_regDCU_parityWBword0Byte2_E1; 
   wire dp_regDCU_parityWBword0Byte2_E2; 
   assign p_WBhi_L2[2] = dp_regDCU_parityWBword0Byte2_regL2;     	
   assign dp_regDCU_parityWBword0Byte2_E1 = WB_hiByte2_E1;     
   assign dp_regDCU_parityWBword0Byte2_E2 = writeBufHiByte23_E2[0];     
   assign dp_regDCU_parityWBword0Byte2_SD = {writeBufMuxSelByte23Bit0, writeBufMuxSelBit1[2]};    	
   assign dp_regDCU_parityWBword0Byte2_D0 = p_SDQ_SDP_mux[2];    	
   assign dp_regDCU_parityWBword0Byte2_D1 = p_fillBuf_L2[2];    	
   assign dp_regDCU_parityWBword0Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword0Byte2_D3 = p_WBlo_L2[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword0Byte2_D0 or dp_regDCU_parityWBword0Byte2_D1 or dp_regDCU_parityWBword0Byte2_D2 or dp_regDCU_parityWBword0Byte2_D3 or dp_regDCU_parityWBword0Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte2_SD)			
     2'b00: dp_regDCU_parityWBword0Byte2_DataIn = dp_regDCU_parityWBword0Byte2_D0;	
     2'b01: dp_regDCU_parityWBword0Byte2_DataIn = dp_regDCU_parityWBword0Byte2_D1;	
     2'b10: dp_regDCU_parityWBword0Byte2_DataIn = dp_regDCU_parityWBword0Byte2_D2;	
     2'b11: dp_regDCU_parityWBword0Byte2_DataIn = dp_regDCU_parityWBword0Byte2_D3;	
      default: dp_regDCU_parityWBword0Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte2_E1 & dp_regDCU_parityWBword0Byte2_E2)		
     1'b0: dp_regDCU_parityWBword0Byte2_regL2 <= dp_regDCU_parityWBword0Byte2_regL2;		
     1'b1: dp_regDCU_parityWBword0Byte2_regL2 <= dp_regDCU_parityWBword0Byte2_DataIn;	
      default: dp_regDCU_parityWBword0Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword0Byte1
   reg dp_regDCU_parityWBword0Byte1_regL2;
   reg dp_regDCU_parityWBword0Byte1_DataIn;
   wire dp_regDCU_parityWBword0Byte1_D0,dp_regDCU_parityWBword0Byte1_D1; 
   wire dp_regDCU_parityWBword0Byte1_D2; 
   wire dp_regDCU_parityWBword0Byte1_D3; 
   wire [0:1] dp_regDCU_parityWBword0Byte1_SD; 
   wire dp_regDCU_parityWBword0Byte1_E1; 
   wire dp_regDCU_parityWBword0Byte1_E2; 
   assign p_WBhi_L2[1] = dp_regDCU_parityWBword0Byte1_regL2;     	
   assign dp_regDCU_parityWBword0Byte1_E1 = WB_hiByte1_E1;     
   assign dp_regDCU_parityWBword0Byte1_E2 = writeBufHiByte01_E2[0];     
   assign dp_regDCU_parityWBword0Byte1_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[1]};    	
   assign dp_regDCU_parityWBword0Byte1_D0 = p_SDQ_SDP_mux[1];    	
   assign dp_regDCU_parityWBword0Byte1_D1 = p_fillBuf_L2[1];    	
   assign dp_regDCU_parityWBword0Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword0Byte1_D3 = p_WBlo_L2[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword0Byte1_D0 or dp_regDCU_parityWBword0Byte1_D1 or dp_regDCU_parityWBword0Byte1_D2 or dp_regDCU_parityWBword0Byte1_D3 or dp_regDCU_parityWBword0Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte1_SD)			
     2'b00: dp_regDCU_parityWBword0Byte1_DataIn = dp_regDCU_parityWBword0Byte1_D0;	
     2'b01: dp_regDCU_parityWBword0Byte1_DataIn = dp_regDCU_parityWBword0Byte1_D1;	
     2'b10: dp_regDCU_parityWBword0Byte1_DataIn = dp_regDCU_parityWBword0Byte1_D2;	
     2'b11: dp_regDCU_parityWBword0Byte1_DataIn = dp_regDCU_parityWBword0Byte1_D3;	
      default: dp_regDCU_parityWBword0Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte1_E1 & dp_regDCU_parityWBword0Byte1_E2)		
     1'b0: dp_regDCU_parityWBword0Byte1_regL2 <= dp_regDCU_parityWBword0Byte1_regL2;		
     1'b1: dp_regDCU_parityWBword0Byte1_regL2 <= dp_regDCU_parityWBword0Byte1_DataIn;	
      default: dp_regDCU_parityWBword0Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EEL2 dp_regDCU_parityWBword0Byte0
   reg dp_regDCU_parityWBword0Byte0_regL2;
   reg dp_regDCU_parityWBword0Byte0_DataIn;
   wire dp_regDCU_parityWBword0Byte0_D0,dp_regDCU_parityWBword0Byte0_D1; 
   wire dp_regDCU_parityWBword0Byte0_D2; 
   wire dp_regDCU_parityWBword0Byte0_D3; 
   wire [0:1] dp_regDCU_parityWBword0Byte0_SD; 
   wire dp_regDCU_parityWBword0Byte0_E1; 
   wire dp_regDCU_parityWBword0Byte0_E2; 
   assign p_WBhi_L2[0] = dp_regDCU_parityWBword0Byte0_regL2;     	
   assign dp_regDCU_parityWBword0Byte0_E1 = WB_hiByte0_E1;     
   assign dp_regDCU_parityWBword0Byte0_E2 = writeBufHiByte01_E2[0];     
   assign dp_regDCU_parityWBword0Byte0_SD = {writeBufMuxSelByte01Bit0, writeBufMuxSelBit1[0]};    	
   assign dp_regDCU_parityWBword0Byte0_D0 = p_SDQ_SDP_mux[0];    	
   assign dp_regDCU_parityWBword0Byte0_D1 = p_fillBuf_L2[0];    	
   assign dp_regDCU_parityWBword0Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityWBword0Byte0_D3 = p_WBlo_L2[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityWBword0Byte0_D0 or dp_regDCU_parityWBword0Byte0_D1 or dp_regDCU_parityWBword0Byte0_D2 or dp_regDCU_parityWBword0Byte0_D3 or dp_regDCU_parityWBword0Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte0_SD)			
     2'b00: dp_regDCU_parityWBword0Byte0_DataIn = dp_regDCU_parityWBword0Byte0_D0;	
     2'b01: dp_regDCU_parityWBword0Byte0_DataIn = dp_regDCU_parityWBword0Byte0_D1;	
     2'b10: dp_regDCU_parityWBword0Byte0_DataIn = dp_regDCU_parityWBword0Byte0_D2;	
     2'b11: dp_regDCU_parityWBword0Byte0_DataIn = dp_regDCU_parityWBword0Byte0_D3;	
      default: dp_regDCU_parityWBword0Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
//RDH   always @(posedge CB)  	
   always @(negedge CB)  	
    begin				  	
    case(dp_regDCU_parityWBword0Byte0_E1 & dp_regDCU_parityWBword0Byte0_E2)		
     1'b0: dp_regDCU_parityWBword0Byte0_regL2 <= dp_regDCU_parityWBword0Byte0_regL2;		
     1'b1: dp_regDCU_parityWBword0Byte0_regL2 <= dp_regDCU_parityWBword0Byte0_DataIn;	
      default: dp_regDCU_parityWBword0Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		


//--------- end -----------------

endmodule
