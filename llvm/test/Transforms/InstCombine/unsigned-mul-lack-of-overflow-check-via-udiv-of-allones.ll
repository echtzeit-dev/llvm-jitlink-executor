; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Fold
;   (-1 u/ %x) u>= %y
; to
;   @llvm.umul.with.overflow(%x, %y) + extractvalue + not

define i1 @t0_basic(i8 %x, i8 %y) {
; CHECK-LABEL: @t0_basic(
; CHECK-NEXT:    [[UMUL:%.*]] = call { i8, i1 } @llvm.umul.with.overflow.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    [[UMUL_OV:%.*]] = extractvalue { i8, i1 } [[UMUL]], 1
; CHECK-NEXT:    [[UMUL_NOT_OV:%.*]] = xor i1 [[UMUL_OV]], true
; CHECK-NEXT:    ret i1 [[UMUL_NOT_OV]]
;
  %t0 = udiv i8 -1, %x
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

define <2 x i1> @t1_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @t1_vec(
; CHECK-NEXT:    [[UMUL:%.*]] = call { <2 x i8>, <2 x i1> } @llvm.umul.with.overflow.v2i8(<2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]])
; CHECK-NEXT:    [[UMUL_OV:%.*]] = extractvalue { <2 x i8>, <2 x i1> } [[UMUL]], 1
; CHECK-NEXT:    [[UMUL_NOT_OV:%.*]] = xor <2 x i1> [[UMUL_OV]], <i1 true, i1 true>
; CHECK-NEXT:    ret <2 x i1> [[UMUL_NOT_OV]]
;
  %t0 = udiv <2 x i8> <i8 -1, i8 -1>, %x
  %r = icmp uge <2 x i8> %t0, %y
  ret <2 x i1> %r
}

define <3 x i1> @t2_vec_undef(<3 x i8> %x, <3 x i8> %y) {
; CHECK-LABEL: @t2_vec_undef(
; CHECK-NEXT:    [[UMUL:%.*]] = call { <3 x i8>, <3 x i1> } @llvm.umul.with.overflow.v3i8(<3 x i8> [[X:%.*]], <3 x i8> [[Y:%.*]])
; CHECK-NEXT:    [[UMUL_OV:%.*]] = extractvalue { <3 x i8>, <3 x i1> } [[UMUL]], 1
; CHECK-NEXT:    [[UMUL_NOT_OV:%.*]] = xor <3 x i1> [[UMUL_OV]], <i1 true, i1 true, i1 true>
; CHECK-NEXT:    ret <3 x i1> [[UMUL_NOT_OV]]
;
  %t0 = udiv <3 x i8> <i8 -1, i8 undef, i8 -1>, %x
  %r = icmp uge <3 x i8> %t0, %y
  ret <3 x i1> %r
}

declare i8 @gen8()

define i1 @t3_commutative(i8 %x) {
; CHECK-LABEL: @t3_commutative(
; CHECK-NEXT:    [[Y:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[UMUL:%.*]] = call { i8, i1 } @llvm.umul.with.overflow.i8(i8 [[X:%.*]], i8 [[Y]])
; CHECK-NEXT:    [[UMUL_OV:%.*]] = extractvalue { i8, i1 } [[UMUL]], 1
; CHECK-NEXT:    [[UMUL_NOT_OV:%.*]] = xor i1 [[UMUL_OV]], true
; CHECK-NEXT:    ret i1 [[UMUL_NOT_OV]]
;
  %t0 = udiv i8 -1, %x
  %y = call i8 @gen8()
  %r = icmp ule i8 %y, %t0 ; swapped
  ret i1 %r
}

; Negative tests

declare void @use8(i8)

define i1 @n4_extrause(i8 %x, i8 %y) {
; CHECK-LABEL: @n4_extrause(
; CHECK-NEXT:    [[T0:%.*]] = udiv i8 -1, [[X:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[T0]])
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[T0]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = udiv i8 -1, %x
  call void @use8(i8 %t0)
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

define i1 @n5_not_negone(i8 %x, i8 %y) {
; CHECK-LABEL: @n5_not_negone(
; CHECK-NEXT:    [[T0:%.*]] = udiv i8 -2, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[T0]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = udiv i8 -2, %x ; not -1
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

define i1 @n6_wrong_pred0(i8 %x, i8 %y) {
; CHECK-LABEL: @n6_wrong_pred0(
; CHECK-NEXT:    [[T0:%.*]] = udiv i8 -1, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[T0]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = udiv i8 -1, %x
  %r = icmp ule i8 %t0, %y ; not uge
  ret i1 %r
}

define i1 @n6_wrong_pred1(i8 %x, i8 %y) {
; CHECK-LABEL: @n6_wrong_pred1(
; CHECK-NEXT:    [[T0:%.*]] = udiv i8 -1, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[T0]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = udiv i8 -1, %x
  %r = icmp ugt i8 %t0, %y ; not uge
  ret i1 %r
}
