; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=hexagon < %s | FileCheck %s

define void @f0(ptr %a0, ptr %a1, ptr %a2) #0 {
; CHECK-LABEL: f0:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r7 = #-4
; CHECK-NEXT:     v0 = vmem(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1 = vmem(r1+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1:0.w = vmpy(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1:0.w = vadd(v1:0.w,v1:0.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v1:0 = vdeal(v1,v0,r7)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0.h = vpacko(v1.w,v0.w)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     vmem(r2+#0) = v0.new
; CHECK-NEXT:    }
b0:
  %v0 = load <64 x i16>, ptr %a0, align 128
  %v1 = load <64 x i16>, ptr %a1, align 128
  %v2 = sext <64 x i16> %v0 to <64 x i32>
  %v3 = sext <64 x i16> %v1 to <64 x i32>
  %0 = trunc <64 x i32> %v2 to <64 x i16>
  %1 = trunc <64 x i32> %v3 to <64 x i16>
  %2 = bitcast <64 x i16> %0 to <32 x i32>
  %3 = bitcast <64 x i16> %1 to <32 x i32>
  %4 = call <64 x i32> @llvm.hexagon.V6.vmpyhv.128B(<32 x i32> %2, <32 x i32> %3)
  %5 = add <64 x i32> %4, %4
  %6 = shufflevector <64 x i32> %5, <64 x i32> %5, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %7 = shufflevector <64 x i32> %5, <64 x i32> %5, <32 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %8 = shufflevector <32 x i32> %6, <32 x i32> %7, <64 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30, i32 32, i32 34, i32 36, i32 38, i32 40, i32 42, i32 44, i32 46, i32 48, i32 50, i32 52, i32 54, i32 56, i32 58, i32 60, i32 62, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31, i32 33, i32 35, i32 37, i32 39, i32 41, i32 43, i32 45, i32 47, i32 49, i32 51, i32 53, i32 55, i32 57, i32 59, i32 61, i32 63>
  %9 = bitcast <64 x i32> %8 to <128 x i16>
  %10 = shufflevector <128 x i16> %9, <128 x i16> poison, <64 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31, i32 33, i32 35, i32 37, i32 39, i32 41, i32 43, i32 45, i32 47, i32 49, i32 51, i32 53, i32 55, i32 57, i32 59, i32 61, i32 63, i32 65, i32 67, i32 69, i32 71, i32 73, i32 75, i32 77, i32 79, i32 81, i32 83, i32 85, i32 87, i32 89, i32 91, i32 93, i32 95, i32 97, i32 99, i32 101, i32 103, i32 105, i32 107, i32 109, i32 111, i32 113, i32 115, i32 117, i32 119, i32 121, i32 123, i32 125, i32 127>
  %11 = sext <64 x i16> %10 to <64 x i32>
  %v6 = trunc <64 x i32> %11 to <64 x i16>
  store <64 x i16> %v6, ptr %a2, align 128
  ret void
}

declare <64 x i32> @llvm.hexagon.V6.vmpyhv.128B(<32 x i32>, <32 x i32>) #0

attributes #0 = { nounwind "target-features"="+v66,+hvxv66,+hvx-length128b" }
