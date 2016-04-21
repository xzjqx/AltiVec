library verilog;
use verilog.vl_types.all;
entity p405s_zeroOneDetect is
    port(
        aBytes01Eq0     : out    vl_logic;
        bBytes23Eq0     : out    vl_logic;
        bBytes01Eq0     : out    vl_logic;
        bBytes01Eq1     : out    vl_logic;
        aBytes01Eq1     : out    vl_logic;
        bBus            : in     vl_logic_vector(0 to 31);
        aBus            : in     vl_logic_vector(0 to 15);
        bIn             : in     vl_logic_vector(0 to 15);
        aIn             : in     vl_logic_vector(0 to 15);
        CO16            : in     vl_logic;
        ZPHi16          : out    vl_logic;
        OPHi16          : out    vl_logic
    );
end p405s_zeroOneDetect;
