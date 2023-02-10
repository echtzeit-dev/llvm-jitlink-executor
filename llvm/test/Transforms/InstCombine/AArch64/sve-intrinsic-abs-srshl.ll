; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <vscale x 8 x i16> @srshl_abs_undef_merge(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_undef_merge(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_zero_merge(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_zero_merge(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_positive_merge(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_positive_merge(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer), <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %absmerge = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %absmerge, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_all_active_pred(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_all_active_pred(
; CHECK-NEXT:    [[PG:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> [[B:%.*]], <vscale x 8 x i1> [[PG]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %pg = tail call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_same_pred(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i1> %pg) #0 {
; CHECK-LABEL: @srshl_abs_same_pred(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> [[B:%.*]], <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_sqabs(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_sqabs(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.sqabs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.sqabs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_negative_merge(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_negative_merge(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 -1, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer), <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[SHR:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[SHR]]
;
  %absmerge = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 -1)
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %absmerge, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_nonconst_merge(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_nonconst_merge(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> [[B:%.*]], <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[SHR:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[SHR]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_not_all_active_pred(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_not_all_active_pred(
; CHECK-NEXT:    [[PG:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 8)
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> [[B:%.*]], <vscale x 8 x i1> [[PG]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[SHR:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[SHR]]
;
  %pg = tail call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 8)
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_diff_pred(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_diff_pred(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> [[B:%.*]], <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[SHR:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[SHR]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> %b, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

define <vscale x 8 x i16> @srshl_abs_negative_shift(<vscale x 8 x i16> %a, <vscale x 8 x i1> %pg, <vscale x 8 x i1> %pg2) #0 {
; CHECK-LABEL: @srshl_abs_negative_shift(
; CHECK-NEXT:    [[ABS:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> [[PG:%.*]], <vscale x 8 x i16> [[A:%.*]])
; CHECK-NEXT:    [[SHR:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> [[PG2:%.*]], <vscale x 8 x i16> [[ABS]], <vscale x 8 x i16> shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 -2, i64 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer))
; CHECK-NEXT:    ret <vscale x 8 x i16> [[SHR]]
;
  %abs = tail call <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16> undef, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %a)
  %splat = tail call <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16 -2)
  %shr = tail call <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1> %pg2, <vscale x 8 x i16> %abs, <vscale x 8 x i16> %splat)
  ret <vscale x 8 x i16> %shr
}

declare <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 immarg)
declare <vscale x 8 x i16> @llvm.aarch64.sve.dup.x.nxv8i16(i16)
declare <vscale x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.sqabs.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.srshl.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>)

attributes #0 = { "target-features"="+sve,+sve2" }
