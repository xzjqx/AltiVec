//===============================================================================
//  File Name       : AltiVecUnit.v
//  File Revision   : 1.0
//  Date            : 2015/3/30
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : AltivecUnit top level (for students)
//  Function        :
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================

module AltiVecUnit(
                 clk,
                 rst_n,
                 in_Instruction,
                 in_ReadDataAfromGPR,
                 in_ReadDataBfromGPR,
                 APU_AltiVec_DcdHold,
                 Mem_LSData,

                 Dcd_APUCR6En,
                 Dcd_APUValidOp,
                 Dcd_APUExeBusy,
                 Dcd_APURaEn,
                 Dcd_APURbEn,
                 VALU_CRData,
                 LS_Mem_cs,
                 LS_Mem_RW,
                 LS_MemAddr,
                 LS_MemData,
                 LS_Mem_WriteEn //memory write enable signal per 8 bits
                 );

//=============================================================================
//input and output declaration
//=============================================================================
input            clk;
input            rst_n;
input    [0: 31] in_Instruction;
input    [0: 31] in_ReadDataAfromGPR;//read data from C405 core GPR
input    [0: 31] in_ReadDataBfromGPR;
input            APU_AltiVec_DcdHold;
input    [0:127] Mem_LSData;

output           Dcd_APUCR6En;
output           Dcd_APUValidOp;     //to APU controller,active high to indicate the instruction being decoded is a valid AltiVec Ins
output           Dcd_APUExeBusy;     //to APU Controller,if high,can't receive instructions ,if low,can receive instructions
output           Dcd_APURaEn;        //enable signal to read operand A from GPR of c405
output           Dcd_APURbEn;
output   [0:  3] VALU_CRData;
output           LS_Mem_cs;
output           LS_Mem_RW;
output   [0: 31] LS_MemAddr;
output   [0:127] LS_MemData;
output   [0: 15] LS_Mem_WriteEn;

//=============================================================================
//internal signal
//=============================================================================
wire     [0:  4] Dcd_XTargetRegister;//from Decoder to PU,VALU,Load/Store unit
//from Decoder to PU
wire             Dcd_PU_cs;
wire     [0:  7] Dcd_PUType;
//from Decoder to VALU
wire     [0:  1] Dcd_VALU_cs;
wire     [0:  9] Dcd_VALUType;
wire             DCD_mtvscr;
wire             DCD_mfvscr;
//from Decoder to LS
wire             Dcd_LS_cs;
wire     [0:  4] Dcd_LSType;         //totally 12 LS instructions
wire             Dcd_LSRaEn;
//From RegFileAccess to RF
wire             Dcd_RFAReadRegEn;
wire     [0:  4] Dcd_RFAReadRegAdd;
wire             Dcd_RFBReadRegEn;
wire     [0:  4] Dcd_RFBReadRegAdd;
wire             Dcd_RFCReadRegEn;
wire     [0:  4] Dcd_RFCReadRegAdd;
//From RF to RegFileAccess
wire     [0:127] RF_DcdAReadData;
wire     [0:127] RF_DcdBReadData;
wire     [0:127] RF_DcdCReadData;
// //from PU to RF
// wire             PU_RFTargetRegEn;
// wire     [0:  4] PU_RFTargetRegister;
// wire     [0:127] PU_RFResult;
//from VALU to RF
wire             VSFX_RFTargetRegEn;
wire     [0:  4] VSFX_RFTargetRegister;
wire     [0:127] VSFX_RFResult;
// wire             VCFX_RFTargetRegEn;
// wire     [0:  4] VCFX_RFTargetRegister;
// wire     [0:127] VCFX_RFResult;
// wire             VFPU_RFTargetRegEn;
// wire     [0:  4] VFPU_RFTargetRegister;
// wire     [0:127] VFPU_RFResult;
wire             VSCR_RFTargetRegEn;
wire     [0:  4] VSCR_RFTargetRegister;
//from Load/Store to RF,added by clp
wire     [0: 15] LS_RFTargetRegEn;
wire     [0:  4] LS_RFTargetRegister;
wire     [0:127] LS_RFResult;
// //from PU to VSCR
// wire             PU_VSCREn;
// wire             PU_VSCRData;
//from VALU to VSCR
wire             VALU_VSCREn;
wire             VALU_VSCRData;

//from RA to PU or VSFX or VCFX or VFPU or Load/Store unit
//Read Register data from C405 GPR
wire     [0:127] Dcd_AOperandMux;
wire     [0:127] Dcd_BOperandMux;
wire     [0:127] Dcd_COperandMux;
wire     [0: 31] VSCR_RFResult;

//=============================================================================
//inst InstructionDecoder,1st pipeline
//=============================================================================
InstructionDecoder InstructionDecoder(
                 .clk                         (clk                  ),
                 .rst_n                       (rst_n                ),
                 // .in_AltiVec_cs               (in_AltiVec_cs        ),
                 .in_Instruction              (in_Instruction       ),
                 .APU_AltiVec_DcdHold         (APU_AltiVec_DcdHold  ),
                 .in_PUResult                 (PU_RFResult          ),
                 .in_VSFXResult               (VSFX_RFResult        ),
                 .in_VCFXResult               (VCFX_RFResult        ),
                 .in_VFPUResult               (VFPU_RFResult        ),
                 .in_LSResult                 (LS_RFResult          ),
                 .in_RFAReadData              (RF_DcdAReadData      ),
                 .in_RFBReadData              (RF_DcdBReadData      ),
                 .in_RFCReadData              (RF_DcdCReadData      ),

                 .Dcd_LS_cs                   (Dcd_LS_cs            ),
                 .Dcd_LSType                  (Dcd_LSType           ),
                 .Dcd_LSRaEn                  (Dcd_LSRaEn           ),
                 .Dcd_PU_cs                   (Dcd_PU_cs            ),
                 .Dcd_PUType                  (Dcd_PUType           ),
                 .Dcd_VALU_cs                 (Dcd_VALU_cs          ),
                 .Dcd_VALUType                (Dcd_VALUType         ),
                 .Dcd_en_mtvscr               (DCD_mtvscr           ),
                 .Dcd_en_mfvscr               (DCD_mfvscr           ),
                 .Dcd_RFReadRegAEn            (Dcd_RFAReadRegEn     ),
                 .Dcd_RFReadRegBEn            (Dcd_RFBReadRegEn     ),
                 .Dcd_RFReadRegCEn            (Dcd_RFCReadRegEn     ),
                 .Dcd_RF_VRA                  (Dcd_RFAReadRegAdd    ),
                 .Dcd_RF_VRB                  (Dcd_RFBReadRegAdd    ),
                 .Dcd_RF_VRC                  (Dcd_RFCReadRegAdd    ),
                 .Dcd_XTargetRegister         (Dcd_XTargetRegister  ),
                 .Dcd_AOperandMux             (Dcd_AOperandMux      ),
                 .Dcd_BOperandMux             (Dcd_BOperandMux      ),
                 .Dcd_COperandMux             (Dcd_COperandMux      ),
                 .Dcd_APUCR6En                (Dcd_APUCR6En         ),
                 .Dcd_ValidAltivecOp          (Dcd_APUValidOp       ),
                 .Dcd_ReadGPRA_En             (Dcd_APURaEn          ),
                 .Dcd_ReadGPRB_En             (Dcd_APURbEn          ),
                 .Dcd_ExeBusy                 (Dcd_APUExeBusy       )
                 );

//=============================================================================
//inst RegisterFile
//=============================================================================
RegisterFile RegisterFile(
                 .clk                         (clk                  ),
                 .rst_n                       (rst_n                ),
                 .in_AReadRegisterEnable      (Dcd_RFAReadRegEn     ),
                 .in_AReadRegister            (Dcd_RFAReadRegAdd    ),
                 .in_BReadRegisterEnable      (Dcd_RFBReadRegEn     ),
                 .in_BReadRegister            (Dcd_RFBReadRegAdd    ),
                 .in_CReadRegisterEnable      (Dcd_RFCReadRegEn     ),
                 .in_CReadRegister            (Dcd_RFCReadRegAdd    ),
                 //added by clp------------------------------------------------
                 .in_ZeroWriteRegisterEnable  (LS_RFTargetRegEn     ),
                 .in_ZeroWriteRegister        (LS_RFTargetRegister  ),
                 .in_ZeroWriteData            (LS_RFResult          ),
                 //------------------------------------------------------------
                 // .in_FirstWriteRegisterEnable (PU_RFTargetRegEn     ),
                 .in_FirstWriteRegisterEnable (1'b0                 ),
                 // .in_FirstWriteRegister       (PU_RFTargetRegister  ),
                 .in_FirstWriteRegister       (5'b0                 ),
                 // .in_FirstWriteData           (PU_RFResult          ),
                 .in_FirstWriteData           (128'b0               ),
                 .in_SecondWriteRegisterEnable(VSFX_RFTargetRegEn   ),
                 .in_SecondWriteRegister      (VSFX_RFTargetRegister),
                 .in_SecondWriteData          (VSFX_RFResult        ),
                 // .in_ThirdWriteRegisterEnable (VCFX_RFTargetRegEn   ),
                 .in_ThirdWriteRegisterEnable (1'b0                 ),
                 // .in_ThirdWriteRegister       (VCFX_RFTargetRegister),
                 .in_ThirdWriteRegister       (5'b0                 ),
                 // .in_ThirdWriteData           (VCFX_RFResult        ),
                 .in_ThirdWriteData           (128'b0               ),
                 // .in_FourthWriteRegisterEnable(VFPU_RFTargetRegEn   ),
                 .in_FourthWriteRegisterEnable(1'b0                 ),
                 // .in_FourthWriteRegister      (VFPU_RFTargetRegister),
                 .in_FourthWriteRegister      (5'b0                 ),
                 // .in_FourthWriteData          (VFPU_RFResult        ),
                 .in_FourthWriteData          (128'b0               ),
                 .in_FifthWriteRegisterEnable (VSCR_RFTargetRegEn   ),
                 .in_FifthWriteRegister       (VSCR_RFTargetRegister),
                 .in_FifthWriteData           (VSCR_RFResult        ),

                 .out_AReadData               (RF_DcdAReadData      ),
                 .out_BReadData               (RF_DcdBReadData      ),
                 .out_CReadData               (RF_DcdCReadData      )
                 );

//=============================================================================
//inst LoadStore unit
//=============================================================================
LoadStore LoadStore(
                 .clk                         (clk                  ),
                 .rst_n                       (rst_n                ),
                 .Dcd_LS_cs                   (Dcd_LS_cs            ),
                 .Dcd_LSType                  (Dcd_LSType           ),
                 .Dcd_RaEn                    (Dcd_LSRaEn           ),
                 .Dcd_LSOperand               (Dcd_AOperandMux      ),
                 .Dcd_LSTargetRegister        (Dcd_XTargetRegister  ),
                 .C405_LSRaData               (in_ReadDataAfromGPR  ),
                 .C405_LSRbData               (in_ReadDataBfromGPR  ),
                 .Mem_LSData                  (Mem_LSData           ),
                 
                 .LS_Mem_cs                   (LS_Mem_cs            ),
                 .LS_MemAddr                  (LS_MemAddr           ),
                 .LS_MemData                  (LS_MemData           ),
                 .LS_Mem_RW                   (LS_Mem_RW            ),
                 .LS_Mem_WriteEn              (LS_Mem_WriteEn       ),
                 .LS_RFTargetRegEn            (LS_RFTargetRegEn     ),
                 .LS_RFTargetRegister         (LS_RFTargetRegister  ),
                 .LS_RFResult                 (LS_RFResult          )
                 );

//=============================================================================
//inst PermuteUnit
//=============================================================================
// PermuteUnit PermuteUnit(
                 // .Clk                         (clk                  ),
                 // .Dcd_PU_cs                   (Dcd_PU_cs            ),
                 // .Dec_PU_Opcode               (Dcd_PUType           ),
                 // .Dcd_PU_AOperand             (Dcd_AOperandMux      ),
                 // .Dcd_PU_BOperand             (Dcd_BOperandMux      ),
                 // .Dcd_PU_COperand             (Dcd_COperandMux      ),
                 // .Dec_PU_Address              (Dcd_XTargetRegister  ),

                 // .PU_RF_en                    (PU_RFTargetRegEn     ),
                 // .PU_RF_Address               (PU_RFTargetRegister  ),
                 // .PU_RF_Result                (PU_RFResult          ),

                 // .PU_VSCR_en                  (PU_VSCREn            ),
                 // .PU_VSCR_SAT                 (PU_VSCRData          )
                 // );

//=============================================================================
//inst Vector ALUnit
//=============================================================================
VectorALUnit VectorALUnit(
                 .clk                         (clk                  ),
                 .rst_n                       (rst_n                ),
                 .in_VALU_cs                  (Dcd_VALU_cs          ),
                 .in_VALUType                 (Dcd_VALUType         ),
                 .in_VALUAOperand             (Dcd_AOperandMux      ),
                 .in_VALUBOperand             (Dcd_BOperandMux      ),
                 .in_VALUCOperand             (Dcd_COperandMux      ),
                 .in_VALUTargetRegister       (Dcd_XTargetRegister  ),

                 .VSFX_RFTargetRegEn          (VSFX_RFTargetRegEn   ),
                 .VSFX_RFTargetRegister       (VSFX_RFTargetRegister),
                 .VSFX_RFResult               (VSFX_RFResult        ),
                 .VCFX_RFTargetRegEn          (VCFX_RFTargetRegEn   ),
                 .VCFX_RFTargetRegister       (VCFX_RFTargetRegister),
                 .VCFX_RFResult               (VCFX_RFResult        ),
                 .VFPU_RFTargetRegEn          (VFPU_RFTargetRegEn   ),
                 .VFPU_RFTargetRegister       (VFPU_RFTargetRegister),
                 .VFPU_RFResult               (VFPU_RFResult        ),

                 .VALU_VSCREn                 (VALU_VSCREn          ),
                 .VALU_VSCRData               (VALU_VSCRData        ),
                 .VALU_CRData                 (VALU_CRData          )
                 );

//=============================================================================
//inst VSCR
//=============================================================================
VSCR VSCR(
                 .clk                         (clk                  ),
                 .rst_n                       (rst_n                ),
                 .in_VSCRReadEnable           (DCD_mfvscr           ),
                 .in_VSCRTargetRegister       (Dcd_XTargetRegister  ),
                 .in_VSCR                     (Dcd_BOperandMux[96:127]),
                 .in_VSCRWriteEnable          (DCD_mtvscr           ),
                 // .PU_VSCR_en                  (PU_VSCREn            ),
                 .PU_VSCR_en                  (1'b0                 ),
                 // .PU_VSCR_SAT                 (PU_VSCRData          ),
                 .PU_VSCR_SAT                 (1'b0                 ),
                 .VALU_VSCREn                 (VALU_VSCREn          ),
                 .VALU_VSCRData               (VALU_VSCRData        ),

                 .VSCR_RFTargetRegEn          (VSCR_RFTargetRegEn   ),
                 .VSCR_RFTargetRegister       (VSCR_RFTargetRegister),
                 .out_VSCR                    (VSCR_RFResult        )
                 );

endmodule
