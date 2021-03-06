library verilog;
use verilog.vl_types.all;
entity p405s_dbgEqs is
    port(
        nxtExeIac1Event : out    vl_logic;
        nxtExeIac2Event : out    vl_logic;
        nxtExeIac3Event : out    vl_logic;
        nxtExeIac4Event : out    vl_logic;
        nxtDac1Rd       : out    vl_logic;
        nxtDac1Wr       : out    vl_logic;
        nxtDac2Rd       : out    vl_logic;
        nxtDac2Wr       : out    vl_logic;
        nxtDvc1Rd       : out    vl_logic;
        nxtDvc1Wr       : out    vl_logic;
        nxtDvc2Rd       : out    vl_logic;
        nxtDvc2Wr       : out    vl_logic;
        nxtDbsrSummaryBit: out    vl_logic;
        nxtHwIac12X     : out    vl_logic;
        nxtHwIac34X     : out    vl_logic;
        dbcr0_XE2       : out    vl_logic;
        iacCntlE1       : out    vl_logic;
        iacCntlE2       : out    vl_logic;
        iacCntlSel      : out    vl_logic;
        dacCntlE1       : out    vl_logic;
        dacCntlE2       : out    vl_logic;
        dvcCntlE2       : out    vl_logic;
        DBG_exeSuppress : out    vl_logic;
        DBG_wbDacSuppress: out    vl_logic;
        DBG_exeIacSuppress: out    vl_logic;
        DBG_icmpEn      : out    vl_logic;
        DBG_stopReq     : out    vl_logic;
        DBG_weakStopReq : out    vl_logic;
        DBG_intrp       : out    vl_logic;
        DBG_freezeTimers: out    vl_logic;
        DBG_trapEnQ     : out    vl_logic;
        DBG_udeIntrp    : out    vl_logic;
        DBG_dacEn       : out    vl_logic;
        DBG_rstCoreReq  : out    vl_logic;
        DBG_rstChipReq  : out    vl_logic;
        DBG_rstSystemReq: out    vl_logic;
        DBG_iacEn       : out    vl_logic;
        DBG_dvcRdEn     : out    vl_logic;
        DBG_dvcWrEn     : out    vl_logic;
        DBG_eventSet    : out    vl_logic;
        DBG_exeTE       : out    vl_logic_vector(0 to 4);
        DBG_wbTE        : out    vl_logic_vector(0 to 4);
        DBG_immdTE      : out    vl_logic_vector(0 to 2);
        DBG_dacIntrp    : out    vl_logic;
        nxtDbsrGroup0   : out    vl_logic_vector(0 to 10);
        nxtDbsrGroup1   : out    vl_logic_vector(0 to 1);
        nxtDbsrGroup2   : out    vl_logic;
        nxtDbsrGroup3   : out    vl_logic_vector(0 to 1);
        dbsrE2          : out    vl_logic;
        dbcrE1          : out    vl_logic;
        dbcr0E2         : out    vl_logic;
        dbcr1E2         : out    vl_logic;
        sprBusSel       : out    vl_logic_vector(0 to 1);
        exeMtdbcr0      : out    vl_logic;
        IFB_iac1GtIar   : in     vl_logic;
        IFB_iac1BitsEq  : in     vl_logic;
        IFB_iac2GtIar   : in     vl_logic;
        IFB_iac2BitsEq  : in     vl_logic;
        IFB_iac3GtIar   : in     vl_logic;
        IFB_iac3BitsEq  : in     vl_logic;
        IFB_iac4GtIar   : in     vl_logic;
        IFB_iac4BitsEq  : in     vl_logic;
        IFB_stuffStL2   : in     vl_logic;
        IFB_exeDbgBrTaken: in     vl_logic;
        IFB_exeFlush    : in     vl_logic;
        IFB_exeClear    : in     vl_logic;
        IFB_dcdFullL2   : in     vl_logic;
        IFB_exeFullL2   : in     vl_logic;
        IFB_exeDisableDbL2: in     vl_logic;
        IFB_wbDisableDbL2: in     vl_logic;
        EXE_dvc1ByteCmp : in     vl_logic_vector(0 to 3);
        EXE_dac1Bits0to26Eq: in     vl_logic;
        EXE_dac1Bits27to29Eq: in     vl_logic;
        EXE_dac1Bits30Eq: in     vl_logic;
        EXE_dac1Bits31Eq: in     vl_logic;
        EXE_dac1GtDsEa  : in     vl_logic;
        EXE_dvc2ByteCmp : in     vl_logic_vector(0 to 3);
        EXE_dac2Bits0to26Eq: in     vl_logic;
        EXE_dac2Bits27to29Eq: in     vl_logic;
        EXE_dac2Bits30Eq: in     vl_logic;
        EXE_dac2Bits31Eq: in     vl_logic;
        EXE_dac2GtDsEa  : in     vl_logic;
        EXE_dbgSprDcds  : in     vl_logic_vector(0 to 3);
        EXE_sprDataBus  : in     vl_logic_vector(0 to 31);
        PCL_exeDbgRdOp  : in     vl_logic;
        PCL_exeDbgWrOp  : in     vl_logic;
        PCL_wbDbgIcmp   : in     vl_logic;
        PCL_dvcCmpEn    : in     vl_logic;
        PCL_mtSPR       : in     vl_logic;
        PCL_exeDvcHold  : in     vl_logic;
        PCL_exeTrap     : in     vl_logic;
        PCL_sprHold     : in     vl_logic;
        PCL_exeIarHold  : in     vl_logic;
        PCL_wbHold      : in     vl_logic;
        PCL_wbFull      : in     vl_logic;
        PCL_exeDbgLdOp  : in     vl_logic;
        PCL_exeDbgStOp  : in     vl_logic;
        VCT_msrDE       : in     vl_logic;
        VCT_msrDWE      : in     vl_logic;
        VCT_wbFlush     : in     vl_logic;
        VCT_wbErrSuppress: in     vl_logic;
        VCT_swapQ01     : in     vl_logic;
        VCT_swapQ23     : in     vl_logic;
        JTG_dbgWaitEn   : in     vl_logic;
        VCT_exeBrTrapErrSuppress: in     vl_logic;
        JTG_uncondEvent : in     vl_logic;
        JTG_dbdrPulse   : in     vl_logic;
        JTG_resetDBSR   : in     vl_logic;
        XXX_uncondEvent : in     vl_logic;
        coreResetL2     : in     vl_logic;
        intDbMode       : in     vl_logic;
        extDbMode       : in     vl_logic;
        enIcmpL2        : in     vl_logic;
        enBrTakenL2     : in     vl_logic;
        enTrapL2        : in     vl_logic;
        enIac1L2        : in     vl_logic;
        enIac2L2        : in     vl_logic;
        enIac12RangeL2  : in     vl_logic;
        enIac12XRangeL2 : in     vl_logic;
        enIac3L2        : in     vl_logic;
        enIac4L2        : in     vl_logic;
        enIac34RangeL2  : in     vl_logic;
        enIac34XRangeL2 : in     vl_logic;
        enIac12XToggleL2: in     vl_logic;
        enIac34XToggleL2: in     vl_logic;
        exeIac1EventL2  : in     vl_logic;
        exeIac2EventL2  : in     vl_logic;
        exeIac3EventL2  : in     vl_logic;
        exeIac4EventL2  : in     vl_logic;
        enDac1RdL2      : in     vl_logic;
        enDac1WrL2      : in     vl_logic;
        dac1SizeL2      : in     vl_logic_vector(0 to 1);
        enDac2RdL2      : in     vl_logic;
        enDac2WrL2      : in     vl_logic;
        dac2SizeL2      : in     vl_logic_vector(0 to 1);
        enDacRangeL2    : in     vl_logic;
        enDacXRangeL2   : in     vl_logic;
        dvc1ModeL2      : in     vl_logic_vector(0 to 1);
        dvc1BEL2        : in     vl_logic_vector(0 to 3);
        dvc2ModeL2      : in     vl_logic_vector(0 to 1);
        dvc2BEL2        : in     vl_logic_vector(0 to 3);
        dac1RdL2        : in     vl_logic;
        dac1WrL2        : in     vl_logic;
        dac2RdL2        : in     vl_logic;
        dac2WrL2        : in     vl_logic;
        dvc1RdL2        : in     vl_logic;
        dvc1WrL2        : in     vl_logic;
        dvc2RdL2        : in     vl_logic;
        dvc2WrL2        : in     vl_logic;
        dbsrGroup0      : in     vl_logic_vector(0 to 10);
        enExcL2         : in     vl_logic;
        dbsrGroup1      : in     vl_logic_vector(0 to 1);
        dbsrGroup2      : in     vl_logic;
        chipResetL2     : in     vl_logic;
        systemResetL2   : in     vl_logic;
        dbsrGroup3      : in     vl_logic_vector(0 to 1);
        dbsrSummaryBit  : in     vl_logic;
        enFreezeTimersL2: in     vl_logic;
        dbcrReset_0     : in     vl_logic;
        dbcrReset_1     : in     vl_logic;
        PCL_exeDvcOrParityHold: in     vl_logic
    );
end p405s_dbgEqs;
