; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-pc-linux-gnu -mcpu=generic -mattr=sse2 -passes=slp-vectorizer -pass-remarks-output=%t < %s -slp-threshold=-2 | FileCheck %s
; RUN: FileCheck --input-file=%t --check-prefix=YAML %s

define void @fextr(ptr %ptr) {
; CHECK-LABEL: @fextr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load <8 x i16>, ptr undef, align 16
; CHECK-NEXT:    br label [[T:%.*]]
; CHECK:       t:
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <8 x i16> [[LD]], <8 x i16> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP0:%.*]] = add <8 x i16> [[LD]], [[SHUFFLE]]
; CHECK-NEXT:    store <8 x i16> [[TMP0]], ptr [[PTR:%.*]], align 2
; CHECK-NEXT:    ret void
;
; YAML:      Pass:            slp-vectorizer
; YAML-NEXT: Name:            StoresVectorized
; YAML-NEXT: Function:        fextr
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:   - Cost:            '-20'
; YAML-NEXT:   - String:          ' and with tree size '
; YAML-NEXT:   - TreeSize:        '4'

entry:
  %LD = load <8 x i16>, ptr undef
  %V0 = extractelement <8 x i16> %LD, i32 0
  br label %t

t:
  %V1 = extractelement <8 x i16> %LD, i32 1
  %V2 = extractelement <8 x i16> %LD, i32 2
  %V3 = extractelement <8 x i16> %LD, i32 3
  %V4 = extractelement <8 x i16> %LD, i32 4
  %V5 = extractelement <8 x i16> %LD, i32 5
  %V6 = extractelement <8 x i16> %LD, i32 6
  %V7 = extractelement <8 x i16> %LD, i32 7
  %P1 = getelementptr inbounds i16, ptr %ptr, i64 1
  %P2 = getelementptr inbounds i16, ptr %ptr, i64 2
  %P3 = getelementptr inbounds i16, ptr %ptr, i64 3
  %P4 = getelementptr inbounds i16, ptr %ptr, i64 4
  %P5 = getelementptr inbounds i16, ptr %ptr, i64 5
  %P6 = getelementptr inbounds i16, ptr %ptr, i64 6
  %P7 = getelementptr inbounds i16, ptr %ptr, i64 7
  %A0 = add i16 %V0, %V0
  %A1 = add i16 %V1, undef
  %A2 = add i16 %V2, %V0
  %A3 = add i16 %V3, %V0
  %A4 = add i16 %V4, %V0
  %A5 = add i16 %V5, %V0
  %A6 = add i16 %V6, %V0
  %A7 = add i16 %V7, %V0
  store i16 %A0, ptr %ptr, align 2
  store i16 %A1, ptr %P1, align 2
  store i16 %A2, ptr %P2, align 2
  store i16 %A3, ptr %P3, align 2
  store i16 %A4, ptr %P4, align 2
  store i16 %A5, ptr %P5, align 2
  store i16 %A6, ptr %P6, align 2
  store i16 %A7, ptr %P7, align 2
  ret void
}
