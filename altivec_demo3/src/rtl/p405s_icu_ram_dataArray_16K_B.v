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

module p405s_icu_ram_dataArray_16K_B( dataOutB, 
                                      CB,
                                      byteWrite, 
                                      cycleDataRamB, 
                                      dataIn,
                                      dataIndexB, 
                                      readWrB,
                                      bist_mode,
                                      bist_ce_n,
                                      bist_we_n,
                                      bist_addr,
                                      bist_rd_data,
                                      bist_wr_data,
                                      cap_mem_addr,
                                      cap_mem_wr_data,
                                      cap_mem_we
                                      );

input  cycleDataRamB;
input  readWrB;

output [0:127]  dataOutB;

input [0:15]   byteWrite;
input          CB;
input [0:9]    dataIndexB;
input [0:127]  dataIn;

// RAM BIST IO

input           bist_mode;
input           bist_ce_n;
input           bist_we_n;
input [8:0]     bist_addr;
input [127:0]   bist_wr_data;
output [127:0]  bist_rd_data;
output [8:0]    cap_mem_addr;
output [127:0]  cap_mem_wr_data;
output          cap_mem_we;


p405s_icu_SRAM_512wordsX128bits
 dataB( 
               .dataOutA0    ({dataOutB[0], dataOutB[64], dataOutB[24],
                               dataOutB[88], dataOutB[1], dataOutB[65], 
                               dataOutB[25], dataOutB[89]}), 
               .dataOutA1    ({dataOutB[2], dataOutB[66], dataOutB[26],
                               dataOutB[90], dataOutB[3], dataOutB[67], 
                               dataOutB[27], dataOutB[91]}),
               .dataOutA2    ({dataOutB[4], dataOutB[68], dataOutB[28], 
                               dataOutB[92], dataOutB[5], dataOutB[69],
                               dataOutB[29], dataOutB[93]}), 
               .dataOutA3    ({dataOutB[6], dataOutB[70], dataOutB[30],
                               dataOutB[94], dataOutB[7], dataOutB[71], 
                               dataOutB[31], dataOutB[95]}), 
               .dataOutA4    ({dataOutB[8], dataOutB[72], dataOutB[16],
                               dataOutB[80], dataOutB[9], dataOutB[73], 
                               dataOutB[17], dataOutB[81]}),
               .dataOutA5    ({dataOutB[10], dataOutB[74], dataOutB[18], 
                               dataOutB[82], dataOutB[11], dataOutB[75],
                               dataOutB[19], dataOutB[83]}), 
               .dataOutA6    ({dataOutB[12], dataOutB[76], dataOutB[20],
                               dataOutB[84], dataOutB[13], dataOutB[77], 
                               dataOutB[21], dataOutB[85]}), 
               .dataOutA7    ({dataOutB[14], dataOutB[78], dataOutB[22],
                               dataOutB[86], dataOutB[15], dataOutB[79], 
                               dataOutB[23], dataOutB[87]}),
               .dataOutA8    ({dataOutB[32], dataOutB[96], dataOutB[56], 
                               dataOutB[120], dataOutB[33], dataOutB[97],
                               dataOutB[57], dataOutB[121]}), 
               .dataOutA9    ({dataOutB[34], dataOutB[98], dataOutB[58],
                               dataOutB[122], dataOutB[35], dataOutB[99], 
                               dataOutB[59], dataOutB[123]}), 
               .dataOutA10   ({dataOutB[36], dataOutB[100], dataOutB[60],
                               dataOutB[124], dataOutB[37], dataOutB[101], 
                               dataOutB[61], dataOutB[125]}),
               .dataOutA11   ({dataOutB[38], dataOutB[102], dataOutB[62], 
                               dataOutB[126], dataOutB[39], dataOutB[103],
                               dataOutB[63], dataOutB[127]}), 
               .dataOutA12   ({dataOutB[40], dataOutB[104], dataOutB[48],
                               dataOutB[112], dataOutB[41], dataOutB[105], 
                               dataOutB[49], dataOutB[113]}), 
               .dataOutA13   ({dataOutB[42], dataOutB[106], dataOutB[50],
                               dataOutB[114], dataOutB[43], dataOutB[107], 
                               dataOutB[51], dataOutB[115]}),
               .dataOutA14   ({dataOutB[44], dataOutB[108], dataOutB[52], 
                               dataOutB[116], dataOutB[45], dataOutB[109],
                               dataOutB[53], dataOutB[117]}), 
               .dataOutA15   ({dataOutB[46], dataOutB[110], dataOutB[54],
                               dataOutB[118], dataOutB[47], dataOutB[111], 
                               dataOutB[55], dataOutB[119]}), 
               .addr         (dataIndexB[1:9]), 
               .byteWrite    (byteWrite[0:15]), 
               .cclk         (CB), 
               .dataInA0     ({dataIn[0], dataIn[64], dataIn[24], dataIn[88],
                               dataIn[1], dataIn[65], dataIn[25], dataIn[89]}), 
               .dataInA1     ({dataIn[2], dataIn[66], dataIn[26], dataIn[90],
                               dataIn[3], dataIn[67], dataIn[27], dataIn[91]}),
               .dataInA2     ({dataIn[4], dataIn[68], dataIn[28], dataIn[92], 
                               dataIn[5], dataIn[69], dataIn[29], dataIn[93]}),
               .dataInA3     ({dataIn[6], dataIn[70], dataIn[30], dataIn[94], 
                               dataIn[7], dataIn[71], dataIn[31], dataIn[95]}),
               .dataInA4     ({dataIn[8], dataIn[72], dataIn[16], dataIn[80], 
                               dataIn[9], dataIn[73], dataIn[17], dataIn[81]}),
               .dataInA5     ({dataIn[10], dataIn[74], dataIn[18], dataIn[82],
                               dataIn[11], dataIn[75], dataIn[19], dataIn[83]}), 
               .dataInA6     ({dataIn[12], dataIn[76], dataIn[20], dataIn[84],
                               dataIn[13], dataIn[77], dataIn[21], dataIn[85]}), 
               .dataInA7     ({dataIn[14], dataIn[78], dataIn[22], dataIn[86],
                               dataIn[15], dataIn[79], dataIn[23], dataIn[87]}), 
               .dataInA8     ({dataIn[32], dataIn[96], dataIn[56], dataIn[120],
                               dataIn[33], dataIn[97], dataIn[57], dataIn[121]}),
               .dataInA9     ({dataIn[34], dataIn[98], dataIn[58], dataIn[122], 
                               dataIn[35], dataIn[99], dataIn[59], dataIn[123]}),
               .dataInA10    ({dataIn[36], dataIn[100], dataIn[60], dataIn[124], 
                               dataIn[37], dataIn[101], dataIn[61], dataIn[125]}),
               .dataInA11    ({dataIn[38], dataIn[102], dataIn[62], dataIn[126], 
                               dataIn[39], dataIn[103], dataIn[63], dataIn[127]}),
               .dataInA12    ({dataIn[40], dataIn[104], dataIn[48], dataIn[112],
                               dataIn[41], dataIn[105], dataIn[49], dataIn[113]}), 
               .dataInA13    ({dataIn[42], dataIn[106], dataIn[50], dataIn[114],
                               dataIn[43], dataIn[107], dataIn[51], dataIn[115]}), 
               .dataInA14    ({dataIn[44], dataIn[108], dataIn[52], dataIn[116],
                               dataIn[45], dataIn[109], dataIn[53], dataIn[117]}), 
               .dataInA15    ({dataIn[46], dataIn[110], dataIn[54], dataIn[118],
                               dataIn[47], dataIn[111], dataIn[55], dataIn[119]}),
               .readWrite    (readWrB),
               .sram_cen     (~cycleDataRamB),
               .bist_mode    (bist_mode),
               .bist_ce_n    (bist_ce_n),
               .bist_we_n    (bist_we_n),
               .bist_addr    (bist_addr),
               .bist_rd_data (bist_rd_data),
               .bist_wr_data (bist_wr_data),
               .cap_mem_addr     (cap_mem_addr),
               .cap_mem_wr_data  (cap_mem_wr_data),
               .cap_mem_we       (cap_mem_we)
               );

endmodule
