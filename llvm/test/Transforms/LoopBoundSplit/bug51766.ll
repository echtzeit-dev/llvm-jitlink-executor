; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-bound-split -S < %s | FileCheck %s

; LoopBoundSplit pass should fail to split this test's loop because the split
; condition is false in first iteration of the loop.

define i16 @main(i16 %qqq) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[T0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[T8:%.*]], [[CONT19:%.*]] ]
; CHECK-NEXT:    [[T1:%.*]] = shl nuw nsw i16 [[T0]], 1
; CHECK-NEXT:    [[T2:%.*]] = add i16 [[T1]], [[QQQ:%.*]]
; CHECK-NEXT:    [[DOTNOT9:%.*]] = icmp ult i16 [[T2]], [[QQQ]]
; CHECK-NEXT:    br i1 [[DOTNOT9]], label [[HANDLER_POINTER_OVERFLOW:%.*]], label [[CONT15_CRITEDGE:%.*]]
; CHECK:       handler.pointer_overflow:
; CHECK-NEXT:    call void @__ubsan_handle_pointer_overflow()
; CHECK-NEXT:    br label [[CONT19]]
; CHECK:       cont15.critedge:
; CHECK-NEXT:    br label [[CONT19]]
; CHECK:       cont19:
; CHECK-NEXT:    [[T8]] = add nuw nsw i16 [[T0]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i16 [[T8]], 3
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %for.body

for.body:
  %t0 = phi i16 [ 0, %entry ], [ %t8, %cont19 ]
  %t1 = shl nuw nsw i16 %t0, 1
  %t2 = add i16 %t1, %qqq
  %.not9 = icmp ult i16 %t2, %qqq
  br i1 %.not9, label %handler.pointer_overflow, label %cont15.critedge

handler.pointer_overflow:
  call void @__ubsan_handle_pointer_overflow()
  br label %cont19

cont15.critedge:
  br label %cont19

cont19:
  %t8 = add nuw nsw i16 %t0, 1
  %exitcond.not = icmp eq i16 %t8, 3
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret i16 0
}

declare dso_local void @__ubsan_handle_pointer_overflow()
