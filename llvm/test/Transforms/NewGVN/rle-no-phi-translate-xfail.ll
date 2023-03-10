; RUN: opt < %s -passes=newgvn -S | FileCheck %s
; XFAIL: *
; FIXME: This should be promotable, but memdep/gvn don't track values
; path/edge sensitively enough.

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"
target triple = "i386-apple-darwin7"

define i32 @g(ptr %b, ptr %c) nounwind {
entry:
        store i32 1, ptr %b
        store i32 2, ptr %c
        
	%t1 = icmp eq ptr %b, null		; <i1> [#uses=1]
	br i1 %t1, label %bb, label %bb2

bb:		; preds = %entry
	br label %bb2

bb2:		; preds = %bb1, %bb
	%c_addr.0 = phi ptr [ %b, %entry ], [ %c, %bb ]		; <ptr> [#uses=1]
	%cv = load i32, ptr %c_addr.0, align 4		; <i32> [#uses=1]
	ret i32 %cv
; CHECK: bb2:
; CHECK-NOT: load i32
; CHECK: ret i32 
}

