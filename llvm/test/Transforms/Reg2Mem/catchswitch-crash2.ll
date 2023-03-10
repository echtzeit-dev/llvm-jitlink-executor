; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=reg2mem -S < %s | FileCheck %s
%opaque = type opaque

declare i32 @__CxxFrameHandler3(...)

define void @testreg2mem(ptr %_Val) personality ptr @__CxxFrameHandler3 {
; CHECK-LABEL: @testreg2mem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[_STATE_3_REG2MEM:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[_STATE_3_REG2MEM1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    %"reg2mem alloca point" = bitcast i32 0 to i32
; CHECK-NEXT:    store i32 0, ptr [[_STATE_3_REG2MEM1]], align 4
; CHECK-NEXT:    [[CALL_I166167:%.*]] = invoke noundef i64 @extfunc_i64()
; CHECK-NEXT:    to label [[IF_END56:%.*]] unwind label [[CATCH_DISPATCH:%.*]]
; CHECK:       if.end56:
; CHECK-NEXT:    store i32 1, ptr [[_STATE_3_REG2MEM1]], align 4
; CHECK-NEXT:    invoke void @extfunc()
; CHECK-NEXT:    to label [[INVOKE_CONT75:%.*]] unwind label [[CATCH_DISPATCH]]
; CHECK:       invoke.cont75:
; CHECK-NEXT:    unreachable
; CHECK:       catch.dispatch:
; CHECK-NEXT:    [[TMP0:%.*]] = catchswitch within none [label %catch] unwind label [[EHCLEANUP105:%.*]]
; CHECK:       catch:
; CHECK-NEXT:    [[TMP1:%.*]] = catchpad within [[TMP0]] [ptr null, i32 64, ptr null]
; CHECK-NEXT:    [[_STATE_3_RELOAD2:%.*]] = load i32, ptr [[_STATE_3_REG2MEM1]], align 4
; CHECK-NEXT:    store i32 [[_STATE_3_RELOAD2]], ptr [[_STATE_3_REG2MEM]], align 4
; CHECK-NEXT:    invoke void @extfunc() [ "funclet"(token [[TMP1]]) ]
; CHECK-NEXT:    to label [[INVOKE_CONT98:%.*]] unwind label [[EHCLEANUP105]]
; CHECK:       invoke.cont98:
; CHECK-NEXT:    catchret from [[TMP1]] to label [[IF_END99:%.*]]
; CHECK:       if.end99:
; CHECK-NEXT:    [[_STATE_3_RELOAD:%.*]] = load i32, ptr [[_STATE_3_REG2MEM]], align 4
; CHECK-NEXT:    [[OR_I:%.*]] = or i32 0, [[_STATE_3_RELOAD]]
; CHECK-NEXT:    unreachable
; CHECK:       ehcleanup105:
; CHECK-NEXT:    [[TMP2:%.*]] = cleanuppad within none []
; CHECK-NEXT:    [[_STATE_3_RELOAD3:%.*]] = load i32, ptr [[_STATE_3_REG2MEM1]], align 4
; CHECK-NEXT:    store i32 [[_STATE_3_RELOAD3]], ptr [[_STATE_3_REG2MEM]], align 4
; CHECK-NEXT:    cleanupret from [[TMP2]] unwind to caller
;
entry:
  %call.i166167 = invoke noundef i64 @"extfunc_i64"()
  to label %if.end56 unwind label %catch.dispatch

if.end56:                                         ; preds = %entry
  invoke void @"extfunc"()
  to label %invoke.cont75 unwind label %catch.dispatch

invoke.cont75:                                    ; preds = %if.end56
  unreachable

catch.dispatch:                                   ; preds = %if.end56, %entry
  %_State.3 = phi i32 [ 1, %if.end56 ], [ 0, %entry ]
  %0 = catchswitch within none [label %catch] unwind label %ehcleanup105

catch:                                            ; preds = %catch.dispatch
  %1 = catchpad within %0 [ptr null, i32 64, ptr null]
  invoke void @"extfunc"() [ "funclet"(token %1) ]
  to label %invoke.cont98 unwind label %ehcleanup105

invoke.cont98:                                    ; preds = %catch
  catchret from %1 to label %if.end99

if.end99:                                         ; preds = %invoke.cont98
  %or.i = or i32 0, %_State.3
  unreachable

ehcleanup105:                                     ; preds = %catch, %catch.dispatch
  %2 = cleanuppad within none []
  cleanupret from %2 unwind to caller
}

declare void @"extfunc"()

declare i64 @"extfunc_i64"()
