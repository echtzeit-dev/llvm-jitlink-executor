; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=avx512f | FileCheck %s

define i64 @test1() nounwind {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    vmovq {{.*#+}} xmm16 = mem[0],zero
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vmovq %xmm16, %rax
; CHECK-NEXT:    retq
entry:
  %0 = tail call i64 asm sideeffect "vmovq $1, $0", "={xmm16},*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) null) nounwind
  ret i64 %0
}
