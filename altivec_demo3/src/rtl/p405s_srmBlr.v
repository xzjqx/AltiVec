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
module p405s_srmBlr (blrOut, aBus_NEG, rotateAmt);
    output [0:31] blrOut;
    input [0:31] aBus_NEG;
    input [0:4] rotateAmt;


//wire [0:31] blrLvl1_NEG;
//dp_muxEXE_srmBlrLvl1       muxEXE_srmBlrLvl1(.Z(blrLvl1_NEG[0:31]),
//                                             .D0(aBus_NEG[0:31]),
//                                             .D1({aBus_NEG[1:31],aBus_NEG[0]}),
//                                             .D2({aBus_NEG[2:31],aBus_NEG[0:1]}),
//                                             .D3({aBus_NEG[3:31],aBus_NEG[0:2]}),
//                                             .SD0(rotateAmt[3]),
//                                             .SD2(rotateAmt[4]));
// Removed the module 'dp_muxEXE_srmBlrLvl1'
reg [0:31] blrLvl1_NEG;
always @(rotateAmt or aBus_NEG )
    begin                                           
    case({rotateAmt[3],rotateAmt[4]})       
     2'b00: blrLvl1_NEG[0:31] = aBus_NEG[0:31];    
     2'b01: blrLvl1_NEG[0:31] = {aBus_NEG[1:31],aBus_NEG[0]};    
     2'b10: blrLvl1_NEG[0:31] = {aBus_NEG[2:31],aBus_NEG[0:1]};    
     2'b11: blrLvl1_NEG[0:31] = {aBus_NEG[3:31],aBus_NEG[0:2]};    
      default: blrLvl1_NEG[0:31] = 32'bx;        
    endcase                                    
   end  

//wire [0:31] blrLvl2_NEG;
//dp_muxEXE_srmBlrLvl2       muxEXE_srmBlrLvl2(.Z(blrLvl2_NEG[0:31]),
//                                             .D0(blrLvl1_NEG[0:31]),
//                                             .D1({blrLvl1_NEG[4:31],blrLvl1_NEG[0:3]}),
//                                             .D2({blrLvl1_NEG[8:31],blrLvl1_NEG[0:7]}),
//                                             .D3({blrLvl1_NEG[12:31],blrLvl1_NEG[0:11]}),
//                                             .SD(rotateAmt[1:2]));
// Removed the module 'dp_muxEXE_srmBlrLvl2'
reg [0:31] blrLvl2_NEG;
always @(blrLvl1_NEG or rotateAmt)
    begin                                           
    case(rotateAmt[1:2])                     
     2'b00: blrLvl2_NEG[0:31] = blrLvl1_NEG[0:31];
     2'b01: blrLvl2_NEG[0:31] = {blrLvl1_NEG[4:31],blrLvl1_NEG[0:3]};    
     2'b10: blrLvl2_NEG[0:31] = {blrLvl1_NEG[8:31],blrLvl1_NEG[0:7]};    
     2'b11: blrLvl2_NEG[0:31] = {blrLvl1_NEG[12:31],blrLvl1_NEG[0:11]};    
      default: blrLvl2_NEG[0:31] = 32'bx;   
    endcase                                    
   end  
//
//dp_muxEXE_srmBlrLvl3       muxEXE_srmBlrLvl3(.Z(blrOut[0:31]),
//                                             .D0(blrLvl2_NEG[0:31]),
//                                             .D1({blrLvl2_NEG[16:31],blrLvl2_NEG[0:15]}),
//                                             .SD(rotateAmt[0]));
// Removed the module 'dp_muxEXE_srmBlrLvl3'
assign blrOut[0:31] = ~( (blrLvl2_NEG[0:31] & {(32){~(rotateAmt[0])}} ) | ({blrLvl2_NEG[16:31],blrLvl2_NEG[0:15]} & {(32){rotateAmt[0]}} ) );

endmodule
