// Library - PR_mmu, Cell - isWord0, // View - schematic, Version - 0.28
// PGM  09/11/01   1873   Remove reference to cds_globals, replace with 1'b0, 1'b1

module p405s_itlb_isWord0( E_out_N,
                Hit,
                I_out_N,
                Miss,
                RA,
                U0_out_N,
                CB,
                CompE2,
                DSize,
                E,
                I,
                LoadRealRaAttr,
                RPN,
                U0,
                VCT_msrIR,
                WordSel_N,
                invalidate,
                isAbort_N,
                isEA,
                isEA_NEG,
                isEPN,
                msrIrL2,
                rdNotWrt,
                writeShadow
                );

output  E_out_N;
output  Hit;
output  I_out_N;
output  Miss;
output  U0_out_N;

input  CompE2;
input  E;
input  I;
input  LoadRealRaAttr;
input  U0;
input  VCT_msrIR;
input  WordSel_N;
input  invalidate;
input  isAbort_N;
input  msrIrL2;
input  rdNotWrt;
input  writeShadow;

output [0:21]  RA;

input [0:21]  isEA;
input         CB;
input [0:21]  RPN;
input [0:6]  DSize;
input [0:21]  isEPN;
input [0:21]  isEA_NEG;

// Buses in the design

wire  [0:6]  SizeForMunge;
wire  [0:6]  Size;
wire  [0:21]  EAL;
wire  [0:24]  RaAttrforLtch;
wire  [0:21]  RA_N;
wire  [0:6]  Size_N;
wire  [0:21]  EAL_N;

wire  valid_NEG;
wire  valid;
wire  epnE1;
wire  writeOrInval;
wire  stateDhitSel;
wire  LoadRealRaAttr_N;

reg  [0:8]   RA_Attr2_DataIn;
reg  [0:8]   RA_Attr2_reg;
reg  [0:28]  EPN_DSize_reg;  
reg  [0:15]  RA_Attr_DataIn;  
reg  [0:15]  RA_Attr_reg;  
reg          Valid_DataIn;  
reg          Valid_reg;  
wire [8:21]  xlate;

wire  E_out_N_i;
wire  I_out_N_i;
wire  U0_out_N_i;

  assign E_out_N = E_out_N_i;
  assign I_out_N = I_out_N_i;
  assign U0_out_N = U0_out_N_i;

   // Replacing instantiation: GTECH_AND2 I176
   wire invalidate_N;
   wire writeEntry;
   wire symNet112;
   assign symNet112 = writeEntry & invalidate_N;

  // Removed the module "dp_logMMU_isWord0redrive"
  assign LoadRealRaAttr_N = ~(LoadRealRaAttr);

  // Removed the module "dp_logMMU_SieInv"
  assign Size[0:6] = ~(Size_N[0:6]);

  // Removed the module "dp_logMMU_realSizeSel"
  assign SizeForMunge[0:6] = ~(({7{1'b1}} & {7{~(msrIrL2)}} ) |
                               (Size_N[0:6] & {7{msrIrL2}} ));

   // Replacing instantiation: GTECH_NAND2 I161
   wire Regs_LoadE1;
   assign Regs_LoadE1 = ~( WordSel_N & VCT_msrIR );

  // Removed the module "dp_regMMU_isWord0_RA_Attr2"
  always @(RaAttrforLtch or RPN or I or E or U0 or symNet112)    
    begin        
      casez(symNet112)        
        1'b0: RA_Attr2_DataIn = RaAttrforLtch[16:24];   
        1'b1: RA_Attr2_DataIn = {RPN[16:21],I, E, U0};   
        default: RA_Attr2_DataIn = 9'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(Regs_LoadE1)        
        1'b0: RA_Attr2_reg <= RA_Attr2_reg;        
        1'b1: RA_Attr2_reg <= RA_Attr2_DataIn;   
        default: RA_Attr2_reg <= 9'bx;  
      endcase            
    end        

  assign {RA_N[16:21], I_out_N_i, E_out_N_i, U0_out_N_i} = ~(RA_Attr2_reg);

  // Removed the module "dp_muxMMU_isWd0RaMux"
  assign RaAttrforLtch[0:24] = ~(({RA_N[0:21], I_out_N_i, E_out_N_i, U0_out_N_i} & 
                                  {25{~(LoadRealRaAttr_N)}} ) |
                                  ({isEA_NEG[0:21], 1'b1, 1'b1, 1'b1} & 
                                  {25{LoadRealRaAttr_N}} ));

  // Removed the module "dp_logMMU_isWord0RAinv"
  assign RA[0:7] = ~(RA_N[0:7]);

  // Removed the module "dp_regMMU_isWord0_EPN_DSize"
  always @(posedge CB)      
    begin        
      casez(epnE1 & writeEntry)        
        1'b0: EPN_DSize_reg <= EPN_DSize_reg;        
        1'b1: EPN_DSize_reg <= {isEPN[0:9],DSize[0],isEPN[10:11],DSize[1],isEPN[12:13], 
                               DSize[2],isEPN[14:15],DSize[3],isEPN[16:17],DSize[4], 
                               isEPN[18:19],DSize[5],isEPN[20:21],DSize[6]};        
        default: EPN_DSize_reg <= 29'bx;  
      endcase        
    end        

  assign {EAL_N[0:9],Size_N[0],EAL_N[10:11],Size_N[1],EAL_N[12:13],Size_N[2],
          EAL_N[14:15],Size_N[3],EAL_N[16:17],Size_N[4],EAL_N[18:19],Size_N[5], 
          EAL_N[20:21], Size_N[6]} = ~(EPN_DSize_reg);

  // Removed the module "dp_regMMU_isWord0_RA_Attr"
  always @(RaAttrforLtch or RPN or symNet112)    
    begin        
      casez(symNet112)        
        1'b0: RA_Attr_DataIn = RaAttrforLtch[0:15];   
        1'b1: RA_Attr_DataIn = RPN[0:15];   
        default: RA_Attr_DataIn = 16'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      casez(Regs_LoadE1)        
        1'b0: RA_Attr_reg <= RA_Attr_reg;        
        1'b1: RA_Attr_reg <= RA_Attr_DataIn;   
        default: RA_Attr_reg <= 16'bx;  
      endcase        
    end        

  assign RA_N[0:15] = ~(RA_Attr_reg);

p405s_itlb_isComp0
 isComparator0( .Hit          (Hit), 
                       .Miss         (Miss), 
                       .stateDhitSel (stateDhitSel), 
                       .CB           (CB), 
                       .CompE2       (CompE2), 
                       .EPN          (EAL[0:21]),
                       .EPN_NEG      (EAL_N[0:21]), 
                       .Size         (Size[0:6]), 
                       .Valid        (valid), 
                       .WordSelect   (epnE1), 
                       .isAbort_NEG  (isAbort_N), 
                       .isEA         (isEA[0:21]), 
                       .msrIrL2      (msrIrL2),
                       .writeShadow  (writeShadow)
                       );

  // Removed the module "dp_logMMU_isEAinvforITLB"
  assign EAL[0:21] = ~(EAL_N[0:21]);

  // Removed the module "dp_regMMU_isWord_Valid"
  always @(invalidate_N or valid or writeOrInval)    
    begin        
      casez(writeOrInval)        
        1'b0: Valid_DataIn = invalidate_N;   
        1'b1: Valid_DataIn = valid;   
        default: Valid_DataIn = 1'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      Valid_reg <= Valid_DataIn;     
    end        

  assign valid_NEG = ~(Valid_reg);

   // Replacing instantiation: GTECH_NOT I43
   assign valid = ~(valid_NEG);

   // Replacing instantiation: GTECH_NOT I166
   assign epnE1 = ~(WordSel_N);

   // Replacing instantiation: GTECH_NOT I37
   assign invalidate_N = ~(invalidate);

   // Replacing instantiation: GTECH_NOR2 I35
   assign writeOrInval = ~( invalidate | writeEntry );

   // Replacing instantiation: GTECH_NOR2 I36
   assign writeEntry = ~( stateDhitSel | WordSel_N );

  // Removed the module "Shadow_Munge"
  assign RA[8:21] = ~( RA_N[8:21] & xlate[8:21] );
  assign xlate[8:21] = ~( isEPN[8:21] & {SizeForMunge[0],SizeForMunge[0],SizeForMunge[1],
                          SizeForMunge[1],SizeForMunge[2],SizeForMunge[2],SizeForMunge[3], 
                          SizeForMunge[3],SizeForMunge[4],SizeForMunge[4],SizeForMunge[5],
                          SizeForMunge[5],SizeForMunge[6],SizeForMunge[6]} );

endmodule
