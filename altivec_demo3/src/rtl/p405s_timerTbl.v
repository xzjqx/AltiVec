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
module p405s_timerTbl( 
                cOut, 
                freezeTimersNEG, 
                tblL2, 
                timerTic, 
                CB, 
                DBG_freezeTimers,
                EXE_sprDataBus, 
                JTG_freezeTimers, 
                PCL_mtSPR, 
                PCL_sprHold, 
                oscTimerDlyL2, 
                tblDcd           
               );

output  cOut; 
output  freezeTimersNEG; 
output  timerTic;
output [0:31]  tblL2;

input  DBG_freezeTimers; 
input  JTG_freezeTimers; 
input  PCL_mtSPR; 
input  PCL_sprHold; 
input  oscTimerDlyL2; 
input  tblDcd;
input [0:31]  EXE_sprDataBus;
input CB;

// Buses in the design

wire  [0:31]  inc;
wire timerTic ;
wire timerTic_i ;
wire freezeTimersNEG ;
wire freezeTimersNEG_i ;
wire cOut8 ;
wire cOut ;
wire sprDataSel ;
wire tbl8E1 ;
wire tbl8E2 ;
wire tbl24E1 ;
wire tbl24E2 ;
reg [0:31]  tblL2_i;
wire [0:31]  tblL2;

assign freezeTimersNEG = freezeTimersNEG_i;
assign timerTic = timerTic_i;
assign tblL2 = tblL2_i;
// Removed the module timerTblEqs 
assign timerTic_i = oscTimerDlyL2;
assign freezeTimersNEG_i = ~(DBG_freezeTimers | JTG_freezeTimers);

assign cOut8 = (&tblL2_i[24:31]) & timerTic_i;
assign cOut = (&tblL2_i[0:23]) & cOut8;

assign sprDataSel = PCL_mtSPR & tblDcd & ~PCL_sprHold;

assign tbl8E1 = timerTic_i | PCL_mtSPR;
assign tbl8E2 = (PCL_mtSPR & tblDcd & ~PCL_sprHold) | 
                (timerTic_i & freezeTimersNEG_i);

assign tbl24E1 = cOut8 | PCL_mtSPR;
assign tbl24E2 = (PCL_mtSPR & tblDcd & ~PCL_sprHold) | 
                 (cOut8 & freezeTimersNEG_i);

//timerTblInc24 TblInc24(inc[0:23], tblL2[0:23]);
assign inc[0:23] = tblL2_i[0:23] + 1;

//timerTblInc8 TblInc8(inc[24:31], tblL2[24:31]);
assign inc[24:31] = tblL2_i[24:31] + 1;
// Removed the module dp_regTIM_timerTbl24 
   always @(posedge CB)    
    begin            
    if (tbl24E1 && tbl24E2)    
      if (~sprDataSel)      
        tblL2_i[0:23] <= inc[0:23];  
      else
        tblL2_i[0:23] <= EXE_sprDataBus[0:23];  
   end           
// Removed the module dp_regTIM_timerTbl8 
   always @(posedge CB)  	
    begin				  	
    if (tbl8E1 && tbl8E2)		
      if (~sprDataSel)			
        tblL2_i[24:31] <= inc[24:31];	
      else
        tblL2_i[24:31] <= EXE_sprDataBus[24:31];	
   end			 		
endmodule
