library verilog;
use verilog.vl_types.all;
entity p405s_DCU_plbMux is
    port(
        DCU_plbDBus     : out    vl_logic_vector(0 to 63);
        CB              : in     vl_logic;
        FDR_L2mux       : in     vl_logic_vector(0 to 63);
        PLBDR_E2        : in     vl_logic_vector(0 to 3);
        PLBDR_hiMuxSel  : in     vl_logic_vector(0 to 3);
        SDP_FDR_muxSel  : in     vl_logic;
        SDP_dataL2      : in     vl_logic_vector(0 to 31);
        sampleCycleL2   : in     vl_logic
    );
end p405s_DCU_plbMux;
