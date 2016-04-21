library verilog;
use verilog.vl_types.all;
entity p405s_DCU_fillBufBypass is
    port(
        bypassMuxOut    : out    vl_logic_vector(0 to 31);
        SDQ_mux         : in     vl_logic_vector(0 to 31);
        bypassFillSDP_sel: in     vl_logic_vector(0 to 3);
        bypassMuxSel    : in     vl_logic_vector(0 to 2);
        fillBufWord0_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord1_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord2_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord3_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord4_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord5_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord6_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord7_L2 : in     vl_logic_vector(0 to 31)
    );
end p405s_DCU_fillBufBypass;
