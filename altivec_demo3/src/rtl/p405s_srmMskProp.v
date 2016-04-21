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
module p405s_srmMskProp (notMask, mskBegin, mskEndHi, mskEndLo, propLookAhd);
    output [0:31] notMask;
    input [0:31] mskBegin;
    input [0:14] mskEndHi;
    input [16:30] mskEndLo;
    input [0:1] propLookAhd;

wire [0:14] loPropagate, hiPropagate;
wire [0:31] notMask, notMask_i;
assign notMask = notMask_i;

assign notMask_i[0:15] = ~(({propLookAhd[0],hiPropagate[0:14]}) | mskBegin[0:15]);
assign hiPropagate[0:14] = ~(mskEndHi[0:14] | notMask_i[0:14]);

assign notMask_i[16:31] = ~(({propLookAhd[1],loPropagate[0:14]}) | mskBegin[16:31]);
assign loPropagate[0:14] = ~(mskEndLo[16:30] | notMask_i[16:30]);
endmodule
