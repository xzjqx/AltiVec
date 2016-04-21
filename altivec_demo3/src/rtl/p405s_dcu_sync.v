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
// Verilog HDL for "PR_icu", "icu_sync" "_functional"

module p405s_dcu_sync(
                DCS_plbRequest, DCS_plbRNW, DCS_plbABus,
                DCS_plbSize2, DCS_plbCacheable, DCS_plbWriteThru,
                DCS_plbU0Attr, DCS_plbGuarded, DCS_plbBE,
                DCS_plbPriority,DCS_plbAbort, DCS_plbWrDBus,

                DCS_c405AddrAck, DCS_c405SSize1, DCS_c405RdDAck,
                DCS_c405RdDBus, DCS_c405RdWdAddr, DCS_c405WrDAck,
                DCS_c405Busy, DCS_c405Err,

                C405_dcsDcuRequest, C405_dcsDcuRNW, C405_dcsDcuABus,
                C405_dcsDcuSize2, C405_dcsDcuCacheable, C405_dcsDcuWriteThru,
                C405_dcsDcuU0Attr, C405_dcsDcuGuarded, C405_dcsDcuBE,
                C405_dcsDcuPriority, C405_dcsDcuAbort, C405_dcsDcuWrDBus,

                PLB_dcsAddrAck, PLB_dcsSSize1, PLB_dcsRdDAck,
                PLB_dcsRdDBus, PLB_dcsRdWdAddr, PLB_dcsWrDAck,
                PLB_dcsBusy, PLB_dcsErr,

                CPM_c405SyncBypass, EXT_sysclkPLB, CB,
                RST_ResetCore
               );

// Inputs and Outputs
////////////////////////////  start I/O  ////////////////////////////////////////

output          DCS_plbRequest;
output          DCS_plbRNW;
output  [0:31]  DCS_plbABus;
output          DCS_plbSize2;
output          DCS_plbCacheable;
output          DCS_plbWriteThru;
output          DCS_plbU0Attr;
output          DCS_plbGuarded;
output  [0:7]   DCS_plbBE;
output  [0:1]   DCS_plbPriority;
output          DCS_plbAbort;
output  [0:63]  DCS_plbWrDBus;

output          DCS_c405AddrAck;
output          DCS_c405SSize1;
output          DCS_c405RdDAck;
output  [0:63]  DCS_c405RdDBus;
output  [1:3]   DCS_c405RdWdAddr;
output          DCS_c405WrDAck;
output          DCS_c405Busy;
output          DCS_c405Err;


input           C405_dcsDcuRequest;
input           C405_dcsDcuRNW;
input   [0:31]  C405_dcsDcuABus;
input           C405_dcsDcuSize2;
input           C405_dcsDcuCacheable;
input           C405_dcsDcuWriteThru;
input           C405_dcsDcuU0Attr;
input           C405_dcsDcuGuarded;
input   [0:7]   C405_dcsDcuBE;
input   [0:1]   C405_dcsDcuPriority;
input           C405_dcsDcuAbort;
input   [0:63]  C405_dcsDcuWrDBus;

input           PLB_dcsAddrAck;
input           PLB_dcsSSize1;
input           PLB_dcsRdDAck;
input   [0:63]  PLB_dcsRdDBus;
input   [1:3]   PLB_dcsRdWdAddr;
input           PLB_dcsWrDAck;
input           PLB_dcsBusy;
input           PLB_dcsErr;

input           CPM_c405SyncBypass;
input           EXT_sysclkPLB;
input   CB;
input           RST_ResetCore;

wire            dcsRequestFL2;
wire            dcsRNWFL2;
wire    [0:31]  dcsABusFL2;
wire            dcsSize2FL2;
wire            dcsCacheableFL2;
wire            dcsWriteThruFL2;
wire            dcsU0AttrFL2;
wire            dcsGuardedFL2;
wire    [0:7]   dcsBEFL2;
wire    [0:1]   dcsPriorityFL2;
wire    [0:63]  dcsWrDBus1FL2;
wire    [0:63]  dcsWrDBus2FL2;
wire    [0:63]  dcsWrDBus3FL2;
wire    [0:63]  dcsWrDBus4FL2;
wire            dcsAbortFL2;

wire            dcsC405AddrAckFL2;
wire            dcsC405SSize1FL2;
wire            dcsC405RdDAckFL2;
wire    [0:63]  dcsC405RdDBusFL2;
wire    [1:3]   dcsC405RdWdAddrFL2;
wire            dcsC405BusyFL2;
wire            dcsC405ErrFL2;

wire            busyForReqFL2;
wire            busyForDataFL2;
wire            dataDoneFL2;
wire            slowEdgeFL2;
wire    [0:1]   writeCountFL2;

wire            dcsPLBRequestSL2;
wire            dcsPLBRNWSL2;
wire    [0:31]  dcsPLBABusSL2;
wire            dcsPLBSize2SL2;
wire            dcsPLBCacheableSL2;
wire            dcsPLBWriteThruSL2;
wire            dcsPLBU0AttrSL2;
wire            dcsPLBGuardedSL2;
wire    [0:7]   dcsPLBBESL2;
wire    [0:1]   dcsPLBPrioritySL2;
wire            dcsPLBAbortSL2;
wire    [0:63]  dcsPLBWrDBusSL2;

wire            dcsAddrAckSL2;
wire            dcsSSize1SL2;
wire            dcsRdDAckSL2;
wire    [0:63]  dcsRdDBusSL2;
wire    [1:3]   dcsRdWdAddrSL2;
wire            dcsWrDAckSL2;
wire            dcsBusySL2;
wire            dcsErrSL2;

wire            wrStateSL2;
wire            slowEdgeSL2;
wire            dataDoneSL2;
wire            dataCompleteSL2;
wire            wrSize2SL2;
wire    [0:2]   wrCountSL2;
wire            plbSSize1SL2;
wire            resetSL2;
wire            resetFL2;

wire            DCS_plbRequest;
wire            DCS_plbRNW;
wire    [0:31]  DCS_plbABus;
wire            DCS_plbSize2;
wire            DCS_plbCacheable;
wire            DCS_plbWriteThru;
wire            DCS_plbU0Attr;
wire            DCS_plbGuarded;
wire    [0:7]   DCS_plbBE;
wire    [0:1]   DCS_plbPriority;
wire            DCS_plbAbort;
wire    [0:63]  DCS_plbWrDBus;

wire            mux_DCS_plbRequest_M;
wire            mux_DCS_plbRNW_M;
wire    [0:31]  mux_DCS_plbABus_M;
wire            mux_DCS_plbSize2_M;
wire            mux_DCS_plbCacheable_M;
wire            mux_DCS_plbWriteThru_M;
wire            mux_DCS_plbU0Attr_M;
wire            mux_DCS_plbGuarded_M;
wire    [0:7]   mux_DCS_plbBE_M;
wire    [0:1]   mux_DCS_plbPriority_M;
wire            mux_DCS_plbAbort_M;
wire    [0:63]  mux_DCS_plbWrDBus_M;

wire            inv_DCS_plbRequest1_N;
wire            inv_DCS_plbRNW1_N;
wire    [0:31]  inv_DCS_plbABus1_N;
wire            inv_DCS_plbSize21_N;
wire            inv_DCS_plbCacheable1_N;
wire            inv_DCS_plbWriteThru1_N;
wire            inv_DCS_plbU0Attr1_N;
wire            inv_DCS_plbGuarded1_N;
wire    [0:7]   inv_DCS_plbBE1_N;
wire    [0:1]   inv_DCS_plbPriority1_N;
wire            inv_DCS_plbAbort1_N;
wire    [0:63]  inv_DCS_plbWrDBus1_N;

wire            DCS_c405AddrAck;
wire            DCS_c405SSize1;
wire            DCS_c405RdDAck;
wire    [0:63]  DCS_c405RdDBus;
wire    [1:3]   DCS_c405RdWdAddr;
wire            DCS_c405WrDAck;
wire            DCS_c405Busy;
wire            DCS_c405Err;

wire            mux_DCS_c405AddrAck_M;
wire            mux_DCS_c405SSize1_M;
wire            mux_DCS_c405RdDAck_M;
wire    [0:63]  mux_DCS_c405RdDBus_M;
wire    [1:3]   mux_DCS_c405RdWdAddr_M;
wire            mux_DCS_c405WrDAck_M;
wire            mux_DCS_c405Busy_M;
wire            mux_DCS_c405Err_M;

wire            inv_DCS_c405AddrAck1_N;
wire            inv_DCS_c405SSize11_N;
wire            inv_DCS_c405RdDAck1_N;
wire    [0:63]  inv_DCS_c405RdDBus1_N;
wire    [1:3]   inv_DCS_c405RdWdAddr1_N;
wire            inv_DCS_c405WrDAck1_N;
wire            inv_DCS_c405Busy1_N;
wire            inv_DCS_c405Err1_N;

reg     [0:63]  dcsWrDBusS;
reg     [0:2]   nxtWrCountS;

wire            dcsC405AddrAckF;
wire            dcsC405WrDAckF;
wire            dcsC405SSize1F;
wire            dcsC405BusyF;
wire            loadRequestF;
wire            dcsReqFHold;
wire            loadDcsWrDBus1;
wire            loadDcsWrDBus2;
wire            loadDcsWrDBus3;
wire            loadDcsWrDBus4;
wire            dcsAddrAckSChop;
wire            dcsErrSChop;
wire            dcsRdDAckSChop;
wire            dcsReqFNoAck;
wire            EXT_sysclkPLB;
wire            loadWrDBus;
wire            incWriteCountF;
wire    [0:1]   writeCountPlus1F;
wire            nxtBusyForReqF;
wire            nxtBusyForDataF;
wire            dataCompleteSChop;
wire            sample;
wire            nxtWrState;
wire            dataDoneS;
wire    [0:2]   wrCountPlus1S;
wire    [0:2]   wrCountPlus2S;
wire            incWrCountS;
wire            wrCountIncSelS;
wire            nxtPlbSSize1S;
wire            nxtWrSize2S;

////////////////////////////  end I/O  //////////////////////////////////////////

wire dcuSyncGlobalE1;
wire dcuSyncGlobalE1S;
wire dcuSyncGlobalE1_wRequest;
wire dcuSyncGlobalE1_wRdDAckPLB;
//wire dcuSyncGlobalE1_wWrDack;
assign dcuSyncGlobalE1  = resetFL2 | ~CPM_c405SyncBypass;
assign dcuSyncGlobalE1S  = resetSL2 | ~CPM_c405SyncBypass;
assign dcuSyncGlobalE1_wRequest = resetFL2 | (~CPM_c405SyncBypass & C405_dcsDcuRequest);
assign dcuSyncGlobalE1_wRdDAckPLB = resetSL2 | (~CPM_c405SyncBypass & PLB_dcsRdDAck);
//assign dcuSyncGlobalE1_wWrDack = resetFL2 | (~CPM_c405SyncBypass & DCS_c405WrDAck);

//****************//
//* BYPASS MUXES *//
//****************//

// Replacing instantiation: PDP_MUX2D dp_muxDCS_plbRequest
assign mux_DCS_plbRequest_M = (dcsPLBRequestSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuRequest & {(1){CPM_c405SyncBypass}} ); 

// Replacing instantiation: INVERT inv_DCS_plbRequest1
assign inv_DCS_plbRequest1_N = ~(mux_DCS_plbRequest_M);

// Replacing instantiation: INVERT inv_DCS_plbRequest2
assign DCS_plbRequest = ~(inv_DCS_plbRequest1_N);

// Replacing instantiation: PDP_MUX2D dp_muxDCS_plbRNW
assign mux_DCS_plbRNW_M = (dcsPLBRNWSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuRNW & {(1){CPM_c405SyncBypass}} ); 

// Replacing instantiation: INVERT inv_DCS_plbRNW1
assign inv_DCS_plbRNW1_N = ~(mux_DCS_plbRNW_M);

// Replacing instantiation: INVERT inv_DCS_plbRNW2
assign DCS_plbRNW = ~(inv_DCS_plbRNW1_N);

// Replacing instantiation: PDP_MUX2D dp_muxDCS_plbABus
assign mux_DCS_plbABus_M = (dcsPLBABusSL2 & {(32){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuABus & {(32){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_plbABus1
   assign inv_DCS_plbABus1_N = ~(mux_DCS_plbABus_M);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbABus2
   assign DCS_plbABus = ~(inv_DCS_plbABus1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbSize2
   assign mux_DCS_plbSize2_M = (dcsPLBSize2SL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuSize2 & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbSize21
   assign inv_DCS_plbSize21_N = ~(mux_DCS_plbSize2_M);

   // Replacing instantiation: INVERT inv_DCS_plbSize22
   assign DCS_plbSize2 = ~(inv_DCS_plbSize21_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbCacheable
   assign mux_DCS_plbCacheable_M = (dcsPLBCacheableSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuCacheable & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbCacheable1
   assign inv_DCS_plbCacheable1_N = ~(mux_DCS_plbCacheable_M);

   // Replacing instantiation: INVERT inv_DCS_plbCacheable2
   assign DCS_plbCacheable = ~(inv_DCS_plbCacheable1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbWriteThru
   assign mux_DCS_plbWriteThru_M = (dcsPLBWriteThruSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuWriteThru & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbWriteThru1
   assign inv_DCS_plbWriteThru1_N = ~(mux_DCS_plbWriteThru_M);

   // Replacing instantiation: INVERT inv_DCS_plbWriteThru2
   assign DCS_plbWriteThru = ~(inv_DCS_plbWriteThru1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbU0Attr
   assign mux_DCS_plbU0Attr_M = (dcsPLBU0AttrSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuU0Attr & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbU0Attr1
   assign inv_DCS_plbU0Attr1_N = ~(mux_DCS_plbU0Attr_M);

   // Replacing instantiation: INVERT inv_DCS_plbU0Attr2
   assign DCS_plbU0Attr = ~(inv_DCS_plbU0Attr1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbGuarded
   assign mux_DCS_plbGuarded_M = (dcsPLBGuardedSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuGuarded & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbGuarded1
   assign inv_DCS_plbGuarded1_N = ~(mux_DCS_plbGuarded_M);

   // Replacing instantiation: INVERT inv_DCS_plbGuarded2
   assign DCS_plbGuarded = ~(inv_DCS_plbGuarded1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbBE
   assign mux_DCS_plbBE_M = (dcsPLBBESL2 & {(8){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuBE & {(8){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_plbBE1
   assign inv_DCS_plbBE1_N = ~(mux_DCS_plbBE_M);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbBE2
   assign DCS_plbBE = ~(inv_DCS_plbBE1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbPriority
   assign mux_DCS_plbPriority_M = (dcsPLBPrioritySL2 & {(2){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuPriority & {(2){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_plbPriority1
   assign inv_DCS_plbPriority1_N = ~(mux_DCS_plbPriority_M);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbPriority2
   assign DCS_plbPriority = ~(inv_DCS_plbPriority1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbAbort
   assign mux_DCS_plbAbort_M = (dcsPLBAbortSL2 & {(1){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuAbort & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_plbAbort1
   assign inv_DCS_plbAbort1_N = ~(mux_DCS_plbAbort_M);

   // Replacing instantiation: INVERT inv_DCS_plbAbort2
   assign DCS_plbAbort = ~(inv_DCS_plbAbort1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbWrDBusHi
   assign mux_DCS_plbWrDBus_M[0:31] = (dcsPLBWrDBusSL2[0:31] & {(32){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuWrDBus[0:31] & {(32){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_plbWrDBusLo
   assign mux_DCS_plbWrDBus_M[32:63] = (dcsPLBWrDBusSL2[32:63] & {(32){~(CPM_c405SyncBypass)}} ) | (C405_dcsDcuWrDBus[32:63] & {(32){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_plbWrDBus1Hi
   assign inv_DCS_plbWrDBus1_N[0:31] = ~(mux_DCS_plbWrDBus_M[0:31]);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbWrDBus1Lo
   assign inv_DCS_plbWrDBus1_N[32:63] = ~(mux_DCS_plbWrDBus_M[32:63]);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbWrDBus2Hi
   assign DCS_plbWrDBus[0:31] = ~(inv_DCS_plbWrDBus1_N[0:31]);

   // Replacing instantiation: GS_INVERT dp_invDCS_plbWrDBus2Lo
   assign DCS_plbWrDBus[32:63] = ~(inv_DCS_plbWrDBus1_N[32:63]);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405AddrAck
   assign mux_DCS_c405AddrAck_M = (dcsC405AddrAckF & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsAddrAck & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405AddrAck1
   assign inv_DCS_c405AddrAck1_N = ~(mux_DCS_c405AddrAck_M);

   // Replacing instantiation: INVERT inv_DCS_c405AddrAck2
   assign DCS_c405AddrAck = ~(inv_DCS_c405AddrAck1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405SSize1
   assign mux_DCS_c405SSize1_M = (dcsC405SSize1F & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsSSize1 & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405SSize11
   assign inv_DCS_c405SSize11_N = ~(mux_DCS_c405SSize1_M);

   // Replacing instantiation: INVERT inv_DCS_c405SSize12
   assign DCS_c405SSize1 = ~(inv_DCS_c405SSize11_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405RdDAck
   assign mux_DCS_c405RdDAck_M = (dcsC405RdDAckFL2 & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsRdDAck & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405RdDAck1
   assign inv_DCS_c405RdDAck1_N = ~(mux_DCS_c405RdDAck_M);

   // Replacing instantiation: INVERT inv_DCS_c405RdDAck2
   assign DCS_c405RdDAck = ~(inv_DCS_c405RdDAck1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405RdDBusHi
   assign mux_DCS_c405RdDBus_M[0:31] = (dcsC405RdDBusFL2[0:31] & {(32){~(CPM_c405SyncBypass)}} ) | (PLB_dcsRdDBus[0:31] & {(32){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405RdDBusLo
   assign mux_DCS_c405RdDBus_M[32:63] = (dcsC405RdDBusFL2[32:63] & {(32){~(CPM_c405SyncBypass)}} ) | (PLB_dcsRdDBus[32:63] & {(32){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdDBus1Hi
   assign inv_DCS_c405RdDBus1_N[0:31] = ~(mux_DCS_c405RdDBus_M[0:31]);

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdDBus1Lo
   assign inv_DCS_c405RdDBus1_N[32:63] = ~(mux_DCS_c405RdDBus_M[32:63]);

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdDBus2Hi
   assign DCS_c405RdDBus[0:31] = ~(inv_DCS_c405RdDBus1_N[0:31]);

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdDBus2Lo
   assign DCS_c405RdDBus[32:63] = ~(inv_DCS_c405RdDBus1_N[32:63]);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405RdWdAddr
   assign mux_DCS_c405RdWdAddr_M = (dcsC405RdWdAddrFL2 & {(3){~(CPM_c405SyncBypass)}} ) | (PLB_dcsRdWdAddr & {(3){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdWdAddr1
   assign inv_DCS_c405RdWdAddr1_N = ~(mux_DCS_c405RdWdAddr_M);

   // Replacing instantiation: GS_INVERT dp_invDCS_c405RdWdAddr2
   assign DCS_c405RdWdAddr = ~(inv_DCS_c405RdWdAddr1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405WrDAck
   assign mux_DCS_c405WrDAck_M = (dcsC405WrDAckF & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsWrDAck & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405WrDAck1
   assign inv_DCS_c405WrDAck1_N = ~(mux_DCS_c405WrDAck_M);

   // Replacing instantiation: INVERT inv_DCS_c405WrDAck2
   assign DCS_c405WrDAck = ~(inv_DCS_c405WrDAck1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405Busy
   assign mux_DCS_c405Busy_M = (dcsC405BusyF & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsBusy & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405Busy1
   assign inv_DCS_c405Busy1_N = ~(mux_DCS_c405Busy_M);

   // Replacing instantiation: INVERT inv_DCS_c405Busy2
   assign DCS_c405Busy = ~(inv_DCS_c405Busy1_N);

   // Replacing instantiation: PDP_MUX2D dp_muxDCS_c405Err
   assign mux_DCS_c405Err_M = (dcsC405ErrFL2 & {(1){~(CPM_c405SyncBypass)}} ) | (PLB_dcsErr & {(1){CPM_c405SyncBypass}} ); 

   // Replacing instantiation: INVERT inv_DCS_c405Err1
   assign inv_DCS_c405Err1_N = ~(mux_DCS_c405Err_M);

   // Replacing instantiation: INVERT inv_DCS_c405Err2
   assign DCS_c405Err = ~(inv_DCS_c405Err1_N);


//*******************************//
//* FAST LOGIC DOMAIN DATA FLOW *//
//*******************************//

// Load Fast Latches for C405 Request
assign loadRequestF = ~dcsC405AddrAckFL2 & ~busyForReqFL2 &
                      (C405_dcsDcuRNW | ~busyForDataFL2);
// Use resetSL2 to insure that on reset request is not dropped before abort
//      is raised. Using resetSL2 insures interlock with slow clock.
assign dcsReqFHold = dcsRequestFL2 & ~dcsAddrAckSChop & ~dcsC405AddrAckFL2 &
                        ~resetSL2;

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsABusFast
   reg [0:31] dp_regDCU_dcsABusFast_regL2;
   wire [0:31] dp_regDCU_dcsABusFast_D; 
   wire dp_regDCU_dcsABusFast_E1; 
   wire dp_regDCU_dcsABusFast_E2; 
   assign dcsABusFL2[0:31] = dp_regDCU_dcsABusFast_regL2;     	
   assign dp_regDCU_dcsABusFast_E1 = dcuSyncGlobalE1_wRequest;     
   assign dp_regDCU_dcsABusFast_E2 = loadRequestF;     
   assign dp_regDCU_dcsABusFast_D = C405_dcsDcuABus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsABusFast_E1 & dp_regDCU_dcsABusFast_E2)		
     1'b0: dp_regDCU_dcsABusFast_regL2 <= dp_regDCU_dcsABusFast_regL2;		
     1'b1: dp_regDCU_dcsABusFast_regL2 <= dp_regDCU_dcsABusFast_D;		
      default: dp_regDCU_dcsABusFast_regL2 <= 32'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsCtlFast
   reg [0:7] dp_regDCU_dcsCtlFast_regL2;
   wire [0:7] dp_regDCU_dcsCtlFast_D; 
   wire dp_regDCU_dcsCtlFast_E1; 
   wire dp_regDCU_dcsCtlFast_E2; 
   assign {dcsRNWFL2,dcsSize2FL2,dcsCacheableFL2,dcsWriteThruFL2,
            dcsU0AttrFL2,dcsGuardedFL2,dcsPriorityFL2[0:1]} = dp_regDCU_dcsCtlFast_regL2;assign dp_regDCU_dcsCtlFast_E1 = dcuSyncGlobalE1_wRequest;     
   assign dp_regDCU_dcsCtlFast_E2 = loadRequestF;     
   assign dp_regDCU_dcsCtlFast_D = {C405_dcsDcuRNW,C405_dcsDcuSize2,
               C405_dcsDcuCacheable,C405_dcsDcuWriteThru, C405_dcsDcuU0Attr,
               C405_dcsDcuGuarded,C405_dcsDcuPriority[0:1]};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsCtlFast_E1 & dp_regDCU_dcsCtlFast_E2)		
     1'b0: dp_regDCU_dcsCtlFast_regL2 <= dp_regDCU_dcsCtlFast_regL2;		
     1'b1: dp_regDCU_dcsCtlFast_regL2 <= dp_regDCU_dcsCtlFast_D;		
      default: dp_regDCU_dcsCtlFast_regL2 <= 8'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsBEFast
   reg [0:7] dp_regDCU_dcsBEFast_regL2;
   wire [0:7] dp_regDCU_dcsBEFast_D; 
   wire dp_regDCU_dcsBEFast_E1; 
   wire dp_regDCU_dcsBEFast_E2; 
   assign dcsBEFL2[0:7] = dp_regDCU_dcsBEFast_regL2;     	
   assign dp_regDCU_dcsBEFast_E1 = dcuSyncGlobalE1_wRequest;     
   assign dp_regDCU_dcsBEFast_E2 = loadRequestF;     
   assign dp_regDCU_dcsBEFast_D = C405_dcsDcuBE[0:7];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsBEFast_E1 & dp_regDCU_dcsBEFast_E2)		
     1'b0: dp_regDCU_dcsBEFast_regL2 <= dp_regDCU_dcsBEFast_regL2;		
     1'b1: dp_regDCU_dcsBEFast_regL2 <= dp_regDCU_dcsBEFast_D;		
      default: dp_regDCU_dcsBEFast_regL2 <= 8'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_dcsRequestFast
   reg dp_regDCU_dcsRequestFast_regL2;
   reg dp_regDCU_dcsRequestFast_DataIn;
   wire dp_regDCU_dcsRequestFast_D0,dp_regDCU_dcsRequestFast_D1; 
   wire dp_regDCU_dcsRequestFast_SD; 
   wire dp_regDCU_dcsRequestFast_E1; 
   assign dcsRequestFL2 = dp_regDCU_dcsRequestFast_regL2;     	
   assign dp_regDCU_dcsRequestFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsRequestFast_SD = loadRequestF;    	
   assign dp_regDCU_dcsRequestFast_D0 = dcsReqFHold;    	
   assign dp_regDCU_dcsRequestFast_D1 = C405_dcsDcuRequest;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_dcsRequestFast_D0 or dp_regDCU_dcsRequestFast_D1 or dp_regDCU_dcsRequestFast_SD)  	
    begin				  	
    casez(dp_regDCU_dcsRequestFast_SD)			
     1'b0: dp_regDCU_dcsRequestFast_DataIn = dp_regDCU_dcsRequestFast_D0;	
     1'b1: dp_regDCU_dcsRequestFast_DataIn = dp_regDCU_dcsRequestFast_D1;	
      default: dp_regDCU_dcsRequestFast_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsRequestFast_E1)			
     1'b0: dp_regDCU_dcsRequestFast_regL2 <= dp_regDCU_dcsRequestFast_regL2;		
     1'b1: dp_regDCU_dcsRequestFast_regL2 <= dp_regDCU_dcsRequestFast_DataIn;	
      default: dp_regDCU_dcsRequestFast_regL2 <= 1'bx;  
    endcase		 		
   end			 		


// Load Fast Write Data Registers
// Four registers are used to buffer data from core
// !!!!!!!!!!!!!CONTROL LOGIC
assign loadDcsWrDBus1 = (C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                        ~busyForDataFL2);
assign loadDcsWrDBus2 = (writeCountFL2[0:1] == 2'b01);
assign loadDcsWrDBus3 = (writeCountFL2[0:1] == 2'b10);
assign loadDcsWrDBus4 = (writeCountFL2[0:1] == 2'b11);

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast1a
   reg [0:31] dp_regDCU_dcsWrDBusFast1a_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast1a_D; 
   wire dp_regDCU_dcsWrDBusFast1a_E1; 
   wire dp_regDCU_dcsWrDBusFast1a_E2; 
   assign dcsWrDBus1FL2[0:31] = dp_regDCU_dcsWrDBusFast1a_regL2;     	
   assign dp_regDCU_dcsWrDBusFast1a_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast1a_E2 = loadDcsWrDBus1;     
   assign dp_regDCU_dcsWrDBusFast1a_D = C405_dcsDcuWrDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast1a_E1 & dp_regDCU_dcsWrDBusFast1a_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast1a_regL2 <= dp_regDCU_dcsWrDBusFast1a_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast1a_regL2 <= dp_regDCU_dcsWrDBusFast1a_D;		
      default: dp_regDCU_dcsWrDBusFast1a_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast1b
   reg [0:31] dp_regDCU_dcsWrDBusFast1b_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast1b_D; 
   wire dp_regDCU_dcsWrDBusFast1b_E1; 
   wire dp_regDCU_dcsWrDBusFast1b_E2; 
   assign dcsWrDBus1FL2[32:63] = dp_regDCU_dcsWrDBusFast1b_regL2;     	
   assign dp_regDCU_dcsWrDBusFast1b_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast1b_E2 = loadDcsWrDBus1;     
   assign dp_regDCU_dcsWrDBusFast1b_D = C405_dcsDcuWrDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast1b_E1 & dp_regDCU_dcsWrDBusFast1b_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast1b_regL2 <= dp_regDCU_dcsWrDBusFast1b_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast1b_regL2 <= dp_regDCU_dcsWrDBusFast1b_D;		
      default: dp_regDCU_dcsWrDBusFast1b_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast2a
   reg [0:31] dp_regDCU_dcsWrDBusFast2a_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast2a_D; 
   wire dp_regDCU_dcsWrDBusFast2a_E1; 
   wire dp_regDCU_dcsWrDBusFast2a_E2; 
   assign dcsWrDBus2FL2[0:31] = dp_regDCU_dcsWrDBusFast2a_regL2;     	
   assign dp_regDCU_dcsWrDBusFast2a_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast2a_E2 = loadDcsWrDBus2;     
   assign dp_regDCU_dcsWrDBusFast2a_D = C405_dcsDcuWrDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast2a_E1 & dp_regDCU_dcsWrDBusFast2a_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast2a_regL2 <= dp_regDCU_dcsWrDBusFast2a_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast2a_regL2 <= dp_regDCU_dcsWrDBusFast2a_D;		
      default: dp_regDCU_dcsWrDBusFast2a_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast2b
   reg [0:31] dp_regDCU_dcsWrDBusFast2b_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast2b_D; 
   wire dp_regDCU_dcsWrDBusFast2b_E1; 
   wire dp_regDCU_dcsWrDBusFast2b_E2; 
   assign dcsWrDBus2FL2[32:63] = dp_regDCU_dcsWrDBusFast2b_regL2;     	
   assign dp_regDCU_dcsWrDBusFast2b_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast2b_E2 = loadDcsWrDBus2;     
   assign dp_regDCU_dcsWrDBusFast2b_D = C405_dcsDcuWrDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast2b_E1 & dp_regDCU_dcsWrDBusFast2b_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast2b_regL2 <= dp_regDCU_dcsWrDBusFast2b_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast2b_regL2 <= dp_regDCU_dcsWrDBusFast2b_D;		
      default: dp_regDCU_dcsWrDBusFast2b_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast3a
   reg [0:31] dp_regDCU_dcsWrDBusFast3a_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast3a_D; 
   wire dp_regDCU_dcsWrDBusFast3a_E1; 
   wire dp_regDCU_dcsWrDBusFast3a_E2; 
   assign dcsWrDBus3FL2[0:31] = dp_regDCU_dcsWrDBusFast3a_regL2;     	
   assign dp_regDCU_dcsWrDBusFast3a_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast3a_E2 = loadDcsWrDBus3;     
   assign dp_regDCU_dcsWrDBusFast3a_D = C405_dcsDcuWrDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast3a_E1 & dp_regDCU_dcsWrDBusFast3a_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast3a_regL2 <= dp_regDCU_dcsWrDBusFast3a_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast3a_regL2 <= dp_regDCU_dcsWrDBusFast3a_D;		
      default: dp_regDCU_dcsWrDBusFast3a_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast3b
   reg [0:31] dp_regDCU_dcsWrDBusFast3b_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast3b_D; 
   wire dp_regDCU_dcsWrDBusFast3b_E1; 
   wire dp_regDCU_dcsWrDBusFast3b_E2; 
   assign dcsWrDBus3FL2[32:63] = dp_regDCU_dcsWrDBusFast3b_regL2;     	
   assign dp_regDCU_dcsWrDBusFast3b_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast3b_E2 = loadDcsWrDBus3;     
   assign dp_regDCU_dcsWrDBusFast3b_D = C405_dcsDcuWrDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast3b_E1 & dp_regDCU_dcsWrDBusFast3b_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast3b_regL2 <= dp_regDCU_dcsWrDBusFast3b_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast3b_regL2 <= dp_regDCU_dcsWrDBusFast3b_D;		
      default: dp_regDCU_dcsWrDBusFast3b_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast4a
   reg [0:31] dp_regDCU_dcsWrDBusFast4a_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast4a_D; 
   wire dp_regDCU_dcsWrDBusFast4a_E1; 
   wire dp_regDCU_dcsWrDBusFast4a_E2; 
   assign dcsWrDBus4FL2[0:31] = dp_regDCU_dcsWrDBusFast4a_regL2;     	
   assign dp_regDCU_dcsWrDBusFast4a_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast4a_E2 = loadDcsWrDBus4;     
   assign dp_regDCU_dcsWrDBusFast4a_D = C405_dcsDcuWrDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast4a_E1 & dp_regDCU_dcsWrDBusFast4a_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast4a_regL2 <= dp_regDCU_dcsWrDBusFast4a_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast4a_regL2 <= dp_regDCU_dcsWrDBusFast4a_D;		
      default: dp_regDCU_dcsWrDBusFast4a_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusFast4b
   reg [0:31] dp_regDCU_dcsWrDBusFast4b_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusFast4b_D; 
   wire dp_regDCU_dcsWrDBusFast4b_E1; 
   wire dp_regDCU_dcsWrDBusFast4b_E2; 
   assign dcsWrDBus4FL2[32:63] = dp_regDCU_dcsWrDBusFast4b_regL2;     	
   assign dp_regDCU_dcsWrDBusFast4b_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWrDBusFast4b_E2 = loadDcsWrDBus4;     
   assign dp_regDCU_dcsWrDBusFast4b_D = C405_dcsDcuWrDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusFast4b_E1 & dp_regDCU_dcsWrDBusFast4b_E2)		
     1'b0: dp_regDCU_dcsWrDBusFast4b_regL2 <= dp_regDCU_dcsWrDBusFast4b_regL2;		
     1'b1: dp_regDCU_dcsWrDBusFast4b_regL2 <= dp_regDCU_dcsWrDBusFast4b_D;		
      default: dp_regDCU_dcsWrDBusFast4b_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsAbortFast
   reg dp_regDCU_dcsAbortFast_regL2;
   wire dp_regDCU_dcsAbortFast_D; 
   wire dp_regDCU_dcsAbortFast_E1; 
   assign dcsAbortFL2 = dp_regDCU_dcsAbortFast_regL2;     	
   assign dp_regDCU_dcsAbortFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsAbortFast_D = C405_dcsDcuAbort;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsAbortFast_E1)	                
     1'b0: dp_regDCU_dcsAbortFast_regL2 <= dp_regDCU_dcsAbortFast_regL2;		
     1'b1: dp_regDCU_dcsAbortFast_regL2 <= dp_regDCU_dcsAbortFast_D;		
      default: dp_regDCU_dcsAbortFast_regL2 <= 1'bx;  
    endcase		 		
   end			 		


// Fast latch signal from the PLB
// Inputs into the C405
assign dcsAddrAckSChop = dcsAddrAckSL2 & sample;
assign dcsRdDAckSChop = dcsRdDAckSL2 & sample;
assign dcsErrSChop = dcsErrSL2 & sample;

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsStatusFast1
   reg [0:5] dp_regDCU_dcsStatusFast1_regL2;
   wire [0:5] dp_regDCU_dcsStatusFast1_D; 
   wire dp_regDCU_dcsStatusFast1_E1; 
   assign {dcsC405RdDAckFL2,dcsC405RdWdAddrFL2[1:3],dcsC405BusyFL2,dcsC405ErrFL2} = dp_regDCU_dcsStatusFast1_regL2;     	
   assign dp_regDCU_dcsStatusFast1_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsStatusFast1_D = ({dcsRdDAckSChop,dcsRdWdAddrSL2[1:3],(dcsBusySL2 | resetFL2),dcsErrSChop});       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsStatusFast1_E1)	                
     1'b0: dp_regDCU_dcsStatusFast1_regL2 <= dp_regDCU_dcsStatusFast1_regL2;		
     1'b1: dp_regDCU_dcsStatusFast1_regL2 <= dp_regDCU_dcsStatusFast1_D;		
      default: dp_regDCU_dcsStatusFast1_regL2 <= 6'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsRdDBusFast1
   reg [0:31] dp_regDCU_dcsRdDBusFast1_regL2;
   wire [0:31] dp_regDCU_dcsRdDBusFast1_D; 
   wire dp_regDCU_dcsRdDBusFast1_E1; 
   assign dcsC405RdDBusFL2[0:31] = dp_regDCU_dcsRdDBusFast1_regL2;     	
   assign dp_regDCU_dcsRdDBusFast1_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsRdDBusFast1_D = dcsRdDBusSL2[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsRdDBusFast1_E1)	                
     1'b0: dp_regDCU_dcsRdDBusFast1_regL2 <= dp_regDCU_dcsRdDBusFast1_regL2;		
     1'b1: dp_regDCU_dcsRdDBusFast1_regL2 <= dp_regDCU_dcsRdDBusFast1_D;		
      default: dp_regDCU_dcsRdDBusFast1_regL2 <= 32'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsRdDBusFast2
   reg [0:31] dp_regDCU_dcsRdDBusFast2_regL2;
   wire [0:31] dp_regDCU_dcsRdDBusFast2_D; 
   wire dp_regDCU_dcsRdDBusFast2_E1; 
   assign dcsC405RdDBusFL2[32:63] = dp_regDCU_dcsRdDBusFast2_regL2;     	
   assign dp_regDCU_dcsRdDBusFast2_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsRdDBusFast2_D = dcsRdDBusSL2[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsRdDBusFast2_E1)	                
     1'b0: dp_regDCU_dcsRdDBusFast2_regL2 <= dp_regDCU_dcsRdDBusFast2_regL2;		
     1'b1: dp_regDCU_dcsRdDBusFast2_regL2 <= dp_regDCU_dcsRdDBusFast2_D;		
      default: dp_regDCU_dcsRdDBusFast2_regL2 <= 32'bx;  
    endcase		 		
   end			 		




assign dcsC405BusyF = dcsC405BusyFL2 | busyForDataFL2;

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsStatusFast2
   reg [0:1] dp_regDCU_dcsStatusFast2_regL2;
   wire [0:1] dp_regDCU_dcsStatusFast2_D; 
   wire dp_regDCU_dcsStatusFast2_E1; 
   assign {dcsC405AddrAckFL2,dcsC405SSize1FL2} = dp_regDCU_dcsStatusFast2_regL2;     	
   assign dp_regDCU_dcsStatusFast2_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsStatusFast2_D = {dcsAddrAckSChop,dcsSSize1SL2};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsStatusFast2_E1)	                
     1'b0: dp_regDCU_dcsStatusFast2_regL2 <= dp_regDCU_dcsStatusFast2_regL2;		
     1'b1: dp_regDCU_dcsStatusFast2_regL2 <= dp_regDCU_dcsStatusFast2_D;		
      default: dp_regDCU_dcsStatusFast2_regL2 <= 2'bx;  
    endcase		 		
   end			 		



//*******************************//
//* SLOW LOGIC DOMAIN DATA FLOW *//
//*******************************//

// Loading Slow clock register for a request to the PLB.
// The outputs of these registers are presented directly to the PLB
// gold.od7 add ~dcsC405AddrAckFL2 to block repeat of same request in 1:1 mode
assign dcsReqFNoAck = dcsRequestFL2 & ~PLB_dcsAddrAck & ~dcsAddrAckSL2 &
                      ~dcsC405AddrAckFL2;

// 04/02/02 -- rlg -- no inferred registered in PEPS design flow.  replaced below.

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsABusSlow
   reg [0:31] dp_regDCU_dcsABusSlow_regL2;
   wire [0:31] dp_regDCU_dcsABusSlow_D; 
   wire dp_regDCU_dcsABusSlow_E1; 
   assign dcsPLBABusSL2[0:31] = dp_regDCU_dcsABusSlow_regL2;     	
   assign dp_regDCU_dcsABusSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsABusSlow_D = dcsABusFL2[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsABusSlow_E1)	                
     1'b0: dp_regDCU_dcsABusSlow_regL2 <= dp_regDCU_dcsABusSlow_regL2;		
     1'b1: dp_regDCU_dcsABusSlow_regL2 <= dp_regDCU_dcsABusSlow_D;		
      default: dp_regDCU_dcsABusSlow_regL2 <= 32'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsBESlow
   reg [0:7] dp_regDCU_dcsBESlow_regL2;
   wire [0:7] dp_regDCU_dcsBESlow_D; 
   wire dp_regDCU_dcsBESlow_E1; 
   assign dcsPLBBESL2[0:7] = dp_regDCU_dcsBESlow_regL2;     	
   assign dp_regDCU_dcsBESlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsBESlow_D = dcsBEFL2[0:7];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsBESlow_E1)	                
     1'b0: dp_regDCU_dcsBESlow_regL2 <= dp_regDCU_dcsBESlow_regL2;		
     1'b1: dp_regDCU_dcsBESlow_regL2 <= dp_regDCU_dcsBESlow_D;		
      default: dp_regDCU_dcsBESlow_regL2 <= 8'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsCtlSlow
   reg [0:9] dp_regDCU_dcsCtlSlow_regL2;
   wire [0:9] dp_regDCU_dcsCtlSlow_D; 
   wire dp_regDCU_dcsCtlSlow_E1; 
   assign {dcsPLBRequestSL2,dcsPLBRNWSL2,dcsPLBSize2SL2,dcsPLBCacheableSL2,dcsPLBWriteThruSL2,
                               dcsPLBU0AttrSL2,dcsPLBGuardedSL2,dcsPLBPrioritySL2[0:1],dcsPLBAbortSL2} = dp_regDCU_dcsCtlSlow_regL2;     	
   assign dp_regDCU_dcsCtlSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsCtlSlow_D = ({dcsReqFNoAck,dcsRNWFL2,dcsSize2FL2,dcsCacheableFL2,dcsWriteThruFL2,
                               dcsU0AttrFL2,dcsGuardedFL2,dcsPriorityFL2[0:1],(dcsAbortFL2 | resetFL2)});       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsCtlSlow_E1)	                
     1'b0: dp_regDCU_dcsCtlSlow_regL2 <= dp_regDCU_dcsCtlSlow_regL2;		
     1'b1: dp_regDCU_dcsCtlSlow_regL2 <= dp_regDCU_dcsCtlSlow_D;		
      default: dp_regDCU_dcsCtlSlow_regL2 <= 10'bx;  
    endcase		 		
   end			 		



// Write Data
always @(nxtWrCountS or dcsWrDBus1FL2 or dcsWrDBus2FL2 or dcsWrDBus3FL2
         or dcsWrDBus4FL2 or dcsPLBWrDBusSL2)
    begin
        casez(nxtWrCountS)
            3'b000: dcsWrDBusS[0:63] = dcsWrDBus1FL2[0:63];
            3'b001: dcsWrDBusS[0:63] = {dcsPLBWrDBusSL2[32:63],
                                    dcsPLBWrDBusSL2[32:63]};
            3'b010: dcsWrDBusS[0:63] = dcsWrDBus2FL2[0:63];
            3'b011: dcsWrDBusS[0:63] = {dcsPLBWrDBusSL2[32:63],
                                    dcsPLBWrDBusSL2[32:63]};
            3'b100: dcsWrDBusS[0:63] = dcsWrDBus3FL2[0:63];
            3'b101: dcsWrDBusS[0:63] = {dcsPLBWrDBusSL2[32:63],
                                    dcsPLBWrDBusSL2[32:63]};
            3'b110: dcsWrDBusS[0:63] = dcsWrDBus4FL2[0:63];
            3'b111: dcsWrDBusS[0:63] = {dcsPLBWrDBusSL2[32:63],
                                    dcsPLBWrDBusSL2[32:63]};
            default: dcsWrDBusS[0:63] = 64'hxxxxxxxxxxxxxxxx;
        endcase
    end

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusSlow1
   reg [0:31] dp_regDCU_dcsWrDBusSlow1_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusSlow1_D; 
   wire dp_regDCU_dcsWrDBusSlow1_E1; 
   wire dp_regDCU_dcsWrDBusSlow1_E2; 
   assign dcsPLBWrDBusSL2[0:31] = dp_regDCU_dcsWrDBusSlow1_regL2;     	
   assign dp_regDCU_dcsWrDBusSlow1_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsWrDBusSlow1_E2 = loadWrDBus;     
   assign dp_regDCU_dcsWrDBusSlow1_D = dcsWrDBusS[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusSlow1_E1 & dp_regDCU_dcsWrDBusSlow1_E2)		
     1'b0: dp_regDCU_dcsWrDBusSlow1_regL2 <= dp_regDCU_dcsWrDBusSlow1_regL2;		
     1'b1: dp_regDCU_dcsWrDBusSlow1_regL2 <= dp_regDCU_dcsWrDBusSlow1_D;		
      default: dp_regDCU_dcsWrDBusSlow1_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EEL2 dp_regDCU_dcsWrDBusSlow2
   reg [0:31] dp_regDCU_dcsWrDBusSlow2_regL2;
   wire [0:31] dp_regDCU_dcsWrDBusSlow2_D; 
   wire dp_regDCU_dcsWrDBusSlow2_E1; 
   wire dp_regDCU_dcsWrDBusSlow2_E2; 
   assign dcsPLBWrDBusSL2[32:63] = dp_regDCU_dcsWrDBusSlow2_regL2;     	
   assign dp_regDCU_dcsWrDBusSlow2_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsWrDBusSlow2_E2 = loadWrDBus;     
   assign dp_regDCU_dcsWrDBusSlow2_D = dcsWrDBusS[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsWrDBusSlow2_E1 & dp_regDCU_dcsWrDBusSlow2_E2)		
     1'b0: dp_regDCU_dcsWrDBusSlow2_regL2 <= dp_regDCU_dcsWrDBusSlow2_regL2;		
     1'b1: dp_regDCU_dcsWrDBusSlow2_regL2 <= dp_regDCU_dcsWrDBusSlow2_D;		
      default: dp_regDCU_dcsWrDBusSlow2_regL2 <= 32'bx;  
    endcase		 		
   end			 		


// Slow latch signals from the PLB
   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsStatusSlow
   reg [0:7] dp_regDCU_dcsStatusSlow_regL2;
   wire [0:7] dp_regDCU_dcsStatusSlow_D; 
   wire dp_regDCU_dcsStatusSlow_E1; 
   assign {dcsAddrAckSL2,dcsSSize1SL2,dcsRdDAckSL2,
                                  dcsRdWdAddrSL2[1:3],dcsBusySL2,dcsErrSL2} = dp_regDCU_dcsStatusSlow_regL2;     	
   assign dp_regDCU_dcsStatusSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsStatusSlow_D = ({PLB_dcsAddrAck,PLB_dcsSSize1,PLB_dcsRdDAck,
                                  PLB_dcsRdWdAddr[1:3],(PLB_dcsBusy | resetSL2),PLB_dcsErr});       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsStatusSlow_E1)	                
     1'b0: dp_regDCU_dcsStatusSlow_regL2 <= dp_regDCU_dcsStatusSlow_regL2;		
     1'b1: dp_regDCU_dcsStatusSlow_regL2 <= dp_regDCU_dcsStatusSlow_D;		
      default: dp_regDCU_dcsStatusSlow_regL2 <= 8'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsRdDBusSlow1
   reg [0:31] dp_regDCU_dcsRdDBusSlow1_regL2;
   wire [0:31] dp_regDCU_dcsRdDBusSlow1_D; 
   wire dp_regDCU_dcsRdDBusSlow1_E1; 
   assign dcsRdDBusSL2[0:31] = dp_regDCU_dcsRdDBusSlow1_regL2;     	
   assign dp_regDCU_dcsRdDBusSlow1_E1 = dcuSyncGlobalE1_wRdDAckPLB;     
   assign dp_regDCU_dcsRdDBusSlow1_D = PLB_dcsRdDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsRdDBusSlow1_E1)	                
     1'b0: dp_regDCU_dcsRdDBusSlow1_regL2 <= dp_regDCU_dcsRdDBusSlow1_regL2;		
     1'b1: dp_regDCU_dcsRdDBusSlow1_regL2 <= dp_regDCU_dcsRdDBusSlow1_D;		
      default: dp_regDCU_dcsRdDBusSlow1_regL2 <= 32'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsRdDBusSlow2
   reg [0:31] dp_regDCU_dcsRdDBusSlow2_regL2;
   wire [0:31] dp_regDCU_dcsRdDBusSlow2_D; 
   wire dp_regDCU_dcsRdDBusSlow2_E1; 
   assign dcsRdDBusSL2[32:63] = dp_regDCU_dcsRdDBusSlow2_regL2;     	
   assign dp_regDCU_dcsRdDBusSlow2_E1 = dcuSyncGlobalE1_wRdDAckPLB;     
   assign dp_regDCU_dcsRdDBusSlow2_D = PLB_dcsRdDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsRdDBusSlow2_E1)	                
     1'b0: dp_regDCU_dcsRdDBusSlow2_regL2 <= dp_regDCU_dcsRdDBusSlow2_regL2;		
     1'b1: dp_regDCU_dcsRdDBusSlow2_regL2 <= dp_regDCU_dcsRdDBusSlow2_D;		
      default: dp_regDCU_dcsRdDBusSlow2_regL2 <= 32'bx;  
    endcase		 		
   end			 		




//*****************************//
//* FAST LOGIC DOMAIN CONTROL *//
//*****************************//

// 04/02/02 -- rlg -- no inferred registered in PEPS design flow.  replaced below.
   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsResetFast
   reg dp_regDCU_dcsResetFast_regL2;
   wire dp_regDCU_dcsResetFast_D; 
   wire dp_regDCU_dcsResetFast_E1; 
   assign resetFL2 = dp_regDCU_dcsResetFast_regL2;     	
   assign dp_regDCU_dcsResetFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsResetFast_D = RST_ResetCore;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsResetFast_E1)	                
     1'b0: dp_regDCU_dcsResetFast_regL2 <= dp_regDCU_dcsResetFast_regL2;		
     1'b1: dp_regDCU_dcsResetFast_regL2 <= dp_regDCU_dcsResetFast_D;		
      default: dp_regDCU_dcsResetFast_regL2 <= 1'bx;  
    endcase		 		
   end			 		


// Address Acknowledge
// For writes the DCS generates an immediate acknowledge signal and blocks
//      the acknowledge signal from the PLB.
// For reads the acknowledge signal from the PLB is allowed to propagate
//      back to the C405
assign dcsC405AddrAckF = (C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                             ~busyForDataFL2 & ~resetFL2) |  //!!!!!!!!!
                          (dcsC405AddrAckFL2 & ~busyForReqFL2);
// Write Data Acknowledge
// For writes the DCS generates an immediate acknowledge signal and blocks
//      the acknowledge signal from the PLB. Writes are always acknowledged
//      as a 64 bit slave
// The first acknowledge is generated off the request. Additional write
//      acknowledge signals are generated until the count expires
assign dcsC405WrDAckF =  (C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                             ~busyForDataFL2 & ~resetFL2) | //!!!!!!!!!!
                          (|writeCountFL2[0:1]);

assign dcsC405SSize1F = (C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                             ~busyForDataFL2 & ~resetFL2) | //!!!!!!!!!!!
                         (dcsC405SSize1FL2 & ~busyForReqFL2);

// Fast write count logic
// For writes the address acknowledge and data acknowledges are
//      generated immediately on request from C405. This logic keeps
//      track of how many write data acknowledges to return
assign  incWriteCountF = ((C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                            C405_dcsDcuSize2 & ~busyForDataFL2) |
                         (|writeCountFL2[0:1])) &
                         ~resetFL2;         //!!!!!!!!!!!!!!!!!!!!!
assign writeCountPlus1F[0:1] = writeCountFL2[0:1] + 1;

   // Replacing instantiation: PDP_P2EUL2 dp_regDCU_dcsWriteCountFast
   reg [0:1] dp_regDCU_dcsWriteCountFast_regL2;
   reg [0:1] dp_regDCU_dcsWriteCountFast_DataIn;
   wire [0:1] dp_regDCU_dcsWriteCountFast_D0,dp_regDCU_dcsWriteCountFast_D1; 
   wire dp_regDCU_dcsWriteCountFast_SD; 
   wire dp_regDCU_dcsWriteCountFast_E1; 
   assign writeCountFL2[0:1] = dp_regDCU_dcsWriteCountFast_regL2;     	
   assign dp_regDCU_dcsWriteCountFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsWriteCountFast_SD = incWriteCountF;    	
   assign dp_regDCU_dcsWriteCountFast_D0 = (writeCountFL2[0:1] & {2{~resetFL2}});    	
   assign dp_regDCU_dcsWriteCountFast_D1 = writeCountPlus1F[0:1];    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_regDCU_dcsWriteCountFast_D0 or dp_regDCU_dcsWriteCountFast_D1 or dp_regDCU_dcsWriteCountFast_SD)  	
    begin				  	
    casez(dp_regDCU_dcsWriteCountFast_SD)			
     1'b0: dp_regDCU_dcsWriteCountFast_DataIn = dp_regDCU_dcsWriteCountFast_D0;	
     1'b1: dp_regDCU_dcsWriteCountFast_DataIn = dp_regDCU_dcsWriteCountFast_D1;	
      default: dp_regDCU_dcsWriteCountFast_DataIn = 2'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsWriteCountFast_E1)			
     1'b0: dp_regDCU_dcsWriteCountFast_regL2 <= dp_regDCU_dcsWriteCountFast_regL2;		
     1'b1: dp_regDCU_dcsWriteCountFast_regL2 <= dp_regDCU_dcsWriteCountFast_DataIn;	
      default: dp_regDCU_dcsWriteCountFast_regL2 <= 2'bx;  
    endcase		 		
   end			 		



// Busy Signals
// These indicate whether the PLB is still processing a write
//      for address acknowledge and for data acknowledges
assign nxtBusyForReqF = ((C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                            ~busyForDataFL2) |
                         (busyForReqFL2 & ~dcsC405AddrAckFL2)) &
                         ~resetFL2;    //!!!!!!!!!!!!!!!!!!
assign nxtBusyForDataF = ((C405_dcsDcuRequest & ~C405_dcsDcuRNW &
                             ~busyForDataFL2) |
                          (busyForDataFL2 & ~dataDoneFL2)) &
                          ~resetFL2;   //!!!!!!!!!!!!!!!!
assign dataCompleteSChop = dataCompleteSL2 & sample;

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsBusyFast
   reg [0:2] dp_regDCU_dcsBusyFast_regL2;
   wire [0:2] dp_regDCU_dcsBusyFast_D; 
   wire dp_regDCU_dcsBusyFast_E1; 
   assign {busyForReqFL2,busyForDataFL2,dataDoneFL2} = dp_regDCU_dcsBusyFast_regL2;     	
   assign dp_regDCU_dcsBusyFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsBusyFast_D = {nxtBusyForReqF,nxtBusyForDataF,dataCompleteSChop};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsBusyFast_E1)	                
     1'b0: dp_regDCU_dcsBusyFast_regL2 <= dp_regDCU_dcsBusyFast_regL2;		
     1'b1: dp_regDCU_dcsBusyFast_regL2 <= dp_regDCU_dcsBusyFast_D;		
      default: dp_regDCU_dcsBusyFast_regL2 <= 3'bx;  
    endcase		 		
   end			 		



// Sample. Used to chop signals from the slow clock to the fast clock
assign sample = slowEdgeSL2 ^ slowEdgeFL2;

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsSampleEdgeFast
   reg dp_regDCU_dcsSampleEdgeFast_regL2;
   wire dp_regDCU_dcsSampleEdgeFast_D; 
   wire dp_regDCU_dcsSampleEdgeFast_E1; 
   assign slowEdgeFL2 = dp_regDCU_dcsSampleEdgeFast_regL2;     	
   assign dp_regDCU_dcsSampleEdgeFast_E1 = dcuSyncGlobalE1;     
   assign dp_regDCU_dcsSampleEdgeFast_D = slowEdgeSL2;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_regDCU_dcsSampleEdgeFast_E1)	                
     1'b0: dp_regDCU_dcsSampleEdgeFast_regL2 <= dp_regDCU_dcsSampleEdgeFast_regL2;		
     1'b1: dp_regDCU_dcsSampleEdgeFast_regL2 <= dp_regDCU_dcsSampleEdgeFast_D;		
      default: dp_regDCU_dcsSampleEdgeFast_regL2 <= 1'bx;  
    endcase		 		
   end			 		




//*****************************//
//* SLOW LOGIC DOMAIN CONTROL *//
//*****************************//


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsResetSlow
   reg dp_regDCU_dcsResetSlow_regL2;
   wire dp_regDCU_dcsResetSlow_D; 
   wire dp_regDCU_dcsResetSlow_E1; 
   assign resetSL2 = dp_regDCU_dcsResetSlow_regL2;     	
   assign dp_regDCU_dcsResetSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsResetSlow_D = resetFL2;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsResetSlow_E1)	                
     1'b0: dp_regDCU_dcsResetSlow_regL2 <= dp_regDCU_dcsResetSlow_regL2;		
     1'b1: dp_regDCU_dcsResetSlow_regL2 <= dp_regDCU_dcsResetSlow_D;		
      default: dp_regDCU_dcsResetSlow_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsSampleEdgeSlow
   reg dp_regDCU_dcsSampleEdgeSlow_regL2;
   wire dp_regDCU_dcsSampleEdgeSlow_D; 
   wire dp_regDCU_dcsSampleEdgeSlow_E1; 
   assign slowEdgeSL2 = dp_regDCU_dcsSampleEdgeSlow_regL2;     	
   assign dp_regDCU_dcsSampleEdgeSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsSampleEdgeSlow_D = (~slowEdgeSL2 & ~resetSL2);       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsSampleEdgeSlow_E1)	                
     1'b0: dp_regDCU_dcsSampleEdgeSlow_regL2 <= dp_regDCU_dcsSampleEdgeSlow_regL2;		
     1'b1: dp_regDCU_dcsSampleEdgeSlow_regL2 <= dp_regDCU_dcsSampleEdgeSlow_D;		
      default: dp_regDCU_dcsSampleEdgeSlow_regL2 <= 1'bx;  
    endcase		 		
   end			 		


// Write State
// Single bit used to determine if the DCS slow logic is processing a write
//      request. Write requests are hand shacked entirely by slow clock logic
//      in the DCS.
assign nxtWrState = ((dcsPLBRequestSL2 & ~dcsPLBRNWSL2 & PLB_dcsAddrAck) |
                      wrStateSL2)
                    & ~dataDoneS & ~resetSL2;
assign nxtPlbSSize1S = ((dcsPLBRequestSL2 & ~dcsPLBRNWSL2 & PLB_dcsAddrAck &
                          PLB_dcsSSize1) |
                      plbSSize1SL2 & ~resetSL2) //!!!!!!!!!!!!!!!!!!!
                    & ~dataDoneS;
assign nxtWrSize2S = ((dcsPLBRequestSL2 & ~dcsPLBRNWSL2 & PLB_dcsAddrAck &
                          dcsPLBSize2SL2) |
                      wrSize2SL2 & ~resetSL2)   //!!!!!!!!!!!!!!!!!
                    & ~dataDoneS;
// Sample. Slow edge will change at every rising edge of PLB clock.

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsStateSlow
   reg [0:2] dp_regDCU_dcsStateSlow_regL2;
   wire [0:2] dp_regDCU_dcsStateSlow_D; 
   wire dp_regDCU_dcsStateSlow_E1; 
   assign {wrStateSL2,plbSSize1SL2,wrSize2SL2} = dp_regDCU_dcsStateSlow_regL2;     	
   assign dp_regDCU_dcsStateSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsStateSlow_D = {nxtWrState,nxtPlbSSize1S,nxtWrSize2S};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsStateSlow_E1)	                
     1'b0: dp_regDCU_dcsStateSlow_regL2 <= dp_regDCU_dcsStateSlow_regL2;		
     1'b1: dp_regDCU_dcsStateSlow_regL2 <= dp_regDCU_dcsStateSlow_D;		
      default: dp_regDCU_dcsStateSlow_regL2 <= 3'bx;  
    endcase		 		
   end			 		


assign dataDoneS = (~wrStateSL2 & PLB_dcsAddrAck & PLB_dcsWrDAck &
                        ~dcsPLBSize2SL2) |
                   (wrStateSL2 & PLB_dcsWrDAck & (nxtWrCountS == 3'b000));

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsCompleteSlow
   reg [0:1] dp_regDCU_dcsCompleteSlow_regL2;
   wire [0:1] dp_regDCU_dcsCompleteSlow_D; 
   wire dp_regDCU_dcsCompleteSlow_E1; 
   assign {dataDoneSL2,dataCompleteSL2} = dp_regDCU_dcsCompleteSlow_regL2;     	
   assign dp_regDCU_dcsCompleteSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsCompleteSlow_D = {dataDoneS,dataDoneSL2};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsCompleteSlow_E1)	                
     1'b0: dp_regDCU_dcsCompleteSlow_regL2 <= dp_regDCU_dcsCompleteSlow_regL2;		
     1'b1: dp_regDCU_dcsCompleteSlow_regL2 <= dp_regDCU_dcsCompleteSlow_D;		
      default: dp_regDCU_dcsCompleteSlow_regL2 <= 2'bx;  
    endcase		 		
   end			 		
 

/* Write Count */
assign wrCountPlus1S[0:2] = wrCountSL2[0:2] + 1;
assign wrCountPlus2S[0:2] = wrCountSL2[0:2] + 2;
assign incWrCountS = ((~wrStateSL2 & dcsPLBSize2SL2 & PLB_dcsWrDAck) |
                    (wrStateSL2 & PLB_dcsWrDAck & wrSize2SL2)) &
                    ~resetSL2;    //!!!!!!!!!!!!!!!!!!!!!!!
assign wrCountIncSelS = (~wrStateSL2 & PLB_dcsSSize1) |
                       (wrStateSL2 & plbSSize1SL2);
always @(incWrCountS or wrCountIncSelS or wrCountSL2 or wrCountPlus1S or
         wrCountPlus2S or resetSL2)
    begin
        casez({incWrCountS,wrCountIncSelS})
            2'b0?: nxtWrCountS[0:2] = wrCountSL2[0:2] & {3{~resetSL2}};
                                        //!!!!!!!!!!!!!!!!!!!!!!1
            2'b10: nxtWrCountS[0:2] = wrCountPlus1S[0:2];
            2'b11: nxtWrCountS[0:2] = wrCountPlus2S[0:2];
            default: nxtWrCountS[0:2] = 3'bxxx;
        endcase
    end

   // Replacing instantiation: PDP_P1EUL2 dp_regDCU_dcsWrCountSlow
   reg [0:2] dp_regDCU_dcsWrCountSlow_regL2;
   wire [0:2] dp_regDCU_dcsWrCountSlow_D; 
   wire dp_regDCU_dcsWrCountSlow_E1; 
   assign wrCountSL2[0:2] = dp_regDCU_dcsWrCountSlow_regL2;     	
   assign dp_regDCU_dcsWrCountSlow_E1 = dcuSyncGlobalE1S;     
   assign dp_regDCU_dcsWrCountSlow_D = nxtWrCountS[0:2];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge EXT_sysclkPLB)  	
    begin				  	
    casez(dp_regDCU_dcsWrCountSlow_E1)	                
     1'b0: dp_regDCU_dcsWrCountSlow_regL2 <= dp_regDCU_dcsWrCountSlow_regL2;		
     1'b1: dp_regDCU_dcsWrCountSlow_regL2 <= dp_regDCU_dcsWrCountSlow_D;		
      default: dp_regDCU_dcsWrCountSlow_regL2 <= 3'bx;  
    endcase		 		
   end			 		


assign loadWrDBus = PLB_dcsWrDAck | (wrCountSL2 == 3'b000);

endmodule
