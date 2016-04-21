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
module p405s_zeroOneDetect (aBytes01Eq0, bBytes23Eq0, bBytes01Eq0, bBytes01Eq1,
           aBytes01Eq1, bBus, aBus, bIn, aIn, CO16, ZPHi16, OPHi16);
    output aBytes01Eq0;
    output bBytes23Eq0;
    output bBytes01Eq0;
    output bBytes01Eq1;
    output aBytes01Eq1;
    output OPHi16;
    output ZPHi16;
    input [0:31] bBus;
    input [0:15] aBus;
    input [0:15] aIn;
    input [0:15] bIn;
    input CO16;

wire [0:15] aEqb, aNEqb, zp, op;
wire [1:15] aAndb, aOrb;

assign aBytes01Eq0 = ~|aBus[0:15];
assign aBytes01Eq1 =  &aBus[0:15];

assign bBytes01Eq0 = ~|bBus[0:15];
assign bBytes23Eq0 = ~|bBus[16:31];
assign bBytes01Eq1 =  &bBus[0:15];


assign aEqb[0:15] = aIn[0:15] ~^ bIn[0:15];
assign aOrb[1:15] = aIn[1:15] | bIn[1:15];
assign zp[0:15] = (aEqb ^ {aOrb[1:15], CO16});
assign ZPHi16 = &zp[0:15];

assign aNEqb[0:15] = aIn[0:15] ^ bIn[0:15];
assign aAndb[1:15] = aIn[1:15] & bIn[1:15];
assign op[0:15] = (aNEqb ^ {aAndb[1:15], CO16});
assign OPHi16 = &op[0:15];


endmodule
