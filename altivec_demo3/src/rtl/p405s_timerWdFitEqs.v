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
module p405s_timerWdFitEqs( 
                           TIM_timerResetL2Buf, 
                           TIM_wdChipRst, 
                           TIM_wdCoreRst, 
                           TIM_wdSysRst,
                           hwSetFitStatus, 
                           hwSetWdIntrp, 
                           hwSetWdRst, 
                           oscTimerDlyL2, 
                           timResetCoreL2, 
                           wdPulse,
                           CB, 
                           OSC_timer, 
                           enableNxtWdTic, 
                           fitTapSel, 
                           fitTaps, 
                           resetCore, 
                           wdIntrpBit, 
                           wdRstType, 
                           wdTapSel, 
                           wdTaps       
                           );

output  TIM_timerResetL2Buf; 
output  TIM_wdChipRst; 
output  TIM_wdCoreRst; 
output  TIM_wdSysRst; 
output  hwSetFitStatus;
output  hwSetWdIntrp; 
output  hwSetWdRst; 
output  oscTimerDlyL2; 
output  timResetCoreL2; 
output  wdPulse;


input  OSC_timer; 
input  enableNxtWdTic; 
input  resetCore; 
input  wdIntrpBit;



input [0:1]  wdRstType;
input [0:3]  fitTaps;
input [0:1]  fitTapSel;
input [0:1]  wdTapSel;
input CB;
input [0:3]  wdTaps;

reg TIM_timerResetL2;
wire wdTapsIn;
wire fitTapsIn;
wire timerResetIn;
wire  TIM_timerResetL2Buf; 
reg  oscTimerDlyL2; 
reg  timResetCoreL2_i; 
wire  timResetCoreL2; 
reg  wdDlyL2;
reg  fitDlyL2;
reg  timerResetForTimersL2;

assign timResetCoreL2 = timResetCoreL2_i;
//dp_logTIM_timerResetBuf logTIM_timerResetBuf(TIM_timerResetL2, 
//                                             TIM_timerResetL2Buf
//               );
assign TIM_timerResetL2Buf = TIM_timerResetL2;
// Removed the module dp_regTIM_wdRegDly                
   always @(posedge CB)  	
    begin				  	
     {timResetCoreL2_i, oscTimerDlyL2, wdDlyL2, 
      fitDlyL2, TIM_timerResetL2, 
      timerResetForTimersL2} <= {resetCore, OSC_timer, wdTapsIn,
                                fitTapsIn, timerResetIn,timerResetIn};		
   end			 		

p405s_timerWdFitCode
 timerWdFitFunc(.wdTapsIn(wdTapsIn), 
                              .fitTapsIn(fitTapsIn), 
                              .nxtTimerResetIn(timerResetIn), 
                              .hwSetFitStatus(hwSetFitStatus), 
                              .hwSetWdIntrp(hwSetWdIntrp),
                              .hwSetWdRst(hwSetWdRst), 
                              .wdPulse(wdPulse), 
                              .TIM_wdCoreRst(TIM_wdCoreRst), 
                              .TIM_wdChipRst(TIM_wdChipRst), 
                              .TIM_wdSysRst(TIM_wdSysRst), 
                              .fitTapSel(fitTapSel[0:1]),
                              .fitTaps(fitTaps[0:3]), 
                              .enableNxtWdTic(enableNxtWdTic), 
                              .timerResetForTimersL2(timerResetForTimersL2), 
                              .wdIntrpBit(wdIntrpBit), 
                              .wdTapSel(wdTapSel[0:1]),
                              .wdTaps(wdTaps[0:3]), 
                              .wdRstType(wdRstType[0:1]), 
                              .wdDlyL2(wdDlyL2), 
                              .fitDlyL2(fitDlyL2), 
                              .timResetCoreL2(timResetCoreL2_i)
                              );

endmodule
