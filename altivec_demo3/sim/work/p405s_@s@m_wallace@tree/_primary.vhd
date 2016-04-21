library verilog;
use verilog.vl_types.all;
entity p405s_SM_wallaceTree is
    port(
        PC              : out    vl_logic_vector(0 to 32);
        RS              : in     vl_logic_vector(0 to 31);
        MD              : in     vl_logic_vector(0 to 15);
        MR              : in     vl_logic_vector(0 to 15);
        PS              : out    vl_logic_vector(0 to 32);
        mdSgn           : in     vl_logic;
        mrSgn           : in     vl_logic;
        FSMD            : in     vl_logic;
        RC              : in     vl_logic_vector(0 to 31);
        LSMD            : in     vl_logic;
        MMD             : in     vl_logic_vector(0 to 16);
        TE              : in     vl_logic
    );
end p405s_SM_wallaceTree;
