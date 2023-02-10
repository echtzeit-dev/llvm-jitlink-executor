; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='default<O3>' -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv6m-none-none-eabi"

; Make sure we don't make a mess of vectorization/unrolling of the remainder loop.

define void @arm_mean_q7(ptr noundef %pSrc, i32 noundef %blockSize, ptr noundef %pResult) #0 {
; CHECK-LABEL: @arm_mean_q7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_NOT10:%.*]] = icmp ult i32 [[BLOCKSIZE:%.*]], 16
; CHECK-NEXT:    br i1 [[CMP_NOT10]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[BLOCKSIZE]], 4
; CHECK-NEXT:    [[TMP0:%.*]] = and i32 [[BLOCKSIZE]], -16
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[SUM_013:%.*]] = phi i32 [ [[TMP3:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PSRC_ADDR_012:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[WHILE_BODY]] ], [ [[PSRC:%.*]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BLKCNT_011:%.*]] = phi i32 [ [[DEC:%.*]], [[WHILE_BODY]] ], [ [[SHR]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = load <16 x i8>, ptr [[PSRC_ADDR_012]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i32 @llvm.arm.mve.addv.v16i8(<16 x i8> [[TMP1]], i32 0)
; CHECK-NEXT:    [[TMP3]] = add i32 [[TMP2]], [[SUM_013]]
; CHECK-NEXT:    [[DEC]] = add nsw i32 [[BLKCNT_011]], -1
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds i8, ptr [[PSRC_ADDR_012]], i32 16
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[DEC]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[PSRC]], i32 [[TMP0]]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    [[PSRC_ADDR_0_LCSSA:%.*]] = phi ptr [ [[PSRC]], [[ENTRY:%.*]] ], [ [[UGLYGEP]], [[WHILE_END_LOOPEXIT]] ]
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP3]], [[WHILE_END_LOOPEXIT]] ]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[BLOCKSIZE]], 15
; CHECK-NEXT:    [[CMP2_NOT15:%.*]] = icmp eq i32 [[AND]], 0
; CHECK-NEXT:    br i1 [[CMP2_NOT15]], label [[WHILE_END5:%.*]], label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = tail call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 0, i32 [[AND]])
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = tail call <16 x i8> @llvm.masked.load.v16i8.p0(ptr [[PSRC_ADDR_0_LCSSA]], i32 1, <16 x i1> [[ACTIVE_LANE_MASK]], <16 x i8> poison)
; CHECK-NEXT:    [[TMP4:%.*]] = sext <16 x i8> [[WIDE_MASKED_LOAD]] to <16 x i32>
; CHECK-NEXT:    [[TMP5:%.*]] = select <16 x i1> [[ACTIVE_LANE_MASK]], <16 x i32> [[TMP4]], <16 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[TMP5]])
; CHECK-NEXT:    [[TMP7:%.*]] = add i32 [[TMP6]], [[SUM_0_LCSSA]]
; CHECK-NEXT:    br label [[WHILE_END5]]
; CHECK:       while.end5:
; CHECK-NEXT:    [[SUM_1_LCSSA:%.*]] = phi i32 [ [[SUM_0_LCSSA]], [[WHILE_END]] ], [ [[TMP7]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[SUM_1_LCSSA]], [[BLOCKSIZE]]
; CHECK-NEXT:    [[CONV6:%.*]] = trunc i32 [[DIV]] to i8
; CHECK-NEXT:    store i8 [[CONV6]], ptr [[PRESULT:%.*]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %pSrc.addr = alloca ptr, align 4
  %blockSize.addr = alloca i32, align 4
  %pResult.addr = alloca ptr, align 4
  %blkCnt = alloca i32, align 4
  %vecSrc = alloca <16 x i8>, align 1
  %sum = alloca i32, align 4
  store ptr %pSrc, ptr %pSrc.addr, align 4
  store i32 %blockSize, ptr %blockSize.addr, align 4
  store ptr %pResult, ptr %pResult.addr, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr %blkCnt) #3
  call void @llvm.lifetime.start.p0(i64 16, ptr %vecSrc) #3
  call void @llvm.lifetime.start.p0(i64 4, ptr %sum) #3
  store i32 0, ptr %sum, align 4
  %0 = load i32, ptr %blockSize.addr, align 4
  %shr = lshr i32 %0, 4
  store i32 %shr, ptr %blkCnt, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %1 = load i32, ptr %blkCnt, align 4
  %cmp = icmp ugt i32 %1, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load ptr, ptr %pSrc.addr, align 4
  %3 = load <16 x i8>, ptr %2, align 1
  store <16 x i8> %3, ptr %vecSrc, align 1
  %4 = load <16 x i8>, ptr %vecSrc, align 1
  %5 = call i32 @llvm.arm.mve.addv.v16i8(<16 x i8> %4, i32 0)
  %6 = load i32, ptr %sum, align 4
  %7 = add i32 %5, %6
  store i32 %7, ptr %sum, align 4
  %8 = load i32, ptr %blkCnt, align 4
  %dec = add i32 %8, -1
  store i32 %dec, ptr %blkCnt, align 4
  %9 = load ptr, ptr %pSrc.addr, align 4
  %add.ptr = getelementptr inbounds i8, ptr %9, i32 16
  store ptr %add.ptr, ptr %pSrc.addr, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %10 = load i32, ptr %blockSize.addr, align 4
  %and = and i32 %10, 15
  store i32 %and, ptr %blkCnt, align 4
  br label %while.cond1

while.cond1:                                      ; preds = %while.body3, %while.end
  %11 = load i32, ptr %blkCnt, align 4
  %cmp2 = icmp ugt i32 %11, 0
  br i1 %cmp2, label %while.body3, label %while.end5

while.body3:                                      ; preds = %while.cond1
  %12 = load ptr, ptr %pSrc.addr, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %12, i32 1
  store ptr %incdec.ptr, ptr %pSrc.addr, align 4
  %13 = load i8, ptr %12, align 1
  %conv = sext i8 %13 to i32
  %14 = load i32, ptr %sum, align 4
  %add = add nsw i32 %14, %conv
  store i32 %add, ptr %sum, align 4
  %15 = load i32, ptr %blkCnt, align 4
  %dec4 = add i32 %15, -1
  store i32 %dec4, ptr %blkCnt, align 4
  br label %while.cond1

while.end5:                                       ; preds = %while.cond1
  %16 = load i32, ptr %sum, align 4
  %17 = load i32, ptr %blockSize.addr, align 4
  %div = sdiv i32 %16, %17
  %conv6 = trunc i32 %div to i8
  %18 = load ptr, ptr %pResult.addr, align 4
  store i8 %conv6, ptr %18, align 1
  call void @llvm.lifetime.end.p0(i64 4, ptr %sum) #3
  call void @llvm.lifetime.end.p0(i64 16, ptr %vecSrc) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr %blkCnt) #3
  ret void
}

declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1
declare i32 @llvm.arm.mve.addv.v16i8(<16 x i8>, i32) #2
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

attributes #0 = { nounwind "approx-func-fp-math"="true" "frame-pointer"="all" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m55" "target-features"="+armv8.1-m.main,+dsp,+fp-armv8d16,+fp-armv8d16sp,+fp16,+fp64,+fullfp16,+hwdiv,+lob,+mve,+mve.fp,+ras,+strict-align,+thumb-mode,+vfp2,+vfp2sp,+vfp3d16,+vfp3d16sp,+vfp4d16,+vfp4d16sp,-aes,-bf16,-cdecp0,-cdecp1,-cdecp2,-cdecp3,-cdecp4,-cdecp5,-cdecp6,-cdecp7,-crc,-crypto,-d32,-dotprod,-fp-armv8,-fp-armv8sp,-fp16fml,-hwdiv-arm,-i8mm,-neon,-pacbti,-sb,-sha2,-vfp3,-vfp3sp,-vfp4,-vfp4sp" "unsafe-fp-math"="true" }
attributes #1 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }
