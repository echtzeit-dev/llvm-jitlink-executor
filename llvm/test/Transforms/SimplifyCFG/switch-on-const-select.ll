; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

; Test basic folding to a conditional branch.
define i32 @foo(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[EQ:%.*]] = icmp eq i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[EQ]], label [[B:%.*]], label [[SWITCH:%.*]]
; CHECK:       switch:
; CHECK-NEXT:    [[LT:%.*]] = icmp slt i64 [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[LT]], label [[A:%.*]], label [[B]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ 1, [[A]] ], [ [[RETVAL:%.*]], [[B]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       a:
; CHECK-NEXT:    tail call void @bees.a() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       b:
; CHECK-NEXT:    [[RETVAL]] = phi i32 [ 0, [[SWITCH]] ], [ 2, [[ENTRY:%.*]] ]
; CHECK-NEXT:    tail call void @bees.b() #[[ATTR0]]
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  %eq = icmp eq i64 %x, %y
  br i1 %eq, label %b, label %switch
switch:
  %lt = icmp slt i64 %x, %y
  %qux = select i1 %lt, i32 0, i32 2
  switch i32 %qux, label %bees [
  i32 0, label %a
  i32 1, label %b
  i32 2, label %b
  ]
a:
  tail call void @bees.a() nounwind
  ret i32 1
b:
  %retval = phi i32 [0, %switch], [0, %switch], [2, %entry]
  tail call void @bees.b() nounwind
  ret i32 %retval
bees:
  tail call void @llvm.trap() nounwind
  unreachable
}

; Test basic folding to an unconditional branch.
define i32 @bar(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    tail call void @bees.a() #[[ATTR0]]
; CHECK-NEXT:    ret i32 0
;
entry:
  %lt = icmp slt i64 %x, %y
  %qux = select i1 %lt, i32 0, i32 2
  switch i32 %qux, label %bees [
  i32 0, label %a
  i32 1, label %b
  i32 2, label %a
  ]
a:
  %retval = phi i32 [0, %entry], [0, %entry], [1, %b]
  tail call void @bees.a() nounwind
  ret i32 0
b:
  tail call void @bees.b() nounwind
  br label %a
bees:
  tail call void @llvm.trap() nounwind
  unreachable
}

; Test the edge case where both values from the select are the default case.
define void @bazz(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: @bazz(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    tail call void @bees.b() #[[ATTR0]]
; CHECK-NEXT:    ret void
;
entry:
  %lt = icmp slt i64 %x, %y
  %qux = select i1 %lt, i32 10, i32 12
  switch i32 %qux, label %b [
  i32 0, label %a
  i32 1, label %bees
  i32 2, label %bees
  ]
a:
  tail call void @bees.a() nounwind
  ret void
b:
  tail call void @bees.b() nounwind
  ret void
bees:
  tail call void @llvm.trap()
  unreachable
}

; Test the edge case where both values from the select are equal.
define void @quux(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: @quux(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    tail call void @bees.a() #[[ATTR0]]
; CHECK-NEXT:    ret void
;
entry:
  %lt = icmp slt i64 %x, %y
  %qux = select i1 %lt, i32 0, i32 0
  switch i32 %qux, label %b [
  i32 0, label %a
  i32 1, label %bees
  i32 2, label %bees
  ]
a:
  tail call void @bees.a() nounwind
  ret void
b:
  tail call void @bees.b() nounwind
  ret void
bees:
  tail call void @llvm.trap()
  unreachable
}

; A final test, for phi node munging.
define i32 @xyzzy(i64 %x, i64 %y) {
; CHECK-LABEL: @xyzzy(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[EQ:%.*]] = icmp eq i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[LT:%.*]] = icmp slt i64 [[X]], [[Y]]
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[LT]], i32 -1, i32 1
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = select i1 [[EQ]], i32 0, i32 [[SPEC_SELECT]]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
;
entry:
  %eq = icmp eq i64 %x, %y
  br i1 %eq, label %r, label %cont
cont:
  %lt = icmp slt i64 %x, %y
  %qux = select i1 %lt, i32 0, i32 2
  switch i32 %qux, label %bees [
  i32 0, label %a
  i32 1, label %r
  i32 2, label %r
  ]
r:
  %val = phi i32 [0, %entry], [1, %cont], [1, %cont]
  ret i32 %val
a:
  ret i32 -1
bees:
  tail call void @llvm.trap()
  unreachable
}

declare void @llvm.trap() nounwind noreturn
declare void @bees.a() nounwind
declare void @bees.b() nounwind

; CHECK: attributes #1 = { cold noreturn nounwind }
