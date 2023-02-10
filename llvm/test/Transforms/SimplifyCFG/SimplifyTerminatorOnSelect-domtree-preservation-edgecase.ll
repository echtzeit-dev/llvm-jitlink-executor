; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

declare void @widget()
declare void @baz(i8)
declare void @snork()
declare void @spam(i8)
declare void @zot()

define void @wombat(i64 %arg, i1 %arg1) {
; CHECK-LABEL: @wombat(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i64 [[ARG:%.*]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[BB4:%.*]], label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @widget()
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb4:
; CHECK-NEXT:    [[TMP:%.*]] = phi i8 [ 0, [[BB:%.*]] ], [ 1, [[BB2]] ]
; CHECK-NEXT:    call void @baz(i8 [[TMP]])
; CHECK-NEXT:    call void @snork()
; CHECK-NEXT:    call void @spam(i8 4)
; CHECK-NEXT:    ret void
;
bb:
  switch i64 %arg, label %bb2 [
  i64 0, label %bb3
  ]

bb2:                                              ; preds = %bb
  call void @widget()
  br label %bb3

bb3:                                              ; preds = %bb2, %bb
  %tmp = phi i8 [ 0, %bb ], [ 1, %bb2 ]
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @baz(i8 %tmp)
  %tmp5 = select i1 %arg1, i64 6, i64 3
  switch i64 %tmp5, label %bb7 [
  i64 1, label %bb6
  i64 0, label %bb8
  ]

bb6:                                              ; preds = %bb4
  call void @zot()
  br label %bb8

bb7:                                              ; preds = %bb4
  call void @snork()
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6, %bb4
  %tmp9 = phi i8 [ 2, %bb4 ], [ 3, %bb6 ], [ 4, %bb7 ]
  call void @spam(i8 %tmp9)
  ret void
}
