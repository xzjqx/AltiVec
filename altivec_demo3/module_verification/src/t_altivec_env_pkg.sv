//===============================================================================
//  File Name       : t_altivec_env_pkg.sv
//  File Revision   : 2.0
//  Date            : 2015/5/19
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform, rc bit is not used
//  Function        : fuctional varification library for VSFX only
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

package t_altivec_env_pkg;

`include "./src/t_altivec_import.sv" //interface with C, "import" the C routine with the import statement
`include "./Define.v"

//===============================================================================
//  class altivec_c
//===============================================================================

  class altivec_c;//pack the value needed in one varification
    rand bit [127:0] vra;      //input operand
    rand bit [127:0] vrb;      //input operand
         bit [127:0] vrt;      //result
    rand bit [  7:0] ins;      //vsfx instructions
    rand bit rc;               //control signal used in compare instructions
    string   str_ins;          //the name of the corresponding ins
    constraint c_ins {ins inside {`INS_1, `INS_2, `INS_3, `INS_4, `INS_5};}//there are 70 instructions in vsfx...
  endclass

//===============================================================================
//  function report, report the stimulus information
//===============================================================================

  function void report(altivec_c t1);//every instrucion under simulation will be reported
    string str;
    if (t1.ins inside {[41:53]})//compare instructions
      $sformat(str, "-> vra = %h, vrb = %h, ins = %d(%s, rc = %b)",
              t1.vra, t1.vrb, t1.ins, t1.str_ins, t1.rc);
    else
      $sformat(str, "-> vra = %h, vrb = %h, ins = %d(%s)",
              t1.vra, t1.vrb, t1.ins, t1.str_ins);
    $display("%s", str);
  endfunction

//===============================================================================
//  class stimulus_generator, 2 methods:
//  1. task generate_stimulus;
//  2. task stop_stimulus_generation();
//===============================================================================

  class stimulus_generator;
    mailbox #(altivec_c) fifo;//mailboxes are facilities where processes can communicate directly with one another.
    //  Mailboxes operate in the same manner as a real mailbox. A process may submit a letter (which, in this case, will 
    //  contain a data message) for another process in a mailbox. The message stays in the mailbox until the receiving 
    //  process comes and retrieves it. If the receiving process checks the mailbox before the sending process deposits 
    //  the message in the mailbox, the receiving process goes back empty handed.
    bit stop = 0;
    task generate_stimulus;
      altivec_c tmp;
      forever
      begin
        if (stop == 1)//stop generating stimulus when stop == 1
          break;
        else if (stop == 0)
        begin
          tmp = new();
          tmp.randomize();
          // $display("time:%0d generator%0d send out a stimulous, vra: %0h,vrb:%0h,vrc:%0h, ins:%d",
                  // $time, id, tmp.vra, tmp.vrb, tmp.vrc, tmp.ins);
          //instructions from vsfx
          case (tmp.ins)//generate name of instructions
              1:$sformat(tmp.str_ins, "vaddcuw   ");
              2:$sformat(tmp.str_ins, "vaddsbs   ");
              3:$sformat(tmp.str_ins, "vaddshs   ");
              4:$sformat(tmp.str_ins, "vaddsws   ");
              5:$sformat(tmp.str_ins, "vaddubm   ");
              6:$sformat(tmp.str_ins, "vadduhm   ");
              7:$sformat(tmp.str_ins, "vadduwm   ");
              8:$sformat(tmp.str_ins, "vaddubs   ");
              9:$sformat(tmp.str_ins, "vadduhs   ");
             10:$sformat(tmp.str_ins, "vadduws   ");
             11:$sformat(tmp.str_ins, "vsubcuw   ");
             12:$sformat(tmp.str_ins, "vsubsbs   ");
             13:$sformat(tmp.str_ins, "vsubshs   ");
             14:$sformat(tmp.str_ins, "vsubsws   ");
             15:$sformat(tmp.str_ins, "vsububm   ");
             16:$sformat(tmp.str_ins, "vsubuhm   ");
             17:$sformat(tmp.str_ins, "vsubuwm   ");
             18:$sformat(tmp.str_ins, "vsububs   ");
             19:$sformat(tmp.str_ins, "vsubuhs   ");
             20:$sformat(tmp.str_ins, "vsubuws   ");
             21:$sformat(tmp.str_ins, "vavgsb    ");
             22:$sformat(tmp.str_ins, "vavgsh    ");
             23:$sformat(tmp.str_ins, "vavgsw    ");
             24:$sformat(tmp.str_ins, "vavgub    ");
             25:$sformat(tmp.str_ins, "vavguh    ");
             26:$sformat(tmp.str_ins, "vavguw    ");
             27:$sformat(tmp.str_ins, "vmaxsb    ");
             28:$sformat(tmp.str_ins, "vmaxsh    ");
             29:$sformat(tmp.str_ins, "vmaxsw    ");
             30:$sformat(tmp.str_ins, "vmaxub    ");
             31:$sformat(tmp.str_ins, "vmaxuh    ");
             32:$sformat(tmp.str_ins, "vmaxuw    ");
             33:$sformat(tmp.str_ins, "vminsb    ");
             34:$sformat(tmp.str_ins, "vminsh    ");
             35:$sformat(tmp.str_ins, "vminsw    ");
             36:$sformat(tmp.str_ins, "vminub    ");
             37:$sformat(tmp.str_ins, "vminuh    ");
             38:$sformat(tmp.str_ins, "vminuw    ");
             39:$sformat(tmp.str_ins, "vmaxfp    ");
             40:$sformat(tmp.str_ins, "vminfp    ");
             41:$sformat(tmp.str_ins, "vcmpequb  ");
             42:$sformat(tmp.str_ins, "vcmpequh  ");
             43:$sformat(tmp.str_ins, "vcmpequw  ");
             44:$sformat(tmp.str_ins, "vcmpeqfp  ");
             45:$sformat(tmp.str_ins, "vcmpgtsb  ");
             46:$sformat(tmp.str_ins, "vcmpgtsh  ");
             47:$sformat(tmp.str_ins, "vcmpgtsw  ");
             48:$sformat(tmp.str_ins, "vcmpbfp   ");
             49:$sformat(tmp.str_ins, "vcmpgtub  ");
             50:$sformat(tmp.str_ins, "vcmpgtuh  ");
             51:$sformat(tmp.str_ins, "vcmpgtuw  ");
             52:$sformat(tmp.str_ins, "vcmpgtfp  ");
             53:$sformat(tmp.str_ins, "vcmpgefp  ");
             54:$sformat(tmp.str_ins, "vand      ");
             55:$sformat(tmp.str_ins, "vandc     ");
             56:$sformat(tmp.str_ins, "vnor      ");
             57:$sformat(tmp.str_ins, "vor       ");
             58:$sformat(tmp.str_ins, "vxor      ");
             59:$sformat(tmp.str_ins, "vrlb      ");
             60:$sformat(tmp.str_ins, "vrlh      ");
             61:$sformat(tmp.str_ins, "vrlw      ");
             62:$sformat(tmp.str_ins, "vslb      ");
             63:$sformat(tmp.str_ins, "vslh      ");
             64:$sformat(tmp.str_ins, "vslw      ");
             65:$sformat(tmp.str_ins, "vsrb      ");
             66:$sformat(tmp.str_ins, "vsrh      ");
             67:$sformat(tmp.str_ins, "vsrw      ");
             68:$sformat(tmp.str_ins, "vsrab     ");
             69:$sformat(tmp.str_ins, "vsrah     ");
             70:$sformat(tmp.str_ins, "vsraw     ");
          endcase
          fifo.put(tmp);
        end//if (stop == 0)
      end//forever
    endtask//generate_stimulus
    task stop_stimulus_generation();
      stop = 1;
    endtask
  endclass//stimulus_generator

//===============================================================================
//  class altivec_scoreboard, 3 methods
//  1. function new (mailbox #(altivec_c) fifo_i);
//  2. task run;
//  3. local function void update_and_check_score(input int count);
//===============================================================================

  class altivec_scoreboard;
    altivec_c t1;
    mailbox #(altivec_c) fifo;
    bit test_done; //if test_done = 1, stop varification
    int limit = 50;//default value = 50, if count >= limit, test_done = 1
    int mismatch_counter = 0;
    function new (mailbox #(altivec_c) fifo_i);
      fifo = fifo_i;
      test_done = 0;
    endfunction

    task run;
      int count = 0;//number of verifications
      forever
      begin
        fifo.get(t1);
        report(t1);
        count = count + 1;
        update_and_check_score(count);
      end
    endtask

    local function void update_and_check_score(input int count);
      bit [127:0] vrt;
      string str;
      case (t1.ins)//generate the software result, using c functions imported in "DPI-C"
       //instructions from vsfx
        1:do_vec_vaddcuw   (vrt, t1.vra, t1.vrb);
        2:do_vec_vaddsbs   (vrt, t1.vra, t1.vrb);
        3:do_vec_vaddshs   (vrt, t1.vra, t1.vrb);
        4:do_vec_vaddsws   (vrt, t1.vra, t1.vrb);
        5:do_vec_vaddubm   (vrt, t1.vra, t1.vrb);
        6:do_vec_vadduhm   (vrt, t1.vra, t1.vrb);
        7:do_vec_vadduwm   (vrt, t1.vra, t1.vrb);
        8:do_vec_vaddubs   (vrt, t1.vra, t1.vrb);
        9:do_vec_vadduhs   (vrt, t1.vra, t1.vrb);
       10:do_vec_vadduws   (vrt, t1.vra, t1.vrb);
       11:do_vec_vsubcuw   (vrt, t1.vra, t1.vrb);
       12:do_vec_vsubsbs   (vrt, t1.vra, t1.vrb);
       13:do_vec_vsubshs   (vrt, t1.vra, t1.vrb);
       14:do_vec_vsubsws   (vrt, t1.vra, t1.vrb);
       15:do_vec_vsububm   (vrt, t1.vra, t1.vrb);
       16:do_vec_vsubuhm   (vrt, t1.vra, t1.vrb);
       17:do_vec_vsubuwm   (vrt, t1.vra, t1.vrb);
       18:do_vec_vsububs   (vrt, t1.vra, t1.vrb);
       19:do_vec_vsubuhs   (vrt, t1.vra, t1.vrb);
       20:do_vec_vsubuws   (vrt, t1.vra, t1.vrb);
       21:do_vec_vavgsb    (vrt, t1.vra, t1.vrb);
       22:do_vec_vavgsh    (vrt, t1.vra, t1.vrb);
       23:do_vec_vavgsw    (vrt, t1.vra, t1.vrb);
       24:do_vec_vavgub    (vrt, t1.vra, t1.vrb);
       25:do_vec_vavguh    (vrt, t1.vra, t1.vrb);
       26:do_vec_vavguw    (vrt, t1.vra, t1.vrb);
       27:do_vec_vmaxsb    (vrt, t1.vra, t1.vrb);
       28:do_vec_vmaxsh    (vrt, t1.vra, t1.vrb);
       29:do_vec_vmaxsw    (vrt, t1.vra, t1.vrb);
       30:do_vec_vmaxub    (vrt, t1.vra, t1.vrb);
       31:do_vec_vmaxuh    (vrt, t1.vra, t1.vrb);
       32:do_vec_vmaxuw    (vrt, t1.vra, t1.vrb);
       33:do_vec_vminsb    (vrt, t1.vra, t1.vrb);
       34:do_vec_vminsh    (vrt, t1.vra, t1.vrb);
       35:do_vec_vminsw    (vrt, t1.vra, t1.vrb);
       36:do_vec_vminub    (vrt, t1.vra, t1.vrb);
       37:do_vec_vminuh    (vrt, t1.vra, t1.vrb);
       38:do_vec_vminuw    (vrt, t1.vra, t1.vrb);
       // 39:do_vec_vmaxfp    (vrt, t1.vra, t1.vrb);
       // 40:do_vec_vminfp    (vrt, t1.vra, t1.vrb);
       41:do_vec_vcmpequb  (vrt, t1.vra, t1.vrb, t1.rc);
       42:do_vec_vcmpequh  (vrt, t1.vra, t1.vrb, t1.rc);
       43:do_vec_vcmpequw  (vrt, t1.vra, t1.vrb, t1.rc);
       // 44:do_vec_vcmpeqfp  (vrt, t1.vra, t1.vrb, t1.rc);
       45:do_vec_vcmpgtsb  (vrt, t1.vra, t1.vrb, t1.rc);
       46:do_vec_vcmpgtsh  (vrt, t1.vra, t1.vrb, t1.rc);
       47:do_vec_vcmpgtsw  (vrt, t1.vra, t1.vrb, t1.rc);
       // 48:do_vec_vcmpbfp   (vrt, t1.vra, t1.vrb, t1.rc);
       49:do_vec_vcmpgtub  (vrt, t1.vra, t1.vrb, t1.rc);
       50:do_vec_vcmpgtuh  (vrt, t1.vra, t1.vrb, t1.rc);
       51:do_vec_vcmpgtuw  (vrt, t1.vra, t1.vrb, t1.rc);
       // 52:do_vec_vcmpgtfp  (vrt, t1.vra, t1.vrb, t1.rc);
       // 53:do_vec_vcmpgefp  (vrt, t1.vra, t1.vrb, t1.rc);
       54:do_vec_vand      (vrt, t1.vra, t1.vrb);
       55:do_vec_vandc     (vrt, t1.vra, t1.vrb);
       56:do_vec_vnor      (vrt, t1.vra, t1.vrb);
       57:do_vec_vor       (vrt, t1.vra, t1.vrb);
       58:do_vec_vxor      (vrt, t1.vra, t1.vrb);
       59:do_vec_vrlb      (vrt, t1.vra, t1.vrb);
       60:do_vec_vrlh      (vrt, t1.vra, t1.vrb);
       61:do_vec_vrlw      (vrt, t1.vra, t1.vrb);
       62:do_vec_vslb      (vrt, t1.vra, t1.vrb);
       63:do_vec_vslh      (vrt, t1.vra, t1.vrb);
       64:do_vec_vslw      (vrt, t1.vra, t1.vrb);
       65:do_vec_vsrb      (vrt, t1.vra, t1.vrb);
       66:do_vec_vsrh      (vrt, t1.vra, t1.vrb);
       67:do_vec_vsrw      (vrt, t1.vra, t1.vrb);
       68:do_vec_vsrab     (vrt, t1.vra, t1.vrb);
       69:do_vec_vsrah     (vrt, t1.vra, t1.vrb);
       70:do_vec_vsraw     (vrt, t1.vra, t1.vrb);
      default:
          $display("call from default case, t1.ins = %0d", t1.ins);
      endcase
      if (vrt != t1.vrt)//the software result is not equal to the hardware result
      begin
        mismatch_counter = mismatch_counter + 1;
        $sformat(str, "------------Ins %0d (%s) MISMATCH!------------
                 vra = %h_%h_%h_%h
                 vrb = %h_%h_%h_%h
software result: vrt = %h_%h_%h_%h
hardware result: vrt = %h_%h_%h_%h",
                t1.ins, t1.str_ins, t1.vra[127:96],  t1.vra[ 95: 64],  t1.vra[ 63: 32],  t1.vra[ 31:  0],
                                    t1.vrb[127:96],  t1.vrb[ 95: 64],  t1.vrb[ 63: 32],  t1.vrb[ 31:  0],
                                       vrt[127:96],     vrt[ 95: 64],     vrt[ 63: 32],     vrt[ 31:  0],
                                    t1.vrt[127:96],  t1.vrt[ 95: 64],  t1.vrt[ 63: 32],  t1.vrt[ 31:  0]);
        $display("%d\n SBD %s",count, str);
      end
      //hardware and software comparison complete once
      if (count >= limit)
      begin
        if (mismatch_counter == 0)//no mismatch found
        begin
          $display("                                                ");
          $display(" PPPPP     AA     SSSS    SSSS   EEEEEE  DDDDD  ");
          $display(" P    P   A  A   S       S       E       D    D ");
          $display(" P    P  A    A   SSSS    SSSS   EEEEE   D    D ");
          $display(" PPPPP   AAAAAA       S       S  E       D    D ");
          $display(" P       A    A  S    S  S    S  E       D    D ");
          $display(" P       A    A   SSSS    SSSS   EEEEEE  DDDDD  ");
          $display("                                                ");
        end
        else
        begin
          $display("                                                ");
          $display(" FFFFFF    AA    IIIIII  L       EEEEEE  DDDDD  ");
          $display(" F        A  A     I     L       E       D    D ");
          $display(" F       A    A    I     L       EEEEE   D    D ");
          $display(" FFFFFF  AAAAAA    I     L       E       D    D ");
          $display(" F       A    A    I     L       E       D    D ");
          $display(" F       A    A  IIIIII  LLLLLL  EEEEEE  DDDDD  ");
          $display("                                                ");
          $display("Error, %0d mismatch found", mismatch_counter);
        end
        test_done = 1;
      end
      endfunction//update_and_check_score
  endclass//altivec_scoreboard

endpackage
