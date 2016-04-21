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

//////////////////////////////////////////////////////////
// ALWAYS GENERATE SYMBOL AUTOMATICALLY!!!!!!!!!!!!!!!!!!/
//////////////////////////////////////////////////////////
// Change History:
// 09/15/98  JD/SP  Added VCT_exeBrTrapErrSuppress and PCL_exeDvcHold terms to
//                  suppressBt  equation.
//           lmd    Why did you do this?????????
// 07/17/01  JBB    Added PCL_exeDvcOrParityHold to suppressBt and suppressIac
//                  equations per the Cobra Workbook

module p405s_dbgEqs (nxtExeIac1Event, nxtExeIac2Event, nxtExeIac3Event,
               nxtExeIac4Event,
               nxtDac1Rd, nxtDac1Wr, nxtDac2Rd, nxtDac2Wr,
               nxtDvc1Rd, nxtDvc1Wr, nxtDvc2Rd, nxtDvc2Wr,
               nxtDbsrSummaryBit,
               nxtHwIac12X, nxtHwIac34X,
               dbcr0_XE2,
               iacCntlE1, iacCntlE2, iacCntlSel,
               dacCntlE1, dacCntlE2, dvcCntlE2,
               DBG_exeSuppress, DBG_wbDacSuppress, DBG_exeIacSuppress,
               DBG_icmpEn, DBG_stopReq, DBG_weakStopReq, DBG_intrp,
               DBG_freezeTimers, DBG_trapEnQ, DBG_udeIntrp, DBG_dacEn,
               DBG_rstCoreReq, DBG_rstChipReq, DBG_rstSystemReq, DBG_iacEn,
               DBG_dvcRdEn, DBG_dvcWrEn, DBG_eventSet, 
               DBG_exeTE, DBG_wbTE, DBG_immdTE, DBG_dacIntrp,
               nxtDbsrGroup0, nxtDbsrGroup1, nxtDbsrGroup2, nxtDbsrGroup3,
               dbsrE2, dbcrE1, dbcr0E2, dbcr1E2, sprBusSel, exeMtdbcr0,

               IFB_iac1GtIar, IFB_iac1BitsEq, IFB_iac2GtIar, IFB_iac2BitsEq,
               IFB_iac3GtIar, IFB_iac3BitsEq, IFB_iac4GtIar, IFB_iac4BitsEq,
               IFB_stuffStL2, IFB_exeDbgBrTaken, IFB_exeFlush, IFB_exeClear,
               IFB_dcdFullL2, IFB_exeFullL2, IFB_exeDisableDbL2,
               IFB_wbDisableDbL2,
               EXE_dvc1ByteCmp, EXE_dac1Bits0to26Eq, EXE_dac1Bits27to29Eq,
               EXE_dac1Bits30Eq, EXE_dac1Bits31Eq, EXE_dac1GtDsEa,
               EXE_dvc2ByteCmp, EXE_dac2Bits0to26Eq, EXE_dac2Bits27to29Eq,
               EXE_dac2Bits30Eq, EXE_dac2Bits31Eq, EXE_dac2GtDsEa,
               EXE_dbgSprDcds, EXE_sprDataBus,
               PCL_exeDbgRdOp, PCL_exeDbgWrOp, PCL_wbDbgIcmp, PCL_dvcCmpEn,
               PCL_mtSPR, PCL_exeDvcHold, PCL_exeTrap,
               PCL_sprHold, PCL_exeIarHold, PCL_wbHold, PCL_wbFull,
               PCL_exeDbgLdOp, PCL_exeDbgStOp,
               VCT_msrDE, VCT_msrDWE, VCT_wbFlush,
               VCT_wbErrSuppress, VCT_swapQ01, VCT_swapQ23, JTG_dbgWaitEn,
               VCT_exeBrTrapErrSuppress,
               JTG_uncondEvent, JTG_dbdrPulse, JTG_resetDBSR,
               XXX_uncondEvent,
               coreResetL2,
               intDbMode, extDbMode, enIcmpL2, enBrTakenL2, enTrapL2,
               enIac1L2, enIac2L2, enIac12RangeL2, enIac12XRangeL2,
               enIac3L2, enIac4L2, enIac34RangeL2, enIac34XRangeL2,
               enIac12XToggleL2, enIac34XToggleL2,
               exeIac1EventL2, exeIac2EventL2, exeIac3EventL2, exeIac4EventL2,
               enDac1RdL2, enDac1WrL2, dac1SizeL2,
               enDac2RdL2, enDac2WrL2, dac2SizeL2, enDacRangeL2, enDacXRangeL2,
               dvc1ModeL2, dvc1BEL2, dvc2ModeL2, dvc2BEL2,
               dac1RdL2, dac1WrL2, dac2RdL2, dac2WrL2,
               dvc1RdL2, dvc1WrL2, dvc2RdL2, dvc2WrL2,
               dbsrGroup0,
               enExcL2, dbsrGroup1,
               dbsrGroup2,
               chipResetL2, systemResetL2, dbsrGroup3, dbsrSummaryBit,
               enFreezeTimersL2, dbcrReset_0, dbcrReset_1, 
	       PCL_exeDvcOrParityHold 
               );

output          nxtExeIac1Event, nxtExeIac2Event, nxtExeIac3Event;
output          nxtExeIac4Event;
output          nxtDac1Rd, nxtDac1Wr, nxtDac2Rd, nxtDac2Wr;
output          nxtDvc1Rd, nxtDvc1Wr, nxtDvc2Rd, nxtDvc2Wr;
output  [0:10]  nxtDbsrGroup0;
output          nxtDbsrSummaryBit;
output          nxtHwIac12X, nxtHwIac34X;
output          dbcr0_XE2;
output          iacCntlE1, iacCntlE2, iacCntlSel;
output          dacCntlE1, dacCntlE2, dvcCntlE2;
output          DBG_exeSuppress, DBG_wbDacSuppress, DBG_exeIacSuppress;
output          DBG_icmpEn, DBG_stopReq, DBG_weakStopReq, DBG_intrp;
output          DBG_freezeTimers, DBG_trapEnQ, DBG_udeIntrp, DBG_dacEn;
output          DBG_rstCoreReq, DBG_rstChipReq, DBG_rstSystemReq, DBG_iacEn;
output          DBG_dvcRdEn, DBG_dvcWrEn, DBG_eventSet;
output  [0:1]   nxtDbsrGroup1;
output          nxtDbsrGroup2;
output  [0:1]   nxtDbsrGroup3;
output  [0:4]   DBG_exeTE, DBG_wbTE;
output  [0:2]   DBG_immdTE;
output          DBG_dacIntrp;
output          dbsrE2;
output          dbcr0E2, dbcr1E2, dbcrE1, exeMtdbcr0;
output  [0:1]   sprBusSel;

input           IFB_iac1GtIar, IFB_iac1BitsEq, IFB_iac2GtIar, IFB_iac2BitsEq;
input           IFB_iac3GtIar, IFB_iac3BitsEq, IFB_iac4GtIar, IFB_iac4BitsEq;
input           IFB_stuffStL2, IFB_exeDbgBrTaken, IFB_exeFlush, IFB_exeClear;
input           IFB_dcdFullL2, IFB_exeFullL2, IFB_exeDisableDbL2;
input           IFB_wbDisableDbL2;
input           EXE_dac1Bits0to26Eq, EXE_dac1Bits27to29Eq;
input           EXE_dac1Bits30Eq, EXE_dac1Bits31Eq, EXE_dac1GtDsEa;
input           EXE_dac2Bits0to26Eq, EXE_dac2Bits27to29Eq;
input           EXE_dac2Bits30Eq, EXE_dac2Bits31Eq, EXE_dac2GtDsEa;
input   [0:3]   EXE_dbgSprDcds;
input   [0:31]  EXE_sprDataBus;
input           PCL_exeDbgRdOp, PCL_exeDbgWrOp, PCL_wbDbgIcmp, PCL_dvcCmpEn;
input           PCL_mtSPR, PCL_exeDvcHold, PCL_exeTrap;
input           PCL_sprHold, PCL_exeIarHold, PCL_wbHold, PCL_wbFull;
input           PCL_exeDbgLdOp, PCL_exeDbgStOp;
input           VCT_msrDE, VCT_msrDWE, VCT_wbFlush;
input           VCT_wbErrSuppress, VCT_swapQ01, VCT_swapQ23, JTG_dbgWaitEn;
input           VCT_exeBrTrapErrSuppress;
input           JTG_uncondEvent, JTG_dbdrPulse, JTG_resetDBSR;
input           XXX_uncondEvent;
input           coreResetL2;
input           intDbMode, extDbMode, enIcmpL2, enBrTakenL2, enTrapL2;
input           enIac1L2, enIac2L2, enIac12RangeL2, enIac12XRangeL2;
input           enIac3L2, enIac4L2, enIac34RangeL2, enIac34XRangeL2;
input           enIac12XToggleL2, enIac34XToggleL2;
input           exeIac1EventL2, exeIac2EventL2, exeIac3EventL2, exeIac4EventL2;
input           enDac1RdL2, enDac1WrL2;
input           enDac2RdL2, enDac2WrL2, enDacRangeL2, enDacXRangeL2;
input           dac1RdL2, dac1WrL2, dac2RdL2, dac2WrL2;
input           dvc1RdL2, dvc1WrL2, dvc2RdL2, dvc2WrL2;
input   [0:3]   EXE_dvc1ByteCmp, EXE_dvc2ByteCmp;
input   [0:1]   dac1SizeL2, dac2SizeL2;
input   [0:1]   dvc1ModeL2, dvc2ModeL2;
input   [0:3]   dvc1BEL2, dvc2BEL2;
input   [0:10]  dbsrGroup0;
input           enExcL2;
input   [0:1]   dbsrGroup1;
input           dbsrGroup2;
input           chipResetL2, systemResetL2;
input   [0:1]   dbsrGroup3;
input           dbsrSummaryBit;
input           enFreezeTimersL2, dbcrReset_0, dbcrReset_1;
input           PCL_exeDvcOrParityHold;  // Added for Cobra

wire            dbgSuppressEn;
wire            icmpHwSet, brTakenHwSet, trapHwSet;
wire            iac12RangeCmp, iac34RangeCmp;
wire            dcdIac1Exact, dcdIac1Range, dcdIac2Exact, dcdIac2Range;
wire            dcdIac3Exact, dcdIac3Range, dcdIac4Exact, dcdIac4Range;
wire            iac1HwSet, iac2HwSet, iac3HwSet, iac4HwSet;
wire            dacRangeCmp, dacXRangeCmp1, dacXRangeCmp2;
wire            dac1ExactCmp, dac1Cmp;
wire            blockDac1ForDvc, blockDac2ForDvc;
wire            wbDac1RdEvent, wbDac1WrEvent;
wire            dac1RdHwSet, dac1WrHwSet, dac2RdHwSet, dac2WrHwSet;
wire            dvc1AndCmp, dvc1OrCmp, dvc1AndOrCmp;
wire            lwbDvc1RdEvent, lwbDvc1WrEvent;
wire            dac2ExactCmp, dac2Cmp;
wire            wbDac2RdEvent, wbDac2WrEvent;
wire            dvc2AndCmp, dvc2OrCmp, dvc2AndOrCmp;
wire            lwbDvc2RdEvent, lwbDvc2WrEvent;
wire            dvc1RdPending, dvc1WrPending, dvc2RdPending, dvc2WrPending;
wire            codeSetAccess, codeRstAccess;
wire    [0:10]  group0CodeRst, group0CodeSet, group0HwEvent;
wire    [0:10]  group0ErrorHold, group0HwSet;
wire            group0HwEnable;
wire            excHwSet, udeHwSet;
wire    [0:1]   group1HwSet, group1CodeSet, group1CodeRst;
wire            group1HwEnable;
wire            group2HwSet, group2CodeSet, group2CodeRst;
wire    [0:1]   group3CodeSet, group3CodeRst, rstStatus;
wire            group3HwEnable;
wire            suppressBt, suppressIac, wbSuppressHold;

reg             dac1CmpBits, dac2CmpBits, dvc1Compare, dvc2Compare;

wire            DBG_wbDacSuppress_i;
wire            DBG_exeIacSuppress_i;
wire [0:1]      nxtDbsrGroup1_i;
wire [0:10]     nxtDbsrGroup0_i;

assign DBG_wbDacSuppress = DBG_wbDacSuppress_i;
assign DBG_exeIacSuppress = DBG_exeIacSuppress_i;
assign nxtDbsrGroup1 = nxtDbsrGroup1_i;
assign nxtDbsrGroup0 = nxtDbsrGroup0_i;

// **************************************************************************
// The debug status register is split into 4 sections.
// **************************************************************************
//

// **************************************************************
// Group 0 -                                                    *
// dbsr spr Name      Function                       group0     *
// bit #                                             bit #      *
//  0       Icmp -    Instruction Complete            0         *
//  1       BrTaken - Branch Taken                    1         *
//  3       Trap -    Trap Condition met.             2         *
//  5       IAC1 -    Instruction Address Cmp 1.      3         *
//  6       IAC2 -    Instruction Address Cmp 1.      4         *
//  7       Dac1Rd -  Data Address Cmp 1 for read.    5         *
//  8       Dac1Wr -  Data Address Cmp 1 for write.   6         *
//  9       Dac2Rd -  Data Address Cmp 2 for read.    7         *
// 10       Dac2Wr -  Data Address Cmp 2 for write.   8         *
// 12       IAC3 -    Instruction Address Cmp 1.      9         *
// 13       IAC4 -    Instruction Address Cmp 1.     10         *
// **************************************************************
// The rules for dbsr group0 register updating are: 1) if mtSPR and qualified
// hw set occur at the same time the hw path has precedence.
//
// Purposely left out is dbg suppress since the setting of this latch is the
// cause of dbg suppress.
// error suprress also does not block since debug event has higher priority
// than error. (Icmp - the register loads but with old value.)
// (Setting of RST0 and RST1 and ICMP does not cause suppress.)
// Group 0 has no G1.

// ********************
// Suppress Equations *
// ********************

// Only allow suppressing when in debug mode.
assign dbgSuppressEn = extDbMode |
                       (VCT_msrDWE & JTG_dbgWaitEn & ~intDbMode) |
                       (intDbMode & VCT_msrDE);

// This is the dbg suppress equation.
// icmp does not cause suppress.
// DBG_btSuppress = dbgSuppressEn & brTakenHwSet;
// DBG_trapSuppress = dbgSuppressEn & trapHwSet;
assign DBG_exeIacSuppress_i = dbgSuppressEn &
            (iac1HwSet | iac2HwSet | iac3HwSet | iac4HwSet);
// DBG_exeSuppress does not contain exe iac suppress.
assign DBG_exeSuppress = dbgSuppressEn & (brTakenHwSet | trapHwSet);

// DVC enable causes an exeIarHold. DVC does not cause a suppress.
// DBG_wbSuppress = DBG_wbDacSuppress_i = dbgSuppressEn &
//      (wbDac1RdEvent | wbDac1WrEvent | wbDac2RdEvent | wbDac2WrEvent);
assign DBG_wbDacSuppress_i = dbgSuppressEn &
            (wbDac1RdEvent | wbDac1WrEvent | wbDac2RdEvent | wbDac2WrEvent);

// Must block setting of sxr trap when using trap as debug event
assign DBG_trapEnQ = (extDbMode | (VCT_msrDWE & JTG_dbgWaitEn & ~intDbMode) |
                     (intDbMode & VCT_msrDE)) & enTrapL2;

// ************************************
// Hardware set equations for group0. *
// ************************************

// Don't allow icmp bit to set if in internal debug mode and the msr DE bit
// is zero, unless extDbMode also enabled. It will set all other times.
// Don't want to set icmp debug event when in internal debug mode and debug
// events disabled because code is most likely in exception handler and won't be
// able to clear dbsr bit and return from interrupt with causing another
// icmp exception because rfi will enable VCT_msrDE.
// PCL_wbDbgIcmp has & (~WB_suppress)
// intDbMode overrides VCT_msrDWE won't stop with intDbMode.
// Will bubble after every instruction when icmp is enabled.
assign DBG_icmpEn = enIcmpL2 & ((intDbMode & VCT_msrDE) |
                                 extDbMode |
                                 (VCT_msrDWE & JTG_dbgWaitEn & ~intDbMode));
// icmp occurs in wb. Points to instruction after.
// PCL_wbDbgIcmp contains wbFlush and wbSuppress
assign icmpHwSet = PCL_wbDbgIcmp & enIcmpL2 & ~IFB_stuffStL2 &
                ~IFB_wbDisableDbL2 & (~intDbMode | VCT_msrDE | extDbMode);

// Don't allow brTaken bit to set if in internal debug mode and
// the msr DE bit is zero. See hwSetIcmp. Branch is usually the first
// instruction at exception vector and would set brTakenStatus.
// Won't be able to tell what kind of debug event caused the exception.
// DBG_btSuppress = brTakenHwSet;
// brTaken occurs in exe.
assign brTakenHwSet = IFB_exeDbgBrTaken & enBrTakenL2 & ~IFB_stuffStL2 &
                      ~IFB_exeDisableDbL2 &
                      (~intDbMode | VCT_msrDE | extDbMode);

// DBG_trapSuppress = trapHwSet;
// trap occurs in exe.
assign trapHwSet = PCL_exeTrap & enTrapL2 & ~IFB_stuffStL2 &
                   ~IFB_exeDisableDbL2;

// iacCntl register enables. This is a exe stage register.
assign DBG_iacEn = enIac1L2 | enIac2L2 | enIac3L2 | enIac4L2;
// If Iac is disabled by the instruction following the instruction setting
// the iac then iac could be disabled before event takes place. Iac event
// should still occur.
// Need the output of the register exeIacEvent in E1 for this case to allow the
//   register to reset. (used to use exeFull & enIac)
assign iacCntlE1 = ((enIac1L2 | enIac2L2 | enIac3L2 | enIac4L2) &
                      IFB_dcdFullL2) |
        (exeIac1EventL2 | exeIac2EventL2 | exeIac3EventL2 | exeIac4EventL2) |
        coreResetL2;
// exeFlush contains reset
// iacCntlE2 = exeDataE2 = exeFlush | ~PCL_exeIarHold;
assign iacCntlE2 = IFB_exeFlush | ~PCL_exeIarHold;
assign iacCntlSel = IFB_exeFlush | IFB_exeClear;

// IAC12 range compare
assign iac12RangeCmp = (~intDbMode | VCT_msrDE | extDbMode |
                         ~enIac12XToggleL2) &
                       ((~IFB_iac1GtIar & IFB_iac2GtIar) ^ enIac12XRangeL2);

// IAC1
assign dcdIac1Exact = IFB_iac1BitsEq & ~enIac12RangeL2;
assign dcdIac1Range = iac12RangeCmp & enIac12RangeL2;
// set in dcd
assign nxtExeIac1Event = (dcdIac1Exact | dcdIac1Range) &
                      enIac1L2 & ~IFB_stuffStL2;
// set in exe
assign iac1HwSet = exeIac1EventL2 & ~IFB_exeDisableDbL2;

// IAC2
assign dcdIac2Exact = IFB_iac2BitsEq & ~enIac12RangeL2;
assign dcdIac2Range = iac12RangeCmp & enIac12RangeL2;
// set in dcd
assign nxtExeIac2Event = (dcdIac2Exact | dcdIac2Range) &
                      enIac2L2 & ~IFB_stuffStL2;
// set in exe
assign iac2HwSet = exeIac2EventL2 & ~IFB_exeDisableDbL2;

// IAC34 range compare
assign iac34RangeCmp = (~intDbMode | VCT_msrDE | extDbMode |
                         ~enIac34XToggleL2) &
                       ((~IFB_iac3GtIar & IFB_iac4GtIar) ^ enIac34XRangeL2);

// IAC3
assign dcdIac3Exact = IFB_iac3BitsEq & ~enIac34RangeL2;
assign dcdIac3Range = iac34RangeCmp & enIac34RangeL2;
// set in dcd
assign nxtExeIac3Event = (dcdIac3Exact | dcdIac3Range) &
                      enIac3L2 & ~IFB_stuffStL2;
// set in exe
assign iac3HwSet = exeIac3EventL2 & ~IFB_exeDisableDbL2;

// IAC4
assign dcdIac4Exact = IFB_iac4BitsEq & ~enIac34RangeL2;
assign dcdIac4Range = iac34RangeCmp & enIac34RangeL2;
// set in dcd
assign nxtExeIac4Event = (dcdIac4Exact | dcdIac4Range) &
                      enIac4L2 & ~IFB_stuffStL2;
// set in exe
assign iac4HwSet = exeIac4EventL2 & ~IFB_exeDisableDbL2;

// DAC

// Enable Dac comparators in EXE
assign DBG_dacEn = enDac1RdL2 | enDac2RdL2 | enDac1WrL2 | enDac2WrL2;
// When DVC enabled it is envasive to loads and stores.
//    send signal to allow PCL to generate DVC hold
assign DBG_dvcRdEn = (enDac1RdL2 & (|dvc1BEL2[0:3])) |
                     (enDac2RdL2 & (|dvc2BEL2[0:3]));
assign DBG_dvcWrEn = (enDac1WrL2 & (|dvc1BEL2[0:3])) |
                     (enDac2WrL2 & (|dvc2BEL2[0:3]));
// dacCntl register enables. This is a WB stage register.

//*Can use PCL_exeStorageOp | PCL_wbStorageOp
assign dacCntlE1 = ((enDac1RdL2 | enDac1WrL2 | enDac2RdL2 | enDac2WrL2) &
                     (IFB_exeFullL2 | PCL_wbFull) & ~IFB_stuffStL2 &
                     ~IFB_exeDisableDbL2) |
                   coreResetL2;
// wbFlush contains coreReset.
// wbHold does not contain suppress terms.
// Don't need VCT_wbSuppress as a hold because it's OK for latch to clear since
// Dac has already been recorded in dbsr and is causing the wbFlush or there
// is some other error that will cause the instruciton to be flushed.
assign dacCntlE2 = ~PCL_wbHold | VCT_wbFlush;

// DVC control register indicates that an address comapare has been made for
// DVC and that the data compare is pending.
// DVC is not supported for unaligned operations.
// DVC is not supported for cache ops.
//*Can use PCL_exeStorageOp | PCL_wbStorageOp instead of exeFull and wbFull
// wbFlush contains coreReset.
// wbHold does not contain suppress terms.
// Register will hold value when dvc enabled instruction moves to lwb, because
// PCL_dvcCmpEn will not come on until lwb.
// wbFlush is OK for dvc since dvc will not allow any instruction in wb while
// dvc is pending in lwb, so we can't get a wbFlush while DVC is in lwb.
// Don't need VCT_wbSuppress as a hold because it's OK for latch to clear since
// there is some other error and the instruction will be flushed.
assign dvcCntlE2 = (~PCL_wbHold & ~IFB_stuffStL2 & ~IFB_exeDisableDbL2 &
            (IFB_exeFullL2 | PCL_wbFull) & (|{dvc1BEL2[0:3],dvc2BEL2[0:3]}) &
            (enDac1RdL2 | enDac1WrL2 | enDac2RdL2 | enDac2WrL2) &
            ~dvc1RdPending & ~dvc1WrPending & ~dvc2RdPending & ~dvc2WrPending) |
          PCL_dvcCmpEn | VCT_wbFlush;

// DAC range compare
assign dacRangeCmp = ~EXE_dac1GtDsEa & EXE_dac2GtDsEa & enDacRangeL2 &
                          ~enDacXRangeL2;
// XRange is (EXE_dac1GtDsEa | ~EXE_dac2GtDsEa)
assign dacXRangeCmp1 = EXE_dac1GtDsEa & enDacRangeL2 & enDacXRangeL2;
assign dacXRangeCmp2 = ~EXE_dac2GtDsEa & enDacRangeL2 & enDacXRangeL2;

// DAC1
// Partial compare of least significant address bits based on DAC size. Need
// compare of most significat bits
always @(EXE_dac1Bits27to29Eq or EXE_dac1Bits30Eq or EXE_dac1Bits31Eq or
         dac1SizeL2)
begin
    casez(dac1SizeL2)
        2'b00: dac1CmpBits = EXE_dac1Bits31Eq & EXE_dac1Bits30Eq &
                             EXE_dac1Bits27to29Eq;
        2'b01: dac1CmpBits = EXE_dac1Bits30Eq & EXE_dac1Bits27to29Eq;
        2'b10: dac1CmpBits = EXE_dac1Bits27to29Eq;
        2'b11: dac1CmpBits = 1'b1;
        default: dac1CmpBits = 1'bx;
    endcase
end
assign dac1ExactCmp = EXE_dac1Bits0to26Eq & dac1CmpBits &
                          ~enDacRangeL2;
// DAC events indicate that there has been an address compare. This
// may be used for a DVC or simply as a DAC.
assign dac1Cmp =  dac1ExactCmp | dacRangeCmp | dacXRangeCmp1 | dacXRangeCmp2;
// Must block setting of DAC for address compare only when DVC is enabled.
assign blockDac1ForDvc = |dvc1BEL2[0:3] | (enDacRangeL2 & |dvc2BEL2[0:3]);
// Set in exe.
// DAC will set for certain cache ops. DVC is not set for any cache ops.
// PCL_exeDbgRdOP and PCL_DbgWrOp include appropriate cache ops as well as
//   load and store instructions.
// PCL_exeDbgLdOp and PCL_DbgWrOp include only load and store instructions.
assign nxtDac1Rd = dac1Cmp & PCL_exeDbgRdOp & enDac1RdL2;
assign nxtDac1Wr = dac1Cmp & PCL_exeDbgWrOp & enDac1WrL2;
assign nxtDvc1Rd = dac1Cmp & PCL_exeDbgLdOp & enDac1RdL2;
assign nxtDvc1Wr = dac1Cmp & PCL_exeDbgStOp & enDac1WrL2;

// Dac events
// Dac events occur in wb
assign wbDac1RdEvent = dac1RdL2 & ~blockDac1ForDvc;
assign wbDac1WrEvent = dac1WrL2 & ~blockDac1ForDvc;

// DVC pending. There is an address compare and will need to check data.
assign dvc1RdPending = dvc1RdL2 & |dvc1BEL2[0:3];
assign dvc1WrPending = dvc1WrL2 & |dvc1BEL2[0:3];

// DVC1
assign dvc1AndCmp =  (EXE_dvc1ByteCmp[0] | ~dvc1BEL2[0]) &
                     (EXE_dvc1ByteCmp[1] | ~dvc1BEL2[1]) &
                     (EXE_dvc1ByteCmp[2] | ~dvc1BEL2[2]) &
                     (EXE_dvc1ByteCmp[3] | ~dvc1BEL2[3]);
assign dvc1OrCmp = (EXE_dvc1ByteCmp[0] & dvc1BEL2[0]) |
                   (EXE_dvc1ByteCmp[1] & dvc1BEL2[1]) |
                   (EXE_dvc1ByteCmp[2] & dvc1BEL2[2]) |
                   (EXE_dvc1ByteCmp[3] & dvc1BEL2[3]);
assign dvc1AndOrCmp = ((EXE_dvc1ByteCmp[0] & dvc1BEL2[0]) &
                        (EXE_dvc1ByteCmp[1] & dvc1BEL2[1])) |
                      ((EXE_dvc1ByteCmp[2] & dvc1BEL2[2]) &
                        (EXE_dvc1ByteCmp[3] & dvc1BEL2[3]));

always @(dvc1ModeL2 or dvc1AndCmp or dvc1OrCmp or dvc1AndOrCmp)
begin
    casez(dvc1ModeL2)
        2'b00: dvc1Compare = 1'b0;
        2'b01: dvc1Compare = dvc1AndCmp;
        2'b10: dvc1Compare = dvc1OrCmp;
        2'b11: dvc1Compare = dvc1AndOrCmp;
        default: dvc1Compare = 1'bx;
    endcase
end
// occurs in lwb
assign lwbDvc1RdEvent = dvc1Compare & PCL_dvcCmpEn & dvc1RdPending;
assign lwbDvc1WrEvent = dvc1Compare & PCL_dvcCmpEn & dvc1WrPending;

// DAC2
// Partial compare of least significant address bits based on DAC size. Need
// compare of most significat bits
always @(EXE_dac2Bits27to29Eq or EXE_dac2Bits30Eq or EXE_dac2Bits31Eq or
         dac2SizeL2)
begin
    casez(dac2SizeL2)
        2'b00: dac2CmpBits = EXE_dac2Bits31Eq & EXE_dac2Bits30Eq &
                             EXE_dac2Bits27to29Eq;
        2'b01: dac2CmpBits = EXE_dac2Bits30Eq & EXE_dac2Bits27to29Eq;
        2'b10: dac2CmpBits = EXE_dac2Bits27to29Eq;
        2'b11: dac2CmpBits = 1'b1;
        default: dac2CmpBits = 1'bx;
    endcase
end
assign dac2ExactCmp = EXE_dac2Bits0to26Eq & dac2CmpBits &
                          ~enDacRangeL2;
// DAC events indicate that there has been an address compare. This
// may be used for a DVC or simply as a DAC.
assign dac2Cmp =  dac2ExactCmp | dacRangeCmp | dacXRangeCmp1 | dacXRangeCmp2;
// Must block setting of DAC for address compare only when DVC is enabled.
assign blockDac2ForDvc = |dvc2BEL2[0:3] | (enDacRangeL2 & |dvc1BEL2[0:3]);
// set in exe.
assign nxtDac2Rd = dac2Cmp & PCL_exeDbgRdOp & enDac2RdL2 & ~IFB_stuffStL2 &
                   ~IFB_exeDisableDbL2;
assign nxtDac2Wr = dac2Cmp & PCL_exeDbgWrOp & enDac2WrL2 & ~IFB_stuffStL2&
                   ~IFB_exeDisableDbL2;
assign nxtDvc2Rd = dac2Cmp & PCL_exeDbgLdOp & enDac2RdL2 & ~IFB_stuffStL2 &
                   ~IFB_exeDisableDbL2;
assign nxtDvc2Wr = dac2Cmp & PCL_exeDbgStOp & enDac2WrL2 & ~IFB_stuffStL2&
                   ~IFB_exeDisableDbL2;

// occurs in wb.
assign wbDac2RdEvent = dac2RdL2 & ~blockDac2ForDvc;
assign wbDac2WrEvent = dac2WrL2 & ~blockDac2ForDvc;

// DVC pending. There is an address compare and will need to check data.
assign dvc2RdPending = dvc2RdL2 & |dvc2BEL2[0:3];
assign dvc2WrPending = dvc2WrL2 & |dvc2BEL2[0:3];

// DVC2
assign dvc2AndCmp =  (EXE_dvc2ByteCmp[0] | ~dvc2BEL2[0]) &
                     (EXE_dvc2ByteCmp[1] | ~dvc2BEL2[1]) &
                     (EXE_dvc2ByteCmp[2] | ~dvc2BEL2[2]) &
                     (EXE_dvc2ByteCmp[3] | ~dvc2BEL2[3]);
assign dvc2OrCmp = (EXE_dvc2ByteCmp[0] & dvc2BEL2[0]) |
                   (EXE_dvc2ByteCmp[1] & dvc2BEL2[1]) |
                   (EXE_dvc2ByteCmp[2] & dvc2BEL2[2]) |
                   (EXE_dvc2ByteCmp[3] & dvc2BEL2[3]);
assign dvc2AndOrCmp = ((EXE_dvc2ByteCmp[0] & dvc2BEL2[0]) &
                        (EXE_dvc2ByteCmp[1] & dvc2BEL2[1])) |
                      ((EXE_dvc2ByteCmp[2] & dvc2BEL2[2]) &
                        (EXE_dvc2ByteCmp[3] & dvc2BEL2[3]));
always @(dvc2ModeL2 or dvc2AndCmp or dvc2OrCmp or dvc2AndOrCmp)
begin
    casez(dvc2ModeL2)
        2'b00: dvc2Compare = 1'b0;
        2'b01: dvc2Compare = dvc2AndCmp;
        2'b10: dvc2Compare = dvc2OrCmp;
        2'b11: dvc2Compare = dvc2AndOrCmp;
        default: dvc2Compare = 1'bx;
    endcase
end
// occurs in lwb.
assign lwbDvc2RdEvent = dvc2Compare & PCL_dvcCmpEn & dvc2RdPending;
assign lwbDvc2WrEvent = dvc2Compare & PCL_dvcCmpEn & dvc2WrPending;

// dbsr DAC is shared for DAC and DVC.
// dac occurs in WB. dvc occurs in LWB and points to the next instruction.
assign dac1RdHwSet = wbDac1RdEvent | lwbDvc1RdEvent;
assign dac1WrHwSet = wbDac1WrEvent | lwbDvc1WrEvent;
assign dac2RdHwSet = wbDac2RdEvent | lwbDvc2RdEvent;
assign dac2WrHwSet = wbDac2WrEvent | lwbDvc2WrEvent;

// *********************
// code path equations *
// *********************
assign codeSetAccess = PCL_mtSPR & EXE_dbgSprDcds[3] & ~PCL_sprHold;
assign codeRstAccess = PCL_mtSPR & EXE_dbgSprDcds[2] & ~PCL_sprHold;

// *******************************************
// group0 code set path and code reset path. *
// *******************************************

assign group0CodeSet[0:1] = EXE_sprDataBus[0:1] & ({2{codeSetAccess}});
assign group0CodeSet[2] = EXE_sprDataBus[3] & (codeSetAccess);
assign group0CodeSet[3:4] = EXE_sprDataBus[5:6] & ({2{codeSetAccess}});
assign group0CodeSet[5:8] = EXE_sprDataBus[7:10] & ({4{codeSetAccess}});
assign group0CodeSet[9:10] = EXE_sprDataBus[12:13] & ({2{codeSetAccess}});

assign group0CodeRst[0:1] = EXE_sprDataBus[0:1] & ({2{codeRstAccess}});
assign group0CodeRst[2] = EXE_sprDataBus[3] & (codeRstAccess);
assign group0CodeRst[3:4] = EXE_sprDataBus[5:6] & ({2{codeRstAccess}});
assign group0CodeRst[5:8] = EXE_sprDataBus[7:10] & ({4{codeRstAccess}});
assign group0CodeRst[9:10] = EXE_sprDataBus[12:13] & ({2{codeRstAccess}});

// *******************************
// group 0 data input equations. *
// *******************************

assign group0HwEvent[0:10] = {icmpHwSet,brTakenHwSet,trapHwSet,iac1HwSet,
             iac2HwSet,dac1RdHwSet,dac1WrHwSet,dac2RdHwSet,dac2WrHwSet,
             iac3HwSet,iac4HwSet};

// VCT_wbErrSuppress =  (PCL_algnErr & ~MMUdsStateBorC) | (|MMU_dsStatus[5:7]);
// VCT_exeBrTrapErrSuppress = isiSet | iMissSet | iSideMachChkSet;
// icmp bubbles all instructions until complete. Icmp sets in Wb. No other
//   suppress can effect icmp.
// brTaken has exeFlush.
// iac sets even with exeIarHold
// dac occurs in wb.
// dvc and dac use same dbsr bit. dvc causes an exeIarHold so a wbSuppress
//   can not occur with dvc. dvc occurs in lwb.
//   Trap won't make it to exeC1 if there is a exeErrSuppress.
//*Comments may not be valid. See change history.

//assign suppressBt = VCT_wbErrSuppress | PCL_wbHold | PCL_exeDvcHold |
//                    DBG_exeIacSuppress_i | DBG_wbDacSuppress_i |
//                    VCT_exeBrTrapErrSuppress;

assign suppressBt = VCT_wbErrSuppress | PCL_wbHold | PCL_exeDvcOrParityHold |
                    DBG_exeIacSuppress_i | DBG_wbDacSuppress_i |
                    VCT_exeBrTrapErrSuppress;

//assign suppressIac = VCT_wbErrSuppress | PCL_wbHold |
//                     DBG_wbDacSuppress_i | PCL_exeDvcHold;

assign suppressIac = VCT_wbErrSuppress | PCL_wbHold |
                     DBG_wbDacSuppress_i | PCL_exeDvcOrParityHold;

assign wbSuppressHold = VCT_wbErrSuppress | PCL_wbHold;
assign group0ErrorHold[0:10] = ({1'b0,suppressBt,1'b0,
                                 suppressIac,suppressIac,
                                 wbSuppressHold,wbSuppressHold,
                                 wbSuppressHold,wbSuppressHold,
                                 suppressIac,suppressIac});

assign group0HwSet[0:10] = group0HwEvent[0:10] & ~group0ErrorHold[0:10] &
                          ~({1'b0,{4{IFB_exeFlush}},{4{VCT_wbFlush}},
                           {2{IFB_exeFlush}}});

assign nxtDbsrGroup0_i[0:10] =
    (group0CodeSet[0:10]) |
    (dbsrGroup0[0:10] & ~group0CodeRst[0:10] &
        {11{~(JTG_dbdrPulse | JTG_resetDBSR)}}) |
    group0HwSet[0:10];

assign group0HwEnable =  enIcmpL2 | enBrTakenL2 |  enTrapL2 |
                       enIac1L2 | enIac2L2 | enDac1RdL2 | enDac1WrL2 |
                         enDac2RdL2 | enDac2WrL2 | enIac3L2 | enIac4L2;

// **************************************************************
// Group 1 -                                                    *
// dbsr spr Name      Function                       group1     *
// bit #                                             bit #      *
//  2       Exc -     Exception Taken                 0         *
//  4       UDE -     Unconditional Debug Event       1         *
// **************************************************************
// ************************************
// Hardware set equations for group1. *
// ************************************
//
// Group1 hw sets do not cause suppress because on exc we are
// swapping and unconditional does not need to suppress the current
// instruction since it is asynchronous to the instruction stream.
// Exception debug event is set for any non-critical interrupt, any interrupt
// in external debug mode, and only for non-critical interrupts in internal
// debug mode without external debug mode.
// In internal debug mode a critical interrupt will go through its interrupt
// handler and be cleared before the exception interrupt handler can see it,
// so there is no point in setting a debug event for them.
// Don't need ~IFB_stuffStL2 because swapQ is enabled with swapEnable. Swap
// enable can't come on in stuffSt
assign excHwSet = enExcL2 & (VCT_swapQ01 | (VCT_swapQ23 & ~intDbMode) |
                       (VCT_swapQ23 & extDbMode));

// Nothing stops ude from setting dbsr.
assign udeHwSet = JTG_uncondEvent| XXX_uncondEvent;

assign group1HwSet[0:1] = {excHwSet,udeHwSet};

// *******************************************
// group1 code set path and code reset path. *
// *******************************************

assign group1CodeSet[0] = EXE_sprDataBus[2] & codeSetAccess;
assign group1CodeSet[1] = EXE_sprDataBus[4] & codeSetAccess;

assign group1CodeRst[0] = EXE_sprDataBus[2] & codeRstAccess;
assign group1CodeRst[1] = EXE_sprDataBus[4] & codeRstAccess;

// *******************************
// Group 1 data input equations. *
// *******************************

assign nxtDbsrGroup1_i[0:1] = (group1CodeSet) |
        (dbsrGroup1 & ~group1CodeRst & {2{~(JTG_dbdrPulse | JTG_resetDBSR)}}) |
        group1HwSet;

assign group1HwEnable = enExcL2 | udeHwSet;

// **************************************************************
// Group 2 -                                                    *
// dbsr spr Name      Function                       group2     *
// bit #                                             bit #      *
//  11      Imprec -  Imprecise Debug Event           0         *
// **************************************************************
// ******************
// group2 Equations *
// ******************
// This is the "debug event occurred while msrDE=0" signal.
// Don't need a group2HwEnable since it must occur with another debug event.
assign group2HwSet = ~VCT_msrDE & ((|group0HwSet) | (|group1HwSet));
assign group2CodeSet = codeSetAccess & EXE_sprDataBus[11];
assign group2CodeRst = codeRstAccess & EXE_sprDataBus[11];
assign nxtDbsrGroup2 = (group2CodeSet) |
        (dbsrGroup2 & ~group2CodeRst & ~(JTG_dbdrPulse | JTG_resetDBSR)) |
        group2HwSet;

// **************************************************************
// Group 3 -                                                    *
// dbsr spr Name      Function                       group3     *
// bit #                                             bit #      *
// 22       RstStat0 - Dbcr initiated Reset Status.   0         *
// 23       RstStat1 - Dbcr initiated Reset Status.   1         *
// **************************************************************

// *******************************************
// group3 code set path and code reset path. *
// *******************************************

assign group3CodeSet[0:1] = EXE_sprDataBus[22:23] & ({2{codeSetAccess}});

assign group3CodeRst[0:1] = EXE_sprDataBus[22:23] & ({2{codeRstAccess}});

// The dbsr reset status bits update with all resets, not just those initiated
// by the dbcr.

// group3HwSet = rstStatus
// coreReset is active with core,chip or sys reset.
assign rstStatus[0] = chipResetL2 | systemResetL2;
assign rstStatus[1] = systemResetL2 | (coreResetL2 & ~chipResetL2);

assign nxtDbsrGroup3[0:1] =
    (group3CodeSet[0:1]) |
    (dbsrGroup3[0:1] & ~group3CodeRst[0:1] & ~({2{coreResetL2}}) |
    rstStatus[0:1]);

assign group3HwEnable = coreResetL2;

// ***************************
// debug interrupt
// ***************************
assign nxtDbsrSummaryBit = (|nxtDbsrGroup0_i) | (|nxtDbsrGroup1_i);

// *********
// dbsr E2
// *********
assign dbsrE2 = (group0HwEnable | group1HwEnable | group3HwEnable |
                  PCL_mtSPR | JTG_dbdrPulse | JTG_resetDBSR);

// ******
// Trace
// ******
// brTaken, iac1, iac2, iac3, iac4
assign DBG_exeTE[0:4] = {(group0HwSet[1] | group0CodeSet[1]),
                         (group0HwSet[3] | group0CodeSet[3]),
                         (group0HwSet[4] | group0CodeSet[4]),
                         (group0HwSet[9] | group0CodeSet[9]),
                         (group0HwSet[10] | group0CodeSet[10])};
// icmp, dac1Rd, dac1Wr, dac2Rd, dac2Wr
// DBG_wbTE is qualified with wbHold, wbSuppress, wbFlush in IFB.
assign DBG_wbTE[0:4] =  {(group0HwEvent[0] | group0CodeSet[0]),
                         (group0HwEvent[5] | group0CodeSet[5]),
                         (group0HwEvent[6] | group0CodeSet[6]),
                         (group0HwEvent[7] | group0CodeSet[7]),
                         (group0HwEvent[8] | group0CodeSet[8])};
// trap, exc, ude.
// For trap and exc the instruction is always flushed and will not finish
//   flowing through the pipe. TE is directly staged to trace logic through
//   a register without anything that can block it.
//   A trap taking an execption will be suppressed and flushed. SRR will
//   point to the address of the trap. Will not get ES for the trap completing.
// Ude is asycronous. Also need to be staged directly to trace logic
assign DBG_immdTE[0:2] = {(group0HwSet[2] | group0CodeSet[2]),
                          (group1HwSet[0]) | (group1CodeSet[0]),
                          (group1HwSet[1]) | (group1CodeSet[1])};

// *********************************
// Stop Request and debug interrupt
// *********************************
assign DBG_stopReq = extDbMode & dbsrSummaryBit;
assign DBG_weakStopReq = ~(extDbMode | intDbMode) & VCT_msrDWE &
                JTG_dbgWaitEn & dbsrSummaryBit;
assign DBG_intrp = intDbMode & VCT_msrDE & dbsrSummaryBit;
assign DBG_udeIntrp = intDbMode & VCT_msrDE & dbsrGroup1[1];
assign DBG_dacIntrp = intDbMode & VCT_msrDE & (|dbsrGroup0[5:8]);

assign DBG_freezeTimers = (extDbMode | (VCT_msrDWE & JTG_dbgWaitEn) |
                               intDbMode) & dbsrSummaryBit & enFreezeTimersL2;

assign DBG_rstCoreReq  = ~dbcrReset_0 & dbcrReset_1;
assign DBG_rstChipReq  = dbcrReset_0 & ~dbcrReset_1;
assign DBG_rstSystemReq = dbcrReset_0 & dbcrReset_1;

assign dbcrE1 = PCL_mtSPR  | coreResetL2;
assign dbcr0E2 = (~PCL_sprHold & EXE_dbgSprDcds[0]) | coreResetL2;
assign dbcr1E2 = (~PCL_sprHold & EXE_dbgSprDcds[1]) | coreResetL2;

assign sprBusSel[0] = EXE_dbgSprDcds[1] | EXE_dbgSprDcds[2];
assign sprBusSel[1] = EXE_dbgSprDcds[0] | EXE_dbgSprDcds[2];

// All debug event except ude
assign DBG_eventSet = (|dbsrGroup0) | dbsrGroup1[0];
//assign DBG_udeEventSet = dbsrGroup1[1];

// Toggle inclusive/exclusive mode.
assign nxtHwIac12X = enIac12XRangeL2 ^
                     (enIac12XToggleL2 & (iac1HwSet | iac2HwSet));
assign nxtHwIac34X = enIac34XRangeL2 ^
                     (enIac34XToggleL2 & (iac3HwSet | iac4HwSet));
assign dbcr0_XE2 = (~PCL_sprHold & EXE_dbgSprDcds[0] & PCL_mtSPR) |
                    group0HwSet[3] | group0HwSet[4] | group0HwSet[9] |
                    group0HwSet[10] | coreResetL2;
assign exeMtdbcr0 = ~PCL_sprHold & PCL_mtSPR & EXE_dbgSprDcds[0];


endmodule
