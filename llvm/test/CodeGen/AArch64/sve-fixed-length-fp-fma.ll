; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -O3 -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -O3 -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

;
; FMA
;

; Don't use SVE for 64-bit vectors.
define <4 x half> @fma_v4f16(<4 x half> %op1, <4 x half> %op2, <4 x half> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmla v2.4h, v0.4h, v1.4h
; CHECK-NEXT:    fmov d0, d2
; CHECK-NEXT:    ret
  %mul = fmul contract <4 x half> %op1, %op2
  %res = fadd contract <4 x half> %mul, %op3
  ret <4 x half> %res
}

; Don't use SVE for 128-bit vectors.
define <8 x half> @fma_v8f16(<8 x half> %op1, <8 x half> %op2, <8 x half> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmla v2.8h, v0.8h, v1.8h
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %mul = fmul contract <8 x half> %op1, %op2
  %res = fadd contract <8 x half> %mul, %op3
  ret <8 x half> %res
}

define void @fma_v16f16(ptr %a, ptr %b, ptr %c) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %op3 = load <16 x half>, ptr %c
  %mul = fmul contract <16 x half> %op1, %op2
  %res = fadd contract <16 x half> %mul, %op3
  store <16 x half> %res, ptr %a
  ret void
}

define void @fma_v32f16(ptr %a, ptr %b, ptr %c) #0 {
; VBITS_GE_256-LABEL: fma_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #16
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1h { z2.h }, p0/z, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z3.h }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1h { z4.h }, p0/z, [x2, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z5.h }, p0/z, [x2]
; VBITS_GE_256-NEXT:    fmad z0.h, p0/m, z2.h, z4.h
; VBITS_GE_256-NEXT:    fmad z1.h, p0/m, z3.h, z5.h
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fma_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1h { z1.h }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1h { z2.h }, p0/z, [x2]
; VBITS_GE_512-NEXT:    fmad z0.h, p0/m, z1.h, z2.h
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <32 x half>, ptr %a
  %op2 = load <32 x half>, ptr %b
  %op3 = load <32 x half>, ptr %c
  %mul = fmul contract <32 x half> %op1, %op2
  %res = fadd contract <32 x half> %mul, %op3
  store <32 x half> %res, ptr %a
  ret void
}

define void @fma_v64f16(ptr %a, ptr %b, ptr %c) vscale_range(8,0) #0 {
; CHECK-LABEL: fma_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <64 x half>, ptr %a
  %op2 = load <64 x half>, ptr %b
  %op3 = load <64 x half>, ptr %c
  %mul = fmul contract <64 x half> %op1, %op2
  %res = fadd contract <64 x half> %mul, %op3
  store <64 x half> %res, ptr %a
  ret void
}

define void @fma_v128f16(ptr %a, ptr %b, ptr %c) vscale_range(16,0) #0 {
; CHECK-LABEL: fma_v128f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl128
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <128 x half>, ptr %a
  %op2 = load <128 x half>, ptr %b
  %op3 = load <128 x half>, ptr %c
  %mul = fmul contract <128 x half> %op1, %op2
  %res = fadd contract <128 x half> %mul, %op3
  store <128 x half> %res, ptr %a
  ret void
}

; Don't use SVE for 64-bit vectors.
define <2 x float> @fma_v2f32(<2 x float> %op1, <2 x float> %op2, <2 x float> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmla v2.2s, v0.2s, v1.2s
; CHECK-NEXT:    fmov d0, d2
; CHECK-NEXT:    ret
  %mul = fmul contract <2 x float> %op1, %op2
  %res = fadd contract <2 x float> %mul, %op3
  ret <2 x float> %res
}

; Don't use SVE for 128-bit vectors.
define <4 x float> @fma_v4f32(<4 x float> %op1, <4 x float> %op2, <4 x float> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmla v2.4s, v0.4s, v1.4s
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %mul = fmul contract <4 x float> %op1, %op2
  %res = fadd contract <4 x float> %mul, %op3
  ret <4 x float> %res
}

define void @fma_v8f32(ptr %a, ptr %b, ptr %c) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %op2 = load <8 x float>, ptr %b
  %op3 = load <8 x float>, ptr %c
  %mul = fmul contract <8 x float> %op1, %op2
  %res = fadd contract <8 x float> %mul, %op3
  store <8 x float> %res, ptr %a
  ret void
}

define void @fma_v16f32(ptr %a, ptr %b, ptr %c) #0 {
; VBITS_GE_256-LABEL: fma_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #8
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1w { z2.s }, p0/z, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z3.s }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1w { z4.s }, p0/z, [x2, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z5.s }, p0/z, [x2]
; VBITS_GE_256-NEXT:    fmad z0.s, p0/m, z2.s, z4.s
; VBITS_GE_256-NEXT:    fmad z1.s, p0/m, z3.s, z5.s
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fma_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1w { z1.s }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1w { z2.s }, p0/z, [x2]
; VBITS_GE_512-NEXT:    fmad z0.s, p0/m, z1.s, z2.s
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <16 x float>, ptr %a
  %op2 = load <16 x float>, ptr %b
  %op3 = load <16 x float>, ptr %c
  %mul = fmul contract <16 x float> %op1, %op2
  %res = fadd contract <16 x float> %mul, %op3
  store <16 x float> %res, ptr %a
  ret void
}

define void @fma_v32f32(ptr %a, ptr %b, ptr %c) vscale_range(8,0) #0 {
; CHECK-LABEL: fma_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x float>, ptr %a
  %op2 = load <32 x float>, ptr %b
  %op3 = load <32 x float>, ptr %c
  %mul = fmul contract <32 x float> %op1, %op2
  %res = fadd contract <32 x float> %mul, %op3
  store <32 x float> %res, ptr %a
  ret void
}

define void @fma_v64f32(ptr %a, ptr %b, ptr %c) vscale_range(16,0) #0 {
; CHECK-LABEL: fma_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <64 x float>, ptr %a
  %op2 = load <64 x float>, ptr %b
  %op3 = load <64 x float>, ptr %c
  %mul = fmul contract <64 x float> %op1, %op2
  %res = fadd contract <64 x float> %mul, %op3
  store <64 x float> %res, ptr %a
  ret void
}

; Don't use SVE for 64-bit vectors.
define <1 x double> @fma_v1f64(<1 x double> %op1, <1 x double> %op2, <1 x double> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmadd d0, d0, d1, d2
; CHECK-NEXT:    ret
  %mul = fmul contract <1 x double> %op1, %op2
  %res = fadd contract <1 x double> %mul, %op3
  ret <1 x double> %res
}

; Don't use SVE for 128-bit vectors.
define <2 x double> @fma_v2f64(<2 x double> %op1, <2 x double> %op2, <2 x double> %op3) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmla v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
  %mul = fmul contract <2 x double> %op1, %op2
  %res = fadd contract <2 x double> %mul, %op3
  ret <2 x double> %res
}

define void @fma_v4f64(ptr %a, ptr %b, ptr %c) vscale_range(2,0) #0 {
; CHECK-LABEL: fma_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %op2 = load <4 x double>, ptr %b
  %op3 = load <4 x double>, ptr %c
  %mul = fmul contract <4 x double> %op1, %op2
  %res = fadd contract <4 x double> %mul, %op3
  store <4 x double> %res, ptr %a
  ret void
}

define void @fma_v8f64(ptr %a, ptr %b, ptr %c) #0 {
; VBITS_GE_256-LABEL: fma_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1d { z2.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z3.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    ld1d { z4.d }, p0/z, [x2, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z5.d }, p0/z, [x2]
; VBITS_GE_256-NEXT:    fmad z0.d, p0/m, z2.d, z4.d
; VBITS_GE_256-NEXT:    fmad z1.d, p0/m, z3.d, z5.d
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fma_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    ld1d { z2.d }, p0/z, [x2]
; VBITS_GE_512-NEXT:    fmad z0.d, p0/m, z1.d, z2.d
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x double>, ptr %a
  %op2 = load <8 x double>, ptr %b
  %op3 = load <8 x double>, ptr %c
  %mul = fmul contract <8 x double> %op1, %op2
  %res = fadd contract <8 x double> %mul, %op3
  store <8 x double> %res, ptr %a
  ret void
}

define void @fma_v16f64(ptr %a, ptr %b, ptr %c) vscale_range(8,0) #0 {
; CHECK-LABEL: fma_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x double>, ptr %a
  %op2 = load <16 x double>, ptr %b
  %op3 = load <16 x double>, ptr %c
  %mul = fmul contract <16 x double> %op1, %op2
  %res = fadd contract <16 x double> %mul, %op3
  store <16 x double> %res, ptr %a
  ret void
}

define void @fma_v32f64(ptr %a, ptr %b, ptr %c) vscale_range(16,0) #0 {
; CHECK-LABEL: fma_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x2]
; CHECK-NEXT:    fmad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x double>, ptr %a
  %op2 = load <32 x double>, ptr %b
  %op3 = load <32 x double>, ptr %c
  %mul = fmul contract <32 x double> %op1, %op2
  %res = fadd contract <32 x double> %mul, %op3
  store <32 x double> %res, ptr %a
  ret void
}

attributes #0 = { "target-features"="+sve" }
