library verilog;
use verilog.vl_types.all;
entity p405s_timerTbl is
    port(
        cOut            : out    vl_logic;
        freezeTimersNEG : out    vl_logic;
        tblL2           : out    vl_logic_vector(0 to 31);
        timerTic        : out    vl_logic;
        CB              : in     vl_logic;
        DBG_freezeTimers: in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        JTG_freezeTimers: in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        oscTimerDlyL2   : in     vl_logic;
        tblDcd          : in     vl_logic
    );
end p405s_timerTbl;
