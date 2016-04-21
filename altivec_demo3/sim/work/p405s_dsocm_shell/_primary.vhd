library verilog;
use verilog.vl_types.all;
entity p405s_dsocm_shell is
    port(
        SystemClock     : in     vl_logic;
        dsocm_if_C405_dsocmLoadReq: in     vl_logic;
        dsocm_if_C405_dsocmStoreReq: in     vl_logic;
        dsocm_if_C405_dsocmXlateValid: in     vl_logic;
        dsocm_if_C405_dsocmABus: in     vl_logic_vector(29 downto 0);
        dsocm_if_C405_dsocmCacheable: in     vl_logic;
        dsocm_if_C405_dsocmGuarded: in     vl_logic;
        dsocm_if_C405_dsocmU0Attr: in     vl_logic;
        dsocm_if_C405_dsocmByteEn: in     vl_logic_vector(3 downto 0);
        dsocm_if_C405_dsocmWrDBus: in     vl_logic_vector(31 downto 0);
        dsocm_if_C405_dsocmAbortOp: in     vl_logic;
        dsocm_if_C405_dsocmAbortReq: in     vl_logic;
        dsocm_if_C405_dsocmWait: in     vl_logic;
        dsocm_if_C405_dsocmStringMultiple: in     vl_logic;
        dsocm_if_DSOCM_c405Complete: out    vl_logic;
        dsocm_if_DSOCM_c405Hold: out    vl_logic;
        dsocm_if_DSOCM_c405DisOperandFwd: out    vl_logic;
        dsocm_if_DSOCM_c405RdDBus: out    vl_logic_vector(31 downto 0);
        dsocm_if_reset_n: in     vl_logic
    );
end p405s_dsocm_shell;
