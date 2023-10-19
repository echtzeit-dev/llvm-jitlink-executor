; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 --x86-asm-syntax=intel -mtriple=x86_64 -mattr=avx < %s | FileCheck %s

define void @extracter0([4 x <4 x i1>] %matrix) {
; CHECK-LABEL: extracter0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    push rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    push r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    push rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset rbx, -32
; CHECK-NEXT:    .cfi_offset r14, -24
; CHECK-NEXT:    .cfi_offset rbp, -16
; CHECK-NEXT:    vpslld xmm0, xmm0, 31
; CHECK-NEXT:    vmovmskps edi, xmm0
; CHECK-NEXT:    mov ebx, edi
; CHECK-NEXT:    shr bl, 3
; CHECK-NEXT:    mov ebp, edi
; CHECK-NEXT:    and bpl, 4
; CHECK-NEXT:    shr bpl, 2
; CHECK-NEXT:    mov r14d, edi
; CHECK-NEXT:    and r14b, 2
; CHECK-NEXT:    shr r14b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, r14b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, bpl
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, bl
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    pop rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pop r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pop rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    ret
  %1 = extractvalue [4 x <4 x i1>] %matrix, 0
  %2 = extractelement <4 x i1> %1, i64 0
  %3 = extractelement <4 x i1> %1, i64 1
  %4 = extractelement <4 x i1> %1, i64 2
  %5 = extractelement <4 x i1> %1, i64 3
  call void @print_i1(i1 %2)
  call void @print_i1(i1 %3)
  call void @print_i1(i1 %4)
  call void @print_i1(i1 %5)
  ret void
}

define void @extracter1([4 x <4 x i1>] %matrix) {
; CHECK-LABEL: extracter1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    push rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    push r15
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    push r14
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    push r13
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    push r12
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    push rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 56
; CHECK-NEXT:    push rax
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset rbx, -56
; CHECK-NEXT:    .cfi_offset r12, -48
; CHECK-NEXT:    .cfi_offset r13, -40
; CHECK-NEXT:    .cfi_offset r14, -32
; CHECK-NEXT:    .cfi_offset r15, -24
; CHECK-NEXT:    .cfi_offset rbp, -16
; CHECK-NEXT:    vpslld xmm1, xmm1, 31
; CHECK-NEXT:    vmovmskps ebx, xmm1
; CHECK-NEXT:    mov eax, ebx
; CHECK-NEXT:    shr al, 3
; CHECK-NEXT:    mov byte ptr [rsp + 7], al # 1-byte Spill
; CHECK-NEXT:    mov r14d, ebx
; CHECK-NEXT:    and r14b, 4
; CHECK-NEXT:    shr r14b, 2
; CHECK-NEXT:    mov r15d, ebx
; CHECK-NEXT:    and r15b, 2
; CHECK-NEXT:    shr r15b
; CHECK-NEXT:    vpslld xmm0, xmm0, 31
; CHECK-NEXT:    vmovmskps edi, xmm0
; CHECK-NEXT:    mov r12d, edi
; CHECK-NEXT:    shr r12b, 3
; CHECK-NEXT:    mov r13d, edi
; CHECK-NEXT:    and r13b, 4
; CHECK-NEXT:    shr r13b, 2
; CHECK-NEXT:    mov ebp, edi
; CHECK-NEXT:    and bpl, 2
; CHECK-NEXT:    shr bpl
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, bpl
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, r13b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, r12b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    mov edi, ebx
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, r15b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, r14b
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    movzx edi, byte ptr [rsp + 7] # 1-byte Folded Reload
; CHECK-NEXT:    call print_i1@PLT
; CHECK-NEXT:    add rsp, 8
; CHECK-NEXT:    .cfi_def_cfa_offset 56
; CHECK-NEXT:    pop rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    pop r12
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    pop r13
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    pop r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pop r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pop rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    ret
  %1 = extractvalue [4 x <4 x i1>] %matrix, 0
  %2 = extractelement <4 x i1> %1, i64 0
  %3 = extractelement <4 x i1> %1, i64 1
  %4 = extractelement <4 x i1> %1, i64 2
  %5 = extractelement <4 x i1> %1, i64 3
  call void @print_i1(i1 %2)
  call void @print_i1(i1 %3)
  call void @print_i1(i1 %4)
  call void @print_i1(i1 %5)
  %6 = extractvalue [4 x <4 x i1>] %matrix, 1
  %7 = extractelement <4 x i1> %6, i64 0
  %8 = extractelement <4 x i1> %6, i64 1
  %9 = extractelement <4 x i1> %6, i64 2
  %10 = extractelement <4 x i1> %6, i64 3
  call void @print_i1(i1 %7)
  call void @print_i1(i1 %8)
  call void @print_i1(i1 %9)
  call void @print_i1(i1 %10)
  ret void
}

declare void @print_i1(i1)
