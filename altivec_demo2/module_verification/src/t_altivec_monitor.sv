//===============================================================================
//  File Name       : t_altivec_monitor.sv
//  File Revision   : 1.0
//  Date            : 2015/4/14
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//	History         : 
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform
//  Function        : get the hardware result from altivec_dut and pack the result
//						        into a altivec_c class
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

class altivec_monitor;
  mailbox #(altivec_c) fifo;
  function altivec_c pins2transaction;
    altivec_c transaction = new;
    transaction.vra       = top_class_based.vra;
    transaction.vrb       = top_class_based.vrb;
    transaction.ins       = top_class_based.ins;
    transaction.rc        = top_class_based.rc;
    transaction.str_ins   = top_class_based.str_ins;
    transaction.vrt       = top_class_based.vrt;
    // $display("transaction.vrt: %h", transaction.vrt);
    return transaction;
  endfunction

  task run;
    forever @ (negedge top_class_based.dut_busy)
    begin
      #1;//consume time
      fifo.put(pins2transaction());//place a message in a mailbox
      //if there are not enough places to put the message in a bounded mailbox, 
      //the call will block (i.e. wait until a place is available). 
    end
  endtask
endclass
