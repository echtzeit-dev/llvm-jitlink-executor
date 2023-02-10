; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=skylake | FileCheck %s

declare void @capture(ptr)

define void @test_natural() "no-realign-stack" {
; CHECK-LABEL: test_natural:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movq %rsp, %rdi
; CHECK-NEXT:    callq capture@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %a = alloca i64
  call void @capture(ptr %a)
  ret void
}

define void @test_realign() {
; CHECK-LABEL: test_realign:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    andq $-64, %rsp
; CHECK-NEXT:    subq $64, %rsp
; CHECK-NEXT:    movq %rsp, %rdi
; CHECK-NEXT:    callq capture@PLT
; CHECK-NEXT:    movq %rbp, %rsp
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    retq
  %a = alloca i64, align 64
  call void @capture(ptr %a)
  ret void
}

define void @test_norealign() "no-realign-stack" {
; CHECK-LABEL: test_norealign:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movq %rsp, %rdi
; CHECK-NEXT:    callq capture@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %a = alloca i64, align 64
  call void @capture(ptr %a)
  ret void
}
