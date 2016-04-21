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

module p405s_DCU_dataSteering( SDQ_mod,
                               p_SDQ_mod,
                               CAR_endian,
                               CB,
                               PCL_stSteerCntl,
                               SAQ_E2,
                               SDQ_E1,
                               SDQ_E2,
                               SDQ_L2,
                               p_SDQ_L2,
                               carStore,
                               ocmCompleteXltVNoWaitNoHold // added for issue 206
                             );


//--------- start ---------------
// rgoldiez - added the following 4 parity inputs that need to be steered with 

input  [0:3]  p_SDQ_L2;

//--------- end -----------------

input  CAR_endian;
input  SAQ_E2;
input  SDQ_E1;
input  SDQ_E2;
input  carStore;

input ocmCompleteXltVNoWaitNoHold; // added for issue 206

output [0:31]  SDQ_mod;

//--------- start ---------------
// rgoldiez - added the following 4 parity output bits that were steered with the 
//            corresponding SDQ_mod data

output [0:3]   p_SDQ_mod;

//--------- end -----------------

input [0:9]  PCL_stSteerCntl;
input        CB;
input [0:31]  SDQ_L2;

// Buses in the design

wire  [0:7]  stByte2;
reg   [0:7]  stAdjByte1L2;
reg   [0:7]  stAdjByte2L2;
wire  [0:7]  stByte0;
wire  [0:3]  stAdjE1;
wire  [0:7]  stByte3;
reg   [0:7]  stAdjByte3L2;
reg   [0:9]  stSteerCnltL2;
reg   [0:7]  stAdjByte0L2;
wire  [0:7]  stByte1;
wire  [0:3]  stMuxSel;
wire  [0:7]  stSteerMuxSel;

   // Replacing instantiation: OR2 issue206Gate
   wire issue206fix;
   assign issue206fix = ocmCompleteXltVNoWaitNoHold | SAQ_E2;
 // added for issue 206
   // Replacing instantiation: GTECH_NOT Notbit9
   wire symNet237;
   assign symNet237 = ~(stSteerCnltL2[9]);

   // Replacing instantiation: GTECH_AND2 gtechAnd2
   wire byte2_E2;
   assign byte2_E2 = issue206fix & stAdjE1[2];
 // changed for issue 206
   // Replacing instantiation: GTECH_AND2 gtechAnd3
   wire byte3_E2;
   assign byte3_E2 = issue206fix & stAdjE1[3];
 // changed for issue 206
   // Replacing instantiation: GTECH_AND2 endianAnd
   wire symNet245;
   assign symNet245 = CAR_endian & symNet237;

   // Replacing instantiation: GTECH_AND2 gtechAnd0
   wire byte0_E2;
   assign byte0_E2 = issue206fix & stAdjE1[0];
 // changed for issue 206
   // Replacing instantiation: GTECH_AND2 gtechAnd1
   wire byte1_E2;
   assign byte1_E2 = issue206fix & stAdjE1[1];
 // changed for issue 206
   // Replacing instantiation: GTECH_XOR2 filpByteRev2
   wire symNet254;
   assign symNet254 = stSteerCnltL2[8] ^ symNet245;

   // Replacing instantiation: GTECH_XOR2 flipByteRev
   wire bytyRevFlipped;
   assign bytyRevFlipped = stSteerCnltL2[8] ^ symNet245;

   always @(posedge CB)  	
     begin				  	
	case(SDQ_E1 & SDQ_E2)	                
	  1'b0: stSteerCnltL2[0:9] <= stSteerCnltL2[0:9];		
	  1'b1: stSteerCnltL2[0:9] <= PCL_stSteerCntl[0:9];		
	  default: stSteerCnltL2[0:9] <= 10'bx;  
	endcase		 		
     end			 		
   
p405s_dcu_stSteerPla
 stSteer(
  .stMuxSel(stMuxSel[0:3]),
  .stSteerMuxSel(stSteerMuxSel[0:7]),
  .stAdjE1(stAdjE1[0:3]),
  .mea(stSteerCnltL2[0:1]),
  .byteCount(stSteerCnltL2[2:3]),
  .cntGtEq4(stSteerCnltL2[4]),
  .storageSt(stSteerCnltL2[5]),
  .string(stSteerCnltL2[6]),
  .multiple(stSteerCnltL2[7]),
  .byteRev(bytyRevFlipped),
  .byteRev2(symNet254));



//--------- start ---------------
// rgoldiez - changed to added parity bits that need to be steered with its data
//
// Removed the module 'module dp_regDCU_stAdjByte0
// Removed the module 'module dp_regDCU_stAdjByte1
// Removed the module 'module dp_regDCU_stAdjByte2
// Removed the module 'module dp_regDCU_stAdjByte3

   reg 	     p_stAdjByte0L2;
   reg 	     p_stAdjByte1L2;
   reg 	     p_stAdjByte2L2;
   reg 	     p_stAdjByte3L2;
   
   always @(posedge CB)  	
     begin				  	
	case(carStore & byte0_E2)		
	  1'b0: {p_stAdjByte0L2,stAdjByte0L2[0:7]} <= {p_stAdjByte0L2,stAdjByte0L2[0:7]};		
	  1'b1: {p_stAdjByte0L2,stAdjByte0L2[0:7]} <= {p_SDQ_L2[0],SDQ_L2[0:7]};		
	  default: {p_stAdjByte0L2,stAdjByte0L2[0:7]} <= 9'bx;  
	endcase		 		
     end			 		
   
   always @(posedge CB)  	
     begin				  	
	case(carStore & byte1_E2)		
	  1'b0: {p_stAdjByte1L2,stAdjByte1L2[0:7]} <= {p_stAdjByte1L2,stAdjByte1L2[0:7]};		
	  1'b1: {p_stAdjByte1L2,stAdjByte1L2[0:7]} <= {p_SDQ_L2[1],SDQ_L2[8:15]};		
	  default: {p_stAdjByte1L2,stAdjByte1L2[0:7]} <= 9'bx;  
	endcase		 		
     end			 		
   
   always @(posedge CB)  	
     begin				  	
	case(carStore & byte2_E2)		
	  1'b0: {p_stAdjByte2L2,stAdjByte2L2[0:7]} <= {p_stAdjByte2L2,stAdjByte2L2[0:7]};		
	  1'b1: {p_stAdjByte2L2,stAdjByte2L2[0:7]} <= {p_SDQ_L2[2],SDQ_L2[16:23]};		
	  default: {p_stAdjByte2L2,stAdjByte2L2[0:7]} <= 9'bx;  
	endcase		 		
     end			 		
   
   always @(posedge CB)  	
     begin				  	
	case(carStore & byte3_E2)		
	  1'b0: {p_stAdjByte3L2,stAdjByte3L2[0:7]} <= {p_stAdjByte3L2,stAdjByte3L2[0:7]};		
	  1'b1: {p_stAdjByte3L2,stAdjByte3L2[0:7]} <= {p_SDQ_L2[3],SDQ_L2[24:31]};		
	  default: {p_stAdjByte3L2,stAdjByte3L2[0:7]} <= 9'bx;  
	endcase		 		
     end			 		


//--------- start ---------------
// rgoldiez - changed to added parity bits that need to be steered with its data
//
// Removed the module 'module dp_muxDCU_stSteer0
// Removed the module 'module dp_muxDCU_stSteer1
// Removed the module 'module dp_muxDCU_stSteer2
// Removed the module 'module dp_muxDCU_stSteer3

   wire   p_stByte0;
   wire   p_stByte1;
   wire   p_stByte2;
   wire   p_stByte3;
   
   reg [0:3] p_SDQ_mod;
   reg [0:31] SDQ_mod;
   
   
   always @(stSteerMuxSel or p_stByte0 or p_stByte1 or p_stByte2 or p_stByte3 or
            stByte0 or stByte1 or stByte2 or stByte3)  	    
     begin 					    
	case(stSteerMuxSel[0:1])    	
	  2'b00: {p_SDQ_mod[0],SDQ_mod[0:7]} = {p_stByte0,stByte0[0:7]};
	  2'b01: {p_SDQ_mod[0],SDQ_mod[0:7]} = {p_stByte1,stByte1[0:7]};
	  2'b10: {p_SDQ_mod[0],SDQ_mod[0:7]} = {p_stByte2,stByte2[0:7]};
	  2'b11: {p_SDQ_mod[0],SDQ_mod[0:7]} = {p_stByte3,stByte3[0:7]};
	  default: {p_SDQ_mod[0],SDQ_mod[0:7]} = 9'bx;
	endcase                                    
     end                                         
   
   always @(stSteerMuxSel or p_stByte0 or p_stByte1 or p_stByte2 or p_stByte3 or
            stByte0 or stByte1 or stByte2 or stByte3)  	    
     begin 					    
	case(stSteerMuxSel[2:3])    	
	  2'b00: {p_SDQ_mod[1],SDQ_mod[8:15]} = {p_stByte1,stByte1[0:7]};
	  2'b01: {p_SDQ_mod[1],SDQ_mod[8:15]} = {p_stByte2,stByte2[0:7]};
	  2'b10: {p_SDQ_mod[1],SDQ_mod[8:15]} = {p_stByte3,stByte3[0:7]};
	  2'b11: {p_SDQ_mod[1],SDQ_mod[8:15]} = {p_stByte0,stByte0[0:7]};
	  default: {p_SDQ_mod[1],SDQ_mod[8:15]} = 9'bx;
	endcase                                    
     end                                         
   
   always @(stSteerMuxSel or p_stByte0 or p_stByte1 or p_stByte2 or p_stByte3 or
            stByte0 or stByte1 or stByte2 or stByte3)  	    
     begin 					    
	case(stSteerMuxSel[4:5])    	
	  2'b00: {p_SDQ_mod[2],SDQ_mod[16:23]} = {p_stByte2,stByte2[0:7]};
	  2'b01: {p_SDQ_mod[2],SDQ_mod[16:23]} = {p_stByte3,stByte3[0:7]};
	  2'b10: {p_SDQ_mod[2],SDQ_mod[16:23]} = {p_stByte0,stByte0[0:7]};
	  2'b11: {p_SDQ_mod[2],SDQ_mod[16:23]} = {p_stByte1,stByte1[0:7]};
	  default: {p_SDQ_mod[2],SDQ_mod[16:23]} = 9'bx;
	endcase                                    
     end                                         
   
   always @(stSteerMuxSel or p_stByte0 or p_stByte1 or p_stByte2 or p_stByte3 or
            stByte0 or stByte1 or stByte2 or stByte3)  	    
     begin 					    
	case(stSteerMuxSel[6:7])    	
	  2'b00: {p_SDQ_mod[3],SDQ_mod[24:31]} = {p_stByte3,stByte3[0:7]};
	  2'b01: {p_SDQ_mod[3],SDQ_mod[24:31]} = {p_stByte0,stByte0[0:7]};
	  2'b10: {p_SDQ_mod[3],SDQ_mod[24:31]} = {p_stByte1,stByte1[0:7]};
	  2'b11: {p_SDQ_mod[3],SDQ_mod[24:31]} = {p_stByte2,stByte2[0:7]};
	  default: {p_SDQ_mod[3],SDQ_mod[24:31]} = 9'bx;
	endcase                                    
     end                                         
   

//--------- start ---------------
// rgoldiez - changed to added parity bits that need to be steered with its data
//
// Removed the module 'module dp_muxDCU_stByte3
// Removed the module 'module dp_muxDCU_stByte2
// Removed the module 'module dp_muxDCU_stByte1
// Removed the module 'module dp_muxDCU_stByte0
   
   assign p_stByte3 = (p_SDQ_L2[3] & ~stMuxSel[3]) | (p_stAdjByte3L2 & stMuxSel[3]);
   assign stByte3[0:7] = (SDQ_L2[24:31] & ~{8{stMuxSel[3]}}) | (stAdjByte3L2[0:7] & {8{stMuxSel[3]}});
 
   assign p_stByte2 = (p_SDQ_L2[2] & ~stMuxSel[2]) | (p_stAdjByte2L2 & stMuxSel[2]);
   assign stByte2[0:7] = (SDQ_L2[16:23] & ~{8{stMuxSel[2]}}) | (stAdjByte2L2[0:7] & {8{stMuxSel[2]}});
 
   assign p_stByte1 = (p_SDQ_L2[1] & ~stMuxSel[1]) | (p_stAdjByte1L2 & stMuxSel[1]);
   assign stByte1[0:7] = (SDQ_L2[8:15] & ~{8{stMuxSel[1]}}) | (stAdjByte1L2[0:7] & {8{stMuxSel[1]}});
 
   assign p_stByte0 = (p_SDQ_L2[0] & ~stMuxSel[0]) | (p_stAdjByte0L2 & stMuxSel[0]);
   assign stByte0[0:7] = (SDQ_L2[0:7] & ~{8{stMuxSel[0]}}) | (stAdjByte0L2[0:7] & {8{stMuxSel[0]}});
 

endmodule
