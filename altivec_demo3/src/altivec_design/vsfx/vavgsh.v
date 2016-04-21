module vsfx_vavgsh(
    vrt,
    vra,
    vrb
);

output  [31 : 0]    vrt;
input   [31 : 0]    vra;
input   [31 : 0]    vrb;

wire    [16 : 0]    aop0;
wire    [16 : 0]    bop0;
wire    [16 : 0]    aop1;
wire    [16 : 0]    bop1;
wire    [16 : 0]    sum0;
wire    [16 : 0]    sum1;
wire    [31 : 0]    vrt;

assign aop1                = {1'b0,vra[31:16]};
assign bop1                = {1'b0,vrb[31:16]};
assign aop0                = {1'b0,vra[15:0]};
assign bop0                = {1'b0,vrb[15:0]};

/*if(aop1[15] == bop1[15])
begin
	assign sum1                = (aop1 + bop1 + 17'h00001) >> 1;
end
else
begin
	assign sum1                = (aop1 + bop1 + 17'h00001) >> 1;
	assign sum1[15]            = ~sum1[15];
end

if(aop0[15] == bop0[15])
begin
	assign sum0                = (aop0 + bop0 + 17'h00001) >> 1;
end
else
begin
	assign sum0                = (aop0 + bop0 + 17'h00001) >> 1;
	assign sum0[15]            = ~sum0[15];
end*/

assign sum1                = (aop1[15] == bop1[15]) ? ((aop1 + bop1 + 17'h00001) >> 1) : ((aop1 + bop1 + 17'h00001) >> 1)^16'h8000;
assign sum0                = (aop0[15] == bop0[15]) ? ((aop0 + bop0 + 17'h00001) >> 1) : ((aop0 + bop0 + 17'h00001) >> 1)^16'h8000;

//assign sum1[15]            = (aop1[15] == bop1[15]) ? sum1[15] : ~sum1[15];

/*assign sum0                = (aop0 + bop0 + 17'h00001) >> 1;
assign x                   = sum0[15] ^ 1;
assign sum0[15]            = x;
*/

assign vrt                = {sum1[15:0], sum0[15:0]};

endmodule
