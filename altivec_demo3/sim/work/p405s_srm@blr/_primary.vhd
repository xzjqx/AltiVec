library verilog;
use verilog.vl_types.all;
entity p405s_srmBlr is
    port(
        blrOut          : out    vl_logic_vector(0 to 31);
        aBus_NEG        : in     vl_logic_vector(0 to 31);
        rotateAmt       : in     vl_logic_vector(0 to 4)
    );
end p405s_srmBlr;
