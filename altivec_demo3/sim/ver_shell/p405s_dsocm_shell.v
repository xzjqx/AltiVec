
module p405s_dsocm_shell(
        SystemClock,
        dsocm_if_C405_dsocmLoadReq,
        dsocm_if_C405_dsocmStoreReq,
        dsocm_if_C405_dsocmXlateValid,
        dsocm_if_C405_dsocmABus,
        dsocm_if_C405_dsocmCacheable,
        dsocm_if_C405_dsocmGuarded,
        dsocm_if_C405_dsocmU0Attr,
        dsocm_if_C405_dsocmByteEn,
        dsocm_if_C405_dsocmWrDBus,
        dsocm_if_C405_dsocmAbortOp,
        dsocm_if_C405_dsocmAbortReq,
        dsocm_if_C405_dsocmWait,
        dsocm_if_C405_dsocmStringMultiple,
        dsocm_if_DSOCM_c405Complete,
        dsocm_if_DSOCM_c405Hold,
        dsocm_if_DSOCM_c405DisOperandFwd,
        dsocm_if_DSOCM_c405RdDBus,
        dsocm_if_reset_n
);
//-------------------------------------
// I/O declaration
//-------------------------------------
input SystemClock;
input dsocm_if_C405_dsocmLoadReq;
input dsocm_if_C405_dsocmStoreReq;
input dsocm_if_C405_dsocmXlateValid;
input [29:0] dsocm_if_C405_dsocmABus;
input dsocm_if_C405_dsocmCacheable;
input dsocm_if_C405_dsocmGuarded;
input dsocm_if_C405_dsocmU0Attr;
input [3:0] dsocm_if_C405_dsocmByteEn;
input [31:0] dsocm_if_C405_dsocmWrDBus;
input dsocm_if_C405_dsocmAbortOp;
input dsocm_if_C405_dsocmAbortReq;
input dsocm_if_C405_dsocmWait;
input dsocm_if_C405_dsocmStringMultiple;
output dsocm_if_DSOCM_c405Complete;
output dsocm_if_DSOCM_c405Hold;
output dsocm_if_DSOCM_c405DisOperandFwd;
output [31:0] dsocm_if_DSOCM_c405RdDBus;
input dsocm_if_reset_n;
//wires declaration
wire                ram_cs;
wire                ram_rw;
wire    [29:0]      ram_addr;
wire    [31:0]      ram_din;
wire    [31:0]      ram_dout;
//reg declaration
reg                 load_req_r;
reg                 store_req_r;
reg [29:0]          abus_r;
reg [3:0]           be_r;
reg                 op_complete;//active high to indicate Load/Store operation is done

//register the input signal
always @(posedge SystemClock)
begin
    load_req_r      <= dsocm_if_C405_dsocmLoadReq;
    store_req_r     <= dsocm_if_C405_dsocmStoreReq;
    abus_r          <= dsocm_if_C405_dsocmABus;
    be_r            <= dsocm_if_C405_dsocmByteEn;
end
//generate output
assign  dsocm_if_DSOCM_c405Hold                 = 1'b0;//if unused ,tied to 0
assign  dsocm_if_DSOCM_c405DisOperandFwd        = 1'b0;//if unused,tied to 0
assign  dsocm_if_DSOCM_c405RdDBus   = ram_dout;
assign  dsocm_if_DSOCM_c405Complete = op_complete;


assign  ram_cs      = ( load_req_r || store_req_r );//either Load or Store operation
assign  ram_rw      = ( load_req_r == 1'b1 ) ? 1'b1: ( store_req_r == 1'b1 ) ? 1'b0 : 1'b1;
assign  ram_addr    = ( ram_cs == 1'b1 ) ? abus_r : 30'h0;
assign  ram_din     = ( store_req_r == 1'b1 ) ? dsocm_if_C405_dsocmWrDBus : 32'h0;
// generate status signal
always @ ( * )
begin
    if( ram_cs )
        op_complete = 1'b1;
    else
        op_complete = 1'b0;
end
     
//Instance data ram
RA1SH #( 32,30,2048) data_mem(
				//.clk    ( SystemClock   ),
				.cs     ( ram_cs        ),
				.rw     ( ram_rw        ),//1 -- read,0---write
				.addr   ( ram_addr      ),
				.din    ( ram_din       ),
				.dout   ( ram_dout      )
				);
                
endmodule
