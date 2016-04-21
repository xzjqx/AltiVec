library verilog;
use verilog.vl_types.all;
entity p405s_DCU_dataSteering is
    port(
        SDQ_mod         : out    vl_logic_vector(0 to 31);
        p_SDQ_mod       : out    vl_logic_vector(0 to 3);
        CAR_endian      : in     vl_logic;
        CB              : in     vl_logic;
        PCL_stSteerCntl : in     vl_logic_vector(0 to 9);
        SAQ_E2          : in     vl_logic;
        SDQ_E1          : in     vl_logic;
        SDQ_E2          : in     vl_logic;
        SDQ_L2          : in     vl_logic_vector(0 to 31);
        p_SDQ_L2        : in     vl_logic_vector(0 to 3);
        carStore        : in     vl_logic;
        ocmCompleteXltVNoWaitNoHold: in     vl_logic
    );
end p405s_DCU_dataSteering;
