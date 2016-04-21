library verilog;
use verilog.vl_types.all;
entity vsfx_top is
    port(
        clk             : in     vl_logic;
        en              : in     vl_logic;
        vra             : in     vl_logic_vector(127 downto 0);
        vrb             : in     vl_logic_vector(127 downto 0);
        ins             : in     vl_logic_vector(7 downto 0);
        vrt_en          : out    vl_logic;
        vrt             : out    vl_logic_vector(127 downto 0);
        sat             : out    vl_logic;
        cr6             : out    vl_logic_vector(3 downto 0)
    );
end vsfx_top;
