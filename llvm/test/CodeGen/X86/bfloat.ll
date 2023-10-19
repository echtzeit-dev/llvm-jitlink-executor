; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-gnu | FileCheck %s --check-prefixes=CHECK,SSE2
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=avx512bf16 | FileCheck %s --check-prefixes=CHECK,BF16

define void @add(ptr %pa, ptr %pb, ptr %pc) nounwind {
; SSE2-LABEL: add:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rbx
; SSE2-NEXT:    movq %rdx, %rbx
; SSE2-NEXT:    movzwl (%rsi), %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movzwl (%rdi), %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movw %ax, (%rbx)
; SSE2-NEXT:    popq %rbx
; SSE2-NEXT:    retq
;
; BF16-LABEL: add:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rbx
; BF16-NEXT:    movq %rdx, %rbx
; BF16-NEXT:    movzwl (%rsi), %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    movzwl (%rdi), %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    movw %ax, (%rbx)
; BF16-NEXT:    popq %rbx
; BF16-NEXT:    retq
  %a = load bfloat, ptr %pa
  %b = load bfloat, ptr %pb
  %add = fadd bfloat %a, %b
  store bfloat %add, ptr %pc
  ret void
}

define bfloat @add2(bfloat %a, bfloat %b) nounwind {
; SSE2-LABEL: add2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movd %xmm1, %ecx
; SSE2-NEXT:    shll $16, %ecx
; SSE2-NEXT:    movd %ecx, %xmm1
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    retq
;
; BF16-LABEL: add2:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rax
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    vmovd %xmm1, %ecx
; BF16-NEXT:    shll $16, %ecx
; BF16-NEXT:    vmovd %ecx, %xmm0
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    popq %rax
; BF16-NEXT:    retq
  %add = fadd bfloat %a, %b
  ret bfloat %add
}

define void @add_double(ptr %pa, ptr %pb, ptr %pc) nounwind {
; SSE2-LABEL: add_double:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rbp
; SSE2-NEXT:    pushq %r14
; SSE2-NEXT:    pushq %rbx
; SSE2-NEXT:    movq %rdx, %rbx
; SSE2-NEXT:    movq %rsi, %r14
; SSE2-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    callq __truncdfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %ebp
; SSE2-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    callq __truncdfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    shll $16, %ebp
; SSE2-NEXT:    movd %ebp, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    cvtss2sd %xmm0, %xmm0
; SSE2-NEXT:    movsd %xmm0, (%rbx)
; SSE2-NEXT:    popq %rbx
; SSE2-NEXT:    popq %r14
; SSE2-NEXT:    popq %rbp
; SSE2-NEXT:    retq
;
; BF16-LABEL: add_double:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rbp
; BF16-NEXT:    pushq %r14
; BF16-NEXT:    pushq %rbx
; BF16-NEXT:    movq %rdx, %rbx
; BF16-NEXT:    movq %rsi, %r14
; BF16-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; BF16-NEXT:    callq __truncdfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %ebp
; BF16-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; BF16-NEXT:    callq __truncdfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    shll $16, %ebp
; BF16-NEXT:    vmovd %ebp, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vcvtss2sd %xmm0, %xmm0, %xmm0
; BF16-NEXT:    vmovsd %xmm0, (%rbx)
; BF16-NEXT:    popq %rbx
; BF16-NEXT:    popq %r14
; BF16-NEXT:    popq %rbp
; BF16-NEXT:    retq
  %la = load double, ptr %pa
  %a = fptrunc double %la to bfloat
  %lb = load double, ptr %pb
  %b = fptrunc double %lb to bfloat
  %add = fadd bfloat %a, %b
  %dadd = fpext bfloat %add to double
  store double %dadd, ptr %pc
  ret void
}

define double @add_double2(double %da, double %db) nounwind {
; SSE2-LABEL: add_double2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rbx
; SSE2-NEXT:    subq $16, %rsp
; SSE2-NEXT:    movsd %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    callq __truncdfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %ebx
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Folded Reload
; SSE2-NEXT:    # xmm0 = mem[0],zero
; SSE2-NEXT:    callq __truncdfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    shll $16, %ebx
; SSE2-NEXT:    movd %ebx, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    cvtss2sd %xmm0, %xmm0
; SSE2-NEXT:    addq $16, %rsp
; SSE2-NEXT:    popq %rbx
; SSE2-NEXT:    retq
;
; BF16-LABEL: add_double2:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rbx
; BF16-NEXT:    subq $16, %rsp
; BF16-NEXT:    vmovsd %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; BF16-NEXT:    callq __truncdfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %ebx
; BF16-NEXT:    vmovq {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Folded Reload
; BF16-NEXT:    # xmm0 = mem[0],zero
; BF16-NEXT:    callq __truncdfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    shll $16, %ebx
; BF16-NEXT:    vmovd %ebx, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vcvtss2sd %xmm0, %xmm0, %xmm0
; BF16-NEXT:    addq $16, %rsp
; BF16-NEXT:    popq %rbx
; BF16-NEXT:    retq
  %a = fptrunc double %da to bfloat
  %b = fptrunc double %db to bfloat
  %add = fadd bfloat %a, %b
  %dadd = fpext bfloat %add to double
  ret double %dadd
}

define void @add_constant(ptr %pa, ptr %pc) nounwind {
; SSE2-LABEL: add_constant:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rbx
; SSE2-NEXT:    movq %rsi, %rbx
; SSE2-NEXT:    movzwl (%rdi), %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movw %ax, (%rbx)
; SSE2-NEXT:    popq %rbx
; SSE2-NEXT:    retq
;
; BF16-LABEL: add_constant:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rbx
; BF16-NEXT:    movq %rsi, %rbx
; BF16-NEXT:    movzwl (%rdi), %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vaddss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    movw %ax, (%rbx)
; BF16-NEXT:    popq %rbx
; BF16-NEXT:    retq
  %a = load bfloat, ptr %pa
  %add = fadd bfloat %a, 1.0
  store bfloat %add, ptr %pc
  ret void
}

define bfloat @add_constant2(bfloat %a) nounwind {
; SSE2-LABEL: add_constant2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    retq
;
; BF16-LABEL: add_constant2:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rax
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vaddss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    popq %rax
; BF16-NEXT:    retq
  %add = fadd bfloat %a, 1.0
  ret bfloat %add
}

define void @store_constant(ptr %pc) nounwind {
; CHECK-LABEL: store_constant:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movw $16256, (%rdi) # imm = 0x3F80
; CHECK-NEXT:    retq
  store bfloat 1.0, ptr %pc
  ret void
}

define void @fold_ext_trunc(ptr %pa, ptr %pc) nounwind {
; CHECK-LABEL: fold_ext_trunc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzwl (%rdi), %eax
; CHECK-NEXT:    movw %ax, (%rsi)
; CHECK-NEXT:    retq
  %a = load bfloat, ptr %pa
  %ext = fpext bfloat %a to float
  %trunc = fptrunc float %ext to bfloat
  store bfloat %trunc, ptr %pc
  ret void
}

define bfloat @fold_ext_trunc2(bfloat %a) nounwind {
; CHECK-LABEL: fold_ext_trunc2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %ext = fpext bfloat %a to float
  %trunc = fptrunc float %ext to bfloat
  ret bfloat %trunc
}

define <8 x bfloat> @addv(<8 x bfloat> %a, <8 x bfloat> %b) nounwind {
; SSE2-LABEL: addv:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rbp
; SSE2-NEXT:    pushq %r15
; SSE2-NEXT:    pushq %r14
; SSE2-NEXT:    pushq %r13
; SSE2-NEXT:    pushq %r12
; SSE2-NEXT:    pushq %rbx
; SSE2-NEXT:    subq $56, %rsp
; SSE2-NEXT:    movq %xmm0, %rcx
; SSE2-NEXT:    movq %rcx, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    movq %rcx, %rax
; SSE2-NEXT:    shrq $32, %rax
; SSE2-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    movq %xmm1, %rdx
; SSE2-NEXT:    movq %rdx, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    movq %rdx, %rax
; SSE2-NEXT:    shrq $32, %rax
; SSE2-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    movq %rcx, %rax
; SSE2-NEXT:    shrq $48, %rax
; SSE2-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    movq %rdx, %rax
; SSE2-NEXT:    shrq $48, %rax
; SSE2-NEXT:    movq %rax, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %r12
; SSE2-NEXT:    movq %r12, %rax
; SSE2-NEXT:    shrq $32, %rax
; SSE2-NEXT:    movq %rax, (%rsp) # 8-byte Spill
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %r14
; SSE2-NEXT:    movq %r14, %rbp
; SSE2-NEXT:    shrq $32, %rbp
; SSE2-NEXT:    movq %r12, %r15
; SSE2-NEXT:    shrq $48, %r15
; SSE2-NEXT:    movq %r14, %r13
; SSE2-NEXT:    shrq $48, %r13
; SSE2-NEXT:    movl %r14d, %eax
; SSE2-NEXT:    andl $-65536, %eax # imm = 0xFFFF0000
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movl %r12d, %eax
; SSE2-NEXT:    andl $-65536, %eax # imm = 0xFFFF0000
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %ebx
; SSE2-NEXT:    shll $16, %ebx
; SSE2-NEXT:    shll $16, %r14d
; SSE2-NEXT:    movd %r14d, %xmm1
; SSE2-NEXT:    shll $16, %r12d
; SSE2-NEXT:    movd %r12d, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movzwl %ax, %r12d
; SSE2-NEXT:    orl %ebx, %r12d
; SSE2-NEXT:    shll $16, %r13d
; SSE2-NEXT:    movd %r13d, %xmm1
; SSE2-NEXT:    shll $16, %r15d
; SSE2-NEXT:    movd %r15d, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %r14d
; SSE2-NEXT:    shll $16, %r14d
; SSE2-NEXT:    shll $16, %ebp
; SSE2-NEXT:    movd %ebp, %xmm1
; SSE2-NEXT:    movq (%rsp), %rax # 8-byte Reload
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movzwl %ax, %ebx
; SSE2-NEXT:    orl %r14d, %ebx
; SSE2-NEXT:    shlq $32, %rbx
; SSE2-NEXT:    orq %r12, %rbx
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r15 # 8-byte Reload
; SSE2-NEXT:    movl %r15d, %eax
; SSE2-NEXT:    andl $-65536, %eax # imm = 0xFFFF0000
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %r14 # 8-byte Reload
; SSE2-NEXT:    movl %r14d, %eax
; SSE2-NEXT:    andl $-65536, %eax # imm = 0xFFFF0000
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %ebp
; SSE2-NEXT:    shll $16, %ebp
; SSE2-NEXT:    movq %r15, %rax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movq %r14, %rax
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movzwl %ax, %r14d
; SSE2-NEXT:    orl %ebp, %r14d
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %ebp
; SSE2-NEXT:    shll $16, %ebp
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm1
; SSE2-NEXT:    movq {{[-0-9]+}}(%r{{[sb]}}p), %rax # 8-byte Reload
; SSE2-NEXT:    shll $16, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    callq __truncsfbf2@PLT
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movzwl %ax, %eax
; SSE2-NEXT:    orl %ebp, %eax
; SSE2-NEXT:    shlq $32, %rax
; SSE2-NEXT:    orq %r14, %rax
; SSE2-NEXT:    movq %rax, %xmm0
; SSE2-NEXT:    movq %rbx, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    addq $56, %rsp
; SSE2-NEXT:    popq %rbx
; SSE2-NEXT:    popq %r12
; SSE2-NEXT:    popq %r13
; SSE2-NEXT:    popq %r14
; SSE2-NEXT:    popq %r15
; SSE2-NEXT:    popq %rbp
; SSE2-NEXT:    retq
;
; BF16-LABEL: addv:
; BF16:       # %bb.0:
; BF16-NEXT:    pushq %rbp
; BF16-NEXT:    pushq %r15
; BF16-NEXT:    pushq %r14
; BF16-NEXT:    pushq %r13
; BF16-NEXT:    pushq %r12
; BF16-NEXT:    pushq %rbx
; BF16-NEXT:    subq $40, %rsp
; BF16-NEXT:    vmovdqa %xmm1, (%rsp) # 16-byte Spill
; BF16-NEXT:    vmovdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; BF16-NEXT:    vpextrw $7, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm2
; BF16-NEXT:    vpextrw $7, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm2, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovss %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $6, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $6, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %ebp
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $5, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $5, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %r14d
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $4, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $4, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %r15d
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $3, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $3, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %r12d
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $2, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $2, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %r13d
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vpextrw $1, %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vpextrw $1, %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %ebx
; BF16-NEXT:    vmovdqa (%rsp), %xmm0 # 16-byte Reload
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vmovdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; BF16-NEXT:    vmovd %xmm1, %eax
; BF16-NEXT:    shll $16, %eax
; BF16-NEXT:    vmovd %eax, %xmm1
; BF16-NEXT:    vaddss %xmm0, %xmm1, %xmm0
; BF16-NEXT:    callq __truncsfbf2@PLT
; BF16-NEXT:    vmovd %xmm0, %eax
; BF16-NEXT:    vmovd %eax, %xmm0
; BF16-NEXT:    vpinsrw $1, %ebx, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $2, %r13d, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $3, %r12d, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $4, %r15d, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $5, %r14d, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $6, %ebp, %xmm0, %xmm0
; BF16-NEXT:    vpinsrw $7, {{[-0-9]+}}(%r{{[sb]}}p), %xmm0, %xmm0 # 4-byte Folded Reload
; BF16-NEXT:    addq $40, %rsp
; BF16-NEXT:    popq %rbx
; BF16-NEXT:    popq %r12
; BF16-NEXT:    popq %r13
; BF16-NEXT:    popq %r14
; BF16-NEXT:    popq %r15
; BF16-NEXT:    popq %rbp
; BF16-NEXT:    retq
  %add = fadd <8 x bfloat> %a, %b
  ret <8 x bfloat> %add
}
