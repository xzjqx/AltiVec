library verilog;
use verilog.vl_types.all;
entity p405s_dcu_cdsModule_0 is
    port(
        dataOutA1       : out    vl_logic_vector(0 to 15);
        dataOutA2       : out    vl_logic_vector(0 to 15);
        dataOutA3       : out    vl_logic_vector(0 to 15);
        dataOutA4       : out    vl_logic_vector(0 to 15);
        dataOutB1       : out    vl_logic_vector(0 to 15);
        dataOutB2       : out    vl_logic_vector(0 to 15);
        dataOutB3       : out    vl_logic_vector(0 to 15);
        dataOutB4       : out    vl_logic_vector(0 to 15);
        addr            : in     vl_logic_vector(0 to 8);
        byteWriteA      : in     vl_logic_vector(0 to 7);
        byteWriteB      : in     vl_logic_vector(0 to 7);
        cclk            : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 63);
        readWrite       : in     vl_logic;
        sram_cen        : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(8 downto 0);
        bist_wr_data    : in     vl_logic_vector(127 downto 0);
        bist_rd_data    : out    vl_logic_vector(127 downto 0);
        cap_mem_addr    : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(127 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_dcu_cdsModule_0;
