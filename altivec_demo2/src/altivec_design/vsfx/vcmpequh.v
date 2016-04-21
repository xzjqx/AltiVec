module vsfx_vcmpequh(
    vrt,
    vra,
    vrb
);

output  [31 : 0]    vrt;
input   [31 : 0]    vra;
input   [31 : 0]    vrb;

wire    [31 : 0]    vrt;

assign vrt[15:0]  = (vra[15:0] == vrb[15:0]) ? 16'hffff : 16'b0;
assign vrt[31:16] = (vra[31:16] == vrb[31:16]) ? 16'hffff : 16'b0;


endmodule
