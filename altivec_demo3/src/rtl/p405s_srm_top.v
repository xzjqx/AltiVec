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
module p405s_srm_top (srmCA, srmOut, exeSrmUnitEn_NEG, aBus, bBus, srmCntlBus,
           srmL2, srmCcBits);
    output srmCA;
    output [0:31] srmOut;
    output [0:2] srmCcBits;
    input exeSrmUnitEn_NEG;
    input [0:31] aBus;
    input [0:31] bBus;
    input [0:3] srmCntlBus;
    input [0:15] srmL2;

// Gating the aBus and bBus to save power
wire [0:31] aBus_NEG, bBus_NEG;

//dp_logEXE_srmABusHiNAND2CINV  logEXE_srmABusHiNAND2CINV(.Z(aBus_NEG[0:15]),
//                                                        .A(aBus[0:15]),
//                                                        .B(exeSrmUnitEn_NEG));
// Removed the module 'dp_logEXE_srmABusHiNAND2CINV'
assign aBus_NEG[0:15] = ~(aBus[0:15] & ~({(16){exeSrmUnitEn_NEG}}) );

//dp_logEXE_srmABusLoNAND2CINV  logEXE_srmABusLoNAND2CINV(.Z(aBus_NEG[16:31]),
//                                                        .A(aBus[16:31]),
//                                                        .B(exeSrmUnitEn_NEG));
// Removed the module 'dp_logEXE_srmABusLoNAND2CINV'
assign aBus_NEG[16:31] = ~(aBus[16:31] & ~({(16){exeSrmUnitEn_NEG}}) );

//dp_logEXE_srmBBusHiNAND2CINV  logEXE_srmBBusHiNAND2CINV(.Z(bBus_NEG[0:15]),
//                                                        .A(bBus[0:15]),
//                                                        .B(exeSrmUnitEn_NEG));
// Removed the module 'dp_logEXE_srmBBusHiNAND2CINV'
assign bBus_NEG[0:15] = ~(bBus[0:15] & ~({(16){exeSrmUnitEn_NEG}}) );

//dp_logEXE_srmBBusLoNAND2CINV  logEXE_srmBBusLoNAND2CINV(.Z(bBus_NEG[16:31]),
//                                                        .A(bBus[16:31]),
//                                                        .B(exeSrmUnitEn_NEG));
// Removed the module 'dp_logEXE_srmBBusLoNAND2CINV'
assign bBus_NEG[16:31] = ~(bBus[16:31] & ~({(16){exeSrmUnitEn_NEG}}) );

// Input Control Bus
wire shiftRt, shiftLt, shRtAlg,  rlwimi;

assign rlwimi  =  srmCntlBus[0];
assign shiftLt =  srmCntlBus[1];
assign shiftRt =  srmCntlBus[2];
assign shRtAlg =  srmCntlBus[3];

// Defining the field of SRM reg
wire shiftAmtMsb;
wire [0:4] shiftAmt, mbField, meField;

assign shiftAmtMsb   = srmL2[0];
assign shiftAmt[0:4] = srmL2[1:5];
assign mbField[0:4]  = srmL2[6:10];
assign meField[0:4]  = srmL2[11:15];

// Generating rotate amount
wire [0:4] rotateAmt;

assign rotateAmt = (shiftRt) ? ((~shiftAmt) + 1) : shiftAmt;

// Rotate bBus by the rotate amount.
wire [0:31] blrOut;
p405s_srmBlr
  blr(
            .rotateAmt(rotateAmt[0:4]),
            .aBus_NEG(aBus_NEG[0:31]),
            .blrOut(blrOut[0:31]));

// Fill Gen Function.

wire shiftFill, fillSel, aBusMsb;

assign aBusMsb   = ~aBus_NEG[0];
assign shiftFill = ~(shRtAlg & aBusMsb);
assign fillSel   = shiftLt | shiftRt;

wire [0:31] fillGenOut;
//dp_muxEXE_srmFillGen   muxEXE_srmFillGen(.Z(fillGenOut[0:31]),
//                                         .D0(bBus_NEG[0:31]),
//                                         .D1({32{shiftFill}}),
//                                         .SD(fillSel));
// Removed the module 'dp_muxEXE_srmFillGen'
assign fillGenOut[0:31] = ~( (bBus_NEG[0:31] & {(32){~(fillSel)}} ) | ({32{shiftFill}} & {(32){fillSel}} ) );



wire [0:1] propLookAhd;
wire forceZeroDcd;

// Prop Look Ahead function
p405s_srmMskLkAhd
  mskLkAhd(.meField(meField[0:4]),
                      .mbField(mbField[0:4]),
                      .propLookAhd(propLookAhd[0:1]),
                      .forceZeroDcd(forceZeroDcd));


// Generate Mask function.

wire [0:31] mskBegin;
wire [0:14] mskEndHi;
wire [16:30] mskEndLo;
p405s_srmMskDcd
      mskDcd(.meField(meField[0:4]),
                      .mbField(mbField[0:4]),
                      .forceZeroDcd(forceZeroDcd),
                      .shiftAmtMsb(shiftAmtMsb),
                      .shiftLt(shiftLt),
                      .shiftRt(shiftRt),
                      .mskBegin(mskBegin[0:31]),
                      .mskEndHi(mskEndHi[0:14]),
                      .mskEndLo(mskEndLo[16:30]));

// Generate the Mask Propagate Function.
wire [0:31] notMask;
p405s_srmMskProp
     mskProp(.mskBegin(mskBegin[0:31]),
                      .mskEndHi(mskEndHi[0:14]),
                      .mskEndLo(mskEndLo[16:30]),
                      .propLookAhd(propLookAhd[0:1]),
                      .notMask(notMask[0:31]));


wire [0:31] mask;
//dp_logEXE_maskINVERT     logEXE_maskINVERT(.Z(mask[0:31]),
//                                           .A(notMask[0:31]));
// Removed the module 'dp_logEXE_maskINVERT'
assign mask[0:31] = ~(notMask[0:31]);

wire [0:31] blrOutANDnotMask;
//dp_logEXE_blrOutANDnotMask     logEXE_blrOutANDnotMask(.Z(blrOutANDnotMask[0:31]),
//                                                       .A(blrOut[0:31]),
//                                                       .B(notMask[0:31]));
// Removed the module 'dp_logEXE_blrOutANDnotMask'
assign blrOutANDnotMask[0:31] = blrOut[0:31] & notMask[0:31];

// Mask Combine Function
wire enFillGenPath, srmCA;

assign enFillGenPath = rlwimi | shiftLt | shiftRt;
assign srmCA         = (|blrOutANDnotMask) & aBusMsb;


wire [0:31] blrOutNANDmask;
//dp_logEXE_blrOutNANDmask     logEXE_blrOutNANDmask(.Z(blrOutNANDmask[0:31]),
//                                                       .A(mask[0:31]),
//                                                       .B(blrOut[0:31]));
// Removed the module 'dp_logEXE_blrOutNANDmask'
assign blrOutNANDmask[0:31] = ~( mask[0:31] & blrOut[0:31] );

wire [0:31] filGenOutNANDnotMask;
//dp_logEXE_fillGenOutNANDnotMask logEXE_fillGenOutNANDnotMask(.Z(filGenOutNANDnotMask[0:31]),
//                                                       .A(notMask[0:31]),
//                                                       .B(fillGenOut[0:31]),
//                                                       .C({32{enFillGenPath}}));
// Removed the module 'dp_logEXE_fillGenOutNANDnotMask'
assign filGenOutNANDnotMask[0:31] = ~( notMask[0:31] & fillGenOut[0:31] & {32{enFillGenPath}} );

//dp_logEXE_mskFillGenNANDmskBlr     logEXE_mskFillGenNANDmskBlr(.Z(srmOut[0:31]),
//                                                       .A(filGenOutNANDnotMask[0:31]),
//                                                       .B(blrOutNANDmask[0:31]));
// Removed the module 'dp_logEXE_mskFillGenNANDmskBlr'
wire [0:31] srmOut, srmOut_i;
assign srmOut = srmOut_i;
assign srmOut_i[0:31] = ~( filGenOutNANDnotMask[0:31] & blrOutNANDmask[0:31] );

wire srmZeroDetect_NEG;

assign srmZeroDetect_NEG =  |srmOut_i[0:31];

assign srmCcBits[0] = srmOut_i[0];

assign srmCcBits[1] = ~srmOut_i[0] & srmZeroDetect_NEG;

assign srmCcBits[2] = ~srmZeroDetect_NEG;

endmodule
