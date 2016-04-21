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
// Verilog HDL for "PR_jtg", "JTG_functional" "_functional"
module p405s_JTG_functional(
//  INPUTS
        BypassTDO,CaptureDRmeta,sysReset,CurrentStateL2,DataValidBit,
        DBG_resetChip,DBG_resetSystem,PCL_jtgSprDcd,IFB_stopAck,IFB_rstStepPend,
        IFB_rstStuffPend,InstRegOutL1,InstRegOutL2,InstRegTDO,InstShiftRegOut,
        JDCRstopProc,JDCRblockFold,JDCRstepPulse,JDCRreset0,JTG_dbgWaitEn,
        JDCRreset1,JDCRinstRegDiagDcdEn,JTG_uncondEvent,JTG_freezeTimers, JTG_resetDBSR,
        pgmOut,JTGEX_BndScanTDO,JTGEX_TDI,JTGEX_TMS,JTGEX_TRST_NEG,
        MultiUse_31,MultiUse_2,JTG_step,JTG_stuff,coreReset,DBG_resetCore,
        PCL_exeMfspr,PCL_exeMtspr,PCL_exeSprHold,ShiftDRL1,
        TIM_wdSysRst,TIM_wdChipRst,TIM_wdCoreRst,
        ShiftIRL1,overrun,UpdateDRmeta,jtgHalt,VCT_stuffStepSup,
//  OUTPUTS
        BypassRegE1,BypassRegIn,CaptureDRSync0,
        CntlRegAsyncReset,diagMuxSel,DataRegE1,DataRegE2,DataRegMuxSel,
        InstBufferE2,InstRegAsyncSet,InstShiftRegE1,InstRegL1E1,
        InstRegL2E1,InstRegIn,InstShiftRegIn,JDCRE1,JDCRMuxSel,
        JDCRMuxIn,capDataReg,
        extest,resetChipReq,resetCoreReq,
        resetSystemReq,jtgShiftDR,JTG_stopReq,
        tdoEnable,jtgUpdateDR,MultiUseRegInMuxSel,
        MultiUseRegE1,NextCacheWr,NextDBDRpulse,NextState,NextStep,
        NextStuff,SPRorDataMuxSel,NextOverrun,
        TDOIn,JTG_stepUPD,JTG_stuffUPD
);
//
        output          BypassRegE1,BypassRegIn;
        output          CaptureDRSync0,CntlRegAsyncReset;
        output  [0:1]   diagMuxSel;
        output          DataRegE1,DataRegE2,DataRegMuxSel,InstBufferE2;
        output          InstRegAsyncSet,InstShiftRegE1,InstRegL1E1,InstRegL2E1;
        output  [0:3]   InstRegIn;
        output  [0:3]   InstShiftRegIn;
        output          JDCRE1,JDCRMuxSel;
        output  [0:7]   JDCRMuxIn;
        output          capDataReg,extest;
        output          resetChipReq,resetCoreReq;
        output          resetSystemReq,jtgShiftDR,JTG_stopReq,tdoEnable;
        output          jtgUpdateDR,MultiUseRegInMuxSel;
        output          MultiUseRegE1,NextCacheWr,NextDBDRpulse;
        output  [0:7]   NextState;
        output          NextStep, NextStuff,NextOverrun;
        output          SPRorDataMuxSel;
        output          TDOIn;
        output          JTG_stepUPD,JTG_stuffUPD;

        input           BypassTDO;
        input           sysReset;
        input   [0:7]   CurrentStateL2;
        input           DataValidBit,DBG_resetChip,DBG_resetSystem;
        input           PCL_jtgSprDcd;
        input           IFB_stopAck,IFB_rstStepPend,IFB_rstStuffPend;
        input   [0:3]   InstRegOutL1;
        input   [0:3]   InstRegOutL2;
        input           InstRegTDO;
        input   [0:2]   InstShiftRegOut;
        input           JDCRstopProc,JDCRblockFold,JDCRstepPulse,JDCRreset0;
        input           JDCRreset1,JDCRinstRegDiagDcdEn,JTG_dbgWaitEn;
        input           JTG_uncondEvent,JTG_freezeTimers,JTG_resetDBSR,pgmOut;
        input           JTGEX_BndScanTDO,JTGEX_TDI,JTGEX_TMS,JTGEX_TRST_NEG;
        input           MultiUse_2,MultiUse_31,JTG_stuff,JTG_step,coreReset;
        input           DBG_resetCore,PCL_exeMfspr,PCL_exeMtspr;
        input           PCL_exeSprHold,ShiftDRL1,ShiftIRL1,overrun;
        input           TIM_wdSysRst,TIM_wdChipRst,TIM_wdCoreRst;
        input   [0:2]   UpdateDRmeta;
        input   [0:1]   CaptureDRmeta;
        input           jtgHalt,VCT_stuffStepSup;

        wire            CaptureDR,CaptureIR,DataRegTDO;
        wire            TestLogicReset,UpdateDRSync;
        wire            UpdateDRSyncDlyd,UpdateIR;
        wire		JDCRMuxSel_i, ShiftDR_i,ShiftIR_i,UpdateDR_i,JTG_stepUPD_i;
	wire		JTG_stuffUPD_i;

        reg     [0:7]   NextState;
        reg             InstExtest,InstSample,InstReserved,InstJDCR;
        reg             InstStuff,InstIcacheWr,InstFastWr,InstDBDR;
        reg             InstBypass,InstDiag1,InstDiag2,InstDiag3;

// declare internal signals to isolate outputs from internal inputs.
assign JDCRMuxSel = JDCRMuxSel_i;
assign JTG_stepUPD = JTG_stepUPD_i;
assign JTG_stuffUPD = JTG_stuffUPD_i;

// *************** Stuff Register ********************
// assign Stuff                 = InstStuff   & UpdateDRSync &      // 7/29/98 DLC:  This function,
//                                DataValidBit  & IFB_stopAck;      // also called InstValid, replaced w/ NextStuff.
//
// NextStuff modified for Prowler issue 171
// Old Equation: assign NextStuff =    ((~JTG_stuff  & ~JTG_step       &
//                                     UpdateDRSyncDlyd & DataValidBit &
//                                     InstStuff)    |
//                                     (JTG_stuff    & ~IFB_stopAck))  & ~coreReset;
//
assign NextStuff =    ((~JTG_stuff & ~JTG_step & UpdateDRSyncDlyd & DataValidBit & InstStuff) |
       (JTG_stuff   & ~IFB_rstStuffPend)) & ~coreReset;

// assign StuffOverrunData =    InstStuff       & UpdateDRSync  &
//                              DataValidBit    & ~IFB_stopAck;
// assign StuffOverrunE1 =      jtgReset       | (InstStuff  &      // 7/29/98 DLC: Removed when making
//                              UpdateDRSync    & DataValidBit);    // enhancements to stuff & step -
                                                                    // enhanced to allow for interrupts.
assign NextOverrun =   ((overrun     & ~JTG_stuffUPD_i   & ~JTG_stepUPD_i) |
                       ((JTG_stuff   | JTG_step)   &
                       (JTG_stepUPD_i  | JTG_stuffUPD_i))) & ~coreReset;


assign JTG_stuffUPD_i =  UpdateDRSync  & InstStuff  &                 // 7/29/98  DLC: Intermediate term added for
                       DataValidBit;                                // new NextOverrun equation.
assign JTG_stepUPD_i  =  UpdateDRSync  & InstJDCR &                   // 7/29/98 DLC: Intermediate term added for
                       DataValidBit  & MultiUse_2;                  // new NextOverrun equation.

assign NextCacheWr =   InstIcacheWr  & UpdateDRSyncDlyd &           // 7/27/98 DLC: logic for
                                                                    // single cycle pulse for new
                                                                    // I-cache write instruction.
                       DataValidBit  & IFB_stopAck;

assign NextDBDRpulse = InstFastWr    & UpdateDRSync &               // 7/27/98 DLC:  logic for new
                       DataValidBit  & IFB_stopAck;                 // single cycle pulse for Fast
                                                                    // Write instruction.

// *************** Sync./ Misc. Signal Register ********************
// 7/30/98 DLC: The following changes have been made for PPC405:
//
// Schematic    Functional                       UpdateDRmeta[0:1] are
// SyncOut[3] = UpdateDRmeta[0]                   used to create a single cycle pulse
// SyncOut[4] = UpdateDRmeta[1]                   when the UpdateDR state has
// SyncOut[5] = UpdateDRmeta[2]                   been synchronized to the core clock.
// SyncOut[7] = CaptureDRmeta[0]                 CaptureDRmeta[0:1] are use to
// SyncOut[8] = CaptureDRmeta[1]                  set the Stuff Pending latch one cycle
//                                                after the stuffed instruction has been
//                                                valid in the stuff buffer.
// SyncOut[7](PPC405) = SyncOut[6](PPC401)
// SyncOut[8](PPC4050 = SyncOut[7](PPC401)

assign CaptureDRSync0   = ~sysReset        & CaptureDR;
assign UpdateDRSync     = UpdateDRmeta[0]  & ~UpdateDRmeta[1];
assign UpdateDRSyncDlyd = UpdateDRmeta[1]  & ~UpdateDRmeta[2];                // 7/29/98 DLC:  Delayed UpdateDRSync
                                                                               // by one cycle for use in stuff.
// NextStep modified for Prowler issue 171
// Old Equation: assign NextStep         = ((~JTG_stuff & ~JTG_step & JDCRstepPulse) |
//                                          (JTG_step & ~IFB_stopAck)) & ~coreReset;
//
assign NextStep = ((~JTG_stuff & ~JTG_step & JDCRstepPulse) |
                   (JTG_step & ~IFB_rstStepPend)) & ~coreReset;

// *************** JTAG Debug Control Register ********************
// 02/21/97 LMD Changed reset so that all reset generated by the core will
//              remain on untill reset is driven back into the core.
//              Removed reset counter and associated logic. EXE_resets
//              are no longer latched into JDCR they are ORed with the
//              output of JDCR.
// Issue (prowler 164): added JTG_resetDBSR to JDCRE1
assign JDCRE1           = (JDCRMuxSel_i| JDCRstepPulse | JTG_uncondEvent | JTG_resetDBSR |
                          sysReset | coreReset);
assign JDCRMuxSel_i = (InstJDCR & DataValidBit & UpdateDRSync); //

//***************************************************************************;
// Set inputs to Control register based on JTAG write to JDCR or if reset
// signals from EXE become active.
// expires.
//  JDCRMuxIn:
//        [0]  Stop Processor
//        [1]  Disable Folding  ------ seen outside the functional
//        [2]  Single cycle pulse to set step pending
//        [3,4]Reset Bit: reset with core reset
//               00  No op
//               01  Reset Core
//               10  Reset Chip
//               11  Reset System
//        [5]  Single cycle pulse to set UDE in DBSR ----- seen outside the functional
//        [6]  Freeze Timers while Stopped
//        [7]  DMA Priority Override
//        [8]  Single cycle pulse used to reset DBSR bits ----- seen outside the functional
//        [9]  Debug wait enable
//        [10] Enable new IR decodes for diag. use
//
assign JDCRMuxIn[0]    = JDCRstopProc & ~sysReset;               // Hold bit
assign JDCRMuxIn[1]    = JDCRblockFold   & ~sysReset;            // Hold bit
assign JDCRMuxIn[2]    = JDCRreset0   & ~coreReset & ~sysReset;  // Hold bit
assign JDCRMuxIn[3]    = JDCRreset1   & ~coreReset & ~sysReset;  // Hold bit
assign JDCRMuxIn[4]    = JTG_freezeTimers     & ~sysReset;       // Hold bit
assign JDCRMuxIn[5]    = pgmOut      & ~sysReset;                // Hold bit
assign JDCRMuxIn[6]    = JTG_dbgWaitEn & ~sysReset;              // Hold bit
assign JDCRMuxIn[7]   = JDCRinstRegDiagDcdEn & ~sysReset;        // Hold bit

// Drive output signals to Processor based on Control register bits set;
// JDCRblockFold used to be used in PPC401 & PPC403 for block folding but was removed for PPC405
// because block folding was not used.
assign resetCoreReq    =    (~JDCRreset0    &  JDCRreset1)|
                            (DBG_resetCore  | TIM_wdCoreRst);
assign resetChipReq    =    (JDCRreset0     & ~JDCRreset1)|
                            (DBG_resetChip  | TIM_wdChipRst);
assign resetSystemReq  =    (JDCRreset0     & JDCRreset1) |
                            (DBG_resetSystem | TIM_wdSysRst) ;

// *************** Instruction Register Controls ***************

assign InstRegL1E1       = (TestLogicReset    | UpdateIR);
assign InstRegL2E1       = (TestLogicReset    | UpdateIR) &
                            JTGEX_TRST_NEG;
assign InstRegIn[0]      = TestLogicReset     | InstShiftRegOut[0];
assign InstRegIn[1]      = TestLogicReset     | InstShiftRegOut[1];
assign InstRegIn[2]      = TestLogicReset     | InstShiftRegOut[2];
assign InstRegIn[3]      = TestLogicReset     | InstRegTDO;

assign InstShiftRegE1    = CaptureIR          | ShiftIR_i;
assign InstShiftRegIn[0] = JTGEX_TDI          & ShiftIR_i;
assign InstShiftRegIn[1] = InstShiftRegOut[0] & ShiftIR_i;
assign InstShiftRegIn[2] = InstShiftRegOut[1] & ShiftIR_i;
assign InstShiftRegIn[3] = InstShiftRegOut[2] | ~ShiftIR_i;
assign InstRegAsyncSet   = ~JTGEX_TRST_NEG;

// ***************  Instruction Decoder ***************
// generate EXTEST based off of L1-outputs = '0000'
assign extest = (InstRegOutL1 == 4'b0000) ? 1'b1 : 1'b0;
//
// generate other instructions based off of L2-outputs;
//
//assign InstExtest   = (InstRegOutL2 == 4'b0000) ? 1'b1 : 1'b0;
//assign InstSample   = (InstRegOutL2 == 4'b0001) ? 1'b1 : 1'b0;
//assign InstJDCR     = (InstRegOutL2 == 4'b0101) ? 1'b1 : 1'b0;  // Used to write the JDCR.
//assign InstIcacheWr = (InstRegOutL2 == 4'b1001) ? 1'b1 : 1'b0;  // 7/27/98  DLC: new addr decode to
//                                                                // write the I cache.
//assign InstFastWr   = (InstRegOutL2 == 4'b1010) ? 1'b1 : 1'b0;  // 7/27/98  DLC: new addr decode to write DBDR with
//                                                                // single cycle pulse.
//assign InstDBDR     = (InstRegOutL2 == 4'b1011) ? 1'b1 : 1'b0;  // Used to read and write the DBDR.
//assign InstStuff    = (InstRegOutL2 == 4'b0111) ? 1'b1 : 1'b0;  // This send pulse & instruction.
//assign InstBypass   = (InstRegOutL2 == 4'b1111) ? 1'b1 : 1'b0;
//assign InstReserved = ~InstExtest   & ~InstSample & ~InstJDCR   &
//                      ~InstDBDR     & ~InstStuff  & ~InstBypass &
//                      ~InstIcacheWr & ~InstFastWr;              // 7/27/98 DLC: added new inst. to list.

always @ (JDCRinstRegDiagDcdEn or InstRegOutL2)
begin
     InstExtest = 1'b0; InstSample   = 1'b0; InstReserved = 1'b0; InstJDCR  = 1'b0;
     InstStuff  = 1'b0; InstIcacheWr = 1'b0; InstFastWr   = 1'b0; InstDBDR  = 1'b0;
     InstBypass = 1'b0; InstDiag1    = 1'b0; InstDiag2    = 1'b0; InstDiag3 = 1'b0;

     casez ({JDCRinstRegDiagDcdEn, InstRegOutL2}) //synopsys full_case parallel_case
     5'b?_0000: InstExtest   = 1'b1;
     5'b?_0001: InstSample   = 1'b1;
     5'b?_0010: InstReserved = 1'b1;
     5'b?_0011: InstReserved = 1'b1;
     5'b?_0100: InstReserved = 1'b1;
     5'b?_0101: InstJDCR     = 1'b1;
     5'b?_0110: InstReserved = 1'b1;
     5'b?_0111: InstStuff    = 1'b1;
     5'b?_1000: InstReserved = 1'b1;
     5'b?_1001: InstIcacheWr = 1'b1;
     5'b?_1010: InstFastWr   = 1'b1;
     5'b?_1011: InstDBDR     = 1'b1;
     5'b0_1100: InstReserved = 1'b1;
     5'b0_1101: InstReserved = 1'b1;
     5'b0_1110: InstReserved = 1'b1;
     5'b?_1111: InstBypass   = 1'b1;

     5'b1_1100: InstDiag1    = 1'b1;
     5'b1_1101: InstDiag2    = 1'b1;
     5'b1_1110: InstDiag3    = 1'b1;

     default: begin
                  InstExtest = 1'bx; InstSample   = 1'bx; InstReserved = 1'bx; InstJDCR  = 1'bx;
                  InstStuff  = 1'bx; InstIcacheWr = 1'bx; InstFastWr   = 1'bx; InstDBDR  = 1'bx;
                  InstBypass = 1'bx; InstDiag1    = 1'bx; InstDiag2    = 1'bx; InstDiag3 = 1'bx;
              end
     endcase
end

// *************** TDO Input Select ***********
//
assign DataRegTDO     = ((InstBypass  | InstReserved) & BypassTDO) |
                        ((InstSample  | InstExtest)   & JTGEX_BndScanTDO) |
                        ((InstStuff   | InstDBDR      | InstJDCR | InstFastWr | InstIcacheWr | InstDiag1 | InstDiag2 | InstDiag3)   // HOTFIX to shift out diagdata DLC: 11/13/98
                        & MultiUse_31);                          // 7/27/98 DLC: added new inst.
assign TDOIn          = (DataRegTDO   & ~ShiftIR_i)     | (InstRegTDO   & ShiftIR_i);
assign tdoEnable  = (ShiftIRL1    | ShiftDRL1);

// *************** SPR Decoder ***************
//
// SPR address decode:
//
//         3F3 = Debug Data Register
//

// assign SprRegSel =       (EXE_sprAddr == 10'h3f3) ? 1'b1 : 1'b0;  // DLC: 5/20/99: now decoded in PCL for timing
assign SPRorDataMuxSel = PCL_jtgSprDcd & PCL_exeMfspr;

// *************** Data Register Controls (DBDR) ***************

assign DataRegMuxSel   = ~((InstFastWr | InstDBDR) & UpdateDRSync & DataValidBit);
assign DataRegE1       = ((InstFastWr | InstDBDR) & UpdateDRSync & DataValidBit) | PCL_exeMtspr;
assign DataRegE2       = ((InstFastWr | InstDBDR) & UpdateDRSync & DataValidBit) | (~PCL_exeSprHold & PCL_jtgSprDcd);


// *************** State Machine ***************
// JTAG TAP state machine current and next state
// includes: TMS and current state inputs
//
always @ (JTGEX_TMS or CurrentStateL2)
  begin
    case ({JTGEX_TMS, CurrentStateL2})  // synopsys full_case parallel_case

// Test-Logic-Reset
     9'b000000000: NextState = 8'b00001100;     // Run-Test-Idle
     9'b100000000: NextState = 8'b00000000;     // Test-Logic-Reset

// Run-Test-Idle
     9'b000001100: NextState = 8'b00001100;     // Run-Test-Idle
     9'b100001100: NextState = 8'b00000111;     // Select-DR-Scan

// Select-DR-Scan
     9'b000000111: NextState = 8'b01000000;     // Capture-DR
     9'b100000111: NextState = 8'b00000100;     // Select-IR-Scan

// Capture-DR
     9'b001000000: NextState = 8'b00010000;     // Shift-DR
     9'b101000000: NextState = 8'b00000001;     // Exit1-DR

// Shift-DR
     9'b000010000: NextState = 8'b00010000;     // Shift-DR
     9'b100010000: NextState = 8'b00000001;     // Exit1-DR

// Exit1-DR
     9'b000000001: NextState = 8'b00000011;     // Pause-DR
     9'b100000001: NextState = 8'b10000000;     // Update-DR

// Pause-DR
     9'b000000011: NextState = 8'b00000011;     // Pause-DR
     9'b100000011: NextState = 8'b00001111;     // Exit2-DR

// Exit2-DR
     9'b000001111: NextState = 8'b00010000;     // Shift-DR
     9'b100001111: NextState = 8'b10000000;     // Update-DR

// Update-DR
     9'b010000000: NextState = 8'b00001100;     // Run-Test-Idle
     9'b110000000: NextState = 8'b00000111;     // Select-DR-Scan

// Select-IR-Scan
     9'b000000100: NextState = 8'b00001110;     // Capture-IR
     9'b100000100: NextState = 8'b00000000;     // Test-Logic-Reset

// Capture-IR
     9'b000001110: NextState = 8'b00100000;     // Shift-IR
     9'b100001110: NextState = 8'b00001001;     // Exit1-IR

// Shift-IR
     9'b000100000: NextState = 8'b00100000;     // Shift-IR
     9'b100100000: NextState = 8'b00001001;     // Exit1-IR

// Exit1-IR
     9'b000001001: NextState = 8'b00001011;     // Pause-IR
     9'b100001001: NextState = 8'b00001101;     // Update-IR

// Pause-IR
     9'b000001011: NextState = 8'b00001011;     // Pause-IR
     9'b100001011: NextState = 8'b00001000;     // Exit2-IR

// Exit2-IR
     9'b000001000: NextState = 8'b00100000;     // Shift-IR
     9'b100001000: NextState = 8'b00001101;     // Update-IR

// Update-IR
     9'b000001101: NextState = 8'b00001100;     // Run-Test-Idle
     9'b100001101: NextState = 8'b00000111;     // Select-DR-Scan

      default      : NextState = 8'b00000000;     // all other states
                                                     // Test-Logic-Reset
    endcase
 end
// set JTAG TAP state L2 outputs
//      00001111 -  TEST-LOGIC RESET
//      00001101 -  UPDATE-IR
//      1xxxxxxx -  UPDATE-DR    - for JTAG BS
//                                 register Cntl.
//      00001110 - CAPTURE-IR
//      ???1???? - SHIFT-DR
//      ??1????? - SHIFT-IR
//      ?1?????? - CAPTURE-DR
//      1??????? - UPDATE-DR
//
//
assign TestLogicReset=  ~CurrentStateL2[0] & ~CurrentStateL2[1] &
                        ~CurrentStateL2[2] & ~CurrentStateL2[3] &
                        ~CurrentStateL2[4] & ~CurrentStateL2[5] &
                        ~CurrentStateL2[6] & ~CurrentStateL2[7];
assign UpdateIR      =  ~CurrentStateL2[0] & ~CurrentStateL2[1] &
                        ~CurrentStateL2[2] & ~CurrentStateL2[3] &
                         CurrentStateL2[4] &  CurrentStateL2[5] &
                        ~CurrentStateL2[6] &  CurrentStateL2[7];
assign CaptureIR     =  ~CurrentStateL2[0] & ~CurrentStateL2[1] &
                        ~CurrentStateL2[2] & ~CurrentStateL2[3] &
                         CurrentStateL2[4] &  CurrentStateL2[5] &
                         CurrentStateL2[6] & ~CurrentStateL2[7];
assign ShiftDR_i =   CurrentStateL2[3];
assign ShiftIR_i       =   CurrentStateL2[2];
assign CaptureDR     =   CurrentStateL2[1];
assign UpdateDR_i      =   CurrentStateL2[0];

// *************** Bypass Register Controls ***************

assign BypassRegE1     = (InstBypass   | InstReserved) &
                          (CaptureDR    | ShiftDR_i);
assign BypassRegIn     = ShiftDR_i       & JTGEX_TDI;


// *************** Random Logic ***************
// MultiUseRegInMuxSel
//         0 = DBDR
//         1 = JDSR
assign MultiUseRegInMuxSel     = InstJDCR  | InstStuff | InstIcacheWr | InstFastWr;   //8/21/98 DLC:
//                         added InstIcacheWr & InstFastWr to see JDSR.

// Diag. Mux Sel
//         00 = DBDR
//         01 = jtgDiagBus1
//         10 = jtgDiagBus2
//         11 = jtgDiagBus3
assign diagMuxSel[0:1] =
        {(InstDiag2 | InstDiag3),(InstDiag1 | InstDiag3)};

assign MultiUseRegE1           = CaptureDR     | ShiftDR_i;

assign jtgUpdateDR            = (InstExtest   | InstSample)   & UpdateDR_i;
assign jtgShiftDR             = (InstExtest   | InstSample)   & ShiftDR_i;
assign capDataReg           = (InstExtest   | InstSample)   & CaptureDR;
assign JTG_stopReq             = jtgHalt       | JDCRstopProc;
assign CntlRegAsyncReset       = JTGEX_TRST_NEG;

//  Instruction Buffer holds stuffed instructions and data to be written to the I-cache.
assign InstBufferE2            = UpdateDRSync  & (InstStuff | InstIcacheWr) &   // 7/29/98 DLC: Added E2 for new
                                  DataValidBit   & ~JTG_stuff & ~JTG_step;      // Instruction Buffer for PPC405.   // HOTFIX
endmodule
