//===============================================================================
//  File Name       : p405s_isocm_shell.v
//  File Revision   : 1.0
//  Date            : 2014/3/5
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  History         : 
//  ----------------------------------------------------------------------------
//  Description     : instruction side on-chip memory            
//  Function        : an area of code storage
//  ----------------------------------------------------------------------------
// Copyright (c) 2013,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module p405s_isocm_shell(
              SystemClock,
              isocm_if_C405_isocmReqPending,
              isocm_if_C405_isocmIcuReady,
              isocm_if_C405_isocmABus,
              isocm_if_C405_isocmAbort,
              isocm_if_C405_isocmContextSync, //not used
              isocm_if_C405_isocmXlateValid,
              isocm_if_C405_isocmU0Attr,      //not used
              isocm_if_C405_isocmCacheable,   //not used
              isocm_if_reset_n,     //not used
              
              isocm_if_ISOCM_c405Hold,
              isocm_if_ISOCM_c405RdDValid,
              isocm_if_ISOCM_c405RdDBus
              );

//===============================================================================
// I/O declaration
//===============================================================================              
input         SystemClock;
input         isocm_if_C405_isocmReqPending; //CPU's instruction fetcher has a request pending(not necessarily a request cycle).
                                             //When a request is presented across the interface, the instruction-side OCM macro must
                                             //respond in the next cycle.
input         isocm_if_C405_isocmIcuReady;   //ICU(instruction cache unit) is able to accept request.
input  [0:29] isocm_if_C405_isocmABus;       //Address of the instruction(s) being requested by the CPU.
input         isocm_if_C405_isocmAbort;      //An outstanding instruction-side OCM transfer request is being aborted.
input         isocm_if_C405_isocmContextSync;//Context synchronization required is required.
input         isocm_if_C405_isocmXlateValid; //Authorizes access of requested address and validates storage attributes.
input         isocm_if_C405_isocmU0Attr;     //Value of the user-defined storage attribute for the target address.
input         isocm_if_C405_isocmCacheable;  //Value of the cacheability storage attribute for the target address.
input         isocm_if_reset_n;

output        isocm_if_ISOCM_c405Hold;       //Instruction-side OCM is working on the request but is unable to complete the 
                                             //transfer in the current cycle.
output [0: 1] isocm_if_ISOCM_c405RdDValid;   //Validates instruction-side OCM read data.
                                             //Bit 0:Even data valid on RdDBus( 0:31)
                                             //Bit 1: Odd data valid on RdDBus(32:63)
output [0:63] isocm_if_ISOCM_c405RdDBus;     //Instruction-side OCM read data bus-the 64-bit memory-aligned data bus used to
                                             //transfer instructions to the CPU.

wire          ValidRequest;
wire          ServiceableRequest;
wire   [0:31] Ins_eve;
wire   [0:31] Ins_odd;
reg    [0:29] ABusL2;
reg    [0: 1] isocm_if_ISOCM_c405RdDValid;

assign        ValidRequest = (isocm_if_C405_isocmReqPending & isocm_if_C405_isocmIcuReady) |//Non-instruction-side OCM request just finished
                             (isocm_if_C405_isocmReqPending & isocm_if_C405_isocmAbort)    |//Abort previous instruction-side OCM request for new
                             (isocm_if_C405_isocmReqPending & isocm_if_C405_isocmXlateValid & isocm_if_ISOCM_c405RdDValid[1]);
                             //Previous instruction-side OCM request waiting for XlateValid
assign        ServiceableRequest = ( isocm_if_C405_isocmABus >= 0 && isocm_if_C405_isocmABus <= ins_mem.DEPTH ) ? 1'b1 : 1'b0;
assign        isocm_if_ISOCM_c405RdDBus[ 0:31] = isocm_if_ISOCM_c405RdDValid[0] ? Ins_eve :  32'h0;
assign        isocm_if_ISOCM_c405RdDBus[32:63] = isocm_if_ISOCM_c405RdDValid[1] ? Ins_odd :  32'h0;
assign        isocm_if_ISOCM_c405Hold = 1'b0;

always @ ( posedge SystemClock )
begin
  if ( !ServiceableRequest )
    isocm_if_ISOCM_c405RdDValid <= 2'b00;
  else if (ValidRequest)
  begin
    isocm_if_ISOCM_c405RdDValid[0] <= ValidRequest & ServiceableRequest & ~isocm_if_C405_isocmABus[29];
    isocm_if_ISOCM_c405RdDValid[1] <= ValidRequest & ServiceableRequest;
  end
  else if (isocm_if_C405_isocmXlateValid | isocm_if_C405_isocmAbort)//?
  begin
    isocm_if_ISOCM_c405RdDValid <= 2'b00;
  end
  else
    isocm_if_ISOCM_c405RdDValid <= isocm_if_ISOCM_c405RdDValid;
end

always @ ( posedge SystemClock )
begin
  if (ValidRequest)
    ABusL2 <= isocm_if_C405_isocmABus;
  else
    ABusL2 <= ABusL2;
end

RO1SH	#(32,30,2048) ins_mem (
                .cs			(	1'b1		),
                .addr		(	{ABusL2[0:28],1'b0}),
                .dout_eve( Ins_eve ),
                .dout_odd( Ins_odd )
                );
          
endmodule
