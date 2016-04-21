library verilog;
use verilog.vl_types.all;
entity p405s_DCU_dataFlow is
    port(
        CAR_L2_buf1     : out    vl_logic_vector(27 to 29);
        CAR_L2_buf2     : out    vl_logic_vector(27 to 29);
        CAR_LSAcmp      : out    vl_logic;
        CAR_OF_L2       : out    vl_logic_vector(27 to 29);
        CAR_SAQcmp      : out    vl_logic;
        DCU_SDQ_mod_NEG : out    vl_logic_vector(0 to 31);
        DCU_data_NEG    : out    vl_logic_vector(0 to 31);
        DCU_icuSize     : out    vl_logic_vector(0 to 2);
        DCU_ocmData     : out    vl_logic_vector(0 to 31);
        DCU_plbABus     : out    vl_logic_vector(0 to 29);
        DCU_plbDBus     : out    vl_logic_vector(0 to 63);
        LRU             : out    vl_logic;
        LSA_L2          : out    vl_logic_vector(27 to 29);
        SAQ_FARcmp      : out    vl_logic;
        SAQ_L2          : out    vl_logic_vector(27 to 29);
        U0AttrFAR       : out    vl_logic;
        carOF_FARcmp    : out    vl_logic;
        carOF_LSAcmp    : out    vl_logic;
        dirtyA          : out    vl_logic;
        dirtyB          : out    vl_logic;
        hit_a           : out    vl_logic;
        hit_a_buf1      : out    vl_logic;
        hit_b           : out    vl_logic;
        hit_b_buf1      : out    vl_logic;
        validA          : out    vl_logic;
        validB          : out    vl_logic;
        DCU_parityError : out    vl_logic;
        CAR_OF_E1       : in     vl_logic;
        CAR_OF_E2       : in     vl_logic;
        CAR_endian      : in     vl_logic;
        CAR_mmuAttr_E1  : in     vl_logic;
        CAR_mmuAttr_E2  : in     vl_logic;
        CB              : in     vl_logic;
        EXE_dcuData     : in     vl_logic_vector(0 to 31);
        FAR_E2          : in     vl_logic;
        FDR_hiMuxSel    : in     vl_logic;
        FDR_hi_E1       : in     vl_logic;
        FDR_hi_E2       : in     vl_logic;
        FDR_holdMuxSel  : in     vl_logic;
        FDR_loMuxSel    : in     vl_logic;
        FDR_lo_E1       : in     vl_logic;
        FDR_lo_E2       : in     vl_logic;
        FDR_outMuxSel   : in     vl_logic_vector(0 to 1);
        ICU_dcuCCR0_L2_bit10: in     vl_logic;
        ICU_dcuCCR0_L2_bit11: in     vl_logic;
        LSA_E1          : in     vl_logic;
        LSA_E2          : in     vl_logic;
        MMU_diagOut     : in     vl_logic_vector(0 to 2);
        MMU_dsRA        : in     vl_logic_vector(0 to 29);
        PCL_stSteerCntl : in     vl_logic_vector(0 to 9);
        PLBAR_E1        : in     vl_logic;
        PLBAR_E2        : in     vl_logic;
        PLBAR_selFAR    : in     vl_logic;
        PLBAR_selSAQ    : in     vl_logic;
        PLBDR_E2        : in     vl_logic_vector(0 to 3);
        PLBDR_hiMuxSel  : in     vl_logic_vector(0 to 3);
        PLB_dcuReadDataBus: in     vl_logic_vector(0 to 63);
        SAQ_E1          : in     vl_logic;
        SAQ_E2          : in     vl_logic;
        SDP_FDR_muxSel  : in     vl_logic;
        SDQ_E1          : in     vl_logic;
        SDQ_E2          : in     vl_logic;
        SDQ_SDP_OCM_sel : in     vl_logic;
        SDQ_SDP_mux     : in     vl_logic;
        bypassFillSDP_sel: in     vl_logic_vector(0 to 3);
        bypassMuxSel    : in     vl_logic_vector(0 to 2);
        bypassPendOrDcRead: in     vl_logic;
        byteWriteData   : in     vl_logic_vector(0 to 15);
        byteWrite_E1    : in     vl_logic;
        cacheableSpecialOp: in     vl_logic;
        carStore        : in     vl_logic;
        dOutMuxSelBit1Byte0: in     vl_logic;
        dOutMuxSelBit1Byte1: in     vl_logic;
        dOutMuxSelBit1Byte2: in     vl_logic;
        dOutMuxSelBit1Byte3: in     vl_logic;
        dataIndexLSA_dupSel: in     vl_logic;
        dataIndexMuxSel2: in     vl_logic;
        dataIndexMuxSel : in     vl_logic_vector(0 to 1);
        dataIndex_E1    : in     vl_logic;
        dataIndex_E2    : in     vl_logic;
        dataReadNotWrite_In: in     vl_logic;
        dataReadWriteCycle_In: in     vl_logic;
        dirtyLRU_readIndexSel: in     vl_logic;
        dirtyLRU_readIndex_E1: in     vl_logic;
        dirtyLRU_readIndex_E2: in     vl_logic;
        dirtyLRU_writeIndex_E1: in     vl_logic;
        fillBufMuxSel0  : in     vl_logic_vector(0 to 31);
        fillBufMuxSel1  : in     vl_logic_vector(0 to 31);
        fillBuf_E1      : in     vl_logic;
        fillBuf_E2      : in     vl_logic_vector(0 to 7);
        fillUsingArray  : in     vl_logic;
        flushHold_E2    : in     vl_logic;
        forceDataIndexZero_mmu: in     vl_logic;
        loadReadFBvalid : in     vl_logic;
        newDirty        : in     vl_logic;
        newLRU          : in     vl_logic;
        newU0AttrIn     : in     vl_logic;
        newValidIn      : in     vl_logic;
        readLRUDirty    : in     vl_logic;
        sampleCycleL2   : in     vl_logic;
        tagIndexDup_E1  : in     vl_logic;
        tagIndexDup_E2  : in     vl_logic;
        tagIndexSel     : in     vl_logic;
        tagIndex_E1     : in     vl_logic;
        tagOutMuxSelFAR : in     vl_logic;
        tagReadNotWrite_In: in     vl_logic;
        tagReadWriteCycle_In: in     vl_logic;
        testEn          : in     vl_logic;
        writeBufHi_E1   : in     vl_logic;
        writeBufHi_E2   : in     vl_logic_vector(0 to 3);
        writeBufLoTag_E1: in     vl_logic;
        writeBufLo_E2   : in     vl_logic;
        writeBufMuxSelBit0: in     vl_logic;
        writeBufMuxSelBit1: in     vl_logic_vector(0 to 31);
        writeDataA0     : in     vl_logic;
        writeDataA1     : in     vl_logic;
        writeDataB0     : in     vl_logic;
        writeDataB1     : in     vl_logic;
        writeDirtyA     : in     vl_logic;
        writeDirtyB     : in     vl_logic;
        writeLRU        : in     vl_logic;
        writeTagA0      : in     vl_logic;
        writeTagA1      : in     vl_logic;
        writeTagB0      : in     vl_logic;
        writeTagB1      : in     vl_logic;
        xltValidLth     : in     vl_logic;
        carDcRead       : in     vl_logic;
        flushIdle_state : in     vl_logic;
        flushAlmostDone : in     vl_logic;
        flushDone       : in     vl_logic;
        fillFlushToDoL2 : in     vl_logic;
        resetCore       : in     vl_logic;
        DCU_DA          : in     vl_logic;
        DCU_FlushParityError: out    vl_logic;
        oneFPL2         : in     vl_logic;
        ocmCompleteXltVNoWaitNoHold: in     vl_logic;
        ICU_CCR1DCTE    : in     vl_logic;
        ICU_CCR1DCDE    : in     vl_logic;
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
        resetMemBist    : in     vl_logic
    );
end p405s_DCU_dataFlow;
