library verilog;
use verilog.vl_types.all;
entity p405s_ldStDVC is
    port(
        EXE_dvc1ByteCmp : out    vl_logic_vector(0 to 3);
        EXE_dvc2ByteCmp : out    vl_logic_vector(0 to 3);
        dvc2L2          : in     vl_logic_vector(0 to 31);
        dvc1L2          : in     vl_logic_vector(0 to 31);
        dofDreg         : in     vl_logic_vector(0 to 31);
        PCL_dvcByteEnL2 : in     vl_logic_vector(0 to 3)
    );
end p405s_ldStDVC;
