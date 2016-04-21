module vsfx_vaddsws(
    vrt,
    vra,
    vrb,
    sat
);

output  [31 : 0]    vrt;
input   [31 : 0]    vra;
input   [31 : 0]    vrb;
output              sat;

wire    [31 : 0]    aop;
wire    [31 : 0]    bop;
wire    [31 : 0]    sum;
wire    [31 : 0]    vrt;
wire                sat;

assign aop                = vra[31 : 0];
assign bop                = vrb[31 : 0];
assign sum                = aop + bop;
assign {sat, vrt[31 : 0]} = ({sum[31],vra[31],vrb[31]} == 3'b100 ) ?  33'h17fffffff : 
				({sum[31],vra[31],vrb[31]} == 3'b011) ? 33'h180000000 : {1'b0, sum[31 : 0]};

endmodule
