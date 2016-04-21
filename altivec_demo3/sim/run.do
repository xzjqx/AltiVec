#===============================================================================
#  File Name        : run.do
#  File Revision    : 1.0
#  Date             : 2015/4/14
#  Author           : wangjie
#  Email            : ycyquick@foxmail.com
#  ----------------------------------------------------------------------------
#  Description      : top level simulation platform				     
#  Function         : autorun script
#  ----------------------------------------------------------------------------
# Copyright (c) 2015,Tianjin University.
#               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
# Tianjin University Confidential Proprietary
# ==============================================================================

#===============================================================================

vlib work
vlog -incr -f run_top.f
vsim -novopt -quiet work.p405s_test_top
add wave -r /*
run 5us
#quit -sim
echo "Test finished"