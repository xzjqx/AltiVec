library verilog;
use verilog.vl_types.all;
entity p405s_dcdEquations is
    port(
        dcdMtCtr        : out    vl_logic;
        dcdCrUpDate     : out    vl_logic;
        dcdLrUpdate     : out    vl_logic;
        dcdCtrUpForBcctr: out    vl_logic;
        dcdDataRcLK     : in     vl_logic;
        dcdPlaCr0En     : in     vl_logic;
        dcdPlaMtSpr     : in     vl_logic;
        dcdDataSprf     : in     vl_logic_vector(0 to 9);
        dcdPlaCrBfEn    : in     vl_logic;
        dcdPlaMtcrf     : in     vl_logic;
        dcdPlaB         : in     vl_logic;
        dcdPlaBc        : in     vl_logic;
        dcdDataBO_2     : in     vl_logic
    );
end p405s_dcdEquations;
