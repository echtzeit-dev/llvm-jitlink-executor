; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

define i32 @test.slt(ptr readonly %src, ptr readnone %min, ptr readnone %max) {
; CHECK-LABEL: @test.slt(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[C_MIN_0:%.*]] = icmp slt ptr [[SRC:%.*]], [[MIN:%.*]]
; CHECK-NEXT:    br i1 [[C_MIN_0]], label [[TRAP:%.*]], label [[CHECK_0_MAX:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret i32 10
; CHECK:       check.0.max:
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp slt ptr [[SRC]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_MAX_0]], label [[CHECK_3_MIN:%.*]], label [[TRAP]]
; CHECK:       check.3.min:
; CHECK-NEXT:    [[L0:%.*]] = load i32, ptr [[SRC]], align 4
; CHECK-NEXT:    [[ADD_PTR_I36:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 3
; CHECK-NEXT:    [[C_3_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I36]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_3_MIN]], label [[TRAP]], label [[CHECK_3_MAX:%.*]]
; CHECK:       check.3.max:
; CHECK-NEXT:    [[C_3_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I36]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_3_MAX]], label [[CHECK_1_MIN:%.*]], label [[TRAP]]
; CHECK:       check.1.min:
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr [[ADD_PTR_I36]], align 4
; CHECK-NEXT:    [[ADD_PTR_I29:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 1
; CHECK-NEXT:    [[C_1_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I29]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_1_MIN]], label [[TRAP]], label [[CHECK_1_MAX:%.*]]
; CHECK:       check.1.max:
; CHECK-NEXT:    [[C_1_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I29]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_1_MAX]], label [[CHECK_2_MIN:%.*]], label [[TRAP]]
; CHECK:       check.2.min:
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr [[ADD_PTR_I29]], align 4
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 2
; CHECK-NEXT:    [[C_2_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_2_MIN]], label [[TRAP]], label [[CHECK_2_MAX:%.*]]
; CHECK:       check.2.max:
; CHECK-NEXT:    [[C_2_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_2_MAX]], label [[EXIT:%.*]], label [[TRAP]]
; CHECK:       exit:
; CHECK-NEXT:    [[L3:%.*]] = load i32, ptr [[ADD_PTR_I]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[L1]], [[L0]]
; CHECK-NEXT:    [[ADD8:%.*]] = add nsw i32 [[ADD]], [[L2]]
; CHECK-NEXT:    [[ADD9:%.*]] = add nsw i32 [[ADD8]], [[L3]]
; CHECK-NEXT:    ret i32 [[ADD9]]
;
check.0.min:
  %c.min.0 = icmp slt ptr %src, %min
  br i1 %c.min.0, label %trap, label %check.0.max

trap:
  ret i32 10

check.0.max:
  %c.max.0 = icmp slt ptr %src, %max
  br i1 %c.max.0, label %check.3.min, label %trap

check.3.min:
  %l0 = load i32, ptr %src, align 4
  %add.ptr.i36 = getelementptr inbounds i32, ptr %src, i64 3
  %c.3.min = icmp slt ptr %add.ptr.i36, %min
  br i1 %c.3.min, label %trap, label %check.3.max

check.3.max:
  %c.3.max = icmp slt ptr %add.ptr.i36, %max
  br i1 %c.3.max, label %check.1.min, label %trap

check.1.min:
  %l1 = load i32, ptr %add.ptr.i36, align 4
  %add.ptr.i29 = getelementptr inbounds i32, ptr %src, i64 1
  %c.1.min = icmp slt ptr %add.ptr.i29, %min
  br i1 %c.1.min, label %trap, label %check.1.max

check.1.max:
  %c.1.max = icmp slt ptr %add.ptr.i29, %max
  br i1 %c.1.max, label %check.2.min, label %trap

check.2.min:
  %l2 = load i32, ptr %add.ptr.i29, align 4
  %add.ptr.i = getelementptr inbounds i32, ptr %src, i64 2
  %c.2.min = icmp slt ptr %add.ptr.i, %min
  br i1 %c.2.min, label %trap, label %check.2.max

check.2.max:
  %c.2.max = icmp slt ptr %add.ptr.i, %max
  br i1 %c.2.max, label %exit, label %trap

exit:
  %l3 = load i32, ptr %add.ptr.i, align 4
  %add = add nsw i32 %l1, %l0
  %add8 = add nsw i32 %add, %l2
  %add9 = add nsw i32 %add8, %l3
  ret i32 %add9
}

; Same as test.slt, but without inbounds.
define i32 @test.slt_no_inbounds(ptr readonly %src, ptr readnone %min, ptr readnone %max) {
; CHECK-LABEL: @test.slt_no_inbounds(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[C_MIN_0:%.*]] = icmp slt ptr [[SRC:%.*]], [[MIN:%.*]]
; CHECK-NEXT:    br i1 [[C_MIN_0]], label [[TRAP:%.*]], label [[CHECK_0_MAX:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret i32 10
; CHECK:       check.0.max:
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp slt ptr [[SRC]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_MAX_0]], label [[CHECK_3_MIN:%.*]], label [[TRAP]]
; CHECK:       check.3.min:
; CHECK-NEXT:    [[L0:%.*]] = load i32, ptr [[SRC]], align 4
; CHECK-NEXT:    [[ADD_PTR_I36:%.*]] = getelementptr i32, ptr [[SRC]], i64 3
; CHECK-NEXT:    [[C_3_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I36]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_3_MIN]], label [[TRAP]], label [[CHECK_3_MAX:%.*]]
; CHECK:       check.3.max:
; CHECK-NEXT:    [[C_3_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I36]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_3_MAX]], label [[CHECK_1_MIN:%.*]], label [[TRAP]]
; CHECK:       check.1.min:
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr [[ADD_PTR_I36]], align 4
; CHECK-NEXT:    [[ADD_PTR_I29:%.*]] = getelementptr i32, ptr [[SRC]], i64 1
; CHECK-NEXT:    [[C_1_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I29]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_1_MIN]], label [[TRAP]], label [[CHECK_1_MAX:%.*]]
; CHECK:       check.1.max:
; CHECK-NEXT:    [[C_1_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I29]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_1_MAX]], label [[CHECK_2_MIN:%.*]], label [[TRAP]]
; CHECK:       check.2.min:
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr [[ADD_PTR_I29]], align 4
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr i32, ptr [[SRC]], i64 2
; CHECK-NEXT:    [[C_2_MIN:%.*]] = icmp slt ptr [[ADD_PTR_I]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_2_MIN]], label [[TRAP]], label [[CHECK_2_MAX:%.*]]
; CHECK:       check.2.max:
; CHECK-NEXT:    [[C_2_MAX:%.*]] = icmp slt ptr [[ADD_PTR_I]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_2_MAX]], label [[EXIT:%.*]], label [[TRAP]]
; CHECK:       exit:
; CHECK-NEXT:    [[L3:%.*]] = load i32, ptr [[ADD_PTR_I]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[L1]], [[L0]]
; CHECK-NEXT:    [[ADD8:%.*]] = add nsw i32 [[ADD]], [[L2]]
; CHECK-NEXT:    [[ADD9:%.*]] = add nsw i32 [[ADD8]], [[L3]]
; CHECK-NEXT:    ret i32 [[ADD9]]
;
check.0.min:
  %c.min.0 = icmp slt ptr %src, %min
  br i1 %c.min.0, label %trap, label %check.0.max

trap:
  ret i32 10

check.0.max:
  %c.max.0 = icmp slt ptr %src, %max
  br i1 %c.max.0, label %check.3.min, label %trap

check.3.min:
  %l0 = load i32, ptr %src, align 4
  %add.ptr.i36 = getelementptr i32, ptr %src, i64 3
  %c.3.min = icmp slt ptr %add.ptr.i36, %min
  br i1 %c.3.min, label %trap, label %check.3.max

check.3.max:
  %c.3.max = icmp slt ptr %add.ptr.i36, %max
  br i1 %c.3.max, label %check.1.min, label %trap

check.1.min:
  %l1 = load i32, ptr %add.ptr.i36, align 4
  %add.ptr.i29 = getelementptr i32, ptr %src, i64 1
  %c.1.min = icmp slt ptr %add.ptr.i29, %min
  br i1 %c.1.min, label %trap, label %check.1.max

check.1.max:
  %c.1.max = icmp slt ptr %add.ptr.i29, %max
  br i1 %c.1.max, label %check.2.min, label %trap

check.2.min:
  %l2 = load i32, ptr %add.ptr.i29, align 4
  %add.ptr.i = getelementptr i32, ptr %src, i64 2
  %c.2.min = icmp slt ptr %add.ptr.i, %min
  br i1 %c.2.min, label %trap, label %check.2.max

check.2.max:
  %c.2.max = icmp slt ptr %add.ptr.i, %max
  br i1 %c.2.max, label %exit, label %trap

exit:
  %l3 = load i32, ptr %add.ptr.i, align 4
  %add = add nsw i32 %l1, %l0
  %add8 = add nsw i32 %add, %l2
  %add9 = add nsw i32 %add8, %l3
  ret i32 %add9
}

define void @test.not.sge.slt(ptr %start, ptr %low, ptr %high) {
; CHECK-LABEL: @test.not.sge.slt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[T_0:%.*]] = icmp slt ptr [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[T_1:%.*]] = icmp slt ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 2
; CHECK-NEXT:    [[T_2:%.*]] = icmp slt ptr [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 3
; CHECK-NEXT:    [[T_3:%.*]] = icmp slt ptr [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 4
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt ptr [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, ptr %start, i64 3
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  ret void

if.end:
  %t.0 = icmp slt ptr %start, %high
  call void @use(i1 %t.0)
  %start.1 = getelementptr inbounds i8, ptr %start, i64 1
  %t.1 = icmp slt ptr %start.1, %high
  call void @use(i1 %t.1)
  %start.2 = getelementptr inbounds i8, ptr %start, i64 2
  %t.2 = icmp slt ptr %start.2, %high
  call void @use(i1 %t.2)
  %start.3 = getelementptr inbounds i8, ptr %start, i64 3
  %t.3 = icmp slt ptr %start.3, %high
  call void @use(i1 %t.3)
  %start.4 = getelementptr inbounds i8, ptr %start, i64 4
  %c.4 = icmp slt ptr %start.4, %high
  call void @use(i1 %c.4)
  ret void
}

; Same as test.not.sge.slt, but without inbounds GEPs.
define void @test.not.sge.slt_no_inbounds(ptr %start, ptr %low, ptr %high) {
; CHECK-LABEL: @test.not.sge.slt_no_inbounds(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr i8, ptr [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[T_0:%.*]] = icmp slt ptr [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[T_1:%.*]] = icmp slt ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr i8, ptr [[START]], i64 2
; CHECK-NEXT:    [[T_2:%.*]] = icmp slt ptr [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr i8, ptr [[START]], i64 3
; CHECK-NEXT:    [[T_3:%.*]] = icmp slt ptr [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr i8, ptr [[START]], i64 4
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt ptr [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr i8, ptr %start, i64 3
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  ret void

if.end:
  %t.0 = icmp slt ptr %start, %high
  call void @use(i1 %t.0)
  %start.1 = getelementptr i8, ptr %start, i64 1
  %t.1 = icmp slt ptr %start.1, %high
  call void @use(i1 %t.1)
  %start.2 = getelementptr i8, ptr %start, i64 2
  %t.2 = icmp slt ptr %start.2, %high
  call void @use(i1 %t.2)
  %start.3 = getelementptr i8, ptr %start, i64 3
  %t.3 = icmp slt ptr %start.3, %high
  call void @use(i1 %t.3)
  %start.4 = getelementptr i8, ptr %start, i64 4
  %c.4 = icmp slt ptr %start.4, %high
  call void @use(i1 %c.4)
  ret void
}

define void @test.not.sge.sle(ptr %start, ptr %low, ptr %high) {
; CHECK-LABEL: @test.not.sge.sle(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[T_0:%.*]] = icmp sle ptr [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[T_1:%.*]] = icmp sle ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 2
; CHECK-NEXT:    [[T_2:%.*]] = icmp sle ptr [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 3
; CHECK-NEXT:    [[T_3:%.*]] = icmp sle ptr [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 4
; CHECK-NEXT:    [[T_4:%.*]] = icmp sle ptr [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp sle ptr [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, ptr %start, i64 3
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  ret void

if.end:
  %t.0 = icmp sle ptr %start, %high
  call void @use(i1 %t.0)
  %start.1 = getelementptr inbounds i8, ptr %start, i64 1
  %t.1 = icmp sle ptr %start.1, %high
  call void @use(i1 %t.1)
  %start.2 = getelementptr inbounds i8, ptr %start, i64 2
  %t.2 = icmp sle ptr %start.2, %high
  call void @use(i1 %t.2)
  %start.3 = getelementptr inbounds i8, ptr %start, i64 3
  %t.3 = icmp sle ptr %start.3, %high
  call void @use(i1 %t.3)
  %start.4 = getelementptr inbounds i8, ptr %start, i64 4
  %t.4 = icmp sle ptr %start.4, %high
  call void @use(i1 %t.4)
  %start.5 = getelementptr inbounds i8, ptr %start, i64 5
  %c.5 = icmp sle ptr %start.5, %high
  call void @use(i1 %c.5)
  ret void
}

define void @test.not.sge.sgt(ptr %start, ptr %low, ptr %high) {
; CHECK-LABEL: @test.not.sge.sgt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[F_0:%.*]] = icmp sgt ptr [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[F_1:%.*]] = icmp sgt ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 2
; CHECK-NEXT:    [[F_2:%.*]] = icmp sgt ptr [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 3
; CHECK-NEXT:    [[F_3:%.*]] = icmp sgt ptr [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 4
; CHECK-NEXT:    [[F_4:%.*]] = icmp sgt ptr [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp sgt ptr [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, ptr %start, i64 3
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  ret void

if.end:
  %f.0 = icmp sgt ptr %start, %high
  call void @use(i1 %f.0)
  %start.1 = getelementptr inbounds i8, ptr %start, i64 1
  %f.1 = icmp sgt ptr %start.1, %high
  call void @use(i1 %f.1)
  %start.2 = getelementptr inbounds i8, ptr %start, i64 2
  %f.2 = icmp sgt ptr %start.2, %high
  call void @use(i1 %f.2)
  %start.3 = getelementptr inbounds i8, ptr %start, i64 3
  %f.3 = icmp sgt ptr %start.3, %high
  call void @use(i1 %f.3)
  %start.4 = getelementptr inbounds i8, ptr %start, i64 4
  %f.4 = icmp sgt ptr %start.4, %high
  call void @use(i1 %f.4)
  %start.5 = getelementptr inbounds i8, ptr %start, i64 5
  %c.5 = icmp sgt ptr %start.5, %high
  call void @use(i1 %c.5)
  ret void
}

define void @test.not.sge.sge(ptr %start, ptr %low, ptr %high) {
; CHECK-LABEL: @test.not.sge.sge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[F_0:%.*]] = icmp sgt ptr [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[F_1:%.*]] = icmp sge ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 2
; CHECK-NEXT:    [[F_2:%.*]] = icmp sge ptr [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 3
; CHECK-NEXT:    [[F_3:%.*]] = icmp sge ptr [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 4
; CHECK-NEXT:    [[C_4:%.*]] = icmp sge ptr [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp sge ptr [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, ptr %start, i64 3
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  ret void

if.end:
  %f.0 = icmp sgt ptr %start, %high
  call void @use(i1 %f.0)
  %start.1 = getelementptr inbounds i8, ptr %start, i64 1
  %f.1 = icmp sge ptr %start.1, %high
  call void @use(i1 %f.1)
  %start.2 = getelementptr inbounds i8, ptr %start, i64 2
  %f.2 = icmp sge ptr %start.2, %high
  call void @use(i1 %f.2)
  %start.3 = getelementptr inbounds i8, ptr %start, i64 3
  %f.3 = icmp sge ptr %start.3, %high
  call void @use(i1 %f.3)
  %start.4 = getelementptr inbounds i8, ptr %start, i64 4
  %c.4 = icmp sge ptr %start.4, %high
  call void @use(i1 %c.4)
  %start.5 = getelementptr inbounds i8, ptr %start, i64 5
  %c.5 = icmp sge ptr %start.5, %high
  call void @use(i1 %c.5)
  ret void
}

define void @test.not.sge.sge.nonconst(ptr %start, ptr %low, ptr %high, i8 %off) {
; CHECK-LABEL: @test.not.sge.sge.nonconst(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[START:%.*]], i8 [[OFF:%.*]]
; CHECK-NEXT:    [[C_1:%.*]] = icmp sge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[START_OFF_2:%.*]] = getelementptr inbounds i8, ptr [[START]], i8 [[OFF]]
; CHECK-NEXT:    [[T_0:%.*]] = icmp sge ptr [[START_OFF_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, ptr [[START]], i64 1
; CHECK-NEXT:    [[C_0:%.*]] = icmp sge ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    [[START_OFF:%.*]] = getelementptr inbounds i8, ptr [[START]], i8 [[OFF]]
; CHECK-NEXT:    [[F_0:%.*]] = icmp sge ptr [[START_OFF]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_0]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, ptr %start, i8 %off
  %c.1 = icmp sge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:
  %start.off.2 = getelementptr inbounds i8, ptr %start, i8 %off
  %t.0 = icmp sge ptr %start.off.2, %high
  call void @use(i1 %t.0)
  ret void

if.end:
  %start.1 = getelementptr inbounds i8, ptr %start, i64 1
  %c.0 = icmp sge ptr %start.1, %high
  call void @use(i1 %c.0)
  %start.off = getelementptr inbounds i8, ptr %start, i8 %off
  %f.0 = icmp sge ptr %start.off, %high
  call void @use(i1 %f.0)
  ret void
}

; Test which requires decomposing GEP %ptr, SHL().
define void @test.slt.gep.shl(ptr readonly %src, ptr readnone %max, i8 %idx) {
; CHECK-LABEL: @test.slt.gep.shl(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i32, ptr [[SRC:%.*]], i32 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp sgt ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_ADD_10_MAX]], label [[TRAP:%.*]], label [[CHECK_IDX:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[IDX:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP]]
; CHECK:       check.max:
; CHECK-NEXT:    [[IDX_SHL_1:%.*]] = shl nuw i8 [[IDX]], 1
; CHECK-NEXT:    [[ADD_PTR_SHL_1:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i8 [[IDX_SHL_1]]
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp slt ptr [[ADD_PTR_SHL_1]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_0]])
; CHECK-NEXT:    [[IDX_SHL_2:%.*]] = shl nuw i8 [[IDX]], 2
; CHECK-NEXT:    [[ADD_PTR_SHL_2:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i8 [[IDX_SHL_2]]
; CHECK-NEXT:    [[C_MAX_1:%.*]] = icmp slt ptr [[ADD_PTR_SHL_2]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_1]])
; CHECK-NEXT:    [[IDX_SHL_NOT_NUW:%.*]] = shl i8 [[IDX]], 1
; CHECK-NEXT:    [[ADD_PTR_SHL_NOT_NUW:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i8 [[IDX_SHL_NOT_NUW]]
; CHECK-NEXT:    [[C_MAX_2:%.*]] = icmp slt ptr [[ADD_PTR_SHL_NOT_NUW]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_2]])
; CHECK-NEXT:    [[IDX_SHL_3:%.*]] = shl nuw i8 [[IDX]], 3
; CHECK-NEXT:    [[ADD_PTR_SHL_3:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i8 [[IDX_SHL_3]]
; CHECK-NEXT:    [[C_MAX_3:%.*]] = icmp slt ptr [[ADD_PTR_SHL_3]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_3]])
; CHECK-NEXT:    ret void
;
check.0.min:
  %add.10 = getelementptr inbounds i32, ptr %src, i32 10
  %c.add.10.max = icmp sgt ptr %add.10, %max
  br i1 %c.add.10.max, label %trap, label %check.idx

trap:
  ret void

check.idx:
  %cmp = icmp slt i8 %idx, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %idx.shl.1 = shl nuw i8 %idx, 1
  %add.ptr.shl.1 = getelementptr inbounds i32, ptr %src, i8 %idx.shl.1
  %c.max.0 = icmp slt ptr %add.ptr.shl.1, %max
  call void @use(i1 %c.max.0)
  %idx.shl.2 = shl nuw i8 %idx, 2
  %add.ptr.shl.2 = getelementptr inbounds i32, ptr %src, i8 %idx.shl.2
  %c.max.1 = icmp slt ptr %add.ptr.shl.2, %max
  call void @use(i1 %c.max.1)
  %idx.shl.not.nuw = shl i8 %idx, 1
  %add.ptr.shl.not.nuw = getelementptr inbounds i32, ptr %src, i8 %idx.shl.not.nuw
  %c.max.2 = icmp slt ptr %add.ptr.shl.not.nuw, %max
  call void @use(i1 %c.max.2)
  %idx.shl.3 = shl nuw i8 %idx, 3
  %add.ptr.shl.3 = getelementptr inbounds i32, ptr %src, i8 %idx.shl.3
  %c.max.3 = icmp slt ptr %add.ptr.shl.3, %max
  call void @use(i1 %c.max.3)
  ret void
}

; Test which requires decomposing GEP %ptr, ZEXT(SHL()).
define void @test.slt.gep.shl.zext(ptr readonly %src, ptr readnone %max, i32 %idx, i32 %j) {
; CHECK-LABEL: @test.slt.gep.shl.zext(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i32, ptr [[SRC:%.*]], i32 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp sgt ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_ADD_10_MAX]], label [[TRAP:%.*]], label [[CHECK_IDX:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[IDX:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP]]
; CHECK:       check.max:
; CHECK-NEXT:    [[IDX_SHL:%.*]] = shl nuw i32 [[IDX]], 1
; CHECK-NEXT:    [[EXT_1:%.*]] = zext i32 [[IDX_SHL]] to i64
; CHECK-NEXT:    [[ADD_PTR_SHL:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 [[EXT_1]]
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp slt ptr [[ADD_PTR_SHL]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_0]])
; CHECK-NEXT:    [[IDX_SHL_NOT_NUW:%.*]] = shl i32 [[IDX]], 1
; CHECK-NEXT:    [[EXT_2:%.*]] = zext i32 [[IDX_SHL_NOT_NUW]] to i64
; CHECK-NEXT:    [[ADD_PTR_SHL_NOT_NUW:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 [[EXT_2]]
; CHECK-NEXT:    [[C_MAX_1:%.*]] = icmp slt ptr [[ADD_PTR_SHL_NOT_NUW]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_1]])
; CHECK-NEXT:    [[IDX_SHL_3:%.*]] = shl nuw i32 [[IDX]], 2
; CHECK-NEXT:    [[EXT_3:%.*]] = zext i32 [[IDX_SHL_3]] to i64
; CHECK-NEXT:    [[ADD_PTR_SHL_3:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 [[EXT_3]]
; CHECK-NEXT:    [[C_MAX_2:%.*]] = icmp slt ptr [[ADD_PTR_SHL_3]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_2]])
; CHECK-NEXT:    ret void
;
check.0.min:
  %add.10 = getelementptr inbounds i32, ptr %src, i32 10
  %c.add.10.max = icmp sgt ptr %add.10, %max
  br i1 %c.add.10.max, label %trap, label %check.idx

trap:
  ret void

check.idx:
  %cmp = icmp slt i32 %idx, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %idx.shl = shl nuw i32 %idx, 1
  %ext.1 = zext i32 %idx.shl to i64
  %add.ptr.shl = getelementptr inbounds i32, ptr %src, i64 %ext.1
  %c.max.0 = icmp slt ptr %add.ptr.shl, %max
  call void @use(i1 %c.max.0)
  %idx.shl.not.nuw = shl i32 %idx, 1
  %ext.2 = zext i32 %idx.shl.not.nuw to i64
  %add.ptr.shl.not.nuw = getelementptr inbounds i32, ptr %src, i64 %ext.2
  %c.max.1 = icmp slt ptr %add.ptr.shl.not.nuw, %max
  call void @use(i1 %c.max.1)
  %idx.shl.3 = shl nuw i32 %idx, 2
  %ext.3 = zext i32 %idx.shl.3 to i64
  %add.ptr.shl.3 = getelementptr inbounds i32, ptr %src, i64 %ext.3
  %c.max.2 = icmp slt ptr %add.ptr.shl.3, %max
  call void @use(i1 %c.max.2)
  ret void
}

; Make sure non-constant shift amounts are handled correctly.
define i1 @test.slt.gep.shl.nonconst.zext(i16 %B, ptr readonly %src, ptr readnone %max, i16 %idx, i16 %j) {
; CHECK-LABEL: @test.slt.gep.shl.nonconst.zext(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i16, ptr [[SRC:%.*]], i16 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp sgt ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_ADD_10_MAX]], label [[EXIT_1:%.*]], label [[CHECK_IDX:%.*]]
; CHECK:       exit.1:
; CHECK-NEXT:    ret i1 true
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i16 [[IDX:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP:%.*]]
; CHECK:       check.max:
; CHECK-NEXT:    [[IDX_SHL:%.*]] = shl nuw i16 [[IDX]], [[B:%.*]]
; CHECK-NEXT:    [[EXT:%.*]] = zext i16 [[IDX_SHL]] to i64
; CHECK-NEXT:    [[ADD_PTR_SHL:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 [[EXT]]
; CHECK-NEXT:    [[C_MAX:%.*]] = icmp slt ptr [[ADD_PTR_SHL]], [[MAX]]
; CHECK-NEXT:    ret i1 [[C_MAX]]
; CHECK:       trap:
; CHECK-NEXT:    [[IDX_SHL_1:%.*]] = shl nuw i16 [[IDX]], [[B]]
; CHECK-NEXT:    [[EXT_1:%.*]] = zext i16 [[IDX_SHL_1]] to i64
; CHECK-NEXT:    [[ADD_PTR_SHL_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 [[EXT_1]]
; CHECK-NEXT:    [[C_MAX_1:%.*]] = icmp slt ptr [[ADD_PTR_SHL_1]], [[MAX]]
; CHECK-NEXT:    ret i1 [[C_MAX_1]]
;
check.0.min:
  %add.10 = getelementptr inbounds i16, ptr %src, i16 10
  %c.add.10.max = icmp sgt ptr %add.10, %max
  br i1 %c.add.10.max, label %exit.1, label %check.idx

exit.1:
  ret i1 true

check.idx:
  %cmp = icmp slt i16 %idx, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %idx.shl = shl nuw i16 %idx, %B
  %ext = zext i16 %idx.shl to i64
  %add.ptr.shl = getelementptr inbounds i16, ptr %src, i64 %ext
  %c.max = icmp slt ptr %add.ptr.shl, %max
  ret i1 %c.max

trap:
  %idx.shl.1 = shl nuw i16 %idx, %B
  %ext.1 = zext i16 %idx.shl.1 to i64
  %add.ptr.shl.1 = getelementptr inbounds i16, ptr %src, i64 %ext.1
  %c.max.1 = icmp slt ptr %add.ptr.shl.1, %max
  ret i1 %c.max.1
}

declare void @use(i1)
