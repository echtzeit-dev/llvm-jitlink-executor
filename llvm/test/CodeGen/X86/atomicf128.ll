; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-macosx10.9 -verify-machineinstrs -mattr=cx16 | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-apple-macosx10.9 -verify-machineinstrs -mattr=cx16 -mattr=-sse | FileCheck %s --check-prefix=NOSSE

; FIXME: This test has a fatal error in 32-bit mode

@fsc128 = external global fp128

define void @atomic_fetch_swapf128(fp128 %x) nounwind {
; CHECK-LABEL: atomic_fetch_swapf128:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rbx
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; CHECK-NEXT:    movq _fsc128@GOTPCREL(%rip), %rsi
; CHECK-NEXT:    movq (%rsi), %rax
; CHECK-NEXT:    movq 8(%rsi), %rdx
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  LBB0_1: ## %atomicrmw.start
; CHECK-NEXT:    ## =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    lock cmpxchg16b (%rsi)
; CHECK-NEXT:    jne LBB0_1
; CHECK-NEXT:  ## %bb.2: ## %atomicrmw.end
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    retq
;
; NOSSE-LABEL: atomic_fetch_swapf128:
; NOSSE:       ## %bb.0:
; NOSSE-NEXT:    pushq %rbx
; NOSSE-NEXT:    movq %rsi, %rcx
; NOSSE-NEXT:    movq %rdi, %rbx
; NOSSE-NEXT:    movq _fsc128@GOTPCREL(%rip), %rsi
; NOSSE-NEXT:    movq (%rsi), %rax
; NOSSE-NEXT:    movq 8(%rsi), %rdx
; NOSSE-NEXT:    .p2align 4, 0x90
; NOSSE-NEXT:  LBB0_1: ## %atomicrmw.start
; NOSSE-NEXT:    ## =>This Inner Loop Header: Depth=1
; NOSSE-NEXT:    lock cmpxchg16b (%rsi)
; NOSSE-NEXT:    jne LBB0_1
; NOSSE-NEXT:  ## %bb.2: ## %atomicrmw.end
; NOSSE-NEXT:    popq %rbx
; NOSSE-NEXT:    retq
  %t1 = atomicrmw xchg ptr @fsc128, fp128 %x acquire
  ret void
}
