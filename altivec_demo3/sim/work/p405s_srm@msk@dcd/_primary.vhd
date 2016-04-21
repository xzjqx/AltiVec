library verilog;
use verilog.vl_types.all;
entity p405s_srmMskDcd is
    port(
        mskBegin        : out    vl_logic_vector(0 to 31);
        mskEndHi        : out    vl_logic_vector(0 to 14);
        mskEndLo        : out    vl_logic_vector(16 to 30);
        forceZeroDcd    : out    vl_logic;
        mbField         : in     vl_logic_vector(0 to 4);
        meField         : in     vl_logic_vector(0 to 4);
        shiftLt         : in     vl_logic;
        shiftAmtMsb     : in     vl_logic;
        shiftRt         : in     vl_logic
    );
end p405s_srmMskDcd;
