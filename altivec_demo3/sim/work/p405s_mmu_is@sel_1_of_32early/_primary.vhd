library verilog;
use verilog.vl_types.all;
entity p405s_mmu_isSel_1_of_32early is
    port(
        sprReal_N       : out    vl_logic_vector(0 to 1);
        CB              : in     vl_logic;
        ea              : in     vl_logic_vector(0 to 1);
        isEAL_N         : in     vl_logic_vector(2 to 4);
        msrIR_N         : in     vl_logic;
        spr1            : in     vl_logic_vector(0 to 31);
        spr2            : in     vl_logic_vector(0 to 31)
    );
end p405s_mmu_isSel_1_of_32early;
