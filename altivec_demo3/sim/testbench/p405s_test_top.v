//===============================================================================
//  File Name       : p405s_test_top.v
//  File Revision   : 2.0
//  Date            : 2014/11/06
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  History         :
//  ----------------------------------------------------------------------------
//  Description     : p405s_test_top
//  Function        :
//  ----------------------------------------------------------------------------
// Copyright (c) 2014,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================
//
// `timescale 1ns/1ns //default value 

//
// Dont Change Definitions
//
`define DONE_TIME 5000

module p405s_test_top;

parameter simulation_cycle = 10;

reg          SystemClock;
reg          TEST_c405ScanEnable;
reg          TEST_c405ScanEnable_r;
reg          TEST_c405ScanEnable_r2;
reg          TEST_c405ScanEnable_r3;
reg          TEST_c405ScanEnable_r4;
//reset signal
reg          RST_c405ResetChip;
reg          RST_c405ResetCore;
reg          RST_c405ResetSystem;

wire         C405_apuDcdFull;
wire         C405_apuDcdHold;
wire [0: 31] C405_apuDcdInstruction;
wire         C405_apuExeFlush;
wire         C405_apuExeHold;
wire [0: 31] C405_apuExeLoadDBus;
wire         C405_apuExeLoadDValid;
wire [0: 31] C405_apuExeRaData;
wire [0: 31] C405_apuExeRbData;
wire [0:  1] C405_apuExeWdCnt;
wire         C405_apuMsrFE0;
wire         C405_apuMsrFE1;
wire [0:  3] C405_apuWbByteEn;
wire         C405_apuWbEndian;
wire         C405_apuWbFlush;
wire         C405_apuWbHold;
wire         C405_apuXerCA;

wire         C405_cpmCoreSleepReq;
wire         C405_cpmMsrCE;
wire         C405_cpmMsrEE;
wire         C405_cpmTimerIRQ;
wire         C405_cpmTimerResetReq;
//Interface with dsocm and isocm module
wire [0: 29] C405_dsocmABus;
wire         C405_dsocmAbortOp;
wire         C405_dsocmAbortReq;
wire [0:  3] C405_dsocmByteEn;
wire         C405_dsocmCacheable;
wire         C405_dsocmGuarded;
wire         C405_dsocmLoadReq;
wire         C405_dsocmStoreReq;
wire         C405_dsocmStringMultiple;
wire         C405_dsocmU0Attr;
wire         C405_dsocmWait;
wire [0: 31] C405_dsocmWrDBus;
wire         C405_dsocmXlateValid;
wire [0: 29] C405_isocmABus;
wire         C405_isocmAbort;
wire         C405_isocmCacheable;
wire         C405_isocmContextSync;
wire         C405_isocmIcuReady;
wire         C405_isocmReqPending;
wire         C405_isocmU0Attr;
wire         C405_isocmXlateValid;

wire [0:  7] C405_testScanOut;

wire         C405_rstChipResetReq;
wire         C405_rstCoreResetReq;
wire         C405_rstSystemResetReq;

wire         C405_trcTriggerEventOut;

wire         APU_c405DcdApuOp;
wire         APU_c405DcdCREn;
wire         APU_c405DcdForceAlgn;
wire         APU_c405DcdForceBESteering;
wire         APU_c405DcdFpuOp;
wire         APU_c405DcdGprWrite;
wire         APU_c405DcdLdStByte;
wire         APU_c405DcdLdStDw;
wire         APU_c405DcdLdStHw;
wire         APU_c405DcdLdStQw;
wire         APU_c405DcdLdStWd;
wire         APU_c405DcdLoad;
wire         APU_c405DcdPrivOp;
wire         APU_c405DcdRaEn;
wire         APU_c405DcdRbEn;
wire         APU_c405DcdStore;
wire         APU_c405DcdTrapBE;
wire         APU_c405DcdTrapLE;
wire         APU_c405DcdUpdate;
wire         APU_c405DcdValidOp;
wire         APU_c405DcdXerCAEn;
wire         APU_c405DcdXerOVEn;
wire         APU_c405Exception;
wire         APU_c405ExeBlockingMCO;
wire         APU_c405ExeBusy;
wire [0:  3] APU_c405ExeCR;
wire [0:  2] APU_c405ExeCRField;
wire         APU_c405ExeLdDepend;
wire         APU_c405ExeNonBlockingMCO;
wire [0: 31] APU_c405ExeResult;
wire         APU_c405ExeXerCA;
wire         APU_c405ExeXerOV;
wire         APU_c405FpuException;
wire         APU_c405LwbLdDepend;
wire         APU_c405SleepReq;
wire         APU_c405WbLdDepend;


wire         DSOCM_c405Complete;
wire         DSOCM_c405DisOperandFwd;
wire         DSOCM_c405Hold;
wire [0: 31] DSOCM_c405RdDBus;

wire         ISOCM_c405Hold;
wire [0: 63] ISOCM_c405RdDBus;
wire [0:  1] ISOCM_c405RdDValid;

wire         JTG_c405TCK;
wire         JTG_c405TRST_NEG;

wire         CPM_c405Clock;
wire         CPM_c405CpuClkEn_CClk;
wire         CPM_c405JtagClkEn_CClk;

wire         EIC_c405CritInputIRQ;
wire         EIC_c405ExtInputIRQ;

wire         TIE_c405DeterministicMult;
wire         TIE_c405DisOperandFwd;
wire         TIE_c405MmuEn;
wire [0: 31] TIE_c405PVR;
wire         TIE_c405ClockEnable;
wire         TIE_c405DutyEnable;

wire         TRC_c405TriggerEventIn;
wire [0:  2] C405_bistPepsPF;
//Internal signal defination
//Interface with APU Controller
// wire         APU_AltiVec_cs;
wire [0: 31] APU_AltiVec_Ins;
wire [0: 31] APU_AltiVec_RaData;
wire [0: 31] APU_AltiVec_RbData;
wire         APU_AltiVec_DcdHold;
wire         AltiVec_APU_ValidOp;
wire         AltiVec_APU_ExeBusy;
wire         AltiVec_APU_RaEn;
wire         AltiVec_APU_RbEn;
wire         AltiVec_APU_CR6En;
wire [0:  3] AltiVec_APU_CRData;
//Interface with Vector Data Memory
wire [0:127] Mem_AltiVecData;
wire         AltiVec_Mem_cs;
wire         AltiVec_Mem_RW;
wire [0: 31] AltiVec_MemAddr;
wire [0:127] AltiVec_MemData;
wire [0: 15] Altivec_Mem_WriteEn;

integer desc1;
integer i;

//
// Clock Assignments
//
assign CPM_c405Clock             = SystemClock;

//
// Initialization of Processor inputs
//
assign TIE_c405PVR [0:31]        = 32'hC00D_143;
assign TIE_c405MmuEn             = 1'b1;
assign TIE_c405DeterministicMult = 1'b0;
assign TIE_c405DisOperandFwd     = 1'b0;
assign TIE_c405ClockEnable       = 1'b1;
assign TIE_c405DutyEnable        = 1'b1;

// Trace Signals
assign TRC_c405TriggerEventIn =  C405_trcTriggerEventOut;

//Clock,Reset,Sleep Logic
wire crsa, crsb, crsc, crsd;
reg C405_cpmMsrEE_r, C405_cpmMsrCE_r;
reg crsd_r;
always @(CPM_c405Clock)
begin
  C405_cpmMsrEE_r <= C405_cpmMsrEE;
  C405_cpmMsrCE_r <= C405_cpmMsrCE;
  crsd_r          <= crsd;
end
//-----------added by clp------------
assign EIC_c405ExtInputIRQ    = 1'b0;
assign EIC_c405CritInputIRQ   = 1'b0;
//----------end added--------------
assign crsa = C405_cpmMsrEE_r & EIC_c405ExtInputIRQ;
assign crsb = C405_cpmMsrCE_r & EIC_c405CritInputIRQ;
assign crsc = C405_cpmTimerResetReq  | C405_cpmTimerIRQ     |
              C405_rstChipResetReq   | C405_rstCoreResetReq |
              C405_rstSystemResetReq | RST_c405ResetSystem  |
              RST_c405ResetCore      | RST_c405ResetChip;
assign crsd = ~(crsa | crsb | crsc);

assign CPM_c405CpuClkEn_CClk = ~(C405_cpmCoreSleepReq & (crsd & crsd_r));
assign CPM_c405JtagClkEn_CClk = 1'b1;

//generate clock signal
initial begin
  SystemClock = 1;
  forever begin
    #(simulation_cycle/2)
      SystemClock = ~SystemClock;
  end
end
//added by clp----------------------------------------------------------------------

//generateJTG signals
//refer avs.isocm.10.1.1
assign #(simulation_cycle/10) JTG_c405TCK      = SystemClock;
assign #(simulation_cycle/5)  JTG_c405TRST_NEG = ~RST_c405ResetChip;

//generate reset signal
initial
begin
repeat(2)@(posedge  SystemClock);
  RST_c405ResetChip   = 1'b0;
  RST_c405ResetCore   = 1'b0;
  RST_c405ResetSystem = 1'b0;
repeat(1)@(posedge  SystemClock);
  RST_c405ResetChip   = 1'b1;
  RST_c405ResetCore   = 1'b1;
  RST_c405ResetSystem = 1'b1;
repeat(11)@(posedge  SystemClock);
  RST_c405ResetChip   = 1'b0;
  RST_c405ResetCore   = 1'b0;
  RST_c405ResetSystem = 1'b0;
end
//initialize instruction memory and data memory
initial
begin
  for(i=0;i<2048;i=i+1)
  begin
    isocm_model.ins_mem.mem[i]  = 128'd0;
    dsocm_model.data_mem.mem[i] = 128'd0;
  end
  for(i=0;i<4096;i=i+1)
  begin
    vector_dram_shell.mem[i]    = 128'd0;
  end
  $readmemh("./in_pattern/ins_mem.txt",isocm_model.ins_mem.mem);
  $readmemh("./in_pattern/data_mem.txt",dsocm_model.data_mem.mem);
  $readmemh("./in_pattern/vector_data_mem.txt",vector_dram_shell.mem);
end
//write data_mem to file "./out_result/result.txt"
initial
begin
  desc1 = $fopen ("./out_result/result_vector_data_mem.txt");
  # `DONE_TIME;
  for(i=0;i<4096;i=i+1)
    $fdisplay(desc1,"%h",vector_dram_shell.mem[i]);
end
//dump fsdb wave file
initial
begin
  $fsdbDumpfile("wave.fsdb");
  $fsdbDumpvars;
end
//During Gate Level Simulation the scan chain is used to place all flops
//into a known state
initial
begin
  TEST_c405ScanEnable = 1'b0;
end

always @ (posedge SystemClock )
begin
  TEST_c405ScanEnable_r  <= TEST_c405ScanEnable;
  TEST_c405ScanEnable_r2 <= TEST_c405ScanEnable_r;
  TEST_c405ScanEnable_r3 <= TEST_c405ScanEnable_r2;
  TEST_c405ScanEnable_r4 <= TEST_c405ScanEnable_r3;
end

// Processors
//
PPC405F5V1_soft dut(
             //Interface with APU
             .C405_apuDcdFull                   (C405_apuDcdFull           ),
             .C405_apuDcdHold                   (C405_apuDcdHold           ),
             .C405_apuDcdInstruction            (C405_apuDcdInstruction    ),
             .C405_apuExeFlush                  (C405_apuExeFlush          ),
             .C405_apuExeHold                   (C405_apuExeHold           ),
             .C405_apuExeLoadDBus               (C405_apuExeLoadDBus       ),
             .C405_apuExeLoadDValid             (C405_apuExeLoadDValid     ),
             .C405_apuExeRaData                 (C405_apuExeRaData         ),
             .C405_apuExeRbData                 (C405_apuExeRbData         ),
             .C405_apuExeWdCnt                  (C405_apuExeWdCnt          ),
             .C405_apuMsrFE0                    (C405_apuMsrFE0            ),
             .C405_apuMsrFE1                    (C405_apuMsrFE1            ),
             .C405_apuWbByteEn                  (C405_apuWbByteEn          ),
             .C405_apuWbEndian                  (C405_apuWbEndian          ),
             .C405_apuWbFlush                   (C405_apuWbFlush           ),
             .C405_apuWbHold                    (C405_apuWbHold            ),
             .C405_apuXerCA                     (C405_apuXerCA             ),

             .C405_cpmCoreSleepReq              (C405_cpmCoreSleepReq      ),
             .C405_cpmMsrCE                     (C405_cpmMsrCE             ),
             .C405_cpmMsrEE                     (C405_cpmMsrEE             ),
             .C405_cpmTimerIRQ                  (C405_cpmTimerIRQ          ),
             .C405_cpmTimerResetReq             (C405_cpmTimerResetReq     ),
             .C405_dbgLoadDataOnApuDBus         (                          ),
             .C405_dbgMsrWE                     (                          ),
             .C405_dbgStopAck                   (                          ),
             .C405_dbgWbComplete                (                          ),
             .C405_dbgWbFull                    (                          ),
             .C405_dbgWbIar                     (                          ),
             .C405_dcrABus                      (                          ),
             .C405_dcrDBusOut                   (                          ),
             .C405_dcrRead                      (                          ),
             .C405_dcrWrite                     (                          ),

             .C405_jtgCaptureDR                 (                          ),
             .C405_jtgExtest                    (                          ),
             .C405_jtgPgmOut                    (                          ),
             .C405_jtgShiftDR                   (                          ),
             .C405_jtgTDO                       (                          ),
             .C405_jtgTDOEn                     (                          ),
             .C405_jtgUpdateDR                  (                          ),

             .C405_testDiagAbistDone            (                          ),
             .C405_testScanOut                  (C405_testScanOut          ),//required,??
             .C405_plbDcuABus                   (                          ),
             .C405_plbDcuAbort                  (                          ),
             .C405_plbDcuBE                     (                          ),
             .C405_plbDcuCacheable              (                          ),
             .C405_plbDcuGuarded                (                          ),
             .C405_plbDcuPriority               (                          ),
             .C405_plbDcuRNW                    (                          ),
             .C405_plbDcuRequest                (                          ),
             .C405_plbDcuSize2                  (                          ),
             .C405_plbDcuU0Attr                 (                          ),
             .C405_plbDcuWrDBus                 (                          ),
             .C405_plbDcuWriteThru              (                          ),
             .C405_plbIcuABus                   (                          ),
             .C405_plbIcuAbort                  (                          ),
             .C405_plbIcuCacheable              (                          ),
             .C405_plbIcuPriority               (                          ),
             .C405_plbIcuRequest                (                          ),
             .C405_plbIcuSize                   (                          ),
             .C405_plbIcuU0Attr                 (                          ),

             .C405_trcCycle                     (                          ),
             .C405_trcEvenExecutionStatus       (                          ),
             .C405_trcOddExecutionStatus        (                          ),
             .C405_trcTraceStatus               (                          ),
             .C405_trcTriggerEventOut           (C405_trcTriggerEventOut   ),//wrapp to Trigger Eventin,done
             .C405_trcTriggerEventType          (                          ),
             .C405_xxxMachineCheck              (                          ),
             .C405_bistPepsPF                   (                          ), //??  not defined in databook
             .C405_bistdcuBistDebugSo           (                          ),
             .C405_bistdcuBistModeRegOut        (                          ),
             .C405_bistdcuBistModeRegSo         (                          ),
             .C405_bisticuBistDebugSo           (                          ),
             .C405_bisticuBistModeRegOut        (                          ),
             .C405_bisticuBistModeRegSo         (                          ),

             .C405_rstChipResetReq              (C405_rstChipResetReq      ),//required
             .C405_rstCoreResetReq              (C405_rstCoreResetReq      ),//required
             .C405_rstSystemResetReq            (C405_rstSystemResetReq    ),//required
             //Interface with isocm and dsocm
             .C405_dsocmABus                    (C405_dsocmABus            ),
             .C405_dsocmAbortOp                 (C405_dsocmAbortOp         ),
             .C405_dsocmAbortReq                (C405_dsocmAbortReq        ),
             .C405_dsocmByteEn                  (C405_dsocmByteEn          ),
             .C405_dsocmCacheable               (C405_dsocmCacheable       ),
             .C405_dsocmGuarded                 (C405_dsocmGuarded         ),
             .C405_dsocmLoadReq                 (C405_dsocmLoadReq         ),
             .C405_dsocmStoreReq                (C405_dsocmStoreReq        ),
             .C405_dsocmStringMultiple          (C405_dsocmStringMultiple  ),
             .C405_dsocmU0Attr                  (C405_dsocmU0Attr          ),
             .C405_dsocmWait                    (C405_dsocmWait            ),
             .C405_dsocmWrDBus                  (C405_dsocmWrDBus          ),
             .C405_dsocmXlateValid              (C405_dsocmXlateValid      ),
             .C405_isocmABus                    (C405_isocmABus            ),
             .C405_isocmAbort                   (C405_isocmAbort           ),
             .C405_isocmCacheable               (C405_isocmCacheable       ),
             .C405_isocmContextSync             (C405_isocmContextSync     ),
             .C405_isocmIcuReady                (C405_isocmIcuReady        ),
             .C405_isocmReqPending              (C405_isocmReqPending      ),
             .C405_isocmU0Attr                  (C405_isocmU0Attr          ),
             .C405_isocmXlateValid              (C405_isocmXlateValid      ),

             .RST_c405ResetChip                 (RST_c405ResetCore         ),//required,drive by p405s_top_vera_shell,done
             .RST_c405ResetCore                 (RST_c405ResetCore         ),//required,drive by p405s_top_vera_shell,done
             .RST_c405ResetSystem               (RST_c405ResetCore         ),//required,drive by p405s_top_vera_shell,done

             .ISOCM_c405Hold                    (ISOCM_c405Hold            ),
             .ISOCM_c405RdDBus                  (ISOCM_c405RdDBus          ),
             .ISOCM_c405RdDValid                (ISOCM_c405RdDValid        ),
             .DSOCM_c405Complete                (DSOCM_c405Complete        ),
             .DSOCM_c405DisOperandFwd           (DSOCM_c405DisOperandFwd   ),
             .DSOCM_c405Hold                    (DSOCM_c405Hold            ),
             .DSOCM_c405RdDBus                  (DSOCM_c405RdDBus          ),

             .APU_c405DcdApuOp                  (APU_c405DcdApuOp          ),
             .APU_c405DcdCREn                   (APU_c405DcdCREn           ),
             .APU_c405DcdForceAlgn              (APU_c405DcdForceAlgn      ),
             .APU_c405DcdForceBESteering        (APU_c405DcdForceBESteering),
             .APU_c405DcdFpuOp                  (APU_c405DcdFpuOp          ),
             .APU_c405DcdGprWrite               (APU_c405DcdGprWrite       ),
             .APU_c405DcdLdStByte               (APU_c405DcdLdStByte       ),
             .APU_c405DcdLdStDw                 (APU_c405DcdLdStDw         ),
             .APU_c405DcdLdStHw                 (APU_c405DcdLdStHw         ),
             .APU_c405DcdLdStQw                 (APU_c405DcdLdStQw         ),
             .APU_c405DcdLdStWd                 (APU_c405DcdLdStWd         ),
             .APU_c405DcdLoad                   (APU_c405DcdLoad           ),
             .APU_c405DcdPrivOp                 (APU_c405DcdPrivOp         ),
             .APU_c405DcdRaEn                   (APU_c405DcdRaEn           ),
             .APU_c405DcdRbEn                   (APU_c405DcdRbEn           ),
             .APU_c405DcdStore                  (APU_c405DcdStore          ),
             .APU_c405DcdTrapBE                 (APU_c405DcdTrapBE         ),
             .APU_c405DcdTrapLE                 (APU_c405DcdTrapLE         ),
             .APU_c405DcdUpdate                 (APU_c405DcdUpdate         ),
             .APU_c405DcdValidOp                (APU_c405DcdValidOp        ),
             .APU_c405DcdXerCAEn                (APU_c405DcdXerCAEn        ),
             .APU_c405DcdXerOVEn                (APU_c405DcdXerOVEn        ),
             .APU_c405Exception                 (APU_c405Exception         ),
             .APU_c405ExeBlockingMCO            (APU_c405ExeBlockingMCO    ),
             .APU_c405ExeBusy                   (APU_c405ExeBusy           ),
             .APU_c405ExeCR                     (APU_c405ExeCR             ),
             .APU_c405ExeCRField                (APU_c405ExeCRField        ),
             .APU_c405ExeLdDepend               (APU_c405ExeLdDepend       ),
             .APU_c405ExeNonBlockingMCO         (APU_c405ExeNonBlockingMCO ),
             .APU_c405ExeResult                 (APU_c405ExeResult         ),
             .APU_c405ExeXerCA                  (APU_c405ExeXerCA          ),
             .APU_c405ExeXerOV                  (APU_c405ExeXerOV          ),
             .APU_c405FpuException              (APU_c405FpuException      ),
             .APU_c405LwbLdDepend               (APU_c405LwbLdDepend       ),
             .APU_c405SleepReq                  (APU_c405SleepReq          ),//only set this signal high
             .APU_c405WbLdDepend                (APU_c405WbLdDepend        ),

             .CPM_c405Clock                     (CPM_c405Clock             ),//required if unused,done
             .CPM_c405CpuClkEn_CClk             (1'b1                         ),//required,done
             .CPM_c405CoreClkInactive           (1'b0                         ),
             .CPM_c405JtagClkEn_CClk            (CPM_c405JtagClkEn_CClk    ),  //required,done.
             .TEST_c405BistCE1Mode              (1'b1                         ),//required,done
                                                                             //Enables the internal generation of clocks for most of the core logic.
             .CPM_c405PlbSampleCycle            (1'b1                         ),
             .CPM_c405TimerClkEn_CClk           (1'b1                         ),//required,
             .CPM_c405TimerTick                 (1'b1                         ),
             .CPM_c405PlbSyncClock              (1'b1                         ),
             .CPM_c405SyncBypass                (1'b1                         ),
             .CPM_c405PlbSampleCycleAlt         (1'b0                         ),

             .DBG_c405DebugHalt                 (1'b0                      ),
             .DBG_c405ExtBusHoldAck             (1'b0                         ),
             .DBG_c405UncondDebugEvent          (1'b0                         ),

             .DCR_c405Ack                       (1'b0                         ),
             .DCR_c405DBusIn                    (32'h0                     ),

             .EIC_c405CritInputIRQ              (1'b0                         ),
             .EIC_c405ExtInputIRQ               (1'b0                         ),

             .JTG_c405BndScanTDO                (1'b0                         ),
             .JTG_c405TCK                       (JTG_c405TCK               ),//??see IEEE 1149.1,??
             .JTG_c405TDI                       (1'b0                         ),//#
             .JTG_c405TMS                       (1'b0                         ),//#
             .JTG_c405TRST_NEG                  (JTG_c405TRST_NEG          ),//required,??

             .PLB_c405DcuAddrAck                (1'b0                         ),
             .PLB_c405DcuBusy                   (1'b0                         ),
             .PLB_c405DcuErr                    (1'b0                         ),
             .PLB_c405DcuRdDAck                 (1'b0                         ),
             .PLB_c405DcuRdDBus                 (64'h0                     ),
             .PLB_c405DcuRdWdAddr               (3'b0                         ),
             .PLB_c405DcuSSize1                 (1'b0                         ),
             .PLB_c405DcuWrDAck                 (1'b0                         ),
             .PLB_c405IcuAddrAck                (1'b0                         ),
             .PLB_c405IcuBusy                   (1'b0                         ),
             .PLB_c405IcuErr                    (1'b0                         ),
             .PLB_c405IcuRdDAck                 (1'b0                         ),
             .PLB_c405IcuRdDBus                 (64'h0                     ),
             .PLB_c405IcuRdWdAddr               (3'b0                         ),
             .PLB_c405IcuSSize1                 (1'b0                         ),

             .TIE_c405ApuDivEn                  (1'b0                         ),
             .TIE_c405ApuPresent                (1'b1                      ),//changed by clp
             .TIE_c405DeterministicMult         (TIE_c405DeterministicMult ),//required,done
             .TIE_c405DisOperandFwd             (TIE_c405DisOperandFwd     ),//required,done
             .TIE_c405MmuEn                     (TIE_c405MmuEn             ),//required,done
             .TIE_c405PVR                       (TIE_c405PVR               ),//required,done
             .TIE_c405ClockEnable               (1'b1                         ),
             .TIE_c405DutyEnable                (1'b1                         ),
             .TRC_c405TraceDisable              (1'b0                         ),
             .TRC_c405TriggerEventIn            (1'b0                         ),//wrap to Trigger Event Out,done

             .TEST_c405CE0EVS                   (1'b0                         ),
             .TEST_c405BistCE0StClk             (1'b0                         ),
             .TEST_c405BistCE1Enable            (1'b1                         ),//required,done
             .TEST_c405ScanEnable               (1'b0                         ),
             .TEST_c405TestMode                 (1'b0                         ),
             .TEST_c405BistCClk                 (1'b1                         ),
             .TEST_c405ScanIn                   (8'b0                         ),
             .TEST_c405CntlPoint                (1'b0                         ),
             .TEST_c405TestM1                   (1'b0                         ),
             .TEST_c405TestM3                   (1'b0                         ),

             .BIST_c405dcuBistDebugSi           (4'b0                         ),
             .BIST_c405dcuBistDebugEn           (4'b0                         ),
             .BIST_c405dcuBistModeRegIn         (19'b0                         ),
             .BIST_c405dcuBistParallelDr        (1'b0                         ),
             .BIST_c405dcuBistModeRegSi         (1'b0                         ),
             .BIST_c405dcuBistShiftDr           (1'b0                         ),
             .BIST_c405dcuBistMbRun             (1'b0                         ),
             .BIST_c405icuBistDebugSi           (4'b0                         ),
             .BIST_c405icuBistDebugEn           (4'b0                         ),
             .BIST_c405icuBistModeRegIn         (19'b0                         ),
             .BIST_c405icuBistParallelDr        (1'b0                         ),
             .BIST_c405icuBistModeRegSi         (1'b0                         ),
             .BIST_c405icuBistShiftDr           (1'b0                         ),
             .BIST_c405icuBistMbRun             (1'b0                         )
             );

p405s_isocm_shell isocm_model(
             .SystemClock                       (SystemClock               ),
             .isocm_if_C405_isocmReqPending     (C405_isocmReqPending      ),
             .isocm_if_C405_isocmIcuReady       (C405_isocmIcuReady        ),
             .isocm_if_C405_isocmABus           (C405_isocmABus            ),
             .isocm_if_C405_isocmXlateValid     (C405_isocmXlateValid      ),
             .isocm_if_C405_isocmCacheable      (C405_isocmCacheable       ),
             .isocm_if_C405_isocmU0Attr         (C405_isocmU0Attr          ),
             .isocm_if_C405_isocmAbort          (C405_isocmAbort           ),
             .isocm_if_C405_isocmContextSync    (C405_isocmContextSync     ),
             .isocm_if_ISOCM_c405Hold           (ISOCM_c405Hold            ),
             .isocm_if_ISOCM_c405RdDValid       (ISOCM_c405RdDValid        ),
             .isocm_if_ISOCM_c405RdDBus         (ISOCM_c405RdDBus          ),
             .isocm_if_reset_n                  (RST_c405ResetChip         )
             );

p405s_dsocm_shell dsocm_model(
             .SystemClock                       (SystemClock               ),
             .dsocm_if_C405_dsocmLoadReq        (C405_dsocmLoadReq         ),
             .dsocm_if_C405_dsocmStoreReq       (C405_dsocmStoreReq        ),
             .dsocm_if_C405_dsocmXlateValid     (C405_dsocmXlateValid      ),
             .dsocm_if_C405_dsocmABus           (C405_dsocmABus            ),
             .dsocm_if_C405_dsocmCacheable      (C405_dsocmCacheable       ),
             .dsocm_if_C405_dsocmGuarded        (C405_dsocmGuarded         ),
             .dsocm_if_C405_dsocmU0Attr         (C405_dsocmU0Attr          ),
             .dsocm_if_C405_dsocmByteEn         (C405_dsocmByteEn          ),
             .dsocm_if_C405_dsocmWrDBus         (C405_dsocmWrDBus          ),
             .dsocm_if_C405_dsocmAbortOp        (C405_dsocmAbortOp         ),
             .dsocm_if_C405_dsocmAbortReq       (C405_dsocmAbortReq        ),
             .dsocm_if_C405_dsocmWait           (C405_dsocmWait            ),
             .dsocm_if_C405_dsocmStringMultiple (C405_dsocmStringMultiple  ),
             .dsocm_if_DSOCM_c405Complete       (DSOCM_c405Complete        ),
             .dsocm_if_DSOCM_c405Hold           (DSOCM_c405Hold            ),
             .dsocm_if_DSOCM_c405DisOperandFwd  (DSOCM_c405DisOperandFwd   ),
             .dsocm_if_DSOCM_c405RdDBus         (DSOCM_c405RdDBus          ),
             .dsocm_if_reset_n                  (RST_c405ResetChip         )
             );

//Instance APU controller
p405s_apu_shell apu_controller(
             .clk                               (SystemClock               ),
             .rst_b                             (~RST_c405ResetCore        ),
             //Signals from Core ppc405
             .C405_apuDcdFull                   (C405_apuDcdFull           ),
             .C405_apuDcdHold                   (C405_apuDcdHold           ),
             .C405_apuDcdInstruction            (C405_apuDcdInstruction    ),
             .C405_apuExeFlush                  (C405_apuExeFlush          ),
             .C405_apuExeHold                   (C405_apuExeHold           ),
             .C405_apuExeLoadDBus               (C405_apuExeLoadDBus       ),
             .C405_apuExeLoadDValid             (C405_apuExeLoadDValid     ),
             .C405_apuExeRaData                 (C405_apuExeRaData         ),
             .C405_apuExeRbData                 (C405_apuExeRbData         ),
             .C405_apuExeWdCnt                  (C405_apuExeWdCnt          ),
             .C405_apuMsrFE0                    (C405_apuMsrFE0            ),
             .C405_apuMsrFE1                    (C405_apuMsrFE1            ),
             .C405_apuWbByteEn                  (C405_apuWbByteEn          ),
             .C405_apuWbEndian                  (C405_apuWbEndian          ),
             .C405_apuWbFlush                   (C405_apuWbFlush           ),
             .C405_apuWbHold                    (C405_apuWbHold            ),
             .C405_apuXerCA                     (C405_apuXerCA             ),
             .AltiVec_APU_ValidOp               (AltiVec_APU_ValidOp       ),
             .AltiVec_APU_ExeBusy               (AltiVec_APU_ExeBusy       ),
             .AltiVec_APU_RaEn                  (AltiVec_APU_RaEn          ),
             .AltiVec_APU_RbEn                  (AltiVec_APU_RbEn          ),
             .AltiVec_APU_CR6En                 (AltiVec_APU_CR6En         ),
             .AltiVec_APU_CRData                (AltiVec_APU_CRData        ),
             //Interface From APU controller
             .APU_c405DcdApuOp                  (APU_c405DcdApuOp          ),
             .APU_c405DcdCREn                   (APU_c405DcdCREn           ),
             .APU_c405DcdForceAlgn              (APU_c405DcdForceAlgn      ),
             .APU_c405DcdForceBESteering        (APU_c405DcdForceBESteering),
             .APU_c405DcdFpuOp                  (APU_c405DcdFpuOp          ),
             .APU_c405DcdGprWrite               (APU_c405DcdGprWrite       ),
             .APU_c405DcdLdStByte               (APU_c405DcdLdStByte       ),
             .APU_c405DcdLdStDw                 (APU_c405DcdLdStDw         ),
             .APU_c405DcdLdStHw                 (APU_c405DcdLdStHw         ),
             .APU_c405DcdLdStQw                 (APU_c405DcdLdStQw         ),
             .APU_c405DcdLdStWd                 (APU_c405DcdLdStWd         ),
             .APU_c405DcdLoad                   (APU_c405DcdLoad           ),
             .APU_c405DcdPrivOp                 (APU_c405DcdPrivOp         ),
             .APU_c405DcdRaEn                   (APU_c405DcdRaEn           ),
             .APU_c405DcdRbEn                   (APU_c405DcdRbEn           ),
             .APU_c405DcdStore                  (APU_c405DcdStore          ),
             .APU_c405DcdTrapBE                 (APU_c405DcdTrapBE         ),
             .APU_c405DcdTrapLE                 (APU_c405DcdTrapLE         ),
             .APU_c405DcdUpdate                 (APU_c405DcdUpdate         ),
             .APU_c405DcdValidOp                (APU_c405DcdValidOp        ),
             .APU_c405DcdXerCAEn                (APU_c405DcdXerCAEn        ),
             .APU_c405DcdXerOVEn                (APU_c405DcdXerOVEn        ),
             .APU_c405Exception                 (APU_c405Exception         ),
             .APU_c405ExeBlockingMCO            (APU_c405ExeBlockingMCO    ),
             .APU_c405ExeBusy                   (APU_c405ExeBusy           ),
             .APU_c405ExeCR                     (APU_c405ExeCR             ),
             .APU_c405ExeCRField                (APU_c405ExeCRField        ),
             .APU_c405ExeLdDepend               (APU_c405ExeLdDepend       ),
             .APU_c405ExeNonBlockingMCO         (APU_c405ExeNonBlockingMCO ),
             .APU_c405ExeResult                 (APU_c405ExeResult         ),
             .APU_c405ExeXerCA                  (APU_c405ExeXerCA          ),
             .APU_c405ExeXerOV                  (APU_c405ExeXerOV          ),
             .APU_c405FpuException              (APU_c405FpuException      ),
             .APU_c405LwbLdDepend               (APU_c405LwbLdDepend       ),
             .APU_c405SleepReq                  (APU_c405SleepReq          ),
             .APU_c405WbLdDepend                (APU_c405WbLdDepend        ),
             // .APU_AltiVec_cs                    (APU_AltiVec_cs            ),
             .APU_AltiVec_Ins                   (APU_AltiVec_Ins           ),
             .APU_AltiVec_RaData                (APU_AltiVec_RaData        ),
             .APU_AltiVec_RbData                (APU_AltiVec_RbData        ),
             .APU_AltiVec_DcdHold               (APU_AltiVec_DcdHold       )
             );

//Instance AltiVec
AltiVecUnit AltiVecUnit(
             .clk                               (SystemClock               ),
             .rst_n                             (!RST_c405ResetCore        ),
             // .in_AltiVec_cs                     (APU_AltiVec_cs            ),
             .in_Instruction                    (APU_AltiVec_Ins           ),
             .in_ReadDataAfromGPR               (APU_AltiVec_RaData        ),
             .in_ReadDataBfromGPR               (APU_AltiVec_RbData        ),
             .APU_AltiVec_DcdHold               (APU_AltiVec_DcdHold       ),
             .Mem_LSData                        (Mem_AltiVecData           ),

             .Dcd_APUCR6En                      (AltiVec_APU_CR6En         ),
             .Dcd_APUValidOp                    (AltiVec_APU_ValidOp       ),
             .Dcd_APUExeBusy                    (AltiVec_APU_ExeBusy       ),
             .Dcd_APURaEn                       (AltiVec_APU_RaEn          ),
             .Dcd_APURbEn                       (AltiVec_APU_RbEn          ),
             .VALU_CRData                       (AltiVec_APU_CRData        ),
             .LS_Mem_cs                         (AltiVec_Mem_cs            ),
             .LS_Mem_RW                         (AltiVec_Mem_RW            ),
             .LS_MemAddr                        (AltiVec_MemAddr           ),
             .LS_MemData                        (AltiVec_MemData           ),
             .LS_Mem_WriteEn                    (Altivec_Mem_WriteEn       )
             );

//Instance vector_dram_shell
vector_dram_shell vector_dram_shell(
             .clk                               (SystemClock               ),
             .rst_b                             (~RST_c405ResetCore        ),
             .cs                                (AltiVec_Mem_cs            ),
             .rw                                (AltiVec_Mem_RW            ),
             .addr                              (AltiVec_MemAddr           ),
             .data_in                           (AltiVec_MemData           ),
             .data_out                          (Mem_AltiVecData           ),
             .write_en                          (Altivec_Mem_WriteEn       )
             );

endmodule
