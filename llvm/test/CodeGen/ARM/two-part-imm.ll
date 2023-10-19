; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi %s -o - | FileCheck %s --check-prefix=CHECK-ARM
; RUN: llc -mtriple=thumb-eabi -mcpu=arm1156t2-s -mattr=+thumb2 %s -o - \
; RUN:   | FileCheck %s --check-prefix=CHECK-THUMB2

;; Check how immediates are handled in add/sub.

define i32 @sub0(i32 %0) {
; CHECK-ARM-LABEL: sub0:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    sub r0, r0, #23
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: sub0:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    subs r0, #23
; CHECK-THUMB2-NEXT:    bx lr
  %2 = sub i32 %0, 23
  ret i32 %2
}

define i32 @sub1(i32 %0) {
; CHECK-ARM-LABEL: sub1:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI1_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI1_0:
; CHECK-ARM-NEXT:    .long 4294836225 @ 0xfffe0001
;
; CHECK-THUMB2-LABEL: sub1:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movs r1, #1
; CHECK-THUMB2-NEXT:    movt r1, #65534
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = sub i32 %0, 131071
  ret i32 %2
}

define i32 @sub2(i32 %0) {
; CHECK-ARM-LABEL: sub2:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    sub r0, r0, #35
; CHECK-ARM-NEXT:    sub r0, r0, #8960
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: sub2:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #8995
; CHECK-THUMB2-NEXT:    subs r0, r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = sub i32 %0, 8995
  ret i32 %2
}

define i32 @sub3(i32 %0) {
; CHECK-ARM-LABEL: sub3:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI3_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI3_0:
; CHECK-ARM-NEXT:    .long 4292870571 @ 0xffe001ab
;
; CHECK-THUMB2-LABEL: sub3:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #427
; CHECK-THUMB2-NEXT:    movt r1, #65504
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = sub i32 %0, 2096725
  ret i32 %2
}

define i32 @sub4(i32 %0) {
; CHECK-ARM-LABEL: sub4:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI4_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI4_0:
; CHECK-ARM-NEXT:    .long 4286505147 @ 0xff7ee0bb
;
; CHECK-THUMB2-LABEL: sub4:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #57531
; CHECK-THUMB2-NEXT:    movt r1, #65406
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = sub i32 %0, 8462149
  ret i32 %2
}
define i32 @add0(i32 %0) {
; CHECK-ARM-LABEL: add0:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    add r0, r0, #23
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: add0:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    adds r0, #23
; CHECK-THUMB2-NEXT:    bx lr
  %2 = add i32 %0, 23
  ret i32 %2
}

define i32 @add1(i32 %0) {
; CHECK-ARM-LABEL: add1:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI6_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI6_0:
; CHECK-ARM-NEXT:    .long 131071 @ 0x1ffff
;
; CHECK-THUMB2-LABEL: add1:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #65535
; CHECK-THUMB2-NEXT:    movt r1, #1
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = add i32 %0, 131071
  ret i32 %2
}

define i32 @add2(i32 %0) {
; CHECK-ARM-LABEL: add2:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    add r0, r0, #8960
; CHECK-ARM-NEXT:    add r0, r0, #2293760
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: add2:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    add.w r0, r0, #2293760
; CHECK-THUMB2-NEXT:    add.w r0, r0, #8960
; CHECK-THUMB2-NEXT:    bx lr
  %2 = add i32 %0, 2302720
  ret i32 %2
}

define i32 @add3(i32 %0) {
; CHECK-ARM-LABEL: add3:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI8_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI8_0:
; CHECK-ARM-NEXT:    .long 2096725 @ 0x1ffe55
;
; CHECK-THUMB2-LABEL: add3:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #65109
; CHECK-THUMB2-NEXT:    movt r1, #31
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = add i32 %0, 2096725
  ret i32 %2
}

define i32 @add4(i32 %0) {
; CHECK-ARM-LABEL: add4:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI9_0
; CHECK-ARM-NEXT:    add r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI9_0:
; CHECK-ARM-NEXT:    .long 8462149 @ 0x811f45
;
; CHECK-THUMB2-LABEL: add4:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #8005
; CHECK-THUMB2-NEXT:    movt r1, #129
; CHECK-THUMB2-NEXT:    add r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = add i32 %0, 8462149
  ret i32 %2
}

define i32 @orr0(i32 %0) {
; CHECK-ARM-LABEL: orr0:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    orr r0, r0, #8960
; CHECK-ARM-NEXT:    orr r0, r0, #2293760
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: orr0:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    orr r0, r0, #2293760
; CHECK-THUMB2-NEXT:    orr r0, r0, #8960
; CHECK-THUMB2-NEXT:    bx lr
  %2 = or i32 %0, 2302720
  ret i32 %2
}

define i32 @orr1(i32 %0) {
; CHECK-ARM-LABEL: orr1:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    orr r0, r0, #23
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: orr1:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    orr r0, r0, #23
; CHECK-THUMB2-NEXT:    bx lr
  %2 = or i32 %0, 23
  ret i32 %2
}

define i32 @orr2(i32 %0) {
; CHECK-ARM-LABEL: orr2:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI12_0
; CHECK-ARM-NEXT:    orr r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI12_0:
; CHECK-ARM-NEXT:    .long 131071 @ 0x1ffff
;
; CHECK-THUMB2-LABEL: orr2:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #65535
; CHECK-THUMB2-NEXT:    movt r1, #1
; CHECK-THUMB2-NEXT:    orrs r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = or i32 %0, 131071
  ret i32 %2
}

define i32 @eor0(i32 %0) {
; CHECK-ARM-LABEL: eor0:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    eor r0, r0, #8960
; CHECK-ARM-NEXT:    eor r0, r0, #2293760
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: eor0:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    eor r0, r0, #2293760
; CHECK-THUMB2-NEXT:    eor r0, r0, #8960
; CHECK-THUMB2-NEXT:    bx lr
  %2 = xor i32 %0, 2302720
  ret i32 %2
}

define i32 @eor1(i32 %0) {
; CHECK-ARM-LABEL: eor1:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    eor r0, r0, #23
; CHECK-ARM-NEXT:    mov pc, lr
;
; CHECK-THUMB2-LABEL: eor1:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    eor r0, r0, #23
; CHECK-THUMB2-NEXT:    bx lr
  %2 = xor i32 %0, 23
  ret i32 %2
}

define i32 @eor2(i32 %0) {
; CHECK-ARM-LABEL: eor2:
; CHECK-ARM:       @ %bb.0:
; CHECK-ARM-NEXT:    ldr r1, .LCPI15_0
; CHECK-ARM-NEXT:    eor r0, r0, r1
; CHECK-ARM-NEXT:    mov pc, lr
; CHECK-ARM-NEXT:    .p2align 2
; CHECK-ARM-NEXT:  @ %bb.1:
; CHECK-ARM-NEXT:  .LCPI15_0:
; CHECK-ARM-NEXT:    .long 131071 @ 0x1ffff
;
; CHECK-THUMB2-LABEL: eor2:
; CHECK-THUMB2:       @ %bb.0:
; CHECK-THUMB2-NEXT:    movw r1, #65535
; CHECK-THUMB2-NEXT:    movt r1, #1
; CHECK-THUMB2-NEXT:    eors r0, r1
; CHECK-THUMB2-NEXT:    bx lr
  %2 = xor i32 %0, 131071
  ret i32 %2
}
