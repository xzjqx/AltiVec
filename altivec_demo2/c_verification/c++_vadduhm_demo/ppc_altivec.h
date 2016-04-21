#include <vector>

/* Altivec registers (128 bits) */
union ppc_avr_t {
    unsigned char u8[16];
    unsigned short u16[8];
    unsigned int u32[4];
    signed char s8[16];
    signed short s16[8];
    signed int s32[4];
    unsigned long long u64[2];
    signed long long s64[2];
};

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

void vadduhm(ppc_avr_t &r, ppc_avr_t &a, ppc_avr_t &b);
