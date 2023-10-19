; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm64-apple-ios %s -o - | FileCheck %s

define void @foo() {
; CHECK-LABEL: foo:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    stp x28, x27, [sp, #-32]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w27, -24
; CHECK-NEXT:    .cfi_offset w28, -32
; CHECK-NEXT:    sub sp, sp, #1, lsl #12 ; =4096
; CHECK-NEXT:    .cfi_def_cfa_offset 4128
; CHECK-NEXT:    sub sp, sp, #80
; CHECK-NEXT:    .cfi_def_cfa_offset 4208
; CHECK-NEXT:    adds x8, sp, #1, lsl #12 ; =4096
; CHECK-NEXT:    cmn x8, #32
; CHECK-NEXT:    b.eq LBB0_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    bl _baz
; CHECK-NEXT:    b LBB0_3
; CHECK-NEXT:  LBB0_2: ; %true
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:  LBB0_3: ; %common.ret
; CHECK-NEXT:    add sp, sp, #1, lsl #12 ; =4096
; CHECK-NEXT:    add sp, sp, #80
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldp x28, x27, [sp], #32 ; 16-byte Folded Reload
; CHECK-NEXT:    ret

%var = alloca i32, i32 12
  %var2 = alloca i32, i32 1030
  %tst = icmp eq ptr %var, null
  br i1 %tst, label %true, label %false

true:
  call void @bar()
  ret void

false:
  call void @baz()
  ret void
}

declare void @bar()
declare void @baz()
