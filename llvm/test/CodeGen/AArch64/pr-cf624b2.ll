; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

;; This used to crash mid-legalization because we'd no longer have BUILD_VECTOR,
;; but an CONCAT_VECTOR, and we didn't anticipate that.

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define linkonce_odr void @_ZN1y2beEPiRK1vPmPS1_(<8 x i8> %0, ptr %agg.tmp.i) {
; CHECK-LABEL: _ZN1y2beEPiRK1vPmPS1_:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    orr x9, x8, #0xf
; CHECK-NEXT:    orr x11, x8, #0xc
; CHECK-NEXT:    orr x10, x8, #0xe
; CHECK-NEXT:    orr x12, x8, #0x8
; CHECK-NEXT:    st1 { v0.b }[0], [x8]
; CHECK-NEXT:    st1 { v0.b }[15], [x9]
; CHECK-NEXT:    orr x9, x8, #0x7
; CHECK-NEXT:    st1 { v0.b }[12], [x11]
; CHECK-NEXT:    orr x11, x8, #0x4
; CHECK-NEXT:    st1 { v0.b }[14], [x10]
; CHECK-NEXT:    orr x10, x8, #0x6
; CHECK-NEXT:    st1 { v0.b }[7], [x9]
; CHECK-NEXT:    orr x9, x8, #0x3
; CHECK-NEXT:    st1 { v0.b }[8], [x12]
; CHECK-NEXT:    mov w12, #11
; CHECK-NEXT:    st1 { v0.b }[4], [x11]
; CHECK-NEXT:    mov w11, #13
; CHECK-NEXT:    st1 { v0.b }[3], [x9]
; CHECK-NEXT:    orr x9, x8, #0x2
; CHECK-NEXT:    st1 { v0.b }[6], [x10]
; CHECK-NEXT:    orr x10, x8, #0x1
; CHECK-NEXT:    orr x11, x8, x11
; CHECK-NEXT:    st1 { v0.b }[2], [x9]
; CHECK-NEXT:    orr x9, x8, x12
; CHECK-NEXT:    st1 { v0.b }[1], [x10]
; CHECK-NEXT:    mov w10, #9
; CHECK-NEXT:    st1 { v0.b }[13], [x11]
; CHECK-NEXT:    mov w11, #5
; CHECK-NEXT:    st1 { v0.b }[11], [x9]
; CHECK-NEXT:    mov w9, #10
; CHECK-NEXT:    orr x9, x8, x9
; CHECK-NEXT:    orr x10, x8, x10
; CHECK-NEXT:    orr x8, x8, x11
; CHECK-NEXT:    movi v1.2d, #0000000000000000
; CHECK-NEXT:    st1 { v0.b }[10], [x9]
; CHECK-NEXT:    st1 { v0.b }[9], [x10]
; CHECK-NEXT:    st1 { v0.b }[5], [x8]
; CHECK-NEXT:    ldr q0, [sp]
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
entry:
  %ref.tmp6.sroa.0.0.vecblend.i = shufflevector <8 x i8> %0, <8 x i8> zeroinitializer, <24 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %ref.tmp6.sroa.0.20.vecblend.i = shufflevector <24 x i8> %ref.tmp6.sroa.0.0.vecblend.i, <24 x i8> zeroinitializer, <24 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 44, i32 45, i32 46, i32 47>
  %ref.tmp.sroa.0.0.vecblend.i = shufflevector <24 x i8> %ref.tmp6.sroa.0.20.vecblend.i, <24 x i8> zeroinitializer, <28 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 20, i32 21, i32 22, i32 23, i32 undef, i32 undef, i32 undef, i32 undef>
  %n.sroa.0.0.vecblend.i.i = shufflevector <28 x i8> %ref.tmp.sroa.0.0.vecblend.i, <28 x i8> zeroinitializer, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 undef, i32 undef, i32 undef, i32 undef>
  store <32 x i8> %n.sroa.0.0.vecblend.i.i, ptr %agg.tmp.i, align 4
  ret void
}
