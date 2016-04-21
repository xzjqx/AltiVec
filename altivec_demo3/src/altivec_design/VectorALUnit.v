//===============================================================================
//  File Name       : VectorALUnit.v
//  File Revision   : 1.0
//  Date            : 2015/4/24
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : Vector Arithmetic Logic Unit (for students)
//  Function        : VSFX only
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================

module VectorALUnit(
                 clk,
                 rst_n,
                 in_VALU_cs,
                 in_VALUType,
                 in_VALUAOperand,
                 in_VALUBOperand,
                 in_VALUCOperand,
                 in_VALUTargetRegister,

                 VSFX_RFTargetRegEn,
                 VSFX_RFTargetRegister,
                 VSFX_RFResult,
                 VCFX_RFTargetRegEn,
                 VCFX_RFTargetRegister,
                 VCFX_RFResult,
                 VFPU_RFTargetRegEn,
                 VFPU_RFTargetRegister,
                 VFPU_RFResult,
                 VALU_VSCREn,
                 VALU_VSCRData,
                 VALU_CRData
                 );

//===============================================================================
// input and output declaration
//===============================================================================
input            clk;
input            rst_n;
//enable Vector ALUnit
input    [0:  1] in_VALU_cs;
//Vector ALUnit operate code type
input    [0:  9] in_VALUType;
//Vector ALUnit 1st operand
input    [0:127] in_VALUAOperand;
//Vector ALUnit 2nd operand
input    [0:127] in_VALUBOperand;
//Vector ALUnit 3rd operand
input    [0:127] in_VALUCOperand;
//Write Back to which regsiter
input    [0:  4] in_VALUTargetRegister;

//VSFX output result valid
output           VSFX_RFTargetRegEn;
//VSFX target register address
output   [0:  4] VSFX_RFTargetRegister;
//VSFX output result
output   [0:127] VSFX_RFResult;
//VCFX output result valid
output           VCFX_RFTargetRegEn;
//VCFX target register address
output   [0:  4] VCFX_RFTargetRegister;
//VCFX output result
output   [0:127] VCFX_RFResult;
//VFPU output result valid
output           VFPU_RFTargetRegEn;
//VFPU target register address
output   [0:  4] VFPU_RFTargetRegister;
//VFPU output result
output   [0:127] VFPU_RFResult;
//some condition need update VSCR
output           VALU_VSCREn;
output           VALU_VSCRData;
//some condition need update CR external
output   [0:  3] VALU_CRData;

//===============================================================================
// internal signal
//===============================================================================
wire     [0:  7] ins_vsfx;                     
wire     [0:  9] ins_vcfx;                     
wire     [0:  5] ins_vfpu;
//wire type from  VSFX output
wire             out_VSFXSat;//to VSCR register,overflow mask bit.1--overflow,0--no overflow
//wire type from  VCFX output
wire             out_VCFXSat;//to VSCR register,overflow mask bit.1--overflow,0--no overflow
//wire type from  VFPU output
wire             out_VFPUSat;//to VSCR register,overflow mask bit.1--overflow,0--no overflow
//cs for VSFX, VCFX, VFPU
reg              VSFX_cs;
reg              VCFX_cs;
reg              VFPU_cs;
//intermediate registers to store vrt address
reg      [0:  4] VSFXTargetRegisterPipe;
reg      [0:  4] VCFXTargetRegisterPipe1;
reg      [0:  4] VCFXTargetRegisterPipe2;
reg      [0:  4] VCFXTargetRegisterPipe3;
reg      [0:  4] VFPUTargetRegisterPipe1;
reg      [0:  4] VFPUTargetRegisterPipe2;
reg      [0:  4] VFPUTargetRegisterPipe3;
reg      [0:  4] VFPUTargetRegisterPipe4;

assign ins_vsfx              = in_VALU_cs == 2'b01 ? {in_VALUType[0:4], in_VALUType[6:8]}               :  8'd0;
assign ins_vcfx              = in_VALU_cs == 2'b10 ?  in_VALUType                                       : 10'd0;
assign ins_vfpu              = in_VALU_cs == 2'b11 ? {in_VALUType[1:4], in_VALUType[7], in_VALUType[9]} :  6'd0;
//===============================================================================
// wire to output
//===============================================================================
assign out_VFPUSat           = 1'b0;
//VSFX result writeback
assign VSFX_RFTargetRegister = VSFXTargetRegisterPipe;
//VCFX result writeback
assign VCFX_RFTargetRegister = VCFXTargetRegisterPipe3;
//VFPU result writeback
assign VFPU_RFTargetRegister = VFPUTargetRegisterPipe4;
//VSCR or CR add here
assign VALU_VSCREn           = VSFX_RFTargetRegEn | VCFX_RFTargetRegEn | VFPU_RFTargetRegEn;
assign VALU_VSCRData         = out_VSFXSat | out_VCFXSat | out_VFPUSat;

//===============================================================================
// Target Register addresses are registed until the instruction result generated
//===============================================================================
always @ (posedge clk or negedge rst_n)
if(!rst_n)
begin
  VSFXTargetRegisterPipe  <= 5'b0;
  VCFXTargetRegisterPipe1 <= 5'b0;
  VCFXTargetRegisterPipe2 <= 5'b0;
  VCFXTargetRegisterPipe3 <= 5'b0;
  VFPUTargetRegisterPipe1 <= 5'b0;
  VFPUTargetRegisterPipe2 <= 5'b0;
  VFPUTargetRegisterPipe3 <= 5'b0;
  VFPUTargetRegisterPipe4 <= 5'b0;
end
else if(VSFX_cs)
begin
  VSFXTargetRegisterPipe  <= in_VALUTargetRegister;
  VCFXTargetRegisterPipe1 <= 5'b0;
  VCFXTargetRegisterPipe2 <= VCFXTargetRegisterPipe1;
  VCFXTargetRegisterPipe3 <= VCFXTargetRegisterPipe2;
  VFPUTargetRegisterPipe1 <= 5'b0;
  VFPUTargetRegisterPipe2 <= VFPUTargetRegisterPipe1;
  VFPUTargetRegisterPipe3 <= VFPUTargetRegisterPipe2;
  VFPUTargetRegisterPipe4 <= VFPUTargetRegisterPipe3;
end
else if(VCFX_cs)
begin
  VSFXTargetRegisterPipe  <= 5'b0;
  VCFXTargetRegisterPipe1 <= in_VALUTargetRegister;
  VCFXTargetRegisterPipe2 <= VCFXTargetRegisterPipe1;
  VCFXTargetRegisterPipe3 <= VCFXTargetRegisterPipe2;
  VFPUTargetRegisterPipe1 <= 5'b0;
  VFPUTargetRegisterPipe2 <= VFPUTargetRegisterPipe1;
  VFPUTargetRegisterPipe3 <= VFPUTargetRegisterPipe2;
  VFPUTargetRegisterPipe4 <= VFPUTargetRegisterPipe3;
end
else if(VFPU_cs)
begin
  VSFXTargetRegisterPipe  <= 5'b0;
  VCFXTargetRegisterPipe1 <= 5'b0;
  VCFXTargetRegisterPipe2 <= VCFXTargetRegisterPipe1;
  VCFXTargetRegisterPipe3 <= VCFXTargetRegisterPipe2;
  VFPUTargetRegisterPipe1 <= in_VALUTargetRegister;
  VFPUTargetRegisterPipe2 <= VFPUTargetRegisterPipe1;
  VFPUTargetRegisterPipe3 <= VFPUTargetRegisterPipe2;
  VFPUTargetRegisterPipe4 <= VFPUTargetRegisterPipe3;
end
else
begin
  VSFXTargetRegisterPipe  <= 5'b0;
  VCFXTargetRegisterPipe1 <= 5'b0;
  VCFXTargetRegisterPipe2 <= VCFXTargetRegisterPipe1;
  VCFXTargetRegisterPipe3 <= VCFXTargetRegisterPipe2;
  VFPUTargetRegisterPipe1 <= 5'b0;
  VFPUTargetRegisterPipe2 <= VFPUTargetRegisterPipe1;
  VFPUTargetRegisterPipe3 <= VFPUTargetRegisterPipe2;
  VFPUTargetRegisterPipe4 <= VFPUTargetRegisterPipe3;
end

//===============================================================================
//Generate cs for VSFX, VCFX, VFPU
//===============================================================================
always @ (in_VALU_cs)
if(in_VALU_cs == 2'b01)//VSFX
begin
  VSFX_cs = 1'b1;
  VCFX_cs = 1'b0;
  VFPU_cs = 1'b0;
end
else if(in_VALU_cs == 2'b10)//VCFX
begin
  VSFX_cs = 1'b0;
  VCFX_cs = 1'b1;
  VFPU_cs = 1'b0;
end
else if(in_VALU_cs == 2'b11)//VFPU
begin
  VSFX_cs = 1'b0;
  VCFX_cs = 1'b0;
  VFPU_cs = 1'b1;
end
else
begin
  VSFX_cs = 1'b0;
  VCFX_cs = 1'b0;
  VFPU_cs = 1'b0;
end

//===============================================================================
//VSFX instruction excute
//===============================================================================
vsfx_top vs_top (
                 .clk        (clk                     ),
                 .en         (VSFX_cs                 ),
                 .vra        (in_VALUAOperand         ),
                 .vrb        (in_VALUBOperand         ),
                 .ins        (ins_vsfx                ),
                             
                 .vrt_en     (VSFX_RFTargetRegEn      ),
                 .vrt        (VSFX_RFResult           ),
                 .sat        (out_VSFXSat             ),
                 .cr6        (VALU_CRData             )
                 );

//===============================================================================
//VCFX instruction excute
//===============================================================================
// vcfx_top vcfx_top (
                 // .clk        (clk                     ),
                 // .en         (VCFX_cs                 ),
                 // .ins        (ins_vcfx                ),
                 // .vra        (in_VALUAOperand         ),
                 // .vrb        (in_VALUBOperand         ),
                 // .vrc        (in_VALUCOperand         ),
                 // .vrt        (VCFX_RFResult           ),
                 // .vrt_en     (VCFX_RFTargetRegEn      ),
                 // .sat        (out_VCFXSat             )//to Special Register
                 // );

//===============================================================================
//VFPU instruction excute
//===============================================================================
// vfpu_top vfpu_top (
                 // .clk        (clk                     ),
                 // .vfpu_ins   (ins_vfpu                ),
                 // .op_valid   (VFPU_cs                 ),
                 // .vra_data   (in_VALUAOperand         ),
                 // .vrb_data   (in_VALUBOperand         ),
                 // .vrc_data   (in_VALUCOperand         ),
                 // .uim        (in_VALUAOperand[123:127]),
                 // .vrt_data   (VFPU_RFResult           ),
                 // .vrt_data_rd(VFPU_RFTargetRegEn      )
                 // );

endmodule
