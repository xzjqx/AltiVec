//===============================================================================
//  File Name       : t_altivec_clock_reset.sv
//  File Revision   : 1.0
//  Date            : 2014/9/22
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//	History         : 
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform				　　　　 
//  Function        : generate clk and rst signal for dut
//  ----------------------------------------------------------------------------
// Copyright (c) 2014,Tianjin University.
//　　　　　　　 No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module altivec_clock_reset(output bit clk, rst);
  parameter bit ACTIVE_RESET = 1;
  task run(int reset_hold = 4, int half_period = 10, int count = 0);
    clk = 0;
    rst = ACTIVE_RESET;
    for (int rst_i = 0; rst_i < reset_hold; rst_i++)
    begin
      #half_period; clk =! clk;
      #half_period; clk =! clk;
    end
    rst <= ~ rst;
	#3 rst <= ~ rst;
    //Run the clock
    for (int clk_i = 0; (clk_i < count || count == 0); clk_i++)
    begin
      #half_period; clk =! clk;
    end
  endtask
endmodule
