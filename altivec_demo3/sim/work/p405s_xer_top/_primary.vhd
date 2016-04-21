library verilog;
use verilog.vl_types.all;
entity p405s_xer_top is
    port(
        EXE_cc          : out    vl_logic_vector(0 to 3);
        EXE_xer         : out    vl_logic_vector(0 to 2);
        EXE_xerTBC      : out    vl_logic_vector(0 to 6);
        EXE_xerTBCNotEqZero: out    vl_logic;
        nxtXerCa        : out    vl_logic;
        rRegBypassMuxSel: out    vl_logic_vector(0 to 1);
        APU_exeCa       : in     vl_logic;
        APU_exeOv       : in     vl_logic;
        CB              : in     vl_logic;
        PCL_exeLogicalUnitEnForLSSD: in     vl_logic;
        APU_exeCr       : in     vl_logic_vector(0 to 3);
        PCL_exeMcrxr    : in     vl_logic;
        PCL_exeMtspr    : in     vl_logic;
        PCL_exeSprUnitEn_NEG: in     vl_logic;
        PCL_exeSrmUnitEnForLSSD: in     vl_logic;
        PCL_exeXerCaEn  : in     vl_logic;
        PCL_exeXerOvEn  : in     vl_logic;
        PCL_xerL2Hold   : in     vl_logic;
        addCA           : in     vl_logic;
        addOV           : in     vl_logic;
        addUnitEn       : in     vl_logic;
        admCcBits       : in     vl_logic_vector(0 to 2);
        resetL2         : in     vl_logic;
        divOV           : in     vl_logic;
        dlmzb           : in     vl_logic;
        logicalCcBits   : in     vl_logic_vector(0 to 2);
        lsaOut          : in     vl_logic_vector(28 to 31);
        multOV          : in     vl_logic;
        sprBusIn        : in     vl_logic_vector(0 to 31);
        srmCA           : in     vl_logic;
        xerDcd          : in     vl_logic;
        EXE_xerTBCIn    : out    vl_logic_vector(0 to 6);
        srmCcBits       : in     vl_logic_vector(0 to 2);
        PCL_exe2XerOvEn : in     vl_logic;
        exeResultMuxSel : out    vl_logic_vector(0 to 1);
        PCL_exeEaCalc   : in     vl_logic;
        divNxtToLastSt  : in     vl_logic;
        macOV           : in     vl_logic;
        multHiEOAnsCc   : in     vl_logic_vector(0 to 2);
        multLo4CycAnsCc : in     vl_logic_vector(0 to 2);
        multLo5CycAnsCc : in     vl_logic_vector(0 to 2);
        admCcMuxSel     : in     vl_logic_vector(0 to 1);
        IFB_exeOpForExe2L2: in     vl_logic;
        PCL_exeFpuOp    : in     vl_logic;
        PCL_exeApuValidOp: in     vl_logic
    );
end p405s_xer_top;
