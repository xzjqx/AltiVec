//===============================================================================
//  File Name       : InstructionDecoder.v
//  File Revision   : 1.0
//  Date            : 2015/4/24
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : Instruction decoder (for students)
//  Function        : instruction dispatch, decoding and fetch oprand
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================

module InstructionDecoder(
               clk,
               rst_n,
               APU_AltiVec_DcdHold,
               in_Instruction,
               in_LSResult,
               in_PUResult,
               in_VSFXResult,
               in_VCFXResult,
               in_VFPUResult,
               in_RFAReadData,
               in_RFBReadData,
               in_RFCReadData,

               Dcd_LS_cs,
               Dcd_LSType,
               Dcd_LSRaEn,
               Dcd_PU_cs,
               Dcd_PUType,
               Dcd_VALU_cs,
               Dcd_VALUType,
               Dcd_en_mtvscr,
               Dcd_en_mfvscr,
               Dcd_RFReadRegAEn,
               Dcd_RFReadRegBEn,
               Dcd_RFReadRegCEn,
               Dcd_RF_VRA,
               Dcd_RF_VRB,
               Dcd_RF_VRC,
               Dcd_XTargetRegister,
               Dcd_AOperandMux,
               Dcd_BOperandMux,
               Dcd_COperandMux,
               Dcd_ValidAltivecOp,
               Dcd_APUCR6En,
               Dcd_ReadGPRA_En,
               Dcd_ReadGPRB_En,
               Dcd_ExeBusy
               );

//=============================================================================
// input and output declaration
//=============================================================================
input          clk;
input          rst_n;
input          APU_AltiVec_DcdHold;
input  [0: 31] in_Instruction;
input  [0:127] in_LSResult;
input  [0:127] in_PUResult;
input  [0:127] in_VSFXResult;
input  [0:127] in_VCFXResult;
input  [0:127] in_VFPUResult;
input  [0:127] in_RFAReadData;
input  [0:127] in_RFBReadData;
input  [0:127] in_RFCReadData;

output         Dcd_LS_cs;
output [0:  4] Dcd_LSType;
output         Dcd_LSRaEn;
output         Dcd_PU_cs;
output [0:  7] Dcd_PUType;
output [0:  1] Dcd_VALU_cs;
output [0:  9] Dcd_VALUType;
output         Dcd_en_mtvscr;
output         Dcd_en_mfvscr;
output         Dcd_RFReadRegAEn;
output         Dcd_RFReadRegBEn;
output         Dcd_RFReadRegCEn;
output [0:  4] Dcd_RF_VRA;
output [0:  4] Dcd_RF_VRB;
output [0:  4] Dcd_RF_VRC;
output [0:  4] Dcd_XTargetRegister;
output [0:127] Dcd_AOperandMux;
output [0:127] Dcd_BOperandMux;
output [0:127] Dcd_COperandMux;
output         Dcd_ValidAltivecOp;
output         Dcd_APUCR6En;
output         Dcd_ReadGPRA_En;
output         Dcd_ReadGPRB_En;
output         Dcd_ExeBusy;

//internal signals
wire           en_axc;
wire           Load_ins;
wire           Store_ins;
wire           PU_ins;
wire           VSFX_ins;
wire           VCFX_ins;
wire           VFPU_ins;
wire           mtvscr_ins;
wire           mfvscr_ins;
wire           AReadRegEnable;
wire           BReadRegEnable;
wire           CReadRegEnable;
wire   [0:  4] AOperand;
wire   [0:  4] BOperand;
wire   [0:  4] COperand;
wire   [0:  4] TargetRegister;
wire           CR6En;
reg            dpt_pu1;    //wire
reg            dpt_vsfx1;  //wire
reg            dpt_vcfx1;  //wire
reg            dpt_vfpu1;  //wire
reg            dpt_store1; //wire
reg            dpt_load1;  //wire
reg            dpt_load2;
reg            dpt_load3;
reg            dpt_load4;
reg            dpt_store2;
reg            dpt_pu2;
reg            dpt_vsfx2;
reg            dpt_vcfx2;
reg            dpt_vcfx3;
reg            dpt_vcfx4;
reg            dpt_vfpu2;
reg            dpt_vfpu3;
reg            dpt_vfpu4;
reg            dpt_vfpu5;
reg    [0:  4] TargetRegister_r1;
reg    [0:  4] TargetRegister_r2;
reg    [0:  4] TargetRegister_r3;
reg    [0:  4] TargetRegister_r4;
wire   [0:  9] dpt_Aexebusy; //RAW
wire   [0:  9] dpt_Bexebusy; //RAW
wire   [0:  9] dpt_Cexebusy; //RAW
wire   [0: 15] dpt_Texebusy; //WAW
wire   [0:  2] dpt_LSexebusy;//LS
reg    [0:  3] dpt_exebusy;  //wire
reg    [0:  3] dpt_exebusy_reg;
reg    [0: 31] dpt_Instruction;
wire           axc_cs;
wire           Load_cs;
wire           Store_cs;
wire           PU_cs;
wire           VSFX_cs;
wire           VCFX_cs;
wire           VFPU_cs;
wire           en_mtvscr;
wire           en_mfvscr;
wire   [0:  4] LSType;
wire           Load_RaEn;
wire           Store_RaEn;
wire   [0:  7] PUType;
wire   [0:  9] VALUType;
wire           dpt_AReadRegEn;
wire           dpt_BReadRegEn;
wire           dpt_CReadRegEn;
wire   [0:  4] dpt_AOperand;
wire   [0:  4] dpt_BOperand;
wire   [0:  4] dpt_COperand;
wire   [0:  4] dpt_TargetReg;
wire   [0:  4] AForwardEnable;
wire   [0:  4] BForwardEnable;
wire   [0:  4] CForwardEnable;
reg    [0:  4] LSType_reg;
reg    [0:  4] LSType_r2;
reg            LoadRaEn_reg;
reg            Load_cs_reg;
reg            Load_cs_r2;
reg            PU_cs_reg;
reg            PU_cs_r2;
reg            PU_cs_r3;
reg            VSFX_cs_reg;
reg            VSFX_cs_r2;
reg            VSFX_cs_r3;
reg            VCFX_cs_reg;
reg            VCFX_cs_r2;
reg            VCFX_cs_r3;
reg            VCFX_cs_r4;
reg            VCFX_cs_r5;
reg            VFPU_cs_reg;
reg            VFPU_cs_r2;
reg            VFPU_cs_r3;
reg            VFPU_cs_r4;
reg            VFPU_cs_r5;
reg            VFPU_cs_r6;
reg            Store_cs_reg;
reg            Store_cs_r2;
reg    [0:  7] PUType_reg;
reg    [0:  9] VALUType_reg;
reg            StoreRaEn_reg;
reg            StoreRaEn_r2;
reg            en_mtvscr_reg;
reg            en_mfvscr_reg;
reg            dpt_AReadRegEn_reg;
reg            dpt_BReadRegEn_reg;
reg            dpt_CReadRegEn_reg;
reg    [0:  4] dpt_AOperand_reg;
reg    [0:  4] dpt_BOperand_reg;
reg    [0:  4] dpt_COperand_reg;
reg    [0:  4] dpt_TargetReg_reg;
reg    [0:  4] dpt_TargetReg_r2;
reg    [0:  4] dpt_TargetReg_r3;
reg    [0:  4] dpt_TargetReg_r4;
reg    [0:  4] dpt_TargetReg_r5;
reg    [0:  4] dpt_TargetReg_r6;

//output signals
wire   [0:  4] Dcd_LSType;
reg    [0:  7] Dcd_PUType;
reg    [0:  9] Dcd_VALUType;
reg            Dcd_en_mtvscr;
reg            Dcd_en_mfvscr;
reg    [0:127] Dcd_AOperandMux;
reg    [0:127] Dcd_BOperandMux;
reg    [0:127] Dcd_COperandMux;
reg            Dcd_ValidAltivecOp;//wire

//=============================================================================
// predecoding, for instruction dispatch, generate Dcd_ValidAltivecOp signal
//=============================================================================
assign en_axc         = in_Instruction[0:5] == 6'd4 ? 1'b1 : 1'b0;
assign Load_ins       = (in_Instruction[21:30] == 10'd7   ||
                         in_Instruction[21:30] == 10'd39  ||
                         in_Instruction[21:30] == 10'd71  ||
                         in_Instruction[21:30] == 10'd103 ||
                         in_Instruction[21:30] == 10'd359 ||
                         in_Instruction[21:30] == 10'd6   ||
                         in_Instruction[21:30] == 10'd38)  && in_Instruction[0:5] == 6'd31 ? 1'b1 : 1'b0;
assign Store_ins      = (in_Instruction[21:30] == 10'd135 ||
                         in_Instruction[21:30] == 10'd167 ||
                         in_Instruction[21:30] == 10'd199 ||
                         in_Instruction[21:30] == 10'd231 ||
                         in_Instruction[21:30] == 10'd487) && in_Instruction[0:5] == 6'd31 ? 1'b1 : 1'b0;
assign PU_ins         = (in_Instruction[21:31] == 11'd782 ||
                         in_Instruction[21:31] == 11'd398 ||
                         in_Instruction[21:31] == 11'd270 ||
                         in_Instruction[21:31] == 11'd462 ||
                         in_Instruction[21:31] == 11'd334 ||
                         in_Instruction[21:31] == 11'd14  ||
                         in_Instruction[21:31] == 11'd142 ||
                         in_Instruction[21:31] == 11'd78  ||
                         in_Instruction[21:31] == 11'd206 ||
                         in_Instruction[21:31] == 11'd846 ||
                         in_Instruction[21:31] == 11'd526 ||
                         in_Instruction[21:31] == 11'd590 ||
                         in_Instruction[21:31] == 11'd974 ||
                         in_Instruction[21:31] == 11'd654 ||
                         in_Instruction[21:31] == 11'd718 ||
                         in_Instruction[21:31] == 11'd12  ||
                         in_Instruction[21:31] == 11'd76  ||
                         in_Instruction[21:31] == 11'd140 ||
                         in_Instruction[21:31] == 11'd268 ||
                         in_Instruction[21:31] == 11'd332 ||
                         in_Instruction[21:31] == 11'd396 ||
                         in_Instruction[21:31] == 11'd524 ||
                         in_Instruction[21:31] == 11'd780 ||
                         in_Instruction[21:31] == 11'd588 ||
                         in_Instruction[21:31] == 11'd844 ||
                         in_Instruction[21:31] == 11'd652 ||
                         in_Instruction[21:31] == 11'd908 ||
                         in_Instruction[26:31] ==  6'd43  ||
                         in_Instruction[26:31] ==  6'd42  ||
                         in_Instruction[21:31] == 11'd452 ||
                         in_Instruction[26:31] ==  6'd44  ||
                         in_Instruction[21:31] == 11'd1036||
                         in_Instruction[21:31] == 11'd708 ||
                         in_Instruction[21:31] == 11'd1100) && en_axc ? 1'b1 : 1'b0;
assign VSFX_ins       = (in_Instruction[21:31] == 11'd384 ||
                         in_Instruction[21:31] == 11'd768 ||
                         in_Instruction[21:31] == 11'd832 ||
                         in_Instruction[21:31] == 11'd896 ||
                         in_Instruction[21:31] == 11'd0   ||
                         in_Instruction[21:31] == 11'd64  ||
                         in_Instruction[21:31] == 11'd128 ||
                         in_Instruction[21:31] == 11'd512 ||
                         in_Instruction[21:31] == 11'd576 ||
                         in_Instruction[21:31] == 11'd640 ||
                         in_Instruction[21:31] == 11'd1408||
                         in_Instruction[21:31] == 11'd1792||
                         in_Instruction[21:31] == 11'd1856||
                         in_Instruction[21:31] == 11'd1920||
                         in_Instruction[21:31] == 11'd1024||
                         in_Instruction[21:31] == 11'd1088||
                         in_Instruction[21:31] == 11'd1152||
                         in_Instruction[21:31] == 11'd1536||
                         in_Instruction[21:31] == 11'd1600||
                         in_Instruction[21:31] == 11'd1664||
                         in_Instruction[21:31] == 11'd1282||
                         in_Instruction[21:31] == 11'd1346||
                         in_Instruction[21:31] == 11'd1410||
                         in_Instruction[21:31] == 11'd1026||
                         in_Instruction[21:31] == 11'd1090||
                         in_Instruction[21:31] == 11'd1154||
                         in_Instruction[21:31] == 11'd258 ||
                         in_Instruction[21:31] == 11'd322 ||
                         in_Instruction[21:31] == 11'd386 ||
                         in_Instruction[21:31] == 11'd2   ||
                         in_Instruction[21:31] == 11'd66  ||
                         in_Instruction[21:31] == 11'd130 ||
                         in_Instruction[21:31] == 11'd770 ||
                         in_Instruction[21:31] == 11'd834 ||
                         in_Instruction[21:31] == 11'd898 ||
                         in_Instruction[21:31] == 11'd514 ||
                         in_Instruction[21:31] == 11'd578 ||
                         in_Instruction[21:31] == 11'd642 ||
                         in_Instruction[21:31] == 11'd1034||
                         in_Instruction[21:31] == 11'd1098||
                         in_Instruction[22:31] == 10'd6   ||
                         in_Instruction[22:31] == 10'd70  ||
                         in_Instruction[22:31] == 10'd134 ||
                         in_Instruction[22:31] == 10'd198 ||
                         in_Instruction[22:31] == 10'd774 ||
                         in_Instruction[22:31] == 10'd838 ||
                         in_Instruction[22:31] == 10'd902 ||
                         in_Instruction[22:31] == 10'd966 ||
                         in_Instruction[22:31] == 10'd518 ||
                         in_Instruction[22:31] == 10'd582 ||
                         in_Instruction[22:31] == 10'd646 ||
                         in_Instruction[22:31] == 10'd710 ||
                         in_Instruction[22:31] == 10'd454 ||
                         in_Instruction[21:31] == 11'd1028||
                         in_Instruction[21:31] == 11'd1092||
                         in_Instruction[21:31] == 11'd1284||
                         in_Instruction[21:31] == 11'd1156||
                         in_Instruction[21:31] == 11'd1220||
                         in_Instruction[21:31] == 11'd4   ||
                         in_Instruction[21:31] == 11'd68  ||
                         in_Instruction[21:31] == 11'd132 ||
                         in_Instruction[21:31] == 11'd260 ||
                         in_Instruction[21:31] == 11'd324 ||
                         in_Instruction[21:31] == 11'd388 ||
                         in_Instruction[21:31] == 11'd516 ||
                         in_Instruction[21:31] == 11'd580 ||
                         in_Instruction[21:31] == 11'd644 ||
                         in_Instruction[21:31] == 11'd772 ||
                         in_Instruction[21:31] == 11'd836 ||
                         in_Instruction[21:31] == 11'd900) && en_axc ? 1'b1 : 1'b0;
assign VCFX_ins       = (in_Instruction[21:31] == 11'd776 ||
                         in_Instruction[21:31] == 11'd840 ||
                         in_Instruction[21:31] == 11'd520 ||
                         in_Instruction[21:31] == 11'd584 ||
                         in_Instruction[21:31] == 11'd264 ||
                         in_Instruction[21:31] == 11'd328 ||
                         in_Instruction[21:31] == 11'd8   ||
                         in_Instruction[21:31] == 11'd72  ||
                         in_Instruction[26:31] ==  6'd32  ||
                         in_Instruction[26:31] ==  6'd33  ||
                         in_Instruction[26:31] ==  6'd34  ||
                         in_Instruction[26:31] ==  6'd36  ||
                         in_Instruction[26:31] ==  6'd37  ||
                         in_Instruction[26:31] ==  6'd40  ||
                         in_Instruction[26:31] ==  6'd41  ||
                         in_Instruction[26:31] ==  6'd38  ||
                         in_Instruction[26:31] ==  6'd39  ||
                         in_Instruction[21:31] == 11'd1928||
                         in_Instruction[21:31] == 11'd1672||
                         in_Instruction[21:31] == 11'd1800||
                         in_Instruction[21:31] == 11'd1608||
                         in_Instruction[21:31] == 11'd1544) && en_axc ? 1'b1 : 1'b0;
assign VFPU_ins       = (in_Instruction[21:31] == 11'd10  ||
                         in_Instruction[21:31] == 11'd74  ||
                         in_Instruction[26:31] ==  6'd46  ||
                         in_Instruction[26:31] ==  6'd47  ||
                         in_Instruction[21:31] == 11'd970 ||
                         in_Instruction[21:31] == 11'd906 ||
                         in_Instruction[21:31] == 11'd842 ||
                         in_Instruction[21:31] == 11'd778 ||
                         in_Instruction[21:31] == 11'd714 ||
                         in_Instruction[21:31] == 11'd522 ||
                         in_Instruction[21:31] == 11'd650 ||
                         in_Instruction[21:31] == 11'd586 ||
                         in_Instruction[21:31] == 11'd394 ||
                         in_Instruction[21:31] == 11'd458 ||
                         in_Instruction[21:31] == 11'd266 ||
                         in_Instruction[21:31] == 11'd330) && en_axc ? 1'b1 : 1'b0;
assign mtvscr_ins     = in_Instruction[21:31] == 11'd1604 && en_axc ? 1'b1 : 1'b0;//move to vscr
assign mfvscr_ins     = in_Instruction[21:31] == 11'd1540 && en_axc ? 1'b1 : 1'b0;//move from vscr
assign AReadRegEnable = Store_ins || VSFX_ins || VCFX_ins ||
                        VFPU_ins && (in_Instruction[26] || {in_Instruction[21:22], in_Instruction[26]} == 3'b000) ||
                        PU_ins && (!in_Instruction[22] ||
                                   {in_Instruction[22:23], in_Instruction[25], in_Instruction[30]} == 4'b1101 ||
                                   {in_Instruction[22:23], in_Instruction[28]} == 3'b100) ? 1'b1 : 1'b0;
assign BReadRegEnable = PU_ins || VSFX_ins || VCFX_ins || VFPU_ins ? 1'b1 : 1'b0;
assign CReadRegEnable = in_Instruction[26] && (PU_ins && in_Instruction[30] || VCFX_ins) ? 1'b1 : 1'b0;
assign AOperand       = (Load_ins || Store_ins) ? in_Instruction[6:10] : in_Instruction[11:15];
assign BOperand       = in_Instruction[16:20];
assign COperand       = in_Instruction[21:25];
assign TargetRegister = in_Instruction[6:10];
assign CR6En          = VSFX_ins && in_Instruction[21]                           //is a valid VC instruction and Rc == 1'b1
                                 && in_Instruction[29:30] == 2'b11 ? 1'b1 : 1'b0;//cmp instructions

always @ ( * )
begin
  if( !APU_AltiVec_DcdHold )
  begin
    case({PU_ins, VSFX_ins, VCFX_ins, VFPU_ins, Load_ins, Store_ins})
      6'b100000: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b100000;
      6'b010000: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b010000;
      6'b001000: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b001000;
      6'b000100: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b000100;
      6'b000010: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b000010;
      6'b000001: {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b000001;
      default  : {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b000000;
    endcase
  end
  else
    {dpt_pu1, dpt_vsfx1, dpt_vcfx1, dpt_vfpu1, dpt_load1, dpt_store1} = 6'b000000;
end

always @ ( posedge clk )
if( !dpt_exebusy )//current ins does not has ins-dependency
begin
  dpt_pu2           <= dpt_pu1;
  dpt_vsfx2         <= dpt_vsfx1;
  dpt_vcfx2         <= dpt_vcfx1;
  dpt_vcfx3         <= dpt_vcfx2;
  dpt_vcfx4         <= dpt_vcfx3;
  dpt_vfpu2         <= dpt_vfpu1;
  dpt_vfpu3         <= dpt_vfpu2;
  dpt_vfpu4         <= dpt_vfpu3;
  dpt_vfpu5         <= dpt_vfpu4;
  dpt_load2         <= dpt_load1;
  dpt_load3         <= dpt_load2;
  dpt_load4         <= dpt_load3;
  dpt_store2        <= dpt_store1;
  TargetRegister_r1 <= TargetRegister;
  TargetRegister_r2 <= TargetRegister_r1;
  TargetRegister_r3 <= TargetRegister_r2;
  TargetRegister_r4 <= TargetRegister_r3;
end
else
begin
  dpt_pu2           <= 1'b0;
  dpt_vsfx2         <= 1'b0;
  dpt_vcfx2         <= 1'b0;
  dpt_vcfx3         <= 1'b0;
  dpt_vcfx4         <= 1'b0;
  dpt_vfpu2         <= 1'b0;
  dpt_vfpu3         <= 1'b0;
  dpt_vfpu4         <= 1'b0;
  dpt_vfpu5         <= 1'b0;
  dpt_load2         <= 1'b0;
  dpt_load3         <= 1'b0;
  dpt_load4         <= 1'b0;
  dpt_store2        <= 1'b0;
  TargetRegister_r1 <= 1'b0;
  TargetRegister_r2 <= 1'b0;
  TargetRegister_r3 <= 1'b0;
  TargetRegister_r4 <= 1'b0;
end

//=============================================================================
// instruction dispatch, iteration inferred here
//=============================================================================
//RAW
assign dpt_Aexebusy[0] = dpt_pu2    && AReadRegEnable && AOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[1] = dpt_vsfx2  && AReadRegEnable && AOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[2] = dpt_vcfx2  && AReadRegEnable && AOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[3] = dpt_vcfx3  && AReadRegEnable && AOperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[4] = dpt_vcfx4  && AReadRegEnable && AOperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[5] = dpt_vfpu2  && AReadRegEnable && AOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[6] = dpt_vfpu3  && AReadRegEnable && AOperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[7] = dpt_vfpu4  && AReadRegEnable && AOperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[8] = dpt_vfpu5  && AReadRegEnable && AOperand == TargetRegister_r4 ? 1'b1 : 1'b0;
assign dpt_Aexebusy[9] = dpt_load2  && AReadRegEnable && AOperand == TargetRegister_r1 ? 1'b1 : 1'b0;

assign dpt_Bexebusy[0] = dpt_pu2    && BReadRegEnable && BOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[1] = dpt_vsfx2  && BReadRegEnable && BOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[2] = dpt_vcfx2  && BReadRegEnable && BOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[3] = dpt_vcfx3  && BReadRegEnable && BOperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[4] = dpt_vcfx4  && BReadRegEnable && BOperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[5] = dpt_vfpu2  && BReadRegEnable && BOperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[6] = dpt_vfpu3  && BReadRegEnable && BOperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[7] = dpt_vfpu4  && BReadRegEnable && BOperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[8] = dpt_vfpu5  && BReadRegEnable && BOperand == TargetRegister_r4 ? 1'b1 : 1'b0;
assign dpt_Bexebusy[9] = dpt_load2  && BReadRegEnable && BOperand == TargetRegister_r1 ? 1'b1 : 1'b0;

assign dpt_Cexebusy[0] = dpt_pu2    && CReadRegEnable && COperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[1] = dpt_vsfx2  && CReadRegEnable && COperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[2] = dpt_vcfx2  && CReadRegEnable && COperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[3] = dpt_vcfx3  && CReadRegEnable && COperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[4] = dpt_vcfx4  && CReadRegEnable && COperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[5] = dpt_vfpu2  && CReadRegEnable && COperand == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[6] = dpt_vfpu3  && CReadRegEnable && COperand == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[7] = dpt_vfpu4  && CReadRegEnable && COperand == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[8] = dpt_vfpu5  && CReadRegEnable && COperand == TargetRegister_r4 ? 1'b1 : 1'b0;
assign dpt_Cexebusy[9] = dpt_load2  && CReadRegEnable && COperand == TargetRegister_r1 ? 1'b1 : 1'b0;
//WAW
assign dpt_Texebusy[0]  = Load_ins  && dpt_vcfx2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[1]  = Load_ins  && dpt_vcfx3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[2]  = Load_ins  && dpt_vfpu2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[3]  = Load_ins  && dpt_vfpu3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[4]  = Load_ins  && dpt_vfpu4 && TargetRegister == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Texebusy[5]  = PU_ins    && dpt_vcfx2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[6]  = PU_ins    && dpt_vcfx3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[7]  = PU_ins    && dpt_vfpu2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[8]  = PU_ins    && dpt_vfpu3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[9]  = PU_ins    && dpt_vfpu4 && TargetRegister == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Texebusy[10] = VSFX_ins  && dpt_vcfx2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[11] = VSFX_ins  && dpt_vcfx3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[12] = VSFX_ins  && dpt_vfpu2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
assign dpt_Texebusy[13] = VSFX_ins  && dpt_vfpu3 && TargetRegister == TargetRegister_r2 ? 1'b1 : 1'b0;
assign dpt_Texebusy[14] = VSFX_ins  && dpt_vfpu4 && TargetRegister == TargetRegister_r3 ? 1'b1 : 1'b0;
assign dpt_Texebusy[15] = VCFX_ins  && dpt_vfpu2 && TargetRegister == TargetRegister_r1 ? 1'b1 : 1'b0;
//LS
assign dpt_LSexebusy[0] = Store_ins && dpt_load2 ? 1'b1 : 1'b0;
assign dpt_LSexebusy[1] = Store_ins && dpt_load3 ? 1'b1 : 1'b0;
assign dpt_LSexebusy[2] = Store_ins && dpt_load4 ? 1'b1 : 1'b0;

always @ ( * )
begin
  if( dpt_exebusy_reg == 4'd0 )
  begin
    if( {dpt_Aexebusy[5], dpt_Bexebusy[5], dpt_Cexebusy[5]} )
      dpt_exebusy = 4'd8;
    else if( {dpt_Aexebusy[2], dpt_Aexebusy[6], dpt_Bexebusy[ 2], dpt_Bexebusy[ 6], dpt_Cexebusy[ 2], dpt_Cexebusy[6],
              dpt_Texebusy[2], dpt_Texebusy[7], dpt_Texebusy[12], dpt_Texebusy[15], dpt_LSexebusy[0]} )
      dpt_exebusy = 4'd4;
    else if( {dpt_Aexebusy[3], dpt_Aexebusy[7], dpt_Bexebusy[ 3], dpt_Bexebusy[ 7], dpt_Cexebusy[ 3], dpt_Cexebusy[ 7],
              dpt_Texebusy[0], dpt_Texebusy[3], dpt_Texebusy[ 5], dpt_Texebusy[ 8], dpt_Texebusy[10], dpt_Texebusy[13], dpt_LSexebusy[1]} )
      dpt_exebusy = 4'd2;
    else if( {dpt_Aexebusy[0:1], dpt_Aexebusy[4], dpt_Aexebusy[8:9], CR6En,
              dpt_Bexebusy[0:1], dpt_Bexebusy[4], dpt_Bexebusy[8:9],
              dpt_Cexebusy[0:1], dpt_Cexebusy[4], dpt_Cexebusy[8:9],
              dpt_Texebusy[1], dpt_Texebusy[4], dpt_Texebusy[9], dpt_Texebusy[9], dpt_Texebusy[11], dpt_Texebusy[14], dpt_LSexebusy[2]} )
      dpt_exebusy = 4'd1;
    else
      dpt_exebusy = 4'd0;
  end
  else
    dpt_exebusy = dpt_exebusy_reg >> 1;
end

always @ ( posedge clk )
begin
  dpt_exebusy_reg <= dpt_exebusy;
end

always @ ( * )
begin//current ins does not has ins-dependency
  if( !APU_AltiVec_DcdHold && !dpt_exebusy &&
     (Load_ins || Store_ins || PU_ins || VSFX_ins || VCFX_ins || VFPU_ins || mtvscr_ins || mfvscr_ins))
    dpt_Instruction = in_Instruction;
  else
  begin
    dpt_Instruction = 32'b0;
  end
end

//=============================================================================
// decoding
//=============================================================================
assign axc_cs            = dpt_Instruction[0:5] == 6'd4 ? 1'b1 : 1'b0;
assign Load_cs           = (dpt_Instruction[0:5] == 6'd31 && !dpt_Instruction[23]) ? 1'b1 : 1'b0;
assign Store_cs          = (dpt_Instruction[0:5] == 6'd31 &&  dpt_Instruction[23]) ? 1'b1 : 1'b0;
assign PU_cs             = {dpt_Instruction[21], dpt_Instruction[24:26], dpt_Instruction[28:30]} == 7'b011_0_010 && axc_cs ||
                          ({dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_101 ||
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_110 ||
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_110 ||                        //vx-form
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_111 ) && axc_cs ? 1'b1 : 1'b0;//vx-form
assign VSFX_cs           = {dpt_Instruction[21], dpt_Instruction[26], dpt_Instruction[28:30]} == 5'b1_0_101 && axc_cs ||//fp_cs in vsfx vx-form
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_000 && axc_cs ||              //vx-form
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_001 && axc_cs ||              //vx-form
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_011 && axc_cs ||              //vx-form
                          ({dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_010 && axc_cs &&
                         !((dpt_Instruction[21] & dpt_Instruction[22]) |//not a VSCR ins
                          (!dpt_Instruction[21] & dpt_Instruction[24] & dpt_Instruction[25]))) ? 1'b1 : 1'b0;//vx-form, not a PU ins
assign VCFX_cs           = {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_000 && axc_cs ||              //
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_001 && axc_cs ||              //
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_010 && axc_cs ||              //
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_011 && axc_cs ||              //
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_100 && axc_cs ||              //
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b0_100 && axc_cs ? 1'b1 : 1'b0;  //vx-form
assign VFPU_cs           = {dpt_Instruction[21], dpt_Instruction[26], dpt_Instruction[28:30]} == 5'b0_0_101 && axc_cs ||//fp_cs in vfpu vx-form
                           {dpt_Instruction[26], dpt_Instruction[28:30]} == 4'b1_111 && axc_cs ? 1'b1 : 1'b0;
assign en_mtvscr         = {dpt_Instruction[21:22], dpt_Instruction[25:26], dpt_Instruction[28:30]} == 7'b11_1_0_010 && axc_cs ? 1'b1 : 1'b0;//move to vscr
assign en_mfvscr         = {dpt_Instruction[21:22], dpt_Instruction[25:26], dpt_Instruction[28:30]} == 7'b11_0_0_010 && axc_cs ? 1'b1 : 1'b0;//move from vscr
assign LSType            = Load_cs | Store_cs ? {dpt_Instruction[22:25], dpt_Instruction[30]} : 5'd0;
assign Load_RaEn         = Load_cs  && dpt_Instruction[11:15] != 5'h0 ? 1'b1 : 1'b0;//x-form ins
assign Store_RaEn        = Store_cs && dpt_Instruction[11:15] != 5'h0 ? 1'b1 : 1'b0;//x-form ins
assign PUType            = {dpt_Instruction[21:26], dpt_Instruction[30:31]};
assign VALUType          = {dpt_Instruction[21:26], dpt_Instruction[28:31]};
assign dpt_AReadRegEn    = Store_cs ||
                           VSFX_cs || VCFX_cs ||
                           VFPU_cs && (dpt_Instruction[26] || {dpt_Instruction[21:22], dpt_Instruction[26]} == 3'b000) ||
                           PU_cs && (!dpt_Instruction[22] ||
                                    {dpt_Instruction[22:23], dpt_Instruction[25], dpt_Instruction[30]} == 4'b1101 ||
                                    {dpt_Instruction[22:23], dpt_Instruction[28]} == 3'b100) ? 1'b1 : 1'b0;
assign dpt_BReadRegEn    = PU_cs || VSFX_cs || VCFX_cs || VFPU_cs ? 1'b1 : 1'b0;
assign dpt_CReadRegEn    = dpt_Instruction[26] && ((PU_cs && dpt_Instruction[30]) || VCFX_cs || VFPU_cs) ? 1'b1 : 1'b0;
assign dpt_AOperand      = (Load_cs || Store_cs) ? dpt_Instruction[6:10] : dpt_Instruction[11:15];
assign dpt_BOperand      = dpt_Instruction[16:20];
assign dpt_COperand      = dpt_Instruction[21:25];
assign dpt_TargetReg     = dpt_Instruction[6:10];

assign AForwardEnable[0] = Load_cs_r2  && dpt_AReadRegEn_reg && dpt_AOperand_reg == dpt_TargetReg_r2  ? 1'b1 : 1'b0;
assign AForwardEnable[1] = PU_cs_r3    && dpt_AReadRegEn_reg && dpt_AOperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign AForwardEnable[2] = VSFX_cs_r3  && dpt_AReadRegEn_reg && dpt_AOperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign AForwardEnable[3] = VCFX_cs_r5  && dpt_AReadRegEn_reg && dpt_AOperand_reg == dpt_TargetReg_r5  ? 1'b1 : 1'b0;
assign AForwardEnable[4] = VFPU_cs_r6  && dpt_AReadRegEn_reg && dpt_AOperand_reg == dpt_TargetReg_r6  ? 1'b1 : 1'b0;

assign BForwardEnable[0] = Load_cs_r2  && dpt_BReadRegEn_reg && dpt_BOperand_reg == dpt_TargetReg_r2  ? 1'b1 : 1'b0;
assign BForwardEnable[1] = PU_cs_r3    && dpt_BReadRegEn_reg && dpt_BOperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign BForwardEnable[2] = VSFX_cs_r3  && dpt_BReadRegEn_reg && dpt_BOperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign BForwardEnable[3] = VCFX_cs_r5  && dpt_BReadRegEn_reg && dpt_BOperand_reg == dpt_TargetReg_r5  ? 1'b1 : 1'b0;
assign BForwardEnable[4] = VFPU_cs_r6  && dpt_BReadRegEn_reg && dpt_BOperand_reg == dpt_TargetReg_r6  ? 1'b1 : 1'b0;

assign CForwardEnable[0] = Load_cs_r2  && dpt_CReadRegEn_reg && dpt_COperand_reg == dpt_TargetReg_r2  ? 1'b1 : 1'b0;
assign CForwardEnable[1] = PU_cs_r3    && dpt_CReadRegEn_reg && dpt_COperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign CForwardEnable[2] = VSFX_cs_r3  && dpt_CReadRegEn_reg && dpt_COperand_reg == dpt_TargetReg_r3  ? 1'b1 : 1'b0;
assign CForwardEnable[3] = VCFX_cs_r5  && dpt_CReadRegEn_reg && dpt_COperand_reg == dpt_TargetReg_r5  ? 1'b1 : 1'b0;
assign CForwardEnable[4] = VFPU_cs_r6  && dpt_CReadRegEn_reg && dpt_COperand_reg == dpt_TargetReg_r6  ? 1'b1 : 1'b0;

//=============================================================================
// write internal registers
//=============================================================================
always @ ( posedge clk )
begin
  Load_cs_reg        <= Load_cs;          //access to output
  Load_cs_r2         <= Load_cs_reg;
  PU_cs_reg          <= PU_cs;
  PU_cs_r2           <= PU_cs_reg;        //access to output
  PU_cs_r3           <= PU_cs_r2;
  VSFX_cs_reg        <= VSFX_cs;
  VSFX_cs_r2         <= VSFX_cs_reg;      //access to output
  VSFX_cs_r3         <= VSFX_cs_r2;
  VCFX_cs_reg        <= VCFX_cs;
  VCFX_cs_r2         <= VCFX_cs_reg;      //access to output
  VCFX_cs_r3         <= VCFX_cs_r2;
  VCFX_cs_r4         <= VCFX_cs_r3;
  VCFX_cs_r5         <= VCFX_cs_r4;
  VFPU_cs_reg        <= VFPU_cs;
  VFPU_cs_r2         <= VFPU_cs_reg;      //access to output
  VFPU_cs_r3         <= VFPU_cs_r2;
  VFPU_cs_r4         <= VFPU_cs_r3;
  VFPU_cs_r5         <= VFPU_cs_r4;
  VFPU_cs_r6         <= VFPU_cs_r5;
  Store_cs_reg       <= Store_cs;
  Store_cs_r2        <= Store_cs_reg;     //access to output
  LoadRaEn_reg       <= Load_RaEn;        //access to output, for Load ins
  LSType_reg         <= LSType;           //access to output, for Load ins
  LSType_r2          <= LSType_reg;       //access to output, for Store ins
  PUType_reg         <= PUType;           //registered to output
  VALUType_reg       <= VALUType;         //registered to output
  StoreRaEn_reg      <= Store_RaEn;
  StoreRaEn_r2       <= StoreRaEn_reg;    //access to output, for Store ins
  en_mtvscr_reg      <= en_mtvscr;        //registered to output
  en_mfvscr_reg      <= en_mfvscr;        //registered to output
  dpt_AReadRegEn_reg <= dpt_AReadRegEn;   //access to output
  dpt_BReadRegEn_reg <= dpt_BReadRegEn;   //access to output
  dpt_CReadRegEn_reg <= dpt_CReadRegEn;   //access to output
  dpt_AOperand_reg   <= dpt_AOperand;     //access to output
  dpt_BOperand_reg   <= dpt_BOperand;     //access to output
  dpt_COperand_reg   <= dpt_COperand;     //access to output
  dpt_TargetReg_reg  <= dpt_TargetReg;    //access to output, for LS ins
  dpt_TargetReg_r2   <= dpt_TargetReg_reg;//access to output, for other ins
  dpt_TargetReg_r3   <= dpt_TargetReg_r2;
  dpt_TargetReg_r4   <= dpt_TargetReg_r3;
  dpt_TargetReg_r5   <= dpt_TargetReg_r4;
  dpt_TargetReg_r6   <= dpt_TargetReg_r5;
end

//=============================================================================
// output generation
//=============================================================================
assign Dcd_LS_cs   = Load_cs_reg | Store_cs_r2;
assign Dcd_LSType  = Load_cs_reg ? LSType_reg :
                     Store_cs_r2 ? LSType_r2  : 5'd0;
assign Dcd_LSRaEn  = Load_cs_reg ? LoadRaEn_reg :
                     Store_cs_r2 ? StoreRaEn_r2 : 1'b0;
assign Dcd_PU_cs   = PU_cs_r2;
assign Dcd_VALU_cs = VSFX_cs_r2 ? 2'b01 :
                     VCFX_cs_r2 ? 2'b10 :
                     VFPU_cs_r2 ? 2'b11 : 2'b00;

always @ ( posedge clk )
begin
  Dcd_PUType         <= PUType_reg;
  Dcd_VALUType       <= VALUType_reg;
  Dcd_en_mtvscr      <= en_mtvscr_reg;
  Dcd_en_mfvscr      <= en_mfvscr_reg;
end

assign Dcd_RFReadRegAEn = dpt_AReadRegEn_reg;
assign Dcd_RFReadRegBEn = dpt_BReadRegEn_reg;
assign Dcd_RFReadRegCEn = dpt_CReadRegEn_reg;
assign Dcd_RF_VRA       = dpt_AOperand_reg;
assign Dcd_RF_VRB       = dpt_BOperand_reg;
assign Dcd_RF_VRC       = dpt_COperand_reg;
assign Dcd_XTargetRegister = Dcd_LS_cs ? dpt_TargetReg_reg : dpt_TargetReg_r2;

always @ ( posedge clk )
begin
  if( AForwardEnable )
  begin
    case( AForwardEnable )
      5'b10000: Dcd_AOperandMux <= in_LSResult;
      5'b01000: Dcd_AOperandMux <= in_PUResult;
      5'b00100: Dcd_AOperandMux <= in_VSFXResult;
      5'b00010: Dcd_AOperandMux <= in_VCFXResult;
      5'b00001: Dcd_AOperandMux <= in_VFPUResult;
    endcase
  end
  else if( dpt_AReadRegEn_reg )
    Dcd_AOperandMux <= in_RFAReadData;
  else
    Dcd_AOperandMux <= dpt_AOperand_reg;
end

always @ ( posedge clk )
begin
  if( BForwardEnable )
  begin
  case( BForwardEnable )
    5'b10000: Dcd_BOperandMux <= in_LSResult;
    5'b01000: Dcd_BOperandMux <= in_PUResult;
    5'b00100: Dcd_BOperandMux <= in_VSFXResult;
    5'b00010: Dcd_BOperandMux <= in_VCFXResult;
    5'b00001: Dcd_BOperandMux <= in_VFPUResult;
  endcase
  end
  else if( dpt_BReadRegEn_reg )
    Dcd_BOperandMux <= in_RFBReadData;
  else
    Dcd_BOperandMux <= 32'd0;
end

always @ ( posedge clk )
begin
  if( CForwardEnable )
  begin
  case( CForwardEnable )
    5'b10000: Dcd_COperandMux <= in_LSResult;
    5'b01000: Dcd_COperandMux <= in_PUResult;
    5'b00100: Dcd_COperandMux <= in_VSFXResult;
    5'b00010: Dcd_COperandMux <= in_VCFXResult;
    5'b00001: Dcd_COperandMux <= in_VFPUResult;
  endcase
  end
  else if( dpt_CReadRegEn_reg )
    Dcd_COperandMux <= in_RFCReadData;
  else
    Dcd_COperandMux <= dpt_COperand_reg;
end

always @ ( * )
casez({Load_ins | Store_ins | PU_ins | VSFX_ins | VCFX_ins | VFPU_ins | mtvscr_ins | mfvscr_ins})
  1'b1   : Dcd_ValidAltivecOp = 1'b1;
  default: Dcd_ValidAltivecOp = 1'b0;
endcase

assign Dcd_APUCR6En    = VSFX_cs && dpt_Instruction[21] && dpt_Instruction[29:30] == 2'b11 && !dpt_exebusy ? 1'b1 : 1'b0;
assign Dcd_ReadGPRA_En = (Load_cs | Store_cs) && !dpt_exebusy;
assign Dcd_ReadGPRB_En = (Load_cs | Store_cs) && !dpt_exebusy;
assign Dcd_ExeBusy     = dpt_exebusy != 4'd0 ? 1'b1 : 1'b0;

endmodule
