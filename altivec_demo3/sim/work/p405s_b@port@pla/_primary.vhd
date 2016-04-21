library verilog;
use verilog.vl_types.all;
entity p405s_bPortPla is
    port(
        dcdBpMuxSel     : out    vl_logic;
        priOp           : in     vl_logic_vector(0 to 5);
        secOp           : in     vl_logic_vector(21 to 31)
    );
end p405s_bPortPla;
