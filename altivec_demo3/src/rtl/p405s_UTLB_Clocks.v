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
// Updated by KVP 9/29/00 to include  EN_ARRAYL1_preTestM3 as output (camclock in prowler)
// copied by KVP/WGLEE on 10/13/00 from local workspace

// 2/18/02  KAM   Changed LSSD_ArrayCClk_NEG to LSSD_ArrayCClk_buf for TBIRD requirements


module p405s_UTLB_Clocks( EN_C1,
                    EN_ARRAYL1,
                    C_Clock,
                    LSSD_ArrayCClk_buf,
                    TestComp,
                    TestM3,
                    lookupEn,
                    LookupenForEnC1,
                    rdEn,
                    wrEn,
                    EN_ARRAYL1_preTestM3,
                    CB);


output  EN_C1;
output  EN_ARRAYL1;
output  EN_ARRAYL1_preTestM3;

input   C_Clock;
input   LSSD_ArrayCClk_buf;
input   TestComp;
input   TestM3;
input   lookupEn;
input   LookupenForEnC1;
input   rdEn;
input   wrEn;

input   CB;

wire  EN_ARRAYL1_preTestM3_i;
wire   EN_ARRAYL1OnL1;
wire  EN_ARRAYL1On;
wire  symNet23;
wire  TestM3_NEG;
wire  C1ClockOn;
wire  symNet26;

assign EN_ARRAYL1_preTestM3 = EN_ARRAYL1_preTestM3_i;


//***********
// EN_ARRAYL1
//***********

  // Removed the module "dp_regMMU_camClockOnL1"

// `ifdef CBS         // for cycle-based simulators (MESA) 
//    // L1 Output modeled as negitive edge FF    
//    always @(negedge CB)      
//     begin        
//      EN_ARRAYL1OnL1 <= EN_ARRAYL1On;      
//    end        
// `else        
//    // L1 Output modeled as a transparent latch     
//    always @(CB or EN_ARRAYL1On or EN_ARRAYL1OnL1)      
//     begin        
//     casez(~CB)   
//      1'b0: ;
//      1'b1: EN_ARRAYL1OnL1 = EN_ARRAYL1On;
//       default: EN_ARRAYL1OnL1 = 1'bx;
//     endcase
//    end
// `endif
assign EN_ARRAYL1OnL1 = EN_ARRAYL1On;      

  // Removed the module "dp_logMMU_UTLBClockAND"
  assign EN_ARRAYL1_preTestM3_i = EN_ARRAYL1OnL1 & LSSD_ArrayCClk_buf;

  // Removed the module "dp_logMMU_UTLBClockNOR3"
  assign symNet23 = ~( rdEn | wrEn | lookupEn );

  // Removed the module "dp_logMMU_UTLBClockNOR"
  assign EN_ARRAYL1On = ~( symNet23 | 1'b0 );

  // Removed the module "dp_logMMU_UTLBClockInv"
  assign TestM3_NEG = ~(TestM3);

  // Removed the module "dp_logMMU_UTLBClockAND"
  assign EN_ARRAYL1 = EN_ARRAYL1_preTestM3_i & TestM3_NEG;


//***********
// EN_C1
//***********

  // Removed the module "dp_logMMU_UTLBClockOR4"
  assign C1ClockOn = rdEn | wrEn | LookupenForEnC1 | TestComp;

  // Removed the module "dp_logMMU_UTLBClockNAND"
  assign symNet26 = ~( C_Clock & C1ClockOn );

  // Removed the module "dp_logMMU_UTLBClockInv"
  assign EN_C1 = ~(symNet26);


endmodule
