library verilog;
use verilog.vl_types.all;
entity p405s_icu_vaG2Gen is
    port(
        va0E2           : out    vl_logic;
        va1E2           : out    vl_logic;
        va2E2           : out    vl_logic;
        va3E2           : out    vl_logic;
        va4E2           : out    vl_logic;
        va5E2           : out    vl_logic;
        va6E2           : out    vl_logic;
        va7E2           : out    vl_logic;
        vaWrCycle       : in     vl_logic;
        vaWrIndex       : in     vl_logic_vector(1 to 3);
        wrFlash         : in     vl_logic
    );
end p405s_icu_vaG2Gen;
