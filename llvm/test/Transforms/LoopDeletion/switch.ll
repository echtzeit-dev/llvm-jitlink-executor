; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-deletion -verify-loop-info -S | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

@G = external global i32

define void @func_1() {
; CHECK-LABEL: @func_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LBL_2368:%.*]]
; CHECK:       lbl_2368:
; CHECK-NEXT:    [[CMP289:%.*]] = icmp slt i32 undef, -5
; CHECK-NEXT:    br i1 [[CMP289]], label [[CLEANUP967:%.*]], label [[UNREACHABLE:%.*]]
; CHECK:       cleanup967:
; CHECK-NEXT:    switch i32 undef, label [[CLEANUP1169:%.*]] [
; CHECK-NEXT:    i32 20, label [[CLEANUP967_LBL_2368_CRIT_EDGE:%.*]]
; CHECK-NEXT:    ]
; CHECK:       cleanup967.lbl_2368_crit_edge:
; CHECK-NEXT:    unreachable
; CHECK:       cleanup1169:
; CHECK-NEXT:    ret void
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
;
entry:
  br label %lbl_2368

lbl_2368:
  %cmp289 = icmp slt i32 undef, -5
  br i1 %cmp289, label %cleanup967, label %unreachable

cleanup967:
  switch i32 undef, label %cleanup1169 [
  i32 20, label %lbl_2368
  ]

cleanup1169:
  ret void

unreachable:
  unreachable
}

define void @func_2() {
; CHECK-LABEL: @func_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LBL_2368:%.*]]
; CHECK:       lbl_2368:
; CHECK-NEXT:    br i1 false, label [[CLEANUP967:%.*]], label [[UNREACHABLE:%.*]]
; CHECK:       cleanup967:
; CHECK-NEXT:    switch i32 undef, label [[CLEANUP1169:%.*]] [
; CHECK-NEXT:    i32 20, label [[CLEANUP967_LBL_2368_CRIT_EDGE:%.*]]
; CHECK-NEXT:    ]
; CHECK:       cleanup967.lbl_2368_crit_edge:
; CHECK-NEXT:    unreachable
; CHECK:       cleanup1169:
; CHECK-NEXT:    ret void
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
;
entry:
  br label %lbl_2368

lbl_2368:
  br i1 false, label %cleanup967, label %unreachable

cleanup967:
  switch i32 undef, label %cleanup1169 [
  i32 20, label %lbl_2368
  ]

cleanup1169:
  ret void

unreachable:
  unreachable
}
