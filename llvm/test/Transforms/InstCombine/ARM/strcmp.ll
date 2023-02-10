; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the strcmp library call simplifier works correctly.
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

@hello = constant [6 x i8] c"hello\00"
@hell = constant [5 x i8] c"hell\00"
@bell = constant [5 x i8] c"bell\00"
@null = constant [1 x i8] zeroinitializer

declare i32 @strcmp(ptr, ptr)

; strcmp("", x) -> -*x
define arm_aapcscc i32 @test1(ptr %str2) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, ptr [[STR2:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub nsw i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;

  %temp1 = call arm_apcscc i32 @strcmp(ptr @null, ptr %str2)
  ret i32 %temp1

}

; strcmp(x, "") -> *x
define arm_aapcscc i32 @test2(ptr %str1) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, ptr [[STR1:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;

  %temp1 = call arm_aapcscc i32 @strcmp(ptr %str1, ptr @null)
  ret i32 %temp1
}

; strcmp(x, y)  -> cnst
define arm_aapcscc i32 @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    ret i32 -1
;

  %temp1 = call arm_aapcscc i32 @strcmp(ptr @hell, ptr @hello)
  ret i32 %temp1
}

define arm_aapcscc i32 @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    ret i32 1
;

  %temp1 = call arm_aapcscc i32 @strcmp(ptr @hell, ptr @null)
  ret i32 %temp1
}

; strcmp(x, y)   -> memcmp(x, y, <known length>)
; (This transform is rather difficult to trigger in a useful manner)
define arm_aapcscc i32 @test5(i1 %b) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[STR2:%.*]] = select i1 [[B:%.*]], ptr @hell, ptr @bell
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr noundef nonnull dereferenceable(5) @hello, ptr noundef nonnull dereferenceable(5) [[STR2]], i32 5)
; CHECK-NEXT:    ret i32 [[MEMCMP]]
;

  %str2 = select i1 %b, ptr @hell, ptr @bell
  %temp3 = call arm_aapcscc i32 @strcmp(ptr @hello, ptr %str2)
  ret i32 %temp3
}

; strcmp(x,x)  -> 0
define arm_aapcscc i32 @test6(ptr %str) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret i32 0
;

  %temp1 = call arm_aapcscc i32 @strcmp(ptr %str, ptr %str)
  ret i32 %temp1
}

; strcmp("", x) -> -*x
define arm_aapcs_vfpcc i32 @test1_vfp(ptr %str2) {
; CHECK-LABEL: @test1_vfp(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, ptr [[STR2:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub nsw i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(ptr @null, ptr %str2)
  ret i32 %temp1

}

; strcmp(x, "") -> *x
define arm_aapcs_vfpcc i32 @test2_vfp(ptr %str1) {
; CHECK-LABEL: @test2_vfp(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, ptr [[STR1:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(ptr %str1, ptr @null)
  ret i32 %temp1
}

; strcmp(x, y)  -> cnst
define arm_aapcs_vfpcc i32 @test3_vfp() {
; CHECK-LABEL: @test3_vfp(
; CHECK-NEXT:    ret i32 -1
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(ptr @hell, ptr @hello)
  ret i32 %temp1
}

define arm_aapcs_vfpcc i32 @test4_vfp() {
; CHECK-LABEL: @test4_vfp(
; CHECK-NEXT:    ret i32 1
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(ptr @hell, ptr @null)
  ret i32 %temp1
}

; strcmp(x, y)   -> memcmp(x, y, <known length>)
; (This transform is rather difficult to trigger in a useful manner)
define arm_aapcs_vfpcc i32 @test5_vfp(i1 %b) {
; CHECK-LABEL: @test5_vfp(
; CHECK-NEXT:    [[STR2:%.*]] = select i1 [[B:%.*]], ptr @hell, ptr @bell
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr noundef nonnull dereferenceable(5) @hello, ptr noundef nonnull dereferenceable(5) [[STR2]], i32 5)
; CHECK-NEXT:    ret i32 [[MEMCMP]]
;

  %str2 = select i1 %b, ptr @hell, ptr @bell
  %temp3 = call arm_aapcs_vfpcc i32 @strcmp(ptr @hello, ptr %str2)
  ret i32 %temp3
}

; strcmp(x,x)  -> 0
define arm_aapcs_vfpcc i32 @test6_vfp(ptr %str) {
; CHECK-LABEL: @test6_vfp(
; CHECK-NEXT:    ret i32 0
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(ptr %str, ptr %str)
  ret i32 %temp1
}
