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

module p405s_icu_ram_dataArray_16K_A( dataOutA, 
                                      CB,
                                      byteWrite, 
                                      cycleDataRamA, 
                                      dataIn,
                                      dataIndexA, 
                                      readWrA,
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
                           
input  cycleDataRamA;
input  readWrA;

output [0:127]  dataOutA;

input          CB;
input [0:15]   byteWrite;
input [0:9]    dataIndexA;
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
 dataA(
                      .dataOutA0  ({dataOutA[119], dataOutA[55], dataOutA[111],
                                    dataOutA[47], dataOutA[118], dataOutA[54], 
                                    dataOutA[110], dataOutA[46]}), 
                      .dataOutA1  ({dataOutA[117], dataOutA[53], dataOutA[109],
                                    dataOutA[45], dataOutA[116], dataOutA[52],
                                    dataOutA[108], dataOutA[44]}),
                      .dataOutA2  ({dataOutA[115], dataOutA[51], dataOutA[107], 
                                    dataOutA[43], dataOutA[114], dataOutA[50],
                                    dataOutA[106], dataOutA[42]}), 
                      .dataOutA3  ({dataOutA[113], dataOutA[49], dataOutA[105],
                                    dataOutA[41], dataOutA[112], dataOutA[48], 
                                    dataOutA[104], dataOutA[40]}), 
                      .dataOutA4  ({dataOutA[127], dataOutA[63], dataOutA[103],
                                    dataOutA[39], dataOutA[126], dataOutA[62], 
                                    dataOutA[102], dataOutA[38]}),
                      .dataOutA5  ({dataOutA[125], dataOutA[61], dataOutA[101], 
                                    dataOutA[37], dataOutA[124], dataOutA[60],
                                    dataOutA[100], dataOutA[36]}), 
                      .dataOutA6  ({dataOutA[123], dataOutA[59], dataOutA[99],
                                    dataOutA[35], dataOutA[122], dataOutA[58], 
                                    dataOutA[98], dataOutA[34]}), 
                      .dataOutA7  ({dataOutA[121],dataOutA[57], dataOutA[97],
                                    dataOutA[33], dataOutA[120], dataOutA[56], 
                                    dataOutA[96], dataOutA[32]}),
                      .dataOutA8  ({dataOutA[87], dataOutA[23], dataOutA[79], 
                                    dataOutA[15], dataOutA[86], dataOutA[22],
                                    dataOutA[78], dataOutA[14]}), 
                      .dataOutA9  ({dataOutA[85], dataOutA[21], dataOutA[77],
                                    dataOutA[13], dataOutA[84], dataOutA[20], 
                                    dataOutA[76], dataOutA[12]}), 
                      .dataOutA10 ({dataOutA[83], dataOutA[19], dataOutA[75],
                                    dataOutA[11], dataOutA[82], dataOutA[18], 
                                    dataOutA[74], dataOutA[10]}),
                      .dataOutA11 ({dataOutA[81], dataOutA[17], dataOutA[73], 
                                    dataOutA[9], dataOutA[80], dataOutA[16],
                                    dataOutA[72], dataOutA[8]}), 
                      .dataOutA12 ({dataOutA[95], dataOutA[31], dataOutA[71],
                                    dataOutA[7], dataOutA[94], dataOutA[30], 
                                    dataOutA[70], dataOutA[6]}), 
                      .dataOutA13 ({dataOutA[93], dataOutA[29], dataOutA[69],
                                    dataOutA[5], dataOutA[92], dataOutA[28], 
                                    dataOutA[68], dataOutA[4]}),
                      .dataOutA14 ({dataOutA[91], dataOutA[27], dataOutA[67], 
                                    dataOutA[3], dataOutA[90], dataOutA[26],
                                    dataOutA[66], dataOutA[2]}), 
                      .dataOutA15 ({dataOutA[89], dataOutA[25], dataOutA[65],
                                    dataOutA[1], dataOutA[88], dataOutA[24], 
                                    dataOutA[64], dataOutA[0]}),
                      .addr        (dataIndexA[1:9]), 
                      .byteWrite   (byteWrite[0:15]), 
                      .cclk        (CB), 
                      .dataInA0    ({dataIn[119], dataIn[55], dataIn[111], dataIn[47],
                                     dataIn[118], dataIn[54], dataIn[110], dataIn[46]}),
                      .dataInA1    ({dataIn[117], dataIn[53], dataIn[109], dataIn[45],
                                     dataIn[116], dataIn[52], dataIn[108], dataIn[44]}),
                      .dataInA2    ({dataIn[115], dataIn[51], dataIn[107], dataIn[43],
                                     dataIn[114], dataIn[50], dataIn[106], dataIn[42]}),
                      .dataInA3    ({dataIn[113], dataIn[49], dataIn[105], dataIn[41], 
                                     dataIn[112], dataIn[48], dataIn[104], dataIn[40]}),
                      .dataInA4    ({dataIn[127], dataIn[63], dataIn[103], dataIn[39], 
                                     dataIn[126], dataIn[62], dataIn[102], dataIn[38]}),
                      .dataInA5    ({dataIn[125], dataIn[61], dataIn[101], dataIn[37],
                                     dataIn[124], dataIn[60], dataIn[100], dataIn[36]}), 
                      .dataInA6    ({dataIn[123], dataIn[59], dataIn[99], dataIn[35],
                                     dataIn[122], dataIn[58], dataIn[98], dataIn[34]}), 
                      .dataInA7    ({dataIn[121], dataIn[57], dataIn[97], dataIn[33],
                                     dataIn[120], dataIn[56], dataIn[96], dataIn[32]}),
                      .dataInA8    ({dataIn[87], dataIn[23], dataIn[79], dataIn[15],
                                     dataIn[86], dataIn[22], dataIn[78], dataIn[14]}),
                      .dataInA9    ({dataIn[85], dataIn[21], dataIn[77], dataIn[13],
                                     dataIn[84], dataIn[20], dataIn[76], dataIn[12]}),
                      .dataInA10   ({dataIn[83], dataIn[19], dataIn[75], dataIn[11],
                                     dataIn[82], dataIn[18], dataIn[74], dataIn[10]}),
                      .dataInA11   ({dataIn[81], dataIn[17], dataIn[73], dataIn[9],
                                     dataIn[80], dataIn[16], dataIn[72], dataIn[8]}),
                      .dataInA12   ({dataIn[95], dataIn[31], dataIn[71], dataIn[7],
                                     dataIn[94], dataIn[30], dataIn[70], dataIn[6]}),
                      .dataInA13   ({dataIn[93], dataIn[29], dataIn[69], dataIn[5],
                                     dataIn[92], dataIn[28], dataIn[68], dataIn[4]}), 
                      .dataInA14   ({dataIn[91], dataIn[27], dataIn[67], dataIn[3],
                                     dataIn[90], dataIn[26], dataIn[66], dataIn[2]}), 
                      .dataInA15   ({dataIn[89], dataIn[25], dataIn[65], dataIn[1],
                                     dataIn[88], dataIn[24], dataIn[64], dataIn[0]}), 
                      .readWrite   (readWrA), 
                      .sram_cen    (~cycleDataRamA),
                      .bist_mode   (bist_mode),
                      .bist_ce_n   (bist_ce_n),
                      .bist_we_n   (bist_we_n),
                      .bist_addr   (bist_addr),
                      .bist_rd_data     (bist_rd_data),
                      .bist_wr_data     (bist_wr_data),
                      .cap_mem_addr     (cap_mem_addr),
                      .cap_mem_wr_data  (cap_mem_wr_data),
                      .cap_mem_we       (cap_mem_we)
                      );

endmodule
