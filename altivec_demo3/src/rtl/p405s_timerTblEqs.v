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
module timerTblEqs (
                    cOut, 
		    sprDataSel, 
		    tbl8E1, 
		    tbl8E2, 
		    tbl24E1, 
		    tbl24E2,
                    timerTic, 
		    freezeTimersNEG, 
		    tblL2, 
		    oscTimerDlyL2, 
		    DBG_freezeTimers, 
                    JTG_freezeTimers, 
		    PCL_mtSPR, 
		    PCL_sprHold, 
		    tblDcd
		    );

    
output cOut;
output sprDataSel;
output tbl8E1;
output tbl8E2;
output tbl24E1;
output tbl24E2;
output timerTic;
output freezeTimersNEG;

input [0:31] tblL2;
input oscTimerDlyL2;
input DBG_freezeTimers;
input JTG_freezeTimers;
input PCL_mtSPR;
input PCL_sprHold;
input tblDcd;
    
wire cOut8;
 
    
assign timerTic = oscTimerDlyL2;
assign freezeTimersNEG = ~(DBG_freezeTimers | JTG_freezeTimers);

assign cOut8 = (&tblL2[24:31]) & timerTic;
assign cOut = (&tblL2[0:23]) & cOut8;

assign sprDataSel = PCL_mtSPR & tblDcd & ~PCL_sprHold;

assign tbl8E1 = timerTic | PCL_mtSPR;
assign tbl8E2 = (PCL_mtSPR & tblDcd & ~PCL_sprHold) | 
                (timerTic & freezeTimersNEG);

assign tbl24E1 = cOut8 | PCL_mtSPR;
assign tbl24E2 = (PCL_mtSPR & tblDcd & ~PCL_sprHold) | 
                 (cOut8 & freezeTimersNEG);

endmodule
