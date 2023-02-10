; RUN: llc < %s -mtriple=ve | FileCheck %s

;;; Test atomic load for all types and all memory order
;;;
;;; Note:
;;;   We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
;;;   We test relaxed, acquire, and seq_cst.
;;;   We test an object, a stack object, and a global variable.

%"struct.std::__1::atomic" = type { %"struct.std::__1::__atomic_base" }
%"struct.std::__1::__atomic_base" = type { %"struct.std::__1::__cxx_atomic_impl" }
%"struct.std::__1::__cxx_atomic_impl" = type { %"struct.std::__1::__cxx_atomic_base_impl" }
%"struct.std::__1::__cxx_atomic_base_impl" = type { i8 }
%"struct.std::__1::atomic.0" = type { %"struct.std::__1::__atomic_base.1" }
%"struct.std::__1::__atomic_base.1" = type { %"struct.std::__1::__atomic_base.2" }
%"struct.std::__1::__atomic_base.2" = type { %"struct.std::__1::__cxx_atomic_impl.3" }
%"struct.std::__1::__cxx_atomic_impl.3" = type { %"struct.std::__1::__cxx_atomic_base_impl.4" }
%"struct.std::__1::__cxx_atomic_base_impl.4" = type { i8 }
%"struct.std::__1::atomic.5" = type { %"struct.std::__1::__atomic_base.6" }
%"struct.std::__1::__atomic_base.6" = type { %"struct.std::__1::__atomic_base.7" }
%"struct.std::__1::__atomic_base.7" = type { %"struct.std::__1::__cxx_atomic_impl.8" }
%"struct.std::__1::__cxx_atomic_impl.8" = type { %"struct.std::__1::__cxx_atomic_base_impl.9" }
%"struct.std::__1::__cxx_atomic_base_impl.9" = type { i8 }
%"struct.std::__1::atomic.10" = type { %"struct.std::__1::__atomic_base.11" }
%"struct.std::__1::__atomic_base.11" = type { %"struct.std::__1::__atomic_base.12" }
%"struct.std::__1::__atomic_base.12" = type { %"struct.std::__1::__cxx_atomic_impl.13" }
%"struct.std::__1::__cxx_atomic_impl.13" = type { %"struct.std::__1::__cxx_atomic_base_impl.14" }
%"struct.std::__1::__cxx_atomic_base_impl.14" = type { i16 }
%"struct.std::__1::atomic.15" = type { %"struct.std::__1::__atomic_base.16" }
%"struct.std::__1::__atomic_base.16" = type { %"struct.std::__1::__atomic_base.17" }
%"struct.std::__1::__atomic_base.17" = type { %"struct.std::__1::__cxx_atomic_impl.18" }
%"struct.std::__1::__cxx_atomic_impl.18" = type { %"struct.std::__1::__cxx_atomic_base_impl.19" }
%"struct.std::__1::__cxx_atomic_base_impl.19" = type { i16 }
%"struct.std::__1::atomic.20" = type { %"struct.std::__1::__atomic_base.21" }
%"struct.std::__1::__atomic_base.21" = type { %"struct.std::__1::__atomic_base.22" }
%"struct.std::__1::__atomic_base.22" = type { %"struct.std::__1::__cxx_atomic_impl.23" }
%"struct.std::__1::__cxx_atomic_impl.23" = type { %"struct.std::__1::__cxx_atomic_base_impl.24" }
%"struct.std::__1::__cxx_atomic_base_impl.24" = type { i32 }
%"struct.std::__1::atomic.25" = type { %"struct.std::__1::__atomic_base.26" }
%"struct.std::__1::__atomic_base.26" = type { %"struct.std::__1::__atomic_base.27" }
%"struct.std::__1::__atomic_base.27" = type { %"struct.std::__1::__cxx_atomic_impl.28" }
%"struct.std::__1::__cxx_atomic_impl.28" = type { %"struct.std::__1::__cxx_atomic_base_impl.29" }
%"struct.std::__1::__cxx_atomic_base_impl.29" = type { i32 }
%"struct.std::__1::atomic.30" = type { %"struct.std::__1::__atomic_base.31" }
%"struct.std::__1::__atomic_base.31" = type { %"struct.std::__1::__atomic_base.32" }
%"struct.std::__1::__atomic_base.32" = type { %"struct.std::__1::__cxx_atomic_impl.33" }
%"struct.std::__1::__cxx_atomic_impl.33" = type { %"struct.std::__1::__cxx_atomic_base_impl.34" }
%"struct.std::__1::__cxx_atomic_base_impl.34" = type { i64 }
%"struct.std::__1::atomic.35" = type { %"struct.std::__1::__atomic_base.36" }
%"struct.std::__1::__atomic_base.36" = type { %"struct.std::__1::__atomic_base.37" }
%"struct.std::__1::__atomic_base.37" = type { %"struct.std::__1::__cxx_atomic_impl.38" }
%"struct.std::__1::__cxx_atomic_impl.38" = type { %"struct.std::__1::__cxx_atomic_base_impl.39" }
%"struct.std::__1::__cxx_atomic_base_impl.39" = type { i64 }
%"struct.std::__1::atomic.40" = type { %"struct.std::__1::__atomic_base.41" }
%"struct.std::__1::__atomic_base.41" = type { %"struct.std::__1::__atomic_base.42" }
%"struct.std::__1::__atomic_base.42" = type { %"struct.std::__1::__cxx_atomic_impl.43" }
%"struct.std::__1::__cxx_atomic_impl.43" = type { %"struct.std::__1::__cxx_atomic_base_impl.44" }
%"struct.std::__1::__cxx_atomic_base_impl.44" = type { i128 }
%"struct.std::__1::atomic.45" = type { %"struct.std::__1::__atomic_base.46" }
%"struct.std::__1::__atomic_base.46" = type { %"struct.std::__1::__atomic_base.47" }
%"struct.std::__1::__atomic_base.47" = type { %"struct.std::__1::__cxx_atomic_impl.48" }
%"struct.std::__1::__cxx_atomic_impl.48" = type { %"struct.std::__1::__cxx_atomic_base_impl.49" }
%"struct.std::__1::__cxx_atomic_base_impl.49" = type { i128 }

@gv_i1 = global %"struct.std::__1::atomic" zeroinitializer, align 4
@gv_i8 = global %"struct.std::__1::atomic.0" zeroinitializer, align 4
@gv_u8 = global %"struct.std::__1::atomic.5" zeroinitializer, align 4
@gv_i16 = global %"struct.std::__1::atomic.10" zeroinitializer, align 4
@gv_u16 = global %"struct.std::__1::atomic.15" zeroinitializer, align 4
@gv_i32 = global %"struct.std::__1::atomic.20" zeroinitializer, align 4
@gv_u32 = global %"struct.std::__1::atomic.25" zeroinitializer, align 4
@gv_i64 = global %"struct.std::__1::atomic.30" zeroinitializer, align 8
@gv_u64 = global %"struct.std::__1::atomic.35" zeroinitializer, align 8
@gv_i128 = global %"struct.std::__1::atomic.40" zeroinitializer, align 16
@gv_u128 = global %"struct.std::__1::atomic.45" zeroinitializer, align 16

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i1 @_Z22atomic_load_relaxed_i1RNSt3__16atomicIbEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_relaxed_i1RNSt3__16atomicIbEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 monotonic, align 1
  %3 = and i8 %2, 1
  %4 = icmp ne i8 %3, 0
  ret i1 %4
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i8 @_Z22atomic_load_relaxed_i8RNSt3__16atomicIcEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_relaxed_i8RNSt3__16atomicIcEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 monotonic, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i8 @_Z22atomic_load_relaxed_u8RNSt3__16atomicIhEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_relaxed_u8RNSt3__16atomicIhEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 monotonic, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i16 @_Z23atomic_load_relaxed_i16RNSt3__16atomicIsEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_i16RNSt3__16atomicIsEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 monotonic, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i16 @_Z23atomic_load_relaxed_u16RNSt3__16atomicItEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_u16RNSt3__16atomicItEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 monotonic, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i32 @_Z23atomic_load_relaxed_i32RNSt3__16atomicIiEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_i32RNSt3__16atomicIiEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 monotonic, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i32 @_Z23atomic_load_relaxed_u32RNSt3__16atomicIjEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_u32RNSt3__16atomicIjEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 monotonic, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_relaxed_i64RNSt3__16atomicIlEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_i64RNSt3__16atomicIlEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 monotonic, align 8
  ret i64 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_relaxed_u64RNSt3__16atomicImEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_relaxed_u64RNSt3__16atomicImEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 monotonic, align 8
  ret i64 %2
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_relaxed_i128RNSt3__16atomicInEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_relaxed_i128RNSt3__16atomicInEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 0)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_relaxed_u128RNSt3__16atomicIoEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_relaxed_u128RNSt3__16atomicIoEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 0)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i1 @_Z22atomic_load_acquire_i1RNSt3__16atomicIbEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_acquire_i1RNSt3__16atomicIbEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 acquire, align 1
  %3 = and i8 %2, 1
  %4 = icmp ne i8 %3, 0
  ret i1 %4
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i8 @_Z22atomic_load_acquire_i8RNSt3__16atomicIcEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_acquire_i8RNSt3__16atomicIcEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 acquire, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i8 @_Z22atomic_load_acquire_u8RNSt3__16atomicIhEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_acquire_u8RNSt3__16atomicIhEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 acquire, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i16 @_Z23atomic_load_acquire_i16RNSt3__16atomicIsEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_i16RNSt3__16atomicIsEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 acquire, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i16 @_Z23atomic_load_acquire_u16RNSt3__16atomicItEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_u16RNSt3__16atomicItEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 acquire, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i32 @_Z23atomic_load_acquire_i32RNSt3__16atomicIiEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_i32RNSt3__16atomicIiEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 acquire, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i32 @_Z23atomic_load_acquire_u32RNSt3__16atomicIjEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_u32RNSt3__16atomicIjEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 acquire, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_acquire_i64RNSt3__16atomicIlEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_i64RNSt3__16atomicIlEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 acquire, align 8
  ret i64 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_acquire_u64RNSt3__16atomicImEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_acquire_u64RNSt3__16atomicImEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 acquire, align 8
  ret i64 %2
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_acquire_i128RNSt3__16atomicInEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_acquire_i128RNSt3__16atomicInEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 2)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_acquire_u128RNSt3__16atomicIoEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_acquire_u128RNSt3__16atomicIoEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 2)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i1 @_Z22atomic_load_seq_cst_i1RNSt3__16atomicIbEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_seq_cst_i1RNSt3__16atomicIbEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 seq_cst, align 1
  %3 = and i8 %2, 1
  %4 = icmp ne i8 %3, 0
  ret i1 %4
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i8 @_Z22atomic_load_seq_cst_i8RNSt3__16atomicIcEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_seq_cst_i8RNSt3__16atomicIcEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 seq_cst, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i8 @_Z22atomic_load_seq_cst_u8RNSt3__16atomicIhEE(ptr nocapture nonnull readonly align 1 dereferenceable(1) %0) {
; CHECK-LABEL: _Z22atomic_load_seq_cst_u8RNSt3__16atomicIhEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i8, ptr %0 seq_cst, align 1
  ret i8 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i16 @_Z23atomic_load_seq_cst_i16RNSt3__16atomicIsEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_i16RNSt3__16atomicIsEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 seq_cst, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i16 @_Z23atomic_load_seq_cst_u16RNSt3__16atomicItEE(ptr nocapture nonnull readonly align 2 dereferenceable(2) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_u16RNSt3__16atomicItEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i16, ptr %0 seq_cst, align 2
  ret i16 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i32 @_Z23atomic_load_seq_cst_i32RNSt3__16atomicIiEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_i32RNSt3__16atomicIiEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 seq_cst, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i32 @_Z23atomic_load_seq_cst_u32RNSt3__16atomicIjEE(ptr nocapture nonnull readonly align 4 dereferenceable(4) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_u32RNSt3__16atomicIjEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i32, ptr %0 seq_cst, align 4
  ret i32 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_seq_cst_i64RNSt3__16atomicIlEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_i64RNSt3__16atomicIlEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 seq_cst, align 8
  ret i64 %2
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z23atomic_load_seq_cst_u64RNSt3__16atomicImEE(ptr nocapture nonnull readonly align 8 dereferenceable(8) %0) {
; CHECK-LABEL: _Z23atomic_load_seq_cst_u64RNSt3__16atomicImEE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load atomic i64, ptr %0 seq_cst, align 8
  ret i64 %2
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_seq_cst_i128RNSt3__16atomicInEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_seq_cst_i128RNSt3__16atomicInEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 5)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z24atomic_load_seq_cst_u128RNSt3__16atomicIoEE(ptr nonnull align 16 dereferenceable(16) %0) {
; CHECK-LABEL: _Z24atomic_load_seq_cst_u128RNSt3__16atomicIoEE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @__atomic_load(i64 16, ptr nonnull %0, ptr nonnull %2, i32 signext 5)
  %3 = load i128, ptr %2, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

; Function Attrs: mustprogress
define zeroext i1 @_Z26atomic_load_relaxed_stk_i1v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_stk_i1v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z6fun_i1RNSt3__16atomicIbEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z6fun_i1RNSt3__16atomicIbEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld1b.zx %s0, 248(, %s11)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %1)
  call void @_Z6fun_i1RNSt3__16atomicIbEE(ptr nonnull align 1 dereferenceable(1) %1)
  %2 = load atomic i8, ptr %1 monotonic, align 1
  %3 = and i8 %2, 1
  %4 = icmp ne i8 %3, 0
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %1)
  ret i1 %4
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)

declare void @_Z6fun_i1RNSt3__16atomicIbEE(ptr nonnull align 1 dereferenceable(1))

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)

; Function Attrs: mustprogress
define signext i8 @_Z26atomic_load_relaxed_stk_i8v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_stk_i8v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z6fun_i8RNSt3__16atomicIcEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z6fun_i8RNSt3__16atomicIcEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld1b.sx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.0", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %1)
  call void @_Z6fun_i8RNSt3__16atomicIcEE(ptr nonnull align 1 dereferenceable(1) %1)
  %2 = load atomic i8, ptr %1 monotonic, align 1
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %1)
  ret i8 %2
}

declare void @_Z6fun_i8RNSt3__16atomicIcEE(ptr nonnull align 1 dereferenceable(1))

; Function Attrs: mustprogress
define zeroext i8 @_Z26atomic_load_relaxed_stk_u8v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_stk_u8v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z6fun_u8RNSt3__16atomicIhEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z6fun_u8RNSt3__16atomicIhEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld1b.zx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.5", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %1)
  call void @_Z6fun_u8RNSt3__16atomicIhEE(ptr nonnull align 1 dereferenceable(1) %1)
  %2 = load atomic i8, ptr %1 monotonic, align 1
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %1)
  ret i8 %2
}

declare void @_Z6fun_u8RNSt3__16atomicIhEE(ptr nonnull align 1 dereferenceable(1))

; Function Attrs: mustprogress
define signext i16 @_Z27atomic_load_relaxed_stk_i16v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_i16v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_i16RNSt3__16atomicIsEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_i16RNSt3__16atomicIsEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld2b.sx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.10", align 2
  call void @llvm.lifetime.start.p0(i64 2, ptr nonnull %1)
  call void @_Z7fun_i16RNSt3__16atomicIsEE(ptr nonnull align 2 dereferenceable(2) %1)
  %2 = load atomic i16, ptr %1 monotonic, align 2
  call void @llvm.lifetime.end.p0(i64 2, ptr nonnull %1)
  ret i16 %2
}

declare void @_Z7fun_i16RNSt3__16atomicIsEE(ptr nonnull align 2 dereferenceable(2))

; Function Attrs: mustprogress
define zeroext i16 @_Z27atomic_load_relaxed_stk_u16v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_u16v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_u16RNSt3__16atomicItEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_u16RNSt3__16atomicItEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld2b.zx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.15", align 2
  call void @llvm.lifetime.start.p0(i64 2, ptr nonnull %1)
  call void @_Z7fun_u16RNSt3__16atomicItEE(ptr nonnull align 2 dereferenceable(2) %1)
  %2 = load atomic i16, ptr %1 monotonic, align 2
  call void @llvm.lifetime.end.p0(i64 2, ptr nonnull %1)
  ret i16 %2
}

declare void @_Z7fun_u16RNSt3__16atomicItEE(ptr nonnull align 2 dereferenceable(2))

; Function Attrs: mustprogress
define signext i32 @_Z27atomic_load_relaxed_stk_i32v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_i32v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_i32RNSt3__16atomicIiEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_i32RNSt3__16atomicIiEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ldl.sx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.20", align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %1)
  call void @_Z7fun_i32RNSt3__16atomicIiEE(ptr nonnull align 4 dereferenceable(4) %1)
  %2 = load atomic i32, ptr %1 monotonic, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %1)
  ret i32 %2
}

declare void @_Z7fun_i32RNSt3__16atomicIiEE(ptr nonnull align 4 dereferenceable(4))

; Function Attrs: mustprogress
define zeroext i32 @_Z27atomic_load_relaxed_stk_u32v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_u32v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_u32RNSt3__16atomicIjEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_u32RNSt3__16atomicIjEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ldl.zx %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.25", align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %1)
  call void @_Z7fun_u32RNSt3__16atomicIjEE(ptr nonnull align 4 dereferenceable(4) %1)
  %2 = load atomic i32, ptr %1 monotonic, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %1)
  ret i32 %2
}

declare void @_Z7fun_u32RNSt3__16atomicIjEE(ptr nonnull align 4 dereferenceable(4))

; Function Attrs: mustprogress
define i64 @_Z27atomic_load_relaxed_stk_i64v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_i64v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_i64RNSt3__16atomicIlEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_i64RNSt3__16atomicIlEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.30", align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %1)
  call void @_Z7fun_i64RNSt3__16atomicIlEE(ptr nonnull align 8 dereferenceable(8) %1)
  %2 = load atomic i64, ptr %1 monotonic, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %1)
  ret i64 %2
}

declare void @_Z7fun_i64RNSt3__16atomicIlEE(ptr nonnull align 8 dereferenceable(8))

; Function Attrs: mustprogress
define i64 @_Z27atomic_load_relaxed_stk_u64v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_stk_u64v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z7fun_u64RNSt3__16atomicImEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z7fun_u64RNSt3__16atomicImEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 248(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s0, 248(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca %"struct.std::__1::atomic.35", align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %1)
  call void @_Z7fun_u64RNSt3__16atomicImEE(ptr nonnull align 8 dereferenceable(8) %1)
  %2 = load atomic i64, ptr %1 monotonic, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %1)
  ret i64 %2
}

declare void @_Z7fun_u64RNSt3__16atomicImEE(ptr nonnull align 8 dereferenceable(8))

; Function Attrs: mustprogress
define i128 @_Z28atomic_load_relaxed_stk_i128v() {
; CHECK-LABEL: _Z28atomic_load_relaxed_stk_i128v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z8fun_i128RNSt3__16atomicInEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z8fun_i128RNSt3__16atomicInEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 240(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s1, 240(, %s11)
; CHECK-NEXT:    lea %s2, 256(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 264(, %s11)
; CHECK-NEXT:    ld %s0, 256(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i128, align 16
  %2 = alloca %"struct.std::__1::atomic.40", align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @_Z8fun_i128RNSt3__16atomicInEE(ptr nonnull align 16 dereferenceable(16) %2)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1)
  call void @__atomic_load(i64 16, ptr nonnull %2, ptr nonnull %1, i32 signext 0)
  %3 = load i128, ptr %1, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

declare void @_Z8fun_i128RNSt3__16atomicInEE(ptr nonnull align 16 dereferenceable(16))

; Function Attrs: mustprogress
define i128 @_Z28atomic_load_relaxed_stk_u128v() {
; CHECK-LABEL: _Z28atomic_load_relaxed_stk_u128v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, _Z8fun_u128RNSt3__16atomicIoEE@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Z8fun_u128RNSt3__16atomicIoEE@hi(, %s0)
; CHECK-NEXT:    lea %s0, 240(, %s11)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s1, 240(, %s11)
; CHECK-NEXT:    lea %s2, 256(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 264(, %s11)
; CHECK-NEXT:    ld %s0, 256(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i128, align 16
  %2 = alloca %"struct.std::__1::atomic.45", align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2)
  call void @_Z8fun_u128RNSt3__16atomicIoEE(ptr nonnull align 16 dereferenceable(16) %2)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1)
  call void @__atomic_load(i64 16, ptr nonnull %2, ptr nonnull %1, i32 signext 0)
  %3 = load i128, ptr %1, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2)
  ret i128 %3
}

declare void @_Z8fun_u128RNSt3__16atomicIoEE(ptr nonnull align 16 dereferenceable(16))

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i1 @_Z25atomic_load_relaxed_gv_i1v() {
; CHECK-LABEL: _Z25atomic_load_relaxed_gv_i1v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_i1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_i1@hi(, %s0)
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i8, ptr @gv_i1 monotonic, align 4
  %2 = and i8 %1, 1
  %3 = icmp ne i8 %2, 0
  ret i1 %3
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i8 @_Z25atomic_load_relaxed_gv_i8v() {
; CHECK-LABEL: _Z25atomic_load_relaxed_gv_i8v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_i8@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_i8@hi(, %s0)
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i8, ptr @gv_i8 monotonic, align 4
  ret i8 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i8 @_Z25atomic_load_relaxed_gv_u8v() {
; CHECK-LABEL: _Z25atomic_load_relaxed_gv_u8v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_u8@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_u8@hi(, %s0)
; CHECK-NEXT:    ld1b.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i8, ptr @gv_u8 monotonic, align 4
  ret i8 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i16 @_Z26atomic_load_relaxed_gv_i16v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_i16v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_i16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_i16@hi(, %s0)
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i16, ptr @gv_i16 monotonic, align 4
  ret i16 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i16 @_Z26atomic_load_relaxed_gv_u16v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_u16v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_u16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_u16@hi(, %s0)
; CHECK-NEXT:    ld2b.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i16, ptr @gv_u16 monotonic, align 4
  ret i16 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define signext i32 @_Z26atomic_load_relaxed_gv_i32v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_i32v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_i32@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i32, ptr @gv_i32 monotonic, align 4
  ret i32 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define zeroext i32 @_Z26atomic_load_relaxed_gv_u32v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_u32v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_u32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_u32@hi(, %s0)
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i32, ptr @gv_u32 monotonic, align 4
  ret i32 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z26atomic_load_relaxed_gv_i64v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_i64v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_i64@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_i64@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i64, ptr @gv_i64 monotonic, align 8
  ret i64 %1
}

; Function Attrs: nofree norecurse nounwind mustprogress
define i64 @_Z26atomic_load_relaxed_gv_u64v() {
; CHECK-LABEL: _Z26atomic_load_relaxed_gv_u64v:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, gv_u64@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, gv_u64@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load atomic i64, ptr @gv_u64 monotonic, align 8
  ret i64 %1
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z27atomic_load_relaxed_gv_i128v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_gv_i128v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s0, gv_i128@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, gv_i128@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1)
  call void @__atomic_load(i64 16, ptr nonnull @gv_i128, ptr nonnull %1, i32 signext 0)
  %2 = load i128, ptr %1, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1)
  ret i128 %2
}

; Function Attrs: nofree nounwind mustprogress
define i128 @_Z27atomic_load_relaxed_gv_u128v() {
; CHECK-LABEL: _Z27atomic_load_relaxed_gv_u128v:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, __atomic_load@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load@hi(, %s0)
; CHECK-NEXT:    lea %s0, gv_u128@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, gv_u128@hi(, %s0)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    ld %s1, 248(, %s11)
; CHECK-NEXT:    ld %s0, 240(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1)
  call void @__atomic_load(i64 16, ptr nonnull @gv_u128, ptr nonnull %1, i32 signext 0)
  %2 = load i128, ptr %1, align 16, !tbaa !2
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1)
  ret i128 %2
}

; Function Attrs: nofree nounwind willreturn
declare void @__atomic_load(i64, ptr, ptr, i32)

!2 = !{!3, !3, i64 0}
!3 = !{!"__int128", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
