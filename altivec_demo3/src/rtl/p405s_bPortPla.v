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
//  from espresso format file on Wed May 12 16:17:47 EDT 1999
// modulename is bPortPla
// input file is bPortPla.pers
// output file is bPortPla.v
// espresso will be called.
// ############################
// #                          #
// #  bPortPla  personality   #
// #                          #
// ############################
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
// .outputnames dcdBpMuxSel
// .inputnames priOp[0:5] secOp[21:31]
// .type fd
// .i 17
// .o 1
// # History:
// # 01/14/98 Created.
// # 01/09/99 SBP Changed the secondaryOp of instr machhws from 118 to 108.
// #
// #
// #  NOTE 1) Added the floating point Instr to 401 dcdPla to create this PLA.
// #
// #  NOTE 2) plaCoproc is the coprocessor instruction enable signal. This pla activates this signal for the IBM portion of the#
// #          sandbox ops and for mult/div instructions that are to be coprocessor driven as indicated by the mult and div enable
// #          inputs.
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
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
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
// #Fixed Point Arithmetic Instructions
// #   addi   RT,RA.SI  PRI = 14 SEC = None
// 001110     -----------                       ~
// #   addis  RT,RA,SI  PRI = 15 SEC = None
// 001111     -----------                       ~
// #   add    RT,RA,RB  PRI = 31 SEC = 266
// 011111     -100001010-                       0
// #   subf   RT,RA,RB  PRI = 31 SEC =  40
// 011111     -000101000-                       0
// #   addic  RT,RA,SI  PRI = 12 SEC = None
// 001100     -----------                       ~
// #   addic. RT,RA,SI  PRI = 13 SEC = None
// 001101     -----------                       ~
// #   subfic RT,RA,SI  PRI =  8 SEC = None
// 001000     -----------                       ~
// #   addc   RT,RA,RB  PRI = 31 SEC =  10
// 011111     -000001010-                       0
// #   subfc  RT,RA,RB  PRI = 31 SEC =   8
// 011111     -000001000-                       0
// #   adde   RT,RA,RB  PRI = 31 SEC = 138
// 011111     -010001010-                       0
// #   subfe  RT,RA,RB  PRI = 31 SEC = 136
// 011111     -010001000-                       0
// #   addme  RT,RA     PRI = 31 SEC = 234
// 011111     -011101010-                       ~
// #   subfme RT,RA     PRI = 31 SEC = 232
// 011111     -011101000-                       ~
// #   addze  RT,RA     PRI = 31 SEC = 202
// 011111     -011001010-                       ~
// #   subfze RT,RA     PRI = 31 SEC = 200
// 011111     -011001000-                       ~
// #   neg    RT,RA     PRI = 31 SEC = 104
// 011111     -001101000-                       ~
// #   mulli  RT,RA,SI  PRI =  7 SEC = None
// 000111     -----------                       ~
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
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21    I30C                    |  0
// #-----     -----------                       -
// # Fixed Point Compare Instruction
// #   cmpwi  BF,RA,SI  PRI = 11 SEC = None
// 001011     -----------                       ~
// #   cmpw   BF,RA,RB  PRI = 31 SEC =   0
// 011111     0000000000-                       0
// #   cmplwi BF,RA,UI  PRI = 10 SEC = None
// 001010     -----------                       ~
// #   cmplw  BF,RA,RB  PRI = 31 SEC =  32
// 011111     0000100000-                       0
// # Fixed Point Trap Instructions
// #   twi    TO,RA,SI  PRI =  3 SEC = None
// 000011     -----------                       ~
// #   tw     TO,RA,RB  PRI = 31 SEC =   4
// 011111     0000000100-                       0
// # Fixed Point Logical Instruction
// #   andi.  RA,RS,UI  PRI = 28 SEC = None
// 011100     -----------                       ~
// #   andis. RA,RS,UI  PRI = 29 SEC = None
// 011101     -----------                       ~
// #   ori    RA,RS,UI  PRI = 24 SEC = None
// 011000     -----------                       ~
// #   oris   RA,RS,UI  PRI = 25 SEC = None
// 011001     -----------                       ~
// #   xori   RA,RS,UI  PRI = 26 SEC = None
// 011010     -----------                       ~
// #   xoris  RA,RS,UI  PRI = 27 SEC = None
// 011011     -----------                       ~
// #   and    RA,RS,RB  PRI = 31 SEC =  28
// 011111     0000011100-                       0
// #   or     RA,RS,RB  PRI = 31 SEC = 444
// 011111     0110111100-                       0
// #   xor    RA,RS,RB  PRI = 31 SEC = 316
// 011111     0100111100-                       0
// #   nand   RA,RS,RB  PRI = 31 SEC = 476
// 011111     0111011100-                       0
// #   nor    RA,RS,RB  PRI = 31 SEC = 124
// 011111     0001111100-                       0
// #   eqv    RA,RS,RB  PRI = 31 SEC = 284
// 011111     0100011100-                       0
// #   andc   RA,RS,RB  PRI = 31 SEC =  60
// 011111     0000111100-                       0
// #   orc    RA,RS,RB  PRI = 31 SEC = 412
// 011111     0110011100-                       0
// #   extsb  RA,RS     PRI = 31 SEC = 954
// 011111     1110111010-                       ~
// #   extsh  RA,RS     PRI = 31 SEC = 922
// 011111     1110011010-                       ~
// #   cntlzw RA,RS     PRI = 31 SEC =  26
// 011111     0000011010-                       ~
// #   dlmzb  RA,RS,RB  PRI = 31 SEC =  78
// 011111     0001001110-                       0
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
// # Fixed Point Rotate and Shift Instructions
// # rlwinm RA,RS,SH,MB,ME PRI = 21 SEC = None
// 010101     -----------                       ~
// # rlwnm  RA,RS,RB,MB,ME PRI = 23 SEC = None
// 010111     -----------                       0
// # rlwimi RA,RS,SH,MB,ME PRI = 20 SEC = None
// 010100     -----------                       1
// # slw    RA,RS,RB       PRI = 31 SEC =  24
// 011111     0000011000-                       0
// # srw    RA,RS,RB       PRI = 31 SEC = 536
// 011111     1000011000-                       0
// # srawi  RA,RS,SH       PRI = 31 SEC = 824
// 011111     1100111000-                       ~
// # sraw   RA,RS,RB       PRI = 31 SEC = 792
// 011111     1100011000-                       0
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
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
// # Fixed Point Load Instructions
// #   lbz   RT,D(RA)   PRI = 34 SEC = None
// 100010     -----------                       ~
// #   lbzu  RT,D(RA)   PRI = 35 SEC = None
// 100011     -----------                       ~
// #   lbzx  RT,RA,RB   PRI = 31 SEC =  87
// 011111     0001010111-                       0
// #   lbzux RT,RA,RB   PRI = 31 SEC = 119
// 011111     0001110111-                       0
// #   lhz   RT,D(RA)   PRI = 40 SEC = None
// 101000     -----------                       ~
// #   lhzu  RT,D(RA)   PRI = 41 SEC = None
// 101001     -----------                       ~
// #   lhzx  RT,RA,RB   PRI = 31 SEC = 279
// 011111     0100010111-                       0
// #   lhzux RT,RA,RB   PRI = 31 SEC = 311
// 011111     0100110111-                       0
// #   lha   RT,D(RA)   PRI = 42 SEC = None
// 101010     -----------                       ~
// #   lhau  RT,D(RA)   PRI = 43 SEC = None
// 101011     -----------                       ~
// #   lhax  RT,RA,RB   PRI = 31 SEC = 343
// 011111     0101010111-                       0
// #   lhaux RT,RA,RB   PRI = 31 SEC = 375
// 011111     0101110111-                       0
// #   lwz   RT,D(RA)   PRI = 32 SEC = None
// 100000     -----------                       ~
// #   lwzu  RT,D(RA)   PRI = 33 SEC = None
// 100001     -----------                       ~
// #   lwzx  RT,RA,RB   PRI = 31 SEC =  23
// 011111     0000010111-                       0
// #   lwzux RT,RA,RB   PRI = 31 SEC =  55
// 011111     0000110111-                       0
// #
// # Fixed Point Store Instructions
// #   stb   RS,D(RA)   PRI = 38 SEC = None
// 100110     -----------                       ~
// #   stbu  RS,D(RA)   PRI = 39 SEC = None
// 100111     -----------                       ~
// #   stbx  RS,RA,RB   PRI = 31 SEC = 215
// 011111     0011010111-                       0
// #   stbux RS,RA,RB   PRI = 31 SEC = 247
// 011111     0011110111-                       0
// #   sth   RS,D(RA)   PRI = 44 SEC = None
// 101100     -----------                       ~
// #   sthu  RS,D(RA)   PRI = 45 SEC = None
// 101101     -----------                       ~
// #   sthx  RS,RA,RB   PRI = 31 SEC = 407
// 011111     0110010111-                       0
// #   sthux RS,RA,RB   PRI = 31 SEC = 439
// 011111     0110110111-                       0
// #   stw   RS,D(RA)   PRI = 36 SEC = None
// 100100     -----------                       ~
// #   stwu  RS,D(RA)   PRI = 37 SEC = None
// 100101     -----------                       ~
// #   stwx  RS,RA,RB   PRI = 31 SEC = 151
// 011111     0010010111-                       0
// #   stwux RS,RA,RB   PRI = 31 SEC = 183
// 011111     0010110111-                       0
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
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
// 101110     -----------                       ~
// #   stmw RS,D(RA)    PRI = 47 SEC = None
// 101111     -----------                       ~
// #
// # Fixed Point Move Assist Instructions
// #   lswi  RT,RA,NB   PRI = 31 SEC = 597
// 011111     1001010101-                       ~
// #   lswx  RT,RA,RB   PRI = 31 SEC = 533
// 011111     1000010101-                       0
// #   stswi RS,RA,NB   PRI = 31 SEC = 725
// 011111     1011010101-                       ~
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
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
// # Miscellaneous Instructions
// #   mtcrf  FXM,RS    PRI = 31 SEC = 144
// 011111     0010010000-                       ~
// #   mfcr   RT        PRI = 31 SEC =  19
// 011111     0000010011-                       ~
// #   mcrxr  BF        PRI = 31 SEC = 512
// 011111     1000000000-                       ~
// #   mfspr  RT,SPR    PRI = 31 SEC = 339,371
// 011111     0101-10011-                       ~
// #   mtspr  SPR,RS    PRI = 31 SEC = 467
// 011111     0111010011-                       ~
// #   mfdcr  RT,DCR    PRI = 31 SEC = 323
// 011111     0101000011-                       ~
// #   mtdcr  DCR,RS    PRI = 31 SEC = 451
// 011111     0111000011-                       ~
// #   mfmsr  RT        PRI = 31 SEC = 339
// 011111     0001010011-                       ~
// #   mtmsr  RS        PRI = 31 SEC = 467
// 011111     0010010010-                       ~
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
// 011111     0010000011-                       ~
// #   wrteei E         PRI = 31 SEC = 163
// 011111     0010100011-                       ~
// #
// #
// #-----------------------------------------------------
// #  INPUTS                                 | OUTPUTS
// #                                         |
// #                                         |  BPort
// #                                         |  Ad
// #Op        ExtOp     R                    |  Mx
// #I0-I5     I21  - I30C                    |  0
// #-----     -----------                       -
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
// 011111     1110110010-                       1
// # tlbwe    RS,RA,WS  PRI = 31 SEC = 978
// 011111     1111010010-                       1
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
// #                        Pre              |  BPort
// #                        Decode           |  Ad
// #Op        ExtOp     R   Bport            |  En
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
module p405s_bPortPla (
dcdBpMuxSel,
priOp,
secOp);

output  dcdBpMuxSel;

input [0:5] priOp;
input [21:31] secOp;

wire [0:5] not_priOp;
wire [21:31] not_secOp;

wire [0:2] pterm;

assign not_priOp[0] = ~(priOp[0]);
assign not_priOp[2] = ~(priOp[2]);
assign not_priOp[4] = ~(priOp[4]);
assign not_priOp[5] = ~(priOp[5]);
assign not_secOp[24] = ~(secOp[24]);
assign not_secOp[25] = ~(secOp[25]);
assign not_secOp[27] = ~(secOp[27]);
assign not_secOp[28] = ~(secOp[28]);
assign not_secOp[30] = ~(secOp[30]);

// AND array expressions and reprint of all terms
// <0> 0111111111010010- 1
assign pterm[0] = (not_priOp[0] & priOp[1] & priOp[2] & priOp[3] & priOp[4] & priOp[5] & 
   secOp[21] & secOp[22] & secOp[23] & secOp[24] & not_secOp[25] & secOp[26] & 
   not_secOp[27] & not_secOp[28] & secOp[29] & not_secOp[30]);
// <1> 0111111110110010- 1
assign pterm[1] = (not_priOp[0] & priOp[1] & priOp[2] & priOp[3] & priOp[4] & priOp[5] & 
   secOp[21] & secOp[22] & secOp[23] & not_secOp[24] & secOp[25] & secOp[26] & 
   not_secOp[27] & not_secOp[28] & secOp[29] & not_secOp[30]);
// <2> 010100----------- 1
assign pterm[2] = (not_priOp[0] & priOp[1] & not_priOp[2] & priOp[3] & not_priOp[4] & 
   not_priOp[5]);

// OR array expressions
assign dcdBpMuxSel = (pterm[0] | pterm[1] | pterm[2]);

endmodule
