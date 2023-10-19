; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes --check-globals --include-generated-funcs
; RUN: opt -passes=openmp-opt -S < %s | FileCheck %s --check-prefixes=CHECK

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "amdgcn-amd-amdhsa"

%"struct.Kokkos::Impl::SubviewExtents.448" = type <{ [2 x i64], [1 x i64], [1 x i32], [4 x i8] }>

define linkonce_odr void @_ZN6Kokkos4ViewIPdJNS_12LayoutStrideENS_6DeviceINS_12Experimental12OpenMPTargetENS_18ScratchMemorySpaceIS5_EEEENS_12MemoryTraitsILj1EEEEEC2IPS1_JNS_11LayoutRightES7_SA_ENS_4Impl5ALL_tEJiEEERKNS0_IT_JDpT0_EEET1_DpT2_() {
entry:
  call void @_ZN6Kokkos4Impl11ViewMappingIvJNS_10ViewTraitsIPPdJNS_11LayoutRightENS_18ScratchMemorySpaceINS_12Experimental12OpenMPTargetEEENS_12MemoryTraitsILj1EEEEEENS0_5ALL_tEiEE6assignINS2_IS3_JNS_12LayoutStrideENS_6DeviceIS8_S9_EESB_EEEEEvRNS1_IT_JvEEERKNS1_ISC_JvEEESD_i()
  ret void
}

define linkonce_odr void @_ZN6Kokkos4Impl11ViewMappingIvJNS_10ViewTraitsIPPdJNS_11LayoutRightENS_18ScratchMemorySpaceINS_12Experimental12OpenMPTargetEEENS_12MemoryTraitsILj1EEEEEENS0_5ALL_tEiEE6assignINS2_IS3_JNS_12LayoutStrideENS_6DeviceIS8_S9_EESB_EEEEEvRNS1_IT_JvEEERKNS1_ISC_JvEEESD_i() {
entry:
  %extents11 = alloca [0 x [0 x %"struct.Kokkos::Impl::SubviewExtents.448"]], i32 0, align 8, addrspace(5)
  %extents.ascast = addrspacecast ptr addrspace(5) %extents11 to ptr
  call void @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EEC2IJLm0ELm0EEJNS0_5ALL_tEiEEERKNS0_13ViewDimensionIJXspT_EEEEDpT0_(ptr %extents.ascast)
  call void @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvEC2INS2_IJLm0ELm0EEEENS_11LayoutRightEEERKNS1_IT_T0_vEERKNS0_14SubviewExtentsIXsrS9_4rankELj1EEE(ptr %extents.ascast)
  ret void
}

define linkonce_odr void @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EEC2IJLm0ELm0EEJNS0_5ALL_tEiEEERKNS0_13ViewDimensionIJXspT_EEEEDpT0_(ptr %this) {
entry:
  %call = call i1 @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EE3setIJLm0ELm0EEJiEEEbjjRKNS0_13ViewDimensionIJXspT_EEEENS0_5ALL_tEDpT0_(ptr %this)
  ret void
}

define linkonce_odr void @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvEC2INS2_IJLm0ELm0EEEENS_11LayoutRightEEERKNS1_IT_T0_vEERKNS0_14SubviewExtentsIXsrS9_4rankELj1EEE(ptr %sub) {
entry:
  %call191 = call i32 @_ZNK6Kokkos4Impl14SubviewExtentsILj2ELj1EE11range_indexIiEEjT_(ptr %sub)
  %call201 = call i64 @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvE6strideINS2_IJLm0ELm0EEEENS_11LayoutRightEEEmjRKNS1_IT_T0_vEE(i32 %call191)
  ret void
}

define linkonce_odr i1 @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EE3setIJLm0ELm0EEJiEEEbjjRKNS0_13ViewDimensionIJXspT_EEEENS0_5ALL_tEDpT0_(ptr %this) {
entry:
  store i64 0, ptr %this, align 8
  ret i1 false
}

define linkonce_odr i64 @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvE6strideINS2_IJLm0ELm0EEEENS_11LayoutRightEEEmjRKNS1_IT_T0_vEE(i32 %r) {
entry:
  store i32 %r, ptr null, align 4294967296
  ret i64 0
}

define linkonce_odr i32 @_ZNK6Kokkos4Impl14SubviewExtentsILj2ELj1EE11range_indexIiEEjT_(ptr %this) {
entry:
  %cmp = icmp eq i32 1, 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %0 = load i32, ptr %this, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %entry
  %cond = phi i32 [ %0, %cond.true ], [ 1, %entry ]
  ret i32 %cond
}

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"openmp", i32 50}
!1 = !{i32 7, !"openmp-device", i32 50}
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4ViewIPdJNS_12LayoutStrideENS_6DeviceINS_12Experimental12OpenMPTargetENS_18ScratchMemorySpaceIS5_EEEENS_12MemoryTraitsILj1EEEEEC2IPS1_JNS_11LayoutRightES7_SA_ENS_4Impl5ALL_tEJiEEERKNS0_IT_JDpT0_EEET1_DpT2_() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4Impl11ViewMappingIvJNS_10ViewTraitsIPPdJNS_11LayoutRightENS_18ScratchMemorySpaceINS_12Experimental12OpenMPTargetEEENS_12MemoryTraitsILj1EEEEEENS0_5ALL_tEiEE6assignINS2_IS3_JNS_12LayoutStrideENS_6DeviceIS8_S9_EESB_EEEEEvRNS1_IT_JvEEERKNS1_ISC_JvEEESD_i() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[EXTENTS11:%.*]] = alloca [0 x [0 x %"struct.Kokkos::Impl::SubviewExtents.448"]], i32 0, align 8, addrspace(5)
; CHECK-NEXT:    [[EXTENTS_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[EXTENTS11]] to ptr
; CHECK-NEXT:    call void @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EEC2IJLm0ELm0EEJNS0_5ALL_tEiEEERKNS0_13ViewDimensionIJXspT_EEEEDpT0_(ptr [[EXTENTS_ASCAST]])
; CHECK-NEXT:    call void @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvEC2INS2_IJLm0ELm0EEEENS_11LayoutRightEEERKNS1_IT_T0_vEERKNS0_14SubviewExtentsIXsrS9_4rankELj1EEE(ptr [[EXTENTS_ASCAST]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EEC2IJLm0ELm0EEJNS0_5ALL_tEiEEERKNS0_13ViewDimensionIJXspT_EEEEDpT0_
; CHECK-SAME: (ptr [[THIS:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call i1 @_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EE3setIJLm0ELm0EEJiEEEbjjRKNS0_13ViewDimensionIJXspT_EEEENS0_5ALL_tEDpT0_(ptr [[THIS]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvEC2INS2_IJLm0ELm0EEEENS_11LayoutRightEEERKNS1_IT_T0_vEERKNS0_14SubviewExtentsIXsrS9_4rankELj1EEE
; CHECK-SAME: (ptr [[SUB:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL191:%.*]] = call i32 @_ZNK6Kokkos4Impl14SubviewExtentsILj2ELj1EE11range_indexIiEEjT_(ptr [[SUB]])
; CHECK-NEXT:    [[CALL201:%.*]] = call i64 @_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvE6strideINS2_IJLm0ELm0EEEENS_11LayoutRightEEEmjRKNS1_IT_T0_vEE(i32 [[CALL191]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4Impl14SubviewExtentsILj2ELj1EE3setIJLm0ELm0EEJiEEEbjjRKNS0_13ViewDimensionIJXspT_EEEENS0_5ALL_tEDpT0_
; CHECK-SAME: (ptr [[THIS:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 0, ptr [[THIS]], align 8
; CHECK-NEXT:    ret i1 false
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZN6Kokkos4Impl10ViewOffsetINS0_13ViewDimensionIJLm0EEEENS_12LayoutStrideEvE6strideINS2_IJLm0ELm0EEEENS_11LayoutRightEEEmjRKNS1_IT_T0_vEE
; CHECK-SAME: (i32 [[R:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 [[R]], ptr null, align 4294967296
; CHECK-NEXT:    ret i64 0
;
;
; CHECK-LABEL: define {{[^@]+}}@_ZNK6Kokkos4Impl14SubviewExtentsILj2ELj1EE11range_indexIiEEjT_
; CHECK-SAME: (ptr [[THIS:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 1, 0
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[THIS]], align 4
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[TMP0]], [[COND_TRUE]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
;.
; CHECK: [[META0:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META1:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
;.
