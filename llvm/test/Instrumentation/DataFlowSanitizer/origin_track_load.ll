; RUN: opt < %s -passes=dfsan -dfsan-track-origins=2 -S | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @load64(ptr %p) {
  ; CHECK-LABEL: @load64.dfsan

  ; CHECK-NEXT: %[[#PO:]] = load i32, ptr @__dfsan_arg_origin_tls, align 4
  ; CHECK-NEXT: %[[#PS:]] = load i8, ptr @__dfsan_arg_tls, align [[ALIGN:2]]

  ; CHECK-NEXT: %[[#LABEL_ORIGIN:]] = call zeroext i64 @__dfsan_load_label_and_origin(ptr %p, i64 8)
  ; CHECK-NEXT: %[[#LABEL_ORIGIN_H32:]] = lshr i64 %[[#LABEL_ORIGIN]], 32
  ; CHECK-NEXT: %[[#LABEL:]] = trunc i64 %[[#LABEL_ORIGIN_H32]] to i8
  ; CHECK-NEXT: %[[#ORIGIN:]] = trunc i64 %[[#LABEL_ORIGIN]] to i32
  ; CHECK-NEXT: %[[#ORIGIN_CHAINED:]] = call i32 @__dfsan_chain_origin_if_tainted(i8 %[[#LABEL]], i32 %[[#ORIGIN]])

  ; CHECK-NEXT: %[[#LABEL:]] = or i8 %[[#LABEL]], %[[#PS]]
  ; CHECK-NEXT: %[[#NZ:]] = icmp ne i8 %[[#PS]], 0
  ; CHECK-NEXT: %[[#ORIGIN_SEL:]] = select i1 %[[#NZ]], i32 %[[#PO]], i32 %[[#ORIGIN_CHAINED]]

  ; CHECK-NEXT: %a = load i64, ptr %p
  ; CHECK-NEXT: store i8 %[[#LABEL]], ptr @__dfsan_retval_tls, align [[ALIGN]]
  ; CHECK-NEXT: store i32 %[[#ORIGIN_SEL]], ptr @__dfsan_retval_origin_tls, align 4

  %a = load i64, ptr %p
  ret i64 %a
}
