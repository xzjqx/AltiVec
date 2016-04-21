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

module p405s_dtlb_dsWord( E_out, 
               G_out,
               Hit,
               I_out,
               Miss,
               RA,
               U0_out,
               WR_out,
               W_out,
               zonePR_out,
               CB,
               DSize,
               E,
               EXE_dsEaCP,
               EXE_eaARegBuf,
               EXE_eaBRegBuf,
               G,
               I,
               LSSD_coreTestEn,
               RPN,
               U0,
               W,
               WR,
               WordSel_N,
               dsEAforMunge,
               dsEPN,
               dsStateA,
               invalidate,
               msrDR,
               rdNotWrt,
               zonePR
               );

output  E_out;
output  G_out;
output  Hit;
output  I_out;
output  Miss;
output  U0_out;
output  WR_out;
output  W_out;

input  E;
input  G;
input  I;
input  LSSD_coreTestEn;
input  U0;
input  W;
input  WR;
input  WordSel_N;
input  dsStateA;
input  invalidate;
input  msrDR;
input  rdNotWrt;

output [0:1]   zonePR_out;
output [0:21]  RA;

input         CB;
input [0:21]  EXE_eaARegBuf;
input [8:21]  dsEAforMunge;
input [0:21]  EXE_eaBRegBuf;
input [0:7]   EXE_dsEaCP;
input [0:21]  RPN;
input [0:6]   DSize;
input [0:21]  dsEPN;
input [0:1]   zonePR;

// Buses in the design

wire  [0:21]  Carry;
wire  [0:21]  sum;
wire  [0:21]  EAL_N;
wire  [0:21]  EAL;
wire  [8:21]  RA_N;
wire  [0:6]   Size;
wire  [8:21]  RAddr;

wire writeOrInval;
wire Regs_LoadL2;
wire msrDR_NEG;
wire Valid_NEG;
wire word_valid;
wire Invalidate_N;
wire Regs_LoadL1;

reg  [0:29]  RA_Attr_reg;  
reg  [0:28]  EPN_DSize_reg;  
reg          Valid_DataIn;  
reg          Valid_reg;  
wire [8:21]  xlate;


  // Removed the module "dp_logMMU_EPNinv"
  assign EAL_N[0:21] = ~(EAL[0:21]);

  // Removed the module "dp_logMMU_dsWordAdder"
  assign Carry[0:21] = ((EAL_N[0:21] & EXE_eaBRegBuf[0:21]) | ((EAL_N[0:21] & 
                         EXE_eaARegBuf[0:21]) |
                        (EXE_eaBRegBuf[0:21] & EXE_eaARegBuf[0:21])));
  assign sum[0:21] = (EAL_N[0:21] ^ (EXE_eaBRegBuf[0:21] ^ EXE_eaARegBuf[0:21]));

p405s_dtlb_SM_dsEaComp
 dsEAComp( .Hit        (Hit), 
                      .Miss       (Miss), 
                      .EXE_dsEaCP (EXE_dsEaCP[0:7]), 
                      .FC         (Carry[0:21]), 
                      .FS         (sum[0:21]), 
                      .LSSD_coreTestEn  (LSSD_coreTestEn),
                      .Size       (Size[0:6]), 
                      .Valid      (word_valid), 
                      .dsStateA   (dsStateA), 
                      .msrDR_NEG  (msrDR_NEG)
                      );
  
  // Removed the module "dp_regMMU_dsWord_RA_Attr"
  always @(posedge CB)      
    begin        
      casez(Regs_LoadL1 & Regs_LoadL2)        
        1'b0: RA_Attr_reg <= RA_Attr_reg;        
        1'b1: RA_Attr_reg <= {RPN[0:21], I, E, U0, W, G, WR,zonePR[0:1]};        
        default: RA_Attr_reg <= 30'bx;  
      endcase        
    end        

  assign {RA[0:7], RAddr[8:21], I_out, E_out,U0_out, W_out, G_out, WR_out, 
                   zonePR_out[0:1]} = RA_Attr_reg;

  // Removed the module "dp_regMMU_dsWord_EPN_DSize"
  always @(posedge CB)      
    begin        
      casez(Regs_LoadL1 & Regs_LoadL2)        
        1'b0: EPN_DSize_reg <= EPN_DSize_reg;        
        1'b1: EPN_DSize_reg <= {dsEPN[0:9], DSize[0], dsEPN[10:11], DSize[1], dsEPN[12:13], 
                               DSize[2], dsEPN[14:15], DSize[3], dsEPN[16:17], DSize[4], 
                               dsEPN[18:19], DSize[5], dsEPN[20:21], DSize[6]};        
        default: EPN_DSize_reg <= 29'bx;  
      endcase        
    end        

  assign {EAL[0:9], Size[0], EAL[10:11], Size[1], EAL[12:13], Size[2], EAL[14:15], Size[3],
          EAL[16:17], Size[4], EAL[18:19], Size[5], EAL[20:21], Size[6]} = EPN_DSize_reg;

  // Removed the module "dp_regMMU_dsWord_Valid"
  always @(Invalidate_N or word_valid or writeOrInval)    
    begin        
      casez(writeOrInval)        
        1'b0: Valid_DataIn = Invalidate_N;   
        1'b1: Valid_DataIn = word_valid;   
        default: Valid_DataIn = 1'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      Valid_reg <= Valid_DataIn;     
    end        

  assign Valid_NEG = ~(Valid_reg);

  // Removed the module "dp_logMMU_dsWord0_RANot"
  assign RA_N[8:21] = ~(RAddr[8:21]);

   // Replacing instantiation: GTECH_NOR2 I49
   assign writeOrInval = ~( invalidate | Regs_LoadL2 );

   // Replacing instantiation: GTECH_NOR2 I48
   assign Regs_LoadL2 = ~( rdNotWrt | WordSel_N );

   // Replacing instantiation: GTECH_NOT I58
   assign msrDR_NEG = ~(msrDR);

   // Replacing instantiation: GTECH_NOT I59
   assign word_valid = ~(Valid_NEG);

   // Replacing instantiation: GTECH_NOT I46
   assign Invalidate_N = ~(invalidate);

   // Replacing instantiation: GTECH_NOT I47
   assign Regs_LoadL1 = ~(WordSel_N);

  // Removed the module "Shadow_Munge"
  assign RA[8:21] = ~( RA_N[8:21] & xlate[8:21] );
  assign xlate[8:21] = ~( dsEAforMunge[8:21] & {Size[0], Size[0], Size[1], Size[1], 
                          Size[2], Size[2],Size[3], Size[3], Size[4], Size[4], Size[5], 
                          Size[5], Size[6], Size[6]} );

endmodule
