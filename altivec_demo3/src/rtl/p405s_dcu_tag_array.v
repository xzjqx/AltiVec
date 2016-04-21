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
module p405s_dcu_tag_array (Q, CLK, CEN, WEN, A, D);

  input CLK, CEN;
  input [0:47] WEN;
  input [0:47] D;
  input [0:7] A;

  output [0:47] Q;

  reg [0:47] Q;

  reg [0:47] Q_R[0:255];

  wire [0:(256*48)-1] Q_R_ARRAY;

  wire [0:47] Q_INT;
  wire CLK_N;

  integer i;
  integer j;
  integer k;

  //Inverted clock required to generate a rising edge clock for the system 
  assign CLK_N = ~CLK;

  //256x48 Register outputs concatinated for DW mux 256x1x48 bit mux input
  assign Q_R_ARRAY = {Q_R[255],Q_R[254],Q_R[253],Q_R[252],Q_R[251],Q_R[250],Q_R[249],Q_R[248],
                      Q_R[247],Q_R[246],Q_R[245],Q_R[244],Q_R[243],Q_R[242],Q_R[241],Q_R[240],
                      Q_R[239],Q_R[238],Q_R[237],Q_R[236],Q_R[235],Q_R[234],Q_R[233],Q_R[232],
                      Q_R[231],Q_R[230],Q_R[229],Q_R[228],Q_R[227],Q_R[226],Q_R[225],Q_R[224],
                      Q_R[223],Q_R[222],Q_R[221],Q_R[220],Q_R[219],Q_R[218],Q_R[217],Q_R[216],
                      Q_R[215],Q_R[214],Q_R[213],Q_R[212],Q_R[211],Q_R[210],Q_R[209],Q_R[208],
                      Q_R[207],Q_R[206],Q_R[205],Q_R[204],Q_R[203],Q_R[202],Q_R[201],Q_R[200],
                      Q_R[199],Q_R[198],Q_R[197],Q_R[196],Q_R[195],Q_R[194],Q_R[193],Q_R[192],
                      Q_R[191],Q_R[190],Q_R[189],Q_R[188],Q_R[187],Q_R[186],Q_R[185],Q_R[184],
                      Q_R[183],Q_R[182],Q_R[181],Q_R[180],Q_R[179],Q_R[178],Q_R[177],Q_R[176],
                      Q_R[175],Q_R[174],Q_R[173],Q_R[172],Q_R[171],Q_R[170],Q_R[169],Q_R[168],
                      Q_R[167],Q_R[166],Q_R[165],Q_R[164],Q_R[163],Q_R[162],Q_R[161],Q_R[160],
                      Q_R[159],Q_R[158],Q_R[157],Q_R[156],Q_R[155],Q_R[154],Q_R[153],Q_R[152],
                      Q_R[151],Q_R[150],Q_R[149],Q_R[148],Q_R[147],Q_R[146],Q_R[145],Q_R[144],
                      Q_R[143],Q_R[142],Q_R[141],Q_R[140],Q_R[139],Q_R[138],Q_R[137],Q_R[136],
                      Q_R[135],Q_R[134],Q_R[133],Q_R[132],Q_R[131],Q_R[130],Q_R[129],Q_R[128],
                      Q_R[127],Q_R[126],Q_R[125],Q_R[124],Q_R[123],Q_R[122],Q_R[121],Q_R[120],
                      Q_R[119],Q_R[118],Q_R[117],Q_R[116],Q_R[115],Q_R[114],Q_R[113],Q_R[112],
                      Q_R[111],Q_R[110],Q_R[109],Q_R[108],Q_R[107],Q_R[106],Q_R[105],Q_R[104],
                      Q_R[103],Q_R[102],Q_R[101],Q_R[100], Q_R[99], Q_R[98], Q_R[97], Q_R[96],
                       Q_R[95], Q_R[94], Q_R[93], Q_R[92], Q_R[91], Q_R[90], Q_R[89], Q_R[88],
                       Q_R[87], Q_R[86], Q_R[85], Q_R[84], Q_R[83], Q_R[82], Q_R[81], Q_R[80],
                       Q_R[79], Q_R[78], Q_R[77], Q_R[76], Q_R[75], Q_R[74], Q_R[73], Q_R[72],
                       Q_R[71], Q_R[70], Q_R[69], Q_R[68], Q_R[67], Q_R[66], Q_R[65], Q_R[64],
                       Q_R[63], Q_R[62], Q_R[61], Q_R[60], Q_R[59], Q_R[58], Q_R[57], Q_R[56],
                       Q_R[55], Q_R[54], Q_R[53], Q_R[52], Q_R[51], Q_R[50], Q_R[49], Q_R[48],
                       Q_R[47], Q_R[46], Q_R[45], Q_R[44], Q_R[43], Q_R[42], Q_R[41], Q_R[40],
                       Q_R[39], Q_R[38], Q_R[37], Q_R[36], Q_R[35], Q_R[34], Q_R[33], Q_R[32],
                       Q_R[31], Q_R[30], Q_R[29], Q_R[28], Q_R[27], Q_R[26], Q_R[25], Q_R[24],
                       Q_R[23], Q_R[22], Q_R[21], Q_R[20], Q_R[19], Q_R[18], Q_R[17], Q_R[16],
                       Q_R[15], Q_R[14], Q_R[13], Q_R[12], Q_R[11], Q_R[10],  Q_R[9],  Q_R[8],
                        Q_R[7],  Q_R[6],  Q_R[5],  Q_R[4],  Q_R[3],  Q_R[2],  Q_R[1],  Q_R[0]};

  //DW mux 256x1x48 bit mux
  DW01_mux_any #((256*48),8,48) U0 
   ( .A(Q_R_ARRAY),.SEL(A),.MUX(Q_INT) ) ; 


  //READ (2x1x48 bit mux)
  always @ (Q_INT,WEN,D)
  begin
    for (k=0;k<48;k=k+1)
      Q[k] = WEN[k] ? Q_INT[k] : D[k];
  end

  //WRITE    
  always @ (posedge CLK_N)
  begin
    if (!CEN)
    begin
      for (i=0;i<256;i=i+1)
        for (j=0;j<48;j=j+1)
        if (!WEN[j])
          Q_R[i][j] <= D[j];
    end
  end

endmodule

