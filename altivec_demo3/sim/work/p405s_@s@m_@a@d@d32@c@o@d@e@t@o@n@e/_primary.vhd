library verilog;
use verilog.vl_types.all;
entity p405s_SM_ADD32CODETONE is
    port(
        CO              : out    vl_logic;
        SUMEQ0          : out    vl_logic;
        SUMEQ1          : out    vl_logic;
        SUMEQ4TO2       : out    vl_logic;
        SUMEQ31TO5      : out    vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0)
    );
end p405s_SM_ADD32CODETONE;
