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

module p405s_DCU_holdReg( holdDataRegWord0_L2,
                          holdDataRegWord1_L2,
                          holdDataRegWord2_L2,
                          holdDataRegWord3_L2,
                          p_holdDataReg_L2,
                          CB,
                          FDR_hi_E1,
                          FDR_holdMuxSel,
                          dataOut_A,
                          p_aSideErrorRaw,
                          dataOut_B,
                          p_bSideErrorRaw,
                          tagParityError,
                          flushHold_E2)
                         ;

output [0:31]  holdDataRegWord0_L2;
output [0:31]  holdDataRegWord1_L2;
output [0:31]  holdDataRegWord2_L2;
output [0:31]  holdDataRegWord3_L2;

input CB;
input [0:3]  FDR_hi_E1;
input [0:3]  flushHold_E2;
input [0:127]  dataOut_A;
input [0:127]  dataOut_B;
input [0:3]  FDR_holdMuxSel;

//--------- start ---------------
// rgoldiez - added a parity error latch bit to the holdReg which could feed the FDR
//            need the error signals for a/b which will get latched into this new bit
//
//            added the new output p_holdDataReg_L2, which says there is an error the holdDR
//              half line

input  p_aSideErrorRaw;
input  p_bSideErrorRaw;
input  tagParityError;
output p_holdDataReg_L2;

//--------- end -----------------

// Removed the module 'module dp_regDCU_holdWord3Byte0
// Removed the module 'module dp_regDCU_holdWord3Byte1
// Removed the module 'module dp_regDCU_holdWord3Byte2
// Removed the module 'module dp_regDCU_holdWord3Byte3
// Removed the module 'module dp_regDCU_holdWord2Byte0
// Removed the module 'module dp_regDCU_holdWord2Byte1
// Removed the module 'module dp_regDCU_holdWord2Byte2
// Removed the module 'module dp_regDCU_holdWord2Byte3
// Removed the module 'module dp_regDCU_holdWord1Byte0
// Removed the module 'module dp_regDCU_holdWord1Byte1
// Removed the module 'module dp_regDCU_holdWord1Byte2
// Removed the module 'module dp_regDCU_holdWord1Byte3
// Removed the module 'module dp_regDCU_holdWord0Byte0
// Removed the module 'module dp_regDCU_holdWord0Byte1
// Removed the module 'module dp_regDCU_holdWord0Byte2
// Removed the module 'module dp_regDCU_holdWord0Byte3

   reg [0:127] dp_Reg_DataIn;
   reg [0:31]  holdDataRegWord3_L2n;
   wire [0:31] holdDataRegWord3_L2;   
   assign      holdDataRegWord3_L2 = ~holdDataRegWord3_L2n;
   
   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[3])                    
	  1'b0: dp_Reg_DataIn[120:127] = dataOut_B[120:127];   
	  1'b1: dp_Reg_DataIn[120:127] = dataOut_A[120:127];   
	  default: dp_Reg_DataIn[120:127] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[3] & flushHold_E2[3])                        
	  1'b0: holdDataRegWord3_L2n[24:31] <= holdDataRegWord3_L2n[24:31];                
	  1'b1: holdDataRegWord3_L2n[24:31] <= dp_Reg_DataIn[120:127];       
	  default: holdDataRegWord3_L2n[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[2])                    
	  1'b0: dp_Reg_DataIn[112:119] = dataOut_B[112:119];   
	  1'b1: dp_Reg_DataIn[112:119] = dataOut_A[112:119];   
	  default: dp_Reg_DataIn[112:119] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[2] & flushHold_E2[2])                        
	  1'b0: holdDataRegWord3_L2n[16:23] <= holdDataRegWord3_L2n[16:23];                
	  1'b1: holdDataRegWord3_L2n[16:23] <= dp_Reg_DataIn[112:119];       
	  default: holdDataRegWord3_L2n[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[1])                    
	  1'b0: dp_Reg_DataIn[104:111] = dataOut_B[104:111];   
	  1'b1: dp_Reg_DataIn[104:111] = dataOut_A[104:111];   
	  default: dp_Reg_DataIn[104:111] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[1] & flushHold_E2[1])                        
	  1'b0: holdDataRegWord3_L2n[8:15] <= holdDataRegWord3_L2n[8:15];                
	  1'b1: holdDataRegWord3_L2n[8:15] <= dp_Reg_DataIn[104:111];       
	  default: holdDataRegWord3_L2n[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[0])                    
	  1'b0: dp_Reg_DataIn[96:103] = dataOut_B[96:103];   
	  1'b1: dp_Reg_DataIn[96:103] = dataOut_A[96:103];   
	  default: dp_Reg_DataIn[96:103] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[0] & flushHold_E2[0])                        
	  1'b0: holdDataRegWord3_L2n[0:7] <= holdDataRegWord3_L2n[0:7];                
	  1'b1: holdDataRegWord3_L2n[0:7] <= dp_Reg_DataIn[96:103];       
	  default: holdDataRegWord3_L2n[0:7] <= 8'bx;  
	endcase                             
     end                                  


   reg [0:31]  holdDataRegWord2_L2n;
   wire [0:31] holdDataRegWord2_L2;   
   assign      holdDataRegWord2_L2 = ~holdDataRegWord2_L2n;
   
   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[3])                    
	  1'b0: dp_Reg_DataIn[88:95] = dataOut_B[88:95];   
	  1'b1: dp_Reg_DataIn[88:95] = dataOut_A[88:95];   
	  default: dp_Reg_DataIn[88:95] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[3] & flushHold_E2[3])                        
	  1'b0: holdDataRegWord2_L2n[24:31] <= holdDataRegWord2_L2n[24:31];                
	  1'b1: holdDataRegWord2_L2n[24:31] <= dp_Reg_DataIn[88:95];       
	  default: holdDataRegWord2_L2n[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[2])                    
	  1'b0: dp_Reg_DataIn[80:87] = dataOut_B[80:87];   
	  1'b1: dp_Reg_DataIn[80:87] = dataOut_A[80:87];   
	  default: dp_Reg_DataIn[80:87] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[2] & flushHold_E2[2])                        
	  1'b0: holdDataRegWord2_L2n[16:23] <= holdDataRegWord2_L2n[16:23];                
	  1'b1: holdDataRegWord2_L2n[16:23] <= dp_Reg_DataIn[80:87];       
	  default: holdDataRegWord2_L2n[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[1])                    
	  1'b0: dp_Reg_DataIn[72:79] = dataOut_B[72:79];   
	  1'b1: dp_Reg_DataIn[72:79] = dataOut_A[72:79];   
	  default: dp_Reg_DataIn[72:79] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[1] & flushHold_E2[1])                        
	  1'b0: holdDataRegWord2_L2n[8:15] <= holdDataRegWord2_L2n[8:15];                
	  1'b1: holdDataRegWord2_L2n[8:15] <= dp_Reg_DataIn[72:79];       
	  default: holdDataRegWord2_L2n[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[0])                    
	  1'b0: dp_Reg_DataIn[64:71] = dataOut_B[64:71];   
	  1'b1: dp_Reg_DataIn[64:71] = dataOut_A[64:71];   
	  default: dp_Reg_DataIn[64:71] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[0] & flushHold_E2[0])                        
	  1'b0: holdDataRegWord2_L2n[0:7] <= holdDataRegWord2_L2n[0:7];                
	  1'b1: holdDataRegWord2_L2n[0:7] <= dp_Reg_DataIn[64:71];       
	  default: holdDataRegWord2_L2n[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31]  holdDataRegWord1_L2n;
   wire [0:31] holdDataRegWord1_L2;   
   assign      holdDataRegWord1_L2 = ~holdDataRegWord1_L2n;
   
   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[3])                    
	  1'b0: dp_Reg_DataIn[56:63] = dataOut_B[56:63];   
	  1'b1: dp_Reg_DataIn[56:63] = dataOut_A[56:63];   
	  default: dp_Reg_DataIn[56:63] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[3] & flushHold_E2[3])                        
	  1'b0: holdDataRegWord1_L2n[24:31] <= holdDataRegWord1_L2n[24:31];                
	  1'b1: holdDataRegWord1_L2n[24:31] <= dp_Reg_DataIn[56:63];       
	  default: holdDataRegWord1_L2n[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[2])                    
	  1'b0: dp_Reg_DataIn[48:55] = dataOut_B[48:55];   
	  1'b1: dp_Reg_DataIn[48:55] = dataOut_A[48:55];   
	  default: dp_Reg_DataIn[48:55] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[2] & flushHold_E2[2])                        
	  1'b0: holdDataRegWord1_L2n[16:23] <= holdDataRegWord1_L2n[16:23];                
	  1'b1: holdDataRegWord1_L2n[16:23] <= dp_Reg_DataIn[48:55];       
	  default: holdDataRegWord1_L2n[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[1])                    
	  1'b0: dp_Reg_DataIn[40:47] = dataOut_B[40:47];   
	  1'b1: dp_Reg_DataIn[40:47] = dataOut_A[40:47];   
	  default: dp_Reg_DataIn[40:47] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[1] & flushHold_E2[1])                        
	  1'b0: holdDataRegWord1_L2n[8:15] <= holdDataRegWord1_L2n[8:15];                
	  1'b1: holdDataRegWord1_L2n[8:15] <= dp_Reg_DataIn[40:47];       
	  default: holdDataRegWord1_L2n[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[0])                    
	  1'b0: dp_Reg_DataIn[32:39] = dataOut_B[32:39];   
	  1'b1: dp_Reg_DataIn[32:39] = dataOut_A[32:39];   
	  default: dp_Reg_DataIn[32:39] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[0] & flushHold_E2[0])                        
	  1'b0: holdDataRegWord1_L2n[0:7] <= holdDataRegWord1_L2n[0:7];                
	  1'b1: holdDataRegWord1_L2n[0:7] <= dp_Reg_DataIn[32:39];       
	  default: holdDataRegWord1_L2n[0:7] <= 8'bx;  
	endcase                             
     end                                  

   reg [0:31]  holdDataRegWord0_L2n;
   wire [0:31] holdDataRegWord0_L2;   
   assign      holdDataRegWord0_L2 = ~holdDataRegWord0_L2n;
   
   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[3])                    
	  1'b0: dp_Reg_DataIn[24:31] = dataOut_B[24:31];   
	  1'b1: dp_Reg_DataIn[24:31] = dataOut_A[24:31];   
	  default: dp_Reg_DataIn[24:31] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[3] & flushHold_E2[3])                        
	  1'b0: holdDataRegWord0_L2n[24:31] <= holdDataRegWord0_L2n[24:31];                
	  1'b1: holdDataRegWord0_L2n[24:31] <= dp_Reg_DataIn[24:31];       
	  default: holdDataRegWord0_L2n[24:31] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[2])                    
	  1'b0: dp_Reg_DataIn[16:23] = dataOut_B[16:23];   
	  1'b1: dp_Reg_DataIn[16:23] = dataOut_A[16:23];   
	  default: dp_Reg_DataIn[16:23] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[2] & flushHold_E2[2])                        
	  1'b0: holdDataRegWord0_L2n[16:23] <= holdDataRegWord0_L2n[16:23];                
	  1'b1: holdDataRegWord0_L2n[16:23] <= dp_Reg_DataIn[16:23];       
	  default: holdDataRegWord0_L2n[16:23] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[1])                    
	  1'b0: dp_Reg_DataIn[8:15] = dataOut_B[8:15];   
	  1'b1: dp_Reg_DataIn[8:15] = dataOut_A[8:15];   
	  default: dp_Reg_DataIn[8:15] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[1] & flushHold_E2[1])                        
	  1'b0: holdDataRegWord0_L2n[8:15] <= holdDataRegWord0_L2n[8:15];                
	  1'b1: holdDataRegWord0_L2n[8:15] <= dp_Reg_DataIn[8:15];       
	  default: holdDataRegWord0_L2n[8:15] <= 8'bx;  
	endcase                             
     end                                  

   always @(FDR_holdMuxSel or dataOut_B or dataOut_A)        
     begin                                       
	case(FDR_holdMuxSel[0])                    
	  1'b0: dp_Reg_DataIn[0:7] = dataOut_B[0:7];   
	  1'b1: dp_Reg_DataIn[0:7] = dataOut_A[0:7];   
	  default: dp_Reg_DataIn[0:7] = 8'bx;  
	endcase                             
     end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
     begin                                       
	case(FDR_hi_E1[0] & flushHold_E2[0])                        
	  1'b0: holdDataRegWord0_L2n[0:7] <= holdDataRegWord0_L2n[0:7];                
	  1'b1: holdDataRegWord0_L2n[0:7] <= dp_Reg_DataIn[0:7];       
	  default: holdDataRegWord0_L2n[0:7] <= 8'bx;  
	endcase                             
     end                                  

//--------- start ---------------
// rgoldiez - added a parity error latch bit to the holdReg which could feed the FDR
   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_parityHoldErrorBit
   reg dp_regDCU_parityHoldErrorBit_regL2;
   reg dp_regDCU_parityHoldErrorBit_DataIn;
   wire dp_regDCU_parityHoldErrorBit_D0,dp_regDCU_parityHoldErrorBit_D1; 
   wire dp_regDCU_parityHoldErrorBit_SD; 
   wire dp_regDCU_parityHoldErrorBit_E1; 
   assign p_holdDataReg_L2 = dp_regDCU_parityHoldErrorBit_regL2;     	
   assign dp_regDCU_parityHoldErrorBit_E1 = FDR_hi_E1[3] & flushHold_E2[3];     
   assign dp_regDCU_parityHoldErrorBit_SD = FDR_holdMuxSel[3];    	
   assign dp_regDCU_parityHoldErrorBit_D0 = (p_bSideErrorRaw | tagParityError);    	
   assign dp_regDCU_parityHoldErrorBit_D1 = (p_aSideErrorRaw | tagParityError);    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_parityHoldErrorBit_D0 or dp_regDCU_parityHoldErrorBit_D1 or dp_regDCU_parityHoldErrorBit_SD)  	
    begin				  	
    case(dp_regDCU_parityHoldErrorBit_SD)			
     1'b0: dp_regDCU_parityHoldErrorBit_DataIn = dp_regDCU_parityHoldErrorBit_D0;	
     1'b1: dp_regDCU_parityHoldErrorBit_DataIn = dp_regDCU_parityHoldErrorBit_D1;	
      default: dp_regDCU_parityHoldErrorBit_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    case(dp_regDCU_parityHoldErrorBit_E1)			
     1'b0: dp_regDCU_parityHoldErrorBit_regL2 <= dp_regDCU_parityHoldErrorBit_regL2;		
     1'b1: dp_regDCU_parityHoldErrorBit_regL2 <= dp_regDCU_parityHoldErrorBit_DataIn;	
      default: dp_regDCU_parityHoldErrorBit_regL2 <= 1'bx;  
    endcase		 		
   end			 		

//--------- end -----------------

endmodule
