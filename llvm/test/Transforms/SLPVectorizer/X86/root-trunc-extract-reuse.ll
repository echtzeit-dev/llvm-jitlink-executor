; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -slp-threshold=-100 -mtriple=x86_64 < %s | FileCheck %s

define i1 @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK:       then:
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[TMP0:%.*]] = phi <2 x i32> [ zeroinitializer, [[THEN]] ], [ zeroinitializer, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <2 x i32> [[TMP0]] to <2 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = zext i8 [[TMP2]] to i32
; CHECK-NEXT:    [[BF_CAST162:%.*]] = and i32 [[TMP3]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x i32> zeroinitializer, <2 x i32> [[TMP0]], <2 x i32> <i32 3, i32 1>
; CHECK-NEXT:    [[T13:%.*]] = and <2 x i32> [[TMP4]], zeroinitializer
; CHECK-NEXT:    br label [[ELSE1:%.*]]
; CHECK:       else1:
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x i32> [[T13]], <2 x i32> poison, <2 x i32> <i32 undef, i32 0>
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <2 x i32> [[TMP5]], i32 [[BF_CAST162]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ugt <2 x i32> [[TMP6]], zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x i1> [[TMP7]], i32 1
; CHECK-NEXT:    ret i1 [[TMP8]]
;
entry:
  br i1 false, label %then, label %else

then:
  br label %else

else:
  %bf.load.off43 = phi i32 [ 0, %then ], [ 0, %entry ]
  %bf.load.off44 = phi i32 [ 0, %then ], [ 0, %entry ]
  %bf.cast162 = and i32 %bf.load.off43, 0
  %t12 = insertelement <2 x i32> zeroinitializer, i32 %bf.load.off44, i64 0
  %t13 = and <2 x i32> %t12, zeroinitializer
  br label %else1

else1:
  %cmp40 = icmp ugt i32 %bf.cast162, 0
  %t20 = extractelement <2 x i32> %t13, i64 0
  %cmp50 = icmp ugt i32 %t20, 0
  ret i1 %cmp50
}
