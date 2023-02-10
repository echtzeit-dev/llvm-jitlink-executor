; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -O0 -global-isel -stop-after=irtranslator -o - %s | FileCheck %s

%type = type [4 x {i8, i32}]

define ptr @translate_element_size1(i64 %arg) {
  ; CHECK-LABEL: name: translate_element_size1
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[C]], [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY [[PTR_ADD]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY1]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %tmp = getelementptr i8, ptr null, i64 %arg
  ret ptr %tmp
}

define ptr @first_offset_const(ptr %addr) {

  ; CHECK-LABEL: name: first_offset_const
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C]](s64)
  ; CHECK-NEXT:   $x0 = COPY [[PTR_ADD]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type, ptr %addr, i32 1
  ret ptr %res
}

define ptr @first_offset_trivial(ptr %addr) {

  ; CHECK-LABEL: name: first_offset_trivial
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY [[COPY]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY1]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type, ptr %addr, i32 0
  ret ptr %res
}

define ptr @first_offset_variable(ptr %addr, i64 %idx) {

  ; CHECK-LABEL: name: first_offset_variable
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[COPY1]], [[C]]
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY [[PTR_ADD]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY2]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type, ptr %addr, i64 %idx
  ret ptr %res
}

define ptr @first_offset_ext(ptr %addr, i32 %idx) {

  ; CHECK-LABEL: name: first_offset_ext
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $w1, $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK-NEXT:   [[SEXT:%[0-9]+]]:_(s64) = G_SEXT [[COPY1]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[SEXT]], [[C]]
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY [[PTR_ADD]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY2]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type, ptr %addr, i32 %idx
  ret ptr %res
}

%type1 = type [4 x [4 x i32]]
define ptr @const_then_var(ptr %addr, i64 %idx) {

  ; CHECK-LABEL: name: const_then_var
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 272
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[C]](s64)
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[COPY1]], [[C1]]
  ; CHECK-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[PTR_ADD]], [[MUL]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY [[PTR_ADD1]](p0)
  ; CHECK-NEXT:   $x0 = COPY [[COPY2]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type1, ptr %addr, i32 4, i32 1, i64 %idx
  ret ptr %res
}

define ptr @var_then_const(ptr %addr, i64 %idx) {

  ; CHECK-LABEL: name: var_then_const
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 64
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[COPY1]], [[C]]
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL]](s64)
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 40
  ; CHECK-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[PTR_ADD]], [[C1]](s64)
  ; CHECK-NEXT:   $x0 = COPY [[PTR_ADD1]](p0)
  ; CHECK-NEXT:   RET_ReallyLR implicit $x0
  %res = getelementptr %type1, ptr %addr, i64 %idx, i32 2, i32 2
  ret ptr %res
}

@arr = external global [8 x i32]

define <2 x ptr> @vec_gep_scalar_base(<2 x i64> %offs) {
  ; CHECK-LABEL: name: vec_gep_scalar_base
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $q0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $q0
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @arr
  ; CHECK-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p0>) = G_BUILD_VECTOR [[GV]](p0), [[GV]](p0)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C]](s64)
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[COPY]], [[BUILD_VECTOR1]]
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(<2 x p0>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x p0>) = COPY [[PTR_ADD]](<2 x p0>)
  ; CHECK-NEXT:   $q0 = COPY [[COPY1]](<2 x p0>)
  ; CHECK-NEXT:   RET_ReallyLR implicit $q0
entry:
  %0 = getelementptr inbounds [8 x i32], ptr @arr, i64 0, <2 x i64> %offs
  ret <2 x ptr> %0
}
