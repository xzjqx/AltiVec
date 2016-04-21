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

module p405s_dcdInstPla ( priOp_0, priOp_1, priOp_2, priOp_3, priOp_4, priOp_5,
    secOp_21, secOp_22, secOp_23, secOp_24, secOp_25, secOp_26, secOp_27,
    secOp_28, secOp_29, secOp_30, Rc, plaExe2Op, plaCrBfEn, plaMtspr, plaMfspr,
    plaB, plaBc, plaCrAnd, plaCrOr, plaCrXor, plaCrNegBB, plaCrNegBT, plaMcrf,
    plaMcrxr, plaMtcrf, plaStwcx, plaTlbsx, plaRfi, plaRfci, plaSc, plaIsync
     );

input  priOp_0, priOp_1, priOp_2, priOp_3, priOp_4, priOp_5, secOp_21,
    secOp_22, secOp_23, secOp_24, secOp_25, secOp_26, secOp_27, secOp_28,
    secOp_29, secOp_30, Rc;

output plaExe2Op, plaCrBfEn, plaMtspr, plaMfspr, plaB, plaBc, plaCrAnd,
    plaCrOr, plaCrXor, plaCrNegBB, plaCrNegBT, plaMcrf, plaMcrxr, plaMtcrf,
    plaStwcx, plaTlbsx, plaRfi, plaRfci, plaSc, plaIsync;

    assign plaExe2Op = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_25 & ~secOp_26 &
        secOp_27 & ~secOp_28 & secOp_29 & secOp_30) | (~priOp_0 & priOp_1 &
        priOp_2 & priOp_3 & priOp_4 & priOp_5 & ~secOp_22 & secOp_23 &
        secOp_24 & secOp_25 & ~secOp_26 & secOp_27 & ~secOp_28 & secOp_29 &
        secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 & priOp_3 & ~priOp_4 & ~
        priOp_5 & ~secOp_21 & secOp_23 & ~secOp_24 & ~secOp_26 & secOp_27 & ~
        secOp_29 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 & priOp_3 & ~
        priOp_4 & ~priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_24 & ~secOp_26 &
        secOp_27 & ~secOp_29 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 &
        priOp_3 & ~priOp_4 & ~priOp_5 & secOp_23 & secOp_25 & ~secOp_26 &
        secOp_27 & secOp_28 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 &
        priOp_3 & ~priOp_4 & ~priOp_5 & secOp_23 & ~secOp_26 & secOp_27 &
        secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 &
        priOp_3 & ~priOp_4 & ~priOp_5 & ~secOp_22 & secOp_25 & ~secOp_26 &
        secOp_27 & secOp_28 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 &
        priOp_3 & ~priOp_4 & ~priOp_5 & ~secOp_22 & ~secOp_26 & secOp_27 &
        secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0 & ~priOp_1 & ~priOp_2 &
        priOp_3 & priOp_4 & priOp_5));
    assign plaCrBfEn = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 & ~secOp_26 &
        ~secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0 & priOp_1
         & priOp_2 & priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~secOp_22 & ~
        secOp_23 & ~secOp_24 & ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29
         & ~secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 &
        ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 &
        secOp_23 & secOp_24 & ~secOp_25 & ~secOp_26 & ~secOp_27 & ~secOp_28 &
        ~secOp_29 & secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 &
        priOp_4 & priOp_5 & ~secOp_21 & secOp_22 & ~secOp_24 & secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~
        secOp_22 & secOp_23 & secOp_24 & ~secOp_26 & ~secOp_27 & ~secOp_28 & ~
        secOp_29 & secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 &
        priOp_4 & priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~
        secOp_23 & ~secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 & ~secOp_28 &
        ~secOp_29 & secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 &
        priOp_4 & priOp_5 & ~secOp_21 & secOp_22 & ~secOp_23 & ~secOp_24 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & ~priOp_1 & priOp_2 & ~priOp_3 & priOp_4));
    assign plaMtspr = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & secOp_22 & secOp_23 & secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & secOp_30));
    assign plaMfspr = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & secOp_30) | (~priOp_0 &
        priOp_1 & priOp_2 & priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & secOp_22
         & ~secOp_23 & secOp_24 & ~secOp_25 & secOp_26 & ~secOp_27 & ~secOp_28
         & secOp_29 & secOp_30));
    assign plaB = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & ~
        priOp_5));
    assign plaBc = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 & secOp_26 & ~
        secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30) | (~priOp_0 & priOp_1 &
        ~priOp_2 & ~priOp_3 & ~priOp_4 & ~priOp_5));
    assign plaCrAnd = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~
        secOp_22 & secOp_23 & secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 & ~
        secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~
        priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~
        secOp_24 & ~secOp_25 & ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29
         & secOp_30));
    assign plaCrOr = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & secOp_22 & secOp_23 & secOp_24 & ~secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~
        secOp_22 & ~secOp_23 & ~secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 &
        ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0 & priOp_1 & ~priOp_2 & ~
        priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & secOp_22 & secOp_23 & ~
        secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 &
        secOp_30));
    assign plaCrXor = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & secOp_24 & ~secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 &
        secOp_22 & ~secOp_23 & ~secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 &
        ~secOp_28 & ~secOp_29 & secOp_30));
    assign plaCrNegBB = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4
         & priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~secOp_24 & ~secOp_25
         & ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~
        priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~
        secOp_21 & secOp_22 & secOp_23 & ~secOp_24 & secOp_25 & ~secOp_26 & ~
        secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30));
    assign plaCrNegBT = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4
         & priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & secOp_24 & secOp_25 &
        ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & secOp_30) | (~priOp_0
         & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 & priOp_5 & ~secOp_21 & ~
        secOp_23 & ~secOp_24 & secOp_25 & ~secOp_26 & ~secOp_27 & ~secOp_28 &
        ~secOp_29 & secOp_30));
    assign plaMcrf = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 &
        ~secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30));
    assign plaMcrxr = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & ~secOp_25 & ~
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30));
    assign plaMtcrf = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & ~secOp_29 & ~secOp_30));
    assign plaStwcx = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & secOp_28 & secOp_29 & ~secOp_30 & Rc));
    assign plaTlbsx = ((~priOp_0 & priOp_1 & priOp_2 & priOp_3 & priOp_4 &
        priOp_5 & secOp_21 & secOp_22 & secOp_23 & ~secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & ~secOp_30));
    assign plaRfi = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & ~secOp_30));
    assign plaRfci = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & ~secOp_23 & ~secOp_24 & secOp_25 &
        secOp_26 & ~secOp_27 & ~secOp_28 & secOp_29 & secOp_30));
    assign plaSc = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & ~priOp_4 &
        priOp_5 & secOp_30));
    assign plaIsync = ((~priOp_0 & priOp_1 & ~priOp_2 & ~priOp_3 & priOp_4 &
        priOp_5 & ~secOp_21 & ~secOp_22 & secOp_23 & ~secOp_24 & ~secOp_25 &
        secOp_26 & ~secOp_27 & secOp_28 & secOp_29 & ~secOp_30));
endmodule

