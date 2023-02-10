; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-apple-ios -aarch64-redzone | FileCheck %s --check-prefixes=CHECK,CHECK64
; RUN: llc < %s -mtriple=arm64_32-apple-ios -aarch64-redzone | FileCheck %s --check-prefixes=CHECK,CHECK32

define ptr @store64(ptr %ptr, i64 %index, i64 %spacing) {
; CHECK-LABEL: store64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str x2, [x0], #8
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 1
  store i64 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store64idxpos256(ptr %ptr, i64 %index, i64 %spacing) {
; CHECK-LABEL: store64idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    str x2, [x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 32
  store i64 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store64idxneg256(ptr %ptr, i64 %index, i64 %spacing) {
; CHECK-LABEL: store64idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str x2, [x0], #-256
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 -32
  store i64 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store32(ptr %ptr, i32 %index, i32 %spacing) {
; CHECK-LABEL: store32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w2, [x0], #4
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 1
  store i32 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store32idxpos256(ptr %ptr, i32 %index, i32 %spacing) {
; CHECK-LABEL: store32idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    str w2, [x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 64
  store i32 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store32idxneg256(ptr %ptr, i32 %index, i32 %spacing) {
; CHECK-LABEL: store32idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w2, [x0], #-256
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 -64
  store i32 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store16(ptr %ptr, i16 %index, i16 %spacing) {
; CHECK-LABEL: store16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w2, [x0], #2
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 1
  store i16 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store16idxpos256(ptr %ptr, i16 %index, i16 %spacing) {
; CHECK-LABEL: store16idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    strh w2, [x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 128
  store i16 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store16idxneg256(ptr %ptr, i16 %index, i16 %spacing) {
; CHECK-LABEL: store16idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w2, [x0], #-256
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 -128
  store i16 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store8(ptr %ptr, i8 %index, i8 %spacing) {
; CHECK-LABEL: store8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w2, [x0], #1
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 1
  store i8 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store8idxpos256(ptr %ptr, i8 %index, i8 %spacing) {
; CHECK-LABEL: store8idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    strb w2, [x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 256
  store i8 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @store8idxneg256(ptr %ptr, i8 %index, i8 %spacing) {
; CHECK-LABEL: store8idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w2, [x0], #-256
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 -256
  store i8 %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @truncst64to32(ptr %ptr, i32 %index, i64 %spacing) {
; CHECK-LABEL: truncst64to32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w2, [x0], #4
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 1
  %trunc = trunc i64 %spacing to i32
  store i32 %trunc, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @truncst64to16(ptr %ptr, i16 %index, i64 %spacing) {
; CHECK-LABEL: truncst64to16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w2, [x0], #2
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 1
  %trunc = trunc i64 %spacing to i16
  store i16 %trunc, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @truncst64to8(ptr %ptr, i8 %index, i64 %spacing) {
; CHECK-LABEL: truncst64to8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w2, [x0], #1
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 1
  %trunc = trunc i64 %spacing to i8
  store i8 %trunc, ptr %ptr, align 4
  ret ptr %incdec.ptr
}


define ptr @storef16(ptr %ptr, half %index, half %spacing) nounwind {
; CHECK-LABEL: storef16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str h1, [x0], #2
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds half, ptr %ptr, i64 1
  store half %spacing, ptr %ptr, align 2
  ret ptr %incdec.ptr
}

define ptr @storef32(ptr %ptr, float %index, float %spacing) {
; CHECK-LABEL: storef32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str s1, [x0], #4
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds float, ptr %ptr, i64 1
  store float %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @storef64(ptr %ptr, double %index, double %spacing) {
; CHECK-LABEL: storef64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str d1, [x0], #8
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds double, ptr %ptr, i64 1
  store double %spacing, ptr %ptr, align 4
  ret ptr %incdec.ptr
}


define ptr @pref64(ptr %ptr, double %spacing) {
; CHECK-LABEL: pref64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str d0, [x0, #32]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds double, ptr %ptr, i64 4
  store double %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pref32(ptr %ptr, float %spacing) {
; CHECK-LABEL: pref32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str s0, [x0, #12]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds float, ptr %ptr, i64 3
  store float %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pref16(ptr %ptr, half %spacing) nounwind {
; CHECK-LABEL: pref16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str h0, [x0, #6]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds half, ptr %ptr, i64 3
  store half %spacing, ptr %incdec.ptr, align 2
  ret ptr %incdec.ptr
}

define ptr @pre64(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pre64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str x1, [x0, #16]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 2
  store i64 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre64idxpos256(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pre64idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    str x1, [x8, #256]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 32
  store i64 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre64idxneg256(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pre64idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str x1, [x0, #-256]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, ptr %ptr, i64 -32
  store i64 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre32(ptr %ptr, i32 %spacing) {
; CHECK-LABEL: pre32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w1, [x0, #8]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 2
  store i32 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre32idxpos256(ptr %ptr, i32 %spacing) {
; CHECK-LABEL: pre32idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    str w1, [x8, #256]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 64
  store i32 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre32idxneg256(ptr %ptr, i32 %spacing) {
; CHECK-LABEL: pre32idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w1, [x0, #-256]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 -64
  store i32 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre16(ptr %ptr, i16 %spacing) {
; CHECK-LABEL: pre16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w1, [x0, #4]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 2
  store i16 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre16idxpos256(ptr %ptr, i16 %spacing) {
; CHECK-LABEL: pre16idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    strh w1, [x8, #256]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 128
  store i16 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre16idxneg256(ptr %ptr, i16 %spacing) {
; CHECK-LABEL: pre16idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w1, [x0, #-256]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 -128
  store i16 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre8(ptr %ptr, i8 %spacing) {
; CHECK-LABEL: pre8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w1, [x0, #2]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 2
  store i8 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre8idxpos256(ptr %ptr, i8 %spacing) {
; CHECK-LABEL: pre8idxpos256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    add x0, x0, #256
; CHECK-NEXT:    strb w1, [x8, #256]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 256
  store i8 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pre8idxneg256(ptr %ptr, i8 %spacing) {
; CHECK-LABEL: pre8idxneg256:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w1, [x0, #-256]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 -256
  store i8 %spacing, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pretrunc64to32(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pretrunc64to32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    str w1, [x0, #8]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i32, ptr %ptr, i64 2
  %trunc = trunc i64 %spacing to i32
  store i32 %trunc, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pretrunc64to16(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pretrunc64to16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w1, [x0, #4]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i16, ptr %ptr, i64 2
  %trunc = trunc i64 %spacing to i16
  store i16 %trunc, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

define ptr @pretrunc64to8(ptr %ptr, i64 %spacing) {
; CHECK-LABEL: pretrunc64to8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w1, [x0, #2]!
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i8, ptr %ptr, i64 2
  %trunc = trunc i64 %spacing to i8
  store i8 %trunc, ptr %incdec.ptr, align 4
  ret ptr %incdec.ptr
}

;-----
; Pre-indexed loads
;-----
define ptr @preidxf64(ptr %src, ptr %out) {
; CHECK-LABEL: preidxf64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldr d0, [x0, #8]!
; CHECK-NEXT:    str d0, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds double, ptr %src, i64 1
  %tmp = load double, ptr %ptr, align 4
  store double %tmp, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidxf32(ptr %src, ptr %out) {
; CHECK-LABEL: preidxf32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldr s0, [x0, #4]!
; CHECK-NEXT:    str s0, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds float, ptr %src, i64 1
  %tmp = load float, ptr %ptr, align 4
  store float %tmp, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidxf16(ptr %src, ptr %out) {
; CHECK-LABEL: preidxf16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldr h0, [x0, #2]!
; CHECK-NEXT:    str h0, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds half, ptr %src, i64 1
  %tmp = load half, ptr %ptr, align 2
  store half %tmp, ptr %out, align 2
  ret ptr %ptr
}

define ptr @preidx64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldr x8, [x0, #8]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i64, ptr %src, i64 1
  %tmp = load i64, ptr %ptr, align 4
  store i64 %tmp, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx32(ptr %src, ptr %out) {
; CHECK-LABEL: preidx32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldr w8, [x0, #4]!
; CHECK-NEXT:    str w8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i32, ptr %src, i64 1
  %tmp = load i32, ptr %ptr, align 4
  store i32 %tmp, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx16zext32(ptr %src, ptr %out) {
; CHECK-LABEL: preidx16zext32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrh w8, [x0, #2]!
; CHECK-NEXT:    str w8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i16, ptr %src, i64 1
  %tmp = load i16, ptr %ptr, align 4
  %ext = zext i16 %tmp to i32
  store i32 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx16zext64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx16zext64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrh w8, [x0, #2]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i16, ptr %src, i64 1
  %tmp = load i16, ptr %ptr, align 4
  %ext = zext i16 %tmp to i64
  store i64 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx8zext32(ptr %src, ptr %out) {
; CHECK-LABEL: preidx8zext32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrb w8, [x0, #1]!
; CHECK-NEXT:    str w8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i8, ptr %src, i64 1
  %tmp = load i8, ptr %ptr, align 4
  %ext = zext i8 %tmp to i32
  store i32 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx8zext64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx8zext64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrb w8, [x0, #1]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i8, ptr %src, i64 1
  %tmp = load i8, ptr %ptr, align 4
  %ext = zext i8 %tmp to i64
  store i64 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx32sext64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx32sext64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrsw x8, [x0, #4]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i32, ptr %src, i64 1
  %tmp = load i32, ptr %ptr, align 4
  %ext = sext i32 %tmp to i64
  store i64 %ext, ptr %out, align 8
  ret ptr %ptr
}

define ptr @preidx16sext32(ptr %src, ptr %out) {
; CHECK-LABEL: preidx16sext32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrsh w8, [x0, #2]!
; CHECK-NEXT:    str w8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i16, ptr %src, i64 1
  %tmp = load i16, ptr %ptr, align 4
  %ext = sext i16 %tmp to i32
  store i32 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx16sext64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx16sext64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrsh x8, [x0, #2]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i16, ptr %src, i64 1
  %tmp = load i16, ptr %ptr, align 4
  %ext = sext i16 %tmp to i64
  store i64 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx8sext32(ptr %src, ptr %out) {
; CHECK-LABEL: preidx8sext32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrsb w8, [x0, #1]!
; CHECK-NEXT:    str w8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i8, ptr %src, i64 1
  %tmp = load i8, ptr %ptr, align 4
  %ext = sext i8 %tmp to i32
  store i32 %ext, ptr %out, align 4
  ret ptr %ptr
}

define ptr @preidx8sext64(ptr %src, ptr %out) {
; CHECK-LABEL: preidx8sext64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldrsb x8, [x0, #1]!
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i8, ptr %src, i64 1
  %tmp = load i8, ptr %ptr, align 4
  %ext = sext i8 %tmp to i64
  store i64 %ext, ptr %out, align 4
  ret ptr %ptr
}

; This test checks if illegal post-index is generated

define ptr @postidx_clobber(ptr %addr) nounwind noinline ssp {
; CHECK64-LABEL: postidx_clobber:
; CHECK64:       ; %bb.0:
; CHECK64-NEXT:    mov x8, x0
; CHECK64-NEXT:    str x0, [x8], #8
; CHECK64-NEXT:    mov x0, x8
; CHECK64-NEXT:    ret
;
; CHECK32-LABEL: postidx_clobber:
; CHECK32:       ; %bb.0:
; CHECK32-NEXT:    mov x8, x0
; CHECK32-NEXT:    add w0, w8, #8
; CHECK32-NEXT:    str w8, [x8]
; CHECK32-NEXT:    ret
; ret
 store ptr %addr, ptr %addr
 %newaddr = getelementptr i64, ptr %addr, i32 1
 ret ptr %newaddr
}
