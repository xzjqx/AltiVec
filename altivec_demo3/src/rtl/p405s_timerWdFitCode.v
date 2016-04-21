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
module p405s_timerWdFitCode (
                       wdTapsIn, 
                       fitTapsIn, 
                       nxtTimerResetIn, 
                       hwSetFitStatus, 
                       hwSetWdIntrp, 
                       hwSetWdRst, 
                       wdPulse, 
                       TIM_wdCoreRst, 
                       TIM_wdChipRst, 
                       TIM_wdSysRst,
                       fitTapSel, 
                       fitTaps, 
                       enableNxtWdTic, 
                       timerResetForTimersL2, 
                       wdIntrpBit,
                       wdTapSel, 
                       wdTaps, 
                       wdRstType, 
                       wdDlyL2, 
                       fitDlyL2, 
                       timResetCoreL2
                       );

output hwSetFitStatus;
output hwSetWdIntrp;
output hwSetWdRst;
output wdPulse;
output TIM_wdCoreRst;
output TIM_wdChipRst;
output TIM_wdSysRst;
output wdTapsIn;
output fitTapsIn;
output nxtTimerResetIn;

input [0:1] fitTapSel;
input [0:3] fitTaps;
input enableNxtWdTic;
input wdIntrpBit;
input [0:1] wdTapSel;
input [0:3] wdTaps;
input [0:1] wdRstType;
input wdDlyL2;
input fitDlyL2;
input timerResetForTimersL2;
input timResetCoreL2;

wire wdPulseQual;
wire wdPulse_i;
wire wdPulse;
wire wdTapsIn;
reg wdTapsIn_i;
wire fitTapsIn;
reg fitTapsIn_i;
wire hwSetWdRst;
wire hwSetWdRst_i;

assign hwSetWdRst = hwSetWdRst_i;
assign wdPulse = wdPulse_i;
assign wdTapsIn = wdTapsIn_i;
assign fitTapsIn = fitTapsIn_i;

// 02/21/97 LMD Reset logic updates. All core generated resets will remain
//              active until reset is driven back to core.
//              Replaced suppressNxtWdTic with enableNxtWdTic.
//              Created wdDlyL2 and fitDlyL2.

always @(wdTaps or wdTapSel or fitTaps or fitTapSel)
begin
   casez(wdTapSel) // synopsys full_case parallel_case
      2'b00: wdTapsIn_i = wdTaps[0];
      2'b01: wdTapsIn_i = wdTaps[1];
      2'b10: wdTapsIn_i = wdTaps[2];
      2'b11: wdTapsIn_i = wdTaps[3];
// x catcher.
      default: wdTapsIn_i = 1'bx;
   endcase
   casez(fitTapSel) // synopsys full_case parallel_case
      2'b00: fitTapsIn_i = fitTaps[0];
      2'b01: fitTapsIn_i = fitTaps[1];
      2'b10: fitTapsIn_i = fitTaps[2];
      2'b11: fitTapsIn_i = fitTaps[3];
// x catcher.
      default: fitTapsIn_i = 1'bx;
   endcase
end

assign wdPulse_i = wdTapsIn_i & ~wdDlyL2;

assign wdPulseQual = wdPulse_i & enableNxtWdTic;

assign hwSetWdRst_i = (wdRstType[0] | wdRstType[1]) & wdIntrpBit & wdPulseQual;

assign hwSetWdIntrp = wdPulseQual;

// The 3 watchdog resets.
assign TIM_wdCoreRst = timerResetForTimersL2 & ~wdRstType[0] & wdRstType[1];

assign TIM_wdChipRst = timerResetForTimersL2 & wdRstType[0] & ~wdRstType[1];

assign TIM_wdSysRst = timerResetForTimersL2 & wdRstType[0] & wdRstType[1];

// Fit Set Equation.
assign hwSetFitStatus = fitTapsIn_i & ~fitDlyL2;

assign nxtTimerResetIn = ~(timResetCoreL2 | ~(hwSetWdRst_i | 
                           timerResetForTimersL2));

endmodule
