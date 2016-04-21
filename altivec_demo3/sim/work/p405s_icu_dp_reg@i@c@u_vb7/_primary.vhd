library verilog;
use verilog.vl_types.all;
entity p405s_icu_dp_regICU_vb7 is
    port(
        CB              : in     vl_logic;
        D               : in     vl_logic_vector(0 to 31);
        E1              : in     vl_logic;
        L2              : out    vl_logic_vector(0 to 31)
    );
end p405s_icu_dp_regICU_vb7;
