library verilog;
use verilog.vl_types.all;
entity p405s_loadSteering is
    port(
        EXE_apuLoadData : out    vl_logic_vector(0 to 31);
        EXE_dvc1ByteCmp : out    vl_logic_vector(0 to 3);
        EXE_dvc2ByteCmp : out    vl_logic_vector(0 to 3);
        dRegBypass      : out    vl_logic_vector(0 to 31);
        gprLpIn         : out    vl_logic_vector(0 to 31);
        CB              : in     vl_logic;
        DCU_SDQ_mod_NEG : in     vl_logic_vector(0 to 31);
        DCU_data_NEG    : in     vl_logic_vector(0 to 31);
        LSSD_coreTestEn : in     vl_logic;
        OCM_dsData      : in     vl_logic_vector(0 to 31);
        PCL_apuTrcLoadEn: in     vl_logic;
        PCL_dRegBypassMuxSel: in     vl_logic;
        PCL_dRegE1      : in     vl_logic;
        PCL_dofDregE1   : in     vl_logic;
        PCL_dofDregMuxSel: in     vl_logic_vector(0 to 1);
        PCL_dvcByteEnL2 : in     vl_logic_vector(0 to 3);
        PCL_dvcCmpEn    : in     vl_logic;
        PCL_ldAdjE1     : in     vl_logic;
        PCL_ldAdjE2     : in     vl_logic_vector(1 to 3);
        PCL_ldAdjMuxSel : in     vl_logic_vector(0 to 1);
        PCL_ldFillByPassMuxSel: in     vl_logic_vector(0 to 5);
        PCL_ldMuxSel    : in     vl_logic_vector(0 to 7);
        PCL_ldSteerMuxSel: in     vl_logic_vector(0 to 7);
        dvc1L2          : in     vl_logic_vector(0 to 31);
        dvc2L2          : in     vl_logic_vector(0 to 31);
        DCU_parityError : in     vl_logic;
        EXE_dofDregParityErrL2: out    vl_logic
    );
end p405s_loadSteering;
