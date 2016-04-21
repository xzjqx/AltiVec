library verilog;
use verilog.vl_types.all;
entity p405s_dcdInstPlaForBr is
    port(
        priOp_0         : in     vl_logic;
        priOp_1         : in     vl_logic;
        priOp_2         : in     vl_logic;
        priOp_3         : in     vl_logic;
        priOp_4         : in     vl_logic;
        priOp_5         : in     vl_logic;
        secOp_21        : in     vl_logic;
        secOp_22        : in     vl_logic;
        secOp_23        : in     vl_logic;
        secOp_24        : in     vl_logic;
        secOp_25        : in     vl_logic;
        secOp_26        : in     vl_logic;
        secOp_27        : in     vl_logic;
        secOp_28        : in     vl_logic;
        secOp_29        : in     vl_logic;
        secOp_30        : in     vl_logic;
        Rc              : in     vl_logic;
        plaCr0En        : out    vl_logic;
        plaB            : out    vl_logic;
        plaBc           : out    vl_logic;
        plaMtspr        : out    vl_logic
    );
end p405s_dcdInstPlaForBr;
