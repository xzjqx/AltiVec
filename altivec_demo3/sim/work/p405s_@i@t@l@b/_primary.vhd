library verilog;
use verilog.vl_types.all;
entity p405s_ITLB is
    port(
        ITLB_E          : out    vl_logic;
        ITLB_I_NEG      : out    vl_logic_vector(0 to 2);
        ITLB_U0         : out    vl_logic;
        isRA_NEG        : out    vl_logic_vector(0 to 21);
        itlbMiss        : out    vl_logic;
        CB              : in     vl_logic;
        CompE2          : in     vl_logic;
        DSize           : in     vl_logic_vector(0 to 6);
        E               : in     vl_logic;
        I               : in     vl_logic;
        LoadRealRaAttr  : in     vl_logic;
        RPN             : in     vl_logic_vector(0 to 21);
        U0              : in     vl_logic;
        VCT_msrIR       : in     vl_logic;
        isAbort         : in     vl_logic;
        isAddr          : in     vl_logic_vector(0 to 1);
        isEA_NEG        : in     vl_logic_vector(0 to 21);
        isEPN           : in     vl_logic_vector(0 to 21);
        isEReal_N       : in     vl_logic;
        isIReal_N       : in     vl_logic;
        isInvalidate    : in     vl_logic;
        isU0Real_N      : in     vl_logic;
        isrdNotWrt      : in     vl_logic;
        msrIrL2         : in     vl_logic
    );
end p405s_ITLB;
