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
// Changes :
//          Date        By Whom       Description
//       ~~~~~~~~~~    ~~~~~~~~~      ~~~~~~~~~~~
//-----------------------------------------------------------------------------------
//          
//        07/13/01        JBB         Widened PCL_vctSprDcds bus for MCSR and MCSRS
//-----------------------------------------------------------------------------------
//        10/05/01        JBB         Added another bit to PCL_vctSprDcds bus for CCR1 
//                                    (defect 1935)
//----------------------------------------------------------------------------------- 
//        10/11/01        JBB         Removed the PCL_vctSprDcds bit added for the above
//                                    defect (defect 1955)
//-----------------------------------------------------------------------------------
//        10/17/01        JBB         Removed the PCL_vctSprDcds bit originally added
//                                    for MCSRS (defect 1971)
//-----------------------------------------------------------------------------------

//***********************************************************************************

module p405s_sprMux_top (sprBusEnd, DBG_sprDataBus, EXE_xer,
           EXE_xerSIL, IFB_sprDataBus, JTG_sprDataBus, PCL_mfDCRL2,
           PCL_exeMfspr, TIM_sprDataBus, VCT_sprDataBus, XXX_dcrDataBus,
           ICU_sprDataBus, MMU_sprDataBus, sprDataBus,
           PCL_sprHold, CB, dac1L2, dac2L2, PCL_exeMtspr, 
           dvc1L2, dvc2L2, PCL_timSprDcds, PCL_dbgSprDcds, PCL_exeSprDcds,
           PCL_vctSprDcds);
    output [0:31] sprBusEnd;
    output [0:31] dac1L2;
    output [0:31] dac2L2;
    output [0:31] dvc1L2;
    output [0:31] dvc2L2;
    input PCL_mfDCRL2;
    input PCL_exeMfspr;
    input [0:5] PCL_timSprDcds;
    input [0:3] PCL_dbgSprDcds;
    input [0:4] PCL_exeSprDcds;

//  input [0:4] PCL_vctSprDcds;                                    
//  input [0:7] PCL_vctSprDcds;       // MCSR, MCSRS, and another bit for CCR1
//  input [0:6] PCL_vctSprDcds;       // Two extra bits for MCSR and MCSRS
    input [0:5] PCL_vctSprDcds;       // Removed the bit for MCSRS
    
    input [0:2] EXE_xer;
    input [0:6] EXE_xerSIL;
    input [0:31] IFB_sprDataBus;
    input [0:31] JTG_sprDataBus;
    input [0:31] DBG_sprDataBus;
    input [0:31] TIM_sprDataBus;
    input [0:31] VCT_sprDataBus;
    input [0:31] XXX_dcrDataBus;
    input [0:31] ICU_sprDataBus;
    input [0:31] MMU_sprDataBus;
    input [0:31] sprDataBus;
    input PCL_sprHold;
    input PCL_exeMtspr;
    //input [0:4] CB;
    input CB;

    wire dbgRegsDcd, timRegsDcd, vctRegsDcd, dacDvcRegsDcd, xerDcd;
    wire [0:1] sprGrpMuxSel, sprTopMuxSel, sprDacDvcMuxSel;
    wire [0:31] sprIfbMmuJtgIcu, sprMmuIcu, sprIfbJtg;

reg [0:31] sprDacDvcOut;
reg [0:31] sprGprOut;
reg [0:31] sprBusEnd;
reg [0:31] dac1L2_i;
wire [0:31] dac1L2;
reg [0:31] dac2L2_i;
wire [0:31] dac2L2;
reg [0:31] dvc1L2_i;
wire [0:31] dvc1L2;
reg [0:31] dvc2L2_i;
wire [0:31] dvc2L2;

// fixed point xer.
assign xerDcd = PCL_exeSprDcds[4];

assign dbgRegsDcd = |(PCL_dbgSprDcds[0:3]);

assign timRegsDcd = |(PCL_timSprDcds[0:5]);

//assign vctRegsDcd =  |(PCL_vctSprDcds[0:4]);
//assign vctRegsDcd =  |(PCL_vctSprDcds[0:7]);
//assign vctRegsDcd =  |(PCL_vctSprDcds[0:6]);
assign vctRegsDcd =  |(PCL_vctSprDcds[0:5]);

assign dacDvcRegsDcd = |(PCL_exeSprDcds[0:3]);

// sprDacDvcMuxSel[0:1]
// 00 -  dac1
// 01 -  dac2
// 10 -  dvc1
// 11 -  dvc2
assign sprDacDvcMuxSel[0] = PCL_exeSprDcds[2] | PCL_exeSprDcds[3];
assign sprDacDvcMuxSel[1] = PCL_exeSprDcds[1] | PCL_exeSprDcds[3];

// sprGrpMuxSel[0:1]
// 00 -  TIM SPR BUS
// 01 -  DBG SPR BUS
// 10 -  XER REG
// 11 -  VCT SPR BUS
assign sprGrpMuxSel[0] = xerDcd | vctRegsDcd;
assign sprGrpMuxSel[1] = dbgRegsDcd | vctRegsDcd;

// sprTopMuxSel[0:1]
// 00 -  sprIfbMmuJtgIcu SPR BUS
// 01 -  DacDvc SPR MUX
// 10 -  sprGprOut SPR BUS
// 11 -  XXX SPR BUS
assign sprTopMuxSel[0] = PCL_mfDCRL2 |
                         (PCL_exeMfspr & (xerDcd | dbgRegsDcd | timRegsDcd | vctRegsDcd));
assign sprTopMuxSel[1] = PCL_mfDCRL2 |
                         (PCL_exeMfspr & dacDvcRegsDcd);

//************************************************************************
// DAC DVC MUX
//************************************************************************
//dp_muxEXE_sprDacDvc muxEXE_sprDacDvc(.Z(sprDacDvcOut[0:31]),
//                                 .D0(dac1L2[0:31]),
//                                 .D1(dac2L2[0:31]),
//                                 .D2(dvc1L2[0:31]),
//                                 .D3(dvc2L2[0:31]),
//                                 .SD(sprDacDvcMuxSel[0:1]));
// Removed the module 'dp_muxEXE_sprDacDvc'
assign dac1L2 = dac1L2_i;
assign dac2L2 = dac2L2_i;
assign dvc1L2 = dvc1L2_i;
assign dvc2L2 = dvc2L2_i;
always @(dac1L2_i or dac2L2_i or dvc1L2_i or dvc2L2_i or sprDacDvcMuxSel)
    begin                                           
    case(sprDacDvcMuxSel[0:1])                     
     2'b00: sprDacDvcOut[0:31] = dac1L2_i[0:31];
     2'b01: sprDacDvcOut[0:31] = dac2L2_i[0:31];    
     2'b10: sprDacDvcOut[0:31] = dvc1L2_i[0:31];    
     2'b11: sprDacDvcOut[0:31] = dvc2L2_i[0:31];    
      default: sprDacDvcOut[0:31] = 32'bx;   
    endcase                                    
   end 

//************************************************************************
// SPR GRP MUX
//************************************************************************
//dp_muxEXE_sprGrp   muxEXE_sprGrp(.Z(sprGprOut[0:31]),
//                                 .D0(TIM_sprDataBus[0:31]),
//                                 .D1(DBG_sprDataBus[0:31]),
//                                 .D2({EXE_xer[0:2],{22{1'b0}},EXE_xerSIL[0:6]}),
//                                 .D3(VCT_sprDataBus[0:31]),
//                                 .SD(sprGrpMuxSel[0:1]));
// Removed the module 'dp_muxEXE_sprGrp'
always @(sprGrpMuxSel or TIM_sprDataBus or DBG_sprDataBus or EXE_xer or EXE_xerSIL or VCT_sprDataBus)
    begin                                           
    case(sprGrpMuxSel[0:1])                     
     2'b00: sprGprOut[0:31] = TIM_sprDataBus[0:31];
     2'b01: sprGprOut[0:31] = DBG_sprDataBus[0:31];    
     2'b10: sprGprOut[0:31] = {EXE_xer[0:2],{22{1'b0}},EXE_xerSIL[0:6]};    
     2'b11: sprGprOut[0:31] = VCT_sprDataBus[0:31];    
      default: sprGprOut[0:31] = 32'bx;   
    endcase                                    
   end 


//************************************************************************
// SPR TOP MUX
//************************************************************************
//dp_logEXE_sprMmuIcuNOR2   logEXE_sprMmuIcuNOR2(.Z(sprMmuIcu[0:31]),
//                                               .A(MMU_sprDataBus[0:31]),
//                                               .B(ICU_sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprMmuIcuNOR2'
assign sprMmuIcu[0:31] = ~( MMU_sprDataBus[0:31] | ICU_sprDataBus[0:31] );

//dp_logEXE_sprIfbJtgNOR2   logEXE_sprIfbJtgNOR2(.Z(sprIfbJtg[0:31]),
//                                               .A(IFB_sprDataBus[0:31]),
//                                               .B(JTG_sprDataBus[0:31]));
// Removed the module 'dp_logEXE_sprIfbJtgNOR2'
assign sprIfbJtg[0:31] = ~( IFB_sprDataBus[0:31] | JTG_sprDataBus[0:31] );

//dp_logEXE_sprIfbMmuJtgIcuNAND2   logEXE_sprIfbMmuJtgIcuNAND2(.Z(sprIfbMmuJtgIcu[0:31]),
//                                                             .A(sprMmuIcu[0:31]),
//                                                             .B(sprIfbJtg[0:31]));
// Removed the module 'dp_logEXE_sprIfbMmuJtgIcuNAND2'
assign sprIfbMmuJtgIcu[0:31] = ~( sprMmuIcu[0:31] & sprIfbJtg[0:31] );

//dp_muxEXE_sprTop   muxEXE_sprTop(.Z(sprBusEnd[0:31]),
//                                 .D0(sprIfbMmuJtgIcu[0:31]),
//                                 .D1(sprDacDvcOut[0:31]),
//                                 .D2(sprGprOut[0:31]),
//                                 .D3(XXX_dcrDataBus[0:31]),
//                                 .SD(sprTopMuxSel[0:1]));
// Removed the module 'dp_muxEXE_sprTop'
always @(sprTopMuxSel or sprIfbMmuJtgIcu or sprDacDvcOut or sprGprOut or XXX_dcrDataBus)
    begin                                           
    case(sprTopMuxSel[0:1])                     
     2'b00: sprBusEnd[0:31] = sprIfbMmuJtgIcu[0:31];    
     2'b01: sprBusEnd[0:31] = sprDacDvcOut[0:31];    
     2'b10: sprBusEnd[0:31] = sprGprOut[0:31];    
     2'b11: sprBusEnd[0:31] = XXX_dcrDataBus[0:31];    
      default: sprBusEnd[0:31] = 32'bx;   
    endcase                                    
   end 

wire dac1E2, dac2E2, dvc1E2, dvc2E2;
assign dac1E2 = PCL_exeMtspr & PCL_exeSprDcds[0] & ~PCL_sprHold;
assign dac2E2 = PCL_exeMtspr & PCL_exeSprDcds[1] & ~PCL_sprHold;
assign dvc1E2 = PCL_exeMtspr & PCL_exeSprDcds[2] & ~PCL_sprHold;
assign dvc2E2 = PCL_exeMtspr & PCL_exeSprDcds[3] & ~PCL_sprHold;

//************************************************************************
// DAC1 Latch
//************************************************************************
//dp_regEXE_DAC1   regEXE_DAC1(.E2(dac1E2),
//                             .E1(PCL_exeMtspr),
//                             .D(sprDataBus[0:31]),
//                             .I(SI),
//                             .CB(CB[0:4]),
//                             .L2(dac1L2_i[0:31]),
//                             .SO(dac1SO));
// Removed the module 'dp_regEXE_DAC1'
always @(posedge CB)      
    begin                                       
    casez(PCL_exeMtspr & dac1E2)
     1'b0: dac1L2_i[0:31] <= dac1L2_i[0:31];                
     1'b1: dac1L2_i[0:31] <= sprDataBus[0:31];            
      default: dac1L2_i[0:31] <= 32'bx;  
    endcase                             
   end
//************************************************************************
// DAC2 Latch
//************************************************************************
//dp_regEXE_DAC2   regEXE_DAC2(.E2(dac2E2),
//                             .E1(PCL_exeMtspr),
//                             .D(sprDataBus[0:31]),
//                             .I(dac1SO),
//                             .CB(CB[0:4]),
//                             .L2(dac2L2_i[0:31]),
//                             .SO(dac2SO));
// Removed the module 'dp_regEXE_DAC2'
always @(posedge CB)      
    begin                                       
    casez(PCL_exeMtspr & dac2E2)
     1'b0: dac2L2_i[0:31] <= dac2L2_i[0:31];                
     1'b1: dac2L2_i[0:31] <= sprDataBus[0:31]; 
      default: dac2L2_i[0:31] <= 32'bx;  
    endcase                             
   end 
//************************************************************************
// DVC1 Latch
//************************************************************************
//dp_regEXE_DVC1   regEXE_DVC1(.E2(dvc1E2),
//                             .E1(PCL_exeMtspr),
//                             .D(sprDataBus[0:31]),
//                             .I(dac2SO),
//                             .CB(CB[0:4]),
//                             .L2(dvc1L2_i[0:31]),
//                             .SO(dvc1SO));
// Removed the module 'dp_regEXE_DVC1'
always @(posedge CB)      
    begin                                       
    casez(PCL_exeMtspr & dvc1E2)
     1'b0: dvc1L2_i[0:31] <= dvc1L2_i[0:31];                
     1'b1: dvc1L2_i[0:31] <= sprDataBus[0:31];            
      default: dvc1L2_i[0:31] <= 32'bx;  
    endcase                             
   end
//************************************************************************
// DVC2 Latch
//************************************************************************
//dp_regEXE_DVC2   regEXE_DVC2(.E2(dvc2E2),
//                             .E1(PCL_exeMtspr),
//                             .D(sprDataBus[0:31]),
//                             .I(dvc1SO),
//                             .CB(CB[0:4]),
//                             .L2(dvc2L2_i[0:31]),
//                             .SO(SO));
// Removed the module 'dp_regEXE_DVC2'
always @(posedge CB)      
    begin                                       
    casez(PCL_exeMtspr & dvc2E2)
     1'b0: dvc2L2_i[0:31] <= dvc2L2_i[0:31];                
     1'b1: dvc2L2_i[0:31] <= sprDataBus[0:31];
      default: dvc2L2_i[0:31] <= 32'bx;  
    endcase                             
   end 

endmodule
