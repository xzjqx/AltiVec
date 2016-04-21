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
// JBB       10/22/02     2297        (1) Created new output PCL_gprRdClk.
//                                    (2) Modified the instantiation of clkChop.v.
// 
// JBB       11/08/02     2299        Removed CB[4] input to clkChop.v.
//                                    
//----------------------------------------------------------------------------//

module p405s_fileAddrGen( PCL_LpEqAp, PCL_LpEqBp, PCL_LpEqSp, PCL_RpEqAp, PCL_RpEqBp, PCL_RpEqSp,
     PCL_dcdApAddr, PCL_dcdBpAddr, PCL_dcdSpAddr, PCL_lwbLpAddr,
     PCL_wbRpAddr, exeApAddrL2, exeMorMRpEqdcdApAddr, exeMorMRpEqdcdBpAddr,
     exeMorMRpEqexeRpAddr, exeMorMRpEqlwbLpAddr, exeMorMRpEqwbLpAddr, exeRTeqRA, exeRTeqRB,
     exeRpEqdcdApAddr, exeRpEqdcdBpAddr, exeRpEqdcdSpAddr, exeRpEqlwbLpAddr, exeRpEqwbLpAddr,
     gprLpeqRp, lwbLpEqdcdSpAddr, lwbLpEqexeApAddr, lwbLpEqexeBpAddr, lwbLpEqexeSpAddr,
     wbLpEqdcdApAddr, wbLpEqdcdBpAddr, wbLpEqdcdSpAddr, wbLpEqexeApAddr, wbLpEqexeBpAddr,
     wbLpEqexeSpAddr, APU_dcdUpdate, CB, DRCC, ERC, IFB_dcdFullL2, LSSD_coreTestEn,
     PCL_exeMacEnL2, PCL_exeMultEnL2, c2Clk, dcdPriOpL2, dcdRAL2, dcdRBL2,
     dcdRSRTL2, dcdSecOpL2, exe1FullL2, exe2FullL2, exeE1, exeE2, exeLpAddrE2,
     exeLpMuxSel, exeMacOrMultRpAddrE2, exeRpAddrE2, exeRpAddrMuxSel, exeSpAddrE2, exeStore,
     gtErr, lwbE1, lwbFullL2, plaRpMuxSel, sPortSelInc, storeRSE1, storeRSE2, wbE1, wbFullL2,
// Defect 2297
//   wbLpAddrE1, wbRAL2[0:4], wbRpAddrE2, TIE_c405BypassE1E2, PCL_BpEqSp);
     wbLpAddrE1, wbRAL2, wbRpAddrE2, PCL_BpEqSp, PCL_gprRdClk);
output  PCL_LpEqAp, PCL_LpEqBp, PCL_LpEqSp, PCL_RpEqAp, PCL_RpEqBp, PCL_RpEqSp, 
     exeMorMRpEqdcdApAddr, exeMorMRpEqdcdBpAddr, exeMorMRpEqexeRpAddr, exeMorMRpEqlwbLpAddr,
     exeMorMRpEqwbLpAddr, exeRTeqRA, exeRTeqRB, exeRpEqdcdApAddr, exeRpEqdcdBpAddr,
     exeRpEqdcdSpAddr, exeRpEqlwbLpAddr, exeRpEqwbLpAddr, gprLpeqRp, lwbLpEqdcdSpAddr,
     lwbLpEqexeApAddr, lwbLpEqexeBpAddr, lwbLpEqexeSpAddr, wbLpEqdcdApAddr, wbLpEqdcdBpAddr,
// Defect 2297
//   wbLpEqdcdSpAddr, wbLpEqexeApAddr, wbLpEqexeBpAddr, wbLpEqexeSpAddr, PCL_BpEqSp;
     wbLpEqdcdSpAddr, wbLpEqexeApAddr, wbLpEqexeBpAddr, wbLpEqexeSpAddr, PCL_BpEqSp,
     PCL_gprRdClk;

input  APU_dcdUpdate, DRCC, ERC, IFB_dcdFullL2, LSSD_coreTestEn, PCL_exeMacEnL2,
     PCL_exeMultEnL2, c2Clk, exe1FullL2, exe2FullL2, exeE1, exeE2, exeLpAddrE2,
     exeLpMuxSel, exeMacOrMultRpAddrE2, exeRpAddrE2, exeRpAddrMuxSel, exeSpAddrE2, exeStore,
     gtErr, lwbE1, lwbFullL2, plaRpMuxSel, sPortSelInc, storeRSE1, storeRSE2, wbE1, wbFullL2,
     wbLpAddrE1, wbRpAddrE2;

output [0:4]  PCL_wbRpAddr;
output [0:9]  PCL_dcdSpAddr;
output [0:4]  exeApAddrL2;
output [0:9]  PCL_dcdApAddr;
output [0:9]  PCL_dcdBpAddr;
output [0:4]  PCL_lwbLpAddr;


input        CB;
input [21:31]  dcdSecOpL2;
input [0:4]  wbRAL2;
input [0:4]  dcdRBL2;
input [0:4]  dcdRSRTL2;
input [0:4]  dcdRAL2;
input [0:5]  dcdPriOpL2;

// Buses in the design

reg  [0:4]  exeLpAddr;

reg  [0:4]  exeRpAddr;

wire  [0:4]  exeLpAddrInc;

reg  [0:4]  exeBpAddrL2;

wire  [0:4]  dcdRpAddr;

wire  [0:9]  preDcdRB;

reg  [0:4]  exeMacOrMultRpAddr;

reg  [0:4]  exeSpAddr;

reg  [0:4]  exeRS;

reg  [0:4]  wbRpAddrL2;

wire  [0:4]  exeMOrMRpAddrForLSSD;

wire  [0:4]  wbRpAddr_NEG;

reg  [0:4]  wbLpAddr;

wire  [0:4]  dcdSpAddr;

wire  [0:4]  symNet843;

wire  [0:9]  preDcdRSRT;

wire  [0:4]  dcdBpAddr;

wire  [0:9]  preExeRS;

reg  [0:4]  lwbLpAddrL2;

wire  [0:9]  preDcdRA;

wire  [0:4]  lwbLpAddr_NEG;

wire  [0:4]  dcdApAddr;

reg [0:4]  exeApAddrL2_i;
wire dcdApMuxSel_NEG;
wire dcdBpMuxSel_NEG;
wire dcdSpAddrEn;
wire dcdSpMuxSel;
wire dcdBpMuxSel;
wire exeRSEqwbRpAddr;
wire exeRSEqlwbLpAddr;
wire dcdRSEqexeMorMRpAddr;
wire dcdRBEqexeMorMRpAddr;
wire dcdRAEqexeMorMRpAddr;
wire dcdRSEqexeRpAddr;
wire dcdRSEqwbRpAddr;
wire dcdRSEqwbLpAddr;
wire rdEn;
wire [0:4] PCL_lwbLpAddr_i;
wire [0:9] PCL_dcdBpAddr_i;
wire [0:9] PCL_dcdApAddr_i;
wire [0:4] PCL_wbRpAddr_i;
wire dcdRSEqlwbLpAddr;
wire dcdRAEqexeRpAddr;
wire dcdRAEqlwbLpAddr;
wire dcdRAEqwbLpAddr;
wire dcdRAEqwbRpAddr;
wire dcdRBEqexeRpAddr;
wire dcdRBEqlwbLpAddr;
wire dcdRBEqwbLpAddr;
wire dcdRBEqwbRpAddr;


assign PCL_wbRpAddr = PCL_wbRpAddr_i;
assign PCL_dcdApAddr = PCL_dcdApAddr_i;
assign PCL_dcdBpAddr = PCL_dcdBpAddr_i;
assign PCL_lwbLpAddr = PCL_lwbLpAddr_i;

assign exeApAddrL2 = exeApAddrL2_i;

//Removed the module dp_logPCL_flipForLssdXOR2 
assign exeMOrMRpAddrForLSSD = exeMacOrMultRpAddr ^ {5{LSSD_coreTestEn}};

//Removed the module dp_logPCL_wbRpAddrInv2 
assign PCL_wbRpAddr_i = ~wbRpAddr_NEG;

//Removed the module dp_logPCL_wbRpAddrInv1 
assign wbRpAddr_NEG = ~wbRpAddrL2;

//Removed the module dp_logPCL_lwbLpAddrInv2 
assign PCL_lwbLpAddr_i = ~lwbLpAddr_NEG;

//Removed the module dp_logPCL_lwbLpAddrInv1 
assign lwbLpAddr_NEG = ~lwbLpAddrL2;

p405s_sPortMux
 spMux( .PCL_LpEqSp(PCL_LpEqSp), 
                            .PCL_RpEqSp(PCL_RpEqSp), 
                            .PCL_dcdSpAddr(PCL_dcdSpAddr), 
                            .dcdSpAddr(dcdSpAddr), 
                            .dcdRSEqlwbLpAddr(dcdRSEqlwbLpAddr),
                            .dcdRSEqwbRpAddr(dcdRSEqwbRpAddr), 
                            .dcdRSRTL2(dcdRSRTL2), 
                            .dcdSpAddrEn(dcdSpAddrEn), 
                            .exeRS(exeRS), 
                            .exeRSEqlwbLpAddr(exeRSEqlwbLpAddr),
                            .exeRSEqwbRpAddr(exeRSEqwbRpAddr), 
                            .preDcdRSRT(preDcdRSRT), 
                            .preExeRS(preExeRS), 
                            .rdEn(rdEn), 
                            .sPortSelInc(sPortSelInc), 
                            .dcdSpMuxSel(dcdSpMuxSel));
p405s_bPortMux
 bpMux( .PCL_LpEqBp(PCL_LpEqBp), 
                            .PCL_RpEqBp(PCL_RpEqBp), 
                            .PCL_dcdBpAddr(PCL_dcdBpAddr_i), 
                            .exeMorMRpEqdcdBpAddr(exeMorMRpEqdcdBpAddr),
                            .exeRpEqdcdBpAddr(exeRpEqdcdBpAddr), 
                            .wbLpEqdcdBpAddr(wbLpEqdcdBpAddr), 
                            .dcdBpMuxSel_NEG(dcdBpMuxSel_NEG), 
                            .dcdRAEqexeMorMRpAddr(dcdRAEqexeMorMRpAddr),
                            .dcdRAEqexeRpAddr(dcdRAEqexeRpAddr), 
                            .dcdRAEqlwbLpAddr(dcdRAEqlwbLpAddr), 
                            .dcdRAEqwbLpAddr(dcdRAEqwbLpAddr), 
                            .dcdRAEqwbRpAddr(dcdRAEqwbRpAddr),
                            .dcdRBEqexeMorMRpAddr(dcdRBEqexeMorMRpAddr), 
                            .dcdRBEqexeRpAddr(dcdRBEqexeRpAddr), 
                            .dcdRBEqlwbLpAddr(dcdRBEqlwbLpAddr), 
                            .dcdRBEqwbLpAddr(dcdRBEqwbLpAddr),
                            .dcdRBEqwbRpAddr(dcdRBEqwbRpAddr), 
                            .preDcdRA(preDcdRA), 
                            .preDcdRB(preDcdRB), 
                            .rdEn(rdEn), 
                            .dcdBpMuxSel(dcdBpMuxSel));
p405s_aPortMux
 apMux( .PCL_LpEqAp(PCL_LpEqAp), 
                            .PCL_RpEqAp(PCL_RpEqAp), 
                            .PCL_dcdApAddr(PCL_dcdApAddr_i), 
                            .exeMorMRpEqdcdApAddr(exeMorMRpEqdcdApAddr),
                            .exeRpEqdcdApAddr(exeRpEqdcdApAddr), 
                            .wbLpEqdcdApAddr(wbLpEqdcdApAddr), 
                            .dcdApMuxSel_NEG(dcdApMuxSel_NEG), 
                            .dcdRAEqexeMorMRpAddr(dcdRAEqexeMorMRpAddr),
                            .dcdRAEqexeRpAddr(dcdRAEqexeRpAddr), 
                            .dcdRAEqlwbLpAddr(dcdRAEqlwbLpAddr), 
                            .dcdRAEqwbLpAddr(dcdRAEqwbLpAddr), 
                            .dcdRAEqwbRpAddr(dcdRAEqwbRpAddr),
                            .dcdRSEqexeMorMRpAddr(dcdRSEqexeMorMRpAddr), 
                            .dcdRSEqexeRpAddr(dcdRSEqexeRpAddr), 
                            .dcdRSEqlwbLpAddr(dcdRSEqlwbLpAddr), 
                            .dcdRSEqwbLpAddr(dcdRSEqwbLpAddr),
                            .dcdRSEqwbRpAddr(dcdRSEqwbRpAddr), 
                            .preDcdRA(preDcdRA), 
                            .preDcdRSRT(preDcdRSRT), 
                            .rdEn(rdEn));
                            
p405s_gprAddrPreDcd
 preDcdRAFunc( .OUT1(preDcdRA), .IN1(dcdRAL2));
p405s_gprAddrPreDcd
 preDcdRBFunc( .OUT1(preDcdRB), .IN1(dcdRBL2));
p405s_gprAddrPreDcd
 preDcdRSRTFunc( .OUT1(preDcdRSRT), .IN1(dcdRSRTL2));
p405s_gprAddrPreDcd
 preExeRSFunc( .OUT1(preExeRS), .IN1(exeRS));

p405s_clkChop
 clkChopFunc
                   (.CB              (CB), 
		    .rdEn            (rdEn), 
		    .DRCC            (DRCC), 
		    .ERC             (ERC), 
		    .IFB_dcdFullL2   (IFB_dcdFullL2), 
		    .LSSD_coreTestEn (LSSD_coreTestEn), 
		    .c2Clk           (c2Clk), 
		    .exeStore        (exeStore), 
		    .PCL_gprRdClk    (PCL_gprRdClk));
		    
//Removed the module dp_regPCL_exeMacOrMultRpAddr
always @(posedge CB)
  begin: dp_regPCL_exeMacOrMultRpAddr_PROC
    if (IFB_dcdFullL2 & exeMacOrMultRpAddrE2)
      exeMacOrMultRpAddr <= dcdRpAddr;
  end // dp_regPCL_exeMacOrMultRpAddr_PROC

   // Replacing instantiation: GTECH_BUF I330
   assign dcdBpAddr[0] = PCL_dcdBpAddr_i[1];

   // Replacing instantiation: GTECH_BUF I319
   assign dcdApAddr[0] = PCL_dcdApAddr_i[1];

   // Replacing instantiation: GTECH_OR2 I331
   assign dcdBpAddr[1] = PCL_dcdBpAddr_i[4] | PCL_dcdBpAddr_i[5];

   // Replacing instantiation: GTECH_OR2 I332
   assign dcdBpAddr[2] = PCL_dcdBpAddr_i[3] | PCL_dcdBpAddr_i[5];

   // Replacing instantiation: GTECH_OR2 I333
   assign dcdBpAddr[3] = PCL_dcdBpAddr_i[8] | PCL_dcdBpAddr_i[9];

   // Replacing instantiation: GTECH_OR2 I334
   assign dcdBpAddr[4] = PCL_dcdBpAddr_i[7] | PCL_dcdBpAddr_i[9];

   // Replacing instantiation: GTECH_OR2 I315
   assign dcdApAddr[1] = PCL_dcdApAddr_i[4] | PCL_dcdApAddr_i[5];

   // Replacing instantiation: GTECH_OR2 I316
   assign dcdApAddr[2] = PCL_dcdApAddr_i[3] | PCL_dcdApAddr_i[5];

   // Replacing instantiation: GTECH_OR2 I317
   assign dcdApAddr[3] = PCL_dcdApAddr_i[8] | PCL_dcdApAddr_i[9];

   // Replacing instantiation: GTECH_OR2 I318
   assign dcdApAddr[4] = PCL_dcdApAddr_i[7] | PCL_dcdApAddr_i[9];

//Removed the module dp_regPCL_exeSPortAddr
always @(posedge CB)
  begin: dp_regPCL_exeSPortAddr_PROC
    if (exeE1 & exeSpAddrE2)
      exeSpAddr <= dcdSpAddr;
  end // dp_regPCL_exeSPortAddr_PROC

//Removed the module dp_regPCL_exeABPortAddr
always @(posedge CB)
  begin: dp_regPCL_exeABPortAddr_PROC
    if (exeE1 & exeE2)
      {exeApAddrL2_i, exeBpAddrL2} <= {dcdApAddr, dcdBpAddr};
  end // dp_regPCL_exeABPortAddr_PROC

p405s_fileAddrCntl
 fileAddrCntlFunc(.dcdRAEqlwbLpAddr(dcdRAEqlwbLpAddr), 
                                          .dcdRAEqwbLpAddr(dcdRAEqwbLpAddr), 
                                          .dcdRAEqwbRpAddr(dcdRAEqwbRpAddr),
                                          .dcdRAEqexeRpAddr(dcdRAEqexeRpAddr), 
                                          .dcdRBEqlwbLpAddr(dcdRBEqlwbLpAddr), 
                                          .dcdRBEqwbLpAddr(dcdRBEqwbLpAddr), 
                                          .dcdRBEqwbRpAddr(dcdRBEqwbRpAddr), 
                                          .dcdRBEqexeRpAddr(dcdRBEqexeRpAddr),
                                          .dcdRSEqlwbLpAddr(dcdRSEqlwbLpAddr), 
                                          .dcdRSEqwbLpAddr(dcdRSEqwbLpAddr), 
                                          .dcdRSEqwbRpAddr(dcdRSEqwbRpAddr), 
                                          .dcdRSEqexeRpAddr(dcdRSEqexeRpAddr),
                                          .dcdRAEqexeMorMRpAddr(dcdRAEqexeMorMRpAddr), 
                                          .dcdRBEqexeMorMRpAddr(dcdRBEqexeMorMRpAddr), 
                                          .dcdRSEqexeMorMRpAddr(dcdRSEqexeMorMRpAddr), 
                                          .exeRSEqlwbLpAddr(exeRSEqlwbLpAddr),
                                          .exeRSEqwbRpAddr(exeRSEqwbRpAddr), 
                                          .exeRpEqdcdSpAddr(exeRpEqdcdSpAddr), 
                                          .exeRpEqwbLpAddr(exeRpEqwbLpAddr), 
                                          .exeRpEqlwbLpAddr(exeRpEqlwbLpAddr), 
                                          .lwbLpEqexeApAddr(lwbLpEqexeApAddr),
                                          .lwbLpEqexeBpAddr(lwbLpEqexeBpAddr), 
                                          .lwbLpEqexeSpAddr(lwbLpEqexeSpAddr), 
                                          .wbLpEqexeApAddr(wbLpEqexeApAddr), 
                                          .wbLpEqexeBpAddr(wbLpEqexeBpAddr), 
                                          .wbLpEqexeSpAddr(wbLpEqexeSpAddr),
                                          .exeMorMRpEqexeRpAddr(exeMorMRpEqexeRpAddr), 
                                          .exeRTeqRA(exeRTeqRA), 
                                          .exeRTeqRB(exeRTeqRB), 
                                          .gprLpeqRp(gprLpeqRp), 
                                          .dcdRAL2(dcdRAL2), 
                                          .dcdRBL2(dcdRBL2),
                                          .dcdRSRTL2(dcdRSRTL2), 
                                          .exeRS(exeRS), 
                                          .exeApAddr(exeApAddrL2_i), 
                                          .exeBpAddr(exeBpAddrL2), 
                                          .exeSpAddr(exeSpAddr),
                                          .exeLpAddr(exeLpAddr), 
                                          .exeRpAddr(exeRpAddr), 
                                          .exeMacOrMultRpAddr(exeMacOrMultRpAddr), 
                                          .wbLpAddr(wbLpAddr), 
                                          .PCL_wbRpAddr(PCL_wbRpAddr_i),
                                          .PCL_lwbLpAddr(PCL_lwbLpAddr_i), 
                                          .IFB_dcdFullL2(IFB_dcdFullL2), 
                                          .exe1FullL2(exe1FullL2), 
                                          .exe2FullL2(exe2FullL2), 
                                          .wbFullL2(wbFullL2), 
                                          .lwbFullL2(lwbFullL2),
                                          .PCL_exeMacEnL2(PCL_exeMacEnL2), 
                                          .PCL_exeMultEnL2(PCL_exeMultEnL2), 
                                          .wbLpEqdcdSpAddr(wbLpEqdcdSpAddr), 
                                          .lwbLpEqdcdSpAddr(lwbLpEqdcdSpAddr), 
                                          .exeMorMRpEqwbLpAddr(exeMorMRpEqwbLpAddr),
                                          .exeMorMRpEqlwbLpAddr(exeMorMRpEqlwbLpAddr), 
                                          .lwbLpAddr_NEG(lwbLpAddr_NEG), 
                                          .wbRpAddr_NEG(wbRpAddr_NEG), 
                                          .sPortSelInc(sPortSelInc), 
                                          .dcdBpMuxSel(dcdBpMuxSel), 
                                          .dcdSpMuxSel(dcdSpMuxSel), 
                                          .PCL_BpEqSp(PCL_BpEqSp));

//Removed the module dp_regPCL_lwbLpAddr
always @(posedge CB)
  begin: dp_regPCL_lwbLpAddr_PROC
    if (lwbE1)
      lwbLpAddrL2 <= wbLpAddr;
  end // dp_regPCL_lwbLpAddr_PROC

//Removed the module dp_regPCL_wbLpAddr
always @(posedge CB)
  begin: dp_regPCL_wbLpAddr_PROC
    if (wbLpAddrE1)
      wbLpAddr <= exeLpAddr;
  end // dp_regPCL_wbLpAddr_PROC

//Removed the module loadIncRT 
assign exeLpAddrInc = exeLpAddr + 1;

//Removed the module dp_regPCL_exeLpAddr 
always @(posedge CB)
  begin: dp_regPCL_exeLpAddr_PROC
    if (exeE1 & exeLpAddrE2)
      begin
        if (exeLpMuxSel)
          exeLpAddr <= exeLpAddrInc;
        else
          exeLpAddr <= dcdRSRTL2;
      end
  end // dp_regPCL_exeLpAddr_PROC

//Removed the module dp_regPCL_wbRpAddr
always @(posedge CB)
  begin: dp_regPCL_wbRpAddr_PROC
    if (wbE1 & wbRpAddrE2)
      begin
        if (gtErr)
          wbRpAddrL2 <= wbRAL2;
        else
          wbRpAddrL2 <= exeRpAddr;
      end
  end // dp_regPCL_wbRpAddr_PROC
     
//Removed the module dp_regPCL_exeRpAddr
always @(posedge CB)
  begin: dp_regPCL_exeRpAddr_PROC
    if (exeE1 & exeRpAddrE2)
      begin
        case ({exeRpAddrMuxSel, APU_dcdUpdate})
          2'b00 : exeRpAddr <= dcdRpAddr;
          2'b01 : exeRpAddr <= dcdRAL2;
          2'b10 : exeRpAddr <= exeMacOrMultRpAddr;
          2'b11 : exeRpAddr <= exeMOrMRpAddrForLSSD;
          default : exeRpAddr <= 5'bxxxxx;
        endcase
      end
  end // dp_regPCL_exeRpAddr_PROC
    
//Removed the module dp_muxPCL_rPortAddr 
assign dcdRpAddr = plaRpMuxSel ?  dcdRAL2 : dcdRSRTL2;

//Removed the module storeIncRS 
assign symNet843 = dcdSpAddr + 1;

//Removed the module dp_regPCL_storeRS
always @(posedge CB)
  begin: dp_regPCL_storeRS_PROC
    if (storeRSE1 & storeRSE2)
      exeRS <= symNet843;
  end // dp_regPCL_storeRS_PROC
  
p405s_sPortPla
 spPla(.dcdSpAddrEn(dcdSpAddrEn),
                           .priOp(dcdPriOpL2), 
                           .secOp(dcdSecOpL2));
p405s_bPortPla
 bpPla(.dcdBpMuxSel(dcdBpMuxSel_NEG), 
                           .priOp(dcdPriOpL2), 
                           .secOp(dcdSecOpL2));
p405s_aPortPla
 apPla(.dcdApMuxSel(dcdApMuxSel_NEG), 
                           .priOp(dcdPriOpL2), 
                           .secOp(dcdSecOpL2));

endmodule
