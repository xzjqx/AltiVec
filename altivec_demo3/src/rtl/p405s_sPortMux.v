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

module p405s_sPortMux( PCL_LpEqSp, PCL_RpEqSp, PCL_dcdSpAddr, dcdSpAddr, dcdRSEqlwbLpAddr,
     dcdRSEqwbRpAddr, dcdRSRTL2, dcdSpAddrEn, exeRS, exeRSEqlwbLpAddr,
     exeRSEqwbRpAddr, preDcdRSRT, preExeRS, rdEn, sPortSelInc, dcdSpMuxSel );
output  PCL_LpEqSp, PCL_RpEqSp;

// added for tbird
output dcdSpMuxSel;

input  dcdRSEqlwbLpAddr, dcdRSEqwbRpAddr, dcdSpAddrEn, exeRSEqlwbLpAddr, exeRSEqwbRpAddr, rdEn,
     sPortSelInc;

output [0:9]  PCL_dcdSpAddr;
output [0:4]  dcdSpAddr;


input [0:4]  dcdRSRTL2;
input [0:4]  exeRS;
input [0:9]  preExeRS;
input [0:9]  preDcdRSRT;

// Buses in the design

wire  [0:11]  sPortAddrMuxOut;
wire dcdSpMuxSel_NEG;
wire rdEn_NEG;
wire symNet27;
wire dcdSpMuxSel_i;

assign dcdSpMuxSel = dcdSpMuxSel_i;

//Removed the module dp_logPCL_sPortAddrINV 
assign {PCL_dcdSpAddr, PCL_RpEqSp, PCL_LpEqSp} = ~sPortAddrMuxOut;

   // Replacing instantiation: GTECH_NOR3 I420
   assign dcdSpMuxSel_NEG = ~( symNet27 | sPortSelInc | rdEn_NEG );

//Removed the module dp_muxPCL_sPortAddr 
assign sPortAddrMuxOut = dcdSpMuxSel_i ? ~{preExeRS, exeRSEqwbRpAddr, exeRSEqlwbLpAddr} 
                                     : ~{preDcdRSRT, dcdRSEqwbRpAddr, dcdRSEqlwbLpAddr};

//Removed the module dp_muxPCL_spAddrForInc 
assign dcdSpAddr = dcdSpMuxSel_i ? exeRS : dcdRSRTL2;

   // Replacing instantiation: GTECH_NOT I424
   assign rdEn_NEG = ~(rdEn);

   // Replacing instantiation: GTECH_NOT I47
   assign symNet27 = ~(dcdSpAddrEn);

   // Replacing instantiation: GTECH_NOT I43
   assign dcdSpMuxSel_i = ~(dcdSpMuxSel_NEG);


endmodule
