; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE2,X64,X64-SSE2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX2,X64,X64-AVX2
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE2,X86,X86-SSE2
; RUN: llc < %s -mtriple=i686-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX2,X86,X86-AVX2

;------------------------------ 32-bit shuffles -------------------------------;

define <4 x i32> @shuffle_i32_of_shl_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_shl_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psllw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_shl_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsllw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}
define <4 x i32> @shuffle_i32_of_lshr_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_lshr_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_lshr_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}
define <4 x i32> @shuffle_i32_of_ashr_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_ashr_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psraw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_ashr_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}

define <4 x i32> @shuffle_i32_of_shl_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_shl_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pslld $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_shl_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> %x, i32 31)
  %i2 = shufflevector <4 x i32> %i1, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i2
}
define <4 x i32> @shuffle_i32_of_lshr_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_lshr_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_lshr_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrld $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> %x, i32 31)
  %i2 = shufflevector <4 x i32> %i1, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i2
}
define <4 x i32> @shuffle_i32_of_ashr_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_ashr_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrad $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_ashr_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrad $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32> %x, i32 31)
  %i2 = shufflevector <4 x i32> %i1, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i2
}

define <4 x i32> @shuffle_i32_of_shl_i64(<2 x i64> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_shl_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psllq $63, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_shl_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsllq $63, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}
define <4 x i32> @shuffle_i32_of_lshr_i64(<2 x i64> %x) nounwind {
; SSE2-LABEL: shuffle_i32_of_lshr_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlq $63, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i32_of_lshr_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrlq $63, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}
define <4 x i32> @shuffle_i32_of_ashr_i64(<2 x i64> %x) nounwind {
; X64-SSE2-LABEL: shuffle_i32_of_ashr_i64:
; X64-SSE2:       # %bb.0:
; X64-SSE2-NEXT:    pushq %rax
; X64-SSE2-NEXT:    movl $63, %edi
; X64-SSE2-NEXT:    callq llvm.x86.sse2.psrai.q@PLT
; X64-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; X64-SSE2-NEXT:    popq %rax
; X64-SSE2-NEXT:    retq
;
; X64-AVX2-LABEL: shuffle_i32_of_ashr_i64:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    pushq %rax
; X64-AVX2-NEXT:    movl $63, %edi
; X64-AVX2-NEXT:    callq llvm.x86.sse2.psrai.q@PLT
; X64-AVX2-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[3,2,1,0]
; X64-AVX2-NEXT:    popq %rax
; X64-AVX2-NEXT:    retq
;
; X86-SSE2-LABEL: shuffle_i32_of_ashr_i64:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl $63
; X86-SSE2-NEXT:    calll llvm.x86.sse2.psrai.q@PLT
; X86-SSE2-NEXT:    addl $4, %esp
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,2,1,0]
; X86-SSE2-NEXT:    retl
;
; X86-AVX2-LABEL: shuffle_i32_of_ashr_i64:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    pushl $63
; X86-AVX2-NEXT:    calll llvm.x86.sse2.psrai.q@PLT
; X86-AVX2-NEXT:    addl $4, %esp
; X86-AVX2-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[3,2,1,0]
; X86-AVX2-NEXT:    retl
  %i1 = tail call <2 x i64> @llvm.x86.sse2.psrai.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <4 x i32>
  %i3 = shufflevector <4 x i32> %i2, <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %i3
}

;------------------------------ 64-bit shuffles -------------------------------;

define <2 x i64> @shuffle_i64_of_shl_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_shl_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psllw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_shl_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsllw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_lshr_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_lshr_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_lshr_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_ashr_i16(<8 x i16> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_ashr_i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psraw $15, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_ashr_i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16> %x, i32 15)
  %i2 = bitcast <8 x i16> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}

define <2 x i64> @shuffle_i64_of_shl_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_shl_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pslld $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_shl_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> %x, i32 31)
  %i2 = bitcast <4 x i32> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_lshr_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_lshr_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_lshr_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrld $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> %x, i32 31)
  %i2 = bitcast <4 x i32> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_ashr_i32(<4 x i32> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_ashr_i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrad $31, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_ashr_i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrad $31, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32> %x, i32 31)
  %i2 = bitcast <4 x i32> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}

define <2 x i64> @shuffle_i64_of_shl_i64(<2 x i64> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_shl_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psllq $63, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_shl_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsllq $63, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_lshr_i64(<2 x i64> %x) nounwind {
; SSE2-LABEL: shuffle_i64_of_lshr_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrlq $63, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    ret{{[l|q]}}
;
; AVX2-LABEL: shuffle_i64_of_lshr_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrlq $63, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    ret{{[l|q]}}
  %i1 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}
define <2 x i64> @shuffle_i64_of_ashr_i64(<2 x i64> %x) nounwind {
; X64-SSE2-LABEL: shuffle_i64_of_ashr_i64:
; X64-SSE2:       # %bb.0:
; X64-SSE2-NEXT:    pushq %rax
; X64-SSE2-NEXT:    movl $63, %edi
; X64-SSE2-NEXT:    callq llvm.x86.sse2.psrai.q@PLT
; X64-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; X64-SSE2-NEXT:    popq %rax
; X64-SSE2-NEXT:    retq
;
; X64-AVX2-LABEL: shuffle_i64_of_ashr_i64:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    pushq %rax
; X64-AVX2-NEXT:    movl $63, %edi
; X64-AVX2-NEXT:    callq llvm.x86.sse2.psrai.q@PLT
; X64-AVX2-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[2,3,0,1]
; X64-AVX2-NEXT:    popq %rax
; X64-AVX2-NEXT:    retq
;
; X86-SSE2-LABEL: shuffle_i64_of_ashr_i64:
; X86-SSE2:       # %bb.0:
; X86-SSE2-NEXT:    pushl $63
; X86-SSE2-NEXT:    calll llvm.x86.sse2.psrai.q@PLT
; X86-SSE2-NEXT:    addl $4, %esp
; X86-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; X86-SSE2-NEXT:    retl
;
; X86-AVX2-LABEL: shuffle_i64_of_ashr_i64:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    pushl $63
; X86-AVX2-NEXT:    calll llvm.x86.sse2.psrai.q@PLT
; X86-AVX2-NEXT:    addl $4, %esp
; X86-AVX2-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[2,3,0,1]
; X86-AVX2-NEXT:    retl
  %i1 = tail call <2 x i64> @llvm.x86.sse2.psrai.q(<2 x i64> %x, i32 63)
  %i2 = bitcast <2 x i64> %i1 to <2 x i64>
  %i3 = shufflevector <2 x i64> %i2, <2 x i64> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %i3
}

declare <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16>, i32)
declare <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16>, i32)
declare <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16>, i32)
declare <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32>, i32)
declare <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32>, i32)
declare <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32>, i32)
declare <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64>, i32)
declare <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64>, i32)
declare <2 x i64> @llvm.x86.sse2.psrai.q(<2 x i64>, i32) ; does not exist
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
; X64: {{.*}}
; X86: {{.*}}
