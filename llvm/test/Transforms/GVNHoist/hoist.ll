; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -opaque-pointers=0 -passes=gvn-hoist -S < %s | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@GlobalVar = internal global float 1.000000e+00

; Check that all scalar expressions are hoisted.
define float @scalarsHoisting(float %d, float %min, float %max, float %a) {
; CHECK-LABEL: @scalarsHoisting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[MIN:%.*]], [[A:%.*]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[MAX:%.*]], [[A]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL2]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sub = fsub float %min, %a
  %mul = fmul float %sub, %div
  %sub1 = fsub float %max, %a
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  %sub3 = fsub float %max, %a
  %mul4 = fmul float %sub3, %div
  %sub5 = fsub float %min, %a
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]
  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that all loads and scalars depending on the loads are hoisted.
; Check that getelementptr computation gets hoisted before the load.
define float @readsAndScalarsHoisting(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @readsAndScalarsHoisting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr float, float* [[MIN:%.*]], i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[A:%.*]] = getelementptr float, float* [[MIN]], i32 1
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[B:%.*]] = getelementptr float, float* [[MIN]], i32 1
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL2]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %A = getelementptr float, float* %min, i32 1
  %0 = load float, float* %A, align 4
  %1 = load float, float* %a, align 4
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %B = getelementptr float, float* %min, i32 1
  %5 = load float, float* %B, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]
  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we do not hoist loads after a store: the first two loads will be
; hoisted, and then the third load will not be hoisted.
define float @readsAndWrites(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @readsAndWrites(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store float [[TMP0]], float* @GlobalVar, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL4]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4
  store float %0, float* @GlobalVar
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]
  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we do hoist loads when the store is above the insertion point.
define float @readsAndWriteAboveInsertPt(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @readsAndWriteAboveInsertPt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    store float 0.000000e+00, float* @GlobalVar, align 4
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL2]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  store float 0.000000e+00, float* @GlobalVar
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]
  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that dependent expressions are hoisted.
define float @dependentScalarsHoisting(float %a, float %b, i1 %c) {
; CHECK-LABEL: @dependentScalarsHoisting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = fsub float [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    [[E:%.*]] = fadd float [[D]], [[A]]
; CHECK-NEXT:    [[F:%.*]] = fdiv float [[E]], [[A]]
; CHECK-NEXT:    [[G:%.*]] = fmul float [[F]], [[A]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[R:%.*]] = phi float [ [[G]], [[IF_THEN]] ], [ [[G]], [[IF_ELSE]] ]
; CHECK-NEXT:    ret float [[R]]
;
entry:
  br i1 %c, label %if.then, label %if.else

if.then:
  %d = fsub float %b, %a
  %e = fadd float %d, %a
  %f = fdiv float %e, %a
  %g = fmul float %f, %a
  br label %if.end

if.else:
  %h = fsub float %b, %a
  %i = fadd float %h, %a
  %j = fdiv float %i, %a
  %k = fmul float %j, %a
  br label %if.end

if.end:
  %r = phi float [ %g, %if.then ], [ %k, %if.else ]
  ret float %r
}

; Check that all independent expressions are hoisted.
define float @independentScalarsHoisting(float %a, float %b, i1 %c) {
; CHECK-LABEL: @independentScalarsHoisting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = fadd float [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    [[E:%.*]] = fsub float [[B]], [[A]]
; CHECK-NEXT:    [[F:%.*]] = fdiv float [[B]], [[A]]
; CHECK-NEXT:    [[G:%.*]] = fmul float [[B]], [[A]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[P:%.*]] = phi float [ [[D]], [[IF_THEN]] ], [ [[D]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[Q:%.*]] = phi float [ [[E]], [[IF_THEN]] ], [ [[E]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[R:%.*]] = phi float [ [[F]], [[IF_THEN]] ], [ [[F]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[S:%.*]] = phi float [ [[G]], [[IF_THEN]] ], [ [[G]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[T:%.*]] = fadd float [[P]], [[Q]]
; CHECK-NEXT:    [[U:%.*]] = fadd float [[R]], [[S]]
; CHECK-NEXT:    [[V:%.*]] = fadd float [[T]], [[U]]
; CHECK-NEXT:    ret float [[V]]
;
entry:
  br i1 %c, label %if.then, label %if.else

if.then:
  %d = fadd float %b, %a
  %e = fsub float %b, %a
  %f = fdiv float %b, %a
  %g = fmul float %b, %a
  br label %if.end

if.else:
  %i = fadd float %b, %a
  %h = fsub float %b, %a
  %j = fdiv float %b, %a
  %k = fmul float %b, %a
  br label %if.end

if.end:
  %p = phi float [ %d, %if.then ], [ %i, %if.else ]
  %q = phi float [ %e, %if.then ], [ %h, %if.else ]
  %r = phi float [ %f, %if.then ], [ %j, %if.else ]
  %s = phi float [ %g, %if.then ], [ %k, %if.else ]
  %t = fadd float %p, %q
  %u = fadd float %r, %s
  %v = fadd float %t, %u
  ret float %v
}

; Check that we hoist load and scalar expressions in triangles.
define float @triangleHoisting(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @triangleHoisting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB5:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL6:%.*]] = fmul float [[SUB5]], [[DIV]]
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[P1:%.*]] = phi float [ [[MUL4]], [[IF_THEN]] ], [ 0.000000e+00, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[P2:%.*]] = phi float [ [[MUL6]], [[IF_THEN]] ], [ 0.000000e+00, [[ENTRY]] ]
; CHECK-NEXT:    [[X:%.*]] = fadd float [[P1]], [[MUL6]]
; CHECK-NEXT:    [[Y:%.*]] = fadd float [[P2]], [[MUL4]]
; CHECK-NEXT:    [[Z:%.*]] = fadd float [[X]], [[Y]]
; CHECK-NEXT:    ret float [[Z]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.end:                                          ; preds = %entry
  %p1 = phi float [ %mul2, %if.then ], [ 0.000000e+00, %entry ]
  %p2 = phi float [ %mul, %if.then ], [ 0.000000e+00, %entry ]
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div

  %x = fadd float %p1, %mul6
  %y = fadd float %p2, %mul4
  %z = fadd float %x, %y
  ret float %z
}

; Check that we do not hoist loads past stores within a same basic block.
define i32 @noHoistInSingleBBWithStore() {
; CHECK-LABEL: @noHoistInSingleBBWithStore(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[D]] to i8*
; CHECK-NEXT:    [[BF:%.*]] = load i8, i8* [[TMP0]], align 4
; CHECK-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF]], -3
; CHECK-NEXT:    store i8 [[BF_CLEAR]], i8* [[TMP0]], align 4
; CHECK-NEXT:    [[BF1:%.*]] = load i8, i8* [[TMP0]], align 4
; CHECK-NEXT:    [[BF_CLEAR1:%.*]] = and i8 [[BF1]], 1
; CHECK-NEXT:    store i8 [[BF_CLEAR1]], i8* [[TMP0]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %D = alloca i32, align 4
  %0 = bitcast i32* %D to i8*
  %bf = load i8, i8* %0, align 4
  %bf.clear = and i8 %bf, -3
  store i8 %bf.clear, i8* %0, align 4
  %bf1 = load i8, i8* %0, align 4
  %bf.clear1 = and i8 %bf1, 1
  store i8 %bf.clear1, i8* %0, align 4
  ret i32 0
}

; Check that we do not hoist loads past calls within a same basic block.
declare void @foo()
define i32 @noHoistInSingleBBWithCall() {
; CHECK-LABEL: @noHoistInSingleBBWithCall(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[D]] to i8*
; CHECK-NEXT:    [[BF:%.*]] = load i8, i8* [[TMP0]], align 4
; CHECK-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF]], -3
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[BF1:%.*]] = load i8, i8* [[TMP0]], align 4
; CHECK-NEXT:    [[BF_CLEAR1:%.*]] = and i8 [[BF1]], 1
; CHECK-NEXT:    ret i32 0
;
entry:
  %D = alloca i32, align 4
  %0 = bitcast i32* %D to i8*
  %bf = load i8, i8* %0, align 4
  %bf.clear = and i8 %bf, -3
  call void @foo()
  %bf1 = load i8, i8* %0, align 4
  %bf.clear1 = and i8 %bf1, 1
  ret i32 0
}

; Check that we do not hoist loads past stores in any branch of a diamond.
define float @noHoistInDiamondWithOneStore1(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @noHoistInDiamondWithOneStore1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store float 0.000000e+00, float* @GlobalVar, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    [[TMP5:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB5:%.*]] = fsub float [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[MUL6:%.*]] = fmul float [[SUB5]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL6]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL4]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB6:%.*]] = fsub float [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[MUL7:%.*]] = fmul float [[SUB6]], [[DIV]]
; CHECK-NEXT:    [[TMP8:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB8:%.*]] = fsub float [[TMP8]], [[TMP7]]
; CHECK-NEXT:    [[MUL9:%.*]] = fmul float [[SUB8]], [[DIV]]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store float 0.000000e+00, float* @GlobalVar
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  ; There are no side effects on the if.else branch.
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]

  %6 = load float, float* %max, align 4
  %7 = load float, float* %a, align 4
  %sub6 = fsub float %6, %7
  %mul7 = fmul float %sub6, %div
  %8 = load float, float* %min, align 4
  %sub8 = fsub float %8, %7
  %mul9 = fmul float %sub8, %div

  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we do not hoist loads past stores from half diamond.
define float @noHoistInHalfDiamondPastStore(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @noHoistInHalfDiamondPastStore(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    store float 0.000000e+00, float* @GlobalVar, align 4
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    [[TMP4:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB5:%.*]] = fsub float [[TMP4]], [[TMP3]]
; CHECK-NEXT:    [[MUL6:%.*]] = fmul float [[SUB5]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL4]], [[IF_THEN]] ], [ [[TMP0]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL6]], [[IF_THEN]] ], [ [[TMP1]], [[ENTRY]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4

  ; Loads should not be hoisted above this store.
  store float 0.000000e+00, float* @GlobalVar

  br i1 %cmp, label %if.then, label %if.end

if.then:
  ; There are no side effects on the if.then branch.
  %2 = load float, float* %max, align 4
  %3 = load float, float* %a, align 4
  %sub3 = fsub float %2, %3
  %mul4 = fmul float %sub3, %div
  %4 = load float, float* %min, align 4
  %sub5 = fsub float %4, %3
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:
  %tmax.0 = phi float [ %mul4, %if.then ], [ %0, %entry ]
  %tmin.0 = phi float [ %mul6, %if.then ], [ %1, %entry ]

  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we do not hoist loads past a store in any branch of a diamond.
define float @noHoistInDiamondWithOneStore2(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @noHoistInDiamondWithOneStore2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    store float 0.000000e+00, float* @GlobalVar, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    [[TMP5:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB5:%.*]] = fsub float [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[MUL6:%.*]] = fmul float [[SUB5]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[IF_THEN]] ], [ [[MUL6]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[IF_THEN]] ], [ [[MUL4]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB6:%.*]] = fsub float [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[MUL7:%.*]] = fmul float [[SUB6]], [[DIV]]
; CHECK-NEXT:    [[TMP8:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB8:%.*]] = fsub float [[TMP8]], [[TMP7]]
; CHECK-NEXT:    [[MUL9:%.*]] = fmul float [[SUB8]], [[DIV]]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  ; There are no side effects on the if.then branch.
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4
  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %if.end

if.else:                                          ; preds = %entry
  store float 0.000000e+00, float* @GlobalVar
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmax.0 = phi float [ %mul2, %if.then ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %if.then ], [ %mul4, %if.else ]

  %6 = load float, float* %max, align 4
  %7 = load float, float* %a, align 4
  %sub6 = fsub float %6, %7
  %mul7 = fmul float %sub6, %div
  %8 = load float, float* %min, align 4
  %sub8 = fsub float %8, %7
  %mul9 = fmul float %sub8, %div

  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we do not hoist loads outside a loop containing stores.
define float @noHoistInLoopsWithStores(float %d, float* %min, float* %max, float* %a) {
; CHECK-LABEL: @noHoistInLoopsWithStores(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float 1.000000e+00, [[D:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oge float [[DIV]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[MIN:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A:%.*]], align 4
; CHECK-NEXT:    store float 0.000000e+00, float* @GlobalVar, align 4
; CHECK-NEXT:    [[SUB:%.*]] = fsub float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[SUB]], [[DIV]]
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[MAX:%.*]], align 4
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul float [[SUB1]], [[DIV]]
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[CMP1:%.*]] = fcmp oge float [[MUL2]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP1]], label [[IF_END:%.*]], label [[DO_BODY]]
; CHECK:       if.else:
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[MAX]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = fsub float [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[MUL4:%.*]] = fmul float [[SUB3]], [[DIV]]
; CHECK-NEXT:    [[TMP5:%.*]] = load float, float* [[MIN]], align 4
; CHECK-NEXT:    [[SUB5:%.*]] = fsub float [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[MUL6:%.*]] = fmul float [[SUB5]], [[DIV]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMAX_0:%.*]] = phi float [ [[MUL2]], [[WHILE_COND]] ], [ [[MUL6]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMIN_0:%.*]] = phi float [ [[MUL]], [[WHILE_COND]] ], [ [[MUL4]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[TMAX_0]], [[TMIN_0]]
; CHECK-NEXT:    ret float [[ADD]]
;
entry:
  %div = fdiv float 1.000000e+00, %d
  %cmp = fcmp oge float %div, 0.000000e+00
  br i1 %cmp, label %do.body, label %if.else

do.body:
  %0 = load float, float* %min, align 4
  %1 = load float, float* %a, align 4

  ; It is unsafe to hoist the loads outside the loop because of the store.
  store float 0.000000e+00, float* @GlobalVar

  %sub = fsub float %0, %1
  %mul = fmul float %sub, %div
  %2 = load float, float* %max, align 4
  %sub1 = fsub float %2, %1
  %mul2 = fmul float %sub1, %div
  br label %while.cond

while.cond:
  %cmp1 = fcmp oge float %mul2, 0.000000e+00
  br i1 %cmp1, label %if.end, label %do.body

if.else:
  %3 = load float, float* %max, align 4
  %4 = load float, float* %a, align 4
  %sub3 = fsub float %3, %4
  %mul4 = fmul float %sub3, %div
  %5 = load float, float* %min, align 4
  %sub5 = fsub float %5, %4
  %mul6 = fmul float %sub5, %div
  br label %if.end

if.end:
  %tmax.0 = phi float [ %mul2, %while.cond ], [ %mul6, %if.else ]
  %tmin.0 = phi float [ %mul, %while.cond ], [ %mul4, %if.else ]

  %add = fadd float %tmax.0, %tmin.0
  ret float %add
}

; Check that we hoist stores: all the instructions from the then branch
; should be hoisted.

%struct.foo = type { i16* }

define void @hoistStores(%struct.foo* %s, i32* %coord, i1 zeroext %delta) {
; CHECK-LABEL: @hoistStores(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FROMBOOL:%.*]] = zext i1 [[DELTA:%.*]] to i8
; CHECK-NEXT:    [[TOBOOL:%.*]] = trunc i8 [[FROMBOOL]] to i1
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[STRUCT_FOO:%.*]], %struct.foo* [[S:%.*]], i32 0, i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = load i16*, i16** [[TMP0]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[STRUCT_FOO]], %struct.foo* [[S]], i32 0, i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i16, i16* [[TMP1]], i32 1
; CHECK-NEXT:    store i16* [[TMP3]], i16** [[TMP2]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, i16* [[TMP1]], align 2
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[COORD:%.*]], align 4
; CHECK-NEXT:    [[CONV:%.*]] = zext i16 [[TMP4]] to i32
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[TMP5]], [[CONV]]
; CHECK-NEXT:    store i32 [[ADD]], i32* [[COORD]], align 4
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[P:%.*]] = getelementptr inbounds [[STRUCT_FOO]], %struct.foo* [[S]], i32 0, i32 0
; CHECK-NEXT:    [[INCDEC_PTR:%.*]] = getelementptr inbounds i16, i16* [[TMP1]], i32 1
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds [[STRUCT_FOO]], %struct.foo* [[S]], i32 0, i32 0
; CHECK-NEXT:    [[INCDEC_PTR2:%.*]] = getelementptr inbounds i16, i16* [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = load i16*, i16** [[P1]], align 8
; CHECK-NEXT:    [[INCDEC_PTR6:%.*]] = getelementptr inbounds i16, i16* [[TMP6]], i32 1
; CHECK-NEXT:    store i16* [[INCDEC_PTR6]], i16** [[P1]], align 8
; CHECK-NEXT:    [[TMP7:%.*]] = load i16, i16* [[TMP6]], align 2
; CHECK-NEXT:    [[CONV7:%.*]] = zext i16 [[TMP7]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV7]], 8
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, i32* [[COORD]], align 4
; CHECK-NEXT:    [[ADD8:%.*]] = add i32 [[TMP8]], [[SHL]]
; CHECK-NEXT:    store i32 [[ADD8]], i32* [[COORD]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %frombool = zext i1 %delta to i8
  %tobool = trunc i8 %frombool to i1
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %p = getelementptr inbounds %struct.foo, %struct.foo* %s, i32 0, i32 0
  %0 = load i16*, i16** %p, align 8
  %incdec.ptr = getelementptr inbounds i16, i16* %0, i32 1
  store i16* %incdec.ptr, i16** %p, align 8
  %1 = load i16, i16* %0, align 2
  %conv = zext i16 %1 to i32
  %2 = load i32, i32* %coord, align 4
  %add = add i32 %2, %conv
  store i32 %add, i32* %coord, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %p1 = getelementptr inbounds %struct.foo, %struct.foo* %s, i32 0, i32 0
  %3 = load i16*, i16** %p1, align 8
  %incdec.ptr2 = getelementptr inbounds i16, i16* %3, i32 1
  store i16* %incdec.ptr2, i16** %p1, align 8
  %4 = load i16, i16* %3, align 2
  %conv3 = zext i16 %4 to i32
  %5 = load i32, i32* %coord, align 4
  %add4 = add i32 %5, %conv3
  store i32 %add4, i32* %coord, align 4
  %6 = load i16*, i16** %p1, align 8
  %incdec.ptr6 = getelementptr inbounds i16, i16* %6, i32 1
  store i16* %incdec.ptr6, i16** %p1, align 8
  %7 = load i16, i16* %6, align 2
  %conv7 = zext i16 %7 to i32
  %shl = shl i32 %conv7, 8
  %8 = load i32, i32* %coord, align 4
  %add8 = add i32 %8, %shl
  store i32 %add8, i32* %coord, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

define i32 @mergeAlignments(i1 %b, i32* %y) {
; CHECK-LABEL: @mergeAlignments(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[L1:%.*]] = load i32, i32* [[Y:%.*]], align 1
; CHECK-NEXT:    br i1 [[B:%.*]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi i32 [ [[L1]], [[IF_THEN]] ], [ [[L1]], [[IF_END]] ]
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  br i1 %b, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %l1 = load i32, i32* %y, align 4
  br label %return

if.end:                                           ; preds = %entry
  %l2 = load i32, i32* %y, align 1
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i32 [ %l1, %if.then ], [ %l2, %if.end ]
  ret i32 %retval.0
}

declare i8 @pr30991_f() nounwind readonly
declare void @pr30991_f1(i8)
define i8 @pr30991(i8* %sp, i8* %word, i1 %b1, i1 %b2) {
; CHECK-LABEL: @pr30991(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[R0:%.*]] = load i8, i8* [[WORD:%.*]], align 1
; CHECK-NEXT:    br i1 [[B1:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       a:
; CHECK-NEXT:    [[INCDEC_PTR:%.*]] = getelementptr i8, i8* [[SP:%.*]], i32 1
; CHECK-NEXT:    [[RR0:%.*]] = call i8 @pr30991_f() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @pr30991_f1(i8 [[R0]])
; CHECK-NEXT:    ret i8 [[RR0]]
; CHECK:       b:
; CHECK-NEXT:    br i1 [[B2:%.*]], label [[C:%.*]], label [[X:%.*]]
; CHECK:       c:
; CHECK-NEXT:    [[INCDEC_PTR115:%.*]] = getelementptr i8, i8* [[SP]], i32 1
; CHECK-NEXT:    [[RR1:%.*]] = call i8 @pr30991_f() #[[ATTR0]]
; CHECK-NEXT:    call void @pr30991_f1(i8 [[R0]])
; CHECK-NEXT:    ret i8 [[RR1]]
; CHECK:       x:
; CHECK-NEXT:    ret i8 [[R0]]
;
entry:
  br i1 %b1, label %a, label %b

a:
  %r0 = load i8, i8* %word, align 1
  %incdec.ptr = getelementptr i8, i8* %sp, i32 1
  %rr0 = call i8 @pr30991_f() nounwind readonly
  call void @pr30991_f1(i8 %r0)
  ret i8 %rr0

b:
  br i1 %b2, label %c, label %x

c:
  %r1 = load i8, i8* %word, align 1
  %incdec.ptr115 = getelementptr i8, i8* %sp, i32 1
  %rr1 = call i8 @pr30991_f() nounwind readonly
  call void @pr30991_f1(i8 %r1)
  ret i8 %rr1

x:
  %r2 = load i8, i8* %word, align 1
  ret i8 %r2
}
