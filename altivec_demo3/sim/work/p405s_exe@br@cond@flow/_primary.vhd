library verilog;
use verilog.vl_types.all;
entity p405s_exeBrCondFlow is
    port(
        exeCondOK_Neg   : out    vl_logic;
        crL2            : in     vl_logic_vector(0 to 31);
        exeBIL2         : in     vl_logic_vector(0 to 4);
        exeBOL2         : in     vl_logic_vector(0 to 3);
        exeCtrEq0       : in     vl_logic
    );
end p405s_exeBrCondFlow;
