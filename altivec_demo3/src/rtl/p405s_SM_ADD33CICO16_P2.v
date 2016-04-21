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
// Verilog HDL for "PEPS_CMOS6SF_MAC", "SM_ADD33CICO16_P2" "_behavioral"

module p405s_SM_ADD33CICO16_P2( CO, CO16, CO30, SUM32_B, SUM32_C, SUM31_B, SUM31_C, SUM15_B, SUM16_B, SUM, CI, A, B);
    output CO;
    output [32:0] SUM;
    output SUM31_B,SUM31_C,SUM32_B,SUM32_C,SUM16_B,SUM15_B;
    output CO16;
    output CO30;
    input [32:0] A;
    input [32:0] B;
    input CI;

    wire [15:0] temp1;
    wire [30:0] temp3;
    wire CO_i, CO;
    wire [32:0] SUM, SUM_i;
    wire CO30, CO30_i;

    assign CO   = CO_i;
    assign SUM  = SUM_i;
    assign CO30 = CO30_i;

    assign {CO_i,SUM_i[31:0]} = A[31:0] + B[31:0] + CI;
    assign SUM_i[32] = A[32] + B[32] + CO_i;
    assign SUM32_B = A[32] + B[32] + CO_i;
    assign SUM32_C = A[32] + B[32] + CO_i;

    assign {CO30_i,temp3[30:0]} = A[30:0] + B[30:0] + CI;
    assign SUM31_B = A[31] + B[31] + CO30_i;
    assign SUM31_C = A[31] + B[31] + CO30_i;

    assign SUM16_B = SUM_i[16];

    assign {CO16,temp1[15:0]} = A[15:0] + B[15:0] + CI;

    assign SUM15_B = SUM_i[15];

endmodule
