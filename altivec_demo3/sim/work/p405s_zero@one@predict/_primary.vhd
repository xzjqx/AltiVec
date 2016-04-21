library verilog;
use verilog.vl_types.all;
entity p405s_zeroOnePredict is
    port(
        N_OP            : out    vl_logic;
        N_ZP            : out    vl_logic;
        OPLo16          : out    vl_logic;
        ZPLo16          : out    vl_logic;
        aIn             : in     vl_logic_vector(0 to 31);
        bIn             : in     vl_logic_vector(0 to 31);
        cIn             : in     vl_logic
    );
end p405s_zeroOnePredict;
