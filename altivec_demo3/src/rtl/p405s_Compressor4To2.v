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
//********************************************************************************************
// Creator: L. Duane Richardson
// Date:    08/25/98
// Module:  Stealth E-Unit 4:2 Compressor
//
// Description:
//
// This verilog functional describes the Stealth E-Unit 4:2 Compressor
//
//**********************************************************************
//       International Business Machines Corporation
//
//            (C) Copyright IBM Corporation
//  All rights reserved.  No part of this software may be sold or
//  distributed in any form or by any means without the prior written
//  permission of IBM.
//
//  This file contains IBM CONFIDENTIAL PROPRIETARY INFORMATION.
//  It is part of the Stealth microprocessor core project.
//
//  Created by PowerPC Embedded Processor Solutions (PEPS) in beautiful
//  Research Triangle Park, North Carolina. Distribution of this file to
//  persons outside the PEPS organization requires the approval of PEPS
//  management.
//
//  File,Comp,Rel:  eu/rtl/eu_compressor4To2.v, eu, stealthSrc_1.0, st5.1c
//  Sccs Revision:  1.1
//  Revision Date:  98/09/15 13:21:24
//  Extract  Date:  98/10/16 12:00:27
//
//  Revision Log:
//  Date      Who       Release          Vers  Description
//  --------  --------  ---------------  ----- --------------------------
//  09/15/98  LDR                              Created
//  09/15/98  LDR       stealthSrc_1.0    1.1  put into cvmc
//
module p405s_Compressor4To2 (C, S, cout, cin, w, x, y, z);
    output C;
    output S;
    output cout;
    input cin;
    input w;
    input x;
    input y;
    input z;

wire temp1;
assign temp1 = w ^ x ^ y ^ z;

assign C = (temp1 & cin) | (~temp1 & ((w & x) | (y & z)));
assign S =  w ^ x ^ y ^ z ^ cin;
assign cout = (w | x) & (y | z);

endmodule
