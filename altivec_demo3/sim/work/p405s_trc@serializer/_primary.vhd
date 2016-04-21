library verilog;
use verilog.vl_types.all;
entity p405s_trcSerializer is
    port(
        serDataOut      : out    vl_logic_vector(0 to 2);
        trcFifoDataOut  : in     vl_logic_vector(0 to 29);
        trcSerStateL2   : in     vl_logic_vector(0 to 3);
        trcTimeStampOut : in     vl_logic_vector(0 to 8)
    );
end p405s_trcSerializer;
