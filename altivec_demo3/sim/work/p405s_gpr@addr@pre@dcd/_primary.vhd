library verilog;
use verilog.vl_types.all;
entity p405s_gprAddrPreDcd is
    port(
        OUT1            : out    vl_logic_vector(0 to 9);
        IN1             : in     vl_logic_vector(0 to 4)
    );
end p405s_gprAddrPreDcd;
