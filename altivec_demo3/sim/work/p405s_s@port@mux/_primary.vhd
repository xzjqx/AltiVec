library verilog;
use verilog.vl_types.all;
entity p405s_sPortMux is
    port(
        PCL_LpEqSp      : out    vl_logic;
        PCL_RpEqSp      : out    vl_logic;
        PCL_dcdSpAddr   : out    vl_logic_vector(0 to 9);
        dcdSpAddr       : out    vl_logic_vector(0 to 4);
        dcdRSEqlwbLpAddr: in     vl_logic;
        dcdRSEqwbRpAddr : in     vl_logic;
        dcdRSRTL2       : in     vl_logic_vector(0 to 4);
        dcdSpAddrEn     : in     vl_logic;
        exeRS           : in     vl_logic_vector(0 to 4);
        exeRSEqlwbLpAddr: in     vl_logic;
        exeRSEqwbRpAddr : in     vl_logic;
        preDcdRSRT      : in     vl_logic_vector(0 to 9);
        preExeRS        : in     vl_logic_vector(0 to 9);
        rdEn            : in     vl_logic;
        sPortSelInc     : in     vl_logic;
        dcdSpMuxSel     : out    vl_logic
    );
end p405s_sPortMux;
