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

// change history
// 08-03-01     JRS     1799    Changing parity array bit enables to use the dataA and dataB cycle signals
//                              May be a timing problem, but should be functionally correct
//                              Could also change the parity array cycle to VDD, but might burn more power and
//                                probably don't need to for timing.
// 08-06-01     JRS             Change tag parity error into output selection mux to use tag B when should
// 08-06-01     JRS     1807    Changing both PLB data parity generations to invert the parity bit because all input data is
//                                stored in inverting fill regs, including the parity bits
//                              Since have 33 bits will have an extra inversion that causes the parity to always be wrong
// 08-08-01     JRS     1817    Changing the PLB fill regs and write buffers back to 32 bits, seperating the parity bits
//                              into their own 1-bit registers so can place them close to parity array
// 08-10-01     JRS     1824    Fixing parity gen block instance names to be consistent with other names
// 8-27-01      JRS     1858    re-order dp_regICU_tagL1WBLow register bits so new ones are first, done to pass formality
// 9-6-01       JRS     1869    Pulling dummy scan chain nets and cds_globals for formality

module p405s_icu_ram_data_flow_16K (
                ICU_isBus,
                ICU_parityErrE,
                ICU_parityErrO,
                ICU_tagParityErr,
                compareA,
                compareA_NEG,
                compareB,
                compareB_NEG,
                dsCompA,
                dsCompB,
                icReadData,
                icuCacheSize,
                lruOut,
                vaOut,
                vbOut,
                CB,
                ICU_paritySel,
                ICU_baSel,
                ICU_tagDataSel,
                JTG_iCacheWr,
                JTG_inst,
                Lx27Sel,
                Lx28Sel,
                Lx29Sel,
                MMU_isCacheable,
                MMU_isRA,
                OCM_isData,
                PLB_icuDBus,
                VaVbRdSel,
                VaVbWrE1,
                cycleDataRegAIn,
                cycleDataRegBIn,
                cycleTagRegIn,
                cycleParityRegIn,
                dataRdWrRegIn,
                df_dataCc,
                df_jtagIsEa_NEG,
                df_lruRdCcInNEG,
                df_lruWrCcIn,
                df_rars,
                df_rarsTLE,
                df_tagVccRegIn,
                dsRD1cycle,
                fillAE2,
                fillBE2,
                fillWr0L2,
                isBusSel,
                lruRdCcE1,
                newLruBitIn,
                newVaBitIn,
                newVbBitIn,
                rdStateL2,
                rdar,
                scL2,
                tagBWE1,
                tagRdWrRegIn,
                vaOutL2,
                vbOutL2,
                wbHighE2,
                wbLowE2,
                wbTagE1,
                wrATagNotB,
                wrFlashIn,
                wrLruIn,
                wrVaIn,
                wrVbIn,
                ICU_CCR1ICTE,
                ICU_CCR1ICDE,
                resetMemBist,
                icu_bist_debug_si,
                icu_bist_debug_so,
                icu_bist_debug_en,
                icu_bist_mode_reg_in,
                icu_bist_mode_reg_out,
                icu_bist_parallel_dr,
                icu_bist_mode_reg_si,
                icu_bist_mode_reg_so,
                icu_bist_shift_dr,
                icu_bist_mbrun
               );

output  compareA;
output  compareA_NEG;
output  compareB;
output  compareB_NEG;
output  dsCompA;
output  dsCompB;
output  lruOut;
output  vaOut;
output  vbOut;

input  ICU_paritySel;
input  ICU_baSel;
input  ICU_tagDataSel;
input  JTG_iCacheWr;
input  Lx27Sel;
input  Lx28Sel;
input  Lx29Sel;
input  MMU_isCacheable;
input  VaVbWrE1;
input  cycleDataRegAIn;
input  cycleDataRegBIn;
input  cycleTagRegIn;
input  cycleParityRegIn;
input  dataRdWrRegIn;
input  df_rarsTLE;
input  dsRD1cycle;
input  fillWr0L2;
input  lruRdCcE1;
input  newLruBitIn;
input  newVaBitIn;
input  newVbBitIn;
input  rdStateL2;
input  scL2;
input  tagBWE1;
input  tagRdWrRegIn;
input  vaOutL2;
input  vbOutL2;
input  wbLowE2;
input  wbTagE1;
input  wrATagNotB;
input  wrFlashIn;
input  wrVaIn;
input  wrVbIn;
input  ICU_CCR1ICTE;
input  ICU_CCR1ICDE;

output [0:63]  ICU_isBus;
output [0:2]   icuCacheSize;
output [0:31]  icReadData;

output  ICU_parityErrE;    // parity error for fetch on high-order word ICU_isBus[0:31]
output  ICU_parityErrO;    // parity error for fetch on low-order word ICU_isBus[32:63]
output  ICU_tagParityErr;  // parity error for fetch on tag hit

input [18:27]  df_dataCc;
input [0:21]   df_rars;
input [0:63]   OCM_isData;
input [0:21]   MMU_isRA;
input [0:3]    wbHighE2;
input [0:63]   PLB_icuDBus;
input [0:1]    isBusSel;
input [18:26]  df_tagVccRegIn;
input [0:31]   JTG_inst;
input [18:26]  df_jtagIsEa_NEG;
input [18:26]  df_lruRdCcInNEG;
input [18:26]  df_lruWrCcIn;
input [0:7]    fillAE2;
input [0:7]    fillBE2;
input          CB;
input [0:29]   rdar;
input [0:2]    VaVbRdSel;
input [0:2]    wrLruIn;

input          resetMemBist;  // sync reset for icu mbist

// BIST IO

input         icu_bist_mbrun;
input  [3:0]  icu_bist_debug_si;
input  [3:0]  icu_bist_debug_en;
output [3:0]  icu_bist_debug_so;

input   icu_bist_shift_dr;
input   icu_bist_mode_reg_si;
output  icu_bist_mode_reg_so;

input          icu_bist_parallel_dr;
input  [18:0]  icu_bist_mode_reg_in;
output [18:0]  icu_bist_mode_reg_out;


// Buses in the design

reg   [0:9]      dataIndexA;
reg   [0:127]    dataA;
reg   [0:9]      dataIndexB;
wire  [0:127]    dataAout;
wire  [0:127]    dataBout;
reg   [0:63]     byPassData;
reg   [0:127]    dataB;
wire  [0:63]     B_data;
wire  [0:63]     A_data;
wire  [0:31]     dataBicRead;
wire  [0:31]     dataAicRead;
reg   [0:31]     read4;
reg   [0:31]     read3;
wire  [0:8]      tagIndex;
wire  [0:21]     isRA_NEG;
wire  [0:21]     rdar_NEG;
wire  [0:8]      vaWrIndex;
wire  [0:8]      lruWrIndex;
reg   [0:8]      vbRdIndex;
reg   [0:8]      vaRdIndex;
wire  [0:21]     tagBOut;
wire  [0:8]      vbWrIndex;
reg   [0:21]     tagDataIn;
reg   [0:6]      icu_float_tagL2ByteLow;
reg   [0:15]     icu_float_tagL2ByteHi;
reg   [0:22]     wrTagANotBL2;
wire  [0:9]      lrufb;
wire  [0:21]     tagAOut;
reg   [0:15]     icu_float_tagL2WBHi;
reg   [0:6]      icu_float_tagL2WBLow;
wire  [0:21]     tagAout;
wire  [0:8]      lruRdIndex;
wire  [0:255]    fillA;
reg   [128:159]  ramWbA4;
reg   [160:191]  ramWbA5;
reg   [224:255]  ramWbA7;
reg   [192:223]  ramWbA6;
wire  [0:127]    ramWbA;
wire  [0:3]      wbHighBE2;
wire  [0:3]      wbHighAE2;
wire  [0:3]      wbInv3;
wire  [0:3]      wbInv1;
reg   [128:159]  ramWbB4;
reg   [160:191]  ramWbB5;
reg   [192:223]  ramWbB6;
reg   [224:255]  ramWbB7;
wire  [0:255]    fillB;
wire  [0:127]    ramWbB;
wire  [0:63]     plbDBus;
reg   [18:26]    VaVbFeedBack;
wire  [0:9]      lruFeedBack_NEG;
wire  [27:31]    JTG_inst_NEG;
wire  [18:26]    df_lruWrCcIn_NEG;
wire  [0:255]    muxB;
wire  [0:255]    muxA;
wire  [0:21]     tagBout;
wire  [0:21]     tagData;


// parity wire declarations     7-9-01 JRS

wire    plbParityBitHi;         // parity for plb data [0:31]
wire    plbParityBitLo;         // parity for plb data [32:63]

wire    fillAParity_0;          // parity for word 0 in A fill reg
wire    fillAParity_1;          // parity for word 1 in A fill reg
wire    fillAParity_2;          // parity for word 2 in A fill reg
wire    fillAParity_3;          // parity for word 3 in A fill reg
wire    fillAParity_4;          // parity for word 4 in A fill reg
wire    fillAParity_5;          // parity for word 5 in A fill reg
wire    fillAParity_6;          // parity for word 6 in A fill reg
wire    fillAParity_7;          // parity for word 7 in A fill reg

wire    fillBParity_0;          // parity for word 0 in B fill reg
wire    fillBParity_1;          // parity for word 1 in B fill reg
wire    fillBParity_2;          // parity for word 2 in B fill reg
wire    fillBParity_3;          // parity for word 3 in B fill reg
wire    fillBParity_4;          // parity for word 4 in B fill reg
wire    fillBParity_5;          // parity for word 5 in B fill reg
wire    fillBParity_6;          // parity for word 6 in B fill reg
wire    fillBParity_7;          // parity for word 7 in B fill reg

wire    ramWbA0Parity;          // selected parity for word 0/4 to go into A array
wire    ramWbA1Parity;          // selected parity for word 1/5 to go into A array
wire    ramWbA2Parity;          // selected parity for word 2/6 to go into A array
wire    ramWbA3Parity;          // selected parity for word 3/7 to go into A array

wire    ramWbB0Parity;          // selected parity for word 0/4 to go into B array
wire    ramWbB1Parity;          // selected parity for word 1/5 to go into B array
wire    ramWbB2Parity;          // selected parity for word 2/6 to go into B array
wire    ramWbB3Parity;          // selected parity for word 3/7 to go into B array

reg     ramWbA4Parity;          // parity for word 4 in A wb reg
reg     ramWbA5Parity;          // parity for word 5 in A wb reg
reg     ramWbA6Parity;          // parity for word 6 in A wb reg
reg     ramWbA7Parity;          // parity for word 7 in A wb reg

reg     ramWbB4Parity;          // parity for word 4 in B wb reg
reg     ramWbB5Parity;          // parity for word 5 in B wb reg
reg     ramWbB6Parity;          // parity for word 6 in B wb reg
reg     ramWbB7Parity;          // parity for word 7 in B wb reg

reg     dataA0Parity;           // latched parity bit for word 0 going into A array
reg     dataA1Parity;           // latched parity bit for word 1 going into A array
reg     dataA2Parity;           // latched parity bit for word 2 going into A array
reg     dataA3Parity;           // latched parity bit for word 3 going into A array

reg     dataB0Parity;           // latched parity bit for word 0 going into B array
reg     dataB1Parity;           // latched parity bit for word 1 going into B array
reg     dataB2Parity;           // latched parity bit for word 2 going into B array
reg     dataB3Parity;           // latched parity bit for word 3 going into B array

wire    JTG_instParity;         // parity for JTAG input instruction
wire    JTG_instParitySEI;      // parity for JTAG input instruction with soft error injection

wire    A_dataEvenParity;       // parity out from A array for selected high-order word [0:31]
wire    A_dataOddParity;        // parity out from A array for selected low-order word [32:63]

wire    B_dataEvenParity;       // parity out from B array for selected high-order word [0:31]
wire    B_dataOddParity;        // parity out from B array for selected low-order word [32:63]

wire    A_dataEvenParityError;  // indicates parity error for high-order word [0:31] of A array
wire    A_dataOddParityError;   // indicates parity error for low-order word [32:63] of A array

wire    B_dataEvenParityError;  // indicates parity error for high-order word [0:31] of B array
wire    B_dataOddParityError;   // indicates parity error for low-order word [32:63] of B array

wire    tagDataParityBit;       // parity bit for tag data into tag wb

wire    tagAParityError;        // parity error for A array tag
wire    tagBParityError;        // parity error for B array tag

wire    cycleParityRamL2;       // E2 clock enable for parity array splitter, from L1 of 
                                // cycleParityRegIn input

reg     readWrParityL2;         // latched read/write signal for parity array, uses same 
                                // input read/write signal as data arrays

reg     icu_float_dataParityrdWr;    // unconnected net used for parity read/write 
                                     // register's L2 output

wire wbInv5;
wire wbInv6;
wire rdStateL2_NEG;
wire vaOut1;
wire vbOut1;

wire newVaBitIn_NEG;
wire newVbBitIn_NEG;
wire cycleDataRamAL2;
wire cycleDataRamBL2;
wire tagcycle;
wire symNet292;
wire wrATagNotBIn;
wire wbLowB57;
wire wbLowB46;

wire newLruBitIn_NEG;
wire wbLowA57;
wire wbLowA46;
wire vbQual;
wire vaQual;

reg [0:8]  vARdCcDup_mux;
reg [0:9]  lruWrCcDup_reg;
reg [0:9]  lruWrCcDup_mux;
reg [0:9]  vbWrCc_reg;
reg [0:9]  vbWrCc_mux;
reg [0:8]  vBRdCc_mux;  
reg [0:9]  vaWrCc_mux;
reg [0:9]  vaWrCc_reg;
reg [0:8]  vARdCc_mux;  
reg [0:8]  lruRdCc_reg;  
reg [0:9]  lruWrCc_mux;  
reg [0:9]  lruWrCc_reg;  
reg [0:31] RamWbB3_mux;  
reg [0:31] RamWbB2_mux;  
reg [0:31] RamWbB1_mux;  
reg [0:31] RamWbB0_mux;  
reg        parityWbB3_mux;  
reg        parityWbB2_mux;  
reg        parityWbB1_mux;  
reg        parityWbB0_mux;  
reg [0:31] RamWbA3_mux;
reg [0:31] RamWbA2_mux;
reg [0:31] RamWbA1_mux;
reg [0:31] RamWbA0_mux;
reg        parityWbA3_mux;  
reg        parityWbA2_mux;  
reg        parityWbA1_mux;  
reg        parityWbA0_mux;  

reg [0:31] RamFillB7_reg;  
reg [0:31] RamFillB6_reg;  
reg [0:31] RamFillB5_reg;  
reg [0:31] RamFillB4_reg;  
reg [0:31] RamFillB3_reg;  
reg [0:31] RamFillB2_reg;  
reg [0:31] RamFillB1_reg;  
reg [0:31] RamFillB0_reg;  
reg [0:31] RamFillA7_reg;  
reg [0:31] RamFillA6_reg;  
reg [0:31] RamFillA5_reg;  
reg [0:31] RamFillA4_reg;  
reg [0:31] RamFillA3_reg;  
reg [0:31] RamFillA2_reg;  
reg [0:31] RamFillA1_reg;  
reg [0:31] RamFillA0_reg;  
reg        parityFillB7_reg;  
reg        parityFillB6_reg;  
reg        parityFillB5_reg;  
reg        parityFillB4_reg;  
reg        parityFillB3_reg;  
reg        parityFillB2_reg;  
reg        parityFillB1_reg;  
reg        parityFillB0_reg;  
reg        parityFillA7_reg;  
reg        parityFillA6_reg;  
reg        parityFillA5_reg;  
reg        parityFillA4_reg;  
reg        parityFillA3_reg;  
reg        parityFillA2_reg;  
reg        parityFillA1_reg;  
reg        parityFillA0_reg;  

reg        icu_float_tagL2RdWr;
reg        tagRdWrL1;
reg        tagDataInParityBit;
wire       dsA;
wire       dsB;
wire       tagAOutParityBit;
wire       tagBOutParityBit;
wire       dataAout0Parity;
wire       dataAout1Parity;
wire       dataAout2Parity;
wire       dataAout3Parity;
wire       dataBout0Parity;
wire       dataBout1Parity;
wire       dataBout2Parity;
wire       dataBout3Parity;
reg        readWrAL2;
reg        readWrBL2;
reg        icu_float_dataArdWr;
reg        icu_floatDataBrdWr;
reg        wrFlash;
reg        vaWrCycle;
reg        vbWrCycle;
reg        lruWrCycle;
reg        ICU_parityErrO;
reg        ICU_parityErrE;
reg        ICU_tagParityErr;

reg [0:63]  ICU_isBus;

wire       newVaBit;
wire       newVbBit;
wire       newLruBit;

// BIST wires and regs

wire          icu_bist_mode;
wire          bist_ce_n_m0;
wire          bist_we_n_m0;
wire [8:0]    bist_addr_m0;
wire [127:0]  bist_wr_data_m0;
wire [127:0]  bist_rd_data_m0;
wire          bist_ce_n_m1;
wire          bist_we_n_m1;
wire [8:0]    bist_addr_m1;
wire [127:0]  bist_wr_data_m1;
wire [127:0]  bist_rd_data_m1;
wire          bist_ce_n_m2;
wire          bist_we_n_m2;
wire [7:0]    bist_addr_m2;
wire [45:0]   bist_wr_data_m2;
wire [45:0]   bist_rd_data_m2;
wire          bist_ce_n_m3;
wire          bist_we_n_m3;
wire [8:0]    bist_addr_m3;
wire [7:0]    bist_wr_data_m3;
wire [7:0]    bist_rd_data_m3;
wire [8:0]    cap_mem_addr_m0;
wire [127:0]  cap_mem_wr_data_m0;
wire          cap_mem_we_m0;
wire [8:0]    cap_mem_addr_m1;
wire [127:0]  cap_mem_wr_data_m1;
wire          cap_mem_we_m1;
wire [7:0]    cap_mem_addr_m2;
wire [45:0]   cap_mem_wr_data_m2;
wire          cap_mem_we_m2;
wire [8:0]    cap_mem_addr_m3;
wire [7:0]    cap_mem_wr_data_m3;
wire          cap_mem_we_m3;


// Can't read from output ports

wire  compareA_i;
wire  compareB_i;
reg   dsCompA_i;
reg   dsCompB_i;
wire  lruOut_i;
wire  vaOut_i;
wire  vbOut_i;

assign compareA = compareA_i;
assign compareB = compareB_i;
assign dsCompA = dsCompA_i;
assign dsCompB = dsCompB_i;
assign lruOut = lruOut_i;
assign vaOut = vaOut_i;
assign vbOut = vbOut_i;

// Address regs

// Removed the module "dp_regICU_AddrRamB"
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)
   begin        
     dataIndexB[0:9] <= df_dataCc[18:27];      
   end        
`else        
   always @(CB or df_dataCc or dataIndexB)      
    begin          
    casez(~CB)   
     1'b0: ;        
     1'b1: dataIndexB[0:9] = df_dataCc[18:27];     
      default: dataIndexB[0:9] = dataIndexB[0:9] ;
    endcase        
   end             
`endif

// Removed the module "dp_regICU_AddrRamA"
`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin        
     dataIndexA[0:9] <= df_dataCc[18:27];      
   end        
`else        
   always @(CB or df_dataCc)      
    begin        
    casez(~CB)   
     1'b0: ;        
     1'b1: dataIndexA[0:9] = df_dataCc[18:27];     
      default: dataIndexA[0:9] = dataIndexA[0:9] ;
    endcase
   end     
`endif

assign tagIndex[0:8] = df_tagVccRegIn[18:26];

assign lruFeedBack_NEG[0:9] = ~(lrufb[0:9]);
assign {newLruBitIn_NEG,newVaBitIn_NEG, newVbBitIn_NEG} = ~({newLruBitIn, newVaBitIn, 
                                                             newVbBitIn});
assign {JTG_inst_NEG[27],JTG_inst_NEG[31]} = ~({JTG_inst[27],JTG_inst[31]});
assign df_lruWrCcIn_NEG[18:26] = ~(df_lruWrCcIn[18:26]);


// TRC removed the latches and added assign statements

assign cycleDataRamAL2 = cycleDataRegAIn;
assign cycleDataRamBL2 = cycleDataRegBIn;
assign tagcycle = cycleTagRegIn;
assign cycleParityRamL2 = cycleParityRegIn;

assign symNet292 = ~(ICU_baSel);

assign wrATagNotBIn = (wrATagNotB & ~(JTG_iCacheWr)) | (symNet292 & JTG_iCacheWr);
assign tagData[0:21] = (df_rars[0:21] & {(22){~(JTG_iCacheWr)}}) | 
                       (JTG_inst[0:21] & {(22){JTG_iCacheWr}});

assign wbLowB57 = ~(wbInv6);
assign wbLowB46 = ~(wbInv6);
assign wbLowA57 = ~(wbInv5);
assign wbLowA46 = ~(wbInv5);
assign wbInv6 = ~(wbLowE2);
assign wbInv5 = ~(wbLowE2);
assign wbHighBE2[0:3] = ~(wbInv3[0:3]);
assign wbInv3[0:3] = ~(wbHighE2[0:3]);
assign wbHighAE2[0:3] = ~(wbInv1[0:3]);
assign wbInv1[0:3] = ~(wbHighE2[0:3]);

// The sram addr/data/control bit registers

// Removed the module "dp_regICU_vARdCcDup"
   always @(VaVbFeedBack or df_tagVccRegIn or VaVbRdSel)    
    begin        
    casez(VaVbRdSel[1])        
     1'b0: vARdCcDup_mux = VaVbFeedBack[18:26];   
     1'b1: vARdCcDup_mux = df_tagVccRegIn[18:26];   
      default: vARdCcDup_mux = 9'bx;  
    endcase        
   end        

   always @(posedge CB)      
    begin        
     VaVbFeedBack[18:26] <= vARdCcDup_mux;     
   end        

// Removed the module "dp_regICU_tagL1RdWr"
   always @(posedge CB)      
    begin        
     icu_float_tagL2RdWr <= icu_float_tagL2RdWr;        
   end        

`ifdef CBS         // for cycle-based simulators (MESA) 
   // L1 Output modeled as negitive edge FF    
   always @(negedge CB)      
    begin        
      tagRdWrL1 <= tagRdWrRegIn;        
   end        
`else        
   always @(CB or tagRdWrRegIn or tagRdWrL1)     
    begin
    casez(~CB)   
     1'b0: ;       
     1'b1: tagRdWrL1 = tagRdWrRegIn;
      default: tagRdWrL1 = tagRdWrL1;
    endcase        
   end             
`endif

// Removed the module "dp_regICU_tagL1ByteLow"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
    casez(tagBWE1)
     1'b0: {wrTagANotBL2[22],wrTagANotBL2[16:21]} <= {wrTagANotBL2[22],wrTagANotBL2[16:21]};
     1'b1: {wrTagANotBL2[22],wrTagANotBL2[16:21]} <= {(7){wrATagNotBIn}};
      default: {wrTagANotBL2[22],wrTagANotBL2[16:21]} <= 7'bx;
    endcase
   end
`else
   always @(CB or wrATagNotBIn or tagBWE1)
    begin
    casez(~CB & tagBWE1)
     1'b0: ;
     1'b1: {wrTagANotBL2[22],wrTagANotBL2[16:21]} = {(7){wrATagNotBIn}};
      default: {wrTagANotBL2[22],wrTagANotBL2[16:21]} = {wrTagANotBL2[22],
                                                         wrTagANotBL2[16:21]} ;
    endcase
   end
`endif

// Removed the module "dp_regICU_tagL1ByteHi"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
    casez(tagBWE1)
     1'b0: wrTagANotBL2[0:15] <= wrTagANotBL2[0:15];
     1'b1: wrTagANotBL2[0:15] <= {16{wrATagNotBIn}};
      default: wrTagANotBL2[0:15] <= 16'bx;
    endcase
   end
`else
   always @(CB or wrATagNotBIn or tagBWE1)
    begin
    casez(~CB & tagBWE1)
     1'b0: ;
     1'b1: wrTagANotBL2[0:15] = {16{wrATagNotBIn}};
      default: wrTagANotBL2[0:15] = wrTagANotBL2[0:15] ;
    endcase
   end
`endif

// Removed the module "dp_regICU_tagL1WBHi"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
    casez(wbTagE1)
     1'b0: tagDataIn[0:15] <= tagDataIn[0:15];
     1'b1: tagDataIn[0:15] <= tagData[0:15];
      default: tagDataIn[0:15] <= 16'bx;
    endcase
   end
`else
   always @(CB or tagData or wbTagE1)
    begin
    casez(~CB & wbTagE1)
     1'b0: ;
     1'b1: tagDataIn[0:15] = tagData[0:15];
      default: tagDataIn[0:15] = tagDataIn[0:15] ;
    endcase
   end
`endif

// Removed the module "dp_regICU_tagL1WBLow"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
    casez(wbTagE1)
     1'b0: {tagDataInParityBit,tagDataIn[16:21]} <= {tagDataInParityBit,tagDataIn[16:21]};
     1'b1: {tagDataInParityBit,tagDataIn[16:21]} <= {tagDataParityBit,tagData[16:21]};
      default: {tagDataInParityBit,tagDataIn[16:21]} <= 7'bx;
    endcase
   end
`else
   always @(CB or tagDataParityBit or tagData or wbTagE1 or
            tagDataInParityBit or tagDataIn)
    begin
    casez(~CB & wbTagE1)
     1'b0: ;
     1'b1: {tagDataInParityBit,tagDataIn[16:21]} = {tagDataParityBit, 
                                                    tagData[16:21]};
      default: {tagDataInParityBit,tagDataIn[16:21]} = {tagDataInParityBit,
                                                        tagDataIn[16:21]} ;
    endcase
   end
`endif

// Removed the module "dp_regICU_lruWrCcDup"
   always @(lruFeedBack_NEG or df_lruWrCcIn_NEG or newLruBitIn_NEG or 
            df_jtagIsEa_NEG or JTG_inst_NEG or wrLruIn or JTG_iCacheWr)      
    begin        
    casez({wrLruIn[0], JTG_iCacheWr})        
     2'b00: lruWrCcDup_mux = lruFeedBack_NEG[0:9];  
     2'b01: lruWrCcDup_mux = {(10){1'b0}};
     2'b10: lruWrCcDup_mux = {df_lruWrCcIn_NEG[18:26], newLruBitIn_NEG};  
     2'b11: lruWrCcDup_mux = {df_jtagIsEa_NEG[18:26], JTG_inst_NEG[31]};  
      default: lruWrCcDup_mux = 10'bx;  
    endcase    
   end

   always @(posedge CB)
    begin
     lruWrCcDup_reg <= lruWrCcDup_mux;
   end

   assign lrufb[0:9] = ~(lruWrCcDup_reg);

// Removed the module "dp_regICU_dsComp"
   always @(posedge CB)      
    begin        
    if (dsRD1cycle)        
      {dsCompA_i, dsCompB_i} <= {dsA, dsB};        
   end        

assign vbQual = (rdStateL2 & vbOut1) | (rdStateL2_NEG & vbOutL2);
assign vaQual = (rdStateL2 & vaOut1) | (rdStateL2_NEG & vaOutL2);

assign plbDBus[32:63] = PLB_icuDBus[32:63];
assign plbDBus[0:31] = PLB_icuDBus[0:31];
assign vbOut_i = vbOut1;
assign vaOut_i = vaOut1;

assign rdStateL2_NEG = ~(rdStateL2);
assign rdar_NEG[0:21] = ~(rdar[0:21]);
assign isRA_NEG[0:21] = ~(MMU_isRA[0:21]);

assign tagBout[0:21] = tagBOut[0:21];
assign tagAout[0:21] = tagAOut[0:21];

// Removed the module "icu_isCompareB"
   assign compareB_i = (vbQual && MMU_isCacheable) ? ((tagBOut[0:21] == MMU_isRA[0:21]) ? 
                                                                  1'b1 : 1'b0) : 1'b0 ;
   assign compareB_NEG = ~compareB_i;

// Removed the module "icu_isCompareA"
   assign compareA_i = (vaQual && MMU_isCacheable) ? ((tagAOut[0:21] == MMU_isRA[0:21]) ? 
                                                                  1'b1 : 1'b0) : 1'b0 ;
   assign compareA_NEG = ~compareA_i;

// Removed the module "icu_newCompareB"
   assign dsB = vbQual ? ((tagBout[0:21] == rdar[0:21]) ? 1'b1 : 1'b0) : 1'b0 ;

// Removed the module "icu_newCompareA"
   assign dsA = vaQual ? ((tagAout[0:21] == rdar[0:21]) ? 1'b1 : 1'b0) : 1'b0 ;

// Leave in hier due to IBM request
p405s_ram_lruVaVb_16K
 lruVaVb_Sch ( 
                   .lruOut       (lruOut_i), 
                   .vaOut        (vaOut1), 
                   .vbOut        (vbOut1), 
                   .CB           (CB),
                   .lruRdIndex   (lruRdIndex[0:8]), 
                   .lruWrCycle   (lruWrCycle), 
                   .lruWrIndex   (lruWrIndex[0:8]), 
                   .newLruBit    (newLruBit), 
                   .newVaBit     (newVaBit), 
                   .newVbBit     (newVbBit), 
                   .vaRdIndex    (vaRdIndex[0:8]), 
                   .vaWrCycle    (vaWrCycle), 
                   .vaWrIndex    (vaWrIndex[0:8]), 
                   .vbRdIndex    (vbRdIndex[0:8]), 
                   .vbWrCycle    (vbWrCycle), 
                   .vbWrIndex    (vbWrIndex[0:8]),
                   .wrFlash      (wrFlash)
                 );

// Removed the module "dp_regICU_vbWrCc"
   always @(df_lruWrCcIn_NEG or newVbBitIn_NEG or df_jtagIsEa_NEG or 
            JTG_inst_NEG or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: vbWrCc_mux = {df_lruWrCcIn_NEG[18:26], newVbBitIn_NEG};   
     1'b1: vbWrCc_mux = {df_jtagIsEa_NEG[18:26], JTG_inst_NEG[27]};   
      default: vbWrCc_mux = 10'bx;  
    endcase        
   end        

   always @(posedge CB)      
    begin        
    if (VaVbWrE1)
      vbWrCc_reg <= vbWrCc_mux;
   end

  assign {vbWrIndex[0:8], newVbBit} = ~(vbWrCc_reg);

// Removed the module "dp_regICU_vBRdCc"
   always @(VaVbFeedBack or df_tagVccRegIn or VaVbRdSel)    
    begin        
    casez(VaVbRdSel[0])        
     1'b0: vBRdCc_mux = VaVbFeedBack[18:26];   
     1'b1: vBRdCc_mux = df_tagVccRegIn[18:26];   
      default: vBRdCc_mux = 9'bx;  
    endcase        
   end        

   always @(posedge CB)      
    begin        
     vbRdIndex[0:8] <= vBRdCc_mux;     
   end        

// Removed the module "dp_regICU_vaWrCc"
   always @(df_lruWrCcIn_NEG or newVaBitIn_NEG or df_jtagIsEa_NEG or 
                                        JTG_inst_NEG or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: vaWrCc_mux = {df_lruWrCcIn_NEG[18:26], newVaBitIn_NEG};   
     1'b1: vaWrCc_mux = {df_jtagIsEa_NEG[18:26], JTG_inst_NEG[27]};   
      default: vaWrCc_mux = 10'bx;  
    endcase        
   end        

   always @(posedge CB)      
    begin        
    if (VaVbWrE1)
      vaWrCc_reg <= vaWrCc_mux;
   end

  assign {vaWrIndex[0:8], newVaBit} = ~(vaWrCc_reg);

// Removed the module "dp_regICU_vARdCc"
   always @(VaVbFeedBack or df_tagVccRegIn or VaVbRdSel)    
    begin        
    casez(VaVbRdSel[2])        
     1'b0: vARdCc_mux = VaVbFeedBack[18:26];   
     1'b1: vARdCc_mux = df_tagVccRegIn[18:26];   
      default: vARdCc_mux = 9'bx;  
    endcase        
   end        

   always @(posedge CB)      
    begin        
     vaRdIndex[0:8] <= vARdCc_mux;     
   end        

// Removed the module "dp_regICU_lruRdCc"
   always @(posedge CB)      
    begin        
    if (lruRdCcE1)        
      lruRdCc_reg <= df_lruRdCcInNEG[18:26];        
   end        

   assign lruRdIndex[0:8] = ~(lruRdCc_reg);

// Removed the module "dp_regICU_lruWrCc"
   always @(lruFeedBack_NEG or df_lruWrCcIn_NEG or newLruBitIn_NEG or 
            df_jtagIsEa_NEG or JTG_inst_NEG or wrLruIn or JTG_iCacheWr)
    begin        
    casez({wrLruIn[1], JTG_iCacheWr})        
     2'b00: lruWrCc_mux = lruFeedBack_NEG[0:9];  
     2'b01: lruWrCc_mux = {(10){1'b0}};  
     2'b10: lruWrCc_mux = {df_lruWrCcIn_NEG[18:26], newLruBitIn_NEG};  
     2'b11: lruWrCc_mux = {df_jtagIsEa_NEG[18:26], JTG_inst_NEG[31]};  
      default: lruWrCc_mux = 10'bx;  
    endcase
   end

   always @(posedge CB)
    begin
     lruWrCc_reg <= lruWrCc_mux;
   end

   assign {lruWrIndex[0:8], newLruBit} = ~(lruWrCc_reg);

// Removed the module "dp_regICU_lruWrCycle"
   always @(posedge CB)      
    begin        
     {wrFlash, vaWrCycle, vbWrCycle, lruWrCycle} <= {wrFlashIn, wrVaIn, wrVbIn, 
                                                                   wrLruIn[2]};      
   end        

// Removed the module "dp_muxICU_dataIcRead5"
   assign icReadData[0:31] = (read3[0:31] & {(32){~(ICU_tagDataSel)}} ) | 
                             (read4[0:31] & {(32){ICU_tagDataSel}} );

// Removed the module "dp_muxICU_dataIcRead4"
   always @(ICU_paritySel or ICU_baSel or tagAout or vaOut_i or lruOut_i or tagBout or 
            vbOut_i or tagAOutParityBit or tagBOutParityBit) 
    begin        
    case({ICU_paritySel, ICU_baSel})        
     2'b00: read4[0:31] = {tagAout[0:21], {(5){1'b0}}, vaOut_i, {(3){1'b0}}, lruOut_i};    
     2'b01: read4[0:31] = {tagBout[0:21], {(5){1'b0}}, vbOut_i, {(3){1'b0}}, lruOut_i};
     2'b10: read4[0:31] = {tagAout[0:21], {(3){1'b0}}, tagAOutParityBit, 1'b0, vaOut_i, 
                          {(3){1'b0}}, lruOut_i};
     2'b11: read4[0:31] = {tagBout[0:21], {(3){1'b0}}, tagBOutParityBit, 1'b0, vbOut_i, 
                          {(3){1'b0}}, lruOut_i};    
      default: read4[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxICU_dataIcRead3"
   always @(ICU_paritySel or ICU_baSel or dataAicRead or dataBicRead or 
            dataAout0Parity or dataAout1Parity or dataAout2Parity or 
            dataAout3Parity or dataBout0Parity or dataBout1Parity or
            dataBout2Parity or dataBout3Parity) 
    begin        
    casex({ICU_paritySel, ICU_baSel})        
     2'b00: read3[0:31] = dataAicRead[0:31];    
     2'b01: read3[0:31] = dataBicRead[0:31];    
     2'b1x: read3[0:31] = {dataAout0Parity, dataAout1Parity, dataAout2Parity, 
                           dataAout3Parity, dataBout0Parity, dataBout1Parity, 
                           dataBout2Parity, dataBout3Parity, {(24){1'b0}}};
      default: read3[0:31] = 32'bx;   
    endcase        
   end        

// Data Muxes
assign dataBicRead[0:31] = (B_data[0:31] & {32{~(Lx29Sel)}} ) | (B_data[32:63] & {32{Lx29Sel}});
assign dataAicRead[0:31] = (A_data[0:31] & {32{~(Lx29Sel)}} ) | (A_data[32:63] & {32{Lx29Sel}});

p405s_icu_ram_tagArray_16K
 tagArray_Sch (
                     .icuCacheSize      (icuCacheSize[0:2]),
                     .tagAOut           (tagAOut[0:21]),
                     .tagAOutParityBit  (tagAOutParityBit),
                     .tagBOut           (tagBOut[0:21]),
                     .tagBOutParityBit  (tagBOutParityBit),
                     .CB                (CB),
                     .dataIn            (tagDataIn[0:21]),
                     .dataInParityBit   (tagDataInParityBit),
                     .readWr            (tagRdWrL1),
                     .tagCycle          (tagcycle),
                     .tagIndex          (tagIndex[0:8]),
                     .writeTagANotB     (wrTagANotBL2[0:22]),
                     .bist_mode         (icu_bist_mode),
                     .bist_ce_n         (bist_ce_n_m2),
                     .bist_we_n         (bist_we_n_m2),
                     .bist_addr         (bist_addr_m2),
                     .bist_rd_data      (bist_rd_data_m2),
                     .bist_wr_data      (bist_wr_data_m2),
                     .cap_mem_addr      (cap_mem_addr_m2),
                     .cap_mem_wr_data   (cap_mem_wr_data_m2),
                     .cap_mem_we        (cap_mem_we_m2)
                   );

// Removed the module "dp_muxICU_dataBout1"
  assign {B_data[32:63],B_dataOddParity} = ({dataBout[32:63],dataBout1Parity} & 
                                            {(33){~(Lx28Sel)}} ) | 
                                            ({dataBout[96:127],dataBout3Parity} & 
                                            {(33){Lx28Sel}} );

// Removed the module "dp_muxICU_dataBout0"
  assign {B_data[0:31],B_dataEvenParity} = ({dataBout[0:31],dataBout0Parity} & 
                                            {(33){~(Lx28Sel)}} ) | 
                                            ({dataBout[64:95],dataBout2Parity} & 
                                            {(33){Lx28Sel}} );

// Removed the module "dp_muxICU_dataAout1"
  assign {A_data[32:63],A_dataOddParity} = ({dataAout[32:63],dataAout1Parity} & 
                                            {(33){~(Lx28Sel)}} ) | 
                                            ({dataAout[96:127],dataAout3Parity} & 
                                            {(33){Lx28Sel}} );

// Removed the module "dp_muxICU_dataAout0"
  assign {A_data[0:31],A_dataEvenParity} = ({dataAout[0:31],dataAout0Parity} & 
                                            {(33){~(Lx28Sel)}} ) | 
                                            ({dataAout[64:95],dataAout2Parity} & 
                                            {(33){Lx28Sel}} );

p405s_icu_ram_dataArray_16K_B
 dataArray_B_Sch (
                           .dataOutB       (dataBout[0:127]),
                           .CB             (CB),
                           .byteWrite      ({16{readWrBL2}}),
                           .cycleDataRamB  (cycleDataRamBL2),
                           .dataIn         (dataB[0:127]),
                           .dataIndexB     (dataIndexB[0:9]),
                           .readWrB        (readWrBL2),
                           .bist_mode      (icu_bist_mode),
                           .bist_ce_n      (bist_ce_n_m1),
                           .bist_we_n      (bist_we_n_m1),
                           .bist_addr      (bist_addr_m1),
                           .bist_rd_data      (bist_rd_data_m1),
                           .bist_wr_data      (bist_wr_data_m1),
                           .cap_mem_addr      (cap_mem_addr_m1),
                           .cap_mem_wr_data   (cap_mem_wr_data_m1),
                           .cap_mem_we        (cap_mem_we_m1)
                          );

// Removed the module "dp_regICU_readWrB"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
      readWrBL2 <= dataRdWrRegIn;
   end
`else
   always @(CB or dataRdWrRegIn or readWrBL2)
    begin
    casez(~CB)
     1'b0: ;
     1'b1: readWrBL2 = dataRdWrRegIn;
      default: readWrBL2 = readWrBL2;
    endcase
   end     
`endif

// Removed the module "dp_regICU_readWrA"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
  always @(negedge CB)
    begin
      readWrAL2 <= dataRdWrRegIn;
   end
`else
   always @(CB or dataRdWrRegIn or readWrAL2)     
    begin        
    casez(~CB)   
     1'b0: ;        
     1'b1: readWrAL2 = dataRdWrRegIn;     
      default: readWrAL2 = readWrAL2 ;
    endcase        
   end             
`endif

// Removed the module "dp_regICU_readWrParity"

`ifdef CBS         // for cycle-based simulators (MESA)
   // L1 Output modeled as negitive edge FF
   always @(negedge CB)
    begin
    casez(1'b1)
     1'b0: readWrParityL2 <= readWrParityL2;
     1'b1: readWrParityL2 <= dataRdWrRegIn;
      default: readWrParityL2 <= 1'bx;
    endcase
   end
`else
   always @(CB or dataRdWrRegIn or readWrParityL2)
    begin
    casez(~CB)
     1'b0: ;
     1'b1: readWrParityL2 = dataRdWrRegIn;
      default: readWrParityL2 = readWrParityL2 ;
    endcase
   end
`endif

p405s_icu_ram_dataArray_16K_A
 dataArray_A_Sch( 
                  .dataOutA       (dataAout[0:127]),
                  .CB             (CB),
                  .byteWrite      ({16{readWrAL2}}),
                  .cycleDataRamA  (cycleDataRamAL2),
                  .dataIn         (dataA[0:127]),
                  .dataIndexA     (dataIndexA[0:9]),
                  .readWrA        (readWrAL2),
                  .bist_mode      (icu_bist_mode),
                  .bist_ce_n      (bist_ce_n_m0),
                  .bist_we_n      (bist_we_n_m0),
                  .bist_addr      (bist_addr_m0),
                  .bist_rd_data     (bist_rd_data_m0),
                  .bist_wr_data     (bist_wr_data_m0),
                  .cap_mem_addr     (cap_mem_addr_m0),
                  .cap_mem_wr_data  (cap_mem_wr_data_m0),
                  .cap_mem_we       (cap_mem_we_m0)
              );

p405s_icu_ram_parityArray
 parityArray( 
                  .parityOut       ({dataAout0Parity, dataAout1Parity, 
                                     dataAout2Parity, dataAout3Parity,
                                     dataBout0Parity, dataBout1Parity, 
                                     dataBout2Parity, dataBout3Parity}),
                  .CB               (CB),
                  .bitWrite         ({{4{~cycleDataRamAL2}},{4{~cycleDataRamBL2}}}), 
                  .cycleParityRam   (cycleParityRamL2),
                  .parityIn         ({dataA0Parity, dataA1Parity, dataA2Parity, 
                                      dataA3Parity, dataB0Parity, dataB1Parity,
                                      dataB2Parity, dataB3Parity}),
                  .dataIndexA       (dataIndexA[0:9]),
                  .readWrParity     (readWrParityL2),
                  .bist_mode        (icu_bist_mode),
                  .bist_ce_n        (bist_ce_n_m3),
                  .bist_we_n        (bist_we_n_m3),
                  .bist_addr        (bist_addr_m3),
                  .bist_rd_data     (bist_rd_data_m3),
                  .bist_wr_data     (bist_wr_data_m3),
                  .cap_mem_addr     (cap_mem_addr_m3),
                  .cap_mem_wr_data  (cap_mem_wr_data_m3),
                  .cap_mem_we       (cap_mem_we_m3)
                 );

// Removed the module "dp_muxICU_bypass1"
   always @(Lx27Sel or Lx28Sel or muxA) 
    begin        
    case({Lx27Sel, Lx28Sel})        
     2'b00:  byPassData[32:63] = muxA[32:63];    
     2'b01:  byPassData[32:63] = muxA[96:127];    
     2'b10:  byPassData[32:63] = muxA[160:191];    
     2'b11:  byPassData[32:63] = muxA[224:255];    
      default:  byPassData[32:63] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxICU_bypass0"
   always @(Lx27Sel or Lx28Sel or muxB) 
    begin        
    case({Lx27Sel, Lx28Sel})        
     2'b00: byPassData[0:31] = muxB[0:31];    
     2'b01: byPassData[0:31] = muxB[64:95];    
     2'b10: byPassData[0:31] = muxB[128:159];    
     2'b11: byPassData[0:31] = muxB[192:223];    
      default: byPassData[0:31] = 32'bx;   
    endcase        
   end        

// Removed the module "dp_muxICU_isBusO"
   always @(isBusSel or isBusSel or byPassData or B_data or B_dataOddParityError or 
            A_data or A_dataOddParityError or OCM_isData) 
    begin        
    case({isBusSel[0], isBusSel[1]})       
     2'b00: {ICU_isBus[32:63],ICU_parityErrO} = {byPassData[32:63],1'b0};    
     2'b01: {ICU_isBus[32:63],ICU_parityErrO} = {B_data[32:63],B_dataOddParityError};    
     2'b10: {ICU_isBus[32:63],ICU_parityErrO} = {A_data[32:63],A_dataOddParityError};    
     2'b11: {ICU_isBus[32:63],ICU_parityErrO} = {OCM_isData[32:63],1'b0};    
      default: {ICU_isBus[32:63],ICU_parityErrO} = 33'bx;        
    endcase        
   end        

// Removed the module "dp_muxICU_isBusE"
   always @(isBusSel or byPassData or B_data or B_dataEvenParityError or tagBParityError or 
            A_data or A_dataEvenParityError or tagAParityError or OCM_isData)
    begin        
    case({isBusSel[0],isBusSel[1]})       
     2'b00: {ICU_isBus[0:31],ICU_parityErrE, ICU_tagParityErr} = {byPassData[0:31],2'b0};    
     2'b01: {ICU_isBus[0:31],ICU_parityErrE, ICU_tagParityErr} = {B_data[0:31],
                                                                  B_dataEvenParityError, 
                                                                  tagBParityError};    
     2'b10: {ICU_isBus[0:31],ICU_parityErrE, ICU_tagParityErr} = {A_data[0:31],
                                                                  A_dataEvenParityError,
                                                                  tagAParityError};    
     2'b11: {ICU_isBus[0:31],ICU_parityErrE, ICU_tagParityErr} = {OCM_isData[0:31],2'b0};    
      default: {ICU_isBus[0:31],ICU_parityErrE, ICU_tagParityErr} = 34'bx;        
    endcase        
   end        

// Removed the module "dp_regICU_RamWbB7"
   always @(posedge CB)      
    begin        
    if (wbLowB57)        
      ramWbB7[224:255] <= muxB[224:255];        
   end        

// Removed the module "dp_regICU_RamWbB6"
   always @(posedge CB)      
    begin        
    if (wbLowB46)        
      ramWbB6[192:223] <= muxB[192:223];        
   end        

// Removed the module "dp_regICU_RamWbB5"
   always @(posedge CB)      
    begin        
    if (wbLowB57)        
      ramWbB5[160:191] <= muxB[160:191];        
   end        

// Removed the module "dp_regICU_RamWbB4"
   always @(posedge CB)      
    begin        
    if (wbLowB46)        
      ramWbB4[128:159] <= muxB[128:159];        
   end        

// Removed the module "dp_regICU_parityWbB7"
   always @(posedge CB)      
    begin        
    if ( wbLowB57)        
      ramWbB7Parity <= fillBParity_7;        
   end        

// Removed the module "dp_regICU_parityWbB6"
   always @(posedge CB)      
    begin        
    if (wbLowB46)        
      ramWbB6Parity <= fillBParity_6;        
   end        

// Removed the module "dp_regICU_parityWbB5"
   always @(posedge CB)      
    begin        
    if (wbLowB57)        
      ramWbB5Parity <= fillBParity_5;        
   end        

// Removed the module "dp_regICU_parityWbB4"
   always @(posedge CB)      
    begin        
    if (wbLowB46)        
      ramWbB4Parity <= fillBParity_4;        
   end        

// Removed the module "dp_muxICU_RamWbB3"
  assign ramWbB[96:127] = (muxB[96:127] & {(32){~(fillWr0L2)}} ) | 
                          (ramWbB7[224:255] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_RamWbB2"
  assign ramWbB[64:95] = (muxB[64:95] & {(32){~(fillWr0L2)}} ) | 
                         (ramWbB6[192:223] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_RamWbB1"
  assign ramWbB[32:63] = (muxB[32:63] & {(32){~(fillWr0L2)}} ) | 
                         (ramWbB5[160:191] & {(32){fillWr0L2}} );
  
// Removed the module "dp_muxICU_RamWbB0"
  assign ramWbB[0:31] = (muxB[0:31] & {(32){~(fillWr0L2)}} ) | 
                        (ramWbB4[128:159] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbB3"
  assign ramWbB3Parity = (fillBParity_3 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbB7Parity & {(1){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbB2"
  assign ramWbB2Parity = (fillBParity_2 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbB6Parity & {(1){fillWr0L2}} );
  
// Removed the module "dp_muxICU_parityWbB1"
  assign ramWbB1Parity = (fillBParity_1 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbB5Parity & {(1){fillWr0L2}} );
// Removed the module "dp_muxICU_parityWbB0"
  assign ramWbB0Parity = (fillBParity_0 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbB4Parity & {(1){fillWr0L2}} );

// Removed the module "dp_regICU_RamWbB3"
   always @(ramWbB or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbB3_mux = ramWbB[96:127];   
     1'b1: RamWbB3_mux = JTG_inst[0:31];   
      default: RamWbB3_mux = 32'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    casez(wbHighBE2[3])
     1'b0: dataB[96:127] <= dataB[96:127];
     1'b1: dataB[96:127] <= RamWbB3_mux;
      default: dataB[96:127] <= 32'bx;
    endcase
   end

// Removed the module "dp_regICU_RamWbB2"
   always @(ramWbB or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbB2_mux = ramWbB[64:95];   
     1'b1: RamWbB2_mux = JTG_inst[0:31];   
      default: RamWbB2_mux = 32'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if ( wbHighBE2[2])        
      dataB[64:95] <= RamWbB2_mux;   
   end        

// Removed the module "dp_regICU_RamWbB1"
   always @(ramWbB or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbB1_mux = ramWbB[32:63];   
     1'b1: RamWbB1_mux = JTG_inst[0:31];   
      default: RamWbB1_mux = 32'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[1])
      dataB[32:63] <= RamWbB1_mux;
   end

// Removed the module "dp_regICU_RamWbB0"
   always @(ramWbB or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbB0_mux = ramWbB[0:31];   
     1'b1: RamWbB0_mux = JTG_inst[0:31];   
      default: RamWbB0_mux = 32'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[0])        
      dataB[0:31] <= RamWbB0_mux;   
   end        

// 10-10-01  JRS  Adding hardware SE injection to B data using ICU_CCR1ICDE
   // Replacing instantiation: XOR2 dp_logICU_dataB1SEInject

 // The following two instantiations were done by hand.
   wire dataB1ParityBitSEI;
   wire dataB2ParityBitSEI;
   assign dataB1ParityBitSEI = ICU_CCR1ICDE ^ ramWbB1Parity ;
   assign dataB2ParityBitSEI = ICU_CCR1ICDE ^ ramWbB2Parity ;
   // Replacing instantiation: XOR2 dp_logICU_dataB2SEInject
   wire dataA1ParityBitSEI;
   wire dataA2ParityBitSEI;
   assign dataA1ParityBitSEI  = ICU_CCR1ICDE ^ ramWbA1Parity ;
   assign dataA2ParityBitSEI  = ICU_CCR1ICDE ^ ramWbA2Parity ;

// Removed the module "dp_regICU_parityWbB3"
   always @(ramWbB3Parity or JTG_instParity or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbB3_mux = ramWbB3Parity;   
     1'b1: parityWbB3_mux = JTG_instParity;   
      default: parityWbB3_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[3])
      dataB3Parity <= parityWbB3_mux;
   end

// Removed the module "dp_regICU_parityWbB2"
   always @(dataB2ParityBitSEI or JTG_instParitySEI or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbB2_mux = dataB2ParityBitSEI;   
     1'b1: parityWbB2_mux = JTG_instParitySEI;   
      default: parityWbB2_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[2])
      dataB2Parity <= parityWbB2_mux;
   end

// Removed the module "dp_regICU_parityWbB1"
   always @(dataB1ParityBitSEI or JTG_instParitySEI or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbB1_mux = dataB1ParityBitSEI;   
     1'b1: parityWbB1_mux = JTG_instParitySEI;   
      default: parityWbB1_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[1])
      dataB1Parity <= parityWbB1_mux;
   end

// Removed the module "dp_regICU_parityWbB0"
   always @(ramWbB0Parity or JTG_instParity or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbB0_mux = ramWbB0Parity;   
     1'b1: parityWbB0_mux = JTG_instParity;   
      default: parityWbB0_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighBE2[0])
      dataB0Parity <= parityWbB0_mux;
   end

// Removed the module "dp_regICU_RamWbA7"
   always @(posedge CB)      
    begin        
    if (wbLowA57)        
      ramWbA7[224:255] <= muxA[224:255];        
   end        

// Removed the module "dp_regICU_RamWbA6"
   always @(posedge CB)      
    begin        
    if (wbLowA46)        
      ramWbA6[192:223] <= muxA[192:223];        
   end        

// Removed the module "dp_regICU_RamWbA5"
   always @(posedge CB)      
    begin        
    if (wbLowA57)        
      ramWbA5[160:191] <= muxA[160:191];        
   end        

// Removed the module "dp_regICU_RamWbA4"
   always @(posedge CB)      
    begin        
    if (wbLowA46)        
      ramWbA4[128:159] <= muxA[128:159];        
   end        

// Removed the module "dp_regICU_parityWbA7"
   always @(posedge CB)      
    begin        
    if (wbLowA57)        
      ramWbA7Parity <= fillAParity_7;        
   end        

// Removed the module "dp_regICU_parityWbA6"
   always @(posedge CB)      
    begin        
    if (wbLowA46)        
      ramWbA6Parity <= fillAParity_6;        
   end        

// Removed the module "dp_regICU_parityWbA5"
   always @(posedge CB)      
    begin        
    if (wbLowA57)        
      ramWbA5Parity <= fillAParity_5;        
   end        

// Removed the module "dp_regICU_parityWbA4"
   always @(posedge CB)      
    begin        
    if (wbLowA46)        
      ramWbA4Parity <= fillAParity_4;        
   end        

// Removed the module "dp_muxICU_RamWbA3"
  assign ramWbA[96:127] = (muxA[96:127] & {(32){~(fillWr0L2)}} ) | 
                          (ramWbA7[224:255] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_RamWbA2"
  assign ramWbA[64:95] = (muxA[64:95] & {(32){~(fillWr0L2)}} ) | 
                         (ramWbA6[192:223] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_RamWbA1"
  assign ramWbA[32:63] = (muxA[32:63] & {(32){~(fillWr0L2)}} ) | 
                         (ramWbA5[160:191] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_RamWbA0"
  assign ramWbA[0:31] = (muxA[0:31] & {(32){~(fillWr0L2)}} ) | 
                        (ramWbA4[128:159] & {(32){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbA3"
  assign ramWbA3Parity = (fillAParity_3 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbA7Parity & {(1){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbA2"
  assign ramWbA2Parity = (fillAParity_2 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbA6Parity & {(1){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbA1"
  assign ramWbA1Parity = (fillAParity_1 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbA5Parity & {(1){fillWr0L2}} );

// Removed the module "dp_muxICU_parityWbA0"
  assign ramWbA0Parity = (fillAParity_0 & {(1){~(fillWr0L2)}} ) | 
                         (ramWbA4Parity & {(1){fillWr0L2}} );

// Removed the module "dp_regICU_RamWbA3"
   always @(ramWbA or JTG_inst or JTG_iCacheWr)
    begin
    casez(JTG_iCacheWr)
     1'b0: RamWbA3_mux = ramWbA[96:127];
     1'b1: RamWbA3_mux = JTG_inst[0:31];
      default: RamWbA3_mux = 32'bx;
    endcase
   end

//RDH   always @(posedge CB)
   always @(negedge CB)
    begin
    casez(wbHighAE2[3])
     1'b0: dataA[96:127] <= dataA[96:127];
     1'b1: dataA[96:127] <= RamWbA3_mux;
      default: dataA[96:127] <= 32'bx;
    endcase
   end

// Removed the module "dp_regICU_RamWbA2"
   always @(ramWbA or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbA2_mux = ramWbA[64:95];   
     1'b1: RamWbA2_mux = JTG_inst[0:31];   
      default: RamWbA2_mux = 32'bx;  
    endcase        
   end        

//RDH    always @(posedge CB)      
   always @(negedge CB)
    begin        
    if (wbHighAE2[2])
      dataA[64:95] <= RamWbA2_mux;
   end

// Removed the module "dp_regICU_RamWbA1"
   always @(ramWbA or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbA1_mux = ramWbA[32:63];   
     1'b1: RamWbA1_mux = JTG_inst[0:31];   
      default: RamWbA1_mux = 32'bx;  
    endcase        
   end        

//RDH    always @(posedge CB)      
   always @(negedge CB)
    begin        
    if (wbHighAE2[1])
      dataA[32:63] <= RamWbA1_mux;
   end

// Removed the module "dp_regICU_RamWbA0"
   always @(ramWbA or JTG_inst or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: RamWbA0_mux = ramWbA[0:31];   
     1'b1: RamWbA0_mux = JTG_inst[0:31];   
      default: RamWbA0_mux = 32'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighAE2[0])
      dataA[0:31] <= RamWbA0_mux;
   end

// Removed the module "dp_regICU_parityWbA3"
   always @(ramWbA3Parity or JTG_instParity or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbA3_mux = ramWbA3Parity;   
     1'b1: parityWbA3_mux = JTG_instParity;   
      default: parityWbA3_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighAE2[3])
      dataA3Parity <= parityWbA3_mux;
   end

// Removed the module "dp_regICU_parityWbA2"
   always @(dataA2ParityBitSEI or JTG_instParitySEI or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbA2_mux = dataA2ParityBitSEI;   
     1'b1: parityWbA2_mux = JTG_instParitySEI;   
      default: parityWbA2_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighAE2[2])
      dataA2Parity <= parityWbA2_mux;
   end

// Removed the module "dp_regICU_parityWbA1"
   always @(dataA1ParityBitSEI or JTG_instParitySEI or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbA1_mux = dataA1ParityBitSEI;   
     1'b1: parityWbA1_mux = JTG_instParitySEI;   
      default: parityWbA1_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighAE2[1])
      dataA1Parity <= parityWbA1_mux;
   end

// Removed the module "dp_regICU_parityWbA0"
   always @(ramWbA0Parity or JTG_instParity or JTG_iCacheWr)    
    begin        
    casez(JTG_iCacheWr)        
     1'b0: parityWbA0_mux = ramWbA0Parity;   
     1'b1: parityWbA0_mux = JTG_instParity;   
      default: parityWbA0_mux = 1'bx;  
    endcase        
   end        

//RDH   always @(posedge CB)      
   always @(negedge CB)      
    begin        
    if (wbHighAE2[0])
      dataA0Parity <= parityWbA0_mux;
   end


// Removed the module "dp_muxICU_RamEndB7"
  assign muxB[224:255] = ~( (fillB[224:255] & {(32){~(df_rarsTLE)}} ) | 
                            ({fillB[248:255], fillB[240:247], fillB[232:239], 
                              fillB[224:231]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB6"
  assign muxB[192:223] = ~( (fillB[192:223] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillB[216:223], fillB[208:215], fillB[200:207], 
                             fillB[192:199]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB5"
  assign muxB[160:191] = ~( (fillB[160:191] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillB[184:191], fillB[176:183], fillB[168:175], 
                             fillB[160:167]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB4"
  assign muxB[128:159] = ~( (fillB[128:159] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillB[152:159], fillB[144:151], fillB[136:143], 
                             fillB[128:135]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB3"
  assign muxB[96:127] = ~( (fillB[96:127] & {(32){~(df_rarsTLE)}} ) | 
                          ({fillB[120:127], fillB[112:119], fillB[104:111], 
                            fillB[96:103]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB2"
  assign muxB[64:95] = ~( (fillB[64:95] & {(32){~(df_rarsTLE)}} ) | 
                         ({fillB[88:95], fillB[80:87], fillB[72:79], 
                           fillB[64:71]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB1"
  assign muxB[32:63] = ~( (fillB[32:63] & {(32){~(df_rarsTLE)}} ) | 
                         ({fillB[56:63], fillB[48:55], fillB[40:47], 
                           fillB[32:39]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndB0"
  assign muxB[0:31] = ~( (fillB[0:31] & {(32){~(df_rarsTLE)}} ) | 
                        ({fillB[24:31], fillB[16:23], fillB[8:15], 
                          fillB[0:7]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA7"
  assign muxA[224:255] = ~( (fillA[224:255] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillA[248:255], fillA[240:247], fillA[232:239], 
                             fillA[224:231]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA6"
  assign muxA[192:223] = ~( (fillA[192:223] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillA[216:223], fillA[208:215], fillA[200:207], 
                             fillA[192:199]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA5"
  assign muxA[160:191] = ~( (fillA[160:191] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillA[184:191], fillA[176:183], fillA[168:175], 
                             fillA[160:167]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA4"
  assign muxA[128:159] = ~( (fillA[128:159] & {(32){~(df_rarsTLE)}} ) | 
                           ({fillA[152:159], fillA[144:151], fillA[136:143], 
                             fillA[128:135]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA3"
  assign muxA[96:127] = ~( (fillA[96:127] & {(32){~(df_rarsTLE)}} ) | 
                          ({fillA[120:127], fillA[112:119], fillA[104:111], 
                            fillA[96:103]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA2"
  assign muxA[64:95] = ~( (fillA[64:95] & {(32){~(df_rarsTLE)}} ) | 
                         ({fillA[88:95], fillA[80:87], fillA[72:79], 
                           fillA[64:71]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA1"
  assign muxA[32:63] = ~( (fillA[32:63] & {(32){~(df_rarsTLE)}} ) | 
                         ({fillA[56:63], fillA[48:55], fillA[40:47], 
                           fillA[32:39]} & {(32){df_rarsTLE}} ) );

// Removed the module "dp_muxICU_RamEndA0"
  assign muxA[0:31] = ~( (fillA[0:31] & {(32){~(df_rarsTLE)}} ) | 
                        ({fillA[24:31], fillA[16:23], fillA[8:15], 
                          fillA[0:7]} & {(32){df_rarsTLE}} ) );

// 08-08-01     JRS     1817    Pulling parity bits into there own fill regs so can place closer to parity array.

// Removed the module "dp_regICU_RamFillB7"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[7])        
      RamFillB7_reg <= plbDBus[32:63];        
   end        

   assign fillB[224:255] = ~(RamFillB7_reg);

// Removed the module "dp_regICU_RamFillB6"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[6])        
      RamFillB6_reg <= plbDBus[0:31];        
   end        

   assign fillB[192:223] = ~(RamFillB6_reg);

// Removed the module "dp_regICU_RamFillB5"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[5])        
      RamFillB5_reg <= plbDBus[32:63];        
   end        

   assign fillB[160:191] = ~(RamFillB5_reg);

// Removed the module "dp_regICU_RamFillB4"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[4])        
      RamFillB4_reg <= plbDBus[0:31];        
   end        

   assign fillB[128:159] = ~(RamFillB4_reg);

// Removed the module "dp_regICU_RamFillB3"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[3])        
      RamFillB3_reg <= plbDBus[32:63];        
   end        

   assign fillB[96:127] = ~(RamFillB3_reg);

// Removed the module "dp_regICU_RamFillB2"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[2])        
      RamFillB2_reg <= plbDBus[0:31];        
   end        

   assign fillB[64:95] = ~(RamFillB2_reg);

// Removed the module "dp_regICU_RamFillB1"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[1])        
      RamFillB1_reg <= plbDBus[32:63];        
   end        

   assign fillB[32:63] = ~(RamFillB1_reg);

// Removed the module "dp_regICU_RamFillB0"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[0])        
      RamFillB0_reg <= plbDBus[0:31];        
   end        

   assign fillB[0:31] = ~(RamFillB0_reg);

// Removed the module "dp_regICU_RamFillA7"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[7])        
      RamFillA7_reg <= plbDBus[32:63];        
   end        

   assign fillA[224:255] = ~(RamFillA7_reg);

// Removed the module "dp_regICU_RamFillA6"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[6])        
      RamFillA6_reg <= plbDBus[0:31];        
   end        

   assign fillA[192:223] = ~(RamFillA6_reg);

// Removed the module "dp_regICU_RamFillA5"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[5])        
      RamFillA5_reg <= plbDBus[32:63];        
   end        

   assign fillA[160:191] = ~(RamFillA5_reg);

// Removed the module "dp_regICU_RamFillA4"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[4])        
      RamFillA4_reg <= plbDBus[0:31];        
   end        

   assign fillA[128:159] = ~(RamFillA4_reg);

// Removed the module "dp_regICU_RamFillA3"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[3])        
      RamFillA3_reg <= plbDBus[32:63];        
   end        

   assign fillA[96:127] = ~(RamFillA3_reg);

// Removed the module "dp_regICU_RamFillA2"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[2])        
      RamFillA2_reg <= plbDBus[0:31];        
   end        

   assign fillA[64:95] = ~(RamFillA2_reg);

// Removed the module "dp_regICU_RamFillA1"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[1])        
      RamFillA1_reg <= plbDBus[32:63];        
   end        

   assign fillA[32:63] = ~(RamFillA1_reg);

// Removed the module "dp_regICU_RamFillA0"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[0])        
      RamFillA0_reg <= plbDBus[0:31];        
   end        

   assign fillA[0:31] = ~(RamFillA0_reg);

// Removed the module "dp_regICU_parityFillB7"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[7])        
      parityFillB7_reg <= plbParityBitLo;        
   end        

   assign fillBParity_7 = ~(parityFillB7_reg);

// Removed the module "dp_regICU_parityFillB6"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[6])        
      parityFillB6_reg <= plbParityBitHi;        
   end        

   assign fillBParity_6 = ~(parityFillB6_reg);

// Removed the module "dp_regICU_parityFillB5"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[5])        
      parityFillB5_reg <= plbParityBitLo;        
   end        

   assign fillBParity_5 = ~(parityFillB5_reg);

// Removed the module "dp_regICU_parityFillB4"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[4])        
      parityFillB4_reg <= plbParityBitHi;        
   end        

   assign fillBParity_4 = ~(parityFillB4_reg);

// Removed the module "dp_regICU_parityFillB3"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[3])        
      parityFillB3_reg <= plbParityBitLo;        
   end        

   assign fillBParity_3 = ~(parityFillB3_reg);

// Removed the module "dp_regICU_parityFillB2"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[2])        
      parityFillB2_reg <= plbParityBitHi;        
   end        

   assign fillBParity_2 = ~(parityFillB2_reg);

// Removed the module "dp_regICU_parityFillB1"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[1])        
      parityFillB1_reg <= plbParityBitLo;        
   end        

   assign fillBParity_1 = ~(parityFillB1_reg);

// Removed the module "dp_regICU_parityFillB0"
   always @(posedge CB)      
    begin        
    if (scL2 & fillBE2[0])        
      parityFillB0_reg <= plbParityBitHi;        
   end        

   assign fillBParity_0 = ~(parityFillB0_reg);

// Removed the module "dp_regICU_parityFillA7"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[7])        
      parityFillA7_reg <= plbParityBitLo;        
   end        

   assign fillAParity_7 = ~(parityFillA7_reg);

// Removed the module "dp_regICU_parityFillA6"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[6])        
      parityFillA6_reg <= plbParityBitHi;        
   end        

   assign fillAParity_6 = ~(parityFillA6_reg);

// Removed the module "dp_regICU_parityFillA5"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[5])        
      parityFillA5_reg <= plbParityBitLo;        
   end        

   assign fillAParity_5 = ~(parityFillA5_reg);

// Removed the module "dp_regICU_parityFillA4"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[4])        
      parityFillA4_reg <= plbParityBitHi;        
   end        

   assign fillAParity_4 = ~(parityFillA4_reg);

// Removed the module "dp_regICU_parityFillA3"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[3])        
      parityFillA3_reg <= plbParityBitLo;        
   end        

   assign fillAParity_3 = ~(parityFillA3_reg);

// Removed the module "dp_regICU_parityFillA2"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[2])        
      parityFillA2_reg <= plbParityBitHi;        
   end        

   assign fillAParity_2 = ~(parityFillA2_reg);

// Removed the module "dp_regICU_parityFillA1"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[1])        
      parityFillA1_reg <= plbParityBitLo;        
   end        

   assign fillAParity_1 = ~(parityFillA1_reg);

// Removed the module "dp_regICU_parityFillA0"
   always @(posedge CB)      
    begin        
    if (scL2 & fillAE2[0])        
      parityFillA0_reg <= plbParityBitHi;        
   end        

   assign fillAParity_0 = ~(parityFillA0_reg);

// parity logic blocks          7-9-01 JRS

// 8-06-01      JRS     changing both PLB data parity generations to invert the parity bit 
//                      because all input data is stored in inverting fill regs, including
//                      the parity bits  since have 33 bits will have an extra inversion
//                      that causes the parity to always be wrong

// Removed the module "dp_logICU_ParityGen32I"
  assign plbParityBitHi = ~(^(PLB_icuDBus[0:31]));
  assign plbParityBitLo = ~(^(PLB_icuDBus[32:63]));

// JRS  10-29-01  Generating JTAG data parity bit with soft error injection.

// Removed the module "dp_logICU_ParityGen33"
  assign JTG_instParitySEI = ^({JTG_inst[0:31],ICU_CCR1ICDE});

// Removed the module "dp_logICU_ParityGen32"
  assign JTG_instParity = ^(JTG_inst[0:31]);

// Removed the module "dp_logICU_ParityGen33"
  assign A_dataEvenParityError = ^({A_data[0:31],A_dataEvenParity});
  assign A_dataOddParityError = ^({A_data[32:63],A_dataOddParity});
  assign B_dataEvenParityError = ^({B_data[0:31],B_dataEvenParity});
  assign B_dataOddParityError = ^({B_data[32:63],B_dataOddParity});

// JRS  10-29-01  Moving soft error injection into parity generation logic.

// Removed the module "dp_logICU_ParityGen23"
  assign tagDataParityBit = ^({tagData[0:21],ICU_CCR1ICTE});
  assign tagAParityError = ^({tagAOut[0:21], tagAOutParityBit});
  assign tagBParityError = ^({tagBOut[0:21], tagBOutParityBit});

// Drive the dw_rambist placeholder ports

  assign icu_bist_mode = 1'b0;
  assign icu_bist_mode_reg_so = 1'b0;
  assign icu_bist_mode_reg_out = 19'b0;
  assign icu_bist_debug_so = 4'b0;
  assign bist_addr_m0 = 9'b0;
  assign bist_wr_data_m0 = 128'b0;
  assign bist_ce_n_m0 = 1'b1;
  assign bist_we_n_m0 = 1'b1;
  assign bist_addr_m1 = 9'b0;
  assign bist_wr_data_m1 = 128'b0;
  assign bist_ce_n_m1 = 1'b1;
  assign bist_we_n_m1 = 1'b1;
  assign bist_addr_m2 = 8'b0;
  assign bist_wr_data_m2 = 46'b0;
  assign bist_ce_n_m2 = 1'b1;
  assign bist_we_n_m2 = 1'b1;
  assign bist_addr_m3 = 9'b0;
  assign bist_wr_data_m3 = 8'b0;
  assign bist_ce_n_m3 = 1'b1;
  assign bist_we_n_m3 = 1'b1;

endmodule
