library verilog;
use verilog.vl_types.all;
entity p405s_timerSprBus is
    port(
        TIM_SprDataBus  : out    vl_logic_vector(0 to 31);
        TIM_fitIntrp    : out    vl_logic;
        TIM_pitIntrp    : out    vl_logic;
        TIM_watchDogIntrp: out    vl_logic;
        pit             : in     vl_logic_vector(0 to 31);
        pitDcd          : in     vl_logic;
        tbh             : in     vl_logic_vector(0 to 31);
        tbhDcd          : in     vl_logic;
        tbl             : in     vl_logic_vector(0 to 31);
        tcrDcd          : in     vl_logic;
        timerControlL2  : in     vl_logic_vector(0 to 9);
        timerRstStatDcd : in     vl_logic;
        timerStatusOutL2: in     vl_logic_vector(0 to 5)
    );
end p405s_timerSprBus;
