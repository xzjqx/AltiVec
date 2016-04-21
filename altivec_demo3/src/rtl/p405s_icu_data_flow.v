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
// 8-02-01      JRS     adding ICU_CCR0DPE, ICU_CCR0DPP, ICU_CCR0IPE, ICU_CCR0TPE as PO, going
//                      to go out of icu_top
// 8-06-01      PGM     Defect 1805 Changed D2 input of dp_regICU_vcarsp and dp_regICU_Vcars
//                       so formality would match
// 8-27-01      JRS     re-order cdbcr (CCR0) register bits so that new ones come 1st, done to pass formality

module p405s_icu_data_flow( BlockFlush, Block_CAR, Block_COF, Block_LSA, Block_SAQ, Block_mult_req,
     DPP1_NEG, ICU_ABus_NEG, ICU_CCR0DDK, ICU_GPRC, ICU_LDBE, ICU_U0Attr_NEG, ICU_baSel,
     ICU_dcuLNC, ICU_dcuLOA, ICU_dcuWOA, ICU_sprData, ICU_tagDataSel, ICU_paritySel, ICU_traceEnable,
     IPP0_NEG, IPP1_NEG, df_cpuEa, df_dataCc, df_forceOnly1Req, df_ftchMissBlkWr,
     df_jtagIsEa_NEG, df_lruRdCcInNEG, df_lruWrCcIn, df_nonC_8,
     df_nonCpreFetchEn, df_plb27L2, df_plbaOverflow, df_preFetchEnable, df_rars,
     df_rarsTLE, df_selCCR0, df_tagVccRegIn, df_vcarVcarsCompare, rdar, 
     CB, DCU_icuSize, EXE_dsEA_NEG, EXE_icuSprDcds, EXE_sprData,
     IFB_isEA, MMU_dsEndianL2, MMU_dsU0AttrL2, MMU_isEndian, MMU_isRA,
     MMU_isU0Attr, MMU_rdarDsRAL2, PCL_mfSPR, PCL_mtSPR, PCL_sprHold, cdbdrE1,
     dataCcSel, dsRdMuxSel, dsVcar1E2, dsVcar2E2, fillWr0L2, icReadData,
     icuCacheSize, icuRdarE1, icuRdarE2, jtag2ndWr, lruRdSel, plbHighSel,
     plbLowSel, rarsSel, resetCore, scL2, scanin, tagVSel, vcarE2, vcarInSelL2,
     vcarSelHi_NEG, vcarSelLow_NEG, vcarsCCE2, vcarsSel, vcarspSel, VCT_msrIR,
     ICU_CCR0DPE, ICU_CCR0DPP, ICU_CCR0IPE, ICU_CCR0TPE,
     ICU_CCR1ICTE, ICU_CCR1ICDE, ICU_CCR1DCTE, ICU_CCR1DCDE, ICU_CCR1TLBE);

output BlockFlush;
output Block_CAR;
output Block_COF;
output Block_LSA;
output Block_SAQ;
output Block_mult_req;
output DPP1_NEG;
output ICU_CCR0DDK;
output ICU_GPRC;
output ICU_LDBE;
output ICU_U0Attr_NEG;
output ICU_baSel;
output ICU_dcuLNC;
output ICU_dcuLOA;
output ICU_dcuWOA;
output ICU_tagDataSel;
output ICU_paritySel;
output ICU_traceEnable;
output IPP0_NEG;
output IPP1_NEG;
output df_forceOnly1Req;
output df_ftchMissBlkWr;
output df_nonC_8;
output df_nonCpreFetchEn;
output df_plb27L2;
output df_plbaOverflow;
output df_preFetchEnable;
output df_rarsTLE;
output df_selCCR0;
output df_vcarVcarsCompare;
output ICU_CCR0DPE;
output ICU_CCR0DPP;
output ICU_CCR0IPE;
output ICU_CCR0TPE;
output ICU_CCR1ICTE;
output ICU_CCR1ICDE;
output ICU_CCR1DCTE;
output ICU_CCR1DCDE;
output ICU_CCR1TLBE;

input VCT_msrIR;
input MMU_dsEndianL2;
input MMU_dsU0AttrL2;
input MMU_isEndian;
input MMU_isU0Attr;
input PCL_mfSPR;
input PCL_mtSPR;
input PCL_sprHold;
input cdbdrE1;
input dsRdMuxSel;
input dsVcar1E2;
input dsVcar2E2;
input fillWr0L2;
input icuRdarE1;
input icuRdarE2;
input jtag2ndWr;
input lruRdSel;
input resetCore;
input scL2;
input scanin;
input vcarE2;
input vcarInSelL2;
input vcarSelHi_NEG;
input vcarSelLow_NEG;
input vcarsCCE2;

output [0:31]  ICU_sprData;
output [18:26]  df_lruRdCcInNEG;
output [18:26]  df_jtagIsEa_NEG;
output [18:26]  df_tagVccRegIn;
output [18:26]  df_lruWrCcIn;
output [27:29]  df_cpuEa;
output [0:29]  rdar;
output [18:27]  df_dataCc;
output [0:29]  ICU_ABus_NEG;
output [0:21]  df_rars;


input [0:2]  EXE_icuSprDcds;
input [0:1]  plbHighSel;
input [0:1]  tagVSel;
input        CB;
input [0:1]  plbLowSel;
input [0:1]  vcarsSel;
input [0:29]  IFB_isEA;
input [0:1]  vcarspSel;
input [0:31]  icReadData;
input [0:29]  EXE_dsEA_NEG;
input [0:1]  rarsSel;
input [0:29]  MMU_isRA;
input [0:29]  MMU_rdarDsRAL2;
input [0:2]  DCU_icuSize;
input [0:2]  icuCacheSize;
input [0:3]  dataCcSel;
input [0:31]  EXE_sprData;

// Buses in the design
reg Block_CAR_i; 
reg Block_LSA_i; 
reg Block_SAQ_i; 
reg Block_COF_i; 
reg BlockFlush_i; 
reg Block_mult_req_i; 
reg ICU_dcuLNC_i; 
reg ICU_dcuLOA_i; 
reg ICU_dcuWOA_i; 
wire DPP1_i; 
wire IPP0_i; 
wire IPP1_i; 
reg ICU_CCR0DPE_i; 
reg ICU_CCR0DPP_i; 
reg ICU_CCR0DDK_i; 
reg ICU_LDBE_i; 
reg ICU_GPRC_i; 
reg ICU_traceDisable_i; 
reg ICU_CCR0IPE_i; 
reg ICU_CCR0TPE_i; 
reg df_preFetchEnable_i; 
reg df_nonCpreFetchEn1_i; 
reg df_nonC_8_i; 
reg df_ftchMissBlkWr_i; 
reg df_forceOnly1Req_i; 
reg ICU_tagDataSel_i; 
reg ICU_paritySel_i; 
reg ICU_baSel_i;
wire Block_CAR; 
wire Block_LSA; 
wire Block_SAQ; 
wire Block_COF; 
wire BlockFlush; 
wire Block_mult_req; 
wire ICU_dcuLNC; 
wire ICU_dcuLOA; 
wire ICU_dcuWOA; 
wire DPP1; 
wire IPP0; 
wire IPP1; 
wire ICU_CCR0DPE; 
wire ICU_CCR0DPP; 
wire ICU_CCR0DDK; 
wire ICU_LDBE; 
wire ICU_GPRC; 
wire ICU_traceDisable; 
wire ICU_CCR0IPE; 
wire ICU_CCR0TPE; 
wire df_preFetchEnable; 
wire df_nonCpreFetchEn1; 
wire df_nonC_8; 
wire df_ftchMissBlkWr; 
wire df_forceOnly1Req; 
wire ICU_tagDataSel; 
wire ICU_paritySel; 
wire ICU_baSel;
wire [0:29]  ICU_ABus_NEG_i;
reg vcarspIR;
reg vcarsIR;
reg [0:29]  rdar_i;
wire [0:29]  rdar;
reg ICU_CCR1ICTE_i;
reg ICU_CCR1ICDE_i;
reg ICU_CCR1DCTE_i;
reg ICU_CCR1DCDE_i;
reg ICU_CCR1TLBE_i;
wire ICU_CCR1ICTE;
wire ICU_CCR1ICDE;
wire ICU_CCR1DCTE;
wire ICU_CCR1DCDE;
wire ICU_CCR1TLBE;
wire [0:21] df_rars;
reg [0:21] df_rars_i;
reg df_rarsTLE;
reg DPP1_NEG_i;
reg IPP0_NEG_i;
reg IPP1_NEG_i;
wire DPP1_NEG;
wire IPP0_NEG;
wire IPP1_NEG;



wire  [0:8]  symNet770;

reg  [0:26]  symNet812;

reg  [0:29]  symNet802;

reg  [0:8]  vcarsCCL2;

wire  [18:26]  incVcarOut;

wire  [0:8]  symNet772;

wire  [0:2]  symNet766;

wire  [0:29]  symNet758;

wire  [0:1]  sprMuxSel;

wire  [18:26]  ccAdd1;

wire  [0:7]  feedBack;

wire  [0:29]  dsEa;

reg  [0:31]  cdbdrData;

wire  [18:27]  dsRdCC;

wire  [22:26]  incOut;

wire  [0:21]  ABus;

wire  [0:21]  isRABuf;

reg  [0:29]  symNet797;

wire  [9:11]  EXE_sprData_NEG;

wire  [0:29]  vcarIn;

wire  [0:29]  isEA_NEG;

wire  [0:29]  itis;

wire  [0:8]  whIncOut;

reg  [0:27]  vcar;

wire  [22:26]  incVcars;

reg  [0:26]  vcars;

wire  [22:27]  icuAdd;
wire resetCor_NEG ;
wire ccAdd4 ;
wire ccAdd3 ;
wire abusTLE_NEG ;
wire AbusU0Attr ;
wire AbusTLE ;
reg  [18:26] df_tagVccRegIn;
wire [0:31] sprOut_D1 ;
wire [0:31] sprOut_D3 ;
reg [0:31] ICU_sprData;
wire sel_ccr1_E2 ;
wire sel_cdbcr_E2 ;
wire df_vcarVcarsCompare;
wire ICU_U0Attr_NEG_i;
wire ICU_U0Attr_NEG;

   // assignments for output ports
   assign ICU_U0Attr_NEG = ICU_U0Attr_NEG_i;
   assign df_rars = df_rars_i;
   assign ICU_ABus_NEG = ICU_ABus_NEG_i;
   assign rdar = rdar_i;
   assign ICU_CCR1ICTE = ICU_CCR1ICTE_i;
   assign ICU_CCR1DCDE = ICU_CCR1DCDE_i;
   assign ICU_CCR1DCTE = ICU_CCR1DCTE_i;
   assign ICU_CCR1ICDE = ICU_CCR1ICDE_i;
   assign ICU_CCR1TLBE = ICU_CCR1TLBE_i;
   assign Block_CAR = Block_CAR_i; 
   assign Block_LSA = Block_LSA_i; 
   assign Block_SAQ = Block_SAQ_i; 
   assign Block_COF = Block_COF_i; 
   assign BlockFlush = BlockFlush_i; 
   assign Block_mult_req = Block_mult_req_i; 
   assign ICU_dcuLNC = ICU_dcuLNC_i; 
   assign ICU_dcuLOA = ICU_dcuLOA_i; 
   assign ICU_dcuWOA = ICU_dcuWOA_i; 
   assign DPP1 = DPP1_i; 
   assign IPP0 = IPP0_i; 
   assign IPP1 = IPP1_i; 
   assign DPP1_NEG = DPP1_NEG_i;
   assign IPP0_NEG = IPP0_NEG_i;
   assign IPP1_NEG = IPP1_NEG_i;
   assign ICU_CCR0DPE = ICU_CCR0DPE_i; 
   assign ICU_CCR0DPP = ICU_CCR0DPP_i; 
   assign ICU_CCR0DDK = ICU_CCR0DDK_i; 
   assign ICU_LDBE = ICU_LDBE_i; 
   assign ICU_GPRC = ICU_GPRC_i; 
   assign ICU_traceDisable = ICU_traceDisable_i; 
   assign ICU_CCR0IPE = ICU_CCR0IPE_i; 
   assign ICU_CCR0TPE = ICU_CCR0TPE_i; 
   assign df_preFetchEnable = df_preFetchEnable_i; 
   assign df_nonCpreFetchEn1 = df_nonCpreFetchEn1_i; 
   assign df_nonC_8 = df_nonC_8_i; 
   assign df_ftchMissBlkWr = df_ftchMissBlkWr_i; 
   assign df_forceOnly1Req = df_forceOnly1Req_i; 
   assign ICU_tagDataSel = ICU_tagDataSel_i; 
   assign ICU_paritySel = ICU_paritySel_i; 
   assign ICU_baSel = ICU_baSel_i;

   // Removed the module dp_regICU_VcarLow 
   reg  vcarIR;
   always @(posedge CB)  	
    begin				  	
    if (vcarE2)			
      if (~vcarSelLow_NEG)			
        {vcarIR, vcar[16:27]} <= {VCT_msrIR, itis[16:27]};	
   end			 		
   // Removed the module dp_regICU_VcarHigh 
   always @(posedge CB)  	
    begin				  	
    if (vcarE2)			
      if (~vcarSelHi_NEG)			
        vcar[0:15] <= itis[0:15];	
   end			 		
   //Removed the module dp_logicICU_inv2 
   assign resetCor_NEG = ~resetCore;
   //Removed the module dp_logicICU_sprIn 
   assign  EXE_sprData_NEG[9:11] = resetCor_NEG ? symNet766[0:2] : EXE_sprData[9:11];                              
   // Replacing instantiation: GTECH_BUF isEaBuffer
   assign df_cpuEa[29] = itis[29];

   // Replacing instantiation: GTECH_BUF I373
   assign df_cpuEa[28] = itis[28];

   // Replacing instantiation: GTECH_BUF I374
   assign df_cpuEa[27] = itis[27];

   //Removed the module dp_logicICU_jtagIsEa 
   assign df_jtagIsEa_NEG[18:26] = isEA_NEG[18:26];
   //Removed the module dp_muxICU_lxSelect 
   assign itis[0:29] = icuRdarE1 ? ~symNet758[0:29] : ~isEA_NEG[0:29];
   //Removed the module dp_muxICU_CcAdd4 
   assign ccAdd4 = dataCcSel[3] ? fillWr0L2 : jtag2ndWr;
   //Removed the module dp_muxICU_CcAdd3 
   assign ccAdd3 = dataCcSel[0] ? ~ccAdd4 : ~dsRdCC[27];
   //Removed the module dp_muxICU_CcAdd2 
   assign df_dataCc[27] = dataCcSel[2] ? ~ccAdd3 : ~isEA_NEG[27];
   //Removed the module dp_muxICU_CcAdd1 
   assign ccAdd1[18:26] = dataCcSel[3] ? ~vcarsCCL2[0:8] : ~dsRdCC[18:26];
   //Removed the module dp_logicICU_vcarInInv 
   assign symNet758[0:29] = ~(vcarIn[0:29]);
   //Removed the module dp_logicICU_plbaHighInv 
   assign {ABus[0:21], AbusU0Attr, AbusTLE} = ~{ICU_ABus_NEG_i[0:21], ICU_U0Attr_NEG_i, abusTLE_NEG};
   //Removed the module dp_logicICU_fdback 
   assign  feedBack[0:7] = ~ICU_ABus_NEG_i[22:29];
   //Removed the module dp_logicICU_sprBitsOutInv 
   assign {DPP1_i, IPP0_i, IPP1_i} = ~{DPP1_NEG_i, IPP0_NEG_i, IPP1_NEG_i};
   //Removed the module dp_logicICU_sprBitsInInv 
   assign symNet766[0:2] = ~EXE_sprData[9:11];
   //Removed the module dp_logicICU_isEAInv 
   assign isEA_NEG[0:29] = ~IFB_isEA[0:29];
   //Removed the module dp_logicICU_vcarsCCInv 
   assign symNet770[0:8] = ~vcarsCCL2[0:8];
   //Removed the module dp_logicICU_dsRdCCInv 
   assign symNet772[0:8] = ~dsRdCC[18:26];
   //Removed the module dp_logicICU_incVcarInv 
   assign whIncOut[0:8] = ~incVcarOut[18:26];
   //Removed the module dp_muxICU_CcAdd 
   assign df_dataCc[18:26] =  dataCcSel[1] ? ~ccAdd1[18:26] : ~isEA_NEG[18:26];                         
   //Removed the module dp_logicICU_traceInv 
   assign ICU_traceEnable = ~ICU_traceDisable;
   //Removed the module dp_logicICU_plba27Buf 
   assign df_plb27L2 = icuAdd[27];
   //Removed the module dp_logicICU_raBuf 
   assign isRABuf[0:21] = MMU_isRA[0:21];
   //Removed the module dp_muxICU_dsRdMux 
   assign dsRdCC[18:27] =  dsRdMuxSel ? vcarIn[18:27] : vcar[18:27];                      
   // Removed the module dp_regICU_daVcar1 
   always @(posedge CB)  	
    begin				  	
    if (dsVcar1E2)		 	
      symNet802[0:29] <= dsEa[0:29];		
   end			 		
   // Removed the module dp_regICU_daVcar2 
   always @(posedge CB)  	
    begin				  	
    if (dsVcar2E2)		 	
      symNet797[0:29] <= dsEa[0:29];		
   end			 		
   //Removed the module dp_muxICU_vcarIn 
   assign vcarIn[0:29] = vcarInSelL2 ? symNet802[0:29] : symNet797[0:29]; 
   // Removed the module dp_regICU_vcarsp 
   always @(posedge CB)  	
    begin				  	
      case(vcarspSel[0:1])			
       2'b00: ;	
       2'b01: {vcarspIR, symNet812[0:26]} <= {vcarIR, vcar[0:26]};	
       2'b10: {vcarspIR, symNet812[0:26]} <= {vcarsIR, {27{1'b0}} };
       2'b11: {vcarspIR, symNet812[0:26]} <= {vcarsIR, vcars[0:21], incVcars[22:26]};	
        default: {vcarspIR, symNet812[0:26]} <= 28'bx;  
      endcase		 		
   end			 		
   //Removed the module dp_muxICU_tagVaVbCcNEG 
    always @(tagVSel or isEA_NEG or whIncOut or symNet772 or symNet770 ) 
    begin                                           
      case(tagVSel[0:1])                       
       2'b00: df_tagVccRegIn[18:26] = ~isEA_NEG[18:26];   
       2'b01: df_tagVccRegIn[18:26] = ~whIncOut[0:8];   
       2'b10: df_tagVccRegIn[18:26] = ~symNet772[0:8];   
       2'b11: df_tagVccRegIn[18:26] = ~symNet770[0:8];   
        default: df_tagVccRegIn[18:26] = 9'bx;   
      endcase                                    
    end
    //Removed the module dp_muxICU_lruRdcc 
   assign df_lruRdCcInNEG[18:26] = lruRdSel ? ~vcars[18:26] : ~dsRdCC[18:26];
   // Removed the module dp_regICU_vcarsCC 
   always @(posedge CB)  	
    begin				  	
    if (vcarsCCE2)	                
       vcarsCCL2[0:8] <= vcars[18:26];		
   end			 		
   // Replacing instantiation: GTECH_AND2 I241
   assign df_nonCpreFetchEn = df_nonCpreFetchEn1 & df_nonC_8_i;

   //Removed the module dp_logicICU_isEA 
   assign dsEa[0:29] = ~EXE_dsEA_NEG[0:29];
   //Removed the module dp_logicICU_plbaLowBuf2 
   assign icuAdd[22:27] = ~ICU_ABus_NEG_i[22:27];
   //Removed the module icu_incPlba
   assign incOut[22:26] = icuAdd[22:26] + 5'b00001;
   // Removed the module dp_regICU_plbaLow 
   reg [0:7] regICU_plbaLow_DataOut;
   assign ICU_ABus_NEG_i[22:29] = ~regICU_plbaLow_DataOut;
   always @(posedge CB)  	
    begin				  	
    if (scL2)			
      case(plbLowSel[0:1])			
       2'b00: regICU_plbaLow_DataOut <= feedBack[0:7];	
       2'b01: regICU_plbaLow_DataOut <=  MMU_isRA[22:29];	
       2'b10: regICU_plbaLow_DataOut <= {incOut[22:26],1'b0, 1'b0, 1'b0};	
       2'b11: regICU_plbaLow_DataOut <= rdar_i[22:29];	
        default: regICU_plbaLow_DataOut <= 8'bx;  
      endcase		 		
    end			 		
   // Removed the module dp_regICU_plbaHigh 
   reg [0:23] regICU_plbaHigh_DataOut;
   reg U0Attr;
   reg dsEndian;
   assign {ICU_ABus_NEG_i[0:21], ICU_U0Attr_NEG_i, abusTLE_NEG} = ~regICU_plbaHigh_DataOut;
   always @(posedge CB)  	
    begin				  	
    if (scL2)			
      case( plbHighSel[0:1])			
       2'b00: regICU_plbaHigh_DataOut <= {ABus[0:21], AbusU0Attr, AbusTLE};	
       2'b01: regICU_plbaHigh_DataOut <= {isRABuf[0:21],MMU_isU0Attr, MMU_isEndian};	
       2'b10: regICU_plbaHigh_DataOut <= {24{1'b0}};	
       2'b11: regICU_plbaHigh_DataOut <= {rdar_i[0:21], U0Attr, dsEndian};	
        default: regICU_plbaHigh_DataOut <= 24'bx;  
      endcase		 		
    end			 		
   //Removed the module dp_muxICU_sprOut 
    assign sprOut_D1 = {Block_CAR_i, Block_LSA_i, Block_SAQ_i, Block_COF_i,
                        BlockFlush_i, Block_mult_req_i, ICU_dcuLNC_i, ICU_dcuLOA_i,
                        ICU_dcuWOA_i, DPP1_i, IPP0_i, IPP1_i,ICU_CCR0DPE_i, ICU_CCR0DPP_i,
                        ICU_CCR0DDK_i, ICU_LDBE_i, ICU_GPRC_i, ICU_traceDisable_i,
                        ICU_CCR0IPE_i, ICU_CCR0TPE_i, df_preFetchEnable_i, df_nonCpreFetchEn1_i,
                        df_nonC_8_i,df_ftchMissBlkWr_i, df_forceOnly1Req_i, 1'b0, 1'b0, ICU_tagDataSel_i,
                        ICU_paritySel_i, 1'b0, 1'b0, ICU_baSel_i} ;
    assign sprOut_D3 = {ICU_CCR1ICTE_i, ICU_CCR1ICDE_i, ICU_CCR1DCTE_i, ICU_CCR1DCDE_i, ICU_CCR1TLBE_i,
                        {27{1'b0}} };
   
    always @( sprMuxSel or EXE_sprData or sprOut_D1 or cdbdrData or sprOut_D3) 
    begin                                           
      case(sprMuxSel[0:1])                     
       2'b00: ICU_sprData[0:31] = EXE_sprData[0:31];    
       2'b01: ICU_sprData[0:31] = sprOut_D1;    
       2'b10: ICU_sprData[0:31] = cdbdrData[0:31];    
       2'b11: ICU_sprData[0:31] = sprOut_D3;    
        default: ICU_sprData[0:31] = 32'bx;   
      endcase                                    
    end        
    //Removed the module icu_spr_add_cmp
assign sel_ccr1_E2 = (~PCL_sprHold & EXE_icuSprDcds[2] & PCL_mtSPR) | resetCore ;
assign sel_cdbcr_E2 = (~PCL_sprHold & EXE_icuSprDcds[0] & PCL_mtSPR) | resetCore ;
assign df_selCCR0 = (EXE_icuSprDcds[0] & PCL_mtSPR) ;


assign sprMuxSel[0] = PCL_mfSPR & (EXE_icuSprDcds[1] | EXE_icuSprDcds[2]);
assign sprMuxSel[1] = PCL_mfSPR & (EXE_icuSprDcds[0] | EXE_icuSprDcds[2]);
   // Removed the module dp_regICU_cdbdr 
   always @(posedge CB)  	
    begin				  	
    if (cdbdrE1)			
      if (~resetCore)			
        cdbdrData[0:31] <= icReadData[0:31];	
      else
        cdbdrData[0:31] <= {1'b0, icuCacheSize[0:2],
              1'b0, DCU_icuSize[0:2],{24{1'b0}} };
   end			 		

   // Removed the module dp_regICU_cdbcr 
   always @(posedge CB)  	
    begin				  	
     if (sel_cdbcr_E2)		 	
      {ICU_paritySel_i, ICU_CCR0TPE_i, ICU_CCR0IPE_i, ICU_CCR0DPP_i, ICU_CCR0DPE_i,
       Block_CAR_i, Block_LSA_i, Block_SAQ_i, Block_COF_i, BlockFlush_i, Block_mult_req_i,
       ICU_dcuLNC_i, ICU_dcuLOA_i, ICU_dcuWOA_i, DPP1_NEG_i, IPP0_NEG_i, IPP1_NEG_i,
       ICU_CCR0DDK_i, ICU_LDBE_i, ICU_GPRC_i, ICU_traceDisable_i,
       df_preFetchEnable_i, df_nonCpreFetchEn1_i, df_nonC_8_i,
       df_ftchMissBlkWr_i, df_forceOnly1Req_i, ICU_tagDataSel_i, ICU_baSel_i} <= 
          {EXE_sprData[28],EXE_sprData[19],EXE_sprData[18],
           EXE_sprData[13],EXE_sprData[12],EXE_sprData[0:8], EXE_sprData_NEG[9:11],
           EXE_sprData[14:17],EXE_sprData[20:24], EXE_sprData[27], EXE_sprData[31]};		
   end			 		
   // Removed the module dp_regICU_ccr1 
   always @(posedge CB)  	
    begin				  	
    if (sel_ccr1_E2)		 	
      {ICU_CCR1ICTE_i, ICU_CCR1ICDE_i, ICU_CCR1DCTE_i, ICU_CCR1DCDE_i, ICU_CCR1TLBE_i} <= EXE_sprData[0:4];		
   end			 		
   //Removed the module dp_muxICU_CcWrAdd 
   assign df_lruWrCcIn[18:26] = fillWr0L2 ? vcarsCCL2[0:8] : vcar[18:26];
   // Removed the module dp_regICU_rars 
   always @(posedge CB)  	
    begin				  	
      case(rarsSel[0:1])			
       2'b00: ;	
       2'b01: {df_rars_i[0:21],df_rarsTLE} <= {isRABuf[0:21], MMU_isEndian};	
       2'b10: {df_rars_i[0:21],df_rarsTLE} <= {rdar_i[0:21], dsEndian};	
       2'b11: {df_rars_i[0:21],df_rarsTLE} <= {ABus[0:21], AbusTLE};	
        default: {df_rars_i[0:21],df_rarsTLE} <= 23'bx;  
      endcase		 		
   end			 		
   // Removed the module dp_regICU_rdar 
   always @(posedge CB)  	
    begin				  	
    if (icuRdarE1 & icuRdarE2)		
      {rdar_i[0:29], U0Attr, dsEndian} <= {MMU_rdarDsRAL2[0:29], MMU_dsU0AttrL2, MMU_dsEndianL2};		
   end			 		
   //Removed module icu_incVcars
    assign incVcars[22:26] = vcars[22:26] + 1 ;
   // Removed the module dp_regICU_Vcars 
   always @(posedge CB)  	
    begin				  	
      case(vcarsSel[0:1])			
       2'b00: ;	
       2'b01: {vcarsIR, vcars[0:26]} <= {vcarIR, vcar[0:26]};	
       2'b10: {vcarsIR, vcars[0:26]} <= {vcarspIR, {27{1'b0}} };	
       2'b11: {vcarsIR, vcars[0:26]} <= {vcarspIR, symNet812[0:26]};	
        default: {vcarsIR, vcars[0:26]} <= 28'bx;  
      endcase		 		
   end			 		
   //Removed module icu_incOverFlow
assign df_plbaOverflow = vcar[22:26] == 5'b11111 ;  
   //Removed module icu_compVcars
assign df_vcarVcarsCompare = {vcar[0:26], vcarIR} == {vcars[0:26], vcarsIR} ;
   //Removed module icu_incVcar
assign incVcarOut[18:26] = vcar[18:26] + 9'b000000001 ;

endmodule
