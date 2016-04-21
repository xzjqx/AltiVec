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
// 08-03-01     JRS     1799    Added cycle_parity_p3_NEG  for generation of new ouptut
//                              cycleParityRegIn output, used to cycle the data parity RAM

module p405s_icu_hitPath( BufValidIn_NEG, ICU_mmuEoOdd, ICU_ocmIcuReady_NEG, VaVbRdSel,
     compAlru_NEG, compB_NEG, cycleDataRegAIn, cycleDataRegBIn, cycleParityRegIn, cycleTagRegIn,
     eo_0, eo_1, forceNlIn, lxFetchValidIn, lxSel, missIn, nxtFetchRd, nxtWait, rdStateIn,
     tagVSel_0, vcarSelHi_NEG, vcarSelLow_NEG, vcarSel_pri_NEG, wrLruIn, IFB_isAbort2,
     IFB_isNL, OCM_isHold, VaVb_VR_pg4_NEG, bufValidL2_NEG, compareA, compareA_NEG, compareB,
     compareB_NEG, cycle_RA_p3_NEG, cycle_RB_p3_NEG, cycle_parity_p3_NEG, cycle_RT_p3_NEG, eo_q, eo_r,
     eo_y_NEG, eo_z2_NEG, eo_z_NEG, forceNlL2, frAndDsRdy, ldcc2RdNoAb_NEG, lxFetchValidIn_A_NEG,
     lxFetchValidIn_B_NEG, lxFetchValidL2, lxSel_C_NEG, lxSel_D_NEG, missL2, nfr_ABC_p2_NEG,
     nxtWa_W_NEG, nxtWa_X_NEG, ocmDvQ_1_NEG, rdOrWaAndXltValid, rdSt_RDA_pg4_NEG, setForceNl,
     tagSelBit0_E_NEG, tagSelBit0_F_NEG, vcarSel_noEO, wrLruNoHit_NEG );

output  BufValidIn_NEG; 
output ICU_mmuEoOdd; 
output ICU_ocmIcuReady_NEG; 
output compAlru_NEG; 
output compB_NEG;
output cycleDataRegAIn; 
output cycleDataRegBIn; 
output cycleParityRegIn; 
output cycleTagRegIn; 
output eo_0; 
output eo_1; 
output forceNlIn;
output lxFetchValidIn; 
output lxSel; 
output missIn; 
output nxtFetchRd; 
output nxtWait; 
output rdStateIn; 
output tagVSel_0; 
output vcarSelHi_NEG;
output vcarSelLow_NEG; 
output vcarSel_pri_NEG;


input  IFB_isAbort2; 
input IFB_isNL; 
input OCM_isHold; 
input VaVb_VR_pg4_NEG; 
input bufValidL2_NEG; 
input compareA;
input compareA_NEG; 
input compareB; 
input compareB_NEG; 
input cycle_RA_p3_NEG; 
input cycle_RB_p3_NEG; 
input cycle_parity_p3_NEG;
input cycle_RT_p3_NEG; 
input eo_q; 
input eo_r; 
input eo_y_NEG; 
input eo_z2_NEG; 
input eo_z_NEG; 
input forceNlL2; 
input frAndDsRdy;
input ldcc2RdNoAb_NEG; 
input lxFetchValidIn_A_NEG; 
input lxFetchValidIn_B_NEG; 
input lxFetchValidL2; 
input lxSel_C_NEG;
input lxSel_D_NEG; 
input missL2; 
input nfr_ABC_p2_NEG; 
input nxtWa_W_NEG; 
input nxtWa_X_NEG; 
input ocmDvQ_1_NEG; 
input rdOrWaAndXltValid; 
input rdSt_RDA_pg4_NEG; 
input setForceNl; 
input tagSelBit0_E_NEG; 
input tagSelBit0_F_NEG; 
input vcarSel_noEO; 
input wrLruNoHit_NEG;

output [0:2]  wrLruIn;
output [0:2]  VaVbRdSel;

wire BufValidIn_NEG;
wire D_NEG;
wire ICU_mmuEoOdd;
wire ICU_ocmIcuReady_NEG;
wire IFB_isAbort2;
wire IFB_isAbort2_NEG;
wire IFB_isNL;
wire OCM_isHold;
wire VaVb_VR_pg4_NEG;
wire [0:2] VaVbRdSel;
wire [0:2] wrLruIn;
wire bufValidL2_NEG;
wire compAlru_NEG;
wire compAlru_NEG_i;
wire compB_NEG;
wire compare0;
wire compare2;
wire compareA;
wire compareA_NEG;
wire compareB;
wire compareB_NEG;
wire cycleDataRegAIn;
wire cycleDataRegBIn;
wire cycleParityRegIn;
wire cycleTagRegIn;
wire cycle_RA_p3_NEG;
wire cycle_RB_p3_NEG;
wire cycle_RT_p3_NEG;
wire cycle_parity_p3_NEG;
wire eo1_reset1_NEG;
wire eo1_reset2_NEG;
wire eo1_reset3_NEG;
wire eo1_reset4_NEG;
wire eo_0;
wire eo_1;
wire eo_q;
wire eo_r;
wire eo_r_NEG;
wire eo_y_NEG;
wire eo_z2_NEG;
wire eo_z_NEG;
wire fetchHitNotAbort_NEG;
wire fetchHit_NEG;
wire forceNlIn;
wire forceNlL2;
wire frAndDsRdy;
wire ldcc2RdNoAb_NEG;
wire lxFetchValidIn;
wire lxFetchValidIn_A_NEG;
wire lxFetchValidIn_B_NEG;
wire lxFetchValidL2;
wire lxSel;
wire lxSel_C_NEG;
wire lxSel_D_NEG;
wire missIn;
wire missL2;
wire muxSel;
wire muxSel2;
wire nfr_ABC_p2_NEG;
wire nxtFetchRd;
wire nxtFetchRd1_NEG;
wire nxtFetchRd2_NEG;
wire nxtFetchRd3_NEG;
wire nxtFetchRd4_NEG;
wire nxtFetchRd5_NEG;
wire nxtWa_W_NEG;
wire nxtWa_X_NEG;
wire nxtWait;
wire ocmDvQ_1_NEG;
wire rdOrWaAndXltValid;
wire rdStateIn;
wire setForceNl;
wire symNet218;
wire symNet220;
wire symNet221;
wire symNet223;
wire symNet224;
wire symNet226;
wire symNet228;
wire symNet233;
wire symNet237;
wire symNet251;
wire symNet253;
wire symNet275;
wire symNet302;
wire symNet307;
wire symNet314;
wire symNet320;
wire symNet336;
wire symNet344;
wire symNet350;
wire symNet358;
wire symNet362;
wire tagSelBit0_E_NEG;
wire tagSelBit0_F_NEG;
wire tagVSel_0;
wire vcarSelHi_NEG;
wire vcarSelLow_NEG;
wire vcarSel_noEO;
wire vcarSel_pri_NEG;
wire wrLruNoHit_NEG;

assign compAlru_NEG = compAlru_NEG_i;
//Removed the module dp_logicICU_issue175 
assign compB_NEG = ~(compareB & compAlru_NEG_i);
//Removed the module dp_logicICU_fixNand3_1 
assign muxSel2 = ~(symNet223 & IFB_isAbort2_NEG & ocmDvQ_1_NEG);
//Removed the module dp_logicICU_fixNand2_3
assign symNet223 = ~(symNet221 & symNet226);
//Removed the module dp_logicICU_fixNand2_2
assign symNet226 = ~(eo_z2_NEG & missL2);
//Removed the module dp_logicICU_fixNand2_1
assign symNet221 = ~(eo_r_NEG & eo_z2_NEG);
//Removed the module dp_logicICU_lruBitInv
assign compAlru_NEG_i = ~compareA;
//Removed the module dp_logicICU_nand2_44
assign VaVbRdSel[2] = ~(nxtFetchRd5_NEG & VaVb_VR_pg4_NEG);
//Removed the module dp_logicICU_nand2_43
assign VaVbRdSel[1] = ~(nxtFetchRd5_NEG & VaVb_VR_pg4_NEG);
//Removed the module dp_logicICU_nor2_28
assign nxtFetchRd5_NEG = ~(symNet220 | symNet218);
//Removed the module dp_logicICU_nor2_27
assign symNet220 = ~(D_NEG | eo1_reset2_NEG);
//Removed the module dp_logicICU_nand2_pg13
assign symNet224 = ~(eo1_reset4_NEG & lxFetchValidL2);
//Removed the module dp_logicICU_Inv_pg13
assign ICU_ocmIcuReady_NEG = ~symNet224;
//Removed the module dp_logicICU_Inv_pg12
assign symNet228 = ~OCM_isHold;
//Removed the module dp_logicICU_mux21I_pg12 
//assign nxtWait = (~nxtWa_W_NEG & ~symNet233) | (~nxtWa_X_NEG & symNet233);
assign nxtWait = symNet233 ? ~nxtWa_X_NEG : ~nxtWa_W_NEG;
//Removed the module dp_logicICU_nand3_pg12
assign symNet233 = ~(eo1_reset4_NEG & symNet228 & ocmDvQ_1_NEG);
//Removed the module dp_logicICU_nor2_03_pg10
assign vcarSelLow_NEG = ~(symNet237 | vcarSel_noEO);
//Removed the module dp_logicICU_nor2_02_pg10
assign vcarSelHi_NEG = ~(symNet237 | vcarSel_noEO);
//Removed the module dp_logicICU_nor2_01_pg10
assign vcarSel_pri_NEG = ~(symNet237 | vcarSel_noEO);
//Removed the module dp_logicICU_nor3_pg10
assign symNet237 = ~(eo1_reset4_NEG | symNet253 | symNet251);
//Removed the module dp_logicICU_Inv_02_pg10
assign symNet251 = ~IFB_isNL;
//Removed the module dp_logicICU_Inv_01_pg10 
assign symNet253 = ~frAndDsRdy;
//Removed the module dp_logicICU_mux21_81 
//assign {lxFetchValidIn, lxSel, tagVSel_0} = ((~{lxFetchValidIn_A_NEG, lxSel_C_NEG, tagSelBit0_E_NEG} &
//                                               ~{muxSel, muxSel, muxSel2}) | 
//                                              (~{lxFetchValidIn_B_NEG, lxSel_D_NEG, tagSelBit0_F_NEG} &
//                                                {muxSel, muxSel, muxSel2}));
assign lxFetchValidIn = muxSel ? ~lxFetchValidIn_B_NEG : ~lxFetchValidIn_A_NEG;
assign lxSel = muxSel ? ~lxSel_D_NEG : ~lxSel_C_NEG;
assign tagVSel_0 = muxSel2 ? ~tagSelBit0_F_NEG : ~tagSelBit0_E_NEG;
//Removed the module dp_logicICU_nand3_81 
assign muxSel = ~(eo1_reset3_NEG & IFB_isAbort2_NEG & ocmDvQ_1_NEG);
//Removed the module dp_logicICU_nand2_63 
assign wrLruIn[2] = ~(wrLruNoHit_NEG & fetchHitNotAbort_NEG);
//Removed the module dp_logicICU_nand2_62 
assign wrLruIn[1] = ~(wrLruNoHit_NEG & fetchHitNotAbort_NEG);
//Removed the module dp_logicICU_nand2_61 
assign wrLruIn[0] = ~(wrLruNoHit_NEG & fetchHitNotAbort_NEG);
//Removed the module dp_logicICU_inv_51 
assign nxtFetchRd = ~nxtFetchRd2_NEG;
//Removed the module dp_logicICU_nand2_51 
assign symNet275 = ~(bufValidL2_NEG & fetchHit_NEG);
//Removed the module dp_logicICU_nand3_51 
assign BufValidIn_NEG = ~(nxtFetchRd2_NEG & ldcc2RdNoAb_NEG & symNet275);
//Removed the module dp_logicICU_nand2_42 
assign VaVbRdSel[0] = ~(nxtFetchRd3_NEG & VaVb_VR_pg4_NEG);
//Removed the module dp_logicICU_nand2_41 
assign rdStateIn = ~(nxtFetchRd3_NEG & rdSt_RDA_pg4_NEG);
//Removed the module dp_logicICU_aor21_41 
assign forceNlIn = (nxtFetchRd4_NEG & forceNlL2) | setForceNl;
//Removed the module dp_logicICU_nand_33 
assign cycleTagRegIn = ~(nxtFetchRd4_NEG & cycle_RT_p3_NEG);
//Removed the module dp_logicICU_nand_32 
assign cycleDataRegBIn = ~(nxtFetchRd1_NEG & cycle_RB_p3_NEG);
//Removed the module dp_logicICU_nand_31 
assign cycleDataRegAIn = ~(nxtFetchRd1_NEG & cycle_RA_p3_NEG);
//Removed the module dp_logicICU_nand_parityCycle 
assign cycleParityRegIn = ~(nxtFetchRd1_NEG & cycle_parity_p3_NEG);
//Removed the module dp_logicICU_nand_24 
assign D_NEG = ~(IFB_isNL & frAndDsRdy);
//Removed the module dp_logicICU_nand_23 
assign symNet218 = ~(symNet302 & nfr_ABC_p2_NEG);
//Removed the module dp_logicICU_nand_22 
assign symNet307 = ~(symNet302 & nfr_ABC_p2_NEG);
//Removed the module dp_logicICU_nand_21 
assign symNet302 = ~(frAndDsRdy & IFB_isAbort2);
//Removed the module dp_logicICU_nor2_26 
assign symNet314 = ~(D_NEG | eo1_reset2_NEG);
//Removed the module dp_logicICU_nor2_25 
assign nxtFetchRd4_NEG = ~(symNet314 | symNet218);
//Removed the module dp_logicICU_nor2_24 
assign nxtFetchRd3_NEG = ~(symNet314 | symNet218);
//Removed the module dp_logicICU_nor2_23 
assign nxtFetchRd2_NEG = ~(symNet320 | symNet307);
//Removed the module dp_logicICU_nor2_22 
assign nxtFetchRd1_NEG = ~(symNet320 | symNet307);
//Removed the module dp_logicICU_nor2_21 
assign symNet320 = ~(D_NEG | eo1_reset1_NEG);
//Removed the module dp_logicICU_inv_03 
assign IFB_isAbort2_NEG = ~IFB_isAbort2;
//Removed the module dp_logicICU_inv_02 
assign missIn = ~symNet336;
//Removed the module dp_logicICU_nand3_03 
assign fetchHitNotAbort_NEG = ~(symNet336 & IFB_isAbort2_NEG & rdOrWaAndXltValid);  
//Removed the module dp_logicICU_nand2_08 
assign fetchHit_NEG = ~(symNet336 & rdOrWaAndXltValid);
//Removed the module dp_logicICU_nand2_07 
assign symNet344 = ~(eo_r_NEG & eo_z2_NEG);
//Removed the module dp_logicICU_nand2_06 
assign eo1_reset4_NEG = ~(symNet358 & symNet344);
//Removed the module dp_logicICU_nand2_05 
assign eo1_reset3_NEG = ~(symNet358 & symNet344);
//Removed the module dp_logicICU_nand2_04 
assign eo1_reset2_NEG = ~(symNet362 & symNet350);
//Removed the module dp_logicICU_nand2_03 
assign eo1_reset1_NEG = ~(symNet362 & symNet350);
//Removed the module dp_logicICU_nand2_02 
assign symNet336 = ~(compareA_NEG & compareB_NEG);
//Removed the module dp_logicICU_nand3_02 
assign symNet358 = ~(compareA_NEG & compareB_NEG & eo_z2_NEG);
//Removed the module dp_logicICU_nand3_01 
assign symNet362 = ~(compareA_NEG & compareB_NEG & eo_z2_NEG);  
//Removed the module dp_logicICU_inv_01 
assign eo_r_NEG = ~eo_r;
//Removed the module dp_logicICU_nand2_01 
assign symNet350 = ~(eo_r_NEG & eo_z2_NEG);
//Removed the module dp_logicICU_compNand2_1 
assign eo_0 = ~(eo_y_NEG & compare0);
//Removed the module dp_logicICU_compNand2_2 
assign eo_1 = ~(eo_z_NEG & compare2);
//Removed the module dp_logicICU_compNand2_3 
assign ICU_mmuEoOdd = ~(eo_z_NEG & compare2);
//Removed the module dp_logicICU_compAOI22_1 
assign compare0 = ~( ( compareA & eo_q) | ( compareB & eo_q));
//Removed the module dp_logicICU_compAOI22_2 
assign compare2 = ~( (compareA &  eo_r) | (compareB & eo_r) );

endmodule
