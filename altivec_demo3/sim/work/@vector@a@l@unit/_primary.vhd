library verilog;
use verilog.vl_types.all;
entity VectorALUnit is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_VALU_cs      : in     vl_logic_vector(0 to 1);
        in_VALUType     : in     vl_logic_vector(0 to 9);
        in_VALUAOperand : in     vl_logic_vector(0 to 127);
        in_VALUBOperand : in     vl_logic_vector(0 to 127);
        in_VALUCOperand : in     vl_logic_vector(0 to 127);
        in_VALUTargetRegister: in     vl_logic_vector(0 to 4);
        VSFX_RFTargetRegEn: out    vl_logic;
        VSFX_RFTargetRegister: out    vl_logic_vector(0 to 4);
        VSFX_RFResult   : out    vl_logic_vector(0 to 127);
        VCFX_RFTargetRegEn: out    vl_logic;
        VCFX_RFTargetRegister: out    vl_logic_vector(0 to 4);
        VCFX_RFResult   : out    vl_logic_vector(0 to 127);
        VFPU_RFTargetRegEn: out    vl_logic;
        VFPU_RFTargetRegister: out    vl_logic_vector(0 to 4);
        VFPU_RFResult   : out    vl_logic_vector(0 to 127);
        VALU_VSCREn     : out    vl_logic;
        VALU_VSCRData   : out    vl_logic;
        VALU_CRData     : out    vl_logic_vector(0 to 3)
    );
end VectorALUnit;
