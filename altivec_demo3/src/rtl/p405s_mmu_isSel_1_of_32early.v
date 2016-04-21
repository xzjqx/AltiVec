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

module p405s_mmu_isSel_1_of_32early( sprReal_N, 
                           CB, 
                           ea,
                           isEAL_N, 
                           msrIR_N, 
                           spr1, 
                           spr2
                           );

input  msrIR_N;

output [0:1]  sprReal_N;

input         CB;
input [0:31]  spr2;
input [0:31]  spr1;
input [0:1]   ea;
input [2:4]   isEAL_N;

// Buses in the design

wire  [0:7]  spr2_8of32L2_N;
wire  [0:7]  spr1_8of32L2_N;
wire  [0:7]  isRealfinalfour;

reg   [0:15]  isRealSel_DataIn;
reg   [0:15]  isRealSel_reg;

reg   [0:1]  sprReal_N;


  // Removed the module "dp_regMMU_isRealSel1"
  always @(isEAL_N or isRealfinalfour)
    begin        
      case(isEAL_N[2:3])        
        2'b00: sprReal_N[0:1] = ~{isRealfinalfour[3], isRealfinalfour[7]};   
        2'b01: sprReal_N[0:1] = ~{isRealfinalfour[2], isRealfinalfour[6]};   
        2'b10: sprReal_N[0:1] = ~{isRealfinalfour[1], isRealfinalfour[5]};   
        2'b11: sprReal_N[0:1] = ~{isRealfinalfour[0], isRealfinalfour[4]};   
        default: sprReal_N[0:1] = 2'bx;   
      endcase        
    end        

  // Removed the module "dp_regMMU_isRealSel0"
  assign isRealfinalfour[0:7] = ~(({spr1_8of32L2_N[1], spr1_8of32L2_N[3],spr1_8of32L2_N[5], 
                             spr1_8of32L2_N[7], spr2_8of32L2_N[1], spr2_8of32L2_N[3],
                             spr2_8of32L2_N[5], spr2_8of32L2_N[7]} & {(8){~(isEAL_N[4])}} ) |
                             ( {spr1_8of32L2_N[0], spr1_8of32L2_N[2],spr1_8of32L2_N[4],
                             spr1_8of32L2_N[6], spr2_8of32L2_N[0], spr2_8of32L2_N[2],
                             spr2_8of32L2_N[4], spr2_8of32L2_N[6]} & {(8){isEAL_N[4]}} ));

  // Removed the module "dp_regMMU_isRealSel"
  always @(spr1 or spr2 or ea)      
    begin        
      casez(ea[0:1])        
        2'b00: isRealSel_DataIn = {spr1[0:7], spr2[0:7]};  
        2'b01: isRealSel_DataIn = {spr1[8:15], spr2[8:15]};  
        2'b10: isRealSel_DataIn = {spr1[16:23], spr2[16:23]};
        2'b11: isRealSel_DataIn = {spr1[24:31], spr2[24:31]};
        default: isRealSel_DataIn = 16'bx;
      endcase    
    end

  always @(posedge CB)
    begin
      casez(msrIR_N)
        1'b0: isRealSel_reg <= isRealSel_reg;
        1'b1: isRealSel_reg <= isRealSel_DataIn;
        default: isRealSel_reg <= 16'bx;
      endcase    
    end

  assign {spr1_8of32L2_N[0:7], spr2_8of32L2_N[0:7]} = ~(isRealSel_reg);

endmodule
