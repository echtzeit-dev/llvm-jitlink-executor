; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=licm -S | FileCheck %s

; This test case case is generated from the following C code with -fstrict-aliasing,
; and after passing through -passes=inline,mem2reg,loop-rotate,instcombine
; void add(ptr restrict data, int *restrict addend) {
;    *data += *addend;
; }
;
; void foo(ptr data, int *addend) {
;    for (int i = 0; i < 1000; ++i) {
;        *data += *addend;
;        add(data, addend);
;    }
; }
; We want to make sure the load of addend gets hoisted, independent of the second load
; load having different noalias metadata.

define void @foo(ptr %data, ptr %addend) #0 {
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ADDEND:%.*]], align 4, !tbaa !1
; CHECK-NEXT:    [[CONV:%.*]] = sitofp i32 [[TMP1]] to double
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ADDEND]], align 4, !tbaa !1, !alias.scope !5, !noalias !8
; CHECK-NEXT:    [[CONV_I:%.*]] = sitofp i32 [[TMP2]] to double
entry:
  %i = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %i) #2
  store i32 0, ptr %i, align 4, !tbaa !1
  br i1 true, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  br label %for.body

for.cond.for.cond.cleanup_crit_edge:              ; preds = %for.inc
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.for.cond.cleanup_crit_edge, %entry
  call void @llvm.lifetime.end.p0(i64 4, ptr %i) #2
  br label %for.end

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %0 = load i32, ptr %addend, align 4, !tbaa !1
  %conv = sitofp i32 %0 to double
  %1 = load i32, ptr %i, align 4, !tbaa !1
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds double, ptr %data, i64 %idxprom
  %2 = load double, ptr %arrayidx, align 8, !tbaa !5
  %add = fadd double %2, %conv
  store double %add, ptr %arrayidx, align 8, !tbaa !5
  %idxprom1 = sext i32 %1 to i64
  %arrayidx2 = getelementptr inbounds double, ptr %data, i64 %idxprom1
  %3 = load i32, ptr %addend, align 4, !tbaa !1, !alias.scope !7, !noalias !10
  %conv.i = sitofp i32 %3 to double
  %4 = load double, ptr %arrayidx2, align 8, !tbaa !5, !alias.scope !10, !noalias !7
  %add.i = fadd double %4, %conv.i
  store double %add.i, ptr %arrayidx2, align 8, !tbaa !5, !alias.scope !10, !noalias !7
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, ptr %i, align 4, !tbaa !1
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4, !tbaa !1
  %cmp = icmp slt i32 %inc, 1000
  br i1 %cmp, label %for.body, label %for.cond.for.cond.cleanup_crit_edge

for.end:                                          ; preds = %for.cond.cleanup
  ret void
}

declare void @llvm.lifetime.start.p0(i64, ptr nocapture) #0
declare void @llvm.lifetime.end.p0(i64, ptr nocapture) #0

attributes #0 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 5.0.0  (llvm/trunk 299971)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !3, i64 0}
!7 = !{!8}
!8 = distinct !{!8, !9, !"add: %addend"}
!9 = distinct !{!9, !"add"}
!10 = !{!11}
!11 = distinct !{!11, !9, !"add: %data"}
