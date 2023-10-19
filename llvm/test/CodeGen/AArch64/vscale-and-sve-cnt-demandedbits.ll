; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

; This tests that various ands, sexts, and zexts (and other operations)
; operating on vscale or the SVE count instructions can be eliminated
; (via demanded bits) due to their known limited range.

; On AArch64 vscale can be at most 16 (for a 2048-bit vector).
; The counting instructions (sans multiplier) have a value of at most 256
; (for a 2048-bit vector of i8s).

define i32 @vscale_and_elimination() vscale_range(1,16) {
; CHECK-LABEL: vscale_and_elimination:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    and w9, w8, #0x1f
; CHECK-NEXT:    and w8, w8, #0xfffffffc
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale.i32()
  %and_redundant = and i32 %vscale, 31
  %and_required = and i32 %vscale, 17179869180
  %result = add i32 %and_redundant, %and_required
  ret i32 %result
}

define i64 @cntb_and_elimination() {
; CHECK-LABEL: cntb_and_elimination:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntb x8
; CHECK-NEXT:    and x9, x8, #0x1fc
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %cntb = call i64 @llvm.aarch64.sve.cntb(i32 31)
  %and_redundant = and i64 %cntb, 511
  %and_required = and i64 %cntb, 17179869180
  %result = add i64 %and_redundant, %and_required
  ret i64 %result
}

define i64 @cnth_and_elimination() {
; CHECK-LABEL: cnth_and_elimination:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    and x9, x8, #0xfc
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %cnth = call i64 @llvm.aarch64.sve.cnth(i32 31)
  %and_redundant = and i64 %cnth, 1023
  %and_required = and i64 %cnth, 17179869180
  %result = add i64 %and_redundant, %and_required
  ret i64 %result
}

define i64 @cntw_and_elimination() {
; CHECK-LABEL: cntw_and_elimination:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntw x8
; CHECK-NEXT:    and x9, x8, #0x7c
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %cntw = call i64 @llvm.aarch64.sve.cntw(i32 31)
  %and_redundant = and i64 %cntw, 127
  %and_required = and i64 %cntw, 17179869180
  %result = add i64 %and_redundant, %and_required
  ret i64 %result
}

define i64 @cntd_and_elimination() {
; CHECK-LABEL: cntd_and_elimination:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntd x8
; CHECK-NEXT:    and x9, x8, #0x3c
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %cntd = call i64 @llvm.aarch64.sve.cntd(i32 31)
  %and_redundant = and i64 %cntd, 63
  %and_required = and i64 %cntd, 17179869180
  %result = add i64 %and_redundant, %and_required
  ret i64 %result
}

define i64 @vscale_trunc_zext() vscale_range(1,16) {
; CHECK-LABEL: vscale_trunc_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    and x0, x8, #0xffffffff
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale.i32()
  %zext = zext i32 %vscale to i64
  ret i64 %zext
}

define i64 @vscale_trunc_sext() vscale_range(1,16) {
; CHECK-LABEL: vscale_trunc_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    sxtw x0, w8
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale.i32()
  %sext = sext i32 %vscale to i64
  ret i64 %sext
}

define i64 @count_bytes_trunc_zext() {
; CHECK-LABEL: count_bytes_trunc_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntb x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntb(i32 31)
  %trunc = trunc i64 %cnt to i32
  %zext = zext i32 %trunc to i64
  ret i64 %zext
}

define i64 @count_halfs_trunc_zext() {
; CHECK-LABEL: count_halfs_trunc_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cnth x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cnth(i32 31)
  %trunc = trunc i64 %cnt to i32
  %zext = zext i32 %trunc to i64
  ret i64 %zext
}

define i64 @count_words_trunc_zext() {
; CHECK-LABEL: count_words_trunc_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntw x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntw(i32 31)
  %trunc = trunc i64 %cnt to i32
  %zext = zext i32 %trunc to i64
  ret i64 %zext
}

define i64 @count_doubles_trunc_zext() {
; CHECK-LABEL: count_doubles_trunc_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntd x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntd(i32 31)
  %trunc = trunc i64 %cnt to i32
  %zext = zext i32 %trunc to i64
  ret i64 %zext
}

define i64 @count_bytes_trunc_sext() {
; CHECK-LABEL: count_bytes_trunc_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntb x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntb(i32 31)
  %trunc = trunc i64 %cnt to i32
  %sext = sext i32 %trunc to i64
  ret i64 %sext
}

define i64 @count_halfs_trunc_sext() {
; CHECK-LABEL: count_halfs_trunc_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cnth x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cnth(i32 31)
  %trunc = trunc i64 %cnt to i32
  %sext = sext i32 %trunc to i64
  ret i64 %sext
}

define i64 @count_words_trunc_sext() {
; CHECK-LABEL: count_words_trunc_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntw x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntw(i32 31)
  %trunc = trunc i64 %cnt to i32
  %sext = sext i32 %trunc to i64
  ret i64 %sext
}

define i64 @count_doubles_trunc_sext() {
; CHECK-LABEL: count_doubles_trunc_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntd x0
; CHECK-NEXT:    ret
  %cnt = call i64 @llvm.aarch64.sve.cntd(i32 31)
  %trunc = trunc i64 %cnt to i32
  %sext = sext i32 %trunc to i64
  ret i64 %sext
}

define i32 @vscale_with_multiplier() vscale_range(1,16) {
; CHECK-LABEL: vscale_with_multiplier:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov w9, #5
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    mul x8, x8, x9
; CHECK-NEXT:    and w9, w8, #0x7f
; CHECK-NEXT:    and w8, w8, #0x3f
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale.i32()
  %mul = mul i32 %vscale, 5
  %and_redundant = and i32 %mul, 127
  %and_required = and i32 %mul, 63
  %result = add i32 %and_redundant, %and_required
  ret i32 %result
}

define i32 @vscale_with_negative_multiplier() vscale_range(1,16) {
; CHECK-LABEL: vscale_with_negative_multiplier:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov x9, #-5
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    mul x8, x8, x9
; CHECK-NEXT:    orr w9, w8, #0xffffff80
; CHECK-NEXT:    and w8, w8, #0xffffffc0
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale.i32()
  %mul = mul i32 %vscale, -5
  %or_redundant = or i32 %mul, 4294967168
  %or_required = and i32 %mul, 4294967232
  %result = add i32 %or_redundant, %or_required
  ret i32 %result
}

declare i32 @llvm.vscale.i32()
declare i64 @llvm.aarch64.sve.cntb(i32 %pattern)
declare i64 @llvm.aarch64.sve.cnth(i32 %pattern)
declare i64 @llvm.aarch64.sve.cntw(i32 %pattern)
declare i64 @llvm.aarch64.sve.cntd(i32 %pattern)
