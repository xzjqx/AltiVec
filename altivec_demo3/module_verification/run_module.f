//===============================================================================
//  File Name       : run.f
//  File Revision   : 1.0
//  Date            : 2015/5/22
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     :   fuctional simulation platform             
//  Function        :   run file of the verification platform
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

./src/t_altivec_env_pkg.sv
./src/t_altivec_dut.sv
./src/t_altivec_sva.sv
./src/t_top_class_based.sv
./Define.v

../src/altivec_design/vsfx/vsfx_top.v
