library verilog;
use verilog.vl_types.all;
entity p405s_trc_top is
    port(
        TRC_evenESBusL2 : out    vl_logic_vector(0 to 1);
        TRC_fifoFull    : out    vl_logic;
        TRC_fifoOneEntryFree: out    vl_logic;
        TRC_oddCycleL2  : out    vl_logic;
        TRC_oddESBusL2  : out    vl_logic_vector(0 to 1);
        TRC_se          : out    vl_logic;
        TRC_seCtrEqZeroL2: out    vl_logic;
        TRC_sleepReq    : out    vl_logic;
        TRC_tsBusL2     : out    vl_logic_vector(0 to 3);
        CB              : in     vl_logic;
        DBG_stopReq     : in     vl_logic;
        ICU_traceEnable : in     vl_logic;
        IFB_postEntry   : in     vl_logic;
        IFB_seIdleSt    : in     vl_logic;
        IFB_stopAck     : in     vl_logic;
        IFB_traceData   : in     vl_logic_vector(0 to 29);
        IFB_traceESL2   : in     vl_logic_vector(0 to 1);
        IFB_traceType   : in     vl_logic_vector(0 to 1);
        JTG_stopReq     : in     vl_logic;
        VCT_msrWE       : in     vl_logic;
        XXX_TE          : in     vl_logic;
        XXX_traceDisable: in     vl_logic;
        coreReset       : in     vl_logic
    );
end p405s_trc_top;
