; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-linux-gnu < %s \
; RUN:   2>&1 | FileCheck --check-prefix=CHECK-LE %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix-xcoff < %s \
; RUN:   2>&1 | FileCheck --check-prefix=CHECK-BE %s

%0 = type <{ i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, [8 x i8] }>
@global.1 = internal global %0 <{ i32 129, i32 2, i32 118, i32 0, i32 5, i32 0, i32 0, i32 0, i32 120, i32 0, ptr @global.2, [8 x i8] c"\00\00\00\00\00\00\00\03" }>, align 4
@global.2 = internal constant [3 x i8] c"x.c"
@alias = dso_local alias i32 (), ptr @main

define dso_local signext i32 @main() nounwind {
; CHECK-LE-LABEL: main:
; CHECK-LE:       # %bb.0: # %bb
; CHECK-LE-NEXT:    mflr 0
; CHECK-LE-NEXT:    std 0, 16(1)
; CHECK-LE-NEXT:    lis 0, -1
; CHECK-LE-NEXT:    ori 0, 0, 65535
; CHECK-LE-NEXT:    sldi 0, 0, 32
; CHECK-LE-NEXT:    oris 0, 0, 32767
; CHECK-LE-NEXT:    ori 0, 0, 65120
; CHECK-LE-NEXT:    stdux 1, 1, 0
; CHECK-LE-NEXT:    lis 3, 0
; CHECK-LE-NEXT:    sldi 3, 3, 32
; CHECK-LE-NEXT:    oris 3, 3, 32768
; CHECK-LE-NEXT:    ori 3, 3, 400
; CHECK-LE-NEXT:    stdx 30, 1, 3 # 8-byte Folded Spill
; CHECK-LE-NEXT:    bl pluto
; CHECK-LE-NEXT:    nop
; CHECK-LE-NEXT:    addis 3, 2, global.1@toc@ha
; CHECK-LE-NEXT:    li 4, 0
; CHECK-LE-NEXT:    li 7, 0
; CHECK-LE-NEXT:    li 8, 0
; CHECK-LE-NEXT:    li 9, 0
; CHECK-LE-NEXT:    addi 5, 3, global.1@toc@l
; CHECK-LE-NEXT:    ori 6, 4, 32768
; CHECK-LE-NEXT:    li 3, 6
; CHECK-LE-NEXT:    li 4, 257
; CHECK-LE-NEXT:    bl snork
; CHECK-LE-NEXT:    nop
; CHECK-LE-NEXT:    mr 30, 3
; CHECK-LE-NEXT:    li 3, 344
; CHECK-LE-NEXT:    addi 4, 1, 48
; CHECK-LE-NEXT:    li 5, 8
; CHECK-LE-NEXT:    li 6, 8
; CHECK-LE-NEXT:    oris 3, 3, 32768
; CHECK-LE-NEXT:    add 4, 4, 3
; CHECK-LE-NEXT:    mr 3, 30
; CHECK-LE-NEXT:    bl zot
; CHECK-LE-NEXT:    nop
; CHECK-LE-NEXT:    mr 3, 30
; CHECK-LE-NEXT:    bl wibble
; CHECK-LE-NEXT:    nop
; CHECK-LE-NEXT:    li 3, 0
; CHECK-LE-NEXT:    bl snork.3
; CHECK-LE-NEXT:    nop
;
; CHECK-BE-LABEL: main:
; CHECK-BE:       # %bb.0: # %bb
; CHECK-BE-NEXT:    mflr 0
; CHECK-BE-NEXT:    std 0, 16(1)
; CHECK-BE-NEXT:    lis 0, -1
; CHECK-BE-NEXT:    ori 0, 0, 65535
; CHECK-BE-NEXT:    sldi 0, 0, 32
; CHECK-BE-NEXT:    oris 0, 0, 32767
; CHECK-BE-NEXT:    ori 0, 0, 65056
; CHECK-BE-NEXT:    stdux 1, 1, 0
; CHECK-BE-NEXT:    lis 3, 0
; CHECK-BE-NEXT:    sldi 3, 3, 32
; CHECK-BE-NEXT:    oris 3, 3, 32768
; CHECK-BE-NEXT:    ori 3, 3, 472
; CHECK-BE-NEXT:    stdx 31, 1, 3 # 8-byte Folded Spill
; CHECK-BE-NEXT:    bl .pluto[PR]
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    ld 5, L..C0(2) # @global.1
; CHECK-BE-NEXT:    li 3, 0
; CHECK-BE-NEXT:    ori 6, 3, 32768
; CHECK-BE-NEXT:    li 3, 6
; CHECK-BE-NEXT:    li 4, 257
; CHECK-BE-NEXT:    li 7, 0
; CHECK-BE-NEXT:    li 8, 0
; CHECK-BE-NEXT:    li 9, 0
; CHECK-BE-NEXT:    bl .snork[PR]
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    mr 31, 3
; CHECK-BE-NEXT:    li 3, 344
; CHECK-BE-NEXT:    oris 3, 3, 32768
; CHECK-BE-NEXT:    addi 4, 1, 120
; CHECK-BE-NEXT:    add 4, 4, 3
; CHECK-BE-NEXT:    mr 3, 31
; CHECK-BE-NEXT:    li 5, 8
; CHECK-BE-NEXT:    li 6, 8
; CHECK-BE-NEXT:    bl .zot[PR]
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    mr 3, 31
; CHECK-BE-NEXT:    bl .wibble[PR]
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    li 3, 0
; CHECK-BE-NEXT:    bl .snork.3[PR]
; CHECK-BE-NEXT:    nop
bb:
  %tmp = alloca [2147484000 x i8], align 8
  tail call void @pluto()
  %tmp6 = tail call i64 @snork(i64 6, i32 257, ptr nonnull @global.1, i64 32768, ptr null, i64 0, ptr null)
  %tmp7 = getelementptr inbounds [2147484000 x i8], ptr %tmp, i64 0, i64 2147483992
  %tmp9 = call i64 @zot(i64 %tmp6, ptr nonnull %tmp7, i64 8, i64 8)
  %tmp10 = call i64 @wibble(i64 %tmp6)
  call void @snork.3(i64 0)
  unreachable
}

declare void @pluto()

declare signext i64 @snork(i64, i32, ptr, i64, ptr, i64, ptr)

declare signext i64 @zot(i64, ptr, i64, i64)

declare signext i64 @wibble(i64)

declare void @snork.3(i64)
