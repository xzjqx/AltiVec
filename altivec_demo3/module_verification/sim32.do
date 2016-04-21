#===============================================================================
#  File Name        : sim32.do
#  File Revision    : 1.0
#  Date             : 2015/5/14
#  Author           : wangjie
#  Email            : ycyquick@foxmail.com
#  ----------------------------------------------------------------------------
#  Description      : fuctional simulation platform				     
#  Function         : autorun script
#  ----------------------------------------------------------------------------
# Copyright (c) 2015,Tianjin University.
#               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
# Tianjin University Confidential Proprietary
# ==============================================================================

#===============================================================================

vlib work
vlog -incr -f run_module.f
vlog -incr -f run_module.f
vsim -c -sv_lib altivec32 top_class_based -novopt -wlfdeleteonquit
add wave -r /*
run -all
#quit -f
