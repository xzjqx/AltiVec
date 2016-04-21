//===============================================================================
//  File Name            : vector_dram_shell.v
//  File Revision        : 2.0			
//  Author               : liguanghe
//  Email                : 1379099640@qq.com
//	History				 : Rev1.0	2014/03/20 	cuiluping
//						 : Rev2.0   2014/09/29  liguanghe
//Rev 1.0			: simple modeling
//  ----------------------------------------------------------------------------
//  Description      :  shell of vector data ram for AltiVec co-processor				     
//  Function         :   
//  ----------------------------------------------------------------------------
// Copyright (c) 2013,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================
module	vector_dram_shell	(
							clk,
							rst_b,
							cs,
							rw,
							addr,
							data_in,
							data_out,
							write_en
					);
//---------------------------------------------
//I/O declaration
//----------------------------------------------
input				clk;
input				rst_b;
input				cs;
input				rw;
input	[0:31]		addr;
input	[0:127]		data_in;
input   [0: 15]		write_en;
output	[0:127]		data_out;

reg		[0:127]		data_out;

reg	[0:127]		data_out_tmp;

//memory declaration
reg     [0:127]      mem [0:4096];
//write
always @ ( posedge clk )
begin
    if( cs && ( !rw ) )
    begin
        //mem[{addr[0:27],2'b00}]   <= data_in[0:31];
        //mem[{addr[0:27],2'b01}]   <= data_in[32:63];
        //mem[{addr[0:27],2'b10}]   <= data_in[64:95];
        //mem[{addr[0:27],2'b11}]   <= data_in[96:127];
		if (write_en[0])
			mem[addr[0:27]][  0:  7] <= data_in[  0:  7];
		if (write_en[1])
			mem[addr[0:27]][  8: 15] <= data_in[  8: 15];
		if (write_en[2])
			mem[addr[0:27]][ 16: 23] <= data_in[ 16: 23];
		if (write_en[3])
			mem[addr[0:27]][ 24: 31] <= data_in[ 24: 31];
		if (write_en[4])
			mem[addr[0:27]][ 32: 39] <= data_in[ 32: 39];
		if (write_en[5])
			mem[addr[0:27]][ 40: 47] <= data_in[ 40: 47];
		if (write_en[6])
			mem[addr[0:27]][ 48: 55] <= data_in[ 48: 55];
		if (write_en[7])
			mem[addr[0:27]][ 56: 63] <= data_in[ 56: 63];
		if (write_en[8])
			mem[addr[0:27]][ 64: 71] <= data_in[ 64: 71];
		if (write_en[9])
			mem[addr[0:27]][ 72: 79] <= data_in[ 72: 79];
		if (write_en[10])
			mem[addr[0:27]][ 80: 87] <= data_in[ 80: 87];
		if (write_en[11])
			mem[addr[0:27]][ 88: 95] <= data_in[ 88: 95];
		if (write_en[12])
			mem[addr[0:27]][ 96:103] <= data_in[ 96:103];
		if (write_en[13])
			mem[addr[0:27]][104:111] <= data_in[104:111];
		if (write_en[14])
			mem[addr[0:27]][112:119] <= data_in[112:119];
		if (write_en[15])
			mem[addr[0:27]][120:127] <= data_in[120:127];
	end
end
//read mem
always @ ( * )
begin
    if( cs && rw )
    begin
        data_out_tmp    =  mem[addr[0:27]];
    end
    else
    begin
        data_out_tmp    =  128'h0;
    end
end
        
always @ ( posedge clk or negedge rst_b )
begin
		if ( !rst_b )
		begin
				data_out	<= 128'h0;
		end
		else
		begin
				data_out	<= data_out_tmp;
		end
end
endmodule
				
