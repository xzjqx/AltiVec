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
// Verilog HDL for "PR_icu", "dp_regICU_va4" "_functional"
module p405s_icu_dp_regICU_va4(
                     CB,
                     D,
                     E1,
                     L2
                    );

    input CB; 
    input [0:31] D; 
    input  E1; 
    output [0:31] L2; 

p405s_PDP_P1EUL2
 #(32, 1, 1, 1, 2, 0 ) dp_Reg (
                                         .CB  (CB),
                                         .D   (D),
                                         .E1  (E1),
                                         .L2  (L2)
                                         );

endmodule
