#include "ppc_altivec.h"

//TODO: add more instruction here

template <typename T>
T Chop(T x, T y) {
    //Chop function
    return x & ((1<<y)-1);
}

void vaddsws(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){
    //TODO: body of instruction
    for(int i = 0; i < 4; i ++) {
        signed int aop = a.s32[i];
        signed int bop = b.s32[i];
        if(aop > 0 && bop > 0 && aop + bop < 0)
            r.s32[i] = ((1<<31) - 1);
        else if (aop < 0 && bop < 0 && aop + bop > 0)
            r.s32[i] = (1<<31);
        else
            r.s32[i] = aop + bop;
    }
}

void vsububm(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){
    //TODO: body of instruction
    for(int i = 0; i < 16; i ++) {
        unsigned char aop = a.u8[i];
        unsigned char bop = b.u8[i];
        r.u8[i] = (unsigned char)Chop(aop + ~bop + 1, 8);
    }
}

void vavgsh(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){
    //TODO: body of instruction
    for(int i = 0; i < 8; i ++) {
        signed short aop = a.s16[i];
        signed short bop = b.s16[i];
        r.s16[i] = (signed short)Chop(((aop + bop + 1)>>1), 16);
    }
}

void vcmpequh(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){
    //TODO: body of instruction
    for(int i = 0; i < 8; i ++) {
        unsigned short aop = a.u16[i];
        unsigned short bop = b.u16[i];
        r.u16[i] = (aop == bop) ? (1<<16)-1 : 0;
    }
}

void vslb(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b){
    //TODO: body of instruction
    for(int i = 0; i < 16; i ++) {
        int sh = b.u8[i] & 0x07;
        unsigned char bop = b.u8[i];
        r.u8[i] = (unsigned char)Chop((a.u8[i]<<sh), 8);
    }
}

