library verilog;
use verilog.vl_types.all;
entity p405s_aPortMux is
    port(
        PCL_LpEqAp      : out    vl_logic;
        PCL_RpEqAp      : out    vl_logic;
        PCL_dcdApAddr   : out    vl_logic_vector(0 to 9);
        exeMorMRpEqdcdApAddr: out    vl_logic;
        exeRpEqdcdApAddr: out    vl_logic;
        wbLpEqdcdApAddr : out    vl_logic;
        dcdApMuxSel_NEG : in     vl_logic;
        dcdRAEqexeMorMRpAddr: in     vl_logic;
        dcdRAEqexeRpAddr: in     vl_logic;
        dcdRAEqlwbLpAddr: in     vl_logic;
        dcdRAEqwbLpAddr : in     vl_logic;
        dcdRAEqwbRpAddr : in     vl_logic;
        dcdRSEqexeMorMRpAddr: in     vl_logic;
        dcdRSEqexeRpAddr: in     vl_logic;
        dcdRSEqlwbLpAddr: in     vl_logic;
        dcdRSEqwbLpAddr : in     vl_logic;
        dcdRSEqwbRpAddr : in     vl_logic;
        preDcdRA        : in     vl_logic_vector(0 to 9);
        preDcdRSRT      : in     vl_logic_vector(0 to 9);
        rdEn            : in     vl_logic
    );
end p405s_aPortMux;
