; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -force-vector-width=2 -force-vector-interleave=1 -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-linux-gnu"

%pair = type { ptr, ptr }

define void @test_pr55375_interleave_opaque_ptr(ptr %start, ptr %end) {
; CHECK-LABEL: @test_pr55375_interleave_opaque_ptr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[START2:%.*]] = ptrtoint ptr [[START:%.*]] to i64
; CHECK-NEXT:    [[END1:%.*]] = ptrtoint ptr [[END:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[END1]], -16
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 [[TMP0]], [[START2]]
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP1]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP3]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP3]], 2
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP3]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[N_VEC]], 16
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP4]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 16
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 16
; CHECK-NEXT:    [[NEXT_GEP3:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <2 x ptr> poison, ptr [[NEXT_GEP]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <2 x ptr> [[TMP9]], ptr [[NEXT_GEP3]], i32 1
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr ptr, ptr [[NEXT_GEP]], i32 0
; CHECK-NEXT:    [[TMP12:%.*]] = shufflevector <2 x ptr> zeroinitializer, <2 x ptr> [[TMP10]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[INTERLEAVED_VEC:%.*]] = shufflevector <4 x ptr> [[TMP12]], <4 x ptr> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
; CHECK-NEXT:    store <4 x ptr> [[INTERLEAVED_VEC]], ptr [[TMP11]], align 8
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP13]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP3]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi ptr [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_1:%.*]] = getelementptr inbounds [[PAIR:%.*]], ptr [[IV]], i64 0, i32 1
; CHECK-NEXT:    store ptr [[IV]], ptr [[IV_1]], align 8
; CHECK-NEXT:    store ptr null, ptr [[IV]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = getelementptr inbounds [[PAIR]], ptr [[IV]], i64 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq ptr [[IV_NEXT]], [[END]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi ptr [ %start, %entry ], [ %iv.next, %loop ]
  %iv.1 = getelementptr inbounds %pair, ptr %iv, i64 0, i32 1
  store ptr %iv, ptr %iv.1, align 8
  store ptr null, ptr %iv, align 8
  %iv.next = getelementptr inbounds %pair, ptr %iv, i64 1
  %ec = icmp eq ptr %iv.next, %end
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
