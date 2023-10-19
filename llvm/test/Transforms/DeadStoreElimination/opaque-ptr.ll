; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=dse -opaque-pointers -S | FileCheck %s

define void @write4to7_opaque_ptr(ptr nocapture %p) {
; CHECK-LABEL: @write4to7_opaque_ptr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i8, ptr [[ARRAYIDX0]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[TMP0]], i8 0, i64 24, i1 false)
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, ptr [[P]], i64 1
; CHECK-NEXT:    store i32 1, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx0 = getelementptr inbounds i32, ptr %p, i64 1
  call void @llvm.memset.p0.i64(ptr align 4 %arrayidx0, i8 0, i64 28, i1 false)
  %arrayidx1 = getelementptr inbounds i32, ptr %p, i64 1
  store i32 1, ptr %arrayidx1, align 4
  ret void
}

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
