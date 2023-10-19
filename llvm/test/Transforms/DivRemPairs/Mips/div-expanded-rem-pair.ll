; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=div-rem-pairs -S -mtriple=mips-unknown-unknown | FileCheck %s

declare void @foo(i32, i32)

define void @decompose_illegal_srem_same_block(i32 %a, i32 %b) {
; CHECK-LABEL: @decompose_illegal_srem_same_block(
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[T0:%.*]] = mul i32 [[DIV]], [[B]]
; CHECK-NEXT:    [[REM_RECOMPOSED:%.*]] = srem i32 [[A]], [[B]]
; CHECK-NEXT:    call void @foo(i32 [[REM_RECOMPOSED]], i32 [[DIV]])
; CHECK-NEXT:    ret void
;
  %div = sdiv i32 %a, %b
  %t0 = mul i32 %div, %b
  %rem = sub i32 %a, %t0
  call void @foo(i32 %rem, i32 %div)
  ret void
}

define void @decompose_illegal_urem_same_block(i32 %a, i32 %b) {
; CHECK-LABEL: @decompose_illegal_urem_same_block(
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[T0:%.*]] = mul i32 [[DIV]], [[B]]
; CHECK-NEXT:    [[REM_RECOMPOSED:%.*]] = urem i32 [[A]], [[B]]
; CHECK-NEXT:    call void @foo(i32 [[REM_RECOMPOSED]], i32 [[DIV]])
; CHECK-NEXT:    ret void
;
  %div = udiv i32 %a, %b
  %t0 = mul i32 %div, %b
  %rem = sub i32 %a, %t0
  call void @foo(i32 %rem, i32 %div)
  ret void
}

; Recompose and hoist the srem if it's safe and free, otherwise keep as-is..

define i16 @hoist_srem(i16 %a, i16 %b) {
; CHECK-LABEL: @hoist_srem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i16 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[DIV]], 42
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[T0:%.*]] = mul i16 [[DIV]], [[B]]
; CHECK-NEXT:    [[REM:%.*]] = sub i16 [[A]], [[T0]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i16 [ [[REM]], [[IF]] ], [ 3, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i16 [[RET]]
;
entry:
  %div = sdiv i16 %a, %b
  %cmp = icmp eq i16 %div, 42
  br i1 %cmp, label %if, label %end

if:
  %t0 = mul i16 %div, %b
  %rem = sub i16 %a, %t0
  br label %end

end:
  %ret = phi i16 [ %rem, %if ], [ 3, %entry ]
  ret i16 %ret
}

; Recompose and hoist the urem if it's safe and free, otherwise keep as-is..

define i8 @hoist_urem(i8 %a, i8 %b) {
; CHECK-LABEL: @hoist_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = udiv i8 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[DIV]], 42
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[T0:%.*]] = mul i8 [[DIV]], [[B]]
; CHECK-NEXT:    [[REM:%.*]] = sub i8 [[A]], [[T0]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i8 [ [[REM]], [[IF]] ], [ 3, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i8 [[RET]]
;
entry:
  %div = udiv i8 %a, %b
  %cmp = icmp eq i8 %div, 42
  br i1 %cmp, label %if, label %end

if:
  %t0 = mul i8 %div, %b
  %rem = sub i8 %a, %t0
  br label %end

end:
  %ret = phi i8 [ %rem, %if ], [ 3, %entry ]
  ret i8 %ret
}

; Be careful with RAUW/invalidation if this is a srem-of-srem.

define i32 @srem_of_srem_unexpanded(i32 %X, i32 %Y, i32 %Z) {
; CHECK-LABEL: @srem_of_srem_unexpanded(
; CHECK-NEXT:    [[T0:%.*]] = mul nsw i32 [[Z:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = sdiv i32 [[X:%.*]], [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = mul nsw i32 [[T0]], [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = srem i32 [[X]], [[T0]]
; CHECK-NEXT:    [[T4:%.*]] = sdiv i32 [[T3]], [[Y]]
; CHECK-NEXT:    [[T5:%.*]] = mul nsw i32 [[T4]], [[Y]]
; CHECK-NEXT:    [[T6:%.*]] = srem i32 [[T3]], [[Y]]
; CHECK-NEXT:    ret i32 [[T6]]
;
  %t0 = mul nsw i32 %Z, %Y
  %t1 = sdiv i32 %X, %t0
  %t2 = mul nsw i32 %t0, %t1
  %t3 = srem i32 %X, %t0
  %t4 = sdiv i32 %t3, %Y
  %t5 = mul nsw i32 %t4, %Y
  %t6 = srem i32 %t3, %Y
  ret i32 %t6
}
define i32 @srem_of_srem_expanded(i32 %X, i32 %Y, i32 %Z) {
; CHECK-LABEL: @srem_of_srem_expanded(
; CHECK-NEXT:    [[T0:%.*]] = mul nsw i32 [[Z:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = sdiv i32 [[X:%.*]], [[T0]]
; CHECK-NEXT:    [[T2:%.*]] = mul nsw i32 [[T0]], [[T1]]
; CHECK-NEXT:    [[T3_RECOMPOSED:%.*]] = srem i32 [[X]], [[T0]]
; CHECK-NEXT:    [[T4:%.*]] = sdiv i32 [[T3_RECOMPOSED]], [[Y]]
; CHECK-NEXT:    [[T5:%.*]] = mul nsw i32 [[T4]], [[Y]]
; CHECK-NEXT:    [[T6_RECOMPOSED:%.*]] = srem i32 [[T3_RECOMPOSED]], [[Y]]
; CHECK-NEXT:    ret i32 [[T6_RECOMPOSED]]
;
  %t0 = mul nsw i32 %Z, %Y
  %t1 = sdiv i32 %X, %t0
  %t2 = mul nsw i32 %t0, %t1
  %t3 = sub nsw i32 %X, %t2
  %t4 = sdiv i32 %t3, %Y
  %t5 = mul nsw i32 %t4, %Y
  %t6 = sub nsw i32 %t3, %t5
  ret i32 %t6
}

; If the target doesn't have a unified div/rem op for the type, keep decomposed rem

define i128 @dont_hoist_urem(i128 %a, i128 %b) {
; CHECK-LABEL: @dont_hoist_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = udiv i128 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i128 [[DIV]], 42
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[T0:%.*]] = mul i128 [[DIV]], [[B]]
; CHECK-NEXT:    [[REM:%.*]] = sub i128 [[A]], [[T0]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i128 [ [[REM]], [[IF]] ], [ 3, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i128 [[RET]]
;
entry:
  %div = udiv i128 %a, %b
  %cmp = icmp eq i128 %div, 42
  br i1 %cmp, label %if, label %end

if:
  %t0 = mul i128 %div, %b
  %rem = sub i128 %a, %t0
  br label %end

end:
  %ret = phi i128 [ %rem, %if ], [ 3, %entry ]
  ret i128 %ret
}
