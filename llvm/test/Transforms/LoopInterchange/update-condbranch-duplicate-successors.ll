; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-interchange -cache-line-size=64 -S %s | FileCheck %s


@global = external dso_local global [1000 x [1000 x i32]], align 16

; Test that we support updating conditional branches where both targets are the same
; in the predecessor of the outer loop header.

define void @foo(i1 %cmp) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CMP:%.*]], label [[INNER_HEADER_PREHEADER:%.*]], label [[INNER_HEADER_PREHEADER]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[OUTER_IV:%.*]] = phi i64 [ 0, [[BB1:%.*]] ], [ [[OUTER_IV_NEXT:%.*]], [[OUTER_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[INNER_HEADER_SPLIT1:%.*]]
; CHECK:       inner.header.preheader:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ [[TMP0:%.*]], [[INNER_HEADER_SPLIT:%.*]] ], [ 5, [[INNER_HEADER_PREHEADER]] ]
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       inner.header.split1:
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds [1000 x [1000 x i32]], ptr @global, i64 0, i64 [[INNER_IV]], i64 [[OUTER_IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[PTR]]
; CHECK-NEXT:    [[V:%.*]] = mul i32 [[LV]], 100
; CHECK-NEXT:    store i32 [[V]], ptr [[PTR]]
; CHECK-NEXT:    [[INNER_IV_NEXT:%.*]] = add nsw i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[COND1:%.*]] = icmp eq i64 [[INNER_IV_NEXT]], 1000
; CHECK-NEXT:    br label [[OUTER_LATCH]]
; CHECK:       inner.header.split:
; CHECK-NEXT:    [[TMP0]] = add nsw i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[TMP0]], 1000
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB9:%.*]], label [[INNER_HEADER]]
; CHECK:       outer.latch:
; CHECK-NEXT:    [[OUTER_IV_NEXT]] = add nuw nsw i64 [[OUTER_IV]], 1
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i64 [[OUTER_IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[COND2]], label [[INNER_HEADER_SPLIT]], label [[OUTER_HEADER]]
; CHECK:       bb9:
; CHECK-NEXT:    br label [[BB10:%.*]]
; CHECK:       bb10:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cmp, label %bb1, label %bb1

bb1:                                              ; preds = %entry, %entry
  br label %outer.header

outer.header:                                              ; preds = %outer.latch, %bb1
  %outer.iv = phi i64 [ 0, %bb1], [ %outer.iv.next, %outer.latch ]
  br label %inner.header

inner.header:                                              ; preds = %inner.header, %outer.header
  %inner.iv = phi i64 [ %inner.iv.next, %inner.header ], [ 5, %outer.header ]
  %ptr = getelementptr inbounds [1000 x [1000 x i32]], ptr @global, i64 0, i64 %inner.iv, i64 %outer.iv
  %lv = load i32, ptr %ptr
  %v = mul i32 %lv, 100
  store i32 %v, ptr %ptr
  %inner.iv.next = add nsw i64 %inner.iv, 1
  %cond1 = icmp eq i64 %inner.iv.next , 1000
  br i1 %cond1, label %outer.latch, label %inner.header

outer.latch:                                              ; preds = %inner.header
  %outer.iv.next = add nuw nsw i64 %outer.iv, 1
  %cond2 = icmp eq i64 %outer.iv.next, 1000
  br i1 %cond2, label %bb9, label %outer.header

bb9:                                              ; preds = %outer.latch
  br label %bb10

bb10:                                             ; preds = %bb9
  ret void
}


define void @foo1(i1 %cmp) {
; CHECK-LABEL: @foo1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CMP:%.*]], label [[BB1:%.*]], label [[BB1]]
; CHECK:       bb1:
; CHECK-NEXT:    br i1 [[CMP]], label [[INNER_HEADER_PREHEADER:%.*]], label [[INNER_HEADER_PREHEADER]]
; CHECK:       outer.header.preheader:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[OUTER_IV:%.*]] = phi i64 [ [[OUTER_IV_NEXT:%.*]], [[OUTER_LATCH:%.*]] ], [ 0, [[OUTER_HEADER_PREHEADER:%.*]] ]
; CHECK-NEXT:    br i1 [[CMP]], label [[INNER_HEADER_SPLIT1:%.*]], label [[INNER_HEADER_SPLIT1]]
; CHECK:       inner.header.preheader:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ [[TMP0:%.*]], [[INNER_HEADER_SPLIT:%.*]] ], [ 5, [[INNER_HEADER_PREHEADER]] ]
; CHECK-NEXT:    br label [[OUTER_HEADER_PREHEADER]]
; CHECK:       inner.header.split1:
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds [1000 x [1000 x i32]], ptr @global, i64 0, i64 [[INNER_IV]], i64 [[OUTER_IV]]
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[PTR]]
; CHECK-NEXT:    [[V:%.*]] = mul i32 [[LV]], 100
; CHECK-NEXT:    store i32 [[V]], ptr [[PTR]]
; CHECK-NEXT:    [[INNER_IV_NEXT:%.*]] = add nsw i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[COND1:%.*]] = icmp eq i64 [[INNER_IV_NEXT]], 1000
; CHECK-NEXT:    br label [[OUTER_LATCH]]
; CHECK:       inner.header.split:
; CHECK-NEXT:    [[TMP0]] = add nsw i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[TMP0]], 1000
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB9:%.*]], label [[INNER_HEADER]]
; CHECK:       outer.latch:
; CHECK-NEXT:    [[OUTER_IV_NEXT]] = add nuw nsw i64 [[OUTER_IV]], 1
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i64 [[OUTER_IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[COND2]], label [[INNER_HEADER_SPLIT]], label [[OUTER_HEADER]]
; CHECK:       bb9:
; CHECK-NEXT:    br label [[BB10:%.*]]
; CHECK:       bb10:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cmp, label %bb1, label %bb1

bb1:                                              ; preds = %entry, %entry
  br i1 %cmp, label %outer.header, label %outer.header

outer.header:                                              ; preds = %outer.latch, %bb1
  %outer.iv = phi i64 [ 0, %bb1 ], [ 0, %bb1 ], [ %outer.iv.next, %outer.latch ]
  br i1 %cmp, label %inner.header, label %inner.header

inner.header:                                              ; preds = %inner.header, %outer.header
  %inner.iv = phi i64 [ %inner.iv.next, %inner.header ], [ 5, %outer.header ], [ 5, %outer.header ]
  %ptr = getelementptr inbounds [1000 x [1000 x i32]], ptr @global, i64 0, i64 %inner.iv, i64 %outer.iv
  %lv = load i32, ptr %ptr
  %v = mul i32 %lv, 100
  store i32 %v, ptr %ptr
  %inner.iv.next = add nsw i64 %inner.iv, 1
  %cond1 = icmp eq i64 %inner.iv.next , 1000
  br i1 %cond1, label %outer.latch, label %inner.header

outer.latch:                                              ; preds = %inner.header
  %outer.iv.next = add nuw nsw i64 %outer.iv, 1
  %cond2 = icmp eq i64 %outer.iv.next, 1000
  br i1 %cond2, label %bb9, label %outer.header

bb9:                                              ; preds = %outer.latch
  br label %bb10

bb10:                                             ; preds = %bb9
  ret void
}
