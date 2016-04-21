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
// Verilog HDL for "PR_icu", "icu_vaE2Gen" "_functional"

module p405s_icu_vaG2Gen (va0E2, va1E2, va2E2, va3E2, va4E2,
                     va5E2, va6E2, va7E2, vaWrCycle, vaWrIndex, wrFlash) ;

output va0E2;
output va1E2;
output va2E2;
output va3E2;
output va4E2 ;
output va5E2;
output va6E2;
output va7E2 ;

input vaWrCycle;
input wrFlash ;
input[1:3]  vaWrIndex ;

reg         va0E2, va1E2, va2E2, va3E2, va4E2 ;
reg         va5E2, va6E2, va7E2 ; 

always @ (wrFlash or vaWrIndex or vaWrCycle)

 begin
   casez ({wrFlash, vaWrCycle, vaWrIndex[1:3]}) //synopsys parallel_case

  5'b1????: begin
            va0E2 = 1'b1; 
            va1E2 = 1'b1; 
            va2E2 = 1'b1; 
            va3E2 = 1'b1; 
            va4E2 = 1'b1; 
            va5E2 = 1'b1; 
            va6E2 = 1'b1; 
            va7E2 = 1'b1; 
           end
  5'b00???: begin
            va0E2 = 1'b0; 
            va1E2 = 1'b0; 
            va2E2 = 1'b0; 
            va3E2 = 1'b0; 
            va4E2 = 1'b0; 
            va5E2 = 1'b0; 
            va6E2 = 1'b0; 
            va7E2 = 1'b0; 
           end
  5'b01000: begin
            va0E2 = 1'b1;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end 
  5'b01001: begin
            va0E2 = 1'b0;
            va1E2 = 1'b1;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end
  5'b01010: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b1;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end
  5'b01011: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b1;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end
  5'b01100: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b1;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end
  5'b01101: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b1;
            va6E2 = 1'b0;
            va7E2 = 1'b0;
           end
  5'b01110: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b1;
            va7E2 = 1'b0;
           end
  5'b01111: begin
            va0E2 = 1'b0;
            va1E2 = 1'b0;
            va2E2 = 1'b0;
            va3E2 = 1'b0;
            va4E2 = 1'b0;
            va5E2 = 1'b0;
            va6E2 = 1'b0;
            va7E2 = 1'b1;
           end
  default: begin
            va0E2 = 1'bx;
            va1E2 = 1'bx;
            va2E2 = 1'bx;
            va3E2 = 1'bx;
            va4E2 = 1'bx;
            va5E2 = 1'bx;
            va6E2 = 1'bx;
            va7E2 = 1'bx;
           end
   endcase 
 end

endmodule
