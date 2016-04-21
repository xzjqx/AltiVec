library verilog;
use verilog.vl_types.all;
entity p405s_dcdBrCondFlow is
    port(
        dcdCondOK       : out    vl_logic;
        dcdTarget_Neg   : out    vl_logic;
        crL2            : in     vl_logic_vector(0 to 31);
        dcdCtrEq0       : in     vl_logic;
        dcdDataBI       : in     vl_logic_vector(0 to 4);
        dcdDataBO       : in     vl_logic_vector(0 to 3);
        dcdFirstCycleL2 : in     vl_logic;
        dcdFullL2       : in     vl_logic;
        dcdPfb0BranchL2 : in     vl_logic;
        dcdPlaB         : in     vl_logic;
        dcdPlaBc        : in     vl_logic;
        dcdPredict      : in     vl_logic;
        dcdPrediction   : in     vl_logic
    );
end p405s_dcdBrCondFlow;
