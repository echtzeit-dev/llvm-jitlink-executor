; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <2 x half> @select_v2f16(<2 x half> %op1, <2 x half> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    bic z1.d, z1.d, z2.d
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <2 x half> %op1, <2 x half> %op2
  ret <2 x half> %sel
}

define <4 x half> @select_v4f16(<4 x half> %op1, <4 x half> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    bic z1.d, z1.d, z2.d
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <4 x half> %op1, <4 x half> %op2
  ret <4 x half> %sel
}

define <8 x half> @select_v8f16(<8 x half> %op1, <8 x half> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    bic z1.d, z1.d, z2.d
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <8 x half> %op1, <8 x half> %op2
  ret <8 x half> %sel
}

define void @select_v16f16(ptr %a, ptr %b, i1 %mask) #0 {
; CHECK-LABEL: select_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    ldr q1, [x0, #16]
; CHECK-NEXT:    ldr q2, [x1, #16]
; CHECK-NEXT:    ldr q3, [x1]
; CHECK-NEXT:    mov z4.h, w8
; CHECK-NEXT:    bic z2.d, z2.d, z4.d
; CHECK-NEXT:    and z0.d, z0.d, z4.d
; CHECK-NEXT:    bic z3.d, z3.d, z4.d
; CHECK-NEXT:    and z1.d, z1.d, z4.d
; CHECK-NEXT:    orr z0.d, z0.d, z3.d
; CHECK-NEXT:    orr z1.d, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load volatile <16 x half>, ptr %a
  %op2 = load volatile <16 x half>, ptr %b
  %sel = select i1 %mask, <16 x half> %op1, <16 x half> %op2
  store <16 x half> %sel, ptr %a
  ret void
}

define <2 x float> @select_v2f32(<2 x float> %op1, <2 x float> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    mvn w9, w8
; CHECK-NEXT:    mov z2.s, w8
; CHECK-NEXT:    mov z3.s, w9
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <2 x float> %op1, <2 x float> %op2
  ret <2 x float> %sel
}

define <4 x float> @select_v4f32(<4 x float> %op1, <4 x float> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    mvn w9, w8
; CHECK-NEXT:    mov z2.s, w8
; CHECK-NEXT:    mov z3.s, w9
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <4 x float> %op1, <4 x float> %op2
  ret <4 x float> %sel
}

define void @select_v8f32(ptr %a, ptr %b, i1 %mask) #0 {
; CHECK-LABEL: select_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    ldr q0, [x0, #16]
; CHECK-NEXT:    csetm w8, ne
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    mvn w9, w8
; CHECK-NEXT:    ldr q2, [x1, #16]
; CHECK-NEXT:    ldr q3, [x1]
; CHECK-NEXT:    mov z4.s, w8
; CHECK-NEXT:    mov z5.s, w9
; CHECK-NEXT:    and z0.d, z0.d, z4.d
; CHECK-NEXT:    and z1.d, z1.d, z4.d
; CHECK-NEXT:    and z3.d, z3.d, z5.d
; CHECK-NEXT:    and z2.d, z2.d, z5.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load volatile <8 x float>, ptr %a
  %op2 = load volatile <8 x float>, ptr %b
  %sel = select i1 %mask, <8 x float> %op1, <8 x float> %op2
  store <8 x float> %sel, ptr %a
  ret void
}

define <1 x double> @select_v1f64(<1 x double> %op1, <1 x double> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    csetm x8, ne
; CHECK-NEXT:    mvn x9, x8
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    mov z3.d, x9
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <1 x double> %op1, <1 x double> %op2
  ret <1 x double> %sel
}

define <2 x double> @select_v2f64(<2 x double> %op1, <2 x double> %op2, i1 %mask) #0 {
; CHECK-LABEL: select_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    csetm x8, ne
; CHECK-NEXT:    mvn x9, x8
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    mov z3.d, x9
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %sel = select i1 %mask, <2 x double> %op1, <2 x double> %op2
  ret <2 x double> %sel
}

define void @select_v4f64(ptr %a, ptr %b, i1 %mask) #0 {
; CHECK-LABEL: select_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    ldr q0, [x0, #16]
; CHECK-NEXT:    csetm x8, ne
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    mvn x9, x8
; CHECK-NEXT:    ldr q2, [x1, #16]
; CHECK-NEXT:    ldr q3, [x1]
; CHECK-NEXT:    mov z4.d, x8
; CHECK-NEXT:    mov z5.d, x9
; CHECK-NEXT:    and z0.d, z0.d, z4.d
; CHECK-NEXT:    and z1.d, z1.d, z4.d
; CHECK-NEXT:    and z3.d, z3.d, z5.d
; CHECK-NEXT:    and z2.d, z2.d, z5.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load volatile <4 x double>, ptr %a
  %op2 = load volatile <4 x double>, ptr %b
  %sel = select i1 %mask, <4 x double> %op1, <4 x double> %op2
  store <4 x double> %sel, ptr %a
  ret void
}

attributes #0 = { "target-features"="+sve" }
