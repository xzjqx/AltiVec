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
module p405s_timerPitEqs (
                    pit8E1, 
                    pit8E2, 
                    pit24E1, 
                    pit24E2, 
                    pitReloadE1,
                    pitReloadE2, 
                    pitMuxSel, 
                    hwSetPitStatus,
                    PCL_mtSPR, 
                    PCL_sprHold, 
                    tcrARenable, 
                    pitDcd, 
                    timerTic, 
                    pitL2,
                    freezeTimersNEG, 
                    LSSD_coreTestEn
                    );
        
    output pit8E1;
    output pit8E2;
    output pit24E1;
    output pit24E2;
    output pitReloadE1;
    output pitReloadE2;
    output [0:1] pitMuxSel;
    output hwSetPitStatus;
    input [0:31] pitL2;
    input PCL_mtSPR;
    input PCL_sprHold;
    input pitDcd;
    input timerTic;
    input tcrARenable;
    input freezeTimersNEG;
    input LSSD_coreTestEn;

    wire pitTic;
    wire pitEqZero;
    wire reload;
    wire sprDataSel;
    wire borrow;
    wire hwSetPitStatus_i;

assign hwSetPitStatus = hwSetPitStatus_i;

assign pitTic = timerTic & ~pitEqZero;

assign pitEqZero = ~|pitL2;

// When pit[24:31] has a value of zero and pitTic comes along
// there will be a borrow from pit[0:23] and therefore pit[0:23]
// must be updated.

assign borrow = ~|pitL2[24:31] & pitTic;

// When pit has value of 1 and a pit tic comes along, set intrpt.
// Make this equation based off of the output of the latch
// rather than the input to the latch for better timing.

assign hwSetPitStatus_i = pitTic & (~|pitL2[0:30]) & pitL2[31];

assign sprDataSel = PCL_mtSPR & pitDcd & ~PCL_sprHold;

assign reload = tcrARenable & hwSetPitStatus_i;

assign pitMuxSel = {(reload | sprDataSel),(sprDataSel | LSSD_coreTestEn)};

assign pit8E1 = timerTic | PCL_mtSPR;

assign pit8E2 = (PCL_mtSPR & pitDcd & ~PCL_sprHold) | (pitTic & freezeTimersNEG);

assign pit24E1 = timerTic | PCL_mtSPR;

assign pit24E2 = (PCL_mtSPR & pitDcd & ~PCL_sprHold) | ((borrow | reload) &
      freezeTimersNEG);

assign pitReloadE1 = PCL_mtSPR;

assign pitReloadE2 = (pitDcd & ~PCL_sprHold);

endmodule
