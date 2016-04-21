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
module p405s_logical_top (logicalCcBits, logicalOut, dlmzb, exeLogicalUnitEn_NEG, aBus,
           bBus, logicalCntl);
    output [0:2] logicalCcBits;
    output [0:31] logicalOut;
    output dlmzb;
    input exeLogicalUnitEn_NEG;
    input [0:31] aBus;
    input [0:31] bBus;
    input [0:7] logicalCntl;


// logicalCntl[0:5]
// [0]   - invertBreg
// [1]   - flipResult
// [2:5] - logicalMuxSel
// [6:7] - logicalOutMuxSel

// Gating the aBus and bBus to save power
wire [0:31] aBus_NEG, bBus_NEG;

//reg [0:31] logicalOut;
wire [0:31] logicalOut;
reg [0:31] logicalOut_i;

//dp_logEXE_logABusHiNAND2  logEXE_logABusHiNAND2(.Z(aBus_NEG[0:15]),
//                                                .A(aBus[0:15]),
//                                                .B(exeLogicalUnitEn_NEG));
// Removed the module 'dp_logEXE_logABusHiNAND2'
assign aBus_NEG[0:15] = ~(aBus[0:15] & ~({(16){exeLogicalUnitEn_NEG}}) );

//dp_logEXE_logABusLoNAND2  logEXE_logABusLoNAND2(.Z(aBus_NEG[16:31]),
//                                                .A(aBus[16:31]),
//                                                .B(exeLogicalUnitEn_NEG));
// Removed the module 'dp_logEXE_logABusLoNAND2'
assign aBus_NEG[16:31] = ~(aBus[16:31] & ~({(16){exeLogicalUnitEn_NEG}}) );

//dp_logEXE_logBBusHiNAND2  logEXE_logBBusHiNAND2(.Z(bBus_NEG[0:15]),
//                                                .A(bBus[0:15]),
//                                                .B(exeLogicalUnitEn_NEG));
// Removed the module 'dp_logEXE_logBBusHiNAND2'
assign bBus_NEG[0:15] = ~(bBus[0:15] & ~({(16){exeLogicalUnitEn_NEG}}) );

//dp_logEXE_logBBusLoNAND2  logEXE_logBBusLoNAND2(.Z(bBus_NEG[16:31]),
//                                                .A(bBus[16:31]),
//                                                .B(exeLogicalUnitEn_NEG));
// Removed the module 'dp_logEXE_logBBusLoNAND2'
assign bBus_NEG[16:31] = ~(bBus[16:31] & ~({(16){exeLogicalUnitEn_NEG}}) );


wire [0:31] bBus_INV;
//dp_logEXE_logicalInvbBus  logEXE_logicalInvbBus(.Z(bBus_INV[0:31]),
//                                                .A(bBus_NEG[0:31]),
//                                                .B({32{logicalCntl[0]}}));
// Removed the module 'dp_logEXE_logicalInvbBus'
assign bBus_INV[0:31] = bBus_NEG[0:31] ^ {32{logicalCntl[0]}};


wire [0:31] logNAND;
//dp_logEXE_logicalNAND   logEXE_logicalNAND(.Z(logNAND[0:31]),
//                                           .A(bBus_INV[0:31]),
//                                           .B(aBus_NEG[0:31]));
// Removed the module 'dp_logEXE_logicalNAND'
assign logNAND[0:31] = bBus_INV[0:31] | aBus_NEG[0:31];

wire [0:31] logOR;
//dp_logEXE_logicalOR   logEXE_logicalOR(.Z(logOR[0:31]),
//                                       .A(bBus_INV[0:31]),
//                                       .B(aBus_NEG[0:31]));
// Removed the module 'dp_logEXE_logicalOR'
assign logOR[0:31] = ~( bBus_INV[0:31] & aBus_NEG[0:31] );

wire [0:31] logXOR;
//dp_logEXE_logicalXOR   logEXE_logicalXOR(.Z(logXOR[0:31]),
//                                         .A(logOR[0:31]),
//                                         .B(logNAND[0:31]));
// Removed the module 'dp_logEXE_logicalXOR'
assign logXOR[0:31] = ~( logOR[0:31] & logNAND[0:31] );


wire [0:31] logical_NEG, logicalMuxOut;
//dp_muxEXE_logical   muxEXE_logical(.Z(logical_NEG[0:31]),
//                                             .D0({{16{aBus_NEG[16]}},aBus_NEG[16:31]}),
//                                             .D1(logXOR[0:31]),
//                                             .D2(logOR[0:31]),
//                                             .D3(logNAND[0:31]),
//                                             .SD(logicalCntl[2:3]));
//dp_logEXE_logicalMux   logEXE_logicalMux(.Z(logicalMuxOut[0:31]),
//                                         .A1({{16{aBus_NEG[16]}},aBus_NEG[16:31]}),
//                                         .A2({32{logicalCntl[2]}}),
//                                         .B1(logXOR[0:31]),
//                                         .B2({32{logicalCntl[3]}}),
//                                         .C1(logOR[0:31]),
//                                         .C2({32{logicalCntl[4]}}),
//                                         .D1(logNAND[0:31]),
//                                         .D2({32{logicalCntl[5]}}));
// Removed the module 'dp_logEXE_logicalMux'
assign logicalMuxOut[0:31] = ({{16{aBus_NEG[16]}},aBus_NEG[16:31]} & {32{logicalCntl[2]}}) 
   | (logXOR[0:31] & {32{logicalCntl[3]}}) 
   | (logOR[0:31] & {32{logicalCntl[4]}}) 
   | (logNAND[0:31] & {32{logicalCntl[5]}});

//dp_logEXE_logicalInv       logEXE_logicalInv(.Z(logical_NEG[0:31]),
//                                             .A(logicalMuxOut[0:31]));
// Removed the module 'dp_logEXE_logicalInv'
assign logical_NEG[0:31] = ~(logicalMuxOut[0:31]);

wire [0:31] logical_INV;
//dp_logEXE_logicalInvRslt   logEXE_logicalInvRslt(.Z(logical_INV[0:31]),
//                                             .A(logical_NEG[0:31]),
//                                             .B({32{logicalCntl[1]}}));
// Removed the module 'dp_logEXE_logicalInvRslt'
//mark by clp
assign logical_INV[0:31] = logical_NEG[0:31] ^ {32{logicalCntl[1]}};


reg [0:5] cntlzwOut;
reg [0:3] dlmzbOut;
reg [0:2] dlmzbCcBits;
wire [0:7] byteEq0;

// Zero byte detection for dlmzb.
assign byteEq0[0] = ~&aBus_NEG[0:7];
assign byteEq0[1] = ~&aBus_NEG[8:15];
assign byteEq0[2] = ~&aBus_NEG[16:23];
assign byteEq0[3] = ~&aBus_NEG[24:31];

assign byteEq0[4] = ~&bBus_NEG[0:7];
assign byteEq0[5] = ~&bBus_NEG[8:15];
assign byteEq0[6] = ~&bBus_NEG[16:23];
assign byteEq0[7] = ~&bBus_NEG[24:31];

always @(aBus_NEG or byteEq0)
begin
// cntlzw.
      casez(aBus_NEG) // synopsys full_case parallel_case
            32'b11111111111111111111111111111111: cntlzwOut = 6'h1f;
            32'b11111111111111111111111111111110: cntlzwOut = 6'h20;
            32'b1111111111111111111111111111110?: cntlzwOut = 6'h21;
            32'b111111111111111111111111111110??: cntlzwOut = 6'h22;
            32'b11111111111111111111111111110???: cntlzwOut = 6'h23;
            32'b1111111111111111111111111110????: cntlzwOut = 6'h24;
            32'b111111111111111111111111110?????: cntlzwOut = 6'h25;
            32'b11111111111111111111111110??????: cntlzwOut = 6'h26;
            32'b1111111111111111111111110???????: cntlzwOut = 6'h27;
            32'b111111111111111111111110????????: cntlzwOut = 6'h28;
            32'b11111111111111111111110?????????: cntlzwOut = 6'h29;
            32'b1111111111111111111110??????????: cntlzwOut = 6'h2a;
            32'b111111111111111111110???????????: cntlzwOut = 6'h2b;
            32'b11111111111111111110????????????: cntlzwOut = 6'h2c;
            32'b1111111111111111110?????????????: cntlzwOut = 6'h2d;
            32'b111111111111111110??????????????: cntlzwOut = 6'h2e;
            32'b11111111111111110???????????????: cntlzwOut = 6'h2f;
            32'b1111111111111110????????????????: cntlzwOut = 6'h30;
            32'b111111111111110?????????????????: cntlzwOut = 6'h31;
            32'b11111111111110??????????????????: cntlzwOut = 6'h32;
            32'b1111111111110???????????????????: cntlzwOut = 6'h33;
            32'b111111111110????????????????????: cntlzwOut = 6'h34;
            32'b11111111110?????????????????????: cntlzwOut = 6'h35;
            32'b1111111110??????????????????????: cntlzwOut = 6'h36;
            32'b111111110???????????????????????: cntlzwOut = 6'h37;
            32'b11111110????????????????????????: cntlzwOut = 6'h38;
            32'b1111110?????????????????????????: cntlzwOut = 6'h39;
            32'b111110??????????????????????????: cntlzwOut = 6'h3a;
            32'b11110???????????????????????????: cntlzwOut = 6'h3b;
            32'b1110????????????????????????????: cntlzwOut = 6'h3c;
            32'b110?????????????????????????????: cntlzwOut = 6'h3d;
            32'b10??????????????????????????????: cntlzwOut = 6'h3e;
            32'b0???????????????????????????????: cntlzwOut = 6'h3f;
            default:                              cntlzwOut = 6'bxxxxxx;
         endcase
// dlmzb.
   casez(byteEq0) //synopsys full_case parallel_case
   8'b11111111:begin
      dlmzbOut[0:3] = 4'h7;
      dlmzbCcBits[0:2] = 3'b001;
   end
   8'b11111110:begin
      dlmzbOut[0:3] = 4'h7;
      dlmzbCcBits[0:2] = 3'b100;
   end
   8'b1111110?:begin
      dlmzbOut[0:3] = 4'h8;
      dlmzbCcBits[0:2] = 3'b100;
   end
   8'b111110??:begin
      dlmzbOut[0:3] = 4'h9;
      dlmzbCcBits[0:2] = 3'b100;
   end
   8'b11110???:begin
      dlmzbOut[0:3] = 4'ha;
      dlmzbCcBits[0:2] = 3'b100;
   end
   8'b1110????:begin
      dlmzbOut[0:3] = 4'hb;
      dlmzbCcBits[0:2] = 3'b010;
   end
   8'b110?????:begin
      dlmzbOut[0:3] = 4'hc;
      dlmzbCcBits[0:2] = 3'b010;
   end
   8'b10??????:begin
      dlmzbOut[0:3] = 4'hd;
      dlmzbCcBits[0:2] = 3'b010;
   end
   8'b0???????:begin
      dlmzbOut[0:3] = 4'he;
      dlmzbCcBits[0:2] = 3'b010;
   end
// x catcher.
   default:begin
      dlmzbOut[0:3] = 4'hx;
      dlmzbCcBits[0:2] = 3'bxxx;
   end
   endcase
end


//dp_muxEXE_logicalOut   muxEXE_logicalOut(.Z(logicalOut[0:31]),
//                                         .D0(logical_INV[0:31]),
//                                         .D1({{26{1'b1}},cntlzwOut[0:5]}),
//                                         .D2({{24{aBus_NEG[24]}},aBus_NEG[24:31]}),
//                                         .D3({{28{1'b1}},dlmzbOut[0:3]}),
//                                         .SD(logicalCntl[6:7]));
// Removed the module 'dp_muxEXE_logicalOut'
assign logicalOut = logicalOut_i;
always @(logicalCntl or logical_INV or cntlzwOut or aBus_NEG or dlmzbOut or logicalCntl)
    begin                                           
    case(logicalCntl[6:7])
     2'b00: logicalOut_i[0:31] = ~(logical_INV[0:31]);
     2'b01: logicalOut_i[0:31] = ~({{26{1'b1}},cntlzwOut[0:5]});
     2'b10: logicalOut_i[0:31] = ~({{24{aBus_NEG[24]}},aBus_NEG[24:31]});
     2'b11: logicalOut_i[0:31] = ~({{28{1'b1}},dlmzbOut[0:3]});   
      default: logicalOut_i[0:31] = 32'bx;   
    endcase                                    
   end

wire logZeroDetect_NEG, dlmzb;
wire dlmzb_i;
assign dlmzb = dlmzb_i;
assign  logZeroDetect_NEG = |logicalOut_i[0:31];
assign  dlmzb_i = logicalCntl[6] & logicalCntl[7];

assign logicalCcBits[0] = (logicalOut_i[0] & ~dlmzb_i) |
                          (dlmzbCcBits[0] & dlmzb_i);

assign logicalCcBits[1] = (~logicalOut_i[0] & logZeroDetect_NEG & ~dlmzb_i) |
                          (dlmzbCcBits[1] & dlmzb_i);

assign logicalCcBits[2] = (~logZeroDetect_NEG & ~dlmzb_i) |
                          (dlmzbCcBits[2] & dlmzb_i);


endmodule
