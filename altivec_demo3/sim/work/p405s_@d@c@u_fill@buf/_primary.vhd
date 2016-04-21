library verilog;
use verilog.vl_types.all;
entity p405s_DCU_fillBuf is
    port(
        fillBufWord0_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord1_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord2_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord3_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord4_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord5_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord6_L2 : out    vl_logic_vector(0 to 31);
        fillBufWord7_L2 : out    vl_logic_vector(0 to 31);
        p_fillBuf_L2    : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        PLB_dcuReadDataBus: in     vl_logic_vector(0 to 63);
        SDQ_SDP_mux     : in     vl_logic_vector(0 to 31);
        p_SDQ_SDP_mux   : in     vl_logic_vector(0 to 3);
        fillBufMuxSel0  : in     vl_logic_vector(0 to 31);
        fillBufMuxSel1  : in     vl_logic_vector(0 to 31);
        fillBuf_E1      : in     vl_logic;
        fillBuf_E2      : in     vl_logic_vector(0 to 7)
    );
end p405s_DCU_fillBuf;
