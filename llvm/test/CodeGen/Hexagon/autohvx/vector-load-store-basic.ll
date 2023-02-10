; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=hexagon < %s | FileCheck %s

define void @f0(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     v0.cur = vmem(r0+#1)
; CHECK-NEXT:     vmem(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x i8>, ptr %a0, i32 1
  %v1 = load <128 x i8>, ptr %v0, align 128
  %v2 = getelementptr <128 x i8>, ptr %a1, i32 2
  store <128 x i8> %v1, ptr %v2, align 128
  ret void
}

define void @f1(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     v0.cur = vmem(r0+#1)
; CHECK-NEXT:     vmem(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x i16>, ptr %a0, i32 1
  %v1 = load <64 x i16>, ptr %v0, align 128
  %v2 = getelementptr <64 x i16>, ptr %a1, i32 2
  store <64 x i16> %v1, ptr %v2, align 128
  ret void
}

define void @f2(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     v0.cur = vmem(r0+#1)
; CHECK-NEXT:     vmem(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <32 x i32>, ptr %a0, i32 1
  %v1 = load <32 x i32>, ptr %v0, align 128
  %v2 = getelementptr <32 x i32>, ptr %a1, i32 2
  store <32 x i32> %v1, ptr %v2, align 128
  ret void
}

define void @f3(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     v0.cur = vmem(r0+#1)
; CHECK-NEXT:     vmem(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x half>, ptr %a0, i32 1
  %v1 = load <64 x half>, ptr %v0, align 128
  %v2 = getelementptr <64 x half>, ptr %a1, i32 2
  store <64 x half> %v1, ptr %v2, align 128
  ret void
}

define void @f4(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     v0.cur = vmem(r0+#1)
; CHECK-NEXT:     vmem(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <32 x float>, ptr %a0, i32 1
  %v1 = load <32 x float>, ptr %v0, align 128
  %v2 = getelementptr <32 x float>, ptr %a1, i32 2
  store <32 x float> %v1, ptr %v2, align 128
  ret void
}

define void @f5(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x i8>, ptr %a0, i32 1
  %v1 = load <128 x i8>, ptr %v0, align 1
  %v2 = getelementptr <128 x i8>, ptr %a1, i32 2
  store <128 x i8> %v1, ptr %v2, align 1
  ret void
}

define void @f6(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x i16>, ptr %a0, i32 1
  %v1 = load <64 x i16>, ptr %v0, align 1
  %v2 = getelementptr <64 x i16>, ptr %a1, i32 2
  store <64 x i16> %v1, ptr %v2, align 1
  ret void
}

define void @f7(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <32 x i32>, ptr %a0, i32 1
  %v1 = load <32 x i32>, ptr %v0, align 1
  %v2 = getelementptr <32 x i32>, ptr %a1, i32 2
  store <32 x i32> %v1, ptr %v2, align 1
  ret void
}

define void @f8(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x half>, ptr %a0, i32 1
  %v1 = load <64 x half>, ptr %v0, align 1
  %v2 = getelementptr <64 x half>, ptr %a1, i32 2
  store <64 x half> %v1, ptr %v2, align 1
  ret void
}

define void @f9(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#2) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <32 x float>, ptr %a0, i32 1
  %v1 = load <32 x float>, ptr %v0, align 1
  %v2 = getelementptr <32 x float>, ptr %a1, i32 2
  store <32 x float> %v1, ptr %v2, align 1
  ret void
}

define void @f10(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmem(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1.cur = vmem(r0+#3)
; CHECK-NEXT:     vmem(r1+#5) = v1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r1+#4) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <256 x i8>, ptr %a0, i32 1
  %v1 = load <256 x i8>, ptr %v0, align 128
  %v2 = getelementptr <256 x i8>, ptr %a1, i32 2
  store <256 x i8> %v1, ptr %v2, align 128
  ret void
}

define void @f11(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmem(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1.cur = vmem(r0+#3)
; CHECK-NEXT:     vmem(r1+#5) = v1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r1+#4) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x i16>, ptr %a0, i32 1
  %v1 = load <128 x i16>, ptr %v0, align 128
  %v2 = getelementptr <128 x i16>, ptr %a1, i32 2
  store <128 x i16> %v1, ptr %v2, align 128
  ret void
}

define void @f12(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmem(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1.cur = vmem(r0+#3)
; CHECK-NEXT:     vmem(r1+#5) = v1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r1+#4) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x i32>, ptr %a0, i32 1
  %v1 = load <64 x i32>, ptr %v0, align 128
  %v2 = getelementptr <64 x i32>, ptr %a1, i32 2
  store <64 x i32> %v1, ptr %v2, align 128
  ret void
}

define void @f13(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmem(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1.cur = vmem(r0+#3)
; CHECK-NEXT:     vmem(r1+#5) = v1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r1+#4) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x half>, ptr %a0, i32 1
  %v1 = load <128 x half>, ptr %v0, align 128
  %v2 = getelementptr <128 x half>, ptr %a1, i32 2
  store <128 x half> %v1, ptr %v2, align 128
  ret void
}

define void @f14(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f14:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmem(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1.cur = vmem(r0+#3)
; CHECK-NEXT:     vmem(r1+#5) = v1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r1+#4) = v0
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x float>, ptr %a0, i32 1
  %v1 = load <64 x float>, ptr %v0, align 128
  %v2 = getelementptr <64 x float>, ptr %a1, i32 2
  store <64 x float> %v1, ptr %v2, align 128
  ret void
}

define void @f15(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f15:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmemu(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     vmemu(r1+#5) = v0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#4) = v1
; CHECK-NEXT:    }
  %v0 = getelementptr <256 x i8>, ptr %a0, i32 1
  %v1 = load <256 x i8>, ptr %v0, align 1
  %v2 = getelementptr <256 x i8>, ptr %a1, i32 2
  store <256 x i8> %v1, ptr %v2, align 1
  ret void
}

define void @f16(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmemu(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     vmemu(r1+#5) = v0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#4) = v1
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x i16>, ptr %a0, i32 1
  %v1 = load <128 x i16>, ptr %v0, align 1
  %v2 = getelementptr <128 x i16>, ptr %a1, i32 2
  store <128 x i16> %v1, ptr %v2, align 1
  ret void
}

define void @f17(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f17:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmemu(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     vmemu(r1+#5) = v0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#4) = v1
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x i32>, ptr %a0, i32 1
  %v1 = load <64 x i32>, ptr %v0, align 1
  %v2 = getelementptr <64 x i32>, ptr %a1, i32 2
  store <64 x i32> %v1, ptr %v2, align 1
  ret void
}

define void @f18(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f18:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmemu(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     vmemu(r1+#5) = v0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#4) = v1
; CHECK-NEXT:    }
  %v0 = getelementptr <128 x half>, ptr %a0, i32 1
  %v1 = load <128 x half>, ptr %v0, align 1
  %v2 = getelementptr <128 x half>, ptr %a1, i32 2
  store <128 x half> %v1, ptr %v2, align 1
  ret void
}

define void @f19(ptr %a0, ptr %a1) #0 {
; CHECK-LABEL: f19:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmemu(r0+#3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmemu(r0+#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     vmemu(r1+#5) = v0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmemu(r1+#4) = v1
; CHECK-NEXT:    }
  %v0 = getelementptr <64 x float>, ptr %a0, i32 1
  %v1 = load <64 x float>, ptr %v0, align 1
  %v2 = getelementptr <64 x float>, ptr %a1, i32 2
  store <64 x float> %v1, ptr %v2, align 1
  ret void
}


attributes #0 = { nounwind "target-cpu"="hexagonv69" "target-features"="+hvxv69,+hvx-length128b,+hvx-qfloat" }
