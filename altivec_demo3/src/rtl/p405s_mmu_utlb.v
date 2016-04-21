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


//`timescale 1 ns / 10 ps
// Local directives

`define DSIZ_B 22:28
`define DSIZ_0_B 22
`define DSIZ_1_B 23
`define DSIZ_2_B 24
`define DSIZ_3_B 25
`define DSIZ_4_B 26
`define DSIZ_5_B 27
`define DSIZ_6_B 28
`define COMP_0 0:7
`define COMP_1 0:9
`define COMP_2 0:11
`define COMP_3 0:13
`define COMP_4 0:15
`define COMP_5 0:17
`define COMP_6 0:19
`define COMP_7 0:21
`define DT_B 29
`define TID_B 30:37
`define PT_B 38:41
`define E_B 42
`define K_B 43
`define V_B 44


module p405s_mmu_utlb (DATA_COMP,DO_00,DO_01,DO_02,DO_03,DO_04,DO_05,DO_06,
  DO_07,DO_08,DO_09,DO_10,DO_11,DO_12,DO_13,DO_14,DO_15,DO_16,DO_17,DO_18,
  DO_19,DO_20,DO_21,DO_E,DO_G,DO_I,DO_K,DO_M,DO_PD_0,DO_PD_1,DO_PT_0,DO_PT_1,
  DO_PT_2,DO_PT_3,DO_V,DO_W,DSIZ_OUT_0,DSIZ_OUT_1,DSIZ_OUT_2,DSIZ_OUT_3,
  DSIZ_OUT_4,
  DSIZ_OUT_5,DSIZ_OUT_6,DT_OUT,EPN_OUT_00,EPN_OUT_01,EPN_OUT_02,EPN_OUT_03,
  EPN_OUT_04,EPN_OUT_05,EPN_OUT_06,EPN_OUT_07,EPN_OUT_08,EPN_OUT_09,EPN_OUT_10,
  EPN_OUT_11,EPN_OUT_12,EPN_OUT_13,EPN_OUT_14,EPN_OUT_15,EPN_OUT_16,EPN_OUT_17,
  EPN_OUT_18,EPN_OUT_19,EPN_OUT_20,EPN_OUT_21,EX_OUT,INDEX_OUT_0,INDEX_OUT_1,
  INDEX_OUT_2,INDEX_OUT_3,INDEX_OUT_4,INDEX_OUT_5,MISS,TAG_COMP,
  TID_OUT_0,
  TID_OUT_1,TID_OUT_2,TID_OUT_3,TID_OUT_4,TID_OUT_5,TID_OUT_6,TID_OUT_7,WR_OUT,
  ZSEL_OUT_0,ZSEL_OUT_1,ZSEL_OUT_2,ZSEL_OUT_3,DATA_EN,DI_00,
  DI_01,DI_02,DI_03,DI_04,DI_05,DI_06,DI_07,DI_08,DI_09,DI_10,DI_11,DI_12,
  DI_13,DI_14,DI_15,DI_16,DI_17,DI_18,DI_19,DI_20,DI_21,DI_CI_00,DI_CI_01,
  DI_CI_02,DI_CI_03,DI_CI_04,DI_CI_05,DI_CI_06,DI_CI_07,DI_CI_08,DI_CI_09,
  DI_CI_10,DI_CI_11,DI_CI_12,DI_CI_13,DI_CI_14,DI_CI_15,DI_CI_16,DI_CI_17,
  DI_CI_18,DI_CI_19,DI_CI_20_TEST_EVEN,DI_CI_21_TEST_ODD,DI_E,DI_G,DI_I,DI_K,
  DI_M,DI_PD_0,DI_PD_1,DI_PT_0,DI_PT_1,DI_PT_2,DI_PT_3,DI_V,DI_W,DSIZ_0,DSIZ_1,
  DSIZ_2,DSIZ_3,DSIZ_4,DSIZ_5,DSIZ_6,DT,DVS,EN_ARRAYL1,EN_C1,EX,INDEX_0,INDEX_1,
  INDEX_2,INDEX_3,INDEX_4,INDEX_5,INDEX_LOOKUPB,INVAL,RD_WRB,SYS_CLK,
  TAG_EN,TEST_COMP,TEST_M1,TID_0,TID_1,TID_2,TID_3,TID_4,TID_5,TID_6,TID_7,
  WR,ZSEL_0,ZSEL_1,ZSEL_2,ZSEL_3,reset);
  output  DATA_COMP;
  output  DO_00;
  output  DO_01;
  output  DO_02;
  output  DO_03;
  output  DO_04;
  output  DO_05;
  output  DO_06;
  output  DO_07;
  output  DO_08;
  output  DO_09;
  output  DO_10;
  output  DO_11;
  output  DO_12;
  output  DO_13;
  output  DO_14;
  output  DO_15;
  output  DO_16;
  output  DO_17;
  output  DO_18;
  output  DO_19;
  output  DO_20;
  output  DO_21;
  output  DO_E;
  output  DO_G;
  output  DO_I;
  output  DO_K;
  output  DO_M;
  output  DO_PD_0;
  output  DO_PD_1;
  output  DO_PT_0;
  output  DO_PT_1;
  output  DO_PT_2;
  output  DO_PT_3;
  output  DO_V;
  output  DO_W;
  output  DSIZ_OUT_0;
  output  DSIZ_OUT_1;
  output  DSIZ_OUT_2;
  output  DSIZ_OUT_3;
  output  DSIZ_OUT_4;
  output  DSIZ_OUT_5;
  output  DSIZ_OUT_6;
  output  DT_OUT;
  output  EPN_OUT_00;
  output  EPN_OUT_01;
  output  EPN_OUT_02;
  output  EPN_OUT_03;
  output  EPN_OUT_04;
  output  EPN_OUT_05;
  output  EPN_OUT_06;
  output  EPN_OUT_07;
  output  EPN_OUT_08;
  output  EPN_OUT_09;
  output  EPN_OUT_10;
  output  EPN_OUT_11;
  output  EPN_OUT_12;
  output  EPN_OUT_13;
  output  EPN_OUT_14;
  output  EPN_OUT_15;
  output  EPN_OUT_16;
  output  EPN_OUT_17;
  output  EPN_OUT_18;
  output  EPN_OUT_19;
  output  EPN_OUT_20;
  output  EPN_OUT_21;
  output  EX_OUT;
  output  INDEX_OUT_0;
  output  INDEX_OUT_1;
  output  INDEX_OUT_2;
  output  INDEX_OUT_3;
  output  INDEX_OUT_4;
  output  INDEX_OUT_5;
  output  MISS;
  output  TAG_COMP;
  output  TID_OUT_0;
  output  TID_OUT_1;
  output  TID_OUT_2;
  output  TID_OUT_3;
  output  TID_OUT_4;
  output  TID_OUT_5;
  output  TID_OUT_6;
  output  TID_OUT_7;
  output  WR_OUT;
  output  ZSEL_OUT_0;
  output  ZSEL_OUT_1;
  output  ZSEL_OUT_2;
  output  ZSEL_OUT_3;
  input  DATA_EN;
  input  DI_00;
  input  DI_01;
  input  DI_02;
  input  DI_03;
  input  DI_04;
  input  DI_05;
  input  DI_06;
  input  DI_07;
  input  DI_08;
  input  DI_09;
  input  DI_10;
  input  DI_11;
  input  DI_12;
  input  DI_13;
  input  DI_14;
  input  DI_15;
  input  DI_16;
  input  DI_17;
  input  DI_18;
  input  DI_19;
  input  DI_20;
  input  DI_21;
  input  DI_CI_00;
  input  DI_CI_01;
  input  DI_CI_02;
  input  DI_CI_03;
  input  DI_CI_04;
  input  DI_CI_05;
  input  DI_CI_06;
  input  DI_CI_07;
  input  DI_CI_08;
  input  DI_CI_09;
  input  DI_CI_10;
  input  DI_CI_11;
  input  DI_CI_12;
  input  DI_CI_13;
  input  DI_CI_14;
  input  DI_CI_15;
  input  DI_CI_16;
  input  DI_CI_17;
  input  DI_CI_18;
  input  DI_CI_19;
  input  DI_CI_20_TEST_EVEN;
  input  DI_CI_21_TEST_ODD;
  input  DI_E;
  input  DI_G;
  input  DI_I;
  input  DI_K;
  input  DI_M;
  input  DI_PD_0;
  input  DI_PD_1;
  input  DI_PT_0;
  input  DI_PT_1;
  input  DI_PT_2;
  input  DI_PT_3;
  input  DI_V;
  input  DI_W;
  input  DSIZ_0;
  input  DSIZ_1;
  input  DSIZ_2;
  input  DSIZ_3;
  input  DSIZ_4;
  input  DSIZ_5;
  input  DSIZ_6;
  input  DT;
  input  DVS;
  input  EN_ARRAYL1;
  input  EN_C1;
  input  EX;
  input  INDEX_0;
  input  INDEX_1;
  input  INDEX_2;
  input  INDEX_3;
  input  INDEX_4;
  input  INDEX_5;
  input  INDEX_LOOKUPB;
  input  INVAL;
  input  RD_WRB;
  input  SYS_CLK;
  input  TAG_EN;
  input  TEST_COMP;
  input  TEST_M1;
  input  TID_0;
  input  TID_1;
  input  TID_2;
  input  TID_3;
  input  TID_4;
  input  TID_5;
  input  TID_6;
  input  TID_7;
  input  WR;
  input  ZSEL_0;
  input  ZSEL_1;
  input  ZSEL_2;
  input  ZSEL_3;
  input  reset;

  //
  // Internal signals
  //
  // Input grouping signal

  wire [0:5] INDEX;
  reg [0:5] matchIndex;
  wire [0:21] DI_CI;
  wire [0:7] TID;
  wire [0:6] DSIZ;
  wire [0:3] ERPN;
  wire [0:21] DI;
  wire [0:1] DI_PD;
  wire [0:3] DI_PT;
  wire [0:3] ZSEL;


 // Ouput grouping signal

  wire [0:7] TID_OUT;
  reg [0:5] INDEX_OUT;
  reg [0:5] index_int_reg;
  reg [0:5] index_int;
  reg [5:0] index_int_tmp;
  wire [0:3] ERPN_OUT;
  wire [0:21] EPN_OUT;
  wire [0:6] DSIZ_OUT;
  wire [0:3] DO_PT;
  wire [0:3] DO_PD;
  wire [0:21] DO;
  wire [0:3] ZSEL_OUT;
  wire INVAL;
 
  //

  reg dram_en;
  reg   dram_wr_en ;
  reg  start_lookup;
  wire [0:7] dram_index;
  wire [0:33] dram_in;
  wire [0:33] dram_out;
  reg  dram_out_sim_xx;
  wire [0:44] tag_in; 
  reg [0:32] cmp_res;
  reg [0:63] dsiz_cmp;
  reg [0:63] tid_cmp;
  integer i;
  reg [0:44] search_val;
  wire [0:63] hit;
  reg single_hit;
  reg more_hit;
  reg MISS;
  reg [0:63] dsiz_cmp_0;
  reg [0:63] dsiz_cmp_1;
  reg [0:63] dsiz_cmp_2;
  reg [0:63] dsiz_cmp_3;
  reg [0:63] dsiz_cmp_4;
  reg [0:63] dsiz_cmp_5;
  reg [0:63] dsiz_cmp_6;
  reg [0:63] dsiz_cmp_7;
  reg [0:63] di_t_cmp;
  
  reg [0:44] tag_ram_0;
  reg [0:44] tag_ram_1	;
  reg [0:44] tag_ram_2	;
  reg [0:44] tag_ram_3	;
  reg [0:44] tag_ram_4	;
  reg [0:44] tag_ram_5	;
  reg [0:44] tag_ram_6	;
  reg [0:44] tag_ram_7	;
  reg [0:44] tag_ram_8	;
  reg [0:44] tag_ram_9	;
  reg [0:44] tag_ram_10 ;
  reg [0:44] tag_ram_11 ;
  reg [0:44] tag_ram_12 ;
  reg [0:44] tag_ram_13 ;
  reg [0:44] tag_ram_14 ;
  reg [0:44] tag_ram_15 ;
  reg [0:44] tag_ram_16 ;
  reg [0:44] tag_ram_17 ;
  reg [0:44] tag_ram_18 ;
  reg [0:44] tag_ram_19 ;
  reg [0:44] tag_ram_20 ;
  reg [0:44] tag_ram_21 ;
  reg [0:44] tag_ram_22 ;
  reg [0:44] tag_ram_23 ;
  reg [0:44] tag_ram_24 ;
  reg [0:44] tag_ram_25 ;
  reg [0:44] tag_ram_26 ;
  reg [0:44] tag_ram_27 ;
  reg [0:44] tag_ram_28 ;
  reg [0:44] tag_ram_29 ;
  reg [0:44] tag_ram_30 ;
  reg [0:44] tag_ram_31 ;
  reg [0:44] tag_ram_32 ;
  reg [0:44] tag_ram_33 ;
  reg [0:44] tag_ram_34 ;
  reg [0:44] tag_ram_35 ;
  reg [0:44] tag_ram_36 ;
  reg [0:44] tag_ram_37 ;
  reg [0:44] tag_ram_38 ;
  reg [0:44] tag_ram_39 ;
  reg [0:44] tag_ram_40 ;
  reg [0:44] tag_ram_41 ;
  reg [0:44] tag_ram_42 ;
  reg [0:44] tag_ram_43 ;
  reg [0:44] tag_ram_44 ;
  reg [0:44] tag_ram_45 ;
  reg [0:44] tag_ram_46 ;
  reg [0:44] tag_ram_47 ;
  reg [0:44] tag_ram_48 ;
  reg [0:44] tag_ram_49 ;
  reg [0:44] tag_ram_50 ;
  reg [0:44] tag_ram_51 ;
  reg [0:44] tag_ram_52 ;
  reg [0:44] tag_ram_53 ;
  reg [0:44] tag_ram_54 ;
  reg [0:44] tag_ram_55 ;
  reg [0:44] tag_ram_56 ;
  reg [0:44] tag_ram_57 ;
  reg [0:44] tag_ram_58 ;
  reg [0:44] tag_ram_59 ;
  reg [0:44] tag_ram_60 ;
  reg [0:44] tag_ram_61 ;
  reg [0:44] tag_ram_62 ;
  reg [0:44] tag_ram_63 ;
  reg [0:6] dsiz_val;
  reg [0:21] dsiz_mask;
  reg tid_tmp;
  reg [0:7] tid_mask;
 



 wire [0:21] dsiz_mask_0 ; 
 wire [0:21] dsiz_mask_1 ; 
 wire [0:21] dsiz_mask_2 ; 
 wire [0:21] dsiz_mask_3 ; 
 wire [0:21] dsiz_mask_4 ; 
 wire [0:21] dsiz_mask_5 ; 
 wire [0:21] dsiz_mask_6 ; 
 wire [0:21] dsiz_mask_7 ; 
 wire [0:21] dsiz_mask_8 ; 
 wire [0:21] dsiz_mask_9 ; 
 wire [0:21] dsiz_mask_10 ; 
 wire [0:21] dsiz_mask_11 ; 
 wire [0:21] dsiz_mask_12 ; 
 wire [0:21] dsiz_mask_13 ; 
 wire [0:21] dsiz_mask_14 ; 
 wire [0:21] dsiz_mask_15 ; 
 wire [0:21] dsiz_mask_16 ; 
 wire [0:21] dsiz_mask_17 ; 
 wire [0:21] dsiz_mask_18 ; 
 wire [0:21] dsiz_mask_19 ; 
 wire [0:21] dsiz_mask_20 ; 
 wire [0:21] dsiz_mask_21 ; 
 wire [0:21] dsiz_mask_22 ; 
 wire [0:21] dsiz_mask_23 ; 
 wire [0:21] dsiz_mask_24 ; 
 wire [0:21] dsiz_mask_25 ; 
 wire [0:21] dsiz_mask_26 ; 
 wire [0:21] dsiz_mask_27 ; 
 wire [0:21] dsiz_mask_28 ; 
 wire [0:21] dsiz_mask_29 ; 
 wire [0:21] dsiz_mask_30 ; 
 wire [0:21] dsiz_mask_31 ; 
 wire [0:21] dsiz_mask_32 ; 
 wire [0:21] dsiz_mask_33 ; 
 wire [0:21] dsiz_mask_34 ; 
 wire [0:21] dsiz_mask_35 ; 
 wire [0:21] dsiz_mask_36 ; 
 wire [0:21] dsiz_mask_37 ; 
 wire [0:21] dsiz_mask_38 ; 
 wire [0:21] dsiz_mask_39 ; 
 wire [0:21] dsiz_mask_40 ; 
 wire [0:21] dsiz_mask_41 ; 
 wire [0:21] dsiz_mask_42 ; 
 wire [0:21] dsiz_mask_43 ; 
 wire [0:21] dsiz_mask_44 ; 
 wire [0:21] dsiz_mask_45 ; 
 wire [0:21] dsiz_mask_46 ; 
 wire [0:21] dsiz_mask_47 ; 
 wire [0:21] dsiz_mask_48 ; 
 wire [0:21] dsiz_mask_49 ; 
 wire [0:21] dsiz_mask_50 ; 
 wire [0:21] dsiz_mask_51 ; 
 wire [0:21] dsiz_mask_52 ; 
 wire [0:21] dsiz_mask_53 ; 
 wire [0:21] dsiz_mask_54 ; 
 wire [0:21] dsiz_mask_55 ; 
 wire [0:21] dsiz_mask_56 ; 
 wire [0:21] dsiz_mask_57 ; 
 wire [0:21] dsiz_mask_58 ; 
 wire [0:21] dsiz_mask_59 ; 
 wire [0:21] dsiz_mask_60 ; 
 wire [0:21] dsiz_mask_61 ; 
 wire [0:21] dsiz_mask_62 ; 
 wire [0:21] dsiz_mask_63 ; 
 wire [0:7] tid_mask_0  ;
 wire [0:7] tid_mask_1  ;
 wire [0:7] tid_mask_2  ;
 wire [0:7] tid_mask_3  ;
 wire [0:7] tid_mask_4  ;
 wire [0:7] tid_mask_5  ;
 wire [0:7] tid_mask_6  ;
 wire [0:7] tid_mask_7  ;
 wire [0:7] tid_mask_8  ;
 wire [0:7] tid_mask_9  ;
 wire [0:7] tid_mask_10  ;
 wire [0:7] tid_mask_11  ;
 wire [0:7] tid_mask_12  ;
 wire [0:7] tid_mask_13  ;
 wire [0:7] tid_mask_14  ;
 wire [0:7] tid_mask_15  ;
 wire [0:7] tid_mask_16  ;
 wire [0:7] tid_mask_17  ;
 wire [0:7] tid_mask_18  ;
 wire [0:7] tid_mask_19  ;
 wire [0:7] tid_mask_20  ;
 wire [0:7] tid_mask_21  ;
 wire [0:7] tid_mask_22  ;
 wire [0:7] tid_mask_23  ;
 wire [0:7] tid_mask_24  ;
 wire [0:7] tid_mask_25  ;
 wire [0:7] tid_mask_26  ;
 wire [0:7] tid_mask_27  ;
 wire [0:7] tid_mask_28  ;
 wire [0:7] tid_mask_29  ;
 wire [0:7] tid_mask_30  ;
 wire [0:7] tid_mask_31  ;
 wire [0:7] tid_mask_32  ;
 wire [0:7] tid_mask_33  ;
 wire [0:7] tid_mask_34  ;
 wire [0:7] tid_mask_35  ;
 wire [0:7] tid_mask_36  ;
 wire [0:7] tid_mask_37  ;
 wire [0:7] tid_mask_38  ;
 wire [0:7] tid_mask_39  ;
 wire [0:7] tid_mask_40  ;
 wire [0:7] tid_mask_41  ;
 wire [0:7] tid_mask_42  ;
 wire [0:7] tid_mask_43  ;
 wire [0:7] tid_mask_44  ;
 wire [0:7] tid_mask_45  ;
 wire [0:7] tid_mask_46  ;
 wire [0:7] tid_mask_47  ;
 wire [0:7] tid_mask_48  ;
 wire [0:7] tid_mask_49  ;
 wire [0:7] tid_mask_50  ;
 wire [0:7] tid_mask_51  ;
 wire [0:7] tid_mask_52  ;
 wire [0:7] tid_mask_53  ;
 wire [0:7] tid_mask_54  ;
 wire [0:7] tid_mask_55  ;
 wire [0:7] tid_mask_56  ;
 wire [0:7] tid_mask_57  ;
 wire [0:7] tid_mask_58  ;
 wire [0:7] tid_mask_59  ;
 wire [0:7] tid_mask_60  ;
 wire [0:7] tid_mask_61  ;
 wire [0:7] tid_mask_62  ;
 wire [0:7] tid_mask_63  ;
 wire [0:30] comp_res_0 ; 
 wire [0:30] comp_res_1 ; 
 wire [0:30] comp_res_2 ; 
 wire [0:30] comp_res_3 ; 
 wire [0:30] comp_res_4 ; 
 wire [0:30] comp_res_5 ; 
 wire [0:30] comp_res_6 ; 
 wire [0:30] comp_res_7 ; 
 wire [0:30] comp_res_8 ; 
 wire [0:30] comp_res_9 ; 
 wire [0:30] comp_res_10 ; 
 wire [0:30] comp_res_11 ; 
 wire [0:30] comp_res_12 ; 
 wire [0:30] comp_res_13 ; 
 wire [0:30] comp_res_14 ; 
 wire [0:30] comp_res_15 ; 
 wire [0:30] comp_res_16 ; 
 wire [0:30] comp_res_17 ; 
 wire [0:30] comp_res_18 ; 
 wire [0:30] comp_res_19 ; 
 wire [0:30] comp_res_20 ; 
 wire [0:30] comp_res_21 ; 
 wire [0:30] comp_res_22 ; 
 wire [0:30] comp_res_23 ; 
 wire [0:30] comp_res_24 ; 
 wire [0:30] comp_res_25 ; 
 wire [0:30] comp_res_26 ; 
 wire [0:30] comp_res_27 ; 
 wire [0:30] comp_res_28 ; 
 wire [0:30] comp_res_29 ; 
 wire [0:30] comp_res_30 ; 
 wire [0:30] comp_res_31 ; 
 wire [0:30] comp_res_32 ; 
 wire [0:30] comp_res_33 ; 
 wire [0:30] comp_res_34 ; 
 wire [0:30] comp_res_35 ; 
 wire [0:30] comp_res_36 ; 
 wire [0:30] comp_res_37 ; 
 wire [0:30] comp_res_38 ; 
 wire [0:30] comp_res_39 ; 
 wire [0:30] comp_res_40 ; 
 wire [0:30] comp_res_41 ; 
 wire [0:30] comp_res_42 ; 
 wire [0:30] comp_res_43 ; 
 wire [0:30] comp_res_44 ; 
 wire [0:30] comp_res_45 ; 
 wire [0:30] comp_res_46 ; 
 wire [0:30] comp_res_47 ; 
 wire [0:30] comp_res_48 ; 
 wire [0:30] comp_res_49 ; 
 wire [0:30] comp_res_50 ; 
 wire [0:30] comp_res_51 ; 
 wire [0:30] comp_res_52 ; 
 wire [0:30] comp_res_53 ; 
 wire [0:30] comp_res_54 ; 
 wire [0:30] comp_res_55 ; 
 wire [0:30] comp_res_56 ; 
 wire [0:30] comp_res_57 ; 
 wire [0:30] comp_res_58 ; 
 wire [0:30] comp_res_59 ; 
 wire [0:30] comp_res_60 ; 
 wire [0:30] comp_res_61 ; 
 wire [0:30] comp_res_62 ; 
 wire [0:30] comp_res_63 ; 
 reg [0:44] tag_rd_1_out;
 wire [0:44] tag_rd_1_out_temp;

  function [0:44] tag_rd_1 ;
input [0:5] rd_index;
begin
  case(rd_index ) 
   0: tag_rd_1 =  tag_ram_0   [0:44];
   1: tag_rd_1 =  tag_ram_1   [0:44];
   2: tag_rd_1 =  tag_ram_2   [0:44];
   3: tag_rd_1 =  tag_ram_3   [0:44];
   4: tag_rd_1 =  tag_ram_4   [0:44];
   5: tag_rd_1 =  tag_ram_5   [0:44];
   6: tag_rd_1 =  tag_ram_6   [0:44];
   7: tag_rd_1 =  tag_ram_7   [0:44];
   8: tag_rd_1 =  tag_ram_8   [0:44];
   9: tag_rd_1 =    tag_ram_9  [0:44];
   10: tag_rd_1 =  tag_ram_10  [0:44];
   11: tag_rd_1 =  tag_ram_11  [0:44];
   12: tag_rd_1 =  tag_ram_12  [0:44];
   13: tag_rd_1 =  tag_ram_13  [0:44];
   14: tag_rd_1 =  tag_ram_14  [0:44];
   15: tag_rd_1 =  tag_ram_15  [0:44];
   16: tag_rd_1 =  tag_ram_16  [0:44];
   17: tag_rd_1 =  tag_ram_17  [0:44];
   18: tag_rd_1 =  tag_ram_18  [0:44];
   19: tag_rd_1 =  tag_ram_19  [0:44];
   20: tag_rd_1 =  tag_ram_20  [0:44];
   21: tag_rd_1 =  tag_ram_21  [0:44];
   22: tag_rd_1 =  tag_ram_22  [0:44];
   23: tag_rd_1 =  tag_ram_23  [0:44];
   24: tag_rd_1 =  tag_ram_24  [0:44];
   25: tag_rd_1 =  tag_ram_25  [0:44];
   26: tag_rd_1 =  tag_ram_26  [0:44];
   27: tag_rd_1 =  tag_ram_27  [0:44];
   28: tag_rd_1 =  tag_ram_28  [0:44];
   29: tag_rd_1 =  tag_ram_29  [0:44];
   30: tag_rd_1 =  tag_ram_30  [0:44];
   31: tag_rd_1 =  tag_ram_31  [0:44];
   32: tag_rd_1 =  tag_ram_32  [0:44];
   33: tag_rd_1 =  tag_ram_33  [0:44];
   34: tag_rd_1 =  tag_ram_34  [0:44];
   35: tag_rd_1 =  tag_ram_35  [0:44];
   36: tag_rd_1 =  tag_ram_36  [0:44];
   37: tag_rd_1 =  tag_ram_37  [0:44];
   38: tag_rd_1 =  tag_ram_38  [0:44];
   39: tag_rd_1 =  tag_ram_39  [0:44];
   40: tag_rd_1 =  tag_ram_40  [0:44];
   41: tag_rd_1 =  tag_ram_41  [0:44];
   42: tag_rd_1 =  tag_ram_42  [0:44];
   43: tag_rd_1 =  tag_ram_43  [0:44];
   44: tag_rd_1 =  tag_ram_44  [0:44];
   45: tag_rd_1 =  tag_ram_45  [0:44];
   46: tag_rd_1 =  tag_ram_46  [0:44];
   47: tag_rd_1 =  tag_ram_47  [0:44];
   48: tag_rd_1 =  tag_ram_48  [0:44];
   49: tag_rd_1 =  tag_ram_49  [0:44];
   50: tag_rd_1 =  tag_ram_50  [0:44];
   51: tag_rd_1 =  tag_ram_51  [0:44];
   52: tag_rd_1 =  tag_ram_52  [0:44];
   53: tag_rd_1 =  tag_ram_53  [0:44];
   54: tag_rd_1 =  tag_ram_54  [0:44];
   55: tag_rd_1 =  tag_ram_55  [0:44];
   56: tag_rd_1 =  tag_ram_56  [0:44];
   57: tag_rd_1 =  tag_ram_57  [0:44];
   58: tag_rd_1 =  tag_ram_58  [0:44];
   59: tag_rd_1 =  tag_ram_59  [0:44];
   60: tag_rd_1 =  tag_ram_60  [0:44];
   61: tag_rd_1 =  tag_ram_61  [0:44];
   62: tag_rd_1 =  tag_ram_62  [0:44];
   63: tag_rd_1 =  tag_ram_63  [0:44];
   default: tag_rd_1 = 45'h0;
 endcase
end
endfunction



  //
  // Input grouping
  //


  assign DI_PT [0:3] = {DI_PT_0,DI_PT_1,DI_PT_2,DI_PT_3};

  assign DI_PD [0:1]  = {DI_PD_0,DI_PD_1};

  assign DI [0:21] = {DI_00,DI_01,DI_02,DI_03,DI_04,DI_05,DI_06,DI_07,
    DI_08,DI_09,DI_10,DI_11,DI_12,DI_13,DI_14,DI_15,DI_16,DI_17,DI_18,
    DI_19,DI_20,DI_21};


  assign DSIZ [0:6] = {DSIZ_0,DSIZ_1,DSIZ_2,DSIZ_3,DSIZ_4,DSIZ_5,DSIZ_6};

  assign TID [0:7] = {TID_0,TID_1,TID_2,TID_3,TID_4,TID_5,TID_6,TID_7};

  assign DI_CI [0:21] = { DI_CI_00,DI_CI_01,DI_CI_02,DI_CI_03, DI_CI_04,
    DI_CI_05,DI_CI_06,DI_CI_07,DI_CI_08,DI_CI_09,DI_CI_10,DI_CI_11,
    DI_CI_12,DI_CI_13,DI_CI_14,DI_CI_15,DI_CI_16,DI_CI_17,DI_CI_18,
    DI_CI_19, DI_CI_20_TEST_EVEN, DI_CI_21_TEST_ODD };

 // assign INDEX[0:5] = {INDEX_0,INDEX_1,INDEX_2,INDEX_3,INDEX_4,INDEX_5};

  assign ZSEL [0:3] = {ZSEL_0,ZSEL_1,ZSEL_2,ZSEL_3};


 //
 // OUTPUT grouping
 //

  assign {DO_00,DO_01,DO_02,DO_03,DO_04,DO_05,DO_06,DO_07,DO_08,
   DO_09,DO_10,DO_11,DO_12,DO_13,DO_14,DO_15,DO_16,DO_17,DO_18,
   DO_19,DO_20,DO_21} = DO [0:21];
  
  assign {DO_PD_0,DO_PD_1} = DO_PD [0:1];

  assign {DO_PT_0,DO_PT_1,DO_PT_2,DO_PT_3} = DO_PT [0:3];


  assign {DSIZ_OUT_0,DSIZ_OUT_1,DSIZ_OUT_2,DSIZ_OUT_3,
    DSIZ_OUT_4,DSIZ_OUT_5,DSIZ_OUT_6} = DSIZ_OUT [0:6];

  assign {EPN_OUT_00,EPN_OUT_01,EPN_OUT_02,EPN_OUT_03,
        EPN_OUT_04,EPN_OUT_05,EPN_OUT_06,EPN_OUT_07,
   EPN_OUT_08,EPN_OUT_09,EPN_OUT_10,EPN_OUT_11,EPN_OUT_12,EPN_OUT_13,
   EPN_OUT_14,EPN_OUT_15,EPN_OUT_16,EPN_OUT_17,
   EPN_OUT_18,EPN_OUT_19,EPN_OUT_20, EPN_OUT_21} = EPN_OUT [0:21] ;


  assign {INDEX_OUT_0,INDEX_OUT_1,INDEX_OUT_2,
        INDEX_OUT_3,INDEX_OUT_4,INDEX_OUT_5} = INDEX_OUT[0:5];

  always @ (posedge SYS_CLK or negedge reset) 
   if (!reset) begin
     INDEX_OUT [0:5] <= 6'b000000;
   end
   else begin
     if (start_lookup)
       INDEX_OUT [0:5] <= index_int;
     else
       INDEX_OUT [0:5] <= index_int_reg;
   end

  always @ (posedge SYS_CLK or negedge reset) 
   if (!reset) begin
    index_int_reg <= 6'h0;
   end
   else begin
    if (start_lookup) 
      index_int_reg <= index_int;
   end
  assign {TID_OUT_0,TID_OUT_1,TID_OUT_2,TID_OUT_3,TID_OUT_4,TID_OUT_5,
   TID_OUT_6,TID_OUT_7} = TID_OUT [0:7];

  assign {ZSEL_OUT_0,ZSEL_OUT_1,ZSEL_OUT_2,ZSEL_OUT_3} = ZSEL_OUT [0:3];

  //
  //
  // OUTPUT DRIVING
  //
   assign TAG_COMP = (&(~(tag_rd_1_out[0:44] ^ {{22{DI_CI_20_TEST_EVEN, DI_CI_21_TEST_ODD}}, DI_CI_20_TEST_EVEN}))) ;
   assign DATA_COMP = (&(~(dram_out[0:33] ^ {17{DI_CI_20_TEST_EVEN, DI_CI_21_TEST_ODD}})));
//The following is to match simulation
//without the ifdef this goes away.
`ifdef VCDFILETEST
    assign {DO[0:21],EX_OUT,WR_OUT,ZSEL_OUT[0:3],DO_W,DO_I,DO_M,DO_G,
            DO_PD [0:1] } = dram_out_sim_xx ? dram_out : 34'hxxxxxxxxx;
`else
    assign {DO[0:21],EX_OUT,WR_OUT,ZSEL_OUT[0:3],DO_W,DO_I,DO_M,DO_G,
            DO_PD [0:1] } = dram_out;
`endif
          
//The following is to match simulation
//using the vcdfile, should not be
//used with any other simulation
//without the ifdef this goes away.
`ifdef VCDFILETEST
  always @ (posedge SYS_CLK  ) begin
   
        if (EN_C1 && EN_ARRAYL1 && INDEX_LOOKUPB ) begin
          if (RD_WRB && DATA_EN)
            dram_out_sim_xx <= 1'b1;
        end
        else begin
          if (~single_hit) begin
            if (EN_C1 && EN_ARRAYL1 && ~INDEX_LOOKUPB)
              dram_out_sim_xx <= 1'b0;
          end
          else begin
            if (~more_hit) 
            dram_out_sim_xx <= 1'b1;
          end
        end
      end
`endif

  assign {EPN_OUT [0:21],DSIZ_OUT[0:6],DT_OUT,TID_OUT[0:7],
           DO_PT[3],DO_PT[2],DO_PT[1],DO_PT[0],DO_E,DO_K, DO_V} = tag_rd_1_out;
  always @ (posedge SYS_CLK  ) begin
   
        if (EN_C1 && EN_ARRAYL1)  
          if (INDEX_LOOKUPB && RD_WRB)
            tag_rd_1_out <= tag_rd_1 (INDEX);
          else
            if (single_hit && ~more_hit ) begin
              case(matchIndex ) 
               0: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_0[22:29],tag_ram_0[38:43]};
               1: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_1[22:29],tag_ram_1[38:43]};
               2: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_2[22:29],tag_ram_2[38:43]};
               3: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_3[22:29],tag_ram_3[38:43]};
               4: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_4[22:29],tag_ram_4[38:43]};
               5: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_5[22:29],tag_ram_5[38:43]};
               6: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_6[22:29],tag_ram_6[38:43]};
               7: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_7[22:29],tag_ram_7[38:43]};
               8: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_8[22:29],tag_ram_8[38:43]};
               9: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_9[22:29],tag_ram_9[38:43]};
               10: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_10[22:29],tag_ram_10[38:43]};
               11: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_11[22:29],tag_ram_11[38:43]};
               12: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_12[22:29],tag_ram_12[38:43]};
               13: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_13[22:29],tag_ram_13[38:43]};
               14: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_14[22:29],tag_ram_14[38:43]};
               15: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_15[22:29],tag_ram_15[38:43]};
               16: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_16[22:29],tag_ram_16[38:43]};
               17: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_17[22:29],tag_ram_17[38:43]};
               18: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_18[22:29],tag_ram_18[38:43]};
               19: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_19[22:29],tag_ram_19[38:43]};
               20: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_20[22:29],tag_ram_20[38:43]};
               21: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_21[22:29],tag_ram_21[38:43]};
               22: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_22[22:29],tag_ram_22[38:43]};
               23: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_23[22:29],tag_ram_23[38:43]};
               24: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_24[22:29],tag_ram_24[38:43]};
               25: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_25[22:29],tag_ram_25[38:43]};
               26: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_26[22:29],tag_ram_26[38:43]};
               27: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_27[22:29],tag_ram_27[38:43]};
               28: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_28[22:29],tag_ram_28[38:43]};
               29: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_29[22:29],tag_ram_29[38:43]};
               30: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_30[22:29],tag_ram_30[38:43]};
               31: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_31[22:29],tag_ram_31[38:43]};
               32: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_32[22:29],tag_ram_32[38:43]};
               33: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_33[22:29],tag_ram_33[38:43]};
               34: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_34[22:29],tag_ram_34[38:43]};
               35: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_35[22:29],tag_ram_35[38:43]};
               36: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_36[22:29],tag_ram_36[38:43]};
               37: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_37[22:29],tag_ram_37[38:43]};
               38: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_38[22:29],tag_ram_38[38:43]};
               39: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_39[22:29],tag_ram_39[38:43]};
               40: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_40[22:29],tag_ram_40[38:43]};
               41: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_41[22:29],tag_ram_41[38:43]};
               42: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_42[22:29],tag_ram_42[38:43]};
               43: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_43[22:29],tag_ram_43[38:43]};
               44: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_44[22:29],tag_ram_44[38:43]};
               45: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_45[22:29],tag_ram_45[38:43]};
               46: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_46[22:29],tag_ram_46[38:43]};
               47: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_47[22:29],tag_ram_47[38:43]};
               48: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_48[22:29],tag_ram_48[38:43]};
               49: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_49[22:29],tag_ram_49[38:43]};
               50: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_50[22:29],tag_ram_50[38:43]};
               51: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_51[22:29],tag_ram_51[38:43]};
               52: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_52[22:29],tag_ram_52[38:43]};
               53: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_53[22:29],tag_ram_53[38:43]};
               54: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_54[22:29],tag_ram_54[38:43]};
               55: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_55[22:29],tag_ram_55[38:43]};
               56: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_56[22:29],tag_ram_56[38:43]};
               57: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_57[22:29],tag_ram_57[38:43]};
               58: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_58[22:29],tag_ram_58[38:43]};
               59: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_59[22:29],tag_ram_59[38:43]};
               60: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_60[22:29],tag_ram_60[38:43]};
               61: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_61[22:29],tag_ram_61[38:43]};
               62: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_62[22:29],tag_ram_62[38:43]};
               63: {tag_rd_1_out[22:29],tag_rd_1_out[38:43]} <=  {tag_ram_63[22:29],tag_ram_63[38:43]};
               default: tag_rd_1_out <= 45'h0;
             endcase
          end
            //The following is to match simulation
            //without the ifdef this goes away.
        `ifdef VCDFILETEST
          else
            if (~INDEX_LOOKUPB)
              tag_rd_1_out <= 45'hxxxxxxxxxxxx;
        `endif
      end

  //
  // CAM  read/write Logic
  //
  assign tag_in [0:44] = {DI_CI[0:21],
                   DSIZ[0:6],
                   DT,
                   TID[0:7],
                   DI_PT[3],
                   DI_PT[2],
                   DI_PT[1],
                   DI_PT[0],
                   DI_E,DI_K,DI_V};
  assign INDEX[0:5] = {INDEX_0,
                INDEX_1,
                INDEX_2,
                INDEX_3,
                INDEX_4,
                INDEX_5};

  always @ (posedge SYS_CLK  ) begin
      if (EN_C1 && EN_ARRAYL1 && INDEX_LOOKUPB && TAG_EN ) begin
        if (~RD_WRB) begin
          case(INDEX )
             0: tag_ram_0 <= tag_in;
             1: tag_ram_1 <= tag_in;
             2: tag_ram_2 <= tag_in;
             3: tag_ram_3 <= tag_in;
             4: tag_ram_4 <= tag_in;
             5: tag_ram_5 <= tag_in;
             6: tag_ram_6 <= tag_in;
             7: tag_ram_7 <= tag_in;
             8: tag_ram_8 <= tag_in;
             9: tag_ram_9  <= tag_in;
            10: tag_ram_10  <= tag_in;
            11: tag_ram_11  <= tag_in;
            12: tag_ram_12  <= tag_in;
            13: tag_ram_13  <= tag_in;
            14: tag_ram_14  <= tag_in;
            15: tag_ram_15  <= tag_in;
            16: tag_ram_16  <= tag_in;
            17: tag_ram_17  <= tag_in;
            18: tag_ram_18  <= tag_in;
            19: tag_ram_19  <= tag_in;
            20: tag_ram_20  <= tag_in;
            21: tag_ram_21  <= tag_in;
            22: tag_ram_22  <= tag_in;
            23: tag_ram_23  <= tag_in;
            24: tag_ram_24  <= tag_in;
            25: tag_ram_25  <= tag_in;
            26: tag_ram_26  <= tag_in;
            27: tag_ram_27  <= tag_in;
            28: tag_ram_28  <= tag_in;
            29: tag_ram_29  <= tag_in;
            30: tag_ram_30  <= tag_in;
            31: tag_ram_31  <= tag_in;
            32: tag_ram_32  <= tag_in;
            33: tag_ram_33  <= tag_in;
            34: tag_ram_34  <= tag_in;
            35: tag_ram_35  <= tag_in;
            36: tag_ram_36  <= tag_in;
            37: tag_ram_37  <= tag_in;
            38: tag_ram_38  <= tag_in;
            39: tag_ram_39  <= tag_in;
            40: tag_ram_40  <= tag_in;
            41: tag_ram_41  <= tag_in;
            42: tag_ram_42  <= tag_in;
            43: tag_ram_43  <= tag_in;
            44: tag_ram_44  <= tag_in;
            45: tag_ram_45  <= tag_in;
            46: tag_ram_46  <= tag_in;
            47: tag_ram_47  <= tag_in;
            48: tag_ram_48  <= tag_in;
            49: tag_ram_49  <= tag_in;
            50: tag_ram_50  <= tag_in;
            51: tag_ram_51  <= tag_in;
            52: tag_ram_52  <= tag_in;
            53: tag_ram_53  <= tag_in;
            54: tag_ram_54  <= tag_in;
            55: tag_ram_55  <= tag_in;
            56: tag_ram_56  <= tag_in;
            57: tag_ram_57  <= tag_in;
            58: tag_ram_58  <= tag_in;
            59: tag_ram_59  <= tag_in;
            60: tag_ram_60  <= tag_in;
            61: tag_ram_61  <= tag_in;
            62: tag_ram_62  <= tag_in;
            63: tag_ram_63  <= tag_in;
          endcase
        end
      end
      //If invalidate set, invalidate all
      if (INVAL) begin
	     tag_ram_0[44] <= 1'b0;
	     tag_ram_1[44] <= 1'b0;
	     tag_ram_2[44] <= 1'b0;
	     tag_ram_3[44] <= 1'b0;
	     tag_ram_4[44] <= 1'b0;
	     tag_ram_5[44] <= 1'b0;
	     tag_ram_6[44] <= 1'b0;
	     tag_ram_7[44] <= 1'b0;
	     tag_ram_8[44] <= 1'b0;
	     tag_ram_9[44]  <= 1'b0;
	     tag_ram_10[44]  <= 1'b0;
	     tag_ram_11[44]  <= 1'b0;
	     tag_ram_12[44]  <= 1'b0;
	     tag_ram_13[44]  <= 1'b0;
	     tag_ram_14[44]  <= 1'b0;
	     tag_ram_15[44]  <= 1'b0;
	     tag_ram_16[44]  <= 1'b0;
	     tag_ram_17[44]  <= 1'b0;
	     tag_ram_18[44]  <= 1'b0;
	     tag_ram_19[44]  <= 1'b0;
	     tag_ram_20[44]  <= 1'b0;
	     tag_ram_21[44]  <= 1'b0;
	     tag_ram_22[44]  <= 1'b0;
	     tag_ram_23[44]  <= 1'b0;
	     tag_ram_24[44]  <= 1'b0;
	     tag_ram_25[44]  <= 1'b0;
	     tag_ram_26[44]  <= 1'b0;
	     tag_ram_27[44]  <= 1'b0;
	     tag_ram_28[44]  <= 1'b0;
	     tag_ram_29[44]  <= 1'b0;
	     tag_ram_30[44]  <= 1'b0;
	     tag_ram_31[44]  <= 1'b0;
	     tag_ram_32[44]  <= 1'b0;
	     tag_ram_33[44]  <= 1'b0;
	     tag_ram_34[44]  <= 1'b0;
	     tag_ram_35[44]  <= 1'b0;
	     tag_ram_36[44]  <= 1'b0;
	     tag_ram_37[44]  <= 1'b0;
	     tag_ram_38[44]  <= 1'b0;
	     tag_ram_39[44]  <= 1'b0;
	     tag_ram_40[44]  <= 1'b0;
	     tag_ram_41[44]  <= 1'b0;
	     tag_ram_42[44]  <= 1'b0;
	     tag_ram_43[44]  <= 1'b0;
	     tag_ram_44[44]  <= 1'b0;
	     tag_ram_45[44]  <= 1'b0;
	     tag_ram_46[44]  <= 1'b0;
	     tag_ram_47[44]  <= 1'b0;
	     tag_ram_48[44]  <= 1'b0;
	     tag_ram_49[44]  <= 1'b0;
	     tag_ram_50[44]  <= 1'b0;
	     tag_ram_51[44]  <= 1'b0;
	     tag_ram_52[44]  <= 1'b0;
	     tag_ram_53[44]  <= 1'b0;
	     tag_ram_54[44]  <= 1'b0;
	     tag_ram_55[44]  <= 1'b0;
	     tag_ram_56[44]  <= 1'b0;
	     tag_ram_57[44]  <= 1'b0;
	     tag_ram_58[44]  <= 1'b0;
	     tag_ram_59[44]  <= 1'b0;
	     tag_ram_60[44]  <= 1'b0;
	     tag_ram_61[44]  <= 1'b0;
	     tag_ram_62[44]  <= 1'b0;
	     tag_ram_63[44]  <= 1'b0;
     end
  end

  //
  // CAM  index_lookup operations
  // 

  always @ (EN_C1 or EN_ARRAYL1 or INDEX_LOOKUPB ) begin
    if (EN_C1 && EN_ARRAYL1 && !INDEX_LOOKUPB) begin
      start_lookup = 'b1;
    end
    else begin
      start_lookup = 'b0;
    end
  end


 // hit [0] logic 

  assign dsiz_mask_0 = { {8{1'b1}}, 
                 { 2{~tag_ram_0[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_0[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_0[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_0[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_0[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_0[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_0[`DSIZ_6_B]}} } ; 
  assign tid_mask_0 = {8{~tag_ram_0[`DT_B]}} ; 

  assign comp_res_0 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_0[`V_B],tag_ram_0[`COMP_7],tag_ram_0 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_0,tid_mask_0}); 
  assign hit[0] = comp_res_0 == 0 && start_lookup ; 


 // hit [1] logic 

  assign dsiz_mask_1 = { {8{1'b1}}, 
                 { 2{~tag_ram_1[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_1[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_1[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_1[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_1[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_1[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_1[`DSIZ_6_B]}} } ; 
  assign tid_mask_1 = {8{~tag_ram_1[`DT_B]}} ; 

  assign comp_res_1 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_1[`V_B],tag_ram_1[`COMP_7],tag_ram_1 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_1,tid_mask_1}); 

  assign hit[1] = comp_res_1 == 0 && start_lookup ; 


 // hit [2] logic 

  assign dsiz_mask_2 = { {8{1'b1}}, 
                 { 2{~tag_ram_2[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_2[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_2[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_2[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_2[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_2[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_2[`DSIZ_6_B]}} } ; 
  assign tid_mask_2 = {8{~tag_ram_2[`DT_B]}} ; 

  assign comp_res_2 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_2[`V_B],tag_ram_2[`COMP_7],tag_ram_2 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_2,tid_mask_2}); 

  assign hit[2] = comp_res_2 == 0 && start_lookup ; 


 // hit [3] logic 

  assign dsiz_mask_3 = { {8{1'b1}}, 
                 { 2{~tag_ram_3[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_3[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_3[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_3[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_3[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_3[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_3[`DSIZ_6_B]}} } ; 
  assign tid_mask_3 = {8{~tag_ram_3[`DT_B]}} ; 

  assign comp_res_3 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_3[`V_B],tag_ram_3[`COMP_7],tag_ram_3 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_3,tid_mask_3}); 

  assign hit[3] = comp_res_3 == 0 && start_lookup ; 


 // hit [4] logic 

  assign dsiz_mask_4 = { {8{1'b1}}, 
                 { 2{~tag_ram_4[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_4[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_4[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_4[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_4[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_4[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_4[`DSIZ_6_B]}} } ; 
  assign tid_mask_4 = {8{~tag_ram_4[`DT_B]}} ; 

  assign comp_res_4 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_4[`V_B],tag_ram_4[`COMP_7],tag_ram_4 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_4,tid_mask_4}); 

  assign hit[4] = comp_res_4 == 0 && start_lookup ; 


 // hit [5] logic 

  assign dsiz_mask_5 = { {8{1'b1}}, 
                 { 2{~tag_ram_5[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_5[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_5[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_5[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_5[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_5[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_5[`DSIZ_6_B]}} } ; 
  assign tid_mask_5 = {8{~tag_ram_5[`DT_B]}} ; 

  assign comp_res_5 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_5[`V_B],tag_ram_5[`COMP_7],tag_ram_5 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_5,tid_mask_5}); 

  assign hit[5] = comp_res_5 == 0 && start_lookup ; 


 // hit [6] logic 

  assign dsiz_mask_6 = { {8{1'b1}}, 
                 { 2{~tag_ram_6[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_6[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_6[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_6[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_6[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_6[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_6[`DSIZ_6_B]}} } ; 
  assign tid_mask_6 = {8{~tag_ram_6[`DT_B]}} ; 

  assign comp_res_6 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_6[`V_B],tag_ram_6[`COMP_7],tag_ram_6 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_6,tid_mask_6}); 

  assign hit[6] = comp_res_6 == 0 && start_lookup ; 


 // hit [7] logic 

  assign dsiz_mask_7 = { {8{1'b1}}, 
                 { 2{~tag_ram_7[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_7[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_7[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_7[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_7[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_7[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_7[`DSIZ_6_B]}} } ; 
  assign tid_mask_7 = {8{~tag_ram_7[`DT_B]}} ; 

  assign comp_res_7 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_7[`V_B],tag_ram_7[`COMP_7],tag_ram_7 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_7,tid_mask_7}); 

  assign hit[7] = comp_res_7 == 0 && start_lookup ; 


 // hit [8] logic 

  assign dsiz_mask_8 = { {8{1'b1}}, 
                 { 2{~tag_ram_8[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_8[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_8[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_8[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_8[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_8[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_8[`DSIZ_6_B]}} } ; 
  assign tid_mask_8 = {8{~tag_ram_8[`DT_B]}} ; 

  assign comp_res_8 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_8[`V_B],tag_ram_8[`COMP_7],tag_ram_8 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_8,tid_mask_8}); 

  assign hit[8] = comp_res_8 == 0 && start_lookup ; 


 // hit [9] logic 

  assign dsiz_mask_9 = { {8{1'b1}}, 
                 { 2{~tag_ram_9[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_9[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_9[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_9[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_9[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_9[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_9[`DSIZ_6_B]}} } ; 
  assign tid_mask_9 = {8{~tag_ram_9[`DT_B]}} ; 

  assign comp_res_9 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_9[`V_B],tag_ram_9[`COMP_7],tag_ram_9 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_9,tid_mask_9}); 

  assign hit[9] = comp_res_9 == 0 && start_lookup ; 


 // hit [10] logic 

  assign dsiz_mask_10 = { {8{1'b1}}, 
                 { 2{~tag_ram_10[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_10[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_10[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_10[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_10[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_10[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_10[`DSIZ_6_B]}} } ; 
  assign tid_mask_10 = {8{~tag_ram_10[`DT_B]}} ; 

  assign comp_res_10 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_10[`V_B],tag_ram_10[`COMP_7],tag_ram_10 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_10,tid_mask_10}); 

  assign hit[10] = comp_res_10 == 0 && start_lookup ; 


 // hit [11] logic 

  assign dsiz_mask_11 = { {8{1'b1}}, 
                 { 2{~tag_ram_11[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_11[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_11[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_11[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_11[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_11[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_11[`DSIZ_6_B]}} } ; 
  assign tid_mask_11 = {8{~tag_ram_11[`DT_B]}} ; 

  assign comp_res_11 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_11[`V_B],tag_ram_11[`COMP_7],tag_ram_11 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_11,tid_mask_11}); 

  assign hit[11] = comp_res_11 == 0 && start_lookup ; 


 // hit [12] logic 

  assign dsiz_mask_12 = { {8{1'b1}}, 
                 { 2{~tag_ram_12[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_12[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_12[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_12[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_12[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_12[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_12[`DSIZ_6_B]}} } ; 
  assign tid_mask_12 = {8{~tag_ram_12[`DT_B]}} ; 

  assign comp_res_12 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_12[`V_B],tag_ram_12[`COMP_7],tag_ram_12 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_12,tid_mask_12}); 

  assign hit[12] = comp_res_12 == 0 && start_lookup ; 


 // hit [13] logic 

  assign dsiz_mask_13 = { {8{1'b1}}, 
                 { 2{~tag_ram_13[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_13[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_13[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_13[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_13[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_13[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_13[`DSIZ_6_B]}} } ; 
  assign tid_mask_13 = {8{~tag_ram_13[`DT_B]}} ; 

  assign comp_res_13 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_13[`V_B],tag_ram_13[`COMP_7],tag_ram_13 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_13,tid_mask_13}); 

  assign hit[13] = comp_res_13 == 0 && start_lookup ; 


 // hit [14] logic 

  assign dsiz_mask_14 = { {8{1'b1}}, 
                 { 2{~tag_ram_14[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_14[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_14[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_14[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_14[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_14[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_14[`DSIZ_6_B]}} } ; 
  assign tid_mask_14 = {8{~tag_ram_14[`DT_B]}} ; 

  assign comp_res_14 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_14[`V_B],tag_ram_14[`COMP_7],tag_ram_14 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_14,tid_mask_14}); 

  assign hit[14] = comp_res_14 == 0 && start_lookup ; 


 // hit [15] logic 

  assign dsiz_mask_15 = { {8{1'b1}}, 
                 { 2{~tag_ram_15[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_15[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_15[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_15[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_15[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_15[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_15[`DSIZ_6_B]}} } ; 
  assign tid_mask_15 = {8{~tag_ram_15[`DT_B]}} ; 

  assign comp_res_15 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_15[`V_B],tag_ram_15[`COMP_7],tag_ram_15 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_15,tid_mask_15}); 

  assign hit[15] = comp_res_15 == 0 && start_lookup ; 


 // hit [16] logic 

  assign dsiz_mask_16 = { {8{1'b1}}, 
                 { 2{~tag_ram_16[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_16[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_16[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_16[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_16[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_16[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_16[`DSIZ_6_B]}} } ; 
  assign tid_mask_16 = {8{~tag_ram_16[`DT_B]}} ; 

  assign comp_res_16 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_16[`V_B],tag_ram_16[`COMP_7],tag_ram_16 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_16,tid_mask_16}); 

  assign hit[16] = comp_res_16 == 0 && start_lookup ; 


 // hit [17] logic 

  assign dsiz_mask_17 = { {8{1'b1}}, 
                 { 2{~tag_ram_17[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_17[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_17[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_17[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_17[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_17[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_17[`DSIZ_6_B]}} } ; 
  assign tid_mask_17 = {8{~tag_ram_17[`DT_B]}} ; 

  assign comp_res_17 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_17[`V_B],tag_ram_17[`COMP_7],tag_ram_17 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_17,tid_mask_17}); 

  assign hit[17] = comp_res_17 == 0 && start_lookup ; 


 // hit [18] logic 

  assign dsiz_mask_18 = { {8{1'b1}}, 
                 { 2{~tag_ram_18[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_18[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_18[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_18[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_18[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_18[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_18[`DSIZ_6_B]}} } ; 
  assign tid_mask_18 = {8{~tag_ram_18[`DT_B]}} ; 

  assign comp_res_18 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_18[`V_B],tag_ram_18[`COMP_7],tag_ram_18 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_18,tid_mask_18}); 

  assign hit[18] = comp_res_18 == 0 && start_lookup ; 


 // hit [19] logic 

  assign dsiz_mask_19 = { {8{1'b1}}, 
                 { 2{~tag_ram_19[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_19[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_19[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_19[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_19[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_19[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_19[`DSIZ_6_B]}} } ; 
  assign tid_mask_19 = {8{~tag_ram_19[`DT_B]}} ; 

  assign comp_res_19 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_19[`V_B],tag_ram_19[`COMP_7],tag_ram_19 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_19,tid_mask_19}); 

  assign hit[19] = comp_res_19 == 0 && start_lookup ; 


 // hit [20] logic 

  assign dsiz_mask_20 = { {8{1'b1}}, 
                 { 2{~tag_ram_20[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_20[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_20[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_20[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_20[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_20[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_20[`DSIZ_6_B]}} } ; 
  assign tid_mask_20 = {8{~tag_ram_20[`DT_B]}} ; 

  assign comp_res_20 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_20[`V_B],tag_ram_20[`COMP_7],tag_ram_20 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_20,tid_mask_20}); 

  assign hit[20] = comp_res_20 == 0 && start_lookup ; 


 // hit [21] logic 

  assign dsiz_mask_21 = { {8{1'b1}}, 
                 { 2{~tag_ram_21[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_21[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_21[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_21[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_21[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_21[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_21[`DSIZ_6_B]}} } ; 
  assign tid_mask_21 = {8{~tag_ram_21[`DT_B]}} ; 

  assign comp_res_21 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_21[`V_B],tag_ram_21[`COMP_7],tag_ram_21 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_21,tid_mask_21}); 

  assign hit[21] = comp_res_21 == 0 && start_lookup ; 


 // hit [22] logic 

  assign dsiz_mask_22 = { {8{1'b1}}, 
                 { 2{~tag_ram_22[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_22[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_22[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_22[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_22[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_22[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_22[`DSIZ_6_B]}} } ; 
  assign tid_mask_22 = {8{~tag_ram_22[`DT_B]}} ; 

  assign comp_res_22 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_22[`V_B],tag_ram_22[`COMP_7],tag_ram_22 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_22,tid_mask_22}); 

  assign hit[22] = comp_res_22 == 0 && start_lookup ; 


 // hit [23] logic 

  assign dsiz_mask_23 = { {8{1'b1}}, 
                 { 2{~tag_ram_23[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_23[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_23[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_23[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_23[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_23[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_23[`DSIZ_6_B]}} } ; 
  assign tid_mask_23 = {8{~tag_ram_23[`DT_B]}} ; 

  assign comp_res_23 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_23[`V_B],tag_ram_23[`COMP_7],tag_ram_23 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_23,tid_mask_23}); 

  assign hit[23] = comp_res_23 == 0 && start_lookup ; 


 // hit [24] logic 

  assign dsiz_mask_24 = { {8{1'b1}}, 
                 { 2{~tag_ram_24[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_24[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_24[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_24[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_24[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_24[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_24[`DSIZ_6_B]}} } ; 
  assign tid_mask_24 = {8{~tag_ram_24[`DT_B]}} ; 

  assign comp_res_24 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_24[`V_B],tag_ram_24[`COMP_7],tag_ram_24 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_24,tid_mask_24}); 

  assign hit[24] = comp_res_24 == 0 && start_lookup ; 


 // hit [25] logic 

  assign dsiz_mask_25 = { {8{1'b1}}, 
                 { 2{~tag_ram_25[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_25[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_25[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_25[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_25[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_25[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_25[`DSIZ_6_B]}} } ; 
  assign tid_mask_25 = {8{~tag_ram_25[`DT_B]}} ; 

  assign comp_res_25 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_25[`V_B],tag_ram_25[`COMP_7],tag_ram_25 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_25,tid_mask_25}); 

  assign hit[25] = comp_res_25 == 0 && start_lookup ; 


 // hit [26] logic 

  assign dsiz_mask_26 = { {8{1'b1}}, 
                 { 2{~tag_ram_26[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_26[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_26[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_26[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_26[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_26[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_26[`DSIZ_6_B]}} } ; 
  assign tid_mask_26 = {8{~tag_ram_26[`DT_B]}} ; 

  assign comp_res_26 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_26[`V_B],tag_ram_26[`COMP_7],tag_ram_26 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_26,tid_mask_26}); 

  assign hit[26] = comp_res_26 == 0 && start_lookup ; 


 // hit [27] logic 

  assign dsiz_mask_27 = { {8{1'b1}}, 
                 { 2{~tag_ram_27[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_27[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_27[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_27[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_27[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_27[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_27[`DSIZ_6_B]}} } ; 
  assign tid_mask_27 = {8{~tag_ram_27[`DT_B]}} ; 

  assign comp_res_27 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_27[`V_B],tag_ram_27[`COMP_7],tag_ram_27 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_27,tid_mask_27}); 

  assign hit[27] = comp_res_27 == 0 && start_lookup ; 


 // hit [28] logic 

  assign dsiz_mask_28 = { {8{1'b1}}, 
                 { 2{~tag_ram_28[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_28[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_28[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_28[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_28[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_28[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_28[`DSIZ_6_B]}} } ; 
  assign tid_mask_28 = {8{~tag_ram_28[`DT_B]}} ; 

  assign comp_res_28 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_28[`V_B],tag_ram_28[`COMP_7],tag_ram_28 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_28,tid_mask_28}); 

  assign hit[28] = comp_res_28 == 0 && start_lookup ; 


 // hit [29] logic 

  assign dsiz_mask_29 = { {8{1'b1}}, 
                 { 2{~tag_ram_29[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_29[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_29[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_29[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_29[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_29[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_29[`DSIZ_6_B]}} } ; 
  assign tid_mask_29 = {8{~tag_ram_29[`DT_B]}} ; 

  assign comp_res_29 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_29[`V_B],tag_ram_29[`COMP_7],tag_ram_29 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_29,tid_mask_29}); 

  assign hit[29] = comp_res_29 == 0 && start_lookup ; 


 // hit [30] logic 

  assign dsiz_mask_30 = { {8{1'b1}}, 
                 { 2{~tag_ram_30[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_30[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_30[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_30[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_30[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_30[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_30[`DSIZ_6_B]}} } ; 
  assign tid_mask_30 = {8{~tag_ram_30[`DT_B]}} ; 

  assign comp_res_30 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_30[`V_B],tag_ram_30[`COMP_7],tag_ram_30 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_30,tid_mask_30}); 

  assign hit[30] = comp_res_30 == 0 && start_lookup ; 


 // hit [31] logic 

  assign dsiz_mask_31 = { {8{1'b1}}, 
                 { 2{~tag_ram_31[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_31[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_31[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_31[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_31[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_31[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_31[`DSIZ_6_B]}} } ; 
  assign tid_mask_31 = {8{~tag_ram_31[`DT_B]}} ; 

  assign comp_res_31 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_31[`V_B],tag_ram_31[`COMP_7],tag_ram_31 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_31,tid_mask_31}); 

  assign hit[31] = comp_res_31 == 0 && start_lookup ; 


 // hit [32] logic 

  assign dsiz_mask_32 = { {8{1'b1}}, 
                 { 2{~tag_ram_32[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_32[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_32[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_32[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_32[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_32[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_32[`DSIZ_6_B]}} } ; 
  assign tid_mask_32 = {8{~tag_ram_32[`DT_B]}} ; 

  assign comp_res_32 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_32[`V_B],tag_ram_32[`COMP_7],tag_ram_32 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_32,tid_mask_32}); 

  assign hit[32] = comp_res_32 == 0 && start_lookup ; 


 // hit [33] logic 

  assign dsiz_mask_33 = { {8{1'b1}}, 
                 { 2{~tag_ram_33[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_33[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_33[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_33[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_33[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_33[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_33[`DSIZ_6_B]}} } ; 
  assign tid_mask_33 = {8{~tag_ram_33[`DT_B]}} ; 

  assign comp_res_33 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_33[`V_B],tag_ram_33[`COMP_7],tag_ram_33 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_33,tid_mask_33}); 

  assign hit[33] = comp_res_33 == 0 && start_lookup ; 


 // hit [34] logic 

  assign dsiz_mask_34 = { {8{1'b1}}, 
                 { 2{~tag_ram_34[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_34[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_34[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_34[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_34[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_34[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_34[`DSIZ_6_B]}} } ; 
  assign tid_mask_34 = {8{~tag_ram_34[`DT_B]}} ; 

  assign comp_res_34 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_34[`V_B],tag_ram_34[`COMP_7],tag_ram_34 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_34,tid_mask_34}); 

  assign hit[34] = comp_res_34 == 0 && start_lookup ; 


 // hit [35] logic 

  assign dsiz_mask_35 = { {8{1'b1}}, 
                 { 2{~tag_ram_35[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_35[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_35[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_35[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_35[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_35[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_35[`DSIZ_6_B]}} } ; 
  assign tid_mask_35 = {8{~tag_ram_35[`DT_B]}} ; 

  assign comp_res_35 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_35[`V_B],tag_ram_35[`COMP_7],tag_ram_35 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_35,tid_mask_35}); 

  assign hit[35] = comp_res_35 == 0 && start_lookup ; 


 // hit [36] logic 

  assign dsiz_mask_36 = { {8{1'b1}}, 
                 { 2{~tag_ram_36[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_36[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_36[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_36[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_36[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_36[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_36[`DSIZ_6_B]}} } ; 
  assign tid_mask_36 = {8{~tag_ram_36[`DT_B]}} ; 

  assign comp_res_36 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_36[`V_B],tag_ram_36[`COMP_7],tag_ram_36 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_36,tid_mask_36}); 

  assign hit[36] = comp_res_36 == 0 && start_lookup ; 


 // hit [37] logic 

  assign dsiz_mask_37 = { {8{1'b1}}, 
                 { 2{~tag_ram_37[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_37[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_37[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_37[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_37[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_37[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_37[`DSIZ_6_B]}} } ; 
  assign tid_mask_37 = {8{~tag_ram_37[`DT_B]}} ; 

  assign comp_res_37 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_37[`V_B],tag_ram_37[`COMP_7],tag_ram_37 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_37,tid_mask_37}); 

  assign hit[37] = comp_res_37 == 0 && start_lookup ; 


 // hit [38] logic 

  assign dsiz_mask_38 = { {8{1'b1}}, 
                 { 2{~tag_ram_38[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_38[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_38[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_38[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_38[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_38[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_38[`DSIZ_6_B]}} } ; 
  assign tid_mask_38 = {8{~tag_ram_38[`DT_B]}} ; 

  assign comp_res_38 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_38[`V_B],tag_ram_38[`COMP_7],tag_ram_38 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_38,tid_mask_38}); 

  assign hit[38] = comp_res_38 == 0 && start_lookup ; 


 // hit [39] logic 

  assign dsiz_mask_39 = { {8{1'b1}}, 
                 { 2{~tag_ram_39[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_39[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_39[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_39[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_39[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_39[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_39[`DSIZ_6_B]}} } ; 
  assign tid_mask_39 = {8{~tag_ram_39[`DT_B]}} ; 

  assign comp_res_39 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_39[`V_B],tag_ram_39[`COMP_7],tag_ram_39 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_39,tid_mask_39}); 

  assign hit[39] = comp_res_39 == 0 && start_lookup ; 


 // hit [40] logic 

  assign dsiz_mask_40 = { {8{1'b1}}, 
                 { 2{~tag_ram_40[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_40[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_40[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_40[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_40[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_40[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_40[`DSIZ_6_B]}} } ; 
  assign tid_mask_40 = {8{~tag_ram_40[`DT_B]}} ; 

  assign comp_res_40 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_40[`V_B],tag_ram_40[`COMP_7],tag_ram_40 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_40,tid_mask_40}); 

  assign hit[40] = comp_res_40 == 0 && start_lookup ; 


 // hit [41] logic 

  assign dsiz_mask_41 = { {8{1'b1}}, 
                 { 2{~tag_ram_41[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_41[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_41[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_41[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_41[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_41[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_41[`DSIZ_6_B]}} } ; 
  assign tid_mask_41 = {8{~tag_ram_41[`DT_B]}} ; 

  assign comp_res_41 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_41[`V_B],tag_ram_41[`COMP_7],tag_ram_41 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_41,tid_mask_41}); 

  assign hit[41] = comp_res_41 == 0 && start_lookup ; 


 // hit [42] logic 

  assign dsiz_mask_42 = { {8{1'b1}}, 
                 { 2{~tag_ram_42[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_42[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_42[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_42[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_42[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_42[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_42[`DSIZ_6_B]}} } ; 
  assign tid_mask_42 = {8{~tag_ram_42[`DT_B]}} ; 

  assign comp_res_42 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_42[`V_B],tag_ram_42[`COMP_7],tag_ram_42 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_42,tid_mask_42}); 

  assign hit[42] = comp_res_42 == 0 && start_lookup ; 


 // hit [43] logic 

  assign dsiz_mask_43 = { {8{1'b1}}, 
                 { 2{~tag_ram_43[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_43[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_43[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_43[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_43[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_43[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_43[`DSIZ_6_B]}} } ; 
  assign tid_mask_43 = {8{~tag_ram_43[`DT_B]}} ; 

  assign comp_res_43 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_43[`V_B],tag_ram_43[`COMP_7],tag_ram_43 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_43,tid_mask_43}); 

  assign hit[43] = comp_res_43 == 0 && start_lookup ; 


 // hit [44] logic 

  assign dsiz_mask_44 = { {8{1'b1}}, 
                 { 2{~tag_ram_44[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_44[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_44[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_44[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_44[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_44[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_44[`DSIZ_6_B]}} } ; 
  assign tid_mask_44 = {8{~tag_ram_44[`DT_B]}} ; 

  assign comp_res_44 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_44[`V_B],tag_ram_44[`COMP_7],tag_ram_44 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_44,tid_mask_44}); 

  assign hit[44] = comp_res_44 == 0 && start_lookup ; 


 // hit [45] logic 

  assign dsiz_mask_45 = { {8{1'b1}}, 
                 { 2{~tag_ram_45[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_45[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_45[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_45[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_45[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_45[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_45[`DSIZ_6_B]}} } ; 
  assign tid_mask_45 = {8{~tag_ram_45[`DT_B]}} ; 

  assign comp_res_45 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_45[`V_B],tag_ram_45[`COMP_7],tag_ram_45 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_45,tid_mask_45}); 

  assign hit[45] = comp_res_45 == 0 && start_lookup ; 


 // hit [46] logic 

  assign dsiz_mask_46 = { {8{1'b1}}, 
                 { 2{~tag_ram_46[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_46[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_46[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_46[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_46[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_46[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_46[`DSIZ_6_B]}} } ; 
  assign tid_mask_46 = {8{~tag_ram_46[`DT_B]}} ; 

  assign comp_res_46 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_46[`V_B],tag_ram_46[`COMP_7],tag_ram_46 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_46,tid_mask_46}); 

  assign hit[46] = comp_res_46 == 0 && start_lookup ; 


 // hit [47] logic 

  assign dsiz_mask_47 = { {8{1'b1}}, 
                 { 2{~tag_ram_47[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_47[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_47[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_47[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_47[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_47[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_47[`DSIZ_6_B]}} } ; 
  assign tid_mask_47 = {8{~tag_ram_47[`DT_B]}} ; 

  assign comp_res_47 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_47[`V_B],tag_ram_47[`COMP_7],tag_ram_47 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_47,tid_mask_47}); 

  assign hit[47] = comp_res_47 == 0 && start_lookup ; 


 // hit [48] logic 

  assign dsiz_mask_48 = { {8{1'b1}}, 
                 { 2{~tag_ram_48[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_48[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_48[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_48[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_48[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_48[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_48[`DSIZ_6_B]}} } ; 
  assign tid_mask_48 = {8{~tag_ram_48[`DT_B]}} ; 

  assign comp_res_48 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_48[`V_B],tag_ram_48[`COMP_7],tag_ram_48 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_48,tid_mask_48}); 

  assign hit[48] = comp_res_48 == 0 && start_lookup ; 


 // hit [49] logic 

  assign dsiz_mask_49 = { {8{1'b1}}, 
                 { 2{~tag_ram_49[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_49[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_49[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_49[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_49[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_49[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_49[`DSIZ_6_B]}} } ; 
  assign tid_mask_49 = {8{~tag_ram_49[`DT_B]}} ; 

  assign comp_res_49 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_49[`V_B],tag_ram_49[`COMP_7],tag_ram_49 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_49,tid_mask_49}); 

  assign hit[49] = comp_res_49 == 0 && start_lookup ; 


 // hit [50] logic 

  assign dsiz_mask_50 = { {8{1'b1}}, 
                 { 2{~tag_ram_50[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_50[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_50[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_50[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_50[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_50[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_50[`DSIZ_6_B]}} } ; 
  assign tid_mask_50 = {8{~tag_ram_50[`DT_B]}} ; 

  assign comp_res_50 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_50[`V_B],tag_ram_50[`COMP_7],tag_ram_50 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_50,tid_mask_50}); 

  assign hit[50] = comp_res_50 == 0 && start_lookup ; 


 // hit [51] logic 

  assign dsiz_mask_51 = { {8{1'b1}}, 
                 { 2{~tag_ram_51[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_51[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_51[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_51[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_51[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_51[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_51[`DSIZ_6_B]}} } ; 
  assign tid_mask_51 = {8{~tag_ram_51[`DT_B]}} ; 

  assign comp_res_51 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_51[`V_B],tag_ram_51[`COMP_7],tag_ram_51 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_51,tid_mask_51}); 

  assign hit[51] = comp_res_51 == 0 && start_lookup ; 


 // hit [52] logic 

  assign dsiz_mask_52 = { {8{1'b1}}, 
                 { 2{~tag_ram_52[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_52[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_52[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_52[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_52[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_52[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_52[`DSIZ_6_B]}} } ; 
  assign tid_mask_52 = {8{~tag_ram_52[`DT_B]}} ; 

  assign comp_res_52 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_52[`V_B],tag_ram_52[`COMP_7],tag_ram_52 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_52,tid_mask_52}); 

  assign hit[52] = comp_res_52 == 0 && start_lookup ; 


 // hit [53] logic 

  assign dsiz_mask_53 = { {8{1'b1}}, 
                 { 2{~tag_ram_53[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_53[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_53[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_53[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_53[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_53[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_53[`DSIZ_6_B]}} } ; 
  assign tid_mask_53 = {8{~tag_ram_53[`DT_B]}} ; 

  assign comp_res_53 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_53[`V_B],tag_ram_53[`COMP_7],tag_ram_53 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_53,tid_mask_53}); 

  assign hit[53] = comp_res_53 == 0 && start_lookup ; 


 // hit [54] logic 

  assign dsiz_mask_54 = { {8{1'b1}}, 
                 { 2{~tag_ram_54[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_54[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_54[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_54[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_54[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_54[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_54[`DSIZ_6_B]}} } ; 
  assign tid_mask_54 = {8{~tag_ram_54[`DT_B]}} ; 

  assign comp_res_54 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_54[`V_B],tag_ram_54[`COMP_7],tag_ram_54 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_54,tid_mask_54}); 

  assign hit[54] = comp_res_54 == 0 && start_lookup ; 


 // hit [55] logic 

  assign dsiz_mask_55 = { {8{1'b1}}, 
                 { 2{~tag_ram_55[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_55[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_55[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_55[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_55[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_55[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_55[`DSIZ_6_B]}} } ; 
  assign tid_mask_55 = {8{~tag_ram_55[`DT_B]}} ; 

  assign comp_res_55 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_55[`V_B],tag_ram_55[`COMP_7],tag_ram_55 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_55,tid_mask_55}); 

  assign hit[55] = comp_res_55 == 0 && start_lookup ; 


 // hit [56] logic 

  assign dsiz_mask_56 = { {8{1'b1}}, 
                 { 2{~tag_ram_56[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_56[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_56[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_56[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_56[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_56[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_56[`DSIZ_6_B]}} } ; 
  assign tid_mask_56 = {8{~tag_ram_56[`DT_B]}} ; 

  assign comp_res_56 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_56[`V_B],tag_ram_56[`COMP_7],tag_ram_56 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_56,tid_mask_56}); 

  assign hit[56] = comp_res_56 == 0 && start_lookup ; 


 // hit [57] logic 

  assign dsiz_mask_57 = { {8{1'b1}}, 
                 { 2{~tag_ram_57[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_57[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_57[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_57[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_57[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_57[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_57[`DSIZ_6_B]}} } ; 
  assign tid_mask_57 = {8{~tag_ram_57[`DT_B]}} ; 

  assign comp_res_57 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_57[`V_B],tag_ram_57[`COMP_7],tag_ram_57 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_57,tid_mask_57}); 

  assign hit[57] = comp_res_57 == 0 && start_lookup ; 


 // hit [58] logic 

  assign dsiz_mask_58 = { {8{1'b1}}, 
                 { 2{~tag_ram_58[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_58[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_58[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_58[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_58[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_58[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_58[`DSIZ_6_B]}} } ; 
  assign tid_mask_58 = {8{~tag_ram_58[`DT_B]}} ; 

  assign comp_res_58 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_58[`V_B],tag_ram_58[`COMP_7],tag_ram_58 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_58,tid_mask_58}); 

  assign hit[58] = comp_res_58 == 0 && start_lookup ; 


 // hit [59] logic 

  assign dsiz_mask_59 = { {8{1'b1}}, 
                 { 2{~tag_ram_59[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_59[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_59[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_59[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_59[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_59[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_59[`DSIZ_6_B]}} } ; 
  assign tid_mask_59 = {8{~tag_ram_59[`DT_B]}} ; 

  assign comp_res_59 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_59[`V_B],tag_ram_59[`COMP_7],tag_ram_59 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_59,tid_mask_59}); 

  assign hit[59] = comp_res_59 == 0 && start_lookup ; 


 // hit [60] logic 

  assign dsiz_mask_60 = { {8{1'b1}}, 
                 { 2{~tag_ram_60[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_60[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_60[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_60[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_60[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_60[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_60[`DSIZ_6_B]}} } ; 
  assign tid_mask_60 = {8{~tag_ram_60[`DT_B]}} ; 

  assign comp_res_60 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_60[`V_B],tag_ram_60[`COMP_7],tag_ram_60 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_60,tid_mask_60}); 

  assign hit[60] = comp_res_60 == 0 && start_lookup ; 


 // hit [61] logic 

  assign dsiz_mask_61 = { {8{1'b1}}, 
                 { 2{~tag_ram_61[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_61[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_61[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_61[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_61[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_61[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_61[`DSIZ_6_B]}} } ; 
  assign tid_mask_61 = {8{~tag_ram_61[`DT_B]}} ; 

  assign comp_res_61 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_61[`V_B],tag_ram_61[`COMP_7],tag_ram_61 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_61,tid_mask_61}); 

  assign hit[61] = comp_res_61 == 0 && start_lookup ; 


 // hit [62] logic 

  assign dsiz_mask_62 = { {8{1'b1}}, 
                 { 2{~tag_ram_62[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_62[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_62[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_62[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_62[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_62[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_62[`DSIZ_6_B]}} } ; 
  assign tid_mask_62 = {8{~tag_ram_62[`DT_B]}} ; 

  assign comp_res_62 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_62[`V_B],tag_ram_62[`COMP_7],tag_ram_62 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_62,tid_mask_62}); 

  assign hit[62] = comp_res_62 == 0 && start_lookup ; 


 // hit [63] logic 

  assign dsiz_mask_63 = { {8{1'b1}}, 
                 { 2{~tag_ram_63[`DSIZ_0_B]}}, 
                 { 2{~tag_ram_63[`DSIZ_1_B]}}, 
                 { 2{~tag_ram_63[`DSIZ_2_B]}}, 
                 { 2{~tag_ram_63[`DSIZ_3_B]}}, 
                 { 2{~tag_ram_63[`DSIZ_4_B]}}, 
                 { 2{~tag_ram_63[`DSIZ_5_B]}} , 
                 { 2{~tag_ram_63[`DSIZ_6_B]}} } ; 
  assign tid_mask_63 = {8{~tag_ram_63[`DT_B]}} ; 

  assign comp_res_63 = 
      ({1'b1,DI_CI[`COMP_7],TID} ^ 
      {tag_ram_63[`V_B],tag_ram_63[`COMP_7],tag_ram_63 [`TID_B] }) & 
 
              ({1'b1,dsiz_mask_63,tid_mask_63}); 

  assign hit[63] = comp_res_63 == 0 && start_lookup ; 


  always @ (hit [0:63]) begin
    single_hit = 0;
    more_hit = 0;
    matchIndex = 6'b000000;
    index_int = 6'b000000;
    for (i=0;i<64;i=i+1) begin
      if (hit[i]   ) begin 
        if (!single_hit ) begin
          single_hit = 1'b1;
          index_int = i;
          matchIndex = i;
        end
        else 
          more_hit = 1'b1; 
      end
    end
  end

  // MISS generations

   always @ (posedge SYS_CLK or negedge reset )
     if (!reset) begin
       MISS <= 1'b0;
     end
     else begin
       if ((!single_hit || more_hit) && start_lookup ) begin
         MISS <= 1'b1;
       end
       else begin
         if (start_lookup) 
           MISS <= 1'b0;
       end
     end

  //
  // Data Ram'0     
  //

  // Read/write control logic

  always @ (EN_C1 or EN_ARRAYL1 or INDEX_LOOKUPB or
    DATA_EN or  RD_WRB or start_lookup ) begin
     dram_en = 1;
     dram_wr_en = 1;
    if ( EN_C1 && EN_ARRAYL1 && INDEX_LOOKUPB &&
         DATA_EN) begin
      dram_en = 0;
      dram_wr_en = RD_WRB;
    end
    else if (start_lookup) begin
      dram_en = 0;
      dram_wr_en = 1'b1;
    end
  end
  // Address generations

  assign dram_index  = (INDEX_LOOKUPB ) ? {INDEX,2'b00} :
         {index_int,2'b00};


  // Ram data 
  // for the input to Ram , I am using the registered version of the inputs
  // signals. These inputs are registered at the positve edge. 

  assign  dram_in [0:33] = {DI[0:21],EX,WR,ZSEL[0:3],
         DI_W,DI_I,DI_M,DI_G,DI_PD[0:1]};
 


  //
  wire read;
  assign read = (EN_C1 & EN_ARRAYL1 & INDEX_LOOKUPB & DATA_EN & RD_WRB) ||
                (single_hit & ~more_hit);

`ifdef USER_SPECIFIC_RAM

  // User specific RAM is instantiated here
  // Users must edit the wrapper file below
  // to add their own technology specific RAMS.
  // The wrapper is located in <workspace>/src/mem_models

  p405s_dataram_64X34_wrapper ramfile_0 (
   .QA (dram_out),
   .CLKA (SYS_CLK),
   .CLKB (SYS_CLK),
   .CENA ( ~read),
   .CENB ( dram_wr_en),
   .AA (dram_index[0:5]),
   .AB (dram_index[0:5]),
   .DB (dram_in));
`else

  // Artisan Specific RAM
  dataram_64X34 ramfile_0 (
   .QA (dram_out),
   .CLKA (SYS_CLK),
   .CLKB (SYS_CLK),
   .CENA ( ~read),
   .CENB ( dram_wr_en),
   .AA (dram_index[0:5]),
   .AB (dram_index[0:5]),
   .DB (dram_in));

`endif

endmodule
