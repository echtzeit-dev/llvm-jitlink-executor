; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+experimental-zvfh,+v,+zbb -riscv-v-vector-bits-min=128 -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s

define i64 @reduce_add(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_add:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> %v)
  %res = add i64 %rdx, %x
  ret i64 %res
}

define i64 @reduce_add2(<4 x i64> %v) {
; CHECK-LABEL: reduce_add2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> %v)
  %res = add i64 %rdx, 8
  ret i64 %res
}

define i64 @reduce_and(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_and:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredand.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.and.v4i64(<4 x i64> %v)
  %res = and i64 %rdx, %x
  ret i64 %res
}

define i64 @reduce_and2(<4 x i64> %v) {
; CHECK-LABEL: reduce_and2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredand.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.and.v4i64(<4 x i64> %v)
  %res = and i64 %rdx, 8
  ret i64 %res
}

define i64 @reduce_or(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_or:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredor.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> %v)
  %res = or i64 %rdx, %x
  ret i64 %res
}

define i64 @reduce_or2(<4 x i64> %v) {
; CHECK-LABEL: reduce_or2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredor.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> %v)
  %res = or i64 %rdx, 8
  ret i64 %res
}

define i64 @reduce_xor(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_xor:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredxor.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.xor.v4i64(<4 x i64> %v)
  %res = xor i64 %rdx, %x
  ret i64 %res
}

define i64 @reduce_xor2(<4 x i64> %v) {
; CHECK-LABEL: reduce_xor2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredxor.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    andi a0, a0, 8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.xor.v4i64(<4 x i64> %v)
  %res = and i64 %rdx, 8
  ret i64 %res
}

define i64 @reduce_umax(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_umax:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredmaxu.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.umax.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.umax.i64(i64 %rdx, i64 %x)
  ret i64 %res
}

define i64 @reduce_umax2(<4 x i64> %v) {
; CHECK-LABEL: reduce_umax2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.umax.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.umax.i64(i64 %rdx, i64 8)
  ret i64 %res
}

define i64 @reduce_umin(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_umin:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredminu.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.umin.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.umin.i64(i64 %rdx, i64 %x)
  ret i64 %res
}

define i64 @reduce_umin2(<4 x i64> %v) {
; CHECK-LABEL: reduce_umin2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredminu.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.umin.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.umin.i64(i64 %rdx, i64 8)
  ret i64 %res
}

define i64 @reduce_smax(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_smax:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredmax.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.smax.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.smax.i64(i64 %rdx, i64 %x)
  ret i64 %res
}

define i64 @reduce_smax2(<4 x i64> %v) {
; CHECK-LABEL: reduce_smax2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredmax.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.smax.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.smax.i64(i64 %rdx, i64 8)
  ret i64 %res
}

define i64 @reduce_smin(i64 %x, <4 x i64> %v) {
; CHECK-LABEL: reduce_smin:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vredmin.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.smin.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.smin.i64(i64 %rdx, i64 %x)
  ret i64 %res
}

define i64 @reduce_smin2(<4 x i64> %v) {
; CHECK-LABEL: reduce_smin2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vredmin.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call i64 @llvm.vector.reduce.smin.v4i64(<4 x i64> %v)
  %res = call i64 @llvm.smin.i64(i64 %rdx, i64 8)
  ret i64 %res
}

define float @reduce_fadd(float %x, <4 x float> %v) {
; CHECK-LABEL: reduce_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vfredusum.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call fast float @llvm.vector.reduce.fadd.v4f32(float %x, <4 x float> %v)
  ret float %rdx
}

define float @reduce_fadd2(float %x, <4 x float> %v) {
; CHECK-LABEL: reduce_fadd2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vfredusum.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.0, <4 x float> %v)
  %res = fadd fast float %rdx, %x
  ret float %res
}

define float @reduce_fmax(float %x, <4 x float> %v) {
; CHECK-LABEL: reduce_fmax:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vfredmax.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call float @llvm.vector.reduce.fmax.v4f32(<4 x float> %v)
  %res = call float @llvm.maxnum.f32(float %x, float %rdx)
  ret float %res
}

define float @reduce_fmin(float %x, <4 x float> %v) {
; CHECK-LABEL: reduce_fmin:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vfredmin.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %rdx = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> %v)
  %res = call float @llvm.minnum.f32(float %x, float %rdx)
  ret float %res
}

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i64 @llvm.vector.reduce.add.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.and.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.or.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.xor.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.umax.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.umin.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.smax.v4i64(<4 x i64>)
declare i64 @llvm.vector.reduce.smin.v4i64(<4 x i64>)
declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>)
declare float @llvm.vector.reduce.fmax.v4f32(<4 x float>)
declare float @llvm.vector.reduce.fmin.v4f32(<4 x float>)
declare i64 @llvm.umax.i64(i64, i64)
declare i64 @llvm.umin.i64(i64, i64)
declare i64 @llvm.smax.i64(i64, i64)
declare i64 @llvm.smin.i64(i64, i64)
declare float @llvm.maxnum.f32(float ,float)
declare float @llvm.minnum.f32(float ,float)
