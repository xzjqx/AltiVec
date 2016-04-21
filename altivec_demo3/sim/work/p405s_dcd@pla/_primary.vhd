library verilog;
use verilog.vl_types.all;
entity p405s_dcdPla is
    port(
        plaApuLdSt      : out    vl_logic;
        plaMac          : out    vl_logic;
        plaVal          : out    vl_logic;
        plaPriv         : out    vl_logic;
        plaRaEq0Ck      : out    vl_logic;
        NplaApRdEn      : out    vl_logic;
        NplaBpRdEn      : out    vl_logic;
        plaSpRdEn       : out    vl_logic;
        plaLpWrEn       : out    vl_logic;
        plaRpWrEn       : out    vl_logic;
        plaRpMuxSel     : out    vl_logic;
        plaLitCntl      : out    vl_logic_vector(0 to 4);
        plaBpLitGenSel  : out    vl_logic;
        plaCmplmntA     : out    vl_logic;
        NplaAregEn      : out    vl_logic;
        NplaBregEn      : out    vl_logic;
        NplaSregEn      : out    vl_logic;
        plaSrmEn        : out    vl_logic;
        plaSrmMuxSel    : out    vl_logic_vector(0 to 2);
        plaUnitEn       : out    vl_logic_vector(0 to 4);
        plaAdmCntl      : out    vl_logic_vector(0 to 3);
        plaLogicalCntl  : out    vl_logic_vector(0 to 7);
        plaSrmCntl      : out    vl_logic_vector(0 to 3);
        plaEaCalc       : out    vl_logic;
        plaAddEn        : out    vl_logic;
        plaLSSMIURA     : out    vl_logic_vector(0 to 7);
        plaByteCnt      : out    vl_logic_vector(0 to 4);
        plaIcuOp        : out    vl_logic_vector(0 to 3);
        plaDcuOp        : out    vl_logic_vector(0 to 11);
        plaMmuCode      : out    vl_logic_vector(0 to 6);
        PCL_dcdHotCIn   : out    vl_logic;
        PCL_dcdXerCa    : out    vl_logic;
        plaOeCk         : out    vl_logic;
        plaXerCaEn      : out    vl_logic;
        plaMtspr        : out    vl_logic;
        plaMfspr        : out    vl_logic;
        plaMtdcr        : out    vl_logic;
        plaMfdcr        : out    vl_logic;
        plaWrExtEn      : out    vl_logic;
        plaWrtee        : out    vl_logic;
        accTyp          : out    vl_logic;
        plaLwarx        : out    vl_logic;
        plaStwcx        : out    vl_logic;
        plaMrSel        : out    vl_logic;
        plaMdSel        : out    vl_logic;
        plaNegMac       : out    vl_logic;
        plaGateZeroToAccReg: out    vl_logic;
        plaMacSat       : out    vl_logic;
        plaForceAlgn    : out    vl_logic;
        plaApuDiv       : out    vl_logic;
        plaMtcrf        : out    vl_logic;
        priOp           : in     vl_logic_vector(0 to 5);
        sprMsb          : in     vl_logic;
        secOp           : in     vl_logic_vector(21 to 31);
        pgmEn           : in     vl_logic_vector(0 to 1)
    );
end p405s_dcdPla;
