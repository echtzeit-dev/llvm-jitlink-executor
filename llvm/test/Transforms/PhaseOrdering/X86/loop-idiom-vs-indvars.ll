; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mcpu=core-avx2 < %s -O3 -S                                        | FileCheck --check-prefix=ALL %s
; RUN: opt -mcpu=core-avx2 < %s -passes="default<O3>" -S | FileCheck --check-prefix=ALL %s

; Not only should we be able to make the loop countable,
; %whatever.next recurrence should be rewritten, making loop dead.

target triple = "x86_64--"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define i32 @cttz(i32 %n, ptr %p1) {
; ALL-LABEL: @cttz(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TMP0:%.*]] = shl i32 [[N:%.*]], 1
; ALL-NEXT:    [[TMP1:%.*]] = tail call i32 @llvm.cttz.i32(i32 [[TMP0]], i1 false), !range [[RNG0:![0-9]+]]
; ALL-NEXT:    [[TMP2:%.*]] = sub nuw nsw i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = sub nuw nsw i32 75, [[TMP1]]
; ALL-NEXT:    store i32 [[TMP3]], ptr [[P1:%.*]], align 4
; ALL-NEXT:    ret i32 [[TMP2]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shl, %while.cond ]
  %whatever = phi i32 [ 42, %entry ], [ %whatever.next, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shl = shl i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shl, 0
  %inc = add nsw i32 %i.0, 1
  %whatever.next = add i32 %whatever, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  store i32 %whatever.next, ptr %p1
  ret i32 %i.0
}
