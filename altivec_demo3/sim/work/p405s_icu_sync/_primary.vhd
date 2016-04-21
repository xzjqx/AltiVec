library verilog;
use verilog.vl_types.all;
entity p405s_icu_sync is
    generic(
        reqSM0          : integer := 8;
        reqSM1          : integer := 4;
        reqSM2          : integer := 2;
        reqSM3          : integer := 1;
        abSM0           : integer := 32;
        abSM1           : integer := 16;
        abSM2           : integer := 8;
        abSM3           : integer := 4;
        abSM4           : integer := 2;
        abSM5           : integer := 1
    );
    port(
        ICS_plbABus     : out    vl_logic_vector(0 to 29);
        ICS_plbAbort    : out    vl_logic;
        ICS_plbCacheable: out    vl_logic;
        ICS_plbRequest  : out    vl_logic;
        ICS_plbTranSize : out    vl_logic_vector(2 to 3);
        ICS_plbU0Attr   : out    vl_logic;
        ICS_plbPriority : out    vl_logic_vector(0 to 1);
        ICS_c405AddrAck : out    vl_logic;
        ICS_c405IcuBusy : out    vl_logic;
        ICS_c405Error   : out    vl_logic;
        ICS_c405RdDAck  : out    vl_logic;
        ICS_c405DBus    : out    vl_logic_vector(0 to 63);
        ICS_c405RdWrAddr: out    vl_logic_vector(1 to 3);
        ICS_c405SSize   : out    vl_logic;
        C405_icsABus    : in     vl_logic_vector(0 to 29);
        C405_icsAbort   : in     vl_logic;
        C405_icsCacheable: in     vl_logic;
        C405_icsRequest : in     vl_logic;
        C405_icsTranSize: in     vl_logic_vector(2 to 3);
        C405_icsU0Attr  : in     vl_logic;
        C405_icsPriority: in     vl_logic_vector(0 to 1);
        PLB_icsAddrAck  : in     vl_logic;
        PLB_icsIcuBusy  : in     vl_logic;
        PLB_icsError    : in     vl_logic;
        PLB_icsRdDAck   : in     vl_logic;
        PLB_icsDBus     : in     vl_logic_vector(0 to 63);
        PLB_icsRdWrAddr : in     vl_logic_vector(1 to 3);
        PLB_icsSSize    : in     vl_logic;
        bypass          : in     vl_logic;
        sc              : in     vl_logic;
        CB              : in     vl_logic;
        reset           : in     vl_logic
    );
end p405s_icu_sync;
