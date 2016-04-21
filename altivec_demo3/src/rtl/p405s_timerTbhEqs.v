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
module timerTbhEqs (
                    sprDataSel, 
		    tbhE1, 
		    tbhE2, 
		    PCL_mtSPR, 
		    PCL_sprHold, 
                    cIn, 
		    tbhDcd, 
		    freezeTimersNEG
		    );
           
output sprDataSel;
output tbhE1;
output tbhE2;
input PCL_mtSPR;
input PCL_sprHold;
input cIn;
input tbhDcd;
input freezeTimersNEG;

// pick the spr side of the mux only when mtspr actually happens,
// default to the incrementer side of the mux.
assign sprDataSel = PCL_mtSPR & tbhDcd & ~PCL_sprHold;

// Enable the L1 for HW inc or mtspr.
assign tbhE1 = cIn | PCL_mtSPR;

// Block C2 if pipe hold, but allow HW inc to override.
assign tbhE2 = (PCL_mtSPR & tbhDcd & ~PCL_sprHold) | (cIn & freezeTimersNEG);

endmodule
