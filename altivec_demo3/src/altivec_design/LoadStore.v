//===============================================================================
//  File Name       : LoadStore.v
//  File Revision   : 3.0
//  Date            : 2014/6/9
//  Author          : cuiluping
//  Email           : clp510@tju.edu.cn
//  History         : 1.0 2013/10/27 cuiluping
//                    2.0 2014/03/19 cuiluping
//                    3.0 2014/06/09 wangjie
//                    Rev2.0 : modify the LoadStore unit according the defination of <<PowerISA>>
//  ----------------------------------------------------------------------------
//  Description     : load data from mem or store data to mem 2 pipeline latency
//                    1st pipe : add (RA)|0 + (RB ) to get the memory address
//                    2nd pipe : access the mem
//  ----------------------------------------------------------------------------
// Copyright (c) 2014,Tianjin University.
//               No.92 Weijin Road , Nankai District, Tianjin, 300072, China
// Tianjin University Confidential Proprietary
//===============================================================================
module    LoadStore    (
                    clk,
                    rst_n,
                    //data from GPR of c405
                    Dcd_RaEn,
                    C405_LSRaData,
                    C405_LSRbData,
                    //Interface with decoder
                    Dcd_LS_cs,
                    Dcd_LSType,
                    Dcd_LSOperand,
                    Dcd_LSTargetRegister,
                    //Interface with mem
                    LS_Mem_cs,
                    LS_MemAddr,
                    LS_MemData,
                    LS_Mem_RW,
					          LS_Mem_WriteEn, //memory write enable signal per 8 bits
                    Mem_LSData,
                    //Interface with register files
                    LS_RFTargetRegEn, //RFTargetReg enable signal per 8 bits
                    LS_RFTargetRegister,
                    LS_RFResult
                    );
//-----------------------------------------------------------------
// I/O declaration
//----------------------------------------------------------------
input            clk;
input            rst_n;
input  [ 31:0]   C405_LSRaData;
input  [ 31:0]   C405_LSRbData;
input            Dcd_RaEn;
input            Dcd_LS_cs;
input  [  4:0]   Dcd_LSType;//bit22,bit23,bit24,bit25,bit30
input  [127:0]   Dcd_LSOperand;//
input  [  4:0]   Dcd_LSTargetRegister;//32 register
input  [127:0]   Mem_LSData;

output           LS_Mem_cs;
output [ 31:0]   LS_MemAddr;
output [127:0]   LS_MemData;
output           LS_Mem_RW;   //1'b1 -- read,1'b0--write
output [ 15:0]	 LS_Mem_WriteEn;
output [ 15:0]   LS_RFTargetRegEn;
output [  4:0]   LS_RFTargetRegister;
output [127:0]   LS_RFResult;

//"register" declaration
reg	   [ 31:0]   C405_LSRaData_r;
reg    [ 31:0]   C405_LSRbData_r;
reg              LS_Mem_cs;
reg    [ 31:0]   LS_MemAddr;
reg    [127:0]   LS_MemData;
reg              LS_Mem_RW;   //1'b1 -- read,1'b0--write
reg    [ 15:0]	 LS_Mem_WriteEn;
reg    [ 15:0]   LS_RFTargetRegEn;
reg    [  4:0]   LS_RFTargetRegister;
reg    [127:0]   LS_RFResult;
//Internal signals declarations
reg              co;
reg    [ 31:0]   ExeMemAddr_r;//3rd pipeline in AltiVec
reg              Dcd_LS_cs_r;
reg      		 Dcd_LS_cs_r_2nd;
reg    [  4:0]   Dcd_LSType_r;
reg    [  4:0]	 Dcd_LSType_r_2nd;
reg    [127:0]   Dcd_LSOperand_r;
reg    [  4:0]   Dcd_LSTargetRegister_r;
reg    [ 31:0]   EA;

wire   [  3:0]   eb;


assign eb = EA[3:0];
//assign LS_RFResult = Mem_LSData;

always @(posedge clk)
begin
	C405_LSRaData_r <= C405_LSRaData;
	C405_LSRbData_r <= C405_LSRbData;
end

//-------------------------------------------------------
//1st pipeline logic
// generate the address of Memory
//--------------------------------------------------------
always @ ( posedge clk or negedge rst_n )
begin
  if ( !rst_n )
  begin
    {co,ExeMemAddr_r} <= 33'h0;
  end
  else if ( Dcd_LS_cs )
  begin
    if ( Dcd_RaEn )
    begin
	  if (Dcd_LSType[3])
		{co,ExeMemAddr_r} <= C405_LSRaData_r + C405_LSRbData_r;
	  else
		{co,ExeMemAddr_r} <= C405_LSRaData + C405_LSRbData;
    end
    else
    begin
	  if (Dcd_LSType[3])
		{co,ExeMemAddr_r} <= { 1'b0, C405_LSRbData_r };
	  else
		{co,ExeMemAddr_r} <= { 1'b0, C405_LSRbData };
    end
  end
  else
  begin
    {co,ExeMemAddr_r } <= 33'hxx;
  end
end

//register Decoder control signals
always @ ( posedge clk or negedge rst_n )
begin
  if ( !rst_n )
  begin
    Dcd_LS_cs_r            <= 1'b0;
    Dcd_LSType_r           <= 5'b0;
    Dcd_LSOperand_r        <= 128'b0;
    Dcd_LSTargetRegister_r <= 5'b0;
	Dcd_LS_cs_r_2nd        <= 1'b0;
	Dcd_LSType_r_2nd       <= 5'b0;
  end                      
  else                     
  begin                    
    Dcd_LS_cs_r            <= Dcd_LS_cs;
    Dcd_LSType_r           <= Dcd_LSType;
    Dcd_LSOperand_r        <= Dcd_LSOperand;
    Dcd_LSTargetRegister_r <= Dcd_LSTargetRegister;
	Dcd_LS_cs_r_2nd        <= Dcd_LS_cs_r;
	Dcd_LSType_r_2nd       <= Dcd_LSType_r;
  end
end

//----------------------------------------------------------------------
// 2nd pipeline
// Access the mem
//------------------------------------------------------------------------
always @ ( * )
begin
  if(Dcd_LS_cs_r)
  begin
    case ( Dcd_LSType_r)
	  5'b00001: begin //lvebx instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
				EA = ExeMemAddr_r;
				LS_MemAddr = EA;
				LS_MemData = 128'b0;
				LS_Mem_WriteEn = 16'b0;
				end
	  5'b00011: begin //lvehx instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
				EA = ( ExeMemAddr_r & 32'hffff_fffe );
				LS_MemAddr = EA;
				LS_MemData = 128'b0;
				LS_Mem_WriteEn = 16'b0;
				end
	  5'b00101: begin  //lvewx instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
				EA = ( ExeMemAddr_r & 32'hffff_fffc );
				LS_MemAddr = EA;
				LS_MemData = 128'b0;
				LS_Mem_WriteEn = 16'b0; 
				end
	  5'b00111: begin  //lvx instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
                EA = ( ExeMemAddr_r & 32'hffff_fff0 );
				LS_MemAddr = EA;
                LS_MemData = 128'h0;
				LS_Mem_WriteEn = 16'b0;
                end
	  5'b10111: begin  //lvxl instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
                EA = ( ExeMemAddr_r & 32'hffff_fff0 );
				LS_MemAddr = EA;
                LS_MemData = 128'h0;
				LS_Mem_WriteEn = 16'b0;
				end
	  5'b01001: begin  //stvebx 
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b0;//for write
                EA = ExeMemAddr_r;
				LS_MemAddr = EA;
                LS_MemData = Dcd_LSOperand_r;
				case (eb)
					4'd0: begin
							LS_Mem_WriteEn[15] = 1'b1;
							LS_Mem_WriteEn[14:0] = 15'b0;
						  end
				    4'd1: begin
							LS_Mem_WriteEn[15] = 1'b0;
							LS_Mem_WriteEn[14] = 1'b1;
							LS_Mem_WriteEn[13:0] = 14'b0;
						  end
					4'd2: begin
							LS_Mem_WriteEn[15:14] = 2'b0;
							LS_Mem_WriteEn[13] = 1'b1;
							LS_Mem_WriteEn[12:0] = 13'b0;
						  end
					4'd3: begin
							LS_Mem_WriteEn[15:13] = 3'b0;
							LS_Mem_WriteEn[12] = 1'b1;
							LS_Mem_WriteEn[11:0] = 12'b0;
						  end
					4'd4: begin
							LS_Mem_WriteEn[15:12] = 4'b0;
							LS_Mem_WriteEn[11] = 1'b1;
							LS_Mem_WriteEn[10:0] = 11'b0;
						  end
				    4'd5: begin
							LS_Mem_WriteEn[15:11] = 5'b0;
							LS_Mem_WriteEn[10] = 1'b1;
							LS_Mem_WriteEn[9:0] = 10'b0;
						  end
					4'd6: begin
							LS_Mem_WriteEn[15:10] = 6'b0;
							LS_Mem_WriteEn[9] = 1'b1;
							LS_Mem_WriteEn[8:0] = 9'b0;
						  end
				    4'd7: begin
							LS_Mem_WriteEn[15:9] = 7'b0;
							LS_Mem_WriteEn[8] = 1'b1;
							LS_Mem_WriteEn[7:0] = 8'b0;
						  end
					4'd8: begin
							LS_Mem_WriteEn[15:8] = 8'b0;
							LS_Mem_WriteEn[7] = 1'b1;
							LS_Mem_WriteEn[6:0] = 7'b0;
						  end
					4'd9: begin
							LS_Mem_WriteEn[15:7] = 9'b0;
							LS_Mem_WriteEn[6] = 1'b1;
							LS_Mem_WriteEn[5:0] = 6'b0;
						  end
					4'd10:begin
							LS_Mem_WriteEn[15:6] = 10'b0;
							LS_Mem_WriteEn[5] = 1'b1;
							LS_Mem_WriteEn[4:0] = 5'b0;
						  end
					4'd11:begin
							LS_Mem_WriteEn[15:5] = 11'b0;
							LS_Mem_WriteEn[4] = 1'b1;
							LS_Mem_WriteEn[3:0] = 4'b0;
						  end
					4'd12:begin
							LS_Mem_WriteEn[15:4] = 12'b0;
							LS_Mem_WriteEn[3] = 1'b1;
							LS_Mem_WriteEn[2:0] = 3'b0;
						  end
					4'd13:begin
							LS_Mem_WriteEn[15:3] = 13'b0;
							LS_Mem_WriteEn[2] = 1'b1;
							LS_Mem_WriteEn[1:0] = 2'b0;
						  end
					4'd14:begin
							LS_Mem_WriteEn[15:2] = 14'b0;
							LS_Mem_WriteEn[1] = 1'b1;
							LS_Mem_WriteEn[0] = 1'b0;
						  end
					4'd15:begin
							LS_Mem_WriteEn[15:1] = 15'b0;
							LS_Mem_WriteEn[0] = 1'b1;
						  end
					default:begin
							LS_Mem_WriteEn = 16'b0;
						    end
				endcase
	  			end
	  5'b01011: begin  //stvehx 
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b0;//for write
                EA = ( ExeMemAddr_r & 32'hffff_fffe );
				LS_MemAddr = EA;
                LS_MemData = Dcd_LSOperand_r;
				case (eb)
					4'd0: begin
							LS_Mem_WriteEn[15:14] = 2'b11;
							LS_Mem_WriteEn[13: 0] = 14'b0;
						  end
				    4'd2: begin
							LS_Mem_WriteEn[15:14] = 2'b0;
							LS_Mem_WriteEn[13:12] = 2'b11;
							LS_Mem_WriteEn[11: 0] = 12'b0;
						  end
					4'd4: begin
							LS_Mem_WriteEn[15:12] = 4'b0;
							LS_Mem_WriteEn[11:10] = 2'b11;
							LS_Mem_WriteEn[ 9: 0] = 10'b0;
						  end
					4'd6: begin
							LS_Mem_WriteEn[15:10] = 6'b0;
							LS_Mem_WriteEn[ 9: 8] = 2'b11;
							LS_Mem_WriteEn[ 7: 0] = 8'b0;
						  end
					4'd8: begin
							LS_Mem_WriteEn[15: 8] = 8'b0;
							LS_Mem_WriteEn[ 7: 6] = 2'b11;
							LS_Mem_WriteEn[ 5: 0] = 6'b0;
						  end
				    4'd10:begin
							LS_Mem_WriteEn[15: 6] = 10'b0;
							LS_Mem_WriteEn[ 5: 4] = 2'b11;
							LS_Mem_WriteEn[ 3: 0] = 4'b0;
						  end
					4'd12:begin
							LS_Mem_WriteEn[15: 4] = 12'b0;
							LS_Mem_WriteEn[ 3: 2] = 2'b11;
							LS_Mem_WriteEn[ 1: 0] = 2'b0;
						  end
				    4'd14:begin
							LS_Mem_WriteEn[15: 2] = 14'b0;
							LS_Mem_WriteEn[ 1: 0] = 2'b11;
						  end
				    default:begin
							LS_Mem_WriteEn = 16'b0;
						  end
				endcase
	  			end
	  5'b01101: begin  //stvewx 
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b0;//for write
                EA = ( ExeMemAddr_r & 32'hffff_fffc );
				LS_MemAddr = EA;
                LS_MemData = Dcd_LSOperand_r;
				case (eb)
					4'd0: begin
							LS_Mem_WriteEn[15:12] = 4'b1111;
							LS_Mem_WriteEn[11: 0] = 12'b0;
						  end
					4'd4: begin
							LS_Mem_WriteEn[15:12] = 4'b0;
							LS_Mem_WriteEn[11: 8] = 4'b1111;
							LS_Mem_WriteEn[ 7: 0] = 8'b0;
						  end
					4'd8: begin
							LS_Mem_WriteEn[15: 8] = 8'b0;
							LS_Mem_WriteEn[ 7: 4] = 4'b1111;
							LS_Mem_WriteEn[ 3: 0] = 4'b0;
						  end
					4'd12:begin
							LS_Mem_WriteEn[15: 4] = 12'b0;
							LS_Mem_WriteEn[ 3: 0] = 4'b1111;
						  end
				    default:begin
							LS_Mem_WriteEn = 16'b0;
						  end
				endcase
	  			end
	  5'b01111: begin  //stvx 
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b0;//for write
                EA = ( ExeMemAddr_r & 32'hffff_fff0 );
				LS_MemAddr = EA;
                LS_MemData = Dcd_LSOperand_r;
				LS_Mem_WriteEn = 16'b1111111111111111;
	  			end
	  5'b11111: begin  //stvxl  
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b0;//for write
                EA = ( ExeMemAddr_r & 32'hffff_fff0 );
				LS_MemAddr = EA;
                LS_MemData = Dcd_LSOperand_r;
				LS_Mem_WriteEn = 16'b1111111111111111;
	  			end
	  5'b00000: begin  //lvsl instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
                EA = ExeMemAddr_r;
				LS_MemAddr = EA;
                LS_MemData = 128'h0;
				LS_Mem_WriteEn = 16'b0;
	  			end
	  5'b00010: begin  //lvsr instruction
                LS_Mem_cs  = 1'b1;
                LS_Mem_RW  = 1'b1;//for read
                EA = ExeMemAddr_r;
				LS_MemAddr = EA;
                LS_MemData = 128'h0;
				LS_Mem_WriteEn = 16'b0;
			   end
      default: begin       
                LS_Mem_cs  = 1'b0;
                LS_Mem_RW  = 1'b1;
                LS_MemAddr = 32'h0;
                LS_MemData = 128'h0;
				LS_Mem_WriteEn = 16'b0;
               end
    endcase
  end
  else
  begin
    LS_Mem_cs  = 1'b0;
    LS_Mem_RW  = 1'b1;
    LS_MemAddr = 32'h0;
    LS_MemData = 128'h0;
	LS_Mem_WriteEn = 16'b0;
  end
end
//---------------------------------------------------------------
//Load LS_RFResult
//---------------------------------------------------------------
always @ ( * )
begin
  if(Dcd_LS_cs_r_2nd)
  begin
    case ( Dcd_LSType_r_2nd)
	  5'b00001: begin //lvebx instruction
				case (eb)
					4'd0: begin
							LS_RFTargetRegEn[15] = 1'b1;
							LS_RFTargetRegEn[14:0] = 15'b0;
						  end
				    4'd1: begin
							LS_RFTargetRegEn[15] = 1'b0;
							LS_RFTargetRegEn[14] = 1'b1;
							LS_RFTargetRegEn[13:0] = 14'b0;
						  end
					4'd2: begin
							LS_RFTargetRegEn[15:14] = 2'b0;
							LS_RFTargetRegEn[13] = 1'b1;
							LS_RFTargetRegEn[12:0] = 13'b0;
						  end
					4'd3: begin
							LS_RFTargetRegEn[15:13] = 3'b0;
							LS_RFTargetRegEn[12] = 1'b1;
							LS_RFTargetRegEn[11:0] = 12'b0;
						  end
					4'd4: begin
							LS_RFTargetRegEn[15:12] = 4'b0;
							LS_RFTargetRegEn[11] = 1'b1;
							LS_RFTargetRegEn[10:0] = 11'b0;
						  end
				    4'd5: begin
							LS_RFTargetRegEn[15:11] = 5'b0;
							LS_RFTargetRegEn[10] = 1'b1;
							LS_RFTargetRegEn[9:0] = 10'b0;
						  end
					4'd6: begin
							LS_RFTargetRegEn[15:10] = 6'b0;
							LS_RFTargetRegEn[9] = 1'b1;
							LS_RFTargetRegEn[8:0] = 9'b0;
						  end
				    4'd7: begin
							LS_RFTargetRegEn[15:9] = 7'b0;
							LS_RFTargetRegEn[8] = 1'b1;
							LS_RFTargetRegEn[7:0] = 8'b0;
						  end
					4'd8: begin
							LS_RFTargetRegEn[15:8] = 8'b0;
							LS_RFTargetRegEn[7] = 1'b1;
							LS_RFTargetRegEn[6:0] = 7'b0;
						  end
					4'd9: begin
							LS_RFTargetRegEn[15:7] = 9'b0;
							LS_RFTargetRegEn[6] = 1'b1;
							LS_RFTargetRegEn[5:0] = 6'b0;
						  end
					4'd10:begin
							LS_RFTargetRegEn[15:6] = 10'b0;
							LS_RFTargetRegEn[5] = 1'b1;
							LS_RFTargetRegEn[4:0] = 5'b0;
						  end
					4'd11:begin
							LS_RFTargetRegEn[15:5] = 11'b0;
							LS_RFTargetRegEn[4] = 1'b1;
							LS_RFTargetRegEn[3:0] = 4'b0;
						  end
					4'd12:begin
							LS_RFTargetRegEn[15:4] = 12'b0;
							LS_RFTargetRegEn[3] = 1'b1;
							LS_RFTargetRegEn[2:0] = 3'b0;
						  end
					4'd13:begin
							LS_RFTargetRegEn[15:3] = 13'b0;
							LS_RFTargetRegEn[2] = 1'b1;
							LS_RFTargetRegEn[1:0] = 2'b0;
						  end
					4'd14:begin
							LS_RFTargetRegEn[15:2] = 14'b0;
							LS_RFTargetRegEn[1] = 1'b1;
							LS_RFTargetRegEn[0] = 1'b0;
						  end
					4'd15:begin
							LS_RFTargetRegEn[15:1] = 15'b0;
							LS_RFTargetRegEn[0] = 1'b1;
						  end
					default:begin
							LS_RFTargetRegEn = 16'b0;
						    end
				endcase
				LS_RFResult = Mem_LSData;
				end
	  5'b00011: begin //lvehx instruction
				case (eb)
					4'd0: begin
							LS_RFTargetRegEn[15:14] = 2'b11;
							LS_RFTargetRegEn[13: 0] = 14'b0;
						  end
				    4'd2: begin
							LS_RFTargetRegEn[15:14] = 2'b0;
							LS_RFTargetRegEn[13:12] = 2'b11;
							LS_RFTargetRegEn[11: 0] = 12'b0;
						  end
					4'd4: begin
							LS_RFTargetRegEn[15:12] = 4'b0;
							LS_RFTargetRegEn[11:10] = 2'b11;
							LS_RFTargetRegEn[ 9: 0] = 10'b0;
						  end
					4'd6: begin
							LS_RFTargetRegEn[15:10] = 6'b0;
							LS_RFTargetRegEn[ 9: 8] = 2'b11;
							LS_RFTargetRegEn[ 7: 0] = 8'b0;
						  end
					4'd8: begin
							LS_RFTargetRegEn[15: 8] = 8'b0;
							LS_RFTargetRegEn[ 7: 6] = 2'b11;
							LS_RFTargetRegEn[ 5: 0] = 6'b0;
						  end
				    4'd10:begin
							LS_RFTargetRegEn[15: 6] = 10'b0;
							LS_RFTargetRegEn[ 5: 4] = 2'b11;
							LS_RFTargetRegEn[ 3: 0] = 4'b0;
						  end
					4'd12:begin
							LS_RFTargetRegEn[15: 4] = 12'b0;
							LS_RFTargetRegEn[ 3: 2] = 2'b11;
							LS_RFTargetRegEn[ 1: 0] = 2'b0;
						  end
				    4'd14:begin
							LS_RFTargetRegEn[15: 2] = 14'b0;
							LS_RFTargetRegEn[ 1: 0] = 2'b11;
						  end
				    default:begin
							LS_RFTargetRegEn = 16'b0;
						  end
				endcase
				LS_RFResult = Mem_LSData;
				end
	  5'b00101: begin  //lvewx instruction
				case (eb)
					4'd0: begin
							LS_RFTargetRegEn[15:12] = 4'b1111;
							LS_RFTargetRegEn[11: 0] = 12'b0;
						  end
					4'd4: begin
							LS_RFTargetRegEn[15:12] = 4'b0;
							LS_RFTargetRegEn[11: 8] = 4'b1111;
							LS_RFTargetRegEn[ 7: 0] = 8'b0;
						  end
					4'd8: begin
							LS_RFTargetRegEn[15: 8] = 8'b0;
							LS_RFTargetRegEn[ 7: 4] = 4'b1111;
							LS_RFTargetRegEn[ 3: 0] = 4'b0;
						  end
					4'd12:begin
							LS_RFTargetRegEn[15: 4] = 12'b0;
							LS_RFTargetRegEn[ 3: 0] = 4'b1111;
						  end
				    default:begin
							LS_RFTargetRegEn = 16'b0;
						  end
				endcase
				LS_RFResult = Mem_LSData;	  
				end
	  5'b00111: begin  //lvx instruction
				LS_RFTargetRegEn = 16'b1111111111111111;
				LS_RFResult = Mem_LSData;
                end
	  5'b10111: begin  //lvxl instruction
				LS_RFTargetRegEn = 16'b1111111111111111;
				LS_RFResult = Mem_LSData;
				end
	  5'b01001: begin  //stvebx 
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
	  			end
	  5'b01011: begin  //stvehx 
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
	  			end
	  5'b01101: begin  //stvewx 
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
	  			end
	  5'b01111: begin  //stvx 
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
	  			end
	  5'b11111: begin  //stvxl  don't finish
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
	  			end
	  5'b00000: begin  //lvsl instruction
				LS_RFTargetRegEn = 16'b1111111111111111;
				case (eb)
					4'd0 : begin
							LS_RFResult = 128'h000102030405060708090A0B0C0D0E0F;
						   end
					4'd1 : begin
							LS_RFResult = 128'h0102030405060708090A0B0C0D0E0F10;
						   end
					4'd2 : begin
							LS_RFResult = 128'h02030405060708090A0B0C0D0E0F1011;
						   end
					4'd3 : begin
							LS_RFResult = 128'h030405060708090A0B0C0D0E0F101112;
						   end
					4'd4 : begin
							LS_RFResult = 128'h0405060708090A0B0C0D0E0F10111213;
						   end
					4'd5 : begin
							LS_RFResult = 128'h05060708090A0B0C0D0E0F1011121314;
						   end
					4'd6 : begin
							LS_RFResult = 128'h060708090A0B0C0D0E0F101112131415;
						   end
					4'd7 : begin
							LS_RFResult = 128'h0708090A0B0C0D0E0F10111213141516;
						   end
					4'd8 : begin
							LS_RFResult = 128'h08090A0B0C0D0E0F1011121314151617;
						   end
					4'd9 : begin
							LS_RFResult = 128'h090A0B0C0D0E0F101112131415161718;
						   end
					4'd10: begin
							LS_RFResult = 128'h0A0B0C0D0E0F10111213141516171819;
						   end
					4'd11: begin
							LS_RFResult = 128'h0B0C0D0E0F101112131415161718191A;
						   end
					4'd12: begin
							LS_RFResult = 128'h0C0D0E0F101112131415161718191A1B;
						   end
					4'd13: begin
							LS_RFResult = 128'h0D0E0F101112131415161718191A1B1C;
						   end
					4'd14: begin
							LS_RFResult = 128'h0E0F101112131415161718191A1B1C1D;
						   end
					4'd15: begin
							LS_RFResult = 128'h0F101112131415161718191A1B1C1D1E;
						   end	
				  default: begin
							LS_RFResult = 128'h00000000000000000000000000000000;
						   end
				endcase
	  			end
	  5'b00010: begin  //lvsr instruction
				LS_RFTargetRegEn = 16'b1111111111111111;
				case (eb)
					4'd0 : begin
							LS_RFResult = 128'h101112131415161718191A1B1C1D1E1F;
						   end
					4'd1 : begin
							LS_RFResult = 128'h0F101112131415161718191A1B1C1D1E;
						   end
					4'd2 : begin
							LS_RFResult = 128'h0E0F101112131415161718191A1B1C1D;
						   end
					4'd3 : begin
							LS_RFResult = 128'h0D0E0F101112131415161718191A1B1C;
						   end
					4'd4 : begin
							LS_RFResult = 128'h0C0D0E0F101112131415161718191A1B;
						   end
					4'd5 : begin
							LS_RFResult = 128'h0B0C0D0E0F101112131415161718191A;
						   end
					4'd6 : begin
							LS_RFResult = 128'h0A0B0C0D0E0F10111213141516171819;
						   end
					4'd7 : begin
							LS_RFResult = 128'h090A0B0C0D0E0F101112131415161718;
						   end
					4'd8 : begin
							LS_RFResult = 128'h08090A0B0C0D0E0F1011121314151617;
						   end
					4'd9 : begin
							LS_RFResult = 128'h0708090A0B0C0D0E0F10111213141516;
						   end
					4'd10: begin
							LS_RFResult = 128'h060708090A0B0C0D0E0F101112131415;
						   end
					4'd11: begin
							LS_RFResult = 128'h05060708090A0B0C0D0E0F1011121314;
						   end
					4'd12: begin
							LS_RFResult = 128'h0405060708090A0B0C0D0E0F10111213;
						   end
					4'd13: begin
							LS_RFResult = 128'h030405060708090A0B0C0D0E0F101112;
						   end
					4'd14: begin
							LS_RFResult = 128'h02030405060708090A0B0C0D0E0F1011;
						   end
					4'd15: begin
							LS_RFResult = 128'h0102030405060708090A0B0C0D0E0F10;
						   end	
				  default: begin
							LS_RFResult = 128'h00000000000000000000000000000000;
						   end
				endcase
			   end
      default: begin       
				LS_RFTargetRegEn = 16'b0;
				LS_RFResult = 128'b0;
               end
    endcase
  end
  else
  begin
	LS_RFTargetRegEn = 16'b0;
	LS_RFResult = 128'b0;
  end
end
//--------------------------------------------------------------
//Load instructions
//----------------------------------------------------------------
always @ ( posedge clk or negedge rst_n )
begin
  if ( !rst_n )
  begin
    LS_RFTargetRegister <= 5'h0;
  end                   
  else                  
  begin                 
    //LS_RFTargetRegEn    <= Dcd_LS_cs_r & LS_Mem_cs & LS_Mem_RW;//this is a valid Load instruction
    LS_RFTargetRegister <= Dcd_LSTargetRegister_r;
  end
end

//--------------------------------------------------------------
//Store instructions
//----------------------------------------------------------------

endmodule
