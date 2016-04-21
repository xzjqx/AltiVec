library verilog;
use verilog.vl_types.all;
entity p405s_storageStMachPla is
    port(
        nxtExeStrgSt    : out    vl_logic_vector(0 to 2);
        PCL_addFour     : out    vl_logic;
        IFB_exeFlush    : in     vl_logic;
        exeStrgSt       : in     vl_logic_vector(0 to 2);
        gtErr           : in     vl_logic;
        strgEnd         : in     vl_logic;
        gtLS            : in     vl_logic;
        exeEaCalc       : in     vl_logic
    );
end p405s_storageStMachPla;
