library verilog;
use verilog.vl_types.all;
entity p405s_icu_newVbGen is
    port(
        newVb           : out    vl_logic_vector(0 to 31);
        vbWrIndex       : in     vl_logic_vector(4 to 8);
        newVbBit        : in     vl_logic;
        feedbackVb      : in     vl_logic_vector(0 to 31);
        wrFlash         : in     vl_logic
    );
end p405s_icu_newVbGen;
