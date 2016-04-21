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
// Verilog HDL for "PR_mmu", "BIST_Control" "_functional"

module p405s_mmu_BIST_Control ( BIST_StateIn,
                      BIST_wrEn,
                      BIST_rdEn,
                      BIST_lookupEn,
                      BIST_invalidate,
                      BIST_data,
                      BIST_addr,
                      decrementIn,
                      BIST_V,
                      iterIn,
                      ABIST_test,
                      EPN_EA_Sel,
                      EPN_EA_Tid_Sel,
                      DSize_DT_Sel,
                      rotate_cntl,
                      tagError,
                      dataError,
                      cbistError,
                      cntZeroIn,
                      cntDoneIn,
                      lookup1_cntDoneIn,
                      LSSD_ArrayCClk_buf,
                      DVS,
                      stop_evs,
                      BIST_Done,
                      BIST_StateL2,
                      TestM1,
                      decrementL2,
                      addrL2,
                      modeL2,
                      iterL2,
                      UTLB_Miss,
                      UTLB_index,
                      tagComp,
                      dataComp,
                      cntZeroL2,
                      cntDoneL2,
                      lookup1_cntDoneL2,
                      LSSD_EVS
                    );

// **********************************************************************************
// Input and Output declarations
// **********************************************************************************
output [0:3] BIST_StateIn;
output       BIST_wrEn;
output       BIST_rdEn;
output       BIST_lookupEn;
output       BIST_invalidate;
output [0:1] BIST_data;
output [0:5] BIST_addr;
output [0:1] iterIn;
output       decrementIn;
output       BIST_V;
output [0:1] EPN_EA_Sel;
output [0:1] EPN_EA_Tid_Sel;
output [0:1] DSize_DT_Sel;
output       rotate_cntl;
//output       MMU_diagOut;
output       tagError;
output       dataError;
output       cbistError;
output       ABIST_test;
//output       ABIST_stuffE2;
//output       UTLB_clocks_off;
output       DVS;
/*output       inc_dec_addr;*/
/*output       reset_to_zero;*/
/*output       states_invert;*/
output       cntZeroIn;            // Count is zero
output       cntDoneIn;            // Count is finished
output       lookup1_cntDoneIn;
//output       invertIn;
output       stop_evs;
output       BIST_Done;
output       LSSD_ArrayCClk_buf;

input  [0:3]  BIST_StateL2;
input         TestM1;
input         decrementL2;
input  [0:5]  addrL2;
input  [0:1]  modeL2;
input  [0:1]  iterL2;
input  [0:5]  UTLB_index;
input         UTLB_Miss;
input         tagComp;
input         dataComp;

input         cntZeroL2;
input         cntDoneL2;
input         lookup1_cntDoneL2;
input         LSSD_EVS;
//put         EVS_gateoffL2;
//input         EVS_L2;
//input         EVS2_L2;
//input         invertL2;

// **********************************************************************************
// Wire and Register declaration
// **********************************************************************************
//wire       cntZero;            // Count is zero
//wire       cntDone;            // Count is finished
//wire       lookup1_cntDone;
wire       inc_iter;           // increment the iteration register
wire       invert;             // invert the data
wire       inc_dec_addr;       // increment/decrement the address
wire       reset_addr;         // reset the address register
wire       set_dec;            // set the decrement register
wire       reset_dec;          // reset the decrement register
wire       start, write0, read0, comp0, write1, read1, comp1, write2, lookup1;
wire       write3, lookup2, write4, write5, inval, lookup3, done;
wire       ABIST_test_i;

wire       read0In;
wire       comp0In;
wire       write1In;
wire       read1In;
wire       comp1In;
wire       lookup1In;

wire       walkError;
wire       matchError;
wire       invalidateError;
wire       encoderMiscompare;
wire       allMatchDisableError;

reg        BIST_wrEn;
reg        BIST_lookupEn;
reg [0:1]  iterIn_i;

reg  [0:3] BIST_StateIn_i;
wire [0:1] BIST_data_i;
wire [0:5] BIST_addr_i;
wire       lookup1_cntDoneIn_i;
wire       stop_evs_i;


  // Assign outputs so we dont read from them
  assign BIST_StateIn = BIST_StateIn_i;
  assign BIST_data = BIST_data_i;
  assign BIST_addr = BIST_addr_i;
  assign iterIn = iterIn_i;
  assign ABIST_test = ABIST_test_i;
  assign lookup1_cntDoneIn = lookup1_cntDoneIn_i;
  assign stop_evs = stop_evs_i;


// **********************************************************************************
// state definition
// **********************************************************************************

assign start    =  BIST_StateL2 == 4'b0000;
assign write0   =  BIST_StateL2 == 4'b0001;
assign read0    =  BIST_StateL2 == 4'b0010;
assign comp0    =  BIST_StateL2 == 4'b0011;
assign write1   =  BIST_StateL2 == 4'b0100;
assign read1    =  BIST_StateL2 == 4'b0101;
assign comp1    =  BIST_StateL2 == 4'b0110;

assign write2   =  BIST_StateL2 == 4'b0111;
assign lookup1  =  BIST_StateL2 == 4'b1100;
assign write3   =  BIST_StateL2 == 4'b1001;
assign lookup2  =  BIST_StateL2 == 4'b1010;
assign write4   =  BIST_StateL2 == 4'b1011;
assign write5   =  BIST_StateL2 == 4'b1000;
assign inval    =  BIST_StateL2 == 4'b1101;
assign lookup3  =  BIST_StateL2 == 4'b1110;
assign done     =  BIST_StateL2 == 4'b1111;

assign read0In    =  BIST_StateIn_i == 4'b0010;
assign comp0In    =  BIST_StateIn_i == 4'b0011;
assign write1In   =  BIST_StateIn_i == 4'b0100;
assign read1In    =  BIST_StateIn_i == 4'b0101;
assign comp1In    =  BIST_StateIn_i == 4'b0110;
assign lookup1In  =  BIST_StateIn_i == 4'b1100;


//latch for timing
//assign cntZero   = ~|addrL2[0:5];    // Address   == 6'b000000 (0)
//assign cntDone   =  lookup1 ? lookup1_cntDone : &addrL2[0:5]; // Address == 6'b111111 (63)
//assign lookup1_cntDone = addrL2[0:5] == 6'b011101;

assign cntZeroIn   = ~|BIST_addr_i[0:5];    // Address   == 6'b000000 (0)
assign cntDoneIn   =  lookup1In ? lookup1_cntDoneIn_i : &BIST_addr_i[0:5]; // Address == 6'b111111 (63)
assign lookup1_cntDoneIn_i = BIST_addr_i[0:5] == 6'b011101;


// qualified state start because it was causing testcomp to be
// high when it shouldn't be. (ISSUE #130)
//assign ABIST_test = start | write0 | read0 | comp0 | write1 | read1 |
//                     (comp1 & ~(cntZero & decrementL2 & iterL2[0] & ~iterL2[1]));

assign ABIST_test_i = (start & TestM1) | write0 | read0 | comp0 | write1 | read1 |
                     (comp1 & ~(cntZeroL2 & decrementL2 & iterL2[0] & ~iterL2[1]));

//assign rotate_cntl = write2 & cntDone;
assign rotate_cntl = write2 & cntDoneL2;

// Delay these error because of glitch due to signal change
// Read them the next cycle they are still valid
//assign matchError           = lookup2 & UTLB_Miss;
//assign encoderMiscompare    = lookup2 & (UTLB_index[0:5] != addrL2[0:5]);
//assign allMatchDisableError = lookup2 & iterL2[0] & UTLB_Miss;
//assign invalidateError      = lookup3 & ~UTLB_Miss;

assign walkError            = lookup1 & ~UTLB_Miss;
assign matchError           = write4  & UTLB_Miss;
assign encoderMiscompare    = write4  & (UTLB_index[0:5] != addrL2[0:5]);
assign allMatchDisableError = write4  & iterL2[0] & UTLB_Miss;
assign invalidateError      = lookup3 & iterL2[1] & ~UTLB_Miss;

//assign tagError             = (comp0 | comp1) & ~tagComp ;
//assign dataError            = (comp0 | comp1) & ~dataComp;
// Test Comp occurs while we are in the read state so the errors are too be latched
// in the same state
assign tagError             = (read0 | read1) & ~tagComp ;
assign dataError            = (read0 | read1) & ~dataComp;
assign cbistError           = walkError | matchError | encoderMiscompare |
                              allMatchDisableError  | invalidateError;


// **********************************************************************************
//  Mux Select for data written to the tag
//  00 rotate data
//  01 ABIST test -- dataIn used
//  10 write ones
//  11 write zeros
// **********************************************************************************
assign EPN_EA_Sel[0]     = ~ABIST_test_i & (~lookup1 | (lookup1 & lookup1_cntDoneL2));

assign EPN_EA_Sel[1]     = ABIST_test_i | (lookup1 & lookup1_cntDoneL2 & iterIn_i[0]) |
                           (write2 & iterIn_i[0]) | (lookup2 & iterL2[1]) |
                           (write5 & cntDoneL2) | (write3 & iterL2[0]) |
                           (write4 & iterL2[0]);

assign EPN_EA_Tid_Sel[0] = ~ABIST_test_i & (~lookup1 | (lookup1 & lookup1_cntDoneL2));

assign EPN_EA_Tid_Sel[1] = ABIST_test_i | (lookup1 & lookup1_cntDoneL2 & iterIn_i[0]) |
                           (write2 & iterIn_i[0]) | (lookup2 & iterL2[1]) |
                           (write5 & cntDoneL2) | (write4 & iterL2[0]);

assign DSize_DT_Sel[0]  = ABIST_test_i ;
assign DSize_DT_Sel[1]  = BIST_StateL2[0] & ~BIST_StateL2[1] & iterIn_i[0];


// **********************************************************************************
// inc_dec_addr == 0 : pass value
// inc_dec_addr == 1 : inc or dec address
// **********************************************************************************
//assign inc_dec_addr = (comp1 & ((decrementL2 & ~cntZero) | (~decrementL2 & ~cntDone))) |
//                      write0 | write2 | lookup1 | write4 | write5;
assign inc_dec_addr = (comp1 & ((decrementL2 & ~cntZeroL2) | (~decrementL2 & ~cntDoneL2))) |
                      write0 | write2 | lookup1 | write4 | write5;

// **********************************************************************************
// Invert is used to invert the data going to the UTLB
// Primarily useful for getting the checkerboard pattern in.
// Only used in ABIST portion of the testing
// signal valid the cycle before the state is entered since the UTLB latches the data
// **********************************************************************************
//assign invert = (~decrementL2 & (comp0 | write1 | read1 | (comp1 & cntDone) )) |
//                ( decrementL2 & (read0 | (comp1 & ~cntZero)));
//assign invertIn = (~decrementIn & (comp0In | write1In | read1In | (comp1In & cntDoneIn) )) |
//                  ( decrementIn & (read0In | (comp1In & ~cntZeroIn)));
assign invert = (~decrementL2 & (comp0 | write1 | read1 | (comp1 & cntDoneL2) )) |
                ( decrementL2 & (read0 | (comp1 & ~cntZeroL2)));


// **********************************************************************************
// data to the UTLB during the ABIST portion of the test
//
//  iterIn[0]  iterIn[1]   invert  addr[5] | dataIn [0:1]
//  ---------------------------------------+--------------
//      0         0          0       --    |    0   0
//      0         0          1       --    |    1   1
//      1         1          0       --    |    1   1
//      1         1          1       --    |    0   0
//      0         1          0       0     |    0   1
//      0         1          0       1     |    1   0
//      0         1          1       0     |    1   0
//      0         1          1       1     |    0   1
//      1         0          0       0     |    1   0
//      1         0          0       1     |    0   1
//      1         0          1       0     |    0   1
//      1         0          1       1     |    1   0
// **********************************************************************************
// signal valid the cycle before the state is entered since the UTLB latches the data
//assign BIST_data[0:1] = ({2{~(iterIn[0] ^ iterIn[1])}} &
//                                     (iterIn[0:1] ^ {2{invertL2}}))  |
//                     ({2{ (iterIn[0] ^ iterIn[1])}} &
//                           (iterIn[0:1] ^ {2{((invertL2 & ~BIST_addr[5]) | (~invertL2 & BIST_addr[5]))}} ));
assign BIST_data_i[0:1] = ({2{~(iterIn_i[0] ^ iterIn_i[1])}} &
                                     (iterIn_i[0:1] ^ {2{invert}}))  |
                     ({2{ (iterIn_i[0] ^ iterIn_i[1])}} &
                           (iterIn_i[0:1] ^ {2{((invert & ~BIST_addr_i[5]) | (~invert & BIST_addr_i[5]))}} ));

// **********************************************************************************
// Address generation
//    reset_addr  inc_dec_addr  decrementL2  | BIST_addr
//  ---------------------------------------+--------
//         1          ----        ----     | 000000
//         0           0          ----     | addrL2
//         0           1            0      | addrL2 + 1
//         0           1            1      | addrL2 - 1
// **********************************************************************************
//assign reset_addr = (write0 & cntDone) | (lookup1 & lookup1_cntDone);
assign reset_addr = (write0 & cntDoneL2) | (lookup1 & lookup1_cntDoneL2);

// signal valid the cycle before the state is entered since the UTLB latches the data
assign BIST_addr_i = (((addrL2 ^ {6{decrementL2}}) + inc_dec_addr) ^ {6{decrementL2}}) &
                     {6{ ~reset_addr}};

// **********************************************************************************
// The enables to the UTLB are determined the cycle before they will be needed.
// These signals are latched in the UTLB by a C1 clock so the need to meet the setup
// time of that clock. Read, write, and lookup are defined in the state machine block
// **********************************************************************************
assign BIST_invalidate   =  BIST_StateIn_i == 4'b1101;

// **********************************************************************************
// Valid is equal to BIST_data[0] during ABIST and a one otherwise.
// **********************************************************************************
assign BIST_V =  ~ABIST_test_i | BIST_data_i[0] ;

// added for TBIRD 1/07/02  KAM
// Go into EVS mode when the EVS pin = 0 and mode = 10
wire DVS;
wire EVSallowRead;
reg  oldBistRdEn;

assign
// EVS_mode = ~LSSD_EVS & modeL2[0] & ~modeL2[1],
// 4/26/02 RLG - gating off DVS with TestM1 per Karen Mitchell and defect 2139
 DVS = ~LSSD_EVS & ~modeL2[0] & modeL2[1] & TestM1,

// 05/28/02 KAM - Corrected to remove latches. As long as EVS is pulsed once we will
//  come out of EVS mode. Combined it with the stop_evs equation
// EVS_gateoff = (EVS_gateoffL2 & ~resume_EVS) |
//               (EVS_mode & ~resume_EVS & ~BIST_StateL2[0] & ~BIST_StateL2[1] & ~BIST_StateL2[2] &
//                 BIST_StateL2[3] & cntDoneL2 & (iterL2[0] ^ iterL2[1])),
// resume_EVS = ~LSSD_EVS & EVS_L2 & EVS2_L2,
// stop_evs = EVS_gateoff & ~resume_EVS,
 stop_evs_i = write0 & cntDoneL2 & (iterL2[0] ^ iterL2[1]) &
             modeL2[0] & ~modeL2[1] & ~LSSD_EVS,

 BIST_Done = &BIST_StateL2[0:3],

//assign ABIST_stuffE2 = ~EVS_gateoff,

// 03/05/02 RLG - Updated for TBIRD to gate this clock properly in functional mode
// LSSD_ArrayCClk_buf = ~LSSD_ArrayCClk_NEG &  stop_evs;
// 04/03/02 RLG - Updated for TBIRD to fix test redundancy
// LSSD_ArrayCClk_buf = (~LSSD_ArrayCClk_NEG &  stop_evs & TestM1) | ~TestM1;

// 08/08/02 KAM - Changed for TBIRD so that only one clock is driving the EN_ArrayL1.
// See teamroom items on EN_ArrayL1 need to be 1
//LSSD_ArrayCClk_buf = ~((stop_evs & TestM1) | LSSD_ArrayCClk_NEG);
LSSD_ArrayCClk_buf = 1'b1, //Don't need this anymore
EVSallowRead       = ~(stop_evs_i & TestM1),
BIST_rdEn          = oldBistRdEn & EVSallowRead;


// **********************************************************************************
//  BIST State Machine
// 08/08/02  KAM- changed BIST_rdEn to oldBistRdEn in state machine
//                The read enable is now gated with stopEvs for evs mode
//                Note: Whenever stop_evs is asserted, oldBistRdEn is also asserted
//                      so we want to block it from generatin EN_ArrayL1 in the UTLB
// **********************************************************************************
always @ (TestM1 or BIST_StateL2 or cntZeroL2 or cntDoneL2 or modeL2 or iterL2 or
          decrementL2)
begin
  BIST_wrEn = 1'b0;
  oldBistRdEn = 1'b0;
  BIST_lookupEn = 1'b0;

  casez({BIST_StateL2,TestM1,cntZeroL2,cntDoneL2,modeL2,iterL2,decrementL2})
   12'b0000_0???????  : BIST_StateIn_i = 4'b0000;   // Not in arraytest
   12'b0000_?0??????  : BIST_StateIn_i = 4'b0000;   // Count not zero, flush didn't work
   12'b0000_11??????  : begin                     // Array Test, start -> write0
                         BIST_StateIn_i = 4'b0001;
                         BIST_wrEn = 1'b1;
                        end
   12'b0001_??0?????  : begin                     // write0 -> write0
                         BIST_StateIn_i = 4'b0001;
                         BIST_wrEn = 1'b1;
                        end
   12'b0001_??10100?  ,
   12'b0001_??10110?  ,
   12'b0001_??10111?  ,
   12'b0001_??10101?  ,
   12'b0001_??11000?  ,
   12'b0001_??11001?  ,
   12'b0001_??11011?  ,
   12'b0001_??11010?  ,
   12'b0001_??111???  ,
   12'b0001_??100???  : begin                     // write0 -> read0
                         BIST_StateIn_i = 4'b0010;
                         oldBistRdEn  = 1'b1;
                        end
// Changed for TBIRD 1/7/02 KAM, now go to read0
//   12'b0001_??10101?  ,
//   12'b0001_??11010?  : BIST_StateIn_i = 4'b1111;   // write0 -> done

   12'b0010_????????  : BIST_StateIn_i = 4'b0011;   // read0  -> comp0
   12'b0011_????????  : begin                     // comp0  -> write1
                         BIST_StateIn_i = 4'b0100;
                         BIST_wrEn = 1'b1;
                        end
   12'b0100_????????  : begin                     // write1 -> read1
                         BIST_StateIn_i = 4'b0101;
                         oldBistRdEn = 1'b1;
                        end
   12'b0101_????????  : BIST_StateIn_i = 4'b0110;   // read1  -> comp1
   12'b0110_?0??????  ,
   12'b0110_???????0  : begin                     // comp1  -> read0
                         BIST_StateIn_i = 4'b0010;
                         oldBistRdEn = 1'b1;
                        end
   12'b0110_?1???001  ,
   12'b0110_?1???011  ,
   12'b0110_?1???111  : begin                     // comp1  -> write0
                         BIST_StateIn_i = 4'b0001;
                         BIST_wrEn = 1'b1;
                        end
   12'b0110_?1???101  : begin                     // comp1  -> write2
                         BIST_StateIn_i = 4'b0111;
                         BIST_wrEn = 1'b1;
                        end
   12'b0111_??0?????  : begin                     // write2 -> write2
                         BIST_StateIn_i = 4'b0111;
                         BIST_wrEn = 1'b1;
                        end
   12'b0111_??1?????  : begin                     // write2 -> lookup1
                         BIST_StateIn_i = 4'b1100;
                         BIST_lookupEn = 1'b1;
                        end
   12'b1100_??0?????  : begin                     // lookup1-> lookup1
                         BIST_StateIn_i = 4'b1100;
                         BIST_lookupEn = 1'b1;
                        end
   12'b1100_??1???0?  : begin                     // lookup1-> write2
                         BIST_StateIn_i = 4'b0111;
                         BIST_wrEn = 1'b1;
                        end
   12'b1100_??1???1?  : begin                     // lookup1-> write3
                         BIST_StateIn_i = 4'b1001;
                         BIST_wrEn = 1'b1;
                        end
   12'b1001_????????  : begin                     // write3 -> lookup2
                         BIST_StateIn_i = 4'b1010;
                         BIST_lookupEn = 1'b1;
                        end
   12'b1010_????????  : begin                     // lookup2-> write4
                         BIST_StateIn_i = 4'b1011;
                         BIST_wrEn = 1'b1;
                        end
   12'b1011_??0?????  : begin                     // write4 -> write3
                         BIST_StateIn_i = 4'b1001;
                         BIST_wrEn = 1'b1;
                        end
   12'b1011_??1??0??  : begin                     // write4 -> write5
                         BIST_StateIn_i = 4'b1000;
                         BIST_wrEn = 1'b1;
                        end
   12'b1011_??1??1??  : BIST_StateIn_i = 4'b1101;   // write4 -> inval
   12'b1000_??0?????  : begin                     // write5 -> write5
                         BIST_StateIn_i = 4'b1000;
                         BIST_wrEn = 1'b1;
                        end
   12'b1000_??1?????  : begin                     // write5 -> write3
                         BIST_StateIn_i = 4'b1001;
                         BIST_wrEn = 1'b1;
                        end
   12'b1101_????????  : begin                     // inval  -> lookup3
                         BIST_StateIn_i = 4'b1110;
                         BIST_lookupEn = 1'b1;
                        end
   12'b1110_??????0?  : BIST_StateIn_i = 4'b1110;  // lookup3-> lookup3
   12'b1110_??????1?  : BIST_StateIn_i = 4'b1111;  // lookup3-> done
   12'b1111_???00???  ,
   12'b1111_???01???  ,
   12'b1111_???10???  : BIST_StateIn_i = 4'b1111;  // done   -> done
   12'b1111_???11???  : BIST_StateIn_i = 4'b0000;  // done   -> start
   default            : BIST_StateIn_i = 4'bxxxx;
 endcase
end


// **********************************************************************************
// Decrement Reg
// The register is set and reset the cycle before it is needed
// **********************************************************************************

//assign set_dec     = cntDone & comp1;
//assign reset_dec   = cntZero & decrementL2 & comp1;
assign set_dec     = cntDoneL2 & comp1;
assign reset_dec   = cntZeroL2 & decrementL2 & comp1;
assign decrementIn = (decrementL2 | set_dec) & ~reset_dec;

// **********************************************************************************
// Iteration Reg
// iteration counts 00->11->01>10
// **********************************************************************************
//assign inc_iter = cntZero & decrementL2 & comp1 |
//                  (lookup1 & lookup1_cntDone) | (write4 & cntDone);
//assign inc_iter = cntZeroL2 & decrementL2 & comp1 |
//                  (lookup1 & lookup1_cntDoneL2) | (write4 & cntDoneL2);
assign inc_iter = cntZeroL2 & decrementL2 & comp1 | (lookup1 & lookup1_cntDoneL2) |
                  (write4 & cntDoneL2) | lookup3;

always @(inc_iter or iterL2)
begin
  casez({iterL2,inc_iter})
    3'b000 : iterIn_i[0:1] = 2'b00;
    3'b001 : iterIn_i[0:1] = 2'b11;
    3'b110 : iterIn_i[0:1] = 2'b11;
    3'b111 : iterIn_i[0:1] = 2'b01;
    3'b010 : iterIn_i[0:1] = 2'b01;
    3'b011 : iterIn_i[0:1] = 2'b10;
    3'b100 : iterIn_i[0:1] = 2'b10;
    3'b101 : iterIn_i[0:1] = 2'b00;
    default : iterIn_i[0:1] = 2'bxx;
  endcase
end


endmodule
