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
//  from espresso format file on Wed Nov 25 15:23:15 EST 1998
// modulename is ldSteerPla
// input file is ldSteerPla.pers
// output file is ldSteerPla.v
// espresso will be called.
// ######################
// #                    #
// #  Load Steer Cntl   #
// #                    #
// ######################
// # the types are:
// #.f    ones=1 , zero= comp ones, dcs = null
// #        this is like a regular PLA
// #.fd   dcs = -, ones = 1 without -, zero = comp(dcs union ones)
// #        all unlisted input combinations produce a 0 output
// #        note that if an output is covered by both a - and 1, it is -
// #.fr   ones = 1, zero=0, dcs= comp(ones union zero)
// #        all unlisted input combinations are don't cares
// #        note that if an output is covered by both a 0 and 1, it is error
// #.fdr  ones = 1, zero=0, dcs=-
// #        all unlisted input combinations are ?
// #        does not say what happens if overlapping covers
// #
// # ~ in an output position means don't consider this line in generating this output.
// # synopsys does:
// #     read pla
// #     set current design
// # normally include:
//
// ##
// #
// .outputnames ldAdjSel[1:3] ldSteerMuxSel[0:7] ldFillByPassMuxSel[0:5]
// .outputnames ldAdjE2[1:3]
// .inputnames  ea[0:1] byteCount[6:7] cntGtEq4 strgSt[1:2] load
// .inputnames  string multiple byteRev algebraic
// .type fd
// .i 12
// .o 20
// #
// #History:
// # 01/15/98 SBP Copied from 401.
// # 11/23/98 SBP Design review changes.
// #
// #Notes:
// #
// #
// #
// #
// #
// #
// # INPUTS ********************* OUTPUTS***********************
// # All I/P are WB L2's
// #
// #                           A
// #                     M     l
// #                     u  B  g
// #       C          S  l  y  e
// #       n          t  t  t  b                   ld
// #       t       L  r  i  e  r    ld   ld        fill    ld
// #   BT  >  strg o  i  p  R  a    Adj  Steer     Bypass  Adj
// #EA CT  =  st   a  n  l  e  i    Sel  Mux       Mux     E2
// #01 67  4  12   d  g  e  v  c    012  01234567  012345  123
// #-- --  -  --   -  -  -  -  -  * ---  --------  ------  ---
// --  --  -  00   1  -  -  -  -    000  ~~~~~~~~  ~~~~~~  ~~~    # All ld's wbC0
// 00  --  -  --   1  -  -  -  -    000  ~~~~~~~~  ~~~~~~  ~~~    # algnd ld's wbC0,C1
// 01  --  -  -1   1  -  -  -  -    111  ~~~~~~~~  ~~~~~~  ~~~    # ld's wbC1
// 10  --  -  -1   1  -  -  -  -    011  ~~~~~~~~  ~~~~~~  ~~~    # ld's wbC1
// 11  --  -  -1   1  -  -  -  -    001  ~~~~~~~~  ~~~~~~  ~~~    # ld's wbC1
// --  --  -  1-   -  -  -  -  -    111  ~~~~~~~~  ~~~~~~  ~~~    # ld's wbLS
// #****************************************************************
// #  Loads Steer Mux
// 00  01  0  00   1  0  0  -  -    ~~~  01010101  ~~~~~~  ~~~    # All ld bytes
// 01  01  0  00   1  0  0  -  -    ~~~  10101010  ~~~~~~  ~~~    #
// 10  01  0  00   1  0  0  -  -    ~~~  11111111  ~~~~~~  ~~~    #
// 11  01  0  00   1  0  0  -  -    ~~~  00000000  ~~~~~~  ~~~    #
// #  EA=00
// 00  10  0  00   1  0  0  0  -    ~~~  10101010  ~~~~~~  ~~~    # ld hw and zero
// 00  10  0  00   1  0  0  1  -    ~~~  11011101  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=01
// 01  10  0  00   1  0  0  0  -    ~~~  11111111  ~~~~~~  ~~~    # ld hw and zero
// 01  10  0  00   1  0  0  1  -    ~~~  00100010  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=10
// 10  10  0  00   1  0  0  0  -    ~~~  00000000  ~~~~~~  ~~~    # ld hw and zero
// 10  10  0  00   1  0  0  1  -    ~~~  01110111  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=11
// 11  01  0  -1   1  0  0  0  -    ~~~  01010101  ~~~~~~  ~~~    # ld hw and zero
// 11  01  0  -1   1  0  0  1  -    ~~~  10001000  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=00
// 00  --  1  00   1  0  0  0  -    ~~~  00000000  ~~~~~~  ~~~    # ld wd and zero
// 00  --  1  00   1  0  0  1  -    ~~~  11011101  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=01
// 01  01  0  -1   1  0  0  0  -    ~~~  01010101  ~~~~~~  ~~~    # ld wd and zero
// 01  01  0  -1   1  0  0  1  -    ~~~  00100010  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=10
// 10  10  0  -1   1  0  0  0  -    ~~~  10101010  ~~~~~~  ~~~    # ld wd and zero
// 10  10  0  -1   1  0  0  1  -    ~~~  01110111  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=11
// 11  11  0  -1   1  0  0  0  -    ~~~  11111111  ~~~~~~  ~~~    # ld wd and zero
// 11  11  0  -1   1  0  0  1  -    ~~~  10001000  ~~~~~~  ~~~    # True LE ^ byteRev
//
// #  lmw Steer Mux
// #  EA=00
// 00  --  -  0-   1  -  1  0  -    ~~~  00000000  ~~~~~~  ~~~    # C0,C1
// 00  --  -  0-   1  -  1  1  -    ~~~  11011101  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=01
// 01  --  -  0-   1  -  1  0  -    ~~~  01010101  ~~~~~~  ~~~    # C1 count >= 4
// 01  --  -  0-   1  -  1  1  -    ~~~  00100010  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=10
// 10  --  -  0-   1  -  1  0  -    ~~~  10101010  ~~~~~~  ~~~    # C1 count >= 4
// 10  --  -  0-   1  -  1  1  -    ~~~  01110111  ~~~~~~  ~~~    # True LE ^ byteRev
// #  EA=11
// 11  --  -  0-   1  -  1  0  -    ~~~  11111111  ~~~~~~  ~~~    # C1 count >= 4
// 11  --  -  0-   1  -  1  1  -    ~~~  10001000  ~~~~~~  ~~~    # True LE ^ byteRev
//
// #  lswi,lswx Steer Mux
// #  EA=00
// 00  --  -  --   1  1  -  -  -    ~~~  00000000  ~~~~~~  ~~~    # C0,C1
// #  EA=01
// 01  --  -  --   1  1  -  -  -    ~~~  01010101  ~~~~~~  ~~~    # C0,C1,LS
// #  EA=10
// 10  --  -  --   1  1  -  -  -    ~~~  10101010  ~~~~~~  ~~~    # C0,C1,LS
// #  EA=11
// 11  --  -  --   1  1  -  -  -    ~~~  11111111  ~~~~~~  ~~~    # C0,C1,LS
//
// #
// # INPUTS ********************* OUTPUTS***********************
// #
// #
// #                           A
// #                     M     l
// #                     u  B  g
// #       C          S  l  y  e
// #       n          t  t  t  b                   ld
// #       t       L  r  i  e  r    ld   ld        fill    ld
// #   BT  >  strg o  i  p  R  a    Adj  Steer     Bypass  Adj
// #EA CT  =  st   a  n  l  e  i    Sel  Mux       Mux     E2
// #01 67  4  12   d  g  e  v  c    123  01234567  012345  123
// #-- --  -  --   -  -  -  -  -  * ---  --------  ------  ---
// --  --  -  --   1  -  1  -  -    ~~~  ~~~~~~~~  00000~  ~~~    # All lmw's
// --  --  -  --   1  0  -  -  -    ~~~  ~~~~~~~~  ~~~~~0  ~~~    # All ld nonString
// --  01  0  -0   1  0  0  -  -    ~~~  ~~~~~~~~  01011~  ~~~    # All ld bytes
// --  --  -  --   1  -  -  -  1    ~~~  ~~~~~~~~  1010~~  ~~~    # ld hw alg
// --  10  0  -0   1  0  0  -  0    ~~~  ~~~~~~~~  0101~~  ~~~    # ld hw aligned
// 11  01  0  -1   1  0  0  -  0    ~~~  ~~~~~~~~  0101~~  ~~~    # ld hw unaligned
// 01  --  -  -1   1  0  0  -  -    ~~~  ~~~~~~~~  00000~  ~~~    # ld wd unaligned
// --  1-  -  -1   1  0  0  -  -    ~~~  ~~~~~~~~  00000~  ~~~    # ld wd unaligned
// --  --  1  0-   1  -  -  -  -    ~~~  ~~~~~~~~  000000  ~~~    # ld string CNT >= 4 Or Ld Wd in C0
// #  ld strings
// --  --  -  0-   1  1  -  -  -    ~~~  ~~~~~~~~  00~~~~  ~~~    # All ld strings wbC0,C1
// --  01  0  00   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0111  ~~~    # ld string wbC0
// --  10  0  00   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0011  ~~~    # ld string wbC0
// --  11  0  00   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0001  ~~~    # ld string wbC0
// #  EA=00
// 00  01  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0111  ~~~    # ld string wbC1
// 00  10  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0011  ~~~    # ld string wbC1
// 00  11  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0001  ~~~    # ld string wbC1
// #  EA=01
// 01  --  -  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0000  ~~~    # ld string wbC1
// #  EA=10
// 10  01  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0001  ~~~    # ld string wbC1
// 10  1-  -  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0000  ~~~    # ld string wbC1
// #  EA=11
// 11  01  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0011  ~~~    # ld string wbC1
// 11  10  0  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0001  ~~~    # ld string wbC1
// 11  11  -  -1   1  1  -  -  -    ~~~  ~~~~~~~~  ~~0000  ~~~    # ld string wbC1
// #  wbLS
// 01  --  1  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000001  ~~~    # ld string wbLS cnt = 4
// 01  10  -  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000111  ~~~    # ld string wbLS
// 01  11  -  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000011  ~~~    # ld string wbLS
// 10  --  1  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000011  ~~~    # ld string wbLS cnt = 4
// 10  11  -  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000111  ~~~    # ld string wbLS
// 11  --  1  1-   -  -  -  -  -    ~~~  ~~~~~~~~  000111  ~~~    # ld string wbLS cnt = 4
//
// #
// # INPUTS ********************* OUTPUTS***********************
// #
// #
// #                           A
// #                     M     l
// #                     u  B  g
// #       C          S  l  y  e
// #       n          t  t  t  b                   ld
// #       t       L  r  i  e  r    ld   ld        fill    ld
// #   BT  >  strg o  i  p  R  a    Adj  Steer     Bypass  Adj
// #EA CT  =  st   a  n  l  e  i    Sel  Mux       Mux     E2
// #01 67  4  12   d  g  e  v  c    123  01234567  012345  123
// #-- --  -  --   -  -  -  -  -  * ---  --------  ------  ---
// #  ldAdjE1 = wbLoadL2 | (lwbFullL2 & ~ltchDAL2);
// #  ld adjByte enable determination for all loads
// #  EA=00 adj not needed.
// #  EA=01
// 01  1-  -  -1   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  111    # wbC1 count >= 2
// 01  --  1  0-   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  111    # wbC0,C1 count >= 4
// #  EA=10
// 10  11  -  0-   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  011    # wbC0,C1 count >= 3
// 10  --  1  0-   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  011    # wbC0,C1 count >= 4
// #  EA=11
// 11  1-  -  00   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  001    # wbC0 count >= 2
// 11  --  1  0-   -  -  -  -  -    ~~~  ~~~~~~~~  ~~~~~~  001    # wbC0,C1 count >= 4
module p405s_ldSteerPla (
ldAdjSel,
ldSteerMuxSel,
ldFillByPassMuxSel,
ldAdjE2,
ea,
byteCount,
cntGtEq4,
strgSt,
load,
string,
multiple,
byteRev,
algebraic);

output [1:3] ldAdjSel;
output [0:7] ldSteerMuxSel;
output [0:5] ldFillByPassMuxSel;
output [1:3] ldAdjE2;

input [0:1] ea;
input [6:7] byteCount;
input  cntGtEq4;
input [1:2] strgSt;
input  load;
input  string;
input  multiple;
input  byteRev;
input  algebraic;

wire [0:1] not_ea;
wire [6:7] not_byteCount;
wire  not_cntGtEq4;
wire [1:2] not_strgSt;
wire  not_string;
wire  not_multiple;
wire  not_byteRev;
wire  not_algebraic;

wire [0:51] pterm;

assign not_ea[0] = ~(ea[0]);
assign not_ea[1] = ~(ea[1]);
assign not_byteCount[6] = ~(byteCount[6]);
assign not_byteCount[7] = ~(byteCount[7]);
assign not_cntGtEq4 = ~(cntGtEq4);
assign not_strgSt[1] = ~(strgSt[1]);
assign not_strgSt[2] = ~(strgSt[2]);
assign not_string = ~(string);
assign not_multiple = ~(multiple);
assign not_byteRev = ~(byteRev);
assign not_algebraic = ~(algebraic);

// AND array expressions and reprint of all terms
// <0> 11010--100-0 00000000000010100000
assign pterm[0] = (ea[0] & ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & load & 
   not_string & not_multiple & not_algebraic);
// <1> 01100001--0- 00001010101000000000
assign pterm[1] = (not_ea[0] & ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_byteRev);
// <2> 01010-11001- 00000100010000000000
assign pterm[2] = (not_ea[0] & ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & not_string & not_multiple & byteRev);
// <3> 011000010-1- 00000100010000000000
assign pterm[3] = (not_ea[0] & ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_string & byteRev);
// <4> 0-100001000- 00010101010000000000
assign pterm[4] = (not_ea[0] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_string & not_multiple & not_byteRev);
// <5> 10010001-0-- 00010101010000000000
assign pterm[5] = (ea[0] & not_ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_multiple);
// <6> 0101000100-- 00010101010000000000
assign pterm[6] = (not_ea[0] & ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_string & not_multiple);
// <7> --100-0100-0 00000000000010100000
assign pterm[7] = (byteCount[6] & not_byteCount[7] & not_cntGtEq4 & not_strgSt[2] & 
   load & not_string & not_multiple & not_algebraic);
// <8> 10100-11001- 00001110111000000000
assign pterm[8] = (ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & not_string & not_multiple & byteRev);
// <9> 10100-11-00- 00010101010000000000
assign pterm[9] = (ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & not_multiple & not_byteRev);
// <10> -001000100-- 00001010101000000000
assign pterm[10] = (not_ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & not_strgSt[2] & load & not_string & not_multiple);
// <11> 00010-111--- 00000000000000110000
assign pterm[11] = (not_ea[0] & not_ea[1] & not_byteCount[6] & byteCount[7] & 
   not_cntGtEq4 & strgSt[2] & load & string);
// <12> 11010-111--- 00000000000000010000
assign pterm[12] = (ea[0] & ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & string);
// <13> 00100-111--- 00000000000000011000
assign pterm[13] = (not_ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & 
   not_cntGtEq4 & strgSt[2] & load & string);
// <14> 11100-111--- 00000000000000001000
assign pterm[14] = (ea[0] & ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & string);
// <15> 0010-0010-1- 00011011101000000000
assign pterm[15] = (not_ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & 
   not_strgSt[1] & not_strgSt[2] & load & not_string & byteRev);
// <16> 11-10-11-01- 00010001000000000000
assign pterm[16] = (ea[0] & ea[1] & byteCount[7] & not_cntGtEq4 & strgSt[2] & load & 
   not_multiple & byteRev);
// <17> 101000-10-1- 00001110111000000000
assign pterm[17] = (ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_strgSt[1] & load & not_string & byteRev);
// <18> -1010-11-00- 00001010101000000000
assign pterm[18] = (ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & strgSt[2] & 
   load & not_multiple & not_byteRev);
// <19> 1-010-111--- 00000000000000001000
assign pterm[19] = (ea[0] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & strgSt[2] & 
   load & string);
// <20> 00-10-111--- 00000000000000001000
assign pterm[20] = (not_ea[0] & not_ea[1] & byteCount[7] & not_cntGtEq4 & strgSt[2] & 
   load & string);
// <21> --010-0100-- 00000000000010110000
assign pterm[21] = (not_byteCount[6] & byteCount[7] & not_cntGtEq4 & not_strgSt[2] & 
   load & not_string & not_multiple);
// <22> --0100011--- 00000000000000110000
assign pterm[22] = (not_byteCount[6] & byteCount[7] & not_cntGtEq4 & not_strgSt[1] & 
   not_strgSt[2] & load & string);
// <23> 00--10010-1- 00011011101000000000
assign pterm[23] = (not_ea[0] & not_ea[1] & cntGtEq4 & not_strgSt[1] & not_strgSt[2] & 
   load & not_string & byteRev);
// <24> --1000011--- 00000000000000011000
assign pterm[24] = (byteCount[6] & not_byteCount[7] & not_cntGtEq4 & not_strgSt[1] & 
   not_strgSt[2] & load & string);
// <25> 11110-11-00- 00011111111000000000
assign pterm[25] = (ea[0] & ea[1] & byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   strgSt[2] & load & not_multiple & not_byteRev);
// <26> 0110-1------ 00000000000000100000
assign pterm[26] = (not_ea[0] & ea[1] & byteCount[6] & not_byteCount[7] & strgSt[1]);
// <27> ---100011--- 00000000000000001000
assign pterm[27] = (byteCount[7] & not_cntGtEq4 & not_strgSt[1] & not_strgSt[2] & load & 
   string);
// <28> 01---0-1-11- 00000100010000000000
assign pterm[28] = (not_ea[0] & ea[1] & not_strgSt[1] & load & multiple & byteRev);
// <29> 1011-0------ 00000000000000000011
assign pterm[29] = (ea[0] & not_ea[1] & byteCount[6] & byteCount[7] & not_strgSt[1]);
// <30> 111--00----- 00000000000000000001
assign pterm[30] = (ea[0] & ea[1] & byteCount[6] & not_strgSt[1] & not_strgSt[2]);
// <31> 1011-1------ 00000000000000111000
assign pterm[31] = (ea[0] & not_ea[1] & byteCount[6] & byteCount[7] & strgSt[1]);
// <32> 11--11------ 00000000000000100000
assign pterm[32] = (ea[0] & ea[1] & cntGtEq4 & strgSt[1]);
// <33> 10--10------ 00000000000000000011
assign pterm[33] = (ea[0] & not_ea[1] & cntGtEq4 & not_strgSt[1]);
// <34> 01--10------ 00000000000000000110
assign pterm[34] = (not_ea[0] & ea[1] & cntGtEq4 & not_strgSt[1]);
// <35> 00---0-1-11- 00011011101000000000
assign pterm[35] = (not_ea[0] & not_ea[1] & not_strgSt[1] & load & multiple & byteRev);
// <36> 11---0-1-1-- 00010001000000000000
assign pterm[36] = (ea[0] & ea[1] & not_strgSt[1] & load & multiple);
// <37> 10---0-1-11- 00001110111000000000
assign pterm[37] = (ea[0] & not_ea[1] & not_strgSt[1] & load & multiple & byteRev);
// <38> 011--1------ 00000000000000011000
assign pterm[38] = (not_ea[0] & ea[1] & byteCount[6] & strgSt[1]);
// <39> 011---1----- 00000000000000000111
assign pterm[39] = (not_ea[0] & ea[1] & byteCount[6] & strgSt[2]);
// <40> 1----0-1-10- 00010101010000000000
assign pterm[40] = (ea[0] & not_strgSt[1] & load & multiple & not_byteRev);
// <41> -1---0-1-10- 00001010101000000000
assign pterm[41] = (ea[1] & not_strgSt[1] & load & multiple & not_byteRev);
// <42> 10----11---- 01100000000000000000
assign pterm[42] = (ea[0] & not_ea[1] & strgSt[2] & load);
// <43> -1--11------ 00000000000000001000
assign pterm[43] = (ea[1] & cntGtEq4 & strgSt[1]);
// <44> 01----11---- 11000000000000000000
assign pterm[44] = (not_ea[0] & ea[1] & strgSt[2] & load);
// <45> 1---11------ 00000000000000011000
assign pterm[45] = (ea[0] & cntGtEq4 & strgSt[1]);
// <46> -1--10------ 00000000000000000001
assign pterm[46] = (ea[1] & cntGtEq4 & not_strgSt[1]);
// <47> -1----11---- 00100000000000000000
assign pterm[47] = (ea[1] & strgSt[2] & load);
// <48> -------1---1 00000000000101000000
assign pterm[48] = (load & algebraic);
// <49> -----1------ 11100000000000000000
assign pterm[49] = (strgSt[1]);
// <50> 1------11--- 00010101010000000000
assign pterm[50] = (ea[0] & load & string);
// <51> -1-----11--- 00001010101000000000
assign pterm[51] = (ea[1] & load & string);

// OR array expressions
assign ldAdjSel[1] = (pterm[44] | pterm[49]);
assign ldAdjSel[2] = (pterm[42] | pterm[44] | pterm[49]);
assign ldAdjSel[3] = (pterm[42] | pterm[47] | pterm[49]);
assign ldSteerMuxSel[0] = (pterm[4] | pterm[5] | pterm[6] | pterm[9] | pterm[15] | 
   pterm[16] | pterm[23] | pterm[25] | pterm[35] | pterm[36] | pterm[40] | pterm[50]);
assign ldSteerMuxSel[1] = (pterm[1] | pterm[8] | pterm[10] | pterm[15] | pterm[17] | 
   pterm[18] | pterm[23] | pterm[25] | pterm[35] | pterm[37] | pterm[41] | pterm[51]);
assign ldSteerMuxSel[2] = (pterm[2] | pterm[3] | pterm[4] | pterm[5] | pterm[6] | 
   pterm[8] | pterm[9] | pterm[17] | pterm[25] | pterm[28] | pterm[37] | pterm[40] | 
   pterm[50]);
assign ldSteerMuxSel[3] = (pterm[1] | pterm[8] | pterm[10] | pterm[15] | pterm[17] | 
   pterm[18] | pterm[23] | pterm[25] | pterm[35] | pterm[37] | pterm[41] | pterm[51]);
assign ldSteerMuxSel[4] = (pterm[4] | pterm[5] | pterm[6] | pterm[9] | pterm[15] | 
   pterm[16] | pterm[23] | pterm[25] | pterm[35] | pterm[36] | pterm[40] | pterm[50]);
assign ldSteerMuxSel[5] = (pterm[1] | pterm[8] | pterm[10] | pterm[15] | pterm[17] | 
   pterm[18] | pterm[23] | pterm[25] | pterm[35] | pterm[37] | pterm[41] | pterm[51]);
assign ldSteerMuxSel[6] = (pterm[2] | pterm[3] | pterm[4] | pterm[5] | pterm[6] | 
   pterm[8] | pterm[9] | pterm[17] | pterm[25] | pterm[28] | pterm[37] | pterm[40] | 
   pterm[50]);
assign ldSteerMuxSel[7] = (pterm[1] | pterm[8] | pterm[10] | pterm[15] | pterm[17] | 
   pterm[18] | pterm[23] | pterm[25] | pterm[35] | pterm[37] | pterm[41] | pterm[51]);
assign ldFillByPassMuxSel[0] = (pterm[48]);
assign ldFillByPassMuxSel[1] = (pterm[0] | pterm[7] | pterm[21]);
assign ldFillByPassMuxSel[2] = (pterm[48]);
assign ldFillByPassMuxSel[3] = (pterm[0] | pterm[7] | pterm[11] | pterm[21] | pterm[22] | 
   pterm[26] | pterm[31] | pterm[32]);
assign ldFillByPassMuxSel[4] = (pterm[11] | pterm[12] | pterm[13] | pterm[21] | 
   pterm[22] | pterm[24] | pterm[31] | pterm[38] | pterm[45]);
assign ldFillByPassMuxSel[5] = (pterm[13] | pterm[14] | pterm[19] | pterm[20] | 
   pterm[24] | pterm[27] | pterm[31] | pterm[38] | pterm[43] | pterm[45]);
assign ldAdjE2[1] = (pterm[34] | pterm[39]);
assign ldAdjE2[2] = (pterm[29] | pterm[33] | pterm[34] | pterm[39]);
assign ldAdjE2[3] = (pterm[29] | pterm[30] | pterm[33] | pterm[39] | pterm[46]);

endmodule
