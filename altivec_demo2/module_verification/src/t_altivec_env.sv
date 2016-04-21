//===============================================================================
//  File Name       : t_altivec_env.sv
//  File Revision   : 1.0
//  Date            : 2015/4/14
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//	History         :
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform				　　　　
//  Function        : task execute
//						        task terminate
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//　　　　　　　 No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

`include	"./Define.v"

class altivec_env;
  stimulus_generator sg;
  altivec_driver  d1;
  altivec_monitor m1;
  altivec_scoreboard sb;
  mailbox #(altivec_c) m_sg2driver; //a communication channel between stimulus generator and driver
  mailbox #(altivec_c) m_monitor2sb;//a communication channel between monitor and scoreboard

  function new();
    m_sg2driver  = new (2);//the depth of the mailbox is 2
    m_monitor2sb = new;//a mailbox can be bounded, meaning it can hold only a pre-specified maximum number of messages. 
                       //Or, it can be unbounded, when it will hold all the messages that it receives.
    sg           = new;
    d1           = new;
    m1           = new;
    sg.fifo      = m_sg2driver;
    d1.fifo      = m_sg2driver;
    sb           = new (m_monitor2sb);
    sb.limit     = `LIMIT;
    m1.fifo      = m_monitor2sb;
  endfunction

  task execute;
    fork
      sg.generate_stimulus();
      d1.run();
      m1.run();
      sb.run();
      terminate;
    join_any//The parent process blocks until any one of the processes spawned by this fork completes.
  endtask

  task terminate;
    begin
      @ (posedge sb.test_done)
      sg.stop_stimulus_generation();
      $display("Test finished!");
    end
  endtask

endclass
