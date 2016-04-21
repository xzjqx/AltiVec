library verilog;
use verilog.vl_types.all;
entity p405s_storageCountCntl is
    port(
        apuLdStGtEq4    : out    vl_logic;
        cntMuxOutGtEq4  : out    vl_logic;
        xerTbcGtEq4     : out    vl_logic;
        xerTbcInGtEq4   : out    vl_logic;
        multCnt         : out    vl_logic_vector(0 to 5);
        stringImmdEq32  : out    vl_logic;
        cntMuxSel       : out    vl_logic_vector(0 to 1);
        countRegMuxSel  : out    vl_logic_vector(0 to 1);
        dcdMultiple     : in     vl_logic;
        dcdNB           : in     vl_logic_vector(0 to 4);
        dcdRSRT         : in     vl_logic_vector(0 to 4);
        dcdStringImmediate: in     vl_logic;
        dcdStringIndexed: in     vl_logic;
        exeXerTBCUpdInstr: in     vl_logic;
        strgEnd         : in     vl_logic;
        APU_dcdLdStWd   : in     vl_logic;
        APU_dcdLdStDw   : in     vl_logic;
        cntMuxOut       : in     vl_logic_vector(0 to 5);
        EXE_xerTBC      : in     vl_logic_vector(0 to 4);
        EXE_xerTBCIn    : in     vl_logic_vector(0 to 4);
        plaVal          : in     vl_logic;
        APU_dcdLdStQw   : in     vl_logic;
        plaApuLdSt      : in     vl_logic;
        exeForceAlgn    : in     vl_logic;
        byteCount       : in     vl_logic_vector(0 to 7);
        exeStrgStC0     : in     vl_logic;
        PCL_exeEaQwEn   : out    vl_logic_vector(0 to 3)
    );
end p405s_storageCountCntl;
