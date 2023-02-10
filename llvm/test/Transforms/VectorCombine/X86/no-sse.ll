; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=-sse | FileCheck %s

; Don't spend time on vector transforms if the target does not support vectors.

define <4 x float> @bitcast_shuf_same_size(<4 x i32> %v) {
; CHECK-LABEL: @bitcast_shuf_same_size(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i32> [[V:%.*]], <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[R:%.*]] = bitcast <4 x i32> [[SHUF]] to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %shuf = shufflevector <4 x i32> %v, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %r = bitcast <4 x i32> %shuf to <4 x float>
  ret <4 x float> %r
}
