; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -S -passes=globalopt -o - < %s | FileCheck %s

; No malloc promotion with non-null check.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@_ZL3g_i = internal global ptr null, align 8
@_ZL3g_j = global ptr null, align 8
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"1\00", align 1

define dso_local i32 @main() {
; CHECK-LABEL: define {{[^@]+}}@main() local_unnamed_addr {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    store ptr null, ptr @_ZL3g_i, align 8
; CHECK-NEXT:    call fastcc void @_ZL13PutsSomethingv()
; CHECK-NEXT:    ret i32 0
;
bb:
  store ptr null, ptr @_ZL3g_i, align 8
  call void @_ZL13PutsSomethingv()
  ret i32 0
}

define internal void @_ZL13PutsSomethingv() {
; CHECK-LABEL: define {{[^@]+}}@_ZL13PutsSomethingv() unnamed_addr {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load ptr, ptr @_ZL3g_i, align 8
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr @_ZL3g_j, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[I]], [[I1]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB2:%.*]], label [[BB6:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[I3:%.*]] = call noalias ptr @malloc(i64 4)
; CHECK-NEXT:    store ptr [[I3]], ptr @_ZL3g_i, align 8
; CHECK-NEXT:    [[I5:%.*]] = call i32 @puts(ptr @.str)
; CHECK-NEXT:    br label [[BB8:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    [[I7:%.*]] = call i32 @puts(ptr @.str.1)
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb8:
; CHECK-NEXT:    ret void
;
bb:
  %i = load ptr, ptr @_ZL3g_i, align 8
  %i1 = load ptr, ptr @_ZL3g_j, align 8
  %cmp = icmp eq ptr %i, %i1
  br i1 %cmp, label %bb2, label %bb6

bb2:                                              ; preds = %bb
  %i3 = call noalias ptr @malloc(i64 4)
  store ptr %i3, ptr @_ZL3g_i, align 8
  %i5 = call i32 @puts(ptr @.str)
  br label %bb8

bb6:                                              ; preds = %bb
  %i7 = call i32 @puts(ptr @.str.1)
  br label %bb8

bb8:                                              ; preds = %bb6, %bb2
  ret void
}

declare dso_local noalias ptr @malloc(i64)

declare dso_local i32 @puts(ptr nocapture readonly)
