library verilog;
use verilog.vl_types.all;
entity p405s_JTG_functional is
    port(
        BypassTDO       : in     vl_logic;
        CaptureDRmeta   : in     vl_logic_vector(0 to 1);
        sysReset        : in     vl_logic;
        CurrentStateL2  : in     vl_logic_vector(0 to 7);
        DataValidBit    : in     vl_logic;
        DBG_resetChip   : in     vl_logic;
        DBG_resetSystem : in     vl_logic;
        PCL_jtgSprDcd   : in     vl_logic;
        IFB_stopAck     : in     vl_logic;
        IFB_rstStepPend : in     vl_logic;
        IFB_rstStuffPend: in     vl_logic;
        InstRegOutL1    : in     vl_logic_vector(0 to 3);
        InstRegOutL2    : in     vl_logic_vector(0 to 3);
        InstRegTDO      : in     vl_logic;
        InstShiftRegOut : in     vl_logic_vector(0 to 2);
        JDCRstopProc    : in     vl_logic;
        JDCRblockFold   : in     vl_logic;
        JDCRstepPulse   : in     vl_logic;
        JDCRreset0      : in     vl_logic;
        JTG_dbgWaitEn   : in     vl_logic;
        JDCRreset1      : in     vl_logic;
        JDCRinstRegDiagDcdEn: in     vl_logic;
        JTG_uncondEvent : in     vl_logic;
        JTG_freezeTimers: in     vl_logic;
        JTG_resetDBSR   : in     vl_logic;
        pgmOut          : in     vl_logic;
        JTGEX_BndScanTDO: in     vl_logic;
        JTGEX_TDI       : in     vl_logic;
        JTGEX_TMS       : in     vl_logic;
        JTGEX_TRST_NEG  : in     vl_logic;
        MultiUse_31     : in     vl_logic;
        MultiUse_2      : in     vl_logic;
        JTG_step        : in     vl_logic;
        JTG_stuff       : in     vl_logic;
        coreReset       : in     vl_logic;
        DBG_resetCore   : in     vl_logic;
        PCL_exeMfspr    : in     vl_logic;
        PCL_exeMtspr    : in     vl_logic;
        PCL_exeSprHold  : in     vl_logic;
        ShiftDRL1       : in     vl_logic;
        TIM_wdSysRst    : in     vl_logic;
        TIM_wdChipRst   : in     vl_logic;
        TIM_wdCoreRst   : in     vl_logic;
        ShiftIRL1       : in     vl_logic;
        overrun         : in     vl_logic;
        UpdateDRmeta    : in     vl_logic_vector(0 to 2);
        jtgHalt         : in     vl_logic;
        VCT_stuffStepSup: in     vl_logic;
        BypassRegE1     : out    vl_logic;
        BypassRegIn     : out    vl_logic;
        CaptureDRSync0  : out    vl_logic;
        CntlRegAsyncReset: out    vl_logic;
        diagMuxSel      : out    vl_logic_vector(0 to 1);
        DataRegE1       : out    vl_logic;
        DataRegE2       : out    vl_logic;
        DataRegMuxSel   : out    vl_logic;
        InstBufferE2    : out    vl_logic;
        InstRegAsyncSet : out    vl_logic;
        InstShiftRegE1  : out    vl_logic;
        InstRegL1E1     : out    vl_logic;
        InstRegL2E1     : out    vl_logic;
        InstRegIn       : out    vl_logic_vector(0 to 3);
        InstShiftRegIn  : out    vl_logic_vector(0 to 3);
        JDCRE1          : out    vl_logic;
        JDCRMuxSel      : out    vl_logic;
        JDCRMuxIn       : out    vl_logic_vector(0 to 7);
        capDataReg      : out    vl_logic;
        extest          : out    vl_logic;
        resetChipReq    : out    vl_logic;
        resetCoreReq    : out    vl_logic;
        resetSystemReq  : out    vl_logic;
        jtgShiftDR      : out    vl_logic;
        JTG_stopReq     : out    vl_logic;
        tdoEnable       : out    vl_logic;
        jtgUpdateDR     : out    vl_logic;
        MultiUseRegInMuxSel: out    vl_logic;
        MultiUseRegE1   : out    vl_logic;
        NextCacheWr     : out    vl_logic;
        NextDBDRpulse   : out    vl_logic;
        NextState       : out    vl_logic_vector(0 to 7);
        NextStep        : out    vl_logic;
        NextStuff       : out    vl_logic;
        SPRorDataMuxSel : out    vl_logic;
        NextOverrun     : out    vl_logic;
        TDOIn           : out    vl_logic;
        JTG_stepUPD     : out    vl_logic;
        JTG_stuffUPD    : out    vl_logic
    );
end p405s_JTG_functional;
