library verilog;
use verilog.vl_types.all;
entity p405s_icu_ram_tagArray_16K is
    port(
        icuCacheSize    : out    vl_logic_vector(0 to 2);
        tagAOut         : out    vl_logic_vector(0 to 21);
        tagAOutParityBit: out    vl_logic;
        tagBOut         : out    vl_logic_vector(0 to 21);
        tagBOutParityBit: out    vl_logic;
        CB              : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 21);
        dataInParityBit : in     vl_logic;
        readWr          : in     vl_logic;
        tagCycle        : in     vl_logic;
        tagIndex        : in     vl_logic_vector(0 to 8);
        writeTagANotB   : in     vl_logic_vector(0 to 22);
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(7 downto 0);
        bist_rd_data    : out    vl_logic_vector(45 downto 0);
        bist_wr_data    : in     vl_logic_vector(45 downto 0);
        cap_mem_addr    : out    vl_logic_vector(7 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(45 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_icu_ram_tagArray_16K;
