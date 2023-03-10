; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-eabi -aarch64-neon-syntax=generic | FileCheck %s

; Function Attrs: nounwind readnone
declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.add.v4i16(<4 x i16>)
declare i8 @llvm.vector.reduce.add.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.add.v16i8(<16 x i8>)

define i8 @add_B(ptr %arr)  {
; CHECK-LABEL: add_B:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    addv b0, v0.16b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %bin.rdx = load <16 x i8>, ptr %arr
  %r = call i8 @llvm.vector.reduce.add.v16i8(<16 x i8> %bin.rdx)
  ret i8 %r
}

define i16 @add_H(ptr %arr)  {
; CHECK-LABEL: add_H:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    addv h0, v0.8h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %bin.rdx = load <8 x i16>, ptr %arr
  %r = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %bin.rdx)
  ret i16 %r
}

define i32 @add_S( ptr %arr)  {
; CHECK-LABEL: add_S:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %bin.rdx = load <4 x i32>, ptr %arr
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %bin.rdx)
  ret i32 %r
}

define i64 @add_D(ptr %arr)  {
; CHECK-LABEL: add_D:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    addp d0, v0.2d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %bin.rdx = load <2 x i64>, ptr %arr
  %r = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %bin.rdx)
  ret i64 %r
}

declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)

define i32 @oversized_ADDV_256(ptr noalias nocapture readonly %arg1, ptr noalias nocapture readonly %arg2) {
; CHECK-LABEL: oversized_ADDV_256:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    uabdl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    uaddlv s0, v0.8h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = load <8 x i8>, ptr %arg1, align 1
  %1 = zext <8 x i8> %0 to <8 x i32>
  %2 = load <8 x i8>, ptr %arg2, align 1
  %3 = zext <8 x i8> %2 to <8 x i32>
  %4 = sub nsw <8 x i32> %1, %3
  %5 = icmp slt <8 x i32> %4, zeroinitializer
  %6 = sub nsw <8 x i32> zeroinitializer, %4
  %7 = select <8 x i1> %5, <8 x i32> %6, <8 x i32> %4
  %r = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %7)
  ret i32 %r
}

declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)

define i32 @oversized_ADDV_512(ptr %arr)  {
; CHECK-LABEL: oversized_ADDV_512:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0, #32]
; CHECK-NEXT:    ldp q3, q2, [x0]
; CHECK-NEXT:    add v0.4s, v3.4s, v0.4s
; CHECK-NEXT:    add v1.4s, v2.4s, v1.4s
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %bin.rdx = load <16 x i32>, ptr %arr
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx)
  ret i32 %r
}

define i8 @addv_combine_i8(<8 x i8> %a1, <8 x i8> %a2) {
; CHECK-LABEL: addv_combine_i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    addv b0, v0.8b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %rdx.1 = call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> %a1)
  %rdx.2 = call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> %a2)
  %r = add i8 %rdx.1, %rdx.2
  ret i8 %r
}

define i16 @addv_combine_i16(<4 x i16> %a1, <4 x i16> %a2) {
; CHECK-LABEL: addv_combine_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    addv h0, v0.4h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %rdx.1 = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> %a1)
  %rdx.2 = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> %a2)
  %r = add i16 %rdx.1, %rdx.2
  ret i16 %r
}

define i32 @addv_combine_i32(<4 x i32> %a1, <4 x i32> %a2) {
; CHECK-LABEL: addv_combine_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %rdx.1 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %a1)
  %rdx.2 = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %a2)
  %r = add i32 %rdx.1, %rdx.2
  ret i32 %r
}

define i64 @addv_combine_i64(<2 x i64> %a1, <2 x i64> %a2) {
; CHECK-LABEL: addv_combine_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    addp d0, v0.2d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
entry:
  %rdx.1 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %a1)
  %rdx.2 = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %a2)
  %r = add i64 %rdx.1, %rdx.2
  ret i64 %r
}
