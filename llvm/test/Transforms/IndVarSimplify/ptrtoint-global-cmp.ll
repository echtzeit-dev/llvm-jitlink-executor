; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=indvars -S %s | FileCheck %s

@a = global [4 x i32] zeroinitializer, align 16

define i32 @test() {
; CHECK-LABEL: define i32 @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[RED:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[RED_NEXT:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i8 [[IV]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr @a, i64 [[IDXPROM]]
; CHECK-NEXT:    br i1 false, label [[LOOP_LATCH]], label [[EXIT_1:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    [[RED_NEXT]] = add nsw i32 [[L]], [[RED]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    br i1 true, label [[LOOP_HEADER]], label [[EXIT_2:%.*]]
; CHECK:       exit.1:
; CHECK-NEXT:    ret i32 0
; CHECK:       exit.2:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[RED_NEXT]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    ret i32 [[ADD_LCSSA]]
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %red = phi i32 [ 0, %entry ], [ %red.next, %loop.latch ]
  %idxprom = zext i8 %iv to i64
  %gep = getelementptr i32, ptr @a, i64 %idxprom
  %f = icmp ult ptr %gep, getelementptr inbounds ([4 x i32], ptr @a, i64 1, i64 0)
  br i1 %f, label %loop.latch, label %exit.1

loop.latch:
  %l = load i32, ptr %gep, align 4
  %red.next = add nsw i32 %l, %red
  %iv.next = add nuw nsw i8 %iv, 1
  %cmp = icmp ult i8 %iv, 4
  br i1 %cmp, label %loop.header, label %exit.2

exit.1:                                             ; preds = %for.body
  ret i32 0

exit.2:
  %add.lcssa = phi i32 [ %red.next, %loop.latch ]
  ret i32 %add.lcssa
}