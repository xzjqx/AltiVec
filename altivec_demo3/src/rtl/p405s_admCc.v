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
//  from espresso format file on Mon Nov 23 16:32:56 EST 1998
// modulename is admCc
// input file is admCc.pers
// output file is admCc.v
// espresso will be called.
// ######################
// #                    #
// #  adm Cond Code Gen #
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
// .synopsys max_delay 15 all_outputs()
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
// .outputnames admCCbits[0:2] trap
// .inputnames  N_zeroDetect adderOut[0:1] cout
// .inputnames  compInstr trapInstr trapCond[0:4]
// .type fd
// .i 11
// .o 4
// #
// #History:
// # 03/08/98 Copied from maverick.
// #
// #Notes:
// # Traps and compares are interested in A-B but perform B-A. Even unsigned traps perform
// # signed subtract.
// # (Traps don't set CC's,
// # just test what they would be.)
// # INPUTS ********************************************************************************
// #N_zeroDetect
// # adderOut[0:1]
// # |  cout
// # |  | compInstr
// # |  | | trapInstr
// # |  | | | trapCond[0:4]
// # |  | | | |     OUTPUTS ***************************
// # |  | | | |     *  admCCbits[0:2]
// # |  | | | |     *  |   trap
// # -- - - - ----- *  --- -
// #
//
// 0 -- - - - -----    001 ~   # Zero detection.
// # =========================================================================
// - -1 - 0 - -----    100 ~   # Algebraic comparison of result to zero, negLt.
// 1 -0 - 0 - -----    010 ~   # Algebraic comparison of result to zero, posGt.
// # =========================================================================
// 1 0- - 1 - -----    100 ~   # Compare instruction lt.
// - 1- - 1 - -----    010 ~   # Compare instruction gt.
// # =========================================================================
// - -- - - 0 -----    ~~~ 0   # Absence of trap instruction prevents traps.
// - -- - - 1 00000    ~~~ 0   # Nop trap.
// 1 0- - - 1 1----    ~~~ 1   # Trap on: a<b signed case.
// - 1- - - 1 -1---    ~~~ 1   # Trap on: a>b signed case.
// 0 -- - - 1 --1--    ~~~ 1   # Trap on: a=b.
// 1 -- 1 - 1 ---1-    ~~~ 1   # Trap on: a<b unsigned case.
// - -- 0 - 1 ----1    ~~~ 1   # Trap on: a>b unsigned case.
// # =========================================================================
module p405s_admCc (
admCCbits,
trap,
N_zeroDetect,
adderOut,
cout,
compInstr,
trapInstr,
trapCond);

output [0:2] admCCbits;
output  trap;

input  N_zeroDetect;
input [0:1] adderOut;
input  cout;
input  compInstr;
input  trapInstr;
input [0:4] trapCond;

wire  not_N_zeroDetect;
wire [0:1] not_adderOut;
wire  not_cout;
wire  not_compInstr;

wire [0:9] pterm;

//not(not_N_zeroDetect,N_zeroDetect);
assign not_N_zeroDetect = ~N_zeroDetect;
//not(not_adderOut[0],adderOut[0]);
assign not_adderOut[0] = ~adderOut[0];
//not(not_adderOut[1],adderOut[1]);
assign not_adderOut[1] = ~adderOut[1];
//not(not_cout,cout);
assign not_cout = ~cout;
//not(not_compInstr,compInstr);
assign not_compInstr = ~compInstr;

// AND array expressions and reprint of all terms
// <0> 1--1-1---1- 0001
//and(pterm[0],N_zeroDetect,cout,trapInstr,trapCond[3]);
assign pterm[0] = (N_zeroDetect & cout & trapInstr & trapCond[3]);
// <1> 10---11---- 0001
//and(pterm[1],N_zeroDetect,not_adderOut[0],trapInstr,trapCond[0]);
assign pterm[1] = (N_zeroDetect & not_adderOut[0] & trapInstr & trapCond[0]);
// <2> 1-0-0------ 0100
//and(pterm[2],N_zeroDetect,not_adderOut[1],not_compInstr);
assign pterm[2] = (N_zeroDetect & not_adderOut[1] & not_compInstr);
// <3> 10--1------ 1000
//and(pterm[3],N_zeroDetect,not_adderOut[0],compInstr);
assign pterm[3] = (N_zeroDetect & not_adderOut[0] & compInstr);
// <4> ---0-1----1 0001
//and(pterm[4],not_cout,trapInstr,trapCond[4]);
assign pterm[4] = (not_cout & trapInstr & trapCond[4]);
// <5> 0----1--1-- 0001
//and(pterm[5],not_N_zeroDetect,trapInstr,trapCond[2]);
assign pterm[5] = (not_N_zeroDetect & trapInstr & trapCond[2]);
// <6> -1---1-1--- 0001
//and(pterm[6],adderOut[0],trapInstr,trapCond[1]);
assign pterm[6] = (adderOut[0] & trapInstr & trapCond[1]);
// <7> --1-0------ 1000
//and(pterm[7],adderOut[1],not_compInstr);
assign pterm[7] = (adderOut[1] & not_compInstr);
// <8> -1--1------ 0100
//and(pterm[8],adderOut[0],compInstr);
assign pterm[8] = (adderOut[0] & compInstr);
// <9> 0---------- 0010
//and(pterm[9],not_N_zeroDetect);
assign pterm[9] = (not_N_zeroDetect);

// OR array expressions
//or(admCCbits[0],pterm[3],pterm[7]);
assign admCCbits[0] = (pterm[3] | pterm[7]);
//or(admCCbits[1],pterm[2],pterm[8]);
assign admCCbits[1] = (pterm[2] | pterm[8]);
//or(admCCbits[2],pterm[9]);
assign admCCbits[2] = pterm[9];
//or(trap,pterm[0],pterm[1],pterm[4],pterm[5],pterm[6]);
assign trap = (pterm[0] | pterm[1] | pterm[4] | pterm[5] | pterm[6]);

endmodule
