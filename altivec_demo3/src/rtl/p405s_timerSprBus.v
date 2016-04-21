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

module p405s_timerSprBus( 
                   TIM_SprDataBus, 
                   TIM_fitIntrp, 
                   TIM_pitIntrp, 
                   TIM_watchDogIntrp,
                   pit, 
               	   pitDcd, 
               	   tbh, 
               	   tbhDcd, 
               	   tbl, 
               	   tcrDcd, 
               	   timerControlL2,
                   timerRstStatDcd, 
               	   timerStatusOutL2 
               	   );

output  TIM_fitIntrp; 
output  TIM_pitIntrp; 
output  TIM_watchDogIntrp;


input  pitDcd; 
input  tbhDcd; 
input  tcrDcd; 
input  timerRstStatDcd;

output [0:31]  TIM_SprDataBus;


input [0:5]  timerStatusOutL2;
input [0:9]  timerControlL2;
input [0:31]  tbl;
input [0:31]  pit;
input [0:31]  tbh;

// Buses in the design

wire  [0:9]  statCntrlMux;
wire  [0:1]  timerSprBusSel;
reg [0:31]  TIM_SprDataBus;
wire timStatCntrlSel;

// Removed the module timerSprBusEqs 
assign TIM_watchDogIntrp = timerStatusOutL2[1] & timerControlL2[4];
assign TIM_pitIntrp = timerStatusOutL2[4] & timerControlL2[5];
assign TIM_fitIntrp = timerStatusOutL2[5] & timerControlL2[8];
assign timStatCntrlSel = tcrDcd;
assign timerSprBusSel[0] = timerRstStatDcd | tcrDcd | pitDcd;
assign timerSprBusSel[1] = timerRstStatDcd | tcrDcd | tbhDcd;
// Removed the module dp_muxTIM_StatCntrl 
assign statCntrlMux[0:9] = timStatCntrlSel ?  timerControlL2[0:9] : 
                                              {timerStatusOutL2[0:5], {4{1'b0}}};
// Removed the module dp_muxTIM_SprBus
   always @(tbl or tbh or  pit or statCntrlMux or timerSprBusSel) 
    begin 					    
    case(timerSprBusSel)    		    	
     2'b00: TIM_SprDataBus = tbl;    
     2'b01: TIM_SprDataBus = tbh;    
     2'b10: TIM_SprDataBus = pit;    
     2'b11: TIM_SprDataBus = {statCntrlMux[0:9], {22{1'b0}}};    
      default: TIM_SprDataBus = 32'bx;   
    endcase                                    
   end                                         
endmodule
