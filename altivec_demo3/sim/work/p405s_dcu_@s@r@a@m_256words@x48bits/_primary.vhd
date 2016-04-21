library verilog;
use verilog.vl_types.all;
entity p405s_dcu_SRAM_256wordsX48bits is
    port(
        U0AttrA         : out    vl_logic;
        U0AttrB         : out    vl_logic;
        dataOutA        : out    vl_logic_vector(0 to 20);
        dataOutB        : out    vl_logic_vector(0 to 20);
        p_parityA       : out    vl_logic;
        p_parityB       : out    vl_logic;
        validA          : out    vl_logic;
        validB          : out    vl_logic;
        addr            : in     vl_logic_vector(0 to 7);
        bitWriteA       : in     vl_logic_vector(0 to 5);
        bitWriteB       : in     vl_logic_vector(0 to 5);
        cclk            : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 20);
        p_tag           : in     vl_logic;
        newU0Attr       : in     vl_logic;
        newValidA       : in     vl_logic;
        newValidB       : in     vl_logic;
        readWrite       : in     vl_logic;
        sram_cen        : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(7 downto 0);
        bist_wr_data    : in     vl_logic_vector(47 downto 0);
        bist_rd_data    : out    vl_logic_vector(47 downto 0);
        cap_mem_addr    : out    vl_logic_vector(7 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(47 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_dcu_SRAM_256wordsX48bits;
