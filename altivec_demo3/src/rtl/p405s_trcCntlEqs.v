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
// Verilog HDL for "PR_trc, "trcCntlEqs" "_functional"

/////////////////////////////////////////
// Please gnerate symbol automatically //
/////////////////////////////////////////

/////////////
// UPDATES //
/////////////
//
// 10/26/98 LMD Modified from 401 logic
//
module p405s_trcCntlEqs (TRC_se, TRC_sleepReq, TRC_fifoOneEntryFree,
                   trcSECtrReset, trcReset,
                   nxtFifoWrAddr, nxtFifoRdAddr, nxtFifoStatus,
                   nxtTrcSerState, nxtTSBus,
                   nxtOddCycle, nxtStampInc, nxtSeCtrEqZero,
                   trcESTSE1, trcTimeStampE1, trcSECtrE1, fifoCntlE2,
                   serializerE1, trcTimeStampE2, evenESTEE1,
                   trcFifoE1, xxxTEQ,

                   ICU_traceEnable,
                   IFB_postEntry, IFB_stopAck, IFB_seIdleSt,
                   VCT_msrWE,
                   JTG_stopReq, DBG_stopReq,
                   XXX_TE,
                   serDataOut, seInc, trcFifoDataOut,
                   fifoStatusL2, fifoWrAddrL2, fifoRdAddrL2, trcSerStateL2,
                   coreResetL2, evenTEL2, stampIncL2, trcEnableDlyL2,
                   oddCycleL2, seCtrEqZeroL2, xxxTraceDisableL2
                   );

output          TRC_se, TRC_sleepReq, TRC_fifoOneEntryFree;
output          trcSECtrReset, trcReset;
output  [0:3]   nxtFifoWrAddr, nxtFifoRdAddr;
output  [0:4]   nxtFifoStatus;
output  [0:3]   nxtTrcSerState, nxtTSBus;
output          nxtOddCycle, nxtStampInc, nxtSeCtrEqZero;
output          trcESTSE1, trcTimeStampE1, trcSECtrE1, fifoCntlE2;
output          serializerE1, trcTimeStampE2, evenESTEE1;
output  [0:15]  trcFifoE1;
output          xxxTEQ;

input           ICU_traceEnable;
input           IFB_postEntry, IFB_stopAck, IFB_seIdleSt;
input           VCT_msrWE;
input           JTG_stopReq, DBG_stopReq;
input           XXX_TE;
input   [0:2]   serDataOut;
input   [0:10]  seInc;
input   [30:31] trcFifoDataOut;
input   [0:3]   fifoWrAddrL2, fifoRdAddrL2, trcSerStateL2;
input   [0:4]   fifoStatusL2;
input           coreResetL2, evenTEL2, stampIncL2, trcEnableDlyL2;
input           oddCycleL2, seCtrEqZeroL2, xxxTraceDisableL2;

reg     [0:3]   nxtTrcSerState, nxtTSBus;
reg     [0:4]   nxtFifoStatus;

wire            fifoEmpty, iarEntry, tsA1State, trcSerCmplt, trcSerCmpltSt;
wire            postEntry, traceEvent, anyStopReq, stopWaitQ, xxxStopTrace;

wire trcSECtrReset_i;
wire trcReset_i;
wire xxxTEQ_i;
wire TRC_se_i;

assign trcSECtrReset = trcSECtrReset_i;
assign trcReset = trcReset_i;
assign xxxTEQ = xxxTEQ_i;
assign TRC_se = TRC_se_i;

assign trcReset_i = coreResetL2 | (ICU_traceEnable ^ trcEnableDlyL2);
assign postEntry = IFB_postEntry & ICU_traceEnable & ~fifoStatusL2[0];
assign xxxTEQ_i = XXX_TE & ~xxxTraceDisableL2;
assign traceEvent = xxxTEQ_i | evenTEL2;

//*************************************************************************
// FIFO Control Register
//      [0:3]  fifo status. How much of the fifo is full.
//      [4:7]  write address
//      [8:11] read address
//*************************************************************************
// FIFO status controls
// Using an up down counter to determine the number of fifo locations in use.
// trcSerCmplt contains ~traceEvent.
// trcSerCmplt contains ~oddCycleL2.
// reset covered by 2:1 mux at register.
always @(postEntry or trcSerCmplt or fifoStatusL2)
    case ({postEntry,trcSerCmplt})
        2'b00: nxtFifoStatus = fifoStatusL2;
        2'b01: nxtFifoStatus = fifoStatusL2 - 1;
        2'b10: nxtFifoStatus = fifoStatusL2 + 1;
        2'b11: nxtFifoStatus = fifoStatusL2;
        default: nxtFifoStatus = 5'bxxxxx;
    endcase

// FIFO write address controls.
assign nxtFifoWrAddr = postEntry ? fifoWrAddrL2 + 1 : fifoWrAddrL2 ;

// FIFO read address controls.
// trcSerCmplt contains ~traceEvent and ~oddCycleL2.
assign nxtFifoRdAddr =  trcSerCmplt ? fifoRdAddrL2 + 1 : fifoRdAddrL2;

// FIFO control E1.
// trcSerCmpltSt is trcSerCmpt without ~traceEvent (late signal)
assign fifoCntlE2 = trcReset_i | postEntry | trcSerCmpltSt;

// FIFO control equations.
assign fifoEmpty = ~|fifoStatusL2;
assign TRC_fifoOneEntryFree = ~fifoStatusL2[0] & fifoStatusL2[1] &
        fifoStatusL2[2] & fifoStatusL2[3] & fifoStatusL2[4]; //15 entries full

// allow synthesis to buffer isolate unit output.
assign TRC_sleepReq = fifoEmpty;

//*************************************************************************
// Trace FIFO register clock gating:
//*************************************************************************
//*Timing on postEntry?? Use E2 if necessary.
assign trcFifoE1[0] = postEntry &
    (~fifoWrAddrL2[0] & ~fifoWrAddrL2[1] & ~fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[1] = postEntry &
    (~fifoWrAddrL2[0] & ~fifoWrAddrL2[1] & ~fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[2] = postEntry &
    (~fifoWrAddrL2[0] & ~fifoWrAddrL2[1] &  fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[3] = postEntry &
    (~fifoWrAddrL2[0] & ~fifoWrAddrL2[1] &  fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[4] = postEntry &
    (~fifoWrAddrL2[0] &  fifoWrAddrL2[1] & ~fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[5] = postEntry &
    (~fifoWrAddrL2[0] &  fifoWrAddrL2[1] & ~fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[6] = postEntry &
    (~fifoWrAddrL2[0] &  fifoWrAddrL2[1] &  fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[7] = postEntry &
    (~fifoWrAddrL2[0] &  fifoWrAddrL2[1] &  fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[8] = postEntry &
    ( fifoWrAddrL2[0] & ~fifoWrAddrL2[1] & ~fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[9] = postEntry &
    ( fifoWrAddrL2[0] & ~fifoWrAddrL2[1] & ~fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[10] = postEntry &
    ( fifoWrAddrL2[0] & ~fifoWrAddrL2[1] &  fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[11] = postEntry &
    ( fifoWrAddrL2[0] & ~fifoWrAddrL2[1] &  fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[12] = postEntry &
    ( fifoWrAddrL2[0] &  fifoWrAddrL2[1] & ~fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[13] = postEntry &
    ( fifoWrAddrL2[0] &  fifoWrAddrL2[1] & ~fifoWrAddrL2[2] &  fifoWrAddrL2[3]);
assign trcFifoE1[14] = postEntry &
    ( fifoWrAddrL2[0] &  fifoWrAddrL2[1] &  fifoWrAddrL2[2] & ~fifoWrAddrL2[3]);
assign trcFifoE1[15] = postEntry &
    ( fifoWrAddrL2[0] &  fifoWrAddrL2[1] &  fifoWrAddrL2[2] &  fifoWrAddrL2[3]);

//*************************************************************************
// Serializer State Machine
//*************************************************************************
// trcFifoDataOut[30:31] is the fifo line trace type. Tells what kind of data
//   is at the current read line of the fifo.
// State updates only on odd cycle unless resetting.
// Reset is handled by input on 2 port register
// FIFO empty in E1 equation and will hold in state 0000.
always @ (traceEvent or trcSerStateL2 or trcFifoDataOut)
begin
casez ({traceEvent,trcSerStateL2})
    5'b00000: begin                          // TS/Addr1(normal only)
               case(trcFifoDataOut[30:31])
                   2'b00: nxtTrcSerState = 4'b0100;     // normal post
                   2'b01: nxtTrcSerState = 4'b1101;     // SE Iar
                   2'b10: nxtTrcSerState = 4'b0011;     // SE Lr
                   2'b11: nxtTrcSerState = 4'b0011;     // SE Ctr
                   default: nxtTrcSerState = 4'bxxxx;
               endcase
              end
    5'b00001: nxtTrcSerState = 4'b0000;      // not used
    5'b00010: nxtTrcSerState = 4'b0000;      // not used
    5'b00011: nxtTrcSerState = 4'b0100;      // Addr1 (for SE only)
    5'b00100: nxtTrcSerState = 4'b0101;      // Addr2
    5'b00101: nxtTrcSerState = 4'b0110;      // Addr3
    5'b00110: nxtTrcSerState = 4'b0111;      // Addr4
    5'b00111: nxtTrcSerState = 4'b1000;      // Addr5
    5'b01000: nxtTrcSerState = 4'b1001;      // Addr6
    5'b01001: nxtTrcSerState = 4'b1010;      // Addr7
    5'b01010: nxtTrcSerState = 4'b1011;      // Addr8
    5'b01011: nxtTrcSerState = 4'b1100;      // Addr9
    5'b01100: nxtTrcSerState = 4'b0000;      // Addr10
    5'b01101: nxtTrcSerState = 4'b1110;      // Time1
    5'b01110: nxtTrcSerState = 4'b1111;      // Time2
    5'b01111: nxtTrcSerState = 4'b0011;      // Time3
    5'b1????: nxtTrcSerState = trcSerStateL2;
    default: nxtTrcSerState = 4'bxxxx;         // x-catcher
endcase
end

// updates only on odd cycle unless resetting.
// fifoEmpty can only happen in trcSerStateL2 == 4'b0000
// Serializer will hold if fifo empty or there is a trigger event.
// Serializer is reset by 2:1 mux at register input.
//*moved ~traceEvent into feedback to remove from E1. Is E2 better (4 bit reg)?
assign serializerE1 = trcReset_i | (~fifoEmpty & ~oddCycleL2);

// Completing sending fifo line. including SE code and time stamp.
// Only complete on an odd cycle and not blocked by a traceEvent.
assign trcSerCmplt = ~traceEvent & ~oddCycleL2 & (trcSerStateL2 == 4'b1100);
// Signal used in an E1 equation without late signal trace event
assign trcSerCmpltSt = ~oddCycleL2 & (trcSerStateL2 == 4'b1100);

// Current fifo read entry is an iar posting.
// If fifo not empty the current line must be full.
// Used only by timestamp.
assign iarEntry = ~oddCycleL2 & (trcFifoDataOut[30:31] == 2'b01) & ~fifoEmpty;

// In TS/A1 state.
assign tsA1State = ~|trcSerStateL2[0:3];

//*************************************************************************
// Creation of Trace Status (TS)
//*************************************************************************
// Qualify wait and stop with XXX_traceEnable.
assign stopWaitQ = (IFB_stopAck | VCT_msrWE) &
                   ~(xxxTraceDisableL2 & IFB_seIdleSt);
// Trace Event/Trace Address/Trace Broadcast.
// Feeds trace status register, which updates
//    only on odd cycles, unless resetting.
// Reset handled by 2:1 mux at register input.
always @ (xxxTEQ_i or evenTEL2 or fifoEmpty or tsA1State or
          trcFifoDataOut or stopWaitQ or serDataOut)
begin
casez ({xxxTEQ_i, evenTEL2, ~fifoEmpty, tsA1State, trcFifoDataOut[30:31],
        stopWaitQ})
    7'b00_0_?_??_0: nxtTSBus = 4'b0000;           // nothing happening
    7'b00_0_?_??_1: nxtTSBus = 4'b0011;           // wait or stop state
    7'b00_1_0_??_?: nxtTSBus = {1'b1,serDataOut}; // address broadcast
    7'b00_1_1_00_?: nxtTSBus = {1'b1,serDataOut}; // normal A1 broadcast
    7'b00_1_1_01_?: nxtTSBus = 4'b0101;           // seIar code
    7'b00_1_1_10_?: nxtTSBus = 4'b0110;           // seLr code
    7'b00_1_1_11_?: nxtTSBus = 4'b0111;           // seCtr code
    7'b01_?_?_??_?: nxtTSBus = 4'b0100;           // even trigger event
    7'b10_?_?_??_?: nxtTSBus = 4'b0001;           // odd trigger event
    7'b11_?_?_??_?: nxtTSBus = 4'b0010;           // even/odd trigger event
    default: nxtTSBus = 4'bxxxx;                    // x-catcher
  endcase
end

// Clock gating for execution status (ES), trace status (TS) register
// Updates only on odd cycles unless resetting.
assign trcESTSE1 = trcReset_i | (ICU_traceEnable & ~oddCycleL2);

//*****************************************************************************
// Timestamp control
//*****************************************************************************
// stampInc is in a free running register.
// There is not any protection to prevent unknown roll over of time stamp.
//   It takes 10 reads X 15 fifo lines X 2 cycles or a maximum of 300 cycles
//   to drain the fifo and broadcast (worst case) the seIar code. Time stamp
//   has counts 512 cycles. It would take 212 TEs preempting fifo postings to
//   blow the count.
// Can't have two IAR entries in the FIFO at the same time or posting.
// NOTE: after the first cycle of IAR the stampInc WILL be "0" so any
//       additional TE's will NOT be counted once the IAR begins to broadcast.
// NOTE: added "| traceEvent" to allow the stamp to increment whenever a TE
//       preempts the first cycle of an SE IAR.  Once the first broadcast
//       for the SE IAR occurs stampInc will go to "0" and prevent incrementing
//       for future TE's that occur during the same SE.
// Time stamp increments from the time the iar is saved due to a TRC_se
//      until the IAR code is sent out or the fifo (iarEntry).
//      TEs can preempt the sending of any data from the fifo.
// Use TRC_se to select reset of timeStamp and to start timestamp
//     incrementing.
// iarEntry contains ~oddCycleL2.
assign nxtStampInc = TRC_se_i |
                     (stampIncL2 & (~iarEntry | traceEvent));
// Using seCtrEqZeroL2 & ~VCT_msrWE in E1 instead of the full equation
//   for TRC_se for timing.
assign trcTimeStampE1 = ICU_traceEnable &
                        ((seCtrEqZeroL2 & ~VCT_msrWE) | stampIncL2);
assign trcTimeStampE2 = TRC_se_i | (~iarEntry | traceEvent);

//*************************************************************************
// Synchronizing Event Generation and Controls
//*************************************************************************
// It was determined to be impossible for a second SE to be posted before
//    the first was out of the fifo. Interlock controls were eliminated,
//    It takes 10 reads X 15 fifo lines X 2 cycles or a maximum of 300 cycles
//    to drain the fifo and broadcast (worst case) the seIar code. There are
//    2K cycles between SE counter events. Allows 1748 TEs to
//    preempt SE postings and broadcasts before blowing the counter.
//
// seCtrEqZero is in a free running register
assign nxtSeCtrEqZero = (seInc == 11'b00000000000) | trcSECtrReset_i;

// No SE when trace disabled
// No SE when in wait state
// No SE when in hard stop
// Build IFB_anyStopReq locally with JTG_stopReq | DBG_stopReq
assign anyStopReq = JTG_stopReq | DBG_stopReq;
assign TRC_se_i = seCtrEqZeroL2 & ICU_traceEnable & ~VCT_msrWE &
                ~anyStopReq & ~xxxTraceDisableL2;

// Reset for SE Counter
// When in wait or stop state and fifo has emptied.
// If fifo is not empty then we haven't been in wait or stop for very long.
// If fifo is empty we are not sure how long we have been in wait or stop but
//    we have room for SE in the fifo so do it.
// Se will occur when leaving wait or stop.
// Also used to steer mux into reg.
assign trcSECtrReset_i = trcReset_i | xxxTraceDisableL2 |
            ICU_traceEnable & (VCT_msrWE | anyStopReq) & fifoEmpty;

// E1 for SE Counter
// Counts cycle to next SE
// ICU_traceEnable allows count to run.
// ~seCtrEqZeroL2 allows counter to continue, and to reset when trace is
//   disabled.
// Reset wants to cause SEs, load counter with 0.
// Reset only when seCtr not equal to zero (~seCtrEqZeroL2) for power savings
// coreResetL2 included to prevent stuck at X in simulation
assign trcSECtrE1 = ICU_traceEnable | ~seCtrEqZeroL2 | coreResetL2;

//*************************************************************************
// Odd cycle indicator
//*************************************************************************
// Odd cycle is defined by the cycle that trace comes out of reset or
//    being disabled.
// ES and debug TE are sent through the pipeline and correspond the instruction
//    in the wb stage. wb status is staged through a latch to create the
//    traceES. which is updated when the instruction leaves wb,
//    1 cycle delay from in instruction in wb to bein sent out on traceES)
//    So and instruction that completes during an even cycle (is in wb and
//    will complete in the even cycle) updates the even cycle ES/TE staging
//    register in the odd cycle (2 cycles delay for instructions completing
//    in even cycles). Then feeds the ES/TS output staging register which
//    updates during an even cycle (3 cycles delay for instruction completing
//    in even cycles, 2 cycle of delay for instructions completing in odd
//    cycles). The new ES/TS data launched on the rising edge of the odd
//    cycle signal or during the odd cycle.
// TraceCycle turns off when XXX_traceDisable and the fifo is empty.
assign xxxStopTrace = xxxTraceDisableL2 & fifoEmpty & IFB_seIdleSt;
assign nxtOddCycle = xxxStopTrace | ~ICU_traceEnable | coreResetL2 |
                     ~oddCycleL2;

//***************************************************************************
// even ES TE E1
//***************************************************************************
// uses oddCycleL2. See above.
assign evenESTEE1 = ICU_traceEnable & oddCycleL2;

endmodule
