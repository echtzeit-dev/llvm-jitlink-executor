; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S < %s -mtriple=unknown -passes=instcombine -instcombine-infinite-loop-threshold=2 | FileCheck -check-prefixes=CHECK,CHECK32 %s
; RUN: opt -S < %s -mtriple=msp430 -passes=instcombine -instcombine-infinite-loop-threshold=2 | FileCheck -check-prefixes=CHECK,CHECK16 %s
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-f80:128:128-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S32"

@G = constant [3 x i8] c"%s\00"		; <ptr> [#uses=1]

; A 32-bit compatible sprintf is not recognized as the standard library
; function on 16-bit targets.
declare i32 @sprintf(ptr, ptr, ...)

define void @foo(ptr %P, ptr %X) {
; CHECK32-LABEL: @foo(
; CHECK32-NEXT:    [[STRCPY:%.*]] = call ptr @strcpy(ptr noundef nonnull dereferenceable(1) [[P:%.*]], ptr noundef nonnull dereferenceable(1) [[X:%.*]])
; CHECK32-NEXT:    ret void
;
; CHECK16-LABEL: @foo(
; CHECK16-NEXT:    [[TMP1:%.*]] = call i32 (ptr, ptr, ...) @sprintf(ptr [[P:%.*]], ptr nonnull @G, ptr [[X:%.*]])
; CHECK16-NEXT:    ret void
;
  call i32 (ptr, ptr, ...) @sprintf( ptr %P, ptr @G, ptr %X )		; <i32>:1 [#uses=0]
  ret void
}

; PR1307
@str = internal constant [5 x i8] c"foog\00"
@str1 = internal constant [8 x i8] c"blahhh!\00"
@str2 = internal constant [5 x i8] c"Ponk\00"

define ptr @test1() {
; CHECK32-LABEL: @test1(
; CHECK32-NEXT:    ret ptr getelementptr inbounds ([5 x i8], ptr @str, i32 0, i32 3)
;
; CHECK16-LABEL: @test1(
; CHECK16-NEXT:    [[TMP3:%.*]] = tail call ptr @strchr(ptr nonnull getelementptr inbounds ([5 x i8], ptr @str, i32 0, i32 2), i32 103)
; CHECK16-NEXT:    ret ptr [[TMP3]]
;
  %tmp3 = tail call ptr @strchr( ptr getelementptr ([5 x i8], ptr @str, i32 0, i32 2), i32 103 )              ; <ptr> [#uses=1]
  ret ptr %tmp3
}

; A 32-bit compatible strchr is not recognized as the standard library
; function on 16-bit targets.
declare ptr @strchr(ptr, i32)

define ptr @test2() {
; CHECK32-LABEL: @test2(
; CHECK32-NEXT:    ret ptr getelementptr inbounds ([8 x i8], ptr @str1, i32 0, i32 7)
;
; CHECK16-LABEL: @test2(
; CHECK16-NEXT:    [[TMP3:%.*]] = tail call ptr @strchr(ptr nonnull getelementptr inbounds ([8 x i8], ptr @str1, i32 0, i32 2), i32 0)
; CHECK16-NEXT:    ret ptr [[TMP3]]
;
  %tmp3 = tail call ptr @strchr( ptr getelementptr ([8 x i8], ptr @str1, i32 0, i32 2), i32 0 )               ; <ptr> [#uses=1]
  ret ptr %tmp3
}

define ptr @test3() {
; CHECK32-LABEL: @test3(
; CHECK32-NEXT:  entry:
; CHECK32-NEXT:    ret ptr null
;
; CHECK16-LABEL: @test3(
; CHECK16-NEXT:  entry:
; CHECK16-NEXT:    [[TMP3:%.*]] = tail call ptr @strchr(ptr nonnull getelementptr inbounds ([5 x i8], ptr @str2, i32 0, i32 1), i32 80)
; CHECK16-NEXT:    ret ptr [[TMP3]]
;
entry:
  %tmp3 = tail call ptr @strchr( ptr getelementptr ([5 x i8], ptr @str2, i32 0, i32 1), i32 80 )              ; <ptr> [#uses=1]
  ret ptr %tmp3

}

@_2E_str = external constant [5 x i8]		; <ptr> [#uses=1]

; A 32-bit compatible memcmp is not recognized as the standard library
; function on 16-bit targets.
declare i32 @memcmp(ptr, ptr, i32) nounwind readonly

define i1 @PR2341(ptr %start_addr) {
; CHECK32-LABEL: @PR2341(
; CHECK32-NEXT:  entry:
; CHECK32-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[START_ADDR:%.*]], align 4
; CHECK32-NEXT:    [[TMP5:%.*]] = call i32 @memcmp(ptr noundef nonnull dereferenceable(4) [[TMP4]], ptr noundef nonnull dereferenceable(4) @_2E_str, i32 4) #[[ATTR0:[0-9]+]]
; CHECK32-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[TMP5]], 0
; CHECK32-NEXT:    ret i1 [[TMP6]]
;
; CHECK16-LABEL: @PR2341(
; CHECK16-NEXT:  entry:
; CHECK16-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[START_ADDR:%.*]], align 4
; CHECK16-NEXT:    [[TMP5:%.*]] = call i32 @memcmp(ptr [[TMP4]], ptr nonnull @_2E_str, i32 4) #[[ATTR0:[0-9]+]]
; CHECK16-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[TMP5]], 0
; CHECK16-NEXT:    ret i1 [[TMP6]]
;
entry:
  %tmp4 = load ptr, ptr %start_addr, align 4		; <ptr> [#uses=1]
  %tmp5 = call i32 @memcmp( ptr %tmp4, ptr @_2E_str, i32 4 ) nounwind readonly 		; <i32> [#uses=1]
  %tmp6 = icmp eq i32 %tmp5, 0		; <i1> [#uses=1]
  ret i1 %tmp6

}

define i32 @PR4284() nounwind {
; CHECK32-LABEL: @PR4284(
; CHECK32-NEXT:  entry:
; CHECK32-NEXT:    ret i32 -65
;
; CHECK16-LABEL: @PR4284(
; CHECK16-NEXT:  entry:
; CHECK16-NEXT:    [[C0:%.*]] = alloca i8, align 1
; CHECK16-NEXT:    [[C2:%.*]] = alloca i8, align 1
; CHECK16-NEXT:    store i8 64, ptr [[C0]], align 1
; CHECK16-NEXT:    store i8 -127, ptr [[C2]], align 1
; CHECK16-NEXT:    [[CALL:%.*]] = call i32 @memcmp(ptr nonnull [[C0]], ptr nonnull [[C2]], i32 1)
; CHECK16-NEXT:    ret i32 [[CALL]]
;
entry:
  %c0 = alloca i8, align 1		; <ptr> [#uses=2]
  %c2 = alloca i8, align 1		; <ptr> [#uses=2]
  store i8 64, ptr %c0
  store i8 -127, ptr %c2
  %call = call i32 @memcmp(ptr %c0, ptr %c2, i32 1)		; <i32> [#uses=1]
  ret i32 %call

}

%struct.__sFILE = type { ptr, i32, i32, i16, i16, %struct.__sbuf, i32, ptr, ptr, ptr, ptr, ptr, %struct.__sbuf, ptr, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64, ptr, ptr, i32, i32, %union.anon }
%struct.__sbuf = type { ptr, i32, [4 x i8] }
%struct.pthread = type opaque
%struct.pthread_mutex = type opaque
%union.anon = type { i64, [120 x i8] }
@.str13 = external constant [2 x i8]		; <ptr> [#uses=1]
@.str14 = external constant [2 x i8]		; <ptr> [#uses=1]

define i32 @PR4641(i32 %argc, ptr %argv, i1 %c1, ptr %ptr) nounwind {
; CHECK-LABEL: @PR4641(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @exit(i32 0) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    [[COND392:%.*]] = select i1 [[C1:%.*]], ptr @.str13, ptr @.str14
; CHECK-NEXT:    [[CALL393:%.*]] = call ptr @fopen(ptr [[PTR:%.*]], ptr nonnull [[COND392]]) #[[ATTR1]]
; CHECK-NEXT:    unreachable
;
entry:
  call void @exit(i32 0) nounwind
  %cond392 = select i1 %c1, ptr @.str13, ptr @.str14		; <ptr> [#uses=1]
  %call393 = call ptr @fopen(ptr %ptr, ptr %cond392) nounwind		; <ptr> [#uses=0]
  unreachable
}

declare ptr @fopen(ptr, ptr)

; A 32-bit compatible exit is not recognized as the standard library
; function on 16-bit targets.
declare void @exit(i32)

define i32 @PR4645(i1 %c1) {
; CHECK-LABEL: @PR4645(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[IF_THEN:%.*]]
; CHECK:       lor.lhs.false:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[IF_THEN]], label [[FOR_COND:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @exit(i32 1)
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.cond:
; CHECK-NEXT:    unreachable
; CHECK:       for.end:
; CHECK-NEXT:    br label [[FOR_COND]]
;
entry:
  br label %if.then

lor.lhs.false:		; preds = %while.body
  br i1 %c1, label %if.then, label %for.cond

if.then:		; preds = %lor.lhs.false, %while.body
  call void @exit(i32 1)
  br label %for.cond

for.cond:		; preds = %for.end, %if.then, %lor.lhs.false
  %j.0 = phi i32 [ %inc47, %for.end ], [ 0, %if.then ], [ 0, %lor.lhs.false ]		; <i32> [#uses=1]
  unreachable

for.end:		; preds = %for.cond20
  %inc47 = add i32 %j.0, 1		; <i32> [#uses=1]
  br label %for.cond
}

@h = constant [2 x i8] c"h\00"		; <ptr> [#uses=1]
@hel = constant [4 x i8] c"hel\00"		; <ptr> [#uses=1]
@hello_u = constant [8 x i8] c"hello_u\00"		; <ptr> [#uses=1]

define i32 @MemCpy() {
; CHECK-LABEL: @MemCpy(
; CHECK-NEXT:    ret i32 0
;
  %target = alloca [1024 x i8]
  call void @llvm.memcpy.p0.p0.i32(ptr align 2 %target, ptr align 2 @h, i32 2, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 4 %target, ptr align 4 @hel, i32 4, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 8 %target, ptr align 8 @hello_u, i32 8, i1 false)
  ret i32 0

}

declare void @llvm.memcpy.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind

; A 32-bit compatible strcmp is not recognized as the standard library
; function on 16-bit targets.
declare i32 @strcmp(ptr, ptr) #0

define void @test9(ptr %x) {
; CHECK32-LABEL: @test9(
; CHECK32-NEXT:    ret void
;
; CHECK16-LABEL: @test9(
; CHECK16-NEXT:    [[Y:%.*]] = call i32 @strcmp(ptr [[X:%.*]], ptr [[X]]) #[[ATTR6:[0-9]+]]
; CHECK16-NEXT:    ret void
;
  %y = call i32 @strcmp(ptr %x, ptr %x) #1
  ret void
}

; PR30484 - https://llvm.org/bugs/show_bug.cgi?id=30484
; These aren't the library functions you're looking for...

declare i32 @isdigit(i8)
declare i32 @isascii(i8)
declare i32 @toascii(i8)

define i32 @fake_isdigit(i8 %x) {
; CHECK-LABEL: @fake_isdigit(
; CHECK-NEXT:    [[Y:%.*]] = call i32 @isdigit(i8 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[Y]]
;
  %y = call i32 @isdigit(i8 %x)
  ret i32 %y
}

define i32 @fake_isascii(i8 %x) {
; CHECK-LABEL: @fake_isascii(
; CHECK-NEXT:    [[Y:%.*]] = call i32 @isascii(i8 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[Y]]
;
  %y = call i32 @isascii(i8 %x)
  ret i32 %y
}

define i32 @fake_toascii(i8 %x) {
; CHECK-LABEL: @fake_toascii(
; CHECK-NEXT:    [[Y:%.*]] = call i32 @toascii(i8 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[Y]]
;
  %y = call i32 @toascii(i8 %x)
  ret i32 %y
}

declare double @pow(double, double)
declare double @exp2(double)

; check to make sure only the correct libcall attributes are used
define double @fake_exp2(double %x) {
; CHECK-LABEL: @fake_exp2(
; CHECK-NEXT:    [[EXP2:%.*]] = call double @exp2(double [[X:%.*]])
; CHECK-NEXT:    ret double [[EXP2]]
;

  %y = call inreg double @pow(double inreg 2.0, double inreg %x)
  ret double %y
}
define double @fake_ldexp(i32 %x) {
; CHECK32-LABEL: @fake_ldexp(
; CHECK32-NEXT:    [[LDEXP:%.*]] = call double @ldexp(double 1.000000e+00, i32 [[X:%.*]])
; CHECK32-NEXT:    ret double [[LDEXP]]
;
; CHECK16-LABEL: @fake_ldexp(
; CHECK16-NEXT:    [[Y:%.*]] = sitofp i32 [[X:%.*]] to double
; CHECK16-NEXT:    [[Z:%.*]] = call inreg double @exp2(double [[Y]])
; CHECK16-NEXT:    ret double [[Z]]
;


  %y = sitofp i32 %x to double
  %z = call inreg double @exp2(double %y)
  ret double %z
}
define double @fake_ldexp_16(i16 %x) {
; CHECK32-LABEL: @fake_ldexp_16(
; CHECK32-NEXT:    [[TMP1:%.*]] = sext i16 [[X:%.*]] to i32
; CHECK32-NEXT:    [[LDEXP:%.*]] = call double @ldexp(double 1.000000e+00, i32 [[TMP1]])
; CHECK32-NEXT:    ret double [[LDEXP]]
;
; CHECK16-LABEL: @fake_ldexp_16(
; CHECK16-NEXT:    [[LDEXP:%.*]] = call double @ldexp(double 1.000000e+00, i16 [[X:%.*]])
; CHECK16-NEXT:    ret double [[LDEXP]]
;


  %y = sitofp i16 %x to double
  %z = call inreg double @exp2(double %y)
  ret double %z
}

; PR50885 - this would crash in ValueTracking.

; A 32-bit compatible snprintf is not recognized as the standard library
; function on 16-bit targets.
declare i32 @snprintf(ptr, double, ptr)

define i32 @fake_snprintf(i32 %buf, double %len, ptr %str, ptr %ptr) {
; CHECK-LABEL: @fake_snprintf(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @snprintf(ptr [[PTR:%.*]], double [[LEN:%.*]], ptr [[STR:%.*]])
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @snprintf(ptr %ptr, double %len, ptr %str)
  ret i32 %call
}

; Wrong return type for the real strlen.
; https://llvm.org/PR50836

define i4 @strlen(ptr %s) {
; CHECK-LABEL: @strlen(
; CHECK-NEXT:    [[R:%.*]] = call i4 @strlen(ptr [[S:%.*]])
; CHECK-NEXT:    ret i4 0
;
  %r = call i4 @strlen(ptr %s)
  ret i4 0
}

; Test emission of stpncpy.
@a = dso_local global [4 x i8] c"123\00"
@b = dso_local global [5 x i8] zeroinitializer
declare ptr @__stpncpy_chk(ptr noundef, ptr noundef, i32 noundef, i32 noundef)
define signext i32 @emit_stpncpy() {
; CHECK-LABEL: @emit_stpncpy(
; CHECK-NEXT:    [[STPNCPY:%.*]] = call ptr @stpncpy(ptr noundef nonnull dereferenceable(1) @b, ptr noundef nonnull dereferenceable(1) @a, i32 2)
; CHECK-NEXT:    ret i32 0
;
  %call = call ptr @__stpncpy_chk(ptr noundef @b,
  ptr noundef @a,
  i32 noundef 2, i32 noundef 5)
  ret i32 0
}

attributes #0 = { nobuiltin }
attributes #1 = { builtin }
