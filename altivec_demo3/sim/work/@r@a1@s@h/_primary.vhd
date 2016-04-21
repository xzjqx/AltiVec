library verilog;
use verilog.vl_types.all;
entity RA1SH is
    generic(
        WIDTH           : integer := 32;
        AWIDTH          : integer := 30;
        DEPTH           : integer := 2048
    );
    port(
        cs              : in     vl_logic;
        rw              : in     vl_logic;
        addr            : in     vl_logic_vector;
        din             : in     vl_logic_vector;
        dout            : out    vl_logic_vector
    );
end RA1SH;
