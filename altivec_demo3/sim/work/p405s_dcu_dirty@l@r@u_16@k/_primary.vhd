library verilog;
use verilog.vl_types.all;
entity p405s_dcu_dirtyLRU_16K is
    port(
        LRU             : out    vl_logic;
        dirtyA          : out    vl_logic;
        dirtyB          : out    vl_logic;
        CB              : in     vl_logic;
        dirtyLRUreadIndexL2: in     vl_logic_vector(0 to 8);
        dirtyLRUwriteIndexL2: in     vl_logic_vector(0 to 8);
        newDirty        : in     vl_logic;
        newLRU          : in     vl_logic;
        readLRUDirty    : in     vl_logic;
        writeDirtyA     : in     vl_logic;
        writeDirtyB     : in     vl_logic;
        writeLRU        : in     vl_logic
    );
end p405s_dcu_dirtyLRU_16K;
