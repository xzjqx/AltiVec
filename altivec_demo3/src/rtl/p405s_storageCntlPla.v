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
//  from espresso format file on Tue Dec 15 20:14:55 EST 1998
// modulename is storageCntlPla
// input file is storageCntlPla.pers
// output file is storageCntlPla.v
// espresso will be called.
// ######################
// #                    #
// #  storage control   #
// #                    #
// ######################
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
// # ~ in an output position means don't consider this line in generating this output.
// # synopsys does:
// #     read pla
// #     set current design
// # normally include:
//
// ##
// #
// .outputnames PCL_dcuByteEn[0:3] decBy[0:3] strgLpWrEn
// .outputnames gotoLS storageEnd sPortSelInc blkExeSpAddr algnErr
// .inputnames  exeApuFpuOp ea[0:1] byteCount[0:7] cntGtEq4 exeStorageSt[0:2]
// .inputnames  exeLd exeSt exeString exeMultiple exeByteRev exeAlg nopStringIndexed
// .inputnames  exeLwarx exeStwcx exeDcread exeEaCalc PCL_Rbit
// .type fd
// .i 27
// .o 14
// #
// #History:
// # 01/15/98 Copied from 401.
// #
// #Notes:
// # 1) During DCD the byteCount reg is loading with its initial value for strings and multiples.
// #    For loads and stores the byteCount reg is loaded with the appropriate count.
// # 2) lwarx,stwcx which are unaligned cause an alignment error.
// # 3) Non-word aligned dcreads will cause an alignment error.
// # 4) apu load/store which are unaligned cause an alignment error.
// #
// #
// # INPUTS *************************************************** OUTPUTS************************************
// # All signals are EXE stage
// #e                                                                                     b
// #x                                        n                                            l
// #e                                     A  o        e  e                                k
// #A                               M     l  p  e  e  x  x  P                          S  E
// #p                               u  B  g  S  x  x  c  e  C                          P  x
// #u               C            S  l  y  e  t  e  e  D  E  L                          M  e
// #F               n            t  t  t  b  r  L  S  c  a  _                          u  S
// #p               t  exe       r  i  e  r  I  w  t  r  C  R    DCU                   x  p  a
// #u EXE Byte      >  Strge Ld  i  p  R  a  n  a  w  e  a  b    Byte  Dec  Strg    E  S  A  l
// #O EA  Count     =  State St  n  l  e  i  d  r  c  a  l  i    En    by   Lp   gt n  e  d  g
// #P 01  01234567  4  012   LS  g  e  v  c  x  x  x  d  c  t    0123  1234 WrEn LS d  l  r  n
// #  --  --------  -  ---   --  -  -  -  -  -  -  -  -  -  -  * ----  ----  -   -  -  -  -  -
// #  Byte Enables
// #EA=00 C0-C1
// -  00  ------01  0  ---   --  -  -  -  -  -  -  -  -  -  -    1000  ~~~~  ~   ~  ~  ~  ~  ~   # count = 1
// -  00  ------10  0  ---   --  -  -  -  -  -  -  -  -  -  -    1100  ~~~~  ~   ~  ~  ~  ~  ~   # count = 2
// -  00  ------11  0  ---   --  -  -  -  -  -  -  -  -  -  -    1110  ~~~~  ~   ~  ~  ~  ~  ~   # count = 3
// -  00  --------  1  ---   --  -  -  -  -  -  -  -  -  -  -    1111  ~~~~  ~   ~  ~  ~  ~  ~   # count >= 4
// #EA=01 C0
// -  01  ------01  0  --0   --  -  -  -  -  -  -  -  -  -  -    0100  ~~~~  ~   ~  ~  ~  ~  ~   # count = 1
// -  01  ------10  0  --0   --  -  -  -  -  -  -  -  -  -  -    0110  ~~~~  ~   ~  ~  ~  ~  ~   # count = 2
// -  01  ------11  -  --0   --  -  -  -  -  -  -  -  -  -  -    0111  ~~~~  ~   ~  ~  ~  ~  ~   # count = 3
// -  01  --------  1  --0   --  -  -  -  -  -  -  -  -  -  -    0111  ~~~~  ~   ~  ~  ~  ~  ~   # count >= 4
// #EA=10 C0
// -  10  ------01  0  --0   --  -  -  -  -  -  -  -  -  -  -    0010  ~~~~  ~   ~  ~  ~  ~  ~   # count = 1
// -  10  ------1-  -  --0   --  -  -  -  -  -  -  -  -  -  -    0011  ~~~~  ~   ~  ~  ~  ~  ~   # count = 2,3
// -  10  --------  1  --0   --  -  -  -  -  -  -  -  -  -  -    0011  ~~~~  ~   ~  ~  ~  ~  ~   # count >= 4
// #EA=11 C0
// -  11  --------  -  --0   --  -  -  -  -  -  -  -  -  -  -    0001  ~~~~  ~   ~  ~  ~  ~  ~   # any count
// #any EA C1
// -  --  ------01  0  --1   --  -  -  -  -  -  -  -  -  -  -    1000  ~~~~  ~   ~  ~  ~  ~  ~   # count = 1
// -  --  ------10  0  --1   --  -  -  -  -  -  -  -  -  -  -    1100  ~~~~  ~   ~  ~  ~  ~  ~   # count = 2
// -  --  ------11  0  --1   --  -  -  -  -  -  -  -  -  -  -    1110  ~~~~  ~   ~  ~  ~  ~  ~   # count = 3
// -  --  --------  1  --1   --  -  -  -  -  -  -  -  -  -  -    1111  ~~~~  ~   ~  ~  ~  ~  ~   # count >= 4
// #
// #
// # INPUTS *************************************************** OUTPUTS*************************************
// # All signals are EXE stage
// #e                                                                                     b
// #x                                        n                                            l
// #e                                     A  o        e  e                                k
// #A                               M     l  p  e  e  x  x  P                          S  E
// #p                               u  B  g  S  x  x  c  e  C                          P  x
// #u               C            S  l  y  e  t  e  e  D  E  L                          M  e
// #F               n            t  t  t  b  r  L  S  c  a  _                          u  S
// #p               t  exe       r  i  e  r  I  w  t  r  C  R    DCU                   x  p  a
// #u EXE Byte      >  Strge Ld  i  p  R  a  n  a  w  e  a  b    Byte  Dec  strg    E  S  A  l
// #O EA  Count     =  State St  n  l  e  i  d  r  c  a  l  i    En    by   Lp   gt n  e  d  g
// #P 01  01234567  4  012   LS  g  e  v  c  x  x  x  d  c  t    0123  1234 WrEn LS d  l  r  n
// #  --  --------  -  ---   --  -  -  -  -  -  -  -  -  -  -  * ----  ----  -   -  -  -  -  -
// #  decrement determination
// -  --  --------  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  0001  ~   ~  ~  ~  ~  ~   # exeC1
// #  EA=00
// -  00  --------  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  0001  ~   ~  ~  ~  ~  ~   # exeC0
// #  EA=01
// -  01  --------  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  0010  ~   ~  ~  ~  ~  ~   # exeC0
// #  EA=10
// -  10  --------  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  0100  ~   ~  ~  ~  ~  ~   # exeC0
// #  EA=11
// -  11  --------  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  1000  ~   ~  ~  ~  ~  ~   # exeC0
// #
// #  StrgLpWrEn
// -  00  --------  -  0-0   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # any count
// -  01  --------  0  0-0   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # count = 1,2,3
// -  10  ------01  0  0-0   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # count = 1
// -  10  ------10  0  0-0   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # count = 2
// -  11  ------01  0  0-0   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # count = 1
// -  --  --------  -  --1   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # any count
// -  --  --------  -  -1-   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  1   ~  ~  ~  ~  ~   # any count
// #  Goto LS state
// #EA=01
// -  01  ------10  0  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// -  01  ------11  0  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// -  01  00000100  -  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// #EA=10
// -  10  ------11  0  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// -  10  00000100  -  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// #EA=11
// -  11  00000100  -  ---   1-  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   1  ~  ~  ~  ~   # Goto LS.
// #
// # INPUTS **************************************************** OUTPUTS**************************************
// # All signals are EXE stage
// #e                                                                                     b
// #x                                        n                                            l
// #e                                     A  o        e  e                                k
// #A                               M     l  p  e  e  x  x  P                          S  E
// #p                               u  B  g  S  x  x  c  e  C                          P  x
// #u               C            S  l  y  e  t  e  e  D  E  L                          M  e
// #F               n            t  t  t  b  r  L  S  c  a  _                          u  S
// #p               t  exe       r  i  e  r  I  w  t  r  C  R    DCU                   x  p  a
// #u EXE Byte      >  Strge Ld  i  p  R  a  n  a  w  e  a  b    Byte  Dec  strg    E  S  A  l
// #O EA  Count     =  State St  n  l  e  i  d  r  c  a  l  i    En    by   Lp   gt n  e  d  g
// #P 01  01234567  4  012   LS  g  e  v  c  x  x  x  d  c  t    0123  1234 WrEn LS d  l  r  n
// #  --  --------  -  ---   --  -  -  -  -  -  -  -  -  -  -  * ----  ----  -   -  -  -  -  -
// #  End detection
// # Anytime LS state then End
// -  --  --------  -  -1-   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// # Anytime No exeEaCalc then End
// -  --  --------  -  ---   --  -  -  -  -  -  -  -  -  0  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #  Anytime C0 and STWRX go to C1.
// -  --  --------  -  --0   --  -  -  -  -  -  -  1  -  -  -    ~~~~  ~~~~  ~   ~  0  ~  ~  ~   # Goto exeC1.
// -  --  --------  -  --1   --  -  -  -  -  -  -  1  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Goto exeC0.
// #  Anytime count=0 then End (only occurs with strings)
// -  --  ------00  0  ---   --  -  -  -  -  -  -  0  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=00
// -  00  00000100  -  ---   --  -  -  -  -  -  -  0  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  00  --------  0  ---   --  -  -  -  -  -  -  0  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=01 C0,C1 count < 4 NOT ld string (To avoid LS state)
// -  01  --------  0  ---   --  0  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  01  --------  0  ---   0-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=01 C1 count = 4 NOT ld string (To avoid LS state)
// -  01  00000100  -  --1   0-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=01 C0 count < 4 ld string
// -  01  --------  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=01 C1 count = 1 ld string
// -  01  ------01  0  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=10 C0 count < 3 (Includes ld string)  See above for count=0 case.
// -  10  ------01  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  10  ------10  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=10 C1 count <= 4 NOT ld string (To avoid LS state)
// -  10  --------  0  --1   --  0  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  10  --------  0  --1   0-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  10  00000100  -  --1   0-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=10 C1 count < 3 ld string  See above for count=0 case.
// -  10  ------01  0  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  10  ------10  0  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=11 C0,C1 count = 1 (Includes ld string) See above for count=0 case.
// -  11  ------01  0  ---   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=11 C1 count < 4 (Includes ld string)
// -  11  --------  0  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #EA=11 C1 count = 4 NOT ld string (To avoid LS state)
// -  11  00000100  -  --1   --  0  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// -  11  00000100  -  --1   0-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  1  ~  ~  ~   # Last cycle.
// #
// # INPUTS **************************************************** OUTPUTS**************************************
// # All signals are EXE stage
// #e                                                                                     b
// #x                                        n                                            l
// #e                                     A  o        e  e                                k
// #A                               M     l  p  e  e  x  x  P                          S  E
// #p                               u  B  g  S  x  x  c  e  C                          P  x
// #u               C            S  l  y  e  t  e  e  D  E  L                          M  e
// #F               n            t  t  t  b  r  L  S  c  a  _                          u  S
// #p               t  exe       r  i  e  r  I  w  t  r  C  R    DCU                   x  p  a
// #u EXE Byte      >  Strge Ld  i  p  R  a  n  a  w  e  a  b    Byte  Dec  strg    E  S  A  l
// #O EA  Count     =  State St  n  l  e  i  d  r  c  a  l  i    En    by   Lp   gt n  e  d  g
// #P 01  01234567  4  012   LS  g  e  v  c  x  x  x  d  c  t    0123  1234 WrEn LS d  l  r  n
// #  --  --------  -  ---   --  -  -  -  -  -  -  -  -  -  -  * ----  ----  -   -  -  -  -  -
// #
// #  SPort Addr Mux Control
// #C0orC1 count = 5,6,7 st string
// -  --  -------1  1  ---   -1  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// -  --  ------1-  1  ---   -1  1  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// #C0orC1 count >= 8 st multiple and st string
// -  --  ----1---  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// -  --  ---1----  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// -  --  --1-----  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// -  --  -1------  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// -  --  1-------  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  1  ~  ~   # Sel Incr RS address
// # blkExeSpAddr
// -  01  00000100  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=01 & C0 & BC=4
// -  10  ------11  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=10 & C0 & BC=3
// -  10  00000100  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=10 & C0 & BC=4
// -  11  ------10  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C0 & BC=2
// -  11  ------11  0  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C0 & BC=3
// -  11  00000100  -  --0   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C0 & BC=4
// -  01  00000101  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=01 & C1 & BC=5
// -  10  00000101  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=10 & C1 & BC=5
// -  10  00000110  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=10 & C1 & BC=6
// -  11  00000101  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C1 & BC=5
// -  11  00000110  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C1 & BC=6
// -  11  00000111  -  --1   --  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  1  ~   # EA=11 & C1 & BC=7
// #
// # INPUTS **************************************************** OUTPUTS**************************************
// # All signals are EXE stage
// #e                                                                                     b
// #x                                        n                                            l
// #e                                     A  o        e  e                                k
// #A                               M     l  p  e  e  x  x  P                          S  E
// #p                               u  B  g  S  x  x  c  e  C                          P  x
// #u               C            S  l  y  e  t  e  e  D  E  L                          M  e
// #F               n            t  t  t  b  r  L  S  c  a  _                          u  S
// #p               t  exe       r  i  e  r  I  w  t  r  C  R    DCU                   x  p  a
// #u DB  Byte      >  Strge Ld  i  p  R  a  n  a  w  e  a  b    Byte  Dec  strg    E  S  A  l
// #O EA  Count     =  State St  n  l  e  i  d  r  c  a  l  i    En    by   Lp   gt n  e  d  g
// #P 01  01234567  4  012   LS  g  e  v  c  x  x  x  d  c  t    0123  1234 WrEn LS d  l  r  n
// #  --  --------  -  ---   --  -  -  -  -  -  -  -  -  -  -  * ----  ----  -   -  -  -  -  -
// #  Alignment Errors
// -  -1  --------  -  ---   --  -  -  -  -  -  1  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # lwarx algnErr (Note2)
// -  1-  --------  -  ---   --  -  -  -  -  -  1  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # lwarx algnErr (Note2)
// -  -1  --------  -  ---   --  -  -  -  -  -  -  1  -  -  1    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # stwcx algnErr (Note2)
// -  1-  --------  -  ---   --  -  -  -  -  -  -  1  -  -  1    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # stwcx algnErr (Note2)
// -  -1  --------  -  ---   --  -  -  -  -  -  -  -  1  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # dcread algnErr (Note3)
// -  1-  --------  -  ---   --  -  -  -  -  -  -  -  1  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # dcread algnErr (Note3)
// 1  -1  ------10  -  ---   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn ld hw (Note4)
// 1  -1  ------10  -  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn st hw (Note4)
// 1  -1  --------  1  ---   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn ld wd/dw (Note4)
// 1  1-  --------  1  ---   1-  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn ld wd/dw (Note4)
// 1  -1  --------  1  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn st wd/dw (Note4)
// 1  1-  --------  1  ---   -1  -  -  -  -  -  -  -  -  -  -    ~~~~  ~~~~  ~   ~  ~  ~  ~  1   # APU unalgn st wd/dw (Note4)
module p405s_storageCntlPla (
PCL_dcuByteEn,
decBy,
strgLpWrEn,
gotoLS,
storageEnd,
sPortSelInc,
blkExeSpAddr,
algnErr,
exeApuFpuOp,
ea,
byteCount,
cntGtEq4,
exeStorageSt,
exeLd,
exeSt,
exeString,
exeMultiple,
exeByteRev,
exeAlg,
nopStringIndexed,
exeLwarx,
exeStwcx,
exeDcread,
exeEaCalc,
PCL_Rbit);

output [0:3] PCL_dcuByteEn;
output [0:3] decBy;
output  strgLpWrEn;
output  gotoLS;
output  storageEnd;
output  sPortSelInc;
output  blkExeSpAddr;
output  algnErr;

input  exeApuFpuOp;
input [0:1] ea;
input [0:7] byteCount;
input  cntGtEq4;
input [0:2] exeStorageSt;
input  exeLd;
input  exeSt;
input  exeString;
input  exeMultiple;
input  exeByteRev;
input  exeAlg;
input  nopStringIndexed;
input  exeLwarx;
input  exeStwcx;
input  exeDcread;
input  exeEaCalc;
input  PCL_Rbit;

wire [0:1] not_ea;
wire [0:7] not_byteCount;
wire  not_cntGtEq4;
wire [0:2] not_exeStorageSt;
wire  not_exeLd;
wire  not_exeString;
wire  not_exeStwcx;
wire  not_exeEaCalc;

wire [0:68] pterm;

assign not_ea[0] = ~(ea[0]);
assign not_ea[1] = ~(ea[1]);
assign not_byteCount[0] = ~(byteCount[0]);
assign not_byteCount[1] = ~(byteCount[1]);
assign not_byteCount[2] = ~(byteCount[2]);
assign not_byteCount[3] = ~(byteCount[3]);
assign not_byteCount[4] = ~(byteCount[4]);
assign not_byteCount[6] = ~(byteCount[6]);
assign not_byteCount[7] = ~(byteCount[7]);
assign not_cntGtEq4 = ~(cntGtEq4);
assign not_exeStorageSt[0] = ~(exeStorageSt[0]);
assign not_exeStorageSt[2] = ~(exeStorageSt[2]);
assign not_exeLd = ~(exeLd);
assign not_exeString = ~(exeString);
assign not_exeStwcx = ~(exeStwcx);
assign not_exeEaCalc = ~(exeEaCalc);

// AND array expressions and reprint of all terms
// <0> -1100000100---1--0--------- 00000000001000
assign pterm[0] = (ea[0] & ea[1] & not_byteCount[0] & not_byteCount[1] & 
   not_byteCount[2] & not_byteCount[3] & not_byteCount[4] & byteCount[5] & 
   not_byteCount[6] & not_byteCount[7] & exeStorageSt[2] & not_exeString);
// <1> -1-00000100----1-1--------- 00000000010000
assign pterm[1] = (ea[0] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   not_byteCount[7] & exeLd & exeString);
// <2> --100000100----1-1--------- 00000000010000
assign pterm[2] = (ea[1] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   not_byteCount[7] & exeLd & exeString);
// <3> -0000000100------------0--- 00000000001000
assign pterm[3] = (not_ea[0] & not_ea[1] & not_byteCount[0] & not_byteCount[1] & 
   not_byteCount[2] & not_byteCount[3] & not_byteCount[4] & byteCount[5] & 
   not_byteCount[6] & not_byteCount[7] & not_exeStwcx);
// <4> ---00000100---10----------- 00000000001000
assign pterm[4] = (not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   not_byteCount[7] & exeStorageSt[2] & not_exeLd);
// <5> -1-00000100---0------------ 00000000000010
assign pterm[5] = (ea[0] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   not_byteCount[7] & not_exeStorageSt[2]);
// <6> --100000100---0------------ 00000000000010
assign pterm[6] = (ea[1] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   not_byteCount[7] & not_exeStorageSt[2]);
// <7> -1-00000101---1------------ 00000000000010
assign pterm[7] = (ea[0] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   byteCount[7] & exeStorageSt[2]);
// <8> -1-00000110---1------------ 00000000000010
assign pterm[8] = (ea[0] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & byteCount[6] & 
   not_byteCount[7] & exeStorageSt[2]);
// <9> --100000101---1------------ 00000000000010
assign pterm[9] = (ea[1] & not_byteCount[0] & not_byteCount[1] & not_byteCount[2] & 
   not_byteCount[3] & not_byteCount[4] & byteCount[5] & not_byteCount[6] & 
   byteCount[7] & exeStorageSt[2]);
// <10> -11000001-1---1------------ 00000000000010
assign pterm[10] = (ea[0] & ea[1] & not_byteCount[0] & not_byteCount[1] & 
   not_byteCount[2] & not_byteCount[3] & not_byteCount[4] & byteCount[5] & 
   byteCount[7] & exeStorageSt[2]);
// <11> -10------110---1-1--------- 00000000010000
assign pterm[11] = (ea[0] & not_ea[1] & byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   exeLd & exeString);
// <12> --0------1000--1----------- 00000000100000
assign pterm[12] = (not_ea[1] & byteCount[6] & not_byteCount[7] & not_cntGtEq4 & 
   not_exeStorageSt[0] & exeLd);
// <13> -01------1-0---1-1--------- 00000000010000
assign pterm[13] = (not_ea[0] & ea[1] & byteCount[6] & not_cntGtEq4 & exeLd & 
   exeString);
// <14> -10------010--0------------ 00100000001000
assign pterm[14] = (ea[0] & not_ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_exeStorageSt[2]);
// <15> ---------0100--1----------- 00000000100000
assign pterm[15] = (not_byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_exeStorageSt[0] & exeLd);
// <16> 1-1------10-----1---------- 00000000000001
assign pterm[16] = (exeApuFpuOp & ea[1] & byteCount[6] & not_byteCount[7] & exeSt);
// <17> 1-1------10----1----------- 00000000000001
assign pterm[17] = (exeApuFpuOp & ea[1] & byteCount[6] & not_byteCount[7] & exeLd);
// <18> -1-------110--0------------ 00000000000010
assign pterm[18] = (ea[0] & byteCount[6] & byteCount[7] & not_cntGtEq4 & 
   not_exeStorageSt[2]);
// <19> -10------100--------------- 00000000001000
assign pterm[19] = (ea[0] & not_ea[1] & byteCount[6] & not_byteCount[7] & 
   not_cntGtEq4);
// <20> -11------1-0--0------------ 00000000000010
assign pterm[20] = (ea[0] & ea[1] & byteCount[6] & not_cntGtEq4 & 
   not_exeStorageSt[2]);
// <21> ----------11----11--------- 00000000000100
assign pterm[21] = (byteCount[7] & cntGtEq4 & exeSt & exeString);
// <22> ---------1-1----11--------- 00000000000100
assign pterm[22] = (byteCount[6] & cntGtEq4 & exeSt & exeString);
// <23> -00---------0--1----------- 00000000100000
assign pterm[23] = (not_ea[0] & not_ea[1] & not_exeStorageSt[0] & exeLd);
// <24> -0---------00--1----------- 00000000100000
assign pterm[24] = (not_ea[0] & not_cntGtEq4 & not_exeStorageSt[0] & exeLd);
// <25> 11---------1----1---------- 00000000000001
assign pterm[25] = (exeApuFpuOp & ea[0] & cntGtEq4 & exeSt);
// <26> 1-1--------1----1---------- 00000000000001
assign pterm[26] = (exeApuFpuOp & ea[1] & cntGtEq4 & exeSt);
// <27> 11---------1---1----------- 00000000000001
assign pterm[27] = (exeApuFpuOp & ea[0] & cntGtEq4 & exeLd);
// <28> -00--------0-----------0--- 00000000001000
assign pterm[28] = (not_ea[0] & not_ea[1] & not_cntGtEq4 & not_exeStwcx);
// <29> 1-1--------1---1----------- 00000000000001
assign pterm[29] = (exeApuFpuOp & ea[1] & cntGtEq4 & exeLd);
// <30> -01-------1---0------------ 01000000000000
assign pterm[30] = (not_ea[0] & ea[1] & byteCount[7] & not_exeStorageSt[2]);
// <31> --1------11---0------------ 00010000000000
assign pterm[31] = (ea[1] & byteCount[6] & byteCount[7] & not_exeStorageSt[2]);
// <32> -10------1----0------------ 00110000000000
assign pterm[32] = (ea[0] & not_ea[1] & byteCount[6] & not_exeStorageSt[2]);
// <33> -01------1----0------------ 01100000000000
assign pterm[33] = (not_ea[0] & ea[1] & byteCount[6] & not_exeStorageSt[2]);
// <34> -01--------1--0------------ 01110010000000
assign pterm[34] = (not_ea[0] & ea[1] & cntGtEq4 & not_exeStorageSt[2]);
// <35> --1------010--------------- 00000000001000
assign pterm[35] = (ea[1] & not_byteCount[6] & byteCount[7] & not_cntGtEq4);
// <36> -01--------0--0------------ 00000010001000
assign pterm[36] = (not_ea[0] & ea[1] & not_cntGtEq4 & not_exeStorageSt[2]);
// <37> -11--------0--1------------ 00000000001000
assign pterm[37] = (ea[0] & ea[1] & not_cntGtEq4 & exeStorageSt[2]);
// <38> -1---------------------1--1 00000000000001
assign pterm[38] = (ea[0] & exeStwcx & PCL_Rbit);
// <39> --1--------------------1--1 00000000000001
assign pterm[39] = (ea[1] & exeStwcx & PCL_Rbit);
// <40> ---------0-0-----------0--- 00000000001000
assign pterm[40] = (not_byteCount[6] & not_cntGtEq4 & not_exeStwcx);
// <41> -----------0--1--0--------- 00000000001000
assign pterm[41] = (not_cntGtEq4 & exeStorageSt[2] & not_exeString);
// <42> -00-------1---------------- 10000000000000
assign pterm[42] = (not_ea[0] & not_ea[1] & byteCount[7]);
// <43> -10-----------0------------ 00000100000000
assign pterm[43] = (ea[0] & not_ea[1] & not_exeStorageSt[2]);
// <44> -00--------1--------------- 11000000000000
assign pterm[44] = (not_ea[0] & not_ea[1] & cntGtEq4);
// <45> -----------0--10----------- 00000001001000
assign pterm[45] = (not_cntGtEq4 & exeStorageSt[2] & not_exeLd);
// <46> ---------11---1------------ 00100000000000
assign pterm[46] = (byteCount[6] & byteCount[7] & exeStorageSt[2]);
// <47> --0------11---------------- 00100000000000
assign pterm[47] = (not_ea[1] & byteCount[6] & byteCount[7]);
// <48> -00------1----------------- 11000000000000
assign pterm[48] = (not_ea[0] & not_ea[1] & byteCount[6]);
// <49> -11-----------0------------ 00011000000000
assign pterm[49] = (ea[0] & ea[1] & not_exeStorageSt[2]);
// <50> -------1--------1---------- 00000000000100
assign pterm[50] = (byteCount[4] & exeSt);
// <51> ------1---------1---------- 00000000000100
assign pterm[51] = (byteCount[3] & exeSt);
// <52> -----1----------1---------- 00000000000100
assign pterm[52] = (byteCount[2] & exeSt);
// <53> ----1-----------1---------- 00000000000100
assign pterm[53] = (byteCount[1] & exeSt);
// <54> ---1------------1---------- 00000000000100
assign pterm[54] = (byteCount[0] & exeSt);
// <55> -------------1-1----------- 00000000100000
assign pterm[55] = (exeStorageSt[1] & exeLd);
// <56> -00------------------------ 00000001000000
assign pterm[56] = (not_ea[0] & not_ea[1]);
// <57> --------------1--------1--- 00000000001000
assign pterm[57] = (exeStorageSt[2] & exeStwcx);
// <58> -1----------------------1-- 00000000000001
assign pterm[58] = (ea[0] & exeDcread);
// <59> -1--------------------1---- 00000000000001
assign pterm[59] = (ea[0] & exeLwarx);
// <60> ----------1---1------------ 10000000000000
assign pterm[60] = (byteCount[7] & exeStorageSt[2]);
// <61> --1---------------------1-- 00000000000001
assign pterm[61] = (ea[1] & exeDcread);
// <62> --1-------------------1---- 00000000000001
assign pterm[62] = (ea[1] & exeLwarx);
// <63> --------------11----------- 00000001100000
assign pterm[63] = (exeStorageSt[2] & exeLd);
// <64> --0--------1--------------- 00110000000000
assign pterm[64] = (not_ea[1] & cntGtEq4);
// <65> ---------1----1------------ 11000000000000
assign pterm[65] = (byteCount[6] & exeStorageSt[2]);
// <66> -----------1--1------------ 11110001000000
assign pterm[66] = (cntGtEq4 & exeStorageSt[2]);
// <67> -------------------------0- 00000000001000
assign pterm[67] = (not_exeEaCalc);
// <68> -------------1------------- 00000000001000
assign pterm[68] = (exeStorageSt[1]);

// OR array expressions
assign PCL_dcuByteEn[0] = (pterm[42] | pterm[44] | pterm[48] | pterm[60] | pterm[65] | 
   pterm[66]);
assign PCL_dcuByteEn[1] = (pterm[30] | pterm[33] | pterm[34] | pterm[44] | pterm[48] | 
   pterm[65] | pterm[66]);
assign PCL_dcuByteEn[2] = (pterm[14] | pterm[32] | pterm[33] | pterm[34] | pterm[46] | 
   pterm[47] | pterm[64] | pterm[66]);
assign PCL_dcuByteEn[3] = (pterm[31] | pterm[32] | pterm[34] | pterm[49] | pterm[64] | 
   pterm[66]);
assign decBy[0] = (pterm[49]);
assign decBy[1] = (pterm[43]);
assign decBy[2] = (pterm[34] | pterm[36]);
assign decBy[3] = (pterm[45] | pterm[56] | pterm[63] | pterm[66]);
assign strgLpWrEn = (pterm[12] | pterm[15] | pterm[23] | pterm[24] | pterm[55] | 
   pterm[63]);
assign gotoLS = (pterm[1] | pterm[2] | pterm[11] | pterm[13]);
assign storageEnd = (pterm[0] | pterm[3] | pterm[4] | pterm[14] | pterm[19] | pterm[28] | 
   pterm[35] | pterm[36] | pterm[37] | pterm[40] | pterm[41] | pterm[45] | pterm[57] | 
   pterm[67] | pterm[68]);
assign sPortSelInc = (pterm[21] | pterm[22] | pterm[50] | pterm[51] | pterm[52] | 
   pterm[53] | pterm[54]);
assign blkExeSpAddr = (pterm[5] | pterm[6] | pterm[7] | pterm[8] | pterm[9] | pterm[10] | 
   pterm[18] | pterm[20]);
assign algnErr = (pterm[16] | pterm[17] | pterm[25] | pterm[26] | pterm[27] | pterm[29] | 
   pterm[38] | pterm[39] | pterm[58] | pterm[59] | pterm[61] | pterm[62]);

endmodule
