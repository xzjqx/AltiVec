library verilog;
use verilog.vl_types.all;
entity p405s_SM_ADD33CICO16_P2 is
    port(
        CO              : out    vl_logic;
        CO16            : out    vl_logic;
        CO30            : out    vl_logic;
        SUM32_B         : out    vl_logic;
        SUM32_C         : out    vl_logic;
        SUM31_B         : out    vl_logic;
        SUM31_C         : out    vl_logic;
        SUM15_B         : out    vl_logic;
        SUM16_B         : out    vl_logic;
        SUM             : out    vl_logic_vector(32 downto 0);
        CI              : in     vl_logic;
        A               : in     vl_logic_vector(32 downto 0);
        B               : in     vl_logic_vector(32 downto 0)
    );
end p405s_SM_ADD33CICO16_P2;
