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

module p405s_icu_sync(ICS_plbABus, ICS_plbAbort, ICS_plbCacheable,
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

                bypass,
                sc, CB, reset
               );


parameter   reqSM0 = 4'b1000 ;
parameter   reqSM1 = 4'b0100 ;
parameter   reqSM2 = 4'b0010 ;
parameter   reqSM3 = 4'b0001 ;

parameter   abSM0 = 6'b100000;
parameter   abSM1 = 6'b010000;
parameter   abSM2 = 6'b001000;
parameter   abSM3 = 6'b000100;
parameter   abSM4 = 6'b000010;
parameter   abSM5 = 6'b000001;


// Inputs and Outputs
////////////////////////////  start I/O  ////////////////////////////////////////


output          ICS_plbAbort, ICS_plbCacheable, ICS_plbRequest ;
output          ICS_plbU0Attr ;
output[0:1]     ICS_plbPriority ;
output[0:29]    ICS_plbABus ;
output[2:3]     ICS_plbTranSize ;

input           C405_icsAbort, C405_icsCacheable, C405_icsRequest ;
input           C405_icsU0Attr ;
input[0:1]      C405_icsPriority ;
input[0:29]     C405_icsABus ;
input[2:3]      C405_icsTranSize ;


input           PLB_icsAddrAck, PLB_icsIcuBusy, PLB_icsRdDAck;
input           PLB_icsError, PLB_icsSSize;
input[1:3]      PLB_icsRdWrAddr;
input[0:63]     PLB_icsDBus ;

output          ICS_c405AddrAck, ICS_c405IcuBusy, ICS_c405RdDAck;
output          ICS_c405Error, ICS_c405SSize;
output[1:3]     ICS_c405RdWrAddr;
output[0:63]    ICS_c405DBus;

input           sc;
input           CB;
input           reset, bypass;

////////////////////////////  end I/O  //////////////////////////////////////////

// rlg - moved, for tbird, so that i could use it below
wire   fcResetL2, fcReset2L2, scResetL2;
wire   fcReqL2;
wire   PLB_icsRdDAck_S;
wire   dAckChop;

wire icuSyncGlobalE1;
wire icuSyncGlobalE1S;
wire icuSyncGlobalE1_wRequest;
wire icuSyncGlobalE1_wRdDAckPLB;
assign icuSyncGlobalE1  = fcResetL2 | ~bypass;
assign icuSyncGlobalE1S = scResetL2 | ~bypass;
assign icuSyncGlobalE1_wRequest = fcResetL2 | (~bypass & C405_icsRequest);
assign icuSyncGlobalE1_wRdDAckPLB = scResetL2 | (~bypass & PLB_icsRdDAck_S);

//////////  start isolation of inputs from logic  ///////////////////////////////

wire       C405_icsRequest_N,   C405_icsRequest_S ;
wire       C405_icsAbort_N,     C405_icsAbort_S ;
wire       C405_icsCacheable_N, C405_icsCacheable_S ;
wire       C405_icsU0Attr_N,    C405_icsU0Attr_S ;
wire[2:3]  C405_icsTranSize_N,  C405_icsTranSize_S ;
wire[0:1]  C405_icsPriority_N,  C405_icsPriority_S ;
wire[0:29] C405_icsABus_N,      C405_icsABus_S ; 

wire           PLB_icsAddrAck_N,  PLB_icsAddrAck_S ; 
wire           PLB_icsIcuBusy_N,  PLB_icsIcuBusy_S ;
wire           PLB_icsRdDAck_N;
wire           PLB_icsError_N,    PLB_icsError_S ;
wire           PLB_icsSSize_N,    PLB_icsSSize_S ;
wire[1:3]      PLB_icsRdWrAddr_N, PLB_icsRdWrAddr_S ;
wire[0:63]     PLB_icsDBus_N,     PLB_icsDBus_S ;

   // Replacing instantiation: INVERT C405_icsRequest_INV1
   assign C405_icsRequest_N = ~(C405_icsRequest);
  
   // Replacing instantiation: INVERT C405_icsRequest_INV2
   assign C405_icsRequest_S = ~(C405_icsRequest_N);

   // Replacing instantiation: INVERT C405_icsAbort_INV1
   assign C405_icsAbort_N = ~(C405_icsAbort);
  
   // Replacing instantiation: INVERT C405_icsAbort_INV2
   assign C405_icsAbort_S = ~(C405_icsAbort_N);

   // Replacing instantiation: INVERT C405_icsCacheable_INV1
   assign C405_icsCacheable_N = ~(C405_icsCacheable);
  
   // Replacing instantiation: INVERT C405_icsCacheable_INV2
   assign C405_icsCacheable_S = ~(C405_icsCacheable_N);

   // Replacing instantiation: INVERT C405_icsU0Attr_INV1
   assign C405_icsU0Attr_N = ~(C405_icsU0Attr);
  
   // Replacing instantiation: INVERT C405_icsU0Attr_INV2
   assign C405_icsU0Attr_S = ~(C405_icsU0Attr_N);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsTranSize_INV1
   assign C405_icsTranSize_N[2:3] = ~(C405_icsTranSize[2:3]);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsTranSize_INV2
   assign C405_icsTranSize_S[2:3] = ~(C405_icsTranSize_N[2:3]);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsPriority_INV1
   assign C405_icsPriority_N[0:1] = ~(C405_icsPriority[0:1]);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsPriority_INV2
   assign C405_icsPriority_S[0:1] = ~(C405_icsPriority_N[0:1]);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsABus_INV1
   assign C405_icsABus_N[0:29] = ~(C405_icsABus[0:29]);
  
   // Replacing instantiation: GS_INVERT dp_logC405_icsABus_INV2
   assign C405_icsABus_S[0:29] = ~(C405_icsABus_N[0:29]);

   // Replacing instantiation: INVERT PLB_icsAddrAck_INV1
   assign PLB_icsAddrAck_N = ~(PLB_icsAddrAck);
  
   // Replacing instantiation: INVERT PLB_icsAddrAck_INV2
   assign PLB_icsAddrAck_S = ~(PLB_icsAddrAck_N);

   // Replacing instantiation: INVERT PLB_icsIcuBusy_INV1
   assign PLB_icsIcuBusy_N = ~(PLB_icsIcuBusy);
  
   // Replacing instantiation: INVERT PLB_icsIcuBusy_INV2
   assign PLB_icsIcuBusy_S = ~(PLB_icsIcuBusy_N);
  
   // Replacing instantiation: INVERT PLB_icsRdDAck_INV1
   assign PLB_icsRdDAck_N = ~(PLB_icsRdDAck);
  
   // Replacing instantiation: INVERT PLB_icsRdDAck_INV2
   assign PLB_icsRdDAck_S = ~(PLB_icsRdDAck_N);
  
   // Replacing instantiation: INVERT PLB_icsError_INV1
   assign PLB_icsError_N = ~(PLB_icsError);
  
   // Replacing instantiation: INVERT PLB_icsError_INV2
   assign PLB_icsError_S = ~(PLB_icsError_N);
  
   // Replacing instantiation: INVERT PLB_icsSSize_INV1
   assign PLB_icsSSize_N = ~(PLB_icsSSize);
  
   // Replacing instantiation: INVERT PLB_icsSSize_INV2
   assign PLB_icsSSize_S = ~(PLB_icsSSize_N);
  
   // Replacing instantiation: GS_INVERT dp_logPLB_icsRdWrAddr_INV1
   assign PLB_icsRdWrAddr_N[1:3] = ~(PLB_icsRdWrAddr[1:3]);
  
   // Replacing instantiation: GS_INVERT dp_logPLB_icsRdWrAddr_INV2
   assign PLB_icsRdWrAddr_S[1:3] = ~(PLB_icsRdWrAddr_N[1:3]);

   // Replacing instantiation: GS_INVERT dp_logPLB_icsDBus_INV1
   assign PLB_icsDBus_N[0:63] = ~(PLB_icsDBus[0:63]);
  
   // Replacing instantiation: GS_INVERT dp_logPLB_icsDBus_INV2
   assign PLB_icsDBus_S[0:63] = ~(PLB_icsDBus_N[0:63]);
  



////////////////////////////  start Reset  logic  ///////////////////////////////

wire vdd = 1'b1;
wire gnd = 1'b0;
wire[1:3]   fcRdWdAddrL2; 
wire        fcPlbErrorL2 ;
wire[0:63]  fcPlbDBus; 
wire[1:3]   sc_fcRdWdAddrL2;
wire        sc_fcBusyL2, sc_fcPlbErrorL2 ;
wire[0:63]  sc_fcPlbDBus;
wire        scBusyL2, fcBusyL2, fcAbortL2;
wire        scAbortL2, scAbortDupL2;

wire        sc_fcAbortFdBackL2;
wire resetSuccessful = scAbortDupL2 & scResetL2 & scBusyL2 & fcBusyL2 & fcAbortL2;
wire holdReset = scAbortDupL2 | scResetL2 | scBusyL2 | fcBusyL2 | fcAbortL2;
wire fcReset2In = fcResetL2 | (fcReset2L2 & holdReset);
wire fcResetIn = reset | (fcResetL2 & ~resetSuccessful); 

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuReset
   reg [0:1] dp_fcReg_icuReset_regL2;
   wire [0:1] dp_fcReg_icuReset_D; 
   wire dp_fcReg_icuReset_E1; 
   assign {fcResetL2,fcReset2L2} = dp_fcReg_icuReset_regL2;     	
   assign dp_fcReg_icuReset_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuReset_D = {fcResetIn,fcReset2In};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuReset_E1)	                
     1'b0: dp_fcReg_icuReset_regL2 <= dp_fcReg_icuReset_regL2;		
     1'b1: dp_fcReg_icuReset_regL2 <= dp_fcReg_icuReset_D;		
      default: dp_fcReg_icuReset_regL2 <= 2'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuReset
   reg dp_scReg_icuReset_regL2;
   wire dp_scReg_icuReset_D; 
   wire dp_scReg_icuReset_E1; 
   assign scResetL2 = dp_scReg_icuReset_regL2;     	
   assign dp_scReg_icuReset_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuReset_D = fcResetL2;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuReset_E1)	                
     1'b0: dp_scReg_icuReset_regL2 <= dp_scReg_icuReset_regL2;		
     1'b1: dp_scReg_icuReset_regL2 <= dp_scReg_icuReset_D;		
      default: dp_scReg_icuReset_regL2 <= 1'bx;  
    endcase		 		
   end			 		


////////////////////////////  stop Reset logic  /////////////////////////////////


///////////////////////  start request and abort logic  /////////////////////////

wire[0:3]     reqSML2;
wire[0:5]     abSML2;
wire    scReqL2_N, scReqDupL2, scReqIn, scReqInNotAck ;
wire    sc_fcReqFdBackL2, fcchopAackL2, abEndCycle;
wire    scAackL2 ;
wire    chopAackL2, fcReqIn, scAbortIn ;
wire    fcAbortFBL2, fcAackFBL2, fcReqFBL2 ;



assign fcReqIn = (C405_icsRequest_S & C405_icsAbort_N & reqSML2[0]) |
                 (reqSML2[1] & ~scAackL2);

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuRequest
   reg dp_fcReg_icuRequest_regL2;
   wire dp_fcReg_icuRequest_D; 
   wire dp_fcReg_icuRequest_E1; 
   assign fcReqL2 = dp_fcReg_icuRequest_regL2;     	
   assign dp_fcReg_icuRequest_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuRequest_D = fcReqIn;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuRequest_E1)	                
     1'b0: dp_fcReg_icuRequest_regL2 <= dp_fcReg_icuRequest_regL2;		
     1'b1: dp_fcReg_icuRequest_regL2 <= dp_fcReg_icuRequest_D;		
      default: dp_fcReg_icuRequest_regL2 <= 1'bx;  
    endcase		 		
   end			 		


wire fcAbortIn = (C405_icsAbort_S & abSML2[1]) |
                  abSML2[2] | fcResetL2 ;

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuAbort
   reg dp_fcReg_icuAbort_regL2;
   wire dp_fcReg_icuAbort_D; 
   wire dp_fcReg_icuAbort_E1; 
   assign fcAbortL2 = dp_fcReg_icuAbort_regL2;     	
   assign dp_fcReg_icuAbort_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuAbort_D = fcAbortIn;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAbort_E1)	                
     1'b0: dp_fcReg_icuAbort_regL2 <= dp_fcReg_icuAbort_regL2;		
     1'b1: dp_fcReg_icuAbort_regL2 <= dp_fcReg_icuAbort_D;		
      default: dp_fcReg_icuAbort_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: BUFFER buf_icuRequest
   assign scReqIn = fcReqL2;

   // Replacing instantiation: BUFFER buf_icuAbort
   assign scAbortIn = fcAbortL2;


wire newscReqIn = scReqIn | scReqDupL2 ;
wire reqSD =  scAbortDupL2 | scAackL2 ;  
wire abSD = (scAbortDupL2 & ~scResetL2) | scAackL2 ;

   // Replacing instantiation: MUX21 mux_icuReqAck
   assign scReqInNotAck = (newscReqIn & ~(reqSD)) | (gnd & reqSD);


   // Replacing instantiation: PDP_P1EUL2I dp_scReg_icuRequest
   reg dp_scReg_icuRequest_regL2;
   wire dp_scReg_icuRequest_D; 
   wire dp_scReg_icuRequest_E1; 
   assign scReqL2_N = ~dp_scReg_icuRequest_regL2; 	
   assign dp_scReg_icuRequest_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuRequest_D = scReqInNotAck;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuRequest_E1)	                
     1'b0: dp_scReg_icuRequest_regL2 <= dp_scReg_icuRequest_regL2;		
     1'b1: dp_scReg_icuRequest_regL2 <= dp_scReg_icuRequest_D;		
      default: dp_scReg_icuRequest_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P2EUL2 dp_scReg_icuReqDup
   reg dp_scReg_icuReqDup_regL2;
   reg dp_scReg_icuReqDup_DataIn;
   wire dp_scReg_icuReqDup_D0,dp_scReg_icuReqDup_D1; 
   wire dp_scReg_icuReqDup_SD; 
   wire dp_scReg_icuReqDup_E1; 
   assign scReqDupL2 = dp_scReg_icuReqDup_regL2;     	
   assign dp_scReg_icuReqDup_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuReqDup_SD = reqSD;    	
   assign dp_scReg_icuReqDup_D0 = newscReqIn;    	
   assign dp_scReg_icuReqDup_D1 = 1'b0;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_scReg_icuReqDup_D0 or dp_scReg_icuReqDup_D1 or dp_scReg_icuReqDup_SD)  	
    begin				  	
    casez(dp_scReg_icuReqDup_SD)			
     1'b0: dp_scReg_icuReqDup_DataIn = dp_scReg_icuReqDup_D0;	
     1'b1: dp_scReg_icuReqDup_DataIn = dp_scReg_icuReqDup_D1;	
      default: dp_scReg_icuReqDup_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuReqDup_E1)			
     1'b0: dp_scReg_icuReqDup_regL2 <= dp_scReg_icuReqDup_regL2;		
     1'b1: dp_scReg_icuReqDup_regL2 <= dp_scReg_icuReqDup_DataIn;	
      default: dp_scReg_icuReqDup_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P2EUL2 dp_scReg_icuReqAbort
   reg [0:1] dp_scReg_icuReqAbort_regL2;
   reg [0:1] dp_scReg_icuReqAbort_DataIn;
   wire [0:1] dp_scReg_icuReqAbort_D0,dp_scReg_icuReqAbort_D1; 
   wire dp_scReg_icuReqAbort_SD; 
   wire dp_scReg_icuReqAbort_E1; 
   assign {scAbortL2,scAbortDupL2} = dp_scReg_icuReqAbort_regL2;     	
   assign dp_scReg_icuReqAbort_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuReqAbort_SD = abSD;    	
   assign dp_scReg_icuReqAbort_D0 = {2{scAbortIn}};    	
   assign dp_scReg_icuReqAbort_D1 = 2'b0;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_scReg_icuReqAbort_D0 or dp_scReg_icuReqAbort_D1 or dp_scReg_icuReqAbort_SD)  	
    begin				  	
    casez(dp_scReg_icuReqAbort_SD)			
     1'b0: dp_scReg_icuReqAbort_DataIn = dp_scReg_icuReqAbort_D0;	
     1'b1: dp_scReg_icuReqAbort_DataIn = dp_scReg_icuReqAbort_D1;	
      default: dp_scReg_icuReqAbort_DataIn = 2'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuReqAbort_E1)			
     1'b0: dp_scReg_icuReqAbort_regL2 <= dp_scReg_icuReqAbort_regL2;		
     1'b1: dp_scReg_icuReqAbort_regL2 <= dp_scReg_icuReqAbort_DataIn;	
      default: dp_scReg_icuReqAbort_regL2 <= 2'bx;  
    endcase		 		
   end			 		



wire plbRequestDup, plbAbort, plbRequest;

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuReqAbortFB
   reg [0:1] dp_fcReg_icuReqAbortFB_regL2;
   wire [0:1] dp_fcReg_icuReqAbortFB_D; 
   wire dp_fcReg_icuReqAbortFB_E1; 
   assign {fcReqFBL2,fcAbortFBL2} = dp_fcReg_icuReqAbortFB_regL2;     	
   assign dp_fcReg_icuReqAbortFB_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuReqAbortFB_D = {plbRequest,plbAbort};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuReqAbortFB_E1)	                
     1'b0: dp_fcReg_icuReqAbortFB_regL2 <= dp_fcReg_icuReqAbortFB_regL2;		
     1'b1: dp_fcReg_icuReqAbortFB_regL2 <= dp_fcReg_icuReqAbortFB_D;		
      default: dp_fcReg_icuReqAbortFB_regL2 <= 2'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: BUFFER buf_icuReqFdBk
   assign sc_fcReqFdBackL2 = fcReqFBL2;

   // Replacing instantiation: BUFFER buf_icuAbFdBk
   assign sc_fcAbortFdBackL2 = fcAbortFBL2;

   // Replacing instantiation: NOR2 reqNor
   assign plbRequest = ~( scReqL2_N | scAackL2 );


assign plbRequestDup = (~scAackL2 & scReqDupL2);

assign plbAbort = plbRequestDup & scAbortL2;


///////////////////////  stop request and abort logic  //////////////////////////
//


/////////////////////// start Address and Attributes logic  /////////////////////

wire[0:5]   scAttL2; 
wire[0:6]   fcAttL2; 
wire[0:29]  fcABusL2, scABusL2;

wire[0:6]   fcAttIn, C405_icsAtt;
wire[0:29]  fcAddIn;

assign C405_icsAtt[0:6] = {C405_icsCacheable_S, C405_icsTranSize_S[2:3],
                              C405_icsU0Attr_S, C405_icsPriority_S[0:1],
                              C405_icsTranSize_S[3]};

wire startCycle = (C405_icsRequest_S & C405_icsAbort_N & reqSML2[0]) | fcResetL2 ;

   // Replacing instantiation: MUX21 mux_fcAddIn0
   assign fcAddIn[0] = (fcABusL2[0] & ~(startCycle)) | (C405_icsABus_S[0] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn1
   assign fcAddIn[1] = (fcABusL2[1] & ~(startCycle)) | (C405_icsABus_S[1] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn2
   assign fcAddIn[2] = (fcABusL2[2] & ~(startCycle)) | (C405_icsABus_S[2] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn3
   assign fcAddIn[3] = (fcABusL2[3] & ~(startCycle)) | (C405_icsABus_S[3] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn4
   assign fcAddIn[4] = (fcABusL2[4] & ~(startCycle)) | (C405_icsABus_S[4] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn5
   assign fcAddIn[5] = (fcABusL2[5] & ~(startCycle)) | (C405_icsABus_S[5] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn6
   assign fcAddIn[6] = (fcABusL2[6] & ~(startCycle)) | (C405_icsABus_S[6] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn7
   assign fcAddIn[7] = (fcABusL2[7] & ~(startCycle)) | (C405_icsABus_S[7] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn8
   assign fcAddIn[8] = (fcABusL2[8] & ~(startCycle)) | (C405_icsABus_S[8] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn9
   assign fcAddIn[9] = (fcABusL2[9] & ~(startCycle)) | (C405_icsABus_S[9] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn10
   assign fcAddIn[10] = (fcABusL2[10] & ~(startCycle)) | (C405_icsABus_S[10] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn11
   assign fcAddIn[11] = (fcABusL2[11] & ~(startCycle)) | (C405_icsABus_S[11] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn12
   assign fcAddIn[12] = (fcABusL2[12] & ~(startCycle)) | (C405_icsABus_S[12] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn13
   assign fcAddIn[13] = (fcABusL2[13] & ~(startCycle)) | (C405_icsABus_S[13] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn14
   assign fcAddIn[14] = (fcABusL2[14] & ~(startCycle)) | (C405_icsABus_S[14] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn15
   assign fcAddIn[15] = (fcABusL2[15] & ~(startCycle)) | (C405_icsABus_S[15] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn16
   assign fcAddIn[16] = (fcABusL2[16] & ~(startCycle)) | (C405_icsABus_S[16] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn17
   assign fcAddIn[17] = (fcABusL2[17] & ~(startCycle)) | (C405_icsABus_S[17] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn18
   assign fcAddIn[18] = (fcABusL2[18] & ~(startCycle)) | (C405_icsABus_S[18] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn19
   assign fcAddIn[19] = (fcABusL2[19] & ~(startCycle)) | (C405_icsABus_S[19] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn20
   assign fcAddIn[20] = (fcABusL2[20] & ~(startCycle)) | (C405_icsABus_S[20] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn21
   assign fcAddIn[21] = (fcABusL2[21] & ~(startCycle)) | (C405_icsABus_S[21] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn22
   assign fcAddIn[22] = (fcABusL2[22] & ~(startCycle)) | (C405_icsABus_S[22] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn23
   assign fcAddIn[23] = (fcABusL2[23] & ~(startCycle)) | (C405_icsABus_S[23] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn24
   assign fcAddIn[24] = (fcABusL2[24] & ~(startCycle)) | (C405_icsABus_S[24] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn25
   assign fcAddIn[25] = (fcABusL2[25] & ~(startCycle)) | (C405_icsABus_S[25] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn26
   assign fcAddIn[26] = (fcABusL2[26] & ~(startCycle)) | (C405_icsABus_S[26] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn27
   assign fcAddIn[27] = (fcABusL2[27] & ~(startCycle)) | (C405_icsABus_S[27] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn28
   assign fcAddIn[28] = (fcABusL2[28] & ~(startCycle)) | (C405_icsABus_S[28] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAddIn29
   assign fcAddIn[29] = (fcABusL2[29] & ~(startCycle)) | (C405_icsABus_S[29] & startCycle);


//assign fcAttIn[0:6] = startCycle ? C405_icsAtt[0:6] : fcAttL2[0:6]; 
   // Replacing instantiation: MUX21 mux_fcAttIn0
   assign fcAttIn[0] = (fcAttL2[0] & ~(startCycle)) | (C405_icsAtt[0] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn1
   assign fcAttIn[1] = (fcAttL2[1] & ~(startCycle)) | (C405_icsAtt[1] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn2
   assign fcAttIn[2] = (fcAttL2[2] & ~(startCycle)) | (C405_icsAtt[2] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn3
   assign fcAttIn[3] = (fcAttL2[3] & ~(startCycle)) | (C405_icsAtt[3] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn4
   assign fcAttIn[4] = (fcAttL2[4] & ~(startCycle)) | (C405_icsAtt[4] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn5
   assign fcAttIn[5] = (fcAttL2[5] & ~(startCycle)) | (C405_icsAtt[5] & startCycle);

   // Replacing instantiation: MUX21 mux_fcAttIn6
   assign fcAttIn[6] = (fcAttL2[6] & ~(startCycle)) | (C405_icsAtt[6] & startCycle);


   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuAdd
   reg [0:29] dp_fcReg_icuAdd_regL2;
   wire [0:29] dp_fcReg_icuAdd_D; 
   wire dp_fcReg_icuAdd_E1; 
   assign fcABusL2[0:29] = dp_fcReg_icuAdd_regL2;     	
   assign dp_fcReg_icuAdd_E1 = icuSyncGlobalE1_wRequest;     
   assign dp_fcReg_icuAdd_D = fcAddIn[0:29];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAdd_E1)	                
     1'b0: dp_fcReg_icuAdd_regL2 <= dp_fcReg_icuAdd_regL2;		
     1'b1: dp_fcReg_icuAdd_regL2 <= dp_fcReg_icuAdd_D;		
      default: dp_fcReg_icuAdd_regL2 <= 30'bx;  
    endcase		 		
   end			 		



   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuAtt
   reg [0:6] dp_fcReg_icuAtt_regL2;
   wire [0:6] dp_fcReg_icuAtt_D; 
   wire dp_fcReg_icuAtt_E1; 
   assign fcAttL2[0:6] = dp_fcReg_icuAtt_regL2;     	
   assign dp_fcReg_icuAtt_E1 = icuSyncGlobalE1_wRequest;     
   assign dp_fcReg_icuAtt_D = fcAttIn[0:6];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAtt_E1)	                
     1'b0: dp_fcReg_icuAtt_regL2 <= dp_fcReg_icuAtt_regL2;		
     1'b1: dp_fcReg_icuAtt_regL2 <= dp_fcReg_icuAtt_D;		
      default: dp_fcReg_icuAtt_regL2 <= 7'bx;  
    endcase		 		
   end			 		



wire[0:29]   scABusIn;
wire[0:5]    scAttIn;

   // Replacing instantiation: BUFFER buf_scABusIn0
   assign scABusIn[0] = fcABusL2[0];

   // Replacing instantiation: BUFFER buf_scABusIn1
   assign scABusIn[1] = fcABusL2[1];

   // Replacing instantiation: BUFFER buf_scABusIn2
   assign scABusIn[2] = fcABusL2[2];

   // Replacing instantiation: BUFFER buf_scABusIn3
   assign scABusIn[3] = fcABusL2[3];

   // Replacing instantiation: BUFFER buf_scABusIn4
   assign scABusIn[4] = fcABusL2[4];

   // Replacing instantiation: BUFFER buf_scABusIn5
   assign scABusIn[5] = fcABusL2[5];

   // Replacing instantiation: BUFFER buf_scABusIn6
   assign scABusIn[6] = fcABusL2[6];

   // Replacing instantiation: BUFFER buf_scABusIn7
   assign scABusIn[7] = fcABusL2[7];

   // Replacing instantiation: BUFFER buf_scABusIn8
   assign scABusIn[8] = fcABusL2[8];

   // Replacing instantiation: BUFFER buf_scABusIn9
   assign scABusIn[9] = fcABusL2[9];

   // Replacing instantiation: BUFFER buf_scABusIn10
   assign scABusIn[10] = fcABusL2[10];

   // Replacing instantiation: BUFFER buf_scABusIn11
   assign scABusIn[11] = fcABusL2[11];

   // Replacing instantiation: BUFFER buf_scABusIn12
   assign scABusIn[12] = fcABusL2[12];

   // Replacing instantiation: BUFFER buf_scABusIn13
   assign scABusIn[13] = fcABusL2[13];

   // Replacing instantiation: BUFFER buf_scABusIn14
   assign scABusIn[14] = fcABusL2[14];

   // Replacing instantiation: BUFFER buf_scABusIn15
   assign scABusIn[15] = fcABusL2[15];

   // Replacing instantiation: BUFFER buf_scABusIn16
   assign scABusIn[16] = fcABusL2[16];

   // Replacing instantiation: BUFFER buf_scABusIn17
   assign scABusIn[17] = fcABusL2[17];

   // Replacing instantiation: BUFFER buf_scABusIn18
   assign scABusIn[18] = fcABusL2[18];

   // Replacing instantiation: BUFFER buf_scABusIn19
   assign scABusIn[19] = fcABusL2[19];

   // Replacing instantiation: BUFFER buf_scABusIn20
   assign scABusIn[20] = fcABusL2[20];

   // Replacing instantiation: BUFFER buf_scABusIn21
   assign scABusIn[21] = fcABusL2[21];

   // Replacing instantiation: BUFFER buf_scABusIn22
   assign scABusIn[22] = fcABusL2[22];

   // Replacing instantiation: BUFFER buf_scABusIn23
   assign scABusIn[23] = fcABusL2[23];

   // Replacing instantiation: BUFFER buf_scABusIn24
   assign scABusIn[24] = fcABusL2[24];

   // Replacing instantiation: BUFFER buf_scABusIn25
   assign scABusIn[25] = fcABusL2[25];

   // Replacing instantiation: BUFFER buf_scABusIn26
   assign scABusIn[26] = fcABusL2[26];

   // Replacing instantiation: BUFFER buf_scABusIn27
   assign scABusIn[27] = fcABusL2[27];

   // Replacing instantiation: BUFFER buf_scABusIn28
   assign scABusIn[28] = fcABusL2[28];

   // Replacing instantiation: BUFFER buf_scABusIn29
   assign scABusIn[29] = fcABusL2[29];

   // Replacing instantiation: BUFFER buf_scAttIn0
   assign scAttIn[0] = fcAttL2[0];

   // Replacing instantiation: BUFFER buf_scAttIn1
   assign scAttIn[1] = fcAttL2[1];

   // Replacing instantiation: BUFFER buf_scAttIn2
   assign scAttIn[2] = fcAttL2[2];

   // Replacing instantiation: BUFFER buf_scAttIn3
   assign scAttIn[3] = fcAttL2[3];

   // Replacing instantiation: BUFFER buf_scAttIn4
   assign scAttIn[4] = fcAttL2[4];

   // Replacing instantiation: BUFFER buf_scAttIn5
   assign scAttIn[5] = fcAttL2[5];

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuAdd
   reg [0:29] dp_scReg_icuAdd_regL2;
   wire [0:29] dp_scReg_icuAdd_D; 
   wire dp_scReg_icuAdd_E1; 
   assign scABusL2[0:29] = dp_scReg_icuAdd_regL2;     	
   assign dp_scReg_icuAdd_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuAdd_D = scABusIn[0:29];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuAdd_E1)	                
     1'b0: dp_scReg_icuAdd_regL2 <= dp_scReg_icuAdd_regL2;		
     1'b1: dp_scReg_icuAdd_regL2 <= dp_scReg_icuAdd_D;		
      default: dp_scReg_icuAdd_regL2 <= 30'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuAtt
   reg [0:5] dp_scReg_icuAtt_regL2;
   wire [0:5] dp_scReg_icuAtt_D; 
   wire dp_scReg_icuAtt_E1; 
   assign scAttL2[0:5] = dp_scReg_icuAtt_regL2;     	
   assign dp_scReg_icuAtt_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuAtt_D = scAttIn[0:5];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuAtt_E1)	                
     1'b0: dp_scReg_icuAtt_regL2 <= dp_scReg_icuAtt_regL2;		
     1'b1: dp_scReg_icuAtt_regL2 <= dp_scReg_icuAtt_D;		
      default: dp_scReg_icuAtt_regL2 <= 6'bx;  
    endcase		 		
   end			 		


wire fcTsize3L2 = fcAttL2[6];


/////////////////////// stop Address and Attributes logic  //////////////////////
//

// start Address ack and size----------------------------------------------------
/////////////////////// start Address ack and size  /////////////////////////////

wire   blockAack, fcAddIdL2, fcAddIdL2_N, fcc405AddrAck ;
wire   scAddIdL2, scIfScAddIdL2_N, scIfNotScAddIdL2_N;
wire   scPLBsSizeL2, scSsizeL2, c405AddrAck ;
wire   fcSsizeFdBackL2, sc_fcAackFdBackL2, fcSsizeIn ;
wire   sc_fcPLBsSizeL2, fcPLBsSizeL2;
wire scAddIdIn = scResetL2 | scAddIdL2;
wire scIfScAddIdIn = scAddIdIn & PLB_icsAddrAck_S ;
wire scIfNotScAddIdIn = ~scAddIdIn & PLB_icsAddrAck_S ;

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuStatus1
   reg [0:5] dp_scReg_icuStatus1_regL2;
   wire [0:5] dp_scReg_icuStatus1_D; 
   wire dp_scReg_icuStatus1_E1; 
   assign {scPLBsSizeL2,scSsizeL2,scAackL2,scAddIdL2,scIfScAddIdL2_N,scIfNotScAddIdL2_N} = dp_scReg_icuStatus1_regL2;     	
   assign dp_scReg_icuStatus1_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuStatus1_D = {PLB_icsSSize_S,PLB_icsSSize_S,PLB_icsAddrAck_S,~scAddIdIn,~scIfScAddIdIn,~scIfNotScAddIdIn};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuStatus1_E1)	                
     1'b0: dp_scReg_icuStatus1_regL2 <= dp_scReg_icuStatus1_regL2;		
     1'b1: dp_scReg_icuStatus1_regL2 <= dp_scReg_icuStatus1_D;		
      default: dp_scReg_icuStatus1_regL2 <= 6'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuStatus1
   reg [0:1] dp_fcReg_icuStatus1_regL2;
   wire [0:1] dp_fcReg_icuStatus1_D; 
   wire dp_fcReg_icuStatus1_E1; 
   assign {fcAddIdL2,fcAddIdL2_N} = dp_fcReg_icuStatus1_regL2;     	
   assign dp_fcReg_icuStatus1_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuStatus1_D = {scAddIdL2,~scAddIdL2};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuStatus1_E1)	                
     1'b0: dp_fcReg_icuStatus1_regL2 <= dp_fcReg_icuStatus1_regL2;		
     1'b1: dp_fcReg_icuStatus1_regL2 <= dp_fcReg_icuStatus1_D;		
      default: dp_fcReg_icuStatus1_regL2 <= 2'bx;  
    endcase		 		
   end			 		

wire icsAack = ~((fcAddIdL2_N | scIfScAddIdL2_N)&
                  (fcAddIdL2 | scIfNotScAddIdL2_N));

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuAack
   reg [0:1] dp_fcReg_icuAack_regL2;
   wire [0:1] dp_fcReg_icuAack_D; 
   wire dp_fcReg_icuAack_E1; 
   assign {fcchopAackL2,fcc405AddrAck} = dp_fcReg_icuAack_regL2;     	
   assign dp_fcReg_icuAack_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuAack_D = {icsAack,icsAack};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAack_E1)	                
     1'b0: dp_fcReg_icuAack_regL2 <= dp_fcReg_icuAack_regL2;		
     1'b1: dp_fcReg_icuAack_regL2 <= dp_fcReg_icuAack_D;		
      default: dp_fcReg_icuAack_regL2 <= 2'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: MUX21 mux_icuSsize
   assign fcSsizeIn = (fcSsizeFdBackL2 & ~(scAackL2)) | (scSsizeL2 & scAackL2);

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuSize
   reg [0:2] dp_fcReg_icuSize_regL2;
   wire [0:2] dp_fcReg_icuSize_D; 
   wire dp_fcReg_icuSize_E1; 
   assign {fcAackFBL2,fcSsizeFdBackL2,fcPLBsSizeL2} = dp_fcReg_icuSize_regL2;     	
   assign dp_fcReg_icuSize_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuSize_D = {scAackL2,fcSsizeIn,scPLBsSizeL2};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuSize_E1)	                
     1'b0: dp_fcReg_icuSize_regL2 <= dp_fcReg_icuSize_regL2;		
     1'b1: dp_fcReg_icuSize_regL2 <= dp_fcReg_icuSize_D;		
      default: dp_fcReg_icuSize_regL2 <= 3'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: BUFFER buf_icuPLBsSize
   assign sc_fcPLBsSizeL2 = fcPLBsSizeL2;

   // Replacing instantiation: BUFFER buf_icuAackFB
   assign sc_fcAackFdBackL2 = fcAackFBL2;

   // Replacing instantiation: BUFFER buf_icuchopAack
   assign chopAackL2 = fcchopAackL2;

   // Replacing instantiation: BUFFER buf_icuAddAck
   assign c405AddrAck = fcc405AddrAck;


wire ics_c405AddrAck = c405AddrAck & ~blockAack;


/////////////////////// stop Address ack and size  //////////////////////////////
//
//                                                                         Page 7


/////////////////////// start data input logic //////////////////////////////////
wire       scRdIdL2, scIfScRdIdL2_N, scIfNotScRdIdL2_N;
wire       scPlbErrorL2, chopDackL2, blockDack;
wire[1:3]  scRdWdAddrL2;
wire       fcRdIdL2, fcRdIdL2_N, c405RdDAck, fcc405RdDAck, fcchopDackL2 ;
wire[0:63] scPlbDBus;

wire scRdIdIn = scResetL2 | scRdIdL2;
wire scIfScRdIdIn = scRdIdIn & PLB_icsRdDAck_S;
wire scIfNotScRdIdIn = ~scRdIdIn & PLB_icsRdDAck_S;

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuRdId
   reg [0:2] dp_scReg_icuRdId_regL2;
   wire [0:2] dp_scReg_icuRdId_D; 
   wire dp_scReg_icuRdId_E1; 
   assign {scRdIdL2,scIfScRdIdL2_N,scIfNotScRdIdL2_N} = dp_scReg_icuRdId_regL2;     	
   assign dp_scReg_icuRdId_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuRdId_D = {~scRdIdIn,~scIfScRdIdIn,~scIfNotScRdIdIn};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuRdId_E1)	                
     1'b0: dp_scReg_icuRdId_regL2 <= dp_scReg_icuRdId_regL2;		
     1'b1: dp_scReg_icuRdId_regL2 <= dp_scReg_icuRdId_D;		
      default: dp_scReg_icuRdId_regL2 <= 3'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuRdId
   reg [0:1] dp_fcReg_icuRdId_regL2;
   wire [0:1] dp_fcReg_icuRdId_D; 
   wire dp_fcReg_icuRdId_E1; 
   assign {fcRdIdL2,fcRdIdL2_N} = dp_fcReg_icuRdId_regL2;     	
   assign dp_fcReg_icuRdId_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuRdId_D = {scRdIdL2,~scRdIdL2};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuRdId_E1)	                
     1'b0: dp_fcReg_icuRdId_regL2 <= dp_fcReg_icuRdId_regL2;		
     1'b1: dp_fcReg_icuRdId_regL2 <= dp_fcReg_icuRdId_D;		
      default: dp_fcReg_icuRdId_regL2 <= 2'bx;  
    endcase		 		
   end			 		


assign dAckChop = ~((fcRdIdL2_N | scIfScRdIdL2_N) & 
                   (fcRdIdL2 | scIfNotScRdIdL2_N));

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuAckCp
   reg [0:1] dp_fcReg_icuAckCp_regL2;
   wire [0:1] dp_fcReg_icuAckCp_D; 
   wire dp_fcReg_icuAckCp_E1; 
   assign {fcc405RdDAck,fcchopDackL2} = dp_fcReg_icuAckCp_regL2;     	
   assign dp_fcReg_icuAckCp_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuAckCp_D = {dAckChop,dAckChop};       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAckCp_E1)	                
     1'b0: dp_fcReg_icuAckCp_regL2 <= dp_fcReg_icuAckCp_regL2;		
     1'b1: dp_fcReg_icuAckCp_regL2 <= dp_fcReg_icuAckCp_D;		
      default: dp_fcReg_icuAckCp_regL2 <= 2'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: BUFFER buf_icuchopDack
   assign c405RdDAck = fcc405RdDAck;

   // Replacing instantiation: BUFFER buf_icuchopDack2
   assign chopDackL2 = fcchopDackL2;


   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuRdWd
   reg [0:2] dp_scReg_icuRdWd_regL2;
   wire [0:2] dp_scReg_icuRdWd_D; 
   wire dp_scReg_icuRdWd_E1; 
   assign scRdWdAddrL2[1:3] = dp_scReg_icuRdWd_regL2;     	
   assign dp_scReg_icuRdWd_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuRdWd_D = PLB_icsRdWrAddr_S[1:3];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuRdWd_E1)	                
     1'b0: dp_scReg_icuRdWd_regL2 <= dp_scReg_icuRdWd_regL2;		
     1'b1: dp_scReg_icuRdWd_regL2 <= dp_scReg_icuRdWd_D;		
      default: dp_scReg_icuRdWd_regL2 <= 3'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuErr
   reg dp_scReg_icuErr_regL2;
   wire dp_scReg_icuErr_D; 
   wire dp_scReg_icuErr_E1; 
   assign scPlbErrorL2 = dp_scReg_icuErr_regL2;     	
   assign dp_scReg_icuErr_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuErr_D = PLB_icsError_S;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuErr_E1)	                
     1'b0: dp_scReg_icuErr_regL2 <= dp_scReg_icuErr_regL2;		
     1'b1: dp_scReg_icuErr_regL2 <= dp_scReg_icuErr_D;		
      default: dp_scReg_icuErr_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuDBus1
   reg [0:31] dp_scReg_icuDBus1_regL2;
   wire [0:31] dp_scReg_icuDBus1_D; 
   wire dp_scReg_icuDBus1_E1; 
   assign scPlbDBus[0:31] = dp_scReg_icuDBus1_regL2;     	
   assign dp_scReg_icuDBus1_E1 = icuSyncGlobalE1_wRdDAckPLB;     
   assign dp_scReg_icuDBus1_D = PLB_icsDBus_S[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuDBus1_E1)	                
     1'b0: dp_scReg_icuDBus1_regL2 <= dp_scReg_icuDBus1_regL2;		
     1'b1: dp_scReg_icuDBus1_regL2 <= dp_scReg_icuDBus1_D;		
      default: dp_scReg_icuDBus1_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuDBus2
   reg [0:31] dp_scReg_icuDBus2_regL2;
   wire [0:31] dp_scReg_icuDBus2_D; 
   wire dp_scReg_icuDBus2_E1; 
   assign scPlbDBus[32:63] = dp_scReg_icuDBus2_regL2;     	
   assign dp_scReg_icuDBus2_E1 = icuSyncGlobalE1_wRdDAckPLB;     
   assign dp_scReg_icuDBus2_D = PLB_icsDBus_S[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuDBus2_E1)	                
     1'b0: dp_scReg_icuDBus2_regL2 <= dp_scReg_icuDBus2_regL2;		
     1'b1: dp_scReg_icuDBus2_regL2 <= dp_scReg_icuDBus2_D;		
      default: dp_scReg_icuDBus2_regL2 <= 32'bx;  
    endcase		 		
   end			 		



   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuRdWd
   reg [0:2] dp_fcReg_icuRdWd_regL2;
   wire [0:2] dp_fcReg_icuRdWd_D; 
   wire dp_fcReg_icuRdWd_E1; 
   assign fcRdWdAddrL2[1:3] = dp_fcReg_icuRdWd_regL2;     	
   assign dp_fcReg_icuRdWd_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuRdWd_D = scRdWdAddrL2[1:3];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuRdWd_E1)	                
     1'b0: dp_fcReg_icuRdWd_regL2 <= dp_fcReg_icuRdWd_regL2;		
     1'b1: dp_fcReg_icuRdWd_regL2 <= dp_fcReg_icuRdWd_D;		
      default: dp_fcReg_icuRdWd_regL2 <= 3'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuErr
   reg dp_fcReg_icuErr_regL2;
   wire dp_fcReg_icuErr_D; 
   wire dp_fcReg_icuErr_E1; 
   assign fcPlbErrorL2 = dp_fcReg_icuErr_regL2;     	
   assign dp_fcReg_icuErr_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuErr_D = scPlbErrorL2;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuErr_E1)	                
     1'b0: dp_fcReg_icuErr_regL2 <= dp_fcReg_icuErr_regL2;		
     1'b1: dp_fcReg_icuErr_regL2 <= dp_fcReg_icuErr_D;		
      default: dp_fcReg_icuErr_regL2 <= 1'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuDBus1
   reg [0:31] dp_fcReg_icuDBus1_regL2;
   wire [0:31] dp_fcReg_icuDBus1_D; 
   wire dp_fcReg_icuDBus1_E1; 
   assign fcPlbDBus[0:31] = dp_fcReg_icuDBus1_regL2;     	
   assign dp_fcReg_icuDBus1_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuDBus1_D = scPlbDBus[0:31];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuDBus1_E1)	                
     1'b0: dp_fcReg_icuDBus1_regL2 <= dp_fcReg_icuDBus1_regL2;		
     1'b1: dp_fcReg_icuDBus1_regL2 <= dp_fcReg_icuDBus1_D;		
      default: dp_fcReg_icuDBus1_regL2 <= 32'bx;  
    endcase		 		
   end			 		

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuDBus2
   reg [0:31] dp_fcReg_icuDBus2_regL2;
   wire [0:31] dp_fcReg_icuDBus2_D; 
   wire dp_fcReg_icuDBus2_E1; 
   assign fcPlbDBus[32:63] = dp_fcReg_icuDBus2_regL2;     	
   assign dp_fcReg_icuDBus2_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuDBus2_D = scPlbDBus[32:63];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuDBus2_E1)	                
     1'b0: dp_fcReg_icuDBus2_regL2 <= dp_fcReg_icuDBus2_regL2;		
     1'b1: dp_fcReg_icuDBus2_regL2 <= dp_fcReg_icuDBus2_D;		
      default: dp_fcReg_icuDBus2_regL2 <= 32'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: BUFFER buf_fcRdWdAddr1
   assign sc_fcRdWdAddrL2[1] = fcRdWdAddrL2[1];

   // Replacing instantiation: BUFFER buf_fcRdWdAddr2
   assign sc_fcRdWdAddrL2[2] = fcRdWdAddrL2[2];

   // Replacing instantiation: BUFFER buf_fcRdWdAddr3
   assign sc_fcRdWdAddrL2[3] = fcRdWdAddrL2[3];

   // Replacing instantiation: BUFFER buf_fcPlbDBus0
   assign sc_fcPlbDBus[0] = fcPlbDBus[0];

   // Replacing instantiation: BUFFER buf_fcPlbDBus1
   assign sc_fcPlbDBus[1] = fcPlbDBus[1];

   // Replacing instantiation: BUFFER buf_fcPlbDBus2
   assign sc_fcPlbDBus[2] = fcPlbDBus[2];

   // Replacing instantiation: BUFFER buf_fcPlbDBus3
   assign sc_fcPlbDBus[3] = fcPlbDBus[3];

   // Replacing instantiation: BUFFER buf_fcPlbDBus4
   assign sc_fcPlbDBus[4] = fcPlbDBus[4];

   // Replacing instantiation: BUFFER buf_fcPlbDBus5
   assign sc_fcPlbDBus[5] = fcPlbDBus[5];

   // Replacing instantiation: BUFFER buf_fcPlbDBus6
   assign sc_fcPlbDBus[6] = fcPlbDBus[6];

   // Replacing instantiation: BUFFER buf_fcPlbDBus7
   assign sc_fcPlbDBus[7] = fcPlbDBus[7];

   // Replacing instantiation: BUFFER buf_fcPlbDBus8
   assign sc_fcPlbDBus[8] = fcPlbDBus[8];

   // Replacing instantiation: BUFFER buf_fcPlbDBus9
   assign sc_fcPlbDBus[9] = fcPlbDBus[9];

   // Replacing instantiation: BUFFER buf_fcPlbDBus10
   assign sc_fcPlbDBus[10] = fcPlbDBus[10];

   // Replacing instantiation: BUFFER buf_fcPlbDBus11
   assign sc_fcPlbDBus[11] = fcPlbDBus[11];

   // Replacing instantiation: BUFFER buf_fcPlbDBus12
   assign sc_fcPlbDBus[12] = fcPlbDBus[12];

   // Replacing instantiation: BUFFER buf_fcPlbDBus13
   assign sc_fcPlbDBus[13] = fcPlbDBus[13];

   // Replacing instantiation: BUFFER buf_fcPlbDBus14
   assign sc_fcPlbDBus[14] = fcPlbDBus[14];

   // Replacing instantiation: BUFFER buf_fcPlbDBus15
   assign sc_fcPlbDBus[15] = fcPlbDBus[15];

   // Replacing instantiation: BUFFER buf_fcPlbDBus16
   assign sc_fcPlbDBus[16] = fcPlbDBus[16];

   // Replacing instantiation: BUFFER buf_fcPlbDBus17
   assign sc_fcPlbDBus[17] = fcPlbDBus[17];

   // Replacing instantiation: BUFFER buf_fcPlbDBus18
   assign sc_fcPlbDBus[18] = fcPlbDBus[18];

   // Replacing instantiation: BUFFER buf_fcPlbDBus19
   assign sc_fcPlbDBus[19] = fcPlbDBus[19];

   // Replacing instantiation: BUFFER buf_fcPlbDBus20
   assign sc_fcPlbDBus[20] = fcPlbDBus[20];

   // Replacing instantiation: BUFFER buf_fcPlbDBus21
   assign sc_fcPlbDBus[21] = fcPlbDBus[21];

   // Replacing instantiation: BUFFER buf_fcPlbDBus22
   assign sc_fcPlbDBus[22] = fcPlbDBus[22];

   // Replacing instantiation: BUFFER buf_fcPlbDBus23
   assign sc_fcPlbDBus[23] = fcPlbDBus[23];

   // Replacing instantiation: BUFFER buf_fcPlbDBus24
   assign sc_fcPlbDBus[24] = fcPlbDBus[24];

   // Replacing instantiation: BUFFER buf_fcPlbDBus25
   assign sc_fcPlbDBus[25] = fcPlbDBus[25];

   // Replacing instantiation: BUFFER buf_fcPlbDBus26
   assign sc_fcPlbDBus[26] = fcPlbDBus[26];

   // Replacing instantiation: BUFFER buf_fcPlbDBus27
   assign sc_fcPlbDBus[27] = fcPlbDBus[27];

   // Replacing instantiation: BUFFER buf_fcPlbDBus28
   assign sc_fcPlbDBus[28] = fcPlbDBus[28];

   // Replacing instantiation: BUFFER buf_fcPlbDBus29
   assign sc_fcPlbDBus[29] = fcPlbDBus[29];

   // Replacing instantiation: BUFFER buf_fcPlbDBus30
   assign sc_fcPlbDBus[30] = fcPlbDBus[30];

   // Replacing instantiation: BUFFER buf_fcPlbDBus31
   assign sc_fcPlbDBus[31] = fcPlbDBus[31];

   // Replacing instantiation: BUFFER buf_fcPlbDBus32
   assign sc_fcPlbDBus[32] = fcPlbDBus[32];

   // Replacing instantiation: BUFFER buf_fcPlbDBus33
   assign sc_fcPlbDBus[33] = fcPlbDBus[33];

   // Replacing instantiation: BUFFER buf_fcPlbDBus34
   assign sc_fcPlbDBus[34] = fcPlbDBus[34];

   // Replacing instantiation: BUFFER buf_fcPlbDBus35
   assign sc_fcPlbDBus[35] = fcPlbDBus[35];

   // Replacing instantiation: BUFFER buf_fcPlbDBus36
   assign sc_fcPlbDBus[36] = fcPlbDBus[36];

   // Replacing instantiation: BUFFER buf_fcPlbDBus37
   assign sc_fcPlbDBus[37] = fcPlbDBus[37];

   // Replacing instantiation: BUFFER buf_fcPlbDBus38
   assign sc_fcPlbDBus[38] = fcPlbDBus[38];

   // Replacing instantiation: BUFFER buf_fcPlbDBus39
   assign sc_fcPlbDBus[39] = fcPlbDBus[39];

   // Replacing instantiation: BUFFER buf_fcPlbDBus40
   assign sc_fcPlbDBus[40] = fcPlbDBus[40];

   // Replacing instantiation: BUFFER buf_fcPlbDBus41
   assign sc_fcPlbDBus[41] = fcPlbDBus[41];

   // Replacing instantiation: BUFFER buf_fcPlbDBus42
   assign sc_fcPlbDBus[42] = fcPlbDBus[42];

   // Replacing instantiation: BUFFER buf_fcPlbDBus43
   assign sc_fcPlbDBus[43] = fcPlbDBus[43];

   // Replacing instantiation: BUFFER buf_fcPlbDBus44
   assign sc_fcPlbDBus[44] = fcPlbDBus[44];

   // Replacing instantiation: BUFFER buf_fcPlbDBus45
   assign sc_fcPlbDBus[45] = fcPlbDBus[45];

   // Replacing instantiation: BUFFER buf_fcPlbDBus46
   assign sc_fcPlbDBus[46] = fcPlbDBus[46];

   // Replacing instantiation: BUFFER buf_fcPlbDBus47
   assign sc_fcPlbDBus[47] = fcPlbDBus[47];

   // Replacing instantiation: BUFFER buf_fcPlbDBus48
   assign sc_fcPlbDBus[48] = fcPlbDBus[48];

   // Replacing instantiation: BUFFER buf_fcPlbDBus49
   assign sc_fcPlbDBus[49] = fcPlbDBus[49];

   // Replacing instantiation: BUFFER buf_fcPlbDBus50
   assign sc_fcPlbDBus[50] = fcPlbDBus[50];

   // Replacing instantiation: BUFFER buf_fcPlbDBus51
   assign sc_fcPlbDBus[51] = fcPlbDBus[51];

   // Replacing instantiation: BUFFER buf_fcPlbDBus52
   assign sc_fcPlbDBus[52] = fcPlbDBus[52];

   // Replacing instantiation: BUFFER buf_fcPlbDBus53
   assign sc_fcPlbDBus[53] = fcPlbDBus[53];

   // Replacing instantiation: BUFFER buf_fcPlbDBus54
   assign sc_fcPlbDBus[54] = fcPlbDBus[54];

   // Replacing instantiation: BUFFER buf_fcPlbDBus55
   assign sc_fcPlbDBus[55] = fcPlbDBus[55];

   // Replacing instantiation: BUFFER buf_fcPlbDBus56
   assign sc_fcPlbDBus[56] = fcPlbDBus[56];

   // Replacing instantiation: BUFFER buf_fcPlbDBus57
   assign sc_fcPlbDBus[57] = fcPlbDBus[57];

   // Replacing instantiation: BUFFER buf_fcPlbDBus58
   assign sc_fcPlbDBus[58] = fcPlbDBus[58];

   // Replacing instantiation: BUFFER buf_fcPlbDBus59
   assign sc_fcPlbDBus[59] = fcPlbDBus[59];

   // Replacing instantiation: BUFFER buf_fcPlbDBus60
   assign sc_fcPlbDBus[60] = fcPlbDBus[60];

   // Replacing instantiation: BUFFER buf_fcPlbDBus61
   assign sc_fcPlbDBus[61] = fcPlbDBus[61];

   // Replacing instantiation: BUFFER buf_fcPlbDBus62
   assign sc_fcPlbDBus[62] = fcPlbDBus[62];

   // Replacing instantiation: BUFFER buf_fcPlbDBus63
   assign sc_fcPlbDBus[63] = fcPlbDBus[63];

   // Replacing instantiation: BUFFER buf_icuErr
   assign sc_fcPlbErrorL2 = fcPlbErrorL2;


wire ics_c405RdDAck = c405RdDAck & ~blockDack;



/////////////////////// stop data input logic ///////////////////////////////////
//

/////////////////////// start busy logic  ///////////////////////////////////////


wire scBusyIn = PLB_icsIcuBusy_S | fcResetL2 ;

   // Replacing instantiation: PDP_P1EUL2 dp_scReg_icuBusy
   reg dp_scReg_icuBusy_regL2;
   wire dp_scReg_icuBusy_D; 
   wire dp_scReg_icuBusy_E1; 
   assign scBusyL2 = dp_scReg_icuBusy_regL2;     	
   assign dp_scReg_icuBusy_E1 = icuSyncGlobalE1S;     
   assign dp_scReg_icuBusy_D = scBusyIn;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge sc)  	
    begin				  	
    casez(dp_scReg_icuBusy_E1)	                
     1'b0: dp_scReg_icuBusy_regL2 <= dp_scReg_icuBusy_regL2;		
     1'b1: dp_scReg_icuBusy_regL2 <= dp_scReg_icuBusy_D;		
      default: dp_scReg_icuBusy_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuBusy
   reg dp_fcReg_icuBusy_regL2;
   wire dp_fcReg_icuBusy_D; 
   wire dp_fcReg_icuBusy_E1; 
   assign fcBusyL2 = dp_fcReg_icuBusy_regL2;     	
   assign dp_fcReg_icuBusy_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuBusy_D = scBusyL2;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuBusy_E1)	                
     1'b0: dp_fcReg_icuBusy_regL2 <= dp_fcReg_icuBusy_regL2;		
     1'b1: dp_fcReg_icuBusy_regL2 <= dp_fcReg_icuBusy_D;		
      default: dp_fcReg_icuBusy_regL2 <= 1'bx;  
    endcase		 		
   end			 		


   // Replacing instantiation: BUFFER buf_icuBusy
   assign sc_fcBusyL2 = fcBusyL2;


wire busyOrReset = sc_fcBusyL2 | fcResetL2 | fcReset2L2;


/////////////////////// stop busy logic  ////////////////////////////////////////


/////////////////////// start counter logic  /////////////////////////////////////

wire[0:2]   setCntIn, fcCntIn;
wire        fcSetCnt;

wire[0:2]   fcCntL2;
wire        fcValidL2;

assign setCntIn[0:2] = (fcCntL2[0:2] & {3{~fcSetCnt}}) |
                    ({(fcTsize3L2 | fcSsizeFdBackL2), 
                     (fcTsize3L2 & fcSsizeFdBackL2), chopDackL2} &
                     {3{fcSetCnt}});

assign fcCntIn[0:2] = (setCntIn[0:2] & ~({3{chopDackL2 & ~fcSetCnt}})) |
                    ((fcCntL2[0:2] + 3'b001) & ({3{chopDackL2 & ~fcSetCnt}}));

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuCntr
   reg [0:2] dp_fcReg_icuCntr_regL2;
   wire [0:2] dp_fcReg_icuCntr_D; 
   wire dp_fcReg_icuCntr_E1; 
   assign fcCntL2[0:2] = dp_fcReg_icuCntr_regL2;     	
   assign dp_fcReg_icuCntr_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuCntr_D = fcCntIn[0:2];       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuCntr_E1)	                
     1'b0: dp_fcReg_icuCntr_regL2 <= dp_fcReg_icuCntr_regL2;		
     1'b1: dp_fcReg_icuCntr_regL2 <= dp_fcReg_icuCntr_D;		
      default: dp_fcReg_icuCntr_regL2 <= 3'bx;  
    endcase		 		
   end			 		


wire fcDone = chopDackL2 & (fcCntL2 == 3'b111);

wire fcValidIn = fcSetCnt | (fcValidL2 & ~(fcDone | fcResetL2));

   // Replacing instantiation: PDP_P1EUL2 dp_fcReg_icuValid
   reg dp_fcReg_icuValid_regL2;
   wire dp_fcReg_icuValid_D; 
   wire dp_fcReg_icuValid_E1; 
   assign fcValidL2 = dp_fcReg_icuValid_regL2;     	
   assign dp_fcReg_icuValid_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuValid_D = fcValidIn;       
                                           
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuValid_E1)	                
     1'b0: dp_fcReg_icuValid_regL2 <= dp_fcReg_icuValid_regL2;		
     1'b1: dp_fcReg_icuValid_regL2 <= dp_fcReg_icuValid_D;		
      default: dp_fcReg_icuValid_regL2 <= 1'bx;  
    endcase		 		
   end			 		



/////////////////////// stop counter logic  //////////////////////////////////////
//
//Page 10

/////////////////////// start reqSM logic  ///////////////////////////////////////

reg[0:3]    reqNxtSt;
reg[0:5]    abNxtSt;

   // Replacing instantiation: PDP_P2EUL2 dp_fcReg_icuReqSM
   reg [0:3] dp_fcReg_icuReqSM_regL2;
   reg [0:3] dp_fcReg_icuReqSM_DataIn;
   wire [0:3] dp_fcReg_icuReqSM_D0,dp_fcReg_icuReqSM_D1; 
   wire dp_fcReg_icuReqSM_SD; 
   wire dp_fcReg_icuReqSM_E1; 
   assign reqSML2[0:3] = dp_fcReg_icuReqSM_regL2;     	
   assign dp_fcReg_icuReqSM_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuReqSM_SD = fcResetL2;    	
   assign dp_fcReg_icuReqSM_D0 = reqNxtSt[0:3];    	
   assign dp_fcReg_icuReqSM_D1 = 4'b1000;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_fcReg_icuReqSM_D0 or dp_fcReg_icuReqSM_D1 or dp_fcReg_icuReqSM_SD)  	
    begin				  	
    casez(dp_fcReg_icuReqSM_SD)			
     1'b0: dp_fcReg_icuReqSM_DataIn = dp_fcReg_icuReqSM_D0;	
     1'b1: dp_fcReg_icuReqSM_DataIn = dp_fcReg_icuReqSM_D1;	
      default: dp_fcReg_icuReqSM_DataIn = 4'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuReqSM_E1)			
     1'b0: dp_fcReg_icuReqSM_regL2 <= dp_fcReg_icuReqSM_regL2;		
     1'b1: dp_fcReg_icuReqSM_regL2 <= dp_fcReg_icuReqSM_DataIn;	
      default: dp_fcReg_icuReqSM_regL2 <= 4'bx;  
    endcase		 		
   end			 		



always @ (reqSML2 or C405_icsRequest_S or C405_icsAbort_S or
          chopAackL2 or sc_fcReqFdBackL2 or sc_fcAbortFdBackL2 or 
          abEndCycle or fcValidL2 or abSML2)

   begin
     casez ({reqSML2[0:3], C405_icsRequest_S, C405_icsAbort_S,
             chopAackL2, sc_fcReqFdBackL2, sc_fcAbortFdBackL2, 
             abEndCycle, fcValidL2, abSML2[5]
           }) 

//        reqSML2[0]
//        |reqSML2[1]
//        ||reqSML2[2]
//        |||reqSML2[3]
//        ||||
//        |||| C405_icsRequest_S
//        |||| |C405_icsAbort_S
//        |||| ||chopAackL2
//        |||| |||sc_fcReqFdBackL2
//        |||| ||||sc_fcAbortFdBackL2
//        |||| |||||abEndCycle
//        |||| ||||||fcValidL2
//        |||| |||||||abSML2[5]
//        |||| ||||||||
      12'b1???_0???????: reqNxtSt[0:3] = reqSM0 ;
      12'b1???_11??????: reqNxtSt[0:3] = reqSM0 ;
      12'b1???_10??????: reqNxtSt[0:3] = reqSM1 ;
      12'b?1??_???0????: reqNxtSt[0:3] = reqSM1 ;
      12'b?1??_??01????: reqNxtSt[0:3] = reqSM2 ;
      12'b?1??_???11???: reqNxtSt[0:3] = reqSM2 ;
      12'b?1??_??110???: reqNxtSt[0:3] = reqSM3 ;
      12'b??1?_??0??0??: reqNxtSt[0:3] = reqSM2 ;
      12'b??1?_?????1??: reqNxtSt[0:3] = reqSM0 ;
      12'b??1?_??1?????: reqNxtSt[0:3] = reqSM3 ;
      12'b???1_??????10: reqNxtSt[0:3] = reqSM3 ;
      12'b???1_???????1: reqNxtSt[0:3] = reqSM0 ;
      12'b???1_??????0?: reqNxtSt[0:3] = reqSM0 ;
       default:       reqNxtSt[0:3] = 4'bxxxx;
   endcase
 end

/////////////////////// stop reqSM logic  ////////////////////////////////////////

/////////////////////// start abSM logic  ////////////////////////////////////////

   // Replacing instantiation: PDP_P2EUL2 dp_fcReg_icuAbSM
   reg [0:5] dp_fcReg_icuAbSM_regL2;
   reg [0:5] dp_fcReg_icuAbSM_DataIn;
   wire [0:5] dp_fcReg_icuAbSM_D0,dp_fcReg_icuAbSM_D1; 
   wire dp_fcReg_icuAbSM_SD; 
   wire dp_fcReg_icuAbSM_E1; 
   assign abSML2[0:5] = dp_fcReg_icuAbSM_regL2;     	
   assign dp_fcReg_icuAbSM_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icuAbSM_SD = fcResetL2;    	
   assign dp_fcReg_icuAbSM_D0 = abNxtSt[0:5];    	
   assign dp_fcReg_icuAbSM_D1 = 6'b10_0000;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_fcReg_icuAbSM_D0 or dp_fcReg_icuAbSM_D1 or dp_fcReg_icuAbSM_SD)  	
    begin				  	
    casez(dp_fcReg_icuAbSM_SD)			
     1'b0: dp_fcReg_icuAbSM_DataIn = dp_fcReg_icuAbSM_D0;	
     1'b1: dp_fcReg_icuAbSM_DataIn = dp_fcReg_icuAbSM_D1;	
      default: dp_fcReg_icuAbSM_DataIn = 6'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icuAbSM_E1)			
     1'b0: dp_fcReg_icuAbSM_regL2 <= dp_fcReg_icuAbSM_regL2;		
     1'b1: dp_fcReg_icuAbSM_regL2 <= dp_fcReg_icuAbSM_DataIn;	
      default: dp_fcReg_icuAbSM_regL2 <= 6'bx;  
    endcase		 		
   end			 		


always @ (abSML2 or C405_icsRequest_S or C405_icsAbort_S or reqSML2 or
          chopAackL2 or sc_fcAbortFdBackL2 or sc_fcAackFdBackL2 or fcValidL2 )

   begin
     casez ({abSML2[0:5], C405_icsRequest_S, C405_icsAbort_S, reqSML2[3],
             chopAackL2, sc_fcAbortFdBackL2, sc_fcAackFdBackL2, fcValidL2
           }) 

//        abSML2[0]
//        |abSML2[1]
//        ||abSML2[2]
//        |||abSML2[3]
//        ||||abSML2[4]
//        |||||abSML2[5]
//        ||||||
//        ||||||
//        |||||| C405_icsRequest_S
//        |||||| |C405_icsAbort_S
//        |||||| ||reqSML2[3]
//        |||||| |||chopAackL2
//        |||||| ||||sc_fcAbortFdBackL2
//        |||||| |||||sc_fcAackFdBackL2
//        |||||| ||||||fcValidL2
//        |||||| |||||||
//        |||||| |||||||
      13'b1?????_0??????: abNxtSt[0:5] = abSM0 ;
      13'b1?????_11?????: abNxtSt[0:5] = abSM0 ;
      13'b1?????_10?????: abNxtSt[0:5] = abSM1 ;
      13'b?1????_?00????: abNxtSt[0:5] = abSM1 ;
      13'b?1????_??1???1: abNxtSt[0:5] = abSM1 ;
      13'b?1????_?100???: abNxtSt[0:5] = abSM2 ;
      13'b?1????_?101???: abNxtSt[0:5] = abSM3 ;
      13'b?1????_??1???0: abNxtSt[0:5] = abSM0 ;
      13'b??1???_???00??: abNxtSt[0:5] = abSM2 ;
      13'b??1???_???1???: abNxtSt[0:5] = abSM3 ;
      13'b??1???_???01??: abNxtSt[0:5] = abSM4 ;
      13'b???1??_??????1: abNxtSt[0:5] = abSM3 ;
      13'b???1??_??????0: abNxtSt[0:5] = abSM0 ;
      13'b????1?_????1??: abNxtSt[0:5] = abSM4 ;
      13'b????1?_???0?1?: abNxtSt[0:5] = abSM4 ;
      13'b????1?_???101?: abNxtSt[0:5] = abSM5 ;
      13'b????1?_????00?: abNxtSt[0:5] = abSM0 ;
      13'b?????1_???????: abNxtSt[0:5] = abSM0 ;
      default:            abNxtSt[0:5] = 6'bxxxxxx;
   endcase
 end

/////////////////////// stop abSM logic  /////////////////////////////////////////

////////////// start signals and block Aack and Dack  ////////////////////////////

wire         blockDackL2;


assign fcSetCnt = reqSML2[3] & ~abSML2[5] & ~fcValidL2 ;
assign blockAack = abSML2[2] | abSML2[4];
wire blockDackIn = ((abSML2[3] & reqSML2[3] & ~fcValidL2) | blockDackL2) &
                      ~fcDone ;
assign blockDack = (abSML2[3] & reqSML2[3] & ~fcValidL2) | blockDackL2 ;
assign abEndCycle = abSML2[4] & ~sc_fcAbortFdBackL2 & ~sc_fcAackFdBackL2;

   // Replacing instantiation: PDP_P2EUL2 dp_fcReg_icublkDack
   reg dp_fcReg_icublkDack_regL2;
   reg dp_fcReg_icublkDack_DataIn;
   wire dp_fcReg_icublkDack_D0,dp_fcReg_icublkDack_D1; 
   wire dp_fcReg_icublkDack_SD; 
   wire dp_fcReg_icublkDack_E1; 
   assign blockDackL2 = dp_fcReg_icublkDack_regL2;     	
   assign dp_fcReg_icublkDack_E1 = icuSyncGlobalE1;     
   assign dp_fcReg_icublkDack_SD = fcResetL2;    	
   assign dp_fcReg_icublkDack_D0 = blockDackIn;    	
   assign dp_fcReg_icublkDack_D1 = 1'b0;    	
                                           
   // 2-1 Mux input to register	      	
   always @(dp_fcReg_icublkDack_D0 or dp_fcReg_icublkDack_D1 or dp_fcReg_icublkDack_SD)  	
    begin				  	
    casez(dp_fcReg_icublkDack_SD)			
     1'b0: dp_fcReg_icublkDack_DataIn = dp_fcReg_icublkDack_D0;	
     1'b1: dp_fcReg_icublkDack_DataIn = dp_fcReg_icublkDack_D1;	
      default: dp_fcReg_icublkDack_DataIn = 1'bx;  
    endcase		 		
   end			 		
   // L2 Output modeled as posedge FF      
   always @(posedge CB)  	
    begin				  	
    casez(dp_fcReg_icublkDack_E1)			
     1'b0: dp_fcReg_icublkDack_regL2 <= dp_fcReg_icublkDack_regL2;		
     1'b1: dp_fcReg_icublkDack_regL2 <= dp_fcReg_icublkDack_DataIn;	
      default: dp_fcReg_icublkDack_regL2 <= 1'bx;  
    endcase		 		
   end			 		


////////////////////////////////////// bypass muxes  ////////////////////////////

wire       inv_ICS_plbRequest_N,   mux_ICS_plbRequest_M;
wire       inv_ICS_plbAbort_N,     mux_ICS_plbAbort_M;
wire       inv_ICS_plbCacheable_N, mux_ICS_plbCacheable_M;
wire       inv_ICS_plbU0Attr_N,    mux_ICS_plbU0Attr_M;
wire[2:3]  inv_ICS_plbTranSize_N,  mux_ICS_plbTranSize_M;
wire[0:1]  inv_ICS_plbPriority_N,  mux_ICS_plbPriority_M;
wire[0:29] inv_ICS_plbABus_N,      mux_ICS_plbABus_M;

wire       inv_ICS_c405AddrAck_N,  mux_ICS_c405AddrAck_M;
wire       inv_ICS_c405SSize_N,    mux_ICS_c405SSize_M;
wire       inv_ICS_c405RdDAck_N,   mux_ICS_c405RdDAck_M;
wire       inv_ICS_c405Error_N,    mux_ICS_c405Error_M;
wire       inv_ICS_c405IcuBusy_N,  mux_ICS_c405IcuBusy_M;
wire[0:63] inv_ICS_c405DBus_N,     mux_ICS_c405DBus_M;
wire[1:3]  inv_ICS_c405RdWrAddr_N, mux_ICS_c405RdWrAddr_M;


   // Replacing instantiation: MUX21 mux_ICS_plbRequest
   assign mux_ICS_plbRequest_M = (plbRequest & ~(bypass)) | (C405_icsRequest & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbAbort
   assign mux_ICS_plbAbort_M = (plbAbort & ~(bypass)) | (C405_icsAbort & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbCacheable
   assign mux_ICS_plbCacheable_M = (scAttL2[0] & ~(bypass)) | (C405_icsCacheable & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbU0Attr
   assign mux_ICS_plbU0Attr_M = (scAttL2[3] & ~(bypass)) | (C405_icsU0Attr & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbTranSize_2
   assign mux_ICS_plbTranSize_M[2] = (scAttL2[1] & ~(bypass)) | (C405_icsTranSize[2] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbTranSize_3
   assign mux_ICS_plbTranSize_M[3] = (scAttL2[2] & ~(bypass)) | (C405_icsTranSize[3] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_0
   assign mux_ICS_plbABus_M[0] = (scABusL2[0] & ~(bypass)) | (C405_icsABus[0] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_1
   assign mux_ICS_plbABus_M[1] = (scABusL2[1] & ~(bypass)) | (C405_icsABus[1] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_2
   assign mux_ICS_plbABus_M[2] = (scABusL2[2] & ~(bypass)) | (C405_icsABus[2] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_3
   assign mux_ICS_plbABus_M[3] = (scABusL2[3] & ~(bypass)) | (C405_icsABus[3] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_4
   assign mux_ICS_plbABus_M[4] = (scABusL2[4] & ~(bypass)) | (C405_icsABus[4] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_5
   assign mux_ICS_plbABus_M[5] = (scABusL2[5] & ~(bypass)) | (C405_icsABus[5] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_6
   assign mux_ICS_plbABus_M[6] = (scABusL2[6] & ~(bypass)) | (C405_icsABus[6] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_7
   assign mux_ICS_plbABus_M[7] = (scABusL2[7] & ~(bypass)) | (C405_icsABus[7] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_8
   assign mux_ICS_plbABus_M[8] = (scABusL2[8] & ~(bypass)) | (C405_icsABus[8] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_9
   assign mux_ICS_plbABus_M[9] = (scABusL2[9] & ~(bypass)) | (C405_icsABus[9] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_10
   assign mux_ICS_plbABus_M[10] = (scABusL2[10] & ~(bypass)) | (C405_icsABus[10] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_11
   assign mux_ICS_plbABus_M[11] = (scABusL2[11] & ~(bypass)) | (C405_icsABus[11] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_12
   assign mux_ICS_plbABus_M[12] = (scABusL2[12] & ~(bypass)) | (C405_icsABus[12] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_13
   assign mux_ICS_plbABus_M[13] = (scABusL2[13] & ~(bypass)) | (C405_icsABus[13] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_14
   assign mux_ICS_plbABus_M[14] = (scABusL2[14] & ~(bypass)) | (C405_icsABus[14] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_15
   assign mux_ICS_plbABus_M[15] = (scABusL2[15] & ~(bypass)) | (C405_icsABus[15] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_16
   assign mux_ICS_plbABus_M[16] = (scABusL2[16] & ~(bypass)) | (C405_icsABus[16] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_17
   assign mux_ICS_plbABus_M[17] = (scABusL2[17] & ~(bypass)) | (C405_icsABus[17] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_18
   assign mux_ICS_plbABus_M[18] = (scABusL2[18] & ~(bypass)) | (C405_icsABus[18] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_19
   assign mux_ICS_plbABus_M[19] = (scABusL2[19] & ~(bypass)) | (C405_icsABus[19] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_20
   assign mux_ICS_plbABus_M[20] = (scABusL2[20] & ~(bypass)) | (C405_icsABus[20] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_21
   assign mux_ICS_plbABus_M[21] = (scABusL2[21] & ~(bypass)) | (C405_icsABus[21] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_22
   assign mux_ICS_plbABus_M[22] = (scABusL2[22] & ~(bypass)) | (C405_icsABus[22] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_23
   assign mux_ICS_plbABus_M[23] = (scABusL2[23] & ~(bypass)) | (C405_icsABus[23] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_24
   assign mux_ICS_plbABus_M[24] = (scABusL2[24] & ~(bypass)) | (C405_icsABus[24] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_25
   assign mux_ICS_plbABus_M[25] = (scABusL2[25] & ~(bypass)) | (C405_icsABus[25] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_26
   assign mux_ICS_plbABus_M[26] = (scABusL2[26] & ~(bypass)) | (C405_icsABus[26] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_27
   assign mux_ICS_plbABus_M[27] = (scABusL2[27] & ~(bypass)) | (C405_icsABus[27] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_28
   assign mux_ICS_plbABus_M[28] = (scABusL2[28] & ~(bypass)) | (C405_icsABus[28] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbABus_29
   assign mux_ICS_plbABus_M[29] = (scABusL2[29] & ~(bypass)) | (C405_icsABus[29] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbPriority_0
   assign mux_ICS_plbPriority_M[0] = (scAttL2[4] & ~(bypass)) | (C405_icsPriority[0] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_plbPriority_1
   assign mux_ICS_plbPriority_M[1] = (scAttL2[5] & ~(bypass)) | (C405_icsPriority[1] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405AddrAck
   assign mux_ICS_c405AddrAck_M = (ics_c405AddrAck & ~(bypass)) | (PLB_icsAddrAck & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405SSize
   assign mux_ICS_c405SSize_M = (sc_fcPLBsSizeL2 & ~(bypass)) | (PLB_icsSSize & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405RdDAck
   assign mux_ICS_c405RdDAck_M = (ics_c405RdDAck & ~(bypass)) | (PLB_icsRdDAck & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405Error
   assign mux_ICS_c405Error_M = (sc_fcPlbErrorL2 & ~(bypass)) | (PLB_icsError & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_0
   assign mux_ICS_c405DBus_M[0] = (sc_fcPlbDBus[0] & ~(bypass)) | (PLB_icsDBus[0] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_1
   assign mux_ICS_c405DBus_M[1] = (sc_fcPlbDBus[1] & ~(bypass)) | (PLB_icsDBus[1] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_2
   assign mux_ICS_c405DBus_M[2] = (sc_fcPlbDBus[2] & ~(bypass)) | (PLB_icsDBus[2] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_3
   assign mux_ICS_c405DBus_M[3] = (sc_fcPlbDBus[3] & ~(bypass)) | (PLB_icsDBus[3] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_4
   assign mux_ICS_c405DBus_M[4] = (sc_fcPlbDBus[4] & ~(bypass)) | (PLB_icsDBus[4] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_5
   assign mux_ICS_c405DBus_M[5] = (sc_fcPlbDBus[5] & ~(bypass)) | (PLB_icsDBus[5] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_6
   assign mux_ICS_c405DBus_M[6] = (sc_fcPlbDBus[6] & ~(bypass)) | (PLB_icsDBus[6] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_7
   assign mux_ICS_c405DBus_M[7] = (sc_fcPlbDBus[7] & ~(bypass)) | (PLB_icsDBus[7] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_8
   assign mux_ICS_c405DBus_M[8] = (sc_fcPlbDBus[8] & ~(bypass)) | (PLB_icsDBus[8] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_9
   assign mux_ICS_c405DBus_M[9] = (sc_fcPlbDBus[9] & ~(bypass)) | (PLB_icsDBus[9] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_10
   assign mux_ICS_c405DBus_M[10] = (sc_fcPlbDBus[10] & ~(bypass)) | (PLB_icsDBus[10] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_11
   assign mux_ICS_c405DBus_M[11] = (sc_fcPlbDBus[11] & ~(bypass)) | (PLB_icsDBus[11] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_12
   assign mux_ICS_c405DBus_M[12] = (sc_fcPlbDBus[12] & ~(bypass)) | (PLB_icsDBus[12] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_13
   assign mux_ICS_c405DBus_M[13] = (sc_fcPlbDBus[13] & ~(bypass)) | (PLB_icsDBus[13] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_14
   assign mux_ICS_c405DBus_M[14] = (sc_fcPlbDBus[14] & ~(bypass)) | (PLB_icsDBus[14] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_15
   assign mux_ICS_c405DBus_M[15] = (sc_fcPlbDBus[15] & ~(bypass)) | (PLB_icsDBus[15] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_16
   assign mux_ICS_c405DBus_M[16] = (sc_fcPlbDBus[16] & ~(bypass)) | (PLB_icsDBus[16] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_17
   assign mux_ICS_c405DBus_M[17] = (sc_fcPlbDBus[17] & ~(bypass)) | (PLB_icsDBus[17] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_18
   assign mux_ICS_c405DBus_M[18] = (sc_fcPlbDBus[18] & ~(bypass)) | (PLB_icsDBus[18] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_19
   assign mux_ICS_c405DBus_M[19] = (sc_fcPlbDBus[19] & ~(bypass)) | (PLB_icsDBus[19] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_20
   assign mux_ICS_c405DBus_M[20] = (sc_fcPlbDBus[20] & ~(bypass)) | (PLB_icsDBus[20] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_21
   assign mux_ICS_c405DBus_M[21] = (sc_fcPlbDBus[21] & ~(bypass)) | (PLB_icsDBus[21] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_22
   assign mux_ICS_c405DBus_M[22] = (sc_fcPlbDBus[22] & ~(bypass)) | (PLB_icsDBus[22] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_23
   assign mux_ICS_c405DBus_M[23] = (sc_fcPlbDBus[23] & ~(bypass)) | (PLB_icsDBus[23] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_24
   assign mux_ICS_c405DBus_M[24] = (sc_fcPlbDBus[24] & ~(bypass)) | (PLB_icsDBus[24] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_25
   assign mux_ICS_c405DBus_M[25] = (sc_fcPlbDBus[25] & ~(bypass)) | (PLB_icsDBus[25] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_26
   assign mux_ICS_c405DBus_M[26] = (sc_fcPlbDBus[26] & ~(bypass)) | (PLB_icsDBus[26] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_27
   assign mux_ICS_c405DBus_M[27] = (sc_fcPlbDBus[27] & ~(bypass)) | (PLB_icsDBus[27] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_28
   assign mux_ICS_c405DBus_M[28] = (sc_fcPlbDBus[28] & ~(bypass)) | (PLB_icsDBus[28] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_29
   assign mux_ICS_c405DBus_M[29] = (sc_fcPlbDBus[29] & ~(bypass)) | (PLB_icsDBus[29] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_30
   assign mux_ICS_c405DBus_M[30] = (sc_fcPlbDBus[30] & ~(bypass)) | (PLB_icsDBus[30] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_31
   assign mux_ICS_c405DBus_M[31] = (sc_fcPlbDBus[31] & ~(bypass)) | (PLB_icsDBus[31] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_32
   assign mux_ICS_c405DBus_M[32] = (sc_fcPlbDBus[32] & ~(bypass)) | (PLB_icsDBus[32] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_33
   assign mux_ICS_c405DBus_M[33] = (sc_fcPlbDBus[33] & ~(bypass)) | (PLB_icsDBus[33] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_34
   assign mux_ICS_c405DBus_M[34] = (sc_fcPlbDBus[34] & ~(bypass)) | (PLB_icsDBus[34] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_35
   assign mux_ICS_c405DBus_M[35] = (sc_fcPlbDBus[35] & ~(bypass)) | (PLB_icsDBus[35] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_36
   assign mux_ICS_c405DBus_M[36] = (sc_fcPlbDBus[36] & ~(bypass)) | (PLB_icsDBus[36] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_37
   assign mux_ICS_c405DBus_M[37] = (sc_fcPlbDBus[37] & ~(bypass)) | (PLB_icsDBus[37] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_38
   assign mux_ICS_c405DBus_M[38] = (sc_fcPlbDBus[38] & ~(bypass)) | (PLB_icsDBus[38] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_39
   assign mux_ICS_c405DBus_M[39] = (sc_fcPlbDBus[39] & ~(bypass)) | (PLB_icsDBus[39] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_40
   assign mux_ICS_c405DBus_M[40] = (sc_fcPlbDBus[40] & ~(bypass)) | (PLB_icsDBus[40] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_41
   assign mux_ICS_c405DBus_M[41] = (sc_fcPlbDBus[41] & ~(bypass)) | (PLB_icsDBus[41] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_42
   assign mux_ICS_c405DBus_M[42] = (sc_fcPlbDBus[42] & ~(bypass)) | (PLB_icsDBus[42] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_43
   assign mux_ICS_c405DBus_M[43] = (sc_fcPlbDBus[43] & ~(bypass)) | (PLB_icsDBus[43] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_44
   assign mux_ICS_c405DBus_M[44] = (sc_fcPlbDBus[44] & ~(bypass)) | (PLB_icsDBus[44] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_45
   assign mux_ICS_c405DBus_M[45] = (sc_fcPlbDBus[45] & ~(bypass)) | (PLB_icsDBus[45] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_46
   assign mux_ICS_c405DBus_M[46] = (sc_fcPlbDBus[46] & ~(bypass)) | (PLB_icsDBus[46] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_47
   assign mux_ICS_c405DBus_M[47] = (sc_fcPlbDBus[47] & ~(bypass)) | (PLB_icsDBus[47] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_48
   assign mux_ICS_c405DBus_M[48] = (sc_fcPlbDBus[48] & ~(bypass)) | (PLB_icsDBus[48] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_49
   assign mux_ICS_c405DBus_M[49] = (sc_fcPlbDBus[49] & ~(bypass)) | (PLB_icsDBus[49] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_50
   assign mux_ICS_c405DBus_M[50] = (sc_fcPlbDBus[50] & ~(bypass)) | (PLB_icsDBus[50] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_51
   assign mux_ICS_c405DBus_M[51] = (sc_fcPlbDBus[51] & ~(bypass)) | (PLB_icsDBus[51] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_52
   assign mux_ICS_c405DBus_M[52] = (sc_fcPlbDBus[52] & ~(bypass)) | (PLB_icsDBus[52] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_53
   assign mux_ICS_c405DBus_M[53] = (sc_fcPlbDBus[53] & ~(bypass)) | (PLB_icsDBus[53] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_54
   assign mux_ICS_c405DBus_M[54] = (sc_fcPlbDBus[54] & ~(bypass)) | (PLB_icsDBus[54] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_55
   assign mux_ICS_c405DBus_M[55] = (sc_fcPlbDBus[55] & ~(bypass)) | (PLB_icsDBus[55] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_56
   assign mux_ICS_c405DBus_M[56] = (sc_fcPlbDBus[56] & ~(bypass)) | (PLB_icsDBus[56] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_57
   assign mux_ICS_c405DBus_M[57] = (sc_fcPlbDBus[57] & ~(bypass)) | (PLB_icsDBus[57] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_58
   assign mux_ICS_c405DBus_M[58] = (sc_fcPlbDBus[58] & ~(bypass)) | (PLB_icsDBus[58] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_59
   assign mux_ICS_c405DBus_M[59] = (sc_fcPlbDBus[59] & ~(bypass)) | (PLB_icsDBus[59] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_60
   assign mux_ICS_c405DBus_M[60] = (sc_fcPlbDBus[60] & ~(bypass)) | (PLB_icsDBus[60] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_61
   assign mux_ICS_c405DBus_M[61] = (sc_fcPlbDBus[61] & ~(bypass)) | (PLB_icsDBus[61] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_62
   assign mux_ICS_c405DBus_M[62] = (sc_fcPlbDBus[62] & ~(bypass)) | (PLB_icsDBus[62] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405DBus_63
   assign mux_ICS_c405DBus_M[63] = (sc_fcPlbDBus[63] & ~(bypass)) | (PLB_icsDBus[63] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405RdWdAddr_1
   assign mux_ICS_c405RdWrAddr_M[1] = (sc_fcRdWdAddrL2[1] & ~(bypass)) | (PLB_icsRdWrAddr[1] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405RdWdAddr_2
   assign mux_ICS_c405RdWrAddr_M[2] = (sc_fcRdWdAddrL2[2] & ~(bypass)) | (PLB_icsRdWrAddr[2] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405RdWdAddr_3
   assign mux_ICS_c405RdWrAddr_M[3] = (sc_fcRdWdAddrL2[3] & ~(bypass)) | (PLB_icsRdWrAddr[3] & bypass);

   // Replacing instantiation: MUX21 mux_ICS_c405IcuBusy
   assign mux_ICS_c405IcuBusy_M = (busyOrReset & ~(bypass)) | (PLB_icsIcuBusy & bypass);

   // Replacing instantiation: INVERT inv_ICS_plbRequest1
   assign inv_ICS_plbRequest_N = ~(mux_ICS_plbRequest_M);
 
   // Replacing instantiation: INVERT inv_ICS_plbRequest2
   assign ICS_plbRequest = ~(inv_ICS_plbRequest_N);

   // Replacing instantiation: INVERT inv_ICS_plbAbort1
   assign inv_ICS_plbAbort_N = ~(mux_ICS_plbAbort_M);
 
   // Replacing instantiation: INVERT inv_ICS_plbAbort2
   assign ICS_plbAbort = ~(inv_ICS_plbAbort_N);
 
   // Replacing instantiation: INVERT inv_ICS_plbCacheable1
   assign inv_ICS_plbCacheable_N = ~(mux_ICS_plbCacheable_M);
 
   // Replacing instantiation: INVERT inv_ICS_plbCacheable2
   assign ICS_plbCacheable = ~(inv_ICS_plbCacheable_N);

   // Replacing instantiation: INVERT inv_ICS_plbU0Attr1
   assign inv_ICS_plbU0Attr_N = ~(mux_ICS_plbU0Attr_M);
 
   // Replacing instantiation: INVERT inv_ICS_plbU0Attr2
   assign ICS_plbU0Attr = ~(inv_ICS_plbU0Attr_N);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbTranSize1
   assign inv_ICS_plbTranSize_N[2:3] = ~(mux_ICS_plbTranSize_M[2:3]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbTranSize2
   assign ICS_plbTranSize[2:3] = ~(inv_ICS_plbTranSize_N[2:3]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbABus1
   assign inv_ICS_plbABus_N[0:29] = ~(mux_ICS_plbABus_M[0:29]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbABus2
   assign ICS_plbABus[0:29] = ~(inv_ICS_plbABus_N[0:29]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbPriority1
   assign inv_ICS_plbPriority_N[0:1] = ~(mux_ICS_plbPriority_M[0:1]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_plbPriority2
   assign ICS_plbPriority[0:1] = ~(inv_ICS_plbPriority_N[0:1]);
 
   // Replacing instantiation: INVERT inv_ICS_c405IcuBusy1
   assign inv_ICS_c405IcuBusy_N = ~(mux_ICS_c405IcuBusy_M);
 
   // Replacing instantiation: INVERT inv_ICS_c405IcuBusy2
   assign ICS_c405IcuBusy = ~(inv_ICS_c405IcuBusy_N);
 
   // Replacing instantiation: GS_INVERT dp_logICS_c405RdWrAddr1
   assign inv_ICS_c405RdWrAddr_N[1:3] = ~(mux_ICS_c405RdWrAddr_M[1:3]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_c405RdWrAddr2
   assign ICS_c405RdWrAddr[1:3] = ~(inv_ICS_c405RdWrAddr_N[1:3]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_c405DBus1
   assign inv_ICS_c405DBus_N[0:63] = ~(mux_ICS_c405DBus_M[0:63]);
 
   // Replacing instantiation: GS_INVERT dp_logICS_c405DBus2
   assign ICS_c405DBus[0:63] = ~(inv_ICS_c405DBus_N[0:63]);

   // Replacing instantiation: INVERT inv_ICS_c405AddrAck1
   assign inv_ICS_c405AddrAck_N = ~(mux_ICS_c405AddrAck_M);
 
   // Replacing instantiation: INVERT inv_ICS_c405AddrAck2
   assign ICS_c405AddrAck = ~(inv_ICS_c405AddrAck_N);
 
   // Replacing instantiation: INVERT inv_ICS_c405SSize1
   assign inv_ICS_c405SSize_N = ~(mux_ICS_c405SSize_M);
 
   // Replacing instantiation: INVERT inv_ICS_c405SSize2
   assign ICS_c405SSize = ~(inv_ICS_c405SSize_N);

   // Replacing instantiation: INVERT inv_ICS_c405RdDAck1
   assign inv_ICS_c405RdDAck_N = ~(mux_ICS_c405RdDAck_M);
 
   // Replacing instantiation: INVERT inv_ICS_c405RdDAck2
   assign ICS_c405RdDAck = ~(inv_ICS_c405RdDAck_N);
 
   // Replacing instantiation: INVERT inv_ICS_c405Error1
   assign inv_ICS_c405Error_N = ~(mux_ICS_c405Error_M);
 
   // Replacing instantiation: INVERT inv_ICS_c405Error2
   assign ICS_c405Error = ~(inv_ICS_c405Error_N);



endmodule

////////////// stop signals and block Aack and Dack  /////////////////////////////

