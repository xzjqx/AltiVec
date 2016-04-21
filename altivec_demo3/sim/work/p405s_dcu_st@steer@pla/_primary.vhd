library verilog;
use verilog.vl_types.all;
entity p405s_dcu_stSteerPla is
    port(
        stMuxSel        : out    vl_logic_vector(0 to 3);
        stSteerMuxSel   : out    vl_logic_vector(0 to 7);
        stAdjE1         : out    vl_logic_vector(0 to 3);
        mea             : in     vl_logic_vector(0 to 1);
        byteCount       : in     vl_logic_vector(6 to 7);
        cntGtEq4        : in     vl_logic;
        storageSt       : in     vl_logic;
        string          : in     vl_logic;
        multiple        : in     vl_logic;
        byteRev         : in     vl_logic;
        byteRev2        : in     vl_logic
    );
end p405s_dcu_stSteerPla;
