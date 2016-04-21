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

//***********************//
// Tbird Change History  //
//***********************//
//
// NAME        DATE      DEFECT                 DESCRIPTION
// ~~~~      ~~~~~~~~    ~~~~~~            ~~~~~~~~~~~~~~~~~~~~~~
// JBB       10/22/02     2297        (1) Brought in new inputs CB1, CB4 and
//                                        output PCL_gprRdClk.  
//                                    
//                                    (2) Added calls to INVERT_E, DELAY6_F, NAND3_D,
//                                        AND2_K , and INVERT_E and wired these in for
//                                        GPR clock gating and delays.
//
// JBB       11/08/02     2299        (1) Removed CB4 from port list.  Input no longer
//                                        needed.
//                                    (2) Changed clock gating structure:
//                                        (a) Removed INVERT_E.v  (clkChopCB4INV)
//                                        (b) Removed AND2_K.v (clkChopAND2)
//                                        (c) Brought PCL_gprRdClk directly
//                                            out of NAND3_D.v (clkChopDlyNAND3)
//                              
//----------------------------------------------------------------------------//

module p405s_clkChop (CB, rdEn, DRCC, ERC, IFB_dcdFullL2, LSSD_coreTestEn, c2Clk,
                      exeStore, PCL_gprRdClk);

output  rdEn;
output  PCL_gprRdClk;

wire clkChopMuxSel;
wire funcDRC;

input  DRCC, ERC, IFB_dcdFullL2, LSSD_coreTestEn, exeStore;
//RDH unsused input pins
input  CB, c2Clk;

assign PCL_gprRdClk = ~LSSD_coreTestEn;
assign rdEn = clkChopMuxSel ? ERC : ~LSSD_coreTestEn;

assign funcDRC = ~(IFB_dcdFullL2 | exeStore);
assign clkChopMuxSel = funcDRC | DRCC;


endmodule
