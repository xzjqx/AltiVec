library verilog;
use verilog.vl_types.all;
entity p405s_admCc is
    port(
        admCCbits       : out    vl_logic_vector(0 to 2);
        trap            : out    vl_logic;
        N_zeroDetect    : in     vl_logic;
        adderOut        : in     vl_logic_vector(0 to 1);
        cout            : in     vl_logic;
        compInstr       : in     vl_logic;
        trapInstr       : in     vl_logic;
        trapCond        : in     vl_logic_vector(0 to 4)
    );
end p405s_admCc;
