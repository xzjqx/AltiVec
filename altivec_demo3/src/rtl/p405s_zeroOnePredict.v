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
module p405s_zeroOnePredict (N_OP, N_ZP, OPLo16, ZPLo16, aIn, bIn, cIn);
    output N_OP;
    output N_ZP;
    output OPLo16;
    output ZPLo16;
    input [0:31] aIn;
    input [0:31] bIn;
    input cIn;

wire [0:31] aEqb, aNEqb, zp, op;
wire [1:31] aOrb, aAndb;

assign aEqb[0:31] = aIn[0:31] ~^ bIn[0:31];
assign aOrb[1:31] = aIn[1:31] | bIn[1:31];
assign zp[0:30] = (aEqb[0:30] ^ aOrb[1:31]);
assign zp[31] = cIn ? ~aEqb[31] : aEqb[31];
assign ZPLo16 = &zp[16:31];
assign N_ZP = ~(&zp[0:31]);

assign aNEqb [0:31] = aIn[0:31] ^ bIn[0:31];
assign aAndb[1:31] = aIn[1:31] & bIn[1:31];
assign op[0:30] =  (aNEqb[0:30] ^ aAndb[1:31]);
assign op[31] =  cIn ? ~aNEqb[31] : aNEqb[31];
assign OPLo16 = &op[16:31];
assign N_OP = ~(&op[0:31]);

endmodule
