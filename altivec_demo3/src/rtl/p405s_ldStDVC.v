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
module p405s_ldStDVC (EXE_dvc1ByteCmp, EXE_dvc2ByteCmp, dvc2L2, dvc1L2, dofDreg, PCL_dvcByteEnL2);
    output [0:3] EXE_dvc1ByteCmp;
    output [0:3] EXE_dvc2ByteCmp;
    input [0:31] dvc2L2;
    input [0:31] dvc1L2;
    input [0:31] dofDreg;
    input [0:3] PCL_dvcByteEnL2;

assign EXE_dvc1ByteCmp[0] = PCL_dvcByteEnL2[0] & (~|(dvc1L2[0:7] ^ dofDreg[0:7]));
assign EXE_dvc1ByteCmp[1] = PCL_dvcByteEnL2[1] & (~|(dvc1L2[8:15] ^ dofDreg[8:15]));
assign EXE_dvc1ByteCmp[2] = PCL_dvcByteEnL2[2] & (~|(dvc1L2[16:23] ^ dofDreg[16:23]));
assign EXE_dvc1ByteCmp[3] = PCL_dvcByteEnL2[3] & (~|(dvc1L2[24:31] ^ dofDreg[24:31]));

assign EXE_dvc2ByteCmp[0] = PCL_dvcByteEnL2[0] & (~|(dvc2L2[0:7] ^ dofDreg[0:7]));
assign EXE_dvc2ByteCmp[1] = PCL_dvcByteEnL2[1] & (~|(dvc2L2[8:15] ^ dofDreg[8:15]));
assign EXE_dvc2ByteCmp[2] = PCL_dvcByteEnL2[2] & (~|(dvc2L2[16:23] ^ dofDreg[16:23]));
assign EXE_dvc2ByteCmp[3] = PCL_dvcByteEnL2[3] & (~|(dvc2L2[24:31] ^ dofDreg[24:31]));

endmodule
