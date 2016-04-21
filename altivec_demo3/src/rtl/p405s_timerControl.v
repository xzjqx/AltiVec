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

module p405s_timerControl(  
                     timerControlL2, 
	            	     CB, 
		                 EXE_sprDataBus, 
		                 PCL_mtSPR,
                     PCL_sprHold, 
		                 resetCore,
                     tcrDcd 
		                 );


output [0:9]  timerControlL2;
input  PCL_mtSPR; 
input  PCL_sprHold; 
input  resetCore; 
input  tcrDcd;
input CB;
input [0:9]  EXE_sprDataBus;

// Buses in the design

wire  [0:9]  timerControlIn;
wire timerControlE1;
wire timerControlE2;
reg [0:9] timerControlL2_i;
wire [0:9] timerControlL2;

assign timerControlL2 = timerControlL2_i;

// Removed the module timerControlEqs 
assign timerControlIn[0:1] = EXE_sprDataBus[0:1];
assign timerControlIn[2:3] = (EXE_sprDataBus[2:3] | timerControlL2_i[2:3]) &
			                        {2{~resetCore}};
assign timerControlIn[4:9] = EXE_sprDataBus[4:9];

assign timerControlE1 = resetCore | PCL_mtSPR;

assign timerControlE2 = (~PCL_sprHold & tcrDcd) | resetCore;
// Removed the module dp_regTIM_timerControl 
   always @(posedge CB)  	
    begin				  	
    if (timerControlE1 && timerControlE2)		
      timerControlL2_i[0:9] <= timerControlIn[0:9];		
   end			 		

endmodule
