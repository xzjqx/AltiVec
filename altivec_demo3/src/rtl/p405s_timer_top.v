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
module p405s_timer_top ( 
                  TIM_fitIntrp, 
                  TIM_pitIntrp, 
                  TIM_sprDataBus, 
                  TIM_timerResetL2Buf,
                  TIM_watchDogIntrp, 
                  TIM_wdChipRst, 
                  TIM_wdCoreRst, 
                  TIM_wdSysRst, 
                  CB,
                  DBG_freezeTimers, 
                  EXE_sprDataBus, 
                  EXE_timSprDcds, 
                  JTG_freezeTimers,
                  LSSD_coreTestEn, 
                  OSC_timer, 
                  PCL_mtSPR, 
                  PCL_sprHold, 
                  resetCore 
                  );
    
output  TIM_fitIntrp; 
output  TIM_pitIntrp; 
output  TIM_timerResetL2Buf; 
output  TIM_watchDogIntrp; 
output  TIM_wdChipRst;
output  TIM_wdCoreRst; 
output  TIM_wdSysRst; 
output [0:31]  TIM_sprDataBus;

input  DBG_freezeTimers; 
input  JTG_freezeTimers; 
input  LSSD_coreTestEn; 
input  OSC_timer; 
input  PCL_mtSPR; 
input  PCL_sprHold;
input  resetCore; 

input [0:31]  EXE_sprDataBus;
input [0:5]   EXE_timSprDcds;
input         CB;

// Buses in the design

wire  [0:31]  tbhL2;
wire  [0:31]  pitL2;
wire  [0:5]   timerStatusOutL2;
wire  [0:31]  tblL2;
wire  [0:9]   timerControlL2;
wire timResetCoreL2; 
wire hwSetFitStatus; 
wire hwSetPitStatus; 
wire hwSetWdIntrp; 
wire hwSetWdRst;
wire wdPulse; 
wire oscTimerDlyL2; 
wire freezeTimersNEG;
wire timerTic;
wire cOut; 

// Removed the module timClkBuf

p405s_timerSprBus
 sprBusSch( 
                            .TIM_SprDataBus(TIM_sprDataBus[0:31]), 
                            .TIM_fitIntrp(TIM_fitIntrp), 
                            .TIM_pitIntrp(TIM_pitIntrp), 
                            .TIM_watchDogIntrp(TIM_watchDogIntrp),
                            .pit(pitL2[0:31]), 
                            .pitDcd(EXE_timSprDcds[3]), 
                            .tbh(tbhL2[0:31]), 
                            .tbhDcd(EXE_timSprDcds[5]), 
                            .tbl(tblL2[0:31]),
                            .tcrDcd(EXE_timSprDcds[0]), 
                            .timerControlL2(timerControlL2[0:9]), 
                            .timerRstStatDcd(EXE_timSprDcds[1]), 
                            .timerStatusOutL2(timerStatusOutL2[0:5])
                            );
        
p405s_timerControl
 controlSch(  
                              .timerControlL2(timerControlL2[0:9]), 
                              .CB(CB), 
                              .EXE_sprDataBus(EXE_sprDataBus[0:9]),
                              .PCL_mtSPR(PCL_mtSPR), 
                              .PCL_sprHold(PCL_sprHold), 
                              .resetCore(timResetCoreL2), 
                              .tcrDcd(EXE_timSprDcds[0])
                             );
    
p405s_timerStatus
 statusSch(
                            .timerStatusOutL2(timerStatusOutL2[0:5]),
                            .CB(CB), 
                            .EXE_sprDataBus(EXE_sprDataBus[0:5]),  
                            .PCL_mtSPR(PCL_mtSPR), 
                            .PCL_sprHold(PCL_sprHold), 
                            .hwSetFitStatus(hwSetFitStatus), 
                            .hwSetPitStatus(hwSetPitStatus), 
                            .hwSetWdIntrp(hwSetWdIntrp), 
                            .hwSetWdRst( hwSetWdRst),
                            .resetCore(timResetCoreL2), 
                            .timerRstStatDcd(EXE_timSprDcds[1]), 
                            .timerSetStatDcd(EXE_timSprDcds[2]), 
                            .wdPulse(wdPulse), 
                            .wdRstType(timerControlL2[2:3])
                              );

p405s_timerWdFitEqs
 wdFitEqsSch(
                                .TIM_timerResetL2Buf(TIM_timerResetL2Buf), 
                                .TIM_wdChipRst(TIM_wdChipRst), 
                                .TIM_wdCoreRst(TIM_wdCoreRst), 
                                .TIM_wdSysRst(TIM_wdSysRst),
                                .hwSetFitStatus(hwSetFitStatus), 
                                .hwSetWdIntrp(hwSetWdIntrp), 
                                .hwSetWdRst(hwSetWdRst), 
                                .oscTimerDlyL2(oscTimerDlyL2), 
                                .timResetCoreL2(timResetCoreL2), 
                                .wdPulse(wdPulse),
                                .CB(CB), 
                                .OSC_timer(OSC_timer), 
                                .enableNxtWdTic(timerStatusOutL2[0]), 
                                .fitTapSel(timerControlL2[6:7]), 
                                .fitTaps({tblL2[23],tblL2[19], tblL2[15],
                                          tblL2[11]}), 
                                .resetCore(resetCore), 
                                .wdIntrpBit(timerStatusOutL2[1]),
                                .wdRstType(timerControlL2[2:3]), 
                                .wdTapSel(timerControlL2[0:1]), 
                                .wdTaps({tblL2[15], tblL2[11], tblL2[7],
                                         tblL2[3]})
                              );

p405s_timerPit
 pitSch(
                      .hwSetPitStatus(hwSetPitStatus), 
                      .pitL2(pitL2[0:31]), 
                      .CB(CB),
                      .EXE_sprDataBus(EXE_sprDataBus[0:31]), 
                      .LSSD_coreTestEn(LSSD_coreTestEn), 
                      .PCL_mtSPR(PCL_mtSPR), 
                      .PCL_sprHold(PCL_sprHold), 
                      .freezeTimersNEG(freezeTimersNEG),
                      .pitDcd(EXE_timSprDcds[3]), 
                      .tcrARenable(timerControlL2[9]), 
                      .timerTic(timerTic) 
                       );
     
p405s_timerTbh
 tbhSch(
                      .tbhL2(tbhL2[0:31]), 
                      .CB(CB), 
                      .EXE_sprDataBus(EXE_sprDataBus[0:31]), 
                      .PCL_mtSPR(PCL_mtSPR),
                      .PCL_sprHold(PCL_sprHold), 
                      .cIn(cOut), 
                      .freezeTimersNEG(freezeTimersNEG), 
                      .tbhDcd(EXE_timSprDcds[5])
                      );

p405s_timerTbl
 tblSch(
                      .cOut(cOut), 
                      .freezeTimersNEG(freezeTimersNEG), 
                      .tblL2(tblL2[0:31]), 
                      .timerTic(timerTic), 
                      .CB(CB),
                      .DBG_freezeTimers(DBG_freezeTimers), 
                      .EXE_sprDataBus(EXE_sprDataBus[0:31]), 
                      .JTG_freezeTimers(JTG_freezeTimers), 
                      .PCL_mtSPR(PCL_mtSPR), 
                      .PCL_sprHold(PCL_sprHold),
                      .oscTimerDlyL2(oscTimerDlyL2), 
                      .tblDcd(EXE_timSprDcds[4])
                      );

endmodule
