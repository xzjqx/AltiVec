library verilog;
use verilog.vl_types.all;
entity p405s_timerWdFitEqs is
    port(
        TIM_timerResetL2Buf: out    vl_logic;
        TIM_wdChipRst   : out    vl_logic;
        TIM_wdCoreRst   : out    vl_logic;
        TIM_wdSysRst    : out    vl_logic;
        hwSetFitStatus  : out    vl_logic;
        hwSetWdIntrp    : out    vl_logic;
        hwSetWdRst      : out    vl_logic;
        oscTimerDlyL2   : out    vl_logic;
        timResetCoreL2  : out    vl_logic;
        wdPulse         : out    vl_logic;
        CB              : in     vl_logic;
        OSC_timer       : in     vl_logic;
        enableNxtWdTic  : in     vl_logic;
        fitTapSel       : in     vl_logic_vector(0 to 1);
        fitTaps         : in     vl_logic_vector(0 to 3);
        resetCore       : in     vl_logic;
        wdIntrpBit      : in     vl_logic;
        wdRstType       : in     vl_logic_vector(0 to 1);
        wdTapSel        : in     vl_logic_vector(0 to 1);
        wdTaps          : in     vl_logic_vector(0 to 3)
    );
end p405s_timerWdFitEqs;
