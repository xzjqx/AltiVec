library verilog;
use verilog.vl_types.all;
entity p405s_bPortMux is
    port(
        PCL_LpEqBp      : out    vl_logic;
        PCL_RpEqBp      : out    vl_logic;
        PCL_dcdBpAddr   : out    vl_logic_vector(0 to 9);
        exeMorMRpEqdcdBpAddr: out    vl_logic;
        exeRpEqdcdBpAddr: out    vl_logic;
        wbLpEqdcdBpAddr : out    vl_logic;
        dcdBpMuxSel_NEG : in     vl_logic;
        dcdRAEqexeMorMRpAddr: in     vl_logic;
        dcdRAEqexeRpAddr: in     vl_logic;
        dcdRAEqlwbLpAddr: in     vl_logic;
        dcdRAEqwbLpAddr : in     vl_logic;
        dcdRAEqwbRpAddr : in     vl_logic;
        dcdRBEqexeMorMRpAddr: in     vl_logic;
        dcdRBEqexeRpAddr: in     vl_logic;
        dcdRBEqlwbLpAddr: in     vl_logic;
        dcdRBEqwbLpAddr : in     vl_logic;
        dcdRBEqwbRpAddr : in     vl_logic;
        preDcdRA        : in     vl_logic_vector(0 to 9);
        preDcdRB        : in     vl_logic_vector(0 to 9);
        rdEn            : in     vl_logic;
        dcdBpMuxSel     : out    vl_logic
    );
end p405s_bPortMux;
