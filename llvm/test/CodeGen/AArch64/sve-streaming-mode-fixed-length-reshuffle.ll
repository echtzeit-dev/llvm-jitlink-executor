; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve  < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

; == Matching first N elements ==

define <4 x i1> @reshuffle_v4i1_nxv4i1(<vscale x 4 x i1> %a) #0 {
; CHECK-LABEL: reshuffle_v4i1_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    mov z0.s, p0/z, #1 // =0x1
; CHECK-NEXT:    mov z1.s, z0.s[3]
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    mov z2.s, z0.s[2]
; CHECK-NEXT:    mov z0.s, z0.s[1]
; CHECK-NEXT:    fmov w9, s1
; CHECK-NEXT:    fmov w10, s2
; CHECK-NEXT:    fmov w11, s0
; CHECK-NEXT:    strh w8, [sp, #8]
; CHECK-NEXT:    strh w9, [sp, #14]
; CHECK-NEXT:    strh w10, [sp, #12]
; CHECK-NEXT:    strh w11, [sp, #10]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %el0 = extractelement <vscale x 4 x i1> %a, i32 0
  %el1 = extractelement <vscale x 4 x i1> %a, i32 1
  %el2 = extractelement <vscale x 4 x i1> %a, i32 2
  %el3 = extractelement <vscale x 4 x i1> %a, i32 3
  %v0 = insertelement <4 x i1> undef, i1 %el0, i32 0
  %v1 = insertelement <4 x i1> %v0, i1 %el1, i32 1
  %v2 = insertelement <4 x i1> %v1, i1 %el2, i32 2
  %v3 = insertelement <4 x i1> %v2, i1 %el3, i32 3
  ret <4 x i1> %v3
}

attributes #0 = { "target-features"="+sve" }
