library verilog;
use verilog.vl_types.all;
entity p405s_sprMux_top is
    port(
        sprBusEnd       : out    vl_logic_vector(0 to 31);
        DBG_sprDataBus  : in     vl_logic_vector(0 to 31);
        EXE_xer         : in     vl_logic_vector(0 to 2);
        EXE_xerSIL      : in     vl_logic_vector(0 to 6);
        IFB_sprDataBus  : in     vl_logic_vector(0 to 31);
        JTG_sprDataBus  : in     vl_logic_vector(0 to 31);
        PCL_mfDCRL2     : in     vl_logic;
        PCL_exeMfspr    : in     vl_logic;
        TIM_sprDataBus  : in     vl_logic_vector(0 to 31);
        VCT_sprDataBus  : in     vl_logic_vector(0 to 31);
        XXX_dcrDataBus  : in     vl_logic_vector(0 to 31);
        ICU_sprDataBus  : in     vl_logic_vector(0 to 31);
        MMU_sprDataBus  : in     vl_logic_vector(0 to 31);
        sprDataBus      : in     vl_logic_vector(0 to 31);
        PCL_sprHold     : in     vl_logic;
        CB              : in     vl_logic;
        dac1L2          : out    vl_logic_vector(0 to 31);
        dac2L2          : out    vl_logic_vector(0 to 31);
        PCL_exeMtspr    : in     vl_logic;
        dvc1L2          : out    vl_logic_vector(0 to 31);
        dvc2L2          : out    vl_logic_vector(0 to 31);
        PCL_timSprDcds  : in     vl_logic_vector(0 to 5);
        PCL_dbgSprDcds  : in     vl_logic_vector(0 to 3);
        PCL_exeSprDcds  : in     vl_logic_vector(0 to 4);
        PCL_vctSprDcds  : in     vl_logic_vector(0 to 5)
    );
end p405s_sprMux_top;
