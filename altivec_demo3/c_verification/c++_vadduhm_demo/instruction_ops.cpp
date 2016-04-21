#include "ppc_altivec.h"

void vadduhm(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){                                                               
    for (int i = 0; i < ARRAY_SIZE(r.u16); i++) {                  
        r.u16[i] = a.u16[i] + b.u16[i];             
    }                                                               
}
