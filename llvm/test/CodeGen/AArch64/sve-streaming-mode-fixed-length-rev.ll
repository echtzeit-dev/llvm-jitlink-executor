; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve  < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; RBIT
;

define <4 x i8> @bitreverse_v4i8(<4 x i8> %op) #0 {
; CHECK-LABEL: bitreverse_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    lsr z0.h, z0.h, #8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i8> @llvm.bitreverse.v4i8(<4 x i8> %op)
  ret <4 x i8> %res
}

define <8 x i8> @bitreverse_v8i8(<8 x i8> %op) #0 {
; CHECK-LABEL: bitreverse_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i8> @llvm.bitreverse.v8i8(<8 x i8> %op)
  ret <8 x i8> %res
}

define <16 x i8> @bitreverse_v16i8(<16 x i8> %op) #0 {
; CHECK-LABEL: bitreverse_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.bitreverse.v16i8(<16 x i8> %op)
  ret <16 x i8> %res
}

define void @bitreverse_v32i8(ptr %a) #0 {
; CHECK-LABEL: bitreverse_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    rbit z1.b, p0/m, z1.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call <32 x i8> @llvm.bitreverse.v32i8(<32 x i8> %op)
  store <32 x i8> %res, ptr %a
  ret void
}

define <2 x i16> @bitreverse_v2i16(<2 x i16> %op) #0 {
; CHECK-LABEL: bitreverse_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    lsr z0.s, z0.s, #16
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.bitreverse.v2i16(<2 x i16> %op)
  ret <2 x i16> %res
}

define <4 x i16> @bitreverse_v4i16(<4 x i16> %op) #0 {
; CHECK-LABEL: bitreverse_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.bitreverse.v4i16(<4 x i16> %op)
  ret <4 x i16> %res
}

define <8 x i16> @bitreverse_v8i16(<8 x i16> %op) #0 {
; CHECK-LABEL: bitreverse_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.bitreverse.v8i16(<8 x i16> %op)
  ret <8 x i16> %res
}

define void @bitreverse_v16i16(ptr %a) #0 {
; CHECK-LABEL: bitreverse_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    rbit z1.h, p0/m, z1.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call <16 x i16> @llvm.bitreverse.v16i16(<16 x i16> %op)
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @bitreverse_v2i32(<2 x i32> %op) #0 {
; CHECK-LABEL: bitreverse_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %op)
  ret <2 x i32> %res
}

define <4 x i32> @bitreverse_v4i32(<4 x i32> %op) #0 {
; CHECK-LABEL: bitreverse_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.bitreverse.v4i32(<4 x i32> %op)
  ret <4 x i32> %res
}

define void @bitreverse_v8i32(ptr %a) #0 {
; CHECK-LABEL: bitreverse_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    rbit z1.s, p0/m, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call <8 x i32> @llvm.bitreverse.v8i32(<8 x i32> %op)
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @bitreverse_v1i64(<1 x i64> %op) #0 {
; CHECK-LABEL: bitreverse_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.bitreverse.v1i64(<1 x i64> %op)
  ret <1 x i64> %res
}

define <2 x i64> @bitreverse_v2i64(<2 x i64> %op) #0 {
; CHECK-LABEL: bitreverse_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> %op)
  ret <2 x i64> %res
}

define void @bitreverse_v4i64(ptr %a) #0 {
; CHECK-LABEL: bitreverse_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    rbit z1.d, p0/m, z1.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call <4 x i64> @llvm.bitreverse.v4i64(<4 x i64> %op)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; REVB
;

define <2 x i16> @bswap_v2i16(<2 x i16> %op) #0 {
; CHECK-LABEL: bswap_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    revb z0.s, p0/m, z0.s
; CHECK-NEXT:    lsr z0.s, z0.s, #16
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.bswap.v2i16(<2 x i16> %op)
  ret <2 x i16> %res
}

define <4 x i16> @bswap_v4i16(<4 x i16> %op) #0 {
; CHECK-LABEL: bswap_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    revb z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.bswap.v4i16(<4 x i16> %op)
  ret <4 x i16> %res
}

define <8 x i16> @bswap_v8i16(<8 x i16> %op) #0 {
; CHECK-LABEL: bswap_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    revb z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %op)
  ret <8 x i16> %res
}

define void @bswap_v16i16(ptr %a) #0 {
; CHECK-LABEL: bswap_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    revb z0.h, p0/m, z0.h
; CHECK-NEXT:    revb z1.h, p0/m, z1.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %op)
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @bswap_v2i32(<2 x i32> %op) #0 {
; CHECK-LABEL: bswap_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    revb z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %op)
  ret <2 x i32> %res
}

define <4 x i32> @bswap_v4i32(<4 x i32> %op) #0 {
; CHECK-LABEL: bswap_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    revb z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %op)
  ret <4 x i32> %res
}

define void @bswap_v8i32(ptr %a) #0 {
; CHECK-LABEL: bswap_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    revb z0.s, p0/m, z0.s
; CHECK-NEXT:    revb z1.s, p0/m, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %op)
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @bswap_v1i64(<1 x i64> %op) #0 {
; CHECK-LABEL: bswap_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    revb z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.bswap.v1i64(<1 x i64> %op)
  ret <1 x i64> %res
}

define <2 x i64> @bswap_v2i64(<2 x i64> %op) #0 {
; CHECK-LABEL: bswap_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    revb z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %op)
  ret <2 x i64> %res
}

define void @bswap_v4i64(ptr %a) #0 {
; CHECK-LABEL: bswap_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    revb z0.d, p0/m, z0.d
; CHECK-NEXT:    revb z1.d, p0/m, z1.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %op)
  store <4 x i64> %res, ptr %a
  ret void
}

attributes #0 = { "target-features"="+sve" }

declare <4 x i8> @llvm.bitreverse.v4i8(<4 x i8>)
declare <8 x i8> @llvm.bitreverse.v8i8(<8 x i8>)
declare <16 x i8> @llvm.bitreverse.v16i8(<16 x i8>)
declare <32 x i8> @llvm.bitreverse.v32i8(<32 x i8>)
declare <2 x i16> @llvm.bitreverse.v2i16(<2 x i16>)
declare <4 x i16> @llvm.bitreverse.v4i16(<4 x i16>)
declare <8 x i16> @llvm.bitreverse.v8i16(<8 x i16>)
declare <16 x i16> @llvm.bitreverse.v16i16(<16 x i16>)
declare <2 x i32> @llvm.bitreverse.v2i32(<2 x i32>)
declare <4 x i32> @llvm.bitreverse.v4i32(<4 x i32>)
declare <8 x i32> @llvm.bitreverse.v8i32(<8 x i32>)
declare <1 x i64> @llvm.bitreverse.v1i64(<1 x i64>)
declare <2 x i64> @llvm.bitreverse.v2i64(<2 x i64>)
declare <4 x i64> @llvm.bitreverse.v4i64(<4 x i64>)

declare <2 x i16> @llvm.bswap.v2i16(<2 x i16>)
declare <4 x i16> @llvm.bswap.v4i16(<4 x i16>)
declare <8 x i16> @llvm.bswap.v8i16(<8 x i16>)
declare <16 x i16> @llvm.bswap.v16i16(<16 x i16>)
declare <2 x i32> @llvm.bswap.v2i32(<2 x i32>)
declare <4 x i32> @llvm.bswap.v4i32(<4 x i32>)
declare <8 x i32> @llvm.bswap.v8i32(<8 x i32>)
declare <1 x i64> @llvm.bswap.v1i64(<1 x i64>)
declare <2 x i64> @llvm.bswap.v2i64(<2 x i64>)
declare <4 x i64> @llvm.bswap.v4i64(<4 x i64>)
