library verilog;
use verilog.vl_types.all;
entity p405s_sdtGates is
    port(
        aRegZ4dndSEIn   : out    vl_logic_vector(0 to 4);
        admAdderAInMuxSel: out    vl_logic_vector(0 to 1);
        admAdderBInMuxSel: out    vl_logic_vector(0 to 1);
        admCcMuxSel     : out    vl_logic_vector(0 to 1);
        macOVSat_NEG    : out    vl_logic;
        macSatValue     : out    vl_logic_vector(0 to 2);
        PCL_addFour     : in     vl_logic;
        PCL_exe2MacOrMultEnForMS: in     vl_logic_vector(0 to 1);
        PCL_exe2MacOrMultEn_NEG: in     vl_logic_vector(0 to 1);
        PCL_exe2MultEn  : in     vl_logic;
        PCL_exe2MultHiWd: in     vl_logic;
        PCL_exe2SignedOp: in     vl_logic;
        PCL_exe2XerOvEn : in     vl_logic;
        PCL_exeCmplmntA_NEG: in     vl_logic;
        PCL_exeDivEnForMuxSel: in     vl_logic_vector(0 to 1);
        PCL_exeMultEnForMuxSel: in     vl_logic_vector(0 to 1);
        PCL_exeMultEn_NEG: in     vl_logic_vector(0 to 1);
        adderOutBit0    : in     vl_logic;
        cInBit1         : in     vl_logic;
        cIn_1           : in     vl_logic;
        divLastStOrSt0L2_1: in     vl_logic;
        divLastStOrSt0L2_NEG: in     vl_logic;
        dndSE_NEG       : in     vl_logic;
        exe2MacProdSgndL2: in     vl_logic;
        exe2MacSatUnsigned: in     vl_logic;
        exe2Md16BitOprndL2: in     vl_logic;
        exe2Mr16BitOprndL2: in     vl_logic;
        macAccL2Bit0    : in     vl_logic;
        potSOV          : in     vl_logic;
        sumBit1         : in     vl_logic
    );
end p405s_sdtGates;
