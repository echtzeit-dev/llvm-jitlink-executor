; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve,+sme -verify-machineinstrs < %s | FileCheck %s

define void @insert_row_b(i32 %tileslice, <vscale x 16 x i1> %pg,
; CHECK-LABEL: insert_row_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.b[w12, 0], p0/m, z0.b
; CHECK-NEXT:    mov za0h.b[w12, 2], p0/m, z1.b
; CHECK-NEXT:    mov za0h.b[w12, 4], p0/m, z2.b
; CHECK-NEXT:    mov za0h.b[w12, 6], p0/m, z3.b
; CHECK-NEXT:    mov za0h.b[w12, 8], p0/m, z4.b
; CHECK-NEXT:    mov za0h.b[w12, 10], p0/m, z5.b
; CHECK-NEXT:    mov za0h.b[w12, 12], p0/m, z6.b
; CHECK-NEXT:    mov za0h.b[w12, 14], p0/m, z7.b
; CHECK-NEXT:    ret
                          <vscale x 16 x i8> %z0, <vscale x 16 x i8> %z1,
                          <vscale x 16 x i8> %z2, <vscale x 16 x i8> %z3,
                          <vscale x 16 x i8> %z4, <vscale x 16 x i8> %z5,
                          <vscale x 16 x i8> %z6, <vscale x 16 x i8> %z7) {
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z0)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.2, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z1)
  %tileslice.4 = add i32 %tileslice, 4
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.4, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z2)
  %tileslice.6 = add i32 %tileslice, 6
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.6, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z3)
  %tileslice.8 = add i32 %tileslice, 8
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.8, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z4)
  %tileslice.10 = add i32 %tileslice, 10
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.10, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z5)
  %tileslice.12 = add i32 %tileslice, 12
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.12, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z6)
  %tileslice.14 = add i32 %tileslice, 14
  call void @llvm.aarch64.sme.write.horiz.nxv16i8(i32 0, i32 %tileslice.14, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z7)
  ret void
}

define void @insert_col_b(i32 %tileslice, <vscale x 16 x i1> %pg,
; CHECK-LABEL: insert_col_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0v.b[w12, 1], p0/m, z0.b
; CHECK-NEXT:    mov za0v.b[w12, 3], p0/m, z1.b
; CHECK-NEXT:    mov za0v.b[w12, 5], p0/m, z2.b
; CHECK-NEXT:    mov za0v.b[w12, 7], p0/m, z3.b
; CHECK-NEXT:    mov za0v.b[w12, 9], p0/m, z4.b
; CHECK-NEXT:    mov za0v.b[w12, 11], p0/m, z5.b
; CHECK-NEXT:    mov za0v.b[w12, 13], p0/m, z6.b
; CHECK-NEXT:    mov za0v.b[w12, 15], p0/m, z7.b
; CHECK-NEXT:    ret
                          <vscale x 16 x i8> %z0, <vscale x 16 x i8> %z1,
                          <vscale x 16 x i8> %z2, <vscale x 16 x i8> %z3,
                          <vscale x 16 x i8> %z4, <vscale x 16 x i8> %z5,
                          <vscale x 16 x i8> %z6, <vscale x 16 x i8> %z7) {
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.1, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z0)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.3, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z1)
  %tileslice.5 = add i32 %tileslice, 5
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.5, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z2)
  %tileslice.7 = add i32 %tileslice, 7
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.7, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z3)
  %tileslice.9 = add i32 %tileslice, 9
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.9, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z4)
  %tileslice.11 = add i32 %tileslice, 11
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.11, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z5)
  %tileslice.13 = add i32 %tileslice, 13
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.13, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z6)
  %tileslice.15 = add i32 %tileslice, 15
  call void @llvm.aarch64.sme.write.vert.nxv16i8(i32 0, i32 %tileslice.15, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %z7)
  ret void
}

define void @insert_row_h(i32 %tileslice, <vscale x 8 x i1> %pg,
; CHECK-LABEL: insert_row_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.h[w12, 0], p0/m, z0.h
; CHECK-NEXT:    mov za0h.h[w12, 2], p0/m, z2.h
; CHECK-NEXT:    mov za0h.h[w12, 4], p0/m, z4.h
; CHECK-NEXT:    mov za0h.h[w12, 6], p0/m, z6.h
; CHECK-NEXT:    ret
                          <vscale x 8 x i16> %z0, <vscale x 8 x i16> %z1,
                          <vscale x 8 x i16> %z2, <vscale x 8 x i16> %z3,
                          <vscale x 8 x i16> %z4, <vscale x 8 x i16> %z5,
                          <vscale x 8 x i16> %z6, <vscale x 8 x i16> %z7) {
  call void @llvm.aarch64.sme.write.horiz.nxv8i16(i32 0, i32 %tileslice, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z0)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.horiz.nxv8i16(i32 0, i32 %tileslice.2, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z2)
  %tileslice.4 = add i32 %tileslice, 4
  call void @llvm.aarch64.sme.write.horiz.nxv8i16(i32 0, i32 %tileslice.4, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z4)
  %tileslice.6 = add i32 %tileslice, 6
  call void @llvm.aarch64.sme.write.horiz.nxv8i16(i32 0, i32 %tileslice.6, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z6)
  ret void
}

define void @insert_col_h(i32 %tileslice, <vscale x 8 x i1> %pg,
; CHECK-LABEL: insert_col_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za1v.h[w12, 1], p0/m, z1.h
; CHECK-NEXT:    mov za1v.h[w12, 3], p0/m, z3.h
; CHECK-NEXT:    mov za1v.h[w12, 5], p0/m, z5.h
; CHECK-NEXT:    mov za1v.h[w12, 7], p0/m, z7.h
; CHECK-NEXT:    ret
                          <vscale x 8 x i16> %z0, <vscale x 8 x i16> %z1,
                          <vscale x 8 x i16> %z2, <vscale x 8 x i16> %z3,
                          <vscale x 8 x i16> %z4, <vscale x 8 x i16> %z5,
                          <vscale x 8 x i16> %z6, <vscale x 8 x i16> %z7) {
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.vert.nxv8i16(i32 1, i32 %tileslice.1, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z1)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv8i16(i32 1, i32 %tileslice.3, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z3)
  %tileslice.5 = add i32 %tileslice, 5
  call void @llvm.aarch64.sme.write.vert.nxv8i16(i32 1, i32 %tileslice.5, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z5)
  %tileslice.7 = add i32 %tileslice, 7
  call void @llvm.aarch64.sme.write.vert.nxv8i16(i32 1, i32 %tileslice.7, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %z7)
  ret void
}

define void @insert_f16(i32 %tileslice, <vscale x 8 x i1> %pg,
; CHECK-LABEL: insert_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.h[w12, 0], p0/m, z0.h
; CHECK-NEXT:    mov za0h.h[w12, 1], p0/m, z1.h
; CHECK-NEXT:    mov za0v.h[w12, 2], p0/m, z2.h
; CHECK-NEXT:    mov za0v.h[w12, 3], p0/m, z3.h
; CHECK-NEXT:    mov za0h.h[w12, 4], p0/m, z4.h
; CHECK-NEXT:    mov za0h.h[w12, 5], p0/m, z5.h
; CHECK-NEXT:    mov za0v.h[w12, 6], p0/m, z6.h
; CHECK-NEXT:    mov za0v.h[w12, 7], p0/m, z7.h
; CHECK-NEXT:    ret
                          <vscale x 8 x half> %z0, <vscale x 8 x half> %z1,
                          <vscale x 8 x half> %z2, <vscale x 8 x half> %z3,
                          <vscale x 8 x half> %z4, <vscale x 8 x half> %z5,
                          <vscale x 8 x half> %z6, <vscale x 8 x half> %z7) {
  call void @llvm.aarch64.sme.write.horiz.nxv8f16(i32 0, i32 %tileslice, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z0)
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.horiz.nxv8f16(i32 0, i32 %tileslice.1, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z1)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.vert.nxv8f16(i32 0, i32 %tileslice.2, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z2)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv8f16(i32 0, i32 %tileslice.3, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z3)
  %tileslice.4 = add i32 %tileslice, 4
  call void @llvm.aarch64.sme.write.horiz.nxv8f16(i32 0, i32 %tileslice.4, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z4)
  %tileslice.5 = add i32 %tileslice, 5
  call void @llvm.aarch64.sme.write.horiz.nxv8f16(i32 0, i32 %tileslice.5, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z5)
  %tileslice.6 = add i32 %tileslice, 6
  call void @llvm.aarch64.sme.write.vert.nxv8f16(i32 0, i32 %tileslice.6, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z6)
  %tileslice.7 = add i32 %tileslice, 7
  call void @llvm.aarch64.sme.write.vert.nxv8f16(i32 0, i32 %tileslice.7, <vscale x 8 x i1> %pg, <vscale x 8 x half> %z7)
  ret void
}

define void @insert_bf16(i32 %tileslice, <vscale x 8 x i1> %pg,
; CHECK-LABEL: insert_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.h[w12, 0], p0/m, z0.h
; CHECK-NEXT:    mov za0h.h[w12, 1], p0/m, z1.h
; CHECK-NEXT:    mov za0v.h[w12, 2], p0/m, z2.h
; CHECK-NEXT:    mov za0v.h[w12, 3], p0/m, z3.h
; CHECK-NEXT:    mov za0h.h[w12, 4], p0/m, z4.h
; CHECK-NEXT:    mov za0h.h[w12, 5], p0/m, z5.h
; CHECK-NEXT:    mov za0v.h[w12, 6], p0/m, z6.h
; CHECK-NEXT:    mov za0v.h[w12, 7], p0/m, z7.h
; CHECK-NEXT:    ret
                          <vscale x 8 x bfloat> %z0, <vscale x 8 x bfloat> %z1,
                          <vscale x 8 x bfloat> %z2, <vscale x 8 x bfloat> %z3,
                          <vscale x 8 x bfloat> %z4, <vscale x 8 x bfloat> %z5,
                          <vscale x 8 x bfloat> %z6, <vscale x 8 x bfloat> %z7) {
  call void @llvm.aarch64.sme.write.horiz.nxv8bf16(i32 0, i32 %tileslice, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z0)
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.horiz.nxv8bf16(i32 0, i32 %tileslice.1, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z1)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.vert.nxv8bf16(i32 0, i32 %tileslice.2, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z2)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv8bf16(i32 0, i32 %tileslice.3, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z3)
  %tileslice.4 = add i32 %tileslice, 4
  call void @llvm.aarch64.sme.write.horiz.nxv8bf16(i32 0, i32 %tileslice.4, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z4)
  %tileslice.5 = add i32 %tileslice, 5
  call void @llvm.aarch64.sme.write.horiz.nxv8bf16(i32 0, i32 %tileslice.5, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z5)
  %tileslice.6 = add i32 %tileslice, 6
  call void @llvm.aarch64.sme.write.vert.nxv8bf16(i32 0, i32 %tileslice.6, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z6)
  %tileslice.7 = add i32 %tileslice, 7
  call void @llvm.aarch64.sme.write.vert.nxv8bf16(i32 0, i32 %tileslice.7, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %z7)
  ret void
}

define void @insert_row_s(i32 %tileslice, <vscale x 4 x i1> %pg,
; CHECK-LABEL: insert_row_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.s[w12, 0], p0/m, z0.s
; CHECK-NEXT:    mov za0h.s[w12, 2], p0/m, z2.s
; CHECK-NEXT:    ret
                          <vscale x 4 x i32> %z0, <vscale x 4 x i32> %z1,
                          <vscale x 4 x i32> %z2, <vscale x 4 x i32> %z3) {
  call void @llvm.aarch64.sme.write.horiz.nxv4i32(i32 0, i32 %tileslice, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %z0)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.horiz.nxv4i32(i32 0, i32 %tileslice.2, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %z2)
  ret void
}

define void @insert_col_s(i32 %tileslice, <vscale x 4 x i1> %pg,
; CHECK-LABEL: insert_col_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za3v.s[w12, 1], p0/m, z1.s
; CHECK-NEXT:    mov za3v.s[w12, 3], p0/m, z3.s
; CHECK-NEXT:    ret
                          <vscale x 4 x i32> %z0, <vscale x 4 x i32> %z1,
                          <vscale x 4 x i32> %z2, <vscale x 4 x i32> %z3) {
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.vert.nxv4i32(i32 3, i32 %tileslice.1, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %z1)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv4i32(i32 3, i32 %tileslice.3, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %z3)
  ret void
}

define void @insert_f32(i32 %tileslice, <vscale x 4 x i1> %pg,
; CHECK-LABEL: insert_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.s[w12, 0], p0/m, z0.s
; CHECK-NEXT:    mov za0h.s[w12, 1], p0/m, z1.s
; CHECK-NEXT:    mov za0v.s[w12, 2], p0/m, z2.s
; CHECK-NEXT:    mov za0v.s[w12, 3], p0/m, z3.s
; CHECK-NEXT:    ret
                          <vscale x 4 x float> %z0, <vscale x 4 x float> %z1,
                          <vscale x 4 x float> %z2, <vscale x 4 x float> %z3) {
  call void @llvm.aarch64.sme.write.horiz.nxv4f32(i32 0, i32 %tileslice, <vscale x 4 x i1> %pg, <vscale x 4 x float> %z0)
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.horiz.nxv4f32(i32 0, i32 %tileslice.1, <vscale x 4 x i1> %pg, <vscale x 4 x float> %z1)
  %tileslice.2 = add i32 %tileslice, 2
  call void @llvm.aarch64.sme.write.vert.nxv4f32(i32 0, i32 %tileslice.2, <vscale x 4 x i1> %pg, <vscale x 4 x float> %z2)
  %tileslice.3 = add i32 %tileslice, 3
  call void @llvm.aarch64.sme.write.vert.nxv4f32(i32 0, i32 %tileslice.3, <vscale x 4 x i1> %pg, <vscale x 4 x float> %z3)
  ret void
}

define void @insert_row_d(i32 %tileslice, <vscale x 2 x i1> %pg,
; CHECK-LABEL: insert_row_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.d[w12, 0], p0/m, z0.d
; CHECK-NEXT:    ret
                          <vscale x 2 x i64> %z0, <vscale x 2 x i64> %z1) {
  call void @llvm.aarch64.sme.write.horiz.nxv2i64(i32 0, i32 %tileslice, <vscale x 2 x i1> %pg, <vscale x 2 x i64> %z0)
  ret void
}

define void @insert_col_d(i32 %tileslice, <vscale x 2 x i1> %pg,
; CHECK-LABEL: insert_col_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za7v.d[w12, 1], p0/m, z1.d
; CHECK-NEXT:    ret
                          <vscale x 2 x i64> %z0, <vscale x 2 x i64> %z1) {
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.vert.nxv2i64(i32 7, i32 %tileslice.1, <vscale x 2 x i1> %pg, <vscale x 2 x i64> %z1)
  ret void
}

define void @insert_f64(i32 %tileslice, <vscale x 2 x i1> %pg,
; CHECK-LABEL: insert_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov za0h.d[w12, 0], p0/m, z0.d
; CHECK-NEXT:    mov za0v.d[w12, 1], p0/m, z1.d
; CHECK-NEXT:    ret
                          <vscale x 2 x double> %z0, <vscale x 2 x double> %z1) {
  call void @llvm.aarch64.sme.write.horiz.nxv2f64(i32 0, i32 %tileslice, <vscale x 2 x i1> %pg, <vscale x 2 x double> %z0)
  %tileslice.1 = add i32 %tileslice, 1
  call void @llvm.aarch64.sme.write.vert.nxv2f64(i32 0, i32 %tileslice.1, <vscale x 2 x i1> %pg, <vscale x 2 x double> %z1)
  ret void
}

define void @insert_row_q_v16i8(<vscale x 16 x i1> %pg, <vscale x 16 x i8> %zn) {
; CHECK-LABEL: insert_row_q_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv16i8(i32 0, i32 0, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %zn)
  ret void
}

define void @insert_row_q_v8i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %zn) {
; CHECK-LABEL: insert_row_q_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv8i16(i32 0, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %zn)
  ret void
}

define void @insert_row_q_v8f16(<vscale x 8 x i1> %pg, <vscale x 8 x half> %zn) {
; CHECK-LABEL: insert_row_q_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv8f16(i32 0, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x half> %zn)
  ret void
}

define void @insert_row_q_v8bf16(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %zn) {
; CHECK-LABEL: insert_row_q_v8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv8bf16(i32 0, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %zn)
  ret void
}

define void @insert_row_q_v4i32(<vscale x 4 x i1> %pg, <vscale x 4 x i32> %zn) {
; CHECK-LABEL: insert_row_q_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv4i32(i32 0, i32 0, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %zn)
  ret void
}

define void @insert_row_q_v4f32(<vscale x 4 x i1> %pg, <vscale x 4 x float> %zn) {
; CHECK-LABEL: insert_row_q_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv4f32(i32 0, i32 0, <vscale x 4 x i1> %pg, <vscale x 4 x float> %zn)
  ret void
}

define void @insert_row_q_v2i64(<vscale x 2 x i1> %pg, <vscale x 2 x i64> %zn) {
; CHECK-LABEL: insert_row_q_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv2i64(i32 0, i32 0, <vscale x 2 x i1> %pg, <vscale x 2 x i64> %zn)
  ret void
}

define void @insert_row_q_v2f64(<vscale x 2 x i1> %pg, <vscale x 2 x double> %zn) {
; CHECK-LABEL: insert_row_q_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za0h.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.horiz.nxv2f64(i32 0, i32 0, <vscale x 2 x i1> %pg, <vscale x 2 x double> %zn)
  ret void
}

define void @insert_col_q_v16i8(<vscale x 16 x i1> %pg, <vscale x 16 x i8> %zn) {
; CHECK-LABEL: insert_col_q_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv16i8(i32 15, i32 0, <vscale x 16 x i1> %pg, <vscale x 16 x i8> %zn)
  ret void
}

define void @insert_col_q_v8i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %zn) {
; CHECK-LABEL: insert_col_q_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv8i16(i32 15, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x i16> %zn)
  ret void
}

define void @insert_col_q_v8f16(<vscale x 8 x i1> %pg, <vscale x 8 x half> %zn) {
; CHECK-LABEL: insert_col_q_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv8f16(i32 15, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x half> %zn)
  ret void
}

define void @insert_col_q_v8bf16(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %zn) {
; CHECK-LABEL: insert_col_q_v8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv8bf16(i32 15, i32 0, <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %zn)
  ret void
}

define void @insert_col_q_v4i32(<vscale x 4 x i1> %pg, <vscale x 4 x i32> %zn) {
; CHECK-LABEL: insert_col_q_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv4i32(i32 15, i32 0, <vscale x 4 x i1> %pg, <vscale x 4 x i32> %zn)
  ret void
}

define void @insert_col_q_v4f32(<vscale x 4 x i1> %pg, <vscale x 4 x float> %zn) {
; CHECK-LABEL: insert_col_q_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv4f32(i32 15, i32 0, <vscale x 4 x i1> %pg, <vscale x 4 x float> %zn)
  ret void
}

define void @insert_col_q_v2i64(<vscale x 2 x i1> %pg, <vscale x 2 x i64> %zn) {
; CHECK-LABEL: insert_col_q_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv2i64(i32 15, i32 0, <vscale x 2 x i1> %pg, <vscale x 2 x i64> %zn)
  ret void
}

define void @insert_col_q_v2f64(<vscale x 2 x i1> %pg, <vscale x 2 x double> %zn) {
; CHECK-LABEL: insert_col_q_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov za15v.q[w12, 0], p0/m, z0.q
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.writeq.vert.nxv2f64(i32 15, i32 0, <vscale x 2 x i1> %pg, <vscale x 2 x double> %zn)
  ret void
}

define void @test_sink_offset_operand(<vscale x 4 x i1> %pg, i32 %base, i32 %N) {
; CHECK-LABEL: test_sink_offset_operand:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:  .LBB28_1: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    subs w1, w1, #3
; CHECK-NEXT:    mov za0h.s[w12, 0], p0/m, z0.s
; CHECK-NEXT:    mov za0h.s[w12, 1], p0/m, z0.s
; CHECK-NEXT:    mov za0h.s[w12, 2], p0/m, z0.s
; CHECK-NEXT:    b.ne .LBB28_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  %add1 = add i32 %base, 1
  %add2 = add i32 %base, 2
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  call void @llvm.aarch64.sme.write.horiz.nxv4i32(i32 0, i32 %base, <vscale x 4 x i1> %pg, <vscale x 4 x i32> zeroinitializer)
  call void @llvm.aarch64.sme.write.horiz.nxv4i32(i32 0, i32 %add1, <vscale x 4 x i1> %pg, <vscale x 4 x i32> zeroinitializer)
  call void @llvm.aarch64.sme.write.horiz.nxv4i32(i32 0, i32 %add2, <vscale x 4 x i1> %pg, <vscale x 4 x i32> zeroinitializer)
  %inc = add nuw nsw i32 %i, 3
  %exitcond.not = icmp eq i32 %inc, %N
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  ret void
}

declare void @llvm.aarch64.sme.write.horiz.nxv16i8(i32, i32, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare void @llvm.aarch64.sme.write.horiz.nxv8i16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare void @llvm.aarch64.sme.write.horiz.nxv8f16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x half>)
declare void @llvm.aarch64.sme.write.horiz.nxv8bf16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x bfloat>)
declare void @llvm.aarch64.sme.write.horiz.nxv4i32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.aarch64.sme.write.horiz.nxv4f32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x float>)
declare void @llvm.aarch64.sme.write.horiz.nxv2i64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x i64>)
declare void @llvm.aarch64.sme.write.horiz.nxv2f64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x double>)
declare void @llvm.aarch64.sme.write.vert.nxv16i8(i32, i32, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare void @llvm.aarch64.sme.write.vert.nxv8i16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare void @llvm.aarch64.sme.write.vert.nxv8f16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x half>)
declare void @llvm.aarch64.sme.write.vert.nxv8bf16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x bfloat>)
declare void @llvm.aarch64.sme.write.vert.nxv4i32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.aarch64.sme.write.vert.nxv4f32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x float>)
declare void @llvm.aarch64.sme.write.vert.nxv2i64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x i64>)
declare void @llvm.aarch64.sme.write.vert.nxv2f64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x double>)

declare void @llvm.aarch64.sme.writeq.horiz.nxv16i8(i32, i32, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv8i16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv8f16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x half>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv8bf16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x bfloat>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv4i32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv4f32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x float>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv2i64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x i64>)
declare void @llvm.aarch64.sme.writeq.horiz.nxv2f64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x double>)
declare void @llvm.aarch64.sme.writeq.vert.nxv16i8(i32, i32, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare void @llvm.aarch64.sme.writeq.vert.nxv8i16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare void @llvm.aarch64.sme.writeq.vert.nxv8f16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x half>)
declare void @llvm.aarch64.sme.writeq.vert.nxv8bf16(i32, i32, <vscale x 8 x i1>, <vscale x 8 x bfloat>)
declare void @llvm.aarch64.sme.writeq.vert.nxv4i32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.aarch64.sme.writeq.vert.nxv4f32(i32, i32, <vscale x 4 x i1>, <vscale x 4 x float>)
declare void @llvm.aarch64.sme.writeq.vert.nxv2i64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x i64>)
declare void @llvm.aarch64.sme.writeq.vert.nxv2f64(i32, i32, <vscale x 2 x i1>, <vscale x 2 x double>)
