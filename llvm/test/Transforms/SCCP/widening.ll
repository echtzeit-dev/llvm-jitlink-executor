; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes=sccp -S | FileCheck --check-prefix=SCCP %s
; RUN: opt %s -passes=ipsccp -S | FileCheck --check-prefix=IPSCCP %s

; Test different widening scenarios.

declare void @use(i1)
declare i1 @cond()

define void @test_2_incoming_constants(i32 %x) {
; SCCP-LABEL: @test_2_incoming_constants(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    br label [[EXIT]]
; SCCP:       exit:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ]
; SCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; SCCP-NEXT:    call void @use(i1 true)
; SCCP-NEXT:    call void @use(i1 false)
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @test_2_incoming_constants(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    br label [[EXIT]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ]
; IPSCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    call void @use(i1 false)
; IPSCCP-NEXT:    ret void
;
entry:
  %c.1 = call i1 @cond()
  br i1 %c.1, label %bb1, label %exit

bb1:
  br label %exit

exit:
  %p = phi i32 [0, %entry], [1, %bb1]
  %a = add i32 %p, 1
  %t.1 = icmp ult i32 %a, 20
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %a, 10
  call void @use(i1 %f.1)
  ret void
}

define void @test_3_incoming_constants(i32 %x) {
; SCCP-LABEL: @test_3_incoming_constants(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_2]], label [[BB2:%.*]], label [[EXIT]]
; SCCP:       bb2:
; SCCP-NEXT:    br label [[EXIT]]
; SCCP:       exit:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ], [ 2, [[BB2]] ]
; SCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; SCCP-NEXT:    call void @use(i1 true)
; SCCP-NEXT:    call void @use(i1 false)
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @test_3_incoming_constants(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_2]], label [[BB2:%.*]], label [[EXIT]]
; IPSCCP:       bb2:
; IPSCCP-NEXT:    br label [[EXIT]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ], [ 2, [[BB2]] ]
; IPSCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    call void @use(i1 false)
; IPSCCP-NEXT:    ret void
;
entry:
  %c.1 = call i1 @cond()
  br i1 %c.1, label %bb1, label %exit

bb1:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %bb2, label %exit

bb2:
  br label %exit

exit:
  %p = phi i32 [0, %entry], [1, %bb1], [2, %bb2]
  %a = add i32 %p, 1
  %t.1 = icmp ult i32 %a, 20
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %a, 10
  call void @use(i1 %f.1)
  ret void
}

define void @test_5_incoming_constants(i32 %x) {
; SCCP-LABEL: @test_5_incoming_constants(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_2]], label [[BB2:%.*]], label [[EXIT]]
; SCCP:       bb2:
; SCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; SCCP:       bb3:
; SCCP-NEXT:    [[C_4:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_4]], label [[BB4:%.*]], label [[EXIT]]
; SCCP:       bb4:
; SCCP-NEXT:    br label [[EXIT]]
; SCCP:       exit:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ], [ 2, [[BB2]] ], [ 3, [[BB3]] ], [ 4, [[BB4]] ]
; SCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; SCCP-NEXT:    call void @use(i1 true)
; SCCP-NEXT:    call void @use(i1 false)
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @test_5_incoming_constants(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[EXIT:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_2]], label [[BB2:%.*]], label [[EXIT]]
; IPSCCP:       bb2:
; IPSCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; IPSCCP:       bb3:
; IPSCCP-NEXT:    [[C_4:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_4]], label [[BB4:%.*]], label [[EXIT]]
; IPSCCP:       bb4:
; IPSCCP-NEXT:    br label [[EXIT]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ 1, [[BB1]] ], [ 2, [[BB2]] ], [ 3, [[BB3]] ], [ 4, [[BB4]] ]
; IPSCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    call void @use(i1 false)
; IPSCCP-NEXT:    ret void
;
entry:
  %c.1 = call i1 @cond()
  br i1 %c.1, label %bb1, label %exit

bb1:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %bb2, label %exit

bb2:
  %c.3 = call i1 @cond()
  br i1 %c.3, label %bb3, label %exit

bb3:
  %c.4 = call i1 @cond()
  br i1 %c.4, label %bb4, label %exit

bb4:
  br label %exit

exit:
  %p = phi i32 [0, %entry], [1, %bb1], [2, %bb2], [3, %bb3], [4, %bb4]
  %a = add i32 %p, 1
  %t.1 = icmp ult i32 %a, 20
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %a, 10
  call void @use(i1 %f.1)
  ret void
}

; For the rotated_loop_* test cases %p and %a are extended on each iteration.

define void @rotated_loop_2(i32 %x) {
; SCCP-LABEL: @rotated_loop_2(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[BB1:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_2]], label [[EXIT]], label [[BB2:%.*]]
; SCCP:       bb2:
; SCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; SCCP:       bb3:
; SCCP-NEXT:    br label [[EXIT]]
; SCCP:       exit:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ 3, [[BB1]] ], [ 2, [[BB2]] ], [ 5, [[BB3]] ]
; SCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; SCCP-NEXT:    call void @use(i1 true)
; SCCP-NEXT:    call void @use(i1 false)
; SCCP-NEXT:    br label [[EXIT_1:%.*]]
; SCCP:       exit.1:
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @rotated_loop_2(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[BB1:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_2]], label [[EXIT]], label [[BB2:%.*]]
; IPSCCP:       bb2:
; IPSCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; IPSCCP:       bb3:
; IPSCCP-NEXT:    br label [[EXIT]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ 3, [[BB1]] ], [ 2, [[BB2]] ], [ 5, [[BB3]] ]
; IPSCCP-NEXT:    [[A:%.*]] = add nuw nsw i32 [[P]], 1
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    call void @use(i1 false)
; IPSCCP-NEXT:    br label [[EXIT_1:%.*]]
; IPSCCP:       exit.1:
; IPSCCP-NEXT:    ret void
;
entry:
  %c.1 = call i1 @cond()
  br i1 %c.1, label %exit, label %bb1

bb1:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %exit, label %bb2

bb2:
  %c.3 = call i1 @cond()
  br i1 %c.3, label %bb3, label %exit

bb3:
  br label %exit

exit:
  %p = phi i32 [1, %entry], [3, %bb1], [2, %bb2], [5, %bb3], [%a, %exit]
  %a = add i32 %p, 1
  %t.1 = icmp ult i32 %a, 20
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %a, 10
  call void @use(i1 %f.1)
  %c.4 = icmp ult i32 %a, 2
  br i1 %c.4, label %exit, label %exit.1

exit.1:
  ret void
}

define void @rotated_loop_3(i32 %x) {
; SCCP-LABEL: @rotated_loop_3(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[BB1:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_2]], label [[EXIT]], label [[BB2:%.*]]
; SCCP:       bb2:
; SCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; SCCP:       bb3:
; SCCP-NEXT:    br label [[EXIT]]
; SCCP:       exit:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ 3, [[BB1]] ], [ 2, [[BB2]] ], [ 5, [[BB3]] ], [ [[A:%.*]], [[EXIT]] ]
; SCCP-NEXT:    [[A]] = add i32 [[P]], 1
; SCCP-NEXT:    [[T_1:%.*]] = icmp ult i32 [[A]], 20
; SCCP-NEXT:    call void @use(i1 [[T_1]])
; SCCP-NEXT:    [[F_1:%.*]] = icmp ugt i32 [[A]], 10
; SCCP-NEXT:    call void @use(i1 [[F_1]])
; SCCP-NEXT:    [[C_4:%.*]] = icmp ult i32 [[A]], 3
; SCCP-NEXT:    br i1 [[C_4]], label [[EXIT]], label [[EXIT_1:%.*]]
; SCCP:       exit.1:
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @rotated_loop_3(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[BB1:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_2]], label [[EXIT]], label [[BB2:%.*]]
; IPSCCP:       bb2:
; IPSCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_3]], label [[BB3:%.*]], label [[EXIT]]
; IPSCCP:       bb3:
; IPSCCP-NEXT:    br label [[EXIT]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ 3, [[BB1]] ], [ 2, [[BB2]] ], [ 5, [[BB3]] ], [ [[A:%.*]], [[EXIT]] ]
; IPSCCP-NEXT:    [[A]] = add i32 [[P]], 1
; IPSCCP-NEXT:    [[T_1:%.*]] = icmp ult i32 [[A]], 20
; IPSCCP-NEXT:    call void @use(i1 [[T_1]])
; IPSCCP-NEXT:    [[F_1:%.*]] = icmp ugt i32 [[A]], 10
; IPSCCP-NEXT:    call void @use(i1 [[F_1]])
; IPSCCP-NEXT:    [[C_4:%.*]] = icmp ult i32 [[A]], 3
; IPSCCP-NEXT:    br i1 [[C_4]], label [[EXIT]], label [[EXIT_1:%.*]]
; IPSCCP:       exit.1:
; IPSCCP-NEXT:    ret void
;
entry:
  %c.1 = call i1 @cond()
  br i1 %c.1, label %exit, label %bb1

bb1:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %exit, label %bb2

bb2:
  %c.3 = call i1 @cond()
  br i1 %c.3, label %bb3, label %exit

bb3:
  br label %exit

exit:
  %p = phi i32 [1, %entry], [3, %bb1], [2, %bb2], [5, %bb3], [%a, %exit]
  %a = add i32 %p, 1
  %t.1 = icmp ult i32 %a, 20
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %a, 10
  call void @use(i1 %f.1)
  %c.4 = icmp ult i32 %a, 3
  br i1 %c.4, label %exit, label %exit.1

exit.1:
  ret void
}

; For the loop_with_header_* tests, %iv and %a change on each iteration, but we
; can use the range imposed by the condition %c.1 when widening.
define void @loop_with_header_1(i32 %x) {
; SCCP-LABEL: @loop_with_header_1(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    br label [[LOOP_HEADER:%.*]]
; SCCP:       loop.header:
; SCCP-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_BODY:%.*]] ]
; SCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[IV]], 2
; SCCP-NEXT:    br i1 [[C_1]], label [[LOOP_BODY]], label [[EXIT:%.*]]
; SCCP:       loop.body:
; SCCP-NEXT:    [[T_1:%.*]] = icmp slt i32 [[IV]], 2
; SCCP-NEXT:    call void @use(i1 [[T_1]])
; SCCP-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; SCCP-NEXT:    br label [[LOOP_HEADER]]
; SCCP:       exit:
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @loop_with_header_1(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    br label [[LOOP_HEADER:%.*]]
; IPSCCP:       loop.header:
; IPSCCP-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_BODY:%.*]] ]
; IPSCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[IV]], 2
; IPSCCP-NEXT:    br i1 [[C_1]], label [[LOOP_BODY]], label [[EXIT:%.*]]
; IPSCCP:       loop.body:
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; IPSCCP-NEXT:    br label [[LOOP_HEADER]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [0, %entry], [%iv.next, %loop.body]
  %c.1 = icmp slt i32 %iv, 2
  br i1 %c.1, label %loop.body, label %exit

loop.body:
  %t.1 = icmp slt i32 %iv, 2
  call void @use(i1 %t.1)
  %iv.next = add nsw i32 %iv, 1
  br label %loop.header

exit:
  ret void
}

define void @loop_with_header_2(i32 %x) {
; SCCP-LABEL: @loop_with_header_2(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    br label [[LOOP_HEADER:%.*]]
; SCCP:       loop.header:
; SCCP-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_BODY:%.*]] ]
; SCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[IV]], 200
; SCCP-NEXT:    br i1 [[C_1]], label [[LOOP_BODY]], label [[EXIT:%.*]]
; SCCP:       loop.body:
; SCCP-NEXT:    [[T_1:%.*]] = icmp slt i32 [[IV]], 200
; SCCP-NEXT:    call void @use(i1 [[T_1]])
; SCCP-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; SCCP-NEXT:    br label [[LOOP_HEADER]]
; SCCP:       exit:
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @loop_with_header_2(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    br label [[LOOP_HEADER:%.*]]
; IPSCCP:       loop.header:
; IPSCCP-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_BODY:%.*]] ]
; IPSCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[IV]], 200
; IPSCCP-NEXT:    br i1 [[C_1]], label [[LOOP_BODY]], label [[EXIT:%.*]]
; IPSCCP:       loop.body:
; IPSCCP-NEXT:    call void @use(i1 true)
; IPSCCP-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; IPSCCP-NEXT:    br label [[LOOP_HEADER]]
; IPSCCP:       exit:
; IPSCCP-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [0, %entry], [%iv.next, %loop.body]
  %c.1 = icmp slt i32 %iv, 200
  br i1 %c.1, label %loop.body, label %exit

loop.body:
  %t.1 = icmp slt i32 %iv, 200
  call void @use(i1 %t.1)
  %iv.next = add nsw i32 %iv, 1
  br label %loop.header

exit:
  ret void
}

; In the function below, the condition %c.1 results in a range [7, 6), which
; can be used as a widening bound. It does not fully contain the range we get
; from combining it with the information from %tmp12.
define void @foo(ptr %arg) {
; SCCP-LABEL: @foo(
; SCCP-NEXT:  bb:
; SCCP-NEXT:    [[TMP:%.*]] = zext i8 undef to i32
; SCCP-NEXT:    [[TMP2:%.*]] = load i64, ptr [[ARG:%.*]], align 8
; SCCP-NEXT:    switch i32 [[TMP]], label [[BB20:%.*]] [
; SCCP-NEXT:    i32 1, label [[BB3:%.*]]
; SCCP-NEXT:    i32 2, label [[BB4:%.*]]
; SCCP-NEXT:    i32 4, label [[BB19:%.*]]
; SCCP-NEXT:    ]
; SCCP:       bb3:
; SCCP-NEXT:    unreachable
; SCCP:       bb4:
; SCCP-NEXT:    [[TMP5:%.*]] = add i64 [[TMP2]], 3
; SCCP-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 3
; SCCP-NEXT:    [[TMP7:%.*]] = sub nuw nsw i64 3, [[TMP6]]
; SCCP-NEXT:    [[TMP8:%.*]] = shl nuw nsw i64 [[TMP7]], 1
; SCCP-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i32
; SCCP-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
; SCCP-NEXT:    br label [[BB11:%.*]]
; SCCP:       bb11:
; SCCP-NEXT:    [[TMP12:%.*]] = phi i64 [ [[TMP10]], [[BB4]] ], [ [[TMP17:%.*]], [[BB18:%.*]] ]
; SCCP-NEXT:    br label [[BB13:%.*]]
; SCCP:       bb13:
; SCCP-NEXT:    [[C_1:%.*]] = icmp eq i64 [[TMP12]], 6
; SCCP-NEXT:    br i1 [[C_1]], label [[BB15:%.*]], label [[BB16:%.*]]
; SCCP:       bb15:
; SCCP-NEXT:    unreachable
; SCCP:       bb16:
; SCCP-NEXT:    [[TMP17]] = add i64 [[TMP12]], 2
; SCCP-NEXT:    br label [[BB18]]
; SCCP:       bb18:
; SCCP-NEXT:    br label [[BB11]]
; SCCP:       bb19:
; SCCP-NEXT:    unreachable
; SCCP:       bb20:
; SCCP-NEXT:    ret void
;
; IPSCCP-LABEL: @foo(
; IPSCCP-NEXT:  bb:
; IPSCCP-NEXT:    [[TMP:%.*]] = zext i8 undef to i32
; IPSCCP-NEXT:    [[TMP2:%.*]] = load i64, ptr [[ARG:%.*]], align 8
; IPSCCP-NEXT:    switch i32 [[TMP]], label [[BB20:%.*]] [
; IPSCCP-NEXT:    i32 1, label [[BB3:%.*]]
; IPSCCP-NEXT:    i32 2, label [[BB4:%.*]]
; IPSCCP-NEXT:    i32 4, label [[BB19:%.*]]
; IPSCCP-NEXT:    ]
; IPSCCP:       bb3:
; IPSCCP-NEXT:    unreachable
; IPSCCP:       bb4:
; IPSCCP-NEXT:    [[TMP5:%.*]] = add i64 [[TMP2]], 3
; IPSCCP-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 3
; IPSCCP-NEXT:    [[TMP7:%.*]] = sub nuw nsw i64 3, [[TMP6]]
; IPSCCP-NEXT:    [[TMP8:%.*]] = shl nuw nsw i64 [[TMP7]], 1
; IPSCCP-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i32
; IPSCCP-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
; IPSCCP-NEXT:    br label [[BB11:%.*]]
; IPSCCP:       bb11:
; IPSCCP-NEXT:    [[TMP12:%.*]] = phi i64 [ [[TMP10]], [[BB4]] ], [ [[TMP17:%.*]], [[BB18:%.*]] ]
; IPSCCP-NEXT:    br label [[BB13:%.*]]
; IPSCCP:       bb13:
; IPSCCP-NEXT:    [[C_1:%.*]] = icmp eq i64 [[TMP12]], 6
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB15:%.*]], label [[BB16:%.*]]
; IPSCCP:       bb15:
; IPSCCP-NEXT:    unreachable
; IPSCCP:       bb16:
; IPSCCP-NEXT:    [[TMP17]] = add i64 [[TMP12]], 2
; IPSCCP-NEXT:    br label [[BB18]]
; IPSCCP:       bb18:
; IPSCCP-NEXT:    br label [[BB11]]
; IPSCCP:       bb19:
; IPSCCP-NEXT:    unreachable
; IPSCCP:       bb20:
; IPSCCP-NEXT:    ret void
;
bb:
  %tmp = zext i8 undef to i32
  %tmp2 = load i64, ptr %arg, align 8
  switch i32 %tmp, label %bb20 [
  i32 1, label %bb3
  i32 2, label %bb4
  i32 4, label %bb19
  ]

bb3:                                              ; preds = %bb
  unreachable

bb4:                                              ; preds = %bb
  %tmp5 = add i64 %tmp2, 3
  %tmp6 = and i64 %tmp5, 3
  %tmp7 = sub i64 3, %tmp6
  %tmp8 = shl i64 %tmp7, 1
  %tmp9 = trunc i64 %tmp8 to i32
  %tmp10 = sext i32 %tmp9 to i64
  br label %bb11

bb11:                                             ; preds = %bb18, %bb4
  %tmp12 = phi i64 [ %tmp10, %bb4 ], [ %tmp17, %bb18 ]
  br label %bb13

bb13:                                             ; preds = %bb11
  %c.1 = icmp eq i64 %tmp12, 6
  br i1 %c.1, label %bb15, label %bb16

bb15:                                             ; preds = %bb13
  unreachable

bb16:                                             ; preds = %bb13
  %tmp17 = add i64 %tmp12, 2
  br label %bb18

bb18:                                             ; preds = %bb16
  br label %bb11

bb19:                                             ; preds = %bb
  unreachable

bb20:                                             ; preds = %bb
  ret void
}

; The functions below check that widening with an upper bound does correctly
; return whether the range changed. Make sure we do not eliminate %c.2.

%struct.baz.1 = type { i32, i32, ptr, ptr }
%struct.blam.2 = type <{ %struct.baz.1, i32, [4 x i8] }>

@global.11 = linkonce_odr global [4 x i8] zeroinitializer, align 1

declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

define linkonce_odr dereferenceable(1) ptr @spam(ptr %arg, i32 %arg1) align 2 {
; SCCP-LABEL: @spam(
; SCCP-NEXT:  bb:
; SCCP-NEXT:    [[TMP:%.*]] = getelementptr inbounds [[STRUCT_BAZ_1:%.*]], ptr [[ARG:%.*]], i32 0, i32 3
; SCCP-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[TMP]], align 8
; SCCP-NEXT:    [[TMP3:%.*]] = sext i32 [[ARG1:%.*]] to i64
; SCCP-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP2]], i64 [[TMP3]]
; SCCP-NEXT:    ret ptr [[TMP4]]
;
; IPSCCP-LABEL: @spam(
; IPSCCP-NEXT:  bb:
; IPSCCP-NEXT:    [[TMP:%.*]] = getelementptr inbounds [[STRUCT_BAZ_1:%.*]], ptr [[ARG:%.*]], i32 0, i32 3
; IPSCCP-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[TMP]], align 8
; IPSCCP-NEXT:    [[TMP3:%.*]] = sext i32 [[ARG1:%.*]] to i64
; IPSCCP-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP2]], i64 [[TMP3]]
; IPSCCP-NEXT:    ret ptr [[TMP4]]
;
bb:
  %tmp = getelementptr inbounds %struct.baz.1, ptr %arg, i32 0, i32 3
  %tmp2 = load ptr, ptr %tmp, align 8
  %tmp3 = sext i32 %arg1 to i64
  %tmp4 = getelementptr inbounds i8, ptr %tmp2, i64 %tmp3
  ret ptr %tmp4
}

define ptr @wobble(ptr %arg, i32 %arg1) align 2 {
; SCCP-LABEL: @wobble(
; SCCP-NEXT:  bb:
; SCCP-NEXT:    [[TMP:%.*]] = lshr i32 [[ARG1:%.*]], 16
; SCCP-NEXT:    [[TMP2:%.*]] = xor i32 [[TMP]], [[ARG1]]
; SCCP-NEXT:    [[TMP3:%.*]] = and i32 [[TMP2]], 65535
; SCCP-NEXT:    [[TMP4:%.*]] = mul i32 [[ARG1]], 8
; SCCP-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_BLAM_2:%.*]], ptr [[ARG:%.*]], i32 0, i32 1
; SCCP-NEXT:    [[TMP6:%.*]] = load i32, ptr [[TMP5]], align 8
; SCCP-NEXT:    [[TMP7:%.*]] = and i32 [[TMP4]], [[TMP6]]
; SCCP-NEXT:    br label [[BB8:%.*]]
; SCCP:       bb8:
; SCCP-NEXT:    [[TMP9:%.*]] = phi ptr [ undef, [[BB:%.*]] ], [ [[TMP17:%.*]], [[BB29:%.*]] ]
; SCCP-NEXT:    [[TMP10:%.*]] = phi ptr [ undef, [[BB]] ], [ [[TMP17]], [[BB29]] ]
; SCCP-NEXT:    [[TMP11:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP30:%.*]], [[BB29]] ]
; SCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[TMP11]], 8
; SCCP-NEXT:    br i1 [[C_1]], label [[BB13:%.*]], label [[BB31:%.*]]
; SCCP:       bb13:
; SCCP-NEXT:    [[TMP15:%.*]] = add i32 [[TMP7]], [[TMP11]]
; SCCP-NEXT:    [[TMP16:%.*]] = mul i32 [[TMP15]], 4
; SCCP-NEXT:    [[TMP17]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP16]])
; SCCP-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i8, ptr [[TMP17]], i64 2
; SCCP-NEXT:    [[TMP20:%.*]] = load i8, ptr [[TMP19]], align 1
; SCCP-NEXT:    [[TMP21:%.*]] = zext i8 [[TMP20]] to i32
; SCCP-NEXT:    [[TMP22:%.*]] = icmp eq i32 [[TMP21]], 0
; SCCP-NEXT:    br i1 [[TMP22]], label [[BB23:%.*]], label [[BB25:%.*]]
; SCCP:       bb23:
; SCCP-NEXT:    [[TMP24:%.*]] = trunc i32 [[TMP3]] to i16
; SCCP-NEXT:    store i16 [[TMP24]], ptr [[TMP17]], align 2
; SCCP-NEXT:    br label [[BB31]]
; SCCP:       bb25:
; SCCP-NEXT:    [[TMP26:%.*]] = load i16, ptr [[TMP17]], align 2
; SCCP-NEXT:    [[TMP27:%.*]] = zext i16 [[TMP26]] to i32
; SCCP-NEXT:    [[TMP28:%.*]] = icmp eq i32 [[TMP27]], [[TMP3]]
; SCCP-NEXT:    br i1 [[TMP28]], label [[BB31]], label [[BB29]]
; SCCP:       bb29:
; SCCP-NEXT:    [[TMP30]] = add nsw i32 [[TMP11]], 1
; SCCP-NEXT:    br label [[BB8]]
; SCCP:       bb31:
; SCCP-NEXT:    [[TMP32:%.*]] = phi ptr [ [[TMP17]], [[BB23]] ], [ [[TMP17]], [[BB25]] ], [ [[TMP9]], [[BB8]] ]
; SCCP-NEXT:    [[TMP33:%.*]] = phi ptr [ [[TMP17]], [[BB23]] ], [ [[TMP17]], [[BB25]] ], [ [[TMP10]], [[BB8]] ]
; SCCP-NEXT:    [[TMP34:%.*]] = icmp eq i32 [[TMP11]], 0
; SCCP-NEXT:    br i1 [[TMP34]], label [[BB35:%.*]], label [[BB37:%.*]]
; SCCP:       bb35:
; SCCP-NEXT:    [[TMP36:%.*]] = getelementptr inbounds i8, ptr [[TMP32]], i64 1
; SCCP-NEXT:    br label [[BB66:%.*]]
; SCCP:       bb37:
; SCCP-NEXT:    [[C_2:%.*]] = icmp eq i32 [[TMP11]], 8
; SCCP-NEXT:    br i1 [[C_2]], label [[BB39:%.*]], label [[BB58:%.*]]
; SCCP:       bb39:
; SCCP-NEXT:    [[TMP40:%.*]] = add nsw i32 [[TMP11]], -1
; SCCP-NEXT:    [[TMP41:%.*]] = trunc i32 [[TMP3]] to i16
; SCCP-NEXT:    store i16 [[TMP41]], ptr @global.11, align 1
; SCCP-NEXT:    [[TMP43:%.*]] = add i32 [[TMP7]], [[TMP40]]
; SCCP-NEXT:    [[TMP44:%.*]] = mul i32 [[TMP43]], 4
; SCCP-NEXT:    [[TMP45:%.*]] = add i32 [[TMP44]], 2
; SCCP-NEXT:    [[TMP46:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP45]])
; SCCP-NEXT:    [[TMP47:%.*]] = load i8, ptr [[TMP46]], align 1
; SCCP-NEXT:    [[TMP48:%.*]] = zext i8 [[TMP47]] to i32
; SCCP-NEXT:    [[TMP49:%.*]] = sub i32 [[TMP43]], 1
; SCCP-NEXT:    [[TMP50:%.*]] = mul i32 [[TMP49]], 4
; SCCP-NEXT:    [[TMP51:%.*]] = add i32 [[TMP50]], 2
; SCCP-NEXT:    [[TMP52:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP51]])
; SCCP-NEXT:    [[TMP53:%.*]] = load i8, ptr [[TMP52]], align 1
; SCCP-NEXT:    [[TMP54:%.*]] = zext i8 [[TMP53]] to i32
; SCCP-NEXT:    [[TMP55:%.*]] = icmp sgt i32 [[TMP48]], [[TMP54]]
; SCCP-NEXT:    br i1 [[TMP55]], label [[BB56:%.*]], label [[BB60:%.*]]
; SCCP:       bb56:
; SCCP-NEXT:    [[TMP57:%.*]] = add nsw i32 [[TMP40]], -1
; SCCP-NEXT:    br label [[BB60]]
; SCCP:       bb58:
; SCCP-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 1 @global.11, ptr align 2 [[TMP33]], i64 4, i1 false)
; SCCP-NEXT:    br label [[BB60]]
; SCCP:       bb60:
; SCCP-NEXT:    [[TMP61:%.*]] = phi i32 [ [[TMP57]], [[BB56]] ], [ [[TMP40]], [[BB39]] ], [ [[TMP11]], [[BB58]] ]
; SCCP-NEXT:    [[TMP63:%.*]] = add i32 [[TMP7]], 1
; SCCP-NEXT:    [[TMP64:%.*]] = mul i32 [[TMP63]], 4
; SCCP-NEXT:    [[TMP65:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP64]])
; SCCP-NEXT:    br label [[BB66]]
; SCCP:       bb66:
; SCCP-NEXT:    [[TMP67:%.*]] = phi ptr [ [[TMP36]], [[BB35]] ], [ null, [[BB60]] ]
; SCCP-NEXT:    ret ptr [[TMP67]]
;
; IPSCCP-LABEL: @wobble(
; IPSCCP-NEXT:  bb:
; IPSCCP-NEXT:    [[TMP:%.*]] = lshr i32 [[ARG1:%.*]], 16
; IPSCCP-NEXT:    [[TMP2:%.*]] = xor i32 [[TMP]], [[ARG1]]
; IPSCCP-NEXT:    [[TMP3:%.*]] = and i32 [[TMP2]], 65535
; IPSCCP-NEXT:    [[TMP4:%.*]] = mul i32 [[ARG1]], 8
; IPSCCP-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_BLAM_2:%.*]], ptr [[ARG:%.*]], i32 0, i32 1
; IPSCCP-NEXT:    [[TMP6:%.*]] = load i32, ptr [[TMP5]], align 8
; IPSCCP-NEXT:    [[TMP7:%.*]] = and i32 [[TMP4]], [[TMP6]]
; IPSCCP-NEXT:    br label [[BB8:%.*]]
; IPSCCP:       bb8:
; IPSCCP-NEXT:    [[TMP9:%.*]] = phi ptr [ undef, [[BB:%.*]] ], [ [[TMP17:%.*]], [[BB29:%.*]] ]
; IPSCCP-NEXT:    [[TMP10:%.*]] = phi ptr [ undef, [[BB]] ], [ [[TMP17]], [[BB29]] ]
; IPSCCP-NEXT:    [[TMP11:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP30:%.*]], [[BB29]] ]
; IPSCCP-NEXT:    [[C_1:%.*]] = icmp slt i32 [[TMP11]], 8
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB13:%.*]], label [[BB31:%.*]]
; IPSCCP:       bb13:
; IPSCCP-NEXT:    [[TMP15:%.*]] = add i32 [[TMP7]], [[TMP11]]
; IPSCCP-NEXT:    [[TMP16:%.*]] = mul i32 [[TMP15]], 4
; IPSCCP-NEXT:    [[TMP17]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP16]])
; IPSCCP-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i8, ptr [[TMP17]], i64 2
; IPSCCP-NEXT:    [[TMP20:%.*]] = load i8, ptr [[TMP19]], align 1
; IPSCCP-NEXT:    [[TMP21:%.*]] = zext i8 [[TMP20]] to i32
; IPSCCP-NEXT:    [[TMP22:%.*]] = icmp eq i32 [[TMP21]], 0
; IPSCCP-NEXT:    br i1 [[TMP22]], label [[BB23:%.*]], label [[BB25:%.*]]
; IPSCCP:       bb23:
; IPSCCP-NEXT:    [[TMP24:%.*]] = trunc i32 [[TMP3]] to i16
; IPSCCP-NEXT:    store i16 [[TMP24]], ptr [[TMP17]], align 2
; IPSCCP-NEXT:    br label [[BB31]]
; IPSCCP:       bb25:
; IPSCCP-NEXT:    [[TMP26:%.*]] = load i16, ptr [[TMP17]], align 2
; IPSCCP-NEXT:    [[TMP27:%.*]] = zext i16 [[TMP26]] to i32
; IPSCCP-NEXT:    [[TMP28:%.*]] = icmp eq i32 [[TMP27]], [[TMP3]]
; IPSCCP-NEXT:    br i1 [[TMP28]], label [[BB31]], label [[BB29]]
; IPSCCP:       bb29:
; IPSCCP-NEXT:    [[TMP30]] = add nsw i32 [[TMP11]], 1
; IPSCCP-NEXT:    br label [[BB8]]
; IPSCCP:       bb31:
; IPSCCP-NEXT:    [[TMP32:%.*]] = phi ptr [ [[TMP17]], [[BB23]] ], [ [[TMP17]], [[BB25]] ], [ [[TMP9]], [[BB8]] ]
; IPSCCP-NEXT:    [[TMP33:%.*]] = phi ptr [ [[TMP17]], [[BB23]] ], [ [[TMP17]], [[BB25]] ], [ [[TMP10]], [[BB8]] ]
; IPSCCP-NEXT:    [[TMP34:%.*]] = icmp eq i32 [[TMP11]], 0
; IPSCCP-NEXT:    br i1 [[TMP34]], label [[BB35:%.*]], label [[BB37:%.*]]
; IPSCCP:       bb35:
; IPSCCP-NEXT:    [[TMP36:%.*]] = getelementptr inbounds i8, ptr [[TMP32]], i64 1
; IPSCCP-NEXT:    br label [[BB66:%.*]]
; IPSCCP:       bb37:
; IPSCCP-NEXT:    [[C_2:%.*]] = icmp eq i32 [[TMP11]], 8
; IPSCCP-NEXT:    br i1 [[C_2]], label [[BB39:%.*]], label [[BB58:%.*]]
; IPSCCP:       bb39:
; IPSCCP-NEXT:    [[TMP41:%.*]] = trunc i32 [[TMP3]] to i16
; IPSCCP-NEXT:    store i16 [[TMP41]], ptr @global.11, align 1
; IPSCCP-NEXT:    [[TMP43:%.*]] = add i32 [[TMP7]], 7
; IPSCCP-NEXT:    [[TMP44:%.*]] = mul i32 [[TMP43]], 4
; IPSCCP-NEXT:    [[TMP45:%.*]] = add i32 [[TMP44]], 2
; IPSCCP-NEXT:    [[TMP46:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP45]])
; IPSCCP-NEXT:    [[TMP47:%.*]] = load i8, ptr [[TMP46]], align 1
; IPSCCP-NEXT:    [[TMP48:%.*]] = zext i8 [[TMP47]] to i32
; IPSCCP-NEXT:    [[TMP49:%.*]] = sub i32 [[TMP43]], 1
; IPSCCP-NEXT:    [[TMP50:%.*]] = mul i32 [[TMP49]], 4
; IPSCCP-NEXT:    [[TMP51:%.*]] = add i32 [[TMP50]], 2
; IPSCCP-NEXT:    [[TMP52:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP51]])
; IPSCCP-NEXT:    [[TMP53:%.*]] = load i8, ptr [[TMP52]], align 1
; IPSCCP-NEXT:    [[TMP54:%.*]] = zext i8 [[TMP53]] to i32
; IPSCCP-NEXT:    [[TMP55:%.*]] = icmp sgt i32 [[TMP48]], [[TMP54]]
; IPSCCP-NEXT:    br i1 [[TMP55]], label [[BB56:%.*]], label [[BB60:%.*]]
; IPSCCP:       bb56:
; IPSCCP-NEXT:    br label [[BB60]]
; IPSCCP:       bb58:
; IPSCCP-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 1 @global.11, ptr align 2 [[TMP33]], i64 4, i1 false)
; IPSCCP-NEXT:    br label [[BB60]]
; IPSCCP:       bb60:
; IPSCCP-NEXT:    [[TMP61:%.*]] = phi i32 [ 6, [[BB56]] ], [ 7, [[BB39]] ], [ [[TMP11]], [[BB58]] ]
; IPSCCP-NEXT:    [[TMP63:%.*]] = add i32 [[TMP7]], 1
; IPSCCP-NEXT:    [[TMP64:%.*]] = mul i32 [[TMP63]], 4
; IPSCCP-NEXT:    [[TMP65:%.*]] = call dereferenceable(1) ptr @spam(ptr [[ARG]], i32 [[TMP64]])
; IPSCCP-NEXT:    br label [[BB66]]
; IPSCCP:       bb66:
; IPSCCP-NEXT:    [[TMP67:%.*]] = phi ptr [ [[TMP36]], [[BB35]] ], [ null, [[BB60]] ]
; IPSCCP-NEXT:    ret ptr [[TMP67]]
;
bb:
  %tmp = lshr i32 %arg1, 16
  %tmp2 = xor i32 %tmp, %arg1
  %tmp3 = and i32 %tmp2, 65535
  %tmp4 = mul i32 %arg1, 8
  %tmp5 = getelementptr inbounds %struct.blam.2, ptr %arg, i32 0, i32 1
  %tmp6 = load i32, ptr %tmp5, align 8
  %tmp7 = and i32 %tmp4, %tmp6
  br label %bb8

bb8:                                              ; preds = %bb29, %bb
  %tmp9 = phi ptr [ undef, %bb ], [ %tmp17, %bb29 ]
  %tmp10 = phi ptr [ undef, %bb ], [ %tmp17, %bb29 ]
  %tmp11 = phi i32 [ 0, %bb ], [ %tmp30, %bb29 ]
  %c.1 = icmp slt i32 %tmp11, 8
  br i1 %c.1, label %bb13, label %bb31

bb13:                                             ; preds = %bb8
  %tmp15 = add i32 %tmp7, %tmp11
  %tmp16 = mul i32 %tmp15, 4
  %tmp17 = call dereferenceable(1) ptr @spam(ptr %arg, i32 %tmp16)
  %tmp19 = getelementptr inbounds i8, ptr %tmp17, i64 2
  %tmp20 = load i8, ptr %tmp19, align 1
  %tmp21 = zext i8 %tmp20 to i32
  %tmp22 = icmp eq i32 %tmp21, 0
  br i1 %tmp22, label %bb23, label %bb25

bb23:                                             ; preds = %bb13
  %tmp24 = trunc i32 %tmp3 to i16
  store i16 %tmp24, ptr %tmp17, align 2
  br label %bb31

bb25:                                             ; preds = %bb13
  %tmp26 = load i16, ptr %tmp17, align 2
  %tmp27 = zext i16 %tmp26 to i32
  %tmp28 = icmp eq i32 %tmp27, %tmp3
  br i1 %tmp28, label %bb31, label %bb29

bb29:                                             ; preds = %bb25
  %tmp30 = add nsw i32 %tmp11, 1
  br label %bb8

bb31:                                             ; preds = %bb25, %bb23, %bb8
  %tmp32 = phi ptr [ %tmp17, %bb23 ], [ %tmp17, %bb25 ], [ %tmp9, %bb8 ]
  %tmp33 = phi ptr [ %tmp17, %bb23 ], [ %tmp17, %bb25 ], [ %tmp10, %bb8 ]
  %tmp34 = icmp eq i32 %tmp11, 0
  br i1 %tmp34, label %bb35, label %bb37

bb35:                                             ; preds = %bb31
  %tmp36 = getelementptr inbounds i8, ptr %tmp32, i64 1
  br label %bb66

bb37:                                             ; preds = %bb31
  %c.2 = icmp eq i32 %tmp11, 8
  br i1 %c.2, label %bb39, label %bb58

bb39:                                             ; preds = %bb37
  %tmp40 = add nsw i32 %tmp11, -1
  %tmp41 = trunc i32 %tmp3 to i16
  store i16 %tmp41, ptr @global.11, align 1
  %tmp43 = add i32 %tmp7, %tmp40
  %tmp44 = mul i32 %tmp43, 4
  %tmp45 = add i32 %tmp44, 2
  %tmp46 = call dereferenceable(1) ptr @spam(ptr %arg, i32 %tmp45)
  %tmp47 = load i8, ptr %tmp46, align 1
  %tmp48 = zext i8 %tmp47 to i32
  %tmp49 = sub i32 %tmp43, 1
  %tmp50 = mul i32 %tmp49, 4
  %tmp51 = add i32 %tmp50, 2
  %tmp52 = call dereferenceable(1) ptr @spam(ptr %arg, i32 %tmp51)
  %tmp53 = load i8, ptr %tmp52, align 1
  %tmp54 = zext i8 %tmp53 to i32
  %tmp55 = icmp sgt i32 %tmp48, %tmp54
  br i1 %tmp55, label %bb56, label %bb60

bb56:                                             ; preds = %bb39
  %tmp57 = add nsw i32 %tmp40, -1
  br label %bb60

bb58:                                             ; preds = %bb37
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 @global.11, ptr align 2 %tmp33, i64 4, i1 false)
  br label %bb60

bb60:                                             ; preds = %bb58, %bb56, %bb39
  %tmp61 = phi i32 [ %tmp57, %bb56 ], [ %tmp40, %bb39 ], [ %tmp11, %bb58 ]
  %tmp63 = add i32 %tmp7, 1
  %tmp64 = mul i32 %tmp63, 4
  %tmp65 = call dereferenceable(1) ptr @spam(ptr %arg, i32 %tmp64)
  br label %bb66

bb66:                                             ; preds = %bb60, %bb35
  %tmp67 = phi ptr [ %tmp36, %bb35 ], [ null, %bb60 ]
  ret ptr %tmp67
}


define i32 @loop_with_multiple_euqal_incomings(i32 %N) {
; SCCP-LABEL: @loop_with_multiple_euqal_incomings(
; SCCP-NEXT:  entry:
; SCCP-NEXT:    br label [[LOOP:%.*]]
; SCCP:       loop:
; SCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[P_NEXT:%.*]], [[BB3:%.*]] ], [ 0, [[BB4:%.*]] ], [ 0, [[BB5:%.*]] ], [ 0, [[BB6:%.*]] ]
; SCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[BB2:%.*]]
; SCCP:       bb1:
; SCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_2]], label [[BB3]], label [[BB4]]
; SCCP:       bb2:
; SCCP-NEXT:    [[C_4:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_4]], label [[BB5]], label [[BB6]]
; SCCP:       bb3:
; SCCP-NEXT:    [[P_NEXT]] = add i32 [[P]], 1
; SCCP-NEXT:    br label [[LOOP]]
; SCCP:       bb4:
; SCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; SCCP-NEXT:    br i1 [[C_3]], label [[LOOP]], label [[END:%.*]]
; SCCP:       bb5:
; SCCP-NEXT:    br label [[LOOP]]
; SCCP:       bb6:
; SCCP-NEXT:    br label [[LOOP]]
; SCCP:       end:
; SCCP-NEXT:    ret i32 [[P]]
;
; IPSCCP-LABEL: @loop_with_multiple_euqal_incomings(
; IPSCCP-NEXT:  entry:
; IPSCCP-NEXT:    br label [[LOOP:%.*]]
; IPSCCP:       loop:
; IPSCCP-NEXT:    [[P:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[P_NEXT:%.*]], [[BB3:%.*]] ], [ 0, [[BB4:%.*]] ], [ 0, [[BB5:%.*]] ], [ 0, [[BB6:%.*]] ]
; IPSCCP-NEXT:    [[C_1:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[BB2:%.*]]
; IPSCCP:       bb1:
; IPSCCP-NEXT:    [[C_2:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_2]], label [[BB3]], label [[BB4]]
; IPSCCP:       bb2:
; IPSCCP-NEXT:    [[C_4:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_4]], label [[BB5]], label [[BB6]]
; IPSCCP:       bb3:
; IPSCCP-NEXT:    [[P_NEXT]] = add i32 [[P]], 1
; IPSCCP-NEXT:    br label [[LOOP]]
; IPSCCP:       bb4:
; IPSCCP-NEXT:    [[C_3:%.*]] = call i1 @cond()
; IPSCCP-NEXT:    br i1 [[C_3]], label [[LOOP]], label [[END:%.*]]
; IPSCCP:       bb5:
; IPSCCP-NEXT:    br label [[LOOP]]
; IPSCCP:       bb6:
; IPSCCP-NEXT:    br label [[LOOP]]
; IPSCCP:       end:
; IPSCCP-NEXT:    ret i32 [[P]]
;
entry:
  br label %loop

loop:
  %p = phi i32 [ 0, %entry ], [ %p.next, %bb3 ], [ 0, %bb4 ], [ 0, %bb5], [ 0, %bb6 ]
  %c.1 = call i1 @cond()
  br i1 %c.1, label %bb1, label %bb2

bb1:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %bb3, label %bb4

bb2:
  %c.4 = call i1 @cond()
  br i1 %c.4, label %bb5, label %bb6

bb3:
  %p.next = add i32 %p, 1
  br label %loop

bb4:
  %c.3 = call i1 @cond()
  br i1 %c.3, label %loop, label %end

bb5:
  br label %loop

bb6:
  br label %loop

end:
  ret i32 %p
}
