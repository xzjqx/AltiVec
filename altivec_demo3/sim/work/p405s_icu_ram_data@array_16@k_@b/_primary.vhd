library verilog;
use verilog.vl_types.all;
entity p405s_icu_ram_dataArray_16K_B is
    port(
        dataOutB        : out    vl_logic_vector(0 to 127);
        CB              : in     vl_logic;
        byteWrite       : in     vl_logic_vector(0 to 15);
        cycleDataRamB   : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 127);
        dataIndexB      : in     vl_logic_vector(0 to 9);
        readWrB         : in     vl_logic;
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
end p405s_icu_ram_dataArray_16K_B;
