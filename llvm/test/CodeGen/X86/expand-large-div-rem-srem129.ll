; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-- -expand-large-div-rem -expand-div-rem-bits 128 < %s | FileCheck %s

define void @test(ptr %ptr, ptr %out) nounwind {
; CHECK-LABEL: @test(
; CHECK-NEXT:  _udiv-special-cases:
; CHECK-NEXT:    [[A:%.*]] = load i129, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i129 [[A]]
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i129 3
; CHECK-NEXT:    [[TMP2:%.*]] = ashr i129 [[TMP0]], 128
; CHECK-NEXT:    [[TMP3:%.*]] = ashr i129 [[TMP1]], 128
; CHECK-NEXT:    [[TMP4:%.*]] = xor i129 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = xor i129 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = sub i129 [[TMP4]], [[TMP2]]
; CHECK-NEXT:    [[TMP7:%.*]] = sub i129 [[TMP5]], [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = freeze i129 [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = freeze i129 [[TMP7]]
; CHECK-NEXT:    [[TMP10:%.*]] = freeze i129 [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = freeze i129 [[TMP8]]
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i129 [[TMP10]], 0
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i129 [[TMP11]], 0
; CHECK-NEXT:    [[TMP14:%.*]] = or i1 [[TMP12]], [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = call i129 @llvm.ctlz.i129(i129 [[TMP10]], i1 true)
; CHECK-NEXT:    [[TMP16:%.*]] = call i129 @llvm.ctlz.i129(i129 [[TMP11]], i1 true)
; CHECK-NEXT:    [[TMP17:%.*]] = sub i129 [[TMP15]], [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = icmp ugt i129 [[TMP17]], 128
; CHECK-NEXT:    [[TMP19:%.*]] = select i1 [[TMP14]], i1 true, i1 [[TMP18]]
; CHECK-NEXT:    [[TMP20:%.*]] = icmp eq i129 [[TMP17]], 128
; CHECK-NEXT:    [[TMP21:%.*]] = select i1 [[TMP19]], i129 0, i129 [[TMP11]]
; CHECK-NEXT:    [[TMP22:%.*]] = select i1 [[TMP19]], i1 true, i1 [[TMP20]]
; CHECK-NEXT:    br i1 [[TMP22]], label [[UDIV_END:%.*]], label [[UDIV_BB1:%.*]]
; CHECK:       udiv-loop-exit:
; CHECK-NEXT:    [[TMP23:%.*]] = phi i129 [ 0, [[UDIV_BB1]] ], [ [[TMP38:%.*]], [[UDIV_DO_WHILE:%.*]] ]
; CHECK-NEXT:    [[TMP24:%.*]] = phi i129 [ [[TMP47:%.*]], [[UDIV_BB1]] ], [ [[TMP35:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP25:%.*]] = shl i129 [[TMP24]], 1
; CHECK-NEXT:    [[TMP26:%.*]] = or i129 [[TMP23]], [[TMP25]]
; CHECK-NEXT:    br label [[UDIV_END]]
; CHECK:       udiv-do-while:
; CHECK-NEXT:    [[TMP27:%.*]] = phi i129 [ 0, [[UDIV_PREHEADER:%.*]] ], [ [[TMP38]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP28:%.*]] = phi i129 [ [[TMP45:%.*]], [[UDIV_PREHEADER]] ], [ [[TMP41:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP29:%.*]] = phi i129 [ [[TMP43:%.*]], [[UDIV_PREHEADER]] ], [ [[TMP40:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP30:%.*]] = phi i129 [ [[TMP47]], [[UDIV_PREHEADER]] ], [ [[TMP35]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP31:%.*]] = shl i129 [[TMP29]], 1
; CHECK-NEXT:    [[TMP32:%.*]] = lshr i129 [[TMP30]], 128
; CHECK-NEXT:    [[TMP33:%.*]] = or i129 [[TMP31]], [[TMP32]]
; CHECK-NEXT:    [[TMP34:%.*]] = shl i129 [[TMP30]], 1
; CHECK-NEXT:    [[TMP35]] = or i129 [[TMP27]], [[TMP34]]
; CHECK-NEXT:    [[TMP36:%.*]] = sub i129 [[TMP44:%.*]], [[TMP33]]
; CHECK-NEXT:    [[TMP37:%.*]] = ashr i129 [[TMP36]], 128
; CHECK-NEXT:    [[TMP38]] = and i129 [[TMP37]], 1
; CHECK-NEXT:    [[TMP39:%.*]] = and i129 [[TMP37]], [[TMP10]]
; CHECK-NEXT:    [[TMP40]] = sub i129 [[TMP33]], [[TMP39]]
; CHECK-NEXT:    [[TMP41]] = add i129 [[TMP28]], -1
; CHECK-NEXT:    [[TMP42:%.*]] = icmp eq i129 [[TMP41]], 0
; CHECK-NEXT:    br i1 [[TMP42]], label [[UDIV_LOOP_EXIT:%.*]], label [[UDIV_DO_WHILE]]
; CHECK:       udiv-preheader:
; CHECK-NEXT:    [[TMP43]] = lshr i129 [[TMP11]], [[TMP45]]
; CHECK-NEXT:    [[TMP44]] = add i129 [[TMP10]], -1
; CHECK-NEXT:    br label [[UDIV_DO_WHILE]]
; CHECK:       udiv-bb1:
; CHECK-NEXT:    [[TMP45]] = add i129 [[TMP17]], 1
; CHECK-NEXT:    [[TMP46:%.*]] = sub i129 128, [[TMP17]]
; CHECK-NEXT:    [[TMP47]] = shl i129 [[TMP11]], [[TMP46]]
; CHECK-NEXT:    [[TMP48:%.*]] = icmp eq i129 [[TMP45]], 0
; CHECK-NEXT:    br i1 [[TMP48]], label [[UDIV_LOOP_EXIT]], label [[UDIV_PREHEADER]]
; CHECK:       udiv-end:
; CHECK-NEXT:    [[TMP49:%.*]] = phi i129 [ [[TMP26]], [[UDIV_LOOP_EXIT]] ], [ [[TMP21]], [[_UDIV_SPECIAL_CASES:%.*]] ]
; CHECK-NEXT:    [[TMP50:%.*]] = mul i129 [[TMP9]], [[TMP49]]
; CHECK-NEXT:    [[TMP51:%.*]] = sub i129 [[TMP8]], [[TMP50]]
; CHECK-NEXT:    [[TMP52:%.*]] = xor i129 [[TMP51]], [[TMP2]]
; CHECK-NEXT:    [[TMP53:%.*]] = sub i129 [[TMP52]], [[TMP2]]
; CHECK-NEXT:    store i129 [[TMP53]], ptr [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %a = load i129, ptr %ptr
  %res = srem i129 %a, 3
  store i129 %res, ptr %out
  ret void
}
