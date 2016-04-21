// Library - PR_mmu, Cell - isComp1_3, // View - schematic, Version - 0.13 

module p405s_itlb_isComp1_3( Hit,
                  Miss,
                  stateDhitSel,
                  CB,
                  CompE2,
                  EPN,
                  EPN_NEG,
                  Size,
                  Valid,
                  WordSelect,
                  isAbort_NEG,
                  isEA,
                  msrIrL2,
                  writeShadow
                  );

output  Hit;
output  Miss;
output  stateDhitSel;

input  CompE2;
input  Valid;
input  WordSelect;
input  isAbort_NEG;
input  msrIrL2;
input  writeShadow;

input [0:6]   Size;
input [0:21]  EPN;
input [0:21]  EPN_NEG;
input [0:21]  isEA;
input         CB;

// Buses in the design

wire  [0:10]  comp1_11_NEG;
wire  [0:10]  comp1_11;
reg   [0:10]  isComp0_11_DataIn;  
reg   [0:10]  isComp0_11_reg;  

wire  mux1D0;
wire  mux2D0;
wire  mux3D0;
wire  mux4D0;
wire  mux5D0;
wire  mux6D0;
wire  mux7D0;
wire  mux8D0;
wire  mux9D0;
wire  mux10D0;
wire  mux11D0;

wire  mux1D1;
wire  mux2D1;
wire  mux3D1;
wire  mux4D1;
wire  mux5D1;
wire  mux6D1;
wire  mux7D1;
wire  mux8D1;
wire  mux9D1;
wire  mux10D1;
wire  mux11D1;

wire  mux1D2;
wire  mux2D2;
wire  mux3D2;
wire  mux4D2;
wire  mux5D2;
wire  mux6D2;
wire  mux7D2;
wire  mux8D2;
wire  mux9D2;
wire  mux10D2;
wire  mux11D2;

wire  mux1D3;
wire  mux2D3;
wire  mux3D3;
wire  mux4D3;
wire  mux5D3;
wire  mux6D3;
wire  mux7D3;
wire  mux8D3;
wire  mux9D3;
wire  mux10D3;
wire  mux11D3;

wire  Miss_i;
wire  stateDhitSel_i;

  assign Miss = Miss_i;
  assign stateDhitSel = stateDhitSel_i;

   // Replacing instantiation: GTECH_NOT I37
   assign Hit = ~(Miss_i);

   // Replacing instantiation: GTECH_NOT I35
   wire WordSelect_NEG;
   assign WordSelect_NEG = ~(WordSelect);

  // Removed the module "dp_logMMU_StdeDhitsel"
  assign stateDhitSel_i = ~( writeShadow & isAbort_NEG );

  // Removed the module "dp_muxMMU_StateDhit"
  assign comp1_11[0:10] = ~(({11{WordSelect_NEG}} & {11{~(stateDhitSel_i)}}) |
                            (comp1_11_NEG[0:10] & {11{stateDhitSel_i}} ));

  // Removed the module "dp_muxMMU_isCompMux"
  assign comp1_11_NEG[0:10]  = ((~({isEA[0],isEA[2],isEA[4],isEA[6],isEA[8],isEA[10],isEA[12], 
                             isEA[14],isEA[16],isEA[18],isEA[20]}) & ~({isEA[1],isEA[3], 
                             isEA[5],isEA[7],isEA[9],isEA[11],isEA[13],isEA[15],isEA[17], 
                             isEA[19],isEA[21]}) & {mux1D0,mux2D0,mux3D0,mux4D0,mux5D0, 
                             mux6D0,mux7D0,mux8D0,mux9D0,mux10D0,mux11D0}) | (~({isEA[0], 
                             isEA[2],isEA[4],isEA[6],isEA[8],isEA[10],isEA[12],isEA[14], 
                             isEA[16],isEA[18],isEA[20]}) & ({isEA[1],isEA[3],isEA[5],isEA[7], 
                             isEA[9],isEA[11],isEA[13],isEA[15],isEA[17],isEA[19],isEA[21]}) &
                             {mux1D1,mux2D1,mux3D1,mux4D1,mux5D1,mux6D1,mux7D1,mux8D1,
                             mux9D1,mux10D1,mux11D1}) | ({isEA[0],isEA[2],isEA[4],isEA[6],
                             isEA[8],isEA[10],isEA[12],isEA[14],isEA[16],isEA[18],isEA[20]} &
                             ~({isEA[1],isEA[3],isEA[5],isEA[7],isEA[9],isEA[11],isEA[13],
                             isEA[15],isEA[17],isEA[19],isEA[21]}) & {mux1D2,mux2D2,mux3D2,
                             mux4D2,mux5D2,mux6D2,mux7D2,mux8D2,mux9D2,mux10D2,mux11D2}) |
                             ({isEA[0],isEA[2],isEA[4],isEA[6],isEA[8],isEA[10],isEA[12],
                             isEA[14],isEA[16],isEA[18],isEA[20]} & {isEA[1],isEA[3],isEA[5],
                             isEA[7], isEA[9], isEA[11], isEA[13], isEA[15], isEA[17],isEA[19],
                             isEA[21]} & {mux1D3,mux2D3,mux3D3,mux4D3,mux5D3,mux6D3,mux7D3,
                             mux8D3,mux9D3,mux10D3,mux11D3}));

   // Replacing instantiation: GTECH_NAND3 I30
   wire validComp_NEG;
   wire comp11L2;
   assign validComp_NEG = ~( comp11L2 & Valid & msrIrL2 );

   // Replacing instantiation: GTECH_NOR3 I23
   wire comp1_2;
   wire comp5_6_NEG;
   wire comp1_6;
   wire comp3_4_NEG;
   assign comp1_6 = ~( comp1_2 | comp3_4_NEG | comp5_6_NEG );

   // Replacing instantiation: GTECH_NOR3 I24
   wire comp7_8_NEG;
   wire comp7_11;
   wire comp9_10_NEG;
   assign comp7_11 = ~( comp7_8_NEG | comp9_10_NEG | validComp_NEG );

   // Replacing instantiation: GTECH_NAND2 I20
   wire comp9L2;
   wire comp10L2;
   assign comp9_10_NEG = ~( comp9L2 & comp10L2 );

   // Replacing instantiation: GTECH_NAND2 I19
   wire comp7L2;
   wire comp8L2;
   assign comp7_8_NEG = ~( comp7L2 & comp8L2 );

   // Replacing instantiation: GTECH_NAND2 I17
   wire comp3L2;
   wire comp4L2;
   assign comp3_4_NEG = ~( comp3L2 & comp4L2 );

   // Replacing instantiation: GTECH_NAND2 I21
   assign Miss_i = ~( comp1_6 & comp7_11 );

   // Replacing instantiation: GTECH_NAND2 I16
   wire comp1L2;
   wire comp2L2;
   assign comp1_2 = ~( comp1L2 & comp2L2 );

   // Replacing instantiation: GTECH_NAND2 I18
   wire comp5L2;
   wire comp6L2;
   assign comp5_6_NEG = ~( comp5L2 & comp6L2 );

  // Removed the module "dp_logMMU_isCompNand" 4 instances
  assign {mux1D0,mux2D0,mux3D0,mux4D0} = ~( {EPN_NEG[0],EPN_NEG[2],EPN_NEG[4],EPN_NEG[6]} &
                                               {EPN_NEG[1],EPN_NEG[3],EPN_NEG[5],EPN_NEG[7]} );
  assign {mux1D1,mux2D1,mux3D1,mux4D1} = ~( {EPN_NEG[0],EPN_NEG[2],EPN_NEG[4],EPN_NEG[6]} &
                                               {EPN[1],EPN[3],EPN[5],EPN[7]} );
  assign {mux1D3,mux2D3,mux3D3,mux4D3} = ~( {EPN[0],EPN[2],EPN[4],EPN[6]} & {EPN[1],EPN[3],
                                                EPN[5],EPN[7]} );
  assign {mux1D2,mux2D2,mux3D2,mux4D2} = ~( {EPN[0],EPN[2],EPN[4],EPN[6]} & {EPN_NEG[1],
                                                EPN_NEG[3],EPN_NEG[5],EPN_NEG[7]} );

  // Removed the module "dp_regMMU_isComp0_11"
  always @(comp1L2 or comp2L2 or comp3L2 or comp4L2 or comp5L2 or comp6L2 or comp7L2 or 
           comp8L2 or comp9L2 or comp10L2 or comp11L2 or comp1_11 or CompE2)    
    begin        
      casez(CompE2)        
        1'b0: isComp0_11_DataIn = {comp1L2,comp2L2,comp3L2,comp4L2,comp5L2,comp6L2,
                               comp7L2,comp8L2,comp9L2,comp10L2,comp11L2};   
        1'b1: isComp0_11_DataIn = comp1_11[0:10];   
        default: isComp0_11_DataIn = 11'bx;  
      endcase        
    end        

  always @(posedge CB)      
    begin        
      isComp0_11_reg <= isComp0_11_DataIn;     
    end        

  assign {comp1L2,comp2L2,comp3L2,comp4L2,comp5L2,comp6L2,comp7L2,comp8L2,comp9L2,
                             comp10L2,comp11L2} = isComp0_11_reg;

  // Removed the module "dp_logMMU_isCompgetMuxData" 4 instances
  assign {mux5D3,mux6D3,mux7D3,mux8D3,mux9D3,mux10D3,mux11D3} = ~( ({EPN[8], EPN[10],
                         EPN[12],EPN[14],EPN[16],EPN[18],EPN[20]} & {EPN[9], EPN[11], EPN[13],
                         EPN[15],EPN[17],EPN[19],EPN[21]}) | Size[0:6] );

  assign {mux5D2,mux6D2,mux7D2,mux8D2,mux9D2,mux10D2,mux11D2} = ~( ({EPN[8],EPN[10],
                         EPN[12],EPN[14],EPN[16],EPN[18],EPN[20]} & {EPN_NEG[9],EPN_NEG[11],
                         EPN_NEG[13],EPN_NEG[15],EPN_NEG[17],EPN_NEG[19],EPN_NEG[21]}) |
                         Size[0:6] );

  assign {mux5D1,mux6D1,mux7D1,mux8D1,mux9D1,mux10D1,mux11D1} = ~( ({EPN_NEG[8],EPN_NEG[10],
                         EPN_NEG[12],EPN_NEG[14],EPN_NEG[16],EPN_NEG[18],EPN_NEG[20]} & {EPN[9],
                         EPN[11],EPN[13],EPN[15],EPN[17],EPN[19],EPN[21]}) | Size[0:6] );

  assign {mux5D0,mux6D0,mux7D0,mux8D0,mux9D0,mux10D0,mux11D0} = ~( ({EPN_NEG[8],EPN_NEG[10],
                         EPN_NEG[12],EPN_NEG[14],EPN_NEG[16],EPN_NEG[18],EPN_NEG[20]} &
                         {EPN_NEG[9],EPN_NEG[11],EPN_NEG[13],EPN_NEG[15],EPN_NEG[17],EPN_NEG[19],
                         EPN_NEG[21]}) | Size[0:6] );

endmodule
