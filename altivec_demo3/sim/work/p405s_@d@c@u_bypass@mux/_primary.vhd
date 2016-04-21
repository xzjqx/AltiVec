library verilog;
use verilog.vl_types.all;
entity p405s_DCU_bypassMux is
    port(
        DCU_data_NEG    : out    vl_logic_vector(0 to 31);
        bypassMuxOut    : in     vl_logic_vector(0 to 31);
        dOutMuxSelByte0 : in     vl_logic_vector(0 to 1);
        dOutMuxSelByte1 : in     vl_logic_vector(0 to 1);
        dOutMuxSelByte2 : in     vl_logic_vector(0 to 1);
        dOutMuxSelByte3 : in     vl_logic_vector(0 to 1);
        dcReadTag       : in     vl_logic_vector(0 to 31);
        wordMuxA        : in     vl_logic_vector(0 to 31);
        wordMuxB        : in     vl_logic_vector(0 to 31)
    );
end p405s_DCU_bypassMux;
