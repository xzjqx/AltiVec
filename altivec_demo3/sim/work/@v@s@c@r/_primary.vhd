library verilog;
use verilog.vl_types.all;
entity VSCR is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_VSCRReadEnable: in     vl_logic;
        in_VSCRTargetRegister: in     vl_logic_vector(0 to 4);
        in_VSCR         : in     vl_logic_vector(0 to 31);
        in_VSCRWriteEnable: in     vl_logic;
        PU_VSCR_en      : in     vl_logic;
        PU_VSCR_SAT     : in     vl_logic;
        VALU_VSCREn     : in     vl_logic;
        VALU_VSCRData   : in     vl_logic;
        VSCR_RFTargetRegEn: out    vl_logic;
        VSCR_RFTargetRegister: out    vl_logic_vector(0 to 4);
        out_VSCR        : out    vl_logic_vector(0 to 31)
    );
end VSCR;
