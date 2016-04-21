library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        in_AReadRegisterEnable: in     vl_logic;
        in_AReadRegister: in     vl_logic_vector(0 to 4);
        in_BReadRegisterEnable: in     vl_logic;
        in_BReadRegister: in     vl_logic_vector(0 to 4);
        in_CReadRegisterEnable: in     vl_logic;
        in_CReadRegister: in     vl_logic_vector(0 to 4);
        in_ZeroWriteRegister: in     vl_logic_vector(0 to 4);
        in_ZeroWriteData: in     vl_logic_vector(0 to 127);
        in_ZeroWriteRegisterEnable: in     vl_logic_vector(0 to 15);
        in_FirstWriteRegisterEnable: in     vl_logic;
        in_FirstWriteRegister: in     vl_logic_vector(0 to 4);
        in_FirstWriteData: in     vl_logic_vector(0 to 127);
        in_SecondWriteRegisterEnable: in     vl_logic;
        in_SecondWriteRegister: in     vl_logic_vector(0 to 4);
        in_SecondWriteData: in     vl_logic_vector(0 to 127);
        in_ThirdWriteRegisterEnable: in     vl_logic;
        in_ThirdWriteRegister: in     vl_logic_vector(0 to 4);
        in_ThirdWriteData: in     vl_logic_vector(0 to 127);
        in_FourthWriteRegisterEnable: in     vl_logic;
        in_FourthWriteRegister: in     vl_logic_vector(0 to 4);
        in_FourthWriteData: in     vl_logic_vector(0 to 127);
        in_FifthWriteRegisterEnable: in     vl_logic;
        in_FifthWriteRegister: in     vl_logic_vector(0 to 4);
        in_FifthWriteData: in     vl_logic_vector(0 to 31);
        out_AReadData   : out    vl_logic_vector(0 to 127);
        out_BReadData   : out    vl_logic_vector(0 to 127);
        out_CReadData   : out    vl_logic_vector(0 to 127)
    );
end RegisterFile;
