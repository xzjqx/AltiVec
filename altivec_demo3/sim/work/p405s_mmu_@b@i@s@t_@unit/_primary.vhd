library verilog;
use verilog.vl_types.all;
entity p405s_mmu_BIST_Unit is
    port(
        ABIST_test      : out    vl_logic;
        BIST_DSize      : out    vl_logic_vector(0 to 6);
        BIST_DT         : out    vl_logic;
        BIST_TID        : out    vl_logic_vector(0 to 7);
        BIST_V          : out    vl_logic;
        BIST_addr       : out    vl_logic_vector(0 to 5);
        BIST_data       : out    vl_logic_vector(0 to 1);
        BIST_epn_ea     : out    vl_logic_vector(0 to 21);
        BIST_invalidate : out    vl_logic;
        BIST_lookupEn   : out    vl_logic;
        BIST_rdEn       : out    vl_logic;
        BIST_wrEn       : out    vl_logic;
        MMU_diagOut     : out    vl_logic_vector(0 to 1);
        cbistError      : out    vl_logic;
        DVS             : out    vl_logic;
        LSSD_ArrayCClk_buf: out    vl_logic;
        LSSD_TestM3_buf : out    vl_logic;
        BIST_Done       : out    vl_logic;
        CB              : in     vl_logic;
        resetL2         : in     vl_logic;
        LSSD_TestM1     : in     vl_logic;
        UTLB_Miss       : in     vl_logic;
        BISTCE0STCLK    : in     vl_logic;
        BISTCE1ENABLE   : in     vl_logic;
        LSSD_BISTCClk   : in     vl_logic;
        UTLB_index      : in     vl_logic_vector(0 to 5);
        dataComp        : in     vl_logic;
        tagComp         : in     vl_logic;
        cbistErrL2      : out    vl_logic;
        dataErrL2       : out    vl_logic;
        tagErrL2        : out    vl_logic;
        LSSD_EVS        : in     vl_logic;
        LSSD_TestM3     : in     vl_logic
    );
end p405s_mmu_BIST_Unit;
