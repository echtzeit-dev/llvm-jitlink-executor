; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Check simplification of
; (icmp sgt x, -1) & (icmp sgt/sge n, x) --> icmp ugt/uge n, x

define i1 @test_and1(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and1(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sge i32 %x, 0
  %b = icmp slt i32 %x, %nn
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @test_and1_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and1_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[NN]], [[X]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A]], i1 [[B]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sge i32 %x, 0
  %b = icmp slt i32 %x, %nn
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @test_and2(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and2(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sgt i32 %x, -1
  %b = icmp sle i32 %x, %nn
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @test_and2_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and2_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[B:%.*]] = icmp sge i32 [[NN]], [[X]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A]], i1 [[B]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sgt i32 %x, -1
  %b = icmp sle i32 %x, %nn
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @test_and3(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and3(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sgt i32 %nn, %x
  %b = icmp sge i32 %x, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @test_and3_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and3_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sgt i32 %nn, %x
  %b = icmp sge i32 %x, 0
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @test_and4(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and4(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sge i32 %nn, %x
  %b = icmp sge i32 %x, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @test_and4_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_and4_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sge i32 %nn, %x
  %b = icmp sge i32 %x, 0
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @test_or1(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or1(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, 0
  %b = icmp sge i32 %x, %nn
  %c = or i1 %a, %b
  ret i1 %c
}

define i1 @test_or1_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or1_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp slt i32 [[X:%.*]], 0
; CHECK-NEXT:    [[B:%.*]] = icmp sle i32 [[NN]], [[X]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A]], i1 true, i1 [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, 0
  %b = icmp sge i32 %x, %nn
  %c = select i1 %a, i1 true, i1 %b
  ret i1 %c
}

define i1 @test_or2(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or2(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sle i32 %x, -1
  %b = icmp sgt i32 %x, %nn
  %c = or i1 %a, %b
  ret i1 %c
}

define i1 @test_or2_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or2_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp slt i32 [[X:%.*]], 0
; CHECK-NEXT:    [[B:%.*]] = icmp slt i32 [[NN]], [[X]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A]], i1 true, i1 [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sle i32 %x, -1
  %b = icmp sgt i32 %x, %nn
  %c = select i1 %a, i1 true, i1 %b
  ret i1 %c
}

define i1 @test_or3(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or3(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sle i32 %nn, %x
  %b = icmp slt i32 %x, 0
  %c = or i1 %a, %b
  ret i1 %c
}

define i1 @test_or3_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or3_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp sle i32 %nn, %x
  %b = icmp slt i32 %x, 0
  %c = select i1 %a, i1 true, i1 %b
  ret i1 %c
}

define i1 @test_or4(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or4(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %nn, %x
  %b = icmp slt i32 %x, 0
  %c = or i1 %a, %b
  ret i1 %c
}

define i1 @test_or4_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @test_or4_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %nn, %x
  %b = icmp slt i32 %x, 0
  %c = select i1 %a, i1 true, i1 %b
  ret i1 %c
}

; Negative tests

define i1 @negative1(i32 %x, i32 %n) {
; CHECK-LABEL: @negative1(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], 0
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sgt i32 %x, 0      ; should be: icmp sge
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @negative1_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @negative1_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], 0
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sgt i32 %x, 0      ; should be: icmp sge
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @negative2(i32 %x, i32 %n) {
; CHECK-LABEL: @negative2(
; CHECK-NEXT:    [[A:%.*]] = icmp slt i32 [[X:%.*]], [[N:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %a = icmp slt i32 %x, %n     ; n can be negative
  %b = icmp sge i32 %x, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @negative2_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @negative2_logical(
; CHECK-NEXT:    [[A:%.*]] = icmp slt i32 [[X:%.*]], [[N:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %a = icmp slt i32 %x, %n     ; n can be negative
  %b = icmp sge i32 %x, 0
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @negative3(i32 %x, i32 %y, i32 %n) {
; CHECK-LABEL: @negative3(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[Y:%.*]], -1
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sge i32 %y, 0      ; should compare %x and not %y
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @negative3_logical(i32 %x, i32 %y, i32 %n) {
; CHECK-LABEL: @negative3_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[Y:%.*]], -1
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A]], i1 [[B]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sge i32 %y, 0      ; should compare %x and not %y
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @negative4(i32 %x, i32 %n) {
; CHECK-LABEL: @negative4(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp ne i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp ne i32 %x, %nn     ; should be: icmp slt/sle
  %b = icmp sge i32 %x, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define i1 @negative4_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @negative4_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp ne i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp ne i32 %x, %nn     ; should be: icmp slt/sle
  %b = icmp sge i32 %x, 0
  %c = select i1 %a, i1 %b, i1 false
  ret i1 %c
}

define i1 @negative5(i32 %x, i32 %n) {
; CHECK-LABEL: @negative5(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = or i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sge i32 %x, 0
  %c = or i1 %a, %b            ; should be: and
  ret i1 %c
}

define i1 @negative5_logical(i32 %x, i32 %n) {
; CHECK-LABEL: @negative5_logical(
; CHECK-NEXT:    [[NN:%.*]] = and i32 [[N:%.*]], 2147483647
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i32 [[NN]], [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = icmp sgt i32 [[X]], -1
; CHECK-NEXT:    [[C:%.*]] = or i1 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %nn = and i32 %n, 2147483647
  %a = icmp slt i32 %x, %nn
  %b = icmp sge i32 %x, 0
  %c = select i1 %a, i1 true, i1 %b            ; should be: and
  ret i1 %c
}

