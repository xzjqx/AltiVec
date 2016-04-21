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
// JBB  08/01/01   1792   Added instantiation of dp_regEXE_dofDregParErr,
//                        input signal (DCU_parityError), and output signal
//                        EXE_dofDregParityErrL2.  Broke scan chain/added new
//                        register to scan chain after dRegByte3 (changed SO
//                        of dRegByte3 from SO to dRegByte3SO and made that the SI
//                        to dp_regEXE_dofDregParErr; made SO of dp_regEXE_dofDregParErr
//                        the SO for the whole chain)
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1
// JBB  09/14/01   1889   Changed instantiation of dp_reg EXE_dofDregParityErr to be 
//                        a 4 port enabling latch similar to dp_regEXE_dofDreg. Made this
//                        change so as to correspond/match gate level changes for 4.0. 
//
module p405s_loadSteering( EXE_apuLoadData, EXE_dvc1ByteCmp, EXE_dvc2ByteCmp, 
     dRegBypass, gprLpIn, CB, DCU_SDQ_mod_NEG, DCU_data_NEG,
     LSSD_coreTestEn, OCM_dsData, PCL_apuTrcLoadEn, PCL_dRegBypassMuxSel, PCL_dRegE1,
     PCL_dofDregE1, PCL_dofDregMuxSel, PCL_dvcByteEnL2, PCL_dvcCmpEn, PCL_ldAdjE1,
     PCL_ldAdjE2, PCL_ldAdjMuxSel, PCL_ldFillByPassMuxSel, PCL_ldMuxSel,
     PCL_ldSteerMuxSel, dvc1L2, dvc2L2, DCU_parityError,
     EXE_dofDregParityErrL2);
output  EXE_dofDregParityErrL2;

input  LSSD_coreTestEn, PCL_apuTrcLoadEn, PCL_dRegBypassMuxSel, PCL_dRegE1, PCL_dofDregE1,
     PCL_dvcCmpEn, PCL_ldAdjE1, DCU_parityError; 

output [0:31]  gprLpIn;
output [0:3]  EXE_dvc2ByteCmp;
output [0:31]  EXE_apuLoadData;
output [0:3]  EXE_dvc1ByteCmp;
output [0:31]  dRegBypass;


//input [0:4]  CB;
input CB;
input [0:31]  OCM_dsData;
input [0:31]  dvc1L2;
input [0:1]  PCL_dofDregMuxSel;
input [1:3]  PCL_ldAdjE2;
input [0:3]  PCL_dvcByteEnL2;
input [0:7]  PCL_ldMuxSel;
input [0:7]  PCL_ldSteerMuxSel;
input [0:31]  DCU_data_NEG;
input [0:5]  PCL_ldFillByPassMuxSel;
input [0:1]  PCL_ldAdjMuxSel;
input [0:31]  dvc2L2;
input [0:31]  DCU_SDQ_mod_NEG;

// Buses in the design

//wire  [0:7]  ldAdjByte3L2;

//wire  [0:7]  ldAdjByte1L2;

//wire  [0:7]  ldByte0;

wire  [0:31]  dofDregDvc;

wire  [0:31]  dofDregDvc_NEG;

wire  [0:31]  apuLoadData_NEG;

//wire  [0:31]  dRegL2;

//wire  [0:7]  ldAdjByte2L2;

wire  [4:5]  ldFillByPassMuxSel_NEG;

//wire  [0:7]  ldByte2;

//wire  [0:7]  ldByte1;

wire  [4:5]  ldFillByPassMuxSelBuf;

//wire  [0:31]  dofDreg_NEG;

wire  [0:31]  dofDregBuf;

//wire  [0:7]  ldByte3;

wire  [0:2]  ldSteerInvBit16Buf;

//wire  [0:31]  ldSteerInv;

wire  [0:31]  ocmData_NEG;

reg [0:7] ldByte0;
reg [0:31] regEXE_dofDreg_muxout;
reg [0:31] dofDreg_NEG;
reg regEXE_dofDregParErr_muxout;
reg EXE_dofDregParityErrL2_i;
wire EXE_dofDregParityErrL2;
reg [24:31] regEXE_dRegByte3_muxout;
reg [0:31] dRegL2;
reg [16:23] regEXE_dRegByte2_muxout;
reg [8:15] regEXE_dRegByte1_muxout;
reg [0:7] regEXE_dRegByte0_muxout;
reg [0:7] regEXE_ldAdjByte3_muxout;
reg [0:7]  ldAdjByte3L2;
reg [0:7] regEXE_ldAdjByte2_muxout;
reg [0:7] ldAdjByte2L2;
reg [0:7] regEXE_ldAdjByte1_muxout;
reg [0:7] ldAdjByte1L2;
reg [0:7] ldByte3;
reg [0:7] ldByte2;
reg [0:7] ldByte1;
reg [0:31] dRegBypass_i;
wire [0:31] dRegBypass;
reg [0:31] ldSteerInv;

//specify
//    specparam CDS_LIBNAME  = "PR_exe";
//    specparam CDS_CELLNAME = "loadSteering";
//    specparam CDS_VIEWNAME = "schematic";
//endspecify

   // Replacing instantiation: GTECH_XOR2 I78
   wire dvcCmpEn;
   assign dvcCmpEn = PCL_dvcCmpEn ^ LSSD_coreTestEn;

//dp_logEXE_ldFillByPassMSInv2 logEXE_ldFillByPassMSInv2(ldFillByPassMuxSel_NEG[4:5],
//     ldFillByPassMuxSelBuf[4:5]);
// Removed the module 'dp_logEXE_ldFillByPassMSInv2'
assign ldFillByPassMuxSelBuf[4:5] = ~(ldFillByPassMuxSel_NEG[4:5]);
//dp_logEXE_ldFillByPassMSInv1 logEXE_ldFillByPassMSInv1(PCL_ldFillByPassMuxSel[4:5],
//     ldFillByPassMuxSel_NEG[4:5]);
// Removed the module 'dp_logEXE_ldFillByPassMSInv1'
assign ldFillByPassMuxSel_NEG[4:5] = ~(PCL_ldFillByPassMuxSel[4:5]);
//dp_logEXE_ldFillByPass3 logEXE_ldFillByPass3(ldSteerInv[24:31], {ldFillByPassMuxSelBuf[5],
//     ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5],
//     ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5],
//     ldFillByPassMuxSelBuf[5]}, dRegBypass[24:31]);
// Removed the module 'dp_logEXE_ldFillByPass3'
assign dRegBypass = dRegBypass_i;
always @(ldSteerInv or ldFillByPassMuxSelBuf)
begin
  dRegBypass_i[24:31] = ~( ldSteerInv[24:31] | {ldFillByPassMuxSelBuf[5],
     ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5],
     ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5], ldFillByPassMuxSelBuf[5],
     ldFillByPassMuxSelBuf[5]} );
end

//dp_logEXE_ldFillByPass2 logEXE_ldFillByPass2(ldSteerInv[16:23], {ldFillByPassMuxSelBuf[4],
//     ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4],
//     ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4],
//     ldFillByPassMuxSelBuf[4]}, dRegBypass_i[16:23]);
// Removed the module 'dp_logEXE_ldFillByPass2'
always @(ldSteerInv or ldFillByPassMuxSelBuf)
begin
  dRegBypass_i[16:23] =  ~( ldSteerInv[16:23] | {ldFillByPassMuxSelBuf[4],
     ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4],
     ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4], ldFillByPassMuxSelBuf[4],
     ldFillByPassMuxSelBuf[4]} ); 
end

//dp_logEXE_apuLdDataLoNOR2CINV logEXE_apuLdDataLoNOR2CINV(dofDregBuf[16:31], PCL_apuTrcLoadEn,
//     apuLoadData_NEG[16:31]);
// Removed the module 'dp_logEXE_apuLdDataLoNOR2CINV'
assign apuLoadData_NEG[16:31] = ~( dofDregBuf[16:31] | ~({(16){PCL_apuTrcLoadEn}}) );
//dp_logEXE_apuLdDataHiNOR2CINV logEXE_apuLdDataHiNOR2CINV(dofDregBuf[0:15], PCL_apuTrcLoadEn,
//     apuLoadData_NEG[0:15]);
// Removed the module 'dp_logEXE_apuLdDataHiNOR2CINV'
assign apuLoadData_NEG[0:15] = ~( dofDregBuf[0:15] | ~({(16){PCL_apuTrcLoadEn}}) );
//dp_logEXE_dofDregDvcLoNOR2CINV logEXE_dofDregDvcLoNOR2CINV(dofDregBuf[16:31], dvcCmpEn,
//     dofDregDvc_NEG[16:31]);
// Removed the module 'dp_logEXE_dofDregDvcLoNOR2CINV'
assign dofDregDvc_NEG[16:31] = ~( dofDregBuf[16:31] | ~({(16){dvcCmpEn}}) );
//dp_logEXE_dofDregDvcHiNOR2CINV logEXE_dofDregDvcHiNOR2CINV(dofDregBuf[0:15], dvcCmpEn,
//     dofDregDvc_NEG[0:15]);
// Removed the module 'dp_logEXE_dofDregDvcHiNOR2CINV'
assign dofDregDvc_NEG[0:15] = ~( dofDregBuf[0:15] | ~({(16){dvcCmpEn}}) );
//dp_logEXE_dofDregDvcINV logEXE_dofDregDvcINV(dofDregDvc_NEG[0:31], dofDregDvc[0:31]);
// Removed the module 'dp_logEXE_dofDregDvcINV'
assign dofDregDvc[0:31] = ~(dofDregDvc_NEG[0:31]);
//dp_logEXE_dofDregBufINV logEXE_dofDregBufINV(dofDreg_NEG[0:31], dofDregBuf[0:31]);
// Removed the module 'dp_logEXE_dofDregBufINV'
assign dofDregBuf[0:31] = ~(dofDreg_NEG[0:31]);
//dp_logEXE_apuLdDataINV logEXE_apuLdDataINV(apuLoadData_NEG[0:31], EXE_apuLoadData[0:31]);
// Removed the module 'dp_logEXE_apuLdDataINV'
assign EXE_apuLoadData[0:31] = ~(apuLoadData_NEG[0:31]);
//dp_logEXE_ldSteerBit16Buf logEXE_ldSteerBit16Buf({ldSteerInv[16], ldSteerInv[16],
//     ldSteerInv[16]}, ldSteerInvBit16Buf[0:2]);
// Removed the module 'dp_logEXE_ldSteerBit16Buf'
assign ldSteerInvBit16Buf[0:2] = {ldSteerInv[16], ldSteerInv[16],ldSteerInv[16]};

p405s_ldStDVC
 ldStDVCFunc(
  .EXE_dvc1ByteCmp(EXE_dvc1ByteCmp[0:3]),
  .EXE_dvc2ByteCmp(EXE_dvc2ByteCmp[0:3]),
  .dvc2L2(dvc2L2[0:31]),
  .dvc1L2(dvc1L2[0:31]),
  .dofDreg(dofDregDvc[0:31]),
  .PCL_dvcByteEnL2(PCL_dvcByteEnL2[0:3]));

//dp_muxEXE_ldByte0 muxEXE_ldByte0(DCU_data_NEG[0:7], ocmData_NEG[0:7], dofDreg_NEG[0:7],
//     {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0}, PCL_ldMuxSel[0:1], ldByte0[0:7]);
// Removed the module 'dp_muxEXE_ldByte0'
always @(PCL_ldMuxSel or DCU_data_NEG or ocmData_NEG or dofDreg_NEG) 
    begin                                           
    case(PCL_ldMuxSel[0:1])                       
     2'b00: ldByte0[0:7] = ~DCU_data_NEG[0:7];
     2'b01: ldByte0[0:7] = ~ocmData_NEG[0:7];   
     2'b10: ldByte0[0:7] = ~dofDreg_NEG[0:7];   
     2'b11: ldByte0[0:7] = ~{1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};   
      default: ldByte0[0:7] = 8'bx;   
    endcase                                    
   end 
//dp_logEXE_ocmDataInv logEXE_ocmDataInv(OCM_dsData[0:31], ocmData_NEG[0:31]);
// Removed the module 'dp_logEXE_ocmDataInv'
assign ocmData_NEG[0:31] = ~(OCM_dsData[0:31]);
//dp_regEXE_dofDreg regEXE_dofDreg(CB[0:4], DCU_data_NEG[0:31], ocmData_NEG[0:31],
//     {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, DCU_SDQ_mod_NEG[0:31], PCL_dofDregE1, SI,
//     PCL_dofDregMuxSel[0:1], dofDreg_NEG[0:31], dofDregSO);
// Removed the module 'dp_regEXE_dofDreg'
always @(DCU_data_NEG or ocmData_NEG or DCU_SDQ_mod_NEG or PCL_dofDregMuxSel)
    begin                                       
    casez(PCL_dofDregMuxSel[0:1])                    
     2'b00: regEXE_dofDreg_muxout = DCU_data_NEG[0:31];
     2'b01: regEXE_dofDreg_muxout = ocmData_NEG[0:31];  
     2'b10: regEXE_dofDreg_muxout = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
     1'b0, 1'b0};  
     2'b11: regEXE_dofDreg_muxout = DCU_SDQ_mod_NEG[0:31];  
      default: regEXE_dofDreg_muxout = 32'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dofDregE1)
     1'b0: dofDreg_NEG[0:31] <= dofDreg_NEG[0:31];                
     1'b1: dofDreg_NEG[0:31] <= regEXE_dofDreg_muxout;       
      default: dofDreg_NEG[0:31] <= 32'bx;  
    endcase                             
   end  
//dp_muxEXE_dRegByPass muxEXE_dRegByPass(dRegL2[0:31], dRegBypass_i[0:31], PCL_dRegBypassMuxSel,
//     gprLpIn[0:31]);
// Removed the module 'dp_muxEXE_dRegByPass'
assign gprLpIn[0:31] = (dRegL2[0:31] & {(32){~(PCL_dRegBypassMuxSel)}} ) | (dRegBypass_i[0:31] & {(32){PCL_dRegBypassMuxSel}} );

//dp_regEXE_dofDregParErr regEXE_dofDregParErr(CB[0:4], DCU_parityError, 1'b0, 1'b0, 1'b0,
//     PCL_dofDregE1, dRegByte3SO,  PCL_dofDregMuxSel[0:1], EXE_dofDregParityErrL2, SO);
// Removed the module 'dp_regEXE_dofDregParErr'
assign EXE_dofDregParityErrL2 = EXE_dofDregParityErrL2_i;
always @(DCU_parityError or PCL_dofDregMuxSel)
    begin                                       
    casez(PCL_dofDregMuxSel[0:1])
     2'b00: regEXE_dofDregParErr_muxout = DCU_parityError;
     2'b01: regEXE_dofDregParErr_muxout = 1'b0;
     2'b10: regEXE_dofDregParErr_muxout = 1'b0;
     2'b11: regEXE_dofDregParErr_muxout = 1'b0;
      default: regEXE_dofDregParErr_muxout = 1'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dofDregE1)                    
     1'b0: EXE_dofDregParityErrL2_i <= EXE_dofDregParityErrL2_i;                
     1'b1: EXE_dofDregParityErrL2_i <= regEXE_dofDregParErr_muxout;       
      default: EXE_dofDregParityErrL2_i <= 1'bx;  
    endcase                             
   end 
//dp_regEXE_dRegByte3 regEXE_dRegByte3(CB[0:4], ldSteerInv[24:31], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, PCL_dRegE1, dRegByte2SO, PCL_ldFillByPassMuxSel[5],
//     dRegL2[24:31], dRegByte3SO);
// Removed the module 'dp_regEXE_dRegByte3'
reg [24:31] dRegL2_L2;
always @(dRegL2_L2)
begin
  dRegL2[24:31] = ~(dRegL2_L2);
end
always @(ldSteerInv or PCL_ldFillByPassMuxSel)
    begin                                       
    casez(PCL_ldFillByPassMuxSel[5])
     1'b0: regEXE_dRegByte3_muxout = ldSteerInv[24:31];
     1'b1: regEXE_dRegByte3_muxout = {1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};   
      default: regEXE_dRegByte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dRegE1)                    
     1'b0: dRegL2_L2[24:31] <= dRegL2_L2[24:31];                
     1'b1: dRegL2_L2[24:31] <= regEXE_dRegByte3_muxout;       
      default: dRegL2_L2[24:31] <= 8'bx;  
    endcase                             
   end 
//dp_regEXE_dRegByte2 regEXE_dRegByte2(CB[0:4], ldSteerInv[16:23], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, PCL_dRegE1, dRegByte1SO, PCL_ldFillByPassMuxSel[4],
//     dRegL2[16:23], dRegByte2SO);
// Removed the module 'dp_regEXE_dRegByte2'
reg [16:23] dRegL2_23;
always @(dRegL2_23)
begin
  dRegL2[16:23] = ~(dRegL2_23[16:23]);
end
always @(ldSteerInv or PCL_ldFillByPassMuxSel)
    begin                                       
    casez(PCL_ldFillByPassMuxSel[4])
     1'b0: regEXE_dRegByte2_muxout = ldSteerInv[16:23]; 
     1'b1: regEXE_dRegByte2_muxout = {1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};   
      default: regEXE_dRegByte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dRegE1)                    
     1'b0: dRegL2_23[16:23] <= dRegL2_23[16:23];                
     1'b1: dRegL2_23[16:23] <= regEXE_dRegByte2_muxout;       
      default: dRegL2_23[16:23] <= 8'bx;  
    endcase                             
   end 
//dp_regEXE_dRegByte1 regEXE_dRegByte1(CB[0:4], ldSteerInv[8:15], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, {ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
//     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
//     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2]}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, PCL_dRegE1, dRegByte0SO, PCL_ldFillByPassMuxSel[2:3],
//     dRegL2[8:15], dRegByte1SO);
// Removed the module 'dp_regEXE_dRegByte1'
reg [8:15] dRegL2_L22;
always @(dRegL2_L22)
begin
  dRegL2[8:15] = ~(dRegL2_L22);
end
always @(ldSteerInv or ldSteerInvBit16Buf or PCL_ldFillByPassMuxSel)
    begin                                       
    casez(PCL_ldFillByPassMuxSel[2:3])
     2'b00: regEXE_dRegByte1_muxout = ldSteerInv[8:15];
     2'b01: regEXE_dRegByte1_muxout = {1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};  
     2'b10: regEXE_dRegByte1_muxout = {ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2]};  
     2'b11: regEXE_dRegByte1_muxout = {1'b0,1'b0, 1'b0, 1'b0, 1'b0, 1'b0,1'b0, 1'b0};  
      default: regEXE_dRegByte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dRegE1)                    
     1'b0: dRegL2_L22[8:15] <= dRegL2_L22[8:15];                
     1'b1: dRegL2_L22[8:15] <= regEXE_dRegByte1_muxout;       
      default: dRegL2_L22[8:15] <= 8'bx;  
    endcase                             
   end  
//dp_regEXE_dRegByte0 regEXE_dRegByte0(CB[0:4], ldSteerInv[0:7], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, {ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
//     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
//     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2]}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, PCL_dRegE1, ldAdjByte3SO,
//     PCL_ldFillByPassMuxSel[0:1], dRegL2[0:7], dRegByte0SO);
// Removed the module 'dp_regEXE_dRegByte0'
reg [0:7] dRegL2_7;
always @(dRegL2_7)
begin
  dRegL2[0:7] = ~(dRegL2_7);
end
always @(ldSteerInv or ldSteerInvBit16Buf or PCL_ldFillByPassMuxSel)
    begin                                       
    casez(PCL_ldFillByPassMuxSel[0:1])                    
     2'b00: regEXE_dRegByte0_muxout = ldSteerInv[0:7];
     2'b01: regEXE_dRegByte0_muxout = {1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};  
     2'b10: regEXE_dRegByte0_muxout = {ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2],
     ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2], ldSteerInvBit16Buf[2]};  
     2'b11: regEXE_dRegByte0_muxout = {1'b0,1'b0, 1'b0, 1'b0, 1'b0, 1'b0,1'b0, 1'b0};  
      default: regEXE_dRegByte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_dRegE1)                    
     1'b0: dRegL2_7[0:7] <= dRegL2_7[0:7];                
     1'b1: dRegL2_7[0:7] <= regEXE_dRegByte0_muxout;       
      default: dRegL2_7[0:7] <= 8'bx;  
    endcase                             
   end 

//dp_regEXE_ldAdjByte3 regEXE_ldAdjByte3(CB[0:4], ldAdjByte3L2[0:7], ocmData_NEG[24:31],
//     DCU_data_NEG[24:31], dofDreg_NEG[24:31], PCL_ldAdjE1, PCL_ldAdjE2[3], ldAdjByte2SO,
//     PCL_ldAdjMuxSel[0:1], ldAdjByte3L2[0:7], ldAdjByte3SO);
// Removed the module 'dp_regEXE_ldAdjByte3'
always @(ldAdjByte3L2 or ocmData_NEG or DCU_data_NEG or dofDreg_NEG or PCL_ldAdjMuxSel)
    begin                                       
    casez(PCL_ldAdjMuxSel[0:1])                    
     2'b00: regEXE_ldAdjByte3_muxout = ldAdjByte3L2[0:7];
     2'b01: regEXE_ldAdjByte3_muxout = ocmData_NEG[24:31];  
     2'b10: regEXE_ldAdjByte3_muxout = DCU_data_NEG[24:31];  
     2'b11: regEXE_ldAdjByte3_muxout = dofDreg_NEG[24:31];  
      default: regEXE_ldAdjByte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez((PCL_ldAdjE1 & PCL_ldAdjE2[3]))                        
     1'b0: ldAdjByte3L2[0:7] <= ldAdjByte3L2[0:7];                
     1'b1: ldAdjByte3L2[0:7] <= regEXE_ldAdjByte3_muxout;       
      default: ldAdjByte3L2[0:7] <= 8'bx;  
    endcase                             
   end  
//dp_regEXE_ldAdjByte2 regEXE_ldAdjByte2(CB[0:4], ldAdjByte2L2[0:7], ocmData_NEG[16:23],
//     DCU_data_NEG[16:23], dofDreg_NEG[16:23], PCL_ldAdjE1, PCL_ldAdjE2[2], ldAdjByte1SO,
//     PCL_ldAdjMuxSel[0:1], ldAdjByte2L2[0:7], ldAdjByte2SO);
// Removed the module 'dp_regEXE_ldAdjByte2'
always @(ldAdjByte2L2 or ocmData_NEG or DCU_data_NEG or dofDreg_NEG or PCL_ldAdjMuxSel)
    begin                                       
    casez(PCL_ldAdjMuxSel[0:1])                    
     2'b00: regEXE_ldAdjByte2_muxout = ldAdjByte2L2[0:7];
     2'b01: regEXE_ldAdjByte2_muxout = ocmData_NEG[16:23];  
     2'b10: regEXE_ldAdjByte2_muxout = DCU_data_NEG[16:23];  
     2'b11: regEXE_ldAdjByte2_muxout = dofDreg_NEG[16:23];  
      default: regEXE_ldAdjByte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_ldAdjE1 & PCL_ldAdjE2[2])
     1'b0: ldAdjByte2L2[0:7] <= ldAdjByte2L2[0:7];                
     1'b1: ldAdjByte2L2[0:7] <= regEXE_ldAdjByte2_muxout;       
      default: ldAdjByte2L2[0:7] <= 8'bx;  
    endcase                             
   end 
//dp_regEXE_ldAdjByte1 regEXE_ldAdjByte1(CB[0:4], ldAdjByte1L2[0:7], ocmData_NEG[8:15],
//     DCU_data_NEG[8:15], dofDreg_NEG[8:15], PCL_ldAdjE1, PCL_ldAdjE2[1], dofDregSO,
//     PCL_ldAdjMuxSel[0:1], ldAdjByte1L2[0:7], ldAdjByte1SO);
// Removed the module 'dp_regEXE_ldAdjByte1'
always @(ldAdjByte1L2 or ocmData_NEG or DCU_data_NEG or dofDreg_NEG or PCL_ldAdjMuxSel)
    begin                                       
    casez(PCL_ldAdjMuxSel[0:1])
     2'b00: regEXE_ldAdjByte1_muxout = ldAdjByte1L2[0:7];
     2'b01: regEXE_ldAdjByte1_muxout = ocmData_NEG[8:15];  
     2'b10: regEXE_ldAdjByte1_muxout = DCU_data_NEG[8:15];  
     2'b11: regEXE_ldAdjByte1_muxout = dofDreg_NEG[8:15];  
      default: regEXE_ldAdjByte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(PCL_ldAdjE1 & PCL_ldAdjE2[1])
     1'b0: ldAdjByte1L2[0:7] <= ldAdjByte1L2[0:7];                
     1'b1: ldAdjByte1L2[0:7] <= regEXE_ldAdjByte1_muxout;       
      default: ldAdjByte1L2[0:7] <= 8'bx;  
    endcase                             
   end 
//dp_muxEXE_ldByte3 muxEXE_ldByte3(DCU_data_NEG[24:31], ocmData_NEG[24:31], dofDreg_NEG[24:31],
//     ldAdjByte3L2[0:7], PCL_ldMuxSel[6:7], ldByte3[0:7]);
// Removed the module 'dp_muxEXE_ldByte3'
always @(DCU_data_NEG or ocmData_NEG or dofDreg_NEG or ldAdjByte3L2 or PCL_ldMuxSel)
    begin                                           
    case(PCL_ldMuxSel[6:7])                       
     2'b00: ldByte3[0:7] = ~DCU_data_NEG[24:31];
     2'b01: ldByte3[0:7] = ~ocmData_NEG[24:31];   
     2'b10: ldByte3[0:7] = ~dofDreg_NEG[24:31];   
     2'b11: ldByte3[0:7] = ~ldAdjByte3L2[0:7];   
      default: ldByte3[0:7] = 8'bx;   
    endcase                                    
   end 
//dp_muxEXE_ldByte2 muxEXE_ldByte2(DCU_data_NEG[16:23], ocmData_NEG[16:23], dofDreg_NEG[16:23],
//     ldAdjByte2L2[0:7], PCL_ldMuxSel[4:5], ldByte2[0:7]);
// Removed the module 'dp_muxEXE_ldByte2'
always @(PCL_ldMuxSel or DCU_data_NEG or ocmData_NEG or dofDreg_NEG or ldAdjByte2L2)
    begin                                           
    case(PCL_ldMuxSel[4:5])                       
     2'b00: ldByte2[0:7] = ~DCU_data_NEG[16:23];
     2'b01: ldByte2[0:7] = ~ocmData_NEG[16:23];   
     2'b10: ldByte2[0:7] = ~dofDreg_NEG[16:23];   
     2'b11: ldByte2[0:7] = ~ldAdjByte2L2[0:7];   
      default: ldByte2[0:7] = 8'bx;   
    endcase                                    
   end
//dp_muxEXE_ldByte1 muxEXE_ldByte1(DCU_data_NEG[8:15], ocmData_NEG[8:15], dofDreg_NEG[8:15],
//     ldAdjByte1L2[0:7], PCL_ldMuxSel[2:3], ldByte1[0:7]);
// Removed the module 'dp_muxEXE_ldByte1'
always @(PCL_ldMuxSel or DCU_data_NEG or ocmData_NEG or dofDreg_NEG or ldAdjByte1L2)
    begin                                           
    case(PCL_ldMuxSel[2:3])                       
     2'b00: ldByte1[0:7] = ~DCU_data_NEG[8:15];
     2'b01: ldByte1[0:7] = ~ocmData_NEG[8:15];   
     2'b10: ldByte1[0:7] = ~dofDreg_NEG[8:15];   
     2'b11: ldByte1[0:7] = ~ldAdjByte1L2[0:7];   
      default: ldByte1[0:7] = 8'bx;   
    endcase                                    
   end 
//dp_muxEXE_ldFillByPass1 muxEXE_ldFillByPass1(ldSteerInv[8:15], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, {ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0],
//     ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0],
//     ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0]}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, PCL_ldFillByPassMuxSel[2:3], dRegBypass_i[8:15]);
// Removed the module 'dp_muxEXE_ldFillByPass1'
always @(PCL_ldFillByPassMuxSel or ldSteerInvBit16Buf or ldSteerInv)
    begin                                           
    case(PCL_ldFillByPassMuxSel[2:3])                       
     2'b00: dRegBypass_i[8:15] = ~ldSteerInv[8:15];
     2'b01: dRegBypass_i[8:15] = ~{1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};   
     2'b10: dRegBypass_i[8:15] = ~{ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0],
     ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0],
     ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0], ldSteerInvBit16Buf[0]};
     2'b11: dRegBypass_i[8:15] = ~{1'b0,1'b0, 1'b0, 1'b0, 1'b0, 1'b0,1'b0, 1'b0};   
      default: dRegBypass_i[8:15] = 8'bx;   
    endcase                                    
   end
//dp_muxEXE_ldFillByPass0 muxEXE_ldFillByPass0(ldSteerInv[0:7], {1'b1,
//     1'b1, 1'b1, 1'b1, 1'b1, 1'b1,
//     1'b1, 1'b1}, {ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1],
//     ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1],
//     ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1]}, {1'b0,
//     1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
//     1'b0, 1'b0}, PCL_ldFillByPassMuxSel[0:1], dRegBypass_i[0:7]);
// Removed the module 'dp_muxEXE_ldFillByPass0'
always @(PCL_ldFillByPassMuxSel or ldSteerInv or ldSteerInvBit16Buf)
    begin                                           
    case(PCL_ldFillByPassMuxSel[0:1])                       
     2'b00: dRegBypass_i[0:7] = ~ldSteerInv[0:7];
     2'b01: dRegBypass_i[0:7] = ~{1'b1,1'b1, 1'b1, 1'b1, 1'b1, 1'b1,1'b1, 1'b1};   
     2'b10: dRegBypass_i[0:7] = ~{ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1],
     ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1],
     ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1], ldSteerInvBit16Buf[1]};   
     2'b11: dRegBypass_i[0:7] = ~{1'b0,1'b0, 1'b0, 1'b0, 1'b0, 1'b0,1'b0, 1'b0};   
      default: dRegBypass_i[0:7] = 8'bx;   
    endcase                                    
   end
//dp_muxEXE_ldSteer3 muxEXE_ldSteer3(ldByte3[0:7], ldByte0[0:7], ldByte1[0:7], ldByte2[0:7],
//     PCL_ldSteerMuxSel[6:7], ldSteerInv[24:31]);
// Removed the module 'dp_muxEXE_ldSteer3'
always @(PCL_ldSteerMuxSel or ldByte3 or ldByte0 or ldByte1 or ldByte2)
    begin                                           
    case(PCL_ldSteerMuxSel[6:7])                       
     2'b00: ldSteerInv[24:31] = ~ldByte3[0:7];
     2'b01: ldSteerInv[24:31] = ~ldByte0[0:7];   
     2'b10: ldSteerInv[24:31] = ~ldByte1[0:7];   
     2'b11: ldSteerInv[24:31] = ~ldByte2[0:7];   
      default: ldSteerInv[24:31] = 8'bx;   
    endcase                                    
   end
//dp_muxEXE_ldSteer1 muxEXE_ldSteer1(ldByte1[0:7], ldByte2[0:7], ldByte3[0:7], ldByte0[0:7],
//     PCL_ldSteerMuxSel[2:3], ldSteerInv[8:15]);
// Removed the module 'dp_muxEXE_ldSteer1'
always @(PCL_ldSteerMuxSel or ldByte1 or ldByte2 or ldByte3 or ldByte0)
    begin                                           
    case(PCL_ldSteerMuxSel[2:3])
     2'b00: ldSteerInv[8:15] = ~ldByte1[0:7];
     2'b01: ldSteerInv[8:15] = ~ldByte2[0:7];   
     2'b10: ldSteerInv[8:15] = ~ldByte3[0:7];   
     2'b11: ldSteerInv[8:15] = ~ldByte0[0:7];   
      default: ldSteerInv[8:15] = 8'bx;   
    endcase                                    
   end
//dp_muxEXE_ldSteer2 muxEXE_ldSteer2(ldByte2[0:7], ldByte3[0:7], ldByte0[0:7], ldByte1[0:7],
//     PCL_ldSteerMuxSel[4:5], ldSteerInv[16:23]);
// Removed the module 'dp_muxEXE_ldSteer2'
always @(PCL_ldSteerMuxSel or ldByte2 or ldByte3 or ldByte0 or ldByte1)
    begin                                           
    case(PCL_ldSteerMuxSel[4:5])                       
     2'b00: ldSteerInv[16:23] = ~ldByte2[0:7];
     2'b01: ldSteerInv[16:23] = ~ldByte3[0:7];   
     2'b10: ldSteerInv[16:23] = ~ldByte0[0:7];   
     2'b11: ldSteerInv[16:23] = ~ldByte1[0:7];   
      default: ldSteerInv[16:23] = 8'bx;   
    endcase                                    
   end 
//dp_muxEXE_ldSteer0 muxEXE_ldSteer0(ldByte0[0:7], ldByte1[0:7], ldByte2[0:7], ldByte3[0:7],
//     PCL_ldSteerMuxSel[0:1], ldSteerInv[0:7]);
// Removed the module 'dp_muxEXE_ldSteer0'
always @(PCL_ldSteerMuxSel or ldByte0 or ldByte1 or ldByte2 or ldByte3)
    begin                                           
    case(PCL_ldSteerMuxSel[0:1])
     2'b00: ldSteerInv[0:7] = ~ldByte0[0:7];
     2'b01: ldSteerInv[0:7] = ~ldByte1[0:7];   
     2'b10: ldSteerInv[0:7] = ~ldByte2[0:7];   
     2'b11: ldSteerInv[0:7] = ~ldByte3[0:7];   
      default: ldSteerInv[0:7] = 8'bx;   
    endcase                                    
   end
endmodule
