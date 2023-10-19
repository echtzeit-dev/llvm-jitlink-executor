; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=dse -enable-dse-partial-store-merging -S < %s | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-f128:128:128-n8:16:32:64"

define void @byte_by_byte_replacement(ptr %ptr) {
; CHECK-LABEL: @byte_by_byte_replacement(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 202050057, ptr [[PTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  ;; This store's value should be modified as it should be better to use one
  ;; larger store than several smaller ones.
  ;; store will turn into 0x0C0B0A09 == 202050057
  store i32 305419896, ptr %ptr  ; 0x12345678
  %bptr1 = getelementptr inbounds i8, ptr %ptr, i64 1
  %bptr2 = getelementptr inbounds i8, ptr %ptr, i64 2
  %bptr3 = getelementptr inbounds i8, ptr %ptr, i64 3

  ;; We should be able to merge these four stores with the i32 above
  ; value (and bytes) stored before  ; 0x12345678
  store i8 9, ptr %ptr              ;         09
  store i8 10, ptr %bptr1            ;       0A
  store i8 11, ptr %bptr2            ;     0B
  store i8 12, ptr %bptr3            ;   0C
  ;                                    0x0C0B0A09
  ret void
}

define void @word_replacement(ptr %ptr) {
; CHECK-LABEL: @word_replacement(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 8106482645252179720, ptr [[PTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  store i64 72623859790382856, ptr %ptr  ; 0x0102030405060708

  %wptr1 = getelementptr inbounds i16, ptr %ptr, i64 1
  %wptr3 = getelementptr inbounds i16, ptr %ptr, i64 3

  ;; We should be able to merge these two stores with the i64 one above
  ; value (not bytes) stored before  ; 0x0102030405060708
  store i16  4128, ptr %wptr1       ;           1020
  store i16 28800, ptr %wptr3       ;   7080
  ;                                    0x7080030410200708
  ret void
}


define void @differently_sized_replacements(ptr %ptr) {
; CHECK-LABEL: @differently_sized_replacements(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 578437695752307201, ptr [[PTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  store i64 579005069656919567, ptr %ptr  ; 0x08090a0b0c0d0e0f

  %bptr6 = getelementptr inbounds i8, ptr %ptr, i64 6
  %wptr2 = getelementptr inbounds i16, ptr %ptr, i64 2

  ;; We should be able to merge all these stores with the i64 one above
  ; value (not bytes) stored before  ; 0x08090a0b0c0d0e0f
  store i8         7, ptr  %bptr6    ;     07
  store i16     1541, ptr %wptr2    ;       0605
  store i32 67305985, ptr %ptr     ;           04030201
  ;                                    0x0807060504030201
  ret void
}


define void @multiple_replacements_to_same_byte(ptr %ptr) {
; CHECK-LABEL: @multiple_replacements_to_same_byte(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 579005069522043393, ptr [[PTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  store i64 579005069656919567, ptr %ptr  ; 0x08090a0b0c0d0e0f

  %bptr3 = getelementptr inbounds i8, ptr %ptr, i64 3
  %wptr1 = getelementptr inbounds i16, ptr %ptr, i64 1

  ;; We should be able to merge all these stores with the i64 one above
  ; value (not bytes) stored before  ; 0x08090a0b0c0d0e0f
  store i8         7, ptr  %bptr3    ;           07
  store i16     1541, ptr %wptr1    ;           0605
  store i32 67305985, ptr %ptr     ;           04030201
  ;                                    0x08090a0b04030201
  ret void
}

define void @merged_merges(ptr %ptr) {
; CHECK-LABEL: @merged_merges(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 579005069572506113, ptr [[PTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  store i64 579005069656919567, ptr %ptr  ; 0x08090a0b0c0d0e0f

  %bptr3 = getelementptr inbounds i8, ptr %ptr, i64 3
  %wptr1 = getelementptr inbounds i16, ptr %ptr, i64 1

  ;; We should be able to merge all these stores with the i64 one above
  ; value (not bytes) stored before  ; 0x08090a0b0c0d0e0f
  store i32 67305985, ptr %ptr     ;           04030201
  store i16     1541, ptr %wptr1    ;           0605
  store i8         7, ptr  %bptr3    ;           07
  ;                                    0x08090a0b07050201
  ret void
}

define signext i8 @shouldnt_merge_since_theres_a_full_overlap(ptr %ptr) {
; CHECK-LABEL: @shouldnt_merge_since_theres_a_full_overlap(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTRM1:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 -1
; CHECK-NEXT:    [[BPTR3:%.*]] = getelementptr inbounds i8, ptr [[PTR]], i64 3
; CHECK-NEXT:    store i32 1234, ptr [[BPTRM1]], align 1
; CHECK-NEXT:    store i64 5678, ptr [[BPTR3]], align 1
; CHECK-NEXT:    ret i8 0
;
entry:

  ; Also check that alias.scope metadata doesn't get dropped
  store i64 0, ptr %ptr, !alias.scope !32

  %bptrm1 = getelementptr inbounds i8, ptr %ptr, i64 -1
  %bptr3 = getelementptr inbounds i8, ptr %ptr, i64 3

  store i32 1234, ptr %bptrm1, align 1
  store i64 5678, ptr %bptr3, align 1

  ret i8 0
}

;; Test case from PR31777
%union.U = type { i64 }

define void @foo(ptr nocapture %u) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i64 42, ptr [[U:%.*]], align 8
; CHECK-NEXT:    ret void
;
entry:
  store i64 0, ptr %u, align 8, !dbg !22, !tbaa !26, !noalias !32, !nontemporal !29
  store i16 42, ptr %u, align 8
  ret void
}

; Don't crash by operating on stale data if we merge (kill) the last 2 stores.

define void @PR34074(ptr %x, ptr %y) {
; CHECK-LABEL: @PR34074(
; CHECK-NEXT:    store i64 42, ptr %y
; CHECK-NEXT:    store i32 4, ptr %x
; CHECK-NEXT:    ret void
;
  store i64 42, ptr %y          ; independent store
  store i32 0, ptr %x           ; big store of constant
  store i8 4, ptr %x           ; small store with mergeable constant
  ret void
}

; We can't eliminate the last store because P and Q may alias.

define void @PR36129(ptr %P, ptr %Q) {
; CHECK-LABEL: @PR36129(
; CHECK-NEXT:    store i32 1, ptr [[P:%.*]], align 4
; CHECK-NEXT:    store i32 2, ptr [[Q:%.*]], align 4
; CHECK-NEXT:    store i8 3, ptr [[P]], align 1
; CHECK-NEXT:    ret void
;
  store i32 1, ptr %P, align 4
  store i32 2, ptr %Q, align 4
  store i8 3, ptr %P, align 1
  ret void
}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 5.0.0 (trunk 306512)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "me.cpp", directory: "/compiler-explorer")
!2 = !{}
!7 = distinct !DISubprogram(name: "foo", linkageName: "foo(U*)", scope: !1, file: !1, line: 9, type: !8, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !20)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "U", file: !1, line: 4, size: 64, elements: !12, identifier: "typeinfo name for U")
!12 = !{!13, !17}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !11, file: !1, line: 5, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !15, line: 55, baseType: !16)
!15 = !DIFile(filename: "/usr/include/stdint.h", directory: "/compiler-explorer")
!16 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !11, file: !1, line: 6, baseType: !18, size: 16)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !15, line: 49, baseType: !19)
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !{!21}
!21 = !DILocalVariable(name: "u", arg: 1, scope: !7, file: !1, line: 9, type: !10)
!22 = !DILocation(line: 10, column: 8, scope: !7)

!26 = !{!27, !27, i64 0}
!27 = !{!"omnipotent char", !28, i64 0}
!28 = !{!"Simple C++ TBAA"}

!29 = !{i32 1}

; Domains and scopes which might alias
!30 = !{!30}
!31 = !{!31, !30}
!32 = !{!31}
