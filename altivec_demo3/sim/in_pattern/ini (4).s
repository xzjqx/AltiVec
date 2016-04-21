.file   "ini.s"
.include "c2002.i"

.section .start, "wa"
.global  _start
_start:
	li r0,0
	li32 r1,_stack_ceil
	li r0,0xf00
	mtspr EVPR,r0
	li32 r0,(MSR_CE|MSR_ME|MSR_EE|MSR_AP)
	mtmsr r0

main:
	li32 r2,0x12345678
#
# random test for vaddsws
#
li         r5, 0x0000
li         r6, 0x0010
li         r10,0x0000
lvx        1,r0,r5;
lvx        2,r0,r6;
vaddsws    3,1,2;
stvx       3,r0,r10;
#
# corner test for vaddsws
#
li         r5, 0x0020
li         r6, 0x0030
li         r10,0x0010
lvx        1,r0,r5;
lvx        2,r0,r6;
vaddsws    3,1,2;
stvx       3,r0,r10;
#
# corner test for vaddsws
#
li         r5, 0x0040
li         r6, 0x0050
li         r10,0x0020
lvx        1,r0,r5;
lvx        2,r0,r6;
vaddsws    3,1,2;
stvx       3,r0,r10;
#
# corner test for vaddsws
#
li         r5, 0x0060
li         r6, 0x0070
li         r10,0x0030
lvx        1,r0,r5;
lvx        2,r0,r6;
vaddsws    3,1,2;
stvx       3,r0,r10;
#
# corner test for vaddsws
#
li         r5, 0x0080
li         r6, 0x0090
li         r10,0x0040
lvx        1,r0,r5;
lvx        2,r0,r6;
vaddsws    3,1,2;
stvx       3,r0,r10;
#
# random test for vsububm
#
li         r5, 0x00a0
li         r6, 0x00b0
li         r10,0x0050
lvx        1,r0,r5;
lvx        2,r0,r6;
vsububm    3,1,2;
stvx       3,r0,r10;
#
# corner test for vsububm
#
li         r5, 0x00c0
li         r6, 0x00d0
li         r10,0x0060
lvx        1,r0,r5;
lvx        2,r0,r6;
vsububm    3,1,2;
stvx       3,r0,r10;
#
# random test for vavgsh
#
li         r5, 0x00e0
li         r6, 0x00f0
li         r10,0x0070
lvx        1,r0,r5;
lvx        2,r0,r6;
vavgsh     3,1,2;
stvx       3,r0,r10;
#
# corner test for vavgsh
#
li         r5, 0x0100
li         r6, 0x0110
li         r10,0x0080
lvx        1,r0,r5;
lvx        2,r0,r6;
vavgsh     3,1,2;
stvx       3,r0,r10;
#
# corner test for vavgsh
#
li         r5, 0x0120
li         r6, 0x0130
li         r10,0x0090
lvx        1,r0,r5;
lvx        2,r0,r6;
vavgsh     3,1,2;
stvx       3,r0,r10;
#
# random test for vcmpequh
#
li         r5, 0x0140
li         r6, 0x0150
li         r10,0x00a0
lvx        1,r0,r5;
lvx        2,r0,r6;
vcmpequh   3,1,2;
stvx       3,r0,r10;
#
# corner test for vcmpequh
#
li         r5, 0x0160
li         r6, 0x0170
li         r10,0x00b0
lvx        1,r0,r5;
lvx        2,r0,r6;
vcmpequh   3,1,2;
stvx       3,r0,r10;
#
# random test for vslb
#
li         r5, 0x0180
li         r6, 0x0190
li         r10,0x00c0
lvx        1,r0,r5;
lvx        2,r0,r6;
vslb      3,1,2;
stvx       3,r0,r10;
#
# corner test for vslb
#
li         r5, 0x01a0
li         r6, 0x01b0
li         r10,0x00d0
lvx        1,r0,r5;
lvx        2,r0,r6;
vslb       3,1,2;
stvx       3,r0,r10;
blr
