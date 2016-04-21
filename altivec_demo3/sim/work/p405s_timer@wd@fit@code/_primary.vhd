library verilog;
use verilog.vl_types.all;
entity p405s_timerWdFitCode is
    port(
        wdTapsIn        : out    vl_logic;
        fitTapsIn       : out    vl_logic;
        nxtTimerResetIn : out    vl_logic;
        hwSetFitStatus  : out    vl_logic;
        hwSetWdIntrp    : out    vl_logic;
        hwSetWdRst      : out    vl_logic;
        wdPulse         : out    vl_logic;
        TIM_wdCoreRst   : out    vl_logic;
        TIM_wdChipRst   : out    vl_logic;
        TIM_wdSysRst    : out    vl_logic;
        fitTapSel       : in     vl_logic_vector(0 to 1);
        fitTaps         : in     vl_logic_vector(0 to 3);
        enableNxtWdTic  : in     vl_logic;
        timerResetForTimersL2: in     vl_logic;
        wdIntrpBit      : in     vl_logic;
        wdTapSel        : in     vl_logic_vector(0 to 1);
        wdTaps          : in     vl_logic_vector(0 to 3);
        wdRstType       : in     vl_logic_vector(0 to 1);
        wdDlyL2         : in     vl_logic;
        fitDlyL2        : in     vl_logic;
        timResetCoreL2  : in     vl_logic
    );
end p405s_timerWdFitCode;
