; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -aa-pipeline=basic-aa -passes=dse -enable-knowledge-retention -S | FileCheck %s

target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

define void @test1(ptr %Q, ptr %P) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(ptr [[Q:%.*]], i64 4), "nonnull"(ptr [[Q]]), "align"(ptr [[Q]], i64 4) ]
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(ptr [[P:%.*]], i64 4), "nonnull"(ptr [[P]]), "align"(ptr [[P]], i64 4) ]
; CHECK-NEXT:    store i32 0, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  %DEAD = load i32, ptr %Q
  store i32 %DEAD, ptr %P
  store i32 0, ptr %P
  ret void
}
