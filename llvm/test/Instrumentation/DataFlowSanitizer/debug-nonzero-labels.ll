; RUN: opt < %s -passes=dfsan -dfsan-debug-nonzero-labels -S | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @g()

; CHECK: define i32 @f.dfsan(i32 %0, i32 %1)
define i32 @f(i32, i32) {
  ; CHECK: [[ARGLABEL1:%.*]] = load i8, {{.*}} @__dfsan_arg_tls
  %i = alloca i32
  ; CHECK: [[ARGCMP1:%.*]] = icmp ne i8 [[ARGLABEL1]], 0
  ; CHECK: br i1 [[ARGCMP1]]
  ; CHECK: [[ARGLABEL2:%.*]] = load i8, {{.*}} @__dfsan_arg_tls
  ; CHECK: [[LOCALLABELALLOCA:%.*]] = alloca i8
  ; CHECK: [[ARGCMP2:%.*]] = icmp ne i8 [[ARGLABEL2]], 0
  ; CHECK: br i1 [[ARGCMP2]]
  %x = add i32 %0, %1
  store i32 %x, ptr %i
  ; CHECK: [[CALL:%.*]] = call i32 @g.dfsan()
  ; CHECK: [[RETLABEL:%.*]] = load i8, {{.*}} @__dfsan_retval_tls
  ; CHECK: [[CALLCMP:%.*]] = icmp ne i8 [[RETLABEL]], 0
  ; CHECK: br i1 [[CALLCMP]]
  %call = call i32 @g()
  ; CHECK: [[LOCALLABEL:%.*]] = load i8, ptr [[LOCALLABELALLOCA]]
  ; CHECK: [[LOCALCMP:%.*]] = icmp ne i8 [[LOCALLABEL]], 0
  ; CHECK: br i1 [[LOCALCMP]]
  %load = load i32, ptr %i
  ret i32 %load
}
