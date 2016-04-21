library verilog;
use verilog.vl_types.all;
entity p405s_DCU_parityRAM is
    port(
        p_dataOutA      : out    vl_logic_vector(0 to 15);
        p_dataOutB      : out    vl_logic_vector(0 to 15);
        addr            : in     vl_logic_vector(0 to 8);
        p_writeA        : in     vl_logic_vector(0 to 15);
        p_writeB        : in     vl_logic_vector(0 to 15);
        cclk            : in     vl_logic;
        p_dataInA       : in     vl_logic_vector(0 to 15);
        p_dataInB       : in     vl_logic_vector(0 to 15);
        readWrite       : in     vl_logic;
        sram_cen        : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n       : in     vl_logic;
        bist_we_n       : in     vl_logic;
        bist_addr       : in     vl_logic_vector(8 downto 0);
        bist_wr_data    : in     vl_logic_vector(31 downto 0);
        bist_rd_data    : out    vl_logic_vector(31 downto 0);
        cap_mem_addr    : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data : out    vl_logic_vector(31 downto 0);
        cap_mem_we      : out    vl_logic
    );
end p405s_DCU_parityRAM;
