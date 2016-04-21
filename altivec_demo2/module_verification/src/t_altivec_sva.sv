//===============================================================================
//  File Name       : t_altivec_sva.sv
//  File Revision   : 2.0
//  Date            : Fri May 22 22:01:07 CST 2015
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : SystemVerilog assertion
//  Function        : check vrt_en signal
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module altivec_sva(input clk, vsfx_vra_en, vsfx_vrb_en, vsfx_ins_en, vsfx_vrt_en);

  property vrt_en;
    @ ( posedge clk ) (vsfx_vra_en && vsfx_vrb_en && vsfx_ins_en) |=> vsfx_vrt_en;
  endproperty

  check_vrt_en : assert property(vrt_en)
  else
  begin
    $error("Assertion error, vrt_en signal not generated correctly!");
  end

endmodule

