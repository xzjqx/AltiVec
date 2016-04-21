library verilog;
use verilog.vl_types.all;
entity p405s_PDP_P1EUL2 is
    generic(
        N               : integer := 10;
        ScanDir         : integer := 0;
        LBHC            : integer := 1;
        CSBHC           : integer := 1;
        ClkSep          : integer := 0;
        FAST            : integer := 0
    );
    port(
        CB              : in     vl_logic;
        D               : in     vl_logic_vector;
        E1              : in     vl_logic;
        I               : in     vl_logic;
        L2              : out    vl_logic_vector;
        SO              : out    vl_logic
    );
end p405s_PDP_P1EUL2;
