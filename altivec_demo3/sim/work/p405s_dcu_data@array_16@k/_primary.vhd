library verilog;
use verilog.vl_types.all;
entity p405s_dcu_dataArray_16K is
    port(
        dataOutA        : out    vl_logic_vector(0 to 127);
        dataOutB        : out    vl_logic_vector(0 to 127);
        p_dataOutA      : out    vl_logic_vector(0 to 15);
        p_dataOutB      : out    vl_logic_vector(0 to 15);
        CB              : in     vl_logic;
        byteWrite       : in     vl_logic_vector(0 to 15);
        byteWrite_E1    : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 127);
        p_WBhi_L2       : in     vl_logic_vector(0 to 15);
        dataIndexA      : in     vl_logic_vector(0 to 9);
        dataIndexB      : in     vl_logic_vector(0 to 9);
        p_dataIndexP    : in     vl_logic_vector(0 to 9);
        dataReadNotWrite_In: in     vl_logic;
        dataReadWriteCycle_In: in     vl_logic;
        hit_a_buf2      : in     vl_logic;
        hit_b_buf2      : in     vl_logic;
        testEn          : in     vl_logic;
        writeDataA0     : in     vl_logic;
        writeDataA1     : in     vl_logic;
        writeDataB0     : in     vl_logic;
        writeDataB1     : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ce_n_m0    : in     vl_logic;
        bist_we_n_m0    : in     vl_logic;
        bist_addr_m0    : in     vl_logic_vector(8 downto 0);
        bist_wr_data_m0 : in     vl_logic_vector(127 downto 0);
        bist_rd_data_m0 : out    vl_logic_vector(127 downto 0);
        bist_ce_n_m1    : in     vl_logic;
        bist_we_n_m1    : in     vl_logic;
        bist_addr_m1    : in     vl_logic_vector(8 downto 0);
        bist_wr_data_m1 : in     vl_logic_vector(127 downto 0);
        bist_rd_data_m1 : out    vl_logic_vector(127 downto 0);
        bist_ce_n_m2    : in     vl_logic;
        bist_we_n_m2    : in     vl_logic;
        bist_addr_m2    : in     vl_logic_vector(8 downto 0);
        bist_wr_data_m2 : in     vl_logic_vector(31 downto 0);
        bist_rd_data_m2 : out    vl_logic_vector(31 downto 0);
        cap_mem_addr_m0 : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data_m0: out    vl_logic_vector(127 downto 0);
        cap_mem_we_m0   : out    vl_logic;
        cap_mem_addr_m1 : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data_m1: out    vl_logic_vector(127 downto 0);
        cap_mem_we_m1   : out    vl_logic;
        cap_mem_addr_m2 : out    vl_logic_vector(8 downto 0);
        cap_mem_wr_data_m2: out    vl_logic_vector(31 downto 0);
        cap_mem_we_m2   : out    vl_logic
    );
end p405s_dcu_dataArray_16K;
