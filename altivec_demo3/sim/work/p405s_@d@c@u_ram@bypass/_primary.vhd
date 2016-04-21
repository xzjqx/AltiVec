library verilog;
use verilog.vl_types.all;
entity p405s_DCU_ramBypass is
    port(
        wordMuxA        : out    vl_logic_vector(0 to 31);
        wordMuxB        : out    vl_logic_vector(0 to 31);
        p_ramBypassA    : out    vl_logic_vector(0 to 3);
        p_ramBypassB    : out    vl_logic_vector(0 to 3);
        CAR_buf2        : in     vl_logic_vector(28 to 29);
        CAR_buf3        : in     vl_logic_vector(28 to 29);
        dataOut_A       : in     vl_logic_vector(0 to 127);
        dataOut_B       : in     vl_logic_vector(0 to 127);
        p_dataOutA      : in     vl_logic_vector(0 to 15);
        p_dataOutB      : in     vl_logic_vector(0 to 15)
    );
end p405s_DCU_ramBypass;
