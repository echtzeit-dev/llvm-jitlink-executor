; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 < %s | FileCheck %s

define i32 @mullohi_u32(i32 %arg, i32 %arg1, ptr %arg2) {
; CHECK-LABEL: mullohi_u32:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mad_u64_u32 v[0:1], s[4:5], v1, v0, 0
; CHECK-NEXT:    flat_store_dword v[2:3], v1
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i32 %arg to i64
  %i3 = zext i32 %arg1 to i64
  %i4 = mul nuw i64 %i3, %i
  %i5 = lshr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = trunc i64 %i4 to i32
  ret i32 %i7
}

define i32 @mullohi_s32(i32 %arg, i32 %arg1, ptr %arg2) {
; CHECK-LABEL: mullohi_s32:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mad_i64_i32 v[0:1], s[4:5], v1, v0, 0
; CHECK-NEXT:    flat_store_dword v[2:3], v1
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = sext i32 %arg to i64
  %i3 = sext i32 %arg1 to i64
  %i4 = mul nsw i64 %i3, %i
  %i5 = ashr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = trunc i64 %i4 to i32
  ret i32 %i7
}

define i32 @mullohi_u32_non_const_shift(i32 %arg, i32 %arg1, ptr %arg2, i64 %shift) {
; CHECK-LABEL: mullohi_u32_non_const_shift:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mad_u64_u32 v[5:6], s[4:5], v1, v0, 0
; CHECK-NEXT:    v_lshrrev_b64 v[0:1], v4, v[5:6]
; CHECK-NEXT:    flat_store_dword v[2:3], v6
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i32 %arg to i64
  %i3 = zext i32 %arg1 to i64
  %i4 = mul nuw i64 %i3, %i
  %i5 = lshr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = lshr i64 %i4, %shift
  %i8 = trunc i64 %i7 to i32
  ret i32 %i8
}

define <2 x i32> @mullohi_2xu32(<2 x i32> %arg, <2 x i32> %arg1, ptr %arg2) {
; CHECK-LABEL: mullohi_2xu32:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v6, v1
; CHECK-NEXT:    v_mad_u64_u32 v[0:1], s[4:5], v2, v0, 0
; CHECK-NEXT:    v_mad_u64_u32 v[2:3], s[4:5], v3, v6, 0
; CHECK-NEXT:    v_mov_b32_e32 v6, v1
; CHECK-NEXT:    v_mov_b32_e32 v7, v3
; CHECK-NEXT:    v_mov_b32_e32 v1, v2
; CHECK-NEXT:    flat_store_dwordx2 v[4:5], v[6:7]
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext <2 x i32> %arg to <2 x i64>
  %i3 = zext <2 x i32> %arg1 to <2 x i64>
  %i4 = mul nuw <2 x i64> %i3, %i
  %i5 = lshr <2 x i64> %i4, <i64 32, i64 32>
  %i6 = trunc <2 x i64> %i5 to <2 x i32>
  store <2 x i32> %i6, ptr %arg2, align 8
  %i7 = trunc <2 x i64> %i4 to <2 x i32>
  ret <2 x i32> %i7
}

define i8 @mullohi_illegal_ty(i8 %arg, i8 %arg1, ptr %arg2) {
; CHECK-LABEL: mullohi_illegal_ty:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mul_lo_u16_sdwa v0, v1, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_0 src1_sel:BYTE_0
; CHECK-NEXT:    v_lshrrev_b16_e32 v1, 8, v0
; CHECK-NEXT:    flat_store_byte v[2:3], v1
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i8 %arg to i16
  %i3 = zext i8 %arg1 to i16
  %i4 = mul nuw i16 %i3, %i
  %i5 = lshr i16 %i4, 8
  %i6 = trunc i16 %i5 to i8
  store i8 %i6, ptr %arg2, align 1
  %i7 = trunc i16 %i4 to i8
  ret i8 %i7
}

define i32 @mul_one_bit_low_hi_u32(i32 %arg, i32 %arg1, ptr %arg2) {
; CHECK-LABEL: mul_one_bit_low_hi_u32:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mad_u64_u32 v[0:1], s[4:5], v1, v0, 0
; CHECK-NEXT:    v_alignbit_b32 v0, v1, v0, 31
; CHECK-NEXT:    flat_store_dword v[2:3], v1
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i32 %arg to i64
  %i3 = zext i32 %arg1 to i64
  %i4 = mul nsw i64 %i3, %i
  %i5 = lshr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = lshr i64 %i4, 31
  %i8 = trunc i64 %i7 to i32
  ret i32 %i8
}

define i32 @mul_one_bit_hi_hi_u32_lshr_lshr(i32 %arg, i32 %arg1, ptr %arg2) {
; CHECK-LABEL: mul_one_bit_hi_hi_u32_lshr_lshr:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mul_hi_u32 v0, v1, v0
; CHECK-NEXT:    flat_store_dword v[2:3], v0
; CHECK-NEXT:    v_lshrrev_b32_e32 v0, 1, v0
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i32 %arg to i64
  %i3 = zext i32 %arg1 to i64
  %i4 = mul nsw i64 %i3, %i
  %i5 = lshr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = lshr i64 %i4, 33
  %i8 = trunc i64 %i7 to i32
  ret i32 %i8
}

define i32 @mul_one_bit_hi_hi_u32_lshr_ashr(i32 %arg, i32 %arg1, ptr %arg2) {
; CHECK-LABEL: mul_one_bit_hi_hi_u32_lshr_ashr:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mul_hi_u32 v4, v1, v0
; CHECK-NEXT:    v_ashrrev_i64 v[0:1], 33, v[3:4]
; CHECK-NEXT:    flat_store_dword v[2:3], v4
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  %i = zext i32 %arg to i64
  %i3 = zext i32 %arg1 to i64
  %i4 = mul nsw i64 %i3, %i
  %i5 = lshr i64 %i4, 32
  %i6 = trunc i64 %i5 to i32
  store i32 %i6, ptr %arg2, align 4
  %i7 = ashr i64 %i4, 33
  %i8 = trunc i64 %i7 to i32
  ret i32 %i8
}
