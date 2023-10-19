; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=indvars < %s | FileCheck %s

@x = global i32 0

; %loop2 is never entered and we cannot derive any fact about %iv from it.
define i32 @main(i32 %iv.start, i32 %arg2) mustprogress {
; CHECK-LABEL: define i32 @main
; CHECK-SAME: (i32 [[IV_START:%.*]], i32 [[ARG2:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ [[IV_START]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    br i1 false, label [[LOOP2_PREHEADER:%.*]], label [[LOOP_LATCH]]
; CHECK:       loop2.preheader:
; CHECK-NEXT:    br label [[LOOP2:%.*]]
; CHECK:       loop2:
; CHECK-NEXT:    br i1 true, label [[LOOP2_EXIT:%.*]], label [[LOOP2]]
; CHECK:       loop2.exit:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[IV_NEXT]] = sdiv i32 [[ARG2]], [[IV]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[IV]], -1
; CHECK-NEXT:    br i1 [[CMP2]], label [[LOOP_EXIT:%.*]], label [[LOOP]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[IV_NEXT_LCSSA:%.*]] = phi i32 [ [[IV_NEXT]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    ret i32 [[IV_NEXT_LCSSA]]
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop.latch ], [ %iv.start, %entry ]
  br i1 false, label %loop2.preheader, label %loop.latch

loop2.preheader:
  br label %loop2

loop2:
  %x = load i32, ptr @x, align 4
  %cmp1 = icmp ult i32 %iv, %x
  br i1 %cmp1, label %loop2.exit, label %loop2

loop2.exit:
  br label %loop.latch

loop.latch:
  %iv.next = sdiv i32 %arg2, %iv
  %cmp2 = icmp eq i32 %iv, -1
  br i1 %cmp2, label %loop.exit, label %loop

loop.exit:
  %iv.next.lcssa = phi i32 [ %iv.next, %loop.latch ]
  ret i32 %iv.next.lcssa
}
