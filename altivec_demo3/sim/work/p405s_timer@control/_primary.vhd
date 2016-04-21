library verilog;
use verilog.vl_types.all;
entity p405s_timerControl is
    port(
        timerControlL2  : out    vl_logic_vector(0 to 9);
        CB              : in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 9);
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        resetCore       : in     vl_logic;
        tcrDcd          : in     vl_logic
    );
end p405s_timerControl;
