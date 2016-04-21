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

module p405s_jtg_top( JTG_TDO, JTG_captureDR, JTG_dbdrPulse, JTG_dbgWaitEn, JTG_extest,
     JTG_freezeTimers, JTG_iCacheWr_NEG, JTG_inst, JTG_instBuf, JTG_pgmOut,
     JTG_resetChipReq, JTG_resetCoreReq, JTG_resetDBSR, JTG_resetSystemReq, 
     JTG_shiftDR, JTG_sprDataBus, JTG_step, JTG_stepUPD, JTG_stopReq, JTG_stuff,
     JTG_stuffUPD, JTG_tDOEnable, JTG_uncondEvent, JTG_updateDR, CB, CPM_coreClkOff,
     DBG_DE, DBG_UDE, DBG_resetChip, DBG_resetCore, DBG_resetSystem, EXE_sprDataBus,
     ICU_sleepReq, IFB_msrWE, IFB_rstStepPend, IFB_rstStuffPend, IFB_stopAck, JTGEX_BndScanTDO,
     JTGEX_TCK, JTGEX_TDI, JTGEX_TMS, JTGEX_TRST_NEG, PCL_exeMfspr,
     PCL_exeMtspr, PCL_exeSprHold, PCL_jtgSprDcd, PLB_jtgHoldAck, TIM_wdChipRst, TIM_wdCoreRst,
     TIM_wdSysRst, VCT_msrDWE, VCT_srr1DWE, VCT_srr3DWE, VCT_stuffStepSup, VCT_sxr,
     XXX_coreReset, XXX_jtgHalt, XXX_systemReset, jtgDiagBus1, jtgDiagBus2,
     jtgDiagBus3);
output  JTG_TDO, JTG_captureDR, JTG_dbdrPulse, JTG_dbgWaitEn, JTG_extest, JTG_freezeTimers,
     JTG_iCacheWr_NEG, JTG_pgmOut, JTG_resetChipReq, JTG_resetCoreReq, JTG_resetDBSR,
     JTG_resetSystemReq, JTG_shiftDR, JTG_step, JTG_stepUPD, JTG_stopReq,
     JTG_stuff, JTG_stuffUPD, JTG_tDOEnable, JTG_uncondEvent, JTG_updateDR;


input  CPM_coreClkOff, DBG_DE, DBG_UDE, DBG_resetChip, DBG_resetCore, DBG_resetSystem,
     ICU_sleepReq, IFB_msrWE, IFB_rstStepPend, IFB_rstStuffPend, IFB_stopAck, JTGEX_BndScanTDO,
     JTGEX_TCK, JTGEX_TDI, JTGEX_TMS, JTGEX_TRST_NEG, PCL_exeMfspr,
     PCL_exeMtspr, PCL_exeSprHold, PCL_jtgSprDcd, PLB_jtgHoldAck, TIM_wdChipRst, TIM_wdCoreRst,
     TIM_wdSysRst, VCT_msrDWE, VCT_srr1DWE, VCT_srr3DWE, VCT_stuffStepSup, XXX_coreReset,
     XXX_jtgHalt, XXX_systemReset ;

output [0:31]  JTG_instBuf;
output [0:31]  JTG_sprDataBus;
output [0:31]  JTG_inst;


input [0:31]  EXE_sprDataBus;
input [0:31]  jtgDiagBus1;
input [0:31]  jtgDiagBus3;
input [0:31]  jtgDiagBus2;
input CB;
input [0:11]  VCT_sxr;

// Buses in the design

wire  [0:7]  NextState;
wire  [0:3]  InstRegIn;
wire  [0:3]  InstShiftRegIn;
wire  [0:1]  diagMuxSel;
wire  [0:31]  MultiUseRegIn;
wire  [0:7]  JDCRMuxIn;
wire  [2:8]  SyncOut;
wire resetSystemReq;
wire resetChipReq;
wire resetCoreReq;
wire jtgShiftDR;
wire pgmOut;
wire tdoEnable;
wire jtgUpdateDR;
wire capDataReg;
wire extest;
wire iCacheWrUninverted;
wire iCacheWrInverted;
wire NextCacheWr;
wire ICU_busy;
wire JDCRMuxSel;
wire JDCRE1;
wire JDCRstopProc;
wire JDCRblockFold;
wire JDCRstepPulse;
wire JDCRreset0; 
wire JDCRreset1;
wire JDCRinstRegDiagDcdEn;
wire InstBufferE2;
wire [0:31] MultiUseRegIn_D1;
wire overrun;
wire MultiUseRegInMuxSel;
wire SPRorDataMuxSel;
wire [0:31] regJTG_sync_D;
wire UpdateDR;
wire CaptureDRSync0;
wire NextDBDRpulse;
wire NextStep;
wire NextOverrun;
wire coreReset;
wire sysReset;
wire jtgHalt;
wire NextStuff;

wire BypassRegE1;
wire BypassRegIn;
wire CntlRegAsyncReset;
wire DataRegE1;
wire DataRegE2;
wire DataRegMuxSel;
wire InstRegAsyncSet;
wire InstShiftRegE1;
wire InstRegL1E1;
wire InstRegL2E1;
wire MultiUseRegE1;
wire ShiftDR;
wire ShiftIR;
wire TDOIn;

reg [0:7] CurrentStateL2;
reg [0:7] regJTG_cntlL2_L1;
reg [0:15] dp_Reg_DataIn2;
reg [0:16] dp_Reg_DataIn;
wire [0:31] JTG_inst;
reg [0:31] regJTG_sync_L2;
reg [0:31] muMuxIn;
reg [0:10] regJTG_JDCRmuxReg_muxout;
reg [0:10] regJTG_JDCRmuxReg_L2;
reg regJTG_iCacheWr_L2;
reg [0:31] MultiUse;
reg DataValidBit;
reg InstRegTDO;
reg [0:2] InstShiftRegOut;
reg [0:31] DBDROut_muxout;
reg [0:31] DBDROut;
reg BypassTDO;
reg [0:2] regJTG_cntlL1_L1;
reg ShiftIRL1;
reg ShiftDRL1;
reg tdo;
reg [0:3] regJTG_InstL2_L1;
reg [0:3] InstRegOutL2;
reg [0:3] InstRegOutL1;
reg [0:3] regJTG_InstL1_L1;

// declare internal signals to isolate outputs from internal inputs.
wire JTG_dbgWaitEn_i;
wire JTG_freezeTimers_i;
wire JTG_resetDBSR_i;
wire JTG_step_i;
wire JTG_stuff_i;
wire JTG_uncondEvent_i;
reg [0:31] JTG_inst_i;

assign JTG_dbgWaitEn = JTG_dbgWaitEn_i;
assign JTG_freezeTimers = JTG_freezeTimers_i;
assign JTG_resetDBSR = JTG_resetDBSR_i;
assign JTG_step = JTG_step_i;
assign JTG_stuff = JTG_stuff_i;
assign JTG_uncondEvent = JTG_uncondEvent_i;
assign JTG_inst[0:31] = JTG_inst_i[0:31];
assign UpdateDR = CurrentStateL2[0];
assign ShiftIR = CurrentStateL2[2];
assign ShiftDR = CurrentStateL2[3];

//Removed the module 'dp_logJTG_resetSystemReq'
assign JTG_resetSystemReq = resetSystemReq;
//Removed the module 'dp_logJTG_resetChipReq'
assign JTG_resetChipReq = resetChipReq;
//Removed the module 'dp_logJTG_resetCoreReq'
assign JTG_resetCoreReq = resetCoreReq;

//Removed the module 'dp_logJTG_inst'
assign JTG_instBuf[0:31] = JTG_inst_i[0:31];

//Removed the module 'dp_logJTG_shiftDR'
assign JTG_shiftDR = jtgShiftDR;
//Removed the module 'dp_logJTG_pgmOut'
assign JTG_pgmOut = pgmOut;
//Removed the module 'dp_logJTG_tdoEnable'
assign JTG_tDOEnable = tdoEnable;
//dp_logJTG_updateDR logJTG_updateDR(jtgUpdateDR, JTG_updateDR);
//Removed the module 'dp_logJTG_updateDR'
assign JTG_updateDR = jtgUpdateDR;

//Removed the module 'dp_logJTG_captureDR'
assign JTG_captureDR = capDataReg;
//Removed the module 'dp_logJTG_tdo'
assign JTG_TDO = tdo;
//Removed the module 'dp_logJTG_extest'
assign JTG_extest = extest;
//Removed the module 'dp_logJTG_iCacheWr2'
assign JTG_iCacheWr_NEG = ~iCacheWrUninverted;
//Removed the module 'dp_logJTG_iCacheWr1'
assign iCacheWrUninverted = ~iCacheWrInverted;

//Removed the module 'dp_regJTG_iCacheWr'
   assign iCacheWrInverted = ~regJTG_iCacheWr_L2;
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
     regJTG_iCacheWr_L2 <= NextCacheWr;          
   end  

   // Replacing instantiation: GTECH_NOT icuSleepReqNeg
   assign ICU_busy = ~(ICU_sleepReq);

//Removed the module 'dp_regJTG_DiagMux'
always @(diagMuxSel or DBDROut or jtgDiagBus1 or jtgDiagBus2 or jtgDiagBus3) 
    begin                                           
    case(diagMuxSel[0:1])                     
     2'b00: muMuxIn[0:31] = DBDROut[0:31];    
     2'b01: muMuxIn[0:31] = jtgDiagBus1[0:31];    
     2'b10: muMuxIn[0:31] = jtgDiagBus2[0:31];    
     2'b11: muMuxIn[0:31] = jtgDiagBus3[0:31];    
      default: muMuxIn[0:31] = 32'bx;   
    endcase                                    
   end   

//Removed the module 'dp_regJTG_JDCRmuxReg'
 always @(JDCRMuxIn or MultiUse or JDCRMuxSel)        
    begin                                       
    casez(JDCRMuxSel)                    
     1'b0: regJTG_JDCRmuxReg_muxout = {JDCRMuxIn[0:1], 1'b0,  JDCRMuxIn[2:3], 1'b0, JDCRMuxIn[4:5], 1'b0, JDCRMuxIn[6:7]};   
     1'b1: regJTG_JDCRmuxReg_muxout = MultiUse[0:10];   
      default: regJTG_JDCRmuxReg_muxout = 11'bx;  
    endcase                             
   end    
  always @(posedge CB)      
    begin                                       
    casez(JDCRE1)                    
     1'b0: regJTG_JDCRmuxReg_L2 <= regJTG_JDCRmuxReg_L2;                
     1'b1: regJTG_JDCRmuxReg_L2 <= regJTG_JDCRmuxReg_muxout;       
      default: regJTG_JDCRmuxReg_L2 <= 11'bx;  
    endcase                             
   end   
   assign {JDCRstopProc, JDCRblockFold, JDCRstepPulse, JDCRreset0, JDCRreset1, JTG_uncondEvent_i, 
           JTG_freezeTimers_i, pgmOut, JTG_resetDBSR_i, JTG_dbgWaitEn_i, JDCRinstRegDiagDcdEn } = regJTG_JDCRmuxReg_L2;


//Removed the module 'dp_regJTG_InstBuffer'
always @(posedge CB)      
    begin                                       
    casez(InstBufferE2)                    
     1'b0: JTG_inst_i[0:31] <= JTG_inst_i[0:31];                
     1'b1: JTG_inst_i[0:31] <= MultiUse[0:31];            
      default: JTG_inst_i[0:31] <= 32'bx;  
    endcase                             
   end   

//Removed the module 'dp_muxJTG_MultiUseRegIn'
assign MultiUseRegIn_D1 = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, DBG_UDE, DBG_DE, VCT_srr3DWE, 
           VCT_srr1DWE, VCT_msrDWE, ICU_busy, JTG_stuff_i, JTG_step_i, VCT_stuffStepSup, VCT_sxr[10:11],
           CPM_coreClkOff, VCT_sxr[7:9], PLB_jtgHoldAck, VCT_sxr[0:6], IFB_msrWE, overrun, IFB_stopAck};
assign MultiUseRegIn[0:31] = (muMuxIn[0:31] & {(32){~(MultiUseRegInMuxSel)}} ) | (MultiUseRegIn_D1 & {(32){MultiUseRegInMuxSel}} );

//Removed the module 'dp_muxJTG_SPRdataPath'
assign JTG_sprDataBus[0:31] = (EXE_sprDataBus[0:31] & {(32){~(SPRorDataMuxSel)}} ) | (DBDROut[0:31] & {(32){SPRorDataMuxSel}} );

//Removed the module 'dp_regJTG_sync'
  always @(posedge CB)      
    begin                                       
     regJTG_sync_L2 <= regJTG_sync_D;          
   end 
assign regJTG_sync_D = {18'b0, XXX_coreReset, XXX_systemReset, UpdateDR,
     SyncOut[2:4], CaptureDRSync0, SyncOut[5:6], NextStuff, NextDBDRpulse, NextStep,
     NextOverrun, XXX_jtgHalt};
assign coreReset     = regJTG_sync_L2[18];
assign sysReset      = regJTG_sync_L2[19];
assign SyncOut[2:8]  = regJTG_sync_L2[20:26];
assign JTG_stuff_i   = regJTG_sync_L2[27];
assign JTG_dbdrPulse = regJTG_sync_L2[28];
assign JTG_step_i    = regJTG_sync_L2[29];
assign overrun       = regJTG_sync_L2[30];
assign jtgHalt       = regJTG_sync_L2[31];

p405s_JTG_functional
 Functional(
  .BypassTDO(BypassTDO),
  .CaptureDRmeta(SyncOut[7:8]),
  .sysReset(sysReset),
  .CurrentStateL2(CurrentStateL2[0:7]),
  .DataValidBit(DataValidBit),
  .DBG_resetChip(DBG_resetChip),
  .DBG_resetSystem(DBG_resetSystem),
  .PCL_jtgSprDcd(PCL_jtgSprDcd),
  .IFB_stopAck(IFB_stopAck),
  .IFB_rstStepPend(IFB_rstStepPend),
  .IFB_rstStuffPend(IFB_rstStuffPend),
  .InstRegOutL1(InstRegOutL1[0:3]),
  .InstRegOutL2(InstRegOutL2[0:3]),
  .InstRegTDO(InstRegTDO),
  .InstShiftRegOut(InstShiftRegOut[0:2]),
  .JDCRstopProc(JDCRstopProc),
  .JDCRblockFold(JDCRblockFold),
  .JDCRstepPulse(JDCRstepPulse),
  .JDCRreset0(JDCRreset0),
  .JTG_dbgWaitEn(JTG_dbgWaitEn_i),
  .JDCRreset1(JDCRreset1),
  .JDCRinstRegDiagDcdEn(JDCRinstRegDiagDcdEn),
  .JTG_uncondEvent(JTG_uncondEvent_i),
  .JTG_freezeTimers(JTG_freezeTimers_i),
  .JTG_resetDBSR(JTG_resetDBSR_i),
  .pgmOut(pgmOut),
  .JTGEX_BndScanTDO(JTGEX_BndScanTDO),
  .JTGEX_TDI(JTGEX_TDI),
  .JTGEX_TMS(JTGEX_TMS),
  .JTGEX_TRST_NEG(JTGEX_TRST_NEG),
  .MultiUse_31(MultiUse[31]),
  .MultiUse_2(MultiUse[2]),
  .JTG_step(JTG_step_i),
  .JTG_stuff(JTG_stuff_i),
  .coreReset(coreReset),
  .DBG_resetCore(DBG_resetCore),
  .PCL_exeMfspr(PCL_exeMfspr),
  .PCL_exeMtspr(PCL_exeMtspr),
  .PCL_exeSprHold(PCL_exeSprHold),
  .ShiftDRL1(ShiftDRL1),
  .TIM_wdSysRst(TIM_wdSysRst),
  .TIM_wdChipRst(TIM_wdChipRst),
  .TIM_wdCoreRst(TIM_wdCoreRst),
  .ShiftIRL1(ShiftIRL1),
  .overrun(overrun),
  .UpdateDRmeta(SyncOut[3:5]),
  .jtgHalt(jtgHalt),
  .VCT_stuffStepSup(VCT_stuffStepSup),
  .BypassRegE1(BypassRegE1),
  .BypassRegIn(BypassRegIn),
  .CaptureDRSync0(CaptureDRSync0),
  .CntlRegAsyncReset(CntlRegAsyncReset),
  .diagMuxSel(diagMuxSel[0:1]),
  .DataRegE1(DataRegE1),
  .DataRegE2(DataRegE2),
  .DataRegMuxSel(DataRegMuxSel),
  .InstBufferE2(InstBufferE2),
  .InstRegAsyncSet(InstRegAsyncSet),
  .InstShiftRegE1(InstShiftRegE1),
  .InstRegL1E1(InstRegL1E1),
  .InstRegL2E1(InstRegL2E1),
  .InstRegIn(InstRegIn[0:3]),
  .InstShiftRegIn(InstShiftRegIn[0:3]),
  .JDCRE1(JDCRE1),
  .JDCRMuxSel(JDCRMuxSel),
  .JDCRMuxIn(JDCRMuxIn[0:7]),
  .capDataReg(capDataReg),
  .extest(extest),
  .resetChipReq(resetChipReq),
  .resetCoreReq(resetCoreReq),
  .resetSystemReq(resetSystemReq),
  .jtgShiftDR(jtgShiftDR),
  .JTG_stopReq(JTG_stopReq),
  .tdoEnable(tdoEnable),
  .jtgUpdateDR(jtgUpdateDR),
  .MultiUseRegInMuxSel(MultiUseRegInMuxSel),
  .MultiUseRegE1(MultiUseRegE1),
  .NextCacheWr(NextCacheWr),
  .NextDBDRpulse(NextDBDRpulse),
  .NextState(NextState[0:7]),
  .NextStep(NextStep),
  .NextStuff(NextStuff),
  .SPRorDataMuxSel(SPRorDataMuxSel),
  .NextOverrun(NextOverrun),
  .TDOIn(TDOIn),
  .JTG_stepUPD(JTG_stepUPD),
  .JTG_stuffUPD(JTG_stuffUPD));

//Removed the module 'dp_regJTG_cntlL2'
always @(CntlRegAsyncReset or JTGEX_TCK or JTGEX_TRST_NEG or NextState)        
    begin                                       
    case(CntlRegAsyncReset)                    
     1'b0: regJTG_cntlL2_L1 = 8'b00000000;          
     1'b1:                              
      case((~JTGEX_TCK & JTGEX_TRST_NEG))                   
       1'b0: ;                          
       1'b1: regJTG_cntlL2_L1 = NextState[0:7];   
        default: regJTG_cntlL2_L1 = 8'bx; 
      endcase                           
      default: regJTG_cntlL2_L1 = 8'bx;   
    endcase                             
   end                                  
                                           
   // L2 latch                             
   always @(JTGEX_TCK or JTGEX_TRST_NEG or regJTG_cntlL2_L1)          
    begin                                       
    case((JTGEX_TCK | ~JTGEX_TRST_NEG))                     
     1'b0: ;                            
     1'b1: CurrentStateL2[0:7] = regJTG_cntlL2_L1;         
      default: CurrentStateL2[0:7] = 8'bx;   
    endcase                             
   end    


//Removed the module 'dp_regJTG_cntlL1'
always @(CntlRegAsyncReset or JTGEX_TRST_NEG or JTGEX_TCK or ShiftIR or ShiftDR or TDOIn)        
    begin                                       
    case(CntlRegAsyncReset)                    
     1'b0: regJTG_cntlL1_L1 = 3'b000;               
     1'b1:                              
      case((JTGEX_TRST_NEG & ~JTGEX_TCK))                   
       1'b0: ;                          
       1'b1: regJTG_cntlL1_L1 = {ShiftIR, ShiftDR, TDOIn};   
        default: regJTG_cntlL1_L1 = 3'bx; 
      endcase                           
      default: regJTG_cntlL1_L1 = 3'bx;   
    endcase                             
   end                                  
                                           
   // L2 latch                             
   // Flush L2 with FZB clock              
   always @(regJTG_cntlL1_L1)                       
    begin                                       
     {ShiftIRL1, ShiftDRL1, tdo} = regJTG_cntlL1_L1;               
   end 


//Removed the module 'dp_regJTG_MultiUseMuxReg2'
always @(MultiUseRegIn or MultiUse or ShiftDR)        
    begin                                       
    casez(ShiftDR)                    
     1'b0: dp_Reg_DataIn2 = MultiUseRegIn[16:31];   
     1'b1: dp_Reg_DataIn2 = MultiUse[15:30];   
      default: dp_Reg_DataIn2 = 16'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge JTGEX_TCK)      
    begin                                       
    casez(MultiUseRegE1)                    
     1'b0: MultiUse[16:31] <= MultiUse[16:31];                
     1'b1: MultiUse[16:31] <= dp_Reg_DataIn2;       
      default: MultiUse[16:31] <= 16'bx;  
    endcase                             
   end   

//Removed the module 'dp_regJTG_MultiUseMuxReg'
always @(MultiUseRegIn or JTGEX_TDI or DataValidBit or MultiUse or ShiftDR)
    begin                                       
    casez(ShiftDR)                    
     1'b0: dp_Reg_DataIn = {1'b0,MultiUseRegIn[0:15]};   
     1'b1: dp_Reg_DataIn = {JTGEX_TDI, DataValidBit, MultiUse[0:14]};   
      default: dp_Reg_DataIn = 17'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge JTGEX_TCK)      
    begin                                       
    casez(MultiUseRegE1)                    
     1'b0: {DataValidBit, MultiUse[0:15]} <= {DataValidBit, MultiUse[0:15]};                
     1'b1: {DataValidBit, MultiUse[0:15]} <= dp_Reg_DataIn;       
      default: {DataValidBit, MultiUse[0:15]} <= 17'bx;  
    endcase                             
   end   

//Removed the module 'dp_regJTG_InstructionShift'
always @(posedge JTGEX_TCK)      
    begin                                       
    casez(InstShiftRegE1)                    
     1'b0: {InstShiftRegOut[0:2], InstRegTDO} <= {InstShiftRegOut[0:2], InstRegTDO};                
     1'b1: {InstShiftRegOut[0:2], InstRegTDO} <= InstShiftRegIn[0:3];            
      default: {InstShiftRegOut[0:2], InstRegTDO} <= 4'bx;  
    endcase                             
   end  

//Removed the module 'dp_regJTG_InstL2'
always @(InstRegAsyncSet or JTGEX_TCK or InstRegL2E1 or InstRegIn)         
    begin                                       
    case(InstRegAsyncSet)                     
     1'b0:                              
      case((InstRegL2E1 & ~JTGEX_TCK))                   
       1'b0: ;                          
       1'b1: regJTG_InstL2_L1 = InstRegIn[0:3];   
        default: regJTG_InstL2_L1 = 4'bx; 
      endcase                           
     1'b1: regJTG_InstL2_L1 = 4'b1111;              
      default: regJTG_InstL2_L1 = 4'bx;   
    endcase                             
   end                                  
                                           
   // L2 latch                             
   always @(JTGEX_TCK or InstRegL2E1 or regJTG_InstL2_L1)          
    begin                                       
    case((JTGEX_TCK | ~InstRegL2E1))                     
     1'b0: ;                            
     1'b1: InstRegOutL2[0:3] = regJTG_InstL2_L1;         
      default: InstRegOutL2[0:3] = 4'bx;   
    endcase                             
   end  


//Removed the module 'dp_regJTG_InstL1'
// always @(InstRegAsyncSet or InstRegL1E1 or JTGEX_TCK or InstRegIn)         
//     begin                                       
//     case(InstRegAsyncSet)                     
//      1'b0:                              
//       case((InstRegL1E1 & ~JTGEX_TCK))                   
//        1'b0: ;                          
//        1'b1: regJTG_InstL1_L1 = InstRegIn[0:3];   
//         default: regJTG_InstL1_L1 = 4'bx; 
//       endcase                           
//      1'b1: regJTG_InstL1_L1 = 4'b1111;              
//       default: regJTG_InstL1_L1 = 4'bx;   
//     endcase                             
//    end                                  
always @(InstRegAsyncSet or InstRegL1E1 or JTGEX_TCK or InstRegIn)         
    begin                                       
    if (InstRegAsyncSet)                     
     regJTG_InstL1_L1 = 4'b1111;              
    else
      if ((InstRegL1E1 & ~JTGEX_TCK))                   
        regJTG_InstL1_L1 = InstRegIn[0:3];   
   end                                  
                                           
   // L2 latch                             
   // Flush L2 with FZB clock              
   always @(regJTG_InstL1_L1)                       
    begin                                       
     InstRegOutL1[0:3] = regJTG_InstL1_L1;               
   end  


//Removed the module 'dp_regJTG'
always @(MultiUse or EXE_sprDataBus or DataRegMuxSel)        
    begin                                       
    casez(DataRegMuxSel)                    
     1'b0: DBDROut_muxout[0:31] = MultiUse[0:31];   
     1'b1: DBDROut_muxout[0:31] = EXE_sprDataBus[0:31];   
      default: DBDROut_muxout[0:31] = 32'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(DataRegE1 & DataRegE2)                
     1'b0: DBDROut[0:31] <= DBDROut[0:31];                
     1'b1: DBDROut[0:31] <= DBDROut_muxout[0:31];       
      default: DBDROut[0:31] <= 32'bx;  
    endcase                             
   end 


//Removed the module 'dp_regJTG_Bypass'
always @(posedge JTGEX_TCK)      
    begin                                       
    casez(BypassRegE1)                    
     1'b0: BypassTDO <= BypassTDO;                
     1'b1: BypassTDO <= BypassRegIn;            
      default: BypassTDO <= 1'bx;  
    endcase                             
   end  

endmodule
