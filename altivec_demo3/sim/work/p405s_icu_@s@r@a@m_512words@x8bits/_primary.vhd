library verilog;
use verilog.vl_types.all;
entity p405s_icu_SRAM_512wordsX8bits is
    port(
        parityOut       : out    vl_logic_vector(0 to 7);
        addr            : in     vl_logic_vector(0 to 8);
        bitWrite        : in     vl_logic_vector(0 to 7);
        cclk            : in     vl_logic;
        parityIn        : in     vl_logic_vector(0 to 7);
        readWrite       : in     vl_logic;
        sram_cen        : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(8 downto 0);
        bist_rd_data    : out    vl_logic_vector(7 downto 0);
        bist_wr_data    : in     vl_logic_vector(7 downto 0);
        cap_mem_addr    : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(7 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_icu_SRAM_512wordsX8bits;
