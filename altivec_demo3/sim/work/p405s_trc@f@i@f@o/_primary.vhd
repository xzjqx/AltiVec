library verilog;
use verilog.vl_types.all;
entity p405s_trcFIFO is
    port(
        trcFifoDataOut  : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        fifoRdAddrL2    : in     vl_logic_vector(0 to 3);
        trcFifoDataIn   : in     vl_logic_vector(0 to 31);
        trcFifoE1       : in     vl_logic_vector(0 to 15)
    );
end p405s_trcFIFO;
