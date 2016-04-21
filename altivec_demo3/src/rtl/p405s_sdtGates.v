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

module p405s_sdtGates( aRegZ4dndSEIn, admAdderAInMuxSel, admAdderBInMuxSel,
     admCcMuxSel, macOVSat_NEG, macSatValue, PCL_addFour,
     PCL_exe2MacOrMultEnForMS, PCL_exe2MacOrMultEn_NEG, PCL_exe2MultEn,
     PCL_exe2MultHiWd, PCL_exe2SignedOp, PCL_exe2XerOvEn, PCL_exeCmplmntA_NEG,
     PCL_exeDivEnForMuxSel, PCL_exeMultEnForMuxSel, PCL_exeMultEn_NEG,
     adderOutBit0, cInBit1, cIn_1, divLastStOrSt0L2_1, divLastStOrSt0L2_NEG, dndSE_NEG,
     exe2MacProdSgndL2, exe2MacSatUnsigned, exe2Md16BitOprndL2, exe2Mr16BitOprndL2,
     macAccL2Bit0, potSOV, sumBit1 );
output  macOVSat_NEG;


input  PCL_addFour, PCL_exe2MultEn, PCL_exe2MultHiWd, PCL_exe2SignedOp, PCL_exe2XerOvEn,
     PCL_exeCmplmntA_NEG, adderOutBit0, cInBit1, cIn_1, divLastStOrSt0L2_1,
     divLastStOrSt0L2_NEG, dndSE_NEG, exe2MacProdSgndL2, exe2MacSatUnsigned,
     exe2Md16BitOprndL2, exe2Mr16BitOprndL2, macAccL2Bit0, potSOV, sumBit1;

output [0:4]  aRegZ4dndSEIn;
output [0:1]  admCcMuxSel;
output [0:1]  admAdderBInMuxSel;
output [0:2]  macSatValue;
output [0:1]  admAdderAInMuxSel;


input [0:1]  PCL_exeMultEn_NEG;
input [0:1]  PCL_exeMultEnForMuxSel;
input [0:1]  PCL_exe2MacOrMultEnForMS;
input [0:1]  PCL_exe2MacOrMultEn_NEG;
input [0:1]  PCL_exeDivEnForMuxSel;



   // Replacing instantiation: INVERT SDT_aRegZ4dndSE1
   wire symNet139;
   assign aRegZ4dndSEIn[0] = ~(symNet139);

   // Replacing instantiation: INVERT SDT_aRegZ4dndSE2
   assign aRegZ4dndSEIn[1] = ~(symNet139);

   // Replacing instantiation: INVERT SDT_aRegZ4dndSE3
   wire symNet135;
   assign aRegZ4dndSEIn[2] = ~(symNet135);

   // Replacing instantiation: INVERT SDT_aRegZ4dndSE4
   assign aRegZ4dndSEIn[3] = ~(symNet135);

   // Replacing instantiation: INVERT SDT_dndSE
   wire symNet268;
   assign symNet268 = ~(dndSE_NEG);

   // Replacing instantiation: INVERT I86
   wire symNet144;
   assign symNet144 = ~(PCL_addFour);

   // Replacing instantiation: INVERT SDT_exe2MultEnInv
   wire symNet90;
   assign symNet90 = ~(PCL_exe2MultEn);

   // Replacing instantiation: OA21 SDT_cc1_3
   wire symNet99;
   wire symNet95;
   wire symNet93;
   assign symNet93 = (PCL_exe2MultHiWd | symNet99) & symNet95;

   // Replacing instantiation: NAND3 SDT_cc1_2
   wire symNet109;
   assign symNet95 = ~( PCL_exe2MultEn & PCL_exe2MultHiWd & symNet109 );

   // Replacing instantiation: NAND3 SDT_cc1_1
   wire symNet103;
   assign symNet99 = ~( PCL_exe2XerOvEn & PCL_exe2MultEn & symNet103 );

   // Replacing instantiation: NOR2 SDT_not16BitOprnd
   assign symNet103 = ~( exe2Mr16BitOprndL2 | exe2Md16BitOprndL2 );

   // Replacing instantiation: OR2 SDT_16BitOprnd
   assign symNet109 = exe2Mr16BitOprndL2 | exe2Md16BitOprndL2;

   // Replacing instantiation: OR2 SDT_admCc0Sel
   wire symNet106;
   assign symNet106 = symNet90 | PCL_exe2MultHiWd;

   // Replacing instantiation: INVERT SDT_macProdSgndInv
   wire symNet162;
   assign symNet162 = ~(exe2MacProdSgndL2);

   // Replacing instantiation: INVERT SDT_dndSeNeg1
   assign symNet139 = ~(symNet268);

   // Replacing instantiation: INVERT SDT_dndSeNeg2
   assign symNet135 = ~(symNet268);

   // Replacing instantiation: XNOR2 SDT_macEq
   wire symNet128;
   assign symNet128 = ~( sumBit1 ^ macAccL2Bit0 );

   // Replacing instantiation: XOR2 SDT_macDiff
   wire symNet131;
   assign symNet131 = sumBit1 ^ macAccL2Bit0;

   // Replacing instantiation: MUX21I SDT_macSgndOVSatForCc
   wire symNet133;
   reg symNet158;
   wire symNet166;
   //Replace with mux to change from unknown with select unknown
   //to an input
   always @(symNet133 or cInBit1 or symNet166) begin
     case (cInBit1)
       1'b0 : symNet158 = ~symNet133;
       1'b1 : symNet158 = ~symNet166;
       default : symNet158 = ~symNet133;
     endcase
   end
   //assign symNet158 = ~( (symNet133 & ~(cInBit1)) | (symNet166 & cInBit1) );

   // Replacing instantiation: MUX21I SDT_macSgndOVSat
   reg symNet134;
   //Replace with mux to change from unknown with select unknown
   //to an input
   always @(symNet133 or cInBit1 or symNet166) begin
     case (cInBit1)
       1'b0 : symNet134 = ~symNet133;
       1'b1 : symNet134 = ~symNet166;
       default : symNet134 = ~symNet133;
     endcase
   end
   //assign symNet134 = ~( (symNet133 & ~(cInBit1)) | (symNet166 & cInBit1) );

   // Replacing instantiation: AOI21 SDT_macOvSatForCc
   wire symNet205;
   assign symNet205 = ~( (adderOutBit0 & exe2MacSatUnsigned) | symNet158 );

   // Replacing instantiation: AOI21 SDT_macOVSat
   assign macOVSat_NEG = ~( (adderOutBit0 & exe2MacSatUnsigned) | symNet134 );

   // Replacing instantiation: NAND3 SDT_admAdderBIn1DivPath
   wire symNet141;
   assign symNet141 = ~( PCL_exeDivEnForMuxSel[1] & divLastStOrSt0L2_NEG & cIn_1 );

   // Replacing instantiation: NAND2 SDT_admAdderBIn0DivPath
   wire symNet147;
   assign symNet147 = ~( PCL_exeDivEnForMuxSel[0] & divLastStOrSt0L2_1 );

   // Replacing instantiation: INVERT SDT_admAdderBIn0Exe2Path
   wire symNet149;
   assign symNet149 = ~(PCL_exe2MacOrMultEnForMS[0]);

   // Replacing instantiation: INVERT SDT_admAdderBIn0Exe1Path
   wire symNet151;
   assign symNet151 = ~(PCL_exeMultEnForMuxSel[0]);

   // Replacing instantiation: NOR2 SDT_admAdderBIn1MultPath
   wire symNet170;
   assign symNet170 = ~( PCL_exeMultEnForMuxSel[1] | PCL_exe2MacOrMultEnForMS[1] );

   // Replacing instantiation: NAND2 SDT_macBit1Diff
   assign symNet133 = ~( symNet131 & potSOV );

   // Replacing instantiation: NAND2 SDT_aRegZ4dndSE5
   assign aRegZ4dndSEIn[4] = ~( dndSE_NEG & symNet144 );

   // Replacing instantiation: NAND2 SDT_macBit1Eq
   assign symNet166 = ~( symNet128 & potSOV );

   // Replacing instantiation: NAND2 SDT_admAdderBInMuxSel1
   assign admAdderBInMuxSel[1] = ~( symNet170 & symNet141 );

   // Replacing instantiation: NAND2 SDT_macSatVal0
   assign macSatValue[0] = ~( PCL_exe2SignedOp & symNet162 );

   // Replacing instantiation: NAND2 SDT_macSatVal2
   assign macSatValue[2] = ~( PCL_exe2SignedOp & exe2MacProdSgndL2 );

   // Replacing instantiation: NAND2 SDT_macSatVal1
   assign macSatValue[1] = ~( PCL_exe2SignedOp & exe2MacProdSgndL2 );

   // Replacing instantiation: NAND2 SDT_admCcMuxSel1
   assign admCcMuxSel[1] = ~( symNet205 & symNet93 );

   // Replacing instantiation: NAND2 SDT_admCcMuxSel0
   assign admCcMuxSel[0] = ~( symNet205 & symNet106 );

   // Replacing instantiation: NAND2 SDT_admAdderAInMuxSel0
   assign admAdderAInMuxSel[0] = ~( PCL_exeMultEn_NEG[0] & PCL_exe2MacOrMultEn_NEG[0] );

   // Replacing instantiation: NAND3 SDT_admAdderBInMuxSel0
   assign admAdderBInMuxSel[0] = ~( symNet151 & symNet149 & symNet147 );

   // Replacing instantiation: NAND3 SDT_admAdderAInMuxSel1
   assign admAdderAInMuxSel[1] = ~( PCL_exeMultEn_NEG[1] & PCL_exe2MacOrMultEn_NEG[1] & PCL_exeCmplmntA_NEG );


endmodule
