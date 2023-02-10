; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm64-unknown-unknown -O3 < %s | FileCheck %s
; This test should show that @f and @f_without_freeze generate equivalent
; assembly
; REQUIRES: aarch64-registered-target

define void @f(ptr %p, i32 %n, i32 %m) {
; CHECK-LABEL: f:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add w8, w2, #1
; CHECK-NEXT:  .LBB0_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    strb wzr, [x0, w8, sxtw]
; CHECK-NEXT:    add w8, w8, #1
; CHECK-NEXT:    subs w1, w1, #1
; CHECK-NEXT:    b.ne .LBB0_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  br label %loop
loop:
  %i = phi i32 [0, %entry], [%i.next, %loop]
  %i.next = add i32 %i, 1
  %i.next.fr = freeze i32 %i.next
  %j = add i32 %m, %i.next.fr
  %q = getelementptr i8, ptr %p, i32 %j
  store i8 0, ptr %q
  %cond = icmp eq i32 %i.next.fr, %n
  br i1 %cond, label %exit, label %loop
exit:
  ret void
}

define void @f_without_freeze(ptr %p, i32 %n, i32 %m) {
; CHECK-LABEL: f_without_freeze:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add w8, w2, #1
; CHECK-NEXT:  .LBB1_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    strb wzr, [x0, w8, sxtw]
; CHECK-NEXT:    subs w1, w1, #1
; CHECK-NEXT:    add w8, w8, #1
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  br label %loop
loop:
  %i = phi i32 [0, %entry], [%i.next, %loop]
  %i.next = add i32 %i, 1
  %j = add i32 %m, %i.next
  %q = getelementptr i8, ptr %p, i32 %j
  store i8 0, ptr %q
  %cond = icmp eq i32 %i.next, %n
  br i1 %cond, label %exit, label %loop
exit:
  ret void
}
