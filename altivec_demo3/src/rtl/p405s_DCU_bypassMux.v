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

module p405s_DCU_bypassMux( DCU_data_NEG,
                            bypassMuxOut,
                            dOutMuxSelByte0,
                            dOutMuxSelByte1,
                            dOutMuxSelByte2,
                            dOutMuxSelByte3,
                            dcReadTag,
                            wordMuxA,
                            wordMuxB
                          );

output [0:31]  DCU_data_NEG;

input [0:1]  dOutMuxSelByte2;
input [0:31]  wordMuxB;
input [0:1]  dOutMuxSelByte1;
input [0:31]  wordMuxA;
input [0:1]  dOutMuxSelByte0;
input [0:1]  dOutMuxSelByte3;
input [0:31]  bypassMuxOut;
input [0:31]  dcReadTag;

// Buses in the design

reg  [0:31]  DCU_data;

// Removed the module 'dp_logDCU_dataOutInv'
assign DCU_data_NEG[0:31] = ~(DCU_data[0:31]);

// Removed the module 'dp_muxDCU_dataOutByte0'
always @(wordMuxB or bypassMuxOut or wordMuxA or dcReadTag or dOutMuxSelByte0)
    begin                                           
    case({dOutMuxSelByte0[0],dOutMuxSelByte0[1]})       
     2'b00: DCU_data[0:7] = wordMuxB[0:7];
     2'b01: DCU_data[0:7] = bypassMuxOut[0:7];    
     2'b10: DCU_data[0:7] = wordMuxA[0:7];    
     2'b11: DCU_data[0:7] = dcReadTag[0:7];    
      default: DCU_data[0:7] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_dataOutByte1'
always @(wordMuxB or bypassMuxOut or wordMuxA or dcReadTag or dOutMuxSelByte1)
    begin                                           
    case({dOutMuxSelByte1[0], dOutMuxSelByte1[1]})
     2'b00: DCU_data[8:15] = wordMuxB[8:15];    
     2'b01: DCU_data[8:15] = bypassMuxOut[8:15];    
     2'b10: DCU_data[8:15] = wordMuxA[8:15];    
     2'b11: DCU_data[8:15] = dcReadTag[8:15];    
      default: DCU_data[8:15] = 8'bx;        
    endcase                                    
   end 

// Removed the module 'dp_muxDCU_dataOutByte2'
always @(wordMuxB or bypassMuxOut or wordMuxA or dcReadTag or dOutMuxSelByte2)
    begin                                           
    case({dOutMuxSelByte2[0], dOutMuxSelByte2[1]})
     2'b00: DCU_data[16:23] = wordMuxB[16:23];    
     2'b01: DCU_data[16:23] = bypassMuxOut[16:23];    
     2'b10: DCU_data[16:23] = wordMuxA[16:23];    
     2'b11: DCU_data[16:23] = dcReadTag[16:23];    
      default: DCU_data[16:23] = 8'bx;        
    endcase                                    
   end

// Removed the module 'dp_muxDCU_dataOutByte3'
always @(wordMuxB or bypassMuxOut or wordMuxA or dcReadTag or dOutMuxSelByte3)
    begin                                           
    case({dOutMuxSelByte3[0], dOutMuxSelByte3[1]})
     2'b00: DCU_data[24:31] = wordMuxB[24:31];
     2'b01: DCU_data[24:31] = bypassMuxOut[24:31];    
     2'b10: DCU_data[24:31] = wordMuxA[24:31];    
     2'b11: DCU_data[24:31] = dcReadTag[24:31];    
      default: DCU_data[24:31] = 8'bx;        
    endcase                                    
   end 

endmodule
