// Library - PR_mmu, Cell - isWord1_3, // View - schematic, Version - 0.11 

module p405s_itlb_isWord1_3( E_out,
                  Hit,
                  I_out,
                  Miss,
                  RA,
                  U0_out,
                  CB,
                  CompE2,
                  DSize,
                  E,
                  I,
                  RPN,
                  U0,
                  WordSel_N,
                  invalidate,
                  isAbort_N,
                  isEA,
                  isEPN,
                  msrIrL2,
                  rdNotWrt,
                  writeShadow
                  );

output  E_out;
output  Hit;
output  I_out;
output  Miss;
output  U0_out;

input  CompE2;
input  E;
input  I;
input  U0;
input  WordSel_N;
input  invalidate;
input  isAbort_N;
input  msrIrL2;
input  rdNotWrt;
input  writeShadow;

output [0:21]  RA;

input [0:21]  isEA;
input [0:6]   DSize;
input [0:21]  RPN;
input [0:21]  isEPN;
input         CB;

// Buses in the design

wire  [8:21]  RA_N;
wire  [8:21]  RAddr_N;
wire  [0:6]   Size;
wire  [0:21]  EAL;
wire  [0:21]  EAL_N;

wire  valid_NEG;
wire  valid;
wire  invalidate_N;
wire  Regs_LoadL1;
wire  writeOrInval;
wire  stateDhitSel;
wire  Regs_LoadL2;
reg   Valid_DataIn;  
reg   Valid_reg;  

reg   [0:24]  RA_Attr_reg;  
reg   [0:28]  EPN_DSize_reg;  
wire  [8:21]  xlate;


  // Removed the module "dp_logMMU_isWord0_RANot"
  assign RA_N[8:21] = ~(RAddr_N[8:21]);

p405s_itlb_isComp1_3
 is2CycleComp( .Hit          (Hit), 
                        .Miss         (Miss), 
                        .stateDhitSel (stateDhitSel), 
                        .CB           (CB), 
                        .CompE2       (CompE2), 
                        .EPN          (EAL[0:21]),
                        .EPN_NEG      (EAL_N[0:21]), 
                        .Size         (Size[0:6]), 
                        .Valid        (valid), 
                        .WordSelect   (Regs_LoadL1), 
                        .isAbort_NEG  (isAbort_N), 
                        .isEA         (isEA[0:21]), 
                        .msrIrL2      (msrIrL2),
                        .writeShadow  (writeShadow)
                        );

  // Removed the module "dp_logMMU_isEAinvforITLB"
  assign EAL_N[0:21] = ~(EAL[0:21]);

  // Removed the module "dp_regMMU_isWord_RA_Attr"
  always @(posedge CB)      
    begin        
      casez(Regs_LoadL1 & Regs_LoadL2)        
        1'b0: RA_Attr_reg <= RA_Attr_reg;        
        1'b1: RA_Attr_reg <= {RPN[0:21], I, E, U0};        
        default: RA_Attr_reg <= 25'bx;  
      endcase        
    end        

  assign {RA[0:7], RAddr_N[8:21], I_out, E_out, U0_out} = RA_Attr_reg;

  // Removed the module "dp_regMMU_isWord_EPN_DSize"
  always @(posedge CB)      
    begin        
      casez(Regs_LoadL1 & Regs_LoadL2)        
        1'b0: EPN_DSize_reg <= EPN_DSize_reg;        
        1'b1: EPN_DSize_reg <= {isEPN[0:9],DSize[0],isEPN[10:11],DSize[1],isEPN[12:13],
                               DSize[2],isEPN[14:15],DSize[3],isEPN[16:17],DSize[4],
                               isEPN[18:19],DSize[5],isEPN[20:21],DSize[6]};        
        default: EPN_DSize_reg <= 29'bx;  
      endcase        
    end        

  assign {EAL[0:9],Size[0],EAL[10:11],Size[1],EAL[12:13],Size[2],EAL[14:15],Size[3],
          EAL[16:17],Size[4],EAL[18:19],Size[5],EAL[20:21],Size[6]} = EPN_DSize_reg;

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

   // Replacing instantiation: GTECH_NOT I37
   assign invalidate_N = ~(invalidate);

   // Replacing instantiation: GTECH_NOT I38
   assign Regs_LoadL1 = ~(WordSel_N);

   // Replacing instantiation: GTECH_NOR2 I35
   assign writeOrInval = ~( invalidate | Regs_LoadL2 );

   // Replacing instantiation: GTECH_NOR2 I36
   assign Regs_LoadL2 = ~( stateDhitSel | WordSel_N );

  // Removed the module "Shadow_Munge"
  assign RA[8:21] = ~( RA_N[8:21] & xlate[8:21] );
  assign xlate[8:21] = ~( isEPN[8:21] & {Size[0],Size[0],Size[1],Size[1],Size[2],Size[2],
                         Size[3],Size[3],Size[4],Size[4],Size[5],Size[5],Size[6],Size[6]} ); 

endmodule
