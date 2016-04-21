library verilog;
use verilog.vl_types.all;
entity p405s_multSM is
    port(
        nxtMultSt       : out    vl_logic_vector(0 to 1);
        multStE1        : out    vl_logic;
        resetL2         : in     vl_logic;
        multEn          : in     vl_logic;
        multMCO         : in     vl_logic;
        multSt          : in     vl_logic_vector(0 to 1)
    );
end p405s_multSM;
