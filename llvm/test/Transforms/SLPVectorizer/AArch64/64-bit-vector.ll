; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64--linux-gnu -mcpu=generic < %s | FileCheck %s
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64-apple-ios -mcpu=cyclone < %s | FileCheck %s
; Currently disabled for a few subtargets (e.g. Kryo):
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64--linux-gnu -mcpu=kryo < %s | FileCheck --check-prefix=NO_SLP %s
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64--linux-gnu -mcpu=generic -slp-min-reg-size=128 < %s | FileCheck --check-prefix=NO_SLP %s

define void @f(ptr %r, ptr %w) {
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, ptr [[R:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <2 x float> [[TMP2]], [[TMP2]]
; CHECK-NEXT:    store <2 x float> [[TMP3]], ptr [[W:%.*]], align 4
; CHECK-NEXT:    ret void
;
; NO_SLP-LABEL: @f(
; NO_SLP-NEXT:    [[R1:%.*]] = getelementptr inbounds float, ptr [[R:%.*]], i64 1
; NO_SLP-NEXT:    [[F0:%.*]] = load float, ptr [[R]], align 4
; NO_SLP-NEXT:    [[F1:%.*]] = load float, ptr [[R1]], align 4
; NO_SLP-NEXT:    [[ADD0:%.*]] = fadd float [[F0]], [[F0]]
; NO_SLP-NEXT:    [[ADD1:%.*]] = fadd float [[F1]], [[F1]]
; NO_SLP-NEXT:    [[W1:%.*]] = getelementptr inbounds float, ptr [[W:%.*]], i64 1
; NO_SLP-NEXT:    store float [[ADD0]], ptr [[W]], align 4
; NO_SLP-NEXT:    store float [[ADD1]], ptr [[W1]], align 4
; NO_SLP-NEXT:    ret void
;
  %r1 = getelementptr inbounds float, ptr %r, i64 1
  %f0 = load float, ptr %r
  %f1 = load float, ptr %r1
  %add0 = fadd float %f0, %f0
  %add1 = fadd float %f1, %f1
  %w1 = getelementptr inbounds float, ptr %w, i64 1
  store float %add0, ptr %w
  store float %add1, ptr %w1
  ret void
}
