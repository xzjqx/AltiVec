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
//
module p405s_fileAddrCntl (dcdRAEqlwbLpAddr, dcdRAEqwbLpAddr, dcdRAEqwbRpAddr, dcdRAEqexeRpAddr,
           dcdRBEqlwbLpAddr, dcdRBEqwbLpAddr, dcdRBEqwbRpAddr, dcdRBEqexeRpAddr,
           dcdRSEqlwbLpAddr, dcdRSEqwbLpAddr, dcdRSEqwbRpAddr, dcdRSEqexeRpAddr,
           dcdRAEqexeMorMRpAddr, dcdRBEqexeMorMRpAddr, dcdRSEqexeMorMRpAddr,
           exeRSEqlwbLpAddr, exeRSEqwbRpAddr,
           exeRpEqdcdSpAddr, exeRpEqwbLpAddr, exeRpEqlwbLpAddr,
           lwbLpEqexeApAddr, lwbLpEqexeBpAddr, lwbLpEqexeSpAddr,
           wbLpEqexeApAddr, wbLpEqexeBpAddr, wbLpEqexeSpAddr, exeMorMRpEqexeRpAddr,
           exeRTeqRA, exeRTeqRB, gprLpeqRp,
           dcdRAL2, dcdRBL2, dcdRSRTL2, exeRS, exeApAddr, exeBpAddr, exeSpAddr,
           exeLpAddr, exeRpAddr, exeMacOrMultRpAddr, wbLpAddr, PCL_wbRpAddr,
           PCL_lwbLpAddr, IFB_dcdFullL2, exe1FullL2, exe2FullL2, wbFullL2,
           lwbFullL2, PCL_exeMacEnL2, PCL_exeMultEnL2,
           wbLpEqdcdSpAddr, lwbLpEqdcdSpAddr, exeMorMRpEqwbLpAddr,
           exeMorMRpEqlwbLpAddr, lwbLpAddr_NEG, wbRpAddr_NEG, sPortSelInc,
           dcdBpMuxSel, dcdSpMuxSel, PCL_BpEqSp);

    output dcdRAEqlwbLpAddr;
    output dcdRAEqwbLpAddr;
    output dcdRAEqwbRpAddr;
    output dcdRAEqexeRpAddr;
    output dcdRAEqexeMorMRpAddr;
    output dcdRBEqlwbLpAddr;
    output dcdRBEqwbLpAddr;
    output dcdRBEqwbRpAddr;
    output dcdRBEqexeRpAddr;
    output dcdRBEqexeMorMRpAddr;
    output dcdRSEqlwbLpAddr;
    output dcdRSEqwbLpAddr;
    output dcdRSEqwbRpAddr;
    output dcdRSEqexeRpAddr;
    output dcdRSEqexeMorMRpAddr;
    output exeRSEqlwbLpAddr;
    output exeRSEqwbRpAddr;
    output exeRpEqwbLpAddr;
    output exeRpEqlwbLpAddr;
    output exeRpEqdcdSpAddr;
    output wbLpEqdcdSpAddr;
    output lwbLpEqdcdSpAddr;
    output lwbLpEqexeApAddr;
    output lwbLpEqexeBpAddr;
    output lwbLpEqexeSpAddr;
    output wbLpEqexeApAddr;
    output wbLpEqexeBpAddr;
    output wbLpEqexeSpAddr;
    output exeMorMRpEqexeRpAddr;
    output exeRTeqRA;
    output exeRTeqRB;
    output gprLpeqRp;
    output exeMorMRpEqwbLpAddr;
    output exeMorMRpEqlwbLpAddr;
    output PCL_BpEqSp;
    input [0:4] dcdRAL2;
    input [0:4] dcdRBL2;
    input [0:4] dcdRSRTL2;
    input [0:4] exeRS;
    input [0:4] exeApAddr;
    input [0:4] exeBpAddr;
    input [0:4] exeSpAddr;
    input [0:4] exeLpAddr;
    input [0:4] exeRpAddr;
    input [0:4] exeMacOrMultRpAddr;
    input [0:4] wbLpAddr;
    input [0:4] PCL_wbRpAddr;
    input [0:4] PCL_lwbLpAddr;
    input IFB_dcdFullL2;
    input exe1FullL2;
    input exe2FullL2;
    input wbFullL2;
    input lwbFullL2;
    input PCL_exeMacEnL2;
    input PCL_exeMultEnL2;
    input [0:4] lwbLpAddr_NEG;
    input [0:4] wbRpAddr_NEG;
    input sPortSelInc;
    input dcdBpMuxSel;
    input dcdSpMuxSel;

wire dcdRBEqdcdRSRT, dcdRBEqexeRS;
wire dcdRAEqdcdRSRT, dcdRAEqexeRS;
reg  PCL_BpEqSp;
wire exeRSEqwbLpAddr;
wire exeRSEqlwbLpAddr_i;
wire dcdRSEqwbLpAddr_i;
wire dcdRSEqlwbLpAddr_i;

assign dcdRSEqlwbLpAddr = dcdRSEqlwbLpAddr_i;

assign dcdRSEqwbLpAddr = dcdRSEqwbLpAddr_i;

assign exeRSEqlwbLpAddr = exeRSEqlwbLpAddr_i;


// Changes:
// 09/24/99 SBP Fix for issue 154 pass2 See issue for more detail.

// Compare for GPR Lport and Rport bypass done
// in parallel with address decode for timing.

assign dcdRAEqlwbLpAddr = (~|(dcdRAL2[0:4] ^ PCL_lwbLpAddr[0:4])) & IFB_dcdFullL2 & lwbFullL2;
assign dcdRAEqwbRpAddr  = (~|(dcdRAL2[0:4] ^ PCL_wbRpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;
assign dcdRBEqlwbLpAddr = (~|(dcdRBL2[0:4] ^ PCL_lwbLpAddr[0:4])) & IFB_dcdFullL2 & lwbFullL2;
assign dcdRBEqwbRpAddr  = (~|(dcdRBL2[0:4] ^ PCL_wbRpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;
assign dcdRSEqlwbLpAddr_i = (~|(dcdRSRTL2[0:4] ^ PCL_lwbLpAddr[0:4])) & IFB_dcdFullL2 & lwbFullL2;
assign dcdRSEqwbRpAddr  = (~|(dcdRSRTL2[0:4] ^ PCL_wbRpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;

assign exeRSEqlwbLpAddr_i = (~|(exeRS[0:4] ^ PCL_lwbLpAddr[0:4])) & exe1FullL2 & lwbFullL2;
assign exeRSEqwbRpAddr  = (~|(exeRS[0:4] ^ PCL_wbRpAddr[0:4])) & exe1FullL2 & wbFullL2;

// dcd Load Use Compares
// wbLport Equal dcd Aport, Bport, Sport Addr
assign dcdRAEqwbLpAddr = (~|(dcdRAL2[0:4] ^ wbLpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;
assign dcdRSEqwbLpAddr_i = (~|(dcdRSRTL2[0:4] ^ wbLpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;
assign dcdRBEqwbLpAddr = (~|(dcdRBL2[0:4] ^ wbLpAddr[0:4])) & IFB_dcdFullL2 & wbFullL2;

// Port depend Compares
assign dcdRAEqexeRpAddr  = (~|(dcdRAL2[0:4] ^ exeRpAddr[0:4])) & IFB_dcdFullL2 & (exe1FullL2 | exe2FullL2);
assign dcdRSEqexeRpAddr  = (~|(dcdRSRTL2[0:4] ^ exeRpAddr[0:4])) & IFB_dcdFullL2 & (exe1FullL2 | exe2FullL2);
assign dcdRBEqexeRpAddr  = (~|(dcdRBL2[0:4] ^ exeRpAddr[0:4])) & IFB_dcdFullL2 & (exe1FullL2 | exe2FullL2);

assign exeRpEqdcdSpAddr = (~|(exeRpAddr[0:4] ^ dcdRSRTL2[0:4])) & IFB_dcdFullL2 & (exe1FullL2 | exe2FullL2);

// Goto pipeCntl for dcdSregLoadUse.
//assign wbLpEqdcdSpAddr = (~|(wbLpAddr[0:4] ^ dcdRSRTL2[0:4])) & IFB_dcdFullL2 & wbFullL2;
//assign lwbLpEqdcdSpAddr = (~|(PCL_lwbLpAddr[0:4] ^ dcdRSRTL2[0:4])) & IFB_dcdFullL2 & lwbFullL2;
//issue154 fix.

assign exeRSEqwbLpAddr  = (~|(exeRS[0:4] ^ wbLpAddr[0:4]));
assign wbLpEqdcdSpAddr = ((dcdRSEqwbLpAddr_i & ~sPortSelInc) | (exeRSEqwbLpAddr & sPortSelInc));
assign lwbLpEqdcdSpAddr = ((dcdRSEqlwbLpAddr_i & ~sPortSelInc) | (exeRSEqlwbLpAddr_i & sPortSelInc));

//Mac depend Bubble
assign dcdRAEqexeMorMRpAddr  = (~|(dcdRAL2[0:4] ^ exeMacOrMultRpAddr[0:4])) & IFB_dcdFullL2 &
                                                            (PCL_exeMacEnL2 | PCL_exeMultEnL2);
assign dcdRSEqexeMorMRpAddr  = (~|(dcdRSRTL2[0:4] ^ exeMacOrMultRpAddr[0:4])) & IFB_dcdFullL2 &
                                                            (PCL_exeMacEnL2 | PCL_exeMultEnL2);
assign dcdRBEqexeMorMRpAddr  = (~|(dcdRBL2[0:4] ^ exeMacOrMultRpAddr[0:4])) & IFB_dcdFullL2 &
                                                            (PCL_exeMacEnL2 | PCL_exeMultEnL2);

// Back to back Mac result recirc depend compare
assign exeMorMRpEqexeRpAddr = (~|(exeRpAddr[0:4] ^ exeMacOrMultRpAddr[0:4])) & exe2FullL2 &
                                                          (PCL_exeMacEnL2 | PCL_exeMultEnL2);

// exe Load Use compares
assign lwbLpEqexeApAddr = (~|(PCL_lwbLpAddr[0:4] ^ exeApAddr[0:4])) & lwbFullL2 & exe1FullL2;
assign lwbLpEqexeBpAddr = (~|(PCL_lwbLpAddr[0:4] ^ exeBpAddr[0:4])) & lwbFullL2 & exe1FullL2;
assign lwbLpEqexeSpAddr = (~|(PCL_lwbLpAddr[0:4] ^ exeSpAddr[0:4])) & lwbFullL2 & exe1FullL2;
assign wbLpEqexeApAddr = (~|(wbLpAddr[0:4] ^ exeApAddr[0:4])) & wbFullL2 & exe1FullL2;
assign wbLpEqexeBpAddr = (~|(wbLpAddr[0:4] ^ exeBpAddr[0:4])) & wbFullL2 & exe1FullL2;
assign wbLpEqexeSpAddr = (~|(wbLpAddr[0:4] ^ exeSpAddr[0:4])) & wbFullL2 & exe1FullL2;

// invalid form block Lport Write Compare
assign exeRTeqRA = (~|(exeLpAddr[0:4] ^ exeApAddr[0:4])) & exe1FullL2;
assign exeRTeqRB = (~|(exeLpAddr[0:4] ^ exeBpAddr[0:4])) & exe1FullL2;

// Hold instruction in exe until Lp has updated the GPR
assign exeRpEqwbLpAddr = (~|(exeRpAddr[0:4] ^ wbLpAddr[0:4])) & wbFullL2 & exe1FullL2 & ~exe2FullL2;
assign exeRpEqlwbLpAddr = (~|(exeRpAddr[0:4] ^ PCL_lwbLpAddr[0:4])) & lwbFullL2 & exe1FullL2 & ~exe2FullL2;
assign exeMorMRpEqwbLpAddr = (~|(exeMacOrMultRpAddr[0:4] ^ wbLpAddr[0:4])) & wbFullL2 & (PCL_exeMacEnL2 | PCL_exeMultEnL2);
assign exeMorMRpEqlwbLpAddr = (~|(exeMacOrMultRpAddr[0:4] ^ PCL_lwbLpAddr[0:4])) & lwbFullL2 & (PCL_exeMacEnL2 | PCL_exeMultEnL2);

// Block the Lport Write for LSSD test. In functional its a invalid case.
assign gprLpeqRp = ~|(lwbLpAddr_NEG[0:4] ^ wbRpAddr_NEG[0:4]);

// Compare for GPR Sport bypass when BPEqSP,
// done to reduce loading on the GPR latch cell by 1/3X.

assign dcdRBEqdcdRSRT = ~|(dcdRBL2[0:4] ^ dcdRSRTL2[0:4]);
assign dcdRBEqexeRS   = ~|(dcdRBL2[0:4] ^ exeRS[0:4]);
assign dcdRAEqdcdRSRT = ~|(dcdRAL2[0:4] ^ dcdRSRTL2[0:4]);
assign dcdRAEqexeRS   = ~|(dcdRAL2[0:4] ^ exeRS[0:4]);

always @(dcdRBEqdcdRSRT or dcdRBEqexeRS or dcdRAEqdcdRSRT or dcdRAEqexeRS or
         dcdBpMuxSel or dcdSpMuxSel)
begin
   case({dcdBpMuxSel,dcdSpMuxSel})   // full_case parallel_case
   2'b00: PCL_BpEqSp = dcdRAEqdcdRSRT;
   2'b01: PCL_BpEqSp = dcdRAEqexeRS;
   2'b10: PCL_BpEqSp = dcdRBEqdcdRSRT;
   2'b11: PCL_BpEqSp = dcdRBEqexeRS;
   default: PCL_BpEqSp = 1'bx;
  endcase
end

endmodule
