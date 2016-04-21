//
//      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARTISAN COMPONENTS, INC.
//      
//      Copyright (c) 2004  Artisan Components, Inc.  All  Rights Reserved.
//      
//      Use of this Software is subject to the terms and conditions  of the
//      applicable license agreement with Artisan Components, Inc. In addition,
//      this Software is protected by patents, copyright law and international
//      treaties.
//      
//      The copyright notice(s) in this Software does not indicate actual or
//      intended publication of this Software.
//      
//      name:			SRAM-SP-HS SRAM Generator
//           			TSMC CL013LV-FSG Process
//      version:		2004Q3V1
//      comment:		
//      configuration:	 -instname sram256x48 -words 256 -bits 48 -frequency 250 -ring_width 2 -mux 8 -drive 6 -write_mask on -wp_size 1 -top_layer met6 -power_type rings -horiz met3 -vert met4 -cust_comment "" -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,GND:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname off -diodes on -inside_ring_type GND
//
//      Verilog model for Synchronous Single-Port Ram
//
//      Instance Name:  sram256x48
//      Words:          256
//      Word Width:     48
//      Pipeline:       No
//
//      Creation Date:  2004-10-20 22:29:18Z
//      Version: 	2004Q3V1
//
//      Verified With: Cadence Verilog-XL
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: The output hold function has been deleted
//          completely from this model.  Most Verilog simulators are 
//          incapable of scheduling more than 1 event on the rising 
//          edge of clock.  Therefore, it is impossible to model
//          the output hold (to x) action correctly.  It is necessary
//          to run static path timing tools using Artisan supplied
//          timing models to insure that the output hold time is
//          sufficient enough to not violate hold time constraints
//          of downstream flip-flops.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
//`timescale 1 ns/1 ps
`celldefine
module sram256x48 (
   Q,
   CLK,
   CEN,
   WEN,
   A,
   D
);
   parameter		   BITS = 48;
   parameter		   word_depth = 256;
   parameter		   addr_width = 8;
   parameter               mask_width = 48 ;
   parameter               wp_size    = 1 ;
   parameter		   maskx = {mask_width{1'bx}};
   parameter		   wordx = {BITS{1'bx}};
   parameter		   addrx = {addr_width{1'bx}};
	
   output [47:0] Q;
   input CLK;
   input CEN;
   input [47:0] WEN;
   input [7:0] A;
   input [47:0] D;

   reg [BITS-1:0]	   mem [word_depth-1:0];

   reg			   NOT_CEN;
   reg			   NOT_WEN0;
   reg			   NOT_WEN1;
   reg			   NOT_WEN2;
   reg			   NOT_WEN3;
   reg			   NOT_WEN4;
   reg			   NOT_WEN5;
   reg			   NOT_WEN6;
   reg			   NOT_WEN7;
   reg			   NOT_WEN8;
   reg			   NOT_WEN9;
   reg			   NOT_WEN10;
   reg			   NOT_WEN11;
   reg			   NOT_WEN12;
   reg			   NOT_WEN13;
   reg			   NOT_WEN14;
   reg			   NOT_WEN15;
   reg			   NOT_WEN16;
   reg			   NOT_WEN17;
   reg			   NOT_WEN18;
   reg			   NOT_WEN19;
   reg			   NOT_WEN20;
   reg			   NOT_WEN21;
   reg			   NOT_WEN22;
   reg			   NOT_WEN23;
   reg			   NOT_WEN24;
   reg			   NOT_WEN25;
   reg			   NOT_WEN26;
   reg			   NOT_WEN27;
   reg			   NOT_WEN28;
   reg			   NOT_WEN29;
   reg			   NOT_WEN30;
   reg			   NOT_WEN31;
   reg			   NOT_WEN32;
   reg			   NOT_WEN33;
   reg			   NOT_WEN34;
   reg			   NOT_WEN35;
   reg			   NOT_WEN36;
   reg			   NOT_WEN37;
   reg			   NOT_WEN38;
   reg			   NOT_WEN39;
   reg			   NOT_WEN40;
   reg			   NOT_WEN41;
   reg			   NOT_WEN42;
   reg			   NOT_WEN43;
   reg			   NOT_WEN44;
   reg			   NOT_WEN45;
   reg			   NOT_WEN46;
   reg			   NOT_WEN47;
   reg [mask_width-1:0]    NOT_WEN;

   reg			   NOT_A0;
   reg			   NOT_A1;
   reg			   NOT_A2;
   reg			   NOT_A3;
   reg			   NOT_A4;
   reg			   NOT_A5;
   reg			   NOT_A6;
   reg			   NOT_A7;
   reg [addr_width-1:0]	   NOT_A;
   reg			   NOT_D0;
   reg			   NOT_D1;
   reg			   NOT_D2;
   reg			   NOT_D3;
   reg			   NOT_D4;
   reg			   NOT_D5;
   reg			   NOT_D6;
   reg			   NOT_D7;
   reg			   NOT_D8;
   reg			   NOT_D9;
   reg			   NOT_D10;
   reg			   NOT_D11;
   reg			   NOT_D12;
   reg			   NOT_D13;
   reg			   NOT_D14;
   reg			   NOT_D15;
   reg			   NOT_D16;
   reg			   NOT_D17;
   reg			   NOT_D18;
   reg			   NOT_D19;
   reg			   NOT_D20;
   reg			   NOT_D21;
   reg			   NOT_D22;
   reg			   NOT_D23;
   reg			   NOT_D24;
   reg			   NOT_D25;
   reg			   NOT_D26;
   reg			   NOT_D27;
   reg			   NOT_D28;
   reg			   NOT_D29;
   reg			   NOT_D30;
   reg			   NOT_D31;
   reg			   NOT_D32;
   reg			   NOT_D33;
   reg			   NOT_D34;
   reg			   NOT_D35;
   reg			   NOT_D36;
   reg			   NOT_D37;
   reg			   NOT_D38;
   reg			   NOT_D39;
   reg			   NOT_D40;
   reg			   NOT_D41;
   reg			   NOT_D42;
   reg			   NOT_D43;
   reg			   NOT_D44;
   reg			   NOT_D45;
   reg			   NOT_D46;
   reg			   NOT_D47;
   reg [BITS-1:0]	   NOT_D;
   reg			   NOT_CLK_PER;
   reg			   NOT_CLK_MINH;
   reg			   NOT_CLK_MINL;

   reg			   LAST_NOT_CEN;
   reg [mask_width-1:0]	   LAST_NOT_WEN;
   reg [addr_width-1:0]	   LAST_NOT_A;
   reg [BITS-1:0]	   LAST_NOT_D;
   reg			   LAST_NOT_CLK_PER;
   reg			   LAST_NOT_CLK_MINH;
   reg			   LAST_NOT_CLK_MINL;


   wire [BITS-1:0]   _Q;
   wire [addr_width-1:0]   _A;
   wire			   _CLK;
   wire			   _CEN;
   wire [mask_width-1:0]   _WEN;

   wire [BITS-1:0]   _D;
   wire                    re_flag;
   wire                    re_data_flag0;
   wire                    re_data_flag1;
   wire                    re_data_flag2;
   wire                    re_data_flag3;
   wire                    re_data_flag4;
   wire                    re_data_flag5;
   wire                    re_data_flag6;
   wire                    re_data_flag7;
   wire                    re_data_flag8;
   wire                    re_data_flag9;
   wire                    re_data_flag10;
   wire                    re_data_flag11;
   wire                    re_data_flag12;
   wire                    re_data_flag13;
   wire                    re_data_flag14;
   wire                    re_data_flag15;
   wire                    re_data_flag16;
   wire                    re_data_flag17;
   wire                    re_data_flag18;
   wire                    re_data_flag19;
   wire                    re_data_flag20;
   wire                    re_data_flag21;
   wire                    re_data_flag22;
   wire                    re_data_flag23;
   wire                    re_data_flag24;
   wire                    re_data_flag25;
   wire                    re_data_flag26;
   wire                    re_data_flag27;
   wire                    re_data_flag28;
   wire                    re_data_flag29;
   wire                    re_data_flag30;
   wire                    re_data_flag31;
   wire                    re_data_flag32;
   wire                    re_data_flag33;
   wire                    re_data_flag34;
   wire                    re_data_flag35;
   wire                    re_data_flag36;
   wire                    re_data_flag37;
   wire                    re_data_flag38;
   wire                    re_data_flag39;
   wire                    re_data_flag40;
   wire                    re_data_flag41;
   wire                    re_data_flag42;
   wire                    re_data_flag43;
   wire                    re_data_flag44;
   wire                    re_data_flag45;
   wire                    re_data_flag46;
   wire                    re_data_flag47;


   reg			   LATCHED_CEN;
   reg	[mask_width-1:0]  LATCHED_WEN;
   reg [addr_width-1:0]	   LATCHED_A;
   reg [BITS-1:0]	   LATCHED_D;

   reg			   CENi;
   reg [mask_width-1:0]	   WENi;
   reg [addr_width-1:0]	   Ai;
   reg [BITS-1:0]	   Di;
   reg [BITS-1:0]	   Qi;
   reg [BITS-1:0]	   LAST_Qi;



   reg			   LAST_CLK;

   reg [BITS-1:0]          dummy;
   integer mask_section ;
   integer lsb, msb  ;




   task update_notifier_buses;
   begin
      NOT_A = {
               NOT_A7,
               NOT_A6,
               NOT_A5,
               NOT_A4,
               NOT_A3,
               NOT_A2,
               NOT_A1,
               NOT_A0};
      NOT_D = {
               NOT_D47,
               NOT_D46,
               NOT_D45,
               NOT_D44,
               NOT_D43,
               NOT_D42,
               NOT_D41,
               NOT_D40,
               NOT_D39,
               NOT_D38,
               NOT_D37,
               NOT_D36,
               NOT_D35,
               NOT_D34,
               NOT_D33,
               NOT_D32,
               NOT_D31,
               NOT_D30,
               NOT_D29,
               NOT_D28,
               NOT_D27,
               NOT_D26,
               NOT_D25,
               NOT_D24,
               NOT_D23,
               NOT_D22,
               NOT_D21,
               NOT_D20,
               NOT_D19,
               NOT_D18,
               NOT_D17,
               NOT_D16,
               NOT_D15,
               NOT_D14,
               NOT_D13,
               NOT_D12,
               NOT_D11,
               NOT_D10,
               NOT_D9,
               NOT_D8,
               NOT_D7,
               NOT_D6,
               NOT_D5,
               NOT_D4,
               NOT_D3,
               NOT_D2,
               NOT_D1,
               NOT_D0};
      NOT_WEN = {
                NOT_WEN47,
                NOT_WEN46,
                NOT_WEN45,
                NOT_WEN44,
                NOT_WEN43,
                NOT_WEN42,
                NOT_WEN41,
                NOT_WEN40,
                NOT_WEN39,
                NOT_WEN38,
                NOT_WEN37,
                NOT_WEN36,
                NOT_WEN35,
                NOT_WEN34,
                NOT_WEN33,
                NOT_WEN32,
                NOT_WEN31,
                NOT_WEN30,
                NOT_WEN29,
                NOT_WEN28,
                NOT_WEN27,
                NOT_WEN26,
                NOT_WEN25,
                NOT_WEN24,
                NOT_WEN23,
                NOT_WEN22,
                NOT_WEN21,
                NOT_WEN20,
                NOT_WEN19,
                NOT_WEN18,
                NOT_WEN17,
                NOT_WEN16,
                NOT_WEN15,
                NOT_WEN14,
                NOT_WEN13,
                NOT_WEN12,
                NOT_WEN11,
                NOT_WEN10,
                NOT_WEN9,
                NOT_WEN8,
                NOT_WEN7,
                NOT_WEN6,
                NOT_WEN5,
                NOT_WEN4,
                NOT_WEN3,
                NOT_WEN2,
                NOT_WEN1,
                NOT_WEN0};
   end
   endtask

   task mem_cycle;
   begin
    for (mask_section=0;mask_section<mask_width; mask_section=mask_section+1)
    begin
      lsb = (mask_section)*(wp_size) ;
      msb = BITS <= (lsb+wp_size-1) ? (BITS-1) : (lsb+wp_size-1) ;
      casez({WENi[mask_section],CENi})

	2'b10: begin
	   read_mem(1,0);
	end
	2'b00: begin
	   write_mem(Ai,Di);
	   read_mem(0,0);
	end
	2'b?1: ;
	2'b1x: begin
	   read_mem(0,1);
	end
	2'bx0: begin
	   write_mem_x(Ai);
	   read_mem(0,1);
	end
	2'b0x,
	2'bxx: begin
	   write_mem_x(Ai);
	   read_mem(0,1);
	end
      endcase
   end
   end
   endtask
      

   task update_last_notifiers;
   begin
      LAST_NOT_A = NOT_A;
      LAST_NOT_D = NOT_D;
      LAST_NOT_WEN = NOT_WEN;
      LAST_NOT_CEN = NOT_CEN;
      LAST_NOT_CLK_PER = NOT_CLK_PER;
      LAST_NOT_CLK_MINH = NOT_CLK_MINH;
      LAST_NOT_CLK_MINL = NOT_CLK_MINL;
   end
   endtask

   task latch_inputs;
   begin
      LATCHED_A = _A ;
      LATCHED_D = _D ;
      LATCHED_WEN = _WEN ;
      LATCHED_CEN = _CEN ;
      LAST_Qi = Qi;
   end
   endtask


   task update_logic;
   begin
      CENi = LATCHED_CEN;
      WENi = LATCHED_WEN;
      Ai = LATCHED_A;
      Di = LATCHED_D;
   end
   endtask



   task x_inputs;
      integer n;
   begin
      for (n=0; n<addr_width; n=n+1)
	 begin
	    LATCHED_A[n] = (NOT_A[n]!==LAST_NOT_A[n]) ? 1'bx : LATCHED_A[n] ;
	 end
      for (n=0; n<BITS; n=n+1)
	 begin
	    LATCHED_D[n] = (NOT_D[n]!==LAST_NOT_D[n]) ? 1'bx : LATCHED_D[n] ;
	 end
      for (n=0; n<mask_width; n=n+1)
	 begin
	    LATCHED_WEN[n] = (NOT_WEN[n]!==LAST_NOT_WEN[n]) ? 1'bx : LATCHED_WEN[n] ;
         end

      LATCHED_CEN = (NOT_CEN!==LAST_NOT_CEN) ? 1'bx : LATCHED_CEN ;
   end
   endtask

   task read_mem;
      input r_wb;
      input xflag;
      integer i ;
   begin
      if (r_wb)
	 begin
	    if (valid_address(Ai))
	       begin
                  dummy = mem[Ai] ;
                  for (i=lsb;i<=msb;i=i+1) Qi[i] = dummy[i] ;
	       end
	    else
	       begin
	          x_mem;
                  for (i=lsb;i<=msb;i=i+1) Qi[i] = 1'bx ;
	       end
	 end
      else
	 begin
	    if (xflag)
	       begin
                  for (i=lsb;i<=msb;i=i+1) Qi[i] = 1'bx ;
	       end
	    else
	       begin
                  for (i=lsb;i<=msb;i=i+1) Qi[i] = dummy[i] ;
	       end
	 end
   end
   endtask

   task write_mem;
      input [addr_width-1:0] a;
      input [BITS-1:0] d;
   integer i;
 
   begin
      casez({valid_address(a)})
	1'b0: 
		begin
			x_mem;
                	for (i=lsb; i<=msb; i=i+1)  dummy[i] = d[i] ;
		end
        1'b1 : begin
		dummy= mem[a];
                for (i=lsb; i<=msb; i=i+1)  dummy[i] = d[i] ;
                mem[a]=dummy;
              end
      endcase
   end
   endtask

   task write_mem_x;
      input [addr_width-1:0] a;
   integer i;
   begin
      casez({valid_address(a)})
	1'b0: 
		begin
			x_mem;
                	for (i=lsb; i<=msb; i=i+1)  dummy[i] = 1'bx ;
		end
        1'b1 : begin
		dummy= mem[a];
                for (i=lsb; i<=msb; i=i+1)  dummy[i] = 1'bx ;
                mem[a]=dummy;
              end
      endcase
   end
   endtask

   task x_mem;
      integer n;
   begin
      for (n=0; n<word_depth; n=n+1)
	 mem[n]=wordx;
   end
   endtask

   task process_violations;
   begin
      if ((NOT_CLK_PER!==LAST_NOT_CLK_PER) ||
	  (NOT_CLK_MINH!==LAST_NOT_CLK_MINH) ||
	  (NOT_CLK_MINL!==LAST_NOT_CLK_MINL))
	 begin
	    if (CENi !== 1'b1)
               begin
		  x_mem;
		  Qi = wordx ;
	       end
	 end
      else
	 begin
	    update_notifier_buses;
	    x_inputs;
	    update_logic;
	    mem_cycle;
	 end
      update_last_notifiers;
   end
   endtask

   function valid_address;
      input [addr_width-1:0] a;
   begin
      valid_address = (^(a) !== 1'bx);
   end
   endfunction


   buf (Q[0], _Q[0]);
   buf (Q[1], _Q[1]);
   buf (Q[2], _Q[2]);
   buf (Q[3], _Q[3]);
   buf (Q[4], _Q[4]);
   buf (Q[5], _Q[5]);
   buf (Q[6], _Q[6]);
   buf (Q[7], _Q[7]);
   buf (Q[8], _Q[8]);
   buf (Q[9], _Q[9]);
   buf (Q[10], _Q[10]);
   buf (Q[11], _Q[11]);
   buf (Q[12], _Q[12]);
   buf (Q[13], _Q[13]);
   buf (Q[14], _Q[14]);
   buf (Q[15], _Q[15]);
   buf (Q[16], _Q[16]);
   buf (Q[17], _Q[17]);
   buf (Q[18], _Q[18]);
   buf (Q[19], _Q[19]);
   buf (Q[20], _Q[20]);
   buf (Q[21], _Q[21]);
   buf (Q[22], _Q[22]);
   buf (Q[23], _Q[23]);
   buf (Q[24], _Q[24]);
   buf (Q[25], _Q[25]);
   buf (Q[26], _Q[26]);
   buf (Q[27], _Q[27]);
   buf (Q[28], _Q[28]);
   buf (Q[29], _Q[29]);
   buf (Q[30], _Q[30]);
   buf (Q[31], _Q[31]);
   buf (Q[32], _Q[32]);
   buf (Q[33], _Q[33]);
   buf (Q[34], _Q[34]);
   buf (Q[35], _Q[35]);
   buf (Q[36], _Q[36]);
   buf (Q[37], _Q[37]);
   buf (Q[38], _Q[38]);
   buf (Q[39], _Q[39]);
   buf (Q[40], _Q[40]);
   buf (Q[41], _Q[41]);
   buf (Q[42], _Q[42]);
   buf (Q[43], _Q[43]);
   buf (Q[44], _Q[44]);
   buf (Q[45], _Q[45]);
   buf (Q[46], _Q[46]);
   buf (Q[47], _Q[47]);
   buf (_D[0], D[0]);
   buf (_D[1], D[1]);
   buf (_D[2], D[2]);
   buf (_D[3], D[3]);
   buf (_D[4], D[4]);
   buf (_D[5], D[5]);
   buf (_D[6], D[6]);
   buf (_D[7], D[7]);
   buf (_D[8], D[8]);
   buf (_D[9], D[9]);
   buf (_D[10], D[10]);
   buf (_D[11], D[11]);
   buf (_D[12], D[12]);
   buf (_D[13], D[13]);
   buf (_D[14], D[14]);
   buf (_D[15], D[15]);
   buf (_D[16], D[16]);
   buf (_D[17], D[17]);
   buf (_D[18], D[18]);
   buf (_D[19], D[19]);
   buf (_D[20], D[20]);
   buf (_D[21], D[21]);
   buf (_D[22], D[22]);
   buf (_D[23], D[23]);
   buf (_D[24], D[24]);
   buf (_D[25], D[25]);
   buf (_D[26], D[26]);
   buf (_D[27], D[27]);
   buf (_D[28], D[28]);
   buf (_D[29], D[29]);
   buf (_D[30], D[30]);
   buf (_D[31], D[31]);
   buf (_D[32], D[32]);
   buf (_D[33], D[33]);
   buf (_D[34], D[34]);
   buf (_D[35], D[35]);
   buf (_D[36], D[36]);
   buf (_D[37], D[37]);
   buf (_D[38], D[38]);
   buf (_D[39], D[39]);
   buf (_D[40], D[40]);
   buf (_D[41], D[41]);
   buf (_D[42], D[42]);
   buf (_D[43], D[43]);
   buf (_D[44], D[44]);
   buf (_D[45], D[45]);
   buf (_D[46], D[46]);
   buf (_D[47], D[47]);
   buf (_A[0], A[0]);
   buf (_A[1], A[1]);
   buf (_A[2], A[2]);
   buf (_A[3], A[3]);
   buf (_A[4], A[4]);
   buf (_A[5], A[5]);
   buf (_A[6], A[6]);
   buf (_A[7], A[7]);
   buf (_CLK, CLK);
   buf (_WEN[0], WEN[0]);
   buf (_WEN[1], WEN[1]);
   buf (_WEN[2], WEN[2]);
   buf (_WEN[3], WEN[3]);
   buf (_WEN[4], WEN[4]);
   buf (_WEN[5], WEN[5]);
   buf (_WEN[6], WEN[6]);
   buf (_WEN[7], WEN[7]);
   buf (_WEN[8], WEN[8]);
   buf (_WEN[9], WEN[9]);
   buf (_WEN[10], WEN[10]);
   buf (_WEN[11], WEN[11]);
   buf (_WEN[12], WEN[12]);
   buf (_WEN[13], WEN[13]);
   buf (_WEN[14], WEN[14]);
   buf (_WEN[15], WEN[15]);
   buf (_WEN[16], WEN[16]);
   buf (_WEN[17], WEN[17]);
   buf (_WEN[18], WEN[18]);
   buf (_WEN[19], WEN[19]);
   buf (_WEN[20], WEN[20]);
   buf (_WEN[21], WEN[21]);
   buf (_WEN[22], WEN[22]);
   buf (_WEN[23], WEN[23]);
   buf (_WEN[24], WEN[24]);
   buf (_WEN[25], WEN[25]);
   buf (_WEN[26], WEN[26]);
   buf (_WEN[27], WEN[27]);
   buf (_WEN[28], WEN[28]);
   buf (_WEN[29], WEN[29]);
   buf (_WEN[30], WEN[30]);
   buf (_WEN[31], WEN[31]);
   buf (_WEN[32], WEN[32]);
   buf (_WEN[33], WEN[33]);
   buf (_WEN[34], WEN[34]);
   buf (_WEN[35], WEN[35]);
   buf (_WEN[36], WEN[36]);
   buf (_WEN[37], WEN[37]);
   buf (_WEN[38], WEN[38]);
   buf (_WEN[39], WEN[39]);
   buf (_WEN[40], WEN[40]);
   buf (_WEN[41], WEN[41]);
   buf (_WEN[42], WEN[42]);
   buf (_WEN[43], WEN[43]);
   buf (_WEN[44], WEN[44]);
   buf (_WEN[45], WEN[45]);
   buf (_WEN[46], WEN[46]);
   buf (_WEN[47], WEN[47]);
   buf (_CEN, CEN);


   assign _Q = Qi;
   assign re_flag = !(_CEN);
   assign re_data_flag0 = !(_CEN || _WEN[0]);
   assign re_data_flag1 = !(_CEN || _WEN[1]);
   assign re_data_flag2 = !(_CEN || _WEN[2]);
   assign re_data_flag3 = !(_CEN || _WEN[3]);
   assign re_data_flag4 = !(_CEN || _WEN[4]);
   assign re_data_flag5 = !(_CEN || _WEN[5]);
   assign re_data_flag6 = !(_CEN || _WEN[6]);
   assign re_data_flag7 = !(_CEN || _WEN[7]);
   assign re_data_flag8 = !(_CEN || _WEN[8]);
   assign re_data_flag9 = !(_CEN || _WEN[9]);
   assign re_data_flag10 = !(_CEN || _WEN[10]);
   assign re_data_flag11 = !(_CEN || _WEN[11]);
   assign re_data_flag12 = !(_CEN || _WEN[12]);
   assign re_data_flag13 = !(_CEN || _WEN[13]);
   assign re_data_flag14 = !(_CEN || _WEN[14]);
   assign re_data_flag15 = !(_CEN || _WEN[15]);
   assign re_data_flag16 = !(_CEN || _WEN[16]);
   assign re_data_flag17 = !(_CEN || _WEN[17]);
   assign re_data_flag18 = !(_CEN || _WEN[18]);
   assign re_data_flag19 = !(_CEN || _WEN[19]);
   assign re_data_flag20 = !(_CEN || _WEN[20]);
   assign re_data_flag21 = !(_CEN || _WEN[21]);
   assign re_data_flag22 = !(_CEN || _WEN[22]);
   assign re_data_flag23 = !(_CEN || _WEN[23]);
   assign re_data_flag24 = !(_CEN || _WEN[24]);
   assign re_data_flag25 = !(_CEN || _WEN[25]);
   assign re_data_flag26 = !(_CEN || _WEN[26]);
   assign re_data_flag27 = !(_CEN || _WEN[27]);
   assign re_data_flag28 = !(_CEN || _WEN[28]);
   assign re_data_flag29 = !(_CEN || _WEN[29]);
   assign re_data_flag30 = !(_CEN || _WEN[30]);
   assign re_data_flag31 = !(_CEN || _WEN[31]);
   assign re_data_flag32 = !(_CEN || _WEN[32]);
   assign re_data_flag33 = !(_CEN || _WEN[33]);
   assign re_data_flag34 = !(_CEN || _WEN[34]);
   assign re_data_flag35 = !(_CEN || _WEN[35]);
   assign re_data_flag36 = !(_CEN || _WEN[36]);
   assign re_data_flag37 = !(_CEN || _WEN[37]);
   assign re_data_flag38 = !(_CEN || _WEN[38]);
   assign re_data_flag39 = !(_CEN || _WEN[39]);
   assign re_data_flag40 = !(_CEN || _WEN[40]);
   assign re_data_flag41 = !(_CEN || _WEN[41]);
   assign re_data_flag42 = !(_CEN || _WEN[42]);
   assign re_data_flag43 = !(_CEN || _WEN[43]);
   assign re_data_flag44 = !(_CEN || _WEN[44]);
   assign re_data_flag45 = !(_CEN || _WEN[45]);
   assign re_data_flag46 = !(_CEN || _WEN[46]);
   assign re_data_flag47 = !(_CEN || _WEN[47]);


   always @(
	    NOT_A0 or
	    NOT_A1 or
	    NOT_A2 or
	    NOT_A3 or
	    NOT_A4 or
	    NOT_A5 or
	    NOT_A6 or
	    NOT_A7 or
	    NOT_D0 or
	    NOT_D1 or
	    NOT_D2 or
	    NOT_D3 or
	    NOT_D4 or
	    NOT_D5 or
	    NOT_D6 or
	    NOT_D7 or
	    NOT_D8 or
	    NOT_D9 or
	    NOT_D10 or
	    NOT_D11 or
	    NOT_D12 or
	    NOT_D13 or
	    NOT_D14 or
	    NOT_D15 or
	    NOT_D16 or
	    NOT_D17 or
	    NOT_D18 or
	    NOT_D19 or
	    NOT_D20 or
	    NOT_D21 or
	    NOT_D22 or
	    NOT_D23 or
	    NOT_D24 or
	    NOT_D25 or
	    NOT_D26 or
	    NOT_D27 or
	    NOT_D28 or
	    NOT_D29 or
	    NOT_D30 or
	    NOT_D31 or
	    NOT_D32 or
	    NOT_D33 or
	    NOT_D34 or
	    NOT_D35 or
	    NOT_D36 or
	    NOT_D37 or
	    NOT_D38 or
	    NOT_D39 or
	    NOT_D40 or
	    NOT_D41 or
	    NOT_D42 or
	    NOT_D43 or
	    NOT_D44 or
	    NOT_D45 or
	    NOT_D46 or
	    NOT_D47 or
	    NOT_WEN0 or
	    NOT_WEN1 or
	    NOT_WEN2 or
	    NOT_WEN3 or
	    NOT_WEN4 or
	    NOT_WEN5 or
	    NOT_WEN6 or
	    NOT_WEN7 or
	    NOT_WEN8 or
	    NOT_WEN9 or
	    NOT_WEN10 or
	    NOT_WEN11 or
	    NOT_WEN12 or
	    NOT_WEN13 or
	    NOT_WEN14 or
	    NOT_WEN15 or
	    NOT_WEN16 or
	    NOT_WEN17 or
	    NOT_WEN18 or
	    NOT_WEN19 or
	    NOT_WEN20 or
	    NOT_WEN21 or
	    NOT_WEN22 or
	    NOT_WEN23 or
	    NOT_WEN24 or
	    NOT_WEN25 or
	    NOT_WEN26 or
	    NOT_WEN27 or
	    NOT_WEN28 or
	    NOT_WEN29 or
	    NOT_WEN30 or
	    NOT_WEN31 or
	    NOT_WEN32 or
	    NOT_WEN33 or
	    NOT_WEN34 or
	    NOT_WEN35 or
	    NOT_WEN36 or
	    NOT_WEN37 or
	    NOT_WEN38 or
	    NOT_WEN39 or
	    NOT_WEN40 or
	    NOT_WEN41 or
	    NOT_WEN42 or
	    NOT_WEN43 or
	    NOT_WEN44 or
	    NOT_WEN45 or
	    NOT_WEN46 or
	    NOT_WEN47 or
	    NOT_CEN or
	    NOT_CLK_PER or
	    NOT_CLK_MINH or
	    NOT_CLK_MINL
	    )
      begin
         process_violations;
      end

   always @( _CLK )
      begin
         casez({LAST_CLK,_CLK})
	   2'b01: begin
	      latch_inputs;
	      update_logic;
	      mem_cycle;
	   end

	   2'b10,
	   2'bx?,
	   2'b00,
	   2'b11: ;

	   2'b?x: begin
	      x_mem;
              read_mem(0,1);
	   end
	   
	 endcase
	 LAST_CLK = _CLK;
      end
/*
   specify
      $setuphold(posedge CLK, posedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK, negedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[0], 1.000, 0.500, NOT_WEN0);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[0], 1.000, 0.500, NOT_WEN0);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[1], 1.000, 0.500, NOT_WEN1);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[1], 1.000, 0.500, NOT_WEN1);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[2], 1.000, 0.500, NOT_WEN2);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[2], 1.000, 0.500, NOT_WEN2);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[3], 1.000, 0.500, NOT_WEN3);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[3], 1.000, 0.500, NOT_WEN3);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[4], 1.000, 0.500, NOT_WEN4);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[4], 1.000, 0.500, NOT_WEN4);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[5], 1.000, 0.500, NOT_WEN5);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[5], 1.000, 0.500, NOT_WEN5);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[6], 1.000, 0.500, NOT_WEN6);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[6], 1.000, 0.500, NOT_WEN6);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[7], 1.000, 0.500, NOT_WEN7);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[7], 1.000, 0.500, NOT_WEN7);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[8], 1.000, 0.500, NOT_WEN8);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[8], 1.000, 0.500, NOT_WEN8);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[9], 1.000, 0.500, NOT_WEN9);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[9], 1.000, 0.500, NOT_WEN9);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[10], 1.000, 0.500, NOT_WEN10);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[10], 1.000, 0.500, NOT_WEN10);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[11], 1.000, 0.500, NOT_WEN11);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[11], 1.000, 0.500, NOT_WEN11);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[12], 1.000, 0.500, NOT_WEN12);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[12], 1.000, 0.500, NOT_WEN12);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[13], 1.000, 0.500, NOT_WEN13);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[13], 1.000, 0.500, NOT_WEN13);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[14], 1.000, 0.500, NOT_WEN14);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[14], 1.000, 0.500, NOT_WEN14);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[15], 1.000, 0.500, NOT_WEN15);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[15], 1.000, 0.500, NOT_WEN15);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[16], 1.000, 0.500, NOT_WEN16);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[16], 1.000, 0.500, NOT_WEN16);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[17], 1.000, 0.500, NOT_WEN17);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[17], 1.000, 0.500, NOT_WEN17);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[18], 1.000, 0.500, NOT_WEN18);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[18], 1.000, 0.500, NOT_WEN18);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[19], 1.000, 0.500, NOT_WEN19);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[19], 1.000, 0.500, NOT_WEN19);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[20], 1.000, 0.500, NOT_WEN20);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[20], 1.000, 0.500, NOT_WEN20);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[21], 1.000, 0.500, NOT_WEN21);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[21], 1.000, 0.500, NOT_WEN21);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[22], 1.000, 0.500, NOT_WEN22);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[22], 1.000, 0.500, NOT_WEN22);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[23], 1.000, 0.500, NOT_WEN23);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[23], 1.000, 0.500, NOT_WEN23);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[24], 1.000, 0.500, NOT_WEN24);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[24], 1.000, 0.500, NOT_WEN24);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[25], 1.000, 0.500, NOT_WEN25);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[25], 1.000, 0.500, NOT_WEN25);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[26], 1.000, 0.500, NOT_WEN26);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[26], 1.000, 0.500, NOT_WEN26);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[27], 1.000, 0.500, NOT_WEN27);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[27], 1.000, 0.500, NOT_WEN27);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[28], 1.000, 0.500, NOT_WEN28);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[28], 1.000, 0.500, NOT_WEN28);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[29], 1.000, 0.500, NOT_WEN29);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[29], 1.000, 0.500, NOT_WEN29);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[30], 1.000, 0.500, NOT_WEN30);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[30], 1.000, 0.500, NOT_WEN30);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[31], 1.000, 0.500, NOT_WEN31);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[31], 1.000, 0.500, NOT_WEN31);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[32], 1.000, 0.500, NOT_WEN32);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[32], 1.000, 0.500, NOT_WEN32);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[33], 1.000, 0.500, NOT_WEN33);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[33], 1.000, 0.500, NOT_WEN33);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[34], 1.000, 0.500, NOT_WEN34);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[34], 1.000, 0.500, NOT_WEN34);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[35], 1.000, 0.500, NOT_WEN35);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[35], 1.000, 0.500, NOT_WEN35);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[36], 1.000, 0.500, NOT_WEN36);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[36], 1.000, 0.500, NOT_WEN36);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[37], 1.000, 0.500, NOT_WEN37);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[37], 1.000, 0.500, NOT_WEN37);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[38], 1.000, 0.500, NOT_WEN38);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[38], 1.000, 0.500, NOT_WEN38);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[39], 1.000, 0.500, NOT_WEN39);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[39], 1.000, 0.500, NOT_WEN39);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[40], 1.000, 0.500, NOT_WEN40);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[40], 1.000, 0.500, NOT_WEN40);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[41], 1.000, 0.500, NOT_WEN41);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[41], 1.000, 0.500, NOT_WEN41);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[42], 1.000, 0.500, NOT_WEN42);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[42], 1.000, 0.500, NOT_WEN42);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[43], 1.000, 0.500, NOT_WEN43);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[43], 1.000, 0.500, NOT_WEN43);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[44], 1.000, 0.500, NOT_WEN44);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[44], 1.000, 0.500, NOT_WEN44);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[45], 1.000, 0.500, NOT_WEN45);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[45], 1.000, 0.500, NOT_WEN45);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[46], 1.000, 0.500, NOT_WEN46);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[46], 1.000, 0.500, NOT_WEN46);
      $setuphold(posedge CLK &&& re_flag, posedge WEN[47], 1.000, 0.500, NOT_WEN47);
      $setuphold(posedge CLK &&& re_flag, negedge WEN[47], 1.000, 0.500, NOT_WEN47);
      $setuphold(posedge CLK &&& re_flag, posedge A[0], 1.000, 0.500, NOT_A0);
      $setuphold(posedge CLK &&& re_flag, negedge A[0], 1.000, 0.500, NOT_A0);
      $setuphold(posedge CLK &&& re_flag, posedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& re_flag, negedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& re_flag, posedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& re_flag, negedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& re_flag, posedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& re_flag, negedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& re_flag, posedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& re_flag, negedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& re_flag, posedge A[5], 1.000, 0.500, NOT_A5);
      $setuphold(posedge CLK &&& re_flag, negedge A[5], 1.000, 0.500, NOT_A5);
      $setuphold(posedge CLK &&& re_flag, posedge A[6], 1.000, 0.500, NOT_A6);
      $setuphold(posedge CLK &&& re_flag, negedge A[6], 1.000, 0.500, NOT_A6);
      $setuphold(posedge CLK &&& re_flag, posedge A[7], 1.000, 0.500, NOT_A7);
      $setuphold(posedge CLK &&& re_flag, negedge A[7], 1.000, 0.500, NOT_A7);
      $setuphold(posedge CLK &&& re_data_flag0, posedge D[0],1.000, 0.500, NOT_D0);
      $setuphold(posedge CLK &&& re_data_flag0, negedge D[0],1.000, 0.500, NOT_D0);
      $setuphold(posedge CLK &&& re_data_flag1, posedge D[1],1.000, 0.500, NOT_D1);
      $setuphold(posedge CLK &&& re_data_flag1, negedge D[1],1.000, 0.500, NOT_D1);
      $setuphold(posedge CLK &&& re_data_flag2, posedge D[2],1.000, 0.500, NOT_D2);
      $setuphold(posedge CLK &&& re_data_flag2, negedge D[2],1.000, 0.500, NOT_D2);
      $setuphold(posedge CLK &&& re_data_flag3, posedge D[3],1.000, 0.500, NOT_D3);
      $setuphold(posedge CLK &&& re_data_flag3, negedge D[3],1.000, 0.500, NOT_D3);
      $setuphold(posedge CLK &&& re_data_flag4, posedge D[4],1.000, 0.500, NOT_D4);
      $setuphold(posedge CLK &&& re_data_flag4, negedge D[4],1.000, 0.500, NOT_D4);
      $setuphold(posedge CLK &&& re_data_flag5, posedge D[5],1.000, 0.500, NOT_D5);
      $setuphold(posedge CLK &&& re_data_flag5, negedge D[5],1.000, 0.500, NOT_D5);
      $setuphold(posedge CLK &&& re_data_flag6, posedge D[6],1.000, 0.500, NOT_D6);
      $setuphold(posedge CLK &&& re_data_flag6, negedge D[6],1.000, 0.500, NOT_D6);
      $setuphold(posedge CLK &&& re_data_flag7, posedge D[7],1.000, 0.500, NOT_D7);
      $setuphold(posedge CLK &&& re_data_flag7, negedge D[7],1.000, 0.500, NOT_D7);
      $setuphold(posedge CLK &&& re_data_flag8, posedge D[8],1.000, 0.500, NOT_D8);
      $setuphold(posedge CLK &&& re_data_flag8, negedge D[8],1.000, 0.500, NOT_D8);
      $setuphold(posedge CLK &&& re_data_flag9, posedge D[9],1.000, 0.500, NOT_D9);
      $setuphold(posedge CLK &&& re_data_flag9, negedge D[9],1.000, 0.500, NOT_D9);
      $setuphold(posedge CLK &&& re_data_flag10, posedge D[10],1.000, 0.500, NOT_D10);
      $setuphold(posedge CLK &&& re_data_flag10, negedge D[10],1.000, 0.500, NOT_D10);
      $setuphold(posedge CLK &&& re_data_flag11, posedge D[11],1.000, 0.500, NOT_D11);
      $setuphold(posedge CLK &&& re_data_flag11, negedge D[11],1.000, 0.500, NOT_D11);
      $setuphold(posedge CLK &&& re_data_flag12, posedge D[12],1.000, 0.500, NOT_D12);
      $setuphold(posedge CLK &&& re_data_flag12, negedge D[12],1.000, 0.500, NOT_D12);
      $setuphold(posedge CLK &&& re_data_flag13, posedge D[13],1.000, 0.500, NOT_D13);
      $setuphold(posedge CLK &&& re_data_flag13, negedge D[13],1.000, 0.500, NOT_D13);
      $setuphold(posedge CLK &&& re_data_flag14, posedge D[14],1.000, 0.500, NOT_D14);
      $setuphold(posedge CLK &&& re_data_flag14, negedge D[14],1.000, 0.500, NOT_D14);
      $setuphold(posedge CLK &&& re_data_flag15, posedge D[15],1.000, 0.500, NOT_D15);
      $setuphold(posedge CLK &&& re_data_flag15, negedge D[15],1.000, 0.500, NOT_D15);
      $setuphold(posedge CLK &&& re_data_flag16, posedge D[16],1.000, 0.500, NOT_D16);
      $setuphold(posedge CLK &&& re_data_flag16, negedge D[16],1.000, 0.500, NOT_D16);
      $setuphold(posedge CLK &&& re_data_flag17, posedge D[17],1.000, 0.500, NOT_D17);
      $setuphold(posedge CLK &&& re_data_flag17, negedge D[17],1.000, 0.500, NOT_D17);
      $setuphold(posedge CLK &&& re_data_flag18, posedge D[18],1.000, 0.500, NOT_D18);
      $setuphold(posedge CLK &&& re_data_flag18, negedge D[18],1.000, 0.500, NOT_D18);
      $setuphold(posedge CLK &&& re_data_flag19, posedge D[19],1.000, 0.500, NOT_D19);
      $setuphold(posedge CLK &&& re_data_flag19, negedge D[19],1.000, 0.500, NOT_D19);
      $setuphold(posedge CLK &&& re_data_flag20, posedge D[20],1.000, 0.500, NOT_D20);
      $setuphold(posedge CLK &&& re_data_flag20, negedge D[20],1.000, 0.500, NOT_D20);
      $setuphold(posedge CLK &&& re_data_flag21, posedge D[21],1.000, 0.500, NOT_D21);
      $setuphold(posedge CLK &&& re_data_flag21, negedge D[21],1.000, 0.500, NOT_D21);
      $setuphold(posedge CLK &&& re_data_flag22, posedge D[22],1.000, 0.500, NOT_D22);
      $setuphold(posedge CLK &&& re_data_flag22, negedge D[22],1.000, 0.500, NOT_D22);
      $setuphold(posedge CLK &&& re_data_flag23, posedge D[23],1.000, 0.500, NOT_D23);
      $setuphold(posedge CLK &&& re_data_flag23, negedge D[23],1.000, 0.500, NOT_D23);
      $setuphold(posedge CLK &&& re_data_flag24, posedge D[24],1.000, 0.500, NOT_D24);
      $setuphold(posedge CLK &&& re_data_flag24, negedge D[24],1.000, 0.500, NOT_D24);
      $setuphold(posedge CLK &&& re_data_flag25, posedge D[25],1.000, 0.500, NOT_D25);
      $setuphold(posedge CLK &&& re_data_flag25, negedge D[25],1.000, 0.500, NOT_D25);
      $setuphold(posedge CLK &&& re_data_flag26, posedge D[26],1.000, 0.500, NOT_D26);
      $setuphold(posedge CLK &&& re_data_flag26, negedge D[26],1.000, 0.500, NOT_D26);
      $setuphold(posedge CLK &&& re_data_flag27, posedge D[27],1.000, 0.500, NOT_D27);
      $setuphold(posedge CLK &&& re_data_flag27, negedge D[27],1.000, 0.500, NOT_D27);
      $setuphold(posedge CLK &&& re_data_flag28, posedge D[28],1.000, 0.500, NOT_D28);
      $setuphold(posedge CLK &&& re_data_flag28, negedge D[28],1.000, 0.500, NOT_D28);
      $setuphold(posedge CLK &&& re_data_flag29, posedge D[29],1.000, 0.500, NOT_D29);
      $setuphold(posedge CLK &&& re_data_flag29, negedge D[29],1.000, 0.500, NOT_D29);
      $setuphold(posedge CLK &&& re_data_flag30, posedge D[30],1.000, 0.500, NOT_D30);
      $setuphold(posedge CLK &&& re_data_flag30, negedge D[30],1.000, 0.500, NOT_D30);
      $setuphold(posedge CLK &&& re_data_flag31, posedge D[31],1.000, 0.500, NOT_D31);
      $setuphold(posedge CLK &&& re_data_flag31, negedge D[31],1.000, 0.500, NOT_D31);
      $setuphold(posedge CLK &&& re_data_flag32, posedge D[32],1.000, 0.500, NOT_D32);
      $setuphold(posedge CLK &&& re_data_flag32, negedge D[32],1.000, 0.500, NOT_D32);
      $setuphold(posedge CLK &&& re_data_flag33, posedge D[33],1.000, 0.500, NOT_D33);
      $setuphold(posedge CLK &&& re_data_flag33, negedge D[33],1.000, 0.500, NOT_D33);
      $setuphold(posedge CLK &&& re_data_flag34, posedge D[34],1.000, 0.500, NOT_D34);
      $setuphold(posedge CLK &&& re_data_flag34, negedge D[34],1.000, 0.500, NOT_D34);
      $setuphold(posedge CLK &&& re_data_flag35, posedge D[35],1.000, 0.500, NOT_D35);
      $setuphold(posedge CLK &&& re_data_flag35, negedge D[35],1.000, 0.500, NOT_D35);
      $setuphold(posedge CLK &&& re_data_flag36, posedge D[36],1.000, 0.500, NOT_D36);
      $setuphold(posedge CLK &&& re_data_flag36, negedge D[36],1.000, 0.500, NOT_D36);
      $setuphold(posedge CLK &&& re_data_flag37, posedge D[37],1.000, 0.500, NOT_D37);
      $setuphold(posedge CLK &&& re_data_flag37, negedge D[37],1.000, 0.500, NOT_D37);
      $setuphold(posedge CLK &&& re_data_flag38, posedge D[38],1.000, 0.500, NOT_D38);
      $setuphold(posedge CLK &&& re_data_flag38, negedge D[38],1.000, 0.500, NOT_D38);
      $setuphold(posedge CLK &&& re_data_flag39, posedge D[39],1.000, 0.500, NOT_D39);
      $setuphold(posedge CLK &&& re_data_flag39, negedge D[39],1.000, 0.500, NOT_D39);
      $setuphold(posedge CLK &&& re_data_flag40, posedge D[40],1.000, 0.500, NOT_D40);
      $setuphold(posedge CLK &&& re_data_flag40, negedge D[40],1.000, 0.500, NOT_D40);
      $setuphold(posedge CLK &&& re_data_flag41, posedge D[41],1.000, 0.500, NOT_D41);
      $setuphold(posedge CLK &&& re_data_flag41, negedge D[41],1.000, 0.500, NOT_D41);
      $setuphold(posedge CLK &&& re_data_flag42, posedge D[42],1.000, 0.500, NOT_D42);
      $setuphold(posedge CLK &&& re_data_flag42, negedge D[42],1.000, 0.500, NOT_D42);
      $setuphold(posedge CLK &&& re_data_flag43, posedge D[43],1.000, 0.500, NOT_D43);
      $setuphold(posedge CLK &&& re_data_flag43, negedge D[43],1.000, 0.500, NOT_D43);
      $setuphold(posedge CLK &&& re_data_flag44, posedge D[44],1.000, 0.500, NOT_D44);
      $setuphold(posedge CLK &&& re_data_flag44, negedge D[44],1.000, 0.500, NOT_D44);
      $setuphold(posedge CLK &&& re_data_flag45, posedge D[45],1.000, 0.500, NOT_D45);
      $setuphold(posedge CLK &&& re_data_flag45, negedge D[45],1.000, 0.500, NOT_D45);
      $setuphold(posedge CLK &&& re_data_flag46, posedge D[46],1.000, 0.500, NOT_D46);
      $setuphold(posedge CLK &&& re_data_flag46, negedge D[46],1.000, 0.500, NOT_D46);
      $setuphold(posedge CLK &&& re_data_flag47, posedge D[47],1.000, 0.500, NOT_D47);
      $setuphold(posedge CLK &&& re_data_flag47, negedge D[47],1.000, 0.500, NOT_D47);

      $period(posedge CLK, 3.000, NOT_CLK_PER);
      $width(posedge CLK, 1.000, 0, NOT_CLK_MINH);
      $width(negedge CLK, 1.000, 0, NOT_CLK_MINL);

      (CLK => Q[0])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[1])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[2])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[3])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[4])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[5])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[6])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[7])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[8])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[9])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[10])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[11])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[12])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[13])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[14])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[15])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[16])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[17])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[18])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[19])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[20])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[21])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[22])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[23])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[24])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[25])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[26])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[27])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[28])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[29])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[30])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[31])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[32])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[33])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[34])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[35])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[36])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[37])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[38])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[39])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[40])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[41])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[42])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[43])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[44])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[45])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[46])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLK => Q[47])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
   endspecify
*/
endmodule
`endcelldefine
