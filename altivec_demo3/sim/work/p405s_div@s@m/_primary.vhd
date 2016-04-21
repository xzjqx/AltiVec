library verilog;
use verilog.vl_types.all;
entity p405s_divSM is
    port(
        nxtDivSt        : out    vl_logic_vector(0 to 5);
        divStE1         : out    vl_logic;
        nxtLastStOrSt0  : out    vl_logic;
        nxtSt0Or1       : out    vl_logic;
        nxtSt1          : out    vl_logic;
        resetL2         : in     vl_logic;
        divideEn        : in     vl_logic;
        pState          : in     vl_logic_vector(0 to 5)
    );
end p405s_divSM;
