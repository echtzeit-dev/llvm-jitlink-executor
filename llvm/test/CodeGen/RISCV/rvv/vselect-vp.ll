; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+m,+zfh,+experimental-zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+m,+zfh,+experimental-zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x i1> @llvm.vp.select.nxv1i1(<vscale x 1 x i1>, <vscale x 1 x i1>, <vscale x 1 x i1>, i32)

define <vscale x 1 x i1> @select_nxv1i1(<vscale x 1 x i1> %a, <vscale x 1 x i1> %b, <vscale x 1 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i1> @llvm.vp.select.nxv1i1(<vscale x 1 x i1> %a, <vscale x 1 x i1> %b, <vscale x 1 x i1> %c, i32 %evl)
  ret <vscale x 1 x i1> %v
}

declare <vscale x 2 x i1> @llvm.vp.select.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i1> @select_nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %b, <vscale x 2 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.select.nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %b, <vscale x 2 x i1> %c, i32 %evl)
  ret <vscale x 2 x i1> %v
}

declare <vscale x 4 x i1> @llvm.vp.select.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>, <vscale x 4 x i1>, i32)

define <vscale x 4 x i1> @select_nxv4i1(<vscale x 4 x i1> %a, <vscale x 4 x i1> %b, <vscale x 4 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i1> @llvm.vp.select.nxv4i1(<vscale x 4 x i1> %a, <vscale x 4 x i1> %b, <vscale x 4 x i1> %c, i32 %evl)
  ret <vscale x 4 x i1> %v
}

declare <vscale x 8 x i1> @llvm.vp.select.nxv8i1(<vscale x 8 x i1>, <vscale x 8 x i1>, <vscale x 8 x i1>, i32)

define <vscale x 8 x i1> @select_nxv8i1(<vscale x 8 x i1> %a, <vscale x 8 x i1> %b, <vscale x 8 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i1> @llvm.vp.select.nxv8i1(<vscale x 8 x i1> %a, <vscale x 8 x i1> %b, <vscale x 8 x i1> %c, i32 %evl)
  ret <vscale x 8 x i1> %v
}

declare <vscale x 16 x i1> @llvm.vp.select.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, i32)

define <vscale x 16 x i1> @select_nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b, <vscale x 16 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i1> @llvm.vp.select.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b, <vscale x 16 x i1> %c, i32 %evl)
  ret <vscale x 16 x i1> %v
}

declare <vscale x 32 x i1> @llvm.vp.select.nxv32i1(<vscale x 32 x i1>, <vscale x 32 x i1>, <vscale x 32 x i1>, i32)

define <vscale x 32 x i1> @select_nxv32i1(<vscale x 32 x i1> %a, <vscale x 32 x i1> %b, <vscale x 32 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i1> @llvm.vp.select.nxv32i1(<vscale x 32 x i1> %a, <vscale x 32 x i1> %b, <vscale x 32 x i1> %c, i32 %evl)
  ret <vscale x 32 x i1> %v
}

declare <vscale x 64 x i1> @llvm.vp.select.nxv64i1(<vscale x 64 x i1>, <vscale x 64 x i1>, <vscale x 64 x i1>, i32)

define <vscale x 64 x i1> @select_nxv64i1(<vscale x 64 x i1> %a, <vscale x 64 x i1> %b, <vscale x 64 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i1> @llvm.vp.select.nxv64i1(<vscale x 64 x i1> %a, <vscale x 64 x i1> %b, <vscale x 64 x i1> %c, i32 %evl)
  ret <vscale x 64 x i1> %v
}

declare <vscale x 8 x i7> @llvm.vp.select.nxv8i7(<vscale x 8 x i1>, <vscale x 8 x i7>, <vscale x 8 x i7>, i32)

define <vscale x 8 x i7> @select_nxv8i7(<vscale x 8 x i1> %a, <vscale x 8 x i7> %b, <vscale x 8 x i7> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i7> @llvm.vp.select.nxv8i7(<vscale x 8 x i1> %a, <vscale x 8 x i7> %b, <vscale x 8 x i7> %c, i32 %evl)
  ret <vscale x 8 x i7> %v
}

declare <vscale x 1 x i8> @llvm.vp.select.nxv1i8(<vscale x 1 x i1>, <vscale x 1 x i8>, <vscale x 1 x i8>, i32)

define <vscale x 1 x i8> @select_nxv1i8(<vscale x 1 x i1> %a, <vscale x 1 x i8> %b, <vscale x 1 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.vp.select.nxv1i8(<vscale x 1 x i1> %a, <vscale x 1 x i8> %b, <vscale x 1 x i8> %c, i32 %evl)
  ret <vscale x 1 x i8> %v
}

declare <vscale x 2 x i8> @llvm.vp.select.nxv2i8(<vscale x 2 x i1>, <vscale x 2 x i8>, <vscale x 2 x i8>, i32)

define <vscale x 2 x i8> @select_nxv2i8(<vscale x 2 x i1> %a, <vscale x 2 x i8> %b, <vscale x 2 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.select.nxv2i8(<vscale x 2 x i1> %a, <vscale x 2 x i8> %b, <vscale x 2 x i8> %c, i32 %evl)
  ret <vscale x 2 x i8> %v
}

declare <vscale x 4 x i8> @llvm.vp.select.nxv4i8(<vscale x 4 x i1>, <vscale x 4 x i8>, <vscale x 4 x i8>, i32)

define <vscale x 4 x i8> @select_nxv4i8(<vscale x 4 x i1> %a, <vscale x 4 x i8> %b, <vscale x 4 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.vp.select.nxv4i8(<vscale x 4 x i1> %a, <vscale x 4 x i8> %b, <vscale x 4 x i8> %c, i32 %evl)
  ret <vscale x 4 x i8> %v
}

declare <vscale x 8 x i8> @llvm.vp.select.nxv8i8(<vscale x 8 x i1>, <vscale x 8 x i8>, <vscale x 8 x i8>, i32)

define <vscale x 8 x i8> @select_nxv8i8(<vscale x 8 x i1> %a, <vscale x 8 x i8> %b, <vscale x 8 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.vp.select.nxv8i8(<vscale x 8 x i1> %a, <vscale x 8 x i8> %b, <vscale x 8 x i8> %c, i32 %evl)
  ret <vscale x 8 x i8> %v
}

declare <vscale x 14 x i8> @llvm.vp.select.nxv14i8(<vscale x 14 x i1>, <vscale x 14 x i8>, <vscale x 14 x i8>, i32)

define <vscale x 14 x i8> @select_nxv14i8(<vscale x 14 x i1> %a, <vscale x 14 x i8> %b, <vscale x 14 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv14i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 14 x i8> @llvm.vp.select.nxv14i8(<vscale x 14 x i1> %a, <vscale x 14 x i8> %b, <vscale x 14 x i8> %c, i32 %evl)
  ret <vscale x 14 x i8> %v
}

declare <vscale x 16 x i8> @llvm.vp.select.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>, i32)

define <vscale x 16 x i8> @select_nxv16i8(<vscale x 16 x i1> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.vp.select.nxv16i8(<vscale x 16 x i1> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c, i32 %evl)
  ret <vscale x 16 x i8> %v
}

declare <vscale x 32 x i8> @llvm.vp.select.nxv32i8(<vscale x 32 x i1>, <vscale x 32 x i8>, <vscale x 32 x i8>, i32)

define <vscale x 32 x i8> @select_nxv32i8(<vscale x 32 x i1> %a, <vscale x 32 x i8> %b, <vscale x 32 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.vp.select.nxv32i8(<vscale x 32 x i1> %a, <vscale x 32 x i8> %b, <vscale x 32 x i8> %c, i32 %evl)
  ret <vscale x 32 x i8> %v
}

declare <vscale x 64 x i8> @llvm.vp.select.nxv64i8(<vscale x 64 x i1>, <vscale x 64 x i8>, <vscale x 64 x i8>, i32)

define <vscale x 64 x i8> @select_nxv64i8(<vscale x 64 x i1> %a, <vscale x 64 x i8> %b, <vscale x 64 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.vp.select.nxv64i8(<vscale x 64 x i1> %a, <vscale x 64 x i8> %b, <vscale x 64 x i8> %c, i32 %evl)
  ret <vscale x 64 x i8> %v
}

declare <vscale x 1 x i16> @llvm.vp.select.nxv1i16(<vscale x 1 x i1>, <vscale x 1 x i16>, <vscale x 1 x i16>, i32)

define <vscale x 1 x i16> @select_nxv1i16(<vscale x 1 x i1> %a, <vscale x 1 x i16> %b, <vscale x 1 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.vp.select.nxv1i16(<vscale x 1 x i1> %a, <vscale x 1 x i16> %b, <vscale x 1 x i16> %c, i32 %evl)
  ret <vscale x 1 x i16> %v
}

declare <vscale x 2 x i16> @llvm.vp.select.nxv2i16(<vscale x 2 x i1>, <vscale x 2 x i16>, <vscale x 2 x i16>, i32)

define <vscale x 2 x i16> @select_nxv2i16(<vscale x 2 x i1> %a, <vscale x 2 x i16> %b, <vscale x 2 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.select.nxv2i16(<vscale x 2 x i1> %a, <vscale x 2 x i16> %b, <vscale x 2 x i16> %c, i32 %evl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 4 x i16> @llvm.vp.select.nxv4i16(<vscale x 4 x i1>, <vscale x 4 x i16>, <vscale x 4 x i16>, i32)

define <vscale x 4 x i16> @select_nxv4i16(<vscale x 4 x i1> %a, <vscale x 4 x i16> %b, <vscale x 4 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.vp.select.nxv4i16(<vscale x 4 x i1> %a, <vscale x 4 x i16> %b, <vscale x 4 x i16> %c, i32 %evl)
  ret <vscale x 4 x i16> %v
}

declare <vscale x 8 x i16> @llvm.vp.select.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)

define <vscale x 8 x i16> @select_nxv8i16(<vscale x 8 x i1> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.vp.select.nxv8i16(<vscale x 8 x i1> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c, i32 %evl)
  ret <vscale x 8 x i16> %v
}

declare <vscale x 16 x i16> @llvm.vp.select.nxv16i16(<vscale x 16 x i1>, <vscale x 16 x i16>, <vscale x 16 x i16>, i32)

define <vscale x 16 x i16> @select_nxv16i16(<vscale x 16 x i1> %a, <vscale x 16 x i16> %b, <vscale x 16 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.vp.select.nxv16i16(<vscale x 16 x i1> %a, <vscale x 16 x i16> %b, <vscale x 16 x i16> %c, i32 %evl)
  ret <vscale x 16 x i16> %v
}

declare <vscale x 32 x i16> @llvm.vp.select.nxv32i16(<vscale x 32 x i1>, <vscale x 32 x i16>, <vscale x 32 x i16>, i32)

define <vscale x 32 x i16> @select_nxv32i16(<vscale x 32 x i1> %a, <vscale x 32 x i16> %b, <vscale x 32 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.vp.select.nxv32i16(<vscale x 32 x i1> %a, <vscale x 32 x i16> %b, <vscale x 32 x i16> %c, i32 %evl)
  ret <vscale x 32 x i16> %v
}

declare <vscale x 1 x i32> @llvm.vp.select.nxv1i32(<vscale x 1 x i1>, <vscale x 1 x i32>, <vscale x 1 x i32>, i32)

define <vscale x 1 x i32> @select_nxv1i32(<vscale x 1 x i1> %a, <vscale x 1 x i32> %b, <vscale x 1 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.vp.select.nxv1i32(<vscale x 1 x i1> %a, <vscale x 1 x i32> %b, <vscale x 1 x i32> %c, i32 %evl)
  ret <vscale x 1 x i32> %v
}

declare <vscale x 2 x i32> @llvm.vp.select.nxv2i32(<vscale x 2 x i1>, <vscale x 2 x i32>, <vscale x 2 x i32>, i32)

define <vscale x 2 x i32> @select_nxv2i32(<vscale x 2 x i1> %a, <vscale x 2 x i32> %b, <vscale x 2 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.select.nxv2i32(<vscale x 2 x i1> %a, <vscale x 2 x i32> %b, <vscale x 2 x i32> %c, i32 %evl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 4 x i32> @llvm.vp.select.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>, i32)

define <vscale x 4 x i32> @select_nxv4i32(<vscale x 4 x i1> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.vp.select.nxv4i32(<vscale x 4 x i1> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c, i32 %evl)
  ret <vscale x 4 x i32> %v
}

declare <vscale x 8 x i32> @llvm.vp.select.nxv8i32(<vscale x 8 x i1>, <vscale x 8 x i32>, <vscale x 8 x i32>, i32)

define <vscale x 8 x i32> @select_nxv8i32(<vscale x 8 x i1> %a, <vscale x 8 x i32> %b, <vscale x 8 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.vp.select.nxv8i32(<vscale x 8 x i1> %a, <vscale x 8 x i32> %b, <vscale x 8 x i32> %c, i32 %evl)
  ret <vscale x 8 x i32> %v
}

declare <vscale x 16 x i32> @llvm.vp.select.nxv16i32(<vscale x 16 x i1>, <vscale x 16 x i32>, <vscale x 16 x i32>, i32)

define <vscale x 16 x i32> @select_nxv16i32(<vscale x 16 x i1> %a, <vscale x 16 x i32> %b, <vscale x 16 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.vp.select.nxv16i32(<vscale x 16 x i1> %a, <vscale x 16 x i32> %b, <vscale x 16 x i32> %c, i32 %evl)
  ret <vscale x 16 x i32> %v
}

declare <vscale x 32 x i32> @llvm.vp.select.nxv32i32(<vscale x 32 x i1>, <vscale x 32 x i32>, <vscale x 32 x i32>, i32)

define <vscale x 32 x i32> @select_nxv32i32(<vscale x 32 x i1> %a, <vscale x 32 x i32> %b, <vscale x 32 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a3, vlenb
; CHECK-NEXT:    slli a1, a3, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re32.v v8, (a1)
; CHECK-NEXT:    slli a1, a3, 1
; CHECK-NEXT:    sub a4, a2, a1
; CHECK-NEXT:    sltu a5, a2, a4
; CHECK-NEXT:    addi a5, a5, -1
; CHECK-NEXT:    and a4, a5, a4
; CHECK-NEXT:    srli a3, a3, 2
; CHECK-NEXT:    vl8re32.v v0, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v24, a3
; CHECK-NEXT:    vsetvli zero, a4, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v16, v8, v16, v0
; CHECK-NEXT:    bltu a2, a1, .LBB27_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, a1
; CHECK-NEXT:  .LBB27_2:
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i32> @llvm.vp.select.nxv32i32(<vscale x 32 x i1> %a, <vscale x 32 x i32> %b, <vscale x 32 x i32> %c, i32 %evl)
  ret <vscale x 32 x i32> %v
}

declare i32 @llvm.vscale.i32()

define <vscale x 32 x i32> @select_evl_nxv32i32(<vscale x 32 x i1> %a, <vscale x 32 x i32> %b, <vscale x 32 x i32> %c) {
; CHECK-LABEL: select_evl_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a2, a1, 3
; CHECK-NEXT:    add a2, a0, a2
; CHECK-NEXT:    vl8re32.v v8, (a2)
; CHECK-NEXT:    slli a2, a1, 1
; CHECK-NEXT:    sub a3, a1, a2
; CHECK-NEXT:    sltu a4, a1, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    srli a4, a1, 2
; CHECK-NEXT:    vl8re32.v v0, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v24, a4
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v16, v8, v16, v0
; CHECK-NEXT:    bltu a1, a2, .LBB28_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, a2
; CHECK-NEXT:  .LBB28_2:
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %evl = call i32 @llvm.vscale.i32()
  %evl0 = mul i32 %evl, 8
  %v = call <vscale x 32 x i32> @llvm.vp.select.nxv32i32(<vscale x 32 x i1> %a, <vscale x 32 x i32> %b, <vscale x 32 x i32> %c, i32 %evl0)
  ret <vscale x 32 x i32> %v
}

declare <vscale x 1 x i64> @llvm.vp.select.nxv1i64(<vscale x 1 x i1>, <vscale x 1 x i64>, <vscale x 1 x i64>, i32)

define <vscale x 1 x i64> @select_nxv1i64(<vscale x 1 x i1> %a, <vscale x 1 x i64> %b, <vscale x 1 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.vp.select.nxv1i64(<vscale x 1 x i1> %a, <vscale x 1 x i64> %b, <vscale x 1 x i64> %c, i32 %evl)
  ret <vscale x 1 x i64> %v
}

declare <vscale x 2 x i64> @llvm.vp.select.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>, i32)

define <vscale x 2 x i64> @select_nxv2i64(<vscale x 2 x i1> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.select.nxv2i64(<vscale x 2 x i1> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c, i32 %evl)
  ret <vscale x 2 x i64> %v
}

declare <vscale x 4 x i64> @llvm.vp.select.nxv4i64(<vscale x 4 x i1>, <vscale x 4 x i64>, <vscale x 4 x i64>, i32)

define <vscale x 4 x i64> @select_nxv4i64(<vscale x 4 x i1> %a, <vscale x 4 x i64> %b, <vscale x 4 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.vp.select.nxv4i64(<vscale x 4 x i1> %a, <vscale x 4 x i64> %b, <vscale x 4 x i64> %c, i32 %evl)
  ret <vscale x 4 x i64> %v
}

declare <vscale x 8 x i64> @llvm.vp.select.nxv8i64(<vscale x 8 x i1>, <vscale x 8 x i64>, <vscale x 8 x i64>, i32)

define <vscale x 8 x i64> @select_nxv8i64(<vscale x 8 x i1> %a, <vscale x 8 x i64> %b, <vscale x 8 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.vp.select.nxv8i64(<vscale x 8 x i1> %a, <vscale x 8 x i64> %b, <vscale x 8 x i64> %c, i32 %evl)
  ret <vscale x 8 x i64> %v
}

declare <vscale x 1 x half> @llvm.vp.select.nxv1f16(<vscale x 1 x i1>, <vscale x 1 x half>, <vscale x 1 x half>, i32)

define <vscale x 1 x half> @select_nxv1f16(<vscale x 1 x i1> %a, <vscale x 1 x half> %b, <vscale x 1 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x half> @llvm.vp.select.nxv1f16(<vscale x 1 x i1> %a, <vscale x 1 x half> %b, <vscale x 1 x half> %c, i32 %evl)
  ret <vscale x 1 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.select.nxv2f16(<vscale x 2 x i1>, <vscale x 2 x half>, <vscale x 2 x half>, i32)

define <vscale x 2 x half> @select_nxv2f16(<vscale x 2 x i1> %a, <vscale x 2 x half> %b, <vscale x 2 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.select.nxv2f16(<vscale x 2 x i1> %a, <vscale x 2 x half> %b, <vscale x 2 x half> %c, i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 4 x half> @llvm.vp.select.nxv4f16(<vscale x 4 x i1>, <vscale x 4 x half>, <vscale x 4 x half>, i32)

define <vscale x 4 x half> @select_nxv4f16(<vscale x 4 x i1> %a, <vscale x 4 x half> %b, <vscale x 4 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x half> @llvm.vp.select.nxv4f16(<vscale x 4 x i1> %a, <vscale x 4 x half> %b, <vscale x 4 x half> %c, i32 %evl)
  ret <vscale x 4 x half> %v
}

declare <vscale x 8 x half> @llvm.vp.select.nxv8f16(<vscale x 8 x i1>, <vscale x 8 x half>, <vscale x 8 x half>, i32)

define <vscale x 8 x half> @select_nxv8f16(<vscale x 8 x i1> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x half> @llvm.vp.select.nxv8f16(<vscale x 8 x i1> %a, <vscale x 8 x half> %b, <vscale x 8 x half> %c, i32 %evl)
  ret <vscale x 8 x half> %v
}

declare <vscale x 16 x half> @llvm.vp.select.nxv16f16(<vscale x 16 x i1>, <vscale x 16 x half>, <vscale x 16 x half>, i32)

define <vscale x 16 x half> @select_nxv16f16(<vscale x 16 x i1> %a, <vscale x 16 x half> %b, <vscale x 16 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x half> @llvm.vp.select.nxv16f16(<vscale x 16 x i1> %a, <vscale x 16 x half> %b, <vscale x 16 x half> %c, i32 %evl)
  ret <vscale x 16 x half> %v
}

declare <vscale x 32 x half> @llvm.vp.select.nxv32f16(<vscale x 32 x i1>, <vscale x 32 x half>, <vscale x 32 x half>, i32)

define <vscale x 32 x half> @select_nxv32f16(<vscale x 32 x i1> %a, <vscale x 32 x half> %b, <vscale x 32 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.select.nxv32f16(<vscale x 32 x i1> %a, <vscale x 32 x half> %b, <vscale x 32 x half> %c, i32 %evl)
  ret <vscale x 32 x half> %v
}

declare <vscale x 1 x float> @llvm.vp.select.nxv1f32(<vscale x 1 x i1>, <vscale x 1 x float>, <vscale x 1 x float>, i32)

define <vscale x 1 x float> @select_nxv1f32(<vscale x 1 x i1> %a, <vscale x 1 x float> %b, <vscale x 1 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x float> @llvm.vp.select.nxv1f32(<vscale x 1 x i1> %a, <vscale x 1 x float> %b, <vscale x 1 x float> %c, i32 %evl)
  ret <vscale x 1 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.select.nxv2f32(<vscale x 2 x i1>, <vscale x 2 x float>, <vscale x 2 x float>, i32)

define <vscale x 2 x float> @select_nxv2f32(<vscale x 2 x i1> %a, <vscale x 2 x float> %b, <vscale x 2 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.select.nxv2f32(<vscale x 2 x i1> %a, <vscale x 2 x float> %b, <vscale x 2 x float> %c, i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 4 x float> @llvm.vp.select.nxv4f32(<vscale x 4 x i1>, <vscale x 4 x float>, <vscale x 4 x float>, i32)

define <vscale x 4 x float> @select_nxv4f32(<vscale x 4 x i1> %a, <vscale x 4 x float> %b, <vscale x 4 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.vp.select.nxv4f32(<vscale x 4 x i1> %a, <vscale x 4 x float> %b, <vscale x 4 x float> %c, i32 %evl)
  ret <vscale x 4 x float> %v
}

declare <vscale x 8 x float> @llvm.vp.select.nxv8f32(<vscale x 8 x i1>, <vscale x 8 x float>, <vscale x 8 x float>, i32)

define <vscale x 8 x float> @select_nxv8f32(<vscale x 8 x i1> %a, <vscale x 8 x float> %b, <vscale x 8 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x float> @llvm.vp.select.nxv8f32(<vscale x 8 x i1> %a, <vscale x 8 x float> %b, <vscale x 8 x float> %c, i32 %evl)
  ret <vscale x 8 x float> %v
}

declare <vscale x 16 x float> @llvm.vp.select.nxv16f32(<vscale x 16 x i1>, <vscale x 16 x float>, <vscale x 16 x float>, i32)

define <vscale x 16 x float> @select_nxv16f32(<vscale x 16 x i1> %a, <vscale x 16 x float> %b, <vscale x 16 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.vp.select.nxv16f32(<vscale x 16 x i1> %a, <vscale x 16 x float> %b, <vscale x 16 x float> %c, i32 %evl)
  ret <vscale x 16 x float> %v
}

declare <vscale x 1 x double> @llvm.vp.select.nxv1f64(<vscale x 1 x i1>, <vscale x 1 x double>, <vscale x 1 x double>, i32)

define <vscale x 1 x double> @select_nxv1f64(<vscale x 1 x i1> %a, <vscale x 1 x double> %b, <vscale x 1 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x double> @llvm.vp.select.nxv1f64(<vscale x 1 x i1> %a, <vscale x 1 x double> %b, <vscale x 1 x double> %c, i32 %evl)
  ret <vscale x 1 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.select.nxv2f64(<vscale x 2 x i1>, <vscale x 2 x double>, <vscale x 2 x double>, i32)

define <vscale x 2 x double> @select_nxv2f64(<vscale x 2 x i1> %a, <vscale x 2 x double> %b, <vscale x 2 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.select.nxv2f64(<vscale x 2 x i1> %a, <vscale x 2 x double> %b, <vscale x 2 x double> %c, i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 4 x double> @llvm.vp.select.nxv4f64(<vscale x 4 x i1>, <vscale x 4 x double>, <vscale x 4 x double>, i32)

define <vscale x 4 x double> @select_nxv4f64(<vscale x 4 x i1> %a, <vscale x 4 x double> %b, <vscale x 4 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x double> @llvm.vp.select.nxv4f64(<vscale x 4 x i1> %a, <vscale x 4 x double> %b, <vscale x 4 x double> %c, i32 %evl)
  ret <vscale x 4 x double> %v
}

declare <vscale x 8 x double> @llvm.vp.select.nxv8f64(<vscale x 8 x i1>, <vscale x 8 x double>, <vscale x 8 x double>, i32)

define <vscale x 8 x double> @select_nxv8f64(<vscale x 8 x i1> %a, <vscale x 8 x double> %b, <vscale x 8 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x double> @llvm.vp.select.nxv8f64(<vscale x 8 x i1> %a, <vscale x 8 x double> %b, <vscale x 8 x double> %c, i32 %evl)
  ret <vscale x 8 x double> %v
}

declare <vscale x 16 x double> @llvm.vp.select.nxv16f64(<vscale x 16 x i1>, <vscale x 16 x double>, <vscale x 16 x double>, i32)

define <vscale x 16 x double> @select_nxv16f64(<vscale x 16 x i1> %a, <vscale x 16 x double> %b, <vscale x 16 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a3, a1, 3
; CHECK-NEXT:    add a3, a0, a3
; CHECK-NEXT:    vl8re64.v v8, (a3)
; CHECK-NEXT:    sub a3, a2, a1
; CHECK-NEXT:    sltu a4, a2, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    srli a4, a1, 3
; CHECK-NEXT:    vl8re64.v v0, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v24, a4
; CHECK-NEXT:    vsetvli zero, a3, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v16, v8, v16, v0
; CHECK-NEXT:    bltu a2, a1, .LBB48_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, a1
; CHECK-NEXT:  .LBB48_2:
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x double> @llvm.vp.select.nxv16f64(<vscale x 16 x i1> %a, <vscale x 16 x double> %b, <vscale x 16 x double> %c, i32 %evl)
  ret <vscale x 16 x double> %v
}
