library verilog;
use verilog.vl_types.all;
entity timerTblEqs is
    port(
        cOut            : out    vl_logic;
        sprDataSel      : out    vl_logic;
        tbl8E1          : out    vl_logic;
        tbl8E2          : out    vl_logic;
        tbl24E1         : out    vl_logic;
        tbl24E2         : out    vl_logic;
        timerTic        : out    vl_logic;
        freezeTimersNEG : out    vl_logic;
        tblL2           : in     vl_logic_vector(0 to 31);
        oscTimerDlyL2   : in     vl_logic;
        DBG_freezeTimers: in     vl_logic;
        JTG_freezeTimers: in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        tblDcd          : in     vl_logic
    );
end timerTblEqs;
