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
module p405s_timerStatusEqs (
                             tsrDataIn, 
                             tsrE2, 
 	                           PCL_mtSPR, 
 	                           PCL_sprHold, 
                             hwSetWdIntrp, 
 	                           hwSetFitStatus, 
 	                           hwSetPitStatus, 
                             wdRstType, 
 	                           hwSetWdRst, 
 	                           EXE_sprDataBus, 
                             timerRstStatDcd, 
 	                           timerSetStatDcd, 
 	                           timerStatusOutL2, 
 	                           wdPulse, 
 	                           resetCore
 	                           );
   
output [0:5] tsrDataIn;
output tsrE2;

input PCL_mtSPR;
input PCL_sprHold;
input hwSetWdIntrp;
input hwSetFitStatus;
input hwSetPitStatus;
input [0:1] wdRstType;
input hwSetWdRst;
input [0:5] EXE_sprDataBus;
input timerRstStatDcd;
input timerSetStatDcd;
input [0:5] timerStatusOutL2;
input wdPulse;
input resetCore;

reg [0:5] codeMux;
    
wire codeSetAccess, codeRstAccess, hwSet, selCodePath;
wire [0:5] codeSet, codeRst, codePath;

always @(selCodePath or codePath or timerStatusOutL2)
  casez(selCodePath)
    1'b0: codeMux = timerStatusOutL2;
    1'b1: codeMux = codePath;
    default : codeMux = 6'bxxxxx;
  endcase
  
assign codeSetAccess = PCL_mtSPR & timerSetStatDcd;

assign codeRstAccess = PCL_mtSPR & timerRstStatDcd;

assign codeSet[0:5] = EXE_sprDataBus[0:5] & ({6{codeSetAccess}});

assign codeRst[0:5] = EXE_sprDataBus[0:5] & ({6{codeRstAccess}});

assign selCodePath = (codeRstAccess | codeSetAccess) & ~PCL_sprHold;

assign codePath[0:5] = (codeSet[0:5] | timerStatusOutL2[0:5]) & ~codeRst[0:5];

assign hwSet = hwSetPitStatus | hwSetFitStatus | wdPulse | resetCore;

assign tsrE2 = hwSet | (PCL_mtSPR & ~PCL_sprHold & (codeSetAccess | 
               codeRstAccess));

assign tsrDataIn[0] = (codeMux[0] | wdPulse | resetCore);

assign tsrDataIn[1] = (codeMux[1] | hwSetWdIntrp);

assign tsrDataIn[2:3] = (codeMux[2:3] & {2{~hwSetWdRst}}) |
			(wdRstType & {2{hwSetWdRst}});

assign tsrDataIn[4] = (codeMux[4] | hwSetPitStatus);

assign tsrDataIn[5] = (codeMux[5] | hwSetFitStatus);

endmodule
