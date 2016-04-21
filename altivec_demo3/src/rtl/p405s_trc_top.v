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
// Cobra Change History
// NAME   DATE    DEFECT  DESCRIPTION
// PGM  07/31/01   1785   Remove port size information in module definition
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1

module p405s_trc_top( TRC_evenESBusL2, TRC_fifoFull, TRC_fifoOneEntryFree, TRC_oddCycleL2,
     TRC_oddESBusL2, TRC_se, TRC_seCtrEqZeroL2, TRC_sleepReq, TRC_tsBusL2,
     CB, DBG_stopReq, ICU_traceEnable, IFB_postEntry, IFB_seIdleSt, IFB_stopAck,
     IFB_traceData, IFB_traceESL2, IFB_traceType, JTG_stopReq, VCT_msrWE,
     XXX_TE, XXX_traceDisable, coreReset );
output  TRC_fifoFull, TRC_fifoOneEntryFree, TRC_oddCycleL2, TRC_se, TRC_seCtrEqZeroL2,
     TRC_sleepReq;


input  DBG_stopReq, ICU_traceEnable, IFB_postEntry, IFB_seIdleSt, IFB_stopAck, JTG_stopReq,
     VCT_msrWE, XXX_TE, XXX_traceDisable, coreReset;

output [0:1]  TRC_evenESBusL2;
output [0:1]  TRC_oddESBusL2;
output [0:3]  TRC_tsBusL2;


input [0:1]  IFB_traceESL2;
input [0:1]  IFB_traceType;
input [0:29]  IFB_traceData;
input         CB;

// Buses in the design

reg  [0:3]  trcSerStateL2;

reg  [0:8]  fifoTimeStampOutL2;

reg  [0:4]  fifoStatusL2;

wire  [0:10]  seInc;

reg  [0:1]  evenESBusL2;

wire  [0:2]  serDataOut;

reg  [0:3]  fifoRdAddrL2;

reg  [0:3]  tsBusL2;

wire  [0:3]  nxtFifoWrAddr;

reg  [0:1]  oddESBusL2;

reg  [0:3]  fifoWrAddrL2;

wire  [0:3]  nxtTrcSerState;

reg  [0:1]  evenESL2;

wire  [0:3]  nxtTSBus;

reg  [0:10]  trcSECtrOutL2;

wire  [0:8]  stampInc;

wire  [0:4]  nxtFifoStatus;

wire  [0:31]  trcFifoDataOut;

wire  [0:15]  trcFifoE1;

wire  [0:3]  nxtFifoRdAddr;

reg extOddCycleL2;

wire serializerE1;
wire trcReset;
wire fifoCntlE2;
wire evenESTEE1;
wire trcSECtrE1;
wire trcESTSE1;
wire trcTimeStampE2;
wire xxxTEQ;
reg evenTEL2;
reg coreResetL2;
reg oddCycleL2;
reg stampIncL2;
reg trcEnableDlyL2;
reg TRC_seCtrEqZeroL2_i;
reg xxxTraceDisableL2;
wire coreReset ;
wire nxtOddCycle;
wire nxtStampInc;
wire ICU_traceEnable;
wire nxtSeCtrEqZero;
wire XXX_traceDisable;
wire trcSECtrReset;
wire trcTimeStampE1;

wire TRC_se_i;

assign TRC_se = TRC_se_i;

assign TRC_seCtrEqZeroL2 = TRC_seCtrEqZeroL2_i;

//Removed the module dp_logTRC_trcSoBuf

//Removed the module dp_logTRC_oddCycleBuf

assign TRC_oddCycleL2 = extOddCycleL2;

//Removed the module dp_logTRC_oddESBusBuf

assign TRC_oddESBusL2 = oddESBusL2;

//Removed the module dp_logTRC_tsBusBuf
assign TRC_tsBusL2 = tsBusL2;

//Removed the module dp_logTRC_evenEsBusBuf
assign TRC_evenESBusL2 = evenESBusL2;

//Removed the module dp_macTRC_seInc
assign seInc = trcSECtrOutL2 + 1;

//Removed the module dp_macTRC_incStamp
assign stampInc = fifoTimeStampOutL2 + 1;

//Removed the module trcClkBuf

//Removed the module dp_regTRC_serializeState
always @(posedge CB)
  begin: dp_regTRC_serializeState_PROC
    if (serializerE1)
      begin
        if (trcReset)
          trcSerStateL2 <= 4'h0;
        else
          trcSerStateL2 <= nxtTrcSerState;
      end
  end // dp_regTRC_serializeState_PROC

//Removed the module dp_regTRC_fifoCntl
always @(posedge CB)
  begin: dp_regTRC_fifoCntl_PROC
    if (fifoCntlE2)
      begin
        if (trcReset)
          {fifoStatusL2, fifoWrAddrL2, fifoRdAddrL2} <= 13'h0;
        else
          {fifoStatusL2, fifoWrAddrL2, fifoRdAddrL2} <= {nxtFifoStatus,
                                                         nxtFifoWrAddr,
                                                         nxtFifoRdAddr};
      end
  end // dp_regTRC_fifoCntl_PROC
     
//Removed the module dp_regTRC_evenESTE
always @(posedge CB)
  begin: dp_regTRC_evenESTE_PROC
    if (evenESTEE1)
      begin
        if (trcReset)
          {evenESL2, evenTEL2} <= 3'h0;
        else
          {evenESL2, evenTEL2} <= {IFB_traceESL2, xxxTEQ};
      end
  end // dp_regTRC_evenESTE_PROC

//Removed the module dp_regTRC_timerSE
always @(posedge CB)
  begin: dp_regTRC_timerSE_PROC
    if (trcSECtrE1)
      begin
        if (trcSECtrReset)
          trcSECtrOutL2 <= 11'h0;
        else
          trcSECtrOutL2 <= seInc;
      end
  end // dp_regTRC_timerSE_PROC


//Removed the module dp_regTRC_ESTS
always @(posedge CB)
  begin: dp_regTRC_ESTS_PROC
    if (trcESTSE1)
      begin
        if (trcReset)
          {tsBusL2, evenESBusL2, oddESBusL2} <= 8'h0;
        else
          {tsBusL2, evenESBusL2, oddESBusL2} <= {nxtTSBus, evenESL2,  IFB_traceESL2};
      end
  end // dp_regTRC_ESTS_PROC

//Removed the module dp_regTRC_timeStamp
always @(posedge CB)
  begin: dp_regTRC_timeStamp_PROC
    if (trcTimeStampE1 & trcTimeStampE2)
      begin
        if (TRC_se_i)
          fifoTimeStampOutL2 <= 9'h0;
        else
          fifoTimeStampOutL2 <= stampInc;
      end
  end // dp_regTRC_timeStamp_PROC

//Removed the module dp_regTRC_resetDly
always @(posedge CB)
  begin: dp_regTRC_resetDly_PROC
    coreResetL2 <= coreReset;
    oddCycleL2 <= nxtOddCycle;
    extOddCycleL2 <= nxtOddCycle;
    stampIncL2 <= nxtStampInc;
    trcEnableDlyL2 <= ICU_traceEnable;
    TRC_seCtrEqZeroL2_i <= nxtSeCtrEqZero;
    xxxTraceDisableL2 <= XXX_traceDisable;
  end // dp_regTRC_resetDly_PROC

assign TRC_fifoFull = fifoStatusL2[0]; //16 entries full

p405s_trcCntlEqs
 trcCntlEqsFun(.TRC_se(TRC_se_i), 
                         .TRC_sleepReq(TRC_sleepReq), 
                         .TRC_fifoOneEntryFree(TRC_fifoOneEntryFree),
                         .trcSECtrReset(trcSECtrReset), 
                         .trcReset(trcReset), 
                         .nxtFifoWrAddr(nxtFifoWrAddr), 
                         .nxtFifoRdAddr(nxtFifoRdAddr), 
                         .nxtFifoStatus(nxtFifoStatus),
                         .nxtTrcSerState(nxtTrcSerState), 
                         .nxtTSBus(nxtTSBus), 
                         .nxtOddCycle(nxtOddCycle), 
                         .nxtStampInc(nxtStampInc), 
                         .nxtSeCtrEqZero(nxtSeCtrEqZero), 
                         .trcESTSE1(trcESTSE1),
                         .trcTimeStampE1(trcTimeStampE1), 
                         .trcSECtrE1(trcSECtrE1), 
                         .fifoCntlE2(fifoCntlE2), 
                         .serializerE1(serializerE1), 
                         .trcTimeStampE2(trcTimeStampE2), 
                         .evenESTEE1(evenESTEE1),
                         .trcFifoE1(trcFifoE1), 
                         .xxxTEQ(xxxTEQ), 
                         .ICU_traceEnable(ICU_traceEnable), 
                         .IFB_postEntry(IFB_postEntry), 
                         .IFB_stopAck(IFB_stopAck), 
                         .IFB_seIdleSt(IFB_seIdleSt),
                         .VCT_msrWE(VCT_msrWE), 
                         .JTG_stopReq(JTG_stopReq), 
                         .DBG_stopReq(DBG_stopReq), 
                         .XXX_TE(XXX_TE), 
                         .serDataOut(serDataOut), 
                         .seInc(seInc),
                         .trcFifoDataOut(trcFifoDataOut[30:31]), 
                         .fifoStatusL2(fifoStatusL2), 
                         .fifoWrAddrL2(fifoWrAddrL2), 
                         .fifoRdAddrL2(fifoRdAddrL2),
                         .trcSerStateL2(trcSerStateL2), 
                         .coreResetL2(coreResetL2), 
                         .evenTEL2(evenTEL2), 
                         .stampIncL2(stampIncL2), 
                         .trcEnableDlyL2(trcEnableDlyL2), 
                         .oddCycleL2(oddCycleL2),
                         .seCtrEqZeroL2(TRC_seCtrEqZeroL2_i), 
                         .xxxTraceDisableL2(xxxTraceDisableL2));
                         
p405s_trcSerializer
 trcSerialSch( .serDataOut(serDataOut), 
                                        .trcFifoDataOut(trcFifoDataOut[0:29]), 
                                        .trcSerStateL2(trcSerStateL2),
                                        .trcTimeStampOut(fifoTimeStampOutL2));
                                        
p405s_trcFIFO
 trcFIFOSch(  .trcFifoDataOut(trcFifoDataOut), 
                                 .CB(CB),  
                                 .fifoRdAddrL2(fifoRdAddrL2),
                                 .trcFifoDataIn({IFB_traceData[0:29], IFB_traceType[0:1]}), 
                                 .trcFifoE1(trcFifoE1));

endmodule
