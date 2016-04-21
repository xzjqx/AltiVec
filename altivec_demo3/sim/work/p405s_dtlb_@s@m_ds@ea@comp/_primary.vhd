library verilog;
use verilog.vl_types.all;
entity p405s_dtlb_SM_dsEaComp is
    port(
        Hit             : out    vl_logic;
        Miss            : out    vl_logic;
        EXE_dsEaCP      : in     vl_logic_vector(0 to 7);
        FC              : in     vl_logic_vector(0 to 21);
        FS              : in     vl_logic_vector(0 to 21);
        LSSD_coreTestEn : in     vl_logic;
        Size            : in     vl_logic_vector(0 to 6);
        Valid           : in     vl_logic;
        dsStateA        : in     vl_logic;
        msrDR_NEG       : in     vl_logic
    );
end p405s_dtlb_SM_dsEaComp;
