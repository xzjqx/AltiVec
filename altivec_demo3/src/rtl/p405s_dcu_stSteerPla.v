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
// Gate level change for p
// 11/16/99 SBP Changes pterm[18]. See pass2 issue 159 for details.
// autogenerated by <$Id: p405s_dcu_stSteerPla.v,v 1.2 2005/03/15 18:00:14 lavanyam Exp $>
//  from espresso format file on Tue May  4 09:34:18 EDT 1999
// modulename is stSteerPla
// input file is stSteerPla.pers
// output file is stSteerPla.v
// espresso will be called.
// ######################
// #                    #
// #  Store Steer PLA   #
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
// .outputnames stMuxSel[0:3] stSteerMuxSel[0:7]  stAdjE1[0:3]
// .inputnames  mea[0:1] byteCount[6:7] cntGtEq4 storageSt
// .inputnames  string multiple byteRev byteRev2
// .type fd
// .i 10
// .o 16
// #
// #History:
// # 01/22/98 Create.
// # 11/25/98 SP/JD Timing improvements. Removed ldAdjEn from
// #          pla and made it the E2 of the adjRegs.
// # 05/04/99 Added additional copy of byteRev, byteRev2 to help loading/timing TSG
// #
// #Notes:
// #
// #
// # INPUTS ******************  OUTPUTS****************************
// #
// #
// #
// #                 M    B
// #                 u  B y
// #       C      S  l  y t
// #       n      t  t  t e
// #       t      r  i  e R           st        st
// #MG BT  >      i  p  R e     st    Steer     Adj
// #EA CT  =  S   n  l  e v     Mux   Mux       E1
// #01 67  4  M   g  e  v 2     0123  01234567  0123
// #-- --  -  -   -  -  - -   * ----  --------  ----
// ## Store Mux
// -1  --  -  1   0  -  1 -     1~~~  ~~~~~~~~  ~~~~   # Only for byteReverse/TLE
// 1-  --  -  1   0  -  1 -     1~~~  ~~~~~~~~  ~~~~   # and non-00 EA.
//
// 10  --  -  1   0  -  1 -     ~1~~  ~~~~~~~~  ~~~~   # All st string byteReverse/TLE
// 11  --  -  1   -  -  - -     ~1~~  ~~~~~~~~  ~~~~   # C1 EA=11.
//
// 10  --  -  1   -  -  0 -     ~~1~  ~~~~~~~~  ~~~~   # C1 EA=10 non-byteReverse/TLE.
// 10  --  -  1   1  -  - -     ~~1~  ~~~~~~~~  ~~~~   # C1 EA=10 all strings.
// 11  --  -  1   -  -  - -     ~~1~  ~~~~~~~~  ~~~~   # C1 EA=11.
//
// -1  --  -  1   1  -  - -     ~~~1  ~~~~~~~~  ~~~~   # String and non-00 EA.
// 1-  --  -  1   1  -  - -     ~~~1  ~~~~~~~~  ~~~~   # String and non-00 EA.
// -1  --  -  1   -  -  0 -     ~~~1  ~~~~~~~~  ~~~~   # Non byteReverse/TLE
// 1-  --  -  1   -  -  0 -     ~~~1  ~~~~~~~~  ~~~~   # and non-00 EA.
//
// #01  --  -  1   -  -  0 -     0001  ~~~~~~~~  ~~~~   # All non string st
// #01  --  -  1   0  -  1 -     1000  ~~~~~~~~  ~~~~   # All non string st byteReverse/TLE
// #01  --  -  1   1  -  - -     0001  ~~~~~~~~  ~~~~   # All string st
// #10  --  -  1   -  -  0 -     0011  ~~~~~~~~  ~~~~   # All non string st
// #10  --  -  1   0  -  1 -     1100  ~~~~~~~~  ~~~~   # All st string byteReverse/TLE
// #10  --  -  1   1  -  - -     0011  ~~~~~~~~  ~~~~   # All string st
// #11  --  -  1   -  -  0 -     0111  ~~~~~~~~  ~~~~   # All non string st
// #11  --  -  1   0  -  1 -     1110  ~~~~~~~~  ~~~~   # All non string st byteReverse/TLE
// #11  --  -  1   1  -  - -     0111  ~~~~~~~~  ~~~~   # All st string
// #
// # INPUTS*******************  OUTPUTS******************
// #
// #                 M    B
// #                 u  B y
// #       C      S  l  y t
// #       n      t  t  t e
// #       t      r  i  e R           st        st
// #MG     >      i  p  R e     st    Steer     Adj
// #EA     =  S   n  l  e v     Mux   Mux       E1
// #01 67  4  M   g  e  v 2     0123  01234567  0123
// #-- --  -  -   -  -  - -   * ----  --------  ----
// #  Stores Steer Mux
// 00  01  0  0   0  0  - -     ~~~~  11------  ~~~~   # All st bytes
// 01  01  0  0   0  0  - -     ~~~~  --10----  ~~~~   #
// 10  01  0  0   0  0  - -     ~~~~  ----01--  ~~~~   #
// 11  01  0  0   0  0  - -     ~~~~  ------00  ~~~~   #
// #EA=00
// 00  10  0  0   0  0  - 0     ~~~~  1010----  ~~~~   # st hw
// 00  10  0  0   0  0  - 1     ~~~~  1101----  ~~~~   # st hw byteReverse/TLE
// #EA=01
// 01  10  0  0   0  0  - 0     ~~~~  --0101--  ~~~~   # st hw
// 01  10  0  0   0  0  - 1     ~~~~  --1000--  ~~~~   # st hw byteReverse/TLE
// #EA=10
// 10  10  0  0   0  0  - 0     ~~~~  ----0000  ~~~~   # st hw
// 10  10  0  0   0  0  - 1     ~~~~  ----0111  ~~~~   # st hw byteReverse/TLE
// #EA=11
// 11  10  0  0   0  0  - 0     ~~~~  ------11  ~~~~   # st hw
// 11  10  0  0   0  0  - 1     ~~~~  ------00  ~~~~   # st hw byteReverse/TLE
// 11  01  0  1   0  0  - 0     ~~~~  11------  ~~~~   # st hw
// 11  01  0  1   0  0  - 1     ~~~~  10------  ~~~~   # st hw byteReverse/TLE
// #EA=00
// 00  --  1  0   0  0  - 0     ~~~~  00000000  ~~~~   # st wd
// 00  --  1  0   0  0  - 1     ~~~~  11011101  ~~~~   # st wd byteReverse/TLE
// #EA=01
// 01  --  1  0   0  0  - 0     ~~~~  --111111  ~~~~   # st wd
// 01  --  1  0   0  0  - 1     ~~~~  --100010  ~~~~   # st wd byteReverse/TLE
// 01  01  0  1   0  0  - 0     ~~~~  11------  ~~~~   # st wd
// 01  01  0  1   0  0  - 1     ~~~~  00------  ~~~~   # st wd byteReverse/TLE
// #EA=10
// 10  --  1  0   0  0  - 0     ~~~~  ----1010  ~~~~   # st wd
// 10  --  1  0   0  0  - 1     ~~~~  ----0111  ~~~~   # st wd byteReverse/TLE
// 10  10  0  1   0  0  - 0     ~~~~  1010----  ~~~~   # st wd
// 10  10  0  1   0  0  - 1     ~~~~  0111----  ~~~~   # st wd byteReverse/TLE
// #EA=11
// 11  --  1  0   0  0  - 0     ~~~~  ------01  ~~~~   # st wd
// 11  --  1  0   0  0  - 1     ~~~~  ------00  ~~~~   # st wd byteReverse/TLE
// 11  11  0  1   0  0  - 0     ~~~~  010101--  ~~~~   # st wd
// 11  11  0  1   0  0  - 1     ~~~~  100010--  ~~~~   # st wd byteReverse/TLE
// #  stmw Steer Mux
// #EA=00
// 00  --  -  -   -  1  - 0     ~~~~  00000000  ~~~~   # C0,C1
// 00  --  -  -   -  1  - 1     ~~~~  11011101  ~~~~   # True LE
// #EA=01
// 01  --  -  -   -  1  - 0     ~~~~  11111111  ~~~~   # C0,C1
// 01  --  -  -   -  1  - 1     ~~~~  00100010  ~~~~   # True LE
// #EA=10
// 10  --  -  -   -  1  - 0     ~~~~  10101010  ~~~~   # C0,C1
// 10  --  -  -   -  1  - 1     ~~~~  01110111  ~~~~   # True LE
// #EA=11
// 11  --  -  -   -  1  - 0     ~~~~  01010101  ~~~~   # C0,C1
// 11  --  -  -   -  1  - 1     ~~~~  10001000  ~~~~   # True LE
// # stswi,stswx Steer Muxux
// #EA=00
// 00  --  -  -   1  -  - -     ~~~~  00000000  ~~~~   # C0,C1
// #EA=01
// 01  --  -  -   1  -  - -     ~~~~  11111111  ~~~~   # C0,C1
// #EA=10
// 10  --  -  -   1  -  - -     ~~~~  10101010  ~~~~   # C0,C1
// #EA=11
// 11  --  -  -   1  -  - -     ~~~~  01010101  ~~~~   # C0,C1
// #
// # INPUTS*******************  OUTPUTS******************
// #
// #                 M    B
// #                 u  B y
// #       C      S  l  y t
// #       n      t  t  t e
// #       t      r  i  e R           st        st
// #MG     >      i  p  R e     st    Steer     Adj
// #EA     =  S   n  l  e v     Mux   Mux       E1
// #01 67  4  M   g  e  v 2     0123  01234567  0123
// #-- --  -  -   -  -  - -   * ----  --------  ----
// #  st Adj Byte E1
// #  st Adj Byte E2 is SASAQ_E2.
// #EA=00 Adj note needed.d.
// #EA=01
// 01  --  1  -   -  -  0 -     ~~~~  ~~~~~~~~  0001   # unalign word, multiple stores
// 01  --  1  -   0  -  1 -     ~~~~  ~~~~~~~~  1000   # C0,C1, count >= 4, word, multiple TLE
// 01  --  1  -   1  -  - -     ~~~~  ~~~~~~~~  0001   # C0,C1, count >= 4, string
// #EA=10
// 10  --  1  -   -  -  0 -     ~~~~  ~~~~~~~~  0011   # unalign word, multiple stores
// 10  --  1  -   0  -  1 -     ~~~~  ~~~~~~~~  1100   # C0, count >= 4, word, multiple TLE
// 10  11  0  0   -  -  - -     ~~~~  ~~~~~~~~  0011   # C0, count = 3, string
// 10  --  1  -   1  -  - -     ~~~~  ~~~~~~~~  0011   # C0, count >= 4, string
// #EA=11
// 11  10  0  -   0  0  0 -     ~~~~  ~~~~~~~~  0001   # unalign hw stores
// 11  10  0  -   0  0  1 -     ~~~~  ~~~~~~~~  0010   # unalign hw stores byteReverse
// 11  --  1  -   0  -  0 -     ~~~~  ~~~~~~~~  0111   # unalign word, multiple stores
// 11  --  1  -   0  -  1 -     ~~~~  ~~~~~~~~  1110   # unalign word, multiple stores (byteReverse)
// 11  1-  -  0   1  -  - -     ~~~~  ~~~~~~~~  0111   # C0, count >= 2, string
// 11  --  1  -   1  -  - -     ~~~~  ~~~~~~~~  0111   # C1, count >= 4, string
module p405s_dcu_stSteerPla (
                          stMuxSel,
                          stSteerMuxSel,
                          stAdjE1,
                          mea,
                          byteCount,
                          cntGtEq4,
                          storageSt,
                          string,
                          multiple,
                          byteRev,
                          byteRev2
                        );

output [0:3] stMuxSel;
output [0:7] stSteerMuxSel;
output [0:3] stAdjE1;

input [0:1] mea;
input [6:7] byteCount;
input  cntGtEq4;
input  storageSt;
input  string;
input  multiple;
input  byteRev;
input  byteRev2;

wire [0:1] not_mea;
wire [6:7] not_byteCount;
wire  not_cntGtEq4;
wire  not_storageSt;
wire  not_string;
wire  not_multiple;
wire  not_byteRev;
wire  not_byteRev2;

wire [0:42] pterm;

assign not_mea[0] = ~mea[0];
assign not_mea[1] = ~mea[1];
assign not_byteCount[6] = ~byteCount[6];
assign not_byteCount[7] = ~byteCount[7];
assign not_cntGtEq4 = ~cntGtEq4;
assign not_storageSt = ~storageSt;
assign not_string = ~string;
assign not_multiple = ~multiple;
assign not_byteRev = ~byteRev;
assign not_byteRev2 = ~byteRev2;

// AND array expressions and reprint of all terms
// <0> -0100000-0 0000101000000000
assign pterm[0] = not_mea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_storageSt & not_string & not_multiple & not_byteRev2;
// <1> -010-000-1 0000110100000000
assign pterm[1] = not_mea[1] & byteCount[6] & not_byteCount[7] & not_storageSt & 
   not_string & not_multiple & byteRev2;
// <2> 10100----0 0000101000000000
assign pterm[2] = mea[0] & not_mea[1] & byteCount[6] & not_byteCount[7] & 
   not_cntGtEq4 & not_byteRev2;
// <3> -1010-00-0 0000110000000000
assign pterm[3] = mea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_string & not_multiple & not_byteRev2;
// <4> 11-1010--1 0000100010000000
assign pterm[4] = mea[0] & mea[1] & byteCount[7] & not_cntGtEq4 & storageSt & 
   not_string & byteRev2;
// <5> 0110-0---1 0000001000000000
assign pterm[5] = not_mea[0] & mea[1] & byteCount[6] & not_byteCount[7] & 
   not_storageSt & byteRev2;
// <6> 11-101---0 0000010101000000
assign pterm[6] = mea[0] & mea[1] & byteCount[7] & not_cntGtEq4 & storageSt & 
   not_byteRev2;
// <7> -1100000-0 0000000101110000
assign pterm[7] = mea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_storageSt & not_string & not_multiple & not_byteRev2;
// <8> 1110--001- 0000000000000010
assign pterm[8] = mea[0] & mea[1] & byteCount[6] & not_byteCount[7] & not_string & 
   not_multiple & byteRev;
// <9> 1110--000- 0000000000000001
assign pterm[9] = mea[0] & mea[1] & byteCount[6] & not_byteCount[7] & not_string & 
   not_multiple & not_byteRev;
//<10> 10--10---0 0000000010100000
assign pterm[10] = mea[0] & not_mea[1] & cntGtEq4 & not_storageSt & not_byteRev2;
// <11> 10100-00-1 0000011101110000
assign pterm[11] = mea[0] & not_mea[1] & byteCount[6] & not_byteCount[7] & 
   not_cntGtEq4 & not_string & not_multiple & byteRev2;
// <12> 101100---- 0000000000000011
assign pterm[12] = mea[0] & not_mea[1] & byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_storageSt;
// <13> 10--100--1 0000000001110000
assign pterm[13] = mea[0] & not_mea[1] & cntGtEq4 & not_storageSt & not_string & 
   byteRev2;
// <14> --010000-- 0000111001000000
assign pterm[14] = not_byteCount[6] & byteCount[7] & not_cntGtEq4 & not_storageSt & 
   not_string & not_multiple;
// <15> -1--1000-0 0000000111010000
assign pterm[15] = mea[1] & cntGtEq4 & not_storageSt & not_string & not_multiple & 
   not_byteRev2;
// <16> 111--01--- 0000000000000111
assign pterm[16] = mea[0] & mea[1] & byteCount[6] & not_storageSt & string;
// <17> 01--10---- 0000001000100000
assign pterm[17] = not_mea[0] & mea[1] & cntGtEq4 & not_storageSt;
// <18> 00--100--1 0000110111010000
//and(pterm[18],not_mea[0],not_mea[1],cntGtEq4,not_storageSt,not_string,
//   byteRev2);
assign pterm[18] = not_mea[0] & not_mea[1] & cntGtEq4 & not_string & 
   byteRev2;
// <19> -1---11--- 0001000000000000
assign pterm[19] = mea[1] & storageSt & string;
// <20> -1---10-1- 1000000000000000
assign pterm[20] = mea[1] & storageSt & not_string & byteRev;
// <21> 1----10-1- 1100000000000000
assign pterm[21] = mea[0] & storageSt & not_string & byteRev;
// <22> -1--1-0-1- 0000000000001000
assign pterm[22] = mea[1] & cntGtEq4 & not_string & byteRev;
// <23> 1---1-0-1- 0000000000001100
assign pterm[23] = mea[0] & cntGtEq4 & not_string & byteRev;
// <24> 1---1-1--- 0000000000000011
assign pterm[24] = mea[0] & cntGtEq4 & string;
// <25> 01-----1-0 0000100010000000
assign pterm[25] = not_mea[0] & mea[1] & multiple & not_byteRev2;
// <26> 11-----1-1 0000100010000000
assign pterm[26] = mea[0] & mea[1] & multiple & byteRev2;
// <27> -1---1--0- 0001000000000000
assign pterm[27] = mea[1] & storageSt & not_byteRev;
// <28> 1----1--0- 0011000000000000
assign pterm[28] = mea[0] & storageSt & not_byteRev;
// <29> 1----11--- 0011000000000000
assign pterm[29] = mea[0] & storageSt & string;
// <30> -1--1---0- 0000000000000001
assign pterm[30] = mea[1] & cntGtEq4 & not_byteRev;
// <31> -1--1-1--- 0000000000000001
assign pterm[31] = mea[1] & cntGtEq4 & string;
// <32> 1---1---0- 0000000000000011
assign pterm[32] = mea[0] & cntGtEq4 & not_byteRev;
// <33> 10-----1-0 0000101010100000
assign pterm[33] = mea[0] & not_mea[1] & multiple & not_byteRev2;
// <34> 00-----1-1 0000110111010000
assign pterm[34] = not_mea[0] & not_mea[1] & multiple & byteRev2;
// <35> 11---1---- 0110000000000000
assign pterm[35] = mea[0] & mea[1] & storageSt;
// <36> 01-----1-- 0000001000100000
assign pterm[36] = not_mea[0] & mea[1] & multiple;
// <37> 11--1----- 0000000000000110
assign pterm[37] = mea[0] & mea[1] & cntGtEq4;
// <38> 10-----1-1 0000011101110000
assign pterm[38] = mea[0] & not_mea[1] & multiple & byteRev2;
// <39> -1-----1-0 0000010101010000
assign pterm[39] = mea[1] & multiple & not_byteRev2;
// <40> 01----1--- 0000101010100000
assign pterm[40] = not_mea[0] & mea[1] & string;
// <41> 10----1--- 0000101010100000
assign pterm[41] = mea[0] & not_mea[1] & string;
// <42> -1----1--- 0000010101010000
assign pterm[42] = mea[1] & string;

// OR array expressions
assign stMuxSel[0] = pterm[20] | pterm[21];
assign stMuxSel[1] = pterm[21] | pterm[35];
assign stMuxSel[2] = pterm[28] | pterm[29] | pterm[35];
assign stMuxSel[3] = pterm[19] | pterm[27] | pterm[28] | pterm[29];
assign stSteerMuxSel[0] = pterm[0] | pterm[1] | pterm[2] | pterm[3] | pterm[4] | 
   pterm[14] | pterm[18] | pterm[25] | pterm[26] | pterm[33] | pterm[34] | pterm[40] | 
   pterm[41];
assign stSteerMuxSel[1] = pterm[1] | pterm[3] | pterm[6] | pterm[11] | pterm[14] | 
   pterm[18] | pterm[34] | pterm[38] | pterm[39] | pterm[42];
assign stSteerMuxSel[2] = pterm[0] | pterm[2] | pterm[5] | pterm[11] | pterm[14] | 
   pterm[17] | pterm[33] | pterm[36] | pterm[38] | pterm[40] | pterm[41];
assign stSteerMuxSel[3] = pterm[1] | pterm[6] | pterm[7] | pterm[11] | pterm[15] | 
   pterm[18] | pterm[34] | pterm[38] | pterm[39] | pterm[42];
assign stSteerMuxSel[4] = pterm[4] | pterm[10] | pterm[15] | pterm[18] | pterm[25] | 
   pterm[26] | pterm[33] | pterm[34] | pterm[40] | pterm[41];
assign stSteerMuxSel[5] = pterm[6] | pterm[7] | pterm[11] | pterm[13] | pterm[14] | 
   pterm[15] | pterm[18] | pterm[34] | pterm[38] | pterm[39] | pterm[42];
assign stSteerMuxSel[6] = pterm[7] | pterm[10] | pterm[11] | pterm[13] | pterm[17] | 
   pterm[33] | pterm[36] | pterm[38] | pterm[40] | pterm[41];
assign stSteerMuxSel[7] = pterm[7] | pterm[11] | pterm[13] | pterm[15] | pterm[18] | 
   pterm[34] | pterm[38] | pterm[39] | pterm[42];
assign stAdjE1[0] = pterm[22] | pterm[23];
assign stAdjE1[1] = pterm[16] | pterm[23] | pterm[37];
assign stAdjE1[2] = pterm[8] | pterm[12] | pterm[16] | pterm[24] | pterm[32] | 
   pterm[37];
assign stAdjE1[3] = pterm[9] | pterm[12] | pterm[16] | pterm[24] | pterm[30] | pterm[31] | 
   pterm[32];

endmodule
