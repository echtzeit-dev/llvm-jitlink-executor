; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512bf16 -mattr=+avx512vl --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bf16 -mattr=+avx512vl --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64

declare <8 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.128(<4 x float>, <4 x float>) #1

define <2 x i64> @test_mm_cvtne2ps2bf16_128(<4 x float> %A, <4 x float> %B) local_unnamed_addr #0 {
; CHECK-LABEL: test_mm_cvtne2ps2bf16_128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vcvtne2ps2bf16 %xmm1, %xmm0, %xmm0 # encoding: [0x62,0xf2,0x7f,0x08,0x72,0xc1]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.128(<4 x float> %A, <4 x float> %B) #2
  %1 = bitcast <8 x i16> %0 to <2 x i64>
  ret <2 x i64> %1
}

define <2 x i64> @test_mm_maskz_cvtne2ps2bf16_128(<4 x float> %A, <4 x float> %B, i8 zeroext %U) local_unnamed_addr #0 {
; X86-LABEL: test_mm_maskz_cvtne2ps2bf16_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtne2ps2bf16 %xmm1, %xmm0, %xmm0 # encoding: [0x62,0xf2,0x7f,0x08,0x72,0xc1]
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vmovdqu16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0x89,0x6f,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm_maskz_cvtne2ps2bf16_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtne2ps2bf16 %xmm1, %xmm0, %xmm0 # encoding: [0x62,0xf2,0x7f,0x08,0x72,0xc1]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0x89,0x6f,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.128(<4 x float> %A, <4 x float> %B) #2
  %1 = bitcast i8 %U to <8 x i1>
  %2 = select <8 x i1> %1, <8 x i16> %0, <8 x i16> zeroinitializer
  %3 = bitcast <8 x i16> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <2 x i64> @test_mm_mask_cvtne2ps2bf16_128(<2 x i64> %C, i8 zeroext %U, <4 x float> %A, <4 x float> %B) local_unnamed_addr #0 {
; X86-LABEL: test_mm_mask_cvtne2ps2bf16_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtne2ps2bf16 %xmm2, %xmm1, %xmm1 # encoding: [0x62,0xf2,0x77,0x08,0x72,0xca]
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm_mask_cvtne2ps2bf16_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtne2ps2bf16 %xmm2, %xmm1, %xmm1 # encoding: [0x62,0xf2,0x77,0x08,0x72,0xca]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.128(<4 x float> %A, <4 x float> %B) #2
  %1 = bitcast <2 x i64> %C to <8 x i16>
  %2 = bitcast i8 %U to <8 x i1>
  %3 = select <8 x i1> %2, <8 x i16> %0, <8 x i16> %1
  %4 = bitcast <8 x i16> %3 to <2 x i64>
  ret <2 x i64> %4
}

declare <16 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.256(<8 x float>, <8 x float>) #3

define <4 x i64> @test_mm256_cvtne2ps2bf16_256(<8 x float> %A, <8 x float> %B) local_unnamed_addr #1 {
; CHECK-LABEL: test_mm256_cvtne2ps2bf16_256:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vcvtne2ps2bf16 %ymm1, %ymm0, %ymm0 # encoding: [0x62,0xf2,0x7f,0x28,0x72,0xc1]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <16 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.256(<8 x float> %A, <8 x float> %B) #4
  %1 = bitcast <16 x i16> %0 to <4 x i64>
  ret <4 x i64> %1
}

define <4 x i64> @test_mm256_maskz_cvtne2ps2bf16_256(<8 x float> %A, <8 x float> %B, i16 zeroext %U) local_unnamed_addr #1 {
; X86-LABEL: test_mm256_maskz_cvtne2ps2bf16_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtne2ps2bf16 %ymm1, %ymm0, %ymm0 # encoding: [0x62,0xf2,0x7f,0x28,0x72,0xc1]
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vmovdqu16 %ymm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0xa9,0x6f,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_maskz_cvtne2ps2bf16_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtne2ps2bf16 %ymm1, %ymm0, %ymm0 # encoding: [0x62,0xf2,0x7f,0x28,0x72,0xc1]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %ymm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0xa9,0x6f,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <16 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.256(<8 x float> %A, <8 x float> %B) #4
  %1 = bitcast i16 %U to <16 x i1>
  %2 = select <16 x i1> %1, <16 x i16> %0, <16 x i16> zeroinitializer
  %3 = bitcast <16 x i16> %2 to <4 x i64>
  ret <4 x i64> %3
}

define <4 x i64> @test_mm256_mask_cvtne2ps2bf16_256(<4 x i64> %C, i16 zeroext %U, <8 x float> %A, <8 x float> %B) local_unnamed_addr #1 {
; X86-LABEL: test_mm256_mask_cvtne2ps2bf16_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtne2ps2bf16 %ymm2, %ymm1, %ymm1 # encoding: [0x62,0xf2,0x77,0x28,0x72,0xca]
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vmovdqu16 %ymm1, %ymm0 {%k1} # encoding: [0x62,0xf1,0xff,0x29,0x6f,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_mask_cvtne2ps2bf16_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtne2ps2bf16 %ymm2, %ymm1, %ymm1 # encoding: [0x62,0xf2,0x77,0x28,0x72,0xca]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %ymm1, %ymm0 {%k1} # encoding: [0x62,0xf1,0xff,0x29,0x6f,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <16 x i16> @llvm.x86.avx512bf16.cvtne2ps2bf16.256(<8 x float> %A, <8 x float> %B) #4
  %1 = bitcast <4 x i64> %C to <16 x i16>
  %2 = bitcast i16 %U to <16 x i1>
  %3 = select <16 x i1> %2, <16 x i16> %0, <16 x i16> %1
  %4 = bitcast <16 x i16> %3 to <4 x i64>
  ret <4 x i64> %4
}

declare <8 x i16> @llvm.x86.avx512bf16.cvtneps2bf16.256(<8 x float>) #3

define <2 x i64> @test_mm256_cvtneps2bf16_256(<8 x float> %A) local_unnamed_addr #2 {
; CHECK-LABEL: test_mm256_cvtneps2bf16_256:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vcvtneps2bf16 %ymm0, %xmm0 # encoding: [0x62,0xf2,0x7e,0x28,0x72,0xc0]
; CHECK-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtneps2bf16.256(<8 x float> %A) #4
  %1 = bitcast <8 x i16> %0 to <2 x i64>
  ret <2 x i64> %1
}

define <2 x i64> @test_mm256_maskz_cvtneps2bf16_256(<8 x float> %A, i8 zeroext %U) local_unnamed_addr #2 {
; X86-LABEL: test_mm256_maskz_cvtneps2bf16_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtneps2bf16 %ymm0, %xmm0 # encoding: [0x62,0xf2,0x7e,0x28,0x72,0xc0]
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vmovdqu16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0x89,0x6f,0xc0]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_maskz_cvtneps2bf16_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtneps2bf16 %ymm0, %xmm0 # encoding: [0x62,0xf2,0x7e,0x28,0x72,0xc0]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf1,0xff,0x89,0x6f,0xc0]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtneps2bf16.256(<8 x float> %A) #4
  %1 = bitcast i8 %U to <8 x i1>
  %2 = select <8 x i1> %1, <8 x i16> %0, <8 x i16> zeroinitializer
  %3 = bitcast <8 x i16> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <2 x i64> @test_mm256_mask_cvtneps2bf16_256(<2 x i64> %C, i8 zeroext %U, <8 x float> %A) local_unnamed_addr #2 {
; X86-LABEL: test_mm256_mask_cvtneps2bf16_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vcvtneps2bf16 %ymm1, %xmm1 # encoding: [0x62,0xf2,0x7e,0x28,0x72,0xc9]
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_mask_cvtneps2bf16_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vcvtneps2bf16 %ymm1, %xmm1 # encoding: [0x62,0xf2,0x7e,0x28,0x72,0xc9]
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.cvtneps2bf16.256(<8 x float> %A) #4
  %1 = bitcast <2 x i64> %C to <8 x i16>
  %2 = bitcast i8 %U to <8 x i1>
  %3 = select <8 x i1> %2, <8 x i16> %0, <8 x i16> %1
  %4 = bitcast <8 x i16> %3 to <2 x i64>
  ret <2 x i64> %4
}

declare <8 x i16> @llvm.x86.avx512bf16.mask.cvtneps2bf16.128(<4 x float>, <8 x i16>, <4 x i1>) #3

define <2 x i64> @test_mm128_cvtneps2bf16_128(<4 x float> %A) local_unnamed_addr #2 {
; CHECK-LABEL: test_mm128_cvtneps2bf16_128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vcvtneps2bf16 %xmm0, %xmm0 # encoding: [0x62,0xf2,0x7e,0x08,0x72,0xc0]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <8 x i16> @llvm.x86.avx512bf16.mask.cvtneps2bf16.128(<4 x float> %A, <8 x i16> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>) #4
  %1 = bitcast <8 x i16> %0 to <2 x i64>
  ret <2 x i64> %1
}

define <2 x i64> @test_mm128_maskz_cvtneps2bf16_128(<4 x float> %A, i8 zeroext %U) local_unnamed_addr #2 {
; X86-LABEL: test_mm128_maskz_cvtneps2bf16_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vcvtneps2bf16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf2,0x7e,0x89,0x72,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm128_maskz_cvtneps2bf16_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvtneps2bf16 %xmm0, %xmm0 {%k1} {z} # encoding: [0x62,0xf2,0x7e,0x89,0x72,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = bitcast i8 %U to <8 x i1>
  %1 = shufflevector <8 x i1> %0, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <8 x i16> @llvm.x86.avx512bf16.mask.cvtneps2bf16.128(<4 x float> %A, <8 x i16> zeroinitializer, <4 x i1> %1) #4
  %3 = bitcast <8 x i16> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <2 x i64> @test_mm128_mask_cvtneps2bf16_128(<2 x i64> %C, i8 zeroext %U, <4 x float> %A) local_unnamed_addr #2 {
; X86-LABEL: test_mm128_mask_cvtneps2bf16_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vcvtneps2bf16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf2,0x7e,0x09,0x72,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm128_mask_cvtneps2bf16_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvtneps2bf16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf2,0x7e,0x09,0x72,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = bitcast i8 %U to <8 x i1>
  %1 = shufflevector <8 x i1> %0, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = bitcast <2 x i64> %C to <8 x i16>
  %3 = tail call <8 x i16> @llvm.x86.avx512bf16.mask.cvtneps2bf16.128(<4 x float> %A, <8 x i16> %2, <4 x i1> %1) #4
  %4 = bitcast <8 x i16> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Make sure we don't fold a select into the 128 bit form of cvtneps2bf16. It
; always writes zeros to bits 127:64 regardless of mask.
define <2 x i64> @test_mm128_cvtneps2bf16_128_select(<2 x i64> %C, i8 zeroext %U, <4 x float> %A) local_unnamed_addr #2 {
; X86-LABEL: test_mm128_cvtneps2bf16_128_select:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vcvtneps2bf16 %xmm1, %xmm1 # encoding: [0x62,0xf2,0x7e,0x08,0x72,0xc9]
; X86-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm128_cvtneps2bf16_128_select:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvtneps2bf16 %xmm1, %xmm1 # encoding: [0x62,0xf2,0x7e,0x08,0x72,0xc9]
; X64-NEXT:    vmovdqu16 %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = bitcast i8 %U to <8 x i1>
  %1 = bitcast <2 x i64> %C to <8 x i16>
  %2 = tail call <8 x i16> @llvm.x86.avx512bf16.mask.cvtneps2bf16.128(<4 x float> %A, <8 x i16> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>) #4
  %3 = select <8 x i1> %0, <8 x i16> %2, <8 x i16> %1
  %4 = bitcast <8 x i16> %3 to <2 x i64>
  ret <2 x i64> %4
}

declare <8 x float> @llvm.x86.avx512bf16.dpbf16ps.256(<8 x float>, <8 x i32>, <8 x i32>) #3

define <8 x float> @test_mm256_dpbf16ps_256(<8 x float> %E, <8 x i32> %A, <8 x i32> %B) local_unnamed_addr #2 {
; CHECK-LABEL: test_mm256_dpbf16ps_256:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vdpbf16ps %ymm2, %ymm1, %ymm0 # encoding: [0x62,0xf2,0x76,0x28,0x52,0xc2]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <8 x float> @llvm.x86.avx512bf16.dpbf16ps.256(<8 x float> %E, <8 x i32> %A, <8 x i32> %B) #4
  ret <8 x float> %0
}

define <8 x float> @test_mm256_maskz_dpbf16ps_256(<8 x float> %E, <8 x i32> %A, <8 x i32> %B, i8 zeroext %U) local_unnamed_addr #2 {
; X86-LABEL: test_mm256_maskz_dpbf16ps_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vdpbf16ps %ymm2, %ymm1, %ymm0 {%k1} {z} # encoding: [0x62,0xf2,0x76,0xa9,0x52,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_maskz_dpbf16ps_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vdpbf16ps %ymm2, %ymm1, %ymm0 {%k1} {z} # encoding: [0x62,0xf2,0x76,0xa9,0x52,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x float> @llvm.x86.avx512bf16.dpbf16ps.256(<8 x float> %E, <8 x i32> %A, <8 x i32> %B) #4
  %1 = bitcast i8 %U to <8 x i1>
  %2 = select <8 x i1> %1, <8 x float> %0, <8 x float> zeroinitializer
  ret <8 x float> %2
}
define <8 x float> @test_mm256_mask_dpbf16ps_256(i8 zeroext %U, <8 x float> %E, <8 x i32> %A, <8 x i32> %B) local_unnamed_addr #2 {
; X86-LABEL: test_mm256_mask_dpbf16ps_256:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vdpbf16ps %ymm2, %ymm1, %ymm0 {%k1} # encoding: [0x62,0xf2,0x76,0x29,0x52,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm256_mask_dpbf16ps_256:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vdpbf16ps %ymm2, %ymm1, %ymm0 {%k1} # encoding: [0x62,0xf2,0x76,0x29,0x52,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <8 x float> @llvm.x86.avx512bf16.dpbf16ps.256(<8 x float> %E, <8 x i32> %A, <8 x i32> %B) #4
  %1 = bitcast i8 %U to <8 x i1>
  %2 = select <8 x i1> %1, <8 x float> %0, <8 x float> %E
  ret <8 x float> %2
}

declare <4 x float> @llvm.x86.avx512bf16.dpbf16ps.128(<4 x float>, <4 x i32>, <4 x i32>) #3

define <4 x float> @test_mm128_dpbf16ps_128(<4 x float> %E, <4 x i32> %A, <4 x i32> %B) local_unnamed_addr #2 {
; CHECK-LABEL: test_mm128_dpbf16ps_128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vdpbf16ps %xmm2, %xmm1, %xmm0 # encoding: [0x62,0xf2,0x76,0x08,0x52,0xc2]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
entry:
  %0 = tail call <4 x float> @llvm.x86.avx512bf16.dpbf16ps.128(<4 x float> %E, <4 x i32> %A, <4x i32> %B) #4
  ret <4 x float> %0
}

define <4 x float> @test_mm128_maskz_dpbf16ps_128(<4 x float> %E, <4 x i32> %A, <4 x i32> %B, i4 zeroext %U) local_unnamed_addr #2 {
; X86-LABEL: test_mm128_maskz_dpbf16ps_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vdpbf16ps %xmm2, %xmm1, %xmm0 {%k1} {z} # encoding: [0x62,0xf2,0x76,0x89,0x52,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm128_maskz_dpbf16ps_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vdpbf16ps %xmm2, %xmm1, %xmm0 {%k1} {z} # encoding: [0x62,0xf2,0x76,0x89,0x52,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <4 x float> @llvm.x86.avx512bf16.dpbf16ps.128(<4 x float> %E, <4 x i32> %A, <4 x i32> %B) #4
  %1 = bitcast i4 %U to <4 x i1>
  %2 = select <4 x i1> %1, <4 x float> %0, <4 x float> zeroinitializer
  ret <4 x float> %2
}
define <4 x float> @test_mm128_mask_dpbf16ps_128(i4 zeroext %U, <4 x float> %E, <4 x i32> %A, <4 x i32> %B) local_unnamed_addr #2 {
; X86-LABEL: test_mm128_mask_dpbf16ps_128:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax # encoding: [0x0f,0xb6,0x44,0x24,0x04]
; X86-NEXT:    kmovd %eax, %k1 # encoding: [0xc5,0xfb,0x92,0xc8]
; X86-NEXT:    vdpbf16ps %xmm2, %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf2,0x76,0x09,0x52,0xc2]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm128_mask_dpbf16ps_128:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vdpbf16ps %xmm2, %xmm1, %xmm0 {%k1} # encoding: [0x62,0xf2,0x76,0x09,0x52,0xc2]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call <4 x float> @llvm.x86.avx512bf16.dpbf16ps.128(<4 x float> %E, <4 x i32> %A, <4 x i32> %B) #4
  %1 = bitcast i4 %U to <4 x i1>
  %2 = select <4 x i1> %1, <4 x float> %0, <4 x float> %E
  ret <4 x float> %2
}
