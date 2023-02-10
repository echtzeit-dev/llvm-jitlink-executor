; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x i32> @load_v4i32_align1(ptr %ptr) {
; CHECK-LABEL: load_v4i32_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    ret
  %z = load <4 x i32>, ptr %ptr, align 1
  ret <4 x i32> %z
}

define <4 x i32> @load_v4i32_align2(ptr %ptr) {
; CHECK-LABEL: load_v4i32_align2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    ret
  %z = load <4 x i32>, ptr %ptr, align 2
  ret <4 x i32> %z
}

define void @store_v4i32_align1(<4 x i32> %x, ptr %ptr) {
; CHECK-LABEL: store_v4i32_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <4 x i32> %x, ptr %ptr, align 1
  ret void
}

define void @store_v4i32_align2(<4 x i32> %x, ptr %ptr) {
; CHECK-LABEL: store_v4i32_align2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <4 x i32> %x, ptr %ptr, align 2
  ret void
}

declare <2 x i16> @llvm.masked.gather.v2i16.v2p0(<2 x ptr>, i32, <2 x i1>, <2 x i16>)

define <2 x i16> @mgather_v2i16_align1(<2 x ptr> %ptrs, <2 x i1> %m, <2 x i16> %passthru) {
; RV32-LABEL: mgather_v2i16_align1:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV32-NEXT:    vmv.x.s a0, v0
; RV32-NEXT:    andi a1, a0, 1
; RV32-NEXT:    bnez a1, .LBB4_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    bnez a0, .LBB4_4
; RV32-NEXT:  .LBB4_2: # %else2
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB4_3: # %cond.load
; RV32-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    lb a2, 1(a1)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    slli a2, a2, 8
; RV32-NEXT:    or a1, a2, a1
; RV32-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; RV32-NEXT:    vmv.s.x v9, a1
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    beqz a0, .LBB4_2
; RV32-NEXT:  .LBB4_4: # %cond.load1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 1
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    lb a1, 1(a0)
; RV32-NEXT:    lbu a0, 0(a0)
; RV32-NEXT:    slli a1, a1, 8
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    vmv.s.x v8, a0
; RV32-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: mgather_v2i16_align1:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV64-NEXT:    vmv.x.s a0, v0
; RV64-NEXT:    andi a1, a0, 1
; RV64-NEXT:    bnez a1, .LBB4_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    bnez a0, .LBB4_4
; RV64-NEXT:  .LBB4_2: # %else2
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB4_3: # %cond.load
; RV64-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    lb a2, 1(a1)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    slli a2, a2, 8
; RV64-NEXT:    or a1, a2, a1
; RV64-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; RV64-NEXT:    vmv.s.x v9, a1
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    beqz a0, .LBB4_2
; RV64-NEXT:  .LBB4_4: # %cond.load1
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 1
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    lb a1, 1(a0)
; RV64-NEXT:    lbu a0, 0(a0)
; RV64-NEXT:    slli a1, a1, 8
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    vmv.s.x v8, a0
; RV64-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV64-NEXT:    vslideup.vi v9, v8, 1
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %v = call <2 x i16> @llvm.masked.gather.v2i16.v2p0(<2 x ptr> %ptrs, i32 1, <2 x i1> %m, <2 x i16> %passthru)
  ret <2 x i16> %v
}

declare <2 x i64> @llvm.masked.gather.v2i64.v2p0(<2 x ptr>, i32, <2 x i1>, <2 x i64>)

define <2 x i64> @mgather_v2i64_align4(<2 x ptr> %ptrs, <2 x i1> %m, <2 x i64> %passthru) {
; RV32-LABEL: mgather_v2i64_align4:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV32-NEXT:    vmv.x.s a0, v0
; RV32-NEXT:    andi a1, a0, 1
; RV32-NEXT:    bnez a1, .LBB5_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    bnez a0, .LBB5_4
; RV32-NEXT:  .LBB5_2: # %else2
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB5_3: # %cond.load
; RV32-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    lw a2, 0(a1)
; RV32-NEXT:    lw a1, 4(a1)
; RV32-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; RV32-NEXT:    vslide1down.vx v9, v9, a2
; RV32-NEXT:    vslide1down.vx v9, v9, a1
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    beqz a0, .LBB5_2
; RV32-NEXT:  .LBB5_4: # %cond.load1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 1
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    lw a1, 0(a0)
; RV32-NEXT:    lw a0, 4(a0)
; RV32-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; RV32-NEXT:    vslide1down.vx v8, v8, a1
; RV32-NEXT:    vslide1down.vx v8, v8, a0
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: mgather_v2i64_align4:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV64-NEXT:    vmv.x.s a0, v0
; RV64-NEXT:    andi a1, a0, 1
; RV64-NEXT:    bnez a1, .LBB5_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    bnez a0, .LBB5_4
; RV64-NEXT:  .LBB5_2: # %else2
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB5_3: # %cond.load
; RV64-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    lwu a2, 4(a1)
; RV64-NEXT:    lwu a1, 0(a1)
; RV64-NEXT:    slli a2, a2, 32
; RV64-NEXT:    or a1, a2, a1
; RV64-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; RV64-NEXT:    vmv.s.x v9, a1
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    beqz a0, .LBB5_2
; RV64-NEXT:  .LBB5_4: # %cond.load1
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 1
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    lwu a1, 4(a0)
; RV64-NEXT:    lwu a0, 0(a0)
; RV64-NEXT:    slli a1, a1, 32
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    vmv.s.x v8, a0
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vslideup.vi v9, v8, 1
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %v = call <2 x i64> @llvm.masked.gather.v2i64.v2p0(<2 x ptr> %ptrs, i32 4, <2 x i1> %m, <2 x i64> %passthru)
  ret <2 x i64> %v
}

declare void @llvm.masked.scatter.v4i16.v4p0(<4 x i16>, <4 x ptr>, i32, <4 x i1>)

define void @mscatter_v4i16_align1(<4 x i16> %val, <4 x ptr> %ptrs, <4 x i1> %m) {
; RV32-LABEL: mscatter_v4i16_align1:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV32-NEXT:    vmv.x.s a0, v0
; RV32-NEXT:    andi a1, a0, 1
; RV32-NEXT:    bnez a1, .LBB6_5
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a1, a0, 2
; RV32-NEXT:    bnez a1, .LBB6_6
; RV32-NEXT:  .LBB6_2: # %else2
; RV32-NEXT:    andi a1, a0, 4
; RV32-NEXT:    bnez a1, .LBB6_7
; RV32-NEXT:  .LBB6_3: # %else4
; RV32-NEXT:    andi a0, a0, 8
; RV32-NEXT:    bnez a0, .LBB6_8
; RV32-NEXT:  .LBB6_4: # %else6
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB6_5: # %cond.store
; RV32-NEXT:    vsetivli zero, 0, e16, mf2, ta, ma
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; RV32-NEXT:    vmv.x.s a2, v9
; RV32-NEXT:    sb a1, 0(a2)
; RV32-NEXT:    srli a1, a1, 8
; RV32-NEXT:    sb a1, 1(a2)
; RV32-NEXT:    andi a1, a0, 2
; RV32-NEXT:    beqz a1, .LBB6_2
; RV32-NEXT:  .LBB6_6: # %cond.store1
; RV32-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v10, v8, 1
; RV32-NEXT:    vmv.x.s a1, v10
; RV32-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v10, v9, 1
; RV32-NEXT:    vmv.x.s a2, v10
; RV32-NEXT:    sb a1, 0(a2)
; RV32-NEXT:    srli a1, a1, 8
; RV32-NEXT:    sb a1, 1(a2)
; RV32-NEXT:    andi a1, a0, 4
; RV32-NEXT:    beqz a1, .LBB6_3
; RV32-NEXT:  .LBB6_7: # %cond.store3
; RV32-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v10, v8, 2
; RV32-NEXT:    vmv.x.s a1, v10
; RV32-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v10, v9, 2
; RV32-NEXT:    vmv.x.s a2, v10
; RV32-NEXT:    sb a1, 0(a2)
; RV32-NEXT:    srli a1, a1, 8
; RV32-NEXT:    sb a1, 1(a2)
; RV32-NEXT:    andi a0, a0, 8
; RV32-NEXT:    beqz a0, .LBB6_4
; RV32-NEXT:  .LBB6_8: # %cond.store5
; RV32-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 3
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v9, 3
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    sb a0, 0(a1)
; RV32-NEXT:    srli a0, a0, 8
; RV32-NEXT:    sb a0, 1(a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: mscatter_v4i16_align1:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV64-NEXT:    vmv.x.s a0, v0
; RV64-NEXT:    andi a1, a0, 1
; RV64-NEXT:    bnez a1, .LBB6_5
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a1, a0, 2
; RV64-NEXT:    bnez a1, .LBB6_6
; RV64-NEXT:  .LBB6_2: # %else2
; RV64-NEXT:    andi a1, a0, 4
; RV64-NEXT:    bnez a1, .LBB6_7
; RV64-NEXT:  .LBB6_3: # %else4
; RV64-NEXT:    andi a0, a0, 8
; RV64-NEXT:    bnez a0, .LBB6_8
; RV64-NEXT:  .LBB6_4: # %else6
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB6_5: # %cond.store
; RV64-NEXT:    vsetivli zero, 0, e16, mf2, ta, ma
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV64-NEXT:    vmv.x.s a2, v10
; RV64-NEXT:    sb a1, 0(a2)
; RV64-NEXT:    srli a1, a1, 8
; RV64-NEXT:    sb a1, 1(a2)
; RV64-NEXT:    andi a1, a0, 2
; RV64-NEXT:    beqz a1, .LBB6_2
; RV64-NEXT:  .LBB6_6: # %cond.store1
; RV64-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV64-NEXT:    vslidedown.vi v9, v8, 1
; RV64-NEXT:    vmv.x.s a1, v9
; RV64-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v12, v10, 1
; RV64-NEXT:    vmv.x.s a2, v12
; RV64-NEXT:    sb a1, 0(a2)
; RV64-NEXT:    srli a1, a1, 8
; RV64-NEXT:    sb a1, 1(a2)
; RV64-NEXT:    andi a1, a0, 4
; RV64-NEXT:    beqz a1, .LBB6_3
; RV64-NEXT:  .LBB6_7: # %cond.store3
; RV64-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV64-NEXT:    vslidedown.vi v9, v8, 2
; RV64-NEXT:    vmv.x.s a1, v9
; RV64-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v12, v10, 2
; RV64-NEXT:    vmv.x.s a2, v12
; RV64-NEXT:    sb a1, 0(a2)
; RV64-NEXT:    srli a1, a1, 8
; RV64-NEXT:    sb a1, 1(a2)
; RV64-NEXT:    andi a0, a0, 8
; RV64-NEXT:    beqz a0, .LBB6_4
; RV64-NEXT:  .LBB6_8: # %cond.store5
; RV64-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 3
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v10, 3
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    sb a0, 0(a1)
; RV64-NEXT:    srli a0, a0, 8
; RV64-NEXT:    sb a0, 1(a1)
; RV64-NEXT:    ret
  call void @llvm.masked.scatter.v4i16.v4p0(<4 x i16> %val, <4 x ptr> %ptrs, i32 1, <4 x i1> %m)
  ret void
}

declare void @llvm.masked.scatter.v2i32.v2p0(<2 x i32>, <2 x ptr>, i32, <2 x i1>)

define void @mscatter_v2i32_align2(<2 x i32> %val, <2 x ptr> %ptrs, <2 x i1> %m) {
; RV32-LABEL: mscatter_v2i32_align2:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV32-NEXT:    vmv.x.s a0, v0
; RV32-NEXT:    andi a1, a0, 1
; RV32-NEXT:    bnez a1, .LBB7_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    bnez a0, .LBB7_4
; RV32-NEXT:  .LBB7_2: # %else2
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB7_3: # %cond.store
; RV32-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    vmv.x.s a2, v9
; RV32-NEXT:    sh a1, 0(a2)
; RV32-NEXT:    srli a1, a1, 16
; RV32-NEXT:    sh a1, 2(a2)
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    beqz a0, .LBB7_2
; RV32-NEXT:  .LBB7_4: # %cond.store1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 1
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    vslidedown.vi v8, v9, 1
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    sh a0, 0(a1)
; RV32-NEXT:    srli a0, a0, 16
; RV32-NEXT:    sh a0, 2(a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: mscatter_v2i32_align2:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 0, e8, mf8, ta, ma
; RV64-NEXT:    vmv.x.s a0, v0
; RV64-NEXT:    andi a1, a0, 1
; RV64-NEXT:    bnez a1, .LBB7_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    bnez a0, .LBB7_4
; RV64-NEXT:  .LBB7_2: # %else2
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB7_3: # %cond.store
; RV64-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; RV64-NEXT:    vmv.x.s a2, v9
; RV64-NEXT:    sh a1, 0(a2)
; RV64-NEXT:    srli a1, a1, 16
; RV64-NEXT:    sh a1, 2(a2)
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    beqz a0, .LBB7_2
; RV64-NEXT:  .LBB7_4: # %cond.store1
; RV64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 1
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v9, 1
; RV64-NEXT:    vmv.x.s a1, v8
; RV64-NEXT:    sh a0, 0(a1)
; RV64-NEXT:    srli a0, a0, 16
; RV64-NEXT:    sh a0, 2(a1)
; RV64-NEXT:    ret
  call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> %val, <2 x ptr> %ptrs, i32 2, <2 x i1> %m)
  ret void
}

declare <2 x i32> @llvm.masked.load.v2i32(ptr, i32, <2 x i1>, <2 x i32>)

define void @masked_load_v2i32_align1(ptr %a, <2 x i32> %m, ptr %res_ptr) nounwind {
; RV32-LABEL: masked_load_v2i32_align1:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmseq.vi v8, v8, 0
; RV32-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV32-NEXT:    vmv.x.s a2, v8
; RV32-NEXT:    andi a3, a2, 1
; RV32-NEXT:    beqz a3, .LBB8_2
; RV32-NEXT:  # %bb.1: # %cond.load
; RV32-NEXT:    lbu a3, 1(a0)
; RV32-NEXT:    lbu a4, 0(a0)
; RV32-NEXT:    lbu a5, 2(a0)
; RV32-NEXT:    lbu a6, 3(a0)
; RV32-NEXT:    slli a3, a3, 8
; RV32-NEXT:    or a3, a3, a4
; RV32-NEXT:    slli a5, a5, 16
; RV32-NEXT:    slli a6, a6, 24
; RV32-NEXT:    or a4, a6, a5
; RV32-NEXT:    or a3, a4, a3
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v8, a3
; RV32-NEXT:    andi a2, a2, 2
; RV32-NEXT:    bnez a2, .LBB8_3
; RV32-NEXT:    j .LBB8_4
; RV32-NEXT:  .LBB8_2:
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    andi a2, a2, 2
; RV32-NEXT:    beqz a2, .LBB8_4
; RV32-NEXT:  .LBB8_3: # %cond.load1
; RV32-NEXT:    lbu a2, 5(a0)
; RV32-NEXT:    lbu a3, 4(a0)
; RV32-NEXT:    lbu a4, 6(a0)
; RV32-NEXT:    lbu a0, 7(a0)
; RV32-NEXT:    slli a2, a2, 8
; RV32-NEXT:    or a2, a2, a3
; RV32-NEXT:    slli a4, a4, 16
; RV32-NEXT:    slli a0, a0, 24
; RV32-NEXT:    or a0, a0, a4
; RV32-NEXT:    or a0, a0, a2
; RV32-NEXT:    vmv.s.x v9, a0
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:  .LBB8_4: # %else2
; RV32-NEXT:    vse32.v v8, (a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: masked_load_v2i32_align1:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vmseq.vi v8, v8, 0
; RV64-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV64-NEXT:    vmv.x.s a2, v8
; RV64-NEXT:    andi a3, a2, 1
; RV64-NEXT:    beqz a3, .LBB8_2
; RV64-NEXT:  # %bb.1: # %cond.load
; RV64-NEXT:    lbu a3, 1(a0)
; RV64-NEXT:    lbu a4, 0(a0)
; RV64-NEXT:    lbu a5, 2(a0)
; RV64-NEXT:    lb a6, 3(a0)
; RV64-NEXT:    slli a3, a3, 8
; RV64-NEXT:    or a3, a3, a4
; RV64-NEXT:    slli a5, a5, 16
; RV64-NEXT:    slli a6, a6, 24
; RV64-NEXT:    or a4, a6, a5
; RV64-NEXT:    or a3, a4, a3
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v8, a3
; RV64-NEXT:    andi a2, a2, 2
; RV64-NEXT:    bnez a2, .LBB8_3
; RV64-NEXT:    j .LBB8_4
; RV64-NEXT:  .LBB8_2:
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    andi a2, a2, 2
; RV64-NEXT:    beqz a2, .LBB8_4
; RV64-NEXT:  .LBB8_3: # %cond.load1
; RV64-NEXT:    lbu a2, 5(a0)
; RV64-NEXT:    lbu a3, 4(a0)
; RV64-NEXT:    lbu a4, 6(a0)
; RV64-NEXT:    lb a0, 7(a0)
; RV64-NEXT:    slli a2, a2, 8
; RV64-NEXT:    or a2, a2, a3
; RV64-NEXT:    slli a4, a4, 16
; RV64-NEXT:    slli a0, a0, 24
; RV64-NEXT:    or a0, a0, a4
; RV64-NEXT:    or a0, a0, a2
; RV64-NEXT:    vmv.s.x v9, a0
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:  .LBB8_4: # %else2
; RV64-NEXT:    vse32.v v8, (a1)
; RV64-NEXT:    ret
  %mask = icmp eq <2 x i32> %m, zeroinitializer
  %load = call <2 x i32> @llvm.masked.load.v2i32(ptr %a, i32 1, <2 x i1> %mask, <2 x i32> undef)
  store <2 x i32> %load, ptr %res_ptr
  ret void
}

declare void @llvm.masked.store.v2i32.p0(<2 x i32>, ptr, i32, <2 x i1>)

define void @masked_store_v2i32_align2(<2 x i32> %val, ptr %a, <2 x i32> %m) nounwind {
; CHECK-LABEL: masked_store_v2i32_align2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vmseq.vi v9, v9, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.x.s a1, v9
; CHECK-NEXT:    andi a2, a1, 1
; CHECK-NEXT:    bnez a2, .LBB9_3
; CHECK-NEXT:  # %bb.1: # %else
; CHECK-NEXT:    andi a1, a1, 2
; CHECK-NEXT:    bnez a1, .LBB9_4
; CHECK-NEXT:  .LBB9_2: # %else2
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB9_3: # %cond.store
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.x.s a2, v8
; CHECK-NEXT:    sh a2, 0(a0)
; CHECK-NEXT:    srli a2, a2, 16
; CHECK-NEXT:    sh a2, 2(a0)
; CHECK-NEXT:    andi a1, a1, 2
; CHECK-NEXT:    beqz a1, .LBB9_2
; CHECK-NEXT:  .LBB9_4: # %cond.store1
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    sh a1, 4(a0)
; CHECK-NEXT:    srli a1, a1, 16
; CHECK-NEXT:    sh a1, 6(a0)
; CHECK-NEXT:    ret
  %mask = icmp eq <2 x i32> %m, zeroinitializer
  call void @llvm.masked.store.v2i32.p0(<2 x i32> %val, ptr %a, i32 2, <2 x i1> %mask)
  ret void
}
