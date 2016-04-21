library verilog;
use verilog.vl_types.all;
entity sram512x8 is
    generic(
        BITS            : integer := 8;
        word_depth      : integer := 512;
        addr_width      : integer := 9;
        mask_width      : integer := 8;
        wp_size         : integer := 1
    );
    port(
        Q               : out    vl_logic_vector(7 downto 0);
        CLK             : in     vl_logic;
        CEN             : in     vl_logic;
        WEN             : in     vl_logic_vector(7 downto 0);
        A               : in     vl_logic_vector(8 downto 0);
        D               : in     vl_logic_vector(7 downto 0)
    );
end sram512x8;
