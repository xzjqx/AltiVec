library verilog;
use verilog.vl_types.all;
entity p405s_dsMMU_sel_1_of_32 is
    port(
        spr1out         : out    vl_logic;
        spr2out         : out    vl_logic;
        ea              : in     vl_logic_vector(0 to 4);
        spr1            : in     vl_logic_vector(0 to 31);
        spr2            : in     vl_logic_vector(0 to 31)
    );
end p405s_dsMMU_sel_1_of_32;
