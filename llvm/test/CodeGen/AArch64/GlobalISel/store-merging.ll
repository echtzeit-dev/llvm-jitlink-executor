; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-apple-ios -global-isel -global-isel-abort=1 - < %s | FileCheck %s

define void @test_simple_2xs8(ptr %ptr) {
; CHECK-LABEL: test_simple_2xs8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    strb w9, [x0, #1]
; CHECK-NEXT:    ret
  store i8 4, ptr %ptr
  %addr2 = getelementptr i8, ptr %ptr, i64 1
  store i8 5, ptr %addr2
  ret void
}

define void @test_simple_2xs16(ptr %ptr) {
; CHECK-LABEL: test_simple_2xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    movk w8, #5, lsl #16
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  store i16 4, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 5, ptr %addr2
  ret void
}

define void @test_simple_4xs16(ptr %ptr) {
; CHECK-LABEL: test_simple_4xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, #4
; CHECK-NEXT:    movk x8, #5, lsl #16
; CHECK-NEXT:    movk x8, #9, lsl #32
; CHECK-NEXT:    movk x8, #14, lsl #48
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  store i16 4, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 5, ptr %addr2
  %addr3 = getelementptr i16, ptr %ptr, i64 2
  store i16 9, ptr %addr3
  %addr4 = getelementptr i16, ptr %ptr, i64 3
  store i16 14, ptr %addr4
  ret void
}

define void @test_simple_2xs32(ptr %ptr) {
; CHECK-LABEL: test_simple_2xs32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x8, #4
; CHECK-NEXT:    movk x8, #5, lsl #32
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  store i32 4, ptr %ptr
  %addr2 = getelementptr i32, ptr %ptr, i64 1
  store i32 5, ptr %addr2
  ret void
}

define void @test_simple_2xs64_illegal(ptr %ptr) {
; CHECK-LABEL: test_simple_2xs64_illegal:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    stp x8, x9, [x0]
; CHECK-NEXT:    ret
  store i64 4, ptr %ptr
  %addr2 = getelementptr i64, ptr %ptr, i64 1
  store i64 5, ptr %addr2
  ret void
}

; Don't merge vectors...yet.
define void @test_simple_vector(ptr %ptr) {
; CHECK-LABEL: test_simple_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #7
; CHECK-NEXT:    mov w10, #5
; CHECK-NEXT:    mov w11, #8
; CHECK-NEXT:    strh w8, [x0]
; CHECK-NEXT:    strh w9, [x0, #2]
; CHECK-NEXT:    strh w10, [x0, #4]
; CHECK-NEXT:    strh w11, [x0, #6]
; CHECK-NEXT:    ret
  store <2 x i16> <i16 4, i16 7>, ptr %ptr
  %addr2 = getelementptr <2 x i16>, ptr %ptr, i64 1
  store <2 x i16> <i16 5, i16 8>, ptr %addr2
  ret void
}

define i32 @test_unknown_alias(ptr %ptr, ptr %aliasptr) {
; CHECK-LABEL: test_unknown_alias:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w9, #4
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    str w9, [x0]
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    ldr w0, [x1]
; CHECK-NEXT:    str w9, [x8, #4]
; CHECK-NEXT:    ret
  store i32 4, ptr %ptr
  %ld = load i32, ptr %aliasptr
  %addr2 = getelementptr i32, ptr %ptr, i64 1
  store i32 5, ptr %addr2
  ret i32 %ld
}

define void @test_2x_2xs32(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: test_2x_2xs32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov x10, #9
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    movk x10, #17, lsl #32
; CHECK-NEXT:    stp w8, w9, [x0]
; CHECK-NEXT:    str x10, [x1]
; CHECK-NEXT:    ret
  store i32 4, ptr %ptr
  %addr2 = getelementptr i32, ptr %ptr, i64 1
  store i32 5, ptr %addr2

  store i32 9, ptr %ptr2
  %addr4 = getelementptr i32, ptr %ptr2, i64 1
  store i32 17, ptr %addr4
  ret void
}

define void @test_simple_var_2xs8(ptr %ptr, i8 %v1, i8 %v2) {
; CHECK-LABEL: test_simple_var_2xs8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strb w1, [x0]
; CHECK-NEXT:    strb w2, [x0, #1]
; CHECK-NEXT:    ret
  store i8 %v1, ptr %ptr
  %addr2 = getelementptr i8, ptr %ptr, i64 1
  store i8 %v2, ptr %addr2
  ret void
}

define void @test_simple_var_2xs16(ptr %ptr, i16 %v1, i16 %v2) {
; CHECK-LABEL: test_simple_var_2xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    strh w1, [x0]
; CHECK-NEXT:    strh w2, [x0, #2]
; CHECK-NEXT:    ret
  store i16 %v1, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 %v2, ptr %addr2
  ret void
}

define void @test_simple_var_2xs32(ptr %ptr, i32 %v1, i32 %v2) {
; CHECK-LABEL: test_simple_var_2xs32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    stp w1, w2, [x0]
; CHECK-NEXT:    ret
  store i32 %v1, ptr %ptr
  %addr2 = getelementptr i32, ptr %ptr, i64 1
  store i32 %v2, ptr %addr2
  ret void
}


; The store to ptr2 prevents merging into a single store.
; We can still merge the stores into addr1 and addr2.
define void @test_alias_4xs16(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: test_alias_4xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #9
; CHECK-NEXT:    movk w8, #5, lsl #16
; CHECK-NEXT:    mov w10, #14
; CHECK-NEXT:    strh w9, [x0, #4]
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    strh wzr, [x1]
; CHECK-NEXT:    strh w10, [x0, #6]
; CHECK-NEXT:    ret
  store i16 4, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 5, ptr %addr2
  %addr3 = getelementptr i16, ptr %ptr, i64 2
  store i16 9, ptr %addr3
  store i16 0, ptr %ptr2
  %addr4 = getelementptr i16, ptr %ptr, i64 3
  store i16 14, ptr %addr4
  ret void
}

; Here store of 5 and 9 can be merged, others have aliasing barriers.
define void @test_alias2_4xs16(ptr %ptr, ptr %ptr2, ptr %ptr3) {
; CHECK-LABEL: test_alias2_4xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    movk w9, #9, lsl #16
; CHECK-NEXT:    strh w8, [x0]
; CHECK-NEXT:    mov w8, #14
; CHECK-NEXT:    strh wzr, [x2]
; CHECK-NEXT:    stur w9, [x0, #2]
; CHECK-NEXT:    strh wzr, [x1]
; CHECK-NEXT:    strh w8, [x0, #6]
; CHECK-NEXT:    ret
  store i16 4, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 0, ptr %ptr3
  store i16 5, ptr %addr2
  %addr3 = getelementptr i16, ptr %ptr, i64 2
  store i16 9, ptr %addr3
  store i16 0, ptr %ptr2
  %addr4 = getelementptr i16, ptr %ptr, i64 3
  store i16 14, ptr %addr4
  ret void
}

; No merging can be done here.
define void @test_alias3_4xs16(ptr %ptr, ptr %ptr2, ptr %ptr3, ptr %ptr4) {
; CHECK-LABEL: test_alias3_4xs16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    strh w8, [x0]
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    strh wzr, [x2]
; CHECK-NEXT:    strh w9, [x0, #2]
; CHECK-NEXT:    mov w9, #14
; CHECK-NEXT:    strh wzr, [x3]
; CHECK-NEXT:    strh w8, [x0, #4]
; CHECK-NEXT:    strh wzr, [x1]
; CHECK-NEXT:    strh w9, [x0, #6]
; CHECK-NEXT:    ret
  store i16 4, ptr %ptr
  %addr2 = getelementptr i16, ptr %ptr, i64 1
  store i16 0, ptr %ptr3
  store i16 5, ptr %addr2
  store i16 0, ptr %ptr4
  %addr3 = getelementptr i16, ptr %ptr, i64 2
  store i16 9, ptr %addr3
  store i16 0, ptr %ptr2
  %addr4 = getelementptr i16, ptr %ptr, i64 3
  store i16 14, ptr %addr4
  ret void
}

; Can merge because the load is from a different alloca and can't alias.
define i32 @test_alias_allocas_2xs32(ptr %ptr) {
; CHECK-LABEL: test_alias_allocas_2xs32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    mov x8, #4
; CHECK-NEXT:    ldr w0, [sp, #4]
; CHECK-NEXT:    movk x8, #5, lsl #32
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %a1 = alloca [6 x i32]
  %a2 = alloca i32, align 4
  store i32 4, ptr %a1
  %ld = load i32, ptr %a2
  %addr2 = getelementptr [6 x i32], ptr %a1, i64 0, i32 1
  store i32 5, ptr %addr2
  ret i32 %ld
}

define void @test_volatile(ptr %ptr) {
; CHECK-LABEL: test_volatile:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    str wzr, [x8]
; CHECK-NEXT:    str wzr, [x8, #4]
; CHECK-NEXT:    ret
entry:
  %0 = load ptr, ptr %ptr, align 8
  store volatile i32 0, ptr %0, align 4;
  %add.ptr.i.i38 = getelementptr inbounds i32, ptr %0, i64 1
  store volatile i32 0, ptr %add.ptr.i.i38, align 4
  ret void
}

define void @test_atomic(ptr %ptr) {
; CHECK-LABEL: test_atomic:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    add x9, x8, #4
; CHECK-NEXT:    stlr wzr, [x8]
; CHECK-NEXT:    stlr wzr, [x9]
; CHECK-NEXT:    ret
entry:
  %0 = load ptr, ptr %ptr, align 8
  store atomic i32 0, ptr %0 release, align 4;
  %add.ptr.i.i38 = getelementptr inbounds i32, ptr %0, i64 1
  store atomic i32 0, ptr %add.ptr.i.i38 release, align 4
  ret void
}
