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
// PGM  09/12/01   1878   Wire BIST outputs out to Core PO's


module p405s_mmu_BIST_Unit( ABIST_test,
                  BIST_DSize,
                  BIST_DT,
                  BIST_TID,
                  BIST_V,
                  BIST_addr,
                  BIST_data,
                  BIST_epn_ea,
                  BIST_invalidate,
                  BIST_lookupEn,
                  BIST_rdEn,
                  BIST_wrEn,
                  MMU_diagOut,
                  cbistError,
                  DVS,
                  LSSD_ArrayCClk_buf,
                  LSSD_TestM3_buf,
                  BIST_Done,
                  CB,
                  resetL2,
                  LSSD_TestM1,
                  UTLB_Miss,
                  BISTCE0STCLK,
                  BISTCE1ENABLE,
                  LSSD_BISTCClk,
                  UTLB_index,
                  dataComp,
                  tagComp,
                  cbistErrL2, 
                  dataErrL2, 
                  tagErrL2,
                  LSSD_EVS,
                  LSSD_TestM3);


output  ABIST_test;
output  BIST_DT;
output  BIST_V;
output  BIST_invalidate;
output  BIST_lookupEn;
output  BIST_rdEn;
output  BIST_wrEn;
output  cbistError;
output  cbistErrL2;
output  dataErrL2;
output  tagErrL2;
output  DVS;
output  LSSD_ArrayCClk_buf;
output  BIST_Done;
output  LSSD_TestM3_buf;


input  LSSD_TestM1;
input  UTLB_Miss;
input  dataComp;
input  tagComp;
input  LSSD_EVS;
input  BISTCE0STCLK;
input  BISTCE1ENABLE;
input  LSSD_BISTCClk;
input  LSSD_TestM3;

// added for tbird
//input         TIE_c405BypassE1E2;

output [0:6]   BIST_DSize;
output [0:7]   BIST_TID;
output [0:21]  BIST_epn_ea;
output [0:1]   MMU_diagOut;
output [0:5]   BIST_addr;
output [0:1]   BIST_data;


input [0:5]  UTLB_index;
input        CB;
input        resetL2;

// Buses in the design

wire  [0:6]  DSizeL2;
wire  [0:1]  EPN_EA_Tid_Sel;
wire  [0:1]  EPN_EA_Sel;
wire  [0:1]  dataL2;
wire  [0:7]  symNet123;
wire  [0:3]  BIST_StateL2;
wire  [0:5]  addrL2;
wire  [0:2]  symNet91;
wire  [0:1]  iterL2;
wire  [0:1]  databuff2;
wire  [0:7]  tidL2;
reg   [0:21]  epn_ea_L2;
wire  [0:1]  databuff1;
wire  [0:1]  iterIn;
wire  [0:3]  BIST_StateIn;
wire  [0:1]  modeL2;
reg   [0:0]  epn_ea_hi_in;
wire  [0:1]  DSize_DT_Sel;
wire         stop_evs;
wire  [0:1]  databuff3;
wire         ABIST_stuffE2;
wire         resetL2;
wire         oldBIST_rdEn;
wire         oldBIST_wrEn;
wire         oldBIST_lookupEn;

reg  [0:1]   MMU_diagOut;
reg  [0:2]   BISTErr_reg;  
reg  [0:15]  BIST_Tid_DSize_reg;  
reg  [0:21]  BIST_epn_ea_reg;
reg  [0:19]  ABIST_stuff_reg;

wire tagError;
wire  dataError;
wire  DT_L2;
wire  decrementIn;
wire  cntZeroIn;
wire  cntDoneIn;
wire  lookup1_cntDoneIn;
wire  decrementL2;
wire  cntZeroL2;
wire  cntDoneL2;
wire  lookup1_cntDoneL2;

wire  BIST_DT_i;
wire  cbistError_i;
wire  cbistErrL2_i;
wire  dataErrL2_i;
wire  tagErrL2_i;
wire [0:6]   BIST_DSize_i;
reg  [0:7]   BIST_TID_i;
wire [0:21]  BIST_epn_ea_i;
wire [0:5]   BIST_addr_i;
wire [0:1]   BIST_data_i;

wire  LSSD_TestM3_i;


  // Assignments so we don't read outputs
  assign BIST_DT = BIST_DT_i;
  assign cbistError = cbistError_i;
  assign cbistErrL2 = cbistErrL2_i;
  assign dataErrL2 = dataErrL2_i;
  assign tagErrL2 = tagErrL2_i;
  assign BIST_DSize = BIST_DSize_i;
  assign BIST_TID = BIST_TID_i;
  assign BIST_epn_ea = BIST_epn_ea_i;
  assign BIST_addr = BIST_addr_i;
  assign BIST_data = BIST_data_i;


// 2/18/02 KAM Changed for TBIRD
//assign BIST_Osc = BISTCE0STCLK & BISTCE1ENABLE;
   // Replacing instantiation: GTECH_AND2 UTLB_clockGate
   wire BISTCE0STCLK;
   wire BIST_Osc;
   assign BIST_Osc = BISTCE0STCLK & BISTCE1ENABLE;


// 05/30/02 KAM Added per Waleed's request
   // Replacing instantiation: GTECH_BUF TestM3Buf
   assign LSSD_TestM3_i = LSSD_TestM3;
   assign LSSD_TestM3_buf = LSSD_TestM3_i;


// 2/18/02 KAM Changed for TBIRD
//dp_regMMU_UTLBtestLtch_cam regMMU_UTLBtestLtch_cam(CB[0:4], {tagError, dataError}, symNet85,
//     MMU_diagOut[0:1], Scanout);

  // Removed the module "dp_regMMU_UTLBtestLtch_cam"
  always @(posedge BIST_Osc)      
    begin        
      MMU_diagOut[0:1] <= {tagError, dataError};      
    end        

// 05/28/02 KAM - removed the reset latch per Waleed's request
//dp_regMMU_reset regMMU_reset({BIST_Osc, CB[1:4]}, resetCore, symNet85, resetL2,
//   symNet86);

  // Removed the module "dp_logMMU_bistbuff1"
  assign {databuff1[0:1], databuff2[0:1], databuff3[0:1]} = {BIST_data_i[0:1], 
                                                     BIST_data_i[0:1], BIST_data_i[0:1]};

  // Removed the module "dp_logMMU_ErrHold"
  assign symNet91[0:2] = {tagError, dataError, cbistError_i} | 
                         {tagErrL2_i, dataErrL2_i,cbistErrL2_i};

// 2/18/02 KAM Changed for TBIRD
//dp_regMMU_BISTErr regMMU_BISTErr(CB[0:4], symNet91[0:2], LSSD_TestM1, symNet94, {tagErrL2,
//     dataErrL2, cbistErrL2}, symNet85);

  // Removed the module "dp_regMMU_BISTErr"
  always @(posedge BIST_Osc)      
    begin        
    if (~resetL2)
      casez(LSSD_TestM1)        
        1'b0: BISTErr_reg <= BISTErr_reg;        
        1'b1: BISTErr_reg <= symNet91[0:2];        
        default: BISTErr_reg <= 3'bx;  
      endcase        
    else
      BISTErr_reg <= 3'b0;
    end        

  assign {tagErrL2_i,dataErrL2_i, cbistErrL2_i} = BISTErr_reg;


// 05/28/02 KAM - removed the reset latch per Waleed's request
//GTECH_OR2  I102( .Z(ABIST_stuffE1), .B(resetL2), .A(LSSD_TestM1));
   // Replacing instantiation: GTECH_NOT I98
   wire rotate_cntl;
   wire symNet104;
   assign symNet104 = ~(rotate_cntl);

  // Removed the module "dp_muxMMU_BISTepn_ea0"
  assign BIST_epn_ea_i[0] = (rotate_cntl & ~(epn_ea_hi_in[0])) | 
                          (symNet104 & epn_ea_hi_in[0]);

// 2/18/02 KAM Changed for TBIRD
//dp_regMMU_BIST_Tid_DSize regMMU_BIST_Tid_DSize(CB[0:4], {BIST_TID[0:7], BIST_DSize[0:6],
//     BIST_DT}, LSSD_TestM1, symNet110, {tidL2[0:7], DSizeL2[0:6], DT_L2}, symNet94);
//dp_regMMU_BIST_epn_ea regMMU_BIST_epn_ea(CB[0:4], BIST_epn_ea[0:21], LSSD_TestM1, symNet116,
//     epn_ea_L2[0:21], symNet110);

  // Removed the module "dp_regMMU_BIST_Tid_DSize"
  always @(posedge BIST_Osc)      
    begin        
    if (~resetL2)
      casez(LSSD_TestM1)        
        1'b0: BIST_Tid_DSize_reg <= BIST_Tid_DSize_reg;        
        1'b1: BIST_Tid_DSize_reg <= {BIST_TID_i[0:7], BIST_DSize_i[0:6],BIST_DT_i};        
        default: BIST_Tid_DSize_reg <= 16'bx;  
      endcase         
    else
        BIST_Tid_DSize_reg <= 16'b0;  
    end        

  assign {tidL2[0:7], DSizeL2[0:6], DT_L2} = BIST_Tid_DSize_reg;

  // Removed the module "dp_regMMU_BIST_epn_ea"
  always @(posedge BIST_Osc)      
    begin        
    if (~resetL2)
      casez(LSSD_TestM1)        
        1'b0: epn_ea_L2[0:21] <= epn_ea_L2[0:21];        
        1'b1: epn_ea_L2[0:21] <= BIST_epn_ea_i[0:21];        
        default: epn_ea_L2[0:21] <= 22'bx;  
      endcase        
    else
        epn_ea_L2[0:21] <= 22'b0;  
    end        

  // Removed the module "dp_muxMMU_dsize_dt" 2 times
  assign symNet123[0:7] = ({8{1'b0}} & {8{~(DSize_DT_Sel[1])}} ) |
                          ({8{1'b1}} & {8{DSize_DT_Sel[1]}} );

  assign {BIST_DSize_i[0:6], BIST_DT_i} = (symNet123[0:7] & {(8){~(DSize_DT_Sel[0])}} ) |
                                      ({databuff3[0:1], databuff3[0:1],databuff3[0:1],
                                        databuff3[0:1]} & {(8){DSize_DT_Sel[0]}} );

  // Removed the module "dp_muxMMU_tid"
  always @(EPN_EA_Tid_Sel or epn_ea_L2 or tidL2 or databuff3) 
    begin
      case(EPN_EA_Tid_Sel[0:1])
        2'b00: BIST_TID_i[0:7] = {epn_ea_L2[21], tidL2[0:6]};
        2'b01: BIST_TID_i[0:7] = {4{databuff3[0:1]}};
        2'b10: BIST_TID_i[0:7] = {8{1'b1}};
        2'b11: BIST_TID_i[0:7] = {8{1'b0}};
        default: BIST_TID_i[0:7] = 8'bx;
      endcase
    end


  // Removed the module "dp_muxMMU_epn_ea_low"
  always @(EPN_EA_Tid_Sel or epn_ea_L2 or databuff2)
    begin
      case(EPN_EA_Tid_Sel[0:1])
        2'b00: BIST_epn_ea_reg[8:21] = epn_ea_L2[7:20];
        2'b01: BIST_epn_ea_reg[8:21] = {7{databuff2[0:1]}};
        2'b10: BIST_epn_ea_reg[8:21] = {14{1'b1}};
        2'b11: BIST_epn_ea_reg[8:21] = {14{1'b0}};
        default: BIST_epn_ea_reg[8:21] = 14'bx;
      endcase
    end
 
  assign BIST_epn_ea_i[8:21] = BIST_epn_ea_reg[8:21];

  // Removed the module "dp_muxMMU_epn_ea_hi"
  always @(EPN_EA_Sel or tidL2 or epn_ea_L2 or databuff1)
    begin
      case(EPN_EA_Sel[0:1])
        2'b00: {epn_ea_hi_in[0], BIST_epn_ea_reg[1:7]} = {tidL2[7], epn_ea_L2[0:6]};
        2'b01: {epn_ea_hi_in[0], BIST_epn_ea_reg[1:7]} = {4{databuff1[0:1]}};
        2'b10: {epn_ea_hi_in[0], BIST_epn_ea_reg[1:7]} = {8{1'b1}};
        2'b11: {epn_ea_hi_in[0], BIST_epn_ea_reg[1:7]} = {8{1'b0}};
        default: {epn_ea_hi_in[0], BIST_epn_ea_reg[1:7]} = 8'bx;
      endcase
    end

  assign BIST_epn_ea_i[1:7] = BIST_epn_ea_reg[1:7];

// changed for TBIRD 1/14/2002 KAM
//dp_regMMU_ABIST_stuff regMMU_ABIST_stuff(CB[0:4], {BIST_StateIn[0:3], iterIn[0:1],
//     BIST_addr[0:5], databuff1[0:1], modeL2[0:1], decrementIn, cntZeroIn, cntDoneIn,
//     lookup1_cntDoneIn}, {1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, symNet100, Scanin, resetL2, {BIST_StateL2[0:3],
//     iterL2[0:1], addrL2[0:5], dataL2[0:1], modeL2[0:1], decrementL2, cntZeroL2, cntDoneL2,
//     lookup1_cntDoneL2}, symNet116);
//BIST_Control BIST_Ctrl(BIST_StateIn[0:3], BIST_wrEn, BIST_rdEn, BIST_lookupEn, BIST_invalidate,
//     BIST_data[0:1], BIST_addr[0:5], decrementIn, BIST_V, iterIn[0:1], ABIST_test,
//     EPN_EA_Sel[0:1], EPN_EA_Tid_Sel[0:1], DSize_DT_Sel[0:1], rotate_cntl, tagError, dataError,
//     cbistError, cntZeroIn, cntDoneIn, lookup1_cntDoneIn, BIST_StateL2[0:3], LSSD_TestM1,
//     decrementL2, addrL2[0:5], modeL2[0:1], iterL2[0:1], UTLB_Miss, UTLB_index[0:5], tagComp,
//     dataComp, cntZeroL2, cntDoneL2, lookup1_cntDoneL2);

// 05/28/02 KAM - removed the reset latch changed EVS_gateoff to stop_evs
//assign ABIST_stuffE2 = resetL2 | ~EVS_gateoff;
assign ABIST_stuffE2 = ~stop_evs;

// changed for TBIRD 1/14/2002 KAM
//dp_regMMU_ABIST_stuff regMMU_ABIST_stuff(CB[0:4], {BIST_StateIn[0:3], iterIn[0:1],
//     BIST_addr[0:5], databuff1[0:1], modeL2[0:1], decrementIn, cntZeroIn, cntDoneIn,
//     lookup1_cntDoneIn}, {1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, ABIST_stuffE1,ABIST_stuffE2, Scanin, resetL2, {BIST_StateL2[0:3],
//     iterL2[0:1], addrL2[0:5], dataL2[0:1], modeL2[0:1], decrementL2, cntZeroL2, cntDoneL2,
//     lookup1_cntDoneL2}, symNet118);

// 05/28/02 KAM - reset was removed per Waleed's request
//changed E1 from ABIST_stffE1 to LSSD_TestM1 because reset was removed
// change the latche from a 2 port to a one port
//dp_regMMU_ABIST_stuff regMMU_ABIST_stuff({BIST_Osc,CB[1:4]}, {BIST_StateIn[0:3], iterIn[0:1],
//     BIST_addr[0:5], databuff1[0:1], modeL2[0:1], decrementIn, cntZeroIn, cntDoneIn,
//     lookup1_cntDoneIn}, {1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, LSSD_TestM1,ABIST_stuffE2, TIE_c405BypassE1E2, Scanin, resetL2, {BIST_StateL2[0:3],
//     iterL2[0:1], addrL2[0:5], dataL2[0:1], modeL2[0:1], decrementL2, cntZeroL2, cntDoneL2,
//     lookup1_cntDoneL2}, symNet118);

  // Removed the module "dp_regMMU_ABIST_stuff"
  always @(posedge BIST_Osc)      
    begin        
    if (~resetL2)
      casez(LSSD_TestM1 & ABIST_stuffE2)        
        1'b0: ABIST_stuff_reg <= ABIST_stuff_reg;        
        1'b1: ABIST_stuff_reg <= {BIST_StateIn[0:3], iterIn[0:1],BIST_addr_i[0:5], 
                               databuff1[0:1], modeL2[0:1], decrementIn, cntZeroIn, 
                               cntDoneIn,lookup1_cntDoneIn};        
        default: ABIST_stuff_reg <= 20'bx;  
      endcase        
    else
        ABIST_stuff_reg <= 20'b0;  
    end        

  assign {BIST_StateL2[0:3], iterL2[0:1], addrL2[0:5], dataL2[0:1], modeL2[0:1],
          decrementL2, cntZeroL2, cntDoneL2, lookup1_cntDoneL2} = ABIST_stuff_reg;

// added for TBIRD- KAM,1/14/02
// 05/28/02 KAM removed EVS latches per Waleed's request
//dp_regMMU_BIST_EVS regMMU_BIST_EVS
//                 (.D  ({LSSD_EVS,EVS_L2, (EVS_gateoff & ~resetL2)}),
//                  .L2 ({EVS_L2,  EVS2_L2,EVS_gateoffL2}),
//                  .CB ({BIST_Osc,CB[1:4]}), .I (symNet118), .SO (symNet115));

p405s_mmu_BIST_Control
 BIST_Ctrl( .BIST_StateIn       (BIST_StateIn[0:3]), 
                        .BIST_wrEn          (oldBIST_wrEn), 
                        .BIST_rdEn          (oldBIST_rdEn), 
                        .BIST_lookupEn      (oldBIST_lookupEn), 
                        .BIST_invalidate    (BIST_invalidate),
                        .BIST_data          (BIST_data_i[0:1]), 
                        .BIST_addr          (BIST_addr_i[0:5]), 
                        .decrementIn        (decrementIn), 
                        .BIST_V             (BIST_V), 
                        .iterIn             (iterIn[0:1]), 
                        .ABIST_test         (ABIST_test),
                        .EPN_EA_Sel         (EPN_EA_Sel[0:1]), 
                        .EPN_EA_Tid_Sel     (EPN_EA_Tid_Sel[0:1]), 
                        .DSize_DT_Sel       (DSize_DT_Sel[0:1]), 
                        .rotate_cntl        (rotate_cntl), 
                        .tagError           (tagError), 
                        .dataError          (dataError),
                        .cbistError         (cbistError_i), 
                        .cntZeroIn          (cntZeroIn), 
                        .cntDoneIn          (cntDoneIn), 
                        .lookup1_cntDoneIn  (lookup1_cntDoneIn), 
                        .LSSD_ArrayCClk_buf (LSSD_ArrayCClk_buf),
                        .DVS                (DVS), 
                        .stop_evs           (stop_evs), 
                        .BIST_Done          (BIST_Done),
                        .BIST_StateL2       (BIST_StateL2[0:3]), 
                        .TestM1             (LSSD_TestM1),
                        .decrementL2        (decrementL2), 
                        .addrL2             (addrL2[0:5]), 
                        .modeL2             (modeL2[0:1]), 
                        .iterL2             (iterL2[0:1]), 
                        .UTLB_Miss          (UTLB_Miss), 
                        .UTLB_index         (UTLB_index[0:5]), 
                        .tagComp            (tagComp),
                        .dataComp           (dataComp), 
                        .cntZeroL2          (cntZeroL2), 
                        .cntDoneL2          (cntDoneL2), 
                        .lookup1_cntDoneL2  (lookup1_cntDoneL2),
                        .LSSD_EVS           (LSSD_EVS)
                        );

   // Replacing instantiation: PDP_P1EUL1 dp_regMMU_BISTL1latches
   reg [0:2] dp_regMMU_BISTL1latches_regL1;
   wire [0:2] dp_regMMU_BISTL1latches_D; 
   wire dp_regMMU_BISTL1latches_E1; 
   assign {BIST_wrEn, BIST_rdEn, BIST_lookupEn} = dp_regMMU_BISTL1latches_regL1;    
   assign dp_regMMU_BISTL1latches_E1 = LSSD_TestM1;     
   assign dp_regMMU_BISTL1latches_D = {oldBIST_wrEn, oldBIST_rdEn, oldBIST_lookupEn};       
                                           
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge BIST_Osc)  	
    begin				  	
    casez(dp_regMMU_BISTL1latches_E1)			
     1'b0: dp_regMMU_BISTL1latches_regL1 <= dp_regMMU_BISTL1latches_regL1;		
     1'b1: dp_regMMU_BISTL1latches_regL1 <= dp_regMMU_BISTL1latches_D;		
      default: dp_regMMU_BISTL1latches_regL1 <= dp_regMMU_BISTL1latches_regL1;  
    endcase		 		
   end			 		
`else                                 	
   // L1 Output modeled as a transparent latch     
   always @(BIST_Osc or dp_regMMU_BISTL1latches_D or dp_regMMU_BISTL1latches_E1)  	
    begin				  	
    casez(~BIST_Osc & dp_regMMU_BISTL1latches_E1)	
     1'b0: ;				
     1'b1: dp_regMMU_BISTL1latches_regL1 = dp_regMMU_BISTL1latches_D;		
      default: dp_regMMU_BISTL1latches_regL1 = dp_regMMU_BISTL1latches_regL1;  
    endcase		 		
   end			 		
`endif                                	

endmodule
