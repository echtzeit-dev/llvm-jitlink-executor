; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

;
; FCVT H -> S
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v2f16_v2f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f16_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NEXT:    str d0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <2 x half>, ptr %a
  %res = fpext <2 x half> %op1 to <2 x float>
  store <2 x float> %res, ptr %b
  ret void
}

; Don't use SVE for 128-bit vectors.
define void @fcvt_v4f16_v4f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f16_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x half>, ptr %a
  %res = fpext <4 x half> %op1 to <4 x float>
  store <4 x float> %res, ptr %b
  ret void
}

define void @fcvt_v8f16_v8f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v8f16_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.h
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <8 x half>, ptr %a
  %res = fpext <8 x half> %op1 to <8 x float>
  store <8 x float> %res, ptr %b
  ret void
}

define void @fcvt_v16f16_v16f32(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v16f16_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #8
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    ld1h { z0.s }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    fcvt z0.s, p0/m, z0.h
; VBITS_GE_256-NEXT:    fcvt z1.s, p0/m, z1.h
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v16f16_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1h { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.s, p0/m, z0.h
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %res = fpext <16 x half> %op1 to <16 x float>
  store <16 x float> %res, ptr %b
  ret void
}

define void @fcvt_v32f16_v32f32(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v32f16_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.h
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x half>, ptr %a
  %res = fpext <32 x half> %op1 to <32 x float>
  store <32 x float> %res, ptr %b
  ret void
}

define void @fcvt_v64f16_v64f32(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v64f16_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.h
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <64 x half>, ptr %a
  %res = fpext <64 x half> %op1 to <64 x float>
  store <64 x float> %res, ptr %b
  ret void
}

;
; FCVT H -> D
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v1f16_v1f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v1f16_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    fcvt d0, h0
; CHECK-NEXT:    str d0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <1 x half>, ptr %a
  %res = fpext <1 x half> %op1 to <1 x double>
  store <1 x double> %res, ptr %b
  ret void
}

; v2f16 is not legal for NEON, so use SVE
define void @fcvt_v2f16_v2f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f16_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    uunpklo z0.s, z0.h
; CHECK-NEXT:    uunpklo z0.d, z0.s
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.h
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <2 x half>, ptr %a
  %res = fpext <2 x half> %op1 to <2 x double>
  store <2 x double> %res, ptr %b
  ret void
}

define void @fcvt_v4f16_v4f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f16_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.h
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x half>, ptr %a
  %res = fpext <4 x half> %op1 to <4 x double>
  store <4 x double> %res, ptr %b
  ret void
}

define void @fcvt_v8f16_v8f64(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v8f16_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1h { z0.d }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    fcvt z0.d, p0/m, z0.h
; VBITS_GE_256-NEXT:    fcvt z1.d, p0/m, z1.h
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v8f16_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1h { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.d, p0/m, z0.h
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x half>, ptr %a
  %res = fpext <8 x half> %op1 to <8 x double>
  store <8 x double> %res, ptr %b
  ret void
}

define void @fcvt_v16f16_v16f64(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v16f16_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.h
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %res = fpext <16 x half> %op1 to <16 x double>
  store <16 x double> %res, ptr %b
  ret void
}

define void @fcvt_v32f16_v32f64(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v32f16_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.h
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x half>, ptr %a
  %res = fpext <32 x half> %op1 to <32 x double>
  store <32 x double> %res, ptr %b
  ret void
}

;
; FCVT S -> D
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v1f32_v1f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v1f32_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    fcvtl v0.2d, v0.2s
; CHECK-NEXT:    str d0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <1 x float>, ptr %a
  %res = fpext <1 x float> %op1 to <1 x double>
  store <1 x double> %res, ptr %b
  ret void
}

; Don't use SVE for 128-bit vectors.
define void @fcvt_v2f32_v2f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f32_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    fcvtl v0.2d, v0.2s
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <2 x float>, ptr %a
  %res = fpext <2 x float> %op1 to <2 x double>
  store <2 x double> %res, ptr %b
  ret void
}

define void @fcvt_v4f32_v4f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f32_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.s
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x float>, ptr %a
  %res = fpext <4 x float> %op1 to <4 x double>
  store <4 x double> %res, ptr %b
  ret void
}

define void @fcvt_v8f32_v8f64(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v8f32_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1w { z0.d }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    fcvt z0.d, p0/m, z0.s
; VBITS_GE_256-NEXT:    fcvt z1.d, p0/m, z1.s
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v8f32_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1w { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.d, p0/m, z0.s
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %res = fpext <8 x float> %op1 to <8 x double>
  store <8 x double> %res, ptr %b
  ret void
}

define void @fcvt_v16f32_v16f64(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v16f32_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.s
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x float>, ptr %a
  %res = fpext <16 x float> %op1 to <16 x double>
  store <16 x double> %res, ptr %b
  ret void
}

define void @fcvt_v32f32_v32f64(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v32f32_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.s
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x float>, ptr %a
  %res = fpext <32 x float> %op1 to <32 x double>
  store <32 x double> %res, ptr %b
  ret void
}

;
; FCVT S -> H
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v2f32_v2f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f32_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    str s0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <2 x float>, ptr %a
  %res = fptrunc <2 x float> %op1 to <2 x half>
  store <2 x half> %res, ptr %b
  ret void
}

; Don't use SVE for 128-bit vectors.
define void @fcvt_v4f32_v4f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f32_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    str d0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x float>, ptr %a
  %res = fptrunc <4 x float> %op1 to <4 x half>
  store <4 x half> %res, ptr %b
  ret void
}

define void @fcvt_v8f32_v8f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v8f32_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.s
; CHECK-NEXT:    st1h { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %res = fptrunc <8 x float> %op1 to <8 x half>
  store <8 x half> %res, ptr %b
  ret void
}

define void @fcvt_v16f32_v16f16(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v16f32_v16f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #8
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    fcvt z0.h, p0/m, z0.s
; VBITS_GE_256-NEXT:    fcvt z1.h, p0/m, z1.s
; VBITS_GE_256-NEXT:    st1h { z0.s }, p0, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.s }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v16f32_v16f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.h, p0/m, z0.s
; VBITS_GE_512-NEXT:    st1h { z0.s }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <16 x float>, ptr %a
  %res = fptrunc <16 x float> %op1 to <16 x half>
  store <16 x half> %res, ptr %b
  ret void
}

define void @fcvt_v32f32_v32f16(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v32f32_v32f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.s
; CHECK-NEXT:    st1h { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x float>, ptr %a
  %res = fptrunc <32 x float> %op1 to <32 x half>
  store <32 x half> %res, ptr %b
  ret void
}

define void @fcvt_v64f32_v64f16(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v64f32_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.s
; CHECK-NEXT:    st1h { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <64 x float>, ptr %a
  %res = fptrunc <64 x float> %op1 to <64 x half>
  store <64 x half> %res, ptr %b
  ret void
}

;
; FCVT D -> H
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v1f64_v1f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v1f64_v1f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    fcvt h0, d0
; CHECK-NEXT:    str h0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <1 x double>, ptr %a
  %res = fptrunc <1 x double> %op1 to <1 x half>
  store <1 x half> %res, ptr %b
  ret void
}

; v2f16 is not legal for NEON, so use SVE
define void @fcvt_v2f64_v2f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f64_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.d
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    str s0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <2 x double>, ptr %a
  %res = fptrunc <2 x double> %op1 to <2 x half>
  store <2 x half> %res, ptr %b
  ret void
}

define void @fcvt_v4f64_v4f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f64_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %res = fptrunc <4 x double> %op1 to <4 x half>
  store <4 x half> %res, ptr %b
  ret void
}

define void @fcvt_v8f64_v8f16(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v8f64_v8f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ptrue p0.d
; VBITS_GE_256-NEXT:    fcvt z0.h, p0/m, z0.d
; VBITS_GE_256-NEXT:    fcvt z1.h, p0/m, z1.d
; VBITS_GE_256-NEXT:    uzp1 z0.s, z0.s, z0.s
; VBITS_GE_256-NEXT:    uzp1 z1.s, z1.s, z1.s
; VBITS_GE_256-NEXT:    uzp1 z0.h, z0.h, z0.h
; VBITS_GE_256-NEXT:    uzp1 z1.h, z1.h, z1.h
; VBITS_GE_256-NEXT:    mov v1.d[1], v0.d[0]
; VBITS_GE_256-NEXT:    str q1, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v8f64_v8f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.h, p0/m, z0.d
; VBITS_GE_512-NEXT:    st1h { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x double>, ptr %a
  %res = fptrunc <8 x double> %op1 to <8 x half>
  store <8 x half> %res, ptr %b
  ret void
}

define void @fcvt_v16f64_v16f16(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v16f64_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x double>, ptr %a
  %res = fptrunc <16 x double> %op1 to <16 x half>
  store <16 x half> %res, ptr %b
  ret void
}

define void @fcvt_v32f64_v32f16(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v32f64_v32f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.h, p0/m, z0.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x double>, ptr %a
  %res = fptrunc <32 x double> %op1 to <32 x half>
  store <32 x half> %res, ptr %b
  ret void
}

;
; FCVT D -> S
;

; Don't use SVE for 64-bit vectors.
define void @fcvt_v1f64_v1f32(<1 x double> %op1, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v1f64_v1f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    str s0, [x0]
; CHECK-NEXT:    ret
  %res = fptrunc <1 x double> %op1 to <1 x float>
  store <1 x float> %res, ptr %b
  ret void
}

; Don't use SVE for 128-bit vectors.
define void @fcvt_v2f64_v2f32(<2 x double> %op1, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v2f64_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %res = fptrunc <2 x double> %op1 to <2 x float>
  store <2 x float> %res, ptr %b
  ret void
}

define void @fcvt_v4f64_v4f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: fcvt_v4f64_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %res = fptrunc <4 x double> %op1 to <4 x float>
  store <4 x float> %res, ptr %b
  ret void
}

define void @fcvt_v8f64_v8f32(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: fcvt_v8f64_v8f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov x8, #4
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    fcvt z0.s, p0/m, z0.d
; VBITS_GE_256-NEXT:    fcvt z1.s, p0/m, z1.d
; VBITS_GE_256-NEXT:    st1w { z0.d }, p0, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.d }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: fcvt_v8f64_v8f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    fcvt z0.s, p0/m, z0.d
; VBITS_GE_512-NEXT:    st1w { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x double>, ptr %a
  %res = fptrunc <8 x double> %op1 to <8 x float>
  store <8 x float> %res, ptr %b
  ret void
}

define void @fcvt_v16f64_v16f32(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: fcvt_v16f64_v16f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <16 x double>, ptr %a
  %res = fptrunc <16 x double> %op1 to <16 x float>
  store <16 x float> %res, ptr %b
  ret void
}

define void @fcvt_v32f64_v32f32(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: fcvt_v32f64_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    fcvt z0.s, p0/m, z0.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %op1 = load <32 x double>, ptr %a
  %res = fptrunc <32 x double> %op1 to <32 x float>
  store <32 x float> %res, ptr %b
  ret void
}

attributes #0 = { "target-features"="+sve" }
