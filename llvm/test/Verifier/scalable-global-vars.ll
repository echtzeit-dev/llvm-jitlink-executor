; RUN: not opt -S -passes=verify < %s 2>&1 | FileCheck %s

;; Global variables cannot be scalable vectors, since we don't
;; know the size at compile time.

; CHECK: Globals cannot contain scalable vectors
; CHECK-NEXT: ptr @ScalableVecGlobal
@ScalableVecGlobal = global <vscale x 4 x i32> zeroinitializer

; CHECK-NEXT: Globals cannot contain scalable vectors
; CHECK-NEXT: ptr @ScalableVecStructGlobal
@ScalableVecStructGlobal = global { i32,  <vscale x 4 x i32> } zeroinitializer

;; Global _pointers_ to scalable vectors are fine
; CHECK-NOT: Globals cannot contain scalable vectors
@ScalableVecPtr = global ptr zeroinitializer
