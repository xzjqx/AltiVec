module vsfx_vsububm(
    vrt,
    vra,
    vrb
);

output  [31 : 0]    vrt;
input   [31 : 0]    vra;
input   [31 : 0]    vrb;

wire    [35 : 0]    aop;
wire    [35 : 0]    bop;
wire    [35 : 0]    sub;
wire    [31 : 0]    vrt;

assign aop                = {1'b1, vra[31:24], 1'b1, vra[23:16], 1'b1, vra[15:8], 1'b1, vra[7:0]};
assign bop                = {1'b0, vrb[31:24], 1'b0, vrb[23:16], 1'b0, vrb[15:8], 1'b0, vrb[7:0]};
assign sub                = aop - bop;
assign vrt                = {sub[34:27], sub[25:18], sub[16:9], sub[7:0]};

endmodule
