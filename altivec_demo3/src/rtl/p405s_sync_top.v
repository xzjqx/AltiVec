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
module p405s_sync_top(ICS_plbABus, ICS_plbAbort, ICS_plbCacheable,
                ICS_plbRequest, ICS_plbTranSize,
                ICS_plbU0Attr, ICS_plbPriority,

                ICS_c405AddrAck, ICS_c405IcuBusy, ICS_c405Error,
                ICS_c405RdDAck, ICS_c405DBus,

                ICS_c405RdWrAddr, ICS_c405SSize,


                C405_icsABus, C405_icsAbort, C405_icsCacheable,
                C405_icsRequest, C405_icsTranSize,
                C405_icsU0Attr, C405_icsPriority,

                PLB_icsAddrAck, PLB_icsIcuBusy, PLB_icsError,
                PLB_icsRdDAck, PLB_icsDBus,
                PLB_icsRdWrAddr, PLB_icsSSize,

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


output          ICS_plbAbort;
output          ICS_plbCacheable;
output          ICS_plbRequest;
output          ICS_plbU0Attr;
output  [0:1]   ICS_plbPriority;
output  [0:29]  ICS_plbABus;
output  [2:3]   ICS_plbTranSize;

output          ICS_c405AddrAck;
output          ICS_c405IcuBusy;
output          ICS_c405RdDAck;
output          ICS_c405Error, ICS_c405SSize;
output  [1:3]   ICS_c405RdWrAddr;
output  [0:63]  ICS_c405DBus;

input           C405_icsAbort;
input           C405_icsCacheable;
input           C405_icsRequest;
input           C405_icsU0Attr;
input   [0:1]   C405_icsPriority;
input   [0:29]  C405_icsABus;
input   [2:3]   C405_icsTranSize;


input           PLB_icsAddrAck;
input           PLB_icsIcuBusy;
input           PLB_icsRdDAck;
input           PLB_icsError;
input           PLB_icsSSize;
input   [1:3]   PLB_icsRdWrAddr;
input   [0:63]  PLB_icsDBus;

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
input           CB;
input           RST_ResetCore;


//////////////////////////
//  Interconnect WIRES  //
//////////////////////////

// DCU Sync
//------------------------------------------------------------

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

wire            DCS_c405AddrAck;
wire            DCS_c405SSize1;
wire            DCS_c405RdDAck;
wire    [0:63]  DCS_c405RdDBus;
wire    [1:3]   DCS_c405RdWdAddr;
wire            DCS_c405WrDAck;
wire            DCS_c405Busy;
wire            DCS_c405Err;

wire            C405_dcsDcuRequest;
wire            C405_dcsDcuRNW;
wire    [0:31]  C405_dcsDcuABus;
wire            C405_dcsDcuSize2;
wire            C405_dcsDcuCacheable;
wire            C405_dcsDcuWriteThru;
wire            C405_dcsDcuU0Attr;
wire            C405_dcsDcuGuarded;
wire    [0:7]   C405_dcsDcuBE;
wire    [0:1]   C405_dcsDcuPriority;

// ICU Sync
//------------------------------------------------------------

wire    [0:29]  ICS_plbABus;
wire            ICS_plbAbort;
wire            ICS_plbCacheable;
wire            ICS_plbRequest;
wire    [2:3]   ICS_plbTranSize;
wire            ICS_plbU0Attr;
wire    [0:1]   ICS_plbPriority;
wire            ICS_c405AddrAck;
wire            ICS_c405IcuBusy;
wire            ICS_c405Error;
wire            ICS_c405RdDAck;
wire    [0:63]  ICS_c405DBus;
wire    [1:3]   ICS_c405RdWrAddr;
wire            ICS_c405SSize;
wire    [0:29]  C405_icsABus;
wire            C405_icsAbort;
wire            C405_icsCacheable;
wire            C405_icsRequest;
wire    [2:3]   C405_icsTranSize;
wire            C405_icsU0Attr;
wire    [0:1]   C405_icsPriority;
wire            PLB_icsAddrAck;
wire            PLB_icsIcuBusy;
wire            PLB_icsError;
wire            PLB_icsRdDAck;
wire    [0:63]  PLB_icsDBus;
wire    [1:3]   PLB_icsRdWrAddr;
wire            PLB_icsSSize;

wire            CPM_c405SyncBypass;
wire            EXT_sysclkPLB;
wire            RST_ResetCore;

p405s_icu_sync
 icuSync(
    .ICS_plbABus                (ICS_plbABus),
    .ICS_plbAbort               (ICS_plbAbort),
    .ICS_plbCacheable           (ICS_plbCacheable),
    .ICS_plbRequest             (ICS_plbRequest),
    .ICS_plbTranSize            (ICS_plbTranSize),
    .ICS_plbU0Attr              (ICS_plbU0Attr),
    .ICS_plbPriority            (ICS_plbPriority),

    .ICS_c405AddrAck            (ICS_c405AddrAck),
    .ICS_c405IcuBusy            (ICS_c405IcuBusy),
    .ICS_c405Error              (ICS_c405Error),
    .ICS_c405RdDAck             (ICS_c405RdDAck),
    .ICS_c405DBus               (ICS_c405DBus),

    .ICS_c405RdWrAddr           (ICS_c405RdWrAddr),
    .ICS_c405SSize              (ICS_c405SSize),


    .C405_icsABus               (C405_icsABus),
    .C405_icsAbort              (C405_icsAbort),
    .C405_icsCacheable          (C405_icsCacheable),
    .C405_icsRequest            (C405_icsRequest),
    .C405_icsTranSize           (C405_icsTranSize[2:3]),
    .C405_icsU0Attr             (C405_icsU0Attr),
    .C405_icsPriority           (C405_icsPriority),

    .PLB_icsAddrAck             (PLB_icsAddrAck),
    .PLB_icsIcuBusy             (PLB_icsIcuBusy),
    .PLB_icsError               (PLB_icsError),
    .PLB_icsRdDAck              (PLB_icsRdDAck),
    .PLB_icsDBus                (PLB_icsDBus),
    .PLB_icsRdWrAddr            (PLB_icsRdWrAddr[1:3]),
    .PLB_icsSSize               (PLB_icsSSize),

    .bypass                     (CPM_c405SyncBypass),
    .sc                         (EXT_sysclkPLB),
    .CB                         (CB),
    .reset                      (RST_ResetCore)
    );

p405s_dcu_sync
 dcuSync (
    .DCS_plbRequest             (DCS_plbRequest),
    .DCS_plbRNW                 (DCS_plbRNW),
    .DCS_plbABus                (DCS_plbABus),
    .DCS_plbSize2               (DCS_plbSize2),
    .DCS_plbCacheable           (DCS_plbCacheable),
    .DCS_plbWriteThru           (DCS_plbWriteThru),
    .DCS_plbU0Attr              (DCS_plbU0Attr),
    .DCS_plbGuarded             (DCS_plbGuarded),
    .DCS_plbBE                  (DCS_plbBE),
    .DCS_plbPriority            (DCS_plbPriority),
    .DCS_plbAbort               (DCS_plbAbort),
    .DCS_plbWrDBus              (DCS_plbWrDBus),

    .DCS_c405AddrAck            (DCS_c405AddrAck),
    .DCS_c405SSize1             (DCS_c405SSize1),
    .DCS_c405RdDAck             (DCS_c405RdDAck),
    .DCS_c405RdDBus             (DCS_c405RdDBus),
    .DCS_c405RdWdAddr           (DCS_c405RdWdAddr[1:3]),
    .DCS_c405WrDAck             (DCS_c405WrDAck),
    .DCS_c405Busy               (DCS_c405Busy),
    .DCS_c405Err                (DCS_c405Err),

    .C405_dcsDcuRequest         (C405_dcsDcuRequest),
    .C405_dcsDcuRNW             (C405_dcsDcuRNW),
    .C405_dcsDcuABus            (C405_dcsDcuABus),
    .C405_dcsDcuSize2           (C405_dcsDcuSize2),
    .C405_dcsDcuCacheable       (C405_dcsDcuCacheable),
    .C405_dcsDcuWriteThru       (C405_dcsDcuWriteThru),
    .C405_dcsDcuU0Attr          (C405_dcsDcuU0Attr),
    .C405_dcsDcuGuarded         (C405_dcsDcuGuarded),
    .C405_dcsDcuBE              (C405_dcsDcuBE),
    .C405_dcsDcuPriority        (C405_dcsDcuPriority),
    .C405_dcsDcuAbort           (C405_dcsDcuAbort),
    .C405_dcsDcuWrDBus          (C405_dcsDcuWrDBus),

    .PLB_dcsAddrAck             (PLB_dcsAddrAck),
    .PLB_dcsSSize1              (PLB_dcsSSize1),
    .PLB_dcsRdDAck              (PLB_dcsRdDAck),
    .PLB_dcsRdDBus              (PLB_dcsRdDBus),
    .PLB_dcsRdWdAddr            (PLB_dcsRdWdAddr[1:3]),
    .PLB_dcsWrDAck              (PLB_dcsWrDAck),
    .PLB_dcsBusy                (PLB_dcsBusy),
    .PLB_dcsErr                 (PLB_dcsErr),

    .CPM_c405SyncBypass         (CPM_c405SyncBypass),
    .EXT_sysclkPLB              (EXT_sysclkPLB),
    .CB                         (CB),
    .RST_ResetCore              (RST_ResetCore)
    );

endmodule
