//
// **************************************************************************
//
//  Copyright (c) International Business Machines Corporation, 2004.
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

// Uncomment the following line to use user specific SRAM inside the
// ram wrappters located in src/mem_models

//`define USER_SPECIFIC_RAM


// **************************************************************************
// CoreConsultant hook to determine the USER_SPECIFIC_RAM parameter


// Description:  The Artisan 130LVFSG RAMS selection will use the Artisan timing models
//                provided in the tech_lib/artisan_lv/libraries directory. Use the
//                User-specific RAM to use RAMs from your vendor.
// DefaultValue: Artisan 130LVFSG RAMS
// EnumValues:   0 1
// ValueRange:   {Artisan 130LVFSG RAMS} {User-specific RAM}
`define USER_SPECIFIC_RAM_BUTTON 1

`define USER_SPECIFIC_RAM
//
// **************************************************************************

