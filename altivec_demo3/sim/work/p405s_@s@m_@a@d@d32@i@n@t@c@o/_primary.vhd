library verilog;
use verilog.vl_types.all;
entity p405s_SM_ADD32INTCO is
    port(
        CP              : out    vl_logic_vector(7 downto 0);
        SUM             : out    vl_logic_vector(31 downto 0);
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0)
    );
end p405s_SM_ADD32INTCO;
