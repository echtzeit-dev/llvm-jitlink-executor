; RUN: opt < %s -passes=gvn
; PR2032

define i32 @sscal(i32 %n, double %sa1, ptr %sx, i32 %incx) {
entry:
	%sx_addr = alloca ptr		; <ptr> [#uses=3]
	store ptr %sx, ptr %sx_addr, align 4
	br label %bb33

bb:		; preds = %bb33
	%tmp27 = load ptr, ptr %sx_addr, align 4		; <ptr> [#uses=1]
	store float 0.000000e+00, ptr %tmp27, align 4
	store ptr null, ptr %sx_addr, align 4
	br label %bb33

bb33:		; preds = %bb, %entry
	br i1 false, label %bb, label %return

return:		; preds = %bb33
	%retval59 = load i32, ptr null, align 4		; <i32> [#uses=1]
	ret i32 %retval59
}
