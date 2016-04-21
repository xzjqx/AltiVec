library verilog;
use verilog.vl_types.all;
entity p405s_timerPitEqs is
    port(
        pit8E1          : out    vl_logic;
        pit8E2          : out    vl_logic;
        pit24E1         : out    vl_logic;
        pit24E2         : out    vl_logic;
        pitReloadE1     : out    vl_logic;
        pitReloadE2     : out    vl_logic;
        pitMuxSel       : out    vl_logic_vector(0 to 1);
        hwSetPitStatus  : out    vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        tcrARenable     : in     vl_logic;
        pitDcd          : in     vl_logic;
        timerTic        : in     vl_logic;
        pitL2           : in     vl_logic_vector(0 to 31);
        freezeTimersNEG : in     vl_logic;
        LSSD_coreTestEn : in     vl_logic
    );
end p405s_timerPitEqs;
