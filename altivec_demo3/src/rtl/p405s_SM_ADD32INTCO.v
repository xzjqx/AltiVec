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
// Verilog HDL for "PEPS_CMOS6SF_MAC", "SM_ADD32INTCO" "_behavioral"

module p405s_SM_ADD32INTCO (CP, SUM, A, B );
    output [31:0] SUM;
    output [7:0] CP;
    input [31:0] A;
    input [31:0] B;

wire [7:0] CP, CP_i;    
assign CP = CP_i;
assign SUM[31:24] = A[31:24] + B[31:24] + CP_i[7];
assign {CP_i[7],SUM[23:22]} = A[23:22] + B[23:22] + CP_i[6];
assign {CP_i[6],SUM[21:20]} = A[21:20] + B[21:20] + CP_i[5];
assign {CP_i[5],SUM[19:18]} = A[19:18] + B[19:18] + CP_i[4];
assign {CP_i[4],SUM[17:16]} = A[17:16] + B[17:16] + CP_i[3];
assign {CP_i[3],SUM[15:14]} = A[15:14] + B[15:14] + CP_i[2];
assign {CP_i[2],SUM[13:12]} = A[13:12] + B[13:12] + CP_i[1];
assign {CP_i[1],SUM[11:10]} = A[11:10] + B[11:10] + CP_i[0];
assign {CP_i[0],SUM[9:0]} = A[9:0] + B[9:0];

endmodule
