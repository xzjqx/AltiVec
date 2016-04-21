library verilog;
use verilog.vl_types.all;
entity p405s_condReg is
    port(
        crL2            : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        EXE_cc          : in     vl_logic_vector(0 to 3);
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        EXE_xer         : in     vl_logic_vector(0 to 2);
        MMU_tlbSXHit    : in     vl_logic;
        PCL_Rbit        : in     vl_logic;
        PCL_exeHoldForCr: in     vl_logic;
        coreResetL2     : in     vl_logic;
        exe2Cr0EnL2     : in     vl_logic;
        exeCr0EnL2      : in     vl_logic;
        exeCrAndL2      : in     vl_logic;
        exeCrBfEnL2     : in     vl_logic;
        exeCrNegBBL2    : in     vl_logic;
        exeCrNegBTL2    : in     vl_logic;
        exeCrOrL2       : in     vl_logic;
        exeCrXorL2      : in     vl_logic;
        exeDataL2       : in     vl_logic_vector(6 to 20);
        exeFlush        : in     vl_logic;
        exeMcrfL2       : in     vl_logic;
        exeMcrxrL2      : in     vl_logic;
        exeMtcrfL2      : in     vl_logic;
        exeOpForExe2L2  : in     vl_logic;
        exeStwcxL2      : in     vl_logic;
        exeTlbsxL2      : in     vl_logic
    );
end p405s_condReg;
