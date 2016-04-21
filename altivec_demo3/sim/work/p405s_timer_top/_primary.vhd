library verilog;
use verilog.vl_types.all;
entity p405s_timer_top is
    port(
        TIM_fitIntrp    : out    vl_logic;
        TIM_pitIntrp    : out    vl_logic;
        TIM_sprDataBus  : out    vl_logic_vector(0 to 31);
        TIM_timerResetL2Buf: out    vl_logic;
        TIM_watchDogIntrp: out    vl_logic;
        TIM_wdChipRst   : out    vl_logic;
        TIM_wdCoreRst   : out    vl_logic;
        TIM_wdSysRst    : out    vl_logic;
        CB              : in     vl_logic;
        DBG_freezeTimers: in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        EXE_timSprDcds  : in     vl_logic_vector(0 to 5);
        JTG_freezeTimers: in     vl_logic;
        LSSD_coreTestEn : in     vl_logic;
        OSC_timer       : in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        resetCore       : in     vl_logic
    );
end p405s_timer_top;
