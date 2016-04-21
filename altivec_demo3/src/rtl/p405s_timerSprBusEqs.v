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

module timerSprBusEqs (
                       timStatCntrlSel, 
		       timerSprBusSel, 
		       TIM_watchDogIntrp,
		       TIM_pitIntrp, 
		       TIM_fitIntrp, 
		       timerStatusOutL2, 
		       timerControlL2, 
		       tbhDcd,
		       timerRstStatDcd, 
		       pitDcd, 
		       tcrDcd
		       );
		
output timStatCntrlSel;
output [0:1] timerSprBusSel;
output TIM_watchDogIntrp;
output TIM_pitIntrp;
output TIM_fitIntrp;

input [0:5] timerStatusOutL2;
input [0:9] timerControlL2;
input tbhDcd;
input timerRstStatDcd;
input pitDcd;
input tcrDcd;
    
assign TIM_watchDogIntrp = timerStatusOutL2[1] & timerControlL2[4];

assign TIM_pitIntrp = timerStatusOutL2[4] & timerControlL2[5];

assign TIM_fitIntrp = timerStatusOutL2[5] & timerControlL2[8];

assign timStatCntrlSel = tcrDcd;

assign timerSprBusSel[0] = timerRstStatDcd | tcrDcd | pitDcd;

assign timerSprBusSel[1] = timerRstStatDcd | tcrDcd | tbhDcd;

endmodule
