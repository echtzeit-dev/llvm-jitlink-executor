; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc i16 @reduce_v16i16_shift_mul(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: reduce_v16i16_shift_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullt.u8 q2, q0, q1
; CHECK-NEXT:    vmullb.u8 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q2, q2, #14
; CHECK-NEXT:    vshr.s16 q0, q0, #14
; CHECK-NEXT:    vaddv.u16 r0, q2
; CHECK-NEXT:    vaddva.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i16>
  %s1s = zext <16 x i8> %s1 to <16 x i16>
  %m = mul <16 x i16> %s0s, %s1s
  %sh = ashr <16 x i16> %m, <i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14>
  %result = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %sh)
  ret i16 %result
}

define arm_aapcs_vfpcc i16 @reduce_v8i16_shift_mul(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: reduce_v8i16_shift_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.u8 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #14
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <8 x i8> %s0 to <8 x i16>
  %s1s = zext <8 x i8> %s1 to <8 x i16>
  %m = mul <8 x i16> %s0s, %s1s
  %sh = ashr <8 x i16> %m, <i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14>
  %result = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %sh)
  ret i16 %result
}

define arm_aapcs_vfpcc i16 @reduce_v16i16_shift_sub(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: reduce_v16i16_shift_sub:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlt.u8 q2, q1
; CHECK-NEXT:    vmovlt.u8 q3, q0
; CHECK-NEXT:    vsub.i16 q2, q3, q2
; CHECK-NEXT:    vmovlb.u8 q1, q1
; CHECK-NEXT:    vmovlb.u8 q0, q0
; CHECK-NEXT:    vshr.s16 q2, q2, #14
; CHECK-NEXT:    vsub.i16 q0, q0, q1
; CHECK-NEXT:    vaddv.u16 r0, q2
; CHECK-NEXT:    vshr.s16 q0, q0, #14
; CHECK-NEXT:    vaddva.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i16>
  %s1s = zext <16 x i8> %s1 to <16 x i16>
  %m = sub <16 x i16> %s0s, %s1s
  %sh = ashr <16 x i16> %m, <i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14, i16 14>
  %result = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %sh)
  ret i16 %result
}

define arm_aapcs_vfpcc i32 @mlapred_v4i32_v4i64_zext(<8 x i16> %x, <8 x i16> %y, <8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: mlapred_v4i32_v4i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    vorr q2, q2, q3
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vstrw.32 q2, [r0]
; CHECK-NEXT:    vmov.i8 q3, #0xff
; CHECK-NEXT:    vldrh.u32 q2, [r0, #8]
; CHECK-NEXT:    vldrh.u32 q5, [r0]
; CHECK-NEXT:    vcmp.i32 eq, q2, zr
; CHECK-NEXT:    vmov.i8 q2, #0x0
; CHECK-NEXT:    vpsel q4, q3, q2
; CHECK-NEXT:    vcmp.i32 eq, q5, zr
; CHECK-NEXT:    vpsel q2, q3, q2
; CHECK-NEXT:    vmov r2, r3, d8
; CHECK-NEXT:    vmov r4, r5, d4
; CHECK-NEXT:    vmov r0, r1, d5
; CHECK-NEXT:    vmov.16 q2[0], r4
; CHECK-NEXT:    vmov.16 q2[1], r5
; CHECK-NEXT:    vmov r12, lr, d9
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov.16 q2[3], r1
; CHECK-NEXT:    vmov.16 q2[4], r2
; CHECK-NEXT:    vmov.16 q2[5], r3
; CHECK-NEXT:    vmov.16 q2[6], r12
; CHECK-NEXT:    vmov.16 q2[7], lr
; CHECK-NEXT:    vpt.i16 ne, q2, zr
; CHECK-NEXT:    vmlavt.u16 r0, q0, q1
; CHECK-NEXT:    add sp, #16
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    pop {r4, r5, r7, pc}
entry:
  %aa = zext <8 x i16> %a to <8 x i32>
  %bb = zext <8 x i16> %b to <8 x i32>
  %c1 = icmp eq <8 x i32> %aa, zeroinitializer
  %c2 = icmp eq <8 x i32> %bb, zeroinitializer
  %c = and <8 x i1> %c1, %c2
  %xx = zext <8 x i16> %x to <8 x i32>
  %yy = zext <8 x i16> %y to <8 x i32>
  %m = mul <8 x i32> %xx, %yy
  %s = select <8 x i1> %c, <8 x i32> %m, <8 x i32> zeroinitializer
  %z = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %s)
  ret i32 %z
}

define void @correlate(ptr nocapture noundef readonly %ID, ptr nocapture noundef writeonly %ACD, i16 noundef signext %DS, i16 noundef signext %Ls, i16 noundef signext %S) {
; CHECK-LABEL: correlate:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; CHECK-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; CHECK-NEXT:    .pad #12
; CHECK-NEXT:    sub sp, #12
; CHECK-NEXT:    cmp r3, #1
; CHECK-NEXT:    strd r0, r1, [sp, #4] @ 8-byte Folded Spill
; CHECK-NEXT:    blt .LBB4_12
; CHECK-NEXT:  @ %bb.1: @ %for.body.lr.ph
; CHECK-NEXT:    ldr r7, [sp, #48]
; CHECK-NEXT:    mov r0, r3
; CHECK-NEXT:    ldr.w r10, [sp, #4] @ 4-byte Reload
; CHECK-NEXT:    adds r3, r2, #3
; CHECK-NEXT:    mov.w r11, #0
; CHECK-NEXT:    mov r9, r2
; CHECK-NEXT:    uxth.w r12, r7
; CHECK-NEXT:    adr r7, .LCPI4_0
; CHECK-NEXT:    vldrw.u32 q0, [r7]
; CHECK-NEXT:    str r2, [sp] @ 4-byte Spill
; CHECK-NEXT:    b .LBB4_4
; CHECK-NEXT:  .LBB4_2: @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:  .LBB4_3: @ %for.end
; CHECK-NEXT:    @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    ldr r7, [sp, #8] @ 4-byte Reload
; CHECK-NEXT:    lsrs r1, r6, #16
; CHECK-NEXT:    subs r3, #1
; CHECK-NEXT:    add.w r10, r10, #2
; CHECK-NEXT:    sub.w r9, r9, #1
; CHECK-NEXT:    strh.w r1, [r7, r11, lsl #1]
; CHECK-NEXT:    add.w r11, r11, #1
; CHECK-NEXT:    cmp r11, r0
; CHECK-NEXT:    beq .LBB4_12
; CHECK-NEXT:  .LBB4_4: @ %for.body
; CHECK-NEXT:    @ =>This Loop Header: Depth=1
; CHECK-NEXT:    @ Child Loop BB4_8 Depth 2
; CHECK-NEXT:    @ Child Loop BB4_11 Depth 2
; CHECK-NEXT:    cmp r2, r11
; CHECK-NEXT:    ble .LBB4_2
; CHECK-NEXT:  @ %bb.5: @ %vector.main.loop.iter.check
; CHECK-NEXT:    @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    sub.w r8, r2, r11
; CHECK-NEXT:    cmp.w r8, #8
; CHECK-NEXT:    bhs .LBB4_7
; CHECK-NEXT:  @ %bb.6: @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    movs r7, #0
; CHECK-NEXT:    b .LBB4_10
; CHECK-NEXT:  .LBB4_7: @ %vector.ph
; CHECK-NEXT:    @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    bic r7, r8, #7
; CHECK-NEXT:    movs r1, #1
; CHECK-NEXT:    sub.w r6, r7, #8
; CHECK-NEXT:    mov r5, r10
; CHECK-NEXT:    add.w lr, r1, r6, lsr #3
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    ldr r4, [sp, #4] @ 4-byte Reload
; CHECK-NEXT:  .LBB4_8: @ %vector.body
; CHECK-NEXT:    @ Parent Loop BB4_4 Depth=1
; CHECK-NEXT:    @ => This Inner Loop Header: Depth=2
; CHECK-NEXT:    vldrh.u16 q1, [r4], #16
; CHECK-NEXT:    vldrh.u16 q2, [r5], #16
; CHECK-NEXT:    rsb.w r1, r12, #0
; CHECK-NEXT:    vmullb.s16 q3, q2, q1
; CHECK-NEXT:    vmullt.s16 q1, q2, q1
; CHECK-NEXT:    vshl.s32 q3, r1
; CHECK-NEXT:    vshl.s32 q1, r1
; CHECK-NEXT:    vaddva.u32 r6, q3
; CHECK-NEXT:    vaddva.u32 r6, q1
; CHECK-NEXT:    le lr, .LBB4_8
; CHECK-NEXT:  @ %bb.9: @ %middle.block
; CHECK-NEXT:    @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    cmp r8, r7
; CHECK-NEXT:    beq .LBB4_3
; CHECK-NEXT:  .LBB4_10: @ %vec.epilog.ph
; CHECK-NEXT:    @ in Loop: Header=BB4_4 Depth=1
; CHECK-NEXT:    ldr r1, [sp, #4] @ 4-byte Reload
; CHECK-NEXT:    add.w r5, r7, r11
; CHECK-NEXT:    bic lr, r3, #3
; CHECK-NEXT:    mov r2, r0
; CHECK-NEXT:    add.w r4, r1, r7, lsl #1
; CHECK-NEXT:    add.w r5, r1, r5, lsl #1
; CHECK-NEXT:    sub.w r1, lr, r7
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    subs r1, #4
; CHECK-NEXT:    add.w lr, r0, r1, lsr #2
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    ldr r2, [sp] @ 4-byte Reload
; CHECK-NEXT:  .LBB4_11: @ %vec.epilog.vector.body
; CHECK-NEXT:    @ Parent Loop BB4_4 Depth=1
; CHECK-NEXT:    @ => This Inner Loop Header: Depth=2
; CHECK-NEXT:    vqadd.u32 q1, q0, r7
; CHECK-NEXT:    vdup.32 q2, r8
; CHECK-NEXT:    rsb.w r1, r12, #0
; CHECK-NEXT:    vptt.u32 hi, q2, q1
; CHECK-NEXT:    vldrht.s32 q1, [r4], #8
; CHECK-NEXT:    vldrht.s32 q2, [r5], #8
; CHECK-NEXT:    adds r7, #4
; CHECK-NEXT:    vmul.i32 q1, q2, q1
; CHECK-NEXT:    vshl.s32 q1, r1
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vaddvat.u32 r6, q1
; CHECK-NEXT:    le lr, .LBB4_11
; CHECK-NEXT:    b .LBB4_3
; CHECK-NEXT:  .LBB4_12: @ %for.end17
; CHECK-NEXT:    add sp, #12
; CHECK-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.13:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
entry:
  %conv = sext i16 %Ls to i32
  %cmp31 = icmp sgt i16 %Ls, 0
  br i1 %cmp31, label %for.body.lr.ph, label %for.end17

for.body.lr.ph:                                   ; preds = %entry
  %conv2 = sext i16 %DS to i32
  %conv1027 = zext i16 %S to i32
  %broadcast.splatinsert = insertelement <8 x i32> poison, i32 %conv1027, i64 0
  %broadcast.splat = shufflevector <8 x i32> %broadcast.splatinsert, <8 x i32> poison, <8 x i32> zeroinitializer
  %broadcast.splatinsert40 = insertelement <4 x i32> poison, i32 %conv1027, i64 0
  %broadcast.splat41 = shufflevector <4 x i32> %broadcast.splatinsert40, <4 x i32> poison, <4 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.end
  %lag.032 = phi i32 [ 0, %for.body.lr.ph ], [ %inc16, %for.end ]
  %0 = sub i32 %conv2, %lag.032
  %cmp428 = icmp slt i32 %lag.032, %conv2
  br i1 %cmp428, label %vector.main.loop.iter.check, label %for.end

vector.main.loop.iter.check:                      ; preds = %for.body
  %min.iters.check = icmp ult i32 %0, 8
  br i1 %min.iters.check, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %0, -8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ 0, %vector.ph ], [ %9, %vector.body ]
  %1 = getelementptr inbounds i16, ptr %ID, i32 %index
  %wide.load = load <8 x i16>, ptr %1, align 2
  %2 = sext <8 x i16> %wide.load to <8 x i32>
  %3 = add nuw nsw i32 %index, %lag.032
  %4 = getelementptr inbounds i16, ptr %ID, i32 %3
  %wide.load34 = load <8 x i16>, ptr %4, align 2
  %5 = sext <8 x i16> %wide.load34 to <8 x i32>
  %6 = mul nsw <8 x i32> %5, %2
  %7 = ashr <8 x i32> %6, %broadcast.splat
  %8 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %7)
  %9 = add i32 %8, %vec.phi
  %index.next = add nuw i32 %index, 8
  %10 = icmp eq i32 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %0, %n.vec
  br i1 %cmp.n, label %for.end, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %middle.block, %vector.main.loop.iter.check
  %bc.merge.rdx = phi i32 [ 0, %vector.main.loop.iter.check ], [ %9, %middle.block ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %middle.block ]
  %n.rnd.up = add i32 %0, 3
  %n.vec36 = and i32 %n.rnd.up, -4
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index37 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next42, %vec.epilog.vector.body ]
  %vec.phi38 = phi i32 [ %bc.merge.rdx, %vec.epilog.ph ], [ %20, %vec.epilog.vector.body ]
  %active.lane.mask = tail call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index37, i32 %0)
  %11 = getelementptr inbounds i16, ptr %ID, i32 %index37
  %wide.masked.load = tail call <4 x i16> @llvm.masked.load.v4i16.p0(ptr %11, i32 2, <4 x i1> %active.lane.mask, <4 x i16> poison)
  %12 = sext <4 x i16> %wide.masked.load to <4 x i32>
  %13 = add nuw nsw i32 %index37, %lag.032
  %14 = getelementptr inbounds i16, ptr %ID, i32 %13
  %wide.masked.load39 = tail call <4 x i16> @llvm.masked.load.v4i16.p0(ptr %14, i32 2, <4 x i1> %active.lane.mask, <4 x i16> poison)
  %15 = sext <4 x i16> %wide.masked.load39 to <4 x i32>
  %16 = mul nsw <4 x i32> %15, %12
  %17 = ashr <4 x i32> %16, %broadcast.splat41
  %18 = select <4 x i1> %active.lane.mask, <4 x i32> %17, <4 x i32> zeroinitializer
  %19 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %18)
  %20 = add i32 %19, %vec.phi38
  %index.next42 = add i32 %index37, 4
  %21 = icmp eq i32 %index.next42, %n.vec36
  br i1 %21, label %for.end, label %vec.epilog.vector.body

for.end:                                          ; preds = %vec.epilog.vector.body, %middle.block, %for.body
  %Accumulator.0.lcssa = phi i32 [ 0, %for.body ], [ %9, %middle.block ], [ %20, %vec.epilog.vector.body ]
  %22 = lshr i32 %Accumulator.0.lcssa, 16
  %conv13 = trunc i32 %22 to i16
  %arrayidx14 = getelementptr inbounds i16, ptr %ACD, i32 %lag.032
  store i16 %conv13, ptr %arrayidx14, align 2
  %inc16 = add nuw nsw i32 %lag.032, 1
  %exitcond33.not = icmp eq i32 %inc16, %conv
  br i1 %exitcond33.not, label %for.end17, label %for.body

for.end17:                                        ; preds = %for.end, %entry
  ret void
}

declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %sh)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %sh)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <4 x i16> @llvm.masked.load.v4i16.p0(ptr nocapture, i32 immarg, <4 x i1>, <4 x i16>)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
