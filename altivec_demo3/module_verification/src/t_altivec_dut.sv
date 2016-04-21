//===============================================================================
//  File Name       : t_altivec_dut.sv
//  File Revision   : 2.0
//  Date            : 2015/4/3
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform
//  Function        : design under test
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module altivec_dut(
  input bit[127:0] vra,
  input bit[127:0] vrb,
  input bit[  7:0] ins,
  input bit vra_en, vrb_en, ins_en,
  input bit clk, rst,
  input bit rc,

  output bit dut_busy,
  output bit vrt_en,
  output bit[127:0] vrt
  );
  
  bit [7:0] ins_vsfx;
  
  assign both_ready = (vra_en & vrb_en & ins_en);
  
  always @ ( * )
  case (ins)//generate ins_vsfx according to ins number
     1:ins_vsfx <= 8'b00110000;//Vector Add and Write Carry-Out Unsigned Word VX-form
     2:ins_vsfx <= 8'b01100000;//Vector Add Signed Byte Saturate VX-form
     3:ins_vsfx <= 8'b01101000;//Vector Add Signed Halfword Saturate VX-form
     4:ins_vsfx <= 8'b01110000;//Vector Add Signed Word Saturate VX-form
     5:ins_vsfx <= 8'b00000000;//Vector Add Unsigned Byte Modulo VX-form
     6:ins_vsfx <= 8'b00001000;//Vector Add Unsigned Halfword Modulo VX-form
     7:ins_vsfx <= 8'b00010000;//Vector Add Unsigned Word Modulo VX-form
     8:ins_vsfx <= 8'b01000000;//Vector Add Unsigned Byte Saturate VX-form
     9:ins_vsfx <= 8'b01001000;//Vector Add Unsigned Halfword Saturate VX-form
    10:ins_vsfx <= 8'b01010000;//Vector Add Unsigned Word Saturate VX-form
    11:ins_vsfx <= 8'b10110000;//Vector Subtract and Write Carry-Out Unsigned Word VX-form
    12:ins_vsfx <= 8'b11100000;//Vector Subtract Signed Byte Saturate VX-form
    13:ins_vsfx <= 8'b11101000;//Vector Subtract Signed Halfword Saturate VX-form
    14:ins_vsfx <= 8'b11110000;//Vector Subtract Signed Word Saturate VX-form
    15:ins_vsfx <= 8'b10000000;//Vector Subtract Unsigned Byte Modulo VX-form
    16:ins_vsfx <= 8'b10001000;//Vector Subtract Unsigned Halfword Modulo VX-form
    17:ins_vsfx <= 8'b10010000;//Vector Subtract Unsigned Word Modulo VX-form
    18:ins_vsfx <= 8'b11000000;//Vector Subtract Unsigned Byte Saturate VX-form
    19:ins_vsfx <= 8'b11001000;//Vector Subtract Unsigned Halfword Saturate VX-form
    20:ins_vsfx <= 8'b11010000;//Vector Subtract Unsigned Word Saturate VX-form
    21:ins_vsfx <= 8'b10100001;//Vector Average Signed Byte VX-form
    22:ins_vsfx <= 8'b10101001;//Vector Average Signed Halfword VX-form
    23:ins_vsfx <= 8'b10110001;//Vector Average Signed Word VX-form
    24:ins_vsfx <= 8'b10000001;//Vector Average Unsigned Byte VX-form
    25:ins_vsfx <= 8'b10001001;//Vector Average Unsigned Halfword VX-form
    26:ins_vsfx <= 8'b10010001;//Vector Average Unsigned Word VX-form
    27:ins_vsfx <= 8'b00100001;//Vector Maximum Signed Byte VX-form
    28:ins_vsfx <= 8'b00101001;//Vector Maximum Signed Halfword VX-form
    29:ins_vsfx <= 8'b00110001;//Vector Maximum Signed Word VX-form
    30:ins_vsfx <= 8'b00000001;//Vector Maximum Unsigned Byte VX-form
    31:ins_vsfx <= 8'b00001001;//Vector Maximum Unsigned Halfword VX-form
    32:ins_vsfx <= 8'b00010001;//Vector Maximum Unsigned Word VX-form
    33:ins_vsfx <= 8'b01100001;//Vector Minimum Signed Byte VX-form
    34:ins_vsfx <= 8'b01101001;//Vector Minimum Signed Halfword VX-form
    35:ins_vsfx <= 8'b01110001;//Vector Minimum Signed Word VX-form
    36:ins_vsfx <= 8'b01000001;//Vector Minimum Unsigned Byte VX-form
    37:ins_vsfx <= 8'b01001001;//Vector Minimum Unsigned Halfword VX-form
    38:ins_vsfx <= 8'b01010001;//Vector Minimum Unsigned Word VX-form
    39:ins_vsfx <= 8'b10000101;//Vector Maximum Single-Precision VX-form
    40:ins_vsfx <= 8'b10001101;//Vector Minimum Single-Precision VX-form
    41:ins_vsfx <= 8'b00000011;//Vector Compare Equal To Unsigned Byte VC-form
    42:ins_vsfx <= 8'b00001011;//Vector Compare Equal To Unsigned Halfword VC-form
    43:ins_vsfx <= 8'b00010011;//Vector Compare Equal To Unsigned Word VC-form
    44:ins_vsfx <= 8'b00011011;//Vector Compare Equal To Single-Precision VC-form
    45:ins_vsfx <= 8'b01100011;//Vector Compare Greater Than Signed Byte VC-form
    46:ins_vsfx <= 8'b01101011;//Vector Compare Greater Than Signed Halfword VC-form
    47:ins_vsfx <= 8'b01110011;//Vector Compare Greater Than Signed Word VC-form
    48:ins_vsfx <= 8'b01111011;//Vector Compare Bounds Single-Precision VC-form
    49:ins_vsfx <= 8'b01000011;//Vector Compare Greater Than Unsigned Byte VC-form
    50:ins_vsfx <= 8'b01001011;//Vector Compare Greater Than Unsigned Halfword VC-form
    51:ins_vsfx <= 8'b01010011;//Vector Compare Greater Than Unsigned Word VC-form
    52:ins_vsfx <= 8'b11011011;//Vector Compare Greater Than Single-Precision VC-form
    53:ins_vsfx <= 8'b00111011;//Vector Compare Greater Than or Equal To Single-Precision VC-form
    54:ins_vsfx <= 8'b10000010;//Vector Logical AND VX-form
    55:ins_vsfx <= 8'b10001010;//Vector Logical AND with Complement VX-form
    56:ins_vsfx <= 8'b10100010;//Vector Logical NOR VX-form
    57:ins_vsfx <= 8'b10010010;//Vector Logical OR VX-form
    58:ins_vsfx <= 8'b10011010;//Vector Logical XOR VX-form
    59:ins_vsfx <= 8'b00000010;//Vector Rotate Left Byte VX-form
    60:ins_vsfx <= 8'b00001010;//Vector Rotate Left Halfword VX-form
    61:ins_vsfx <= 8'b00010010;//Vector Rotate Left Word VX-form
    62:ins_vsfx <= 8'b00100010;//Vector Shift Left Byte VX-form
    63:ins_vsfx <= 8'b00101010;//Vector Shift Left Halfword VX-form
    64:ins_vsfx <= 8'b00110010;//Vector Shift Left Word VX-form
    65:ins_vsfx <= 8'b01000010;//Vector Shift Right Byte VX-form
    66:ins_vsfx <= 8'b01001010;//Vector Shift Right Halfword VX-form
    67:ins_vsfx <= 8'b01010010;//Vector Shift Right Word VX-form
    68:ins_vsfx <= 8'b01100010;//Vector Shift Right Algebraic Byte VX-form
    69:ins_vsfx <= 8'b01101010;//Vector Shift Right Algebraic Halfword VX-form
    70:ins_vsfx <= 8'b01110010;//Vector Shift Right Algebraic Word VX-form
  endcase
  
  always @ (posedge both_ready)
  begin
    #1;//consume time
    dut_busy <= 1;
	  @ (posedge clk);//hardware result will be generated after 1 cycle
    dut_busy <= 0;
  end

  vsfx_top vstop(
                .clk,
                .en(1'b1),
                .vra,
                .vrb,
                .ins(ins_vsfx),
                  
                .vrt_en(vrt_en),	
                .vrt(vrt),
                .sat(),
                .cr6()
                );
				 
endmodule
