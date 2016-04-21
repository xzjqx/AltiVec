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

module p405s_storage( PCL_addFour, PCL_apuExeWdCnt, PCL_dcuByteEn, PCL_dsOcmByteEn,
     PCL_exeEaQwEn, algnErr, blkExeSpAddr, byteCount, cntGtEq4, exeStrgSt,
     exeStrgStC0, sPortSelInc, strgEnd, strgLpWrEn, APU_dcdLdStByte, APU_dcdLdStDw,
     APU_dcdLdStHw, APU_dcdLdStQw, APU_dcdLdStWd, CB, EXE_ea, EXE_xerTBC,
     EXE_xerTBCIn, IFB_exeFlush, PCL_Rbit, countE1, countE2, dcdMultiple,
     dcdRBL2, dcdRSRTL2, dcdStringImmediate, dcdStringIndexed, exeAlg, exeApuFpuOp,
     exeByteRev, exeDcread, exeEaCalc, exeForceAlgn, exeLd, exeLwarx, exeMultiple, exeStore,
     exeString, exeStwcx, exeXerTBCUpdInstr, gtErr, nopStringIndexed, plaApuLdSt, plaLdStByte,
     plaLdStDw, plaLdStHw, plaLdStQw, plaLdStWd, plaVal, storageStMachE1, storageStMachE2 );
output  PCL_addFour, algnErr, blkExeSpAddr, cntGtEq4, exeStrgStC0, sPortSelInc, strgEnd,
     strgLpWrEn;


input  APU_dcdLdStByte, APU_dcdLdStDw, APU_dcdLdStHw, APU_dcdLdStQw, APU_dcdLdStWd,
     IFB_exeFlush, PCL_Rbit, countE1, countE2, dcdMultiple, dcdStringImmediate,
     dcdStringIndexed, exeAlg, exeApuFpuOp, exeByteRev, exeDcread, exeEaCalc, exeForceAlgn,
     exeLd, exeLwarx, exeMultiple, exeStore, exeString, exeStwcx, exeXerTBCUpdInstr, gtErr,
     nopStringIndexed, plaApuLdSt, plaLdStByte, plaLdStDw, plaLdStHw, plaLdStQw, plaLdStWd,
     plaVal, storageStMachE1, storageStMachE2;

output [0:3]  PCL_dsOcmByteEn;
output [6:7]  byteCount;
output [0:2]  exeStrgSt;
output [0:3]  PCL_dcuByteEn;
output [0:1]  PCL_apuExeWdCnt;
output [0:3]  PCL_exeEaQwEn;


input        CB;
input [30:31]  EXE_ea;
input [0:4]  dcdRBL2;
input [0:6]  EXE_xerTBC;
input [0:4]  dcdRSRTL2;
input [0:6]  EXE_xerTBCIn;

// Buses in the design

wire  [0:7]  symNet224;

wire  [0:1]  countRegMuxSel;

wire  [0:1]  cntMuxSel;

wire  [0:2]  exeStrgSt_1;

reg  [0:6]  exeStrgStL2_NEG_i;
wire  [0:6]  exeStrgStL2_NEG;

wire  [0:3]  decBy;

wire  [0:5]  multCnt;

reg  [0:7]  cntMuxOut;

wire  [0:1]  exeWdCnt_NEG;

wire  [0:8]  storageCount_NEG;

reg  [0:8]  storageCountL2;

wire  [0:2]  nxtStrgSt;

wire gtLS;
wire gtLS_NEG;
wire maskInc;

wire [0:3] PCL_dcuByteEn_i;
wire [0:7]  byteCount_i;

wire stringImmdEq32;
wire xerTbcInGtEq4;
wire cntMuxOutGtEq4;
wire apuLdStGtEq4;
wire [0:2] exeStrgSt_i;
wire strgEnd_i;
wire exeStrgStC0_i;
wire cntGtEq4_i;
wire xerTbcGtEq4;

assign cntGtEq4 = cntGtEq4_i;
assign exeStrgStC0 = exeStrgStC0_i;
assign strgEnd = strgEnd_i;

assign exeStrgSt = exeStrgSt_i;

assign byteCount = byteCount_i[6:7];
assign PCL_dcuByteEn = PCL_dcuByteEn_i;

//Removed the module dp_logPCL_exeWdCntInv
assign PCL_apuExeWdCnt = ~exeWdCnt_NEG;

   // Replacing instantiation: GTECH_OA21 I167
   assign exeWdCnt_NEG[0] = (storageCount_NEG[5] | storageCount_NEG[4]) & storageCount_NEG[3];

   // Replacing instantiation: GTECH_OA21 I168
   assign exeWdCnt_NEG[1] = (storageCountL2[5] | storageCount_NEG[4]) & storageCount_NEG[3];

//Removed the module dp_logPCL_storageCountInv2 
assign {byteCount_i, cntGtEq4_i} = ~storageCount_NEG;

//Removed the module dp_logPCL_storageCountInv1
assign storageCount_NEG = ~storageCountL2;

   // Replacing instantiation: GTECH_NOR3 I159
   wire nxtStrgStC0;
   assign nxtStrgStC0 = ~( nxtStrgSt[0] | nxtStrgSt[1] | nxtStrgSt[2] );

//Removed the module dp_logPCL_storageStMachINV 
assign {exeStrgSt_i, exeStrgSt_1, exeStrgStC0_i} = ~exeStrgStL2_NEG;

//Removed the module dp_logPCL_dsOcmByteEn 
assign PCL_dsOcmByteEn = PCL_dcuByteEn_i;

   // Replacing instantiation: GTECH_NOT I102
   assign gtLS_NEG = ~(gtLS);

   // Replacing instantiation: GTECH_AND2 I101
   assign maskInc = gtLS_NEG & decBy[3];

p405s_storageCountCntl
 strgCountCntl(.apuLdStGtEq4(apuLdStGtEq4), 
                                           .cntMuxOutGtEq4(cntMuxOutGtEq4), 
                                           .xerTbcGtEq4(xerTbcGtEq4), 
                                           .xerTbcInGtEq4(xerTbcInGtEq4),
                                           .multCnt(multCnt), 
                                           .stringImmdEq32(stringImmdEq32), 
                                           .cntMuxSel(cntMuxSel), 
                                           .countRegMuxSel(countRegMuxSel), 
                                           .dcdMultiple(dcdMultiple),
                                           .dcdNB(dcdRBL2), 
                                           .dcdRSRT(dcdRSRTL2), 
                                           .dcdStringImmediate(dcdStringImmediate), 
                                           .dcdStringIndexed(dcdStringIndexed), 
                                           .exeXerTBCUpdInstr(exeXerTBCUpdInstr),
                                           .strgEnd(strgEnd_i), 
                                           .APU_dcdLdStWd(APU_dcdLdStWd), 
                                           .APU_dcdLdStDw(APU_dcdLdStDw), 
                                           .cntMuxOut(cntMuxOut[0:5]), 
                                           .EXE_xerTBC(EXE_xerTBC[0:4]), 
                                           .EXE_xerTBCIn(EXE_xerTBCIn[0:4]),
                                           .plaVal(plaVal), 
                                           .APU_dcdLdStQw(APU_dcdLdStQw), 
                                           .plaApuLdSt(plaApuLdSt), 
                                           .exeForceAlgn(exeForceAlgn), 
                                           .byteCount(byteCount_i), 
                                           .exeStrgStC0(exeStrgStC0_i),
                                           .PCL_exeEaQwEn(PCL_exeEaQwEn));
     
p405s_storageStMachPla
 strgStMachPla(.nxtExeStrgSt(nxtStrgSt), 
                                     .PCL_addFour(PCL_addFour), 
                                     .IFB_exeFlush(IFB_exeFlush), 
                                     .exeStrgSt(exeStrgSt_i),
                                     .gtErr(gtErr), 
                                     .strgEnd(strgEnd_i), 
                                     .gtLS(gtLS), 
                                     .exeEaCalc(exeEaCalc));
     
//Removed the module dp_regPCL_storageStMach
always @(posedge CB)
  begin: dp_regPCL_storageStMach_PROC
    if (storageStMachE1 & storageStMachE2)
      exeStrgStL2_NEG_i <= {nxtStrgSt, nxtStrgSt, nxtStrgStC0};
  end // dp_regPCL_storageStMach_PROC

assign exeStrgStL2_NEG = ~exeStrgStL2_NEG_i;

p405s_storageCntlPla
 strgCntlPla(.PCL_dcuByteEn(PCL_dcuByteEn_i), 
                                       .decBy(decBy), 
                                       .strgLpWrEn(strgLpWrEn), 
                                       .gotoLS(gtLS), 
                                       .storageEnd(strgEnd_i),
                                       .sPortSelInc(sPortSelInc), 
                                       .blkExeSpAddr(blkExeSpAddr), 
                                       .algnErr(algnErr), 
                                       .exeApuFpuOp(exeApuFpuOp), 
                                       .ea(EXE_ea),
                                       .byteCount(byteCount_i), 
                                       .cntGtEq4(cntGtEq4_i),
                                       .exeStorageSt(exeStrgSt_1), 
                                       .exeLd(exeLd), 
                                       .exeSt(exeStore), 
                                       .exeString(exeString), 
                                       .exeMultiple(exeMultiple), 
                                       .exeByteRev(exeByteRev), 
                                       .exeAlg(exeAlg),
                                       .nopStringIndexed(nopStringIndexed), 
                                       .exeLwarx(exeLwarx), 
                                       .exeStwcx(exeStwcx), 
                                       .exeDcread(exeDcread), 
                                       .exeEaCalc(exeEaCalc), 
                                       .PCL_Rbit(PCL_Rbit));

//Removed the module storage_dec
assign symNet224 = byteCount_i - {5'b0, maskInc, (decBy[1] | decBy[2]), (decBy[0] | decBy[2])};

//Removed the module dp_muxPCL_storageCount 
always @(cntMuxSel or plaLdStQw or plaLdStDw or plaLdStWd or 
         plaLdStHw or plaLdStByte or multCnt or stringImmdEq32 or
         dcdRBL2 or symNet224)
  begin: dp_muxPCL_storageCount_PROC
    case (cntMuxSel)
      2'b00: cntMuxOut = {3'b000, plaLdStQw, plaLdStDw, plaLdStWd, plaLdStHw, plaLdStByte};    
      2'b01: cntMuxOut = {multCnt[0:5], 1'b0, 1'b0};    
      2'b10: cntMuxOut = {1'b0, 1'b0, stringImmdEq32, dcdRBL2[0:4]};    
      2'b11: cntMuxOut = symNet224;    
      default: cntMuxOut = 8'bx;   
    endcase
  end // dp_muxPCL_storageCount_PROC

//Removed the module dp_regPCL_storageCount 
always @(posedge CB)
  begin: dp_regPCL_storageCount_PROC
    if (countE1 & countE2)
      case (countRegMuxSel)
        2'b00: storageCountL2 <= {cntMuxOut, cntMuxOutGtEq4};    
        2'b01: storageCountL2 <= {1'b0, EXE_xerTBC, xerTbcGtEq4};    
        2'b10: storageCountL2 <= {1'b0, EXE_xerTBCIn, xerTbcInGtEq4};    
        2'b11: storageCountL2 <= {1'b0, 1'b0, 1'b0, APU_dcdLdStQw,
                                  APU_dcdLdStDw, APU_dcdLdStWd, APU_dcdLdStHw, 
                                  APU_dcdLdStByte, apuLdStGtEq4};    
        default: storageCountL2 <= 9'bx;   
      endcase
  end // dp_regPCL_storageCount_PROC

endmodule
