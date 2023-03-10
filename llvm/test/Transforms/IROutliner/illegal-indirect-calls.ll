; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost --no-ir-sim-indirect-calls < %s | FileCheck %s

; This test checks that we do not outline indirect calls when it is specified
; that we should not.

declare void @f1(ptr, ptr);
declare void @f2(ptr, ptr);

define void @function1(ptr %func) {
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    call void [[FUNC:%.*]]()
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  call void %func()
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

define void @function2(ptr %func) {
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    call void [[FUNC:%.*]]()
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  call void %func()
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}
