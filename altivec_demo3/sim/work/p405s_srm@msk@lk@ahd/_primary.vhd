library verilog;
use verilog.vl_types.all;
entity p405s_srmMskLkAhd is
    port(
        propLookAhd     : out    vl_logic_vector(0 to 1);
        forceZeroDcd    : in     vl_logic;
        mbField         : in     vl_logic_vector(0 to 4);
        meField         : in     vl_logic_vector(0 to 4)
    );
end p405s_srmMskLkAhd;
