; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-linux-gnu | FileCheck %s --check-prefixes=X86

define { i64, i8 } @mulodi_test(i64 %l, i64 %r) unnamed_addr #0 {
; X86-LABEL: mulodi_test:
; X86:       # %bb.0: # %start
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 20
; X86-NEXT:    .cfi_offset %esi, -20
; X86-NEXT:    .cfi_offset %edi, -16
; X86-NEXT:    .cfi_offset %ebx, -12
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    setne %dl
; X86-NEXT:    testl %eax, %eax
; X86-NEXT:    setne %cl
; X86-NEXT:    andb %dl, %cl
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    seto %bl
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    mull %ebp
; X86-NEXT:    seto %ch
; X86-NEXT:    orb %bl, %ch
; X86-NEXT:    orb %cl, %ch
; X86-NEXT:    leal (%edi,%eax), %esi
; X86-NEXT:    movl %ebp, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %esi, %edx
; X86-NEXT:    setb %cl
; X86-NEXT:    orb %ch, %cl
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
start:
  %0 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %l, i64 %r) #2
  %1 = extractvalue { i64, i1 } %0, 0
  %2 = extractvalue { i64, i1 } %0, 1
  %3 = zext i1 %2 to i8
  %4 = insertvalue { i64, i8 } undef, i64 %1, 0
  %5 = insertvalue { i64, i8 } %4, i8 %3, 1
  ret { i64, i8 } %5
}

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #1

attributes #0 = { nounwind readnone uwtable }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }
