; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -passes="default<O1>" -S < %s | FileCheck --check-prefixes=O1 %s
; RUN: opt -passes="default<O2>" -S < %s | FileCheck --check-prefixes=O2 %s
; RUN: opt -passes="default<O3>" -S < %s | FileCheck --check-prefixes=O3 %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data" = type { ptr, ptr, ptr }

$_ZNSt6vectorIiSaIiEEixEm = comdat any

define dso_local void @_Z7computeRSt6vectorIiSaIiEEy(ptr noundef nonnull align 8 dereferenceable(24) %data, i64 noundef %numElems) {
; O1-LABEL: define {{[^@]+}}@_Z7computeRSt6vectorIiSaIiEEy
; O1-SAME: (ptr nocapture noundef nonnull readonly align 8 dereferenceable(24) [[DATA:%.*]], i64 noundef [[NUMELEMS:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; O1-NEXT:  entry:
; O1-NEXT:    [[CMP24_NOT:%.*]] = icmp eq i64 [[NUMELEMS]], 0
; O1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DATA]], align 8
; O1-NEXT:    br label [[FOR_COND1_PREHEADER:%.*]]
; O1:       for.cond1.preheader:
; O1-NEXT:    [[I_06:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC7:%.*]], [[FOR_COND_CLEANUP3:%.*]] ]
; O1-NEXT:    br i1 [[CMP24_NOT]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4:%.*]]
; O1:       for.cond.cleanup:
; O1-NEXT:    ret void
; O1:       for.cond.cleanup3:
; O1-NEXT:    [[INC7]] = add nuw nsw i64 [[I_06]], 1
; O1-NEXT:    [[EXITCOND7_NOT:%.*]] = icmp eq i64 [[INC7]], 100
; O1-NEXT:    br i1 [[EXITCOND7_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_COND1_PREHEADER]], !llvm.loop [[LOOP0:![0-9]+]]
; O1:       for.body4:
; O1-NEXT:    [[J_05:%.*]] = phi i64 [ [[INC5:%.*]], [[FOR_BODY4]] ], [ 0, [[FOR_COND1_PREHEADER]] ]
; O1-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 [[J_05]]
; O1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ADD_PTR_I]], align 4, !tbaa [[TBAA2:![0-9]+]]
; O1-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP1]], 1
; O1-NEXT:    store i32 [[INC]], ptr [[ADD_PTR_I]], align 4, !tbaa [[TBAA2]]
; O1-NEXT:    [[INC5]] = add nuw i64 [[J_05]], 1
; O1-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC5]], [[NUMELEMS]]
; O1-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4]], !llvm.loop [[LOOP6:![0-9]+]]
;
; O2-LABEL: define {{[^@]+}}@_Z7computeRSt6vectorIiSaIiEEy
; O2-SAME: (ptr nocapture noundef nonnull readonly align 8 dereferenceable(24) [[DATA:%.*]], i64 noundef [[NUMELEMS:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; O2-NEXT:  entry:
; O2-NEXT:    [[CMP24_NOT:%.*]] = icmp eq i64 [[NUMELEMS]], 0
; O2-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DATA]], align 8
; O2-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[NUMELEMS]], 8
; O2-NEXT:    [[N_VEC:%.*]] = and i64 [[NUMELEMS]], -8
; O2-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[NUMELEMS]]
; O2-NEXT:    br label [[FOR_COND1_PREHEADER:%.*]]
; O2:       for.cond1.preheader:
; O2-NEXT:    [[I_06:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC7:%.*]], [[FOR_COND_CLEANUP3:%.*]] ]
; O2-NEXT:    br i1 [[CMP24_NOT]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4_PREHEADER:%.*]]
; O2:       for.body4.preheader:
; O2-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[FOR_BODY4_PREHEADER9:%.*]], label [[VECTOR_BODY:%.*]]
; O2:       vector.body:
; O2-NEXT:    [[INDEX:%.*]] = phi i64 [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ], [ 0, [[FOR_BODY4_PREHEADER]] ]
; O2-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 [[INDEX]]
; O2-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP1]], align 4, !tbaa [[TBAA0:![0-9]+]]
; O2-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 4
; O2-NEXT:    [[WIDE_LOAD8:%.*]] = load <4 x i32>, ptr [[TMP2]], align 4, !tbaa [[TBAA0]]
; O2-NEXT:    [[TMP3:%.*]] = add nsw <4 x i32> [[WIDE_LOAD]], <i32 1, i32 1, i32 1, i32 1>
; O2-NEXT:    [[TMP4:%.*]] = add nsw <4 x i32> [[WIDE_LOAD8]], <i32 1, i32 1, i32 1, i32 1>
; O2-NEXT:    store <4 x i32> [[TMP3]], ptr [[TMP1]], align 4, !tbaa [[TBAA0]]
; O2-NEXT:    store <4 x i32> [[TMP4]], ptr [[TMP2]], align 4, !tbaa [[TBAA0]]
; O2-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; O2-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; O2-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; O2:       middle.block:
; O2-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4_PREHEADER9]]
; O2:       for.body4.preheader9:
; O2-NEXT:    [[J_05_PH:%.*]] = phi i64 [ 0, [[FOR_BODY4_PREHEADER]] ], [ [[N_VEC]], [[MIDDLE_BLOCK]] ]
; O2-NEXT:    br label [[FOR_BODY4:%.*]]
; O2:       for.cond.cleanup:
; O2-NEXT:    ret void
; O2:       for.cond.cleanup3:
; O2-NEXT:    [[INC7]] = add nuw nsw i64 [[I_06]], 1
; O2-NEXT:    [[EXITCOND7_NOT:%.*]] = icmp eq i64 [[INC7]], 100
; O2-NEXT:    br i1 [[EXITCOND7_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_COND1_PREHEADER]], !llvm.loop [[LOOP7:![0-9]+]]
; O2:       for.body4:
; O2-NEXT:    [[J_05:%.*]] = phi i64 [ [[INC5:%.*]], [[FOR_BODY4]] ], [ [[J_05_PH]], [[FOR_BODY4_PREHEADER9]] ]
; O2-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 [[J_05]]
; O2-NEXT:    [[TMP6:%.*]] = load i32, ptr [[ADD_PTR_I]], align 4, !tbaa [[TBAA0]]
; O2-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP6]], 1
; O2-NEXT:    store i32 [[INC]], ptr [[ADD_PTR_I]], align 4, !tbaa [[TBAA0]]
; O2-NEXT:    [[INC5]] = add nuw i64 [[J_05]], 1
; O2-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC5]], [[NUMELEMS]]
; O2-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4]], !llvm.loop [[LOOP8:![0-9]+]]
;
; O3-LABEL: define {{[^@]+}}@_Z7computeRSt6vectorIiSaIiEEy
; O3-SAME: (ptr nocapture noundef nonnull readonly align 8 dereferenceable(24) [[DATA:%.*]], i64 noundef [[NUMELEMS:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; O3-NEXT:  entry:
; O3-NEXT:    [[CMP24_NOT:%.*]] = icmp eq i64 [[NUMELEMS]], 0
; O3-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DATA]], align 8
; O3-NEXT:    br i1 [[CMP24_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_COND1_PREHEADER_US_PREHEADER:%.*]]
; O3:       for.cond1.preheader.us.preheader:
; O3-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[NUMELEMS]], 8
; O3-NEXT:    [[N_VEC:%.*]] = and i64 [[NUMELEMS]], -8
; O3-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[NUMELEMS]]
; O3-NEXT:    br label [[FOR_COND1_PREHEADER_US:%.*]]
; O3:       for.cond1.preheader.us:
; O3-NEXT:    [[I_06_US:%.*]] = phi i64 [ [[INC7_US:%.*]], [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US:%.*]] ], [ 0, [[FOR_COND1_PREHEADER_US_PREHEADER]] ]
; O3-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[FOR_BODY4_US_PREHEADER:%.*]], label [[VECTOR_BODY:%.*]]
; O3:       vector.body:
; O3-NEXT:    [[INDEX:%.*]] = phi i64 [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ], [ 0, [[FOR_COND1_PREHEADER_US]] ]
; O3-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 [[INDEX]]
; O3-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP1]], align 4, !tbaa [[TBAA0:![0-9]+]]
; O3-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 4
; O3-NEXT:    [[WIDE_LOAD9:%.*]] = load <4 x i32>, ptr [[TMP2]], align 4, !tbaa [[TBAA0]]
; O3-NEXT:    [[TMP3:%.*]] = add nsw <4 x i32> [[WIDE_LOAD]], <i32 1, i32 1, i32 1, i32 1>
; O3-NEXT:    [[TMP4:%.*]] = add nsw <4 x i32> [[WIDE_LOAD9]], <i32 1, i32 1, i32 1, i32 1>
; O3-NEXT:    store <4 x i32> [[TMP3]], ptr [[TMP1]], align 4, !tbaa [[TBAA0]]
; O3-NEXT:    store <4 x i32> [[TMP4]], ptr [[TMP2]], align 4, !tbaa [[TBAA0]]
; O3-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; O3-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; O3-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; O3:       middle.block:
; O3-NEXT:    br i1 [[CMP_N]], label [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US]], label [[FOR_BODY4_US_PREHEADER]]
; O3:       for.body4.us.preheader:
; O3-NEXT:    [[J_05_US_PH:%.*]] = phi i64 [ 0, [[FOR_COND1_PREHEADER_US]] ], [ [[N_VEC]], [[MIDDLE_BLOCK]] ]
; O3-NEXT:    br label [[FOR_BODY4_US:%.*]]
; O3:       for.body4.us:
; O3-NEXT:    [[J_05_US:%.*]] = phi i64 [ [[INC5_US:%.*]], [[FOR_BODY4_US]] ], [ [[J_05_US_PH]], [[FOR_BODY4_US_PREHEADER]] ]
; O3-NEXT:    [[ADD_PTR_I_US:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 [[J_05_US]]
; O3-NEXT:    [[TMP6:%.*]] = load i32, ptr [[ADD_PTR_I_US]], align 4, !tbaa [[TBAA0]]
; O3-NEXT:    [[INC_US:%.*]] = add nsw i32 [[TMP6]], 1
; O3-NEXT:    store i32 [[INC_US]], ptr [[ADD_PTR_I_US]], align 4, !tbaa [[TBAA0]]
; O3-NEXT:    [[INC5_US]] = add nuw i64 [[J_05_US]], 1
; O3-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC5_US]], [[NUMELEMS]]
; O3-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US]], label [[FOR_BODY4_US]], !llvm.loop [[LOOP7:![0-9]+]]
; O3:       for.cond1.for.cond.cleanup3_crit_edge.us:
; O3-NEXT:    [[INC7_US]] = add nuw nsw i64 [[I_06_US]], 1
; O3-NEXT:    [[EXITCOND8_NOT:%.*]] = icmp eq i64 [[INC7_US]], 100
; O3-NEXT:    br i1 [[EXITCOND8_NOT]], label [[FOR_COND_CLEANUP]], label [[FOR_COND1_PREHEADER_US]], !llvm.loop [[LOOP9:![0-9]+]]
; O3:       for.cond.cleanup:
; O3-NEXT:    ret void
;
entry:
  %data.addr = alloca ptr, align 8
  %numElems.addr = alloca i64, align 8
  %i = alloca i64, align 8
  %cleanup.dest.slot = alloca i32, align 4
  %j = alloca i64, align 8
  store ptr %data, ptr %data.addr, align 8, !tbaa !3
  store i64 %numElems, ptr %numElems.addr, align 8, !tbaa !7
  call void @llvm.lifetime.start.p0(i64 8, ptr %i)
  store i64 0, ptr %i, align 8, !tbaa !7
  br label %for.cond

for.cond:
  %0 = load i64, ptr %i, align 8, !tbaa !7
  %cmp = icmp ult i64 %0, 100
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  store i32 2, ptr %cleanup.dest.slot, align 4
  call void @llvm.lifetime.end.p0(i64 8, ptr %i)
  br label %for.end8

for.body:
  call void @llvm.lifetime.start.p0(i64 8, ptr %j)
  store i64 0, ptr %j, align 8, !tbaa !7
  br label %for.cond1

for.cond1:
  %1 = load i64, ptr %j, align 8, !tbaa !7
  %2 = load i64, ptr %numElems.addr, align 8, !tbaa !7
  %cmp2 = icmp ult i64 %1, %2
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3

for.cond.cleanup3:
  store i32 5, ptr %cleanup.dest.slot, align 4
  call void @llvm.lifetime.end.p0(i64 8, ptr %j)
  br label %for.end

for.body4:
  %3 = load ptr, ptr %data.addr, align 8, !tbaa !3
  %4 = load i64, ptr %j, align 8, !tbaa !7
  %call = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEEixEm(ptr noundef nonnull align 8 dereferenceable(24) %3, i64 noundef %4)
  %5 = load i32, ptr %call, align 4, !tbaa !9
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %call, align 4, !tbaa !9
  br label %for.inc

for.inc:
  %6 = load i64, ptr %j, align 8, !tbaa !7
  %inc5 = add i64 %6, 1
  store i64 %inc5, ptr %j, align 8, !tbaa !7
  br label %for.cond1, !llvm.loop !11

for.end:
  br label %for.inc6

for.inc6:
  %7 = load i64, ptr %i, align 8, !tbaa !7
  %inc7 = add i64 %7, 1
  store i64 %inc7, ptr %i, align 8, !tbaa !7
  br label %for.cond, !llvm.loop !13

for.end8:
  ret void
}

declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)

define linkonce_odr dso_local noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEEixEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n) comdat align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %__n.addr = alloca i64, align 8
  store ptr %this, ptr %this.addr, align 8, !tbaa !3
  store i64 %__n, ptr %__n.addr, align 8, !tbaa !14
  %this1 = load ptr, ptr %this.addr, align 8
  %_M_start = getelementptr inbounds %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data", ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %_M_start, align 8, !tbaa !16
  %1 = load i64, ptr %__n.addr, align 8, !tbaa !14
  %add.ptr = getelementptr inbounds i32, ptr %0, i64 %1
  ret ptr %add.ptr
}

declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git 69297cf639044acf48dd5d9b39b95c54dd50561d)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"long long", !5, i64 0}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !5, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = distinct !{!13, !12}
!14 = !{!15, !15, i64 0}
!15 = !{!"long", !5, i64 0}
!16 = !{!17, !4, i64 0}
!17 = !{!"_ZTSNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataE", !4, i64 0, !4, i64 8, !4, i64 16}
