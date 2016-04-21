library verilog;
use verilog.vl_types.all;
entity altivec_dut is
    port(
        vra             : in     vl_logic_vector(127 downto 0);
        vrb             : in     vl_logic_vector(127 downto 0);
        ins             : in     vl_logic_vector(7 downto 0);
        vra_en          : in     vl_logic;
        vrb_en          : in     vl_logic;
        ins_en          : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rc              : in     vl_logic;
        dut_busy        : out    vl_logic;
        vrt_en          : out    vl_logic;
        vrt             : out    vl_logic_vector(127 downto 0)
    );
end altivec_dut;
