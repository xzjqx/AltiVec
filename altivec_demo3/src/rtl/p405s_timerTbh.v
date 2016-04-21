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

module p405s_timerTbh( 
                      tbhL2, 
                      CB, 
                      EXE_sprDataBus, 
                      PCL_mtSPR, 
                      PCL_sprHold, 
                      cIn,
                      freezeTimersNEG, 
                      tbhDcd          
                      );


input  PCL_mtSPR; 
input  PCL_sprHold; 
input  cIn; 
input  freezeTimersNEG; 
input  tbhDcd;

output [0:31]  tbhL2;


input CB;
input [0:31]  EXE_sprDataBus;

// Buses in the design
wire  [0:31]  inc;
wire tbhE1;
wire tbhE2;
wire sprDataSel;
reg [0:31]  tbhL2_i;
wire [0:31]  tbhL2;

assign tbhL2 = tbhL2_i;
//timerTbhInc tbhInc(inc[0:31], tbhL2[0:31]);
assign inc = tbhL2_i + 1;

// Removed the module dp_regTIM_timerTbh 
   always @(posedge CB)  	
    begin				  	
    if (tbhE1 && tbhE2)		
      if (~sprDataSel)			
         tbhL2_i <= inc;	
      else
         tbhL2_i <= EXE_sprDataBus;	
   end			 		
// Removed the module timerTbhEqs 
// pick the spr side of the mux only when mtspr actually happens,
// default to the incrementer side of the mux.
assign sprDataSel = PCL_mtSPR & tbhDcd & ~PCL_sprHold;

// Enable the L1 for HW inc or mtspr.
assign tbhE1 = cIn | PCL_mtSPR;

// Block C2 if pipe hold, but allow HW inc to override.
assign tbhE2 = (PCL_mtSPR & tbhDcd & ~PCL_sprHold) | (cIn & freezeTimersNEG);

endmodule
