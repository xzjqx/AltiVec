library verilog;
use verilog.vl_types.all;
entity LoadStore is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        Dcd_RaEn        : in     vl_logic;
        C405_LSRaData   : in     vl_logic_vector(31 downto 0);
        C405_LSRbData   : in     vl_logic_vector(31 downto 0);
        Dcd_LS_cs       : in     vl_logic;
        Dcd_LSType      : in     vl_logic_vector(4 downto 0);
        Dcd_LSOperand   : in     vl_logic_vector(127 downto 0);
        Dcd_LSTargetRegister: in     vl_logic_vector(4 downto 0);
        LS_Mem_cs       : out    vl_logic;
        LS_MemAddr      : out    vl_logic_vector(31 downto 0);
        LS_MemData      : out    vl_logic_vector(127 downto 0);
        LS_Mem_RW       : out    vl_logic;
        LS_Mem_WriteEn  : out    vl_logic_vector(15 downto 0);
        Mem_LSData      : in     vl_logic_vector(127 downto 0);
        LS_RFTargetRegEn: out    vl_logic_vector(15 downto 0);
        LS_RFTargetRegister: out    vl_logic_vector(4 downto 0);
        LS_RFResult     : out    vl_logic_vector(127 downto 0)
    );
end LoadStore;
