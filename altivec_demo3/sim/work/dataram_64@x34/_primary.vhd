library verilog;
use verilog.vl_types.all;
entity dataram_64X34 is
    generic(
        BITS            : integer := 34;
        word_depth      : integer := 64;
        addr_width      : integer := 6
    );
    port(
        QA              : out    vl_logic_vector(33 downto 0);
        AA              : in     vl_logic_vector(5 downto 0);
        CLKA            : in     vl_logic;
        CENA            : in     vl_logic;
        AB              : in     vl_logic_vector(5 downto 0);
        DB              : in     vl_logic_vector(33 downto 0);
        CLKB            : in     vl_logic;
        CENB            : in     vl_logic
    );
end dataram_64X34;
