; MRE for SCC splitting causing MLInlineAdvisor to lose track of edges
; foo and bar both call inlineme; inlineme calls only foo and bar
; when the foo-bar-inlineme SCC reaches the inliner, foo-bar will be split out
; leaving inlineme in the SCC. inlineme is dead, so it gets removed from the SCC
; However, MLInlineAdvisor should still track the edges of foo and bar onPassExit
; as the foo-bar SCC will be passed on to the next SCC pass in the pipeline
; and as a result could gain/lose edges before the inliner sees it again

; In this example if loop-unroll is ran after a mandatory inlining CGSCC pass,
; edges would increase but wouldn't be tracked

; REQUIRES: llvm_inliner_model_autogenerated

; RUN: opt -enable-ml-inliner=release -passes=inliner-ml-advisor-release \
; RUN:     -keep-inline-advisor-for-printing \
; RUN:     -enable-scc-inline-advisor-printing -S < %s 2>&1 | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @_Z8inlinemei() inlinehint alwaysinline {
entry:
  %call2 = call noundef i32 @_Z3bari(i32 noundef 12321)
  %call3 = call noundef i32 @_Z3fooi(i32 noundef 12321)
  ret void
}

define dso_local noundef i32 @_Z3bari(i32 noundef %y) {
entry:
  call void @_Z8inlinemei()
  ret i32 %y
}

define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef %argv) {
entry:
  %call = call noundef i32 @_Z3fooi(i32 noundef %argc)
  ret i32 %call
}

define dso_local noundef i32 @_Z3fooi(i32 noundef %z) {
entry:
  %a = alloca i32, align 4
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %inc = add nsw i32 %0, 1
  store i32 %inc, ptr %arrayidx, align 4
  call void @_Z8inlinemei()
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !5

for.end:
  ret i32 %z
}

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!5, !{!"llvm.loop.disable_nonforced"}, !{!"llvm.loop.unroll.enable"}}

; CHECK: [MLInlineAdvisor] Nodes: 3 Edges: 5 EdgesOfLastSeenNodes: 4
; CHECK: [MLInlineAdvisor] Nodes: 3 Edges: 5 EdgesOfLastSeenNodes: 4
; CHECK: [MLInlineAdvisor] Nodes: 3 Edges: 5 EdgesOfLastSeenNodes: 4
; CHECK: [MLInlineAdvisor] Nodes: 3 Edges: 5 EdgesOfLastSeenNodes: 4
; CHECK: [MLInlineAdvisor] Nodes: 3 Edges: 5 EdgesOfLastSeenNodes: 1
