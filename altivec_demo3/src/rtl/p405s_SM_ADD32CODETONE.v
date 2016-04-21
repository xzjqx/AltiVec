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
// Verilog HDL for "PEPS_CMOS6SF_MAC", "SM_ADD32CODETONE" "_behavioral"

module p405s_SM_ADD32CODETONE (CO, SUMEQ0, SUMEQ1, SUMEQ4TO2, SUMEQ31TO5, A, B);
    output CO;
    output SUMEQ0;
    output SUMEQ1;
    output SUMEQ4TO2;
    output SUMEQ31TO5;
    input [31:0] A;
    input [31:0] B;

    wire [31:0] SUM;

    assign {CO,SUM} = A + B + 1'b0;
    assign SUMEQ31TO5 = &(A[31:5] ^ B[31:5]);
    assign SUMEQ4TO2 = &(A[4:2] ^ B[4:2]);
    assign SUMEQ1 = A[1] ^ B[1];
    assign SUMEQ0 = A[0] ^ B[0];

endmodule
