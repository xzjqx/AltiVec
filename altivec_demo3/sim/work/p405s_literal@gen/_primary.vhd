library verilog;
use verilog.vl_types.all;
entity p405s_literalGen is
    port(
        litGen          : out    vl_logic_vector(0 to 31);
        PCL_dcdImmd     : in     vl_logic_vector(11 to 31);
        litCntl         : in     vl_logic_vector(0 to 4);
        LSSD_coreTestEn : in     vl_logic
    );
end p405s_literalGen;
