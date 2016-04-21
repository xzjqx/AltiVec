library verilog;
use verilog.vl_types.all;
entity RO1SH is
    generic(
        WIDTH           : integer := 32;
        AWIDTH          : integer := 30;
        DEPTH           : integer := 2048
    );
    port(
        cs              : in     vl_logic;
        addr            : in     vl_logic_vector;
        dout_eve        : out    vl_logic_vector;
        dout_odd        : out    vl_logic_vector
    );
end RO1SH;
