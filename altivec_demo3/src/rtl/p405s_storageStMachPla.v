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
//  from espresso format file on Tue Nov 24 12:55:28 EST 1998
// modulename is storageStMachPla
// input file is storageStMachPla.pers
// output file is storageStMachPla.v
// espresso will be called.
// ############################
// #                          #
// #  Storage State Machine   #
// #                          #
// ############################
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
// .outputnames nxtExeStrgSt[0:2] PCL_addFour
// .inputnames  IFB_exeFlush exeStrgSt[0:2] gtErr strgEnd gtLS exeEaCalc
// .type fd
// .i 8
// .o 4
// #
// #History:
// # 03/01/98 SBP Entered
// # 11/19/98 SBP Removed strgStEn output as not needed in StMach E1 and E2 cntl.
// # 11/24/98 SBP Removed strgEnd output as storageCntlPla completely qualifies that signal.
// #
// # INPUTS ************ Outputs *
// #e
// #x         S
// #e         t     E
// #F         r     A     nxt
// #l exe     g     C     exe  A
// #u Strg    E     a     Strg d
// #s St   gt n  gt l     St   d
// #h 012 Err d  LS C     012  4
// #  ---  -  -  -  -  *  ---  -
// #
// 1  ---  0  -  -  -     000  -  # reset
// # =============================
// 0  000  0  1  -  1     000  ~  # Idle
// 0  000  0  0  -  1     001  ~  # exeC0 -> exeC1
// # =============================
// 0  --1  0  0  0  -     001  ~  # exeC1 -> exeC1
// 0  --1  0  1  -  -     000  ~  # exeC1 -> exeC0
// 0  --1  -  -  1  -     010  ~  # exeC1 -> exeLS
// # =============================
// 0  -1-  -  -  -  -     000  ~  # exeLS -> exeC0
// # =============================
// -  ---  1  -  -  -     100  ~  # exeE0
// # =============================
// -  1--  -  -  -  -     000  ~  # E0 -> exeC0
// # =============================
// 0  000  -  0  -  1     ~~~  1  # Incr EA
// 0  --1  -  0  -  -     ~~~  1
module p405s_storageStMachPla (
nxtExeStrgSt,
PCL_addFour,
IFB_exeFlush,
exeStrgSt,
gtErr,
strgEnd,
gtLS,
exeEaCalc);

output [0:2] nxtExeStrgSt;
output  PCL_addFour;

input  IFB_exeFlush;
input [0:2] exeStrgSt;
input  gtErr;
input  strgEnd;
input  gtLS;
input  exeEaCalc;

wire  not_IFB_exeFlush;
wire [0:2] not_exeStrgSt;
wire  not_gtErr;
wire  not_strgEnd;
wire  not_gtLS;

wire [0:5] pterm;

assign not_IFB_exeFlush = ~(IFB_exeFlush);
assign not_exeStrgSt[0] = ~(exeStrgSt[0]);
assign not_exeStrgSt[1] = ~(exeStrgSt[1]);
assign not_exeStrgSt[2] = ~(exeStrgSt[2]);
assign not_gtErr = ~(gtErr);
assign not_strgEnd = ~(strgEnd);
assign not_gtLS = ~(gtLS);

// AND array expressions and reprint of all terms
// <0> 000000-1 0010
assign pterm[0] = (not_IFB_exeFlush & not_exeStrgSt[0] & not_exeStrgSt[1] & 
   not_exeStrgSt[2] & not_gtErr & not_strgEnd & exeEaCalc);
// <1> 0--1000- 0010
assign pterm[1] = (not_IFB_exeFlush & exeStrgSt[2] & not_gtErr & not_strgEnd & 
   not_gtLS);
// <2> 000--0-1 0001
assign pterm[2] = (not_IFB_exeFlush & not_exeStrgSt[0] & not_exeStrgSt[1] & 
   not_strgEnd & exeEaCalc);
// <3> 0--1--1- 0100
assign pterm[3] = (not_IFB_exeFlush & exeStrgSt[2] & gtLS);
// <4> ----1--- 1000
assign pterm[4] = (gtErr);
// <5> 0--1-0-- 0001
assign pterm[5] = (not_IFB_exeFlush & exeStrgSt[2] & not_strgEnd);

// OR array expressions
assign nxtExeStrgSt[0] = (pterm[4]);
assign nxtExeStrgSt[1] = (pterm[3]);
assign nxtExeStrgSt[2] = (pterm[0] | pterm[1]);
assign PCL_addFour = (pterm[2] | pterm[5]);

endmodule
