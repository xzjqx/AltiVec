library verilog;
use verilog.vl_types.all;
entity p405s_dbg_top is
    port(
        DBG_dacEn       : out    vl_logic;
        DBG_dacIntrp    : out    vl_logic;
        DBG_dvcRdEn     : out    vl_logic;
        DBG_dvcWrEn     : out    vl_logic;
        DBG_eventSet    : out    vl_logic;
        DBG_exeIacSuppress: out    vl_logic;
        DBG_exeSuppress : out    vl_logic;
        DBG_exeTE       : out    vl_logic_vector(0 to 4);
        DBG_freezeTimers: out    vl_logic;
        DBG_iacEn       : out    vl_logic;
        DBG_icmpEn      : out    vl_logic;
        DBG_immdTE      : out    vl_logic_vector(0 to 2);
        DBG_intrp       : out    vl_logic;
        DBG_rstChipReq  : out    vl_logic;
        DBG_rstCoreReq  : out    vl_logic;
        DBG_rstSystemReq: out    vl_logic;
        DBG_sprDataBus  : out    vl_logic_vector(0 to 31);
        DBG_stopReq     : out    vl_logic;
        DBG_trapEnQ     : out    vl_logic;
        DBG_udeEventSet : out    vl_logic;
        DBG_udeIntrp    : out    vl_logic;
        DBG_wbDacSuppress: out    vl_logic;
        DBG_wbTE        : out    vl_logic_vector(0 to 4);
        DBG_weakStopReq : out    vl_logic;
        CB              : in     vl_logic;
        EXE_dac1Bits0to26Eq: in     vl_logic;
        EXE_dac1Bits27to29Eq: in     vl_logic;
        EXE_dac1Bits30Eq: in     vl_logic;
        EXE_dac1Bits31Eq: in     vl_logic;
        EXE_dac1GtDsEa  : in     vl_logic;
        EXE_dac2Bits0to26Eq: in     vl_logic;
        EXE_dac2Bits27to29Eq: in     vl_logic;
        EXE_dac2Bits30Eq: in     vl_logic;
        EXE_dac2Bits31Eq: in     vl_logic;
        EXE_dac2GtDsEa  : in     vl_logic;
        EXE_dbgSprDcds  : in     vl_logic_vector(0 to 3);
        EXE_dvc1ByteCmp : in     vl_logic_vector(0 to 3);
        EXE_dvc2ByteCmp : in     vl_logic_vector(0 to 3);
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        IFB_dcdFullL2   : in     vl_logic;
        IFB_exeBrTaken  : in     vl_logic;
        IFB_exeClear    : in     vl_logic;
        IFB_exeDisableDbL2: in     vl_logic;
        IFB_exeFlush    : in     vl_logic;
        IFB_exeFullL2   : in     vl_logic;
        IFB_iac1BitsEq  : in     vl_logic;
        IFB_iac1GtIar   : in     vl_logic;
        IFB_iac2BitsEq  : in     vl_logic;
        IFB_iac2GtIar   : in     vl_logic;
        IFB_iac3BitsEq  : in     vl_logic;
        IFB_iac3GtIar   : in     vl_logic;
        IFB_iac4BitsEq  : in     vl_logic;
        IFB_iac4GtIar   : in     vl_logic;
        IFB_stuffStL2   : in     vl_logic;
        IFB_wbDisableDbL2: in     vl_logic;
        JTG_dbdrPulse   : in     vl_logic;
        JTG_dbgWaitEn   : in     vl_logic;
        JTG_resetDBSR   : in     vl_logic;
        JTG_uncondEvent : in     vl_logic;
        PCL_dvcCmpEn    : in     vl_logic;
        PCL_exeDbgLdOp  : in     vl_logic;
        PCL_exeDbgRdOp  : in     vl_logic;
        PCL_exeDbgStOp  : in     vl_logic;
        PCL_exeDbgWrOp  : in     vl_logic;
        PCL_exeDvcHold  : in     vl_logic;
        PCL_exeIarHold  : in     vl_logic;
        PCL_exeTrap     : in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        PCL_wbClearOrFlush: in     vl_logic;
        PCL_wbDbgIcmp   : in     vl_logic;
        PCL_wbFull      : in     vl_logic;
        PCL_wbHold      : in     vl_logic;
        VCT_exeBrTrapErrSuppress: in     vl_logic;
        VCT_msrDE       : in     vl_logic;
        VCT_msrDWE      : in     vl_logic;
        VCT_swapQ01     : in     vl_logic;
        VCT_swapQ23     : in     vl_logic;
        VCT_wbErrSuppress: in     vl_logic;
        VCT_wbFlush     : in     vl_logic;
        XXX_uncondEvent : in     vl_logic;
        chipReset       : in     vl_logic;
        coreReset       : in     vl_logic;
        systemReset     : in     vl_logic;
        PCL_exeDvcOrParityHold: in     vl_logic
    );
end p405s_dbg_top;
