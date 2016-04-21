library verilog;
use verilog.vl_types.all;
entity p405s_DCU_writeBuf is
    port(
        WB_word0L2      : out    vl_logic_vector(0 to 31);
        WB_word1L2      : out    vl_logic_vector(0 to 31);
        WB_word2L2      : out    vl_logic_vector(0 to 31);
        WB_word3L2      : out    vl_logic_vector(0 to 31);
        p_WBhi_L2       : out    vl_logic_vector(0 to 15);
        CB              : in     vl_logic;
        SDQ_SDP_mux     : in     vl_logic_vector(0 to 31);
        p_SDQ_SDP_mux   : in     vl_logic_vector(0 to 3);
        fillBufWord0_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord1_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord2_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord3_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord4_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord5_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord6_L2 : in     vl_logic_vector(0 to 31);
        fillBufWord7_L2 : in     vl_logic_vector(0 to 31);
        p_fillBuf_L2    : in     vl_logic_vector(0 to 31);
        writeBufHi_E1   : in     vl_logic;
        writeBufHi_E2   : in     vl_logic_vector(0 to 3);
        writeBufLoTag_E1: in     vl_logic;
        writeBufLoTag_E2: in     vl_logic;
        writeBufMuxSelBit0: in     vl_logic;
        writeBufMuxSelBit1: in     vl_logic_vector(0 to 31)
    );
end p405s_DCU_writeBuf;
