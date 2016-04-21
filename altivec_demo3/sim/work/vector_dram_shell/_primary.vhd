library verilog;
use verilog.vl_types.all;
entity vector_dram_shell is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        cs              : in     vl_logic;
        rw              : in     vl_logic;
        addr            : in     vl_logic_vector(0 to 31);
        data_in         : in     vl_logic_vector(0 to 127);
        data_out        : out    vl_logic_vector(0 to 127);
        write_en        : in     vl_logic_vector(0 to 15)
    );
end vector_dram_shell;
