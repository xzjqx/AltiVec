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
//  from espresso format file on Wed Dec  2 14:09:27 EST 1998
// modulename is multSM
// input file is multSM.pers
// output file is multSM.v
// espresso will be called.
//
// #############################
// #                           #
// #  Multiply state Machine   #
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
// .outputnames nxtMultSt[0:1] multStE1
// .inputnames  resetL2 multEn multMCO multSt[0:1]
// .type fd
// .i 5
// .o 3
// #
// #History:
// # 03/05/98 SBP Copied from 401.
// #
// #Notes:
// # State machine is for multiply.
// #
// #
// # INPUTS ********************************************************************************
// #resetL2
// # multEn
// # | multMCO
// # | | multSt[0:1]
// # | | |  OUTPUTS ***************************
// # | | |  *  nxtMultSt[0:1]
// # | | |  *  |  multStE1
// # | | |  *  |  |
// # - - -- *  -- -
// # MultStE1
// 1 - - --    ~~ 1  # reset to idle.
// - 1 - --    ~~ 1  # Turn on multStE1 if multEn.
// - - - -1    ~~ 1  # Interrupted mult should
// - - - 1-    ~~ 1  # go back to idle state.
// # nxtMultSt
// 1 - - --    00 ~  # reset to idle.
// - 0 - --    00 ~  # No multEn, go to idle.
// - 1 0 --    00 ~  # Last mult cycle, go to idle.
// 0 1 1 00    01 ~  # state0  to state1
// 0 1 1 01    11 ~  # state1  to state3
// 0 1 1 11    10 ~  # state3  to state2
// - - - 10    00 ~  # state2  to state0
module p405s_multSM (
nxtMultSt,
multStE1,
resetL2,
multEn,
multMCO,
multSt);

output [0:1] nxtMultSt;
output  multStE1;

input  resetL2;
input  multEn;
input  multMCO;
input [0:1] multSt;

wire  not_resetL2;
wire not_multSt;

wire [0:5] pterm;

//not(not_resetL2,resetL2);
assign not_resetL2 = ~resetL2;
//not(not_multSt,multSt[0]);
assign not_multSt = ~multSt[0];

// AND array expressions and reprint of all terms
// <0> 0110- 010
//and(pterm[0],not_resetL2,multEn,multMCO,not_multSt);
assign pterm[0] = (not_resetL2 & multEn & multMCO & not_multSt);
// <1> 011-1 100
//and(pterm[1],not_resetL2,multEn,multMCO,multSt[1]);
assign pterm[1] = (not_resetL2 & multEn & multMCO & multSt[1]);
// <2> ---1- 001
//and(pterm[2],multSt[0]);
assign pterm[2] = multSt[0];
// <3> 1---- 001
//and(pterm[3],resetL2);
assign pterm[3] = resetL2;
// <4> ----1 001
//and(pterm[4],multSt[1]);
assign pterm[4] = multSt[1];
// <5> -1--- 001
//and(pterm[5],multEn);
assign pterm[5] = multEn;

// OR array expressions
//or(nxtMultSt[0],pterm[1]);
assign nxtMultSt[0] = pterm[1];
//or(nxtMultSt[1],pterm[0]);
assign nxtMultSt[1] = pterm[0];
//or(multStE1,pterm[2],pterm[3],pterm[4],pterm[5]);
assign multStE1 = (pterm[2] | pterm[3] | pterm[4] | pterm[5]);

endmodule
