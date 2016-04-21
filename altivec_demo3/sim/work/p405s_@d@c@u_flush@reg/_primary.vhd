library verilog;
use verilog.vl_types.all;
entity p405s_DCU_flushReg is
    port(
        FDR_L2mux       : out    vl_logic_vector(0 to 63);
        CB              : in     vl_logic;
        FDR_hiMuxSel    : in     vl_logic;
        FDR_hi_E1       : in     vl_logic_vector(0 to 3);
        FDR_hi_E2       : in     vl_logic;
        FDR_holdMuxSel  : in     vl_logic_vector(0 to 3);
        FDR_loMuxSel    : in     vl_logic;
        FDR_lo_E1       : in     vl_logic_vector(0 to 3);
        FDR_lo_E2       : in     vl_logic;
        FDR_outMuxSel   : in     vl_logic_vector(0 to 1);
        dataOutPos_A    : in     vl_logic_vector(0 to 127);
        p_aSideErrorRaw : in     vl_logic;
        hit_a           : in     vl_logic;
        dataOutPos_B    : in     vl_logic_vector(0 to 127);
        p_bSideErrorRaw : in     vl_logic;
        hit_b           : in     vl_logic;
        flushIdle_state : in     vl_logic;
        flushAlmostDone : in     vl_logic;
        flushDone       : in     vl_logic;
        fillFlushToDoL2 : in     vl_logic;
        oneFPL2         : in     vl_logic;
        resetCore       : in     vl_logic;
        holdDataRegWord0_L2: in     vl_logic_vector(0 to 31);
        holdDataRegWord1_L2: in     vl_logic_vector(0 to 31);
        holdDataRegWord2_L2: in     vl_logic_vector(0 to 31);
        holdDataRegWord3_L2: in     vl_logic_vector(0 to 31);
        p_holdDataReg_L2: in     vl_logic;
        tagParityError  : in     vl_logic;
        DCU_FlushParityError: out    vl_logic
    );
end p405s_DCU_flushReg;
