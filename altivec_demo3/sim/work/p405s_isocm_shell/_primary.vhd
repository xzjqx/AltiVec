library verilog;
use verilog.vl_types.all;
entity p405s_isocm_shell is
    port(
        SystemClock     : in     vl_logic;
        isocm_if_C405_isocmReqPending: in     vl_logic;
        isocm_if_C405_isocmIcuReady: in     vl_logic;
        isocm_if_C405_isocmABus: in     vl_logic_vector(0 to 29);
        isocm_if_C405_isocmAbort: in     vl_logic;
        isocm_if_C405_isocmContextSync: in     vl_logic;
        isocm_if_C405_isocmXlateValid: in     vl_logic;
        isocm_if_C405_isocmU0Attr: in     vl_logic;
        isocm_if_C405_isocmCacheable: in     vl_logic;
        isocm_if_reset_n: in     vl_logic;
        isocm_if_ISOCM_c405Hold: out    vl_logic;
        isocm_if_ISOCM_c405RdDValid: out    vl_logic_vector(0 to 1);
        isocm_if_ISOCM_c405RdDBus: out    vl_logic_vector(0 to 63)
    );
end p405s_isocm_shell;
