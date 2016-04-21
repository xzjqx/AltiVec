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

module p405s_gprAddrPreDcd( OUT1, IN1 );



output [0:9]  OUT1;


input [0:4]  IN1;


   // Replacing instantiation: IN1VERT preDcdMsb1Inv1
   wire msb1;
   assign msb1 = ~(IN1[0]);

   // Replacing instantiation: IN1VERT preDcdMsb1Inv2
   assign OUT1[1] = ~(msb1);

   // Replacing instantiation: IN1VERT preDcdMsb0Inv
   wire msb0;
   assign OUT1[0] = ~(msb0);

   // Replacing instantiation: BUFFER preDcdMsb0Buf
   assign msb0 = IN1[0];

   // Replacing instantiation: DEC24_DP_RTP preDcdHi
   assign OUT1[2] = ~(IN1[2]) & ~(IN1[1]); 
   assign OUT1[3] = IN1[2] & ~(IN1[1]); 
   assign OUT1[4] = ~(IN1[2]) & IN1[1]; 
   assign OUT1[5] = IN1[2] & IN1[1]; 

   // Replacing instantiation: DEC24_DP_RTP preDcdLo
   assign OUT1[6] = ~(IN1[4]) & ~(IN1[3]); 
   assign OUT1[7] = IN1[4] & ~(IN1[3]); 
   assign OUT1[8] = ~(IN1[4]) & IN1[3]; 
   assign OUT1[9] = IN1[4] & IN1[3]; 


endmodule
