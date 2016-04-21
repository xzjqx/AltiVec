library verilog;
use verilog.vl_types.all;
entity vsfx_vaddsws is
    port(
        vrt             : out    vl_logic_vector(31 downto 0);
        vra             : in     vl_logic_vector(31 downto 0);
        vrb             : in     vl_logic_vector(31 downto 0);
        sat             : out    vl_logic
    );
end vsfx_vaddsws;
