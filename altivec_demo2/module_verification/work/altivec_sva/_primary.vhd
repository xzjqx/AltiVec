library verilog;
use verilog.vl_types.all;
entity altivec_sva is
    port(
        clk             : in     vl_logic;
        vsfx_vra_en     : in     vl_logic;
        vsfx_vrb_en     : in     vl_logic;
        vsfx_ins_en     : in     vl_logic;
        vsfx_vrt_en     : in     vl_logic
    );
end altivec_sva;
