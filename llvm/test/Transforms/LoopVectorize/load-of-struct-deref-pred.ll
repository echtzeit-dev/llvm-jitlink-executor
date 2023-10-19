; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=loop-vectorize -force-vector-width=4 -force-vector-interleave=1 -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

%struct.Foo = type { [32000 x i32], [32000 x i32] }

@foo = global %struct.Foo zeroinitializer, align 4

define void @accesses_to_struct_dereferenceable(ptr noalias %dst) {
; CHECK-LABEL: define void @accesses_to_struct_dereferenceable
; CHECK-SAME: (ptr noalias [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <4 x i32> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr [[STRUCT_FOO:%.*]], ptr @foo, i64 0, i32 1, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i32, ptr [[TMP4]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <4 x i32>, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x i32>, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = xor <4 x i1> [[TMP3]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[TMP8]], <4 x i32> [[WIDE_LOAD1]], <4 x i32> [[WIDE_LOAD2]]
; CHECK-NEXT:    store <4 x i32> [[PREDPHI]], ptr [[TMP2]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i64 [[INDEX_NEXT]], 32000
; CHECK-NEXT:    br i1 [[TMP9]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 32000, 32000
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 32000, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    [[D:%.*]] = load i32, ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i32 [[D]], 0
; CHECK-NEXT:    br i1 [[CMP3]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[IV]]
; CHECK-NEXT:    [[L_A:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       if.else:
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[IV]]
; CHECK-NEXT:    [[L_B:%.*]] = load i32, ptr [[GEP_B]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[TMP_0:%.*]] = phi i32 [ [[L_A]], [[IF_THEN]] ], [ [[L_B]], [[IF_ELSE]] ]
; CHECK-NEXT:    store i32 [[TMP_0]], ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 32000
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[LOOP_HEADER]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.dst = getelementptr inbounds i32, ptr %dst, i64 %iv
  %d = load i32, ptr %gep.dst, align 4
  %cmp3 = icmp ult i32 %d, 0
  br i1 %cmp3, label %if.then, label %if.else

if.then:
  %gep.a = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 0, i64 %iv
  %l.a = load i32, ptr %gep.a, align 4
  br label %loop.latch

if.else:
  %gep.b = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 1, i64 %iv
  %l.b = load i32, ptr %gep.b, align 4
  br label %loop.latch

loop.latch:
  %tmp.0 = phi i32 [ %l.a, %if.then ], [ %l.b, %if.else ]
  store i32 %tmp.0, ptr %gep.dst, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 32000
  br i1 %exitcond.not, label %exit, label %loop.header

exit:
  ret void
}

define void @accesses_to_struct_may_not_be_dereferenceable_due_to_loop_bound(ptr noalias %dst) {
; CHECK-LABEL: define void @accesses_to_struct_may_not_be_dereferenceable_due_to_loop_bound
; CHECK-SAME: (ptr noalias [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_LOAD_CONTINUE6:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <4 x i32> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = xor <4 x i1> [[TMP3]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i1> [[TMP4]], i32 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[PRED_LOAD_IF:%.*]], label [[PRED_LOAD_CONTINUE:%.*]]
; CHECK:       pred.load.if:
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_FOO:%.*]], ptr @foo, i64 0, i32 1, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x i32> poison, i32 [[TMP7]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE]]
; CHECK:       pred.load.continue:
; CHECK-NEXT:    [[TMP9:%.*]] = phi <4 x i32> [ poison, [[VECTOR_BODY]] ], [ [[TMP8]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i1> [[TMP4]], i32 1
; CHECK-NEXT:    br i1 [[TMP10]], label [[PRED_LOAD_IF1:%.*]], label [[PRED_LOAD_CONTINUE2:%.*]]
; CHECK:       pred.load.if1:
; CHECK-NEXT:    [[TMP11:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[TMP12]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = insertelement <4 x i32> [[TMP9]], i32 [[TMP13]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE2]]
; CHECK:       pred.load.continue2:
; CHECK-NEXT:    [[TMP15:%.*]] = phi <4 x i32> [ [[TMP9]], [[PRED_LOAD_CONTINUE]] ], [ [[TMP14]], [[PRED_LOAD_IF1]] ]
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x i1> [[TMP4]], i32 2
; CHECK-NEXT:    br i1 [[TMP16]], label [[PRED_LOAD_IF3:%.*]], label [[PRED_LOAD_CONTINUE4:%.*]]
; CHECK:       pred.load.if3:
; CHECK-NEXT:    [[TMP17:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = load i32, ptr [[TMP18]], align 4
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i32> [[TMP15]], i32 [[TMP19]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE4]]
; CHECK:       pred.load.continue4:
; CHECK-NEXT:    [[TMP21:%.*]] = phi <4 x i32> [ [[TMP15]], [[PRED_LOAD_CONTINUE2]] ], [ [[TMP20]], [[PRED_LOAD_IF3]] ]
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <4 x i1> [[TMP4]], i32 3
; CHECK-NEXT:    br i1 [[TMP22]], label [[PRED_LOAD_IF5:%.*]], label [[PRED_LOAD_CONTINUE6]]
; CHECK:       pred.load.if5:
; CHECK-NEXT:    [[TMP23:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = load i32, ptr [[TMP24]], align 4
; CHECK-NEXT:    [[TMP26:%.*]] = insertelement <4 x i32> [[TMP21]], i32 [[TMP25]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE6]]
; CHECK:       pred.load.continue6:
; CHECK-NEXT:    [[TMP27:%.*]] = phi <4 x i32> [ [[TMP21]], [[PRED_LOAD_CONTINUE4]] ], [ [[TMP26]], [[PRED_LOAD_IF5]] ]
; CHECK-NEXT:    [[TMP28:%.*]] = getelementptr [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr i32, ptr [[TMP28]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD7:%.*]] = load <4 x i32>, ptr [[TMP29]], align 4
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[TMP4]], <4 x i32> [[TMP27]], <4 x i32> [[WIDE_LOAD7]]
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    store <4 x i32> [[PREDPHI]], ptr [[TMP30]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP31:%.*]] = icmp eq i64 [[INDEX_NEXT]], 32000
; CHECK-NEXT:    br i1 [[TMP31]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 32001, 32000
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 32000, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    [[D:%.*]] = load i32, ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i32 [[D]], 0
; CHECK-NEXT:    br i1 [[CMP3]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[IV]]
; CHECK-NEXT:    [[L_A:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       if.else:
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[IV]]
; CHECK-NEXT:    [[L_B:%.*]] = load i32, ptr [[GEP_B]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[TMP_0:%.*]] = phi i32 [ [[L_A]], [[IF_THEN]] ], [ [[L_B]], [[IF_ELSE]] ]
; CHECK-NEXT:    store i32 [[TMP_0]], ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 32001
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[LOOP_HEADER]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.dst = getelementptr inbounds i32, ptr %dst, i64 %iv
  %d = load i32, ptr %gep.dst, align 4
  %cmp3 = icmp ult i32 %d, 0
  br i1 %cmp3, label %if.then, label %if.else

if.then:
  %gep.a = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 0, i64 %iv
  %l.a = load i32, ptr %gep.a, align 4
  br label %loop.latch

if.else:
  %gep.b = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 1, i64 %iv
  %l.b = load i32, ptr %gep.b, align 4
  br label %loop.latch

loop.latch:
  %tmp.0 = phi i32 [ %l.a, %if.then ], [ %l.b, %if.else ]
  store i32 %tmp.0, ptr %gep.dst, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 32001
  br i1 %exitcond.not, label %exit, label %loop.header

exit:
  ret void
}

define void @accesses_to_struct_may_not_be_dereferenceable_access_size(ptr noalias %dst) {
; CHECK-LABEL: define void @accesses_to_struct_may_not_be_dereferenceable_access_size
; CHECK-SAME: (ptr noalias [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_LOAD_CONTINUE6:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <4 x i32> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = xor <4 x i1> [[TMP3]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i1> [[TMP4]], i32 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[PRED_LOAD_IF:%.*]], label [[PRED_LOAD_CONTINUE:%.*]]
; CHECK:       pred.load.if:
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_FOO:%.*]], ptr @foo, i64 0, i32 1, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP7:%.*]] = load i64, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x i64> poison, i64 [[TMP7]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE]]
; CHECK:       pred.load.continue:
; CHECK-NEXT:    [[TMP9:%.*]] = phi <4 x i64> [ poison, [[VECTOR_BODY]] ], [ [[TMP8]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i1> [[TMP4]], i32 1
; CHECK-NEXT:    br i1 [[TMP10]], label [[PRED_LOAD_IF1:%.*]], label [[PRED_LOAD_CONTINUE2:%.*]]
; CHECK:       pred.load.if1:
; CHECK-NEXT:    [[TMP11:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[TMP12]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = insertelement <4 x i64> [[TMP9]], i64 [[TMP13]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE2]]
; CHECK:       pred.load.continue2:
; CHECK-NEXT:    [[TMP15:%.*]] = phi <4 x i64> [ [[TMP9]], [[PRED_LOAD_CONTINUE]] ], [ [[TMP14]], [[PRED_LOAD_IF1]] ]
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x i1> [[TMP4]], i32 2
; CHECK-NEXT:    br i1 [[TMP16]], label [[PRED_LOAD_IF3:%.*]], label [[PRED_LOAD_CONTINUE4:%.*]]
; CHECK:       pred.load.if3:
; CHECK-NEXT:    [[TMP17:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = load i64, ptr [[TMP18]], align 4
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i64> [[TMP15]], i64 [[TMP19]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE4]]
; CHECK:       pred.load.continue4:
; CHECK-NEXT:    [[TMP21:%.*]] = phi <4 x i64> [ [[TMP15]], [[PRED_LOAD_CONTINUE2]] ], [ [[TMP20]], [[PRED_LOAD_IF3]] ]
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <4 x i1> [[TMP4]], i32 3
; CHECK-NEXT:    br i1 [[TMP22]], label [[PRED_LOAD_IF5:%.*]], label [[PRED_LOAD_CONTINUE6]]
; CHECK:       pred.load.if5:
; CHECK-NEXT:    [[TMP23:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = load i64, ptr [[TMP24]], align 4
; CHECK-NEXT:    [[TMP26:%.*]] = insertelement <4 x i64> [[TMP21]], i64 [[TMP25]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE6]]
; CHECK:       pred.load.continue6:
; CHECK-NEXT:    [[TMP27:%.*]] = phi <4 x i64> [ [[TMP21]], [[PRED_LOAD_CONTINUE4]] ], [ [[TMP26]], [[PRED_LOAD_IF5]] ]
; CHECK-NEXT:    [[TMP28:%.*]] = trunc <4 x i64> [[TMP27]] to <4 x i32>
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr i32, ptr [[TMP29]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD7:%.*]] = load <4 x i32>, ptr [[TMP30]], align 4
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[TMP4]], <4 x i32> [[TMP28]], <4 x i32> [[WIDE_LOAD7]]
; CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i32 0
; CHECK-NEXT:    store <4 x i32> [[PREDPHI]], ptr [[TMP31]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP32:%.*]] = icmp eq i64 [[INDEX_NEXT]], 32000
; CHECK-NEXT:    br i1 [[TMP32]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 32000, 32000
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 32000, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    [[D:%.*]] = load i32, ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i32 [[D]], 0
; CHECK-NEXT:    br i1 [[CMP3]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 0, i64 [[IV]]
; CHECK-NEXT:    [[L_A:%.*]] = load i32, ptr [[GEP_A]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       if.else:
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds [[STRUCT_FOO]], ptr @foo, i64 0, i32 1, i64 [[IV]]
; CHECK-NEXT:    [[L_B:%.*]] = load i64, ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[T:%.*]] = trunc i64 [[L_B]] to i32
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[TMP_0:%.*]] = phi i32 [ [[L_A]], [[IF_THEN]] ], [ [[T]], [[IF_ELSE]] ]
; CHECK-NEXT:    store i32 [[TMP_0]], ptr [[GEP_DST]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 32000
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[LOOP_HEADER]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.dst = getelementptr inbounds i32, ptr %dst, i64 %iv
  %d = load i32, ptr %gep.dst, align 4
  %cmp3 = icmp ult i32 %d, 0
  br i1 %cmp3, label %if.then, label %if.else

if.then:
  %gep.a = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 0, i64 %iv
  %l.a = load i32, ptr %gep.a, align 4
  br label %loop.latch

if.else:
  %gep.b = getelementptr inbounds %struct.Foo, ptr @foo, i64 0, i32 1, i64 %iv
  %l.b = load i64, ptr %gep.b, align 4
  %t = trunc i64 %l.b to i32
  br label %loop.latch

loop.latch:
  %tmp.0 = phi i32 [ %l.a, %if.then ], [ %t, %if.else ]
  store i32 %tmp.0, ptr %gep.dst, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 32000
  br i1 %exitcond.not, label %exit, label %loop.header

exit:
  ret void
}
