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

module p405s_dcdBrCondFlow( dcdCondOK, dcdTarget_Neg, crL2, dcdCtrEq0, dcdDataBI,
     dcdDataBO, dcdFirstCycleL2, dcdFullL2, dcdPfb0BranchL2, dcdPlaB, dcdPlaBc,
     dcdPredict, dcdPrediction );

output  dcdCondOK, dcdTarget_Neg;

input  dcdCtrEq0, dcdFirstCycleL2, dcdFullL2, dcdPfb0BranchL2, dcdPlaB, dcdPlaBc, dcdPredict,
     dcdPrediction;
input [0:31]  crL2;
input [0:4]  dcdDataBI;
input [0:3]  dcdDataBO;

// Buses in the design
reg  [0:7]  crBitStage1;
wire dcdCondOK_int;


assign dcdCondOK = dcdCondOK_int;

   // Replacing instantiation: NAND3 I30
   wire symNet196;
   wire symNet188;
   assign symNet188 = ~( dcdPrediction & dcdPlaBc & symNet196 );

   // Replacing instantiation: NAND3 I29
   wire symNet198;
   assign symNet198 = ~( dcdCondOK_int & dcdPlaBc & symNet196 );

   // Replacing instantiation: NAND2 I36
   wire cr0ctr1_Neg;
   wire ctrCmp1;
   wire crCmp0;
   assign cr0ctr1_Neg = ~( crCmp0 & ctrCmp1 );

   // Replacing instantiation: NAND2 I35
   wire cr1ctr0_Neg;
   wire ctrCmp0;
   wire crCmp1;
   assign cr1ctr0_Neg = ~( crCmp1 & ctrCmp0 );

   // Replacing instantiation: NAND2 I34
   wire cr1ctr1_Neg;
   assign cr1ctr1_Neg = ~( crCmp1 & ctrCmp1 );

   // Replacing instantiation: NAND2 I37
   wire cr0ctr0_Neg;
   assign cr0ctr0_Neg = ~( crCmp0 & ctrCmp0 );

   // Replacing instantiation: NAND2 I41
   wire dcdDataB0_0_Neg;
   assign crCmp0 = ~( dcdDataB0_0_Neg & dcdDataBO[1] );

   // Replacing instantiation: NAND2 I39
   wire dcdDataB0_2_Neg;
   wire dcdDataBO_3_Neg;
   assign ctrCmp0 = ~( dcdDataB0_2_Neg & dcdDataBO_3_Neg );

   // Replacing instantiation: NAND2 I38
   assign ctrCmp1 = ~( dcdDataB0_2_Neg & dcdDataBO[3] );

   // Replacing instantiation: NAND2 I40
   wire dcdDataBO_1_Neg;
   assign crCmp1 = ~( dcdDataB0_0_Neg & dcdDataBO_1_Neg );

   // Replacing instantiation: INVERT I49
   wire symNet136;
   assign symNet136 = ~(symNet196);

   // Replacing instantiation: INVERT I43
   wire cr1ctr0;
   assign cr1ctr0 = ~(cr1ctr0_Neg);

   // Replacing instantiation: INVERT I42
   wire cr1ctr1;
   assign cr1ctr1 = ~(cr1ctr1_Neg);

   // Replacing instantiation: INVERT I45
   wire cr0ctr0;
   assign cr0ctr0 = ~(cr0ctr0_Neg);

   // Replacing instantiation: INVERT I44
   wire cr0ctr1;
   assign cr0ctr1 = ~(cr0ctr1_Neg);

   // Replacing instantiation: MUX41 condOk
   reg crBit_Neg;
   reg condOk_muxOut;
   wire condOk_SD1,condOk_SD2; 
   wire condOk_D0,condOk_D1,condOk_D2,condOk_D3; 
   assign dcdCondOK_int = condOk_muxOut;       
   assign condOk_SD1 = crBit_Neg;       
   assign condOk_SD2 = dcdCtrEq0;       
   assign condOk_D0 = cr1ctr1;         
   assign condOk_D1 = cr1ctr0;         
   assign condOk_D2 = cr0ctr1;         
   assign condOk_D3 = cr0ctr0;         
                                               
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

   // Replacing instantiation: MUX41 target
   reg target_muxOut;
   wire target_SD1,target_SD2; 
   wire target_D0,target_D1,target_D2,target_D3; 
   assign dcdTarget_Neg = target_muxOut;       
   assign target_SD1 = dcdPlaB;       
   assign target_SD2 = dcdPredict;       
   assign target_D0 = symNet198;         
   assign target_D1 = symNet188;         
   assign target_D2 = symNet136;         
   assign target_D3 = symNet136;         
                                               
   always @(target_SD1 or target_SD2 or target_D0 or target_D1 or  
            target_D2 or target_D3)  	    
    begin 					    
    case({target_SD1,target_SD2})    	
     2'b00: target_muxOut = target_D0;    
     2'b01: target_muxOut = target_D1;    
     2'b10: target_muxOut = target_D2;    
     2'b11: target_muxOut = target_D3;    
//      default: target_muxOut = 1'bx;        
//
//   The default state going to X is wrong, per the
//   primative.  Talking to John Kuhns, Terry Bowness, 
//   and using Arul's solution, I changed it to go to
//   the same state as one of the inputs.  This matches
//   primative.   NOTE- I only changed this mux.  Others
//   may need to be changed.   --chrism
      default: target_muxOut = target_D0;        
    endcase                                    
   end                                         

   // Replacing instantiation: AND3 I28
   wire dcdPfb0BranchL2_Neg;
   assign symNet196 = dcdFullL2 & dcdFirstCycleL2 & dcdPfb0BranchL2_Neg;

   // Replacing instantiation: INVERT I48
   assign dcdDataBO_3_Neg = ~(dcdDataBO[3]);

   // Replacing instantiation: INVERT I17
   assign dcdDataBO_1_Neg = ~(dcdDataBO[1]);

   // Replacing instantiation: INVERT I27
   assign dcdPfb0BranchL2_Neg = ~(dcdPfb0BranchL2);

   // Replacing instantiation: INVERT I46
   assign dcdDataB0_0_Neg = ~(dcdDataBO[0]);

   // Replacing instantiation: INVERT I47
   assign dcdDataB0_2_Neg = ~(dcdDataBO[2]);

   //Removed the module 'dp_muxIFB_dcdBrCrBit2' 
   always @(crBitStage1 or dcdDataBI)
     case(dcdDataBI[2:4])
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

   //Removed the module 'dp_muxIFB_dcdBrCrBit1' 
   always @(crL2 or dcdDataBI or dcdDataBI)
     case(dcdDataBI[0:1])
       2'b00: crBitStage1 = crL2[0:7];
       2'b01: crBitStage1 = crL2[8:15];
       2'b10: crBitStage1 = crL2[16:23];
       2'b11: crBitStage1 = crL2[24:31];
       default: crBitStage1 = 8'bx;
     endcase

endmodule
