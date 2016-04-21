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

module p405s_exeBrCondFlow( exeCondOK_Neg, crL2, exeBIL2, exeBOL2, exeCtrEq0 );

output  exeCondOK_Neg;

input  exeCtrEq0;
input [0:31]  crL2;
input [0:3]  exeBOL2;
input [0:4]  exeBIL2;

// Buses in the design

reg  [0:7]  crBitStage1;
reg crBit_Neg;


   // Replacing instantiation: NAND2 I39
   wire exeDataB0_2_Neg;
   wire exeDataBO_3_Neg;
   wire ctrCmp0;
   assign ctrCmp0 = ~( exeDataB0_2_Neg & exeDataBO_3_Neg );

   // Replacing instantiation: NAND2 I38
   wire ctrCmp1;
   assign ctrCmp1 = ~( exeDataB0_2_Neg & exeBOL2[3] );

   // Replacing instantiation: NAND2 I40
   wire exeDataB0_0_Neg;
   wire exeDataBO_1_Neg;
   wire crCmp1;
   assign crCmp1 = ~( exeDataB0_0_Neg & exeDataBO_1_Neg );

   // Replacing instantiation: NAND2 I41
   wire crCmp0;
   assign crCmp0 = ~( exeDataB0_0_Neg & exeBOL2[1] );

   // Replacing instantiation: NAND2 I36
   wire cr0ctr1_Neg;
   assign cr0ctr1_Neg = ~( crCmp0 & ctrCmp1 );

   // Replacing instantiation: NAND2 I35
   wire cr1ctr0_Neg;
   assign cr1ctr0_Neg = ~( crCmp1 & ctrCmp0 );

   // Replacing instantiation: NAND2 I34
   wire cr1ctr1_Neg;
   assign cr1ctr1_Neg = ~( crCmp1 & ctrCmp1 );

   // Replacing instantiation: NAND2 I37
   wire cr0ctr0_Neg;
   assign cr0ctr0_Neg = ~( crCmp0 & ctrCmp0 );

   // Replacing instantiation: MUX41 condOk
   reg condOk_muxOut;
   wire condOk_SD1,condOk_SD2; 
   wire condOk_D0,condOk_D1,condOk_D2,condOk_D3; 
   assign exeCondOK_Neg = condOk_muxOut;       
   assign condOk_SD1 = crBit_Neg;       
   assign condOk_SD2 = exeCtrEq0;       
   assign condOk_D0 = cr1ctr1_Neg;         
   assign condOk_D1 = cr1ctr0_Neg;         
   assign condOk_D2 = cr0ctr1_Neg;         
   assign condOk_D3 = cr0ctr0_Neg;         
                                               
   always @(condOk_SD1 or condOk_SD2 or condOk_D0 or condOk_D1 or  
            condOk_D2 or condOk_D3)  	    
    begin 					    
    case({condOk_SD1,condOk_SD2})    	
     2'b00: condOk_muxOut = condOk_D0;    
     2'b01: condOk_muxOut = condOk_D1;    
     2'b10: condOk_muxOut = condOk_D2;    
     2'b11: condOk_muxOut = condOk_D3;    
      default: condOk_muxOut = 1'bx;        
    endcase                                    
   end                                         

  //Removed the module 'dp_muxIFB_exeBrCrBit2'
  always @(crBitStage1 or exeBIL2)
     case(exeBIL2[2:4])
       3'b000: crBit_Neg = ~crBitStage1[0];
       3'b001: crBit_Neg = ~crBitStage1[1];
       3'b010: crBit_Neg = ~crBitStage1[2];
       3'b011: crBit_Neg = ~crBitStage1[3];
       3'b100: crBit_Neg = ~crBitStage1[4];
       3'b101: crBit_Neg = ~crBitStage1[5];
       3'b110: crBit_Neg = ~crBitStage1[6];
       3'b111: crBit_Neg = ~crBitStage1[7];
       default: crBit_Neg = 1'bx;
     endcase


  //Removed the module 'dp_muxIFB_exeBrCrBit1' 
  always @(crL2 or exeBIL2)
     case({exeBIL2[0],exeBIL2[1]})
       2'b00: crBitStage1 = crL2[0:7];
       2'b01: crBitStage1 = crL2[8:15];
       2'b10: crBitStage1 = crL2[16:23];
       2'b11: crBitStage1 = crL2[24:31];
       default: crBitStage1 = 8'bx;
     endcase

   // Replacing instantiation: INVERT I48
   assign exeDataBO_3_Neg = ~(exeBOL2[3]);

   // Replacing instantiation: INVERT I47
   assign exeDataB0_2_Neg = ~(exeBOL2[2]);

   // Replacing instantiation: INVERT I46
   assign exeDataBO_1_Neg = ~(exeBOL2[1]);

   // Replacing instantiation: INVERT I49
   assign exeDataB0_0_Neg = ~(exeBOL2[0]);


endmodule
