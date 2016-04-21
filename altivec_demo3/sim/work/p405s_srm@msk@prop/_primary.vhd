library verilog;
use verilog.vl_types.all;
entity p405s_srmMskProp is
    port(
        notMask         : out    vl_logic_vector(0 to 31);
        mskBegin        : in     vl_logic_vector(0 to 31);
        mskEndHi        : in     vl_logic_vector(0 to 14);
        mskEndLo        : in     vl_logic_vector(16 to 30);
        propLookAhd     : in     vl_logic_vector(0 to 1)
    );
end p405s_srmMskProp;
