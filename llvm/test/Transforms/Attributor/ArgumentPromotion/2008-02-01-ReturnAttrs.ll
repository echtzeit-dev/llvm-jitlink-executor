; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=11 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define internal i32 @deref(ptr %x) nounwind {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind willreturn memory(argmem: read)
; CGSCC-LABEL: define {{[^@]+}}@deref
; CGSCC-SAME: (i32 [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[X_PRIV:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 [[TMP0]], ptr [[X_PRIV]], align 4
; CGSCC-NEXT:    [[TMP2:%.*]] = load i32, ptr [[X_PRIV]], align 4
; CGSCC-NEXT:    ret i32 [[TMP2]]
;
entry:
  %tmp2 = load i32, ptr %x, align 4
  ret i32 %tmp2
}

define i32 @f(i32 %x) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@f
; TUNIT-SAME: (i32 returned [[X:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    store i32 [[X]], ptr [[X_ADDR]], align 4
; TUNIT-NEXT:    ret i32 [[X]]
;
; CGSCC: Function Attrs: nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@f
; CGSCC-SAME: (i32 [[X:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 [[X]], ptr [[X_ADDR]], align 4
; CGSCC-NEXT:    [[TMP1:%.*]] = call i32 @deref(i32 [[X]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[TMP1]]
;
entry:
  %x_addr = alloca i32
  store i32 %x, ptr %x_addr, align 4
  %tmp1 = call i32 @deref( ptr %x_addr ) nounwind
  ret i32 %tmp1
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind willreturn memory(argmem: read) }
; CGSCC: attributes #[[ATTR1]] = { nofree nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { nounwind willreturn }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
