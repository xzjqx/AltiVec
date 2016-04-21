//===============================================================================
//  File Name       : t_altivec_driver.sv
//  File Revision   : 1.0
//  Date            : 2015/4/14
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform
//  Function        : get the stimulus, generate the corresponding control signal
//						        and pass them to altivec_dut 
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

class altivec_driver;
  mailbox #(altivec_c) fifo;
  altivec_c transaction;
  task run;
    top_class_based.vra     = 0;
    top_class_based.vrb     = 0;
    top_class_based.ins     = 0;
    top_class_based.rc      = 0;
    top_class_based.str_ins = "";
    top_class_based.vra_en  = 0;
    top_class_based.vrb_en  = 0;
    top_class_based.ins_en  = 0;
    @ (negedge top_class_based.rst);
    forever @ (posedge top_class_based.clk)
      if (fifo.try_get(transaction))//retrieves a stimulus and it is non-blocking
      //if a stimulus is available, it will retrieve the stimulus (and will return 1). 
      //If a stimulus is not available, it will return 0 and, 
      //if a stimulus of wrong type is available (indicating a possible programming error), it will return -1
      begin
        top_class_based.vra     = 0;
        top_class_based.vrb     = 0;
        top_class_based.ins     = 0;
        top_class_based.rc      = 0;
        top_class_based.str_ins = "";
        // $display("driver%0d get a stimulus: vr: %0h, ins: %0d",
                // id, transaction.vr, transaction.ins);
        top_class_based.vra      = transaction.vra;
        top_class_based.vrb      = transaction.vrb;
        top_class_based.ins      = transaction.ins;
        top_class_based.rc       = transaction.rc;
        top_class_based.str_ins  = transaction.str_ins;
        top_class_based.vra_en   = 1;
        top_class_based.vrb_en   = 1;
        top_class_based.ins_en   = 1;
        @ (posedge top_class_based.clk);
        top_class_based.vra_en   = 0;
        top_class_based.vrb_en   = 0;
        top_class_based.ins_en   = 0;
      end//if
  endtask
endclass
