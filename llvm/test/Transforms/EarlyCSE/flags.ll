; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=early-cse -earlycse-debug-hash -S < %s | FileCheck %s
; RUN: opt -passes='early-cse<memssa>' -S < %s | FileCheck %s

declare void @use(i1)

define void @test1(float %x, float %y) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[CMP1:%.*]] = fcmp oeq float [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    ret void
;
  %cmp1 = fcmp nnan oeq float %y, %x
  %cmp2 = fcmp oeq float %x, %y
  call void @use(i1 %cmp1)
  call void @use(i1 %cmp2)
  ret void
}

declare void @use.i8(ptr)

define void @test_inbounds_program_ub_if_first_gep_poison(ptr %ptr, i64 %n) {
; CHECK-LABEL: @test_inbounds_program_ub_if_first_gep_poison(
; CHECK-NEXT:    [[ADD_PTR_1:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 [[N:%.*]]
; CHECK-NEXT:    call void @use.i8(ptr noundef [[ADD_PTR_1]])
; CHECK-NEXT:    call void @use.i8(ptr [[ADD_PTR_1]])
; CHECK-NEXT:    ret void
;
  %add.ptr.1 = getelementptr inbounds i8, ptr %ptr, i64 %n
  call void @use.i8(ptr noundef %add.ptr.1)
  %add.ptr.2 = getelementptr i8, ptr %ptr, i64 %n
  call void @use.i8(ptr %add.ptr.2)
  ret void
}

define void @test_inbounds_program_not_ub_if_first_gep_poison(ptr %ptr, i64 %n) {
; CHECK-LABEL: @test_inbounds_program_not_ub_if_first_gep_poison(
; CHECK-NEXT:    [[ADD_PTR_1:%.*]] = getelementptr i8, ptr [[PTR:%.*]], i64 [[N:%.*]]
; CHECK-NEXT:    call void @use.i8(ptr [[ADD_PTR_1]])
; CHECK-NEXT:    call void @use.i8(ptr [[ADD_PTR_1]])
; CHECK-NEXT:    ret void
;
  %add.ptr.1 = getelementptr inbounds i8, ptr %ptr, i64 %n
  call void @use.i8(ptr %add.ptr.1)
  %add.ptr.2 = getelementptr i8, ptr %ptr, i64 %n
  call void @use.i8(ptr %add.ptr.2)
  ret void
}
