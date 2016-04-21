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
//===========================================================================
// Verilog HDL for "PR_mmu", "mmu_control" "_functional"
//===========================================================================
//===========================================================================
//  Changes:
//  DATE--             ------------ DESCRIPTION ------------------------
//  02/18/98  KAM   Started design using Maverick as an example
//  03/23/98  KAM   Deleted MMU_isGuarded. Might be added later for timing
//  04/23/98  KAM   Removed blkFlush per meeting w/ Jim on 4/22
//  04/23/98  KAM   Added State D to tlb instr state machine for holding
//                   the data on a tlbRead or tlbSearch
//  07/14/98  KAM   cdbcrFDK no longer forces the K attribute to zero.
//                  added U0Fault. cdbcrFDK enables it
//  08/05/98  KAM   Removed wbAbort from dcuUTLBAbort. DCU get it from VCT
//  08/05/98  KAM   added alignment error.
//                  Removed NOP errors from dsStatus bus
//                  Seperated dsStatus into once for MISS (UTLB) and HIT (Shadow)
//                  expanded dsStatus bus into 8 bits
//  08/10/98  KAM   Added MMU_dsStateBorC signal to CPU
//  10/12/98  KAM   Deleted MMU_icuIsAbort. Ron no longer needs it. IFB uses IsStatus
//  11/2/98   KAM   Added MMU_icuIsAbort back it is needed for G storage errors
//  11/10/98  KAM   Removed all BufferMod/Suppress Read Logic
//  11/19/99  RDE   Modified clock generation for new UTLB
//  02/23/00  RDE   Implemented changes made to Prowler by Karen Mitchell.
//                  These were put in place to fix problem defined in prowler
//                  issue 173.
//  09/29/00  KVP   Updates made to UTLB_clocks EN_ARRAYL1_preTestM3 as output
//  10/13/00  KVP/WGLee copied from local workspace
//  07/16/01  TRI   Adding parity to MMU
//  09-18-01  JRS  Replacing UTLB_V with 1'b1 since will only report parity errors for valid entries (UTLB_V = 1'b1).
//                  Done to match gates for formality.
//  02/18/02  KAM   Changed LSSD_ArrayCClk_NEG to LSSD_ArrayCClk_buf for TBIRD
//===========================================================================

module p405s_mmu_control (
                    MMU_isStatus,
                    MMU_isXltValid,
                    MMU_icuDsAbort,
                    MMU_isRA,
                    msrIrL2forITLB,
                    LoadRealRaAttr,
                    MMU_dsStatus,
                    MMU_dcuXltValid,
                    MMU_dcuUTLBAbort,
                    MMU_dcuShadowAbort,
                    MMU_dsRA,
                    MMU_wbHold,
                    MMU_tlbSXHit,
                    MMU_dsStateBorC,
                    msrDrL2forDTLB,
                    MMU_icuIsAbort,
                    marRPN,
                    marDSize,
                    marE,
                    marU0,
                    marWR,
                    marW,
                    marG,
                    marCacheable,
                    marZonePR,
                    sprRegE2,
                    iccrE1,
                    dccrE1,
                    sgrE1,
                    slerE1,
                    skrE1,
                    pidE1,
                    pidE2,
                    zoneE1,
                    dcwrE1,
                    seldccr,
                    seliccr,
                    selzone,
                    selpid,
                    selsgr,
                    dearE1,
                    dearE2,
                    seldcwr,
                    selsler,
                    selskr,
                    seldear,
                    MMU_BMCO,
                    pidIn_N,
                    size_out,
                    sprMuxSel,
                    wbStorageOp,
                    bypassRPN,
                    dsStateAfromLatch,
                    dsStateD,
                    dsAddrL2,
                    dsrdNotWrt,
                    dsEAL,
                    dsInvalidate,
                    isAddrL2,
                    isInvalidate,
                    isrdNotWrt,
                    isEAL,
                    CompE2,
                    tlbAddr,
                    tagEn,
                    dataEn,
                    rdWrb,
                    indexLookupb,
                    EN_ARRAYL1,
                    TestComp,
                    EN_C1,
                    tlb_invalidate,
                    tlbE,
                    tlbU0,
                    DT,
                    TID,
                    EPN_EA,
                    DSIZE,
                    RPN,
                    tlbV,
                    EX,
                    WR,
                    ZSEL,
                    tlbW,
                    tlbCacheInhibit,
                    tlbM,
                    tlbG,
                    isIReal_N,
                    isDsIReal_N,
                    isEReal_N,
                    isU0Real_N,
                    dsIReal_N,
                    dsGReal_N,
                    dsEReal_N,
                    dsU0Real_N,
                    wtReqReal_N,
                    fetchReq,
                    isEA_NEG,
                    nonSpecAcc,
                    isAbort,
                    cntxSync,
                    msrIR,
                    isNP,
                    isCA,
                    EoOdd,
                    CancelData,
                    icuOp,
                    isNewLine,
                    msrPR,
                    msrDR,
                    LdNotSt,
                    wbAbort,
                    dcuOp,
                    dsMmuOp,
                    dsEA_N,
                    ICU_dsCA,
                    DCU_CA,
                    cdbcrFDK,
                    dcuLoad,
                    dcuStore,
                    dcbz,
                    dcba,
                    VCT_mmuExeSuppress,
                    IFB_exeFlush,
                    PCL_mmuExeAbort,
                    tlbSX,
                    tlbWE,
                    tlbRE,
                    tlbWC,
                    exeTlbOp,
                    sprAddr,
                    SprDcd,
                    sprData,
                    mtSPR,
                    mfSPR,
                    sprHold,
                    VCT_dearE2,
                    iccrL2,
                    dccrL2,
                    dcwrL2,
                    slerL2,
                    skrL2,
                    sgrL2,
                    pidL2,
                    zoneL2,
                    UTLB_DSize,
                    UTLB_EPN,
                    UTLB_V,
                    UTLB_E,
                    UTLB_U0,
                    UTLB_TID,
                    UTLB_Miss,
                    UTLB_RPN,
                    UTLB_EX,
                    UTLB_WR,
                    UTLB_ZSEL,
                    UTLB_W,
                    UTLB_CacheInhibit,
                    UTLB_G,
                    dtlbMiss,
                    DTLB_zonePR,
                    DTLB_WR,
                    DTLB_U0,
                    DTLB_I,
                    DTLB_W,
                    itlbMiss,
                    PCL_wbHoldnonErr,
                    exeStorageOp,
                    resetL2,
                    CB,
                    TestM1,
                    TestM3,
                    LSSD_ArrayCClk_buf,
                    BIST_wrEn,
                    BIST_rdEn,
                    BIST_addr,
                    BIST_lookupEn,
                    BIST_epn_ea,
                    BIST_DSize,
                    BIST_TID,
                    BIST_data,
                    BIST_DT,
                    BIST_V,
                    BIST_invalidate,
                    ABIST_test,
                    EN_ARRAYL1_preTestM3,
                    UTLB_DT,
                    MMU_tlbREParityErr,
                    MMU_tlbSXParityErr,
                    MMU_dsParityErr,
                    MMU_isParityErr,
                    tagPar1,
                    tagPar2,
                    tagPar3,
                    tagPar4,
                    ramPar1,
                    ramPar2,
                    UTLB_T1,
                    UTLB_T2,
                    UTLB_T3,
                    UTLB_T4,
                    UTLB_R1,
                    UTLB_R2,
                    UTLB_M,
                    ICU_CCR1TLBE,
                    ICU_CCR0TPE
                    );

//===========================================================================
// Input and Output declarations
//===========================================================================
// I-Side outputs
output [0:1]   MMU_isStatus;        // Status for current instruction
output         MMU_isXltValid;      // Xlate Valid for current instruction
output         MMU_icuDsAbort;      // Abort current icuOp
output         MMU_icuIsAbort;      // Abort current fetch request
output [22:29] MMU_isRA;            // i-side translated Address
output         isIReal_N;             // Real Mode is Cacheable
output         isDsIReal_N;         // Real Mode icu ds Cacheable
output         isEReal_N;             // Real Mode is Endian
output         isU0Real_N;            // Real Mode is Kompressed
output         msrIrL2forITLB;      // Latch the msrIR for timing and load control
output         LoadRealRaAttr;      // Value of msrIR going into the latch

// D-Side Outputs
output [0:7]   MMU_dsStatus;        // Status for current d-side Op
//output         MMU_dcuSuppressRead; // current d-side address
output         MMU_dcuXltValid;     // Xlate Valid for current d-side Op
output         MMU_dcuShadowAbort;  // Abort current dcuOp
output         MMU_dcuUTLBAbort;    // Abort current dcuOp
output [22:29] MMU_dsRA;            // d-side translated address
output         dsIReal_N;           // Real Mode ds Cacheable
output         dsGReal_N;           // Real Mode ds Guarded
output         dsEReal_N;           // Real Mode ds Endian
output         dsU0Real_N;          // Real Mode ds Kompressed
output         wtReqReal_N;         // Real Mode write through request
output         MMU_wbHold;          // Hold current instruction in writeback
output         MMU_tlbSXHit;        // Hit occurred from current tlbSX instruction
output         MMU_dsStateBorC;     // Ds State Machine is in state B or C
output         msrDrL2forDTLB;      // Latch the msrDR for timing and load control
output [0:21]  bypassRPN;

// spr outputs
output         sprRegE2;            // E1 gate for all SPR reg except PID
output         pidE1;               // E1 gate for PID
output         dearE1;              // E1 gate for DEAR reg
output         dearE2;              // E2 gate for DEAR reg
output         iccrE1;              // E2 gate for ICCR reg
output         dccrE1;              // E2 gate for DCCR reg
output         slerE1;              // E2 gate for SLER reg
output         skrE1;               // E2 gate for SKR  reg
output         sgrE1;               // E2 gate for SGR  reg
output         zoneE1;              // E2 gate for ZONE reg
output         dcwrE1;              // E2 gate for DCWR reg
output         pidE2;               // E2 gate for PID  reg
output         seldccr;             // SPR instr. is to DCCR reg
output         seliccr;             // SPR instr. is to ICCR reg
output         selzone;             // SPR instr. is to ZONE reg
output         selpid;              // SPR instr. is to PID  reg
output         selsgr;              // SPR instr. is to SGR  reg
output         seldcwr;             // SPR instr. is to DCWR reg
output         selsler;             // SPR instr. is to SLER reg
output         selskr;              // SPR instr. is to SKR  reg
output         seldear;             // SPR instr. is to DEAR  reg
output         MMU_BMCO;            // spr Blocking Multiple cycle command
output [0:7]   pidIn_N;               // Input to PID reg
output [0:2]   size_out;            // encoded size for a tlb read
output [0:1]   sprMuxSel;           // Mux Select for SPR data bus

// outputs to the D-Side Shadow
output         dsStateD;            // D-side state machine is in State D
output [0:2]   dsAddrL2;            // DTLB address
output         dsrdNotWrt;          // DTLB RnW
output [0:31]  dsEAL;               // Latched DTLB EA (sent to DTLB for writing)
output         dsStateAfromLatch;
output         dsInvalidate;    // invalidate for is and ds shadow

// outputs to shadow form MAR
output [0:21]  marRPN;              // RPN stored in MAR from ITLB/DTLB Miss
output [0:6]   marDSize;            // DSize stored in MAR from ITLB/DTLB Miss
output         marE;                // E stored in MAR from ITLB/DTLB Miss
output         marU0;               // K stored in MAR from ITLB/DTLB Miss
output         marWR;               // WR stored in MAR from ITLB/DTLB Miss
output         marW;                // W stored in MAR from ITLB/DTLB Miss
output         marG;                // G stored in MAR from ITLB/DTLB Miss
output         marCacheable;        // I stored in MAR from ITLB/DTLB Miss
output [0:1]   marZonePR;           // ZonePR stored in MAR from ITLB/DTLB Miss

// outputs to the I-Side Shadow
output [0:1]   isAddrL2;            // ITLB address
output         isInvalidate;        // invalidate for is and ds shadow
output         isrdNotWrt;          // ITLB RnW
output [0:21]  isEAL;               // ITLB effective address
//output [0:21]  isEAL_NEG;         // ITLB effective address inverted
output         CompE2;              // isEAL_E2 to the shadows

// outputs to the UTLB
output [0:5]   tlbAddr;             // UTLB Address for Read or Write
output         tagEn;               // UTLB tag Enable
output         dataEn;              // UTLB ram enable
output         rdWrb;               // UTLB RnW  input
output         indexLookupb;        // UTLB index not Lookup  input
output         tlb_invalidate;      // UTLB latched invalidate input
output         tlbE;                // UTLB E input
output         tlbU0;               // UTLB U0 input
output         DT;                  // UTLB DT input
output [0:7]   TID;                 // UTLB TID input
output [0:21]  EPN_EA;              // UTLB Effective Address input
output [0:6]   DSIZE;               // UTLB DSize input
output [0:21]  RPN;                 // UTLB RPN input
output         tlbV;                // UTLB V input
output         EX;                  // UTLB EX input
output         WR;                  // UTLB WR input
output [0:3]   ZSEL;                // UTLB ZSEL input
output         tlbW;                // UTLB W input
output         tlbCacheInhibit;     // UTLB I input
output         tlbM;                // UTLB M input
output         tlbG;                // UTLB G input
output         TestComp;            // UTLB TestComp input
output         EN_ARRAYL1;          // UTLB EN_ARRAYL1 input
output         EN_C1;               // UTLB C1Clock Enable input
output         EN_ARRAYL1_preTestM3; //old camClock
// TRI 07/17/01
// New outputs for parity to UTLB
output         tagPar1;             // UTLB tag 1 parity bit
output         tagPar2;             // UTLB tag 2 parity bit
output         tagPar3;             // UTLB tag 3 parity bit
output         tagPar4;             // UTLB tag 4 parity bit
output         ramPar1;             // UTLB ram 1 parity bit
output         ramPar2;             // UTLB ram 2 parity bit
// TRI 07/17/01
// New outputs for parity to UTLB
output         MMU_tlbREParityErr;  // tlb read parity error
output         MMU_tlbSXParityErr;  // tlb search parity error
output         MMU_isParityErr;     // MMU has a IS parity error
output         MMU_dsParityErr;     // MMU has a DS parity error

// I-Side inputs
input          fetchReq;            // fetch Request
input [0:29]   isEA_NEG;            // I-side effective address
input          nonSpecAcc;          // An instruction is in decode
input          isAbort;             // Abort current instruction
input          cntxSync;            // Context Sync
input          msrIR;               // translate instruction
input          isNP;                // Crossing 1K boundary
input          isCA;                // I-side Command Accept
input          icuOp;               // I-cache Op
input          EoOdd;               // ICU Odd Data Valid
input          CancelData;          // Cancel current instruction
input          isNewLine;           // PLB instr is to a new line in the page

// ds inputs
//input          DCU_mmuBufferMod;    // DCU has modified buffer reset valid
input          msrPR;               // Protection bit in MSR reg
input          msrDR;               // translate data
input          LdNotSt;             // Load instruction taking place
input          wbAbort;             // Abort current instruction in writeback
//input          exeAbort;            // Abort current instruction in execute
input          dcuOp;               // d-cache op
input          dcuLoad;             // d-cache op is a load
input          dcuStore;            // d-cache op is a store
input          dcbz;                // d-cache op is a dcbz
input          dcba;                // d-cache op is a dcba
input  [0:3]   dsMmuOp;             // type of ds Op
input  [0:31]  dsEA_N;              // ds effective address for translation
input          ICU_dsCA;            // ICU d-side Command Accept
input          DCU_CA;              // DCU Command Accept
input          cdbcrFDK;            // Debug data Kompressed
input          PCL_wbHoldnonErr;          // Instruction in write back is being held
input          exeStorageOp;        // A Storage Op is in exe
input          VCT_mmuExeSuppress;
input          IFB_exeFlush;
input          PCL_mmuExeAbort;     // Abort current instruction in execute

// spr inputs
input          tlbSX;               // tlb search is in execute
input          tlbWE;               // tlb write is in execute
input          tlbRE;               // tlb read is in execute
input          tlbWC;               // write/read the tag/data (0: tag 1:data)
input          exeTlbOp;
input          wbStorageOp;         // Storage op is in writeback

input  [4:9]   sprAddr;             // address for the spr instruction
input  [0:8]   SprDcd;              // decode for the spr instruction
input  [0:31]  sprData;             // data for the spr instruction
input          mtSPR;               // mtSPR instruction is in execute
input          mfSPR;               // mfSPR instruction is in execute
input          sprHold;             // hold the current spr instruction
input          VCT_dearE2;

// SPR Registers
input  [0:31]  iccrL2;              // iccr spr register
input  [0:31]  dccrL2;              // dccr spr register
input  [0:31]  dcwrL2;              // dcwr spr register
input  [0:31]  slerL2;              // slerspr register
input  [0:31]  skrL2;               // skr spr register
input  [0:31]  sgrL2;               // sgr spr register
input  [0:7]   pidL2;               // pid spr register
input  [0:31]  zoneL2;              // zone spr register

// UTLB inputs
input  [0:6]   UTLB_DSize;          // decoded size bits from UTLB read
input  [0:21]  UTLB_EPN;            // effective page number from UTLB read
input  [0:7]   UTLB_TID;            // TID from UTLB read
input          UTLB_V;              // valid bit from UTLB read
input          UTLB_E;              // endian bit from UTLB read
input          UTLB_U0;             // U0 Attribute from UTLB read
input  [0:21]  UTLB_RPN;            // real page number from UTLB read
input          UTLB_EX;             // execute attrfrom UTLB read
input          UTLB_WR;             // write attr from UTLB read
input  [0:3]   UTLB_ZSEL;           // zone select bits from UTLB read
input          UTLB_W;              // write thru from UTLB read
input          UTLB_CacheInhibit;   // cacheInhibit from UTLB read
input          UTLB_G;              // guarded from UTLB read
input          UTLB_Miss;           // UTLB miss
// TRI 07/18/01
// New inputs for parity from UTLB read
input          UTLB_T1;             // UTLB tag 1 parity bit
input          UTLB_T2;             // UTLB tag 2 parity bit
input          UTLB_T3;             // UTLB tag 3 parity bit
input          UTLB_T4;             // UTLB tag 4 parity bit
input          UTLB_R1;             // UTLB ram 1 parity bit
input          UTLB_R2;             // UTLB ram 2 parity bit

input          dtlbMiss;            // d-side shadow miss
input  [0:1]   DTLB_zonePR;         // zone protection bit from the DTLB
input          DTLB_WR;             // WR from d-side Shadow
input          DTLB_U0;             // U0 from d-side Shadow
input          DTLB_I;              // I from d-side Shadow
input          DTLB_W;              // W from d-side Shadow
input          itlbMiss;            // i-side shadow miss

// Clock/Test inputs
input          resetL2;             // reset
input          CB;                  // clock bus
input          TestM1;              // Array Test is being performed
input          TestM3;              // Diagnostics is being performed.
                                    // Clocks to UTLB are blocked when active
input          LSSD_ArrayCClk_buf;       // CClk for UTLB clocks

// CBIST/ABIST inputs
input          ABIST_test;          // ABIST portion of test is being ran
input          BIST_wrEn;           // wrEn from the BIST unit
input          BIST_rdEn;           // rdEn from the BIST unit
input  [0:1]   BIST_data;           // data from the BIST unit
input  [0:5]   BIST_addr;           // addr from the BIST unit
input          BIST_lookupEn;       // lookupEn from the BIST unit
input  [0:21]  BIST_epn_ea;         // epn_ea from the BIST unit
input  [0:6]   BIST_DSize;          // DSize from the BIST unit
input  [0:7]   BIST_TID;            // TID from the BIST unit
input          BIST_DT;             // DT from the BIST unit
input          BIST_V;              // V from the BIST unit
input          BIST_invalidate;     // invalidate from the BIST unit

// TRI 07/17/01
// New input for parity
input          UTLB_DT;             // DT bit from UTLB
input          UTLB_M;              // M bit from UTLB
input          ICU_CCR1TLBE;        // Parity Injector
input          ICU_CCR0TPE;

//===========================================================================
// Wire and Register declarations
//===========================================================================
wire         isGReal_N;           // Real Mode isGuarded
//wire         dsU0R;             // Real Mode dsU0R from SPR

//wire         ramtest;           // abist test is taking place
wire [0:2]   sprDataBits22to24; // bits 22-24 of sprDBus
//wire         shadowInvalidate;  // invalidate for is and ds shadow
wire         tlbInvalidateIn;   // input to tlb invalidate latch
reg          tlbInvalidateL2;   // latched tlb invalidate command
wire         tlbia;             // decoded tlbia command
wire         tlbReq;            // tlb instr is requesting the UTLB
wire         utlbStE2;          // E1 gate for UTLB state and tlbia reg
wire [0:1]   tlbStateIn;        // Input to tlb instr state machine
reg  [0:1]   tlbStateL2;        // tlb instr State MAchine
wire         tlbStateA;         // tlb instr is in State A
wire         tlbStateB;         // tlb instr is in State B
wire         tlbStateC;         // tlb instr is in State C
wire         tlbStateD;         // tlb instr is in State D
//wire         tlbwait;           // tlb instr is waiting due to sprhold or wbStorageOp
wire [0:1]   EPN_EA_MuxSel;     // Mux to select whether EPN or EA is sent to UTLB
wire         rdEn;              // UTLB read Enable
wire         wrEn;              // UTLB write enable
wire         LookupEn;          // UTLB lookup enable
wire         indexEn;           // utlb index enable (Read or Write)
//wire [0:21]  EPN;               // UTLB Effective Page number
//wire         tlbIdle;           // No instruction is being sent to UTLB

//wire         OsrIn;             // Input to Outstanding Request Latch
wire         OsrL2_N;             // Outstandin Request
wire         cancelReq;
reg          CancelDataL2;

reg  [0:1]   isStateIn;         // Next isState
reg  [0:1]   isStateL2;         // instr. shadow state machine data
wire         isStateE2;         // instr. shadow state machine enable
wire         isStateA;          // instr. shadow is in state A
wire         isStateB;          // instr. shadow is in state B
wire         isStateC;          // instr. shadow is in state C
wire         isStateD;          // instr. shadow is in state D
wire         goToisStateA;      // Next state is isStateA
wire [0:1]   isAddrIn;          // input to ITLB address REG
reg  [0:1]   isAddrL2_i;          // ITLB Address to be written
wire         isAddrE2;          // Gate term for ITLB Address
wire         wrtITLB;           // Write enable for ITLB
wire         isEA0_21_E2_EO;   // Load signal for isEA latch
wire         isEA0_21_E2noEO;   // Load signal for isEA latch
wire         isEA0_21_E2_NEG;   // Load signal for isEA latch
wire         isEA0_21_E2toRedrive_NEG;
wire         isEA0_21_E2;   // Load signal for isEA latch
wire         isEA0_21_E2forMsrIR_NEG;
wire         isEA0_21_E2forComp_NEG;
wire         EoOdd_N;
wire [0:29]  isEA;
wire [0:21]  isEAL2fromReg_NEG;     // isEA from fast latch. Gets repowered
reg  [0:21]  isEAL2fromReg_NEG_reg;
wire         isEA22_29_E2_EO;   // Load signal for isEA latch
wire         isEA22_29_E2noEO;   // Load signal for isEA latch
wire         isEA22_29_E2_NEG;  // Load signal for isEA latch
reg  [22:29] isEA22_29_L2;      // isEA latch
wire [0:4]   isEAforSprSel;     // isEA latch[0:4] used for real mode sprSel
reg  [0:4]   isEAforSprSel_reg;
wire [0:4]   isEAforSprSel_N;   // isEA latch[0:4] used for real mode sprSel
wire         isReq;             // i-side is requesting the UTLB
wire         istlbBusy;         // UTLB busy for is request
wire         isXltValid;        // is Xlation Valid
wire [0:1]   isStatus;          // Status of the current instruction
wire         msrIR_N;
wire         msrIRearly;
wire         msrIRearlytoRepower;
wire         msrIrL2_N;         // latched version of msrIR
wire         msrIr0_L2;
wire         msrIr1_L2_N;
wire         msrPrL2torepower_N;
wire         msrPrL2;           // latched version of msrIR
reg          nonSpecAccL2;
wire         OsrInNoEoOdd;
wire         OsrInEoOdd;
reg          OsrL2torepower;
wire         LoadRaAttr_EO;
wire         LoadRaAttrnoEO;

wire         msrDrL2;           // latched version of msrDR
reg  [0:2]   dsStateIn;         // Next dsState
wire [0:2]   dsStateL2;         // data shadow state machine
wire         dsStateE1;         // data shadow state machine
wire         dsStateA;          // data shadow is in state A
wire         dsStateA_In;       // data shadow is in state A
wire         dsStateA_L2;       // data shadow is in state A
wire         dsStateB;          // data shadow is in state B
wire         dsStateC;          // data shadow is in state C
wire         dsStateD_i;        // data shadow is in state D
wire         dsStateD_In;       // data shadow is in state D
wire         dsStateD_L2;       // data shadow is in state D
wire [0:2]   dsAddrIn;          // input to DTLB address REG
reg  [0:2]   dsAddrL2_i;          // DTLB Address to be written
wire         dsAddrE2;          // Gate term for DTLB Address
wire         wrtDTLB;           // Write enable for DTLB
//wire         dsEAisSame;
//wire [0:21]  dsEA0_21;
//wire         dsEA0_27_E1;       // Load signal for dsEA latch
//wire         dsEA0_27_E2;       // Load signal for dsEA latch
//wire         dsEA28_31_E2;      // Load signal for dsEA latch
//wire [0:27]  dsEA0_27_L2;       // dsEA latch
//wire [28:31] dsEA28_31_L2;      // dsEA latch
wire         dsReq;             // d-side is requesting the UTLB
wire [0:4]   dsEAforSprSel;     // dsEA inverted for real mode sprSel
wire         parDtlbMiss;       // Latched value of DTLB Miss
//wire         missComp;          // current dsOp is not to same addr as previous one
wire         goTodsStateA;      // Next state is dsStateA
wire         dsrequest;
wire   [0:31]  dsEAL2;            // dsEA latch
reg  [0:31]  dsEAL2_reg;
wire         dsEA_E1;           // Load signal for dsEA latch
wire         dsEA_E2;           // Load signal for dsEA latch
//wire         dsEAL_ValidIn;     // Valid input for dsEA
//wire         dsEAL_ValidL2;     // Valid term for dsEA
//wire         dsEAL_ValidE2;     // Valid gate for dsEA
//wire         reset_dsEAL_Valid; // reset dsEA valid term
wire         dcuXltValid;       // ds Xlation valid
//wire         dcuSuppressRead;   // current dsOp is to same addr as previous one
//wire         dsAbort;           // Abort current Access Check
wire [0:7]   dsStatus;          // Status of the current Access Check command
//wire         dsgoodStatus;      // current d-side op has no errors
//wire         dcuSpecialOp;      // Special op is being executed
//wire [8:21]  mungeRPN;
wire [22:29] dsEA22_29;
wire         exeAbort;
wire         mmuExeAbort;
wire         sprHold_N;
wire [0:2]   dsStatetoRe1;
wire         dsStateAtoRe1;
wire         dsStateDtoRe1;
wire [0:2]   dsStatetoRe2;
wire         dsStateAtoRe2;
wire         dsStateDtoRe2;

//wire         parMuxSel;
wire         parAttrValid;
wire         dsCmdAccept;
wire         dsCmdAcceptL2;
//wire [0:4]   attrtoMAR0;
//wire [0:10]  attrtoMAR1;
wire         StNotLdL2;          // Store command is taking place wrt protection
wire [0:1]   parZonePR;          // Zone Priority bits from the DTLB
wire [0:1]   ZSEL_high;          // ZSEL bits from UTLB
wire [2:3]   ZSEL_low;           // ZSEL bits from UTLB
wire         parWR;              // latched WR protection bit from the DTLB
wire         parU0;               // latched U0 bit from the DTLB
wire         parI;               // latched I bit from the DTLB
wire         parW;               // latched W bit from the DTLB
wire         parIcuOp;            // icuOp Latch
wire         parDcuOp;            // dcuOp Latch
wire         ACheck;             // current command is access check
wire         achkNop;            // Access Check NOP type
wire         achkSup;            // Access Check Suppress type
wire         parAchkNop;          // Latched Access Check NOP type
wire         parAchkSup;          // Latched Access Check Suppress type

wire         zoneFault;          // Zone Fault
wire         writeFault;         // Write Fault from miss
wire         parWriteFault;      // Write Fault from hit
wire         exFault;            // Execution Fault
wire         U0Fault;            // U0 Fault from miss
wire         parU0Fault;         // U0 Fault from hit
wire         alignFault;         // alignment fault from a dcbz instruction (Miss)
wire         parAlignFault;      // alignment fault from a dcbz instruction (Hit)
wire         dcbaFault;          // alignment fault from a dcba instruction (Miss)
wire         parDcbaFault;       // alignment fault from a dcba instruction (Hit)
wire         dcbaL2;             //
wire         dcbzL2;             //
wire         marE1;              // MAR Enable
//wire         marSXE1;             // MAR Enable for parity latches
wire         marREE1;             // MAR Enable for parity latches
wire         marEX;              // EX bit from the MAR register
wire         marUTLB_Miss;       // UTLB Miss bit from the MAR register
wire [0:1]   marZonePR_i;          // Zone Pri. bits from the mar register
wire [8:21]  RPNtoMAR;

wire         tlbStateAin;
reg          tlbREorSXL2;
reg          tlbStateAL2;
wire [0:7]   zonePRgrp8;         // 8 bits decoded from ZSEL bits
reg  [0:1]   zonePR;             // Protection bits that are selected from Zone reg
reg  [0:6]   decSize;            // decoded size bits
reg  [0:2]   size_out;           // encoded size from UTLB

wire         EN_ARRAYL1;            // UTLB EN_ARRAYL1 input
wire         EN_C1;                 // UTLB C1Clock Enable input
wire [0:3]   tlbRE_buf_N;

// TRI 07/16/01 New wires added for parity
wire         tagPar1;
wire         tagPar2;
wire         ramPar1;
wire         ramPar2;
wire         tagGenPar1;
wire         tagGenPar2;
wire         tagGenPar3;
wire         tagGenPar4;
wire         ramGenPar1;
wire         ramGenPar2;
wire         tagGenUTLBParRe1;
wire         tagGenUTLBParRe2;
wire         tagGenUTLBParSx1;
wire         tagGenUTLBParSx2;
wire         tagGenUTLBPar3;
wire         tagGenUTLBPar4;
wire         ramGenUTLBPar1;
wire         ramGenUTLBPar2;
wire         tagParErr3;
wire         tagParErr4;
wire         ramParErr1;
wire         ramParErr2;
wire         parityErrSX;
wire         parityErrSXwTPE;
wire         parityErrRE;
reg [0:21]   EPN_EAL2;
wire         tlbREParErr1In;
wire         tlbREParErr2In;
wire         tlbSXParErr1In;
wire         tlbSXParErr2In;
wire         tagDSizeParErrIn;
wire         ramParErrIn;
wire         tagDSizeRamParErrIn;

wire [8:21]  munge_xlate;
wire         LookupenForEnC1;
reg  [0:22]  mar_DataIn;  
reg  [0:22]  mar_reg;  
reg  [0:15]  mar2_DataIn;  
reg  [0:15]  mar2_reg;  
reg  [0:3]   mar3_DataIn;  
reg  [0:3]   mar3_reg;  
reg  [0:2]   mar3b_DataIn;  
reg  [0:2]   mar3b_reg;  
reg  [0:21]  mar4_DataIn;  
reg          osr_DataIn;
reg  [0:10]  isEA0_10_DataIn;
reg  [0:10]  isEA11_21_DataIn;
reg  [0:7]   isEA22_29_DataIn;
reg          nonSpecAcc_DataIn;
reg  [0:9]   PAR_reg;  
reg  [0:6]   PAR2_reg;  
reg  [0:4]   dsState_reg;
reg  [0:2]   MSR_reg;

wire  tlbREParErr1L2;
wire  tlbREParErr2L2;
wire  tagDSizeParErrL2;
wire  ramParErrL2;
wire  tlbSXParErr1L2;
wire  tlbSXParErr2L2;
wire  tagDSizeRamParErrL2;


wire         seldccr_i;
wire         seliccr_i;
wire         selzone_i;
wire         selpid_i;
wire         selsgr_i;
wire         seldcwr_i;
wire         selsler_i;
wire         selskr_i;
wire         seldear_i;
wire [0:31]  dsEAL_i;
wire         dsInvalidate_i;
wire [0:21]  marRPN_i;
wire [0:6]   marDSize_i;
wire         marU0_i;
wire         marWR_i;
wire         marW_i;
wire         marG_i;
wire         marCacheable_i;
wire         isInvalidate_i;
wire         isrdNotWrt_i;
wire [0:21]  isEAL_i;
wire [0:21]  EPN_EA_i;
wire         TestComp_i;


  // assign outputs so we dont read from them
  assign seldccr = seldccr_i;
  assign seliccr = seliccr_i;
  assign selzone = selzone_i;
  assign selpid = selpid_i;
  assign selsgr = selsgr_i;
  assign seldcwr = seldcwr_i;
  assign selsler = selsler_i;
  assign selskr = selskr_i;
  assign seldear = seldear_i;
  assign dsStateD = dsStateD_i;
  assign dsAddrL2 = dsAddrL2_i;
  assign dsEAL = dsEAL_i;
  assign dsInvalidate = dsInvalidate_i;
  assign marRPN = marRPN_i;
  assign marDSize = marDSize_i;
  assign marU0 = marU0_i;
  assign marWR = marWR_i;
  assign marW = marW_i;
  assign marG = marG_i;
  assign marCacheable = marCacheable_i;
  assign marZonePR = marZonePR_i;
  assign isAddrL2 = isAddrL2_i;
  assign isInvalidate = isInvalidate_i;
  assign isrdNotWrt = isrdNotWrt_i;
  assign isEAL = isEAL_i;
  assign EPN_EA = EPN_EA_i;
  assign TestComp = TestComp_i;


assign MMU_dsStatus = dsStatus;
assign MMU_isStatus = isStatus;
assign dsEAL_i[0:31] = dsEAL2[0:31];
assign MMU_isRA[22:29] = isEA22_29_L2[22:29];
assign MMU_dsRA[22:29] = (msrDrL2 & dsStateD_i) ? dsEAL2[22:29] : dsEA22_29[22:29];
assign MMU_isXltValid = isXltValid;
assign MMU_dcuXltValid = dcuXltValid;
//assign MMU_dcuSuppressRead = dcuSuppressRead;
assign dsEAforSprSel = ~dsEA_N[0:4];
assign dsStateAfromLatch = dsStateA_L2;


// Hold the current command in wb if miss and searching UTLB
assign MMU_wbHold = dsStateL2[0];

  // Removed the module "dp_logMMU_tlbREredrive"
  assign tlbRE_buf_N[0:3] = ~({4{tlbRE}});

// ***********************************************************************
// Abort i-side command if
//     in State D and get error from UTLB
// ***********************************************************************
// The ICU gets the isAbort signal so it is not needed in this equation
//assign MMU_icuIsAbort = (isAbort & |isStateL2[0:1]) |
//                        (isStateD & (exFault | zoneFault | marG | marUTLB_Miss));
// TRI 07/17/01
// Changed to add parity
// assign MMU_icuIsAbort = isStateD & (exFault | zoneFault | marG | marUTLB_Miss);
assign MMU_icuIsAbort = isStateD & (exFault | zoneFault | marG_i | marUTLB_Miss | parityErrSX);

// ***********************************************************************
// Abort d-side command if
//    1) (UTLB)   in State D and get errors from UTLB or
//    2) (Shadow) Error latched in PAR register from Dtlb Hit in previous cycle
// ***********************************************************************
//assign dsAbort = |dsStatus[0:3] | (dsStateL2[0] & wbAbort);

// 8/5/98 KAM - Removed wbAbort. DCU and ICU get it from VCT
//assign MMU_dcuUTLBAbort = (dsStateL2[0] & wbAbort) |
//                          (dcuOpL2 & dsStateD & (achkSupL2 | parAchkNop) &
//                                (zoneFault | writeFault | marUTLB_Miss | U0Fault));
//assign MMU_icuDsAbort = (dsStateL2[0] & wbAbort) |
//                         icuOpL2 & (achkSupL2 | achkNopL2) &
//                           ((dsStateD & (zoneFault | writeFault | marUTLB_Miss)) |
//                            (dsStateA & parWriteFault));

// TRI 07/17/01
// Change equation for parity
//assign MMU_dcuUTLBAbort = parDcuOp & dsStateD_L2 & (parAchkSup | parAchkNop) &
//                           (zoneFault | writeFault | marUTLB_Miss | U0Fault |
//                            alignFault | dcbaFault);
// TRI 10/31/01
// DEFECT 2020
assign MMU_dcuUTLBAbort = parDcuOp & dsStateD_L2 & (parAchkSup | parAchkNop) &
                           (zoneFault | writeFault | marUTLB_Miss | U0Fault |
                            alignFault | dcbaFault | parityErrSXwTPE);

assign MMU_dcuShadowAbort = parDcuOp & dsStateA_L2 & (parAchkSup | parAchkNop) &
                            (parWriteFault | parU0Fault | parAlignFault | parDcbaFault);


// this equation was rewritten because a icuOp cannot have a  U0fault or a write fault
//assign MMU_icuDsAbort = icuOpL2 & (parAchkSup | parAchkNop) &
//                     ((dsStateD & (zoneFault | writeFault | marUTLB_Miss| U0Fault)) |
//                      (dsStateA & (parWriteFault| parU0Fault)));

// TRI 07/17/01
// Change equation for parity
//assign MMU_icuDsAbort = parIcuOp & (parAchkSup | parAchkNop) & dsStateD &
//                              (zoneFault | marUTLB_Miss);
// TRI 10/31/01
// DEFECT 2020
assign MMU_icuDsAbort = parIcuOp & (parAchkSup | parAchkNop) & dsStateD_i &
                              (zoneFault | marUTLB_Miss | parityErrSXwTPE);

// ***********************************************************************
// Data Side Operations
// ***********************************************************************
// dsMmuOp[0:3] definition
//            0000 - NOP
//            0001 - reserved
//            0010 - reserved
//            0011 - reserved
//            0100 - TLB sync
//            0101 - reserved
//            0110 - Access Check (NOP on Violation)
//            0111 - Access Check (Supress on Violation)
//            1000 - TLB Invalidate All
// ***********************************************************************
// generate data side instruction
// -----------------------------------------------------------------------
assign achkNop = ~dsMmuOp[0] & (&dsMmuOp[1:2]) & ~dsMmuOp[3];
assign achkSup = ~dsMmuOp[0] & (&dsMmuOp[1:3]) ;
//assign tlbia   =  dsMmuOp[0] & ~dsMmuOp[1] & ~dsMmuOp[2] & ~dsMmuOp[3];
assign tlbia   =  dsMmuOp[0] ;

assign ACheck = dsMmuOp[1] & dsMmuOp[2];


// -----------------------------------------------------------------------
// Cntxt sync happens in two scenarios
//   1) Swap State (isAbort happens in the same cycle)
//   2) wbIsync    (isAbort happens the cycle after)
//         => wbIsync is latched in the IFB
// -----------------------------------------------------------------------
//assign shadowInvalidate =  cntxSync | resetL2;
assign dsInvalidate_i =  cntxSync | resetL2;
assign isInvalidate_i =  cntxSync | resetL2;

// inverting control mux so invert going in
//dp_muxMMU_isInvalidate muxMMU_isInvalidate (
//                      .D0          (~resetL2),
//                      .D1          (~(swapStL2 | wbIsyncL2preQual)),
//                      .SD          (isAbort),
//                      .Z           (isInvalidate)  );


// ***********************************************************************
//                       SPR Regs
// ***********************************************************************

// Select a spr to potentially drive onto the SPRbus
// The SPR addresses are decoded while in decode
assign seldccr_i = SprDcd[0];         //sprAddr == 10'h3fa
assign seliccr_i = SprDcd[1];         //sprAddr == 10'h3fb
assign selzone_i = SprDcd[2];         //sprAddr == 10'h3b0
assign selpid_i  = SprDcd[3];         //sprAddr == 10'h3b1
assign selsgr_i  = SprDcd[4];         //sprAddr == 10'h3b9
assign seldcwr_i = SprDcd[5];         //sprAddr == 10'h3ba
assign selsler_i = SprDcd[6];         //sprAddr == 10'h3bb
assign selskr_i  = SprDcd[7];         //sprAddr == 10'h3bc
assign seldear_i = SprDcd[8];         //sprAddr == 10'h3d5


// E1 Enables for sprs
assign pidE1   = (selpid_i  & mtSPR) | resetL2 | ~tlbRE_buf_N[3];   // pid gets loaded on read of Tag
assign zoneE1  = (selzone_i & mtSPR) | resetL2 ;
assign sgrE1   = (selsgr_i  & mtSPR) | resetL2 ;
assign dcwrE1  = (seldcwr_i & mtSPR) | resetL2 ;
assign slerE1  = (selsler_i & mtSPR) | resetL2 ;
assign skrE1   = (selskr_i  & mtSPR) | resetL2 ;
assign dccrE1  = (seldccr_i & mtSPR) | resetL2 ;
assign iccrE1  = (seliccr_i & mtSPR) | resetL2 ;
assign dearE1  = (seldear_i & mtSPR) | wbStorageOp | resetL2;


// E2 Enables for sprs
// removed selxxx and generated a common E2 for the spr registers
// per design review on 12/3/98
//assign zoneE2  = (selzone & ~sprHold) | resetL2 ;
//assign sgrE2   = (selsgr  & ~sprHold) | resetL2 ;
//assign dcwrE2  = (seldcwr & ~sprHold) | resetL2 ;
//assign slerE2  = (selsler & ~sprHold) | resetL2 ;
//assign skrE2   = (selskr  & ~sprHold) | resetL2 ;
//assign dccrE2  = (seldccr & ~sprHold) | resetL2 ;
//assign iccrE2  = (seliccr & ~sprHold) | resetL2 ;

// For Pass2 Sanjay send sprHold for MMU and I OR in MMU terms locally

  // Removed the module "dp_logMMU_sprHoldInv"
  assign sprHold_N = ~(sprHold);

assign sprRegE2 = sprHold_N | resetL2 ;
// Modified to match Prowler edits:  RDE 5/1/00
assign dearE2 =  (seldear_i & sprHold_N & mtSPR) | VCT_dearE2 | resetL2;

// pid gets tid on tlb reads and sprdata on pid writes
//assign pidIn = tlbRE  ? UTLB_TID[0:7] : sprData[24:31];
// datapath inverting mux

  // Removed the module "dp_muxMMU_PIDdata"
  assign pidIn_N = ~( (UTLB_TID[0:7] & {8{~(tlbRE_buf_N[3])}} ) | (sprData[24:31] &
                      {8{tlbRE_buf_N[3]}} ) );

assign pidE2   = (selpid_i  & sprHold_N) | resetL2 |  // pid gets loaded on read of Tag
                    (~tlbWC & ~tlbRE_buf_N[0] & tlbStateD) ;

// ***********************************************************************
// encode size that is received from UTLB for tlb read
always @ (UTLB_DSize)
begin
   casez ({UTLB_DSize}) //synopsys full_case parallel_case
      7'b0000000: size_out = 3'b000;        //
      7'b0000001: size_out = 3'b001;        //
      7'b000001?: size_out = 3'b010;        //
      7'b00001??: size_out = 3'b011;        //
      7'b0001???: size_out = 3'b100;        //
      7'b001????: size_out = 3'b101;        //
      7'b01?????: size_out = 3'b110;        //
      7'b1??????: size_out = 3'b111;        //
      default   : size_out = 3'bxxx;        // x-catcher
   endcase
end

// ***********************************************************************
// muxing of the MMU_sprData Bus
//  00 - output from the selected SPR register for mfspr
//  01 - tag output from tlbRE of tag
//  10 - data output from tlbRE of data
//  11 - index for a tlbSX
// ***********************************************************************
assign sprMuxSel[0] = tlbSX | (~tlbRE_buf_N[1] &  tlbWC);
assign sprMuxSel[1] = tlbSX | (~tlbRE_buf_N[1] & ~tlbWC);


// ***********************************************************************
// ------------Real Mode Cacheability Controls ---------------------
// ***********************************************************************

// instruction cache cacheability controls and U0 attribute
//port order  .CB
//            .Scanin
//            .Scanout
//            .ea
//            .isEAL
//            .msrIR_N
//            .spr1
//            .spr2
//            .sprReal2
//            .sprReal1

  p405s_mmu_isSel_1_of_32early
   iscr_U0r( .sprReal_N ({isIReal_N,isU0Real_N}), 
                               .CB        (CB), 
                               .ea        (isEA[0:1]),
                               .isEAL_N   (isEAforSprSel_N[2:4]), 
                               .msrIR_N   (~msrIR), 
                               .spr1      (iccrL2[0:31]), 
                               .spr2      (skrL2[0:31])
                               );

// i-side guarded and endian storage controls for real mode
  p405s_mmu_isSel_1_of_32early
   isgr_iser ( .sprReal_N ({isGReal_N,isEReal_N}), 
                                 .CB        (CB), 
                                 .ea        (isEA[0:1]),
                                 .isEAL_N   (isEAforSprSel_N[2:4]), 
                                 .msrIR_N   (~msrIR), 
                                 .spr1      (sgrL2[0:31]), 
                                 .spr2      (slerL2[0:31])
                                 );

// d-cache and i-cache cacheability controls for d-side operations
  p405s_dsMMU_sel_1_of_32
   dscr_isdscr( .spr1out  (dsIReal_N),
                                 .spr2out  (isDsIReal_N),
                                 .ea       (dsEAforSprSel),
                                 .spr1     (dccrL2[0:31]),
                                 .spr2     (iccrL2[0:31])
                                 );

// d-side guarded and endian  storage controls for real mode
  p405s_dsMMU_sel_1_of_32
   dsgr( .spr1out  (dsGReal_N),
                          .spr2out  (dsEReal_N),
                          .ea       (dsEAforSprSel),
                          .spr1     (sgrL2[0:31]),
                          .spr2     (slerL2[0:31])
                          );

// d-cache write-through and  U0 attribute
  p405s_dsMMU_sel_1_of_32
   wtrr( .spr1out  (wtReqReal_N),
                          .spr2out  (dsU0Real_N),
                          .ea       (dsEAforSprSel),
                          .spr1     (dcwrL2[0:31]),
                          .spr2     (skrL2[0:31])
                          );

// KAM 7/14/98 Took out. The cdbcrFDK will now be used to enable the U0 Fault
//  assign dsKReal = dsKR & ~(cdbcrFDK & dcuOp);


// ***********************************************************************
//                       TLB Instruction State Machine
// ***********************************************************************
// tlbRE          goes  A->B->C->D->A   (4 cycle)
// tlbWE          goes  A->B->A         (2 cycle)
// tlbSX          goes  A->B->C->D->A   (4 cycle)
// tlb invalidate goes  A->B->A         (2 cycle)
//
// 00 - tlbStateA  - idle
// 01 - tlbStateB  - cmd
// 11 - tlbStateC  - data
// 10 - tlbStateD  - hold_data
// All tlb commands are issued in stateB
// tlb States B, C, and D cannot be interrupted because blockFlush is set
// ***********************************************************************
assign tlbStateA = ~(|tlbStateL2[0:1]);
assign tlbStateB = ~tlbStateL2[0] & tlbStateL2[1];
assign tlbStateC = &tlbStateL2[0:1];
assign tlbStateD = tlbStateL2[0] & ~tlbStateL2[1];

// TLB state Variable
// tlb instruction must wait until sprHold == 0 and wbStorageOp == 0
// before it can begin
assign tlbStateIn[0] = (tlbStateB | tlbStateC) & (~tlbRE_buf_N[2] | tlbSX);
assign tlbStateIn[1] = (tlbStateA & sprHold_N & ~wbStorageOp &
                            (~tlbRE_buf_N[2] | tlbSX | tlbWE | tlbia)) |
                       (tlbStateB & (~tlbRE_buf_N[2] | tlbSX)) ;


// ---------------------------------------------------------------------------
// tlb invalidate is latched because it must be a glitchless signal
// tlbInvalidateL2 is on when we are in tlbStateB
// ---------------------------------------------------------------------------
// Modified to match Prowler edits:  RDE 3/12/00
//assign tlbInvalidateIn = (tlbia & sprHold_N & ~wbStorageOp & ~tlbInvalidateL2) |
//                         BIST_invalidate;

// 3/30/00 KAM block the functional path whenever doing BIST
//assign tlbInvalidateIn = (~TestM1 & tlbia & sprHold_N & ~wbStorageOp & ~tlbInvalidateL2) |
//                         BIST_invalidate;

// 2/22/02 KAM - Changed for TBIRD
// BIST_invalidate now comes off its own latch. Do the mux after the latch
assign tlbInvalidateIn = tlbia & sprHold_N & ~wbStorageOp & ~tlbInvalidateL2,
       tlb_invalidate = TestM1 ? BIST_invalidate : tlbInvalidateL2;

/*---------------------------------------------*/
// tlb invalidate and state register
/*---------------------------------------------*/
// 3/4/02 RLG - changed from TBIRD since  BIST_invalidate is now mux'ed after the latch
// assign utlbStE2 = resetL2 | ~tlbRE_buf_N[2] | tlbWE | tlbia | tlbSX |
//                   BIST_invalidate | tlbInvalidateL2;
assign utlbStE2 = resetL2 | ~tlbRE_buf_N[2] | tlbWE | tlbia | tlbSX |
                  tlbInvalidateL2;

assign tlbStateAin = ~(|tlbStateIn[0:1]);

  // Removed the module "dp_regMMU_tlbia_State"
  always @(posedge CB)      
    begin                                       
      casez(utlbStE2)                    
        1'b0: {tlbStateL2,tlbInvalidateL2,tlbStateAL2} <= {tlbStateL2,tlbInvalidateL2,
                                                           tlbStateAL2};                
        1'b1: {tlbStateL2,tlbInvalidateL2,tlbStateAL2} <= {tlbStateIn[0:1],tlbInvalidateIn,
                                                           tlbStateAin};            
        default: {tlbStateL2,tlbInvalidateL2,tlbStateAL2} <= 4'bx;  
      endcase                             
    end                                  

  // Removed the module "dp_regMMU_tlbReSx"
  always @(posedge CB)
    begin
      tlbREorSXL2 <= (~tlbRE_buf_N[1] | tlbSX);
    end

// ---------------------------------------------------------------------------
// Blocking multiple cyle command is active during state A for tlbWE and tlbia
// instructions and during states A,B,C, for tlbSX and tlbRE
// ---------------------------------------------------------------------------
//assign MMU_BMCO = (tlbStateA & (tlbRE | tlbWE | tlbSX | tlbia)) |
//                  (tlbStateL2[1] & (tlbRE | tlbSX));
assign MMU_BMCO = (tlbStateAL2  & exeTlbOp) | (tlbStateL2[1] & tlbREorSXL2);

// ***********************************************************************
//                    Request for UTLB
// ***********************************************************************
// Requests can be made for the UTLB by a tlb instruction, d-side or i-side
// Contention cases :
//  d-side vs tlb instr -- can never contend. They occur in execute
//    d-side instr first -- If a d-side miss is being handled wbHold would
//      be asserted which will cause a sprHold to come on. This will cause
//      the tlb instruction to wait.
//    tlb instr first -- once a tlb instr is received BMCO goes on which
//      will cause it to stay in execute.
//  d-side vs i-side -- d-side executes
//  i-side vs tlb instr -- tlb instr executes
// ***********************************************************************
// the tlb instructions control the UTLB during states B and C. This is
// specifically for the tlbSX and tlbRE instructions. Data is returned
// in the middle to end of the cycle during state C. By preventing the
// i-side from sending a UTLB req, we can guarantee that the UTLB will
// keep the data on its bus till the end of state D.
// ------------------------------------------------------------------------
assign tlbReq = tlbStateL2[1];      //states B and C

// removed wbabort for timing. Dsreq has priority over isreq so in this case
// an isreq will wait an extra cycle before doing a lookup
//assign dsReq = dsStateB & ~wbAbort;
assign dsReq     = dsStateB ;

assign istlbBusy = dsReq | tlbReq;

// removed isabort for timing. isreq has the lowest priority so this would
// only do an extra search of the UTLB. Nothing else would be blocked
//assign isReq     = ~istlbBusy & isStateB & ~isAbort;
assign isReq     = ~istlbBusy & isStateB ;

// ***********************************************************************
// ---------------------- UTLB Input Signals -------------------
// ***********************************************************************

// ***********************************************************************
// Create EN_C1 and EN_ARRAYL1 for the UTLB
// ***********************************************************************
// The clocks are generated from Designware books
//assign camClockOn  = ~(TestM3 | ((~rdEn & ~wrEn) & ~LookupEn));
//assign C1ClockOn   =  rdEn |  wrEn |  LookupEn;
//assign C1fromSplit = ~(LSSD_ArrayCClk_NEG | CB);
//assign C1          = C1fromSplit & C1ClockOn;
//assign camClock    = C1fromSplit & camClockOn;
// added EN_ARRAYL1_preTestM3  (camclock in prowler) KVP 09/29/00
// 08/08/02 KAM - added LookupenForEnC1 to match the gates.
// This was added as a request from Waleed, EN_C1 needed to be 1 the entire time
// BIST is running so the lookupEn is ored with testM1 for EN_C1 use.
// The other loookupEn that is used by EN_ARRAYL1 cannot be on all the time
// because that that signal needs to toggle througout the bist


p405s_UTLB_Clocks
  UTLB_Clock_Gen (.EN_C1                (EN_C1),
                             .EN_ARRAYL1           (EN_ARRAYL1),
                             .LSSD_ArrayCClk_buf   (LSSD_ArrayCClk_buf),
                             .TestM3               (TestM3),
                             .lookupEn             (LookupEn),
                             .LookupenForEnC1      (LookupenForEnC1),
                             .rdEn                 (rdEn),
                             .wrEn                 (wrEn),
                             .TestComp             (TestComp_i),
                             .C_Clock              (1'b1),
                             .EN_ARRAYL1_preTestM3 (EN_ARRAYL1_preTestM3),
                             .CB                   (CB));

// 03/04/02 RLG - added TestM1 for TBIRD changes
// assign TestComp    = (~BIST_rdEn & ~BIST_wrEn) & ABIST_test;
assign TestComp_i    = (~BIST_rdEn & ~BIST_wrEn) & ABIST_test & TestM1;

assign indexLookupb = indexEn;        // indexEn and lookupEn are on same pin
assign rdWrb = rdEn;                  // rdEn and wrEn are on same pin

assign LookupEn = TestM1 ? BIST_lookupEn
                         : ((tlbSX & tlbStateB) | dsStateB  | (isStateB & ~istlbBusy)) ;

assign LookupenForEnC1 = TestM1 | ((tlbSX & tlbStateB) | dsStateB  | (isStateB & ~istlbBusy));
assign indexEn =  TestM1 ? (BIST_rdEn | BIST_wrEn) : ((~tlbRE_buf_N[0] | tlbWE ) & tlbStateB);

// assign tag and data enables. These are only applicable when index enable is a
// logic one and the tlb is being read or written.
assign tagEn  =   TestM1 ? ((BIST_rdEn | BIST_wrEn) | BIST_lookupEn) : ~tlbWC ;

assign dataEn =   TestM1 ? (BIST_rdEn | BIST_wrEn) : tlbWC ;

// assign read and write enables
assign rdEn   =   TestM1 ? BIST_rdEn : (~tlbRE_buf_N[0] & tlbStateB);

assign wrEn   =   TestM1 ? BIST_wrEn : (tlbWE & tlbStateB);

// get tlb address from sprAddr bus or Bist Unit if in test mode
assign tlbAddr[0:5] = TestM1 ? BIST_addr : sprAddr[4:9] ;

// ---------------------------------------------------------------------------
// assign data to Tag inputs including ABIST data during array test.
// ---------------------------------------------------------------------------
//dp_logMMU_dsEAinvert logMMU_dsEAinvert(
//              .Z     ({dsEA0_21,dsEA22_29}),
//              .A     (dsEA_N[0:29])  );
// dsEA0_21 was used in the EPN equation. This has been removed so the signal is no
// longer needed

  // Removed the module "dp_logMMU_dsEAinvert"
  assign dsEA22_29 = ~(dsEA_N[22:29]);

assign tlbU0     = TestM1 ? BIST_data[1] : sprData[27] ;
assign tlbE      = TestM1 ? BIST_data[0] : sprData[26] ;

// The EPN for a tlb write is the sprData. For a tlbSX the EPN is the dsEAL2.
// These are muxed in the muxMMU_EPN_EA
// assign EPN[0:21] = tlbSX  ? dsEA0_21     : sprData[0:21];
// TRI 07/17/01
// parity inputs to UTLB

assign DSIZE[0:6]= TestM1 ? BIST_DSize   : decSize[0:6];
assign DT        = TestM1 ? BIST_DT      : ~|pidL2[0:7];
assign TID[0:7]  = TestM1 ? BIST_TID     : pidL2[0:7] ;
assign tlbV      = TestM1 ? BIST_V       : sprData[25];
assign tagPar1   = TestM1 ? BIST_data[1] : tagGenPar1;
assign tagPar2   = TestM1 ? BIST_data[0] : tagGenPar2;
assign tagPar3   = TestM1 ? BIST_data[1] : tagGenPar3;
assign tagPar4   = TestM1 ? BIST_data[0] : tagGenPar4;

// ---------------------------------------------------------------------------
// assign data SRAM inputs including ABIST data during array test
// ---------------------------------------------------------------------------
assign RPN[0:21] = TestM1 ? {11{BIST_data[0],BIST_data[1]}} : sprData[0:21] ;
assign EX        = TestM1 ? BIST_data[0] : sprData[22] ;
assign WR        = TestM1 ? BIST_data[1] : sprData[23] ;
assign ZSEL[0:3] = TestM1 ? { 2{BIST_data[0],BIST_data[1]}} : sprData[24:27];
assign tlbW      = TestM1 ? BIST_data[0] : sprData[28] ;
assign tlbCacheInhibit      = TestM1 ? BIST_data[1] : sprData[29] ;
assign tlbM      = TestM1 ? BIST_data[0] : sprData[30] ;
assign tlbG      = TestM1 ? BIST_data[1] : sprData[31] ;
assign ramPar1   = TestM1 ? BIST_data[0] : ramGenPar1;
assign ramPar2   = TestM1 ? BIST_data[1] : ramGenPar2;

// ---------------------------------------------------------------------------
// generate signal for size decode case statement below
// ---------------------------------------------------------------------------
assign sprDataBits22to24[0:2] = sprData[22:24];

// decode 7 dsiz bits from 3 siz bits
always @ (sprDataBits22to24)
 begin
   casez ({sprDataBits22to24})  //synopsys full_case parallel_case
     3'b000 :  decSize[0:6] = 7'b0000000;                 //
     3'b001 :  decSize[0:6] = 7'b0000001;                 //
     3'b010 :  decSize[0:6] = 7'b0000011;                 //
     3'b011 :  decSize[0:6] = 7'b0000111;                 //
     3'b100 :  decSize[0:6] = 7'b0001111;                 //
     3'b101 :  decSize[0:6] = 7'b0011111;                 //
     3'b110 :  decSize[0:6] = 7'b0111111;                 //
     3'b111 :  decSize[0:6] = 7'b1111111;                 //
     default:  decSize[0:6] = 7'bxxxxxxx;                 // x catcher
   endcase
 end

// ***********************************************************************
// The EPN and effective address share a bus in the UTLB. This is how
// they are muxed:
//   00 - D-Side miss or tlbSX   EPN_EA = dsEAL2
//   01 - I-Side miss            EPN_EA = isEAL2
//   10 - tlb write              EPN_EA = EPN
//   11 - cbist mode             EPN_EA = BIST_epn_ea
//
//    sprData    cbist      dsEAL   isEAL
//        ------------      -------------
//         0   |  1          0    |   1    Sel[1] = TestM1 | isReq
//             |-------   --------|
//                     |  |
//                   -------
//                    1 | 0      Sel[0] = TestM1 | (tlbWE & tlbStateB)
//                      |
// ***********************************************************************
//assign EPN_EA_MuxSel[0] = TestM1 | tlbWE | tlbSX;
//assign EPN_EA_MuxSel[1] = TestM1 | isReq;

// control late mux inplementation
//dp_muxMMU_EPN_EA muxMMU_EPN_EA (
//      .Z      (EPN_EA[0:21]),                //output
//      .D0     (dsEAL2[0:21]),                // (00) i-side op
//      .D1     (isEAL2[0:21]),                // (01) d-side op
//      .D2     (EPN[0:21]),                   // (10) tlb write/search op
//      .D3     (BIST_epn_ea[0:21]),           // (11) bist op
//      .SD0    ({22{EPN_EA_MuxSel[0]}}),      // mux sel
//      .SD1    ({22{EPN_EA_MuxSel[1]}}) );    // mux sel

assign EPN_EA_MuxSel[0] = TestM1 | (tlbWE & tlbStateB);
assign EPN_EA_MuxSel[1] = TestM1 | isReq;

  // Removed the module "dp_muxMMU_EPN_EA"
  assign EPN_EA_i[0:21]  = ((~({22{EPN_EA_MuxSel[0]}}) & ~({22{EPN_EA_MuxSel[1]}}) & 
                        dsEAL2[0:21]) |
                        (~({22{EPN_EA_MuxSel[0]}}) & ({22{EPN_EA_MuxSel[1]}}) & isEAL_i[0:21]) |
                        ({22{EPN_EA_MuxSel[0]}} & ~({22{EPN_EA_MuxSel[1]}}) & sprData[0:21]) |
                        ({22{EPN_EA_MuxSel[0]}} & {22{EPN_EA_MuxSel[1]}} & BIST_epn_ea[0:21]));


// ***********************************************************************
// Zone Protection Bits Generation
// ***********************************************************************
//select zone protection bits from zone register
assign ZSEL_high = UTLB_ZSEL[0:1];
assign ZSEL_low  = UTLB_ZSEL[2:3];

  // Removed the module "dp_muxMMU_zonePRgrp8"
  assign zonePRgrp8  = ((~({8{ZSEL_high[0]}}) & ~({8{ZSEL_high[1]}}) & zoneL2[0:7]) |
                        (~({8{ZSEL_high[0]}}) & ({8{ZSEL_high[1]}}) & zoneL2[8:15]) |
                        ({8{ZSEL_high[0]}} & ~({8{ZSEL_high[1]}}) & zoneL2[16:23]) |
                        ({8{ZSEL_high[0]}} & {8{ZSEL_high[1]}} & zoneL2[24:31]));

  // Removed the module "dp_muxMMU_zonePR"
  always @(ZSEL_low or zonePRgrp8)
    begin
      case(ZSEL_low[2:3])
        2'b00: zonePR = zonePRgrp8[0:1];
        2'b01: zonePR = zonePRgrp8[2:3];
        2'b10: zonePR = zonePRgrp8[4:5];
        2'b11: zonePR = zonePRgrp8[6:7];
        default: zonePR = 2'bx;
      endcase
    end


// ***********************************************************************
//                     MAR Register
// This register loads the information that is coming out of the UTLB
// while the ITLB or DTLB is in state C. The information is then
// transfered to the ITLB or DTLB if no errors are present
//
// MAR1 : <0:21>  RPN[0:21]            MAR2 :  <0:1>   zonePR
//        <22>    UTLB_Miss                    <2:3>   EX,WR
//                                             <4:6>   I,W,G
//                                             <7:13>  DSize
//                                            <14:15>  E,U0
// ***********************************************************************
assign marE1  = dsStateC | isStateC | resetL2 | (tlbSX & tlbStateC);
//assign marSXE1 = dsStateC | isStateC | resetL2 | (tlbSX & tlbStateC);
assign marREE1 = resetL2  | (~tlbRE_buf_N[3] & tlbStateC);

// fix for issue 147
// The RA has to be "munged" so that the untranslated bits are not passed
// as zeros on the bypass path.

//Shadow_Munge bypassRA_Munge (mungeRPN,           // munged address [8:21]
//                             dsEAL[8:21],        // latched effective address
//                             ~(UTLB_RPN[8:21]),  // RPN from the UTLB
//                             UTLB_DSize );       // Size from th UTLB

//dp_regMMU_bypassRPN regMMU_bypassRPN
//           .D0   ({UTLB_RPN[0:7],mungeRPN[8:21]}),
//           .L2   (bypassRPN),
//           .E1   (dsStateC),
//           .CB   (CB),
//           .I    (scan14),
//           .SO   (scan15) );

// per conversation with Jim Dieffenderfer, zero out the RPN bits that does not
// get translated so the software person does not have the requirement of
// writing zeros to the bits that are not used.
assign RPNtoMAR[8:9]   = UTLB_RPN[8:9]   & {2{~UTLB_DSize[0]}};
assign RPNtoMAR[10:11] = UTLB_RPN[10:11] & {2{~UTLB_DSize[1]}};
assign RPNtoMAR[12:13] = UTLB_RPN[12:13] & {2{~UTLB_DSize[2]}};
assign RPNtoMAR[14:15] = UTLB_RPN[14:15] & {2{~UTLB_DSize[3]}};
assign RPNtoMAR[16:17] = UTLB_RPN[16:17] & {2{~UTLB_DSize[4]}};
assign RPNtoMAR[18:19] = UTLB_RPN[18:19] & {2{~UTLB_DSize[5]}};
assign RPNtoMAR[20:21] = UTLB_RPN[20:21] & {2{~UTLB_DSize[6]}};

// fix for Pass2 issue 17.
// The RPN that is sent to the shadows must not be munged. This RPN must have the
// untranslated bits a zero just in case they need to be munged later.
// On a utlb miss force data to a known value because the UTLB has unknown values.

  // Removed the module "dp_regMMU_MAR"
  always @(UTLB_RPN or RPNtoMAR or resetL2 or UTLB_Miss)    
    begin        
      casez(resetL2 | UTLB_Miss)        
        1'b0: mar_DataIn = {UTLB_RPN[0:7],RPNtoMAR[8:21],1'b0};   
        1'b1: mar_DataIn = 23'h000001;   
        default: mar_DataIn = 23'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(marE1)
        1'b0: mar_reg <= mar_reg;
        1'b1: mar_reg <= mar_DataIn;
        default: mar_reg <= 23'bx;
      endcase
    end

  assign {marRPN_i,marUTLB_Miss} = mar_reg;

assign bypassRPN[0:7] = marRPN_i[0:7];

// The Real address for the bypass path must have some logic to leave to untranslated
// bits alone.
           // bypassRPN[8:21],    // munged address [8:21]
           // dsEAL[8:21],        // latched effective address
           // ~(marRPN[8:21]),    // RPN from the UTLB
           // marDSize);          // Size from th UTLB

  // Removed the module "dp_logMMU_MungeNand"
  // Removed the module "Shadow_Munge"
  assign bypassRPN[8:21] = ~( ~(marRPN_i[8:21]) & munge_xlate[8:21] );
  assign munge_xlate[8:21] = ~( dsEAL_i[8:21] & {marDSize_i[0],marDSize_i[0],marDSize_i[1],
                                marDSize_i[1],marDSize_i[2],marDSize_i[2],marDSize_i[3],
                                marDSize_i[3],marDSize_i[4],marDSize_i[4],marDSize_i[5],
                                marDSize_i[5],marDSize_i[6],marDSize_i[6]} );


// Invert I because it is stored in UTLB as cache-Inhibit but the shadows use it
// as cacheable

  // Removed the module "dp_regMMU_MAR2"
  always @(zonePR or UTLB_EX or UTLB_WR or UTLB_CacheInhibit or UTLB_W or UTLB_G or 
           UTLB_DSize or UTLB_E or UTLB_U0 or resetL2 or UTLB_Miss)    
    begin        
      casez(resetL2 | UTLB_Miss)        
        1'b0: mar2_DataIn = {zonePR,UTLB_EX,UTLB_WR,~UTLB_CacheInhibit,UTLB_W,
                               UTLB_G,UTLB_DSize,UTLB_E,UTLB_U0};   
        1'b1: mar2_DataIn = 16'hF800;   
        default: mar2_DataIn = 16'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(marE1)
        1'b0: mar2_reg <=  mar2_reg;
        1'b1: mar2_reg <= mar2_DataIn;
        default: mar2_reg <= 16'bx;
      endcase
    end

  assign {marZonePR_i,marEX,marWR_i,marCacheable_i,marW_i,marG_i,marDSize_i,marE,marU0_i} = mar2_reg;


// TRI 07/16/01
// Added register for 6 parity bits
// 4 tag bits and 2 ram bits.
// The 4 tags bits are divided up into even and odd parity bits
// for the EPN, TID, V, E and U0 bit. The other 2 tag bits are
// for even and odd DSize bits and the DT bit. The 2 ram bits
// are for even and odd parity bits.
// The even or odd stands for the physical column in the UTLB

// TRI 08/24/01
// Changed for timing.
// The 4 parity bits in Reg MAR3 are for tlb reads.
// The 3 parity bits in Reg MAR3b are for tlb searchs.
// TRI 08/28/01
// added defect 1853

  // Removed the module "dp_regMMU_MAR3"
  always @(tlbREParErr1In or tlbREParErr2In or tagDSizeParErrIn or 
           ramParErrIn or resetL2 or UTLB_V or tlbWC)    
    begin        
      casez(resetL2 | (~UTLB_V & ~tlbWC))        
        1'b0: mar3_DataIn = {tlbREParErr1In,tlbREParErr2In,
                               tagDSizeParErrIn,ramParErrIn};   
        1'b1: mar3_DataIn = 4'b0;   
        default: mar3_DataIn = 4'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(marREE1)        
        1'b0: mar3_reg <= mar3_reg;        
        1'b1: mar3_reg <= mar3_DataIn;   
        default: mar3_reg <= 4'bx;  
      endcase        
    end        

  assign {tlbREParErr1L2,tlbREParErr2L2,tagDSizeParErrL2,ramParErrL2} = mar3_reg;

// TRI 08/28/01
// added defect 1853

  // Removed the module "dp_regMMU_MAR3b"
  always @(tlbSXParErr1In or tlbSXParErr2In or tagDSizeRamParErrIn or 
           resetL2 or UTLB_Miss) 
    begin  
      casez(resetL2 | UTLB_Miss)        
        1'b0: mar3b_DataIn = {tlbSXParErr1In,tlbSXParErr2In,tagDSizeRamParErrIn};   
        1'b1: mar3b_DataIn = 3'b0;   
        default: mar3b_DataIn = 3'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(marE1)        
        1'b0: mar3b_reg <= mar3b_reg;        
        1'b1: mar3b_reg <= mar3b_DataIn;   
        default: mar3b_reg <= 3'bx;  
      endcase        
    end        

  assign {tlbSXParErr1L2,tlbSXParErr2L2,tagDSizeRamParErrL2} = mar3b_reg;

// TRI 08/24/01
// Added for timing.
// The parity error from Reg MAR3b is the or of all for other parity bits.
// 2 from the ram and from the DSize and DT bits.
// TRI 08/28/01
// removed defect 1853
//dp_regMMU_MAR3b regMMU_MAR3b (
//     .D0   (parErr3),
//     .D1   (1'b0),
//     .SD   (resetL2 | UTLB_Miss),
//     .L2   (marParErr3L2),
//     .E2   (parE2),
//     .CB   (CB),
//     .I    (scan20b),
//     .SO   (scan20c) );

//dp_regMMU_MAR3 regMMU_MAR3 (
//     .D0   ({tagParErr1,tagParErr2,tagParErr3,tagParErr4,ramParErr1,ramParErr2}),
//     .D1   (6'b0),
//     .SD   (resetL2 | UTLB_Miss),
//     .L2   ({marTagParErr1L2,marTagParErr2L2,marTagParErr3L2,marTagParErr4L2,marRamParErr1L2,marRamParErr2L2}),
//     .E1   (parE1),
//     .CB   (CB),
//     .I    (scan20a),
//     .SO   (scan20b) );

// TRI 08/24/01
// This latch is to hold the value of the EPN for a lookup.
// The EPN is not driven from the UTLB on a lookup so we must
// latch the EPN for parity checking.

  // Removed the module "dp_regMMU_MAR4"
  always @(EPN_EA_i or resetL2)    
    begin        
      casez(resetL2)        
        1'b0: mar4_DataIn = EPN_EA_i[0:21];   
        1'b1: mar4_DataIn = 22'b0;   
        default: mar4_DataIn = 22'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(resetL2 | LookupenForEnC1)
        1'b0: EPN_EAL2 <= EPN_EAL2;
        1'b1: EPN_EAL2 <= mar4_DataIn;
        default: EPN_EAL2 <= 22'bx;
      endcase
    end

// ***********************************************************************
// Generate Errors
// ***********************************************************************
// Zone Fault
//      msrPR = 1, ZonePR = 00
// Execute Fault
//   1) msrPR = 0, EX = 0, ZonePR = 0x
//   2) msrPR = 1, EX = 0, ZonePR = 01
//   3) msrPR = 1, EX = 0, ZonePR = 10
// Write Fault
//   1) Store = 1, WR = 0, msrPR = 1, ZonePR = 01
//   2) Store = 1, WR = 0, msrPR = 1, ZonePR = 10
//   3) Store = 1, WR = 0, msrPR = 0, ZonePR = 0x
// U0Fault
//   cdbcrFDK = 1, Store = 1, U0 = 1
// AlignFault
//   1) dcbz = 1, I = 0
//   2) dcbz = 1, W = 1
//
// ***********************************************************************
// The error that are generated from the UTLB are only valid on a UTLB Hit.
// When a UTLB Miss occurs, the data is undefined.
// ***********************************************************************

assign zoneFault  = msrPrL2 & ~(|marZonePR_i[0:1]);

assign exFault    = ~marEX & (( msrPrL2 & (marZonePR_i[0] ^  marZonePR_i[1])) |
                              (~msrPrL2 & ~marZonePR_i[0]));

// ***********************************************************************
// write fault can occur when the data is sent from the UTLB or on a DTLB hit.
// In the case of a DTLB hit, the data is saved in the PAR and the error is
// generated the cycle after the hit.
// ***********************************************************************
assign writeFault = StNotLdL2 & (~marWR_i & (( msrPrL2 & (marZonePR_i[0] ^ marZonePR_i[1])) |
                                           (~msrPrL2 & ~marZonePR_i[0])));

assign parWriteFault = StNotLdL2 & parAttrValid &
                         (~parWR & (( msrPrL2 & (parZonePR[0] ^ parZonePR[1])) |
                                    (~msrPrL2 & ~parZonePR[0])));

// ***********************************************************************
// UO (formerly Kompressed) error occurs when cdbcrFDK is enabled and a
// store is done with the U0 (formerly dsK) bit a logic one. This error
// is similar to the write fault in that it can occur in two different cases:
// 1) A DTLB miss occurs and the attributes are sent from the UTLB
// 2) a DTLB hit occurs and the attributes are saved in the PAR and the error is
//         generated the cycle after the hit.
// ***********************************************************************
assign U0Fault = cdbcrFDK & StNotLdL2 & marU0_i;
assign parU0Fault = cdbcrFDK & parAttrValid & StNotLdL2 & parU0;

// ***********************************************************************
// Alignment Fault can occur from the UTLB when protection checking is done or
// from the DTLB when checking is done on a hit. DCBA and DCBZ both generate
// alignment errors, creating an abort to the cache, but the DCBA does not
// affect the dsStatus bus upon getting an alignment error.
// ***********************************************************************
assign alignFault = dcbzL2 & (~marCacheable_i | marW_i);
assign parAlignFault = dcbzL2 & parAttrValid & (~parI | parW);

assign dcbaFault = dcbaL2 & (~marCacheable_i | marW_i);
assign parDcbaFault = dcbaL2 & parAttrValid & (~parI | parW);

// ***********************************************************************
// generate i-side status before latching info into shadow
// 00 - good status
// 01 - Zone fault
// 10 - Protection (EX=0, G=1)
// 11 - TLB Miss
// ***********************************************************************
// TRI 07/17/01
// New Parity checking equation
assign isStatus[0]     = isStateD & (exFault | marG_i | marUTLB_Miss);
assign isStatus[1]     = isStateD & (zoneFault | marUTLB_Miss);
assign MMU_isParityErr = isStateD & parityErrSX;               // New output from MMU


//assign isgoodStatus = ~(|isStatus[0:1]);

// ***********************************************************************
// This is sent to the ICU. isXltValid is high unless one of the following
// conditions occur:
//   1) Virtual mode and itlbMiss
//   2) Real Mode and Speculative Access to Guarded Storage
// ***********************************************************************
assign isXltValid = (~msrIrL2_N & ~itlbMiss) | (msrIrL2_N & (isGReal_N | nonSpecAccL2));

// ***********************************************************************
// ---------------------- ITLB Interface -------------------
// ***********************************************************************
// KAM 7/8/98 Removed redundancy
// KAM 12/17/99 Removed isAbort from the equation.  It is very late so we will
//   always write the shadow in state D
//assign wrtITLB = isStateD & ~isAbort & isgoodStatus;
//assign wrtITLB = isStateD & ~isAbort & ~exFault & ~marG & ~marUTLB_Miss & ~zoneFault;
// in Real mode we always write entry 0. We force a hit on that entry to remove
// some muxing in the back end.
//assign wrtITLB = ~msrIR  | (isStateD & ~exFault & ~marG & ~marUTLB_Miss & ~zoneFault);

// TRI 07/17/01
// Changed equation for parity
//assign wrtITLB = (isStateD & ~exFault & ~marG & ~marUTLB_Miss & ~zoneFault);
assign wrtITLB = (isStateD & ~exFault & ~marG_i & ~marUTLB_Miss & ~zoneFault & ~parityErrSX);
assign isrdNotWrt_i = ~wrtITLB;

/*------------------------------------------------------------------------*/
// is Address register
// in virtual mode, increment the address every time the shadow is written
/*------------------------------------------------------------------------*/
assign isAddrE2 = isInvalidate_i | (~msrIrL2_N & wrtITLB);
assign isAddrIn = {2{~isInvalidate_i}} & (isAddrL2_i[0:1] + 2'b01);

  // Removed the module "dp_regMMU_isAddr"
  always @(posedge CB)      
    begin        
      casez(isAddrE2)        
        1'b0: isAddrL2_i <= isAddrL2_i;        
        1'b1: isAddrL2_i <= isAddrIn;        
        default: isAddrL2_i <= 2'bx;  
      endcase        
    end        

/*---------------------------------------------*/
// Outstanding Request Register
/*---------------------------------------------*/
// Original OSR equation
// OsrIn = ~resetL2 & ( (isCA & (~OsrL2 | EoOdd | isAbort | CancelData)) |
//                      (OsrL2 & (~EoOdd & ~CancelData)));
assign OsrInNoEoOdd = ~resetL2 & ((isCA & (OsrL2_N | isAbort | CancelData)) |
                                          (~OsrL2_N & ~CancelData));

assign OsrInEoOdd = ~resetL2 & isCA;

// For timing this has been changed to an inverting fast latch feeding an inverter

  // Removed the module "dp_regMMU_OSR"
  always @(OsrInNoEoOdd or OsrInEoOdd or EoOdd)    
    begin        
      casez(EoOdd)        
        1'b0: osr_DataIn = OsrInNoEoOdd;   
        1'b1: osr_DataIn = OsrInEoOdd;   
        default: osr_DataIn = 1'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      OsrL2torepower <= osr_DataIn;     
    end        

  // This is an inverting control path mux
  // Removed the module "dp_muxMMU_msrIRupdate"
  assign msrIRearlytoRepower = (~(msrIR) & ~(isEA0_21_E2forMsrIR_NEG)) |
                               (~(~msrIrL2_N & ~resetL2) & isEA0_21_E2forMsrIR_NEG);


  // Removed the module "dp_logMMU_msrIRrepower"
  assign msrIRearly = ~(msrIRearlytoRepower);

// For timing this has been changed to an inverting fast latch feeding an inverter
  // Removed the module "dp_regMMU_MSR"
   always @(posedge CB)      
    begin        
      MSR_reg <= {~msrIRearly,msrIRearly,msrPR};      
   end        

  assign {msrIr0_L2,msrIr1_L2_N,msrPrL2torepower_N} = ~(MSR_reg);

  // Removed the module "dp_logMMU_msrIR_repower"
  assign {OsrL2_N,msrIrL2_N,msrIrL2forITLB,msrPrL2} = ~({OsrL2torepower,msrIr0_L2,
                                                         msrIr1_L2_N,
                                                         msrPrL2torepower_N});

/*---------------------------------------------*/
// is Effective Address register
/*---------------------------------------------*/
// original equations. EoOdd used as mux sel for timing
//assign isEA0_21_E2 = fetchReq & isCA & (isAbort | (isNP & (CancelData | EoOdd | ~OsrL2)));
//assign isEA22_29_E2 = fetchReq & isCA & (isAbort | (isNewLine & (CancelData | EoOdd | ~OsrL2)));

assign isEA0_21_E2noEO = fetchReq & isCA & (isAbort | (isNP & (CancelData | OsrL2_N)));
assign isEA22_29_E2noEO = fetchReq & isCA & (isAbort | (isNewLine & (CancelData | OsrL2_N)));
assign isEA0_21_E2_EO = fetchReq & isCA & (isAbort | isNP );
assign isEA22_29_E2_EO = fetchReq & isCA & (isAbort | isNewLine);

assign msrIR_N = ~msrIR;
assign LoadRaAttrnoEO = isEA0_21_E2noEO & msrIR_N;
assign LoadRaAttr_EO =  isEA0_21_E2_EO & msrIR_N;


  // inverting control path mux
  // Removed the module "dp_muxMMU_isEAEoOddMux"
  assign {LoadRealRaAttr,isEA0_21_E2toRedrive_NEG,isEA0_21_E2forMsrIR_NEG,isEA22_29_E2_NEG} =
       (~({LoadRaAttrnoEO,isEA0_21_E2noEO,isEA0_21_E2_EO, isEA22_29_E2_EO}) & ~({{2{EoOdd}},
       {2{EoOdd_N}}})) | (~({LoadRaAttr_EO, isEA0_21_E2_EO, isEA0_21_E2noEO,isEA22_29_E2noEO}) &
       {{2{EoOdd}},{2{EoOdd_N}}});

  // Removed the module "dp_logMMU_isEA_E2repower"
  assign {EoOdd_N, isEA0_21_E2} = ~({EoOdd,isEA0_21_E2toRedrive_NEG});


assign isEA0_21_E2_NEG = ~isEA0_21_E2;
assign isEA0_21_E2forComp_NEG = ~isEA0_21_E2;

  // Removed the module "dp_logMMU_CompE2Nand"
  assign CompE2 = ~( isEA0_21_E2forComp_NEG & isrdNotWrt_i );


  //The isEA is inverted coming in to the MMU.
  // Removed the module "dp_logMMU_isEAinv"
  assign isEA[0:29] = ~(isEA_NEG[0:29]);

  // These are inverting 2 port fast latches.
            //     .D0      (isEA[0:10]),       // 1 - load new isEA
            //     .D1      (isEAL[0:10]),      // 0 - reload with latched version
            //     .SD      (isEA0_21_E2_NEG),  // E2 is selector
  // Removed the module "dp_regMMU_isEA0_10"
  always @(isEA or isEAL_i or isEA0_21_E2_NEG)    
    begin        
      casez(isEA0_21_E2_NEG)        
        1'b0: isEA0_10_DataIn = isEA[0:10];   
        1'b1: isEA0_10_DataIn = isEAL_i[0:10];   
        default: isEA0_10_DataIn = 11'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      isEAL2fromReg_NEG_reg[0:10] <= isEA0_10_DataIn;     
    end        

  assign isEAL2fromReg_NEG[0:10] = ~isEAL2fromReg_NEG_reg[0:10];

           //    .D0      (isEA[11:21]),      // 1 - load new isEA
           //    .D1      (isEAL[11:21]),     // 0 - reload with latched version
           //    .SD      (isEA0_21_E2_NEG),  // E2 is selector
  // Removed the module "dp_regMMU_isEA11_21"
  always @(isEA or isEAL_i or isEA0_21_E2_NEG)    
    begin        
      casez(isEA0_21_E2_NEG)        
        1'b0: isEA11_21_DataIn = isEA[11:21];   
        1'b1: isEA11_21_DataIn = isEAL_i[11:21];   
        default: isEA11_21_DataIn = 11'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      isEAL2fromReg_NEG_reg[11:21] <= isEA11_21_DataIn;     
    end        

  assign isEAL2fromReg_NEG[11:21] = ~isEAL2fromReg_NEG_reg[11:21];

  // repower isEA Latch
  // Removed the module "dp_logMMU_isEALinv"
  assign isEAL_i[0:21] = ~(isEAL2fromReg_NEG[0:21]);

  // 2 port fast latch
            //    .D0     (isEA[22:29]),          // 1 - load new isEA
            //    .D1     (isEA22_29_L2[22:29]),  // 0 - reload with latched version
            //    .SD     (isEA22_29_E2_NEG),     // E2 is selector
  // Removed the module "dp_regMMU_isEA22_29"
  always @(isEA or isEA22_29_L2 or isEA22_29_E2_NEG)    
    begin        
      casez(isEA22_29_E2_NEG)        
        1'b0: isEA22_29_DataIn = isEA[22:29];   
        1'b1: isEA22_29_DataIn = isEA22_29_L2[22:29];   
        default: isEA22_29_DataIn = 8'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      isEA22_29_L2[22:29] <= isEA22_29_DataIn;     
    end       

  // Removed the module "dp_regMMU_cancelData"
  always @(posedge CB)      
    begin        
      CancelDataL2<= (CancelData | CancelDataL2) & ~isCA;      
    end        

// ***********************************************************************
// changed to prevent xltValid from going high then low in the same line in real mode
// When a new access is received load the current value of nonSpecAcc
// From there load either nonSpecAcc or nonSpecAccL2. In real mode a SpecAcc to guarded
// storage will cause the ICU to wait. Once the SpecAcc becomes nonSpeculative, the
// register will reload and isXltValid will again go high
// ***********************************************************************

  // Removed the module "dp_regMMU_nonSpecAcc"
  always @(nonSpecAcc or nonSpecAccL2 or isEA0_21_E2forComp_NEG)    
    begin        
      casez(isEA0_21_E2forComp_NEG)        
        1'b0: nonSpecAcc_DataIn = nonSpecAcc;   
        1'b1: nonSpecAcc_DataIn = (nonSpecAcc | nonSpecAccL2);   
        default: nonSpecAcc_DataIn = 1'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      nonSpecAccL2 <= nonSpecAcc_DataIn;     
    end        

// ***********************************************************************
// To decrease the load on isEAL, bits [0:4] are latched seperately for
// real mode attribute select
// This is an inverting fast latch to an inverter to prevent buffers in synthesis
// ***********************************************************************

  // Removed the module "dp_regMMU_isEAforSprSel"
  always @(posedge CB)      
    begin        
      isEAforSprSel_reg <= isEA_NEG[0:4];      
    end        

  assign isEAforSprSel = ~isEAforSprSel_reg;

  // Removed the module "dp_logMMU_isSprSelinv"
  assign isEAforSprSel_N = ~(isEAforSprSel);

// ***********************************************************************
//   I-Side State Machine
// ***********************************************************************
// 00 - idle - isStateA
// 01 - cmd  - isStateB
// 10 - wait - isStateC
// 11 - data - isStateD
// ***********************************************************************

// assign goToisStateA = msrIrL2_N | isAbort | resetL2;
assign cancelReq =  (CancelData | CancelDataL2) & isNP;
assign goToisStateA = msrIrL2_N | isAbort | resetL2 | cancelReq;


always @ (goToisStateA or isStateL2 or itlbMiss or
          fetchReq or istlbBusy)
begin
  casez({goToisStateA,isStateL2,itlbMiss,fetchReq,istlbBusy})
                                          //synopsys full_case
   6'b1????? : isStateIn = 2'b00; // (A|B|C|D) -> A (isAbort | reset | Real mode)
   6'b?00?0? : isStateIn = 2'b00; // A -> A         (NO Req  )
   6'b?000?? : isStateIn = 2'b00; // A -> A         (ITLB HIT)
   6'b00011? : isStateIn = 2'b01; // A -> B         (Req and Miss)
   6'b001??0 : isStateIn = 2'b10; // B -> C         (~UTLB Busy)
   6'b001??1 : isStateIn = 2'b01; // B -> B         (UTLB Busy)
   6'b010??? : isStateIn = 2'b11; // C -> D         (~Abort)
   6'b?11??? : isStateIn = 2'b00; // D -> A         (~Abort)
   default   : isStateIn = 2'bxx; // x-catcher
  endcase
end

assign isStateA = ~(|isStateL2[0:1]);                    // 00
assign isStateB = ~isStateL2[0] &  isStateL2[1];         // 01
assign isStateC =  isStateL2[0] & ~isStateL2[1];         // 10
assign isStateD = &isStateL2[0:1];                       // 11

// generate E2 gate for is State
assign isStateE2 = resetL2 | fetchReq | ~isStateA;

/*---------------------------------------------*/
// is State register
/*---------------------------------------------*/

  // Removed the module "dp_regMMU_isState"
  always @(posedge CB)      
    begin        
      casez(isStateE2)        
        1'b0: isStateL2[0:1] <= isStateL2[0:1];        
        1'b1: isStateL2[0:1] <= isStateIn[0:1];        
        default: isStateL2[0:1] <= 2'bx;  
      endcase        
    end        

/*----------------------------------------------------------------------*/
// This register uses a dast latch for timing
// Protection Attribute register (D-Side)
// 0 - Access Check NOP              0:1 - ZonePR from DTLB
// 1 - Access Check Suppress           2 - WR from DTLB
// 2 - Store Op                        3 - U0 from DTLB
// 3 - icu Op                          4 - I from DTLB
// 4 - dcu Op                          5 - W from DTLB
// 5 - dcbz                            6 - Cmd Accept
// 6 - dcba
// 7:8 - msrDR
// 9 - dtlbMiss
/*-----------------------------------------------------------------------*/
// This register is only loaded when the d-side state machine is in state A.
// On a dtlbMiss, the data will be preserved until the state machine cycles
// back to dsStateA. To assist in timing, the attributes will be blindly
// written to the PAR dtlbMiss will also be stored and used in the next cycle
// to validate the PAR attributes. Note that TLB Ops do not generate an access
// check (even thought they are D-side ops) therefore no errors will be
// reported for them.
// ****************************************************************************
// The instruction in EXE will be aborted whenever there is an error in WB or
// a debug event in WB. Any dside instruction that generates a mmuExeAbort will
// be suppressed in WB so the next instruction must be blocked from executing.
// ****************************************************************************
//  Variables used to generate exeAbort:
//    VCT_mmuExeSuppress =
//
//    IFB_exeFlush =
//
//    PCL_mmuExeAbort =
//
// ****************************************************************************

assign mmuExeAbort = parAlignFault | parWriteFault | parU0Fault;
assign exeAbort = VCT_mmuExeSuppress | IFB_exeFlush | PCL_mmuExeAbort | mmuExeAbort;

assign dsCmdAccept = ACheck & ICU_dsCA & DCU_CA & ~exeAbort & ~PCL_wbHoldnonErr;

  // Removed the module "dp_regMMU_PAR"
  always @(posedge CB)      
    begin        
      casez(dsStateA)        
        1'b0: PAR_reg <= PAR_reg;        
        1'b1: PAR_reg <= {achkNop,achkSup,~LdNotSt,icuOp,dcuOp,dcbz,dcba,
                          msrDR,msrDR,dtlbMiss};        
        default: PAR_reg <= 10'bx;  
      endcase        
    end        

  assign {parAchkNop,parAchkSup,StNotLdL2,parIcuOp,parDcuOp,dcbzL2,dcbaL2,msrDrL2,
          msrDrL2forDTLB,parDtlbMiss} = PAR_reg;

  // Removed the module "dp_regMMU_PAR2"
  always @(posedge CB)      
    begin        
      casez(dsStateA)        
        1'b0: PAR2_reg <= PAR2_reg;        
        1'b1: PAR2_reg <= {DTLB_zonePR[0:1],DTLB_WR,DTLB_U0,DTLB_I,
                           DTLB_W,dsCmdAccept};        
        default: PAR2_reg <= 7'bx;  
      endcase        
    end        

  assign {parZonePR,parWR,parU0,parI,parW,dsCmdAcceptL2} = PAR2_reg;

/*----------------------------------------------------------------------*/
// The attributes are valid if the command was accepted and the d-side is
// either in real mode or there was a DTLB hit
// Note: In Real mode, the attributes are muxed in the DTLB
/*----------------------------------------------------------------------*/
assign parAttrValid = dsCmdAcceptL2 & (~msrDrL2 | ~parDtlbMiss);

// ***********************************************************************
// D-Side Errors
// ***********************************************************************
// generate d-side status before latching info into shadow
// 0 - Zone fault from the UTLB
// 1 - Write Fault from the UTLB
// 2 - Miss in UTLB
// 3 - Alignment from the UTLB
// 4 - U0 attribute exception in UTLB
// 5 - Write Fault from the Shadow
// 6 - Alignment exception from the Shadow
// 7 - U0 attribute exception from the Shadow
// ***********************************************************************
// TRI 07/17/01
// New Parity checking equation
assign dsStatus[0] =  parAchkSup & dsStateD_L2 & zoneFault ;
assign dsStatus[1] =  parAchkSup & dsStateD_L2 & writeFault;
assign dsStatus[2] =  parAchkSup & dsStateD_L2 & marUTLB_Miss;
assign dsStatus[3] =  parAchkSup & dsStateD_L2 & alignFault ;
assign dsStatus[4] =  parAchkSup & dsStateD_L2 & U0Fault;

assign dsStatus[5] =  parAchkSup & dsStateA_L2 & parWriteFault;
assign dsStatus[6] =  parAchkSup & dsStateA_L2 & parAlignFault;
assign dsStatus[7] =  parAchkSup & dsStateA_L2 & parU0Fault;
// TRI 10/31/01
// DEFECT 2020
assign MMU_dsParityErr = parAchkSup & dsStateD_L2 & parityErrSX; // New output from MMU

// 8/11/98 KAM - changed for timing need the latched version. Now sent in StateD
assign MMU_tlbSXHit =  tlbStateL2[0] & ~tlbStateL2[1] & tlbSX & ~marUTLB_Miss;

// TRI 07/17/01
// Added equations for parity
//assign MMU_tlbSXParityErr = tlbStateL2[0] & ~tlbStateL2[1] & tlbSX & parityErrSX;
//assign MMU_tlbREParityErr = tlbStateL2[0] & ~tlbStateL2[1] & ~tlbRE_buf_N[0] & parityErrRE;
// TRI 10/31/01
// DEFECT 2020
assign MMU_tlbSXParityErr = tlbStateD & tlbSX & parityErrSX;
assign MMU_tlbREParityErr = tlbStateD & ~tlbRE_buf_N[0] & parityErrRE;

// ***********************************************************************
// ---------------------- DTLB Interface -------------------
// ***********************************************************************

// TRI 07/17/01
// Change equation for parity
//assign wrtDTLB = dsStateD & ~wbAbort & ~marUTLB_Miss & ~zoneFault & ~writeFault
//                                     & ~U0Fault & ~alignFault ;
assign wrtDTLB = dsStateD_i & ~wbAbort & ~marUTLB_Miss & ~zoneFault & ~writeFault
                                     & ~U0Fault & ~alignFault & ~parityErrSX;
assign dsrdNotWrt = ~wrtDTLB;

// either write the shadow and thus validate the translation or return bad status
// Pass2 latch in the MMU for the DCU
// TRI 10/31/01
// DEFECT 2020
//assign dcuXltValid = (msrDrL2 & ((dsStateA & ~dtlbMiss) | wrtDTLB)) | ~msrDrL2;
assign dcuXltValid = (msrDrL2 & (((dsStateA & ~dtlbMiss) | wrtDTLB) |
                     (parityErrSX & ~ICU_CCR0TPE & dsStateD_L2 & ~UTLB_Miss))) | ~msrDrL2;

assign dsAddrE2 = dsInvalidate_i | wrtDTLB;
assign dsAddrIn = {3{~dsInvalidate_i}} & (dsAddrL2_i[0:2] + 3'b001);

/*---------------------------------------------*/
// ds Address register
/*---------------------------------------------*/

  // Removed the module "dp_regMMU_dsAddr"
  always @(posedge CB)      
    begin        
      casez(dsAddrE2)        
        1'b0: dsAddrL2_i <= dsAddrL2_i;        
        1'b1: dsAddrL2_i <= dsAddrIn[0:2];        
        default: dsAddrL2_i <= 3'bx;  
      endcase        
    end        

/*---------------------------------------------*/
// ds Effective Address Valid bit
/*---------------------------------------------*/
//assign dcuSpecialOp = dcuOp & ~dcuStore & ~dcuLoad;
//assign reset_dsEAL_Valid =  resetL2 | cntxSync | DCU_mmuBufferMod | dcuSpecialOp;

//assign dsEAL_ValidIn = ~(resetL2 | cntxSync | DCU_mmuBufferMod) &
//                         (((dcuStore | dcuLoad) & DCU_CA &
//                                  ((~exeAbort & ~PCL_wbHoldnonErr) | dsEAL_ValidL2)) |
//                          (dsEAL_ValidL2 & ~ACheck));
//
//
//dp_regMMU_dsEAL_Valid regMMU_dsEAL_Valid (
//                     .D       (dsEAL_ValidIn),
//                     .L2      (dsEAL_ValidL2),
//                     .CB      (CB),
//                     .I       (scan12),
//                     .SO      (scan13)   );

// ***********************************************************************
// Removed because was causing problems in DCU it was not worth it.
// ***********************************************************************
// Suppress the DCU read (for power savings) when
//  Valid bit is set and reading from same address that is latched
//  If we are resetting the latch, then we will not suppress the read for that
//  current cycle
// ***********************************************************************
//added custom comparator to help timing
//dsEA_Comp28 dsEA_Comp28 (dsEAisSame,dsEAL2[0:27], ~dsEAL2[0:27],dsEA_N[0:27]);

//assign dcuSuppressRead = dsEAL_ValidL2 & ~reset_dsEAL_Valid & dsEAisSame;
//assign missComp = ~dcuSuppressRead;


/*----------------------------------------------------------------------*/
// ds Effective Address register
// These registers are inverting since I receive dsEA_N
// Latch the effective address if
//  1) You are in State A and
//  2) storage request is made which miscmpares with the existing EAL and
//  3) DCU is accepting the command and
//  4) the pipe is not being held for any non-error reason
//  5) the current request is not being aborted
/*-----------------------------------------------------------------------*/
// took out dtlbmiss per conversation with Jim. Latch dsEA everytime there is
// a storage Op in EXE or there is a tlbSX instruction in EXE
//assign dsEA0_27_E2 = dtlbMiss | (missComp & dcuOp);
//assign dsEA0_27_E2 = ~exeAbort & ~dsEAisSame & DCU_CA ;

// took out power savings it was too much trouble with suppress read
//assign dsEA28_31_E2 = ACheck & ~exeAbort ;
//combined dsEA0_27 and dsEA28_31 because power savings was removed
//assign dsEA0_27_E1 = (ACheck & exeStorageOp & ~dsStateL2[0] & ~PCL_wbHoldnonErr) |
//                     (tlbSX & tlbStateA);
//assign dsEA0_27_E2 = (~exeAbort & DCU_CA) | (tlbSX & tlbStateA);

// tlbOps can only be latched if the d-side state machine is in state A.
// In any other state there is a miss and the dtlb needs the efective address to
// be held in the latch.
//assign dsEA_E1 = ((ACheck & exeStorageOp) | tlbSX) & dsStateA;
//assign dsEA_E2 = ~exeAbort & ~PCL_wbHoldnonErr &
//                     ((DCU_CA & ICU_dsCA) | (tlbSX & tlbStateA & dsStateA));

assign dsEA_E1 = (exeStorageOp | tlbSX) & dsStateA_L2;
assign dsEA_E2 = ~exeAbort & ~PCL_wbHoldnonErr &
                     ((ACheck & DCU_CA & ICU_dsCA) | (tlbSX & tlbStateA & dsStateA));

  // This is an inverting register.
  // Removed the module "dp_regMMU_dsEAL"
  always @(posedge CB)      
    begin        
      casez(dsEA_E1 & dsEA_E2)        
        1'b0: dsEAL2_reg[0:31] <= dsEAL2_reg[0:31];        
        1'b1: dsEAL2_reg[0:31] <= dsEA_N[0:31];        
        default: dsEAL2_reg[0:31] <= 32'bx;  
      endcase        
    end        

  assign dsEAL2[0:31] = ~(dsEAL2_reg[0:31]);

//dp_regMMU_dsEAL28_31 regMMU_dsEAL28_31 (
//                     .D       (dsEA_N[28:31]),
//                     .L2      (dsEA28_31_L2[28:31]),
//                     .E1      (~dsStateL2[0]),
//                     .E2      (dsEA28_31_E2),
//                    .CB      (CB),
//                     .I       (scan12),
//                     .SO      (scan13)   );

//assign dsEAL2[0:31] = {dsEA0_27_L2,dsEA28_31_L2};


// ***********************************************************************
//   D-Side State Machine
// ***********************************************************************
// 000 - idle - dsStateA
// 100 - cmd  - dsStateB
// 101 - wait - dsStateC
// 111 - data - dsStateD
// ***********************************************************************
// EXE abort should only affect the d-side in state A
//assign goTodsStateA = ~msrDrL2 | resetL2 | wbAbort | exeAbort;
assign goTodsStateA = ~msrDrL2 | resetL2 | wbAbort;
assign MMU_dsStateBorC = dsStateL2[0] & ~dsStateL2[1];

//assign dsrequest = ACheck & ~exeAbort;
assign dsrequest = ACheck & ~exeAbort & DCU_CA & ICU_dsCA & ~PCL_wbHoldnonErr;
always @ (goTodsStateA or dsStateL2 or dtlbMiss or dsrequest)
begin
  casez({goTodsStateA,dsStateL2,dtlbMiss,dsrequest})
                                          //synopsys full_case
   6'b1????? : dsStateIn = 3'b000; // (A|B|C|D) -> A (reset | realMode | instr aborted)
   6'b?000?0 : dsStateIn = 3'b000; // A -> A         (NO Req  )
   6'b?00001 : dsStateIn = 3'b000; // A -> A         (DTLB HIT)
   6'b000011 : dsStateIn = 3'b100; // A -> B         (Req and Miss)
   6'b0100?? : dsStateIn = 3'b101; // B -> C         (~Abort)
   6'b0101?? : dsStateIn = 3'b111; // C -> D         (~Abort)
   6'b?111?? : dsStateIn = 3'b000; // D -> A         (~Abort)
   default   : dsStateIn = 3'bxxx; // x-catcher
  endcase
end

assign dsStateA = ~dsStateL2[0];                                // 000
assign dsStateB = dsStateL2[0] & ~(|dsStateL2[1:2]);            // 100
assign dsStateC = ~dsStateL2[1] & dsStateL2[2];                 // x01
assign dsStateD_i = &dsStateL2[1:2];                              // x11

// latched these signals for timing. They generate the dsStatus which
// is in sprHold critical path
assign dsStateA_In = ~dsStateIn[0];
assign dsStateD_In = &dsStateIn[1:2];

/*---------------------------------------------*/
// ds State register
/*---------------------------------------------*/
// generate E1 gate for ds State
assign dsStateE1 = resetL2 | ACheck | dsStateL2[0];

  // This is a fast latch for timing
  // Removed the module "dp_regMMU_dsState"
  always @(posedge CB)      
    begin        
      casez(dsStateE1)        
        1'b0: dsState_reg <= dsState_reg;        
        1'b1: dsState_reg <= {dsStateIn[0:2],dsStateA_In,dsStateD_In};        
        default: dsState_reg <= 5'bx;  
      endcase        
    end        

  assign {dsStatetoRe1[0:2],dsStateAtoRe1,dsStateDtoRe1} = dsState_reg;


  // Repower the outputs for dsState Reg to drive wbHold and the State

  // Removed the module "dp_logMMU_dsStateRepower1"
  assign {dsStatetoRe2[0:2],dsStateAtoRe2,dsStateDtoRe2} = ~({dsStatetoRe1[0:2],
                                                              dsStateAtoRe1,
                                                              dsStateDtoRe1});

  // Removed the module "dp_logMMU_dsStateRepower2"
  assign {dsStateL2[0:2],dsStateA_L2,dsStateD_L2} = ~({dsStatetoRe2[0:2],dsStateAtoRe2,
                                                       dsStateDtoRe2});

// ***********************************************************************
// ---------------------- PARITY GENERATION SECTION ----------------------
// ***********************************************************************

// ***********************************************************************
// --------------------- TLB write parity generation --------------------
// ***********************************************************************

assign tagGenPar1 = ((((sprData[0]  ^ sprData[2])      ^ (sprData[4]  ^ sprData[6]))        ^
                     (((sprData[8]  & (~(decSize[0]))) ^ (sprData[10] & (~(decSize[1]))))   ^
                      ((sprData[12] & (~(decSize[2]))) ^ (sprData[14] & (~(decSize[3])))))) ^
                    ((((sprData[16] & (~(decSize[4]))) ^ (sprData[18] & (~(decSize[5]))))   ^
                      ((sprData[20] & (~(decSize[6]))) ^ pidL2[0]))   ^
                      ((pidL2[2]    ^ pidL2[4])        ^ (pidL2[6]    ^ sprData[25]         ^ sprData[26]))));
assign tagGenPar2 = ((((sprData[1]  ^ sprData[3])      ^ (sprData[5]  ^ sprData[7]))        ^
                     (((sprData[9]  & (~(decSize[0]))) ^ (sprData[11] & (~(decSize[1]))))   ^
                      ((sprData[13] & (~(decSize[2]))) ^ (sprData[15] & (~(decSize[3])))))) ^
                    ((((sprData[17] & (~(decSize[4]))) ^ (sprData[19] & (~(decSize[5]))))   ^
                      ((sprData[21] & (~(decSize[6]))) ^ pidL2[1]))   ^
// TRI 10/8/01
// ICU_CCR1TLBE is for parity injection
                     (((pidL2[3]    ^ pidL2[5])        ^ (pidL2[7]    ^ sprData[27] ^ ICU_CCR1TLBE)))));
assign tagGenPar3 = ((decSize[0]    ^ decSize[2])      ^ (decSize[4]  ^ decSize[6]));
assign tagGenPar4 = ((decSize[1]    ^ decSize[3])      ^ (decSize[5]  ^ ~|pidL2[0:7]));
assign ramGenPar1 = ((((sprData[0]  ^ sprData[2])  ^ (sprData[4]   ^ sprData[6]))    ^
                      ((sprData[8]  ^ sprData[10]) ^ (sprData[12]  ^ sprData[14])))  ^
                     (((sprData[16] ^ sprData[18]) ^ (sprData[20]  ^ sprData[22]))   ^
                      ((sprData[24] ^ sprData[26]) ^ (sprData[28]  ^ sprData[30]))));
assign ramGenPar2 = ((((sprData[1]  ^ sprData[3])  ^ (sprData[5]   ^ sprData[7]))    ^
                      ((sprData[9]  ^ sprData[11]) ^ (sprData[13]  ^ sprData[15])))  ^
                     (((sprData[17] ^ sprData[19]) ^ (sprData[21]  ^ sprData[23]))   ^
// TRI 10/8/01
// ICU_CCR1TLBE is for parity injection
                      ((sprData[25] ^ sprData[27]) ^ (sprData[29]  ^ sprData[31] ^ ICU_CCR1TLBE))));

// ***********************************************************************
// --------------------- TLB read and serach parity generation -----------
// ***********************************************************************

// 9-18-01  JRS  Replacing UTLB_V with 1'b1 since will only report parity errors for valid entries (UTLB_V = 1'b1).
//               Done to match gates for formality.
assign tagGenUTLBParRe1 = ((((UTLB_EPN[0]  ^ UTLB_EPN[2])          ^ (UTLB_EPN[4]   ^ UTLB_EPN[6]))          ^
                            (((UTLB_EPN[8] & (~(UTLB_DSize[0])))   ^ (UTLB_EPN[10]) & (~(UTLB_DSize[1])))    ^
                            ((UTLB_EPN[12] & (~(UTLB_DSize[2])))   ^ (UTLB_EPN[14]  & (~(UTLB_DSize[3])))))) ^
                          ((((UTLB_EPN[16] & (~(UTLB_DSize[4])))   ^ (UTLB_EPN[18]) & (~(UTLB_DSize[5])))    ^
                            ((UTLB_EPN[20] & (~(UTLB_DSize[6])))   ^ UTLB_TID[0]))  ^
                            ((UTLB_TID[2]  ^ UTLB_TID[4])          ^ (UTLB_TID[6]   ^ 1'b1 ^ UTLB_E))));
//assign tagGenUTLBParRe1 = ((((UTLB_EPN[0]  ^ UTLB_EPN[2])          ^ (UTLB_EPN[4]   ^ UTLB_EPN[6]))          ^
//                            (((UTLB_EPN[8] & (~(UTLB_DSize[0])))   ^ (UTLB_EPN[10]) & (~(UTLB_DSize[1])))    ^
//                            ((UTLB_EPN[12] & (~(UTLB_DSize[2])))   ^ (UTLB_EPN[14]  & (~(UTLB_DSize[3])))))) ^
//                          ((((UTLB_EPN[16] & (~(UTLB_DSize[4])))   ^ (UTLB_EPN[18]) & (~(UTLB_DSize[5])))    ^
//                            ((UTLB_EPN[20] & (~(UTLB_DSize[6])))   ^ UTLB_TID[0]))  ^
//                            ((UTLB_TID[2]  ^ UTLB_TID[4])          ^ (UTLB_TID[6]   ^ UTLB_V ^ UTLB_E))));
assign tagGenUTLBParRe2 = ((((UTLB_EPN[1]  ^ UTLB_EPN[3])          ^ (UTLB_EPN[5]   ^ UTLB_EPN[7]))          ^
                           (((UTLB_EPN[9]  & (~(UTLB_DSize[0])))   ^ (UTLB_EPN[11]) & (~(UTLB_DSize[1])))    ^
                            ((UTLB_EPN[13] & (~(UTLB_DSize[2])))   ^ (UTLB_EPN[15]  & (~(UTLB_DSize[3])))))) ^
                          ((((UTLB_EPN[17] & (~(UTLB_DSize[4])))   ^ (UTLB_EPN[19]) & (~(UTLB_DSize[5])))    ^
                            ((UTLB_EPN[21] & (~(UTLB_DSize[6])))   ^ UTLB_TID[1]))  ^
                            ((UTLB_TID[3]  ^ UTLB_TID[5])          ^ (UTLB_TID[7]   ^ UTLB_U0))));
assign tagGenUTLBParSx1 = ((((EPN_EAL2[0]  ^ EPN_EAL2[2])        ^ (EPN_EAL2[4]  ^ EPN_EAL2[6]))          ^
                           (((EPN_EAL2[8]  & (~(UTLB_DSize[0]))) ^ (EPN_EAL2[10] & (~(UTLB_DSize[1]))))   ^
                            ((EPN_EAL2[12] & (~(UTLB_DSize[2]))) ^ (EPN_EAL2[14] & (~(UTLB_DSize[3])))))) ^
                          ((((EPN_EAL2[16] & (~(UTLB_DSize[4]))) ^ (EPN_EAL2[18] & (~(UTLB_DSize[5]))))   ^
                            ((EPN_EAL2[20] & (~(UTLB_DSize[6]))) ^ (pidL2[0]     & ~UTLB_DT)))            ^
                           (((pidL2[2]     & ~UTLB_DT)           ^ (pidL2[4])    & ~UTLB_DT)              ^
                            ((pidL2[6]     & ~UTLB_DT)           ^ (1'b1)        ^ UTLB_E))));
assign tagGenUTLBParSx2 = ((((EPN_EAL2[1]  ^ EPN_EAL2[3])        ^ (EPN_EAL2[5]  ^ EPN_EAL2[7]))          ^
                           (((EPN_EAL2[9]  & (~(UTLB_DSize[0]))) ^ (EPN_EAL2[11] & (~(UTLB_DSize[1]))))   ^
                            ((EPN_EAL2[13] & (~(UTLB_DSize[2]))) ^ (EPN_EAL2[15] & (~(UTLB_DSize[3])))))) ^
                          ((((EPN_EAL2[17] & (~(UTLB_DSize[4]))) ^ (EPN_EAL2[19] & (~(UTLB_DSize[5]))))   ^
                            ((EPN_EAL2[21] & (~(UTLB_DSize[6]))) ^ (pidL2[1]     & ~UTLB_DT)))            ^
                           (((pidL2[3]     & ~UTLB_DT)           ^ (pidL2[5]     & ~UTLB_DT))             ^
                            ((pidL2[7]     & ~UTLB_DT)           ^ UTLB_U0))));
assign tagGenUTLBPar3 = ((UTLB_DSize[0] ^ UTLB_DSize[2]) ^ (UTLB_DSize[4]     ^ UTLB_DSize[6]));
assign tagGenUTLBPar4 = ((UTLB_DSize[1] ^ UTLB_DSize[3]) ^ (UTLB_DSize[5]     ^ UTLB_DT)) ;
assign ramGenUTLBPar1 = ((((UTLB_RPN[0]  ^ UTLB_RPN[2])  ^ (UTLB_RPN[4]       ^ UTLB_RPN[6]))   ^
                          ((UTLB_RPN[8]  ^ UTLB_RPN[10]) ^ (UTLB_RPN[12]      ^ UTLB_RPN[14]))) ^
                         (((UTLB_RPN[16] ^ UTLB_RPN[18]) ^ (UTLB_RPN[20]      ^ UTLB_EX))       ^
                          ((UTLB_ZSEL[0] ^ UTLB_ZSEL[2]) ^ (UTLB_W            ^ UTLB_M))));
assign ramGenUTLBPar2 = ((((UTLB_RPN[1]  ^ UTLB_RPN[3])  ^ (UTLB_RPN[5]       ^ UTLB_RPN[7]))   ^
                          ((UTLB_RPN[9]  ^ UTLB_RPN[11]) ^ (UTLB_RPN[13]      ^ UTLB_RPN[15]))) ^
                         (((UTLB_RPN[17] ^ UTLB_RPN[19]) ^ (UTLB_RPN[21]      ^ UTLB_WR))       ^
                          ((UTLB_ZSEL[1] ^ UTLB_ZSEL[3]) ^ (UTLB_CacheInhibit ^ UTLB_G))));
// TRI 08/24/01
// Removed for timing.
//dp_muxPAR muxPAR (
//     .D0   ({tagGenUTLBPar1,   tagGenUTLBPar2}),
//     .D1   ({tagGenUTLBParRe1, tagGenUTLBParRe2}),
//     .Z    ({tagGenMux1,       tagGenMux2}),
//     .SD   (tlbRE_buf_N[1]));

//dp_muxPAR muxPAR (
//     .D0   ({tagGenUTLBParRe1, tagGenUTLBParRe2}),
//     .D1   ({tagGenUTLBPar1,   tagGenUTLBPar2}),
//     .Z    ({tagGenMux1,       tagGenMux2}),
//     .SD   ((tlbSX|dtlbMiss|itlbMiss)&~tlbRE));

assign tlbREParErr1In      = tagGenUTLBParRe1   ^ UTLB_T1;
assign tlbREParErr2In      = tagGenUTLBParRe2   ^ UTLB_T2;
assign tlbSXParErr1In      = tagGenUTLBParSx1   ^ UTLB_T1;
assign tlbSXParErr2In      = tagGenUTLBParSx2   ^ UTLB_T2;
assign tagParErr3          = tagGenUTLBPar3     ^ UTLB_T3;
assign tagParErr4          = tagGenUTLBPar4     ^ UTLB_T4;
assign ramParErr1          = ramGenUTLBPar1     ^ UTLB_R1;
assign ramParErr2          = ramGenUTLBPar2     ^ UTLB_R2;
assign tagDSizeParErrIn    = tagParErr3         | tagParErr4;
assign ramParErrIn         = ramParErr1         | ramParErr2;
assign tagDSizeRamParErrIn = tagDSizeParErrIn   | ramParErrIn;
assign parityErrSX         = tlbSXParErr1L2     | tlbSXParErr2L2 | tagDSizeRamParErrL2;
assign parityErrRE         = ((tlbREParErr1L2   | tlbREParErr2L2 | tagDSizeParErrL2) & ~tlbWC) | (ramParErrL2 & tlbWC);
// TRI 10/31/01
// defect 2020
assign parityErrSXwTPE     = (tlbSXParErr1L2     | tlbSXParErr2L2 | tagDSizeRamParErrL2) & ICU_CCR0TPE;

endmodule
