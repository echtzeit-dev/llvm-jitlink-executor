; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; Check that we not do outline musttail calls when tailcc is present.

declare tailcc void @musttail()

define tailcc void @f1() {
  %a = alloca i32, align 4
  store i32 2, ptr %a, align 4
  musttail call tailcc void @musttail()
  ret void
}

define tailcc void @f2() {
  %a = alloca i32, align 4
  store i32 2, ptr %a, align 4
  musttail call tailcc void @musttail()
  ret void
}
; CHECK-LABEL: @f1(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 2, ptr [[A]], align 4
; CHECK-NEXT:    musttail call tailcc void @musttail()
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @f2(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 2, ptr [[A]], align 4
; CHECK-NEXT:    musttail call tailcc void @musttail()
; CHECK-NEXT:    ret void
;
