; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple aarch64-apple-darwin | FileCheck %s

define void @test_stnp_v4i64(ptr %p, <4 x i64> %v) #0 {
; CHECK-LABEL: test_stnp_v4i64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret
  store <4 x i64> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4i32(ptr %p, <4 x i32> %v) #0 {
; CHECK-LABEL: test_stnp_v4i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0]
; CHECK-NEXT:    ret
  store <4 x i32> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v8i16(ptr %p, <8 x i16> %v) #0 {
; CHECK-LABEL: test_stnp_v8i16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0]
; CHECK-NEXT:    ret
  store <8 x i16> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v16i8(ptr %p, <16 x i8> %v) #0 {
; CHECK-LABEL: test_stnp_v16i8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0]
; CHECK-NEXT:    ret
  store <16 x i8> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2i32(ptr %p, <2 x i32> %v) #0 {
; CHECK-LABEL: test_stnp_v2i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <2 x i32> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4i16(ptr %p, <4 x i16> %v) #0 {
; CHECK-LABEL: test_stnp_v4i16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <4 x i16> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v8i8(ptr %p, <8 x i8> %v) #0 {
; CHECK-LABEL: test_stnp_v8i8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <8 x i8> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f64(ptr %p, <2 x double> %v) #0 {
; CHECK-LABEL: test_stnp_v2f64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0]
; CHECK-NEXT:    ret
  store <2 x double> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0]
; CHECK-NEXT:    ret
  store <4 x float> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <2 x float> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v1f64(ptr %p, <1 x double> %v) #0 {
; CHECK-LABEL: test_stnp_v1f64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <1 x double> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v1i64(ptr %p, <1 x i64> %v) #0 {
; CHECK-LABEL: test_stnp_v1i64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0]
; CHECK-NEXT:    ret
  store <1 x i64> %v, ptr %p, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_i64(ptr %p, i64 %v) #0 {
; CHECK-LABEL: test_stnp_i64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    lsr x8, x1, #32
; CHECK-NEXT:    stnp w1, w8, [x0]
; CHECK-NEXT:    ret
  store i64 %v, ptr %p, align 1, !nontemporal !0
  ret void
}


define void @test_stnp_v2f64_offset(ptr %p, <2 x double> %v) #0 {
; CHECK-LABEL: test_stnp_v2f64_offset:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0, #16]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr <2 x double>, ptr %p, i32 1
  store <2 x double> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f64_offset_neg(ptr %p, <2 x double> %v) #0 {
; CHECK-LABEL: test_stnp_v2f64_offset_neg:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0, #-16]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr <2 x double>, ptr %p, i32 -1
  store <2 x double> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32_offset(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_offset:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0, #8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr <2 x float>, ptr %p, i32 1
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32_offset_neg(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_offset_neg:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0, #-8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr <2 x float>, ptr %p, i32 -1
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_i64_offset(ptr %p, i64 %v) #0 {
; CHECK-LABEL: test_stnp_i64_offset:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    lsr x8, x1, #32
; CHECK-NEXT:    stnp w1, w8, [x0, #8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i64, ptr %p, i32 1
  store i64 %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_i64_offset_neg(ptr %p, i64 %v) #0 {
; CHECK-LABEL: test_stnp_i64_offset_neg:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    lsr x8, x1, #32
; CHECK-NEXT:    stnp w1, w8, [x0, #-8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i64, ptr %p, i32 -1
  store i64 %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_invalid_offset_4(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_invalid_offset_4:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    add x8, x0, #4
; CHECK-NEXT:    stnp d0, d1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 4
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_invalid_offset_neg_4(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_invalid_offset_neg_4:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    sub x8, x0, #4
; CHECK-NEXT:    stnp d0, d1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 -4
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_invalid_offset_512(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_invalid_offset_512:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    add x8, x0, #512
; CHECK-NEXT:    stnp d0, d1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 512
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_offset_504(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_offset_504:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0, #504]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 504
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_invalid_offset_508(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_invalid_offset_508:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    add x8, x0, #508
; CHECK-NEXT:    stnp d0, d1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 508
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_invalid_offset_neg_520(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_invalid_offset_neg_520:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    sub x8, x0, #520
; CHECK-NEXT:    stnp d0, d1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 -520
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v4f32_offset_neg_512(ptr %p, <4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_offset_neg_512:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    stnp d0, d1, [x0, #-512]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 -512
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}


define void @test_stnp_v2f32_invalid_offset_256(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_invalid_offset_256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    add x8, x0, #256
; CHECK-NEXT:    stnp s0, s1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 256
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32_offset_252(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_offset_252:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0, #252]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 252
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32_invalid_offset_neg_260(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_invalid_offset_neg_260:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    sub x8, x0, #260
; CHECK-NEXT:    stnp s0, s1, [x8]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 -260
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

define void @test_stnp_v2f32_offset_neg_256(ptr %p, <2 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v2f32_offset_neg_256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ; kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov s1, v0[1]
; CHECK-NEXT:    stnp s0, s1, [x0, #-256]
; CHECK-NEXT:    ret
  %tmp0 = getelementptr i8, ptr %p, i32 -256
  store <2 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  ret void
}

declare void @dummy(ptr)

define void @test_stnp_v4f32_offset_alloca(<4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_offset_alloca:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    stnp d0, d1, [sp]
; CHECK-NEXT:    bl _dummy
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %tmp0 = alloca <4 x float>
  store <4 x float> %v, ptr %tmp0, align 1, !nontemporal !0
  call void @dummy(ptr %tmp0)
  ret void
}

define void @test_stnp_v4f32_offset_alloca_2(<4 x float> %v) #0 {
; CHECK-LABEL: test_stnp_v4f32_offset_alloca_2:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    mov d1, v0[1]
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp x29, x30, [sp, #32] ; 16-byte Folded Spill
; CHECK-NEXT:    stnp d0, d1, [sp, #16]
; CHECK-NEXT:    bl _dummy
; CHECK-NEXT:    ldp x29, x30, [sp, #32] ; 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %tmp0 = alloca <4 x float>, i32 2
  %tmp1 = getelementptr <4 x float>, ptr %tmp0, i32 1
  store <4 x float> %v, ptr %tmp1, align 1, !nontemporal !0
  call void @dummy(ptr %tmp0)
  ret void
}

define void @test_stnp_v32i8(<32 x i8> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v32i8:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <32 x i8> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v32i16(<32 x i16> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v32i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <32 x i16> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v32f16(<32 x half> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v32f16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <32 x half> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v16i32(<16 x i32> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v16i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <16 x i32> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v16f32(<16 x float> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v16f32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <16 x float> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v17f32(<17 x float> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v17f32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldr s16, [sp, #16]
; CHECK-NEXT:    add x8, sp, #20
; CHECK-NEXT:    ldr s17, [sp]
; CHECK-NEXT:    add x9, sp, #4
; CHECK-NEXT:    ; kill: def $s4 killed $s4 def $q4
; CHECK-NEXT:    ; kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    ; kill: def $s5 killed $s5 def $q5
; CHECK-NEXT:    ; kill: def $s1 killed $s1 def $q1
; CHECK-NEXT:    ; kill: def $s6 killed $s6 def $q6
; CHECK-NEXT:    ; kill: def $s2 killed $s2 def $q2
; CHECK-NEXT:    ; kill: def $s7 killed $s7 def $q7
; CHECK-NEXT:    ; kill: def $s3 killed $s3 def $q3
; CHECK-NEXT:    ld1.s { v16 }[1], [x8]
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    ld1.s { v17 }[1], [x9]
; CHECK-NEXT:    add x9, sp, #8
; CHECK-NEXT:    mov.s v4[1], v5[0]
; CHECK-NEXT:    mov.s v0[1], v1[0]
; CHECK-NEXT:    ld1.s { v16 }[2], [x8]
; CHECK-NEXT:    add x8, sp, #28
; CHECK-NEXT:    ld1.s { v17 }[2], [x9]
; CHECK-NEXT:    add x9, sp, #12
; CHECK-NEXT:    mov.s v4[2], v6[0]
; CHECK-NEXT:    mov.s v0[2], v2[0]
; CHECK-NEXT:    ld1.s { v16 }[3], [x8]
; CHECK-NEXT:    ld1.s { v17 }[3], [x9]
; CHECK-NEXT:    mov.s v4[3], v7[0]
; CHECK-NEXT:    mov.s v0[3], v3[0]
; CHECK-NEXT:    mov d1, v16[1]
; CHECK-NEXT:    mov d2, v17[1]
; CHECK-NEXT:    mov d3, v4[1]
; CHECK-NEXT:    mov d5, v0[1]
; CHECK-NEXT:    stnp d16, d1, [x0, #48]
; CHECK-NEXT:    ldr s1, [sp, #32]
; CHECK-NEXT:    stnp d17, d2, [x0, #32]
; CHECK-NEXT:    stnp d4, d3, [x0, #16]
; CHECK-NEXT:    stnp d0, d5, [x0]
; CHECK-NEXT:    str s1, [x0, #64]
; CHECK-NEXT:    ret

entry:
  store <17 x float> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}
define void @test_stnp_v16i32_invalid_offset(<16 x i32> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v16i32_invalid_offset:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    mov w8, #32032
; CHECK-NEXT:    mov w9, #32000
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    add x9, x0, x9
; CHECK-NEXT:    stnp q2, q3, [x8]
; CHECK-NEXT:    stnp q0, q1, [x9]
; CHECK-NEXT:    ret

entry:
  %gep = getelementptr <16 x i32>, ptr %ptr, i32 500
  store <16 x i32> %v, ptr %gep, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v16f64(<16 x double> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v16f64:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q6, q7, [x0, #96]
; CHECK-NEXT:    stnp q4, q5, [x0, #64]
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <16 x double> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

define void @test_stnp_v16i64(<16 x i64> %v, ptr %ptr) {
; CHECK-LABEL: test_stnp_v16i64:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    stnp q6, q7, [x0, #96]
; CHECK-NEXT:    stnp q4, q5, [x0, #64]
; CHECK-NEXT:    stnp q2, q3, [x0, #32]
; CHECK-NEXT:    stnp q0, q1, [x0]
; CHECK-NEXT:    ret

entry:
  store <16 x i64> %v, ptr %ptr, align 4, !nontemporal !0
  ret void
}

!0 = !{ i32 1 }

attributes #0 = { nounwind }
