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

module p405s_DCU_plbMux( DCU_plbDBus,
                         CB,
                         FDR_L2mux,
                         PLBDR_E2,
                         PLBDR_hiMuxSel,
                         SDP_FDR_muxSel,
                         SDP_dataL2,
                         sampleCycleL2
                        );


input  SDP_FDR_muxSel;
input  sampleCycleL2;

output [0:63]  DCU_plbDBus;


input [0:63]  FDR_L2mux;
input [0:3]  PLBDR_hiMuxSel;
input [0:3]  PLBDR_E2;
input [0:31]  SDP_dataL2;
input CB;

// Buses in the design

wire  [0:31]  DCU_plbDBusNoBuf;
wire  [0:31]  DCU_plbDBusNoBufInv;
wire  [0:63]  SDP_FDR_data;

wire sampleCycleInv, SDP_FDR_muxSelInv,sampleCycleBuf01;
wire sampleCycleBuf23, SDP_FDR_muxSel0145, SDP_FDR_muxSel2367;


reg [24:31] regDCU_PLB_DRloByte3_L2;
reg [16:23] regDCU_PLB_DRloByte2_L2;
reg [8:15] regDCU_PLB_DRloByte1_L2;
reg [0:7] regDCU_PLB_DRloByte0_L2;
reg [24:31] regDCU_PLB_DRhiByte3_muxout, regDCU_PLB_DRhiByte3_L2;
wire [0:31] DCU_plbDBusNoBufHiInv;
reg [16:23] regDCU_PLB_DRhiByte2_muxout, regDCU_PLB_DRhiByte2_L2;
reg [8:15] regDCU_PLB_DRhiByte1_muxout, regDCU_PLB_DRhiByte1_L2;
reg [0:7] regDCU_PLB_DRhiByte0_muxout,regDCU_PLB_DRhiByte0_L2;


// Removed the module 'dp_logDCU_sampleCycleBuf3'
assign {sampleCycleInv, SDP_FDR_muxSelInv} = ~({sampleCycleL2, SDP_FDR_muxSel});

// Removed the module 'dp_logDCU_sampleCycleBuf'
assign {sampleCycleBuf01, sampleCycleBuf23, SDP_FDR_muxSel0145, SDP_FDR_muxSel2367} = 
     ~({sampleCycleInv, sampleCycleInv,SDP_FDR_muxSelInv, SDP_FDR_muxSelInv});

// Removed the module 'dp_logDCU_PLBDRhiInv'
assign DCU_plbDBus[0:31] = ~(DCU_plbDBusNoBufHiInv[0:31]);

// Removed the module 'dp_regDCU_PLB_DRloByte3'
assign DCU_plbDBusNoBufInv[24:31] = ~(regDCU_PLB_DRloByte3_L2[24:31]);
always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf23 & PLBDR_E2[3])
     1'b0: regDCU_PLB_DRloByte3_L2[24:31] <= regDCU_PLB_DRloByte3_L2[24:31];                
     1'b1: regDCU_PLB_DRloByte3_L2[24:31] <= SDP_FDR_data[56:63]; 
      default: regDCU_PLB_DRloByte3_L2[24:31] <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_PLB_DRloByte2'
assign DCU_plbDBusNoBufInv[16:23] = ~(regDCU_PLB_DRloByte2_L2[16:23]);
always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf23 & PLBDR_E2[2])
     1'b0: regDCU_PLB_DRloByte2_L2 <= regDCU_PLB_DRloByte2_L2;                
     1'b1: regDCU_PLB_DRloByte2_L2 <= SDP_FDR_data[48:55]; 
      default: regDCU_PLB_DRloByte2_L2 <= 8'bx;  
    endcase                             
   end

// Removed the module 'dp_regDCU_PLB_DRloByte1'
assign DCU_plbDBusNoBufInv[8:15] = ~(regDCU_PLB_DRloByte1_L2[8:15]);
always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf01 & PLBDR_E2[1])
     1'b0: regDCU_PLB_DRloByte1_L2 <= regDCU_PLB_DRloByte1_L2;                
     1'b1: regDCU_PLB_DRloByte1_L2 <= SDP_FDR_data[40:47]; 
      default: regDCU_PLB_DRloByte1_L2 <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_PLB_DRloByte0'
assign DCU_plbDBusNoBufInv[0:7] = ~(regDCU_PLB_DRloByte0_L2[0:7]);
always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf01 & PLBDR_E2[0])
     1'b0: regDCU_PLB_DRloByte0_L2 <= regDCU_PLB_DRloByte0_L2;                
     1'b1: regDCU_PLB_DRloByte0_L2 <= SDP_FDR_data[32:39]; 
      default: regDCU_PLB_DRloByte0_L2 <= 8'bx;  
    endcase                             
   end  

// Removed the module 'dp_regDCU_PLB_DRhiByte3'
assign DCU_plbDBusNoBufHiInv[24:31] = ~(regDCU_PLB_DRhiByte3_L2[24:31]);
always @(SDP_FDR_data or DCU_plbDBusNoBuf or PLBDR_hiMuxSel)
    begin                                       
    casez(PLBDR_hiMuxSel[3])                    
     1'b0: regDCU_PLB_DRhiByte3_muxout = SDP_FDR_data[24:31];
     1'b1: regDCU_PLB_DRhiByte3_muxout = DCU_plbDBusNoBuf[24:31];   
      default: regDCU_PLB_DRhiByte3_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf23 & PLBDR_E2[3])
     1'b0: regDCU_PLB_DRhiByte3_L2 <= regDCU_PLB_DRhiByte3_L2;                
     1'b1: regDCU_PLB_DRhiByte3_L2 <= regDCU_PLB_DRhiByte3_muxout;       
      default: regDCU_PLB_DRhiByte3_L2 <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_PLB_DRhiByte2'
assign DCU_plbDBusNoBufHiInv[16:23] = ~(regDCU_PLB_DRhiByte2_L2[16:23]);
always @(SDP_FDR_data or DCU_plbDBusNoBuf or PLBDR_hiMuxSel)
    begin                                       
    casez(PLBDR_hiMuxSel[2])                    
     1'b0: regDCU_PLB_DRhiByte2_muxout = SDP_FDR_data[16:23];
     1'b1: regDCU_PLB_DRhiByte2_muxout = DCU_plbDBusNoBuf[16:23];   
      default: regDCU_PLB_DRhiByte2_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf23 & PLBDR_E2[2])
     1'b0: regDCU_PLB_DRhiByte2_L2 <= regDCU_PLB_DRhiByte2_L2;                
     1'b1: regDCU_PLB_DRhiByte2_L2 <= regDCU_PLB_DRhiByte2_muxout;       
      default: regDCU_PLB_DRhiByte2_L2 <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_PLB_DRhiByte1'
assign DCU_plbDBusNoBufHiInv[8:15] = ~(regDCU_PLB_DRhiByte1_L2[8:15]);
always @(SDP_FDR_data or DCU_plbDBusNoBuf or PLBDR_hiMuxSel)
    begin                                       
    casez(PLBDR_hiMuxSel[1])                    
     1'b0: regDCU_PLB_DRhiByte1_muxout = SDP_FDR_data[8:15];
     1'b1: regDCU_PLB_DRhiByte1_muxout = DCU_plbDBusNoBuf[8:15];   
      default: regDCU_PLB_DRhiByte1_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf01 & PLBDR_E2[1])
     1'b0: regDCU_PLB_DRhiByte1_L2 <= regDCU_PLB_DRhiByte1_L2;                
     1'b1: regDCU_PLB_DRhiByte1_L2 <= regDCU_PLB_DRhiByte1_muxout;       
      default: regDCU_PLB_DRhiByte1_L2 <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_regDCU_PLB_DRhiByte0'
assign DCU_plbDBusNoBufHiInv[0:7] = ~(regDCU_PLB_DRhiByte0_L2[0:7]);
always @(SDP_FDR_data or DCU_plbDBusNoBuf or PLBDR_hiMuxSel)
    begin                                       
    casez(PLBDR_hiMuxSel[0])                    
     1'b0: regDCU_PLB_DRhiByte0_muxout = SDP_FDR_data[0:7];
     1'b1: regDCU_PLB_DRhiByte0_muxout = DCU_plbDBusNoBuf[0:7];   
      default: regDCU_PLB_DRhiByte0_muxout = 8'bx;  
    endcase                             
   end                                  
   // L2 Output modeled as posedge FF      
   always @(posedge CB)      
    begin                                       
    casez(sampleCycleBuf01 & PLBDR_E2[0])
     1'b0: regDCU_PLB_DRhiByte0_L2 <= regDCU_PLB_DRhiByte0_L2;                
     1'b1: regDCU_PLB_DRhiByte0_L2 <= regDCU_PLB_DRhiByte0_muxout;       
      default: regDCU_PLB_DRhiByte0_L2 <= 8'bx;  
    endcase                             
   end 

// Removed the module 'dp_logDCU_PLBDRlo_inv'
assign DCU_plbDBusNoBuf[0:31] = ~(DCU_plbDBusNoBufInv[0:31]);

// Removed the module 'dp_logDCU_PLBDRloInv'
assign DCU_plbDBus[32:63] = ~(DCU_plbDBusNoBufInv[0:31]);

// Removed the module 'dp_muxDCU_PLBwrBusByte7'
assign SDP_FDR_data[56:63] = (FDR_L2mux[56:63] & {(8){~(SDP_FDR_muxSel2367)}} ) | (SDP_dataL2[24:31] & {(8){SDP_FDR_muxSel2367}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte6'
assign SDP_FDR_data[48:55] = (FDR_L2mux[48:55] & {(8){~(SDP_FDR_muxSel2367)}} ) | (SDP_dataL2[16:23] & {(8){SDP_FDR_muxSel2367}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte5'
assign SDP_FDR_data[40:47] = (FDR_L2mux[40:47] & {(8){~(SDP_FDR_muxSel0145)}} ) | (SDP_dataL2[8:15] & {(8){SDP_FDR_muxSel0145}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte4'
assign SDP_FDR_data[32:39] = (FDR_L2mux[32:39] & {(8){~(SDP_FDR_muxSel0145)}} ) | ( SDP_dataL2[0:7] & {(8){SDP_FDR_muxSel0145}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte3'
assign SDP_FDR_data[24:31] = (FDR_L2mux[24:31] & {(8){~(SDP_FDR_muxSel2367)}} ) | (SDP_dataL2[24:31] & {(8){SDP_FDR_muxSel2367}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte2'
assign SDP_FDR_data[16:23] = (FDR_L2mux[16:23] & {(8){~(SDP_FDR_muxSel2367)}} ) | (SDP_dataL2[16:23] & {(8){SDP_FDR_muxSel2367}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte1'
assign SDP_FDR_data[8:15] = (FDR_L2mux[8:15] & {(8){~(SDP_FDR_muxSel0145)}} ) | (SDP_dataL2[8:15] & {(8){SDP_FDR_muxSel0145}} );

// Removed the module 'dp_muxDCU_PLBwrBusByte0'
assign SDP_FDR_data[0:7] = (FDR_L2mux[0:7] & {(8){~(SDP_FDR_muxSel0145)}} ) | (SDP_dataL2[0:7] & {(8){SDP_FDR_muxSel0145}} );

endmodule
