library verilog;
use verilog.vl_types.all;
entity p405s_itlb_isComp0 is
    port(
        Hit             : out    vl_logic;
        Miss            : out    vl_logic;
        stateDhitSel    : out    vl_logic;
        CB              : in     vl_logic;
        CompE2          : in     vl_logic;
        EPN             : in     vl_logic_vector(0 to 21);
        EPN_NEG         : in     vl_logic_vector(0 to 21);
        Size            : in     vl_logic_vector(0 to 6);
        Valid           : in     vl_logic;
        WordSelect      : in     vl_logic;
        isAbort_NEG     : in     vl_logic;
        isEA            : in     vl_logic_vector(0 to 21);
        msrIrL2         : in     vl_logic;
        writeShadow     : in     vl_logic
    );
end p405s_itlb_isComp0;
