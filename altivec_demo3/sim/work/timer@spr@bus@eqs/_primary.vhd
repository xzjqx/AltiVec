library verilog;
use verilog.vl_types.all;
entity timerSprBusEqs is
    port(
        timStatCntrlSel : out    vl_logic;
        timerSprBusSel  : out    vl_logic_vector(0 to 1);
        TIM_watchDogIntrp: out    vl_logic;
        TIM_pitIntrp    : out    vl_logic;
        TIM_fitIntrp    : out    vl_logic;
        timerStatusOutL2: in     vl_logic_vector(0 to 5);
        timerControlL2  : in     vl_logic_vector(0 to 9);
        tbhDcd          : in     vl_logic;
        timerRstStatDcd : in     vl_logic;
        pitDcd          : in     vl_logic;
        tcrDcd          : in     vl_logic
    );
end timerSprBusEqs;
