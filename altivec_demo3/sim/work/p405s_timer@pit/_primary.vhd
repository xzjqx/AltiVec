library verilog;
use verilog.vl_types.all;
entity p405s_timerPit is
    port(
        hwSetPitStatus  : out    vl_logic;
        pitL2           : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        LSSD_coreTestEn : in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        freezeTimersNEG : in     vl_logic;
        pitDcd          : in     vl_logic;
        tcrARenable     : in     vl_logic;
        timerTic        : in     vl_logic
    );
end p405s_timerPit;
