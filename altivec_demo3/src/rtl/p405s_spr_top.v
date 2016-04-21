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
module p405s_spr_top (exeSprDataBus, EXE_vctDbgSprDataBus, EXE_timJtgSprDataBus,
                EXE_mmuIcuSprDataBus, EXE_ifbSprDataBus, EXE_dcrDataBus,
                EXE_sprAddr, EXE_dcrAddr,
                exeSprDataEn_NEG, exeSprUnitEn_NEG, aBus, bBus);
    output [0:31] exeSprDataBus;
    output [0:31] EXE_vctDbgSprDataBus;
    output [0:31] EXE_timJtgSprDataBus;
    output [0:31] EXE_mmuIcuSprDataBus;
    output [0:31] EXE_ifbSprDataBus;
    output [0:31] EXE_dcrDataBus;
    output [4:9] EXE_sprAddr;
    output [0:9] EXE_dcrAddr;
    input exeSprUnitEn_NEG;
    input exeSprDataEn_NEG;
    input [0:31] aBus;
    input [22:31] bBus;

// SPR Data Bus Enable
wire [0:31] sprDataQ, sprDataBus;


//dp_logEXE_sprDataQHiNAND2CINV     logEXE_sprDataQHiNAND2CINV(.Z(sprDataQ[0:15]),
//                                                             .A(aBus[0:15]),
//                                                             .B(exeSprDataEn_NEG));
// Removed the module 'dp_logEXE_sprDataQHiNAND2CINV'
assign sprDataQ[0:15] = ~(aBus[0:15] & ~({(16){exeSprDataEn_NEG}}) );

//dp_logEXE_sprDataQLoNAND2CINV     logEXE_sprDataQLoNAND2CINV(.Z(sprDataQ[16:31]),
//                                                             .A(aBus[16:31]),
//                                                             .B(exeSprDataEn_NEG));
// Removed the module 'dp_logEXE_sprDataQLoNAND2CINV'
assign sprDataQ[16:31] = ~(aBus[16:31] & ~({(16){exeSprDataEn_NEG}}) );

//dp_logEXE_sprDataInv          logEXE_sprDataInv(.Z(sprDataBus[0:31]),
//                                                .A(sprDataQ[0:31]));
// Removed the module 'dp_logEXE_sprDataInv'
assign sprDataBus[0:31] = ~(sprDataQ[0:31]);

//dp_logEXE_sprDataExeBuf       logEXE_sprDataExeBuf(.Z(exeSprDataBus[0:31]),
//                                                   .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataExeBuf'
assign exeSprDataBus[0:31] = sprDataBus[0:31];

//dp_logEXE_sprDataVctDbgBuf    logEXE_sprDataVctDbgBuf(.Z(EXE_vctDbgSprDataBus[0:31]),
//                                                      .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataVctDbgBuf'
assign EXE_vctDbgSprDataBus[0:31] = sprDataBus[0:31];

//dp_logEXE_sprDataTimJtgBuf    logEXE_sprDataTimJtgBuf(.Z(EXE_timJtgSprDataBus[0:31]),
//                                                      .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataTimJtgBuf'
assign EXE_timJtgSprDataBus[0:31] = sprDataBus[0:31];

//dp_logEXE_sprDataMmuIcuBuf    logEXE_sprDataMmuIcuBuf(.Z(EXE_mmuIcuSprDataBus[0:31]),
//                                                      .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataMmuIcuBuf'
assign EXE_mmuIcuSprDataBus[0:31] = sprDataBus[0:31];

//dp_logEXE_sprDataIfbBuf       logEXE_sprDataIfbBuf(.Z(EXE_ifbSprDataBus[0:31]),
//                                                   .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataIfbBuf'
assign EXE_ifbSprDataBus[0:31] = sprDataBus[0:31];

//dp_logEXE_sprDataDcrBuf       logEXE_sprDataDcrBuf(.Z(EXE_dcrDataBus[0:31]),
//                                                   .A(sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprDataDcrBuf'
assign EXE_dcrDataBus[0:31] = sprDataBus[0:31];

// SPR Addr Bus Enable
wire [0:9] sprAddrQ;

//dp_logEXE_sprAddrQNOR2CBUF   logEXE_sprAddrQNOR2CBUF(.Z(sprAddrQ[0:9]),
//                                                     .A(bBus[22:31]),
//                                                     .B(exeSprUnitEn_NEG));
// Removed the module 'dp_logEXE_sprAddrQNOR2CBUF'
assign sprAddrQ[0:9] = ~( bBus[22:31] | {(10){exeSprUnitEn_NEG}} );

//dp_logEXE_sprAddrInv   logEXE_sprAddrInv(.Z(EXE_sprAddr[4:9]),
//                                         .A(sprAddrQ[4:9]));
// Removed the module 'dp_logEXE_sprAddrInv'
assign EXE_sprAddr[4:9] = ~(sprAddrQ[4:9]);

//dp_logEXE_dcrAddrInv   logEXE_dcrAddrInv(.Z(EXE_dcrAddr[0:9]),
//                                         .A(sprAddrQ[0:9]));
// Removed the module 'dp_logEXE_dcrAddrInv'
assign EXE_dcrAddr[0:9] = ~(sprAddrQ[0:9]);

endmodule
