; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mcpu=sifive-u74 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=SFB64 %s
; RUN: llc -mtriple=riscv64 -mattr=+xventanacondops -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=VTCONDOPS64 %s
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zicond -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=ZICOND,ZICOND32 %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zicond -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=ZICOND,ZICOND64 %s

; InstCombine canonicalizes (c ? x | y : x) to (x | (c ? y : 0)) similar for
; other binary operations using their identity value as the constant.

; We can reverse this for and/or/xor. Allowing us to pull the binop into
; the basic block we create when we expand select.

define signext i32 @and_select_all_ones_i32(i1 zeroext %c, i32 signext %x, i32 signext %y) {
; RV32I-LABEL: and_select_all_ones_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and_select_all_ones_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    ret
;
; SFB64-LABEL: and_select_all_ones_i32:
; SFB64:       # %bb.0:
; SFB64-NEXT:    beqz a0, .LBB0_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    and a2, a2, a1
; SFB64-NEXT:  .LBB0_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: and_select_all_ones_i32:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    li a3, -1
; VTCONDOPS64-NEXT:    vt.maskcn a3, a3, a0
; VTCONDOPS64-NEXT:    vt.maskc a0, a1, a0
; VTCONDOPS64-NEXT:    or a0, a0, a3
; VTCONDOPS64-NEXT:    and a0, a0, a2
; VTCONDOPS64-NEXT:    ret
;
; ZICOND-LABEL: and_select_all_ones_i32:
; ZICOND:       # %bb.0:
; ZICOND-NEXT:    li a3, -1
; ZICOND-NEXT:    czero.nez a3, a3, a0
; ZICOND-NEXT:    czero.eqz a0, a1, a0
; ZICOND-NEXT:    or a0, a0, a3
; ZICOND-NEXT:    and a0, a0, a2
; ZICOND-NEXT:    ret
  %a = select i1 %c, i32 %x, i32 -1
  %b = and i32 %a, %y
  ret i32 %b
}

define i64 @and_select_all_ones_i64(i1 zeroext %c, i64 %x, i64 %y) {
; RV32I-LABEL: and_select_all_ones_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    or a2, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    and a0, a3, a0
; RV32I-NEXT:    and a1, a4, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and_select_all_ones_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    and a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: and_select_all_ones_i64:
; SFB64:       # %bb.0:
; SFB64-NEXT:    bnez a0, .LBB1_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    and a2, a2, a1
; SFB64-NEXT:  .LBB1_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: and_select_all_ones_i64:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskcn a1, a1, a0
; VTCONDOPS64-NEXT:    li a3, -1
; VTCONDOPS64-NEXT:    vt.maskc a0, a3, a0
; VTCONDOPS64-NEXT:    or a0, a0, a1
; VTCONDOPS64-NEXT:    and a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: and_select_all_ones_i64:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.nez a2, a2, a0
; ZICOND32-NEXT:    li a5, -1
; ZICOND32-NEXT:    czero.eqz a5, a5, a0
; ZICOND32-NEXT:    or a2, a5, a2
; ZICOND32-NEXT:    czero.nez a0, a1, a0
; ZICOND32-NEXT:    or a0, a5, a0
; ZICOND32-NEXT:    and a0, a3, a0
; ZICOND32-NEXT:    and a1, a4, a2
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: and_select_all_ones_i64:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.nez a1, a1, a0
; ZICOND64-NEXT:    li a3, -1
; ZICOND64-NEXT:    czero.eqz a0, a3, a0
; ZICOND64-NEXT:    or a0, a0, a1
; ZICOND64-NEXT:    and a0, a2, a0
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i64 -1, i64 %x
  %b = and i64 %y, %a
  ret i64 %b
}

define signext i32 @or_select_all_zeros_i32(i1 zeroext %c, i32 signext %x, i32 signext %y) {
; RV32I-LABEL: or_select_all_zeros_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: or_select_all_zeros_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    or a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: or_select_all_zeros_i32:
; SFB64:       # %bb.0:
; SFB64-NEXT:    beqz a0, .LBB2_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    or a2, a2, a1
; SFB64-NEXT:  .LBB2_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: or_select_all_zeros_i32:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskc a0, a1, a0
; VTCONDOPS64-NEXT:    or a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND-LABEL: or_select_all_zeros_i32:
; ZICOND:       # %bb.0:
; ZICOND-NEXT:    czero.eqz a0, a1, a0
; ZICOND-NEXT:    or a0, a2, a0
; ZICOND-NEXT:    ret
  %a = select i1 %c, i32 %x, i32 0
  %b = or i32 %y, %a
  ret i32 %b
}

define i64 @or_select_all_zeros_i64(i1 zeroext %c, i64 %x, i64 %y) {
; RV32I-LABEL: or_select_all_zeros_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a2, a0, a2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    or a0, a0, a3
; RV32I-NEXT:    or a1, a2, a4
; RV32I-NEXT:    ret
;
; RV64I-LABEL: or_select_all_zeros_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    or a0, a0, a2
; RV64I-NEXT:    ret
;
; SFB64-LABEL: or_select_all_zeros_i64:
; SFB64:       # %bb.0:
; SFB64-NEXT:    bnez a0, .LBB3_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    or a2, a2, a1
; SFB64-NEXT:  .LBB3_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: or_select_all_zeros_i64:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskcn a0, a1, a0
; VTCONDOPS64-NEXT:    or a0, a0, a2
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: or_select_all_zeros_i64:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.nez a2, a2, a0
; ZICOND32-NEXT:    czero.nez a0, a1, a0
; ZICOND32-NEXT:    or a0, a0, a3
; ZICOND32-NEXT:    or a1, a2, a4
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: or_select_all_zeros_i64:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.nez a0, a1, a0
; ZICOND64-NEXT:    or a0, a0, a2
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i64 0, i64 %x
  %b = or i64 %a, %y
  ret i64 %b
}

define signext i32 @xor_select_all_zeros_i32(i1 zeroext %c, i32 signext %x, i32 signext %y) {
; RV32I-LABEL: xor_select_all_zeros_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    xor a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: xor_select_all_zeros_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    xor a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: xor_select_all_zeros_i32:
; SFB64:       # %bb.0:
; SFB64-NEXT:    bnez a0, .LBB4_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    xor a2, a2, a1
; SFB64-NEXT:  .LBB4_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: xor_select_all_zeros_i32:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskcn a0, a1, a0
; VTCONDOPS64-NEXT:    xor a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND-LABEL: xor_select_all_zeros_i32:
; ZICOND:       # %bb.0:
; ZICOND-NEXT:    czero.nez a0, a1, a0
; ZICOND-NEXT:    xor a0, a2, a0
; ZICOND-NEXT:    ret
  %a = select i1 %c, i32 0, i32 %x
  %b = xor i32 %y, %a
  ret i32 %b
}

define i64 @xor_select_all_zeros_i64(i1 zeroext %c, i64 %x, i64 %y) {
; RV32I-LABEL: xor_select_all_zeros_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a2, a0, a2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    xor a0, a0, a3
; RV32I-NEXT:    xor a1, a2, a4
; RV32I-NEXT:    ret
;
; RV64I-LABEL: xor_select_all_zeros_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    xor a0, a0, a2
; RV64I-NEXT:    ret
;
; SFB64-LABEL: xor_select_all_zeros_i64:
; SFB64:       # %bb.0:
; SFB64-NEXT:    beqz a0, .LBB5_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    xor a2, a2, a1
; SFB64-NEXT:  .LBB5_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: xor_select_all_zeros_i64:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskc a0, a1, a0
; VTCONDOPS64-NEXT:    xor a0, a0, a2
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: xor_select_all_zeros_i64:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.eqz a2, a2, a0
; ZICOND32-NEXT:    czero.eqz a0, a1, a0
; ZICOND32-NEXT:    xor a0, a0, a3
; ZICOND32-NEXT:    xor a1, a2, a4
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: xor_select_all_zeros_i64:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.eqz a0, a1, a0
; ZICOND64-NEXT:    xor a0, a0, a2
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i64 %x, i64 0
  %b = xor i64 %a, %y
  ret i64 %b
}

define signext i32 @add_select_all_zeros_i32(i1 zeroext %c, i32 signext %x, i32 signext %y) {
; RV32I-LABEL: add_select_all_zeros_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_select_all_zeros_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addiw a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    addw a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: add_select_all_zeros_i32:
; SFB64:       # %bb.0:
; SFB64-NEXT:    bnez a0, .LBB6_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    addw a2, a2, a1
; SFB64-NEXT:  .LBB6_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: add_select_all_zeros_i32:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskcn a0, a1, a0
; VTCONDOPS64-NEXT:    addw a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: add_select_all_zeros_i32:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.nez a0, a1, a0
; ZICOND32-NEXT:    add a0, a2, a0
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: add_select_all_zeros_i32:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.nez a0, a1, a0
; ZICOND64-NEXT:    addw a0, a2, a0
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i32 0, i32 %x
  %b = add i32 %y, %a
  ret i32 %b
}

define i64 @add_select_all_zeros_i64(i1 zeroext %c, i64 %x, i64 %y) {
; RV32I-LABEL: add_select_all_zeros_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a2, a0, a2
; RV32I-NEXT:    and a1, a0, a1
; RV32I-NEXT:    add a0, a1, a3
; RV32I-NEXT:    sltu a1, a0, a1
; RV32I-NEXT:    add a2, a2, a4
; RV32I-NEXT:    add a1, a2, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_select_all_zeros_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a0, a2
; RV64I-NEXT:    ret
;
; SFB64-LABEL: add_select_all_zeros_i64:
; SFB64:       # %bb.0:
; SFB64-NEXT:    beqz a0, .LBB7_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    add a2, a2, a1
; SFB64-NEXT:  .LBB7_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: add_select_all_zeros_i64:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskc a0, a1, a0
; VTCONDOPS64-NEXT:    add a0, a0, a2
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: add_select_all_zeros_i64:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.eqz a2, a2, a0
; ZICOND32-NEXT:    czero.eqz a1, a1, a0
; ZICOND32-NEXT:    add a0, a1, a3
; ZICOND32-NEXT:    sltu a1, a0, a1
; ZICOND32-NEXT:    add a2, a2, a4
; ZICOND32-NEXT:    add a1, a2, a1
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: add_select_all_zeros_i64:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.eqz a0, a1, a0
; ZICOND64-NEXT:    add a0, a0, a2
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i64 %x, i64 0
  %b = add i64 %a, %y
  ret i64 %b
}

define signext i32 @sub_select_all_zeros_i32(i1 zeroext %c, i32 signext %x, i32 signext %y) {
; RV32I-LABEL: sub_select_all_zeros_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    sub a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sub_select_all_zeros_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addiw a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    subw a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: sub_select_all_zeros_i32:
; SFB64:       # %bb.0:
; SFB64-NEXT:    bnez a0, .LBB8_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    subw a2, a2, a1
; SFB64-NEXT:  .LBB8_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: sub_select_all_zeros_i32:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskcn a0, a1, a0
; VTCONDOPS64-NEXT:    subw a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: sub_select_all_zeros_i32:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.nez a0, a1, a0
; ZICOND32-NEXT:    sub a0, a2, a0
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: sub_select_all_zeros_i32:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.nez a0, a1, a0
; ZICOND64-NEXT:    subw a0, a2, a0
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i32 0, i32 %x
  %b = sub i32 %y, %a
  ret i32 %b
}

define i64 @sub_select_all_zeros_i64(i1 zeroext %c, i64 %x, i64 %y) {
; RV32I-LABEL: sub_select_all_zeros_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a2, a0, a2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    sltu a1, a3, a0
; RV32I-NEXT:    sub a4, a4, a2
; RV32I-NEXT:    sub a1, a4, a1
; RV32I-NEXT:    sub a0, a3, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sub_select_all_zeros_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    sub a0, a2, a0
; RV64I-NEXT:    ret
;
; SFB64-LABEL: sub_select_all_zeros_i64:
; SFB64:       # %bb.0:
; SFB64-NEXT:    beqz a0, .LBB9_2
; SFB64-NEXT:  # %bb.1:
; SFB64-NEXT:    sub a2, a2, a1
; SFB64-NEXT:  .LBB9_2:
; SFB64-NEXT:    mv a0, a2
; SFB64-NEXT:    ret
;
; VTCONDOPS64-LABEL: sub_select_all_zeros_i64:
; VTCONDOPS64:       # %bb.0:
; VTCONDOPS64-NEXT:    vt.maskc a0, a1, a0
; VTCONDOPS64-NEXT:    sub a0, a2, a0
; VTCONDOPS64-NEXT:    ret
;
; ZICOND32-LABEL: sub_select_all_zeros_i64:
; ZICOND32:       # %bb.0:
; ZICOND32-NEXT:    czero.eqz a2, a2, a0
; ZICOND32-NEXT:    czero.eqz a0, a1, a0
; ZICOND32-NEXT:    sltu a1, a3, a0
; ZICOND32-NEXT:    sub a4, a4, a2
; ZICOND32-NEXT:    sub a1, a4, a1
; ZICOND32-NEXT:    sub a0, a3, a0
; ZICOND32-NEXT:    ret
;
; ZICOND64-LABEL: sub_select_all_zeros_i64:
; ZICOND64:       # %bb.0:
; ZICOND64-NEXT:    czero.eqz a0, a1, a0
; ZICOND64-NEXT:    sub a0, a2, a0
; ZICOND64-NEXT:    ret
  %a = select i1 %c, i64 %x, i64 0
  %b = sub i64 %y, %a
  ret i64 %b
}
