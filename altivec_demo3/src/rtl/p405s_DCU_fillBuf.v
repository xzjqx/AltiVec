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

module p405s_DCU_fillBuf( fillBufWord0_L2,
                          fillBufWord1_L2,
                          fillBufWord2_L2,
                          fillBufWord3_L2,
                          fillBufWord4_L2,
                          fillBufWord5_L2,
                          fillBufWord6_L2,
                          fillBufWord7_L2,
                          p_fillBuf_L2,
                          CB,
                          PLB_dcuReadDataBus,
                          SDQ_SDP_mux,
                          p_SDQ_SDP_mux,
                          fillBufMuxSel0,
                          fillBufMuxSel1,
                          fillBuf_E1,
                          fillBuf_E2
                         );

input  fillBuf_E1;

output [0:31]  fillBufWord4_L2;
output [0:31]  fillBufWord5_L2;
output [0:31]  fillBufWord6_L2;
output [0:31]  fillBufWord7_L2;
output [0:31]  fillBufWord2_L2;
output [0:31]  fillBufWord0_L2;
output [0:31]  fillBufWord1_L2;
output [0:31]  fillBufWord3_L2;

//--------- start ---------------
// rgoldiez - added for the output of the parity bits for the fill buffer

output [0:31]  p_fillBuf_L2;

//--------- end -----------------

input [0:7]  fillBuf_E2;
input [0:31]  SDQ_SDP_mux;
input [0:63]  PLB_dcuReadDataBus;
input CB;
input [0:31]  fillBufMuxSel1;
input [0:31]  fillBufMuxSel0;

//--------- start ---------------
// rgoldiez - added for the output of the parity bits for the fill buffer

input [0:3]   p_SDQ_SDP_mux;

//--------- end -----------------

// Buses in the design

wire  [0:7]  fillBuf_E2_invByte23;
wire  [0:7]  fillBuf_E2_invByte01;
wire  [0:7]  fillBuf_E2_byte01;
wire  [0:7]  fillBuf_E2_byte23;

//--------- start ---------------
// rgoldiez - added for the output of the parity generation on the PLB bus
wire  [0:7]  p_PLB_dcuReadDataBus;
//--------- end -----------------

// wires from instantiation
wire fillBufByte3_E1;
wire fillBufByte2_E1;
wire fillBufByte1_E1;
wire fillBufByte0_E1;

// Removed the module 'module dp_logDCU_FB_E2_inv4
// Removed the module 'module dp_logDCU_FB_E2_inv3
// Removed the module 'module dp_logDCU_FB_E2_inv2
// Removed the module 'module dp_logDCU_FB_E2_inv1
// Removed the module 'module dp_logDCU_FB_inv6
// Removed the module 'module dp_logDCU_FB_inv5
// Removed the module 'module dp_logDCU_FB_inv4
// Removed the module 'module dp_logDCU_FB_inv3
// Removed the module 'module dp_logDCU_FB_inv2
// Removed the module 'module dp_logDCU_FB_inv1

   wire E1_inv2;
   wire E1_inv1;
   
   assign fillBuf_E2_byte23[0:7] = ~fillBuf_E2_invByte23[0:7];
   assign fillBuf_E2_byte01[0:7] = ~fillBuf_E2_invByte01[0:7];
   assign fillBuf_E2_invByte23[0:7] = ~fillBuf_E2[0:7];
   assign fillBuf_E2_invByte01[0:7] = ~fillBuf_E2[0:7];
   assign fillBufByte3_E1 = ~E1_inv2;
   assign fillBufByte2_E1 = ~E1_inv2;
   assign fillBufByte1_E1 = ~E1_inv1;
   assign fillBufByte0_E1 = ~E1_inv1;
   assign E1_inv2 = ~fillBuf_E1;
   assign E1_inv1 = ~fillBuf_E1;

// Removed the module 'module dp_regDCU_FBword7Byte3
// Removed the module 'module dp_regDCU_FBword7Byte2
// Removed the module 'module dp_regDCU_FBword7Byte1
// Removed the module 'module dp_regDCU_FBword7Byte0
// Removed the module 'module dp_regDCU_FBword6Byte3
// Removed the module 'module dp_regDCU_FBword6Byte2
// Removed the module 'module dp_regDCU_FBword6Byte1
// Removed the module 'module dp_regDCU_FBword6Byte0
// Removed the module 'module dp_regDCU_FBword5Byte3
// Removed the module 'module dp_regDCU_FBword5Byte2
// Removed the module 'module dp_regDCU_FBword5Byte1
// Removed the module 'module dp_regDCU_FBword5Byte0
// Removed the module 'module dp_regDCU_FBword4Byte3
// Removed the module 'module dp_regDCU_FBword4Byte2
// Removed the module 'module dp_regDCU_FBword4Byte1
// Removed the module 'module dp_regDCU_FBword4Byte0
// Removed the module 'module dp_regDCU_FBword3Byte3
// Removed the module 'module dp_regDCU_FBword3Byte2
// Removed the module 'module dp_regDCU_FBword3Byte1
// Removed the module 'module dp_regDCU_FBword3Byte0
// Removed the module 'module dp_regDCU_FBword2Byte3
// Removed the module 'module dp_regDCU_FBword2Byte2
// Removed the module 'module dp_regDCU_FBword2Byte1
// Removed the module 'module dp_regDCU_FBword2Byte0
// Removed the module 'module dp_regDCU_FBword1Byte3
// Removed the module 'module dp_regDCU_FBword1Byte2
// Removed the module 'module dp_regDCU_FBword1Byte1
// Removed the module 'module dp_regDCU_FBword1Byte0
// Removed the module 'module dp_regDCU_FBword0Byte3
// Removed the module 'module dp_regDCU_FBword0Byte2
// Removed the module 'module dp_regDCU_FBword0Byte1
// Removed the module 'module dp_regDCU_FBword0Byte0

   reg [0:31] dp_Reg_DataIn7;
   reg  [0:31] fillBufWord7_L2_i;
   wire [0:31] fillBufWord7_L2;
   assign fillBufWord7_L2 = fillBufWord7_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord7_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[31],fillBufMuxSel1[31]})                    
	  2'b00: dp_Reg_DataIn7[24:31] = PLB_dcuReadDataBus[56:63];  
	  2'b01: dp_Reg_DataIn7[24:31] = fillBufWord7_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn7[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn7[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn7[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[7])                
	  1'b0: fillBufWord7_L2_i[24:31] <= fillBufWord7_L2_i[24:31];                
	  1'b1: fillBufWord7_L2_i[24:31] <= dp_Reg_DataIn7[24:31];       
	  default: fillBufWord7_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord7_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[30],fillBufMuxSel1[30]})                    
	  2'b00: dp_Reg_DataIn7[16:23] = PLB_dcuReadDataBus[48:55];  
	  2'b01: dp_Reg_DataIn7[16:23] = fillBufWord7_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn7[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn7[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn7[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[7])                
	  1'b0: fillBufWord7_L2_i[16:23] <= fillBufWord7_L2_i[16:23];                
	  1'b1: fillBufWord7_L2_i[16:23] <= dp_Reg_DataIn7[16:23];       
	  default: fillBufWord7_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord7_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[29],fillBufMuxSel1[29]})                    
	  2'b00: dp_Reg_DataIn7[8:15] = PLB_dcuReadDataBus[40:47];  
	  2'b01: dp_Reg_DataIn7[8:15] = fillBufWord7_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn7[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn7[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn7[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[7])                
	  1'b0: fillBufWord7_L2_i[8:15] <= fillBufWord7_L2_i[8:15];                
	  1'b1: fillBufWord7_L2_i[8:15] <= dp_Reg_DataIn7[8:15];       
	  default: fillBufWord7_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord7_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[28],fillBufMuxSel1[28]})                    
	  2'b00: dp_Reg_DataIn7[0:7] = PLB_dcuReadDataBus[32:39];  
	  2'b01: dp_Reg_DataIn7[0:7] = fillBufWord7_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn7[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn7[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn7[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[7])                
	  1'b0: fillBufWord7_L2_i[0:7] <= fillBufWord7_L2_i[0:7];                
	  1'b1: fillBufWord7_L2_i[0:7] <= dp_Reg_DataIn7[0:7];       
	  default: fillBufWord7_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31] dp_Reg_DataIn6;
   reg  [0:31] fillBufWord6_L2_i;
   wire [0:31] fillBufWord6_L2;
   assign fillBufWord6_L2 = fillBufWord6_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord6_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[27],fillBufMuxSel1[27]})                    
	  2'b00: dp_Reg_DataIn6[24:31] = PLB_dcuReadDataBus[24:31];  
	  2'b01: dp_Reg_DataIn6[24:31] = fillBufWord6_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn6[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn6[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn6[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[6])                
	  1'b0: fillBufWord6_L2_i[24:31] <= fillBufWord6_L2_i[24:31];                
	  1'b1: fillBufWord6_L2_i[24:31] <= dp_Reg_DataIn6[24:31];       
	  default: fillBufWord6_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord6_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[26],fillBufMuxSel1[26]})                    
	  2'b00: dp_Reg_DataIn6[16:23] = PLB_dcuReadDataBus[16:23];  
	  2'b01: dp_Reg_DataIn6[16:23] = fillBufWord6_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn6[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn6[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn6[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[6])                
	  1'b0: fillBufWord6_L2_i[16:23] <= fillBufWord6_L2_i[16:23];                
	  1'b1: fillBufWord6_L2_i[16:23] <= dp_Reg_DataIn6[16:23];       
	  default: fillBufWord6_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord6_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[25],fillBufMuxSel1[25]})                    
	  2'b00: dp_Reg_DataIn6[8:15] = PLB_dcuReadDataBus[8:15];  
	  2'b01: dp_Reg_DataIn6[8:15] = fillBufWord6_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn6[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn6[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn6[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[6])                
	  1'b0: fillBufWord6_L2_i[8:15] <= fillBufWord6_L2_i[8:15];                
	  1'b1: fillBufWord6_L2_i[8:15] <= dp_Reg_DataIn6[8:15];       
	  default: fillBufWord6_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord6_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[24],fillBufMuxSel1[24]})                    
	  2'b00: dp_Reg_DataIn6[0:7] = PLB_dcuReadDataBus[0:7];  
	  2'b01: dp_Reg_DataIn6[0:7] = fillBufWord6_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn6[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn6[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn6[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[6])                
	  1'b0: fillBufWord6_L2_i[0:7] <= fillBufWord6_L2_i[0:7];                
	  1'b1: fillBufWord6_L2_i[0:7] <= dp_Reg_DataIn6[0:7];       
	  default: fillBufWord6_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31] dp_Reg_DataIn5;
   reg  [0:31] fillBufWord5_L2_i;
   wire [0:31] fillBufWord5_L2;
   assign fillBufWord5_L2 = fillBufWord5_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord5_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[23],fillBufMuxSel1[23]})                    
	  2'b00: dp_Reg_DataIn5[24:31] = PLB_dcuReadDataBus[56:63];  
	  2'b01: dp_Reg_DataIn5[24:31] = fillBufWord5_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn5[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn5[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn5[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[5])                
	  1'b0: fillBufWord5_L2_i[24:31] <= fillBufWord5_L2_i[24:31];                
	  1'b1: fillBufWord5_L2_i[24:31] <= dp_Reg_DataIn5[24:31];       
	  default: fillBufWord5_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord5_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[22],fillBufMuxSel1[22]})                    
	  2'b00: dp_Reg_DataIn5[16:23] = PLB_dcuReadDataBus[48:55];  
	  2'b01: dp_Reg_DataIn5[16:23] = fillBufWord5_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn5[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn5[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn5[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[5])                
	  1'b0: fillBufWord5_L2_i[16:23] <= fillBufWord5_L2_i[16:23];                
	  1'b1: fillBufWord5_L2_i[16:23] <= dp_Reg_DataIn5[16:23];       
	  default: fillBufWord5_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord5_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[21],fillBufMuxSel1[21]})                    
	  2'b00: dp_Reg_DataIn5[8:15] = PLB_dcuReadDataBus[40:47];  
	  2'b01: dp_Reg_DataIn5[8:15] = fillBufWord5_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn5[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn5[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn5[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[5])                
	  1'b0: fillBufWord5_L2_i[8:15] <= fillBufWord5_L2_i[8:15];                
	  1'b1: fillBufWord5_L2_i[8:15] <= dp_Reg_DataIn5[8:15];       
	  default: fillBufWord5_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord5_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[20],fillBufMuxSel1[20]})                    
	  2'b00: dp_Reg_DataIn5[0:7] = PLB_dcuReadDataBus[32:39];  
	  2'b01: dp_Reg_DataIn5[0:7] = fillBufWord5_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn5[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn5[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn5[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[5])                
	  1'b0: fillBufWord5_L2_i[0:7] <= fillBufWord5_L2_i[0:7];                
	  1'b1: fillBufWord5_L2_i[0:7] <= dp_Reg_DataIn5[0:7];       
	  default: fillBufWord5_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  
 
   reg [0:31] dp_Reg_DataIn4;
   reg [0:31] fillBufWord4_L2_i;
   wire [0:31] fillBufWord4_L2;
   assign fillBufWord4_L2 = fillBufWord4_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord4_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[19],fillBufMuxSel1[19]})                    
	  2'b00: dp_Reg_DataIn4[24:31] = PLB_dcuReadDataBus[24:31];  
	  2'b01: dp_Reg_DataIn4[24:31] = fillBufWord4_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn4[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn4[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn4[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[4])                
	  1'b0: fillBufWord4_L2_i[24:31] <= fillBufWord4_L2_i[24:31];                
	  1'b1: fillBufWord4_L2_i[24:31] <= dp_Reg_DataIn4[24:31];       
	  default: fillBufWord4_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord4_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[18],fillBufMuxSel1[18]})                    
	  2'b00: dp_Reg_DataIn4[16:23] = PLB_dcuReadDataBus[16:23];  
	  2'b01: dp_Reg_DataIn4[16:23] = fillBufWord4_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn4[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn4[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn4[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[4])                
	  1'b0: fillBufWord4_L2_i[16:23] <= fillBufWord4_L2_i[16:23];                
	  1'b1: fillBufWord4_L2_i[16:23] <= dp_Reg_DataIn4[16:23];       
	  default: fillBufWord4_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord4_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[17],fillBufMuxSel1[17]})                    
	  2'b00: dp_Reg_DataIn4[8:15] = PLB_dcuReadDataBus[8:15];  
	  2'b01: dp_Reg_DataIn4[8:15] = fillBufWord4_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn4[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn4[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn4[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[4])                
	  1'b0: fillBufWord4_L2_i[8:15] <= fillBufWord4_L2_i[8:15];                
	  1'b1: fillBufWord4_L2_i[8:15] <= dp_Reg_DataIn4[8:15];       
	  default: fillBufWord4_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord4_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[16],fillBufMuxSel1[16]})                    
	  2'b00: dp_Reg_DataIn4[0:7] = PLB_dcuReadDataBus[0:7];  
	  2'b01: dp_Reg_DataIn4[0:7] = fillBufWord4_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn4[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn4[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn4[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[4])                
	  1'b0: fillBufWord4_L2_i[0:7] <= fillBufWord4_L2_i[0:7];                
	  1'b1: fillBufWord4_L2_i[0:7] <= dp_Reg_DataIn4[0:7];       
	  default: fillBufWord4_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  
 
   reg [0:31] dp_Reg_DataIn3;
   reg  [0:31] fillBufWord3_L2_i;
   wire [0:31] fillBufWord3_L2;
   assign fillBufWord3_L2 = fillBufWord3_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord3_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[15],fillBufMuxSel1[15]})                    
	  2'b00: dp_Reg_DataIn3[24:31] = PLB_dcuReadDataBus[56:63];  
	  2'b01: dp_Reg_DataIn3[24:31] = fillBufWord3_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn3[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn3[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn3[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[3])                
	  1'b0: fillBufWord3_L2_i[24:31] <= fillBufWord3_L2_i[24:31];                
	  1'b1: fillBufWord3_L2_i[24:31] <= dp_Reg_DataIn3[24:31];       
	  default: fillBufWord3_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord3_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[14],fillBufMuxSel1[14]})                    
	  2'b00: dp_Reg_DataIn3[16:23] = PLB_dcuReadDataBus[48:55];  
	  2'b01: dp_Reg_DataIn3[16:23] = fillBufWord3_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn3[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn3[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn3[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[3])                
	  1'b0: fillBufWord3_L2_i[16:23] <= fillBufWord3_L2_i[16:23];                
	  1'b1: fillBufWord3_L2_i[16:23] <= dp_Reg_DataIn3[16:23];       
	  default: fillBufWord3_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord3_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[13],fillBufMuxSel1[13]})                    
	  2'b00: dp_Reg_DataIn3[8:15] = PLB_dcuReadDataBus[40:47];  
	  2'b01: dp_Reg_DataIn3[8:15] = fillBufWord3_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn3[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn3[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn3[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[3])                
	  1'b0: fillBufWord3_L2_i[8:15] <= fillBufWord3_L2_i[8:15];                
	  1'b1: fillBufWord3_L2_i[8:15] <= dp_Reg_DataIn3[8:15];       
	  default: fillBufWord3_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord3_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[12],fillBufMuxSel1[12]})                    
	  2'b00: dp_Reg_DataIn3[0:7] = PLB_dcuReadDataBus[32:39];  
	  2'b01: dp_Reg_DataIn3[0:7] = fillBufWord3_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn3[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn3[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn3[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[3])                
	  1'b0: fillBufWord3_L2_i[0:7] <= fillBufWord3_L2_i[0:7];                
	  1'b1: fillBufWord3_L2_i[0:7] <= dp_Reg_DataIn3[0:7];       
	  default: fillBufWord3_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31] dp_Reg_DataIn2;
   reg  [0:31] fillBufWord2_L2_i;
   wire [0:31] fillBufWord2_L2;
   assign fillBufWord2_L2 = fillBufWord2_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord2_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[11],fillBufMuxSel1[11]})                    
	  2'b00: dp_Reg_DataIn2[24:31] = PLB_dcuReadDataBus[24:31];  
	  2'b01: dp_Reg_DataIn2[24:31] = fillBufWord2_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn2[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn2[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn2[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[2])                
	  1'b0: fillBufWord2_L2_i[24:31] <= fillBufWord2_L2_i[24:31];                
	  1'b1: fillBufWord2_L2_i[24:31] <= dp_Reg_DataIn2[24:31];       
	  default: fillBufWord2_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord2_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[10],fillBufMuxSel1[10]})                    
	  2'b00: dp_Reg_DataIn2[16:23] = PLB_dcuReadDataBus[16:23];  
	  2'b01: dp_Reg_DataIn2[16:23] = fillBufWord2_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn2[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn2[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn2[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[2])                
	  1'b0: fillBufWord2_L2_i[16:23] <= fillBufWord2_L2_i[16:23];                
	  1'b1: fillBufWord2_L2_i[16:23] <= dp_Reg_DataIn2[16:23];       
	  default: fillBufWord2_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord2_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[9],fillBufMuxSel1[9]})                    
	  2'b00: dp_Reg_DataIn2[8:15] = PLB_dcuReadDataBus[8:15];  
	  2'b01: dp_Reg_DataIn2[8:15] = fillBufWord2_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn2[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn2[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn2[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[2])                
	  1'b0: fillBufWord2_L2_i[8:15] <= fillBufWord2_L2_i[8:15];                
	  1'b1: fillBufWord2_L2_i[8:15] <= dp_Reg_DataIn2[8:15];       
	  default: fillBufWord2_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord2_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[8],fillBufMuxSel1[8]})                    
	  2'b00: dp_Reg_DataIn2[0:7] = PLB_dcuReadDataBus[0:7];  
	  2'b01: dp_Reg_DataIn2[0:7] = fillBufWord2_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn2[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn2[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn2[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[2])                
	  1'b0: fillBufWord2_L2_i[0:7] <= fillBufWord2_L2_i[0:7];                
	  1'b1: fillBufWord2_L2_i[0:7] <= dp_Reg_DataIn2[0:7];       
	  default: fillBufWord2_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31] dp_Reg_DataIn1;
   reg  [0:31] fillBufWord1_L2_i;
   wire [0:31] fillBufWord1_L2;
   assign fillBufWord1_L2 = fillBufWord1_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord1_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[7],fillBufMuxSel1[7]})                    
	  2'b00: dp_Reg_DataIn1[24:31] = PLB_dcuReadDataBus[56:63];  
	  2'b01: dp_Reg_DataIn1[24:31] = fillBufWord1_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn1[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn1[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn1[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[1])                
	  1'b0: fillBufWord1_L2_i[24:31] <= fillBufWord1_L2_i[24:31];                
	  1'b1: fillBufWord1_L2_i[24:31] <= dp_Reg_DataIn1[24:31];       
	  default: fillBufWord1_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord1_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[6],fillBufMuxSel1[6]})                    
	  2'b00: dp_Reg_DataIn1[16:23] = PLB_dcuReadDataBus[48:55];  
	  2'b01: dp_Reg_DataIn1[16:23] = fillBufWord1_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn1[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn1[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn1[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[1])                
	  1'b0: fillBufWord1_L2_i[16:23] <= fillBufWord1_L2_i[16:23];                
	  1'b1: fillBufWord1_L2_i[16:23] <= dp_Reg_DataIn1[16:23];       
	  default: fillBufWord1_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord1_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[5],fillBufMuxSel1[5]})                    
	  2'b00: dp_Reg_DataIn1[8:15] = PLB_dcuReadDataBus[40:47];  
	  2'b01: dp_Reg_DataIn1[8:15] = fillBufWord1_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn1[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn1[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn1[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[1])                
	  1'b0: fillBufWord1_L2_i[8:15] <= fillBufWord1_L2_i[8:15];                
	  1'b1: fillBufWord1_L2_i[8:15] <= dp_Reg_DataIn1[8:15];       
	  default: fillBufWord1_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord1_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[4],fillBufMuxSel1[4]})                    
	  2'b00: dp_Reg_DataIn1[0:7] = PLB_dcuReadDataBus[32:39];  
	  2'b01: dp_Reg_DataIn1[0:7] = fillBufWord1_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn1[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn1[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn1[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[1])                
	  1'b0: fillBufWord1_L2_i[0:7] <= fillBufWord1_L2_i[0:7];                
	  1'b1: fillBufWord1_L2_i[0:7] <= dp_Reg_DataIn1[0:7];       
	  default: fillBufWord1_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31] dp_Reg_DataIn0;
   reg  [0:31] fillBufWord0_L2_i;
   wire [0:31] fillBufWord0_L2;
   assign fillBufWord0_L2 = fillBufWord0_L2_i;
   
   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord0_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[3],fillBufMuxSel1[3]})                    
	  2'b00: dp_Reg_DataIn0[24:31] = PLB_dcuReadDataBus[24:31];  
	  2'b01: dp_Reg_DataIn0[24:31] = fillBufWord0_L2_i[24:31];  
	  2'b10: dp_Reg_DataIn0[24:31] = 8'b0;  
	  2'b11: dp_Reg_DataIn0[24:31] = SDQ_SDP_mux[24:31];  
	  default: dp_Reg_DataIn0[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte3_E1 & fillBuf_E2_byte23[0])                
	  1'b0: fillBufWord0_L2_i[24:31] <= fillBufWord0_L2_i[24:31];                
	  1'b1: fillBufWord0_L2_i[24:31] <= dp_Reg_DataIn0[24:31];       
	  default: fillBufWord0_L2_i[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord0_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[2],fillBufMuxSel1[2]})                    
	  2'b00: dp_Reg_DataIn0[16:23] = PLB_dcuReadDataBus[16:23];  
	  2'b01: dp_Reg_DataIn0[16:23] = fillBufWord0_L2_i[16:23];  
	  2'b10: dp_Reg_DataIn0[16:23] = 8'b0;  
	  2'b11: dp_Reg_DataIn0[16:23] = SDQ_SDP_mux[16:23];  
	  default: dp_Reg_DataIn0[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte2_E1 & fillBuf_E2_byte23[0])                
	  1'b0: fillBufWord0_L2_i[16:23] <= fillBufWord0_L2_i[16:23];                
	  1'b1: fillBufWord0_L2_i[16:23] <= dp_Reg_DataIn0[16:23];       
	  default: fillBufWord0_L2_i[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord0_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[1],fillBufMuxSel1[1]})                    
	  2'b00: dp_Reg_DataIn0[8:15] = PLB_dcuReadDataBus[8:15];  
	  2'b01: dp_Reg_DataIn0[8:15] = fillBufWord0_L2_i[8:15];  
	  2'b10: dp_Reg_DataIn0[8:15] = 8'b0;  
	  2'b11: dp_Reg_DataIn0[8:15] = SDQ_SDP_mux[8:15];  
	  default: dp_Reg_DataIn0[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte1_E1 & fillBuf_E2_byte01[0])                
	  1'b0: fillBufWord0_L2_i[8:15] <= fillBufWord0_L2_i[8:15];                
	  1'b1: fillBufWord0_L2_i[8:15] <= dp_Reg_DataIn0[8:15];       
	  default: fillBufWord0_L2_i[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(fillBufMuxSel0 or fillBufMuxSel1 or PLB_dcuReadDataBus or fillBufWord0_L2_i or SDQ_SDP_mux)      
     begin                                       
	case({fillBufMuxSel0[0],fillBufMuxSel1[0]})                    
	  2'b00: dp_Reg_DataIn0[0:7] = PLB_dcuReadDataBus[0:7];  
	  2'b01: dp_Reg_DataIn0[0:7] = fillBufWord0_L2_i[0:7];  
	  2'b10: dp_Reg_DataIn0[0:7] = 8'b0;  
	  2'b11: dp_Reg_DataIn0[0:7] = SDQ_SDP_mux[0:7];  
	  default: dp_Reg_DataIn0[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(fillBufByte0_E1 & fillBuf_E2_byte01[0])                
	  1'b0: fillBufWord0_L2_i[0:7] <= fillBufWord0_L2_i[0:7];                
	  1'b1: fillBufWord0_L2_i[0:7] <= dp_Reg_DataIn0[0:7];       
	  default: fillBufWord0_L2_i[0:7] <= 8'bx;  
	endcase                             
     end                                  

//--------- start ---------------
// rgoldiez - added these parity generation blocks for the 64-bit PLB read bus

// Removed the module 'module dp_logDCU_parityGen8, 8 instances

   assign p_PLB_dcuReadDataBus[0] = ^{PLB_dcuReadDataBus[0:7]};
   assign p_PLB_dcuReadDataBus[1] = ^{PLB_dcuReadDataBus[8:15]};
   assign p_PLB_dcuReadDataBus[2] = ^{PLB_dcuReadDataBus[16:23]};
   assign p_PLB_dcuReadDataBus[3] = ^{PLB_dcuReadDataBus[24:31]};
   assign p_PLB_dcuReadDataBus[4] = ^{PLB_dcuReadDataBus[32:39]};
   assign p_PLB_dcuReadDataBus[5] = ^{PLB_dcuReadDataBus[40:47]};
   assign p_PLB_dcuReadDataBus[6] = ^{PLB_dcuReadDataBus[48:55]};
   assign p_PLB_dcuReadDataBus[7] = ^{PLB_dcuReadDataBus[56:63]};

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword7Byte3
   reg dp_regDCU_parityFBword7Byte3_regL2;
   reg dp_regDCU_parityFBword7Byte3_DataIn;
   wire dp_regDCU_parityFBword7Byte3_D0,dp_regDCU_parityFBword7Byte3_D1; 
   wire dp_regDCU_parityFBword7Byte3_D2; 
   wire dp_regDCU_parityFBword7Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword7Byte3_SD; 
   wire dp_regDCU_parityFBword7Byte3_E1; 
   wire [0:31] p_fillBuf_L2, p_fillBuf_L2_i;
   assign p_fillBuf_L2 = p_fillBuf_L2_i; 
   assign p_fillBuf_L2_i[31] = dp_regDCU_parityFBword7Byte3_regL2;     	
   assign dp_regDCU_parityFBword7Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[7];     
   assign dp_regDCU_parityFBword7Byte3_SD = {fillBufMuxSel0[31],fillBufMuxSel1[31]};    	
   assign dp_regDCU_parityFBword7Byte3_D0 = p_PLB_dcuReadDataBus[7];    	
   assign dp_regDCU_parityFBword7Byte3_D1 = p_fillBuf_L2_i[31];    	
   assign dp_regDCU_parityFBword7Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword7Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword7Byte3_D0 or dp_regDCU_parityFBword7Byte3_D1 or dp_regDCU_parityFBword7Byte3_D2 or dp_regDCU_parityFBword7Byte3_D3 or dp_regDCU_parityFBword7Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte3_SD)			
     2'b00: dp_regDCU_parityFBword7Byte3_DataIn = dp_regDCU_parityFBword7Byte3_D0;	
     2'b01: dp_regDCU_parityFBword7Byte3_DataIn = dp_regDCU_parityFBword7Byte3_D1;	
     2'b10: dp_regDCU_parityFBword7Byte3_DataIn = dp_regDCU_parityFBword7Byte3_D2;	
     2'b11: dp_regDCU_parityFBword7Byte3_DataIn = dp_regDCU_parityFBword7Byte3_D3;	
      default: dp_regDCU_parityFBword7Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte3_E1)			
     1'b0: dp_regDCU_parityFBword7Byte3_regL2 <= dp_regDCU_parityFBword7Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword7Byte3_regL2 <= dp_regDCU_parityFBword7Byte3_DataIn;	
      default: dp_regDCU_parityFBword7Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword7Byte2
   reg dp_regDCU_parityFBword7Byte2_regL2;
   reg dp_regDCU_parityFBword7Byte2_DataIn;
   wire dp_regDCU_parityFBword7Byte2_D0,dp_regDCU_parityFBword7Byte2_D1; 
   wire dp_regDCU_parityFBword7Byte2_D2; 
   wire dp_regDCU_parityFBword7Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword7Byte2_SD; 
   wire dp_regDCU_parityFBword7Byte2_E1; 
   assign p_fillBuf_L2_i[30] = dp_regDCU_parityFBword7Byte2_regL2;     	
   assign dp_regDCU_parityFBword7Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[7];     
   assign dp_regDCU_parityFBword7Byte2_SD = {fillBufMuxSel0[30],fillBufMuxSel1[30]};    	
   assign dp_regDCU_parityFBword7Byte2_D0 = p_PLB_dcuReadDataBus[6];    	
   assign dp_regDCU_parityFBword7Byte2_D1 = p_fillBuf_L2_i[30];    	
   assign dp_regDCU_parityFBword7Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword7Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword7Byte2_D0 or dp_regDCU_parityFBword7Byte2_D1 or dp_regDCU_parityFBword7Byte2_D2 or dp_regDCU_parityFBword7Byte2_D3 or dp_regDCU_parityFBword7Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte2_SD)			
     2'b00: dp_regDCU_parityFBword7Byte2_DataIn = dp_regDCU_parityFBword7Byte2_D0;	
     2'b01: dp_regDCU_parityFBword7Byte2_DataIn = dp_regDCU_parityFBword7Byte2_D1;	
     2'b10: dp_regDCU_parityFBword7Byte2_DataIn = dp_regDCU_parityFBword7Byte2_D2;	
     2'b11: dp_regDCU_parityFBword7Byte2_DataIn = dp_regDCU_parityFBword7Byte2_D3;	
      default: dp_regDCU_parityFBword7Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte2_E1)			
     1'b0: dp_regDCU_parityFBword7Byte2_regL2 <= dp_regDCU_parityFBword7Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword7Byte2_regL2 <= dp_regDCU_parityFBword7Byte2_DataIn;	
      default: dp_regDCU_parityFBword7Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword7Byte1
   reg dp_regDCU_parityFBword7Byte1_regL2;
   reg dp_regDCU_parityFBword7Byte1_DataIn;
   wire dp_regDCU_parityFBword7Byte1_D0,dp_regDCU_parityFBword7Byte1_D1; 
   wire dp_regDCU_parityFBword7Byte1_D2; 
   wire dp_regDCU_parityFBword7Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword7Byte1_SD; 
   wire dp_regDCU_parityFBword7Byte1_E1; 
   assign p_fillBuf_L2_i[29] = dp_regDCU_parityFBword7Byte1_regL2;     	
   assign dp_regDCU_parityFBword7Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[7];     
   assign dp_regDCU_parityFBword7Byte1_SD = {fillBufMuxSel0[29],fillBufMuxSel1[29]};    	
   assign dp_regDCU_parityFBword7Byte1_D0 = p_PLB_dcuReadDataBus[5];    	
   assign dp_regDCU_parityFBword7Byte1_D1 = p_fillBuf_L2_i[29];    	
   assign dp_regDCU_parityFBword7Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword7Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword7Byte1_D0 or dp_regDCU_parityFBword7Byte1_D1 or dp_regDCU_parityFBword7Byte1_D2 or dp_regDCU_parityFBword7Byte1_D3 or dp_regDCU_parityFBword7Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte1_SD)			
     2'b00: dp_regDCU_parityFBword7Byte1_DataIn = dp_regDCU_parityFBword7Byte1_D0;	
     2'b01: dp_regDCU_parityFBword7Byte1_DataIn = dp_regDCU_parityFBword7Byte1_D1;	
     2'b10: dp_regDCU_parityFBword7Byte1_DataIn = dp_regDCU_parityFBword7Byte1_D2;	
     2'b11: dp_regDCU_parityFBword7Byte1_DataIn = dp_regDCU_parityFBword7Byte1_D3;	
      default: dp_regDCU_parityFBword7Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte1_E1)			
     1'b0: dp_regDCU_parityFBword7Byte1_regL2 <= dp_regDCU_parityFBword7Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword7Byte1_regL2 <= dp_regDCU_parityFBword7Byte1_DataIn;	
      default: dp_regDCU_parityFBword7Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword7Byte0
   reg dp_regDCU_parityFBword7Byte0_regL2;
   reg dp_regDCU_parityFBword7Byte0_DataIn;
   wire dp_regDCU_parityFBword7Byte0_D0,dp_regDCU_parityFBword7Byte0_D1; 
   wire dp_regDCU_parityFBword7Byte0_D2; 
   wire dp_regDCU_parityFBword7Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword7Byte0_SD; 
   wire dp_regDCU_parityFBword7Byte0_E1; 
   assign p_fillBuf_L2_i[28] = dp_regDCU_parityFBword7Byte0_regL2;     	
   assign dp_regDCU_parityFBword7Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[7];     
   assign dp_regDCU_parityFBword7Byte0_SD = {fillBufMuxSel0[28],fillBufMuxSel1[28]};    	
   assign dp_regDCU_parityFBword7Byte0_D0 = p_PLB_dcuReadDataBus[4];    	
   assign dp_regDCU_parityFBword7Byte0_D1 = p_fillBuf_L2_i[28];    	
   assign dp_regDCU_parityFBword7Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword7Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword7Byte0_D0 or dp_regDCU_parityFBword7Byte0_D1 or dp_regDCU_parityFBword7Byte0_D2 or dp_regDCU_parityFBword7Byte0_D3 or dp_regDCU_parityFBword7Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte0_SD)			
     2'b00: dp_regDCU_parityFBword7Byte0_DataIn = dp_regDCU_parityFBword7Byte0_D0;	
     2'b01: dp_regDCU_parityFBword7Byte0_DataIn = dp_regDCU_parityFBword7Byte0_D1;	
     2'b10: dp_regDCU_parityFBword7Byte0_DataIn = dp_regDCU_parityFBword7Byte0_D2;	
     2'b11: dp_regDCU_parityFBword7Byte0_DataIn = dp_regDCU_parityFBword7Byte0_D3;	
      default: dp_regDCU_parityFBword7Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword7Byte0_E1)			
     1'b0: dp_regDCU_parityFBword7Byte0_regL2 <= dp_regDCU_parityFBword7Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword7Byte0_regL2 <= dp_regDCU_parityFBword7Byte0_DataIn;	
      default: dp_regDCU_parityFBword7Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword6Byte3
   reg dp_regDCU_parityFBword6Byte3_regL2;
   reg dp_regDCU_parityFBword6Byte3_DataIn;
   wire dp_regDCU_parityFBword6Byte3_D0,dp_regDCU_parityFBword6Byte3_D1; 
   wire dp_regDCU_parityFBword6Byte3_D2; 
   wire dp_regDCU_parityFBword6Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword6Byte3_SD; 
   wire dp_regDCU_parityFBword6Byte3_E1; 
   assign p_fillBuf_L2_i[27] = dp_regDCU_parityFBword6Byte3_regL2;     	
   assign dp_regDCU_parityFBword6Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[6];     
   assign dp_regDCU_parityFBword6Byte3_SD = {fillBufMuxSel0[27],fillBufMuxSel1[27]};    	
   assign dp_regDCU_parityFBword6Byte3_D0 = p_PLB_dcuReadDataBus[3];    	
   assign dp_regDCU_parityFBword6Byte3_D1 = p_fillBuf_L2_i[27];    	
   assign dp_regDCU_parityFBword6Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword6Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword6Byte3_D0 or dp_regDCU_parityFBword6Byte3_D1 or dp_regDCU_parityFBword6Byte3_D2 or dp_regDCU_parityFBword6Byte3_D3 or dp_regDCU_parityFBword6Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte3_SD)			
     2'b00: dp_regDCU_parityFBword6Byte3_DataIn = dp_regDCU_parityFBword6Byte3_D0;	
     2'b01: dp_regDCU_parityFBword6Byte3_DataIn = dp_regDCU_parityFBword6Byte3_D1;	
     2'b10: dp_regDCU_parityFBword6Byte3_DataIn = dp_regDCU_parityFBword6Byte3_D2;	
     2'b11: dp_regDCU_parityFBword6Byte3_DataIn = dp_regDCU_parityFBword6Byte3_D3;	
      default: dp_regDCU_parityFBword6Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte3_E1)			
     1'b0: dp_regDCU_parityFBword6Byte3_regL2 <= dp_regDCU_parityFBword6Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword6Byte3_regL2 <= dp_regDCU_parityFBword6Byte3_DataIn;	
      default: dp_regDCU_parityFBword6Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword6Byte2
   reg dp_regDCU_parityFBword6Byte2_regL2;
   reg dp_regDCU_parityFBword6Byte2_DataIn;
   wire dp_regDCU_parityFBword6Byte2_D0,dp_regDCU_parityFBword6Byte2_D1; 
   wire dp_regDCU_parityFBword6Byte2_D2; 
   wire dp_regDCU_parityFBword6Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword6Byte2_SD; 
   wire dp_regDCU_parityFBword6Byte2_E1; 
   assign p_fillBuf_L2_i[26] = dp_regDCU_parityFBword6Byte2_regL2;     	
   assign dp_regDCU_parityFBword6Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[6];     
   assign dp_regDCU_parityFBword6Byte2_SD = {fillBufMuxSel0[26],fillBufMuxSel1[26]};    	
   assign dp_regDCU_parityFBword6Byte2_D0 = p_PLB_dcuReadDataBus[2];    	
   assign dp_regDCU_parityFBword6Byte2_D1 = p_fillBuf_L2_i[26];    	
   assign dp_regDCU_parityFBword6Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword6Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword6Byte2_D0 or dp_regDCU_parityFBword6Byte2_D1 or dp_regDCU_parityFBword6Byte2_D2 or dp_regDCU_parityFBword6Byte2_D3 or dp_regDCU_parityFBword6Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte2_SD)			
     2'b00: dp_regDCU_parityFBword6Byte2_DataIn = dp_regDCU_parityFBword6Byte2_D0;	
     2'b01: dp_regDCU_parityFBword6Byte2_DataIn = dp_regDCU_parityFBword6Byte2_D1;	
     2'b10: dp_regDCU_parityFBword6Byte2_DataIn = dp_regDCU_parityFBword6Byte2_D2;	
     2'b11: dp_regDCU_parityFBword6Byte2_DataIn = dp_regDCU_parityFBword6Byte2_D3;	
      default: dp_regDCU_parityFBword6Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte2_E1)			
     1'b0: dp_regDCU_parityFBword6Byte2_regL2 <= dp_regDCU_parityFBword6Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword6Byte2_regL2 <= dp_regDCU_parityFBword6Byte2_DataIn;	
      default: dp_regDCU_parityFBword6Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword6Byte1
   reg dp_regDCU_parityFBword6Byte1_regL2;
   reg dp_regDCU_parityFBword6Byte1_DataIn;
   wire dp_regDCU_parityFBword6Byte1_D0,dp_regDCU_parityFBword6Byte1_D1; 
   wire dp_regDCU_parityFBword6Byte1_D2; 
   wire dp_regDCU_parityFBword6Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword6Byte1_SD; 
   wire dp_regDCU_parityFBword6Byte1_E1; 
   assign p_fillBuf_L2_i[25] = dp_regDCU_parityFBword6Byte1_regL2;     	
   assign dp_regDCU_parityFBword6Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[6];     
   assign dp_regDCU_parityFBword6Byte1_SD = {fillBufMuxSel0[25],fillBufMuxSel1[25]};    	
   assign dp_regDCU_parityFBword6Byte1_D0 = p_PLB_dcuReadDataBus[1];    	
   assign dp_regDCU_parityFBword6Byte1_D1 = p_fillBuf_L2_i[25];    	
   assign dp_regDCU_parityFBword6Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword6Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword6Byte1_D0 or dp_regDCU_parityFBword6Byte1_D1 or dp_regDCU_parityFBword6Byte1_D2 or dp_regDCU_parityFBword6Byte1_D3 or dp_regDCU_parityFBword6Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte1_SD)			
     2'b00: dp_regDCU_parityFBword6Byte1_DataIn = dp_regDCU_parityFBword6Byte1_D0;	
     2'b01: dp_regDCU_parityFBword6Byte1_DataIn = dp_regDCU_parityFBword6Byte1_D1;	
     2'b10: dp_regDCU_parityFBword6Byte1_DataIn = dp_regDCU_parityFBword6Byte1_D2;	
     2'b11: dp_regDCU_parityFBword6Byte1_DataIn = dp_regDCU_parityFBword6Byte1_D3;	
      default: dp_regDCU_parityFBword6Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte1_E1)			
     1'b0: dp_regDCU_parityFBword6Byte1_regL2 <= dp_regDCU_parityFBword6Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword6Byte1_regL2 <= dp_regDCU_parityFBword6Byte1_DataIn;	
      default: dp_regDCU_parityFBword6Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword6Byte0
   reg dp_regDCU_parityFBword6Byte0_regL2;
   reg dp_regDCU_parityFBword6Byte0_DataIn;
   wire dp_regDCU_parityFBword6Byte0_D0,dp_regDCU_parityFBword6Byte0_D1; 
   wire dp_regDCU_parityFBword6Byte0_D2; 
   wire dp_regDCU_parityFBword6Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword6Byte0_SD; 
   wire dp_regDCU_parityFBword6Byte0_E1; 
   assign p_fillBuf_L2_i[24] = dp_regDCU_parityFBword6Byte0_regL2;     	
   assign dp_regDCU_parityFBword6Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[6];     
   assign dp_regDCU_parityFBword6Byte0_SD = {fillBufMuxSel0[24],fillBufMuxSel1[24]};    	
   assign dp_regDCU_parityFBword6Byte0_D0 = p_PLB_dcuReadDataBus[0];    	
   assign dp_regDCU_parityFBword6Byte0_D1 = p_fillBuf_L2_i[24];    	
   assign dp_regDCU_parityFBword6Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword6Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword6Byte0_D0 or dp_regDCU_parityFBword6Byte0_D1 or dp_regDCU_parityFBword6Byte0_D2 or dp_regDCU_parityFBword6Byte0_D3 or dp_regDCU_parityFBword6Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte0_SD)			
     2'b00: dp_regDCU_parityFBword6Byte0_DataIn = dp_regDCU_parityFBword6Byte0_D0;	
     2'b01: dp_regDCU_parityFBword6Byte0_DataIn = dp_regDCU_parityFBword6Byte0_D1;	
     2'b10: dp_regDCU_parityFBword6Byte0_DataIn = dp_regDCU_parityFBword6Byte0_D2;	
     2'b11: dp_regDCU_parityFBword6Byte0_DataIn = dp_regDCU_parityFBword6Byte0_D3;	
      default: dp_regDCU_parityFBword6Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword6Byte0_E1)			
     1'b0: dp_regDCU_parityFBword6Byte0_regL2 <= dp_regDCU_parityFBword6Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword6Byte0_regL2 <= dp_regDCU_parityFBword6Byte0_DataIn;	
      default: dp_regDCU_parityFBword6Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword5Byte3
   reg dp_regDCU_parityFBword5Byte3_regL2;
   reg dp_regDCU_parityFBword5Byte3_DataIn;
   wire dp_regDCU_parityFBword5Byte3_D0,dp_regDCU_parityFBword5Byte3_D1; 
   wire dp_regDCU_parityFBword5Byte3_D2; 
   wire dp_regDCU_parityFBword5Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword5Byte3_SD; 
   wire dp_regDCU_parityFBword5Byte3_E1; 
   assign p_fillBuf_L2_i[23] = dp_regDCU_parityFBword5Byte3_regL2;     	
   assign dp_regDCU_parityFBword5Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[5];     
   assign dp_regDCU_parityFBword5Byte3_SD = {fillBufMuxSel0[23],fillBufMuxSel1[23]};    	
   assign dp_regDCU_parityFBword5Byte3_D0 = p_PLB_dcuReadDataBus[7];    	
   assign dp_regDCU_parityFBword5Byte3_D1 = p_fillBuf_L2_i[23];    	
   assign dp_regDCU_parityFBword5Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword5Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword5Byte3_D0 or dp_regDCU_parityFBword5Byte3_D1 or dp_regDCU_parityFBword5Byte3_D2 or dp_regDCU_parityFBword5Byte3_D3 or dp_regDCU_parityFBword5Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte3_SD)			
     2'b00: dp_regDCU_parityFBword5Byte3_DataIn = dp_regDCU_parityFBword5Byte3_D0;	
     2'b01: dp_regDCU_parityFBword5Byte3_DataIn = dp_regDCU_parityFBword5Byte3_D1;	
     2'b10: dp_regDCU_parityFBword5Byte3_DataIn = dp_regDCU_parityFBword5Byte3_D2;	
     2'b11: dp_regDCU_parityFBword5Byte3_DataIn = dp_regDCU_parityFBword5Byte3_D3;	
      default: dp_regDCU_parityFBword5Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte3_E1)			
     1'b0: dp_regDCU_parityFBword5Byte3_regL2 <= dp_regDCU_parityFBword5Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword5Byte3_regL2 <= dp_regDCU_parityFBword5Byte3_DataIn;	
      default: dp_regDCU_parityFBword5Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword5Byte2
   reg dp_regDCU_parityFBword5Byte2_regL2;
   reg dp_regDCU_parityFBword5Byte2_DataIn;
   wire dp_regDCU_parityFBword5Byte2_D0,dp_regDCU_parityFBword5Byte2_D1; 
   wire dp_regDCU_parityFBword5Byte2_D2; 
   wire dp_regDCU_parityFBword5Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword5Byte2_SD; 
   wire dp_regDCU_parityFBword5Byte2_E1; 
   assign p_fillBuf_L2_i[22] = dp_regDCU_parityFBword5Byte2_regL2;     	
   assign dp_regDCU_parityFBword5Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[5];     
   assign dp_regDCU_parityFBword5Byte2_SD = {fillBufMuxSel0[22],fillBufMuxSel1[22]};    	
   assign dp_regDCU_parityFBword5Byte2_D0 = p_PLB_dcuReadDataBus[6];    	
   assign dp_regDCU_parityFBword5Byte2_D1 = p_fillBuf_L2_i[22];    	
   assign dp_regDCU_parityFBword5Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword5Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword5Byte2_D0 or dp_regDCU_parityFBword5Byte2_D1 or dp_regDCU_parityFBword5Byte2_D2 or dp_regDCU_parityFBword5Byte2_D3 or dp_regDCU_parityFBword5Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte2_SD)			
     2'b00: dp_regDCU_parityFBword5Byte2_DataIn = dp_regDCU_parityFBword5Byte2_D0;	
     2'b01: dp_regDCU_parityFBword5Byte2_DataIn = dp_regDCU_parityFBword5Byte2_D1;	
     2'b10: dp_regDCU_parityFBword5Byte2_DataIn = dp_regDCU_parityFBword5Byte2_D2;	
     2'b11: dp_regDCU_parityFBword5Byte2_DataIn = dp_regDCU_parityFBword5Byte2_D3;	
      default: dp_regDCU_parityFBword5Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte2_E1)			
     1'b0: dp_regDCU_parityFBword5Byte2_regL2 <= dp_regDCU_parityFBword5Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword5Byte2_regL2 <= dp_regDCU_parityFBword5Byte2_DataIn;	
      default: dp_regDCU_parityFBword5Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword5Byte1
   reg dp_regDCU_parityFBword5Byte1_regL2;
   reg dp_regDCU_parityFBword5Byte1_DataIn;
   wire dp_regDCU_parityFBword5Byte1_D0,dp_regDCU_parityFBword5Byte1_D1; 
   wire dp_regDCU_parityFBword5Byte1_D2; 
   wire dp_regDCU_parityFBword5Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword5Byte1_SD; 
   wire dp_regDCU_parityFBword5Byte1_E1; 
   assign p_fillBuf_L2_i[21] = dp_regDCU_parityFBword5Byte1_regL2;     	
   assign dp_regDCU_parityFBword5Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[5];     
   assign dp_regDCU_parityFBword5Byte1_SD = {fillBufMuxSel0[21],fillBufMuxSel1[21]};    	
   assign dp_regDCU_parityFBword5Byte1_D0 = p_PLB_dcuReadDataBus[5];    	
   assign dp_regDCU_parityFBword5Byte1_D1 = p_fillBuf_L2_i[21];    	
   assign dp_regDCU_parityFBword5Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword5Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword5Byte1_D0 or dp_regDCU_parityFBword5Byte1_D1 or dp_regDCU_parityFBword5Byte1_D2 or dp_regDCU_parityFBword5Byte1_D3 or dp_regDCU_parityFBword5Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte1_SD)			
     2'b00: dp_regDCU_parityFBword5Byte1_DataIn = dp_regDCU_parityFBword5Byte1_D0;	
     2'b01: dp_regDCU_parityFBword5Byte1_DataIn = dp_regDCU_parityFBword5Byte1_D1;	
     2'b10: dp_regDCU_parityFBword5Byte1_DataIn = dp_regDCU_parityFBword5Byte1_D2;	
     2'b11: dp_regDCU_parityFBword5Byte1_DataIn = dp_regDCU_parityFBword5Byte1_D3;	
      default: dp_regDCU_parityFBword5Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte1_E1)			
     1'b0: dp_regDCU_parityFBword5Byte1_regL2 <= dp_regDCU_parityFBword5Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword5Byte1_regL2 <= dp_regDCU_parityFBword5Byte1_DataIn;	
      default: dp_regDCU_parityFBword5Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword5Byte0
   reg dp_regDCU_parityFBword5Byte0_regL2;
   reg dp_regDCU_parityFBword5Byte0_DataIn;
   wire dp_regDCU_parityFBword5Byte0_D0,dp_regDCU_parityFBword5Byte0_D1; 
   wire dp_regDCU_parityFBword5Byte0_D2; 
   wire dp_regDCU_parityFBword5Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword5Byte0_SD; 
   wire dp_regDCU_parityFBword5Byte0_E1; 
   assign p_fillBuf_L2_i[20] = dp_regDCU_parityFBword5Byte0_regL2;     	
   assign dp_regDCU_parityFBword5Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[5];     
   assign dp_regDCU_parityFBword5Byte0_SD = {fillBufMuxSel0[20],fillBufMuxSel1[20]};    	
   assign dp_regDCU_parityFBword5Byte0_D0 = p_PLB_dcuReadDataBus[4];    	
   assign dp_regDCU_parityFBword5Byte0_D1 = p_fillBuf_L2_i[20];    	
   assign dp_regDCU_parityFBword5Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword5Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword5Byte0_D0 or dp_regDCU_parityFBword5Byte0_D1 or dp_regDCU_parityFBword5Byte0_D2 or dp_regDCU_parityFBword5Byte0_D3 or dp_regDCU_parityFBword5Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte0_SD)			
     2'b00: dp_regDCU_parityFBword5Byte0_DataIn = dp_regDCU_parityFBword5Byte0_D0;	
     2'b01: dp_regDCU_parityFBword5Byte0_DataIn = dp_regDCU_parityFBword5Byte0_D1;	
     2'b10: dp_regDCU_parityFBword5Byte0_DataIn = dp_regDCU_parityFBword5Byte0_D2;	
     2'b11: dp_regDCU_parityFBword5Byte0_DataIn = dp_regDCU_parityFBword5Byte0_D3;	
      default: dp_regDCU_parityFBword5Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword5Byte0_E1)			
     1'b0: dp_regDCU_parityFBword5Byte0_regL2 <= dp_regDCU_parityFBword5Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword5Byte0_regL2 <= dp_regDCU_parityFBword5Byte0_DataIn;	
      default: dp_regDCU_parityFBword5Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword4Byte3
   reg dp_regDCU_parityFBword4Byte3_regL2;
   reg dp_regDCU_parityFBword4Byte3_DataIn;
   wire dp_regDCU_parityFBword4Byte3_D0,dp_regDCU_parityFBword4Byte3_D1; 
   wire dp_regDCU_parityFBword4Byte3_D2; 
   wire dp_regDCU_parityFBword4Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword4Byte3_SD; 
   wire dp_regDCU_parityFBword4Byte3_E1; 
   assign p_fillBuf_L2_i[19] = dp_regDCU_parityFBword4Byte3_regL2;     	
   assign dp_regDCU_parityFBword4Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[4];     
   assign dp_regDCU_parityFBword4Byte3_SD = {fillBufMuxSel0[19],fillBufMuxSel1[19]};    	
   assign dp_regDCU_parityFBword4Byte3_D0 = p_PLB_dcuReadDataBus[3];    	
   assign dp_regDCU_parityFBword4Byte3_D1 = p_fillBuf_L2_i[19];    	
   assign dp_regDCU_parityFBword4Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword4Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword4Byte3_D0 or dp_regDCU_parityFBword4Byte3_D1 or dp_regDCU_parityFBword4Byte3_D2 or dp_regDCU_parityFBword4Byte3_D3 or dp_regDCU_parityFBword4Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte3_SD)			
     2'b00: dp_regDCU_parityFBword4Byte3_DataIn = dp_regDCU_parityFBword4Byte3_D0;	
     2'b01: dp_regDCU_parityFBword4Byte3_DataIn = dp_regDCU_parityFBword4Byte3_D1;	
     2'b10: dp_regDCU_parityFBword4Byte3_DataIn = dp_regDCU_parityFBword4Byte3_D2;	
     2'b11: dp_regDCU_parityFBword4Byte3_DataIn = dp_regDCU_parityFBword4Byte3_D3;	
      default: dp_regDCU_parityFBword4Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte3_E1)			
     1'b0: dp_regDCU_parityFBword4Byte3_regL2 <= dp_regDCU_parityFBword4Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword4Byte3_regL2 <= dp_regDCU_parityFBword4Byte3_DataIn;	
      default: dp_regDCU_parityFBword4Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword4Byte2
   reg dp_regDCU_parityFBword4Byte2_regL2;
   reg dp_regDCU_parityFBword4Byte2_DataIn;
   wire dp_regDCU_parityFBword4Byte2_D0,dp_regDCU_parityFBword4Byte2_D1; 
   wire dp_regDCU_parityFBword4Byte2_D2; 
   wire dp_regDCU_parityFBword4Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword4Byte2_SD; 
   wire dp_regDCU_parityFBword4Byte2_E1; 
   assign p_fillBuf_L2_i[18] = dp_regDCU_parityFBword4Byte2_regL2;     	
   assign dp_regDCU_parityFBword4Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[4];     
   assign dp_regDCU_parityFBword4Byte2_SD = {fillBufMuxSel0[18],fillBufMuxSel1[18]};    	
   assign dp_regDCU_parityFBword4Byte2_D0 = p_PLB_dcuReadDataBus[2];    	
   assign dp_regDCU_parityFBword4Byte2_D1 = p_fillBuf_L2_i[18];    	
   assign dp_regDCU_parityFBword4Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword4Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword4Byte2_D0 or dp_regDCU_parityFBword4Byte2_D1 or dp_regDCU_parityFBword4Byte2_D2 or dp_regDCU_parityFBword4Byte2_D3 or dp_regDCU_parityFBword4Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte2_SD)			
     2'b00: dp_regDCU_parityFBword4Byte2_DataIn = dp_regDCU_parityFBword4Byte2_D0;	
     2'b01: dp_regDCU_parityFBword4Byte2_DataIn = dp_regDCU_parityFBword4Byte2_D1;	
     2'b10: dp_regDCU_parityFBword4Byte2_DataIn = dp_regDCU_parityFBword4Byte2_D2;	
     2'b11: dp_regDCU_parityFBword4Byte2_DataIn = dp_regDCU_parityFBword4Byte2_D3;	
      default: dp_regDCU_parityFBword4Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte2_E1)			
     1'b0: dp_regDCU_parityFBword4Byte2_regL2 <= dp_regDCU_parityFBword4Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword4Byte2_regL2 <= dp_regDCU_parityFBword4Byte2_DataIn;	
      default: dp_regDCU_parityFBword4Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword4Byte1
   reg dp_regDCU_parityFBword4Byte1_regL2;
   reg dp_regDCU_parityFBword4Byte1_DataIn;
   wire dp_regDCU_parityFBword4Byte1_D0,dp_regDCU_parityFBword4Byte1_D1; 
   wire dp_regDCU_parityFBword4Byte1_D2; 
   wire dp_regDCU_parityFBword4Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword4Byte1_SD; 
   wire dp_regDCU_parityFBword4Byte1_E1; 
   assign p_fillBuf_L2_i[17] = dp_regDCU_parityFBword4Byte1_regL2;     	
   assign dp_regDCU_parityFBword4Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[4];     
   assign dp_regDCU_parityFBword4Byte1_SD = {fillBufMuxSel0[17],fillBufMuxSel1[17]};    	
   assign dp_regDCU_parityFBword4Byte1_D0 = p_PLB_dcuReadDataBus[1];    	
   assign dp_regDCU_parityFBword4Byte1_D1 = p_fillBuf_L2_i[17];    	
   assign dp_regDCU_parityFBword4Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword4Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword4Byte1_D0 or dp_regDCU_parityFBword4Byte1_D1 or dp_regDCU_parityFBword4Byte1_D2 or dp_regDCU_parityFBword4Byte1_D3 or dp_regDCU_parityFBword4Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte1_SD)			
     2'b00: dp_regDCU_parityFBword4Byte1_DataIn = dp_regDCU_parityFBword4Byte1_D0;	
     2'b01: dp_regDCU_parityFBword4Byte1_DataIn = dp_regDCU_parityFBword4Byte1_D1;	
     2'b10: dp_regDCU_parityFBword4Byte1_DataIn = dp_regDCU_parityFBword4Byte1_D2;	
     2'b11: dp_regDCU_parityFBword4Byte1_DataIn = dp_regDCU_parityFBword4Byte1_D3;	
      default: dp_regDCU_parityFBword4Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte1_E1)			
     1'b0: dp_regDCU_parityFBword4Byte1_regL2 <= dp_regDCU_parityFBword4Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword4Byte1_regL2 <= dp_regDCU_parityFBword4Byte1_DataIn;	
      default: dp_regDCU_parityFBword4Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword4Byte0
   reg dp_regDCU_parityFBword4Byte0_regL2;
   reg dp_regDCU_parityFBword4Byte0_DataIn;
   wire dp_regDCU_parityFBword4Byte0_D0,dp_regDCU_parityFBword4Byte0_D1; 
   wire dp_regDCU_parityFBword4Byte0_D2; 
   wire dp_regDCU_parityFBword4Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword4Byte0_SD; 
   wire dp_regDCU_parityFBword4Byte0_E1; 
   assign p_fillBuf_L2_i[16] = dp_regDCU_parityFBword4Byte0_regL2;     	
   assign dp_regDCU_parityFBword4Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[4];     
   assign dp_regDCU_parityFBword4Byte0_SD = {fillBufMuxSel0[16],fillBufMuxSel1[16]};    	
   assign dp_regDCU_parityFBword4Byte0_D0 = p_PLB_dcuReadDataBus[0];    	
   assign dp_regDCU_parityFBword4Byte0_D1 = p_fillBuf_L2_i[16];    	
   assign dp_regDCU_parityFBword4Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword4Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword4Byte0_D0 or dp_regDCU_parityFBword4Byte0_D1 or dp_regDCU_parityFBword4Byte0_D2 or dp_regDCU_parityFBword4Byte0_D3 or dp_regDCU_parityFBword4Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte0_SD)			
     2'b00: dp_regDCU_parityFBword4Byte0_DataIn = dp_regDCU_parityFBword4Byte0_D0;	
     2'b01: dp_regDCU_parityFBword4Byte0_DataIn = dp_regDCU_parityFBword4Byte0_D1;	
     2'b10: dp_regDCU_parityFBword4Byte0_DataIn = dp_regDCU_parityFBword4Byte0_D2;	
     2'b11: dp_regDCU_parityFBword4Byte0_DataIn = dp_regDCU_parityFBword4Byte0_D3;	
      default: dp_regDCU_parityFBword4Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword4Byte0_E1)			
     1'b0: dp_regDCU_parityFBword4Byte0_regL2 <= dp_regDCU_parityFBword4Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword4Byte0_regL2 <= dp_regDCU_parityFBword4Byte0_DataIn;	
      default: dp_regDCU_parityFBword4Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword3Byte3
   reg dp_regDCU_parityFBword3Byte3_regL2;
   reg dp_regDCU_parityFBword3Byte3_DataIn;
   wire dp_regDCU_parityFBword3Byte3_D0,dp_regDCU_parityFBword3Byte3_D1; 
   wire dp_regDCU_parityFBword3Byte3_D2; 
   wire dp_regDCU_parityFBword3Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword3Byte3_SD; 
   wire dp_regDCU_parityFBword3Byte3_E1; 
   assign p_fillBuf_L2_i[15] = dp_regDCU_parityFBword3Byte3_regL2;     	
   assign dp_regDCU_parityFBword3Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[3];     
   assign dp_regDCU_parityFBword3Byte3_SD = {fillBufMuxSel0[15],fillBufMuxSel1[15]};    	
   assign dp_regDCU_parityFBword3Byte3_D0 = p_PLB_dcuReadDataBus[7];    	
   assign dp_regDCU_parityFBword3Byte3_D1 = p_fillBuf_L2_i[15];    	
   assign dp_regDCU_parityFBword3Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword3Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword3Byte3_D0 or dp_regDCU_parityFBword3Byte3_D1 or dp_regDCU_parityFBword3Byte3_D2 or dp_regDCU_parityFBword3Byte3_D3 or dp_regDCU_parityFBword3Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte3_SD)			
     2'b00: dp_regDCU_parityFBword3Byte3_DataIn = dp_regDCU_parityFBword3Byte3_D0;	
     2'b01: dp_regDCU_parityFBword3Byte3_DataIn = dp_regDCU_parityFBword3Byte3_D1;	
     2'b10: dp_regDCU_parityFBword3Byte3_DataIn = dp_regDCU_parityFBword3Byte3_D2;	
     2'b11: dp_regDCU_parityFBword3Byte3_DataIn = dp_regDCU_parityFBword3Byte3_D3;	
      default: dp_regDCU_parityFBword3Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte3_E1)			
     1'b0: dp_regDCU_parityFBword3Byte3_regL2 <= dp_regDCU_parityFBword3Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword3Byte3_regL2 <= dp_regDCU_parityFBword3Byte3_DataIn;	
      default: dp_regDCU_parityFBword3Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword3Byte2
   reg dp_regDCU_parityFBword3Byte2_regL2;
   reg dp_regDCU_parityFBword3Byte2_DataIn;
   wire dp_regDCU_parityFBword3Byte2_D0,dp_regDCU_parityFBword3Byte2_D1; 
   wire dp_regDCU_parityFBword3Byte2_D2; 
   wire dp_regDCU_parityFBword3Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword3Byte2_SD; 
   wire dp_regDCU_parityFBword3Byte2_E1; 
   assign p_fillBuf_L2_i[14] = dp_regDCU_parityFBword3Byte2_regL2;     	
   assign dp_regDCU_parityFBword3Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[3];     
   assign dp_regDCU_parityFBword3Byte2_SD = {fillBufMuxSel0[14],fillBufMuxSel1[14]};    	
   assign dp_regDCU_parityFBword3Byte2_D0 = p_PLB_dcuReadDataBus[6];    	
   assign dp_regDCU_parityFBword3Byte2_D1 = p_fillBuf_L2_i[14];    	
   assign dp_regDCU_parityFBword3Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword3Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword3Byte2_D0 or dp_regDCU_parityFBword3Byte2_D1 or dp_regDCU_parityFBword3Byte2_D2 or dp_regDCU_parityFBword3Byte2_D3 or dp_regDCU_parityFBword3Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte2_SD)			
     2'b00: dp_regDCU_parityFBword3Byte2_DataIn = dp_regDCU_parityFBword3Byte2_D0;	
     2'b01: dp_regDCU_parityFBword3Byte2_DataIn = dp_regDCU_parityFBword3Byte2_D1;	
     2'b10: dp_regDCU_parityFBword3Byte2_DataIn = dp_regDCU_parityFBword3Byte2_D2;	
     2'b11: dp_regDCU_parityFBword3Byte2_DataIn = dp_regDCU_parityFBword3Byte2_D3;	
      default: dp_regDCU_parityFBword3Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte2_E1)			
     1'b0: dp_regDCU_parityFBword3Byte2_regL2 <= dp_regDCU_parityFBword3Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword3Byte2_regL2 <= dp_regDCU_parityFBword3Byte2_DataIn;	
      default: dp_regDCU_parityFBword3Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword3Byte1
   reg dp_regDCU_parityFBword3Byte1_regL2;
   reg dp_regDCU_parityFBword3Byte1_DataIn;
   wire dp_regDCU_parityFBword3Byte1_D0,dp_regDCU_parityFBword3Byte1_D1; 
   wire dp_regDCU_parityFBword3Byte1_D2; 
   wire dp_regDCU_parityFBword3Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword3Byte1_SD; 
   wire dp_regDCU_parityFBword3Byte1_E1; 
   assign p_fillBuf_L2_i[13] = dp_regDCU_parityFBword3Byte1_regL2;     	
   assign dp_regDCU_parityFBword3Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[3];     
   assign dp_regDCU_parityFBword3Byte1_SD = {fillBufMuxSel0[13],fillBufMuxSel1[13]};    	
   assign dp_regDCU_parityFBword3Byte1_D0 = p_PLB_dcuReadDataBus[5];    	
   assign dp_regDCU_parityFBword3Byte1_D1 = p_fillBuf_L2_i[13];    	
   assign dp_regDCU_parityFBword3Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword3Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword3Byte1_D0 or dp_regDCU_parityFBword3Byte1_D1 or dp_regDCU_parityFBword3Byte1_D2 or dp_regDCU_parityFBword3Byte1_D3 or dp_regDCU_parityFBword3Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte1_SD)			
     2'b00: dp_regDCU_parityFBword3Byte1_DataIn = dp_regDCU_parityFBword3Byte1_D0;	
     2'b01: dp_regDCU_parityFBword3Byte1_DataIn = dp_regDCU_parityFBword3Byte1_D1;	
     2'b10: dp_regDCU_parityFBword3Byte1_DataIn = dp_regDCU_parityFBword3Byte1_D2;	
     2'b11: dp_regDCU_parityFBword3Byte1_DataIn = dp_regDCU_parityFBword3Byte1_D3;	
      default: dp_regDCU_parityFBword3Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte1_E1)			
     1'b0: dp_regDCU_parityFBword3Byte1_regL2 <= dp_regDCU_parityFBword3Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword3Byte1_regL2 <= dp_regDCU_parityFBword3Byte1_DataIn;	
      default: dp_regDCU_parityFBword3Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword3Byte0
   reg dp_regDCU_parityFBword3Byte0_regL2;
   reg dp_regDCU_parityFBword3Byte0_DataIn;
   wire dp_regDCU_parityFBword3Byte0_D0,dp_regDCU_parityFBword3Byte0_D1; 
   wire dp_regDCU_parityFBword3Byte0_D2; 
   wire dp_regDCU_parityFBword3Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword3Byte0_SD; 
   wire dp_regDCU_parityFBword3Byte0_E1; 
   assign p_fillBuf_L2_i[12] = dp_regDCU_parityFBword3Byte0_regL2;     	
   assign dp_regDCU_parityFBword3Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[3];     
   assign dp_regDCU_parityFBword3Byte0_SD = {fillBufMuxSel0[12],fillBufMuxSel1[12]};    	
   assign dp_regDCU_parityFBword3Byte0_D0 = p_PLB_dcuReadDataBus[4];    	
   assign dp_regDCU_parityFBword3Byte0_D1 = p_fillBuf_L2_i[12];    	
   assign dp_regDCU_parityFBword3Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword3Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword3Byte0_D0 or dp_regDCU_parityFBword3Byte0_D1 or dp_regDCU_parityFBword3Byte0_D2 or dp_regDCU_parityFBword3Byte0_D3 or dp_regDCU_parityFBword3Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte0_SD)			
     2'b00: dp_regDCU_parityFBword3Byte0_DataIn = dp_regDCU_parityFBword3Byte0_D0;	
     2'b01: dp_regDCU_parityFBword3Byte0_DataIn = dp_regDCU_parityFBword3Byte0_D1;	
     2'b10: dp_regDCU_parityFBword3Byte0_DataIn = dp_regDCU_parityFBword3Byte0_D2;	
     2'b11: dp_regDCU_parityFBword3Byte0_DataIn = dp_regDCU_parityFBword3Byte0_D3;	
      default: dp_regDCU_parityFBword3Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword3Byte0_E1)			
     1'b0: dp_regDCU_parityFBword3Byte0_regL2 <= dp_regDCU_parityFBword3Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword3Byte0_regL2 <= dp_regDCU_parityFBword3Byte0_DataIn;	
      default: dp_regDCU_parityFBword3Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword2Byte3
   reg dp_regDCU_parityFBword2Byte3_regL2;
   reg dp_regDCU_parityFBword2Byte3_DataIn;
   wire dp_regDCU_parityFBword2Byte3_D0,dp_regDCU_parityFBword2Byte3_D1; 
   wire dp_regDCU_parityFBword2Byte3_D2; 
   wire dp_regDCU_parityFBword2Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword2Byte3_SD; 
   wire dp_regDCU_parityFBword2Byte3_E1; 
   assign p_fillBuf_L2_i[11] = dp_regDCU_parityFBword2Byte3_regL2;     	
   assign dp_regDCU_parityFBword2Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[2];     
   assign dp_regDCU_parityFBword2Byte3_SD = {fillBufMuxSel0[11],fillBufMuxSel1[11]};    	
   assign dp_regDCU_parityFBword2Byte3_D0 = p_PLB_dcuReadDataBus[3];    	
   assign dp_regDCU_parityFBword2Byte3_D1 = p_fillBuf_L2_i[11];    	
   assign dp_regDCU_parityFBword2Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword2Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword2Byte3_D0 or dp_regDCU_parityFBword2Byte3_D1 or dp_regDCU_parityFBword2Byte3_D2 or dp_regDCU_parityFBword2Byte3_D3 or dp_regDCU_parityFBword2Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte3_SD)			
     2'b00: dp_regDCU_parityFBword2Byte3_DataIn = dp_regDCU_parityFBword2Byte3_D0;	
     2'b01: dp_regDCU_parityFBword2Byte3_DataIn = dp_regDCU_parityFBword2Byte3_D1;	
     2'b10: dp_regDCU_parityFBword2Byte3_DataIn = dp_regDCU_parityFBword2Byte3_D2;	
     2'b11: dp_regDCU_parityFBword2Byte3_DataIn = dp_regDCU_parityFBword2Byte3_D3;	
      default: dp_regDCU_parityFBword2Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte3_E1)			
     1'b0: dp_regDCU_parityFBword2Byte3_regL2 <= dp_regDCU_parityFBword2Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword2Byte3_regL2 <= dp_regDCU_parityFBword2Byte3_DataIn;	
      default: dp_regDCU_parityFBword2Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword2Byte2
   reg dp_regDCU_parityFBword2Byte2_regL2;
   reg dp_regDCU_parityFBword2Byte2_DataIn;
   wire dp_regDCU_parityFBword2Byte2_D0,dp_regDCU_parityFBword2Byte2_D1; 
   wire dp_regDCU_parityFBword2Byte2_D2; 
   wire dp_regDCU_parityFBword2Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword2Byte2_SD; 
   wire dp_regDCU_parityFBword2Byte2_E1; 
   assign p_fillBuf_L2_i[10] = dp_regDCU_parityFBword2Byte2_regL2;     	
   assign dp_regDCU_parityFBword2Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[2];     
   assign dp_regDCU_parityFBword2Byte2_SD = {fillBufMuxSel0[10],fillBufMuxSel1[10]};    	
   assign dp_regDCU_parityFBword2Byte2_D0 = p_PLB_dcuReadDataBus[2];    	
   assign dp_regDCU_parityFBword2Byte2_D1 = p_fillBuf_L2_i[10];    	
   assign dp_regDCU_parityFBword2Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword2Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword2Byte2_D0 or dp_regDCU_parityFBword2Byte2_D1 or dp_regDCU_parityFBword2Byte2_D2 or dp_regDCU_parityFBword2Byte2_D3 or dp_regDCU_parityFBword2Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte2_SD)			
     2'b00: dp_regDCU_parityFBword2Byte2_DataIn = dp_regDCU_parityFBword2Byte2_D0;	
     2'b01: dp_regDCU_parityFBword2Byte2_DataIn = dp_regDCU_parityFBword2Byte2_D1;	
     2'b10: dp_regDCU_parityFBword2Byte2_DataIn = dp_regDCU_parityFBword2Byte2_D2;	
     2'b11: dp_regDCU_parityFBword2Byte2_DataIn = dp_regDCU_parityFBword2Byte2_D3;	
      default: dp_regDCU_parityFBword2Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte2_E1)			
     1'b0: dp_regDCU_parityFBword2Byte2_regL2 <= dp_regDCU_parityFBword2Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword2Byte2_regL2 <= dp_regDCU_parityFBword2Byte2_DataIn;	
      default: dp_regDCU_parityFBword2Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword2Byte1
   reg dp_regDCU_parityFBword2Byte1_regL2;
   reg dp_regDCU_parityFBword2Byte1_DataIn;
   wire dp_regDCU_parityFBword2Byte1_D0,dp_regDCU_parityFBword2Byte1_D1; 
   wire dp_regDCU_parityFBword2Byte1_D2; 
   wire dp_regDCU_parityFBword2Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword2Byte1_SD; 
   wire dp_regDCU_parityFBword2Byte1_E1; 
   assign p_fillBuf_L2_i[9] = dp_regDCU_parityFBword2Byte1_regL2;     	
   assign dp_regDCU_parityFBword2Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[2];     
   assign dp_regDCU_parityFBword2Byte1_SD = {fillBufMuxSel0[9],fillBufMuxSel1[9]};    	
   assign dp_regDCU_parityFBword2Byte1_D0 = p_PLB_dcuReadDataBus[1];    	
   assign dp_regDCU_parityFBword2Byte1_D1 = p_fillBuf_L2_i[9];    	
   assign dp_regDCU_parityFBword2Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword2Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword2Byte1_D0 or dp_regDCU_parityFBword2Byte1_D1 or dp_regDCU_parityFBword2Byte1_D2 or dp_regDCU_parityFBword2Byte1_D3 or dp_regDCU_parityFBword2Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte1_SD)			
     2'b00: dp_regDCU_parityFBword2Byte1_DataIn = dp_regDCU_parityFBword2Byte1_D0;	
     2'b01: dp_regDCU_parityFBword2Byte1_DataIn = dp_regDCU_parityFBword2Byte1_D1;	
     2'b10: dp_regDCU_parityFBword2Byte1_DataIn = dp_regDCU_parityFBword2Byte1_D2;	
     2'b11: dp_regDCU_parityFBword2Byte1_DataIn = dp_regDCU_parityFBword2Byte1_D3;	
      default: dp_regDCU_parityFBword2Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte1_E1)			
     1'b0: dp_regDCU_parityFBword2Byte1_regL2 <= dp_regDCU_parityFBword2Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword2Byte1_regL2 <= dp_regDCU_parityFBword2Byte1_DataIn;	
      default: dp_regDCU_parityFBword2Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword2Byte0
   reg dp_regDCU_parityFBword2Byte0_regL2;
   reg dp_regDCU_parityFBword2Byte0_DataIn;
   wire dp_regDCU_parityFBword2Byte0_D0,dp_regDCU_parityFBword2Byte0_D1; 
   wire dp_regDCU_parityFBword2Byte0_D2; 
   wire dp_regDCU_parityFBword2Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword2Byte0_SD; 
   wire dp_regDCU_parityFBword2Byte0_E1; 
   assign p_fillBuf_L2_i[8] = dp_regDCU_parityFBword2Byte0_regL2;     	
   assign dp_regDCU_parityFBword2Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[2];     
   assign dp_regDCU_parityFBword2Byte0_SD = {fillBufMuxSel0[8],fillBufMuxSel1[8]};    	
   assign dp_regDCU_parityFBword2Byte0_D0 = p_PLB_dcuReadDataBus[0];    	
   assign dp_regDCU_parityFBword2Byte0_D1 = p_fillBuf_L2_i[8];    	
   assign dp_regDCU_parityFBword2Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword2Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword2Byte0_D0 or dp_regDCU_parityFBword2Byte0_D1 or dp_regDCU_parityFBword2Byte0_D2 or dp_regDCU_parityFBword2Byte0_D3 or dp_regDCU_parityFBword2Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte0_SD)			
     2'b00: dp_regDCU_parityFBword2Byte0_DataIn = dp_regDCU_parityFBword2Byte0_D0;	
     2'b01: dp_regDCU_parityFBword2Byte0_DataIn = dp_regDCU_parityFBword2Byte0_D1;	
     2'b10: dp_regDCU_parityFBword2Byte0_DataIn = dp_regDCU_parityFBword2Byte0_D2;	
     2'b11: dp_regDCU_parityFBword2Byte0_DataIn = dp_regDCU_parityFBword2Byte0_D3;	
      default: dp_regDCU_parityFBword2Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword2Byte0_E1)			
     1'b0: dp_regDCU_parityFBword2Byte0_regL2 <= dp_regDCU_parityFBword2Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword2Byte0_regL2 <= dp_regDCU_parityFBword2Byte0_DataIn;	
      default: dp_regDCU_parityFBword2Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword1Byte3
   reg dp_regDCU_parityFBword1Byte3_regL2;
   reg dp_regDCU_parityFBword1Byte3_DataIn;
   wire dp_regDCU_parityFBword1Byte3_D0,dp_regDCU_parityFBword1Byte3_D1; 
   wire dp_regDCU_parityFBword1Byte3_D2; 
   wire dp_regDCU_parityFBword1Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword1Byte3_SD; 
   wire dp_regDCU_parityFBword1Byte3_E1; 
   assign p_fillBuf_L2_i[7] = dp_regDCU_parityFBword1Byte3_regL2;     	
   assign dp_regDCU_parityFBword1Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[1];     
   assign dp_regDCU_parityFBword1Byte3_SD = {fillBufMuxSel0[7],fillBufMuxSel1[7]};    	
   assign dp_regDCU_parityFBword1Byte3_D0 = p_PLB_dcuReadDataBus[7];    	
   assign dp_regDCU_parityFBword1Byte3_D1 = p_fillBuf_L2_i[7];    	
   assign dp_regDCU_parityFBword1Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword1Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword1Byte3_D0 or dp_regDCU_parityFBword1Byte3_D1 or dp_regDCU_parityFBword1Byte3_D2 or dp_regDCU_parityFBword1Byte3_D3 or dp_regDCU_parityFBword1Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte3_SD)			
     2'b00: dp_regDCU_parityFBword1Byte3_DataIn = dp_regDCU_parityFBword1Byte3_D0;	
     2'b01: dp_regDCU_parityFBword1Byte3_DataIn = dp_regDCU_parityFBword1Byte3_D1;	
     2'b10: dp_regDCU_parityFBword1Byte3_DataIn = dp_regDCU_parityFBword1Byte3_D2;	
     2'b11: dp_regDCU_parityFBword1Byte3_DataIn = dp_regDCU_parityFBword1Byte3_D3;	
      default: dp_regDCU_parityFBword1Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte3_E1)			
     1'b0: dp_regDCU_parityFBword1Byte3_regL2 <= dp_regDCU_parityFBword1Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword1Byte3_regL2 <= dp_regDCU_parityFBword1Byte3_DataIn;	
      default: dp_regDCU_parityFBword1Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword1Byte2
   reg dp_regDCU_parityFBword1Byte2_regL2;
   reg dp_regDCU_parityFBword1Byte2_DataIn;
   wire dp_regDCU_parityFBword1Byte2_D0,dp_regDCU_parityFBword1Byte2_D1; 
   wire dp_regDCU_parityFBword1Byte2_D2; 
   wire dp_regDCU_parityFBword1Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword1Byte2_SD; 
   wire dp_regDCU_parityFBword1Byte2_E1; 
   assign p_fillBuf_L2_i[6] = dp_regDCU_parityFBword1Byte2_regL2;     	
   assign dp_regDCU_parityFBword1Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[1];     
   assign dp_regDCU_parityFBword1Byte2_SD = {fillBufMuxSel0[6],fillBufMuxSel1[6]};    	
   assign dp_regDCU_parityFBword1Byte2_D0 = p_PLB_dcuReadDataBus[6];    	
   assign dp_regDCU_parityFBword1Byte2_D1 = p_fillBuf_L2_i[6];    	
   assign dp_regDCU_parityFBword1Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword1Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword1Byte2_D0 or dp_regDCU_parityFBword1Byte2_D1 or dp_regDCU_parityFBword1Byte2_D2 or dp_regDCU_parityFBword1Byte2_D3 or dp_regDCU_parityFBword1Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte2_SD)			
     2'b00: dp_regDCU_parityFBword1Byte2_DataIn = dp_regDCU_parityFBword1Byte2_D0;	
     2'b01: dp_regDCU_parityFBword1Byte2_DataIn = dp_regDCU_parityFBword1Byte2_D1;	
     2'b10: dp_regDCU_parityFBword1Byte2_DataIn = dp_regDCU_parityFBword1Byte2_D2;	
     2'b11: dp_regDCU_parityFBword1Byte2_DataIn = dp_regDCU_parityFBword1Byte2_D3;	
      default: dp_regDCU_parityFBword1Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte2_E1)			
     1'b0: dp_regDCU_parityFBword1Byte2_regL2 <= dp_regDCU_parityFBword1Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword1Byte2_regL2 <= dp_regDCU_parityFBword1Byte2_DataIn;	
      default: dp_regDCU_parityFBword1Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword1Byte1
   reg dp_regDCU_parityFBword1Byte1_regL2;
   reg dp_regDCU_parityFBword1Byte1_DataIn;
   wire dp_regDCU_parityFBword1Byte1_D0,dp_regDCU_parityFBword1Byte1_D1; 
   wire dp_regDCU_parityFBword1Byte1_D2; 
   wire dp_regDCU_parityFBword1Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword1Byte1_SD; 
   wire dp_regDCU_parityFBword1Byte1_E1; 
   assign p_fillBuf_L2_i[5] = dp_regDCU_parityFBword1Byte1_regL2;     	
   assign dp_regDCU_parityFBword1Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[1];     
   assign dp_regDCU_parityFBword1Byte1_SD = {fillBufMuxSel0[5],fillBufMuxSel1[5]};    	
   assign dp_regDCU_parityFBword1Byte1_D0 = p_PLB_dcuReadDataBus[5];    	
   assign dp_regDCU_parityFBword1Byte1_D1 = p_fillBuf_L2_i[5];    	
   assign dp_regDCU_parityFBword1Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword1Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword1Byte1_D0 or dp_regDCU_parityFBword1Byte1_D1 or dp_regDCU_parityFBword1Byte1_D2 or dp_regDCU_parityFBword1Byte1_D3 or dp_regDCU_parityFBword1Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte1_SD)			
     2'b00: dp_regDCU_parityFBword1Byte1_DataIn = dp_regDCU_parityFBword1Byte1_D0;	
     2'b01: dp_regDCU_parityFBword1Byte1_DataIn = dp_regDCU_parityFBword1Byte1_D1;	
     2'b10: dp_regDCU_parityFBword1Byte1_DataIn = dp_regDCU_parityFBword1Byte1_D2;	
     2'b11: dp_regDCU_parityFBword1Byte1_DataIn = dp_regDCU_parityFBword1Byte1_D3;	
      default: dp_regDCU_parityFBword1Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte1_E1)			
     1'b0: dp_regDCU_parityFBword1Byte1_regL2 <= dp_regDCU_parityFBword1Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword1Byte1_regL2 <= dp_regDCU_parityFBword1Byte1_DataIn;	
      default: dp_regDCU_parityFBword1Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword1Byte0
   reg dp_regDCU_parityFBword1Byte0_regL2;
   reg dp_regDCU_parityFBword1Byte0_DataIn;
   wire dp_regDCU_parityFBword1Byte0_D0,dp_regDCU_parityFBword1Byte0_D1; 
   wire dp_regDCU_parityFBword1Byte0_D2; 
   wire dp_regDCU_parityFBword1Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword1Byte0_SD; 
   wire dp_regDCU_parityFBword1Byte0_E1; 
   assign p_fillBuf_L2_i[4] = dp_regDCU_parityFBword1Byte0_regL2;     	
   assign dp_regDCU_parityFBword1Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[1];     
   assign dp_regDCU_parityFBword1Byte0_SD = {fillBufMuxSel0[4],fillBufMuxSel1[4]};    	
   assign dp_regDCU_parityFBword1Byte0_D0 = p_PLB_dcuReadDataBus[4];    	
   assign dp_regDCU_parityFBword1Byte0_D1 = p_fillBuf_L2_i[4];    	
   assign dp_regDCU_parityFBword1Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword1Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword1Byte0_D0 or dp_regDCU_parityFBword1Byte0_D1 or dp_regDCU_parityFBword1Byte0_D2 or dp_regDCU_parityFBword1Byte0_D3 or dp_regDCU_parityFBword1Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte0_SD)			
     2'b00: dp_regDCU_parityFBword1Byte0_DataIn = dp_regDCU_parityFBword1Byte0_D0;	
     2'b01: dp_regDCU_parityFBword1Byte0_DataIn = dp_regDCU_parityFBword1Byte0_D1;	
     2'b10: dp_regDCU_parityFBword1Byte0_DataIn = dp_regDCU_parityFBword1Byte0_D2;	
     2'b11: dp_regDCU_parityFBword1Byte0_DataIn = dp_regDCU_parityFBword1Byte0_D3;	
      default: dp_regDCU_parityFBword1Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword1Byte0_E1)			
     1'b0: dp_regDCU_parityFBword1Byte0_regL2 <= dp_regDCU_parityFBword1Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword1Byte0_regL2 <= dp_regDCU_parityFBword1Byte0_DataIn;	
      default: dp_regDCU_parityFBword1Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword0Byte3
   reg dp_regDCU_parityFBword0Byte3_regL2;
   reg dp_regDCU_parityFBword0Byte3_DataIn;
   wire dp_regDCU_parityFBword0Byte3_D0,dp_regDCU_parityFBword0Byte3_D1; 
   wire dp_regDCU_parityFBword0Byte3_D2; 
   wire dp_regDCU_parityFBword0Byte3_D3; 
   wire [0:1] dp_regDCU_parityFBword0Byte3_SD; 
   wire dp_regDCU_parityFBword0Byte3_E1; 
   assign p_fillBuf_L2_i[3] = dp_regDCU_parityFBword0Byte3_regL2;     	
   assign dp_regDCU_parityFBword0Byte3_E1 = fillBufByte3_E1 & fillBuf_E2_byte23[0];     
   assign dp_regDCU_parityFBword0Byte3_SD = {fillBufMuxSel0[3],fillBufMuxSel1[3]};    	
   assign dp_regDCU_parityFBword0Byte3_D0 = p_PLB_dcuReadDataBus[3];    	
   assign dp_regDCU_parityFBword0Byte3_D1 = p_fillBuf_L2_i[3];    	
   assign dp_regDCU_parityFBword0Byte3_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword0Byte3_D3 = p_SDQ_SDP_mux[3];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword0Byte3_D0 or dp_regDCU_parityFBword0Byte3_D1 or dp_regDCU_parityFBword0Byte3_D2 or dp_regDCU_parityFBword0Byte3_D3 or dp_regDCU_parityFBword0Byte3_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte3_SD)			
     2'b00: dp_regDCU_parityFBword0Byte3_DataIn = dp_regDCU_parityFBword0Byte3_D0;	
     2'b01: dp_regDCU_parityFBword0Byte3_DataIn = dp_regDCU_parityFBword0Byte3_D1;	
     2'b10: dp_regDCU_parityFBword0Byte3_DataIn = dp_regDCU_parityFBword0Byte3_D2;	
     2'b11: dp_regDCU_parityFBword0Byte3_DataIn = dp_regDCU_parityFBword0Byte3_D3;	
      default: dp_regDCU_parityFBword0Byte3_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte3_E1)			
     1'b0: dp_regDCU_parityFBword0Byte3_regL2 <= dp_regDCU_parityFBword0Byte3_regL2;		
     1'b1: dp_regDCU_parityFBword0Byte3_regL2 <= dp_regDCU_parityFBword0Byte3_DataIn;	
      default: dp_regDCU_parityFBword0Byte3_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword0Byte2
   reg dp_regDCU_parityFBword0Byte2_regL2;
   reg dp_regDCU_parityFBword0Byte2_DataIn;
   wire dp_regDCU_parityFBword0Byte2_D0,dp_regDCU_parityFBword0Byte2_D1; 
   wire dp_regDCU_parityFBword0Byte2_D2; 
   wire dp_regDCU_parityFBword0Byte2_D3; 
   wire [0:1] dp_regDCU_parityFBword0Byte2_SD; 
   wire dp_regDCU_parityFBword0Byte2_E1; 
   assign p_fillBuf_L2_i[2] = dp_regDCU_parityFBword0Byte2_regL2;     	
   assign dp_regDCU_parityFBword0Byte2_E1 = fillBufByte2_E1 & fillBuf_E2_byte23[0];     
   assign dp_regDCU_parityFBword0Byte2_SD = {fillBufMuxSel0[2],fillBufMuxSel1[2]};    	
   assign dp_regDCU_parityFBword0Byte2_D0 = p_PLB_dcuReadDataBus[2];    	
   assign dp_regDCU_parityFBword0Byte2_D1 = p_fillBuf_L2_i[2];    	
   assign dp_regDCU_parityFBword0Byte2_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword0Byte2_D3 = p_SDQ_SDP_mux[2];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword0Byte2_D0 or dp_regDCU_parityFBword0Byte2_D1 or dp_regDCU_parityFBword0Byte2_D2 or dp_regDCU_parityFBword0Byte2_D3 or dp_regDCU_parityFBword0Byte2_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte2_SD)			
     2'b00: dp_regDCU_parityFBword0Byte2_DataIn = dp_regDCU_parityFBword0Byte2_D0;	
     2'b01: dp_regDCU_parityFBword0Byte2_DataIn = dp_regDCU_parityFBword0Byte2_D1;	
     2'b10: dp_regDCU_parityFBword0Byte2_DataIn = dp_regDCU_parityFBword0Byte2_D2;	
     2'b11: dp_regDCU_parityFBword0Byte2_DataIn = dp_regDCU_parityFBword0Byte2_D3;	
      default: dp_regDCU_parityFBword0Byte2_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte2_E1)			
     1'b0: dp_regDCU_parityFBword0Byte2_regL2 <= dp_regDCU_parityFBword0Byte2_regL2;		
     1'b1: dp_regDCU_parityFBword0Byte2_regL2 <= dp_regDCU_parityFBword0Byte2_DataIn;	
      default: dp_regDCU_parityFBword0Byte2_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword0Byte1
   reg dp_regDCU_parityFBword0Byte1_regL2;
   reg dp_regDCU_parityFBword0Byte1_DataIn;
   wire dp_regDCU_parityFBword0Byte1_D0,dp_regDCU_parityFBword0Byte1_D1; 
   wire dp_regDCU_parityFBword0Byte1_D2; 
   wire dp_regDCU_parityFBword0Byte1_D3; 
   wire [0:1] dp_regDCU_parityFBword0Byte1_SD; 
   wire dp_regDCU_parityFBword0Byte1_E1; 
   assign p_fillBuf_L2_i[1] = dp_regDCU_parityFBword0Byte1_regL2;     	
   assign dp_regDCU_parityFBword0Byte1_E1 = fillBufByte1_E1 & fillBuf_E2_byte01[0];     
   assign dp_regDCU_parityFBword0Byte1_SD = {fillBufMuxSel0[1],fillBufMuxSel1[1]};    	
   assign dp_regDCU_parityFBword0Byte1_D0 = p_PLB_dcuReadDataBus[1];    	
   assign dp_regDCU_parityFBword0Byte1_D1 = p_fillBuf_L2_i[1];    	
   assign dp_regDCU_parityFBword0Byte1_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword0Byte1_D3 = p_SDQ_SDP_mux[1];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword0Byte1_D0 or dp_regDCU_parityFBword0Byte1_D1 or dp_regDCU_parityFBword0Byte1_D2 or dp_regDCU_parityFBword0Byte1_D3 or dp_regDCU_parityFBword0Byte1_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte1_SD)			
     2'b00: dp_regDCU_parityFBword0Byte1_DataIn = dp_regDCU_parityFBword0Byte1_D0;	
     2'b01: dp_regDCU_parityFBword0Byte1_DataIn = dp_regDCU_parityFBword0Byte1_D1;	
     2'b10: dp_regDCU_parityFBword0Byte1_DataIn = dp_regDCU_parityFBword0Byte1_D2;	
     2'b11: dp_regDCU_parityFBword0Byte1_DataIn = dp_regDCU_parityFBword0Byte1_D3;	
      default: dp_regDCU_parityFBword0Byte1_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte1_E1)			
     1'b0: dp_regDCU_parityFBword0Byte1_regL2 <= dp_regDCU_parityFBword0Byte1_regL2;		
     1'b1: dp_regDCU_parityFBword0Byte1_regL2 <= dp_regDCU_parityFBword0Byte1_DataIn;	
      default: dp_regDCU_parityFBword0Byte1_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P4EUL2 dp_regDCU_parityFBword0Byte0
   reg dp_regDCU_parityFBword0Byte0_regL2;
   reg dp_regDCU_parityFBword0Byte0_DataIn;
   wire dp_regDCU_parityFBword0Byte0_D0,dp_regDCU_parityFBword0Byte0_D1; 
   wire dp_regDCU_parityFBword0Byte0_D2; 
   wire dp_regDCU_parityFBword0Byte0_D3; 
   wire [0:1] dp_regDCU_parityFBword0Byte0_SD; 
   wire dp_regDCU_parityFBword0Byte0_E1; 
   assign p_fillBuf_L2_i[0] = dp_regDCU_parityFBword0Byte0_regL2;     	
   assign dp_regDCU_parityFBword0Byte0_E1 = fillBufByte0_E1 & fillBuf_E2_byte01[0];     
   assign dp_regDCU_parityFBword0Byte0_SD = {fillBufMuxSel0[0],fillBufMuxSel1[0]};    	
   assign dp_regDCU_parityFBword0Byte0_D0 = p_PLB_dcuReadDataBus[0];    	
   assign dp_regDCU_parityFBword0Byte0_D1 = p_fillBuf_L2_i[0];    	
   assign dp_regDCU_parityFBword0Byte0_D2 = 1'b0;    	
   assign dp_regDCU_parityFBword0Byte0_D3 = p_SDQ_SDP_mux[0];    	
                                           
   // 4-1 Mux input to register	      	
   always @(dp_regDCU_parityFBword0Byte0_D0 or dp_regDCU_parityFBword0Byte0_D1 or dp_regDCU_parityFBword0Byte0_D2 or dp_regDCU_parityFBword0Byte0_D3 or dp_regDCU_parityFBword0Byte0_SD)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte0_SD)			
     2'b00: dp_regDCU_parityFBword0Byte0_DataIn = dp_regDCU_parityFBword0Byte0_D0;	
     2'b01: dp_regDCU_parityFBword0Byte0_DataIn = dp_regDCU_parityFBword0Byte0_D1;	
     2'b10: dp_regDCU_parityFBword0Byte0_DataIn = dp_regDCU_parityFBword0Byte0_D2;	
     2'b11: dp_regDCU_parityFBword0Byte0_DataIn = dp_regDCU_parityFBword0Byte0_D3;	
      default: dp_regDCU_parityFBword0Byte0_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityFBword0Byte0_E1)			
     1'b0: dp_regDCU_parityFBword0Byte0_regL2 <= dp_regDCU_parityFBword0Byte0_regL2;		
     1'b1: dp_regDCU_parityFBword0Byte0_regL2 <= dp_regDCU_parityFBword0Byte0_DataIn;	
      default: dp_regDCU_parityFBword0Byte0_regL2 <= 1'bx;  
    endcase		 		
   end			 		


//--------- end -----------------

endmodule
