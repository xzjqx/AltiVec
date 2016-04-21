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

module p405s_timerPit(
                      hwSetPitStatus, 
		                  pitL2,
                      CB,
                      EXE_sprDataBus,
                      LSSD_coreTestEn,
                      PCL_mtSPR,
                      PCL_sprHold, 
               	     	freezeTimersNEG, 
               	     	pitDcd, 
               	     	tcrARenable,
               	     	timerTic         
               	       );

output  hwSetPitStatus; 


input LSSD_coreTestEn; 
input	PCL_mtSPR; 
input	PCL_sprHold; 
input	freezeTimersNEG; 
input	pitDcd; 
input	tcrARenable;
input timerTic;

output [0:31]  pitL2;


input         CB;
input [0:31]  EXE_sprDataBus;

// Buses in the design
wire  [0:31]  dec;
wire  [0:1]  pitMuxSel;
wire pit8E1;
wire pit8E2;
wire pit24E1;
wire pit24E2;
wire pitReloadE1;
wire pitReloadE2;
reg [0:31] pitL2_i;
wire [0:31] pitL2;
reg [0:31] pitReload;

assign pitL2 = pitL2_i;
//timerPitDec timerPitDecFunc(dec[0:31], pitL2[0:31]);
assign dec = pitL2_i - 1;
// Removed the module dp_regTIM_pit8 
   always @(posedge CB)  	
    begin				  	
      if (pit8E1 && pit8E2)		
      begin
        case(pitMuxSel[0:1])			
         2'b00: pitL2_i[24:31] <= dec[24:31];	
         2'b01: pitL2_i[24:31] <= {8{1'b0}};	
         2'b10: pitL2_i[24:31] <= pitReload[24:31];	
         2'b11: pitL2_i[24:31] <= EXE_sprDataBus[24:31];	
          default:  pitL2_i[24:31] <= 8'bx;  
        endcase		 		
      end
   end			 		
// Removed the module dp_regTIM_pit24 
   always @(posedge CB)  	
    begin				  	
    if (pit24E1 && pit24E2)		
    begin
      case(pitMuxSel[0:1])			
       2'b00: pitL2_i[0:23] <= dec[0:23];	
       2'b01: pitL2_i[0:23] <= {24{1'b0}};	
       2'b10: pitL2_i[0:23] <= pitReload[0:23];	
       2'b11: pitL2_i[0:23] <= EXE_sprDataBus[0:23];	
        default: pitL2_i[0:23] <= 24'bx;  
      endcase		 		
    end
   end			 		
// Removed the module dp_regTIM_pitReload 
   always @(posedge CB)  	
    begin				  	
    if (pitReloadE1 && pitReloadE2)		
      pitReload[0:31] <= EXE_sprDataBus[0:31];		
   end			 		
p405s_timerPitEqs
 timerPitFunc(.pit8E1(pit8E1), 
                         .pit8E2(pit8E2), 
  		                   .pit24E1(pit24E1), 
                    		 .pit24E2(pit24E2), 
                    		 .pitReloadE1(pitReloadE1), 
                         .pitReloadE2(pitReloadE2), 
                         .pitMuxSel(pitMuxSel[0:1]),
                         .hwSetPitStatus(hwSetPitStatus),
                         .PCL_mtSPR(PCL_mtSPR),
                         .PCL_sprHold(PCL_sprHold),
                         .tcrARenable(tcrARenable),
                         .pitDcd(pitDcd),
                         .timerTic(timerTic),
                         .pitL2(pitL2_i[0:31]),
                         .freezeTimersNEG(freezeTimersNEG),
                         .LSSD_coreTestEn(LSSD_coreTestEn));

endmodule
