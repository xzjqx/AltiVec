library verilog;
use verilog.vl_types.all;
entity p405s_srm_top is
    port(
        srmCA           : out    vl_logic;
        srmOut          : out    vl_logic_vector(0 to 31);
        exeSrmUnitEn_NEG: in     vl_logic;
        aBus            : in     vl_logic_vector(0 to 31);
        bBus            : in     vl_logic_vector(0 to 31);
        srmCntlBus      : in     vl_logic_vector(0 to 3);
        srmL2           : in     vl_logic_vector(0 to 15);
        srmCcBits       : out    vl_logic_vector(0 to 2)
    );
end p405s_srm_top;
