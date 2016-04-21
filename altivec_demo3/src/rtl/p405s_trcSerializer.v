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

module p405s_trcSerializer( serDataOut, trcFifoDataOut, trcSerStateL2,
     trcTimeStampOut );



output [0:2]  serDataOut;


input [0:29] trcFifoDataOut;
input [0:8]  trcTimeStampOut;
input [0:3]  trcSerStateL2;

// Buses in the design

reg [0:2] serDataOut_i;

reg  [0:2]  serMux1b;

reg  [0:2]  serMux1a;

reg  [0:2]  serMux0a;

wire  [0:2]  trcFifoDataOut_Neg;

assign serDataOut = serDataOut_i;

//Removed the module dp_logTRC_invFifoData02
assign trcFifoDataOut_Neg = ~trcFifoDataOut[0:2];

//Removed the module dp_muxTRC_serMux2 
always @(trcSerStateL2 or trcFifoDataOut_Neg or serMux0a or serMux1a or serMux1b) 
  begin: dp_muxTRC_serMux2_PROC				    
    case(trcSerStateL2[0:1])    		    	  
      2'b00: serDataOut_i = ~trcFifoDataOut_Neg;   
      2'b01: serDataOut_i = ~serMux0a;   
      2'b10: serDataOut_i = ~serMux1a;   
      2'b11: serDataOut_i = ~serMux1b;   
      default: serDataOut_i = 3'bx;   
    endcase                                    
  end // dp_muxTRC_serMux2_PROC                                        

//Removed the module dp_muxTRC_serMux1b 
always @(trcSerStateL2 or trcFifoDataOut or trcTimeStampOut) 
  begin: dp_muxTRC_serMux1b_PROC				    
    case(trcSerStateL2[2:3])    		    	  
      2'b00: serMux1b = ~trcFifoDataOut[27:29];   
      2'b01: serMux1b = ~trcTimeStampOut[0:2];   
      2'b10: serMux1b = ~trcTimeStampOut[3:5];   
      2'b11: serMux1b = ~trcTimeStampOut[6:8];   
      default: serMux1b = 3'bx;   
    endcase                                    
  end // dp_muxTRC_serMux1b_PROC                                        

//Removed the module dp_muxTRC_serMux1a 
always @(trcSerStateL2 or trcFifoDataOut) 
  begin: dp_muxTRC_serMux1a_PROC				    
    case(trcSerStateL2[2:3])    		    	  
      2'b00: serMux1a = ~trcFifoDataOut[15:17];   
      2'b01: serMux1a = ~trcFifoDataOut[18:20];   
      2'b10: serMux1a = ~trcFifoDataOut[21:23];   
      2'b11: serMux1a = ~trcFifoDataOut[24:26];   
      default: serMux1a = 3'bx;   
    endcase                                    
  end // dp_muxTRC_serMux1a_PROC                                        

//Removed the module dp_muxTRC_serMux0a 
always @(trcSerStateL2 or trcFifoDataOut) 
  begin: dp_muxTRC_serMux0a_PROC				    
    case(trcSerStateL2[2:3])    		    	  
      2'b00: serMux0a = ~trcFifoDataOut[3:5];   
      2'b01: serMux0a = ~trcFifoDataOut[6:8];   
      2'b10: serMux0a = ~trcFifoDataOut[9:11];   
      2'b11: serMux0a = ~trcFifoDataOut[12:14];   
      default: serMux0a = 3'bx;   
    endcase                                    
  end // dp_muxTRC_serMux0a_PROC                                        

endmodule
