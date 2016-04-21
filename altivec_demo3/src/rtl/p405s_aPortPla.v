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
//  from espresso format file on Wed May 12 16:15:50 EDT 1999
// modulename is aPortPla
// input file is aPortPla.pers
// output file is aPortPla.v
// espresso will be called.
// ##########################
// #                        #
// #  aPortPla  personality #
// #                        #
// ##########################
//
// # the types are:
// #.f    ones=1 , zero= comp ones, dcs = null
// #        this is like a regular PLA
// #.fd   dcs = -, ones = 1 without -, zero = comp(dcs union ones)
// #        all unlisted input combinations produce a 0 output
// #        note that if an output is covered by both a - and 1, it is -
// #.fr   ones = 1, zero=0, dcs= comp(ones union zero)
// #        all unlisted input combinations are don't cares
// #        note that if an output is covered by both a 0 and 1, it is error
// #.fdr  ones = 1, zero=0, dcs=-
// #        all unlisted input combinations are ?
// #        does not say what happens if overlapping covers
// #
// .outputnames dcdApMuxSel
// .inputnames priOp[0:5] secOp[21:31]
// .type fd
// .i 17
// .o 1
// # History:
// # 01/14/98 Created.
// # 01/09/99 SBP Changed the secondaryOp of instr machhws from 118 to 108.
// #
// #  NOTE 1) Added the floating point Instr to 401 dcdPla to create this PLA.
// #
// #  NOTE 2) plaCoproc is the coprocessor instruction enable signal. This pla activates this signal for the IBM portion of the#
// #          sandbox ops and for mult/div instructions that are to be coprocessor driven as indicated by the mult and div enable
// #          inputs.
// #
// #  NOTE 3) Predecode the Opcode bit to help timing on Address Select.
// #          preDcdApPriOp = ~priOp[0] & priOp[1] & priOp[3] & priOp[5]
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21  - I30C   PriOp            |  0
// #-----     -----------   ----                -
// #MAC Instructions
// # machhwu  RT,RA,RB  PRI = 4  SEC = 12
// 000100     -000001100-                       0
// # machhw   RT,RA,RB  PRI = 4  SEC = 44
// 000100     -000101100-                       0
// # machhwsu RT,RA,RB  PRI = 4  SEC = 76
// 000100     -001001100-                       0
// # machhws  RT,RA,RB  PRI = 4  SEC = 108
// 000100     -001101100-                       0
// # maclhwu  RT,RA,RB  PRI = 4  SEC = 396
// 000100     -110001100-                       0
// # maclhw   RT,RA,RB  PRI = 4  SEC = 428
// 000100     -110101100-                       0
// # maclhwsu RT,RA,RB  PRI = 4  SEC = 460
// 000100     -111001100-                       0
// # maclhws  RT,RA,RB  PRI = 4  SEC = 492
// 000100     -111101100-                       0
// # macchwu  RT,RA,RB  PRI = 4  SEC = 140
// 000100     -010001100-                       0
// # macchw   RT,RA,RB  PRI = 4  SEC = 172
// 000100     -010101100-                       0
// # macchwsu RT,RA,RB  PRI = 4  SEC = 204
// 000100     -011001100-                       0
// # macchws  RT,RA,RB  PRI = 4  SEC = 236
// 000100     -011101100-                       0
// # mulhhwu  RT,RA,RB  PRI = 4  SEC = 8
// 000100     0000001000-                       0
// # mulhhw   RT,RA,RB  PRI = 4  SEC = 40
// 000100     0000101000-                       0
// # mullhwu  RT,RA,RB  PRI = 4  SEC = 392
// 000100     0110001000-                       0
// # mullhw   RT,RA,RB  PRI = 4  SEC = 424
// 000100     0110101000-                       0
// # mulchwu  RT,RA,RB  PRI = 4  SEC = 136
// 000100     0010001000-                       0
// # mulchw   RT,RA,RB  PRI = 4  SEC = 168
// 000100     0010101000-                       0
// # nmachhw  RT,RA,RB  PRI = 4  SEC = 46
// 000100     -000101110-                       0
// # nmaclhw  RT,RA,RB  PRI = 4  SEC = 430
// 000100     -110101110-                       0
// # nmacchw  RT,RA,RB  PRI = 4  SEC = 174
// 000100     -010101110-                       0
// # nmachhws RT,RA,RB  PRI = 4  SEC = 110
// 000100     -001101110-                       0
// # nmaclhws RT,RA,RB  PRI = 4  SEC = 494
// 000100     -111101110-                       0
// # nmacchws RT,RA,RB  PRI = 4  SEC = 238
// 000100     -011101110-                       0
// #
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21    I30C   PriOp            |  0
// #-----     -----------   ----                -
// #Fixed Point Arithmetic Instructions
// #   addi   RT,RA.SI  PRI = 14 SEC = None
// 001110     -----------                       0
// #   addis  RT,RA,SI  PRI = 15 SEC = None
// 001111     -----------                       0
// #   add    RT,RA,RB  PRI = 31 SEC = 266
// 011111     -100001010-                       0
// #   subf   RT,RA,RB  PRI = 31 SEC =  40
// 011111     -000101000-                       0
// #   addic  RT,RA,SI  PRI = 12 SEC = None
// 001100     -----------                       0
// #   addic. RT,RA,SI  PRI = 13 SEC = None
// 001101     -----------                       0
// #   subfic RT,RA,SI  PRI =  8 SEC = None
// 001000     -----------                       0
// #   addc   RT,RA,RB  PRI = 31 SEC =  10
// 011111     -000001010-                       0
// #   subfc  RT,RA,RB  PRI = 31 SEC =   8
// 011111     -000001000-                       0
// #   adde   RT,RA,RB  PRI = 31 SEC = 138
// 011111     -010001010-                       0
// #   subfe  RT,RA,RB  PRI = 31 SEC = 136
// 011111     -010001000-                       0
// #   addme  RT,RA     PRI = 31 SEC = 234
// 011111     -011101010-                       0
// #   subfme RT,RA     PRI = 31 SEC = 232
// 011111     -011101000-                       0
// #   addze  RT,RA     PRI = 31 SEC = 202
// 011111     -011001010-                       0
// #   subfze RT,RA     PRI = 31 SEC = 200
// 011111     -011001000-                       0
// #   neg    RT,RA     PRI = 31 SEC = 104
// 011111     -001101000-                       0
// #   mulli  RT,RA,SI  PRI =  7 SEC = None
// 000111     -----------                       0
// #   mullw  RT,RA,RB  PRI = 31 SEC = 235
// 011111     -011101011-                       0
// #   mulhw  RT,RA,RB  PRI = 31 SEC =  75
// 011111     0001001011-                       0
// #   mulhwu RT,RA,RB  PRI = 31 SEC =  11
// 011111     0000001011-                       0
// #   divw   RT,RA,RB  PRI = 31 SEC = 491
// 011111     -111101011-                       0
// #   divwu  RT,RA,RB  PRI = 31 SEC = 459
// 011111     -111001011-                       0
// #
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21    I30C   PriOp            |  0
// #-----     -----------   ----                -
// # Fixed Point Compare Instruction
// #   cmpwi  BF,RA,SI  PRI = 11 SEC = None
// 001011     -----------                       0
// #   cmpw   BF,RA,RB  PRI = 31 SEC =   0
// 011111     0000000000-                       0
// #   cmplwi BF,RA,UI  PRI = 10 SEC = None
// 001010     -----------                       0
// #   cmplw  BF,RA,RB  PRI = 31 SEC =  32
// 011111     0000100000-                       0
// # Fixed Point Trap Instructions
// #   twi    TO,RA,SI  PRI =  3 SEC = None
// 000011     -----------                       0
// #   tw     TO,RA,RB  PRI = 31 SEC =   4
// 011111     0000000100-                       0
// # Fixed Point Logical Instruction
// #   andi.  RA,RS,UI  PRI = 28 SEC = None
// 011100     -----------                       1
// #   andis. RA,RS,UI  PRI = 29 SEC = None
// 011101     -----------                       1
// #--1-0-     -----------   1                   1
// #   ori    RA,RS,UI  PRI = 24 SEC = None
// 011000     -----------                       1
// #   oris   RA,RS,UI  PRI = 25 SEC = None
// 011001     -----------                       1
// #   xori   RA,RS,UI  PRI = 26 SEC = None
// 011010     -----------                       1
// #   xoris  RA,RS,UI  PRI = 27 SEC = None
// 011011     -----------                       1
// #   and    RA,RS,RB  PRI = 31 SEC =  28
// 011111     0000011100-                       1
// #--1-1-     0000011100-   1                   1
// #   or     RA,RS,RB  PRI = 31 SEC = 444
// 011111     0110111100-                       1
// #--1-1-     0110111100-   1                   1
// #   xor    RA,RS,RB  PRI = 31 SEC = 316
// 011111     0100111100-                       1
// #--1-1-     0100111100-   1                   1
// #   nand   RA,RS,RB  PRI = 31 SEC = 476
// 011111     0111011100-                       1
// #--1-1-     0111011100-   1                   1
// #   nor    RA,RS,RB  PRI = 31 SEC = 124
// 011111     0001111100-                       1
// #--1-1-     0001111100-   1                   1
// #   eqv    RA,RS,RB  PRI = 31 SEC = 284
// 011111     0100011100-                       1
// #--1-1-     0100011100-   1                   1
// #   andc   RA,RS,RB  PRI = 31 SEC =  60
// 011111     0000111100-                       1
// #--1-1-     0000111100-   1                   1
// #   orc    RA,RS,RB  PRI = 31 SEC = 412
// 011111     0110011100-                       1
// #--1-1-     0110011100-   1                   1
// #   extsb  RA,RS     PRI = 31 SEC = 954
// 011111     1110111010-                       1
// #--1-1-     1110111010-   1                   1
// #   extsh  RA,RS     PRI = 31 SEC = 922
// 011111     1110011010-                       1
// #--1-1-     1110011010-   1                   1
// #   cntlzw RA,RS     PRI = 31 SEC =  26
// 011111     0000011010-                       1
// #--1-1-     0000011010-   1                   1
// #   dlmzb  RA,RS,RB  PRI = 31 SEC =  78
// 011111     0001001110-                       1
// #--1-1-     0001001110-   1                   1
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                         Pre             |  APort
// #                         Decode          |  Ad
// #Op        ExtOp     R    Aport           |  Mx
// #I0-I5     I21  - I30C    PriOp           |  0
// #-----     -----------    ----               -
// # Fixed Point Rotate and Shift Instructions
// # rlwinm RA,RS,SH,MB,ME PRI = 21 SEC = None
// 010101     -----------                       1
// #--0-0-     -----------   1                   1
// # rlwnm  RA,RS,RB,MB,ME PRI = 23 SEC = None
// 010111     -----------                       1
// #--0-1-     -----------   1                   1
// # rlwimi RA,RS,SH,MB,ME PRI = 20 SEC = None
// 010100     -----------                       1
// # slw    RA,RS,RB       PRI = 31 SEC =  24
// 011111     0000011000-                       1
// #--1-1-     0000011000-   1                   1
// # srw    RA,RS,RB       PRI = 31 SEC = 536
// 011111     1000011000-                       1
// #--1-1-     1000011000-   1                   1
// # srawi  RA,RS,SH       PRI = 31 SEC = 824
// 011111     1100111000-                       1
// #--1-1-     1100111000-   1                   1
// # sraw   RA,RS,RB       PRI = 31 SEC = 792
// 011111     1100011000-                       1
// #--1-1-     1100011000-   1                   1
// #
// # CR Logical Instructions
// #   crand  BT,BA,BB  PRI = 19 SEC = 257
// 010011     0100000001-                       ~
// #   cror   BT,BA,BB  PRI = 19 SEC = 449
// 010011     0111000001-                       ~
// #   crxor  BT,BA,BB  PRI = 19 SEC = 193
// 010011     0011000001-                       ~
// #   crnand BT,BA,BB  PRI = 19 SEC = 225
// 010011     0011100001-                       ~
// #   crnor  BT,BA,BB  PRI = 19 SEC =  33
// 010011     0000100001-                       ~
// #   creqv  BT,BA,BB  PRI = 19 SEC = 289
// 010011     0100100001-                       ~
// #   crandc BT,BA,BB  PRI = 19 SEC = 129
// 010011     0010000001-                       ~
// #   crorc  BT,BA,BB  PRI = 19 SEC = 417
// 010011     0110100001-                       ~
// #   mcrf   BF,BFA    PRI = 19 SEC =   0
// 010011     0000000000-                       ~
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21  - I30C   PriOp            |  0
// #-----     -----------   ----                -
// # Fixed Point Load Instructions
// #   lbz   RT,D(RA)   PRI = 34 SEC = None
// 100010     -----------                       0
// #   lbzu  RT,D(RA)   PRI = 35 SEC = None
// 100011     -----------                       0
// #   lbzx  RT,RA,RB   PRI = 31 SEC =  87
// 011111     0001010111-                       0
// #   lbzux RT,RA,RB   PRI = 31 SEC = 119
// 011111     0001110111-                       0
// #   lhz   RT,D(RA)   PRI = 40 SEC = None
// 101000     -----------                       0
// #   lhzu  RT,D(RA)   PRI = 41 SEC = None
// 101001     -----------                       0
// #   lhzx  RT,RA,RB   PRI = 31 SEC = 279
// 011111     0100010111-                       0
// #   lhzux RT,RA,RB   PRI = 31 SEC = 311
// 011111     0100110111-                       0
// #   lha   RT,D(RA)   PRI = 42 SEC = None
// 101010     -----------                       0
// #   lhau  RT,D(RA)   PRI = 43 SEC = None
// 101011     -----------                       0
// #   lhax  RT,RA,RB   PRI = 31 SEC = 343
// 011111     0101010111-                       0
// #   lhaux RT,RA,RB   PRI = 31 SEC = 375
// 011111     0101110111-                       0
// #   lwz   RT,D(RA)   PRI = 32 SEC = None
// 100000     -----------                       0
// #   lwzu  RT,D(RA)   PRI = 33 SEC = None
// 100001     -----------                       0
// #   lwzx  RT,RA,RB   PRI = 31 SEC =  23
// 011111     0000010111-                       0
// #   lwzux RT,RA,RB   PRI = 31 SEC =  55
// 011111     0000110111-                       0
// #
// # Fixed Point Store Instructions
// #   stb   RS,D(RA)   PRI = 38 SEC = None
// 100110     -----------                       0
// #   stbu  RS,D(RA)   PRI = 39 SEC = None
// 100111     -----------                       0
// #   stbx  RS,RA,RB   PRI = 31 SEC = 215
// 011111     0011010111-                       0
// #   stbux RS,RA,RB   PRI = 31 SEC = 247
// 011111     0011110111-                       0
// #   sth   RS,D(RA)   PRI = 44 SEC = None
// 101100     -----------                       0
// #   sthu  RS,D(RA)   PRI = 45 SEC = None
// 101101     -----------                       0
// #   sthx  RS,RA,RB   PRI = 31 SEC = 407
// 011111     0110010111-                       0
// #   sthux RS,RA,RB   PRI = 31 SEC = 439
// 011111     0110110111-                       0
// #   stw   RS,D(RA)   PRI = 36 SEC = None
// 100100     -----------                       0
// #   stwu  RS,D(RA)   PRI = 37 SEC = None
// 100101     -----------                       0
// #   stwx  RS,RA,RB   PRI = 31 SEC = 151
// 011111     0010010111-                       0
// #   stwux RS,RA,RB   PRI = 31 SEC = 183
// 011111     0010110111-                       0
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21  - I30C   PriOp            |  0
// #-----     -----------   ----                -
// # Fixed Point Load and Store with Byte Reversal
// #   lhbrx  RT,RA,RB  PRI = 31 SEC = 790
// 011111     1100010110-                       0
// #   lwbrx  RT,RA,RB  PRI = 31 SEC = 534
// 011111     1000010110-                       0
// #   sthbrx RS,RA,RB  PRI = 31 SEC = 918
// 011111     1110010110-                       0
// #   stwbrx RS,RA,RB  PRI = 31 SEC = 662
// 011111     1010010110-                       0
// #
// # Fixed Point Load and Store Multiple Instructions
// #   lmw  RT,D(RA)    PRI = 46 SEC = None
// 101110     -----------                       0
// #   stmw RS,D(RA)    PRI = 47 SEC = None
// 101111     -----------                       0
// #
// # Fixed Point Move Assist Instructions
// #   lswi  RT,RA,NB   PRI = 31 SEC = 597
// 011111     1001010101-                       0
// #   lswx  RT,RA,RB   PRI = 31 SEC = 533
// 011111     1000010101-                       0
// #   stswi RS,RA,NB   PRI = 31 SEC = 725
// 011111     1011010101-                       0
// #   stswx RS,RA,RB   PRI = 31 SEC = 661
// 011111     1010010101-                       0
// #
// # Storage Synchronization Instructions
// #   lwarx  RT,RA,RB  PRI = 31 SEC =  20
// 011111     0000010100-                       0
// #   stwcx. RS,RA,RB  PRI = 31 SEC = 150
// 011111     00100101101                       0
// #   sync             PRI = 31 SEC = 598
// 011111     1001010110-                       ~
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21  - I30C   PriOp            |  0
// #-----     -----------   ----                -
// # Miscellaneous Instructions
// #   mtcrf  FXM,RS    PRI = 31 SEC = 144
// 011111     0010010000-                       1
// #--1-1-     0010010000-   1                   1
// #   mfcr   RT        PRI = 31 SEC =  19
// 011111     0000010011-                       ~
// #   mcrxr  BF        PRI = 31 SEC = 512
// 011111     1000000000-                       ~
// #   mfspr  RT,SPR    PRI = 31 SEC = 339,371
// 011111     0101-10011-                       ~
// #   mtspr  SPR,RS    PRI = 31 SEC = 467
// 011111     0111010011-                       1
// #--1-1-     0111010011-   1                   1
// #   mfdcr  RT,DCR    PRI = 31 SEC = 323
// 011111     0101000011-                       ~
// #   mtdcr  DCR,RS    PRI = 31 SEC = 451
// 011111     0111000011-                       1
// #--1-1-     0111000011-   1                   1
// #   mfmsr  RT        PRI = 31 SEC = 339
// 011111     0001010011-                       ~
// #   mtmsr  RS        PRI = 31 SEC = 467
// 011111     0010010010-                       1
// #--1-1-     0010010010-   1                   1
// #
// #  system call
// #   sc               PRI = 17 SEC =   1
// 010001     ---------1-                       ~
// #
// # Interrupt Control Instructions
// #   rfi              PRI = 19 SEC =  50
// 010011     0000110010-                       ~
// #   rfci             PRI = 19 SEC =  51
// 010011     0000110011-                       ~
// #   wrtee  RS        PRI = 31 SEC = 131
// 011111     0010000011-                       1
// #--1-1-     0010000011-   1                   1
// #   wrteei E         PRI = 31 SEC = 163
// 011111     0010100011-                       ~
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  Mx
// #I0-I5     I21  - I30C   PriOp            |  0
// #-----     -----------   ----                -
// # Storage Control Instructions
// #   eieio            PRI = 31 SEC = 854
// 011111     1101010110-                       ~
// #   isync            PRI = 19 SEC = 150
// 010011     0010010110-                       ~
// #   dcbt   RA,RB     PRI = 31 SEC = 278
// 011111     0100010110-                       0
// #   dcbtst RA,RB     PRI = 31 SEC = 246
// 011111     0011110110-                       0
// #   dcbz/dcba   RA,RB  PRI = 31  SEC =1014/75
// 011111     1-11110110-                       0
// #   dcbst  RA,RB     PRI = 31 SEC =  54
// 011111     0000110110-                       0
// #   dcbf   RA,RB     PRI = 31 SEC =  86
// 011111     0001010110-                       0
// #   dcbi   RA,RB     PRI = 31 SEC = 470
// 011111     0111010110-                       0
// #   dccci  RA,RB     PRI = 31 SEC = 454
// 011111     0111000110-                       0
// #   dcread RT,RA,RB  PRI = 31 SEC = 486
// 011111     0111100110-                       0
// #   icbt   RA,RB     PRI = 31 1EC = 262
// 011111     0100000110-                       0
// #   icbi   RA,RB     PRI = 31 SEC = 982
// 011111     1111010110-                       0
// #   iccci  RA,RB     PRI = 31 SEC = 965
// 011111     1111000110-                       0
// #   icread RA,RB     PRI = 31 SEC = 998
// 011111     1111100110-                       0
// #
// #
// # TLB instructions
// # tlbia              PRI = 31 SEC = 370
// 011111     0101110010-                       ~
// # tlbsx(.) RT,RA,RB  PRI = 31 SEC = 914
// 011111     1110010010-                       0
// # tlbre    RT,RA,WS  PRI = 31 SEC = 946
// 011111     1110110010-                       ~
// # tlbwe    RS,RA,WS  PRI = 31 SEC = 978
// 011111     1111010010-                       1
// #--1-1-     1111010010-   1                   1
// # tlbsync            PRI = 31 SEC = 566
// 011111     1000110110-                       ~
// #
// # Branches
// # b                  PRI = 18 SEC = None
// 010010     -----------                       ~
// # bc                 PRI = 16 SEC = None
// 010000     -----------                       ~
// # bclr               PRI = 19 SEC =  16
// 010011     0000010000-                       ~
// # bcctr              PRI = 19 SEC = 528
// 010011     1000010000-                       ~
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                        Pre              |  APort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Aport            |  En
// #I0-I5     I21  - I30C   Op               |  0
// #-----     -----------   ------           -
// # Float Point Load and Store Instructions
// #   lfs    FRT,D(RA) PRI = 48 SEC = None
// 110000     -----------                       0
// #   lfsx   FRT,RA,RB PRI = 31 SEC = 535
// 011111     1000010111-                       0
// #   lfsu   FRT,D(RA) PRI = 49 SEC = None
// 110001     -----------                       0
// #   lfsux  FRT,RA,RB PRI = 31 SEC = 567
// 011111     1000110111-                       0
// #   lfd    FRT,D(RA) PRI = 50 SEC = None
// 110010     -----------                       0
// #   lfdx   FRT,RA,RB PRI = 31 SEC = 599
// 011111     1001010111-                       0
// #   lfdu   FRT,D(RA) PRI = 51 SEC = None
// 110011     -----------                       0
// #   lfdux  FRT,RA,RB PRI = 31 SEC = 631
// 011111     1001110111-                       0
// #   stfs   FRS,D(RA) PRI = 52 SEC = None
// 110100     -----------                       0
// #   stfsx  FRS,RA,RB PRI = 31 SEC = 663
// 011111     1010010111-                       0
// #   stfsu  FRS,D(RA) PRI = 53 SEC = None
// 110101     -----------                       0
// #   stfsux FRS,RA,RB PRI = 31 SEC = 695
// 011111     1010110111-                       0
// #   stfd   FRS,D(RA) PRI = 54 SEC = None
// 110110     -----------                       0
// #   stfdx  FRS,RA,RB PRI = 31 SEC = 727
// 011111     1011010111-                       0
// #   stfdu  FRS,D(RA) PRI = 55 SEC = None
// 110111     -----------                       0
// #   stfdux FRS,RA,RB PRI = 31 SEC = 759
// 011111     1011110111-                       0
// #   stfiwx FRS,RA,RB PRI = 31 SEC = 983
// 011111     1111010111-                       0
// #
// # VMX Load/Store Instructions
// #   lvebx VT,RA,RB   PRI = 31 SEC =   7
// 011111     0000000111-                       0
// #   lvehx VT,RA,RB   PRI = 31 SEC =  39
// 011111     0000100111-                       0
// #   lvewx VT,RA,RB   PRI = 31 SEC =  71
// 011111     0001000111-                       0
// #   lvx   VT,RA,RB   PRI = 31 SEC = 103
// 011111     0001100111-                       0
// #   lvxl  VT,RA,RB   PRI = 31 SEC = 359
// 011111     0101100111-                       0
// #   stvebx VS,RA,RB   PRI = 31 SEC = 135
// 011111     0010000111-                       0
// #   stvehx VS,RA,RB   PRI = 31 SEC = 167
// 011111     0010100111-                       0
// #   stvewx VS,RA,RB   PRI = 31 SEC = 199
// 011111     0011000111-                       0
// #   stvx  VS,RA,RB   PRI = 31 SEC = 231
// 011111     0011100111-                       0
// #   stvxl VS,RA,RB   PRI = 31 SEC = 487
// 011111     0111100111-                       0
module p405s_aPortPla (
dcdApMuxSel,
priOp,
secOp);

output  dcdApMuxSel;

input [0:5] priOp;
input [21:31] secOp;

wire [0:5] not_priOp;
wire [21:31] not_secOp;

wire [0:15] pterm;

assign not_priOp[0] = ~(priOp[0]);
assign not_priOp[2] = ~(priOp[2]);
assign not_priOp[3] = ~(priOp[3]);
assign not_priOp[4] = ~(priOp[4]);
assign not_secOp[21] = ~(secOp[21]);
assign not_secOp[22] = ~(secOp[22]);
assign not_secOp[23] = ~(secOp[23]);
assign not_secOp[24] = ~(secOp[24]);
assign not_secOp[25] = ~(secOp[25]);
assign not_secOp[26] = ~(secOp[26]);
assign not_secOp[27] = ~(secOp[27]);
assign not_secOp[28] = ~(secOp[28]);
assign not_secOp[29] = ~(secOp[29]);
assign not_secOp[30] = ~(secOp[30]);

// AND array expressions and reprint of all terms
// <0> 01-1-10010000011- 1
assign pterm[0] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[22] & secOp[23] & not_secOp[24] & not_secOp[25] & not_secOp[26] & 
   not_secOp[27] & not_secOp[28] & secOp[29] & secOp[30]);
// <1> 01-1-10001001110- 1
assign pterm[1] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[22] & not_secOp[23] & secOp[24] & not_secOp[25] & not_secOp[26] & 
   secOp[27] & secOp[28] & secOp[29] & not_secOp[30]);
// <2> 01-1-11111010010- 1
assign pterm[2] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & secOp[21] & secOp[22] & 
   secOp[23] & secOp[24] & not_secOp[25] & secOp[26] & not_secOp[27] & not_secOp[28] & 
   secOp[29] & not_secOp[30]);
// <3> 01-1-101110-0011- 1
assign pterm[3] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   secOp[22] & secOp[23] & secOp[24] & not_secOp[25] & not_secOp[27] & not_secOp[28] & 
   secOp[29] & secOp[30]);
// <4> 01-1-1000-111100- 1
assign pterm[4] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[22] & not_secOp[23] & secOp[25] & secOp[26] & secOp[27] & secOp[28] & 
   not_secOp[29] & not_secOp[30]);
// <5> 01-1-101-0-11100- 1
assign pterm[5] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   secOp[22] & not_secOp[24] & secOp[26] & secOp[27] & secOp[28] & not_secOp[29] & 
   not_secOp[30]);
// <6> 01-1-11100-11000- 1
assign pterm[6] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & secOp[21] & secOp[22] & 
   not_secOp[23] & not_secOp[24] & secOp[26] & secOp[27] & not_secOp[28] & 
   not_secOp[29] & not_secOp[30]);
// <7> 01-1-100000110-0- 1
assign pterm[7] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[22] & not_secOp[23] & not_secOp[24] & not_secOp[25] & secOp[26] & 
   secOp[27] & not_secOp[28] & not_secOp[30]);
// <8> 01-1-11110-11010- 1
assign pterm[8] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & secOp[21] & secOp[22] & 
   secOp[23] & not_secOp[24] & secOp[26] & secOp[27] & not_secOp[28] & secOp[29] & 
   not_secOp[30]);
// <9> 01-1-1011-011100- 1
assign pterm[9] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   secOp[22] & secOp[23] & not_secOp[25] & secOp[26] & secOp[27] & secOp[28] & 
   not_secOp[29] & not_secOp[30]);
// <10> 01-1-100100100-0- 1
assign pterm[10] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[22] & secOp[23] & not_secOp[24] & not_secOp[25] & secOp[26] & 
   not_secOp[27] & not_secOp[28] & not_secOp[30]);
// <11> 01-1-1-000011000- 1
assign pterm[11] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[22] & 
   not_secOp[23] & not_secOp[24] & not_secOp[25] & secOp[26] & secOp[27] & 
   not_secOp[28] & not_secOp[29] & not_secOp[30]);
// <12> 01-1-10-00-11100- 1
assign pterm[12] = (not_priOp[0] & priOp[1] & priOp[3] & priOp[5] & not_secOp[21] & 
   not_secOp[23] & not_secOp[24] & secOp[26] & secOp[27] & secOp[28] & not_secOp[29] & 
   not_secOp[30]);
// <13> 01-10------------ 1
assign pterm[13] = (not_priOp[0] & priOp[1] & priOp[3] & not_priOp[4]);
// <14> 0110------------- 1
assign pterm[14] = (not_priOp[0] & priOp[1] & priOp[2] & not_priOp[3]);
// <15> 0101-1----------- 1
assign pterm[15] = (not_priOp[0] & priOp[1] & not_priOp[2] & priOp[3] & priOp[5]);

// OR array expressions
assign dcdApMuxSel = (pterm[0] | pterm[1] | pterm[2] | pterm[3] | pterm[4] | pterm[5] | 
   pterm[6] | pterm[7] | pterm[8] | pterm[9] | pterm[10] | pterm[11] | pterm[12] | 
   pterm[13] | pterm[14] | pterm[15]);

endmodule
