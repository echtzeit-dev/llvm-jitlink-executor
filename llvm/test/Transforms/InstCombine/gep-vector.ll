; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine %s -S | FileCheck %s

@block = global [64 x [8192 x i8]] zeroinitializer, align 1

define <2 x ptr> @vectorindex1() {
; CHECK-LABEL: @vectorindex1(
; CHECK-NEXT:    ret <2 x ptr> getelementptr inbounds ([64 x [8192 x i8]], ptr @block, <2 x i64> zeroinitializer, <2 x i64> <i64 1, i64 2>, <2 x i64> zeroinitializer)
;
  %1 = getelementptr inbounds [64 x [8192 x i8]], ptr @block, i64 0, <2 x i64> <i64 0, i64 1>, i64 8192
  ret <2 x ptr> %1
}

define <2 x ptr> @vectorindex2() {
; CHECK-LABEL: @vectorindex2(
; CHECK-NEXT:    ret <2 x ptr> getelementptr inbounds ([64 x [8192 x i8]], ptr @block, <2 x i64> zeroinitializer, <2 x i64> <i64 1, i64 2>, <2 x i64> <i64 8191, i64 1>)
;
  %1 = getelementptr inbounds [64 x [8192 x i8]], ptr @block, i64 0, i64 1, <2 x i64> <i64 8191, i64 8193>
  ret <2 x ptr> %1
}

define <2 x ptr> @vectorindex3() {
; CHECK-LABEL: @vectorindex3(
; CHECK-NEXT:    ret <2 x ptr> getelementptr inbounds ([64 x [8192 x i8]], ptr @block, <2 x i64> zeroinitializer, <2 x i64> <i64 0, i64 2>, <2 x i64> <i64 8191, i64 1>)
;
  %1 = getelementptr inbounds [64 x [8192 x i8]], ptr @block, i64 0, <2 x i64> <i64 0, i64 1>, <2 x i64> <i64 8191, i64 8193>
  ret <2 x ptr> %1
}

; Negative test - datalayout's alloc size for the 2 types must match.

define ptr @bitcast_vec_to_array_gep(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_vec_to_array_gep(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr [7 x i32], ptr [[X:%.*]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr [7 x i32], ptr %x, i64 %y, i64 %z
  ret ptr %gep
}

; Negative test - datalayout's alloc size for the 2 types must match.

define ptr @bitcast_array_to_vec_gep(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_array_to_vec_gep(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds <3 x i32>, ptr [[X:%.*]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr inbounds <3 x i32>, ptr %x, i64 %y, i64 %z
  ret ptr %gep
}

; Sizes and types match - safe to remove bitcast.

define ptr @bitcast_vec_to_array_gep_matching_alloc_size(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_vec_to_array_gep_matching_alloc_size(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr [4 x i32], ptr [[X:%.*]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr [4 x i32], ptr %x, i64 %y, i64 %z
  ret ptr %gep
}

; Sizes and types match - safe to remove bitcast.

define ptr @bitcast_array_to_vec_gep_matching_alloc_size(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_array_to_vec_gep_matching_alloc_size(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds <4 x i32>, ptr [[X:%.*]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr inbounds <4 x i32>, ptr %x, i64 %y, i64 %z
  ret ptr %gep
}

; Negative test - datalayout's alloc size for the 2 types must match.

define ptr addrspace(3) @bitcast_vec_to_array_addrspace(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_vec_to_array_addrspace(
; CHECK-NEXT:    [[ASC:%.*]] = addrspacecast ptr [[X:%.*]] to ptr addrspace(3)
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr [7 x i32], ptr addrspace(3) [[ASC]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr addrspace(3) [[GEP]]
;
  %asc = addrspacecast ptr %x to ptr addrspace(3)
  %gep = getelementptr [7 x i32], ptr addrspace(3) %asc, i64 %y, i64 %z
  ret ptr addrspace(3) %gep
}

; Negative test - datalayout's alloc size for the 2 types must match.

define ptr addrspace(3) @inbounds_bitcast_vec_to_array_addrspace(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @inbounds_bitcast_vec_to_array_addrspace(
; CHECK-NEXT:    [[ASC:%.*]] = addrspacecast ptr [[X:%.*]] to ptr addrspace(3)
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [7 x i32], ptr addrspace(3) [[ASC]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr addrspace(3) [[GEP]]
;
  %asc = addrspacecast ptr %x to ptr addrspace(3)
  %gep = getelementptr inbounds [7 x i32], ptr addrspace(3) %asc, i64 %y, i64 %z
  ret ptr addrspace(3) %gep
}

; Sizes and types match - safe to remove bitcast.

define ptr addrspace(3) @bitcast_vec_to_array_addrspace_matching_alloc_size(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @bitcast_vec_to_array_addrspace_matching_alloc_size(
; CHECK-NEXT:    [[ASC:%.*]] = addrspacecast ptr [[X:%.*]] to ptr addrspace(3)
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr [4 x i32], ptr addrspace(3) [[ASC]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr addrspace(3) [[GEP]]
;
  %asc = addrspacecast ptr %x to ptr addrspace(3)
  %gep = getelementptr [4 x i32], ptr addrspace(3) %asc, i64 %y, i64 %z
  ret ptr addrspace(3) %gep
}

; Sizes and types match - safe to remove bitcast.

define ptr addrspace(3) @inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size(ptr %x, i64 %y, i64 %z) {
; CHECK-LABEL: @inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size(
; CHECK-NEXT:    [[ASC:%.*]] = addrspacecast ptr [[X:%.*]] to ptr addrspace(3)
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [4 x i32], ptr addrspace(3) [[ASC]], i64 [[Y:%.*]], i64 [[Z:%.*]]
; CHECK-NEXT:    ret ptr addrspace(3) [[GEP]]
;
  %asc = addrspacecast ptr %x to ptr addrspace(3)
  %gep = getelementptr inbounds [4 x i32], ptr addrspace(3) %asc, i64 %y, i64 %z
  ret ptr addrspace(3) %gep
}

; Negative test - avoid doing bitcast on ptr, because '16' should be scaled by 'vscale'.

define ptr @test_accumulate_constant_offset_vscale_nonzero(<vscale x 16 x i1> %pg, ptr %base) {
; CHECK-LABEL: @test_accumulate_constant_offset_vscale_nonzero(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr <vscale x 16 x i8>, ptr [[BASE:%.*]], i64 1, i64 4
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr <vscale x 16 x i8>, ptr %base, i64 1, i64 4
  ret ptr %gep
}

define ptr @test_accumulate_constant_offset_vscale_zero(<vscale x 16 x i1> %pg, ptr %base) {
; CHECK-LABEL: @test_accumulate_constant_offset_vscale_zero(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr <vscale x 16 x i8>, ptr [[BASE:%.*]], i64 0, i64 4
; CHECK-NEXT:    ret ptr [[GEP]]
;
  %gep = getelementptr <vscale x 16 x i8>, ptr %base, i64 0, i64 4
  ret ptr %gep
}
