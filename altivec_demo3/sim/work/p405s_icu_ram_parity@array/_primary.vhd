library verilog;
use verilog.vl_types.all;
entity p405s_icu_ram_parityArray is
    port(
        parityOut       : out    vl_logic_vector(0 to 7);
        CB              : in     vl_logic;
        bitWrite        : in     vl_logic_vector(0 to 7);
        cycleParityRam  : in     vl_logic;
        parityIn        : in     vl_logic_vector(0 to 7);
        dataIndexA      : in     vl_logic_vector(0 to 9);
        readWrParity    : in     vl_logic;
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
end p405s_icu_ram_parityArray;
