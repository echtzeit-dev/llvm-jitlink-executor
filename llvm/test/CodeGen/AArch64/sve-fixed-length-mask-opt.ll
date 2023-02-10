; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

;
; LD1B
;

define void @masked_gather_v2i8(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    st1b { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <2 x ptr>, ptr %b
  %vals = call <2 x i8> @llvm.masked.gather.v2i8(<2 x ptr> %ptrs, i32 8, <2 x i1> <i1 true, i1 true>, <2 x i8> undef)
  store <2 x i8> %vals, ptr %a
  ret void
}

define void @masked_gather_v4i8(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1b { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <4 x ptr>, ptr %b
  %vals = call <4 x i8> @llvm.masked.gather.v4i8(<4 x ptr> %ptrs, i32 8, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i8> undef)
  store <4 x i8> %vals, ptr %a
  ret void
}

define void @masked_gather_v8i8(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: masked_gather_v8i8:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; VBITS_GE_256-NEXT:    ld1b { z1.d }, p0/z, [z1.d]
; VBITS_GE_256-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_256-NEXT:    uzp1 z1.s, z1.s, z1.s
; VBITS_GE_256-NEXT:    uzp1 z0.h, z0.h, z0.h
; VBITS_GE_256-NEXT:    uzp1 z1.h, z1.h, z1.h
; VBITS_GE_256-NEXT:    uzp1 v0.8b, v1.8b, v0.8b
; VBITS_GE_256-NEXT:    str d0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: masked_gather_v8i8:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; VBITS_GE_512-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_512-NEXT:    uzp1 z0.h, z0.h, z0.h
; VBITS_GE_512-NEXT:    uzp1 z0.b, z0.b, z0.b
; VBITS_GE_512-NEXT:    str d0, [x0]
; VBITS_GE_512-NEXT:    ret
  %ptrs = load <8 x ptr>, ptr %b
  %vals = call <8 x i8> @llvm.masked.gather.v8i8(<8 x ptr> %ptrs, i32 8, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i8> undef)
  store <8 x i8> %vals, ptr %a
  ret void
}

define void @masked_gather_v16i8(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: masked_gather_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <16 x ptr>, ptr %b
  %vals = call <16 x i8> @llvm.masked.gather.v16i8(<16 x ptr> %ptrs, i32 8, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                       i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <16 x i8> undef)
  store <16 x i8> %vals, ptr %a
  ret void
}

define void @masked_gather_v32i8(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: masked_gather_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1b { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1b { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <32 x ptr>, ptr %b
  %vals = call <32 x i8> @llvm.masked.gather.v32i8(<32 x ptr> %ptrs, i32 8, <32 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                       i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                       i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                       i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <32 x i8> undef)
  store <32 x i8> %vals, ptr %a
  ret void
}

;
; LD1H
;

define void @masked_gather_v2i16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    st1h { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <2 x ptr>, ptr %b
  %vals = call <2 x i16> @llvm.masked.gather.v2i16(<2 x ptr> %ptrs, i32 8, <2 x i1> <i1 true, i1 true>, <2 x i16> undef)
  store <2 x i16> %vals, ptr %a
  ret void
}

define void @masked_gather_v4i16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <4 x ptr>, ptr %b
  %vals = call <4 x i16> @llvm.masked.gather.v4i16(<4 x ptr> %ptrs, i32 8, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i16> undef)
  store <4 x i16> %vals, ptr %a
  ret void
}

define void @masked_gather_v8i16(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: masked_gather_v8i16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; VBITS_GE_256-NEXT:    ld1h { z1.d }, p0/z, [z1.d]
; VBITS_GE_256-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_256-NEXT:    uzp1 z1.s, z1.s, z1.s
; VBITS_GE_256-NEXT:    uzp1 z0.h, z0.h, z0.h
; VBITS_GE_256-NEXT:    uzp1 z1.h, z1.h, z1.h
; VBITS_GE_256-NEXT:    mov v1.d[1], v0.d[0]
; VBITS_GE_256-NEXT:    str q1, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: masked_gather_v8i16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; VBITS_GE_512-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_512-NEXT:    uzp1 z0.h, z0.h, z0.h
; VBITS_GE_512-NEXT:    str q0, [x0]
; VBITS_GE_512-NEXT:    ret
  %ptrs = load <8 x ptr>, ptr %b
  %vals = call <8 x i16> @llvm.masked.gather.v8i16(<8 x ptr> %ptrs, i32 8, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  store <8 x i16> %vals, ptr %a
  ret void
}

define void @masked_gather_v16i16(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: masked_gather_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1h { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <16 x ptr>, ptr %b
  %vals = call <16 x i16> @llvm.masked.gather.v16i16(<16 x ptr> %ptrs, i32 8, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <16 x i16> undef)
  store <16 x i16> %vals, ptr %a
  ret void
}

define void @masked_gather_v32i16(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: masked_gather_v32i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1h { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <32 x ptr>, ptr %b
  %vals = call <32 x i16> @llvm.masked.gather.v32i16(<32 x ptr> %ptrs, i32 8, <32 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <32 x i16> undef)
  store <32 x i16> %vals, ptr %a
  ret void
}

;
; LD1W
;

define void @masked_gather_v2i32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <2 x ptr>, ptr %b
  %vals = call <2 x i32> @llvm.masked.gather.v2i32(<2 x ptr> %ptrs, i32 8, <2 x i1> <i1 true, i1 true>, <2 x i32> undef)
  store <2 x i32> %vals, ptr %a
  ret void
}

define void @masked_gather_v4i32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <4 x ptr>, ptr %b
  %vals = call <4 x i32> @llvm.masked.gather.v4i32(<4 x ptr> %ptrs, i32 8, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  store <4 x i32> %vals, ptr %a
  ret void
}

define void @masked_gather_v8i32(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: masked_gather_v8i32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; VBITS_GE_256-NEXT:    ld1w { z1.d }, p0/z, [z1.d]
; VBITS_GE_256-NEXT:    ptrue p0.s, vl4
; VBITS_GE_256-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_256-NEXT:    uzp1 z1.s, z1.s, z1.s
; VBITS_GE_256-NEXT:    splice z1.s, p0, z1.s, z0.s
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: masked_gather_v8i32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; VBITS_GE_512-NEXT:    st1w { z0.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %ptrs = load <8 x ptr>, ptr %b
  %vals = call <8 x i32> @llvm.masked.gather.v8i32(<8 x ptr> %ptrs, i32 8, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i32> undef)
  store <8 x i32> %vals, ptr %a
  ret void
}

define void @masked_gather_v16i32(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: masked_gather_v16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1w { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <16 x ptr>, ptr %b
  %vals = call <16 x i32> @llvm.masked.gather.v16i32(<16 x ptr> %ptrs, i32 8, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <16 x i32> undef)
  store <16 x i32> %vals, ptr %a
  ret void
}

define void @masked_gather_v32i32(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: masked_gather_v32i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1w { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <32 x ptr>, ptr %b
  %vals = call <32 x i32> @llvm.masked.gather.v32i32(<32 x ptr> %ptrs, i32 8, <32 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <32 x i32> undef)
  store <32 x i32> %vals, ptr %a
  ret void
}

;
; LD1D
;

define void @masked_gather_v2i64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <2 x ptr>, ptr %b
  %vals = call <2 x i64> @llvm.masked.gather.v2i64(<2 x ptr> %ptrs, i32 8, <2 x i1> <i1 true, i1 true>, <2 x i64> undef)
  store <2 x i64> %vals, ptr %a
  ret void
}

define void @masked_gather_v4i64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: masked_gather_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <4 x ptr>, ptr %b
  %vals = call <4 x i64> @llvm.masked.gather.v4i64(<4 x ptr> %ptrs, i32 8, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i64> undef)
  store <4 x i64> %vals, ptr %a
  ret void
}

define void @masked_gather_v8i64(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: masked_gather_v8i64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [z1.d]
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: masked_gather_v8i64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %ptrs = load <8 x ptr>, ptr %b
  %vals = call <8 x i64> @llvm.masked.gather.v8i64(<8 x ptr> %ptrs, i32 8, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i64> undef)
  store <8 x i64> %vals, ptr %a
  ret void
}

define void @masked_gather_v16i64(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: masked_gather_v16i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <16 x ptr>, ptr %b
  %vals = call <16 x i64> @llvm.masked.gather.v16i64(<16 x ptr> %ptrs, i32 8, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <16 x i64> undef)
  store <16 x i64> %vals, ptr %a
  ret void
}

define void @masked_gather_v32i64(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: masked_gather_v32i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [z0.d]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %ptrs = load <32 x ptr>, ptr %b
  %vals = call <32 x i64> @llvm.masked.gather.v32i64(<32 x ptr> %ptrs, i32 8, <32 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true,
                                                                                          i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <32 x i64> undef)
  store <32 x i64> %vals, ptr %a
  ret void
}

declare <2 x i8> @llvm.masked.gather.v2i8(<2 x ptr>, i32, <2 x i1>, <2 x i8>)
declare <4 x i8> @llvm.masked.gather.v4i8(<4 x ptr>, i32, <4 x i1>, <4 x i8>)
declare <8 x i8> @llvm.masked.gather.v8i8(<8 x ptr>, i32, <8 x i1>, <8 x i8>)
declare <16 x i8> @llvm.masked.gather.v16i8(<16 x ptr>, i32, <16 x i1>, <16 x i8>)
declare <32 x i8> @llvm.masked.gather.v32i8(<32 x ptr>, i32, <32 x i1>, <32 x i8>)

declare <2 x i16> @llvm.masked.gather.v2i16(<2 x ptr>, i32, <2 x i1>, <2 x i16>)
declare <4 x i16> @llvm.masked.gather.v4i16(<4 x ptr>, i32, <4 x i1>, <4 x i16>)
declare <8 x i16> @llvm.masked.gather.v8i16(<8 x ptr>, i32, <8 x i1>, <8 x i16>)
declare <16 x i16> @llvm.masked.gather.v16i16(<16 x ptr>, i32, <16 x i1>, <16 x i16>)
declare <32 x i16> @llvm.masked.gather.v32i16(<32 x ptr>, i32, <32 x i1>, <32 x i16>)

declare <2 x i32> @llvm.masked.gather.v2i32(<2 x ptr>, i32, <2 x i1>, <2 x i32>)
declare <4 x i32> @llvm.masked.gather.v4i32(<4 x ptr>, i32, <4 x i1>, <4 x i32>)
declare <8 x i32> @llvm.masked.gather.v8i32(<8 x ptr>, i32, <8 x i1>, <8 x i32>)
declare <16 x i32> @llvm.masked.gather.v16i32(<16 x ptr>, i32, <16 x i1>, <16 x i32>)
declare <32 x i32> @llvm.masked.gather.v32i32(<32 x ptr>, i32, <32 x i1>, <32 x i32>)

declare <2 x i64> @llvm.masked.gather.v2i64(<2 x ptr>, i32, <2 x i1>, <2 x i64>)
declare <4 x i64> @llvm.masked.gather.v4i64(<4 x ptr>, i32, <4 x i1>, <4 x i64>)
declare <8 x i64> @llvm.masked.gather.v8i64(<8 x ptr>, i32, <8 x i1>, <8 x i64>)
declare <16 x i64> @llvm.masked.gather.v16i64(<16 x ptr>, i32, <16 x i1>, <16 x i64>)
declare <32 x i64> @llvm.masked.gather.v32i64(<32 x ptr>, i32, <32 x i1>, <32 x i64>)

attributes #0 = { "target-features"="+sve" }
