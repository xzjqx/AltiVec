library verilog;
use verilog.vl_types.all;
entity vsfx_vavgsh is
    port(
        vrt             : out    vl_logic_vector(31 downto 0);
        vra             : in     vl_logic_vector(31 downto 0);
        vrb             : in     vl_logic_vector(31 downto 0)
    );
end vsfx_vavgsh;
