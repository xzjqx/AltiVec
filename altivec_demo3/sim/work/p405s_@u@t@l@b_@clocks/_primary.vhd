library verilog;
use verilog.vl_types.all;
entity p405s_UTLB_Clocks is
    port(
        EN_C1           : out    vl_logic;
        EN_ARRAYL1      : out    vl_logic;
        C_Clock         : in     vl_logic;
        LSSD_ArrayCClk_buf: in     vl_logic;
        TestComp        : in     vl_logic;
        TestM3          : in     vl_logic;
        lookupEn        : in     vl_logic;
        LookupenForEnC1 : in     vl_logic;
        rdEn            : in     vl_logic;
        wrEn            : in     vl_logic;
        EN_ARRAYL1_preTestM3: out    vl_logic;
        CB              : in     vl_logic
    );
end p405s_UTLB_Clocks;
