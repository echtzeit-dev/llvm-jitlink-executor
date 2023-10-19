; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+f -target-abi=lp64f -verify-machineinstrs < %s \
; RUN:   -disable-strictnode-mutation | FileCheck %s -check-prefix=RV64IF

; This file exhaustively checks float<->i32 conversions. In general,
; fcvt.l[u].s can be selected instead of fcvt.w[u].s because poison is
; generated for an fpto[s|u]i conversion if the result doesn't fit in the
; target type.

define i32 @aext_fptosi(float %a) nounwind strictfp {
; RV64IF-LABEL: aext_fptosi:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.w.s a0, fa0, rtz
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptosi.i32.f32(float, metadata)

define signext i32 @sext_fptosi(float %a) nounwind strictfp {
; RV64IF-LABEL: sext_fptosi:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.w.s a0, fa0, rtz
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define zeroext i32 @zext_fptosi(float %a) nounwind strictfp {
; RV64IF-LABEL: zext_fptosi:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.w.s a0, fa0, rtz
; RV64IF-NEXT:    slli a0, a0, 32
; RV64IF-NEXT:    srli a0, a0, 32
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define i32 @aext_fptoui(float %a) nounwind strictfp {
; RV64IF-LABEL: aext_fptoui:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.wu.s a0, fa0, rtz
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptoui.i32.f32(float, metadata)

define signext i32 @sext_fptoui(float %a) nounwind strictfp {
; RV64IF-LABEL: sext_fptoui:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.wu.s a0, fa0, rtz
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define zeroext i32 @zext_fptoui(float %a) nounwind strictfp {
; RV64IF-LABEL: zext_fptoui:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.lu.s a0, fa0, rtz
; RV64IF-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define float @uitofp_aext_i32_to_f32(i32 %a) nounwind strictfp {
; RV64IF-LABEL: uitofp_aext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.wu fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata, metadata)

define float @uitofp_sext_i32_to_f32(i32 signext %a) nounwind strictfp {
; RV64IF-LABEL: uitofp_sext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.wu fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}

define float @uitofp_zext_i32_to_f32(i32 zeroext %a) nounwind strictfp {
; RV64IF-LABEL: uitofp_zext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.wu fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}

define float @sitofp_aext_i32_to_f32(i32 %a) nounwind strictfp {
; RV64IF-LABEL: sitofp_aext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.w fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.sitofp.f32.i32(i32, metadata, metadata)

define float @sitofp_sext_i32_to_f32(i32 signext %a) nounwind strictfp {
; RV64IF-LABEL: sitofp_sext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.w fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}

define float @sitofp_zext_i32_to_f32(i32 zeroext %a) nounwind strictfp {
; RV64IF-LABEL: sitofp_zext_i32_to_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.w fa0, a0
; RV64IF-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
