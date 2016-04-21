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
module p405s_timerStatus( 
	                 timerStatusOutL2, 
	                 CB, 
	                 EXE_sprDataBus, 
	                 PCL_mtSPR,
                   PCL_sprHold, 
	                 hwSetFitStatus, 
	                 hwSetPitStatus, 
	                 hwSetWdIntrp, 
	                 hwSetWdRst, 
	                 resetCore, 
                   timerRstStatDcd, 
	                 timerSetStatDcd, 
	                 wdPulse, 
	                 wdRstType 
	                 );
output [0:5]  timerStatusOutL2;


input  PCL_mtSPR; 
input  PCL_sprHold; 
input  hwSetFitStatus; 
input  hwSetPitStatus; 
input  hwSetWdIntrp; 
input  hwSetWdRst;
input  resetCore; 
input  timerRstStatDcd; 
input  timerSetStatDcd; 
input  wdPulse;

input        CB;
input [0:5]  EXE_sprDataBus;
input [0:1]  wdRstType;

// Buses in the design

wire  [0:5]  tsrDataIn;
wire tsrE2;
reg [0:5]  timerStatusOutL2_i;
wire [0:5]  timerStatusOutL2;

assign timerStatusOutL2 = timerStatusOutL2_i;
// Removed the module dp_regTIM_timerStatus 
   always @(posedge CB)  	
    begin				  	
    if (tsrE2)		 	
      timerStatusOutL2_i[0:5] <= tsrDataIn[0:5];		
   end			 		

p405s_timerStatusEqs
 statusEqsFunc(.tsrDataIn(tsrDataIn[0:5]), 
                             .tsrE2(tsrE2), 
                             .PCL_mtSPR(PCL_mtSPR), 
 		                         .PCL_sprHold(PCL_sprHold), 
 		                         .hwSetWdIntrp(hwSetWdIntrp),
                             .hwSetFitStatus(hwSetFitStatus), 
 		                         .hwSetPitStatus(hwSetPitStatus), 
 		                         .wdRstType(wdRstType[0:1]), 
                     		     .hwSetWdRst(hwSetWdRst), 
                     		     .EXE_sprDataBus(EXE_sprDataBus[0:5]),	 
                     		     .timerRstStatDcd(timerRstStatDcd), 
                     		     .timerSetStatDcd(timerSetStatDcd), 
                     		     .timerStatusOutL2(timerStatusOutL2_i[0:5]), 
                     		     .wdPulse(wdPulse), 
                     		     .resetCore(resetCore)
                     		     );

endmodule
