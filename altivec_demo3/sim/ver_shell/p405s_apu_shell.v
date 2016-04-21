//===============================================================================
//  File Name       : p405s_apu_shell.v
//  File Revision   : 4.0
//  Date            : 2014/9/10
//  Author          : clp
//  Email           : clp510@tju.edu.cn
//  History         : Rev1.0 cuiluping 2014/03/11
//                    Rev2.0 cuiluping 2014/03/26
//                    Rev3.0 cuiluping 2014/04/02
//                    Rev4.0 wangjie   2014/09/10
//  ----------------------------------------------------------------------------
//  Description     : APU controller between p405s and Altivec
//                    Rev2.0 add new signal:APU_AltiVec_DcdHold_r.
//                    Rev3.0 remove APU_AltiVec_DcdHold_r.
//  Function        :
//  ----------------------------------------------------------------------------
// Copyright (c) 2014,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================

module p405s_apu_shell(
                 clk,
                 rst_b,
                 C405_apuDcdInstruction,
                 C405_apuDcdFull,
                 C405_apuDcdHold,
                 C405_apuExeHold,
                 C405_apuExeFlush,
                 C405_apuExeWdCnt,
                 C405_apuExeRaData,
                 C405_apuExeRbData,
                 C405_apuXerCA,
                 C405_apuWbHold,
                 C405_apuWbFlush,
                 C405_apuWbEndian,
                 C405_apuWbByteEn,
                 C405_apuExeLoadDBus,
                 C405_apuExeLoadDValid,
                 C405_apuMsrFE0,
                 C405_apuMsrFE1,
                 AltiVec_APU_ValidOp,
                 AltiVec_APU_ExeBusy,
                 AltiVec_APU_RaEn,
                 AltiVec_APU_RbEn,
                 AltiVec_APU_CR6En,
                 AltiVec_APU_CRData,

                 APU_c405DcdValidOp,
                 APU_c405DcdApuOp,
                 APU_c405DcdFpuOp,
                 APU_c405DcdPrivOp,
                 APU_c405DcdGprWrite,
                 APU_c405DcdRaEn,
                 APU_c405DcdRbEn,
                 APU_c405DcdXerOVEn,
                 APU_c405DcdXerCAEn,
                 APU_c405DcdCREn,
                 APU_c405ExeCRField,
                 APU_c405DcdForceAlgn,
                 APU_c405DcdLoad,
                 APU_c405DcdStore,
                 APU_c405DcdUpdate,
                 APU_c405DcdLdStByte,
                 APU_c405DcdLdStHw,
                 APU_c405DcdLdStWd,
                 APU_c405DcdLdStDw,
                 APU_c405DcdLdStQw,
                 APU_c405DcdTrapBE,
                 APU_c405DcdTrapLE,
                 APU_c405DcdForceBESteering,
                 APU_c405ExeLdDepend,
                 APU_c405WbLdDepend,
                 APU_c405LwbLdDepend,
                 APU_c405ExeBlockingMCO,
                 APU_c405ExeNonBlockingMCO,
                 APU_c405ExeBusy,
                 APU_c405ExeResult,
                 APU_c405ExeXerCA,
                 APU_c405ExeXerOV,
                 APU_c405ExeCR,
                 APU_c405Exception,
                 APU_c405FpuException,
                 APU_c405SleepReq,
                 // APU_AltiVec_cs,
                 APU_AltiVec_Ins,
                 APU_AltiVec_RaData,
                 APU_AltiVec_RbData,
                 APU_AltiVec_DcdHold
                 );

//----------------------------------------------------
//I/O declaration
//----------------------------------------------------
input            clk;
input            rst_b;
//----------------------------------------------------
//Interface with C405
//----------------------------------------------------
input    [0:31]  C405_apuDcdInstruction;    //Current instruction in decode
input            C405_apuDcdFull;           //Signals from Core ppc405
input            C405_apuDcdHold;           //When asserted instruction in DCD should not be execute stage 
input            C405_apuExeHold;           //When asserted an APU instruction in execute must hold in execute stage
input            C405_apuExeFlush;          //When asserted execute stage must be flushed
input    [0: 1]  C405_apuExeWdCnt;          /*The count is decremented as each word transfer is passed through the pipeline. The instruction is held in EXE until the word count goes to zero
                                            ? 00 = Word or less
                                            ? 01 = double word
                                            ? 10 = triple word
                                            ? 11 = quad word, load/store. */    
input    [0:31]  C405_apuExeRaData;         //Data read from GPR file using RA field of instruction
input    [0:31]  C405_apuExeRbData;         //Data read from GPR file using RB field of instruction
input            C405_apuXerCA;             //This is the xerCA bit used for extended arithmetic
input            C405_apuWbHold;            //When asserted an APU instruction in write back must hold in write back stage
input            C405_apuWbFlush;           //When asserted write back stage must be flushed
input            C405_apuWbEndian;          //When asserted a load/store instruction in write back has true little Endian storage attribute
input    [0: 3]  C405_apuWbByteEn;          //Specifies the valid bytes for load instruction in write back stage
input    [0:31]  C405_apuExeLoadDBus;       //Data loaded from storage for the instruction in load write back
input            C405_apuExeLoadDValid;     //When asserted, the load data is valid on C405_apuExeLoadDBus(0:31)
input            C405_apuMsrFE0;            //This is the msrFE0 bit used for FPU exception
input            C405_apuMsrFE1;            //This is the msrFE1 bit used for FPU exception
input            AltiVec_APU_ValidOp;
input            AltiVec_APU_ExeBusy;
input            AltiVec_APU_RaEn;
input            AltiVec_APU_RbEn;
input            AltiVec_APU_CR6En;
input    [0: 3]  AltiVec_APU_CRData;

output           APU_c405DcdValidOp;        //When asserted, a valid APU instruction is in decode.
output           APU_c405DcdApuOp;          //When asserted, an APU instruction is in decode.
output           APU_c405DcdFpuOp;          //When asserted, an FPU instruction is in decode.
output           APU_c405DcdPrivOp;         //When asserted, the APU instruction in decode is privileged.
output           APU_c405DcdGprWrite;       //Indicates an APU result is to be placed in the GPR file.
output           APU_c405DcdRaEn;           //When asserted, an APU instruction is in decode read GPR file using RA field of instruction.
output           APU_c405DcdRbEn;           //When asserted, an APU instruction is in decode read GPR file using RB field of instruction.
output           APU_c405DcdXerOVEn;        //Indicates overflow is to be recorded from an APU.
output           APU_c405DcdXerCAEn;        //Indicates carry is to be recorded from an APU.
output           APU_c405DcdCREn;           //Indicates condition code is to be recorded from an APU.
output   [0: 2]  APU_c405ExeCRField;        //Specifies the CR field to be set by the APU instruction in decode stage.
output           APU_c405DcdForceAlgn;      //When asserted, forces an alignment for load/store
output           APU_c405DcdLoad;           //When asserted, the APU instruction in decode is a Load
output           APU_c405DcdStore;          //When asserted, the APU instruction in decode is a Store
output           APU_c405DcdUpdate;         //When asserted, the APU instruction in decode has an update form
output           APU_c405DcdLdStByte;       //When asserted, the APU instruction in decode is Load/Store byte
output           APU_c405DcdLdStHw;         //When asserted, the APU instruction in decode is Load/Store halfword
output           APU_c405DcdLdStWd;         //When asserted, the APU instruction in decode is Load/Store Word
output           APU_c405DcdLdStDw;         //When asserted, the APU instruction in decode is Load/Store doubleword
output           APU_c405DcdLdStQw;         //When asserted, the APU instruction in decode is Load/Store quadword
output           APU_c405DcdTrapBE;         //When asserted, the APU/FPU load/store instruction in decode will take alignment exception if the storage Endian attribute is 0
output           APU_c405DcdTrapLE;         //When asserted, the APU/FPU load/store instruction in decode will take alignment exception if the storage Endian attribute is 1
output           APU_c405DcdForceBESteering;//When asserted, the APU/FPU load/store instruction in decode will force Big Endian steering
output           APU_c405ExeLdDepend;       //When asserted the APU instruction in decode has a dependency on APU load instruction in execute stage
output           APU_c405WbLdDepend;        //When asserted the APU instruction in decode has a dependency on APU load instruction in write back stage
output           APU_c405LwbLdDepend;       //When asserted the APU instruction in decode has a dependency on APU load instruction in load write back stage
output           APU_c405ExeBlockingMCO;    //When asserted, holds CPU pipe and is noninterruptible after 1st cycle
output           APU_c405ExeNonBlockingMCO; //When asserted, holds CPU pipe and is interruptible at any time
output           APU_c405ExeBusy;           //When asserted, APU is busy with an AMCO and cannot receive additional instructions
output   [0:31]  APU_c405ExeResult;         //Result or store data from APU
output           APU_c405ExeXerCA;          //Carry bit from APU/FPU to XER
output           APU_c405ExeXerOV;          //Overflow bit from APU
output   [0: 3]  APU_c405ExeCR;             //APU condition code as a result of APU instruction in execute
output           APU_c405Exception;         //When asserted, and if enabled, generates program exception (vctr 0x0700)
output           APU_c405FpuException;      //When asserted, and if enabled, generates program exception (vctr 0x0700)
output           APU_c405SleepReq;          //0 = no sleep req, 1 = sleep req. Must bea 1 for CPU to sleep
//----------------------------------------------------
//Interface with AltiVecUnit
//----------------------------------------------------
// output           APU_AltiVec_cs;
output   [0:31]  APU_AltiVec_Ins;
output   [0:31]  APU_AltiVec_RaData;
output   [0:31]  APU_AltiVec_RbData;
output           APU_AltiVec_DcdHold;

//----------------------------------------------------
//Internal signals defination
//----------------------------------------------------
wire             rst_b_w;
reg              rst_b_r0;
reg              rst_b_r1;
reg              rst_b_r2;
reg              rst_b_r3;
reg              rst_b_r4;
reg              rst_b_r5;
reg              rst_b_r6;
reg              AltiVec_APU_CR6En_r;//register AltiVec_APU_CR6En signal

// reg      [0:31]  C405_apuDcdInstruction_reg;
// reg              C405_apuDcdHold_reg;
// reg      [0:31]  C405_apuExeRaData_reg;
// reg      [0:31]  C405_apuExeRbData_reg;

// always @ ( posedge clk )
// begin
  // C405_apuDcdInstruction_reg <= C405_apuDcdInstruction;
  // C405_apuDcdHold_reg        <= C405_apuDcdHold;
  // C405_apuExeRaData_reg      <= C405_apuExeRaData;
  // C405_apuExeRbData_reg      <= C405_apuExeRbData;
// end

always @ ( posedge clk or negedge rst_b )
begin
  if ( !rst_b )
  begin
    AltiVec_APU_CR6En_r <= 1'b0;
  end
  else if ( C405_apuDcdHold )
  begin
    AltiVec_APU_CR6En_r <= 1'b0;
  end
  else
  begin
    AltiVec_APU_CR6En_r <= AltiVec_APU_CR6En;
  end
end

always @ (posedge clk )
begin
  rst_b_r0 <= rst_b;
  rst_b_r1 <= rst_b_r0;
  rst_b_r2 <= rst_b_r1;
  rst_b_r3 <= rst_b_r2;
  rst_b_r4 <= rst_b_r3;
  rst_b_r5 <= rst_b_r4;
  rst_b_r6 <= rst_b_r5;
end

assign rst_b_w = rst_b & rst_b_r0 & rst_b_r1 & rst_b_r2 & rst_b_r3 & rst_b_r4 & rst_b_r5 & rst_b_r6;
//----------------------------------------------------
// Tied Default value to APU_c405* signals
// are not used for the time being
//----------------------------------------------------
assign APU_c405DcdValidOp         = ( rst_b_w ) & AltiVec_APU_ValidOp;
assign APU_c405DcdApuOp           = ( rst_b_w ) & AltiVec_APU_ValidOp;
assign APU_c405DcdFpuOp           = 1'b0;
assign APU_c405DcdPrivOp          = 1'b0;
assign APU_c405DcdGprWrite        = 1'b0;
assign APU_c405DcdRaEn            = ( rst_b_w ) & AltiVec_APU_RaEn;
assign APU_c405DcdRbEn            = ( rst_b_w ) & AltiVec_APU_RbEn;
assign APU_c405DcdXerOVEn         = 1'b0;
assign APU_c405DcdXerCAEn         = 1'b0;
assign APU_c405DcdCREn            = ( rst_b_w ) & AltiVec_APU_CR6En;
assign APU_c405ExeCRField [0:2]   = 3'd6;//always write CR6 register
assign APU_c405DcdForceAlgn       = 1'b0;
assign APU_c405DcdLoad            = 1'b0;
assign APU_c405DcdStore           = 1'b0;
assign APU_c405DcdUpdate          = 1'b0;
assign APU_c405DcdLdStByte        = 1'b0;
assign APU_c405DcdLdStHw          = 1'b0;
assign APU_c405DcdLdStWd          = 1'b0;
assign APU_c405DcdLdStDw          = 1'b0;
assign APU_c405DcdLdStQw          = 1'b0;
assign APU_c405DcdTrapBE          = 1'b0;
assign APU_c405DcdTrapLE          = 1'b0;
assign APU_c405DcdForceBESteering = 1'b0;
assign APU_c405ExeLdDepend        = 1'b0;
assign APU_c405WbLdDepend         = 1'b0;
assign APU_c405LwbLdDepend        = 1'b0;
assign APU_c405ExeBlockingMCO     = 1'b0;
assign APU_c405ExeNonBlockingMCO  = 1'b0;
assign APU_c405ExeBusy            = ( rst_b_w ) & AltiVec_APU_ExeBusy;
assign APU_c405ExeResult [0:31]   = 32'b0;
assign APU_c405ExeXerCA           = 1'b0;
assign APU_c405ExeXerOV           = 1'b0;
assign APU_c405ExeCR [0:3]        = AltiVec_APU_CRData;
assign APU_c405Exception          = 1'b0;
assign APU_c405FpuException       = 1'b0;
assign APU_c405SleepReq           = 1'b0;
//output to AltiVec
// assign APU_AltiVec_cs             = 1'b1;
assign APU_AltiVec_Ins            = C405_apuDcdInstruction;
assign APU_AltiVec_RaData         = C405_apuExeRaData;
assign APU_AltiVec_RbData         = C405_apuExeRbData;
assign APU_AltiVec_DcdHold        = C405_apuDcdHold;

endmodule
