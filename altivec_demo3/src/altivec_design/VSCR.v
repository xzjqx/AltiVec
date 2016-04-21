//===============================================================================
//  File Name       : AltiVecUnit.v
//  File Revision   : 1.0
//  Date            : 2015/3/30
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : Vector Status and Control Register (for students)
//  Function        : Read or Write VSCR
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================

module VSCR(
                 clk,
                 rst_n,
                 in_VSCRReadEnable,
                 in_VSCRTargetRegister,
                 in_VSCR,
                 in_VSCRWriteEnable,
                 PU_VSCR_en,
                 PU_VSCR_SAT,
                 VALU_VSCREn,
                 VALU_VSCRData,
                 
                 VSCR_RFTargetRegEn,
                 VSCR_RFTargetRegister,
                 out_VSCR
                 );

//===============================================================================
//input and output declaration
//===============================================================================
input            clk;
input            rst_n;
//enable read VSCR_reg
input            in_VSCRReadEnable;
input    [0:  4] in_VSCRTargetRegister;
input    [0: 31] in_VSCR;
//enable write VSCR_reg
input            in_VSCRWriteEnable;
input            PU_VSCR_en;
input            PU_VSCR_SAT;
input            VALU_VSCREn;
input            VALU_VSCRData;

//read output
output           VSCR_RFTargetRegEn;
output   [0:  4] VSCR_RFTargetRegister;
output   [0: 31] out_VSCR;

//reg style declaration of output signal
reg              VSCR_RFTargetRegEn;
reg      [0:  4] VSCR_RFTargetRegister;
reg      [0: 31] out_VSCR;
//===============================================================================
//internal signal
//===============================================================================
reg      [0: 31] VSCR_reg;

//===============================================================================
//reg input once, because Permute Unit need one pipeline
//===============================================================================
always @ (posedge clk or negedge rst_n)
if(!rst_n)
  VSCR_reg              <= 32'b0;
else if(PU_VSCR_en)
  VSCR_reg              <= {31'b0,PU_VSCR_SAT};
else if(VALU_VSCREn)
  VSCR_reg              <= {31'b0,VALU_VSCRData};
else if(in_VSCRReadEnable)
  VSCR_reg              <= VSCR_reg;
else if(in_VSCRWriteEnable)
  VSCR_reg              <= in_VSCR;
else
  VSCR_reg              <= VSCR_reg;

always @ (posedge clk or negedge rst_n)
if(!rst_n)
  out_VSCR              <= 32'b0;
else if(in_VSCRReadEnable)
  out_VSCR              <= VSCR_reg;
else
  out_VSCR              <= out_VSCR;

always @ (posedge clk or negedge rst_n)
if(!rst_n)
begin
  VSCR_RFTargetRegEn    <= 1'b0;
  VSCR_RFTargetRegister <= 5'b0;
end
else if(in_VSCRReadEnable)
begin
  VSCR_RFTargetRegEn    <= 1'b1;
  VSCR_RFTargetRegister <= in_VSCRTargetRegister;
end
else
begin
  VSCR_RFTargetRegEn    <= 1'b0;
  VSCR_RFTargetRegister <= 5'b0;
end

endmodule
