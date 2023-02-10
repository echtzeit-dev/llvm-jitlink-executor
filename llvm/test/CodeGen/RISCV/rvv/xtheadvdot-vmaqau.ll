; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvdot \
; RUN:   -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvdot \
; RUN:   -verify-machineinstrs | FileCheck %s
declare <vscale x 1 x i32> @llvm.riscv.th.vmaqau.nxv1i32.nxv4i8(
  <vscale x 1 x i32>,
  <vscale x 4 x i8>,
  <vscale x 4 x i8>,
  iXLen,
  iXLen);

define <vscale x 1 x i32>  @intrinsic_th_vmaqau_vv_nxv1i32_nxv4i8_nxv4i8(<vscale x 1 x i32> %0, <vscale x 4 x i8> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vv_nxv1i32_nxv4i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, tu, ma
; CHECK-NEXT:    th.vmaqau.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.th.vmaqau.nxv1i32.nxv4i8(
    <vscale x 1 x i32> %0,
    <vscale x 4 x i8> %1,
    <vscale x 4 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.th.vmaqau.mask.nxv1i32.nxv4i8(
  <vscale x 1 x i32>,
  <vscale x 4 x i8>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen, iXLen);

define <vscale x 1 x i32>  @intrinsic_th_vmaqau_mask_vv_nxv1i32_nxv4i8_nxv4i8(<vscale x 1 x i32> %0, <vscale x 4 x i8> %1, <vscale x 4 x i8> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vv_nxv1i32_nxv4i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, tu, mu
; CHECK-NEXT:    th.vmaqau.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.th.vmaqau.mask.nxv1i32.nxv4i8(
    <vscale x 1 x i32> %0,
    <vscale x 4 x i8> %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vmaqau.nxv2i32.nxv8i8(
  <vscale x 2 x i32>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  iXLen,
  iXLen);

define <vscale x 2 x i32>  @intrinsic_th_vmaqau_vv_nxv2i32_nxv8i8_nxv8i8(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vv_nxv2i32_nxv8i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, ma
; CHECK-NEXT:    th.vmaqau.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vmaqau.nxv2i32.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vmaqau.mask.nxv2i32.nxv8i8(
  <vscale x 2 x i32>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen, iXLen);

define <vscale x 2 x i32>  @intrinsic_th_vmaqau_mask_vv_nxv2i32_nxv8i8_nxv8i8(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vv_nxv2i32_nxv8i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, mu
; CHECK-NEXT:    th.vmaqau.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vmaqau.mask.nxv2i32.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vmaqau.nxv4i32.nxv16i8(
  <vscale x 4 x i32>,
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  iXLen,
  iXLen);

define <vscale x 4 x i32>  @intrinsic_th_vmaqau_vv_nxv4i32_nxv16i8_nxv16i8(<vscale x 4 x i32> %0, <vscale x 16 x i8> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vv_nxv4i32_nxv16i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    th.vmaqau.vv v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vmaqau.nxv4i32.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 16 x i8> %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vmaqau.mask.nxv4i32.nxv16i8(
  <vscale x 4 x i32>,
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen, iXLen);

define <vscale x 4 x i32>  @intrinsic_th_vmaqau_mask_vv_nxv4i32_nxv16i8_nxv16i8(<vscale x 4 x i32> %0, <vscale x 16 x i8> %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vv_nxv4i32_nxv16i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, mu
; CHECK-NEXT:    th.vmaqau.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vmaqau.mask.nxv4i32.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 16 x i8> %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vmaqau.nxv8i32.nxv32i8(
  <vscale x 8 x i32>,
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  iXLen,
  iXLen);

define <vscale x 8 x i32>  @intrinsic_th_vmaqau_vv_nxv8i32_nxv32i8_nxv32i8(<vscale x 8 x i32> %0, <vscale x 32 x i8> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vv_nxv8i32_nxv32i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    th.vmaqau.vv v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vmaqau.nxv8i32.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 32 x i8> %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vmaqau.mask.nxv8i32.nxv32i8(
  <vscale x 8 x i32>,
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen, iXLen);

define <vscale x 8 x i32>  @intrinsic_th_vmaqau_mask_vv_nxv8i32_nxv32i8_nxv32i8(<vscale x 8 x i32> %0, <vscale x 32 x i8> %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vv_nxv8i32_nxv32i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, mu
; CHECK-NEXT:    th.vmaqau.vv v8, v12, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vmaqau.mask.nxv8i32.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 32 x i8> %1,
    <vscale x 32 x i8> %2,
    <vscale x 32 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 8 x i32> %a
}


declare <vscale x 1 x i32> @llvm.riscv.th.vmaqau.nxv1i32.i8(
  <vscale x 1 x i32>,
  i8,
  <vscale x 4 x i8>,
  iXLen,
  iXLen);

define <vscale x 1 x i32>  @intrinsic_th_vmaqau_vx_nxv1i32_i8_nxv4i8(<vscale x 1 x i32> %0, i8 %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vx_nxv1i32_i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, tu, ma
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.th.vmaqau.nxv1i32.i8(
    <vscale x 1 x i32> %0,
    i8 %1,
    <vscale x 4 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.th.vmaqau.mask.nxv1i32.i8(
  <vscale x 1 x i32>,
  i8,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen, iXLen);

define <vscale x 1 x i32> @intrinsic_th_vmaqau_mask_vx_nxv1i32_i8_nxv4i8(<vscale x 1 x i32> %0, i8 %1, <vscale x 4 x i8> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vx_nxv1i32_i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, tu, mu
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.th.vmaqau.mask.nxv1i32.i8(
    <vscale x 1 x i32> %0,
    i8 %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vmaqau.nxv2i32.i8(
  <vscale x 2 x i32>,
  i8,
  <vscale x 8 x i8>,
  iXLen,
  iXLen);

define <vscale x 2 x i32>  @intrinsic_th_vmaqau_vx_nxv2i32_i8_nxv8i8(<vscale x 2 x i32> %0, i8 %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vx_nxv2i32_i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, tu, ma
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vmaqau.nxv2i32.i8(
    <vscale x 2 x i32> %0,
    i8 %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vmaqau.mask.nxv2i32.i8(
  <vscale x 2 x i32>,
  i8,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen, iXLen);

define <vscale x 2 x i32> @intrinsic_th_vmaqau_mask_vx_nxv2i32_i8_nxv8i8(<vscale x 2 x i32> %0, i8 %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vx_nxv2i32_i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, tu, mu
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vmaqau.mask.nxv2i32.i8(
    <vscale x 2 x i32> %0,
    i8 %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vmaqau.nxv4i32.i8(
  <vscale x 4 x i32>,
  i8,
  <vscale x 16 x i8>,
  iXLen,
  iXLen);

define <vscale x 4 x i32>  @intrinsic_th_vmaqau_vx_nxv4i32_i8_nxv16i8(<vscale x 4 x i32> %0, i8 %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vx_nxv4i32_i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vmaqau.nxv4i32.i8(
    <vscale x 4 x i32> %0,
    i8 %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vmaqau.mask.nxv4i32.i8(
  <vscale x 4 x i32>,
  i8,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen, iXLen);

define <vscale x 4 x i32> @intrinsic_th_vmaqau_mask_vx_nxv4i32_i8_nxv16i8(<vscale x 4 x i32> %0, i8 %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vx_nxv4i32_i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, mu
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vmaqau.mask.nxv4i32.i8(
    <vscale x 4 x i32> %0,
    i8 %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vmaqau.nxv8i32.i8(
  <vscale x 8 x i32>,
  i8,
  <vscale x 32 x i8>,
  iXLen,
  iXLen);

define <vscale x 8 x i32>  @intrinsic_th_vmaqau_vx_nxv8i32_i8_nxv32i8(<vscale x 8 x i32> %0, i8 %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_vx_nxv8i32_i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, tu, ma
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vmaqau.nxv8i32.i8(
    <vscale x 8 x i32> %0,
    i8 %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 0)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vmaqau.mask.nxv8i32.i8(
  <vscale x 8 x i32>,
  i8,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen, iXLen);

define <vscale x 8 x i32> @intrinsic_th_vmaqau_mask_vx_nxv8i32_i8_nxv32i8(<vscale x 8 x i32> %0, i8 %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_th_vmaqau_mask_vx_nxv8i32_i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, tu, mu
; CHECK-NEXT:    th.vmaqau.vx v8, a0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vmaqau.mask.nxv8i32.i8(
    <vscale x 8 x i32> %0,
    i8 %1,
    <vscale x 32 x i8> %2,
    <vscale x 32 x i1> %3,
    iXLen %4, iXLen 0)

  ret <vscale x 8 x i32> %a
}
