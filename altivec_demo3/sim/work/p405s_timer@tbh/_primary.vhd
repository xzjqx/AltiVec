library verilog;
use verilog.vl_types.all;
entity p405s_timerTbh is
    port(
        tbhL2           : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        cIn             : in     vl_logic;
        freezeTimersNEG : in     vl_logic;
        tbhDcd          : in     vl_logic
    );
end p405s_timerTbh;
