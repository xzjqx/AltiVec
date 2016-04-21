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
// Verilog HDL for "PR_gpr", "PRgprFile_top" "_structural"
//***********************//
// Tbird Change History  //
//***********************//
//
// NAME        DATE      DEFECT                 DESCRIPTION
// ~~~~      ~~~~~~~~    ~~~~~~            ~~~~~~~~~~~~~~~~~~~~~~
// JBB       10/22/02     2297      (1)  Added the following low power GPR 
//                                       inputs/outputs and wired them to the
//                                       GPRLV2W3R32X32_RTP_I wrapper:
//                                       
//                                       oscnandout, CB_4, EXE_gprDetectBypass,
//                                       EXE_gprFmin_enable, osc_return, 
//                                       EXE_gprRen, CB_buf_1, EXE_gprSysClkPI, 
//                                       EXE_gprV_detect 
//       
//                                  (2)  Widened scanin and scanout (SI and SO)
//                                       by one bit each.
//
// JBB       11/03/02     2299      Added LSSD inputs EXE_gprLc and EXE_gprTe.
//
// JBB       11/12/02     2300      Changed oscnandout from input to output after 
//                                  ###formality run of 11/11 (consistency).
//
//*********************************************************************************//

// Defect 2297
//module SM_GPR2W3R32X32_RTP (aPort, bPort, sPort, lPort, rPort, ApAddr, BpAddr,
//           SpAddr, LpAddr, LpWE, RpAddr, RpWE, LpEqAp, LpEqBp, LpEqSp,
//           RpEqAp, RpEqBp, RpEqSp, BpEqSp, SysClk, ACLK, BCLK, CCLK, SI,
//           SO);

module p405s_SM_GPR2W3R32X32_RTP 
          (aPort, bPort, sPort, lPort, rPort, ApAddr, BpAddr,
           SpAddr, LpAddr, LpWE, RpAddr, RpWE, LpEqAp, LpEqBp, LpEqSp,
           RpEqAp, RpEqBp, RpEqSp, BpEqSp, SysClk, 
// Defect 2299
//	   osc_return, EXE_gprRen, CB_buf_1, EXE_gprSysClkPI, EXE_gprV_detect);
 	   EXE_gprRen, EXE_gprSysClkPI); 
	   	   
    output [0:31] aPort;
    output [0:31] bPort;
    output [0:31] sPort;
// Defect 2300
       
    input [0:31] lPort;
    input [0:31] rPort;
    input [0:9] ApAddr;
    input [0:9] BpAddr;
    input [0:9] SpAddr;
    input [0:4] LpAddr;
    input LpWE;
    input [0:4] RpAddr;
    input RpWE;
    input LpEqAp;
    input LpEqBp;
    input LpEqSp;
    input RpEqAp;
    input RpEqBp;
    input RpEqSp;
    input BpEqSp;
    input SysClk;
    
// Defect 2297    
// input [0:1] SI;
// output [0:1] SO;

//    input [0:2] SI;
    
// Defect 2300     	    
//  input oscnandout;
	    
    input EXE_gprRen;	    
    input EXE_gprSysClkPI;      
// Defect 2299
          
//    output [0:2] SO;	    

p405s_exe_gpr
 p405s_exe_gpr_i (.aPort(aPort),
                               .bPort(bPort),
                               .sPort(sPort),
                               .lPort(lPort),
                               .rPort(rPort),
                               .ApAddr(ApAddr),
                               .BpAddr(BpAddr),
                               .SpAddr(SpAddr),
                               .LpAddr(LpAddr),
                               .LpWE(LpWE),
                               .RpAddr(RpAddr),
                               .RpWE(RpWE),
                               .LpEqAp(LpEqAp),
                               .LpEqBp(LpEqBp),
                               .LpEqSp(LpEqSp),
                               .RpEqAp(RpEqAp),
                               .RpEqBp(RpEqBp),
                               .RpEqSp(RpEqSp),
                               .BpEqSp(BpEqSp),
                               .SysClk(SysClk),
                               .EXE_gprRen(EXE_gprRen),	    
                               .EXE_gprSysClkPI(EXE_gprSysClkPI));      
endmodule
