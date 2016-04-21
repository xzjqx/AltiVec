library verilog;
use verilog.vl_types.all;
entity p405s_dcu_tagArray_16K is
    port(
        DCU_icuSize     : out    vl_logic_vector(0 to 2);
        U0AttrA         : out    vl_logic;
        U0AttrB         : out    vl_logic;
        tagAOut         : out    vl_logic_vector(0 to 20);
        tagBOut         : out    vl_logic_vector(0 to 20);
        p_parityA       : out    vl_logic;
        p_parityB       : out    vl_logic;
        validA          : out    vl_logic;
        validB          : out    vl_logic;
        CB              : in     vl_logic;
        dataIn          : in     vl_logic_vector(0 to 20);
        p_tag           : in     vl_logic;
        hit_a_buf2      : in     vl_logic;
        hit_b_buf2      : in     vl_logic;
        newValidIn      : in     vl_logic;
        tagIndex        : in     vl_logic_vector(0 to 9);
        tagReadNotWrite_In: in     vl_logic;
        tagReadWriteCycle_In: in     vl_logic;
        wbU0AttrL1      : in     vl_logic;
        writeTagA0      : in     vl_logic;
        writeTagA1      : in     vl_logic;
        writeTagB0      : in     vl_logic;
        writeTagB1      : in     vl_logic;
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
end p405s_dcu_tagArray_16K;
