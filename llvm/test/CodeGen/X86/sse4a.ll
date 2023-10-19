; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown-unknown -mattr=+sse4a -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86-SSE
; RUN: llc < %s -mtriple=i386-unknown-unknown -mattr=+sse4a,+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86-AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4a -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4a,+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64-AVX

define <2 x i64> @test_extrqi(<2 x i64> %x) nounwind uwtable ssp {
; CHECK-LABEL: test_extrqi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    extrq $2, $3, %xmm0 # encoding: [0x66,0x0f,0x78,0xc0,0x03,0x02]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %x, i8 3, i8 2)
  ret <2 x i64> %1
}

define <2 x i64> @test_extrqi_domain(ptr%p) nounwind uwtable ssp {
; X86-SSE-LABEL: test_extrqi_domain:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movdqa (%eax), %xmm0 # encoding: [0x66,0x0f,0x6f,0x00]
; X86-SSE-NEXT:    extrq $2, $3, %xmm0 # encoding: [0x66,0x0f,0x78,0xc0,0x03,0x02]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: test_extrqi_domain:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovdqa (%eax), %xmm0 # encoding: [0xc5,0xf9,0x6f,0x00]
; X86-AVX-NEXT:    extrq $2, $3, %xmm0 # encoding: [0x66,0x0f,0x78,0xc0,0x03,0x02]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: test_extrqi_domain:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movdqa (%rdi), %xmm0 # encoding: [0x66,0x0f,0x6f,0x07]
; X64-SSE-NEXT:    extrq $2, $3, %xmm0 # encoding: [0x66,0x0f,0x78,0xc0,0x03,0x02]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: test_extrqi_domain:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovdqa (%rdi), %xmm0 # encoding: [0xc5,0xf9,0x6f,0x07]
; X64-AVX-NEXT:    extrq $2, $3, %xmm0 # encoding: [0x66,0x0f,0x78,0xc0,0x03,0x02]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
  %1 = load <2 x i64>, ptr%p
  %2 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %1, i8 3, i8 2)
  ret <2 x i64> %2
}

declare <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64>, i8, i8) nounwind

define <2 x i64> @test_extrq(<2 x i64> %x, <2 x i64> %y) nounwind uwtable ssp {
; CHECK-LABEL: test_extrq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    extrq %xmm1, %xmm0 # encoding: [0x66,0x0f,0x79,0xc1]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = bitcast <2 x i64> %y to <16 x i8>
  %2 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %x, <16 x i8> %1) nounwind
  ret <2 x i64> %2
}

define <2 x i64> @test_extrq_domain(ptr%p, <2 x i64> %y) nounwind uwtable ssp {
; X86-SSE-LABEL: test_extrq_domain:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movdqa (%eax), %xmm1 # encoding: [0x66,0x0f,0x6f,0x08]
; X86-SSE-NEXT:    extrq %xmm0, %xmm1 # encoding: [0x66,0x0f,0x79,0xc8]
; X86-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: test_extrq_domain:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovdqa (%eax), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x08]
; X86-AVX-NEXT:    extrq %xmm0, %xmm1 # encoding: [0x66,0x0f,0x79,0xc8]
; X86-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: test_extrq_domain:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movdqa (%rdi), %xmm1 # encoding: [0x66,0x0f,0x6f,0x0f]
; X64-SSE-NEXT:    extrq %xmm0, %xmm1 # encoding: [0x66,0x0f,0x79,0xc8]
; X64-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: test_extrq_domain:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovdqa (%rdi), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x0f]
; X64-AVX-NEXT:    extrq %xmm0, %xmm1 # encoding: [0x66,0x0f,0x79,0xc8]
; X64-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
  %1 = load <2 x i64>, ptr%p
  %2 = bitcast <2 x i64> %y to <16 x i8>
  %3 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %1, <16 x i8> %2) nounwind
  ret <2 x i64> %3
}

declare <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64>, <16 x i8>) nounwind

define <2 x i64> @test_insertqi(<2 x i64> %x, <2 x i64> %y) nounwind uwtable ssp {
; CHECK-LABEL: test_insertqi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    insertq $6, $5, %xmm1, %xmm0 # encoding: [0xf2,0x0f,0x78,0xc1,0x05,0x06]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %x, <2 x i64> %y, i8 5, i8 6)
  ret <2 x i64> %1
}

define <2 x i64> @test_insertqi_domain(ptr%p, <2 x i64> %y) nounwind uwtable ssp {
; X86-SSE-LABEL: test_insertqi_domain:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movdqa (%eax), %xmm1 # encoding: [0x66,0x0f,0x6f,0x08]
; X86-SSE-NEXT:    insertq $6, $5, %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x78,0xc8,0x05,0x06]
; X86-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: test_insertqi_domain:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovdqa (%eax), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x08]
; X86-AVX-NEXT:    insertq $6, $5, %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x78,0xc8,0x05,0x06]
; X86-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: test_insertqi_domain:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movdqa (%rdi), %xmm1 # encoding: [0x66,0x0f,0x6f,0x0f]
; X64-SSE-NEXT:    insertq $6, $5, %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x78,0xc8,0x05,0x06]
; X64-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: test_insertqi_domain:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovdqa (%rdi), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x0f]
; X64-AVX-NEXT:    insertq $6, $5, %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x78,0xc8,0x05,0x06]
; X64-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
  %1 = load <2 x i64>, ptr%p
  %2 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %1, <2 x i64> %y, i8 5, i8 6)
  ret <2 x i64> %2
}

declare <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64>, <2 x i64>, i8, i8) nounwind

define <2 x i64> @test_insertq(<2 x i64> %x, <2 x i64> %y) nounwind uwtable ssp {
; CHECK-LABEL: test_insertq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    insertq %xmm1, %xmm0 # encoding: [0xf2,0x0f,0x79,0xc1]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %x, <2 x i64> %y) nounwind
  ret <2 x i64> %1
}

define <2 x i64> @test_insertq_domain(ptr%p, <2 x i64> %y) nounwind uwtable ssp {
; X86-SSE-LABEL: test_insertq_domain:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movdqa (%eax), %xmm1 # encoding: [0x66,0x0f,0x6f,0x08]
; X86-SSE-NEXT:    insertq %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x79,0xc8]
; X86-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: test_insertq_domain:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovdqa (%eax), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x08]
; X86-AVX-NEXT:    insertq %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x79,0xc8]
; X86-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: test_insertq_domain:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movdqa (%rdi), %xmm1 # encoding: [0x66,0x0f,0x6f,0x0f]
; X64-SSE-NEXT:    insertq %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x79,0xc8]
; X64-SSE-NEXT:    movdqa %xmm1, %xmm0 # encoding: [0x66,0x0f,0x6f,0xc1]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: test_insertq_domain:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovdqa (%rdi), %xmm1 # encoding: [0xc5,0xf9,0x6f,0x0f]
; X64-AVX-NEXT:    insertq %xmm0, %xmm1 # encoding: [0xf2,0x0f,0x79,0xc8]
; X64-AVX-NEXT:    vmovdqa %xmm1, %xmm0 # encoding: [0xc5,0xf9,0x6f,0xc1]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
  %1 = load <2 x i64>, ptr%p
  %2 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %1, <2 x i64> %y) nounwind
  ret <2 x i64> %2
}

declare <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64>, <2 x i64>) nounwind
