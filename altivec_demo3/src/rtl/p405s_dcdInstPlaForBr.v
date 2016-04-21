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

module p405s_dcdInstPlaForBr ( priOp_0, priOp_1, priOp_2, priOp_3, priOp_4, priOp_5,
    secOp_21, secOp_22, secOp_23, secOp_24, secOp_25, secOp_26, secOp_27,
    secOp_28, secOp_29, secOp_30, Rc, plaCr0En, plaB, plaBc, plaMtspr );

input  priOp_0, priOp_1, priOp_2, priOp_3, priOp_4, priOp_5, secOp_21,
    secOp_22, secOp_23, secOp_24, secOp_25, secOp_26, secOp_27, secOp_28,
    secOp_29, secOp_30, Rc;

output plaCr0En, plaB, plaBc, plaMtspr;

    assign plaCr0En = ((~priOp_0 & ~priOp_2 & priOp_3 & ~priOp_4 & ~priOp_5 &
        Rc) | (~priOp_0 & priOp_1 & priOp_3 & priOp_5 & Rc) | (~priOp_0 &
        priOp_2 & priOp_3 & ~priOp_4 & priOp_5) | (~priOp_0 & priOp_1 &
        priOp_2 & priOp_3 & ~priOp_4));
    assign plaB = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & ~
        priOp_5));
    assign plaBc = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 & secOp_26 & ~
        secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0 & priOp_1 &
        ~priOp_2 & ~priOp_3 & ~priOp_4 & ~priOp_5));
    assign plaMtspr = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & secOp_22 & secOp_23 & secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & secOp_30));

endmodule

