library verilog;
use verilog.vl_types.all;
entity p405s_Compressor4To2 is
    port(
        C               : out    vl_logic;
        S               : out    vl_logic;
        cout            : out    vl_logic;
        cin             : in     vl_logic;
        w               : in     vl_logic;
        x               : in     vl_logic;
        y               : in     vl_logic;
        z               : in     vl_logic
    );
end p405s_Compressor4To2;
