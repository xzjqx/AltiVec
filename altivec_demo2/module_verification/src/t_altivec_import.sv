//===============================================================================
//  File Name       : t_altivec_import.sv
//  File Revision   : 1.0
//  Date            : 2015/5/19
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : fuctional simulation platform, to students
//  Function        : interface with C, "import" the C routine with the
//                    import statement
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

  //instructions from vsfx
  import "DPI-C" function void do_vec_vaddcuw    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vaddsbs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vaddshs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vaddsws    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vaddubm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vaddubs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vadduhm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vadduhs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vadduwm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vadduws    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubcuw    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubsbs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubshs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubsws    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsububm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsububs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubuhm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubuhs    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubuwm    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsubuws    (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavgsb     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavgsh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavgsw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavgub     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavguh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vavguw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxsb     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxsh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxsw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxub     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxuh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vmaxuw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminsb     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminsh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminsw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminub     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminuh     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vminuw     (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vcmpequb   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpequh   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpequw   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtsb   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtsh   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtsw   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtub   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtuh   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vcmpgtuw   (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb,
                                                   input bit rc);
  import "DPI-C" function void do_vec_vand       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vandc      (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vnor       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vor        (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vxor       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vrlb       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vrlh       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vrlw       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vslb       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vslh       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vslw       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsrab      (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsrah      (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsraw      (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsrb       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsrh       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);
  import "DPI-C" function void do_vec_vsrw       (output bit[127:0]vrt,
                                                   input bit[127:0]vra, vrb);