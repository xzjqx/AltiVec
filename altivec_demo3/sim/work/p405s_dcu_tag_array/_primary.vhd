library verilog;
use verilog.vl_types.all;
entity p405s_dcu_tag_array is
    port(
        Q               : out    vl_logic_vector(0 to 47);
        CLK             : in     vl_logic;
        CEN             : in     vl_logic;
        WEN             : in     vl_logic_vector(0 to 47);
        A               : in     vl_logic_vector(0 to 7);
        D               : in     vl_logic_vector(0 to 47)
    );
end p405s_dcu_tag_array;
