library verilog;
use verilog.vl_types.all;
entity AltiVecUnit is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_Instruction  : in     vl_logic_vector(0 to 31);
        in_ReadDataAfromGPR: in     vl_logic_vector(0 to 31);
        in_ReadDataBfromGPR: in     vl_logic_vector(0 to 31);
        APU_AltiVec_DcdHold: in     vl_logic;
        Mem_LSData      : in     vl_logic_vector(0 to 127);
        Dcd_APUCR6En    : out    vl_logic;
        Dcd_APUValidOp  : out    vl_logic;
        Dcd_APUExeBusy  : out    vl_logic;
        Dcd_APURaEn     : out    vl_logic;
        Dcd_APURbEn     : out    vl_logic;
        VALU_CRData     : out    vl_logic_vector(0 to 3);
        LS_Mem_cs       : out    vl_logic;
        LS_Mem_RW       : out    vl_logic;
        LS_MemAddr      : out    vl_logic_vector(0 to 31);
        LS_MemData      : out    vl_logic_vector(0 to 127);
        LS_Mem_WriteEn  : out    vl_logic_vector(0 to 15)
    );
end AltiVecUnit;
