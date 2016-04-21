//===============================================================================
//  File Name       : vsfx_top.v
//  File Revision   : 2.0
//  Date            : 2015/4/7
//  Author          : wangjie
//  Email           : ycyquick@foxmail.com
//  ----------------------------------------------------------------------------
//  Description     : vsfx_Top module (for students)
//  Function        : vsfx top level
//  ----------------------------------------------------------------------------
// Copyright (c) 2015,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
// ==============================================================================

//===============================================================================

module vsfx_top(
                 clk,
                 en,
                 vra,
                 vrb,
                 ins,

                 vrt_en,
                 vrt,
                 sat,
                 cr6
                 );

//===============================================================================
// I/O declaration
//===============================================================================
input            clk;
input            en;    //0 = disable
                        //1 = enable
input  [127 : 0] vra;
input  [127 : 0] vrb;
input  [  7 : 0] ins;   //ins[21:25],ins[28:30] of the 32-bit ins
output           vrt_en;//enable signal of output operand
output [127 : 0] vrt;
output           sat;   //saturation bit of Vector Status and Control Register
output [  3 : 0] cr6;   //condition register field 6(bit [20:23] of [0:31])

//===============================================================================
// wire declaration
//===============================================================================

reg                  vrt_en;

reg        [127 : 0] vrt;
wire	   [127 : 0] vra;
wire	   [127 : 0] vrb;
wire	   [31 : 0] vra0;
wire	   [31 : 0] vrb0;
wire	   [31 : 0] vra1;
wire	   [31 : 0] vrb1;
wire	   [31 : 0] vra2;
wire	   [31 : 0] vrb2;
wire	   [31 : 0] vra3;
wire	   [31 : 0] vrb3;

wire       [127 : 0] add_vrt;
wire       [127 : 0] sub_vrt;
wire       [127 : 0] cmp_vrt;
wire       [127 : 0] avg_vrt;
wire       [127 : 0] shi_vrt;
wire	   [31 : 0] add_vrt0;
wire	   [31 : 0] add_vrt1;
wire	   [31 : 0] add_vrt2;
wire	   [31 : 0] add_vrt3;
wire	   [31 : 0] sub_vrt0;
wire	   [31 : 0] sub_vrt1;
wire	   [31 : 0] sub_vrt2;
wire	   [31 : 0] sub_vrt3;
wire	   [31 : 0] cmp_vrt0;
wire	   [31 : 0] cmp_vrt1;
wire	   [31 : 0] cmp_vrt2;
wire	   [31 : 0] cmp_vrt3;
wire	   [31 : 0] avg_vrt0;
wire	   [31 : 0] avg_vrt1;
wire	   [31 : 0] avg_vrt2;
wire	   [31 : 0] avg_vrt3;
wire	   [31 : 0] shi_vrt0;
wire	   [31 : 0] shi_vrt1;
wire	   [31 : 0] shi_vrt2;
wire	   [31 : 0] shi_vrt3;

wire                sat0;
wire                sat1;
wire                sat2;
wire                sat3;
reg                 sat;

reg                 t;
reg                 f;
reg         [3 : 0] cr6;

//assign vra = 128'h111111111234567800000000ffffffff;
//assign vrb = 128'h222222221234567801010101ffffffff;
assign vra0 = vra[31:0];
assign vrb0 = vrb[31:0];
assign vra1 = vra[63:32];
assign vrb1 = vrb[63:32];
assign vra2 = vra[95:64];
assign vrb2 = vrb[95:64];
assign vra3 = vra[127:96];
assign vrb3 = vrb[127:96];

vsfx_vaddsws add_test0(
    .vrt(add_vrt0),
    .vra(vra0),
    .vrb(vrb0),
    .sat(sat0)
);
vsfx_vaddsws add_test1(
    .vrt(add_vrt1),
    .vra(vra1),
    .vrb(vrb1),
    .sat(sat1)
);
vsfx_vaddsws add_test2(
    .vrt(add_vrt2),
    .vra(vra2),
    .vrb(vrb2),
    .sat(sat2)
);
vsfx_vaddsws add_test3(
    .vrt(add_vrt3),
    .vra(vra3),
    .vrb(vrb3),
    .sat(sat3)
);
assign add_vrt = {add_vrt3, add_vrt2, add_vrt1, add_vrt0};

vsfx_vsububm sub_test0(
    .vrt(sub_vrt0),
    .vra(vra0),
    .vrb(vrb0)
);
vsfx_vsububm sub_test1(
    .vrt(sub_vrt1),
    .vra(vra1),
    .vrb(vrb1)
);
vsfx_vsububm sub_test2(
    .vrt(sub_vrt2),
    .vra(vra2),
    .vrb(vrb2)
);
vsfx_vsububm sub_test3(
    .vrt(sub_vrt3),
    .vra(vra3),
    .vrb(vrb3)
);
assign sub_vrt = {sub_vrt3, sub_vrt2, sub_vrt1, sub_vrt0};

vsfx_vcmpequh cmp_test0(
    .vrt(cmp_vrt0),
    .vra(vra0),
    .vrb(vrb0)
);
vsfx_vcmpequh cmp_test1(
    .vrt(cmp_vrt1),
    .vra(vra1),
    .vrb(vrb1)
);
vsfx_vcmpequh cmp_test2(
    .vrt(cmp_vrt2),
    .vra(vra2),
    .vrb(vrb2)
);
vsfx_vcmpequh cmp_test3(
    .vrt(cmp_vrt3),
    .vra(vra3),
    .vrb(vrb3)
);
assign cmp_vrt = {cmp_vrt3, cmp_vrt2, cmp_vrt1, cmp_vrt0};

vsfx_vavgsh avg_test0(
    .vrt(avg_vrt0),
    .vra(vra0),
    .vrb(vrb0)
);
vsfx_vavgsh avg_test1(
    .vrt(avg_vrt1),
    .vra(vra1),
    .vrb(vrb1)
);
vsfx_vavgsh avg_test2(
    .vrt(avg_vrt2),
    .vra(vra2),
    .vrb(vrb2)
);
vsfx_vavgsh avg_test3(
    .vrt(avg_vrt3),
    .vra(vra3),
    .vrb(vrb3)
);
assign avg_vrt = {avg_vrt3, avg_vrt2, avg_vrt1, avg_vrt0};

vsfx_vslb shi_test0(
    .vrt(shi_vrt0),
    .vra(vra0),
    .vrb(vrb0)
);
vsfx_vslb shi_test1(
    .vrt(shi_vrt1),
    .vra(vra1),
    .vrb(vrb1)
);
vsfx_vslb shi_test2(
    .vrt(shi_vrt2),
    .vra(vra2),
    .vrb(vrb2)
);
vsfx_vslb shi_test3(
    .vrt(shi_vrt3),
    .vra(vra3),
    .vrb(vrb3)
);
assign shi_vrt = {shi_vrt3, shi_vrt2, shi_vrt1, shi_vrt0};

always @ ( posedge clk )
begin
    if(ins == 8'b01110000)
    begin
        vrt <= add_vrt;
        sat <= sat0 | sat1 | sat2 | sat3;
    end
    else if(ins == 8'b10000000)
    begin
        vrt <= sub_vrt;
    end
    else if(ins == 8'b10001011 || ins == 8'b00001011)
    begin
        vrt <= cmp_vrt;
        if(ins[7] == 1'b1)
        begin
            t   <= (vrt == 32'hffffffff);
            f   <= (vrt == 32'b0);
            cr6 <= {1'b0, t, 1'b0, f};
        end
    end
    else if(ins == 8'b10101001)
    begin
        vrt <= avg_vrt;
    end
    else if(ins == 8'b00100010)
    begin
        vrt <= shi_vrt;
    end
    vrt_en <= en;
end


endmodule
