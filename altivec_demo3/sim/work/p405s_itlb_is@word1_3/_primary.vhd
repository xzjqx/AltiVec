library verilog;
use verilog.vl_types.all;
entity p405s_itlb_isWord1_3 is
    port(
        E_out           : out    vl_logic;
        Hit             : out    vl_logic;
        I_out           : out    vl_logic;
        Miss            : out    vl_logic;
        RA              : out    vl_logic_vector(0 to 21);
        U0_out          : out    vl_logic;
        CB              : in     vl_logic;
        CompE2          : in     vl_logic;
        DSize           : in     vl_logic_vector(0 to 6);
        E               : in     vl_logic;
        I               : in     vl_logic;
        RPN             : in     vl_logic_vector(0 to 21);
        U0              : in     vl_logic;
        WordSel_N       : in     vl_logic;
        invalidate      : in     vl_logic;
        isAbort_N       : in     vl_logic;
        isEA            : in     vl_logic_vector(0 to 21);
        isEPN           : in     vl_logic_vector(0 to 21);
        msrIrL2         : in     vl_logic;
        rdNotWrt        : in     vl_logic;
        writeShadow     : in     vl_logic
    );
end p405s_itlb_isWord1_3;
