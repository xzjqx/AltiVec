library verilog;
use verilog.vl_types.all;
entity timerTbhEqs is
    port(
        sprDataSel      : out    vl_logic;
        tbhE1           : out    vl_logic;
        tbhE2           : out    vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        cIn             : in     vl_logic;
        tbhDcd          : in     vl_logic;
        freezeTimersNEG : in     vl_logic
    );
end timerTbhEqs;
