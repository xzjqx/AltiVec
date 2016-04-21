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

module p405s_bPortMux( PCL_LpEqBp, PCL_RpEqBp, PCL_dcdBpAddr, exeMorMRpEqdcdBpAddr,
     exeRpEqdcdBpAddr, wbLpEqdcdBpAddr, dcdBpMuxSel_NEG, dcdRAEqexeMorMRpAddr,
     dcdRAEqexeRpAddr, dcdRAEqlwbLpAddr, dcdRAEqwbLpAddr, dcdRAEqwbRpAddr,
     dcdRBEqexeMorMRpAddr, dcdRBEqexeRpAddr, dcdRBEqlwbLpAddr, dcdRBEqwbLpAddr,
     dcdRBEqwbRpAddr, preDcdRA, preDcdRB, rdEn, dcdBpMuxSel );
output  PCL_LpEqBp, PCL_RpEqBp, exeMorMRpEqdcdBpAddr, exeRpEqdcdBpAddr, wbLpEqdcdBpAddr;

//added for tbird
output dcdBpMuxSel;

input  dcdBpMuxSel_NEG, dcdRAEqexeMorMRpAddr, dcdRAEqexeRpAddr, dcdRAEqlwbLpAddr,
     dcdRAEqwbLpAddr, dcdRAEqwbRpAddr, dcdRBEqexeMorMRpAddr, dcdRBEqexeRpAddr,
     dcdRBEqlwbLpAddr, dcdRBEqwbLpAddr, dcdRBEqwbRpAddr, rdEn;

output [0:9]  PCL_dcdBpAddr;


input [0:9]  preDcdRB;
input [0:9]  preDcdRA;

// Buses in the design

wire  [0:9]  bPortAddrMuxOut;
wire  dcdBpMuxSel_i;

assign  dcdBpMuxSel =  dcdBpMuxSel_i;

//Removed the module dp_muxPCL_bPortDepend 
assign {PCL_RpEqBp, PCL_LpEqBp, wbLpEqdcdBpAddr, exeRpEqdcdBpAddr, exeMorMRpEqdcdBpAddr} 
       = dcdBpMuxSel_NEG ? {dcdRAEqwbRpAddr, dcdRAEqlwbLpAddr,
                            dcdRAEqwbLpAddr, dcdRAEqexeRpAddr, 
                            dcdRAEqexeMorMRpAddr} 
                         : {dcdRBEqwbRpAddr, dcdRBEqlwbLpAddr, dcdRBEqwbLpAddr,
                            dcdRBEqexeRpAddr, dcdRBEqexeMorMRpAddr};

//Removed the module dp_logPCL_bPortAddrINV 
assign PCL_dcdBpAddr = ~bPortAddrMuxOut;

//Removed the module dp_muxPCL_bPortAddr 
assign bPortAddrMuxOut = dcdBpMuxSel_i ? ~preDcdRB : ~preDcdRA;

   // Replacing instantiation: GTECH_NAND2 aPortAddrGate
   assign dcdBpMuxSel_i = ~( rdEn & dcdBpMuxSel_NEG );


endmodule
