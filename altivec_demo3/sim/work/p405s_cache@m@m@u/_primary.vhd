library verilog;
use verilog.vl_types.all;
entity p405s_cacheMMU is
    port(
        CAR_cacheable   : out    vl_logic;
        CAR_endian      : out    vl_logic;
        DCU_ABus        : out    vl_logic_vector(0 to 31);
        DCU_CA          : out    vl_logic;
        DCU_DA          : out    vl_logic;
        DCU_DBus        : out    vl_logic_vector(0 to 63);
        DCU_RNW         : out    vl_logic;
        DCU_SCL2        : out    vl_logic;
        DCU_SDQ_mod     : out    vl_logic_vector(0 to 31);
        C405_lssdDiagBistDone: out    vl_logic;
        DCU_abort       : out    vl_logic;
        DCU_apuWbByteEn : out    vl_logic_vector(0 to 3);
        DCU_cacheable   : out    vl_logic;
        DCU_carByteEn   : out    vl_logic_vector(0 to 3);
        DCU_dTags       : out    vl_logic_vector(0 to 7);
        DCU_data_NEG    : out    vl_logic_vector(0 to 31);
        DCU_diagBus     : out    vl_logic_vector(0 to 20);
        DCU_firstCycCarStXltV: out    vl_logic;
        DCU_guarded     : out    vl_logic;
        DCU_kompress    : out    vl_logic;
        DCU_ocmAbort    : out    vl_logic;
        DCU_ocmData     : out    vl_logic_vector(0 to 31);
        DCU_ocmLoadReq  : out    vl_logic;
        DCU_ocmStoreReq : out    vl_logic;
        DCU_ocmWait     : out    vl_logic;
        DCU_parityError : out    vl_logic;
        DCU_FlushParityError: out    vl_logic;
        DCU_pclOcmWait  : out    vl_logic;
        DCU_plbPriority : out    vl_logic_vector(0 to 1);
        DCU_request     : out    vl_logic;
        DCU_sleepReq    : out    vl_logic;
        DCU_tranSize    : out    vl_logic;
        DCU_writeThru   : out    vl_logic;
        ICU_ABus        : out    vl_logic_vector(0 to 29);
        ICU_EO          : out    vl_logic_vector(0 to 1);
        ICU_GPRC        : out    vl_logic;
        ICU_LDBE        : out    vl_logic;
        ICU_abort       : out    vl_logic;
        ICU_cacheable   : out    vl_logic;
        ICU_diagBus     : out    vl_logic_vector(0 to 22);
        ICU_dsCA        : out    vl_logic;
        ICU_ifbError    : out    vl_logic_vector(0 to 1);
        ICU_isBus       : out    vl_logic_vector(0 to 63);
        ICU_isCA        : out    vl_logic;
        ICU_ocmIcuReady : out    vl_logic;
        ICU_ocmReqPending: out    vl_logic;
        ICU_parityErrE  : out    vl_logic;
        ICU_parityErrO  : out    vl_logic;
        ICU_tagParityErr: out    vl_logic;
        ICU_CCR0DPP     : out    vl_logic;
        ICU_CCR0DPE     : out    vl_logic;
        ICU_CCR0IPE     : out    vl_logic;
        ICU_CCR0TPE     : out    vl_logic;
        ICU_plbPriority : out    vl_logic_vector(0 to 1);
        ICU_plbU0Attr   : out    vl_logic;
        ICU_request     : out    vl_logic;
        ICU_sleepReq    : out    vl_logic;
        ICU_sprData     : out    vl_logic_vector(0 to 31);
        ICU_syncAfterReset: out    vl_logic;
        ICU_traceEnable : out    vl_logic;
        ICU_tranSize    : out    vl_logic_vector(2 to 3);
        LSSD_cacheMMUScanOut: out    vl_logic_vector(0 to 9);
        MMU_BMCO        : out    vl_logic;
        MMU_apuWbEndian : out    vl_logic;
        MMU_dsStateBorC : out    vl_logic;
        MMU_dsStatus    : out    vl_logic_vector(0 to 7);
        MMU_dsocmABus   : out    vl_logic_vector(0 to 29);
        MMU_dsocmCacheable: out    vl_logic;
        MMU_dsocmGuarded: out    vl_logic;
        MMU_dsocmU0Attr : out    vl_logic;
        MMU_dsocmXltValid: out    vl_logic;
        MMU_isStatus    : out    vl_logic_vector(0 to 1);
        MMU_isocmCacheable: out    vl_logic;
        MMU_isocmU0Attr : out    vl_logic;
        MMU_isocmXltValid: out    vl_logic;
        MMU_sprData     : out    vl_logic_vector(0 to 31);
        MMU_tlbSXHit    : out    vl_logic;
        MMU_wbHold      : out    vl_logic;
        CB              : in     vl_logic;
        EXE_dcuData     : in     vl_logic_vector(0 to 31);
        MMU_tlbREParityErr: out    vl_logic;
        MMU_tlbSXParityErr: out    vl_logic;
        MMU_dsParityErr : out    vl_logic;
        MMU_isParityErr : out    vl_logic;
        EXE_dsEA_NEG    : in     vl_logic_vector(0 to 31);
        EXE_dsEaCP      : in     vl_logic_vector(0 to 7);
        EXE_eaARegBuf   : in     vl_logic_vector(0 to 21);
        EXE_eaBRegBuf   : in     vl_logic_vector(0 to 21);
        EXE_icuSprDcds  : in     vl_logic_vector(0 to 2);
        EXE_mmuIcuSprData: in     vl_logic_vector(0 to 31);
        EXE_sprAddr     : in     vl_logic_vector(4 to 9);
        IFB_cntxSync    : in     vl_logic;
        IFB_exeFlush    : in     vl_logic;
        IFB_fetchReq    : in     vl_logic;
        IFB_icuCancelData: in     vl_logic;
        IFB_isAbortForICU: in     vl_logic_vector(0 to 2);
        IFB_isAbortForMMU: in     vl_logic;
        IFB_isEA        : in     vl_logic_vector(0 to 29);
        IFB_isNL        : in     vl_logic;
        IFB_isNP        : in     vl_logic;
        IFB_ldNotSt     : in     vl_logic;
        IFB_nonSpecAcc  : in     vl_logic;
        JTG_iCacheWr    : in     vl_logic;
        JTG_instBuf     : in     vl_logic_vector(0 to 31);
        LSSD_bistCClk   : in     vl_logic;
        LSSD_cacheMMUScanIn: in     vl_logic_vector(0 to 9);
        LSSD_coreTestEn : in     vl_logic;
        LSSD_testM1     : in     vl_logic;
        LSSD_testM3     : in     vl_logic;
        OCM_dsComplete  : in     vl_logic;
        OCM_dsHold      : in     vl_logic;
        OCM_isDATA      : in     vl_logic_vector(0 to 63);
        OCM_isDValid    : in     vl_logic_vector(0 to 1);
        OCM_isHold      : in     vl_logic;
        PCL_dcuByteEn   : in     vl_logic_vector(0 to 3);
        PCL_dcuOp       : in     vl_logic_vector(0 to 11);
        PCL_dcuOp_early : in     vl_logic_vector(0 to 2);
        PCL_dsMmuOp     : in     vl_logic_vector(0 to 3);
        PCL_exeAbort    : in     vl_logic;
        PCL_exeStorageOp: in     vl_logic;
        PCL_exeTlbOp    : in     vl_logic;
        PCL_icuOp       : in     vl_logic_vector(0 to 3);
        PCL_mfSPR       : in     vl_logic;
        PCL_mmuExeAbort : in     vl_logic;
        PCL_mmuIcuSprHold: in     vl_logic;
        PCL_mmuSprDcd   : in     vl_logic_vector(0 to 8);
        PCL_mtSPR       : in     vl_logic;
        PCL_stSteerCntl : in     vl_logic_vector(0 to 9);
        PCL_tlbRE       : in     vl_logic;
        PCL_tlbSX       : in     vl_logic;
        PCL_tlbWE       : in     vl_logic;
        PCL_tlbWS       : in     vl_logic;
        PCL_wbHoldNonErr: in     vl_logic;
        PCL_wbStorageOp : in     vl_logic;
        PLB_dcuAddrAck  : in     vl_logic;
        PLB_dcuBusy     : in     vl_logic;
        PLB_dcuRdDAck   : in     vl_logic;
        PLB_dcuRdDBus   : in     vl_logic_vector(0 to 63);
        PLB_dcuRdWdAddr : in     vl_logic_vector(0 to 2);
        PLB_dcuSsize    : in     vl_logic;
        PLB_dcuWrDAck   : in     vl_logic;
        PLB_icuAddrAck  : in     vl_logic;
        PLB_icuBusy     : in     vl_logic;
        PLB_icuDBus     : in     vl_logic_vector(0 to 63);
        PLB_icuError    : in     vl_logic;
        PLB_icuRdDAck   : in     vl_logic;
        PLB_icuRdWrAddr : in     vl_logic_vector(1 to 3);
        PLB_sSize       : in     vl_logic;
        PLB_sampleCycle : in     vl_logic;
        VCT_dcuWbAbort  : in     vl_logic;
        VCT_dearE2      : in     vl_logic;
        VCT_icuWbAbort  : in     vl_logic;
        VCT_mmuExeSuppress: in     vl_logic;
        VCT_mmuWbAbort  : in     vl_logic;
        VCT_msrDR       : in     vl_logic;
        VCT_msrIR       : in     vl_logic;
        VCT_msrPR       : in     vl_logic;
        resetCore       : in     vl_logic;
        BIST_pepsPF     : out    vl_logic_vector(0 to 2);
        LSSD_c405CE0EVS : in     vl_logic;
        LSSD_c405BistCE0StClk: in     vl_logic;
        LSSD_c405BistCE1Enable: in     vl_logic;
        PLB_sampleCycleAlt: in     vl_logic;
        CPM_c405SyncBypass: in     vl_logic;
        testmode        : in     vl_logic;
        dcu_bist_debug_si: in     vl_logic_vector(3 downto 0);
        dcu_bist_debug_so: out    vl_logic_vector(3 downto 0);
        dcu_bist_debug_en: in     vl_logic_vector(3 downto 0);
        dcu_bist_mode_reg_in: in     vl_logic_vector(18 downto 0);
        dcu_bist_mode_reg_out: out    vl_logic_vector(18 downto 0);
        dcu_bist_parallel_dr: in     vl_logic;
        dcu_bist_mode_reg_si: in     vl_logic;
        dcu_bist_mode_reg_so: out    vl_logic;
        dcu_bist_shift_dr: in     vl_logic;
        dcu_bist_mbrun  : in     vl_logic;
        icu_bist_debug_si: in     vl_logic_vector(3 downto 0);
        icu_bist_debug_so: out    vl_logic_vector(3 downto 0);
        icu_bist_debug_en: in     vl_logic_vector(3 downto 0);
        icu_bist_mode_reg_in: in     vl_logic_vector(18 downto 0);
        icu_bist_mode_reg_out: out    vl_logic_vector(18 downto 0);
        icu_bist_parallel_dr: in     vl_logic;
        icu_bist_mode_reg_si: in     vl_logic;
        icu_bist_mode_reg_so: out    vl_logic;
        icu_bist_shift_dr: in     vl_logic;
        icu_bist_mbrun  : in     vl_logic
    );
end p405s_cacheMMU;
