library verilog;
use verilog.vl_types.all;
entity p405s_icu_SRAM_512wordsX128bits is
    port(
        dataOutA0       : out    vl_logic_vector(0 to 7);
        dataOutA1       : out    vl_logic_vector(8 to 15);
        dataOutA2       : out    vl_logic_vector(16 to 23);
        dataOutA3       : out    vl_logic_vector(24 to 31);
        dataOutA4       : out    vl_logic_vector(32 to 39);
        dataOutA5       : out    vl_logic_vector(40 to 47);
        dataOutA6       : out    vl_logic_vector(48 to 55);
        dataOutA7       : out    vl_logic_vector(56 to 63);
        dataOutA8       : out    vl_logic_vector(64 to 71);
        dataOutA9       : out    vl_logic_vector(72 to 79);
        dataOutA10      : out    vl_logic_vector(80 to 87);
        dataOutA11      : out    vl_logic_vector(88 to 95);
        dataOutA12      : out    vl_logic_vector(96 to 103);
        dataOutA13      : out    vl_logic_vector(104 to 111);
        dataOutA14      : out    vl_logic_vector(112 to 119);
        dataOutA15      : out    vl_logic_vector(120 to 127);
        addr            : in     vl_logic_vector(0 to 8);
        byteWrite       : in     vl_logic_vector(0 to 15);
        cclk            : in     vl_logic;
        dataInA0        : in     vl_logic_vector(0 to 7);
        dataInA1        : in     vl_logic_vector(8 to 15);
        dataInA2        : in     vl_logic_vector(16 to 23);
        dataInA3        : in     vl_logic_vector(24 to 31);
        dataInA4        : in     vl_logic_vector(32 to 39);
        dataInA5        : in     vl_logic_vector(40 to 47);
        dataInA6        : in     vl_logic_vector(48 to 55);
        dataInA7        : in     vl_logic_vector(56 to 63);
        dataInA8        : in     vl_logic_vector(64 to 71);
        dataInA9        : in     vl_logic_vector(72 to 79);
        dataInA10       : in     vl_logic_vector(80 to 87);
        dataInA11       : in     vl_logic_vector(88 to 95);
        dataInA12       : in     vl_logic_vector(96 to 103);
        dataInA13       : in     vl_logic_vector(104 to 111);
        dataInA14       : in     vl_logic_vector(112 to 119);
        dataInA15       : in     vl_logic_vector(120 to 127);
        readWrite       : in     vl_logic;
        sram_cen        : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(8 downto 0);
        bist_rd_data    : out    vl_logic_vector(127 downto 0);
        bist_wr_data    : in     vl_logic_vector(127 downto 0);
        cap_mem_addr    : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(127 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_icu_SRAM_512wordsX128bits;
