; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=dse < %s | FileCheck %s

; Assume that %p1 != %p2 if and only if %c is true. In that case the noalias
; metadata is correct, but the first store cannot be eliminated, as it may be
; read-clobbered by the load.
define void @test(i1 %c, ptr %p1, ptr %p2) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    store i8 0, ptr [[P1:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr [[P2:%.*]], align 1, !alias.scope !0
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[ELSE:%.*]]
; CHECK:       if:
; CHECK-NEXT:    store i8 1, ptr [[P1]], align 1, !noalias !0
; CHECK-NEXT:    ret void
; CHECK:       else:
; CHECK-NEXT:    store i8 2, ptr [[P1]], align 1
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %p1
  load i8, ptr %p2, !alias.scope !2
  br i1 %c, label %if, label %else

if:
  store i8 1, ptr %p1, !noalias !2
  ret void

else:
  store i8 2, ptr %p1
  ret void
}

!0 = !{!0}
!1 = !{!1, !0}
!2 = !{!1}
