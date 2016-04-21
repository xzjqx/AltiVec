library verilog;
use verilog.vl_types.all;
entity p405s_spr_top is
    port(
        exeSprDataBus   : out    vl_logic_vector(0 to 31);
        EXE_vctDbgSprDataBus: out    vl_logic_vector(0 to 31);
        EXE_timJtgSprDataBus: out    vl_logic_vector(0 to 31);
        EXE_mmuIcuSprDataBus: out    vl_logic_vector(0 to 31);
        EXE_ifbSprDataBus: out    vl_logic_vector(0 to 31);
        EXE_dcrDataBus  : out    vl_logic_vector(0 to 31);
        EXE_sprAddr     : out    vl_logic_vector(4 to 9);
        EXE_dcrAddr     : out    vl_logic_vector(0 to 9);
        exeSprDataEn_NEG: in     vl_logic;
        exeSprUnitEn_NEG: in     vl_logic;
        aBus            : in     vl_logic_vector(0 to 31);
        bBus            : in     vl_logic_vector(22 to 31)
    );
end p405s_spr_top;
