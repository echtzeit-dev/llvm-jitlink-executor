; RUN: opt -passes=loop-versioning -S < %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; Do not version this loop because of a convergent operation

; CHECK-LABEL: @f(
; CHECK: call i32 @llvm.convergent(
; CHECK-NOT: call i32 @llvm.convergent(
define void @f(ptr %a, ptr %b, ptr %c) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %add, %for.body ]

  %arrayidxA = getelementptr inbounds i32, ptr %a, i64 %ind
  %loadA = load i32, ptr %arrayidxA, align 4

  %arrayidxB = getelementptr inbounds i32, ptr %b, i64 %ind
  %loadB = load i32, ptr %arrayidxB, align 4
  %convergentB = call i32 @llvm.convergent(i32 %loadB)

  %mulC = mul i32 %loadA, %convergentB

  %arrayidxC = getelementptr inbounds i32, ptr %c, i64 %ind
  store i32 %mulC, ptr %arrayidxC, align 4

  %add = add nuw nsw i64 %ind, 1
  %exitcond = icmp eq i64 %add, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

declare i32 @llvm.convergent(i32) #1

attributes #0 = { nounwind convergent }
attributes #1 = { nounwind readnone convergent }
