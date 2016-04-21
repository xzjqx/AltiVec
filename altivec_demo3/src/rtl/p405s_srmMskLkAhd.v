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
module p405s_srmMskLkAhd (propLookAhd, forceZeroDcd, mbField, meField);
    output [0:1] propLookAhd;
    input forceZeroDcd;
    input [0:4] mbField;
    input [0:4] meField;

    wire gen3,gen2,gen1;
    wire prop4,prop3,prop2,prop1;
    wire meLessThanMb;

// Carry Look Ahead used to determine me < mb.
// me + /mb + 1.
// Only need carry into msb.
assign gen3 = meField[3] & ~mbField[3];
assign gen2 = meField[2] & ~mbField[2];
assign gen1 = meField[1] & ~mbField[1];

assign prop4 = meField[4] | ~mbField[4];
assign prop3 = meField[3] | ~mbField[3];
assign prop2 = meField[2] | ~mbField[2];
assign prop1 = meField[1] | ~mbField[1];

assign meLessThanMb = ~(gen1 | (prop1 & gen2) | (prop1 & prop2 & gen3) |
(prop1 & prop2 & prop3 & prop4));

assign propLookAhd[0] = (((mbField[0] ~^ meField[0]) & meLessThanMb) | (mbField[0] & ~meField[0])) & ~forceZeroDcd;

assign propLookAhd[1] = (((mbField[0] ~^ meField[0]) & meLessThanMb) | (~mbField[0] & meField[0]))& ~forceZeroDcd;
endmodule
