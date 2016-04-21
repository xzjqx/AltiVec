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
//  from espresso format file on Mon Mar  8 16:19:22 EST 1999
// modulename is divSM
// input file is divSM.pers
// output file is divSM.v
// espresso will be called.
//
// #############################
// #                           #
// #  divide State Machine     #
// #                           #
// #############################
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
// #
// ######################################################################
// ##  Set the input and output port attributes here and map to gates. ##
// ##  See process document for the correct values for your design.    ##
// ######################################################################
// .synopsys set_drive 3.0 all_inputs()
// .synopsys set_max_transition 0.4 all_inputs()
// .synopsys set_load .200 all_outputs()
// #
// #########################################################################
// ##  Set the option to flatten and structure the design. Use the option ##
// ##  single_output for speed optimization, and uncomment the multiple   ##
// ##  output option for area optimization.                               ##
// #########################################################################
// .synopsys set_flatten -minimize single_output -effort medium
// ## .synopsys set_flatten -minimize multiple_output -effort medium
// .synopsys set_structure
// #
// ###########################################################################
// ##  Set the max delay for all output for initial pass.  Set delay for    ##
// ##  your design.  Uncomment and set the other delays if the previous try ##
// ##  does not meet timing.  Replace the <delay> with the needed delay     ##
// ##  timming and replace the PIN with the pin name to delay or set delay  ##
// ##  for multiple outputs. DONT USE BITS OF A BUS USE THE WHOLE BUS.      ##
// ###########################################################################
// .synopsys max_delay 5 all_outputs()
// ##  .synopsys max_delay <delay> find(port {"PIN"})
// ##  .synopsys max_delay <delay> find(port {"PIN"})
// ##  .synopsys max_delay <delay> find(port {"PIN1" "PIN2" "PIN3" ... })
// #
// ######################################################################
// ##  To compile for minimal area uncomment max_area 0 and change the ##
// ##  max_delay 15 all_outputs() to max_delay 30 all_outputs()        ##
// ######################################################################
// ##  .synopsys max_area 0
// #
// ################################################################
// ##  Set the arrival time for any input pins that may be late  ##
// ################################################################
// ## .synopsys set_arrival 12 PAGE_END - late arriving signal
// ## .synopsys set_arrival 12 HOLD - late arriving signal
// #
// ####################################################################
// ## The complile option is set to medium to optimize the design.   ##
// ####################################################################
// .synopsys compile -map_effort medium
// ##
// #
// .outputnames nxtDivSt[0:5] divStE1 nxtLastStOrSt0 nxtSt0Or1 nxtSt1
// .inputnames  resetL2 divideEn pState[0:5]
// .type fd
// .i 8
// .o 10
// #
// #History:
// # 02/13/98 SBP Copied from 401.
// #
// #Notes:
// # State machine is for divide. Divide takes 35 cycles
// #
// #
// #
// # INPUTS ********************************************************************************
// #resetL2
// # divideEn
// # | pState[0:5]
// # | |      OUTPUTS ***************************
// # | |      *  nxtDivSt[0:5]
// # | |      *  |      divStE1
// # | |      *  |      | nxtLastStOrSt0
// # | |      *  |      | | nxtSt0or1
// # | |      *  |      | | | nxtSt1
// # | |      *  |      | | | |
// # - ------ *  ------ - - - -
// # ================================================================================
// # Reset puts state machininine in idle.
// # ================================================================================
// 1 - ------    000000 1 1 1 ~  # reset to idle.
// - 0 ------    000000 ~ 1 1 ~  # reset to idle.
// - 1 ------    ~~~~~~ 1 ~ ~ ~  # Turn on divStE1.
// - - -----1    ~~~~~~ 1 ~ ~ ~  # Interrupted divide should
// - - ----1-    ~~~~~~ 1 ~ ~ ~  # go back to idle state.
// - - ---1--    ~~~~~~ 1 ~ ~ ~  #
// - - --1---    ~~~~~~ 1 ~ ~ ~  #
// - - -1----    ~~~~~~ 1 ~ ~ ~  #
// - - 1-----    ~~~~~~ 1 ~ ~ ~  #
// # ================================================================================
// # State Machine gray codededed to save gates and power.
// # ================================================================================
// 0 1 000000    000001 ~ ~ 1 1  # state0  to state1
// 0 1 000001    000011 ~ ~ ~ ~  # state1  to state2
// 0 1 000011    000010 ~ ~ ~ ~  # state2  to state3
// 0 1 000010    000110 ~ ~ ~ ~  # state3  to state4
// 0 1 000110    000111 ~ ~ ~ ~  # state4  to state5
// 0 1 000111    000101 ~ ~ ~ ~  # state5  to state6
// 0 1 000101    000100 ~ ~ ~ ~  # state6  to state7
// 0 1 000100    001100 ~ ~ ~ ~  # state7  to state8
// 0 1 001100    001101 ~ ~ ~ ~  # state8  to state9
// 0 1 001101    001111 ~ ~ ~ ~  # state9  to state10
// 0 1 001111    001110 ~ ~ ~ ~  # state10 to state11
// 0 1 001110    001010 ~ ~ ~ ~  # state11 to state12
// 0 1 001010    001011 ~ ~ ~ ~  # state12 to state13
// 0 1 001011    001001 ~ ~ ~ ~  # state13 to state14
// 0 1 001001    001000 ~ ~ ~ ~  # state14 to state15
// 0 1 001000    011000 ~ ~ ~ ~  # state15 to state16
// 0 1 011000    011001 ~ ~ ~ ~  # state16 to state17
// 0 1 011001    011011 ~ ~ ~ ~  # state17 to state18
// 0 1 011011    011010 ~ ~ ~ ~  # state18 to state19
// 0 1 011010    011110 ~ ~ ~ ~  # state19 to state20
// 0 1 011110    011111 ~ ~ ~ ~  # state20 to state21
// 0 1 011111    011101 ~ ~ ~ ~  # state21 to state22
// 0 1 011101    011100 ~ ~ ~ ~  # state22 to state23
// 0 1 011100    010100 ~ ~ ~ ~  # state23 to state24
// 0 1 010100    010101 ~ ~ ~ ~  # state24 to state25
// 0 1 010101    010111 ~ ~ ~ ~  # state25 to state26
// 0 1 010111    010110 ~ ~ ~ ~  # state26 to state27
// 0 1 010110    010010 ~ ~ ~ ~  # state27 to state28
// 0 1 010010    010011 ~ ~ ~ ~  # state28 to state29
// 0 1 010011    010001 ~ ~ ~ ~  # state29 to state30
// 0 1 010001    010000 ~ ~ ~ ~  # state30 to state31
// 0 1 010000    110000 ~ ~ ~ ~  # state31 to state32
// 0 1 110000    100001 ~ ~ ~ ~  # state32 to nxtToLastState
// 0 1 100001    100000 ~ 1 ~ ~  # nxtToLastState to lastState
// 0 1 100000    000000 ~ 1 1 ~  # lastState to state0
module p405s_divSM (
nxtDivSt,
divStE1,
nxtLastStOrSt0,
nxtSt0Or1,
nxtSt1,
resetL2,
divideEn,
pState);

output [0:5] nxtDivSt;
output  divStE1;
output  nxtLastStOrSt0;
output  nxtSt0Or1;
output  nxtSt1;

input  resetL2;
input  divideEn;
input [0:5] pState;

wire  not_resetL2;
wire  not_divideEn;
wire [0:5] not_pState;

wire [0:32] pterm;

//not(not_resetL2,resetL2);
assign not_resetL2 = ~resetL2;
//not(not_divideEn,divideEn);
assign not_divideEn = ~divideEn;
//not(not_pState[0],pState[0]);
//not(not_pState[1],pState[1]);
//not(not_pState[2],pState[2]);
//not(not_pState[3],pState[3]);
//not(not_pState[4],pState[4]);
//not(not_pState[5],pState[5]);
assign not_pState = ~(pState);

// AND array expressions and reprint of all terms
// <0> 01100001 1000000100
//and(pterm[0],not_resetL2,divideEn,pState[0],not_pState[1],not_pState[2],
//   not_pState[3],not_pState[4],pState[5]);
assign pterm[0] = (not_resetL2 & divideEn & pState[0] & not_pState[1] & not_pState[2] & not_pState[3] & not_pState[4] & pState[5]);
// <1> 01110000 0000010000
//and(pterm[1],not_resetL2,divideEn,pState[0],pState[1],not_pState[2],
//   not_pState[3],not_pState[4],not_pState[5]);
assign pterm[1] = (not_resetL2 & divideEn & pState[0] & pState[1] & not_pState[2] & not_pState[3] & not_pState[4] & not_pState[5]);
// <2> 01-10000 1000000000
//and(pterm[2],not_resetL2,divideEn,pState[1],not_pState[2],not_pState[3],
//   not_pState[4],not_pState[5]);
assign pterm[2] = (not_resetL2 & divideEn & pState[1] & not_pState[2] & not_pState[3] & not_pState[4] & not_pState[5]);
// <3> --100000 0000001110
//and(pterm[3],pState[0],not_pState[1],not_pState[2],not_pState[3],
//   not_pState[4],not_pState[5]);
assign pterm[3] = (pState[0] & not_pState[1] & not_pState[2] & not_pState[3] & not_pState[4] & not_pState[5]);
// <4> 01000000 0000001011
//and(pterm[4],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   not_pState[2],not_pState[3],not_pState[4],not_pState[5]);
assign pterm[4] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & not_pState[2] & not_pState[3] & not_pState[4] & not_pState[5]);
// <5> 010-1000 0100000000
//and(pterm[5],not_resetL2,divideEn,not_pState[0],pState[2],not_pState[3],
//   not_pState[4],not_pState[5]);
assign pterm[5] = (not_resetL2 & divideEn & not_pState[0] & pState[2] & not_pState[3] & not_pState[4] & not_pState[5]);
// <6> 010110-1 0000100000
//and(pterm[6],not_resetL2,divideEn,not_pState[0],pState[1],pState[2],
//   not_pState[3],pState[5]);
assign pterm[6] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & pState[2] & not_pState[3] & pState[5]);
// <7> 0100-100 0010000000
//and(pterm[7],not_resetL2,divideEn,not_pState[0],not_pState[1],pState[3],
//   not_pState[4],not_pState[5]);
assign pterm[7] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & pState[3] & not_pState[4] & not_pState[5]);
// <8> 01000-10 0001000000
//and(pterm[8],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   not_pState[2],pState[4],not_pState[5]);
assign pterm[8] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & not_pState[2] & pState[4] & not_pState[5]); 
// <9> 010000-1 0000100000
//and(pterm[9],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   not_pState[2],not_pState[3],pState[5]);
assign pterm[9] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & not_pState[2] & not_pState[3] & pState[5]);
// <10> 01011-10 0011000000
//and(pterm[10],not_resetL2,divideEn,not_pState[0],pState[1],pState[2],
//   pState[4],not_pState[5]);
assign pterm[10] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & pState[2] & pState[4] & not_pState[5]);
// <11> 010101-1 0001100000
//and(pterm[11],not_resetL2,divideEn,not_pState[0],pState[1],not_pState[2],
//   pState[3],pState[5]);
assign pterm[11] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & not_pState[2] & pState[3] & pState[5]);
// <12> 010011-1 0001100000
//and(pterm[12],not_resetL2,divideEn,not_pState[0],not_pState[1],pState[2],
//   pState[3],pState[5]);
assign pterm[12] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & pState[2] & pState[3] & pState[5]);
// <13> 0101001- 0000010000
//and(pterm[13],not_resetL2,divideEn,not_pState[0],pState[1],not_pState[2],
//   not_pState[3],pState[4]);
assign pterm[13] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & not_pState[2] & not_pState[3] & pState[4]);
// <14> 0100101- 0000010000
//and(pterm[14],not_resetL2,divideEn,not_pState[0],not_pState[1],pState[2],
//   not_pState[3],pState[4]);
assign pterm[14] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & pState[2] & not_pState[3] & pState[4]);
// <15> 0101010- 0000010000
//and(pterm[15],not_resetL2,divideEn,not_pState[0],pState[1],not_pState[2],
//   pState[3],not_pState[4]);
assign pterm[15] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & not_pState[2] & pState[3] & not_pState[4]);
// <16> 0100110- 0000010000
//and(pterm[16],not_resetL2,divideEn,not_pState[0],not_pState[1],pState[2],
//   pState[3],not_pState[4]);
assign pterm[16] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & pState[2] & pState[3] & not_pState[4]);
// <17> 0101111- 0001010000
//and(pterm[17],not_resetL2,divideEn,not_pState[0],pState[1],pState[2],
//   pState[3],pState[4]);
assign pterm[17] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & pState[2] & pState[3] & pState[4]);
// <18> 0100000- 0000010000
//and(pterm[18],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   not_pState[2],not_pState[3],not_pState[4]);
assign pterm[18] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & not_pState[2] & not_pState[3] & not_pState[4]);
// <19> 0100011- 0001010000
//and(pterm[19],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   not_pState[2],pState[3],pState[4]);
assign pterm[19] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & not_pState[2] & pState[3] & pState[4]);
// <20> 0101100- 0010010000
//and(pterm[20],not_resetL2,divideEn,not_pState[0],pState[1],pState[2],
//   not_pState[3],not_pState[4]);
assign pterm[20] = (not_resetL2 & divideEn & not_pState[0] & pState[1] & pState[2] & not_pState[3] & not_pState[4]);
// <21> 010---10 0000100000
//and(pterm[21],not_resetL2,divideEn,not_pState[0],pState[4],
//   not_pState[5]);
assign pterm[21] = (not_resetL2 & divideEn & not_pState[0] & pState[4] & not_pState[5]);
// <22> 010-1--1 0010000000
//and(pterm[22],not_resetL2,divideEn,not_pState[0],pState[2],pState[5]);
assign pterm[22] = (not_resetL2 & divideEn & not_pState[0] & pState[2] & pState[5]);
// <23> 01001--- 0010000000
//and(pterm[23],not_resetL2,divideEn,not_pState[0],not_pState[1],
//   pState[2]);
assign pterm[23] = (not_resetL2 & divideEn & not_pState[0] & not_pState[1] & pState[2]);
// <24> 010--10- 0001000000
//and(pterm[24],not_resetL2,divideEn,not_pState[0],pState[3],
//   not_pState[4]);
assign pterm[24] = (not_resetL2 & divideEn & not_pState[0] & pState[3] & not_pState[4]);
// <25> 0101---- 0100000000
//and(pterm[25],not_resetL2,divideEn,not_pState[0],pState[1]);
assign pterm[25] = (not_resetL2 & divideEn & not_pState[0] & pState[1]);
// <26> -0------ 0000000110
//and(pterm[26],not_divideEn);
assign pterm[26] = not_divideEn;
// <27> -------1 0000001000
//and(pterm[27],pState[5]);
assign pterm[27] = pState[5];
// <28> ------1- 0000001000
//and(pterm[28],pState[4]);
assign pterm[28] = pState[4];
// <29> -----1-- 0000001000
//and(pterm[29],pState[3]);
assign pterm[29] = pState[3];
// <30> 1------- 0000001110
//and(pterm[30],resetL2);
assign pterm[30] = resetL2;
// <31> ----1--- 0000001000
//and(pterm[31],pState[2]);
assign pterm[31] = pState[2];
// <32> ---1---- 0000001000
//and(pterm[32],pState[1]);
assign pterm[32] = pState[1];

// OR array expressions
//or(nxtDivSt[0],pterm[0],pterm[2]);
assign nxtDivSt[0] = (pterm[0] | pterm[2]);
//or(nxtDivSt[1],pterm[5],pterm[25]);
assign nxtDivSt[1] = (pterm[5] | pterm[25]);
//or(nxtDivSt[2],pterm[7],pterm[10],pterm[20],pterm[22],pterm[23]);
assign nxtDivSt[2] = (pterm[7] | pterm[10] | pterm[20] | pterm[22] | pterm[23]);
//or(nxtDivSt[3],pterm[8],pterm[10],pterm[11],pterm[12],pterm[17],
//   pterm[19],pterm[24]);
assign nxtDivSt[3] = (pterm[8] | pterm[10] | pterm[11] | pterm[12] | pterm[17] | pterm[19] | pterm[24]);
//or(nxtDivSt[4],pterm[6],pterm[9],pterm[11],pterm[12],pterm[21]);
assign nxtDivSt[4] = (pterm[6] | pterm[9] | pterm[11] | pterm[12] | pterm[21]);
//or(nxtDivSt[5],pterm[1],pterm[13],pterm[14],pterm[15],pterm[16],
//   pterm[17],pterm[18],pterm[19],pterm[20]);
assign nxtDivSt[5] = (pterm[1] | pterm[13]| pterm[14] | pterm[15] | pterm[16] | pterm[17] | pterm[18] | pterm[19] | pterm[20]);
//or(divStE1,pterm[3],pterm[4],pterm[27],pterm[28],pterm[29],pterm[30],
//   pterm[31],pterm[32]);
assign divStE1 = (pterm[3] | pterm[4] | pterm[27] | pterm[28] | pterm[29] | pterm[30] | pterm[31] | pterm[32]);
//or(nxtLastStOrSt0,pterm[0],pterm[3],pterm[26],pterm[30]);
assign nxtLastStOrSt0 = (pterm[0] | pterm[3] | pterm[26] | pterm[30]);
//or(nxtSt0Or1,pterm[3],pterm[4],pterm[26],pterm[30]);
assign nxtSt0Or1 = (pterm[3] | pterm[4] | pterm[26] | pterm[30]);
//or(nxtSt1,pterm[4]);
assign nxtSt1 = pterm[4];

endmodule
