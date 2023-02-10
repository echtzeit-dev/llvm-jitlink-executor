; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=guard-widening < %s | FileCheck %s

declare void @llvm.experimental.guard(i1,...)

define void @f_0(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2]], [[CHK0]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3]], [[CHK0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_1(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X_INC1]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2]], [[CHK0]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X_INC2]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3]], [[CHK0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x.inc1, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x.inc2, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_2(i32 %a, ptr %length_buf) {
; CHECK-LABEL: @f_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X:%.*]] = and i32 [[A:%.*]], -256
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = or i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = or i32 [[X]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2]], [[CHK0]]
; CHECK-NEXT:    [[X_INC3:%.*]] = or i32 [[X]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3]], [[CHK0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %x = and i32 %a, 4294967040 ;; 4294967040 == 0xffffff00
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = or i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = or i32 %x, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = or i32 %x, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_3(i32 %a, ptr %length_buf) {
; CHECK-LABEL: @f_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X:%.*]] = and i32 [[A:%.*]], -256
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = or i32 [[X_INC1]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2]], [[CHK0]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X_INC2]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3]], [[CHK0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %x = and i32 %a, 4294967040 ;; 4294967040 == 0xffffff00
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = or i32 %x.inc1, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x.inc2, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_4(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], -1024
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2]], [[CHK1]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3]], [[CHK1]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;

; Note: we NOT guarding on "and i1 %chk3, %chk0", that would be incorrect.
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, -1024
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_5(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X_INC1]], -200
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK1]], [[CHK2]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK1]], [[CHK2]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X_INC2]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    ret void
;
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x.inc1, -200
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x.inc2, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}


; Negative test: we can't merge these checks into
;
;  (%x + -2147483647) u< L && (%x + 3) u< L
;
; because if %length == INT_MAX and %x == -3 then
;
; (%x + -2147483647) == i32 2147483646  u< L   (L is 2147483647)
; (%x + 3) == 0 u< L
;
; But (%x + 2) == -1 is not u< L
;
define void @f_6(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], -2147483647
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X]], 2
; CHECK-NEXT:    [[CHK2:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[WIDE_CHK]], [[CHK2]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X]], 3
; CHECK-NEXT:    [[CHK3:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[WIDE_CHK1]], [[CHK3]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, -2147483647 ;; -2147483647 == (i32 INT_MIN)+1 == -(i32 INT_MAX)
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x, 2
  %chk2 = icmp ult i32 %x.inc2, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x, 3
  %chk3 = icmp ult i32 %x.inc3, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}


define void @f_7(i32 %x, ptr %length_buf) {
; CHECK-LABEL: @f_7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH_A:%.*]] = load volatile i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[LENGTH_B:%.*]] = load volatile i32, ptr [[LENGTH_BUF]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0_A:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH_A]]
; CHECK-NEXT:    [[CHK0_B:%.*]] = icmp ult i32 [[X]], [[LENGTH_B]]
; CHECK-NEXT:    [[CHK0:%.*]] = and i1 [[CHK0_A]], [[CHK0_B]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1_A:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH_A]]
; CHECK-NEXT:    [[CHK1_B:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH_B]]
; CHECK-NEXT:    [[CHK1:%.*]] = and i1 [[CHK1_A]], [[CHK1_B]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    [[X_INC2:%.*]] = add i32 [[X]], 2
; CHECK-NEXT:    [[CHK2_A:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH_A]]
; CHECK-NEXT:    [[TMP0:%.*]] = and i1 [[CHK2_A]], [[CHK0_A]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i1 [[CHK0_B]], [[TMP0]]
; CHECK-NEXT:    [[CHK2_B:%.*]] = icmp ult i32 [[X_INC2]], [[LENGTH_B]]
; CHECK-NEXT:    [[WIDE_CHK1:%.*]] = and i1 [[CHK2_B]], [[TMP1]]
; CHECK-NEXT:    [[X_INC3:%.*]] = add i32 [[X]], 3
; CHECK-NEXT:    [[CHK3_B:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH_B]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i1 [[CHK3_B]], [[CHK0_B]]
; CHECK-NEXT:    [[TMP3:%.*]] = and i1 [[CHK0_A]], [[TMP2]]
; CHECK-NEXT:    [[CHK3_A:%.*]] = icmp ult i32 [[X_INC3]], [[LENGTH_A]]
; CHECK-NEXT:    [[WIDE_CHK2:%.*]] = and i1 [[CHK3_A]], [[TMP3]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK2]]) [ "deopt"() ]
; CHECK-NEXT:    [[CHK2:%.*]] = and i1 [[CHK2_A]], [[CHK2_B]]
; CHECK-NEXT:    [[CHK3:%.*]] = and i1 [[CHK3_A]], [[CHK3_B]]
; CHECK-NEXT:    ret void
;


entry:
  %length_a = load volatile i32, ptr %length_buf, !range !0
  %length_b = load volatile i32, ptr %length_buf, !range !0
  %chk0.a = icmp ult i32 %x, %length_a
  %chk0.b = icmp ult i32 %x, %length_b
  %chk0 = and i1 %chk0.a, %chk0.b
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add i32 %x, 1
  %chk1.a = icmp ult i32 %x.inc1, %length_a
  %chk1.b = icmp ult i32 %x.inc1, %length_b
  %chk1 = and i1 %chk1.a, %chk1.b
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]

  %x.inc2 = add i32 %x, 2
  %chk2.a = icmp ult i32 %x.inc2, %length_a
  %chk2.b = icmp ult i32 %x.inc2, %length_b
  %chk2 = and i1 %chk2.a, %chk2.b
  call void(i1, ...) @llvm.experimental.guard(i1 %chk2) [ "deopt"() ]

  %x.inc3 = add i32 %x, 3
  %chk3.a = icmp ult i32 %x.inc3, %length_a
  %chk3.b = icmp ult i32 %x.inc3, %length_b
  %chk3 = and i1 %chk3.a, %chk3.b
  call void(i1, ...) @llvm.experimental.guard(i1 %chk3) [ "deopt"() ]
  ret void
}

define void @f_8(i32 %x, ptr %length_buf) {
; Check that we clean nuw nsw flags
; CHECK-LABEL: @f_8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LENGTH:%.*]] = load i32, ptr [[LENGTH_BUF:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHK0:%.*]] = icmp ult i32 [[X:%.*]], [[LENGTH]]
; CHECK-NEXT:    [[X_INC1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    [[CHK1:%.*]] = icmp ult i32 [[X_INC1]], [[LENGTH]]
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = and i1 [[CHK0]], [[CHK1]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WIDE_CHK]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
entry:
  %length = load i32, ptr %length_buf, !range !0
  %chk0 = icmp ult i32 %x, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk0) [ "deopt"() ]

  %x.inc1 = add nuw nsw i32 %x, 1
  %chk1 = icmp ult i32 %x.inc1, %length
  call void(i1, ...) @llvm.experimental.guard(i1 %chk1) [ "deopt"() ]
  ret void
}



!0 = !{i32 0, i32 2147483648}
