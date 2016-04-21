library verilog;
use verilog.vl_types.all;
entity p405s_timerStatusEqs is
    port(
        tsrDataIn       : out    vl_logic_vector(0 to 5);
        tsrE2           : out    vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        hwSetWdIntrp    : in     vl_logic;
        hwSetFitStatus  : in     vl_logic;
        hwSetPitStatus  : in     vl_logic;
        wdRstType       : in     vl_logic_vector(0 to 1);
        hwSetWdRst      : in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 5);
        timerRstStatDcd : in     vl_logic;
        timerSetStatDcd : in     vl_logic;
        timerStatusOutL2: in     vl_logic_vector(0 to 5);
        wdPulse         : in     vl_logic;
        resetCore       : in     vl_logic
    );
end p405s_timerStatusEqs;
