// 
// ************************************************************************** 
// 
//  Copyright (c) International Business Machines Corporation, 2005. 
// 
//  This file contains trade secrets and other proprietary and confidential 
//  information of International Business Machines Corporation which are 
//  protected by copyright and other intellectual property rights and shall 
//  not be reproduced, transferred to other documents, disclosed to others, 
//  or used for any purpose except as specifically authorized in writing by 
//  International Business Machines Corporation. This notice must be 
//  contained as part of this text at all times. 
// 
// ************************************************************************** 
//

module p405s_trcFIFO( trcFifoDataOut, CB, fifoRdAddrL2, 
     trcFifoDataIn, trcFifoE1 );

output [0:31]  trcFifoDataOut;


input [0:31]  trcFifoDataIn;
input [0:3]   fifoRdAddrL2;
input [0:15]  trcFifoE1;
input         CB;

// Buses in the design

reg  [0:31]  trcFifoDataOut_i;

reg  [0:31]  fifoMux4;

reg  [0:31]  fifoMux3;

reg  [0:31]  fifoMux2;

reg  [0:31]  fifoMux1;

reg   [0:31]  fifoLine15Out;

reg   [0:31]  fifoLine14Out;

reg   [0:31]  fifoLine13Out;

reg   [0:31]  fifoLine12Out;

reg   [0:31]  fifoLine0Out;

reg   [0:31]  fifoLine10Out;

reg   [0:31]  fifoLine9Out;

reg   [0:31]  fifoLine4Out;

reg   [0:31]  fifoLine8Out;

reg   [0:31]  fifoLine6Out;

reg   [0:31]  fifoLine5Out;

reg   [0:31]  fifoLine3Out;

reg   [0:31]  fifoLine2Out;

reg   [0:31]  fifoLine1Out;

reg   [0:31]  fifoLine11Out;

reg   [0:31]  fifoLine7Out;

wire   [0:31]  fifoDataInBuf;

assign trcFifoDataOut = trcFifoDataOut_i;

//Removed the module dp_logTRC_fifoDataInBuf 
assign fifoDataInBuf = trcFifoDataIn;

//Removed the module dp_logTRC_fifoAclkBuf 

//Removed the module dp_muxTRC_fifo5 
always @(fifoRdAddrL2 or fifoMux1 or fifoMux2 or fifoMux3 or fifoMux4) 
  begin:  dp_muxTRC_fifo5_PROC					    
    case(fifoRdAddrL2[0:1])    		    	  
     2'b00: trcFifoDataOut_i = ~fifoMux1;   
     2'b01: trcFifoDataOut_i = ~fifoMux2;   
     2'b10: trcFifoDataOut_i = ~fifoMux3;   
     2'b11: trcFifoDataOut_i = ~fifoMux4;   
      default: trcFifoDataOut_i = 32'bx;   
    endcase // dp_muxTRC_fifo5_PROC                                 
  end                                         

//Removed the module dp_muxTRC_fifo4 
always @(fifoRdAddrL2 or fifoLine12Out or fifoLine13Out or fifoLine14Out or fifoLine15Out) 
  begin:  dp_muxTRC_fifo4_PROC					    
    case(fifoRdAddrL2[2:3])    		    	  
     2'b00:  fifoMux4 = ~fifoLine12Out;   
     2'b01:  fifoMux4 = ~fifoLine13Out;   
     2'b10:  fifoMux4 = ~fifoLine14Out;   
     2'b11:  fifoMux4 = ~fifoLine15Out;   
      default:  fifoMux4 = 32'bx;   
    endcase // dp_muxTRC_fifo4_PROC                                 
  end                                         


//Removed the module dp_regTRC_fifoLine15 
always @(posedge CB)
  begin: dp_regTRC_fifoLine15_PROC
    if (trcFifoE1[15])
      fifoLine15Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine15_PROC

//Removed the module dp_regTRC_fifoLine14 
always @(posedge CB)
  begin: dp_regTRC_fifoLine14_PROC
    if (trcFifoE1[14])
      fifoLine14Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine14_PROC

//Removed the module dp_regTRC_fifoLine13 
always @(posedge CB)
  begin: dp_regTRC_fifoLine13_PROC
    if (trcFifoE1[13])
      fifoLine13Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine13_PROC

//Removed the module dp_regTRC_fifoLine12 
always @(posedge CB)
  begin: dp_regTRC_fifoLine12_PROC
    if (trcFifoE1[12])
      fifoLine12Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine12_PROC

//Removed the module dp_regTRC_fifoLine11 
always @(posedge CB)
  begin: dp_regTRC_fifoLine11_PROC
    if (trcFifoE1[11])
      fifoLine11Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine11_PROC

//Removed the module dp_regTRC_fifoLine10 
always @(posedge CB)
  begin: dp_regTRC_fifoLine10_PROC
    if (trcFifoE1[10])
      fifoLine10Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine10_PROC

//Removed the module dp_regTRC_fifoLine9 
always @(posedge CB)
  begin: dp_regTRC_fifoLine9_PROC
    if (trcFifoE1[9])
      fifoLine9Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine9_PROC

//Removed the module dp_regTRC_fifoLine8 
always @(posedge CB)
  begin: dp_regTRC_fifoLine8_PROC
    if (trcFifoE1[8])
      fifoLine8Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine8_PROC

//Removed the module dp_muxTRC_fifo3 
always @(fifoRdAddrL2 or fifoLine8Out or fifoLine9Out or fifoLine10Out or fifoLine11Out) 
  begin:  dp_muxTRC_fifo3_PROC					    
    case(fifoRdAddrL2[2:3])    		    	  
     2'b00:  fifoMux3 = ~fifoLine8Out;   
     2'b01:  fifoMux3 = ~fifoLine9Out;   
     2'b10:  fifoMux3 = ~fifoLine10Out;   
     2'b11:  fifoMux3 = ~fifoLine11Out;   
      default:  fifoMux3 = 32'bx;   
    endcase // dp_muxTRC_fifo3_PROC                                 
  end                                         

//Removed the module dp_muxTRC_fifo2 
always @(fifoRdAddrL2 or fifoLine4Out or fifoLine5Out or fifoLine6Out or fifoLine7Out) 
  begin:  dp_muxTRC_fifo2_PROC					    
    case(fifoRdAddrL2[2:3])    		    	  
     2'b00:  fifoMux2 = ~fifoLine4Out;   
     2'b01:  fifoMux2 = ~fifoLine5Out;   
     2'b10:  fifoMux2 = ~fifoLine6Out;   
     2'b11:  fifoMux2 = ~fifoLine7Out;   
      default:  fifoMux2 = 32'bx;   
    endcase // dp_muxTRC_fifo2_PROC                                 
  end                                         

//Removed the module dp_muxTRC_fifo1 
always @(fifoRdAddrL2 or fifoLine0Out or fifoLine1Out or fifoLine2Out or fifoLine3Out) 
  begin:  dp_muxTRC_fifo1_PROC					    
    case(fifoRdAddrL2[2:3])    		    	  
     2'b00:  fifoMux1 = ~fifoLine0Out;   
     2'b01:  fifoMux1 = ~fifoLine1Out;   
     2'b10:  fifoMux1 = ~fifoLine2Out;   
     2'b11:  fifoMux1 = ~fifoLine3Out;   
      default:  fifoMux1 = 32'bx;   
    endcase // dp_muxTRC_fifo1_PROC                                 
  end                                         

//Removed the module dp_regTRC_fifoLine7 
always @(posedge CB)
  begin: dp_regTRC_fifoLine7_PROC
    if (trcFifoE1[7])
      fifoLine7Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine7_PROC

//Removed the module dp_regTRC_fifoLine6 
always @(posedge CB)
  begin: dp_regTRC_fifoLine6_PROC
    if (trcFifoE1[6])
      fifoLine6Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine6_PROC

//Removed the module dp_regTRC_fifoLine5 
always @(posedge CB)
  begin: dp_regTRC_fifoLine5_PROC
    if (trcFifoE1[5])
      fifoLine5Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine5_PROC

//Removed the module dp_regTRC_fifoLine4 
always @(posedge CB)
  begin: dp_regTRC_fifoLine4_PROC
    if (trcFifoE1[4])
      fifoLine4Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine4_PROC

//Removed the module dp_regTRC_fifoLine3 
always @(posedge CB)
  begin: dp_regTRC_fifoLine3_PROC
    if (trcFifoE1[3])
      fifoLine3Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine3_PROC

//Removed the module dp_regTRC_fifoLine2 
always @(posedge CB)
  begin: dp_regTRC_fifoLine2_PROC
    if (trcFifoE1[2])
      fifoLine2Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine2_PROC

//Removed the module dp_regTRC_fifoLine1 
always @(posedge CB)
  begin: dp_regTRC_fifoLine1_PROC
    if (trcFifoE1[1])
      fifoLine1Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine1_PROC

//Removed the module dp_regTRC_fifoLine0 
always @(posedge CB)
  begin: dp_regTRC_fifoLine0_PROC
    if (trcFifoE1[0])
      fifoLine0Out <= fifoDataInBuf;
  end // dp_regTRC_fifoLine0_PROC


endmodule
