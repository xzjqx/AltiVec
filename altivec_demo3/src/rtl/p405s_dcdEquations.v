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

module p405s_dcdEquations( dcdMtCtr, dcdCrUpDate, dcdLrUpdate, dcdCtrUpForBcctr, 
   dcdDataRcLK, dcdPlaCr0En, dcdPlaMtSpr, dcdDataSprf, dcdPlaCrBfEn, dcdPlaMtcrf, 
   dcdPlaB, dcdPlaBc, dcdDataBO_2);

output          dcdMtCtr, dcdCrUpDate;
output          dcdLrUpdate, dcdCtrUpForBcctr;

input           dcdPlaMtSpr;
input   [0:9]   dcdDataSprf;
input           dcdDataRcLK;
input           dcdPlaCr0En, dcdPlaCrBfEn, dcdPlaMtcrf, dcdPlaB;
input           dcdPlaBc, dcdDataBO_2;

wire    [0:9]   dcdDataSprn;
wire            dcdMtLr;

wire dcdMtCtr_int;
assign dcdMtCtr = dcdMtCtr_int;

assign dcdDataSprn = {dcdDataSprf[5:9],dcdDataSprf[0:4]};
assign dcdMtLr = dcdPlaMtSpr & (dcdDataSprn[0:9] == 10'h008);
assign dcdMtCtr_int = dcdPlaMtSpr & (dcdDataSprn[0:9] == 10'h009);
assign dcdCrUpDate = dcdPlaCr0En | dcdPlaCrBfEn | dcdPlaMtcrf;
assign dcdLrUpdate = dcdMtLr | ((dcdPlaB | dcdPlaBc) & dcdDataRcLK);
assign dcdCtrUpForBcctr = dcdMtCtr_int | (dcdPlaBc & ~dcdDataBO_2);

endmodule
