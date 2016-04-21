library verilog;
use verilog.vl_types.all;
entity p405s_ldSteerPla is
    port(
        ldAdjSel        : out    vl_logic_vector(1 to 3);
        ldSteerMuxSel   : out    vl_logic_vector(0 to 7);
        ldFillByPassMuxSel: out    vl_logic_vector(0 to 5);
        ldAdjE2         : out    vl_logic_vector(1 to 3);
        ea              : in     vl_logic_vector(0 to 1);
        byteCount       : in     vl_logic_vector(6 to 7);
        cntGtEq4        : in     vl_logic;
        strgSt          : in     vl_logic_vector(1 to 2);
        load            : in     vl_logic;
        string          : in     vl_logic;
        multiple        : in     vl_logic;
        byteRev         : in     vl_logic;
        algebraic       : in     vl_logic
    );
end p405s_ldSteerPla;
