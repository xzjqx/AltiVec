module vsfx_vslb(
    vrt,
    vra,
    vrb
);

output  [31 : 0]    vrt;
input   [31 : 0]    vra;
input   [31 : 0]    vrb;

wire    [31 : 0]    vrt;
wire    [3 : 0]     sh0;
wire	 [3 : 0]     sh1;
wire	 [3 : 0]     sh2;
wire	 [3 : 0]     sh3;

assign {sh0, sh1, sh2, sh3} =  {1'b0, vrb[2:0], 1'b0, vrb[10:8], 1'b0, vrb[18:16], 1'b0, vrb[26:24]};

assign vrt[31:0] = {(vra[31:24]<<sh3)&8'hff,(vra[23:16]<<sh2)&8'hff,(vra[15:8]<<sh1)&8'hff,(vra[7:0]<<sh0)&8'hff};

endmodule
