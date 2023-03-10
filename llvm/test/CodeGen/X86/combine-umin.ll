; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=CHECK,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefixes=CHECK,SSE42
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefixes=CHECK,AVX

define i8 @test_demandedbits_umin_ult(i8 %a0, i8 %a1) {
; CHECK-LABEL: test_demandedbits_umin_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    orb $4, %al
; CHECK-NEXT:    andb $12, %al
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %lhs0 = and i8 %a0, 13  ; b1101
  %rhs0 = and i8 %a1, 12  ; b1100
  %lhs1 = or i8 %lhs0, 12 ; b1100
  %rhs1 = or i8 %rhs0, 4  ; b0100
  %umin = tail call i8 @llvm.umin.i8(i8 %lhs1, i8 %rhs1)
  ret i8 %umin
}
declare i8 @llvm.umin.i8(i8, i8)

define <8 x i16> @test_v8i16_nosignbit(<8 x i16> %a, <8 x i16> %b) {
; SSE2-LABEL: test_v8i16_nosignbit:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    psrlw $1, %xmm1
; SSE2-NEXT:    pmaxsw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v8i16_nosignbit:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    psrlw $1, %xmm1
; SSE41-NEXT:    pmaxuw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: test_v8i16_nosignbit:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE42-NEXT:    psrlw $1, %xmm1
; SSE42-NEXT:    pmaxuw %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: test_v8i16_nosignbit:
; AVX:       # %bb.0:
; AVX-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsrlw $1, %xmm1, %xmm1
; AVX-NEXT:    vpmaxuw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = and <8 x i16> %a, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %2 = lshr <8 x i16> %b, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %3 = icmp ugt <8 x i16> %1, %2
  %4 = select <8 x i1> %3, <8 x i16> %1, <8 x i16> %2
  ret <8 x i16> %4
}

define <16 x i8> @test_v16i8_reassociation(<16 x i8> %a) {
; SSE2-LABEL: test_v16i8_reassociation:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; SSE2-NEXT:    pminub %xmm1, %xmm0
; SSE2-NEXT:    pminub %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v16i8_reassociation:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; SSE41-NEXT:    pminub %xmm1, %xmm0
; SSE41-NEXT:    pminub %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; SSE42-LABEL: test_v16i8_reassociation:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa {{.*#+}} xmm1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; SSE42-NEXT:    pminub %xmm1, %xmm0
; SSE42-NEXT:    pminub %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: test_v16i8_reassociation:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; AVX-NEXT:    vpminub %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpminub %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> %a, <16 x i8> <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>)
  %2 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> %1, <16 x i8> <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>)
  ret <16 x i8> %2
}
declare <16 x i8> @llvm.umin.v16i8(<16 x i8> %x, <16 x i8> %y)
