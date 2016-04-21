library verilog;
use verilog.vl_types.all;
entity p405s_storageCntlPla is
    port(
        PCL_dcuByteEn   : out    vl_logic_vector(0 to 3);
        decBy           : out    vl_logic_vector(0 to 3);
        strgLpWrEn      : out    vl_logic;
        gotoLS          : out    vl_logic;
        storageEnd      : out    vl_logic;
        sPortSelInc     : out    vl_logic;
        blkExeSpAddr    : out    vl_logic;
        algnErr         : out    vl_logic;
        exeApuFpuOp     : in     vl_logic;
        ea              : in     vl_logic_vector(0 to 1);
        byteCount       : in     vl_logic_vector(0 to 7);
        cntGtEq4        : in     vl_logic;
        exeStorageSt    : in     vl_logic_vector(0 to 2);
        exeLd           : in     vl_logic;
        exeSt           : in     vl_logic;
        exeString       : in     vl_logic;
        exeMultiple     : in     vl_logic;
        exeByteRev      : in     vl_logic;
        exeAlg          : in     vl_logic;
        nopStringIndexed: in     vl_logic;
        exeLwarx        : in     vl_logic;
        exeStwcx        : in     vl_logic;
        exeDcread       : in     vl_logic;
        exeEaCalc       : in     vl_logic;
        PCL_Rbit        : in     vl_logic
    );
end p405s_storageCntlPla;
