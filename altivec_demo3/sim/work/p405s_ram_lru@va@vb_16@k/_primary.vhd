library verilog;
use verilog.vl_types.all;
entity p405s_ram_lruVaVb_16K is
    port(
        lruOut          : out    vl_logic;
        vaOut           : out    vl_logic;
        vbOut           : out    vl_logic;
        CB              : in     vl_logic;
        lruRdIndex      : in     vl_logic_vector(0 to 8);
        lruWrCycle      : in     vl_logic;
        lruWrIndex      : in     vl_logic_vector(0 to 8);
        newLruBit       : in     vl_logic;
        newVaBit        : in     vl_logic;
        newVbBit        : in     vl_logic;
        vaRdIndex       : in     vl_logic_vector(0 to 8);
        vaWrCycle       : in     vl_logic;
        vaWrIndex       : in     vl_logic_vector(0 to 8);
        vbRdIndex       : in     vl_logic_vector(0 to 8);
        vbWrCycle       : in     vl_logic;
        vbWrIndex       : in     vl_logic_vector(0 to 8);
        wrFlash         : in     vl_logic
    );
end p405s_ram_lruVaVb_16K;
