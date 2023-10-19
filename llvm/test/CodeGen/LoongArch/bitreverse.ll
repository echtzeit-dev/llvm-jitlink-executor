; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 --verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA64

declare i7 @llvm.bitreverse.i7(i7)
declare i8 @llvm.bitreverse.i8(i8)
declare i16 @llvm.bitreverse.i16(i16)
declare i24 @llvm.bitreverse.i24(i24)
declare i32 @llvm.bitreverse.i32(i32)
declare i48 @llvm.bitreverse.i48(i48)
declare i64 @llvm.bitreverse.i64(i64)
declare i77 @llvm.bitreverse.i77(i77)
declare i128 @llvm.bitreverse.i128(i128)

define i8 @test_bitreverse_i8(i8 %a) nounwind {
; LA32-LABEL: test_bitreverse_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.4b $a0, $a0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.4b $a0, $a0
; LA64-NEXT:    ret
  %tmp = call i8 @llvm.bitreverse.i8(i8 %a)
  ret i8 %tmp
}

define i16 @test_bitreverse_i16(i16 %a) nounwind {
; LA32-LABEL: test_bitreverse_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a0, $a0
; LA32-NEXT:    srli.w $a0, $a0, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a0, $a0
; LA64-NEXT:    srli.d $a0, $a0, 48
; LA64-NEXT:    ret
  %tmp = call i16 @llvm.bitreverse.i16(i16 %a)
  ret i16 %tmp
}

define i32 @test_bitreverse_i32(i32 %a) nounwind {
; LA32-LABEL: test_bitreverse_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a0, $a0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.w $a0, $a0
; LA64-NEXT:    ret
  %tmp = call i32 @llvm.bitreverse.i32(i32 %a)
  ret i32 %tmp
}

define i64 @test_bitreverse_i64(i64 %a) nounwind {
; LA32-LABEL: test_bitreverse_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a2, $a1
; LA32-NEXT:    bitrev.w $a1, $a0
; LA32-NEXT:    move $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a0, $a0
; LA64-NEXT:    ret
  %tmp = call i64 @llvm.bitreverse.i64(i64 %a)
  ret i64 %tmp
}

;; Bitreverse on non-native integer widths.

define i7 @test_bitreverse_i7(i7 %a) nounwind {
; LA32-LABEL: test_bitreverse_i7:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a0, $a0
; LA32-NEXT:    srli.w $a0, $a0, 25
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i7:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a0, $a0
; LA64-NEXT:    srli.d $a0, $a0, 57
; LA64-NEXT:    ret
  %tmp = call i7 @llvm.bitreverse.i7(i7 %a)
  ret i7 %tmp
}

define i24 @test_bitreverse_i24(i24 %a) nounwind {
; LA32-LABEL: test_bitreverse_i24:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a0, $a0
; LA32-NEXT:    srli.w $a0, $a0, 8
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i24:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a0, $a0
; LA64-NEXT:    srli.d $a0, $a0, 40
; LA64-NEXT:    ret
  %tmp = call i24 @llvm.bitreverse.i24(i24 %a)
  ret i24 %tmp
}

define i48 @test_bitreverse_i48(i48 %a) nounwind {
; LA32-LABEL: test_bitreverse_i48:
; LA32:       # %bb.0:
; LA32-NEXT:    bitrev.w $a2, $a0
; LA32-NEXT:    bitrev.w $a0, $a1
; LA32-NEXT:    bytepick.w $a0, $a0, $a2, 2
; LA32-NEXT:    srli.w $a1, $a2, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i48:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a0, $a0
; LA64-NEXT:    srli.d $a0, $a0, 16
; LA64-NEXT:    ret
  %tmp = call i48 @llvm.bitreverse.i48(i48 %a)
  ret i48 %tmp
}

define i77 @test_bitreverse_i77(i77 %a) nounwind {
; LA32-LABEL: test_bitreverse_i77:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a2, $a1, 0
; LA32-NEXT:    bitrev.w $a2, $a2
; LA32-NEXT:    ld.w $a3, $a1, 4
; LA32-NEXT:    bitrev.w $a3, $a3
; LA32-NEXT:    srli.w $a4, $a3, 19
; LA32-NEXT:    slli.w $a5, $a2, 13
; LA32-NEXT:    or $a4, $a5, $a4
; LA32-NEXT:    srli.w $a2, $a2, 19
; LA32-NEXT:    st.h $a2, $a0, 8
; LA32-NEXT:    st.w $a4, $a0, 4
; LA32-NEXT:    slli.w $a2, $a3, 13
; LA32-NEXT:    ld.w $a1, $a1, 8
; LA32-NEXT:    bitrev.w $a1, $a1
; LA32-NEXT:    srli.w $a1, $a1, 19
; LA32-NEXT:    or $a1, $a1, $a2
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i77:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a1, $a1
; LA64-NEXT:    srli.d $a1, $a1, 51
; LA64-NEXT:    bitrev.d $a2, $a0
; LA64-NEXT:    slli.d $a0, $a2, 13
; LA64-NEXT:    or $a0, $a1, $a0
; LA64-NEXT:    srli.d $a1, $a2, 51
; LA64-NEXT:    ret
  %tmp = call i77 @llvm.bitreverse.i77(i77 %a)
  ret i77 %tmp
}

define i128 @test_bitreverse_i128(i128 %a) nounwind {
; LA32-LABEL: test_bitreverse_i128:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.w $a2, $a1, 0
; LA32-NEXT:    bitrev.w $a2, $a2
; LA32-NEXT:    st.w $a2, $a0, 12
; LA32-NEXT:    ld.w $a2, $a1, 4
; LA32-NEXT:    bitrev.w $a2, $a2
; LA32-NEXT:    st.w $a2, $a0, 8
; LA32-NEXT:    ld.w $a2, $a1, 8
; LA32-NEXT:    bitrev.w $a2, $a2
; LA32-NEXT:    st.w $a2, $a0, 4
; LA32-NEXT:    ld.w $a1, $a1, 12
; LA32-NEXT:    bitrev.w $a1, $a1
; LA32-NEXT:    st.w $a1, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_bitreverse_i128:
; LA64:       # %bb.0:
; LA64-NEXT:    bitrev.d $a2, $a1
; LA64-NEXT:    bitrev.d $a1, $a0
; LA64-NEXT:    move $a0, $a2
; LA64-NEXT:    ret
  %tmp = call i128 @llvm.bitreverse.i128(i128 %a)
  ret i128 %tmp
}
