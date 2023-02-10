; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --filter "LV: Found an estimated cost of [0-9]+ for VF [0-9]+ For instruction:\s*%valB = load i16, ptr %inB, align 2"
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=SSE
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse4.2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=SSE
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx  --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX1
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2,-fast-gather --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX2-SLOWGATHER
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2,+fast-gather --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX2-FASTGATHER
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512bw --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX512

; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = global [1024 x i8] zeroinitializer, align 128
@B = global [1024 x i16] zeroinitializer, align 128
@C = global [1024 x i16] zeroinitializer, align 128

define void @test() {
; SSE-LABEL: 'test'
; SSE:  LV: Found an estimated cost of 1 for VF 1 For instruction: %valB = load i16, ptr %inB, align 2
; SSE:  LV: Found an estimated cost of 24 for VF 2 For instruction: %valB = load i16, ptr %inB, align 2
; SSE:  LV: Found an estimated cost of 48 for VF 4 For instruction: %valB = load i16, ptr %inB, align 2
; SSE:  LV: Found an estimated cost of 96 for VF 8 For instruction: %valB = load i16, ptr %inB, align 2
; SSE:  LV: Found an estimated cost of 192 for VF 16 For instruction: %valB = load i16, ptr %inB, align 2
;
; AVX1-LABEL: 'test'
; AVX1:  LV: Found an estimated cost of 1 for VF 1 For instruction: %valB = load i16, ptr %inB, align 2
; AVX1:  LV: Found an estimated cost of 24 for VF 2 For instruction: %valB = load i16, ptr %inB, align 2
; AVX1:  LV: Found an estimated cost of 48 for VF 4 For instruction: %valB = load i16, ptr %inB, align 2
; AVX1:  LV: Found an estimated cost of 96 for VF 8 For instruction: %valB = load i16, ptr %inB, align 2
; AVX1:  LV: Found an estimated cost of 193 for VF 16 For instruction: %valB = load i16, ptr %inB, align 2
; AVX1:  LV: Found an estimated cost of 386 for VF 32 For instruction: %valB = load i16, ptr %inB, align 2
;
; AVX2-SLOWGATHER-LABEL: 'test'
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 1 for VF 1 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 4 for VF 2 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 8 for VF 4 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 16 for VF 8 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 33 for VF 16 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-SLOWGATHER:  LV: Found an estimated cost of 66 for VF 32 For instruction: %valB = load i16, ptr %inB, align 2
;
; AVX2-FASTGATHER-LABEL: 'test'
; AVX2-FASTGATHER:  LV: Found an estimated cost of 1 for VF 1 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-FASTGATHER:  LV: Found an estimated cost of 6 for VF 2 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-FASTGATHER:  LV: Found an estimated cost of 13 for VF 4 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-FASTGATHER:  LV: Found an estimated cost of 26 for VF 8 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-FASTGATHER:  LV: Found an estimated cost of 53 for VF 16 For instruction: %valB = load i16, ptr %inB, align 2
; AVX2-FASTGATHER:  LV: Found an estimated cost of 106 for VF 32 For instruction: %valB = load i16, ptr %inB, align 2
;
; AVX512-LABEL: 'test'
; AVX512:  LV: Found an estimated cost of 1 for VF 1 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 6 for VF 2 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 13 for VF 4 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 27 for VF 8 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 55 for VF 16 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 111 for VF 32 For instruction: %valB = load i16, ptr %inB, align 2
; AVX512:  LV: Found an estimated cost of 222 for VF 64 For instruction: %valB = load i16, ptr %inB, align 2
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]

  %inA = getelementptr inbounds [1024 x i8], ptr @A, i64 0, i64 %iv
  %valA = load i8, ptr %inA
  %valA.ext = sext i8 %valA to i64

  %inB = getelementptr inbounds [1024 x i16], ptr @B, i64 0, i64 %valA.ext
  %valB = load i16, ptr %inB

  %out = getelementptr inbounds [1024 x i16], ptr @C, i64 0, i64 %iv
  store i16 %valB, ptr %out

  %iv.next = add nuw nsw i64 %iv, 1
  %cmp = icmp ult i64 %iv.next, 1024
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void
}
