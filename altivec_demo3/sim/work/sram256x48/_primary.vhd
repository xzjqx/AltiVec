library verilog;
use verilog.vl_types.all;
entity sram256x48 is
    generic(
        BITS            : integer := 48;
        word_depth      : integer := 256;
        addr_width      : integer := 8;
        mask_width      : integer := 48;
        wp_size         : integer := 1
    );
    port(
        Q               : out    vl_logic_vector(47 downto 0);
        CLK             : in     vl_logic;
        CEN             : in     vl_logic;
        WEN             : in     vl_logic_vector(47 downto 0);
        A               : in     vl_logic_vector(7 downto 0);
        D               : in     vl_logic_vector(47 downto 0)
    );
end sram256x48;
