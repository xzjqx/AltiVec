library verilog;
use verilog.vl_types.all;
entity p405s_logical_top is
    port(
        logicalCcBits   : out    vl_logic_vector(0 to 2);
        logicalOut      : out    vl_logic_vector(0 to 31);
        dlmzb           : out    vl_logic;
        exeLogicalUnitEn_NEG: in     vl_logic;
        aBus            : in     vl_logic_vector(0 to 31);
        bBus            : in     vl_logic_vector(0 to 31);
        logicalCntl     : in     vl_logic_vector(0 to 7)
    );
end p405s_logical_top;
