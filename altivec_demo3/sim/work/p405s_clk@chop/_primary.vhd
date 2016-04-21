library verilog;
use verilog.vl_types.all;
entity p405s_clkChop is
    port(
        CB              : in     vl_logic;
        rdEn            : out    vl_logic;
        DRCC            : in     vl_logic;
        ERC             : in     vl_logic;
        IFB_dcdFullL2   : in     vl_logic;
        LSSD_coreTestEn : in     vl_logic;
        c2Clk           : in     vl_logic;
        exeStore        : in     vl_logic;
        PCL_gprRdClk    : out    vl_logic
    );
end p405s_clkChop;
