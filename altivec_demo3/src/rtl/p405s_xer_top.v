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
module p405s_xer_top (EXE_cc, EXE_xer, EXE_xerTBC, EXE_xerTBCNotEqZero,
           nxtXerCa, rRegBypassMuxSel, APU_exeCa,
           APU_exeOv, CB, PCL_exeLogicalUnitEnForLSSD, APU_exeCr,
           PCL_exeMcrxr, PCL_exeMtspr, PCL_exeSprUnitEn_NEG, PCL_exeSrmUnitEnForLSSD,
           PCL_exeXerCaEn, PCL_exeXerOvEn, PCL_xerL2Hold, addCA, addOV,
           addUnitEn, admCcBits, resetL2, divOV, dlmzb, logicalCcBits,
           lsaOut, multOV, sprBusIn, srmCA, xerDcd, EXE_xerTBCIn,
           srmCcBits, PCL_exe2XerOvEn, exeResultMuxSel, PCL_exeEaCalc,
           divNxtToLastSt, macOV, multHiEOAnsCc, multLo4CycAnsCc, multLo5CycAnsCc,
           admCcMuxSel, IFB_exeOpForExe2L2, PCL_exeFpuOp, PCL_exeApuValidOp);
    output [0:3] EXE_cc;
    output [0:2] EXE_xer;
    output [0:6] EXE_xerTBC;
    output [0:6] EXE_xerTBCIn;
    output EXE_xerTBCNotEqZero;
    output nxtXerCa;
    output [0:1] rRegBypassMuxSel;
    output [0:1] exeResultMuxSel;
    input APU_exeCa;
    input APU_exeOv;
    input [0:3] APU_exeCr;
    //input [0:4] CB;
    input CB;
    input PCL_exeLogicalUnitEnForLSSD;
    input PCL_exeMcrxr;
    input PCL_exeMtspr;
    input PCL_exeSprUnitEn_NEG;
    input PCL_exeSrmUnitEnForLSSD;
    input PCL_exeXerCaEn;
    input PCL_exeXerOvEn;
    input PCL_xerL2Hold;
    input addCA;
    input addOV;
    input addUnitEn;
    input [0:2] admCcBits;
    input resetL2;
    input divOV;
    input dlmzb;
    input [0:2] logicalCcBits;
    input [28:31] lsaOut;
    input multOV;
    input [0:31] sprBusIn;
    input srmCA;
    input xerDcd;
    input [0:2] srmCcBits;
    input PCL_exe2XerOvEn;
    input PCL_exeEaCalc;
    input divNxtToLastSt;
    input macOV;
    input [0:1] admCcMuxSel;
    input [0:2] multLo5CycAnsCc;
    input [0:2] multLo4CycAnsCc;
    input [0:2] multHiEOAnsCc;
    input IFB_exeOpForExe2L2;
    input PCL_exeFpuOp;
    input PCL_exeApuValidOp;

// Changes:
// 01/27/99 SBP Changed nxrXerOVIn equation. See pass1 issue 363 for details.
//

wire  nxtXerOv, mtXer, mtOrReset, xerE1, xerE2, xerSOIn, xerOVIn;
wire xerTBCNotEqZeroIn, exeResultSel;
wire [0:1] crMuxSel;
//wire [0:2] exeUnitCc;
//wire [0:3] exeCc;
reg [0:6] xerTBCIn;
//reg [0:2] EXE_xer;
//reg [0:6] EXE_xerTBC;
//reg EXE_xerTBCNotEqZero;
reg [0:2] exeUnitCc;
reg [0:2] EXE_cc_muxout;

// The xer should be updated with overflow detection by:
// 1) an internal div with PCL_exeXerOvEn,
// 2) an add unit overflow,
// 3) an apu overflow.

// The xer should be loaded with carry info by:
// 1) an add unit carry bit,
// 2) an SRM carry bit,
// 3) an apu carry bit.

assign mtXer = PCL_exeMtspr & xerDcd;

assign xerE1 = ((PCL_exeXerOvEn & ~IFB_exeOpForExe2L2) | PCL_exeMtspr | PCL_exeXerCaEn |
                PCL_exe2XerOvEn | dlmzb | PCL_exeMcrxr | resetL2);

assign xerE2 = ~(PCL_xerL2Hold | (PCL_exeMtspr & ~xerDcd));

assign nxtXerOv = (PCL_exeXerOvEn & ((addUnitEn & addOV) | divOV |
                  (PCL_exeApuValidOp & APU_exeOv))) |         //mutlDivOV is qualified with
                  (PCL_exe2XerOvEn & (multOV | macOV));                                      //with there unit enables.

reg [0:2] EXE_xer_i;
wire [0:2] EXE_xer;
assign EXE_xer[0:2] = EXE_xer_i[0:2];
wire nxtXerCa_i;
wire nxtXerCa;
assign nxtXerCa = nxtXerCa_i;
assign nxtXerCa_i = (PCL_exeXerCaEn & ((addUnitEn & addCA) | (PCL_exeSrmUnitEnForLSSD & srmCA) |
                   (PCL_exeApuValidOp & APU_exeCa))) |
                   (mtXer & sprBusIn[2]) |
                   (~mtXer & ~PCL_exeXerCaEn & ~PCL_exeMcrxr & EXE_xer_i[2]);

assign xerSOIn = (mtXer & sprBusIn[0]) | nxtXerOv |
                 (~mtXer & ~PCL_exeMcrxr & EXE_xer_i[0]);

assign xerOVIn = (mtXer & sprBusIn[1]) | nxtXerOv |
                  (~mtXer & ~PCL_exeXerOvEn & ~PCL_exe2XerOvEn & ~PCL_exeMcrxr &
                   EXE_xer_i[1]);

assign mtOrReset = mtXer | resetL2;

assign xerTBCNotEqZeroIn = |xerTBCIn[0:6];

reg [0:6] EXE_xerTBC_i;
wire [0:6] EXE_xerTBC;
assign EXE_xerTBC = EXE_xerTBC_i;
always @(mtOrReset or sprBusIn or EXE_xerTBC_i or dlmzb or lsaOut)
begin
   casez({mtOrReset,dlmzb})
      2'b00:begin
         xerTBCIn[0:6] = EXE_xerTBC_i;
      end
      2'b01:begin
         xerTBCIn[0:6] = {3'b0,lsaOut[28:31]};
      end
      2'b1?:begin
         xerTBCIn[0:6] = sprBusIn[25:31];
      end
// x catcher.
      default:begin
         xerTBCIn[0:6] = 7'bxxxxxxx;
      end
   endcase
end

assign EXE_xerTBCIn[0:6] = xerTBCIn[0:6];
//************************************************************************
// XER Latch
//************************************************************************
//dp_regEXE_xer   regEXE_xer(.E1(xerE1),
//                           .E2(xerE2),
//                           .D({xerSOIn,xerOVIn,nxtXerCa,xerTBCIn[0:6],xerTBCNotEqZeroIn}),
//                           .I(SI),
//                           .CB(CB[0:4]),
//                           .L2({EXE_xer[0:2],EXE_xerTBC[0:6],EXE_xerTBCNotEqZero}),
//                           .SO(SO));
// Removed the module 'dp_regEXE_xer'
reg EXE_xerTBCNotEqZero_i;
wire EXE_xerTBCNotEqZero;
assign EXE_xerTBCNotEqZero = EXE_xerTBCNotEqZero_i;
always @(posedge CB)      
    begin                                       
    casez(xerE1 & xerE2)
     1'b0: {EXE_xer_i[0:2],EXE_xerTBC_i[0:6],EXE_xerTBCNotEqZero_i} <= {EXE_xer_i[0:2],EXE_xerTBC_i[0:6],EXE_xerTBCNotEqZero_i};                
     1'b1: {EXE_xer_i[0:2],EXE_xerTBC_i[0:6],EXE_xerTBCNotEqZero_i} <= {xerSOIn,xerOVIn,nxtXerCa_i,xerTBCIn[0:6],xerTBCNotEqZeroIn}; 
      default: {EXE_xer_i[0:2],EXE_xerTBC_i[0:6],EXE_xerTBCNotEqZero_i} <= 11'bx;  
    endcase                             
   end

//************************************************************************
// CR Out Mux
//************************************************************************
// crMuxSel[0:1]
// 00 -  admCcBits[0:2]
// 01 -  logicalCcBits[0:2]
// 10 -  srmCcBits[0:2]
// 11 -  APU_exeCr[0:2]

// condition register bit 3.
assign EXE_cc[3] = ((nxtXerOv | EXE_xer_i[0]) & ~PCL_exeFpuOp) |
                   (APU_exeCr[3] & PCL_exeFpuOp);

assign crMuxSel[0] = PCL_exeSrmUnitEnForLSSD | PCL_exeApuValidOp;
assign crMuxSel[1] = PCL_exeLogicalUnitEnForLSSD | PCL_exeApuValidOp;

//dp_muxEXE_crOut   muxEXE_crOut(.Z(exeUnitCc[0:2]),
//                               .D0(admCcBits[0:2]),
//                               .D1(logicalCcBits[0:2]),
//                               .D2(srmCcBits[0:2]),
//                               .D3(APU_exeCr[0:2]),
//                               .SD(crMuxSel[0:1]));
// Removed the module 'dp_muxEXE_crOut'
always @(crMuxSel or admCcBits or logicalCcBits or srmCcBits or APU_exeCr)
    begin                                           
    case(crMuxSel[0:1])
     2'b00: exeUnitCc[0:2] = admCcBits[0:2];
     2'b01: exeUnitCc[0:2] = logicalCcBits[0:2];    
     2'b10: exeUnitCc[0:2] = srmCcBits[0:2];    
     2'b11: exeUnitCc[0:2] = APU_exeCr[0:2];    
      default: exeUnitCc[0:2] = 3'bx;   
    endcase                                    
   end 

//************************************************************************
// admCc Mux
//************************************************************************
// admCcMuxSel[0:1]
// 00 -  exeUnitCc[0:2]
// 01 -  multHiEOAnsCc[0:2]
// 10 -  multLo4CycAnsCc[0:2]
// 11 -  multLo5CycAnsCc/MacSatCc[0:2]

//dp_muxEXE_admCc   muxEXE_admCc(.Z(EXE_cc[0:2]),
//                               .D0(exeUnitCc[0:2]),
//                               .D1(multHiEOAnsCc[0:2]),
//                               .D2(multLo4CycAnsCc[0:2]),
//                               .D3(multLo5CycAnsCc[0:2]),
//                               .SD0({3{admCcMuxSel[0]}}),
//                               .SD1({3{admCcMuxSel[1]}}));
// Removed the module 'dp_muxEXE_admCc'
assign EXE_cc[0:2] = EXE_cc_muxout[0:2];
always @(admCcMuxSel or admCcMuxSel or exeUnitCc or multHiEOAnsCc or multLo4CycAnsCc or multLo5CycAnsCc)
    begin                                           
    case({admCcMuxSel[0],admCcMuxSel[1]})       
     2'b00: EXE_cc_muxout[0:2] = exeUnitCc[0:2];
     2'b01: EXE_cc_muxout[0:2] = multHiEOAnsCc[0:2];
     2'b10: EXE_cc_muxout[0:2] = multLo4CycAnsCc[0:2];
     2'b11: EXE_cc_muxout[0:2] = multLo5CycAnsCc[0:2];
      default: EXE_cc_muxout[0:2] = 1'bx;        
    endcase                                    
   end

//************************************************************************
// EXE_Cc Inv
//************************************************************************
//dp_logEXE_exeCcInv logEXE_exeCcInv(.Z(EXE_cc_Neg[0:3]),
//                                   .A(exeCc[0:3]));
//
//************************************************************************
// exeResultMuxSel
//************************************************************************
// exeResultMuxSel[0:1]
// 00 -  dsEa[0:31]
// 01 -  srmOut[0:31]
// 10 -  logicalOut[0:31]
// 11 -  sprBus[0:31]

assign exeResultMuxSel[0] = PCL_exeLogicalUnitEnForLSSD | ~PCL_exeSprUnitEn_NEG;
assign exeResultMuxSel[1] = PCL_exeSrmUnitEnForLSSD | ~PCL_exeSprUnitEn_NEG;

assign exeResultSel = PCL_exeEaCalc | PCL_exeSrmUnitEnForLSSD | PCL_exeLogicalUnitEnForLSSD |
                      ~PCL_exeSprUnitEn_NEG;
//************************************************************************
// rRegBypassMuxSel
//************************************************************************
// rRegBypassMuxSel[0:1]
// 00 -  admOut[0:31]
// 01 -  exeResult[0:31]
// 10 -  sRegL2[1:31],nxtQ
// 11 -  apuResult[0:31]

assign rRegBypassMuxSel[0] = (PCL_exeApuValidOp & ~PCL_exeEaCalc) | divNxtToLastSt;
assign rRegBypassMuxSel[1] = PCL_exeApuValidOp | exeResultSel;


endmodule
