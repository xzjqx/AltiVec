library verilog;
use verilog.vl_types.all;
entity p405s_DCU_holdReg is
    port(
        holdDataRegWord0_L2: out    vl_logic_vector(0 to 31);
        holdDataRegWord1_L2: out    vl_logic_vector(0 to 31);
        holdDataRegWord2_L2: out    vl_logic_vector(0 to 31);
        holdDataRegWord3_L2: out    vl_logic_vector(0 to 31);
        p_holdDataReg_L2: out    vl_logic;
        CB              : in     vl_logic;
        FDR_hi_E1       : in     vl_logic_vector(0 to 3);
        FDR_holdMuxSel  : in     vl_logic_vector(0 to 3);
        dataOut_A       : in     vl_logic_vector(0 to 127);
        p_aSideErrorRaw : in     vl_logic;
        dataOut_B       : in     vl_logic_vector(0 to 127);
        p_bSideErrorRaw : in     vl_logic;
        tagParityError  : in     vl_logic;
        flushHold_E2    : in     vl_logic_vector(0 to 3)
    );
end p405s_DCU_holdReg;
