library verilog;
use verilog.vl_types.all;
entity p405s_exe_gpr is
    port(
        aPort           : out    vl_logic_vector(0 to 31);
        bPort           : out    vl_logic_vector(0 to 31);
        sPort           : out    vl_logic_vector(0 to 31);
        lPort           : in     vl_logic_vector(0 to 31);
        rPort           : in     vl_logic_vector(0 to 31);
        ApAddr          : in     vl_logic_vector(0 to 9);
        BpAddr          : in     vl_logic_vector(0 to 9);
        SpAddr          : in     vl_logic_vector(0 to 9);
        LpAddr          : in     vl_logic_vector(0 to 4);
        LpWE            : in     vl_logic;
        RpAddr          : in     vl_logic_vector(0 to 4);
        RpWE            : in     vl_logic;
        LpEqAp          : in     vl_logic;
        LpEqBp          : in     vl_logic;
        LpEqSp          : in     vl_logic;
        RpEqAp          : in     vl_logic;
        RpEqBp          : in     vl_logic;
        RpEqSp          : in     vl_logic;
        BpEqSp          : in     vl_logic;
        SysClk          : in     vl_logic;
        EXE_gprRen      : in     vl_logic;
        EXE_gprSysClkPI : in     vl_logic
    );
end p405s_exe_gpr;
