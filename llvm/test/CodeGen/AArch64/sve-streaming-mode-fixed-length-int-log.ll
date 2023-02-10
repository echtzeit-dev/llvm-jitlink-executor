; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; AND
;

define <8 x i8> @and_v8i8(<8 x i8> %op1, <8 x i8> %op2) #0 {
; CHECK-LABEL: and_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = and <8 x i8> %op1, %op2
  ret <8 x i8> %res
}

define <16 x i8> @and_v16i8(<16 x i8> %op1, <16 x i8> %op2) #0 {
; CHECK-LABEL: and_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = and <16 x i8> %op1, %op2
  ret <16 x i8> %res
}

define void @and_v32i8(ptr %a, ptr %b) #0 {
; CHECK-LABEL: and_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %op2 = load <32 x i8>, ptr %b
  %res = and <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define <4 x i16> @and_v4i16(<4 x i16> %op1, <4 x i16> %op2) #0 {
; CHECK-LABEL: and_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = and <4 x i16> %op1, %op2
  ret <4 x i16> %res
}

define <8 x i16> @and_v8i16(<8 x i16> %op1, <8 x i16> %op2) #0 {
; CHECK-LABEL: and_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = and <8 x i16> %op1, %op2
  ret <8 x i16> %res
}

define void @and_v16i16(ptr %a, ptr %b) #0 {
; CHECK-LABEL: and_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %op2 = load <16 x i16>, ptr %b
  %res = and <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @and_v2i32(<2 x i32> %op1, <2 x i32> %op2) #0 {
; CHECK-LABEL: and_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = and <2 x i32> %op1, %op2
  ret <2 x i32> %res
}

define <4 x i32> @and_v4i32(<4 x i32> %op1, <4 x i32> %op2) #0 {
; CHECK-LABEL: and_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = and <4 x i32> %op1, %op2
  ret <4 x i32> %res
}

define void @and_v8i32(ptr %a, ptr %b) #0 {
; CHECK-LABEL: and_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %op2 = load <8 x i32>, ptr %b
  %res = and <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @and_v1i64(<1 x i64> %op1, <1 x i64> %op2) #0 {
; CHECK-LABEL: and_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = and <1 x i64> %op1, %op2
  ret <1 x i64> %res
}

define <2 x i64> @and_v2i64(<2 x i64> %op1, <2 x i64> %op2) #0 {
; CHECK-LABEL: and_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = and <2 x i64> %op1, %op2
  ret <2 x i64> %res
}

define void @and_v4i64(ptr %a, ptr %b) #0 {
; CHECK-LABEL: and_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %op2 = load <4 x i64>, ptr %b
  %res = and <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; OR
;

define <8 x i8> @or_v8i8(<8 x i8> %op1, <8 x i8> %op2) #0 {
; CHECK-LABEL: or_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = or <8 x i8> %op1, %op2
  ret <8 x i8> %res
}

define <16 x i8> @or_v16i8(<16 x i8> %op1, <16 x i8> %op2) #0 {
; CHECK-LABEL: or_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = or <16 x i8> %op1, %op2
  ret <16 x i8> %res
}

define void @or_v32i8(ptr %a, ptr %b) #0 {
; CHECK-LABEL: or_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %op2 = load <32 x i8>, ptr %b
  %res = or <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define <4 x i16> @or_v4i16(<4 x i16> %op1, <4 x i16> %op2) #0 {
; CHECK-LABEL: or_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = or <4 x i16> %op1, %op2
  ret <4 x i16> %res
}

define <8 x i16> @or_v8i16(<8 x i16> %op1, <8 x i16> %op2) #0 {
; CHECK-LABEL: or_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = or <8 x i16> %op1, %op2
  ret <8 x i16> %res
}

define void @or_v16i16(ptr %a, ptr %b) #0 {
; CHECK-LABEL: or_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %op2 = load <16 x i16>, ptr %b
  %res = or <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @or_v2i32(<2 x i32> %op1, <2 x i32> %op2) #0 {
; CHECK-LABEL: or_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = or <2 x i32> %op1, %op2
  ret <2 x i32> %res
}

define <4 x i32> @or_v4i32(<4 x i32> %op1, <4 x i32> %op2) #0 {
; CHECK-LABEL: or_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = or <4 x i32> %op1, %op2
  ret <4 x i32> %res
}

define void @or_v8i32(ptr %a, ptr %b) #0 {
; CHECK-LABEL: or_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %op2 = load <8 x i32>, ptr %b
  %res = or <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @or_v1i64(<1 x i64> %op1, <1 x i64> %op2) #0 {
; CHECK-LABEL: or_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = or <1 x i64> %op1, %op2
  ret <1 x i64> %res
}

define <2 x i64> @or_v2i64(<2 x i64> %op1, <2 x i64> %op2) #0 {
; CHECK-LABEL: or_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = or <2 x i64> %op1, %op2
  ret <2 x i64> %res
}

define void @or_v4i64(ptr %a, ptr %b) #0 {
; CHECK-LABEL: or_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %op2 = load <4 x i64>, ptr %b
  %res = or <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; XOR
;

define <8 x i8> @xor_v8i8(<8 x i8> %op1, <8 x i8> %op2) #0 {
; CHECK-LABEL: xor_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <8 x i8> %op1, %op2
  ret <8 x i8> %res
}

define <16 x i8> @xor_v16i8(<16 x i8> %op1, <16 x i8> %op2) #0 {
; CHECK-LABEL: xor_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <16 x i8> %op1, %op2
  ret <16 x i8> %res
}

define void @xor_v32i8(ptr %a, ptr %b) #0 {
; CHECK-LABEL: xor_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    eor z0.d, z0.d, z2.d
; CHECK-NEXT:    eor z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %op2 = load <32 x i8>, ptr %b
  %res = xor <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define <4 x i16> @xor_v4i16(<4 x i16> %op1, <4 x i16> %op2) #0 {
; CHECK-LABEL: xor_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <4 x i16> %op1, %op2
  ret <4 x i16> %res
}

define <8 x i16> @xor_v8i16(<8 x i16> %op1, <8 x i16> %op2) #0 {
; CHECK-LABEL: xor_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <8 x i16> %op1, %op2
  ret <8 x i16> %res
}

define void @xor_v16i16(ptr %a, ptr %b) #0 {
; CHECK-LABEL: xor_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    eor z0.d, z0.d, z2.d
; CHECK-NEXT:    eor z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %op2 = load <16 x i16>, ptr %b
  %res = xor <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @xor_v2i32(<2 x i32> %op1, <2 x i32> %op2) #0 {
; CHECK-LABEL: xor_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <2 x i32> %op1, %op2
  ret <2 x i32> %res
}

define <4 x i32> @xor_v4i32(<4 x i32> %op1, <4 x i32> %op2) #0 {
; CHECK-LABEL: xor_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <4 x i32> %op1, %op2
  ret <4 x i32> %res
}

define void @xor_v8i32(ptr %a, ptr %b) #0 {
; CHECK-LABEL: xor_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    eor z0.d, z0.d, z2.d
; CHECK-NEXT:    eor z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %op2 = load <8 x i32>, ptr %b
  %res = xor <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @xor_v1i64(<1 x i64> %op1, <1 x i64> %op2) #0 {
; CHECK-LABEL: xor_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <1 x i64> %op1, %op2
  ret <1 x i64> %res
}

define <2 x i64> @xor_v2i64(<2 x i64> %op1, <2 x i64> %op2) #0 {
; CHECK-LABEL: xor_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = xor <2 x i64> %op1, %op2
  ret <2 x i64> %res
}

define void @xor_v4i64(ptr %a, ptr %b) #0 {
; CHECK-LABEL: xor_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ldp q2, q3, [x1]
; CHECK-NEXT:    eor z0.d, z0.d, z2.d
; CHECK-NEXT:    eor z1.d, z1.d, z3.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %op2 = load <4 x i64>, ptr %b
  %res = xor <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

attributes #0 = { "target-features"="+sve" }
