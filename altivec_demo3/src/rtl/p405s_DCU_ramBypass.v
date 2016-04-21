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

module p405s_DCU_ramBypass( wordMuxA,
                            wordMuxB,
                            p_ramBypassA,
                            p_ramBypassB,
                            CAR_buf2,
                            CAR_buf3,
                            dataOut_A,
                            dataOut_B,
                            p_dataOutA,
                            p_dataOutB
                           );


output [0:31]  wordMuxA;
output [0:31]  wordMuxB;


input [0:127]  dataOut_A;
input [0:127]  dataOut_B;
input [28:29]  CAR_buf2;
input [28:29]  CAR_buf3;

//--------- start ---------------
// rgoldiez - Added the new ports for the parity for each byte of A/B
input [0:15]   p_dataOutA;
input [0:15]   p_dataOutB;
output [0:3]   p_ramBypassA;
output [0:3]   p_ramBypassB;
//--------- end -----------------

reg [0:31]  wordMuxA;
reg [0:31]  wordMuxB;


// Removed the module 'dp_muxDCU_wordSelBByte0'
always @(dataOut_B or CAR_buf2)
    begin                                           
    case(CAR_buf2[28:29])                       
     2'b00: wordMuxB[0:7] = ~dataOut_B[0:7];
     2'b01: wordMuxB[0:7] = ~dataOut_B[32:39];   
     2'b10: wordMuxB[0:7] = ~dataOut_B[64:71];   
     2'b11: wordMuxB[0:7] = ~dataOut_B[96:103];   
      default: wordMuxB[0:7] = 8'bx;   
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_wordSelBByte1'
always @(dataOut_B or CAR_buf2)
    begin                                           
    case(CAR_buf2[28:29])                       
     2'b00: wordMuxB[8:15] = ~dataOut_B[8:15];
     2'b01: wordMuxB[8:15] = ~dataOut_B[40:47];   
     2'b10: wordMuxB[8:15] = ~dataOut_B[72:79];   
     2'b11: wordMuxB[8:15] = ~dataOut_B[104:111];   
      default: wordMuxB[8:15] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelBByte2'
always @(dataOut_B or CAR_buf3)
    begin                                           
    case(CAR_buf3[28:29])                       
     2'b00: wordMuxB[16:23] = ~dataOut_B[16:23];
     2'b01: wordMuxB[16:23] = ~dataOut_B[48:55];   
     2'b10: wordMuxB[16:23] = ~dataOut_B[80:87];   
     2'b11: wordMuxB[16:23] = ~dataOut_B[112:119];   
      default: wordMuxB[16:23] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelBByte3'
always @(dataOut_B or CAR_buf3)
    begin                                           
    case(CAR_buf3[28:29])                       
     2'b00: wordMuxB[24:31] = ~dataOut_B[24:31];
     2'b01: wordMuxB[24:31] = ~dataOut_B[56:63];   
     2'b10: wordMuxB[24:31] = ~dataOut_B[88:95];   
     2'b11: wordMuxB[24:31] = ~dataOut_B[120:127];   
      default: wordMuxB[24:31] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelAByte3'
always @(dataOut_A or CAR_buf3)
    begin                                           
    case(CAR_buf3[28:29])                       
     2'b00: wordMuxA[24:31] = ~dataOut_A[24:31];
     2'b01: wordMuxA[24:31] = ~dataOut_A[56:63];   
     2'b10: wordMuxA[24:31] = ~dataOut_A[88:95];   
     2'b11: wordMuxA[24:31] = ~dataOut_A[120:127];   
      default: wordMuxA[24:31] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelAByte2'
always @(dataOut_A or CAR_buf3)
    begin                                           
    case(CAR_buf3[28:29])                       
     2'b00: wordMuxA[16:23] = ~dataOut_A[16:23];
     2'b01: wordMuxA[16:23] = ~dataOut_A[48:55];   
     2'b10: wordMuxA[16:23] = ~dataOut_A[80:87];   
     2'b11: wordMuxA[16:23] = ~dataOut_A[112:119];   
      default: wordMuxA[16:23] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelAByte1'
always @(dataOut_A or CAR_buf2)
    begin                                           
    case(CAR_buf2[28:29])                       
     2'b00: wordMuxA[8:15] = ~dataOut_A[8:15];
     2'b01: wordMuxA[8:15] = ~dataOut_A[40:47];   
     2'b10: wordMuxA[8:15] = ~dataOut_A[72:79];   
     2'b11: wordMuxA[8:15] = ~dataOut_A[104:111];   
      default: wordMuxA[8:15] = 8'bx;   
    endcase                                    
   end

// Removed the module 'dp_muxDCU_wordSelAByte0'
always @(dataOut_A or CAR_buf2)
    begin                                           
    case(CAR_buf2[28:29])                       
     2'b00: wordMuxA[0:7] = ~dataOut_A[0:7];
     2'b01: wordMuxA[0:7] = ~dataOut_A[32:39];   
     2'b10: wordMuxA[0:7] = ~dataOut_A[64:71];   
     2'b11: wordMuxA[0:7] = ~dataOut_A[96:103];   
      default: wordMuxA[0:7] = 8'bx;   
    endcase                                    
   end

   // Replacing instantiation: PDP_MUX4D dp_muxDCU_parityWordSelA
   reg [0:3] dp_muxDCU_parityWordSelA_muxOut;
   wire [0:3] dp_muxDCU_parityWordSelA_D0,dp_muxDCU_parityWordSelA_D1; 
   wire [0:3] dp_muxDCU_parityWordSelA_D2; 
   wire [0:3] dp_muxDCU_parityWordSelA_D3; 
   wire [0:1] dp_muxDCU_parityWordSelA_SD; 
   assign p_ramBypassA[0:3] = dp_muxDCU_parityWordSelA_muxOut;	    
   assign dp_muxDCU_parityWordSelA_SD = CAR_buf2[28:29];         
   assign dp_muxDCU_parityWordSelA_D0 = {p_dataOutA[0],p_dataOutA[1],p_dataOutA[2],p_dataOutA[3]};         
   assign dp_muxDCU_parityWordSelA_D1 = {p_dataOutA[4],p_dataOutA[5],p_dataOutA[6],p_dataOutA[7]};         
   assign dp_muxDCU_parityWordSelA_D2 = {p_dataOutA[8],p_dataOutA[9],p_dataOutA[10],p_dataOutA[11]};         
   assign dp_muxDCU_parityWordSelA_D3 = {p_dataOutA[12],p_dataOutA[13],p_dataOutA[14],p_dataOutA[15]};         
                                               
   always @(dp_muxDCU_parityWordSelA_SD or dp_muxDCU_parityWordSelA_D0 or dp_muxDCU_parityWordSelA_D1 or dp_muxDCU_parityWordSelA_D2 or dp_muxDCU_parityWordSelA_D3) 
    begin 					    
    case(dp_muxDCU_parityWordSelA_SD)    		    	
     2'b00: dp_muxDCU_parityWordSelA_muxOut = dp_muxDCU_parityWordSelA_D0;    
     2'b01: dp_muxDCU_parityWordSelA_muxOut = dp_muxDCU_parityWordSelA_D1;    
     2'b10: dp_muxDCU_parityWordSelA_muxOut = dp_muxDCU_parityWordSelA_D2;    
     2'b11: dp_muxDCU_parityWordSelA_muxOut = dp_muxDCU_parityWordSelA_D3;    
      default: dp_muxDCU_parityWordSelA_muxOut = 4'bx;   
    endcase                                    
   end                                         


   // Replacing instantiation: PDP_MUX4D dp_muxDCU_parityWordSelB
   reg [0:3] dp_muxDCU_parityWordSelB_muxOut;
   wire [0:3] dp_muxDCU_parityWordSelB_D0,dp_muxDCU_parityWordSelB_D1; 
   wire [0:3] dp_muxDCU_parityWordSelB_D2; 
   wire [0:3] dp_muxDCU_parityWordSelB_D3; 
   wire [0:1] dp_muxDCU_parityWordSelB_SD; 
   assign p_ramBypassB[0:3] = dp_muxDCU_parityWordSelB_muxOut;	    
   assign dp_muxDCU_parityWordSelB_SD = CAR_buf3[28:29];         
   assign dp_muxDCU_parityWordSelB_D0 = {p_dataOutB[0],p_dataOutB[1],p_dataOutB[2],p_dataOutB[3]};         
   assign dp_muxDCU_parityWordSelB_D1 = {p_dataOutB[4],p_dataOutB[5],p_dataOutB[6],p_dataOutB[7]};         
   assign dp_muxDCU_parityWordSelB_D2 = {p_dataOutB[8],p_dataOutB[9],p_dataOutB[10],p_dataOutB[11]};         
   assign dp_muxDCU_parityWordSelB_D3 = {p_dataOutB[12],p_dataOutB[13],p_dataOutB[14],p_dataOutB[15]};         
                                               
   always @(dp_muxDCU_parityWordSelB_SD or dp_muxDCU_parityWordSelB_D0 or dp_muxDCU_parityWordSelB_D1 or dp_muxDCU_parityWordSelB_D2 or dp_muxDCU_parityWordSelB_D3) 
    begin 					    
    case(dp_muxDCU_parityWordSelB_SD)    		    	
     2'b00: dp_muxDCU_parityWordSelB_muxOut = dp_muxDCU_parityWordSelB_D0;    
     2'b01: dp_muxDCU_parityWordSelB_muxOut = dp_muxDCU_parityWordSelB_D1;    
     2'b10: dp_muxDCU_parityWordSelB_muxOut = dp_muxDCU_parityWordSelB_D2;    
     2'b11: dp_muxDCU_parityWordSelB_muxOut = dp_muxDCU_parityWordSelB_D3;    
      default: dp_muxDCU_parityWordSelB_muxOut = 4'bx;   
    endcase                                    
   end                                         


endmodule
