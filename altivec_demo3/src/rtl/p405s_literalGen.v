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
module p405s_literalGen (litGen, PCL_dcdImmd, litCntl, LSSD_coreTestEn);
    output [0:31] litGen;
    input [11:31] PCL_dcdImmd;
    input [0:4] litCntl;
    input       LSSD_coreTestEn;

//******************
//  litGen<0:15>   *
//******************
//  litCntl[0:1] litHiMuxSel   Output               Comments
//------------------------------------------------------------
//       00           0        16'h0000             Zeroes
//       01           0        16'hffff             Ones
//       10           0        16*PCL_dcdImmd[16]   Sign Extend
//       11           1        PCL_dcdImmd[16:31]   Immediate Field

wire zos, litHiMuxSel;
assign zos =  litCntl[1] | (litCntl[0] & PCL_dcdImmd[16]);

// defect 2302 - tbird - added LSSD_coreTestEn to increase test coverage
assign litHiMuxSel = litCntl[0] & (litCntl[1] ^ LSSD_coreTestEn);

//dp_muxEXE_litHi  muxEXE_litHi( .Z(litGen[0:15]),
//                               .D0({16{zos}}),
//                               .D1(PCL_dcdImmd[16:31]),
//                               .SD({16{litHiMuxSel}}));
// Removed the module 'dp_muxEXE_litHi'
assign litGen[0:15] = ({16{zos}} & ~({16{litHiMuxSel}})) | (PCL_dcdImmd[16:31] & {16{litHiMuxSel}});

//******************
//  litGen<16:31>  *
//******************
//  litCntl[2:4] litLoMuxSel[0:1]  Output                            Comments
//---------------------------------------------------------------------------------------
//      000           00           PCL_dcdImmd[16:31]                Immediate Field
//      001           01           <*6>gnd!,PCL_dcdImmd[16:20,11:15] spr/dcr Addr
//      010           10           <*2>PCL_dcdImmd[16:20],<*6>vdd!   smr
//      011           11           16'hffff                          Ones
//      100           11           16'h0000                          Zeroes
//      101           11           16'h0010                          mtfmsr
//      110           11           16'hffef                          (not used)
//      111           11           16'hffff                          (not used)

wire [0:1] litLoMuxSel;

assign litLoMuxSel[0] = litCntl[2] | litCntl[3];
assign litLoMuxSel[1] = litCntl[2] | litCntl[4];

//dp_muxEXE_litLo  muxEXE_litLo( .Z(litGen[16:31]),
//                               .D0(PCL_dcdImmd[16:31]),
//                               .D1({6'b000000,PCL_dcdImmd[16:20],PCL_dcdImmd[11:15]}),
//                               .D2({{2{PCL_dcdImmd[16:20]}},6'b111111}),
//                               .D3({{11{litCntl[3]}},litCntl[4],{4{litCntl[3]}}}),
//                               .SD0({16{litLoMuxSel[0]}}),
//                               .SD1({16{litLoMuxSel[1]}}));
// Removed the module 'dp_muxEXE_litLo'
reg [16:31] muxEXE_litLo_muxout;
assign litGen[16:31] = muxEXE_litLo_muxout[16:31];
always @(litLoMuxSel or PCL_dcdImmd or PCL_dcdImmd or PCL_dcdImmd or litCntl)  
    begin                                           
    case({litLoMuxSel[0],litLoMuxSel[1]})
     2'b00: muxEXE_litLo_muxout[16:31] = PCL_dcdImmd[16:31];
     2'b01: muxEXE_litLo_muxout[16:31] = {6'b000000,PCL_dcdImmd[16:20],PCL_dcdImmd[11:15]};    
     2'b10: muxEXE_litLo_muxout[16:31] = {{2{PCL_dcdImmd[16:20]}},6'b111111};    
     2'b11: muxEXE_litLo_muxout[16:31] = {{11{litCntl[3]}},litCntl[4],{4{litCntl[3]}}};    
      default: muxEXE_litLo_muxout[16:31] = 16'bx;        
    endcase                                    
   end 

endmodule
