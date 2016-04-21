library verilog;
use verilog.vl_types.all;
entity p405s_dtlb_dsWord is
    port(
        E_out           : out    vl_logic;
        G_out           : out    vl_logic;
        Hit             : out    vl_logic;
        I_out           : out    vl_logic;
        Miss            : out    vl_logic;
        RA              : out    vl_logic_vector(0 to 21);
        U0_out          : out    vl_logic;
        WR_out          : out    vl_logic;
        W_out           : out    vl_logic;
        zonePR_out      : out    vl_logic_vector(0 to 1);
        CB              : in     vl_logic;
        DSize           : in     vl_logic_vector(0 to 6);
        E               : in     vl_logic;
        EXE_dsEaCP      : in     vl_logic_vector(0 to 7);
        EXE_eaARegBuf   : in     vl_logic_vector(0 to 21);
        EXE_eaBRegBuf   : in     vl_logic_vector(0 to 21);
        G               : in     vl_logic;
        I               : in     vl_logic;
        LSSD_coreTestEn : in     vl_logic;
        RPN             : in     vl_logic_vector(0 to 21);
        U0              : in     vl_logic;
        W               : in     vl_logic;
        WR              : in     vl_logic;
        WordSel_N       : in     vl_logic;
        dsEAforMunge    : in     vl_logic_vector(8 to 21);
        dsEPN           : in     vl_logic_vector(0 to 21);
        dsStateA        : in     vl_logic;
        invalidate      : in     vl_logic;
        msrDR           : in     vl_logic;
        rdNotWrt        : in     vl_logic;
        zonePR          : in     vl_logic_vector(0 to 1)
    );
end p405s_dtlb_dsWord;
