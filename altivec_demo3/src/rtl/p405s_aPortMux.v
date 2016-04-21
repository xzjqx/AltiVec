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

module p405s_aPortMux( PCL_LpEqAp, PCL_RpEqAp, PCL_dcdApAddr, exeMorMRpEqdcdApAddr,
     exeRpEqdcdApAddr, wbLpEqdcdApAddr, dcdApMuxSel_NEG, dcdRAEqexeMorMRpAddr,
     dcdRAEqexeRpAddr, dcdRAEqlwbLpAddr, dcdRAEqwbLpAddr, dcdRAEqwbRpAddr,
     dcdRSEqexeMorMRpAddr, dcdRSEqexeRpAddr, dcdRSEqlwbLpAddr, dcdRSEqwbLpAddr,
     dcdRSEqwbRpAddr, preDcdRA, preDcdRSRT, rdEn );
output  PCL_LpEqAp, PCL_RpEqAp, exeMorMRpEqdcdApAddr, exeRpEqdcdApAddr, wbLpEqdcdApAddr;


input  dcdApMuxSel_NEG, dcdRAEqexeMorMRpAddr, dcdRAEqexeRpAddr, dcdRAEqlwbLpAddr,
     dcdRAEqwbLpAddr, dcdRAEqwbRpAddr, dcdRSEqexeMorMRpAddr, dcdRSEqexeRpAddr,
     dcdRSEqlwbLpAddr, dcdRSEqwbLpAddr, dcdRSEqwbRpAddr, rdEn;

output [0:9]  PCL_dcdApAddr;


input [0:9]  preDcdRSRT;
input [0:9]  preDcdRA;

// Buses in the design

wire  [0:9]  aPortAddrMuxOut;
wire dcdApMuxSel;

//Removed the module dp_logPCL_aPortAddrGate 
assign dcdApMuxSel = ~(rdEn & dcdApMuxSel_NEG);

//Removed the module dp_muxPCL_aPortDepend 
assign {PCL_RpEqAp, PCL_LpEqAp, wbLpEqdcdApAddr, exeRpEqdcdApAddr, exeMorMRpEqdcdApAddr}
       = dcdApMuxSel_NEG ? {dcdRSEqwbRpAddr, dcdRSEqlwbLpAddr,
                            dcdRSEqwbLpAddr, dcdRSEqexeRpAddr, 
                            dcdRSEqexeMorMRpAddr}
                         : {dcdRAEqwbRpAddr, dcdRAEqlwbLpAddr, dcdRAEqwbLpAddr,
                            dcdRAEqexeRpAddr, dcdRAEqexeMorMRpAddr};
                         
                         
//Removed the module dp_logPCL_aPortAddrINV 
assign PCL_dcdApAddr = ~aPortAddrMuxOut;

//Removed the module dp_muxPCL_aPortAddr 
assign aPortAddrMuxOut = dcdApMuxSel ? ~preDcdRA : ~preDcdRSRT;

endmodule
