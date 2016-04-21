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
module p405s_storageCountCntl (apuLdStGtEq4, cntMuxOutGtEq4, xerTbcGtEq4, xerTbcInGtEq4,
           multCnt, stringImmdEq32, cntMuxSel, countRegMuxSel,
           dcdMultiple, dcdNB, dcdRSRT, dcdStringImmediate,
           dcdStringIndexed, exeXerTBCUpdInstr, strgEnd,
           APU_dcdLdStWd, APU_dcdLdStDw, cntMuxOut, EXE_xerTBC,
           EXE_xerTBCIn, plaVal, APU_dcdLdStQw, plaApuLdSt, exeForceAlgn,
           byteCount, exeStrgStC0, PCL_exeEaQwEn);

    output apuLdStGtEq4, cntMuxOutGtEq4, xerTbcGtEq4, xerTbcInGtEq4;
    output [0:5] multCnt;
    output [0:1] cntMuxSel;
    output [0:1] countRegMuxSel;
    output stringImmdEq32;
    output [0:3] PCL_exeEaQwEn;
    input dcdMultiple;
    input [0:4] dcdNB;
    input [0:4] dcdRSRT;
    input dcdStringImmediate;
    input dcdStringIndexed;
    input exeXerTBCUpdInstr;
    input strgEnd;
    input plaVal;
    input APU_dcdLdStQw;
    input APU_dcdLdStDw;
    input APU_dcdLdStWd;
    input [0:5] cntMuxOut;
    input [0:4] EXE_xerTBC;
    input [0:4] EXE_xerTBCIn;
    input plaApuLdSt;
    input exeForceAlgn;
    input [0:7] byteCount;
    input exeStrgStC0;

//assign PCL_apuExeWdCnt[0] = byteCount[3] | (byteCount[4] & byteCount[5]);
//assign PCL_apuExeWdCnt[1] = byteCount[3] | (byteCount[4] & ~byteCount[5]);

// Force lower order bit of dsEa.
assign PCL_exeEaQwEn[0] = ~(exeForceAlgn & exeStrgStC0 & byteCount[3]);

assign PCL_exeEaQwEn[1] = ~(exeForceAlgn & exeStrgStC0 &
                            (byteCount[3] | byteCount[4]));

assign PCL_exeEaQwEn[2] = ~(exeForceAlgn & exeStrgStC0 &
                            (byteCount[3] | byteCount[4] | byteCount[5]));

assign PCL_exeEaQwEn[3] = ~(exeForceAlgn & exeStrgStC0 &
                            (byteCount[3] | byteCount[4] | byteCount[5] | byteCount[6]));

// apuLdSt >= 4.
assign apuLdStGtEq4 = APU_dcdLdStWd | APU_dcdLdStDw | APU_dcdLdStQw;

// cntMuxOut >= 4.
assign cntMuxOutGtEq4 = |cntMuxOut[0:5];

// EXE_xerTBC >= 4.
assign xerTbcGtEq4 = |EXE_xerTBC[0:4];

// EXE_xerTBCIn >= 4.
assign xerTbcInGtEq4 = |EXE_xerTBCIn[0:4];

// multiple Count is obtained by two's comp of RSRT times 4.
assign multCnt[0:5] = {({1'b0,~dcdRSRT[0:4]} + 1)};

// When NB field is zeroes, string length is 32.
assign stringImmdEq32 = ~|dcdNB[0:4];

// Select feedback path any time NOT strgEnd
// 00 - Scalar load/store initial count.
// 01 - multiple load/store initial count.
// 10 - string Immediate initial count.
// 11 - Feedback path while working on storage instruction
assign cntMuxSel[0] = ~strgEnd | dcdStringImmediate;
assign cntMuxSel[1] = ~strgEnd | dcdMultiple;

// Select feedback path any time NOT strgEnd
// 00 - Feedback path while working on storage instruction.
// 01 - String Index output of XER register.
// 10 - String Index input of XER register
// 11 - APU.
   // Replacing instantiation: GTECH_AO21 cntRegSel0
   assign countRegMuxSel[0] = (strgEnd & (~plaVal & ~plaApuLdSt)) | strgEnd & dcdStringIndexed & exeXerTBCUpdInstr;


   // Replacing instantiation: GTECH_AO21 cntRegSel1
   assign countRegMuxSel[1] = (strgEnd & (~plaVal & ~plaApuLdSt)) | strgEnd & dcdStringIndexed & ~exeXerTBCUpdInstr;


endmodule
