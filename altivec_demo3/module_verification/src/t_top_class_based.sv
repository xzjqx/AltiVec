//===============================================================================
//  File Name       : t_top_class_based.sv
//  File Revision   : 1.0
//  Date            : Thu May 21 16:15:19 CST 2015
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform
//  Function        : top module for the varification platform,
//                    instantiate altivec_clock_reset, altivec_dut and altivec_env
//                    import verification library, include driver and monitor
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module top_class_based;
  import t_altivec_env_pkg::*;
  `include "./src/t_altivec_driver.sv"
  `include "./src/t_altivec_monitor.sv"
  `include "./src/t_altivec_env.sv"
  `include "./src/t_altivec_clock_reset.sv"

  bit[127:0] vra;
  bit[127:0] vrb;
  bit[  7:0] ins;
  bit vra_en, vrb_en, ins_en;
  bit clk, rst;
  bit rc;
  string str_ins;

  bit dut_busy;
  bit vrt_en;
  bit[127:0] vrt;

  //instantiate altivec_clock_reset
  altivec_clock_reset cr(.clk,
                         .rst
                         );

  //instantiate altivec_dut
  altivec_dut dut(.vra,
                  .vrb,
                  .ins,
                  .vra_en,
                  .vrb_en,
                  .ins_en,
                  .clk,
                  .rst,
                  .rc,

                  .dut_busy,
                  .vrt_en,
                  .vrt
                  );

  //instantiate altivec_env
  altivec_env env;
  
  bind altivec_dut altivec_sva sva_interface(.clk, .vsfx_vra_en(vra_en), .vsfx_vrb_en(vrb_en), .vsfx_ins_en(ins_en), .vsfx_vrt_en(vrt_en));

  initial
  begin
    env = new();
    fork
      cr.run();
    join_none//The parent process continues to execute concurrently with all the processes spawned by the fork.
    //The spawned processes do not start executing until the parent thread executes a blocking statement.
    env.execute();
    $stop;
  end
endmodule
