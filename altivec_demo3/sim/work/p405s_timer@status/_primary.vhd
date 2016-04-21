library verilog;
use verilog.vl_types.all;
entity p405s_timerStatus is
    port(
        timerStatusOutL2: out    vl_logic_vector(0 to 5);
        CB              : in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 5);
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        hwSetFitStatus  : in     vl_logic;
        hwSetPitStatus  : in     vl_logic;
        hwSetWdIntrp    : in     vl_logic;
        hwSetWdRst      : in     vl_logic;
        resetCore       : in     vl_logic;
        timerRstStatDcd : in     vl_logic;
        timerSetStatDcd : in     vl_logic;
        wdPulse         : in     vl_logic;
        wdRstType       : in     vl_logic_vector(0 to 1)
    );
end p405s_timerStatus;
